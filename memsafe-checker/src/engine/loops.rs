use crate::computer::MAX_EXPRESSION_NODES;
use std::fmt;

const WIDENED_FLOORS: [i64; 7] = [1, 2, 4, 8, 16, 32, 64];
const STACK_REGION: &str = "sp";
const CONFINEMENT_RESOURCE_LIMIT: u32 = 60_000_000;
const STEP_BOUND_RESOURCE_LIMIT: u32 = 2_000_000;
const MAX_STEP_BOUND_NODES: usize = 200;
const MAX_WITHIN_BOUND: i64 = 1 << 16;

use super::*;

enum Obligation {
    Step(usize),
    Cell(MemoryCell),
    Tie(MemoryCell),
    Slots,
    Confined(usize),
    Ghost(Vec<bool>),
    Operand(usize),
    Bound(Bound),
    Carried(usize),
    Settled(usize),
    Chosen(usize),
    Escaped(usize),
}

impl fmt::Display for Obligation {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Obligation::Step(i) => write!(f, "step of x{i}"),
            Obligation::Cell(cell) => write!(f, "cell {}+{}", cell.region, cell.offset),
            Obligation::Tie(cell) => write!(f, "tie of cell {}+{}", cell.region, cell.offset),
            Obligation::Slots => write!(f, "saved slots"),
            Obligation::Confined(i) => write!(f, "width of x{i}"),
            Obligation::Ghost(path) => write!(f, "ghost operand at {path:?}"),
            Obligation::Operand(i) => write!(f, "guard operand x{i}"),
            Obligation::Bound(bound) => write!(f, "bound {}", bound.key()),
            Obligation::Carried(branch) => write!(f, "branch fact of line {branch}"),
            Obligation::Settled(i) => write!(f, "settled step of x{i}"),
            Obligation::Chosen(i) => write!(f, "chosen select of x{i}"),
            Obligation::Escaped(i) => write!(f, "confinement of x{i}"),
        }
    }
}

enum Discharge {
    Closed(bool),
    LeftThrough(usize, Vec<(AbstractComparison, bool)>),
    Refuted,
}

enum Decline {
    AlreadyOpen,
    NotVisited,
    ChangingLoad,
    OutOfTries,
    InsideBody,
    OnOpenCycle(LoopId, usize),
    Fixpoint(LoopId),
    Ascended(LoopId),
    WidensRegion(LoopId, usize, Box<[RegisterValue; 2]>),
    UnprovedAtBase(LoopId, AbstractComparison),
    Contradicts(LoopId),
    LowBitsWalker(usize),
    EscapedLeader(LoopId, usize, usize),
    ConcretelyBounded(usize, i64),
}

impl Decline {
    fn report(&self, pc: usize) {
        match self {
            Decline::AlreadyOpen | Decline::NotVisited => {}
            Decline::ChangingLoad => {
                log::info!("line {pc} tests a load that changed since the last visit, unrolling")
            }
            Decline::ConcretelyBounded(branch, remaining) => log::info!(
                "line {pc} loops through line {branch}, which leaves after {remaining} more concrete iterations, unrolling"
            ),
            Decline::OutOfTries => {
                log::info!(
                    "loop at line {pc} failed {} summaries, unrolling",
                    LOOP_BUDGET.summary_tries
                )
            }
            Decline::InsideBody => {
                log::info!("line {pc} branches inside a loop body, not summarized there")
            }
            Decline::OnOpenCycle(id, at) => {
                log::info!("line {pc} is on the cycle of {id} at line {at}, not summarized again")
            }
            Decline::Fixpoint(id) => {
                log::info!("{id} at line {pc} reached a fixpoint without closing")
            }
            Decline::Ascended(id) => log::error!("{id} at line {pc} exceeded its bound"),
            Decline::WidensRegion(id, i, moved) => log::info!(
                "{id} at line {pc} declined: would widen a region in x{i} (entry {:?} exit {:?})",
                moved[0],
                moved[1]
            ),
            Decline::UnprovedAtBase(id, fact) => log::info!(
                "{id} at line {pc} does not hold {fact} where it is summarized, unrolling"
            ),
            Decline::Contradicts(id) => {
                log::info!("{id} at line {pc} summary contradicts the path, unrolling")
            }
            Decline::LowBitsWalker(i) => log::info!(
                "line {pc} tests the low bits of x{i}, which steps by one, so it exits within a few rounds: unrolling"
            ),
            Decline::EscapedLeader(id, i, j) => log::info!(
                "{id} at line {pc} declined: x{i} follows x{j}, which escaped its confinement"
            ),
        }
    }

    fn counts_as_failure(&self) -> bool {
        matches!(self, Decline::UnprovedAtBase(..) | Decline::Contradicts(_))
    }
}

struct Cycle<L> {
    history: Vec<JumpRecord<L>>,
    index: usize,
    previous: BranchPoint<L>,
    continues: bool,
}

impl<L> Cycle<L> {
    fn walked(&self) -> &[JumpRecord<L>] {
        &self.history[self.index + 1..]
    }

    fn before(&self) -> &[JumpRecord<L>] {
        &self.history[..self.index]
    }
}

type SelectSettlements = BTreeMap<String, Option<AbstractExpression>>;

struct Observation {
    entry: MachineState,
    current: MachineState,
    invariants: Vec<LoopInvariant>,
    guard: AbstractComparison,
    previous_guard: AbstractComparison,
    staying: AbstractComparison,
}

struct Draft {
    summary: Summary,
    settled_steps: Vec<SettledSelectStep>,
    chosen: Vec<ChosenRegister>,
    pinned_selects: Vec<ast::Bool>,
    continuing: AbstractComparison,
    bounds: Vec<Bound>,
    cells: Vec<(MemoryCell, LoopInvariant)>,
    round: usize,
}

impl LoopAttempt {
    fn advance(&self, invariants: Vec<LoopInvariant>, widened: bool) -> Result<Self, Decline> {
        if self.rounds >= LOOP_BUDGET.ascents(invariants.len()) {
            return Err(Decline::Ascended(self.id));
        }
        Ok(LoopAttempt {
            id: self.id,
            invariants,
            rounds: self.rounds + 1,
            widened,
            rejected_bounds: self.rejected_bounds.clone(),
        })
    }
}

#[derive(Clone)]
pub(super) struct PathLoops<M: Machine> {
    pub(super) active: Vec<ActiveLoop>,
    pub(super) attempts: BTreeMap<usize, LoopAttempt>,
    pub(super) rounds: BTreeMap<usize, RoundEntry>,
    pub(super) closed_counters: Vec<(AbstractExpression, Vec<AbstractExpression>)>,
    pub(super) relied_on: Vec<usize>,
    pub(super) pending: Option<(usize, Box<Engine<M>>)>,
    pub(super) value_ranges: BTreeMap<String, i64>,
    pub(super) concrete_latch_visits: BTreeMap<usize, (usize, i64)>,
    pub(super) concrete_latch_ends: BTreeMap<usize, ConcreteLatchEnd>,
    pub(super) costly_latches: BTreeSet<usize>,
}

#[derive(Clone, Copy)]
pub(super) struct ConcreteLatchEnd {
    target: usize,
    continues_at_its_value: bool,
    value: i64,
    closing: Option<i64>,
    visited_at: usize,
}

impl<M: Machine> PathLoops<M> {
    pub(super) fn new() -> Self {
        Self {
            active: Vec::new(),
            attempts: BTreeMap::new(),
            rounds: BTreeMap::new(),
            closed_counters: Vec::new(),
            relied_on: Vec::new(),
            pending: None,
            value_ranges: BTreeMap::new(),
            concrete_latch_visits: BTreeMap::new(),
            concrete_latch_ends: BTreeMap::new(),
            costly_latches: BTreeSet::new(),
        }
    }
}

#[derive(Default, Clone)]
pub(super) struct PcRecord {
    failures: usize,
    refutations: usize,
    cell_retries: usize,
    counted: BTreeSet<(LoopId, usize)>,
    unstable_registers: BTreeSet<usize>,
    unstable_cells: BTreeSet<MemoryCell>,
    wandering_cells: BTreeSet<MemoryCell>,
    unstable_slots: bool,
    uncarried: BTreeSet<usize>,
    select_refuted: bool,
    chosen_refuted: bool,
    unconfinable: BTreeSet<usize>,
    untied_cells: BTreeSet<MemoryCell>,
}

#[derive(Default, Clone)]
pub(super) struct LoopHistory {
    records: BTreeMap<usize, PcRecord>,
    confined_instances: BTreeMap<usize, Vec<usize>>,
    validated_instances: BTreeSet<usize>,
}

struct LoopBudget {
    summary_tries: usize,
    refutations: usize,
    cell_retries: usize,
}

const MAX_CANCELLED_STEP_PIECES: usize = 8;
const MAX_CANCELLED_GROUP: usize = 3;
const MAX_CANCELLATION_PROOFS: usize = 32;

fn index_groups(count: usize, size: usize) -> Vec<Vec<usize>> {
    if size == 0 {
        return vec![Vec::new()];
    }
    (0..count)
        .rev()
        .filter(|&last| last + 1 >= size)
        .flat_map(|last| {
            index_groups(last, size - 1)
                .into_iter()
                .map(move |mut group| {
                    group.push(last);
                    group
                })
        })
        .collect::<Vec<_>>()
        .into_iter()
        .rev()
        .collect()
}

const LOOP_BUDGET: LoopBudget = LoopBudget {
    summary_tries: 3,
    refutations: 8,
    cell_retries: 4,
};

impl LoopBudget {
    fn exhausted(&self, record: &PcRecord) -> bool {
        record.failures >= self.summary_tries || record.refutations >= self.refutations
    }

    fn ascents(&self, components: usize) -> usize {
        max_ascents(components)
    }
}

#[derive(Default, Clone)]
pub(super) struct SummaryLedger {
    next_instance: usize,
    failures: Vec<FailedDischarge>,
    refuted: BTreeSet<usize>,
}

enum Verdict {
    Stands,
    Refuted { retry: Option<LoopAttempt> },
}

#[derive(Clone)]
struct FailedDischarge {
    instance: usize,
    relied_on: Vec<usize>,
    retry: Option<LoopAttempt>,
}

impl SummaryLedger {
    fn refute(&mut self, instance: usize) -> Verdict {
        let Some(failure) = self.failures.iter().find(|failure| {
            failure.instance == instance
                && failure
                    .relied_on
                    .iter()
                    .all(|other| !self.refuted.contains(other))
        }) else {
            return Verdict::Stands;
        };
        let retry = failure.retry.clone();
        self.refuted.insert(instance);
        Verdict::Refuted { retry }
    }
}

const NEIGHBOUR_GAPS: [i64; 6] = [0, 1, 2, 4, 16, 256];
const OBLIGATION_RESOURCE_LIMIT: u32 = 5_000_000;
const OBLIGATION_INCREMENTAL_RESOURCE_LIMIT: u32 = 500_000;

impl<M: Machine> Engine<M> {
    fn record_at<T>(&self, pc: usize, read: impl FnOnce(&PcRecord) -> T) -> T {
        let history = self.loop_history.borrow();
        match history.records.get(&pc) {
            Some(record) => read(record),
            None => read(&PcRecord::default()),
        }
    }

    fn update_record<T>(&self, pc: usize, write: impl FnOnce(&mut PcRecord) -> T) -> T {
        write(
            self.loop_history
                .borrow_mut()
                .records
                .entry(pc)
                .or_default(),
        )
    }

    fn out_of_tries(&self, pc: usize) -> bool {
        self.record_at(pc, |record| LOOP_BUDGET.exhausted(record))
    }

    pub(super) fn validate_summary(
        &mut self,
        instance: usize,
        fallback: Engine<M>,
        next: usize,
        (pc, condition, jump_dest): (usize, AbstractComparison, usize),
        depth: usize,
    ) -> std::io::Result<BranchOutcome> {
        let _resolving = profile::enter(Phase::LoopResolution);
        let explored = self.run(next, depth);
        let unvalidated = {
            let history = self.loop_history.borrow();
            history
                .confined_instances
                .get(&instance)
                .filter(|_| !history.validated_instances.contains(&instance))
                .cloned()
        };
        if let Some(registers) = unvalidated {
            log::info!(
                "summary {instance} at line {pc} relied on confinements no continuing iteration checked, exploring again"
            );
            *self = fallback;
            self.update_record(pc, |record| record.unconfinable.extend(registers));
            self.loops.attempts.remove(&pc);
            let decision = self.decide(pc, depth, &condition);
            return self.follow_branch(pc, condition, decision, jump_dest, depth);
        }
        let Verdict::Refuted { retry } = self.ledger.borrow_mut().refute(instance) else {
            let mut fallback = fallback;
            let continues = next == jump_dest;
            if !matches!(fallback.decide_from_solver(&condition), Decision::Explore) {
                return explored.map(|()| BranchOutcome::BothExplored);
            }
            fallback.loops.attempts.remove(&pc);
            let here = fallback.branch_point(pc, &condition);
            let leaves = if continues { pc + 1 } else { jump_dest };
            let left = fallback.explore_arm(here, !continues, leaves, depth);
            return join_arms(explored, left);
        };
        log::info!("summary {instance} at line {pc} failed its inductive check, exploring again");
        *self = fallback;
        self.update_record(pc, |record| record.refutations += 1);
        match retry {
            Some(attempt) => self.loops.attempts.insert(pc, attempt),
            None => self.loops.attempts.remove(&pc),
        };
        let decision = self.decide(pc, depth, &condition);
        self.follow_branch(pc, condition, decision, jump_dest, depth)
    }

    pub(super) fn memory_free_loop(
        &mut self,
        header: usize,
        end: usize,
    ) -> Option<(Vec<M::Operand>, Vec<usize>)> {
        let _resolving = profile::enter(Phase::LoopResolution);
        let mut written = Vec::new();
        let mut exits = Vec::new();
        let mut conditional_branches = 0;
        let program = Rc::clone(&self.program);
        for pc in header..=end {
            let instruction = program.code.get(pc)?;
            if let Some(destination) = instruction.register_written()? {
                let current = self.computer.get_register(&destination);
                if self.computer.carries_region(&current) {
                    return None;
                }
                if !written.contains(&destination) {
                    written.push(destination);
                }
            }
            if matches!(instruction.flow(), Flow::Branch(_)) {
                conditional_branches += 1;
            }
            if let Some(label) = branch_target(instruction) {
                let target = self.resolve_jump_target(label, pc).ok()?;
                if (target < header || target > end) && !exits.contains(&target) {
                    exits.push(target);
                }
            }
        }
        if conditional_branches < 2 {
            return None;
        }
        if !matches!(self.program.code[end].flow(), Flow::Jump(_)) && !exits.contains(&(end + 1)) {
            exits.push(end + 1);
        }
        Some((written, exits))
    }

    pub(super) fn havoc_memory_free_loop(
        &mut self,
        header: usize,
        written: Vec<M::Operand>,
        exits: Vec<usize>,
        depth: usize,
    ) -> std::io::Result<Step> {
        let _resolving = profile::enter(Phase::LoopResolution);
        profile::loops_back_to(header);
        for register in &written {
            self.computer.set_register(
                register,
                RegisterKind::RegisterBase,
                Some(fresh_unknown()),
                0,
            );
        }
        self.computer.set_unknown_flags();
        log::info!(
            "line {header} starts a memory-free loop; {} registers havocked, exits {exits:?}",
            written.len()
        );
        let Some((&first, rest)) = exits.split_first() else {
            return Ok(Step::Stop);
        };
        for &exit in rest {
            let mut other = self.fork();
            other.run(exit, depth + 1)?;
        }
        Ok(Step::Continue(first))
    }

    pub(super) fn evaluate_branch_condition(
        &mut self,
        pc: usize,
        depth: usize,
        expression: &mut AbstractComparison,
    ) -> Option<bool> {
        log::info!("jump condition: {}", expression.clone());

        if let Some(active) = self.loops.active.last().cloned()
            && active.pc == pc
        {
            match self.discharge_active_loop(active, expression.clone()) {
                Discharge::Closed(decision) => return Some(decision),
                Discharge::Refuted => {
                    self.path_ends = true;
                    return None;
                }
                Discharge::LeftThrough(exit, prefix) => {
                    if self.repeat_round(pc, exit, &prefix, expression) {
                        return None;
                    }
                }
            }
        }
        self.decide(pc, depth, expression)
    }

    fn decide(&mut self, pc: usize, depth: usize, expression: &AbstractComparison) -> Option<bool> {
        match self.decide_from_solver(expression) {
            Decision::Unreachable => {
                log::info!("line {pc} is unreachable on this path");
                self.path_ends = true;
                None
            }
            Decision::Take(taken)
                if self.repeats_unboundedly(pc, taken, expression)
                    || self.unrolling_costs_too_much(pc, taken, expression)
                    || self.unrolling_runs_out_of_revisits(pc, taken, expression) =>
            {
                self.try_summarize(pc, depth, expression).or(Some(taken))
            }
            Decision::Take(taken) => Some(taken),
            Decision::Explore => self.try_summarize(pc, depth, expression),
        }
    }

    fn unrolling_runs_out_of_revisits(
        &self,
        pc: usize,
        taken: bool,
        expression: &AbstractComparison,
    ) -> bool {
        if self.loops.active.iter().any(|open| open.pc == pc) {
            return false;
        }
        let visits = visits_since_the_branch_turned(&self.jump_history, pc, taken);
        if visits + 2 != self.revisit_cap() {
            return false;
        }
        let Some(last) = self
            .jump_history
            .iter()
            .rev()
            .find(|record| record.point.pc == pc && !record.resolved)
        else {
            return false;
        };
        let distance_of = |condition: &AbstractComparison| {
            expression_to_ast(generate_expression(
                "-",
                (*condition.left).clone(),
                (*condition.right).clone(),
            ))
        };
        let (Some(now), Some(before)) =
            (distance_of(expression), distance_of(&last.point.condition))
        else {
            return false;
        };
        let Some(closing) = ast::Int::sub(&[&before, &now]).simplify().as_i64() else {
            return false;
        };
        if closing == 0 {
            return false;
        }
        let misses_the_exit = now
            .modulo(ast::Int::from_i64(closing.abs()))
            .eq(ast::Int::from_i64(0))
            .not();
        let runs_out = !matches!(expression.op.as_str(), "==" | "!=")
            || self.computer.solver().check_assumptions(&[misses_the_exit]) == SatResult::Unsat;
        if runs_out {
            log::info!("line {pc} is about to exhaust its {visits} revisits, summarizing instead");
        }
        runs_out
    }

    fn repeats_unboundedly(&self, pc: usize, taken: bool, expression: &AbstractComparison) -> bool {
        let _resolving = profile::enter(Phase::LoopResolution);
        if expression.get_abstracts().is_empty()
            || self.loops.active.iter().any(|open| open.pc == pc)
        {
            return false;
        }
        let mut visits = self
            .jump_history
            .iter()
            .rev()
            .filter(|record| record.point.pc == pc && !record.resolved)
            .take_while(|record| record.taken == taken);
        let progresses = visits
            .next()
            .is_some_and(|last| last.point.condition != *expression);
        progresses
            && 1 + visits.count() >= DECIDED_REPEATS_BEFORE_SUMMARY
            && self.bounded_guard(pc).is_none()
    }

    pub(super) fn costly_concrete_latch(
        &mut self,
        pc: usize,
        instruction: &M::Instruction,
        result: &Result<ExecuteReturnType<M::Operand>, String>,
    ) -> Option<(AbstractComparison, String)> {
        let _resolving = profile::enter(Phase::LoopResolution);
        let (op, tested, label, width) = match instruction.zero_test() {
            Some((op, tested, label)) => (op, tested.clone(), label.to_string(), 8),
            None => {
                let Flow::Branch(label) = instruction.flow() else {
                    return None;
                };
                let (op, tested, width) = M::Instruction::flag_zero_latch(&self.program.code, pc)?;
                (op, tested, label.to_string(), width)
            }
        };
        let costly = self.loops.costly_latches.contains(&pc);
        match result {
            Ok(ExecuteReturnType::Next | ExecuteReturnType::JumpLabel(_)) => {}
            Ok(ExecuteReturnType::ConditionalJumpLabel(..)) if costly => {}
            _ => return None,
        }
        let target = self.get_linenumber_of_label(label.clone(), pc)?;
        if target > pc {
            return None;
        }
        let tested = self.computer.get_register(&tested);
        let symbolic = tested.base.is_some();
        if tested.kind == RegisterKind::Number || (symbolic && !costly) {
            return None;
        }
        let value = signed_at_width(tested.offset, width);
        let leaf = AbstractExpression::Register(Box::new(tested.clone()));
        let compared = if value == tested.offset && !(symbolic && width < 8) {
            leaf
        } else {
            let half = 1i64 << (width * 8 - 1);
            let shifted = generate_expression("+", leaf, AbstractExpression::Immediate(half));
            let wrapped = generate_expression(
                "%",
                shifted,
                AbstractExpression::Immediate(1i64 << (width * 8)),
            );
            generate_expression("-", wrapped, AbstractExpression::Immediate(half))
        };
        let condition = AbstractComparison::new(op, AbstractExpression::Immediate(0), compared);
        if costly {
            return Some((condition, label));
        }
        let now = (self.instructions_run, value);
        let closing = self
            .loops
            .concrete_latch_visits
            .get(&pc)
            .map(|(_, before)| before - value);
        self.loops.concrete_latch_ends.insert(
            pc,
            ConcreteLatchEnd {
                target,
                continues_at_its_value: match op {
                    "!=" => value != 0,
                    "==" => value == 0,
                    "<" => 0 < value,
                    "<=" => 0 <= value,
                    ">" => 0 > value,
                    ">=" => 0 >= value,
                    _ => false,
                },
                value,
                closing,
                visited_at: self.instructions_run,
            },
        );
        if let Some((run_before, value_before)) = self.loops.concrete_latch_visits.insert(pc, now) {
            let closing = value_before - value;
            let per_iteration = (self.instructions_run - run_before) as i64;
            if closing != 0 && value.signum() == closing.signum() && value % closing == 0 {
                let remaining = value / closing;
                if remaining.saturating_mul(per_iteration) > UNROLLING_INSTRUCTION_BUDGET
                    || remaining as usize >= MAX_UNCONDITIONAL_REVISITS
                {
                    log::info!(
                        "line {pc} would unroll {remaining} more iterations of {per_iteration} instructions, tracking it as a loop guard"
                    );
                    self.loops.costly_latches.insert(pc);
                    return Some((condition, label));
                }
            }
        }
        None
    }

