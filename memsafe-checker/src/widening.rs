use crate::common::*;
use std::collections::BTreeMap;
use std::fmt;

#[derive(Debug, Clone, PartialEq)]
pub struct LinearForm {
    pub constant: i64,
    pub terms: BTreeMap<String, i64>,
}

impl LinearForm {
    fn constant(value: i64) -> Self {
        Self {
            constant: value,
            terms: BTreeMap::new(),
        }
    }

    fn symbol(name: &str) -> Self {
        Self {
            constant: 0,
            terms: BTreeMap::from([(name.to_string(), 1)]),
        }
    }

    fn combine(&self, other: &LinearForm, sign: i64) -> Option<LinearForm> {
        let mut terms = self.terms.clone();
        for (name, coefficient) in &other.terms {
            let entry = terms.entry(name.clone()).or_insert(0);
            *entry = entry.checked_add(coefficient.checked_mul(sign)?)?;
        }
        terms.retain(|_, c| *c != 0);
        Some(LinearForm {
            constant: self
                .constant
                .checked_add(other.constant.checked_mul(sign)?)?,
            terms,
        })
    }

    fn scaled(&self, factor: i64) -> Option<LinearForm> {
        let mut terms = BTreeMap::new();
        for (name, coefficient) in &self.terms {
            let scaled = coefficient.checked_mul(factor)?;
            if scaled != 0 {
                terms.insert(name.clone(), scaled);
            }
        }
        Some(LinearForm {
            constant: self.constant.checked_mul(factor)?,
            terms,
        })
    }
}

pub fn linear_form(e: &AbstractExpression) -> Option<LinearForm> {
    match e {
        AbstractExpression::Immediate(value) => Some(LinearForm::constant(*value)),
        AbstractExpression::Abstract(name) => Some(LinearForm::symbol(name)),
        AbstractExpression::Register(register) => register_form(register),
        AbstractExpression::Expression(op, a, b) => {
            let (left, right) = (linear_form(a)?, linear_form(b)?);
            match op.as_str() {
                "+" => left.combine(&right, 1),
                "-" => left.combine(&right, -1),
                "*" if right.terms.is_empty() => left.scaled(right.constant),
                "*" if left.terms.is_empty() => right.scaled(left.constant),
                "lsl" if right.terms.is_empty() && (0..62).contains(&right.constant) => {
                    left.scaled(1i64 << right.constant)
                }
                _ => None,
            }
        }
        _ => None,
    }
}

#[derive(Debug, Clone)]
struct RationalForm {
    constant: i128,
    terms: BTreeMap<String, i128>,
    atoms: BTreeMap<String, AbstractExpression>,
    denominator: i128,
}

impl RationalForm {
    fn constant(value: i128) -> Self {
        Self {
            constant: value,
            terms: BTreeMap::new(),
            atoms: BTreeMap::new(),
            denominator: 1,
        }
    }

    fn atom(e: &AbstractExpression) -> Self {
        let key = match e {
            AbstractExpression::Abstract(name) => name.clone(),
            other => format!("({other})"),
        };
        Self {
            constant: 0,
            terms: BTreeMap::from([(key.clone(), 1)]),
            atoms: BTreeMap::from([(key, e.clone())]),
            denominator: 1,
        }
    }

    fn integral_constant(&self) -> Option<i128> {
        (self.terms.is_empty() && self.denominator == 1).then_some(self.constant)
    }

    fn scaled(&self, factor: i128) -> Option<Self> {
        let mut terms = BTreeMap::new();
        for (name, coefficient) in &self.terms {
            let scaled = coefficient.checked_mul(factor)?;
            if scaled != 0 {
                terms.insert(name.clone(), scaled);
            }
        }
        Some(Self {
            constant: self.constant.checked_mul(factor)?,
            terms,
            atoms: self.atoms.clone(),
            denominator: self.denominator,
        })
    }

    fn combine(&self, other: &Self, sign: i128) -> Option<Self> {
        let left = self.scaled(other.denominator)?;
        let right = other.scaled(self.denominator.checked_mul(sign)?)?;
        let mut terms = left.terms;
        for (name, coefficient) in right.terms {
            let entry = terms.entry(name).or_insert(0);
            *entry = entry.checked_add(coefficient)?;
        }
        terms.retain(|_, c| *c != 0);
        let mut atoms = left.atoms;
        atoms.extend(right.atoms);
        Some(Self {
            constant: left.constant.checked_add(right.constant)?,
            terms,
            atoms,
            denominator: self.denominator.checked_mul(other.denominator)?,
        })
    }

    fn quotient_assuming_exact(&self, divisor: i128) -> Option<Self> {
        if divisor <= 0 || self.denominator != 1 {
            return None;
        }
        let whole = self.constant.div_euclid(divisor);
        let symbolic = Self {
            constant: 0,
            terms: self.terms.clone(),
            atoms: self.atoms.clone(),
            denominator: divisor,
        };
        symbolic.combine(&Self::constant(whole), 1)
    }

    fn to_integral_expression(&self) -> Option<AbstractExpression> {
        let exact = |n: i128| {
            (n % self.denominator == 0)
                .then(|| i64::try_from(n / self.denominator).ok())
                .flatten()
        };
        let mut sum: Option<AbstractExpression> = None;
        for (key, coefficient) in &self.terms {
            let coefficient = exact(*coefficient)?;
            let atom = self.atoms.get(key)?.clone();
            let term = match coefficient {
                1 => atom,
                _ => generate_expression("*", atom, AbstractExpression::Immediate(coefficient)),
            };
            sum = Some(match sum {
                None => term,
                Some(sum) => generate_expression("+", sum, term),
            });
        }
        let constant = AbstractExpression::Immediate(exact(self.constant)?);
        Some(match sum {
            None => constant,
            Some(sum) => generate_expression("+", sum, constant),
        })
    }
}

fn rational_form(e: &AbstractExpression) -> Option<RationalForm> {
    match e {
        AbstractExpression::Immediate(value) => Some(RationalForm::constant(*value as i128)),
        AbstractExpression::Register(register) => match &register.base {
            None if register.kind == RegisterKind::Number => None,
            None => Some(RationalForm::constant(register.offset as i128)),
            Some(base) => {
                rational_form(base)?.combine(&RationalForm::constant(register.offset as i128), 1)
            }
        },
        AbstractExpression::Expression(op, a, b) => {
            let (left, right) = (rational_form(a)?, rational_form(b)?);
            let shift = right
                .integral_constant()
                .filter(|k| (0..62).contains(k))
                .map(|k| 1i128 << k);
            let positive = right.integral_constant().filter(|d| *d > 0);
            let decomposed = match op.as_str() {
                "+" => left.combine(&right, 1),
                "-" => left.combine(&right, -1),
                "*" => match (left.integral_constant(), right.integral_constant()) {
                    (_, Some(factor)) => left.scaled(factor),
                    (Some(factor), _) => right.scaled(factor),
                    _ => None,
                },
                "lsl" => shift.and_then(|s| left.scaled(s)),
                "lsr" | ">>" => shift.and_then(|s| left.quotient_assuming_exact(s)),
                "/" => positive.and_then(|d| left.quotient_assuming_exact(d)),
                "%" if positive.is_some() => Some(left),
                "sext" | "zext" if positive.is_some() => Some(left),
                _ => None,
            };
            Some(decomposed.unwrap_or_else(|| RationalForm::atom(e)))
        }
        other => Some(RationalForm::atom(other)),
    }
}

