use std::cell::{Cell, RefCell};
use std::collections::{BTreeMap, BTreeSet};
use std::io::Error;
use std::rc::Rc;

const MAX_UNCONDITIONAL_REVISITS: usize = 1000;
const MAX_BRANCH_DEPTH: usize = 32;
const MAX_JUMP_HISTORY: usize = 30;
const MIN_REVISITS_PER_BRANCH: usize = 20;
const MAX_SPLIT_VALUES: usize = 4;
const MAX_SELECT_CHAIN: usize = 16;
const SUMMARY_ITERATION: i64 = 3;
const DECIDED_REPEATS_BEFORE_SUMMARY: usize = 3;
const UNROLLING_INSTRUCTION_BUDGET: i64 = 200_000;
const MAX_MERGED_BLOCK: usize = 16;
const MAX_STEPS: usize = 200_000;
const STEPS_PER_INSTRUCTION: usize = 256;

fn limit_from_env(variable: &str, default: usize) -> usize {
    std::env::var(variable)
        .ok()
        .and_then(|v| v.parse().ok())
        .unwrap_or(default)
}

fn max_branch_depth() -> usize {
    limit_from_env("BUMS_MAX_BRANCH_DEPTH", MAX_BRANCH_DEPTH)
}
use z3::ast::Ast;
use z3::*;

use crate::common::*;
use crate::computer::ARMCORTEXA;
use crate::loader::Listing;
use crate::machine::*;
use crate::widening::*;

mod loops;
mod summary;

use loops::*;
use summary::*;

enum BranchOutcome {
    BothExplored,
    Next(usize),
}

enum Step {
    Continue(usize),
    Stop,
    Return,
}

fn runs_past_the_end(pc: usize) -> Error {
    Error::other(format!(
        "line {pc}: execution runs past the end of the code"
    ))
}

const MAX_EXPLORED_KEY_BYTES: usize = 256 << 20;

fn symbols_of(fact: &str) -> impl Iterator<Item = &str> {
    const KEYWORDS: [&str; 20] = [
        "and", "or", "not", "ite", "=", "<=", ">=", "<", ">", "+", "-", "*", "div", "mod", "^",
        "to_int", "to_real", "true", "false", "=>",
    ];
    fact.split(|c: char| c.is_whitespace() || c == '(' || c == ')')
        .filter(|token| {
            !token.is_empty()
                && !KEYWORDS.contains(token)
                && !token.chars().all(|c| c.is_ascii_digit() || c == '.')
        })
}

fn is_fresh_flag(symbol: &str) -> bool {
    symbol.rsplit_once('_').is_some_and(|(prefix, n)| {
        !n.is_empty() && n.chars().all(|c| c.is_ascii_digit()) && prefix.ends_with("_flag")
    })
}

fn facts_about_live_symbols(facts: Vec<String>, state: &str) -> Vec<String> {
    let mut live: Vec<&str> = Vec::new();
    let mut kept = vec![false; facts.len()];
    loop {
        let mut grew = false;
        for (fact, kept) in facts.iter().zip(kept.iter_mut()) {
            if *kept {
                continue;
            }
            let keeps = symbols_of(fact).any(|symbol| {
                !is_fresh_flag(symbol) || live.contains(&symbol) || state.contains(symbol)
            });
            if keeps {
                *kept = true;
                live.extend(symbols_of(fact));
                grew = true;
            }
        }
        if !grew {
            break;
        }
    }
    facts
        .into_iter()
        .zip(kept)
        .filter_map(|(fact, kept)| kept.then_some(fact))
        .collect()
}

#[derive(Default)]
struct Explored {
    finished: BTreeMap<String, bool>,
    bytes: usize,
}

fn join_arms(
    first: std::io::Result<()>,
    second: std::io::Result<()>,
) -> std::io::Result<BranchOutcome> {
    match (first, second) {
        (Ok(()), Ok(())) => Ok(BranchOutcome::BothExplored),
        (Err(err), Ok(())) | (Ok(()), Err(err)) => Err(err),
        (Err(e1), Err(e2)) => {
            let (e1, e2) = (e1.to_string(), e2.to_string());
            Err(Error::other(if e1 == e2 {
                e1
            } else {
                format!("{e1}; {e2}")
            }))
        }
    }
}

#[derive(Debug, Clone)]
struct BranchPoint {
    pc: usize,
    condition: AbstractComparison,
    state: MachineState,
    journal_len: usize,
    slots: Vec<SymbolicSlot>,
    instructions_run: usize,
}

#[derive(Debug, Clone)]
struct JumpRecord {
    point: BranchPoint,
    taken: bool,
    resolved: bool,
}

fn visits_since_the_branch_turned(history: &[JumpRecord], pc: usize, taken: bool) -> usize {
    history
        .iter()
        .rev()
        .filter(|record| record.point.pc == pc)
        .take_while(|record| record.taken == taken)
        .filter(|record| !record.resolved)
        .count()
}

enum Decision {
    Take(bool),
    Explore,
    Unreachable,
}

struct Program<I> {
    code: Vec<I>,
    labels: Vec<(String, usize)>,
    loop_ends: BTreeMap<usize, usize>,
    line_at: BTreeMap<i64, usize>,
    addresses: BTreeMap<String, i64>,
}

fn local_label_reference(label: &str) -> Option<(&str, bool)> {
    let (digits, direction) = label.split_at(label.len().checked_sub(1)?);
    if digits.is_empty() || !digits.bytes().all(|b| b.is_ascii_digit()) {
        return None;
    }
    match direction {
        "f" => Some((digits, true)),
        "b" => Some((digits, false)),
        _ => None,
    }
}

fn label_line(labels: &[(String, usize)], label: &str, pc: usize) -> Option<usize> {
    if let Some((number, forward)) = local_label_reference(label) {
        let candidates = labels.iter().filter(|(name, _)| name == number);
        return if forward {
            candidates
                .filter(|(_, line)| *line > pc)
                .map(|(_, line)| *line)
                .min()
        } else {
            candidates
                .filter(|(_, line)| *line <= pc)
                .map(|(_, line)| *line)
                .max()
        };
    }
    let prefixed = format!("_{label}");
    labels
        .iter()
        .find(|l| l.0 == label || l.0 == prefixed)
        .map(|l| l.1)
}

fn branch_target<I: MachineInstruction>(instruction: &I) -> Option<&str> {
    match instruction.flow() {
        Flow::Jump(label) | Flow::Branch(label) => Some(label),
        _ => None,
    }
}

fn loop_ends_of<I: MachineInstruction>(
    code: &[I],
    labels: &[(String, usize)],
) -> BTreeMap<usize, usize> {
    let mut ends: BTreeMap<usize, usize> = BTreeMap::new();
    for (pc, instruction) in code.iter().enumerate() {
        if let Some(target) = branch_target(instruction).and_then(|l| label_line(labels, l, pc))
            && target <= pc
        {
            let end = ends.entry(target).or_insert(pc);
            *end = (*end).max(pc);
        }
    }
    ends
}

pub type ExecutionEngine = Engine<ARMCORTEXA>;

#[derive(Clone)]
pub struct Engine<M: Machine> {
    program: Rc<Program<M::Instruction>>,
    computer: M,
    loops: PathLoops<M>,
    loop_history: Rc<RefCell<LoopHistory>>,
    jump_history: Vec<JumpRecord>,
    concrete_decisions: BTreeMap<usize, bool>,
    instructions_run: usize,
    select_history: Vec<usize>,
    fail_fast: bool,
    summaries: Rc<RefCell<Vec<Summary>>>,
    dead_registers: Rc<RefCell<BTreeMap<usize, Rc<Vec<usize>>>>>,
    next_loop_id: Rc<Cell<usize>>,
    steps_left: Rc<Cell<usize>>,
    explored: Rc<RefCell<Explored>>,
    scopes: Vec<Scope>,
    next_scope_id: usize,
    path_ends: bool,
    suspended: Vec<SuspendedCall>,
    ledger: Rc<RefCell<SummaryLedger>>,
}

#[derive(Debug, Clone)]
struct SuspendedCall {
    resume: usize,
    loops: Vec<ActiveLoop>,
    history_len: usize,
}

#[derive(Clone)]
struct Scope {
    id: usize,
    base: usize,
    facts: Vec<ast::Bool>,
}

