use std::cell::RefCell;
use std::collections::{BTreeMap, HashSet};
use std::fmt;
use std::str::FromStr;
use std::sync::OnceLock;
use std::time::{Duration, Instant};
use z3::ast::Ast;
use z3::*;

use crate::instruction_parser::{self, Arrangement};

pub struct EmptiedOnClone(Solver);

impl EmptiedOnClone {
    pub fn new(solver: Solver) -> Self {
        EmptiedOnClone(solver)
    }
}

impl Clone for EmptiedOnClone {
    fn clone(&self) -> Self {
        EmptiedOnClone(Solver::new())
    }
}

impl std::ops::Deref for EmptiedOnClone {
    type Target = Solver;

    fn deref(&self) -> &Solver {
        &self.0
    }
}

const PATH_RESOURCE_LIMIT: u32 = 2_000_000;
pub const INDEXED_FACT_INCREMENTAL_UNITS: u32 = 2_000_000;
pub const INDEXED_FACT_FRESH_UNITS: u32 = 20_000_000;

pub fn refuted_for_indexed_fact(solver: &Solver, assumption: &ast::Bool) -> bool {
    refuted_within(
        solver,
        assumption,
        INDEXED_FACT_INCREMENTAL_UNITS,
        INDEXED_FACT_FRESH_UNITS,
    )
}
const ESCALATION: [(ArithmeticEngine, u32, Duration); 5] = [
    (ArithmeticEngine::Legacy, 5_000_000, Duration::from_secs(5)),
    (
        ArithmeticEngine::Default,
        20_000_000,
        Duration::from_secs(15),
    ),
    (
        ArithmeticEngine::Legacy,
        50_000_000,
        Duration::from_secs(30),
    ),
    (
        ArithmeticEngine::Default,
        200_000_000,
        Duration::from_secs(60),
    ),
    (
        ArithmeticEngine::Legacy,
        500_000_000,
        Duration::from_secs(120),
    ),
];
const UNLIMITED: u32 = 0;
const NO_TIMEOUT_MS: u32 = u32::MAX;
const LEGACY_ARITHMETIC_ENGINE: u32 = 2;
const DEFAULT_CHECK_TIMEOUT: Duration = Duration::from_secs(600);

#[derive(Clone, Copy)]
enum ArithmeticEngine {
    Default,
    Legacy,
}

impl ArithmeticEngine {
    fn solver(self) -> Solver {
        match self {
            ArithmeticEngine::Default => Solver::new(),
            ArithmeticEngine::Legacy => {
                let mut params = Params::new();
                params.set_u32("arith.solver", LEGACY_ARITHMETIC_ENGINE);
                Tactic::new("smt").with(&params).solver()
            }
        }
    }
}

fn check_timeout() -> Duration {
    static CONFIGURED: OnceLock<Duration> = OnceLock::new();
    *CONFIGURED.get_or_init(|| {
        std::env::var("BUMS_CHECK_TIMEOUT_SECS")
            .ok()
            .and_then(|seconds| seconds.trim().parse().ok())
            .map(Duration::from_secs)
            .unwrap_or(DEFAULT_CHECK_TIMEOUT)
    })
}

pub fn check(solver: &Solver, assumptions: &[ast::Bool]) -> SatResult {
    check_within(solver, assumptions, check_timeout())
}

const BRANCH_ESCALATION_LIMIT: u32 = 50_000_000;

pub fn check_branch(solver: &Solver, assumptions: &[ast::Bool]) -> SatResult {
    escalate(
        solver,
        assumptions,
        check_timeout(),
        BRANCH_ESCALATION_LIMIT,
        false,
    )
}

pub fn check_within(solver: &Solver, assumptions: &[ast::Bool], budget: Duration) -> SatResult {
    escalate(solver, assumptions, budget, u32::MAX, true)
}

fn escalate(
    solver: &Solver,
    assumptions: &[ast::Bool],
    budget: Duration,
    most_units: u32,
    unlimited_last: bool,
) -> SatResult {
    let deadline = Instant::now() + budget;
    let left = |cap: Duration| deadline.saturating_duration_since(Instant::now()).min(cap);
    let bounded = |solver: &Solver, units: u32, cap: Duration, run: &dyn Fn() -> SatResult| {
        let time = left(cap);
        if time.is_zero() {
            return SatResult::Unknown;
        }
        set_limits(solver, units, milliseconds(time));
        let decided = run();
        set_limits(solver, UNLIMITED, NO_TIMEOUT_MS);
        decided
    };
    let decided = bounded(solver, PATH_RESOURCE_LIMIT, budget, &|| {
        solver.check_assumptions(assumptions)
    });
    if decided != SatResult::Unknown {
        return decided;
    }
    let mut facts: Vec<ast::Bool> = solver
        .get_assertions()
        .into_iter()
        .chain(assumptions.iter().cloned())
        .collect();
    let identities = digit_identities_about(&facts);
    facts.extend(identities.iter().cloned());
    let assumptions: Vec<ast::Bool> = assumptions.iter().cloned().chain(identities).collect();
    let assumptions = assumptions.as_slice();
    for (engine, units, cap) in ESCALATION
        .into_iter()
        .filter(|(_, units, _)| *units <= most_units)
    {
        let fresh = engine.solver();
        for fact in &facts {
            fresh.assert(fact);
        }
        let decided = bounded(&fresh, units, cap, &|| fresh.check());
        if decided != SatResult::Unknown {
            return decided;
        }
    }
    if !unlimited_last {
        return SatResult::Unknown;
    }
    bounded(solver, UNLIMITED, budget, &|| {
        solver.check_assumptions(assumptions)
    })
}

pub fn refuted_within(
    solver: &Solver,
    assumption: &ast::Bool,
    incremental_units: u32,
    fresh_units: u32,
) -> bool {
    if refuted_incrementally_within(solver, assumption, incremental_units) {
        return true;
    }
    let fresh = ArithmeticEngine::Default.solver();
    for fact in solver.get_assertions() {
        fresh.assert(&fact);
    }
    fresh.assert(assumption);
    unsat_within(&fresh, fresh_units, &|| fresh.check())
}

pub fn refuted_incrementally_within(solver: &Solver, assumption: &ast::Bool, units: u32) -> bool {
    unsat_within(solver, units, &|| {
        solver.check_assumptions(std::slice::from_ref(assumption))
    })
}

fn unsat_within(solver: &Solver, units: u32, run: &dyn Fn() -> SatResult) -> bool {
    set_limits(solver, units, NO_TIMEOUT_MS);
    let decided = run();
    set_limits(solver, UNLIMITED, NO_TIMEOUT_MS);
    decided == SatResult::Unsat
}

fn milliseconds(time: Duration) -> u32 {
    u32::try_from(time.as_millis())
        .unwrap_or(NO_TIMEOUT_MS - 1)
        .clamp(1, NO_TIMEOUT_MS - 1)
}

fn set_limits(solver: &Solver, units: u32, timeout_ms: u32) {
    let mut params = Params::new();
    params.set_u32("rlimit", units);
    params.set_u32("timeout", timeout_ms);
    solver.set_params(&params);
}

#[derive(Debug, Clone, PartialEq)]
pub enum RegisterKind {
    RegisterBase,
    Number,
    Immediate,
}

#[derive(Debug, Clone, PartialEq)]
pub struct RegisterValue {
    pub kind: RegisterKind,
    pub base: Option<AbstractExpression>,
    pub offset: i64,
}

impl RegisterValue {
    pub fn new(kind: RegisterKind, base: Option<AbstractExpression>, offset: i64) -> Self {
        Self { kind, base, offset }
    }

    pub fn new_empty(name: &str) -> Self {
        Self {
            kind: RegisterKind::RegisterBase,
            base: Some(AbstractExpression::Abstract(name.to_string())),
            offset: 0,
        }
    }

    pub fn new_imm(num: i64) -> Self {
        Self {
            kind: RegisterKind::Immediate,
            base: None,
            offset: num,
        }
    }

    pub fn set(&mut self, kind: RegisterKind, base: Option<AbstractExpression>, offset: i64) {
        self.kind = kind;
        self.base = base;
        self.offset = offset;
    }

    pub fn expression(&self) -> AbstractExpression {
        match (&self.base, self.offset) {
            (None, _) if self.kind == RegisterKind::Number => fresh_unknown(),
            (Some(base), 0) => base.clone(),
            (Some(base), offset) => {
                generate_expression("+", base.clone(), AbstractExpression::Immediate(offset))
            }
            (None, offset) => AbstractExpression::Immediate(offset),
        }
    }
}

pub fn fresh_unknown() -> AbstractExpression {
    use std::sync::atomic::{AtomicUsize, Ordering};
    static NEXT: AtomicUsize = AtomicUsize::new(0);
    AbstractExpression::Abstract(format!(
        "unknown_value_{}",
        NEXT.fetch_add(1, Ordering::Relaxed)
    ))
}

#[derive(Debug, Clone, PartialEq)]
pub struct SimdRegister {
    pub kind: RegisterKind,
    pub base: [Option<AbstractExpression>; 16],
    pub offset: [u8; 16],
    pub lane_range: Option<(i64, i64)>,
}

pub const BASE_INIT: Option<AbstractExpression> = None;

impl Default for SimdRegister {
    fn default() -> Self {
        Self::new("")
    }
}

impl SimdRegister {
    pub fn new(_name: &str) -> Self {
        let bases = [BASE_INIT; 16];
        Self {
            kind: RegisterKind::Number,
            base: bases,
            offset: [0; 16],
            lane_range: None,
        }
    }

    pub fn get_byte(&self, index: usize) -> (Option<AbstractExpression>, u8) {
        assert!(index < 16);
        (self.base[index].clone(), self.offset[index])
    }
    pub fn get_halfword(&self, index: usize) -> ([Option<AbstractExpression>; 2], [u8; 2]) {
        assert!(index <= 8);
        let index = index * 2;
        let base: [Option<AbstractExpression>; 2] =
            [self.base[index].clone(), self.base[index + 1].clone()];
        let offset: [u8; 2] = [self.offset[index], self.offset[index + 1]];
        (base, offset)
    }

    pub fn get_word(&self, index: usize) -> ([Option<AbstractExpression>; 4], [u8; 4]) {
        assert!(index <= 4);
        let index = index * 4;
        let mut base: [Option<AbstractExpression>; 4] = Default::default();
        base.clone_from_slice(&self.base[index..(index + 4)]);
        let mut offset: [u8; 4] = Default::default();
        offset.clone_from_slice(&self.offset[index..(index + 4)]);
        (base, offset)
    }