pub fn greatest_common_divisor(a: u64, b: u64) -> u64 {
    if b == 0 {
        a
    } else {
        greatest_common_divisor(b, a % b)
    }
}

pub fn mentions_a_quotient(e: &AbstractExpression) -> bool {
    match e {
        AbstractExpression::Expression(op, a, b) => {
            matches!(op.as_str(), "/" | "lsr" | ">>" | "%")
                || mentions_a_quotient(a)
                || mentions_a_quotient(b)
        }
        AbstractExpression::Register(register) => {
            register.base.as_ref().is_some_and(mentions_a_quotient)
        }
        _ => false,
    }
}

pub fn exact_arithmetic_candidate(e: &AbstractExpression) -> Option<AbstractExpression> {
    rational_form(e)?.to_integral_expression()
}

fn register_form(register: &RegisterValue) -> Option<LinearForm> {
    match &register.base {
        None if register.kind == RegisterKind::Number => None,
        None => Some(LinearForm::constant(register.offset)),
        Some(base) => linear_form(base)?.combine(&LinearForm::constant(register.offset), 1),
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct Affine {
    pub constant: i64,
    pub terms: Vec<(AbstractExpression, i64)>,
}

impl Affine {
    fn atom(e: &AbstractExpression) -> Self {
        Self {
            constant: 0,
            terms: vec![(e.clone(), 1)],
        }
    }

    fn number(value: i64) -> Self {
        Self {
            constant: value,
            terms: Vec::new(),
        }
    }

    pub fn of(e: &AbstractExpression) -> Option<Affine> {
        match e {
            AbstractExpression::Immediate(value) => Some(Affine::number(*value)),
            AbstractExpression::Register(register) => Affine::of_register(register),
            AbstractExpression::Expression(op, a, b) => {
                let (left, right) = (Affine::of(a)?, Affine::of(b)?);
                match op.as_str() {
                    "+" => left.combine(&right, 1),
                    "-" => left.combine(&right, -1),
                    "*" if right.terms.is_empty() => left.scaled(right.constant),
                    "*" if left.terms.is_empty() => right.scaled(left.constant),
                    "/" if right.terms.is_empty() && right.constant > 0 => Some(
                        Affine::quotient_with_whole_part_outside(&left, right.constant),
                    ),
                    _ => Some(Affine::atom(e)),
                }
            }
            other => Some(Affine::atom(other)),
        }
    }

    fn quotient_with_whole_part_outside(dividend: &Affine, divisor: i64) -> Affine {
        let whole = dividend.constant.div_euclid(divisor);
        let remainder = dividend.constant.rem_euclid(divisor);
        if dividend.terms.is_empty() {
            return Affine::number(whole);
        }
        let reduced = Affine {
            constant: remainder,
            terms: dividend.terms.clone(),
        };
        Affine {
            constant: whole,
            terms: vec![(
                generate_expression(
                    "/",
                    reduced.to_expression(),
                    AbstractExpression::Immediate(divisor),
                ),
                1,
            )],
        }
    }

    pub fn of_register(register: &RegisterValue) -> Option<Affine> {
        match &register.base {
            None if register.kind == RegisterKind::Number => None,
            None => Some(Affine::number(register.offset)),
            Some(base) => Affine::of(base)?.combine(&Affine::number(register.offset), 1),
        }
    }

    pub fn combine(&self, other: &Affine, sign: i64) -> Option<Affine> {
        let mut terms = self.terms.clone();
        for (atom, coefficient) in &other.terms {
            let moved = coefficient.checked_mul(sign)?;
            match terms.iter_mut().find(|(known, _)| known == atom) {
                Some((_, total)) => *total = total.checked_add(moved)?,
                None => terms.push((atom.clone(), moved)),
            }
        }
        terms.retain(|(_, coefficient)| *coefficient != 0);
        Some(Affine {
            constant: self
                .constant
                .checked_add(other.constant.checked_mul(sign)?)?,
            terms,
        })
    }

    pub fn scaled(&self, factor: i64) -> Option<Affine> {
        let mut terms = Vec::new();
        for (atom, coefficient) in &self.terms {
            let scaled = coefficient.checked_mul(factor)?;
            if scaled != 0 {
                terms.push((atom.clone(), scaled));
            }
        }
        Some(Affine {
            constant: self.constant.checked_mul(factor)?,
            terms,
        })
    }

    pub fn coefficient(&self, atom: &AbstractExpression) -> i64 {
        self.terms
            .iter()
            .find(|(known, _)| known == atom)
            .map_or(0, |(_, coefficient)| *coefficient)
    }

    pub fn without(&self, atom: &AbstractExpression) -> Affine {
        Affine {
            constant: self.constant,
            terms: self
                .terms
                .iter()
                .filter(|(known, _)| known != atom)
                .cloned()
                .collect(),
        }
    }

    pub fn mentions_only_as_term(&self, atom: &AbstractExpression) -> bool {
        let AbstractExpression::Abstract(name) = atom else {
            return false;
        };
        self.terms
            .iter()
            .all(|(known, _)| known == atom || !known.contains(name))
    }

    pub fn to_register(&self) -> RegisterValue {
        let mut base: Option<AbstractExpression> = None;
        for (atom, coefficient) in &self.terms {
            let magnitude = match coefficient.unsigned_abs() {
                1 => atom.clone(),
                n => {
                    generate_expression("*", atom.clone(), AbstractExpression::Immediate(n as i64))
                }
            };
            base = Some(match (base, *coefficient > 0) {
                (None, true) => magnitude,
                (None, false) => {
                    generate_expression("-", AbstractExpression::Immediate(0), magnitude)
                }
                (Some(sum), true) => generate_expression("+", sum, magnitude),
                (Some(sum), false) => generate_expression("-", sum, magnitude),
            });
        }
        match base {
            Some(base) => RegisterValue::new(RegisterKind::RegisterBase, Some(base), self.constant),
            None => RegisterValue::new_imm(self.constant),
        }
    }

    pub fn to_expression(&self) -> AbstractExpression {
        expression_of_register(&self.to_register())
    }

    pub fn mentions_a_loop_counter(&self) -> bool {
        self.terms.iter().any(|(atom, _)| {
            atom.get_abstracts()
                .iter()
                .any(|name| LoopSymbol::names_any(name))
        })
    }

    pub fn without_terms_tied_to(&self, seeds: &[String]) -> Affine {
        let mut tied: Vec<String> = seeds.to_vec();
        loop {
            let known = tied.len();
            for (atom, _) in &self.terms {
                let symbols = atom.get_abstracts();
                if symbols.iter().any(|symbol| tied.contains(symbol)) {
                    for symbol in symbols {
                        if !tied.contains(&symbol) {
                            tied.push(symbol);
                        }
                    }
                }
            }
            if tied.len() == known {
                break;
            }
        }
        Affine {
            constant: self.constant,
            terms: self
                .terms
                .iter()
                .filter(|(atom, _)| !atom.get_abstracts().iter().any(|s| tied.contains(s)))
                .cloned()
                .collect(),
        }
    }
}

fn expression_of_register(register: &RegisterValue) -> AbstractExpression {
    match (&register.base, register.offset) {
        (Some(base), 0) => base.clone(),
        (Some(base), offset) => {
            generate_expression("+", base.clone(), AbstractExpression::Immediate(offset))
        }
        (None, offset) => AbstractExpression::Immediate(offset),
    }
}

pub fn counter_value_at_exit(
    counter: &AbstractExpression,
    exit: &Affine,
) -> Option<AbstractExpression> {
    let unit = exit.coefficient(counter);
    if unit == 0 || !exit.mentions_only_as_term(counter) {
        return None;
    }
    let rest = exit
        .without(counter)
        .scaled(-unit.signum())?
        .to_expression();
    Some(match unit.abs() {
        1 => rest,
        divisor => generate_expression("/", rest, AbstractExpression::Immediate(divisor)),
    })
}

pub fn step_form(prev: &RegisterValue, cur: &RegisterValue) -> Option<LinearForm> {
    register_form(cur)?.combine(&register_form(prev)?, -1)
}

pub fn proportion(follower: &LinearForm, leader: &LinearForm) -> Option<i64> {
    let (name, &unit) = leader.terms.iter().next()?;
    let &moved = follower.terms.get(name)?;
    if moved % unit != 0 {
        return None;
    }
    let k = moved / unit;
    (k != 0 && leader.scaled(k)? == *follower).then_some(k)
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct LoopId(usize);

impl LoopId {
    pub fn new(n: usize) -> Self {
        Self(n)
    }
}

impl fmt::Display for LoopId {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "loop{}", self.0)
    }
}

pub const STATUS_FLAGS: [&str; 4] = ["zero", "neg", "carry", "overflow"];

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum LoopRole {
    Counter,
    Trips(Option<usize>),
    Progress(usize),
    CellProgress(usize),
    Within(usize),
    Widened(usize),
    Flag(usize),
    Status(usize),
    Latest(usize),
    Offset(usize),
    Cell(usize),
    Any,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct LoopSymbol {
    pub id: LoopId,
    pub role: LoopRole,
}

impl LoopSymbol {
    pub fn new(id: LoopId, role: LoopRole) -> Self {
        Self { id, role }
    }

    pub fn expression(&self) -> AbstractExpression {
        AbstractExpression::Abstract(self.to_string())
    }

    pub fn parse(name: &str) -> Option<Self> {
        let (number, role) = name.strip_prefix("loop")?.split_once("_?")?;
        let id = LoopId::new(number.parse().ok()?);
        let indexed = |prefix: &str| role.strip_prefix(prefix)?.parse::<usize>().ok();
        let role = match role {
            "" => LoopRole::Counter,
            "_trips" => LoopRole::Trips(None),
            "_any" => LoopRole::Any,
            _ => {
                if let Some(exit) = indexed("_trips") {
                    LoopRole::Trips(Some(exit))
                } else if let Some(i) = indexed("_progress_") {
                    LoopRole::Progress(i)
                } else if let Some(k) = indexed("_cell_progress_") {
                    LoopRole::CellProgress(k)
                } else if let Some(i) = indexed("_within_") {
                    LoopRole::Within(i)
                } else if let Some(i) = indexed("_widened_") {
                    LoopRole::Widened(i)
                } else if let Some(k) = indexed("_flag_") {
                    LoopRole::Flag(k)
                } else if let Some(i) = indexed("_latest_") {
                    LoopRole::Latest(i)
                } else if let Some(i) = indexed("_offset_") {
                    LoopRole::Offset(i)
                } else if let Some(k) = indexed("_cell_") {
                    LoopRole::Cell(k)
                } else {
                    let status = role.strip_prefix('_')?;
                    LoopRole::Status(STATUS_FLAGS.iter().position(|flag| *flag == status)?)
                }
            }
        };
        let symbol = Self::new(id, role);
        (symbol.to_string() == name).then_some(symbol)
    }

    pub fn names_any(name: &str) -> bool {
        Self::parse(name).is_some()
    }

    pub fn names_of(name: &str, id: LoopId) -> bool {
        Self::parse(name).is_some_and(|symbol| symbol.id == id)
    }
}

impl fmt::Display for LoopSymbol {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}_?", self.id)?;
        match self.role {
            LoopRole::Counter => Ok(()),
            LoopRole::Trips(None) => write!(f, "_trips"),
            LoopRole::Trips(Some(exit)) => write!(f, "_trips{exit}"),
            LoopRole::Progress(i) => write!(f, "_progress_{i}"),
            LoopRole::CellProgress(k) => write!(f, "_cell_progress_{k}"),
            LoopRole::Within(i) => write!(f, "_within_{i}"),
            LoopRole::Widened(i) => write!(f, "_widened_{i}"),
            LoopRole::Flag(k) => write!(f, "_flag_{k}"),
            LoopRole::Status(k) => write!(f, "_{}", STATUS_FLAGS[k]),
            LoopRole::Latest(i) => write!(f, "_latest_{i}"),
            LoopRole::Offset(i) => write!(f, "_offset_{i}"),
            LoopRole::Cell(k) => write!(f, "_cell_{k}"),
            LoopRole::Any => write!(f, "_any"),
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct LoopCounter {
    id: LoopId,
    name: String,
}

impl LoopCounter {
    pub fn for_loop(id: LoopId) -> Self {
        Self {
            id,
            name: LoopSymbol::new(id, LoopRole::Counter).to_string(),
        }
    }

    pub fn id(&self) -> LoopId {
        self.id
    }

    pub fn name(&self) -> &str {
        &self.name
    }

    pub fn expression(&self) -> AbstractExpression {
        AbstractExpression::Abstract(self.name.clone())
    }

    pub fn next_iteration(&self) -> AbstractExpression {
        generate_expression("+", self.expression(), AbstractExpression::Immediate(1))
    }

    pub fn symbol(&self, role: LoopRole) -> LoopSymbol {
        LoopSymbol::new(self.id, role)
    }

    pub fn total(&self) -> AbstractExpression {
        self.symbol(LoopRole::Trips(None)).expression()
    }

    pub fn total_for(&self, exit: usize) -> AbstractExpression {
        self.symbol(LoopRole::Trips(Some(exit))).expression()
    }
}

pub const DERIVED_LEADER: &str = "derived_leader";

#[derive(Debug, Clone, PartialEq)]
pub enum LoopInvariant {
    Fixed,
    Linear(AbstractExpression),
    AtMost(i64),
    Ranged(i64, i64),
    Within(i64),
    Tracks(usize, i64),
    Derived(usize, AbstractExpression),
    NonDecreasing,
    NonIncreasing,
    Geometric(i64),
    Unknown,
}

impl LoopInvariant {
    fn reach(&self) -> Option<i64> {
        match self {
            LoopInvariant::Fixed => Some(0),
            LoopInvariant::Linear(AbstractExpression::Immediate(step)) => Some(*step),
            LoopInvariant::AtMost(bound) => Some(*bound),
            _ => None,
        }
    }

    fn step_range(&self) -> Option<(i64, i64)> {
        match self {
            LoopInvariant::Fixed => Some((0, 0)),
            LoopInvariant::Linear(AbstractExpression::Immediate(step)) => Some((*step, *step)),
            LoopInvariant::AtMost(bound) => Some((0, *bound)),
            LoopInvariant::Ranged(low, high) => Some((*low, *high)),
            _ => None,
        }
    }

    pub fn subsumes(&self, other: &LoopInvariant) -> bool {
        if matches!(self, LoopInvariant::Unknown) || self == other {
            return true;
        }
        match (self, other) {
            (LoopInvariant::Ranged(low, high), _) => other
                .step_range()
                .is_some_and(|(l, h)| *low <= l && h <= *high),
            (LoopInvariant::AtMost(bound), LoopInvariant::Ranged(low, high)) => {
                *low >= 0 && high <= bound
            }
            (LoopInvariant::NonDecreasing, LoopInvariant::Ranged(low, _)) => *low >= 0,
            (LoopInvariant::NonIncreasing, LoopInvariant::Ranged(_, high)) => *high <= 0,
            (LoopInvariant::Within(bound), LoopInvariant::Within(seen)) => seen <= bound,
            (LoopInvariant::Within(_), LoopInvariant::Fixed) => true,
            (LoopInvariant::Fixed, _) => other.reach() == Some(0),
            (LoopInvariant::AtMost(bound), _) => other
                .reach()
                .is_some_and(|step| (0..=*bound).contains(&step)),
            (LoopInvariant::NonDecreasing, LoopInvariant::AtMost(_)) => true,
            (LoopInvariant::NonDecreasing, _) => other.reach().is_some_and(|step| step >= 0),
            (LoopInvariant::NonIncreasing, _) => other.reach().is_some_and(|step| step <= 0),
            _ => false,
        }
    }

    pub fn join(&self, other: &LoopInvariant) -> LoopInvariant {
        if self == other {
            return self.clone();
        }
        let ranged =
            matches!(self, LoopInvariant::Ranged(..)) || matches!(other, LoopInvariant::Ranged(..));
        match (ranged, self.step_range(), other.step_range()) {
            (true, Some((a, b)), Some((c, d))) => LoopInvariant::Ranged(a.min(c), b.max(d)),
            _ => LoopInvariant::Unknown,
        }
    }
}

fn constant_step(prev: &AbstractExpression, cur: &AbstractExpression) -> Option<i64> {
    if let AbstractExpression::Expression(op, left, right) = cur
        && op == "+"
        && **left == *prev
        && let AbstractExpression::Immediate(k) = **right
    {
        return Some(k);
    }
    None
}

pub fn invariant_of(prev: &AbstractExpression, cur: &AbstractExpression) -> LoopInvariant {
    if prev == cur {
        return LoopInvariant::Fixed;
    }
    match constant_step(prev, cur) {
        Some(0) => LoopInvariant::Fixed,
        Some(step) => LoopInvariant::Linear(AbstractExpression::Immediate(step)),
        None => LoopInvariant::Unknown,
    }
}

fn split_constant(e: &AbstractExpression) -> Option<(&AbstractExpression, i64)> {
    match e {
        AbstractExpression::Expression(op, core, constant) if op == "+" || op == "-" => {
            let AbstractExpression::Immediate(c) = **constant else {
                return Some((e, 0));
            };
            let (core, k) = split_constant(core)?;
            let c = if op == "+" { c } else { c.checked_neg()? };
            Some((core, k.checked_add(c)?))
        }
        _ => Some((e, 0)),
    }
}

fn narrowed_step(prev: &AbstractExpression, cur: &AbstractExpression) -> Option<i64> {
    let (
        AbstractExpression::Expression(_, prev_inner, _),
        AbstractExpression::Expression(_, cur_inner, _),
    ) = (prev, cur)
    else {
        return None;
    };
    if !is_narrowed(prev) || !is_narrowed(cur) {
        return None;
    }
    let (prev_core, prev_constant) = split_constant(prev_inner)?;
    let (cur_core, cur_constant) = split_constant(cur_inner)?;
    (prev_core == cur_core).then_some(cur_constant.checked_sub(prev_constant)?)
}

fn symbolic_step(
    prev: &AbstractExpression,
    cur: &AbstractExpression,
) -> Option<AbstractExpression> {
    if let Some(step) = narrowed_step(prev, cur) {
        return Some(AbstractExpression::Immediate(step));
    }
    if let (
        AbstractExpression::Expression(_, prev_inner, _),
        AbstractExpression::Expression(_, cur_inner, _),
    ) = (prev, cur)
        && is_narrowed(prev)
        && is_narrowed(cur)
    {
        let step = Affine::of(cur_inner)?.combine(&Affine::of(prev_inner)?, -1)?;
        let over_symbols = step
            .terms
            .iter()
            .all(|(atom, _)| matches!(atom, AbstractExpression::Abstract(_)));
        return (over_symbols && !step.terms.is_empty() && !step.mentions_a_loop_counter())
            .then(|| step.to_expression());
    }
    let cur = match cur {
        AbstractExpression::Expression(op, inner, _) if op == "%" && is_narrowed(cur) => &**inner,
        other => other,
    };
    if let AbstractExpression::Expression(op, left, right) = cur
        && **left == *prev
    {
        return match op.as_str() {
            "+" => Some((**right).clone()),
            "-" => Some(generate_expression(
                "-",
                AbstractExpression::Immediate(0),
                (**right).clone(),
            )),
            _ => None,
        };
    }
    if let (
        AbstractExpression::Expression(prev_op, prev_left, prev_right),
        AbstractExpression::Expression(cur_op, cur_left, cur_right),
    ) = (prev, cur)
        && prev_op == cur_op
    {
        if prev_right == cur_right && (prev_op == "+" || prev_op == "-") {
            return symbolic_step(prev_left, cur_left);
        }
        if prev_left == cur_left && prev_op == "+" {
            return symbolic_step(prev_right, cur_right);
        }
        if prev_left == cur_left && prev_op == "-" {
            return symbolic_step(prev_right, cur_right)
                .map(|step| generate_expression("-", AbstractExpression::Immediate(0), step));
        }
    }
    let step = Affine::of(cur)?.combine(&Affine::of(prev)?, -1)?;
    (!step.terms.is_empty() && !step.mentions_a_loop_counter()).then(|| step.to_expression())
}

pub fn invariant_of_register(prev: &RegisterValue, cur: &RegisterValue) -> LoopInvariant {
    if prev.kind == RegisterKind::Number || cur.kind == RegisterKind::Number {
        return if prev == cur {
            LoopInvariant::Fixed
        } else {
            LoopInvariant::Unknown
        };
    }
    if prev.base != cur.base {
        if prev.offset == cur.offset
            && let (Some(p), Some(c)) = (&prev.base, &cur.base)
            && let Some(step) = symbolic_step(p, c)
            && !step.contains_expression(p)
        {
            return LoopInvariant::Linear(step);
        }
        if let Some(divisor) = geometric_step(prev, cur) {
            return LoopInvariant::Geometric(divisor);
        }
        return LoopInvariant::Unknown;
    }
    match cur.offset.checked_sub(prev.offset) {
        Some(0) => LoopInvariant::Fixed,
        Some(step) => LoopInvariant::Linear(AbstractExpression::Immediate(step)),
        None => LoopInvariant::Unknown,
    }
}

fn narrowing_core(e: &AbstractExpression) -> (&AbstractExpression, bool) {
    match e {
        AbstractExpression::Expression(_, inner, _) if is_narrowed(e) => {
            (narrowing_core(inner).0, true)
        }
        other => (other, false),
    }
}

pub fn geometric_step(prev: &RegisterValue, cur: &RegisterValue) -> Option<i64> {
    if prev.offset != 0 || cur.offset != 0 {
        return None;
    }
    let before = narrowing_core(prev.base.as_ref()?);
    let AbstractExpression::Expression(op, operand, amount) = narrowing_core(cur.base.as_ref()?).0
    else {
        return None;
    };
    let (core, narrowed) = narrowing_core(operand);
    if core != before.0 || (before.1 && !narrowed) {
        return None;
    }
    match (op.as_str(), &**amount) {
        ("lsr" | ">>", AbstractExpression::Immediate(bits)) if (1..=62).contains(bits) => {
            Some(1i64 << bits)
        }
        ("/", AbstractExpression::Immediate(k)) if *k >= 2 => Some(*k),
        _ => None,
    }
}

pub fn divisions_to_zero(bound: i64, divisor: i64) -> Option<i64> {
    if bound < 0 || divisor < 2 {
        return None;
    }
    let (mut left, mut steps) = (bound, 0);
    while left > 0 {
        left /= divisor;
        steps += 1;
    }
    Some(steps)
}

pub fn unsigned_range(e: &AbstractExpression) -> Option<(i64, i64)> {
    let bits_of = |high: i64| 64 - (high as u64).leading_zeros() as i64;
    match e {
        AbstractExpression::Immediate(v) => Some((*v, *v)),
        AbstractExpression::Register(register) => match (&register.kind, &register.base) {
            (RegisterKind::Immediate, _) => Some((register.offset, register.offset)),
            (RegisterKind::RegisterBase, Some(base)) => {
                let (low, high) = unsigned_range(base)?;
                Some((
                    low.checked_add(register.offset)?,
                    high.checked_add(register.offset)?,
                ))
            }
            _ => None,
        },
        AbstractExpression::Expression(op, left, right) => {
            let constant = |side: &AbstractExpression| match side {
                AbstractExpression::Immediate(v) => Some(*v),
                _ => None,
            };
            match op.as_str() {
                "atmost" => {
                    let high = constant(right)?;
                    let (low, inner_high) = unsigned_range(left)
                        .or_else(|| at_least(left).map(|low| (low, i64::MAX)))?;
                    Some((low.min(high), inner_high.min(high)))
                }
                "atleast" => {
                    let low = constant(right)?;
                    let high = unsigned_range(left).map_or(i64::MAX, |(_, h)| h);
                    Some((low, high.max(low)))
                }
                "%" => {
                    let m = constant(right).filter(|m| *m > 0)?;
                    let high = unsigned_range(left)
                        .filter(|(low, _)| *low >= 0)
                        .map_or(m - 1, |(_, h)| h.min(m - 1));
                    Some((0, high))
                }
                "lsr" | ">>" => {
                    let shift = constant(right).filter(|s| (0..63).contains(s))?;
                    let (low, high) = unsigned_range(left).filter(|(low, _)| *low >= 0)?;
                    Some((low >> shift, high >> shift))
                }
                "&" => {
                    let masks: Vec<i64> = [left, right]
                        .into_iter()
                        .filter_map(|side| unsigned_range(side).filter(|(low, _)| *low >= 0))
                        .map(|(_, high)| high)
                        .collect();
                    masks.into_iter().min().map(|high| (0, high))
                }
                "|" | "^" => {
                    let (_, a) = unsigned_range(left).filter(|(low, _)| *low >= 0)?;
                    let (_, b) = unsigned_range(right).filter(|(low, _)| *low >= 0)?;
                    let bits = bits_of(a.max(b));
                    (bits < 63).then(|| (0, (1i64 << bits) - 1))
                }
                "+" => {
                    let (a, b) = unsigned_range(left)?;
                    let (c, d) = unsigned_range(right)?;
                    Some((a.checked_add(c)?, b.checked_add(d)?))
                }
                _ => None,
            }
        }
        _ => None,
    }
}

fn at_least(e: &AbstractExpression) -> Option<i64> {
    match e {
        AbstractExpression::Expression(op, _, right) if op == "atleast" => match **right {
            AbstractExpression::Immediate(v) => Some(v),
            _ => None,
        },
        _ => None,
    }
}

pub fn upper_bound_of(e: &AbstractExpression) -> Option<i64> {
    let AbstractExpression::Expression(op, inner, right) = e else {
        return match e {
            AbstractExpression::Immediate(v) => Some(*v),
            _ => None,
        };
    };
    let within = upper_bound_of(inner);
    match (op.as_str(), &**right) {
        ("%", AbstractExpression::Immediate(m)) if *m > 0 => {
            Some(within.filter(|w| *w >= 0).map_or(m - 1, |w| w.min(m - 1)))
        }
        ("lsr" | ">>", AbstractExpression::Immediate(bits)) if (0..63).contains(bits) => {
            within.map(|w| w >> bits)
        }
        ("atmost", AbstractExpression::Immediate(h)) => Some(within.map_or(*h, |w| w.min(*h))),
        _ => None,
    }
}

pub fn join_all(a: &[LoopInvariant], b: &[LoopInvariant]) -> Vec<LoopInvariant> {
    a.iter().zip(b.iter()).map(|(x, y)| x.join(y)).collect()
}

pub fn max_ascents(components: usize) -> usize {
    components
}

pub fn drift_of_registers(prev: &[RegisterValue], cur: &[RegisterValue]) -> Vec<LoopInvariant> {
    prev.iter()
        .zip(cur.iter())
        .map(|(p, c)| match invariant_of_register(p, c) {
            LoopInvariant::Unknown
                if p.kind != RegisterKind::Number && c.kind != RegisterKind::Number =>
            {
                match (&p.base, &c.base) {
                    (Some(before), Some(after)) => symbolic_step(before, after)
                        .zip(c.offset.checked_sub(p.offset))
                        .map_or(LoopInvariant::Unknown, |(step, moved)| {
                            LoopInvariant::Linear(generate_expression(
                                "+",
                                step,
                                AbstractExpression::Immediate(moved),
                            ))
                        }),
                    _ => LoopInvariant::Unknown,
                }
            }
            other => other,
        })
        .collect()
}

pub fn invariant_of_registers(prev: &[RegisterValue], cur: &[RegisterValue]) -> Vec<LoopInvariant> {
    prev.iter()
        .zip(cur.iter())
        .map(|(p, c)| invariant_of_register(p, c))
        .collect()
}

pub fn widen_flag(
    name: &str,
    prev: &Option<FlagValue>,
    cur: &Option<FlagValue>,
) -> Option<FlagValue> {
    match cur {
        Some(_) if prev != cur => Some(FlagValue::Abstract(AbstractComparison::new(
            "==",
            AbstractExpression::Abstract(name.to_string()),
            AbstractExpression::Immediate(0),
        ))),
        _ => cur.clone(),
    }
}

pub fn advance(
    anchor: AbstractExpression,
    step: &AbstractExpression,
    counter: &LoopCounter,
) -> AbstractExpression {
    generate_expression(
        "+",
        anchor,
        generate_expression("*", counter.expression(), step.clone()),
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    fn base() -> AbstractExpression {
        AbstractExpression::Abstract("base".to_string())
    }

    fn counter() -> LoopCounter {
        LoopCounter::for_loop(LoopId::new(0))
    }

    fn symbol(name: &str) -> AbstractExpression {
        AbstractExpression::Abstract(name.to_string())
    }

    fn number(value: i64) -> AbstractExpression {
        AbstractExpression::Immediate(value)
    }

    #[test]
    fn quotients_by_a_constant_share_one_atom_whatever_their_offset() {
        let quarter = |offset: i64| {
            generate_expression(
                "/",
                generate_expression("+", symbol("w"), number(offset)),
                number(4),
            )
        };
        let w_over_4 = Affine::of(&quarter(0)).expect("affine");
        let eight_less = Affine::of(&quarter(-8)).expect("affine");
        assert_eq!(eight_less.terms, w_over_4.terms);
        assert_eq!(eight_less.constant, -2);
        let one_less = Affine::of(&quarter(-1)).expect("affine");
        let three_more = Affine::of(&quarter(3)).expect("affine");
        assert_eq!(one_less.terms, three_more.terms);
        assert_eq!(one_less.constant, -1);
        assert_eq!(three_more.constant, 0);
        assert_eq!(
            Affine::of(&generate_expression("/", number(-9), number(4)))
                .expect("affine")
                .constant,
            -3
        );
    }

    #[test]
    fn exact_arithmetic_folds_a_row_step_back_to_its_stride() {
        let wrapped_stride = generate_expression(
            "%",
            generate_expression("+", symbol("stride"), number(1 << 31)),
            number(1 << 32),
        );
        let columns_walked = generate_expression(
            "*",
            generate_expression(
                "/",
                generate_expression("+", symbol("w"), number(-1)),
                number(16),
            ),
            number(64),
        );
        let step = generate_expression(
            "+",
            generate_expression(
                "-",
                generate_expression(
                    "+",
                    generate_expression("-", wrapped_stride, number(1 << 31)),
                    columns_walked,
                ),
                generate_expression("lsl", symbol("w"), number(2)),
            ),
            number(64),
        );
        let candidate = exact_arithmetic_candidate(&step).expect("integral");
        assert_eq!(linear_form(&candidate), linear_form(&symbol("stride")));
    }

    #[test]
    fn exact_arithmetic_declines_a_fractional_quotient() {
        let half = generate_expression("lsr", symbol("w"), number(1));
        assert_eq!(exact_arithmetic_candidate(&half), None);
        let quarter_of_odd = generate_expression(
            "/",
            generate_expression("+", symbol("w"), number(3)),
            number(4),
        );
        let scaled = generate_expression("*", quarter_of_odd, number(4));
        assert_eq!(
            linear_form(&exact_arithmetic_candidate(&scaled).expect("integral")),
            linear_form(&symbol("w"))
        );
    }

    #[test]
    fn loop_symbols_render_and_parse_back() {
        let id = LoopId::new(12);
        for role in [
            LoopRole::Counter,
            LoopRole::Trips(None),
            LoopRole::Trips(Some(40)),
            LoopRole::Progress(3),
            LoopRole::CellProgress(2),
            LoopRole::Within(1),
            LoopRole::Widened(0),
            LoopRole::Flag(2),
            LoopRole::Status(3),
            LoopRole::Latest(5),
            LoopRole::Any,
        ] {
            let symbol = LoopSymbol::new(id, role);
            assert_eq!(LoopSymbol::parse(&symbol.to_string()), Some(symbol));
        }
        assert_eq!(
            LoopSymbol::new(id, LoopRole::Counter).to_string(),
            "loop12_?"
        );
        assert_eq!(
            LoopSymbol::new(id, LoopRole::Status(0)).to_string(),
            "loop12_?_zero"
        );
        for name in [
            "loop",
            "loop12",
            "loaded_3",
            "loop12_?_trips_",
            "loop12_?_flag",
        ] {
            assert_eq!(LoopSymbol::parse(name), None, "{name}");
        }
    }

    #[test]
    fn unchanged_expression_is_fixed() {
        assert_eq!(invariant_of(&base(), &base()), LoopInvariant::Fixed);
    }

    #[test]
    fn constant_offset_is_linear() {
        let cur = generate_expression("+", base(), AbstractExpression::Immediate(4));
        assert_eq!(
            invariant_of(&base(), &cur),
            LoopInvariant::Linear(AbstractExpression::Immediate(4))
        );
    }

    #[test]
    fn a_narrowed_counter_spelled_differently_each_round_still_steps() {
        let masked = generate_expression("&", base(), AbstractExpression::Immediate(0xffff_fffc));
        let word = |op: &str, c: i64| RegisterValue {
            kind: RegisterKind::RegisterBase,
            base: Some(generate_expression(
                "%",
                generate_expression(op, masked.clone(), AbstractExpression::Immediate(c)),
                AbstractExpression::Immediate(1 << 32),
            )),
            offset: -4,
        };
        assert_eq!(
            invariant_of_register(&word("+", -4), &word("-", 8)),
            LoopInvariant::Linear(AbstractExpression::Immediate(-4))
        );
        let other = RegisterValue {
            base: Some(generate_expression(
                "%",
                generate_expression("-", base(), AbstractExpression::Immediate(8)),
                AbstractExpression::Immediate(1 << 32),
            )),
            ..word("-", 8)
        };
        assert_eq!(
            invariant_of_register(&word("+", -4), &other),
            LoopInvariant::Unknown
        );
    }

    #[test]
    fn a_gap_below_an_advancing_pointer_steps_backwards() {
        let end = AbstractExpression::Abstract("end".to_string());
        let walker = generate_expression("+", base(), AbstractExpression::Immediate(32));
        let gap = |walked: AbstractExpression| RegisterValue {
            kind: RegisterKind::RegisterBase,
            base: Some(generate_expression("-", end.clone(), walked)),
            offset: 0,
        };
        assert_eq!(
            invariant_of_register(&gap(base()), &gap(walker)),
            LoopInvariant::Linear(generate_expression(
                "-",
                AbstractExpression::Immediate(0),
                AbstractExpression::Immediate(32)
            ))
        );
    }

    #[test]
    fn zero_step_normalises_to_fixed() {
        let cur = generate_expression("+", base(), AbstractExpression::Immediate(0));
        assert_eq!(invariant_of(&base(), &cur), LoopInvariant::Fixed);
    }

    #[test]
    fn unrelated_expression_is_unknown() {
        let cur = generate_expression("*", base(), base());
        assert_eq!(invariant_of(&base(), &cur), LoopInvariant::Unknown);
    }

    #[test]
    fn register_offset_delta_is_linear() {
        let prev = RegisterValue::new(RegisterKind::RegisterBase, Some(base()), 8);
        let cur = RegisterValue::new(RegisterKind::RegisterBase, Some(base()), 12);
        assert_eq!(
            invariant_of_register(&prev, &cur),
            LoopInvariant::Linear(AbstractExpression::Immediate(4))
        );
    }

    #[test]
    fn register_negative_delta_is_linear() {
        let prev = RegisterValue::new(RegisterKind::RegisterBase, Some(base()), 8);
        let cur = RegisterValue::new(RegisterKind::RegisterBase, Some(base()), 4);
        assert_eq!(
            invariant_of_register(&prev, &cur),
            LoopInvariant::Linear(AbstractExpression::Immediate(-4))
        );
    }

    #[test]
    fn register_stepping_by_a_symbolic_amount_is_linear() {
        let stride = AbstractExpression::Abstract("r".to_string());
        let prev = RegisterValue::new(RegisterKind::RegisterBase, Some(base()), 0);
        let cur = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression("-", base(), stride.clone())),
            0,
        );
        assert_eq!(
            invariant_of_register(&prev, &cur),
            LoopInvariant::Linear(generate_expression(
                "-",
                AbstractExpression::Immediate(0),
                stride
            ))
        );
    }

    #[test]
    fn a_step_absorbed_beside_the_counter_term_is_linear() {
        let r = AbstractExpression::Abstract("r".to_string());
        let len = AbstractExpression::Abstract("inp_len".to_string());
        let stride = generate_expression("-", AbstractExpression::Immediate(0), r.clone());
        let walked = generate_expression("*", counter().expression(), stride.clone());
        let before = generate_expression("-", generate_expression("-", len, r.clone()), r.clone());
        let after = generate_expression("-", before.clone(), r);
        let prev = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression("+", before, walked.clone())),
            0,
        );
        let cur = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression("+", after, walked)),
            0,
        );
        assert_eq!(
            invariant_of_register(&prev, &cur),
            LoopInvariant::Linear(stride)
        );
    }

    #[test]
    fn a_round_moving_both_base_and_offset_drifts_linearly() {
        let out = AbstractExpression::Abstract("out".to_string());
        let lanes = generate_expression(
            "*",
            AbstractExpression::Abstract("lanes".to_string()),
            AbstractExpression::Immediate(8),
        );
        let prev = RegisterValue::new(RegisterKind::RegisterBase, Some(out.clone()), 8);
        let cur = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression("+", out, lanes.clone())),
            -16,
        );
        assert_eq!(invariant_of_register(&prev, &cur), LoopInvariant::Unknown);
        assert_eq!(
            drift_of_registers(&[prev], &[cur]),
            vec![LoopInvariant::Linear(generate_expression(
                "+",
                lanes,
                AbstractExpression::Immediate(-24)
            ))]
        );
    }

    #[test]
    fn a_different_counter_term_is_not_mistaken_for_a_step() {
        let r = AbstractExpression::Abstract("r".to_string());
        let len = AbstractExpression::Abstract("inp_len".to_string());
        let prev = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression(
                "+",
                len.clone(),
                generate_expression("*", counter().expression(), r.clone()),
            )),
            0,
        );
        let cur = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression(
                "+",
                generate_expression("-", len, r.clone()),
                generate_expression("*", counter().expression(), base()),
            )),
            0,
        );
        assert_eq!(invariant_of_register(&prev, &cur), LoopInvariant::Unknown);
    }

    #[test]
    fn unknown_data_never_gets_a_linear_step() {
        let before = RegisterValue::new(RegisterKind::Number, None, 0);
        let after = RegisterValue::new(RegisterKind::Number, None, -9223372036854742903);
        assert_eq!(
            invariant_of_register(&before, &after),
            LoopInvariant::Unknown
        );
        assert_eq!(
            invariant_of_register(&before, &before),
            LoopInvariant::Fixed
        );
    }

    #[test]
    fn register_with_changed_base_is_unknown_not_fixed() {
        let prev = RegisterValue::new(RegisterKind::RegisterBase, Some(base()), 0);
        let cur = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression("*", base(), base())),
            0,
        );
        assert_eq!(invariant_of_register(&prev, &cur), LoopInvariant::Unknown);
    }

    #[test]
    fn immediate_counter_is_linear() {
        let prev = RegisterValue::new_imm(2);
        let cur = RegisterValue::new_imm(3);
        assert_eq!(
            invariant_of_register(&prev, &cur),
            LoopInvariant::Linear(AbstractExpression::Immediate(1))
        );
    }

    #[test]
    fn register_offset_overflow_is_unknown() {
        let prev = RegisterValue::new_imm(i64::MIN);
        let cur = RegisterValue::new_imm(i64::MAX);
        assert_eq!(invariant_of_register(&prev, &cur), LoopInvariant::Unknown);
    }

    #[test]
    fn unknown_subsumes_everything() {
        let linear = LoopInvariant::Linear(AbstractExpression::Immediate(4));
        assert!(LoopInvariant::Unknown.subsumes(&LoopInvariant::Fixed));
        assert!(LoopInvariant::Unknown.subsumes(&linear));
        assert!(LoopInvariant::Unknown.subsumes(&LoopInvariant::Unknown));
    }

    #[test]
    fn precise_elements_only_subsume_themselves() {
        let four = LoopInvariant::Linear(AbstractExpression::Immediate(4));
        let eight = LoopInvariant::Linear(AbstractExpression::Immediate(8));
        assert!(four.subsumes(&four));
        assert!(!four.subsumes(&eight));
        assert!(!four.subsumes(&LoopInvariant::Fixed));
        assert!(!LoopInvariant::Fixed.subsumes(&four));
        assert!(!LoopInvariant::Fixed.subsumes(&LoopInvariant::Unknown));
    }

    #[test]
    fn a_fixed_register_subsumes_a_step_proved_zero() {
        let zero = LoopInvariant::Linear(AbstractExpression::Immediate(0));
        let one = LoopInvariant::Linear(AbstractExpression::Immediate(1));
        assert!(LoopInvariant::Fixed.subsumes(&zero));
        assert!(!LoopInvariant::Fixed.subsumes(&one));
        assert!(!LoopInvariant::Fixed.subsumes(&LoopInvariant::AtMost(1)));
    }

    #[test]
    fn disagreement_joins_to_unknown() {
        let four = LoopInvariant::Linear(AbstractExpression::Immediate(4));
        let eight = LoopInvariant::Linear(AbstractExpression::Immediate(8));
        assert_eq!(four.join(&four), four);
        assert_eq!(four.join(&eight), LoopInvariant::Unknown);
        assert_eq!(four.join(&LoopInvariant::Fixed), LoopInvariant::Unknown);
    }

    #[test]
    fn advance_steps_from_the_anchor() {
        let stepped = advance(base(), &AbstractExpression::Immediate(4), &counter());
        assert_eq!(
            stepped,
            generate_expression(
                "+",
                base(),
                generate_expression(
                    "*",
                    AbstractExpression::Abstract("loop0_?".to_string()),
                    AbstractExpression::Immediate(4)
                )
            )
        );
    }

    fn form_of(e: &AbstractExpression) -> LinearForm {
        linear_form(e).expect("linear")
    }

    #[test]
    fn a_doubled_sum_is_twice_the_sum() {
        let (a, b) = (abstract_of("a"), abstract_of("b"));
        let doubled = generate_expression(
            "+",
            generate_expression("lsl", a.clone(), AbstractExpression::Immediate(1)),
            generate_expression("lsl", b.clone(), AbstractExpression::Immediate(1)),
        );
        let sum = generate_expression("+", a, b);
        assert_eq!(proportion(&form_of(&doubled), &form_of(&sum)), Some(2));
    }

    #[test]
    fn unequal_coefficients_or_constants_are_not_proportional() {
        let (a, b) = (abstract_of("a"), abstract_of("b"));
        let sum = form_of(&generate_expression("+", a.clone(), b.clone()));
        let lopsided = generate_expression(
            "+",
            generate_expression("*", a.clone(), AbstractExpression::Immediate(2)),
            generate_expression("*", b.clone(), AbstractExpression::Immediate(3)),
        );
        assert_eq!(proportion(&form_of(&lopsided), &sum), None);
        let shifted = generate_expression(
            "+",
            generate_expression(
                "*",
                generate_expression("+", a.clone(), b.clone()),
                AbstractExpression::Immediate(2),
            ),
            AbstractExpression::Immediate(1),
        );
        assert_eq!(proportion(&form_of(&shifted), &sum), None);
    }

    #[test]
    fn a_narrowed_value_has_no_linear_form() {
        let narrowed = generate_expression(
            "%",
            abstract_of("a"),
            AbstractExpression::Immediate(1 << 32),
        );
        assert_eq!(linear_form(&narrowed), None);
    }

    #[test]
    fn join_all_weakens_pointwise() {
        let four = LoopInvariant::Linear(AbstractExpression::Immediate(4));
        let eight = LoopInvariant::Linear(AbstractExpression::Immediate(8));
        let a = [four.clone(), LoopInvariant::Fixed, four.clone()];
        let b = [four.clone(), LoopInvariant::Fixed, eight];
        assert_eq!(
            join_all(&a, &b),
            vec![four, LoopInvariant::Fixed, LoopInvariant::Unknown]
        );
    }

    #[test]
    fn join_all_is_idempotent() {
        let a = [
            LoopInvariant::Linear(AbstractExpression::Immediate(4)),
            LoopInvariant::Unknown,
        ];
        assert_eq!(join_all(&a, &a), a.to_vec());
    }

    #[test]
    fn unknown_absorbs() {
        let a = [LoopInvariant::Unknown];
        let b = [LoopInvariant::Fixed];
        assert_eq!(join_all(&a, &b), vec![LoopInvariant::Unknown]);
        assert_eq!(join_all(&b, &a), vec![LoopInvariant::Unknown]);
    }

    #[test]
    fn ascending_every_component_takes_at_most_max_ascents_rounds() {
        let mut current = vec![LoopInvariant::Fixed; 4];
        let mut rounds = 0;
        for i in 0..current.len() {
            let mut next = current.clone();
            next[i] = LoopInvariant::Linear(AbstractExpression::Immediate(4));
            let joined = join_all(&current, &next);
            assert_ne!(joined, current);
            current = joined;
            rounds += 1;
        }
        assert_eq!(current, vec![LoopInvariant::Unknown; 4]);
        assert!(rounds <= max_ascents(4));
    }

    fn flag(name: &str) -> Option<FlagValue> {
        Some(FlagValue::Abstract(AbstractComparison::new(
            "==",
            abstract_of(name),
            AbstractExpression::Immediate(0),
        )))
    }

    #[test]
    fn unchanged_flag_is_kept() {
        assert_eq!(widen_flag("w", &flag("a"), &flag("a")), flag("a"));
        let real = Some(FlagValue::Real(true));
        assert_eq!(widen_flag("w", &real, &real), real);
    }

    #[test]
    fn changed_flag_is_widened_to_a_fresh_abstract() {
        let widened = widen_flag("w", &flag("a"), &flag("b"));
        assert_eq!(widened, flag("w"));
        assert_ne!(widened, flag("b"));
    }

    #[test]
    fn newly_set_flag_is_widened() {
        assert_eq!(widen_flag("w", &None, &flag("a")), flag("w"));
    }

    #[test]
    fn unset_flag_stays_unset() {
        assert_eq!(widen_flag("w", &None, &None), None);
        assert_eq!(widen_flag("w", &flag("a"), &None), None);
    }

    #[test]
    fn registers_are_classified_pointwise() {
        let prev = [
            RegisterValue::new(RegisterKind::RegisterBase, Some(base()), 0),
            RegisterValue::new_imm(7),
        ];
        let cur = [
            RegisterValue::new(RegisterKind::RegisterBase, Some(base()), 4),
            RegisterValue::new_imm(7),
        ];
        assert_eq!(
            invariant_of_registers(&prev, &cur),
            vec![
                LoopInvariant::Linear(AbstractExpression::Immediate(4)),
                LoopInvariant::Fixed
            ]
        );
    }

    fn narrowed(e: AbstractExpression) -> RegisterValue {
        RegisterValue {
            kind: RegisterKind::RegisterBase,
            base: Some(generate_expression(
                "%",
                e,
                AbstractExpression::Immediate(1 << 32),
            )),
            offset: 0,
        }
    }

    #[test]
    fn a_shifted_register_is_geometric() {
        let prev = narrowed(abstract_of("mask"));
        let cur = narrowed(generate_expression(
            "lsr",
            prev.base.clone().unwrap(),
            AbstractExpression::Immediate(4),
        ));
        assert_eq!(geometric_step(&prev, &cur), Some(16));
        assert_eq!(
            invariant_of_register(&prev, &cur),
            LoopInvariant::Geometric(16)
        );
    }

    #[test]
    fn other_steps_are_not_geometric() {
        let prev = narrowed(abstract_of("mask"));
        let plus = narrowed(generate_expression(
            "+",
            prev.base.clone().unwrap(),
            AbstractExpression::Immediate(4),
        ));
        assert_eq!(geometric_step(&prev, &plus), None);
        let elsewhere = narrowed(generate_expression(
            "lsr",
            abstract_of("other"),
            AbstractExpression::Immediate(4),
        ));
        assert_eq!(geometric_step(&prev, &elsewhere), None);
        let unnarrowed_operand = narrowed(generate_expression(
            "lsr",
            abstract_of("mask"),
            AbstractExpression::Immediate(4),
        ));
        assert_eq!(geometric_step(&prev, &unnarrowed_operand), None);
        let plain = RegisterValue::new(RegisterKind::RegisterBase, Some(abstract_of("mask")), 0);
        assert_eq!(geometric_step(&plain, &prev), None);
        let narrowed_operand = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression(
                "lsr",
                prev.base.clone().unwrap(),
                AbstractExpression::Immediate(4),
            )),
            0,
        );
        assert_eq!(geometric_step(&plain, &narrowed_operand), Some(16));
    }

    #[test]
    fn divisions_to_zero_counts_the_shifts() {
        assert_eq!(divisions_to_zero((1i64 << 32) - 1, 16), Some(8));
        assert_eq!(divisions_to_zero(255, 16), Some(2));
        assert_eq!(divisions_to_zero(0, 16), Some(0));
        assert_eq!(divisions_to_zero(-1, 16), None);
        assert_eq!(divisions_to_zero(100, 1), None);
    }

    #[test]
    fn an_upper_bound_is_read_off_a_narrowing_or_a_clamp() {
        assert_eq!(
            upper_bound_of(&generate_expression(
                "%",
                abstract_of("x"),
                AbstractExpression::Immediate(1 << 32)
            )),
            Some((1i64 << 32) - 1)
        );
        assert_eq!(
            upper_bound_of(&generate_expression(
                "atmost",
                abstract_of("x"),
                AbstractExpression::Immediate(7)
            )),
            Some(7)
        );
        assert_eq!(
            upper_bound_of(
                &narrowed(generate_expression(
                    "lsr",
                    narrowed(abstract_of("x")).base.unwrap(),
                    AbstractExpression::Immediate(12)
                ))
                .base
                .unwrap()
            ),
            Some((1i64 << 20) - 1)
        );
        assert_eq!(upper_bound_of(&abstract_of("x")), None);
    }

    #[test]
    fn a_step_form_is_the_normalized_difference() {
        let s = abstract_of("s");
        let prev = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression("+", base(), s.clone())),
            8,
        );
        let cur = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression(
                "+",
                generate_expression("lsl", s.clone(), AbstractExpression::Immediate(1)),
                base(),
            )),
            24,
        );
        assert_eq!(
            step_form(&prev, &cur),
            linear_form(&generate_expression(
                "+",
                s,
                AbstractExpression::Immediate(16)
            ))
        );
        assert_eq!(step_form(&prev, &prev), Some(LinearForm::constant(0)));
    }

    #[test]
    fn a_step_built_from_the_value_itself_is_unknown() {
        let prev = RegisterValue::new(RegisterKind::RegisterBase, Some(base()), 0);
        let cur = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression("+", base(), base())),
            0,
        );
        assert_eq!(invariant_of_register(&prev, &cur), LoopInvariant::Unknown);
    }
}