impl<M: Machine> Engine<M> {
    pub fn new<S: Into<String>>(lines: impl IntoIterator<Item = S>) -> Engine<M> {
        let listing = Listing::<M::Instruction>::parse(lines);
        let mut computer = M::new();

        let mut addresses: BTreeMap<String, i64> = BTreeMap::new();
        for section in &listing.data {
            let ty = if section.writable {
                RegionType::RW
            } else {
                RegionType::READ
            };
            computer.add_data_section(&section.name, ty, section.size, section.alignment);
            addresses.insert(section.name.clone(), section.address);
        }
        for (name, symbol) in &listing.data_symbols {
            computer.add_data_symbol(name, &symbol.section, symbol.offset, symbol.size);
        }
        computer.set_code_labels(Rc::new(
            listing.labels.iter().map(|(n, _)| n.clone()).collect(),
        ));
        for section in &listing.data {
            for item in &section.items {
                computer.store_data_item(&section.name, item);
            }
        }
        for name in listing
            .labels
            .iter()
            .map(|(n, _)| n)
            .chain(listing.data_symbols.keys())
        {
            if let Some(address) = listing.address_of(name) {
                addresses.insert(name.clone(), address);
            }
        }
        let Listing {
            code,
            labels,
            line_at,
            ..
        } = listing;
        let steps = MAX_STEPS.max(STEPS_PER_INSTRUCTION * code.len());

        Engine {
            program: Rc::new(Program {
                loop_ends: loop_ends_of(&code, &labels),
                code,
                labels,
                line_at,
                addresses,
            }),
            computer,
            loops: PathLoops::new(),
            loop_history: Rc::default(),
            jump_history: Vec::new(),
            concrete_decisions: BTreeMap::new(),
            instructions_run: 0,
            select_history: Vec::new(),
            fail_fast: true,
            summaries: Rc::new(RefCell::new(Vec::new())),
            dead_registers: Rc::new(RefCell::new(BTreeMap::new())),
            next_loop_id: Rc::new(Cell::new(0)),
            steps_left: Rc::new(Cell::new(limit_from_env("BUMS_MAX_STEPS", steps))),
            explored: Rc::default(),
            scopes: Vec::new(),
            next_scope_id: 0,
            path_ends: false,
            suspended: Vec::new(),
            ledger: Rc::default(),
        }
    }

    pub fn add_region(
        &mut self,
        ty: RegionType,
        base: impl Into<String>,
        length: AbstractExpression,
    ) {
        let zero = ast::Int::from_i64(0);
        for a in length.get_abstracts() {
            let temp = ast::Int::new_const(a);
            self.computer.solver().assert(temp.ge(&zero));
        }
        let base = base.into();
        self.computer
            .solver()
            .assert(ast::Int::new_const(base.clone()).ge(&zero));
        self.computer.add_memory_region(base, ty, length);
    }

    pub fn add_immediate(&mut self, register: impl Into<String>, value: usize) {
        self.computer.set_immediate(register.into(), value as u64);
    }

    pub fn add_abstract(&mut self, register: impl Into<String>, value: AbstractExpression) {
        self.computer.set_abstract(register.into(), value);
    }

    pub fn add_abstract_to_memory(
        &mut self,
        region: impl Into<String>,
        address: i64,
        value: AbstractExpression,
    ) {
        self.computer
            .add_memory_value_abstract(region.into(), address, value);
    }

    pub fn add_abstract_expression_from(&mut self, register: usize, value: AbstractExpression) {
        self.computer.set_argument(register, value);
    }

    pub fn add_abstract_from(&mut self, register: usize, value: impl Into<String>) {
        self.computer
            .set_argument(register, AbstractExpression::Abstract(value.into()));
    }

    pub fn add_element_fact(
        &mut self,
        region: impl Into<String>,
        index: i64,
        element_size: i64,
        symbol: impl Into<String>,
    ) {
        let region = region.into();
        self.computer
            .add_element_fact(&region, index * element_size, element_size, &symbol.into());
    }

    pub fn add_pointer_elements(&mut self, region: impl Into<String>, target: impl Into<String>) {
        self.computer
            .add_pointer_elements(&region.into(), &target.into());
    }

    pub fn add_element_range(
        &mut self,
        region: impl Into<String>,
        element_size: i64,
        signed: bool,
        op: &str,
        bound: AbstractExpression,
    ) {
        self.computer.add_element_range(
            &region.into(),
            ElementRange {
                width: element_size,
                signed,
                op: op.to_string(),
                bound,
            },
        );
    }

    pub fn unread_element_facts(&self) -> Vec<String> {
        self.computer.unread_element_facts()
    }

    pub fn allow_red_zone(&mut self, bytes: i64) {
        self.computer.allow_red_zone(bytes);
    }

    pub fn findings(&self) -> Vec<String> {
        self.computer.findings()
    }

    pub fn get_register_output(&self, register: usize) -> RegisterValue {
        self.computer.register_at(register)
    }

    pub fn address_of(&self, name: &str) -> Option<i64> {
        self.program.addresses.get(name).copied()
    }

    pub fn line_for_address(&self, address: i64) -> Option<usize> {
        self.program.line_at.get(&address).copied()
    }

    pub fn set_step_budget(&mut self, steps: usize) {
        self.steps_left.set(steps);
    }

    pub fn dont_fail_fast(&mut self) {
        self.fail_fast = false;
    }

    pub fn change_alignment(&mut self, value: i64) {
        self.computer.change_alignment(value);
    }

    pub fn start(&mut self, start: impl Into<String>) -> std::io::Result<()> {
        let start: String = start.into();
        let pc = match self.get_linenumber_of_label(start.trim_matches(|c| c == ':').to_string(), 0)
        {
            Some(n) => n,
            None => return Err(Error::other("Start label not found in program")),
        };

        let res = self.run(pc, 0);
        debug_assert!(self.scopes.is_empty(), "solver scopes left open");
        res
    }

    fn concrete_split(&self, condition: &AbstractComparison) -> Option<(String, Vec<i64>)> {
        let mut symbols = condition.get_abstracts();
        symbols.sort();
        symbols.dedup();
        for symbol in symbols {
            if let Some(values) = self.computer.finite_values(&symbol, MAX_SPLIT_VALUES)
                && values.len() > 1
            {
                return Some((symbol, values));
            }
        }
        None
    }

    fn split_on(
        &mut self,
        symbol: &str,
        values: &[i64],
        pc: usize,
        depth: usize,
    ) -> std::io::Result<BranchOutcome> {
        log::info!("splitting {symbol} over {values:?} at line {pc}");
        let mut failures: Vec<String> = Vec::new();
        for value in values {
            let mut branch = self.fork();
            let pinned = ast::Int::new_const(symbol.to_string()).eq(ast::Int::from_i64(*value));
            branch.computer.solver().assert(&pinned);
            branch.computer.substitute_symbol(symbol, *value);
            if let Err(e) = branch.run(pc, depth + 1) {
                let text = e.to_string();
                if !failures.contains(&text) {
                    failures.push(text);
                }
            }
        }
        if failures.is_empty() {
            Ok(BranchOutcome::BothExplored)
        } else {
            Err(Error::other(failures.join("; ")))
        }
    }

    fn split_cases(
        &mut self,
        pc: usize,
        cases: Vec<AbstractComparison>,
        depth: usize,
    ) -> std::io::Result<()> {
        log::info!("splitting line {pc} over {} cases", cases.len());
        let mut failures: Vec<String> = Vec::new();
        for case in cases {
            let mut branch = self.fork();
            branch.add_constraint(case, true);
            if let Err(e) = branch.run(pc, depth + 1) {
                let text = e.to_string();
                if !failures.contains(&text) {
                    failures.push(text);
                }
            }
        }
        if failures.is_empty() {
            Ok(())
        } else {
            Err(Error::other(failures.join("; ")))
        }
    }

    fn resolve_indirect(&self, pc: usize, target: &RegisterValue) -> std::io::Result<usize> {
        let Some(AbstractExpression::Abstract(symbol)) = &target.base else {
            return Err(Error::other(format!(
                "line {pc}: indirect branch to {}",
                target.expression()
            )));
        };
        self.address_of(symbol)
            .and_then(|address| self.line_for_address(address + target.offset))
            .ok_or_else(|| {
                Error::other(format!(
                    "line {pc}: indirect branch to {symbol} + {} is not an instruction",
                    target.offset
                ))
            })
    }

    fn push_scope(&mut self) -> usize {
        let id = self.next_scope_id;
        self.next_scope_id += 1;
        self.push_scope_with(id);
        id
    }

    fn push_scope_with(&mut self, id: usize) {
        let base = self.computer.solver().get_assertions().len();
        self.computer.solver().push();
        self.scopes.push(Scope {
            id,
            base,
            facts: Vec::new(),
        });
    }

    fn fork(&self) -> Engine<M> {
        let mut forked = self.clone();
        let assertions = self.computer.solver().get_assertions();
        let solver = Solver::new();
        let mut next = 0;
        for scope in &self.scopes {
            let end = scope.base.clamp(next, assertions.len());
            for assertion in &assertions[next..end] {
                solver.assert(assertion);
            }
            solver.push();
            next = end;
        }
        for assertion in &assertions[next..] {
            solver.assert(assertion);
        }
        forked.computer.set_solver(solver);
        forked
    }

    fn pop_scope(&mut self, id: usize) {
        if !self.scopes.iter().any(|s| s.id == id) {
            return;
        }
        while let Some(top) = self.scopes.pop() {
            self.computer.solver().pop(1);
            if top.id == id {
                break;
            }
        }
    }

    fn scopes_above(&self, id: usize) -> Vec<Scope> {
        match self.scopes.iter().position(|s| s.id == id) {
            Some(i) => self.scopes[i + 1..].to_vec(),
            None => Vec::new(),
        }
    }

    fn rebuild_scopes(&mut self, above: Vec<Scope>) {
        for scope in above {
            self.push_scope_with(scope.id);
            for c in scope.facts {
                self.assert_in_scope(c);
            }
        }
    }

    fn assert_in_scope(&mut self, c: ast::Bool) {
        self.computer.solver().assert(&c);
        if let Some(scope) = self.scopes.last_mut() {
            scope.facts.push(c);
        }
    }