    fn concretely_bounded_branch(
        &self,
        pc: usize,
        cycle: &Cycle<M::LoopLanes>,
    ) -> Option<(usize, i64)> {
        let since = cycle.previous.instructions_run;
        let per_iteration = self.instructions_run.saturating_sub(since) as i64;
        self.loops
            .concrete_latch_ends
            .iter()
            .find_map(|(&latch, end)| {
                let remaining = match end.closing {
                    _ if !end.continues_at_its_value => return None,
                    Some(0) => return None,
                    Some(closing)
                        if end.value.signum() == closing.signum() && end.value % closing == 0 =>
                    {
                        end.value / closing
                    }
                    Some(_) => return None,
                    None => end.value.abs(),
                };
                (end.target <= pc
                    && pc < latch
                    && end.visited_at >= since
                    && remaining.saturating_mul(per_iteration) <= UNROLLING_INSTRUCTION_BUDGET
                    && remaining as usize <= self.revisit_cap())
                .then_some((latch, remaining))
            })
    }

    fn unrolling_costs_too_much(
        &self,
        pc: usize,
        taken: bool,
        expression: &AbstractComparison,
    ) -> bool {
        let _resolving = profile::enter(Phase::LoopResolution);
        if self.loops.active.iter().any(|open| open.pc == pc) {
            return false;
        }
        let mut visits = self
            .jump_history
            .iter()
            .rev()
            .filter(|record| record.point.pc == pc && !record.resolved)
            .take_while(|record| record.taken == taken);
        let Some(last) = visits.next() else {
            return false;
        };
        if 1 + visits.count() < DECIDED_REPEATS_BEFORE_SUMMARY {
            return false;
        }
        let distance_of = |condition: &AbstractComparison| {
            expression_to_ast(generate_expression(
                "-",
                (*condition.left).clone(),
                (*condition.right).clone(),
            ))?
            .simplify()
            .as_i64()
        };
        let (Some(now), Some(before)) =
            (distance_of(expression), distance_of(&last.point.condition))
        else {
            return false;
        };
        let closing = before - now;
        if closing == 0 || now.signum() != closing.signum() {
            return false;
        }
        let per_iteration = (self.instructions_run - last.point.instructions_run) as i64;
        let remaining = now / closing;
        let costs_too_much = remaining.saturating_mul(per_iteration) > UNROLLING_INSTRUCTION_BUDGET
            || remaining as usize > self.revisit_cap();
        if costs_too_much {
            log::info!(
                "line {pc} would unroll {remaining} more iterations of {per_iteration} instructions, summarizing instead"
            );
        }
        costs_too_much
    }

    fn invariants_while_staying(
        &self,
        (condition, previous_condition): (&AbstractComparison, &AbstractComparison),
        continues_when: bool,
        tested: &[AbstractComparison],
        entry_state: &mut MachineState,
        current_state: &mut MachineState,
    ) -> (Vec<LoopInvariant>, AbstractComparison, AbstractComparison) {
        self.while_staying(condition, continues_when, |engine| {
            let mut settlements = SelectSettlements::new();
            engine.resolve_selects(entry_state, &mut settlements);
            engine.resolve_selects(current_state, &mut settlements);
            let mut resolved = |guard: &AbstractComparison| {
                AbstractComparison::new(
                    &guard.op,
                    engine.resolved_leaves(&guard.left, &mut settlements),
                    engine.resolved_leaves(&guard.right, &mut settlements),
                )
            };
            let resolved_guard = resolved(condition);
            let resolved_previous_guard = resolved(previous_condition);
            let mut observed = invariant_of_registers(&entry_state.0, &current_state.0);
            engine.pin_unknown_steps(
                &mut observed,
                &entry_state.0,
                &current_state.0,
                condition,
                tested,
            );
            (observed, resolved_guard, resolved_previous_guard)
        })
    }

    fn while_staying<T>(
        &self,
        condition: &AbstractComparison,
        continues_when: bool,
        within: impl FnOnce(&Self) -> T,
    ) -> T {
        let staying = comparison_to_ast(if continues_when {
            condition.clone()
        } else {
            condition.clone().not()
        });
        self.computer.solver().push();
        if let Some(staying) = staying {
            self.computer.solver().assert(staying);
        }
        let result = within(self);
        self.computer.solver().pop(1);
        result
    }

    fn pin_unknown_steps(
        &self,
        observed: &mut [LoopInvariant],
        entry: &[RegisterValue],
        current: &[RegisterValue],
        guard: &AbstractComparison,
        tested: &[AbstractComparison],
    ) {
        let mut in_guard = guard.get_abstracts();
        in_guard.sort();
        in_guard.dedup();
        let named_in_guard = |r: &RegisterValue| {
            r.base
                .as_ref()
                .is_some_and(|b| b.get_abstracts().iter().any(|n| in_guard.contains(n)))
        };
        for (i, invariant) in observed.iter_mut().enumerate() {
            if !matches!(invariant, LoopInvariant::Unknown) {
                continue;
            }
            let (Some(prev), Some(cur)) = (entry.get(i), current.get(i)) else {
                continue;
            };
            if prev.kind == RegisterKind::Number || cur.kind == RegisterKind::Number {
                continue;
            }
            let unchanged = generate_expression("-", cur.expression(), prev.expression());
            if prev != cur
                && is_translatable(&unchanged)
                && unchanged.size() <= MAX_EXPRESSION_NODES
                && self.proves_with_selects(AbstractComparison::new(
                    "==",
                    unchanged,
                    AbstractExpression::Immediate(0),
                ))
            {
                log::info!("x{i} is unchanged on this path");
                *invariant = LoopInvariant::Fixed;
                continue;
            }
            if !(self.computer.carries_region(prev)
                || self.computer.carries_region(cur)
                || named_in_guard(prev)
                || named_in_guard(cur))
            {
                continue;
            }
            let step = generate_expression("-", cur.expression(), prev.expression());
            let pinnable = is_translatable(&step) && step.size() <= MAX_EXPRESSION_NODES;
            if let Some(value) = pinnable.then(|| self.pinned_value(&step)).flatten() {
                log::info!("x{i} step pinned to {value} by the path");
                *invariant = LoopInvariant::Linear(AbstractExpression::Immediate(value));
            } else if let Some(kept) = self.step_without_cancelling_terms(prev, cur) {
                log::info!("x{i} step reduced to {kept} by terms the path cancels");
                *invariant = LoopInvariant::Linear(kept);
            }
        }
        let registers = observed.len().min(entry.len()).min(current.len());
        let guarded = registers_in(guard);
        let compared: Vec<RegisterValue> = tested.iter().flat_map(registers_in).collect();
        let mut at_entry: Vec<String> = entry
            .iter()
            .filter_map(|r| r.base.as_ref())
            .flat_map(|b| b.get_abstracts())
            .collect();
        at_entry.sort();
        at_entry.dedup();
        let fresh_data_step = |j: usize, invariant: &LoopInvariant| {
            if !matches!(invariant, LoopInvariant::Unknown | LoopInvariant::Linear(_)) {
                return None;
            }
            let step = step_form(&entry[j], &current[j])?;
            let fresh = !step.terms.is_empty()
                && step.terms.keys().all(|name| {
                    at_entry.binary_search(name).is_err() && !LoopSymbol::names_any(name)
                });
            fresh.then_some(step)
        };
        for i in 0..registers {
            if !(self.computer.carries_region(&entry[i])
                || self.computer.carries_region(&current[i]))
            {
                continue;
            }
            let Some(follower) = fresh_data_step(i, &observed[i]) else {
                continue;
            };
            let leader = (0..registers).find_map(|j| {
                if j == i
                    || self.computer.carries_region(&entry[j])
                    || self.computer.carries_region(&current[j])
                    || !(guarded.contains(&current[j])
                        || compared.contains(&current[j])
                        || compared.contains(&entry[j]))
                {
                    return None;
                }
                let leader = step_form(&entry[j], &current[j])?;
                proportion(&follower, &leader).map(|k| (j, k))
            });
            if let Some((j, k)) = leader {
                log::info!("x{i} moves by {k} times x{j} each iteration");
                observed[i] = LoopInvariant::Tracks(j, k);
                if fresh_data_step(j, &observed[j]).is_some() {
                    let step =
                        generate_expression("-", current[j].expression(), entry[j].expression());
                    let signed = |op: &str| {
                        self.proves(AbstractComparison::new(
                            op,
                            step.clone(),
                            AbstractExpression::Immediate(0),
                        ))
                    };
                    observed[j] = if signed(">=") {
                        LoopInvariant::NonDecreasing
                    } else if signed("<=") {
                        LoopInvariant::NonIncreasing
                    } else {
                        LoopInvariant::Unknown
                    };
                }
            }
        }
        let demoted = self.demote_varying_steps(observed.to_vec(), entry);
        observed.clone_from_slice(&demoted);
        for i in 0..registers {
            if !matches!(observed[i], LoopInvariant::Unknown)
                || !(self.computer.carries_region(&entry[i])
                    || self.computer.carries_region(&current[i]))
            {
                continue;
            }
            let moved = generate_expression("-", current[i].expression(), entry[i].expression());
            let leader = (0..registers)
                .filter(|&j| {
                    j != i
                        && !self.computer.carries_region(&entry[j])
                        && !self.computer.carries_region(&current[j])
                        && entry[j].kind == RegisterKind::RegisterBase
                        && current[j].kind == RegisterKind::RegisterBase
                        && entry[j] != current[j]
                })
                .find_map(|j| {
                    let led =
                        generate_expression("-", current[j].expression(), entry[j].expression());
                    log::info!("x{i} moved {moved}; candidate x{j} moved {led}");
                    [-1i64, 1, -2, 2, -4, 4, -8, 8].into_iter().find_map(|k| {
                        self.proves_with_selects(AbstractComparison::new(
                            "==",
                            moved.clone(),
                            generate_expression("*", AbstractExpression::Immediate(k), led.clone()),
                        ))
                        .then_some((j, k))
                    })
                });
            if let Some((j, k)) = leader {
                log::info!("x{i} provably moves by {k} times x{j} each iteration");
                observed[i] = LoopInvariant::Tracks(j, k);
            }
        }
        let mut packs: Vec<(usize, LinearForm)> = Vec::new();
        for i in 0..registers {
            if !matches!(observed[i], LoopInvariant::Unknown)
                || !(self.computer.carries_region(&entry[i])
                    || self.computer.carries_region(&current[i]))
            {
                continue;
            }
            let Some(step) = step_form(&entry[i], &current[i]) else {
                continue;
            };
            if step.terms.is_empty() {
                continue;
            }
            match packs.iter().find(|(_, leader)| *leader == step) {
                Some(&(j, _)) => {
                    log::info!("x{i} moves with x{j} each iteration");
                    observed[i] = LoopInvariant::Tracks(j, 1);
                }
                None => packs.push((i, step)),
            }
        }
        self.derive_from_leaders(observed, entry, current);
    }

    fn derive_from_leaders(
        &self,
        observed: &mut [LoopInvariant],
        entry: &[RegisterValue],
        current: &[RegisterValue],
    ) {
        let registers = observed.len().min(entry.len()).min(current.len());
        for i in 0..registers {
            if observed[i] != LoopInvariant::Unknown
                || entry[i].kind != RegisterKind::RegisterBase
                || current[i].kind != RegisterKind::RegisterBase
                || self.computer.carries_region(&entry[i])
                || self.computer.carries_region(&current[i])
            {
                continue;
            }
            let derived = (0..registers).find_map(|j| {
                if j == i || !matches!(observed[j], LoopInvariant::Linear(_)) {
                    return None;
                }
                self.template_following(&entry[i], &current[i], &entry[j], &current[j])
                    .map(|template| (j, template))
            });
            if let Some((j, template)) = derived {
                log::info!("x{i} is {template} of x{j} at every visit");
                observed[i] = LoopInvariant::Derived(j, template);
            }
        }
    }

    fn follows(
        &self,
        template: &AbstractExpression,
        leader: &RegisterValue,
        follower: &RegisterValue,
    ) -> bool {
        if follower.kind != RegisterKind::RegisterBase {
            return false;
        }
        let rebuilt = substitute(template, DERIVED_LEADER, &value_of(leader));
        let held = value_of(follower);
        rebuilt == held
            || (expression_to_ast(rebuilt.clone()).is_some()
                && expression_to_ast(held.clone()).is_some()
                && self.proves(AbstractComparison::new("==", rebuilt, held)))
    }

    fn template_following(
        &self,
        follower_then: &RegisterValue,
        follower_now: &RegisterValue,
        leader_then: &RegisterValue,
        leader_now: &RegisterValue,
    ) -> Option<AbstractExpression> {
        let then = value_of(follower_then);
        let now = value_of(follower_now);
        let leader_then = value_of(leader_then);
        let leader_now = value_of(leader_now);
        if then.size() > MAX_EXPRESSION_NODES || expression_to_ast(now.clone()).is_none() {
            return None;
        }
        let placeholder = AbstractExpression::Abstract(DERIVED_LEADER.to_string());
        subexpressions(&then)
            .into_iter()
            .filter(|node| !matches!(node, AbstractExpression::Immediate(_)) && *node != then)
            .find_map(|node| {
                let offset = generate_expression("-", node.clone(), leader_then.clone());
                if offset.size() > MAX_EXPRESSION_NODES {
                    return None;
                }
                let template = replaced(
                    &then,
                    &node,
                    &generate_expression("+", placeholder.clone(), offset),
                );
                let reproduces = |leader: &AbstractExpression, follower: &AbstractExpression| {
                    substitute(&template, DERIVED_LEADER, leader) == *follower
                };
                (reproduces(&leader_then, &then) && reproduces(&leader_now, &now))
                    .then_some(template)
            })
    }

    fn try_summarize(
        &mut self,
        pc: usize,
        depth: usize,
        expression: &AbstractComparison,
    ) -> Option<bool> {
        let _resolving = profile::enter(Phase::LoopResolution);
        match self.summarize_loop(pc, depth, expression) {
            Ok(decision) => Some(decision),
            Err(decline) => {
                decline.report(pc);
                if decline.counts_as_failure() {
                    self.update_record(pc, |record| record.failures += 1);
                }
                None
            }
        }
    }

    fn summarize_loop(
        &mut self,
        pc: usize,
        depth: usize,
        expression: &AbstractComparison,
    ) -> Result<bool, Decline> {
        let cycle = self.locate_cycle(pc, expression)?;
        if let Some((branch, remaining)) = self.concretely_bounded_branch(pc, &cycle) {
            return Err(Decline::ConcretelyBounded(branch, remaining));
        }
        let mut observation = self.observe(pc, expression, &cycle)?;
        let guard = observation.guard.clone();
        let expression = &guard;
        let (attempt, confined) = self.next_attempt(pc, expression, &observation)?;
        let cells = self.abstract_cells(pc, &cycle);
        let mut draft =
            self.draft_summary(pc, expression, &cycle, &attempt, &mut observation, cells);
        self.loops.attempts.insert(pc, attempt);
        self.justify_facts(pc, expression, &cycle, &mut draft.summary)?;
        self.install(pc, depth, &cycle, observation, draft, confined)
    }

    fn locate_cycle(
        &self,
        pc: usize,
        expression: &AbstractComparison,
    ) -> Result<Cycle<M::LoopLanes>, Decline> {
        if self.loops.active.iter().any(|open| open.pc == pc) {
            return Err(Decline::AlreadyOpen);
        }
        let history = self.jump_history.clone();
        let this_iteration = self
            .loops
            .active
            .last()
            .map_or(0, |open| open.history_len.min(history.len()));
        let (index, record) = history
            .iter()
            .enumerate()
            .skip(this_iteration)
            .rev()
            .find(|(_, record)| record.point.pc == pc)
            .ok_or(Decline::NotVisited)?;
        let (previous, continues) = (record.point.clone(), record.taken);
        if self.reads_a_changing_load(expression, &previous.state) {
            return Err(Decline::ChangingLoad);
        }
        if self.out_of_tries(pc) {
            return Err(Decline::OutOfTries);
        }
        if let Some((source, header, walked)) =
            self.cycle_back_edge(pc, continues, &history[index + 1..])
            && let Some(successors) = self.static_successors(pc)
            && let [target, fallthrough] = successors.as_slice()
            && let other = if continues { *fallthrough } else { *target }
            && !self.can_leave_cycle(other, &walked)
            && (self.stays_in_loop(other, header, source, pc != source)
                || (pc == source
                    && self.stays_in_loop(other, header, source, true)
                    && self.exits_elsewhere(pc, &walked)))
        {
            return Err(Decline::InsideBody);
        }
        if let Some((_, _, walked)) = self.cycle_back_edge(pc, continues, &history[index + 1..])
            && let Some(open) = self
                .loops
                .active
                .iter()
                .find(|open| walked.contains(&open.pc))
        {
            return Err(Decline::OnOpenCycle(open.id, open.pc));
        }
        Ok(Cycle {
            history,
            index,
            previous,
            continues,
        })
    }

    fn observe(
        &mut self,
        pc: usize,
        expression: &AbstractComparison,
        cycle: &Cycle<M::LoopLanes>,
    ) -> Result<Observation, Decline> {
        let mut entry = cycle.previous.state.clone();
        self.forget_dead_registers(pc, expression, cycle.continues, &mut [&mut entry]);
        let mut current = self.computer.get_state();
        let tested: Vec<AbstractComparison> = cycle
            .walked()
            .iter()
            .map(|record| record.point.condition.clone())
            .collect();
        let (invariants, guard, previous_guard) = self.invariants_while_staying(
            (expression, &cycle.previous.condition),
            cycle.continues,
            &tested,
            &mut entry,
            &mut current,
        );
        let visits: Vec<&MachineState> = cycle
            .history
            .iter()
            .filter(|record| record.point.pc == pc)
            .map(|record| &record.point.state)
            .collect();
        let mut invariants = invariants;
        self.step_past_inner_loops(&mut invariants, &entry, &current, &visits);
        let mut invariants = self.demote_varying_steps(invariants, &entry.0);
        let read_by_guard = registers_in(expression);
        let candidates: Vec<usize> = (0..current.0.len())
            .filter(|&i| !read_by_guard.contains(&current.0[i]))
            .collect();
        if let Some(group) = values_kept_within_a_group(&entry.0, &current.0, &candidates) {
            log::info!("line {pc}: registers {group:?} only exchange their values each round");
            for &i in &group {
                invariants[i] = LoopInvariant::OneOf(group.clone());
            }
        }
        let staying = if cycle.continues {
            expression.clone()
        } else {
            expression.clone().not()
        };
        if let Some(i) = unit_walker_under_a_low_bits_test(
            &invariants,
            &current.0,
            tested.iter().chain([&staying]),
        ) {
            return Err(Decline::LowBitsWalker(i));
        }
        Ok(Observation {
            entry,
            current,
            invariants,
            guard,
            previous_guard,
            staying,
        })
    }

    fn next_attempt(
        &self,
        pc: usize,
        expression: &AbstractComparison,
        observation: &Observation,
    ) -> Result<(LoopAttempt, Vec<Confinement>), Decline> {
        let observed = &observation.invariants;
        let mut attempt = match self.loops.attempts.get(&pc) {
            Some(earlier) if earlier.widened => LoopAttempt {
                widened: false,
                ..earlier.clone()
            },
            Some(earlier) => {
                let joined = join_all(&earlier.invariants, observed);
                if joined == earlier.invariants {
                    return Err(Decline::Fixpoint(earlier.id));
                }
                earlier.advance(joined, false)?
            }
            None => LoopAttempt {
                id: self.allocate_loop_id(),
                invariants: observed.clone(),
                rounds: 1,
                widened: false,
                rejected_bounds: Vec::new(),
            },
        };
        for i in self.record_at(pc, |record| record.unstable_registers.clone()) {
            if let Some(invariant) = attempt.invariants.get_mut(i) {
                *invariant = LoopInvariant::Unknown;
            }
        }
        let unconfinable = self.record_at(pc, |record| record.unconfinable.clone());
        let mut confined: Vec<Confinement> = Vec::new();
        for (i, invariant) in attempt.invariants.iter().enumerate() {
            if matches!(invariant, LoopInvariant::Unknown)
                && !unconfinable.contains(&i)
                && self.computer.carries_region(&observation.current.0[i])
                && let Some((region, length)) =
                    self.confining_region(&[&observation.entry.0[i], &observation.current.0[i]])
            {
                let guarded = registers_in(expression);
                let floor = confined
                    .iter()
                    .filter(|other| other.region == region)
                    .map(|other| other.register)
                    .filter(|&j| {
                        guarded.contains(&observation.current.0[i])
                            && guarded.contains(&observation.current.0[j])
                    })
                    .filter(|&j| {
                        [&observation.entry, &observation.current]
                            .iter()
                            .all(|state| {
                                self.proves_with_selects(AbstractComparison::new(
                                    ">=",
                                    value_of(&state.0[i]),
                                    value_of(&state.0[j]),
                                ))
                            })
                    })
                    .last();
                let multiple = floor
                    .and_then(|j| {
                        (2..=16i64).rev().find(|m| {
                            [&observation.entry, &observation.current]
                                .iter()
                                .all(|state| {
                                    self.proves_with_selects(AbstractComparison::new(
                                        "==",
                                        generate_expression(
                                            "%",
                                            generate_expression(
                                                "-",
                                                value_of(&state.0[i]),
                                                value_of(&state.0[j]),
                                            ),
                                            AbstractExpression::Immediate(*m),
                                        ),
                                        AbstractExpression::Immediate(0),
                                    ))
                                })
                        })
                    })
                    .unwrap_or(1);
                log::info!(
                    "{} x{i} stays within region {region}{}{}",
                    attempt.id,
                    floor.map_or(String::new(), |j| format!(", at or above x{j}")),
                    if multiple > 1 {
                        format!(" by multiples of {multiple}")
                    } else {
                        String::new()
                    }
                );
                confined.push(Confinement {
                    register: i,
                    region,
                    length,
                    floor,
                    multiple,
                });
            }
        }
        if let Some((i, _)) = attempt.invariants.iter().enumerate().find(|(i, inv)| {
            matches!(inv, LoopInvariant::Unknown)
                && self.computer.points_into_region(&observation.current.0[*i])
                && confined.iter().all(|kept| kept.register != *i)
        }) {
            return Err(Decline::WidensRegion(
                attempt.id,
                i,
                Box::new([
                    observation.entry.0[i].clone(),
                    observation.current.0[i].clone(),
                ]),
            ));
        }
        if let Some((i, j)) = attempt
            .invariants
            .iter()
            .enumerate()
            .find_map(|(i, inv)| match inv {
                LoopInvariant::Tracks(j, _)
                    if unconfinable.contains(j)
                        && matches!(attempt.invariants[*j], LoopInvariant::Unknown)
                        && self.computer.carries_region(&observation.current.0[i]) =>
                {
                    Some((i, *j))
                }
                _ => None,
            })
        {
            return Err(Decline::EscapedLeader(attempt.id, i, j));
        }
        Ok((attempt, confined))
    }