    pub fn get_double(&self, index: usize) -> ([Option<AbstractExpression>; 8], [u8; 8]) {
        assert!(index <= 1);
        let index = index * 8;
        let mut base: [Option<AbstractExpression>; 8] = Default::default();
        base.clone_from_slice(&self.base[index..(index + 8)]);
        let mut offset: [u8; 8] = Default::default();
        offset.clone_from_slice(&self.offset[index..(index + 8)]);
        (base, offset)
    }

    pub fn set_byte(&mut self, index: usize, base: Option<AbstractExpression>, offset: u8) {
        assert!(index < 16);
        self.lane_range = None;
        self.base[index] = base;
        self.offset[index] = offset;
    }
    pub fn set_halfword(
        &mut self,
        index: usize,
        base: [Option<AbstractExpression>; 2],
        offset: [u8; 2],
    ) {
        assert!(index <= 8);
        self.lane_range = None;
        let index = index * 2;
        self.base[index..index + 2].clone_from_slice(&base);
        self.offset[index..index + 2].copy_from_slice(&offset);
    }

    pub fn set_word(
        &mut self,
        index: usize,
        base: [Option<AbstractExpression>; 4],
        offset: [u8; 4],
    ) {
        assert!(index < 4);
        self.lane_range = None;
        let index = index * 4;
        self.base[index..index + 4].clone_from_slice(&base);
        self.offset[index..index + 4].copy_from_slice(&offset);
    }

    pub fn set_double(
        &mut self,
        index: usize,
        base: [Option<AbstractExpression>; 8],
        offset: [u8; 8],
    ) {
        assert!(index < 2);
        self.lane_range = None;
        let index = index * 8;
        self.base[index..index + 8].clone_from_slice(&base);
        self.offset[index..index + 8].copy_from_slice(&offset);
    }

    pub fn get_lane(
        &self,
        arrangement: &Arrangement,
        index: usize,
    ) -> (Vec<Option<AbstractExpression>>, u128) {
        let width = arrangement.lane_bytes();
        let start = index * width;
        assert!(start + width <= 16, "lane {} out of range", index);

        let bases = self.base[start..start + width].to_vec();
        let mut value: u128 = 0;
        for byte in &self.offset[start..start + width] {
            value = (value << 8) | (*byte as u128);
        }
        (bases, value)
    }

    pub fn set_lane(
        &mut self,
        arrangement: &Arrangement,
        index: usize,
        bases: Vec<Option<AbstractExpression>>,
        value: u128,
    ) {
        let width = arrangement.lane_bytes();
        let start = index * width;
        assert!(start + width <= 16, "lane {} out of range", index);

        self.lane_range = None;

        for i in 0..width {
            self.base[start + i] = bases.get(i).cloned().flatten();
            self.offset[start + i] = (value >> (8 * (width - 1 - i))) as u8;
        }
    }

    pub fn set_unknown(&mut self) {
        self.kind = RegisterKind::Number;
        self.base = [BASE_INIT; 16];
        self.offset = [0; 16];
        self.lane_range = None;
    }

    pub fn set_from_register(
        &mut self,
        arrangement: Arrangement,
        index: usize,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: u128,
    ) {
        self.kind = kind;
        self.lane_range = None;
        let lane_bytes = arrangement.lane_bytes();
        let value = if lane_bytes >= 16 {
            offset
        } else {
            offset & ((1u128 << (8 * lane_bytes)) - 1)
        };
        let bases = vec![base; lane_bytes];

        if arrangement.lanes() == 1 {
            self.set_lane(&arrangement, index, bases, value);
            return;
        }

        self.base = [BASE_INIT; 16];
        self.offset = [0; 16];
        for lane in 0..arrangement.lanes() {
            self.set_lane(&arrangement, lane, bases.clone(), value);
        }
    }

    pub fn get_as_register(&self) -> RegisterValue {
        let mut offset_buf: [u8; 8] = Default::default();
        offset_buf.clone_from_slice(&self.offset[0..8]);
        let offset: i64 = i64::from_be_bytes(offset_buf);

        let base = generate_expression_from_options(
            ",",
            generate_expression_from_options(
                ",",
                generate_expression_from_options(
                    ",",
                    generate_expression_from_options(
                        ",",
                        self.base[0].clone(),
                        self.base[1].clone(),
                    ),
                    generate_expression_from_options(
                        ",",
                        self.base[2].clone(),
                        self.base[3].clone(),
                    ),
                ),
                generate_expression_from_options(
                    ",",
                    generate_expression_from_options(
                        ",",
                        self.base[4].clone(),
                        self.base[5].clone(),
                    ),
                    generate_expression_from_options(
                        ",",
                        self.base[6].clone(),
                        self.base[7].clone(),
                    ),
                ),
            ),
            generate_expression_from_options(
                ",",
                generate_expression_from_options(
                    ",",
                    generate_expression_from_options(
                        ",",
                        self.base[8].clone(),
                        self.base[9].clone(),
                    ),
                    generate_expression_from_options(
                        ",",
                        self.base[10].clone(),
                        self.base[11].clone(),
                    ),
                ),
                generate_expression_from_options(
                    ",",
                    generate_expression_from_options(
                        ",",
                        self.base[12].clone(),
                        self.base[13].clone(),
                    ),
                    generate_expression_from_options(
                        ",",
                        self.base[14].clone(),
                        self.base[15].clone(),
                    ),
                ),
            ),
        );

        RegisterValue {
            kind: self.kind.clone(),
            base,
            offset,
        }
    }
}

pub fn abstract_of(name: impl Into<String>) -> AbstractExpression {
    AbstractExpression::Abstract(name.into())
}

const MAX_CANCELLATION_NODES: usize = 256;

fn additive_terms(
    e: AbstractExpression,
    negated: bool,
    out: &mut Vec<(bool, AbstractExpression)>,
    flipped: &mut bool,
) {
    match e {
        AbstractExpression::Expression(ref op, a, b) if op == "+" => {
            additive_terms(*a, negated, out, flipped);
            additive_terms(*b, negated, out, flipped);
        }
        AbstractExpression::Expression(ref op, a, b) if op == "-" => {
            additive_terms(*a, negated, out, flipped);
            additive_terms(*b, !negated, out, flipped);
        }
        leaf => {
            let term = with_positive_factor(negated, leaf);
            *flipped |= term.0 != negated;
            out.push(term);
        }
    }
}

fn with_positive_factor(negated: bool, leaf: AbstractExpression) -> (bool, AbstractExpression) {
    if let AbstractExpression::Expression(ref op, ref a, ref b) = leaf
        && op == "*"
    {
        if let AbstractExpression::Immediate(k) = **b
            && k < 0
        {
            return (
                !negated,
                AbstractExpression::Expression(
                    "*".to_string(),
                    a.clone(),
                    Box::new(AbstractExpression::Immediate(-k)),
                ),
            );
        }
        if let AbstractExpression::Immediate(k) = **a
            && k < 0
        {
            return (
                !negated,
                AbstractExpression::Expression(
                    "*".to_string(),
                    Box::new(AbstractExpression::Immediate(-k)),
                    b.clone(),
                ),
            );
        }
    }
    (negated, leaf)
}

fn rebuild_sum(kept: Vec<(bool, AbstractExpression)>, constant: i64) -> AbstractExpression {
    let mut result: Option<AbstractExpression> = None;
    for (negated, term) in kept {
        result = Some(match result {
            None if negated => AbstractExpression::Expression(
                "-".to_string(),
                Box::new(AbstractExpression::Immediate(0)),
                Box::new(term),
            ),
            None => term,
            Some(acc) => AbstractExpression::Expression(
                if negated { "-" } else { "+" }.to_string(),
                Box::new(acc),
                Box::new(term),
            ),
        });
    }
    match (result, constant) {
        (None, c) => AbstractExpression::Immediate(c),
        (Some(e), 0) => e,
        (Some(e), c) => AbstractExpression::Expression(
            if c > 0 { "+" } else { "-" }.to_string(),
            Box::new(e),
            Box::new(AbstractExpression::Immediate(c.abs())),
        ),
    }
}

pub fn generate_expression(
    op: &str,
    a: AbstractExpression,
    b: AbstractExpression,
) -> AbstractExpression {
    if let AbstractExpression::Expression(inner, x, t) = &a {
        let undone = match (op, inner.as_str(), &b) {
            ("asr", "lsl", AbstractExpression::Immediate(k)) if (0..64).contains(k) => {
                **t == b && fits_signed(x, 64 - *k as u32)
            }
            ("-", "+", _) | ("+", "-", _) => **t == b,
            _ => false,
        };
        if undone {
            return (**x).clone();
        }
    }
    if op == "*"
        && let Some(folded) = with_constant_factor_outside(&a, &b)
    {
        return folded;
    }
    if op == "^"
        && let Some(cancelled) = xor_cancelled(&a, &b)
    {
        return cancelled;
    }
    if op == "%"
        && let AbstractExpression::Immediate(modulus) = b
        && modulus > 0
        && let Some(reduced) = without_multiples_of(&a, modulus)
    {
        return reduced;
    }
    if matches!(op, "lsr" | ">>")
        && let AbstractExpression::Immediate(shift) = b
        && (1..64).contains(&shift)
        && let Some(high) = high_fields_of_composition(&a, shift)
    {
        return high;
    }
    if op == "asr"
        && let AbstractExpression::Immediate(shift) = b
        && (1..64).contains(&shift)
        && let Some(high) = high_fields_of_composition(&a, shift)
    {
        return generate_expression("sext", high, AbstractExpression::Immediate(64 - shift));
    }
    if matches!(op, "+" | "-") && b == AbstractExpression::Immediate(0) {
        return a;
    }
    if op == "+" && a == AbstractExpression::Immediate(0) {
        return b;
    }
    if matches!(op, "+" | "-") && a.size() + b.size() <= MAX_CANCELLATION_NODES {
        let mut terms = Vec::new();
        let mut flipped = false;
        additive_terms(a.clone(), false, &mut terms, &mut flipped);
        additive_terms(b.clone(), op == "-", &mut terms, &mut flipped);

        let mut constant: i64 = 0;
        let mut immediates = 0;
        let mut kept: Vec<(bool, AbstractExpression)> = Vec::new();
        let mut cancelled = false;
        for (negated, term) in terms {
            if let AbstractExpression::Immediate(v) = term {
                immediates += 1;
                constant = if negated {
                    constant.saturating_sub(v)
                } else {
                    constant.saturating_add(v)
                };
                continue;
            }
            match kept.iter().position(|(n, k)| *n != negated && *k == term) {
                Some(pos) => {
                    kept.remove(pos);
                    cancelled = true;
                }
                None => kept.push((negated, term)),
            }
        }
        if let Some(collected) = like_terms_collected(&kept) {
            return rebuild_sum(collected, constant);
        }
        if cancelled || flipped || immediates > 1 {
            return rebuild_sum(kept, constant);
        }
    }
    AbstractExpression::Expression(op.to_string(), Box::new(a), Box::new(b))
}