    fn run(&mut self, start_pc: usize, depth: usize) -> std::io::Result<()> {
        let result = self.run_from(start_pc, depth);
        while let Some(active) = self.loops.active.last()
            && active.depth == depth
        {
            log::info!("{} abandoned at line {}", active.id, active.pc);
            let scope_id = active.scope_id;
            self.loops.active.pop();
            self.pop_scope(scope_id);
        }
        result
    }

    fn run_from(&mut self, start_pc: usize, depth: usize) -> std::io::Result<()> {
        if depth > max_branch_depth() {
            return Err(Error::other(format!(
                "line {start_pc}: branch depth exceeded {}",
                max_branch_depth()
            )));
        }
        let mut reached = Vec::new();
        let result = self.run_path(start_pc, depth, &mut reached);
        let mut explored = self.explored.borrow_mut();
        for key in reached {
            explored.finished.insert(key, true);
        }
        result
    }

    fn run_path(
        &mut self,
        start_pc: usize,
        depth: usize,
        reached: &mut Vec<String>,
    ) -> std::io::Result<()> {
        let mut pc = start_pc;
        let mut unconditional_visits: BTreeMap<usize, usize> = BTreeMap::new();
        let length = self.program.code.len();
        while pc < length {
            match self.step(pc, depth, &mut unconditional_visits, reached)? {
                Step::Continue(next) => pc = next,
                Step::Stop => return Ok(()),
                Step::Return => {
                    return self
                        .computer
                        .check_stack_pointer_restored(pc)
                        .map_err(Error::other);
                }
            }
        }
        Err(runs_past_the_end(pc))
    }

    fn merge_key(&self, pc: usize) -> Option<String> {
        let fingerprint = self
            .computer
            .fingerprint(!M::Instruction::flags_dead(&self.program.code, pc))?;
        let mut state = format!(
            "{pc}|{fingerprint}|{:?}|{:?}|{:?}|{:?}|{:?}|{:?}|{:?}|{:?}|{:?}|{:?}|{:?}",
            self.loops.active,
            self.loops.attempts,
            self.concrete_decisions,
            self.loops.closed_counters,
            self.loops.concrete_latch_visits,
            self.loops.costly_latches,
            self.loops.value_ranges,
            self.loops.rounds,
            self.loops.relied_on,
            self.suspended,
            self.scopes.iter().map(|scope| scope.id).collect::<Vec<_>>(),
        );
        let facts = self
            .computer
            .solver()
            .get_assertions()
            .iter()
            .map(|fact| fact.to_string())
            .collect();
        for fact in facts_about_live_symbols(facts, &state) {
            state.push('|');
            state.push_str(&fact);
        }
        Some(state)
    }

    fn already_explored(&self, pc: usize, reached: &mut Vec<String>) -> bool {
        let Some(key) = self.merge_key(pc) else {
            return false;
        };
        let mut explored = self.explored.borrow_mut();
        match explored.finished.get(&key) {
            Some(finished) => *finished,
            None => {
                if explored.bytes + key.len() <= MAX_EXPLORED_KEY_BYTES {
                    explored.bytes += key.len();
                    explored.finished.insert(key.clone(), false);
                    reached.push(key);
                }
                false
            }
        }
    }

    fn step(
        &mut self,
        mut pc: usize,
        depth: usize,
        unconditional_visits: &mut BTreeMap<usize, usize>,
        reached: &mut Vec<String>,
    ) -> std::io::Result<Step> {
        let Some(steps_left) = self.steps_left.get().checked_sub(1) else {
            return Err(Error::other(format!(
                "line {pc}: exploration limit reached"
            )));
        };
        self.steps_left.set(steps_left);
        self.instructions_run += 1;
        if let Some(&end) = self.program.loop_ends.get(&pc)
            && let Some((written, exits)) = self.memory_free_loop(pc, end)
        {
            return self.havoc_memory_free_loop(pc, written, exits, depth);
        }
        {
            let mut instruction = self.program.code[pc].clone();

            let block_start = instruction.is_label();
            while instruction.is_label() {
                pc += 1;
                if pc >= self.program.code.len() {
                    return Err(runs_past_the_end(pc));
                }
                instruction = self.program.code[pc].clone();
            }

            if block_start && self.already_explored(pc, reached) {
                log::info!("line {pc}: reached again in an explored state; merged");
                return Ok(Step::Stop);
            }

            log::info!("{:?}: {:?}", pc, instruction);

            let mut execute_result = self.computer.execute(pc, &instruction);
            if instruction.flow() == Flow::Call && execute_result.is_ok() {
                self.suspend_for_call(pc);
            }
            if let Some((condition, label)) =
                self.costly_concrete_latch(pc, &instruction, &execute_result)
            {
                execute_result = Ok(ExecuteReturnType::ConditionalJumpLabel(condition, label));
            }

            if matches!(instruction.flow(), Flow::Branch(_)) {
                match &execute_result {
                    Ok(ExecuteReturnType::Next) => {
                        self.concrete_decisions.insert(pc, false);
                    }
                    Ok(ExecuteReturnType::JumpLabel(_)) => {
                        self.concrete_decisions.insert(pc, true);
                    }
                    _ => (),
                }
            }

            match execute_result {
                Ok(res) => match res {
                    ExecuteReturnType::Next => Ok(Step::Continue(pc + 1)),
                    ExecuteReturnType::Trap => {
                        log::info!("line {pc}: trap, path does not return");
                        Ok(Step::Stop)
                    }
                    ExecuteReturnType::JumpLabel(label) => {
                        if &label == "return" {
                            return Ok(Step::Return);
                        }
                        match self.get_linenumber_of_label(label.clone(), pc) {
                            Some(n) => {
                                log::info!("jumping to: {}", n);
                                Self::note_unconditional_jump(unconditional_visits, n)?;
                                Ok(Step::Continue(n))
                            }
                            None => {
                                Err(Error::other(format!("line {pc}: undefined label {label}")))
                            }
                        }
                    }
                    ExecuteReturnType::JumpAddress(address) => {
                        let dest = address as usize;
                        if instruction.flow() == Flow::Return
                            && self
                                .suspended
                                .last()
                                .is_some_and(|call| call.resume == dest)
                        {
                            self.resume_suspended();
                        }
                        Self::note_unconditional_jump(unconditional_visits, dest)?;
                        Ok(Step::Continue(dest))
                    }
                    ExecuteReturnType::ConditionalJumpLabel(condition, label) => {
                        self.check_not_stuck(pc, &format!("loop at {label}"))?;
                        let jump_dest = self.resolve_jump_target(&label, pc)?;
                        Ok(
                            match self.take_conditional_branch(pc, condition, jump_dest, depth)? {
                                BranchOutcome::BothExplored => Step::Stop,
                                BranchOutcome::Next(next) => Step::Continue(next),
                            },
                        )
                    }
                    ExecuteReturnType::ConditionalJumpAddress(condition, address) => {
                        self.check_not_stuck(pc, "branch")?;
                        let jump_dest = address
                            .try_into()
                            .expect("branch target must be non-negative");
                        Ok(
                            match self.take_conditional_branch(pc, condition, jump_dest, depth)? {
                                BranchOutcome::BothExplored => Step::Stop,
                                BranchOutcome::Next(next) => Step::Continue(next),
                            },
                        )
                    }
                    ExecuteReturnType::Select(condition, register, option1, option2) => {
                        self.check_not_stuck(pc, "select")?;
                        Ok(
                            match self
                                .take_select(pc, condition, register, option1, option2, depth)?
                            {
                                BranchOutcome::BothExplored => Step::Stop,
                                BranchOutcome::Next(next) => Step::Continue(next),
                            },
                        )
                    }
                    ExecuteReturnType::JumpIndirect(target) => {
                        let dest = self.resolve_indirect(pc, &target)?;
                        Self::note_unconditional_jump(unconditional_visits, dest)?;
                        Ok(Step::Continue(dest))
                    }
                    ExecuteReturnType::Split(cases) => {
                        self.split_cases(pc, cases, depth)?;
                        Ok(Step::Stop)
                    }
                },
                Err(err) => {
                    let err = format!("line {pc} ({}): {err}", instruction.opcode());
                    log::error!("{err}");
                    if self.fail_fast {
                        return Err(Error::other(err));
                    }
                    Ok(Step::Continue(pc + 1))
                }
            }
        }
    }

    fn allocate_loop_id(&self) -> LoopId {
        let n = self.next_loop_id.get();
        self.next_loop_id.set(n + 1);
        LoopId::new(n)
    }

    fn enclosing_label(&self, pc: usize) -> Option<String> {
        self.program
            .labels
            .iter()
            .filter(|(_, line)| *line <= pc)
            .max_by_key(|(_, line)| *line)
            .map(|(name, _)| name.clone())
    }

    fn get_linenumber_of_label(&self, label: String, pc: usize) -> Option<usize> {
        if let Some((number, forward)) = local_label_reference(&label) {
            let candidates = self
                .program
                .labels
                .iter()
                .filter(|(name, _)| name == number);
            return if forward {
                candidates
                    .filter(|(_, line)| *line > pc)
                    .map(|(_, line)| *line)
                    .min()
            } else {
                candidates
                    .filter(|(_, line)| *line <= pc)
                    .map(|(_, line)| *line)
                    .max()
            };
        }
        let prefixed = format!("_{label}");
        self.program
            .labels
            .iter()
            .find(|l| l.0 == label)
            .or_else(|| self.program.labels.iter().find(|l| l.0 == prefixed))
            .map(|l| l.1)
    }