    fn abstract_cells(
        &self,
        pc: usize,
        cycle: &Cycle<M::LoopLanes>,
    ) -> Vec<(MemoryCell, LoopInvariant)> {
        let cycle_start = cycle
            .previous
            .journal_len
            .min(self.computer.write_journal().len());
        let unstable_cells = self.record_at(pc, |record| record.unstable_cells.clone());
        let wandering_cells = self.record_at(pc, |record| record.wandering_cells.clone());
        let mut cells: Vec<(MemoryCell, LoopInvariant)> =
            cells_written(&self.computer.write_journal()[cycle_start..])
                .into_iter()
                .map(|(cell, before)| {
                    let now = self.computer.cell_content(&cell);
                    let observed = self.demote_varying_steps(
                        vec![invariant_of_register(&before, &now)],
                        std::slice::from_ref(&before),
                    );
                    let invariant = match observed.into_iter().next() {
                        _ if wandering_cells.contains(&cell) => LoopInvariant::Unknown,
                        _ if self.advances_a_pointer(&before, &now) => LoopInvariant::NonDecreasing,
                        _ if unstable_cells.contains(&cell) => LoopInvariant::Unknown,
                        Some(LoopInvariant::Fixed) => LoopInvariant::Fixed,
                        Some(LoopInvariant::Linear(step))
                            if matches!(step, AbstractExpression::Immediate(_)) =>
                        {
                            LoopInvariant::Linear(step)
                        }
                        Some(ranged @ (LoopInvariant::AtMost(_) | LoopInvariant::Ranged(..))) => {
                            ranged
                        }
                        _ => LoopInvariant::Unknown,
                    };
                    (cell, invariant)
                })
                .collect();
        for cell in unstable_cells {
            if cells.iter().all(|(known, _)| *known != cell) {
                let holds_a_pointer = !wandering_cells.contains(&cell)
                    && self
                        .computer
                        .carries_region(&self.computer.cell_content(&cell));
                let invariant = if holds_a_pointer {
                    LoopInvariant::NonDecreasing
                } else {
                    LoopInvariant::Unknown
                };
                cells.push((cell, invariant));
            }
        }
        cells
    }

    fn advances_a_pointer(&self, before: &RegisterValue, now: &RegisterValue) -> bool {
        let stepped_by_a_constant = match invariant_of_register(before, now) {
            LoopInvariant::Fixed => true,
            LoopInvariant::Linear(step) => matches!(step, AbstractExpression::Immediate(_)),
            _ => false,
        };
        !stepped_by_a_constant
            && self.computer.carries_region(before)
            && self.computer.carries_region(now)
            && self.proves(AbstractComparison::new(
                ">=",
                now.expression(),
                before.expression(),
            ))
    }

    fn draft_summary(
        &mut self,
        pc: usize,
        expression: &AbstractComparison,
        cycle: &Cycle<M::LoopLanes>,
        attempt: &LoopAttempt,
        observation: &mut Observation,
        cells: Vec<(MemoryCell, LoopInvariant)>,
    ) -> Draft {
        self.anchor_past_inner_loops(
            pc,
            &attempt.invariants,
            &cycle.history,
            &mut observation.current,
        );
        self.simplify_anchors(&attempt.invariants, &mut observation.current);
        let (entry_state, current_state) = (&observation.entry, &observation.current);
        let (previous_guard, branch_decision) = (&observation.previous_guard, cycle.continues);
        let id = attempt.id;
        let ghosts = ghost_operands(
            previous_guard,
            expression,
            &entry_state.0,
            &current_state.0,
            |step| {
                (is_translatable(step) && step.size() <= MAX_EXPRESSION_NODES)
                    .then(|| self.pinned_value(step))
                    .flatten()
            },
        );
        let mut summary = summarize(
            id,
            pc,
            self.enclosing_label(pc),
            (
                expression,
                &ghosts,
                &guard_operands(previous_guard, expression, &entry_state.0, &current_state.0),
            ),
            branch_decision,
            self.bound_values(
                pc,
                &self.pin_steps(&attempt.invariants),
                &entry_state.0,
                &current_state.0,
            ),
            (
                entry_state,
                current_state,
                &self.exit_ghosts(
                    self.loop_exits(pc, branch_decision, cycle.walked()),
                    cycle.before(),
                    (pc, &entry_state.0, &attempt.invariants),
                ),
                &self.exit_ghosts(
                    branches_walked(pc, cycle.walked()),
                    cycle.before(),
                    (pc, &entry_state.0, &attempt.invariants),
                ),
            ),
        );
        let continuing_now = if branch_decision {
            expression.clone()
        } else {
            expression.clone().not()
        };
        self.bound_geometric_walks(&mut summary, &continuing_now, current_state);
        let settled_steps = self.settle_select_steps(
            &mut summary,
            entry_state,
            current_state,
            &ghosts,
            &continuing_now,
        );
        let chosen = self.choose_registers(
            &mut summary,
            (expression, branch_decision),
            entry_state,
            current_state,
        );
        let pinned_selects = self.pinned_select_facts(&summary, entry_state, current_state);
        let continuing = summary.continuing.clone();
        log::info!(
            "detected {id} at line {pc} in {:?}, round {}",
            summary.label.as_deref().unwrap_or("?"),
            attempt.rounds
        );
        for fact in &summary.facts {
            log::info!("{id} fact: {fact}");
        }
        for (i, inv) in summary.invariants.iter().enumerate() {
            if !matches!(inv, LoopInvariant::Fixed) {
                log::info!(
                    "{id} x{i} invariant: {inv:?} prev={:?} cur={:?}",
                    entry_state.0[i],
                    current_state.0[i]
                );
            }
        }
        let mut candidates = bound_candidates(&summary.invariants, &current_state.0);
        candidates.extend(self.word_limits(&summary.invariants, &current_state.0, expression));
        let mut bounds: Vec<Bound> = candidates
            .into_iter()
            .filter(|bound| !attempt.rejected_bounds.contains(&bound.key()))
            .filter(|bound| self.plausible(bound, &entry_state.0, &current_state.0))
            .collect();
        bounds.extend(self.while_staying(expression, branch_decision, |engine| {
            engine
                .down_counter_floors(&summary.invariants, &current_state.0, expression)
                .into_iter()
                .filter(|bound| !attempt.rejected_bounds.contains(&bound.key()))
                .filter(|bound| engine.plausible(bound, &entry_state.0, &current_state.0))
                .collect::<Vec<Bound>>()
        }));
        Draft {
            summary,
            settled_steps,
            chosen,
            pinned_selects,
            continuing,
            bounds,
            cells,
            round: attempt.rounds,
        }
    }

    fn justify_facts(
        &mut self,
        pc: usize,
        expression: &AbstractComparison,
        cycle: &Cycle<M::LoopLanes>,
        summary: &mut Summary,
    ) -> Result<(), Decline> {
        let id = summary.id;
        let mut unjustified: Vec<AbstractComparison> = summary
            .landings
            .iter()
            .filter(|(requirement, _)| {
                summary_fact_to_ast(requirement).is_none_or(|required| {
                    self.computer.solver().check_timed(&[required.not()]) != SatResult::Unsat
                })
            })
            .map(|(_, landing)| landing.clone())
            .collect();
        let undefined_trips: Vec<String> = unjustified
            .iter()
            .flat_map(AbstractComparison::get_abstracts)
            .filter(|symbol| {
                LoopSymbol::parse(symbol).is_some_and(|symbol| {
                    symbol.id == id && matches!(symbol.role, LoopRole::Trips(_))
                })
            })
            .collect();
        let uncarried = self.record_at(pc, |record| record.uncarried.clone());
        let unusable: Vec<AbstractComparison> = summary
            .branch_facts
            .iter()
            .filter(|(branch, fact)| {
                !unjustified.contains(fact)
                    && (uncarried.contains(branch)
                        || fact
                            .get_abstracts()
                            .iter()
                            .any(|symbol| undefined_trips.contains(symbol)))
            })
            .map(|(_, fact)| fact.clone())
            .collect();
        for fact in &unusable {
            log::info!("{id} at line {pc} cannot carry {fact} across iterations, dropping it");
        }
        for landing in &unjustified {
            log::info!("{id} at line {pc} may step over its bound, dropping {landing}");
        }
        unjustified.extend(unusable);
        summary.facts.retain(|fact| !unjustified.contains(fact));
        if !unjustified.is_empty()
            && !uncarried.contains(&pc)
            && let Some(ordered) = self.ordered_by_consecutive_exits(
                (&cycle.previous, expression, cycle.continues),
                cycle.walked(),
                &summary.continuing,
            )
        {
            log::info!("{id} at line {pc} exits at every value its walk takes: {ordered}");
            summary.branch_facts.push((pc, ordered.clone()));
            summary.facts.push(ordered);
        }
        summary
            .exit_facts
            .retain(|fact| !unjustified.contains(fact));
        summary
            .branch_facts
            .retain(|(_, fact)| !unjustified.contains(fact));

        let counter_name = summary.counter.name().to_string();
        let at_base = AbstractExpression::Immediate(SUMMARY_ITERATION);
        let unproved_at_base = self.while_staying(expression, cycle.continues, |engine| {
            summary
                .branch_facts
                .iter()
                .map(|(_, fact)| comparison_with_counter_at(fact, &counter_name, &at_base))
                .filter(|fact| {
                    fact.get_abstracts()
                        .iter()
                        .all(|symbol| !LoopSymbol::names_of(symbol, id))
                })
                .find(|fact| !engine.proves(fact.clone()))
        });
        if let Some(fact) = unproved_at_base {
            return Err(Decline::UnprovedAtBase(id, fact));
        }
        let unimplied = self
            .facts_not_implied_at_base(summary, expression, cycle.continues)
            .ok_or(Decline::Contradicts(id))?;
        for fact in &unimplied {
            log::info!(
                "{id} at line {pc} does not imply {fact} where it is summarized, dropping it"
            );
        }
        summary.facts.retain(|fact| !unimplied.contains(fact));
        summary
            .branch_facts
            .retain(|(_, fact)| !unimplied.contains(fact));
        summary.exit_facts.retain(|fact| !unimplied.contains(fact));
        Ok(())
    }

    fn facts_not_implied_at_base(
        &self,
        summary: &Summary,
        expression: &AbstractComparison,
        continues: bool,
    ) -> Option<Vec<AbstractComparison>> {
        let id = summary.id;
        let roles_in = |names: Vec<String>| -> Vec<LoopRole> {
            names
                .iter()
                .filter_map(|name| LoopSymbol::parse(name))
                .filter(|symbol| symbol.id == id)
                .map(|symbol| symbol.role)
                .collect()
        };
        let current = self.computer.get_state();
        let mut definitions: Vec<AbstractComparison> = summary
            .updates
            .iter()
            .filter_map(|(i, update)| {
                let summarized = value_of(update);
                let own = [
                    LoopRole::Widened(*i),
                    LoopRole::Within(*i),
                    LoopRole::Progress(*i),
                ];
                let roles = roles_in(summarized.get_abstracts());
                let defines_its_own_symbol = roles
                    .first()
                    .is_some_and(|first| own.contains(first) && roles.iter().all(|r| r == first));
                if !defines_its_own_symbol {
                    return None;
                }
                let held = current.0[*i].expression();
                match confined_load_width(&summarized) {
                    Some(width) if confined_load_width(&held) != Some(width) => None,
                    _ => Some(AbstractComparison::new("==", summarized, held)),
                }
            })
            .collect();
        let trips_in = |fact: &AbstractComparison| -> Vec<String> {
            fact.get_abstracts()
                .into_iter()
                .filter(|name| {
                    LoopSymbol::parse(name).is_some_and(|symbol| {
                        symbol.id == id && matches!(symbol.role, LoopRole::Trips(_))
                    })
                })
                .collect()
        };
        let mentions_the_counter =
            |fact: &AbstractComparison| roles_in(fact.get_abstracts()).contains(&LoopRole::Counter);
        let mut trip_definitions: Vec<AbstractComparison> = summary
            .facts
            .iter()
            .filter(|fact| !trips_in(fact).is_empty() && !mentions_the_counter(fact))
            .cloned()
            .collect();
        let defined: Vec<String> = trip_definitions.iter().flat_map(&trips_in).collect();
        let bounds_a_free_trip_count = |fact: &AbstractComparison| {
            let trips = trips_in(fact);
            let [trip] = &trips[..] else {
                return false;
            };
            !matches!(fact.op.as_str(), "==" | "!=")
                && !defined.contains(trip)
                && summary
                    .facts
                    .iter()
                    .filter(|other| other.get_abstracts().contains(trip))
                    .count()
                    == 1
        };
        trip_definitions.extend(
            summary
                .facts
                .iter()
                .filter(|fact| bounds_a_free_trip_count(fact))
                .cloned(),
        );
        definitions.extend(trip_definitions.iter().cloned());
        definitions.push(AbstractComparison::new(
            "==",
            summary.counter.expression(),
            AbstractExpression::Immediate(SUMMARY_ITERATION),
        ));
        self.while_staying(expression, continues, |engine| {
            let solver = engine.computer.solver();
            solver.push();
            for definition in &definitions {
                for fact in engine
                    .select_definitions_in(definition)
                    .into_iter()
                    .chain(summary_fact_to_ast(definition))
                {
                    solver.assert(fact);
                }
            }
            let unimplied = (check(solver, &[]) == SatResult::Sat).then(|| {
                summary
                    .facts
                    .iter()
                    .filter(|fact| !trip_definitions.contains(fact) && !engine.implied(fact))
                    .cloned()
                    .collect()
            });
            solver.pop(1);
            unimplied
        })
    }

    fn install(
        &mut self,
        pc: usize,
        depth: usize,
        cycle: &Cycle<M::LoopLanes>,
        observation: Observation,
        draft: Draft,
        mut confined: Vec<Confinement>,
    ) -> Result<bool, Decline> {
        let Draft {
            mut summary,
            settled_steps,
            chosen,
            pinned_selects,
            continuing,
            bounds,
            cells,
            round,
        } = draft;
        let id = summary.id;
        let fallback = self.fork();
        let scope_id = self.push_scope();
        for fact in &pinned_selects {
            self.computer.solver().assert(fact);
        }
        for fact in summary.facts.iter().filter_map(summary_fact_to_ast) {
            self.computer.solver().assert(fact);
        }
        for lemma in self.counter_stride_products(&summary) {
            self.computer.solver().assert(&lemma);
        }
        for fact in self
            .select_definitions_in(&observation.staying)
            .into_iter()
            .chain(comparison_to_ast(observation.staying.clone()))
        {
            self.computer.solver().assert(fact);
        }
        for fact in self
            .select_definitions_in(&summary.continuing)
            .into_iter()
            .chain(summary_fact_to_ast(&summary.continuing))
        {
            self.computer.solver().assert(fact);
        }
        let mut summarized = self.computer.get_state();
        for (i, new_reg) in summary.updates.iter().cloned() {
            summarized.0[i] = new_reg;
        }
        let (entry_state, current_state) = (&observation.entry, &observation.current);
        let unconfinable = self.record_at(pc, |record| record.unconfinable.clone());
        let leaders: Vec<usize> = summary
            .invariants
            .iter()
            .filter_map(|invariant| match invariant {
                LoopInvariant::Tracks(j, _) => Some(*j),
                _ => None,
            })
            .collect();
        {
            for (i, invariant) in summary.invariants.iter().enumerate() {
                let stepped = matches!(
                    invariant,
                    LoopInvariant::Linear(AbstractExpression::Immediate(_))
                        | LoopInvariant::AtMost(_)
                        | LoopInvariant::Ranged(..)
                ) || (matches!(invariant, LoopInvariant::Unknown)
                    && leaders.contains(&i)
                    && !self.computer.carries_region(&current_state.0[i]));
                if !stepped
                    || unconfinable.contains(&i)
                    || confined.iter().any(|kept| kept.register == i)
                {
                    continue;
                }
                let counts_down = matches!(
                    invariant,
                    LoopInvariant::Linear(AbstractExpression::Immediate(step)) if *step < 0
                ) || matches!(invariant, LoopInvariant::Ranged(_, high) if *high <= 0)
                    || (matches!(invariant, LoopInvariant::Unknown) && leaders.contains(&i));
                if !self.computer.carries_region(&current_state.0[i]) {
                    let zero = AbstractExpression::Immediate(0);
                    let stays_natural = counts_down
                        && current_state.0[i].kind == RegisterKind::RegisterBase
                        && [&entry_state, &current_state].iter().all(|state| {
                            self.proves_with_selects(AbstractComparison::new(
                                ">=",
                                value_of(&state.0[i]),
                                zero.clone(),
                            ))
                        });
                    if stays_natural {
                        log::info!("{id} x{i} counts down without going below zero");
                        let fact = AbstractComparison::new(">=", value_of(&summarized.0[i]), zero);
                        if let Some(asserted) = comparison_to_ast(fact.clone()) {
                            self.computer.solver().assert(asserted);
                        }
                        summary.facts.push(fact);
                        confined.push(Confinement {
                            register: i,
                            region: String::new(),
                            length: AbstractExpression::Immediate(0),
                            floor: None,
                            multiple: 1,
                        });
                    }
                    continue;
                }
                let Some((region, length)) =
                    self.confining_region(&[&entry_state.0[i], &current_state.0[i]])
                else {
                    continue;
                };
                log::info!("{id} x{i} stays within region {region} as it steps");
                let start = AbstractExpression::Abstract(region.clone());
                let end = generate_expression("+", start.clone(), length.clone());
                let value = value_of(&summarized.0[i]);
                for fact in [
                    AbstractComparison::new(">=", value.clone(), start),
                    AbstractComparison::new("<=", value, end),
                ] {
                    if let Some(asserted) = comparison_to_ast(fact.clone()) {
                        self.computer.solver().assert(asserted);
                    }
                    summary.facts.push(fact);
                }
                confined.push(Confinement {
                    register: i,
                    region,
                    length,
                    floor: None,
                    multiple: 1,
                });
            }
        }
        for confinement in confined.iter().filter(|c| {
            !c.region.is_empty() && matches!(summary.invariants[c.register], LoopInvariant::Unknown)
        }) {
            let i = confinement.register;
            let start = AbstractExpression::Abstract(confinement.region.clone());
            let end = generate_expression("+", start.clone(), confinement.length.clone());
            let offset = summary.counter.symbol(LoopRole::Offset(i)).expression();
            let floor = confinement
                .floor
                .map_or(start, |j| value_of(&summarized.0[j]));
            let scaled = generate_expression(
                "*",
                AbstractExpression::Immediate(confinement.multiple),
                offset.clone(),
            );
            let within = generate_expression("+", floor, scaled);
            let facts = [
                AbstractComparison::new(">=", offset, AbstractExpression::Immediate(0)),
                AbstractComparison::new("<=", within.clone(), end),
                AbstractComparison::new("==", value_of(&summarized.0[i]), within.clone()),
            ];
            for fact in facts {
                if let Some(asserted) = comparison_to_ast(fact.clone()) {
                    self.computer.solver().assert(asserted);
                }
                summary.facts.push(fact);
            }
            summarized.0[i] = RegisterValue::new(RegisterKind::RegisterBase, Some(within), 0);
        }
        for bound in bounds.iter().map(|bound| bound.at(&summarized.0)) {
            log::info!("{id} assumes {bound}");
            for fact in self
                .select_definitions_in(&bound)
                .into_iter()
                .chain(comparison_to_ast(bound))
            {
                self.computer.solver().assert(fact);
            }
        }
        let mentioned: Vec<String> = summary
            .facts
            .iter()
            .chain(&summary.exit_facts)
            .flat_map(|fact| fact.get_abstracts())
            .collect();
        for counter in mentioned
            .iter()
            .filter(|symbol| LoopSymbol::names_any(symbol))
        {
            self.computer
                .symbols_bounding_counter_mut()
                .entry(counter.clone())
                .or_default()
                .extend(mentioned.iter().cloned());
        }
        let admits_base = comparison_to_ast(AbstractComparison::new(
            "==",
            summary.counter.expression(),
            AbstractExpression::Immediate(SUMMARY_ITERATION),
        ))
        .is_some_and(|base| self.computer.solver().check_timed(&[base]) == SatResult::Sat);
        if !admits_base {
            self.pop_scope(scope_id);
            return Err(Decline::Contradicts(id));
        }

        let lanes_now = self.computer.loop_lanes();
        let registers_before_summary = self.computer.get_state().0;
        let summarized_registers = summarized.0.clone();
        self.computer.set_state(summarized);
        self.computer
            .keep_loop_lanes(&cycle.previous.lanes, lanes_now);
        if self.record_at(pc, |record| record.unstable_slots) {
            self.computer.set_symbolic_slots(Vec::new());
        }
        let kept = self
            .computer
            .symbolic_slots()
            .into_iter()
            .filter(|slot| cycle.previous.slots.contains(slot))
            .collect();
        self.computer.set_symbolic_slots(kept);
        let counter = LoopCounter::for_loop(id);
        let mut cell_ties: Vec<(MemoryCell, usize)> = Vec::new();
        let untied_cells = self.record_at(pc, |record| record.untied_cells.clone());
        for (index, (cell, invariant)) in cells.iter().enumerate() {
            let stored = self.computer.cell_content(cell);
            let holding_register = (*invariant != LoopInvariant::Fixed
                && !untied_cells.contains(cell)
                && stored.kind == RegisterKind::RegisterBase)
                .then(|| {
                    registers_before_summary
                        .iter()
                        .position(|register| *register == stored)
                })
                .flatten()
                .filter(|&i| summarized_registers[i] != stored);
            if let Some(i) = holding_register {
                log::info!("{id} cell {}+{} holds x{i}", cell.region, cell.offset);
                cell_ties.push((cell.clone(), i));
                self.computer
                    .write_cell(cell, summarized_registers[i].clone());
                continue;
            }
            let generalized = match invariant {
                LoopInvariant::Fixed => continue,
                LoopInvariant::Linear(step) => stepped_by_the_counter(&stored, step, &counter),
                LoopInvariant::NonDecreasing => {
                    let progress = counter.symbol(LoopRole::CellProgress(index)).expression();
                    let ahead = AbstractComparison::new(
                        ">=",
                        progress.clone(),
                        AbstractExpression::Immediate(0),
                    );
                    if let Some(fact) = comparison_to_ast(ahead) {
                        self.computer.solver().assert(fact);
                    }
                    RegisterValue {
                        kind: RegisterKind::RegisterBase,
                        base: Some(generate_expression("+", value_of(&stored), progress)),
                        offset: 0,
                    }
                }
                LoopInvariant::AtMost(high) => {
                    self.ranged_cell(&stored, (0, *high), &counter, index, &mut summary.facts)
                }
                LoopInvariant::Ranged(low, high) => {
                    self.ranged_cell(&stored, (*low, *high), &counter, index, &mut summary.facts)
                }
                _ => RegisterValue::new(RegisterKind::Number, None, 0),
            };
            log::info!(
                "{id} cell {}+{} invariant: {invariant:?} now {generalized:?}",
                cell.region,
                cell.offset
            );
            self.computer.write_cell(cell, generalized);
        }
        let journal_after_summary = self.computer.write_journal().len();
        self.loops
            .value_ranges
            .extend(summary.ranges.iter().cloned());
        self.computer.set_flags(summary.flags.clone());
        let invariants = summary.invariants.clone();
        let exit_facts = summary.exit_facts.clone();
        let facts = summary.facts.clone();
        let exits = summary.exits.clone();
        let branch_facts = summary.branch_facts.clone();
        let ghost_checks = summary.ghost_checks.clone();
        let operand_checks = summary.operand_checks.clone();
        self.summaries.borrow_mut().push(summary);

        let instance = {
            let mut ledger = self.ledger.borrow_mut();
            ledger.next_instance += 1;
            ledger.next_instance
        };
        self.loops.relied_on.push(instance);
        if !confined.is_empty() {
            self.loop_history
                .borrow_mut()
                .confined_instances
                .insert(instance, confined.iter().map(|c| c.register).collect());
        }
        self.loops.pending = Some((instance, Box::new(fallback)));
        self.loops.active.push(ActiveLoop {
            id,
            instance,
            pc,
            depth,
            scope_id,
            entry_decision: cycle.continues,
            invariants,
            exit_facts,
            state: self.computer.get_state(),
            entry_state: observation.current,
            history_len: self.jump_history.len(),
            facts,
            exits,
            branch_facts,
            round,
            nested_facts: pinned_selects,
            ghost_checks,
            operand_checks,
            cells,
            cell_ties,
            journal_after_summary,
            blind_writes_at_summary: self.computer.blind_stack_writes().len(),
            slots: self.computer.symbolic_slots(),
            settled_steps,
            chosen,
            continuing,
            bounds,
            confined,
        });
        Ok(cycle.continues)
    }