fn multiplier_of(term: &AbstractExpression) -> Option<(&AbstractExpression, i64)> {
    match term {
        AbstractExpression::Expression(op, x, c) if op == "*" => match (x.as_ref(), c.as_ref()) {
            (_, AbstractExpression::Immediate(c)) => Some((x, *c)),
            (AbstractExpression::Immediate(k), _) => Some((c, *k)),
            _ => None,
        },
        _ => None,
    }
}

fn is_multiple_of(term: &AbstractExpression, modulus: i64) -> bool {
    match term {
        AbstractExpression::Immediate(c) => c % modulus == 0,
        _ => multiplier_of(term).is_some_and(|(_, c)| c % modulus == 0),
    }
}

fn like_terms_collected(
    kept: &[(bool, AbstractExpression)],
) -> Option<Vec<(bool, AbstractExpression)>> {
    let scaled = |term: &AbstractExpression| match multiplier_of(term) {
        Some((x, k)) if k > 0 && !matches!(x, AbstractExpression::Immediate(_)) => (x.clone(), k),
        _ => (term.clone(), 1),
    };
    let mut collected: Vec<(AbstractExpression, i64)> = Vec::new();
    let mut repeated = false;
    for (negated, term) in kept {
        let (base, k) = scaled(term);
        let k = if *negated { k.checked_neg()? } else { k };
        match collected.iter_mut().find(|(b, _)| *b == base) {
            Some(entry) => {
                entry.1 = entry.1.checked_add(k)?;
                repeated = true;
            }
            None => collected.push((base, k)),
        }
    }
    if collected.iter().any(|(_, k)| *k == i64::MIN) {
        return None;
    }
    repeated.then(|| {
        collected
            .into_iter()
            .filter(|(_, k)| *k != 0)
            .map(|(base, k)| {
                let term = if k.abs() == 1 {
                    base
                } else {
                    AbstractExpression::Expression(
                        "*".to_string(),
                        Box::new(base),
                        Box::new(AbstractExpression::Immediate(k.abs())),
                    )
                };
                (k < 0, term)
            })
            .collect()
    })
}

fn finer_residue_of(term: &AbstractExpression, modulus: i64) -> Option<AbstractExpression> {
    match term {
        AbstractExpression::Expression(op, x, m) if op == "%" => match m.as_ref() {
            AbstractExpression::Immediate(outer) if *outer > 0 && outer % modulus == 0 => {
                Some((**x).clone())
            }
            _ => None,
        },
        _ => match multiplier_of(term) {
            Some((residue, scale)) => finer_residue_of(residue, modulus)
                .map(|inner| generate_expression("*", inner, AbstractExpression::Immediate(scale))),
            None => None,
        },
    }
}

fn with_constant_factor_outside(
    a: &AbstractExpression,
    b: &AbstractExpression,
) -> Option<AbstractExpression> {
    match (a, b) {
        (AbstractExpression::Immediate(k), _) | (_, AbstractExpression::Immediate(k))
            if !matches!(
                (a, b),
                (
                    AbstractExpression::Immediate(_),
                    AbstractExpression::Immediate(_)
                )
            ) =>
        {
            let scaled = if matches!(a, AbstractExpression::Immediate(_)) {
                b
            } else {
                a
            };
            let (inner, c) = multiplier_of(scaled)?;
            Some(generate_expression(
                "*",
                inner.clone(),
                AbstractExpression::Immediate(c.checked_mul(*k)?),
            ))
        }
        _ => {
            let (inner, c) = multiplier_of(b).or_else(|| multiplier_of(a))?;
            let other = if multiplier_of(b).is_some() { a } else { b };
            Some(generate_expression(
                "*",
                generate_expression("*", other.clone(), inner.clone()),
                AbstractExpression::Immediate(c),
            ))
        }
    }
}

fn without_multiples_of(a: &AbstractExpression, modulus: i64) -> Option<AbstractExpression> {
    match a {
        AbstractExpression::Expression(op, x, m) if op == "%" => match m.as_ref() {
            AbstractExpression::Immediate(outer) if *outer > 0 && outer % modulus == 0 => Some(
                generate_expression("%", (**x).clone(), AbstractExpression::Immediate(modulus)),
            ),
            _ => None,
        },
        AbstractExpression::Expression(op, ..)
            if matches!(op.as_str(), "+" | "-") && a.size() <= MAX_CANCELLATION_NODES =>
        {
            let mut terms = Vec::new();
            let mut flipped = false;
            additive_terms(a.clone(), false, &mut terms, &mut flipped);
            let before = terms.len();
            terms.retain(|(_, term)| !is_multiple_of(term, modulus));
            let mut unwrapped = false;
            for (_, term) in terms.iter_mut() {
                if let Some(inner) = finer_residue_of(term, modulus) {
                    *term = inner;
                    unwrapped = true;
                }
            }
            if terms.len() == before && !unwrapped {
                return None;
            }
            let terms = like_terms_collected(&terms).unwrap_or(terms);
            if terms.is_empty() {
                return Some(AbstractExpression::Immediate(0));
            }
            let reduced = rebuild_sum(terms, 0);
            (reduced != *a)
                .then(|| generate_expression("%", reduced, AbstractExpression::Immediate(modulus)))
        }
        _ => None,
    }
}

fn residue_field(term: &AbstractExpression) -> Option<(AbstractExpression, i64, i64)> {
    let (residue, scale) = match multiplier_of(term) {
        Some((x, c)) => (x, c),
        None => (term, 1),
    };
    match residue {
        AbstractExpression::Expression(op, _, m) if op == "%" => match m.as_ref() {
            AbstractExpression::Immediate(m) if *m > 0 && scale > 0 => {
                Some((residue.clone(), *m, scale))
            }
            _ => None,
        },
        _ => None,
    }
}

fn high_fields_of_composition(a: &AbstractExpression, shift: i64) -> Option<AbstractExpression> {
    if !matches!(a, AbstractExpression::Expression(op, ..) if op == "+")
        || a.size() > MAX_CANCELLATION_NODES
    {
        return None;
    }
    let mut terms = Vec::new();
    let mut flipped = false;
    additive_terms(a.clone(), false, &mut terms, &mut flipped);
    let divisor = 1i64 << shift;
    let mut largest: u128 = 0;
    let mut largest_low: u128 = 0;
    let mut high = Vec::new();
    for (negated, term) in terms {
        if negated {
            return None;
        }
        let (residue, modulus, scale) = residue_field(&term)?;
        let most = (modulus as u128 - 1) * scale as u128;
        largest = largest.checked_add(most)?;
        if scale % divisor == 0 {
            let quotient = scale / divisor;
            high.push((
                false,
                if quotient == 1 {
                    residue
                } else {
                    AbstractExpression::Expression(
                        "*".to_string(),
                        Box::new(residue),
                        Box::new(AbstractExpression::Immediate(quotient)),
                    )
                },
            ));
        } else {
            largest_low += most;
        }
    }
    (largest < 1u128 << 64 && largest_low < divisor as u128).then(|| rebuild_sum(high, 0))
}

fn xor_cancelled(a: &AbstractExpression, b: &AbstractExpression) -> Option<AbstractExpression> {
    if a == b {
        return Some(AbstractExpression::Immediate(0));
    }
    if *b == AbstractExpression::Immediate(0) {
        return Some(a.clone());
    }
    if *a == AbstractExpression::Immediate(0) {
        return Some(b.clone());
    }
    let other_of = |pair: &AbstractExpression, single: &AbstractExpression| match pair {
        AbstractExpression::Expression(op, x, y) if op == "^" => {
            if **y == *single {
                Some((**x).clone())
            } else if **x == *single {
                Some((**y).clone())
            } else {
                None
            }
        }
        _ => None,
    };
    other_of(a, b).or_else(|| other_of(b, a))
}

pub fn generate_expression_from_options(
    op: &str,
    a: Option<AbstractExpression>,
    b: Option<AbstractExpression>,
) -> Option<AbstractExpression> {
    if a.is_some() || b.is_some() {
        Some(generate_expression(
            op,
            a.clone().unwrap_or(AbstractExpression::Immediate(0)),
            b.clone().unwrap_or(AbstractExpression::Immediate(0)),
        ))
    } else {
        None
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum AbstractExpression {
    Empty,
    Immediate(i64),
    Abstract(String),
    Register(Box<RegisterValue>),
    Expression(String, Box<AbstractExpression>, Box<AbstractExpression>),
}

fn binding_power(op: &str) -> u8 {
    match op {
        "|" => 1,
        "^" => 2,
        "&" => 3,
        "<<" | ">>" | "lsl" | "lsr" | "asr" => 4,
        "+" | "-" => 5,
        _ => 6,
    }
}

impl fmt::Display for AbstractExpression {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            AbstractExpression::Empty => write!(f, "Empty"),
            AbstractExpression::Immediate(value) => write!(f, "{}", value),
            AbstractExpression::Abstract(name) => write!(f, "{}", name),
            AbstractExpression::Register(reg) => {
                write!(f, "({:?})", reg)
            }
            AbstractExpression::Expression(op, left, right)
                if op == "+" && matches!(**right, AbstractExpression::Immediate(n) if n < 0) =>
            {
                let AbstractExpression::Immediate(n) = **right else {
                    unreachable!()
                };
                write!(f, "{} - {}", Parenthesized(left, 5, false), -n)
            }
            AbstractExpression::Expression(op, value, width) if op == "clz" => {
                write!(f, "clz{width}({value})")
            }
            AbstractExpression::Expression(op, left, right) => {
                let outer = binding_power(op);
                let tight = matches!(op.as_str(), "-" | "/" | "%" | "<<" | ">>");
                write!(f, "{}", Parenthesized(left, outer, false))?;
                write!(f, " {} ", op)?;
                write!(f, "{}", Parenthesized(right, outer, tight))
            }
        }
    }
}

struct Parenthesized<'a>(&'a AbstractExpression, u8, bool);

impl fmt::Display for Parenthesized<'_> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let Parenthesized(inner, outer, tight) = self;
        match inner {
            AbstractExpression::Expression(op, _, _)
                if binding_power(op) < *outer || (*tight && binding_power(op) == *outer) =>
            {
                write!(f, "({})", inner)
            }
            _ => write!(f, "{}", inner),
        }
    }
}

impl fmt::Display for AbstractComparison {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "({} {} {})", self.op, self.left, self.right)
    }
}

impl AbstractExpression {
    pub fn size(&self) -> usize {
        match self {
            AbstractExpression::Expression(_, left, right) => 1 + left.size() + right.size(),
            AbstractExpression::Register(reg) => match &reg.base {
                Some(base) => 1 + base.size(),
                None => 1,
            },
            _ => 1,
        }
    }