    fn note_unconditional_jump(
        visits: &mut BTreeMap<usize, usize>,
        dest: usize,
    ) -> std::io::Result<()> {
        let count = visits.entry(dest).or_insert(0);
        *count += 1;
        if *count > MAX_UNCONDITIONAL_REVISITS {
            log::error!("unconditional jump cycle at line {}", dest);
            return Err(Error::other(format!(
                "could not resolve loop: unconditional jump to line {} repeated {} times",
                dest, count
            )));
        }
        Ok(())
    }

    fn resolve_jump_target(&self, label: &str, pc: usize) -> std::io::Result<usize> {
        if let Some(i) = self.get_linenumber_of_label(label.to_string(), pc) {
            return Ok(i);
        }
        let (base, offset) = label
            .split_once('+')
            .ok_or_else(|| Error::other(format!("No label found: {:?}", label)))?;
        let line = self
            .get_linenumber_of_label(base.to_string(), pc)
            .ok_or_else(|| Error::other(format!("No label found: {:?}", base)))?;
        let width = M::Instruction::FIXED_WIDTH.ok_or_else(|| {
            Error::other(format!(
                "{label}: instructions have no fixed width to count"
            ))
        })?;
        let parsed_offset = usize::from_str_radix(offset.trim_start_matches("0x"), 16)
            .expect("unable to parse label offset");
        Ok(line + 1 + parsed_offset / width)
    }

    fn is_boolean_mask(&self, expr: &AbstractExpression) -> bool {
        match expr {
            AbstractExpression::Immediate(-1) | AbstractExpression::Immediate(0) => true,
            AbstractExpression::Abstract(name) => matches!(
                self.computer
                    .select_definitions()
                    .get(name)
                    .map(|(_, a, b)| (a, b)),
                Some((
                    AbstractExpression::Immediate(-1),
                    AbstractExpression::Immediate(0)
                )) | Some((
                    AbstractExpression::Immediate(0),
                    AbstractExpression::Immediate(-1)
                ))
            ),
            _ => false,
        }
    }

    fn resolve_boolean_mask_xor(&self, expr: &AbstractExpression) -> AbstractExpression {
        match expr {
            AbstractExpression::Expression(op, left, right) => {
                let left = self.resolve_boolean_mask_xor(left);
                let right = self.resolve_boolean_mask_xor(right);
                if op.as_str() == "^"
                    && (self.is_boolean_mask(&left) || self.is_boolean_mask(&right))
                {
                    generate_expression(
                        "+",
                        generate_expression("+", left.clone(), right.clone()),
                        generate_expression(
                            "*",
                            AbstractExpression::Immediate(2),
                            generate_expression("*", left, right),
                        ),
                    )
                } else {
                    generate_expression(op.as_str(), left, right)
                }
            }
            AbstractExpression::Register(reg) => {
                let mut reg = (**reg).clone();
                if let Some(base) = reg.base.take() {
                    reg.base = Some(self.resolve_boolean_mask_xor(&base));
                }
                AbstractExpression::Register(Box::new(reg))
            }
            other => other.clone(),
        }
    }

    fn resolve_boolean_mask_xors_in(&self, condition: &AbstractComparison) -> AbstractComparison {
        AbstractComparison::new(
            &condition.op,
            self.resolve_boolean_mask_xor(&condition.left),
            self.resolve_boolean_mask_xor(&condition.right),
        )
    }

    fn take_select(
        &mut self,
        pc: usize,
        condition: AbstractComparison,
        register: M::Operand,
        option1: RegisterValue,
        option2: RegisterValue,
        depth: usize,
    ) -> std::io::Result<BranchOutcome> {
        let condition = self.resolve_boolean_mask_xors_in(&condition);
        let take = comparison_to_ast(condition.clone()).ok_or_else(|| {
            Error::other(format!(
                "select condition uses an operation the engine does not model: {condition}"
            ))
        })?;
        let skip = comparison_to_ast(condition.clone().not()).ok_or_else(|| {
            Error::other(format!(
                "negated select condition uses an operation the engine does not model: {}",
                condition.clone().not()
            ))
        })?;
        match (
            check(self.computer.solver(), &[take]),
            check(self.computer.solver(), &[skip]),
        ) {
            (SatResult::Sat, SatResult::Unsat) => {
                self.add_constraint(condition, true);
                self.computer
                    .set_register(&register, option1.kind, option1.base, option1.offset);
                Ok(BranchOutcome::Next(pc + 1))
            }
            (SatResult::Unsat, SatResult::Sat) => {
                self.add_constraint(condition, false);
                self.computer
                    .set_register(&register, option2.kind, option2.base, option2.offset);
                Ok(BranchOutcome::Next(pc + 1))
            }
            _ => {
                let code_address = self.computer.carries_code_address(&option1)
                    || self.computer.carries_code_address(&option2);
                if let Some(base) = option1.base.clone()
                    && !code_address
                    && option1.base == option2.base
                    && option1.kind == option2.kind
                {
                    let name = format!("select_{}", self.computer.fresh_index());
                    self.computer.select_definitions_mut().insert(
                        name.clone(),
                        (
                            condition.clone(),
                            AbstractExpression::Immediate(option1.offset),
                            AbstractExpression::Immediate(option2.offset),
                        ),
                    );
                    self.computer.set_register(
                        &register,
                        option1.kind,
                        Some(generate_expression(
                            "+",
                            base,
                            AbstractExpression::Abstract(name),
                        )),
                        0,
                    );
                    return Ok(BranchOutcome::Next(pc + 1));
                }
                if !code_address
                    && !self.computer.carries_region(&option1)
                    && !self.computer.carries_region(&option2)
                {
                    let name = format!("select_{}", self.computer.fresh_index());
                    self.computer.select_definitions_mut().insert(
                        name.clone(),
                        (
                            condition.clone(),
                            option1.expression(),
                            option2.expression(),
                        ),
                    );
                    self.computer.set_register(
                        &register,
                        RegisterKind::RegisterBase,
                        Some(AbstractExpression::Abstract(name)),
                        0,
                    );
                    return Ok(BranchOutcome::Next(pc + 1));
                }
                self.select_history.push(pc);
                let clone = &mut self.fork();

                self.add_constraint(condition.clone(), true);
                self.computer
                    .set_register(&register, option1.kind, option1.base, option1.offset);
                let res1 = self.run(pc + 1, depth + 1);

                clone.add_constraint(condition, false);
                clone
                    .computer
                    .set_register(&register, option2.kind, option2.base, option2.offset);
                let res2 = clone.run(pc + 1, depth + 1);
                join_arms(res1, res2)
            }
        }
    }

    fn take_conditional_branch(
        &mut self,
        pc: usize,
        mut condition: AbstractComparison,
        jump_dest: usize,
        depth: usize,
    ) -> std::io::Result<BranchOutcome> {
        if self.loops.active.is_empty()
            && let Some((symbol, values)) = self.concrete_split(&condition)
        {
            return self.split_on(&symbol, &values, pc, depth);
        }
        let decision = self.evaluate_branch_condition(pc, depth, &mut condition);
        self.follow_branch(pc, condition, decision, jump_dest, depth)
    }

    fn follow_branch(
        &mut self,
        pc: usize,
        condition: AbstractComparison,
        decision: Option<bool>,
        jump_dest: usize,
        depth: usize,
    ) -> std::io::Result<BranchOutcome> {
        let pending_summary = self.loops.pending.take();
        if std::mem::take(&mut self.path_ends) {
            return Ok(BranchOutcome::BothExplored);
        }
        if decision.is_none()
            && let Some(join) = self.merge_branch_arms(pc, &condition, jump_dest)
        {
            return Ok(BranchOutcome::Next(join));
        }
        match decision {
            None => {
                let here = self.branch_point(pc, &condition);
                let mut other = self.fork();
                let taken = self.explore_arm(here.clone(), true, jump_dest, depth);
                let fallen = other.explore_arm(here, false, pc + 1, depth);
                join_arms(taken, fallen)
            }
            Some(taken) => {
                self.jump_history.push(JumpRecord {
                    point: BranchPoint {
                        pc,
                        condition: condition.clone(),
                        state: self.computer.get_state(),
                        journal_len: self.computer.write_journal().len(),
                        slots: self.computer.symbolic_slots(),
                        instructions_run: self.instructions_run,
                    },
                    taken,
                    resolved: false,
                });
                self.computer.clear_rw_queue();
                if self.loops.active.last().is_none_or(|open| open.pc != pc) {
                    self.add_constraint(condition.clone(), taken);
                    self.order_a_monotone_guard(pc, &condition, taken);
                }
                let next = if taken { jump_dest } else { pc + 1 };
                log::info!("exploring line: {}", next);
                match pending_summary {
                    Some((instance, fallback)) => self.validate_summary(
                        instance,
                        *fallback,
                        next,
                        (pc, condition, jump_dest),
                        depth,
                    ),
                    None => Ok(BranchOutcome::Next(next)),
                }
            }
        }
    }