    fn reads_a_changing_load(
        &self,
        condition: &AbstractComparison,
        previous: &MachineState,
    ) -> bool {
        let tested = registers_in(condition);
        self.computer
            .get_state()
            .0
            .iter()
            .zip(previous.0.iter())
            .enumerate()
            .any(|(i, (now, before))| {
                self.computer.loaded(i)
                    && tested.contains(now)
                    && (now != before || (now.kind == RegisterKind::Number && now.base.is_none()))
            })
    }

    fn proven_upper_bound(&self, register: &RegisterValue) -> Option<i64> {
        let value = value_of(register);
        let word = is_narrowed(&value).then_some((1i64 << 32) - 1);
        [upper_bound_of(&value), word]
            .into_iter()
            .flatten()
            .find(|bound| {
                self.proves(AbstractComparison::new(
                    ">=",
                    value.clone(),
                    AbstractExpression::Immediate(0),
                )) && self.proves(AbstractComparison::new(
                    "<=",
                    value.clone(),
                    AbstractExpression::Immediate(*bound),
                ))
            })
    }

    fn bound_geometric_walks(
        &self,
        summary: &mut Summary,
        continuing_now: &AbstractComparison,
        current: &MachineState,
    ) {
        let counter = summary.counter.clone();
        for (i, invariant) in summary.invariants.iter().enumerate() {
            let LoopInvariant::Geometric(divisor) = invariant else {
                continue;
            };
            let Some(loose) = self.proven_upper_bound(&current.0[i]) else {
                continue;
            };
            let bound = self
                .computer
                .proven_bit_width(&value_of(&current.0[i]))
                .map_or(loose, |bits| loose.min((1i64 << bits) - 1));
            let widened = counter.symbol(LoopRole::Widened(i)).expression();
            summary.facts.push(AbstractComparison::new(
                ">=",
                widened.clone(),
                AbstractExpression::Immediate(0),
            ));
            summary.facts.push(AbstractComparison::new(
                "<=",
                widened,
                AbstractExpression::Immediate(bound),
            ));
            if continues_while_nonzero(continuing_now, &current.0[i], bound)
                && let Some(divisions) = divisions_to_zero(bound, *divisor)
            {
                log::info!("{} leaves within {divisions} divisions of x{i}", summary.id);
                summary.facts.push(AbstractComparison::new(
                    "<=",
                    counter.expression(),
                    AbstractExpression::Immediate(divisions + SUMMARY_ITERATION - 1),
                ));
            }
        }
    }

    fn step_without_cancelling_terms(
        &self,
        prev: &RegisterValue,
        cur: &RegisterValue,
    ) -> Option<AbstractExpression> {
        let step = Affine::of_register(cur)?.combine(&Affine::of_register(prev)?, -1)?;
        let mut pieces: Vec<Affine> = step
            .terms
            .iter()
            .map(|term| Affine {
                constant: 0,
                terms: vec![term.clone()],
            })
            .collect();
        if step.constant != 0 {
            pieces.push(Affine {
                constant: step.constant,
                terms: Vec::new(),
            });
        }
        if pieces.len() < 2 || pieces.len() > MAX_CANCELLED_STEP_PIECES {
            return None;
        }
        let mut proofs = 0;
        for size in 1..=MAX_CANCELLED_GROUP.min(pieces.len() - 1) {
            for group in index_groups(pieces.len(), size) {
                let dropped = group.iter().try_fold(
                    Affine {
                        constant: 0,
                        terms: Vec::new(),
                    },
                    |sum, &k| sum.combine(&pieces[k], 1),
                )?;
                let kept = (0..pieces.len()).filter(|k| !group.contains(k)).try_fold(
                    Affine {
                        constant: 0,
                        terms: Vec::new(),
                    },
                    |sum, k| sum.combine(&pieces[k], 1),
                )?;
                if kept.terms.is_empty() || kept.mentions_a_loop_counter() {
                    continue;
                }
                let cancelled = dropped.to_expression();
                if cancelled.size() > MAX_EXPRESSION_NODES {
                    continue;
                }
                if proofs == MAX_CANCELLATION_PROOFS {
                    return None;
                }
                proofs += 1;
                if self.proves_with_selects(AbstractComparison::new(
                    "==",
                    cancelled,
                    AbstractExpression::Immediate(0),
                )) {
                    return Some(kept.to_expression());
                }
            }
        }
        None
    }

    fn pinned_value(&self, e: &AbstractExpression) -> Option<i64> {
        let term = expression_to_ast(e.clone())?;
        let mut assuming = self.computer.select_assumptions(e);
        if self.computer.solver().check_timed(&assuming) != SatResult::Sat {
            return None;
        }
        let value = self
            .computer
            .solver()
            .get_model()?
            .eval(&term, true)?
            .as_i64()?;
        assuming.push(term.eq(ast::Int::from_i64(value)).not());
        refuted_within(
            self.computer.solver(),
            &ast::Bool::and(&assuming),
            OBLIGATION_INCREMENTAL_RESOURCE_LIMIT,
            OBLIGATION_RESOURCE_LIMIT,
        )
        .then_some(value)
    }

    fn select_bound(&self, name: &str, fuel: usize) -> Option<i64> {
        if let Some(bound) = self.loops.value_ranges.get(name) {
            return Some(*bound);
        }
        let (_, taken, skipped) = self.computer.select_definitions().get(name)?;
        let reach = |e: &AbstractExpression| match e {
            AbstractExpression::Immediate(value) => Some(*value),
            AbstractExpression::Abstract(inner) if fuel > 0 => self.select_bound(inner, fuel - 1),
            _ => None,
        };
        let (taken, skipped) = (reach(taken)?, reach(skipped)?);
        (taken >= 0 && skipped >= 0).then(|| taken.max(skipped))
    }

    fn value_bound(&self, register: &RegisterValue) -> Option<i64> {
        let value = value_of(register);
        let by_select = match &value {
            AbstractExpression::Immediate(value) => return (*value >= 0).then_some(*value),
            AbstractExpression::Abstract(name) => self.select_bound(name, MAX_SELECT_CHAIN),
            _ => None,
        };
        by_select.or_else(|| {
            self.step_bounds(&value)
                .filter(|(low, high)| *low >= 0 && *high <= MAX_WITHIN_BOUND)
                .map(|(_, high)| high)
        })
    }

    fn bound_values(
        &self,
        pc: usize,
        invariants: &[LoopInvariant],
        entry: &[RegisterValue],
        current: &[RegisterValue],
    ) -> Vec<LoopInvariant> {
        let unstable = self.record_at(pc, |record| record.unstable_registers.clone());
        invariants
            .iter()
            .zip(entry.iter().zip(current.iter()))
            .enumerate()
            .map(|(i, (invariant, (before, after)))| match invariant {
                LoopInvariant::Unknown
                    if !unstable.contains(&i)
                        && before.kind != RegisterKind::Number
                        && after.kind != RegisterKind::Number
                        && !self.computer.carries_region(after) =>
                {
                    self.value_bound(before)
                        .zip(self.value_bound(after))
                        .map_or(LoopInvariant::Unknown, |(was, is)| {
                            LoopInvariant::Within(was.max(is))
                        })
                }
                other => other.clone(),
            })
            .collect()
    }

    fn confining_region(&self, values: &[&RegisterValue]) -> Option<(String, AbstractExpression)> {
        let base = values.first()?.base.as_ref()?;
        let (region, symbol, label_offset) = self.computer.region_of(base)?;
        if region != symbol || label_offset != 0 || region == STACK_REGION {
            return None;
        }
        let length = self.computer.memory().get(&region)?.get_length();
        let start = AbstractExpression::Abstract(region.clone());
        let end = generate_expression("+", start.clone(), length.clone());
        values
            .iter()
            .all(|value| {
                let same = value.kind == RegisterKind::RegisterBase
                    && self
                        .computer
                        .region_of(value.base.as_ref().expect("based"))
                        .map(|r| r.0)
                        == Some(region.clone());
                let above = same
                    && self.proves_with_selects(AbstractComparison::new(
                        ">=",
                        value_of(value),
                        start.clone(),
                    ));
                let below = above
                    && self.proves_with_selects(AbstractComparison::new(
                        "<=",
                        value_of(value),
                        end.clone(),
                    ));
                if !below {
                    log::info!(
                        "{} not confined to {region}: same region {same}, above start {above}",
                        value_of(value)
                    );
                }
                below
            })
            .then_some((region, length))
    }

    fn demote_varying_steps(
        &self,
        invariants: Vec<LoopInvariant>,
        before: &[RegisterValue],
    ) -> Vec<LoopInvariant> {
        let known: BTreeSet<String> = before
            .iter()
            .filter_map(|register| register.base.as_ref())
            .flat_map(|base| base.get_abstracts())
            .collect();
        let active: Vec<String> = self
            .loops
            .active
            .iter()
            .map(|open| LoopCounter::for_loop(open.id).name().to_string())
            .collect();
        let finished_counter = |symbol: &str| {
            symbol
                .find("_?")
                .is_some_and(|at| !active.iter().any(|open| *open == symbol[..at + 2]))
        };
        let pinned_step = |step: &AbstractExpression| {
            (!step.get_abstracts().is_empty() && step.size() <= MAX_STEP_BOUND_NODES)
                .then(|| self.pinned_value(step))
                .flatten()
        };
        invariants
            .into_iter()
            .map(|invariant| {
                if let LoopInvariant::Linear(step) = &invariant
                    && let Some(value) = pinned_step(step)
                {
                    return LoopInvariant::Linear(AbstractExpression::Immediate(value));
                }
                self.demoted(invariant, &known, &finished_counter)
            })
            .collect()
    }

    fn demoted(
        &self,
        invariant: LoopInvariant,
        known: &BTreeSet<String>,
        finished_counter: &dyn Fn(&str) -> bool,
    ) -> LoopInvariant {
        match invariant {
            LoopInvariant::Linear(step)
                if step
                    .get_abstracts()
                    .iter()
                    .any(|symbol| finished_counter(symbol)) =>
            {
                LoopInvariant::Unknown
            }
            LoopInvariant::Linear(step)
                if step
                    .get_abstracts()
                    .iter()
                    .any(|symbol| is_fresh_symbol(symbol) && !known.contains(symbol)) =>
            {
                match self.step_bounds(&step) {
                    Some((low, high)) if low >= 0 => LoopInvariant::AtMost(high),
                    Some((low, high)) => LoopInvariant::Ranged(low, high),
                    None => LoopInvariant::Unknown,
                }
            }
            other => other,
        }
    }

    fn step_bounds(&self, step: &AbstractExpression) -> Option<(i64, i64)> {
        const REACH: i64 = 1 << 40;
        if let Some(range) = unsigned_range(step) {
            return Some(range);
        }
        if step.size() > MAX_STEP_BOUND_NODES {
            return None;
        }
        let upper = |value: &AbstractExpression| {
            let at_most = |bound: i64| {
                self.proves_quietly_within(
                    AbstractComparison::new(
                        "<=",
                        value.clone(),
                        AbstractExpression::Immediate(bound),
                    ),
                    STEP_BOUND_RESOURCE_LIMIT,
                )
            };
            if !at_most(REACH) {
                return None;
            }
            let (mut low, mut high) = (-REACH, REACH);
            if at_most(low) {
                return None;
            }
            while low + 1 < high {
                let middle = low + (high - low) / 2;
                if at_most(middle) {
                    high = middle;
                } else {
                    low = middle;
                }
            }
            Some(high)
        };
        let high = upper(step)?;
        let negated = generate_expression("-", AbstractExpression::Immediate(0), step.clone());
        let low = -upper(&negated)?;
        Some((low, high))
    }

    fn ranged_cell(
        &self,
        stored: &RegisterValue,
        (low, high): (i64, i64),
        counter: &LoopCounter,
        index: usize,
        kept: &mut Vec<AbstractComparison>,
    ) -> RegisterValue {
        let progress = counter.symbol(LoopRole::Cell(index)).expression();
        let rounds = generate_expression(
            "-",
            counter.expression(),
            AbstractExpression::Immediate(SUMMARY_ITERATION),
        );
        let facts = [
            AbstractComparison::new(
                "<=",
                generate_expression("*", AbstractExpression::Immediate(low), rounds.clone()),
                progress.clone(),
            ),
            AbstractComparison::new(
                ">=",
                generate_expression("*", AbstractExpression::Immediate(high), rounds),
                progress.clone(),
            ),
        ];
        for fact in facts {
            if let Some(asserted) = comparison_to_ast(fact.clone()) {
                self.computer.solver().assert(asserted);
            }
            kept.push(fact);
        }
        RegisterValue {
            kind: RegisterKind::RegisterBase,
            base: Some(generate_expression("+", value_of(stored), progress)),
            offset: 0,
        }
    }

    fn bounded_step(&self, step: &AbstractExpression) -> Option<i64> {
        let AbstractExpression::Abstract(name) = step else {
            return None;
        };
        self.select_bound(name, MAX_SELECT_CHAIN).filter(|b| *b > 0)
    }

    fn pin_steps(&self, invariants: &[LoopInvariant]) -> Vec<LoopInvariant> {
        invariants
            .iter()
            .map(|invariant| match invariant {
                LoopInvariant::Linear(step)
                    if !matches!(step, AbstractExpression::Immediate(_)) =>
                {
                    if let Some(value) = self.pinned_value(step) {
                        LoopInvariant::Linear(AbstractExpression::Immediate(value))
                    } else if let simpler = self.simplified_step(step.clone())
                        && simpler != *step
                    {
                        LoopInvariant::Linear(simpler)
                    } else {
                        self.bounded_step(step)
                            .map_or_else(|| invariant.clone(), LoopInvariant::AtMost)
                    }
                }
                other => other.clone(),
            })
            .collect()
    }

    pub(super) fn static_successors(&self, pc: usize) -> Option<Vec<usize>> {
        let instruction = self.program.code.get(pc)?;
        let target = |label: &str| self.resolve_jump_target(label, pc).ok();
        let next = pc + 1;
        match instruction.flow() {
            Flow::Return | Flow::Trap => Some(Vec::new()),
            Flow::Indirect => None,
            Flow::Jump(label) => Some(vec![target(label)?]),
            Flow::Branch(label) => Some(vec![target(label)?, next]),
            Flow::Call | Flow::Next => Some(vec![next]),
        }
    }

    fn literal_leaves(&self, e: &AbstractExpression, fuel: usize, found: &mut Vec<i64>) {
        if let Some(value) = constant_value(e) {
            if !found.contains(&value) {
                found.push(value);
            }
            return;
        }
        if fuel == 0 {
            return;
        }
        if let AbstractExpression::Abstract(name) = e
            && let Some((_, taken, skipped)) = self.computer.select_definitions().get(name)
        {
            self.literal_leaves(taken, fuel - 1, found);
            self.literal_leaves(skipped, fuel - 1, found);
        }
    }

    fn arm_constant(
        &self,
        arm: &AbstractExpression,
        continuing_now: &AbstractComparison,
    ) -> Option<i64> {
        if let Some(value) = constant_value(arm) {
            return Some(value);
        }
        let mut candidates = Vec::new();
        self.literal_leaves(arm, MAX_SELECT_CHAIN, &mut candidates);
        let term = expression_to_ast(arm.clone())?;
        let mut assuming = self.computer.select_assumptions(arm);
        assuming.extend(self.computer.select_assumptions(&continuing_now.left));
        assuming.extend(self.computer.select_assumptions(&continuing_now.right));
        assuming.push(comparison_to_ast(continuing_now.clone())?);
        candidates.into_iter().find(|candidate| {
            let mut with = assuming.clone();
            with.push(term.eq(ast::Int::from_i64(*candidate)).not());
            self.computer.solver().check_timed(&with) == SatResult::Unsat
        })
    }

    fn proves_step_between(
        &self,
        before: &RegisterValue,
        after: &RegisterValue,
        (low, high): (Option<i64>, Option<i64>),
    ) -> bool {
        if before.kind == RegisterKind::Number || after.kind == RegisterKind::Number {
            return false;
        }
        let moved = generate_expression("-", value_of(after), value_of(before));
        let mut assuming = self.computer.select_assumptions(&moved);
        let Some(moved) = expression_to_ast(moved) else {
            return false;
        };
        let outside: Vec<ast::Bool> = [
            low.map(|low| moved.lt(ast::Int::from_i64(low))),
            high.map(|high| moved.gt(ast::Int::from_i64(high))),
        ]
        .into_iter()
        .flatten()
        .collect();
        assuming.push(ast::Bool::or(&outside.iter().collect::<Vec<_>>()));
        self.within_candidate_budget(|solver| solver.check_timed(&assuming)) == SatResult::Unsat
    }

    fn proves_step(
        &self,
        before: &RegisterValue,
        after: &RegisterValue,
        step: &AbstractExpression,
    ) -> bool {
        if before.kind == RegisterKind::Number || after.kind == RegisterKind::Number {
            return false;
        }
        let moved = generate_expression("-", value_of(after), value_of(before));
        let mut assuming = self.computer.select_assumptions(&moved);
        assuming.extend(self.computer.select_assumptions(step));
        let (Some(moved), Some(step)) = (expression_to_ast(moved), expression_to_ast(step.clone()))
        else {
            return false;
        };
        assuming.push(moved.eq(&step).not());
        self.within_candidate_budget(|solver| solver.check_timed(&assuming)) == SatResult::Unsat
    }

    fn within_candidate_budget(&self, check: impl FnOnce(&Solver) -> SatResult) -> SatResult {
        let solver = Solver::new();
        for assertion in self.computer.solver().get_assertions() {
            solver.assert(&assertion);
        }
        let mut bounded = Params::new();
        bounded.set_u32("rlimit", CANDIDATE_PROOF_RESOURCE_LIMIT);
        solver.set_params(&bounded);
        check(&solver)
    }

    fn step_past_inner_loops(
        &self,
        observed: &mut [LoopInvariant],
        entry: &MachineState,
        current: &MachineState,
        visits: &[&MachineState],
    ) {
        for (i, invariant) in observed.iter_mut().enumerate() {
            if *invariant != LoopInvariant::Unknown {
                continue;
            }
            let (before, after) = (&entry.0[i], &current.0[i]);
            if before.kind == RegisterKind::Number || after.kind == RegisterKind::Number {
                continue;
            }
            let carried_before = value_of(before).get_abstracts();
            let inner_exit_symbols: Vec<String> = self
                .loops
                .closed_counters
                .iter()
                .filter(|(counter, _)| match counter {
                    AbstractExpression::Abstract(name) => carried_before.contains(name),
                    _ => false,
                })
                .flat_map(|(_, values)| values.iter().flat_map(|value| value.get_abstracts()))
                .collect();
            let moved = Affine::of_register(after)
                .zip(Affine::of_register(before))
                .and_then(|(after, before)| after.combine(&before, -1));
            let mentioned: Vec<String> = match moved {
                Some(moved) => moved.to_expression().get_abstracts(),
                None => [value_of(before), value_of(after)]
                    .iter()
                    .flat_map(|e| e.get_abstracts())
                    .collect(),
            };
            let relevant: Vec<&(AbstractExpression, Vec<AbstractExpression>)> = self
                .loops
                .closed_counters
                .iter()
                .rev()
                .filter(|(counter, _)| match counter {
                    AbstractExpression::Abstract(name) => mentioned.contains(name),
                    _ => false,
                })
                .collect();
            if relevant.is_empty() {
                if let Some(step) = self.step_held_by_invariant_symbols(i, entry, current, visits) {
                    log::info!("x{i} steps by {step}");
                    *invariant = LoopInvariant::Linear(step);
                }
                continue;
            }
            let choices: usize = relevant.iter().map(|(_, values)| values.len()).product();
            if choices > MAX_SETTLING_CHOICES {
                continue;
            }
            for choice in 0..choices {
                let mut remaining = choice;
                let assignment: Vec<(&AbstractExpression, &AbstractExpression)> = relevant
                    .iter()
                    .map(|(counter, values)| {
                        let value = &values[remaining % values.len()];
                        remaining /= values.len();
                        (counter, value)
                    })
                    .collect();
                let settle = |e: AbstractExpression| {
                    assignment
                        .iter()
                        .fold(e, |e, (counter, value)| match counter {
                            AbstractExpression::Abstract(name) => with_counter_at(&e, name, value),
                            _ => e,
                        })
                };
                let settled_before = settle(value_of(before));
                let settled_after = settle(value_of(after));
                if let Some(step) = self.proven_settled_step(
                    (before, after),
                    &settled_before,
                    &settled_after,
                    &inner_exit_symbols,
                ) {
                    let step = self.simplified_step(step);
                    log::info!("x{i} steps by {step} once inner loop counters are settled");
                    *invariant = LoopInvariant::Linear(step);
                    break;
                }
            }
        }
    }