    pub fn get_abstracts(&self) -> Vec<String> {
        let mut abstracts = Vec::new();
        match self {
            AbstractExpression::Abstract(value) => {
                abstracts.push(value.to_string());
            }
            AbstractExpression::Register(reg) => {
                abstracts.append(
                    &mut reg
                        .base
                        .clone()
                        .unwrap_or(AbstractExpression::Empty)
                        .get_abstracts(),
                );
            }
            AbstractExpression::Expression(_, arg1, arg2) => {
                abstracts.append(&mut arg1.get_abstracts());
                abstracts.append(&mut arg2.get_abstracts());
            }
            AbstractExpression::Empty | AbstractExpression::Immediate(_) => (),
        }
        abstracts
    }

    pub fn contains(&self, token: &str) -> bool {
        match self {
            AbstractExpression::Abstract(value) => value.contains(token),
            AbstractExpression::Register(reg) => match &reg.base {
                Some(e) => e.contains(token),
                None => false,
            },
            AbstractExpression::Expression(_, arg1, arg2) => {
                arg1.contains(token) || arg2.contains(token)
            }
            _ => false,
        }
    }

    pub fn contains_expression(&self, expr: &AbstractExpression) -> bool {
        if self == expr {
            return true;
        }
        match self {
            AbstractExpression::Expression(_, arg1, arg2) => {
                arg1.contains_expression(expr) || arg2.contains_expression(expr)
            }
            _ => false,
        }
    }
}

pub fn generate_comparison(
    op: &str,
    a: AbstractExpression,
    b: AbstractExpression,
) -> AbstractComparison {
    AbstractComparison {
        op: op.to_string(),
        left: Box::new(a),
        right: Box::new(b),
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct AbstractComparison {
    pub op: String,
    pub left: Box<AbstractExpression>,
    pub right: Box<AbstractExpression>,
}

impl AbstractComparison {
    pub fn new(op: &str, left: AbstractExpression, right: AbstractExpression) -> Self {
        Self {
            op: op.to_string(),
            left: Box::new(left),
            right: Box::new(right),
        }
    }

    pub fn not(&self) -> Self {
        let left = *self.left.clone();
        let right = *self.right.clone();
        match self.op.as_str() {
            "<" => Self::new(">=", left, right),
            ">" => Self::new("<=", left, right),
            ">=" => Self::new("<", left, right),
            "<=" => Self::new(">", left, right),
            "==" => Self::new("!=", left, right),
            "!=" => Self::new("==", left, right),
            _ => todo!("unsupported op {:?}", self.op),
        }
    }

    pub fn reduce_solution(&self) -> (AbstractExpression, AbstractExpression) {
        todo!()
    }

    pub fn get_abstracts(&self) -> Vec<String> {
        let mut abstracts = Vec::new();
        abstracts.append(&mut self.left.get_abstracts());
        abstracts.append(&mut self.right.get_abstracts());
        abstracts
    }

    pub fn contains(&self, token: &str) -> bool {
        self.left.contains(token) || self.right.contains(token)
    }
}

pub fn is_narrowed(e: &AbstractExpression) -> bool {
    matches!(e, AbstractExpression::Expression(op, _, right)
        if op == "%" && **right == AbstractExpression::Immediate(1 << 32))
}

pub fn peel_narrowing(e: &AbstractExpression) -> AbstractExpression {
    match e {
        AbstractExpression::Expression(op, inner, _) if op == "%" && is_narrowed(e) => {
            (**inner).clone()
        }
        other => other.clone(),
    }
}

pub fn narrow_to_32(
    base: Option<AbstractExpression>,
    offset: i64,
) -> (Option<AbstractExpression>, i64) {
    const MODULUS: i64 = 1 << 32;
    match base {
        None => (None, offset.rem_euclid(MODULUS)),
        Some(b) => {
            if offset == 0 && is_narrowed(&b) {
                return (Some(b), 0);
            }
            let inner = match &b {
                AbstractExpression::Expression(op, x, m)
                    if op == "%" && **m == AbstractExpression::Immediate(MODULUS) =>
                {
                    (**x).clone()
                }
                _ => b,
            };
            let whole = if offset == 0 {
                inner
            } else {
                generate_expression("+", inner, AbstractExpression::Immediate(offset))
            };
            let narrowed = generate_expression("%", whole, AbstractExpression::Immediate(MODULUS));
            (Some(narrowed), 0)
        }
    }
}

pub fn access_width(opcode: &str, register: &instruction_parser::Operand) -> i64 {
    if opcode.ends_with("sw") {
        return 4;
    }
    if opcode.ends_with('b') {
        return 1;
    }
    if opcode.ends_with('h') {
        return 2;
    }
    match register {
        instruction_parser::Operand::Register(instruction_parser::RePrefix::W, _) => 4,
        instruction_parser::Operand::Vector(_, _, arrangement)
        | instruction_parser::Operand::VectorAccess(_, _, arrangement, _) => arrangement.width(),
        instruction_parser::Operand::VectorRegister(..) => 16,
        _ => 8,
    }
}

pub fn format_address(base: &AbstractExpression, offset: i64) -> String {
    if offset < 0 {
        format!("{base} - {}", -offset)
    } else {
        format!("{base} + {offset}")
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct MemoryAccess {
    pub kind: RegionType,
    pub base: AbstractExpression,
    pub offset: i64,
}

impl fmt::Display for MemoryAccess {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{:?}, {}, {:?}", self.kind, self.base, self.offset)
    }
}

#[derive(Debug, Clone)]
pub enum FlagValue {
    Abstract(AbstractComparison),
    Real(bool),
}

impl FlagValue {
    pub fn to_abstract_expression(&self) -> AbstractComparison {
        match self {
            Self::Abstract(a) => a.clone(),
            Self::Real(r) => match r {
                true => {
                    generate_comparison("==", AbstractExpression::Empty, AbstractExpression::Empty)
                }
                false => {
                    generate_comparison("!=", AbstractExpression::Empty, AbstractExpression::Empty)
                }
            },
        }
    }

    pub fn not(&self) -> Self {
        match self {
            Self::Abstract(a) => Self::Abstract(a.clone().not()),
            Self::Real(r) => Self::Real(!r),
        }
    }
}

impl PartialEq for FlagValue {
    fn eq(&self, other: &Self) -> bool {
        match (self, other) {
            (FlagValue::Abstract(a), FlagValue::Abstract(b)) => a == b,
            (FlagValue::Real(a), FlagValue::Real(b)) => a == b,
            _ => false,
        }
    }
}

#[derive(Debug, Clone, Copy, Eq, PartialEq)]
pub enum RegionType {
    READ,
    WRITE,
    RW,
}

impl fmt::Display for RegionType {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            RegionType::READ => write!(f, "read"),
            RegionType::WRITE => write!(f, "write"),
            RegionType::RW => write!(f, "read/write"),
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct IndexedFact {
    pub label: String,
    pub base: i64,
    pub stride: i64,
    pub first: AbstractExpression,
    pub end: AbstractExpression,
    pub width: i64,
    pub signed: bool,
    pub op: String,
    pub bound: AbstractExpression,
}

impl IndexedFact {
    pub fn elements(
        label: String,
        first: AbstractExpression,
        end: AbstractExpression,
        width: i64,
        signed: bool,
    ) -> Self {
        IndexedFact {
            label,
            base: 0,
            stride: width,
            first,
            end,
            width,
            signed,
            op: "==".to_string(),
            bound: AbstractExpression::Immediate(0),
        }
    }

    pub fn bounded(self, op: &str, bound: AbstractExpression) -> Self {
        IndexedFact {
            op: op.to_string(),
            bound,
            ..self
        }
    }

    pub fn placed(self, base: i64, stride: i64) -> Self {
        IndexedFact {
            base,
            stride,
            ..self
        }
    }

    fn element_start(&self, index: &ast::Int) -> ast::Int {
        ast::Int::add(&[
            &ast::Int::from_i64(self.base),
            &ast::Int::mul(&[index, &ast::Int::from_i64(self.stride)]),
        ])
    }

    pub fn byte_span(&self) -> Option<(ast::Int, ast::Int)> {
        let first = expression_to_ast(self.first.clone())?;
        let end = expression_to_ast(self.end.clone())?;
        let last = ast::Int::sub(&[&end, &ast::Int::from_i64(1)]);
        Some((
            self.element_start(&first),
            ast::Int::add(&[&self.element_start(&last), &ast::Int::from_i64(self.width)]),
        ))
    }

    pub fn is_empty_ast(&self) -> Option<ast::Bool> {
        let first = expression_to_ast(self.first.clone())?;
        let end = expression_to_ast(self.end.clone())?;
        Some(end.le(&first))
    }

    pub fn covers(&self, offset: &ast::Int) -> Option<ast::Bool> {
        let first = expression_to_ast(self.first.clone())?;
        let end = expression_to_ast(self.end.clone())?;
        let within = ast::Int::sub(&[offset, &ast::Int::from_i64(self.base)]);
        let stride = ast::Int::from_i64(self.stride);
        Some(ast::Bool::and(&[
            &within.modulo(&stride).eq(ast::Int::from_i64(0)),
            &within.ge(ast::Int::mul(&[&first, &stride])),
            &within.lt(ast::Int::mul(&[&end, &stride])),
        ]))
    }

    pub fn value_range(&self) -> Option<(i64, i64)> {
        let bits = 8 * u32::try_from(self.width)
            .ok()
            .filter(|w| (1..8).contains(w))?;
        Some(if self.signed {
            (-(1i64 << (bits - 1)), (1i64 << (bits - 1)) - 1)
        } else {
            (0, (1i64 << bits) - 1)
        })
    }
}

#[derive(Debug, Clone)]
pub struct MemorySafeRegion {
    pub kind: RegionType,
    length: AbstractExpression,
    alignment: i64,
    pub content: BTreeMap<i64, RegisterValue>,
    widths: BTreeMap<i64, i64>,
    written: Vec<(i64, i64)>,
    pub epoch: usize,
    pub many: bool,
    indexed_facts: Vec<IndexedFact>,
}

impl MemorySafeRegion {
    pub fn new(length: AbstractExpression, kind: RegionType) -> Self {
        Self {
            kind,
            length,
            alignment: 1,
            content: BTreeMap::new(),
            widths: BTreeMap::new(),
            written: Vec::new(),
            epoch: 0,
            many: false,
            indexed_facts: Vec::new(),
        }
    }

    pub fn stands_for_many(&mut self) {
        self.many = true;
    }

    pub fn indexed_facts(&self) -> &[IndexedFact] {
        &self.indexed_facts
    }

    pub fn add_indexed_fact(&mut self, fact: IndexedFact) {
        self.indexed_facts.push(fact);
    }

    pub fn keep_indexed_facts(&mut self, kept: Vec<IndexedFact>) {
        self.indexed_facts = kept;
    }

    fn changed(&mut self) {
        self.indexed_facts.clear();
    }

    pub fn with_alignment(mut self, alignment: i64) -> Self {
        self.alignment = alignment;
        self
    }

    pub fn alignment(&self) -> i64 {
        self.alignment
    }

    pub fn write(&mut self, address: i64, width: i64, value: Option<RegisterValue>) {
        self.changed();
        let widths = &self.widths;
        let overlapped: Vec<i64> = self
            .content
            .keys()
            .copied()
            .filter(|k| *k < address + width && k + widths.get(k).copied().unwrap_or(8) > address)
            .collect();
        for k in overlapped {
            self.content.remove(&k);
            self.widths.remove(&k);
        }
        if let Some(value) = value {
            self.content.insert(address, value);
            self.widths.insert(address, width);
        }
        self.written.push((address, address + width));
    }

    pub fn overwritten(&self, address: i64, width: i64) -> bool {
        self.written
            .iter()
            .any(|&(start, end)| start < address + width && address < end)
    }

    pub fn read(&self, address: i64, width: i64) -> Option<RegisterValue> {
        if let Some(v) = self.content.get(&address) {
            let stored = self.widths.get(&address).copied().unwrap_or(8);
            if stored == width {
                return Some(v.clone());
            }
            if width < stored
                && (1..=4).contains(&width)
                && v.kind == RegisterKind::RegisterBase
                && let Some(base) = &v.base
            {
                let whole = if v.offset == 0 {
                    base.clone()
                } else {
                    generate_expression("+", base.clone(), AbstractExpression::Immediate(v.offset))
                };
                return Some(RegisterValue::new(
                    RegisterKind::RegisterBase,
                    Some(generate_expression(
                        "%",
                        whole,
                        AbstractExpression::Immediate(1i64 << (8 * width)),
                    )),
                    0,
                ));
            }
        }
        if !(1..=8).contains(&width) {
            return None;
        }
        self.read_bytes(address, width)
            .or_else(|| self.read_whole_cells(address, width))
    }

    fn read_whole_cells(&self, address: i64, width: i64) -> Option<RegisterValue> {
        let mut constant: u64 = 0;
        let mut terms: Option<AbstractExpression> = None;
        let mut at = address;
        while at < address + width {
            let cell = self.content.get(&at)?;
            let cell_width = self.widths.get(&at).copied()?;
            if !(1..=4).contains(&cell_width) || at + cell_width > address + width {
                return None;
            }
            let shift = 8 * (at - address) as u32;
            let modulus = 1i64 << (8 * cell_width);
            match (&cell.kind, &cell.base) {
                (RegisterKind::Immediate, None) => {
                    let piece = (cell.offset as u64 & (modulus as u64 - 1)).checked_shl(shift)?;
                    constant = constant.checked_add(piece)?;
                }
                (RegisterKind::RegisterBase, Some(base)) => {
                    let whole = generate_expression(
                        "+",
                        base.clone(),
                        AbstractExpression::Immediate(cell.offset),
                    );
                    let field =
                        generate_expression("%", whole, AbstractExpression::Immediate(modulus));
                    let piece = if shift == 0 {
                        field
                    } else {
                        generate_expression(
                            "*",
                            field,
                            AbstractExpression::Immediate(1i64 << shift),
                        )
                    };
                    terms = Some(match terms {
                        None => piece,
                        Some(sum) => generate_expression("+", sum, piece),
                    });
                }
                _ => return None,
            }
            at += cell_width;
        }
        let constant = i64::try_from(constant).ok()?;
        let composed = generate_expression("+", terms?, AbstractExpression::Immediate(constant));
        Some(RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(composed),
            0,
        ))
    }

    fn read_bytes(&self, address: i64, width: i64) -> Option<RegisterValue> {
        let mut value: u64 = 0;
        for byte in 0..width {
            let at = address + byte;
            let (start, stored) = (0..16).find_map(|back| {
                let k = at - back;
                let v = self.content.get(&k)?;
                (at < k + self.widths.get(&k).copied().unwrap_or(8)).then_some((k, v))
            })?;
            if stored.kind != RegisterKind::Immediate || stored.base.is_some() {
                return None;
            }
            let b = (stored.offset as u64).checked_shr(8 * (at - start) as u32)? & 0xff;
            value |= b << (8 * byte);
        }
        Some(RegisterValue::new_imm(value as i64))
    }

    pub fn insert_sized(&mut self, address: i64, value: RegisterValue, width: i64) {
        self.changed();
        self.content.insert(address, value);
        self.widths.insert(address, width);
    }

    pub fn pristine(&self) -> bool {
        self.written.is_empty() && self.epoch == 0
    }

    pub fn clobber(&mut self) {
        self.changed();
        self.content.clear();
        self.widths.clear();
        self.written.clear();
        self.epoch += 1;
    }

    pub fn insert(&mut self, address: i64, value: RegisterValue) {
        self.changed();
        self.content.insert(address, value);
    }

    pub fn width_at(&self, address: i64) -> Option<i64> {
        self.widths.get(&address).copied()
    }

    pub fn overlapping(&self, address: i64, width: i64) -> Vec<i64> {
        self.content
            .keys()
            .copied()
            .filter(|k| {
                *k < address.saturating_add(width)
                    && k + self.widths.get(k).copied().unwrap_or(8) > address
            })
            .collect()
    }

    pub fn put(&mut self, address: i64, entry: Option<(RegisterValue, Option<i64>)>) {
        self.changed();
        match entry {
            Some((value, width)) => {
                self.content.insert(address, value);
                match width {
                    Some(w) => self.widths.insert(address, w),
                    None => self.widths.remove(&address),
                };
            }
            None => {
                self.content.remove(&address);
                self.widths.remove(&address);
            }
        }
    }

    pub fn mark_written(&mut self, address: i64, width: i64) {
        self.changed();
        self.written.push((address, address.saturating_add(width)));
    }

    pub fn renew_unwritten(&mut self) {
        self.changed();
        self.epoch += 1;
    }

    pub fn grow_to(&mut self, end: i64) {
        if let AbstractExpression::Immediate(l) = self.length
            && l < end
        {
            self.length = AbstractExpression::Immediate(end);
        }
    }

    pub fn get(&self, address: i64) -> Option<RegisterValue> {
        let res = self.content.get(&address);
        match res {
            Some(_) => res.cloned(),
            None => Some(RegisterValue::new(RegisterKind::Number, None, 0)),
        }
    }

    pub fn get_length(&self) -> AbstractExpression {
        self.length.clone()
    }
}

#[derive(Debug, Clone)]
pub struct MemorySafetyError {
    details: String,
}

impl MemorySafetyError {
    pub fn new(msg: &str) -> MemorySafetyError {
        MemorySafetyError {
            details: msg.to_string(),
        }
    }
}
impl fmt::Display for MemorySafetyError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.details)
    }
}