    fn branch_point(&self, pc: usize, condition: &AbstractComparison) -> BranchPoint {
        BranchPoint {
            pc,
            condition: condition.clone(),
            state: self.computer.get_state(),
            journal_len: self.computer.write_journal().len(),
            slots: self.computer.symbolic_slots(),
            instructions_run: self.instructions_run,
        }
    }

    fn explore_arm(
        &mut self,
        here: BranchPoint,
        taken: bool,
        dest: usize,
        depth: usize,
    ) -> std::io::Result<()> {
        let (pc, condition) = (here.pc, here.condition.clone());
        self.jump_history.push(JumpRecord {
            point: here,
            taken,
            resolved: false,
        });
        self.computer.clear_rw_queue();
        log::info!(
            "exploring line {dest} (from line {pc}, depth {depth}, history {})",
            self.jump_history.len()
        );
        let scope = self.push_scope();
        self.add_constraint(condition.clone(), taken);
        self.order_a_monotone_guard(pc, &condition, taken);
        let explored = self.run(dest, depth + 1);
        self.pop_scope(scope);
        explored
    }

    fn run_data_arm(&mut self, start: usize, stop_at: Option<usize>) -> Option<usize> {
        let mut pc = start;
        for _ in 0..MAX_MERGED_BLOCK {
            if Some(pc) == stop_at {
                return Some(pc);
            }
            let instruction = self.program.code.get(pc)?.clone();
            if !instruction.is_label() {
                match instruction.flow() {
                    Flow::Jump(label) => return self.resolve_jump_target(label, pc).ok(),
                    Flow::Branch(_) => {
                        pc = match self.computer.execute(pc, &instruction) {
                            Ok(ExecuteReturnType::Next) => pc + 1,
                            Ok(ExecuteReturnType::JumpLabel(label)) => {
                                self.resolve_jump_target(&label, pc).ok()?
                            }
                            Ok(ExecuteReturnType::ConditionalJumpLabel(condition, label)) => {
                                let target = self.resolve_jump_target(&label, pc).ok()?;
                                let join = (target > pc)
                                    .then(|| self.merge_branch_arms(pc, &condition, target))
                                    .flatten()?;
                                (join > pc).then_some(join)?
                            }
                            _ => return None,
                        };
                        continue;
                    }
                    Flow::Next if instruction.data_only() => {
                        if !matches!(
                            self.computer.execute(pc, &instruction),
                            Ok(ExecuteReturnType::Next)
                        ) {
                            return None;
                        }
                    }
                    _ => return None,
                }
            }
            pc += 1;
        }
        None
    }

    fn merge_branch_arms(
        &mut self,
        pc: usize,
        condition: &AbstractComparison,
        jump_dest: usize,
    ) -> Option<usize> {
        if self.loops.active.iter().any(|open| open.pc == pc)
            || comparison_to_ast(condition.clone()).is_none()
        {
            return None;
        }
        let entry = self.computer.get_state();
        let lanes = self.computer.lanes();
        let history_len = self.jump_history.len();
        let abandon = |engine: &mut Self, entry: MachineState| {
            engine.computer.set_state(entry);
            engine.computer.set_lanes(lanes.clone());
            engine.jump_history.truncate(history_len);
            None
        };
        let stop_at = (jump_dest > pc).then_some(jump_dest);
        let Some(fall_end) = self.run_data_arm(pc + 1, stop_at) else {
            return abandon(self, entry);
        };
        let fallen = self.computer.get_state();
        self.computer.set_state(entry.clone());
        let (taken, join) = if fall_end == jump_dest {
            (entry.clone(), jump_dest)
        } else {
            match self.run_data_arm(jump_dest, Some(fall_end)) {
                Some(end) if end == fall_end => (self.computer.get_state(), end),
                _ => return abandon(self, entry),
            }
        };
        let pointer_moved = taken.0.iter().zip(fallen.0.iter()).any(|(a, b)| {
            a != b && (self.computer.carries_region(a) || self.computer.carries_region(b))
        });
        if pointer_moved {
            return abandon(self, entry);
        }
        let mut merged = fallen.clone();
        for (i, (if_taken, if_fallen)) in taken.0.iter().zip(fallen.0.iter()).enumerate() {
            if if_taken == if_fallen {
                continue;
            }
            let name = format!("select_{}", self.computer.fresh_index());
            self.computer.select_definitions_mut().insert(
                name.clone(),
                (
                    condition.clone(),
                    if_taken.expression(),
                    if_fallen.expression(),
                ),
            );
            merged.0[i] = RegisterValue::new(
                RegisterKind::RegisterBase,
                Some(AbstractExpression::Abstract(name)),
                0,
            );
        }
        let flags_agree = (&taken.1, &taken.2, &taken.3, &taken.4)
            == (&fallen.1, &fallen.2, &fallen.3, &fallen.4);
        self.computer.set_state(merged);
        if !flags_agree {
            self.computer.set_unknown_flags();
        }
        self.jump_history.push(JumpRecord {
            point: BranchPoint {
                pc,
                condition: condition.clone(),
                state: entry,
                journal_len: self.computer.write_journal().len(),
                slots: self.computer.symbolic_slots(),
                instructions_run: self.instructions_run,
            },
            taken: true,
            resolved: true,
        });
        self.computer.clear_rw_queue();
        log::info!("line {pc} merged its data-only arms, rejoining at line {join}");
        Some(join)
    }

    fn add_constraint(&mut self, constraint: AbstractComparison, decision: bool) {
        let shown = constraint.clone();
        for defined in self.select_definitions_in(&constraint) {
            self.assert_in_scope(defined);
        }
        let Some(c) = comparison_to_ast(constraint) else {
            log::info!("branch condition not expressible, left unconstrained: {shown}");
            return;
        };
        let c = c.simplify();
        self.assert_in_scope(if decision { c } else { c.not() });
        if matches!((shown.op.as_str(), decision), ("==", true) | ("!=", false)) {
            self.substitute_decided_symbol(&shown);
        }
    }

    fn substitute_decided_symbol(&mut self, equality: &AbstractComparison) {
        let spelled =
            |e: &AbstractExpression| peel_narrowing(&without_registers(e).unwrap_or(e.clone()));
        let Some(difference) = linear_form(&generate_expression(
            "-",
            spelled(&equality.left),
            spelled(&equality.right),
        )) else {
            return;
        };
        let [(symbol, &coefficient)] = difference.terms.iter().collect::<Vec<_>>()[..] else {
            return;
        };
        if difference.constant % coefficient != 0 {
            return;
        }
        let value = -difference.constant / coefficient;
        let symbol = symbol.clone();
        if self.proves(AbstractComparison::new(
            "==",
            AbstractExpression::Abstract(symbol.clone()),
            AbstractExpression::Immediate(value),
        )) {
            log::info!("{symbol} is {value} on this path");
            self.computer.substitute_symbol(&symbol, value);
        }
    }

    pub fn pin(&mut self, symbol: &str, value: i64) {
        self.add_invariant(AbstractComparison::new(
            "==",
            AbstractExpression::Abstract(symbol.to_string()),
            AbstractExpression::Immediate(value),
        ));
        self.computer.substitute_symbol(symbol, value);
    }

    fn order_a_monotone_guard(&mut self, pc: usize, condition: &AbstractComparison, taken: bool) {
        let Some(ordering) = self.ordering_from_a_monotone_guard(pc, condition, taken) else {
            return;
        };
        let Some(ordered) = comparison_to_ast(ordering.clone()) else {
            return;
        };
        log::info!("line {pc}: a walker stepping by one never passed its bound: {ordering}");
        self.assert_in_scope(ordered.simplify());
    }

    fn ordering_from_a_monotone_guard(
        &self,
        pc: usize,
        condition: &AbstractComparison,
        taken: bool,
    ) -> Option<AbstractComparison> {
        let held = if taken {
            condition.clone()
        } else {
            condition.not()
        };
        if held.op != "!=" {
            return None;
        }
        let active = self.loops.active.last()?;
        if active.entry_decision || !self.straight_from_the_loop_branch(pc, active.pc) {
            return None;
        }
        let counter = LoopCounter::for_loop(active.id);
        let (left, right) = (
            without_registers(&held.left)?,
            without_registers(&held.right)?,
        );
        let (walks_left, start, step, walker, bound) = match (
            counter_affine(&left, counter.name()),
            counter_affine(&right, counter.name()),
        ) {
            (Some((start, step)), Some((_, 0))) if step.abs() == 1 => {
                (true, start, step, left, right)
            }
            (Some((_, 0)), Some((start, step))) if step.abs() == 1 => {
                (false, start, step, right, left)
            }
            _ => return None,
        };
        let history = &self.jump_history[..active.history_len.min(self.jump_history.len())];
        let last_round = history.iter().rposition(|r| r.point.pc == active.pc)?;
        let unrolled = history[last_round..].iter().find(|r| r.point.pc == pc)?;
        let unrolled_bound = if walks_left {
            &unrolled.point.condition.right
        } else {
            &unrolled.point.condition.left
        };
        if unrolled.taken != taken
            || unrolled.point.condition.op != condition.op
            || without_registers(unrolled_bound).as_ref() != Some(&bound)
        {
            return None;
        }
        if !self.equal_side_leaves_the_loop(pc, taken, history, last_round) {
            return None;
        }
        let (behind, order) = if step == 1 { (">=", "<") } else { ("<=", ">") };
        let started_past =
            comparison_to_ast(AbstractComparison::new(behind, start, bound.clone()))?;
        if self.computer.solver().check_assumptions(&[started_past]) != SatResult::Unsat {
            return None;
        }
        Some(AbstractComparison::new(order, walker, bound))
    }