    fn step_held_by_invariant_symbols(
        &self,
        register: usize,
        entry: &MachineState,
        current: &MachineState,
        visits: &[&MachineState],
    ) -> Option<AbstractExpression> {
        let (before, after) = (&entry.0[register], &current.0[register]);
        let moved = Affine::of_register(after)?.combine(&Affine::of_register(before)?, -1)?;
        if moved.terms.is_empty() || moved.mentions_a_loop_counter() {
            return None;
        }
        let known_at_entry: Vec<String> = entry
            .0
            .iter()
            .flat_map(|value| value_of(value).get_abstracts())
            .collect();
        let made_this_iteration = moved.terms.iter().any(|(atom, _)| {
            atom.get_abstracts()
                .iter()
                .any(|symbol| !known_at_entry.contains(symbol))
        });
        if made_this_iteration {
            return None;
        }
        let moving: Vec<(usize, Vec<String>)> = entry
            .0
            .iter()
            .zip(current.0.iter())
            .enumerate()
            .filter(|(_, (was, is))| was != is)
            .map(|(j, (was, is))| {
                let mut symbols = value_of(was).get_abstracts();
                symbols.extend(value_of(is).get_abstracts());
                (j, symbols)
            })
            .collect();
        let carried_elsewhere = |symbol: &String| {
            moving
                .iter()
                .any(|(j, symbols)| *j != register && symbols.contains(symbol))
        };
        let carried_anywhere =
            |symbol: &String| moving.iter().any(|(_, symbols)| symbols.contains(symbol));
        let invariant = moved.terms.iter().all(|(atom, _)| match atom {
            AbstractExpression::Abstract(symbol) => !carried_elsewhere(symbol),
            product => product
                .get_abstracts()
                .iter()
                .all(|symbol| !carried_anywhere(symbol)),
        });
        let step = moved.to_expression();
        if !self.proves_step(before, after, &step) {
            return None;
        }
        (invariant || self.repeated_on_every_visit(register, visits, after, &step)).then_some(step)
    }

    fn repeated_on_every_visit(
        &self,
        register: usize,
        visits: &[&MachineState],
        current: &RegisterValue,
        step: &AbstractExpression,
    ) -> bool {
        let mut walk: Vec<&RegisterValue> = visits.iter().map(|state| &state.0[register]).collect();
        walk.push(current);
        walk.len() > SUMMARY_ITERATION as usize
            && walk
                .windows(2)
                .all(|pair| self.proves_step(pair[0], pair[1], step))
    }

    fn anchor_past_inner_loops(
        &self,
        pc: usize,
        invariants: &[LoopInvariant],
        history: &[JumpRecord<M::LoopLanes>],
        current: &mut MachineState,
    ) {
        let closed: Vec<String> = self
            .loops
            .closed_counters
            .iter()
            .filter_map(|(counter, _)| match counter {
                AbstractExpression::Abstract(name) => Some(name.clone()),
                _ => None,
            })
            .collect();
        if closed.is_empty() {
            return;
        }
        for (i, invariant) in invariants.iter().enumerate() {
            let LoopInvariant::Linear(step) = invariant else {
                continue;
            };
            let mentions_closed = value_of(&current.0[i])
                .get_abstracts()
                .iter()
                .any(|symbol| closed.contains(symbol));
            if !mentions_closed {
                continue;
            }
            let mut visits: Vec<RegisterValue> = history
                .iter()
                .filter(|record| record.point.pc == pc)
                .map(|record| record.point.state.0[i].clone())
                .collect();
            visits.push(current.0[i].clone());
            let earliest = visits.len().saturating_sub(SUMMARY_ITERATION as usize + 1);
            if let Some(anchor) = (earliest..visits.len())
                .find_map(|start| self.proven_anchor(&visits[start..], step, &closed))
            {
                log::info!("x{i} re-anchored past inner loops at {anchor:?}");
                current.0[i] = anchor;
            }
        }
    }

    fn proven_anchor(
        &self,
        visits: &[RegisterValue],
        step: &AbstractExpression,
        closed: &[String],
    ) -> Option<RegisterValue> {
        let first = visits.first()?;
        let with_kind_of_first = |affine: &Affine| {
            let mut register = affine.to_register();
            if register.base.is_some() {
                register.kind = first.kind.clone();
            }
            register
        };
        let equals_first = |candidate: &Affine| {
            self.proves_step(
                &with_kind_of_first(candidate),
                first,
                &AbstractExpression::Immediate(0),
            )
        };
        let cleaned = self
            .with_inner_counters_settled_exactly(first)
            .filter(|settled| equals_first(settled))
            .or_else(|| {
                Affine::of_register(first)
                    .map(|affine| affine.without_terms_tied_to(closed))
                    .filter(|dropped| equals_first(dropped))
            })?;
        if !visits
            .windows(2)
            .all(|pair| self.proves_step(&pair[0], &pair[1], step))
        {
            return None;
        }
        let travelled = Affine::of(&generate_expression(
            "*",
            AbstractExpression::Immediate(visits.len() as i64 - 1),
            step.clone(),
        ))?;
        Some(with_kind_of_first(&cleaned.combine(&travelled, 1)?))
    }

    fn with_inner_counters_settled_exactly(&self, register: &RegisterValue) -> Option<Affine> {
        let mut settled = value_of(register);
        let mut changed = false;
        for (counter, values) in &self.loops.closed_counters {
            if let (AbstractExpression::Abstract(name), [value]) = (counter, values.as_slice())
                && settled.contains(name)
            {
                settled = with_counter_at(&settled, name, value);
                changed = true;
            }
        }
        if !changed {
            return None;
        }
        let affine = Affine::of(&exact_arithmetic_candidate(&settled)?)?;
        (!affine.mentions_a_loop_counter()).then_some(affine)
    }

    fn proven_settled_step(
        &self,
        (before, after): (&RegisterValue, &RegisterValue),
        settled_before: &AbstractExpression,
        settled_after: &AbstractExpression,
        inner_exit_symbols: &[String],
    ) -> Option<AbstractExpression> {
        let (settled_before, settled_after) =
            (Affine::of(settled_before)?, Affine::of(settled_after)?);
        let moved = settled_after.combine(&settled_before, -1)?;
        if moved.mentions_a_loop_counter() {
            return None;
        }
        let (known_before, known_after) = (
            settled_before.to_expression().get_abstracts(),
            settled_after.to_expression().get_abstracts(),
        );
        let step = moved.to_expression();
        let held_throughout = step.get_abstracts().iter().all(|symbol| {
            known_after.contains(symbol)
                && (known_before.contains(symbol) || inner_exit_symbols.contains(symbol))
        });
        if !held_throughout {
            return None;
        }
        let constant_part = AbstractExpression::Immediate(moved.constant);
        if step != constant_part && self.proves_step(before, after, &constant_part) {
            return Some(constant_part);
        }
        self.proves_step(before, after, &step).then_some(step)
    }

    fn rare_only_at_the_latest(
        &self,
        rare_when: &AbstractComparison,
        continuing: &AbstractComparison,
        counter: &LoopCounter,
    ) -> bool {
        let any = counter.symbol(LoopRole::Any).expression();
        let rare_at_any = comparison_with_counter_at(rare_when, counter.name(), &any);
        let continues_after = comparison_with_counter_at(
            continuing,
            counter.name(),
            &generate_expression("+", any.clone(), AbstractExpression::Immediate(1)),
        );
        let past_the_prefix =
            AbstractComparison::new(">=", any, AbstractExpression::Immediate(SUMMARY_ITERATION));
        let mut assuming = Vec::new();
        for comparison in [&rare_at_any, &continues_after] {
            assuming.extend(self.computer.select_assumptions(&comparison.left));
            assuming.extend(self.computer.select_assumptions(&comparison.right));
        }
        let (Some(past), Some(rare_taken), Some(continued)) = (
            comparison_to_ast(past_the_prefix),
            comparison_to_ast(rare_at_any),
            comparison_to_ast(continues_after),
        ) else {
            return false;
        };
        assuming.extend([past, rare_taken, continued]);
        self.computer.solver().check_timed(&assuming) == SatResult::Unsat
    }

    fn pinned_select_facts(
        &self,
        summary: &Summary,
        entry: &MachineState,
        current: &MachineState,
    ) -> Vec<ast::Bool> {
        let name = summary.counter.name().to_string();
        let previous = generate_expression(
            "-",
            summary.counter.expression(),
            AbstractExpression::Immediate(1),
        );
        let not_a_head_register = |_: &RegisterValue| None;
        let at_previous = |e: &AbstractExpression| {
            flag_at_summary(e, &entry.0, &summary.updates, &not_a_head_register)
                .map(|at_summary| with_counter_at(&at_summary, &name, &previous))
        };
        let mut facts = Vec::new();
        for (i, invariant) in summary.invariants.iter().enumerate() {
            let LoopInvariant::Linear(AbstractExpression::Immediate(moved)) = invariant else {
                continue;
            };
            let Some(step) = step_form(&entry.0[i], &current.0[i]) else {
                continue;
            };
            let [(select, &coefficient)] = step.terms.iter().collect::<Vec<_>>()[..] else {
                continue;
            };
            if coefficient == 0 || (moved - step.constant) % coefficient != 0 {
                continue;
            }
            let value = (moved - step.constant) / coefficient;
            let Some((condition, taken, skipped)) =
                self.computer.select_definitions().get(select).cloned()
            else {
                continue;
            };
            let (Some(left), Some(right), Some(taken), Some(skipped)) = (
                at_previous(&condition.left),
                at_previous(&condition.right),
                at_previous(&taken),
                at_previous(&skipped),
            ) else {
                continue;
            };
            let chosen = AbstractExpression::Immediate(value);
            let (Some(holds), Some(fails), Some(took), Some(skipped)) = (
                comparison_to_ast(AbstractComparison::new(
                    &condition.op,
                    left.clone(),
                    right.clone(),
                )),
                comparison_to_ast(AbstractComparison::new(&condition.op, left, right).not()),
                comparison_to_ast(AbstractComparison::new("==", taken, chosen.clone())),
                comparison_to_ast(AbstractComparison::new("==", skipped, chosen)),
            ) else {
                continue;
            };
            let previous_counter = ast::Int::new_const(name.clone());
            let summarized = previous_counter.gt(ast::Int::from_i64(SUMMARY_ITERATION));
            log::info!(
                "{} x{i} took {select} = {value} in every iteration before the latest",
                summary.counter.name()
            );
            facts.push(summarized.implies(ast::Bool::or(&[
                &ast::Bool::and(&[&holds, &took]),
                &ast::Bool::and(&[&fails, &skipped]),
            ])));
        }
        facts
    }

    fn settle_select_steps(
        &mut self,
        summary: &mut Summary,
        entry: &MachineState,
        current: &MachineState,
        ghosts: &[Ghost],
        continuing_now: &AbstractComparison,
    ) -> Vec<SettledSelectStep> {
        if self.record_at(summary.pc, |record| record.select_refuted) {
            return Vec::new();
        }
        let counter = summary.counter.clone();
        let clobbered_operand = |r: &RegisterValue| {
            ghosts
                .iter()
                .find(|ghost| ghost.value == *r && !current.0.contains(r))
                .map(|ghost| ghost_at_summary(ghost, &counter, 0))
        };
        let mut settled = Vec::new();
        for i in 0..summary.invariants.len() {
            if !matches!(summary.invariants[i], LoopInvariant::AtMost(_)) {
                continue;
            }
            let (before, now) = (&entry.0[i], &current.0[i]);
            let Some(step) = step_form(before, now) else {
                continue;
            };
            let [(select, 1)] = step.terms.iter().collect::<Vec<_>>()[..] else {
                continue;
            };
            if step.constant != 0 {
                continue;
            }
            let Some((condition, rare_arm, usual_arm)) =
                self.computer.select_definitions().get(select).cloned()
            else {
                continue;
            };
            let (Some(rare), Some(usual)) = (
                self.arm_constant(&rare_arm, continuing_now),
                self.arm_constant(&usual_arm, continuing_now),
            ) else {
                continue;
            };
            let side = |e: &AbstractExpression| {
                flag_at_summary(e, &current.0, &summary.updates, &clobbered_operand)
            };
            let (Some(left), Some(right)) = (side(&condition.left), side(&condition.right)) else {
                continue;
            };
            let taken_when = AbstractComparison::new(&condition.op, left, right);
            let orientations = [
                (taken_when.clone(), rare, usual),
                (taken_when.not(), usual, rare),
            ];
            let Some((latest_when, rare, usual)) =
                orientations.into_iter().find(|(rare_when, _, _)| {
                    self.rare_only_at_the_latest(rare_when, &summary.continuing, &counter)
                })
            else {
                log::info!(
                    "{} x{i}: either arm of {select} may be taken before the latest iteration",
                    summary.id
                );
                continue;
            };

            let latest = counter.symbol(LoopRole::Latest(i));
            self.computer.select_definitions_mut().insert(
                latest.to_string(),
                (
                    latest_when.clone(),
                    AbstractExpression::Immediate(rare),
                    AbstractExpression::Immediate(usual),
                ),
            );
            let usual_steps = generate_expression(
                "*",
                AbstractExpression::Immediate(usual),
                generate_expression(
                    "-",
                    counter.expression(),
                    AbstractExpression::Immediate(SUMMARY_ITERATION),
                ),
            );
            let value = generate_expression(
                "+",
                generate_expression("+", value_of(before), usual_steps),
                latest.expression(),
            );
            let settled_register = RegisterValue::new(
                if now.base.is_some() {
                    now.kind.clone()
                } else {
                    RegisterKind::RegisterBase
                },
                Some(value),
                0,
            );
            log::info!(
                "{} x{i} steps {usual} except possibly the latest, {rare} when {latest_when}",
                summary.id
            );
            match summary.updates.iter_mut().find(|(j, _)| *j == i) {
                Some(update) => update.1 = settled_register,
                None => summary.updates.push((i, settled_register)),
            }
            settled.push(SettledSelectStep {
                register: i,
                holds_the_select: false,
                condition: latest_when.clone(),
                rare,
                usual,
            });
            let latest_value = latest.expression();
            for (j, held) in current.0.iter().enumerate() {
                if j == i || value_of(held) != AbstractExpression::Abstract(select.clone()) {
                    continue;
                }
                let carrier =
                    RegisterValue::new(RegisterKind::RegisterBase, Some(latest_value.clone()), 0);
                match summary.updates.iter_mut().find(|(k, _)| *k == j) {
                    Some(update) => update.1 = carrier,
                    None => summary.updates.push((j, carrier)),
                }
                settled.push(SettledSelectStep {
                    register: j,
                    holds_the_select: true,
                    condition: latest_when.clone(),
                    rare,
                    usual,
                });
            }
        }
        settled
    }

    fn branches_not_carried(&self, active: &ActiveLoop) -> BTreeSet<usize> {
        let counter = LoopCounter::for_loop(active.id);
        let (name, next_iteration) = (counter.name(), counter.next_iteration());
        let mut uncarried = BTreeSet::new();
        for (branch, fact) in &active.branch_facts {
            let next = comparison_with_counter_at(fact, name, &next_iteration);
            if !self.proves(next.clone()) {
                log::info!("{} did not carry {next} to its next iteration", active.id);
                uncarried.insert(*branch);
            }
        }
        uncarried
    }

    fn choose_registers(
        &mut self,
        summary: &mut Summary,
        (staying, continues_when): (&AbstractComparison, bool),
        entry: &MachineState,
        current: &MachineState,
    ) -> Vec<ChosenRegister> {
        if self.record_at(summary.pc, |record| record.chosen_refuted) {
            return Vec::new();
        }
        let mut chosen = Vec::new();
        for i in 0..summary.invariants.len().min(current.0.len()) {
            let Some(candidate) = self.choice_over_a_leader(&summary.invariants, &current.0, i)
            else {
                continue;
            };
            let holds_at_entry = self.while_staying(staying, continues_when, |engine| {
                engine.chosen_holds(&candidate, &entry.0)
            });
            if !holds_at_entry || !self.chosen_holds(&candidate, &current.0) {
                continue;
            }
            let leader = summary
                .updates
                .iter()
                .find(|(j, _)| *j == candidate.leader)
                .map_or_else(|| current.0[candidate.leader].clone(), |(_, u)| u.clone());
            let Some(leader_base) = leader.base.clone() else {
                continue;
            };
            let name = format!("{}_chosen_{i}", summary.counter.name());
            let condition = chosen_condition(&candidate.condition, &value_of(&leader));
            self.computer.select_definitions_mut().insert(
                name.clone(),
                (
                    condition.clone(),
                    AbstractExpression::Immediate(leader.offset + candidate.taken),
                    AbstractExpression::Immediate(leader.offset + candidate.skipped),
                ),
            );
            let register = RegisterValue::new(
                current.0[i].kind.clone(),
                Some(generate_expression(
                    "+",
                    leader_base,
                    AbstractExpression::Abstract(name.clone()),
                )),
                0,
            );
            log::info!(
                "{} x{i} is x{} + {} when {condition}, else + {}",
                summary.id,
                candidate.leader,
                candidate.taken,
                candidate.skipped
            );
            match summary.updates.iter_mut().find(|(j, _)| *j == i) {
                Some(update) => update.1 = register,
                None => summary.updates.push((i, register)),
            }
            summary.invariants[i] = LoopInvariant::Unknown;
            chosen.push(candidate);
        }
        chosen
    }

    fn choice_over_a_leader(
        &self,
        invariants: &[LoopInvariant],
        current: &[RegisterValue],
        i: usize,
    ) -> Option<ChosenRegister> {
        let now = &current[i];
        if now.kind != RegisterKind::RegisterBase {
            return None;
        }
        let AbstractExpression::Expression(op, left, right) = now.base.as_ref()? else {
            return None;
        };
        if op != "+" {
            return None;
        }
        let selects = self.computer.select_definitions();
        let (base, select) = [(left, right), (right, left)].into_iter().find_map(
            |(base, select)| match &**select {
                AbstractExpression::Abstract(name) if selects.contains_key(name) => {
                    Some(((**base).clone(), name.clone()))
                }
                _ => None,
            },
        )?;
        let (
            condition,
            AbstractExpression::Immediate(taken),
            AbstractExpression::Immediate(skipped),
        ) = selects.get(&select)?.clone()
        else {
            return None;
        };
        let leader = (0..invariants.len().min(current.len())).find(|&j| {
            j != i
                && matches!(
                    invariants[j],
                    LoopInvariant::Linear(AbstractExpression::Immediate(_))
                )
                && current[j].kind == RegisterKind::RegisterBase
                && current[j].base.as_ref() == Some(&base)
        })?;
        let at = current[leader].offset;
        let relative =
            |e: &AbstractExpression| relative_to_leader(e, &base, at, current, invariants);
        Some(ChosenRegister {
            register: i,
            leader,
            condition: AbstractComparison::new(
                &condition.op,
                relative(&condition.left)?,
                relative(&condition.right)?,
            ),
            taken: taken + now.offset - at,
            skipped: skipped + now.offset - at,
        })
    }

    fn chosen_holds(&self, chosen: &ChosenRegister, state: &[RegisterValue]) -> bool {
        let (Some(leader), Some(held)) = (state.get(chosen.leader), state.get(chosen.register))
        else {
            return false;
        };
        let (leader, held) = (value_of(leader), value_of(held));
        let condition = chosen_condition(&chosen.condition, &leader);
        let mut assuming = self.computer.select_assumptions(&held);
        assuming.extend(self.computer.select_assumptions(&leader));
        assuming.extend(self.computer.select_assumptions(&condition.left));
        assuming.extend(self.computer.select_assumptions(&condition.right));
        let (Some(condition), Some(held), Some(leader)) = (
            comparison_to_ast(condition),
            expression_to_ast(held),
            expression_to_ast(leader),
        ) else {
            return false;
        };
        let refuted_when = |holds: ast::Bool, offset: i64| {
            let mut with = assuming.clone();
            with.push(holds);
            with.push(
                held.eq(ast::Int::add(&[&leader, &ast::Int::from_i64(offset)]))
                    .not(),
            );
            refuted_within(
                self.computer.solver(),
                &ast::Bool::and(&with),
                OBLIGATION_INCREMENTAL_RESOURCE_LIMIT,
                OBLIGATION_RESOURCE_LIMIT,
            )
        };
        refuted_when(condition.clone(), chosen.taken)
            && refuted_when(condition.not(), chosen.skipped)
    }

    fn unrepeated_settled_step(&self, active: &ActiveLoop) -> Option<usize> {
        let counter = LoopCounter::for_loop(active.id);
        let (name, next_iteration) = (counter.name(), counter.next_iteration());
        let continues = comparison_with_counter_at(&active.continuing, name, &next_iteration);
        let repeats = |settled: &SettledSelectStep| {
            let now = value_of(&self.computer.register_at(settled.register));
            let step = if settled.holds_the_select {
                now
            } else {
                generate_expression("-", now, value_of(&active.state.0[settled.register]))
            };
            let condition = comparison_with_counter_at(&settled.condition, name, &next_iteration);
            let mut assuming = self.computer.select_assumptions(&step);
            assuming.extend(self.computer.select_assumptions(&continues.left));
            assuming.extend(self.computer.select_assumptions(&continues.right));
            let Some(continuing) = comparison_to_ast(continues.clone()) else {
                return false;
            };
            assuming.push(continuing);
            assuming.extend(self.computer.select_assumptions(&condition.left));
            assuming.extend(self.computer.select_assumptions(&condition.right));
            let (Some(step), Some(condition)) =
                (expression_to_ast(step), comparison_to_ast(condition))
            else {
                return false;
            };
            let refuted_when = |holds: ast::Bool, arm: i64| {
                let mut with = assuming.clone();
                with.push(holds);
                with.push(step.eq(ast::Int::from_i64(arm)).not());
                self.computer.solver().check_timed(&with) == SatResult::Unsat
            };
            refuted_when(condition.clone(), settled.rare)
                && refuted_when(condition.not(), settled.usual)
        };
        let unrepeated = active
            .settled_steps
            .iter()
            .find(|settled| !repeats(settled))?;
        log::info!(
            "{} a settled select step did not repeat; summarizing it as bounded instead",
            active.id
        );
        Some(unrepeated.register)
    }

    fn stack_cells_a_blind_write_may_reach(&self, active: &ActiveLoop) -> Vec<MemoryCell> {
        let from = active
            .blind_writes_at_summary
            .min(self.computer.blind_stack_writes().len());
        let writes = &self.computer.blind_stack_writes()[from..];
        if writes.is_empty() {
            return Vec::new();
        }
        let Some(stack) = self.computer.memory().get("sp") else {
            return Vec::new();
        };
        let already_unknown = |cell: &MemoryCell| {
            active
                .cells
                .iter()
                .any(|(known, invariant)| known == cell && *invariant == LoopInvariant::Unknown)
        };
        let tracked: Vec<MemoryCell> = stack
            .content
            .keys()
            .map(|offset| MemoryCell {
                region: "sp".to_string(),
                offset: *offset,
            })
            .filter(|cell| !already_unknown(cell))
            .collect();
        let stack_pointer = ast::Int::new_const("sp");
        let mut reached = Vec::new();
        for cell in tracked {
            let cell_start = ast::Int::add(&[&stack_pointer, &ast::Int::from_i64(cell.offset)]);
            let cell_width = stack.width_at(cell.offset).unwrap_or(WIDEST_STORED_VALUE);
            let cell_end = ast::Int::add(&[&cell_start, &ast::Int::from_i64(cell_width)]);
            let may_overlap = writes.iter().any(|(base, offset, width)| {
                if !is_translatable(base) {
                    return true;
                }
                let Some(base) = expression_to_ast(base.clone()) else {
                    return true;
                };
                let write_start = ast::Int::add(&[&base, &ast::Int::from_i64(*offset)]);
                let write_end = ast::Int::add(&[&write_start, &ast::Int::from_i64(*width)]);
                let overlap =
                    ast::Bool::and(&[&write_start.lt(&cell_end), &cell_start.lt(&write_end)]);
                self.computer.solver().check_timed(&[overlap]) != SatResult::Unsat
            });
            if may_overlap {
                reached.push(cell);
            }
        }
        reached
    }