pub fn get_register_name_string(r: String) -> String {
    r.split(",")
        .next()
        .unwrap_or(&r)
        .trim_matches('[')
        .to_string()
}

fn mask_modulus(expression: &AbstractExpression) -> Option<i64> {
    match expression {
        AbstractExpression::Immediate(mask) if *mask > 0 && *mask < i64::MAX => {
            (mask.wrapping_add(1) as u64)
                .is_power_of_two()
                .then_some(mask + 1)
        }
        _ => None,
    }
}

fn fits_signed(expression: &AbstractExpression, bits: u32) -> bool {
    match expression {
        AbstractExpression::Immediate(v) => {
            let half = 1i128 << (bits - 1);
            (-half..half).contains(&(*v as i128))
        }
        AbstractExpression::Expression(op, _, width) => match (op.as_str(), width.as_ref()) {
            ("sext", AbstractExpression::Immediate(w)) => (1..=bits as i64).contains(w),
            ("zext", AbstractExpression::Immediate(w)) => (1..bits as i64).contains(w),
            ("&", mask) => mask_modulus(mask).is_some_and(|m| m as i128 <= 1i128 << (bits - 1)),
            _ => false,
        },
        _ => false,
    }
}

fn single_bit(expression: &AbstractExpression) -> Option<i64> {
    match expression {
        AbstractExpression::Immediate(mask) if *mask > 0 => {
            (*mask as u64).is_power_of_two().then_some(*mask)
        }
        _ => None,
    }
}

fn cleared_bit(expression: &AbstractExpression) -> Option<i64> {
    match expression {
        AbstractExpression::Immediate(mask) if *mask < 0 => {
            let bit = !*mask;
            (bit > 0 && (bit as u64).is_power_of_two()).then_some(bit)
        }
        _ => None,
    }
}

fn align_modulus(expression: &AbstractExpression) -> Option<i64> {
    match expression {
        AbstractExpression::Immediate(mask) if *mask < 0 => {
            let magnitude = mask.checked_neg()?;
            (magnitude as u64).is_power_of_two().then_some(magnitude)
        }
        _ => None,
    }
}

fn field_mask(expression: &AbstractExpression) -> Option<(i64, i64)> {
    let AbstractExpression::Immediate(mask) = expression else {
        return None;
    };
    if *mask <= 0 {
        return None;
    }
    let low = mask.trailing_zeros();
    let run = (*mask as u64) >> low;
    if run & (run + 1) != 0 || low + (64 - run.leading_zeros()) > 62 {
        return None;
    }
    let high = low + (64 - run.leading_zeros());
    Some((1i64 << low, 1i64 << high))
}

fn align32_modulus(expression: &AbstractExpression) -> Option<i64> {
    match expression {
        AbstractExpression::Immediate(mask) if (1..1 << 32).contains(mask) => {
            let cleared = (1i64 << 32) - mask;
            (cleared as u64).is_power_of_two().then_some(cleared)
        }
        _ => None,
    }
}

fn disjoint_bits(a: &AbstractExpression, b: &AbstractExpression) -> bool {
    let shift = |e: &AbstractExpression, ops: &[&str]| match e {
        AbstractExpression::Expression(op, _, amount) if ops.contains(&op.as_str()) => {
            match **amount {
                AbstractExpression::Immediate(n) => Some(n),
                _ => None,
            }
        }
        _ => None,
    };
    let shifted_apart = |x: &AbstractExpression, y: &AbstractExpression| {
        shift(x, &["lsr", ">>"])
            .zip(shift(y, &["lsl", "<<"]))
            .is_some_and(|(s1, s2)| s1 + s2 >= 64)
    };
    shifted_apart(a, b) || shifted_apart(b, a)
}

pub fn is_exactly_translatable(e: &AbstractExpression) -> bool {
    expression_to_ast(e.clone()).is_some() && !has_opaque_bitwise(e)
}