    fn equal_side_leaves_the_loop(
        &self,
        pc: usize,
        taken: bool,
        history: &[JumpRecord],
        last_round: usize,
    ) -> bool {
        let loop_record = &history[last_round];
        let Some((source, header, _)) = self.cycle_back_edge(
            loop_record.point.pc,
            loop_record.taken,
            &history[last_round + 1..],
        ) else {
            return false;
        };
        let Some(successors) = self.static_successors(pc) else {
            return false;
        };
        let [target, fallthrough] = successors.as_slice() else {
            return false;
        };
        let equal_side = if taken { *fallthrough } else { *target };
        !self.stays_in_loop(equal_side, header, source, pc != source)
    }

    fn straight_from_the_loop_branch(&self, pc: usize, loop_pc: usize) -> bool {
        pc > loop_pc
            && (loop_pc + 1..pc).all(|i| {
                self.program
                    .code
                    .get(i)
                    .is_some_and(MachineInstruction::is_straight_line)
            })
    }

    pub fn add_invariant(&self, constraint: AbstractComparison) {
        let shown = constraint.clone();
        let Some(c) = comparison_to_ast(constraint) else {
            log::info!("invariant not expressible, dropped: {shown}");
            return;
        };
        self.computer.solver().assert(c.simplify());
    }

    fn revisit_cap(&self) -> usize {
        let widest_region = self
            .computer
            .memory()
            .values()
            .filter_map(|region| match region.get_length() {
                AbstractExpression::Immediate(bytes) if bytes > 0 => Some(bytes as usize / 8),
                _ => None,
            })
            .max()
            .unwrap_or(0);
        MIN_REVISITS_PER_BRANCH.max(self.program.labels.len().saturating_add(widest_region))
    }

    fn bounded_guard(&self, pc: usize) -> Option<i64> {
        let record = self.jump_history.iter().rev().find(|h| h.point.pc == pc)?;
        let condition = &record.point.condition;
        let distance =
            generate_expression("-", (*condition.left).clone(), (*condition.right).clone());
        if !is_translatable(&distance) {
            return None;
        }
        let distance = expression_to_ast(distance)?;
        [8i64, 64, 512].into_iter().find(|&bound| {
            let outside = ast::Bool::or(&[
                &distance.gt(ast::Int::from_i64(bound)),
                &distance.lt(ast::Int::from_i64(-bound)),
            ]);
            self.computer.solver().check_assumptions(&[outside]) == SatResult::Unsat
        })
    }

    fn check_not_stuck(&self, pc: usize, what: &str) -> std::io::Result<()> {
        let cap = self.revisit_cap();
        if self.jump_history.len() > MAX_JUMP_HISTORY {
            let latest = self.jump_history.last().expect("jump history");
            let last = latest.point.pc;
            let loop_count = visits_since_the_branch_turned(&self.jump_history, last, latest.taken);
            let allowance = self
                .bounded_guard(last)
                .map_or(cap, |bound| cap.max(bound as usize * 4));
            if loop_count > allowance {
                log::info!("line {last} revisited {loop_count} times without resolving");
                let site = if last == pc {
                    format!("line {pc}: {what}")
                } else {
                    format!("line {last} (reached at line {pc}: {what})")
                };
                return Err(Error::other(format!(
                    "{site} not summarized after {allowance} revisits"
                )));
            }
        }
        let selects = self.select_history.iter().filter(|p| **p == pc).count();
        if selects > cap {
            log::info!("line {pc} selected {selects} times without resolving");
            return Err(Error::other(format!(
                "line {pc}: {what} not summarized after {cap} revisits"
            )));
        }
        Ok(())
    }

    fn select_definitions_in(&self, condition: &AbstractComparison) -> Vec<ast::Bool> {
        let mut defined = self.computer.select_assumptions(&condition.left);
        defined.extend(self.computer.select_assumptions(&condition.right));
        defined
    }

    fn decide_from_solver(&self, expression: &AbstractComparison) -> Decision {
        let (Some(holds), Some(fails)) = (
            comparison_to_ast(expression.clone()),
            comparison_to_ast(expression.clone().not()),
        ) else {
            log::info!("branch condition not expressible, exploring both: {expression}");
            return Decision::Explore;
        };
        let defined = self.select_definitions_in(expression);
        let under = |c: ast::Bool| {
            let mut assuming = defined.clone();
            assuming.push(c);
            check(self.computer.solver(), &assuming)
        };
        match (under(holds), under(fails)) {
            (SatResult::Unsat, SatResult::Unsat) => Decision::Unreachable,
            (SatResult::Sat, SatResult::Unsat) => Decision::Take(true),
            (SatResult::Unsat, _) => Decision::Take(false),
            (SatResult::Unknown, SatResult::Unsat) => Decision::Take(true),
            _ => Decision::Explore,
        }
    }
}

#[derive(Clone)]
pub enum AnyEngine {
    Aarch64(Box<ExecutionEngine>),
    X86_64(Box<crate::x86::engine::ExecutionEngine>),
}

macro_rules! forward {
    ($self:ident, $engine:ident => $call:expr) => {
        match $self {
            AnyEngine::Aarch64($engine) => $call,
            AnyEngine::X86_64($engine) => $call,
        }
    };
}

impl AnyEngine {
    pub fn new<S: Into<String>>(lines: impl IntoIterator<Item = S>) -> AnyEngine {
        let lines: Vec<String> = lines.into_iter().map(Into::into).collect();
        match Isa::detect(&lines) {
            Isa::Aarch64 => AnyEngine::Aarch64(Box::new(ExecutionEngine::new(lines))),
            Isa::X86_64 => {
                AnyEngine::X86_64(Box::new(crate::x86::engine::ExecutionEngine::new(lines)))
            }
        }
    }

    pub fn isa(&self) -> Isa {
        match self {
            AnyEngine::Aarch64(_) => Isa::Aarch64,
            AnyEngine::X86_64(_) => Isa::X86_64,
        }
    }

    pub fn add_region(
        &mut self,
        ty: RegionType,
        base: impl Into<String>,
        length: AbstractExpression,
    ) {
        forward!(self, e => e.add_region(ty, base, length))
    }

    pub fn add_immediate(&mut self, register: impl Into<String>, value: usize) {
        forward!(self, e => e.add_immediate(register, value))
    }

    pub fn add_abstract(&mut self, register: impl Into<String>, value: AbstractExpression) {
        forward!(self, e => e.add_abstract(register, value))
    }

    pub fn add_abstract_to_memory(
        &mut self,
        region: impl Into<String>,
        address: i64,
        value: AbstractExpression,
    ) {
        forward!(self, e => e.add_abstract_to_memory(region, address, value))
    }

    pub fn add_abstract_expression_from(&mut self, register: usize, value: AbstractExpression) {
        forward!(self, e => e.add_abstract_expression_from(register, value))
    }

    pub fn add_abstract_from(&mut self, register: usize, value: impl Into<String>) {
        forward!(self, e => e.add_abstract_from(register, value))
    }

    pub fn add_element_fact(
        &mut self,
        region: impl Into<String>,
        index: i64,
        element_size: i64,
        symbol: impl Into<String>,
    ) {
        forward!(self, e => e.add_element_fact(region, index, element_size, symbol))
    }

    pub fn add_pointer_elements(&mut self, region: impl Into<String>, target: impl Into<String>) {
        forward!(self, e => e.add_pointer_elements(region, target))
    }

    pub fn add_element_range(
        &mut self,
        region: impl Into<String>,
        element_size: i64,
        signed: bool,
        op: &str,
        bound: AbstractExpression,
    ) {
        forward!(self, e => e.add_element_range(region, element_size, signed, op, bound))
    }

    pub fn unread_element_facts(&self) -> Vec<String> {
        forward!(self, e => e.unread_element_facts())
    }

    pub fn allow_red_zone(&mut self, bytes: i64) {
        forward!(self, e => e.allow_red_zone(bytes))
    }

    pub fn findings(&self) -> Vec<String> {
        forward!(self, e => e.findings())
    }

    pub fn get_register_output(&self, register: usize) -> RegisterValue {
        forward!(self, e => e.get_register_output(register))
    }

    pub fn address_of(&self, name: &str) -> Option<i64> {
        forward!(self, e => e.address_of(name))
    }

    pub fn line_for_address(&self, address: i64) -> Option<usize> {
        forward!(self, e => e.line_for_address(address))
    }

    pub fn set_step_budget(&mut self, steps: usize) {
        forward!(self, e => e.set_step_budget(steps))
    }

    pub fn dont_fail_fast(&mut self) {
        forward!(self, e => e.dont_fail_fast())
    }

    pub fn change_alignment(&mut self, value: i64) {
        forward!(self, e => e.change_alignment(value))
    }