    fn is_overwritten_before_any_read(
        &self,
        from: usize,
        register: usize,
        returning_ends_the_function: bool,
    ) -> bool {
        let starts = self.static_successors(from).unwrap_or_default();
        self.is_overwritten_along(starts, register, returning_ends_the_function)
    }

    fn is_overwritten_along(
        &self,
        starts: Vec<usize>,
        register: usize,
        returning_ends_the_function: bool,
    ) -> bool {
        let mut seen = BTreeSet::new();
        let mut pending: Vec<(usize, Vec<usize>)> =
            starts.into_iter().map(|pc| (pc, Vec::new())).collect();
        if pending.is_empty() {
            return false;
        }
        while let Some((pc, return_sites)) = pending.pop() {
            if !seen.insert((pc, return_sites.clone())) {
                continue;
            }
            let Some(instruction) = self.program.code.get(pc) else {
                return false;
            };
            if instruction.flow() == Flow::Indirect {
                return false;
            }
            if instruction.overwrites_without_reading(register) {
                continue;
            }
            if instruction.mentions(register) {
                return false;
            }
            if instruction.flow() == Flow::Call {
                let Some(callee) = instruction
                    .call_target()
                    .and_then(|label| self.resolve_jump_target(label, pc).ok())
                else {
                    return false;
                };
                if return_sites.len() >= MAX_CALL_DEPTH {
                    return false;
                }
                let mut inside = return_sites;
                inside.push(pc + 1);
                pending.push((callee, inside));
                continue;
            }
            match self.static_successors(pc) {
                Some(successors) if successors.is_empty() => {
                    if instruction.flow() == Flow::Return
                        && let Some((&site, outer)) = return_sites.split_last()
                    {
                        pending.push((site, outer.to_vec()));
                    } else if !returning_ends_the_function
                        || (instruction.flow() == Flow::Return
                            && M::CALLEE_SAVED_REGISTERS.contains(&register))
                    {
                        return false;
                    }
                }
                Some(successors) => pending.extend(
                    successors
                        .into_iter()
                        .map(|next| (next, return_sites.clone())),
                ),
                None => return false,
            }
        }
        true
    }

    pub(super) fn loaded_value_only_fills_lanes(&self, pc: usize) -> bool {
        let code = &self.program.code;
        let Some(register) = code.get(pc).and_then(|load| load.loaded_register()) else {
            return false;
        };
        let mut next = pc + 1;
        while let Some(instruction) = code.get(next) {
            if !instruction.is_straight_line() {
                break;
            }
            if instruction.fills_lanes_from(register) {
                next += 1;
                continue;
            }
            if instruction.overwrites_without_reading(register) {
                return true;
            }
            if instruction.mentions(register) {
                return false;
            }
            next += 1;
        }
        self.is_overwritten_along(vec![next], register, self.returning_ends_the_function())
    }

    fn returning_ends_the_function(&self) -> bool {
        let has_calls = self
            .program
            .code
            .iter()
            .any(|instruction| instruction.flow() == Flow::Call);
        !has_calls || self.suspended.is_empty()
    }

    fn overwritten_when_continuing(&self, pc: usize, continues: bool, register: usize) -> bool {
        let Some(successors) = self.static_successors(pc) else {
            return false;
        };
        let [target, fallthrough] = successors.as_slice() else {
            return false;
        };
        let staying = if continues { *target } else { *fallthrough };
        self.is_overwritten_along(vec![staying], register, self.returning_ends_the_function())
    }

    fn dead_after(&self, pc: usize) -> Rc<Vec<usize>> {
        let returning_ends_the_function = self.returning_ends_the_function();
        let key = (pc, returning_ends_the_function);
        if let Some(known) = self.dead_registers.borrow().get(&key) {
            return Rc::clone(known);
        }
        let dead: Vec<usize> = (0..M::Instruction::TRACKED_REGISTERS)
            .filter(|&register| {
                self.is_overwritten_before_any_read(pc, register, returning_ends_the_function)
            })
            .collect();
        let dead = Rc::new(dead);
        self.dead_registers
            .borrow_mut()
            .insert(key, Rc::clone(&dead));
        dead
    }

    fn forget_dead_registers(
        &mut self,
        pc: usize,
        guard: &AbstractComparison,
        continues: bool,
        snapshots: &mut [&mut MachineState],
    ) {
        let read_by_guard = registers_in(guard);
        let dead = self.dead_after(pc);
        let live: Vec<RegisterValue> = (0..M::Instruction::TRACKED_REGISTERS)
            .filter(|other| !dead.contains(other))
            .map(|other| self.computer.register_at(other))
            .collect();
        let fresh_each_iteration: Vec<usize> = (0..M::Instruction::TRACKED_REGISTERS)
            .filter(|register| !dead.contains(register))
            .filter(|&register| {
                let value = self.computer.register_at(register);
                read_by_guard.contains(&value)
                    && !self.tied_to_other_registers(register, &value)
                    && self.overwritten_when_continuing(pc, continues, register)
            })
            .collect();
        for &register in dead.iter().chain(fresh_each_iteration.iter()) {
            let value = self.computer.register_at(register);
            if dead.contains(&register) && read_by_guard.contains(&value) && !live.contains(&value)
            {
                continue;
            }
            let forgotten = RegisterValue::new(RegisterKind::Number, None, 0);
            self.computer.set_register_at(register, forgotten.clone());
            for snapshot in snapshots.iter_mut() {
                snapshot.0[register] = forgotten.clone();
            }
        }
    }

    fn tied_to_other_registers(&self, register: usize, value: &RegisterValue) -> bool {
        let Some(base) = &value.base else {
            return true;
        };
        let symbols = base.get_abstracts();
        (0..M::Instruction::TRACKED_REGISTERS)
            .filter(|&other| other != register)
            .filter_map(|other| self.computer.register_at(other).base)
            .any(|other| {
                other
                    .get_abstracts()
                    .iter()
                    .any(|symbol| symbols.contains(symbol))
            })
    }

    pub(super) fn cycle_back_edge(
        &self,
        loop_pc: usize,
        continues: bool,
        cycle: &[JumpRecord<M::LoopLanes>],
    ) -> Option<(usize, usize, BTreeSet<usize>)> {
        let _resolving = profile::enter(Phase::LoopResolution);
        let branch_step = |pc: usize, taken: bool| -> Option<usize> {
            match self.static_successors(pc)?.as_slice() {
                [target, fallthrough] => Some(if taken { *target } else { *fallthrough }),
                _ => None,
            }
        };
        let mut walked = BTreeSet::new();
        let mut edge = None;
        let mut pc = loop_pc;
        let mut next = branch_step(loop_pc, continues)?;
        let mut remaining = cycle.iter();
        for _ in 0..(cycle.len() + 2) * self.program.code.len() {
            if next <= pc {
                edge = Some((pc, next));
            }
            if next == loop_pc {
                let (source, header) = edge?;
                return Some((source, header, walked));
            }
            walked.insert(next);
            pc = next;
            let flow = self.program.code.get(pc)?.flow();
            next = if matches!(flow, Flow::Branch(_)) {
                let mut ahead = remaining.clone();
                let taken = match ahead.find(|record| record.point.pc == pc) {
                    Some(record) => {
                        remaining = ahead;
                        record.taken
                    }
                    None => *self.concrete_decisions.get(&pc)?,
                };
                branch_step(pc, taken)?
            } else {
                match self.static_successors(pc)?.as_slice() {
                    [only] => *only,
                    _ => return None,
                }
            };
        }
        None
    }

    pub(super) fn stays_in_loop(
        &self,
        from: usize,
        header: usize,
        source: usize,
        other_back_edges: bool,
    ) -> bool {
        let _resolving = profile::enter(Phase::LoopResolution);
        if from == header {
            return true;
        }
        let mut seen = BTreeSet::new();
        let mut pending = vec![from];
        while let Some(pc) = pending.pop() {
            if pc == source {
                return true;
            }
            if pc == header || !seen.insert(pc) {
                continue;
            }
            let Some(successors) = self.static_successors(pc) else {
                return true;
            };
            for next in successors {
                if other_back_edges && next == header && pc >= header {
                    return true;
                }
                pending.push(next);
            }
        }
        false
    }

    fn exits_elsewhere(&self, pc: usize, walked: &BTreeSet<usize>) -> bool {
        walked
            .iter()
            .filter(|&&branch| branch != pc)
            .any(|&branch| {
                self.static_successors(branch).is_some_and(|successors| {
                    successors.len() == 2
                        && successors.iter().any(|next| {
                            !walked.contains(next) && self.can_leave_cycle(*next, walked)
                        })
                })
            })
    }

    fn can_leave_cycle(&self, from: usize, walked: &BTreeSet<usize>) -> bool {
        let mut seen = BTreeSet::new();
        let mut pending = vec![from];
        while let Some(pc) = pending.pop() {
            if walked.contains(&pc) || !seen.insert(pc) {
                continue;
            }
            match self.static_successors(pc) {
                Some(successors) if successors.is_empty() => return true,
                Some(successors) => pending.extend(successors),
                None => (),
            }
        }
        false
    }

    fn flag_source(&self, branch_pc: usize) -> Option<usize> {
        M::Instruction::flag_source(&self.program.code, branch_pc)
    }

    pub(super) fn exit_ghosts(
        &self,
        exits: Vec<JumpRecord<M::LoopLanes>>,
        before: &[JumpRecord<M::LoopLanes>],
        (loop_pc, entry, steps): (usize, &[RegisterValue], &[LoopInvariant]),
    ) -> Vec<GhostedRecord<M::LoopLanes>> {
        let _resolving = profile::enter(Phase::LoopResolution);
        let iteration_start = before.iter().rposition(|r| r.point.pc == loop_pc);
        exits
            .into_iter()
            .map(|record| {
                let earlier = iteration_start.and_then(|start| {
                    before[start + 1..]
                        .iter()
                        .rev()
                        .find(|r| r.point.pc == record.point.pc && r.taken == record.taken)
                });
                let ghosts = earlier.map_or_else(Vec::new, |earlier| {
                    ghost_operands(
                        &earlier.point.condition,
                        &record.point.condition,
                        &earlier.point.state.0,
                        &record.point.state.0,
                        |_| None,
                    )
                });
                let ghosts = match (earlier, self.flag_source(record.point.pc)) {
                    (None, Some(n)) => entry
                        .get(n)
                        .zip(steps.get(n))
                        .and_then(|(value, step)| match step {
                            LoopInvariant::Linear(AbstractExpression::Immediate(step))
                                if *step != 0 =>
                            {
                                [value.clone(), word_view(value)]
                                    .into_iter()
                                    .find_map(|tested| {
                                        leaf_path(&record.point.condition, &tested)
                                            .map(|path| (path, tested))
                                    })
                                    .map(|(path, value)| Ghost {
                                        path,
                                        value,
                                        step: *step,
                                    })
                            }
                            _ => None,
                        })
                        .into_iter()
                        .collect(),
                    _ => ghosts,
                };
                (record, ghosts)
            })
            .collect()
    }

    fn loop_exits(
        &self,
        loop_pc: usize,
        continues: bool,
        cycle: &[JumpRecord<M::LoopLanes>],
    ) -> Vec<JumpRecord<M::LoopLanes>> {
        let Some((source, header, walked)) = self.cycle_back_edge(loop_pc, continues, cycle) else {
            return Vec::new();
        };
        let mut exits: Vec<JumpRecord<M::LoopLanes>> = Vec::new();
        for record in cycle.iter().rev() {
            let pc = record.point.pc;
            if pc == loop_pc
                || !walked.contains(&pc)
                || exits.iter().any(|exit| exit.point.pc == pc)
                || cycle
                    .iter()
                    .any(|other| other.point.pc == pc && other.taken != record.taken)
            {
                continue;
            }
            let Some(successors) = self.static_successors(pc) else {
                continue;
            };
            let [target, fallthrough] = successors.as_slice() else {
                continue;
            };
            let other = if record.taken { *fallthrough } else { *target };
            if !self.stays_in_loop(other, header, source, pc != source) {
                exits.push(record.clone());
            }
        }
        exits
    }

    fn resolved_leaves(
        &self,
        e: &AbstractExpression,
        settlements: &mut SelectSettlements,
    ) -> AbstractExpression {
        match e {
            AbstractExpression::Register(register) => match &register.base {
                Some(base) => AbstractExpression::Register(Box::new(RegisterValue {
                    base: Some(self.resolved_selects(base, settlements)),
                    ..(**register).clone()
                })),
                None => e.clone(),
            },
            AbstractExpression::Expression(op, left, right) => generate_expression(
                op,
                self.resolved_leaves(left, settlements),
                self.resolved_leaves(right, settlements),
            ),
            other => self.resolved_selects(other, settlements),
        }
    }

    fn resolve_selects(&self, state: &mut MachineState, settlements: &mut SelectSettlements) {
        if self.computer.select_definitions().is_empty() {
            return;
        }
        for register in state.0.iter_mut() {
            let Some(base) = register.base.clone() else {
                continue;
            };
            register.base = Some(self.resolved_selects(&base, settlements));
        }
    }

    fn settled_select(&self, name: &str) -> Option<AbstractExpression> {
        let (condition, taken, skipped) = self.computer.select_definitions().get(name)?;
        let holds = comparison_to_ast(condition.clone())?;
        let settled = if self
            .computer
            .solver()
            .check_timed(std::slice::from_ref(&holds))
            == SatResult::Unsat
        {
            skipped
        } else if self.computer.solver().check_timed(&[holds.not()]) == SatResult::Unsat {
            taken
        } else {
            return None;
        };
        Some(match self.pinned_value(settled) {
            Some(value) => AbstractExpression::Immediate(value),
            None => settled.clone(),
        })
    }

    fn resolved_selects(
        &self,
        base: &AbstractExpression,
        settlements: &mut SelectSettlements,
    ) -> AbstractExpression {
        {
            let mut resolved = base.clone();
            for name in resolved.get_abstracts() {
                let settled = settlements
                    .entry(name.clone())
                    .or_insert_with(|| self.settled_select(&name))
                    .clone();
                let Some(settled) = settled else {
                    continue;
                };
                resolved = substitute(&resolved, &name, &settled);
            }
            resolved
        }
    }

    fn widen_for_retry(
        &mut self,
        active: &ActiveLoop,
        observed: &[LoopInvariant],
        unbounded: Vec<String>,
    ) {
        let mut joined = join_all(&active.invariants, observed);
        for (i, inv) in joined.iter_mut().enumerate() {
            if *inv != active.invariants[i]
                && self.computer.carries_region(&active.entry_state.0[i])
            {
                *inv = active.invariants[i].clone();
            }
        }
        self.update_record(active.pc, |record| {
            for (i, inv) in joined.iter().enumerate() {
                if *inv == LoopInvariant::Unknown && active.invariants[i] != LoopInvariant::Unknown
                {
                    record.unstable_registers.insert(i);
                }
            }
        });
        if self.out_of_tries(active.pc) {
            return;
        }
        if joined == active.invariants && unbounded.is_empty() {
            return;
        }
        let earlier = match self.loops.attempts.get(&active.pc) {
            Some(earlier) => LoopAttempt {
                id: active.id,
                ..earlier.clone()
            },
            None => LoopAttempt {
                id: active.id,
                invariants: Vec::new(),
                rounds: 1,
                widened: false,
                rejected_bounds: Vec::new(),
            },
        };
        let Ok(mut retry) = earlier.advance(joined, true) else {
            return;
        };
        retry.rejected_bounds.extend(unbounded);
        self.loops.attempts.insert(active.pc, retry);
        log::info!(
            "{} at line {} widening after a failed inductive check",
            active.id,
            active.pc
        );
    }

    fn release_loop(&mut self, active: &ActiveLoop) {
        let above = self.scopes_above(active.scope_id);
        self.pop_scope(active.scope_id);
        let mut kept: Vec<ast::Bool> = active
            .facts
            .iter()
            .filter_map(summary_fact_to_ast)
            .collect();
        kept.extend(active.nested_facts.iter().cloned());
        self.keep_facts(kept);
        self.rebuild_scopes(above);
        self.jump_history.truncate(active.history_len);
        self.loops.attempts.remove(&active.pc);
    }

    fn keep_facts(&mut self, facts: Vec<ast::Bool>) {
        for fact in &facts {
            self.computer.solver().assert(fact);
        }
        if let Some(enclosing) = self.loops.active.last_mut() {
            enclosing.nested_facts.extend(facts);
        }
    }

    pub(super) fn suspend_for_call(&mut self, pc: usize) {
        let loops = std::mem::take(&mut self.loops.active);
        log::info!(
            "suspended {} loop(s) across the call at line {pc}",
            loops.len()
        );
        let rounds = std::mem::take(&mut self.loops.rounds);
        self.suspended.push(SuspendedCall {
            resume: pc + 1,
            loops,
            rounds,
            history_len: self.jump_history.len(),
        });
    }

    pub(super) fn resume_suspended(&mut self) {
        let Some(call) = self.suspended.pop() else {
            return;
        };
        while let Some(inner) = self.loops.active.pop() {
            log::info!("{} released at the return", inner.id);
            self.release_loop(&inner);
        }
        self.jump_history
            .truncate(call.history_len.min(self.jump_history.len()));
        log::info!("resumed {} loop(s) after the call", call.loops.len());
        self.loops.active = call.loops;
        self.loops.rounds = call.rounds;
    }

    fn plausible(
        &self,
        bound: &Bound,
        previous: &[RegisterValue],
        current: &[RegisterValue],
    ) -> bool {
        let moved = AbstractComparison::new(
            bound.op,
            current[bound.register].expression(),
            previous[bound.register].expression(),
        );
        let stayed = AbstractComparison::new(
            "==",
            current[bound.register].expression(),
            previous[bound.register].expression(),
        );
        match bound.anchor {
            Some(AbstractExpression::Immediate(_)) => {
                self.implied(&bound.at(previous)) && self.implied(&bound.at(current))
            }
            Some(_) => self.implied(&moved) && !self.implied(&stayed),
            None => self.implied(&bound.at(previous)) && self.implied(&bound.at(current)),
        }
    }

    fn down_counter_floors(
        &self,
        invariants: &[LoopInvariant],
        current: &[RegisterValue],
        guard: &AbstractComparison,
    ) -> Vec<Bound> {
        let in_guard = registers_in(guard);
        let read_by_guard = |now: &RegisterValue| {
            in_guard.iter().any(|r| {
                r == now
                    || word_view(now) == *r
                    || self.implied(&AbstractComparison::new(
                        "==",
                        r.expression(),
                        now.expression(),
                    ))
            })
        };
        let counting_down: Vec<usize> = invariants
            .iter()
            .zip(current)
            .enumerate()
            .filter(|(_, (invariant, now))| {
                matches!(
                    invariant,
                    LoopInvariant::Linear(AbstractExpression::Immediate(step)) if *step < 0
                ) && now.kind != RegisterKind::Number
            })
            .map(|(register, _)| register)
            .collect();
        counting_down
            .into_iter()
            .filter(|&register| read_by_guard(&current[register]))
            .flat_map(|register| {
                [1, 0].map(|floor| Bound {
                    register,
                    op: ">=",
                    other: None,
                    offset: 0,
                    anchor: Some(AbstractExpression::Immediate(floor)),
                })
            })
            .collect()
    }

    fn word_limits(
        &self,
        invariants: &[LoopInvariant],
        current: &[RegisterValue],
        guard: &AbstractComparison,
    ) -> Vec<Bound> {
        let limited: Vec<(usize, i64)> = invariants
            .iter()
            .zip(current)
            .enumerate()
            .filter(|(_, (invariant, now))| {
                **invariant == LoopInvariant::Unknown && now.kind != RegisterKind::Number
            })
            .filter_map(|(i, (_, now))| Some((i, self.proven_upper_bound(now)?)))
            .collect();
        let mut bounds: Vec<Bound> = limited
            .iter()
            .flat_map(|&(register, limit)| {
                [(">=", 0), ("<=", limit)].map(|(op, value)| Bound {
                    register,
                    op,
                    other: None,
                    offset: 0,
                    anchor: Some(AbstractExpression::Immediate(value)),
                })
            })
            .collect();
        bounds.extend(limited.iter().flat_map(|&(register, _)| {
            WIDENED_FLOORS.map(|floor| Bound {
                register,
                op: ">=",
                other: None,
                offset: 0,
                anchor: Some(AbstractExpression::Immediate(floor)),
            })
        }));
        let guarded: Vec<usize> = registers_in(guard)
            .iter()
            .filter_map(|r| current.iter().position(|c| c == r || word_view(c) == *r))
            .collect();
        for &(register, _) in &limited {
            for &other in guarded.iter().filter(|other| **other != register) {
                let ahead = NEIGHBOUR_GAPS.into_iter().find(|gap| {
                    self.implied(&AbstractComparison::new(
                        "<=",
                        current[register].expression(),
                        generate_expression(
                            "+",
                            current[other].expression(),
                            AbstractExpression::Immediate(*gap),
                        ),
                    ))
                });
                if let Some(offset) = ahead {
                    bounds.push(Bound {
                        register,
                        op: "<=",
                        other: Some(other),
                        offset,
                        anchor: None,
                    });
                }
            }
        }
        bounds
    }

    fn implied(&self, fact: &AbstractComparison) -> bool {
        let Some(violated) = comparison_to_ast(fact.not()) else {
            return false;
        };
        let mut assuming = self.select_definitions_in(fact);
        assuming.push(violated);
        check(self.computer.solver(), &assuming) == SatResult::Unsat
    }