fn has_opaque_bitwise(e: &AbstractExpression) -> bool {
    match e {
        AbstractExpression::Expression(op, left, right) => {
            let constant =
                |side: &AbstractExpression| matches!(side, AbstractExpression::Immediate(_));
            (matches!(op.as_str(), "&" | "|" | "^") && !constant(left) && !constant(right))
                || has_opaque_bitwise(left)
                || has_opaque_bitwise(right)
        }
        AbstractExpression::Register(reg) => reg.base.as_ref().is_some_and(has_opaque_bitwise),
        _ => false,
    }
}

pub fn is_translatable_with_clamps(e: &AbstractExpression) -> bool {
    match e {
        AbstractExpression::Expression(op, left, right) if op == "atleast" || op == "atmost" => {
            is_translatable_with_clamps(left) && is_translatable_with_clamps(right)
        }
        AbstractExpression::Expression(op, left, right) => {
            matches!(
                op.as_str(),
                "+" | "-" | "*" | "/" | "%" | "&" | "^" | "|" | "lsl" | "lsr" | ">>"
            ) && is_translatable_with_clamps(left)
                && is_translatable_with_clamps(right)
        }
        AbstractExpression::Register(reg) => {
            reg.base.as_ref().is_none_or(is_translatable_with_clamps)
        }
        _ => true,
    }
}

pub fn is_translatable(e: &AbstractExpression) -> bool {
    match e {
        AbstractExpression::Expression(op, left, right) => {
            matches!(
                op.as_str(),
                "+" | "-" | "*" | "/" | "%" | "&" | "^" | "|" | "lsl" | "lsr" | ">>"
            ) && is_translatable(left)
                && is_translatable(right)
        }
        AbstractExpression::Register(reg) => match &reg.base {
            Some(base) => is_translatable(base),
            None => true,
        },
        _ => true,
    }
}

pub fn substitute(
    e: &AbstractExpression,
    name: &str,
    value: &AbstractExpression,
) -> AbstractExpression {
    match e {
        AbstractExpression::Abstract(symbol) if symbol == name => value.clone(),
        AbstractExpression::Expression(op, left, right) => generate_expression(
            op,
            substitute(left, name, value),
            substitute(right, name, value),
        ),
        other => other.clone(),
    }
}

fn opaque_name(kind: &str, expression: &AbstractExpression) -> String {
    use std::hash::{DefaultHasher, Hash, Hasher};
    let mut hasher = DefaultHasher::new();
    expression.to_string().hash(&mut hasher);
    format!("{kind}_{:x}", hasher.finish())
}

fn flip_bit(value: &ast::Int, bit: i64) -> ast::Int {
    let two = ast::Int::from_i64(2);
    ast::Int::sub(&[
        &ast::Int::add(&[value, &ast::Int::from_i64(bit)]),
        &ast::Int::mul(&[&two, &bit_of(value, bit)]),
    ])
}

fn flip_mask(value: &ast::Int, mask: &AbstractExpression) -> Option<ast::Int> {
    let AbstractExpression::Immediate(mask) = mask else {
        return None;
    };
    if *mask < 0 {
        return None;
    }
    let mut result = value.clone();
    let mut remaining = *mask as u64;
    while remaining != 0 {
        let bit = remaining & remaining.wrapping_neg();
        result = flip_bit(&result, bit as i64);
        remaining -= bit;
    }
    Some(result)
}

fn masked_bits(value: &ast::Int, mask: &AbstractExpression) -> Option<ast::Int> {
    let AbstractExpression::Immediate(mask) = mask else {
        return None;
    };
    if *mask < 0 {
        return None;
    }
    let mut parts = Vec::new();
    let mut remaining = *mask as u64;
    while remaining != 0 {
        let low = remaining & remaining.wrapping_neg();
        let filled = remaining | (low - 1);
        let above = filled.wrapping_add(1) & !filled;
        parts.push(ast::Int::sub(&[
            &value.modulo(ast::Int::from_u64(above)),
            &value.modulo(ast::Int::from_u64(low)),
        ]));
        remaining &= above.wrapping_neg();
    }
    let borrowed: Vec<&ast::Int> = parts.iter().collect();
    match borrowed.is_empty() {
        true => Some(ast::Int::from_i64(0)),
        false => Some(ast::Int::add(&borrowed)),
    }
}

fn bit_of(value: &ast::Int, bit: i64) -> ast::Int {
    note_digit_identity(value, bit, 2);
    let weight = ast::Int::from_i64(bit);
    let two = ast::Int::from_i64(2);
    ast::Int::mul(&[&value.div(&weight).modulo(&two), &weight])
}

thread_local! {
    static DIGIT_IDENTITIES: RefCell<BTreeMap<String, (ast::Dynamic, ast::Bool)>> = const { RefCell::new(BTreeMap::new()) };
}

fn note_digit_identity(value: &ast::Int, divisor: i64, modulus: i64) {
    let Some(span) = divisor.checked_mul(modulus) else {
        return;
    };
    if divisor <= 0 || modulus <= 0 {
        return;
    }
    let divisor = ast::Int::from_i64(divisor);
    let digit = value.div(&divisor).modulo(ast::Int::from_i64(modulus));
    let identity = value.modulo(ast::Int::from_i64(span)).eq(ast::Int::add(&[
        &ast::Int::mul(&[&divisor, &digit]),
        &value.modulo(&divisor),
    ]));
    DIGIT_IDENTITIES.with_borrow_mut(|identities| {
        identities
            .entry(identity.to_string())
            .or_insert((ast::Dynamic::from_ast(&digit), identity));
    });
}

fn digit_identities_about(facts: &[ast::Bool]) -> Vec<ast::Bool> {
    if DIGIT_IDENTITIES.with_borrow(|identities| identities.is_empty()) {
        return Vec::new();
    }
    let mut seen: HashSet<ast::Dynamic> = HashSet::new();
    let mut pending: Vec<ast::Dynamic> = facts
        .iter()
        .map(|fact| ast::Dynamic::from_ast(fact))
        .collect();
    while let Some(term) = pending.pop() {
        if seen.contains(&term) {
            continue;
        }
        if term.is_app() {
            pending.extend(term.children());
        }
        seen.insert(term);
    }
    DIGIT_IDENTITIES.with_borrow(|identities| {
        identities
            .values()
            .filter(|(digit, _)| seen.contains(digit))
            .map(|(_, identity)| identity.clone())
            .collect()
    })
}

fn signed_word(value: &ast::Int, operand: &AbstractExpression) -> ast::Int {
    let modulus = ast::Int::from_str(&(1u128 << 64).to_string()).expect("modulus");
    let half = ast::Int::from_str(&(1u128 << 63).to_string()).expect("half");
    let in_signed_range = |v: &ast::Int| v.ge(half.unary_minus()) & v.lt(&half);
    let wrapped = ast::Int::new_const(opaque_name("signed_word", operand));
    let wrapped = in_signed_range(&wrapped).ite(&wrapped, &ast::Int::from_i64(0));
    let unsigned_high = value.ge(&half) & value.lt(&modulus);
    in_signed_range(value).ite(
        value,
        &unsigned_high.ite(&ast::Int::sub(&[value, &modulus]), &wrapped),
    )
}