    pub fn pin(&mut self, symbol: &str, value: i64) {
        forward!(self, e => e.pin(symbol, value))
    }

    pub fn add_invariant(&self, constraint: AbstractComparison) {
        forward!(self, e => e.add_invariant(constraint))
    }

    pub fn start(&mut self, start: impl Into<String>) -> std::io::Result<()> {
        forward!(self, e => e.start(start))
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_label_parsing_simple() {
        let asm = vec!["start:".to_string(), "add x0, x1, x2".to_string()];

        let engine = ExecutionEngine::new(asm);

        let labels: Vec<(String, usize)> = engine.program.labels.clone();
        assert_eq!(labels.len(), 1);
        assert_eq!(labels[0], ("start".to_string(), 0));
    }

    #[test]
    fn test_branch_fan_out_hits_exploration_limit() {
        let mut asm = vec!["start:".to_string()];
        for i in 0..29 {
            asm.push(format!("cmp x{i}, #0"));
            asm.push(format!("b.eq next_{i}"));
            asm.push("nop".to_string());
            asm.push(format!("next_{i}:"));
        }
        asm.push("ret".to_string());

        let mut engine = ExecutionEngine::new(asm);
        engine.dont_fail_fast();
        engine.set_step_budget(150);

        let err = engine.start("start").unwrap_err();
        assert!(
            err.to_string().contains("exploration limit reached"),
            "{err}"
        );
    }

    #[test]
    fn a_concrete_loop_longer_than_the_base_budget_runs_to_its_end() {
        let mut asm = vec![
            "start:".to_string(),
            "mov x0, #255".to_string(),
            "round:".to_string(),
        ];
        asm.extend((0..1000).map(|_| "add x1, x1, #1".to_string()));
        asm.push("subs x0, x0, #1".to_string());
        asm.push("b.ne round".to_string());
        asm.push("ret".to_string());
        let mut engine = ExecutionEngine::new(asm);
        assert_eq!(engine.start("start").map_err(|e| e.to_string()), Ok(()));
    }

    #[test]
    fn a_runaway_concrete_loop_is_still_stopped() {
        let asm = vec![
            "start:",
            "mov x0, #0",
            "round:",
            "add x0, x0, #2",
            "cmp x0, #1",
            "b.ne round",
            "ret",
        ];
        let mut engine = ExecutionEngine::new(asm);
        assert!(engine.start("start").is_err());
    }

    #[test]
    fn test_label_offset_counts_from_the_line_after_the_label() {
        let asm = vec!["start:", "add x0, x1, x2", "add x0, x1, x2", "ret"];
        let engine = ExecutionEngine::new(asm);
        assert_eq!(engine.resolve_jump_target("start+0x0", 0).unwrap(), 1);
        assert_eq!(engine.resolve_jump_target("start+0x4", 0).unwrap(), 2);
    }

    #[test]
    fn test_label_parsing_multi() {
        let asm = vec![
            "start:".to_string(),
            "add x0, x1, x2".to_string(),
            "add x0, x1, x2".to_string(),
            "add x0, x1, x2".to_string(),
            "end:".to_string(),
            "ret".to_string(),
        ];

        let engine = ExecutionEngine::new(asm);

        let labels: Vec<(String, usize)> = engine.program.labels.clone();
        assert_eq!(labels.len(), 2);
        assert_eq!(labels[0], ("start".to_string(), 0));
        assert_eq!(labels[1], ("end".to_string(), 4));
    }

    fn summarized_register(summary: &Summary, index: usize) -> &RegisterValue {
        summary
            .updates
            .iter()
            .find(|(i, _)| *i == index)
            .map(|(_, r)| r)
            .expect("register summarized")
    }

    fn summaries_of(stride: i64, body: &[&str]) -> Vec<Summary> {
        let mut program = vec!["start:", "add x1,x0,x1", "loop:", "cmp x0,x1", "b.eq end"]
            .into_iter()
            .map(String::from)
            .collect::<Vec<_>>();
        program.extend(body.iter().map(|s| s.to_string()));
        program.push(format!("add x0,x0,#{stride}"));
        program.extend(["b loop", "end:", "ret"].iter().map(|s| s.to_string()));

        let mut engine = ExecutionEngine::new(program);
        engine.add_abstract_from(0, "base".to_string());
        engine.add_region(
            RegionType::READ,
            "base".to_string(),
            AbstractExpression::Abstract("length".to_string()),
        );
        engine.add_abstract_from(1, "length".to_string());
        let _ = engine.start("start".to_string());
        engine.summaries.borrow().clone()
    }

    #[test]
    fn walking_register_is_summarized_as_linear() {
        let summaries = summaries_of(4, &[]);
        assert_eq!(summaries.len(), 1);
        assert_eq!(
            summaries[0].invariants[0],
            LoopInvariant::Linear(AbstractExpression::Immediate(4))
        );
    }

    #[test]
    fn walking_register_advances_by_the_counter() {
        let summaries = summaries_of(4, &[]);
        let x0 = format!("{:?}", summarized_register(&summaries[0], 0));
        assert!(x0.contains(summaries[0].counter.name()), "{x0}");
    }

    #[test]
    fn summary_is_recorded_against_the_branch_pc() {
        let summaries = summaries_of(4, &[]);
        assert_eq!(summaries[0].pc, 4);
    }

    #[test]
    fn summary_is_tagged_with_the_enclosing_label() {
        let summaries = summaries_of(4, &[]);
        assert_eq!(summaries[0].label.as_deref(), Some("loop"));
    }

    #[test]
    fn counter_is_named_from_the_loop_id() {
        let summaries = summaries_of(4, &[]);
        assert_eq!(summaries[0].id, LoopId::new(0));
        assert_eq!(summaries[0].counter.name(), "loop0_?");
    }

    #[test]
    fn each_detection_gets_a_distinct_id() {
        let mut engine = ExecutionEngine::new(vec![
            "start:",
            "add x1,x0,x1",
            "add x2,x0,#0",
            "first:",
            "cmp x0,x1",
            "b.eq second",
            "add x0,x0,#4",
            "b first",
            "second:",
            "cmp x2,x1",
            "b.eq end",
            "add x2,x2,#8",
            "b second",
            "end:",
            "ret",
        ]);
        engine.add_abstract_from(0, "base");
        engine.add_region(RegionType::READ, "base", abstract_of("length"));
        engine.add_abstract_from(1, "length");
        let _ = engine.start("start");

        assert_ids_are_distinct(&engine);
    }

    #[test]
    fn detections_in_sibling_branches_get_distinct_ids() {
        let mut engine = ExecutionEngine::new(vec![
            "start:",
            "add x1,x0,x1",
            "cmp x3,#0",
            "b.eq right",
            "left:",
            "cmp x0,x1",
            "b.eq end",
            "add x0,x0,#4",
            "b left",
            "right:",
            "cmp x0,x1",
            "b.eq end",
            "add x0,x0,#8",
            "b right",
            "end:",
            "ret",
        ]);
        engine.add_abstract_from(0, "base");
        engine.add_region(RegionType::READ, "base", abstract_of("length"));
        engine.add_abstract_from(1, "length");
        let _ = engine.start("start");

        assert_ids_are_distinct(&engine);
    }

    #[test]
    fn loop_with_an_unresolvable_branch_in_the_body_is_closed() {
        let mut engine = ExecutionEngine::new(vec![
            "start:",
            "add x1,x0,x1",
            "loop:",
            "cmp x0,x1",
            "b.eq end",
            "add x0,x0,#4",
            "cbz x9, side",
            "b loop",
            "side:",
            "b loop",
            "end:",
            "ret",
        ]);
        engine.add_abstract_from(0, "base");
        engine.add_region(RegionType::READ, "base", abstract_of("length"));
        engine.add_abstract_from(1, "length");
        let _ = engine.start("start");

        assert!(!engine.summaries.borrow().is_empty(), "no acceleration");
        assert!(engine.loops.active.is_empty());
    }

    #[test]
    fn a_growing_stride_over_a_region_is_declined() {
        let mut engine = ExecutionEngine::new(vec![
            "start:",
            "add x1,x0,x1",
            "loop:",
            "cmp x0,x1",
            "b.eq end",
            "add x2,x2,#4",
            "add x0,x0,x2",
            "b loop",
            "end:",
            "ret",
        ]);
        engine.add_abstract_from(0, "base");
        engine.add_region(RegionType::READ, "base", abstract_of("length"));
        engine.add_abstract_from(1, "length");
        let _ = engine.start("start");

        let summaries = engine.summaries.borrow();
        let at_the_loop: Vec<&Summary> = summaries.iter().filter(|s| s.pc == 4).collect();
        assert_eq!(at_the_loop.len(), 0, "summarized: {at_the_loop:?}");
    }

    #[test]
    fn a_forked_engine_drops_what_a_popped_scope_asserted() {
        let mut engine = ExecutionEngine::new(vec!["start:", "ret"]);
        let x = ast::Int::new_const("x");
        let scope = engine.push_scope();
        engine.computer.solver.assert(x.eq(ast::Int::from_i64(1)));
        let mut forked = engine.fork();
        forked.pop_scope(scope);
        forked.computer.solver.assert(x.eq(ast::Int::from_i64(2)));
        assert_eq!(forked.computer.solver.check(), SatResult::Sat);
    }

    #[test]
    fn engine_stays_small_enough_to_clone_per_branch() {
        assert!(
            size_of::<ExecutionEngine>() < 8 * 1024,
            "{} bytes",
            size_of::<ExecutionEngine>()
        );
    }

    fn assert_ids_are_distinct(engine: &ExecutionEngine) {
        let summaries = engine.summaries.borrow();
        let ids: Vec<LoopId> = summaries.iter().map(|s| s.id).collect();
        assert!(ids.len() > 1, "expected more than one detection: {ids:?}");
        let mut seen: Vec<String> = ids.iter().map(|i| format!("{i}")).collect();
        seen.sort();
        seen.dedup();
        assert_eq!(seen.len(), ids.len(), "ids repeat: {ids:?}");
    }

    #[test]
    fn nonlinear_update_is_summarized_as_unknown() {
        let summaries = summaries_of(4, &["mul x3,x3,x3"]);
        assert_eq!(summaries[0].invariants[3], LoopInvariant::Unknown);
    }

    #[test]
    fn widened_register_is_a_fresh_symbol() {
        let summaries = summaries_of(4, &["mul x3,x3,x3"]);
        let x3 = format!("{:?}", summarized_register(&summaries[0], 3));
        assert!(x3.contains("widened"), "{x3}");
    }

    #[test]
    fn untouched_register_is_summarized_as_fixed() {
        let summaries = summaries_of(4, &[]);
        assert_eq!(summaries[0].invariants[5], LoopInvariant::Fixed);
    }

    #[test]
    fn test_running_small_program_no_mem_access() {
        let asm = vec![
            "start:".to_string(),
            "add x0, x1, x2".to_string(),
            "ret".to_string(),
        ];

        let mut engine = ExecutionEngine::new(asm);

        assert!(engine.start("start".to_string()).is_ok());
        assert_eq!(
            engine.computer.registers[0],
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(generate_expression(
                    "+",
                    AbstractExpression::Abstract("x1".to_string()),
                    AbstractExpression::Abstract("x2".to_string())
                )),
                offset: 0,
            }
        )
    }