    fn ordered_by_consecutive_exits(
        &self,
        (previous, current, continues): (&BranchPoint<M::LoopLanes>, &AbstractComparison, bool),
        cycle: &[JumpRecord<M::LoopLanes>],
        at_summary: &AbstractComparison,
    ) -> Option<AbstractComparison> {
        let continuing = |condition: &AbstractComparison, taken: bool| {
            if taken {
                condition.clone()
            } else {
                condition.not()
            }
        };
        let difference = |condition: &AbstractComparison| {
            Some(generate_expression(
                "-",
                without_registers(peel_unsigned(&condition.left))?,
                without_registers(peel_unsigned(&condition.right))?,
            ))
        };
        let held_now = continuing(current, continues);
        let excludes_equality = |op: &str| matches!(op, "!=" | "<" | ">");
        if !excludes_equality(&held_now.op) || !excludes_equality(&at_summary.op) {
            return None;
        }
        let exits: Vec<usize> = self
            .loop_exits(previous.pc, continues, cycle)
            .iter()
            .map(|record| record.point.pc)
            .collect();
        let gap = |from: &AbstractExpression, to: &AbstractExpression| {
            self.pinned_value(&generate_expression("-", to.clone(), from.clone()))
        };
        let mut last = difference(&previous.condition)?;
        let mut step = None;
        for record in cycle {
            let pc = record.point.pc;
            if !exits.contains(&pc)
                || cycle.iter().filter(|other| other.point.pc == pc).count() != 1
                || !excludes_equality(&continuing(&record.point.condition, record.taken).op)
            {
                continue;
            }
            let Some(next) = difference(&record.point.condition) else {
                continue;
            };
            match (gap(&last, &next), step) {
                (Some(by), None) if by != 0 => step = Some(by),
                (Some(by), Some(known)) if by == known => (),
                _ => continue,
            }
            last = next;
        }
        let now = difference(current)?;
        let step = match (gap(&last, &now), step) {
            (Some(by), None) if by != 0 => by,
            (Some(by), Some(known)) if by == known => known,
            _ => return None,
        };
        let toward = if step < 0 { ">" } else { "<" };
        let required = [
            AbstractComparison::new(
                "==",
                generate_expression("%", now.clone(), AbstractExpression::Immediate(step.abs())),
                AbstractExpression::Immediate(0),
            ),
            AbstractComparison::new(toward, now, AbstractExpression::Immediate(0)),
        ];
        let held_now = comparison_to_ast(held_now)?;
        let proved = required.into_iter().all(|requirement| {
            comparison_to_ast(requirement).is_some_and(|requirement| {
                self.computer
                    .solver()
                    .check_timed(&[held_now.clone(), requirement.not()])
                    == SatResult::Unsat
            })
        });
        proved.then(|| {
            AbstractComparison::new(
                toward,
                generate_expression(
                    "-",
                    peel_unsigned(&at_summary.left).clone(),
                    peel_unsigned(&at_summary.right).clone(),
                ),
                AbstractExpression::Immediate(0),
            )
        })
    }

    fn proves_quietly_within(&self, fact: AbstractComparison, limit: u32) -> bool {
        let mut assumptions = self.select_definitions_in(&fact);
        let Some(negated) = comparison_to_ast(fact.not()) else {
            return false;
        };
        assumptions.push(negated);
        let mut bounded = Params::new();
        bounded.set_u32("rlimit", limit);
        self.computer.solver().set_params(&bounded);
        let result = self.computer.solver().check_assumptions(&assumptions);
        let mut unbounded = Params::new();
        unbounded.set_u32("rlimit", 0);
        self.computer.solver().set_params(&unbounded);
        result == SatResult::Unsat
    }

    fn proves_with_selects(&self, fact: AbstractComparison) -> bool {
        let mut assumptions = self.select_definitions_in(&fact);
        let Some(negated) = comparison_to_ast(fact.clone().not()) else {
            return false;
        };
        assumptions.push(negated);
        let mut bounded = Params::new();
        bounded.set_u32("rlimit", CONFINEMENT_RESOURCE_LIMIT);
        self.computer.solver().set_params(&bounded);
        let result = self.computer.solver().check_assumptions(&assumptions);
        let mut unbounded = Params::new();
        unbounded.set_u32("rlimit", 0);
        self.computer.solver().set_params(&unbounded);
        if result != SatResult::Unsat {
            log::info!("confinement premise {fact} is {result:?}");
            if result == SatResult::Sat {
                for assumption in &assumptions {
                    log::info!("  under {assumption}");
                }
                if let Some(model) = self.computer.solver().get_model() {
                    log::info!("  model {model}");
                }
            }
        }
        result == SatResult::Unsat
    }

    pub(super) fn proves(&self, fact: AbstractComparison) -> bool {
        comparison_to_ast(fact)
            .is_some_and(|c| self.computer.solver().check_timed(&[c.not()]) == SatResult::Unsat)
    }

    fn simplified_step(&self, step: AbstractExpression) -> AbstractExpression {
        if matches!(
            step,
            AbstractExpression::Immediate(_) | AbstractExpression::Abstract(_)
        ) {
            return step;
        }
        let lone_symbols: BTreeSet<String> = step
            .get_abstracts()
            .into_iter()
            .filter(|name| !LoopSymbol::names_any(name))
            .collect();
        let mut candidates: Vec<AbstractExpression> = lone_symbols
            .into_iter()
            .map(AbstractExpression::Abstract)
            .collect();
        let exact = exact_arithmetic_candidate(&step);
        candidates.extend(exact.clone());
        candidates.dedup();
        let simpler = candidates
            .into_iter()
            .find(|candidate| {
                *candidate != step
                    && self.proves_within_budget(AbstractComparison::new(
                        "==",
                        step.clone(),
                        candidate.clone(),
                    ))
            })
            .or_else(|| {
                let exact = exact?;
                let offset =
                    self.pinned_value(&generate_expression("-", step.clone(), exact.clone()))?;
                let pinned_offset = Affine {
                    constant: offset,
                    terms: Vec::new(),
                };
                let corrected = Affine::of(&exact)?.combine(&pinned_offset, 1)?;
                Some(corrected.to_expression())
            });
        let candidate = simpler.unwrap_or_else(|| step.clone());
        let candidate = self.with_pinned_atoms(candidate);
        if candidate != step {
            log::info!("step {step} is exactly {candidate}");
        }
        candidate
    }

    fn with_pinned_atoms(&self, e: AbstractExpression) -> AbstractExpression {
        let Some(affine) = Affine::of(&e) else {
            return e;
        };
        if affine.terms.len() < 2 {
            return e;
        }
        let mut pinned_any = false;
        let mut constant = affine.constant;
        let mut kept = Vec::new();
        for (atom, coefficient) in affine.terms {
            let fixed = (!atom
                .get_abstracts()
                .iter()
                .any(|s| LoopSymbol::names_any(s)))
            .then(|| self.pinned_value(&atom))
            .flatten()
            .and_then(|value| value.checked_mul(coefficient))
            .and_then(|scaled| constant.checked_add(scaled));
            match fixed {
                Some(total) => {
                    constant = total;
                    pinned_any = true;
                }
                None => kept.push((atom, coefficient)),
            }
        }
        if !pinned_any {
            return e;
        }
        Affine {
            constant,
            terms: kept,
        }
        .to_expression()
    }

    fn counter_stride_products(&self, summary: &Summary) -> Vec<ast::Bool> {
        let AbstractExpression::Abstract(counter) = summary.counter.expression() else {
            return Vec::new();
        };
        let mut strides: Vec<AbstractExpression> = Vec::new();
        for invariant in &summary.invariants {
            if let LoopInvariant::Linear(step) = invariant
                && !matches!(step, AbstractExpression::Immediate(_))
                && !step
                    .get_abstracts()
                    .iter()
                    .any(|s| LoopSymbol::names_any(s))
                && !strides.contains(step)
            {
                strides.push(step.clone());
            }
        }
        if strides.is_empty() {
            return Vec::new();
        }
        let zero = AbstractExpression::Immediate(0);
        let mut lemmas = Vec::new();
        for fact in &summary.facts {
            let slack = match fact.op.as_str() {
                ">" | ">=" => generate_expression("-", *fact.left.clone(), *fact.right.clone()),
                "<" | "<=" => generate_expression("-", *fact.right.clone(), *fact.left.clone()),
                _ => continue,
            };
            let Some(unwrapped) = exact_arithmetic_candidate(&slack) else {
                continue;
            };
            if !unwrapped.get_abstracts().contains(&counter)
                || !self.proves_within_budget(AbstractComparison::new(
                    "==",
                    slack.clone(),
                    unwrapped.clone(),
                ))
            {
                continue;
            }
            let Some(slack_holds) = comparison_to_ast(AbstractComparison::new(
                ">=",
                unwrapped.clone(),
                zero.clone(),
            )) else {
                continue;
            };
            for stride in &strides {
                let product = generate_expression("*", unwrapped.clone(), stride.clone());
                let (Some(stride_holds), Some(product_holds)) = (
                    comparison_to_ast(AbstractComparison::new(">=", stride.clone(), zero.clone())),
                    comparison_to_ast(AbstractComparison::new(">=", product, zero.clone())),
                ) else {
                    continue;
                };
                log::info!("{} slack {unwrapped} scales by stride {stride}", summary.id);
                lemmas.push(ast::Bool::and(&[&slack_holds, &stride_holds]).implies(&product_holds));
            }
        }
        lemmas
    }

    fn simplify_anchors(&self, invariants: &[LoopInvariant], current: &mut MachineState) {
        for (i, invariant) in invariants.iter().enumerate() {
            if !matches!(invariant, LoopInvariant::Linear(_)) {
                continue;
            }
            let value = value_of(&current.0[i]);
            let exact = mentions_a_quotient(&value)
                .then(|| exact_arithmetic_candidate(&value))
                .flatten()
                .filter(|candidate| {
                    *candidate != value
                        && self.proves_within_budget(AbstractComparison::new(
                            "==",
                            value.clone(),
                            candidate.clone(),
                        ))
                });
            let simpler = exact.unwrap_or_else(|| value.clone());
            let Some(affine) = Affine::of(&simpler) else {
                continue;
            };
            let affine = self.with_parameter_residual_pinned(affine);
            let candidate = affine.to_expression();
            if candidate == value {
                continue;
            }
            let mut anchored = affine.to_register();
            if anchored.base.is_some() {
                anchored.kind = current.0[i].kind.clone();
            }
            log::info!("x{i} anchored at {candidate}, exactly {value}");
            current.0[i] = anchored;
        }
    }

    fn with_parameter_residual_pinned(&self, affine: Affine) -> Affine {
        let stays_symbolic = |atom: &AbstractExpression| {
            atom.get_abstracts()
                .iter()
                .any(|s| LoopSymbol::names_any(s))
                || self.computer.carries_region(&RegisterValue::new(
                    RegisterKind::RegisterBase,
                    Some(atom.clone()),
                    0,
                ))
        };
        let (kept, residual): (Vec<_>, Vec<_>) = affine
            .terms
            .iter()
            .cloned()
            .partition(|(atom, _)| stays_symbolic(atom));
        if residual.is_empty() {
            return affine;
        }
        let residual_expression = Affine {
            constant: 0,
            terms: residual,
        }
        .to_expression();
        match self.pinned_value(&residual_expression) {
            Some(pinned) => match affine.constant.checked_add(pinned) {
                Some(constant) => Affine {
                    constant,
                    terms: kept,
                },
                None => affine,
            },
            None => affine,
        }
    }

    fn proves_within_budget(&self, fact: AbstractComparison) -> bool {
        comparison_to_ast(fact).is_some_and(|c| {
            refuted_within(
                self.computer.solver(),
                &c.not(),
                OBLIGATION_INCREMENTAL_RESOURCE_LIMIT,
                OBLIGATION_RESOURCE_LIMIT,
            )
        })
    }

    fn repeat_round(
        &mut self,
        pc: usize,
        exit: usize,
        prefix: &[(AbstractComparison, bool)],
        expression: &mut AbstractComparison,
    ) -> bool {
        let _resolving = profile::enter(Phase::LoopResolution);
        let current = self.computer.get_state();
        let Some(entry) = self
            .loops
            .rounds
            .get(&pc)
            .filter(|entry| entry.exit == exit)
            .cloned()
        else {
            self.loops.rounds.insert(
                pc,
                RoundEntry {
                    exit,
                    state: current,
                    generalization: None,
                },
            );
            return false;
        };
        if let Some(generalization) = &entry.generalization {
            if self.round_covers(&entry.state, &current, generalization) {
                log::info!(
                    "round at line {pc} through line {exit} is covered by its generalization"
                );
                self.path_ends = true;
                return true;
            }
            self.loops.rounds.insert(
                pc,
                RoundEntry {
                    exit,
                    state: current,
                    generalization: None,
                },
            );
            return false;
        }
        let entry = match self.generalize_round(&entry.state, &current, prefix, expression) {
            Some((state, generalization)) => {
                log::info!("round at line {pc} through line {exit} generalized");
                RoundEntry {
                    exit,
                    state,
                    generalization: Some(generalization),
                }
            }
            None => RoundEntry {
                exit,
                state: current,
                generalization: None,
            },
        };
        self.loops.rounds.insert(pc, entry);
        false
    }

    fn generalize_round(
        &mut self,
        previous: &MachineState,
        current: &MachineState,
        prefix: &[(AbstractComparison, bool)],
        expression: &mut AbstractComparison,
    ) -> Option<(MachineState, Generalization)> {
        let invariants = self.pin_steps(&drift_of_registers(&previous.0, &current.0));
        let (stack_pointer, _) = self.computer.stack_pointer_at_return();
        let stack_moved = invariants
            .iter()
            .zip(current.0.iter())
            .any(|(invariant, register)| {
                *register == stack_pointer && *invariant != LoopInvariant::Fixed
            });
        if stack_moved {
            log::info!("round declined: the stack pointer moved between visits");
            return None;
        }
        let pointer_steps: Vec<&AbstractExpression> = invariants
            .iter()
            .zip(current.0.iter())
            .filter_map(|(invariant, register)| match invariant {
                LoopInvariant::Linear(step) if register.base.is_some() => Some(step),
                _ => None,
            })
            .collect();
        let first_step = (*pointer_steps.first()?).clone();
        let common_divisor = pointer_steps
            .iter()
            .map(|step| match step {
                AbstractExpression::Immediate(v) if *v != 0 => Some(v.unsigned_abs()),
                _ => None,
            })
            .collect::<Option<Vec<u64>>>()
            .and_then(|magnitudes| magnitudes.into_iter().reduce(greatest_common_divisor));
        let mut unit = match (common_divisor, &first_step) {
            (Some(divisor), AbstractExpression::Immediate(first))
                if divisor != first.unsigned_abs() =>
            {
                AbstractExpression::Immediate(i64::try_from(divisor).ok()?)
            }
            _ => first_step,
        };
        let zero = AbstractExpression::Immediate(0);
        if !self.proves(AbstractComparison::new(">=", unit.clone(), zero.clone())) {
            if !self.proves(AbstractComparison::new("<=", unit.clone(), zero.clone())) {
                return None;
            }
            unit = negate_step(unit);
        }
        let counter = LoopCounter::for_loop(self.allocate_loop_id());
        let progress = counter.expression();
        let mut updates = Vec::new();
        let mut shifts = Vec::new();
        let mut steps = Vec::new();
        let mut free_registers = Vec::new();
        for (i, (invariant, register)) in invariants.iter().zip(current.0.iter()).enumerate() {
            if *invariant == LoopInvariant::Fixed {
                continue;
            }
            let sign = match (invariant, &register.base) {
                (LoopInvariant::Linear(step), Some(base)) if !is_narrowed(base) => {
                    let multiple = match (step, &unit) {
                        (AbstractExpression::Immediate(s), AbstractExpression::Immediate(u))
                            if *u != 0 && *s != 0 && s % u == 0 && s / u != 1 && s / u != -1 =>
                        {
                            Some(s / u)
                        }
                        _ => None,
                    };
                    [1, -1].into_iter().chain(multiple).find(|sign| {
                        self.proves(AbstractComparison::new(
                            "==",
                            step.clone(),
                            generate_expression(
                                "*",
                                AbstractExpression::Immediate(*sign),
                                unit.clone(),
                            ),
                        ))
                    })
                }
                _ => None,
            };
            match sign {
                Some(sign) => {
                    let shift = generate_expression(
                        "*",
                        AbstractExpression::Immediate(sign),
                        progress.clone(),
                    );
                    updates.push((
                        i,
                        RegisterValue {
                            kind: register.kind.clone(),
                            base: register
                                .base
                                .as_ref()
                                .map(|base| generate_expression("+", base.clone(), shift.clone())),
                            offset: register.offset,
                        },
                    ));
                    shifts.push((i, shift));
                    steps.push((i, sign));
                }
                None => {
                    updates.push((
                        i,
                        RegisterValue::new_empty(&counter.symbol(LoopRole::Widened(i)).to_string()),
                    ));
                    free_registers.push(i);
                }
            }
        }
        if steps.is_empty() {
            return None;
        }
        log::info!(
            "{} round unit {unit}: multiples {steps:?}, free {free_registers:?}",
            counter.name()
        );
        let rewritten = |c: &AbstractComparison| -> Option<AbstractComparison> {
            Some(AbstractComparison::new(
                &c.op,
                shifted_leaves(&c.left, &current.0, &shifts, &free_registers)?,
                shifted_leaves(&c.right, &current.0, &shifts, &free_registers)?,
            ))
        };
        let condition = rewritten(expression)?;
        let guards: Vec<AbstractComparison> = prefix
            .iter()
            .filter_map(|(guard, taken)| {
                let held = rewritten(guard)?;
                let held = if *taken { held } else { held.not() };
                comparison_to_ast(held.clone()).is_some().then_some(held)
            })
            .collect();
        let mut free_flags = Vec::new();
        let mut flag = |k: usize, value: &Option<FlagValue>| match value {
            Some(FlagValue::Abstract(c)) => match rewritten(c) {
                Some(rebuilt) => Some(FlagValue::Abstract(rebuilt)),
                None => {
                    free_flags.push(k);
                    widen_flag(&counter.symbol(LoopRole::Flag(k)).to_string(), &None, value)
                }
            },
            _ => value.clone(),
        };
        let flags = [
            flag(0, &current.1),
            flag(1, &current.2),
            flag(2, &current.3),
            flag(3, &current.4),
        ];
        let nonnegative: Vec<usize> = steps
            .iter()
            .map(|(i, _)| *i)
            .filter(|&i| self.proves(at_least_zero(&current.0[i])))
            .collect();
        let progresses = comparison_to_ast(AbstractComparison::new(">=", progress, zero))?;
        self.computer.solver().assert(progresses);
        for guard in guards
            .iter()
            .filter_map(|guard| comparison_to_ast(guard.clone()))
        {
            self.computer.solver().assert(guard);
        }
        for (i, register) in updates {
            self.computer.set_register_at(i, register);
        }
        for &i in &nonnegative {
            if let Some(stays) = comparison_to_ast(at_least_zero(&self.computer.register_at(i))) {
                self.computer.solver().assert(stays);
            }
        }
        self.computer.set_flags(flags);
        *expression = condition;
        Some((
            self.computer.get_state(),
            Generalization {
                progress: counter,
                steps,
                free_registers,
                free_flags,
                nonnegative,
                guards,
            },
        ))
    }

    pub(super) fn round_covers(
        &self,
        generalized: &MachineState,
        next: &MachineState,
        generalization: &Generalization,
    ) -> bool {
        let _resolving = profile::enter(Phase::LoopResolution);
        let Some(&(first, sign)) = generalization.steps.first() else {
            return false;
        };
        let moved =
            |i: usize| generate_expression("-", value_of(&next.0[i]), value_of(&generalized.0[i]));
        let shift = match sign {
            1 | -1 => generate_expression("*", AbstractExpression::Immediate(sign), moved(first)),
            multiple => generate_expression(
                "/",
                generate_expression(
                    "*",
                    AbstractExpression::Immediate(multiple.signum()),
                    moved(first),
                ),
                AbstractExpression::Immediate(multiple.abs()),
            ),
        };
        if !self.proves(AbstractComparison::new(
            ">=",
            shift.clone(),
            AbstractExpression::Immediate(0),
        )) {
            return false;
        }
        let registers = (0..generalized.0.len()).all(|i| {
            if generalization.free_registers.contains(&i) {
                return true;
            }
            match generalization.steps.iter().find(|(j, _)| *j == i) {
                Some((_, sign)) => self.proves(AbstractComparison::new(
                    "==",
                    moved(i),
                    generate_expression("*", AbstractExpression::Immediate(*sign), shift.clone()),
                )),
                None => {
                    generalized.0[i] == next.0[i]
                        || self.proves(AbstractComparison::new(
                            "==",
                            moved(i),
                            AbstractExpression::Immediate(0),
                        ))
                }
            }
        });
        let progress = &generalization.progress;
        let shifted_progress = generate_expression("+", progress.expression(), shift.clone());
        if !registers
            || !generalization
                .nonnegative
                .iter()
                .all(|&i| self.proves(at_least_zero(&next.0[i])))
            || !generalization.guards.iter().all(|guard| {
                self.implied(&comparison_with_counter_at(
                    guard,
                    progress.name(),
                    &shifted_progress,
                ))
            })
        {
            return false;
        }
        let shifts: Vec<(usize, AbstractExpression)> = generalization
            .steps
            .iter()
            .map(|(i, sign)| {
                (
                    *i,
                    generate_expression("*", AbstractExpression::Immediate(*sign), shift.clone()),
                )
            })
            .collect();
        let free = &generalization.free_registers;
        [
            (&generalized.1, &next.1),
            (&generalized.2, &next.2),
            (&generalized.3, &next.3),
            (&generalized.4, &next.4),
        ]
        .into_iter()
        .enumerate()
        .all(|(k, (was, now))| {
            generalization.free_flags.contains(&k)
                || was == now
                || match (was, now) {
                    (Some(FlagValue::Abstract(was)), Some(FlagValue::Abstract(now))) => {
                        shifted_leaves(&was.left, &generalized.0, &shifts, free)
                            .zip(shifted_leaves(&was.right, &generalized.0, &shifts, free))
                            .and_then(|(left, right)| {
                                comparison_to_ast(AbstractComparison::new(&was.op, left, right))
                            })
                            .zip(comparison_to_ast(now.clone()))
                            .is_some_and(|(was, now)| {
                                self.computer.solver().check_timed(&[was.eq(now).not()])
                                    == SatResult::Unsat
                            })
                    }
                    _ => false,
                }
        })
    }