pub fn expression_to_ast(expression: AbstractExpression) -> Option<ast::Int> {
    match expression.clone() {
        AbstractExpression::Immediate(num) => Some(ast::Int::from_i64(num)),
        AbstractExpression::Abstract(a) => Some(ast::Int::new_const(a)),
        AbstractExpression::Register(reg) => {
            if let Some(base) = reg.base.clone() {
                let base = expression_to_ast(base.clone())?;
                let offset = ast::Int::from_i64(reg.offset);
                Some(ast::Int::add(&[&base, &offset]))
            } else if reg.kind == RegisterKind::Number {
                expression_to_ast(fresh_unknown())
            } else {
                Some(ast::Int::from_i64(reg.offset))
            }
        }
        AbstractExpression::Expression(op, old1, old2) => {
            if op == "!&"
                && let AbstractExpression::Expression(inner, shifted, amount) = old2.as_ref()
                && inner == "asr"
                && shifted.as_ref() == old1.as_ref()
                && **amount == AbstractExpression::Immediate(63)
            {
                let value = signed_word(&expression_to_ast(*old1.clone())?, &old1);
                let zero = ast::Int::from_i64(0);
                return Some(value.ge(&zero).ite(&value, &zero));
            }
            if op == "!&"
                && let AbstractExpression::Expression(inner, shifted, amount) = old2.as_ref()
                && inner == "asr"
                && **amount == AbstractExpression::Immediate(31)
                && let AbstractExpression::Expression(extension, word, bits) = shifted.as_ref()
                && extension == "sext"
                && **bits == AbstractExpression::Immediate(32)
                && word.as_ref() == old1.as_ref()
            {
                let whole = expression_to_ast(*old1.clone())?;
                let low = whole.modulo(ast::Int::from_i64(1i64 << 32));
                let negative = low.ge(ast::Int::from_i64(1i64 << 31));
                return Some(negative.ite(&ast::Int::from_i64(0), &whole));
            }
            if op == "!&"
                && let AbstractExpression::Immediate(mask) = old2.as_ref()
            {
                return expression_to_ast(generate_expression(
                    "&",
                    *old1.clone(),
                    AbstractExpression::Immediate(!mask),
                ));
            }
            let constant_shift = match old2.as_ref() {
                AbstractExpression::Immediate(k) if *k >= 0 => Some(*k),
                _ => None,
            };
            let new1 = expression_to_ast(*old1.clone())?;
            let new2 = expression_to_ast(*old2.clone())?;
            match op.as_str() {
                "asr" if constant_shift.is_some() => {
                    let shift = constant_shift.unwrap();
                    let zero = ast::Int::from_i64(0);
                    let new1 = signed_word(&new1, &old1);
                    if shift >= 63 {
                        let minus_one = ast::Int::from_i64(-1);
                        return Some(new1.ge(&zero).ite(&zero, &minus_one));
                    }
                    Some(new1.div(ast::Int::from_i64(1i64 << shift)))
                }
                "lsr" | ">>" if constant_shift.is_some() => {
                    let shift = constant_shift.unwrap();
                    let zero = ast::Int::from_i64(0);
                    if shift >= 64 {
                        return Some(zero);
                    }
                    let modulus = ast::Int::from_str(&(1u128 << 64).to_string()).expect("modulus");
                    let divisor =
                        ast::Int::from_str(&(1u128 << shift).to_string()).expect("divisor");
                    Some(new1.modulo(&modulus).div(&divisor))
                }
                "clz" if matches!(constant_shift, Some(32 | 64)) => {
                    let width = constant_shift.unwrap() as u32;
                    let zero = ast::Int::from_i64(0);
                    let modulus =
                        ast::Int::from_str(&(1u128 << width).to_string()).expect("modulus");
                    let unsigned = if width == 32 {
                        new1.modulo(&modulus)
                    } else {
                        new1.ge(&zero)
                            .ite(&new1, &ast::Int::add(&[&new1, &modulus]))
                    };
                    let mut count = ast::Int::from_i64(width as i64);
                    for k in (0..width).rev() {
                        let threshold = ast::Int::from_str(&(1u128 << (width - 1 - k)).to_string())
                            .expect("threshold");
                        count = unsigned
                            .ge(&threshold)
                            .ite(&ast::Int::from_i64(k as i64), &count);
                    }
                    Some(count)
                }
                "zext" if constant_shift == Some(64) => {
                    let zero = ast::Int::from_i64(0);
                    let modulus = ast::Int::from_str(&(1u128 << 64).to_string()).expect("modulus");
                    let wrapped = ast::Int::add(&[&new1, &modulus]);
                    Some(new1.ge(&zero).ite(&new1, &wrapped))
                }
                "zext" | "sext" if matches!(constant_shift, Some(1..=64)) => {
                    let width = constant_shift.unwrap();
                    let modulus =
                        ast::Int::from_str(&(1u128 << width).to_string()).expect("modulus");
                    if op == "zext" {
                        return Some(new1.modulo(&modulus));
                    }
                    let half =
                        ast::Int::from_str(&(1u128 << (width - 1)).to_string()).expect("half");
                    let shifted = ast::Int::add(&[&new1, &half]).modulo(&modulus);
                    Some(ast::Int::sub(&[&shifted, &half]))
                }
                "atleast" => Some(new1.lt(&new2).ite(&new2, &new1)),
                "atmost" => Some(new1.gt(&new2).ite(&new2, &new1)),
                "+" => Some(ast::Int::add(&[&new1, &new2])),
                "-" => Some(ast::Int::sub(&[&new1, &new2])),
                "*" => Some(ast::Int::mul(&[&new1, &new2])),
                "/" => Some(new1.div(&new2)),
                "lsl" if matches!(constant_shift, Some(0..=31)) => {
                    let multiplier =
                        ast::Int::from_str(&(1u128 << constant_shift.unwrap()).to_string())
                            .expect("multiplier");
                    Some(ast::Int::mul(&[&new1, &multiplier]))
                }
                "lsl" => {
                    let two = ast::Int::from_i64(2);
                    let multiplier = two.power(&new2).to_int();
                    Some(ast::Int::mul(&[&new1, &multiplier]))
                }
                ">>" | "lsr" => {
                    let two = ast::Int::from_i64(2);
                    let divisor = two.power(&new2).to_int();
                    Some(new1.div(&divisor))
                }
                "%" => {
                    if let AbstractExpression::Expression(inner_op, dividend, divisor) =
                        old1.as_ref()
                        && inner_op == "/"
                        && let (AbstractExpression::Immediate(divisor), Some(modulus)) =
                            (divisor.as_ref(), constant_shift)
                        && let Some(dividend) = expression_to_ast((**dividend).clone())
                    {
                        note_digit_identity(&dividend, *divisor, modulus);
                    }
                    Some(new1.modulo(&new2))
                }
                "umulh" => {
                    let half_word = ast::Int::from_u64(1 << 32);
                    let word = ast::Int::mul(&[&half_word, &half_word]);
                    let product = ast::Int::mul(&[&new1.modulo(&word), &new2.modulo(&word)]);
                    Some(product.div(&word))
                }
                "&" => {
                    if let Some(modulus) = mask_modulus(&old2) {
                        Some(new1.modulo(ast::Int::from_i64(modulus)))
                    } else if let Some(modulus) = mask_modulus(&old1) {
                        Some(new2.modulo(ast::Int::from_i64(modulus)))
                    } else if let Some(bit) = single_bit(&old2) {
                        Some(bit_of(&new1, bit))
                    } else if let Some(bit) = single_bit(&old1) {
                        Some(bit_of(&new2, bit))
                    } else if let Some(bit) = cleared_bit(&old2) {
                        Some(ast::Int::sub(&[&new1, &bit_of(&new1, bit)]))
                    } else if let Some(bit) = cleared_bit(&old1) {
                        Some(ast::Int::sub(&[&new2, &bit_of(&new2, bit)]))
                    } else if let Some(modulus) = align_modulus(&old2) {
                        Some(ast::Int::sub(&[
                            &new1,
                            &new1.modulo(ast::Int::from_i64(modulus)),
                        ]))
                    } else if let Some(modulus) = align_modulus(&old1) {
                        Some(ast::Int::sub(&[
                            &new2,
                            &new2.modulo(ast::Int::from_i64(modulus)),
                        ]))
                    } else if let Some(masked) = masked_bits(&new1, &old2) {
                        Some(masked)
                    } else if let Some(masked) = masked_bits(&new2, &old1) {
                        Some(masked)
                    } else if let Some(modulus) = align32_modulus(&old2) {
                        let low = new1.modulo(ast::Int::from_i64(1 << 32));
                        Some(ast::Int::sub(&[
                            &low,
                            &low.modulo(ast::Int::from_i64(modulus)),
                        ]))
                    } else if let Some(modulus) = align32_modulus(&old1) {
                        let low = new2.modulo(ast::Int::from_i64(1 << 32));
                        Some(ast::Int::sub(&[
                            &low,
                            &low.modulo(ast::Int::from_i64(modulus)),
                        ]))
                    } else if let Some((low, high)) = field_mask(&old2) {
                        Some(ast::Int::sub(&[
                            &new1.modulo(ast::Int::from_i64(high)),
                            &new1.modulo(ast::Int::from_i64(low)),
                        ]))
                    } else if let Some((low, high)) = field_mask(&old1) {
                        Some(ast::Int::sub(&[
                            &new2.modulo(ast::Int::from_i64(high)),
                            &new2.modulo(ast::Int::from_i64(low)),
                        ]))
                    } else {
                        Some(ast::Int::new_const(opaque_name("and", &expression)))
                    }
                }
                "^" => {
                    if old1 == old2 {
                        Some(ast::Int::from_i64(0))
                    } else if matches!(*old2, AbstractExpression::Immediate(-1)) {
                        Some(ast::Int::sub(&[&ast::Int::from_i64(-1), &new1]))
                    } else if matches!(*old1, AbstractExpression::Immediate(-1)) {
                        Some(ast::Int::sub(&[&ast::Int::from_i64(-1), &new2]))
                    } else if let Some(flipped) = flip_mask(&new1, &old2) {
                        Some(flipped)
                    } else {
                        flip_mask(&new2, &old1)
                    }
                }
                "|" => {
                    if matches!(*old1, AbstractExpression::Immediate(-1))
                        || matches!(*old2, AbstractExpression::Immediate(-1))
                    {
                        Some(ast::Int::from_i64(-1))
                    } else if matches!(*old1, AbstractExpression::Immediate(0)) {
                        Some(new2)
                    } else if matches!(*old2, AbstractExpression::Immediate(0)) {
                        Some(new1)
                    } else if disjoint_bits(&old1, &old2) {
                        Some(ast::Int::add(&[&new1, &new2]))
                    } else {
                        Some(ast::Int::new_const(opaque_name("or", &expression)))
                    }
                }
                _ => Some(ast::Int::new_const(opaque_name("opaque", &expression))),
            }
        }
        _ => Some(ast::Int::from_i64(0)),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_narrow_read_inside_a_wide_constant_is_unknown_past_its_eighth_byte() {
        let mut region = MemorySafeRegion::new(AbstractExpression::Immediate(16), RegionType::RW);
        region.insert_sized(0, RegisterValue::new_imm(0x0807_0605_0403_0201), 16);
        assert_eq!(region.read(1, 1).map(|v| v.offset), Some(2));
        assert!(region.read(9, 1).is_none());
        assert!(region.read(6, 4).is_none());
    }

    #[test]
    fn a_mask_of_several_runs_keeps_each_run() {
        for mask in [0xffff_fffc, 0xb6, 0x7fff_ffff_ffff_fff0, 0x8000_0001] {
            for value in [
                0,
                3,
                4,
                0x1234_5677,
                0xffff_ffff,
                0x1_0000_0007,
                -5,
                i64::MIN + 9,
            ] {
                assert!(
                    equals(&masked(value, mask), value & mask),
                    "{value:#x} & {mask:#x}"
                );
            }
        }
    }

    #[test]
    fn mask_modulus_recognizes_all_ones() {
        assert_eq!(mask_modulus(&AbstractExpression::Immediate(1)), Some(2));
        assert_eq!(mask_modulus(&AbstractExpression::Immediate(15)), Some(16));
        assert_eq!(mask_modulus(&AbstractExpression::Immediate(6)), None);
        assert_eq!(mask_modulus(&AbstractExpression::Immediate(0)), None);
        assert_eq!(mask_modulus(&AbstractExpression::Immediate(-1)), None);
        assert_eq!(mask_modulus(&AbstractExpression::Immediate(i64::MAX)), None);
        assert_eq!(mask_modulus(&abstract_of("len")), None);
    }

    fn masked(value: i64, mask: i64) -> ast::Int {
        expression_to_ast(generate_expression(
            "&",
            AbstractExpression::Immediate(value),
            AbstractExpression::Immediate(mask),
        ))
        .expect("mask is translatable")
    }

    fn equals(left: &ast::Int, value: i64) -> bool {
        let solver = Solver::new();
        solver.check_assumptions(&[left.eq(ast::Int::from_i64(value)).not()]) == SatResult::Unsat
    }

    #[test]
    fn a_single_bit_mask_keeps_only_that_bit() {
        assert!(equals(&masked(0b1101, 8), 8));
        assert!(equals(&masked(0b0101, 8), 0));
        assert!(equals(&masked(0b1101, 4), 4));
    }

    #[test]
    fn a_negated_single_bit_mask_clears_only_that_bit() {
        assert!(equals(&masked(0b1101, !8), 0b0101));
        assert!(equals(&masked(0b0101, !8), 0b0101));
        assert!(equals(&masked(200, -65), 200 & -65));
    }

    #[test]
    fn a_word_align_down_mask_keeps_the_high_bits_of_the_low_word() {
        assert_eq!(
            align32_modulus(&AbstractExpression::Immediate(0xffff_fffc)),
            Some(4)
        );
        assert_eq!(
            align32_modulus(&AbstractExpression::Immediate(0xffff_fff0)),
            Some(16)
        );
        assert_eq!(
            align32_modulus(&AbstractExpression::Immediate(0xffff_fff5)),
            None
        );
        assert!(equals(&masked(203, 0xffff_fffc), 200));
        assert!(equals(&masked(-1, 0xffff_fffc), 0xffff_fffc));
        assert!(equals(&masked(0x1_0000_0007, 0xffff_fffc), 4));
    }

    #[test]
    fn a_run_of_bits_mask_keeps_that_field() {
        assert_eq!(
            field_mask(&AbstractExpression::Immediate(0x1fc000)),
            Some((1 << 14, 1 << 21))
        );
        assert_eq!(
            field_mask(&AbstractExpression::Immediate(0x30)),
            Some((16, 64))
        );
        assert_eq!(field_mask(&AbstractExpression::Immediate(0x1f4000)), None);
        for value in [0, 0x1fc000, 0x3fffff, 0x12345678, 123456789, -5] {
            assert!(
                equals(&masked(value, 0x1fc000), value & 0x1fc000),
                "{value:#x}"
            );
        }
    }

    #[test]
    fn a_negative_power_of_two_mask_aligns_down() {
        assert!(equals(&masked(200, -64), 200 & -64));
        assert!(equals(&masked(128, -64), 128));
        assert!(equals(&masked(255, -128), 128));
        assert!(equals(&masked(1000, -1), 1000));
    }

    #[test]
    fn an_irregular_mask_keeps_each_of_its_bits() {
        assert!(equals(&masked(0b111111, 48), 48));
        assert!(equals(&masked(0b010000, 48), 16));
        assert!(equals(&masked(0b001111, 48), 0));
        assert!(equals(&masked(0xABCD, 0x0F0F), 0xABCD & 0x0F0F));
        assert!(equals(&masked(1000, 0), 0));
    }

    fn xored(value: i64, bit: i64) -> ast::Int {
        expression_to_ast(generate_expression(
            "^",
            AbstractExpression::Immediate(value),
            AbstractExpression::Immediate(bit),
        ))
        .expect("xor is translatable")
    }

    #[test]
    fn a_single_bit_xor_flips_only_that_bit() {
        assert!(equals(&xored(0b1101, 8), 0b0101));
        assert!(equals(&xored(0b0101, 8), 0b1101));
        assert!(equals(&xored(32, 32), 0));
        assert!(equals(&xored(0, 32), 32));
    }

    #[test]
    fn a_multi_bit_xor_flips_every_set_bit() {
        assert!(equals(&xored(0b1101, 48), 0b1101 ^ 48));
        assert!(equals(&xored(200, 48), 200 ^ 48));
        assert!(equals(&xored(0, 0), 0));
        assert!(equals(&xored(255, 255), 0));
    }

    #[test]
    fn xor_by_minus_one_is_bitwise_not() {
        for value in [0, 1, -1, 0b1101, 200, i64::MIN + 9, i64::MAX - 1] {
            assert!(equals(&xored(value, -1), !value), "{value:#x}");
            assert!(equals(&xored(-1, value), !value), "{value:#x}");
        }
    }

    #[test]
    fn masked_length_is_zero_when_even() {
        let solver = Solver::new();
        let masked = expression_to_ast(generate_expression(
            "&",
            abstract_of("len"),
            AbstractExpression::Immediate(1),
        ))
        .expect("mask is translatable");
        let len = ast::Int::new_const("len");
        let two = ast::Int::from_i64(2);
        solver.assert(len.modulo(&two).eq(ast::Int::from_i64(0)));
        assert_eq!(
            solver.check_assumptions(&[masked.eq(ast::Int::from_i64(0)).not()]),
            SatResult::Unsat
        );
    }
    #[test]
    fn narrowing_does_not_nest_modulos() {
        let mut value = (Some(abstract_of("w")), 0i64);
        for step in [2i64, -8, -8, -8] {
            value = narrow_to_32(value.0, step);
        }
        let shown = value.0.expect("a base").to_string();
        assert_eq!(shown.matches('%').count(), 1, "{shown}");
    }
}

pub fn comparison_to_ast(expression: AbstractComparison) -> Option<ast::Bool> {
    let left = expression_to_ast(*expression.left)?;
    let right = expression_to_ast(*expression.right)?;
    match expression.op.as_str() {
        "<" => Some(left.lt(&right)),
        ">" => Some(left.gt(&right)),
        ">=" => Some(left.ge(&right)),
        "<=" => Some(left.le(&right)),
        "==" => Some(left.eq(&right)),
        "!=" => Some(ast::Bool::or(&[&left.lt(&right), &left.gt(&right)])),
        _ => todo!("unsupported op {:?}", expression.op),
    }
}

pub fn outside_signed_range(exact: AbstractExpression, bits: u32) -> AbstractComparison {
    let half = 1i128 << (bits - 1);
    let clamped = AbstractExpression::Expression(
        "atmost".to_string(),
        Box::new(AbstractExpression::Expression(
            "atleast".to_string(),
            Box::new(exact.clone()),
            Box::new(AbstractExpression::Immediate((-half) as i64)),
        )),
        Box::new(AbstractExpression::Immediate((half - 1) as i64)),
    );
    AbstractComparison::new("!=", clamped, exact)
}

pub fn confined_load(value: AbstractExpression, width: i64) -> AbstractExpression {
    generate_expression(
        "atmost",
        generate_expression("atleast", value, AbstractExpression::Immediate(0)),
        AbstractExpression::Immediate((1i64 << (8 * width)) - 1),
    )
}

pub fn confined_load_width(e: &AbstractExpression) -> Option<i64> {
    let AbstractExpression::Expression(most, inner, top) = e else {
        return None;
    };
    let AbstractExpression::Expression(least, symbol, zero) = inner.as_ref() else {
        return None;
    };
    let AbstractExpression::Immediate(top) = top.as_ref() else {
        return None;
    };
    let named = matches!(symbol.as_ref(), AbstractExpression::Abstract(_));
    (most == "atmost" && least == "atleast" && named && **zero == AbstractExpression::Immediate(0))
        .then(|| {
            [1, 2, 4]
                .into_iter()
                .find(|w| (1i64 << (8 * w)) - 1 == *top)
        })
        .flatten()
}

#[derive(Debug, Clone, PartialEq)]
pub enum ExecuteReturnType<O = instruction_parser::Operand> {
    Next,
    Split(Vec<AbstractComparison>),
    JumpIndirect(RegisterValue),
    JumpLabel(String),
    JumpAddress(u128),
    ConditionalJumpLabel(AbstractComparison, String),
    ConditionalJumpAddress(AbstractComparison, u128),
    Select(AbstractComparison, O, RegisterValue, RegisterValue),
    Trap,
}

#[cfg(test)]
mod cancellation_tests {
    use super::*;

    fn sym(name: &str) -> AbstractExpression {
        AbstractExpression::Abstract(name.to_string())
    }

    fn imm(v: i64) -> AbstractExpression {
        AbstractExpression::Immediate(v)
    }

    fn add(a: AbstractExpression, b: AbstractExpression) -> AbstractExpression {
        generate_expression("+", a, b)
    }

    fn sub(a: AbstractExpression, b: AbstractExpression) -> AbstractExpression {
        generate_expression("-", a, b)
    }

    fn shown(e: AbstractExpression) -> String {
        e.to_string()
    }

    #[test]
    fn a_term_added_then_subtracted_cancels() {
        assert_eq!(shown(sub(add(sym("x"), sym("y")), sym("x"))), "y");
    }

    #[test]
    fn a_term_subtracted_then_added_cancels() {
        assert_eq!(shown(add(sub(sym("x"), sym("y")), sym("y"))), "x");
    }

    #[test]
    fn a_term_minus_itself_is_zero() {
        assert_eq!(shown(sub(sym("x"), sym("x"))), "0");
    }

    #[test]
    fn subtracting_a_sum_flips_every_term() {
        assert_eq!(shown(sub(add(sym("p"), sym("w")), sym("p"))), "w");
    }

    #[test]
    fn the_bn_mul_mont_address_cancels_its_pointer() {
        let width = generate_expression("lsl", sym("rp_len"), imm(3));
        let inner = sub(add(sym("ap"), width.clone()), sym("ap"));
        assert_eq!(shown(inner), shown(width));
    }

    #[test]
    fn constants_fold_through_a_chain() {
        assert_eq!(shown(sub(add(sym("x"), imm(3)), imm(1))), "x + 2");
    }

    #[test]
    fn unrelated_terms_are_left_alone() {
        assert_eq!(shown(sub(add(sym("x"), sym("y")), sym("z"))), "x + y - z");
    }

    #[test]
    fn a_repeated_term_is_not_over_cancelled() {
        assert_eq!(shown(sub(add(sym("x"), sym("x")), sym("x"))), "x");
    }

    #[test]
    fn a_product_cancels_as_a_whole_term() {
        let p = generate_expression("*", sym("a"), sym("b"));
        assert_eq!(shown(sub(add(sym("c"), p.clone()), p)), "c");
    }

    #[test]
    fn a_negative_multiplier_becomes_a_subtraction() {
        let stepped = generate_expression("*", sym("k"), imm(-32));
        assert_eq!(shown(add(sym("a"), stepped)), "a - k * 32");
    }

    #[test]
    fn the_two_spellings_of_a_countdown_agree() {
        let down = generate_expression("*", sym("k"), imm(-32));
        let up = generate_expression("*", sym("k"), imm(32));
        assert_eq!(add(sym("a"), down), sub(sym("a"), up));
    }

    #[test]
    fn a_negative_multiplier_on_the_left_also_flips() {
        let stepped = generate_expression("*", imm(-32), sym("k"));
        assert_eq!(shown(add(sym("a"), stepped)), "a - 32 * k");
    }

    #[test]
    fn a_negative_step_cancels_its_positive_spelling() {
        let down = generate_expression("*", sym("k"), imm(-32));
        let up = generate_expression("*", sym("k"), imm(32));
        assert_eq!(shown(add(add(sym("a"), down), up)), "a");
    }

    #[test]
    fn cancellation_does_not_reach_across_a_multiply() {
        let p = generate_expression("*", sub(sym("x"), sym("x")), sym("b"));
        assert_eq!(shown(p), "0 * b");
    }
}

pub fn subexpressions(e: &AbstractExpression) -> Vec<AbstractExpression> {
    let mut found = vec![e.clone()];
    if let AbstractExpression::Expression(_, left, right) = e {
        found.extend(subexpressions(left));
        found.extend(subexpressions(right));
    }
    found
}

pub fn replaced(
    e: &AbstractExpression,
    target: &AbstractExpression,
    with: &AbstractExpression,
) -> AbstractExpression {
    if e == target {
        return with.clone();
    }
    match e {
        AbstractExpression::Expression(op, left, right) => generate_expression(
            op,
            replaced(left, target, with),
            replaced(right, target, with),
        ),
        other => other.clone(),
    }
}