    #[test]
    fn a_loop_that_fails_to_close_is_not_summarized_again() {
        let mut engine = ExecutionEngine::new(vec![
            "start:",
            "add x1,x0,x1",
            "loop:",
            "cmp x0,x1",
            "b.eq end",
            "add x3,x3,#4",
            "add x2,x2,x3",
            "add x0,x0,#8",
            "b loop",
            "end:",
            "ret",
        ]);
        engine.add_abstract_from(0, "base");
        engine.add_region(RegionType::READ, "base", abstract_of("length"));
        engine.add_abstract_from(1, "length");
        let _ = engine.start("start");

        let summaries = engine.summaries.borrow();
        let at_the_loop: Vec<&Summary> = summaries.iter().filter(|s| s.pc == 4).collect();
        assert_eq!(at_the_loop.len(), 1, "resummarized: {at_the_loop:?}");
    }

    #[test]
    fn a_split_step_is_confirmed_from_a_third_state() {
        let mut engine = ExecutionEngine::new(vec![
            "start:",
            "loop:",
            "cmp x4,#0",
            "b.eq done",
            "add x0,x0,x3",
            "add x0,x0,#8",
            "sub x4,x4,#1",
            "b loop",
            "done:",
            "ret",
        ]);
        engine.add_abstract_from(0, "base");
        engine.add_region(RegionType::RW, "base", AbstractExpression::Immediate(1024));
        engine.add_abstract_from(3, "stride");
        engine.add_abstract_from(4, "count");
        let _ = engine.start("start");

        let summaries = engine.summaries.borrow();
        let summary = summaries.first().expect("the loop was summarized");
        let (_, update) = summary
            .updates
            .iter()
            .find(|(i, _)| *i == 0)
            .expect("x0 has an update");
        let shown = update.base.as_ref().expect("x0 keeps a base").to_string();
        assert!(
            !shown.contains("widened"),
            "x0 was widened instead of stepped: {shown}"
        );
        assert!(
            shown.contains("stride + 8"),
            "the split step was not recognised: {shown}"
        );
    }

    #[test]
    fn a_counter_bound_follows_only_from_a_walk_towards_its_bound() {
        const HALF: i64 = 1 << 31;

        assert_eq!(iterations_before_leaving(">", -1, 0), Some(HALF));
        assert_eq!(iterations_before_leaving(">", -2, 0), Some(HALF / 2));
        assert_eq!(iterations_before_leaving(">=", -4, 0), Some(HALF / 4));
        assert_eq!(iterations_before_leaving("<", 1, 0), Some(HALF + 1));
        assert_eq!(iterations_before_leaving(">", -1, HALF - 2), Some(2));

        assert_eq!(iterations_before_leaving(">", 1, 0), None);
        assert_eq!(iterations_before_leaving("<", -1, 0), None);
        assert_eq!(iterations_before_leaving(">", 0, 0), None);
        assert_eq!(iterations_before_leaving("!=", -1, 0), None);
        assert_eq!(iterations_before_leaving("==", -1, 0), None);
        assert_eq!(iterations_before_leaving(">", -1, HALF), None);
        assert_eq!(iterations_before_leaving("<", 1, -HALF - 1), None);
    }

    #[test]
    fn a_summary_stands_where_the_loop_stood_after_summary_iteration_rounds() {
        let counter = LoopCounter::for_loop(LoopId::new(0));
        let at_summary = |register: &RegisterValue, step: &AbstractExpression| {
            let stepped = stepped_by_the_counter(register, step, &counter);
            let settled = with_counter_at(
                &value_of(&stepped),
                counter.name(),
                &AbstractExpression::Immediate(SUMMARY_ITERATION),
            );
            Affine::of(&settled)
                .and_then(|now| now.combine(&Affine::of_register(register)?, -1))
                .expect("both sides are affine")
        };
        let unchanged = Affine {
            constant: 0,
            terms: Vec::new(),
        };

        let walking = RegisterValue::new(RegisterKind::RegisterBase, Some(abstract_of("dst")), 24);
        assert_eq!(
            at_summary(&walking, &AbstractExpression::Immediate(8)),
            unchanged
        );

        let held = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression(
                "+",
                abstract_of("dst"),
                abstract_of("stride"),
            )),
            8,
        );
        assert_eq!(at_summary(&held, &abstract_of("stride")), unchanged);
    }

    fn history(runs: &[(usize, bool, usize)]) -> Vec<JumpRecord> {
        let mut out = Vec::new();
        for &(pc, taken, times) in runs {
            for _ in 0..times {
                out.push(JumpRecord {
                    point: BranchPoint {
                        pc,
                        condition: AbstractComparison::new(
                            "==",
                            AbstractExpression::Immediate(0),
                            AbstractExpression::Immediate(0),
                        ),
                        state: (vec![RegisterValue::new_imm(0); 33], None, None, None, None),
                        journal_len: 0,
                        slots: Vec::new(),
                        instructions_run: 0,
                    },
                    taken,
                    resolved: false,
                });
            }
        }
        out
    }

    #[test]
    fn a_loop_an_outer_one_re_enters_counts_only_its_latest_run() {
        let mut runs = vec![(7683, true, 5)];
        for _ in 0..4 {
            runs.push((7683, false, 1));
            runs.push((7683, true, 16));
        }
        let history = history(&runs);
        assert_eq!(history.len(), 73);
        assert_eq!(visits_since_the_branch_turned(&history, 7683, true), 16);
    }

    #[test]
    fn a_loop_that_never_leaves_counts_every_visit() {
        let history = history(&[(4833, true, 81)]);
        assert_eq!(visits_since_the_branch_turned(&history, 4833, true), 81);
    }

    #[test]
    fn other_branches_in_the_body_do_not_break_the_run() {
        let mut runs = Vec::new();
        for _ in 0..30 {
            runs.push((4833, true, 1));
            runs.push((4850, true, 1));
        }
        let history = history(&runs);
        assert_eq!(visits_since_the_branch_turned(&history, 4833, true), 30);
    }

    #[test]
    fn a_register_stepping_twice_by_a_symbolic_amount_is_summarized_as_linear() {
        let mut engine = ExecutionEngine::new(vec![
            "start:",
            "add x1,x0,x1",
            "loop:",
            "cmp x0,x1",
            "b.eq end",
            "add x4,x4,x3",
            "add x4,x4,x3",
            "add x0,x0,#8",
            "b loop",
            "end:",
            "ret",
        ]);
        engine.add_abstract_from(0, "base");
        engine.add_region(RegionType::READ, "base", abstract_of("length"));
        engine.add_abstract_from(1, "length");
        engine.add_abstract_from(3, "stride");
        engine.add_abstract_from(4, "aux");
        let _ = engine.start("start");

        let summaries = engine.summaries.borrow();
        let summary = summaries.first().expect("the loop was summarized");
        let LoopInvariant::Linear(step) = &summary.invariants[4] else {
            panic!("x4 was not stepped: {:?}", summary.invariants[4]);
        };
        let twice = Affine::of(&generate_expression(
            "*",
            AbstractExpression::Immediate(2),
            abstract_of("stride"),
        ));
        assert_eq!(Affine::of(step), twice);
    }
}