    fn discharge_active_loop(
        &mut self,
        active: ActiveLoop,
        expression: AbstractComparison,
    ) -> Discharge {
        let _resolving = profile::enter(Phase::LoopResolution);
        let since = active.history_len.min(self.jump_history.len());
        let left_through = self.jump_history[since..].iter().position(|record| {
            active
                .exits
                .iter()
                .any(|(exit, go_on)| record.point.pc == *exit && record.taken != *go_on)
        });
        if let Some(index) = left_through {
            let exit_pc = self.jump_history[since + index].point.pc;
            let prefix: Vec<(AbstractComparison, bool)> = self.jump_history[since + index + 1..]
                .iter()
                .map(|record| (record.point.condition.clone(), record.taken))
                .collect();
            self.loops.active.pop();
            self.release_loop(&active);
            self.jump_history
                .retain(|record| record.point.pc != active.pc);
            log::info!(
                "{} at line {} left through line {exit_pc} and re-entered",
                active.id,
                active.pc
            );
            return Discharge::LeftThrough(exit_pc, prefix);
        }

        let mut active = active;
        let (mut summarized, mut entered) = (active.state.clone(), active.entry_state.clone());
        self.forget_dead_registers(
            active.pc,
            &expression,
            active.entry_decision,
            &mut [&mut summarized, &mut entered],
        );
        active.state = summarized;
        active.entry_state = entered;
        let current = self.computer.get_state();
        let (mut before, mut after) = (active.state.clone(), current.clone());
        self.while_staying(&expression, active.entry_decision, |engine| {
            let mut settlements = SelectSettlements::new();
            engine.resolve_selects(&mut before, &mut settlements);
            engine.resolve_selects(&mut after, &mut settlements);
        });
        let mut observed = self.pin_steps(&invariant_of_registers(&before.0, &after.0));
        let tested: Vec<AbstractComparison> = self.jump_history[since..]
            .iter()
            .map(|record| record.point.condition.clone())
            .collect();
        self.while_staying(&expression, active.entry_decision, |engine| {
            engine.pin_unknown_steps(&mut observed, &before.0, &after.0, &expression, &tested)
        });
        let mut observed = self.bound_values(active.pc, &observed, &before.0, &after.0);
        for (i, recorded) in active.invariants.iter().enumerate() {
            if let LoopInvariant::OneOf(group) = recorded
                && observed[i] != *recorded
                && group.iter().any(|&j| before.0.get(j) == after.0.get(i))
            {
                observed[i] = recorded.clone();
            }
            if let LoopInvariant::Linear(step) = recorded
                && !recorded.subsumes(&observed[i])
                && self.proves_step(&before.0[i], &after.0[i], step)
            {
                observed[i] = recorded.clone();
            }
            let recorded_range = match recorded {
                LoopInvariant::AtMost(high) => Some((Some(0), Some(*high))),
                LoopInvariant::Ranged(low, high) => Some((Some(*low), Some(*high))),
                LoopInvariant::NonDecreasing => Some((Some(0), None)),
                LoopInvariant::NonIncreasing => Some((None, Some(0))),
                _ => None,
            };
            if let Some(range) = recorded_range
                && !recorded.subsumes(&observed[i])
                && self.proves_step_between(&before.0[i], &after.0[i], range)
            {
                observed[i] = recorded.clone();
            }
            if let LoopInvariant::Derived(j, template) = recorded
                && observed[i] != *recorded
                && self.follows(template, &before.0[*j], &before.0[i])
                && self.follows(template, &after.0[*j], &after.0[i])
            {
                observed[i] = recorded.clone();
            }
            if let LoopInvariant::Tracks(j, k) = recorded
                && observed[i] != *recorded
                && before.0[*j].kind != RegisterKind::Number
                && after.0[*j].kind != RegisterKind::Number
            {
                let leader_moved =
                    generate_expression("-", value_of(&after.0[*j]), value_of(&before.0[*j]));
                let step =
                    generate_expression("*", AbstractExpression::Immediate(*k), leader_moved);
                if self.proves_step(&before.0[i], &after.0[i], &step) {
                    observed[i] = recorded.clone();
                }
            }
        }
        let leaving = matches!(
            self.decide_from_solver(&expression),
            Decision::Take(taken) if taken != active.entry_decision
        );
        if leaving {
            log::info!(
                "{} at line {} leaves on this arrival; the last iteration needs no repeat",
                active.id,
                active.pc
            );
        }
        let broken = if leaving {
            Vec::new()
        } else {
            self.broken_obligations(&active, &expression, &observed, &current)
        };
        if !broken.is_empty() {
            self.refute_active_loop(&active, &expression, &observed, &broken);
            log::info!(
                "{} at line {} not closed, exit condition {expression}",
                active.id,
                active.pc
            );
            for (i, (recorded, seen)) in active.invariants.iter().zip(observed.iter()).enumerate() {
                if *seen == LoopInvariant::Fixed && recorded.subsumes(seen) {
                    continue;
                }
                log::info!(
                    "{} x{i}: recorded={recorded:?} observed={seen:?} subsumed={} entry={:?} exit={:?}",
                    active.id,
                    recorded.subsumes(seen),
                    active.state.0[i],
                    current.0[i]
                );
            }
            return Discharge::Refuted;
        }
        if !leaving {
            self.loop_history
                .borrow_mut()
                .validated_instances
                .insert(active.instance);
        }

        let held_on_leaving: Vec<AbstractComparison> = active
            .bounds
            .iter()
            .map(|bound| bound.at(&current.0))
            .filter(|bound| self.implied(bound))
            .collect();
        let above = self.scopes_above(active.scope_id);
        self.pop_scope(active.scope_id);
        self.loops.active.pop();
        let left_by = if active.entry_decision {
            expression.not()
        } else {
            expression.clone()
        };
        let counter = LoopCounter::for_loop(active.id).expression();
        let distance_to_exit = |left: &AbstractExpression, right: &AbstractExpression| {
            Affine::of(left)?
                .combine(&Affine::of(right)?, -1)
                .filter(|distance| distance.coefficient(&counter) != 0)
        };
        let distance = distance_to_exit(&left_by.left, &left_by.right).or_else(|| {
            distance_to_exit(
                &without_word_wraps(&left_by.left),
                &without_word_wraps(&left_by.right),
            )
        });
        if let Some(distance) = distance {
            let values: Vec<AbstractExpression> =
                exit_window(&left_by.op, distance.coefficient(&counter))
                    .into_iter()
                    .filter_map(|reached| {
                        counter_value_at_exit(
                            &counter,
                            &Affine {
                                constant: distance.constant - reached,
                                terms: distance.terms.clone(),
                            },
                        )
                    })
                    .collect();
            if !values.is_empty() {
                log::info!("{} leaves with its counter at one of {values:?}", active.id);
                self.loops.closed_counters.push((counter.clone(), values));
            }
        }
        let mut kept: Vec<ast::Bool> = summary_fact_to_ast(&left_by).into_iter().collect();
        kept.extend(
            active
                .facts
                .iter()
                .chain(&active.exit_facts)
                .filter_map(summary_fact_to_ast),
        );
        kept.extend(active.nested_facts.iter().cloned());
        for bound in held_on_leaving {
            kept.extend(self.select_definitions_in(&bound));
            kept.extend(comparison_to_ast(bound));
        }
        self.keep_facts(kept);
        self.jump_history.truncate(active.history_len);
        for record in &mut self.jump_history {
            record.resolved |= record.point.pc == active.pc;
        }
        self.loops.attempts.remove(&active.pc);
        self.rebuild_scopes(above);
        if self.computer.solver().check_timed(&[]) == SatResult::Unsat {
            log::info!(
                "{} at line {} has no feasible exit on this path",
                active.id,
                active.pc
            );
            self.path_ends = true;
        } else {
            self.settle_closed_counter(&counter);
        }
        Discharge::Closed(!active.entry_decision)
    }

    fn settle_closed_counter(&mut self, counter: &AbstractExpression) {
        let AbstractExpression::Abstract(name) = counter else {
            return;
        };
        let Some((_, values)) = self
            .loops
            .closed_counters
            .last()
            .filter(|(closed, values)| closed == counter && values.len() > 1)
        else {
            return;
        };
        let Some(value) = values
            .iter()
            .find(|value| {
                self.proves(AbstractComparison::new(
                    "==",
                    counter.clone(),
                    (*value).clone(),
                ))
            })
            .cloned()
        else {
            return;
        };
        log::info!("{name} is {value} on this path");
        let name = name.clone();
        self.substitute_symbol(&name, &value);
    }

    fn stays_confined(&self, confinement: &Confinement, current: &MachineState) -> bool {
        let now = value_of(&current.0[confinement.register]);
        if confinement.region.is_empty() {
            return self.proves_with_selects(AbstractComparison::new(
                ">=",
                now,
                AbstractExpression::Immediate(0),
            ));
        }
        let start = AbstractExpression::Abstract(confinement.region.clone());
        let floor = confinement
            .floor
            .map_or(start.clone(), |j| value_of(&current.0[j]));
        let on_multiple = confinement.multiple == 1
            || self.proves_with_selects(AbstractComparison::new(
                "==",
                generate_expression(
                    "%",
                    generate_expression("-", now.clone(), floor.clone()),
                    AbstractExpression::Immediate(confinement.multiple),
                ),
                AbstractExpression::Immediate(0),
            ));
        on_multiple
            && self.proves_with_selects(AbstractComparison::new(">=", now.clone(), floor))
            && self.proves_with_selects(AbstractComparison::new(
                "<=",
                now,
                generate_expression("+", start, confinement.length.clone()),
            ))
    }

    fn broken_obligations(
        &self,
        active: &ActiveLoop,
        expression: &AbstractComparison,
        observed: &[LoopInvariant],
        current: &MachineState,
    ) -> Vec<Obligation> {
        let mut broken = Vec::new();
        let unrepeated = self.while_staying(expression, active.entry_decision, |engine| {
            let ghost = active
                .ghost_checks
                .iter()
                .find(|(path, expected)| match condition_side(expression, path) {
                    Some(AbstractExpression::Register(now)) => !engine.proves_within_budget(
                        AbstractComparison::new("==", value_of(now), expected.clone()),
                    ),
                    _ => true,
                })
                .map(|(path, _)| Obligation::Ghost(path.clone()));
            let operand = || {
                active
                    .operand_checks
                    .iter()
                    .find(|(path, i)| match condition_side(expression, path) {
                        Some(AbstractExpression::Register(now)) => {
                            **now != current.0[*i]
                                && !engine.proves_within_budget(AbstractComparison::new(
                                    "==",
                                    value_of(now),
                                    value_of(&current.0[*i]),
                                ))
                        }
                        _ => true,
                    })
                    .map(|(_, i)| Obligation::Operand(*i))
            };
            ghost.or_else(operand)
        });
        if let Some(unrepeated) = unrepeated {
            log::info!("{} guard operand did not repeat its step", active.id);
            broken.push(unrepeated);
        }
        let checked_from = active
            .journal_after_summary
            .min(self.computer.write_journal().len());
        let mut rewritten = cells_written(&self.computer.write_journal()[checked_from..]);
        for (cell, _) in &active.cells {
            if rewritten.iter().all(|(known, _)| known != cell) {
                rewritten.push((cell.clone(), self.computer.cell_content(cell)));
            }
        }
        let clobbered_cells = self.stack_cells_a_blind_write_may_reach(active);
        let drifting_cells: Vec<MemoryCell> = rewritten
            .into_iter()
            .filter(|(cell, before)| {
                let now = self.computer.cell_content(cell);
                let seen = self.pin_steps(&self.demote_varying_steps(
                    vec![invariant_of_register(before, &now)],
                    std::slice::from_ref(before),
                ));
                let recorded = active
                    .cells
                    .iter()
                    .find(|(known, _)| known == cell)
                    .map_or(LoopInvariant::Fixed, |(_, invariant)| invariant.clone());
                let advanced_as_recorded = recorded == LoopInvariant::NonDecreasing
                    && self.advances_a_pointer(before, &now);
                !(recorded.subsumes(&seen[0]) || advanced_as_recorded)
            })
            .map(|(cell, _)| cell)
            .chain(clobbered_cells)
            .collect();
        if !drifting_cells.is_empty() {
            log::info!(
                "{} memory cells did not repeat their step: {drifting_cells:?}",
                active.id
            );
            broken.extend(drifting_cells.into_iter().map(Obligation::Cell));
        }
        let untied: Vec<MemoryCell> = active
            .cell_ties
            .iter()
            .filter(|(cell, i)| {
                let held = self.computer.cell_content(cell);
                let register = &current.0[*i];
                held != *register
                    && !(held.kind != RegisterKind::Number
                        && register.kind != RegisterKind::Number
                        && self.proves(AbstractComparison::new(
                            "==",
                            value_of(&held),
                            value_of(register),
                        )))
            })
            .map(|(cell, _)| cell.clone())
            .collect();
        if !untied.is_empty() {
            log::info!(
                "{} cells no longer hold their registers: {untied:?}",
                active.id
            );
            broken.extend(untied.into_iter().map(Obligation::Tie));
        }
        let uncarried = self.while_staying(expression, active.entry_decision, |engine| {
            engine.branches_not_carried(active)
        });
        broken.extend(uncarried.into_iter().map(Obligation::Carried));
        broken.extend(
            self.unrepeated_settled_step(active)
                .map(Obligation::Settled),
        );
        broken.extend(
            active
                .chosen
                .iter()
                .find(|chosen| !self.chosen_holds(chosen, &current.0))
                .map(|chosen| Obligation::Chosen(chosen.register)),
        );
        if !self.computer.slots_kept(&active.slots) {
            log::info!("{} a saved slot did not survive the body", active.id);
            broken.push(Obligation::Slots);
        }
        let unconfined = active
            .state
            .0
            .iter()
            .zip(&current.0)
            .position(|(summarized, now)| {
                match summarized
                    .base
                    .as_ref()
                    .filter(|_| summarized.kind == RegisterKind::RegisterBase)
                    .and_then(confined_load_width)
                {
                    Some(width) => {
                        now.kind != RegisterKind::RegisterBase
                            || !self
                                .computer
                                .fits_unsigned(&value_of(now), 8 * width as u32)
                    }
                    None => false,
                }
            });
        if let Some(register) = unconfined {
            log::info!("{} a widened load left its width", active.id);
            broken.push(Obligation::Confined(register));
        }
        let escaped: Vec<usize> = active
            .confined
            .iter()
            .filter(|confinement| !self.stays_confined(confinement, current))
            .map(|confinement| confinement.register)
            .collect();
        if !escaped.is_empty() {
            log::info!("{} a confined pointer left its region", active.id);
        }
        broken.extend(escaped.into_iter().map(Obligation::Escaped));
        let unbounded: Vec<&Bound> =
            self.while_staying(expression, active.entry_decision, |engine| {
                active
                    .bounds
                    .iter()
                    .filter(|bound| !engine.implied(&bound.at(&current.0)))
                    .collect()
            });
        if !unbounded.is_empty() {
            let keys: Vec<String> = unbounded.iter().map(|bound| bound.key()).collect();
            log::info!("{} bounds {keys:?} not re-established", active.id);
        }
        broken.extend(unbounded.into_iter().cloned().map(Obligation::Bound));
        broken.extend(
            active
                .invariants
                .iter()
                .zip(observed)
                .enumerate()
                .filter(|(_, (recorded, seen))| !recorded.subsumes(seen))
                .map(|(i, _)| Obligation::Step(i)),
        );
        broken
    }

    fn refute_active_loop(
        &mut self,
        active: &ActiveLoop,
        expression: &AbstractComparison,
        observed: &[LoopInvariant],
        broken: &[Obligation],
    ) {
        let listed: Vec<String> = broken.iter().map(Obligation::to_string).collect();
        log::info!("{} broke {}", active.id, listed.join(", "));
        let mut drifting_cells = Vec::new();
        let mut untied_cells = BTreeSet::new();
        let mut uncarried = BTreeSet::new();
        let mut escaped = BTreeSet::new();
        let mut unbounded = Vec::new();
        let mut moved = Vec::new();
        let (mut ghosts_repeat, mut slots_hold, mut steps_hold) = (true, true, true);
        let mut chosen_hold = true;
        for obligation in broken {
            match obligation {
                Obligation::Step(i) => moved.push(*i),
                Obligation::Cell(cell) => drifting_cells.push(cell.clone()),
                Obligation::Tie(cell) => {
                    drifting_cells.push(cell.clone());
                    untied_cells.insert(cell.clone());
                }
                Obligation::Slots => slots_hold = false,
                Obligation::Confined(_) => {}
                Obligation::Ghost(_) | Obligation::Operand(_) => ghosts_repeat = false,
                Obligation::Bound(bound) => unbounded.push(bound.key()),
                Obligation::Carried(branch) => {
                    uncarried.insert(*branch);
                }
                Obligation::Settled(_) => steps_hold = false,
                Obligation::Chosen(_) => chosen_hold = false,
                Obligation::Escaped(i) => {
                    if !matches!(active.invariants.get(*i), Some(LoopInvariant::Unknown)) {
                        escaped.insert(*i);
                    }
                }
            }
        }
        let newly_unconfinable = self.update_record(active.pc, |record| {
            let before = record.unconfinable.len();
            record.unconfinable.extend(escaped.iter().copied());
            record.unconfinable.len() > before
        });
        if newly_unconfinable {
            self.loops.attempts.remove(&active.pc);
        }
        let cells_hold = drifting_cells.is_empty();
        let (wandering, drifting): (Vec<MemoryCell>, Vec<MemoryCell>) =
            drifting_cells.into_iter().partition(|cell| {
                active
                    .cells
                    .contains(&(cell.clone(), LoopInvariant::NonDecreasing))
            });
        let newly_uncarried = self.update_record(active.pc, |record| {
            record.unstable_cells.extend(drifting);
            record.untied_cells.extend(untied_cells.iter().cloned());
            record.wandering_cells.extend(wandering);
            record.select_refuted |= !steps_hold;
            record.chosen_refuted |= !chosen_hold;
            record.unstable_slots |= !slots_hold;
            let before = record.uncarried.len();
            record.uncarried.extend(uncarried.iter().copied());
            record.uncarried.len() > before
        });
        if newly_uncarried {
            self.loops.attempts.remove(&active.pc);
        }
        let read_by_guard = registers_in(expression);
        let current = self.computer.get_state();
        let only_data_moved = ghosts_repeat
            && uncarried.is_empty()
            && moved.iter().all(|&i| {
                [&active.entry_state.0[i], &active.state.0[i], &current.0[i]]
                    .into_iter()
                    .all(|r| !self.computer.carries_region(r) && !read_by_guard.contains(r))
            });
        if !only_data_moved {
            self.update_record(active.pc, |record| {
                if record.counted.insert((active.id, active.round)) {
                    record.failures += 1;
                }
            });
        }
        self.widen_for_retry(active, observed, unbounded);
        if !cells_hold || !slots_hold {
            let retried = self.update_record(active.pc, |record| {
                let retried = record.cell_retries < LOOP_BUDGET.cell_retries;
                record.cell_retries += usize::from(retried);
                retried
            });
            if retried {
                self.loops.attempts.remove(&active.pc);
            }
        }
        self.ledger.borrow_mut().failures.push(FailedDischarge {
            instance: active.instance,
            relied_on: self.loops.relied_on.clone(),
            retry: self.loops.attempts.get(&active.pc).cloned(),
        });
    }
}

fn without_word_wraps(e: &AbstractExpression) -> AbstractExpression {
    match e {
        AbstractExpression::Register(register) if register.base.is_some() => {
            without_word_wraps(&value_of(register))
        }
        AbstractExpression::Expression(_, inner, _) if is_narrowed(e) => without_word_wraps(inner),
        AbstractExpression::Expression(op, inner, width)
            if (op == "sext" || op == "zext") && **width == AbstractExpression::Immediate(32) =>
        {
            without_word_wraps(inner)
        }
        AbstractExpression::Expression(op, left, right) => {
            generate_expression(op, without_word_wraps(left), without_word_wraps(right))
        }
        other => other.clone(),
    }
}

fn chosen_condition(
    template: &AbstractComparison,
    leader: &AbstractExpression,
) -> AbstractComparison {
    AbstractComparison::new(
        &template.op,
        substitute(&template.left, DERIVED_LEADER, leader),
        substitute(&template.right, DERIVED_LEADER, leader),
    )
}

fn relative_to_leader(
    e: &AbstractExpression,
    base: &AbstractExpression,
    at: i64,
    current: &[RegisterValue],
    invariants: &[LoopInvariant],
) -> Option<AbstractExpression> {
    match e {
        AbstractExpression::Register(r) if r.base.as_ref() == Some(base) => {
            Some(generate_expression(
                "+",
                AbstractExpression::Abstract(DERIVED_LEADER.to_string()),
                AbstractExpression::Immediate(r.offset - at),
            ))
        }
        AbstractExpression::Register(r) => {
            let held: Vec<usize> = (0..current.len().min(invariants.len()))
                .filter(|&k| current[k] == **r)
                .collect();
            (r.base.is_none()
                || (!held.is_empty()
                    && held.iter().all(|&k| invariants[k] == LoopInvariant::Fixed)))
            .then(|| e.clone())
        }
        AbstractExpression::Expression(op, left, right) => Some(generate_expression(
            op,
            relative_to_leader(left, base, at, current, invariants)?,
            relative_to_leader(right, base, at, current, invariants)?,
        )),
        AbstractExpression::Immediate(_) => Some(e.clone()),
        _ => None,
    }
}

fn is_fresh_symbol(symbol: &str) -> bool {
    let Some((stem, number)) = symbol.rsplit_once('_') else {
        return false;
    };
    stem != "select"
        && !stem.is_empty()
        && !number.is_empty()
        && number.chars().all(|c| c.is_ascii_digit())
        && stem.chars().all(|c| c.is_ascii_lowercase() || c == '_')
}

const MAX_UNROLLED_LOW_BITS_MASK: i64 = 15;

fn masked_operands(e: &AbstractExpression, found: &mut Vec<AbstractExpression>) {
    match e {
        AbstractExpression::Expression(op, left, right) => {
            if op == "&" {
                for (value, mask) in [(left, right), (right, left)] {
                    if let AbstractExpression::Immediate(m) = **mask
                        && (1..=MAX_UNROLLED_LOW_BITS_MASK).contains(&m)
                        && (m + 1) & m == 0
                    {
                        found.push((**value).clone());
                    }
                }
            }
            masked_operands(left, found);
            masked_operands(right, found);
        }
        AbstractExpression::Register(register) => {
            if let Some(base) = &register.base {
                masked_operands(base, found);
            }
        }
        _ => (),
    }
}

fn unit_walker_under_a_low_bits_test<'a>(
    observed: &[LoopInvariant],
    current: &[RegisterValue],
    conditions: impl Iterator<Item = &'a AbstractComparison>,
) -> Option<usize> {
    let mut masked = Vec::new();
    for condition in conditions {
        if !matches!(condition.op.as_str(), "==" | "!=") {
            continue;
        }
        masked_operands(&condition.left, &mut masked);
        masked_operands(&condition.right, &mut masked);
    }
    observed.iter().enumerate().find_map(|(i, invariant)| {
        let LoopInvariant::Linear(AbstractExpression::Immediate(-1 | 1)) = invariant else {
            return None;
        };
        let now = value_of(current.get(i)?);
        masked
            .iter()
            .any(|operand| {
                linear_form(&generate_expression("-", operand.clone(), now.clone()))
                    .is_some_and(|difference| difference.terms.is_empty())
            })
            .then_some(i)
    })
}

fn signed_at_width(value: i64, width: i64) -> i64 {
    if width >= 8 {
        return value;
    }
    let bits = width * 8;
    let low = value.rem_euclid(1i64 << bits);
    if low >= 1i64 << (bits - 1) {
        low - (1i64 << bits)
    } else {
        low
    }
}
