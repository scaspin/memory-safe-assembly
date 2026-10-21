use crate::computer::MAX_EXPRESSION_NODES;

use super::*;

enum Discharge {
    Closed(bool),
    LeftThrough(usize, Vec<(AbstractComparison, bool)>),
    Refuted,
}

#[derive(Default)]
pub(super) struct SummaryLedger {
    next_instance: usize,
    failures: Vec<FailedDischarge>,
    refuted: BTreeSet<usize>,
    refutations_at: BTreeMap<usize, usize>,
}

struct FailedDischarge {
    instance: usize,
    relied_on: Vec<usize>,
    retry: Option<LoopAttempt>,
}

impl SummaryLedger {
    fn refute(&mut self, instance: usize) -> Option<Option<LoopAttempt>> {
        let failure = self.failures.iter().find(|failure| {
            failure.instance == instance
                && failure
                    .relied_on
                    .iter()
                    .all(|other| !self.refuted.contains(other))
        })?;
        let retry = failure.retry.clone();
        self.refuted.insert(instance);
        Some(retry)
    }
}

impl<M: Machine> Engine<M> {
    pub(super) fn validate_summary(
        &mut self,
        instance: usize,
        fallback: Engine<M>,
        next: usize,
        (pc, condition, jump_dest): (usize, AbstractComparison, usize),
        depth: usize,
    ) -> std::io::Result<BranchOutcome> {
        let explored = self.run(next, depth);
        let Some(retry) = self.ledger.borrow_mut().refute(instance) else {
            let mut fallback = fallback;
            let continues = next == jump_dest;
            if !matches!(fallback.decide_from_solver(&condition), Decision::Explore) {
                return explored.map(|()| BranchOutcome::BothExplored);
            }
            fallback.loop_attempts.remove(&pc);
            let here = fallback.branch_point(pc, &condition);
            let leaves = if continues { pc + 1 } else { jump_dest };
            let left = fallback.explore_arm(here, !continues, leaves, depth);
            return join_arms(explored, left);
        };
        log::info!("summary {instance} at line {pc} failed its inductive check, exploring again");
        *self = fallback;
        let refutations = {
            let mut ledger = self.ledger.borrow_mut();
            let refutations = ledger.refutations_at.entry(pc).or_insert(0);
            *refutations += 1;
            *refutations
        };
        if refutations >= MAX_REFUTATIONS {
            self.failed_summaries
                .borrow_mut()
                .insert(pc, MAX_SUMMARY_TRIES);
        }
        match retry {
            Some(attempt) => self.loop_attempts.insert(pc, attempt),
            None => self.loop_attempts.remove(&pc),
        };
        let decision = self.decide(pc, depth, &condition);
        self.follow_branch(pc, condition, decision, jump_dest, depth)
    }

    pub(super) fn memory_free_loop(
        &mut self,
        header: usize,
        end: usize,
    ) -> Option<(Vec<M::Operand>, Vec<usize>)> {
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

        if let Some(active) = self.active_loops.last().cloned()
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
                    || self.unrolling_costs_too_much(pc, taken, expression) =>
            {
                self.try_summarize(pc, depth, expression).or(Some(taken))
            }
            Decision::Take(taken) => Some(taken),
            Decision::Explore => self.try_summarize(pc, depth, expression),
        }
    }

    fn repeats_unboundedly(&self, pc: usize, taken: bool, expression: &AbstractComparison) -> bool {
        if expression.get_abstracts().is_empty()
            || self.active_loops.iter().any(|open| open.pc == pc)
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
        let (op, tested, label) = instruction.zero_test()?;
        let Ok(ExecuteReturnType::Next | ExecuteReturnType::JumpLabel(_)) = result else {
            return None;
        };
        let label = label.to_string();
        if self.get_linenumber_of_label(label.clone(), pc)? > pc {
            return None;
        }
        let tested = self.computer.get_register(tested);
        if tested.base.is_some() || tested.kind == RegisterKind::Number {
            return None;
        }
        let condition = AbstractComparison::new(
            op,
            AbstractExpression::Immediate(0),
            AbstractExpression::Register(Box::new(tested.clone())),
        );
        if self.costly_latches.contains(&pc) {
            return Some((condition, label));
        }
        let now = (self.instructions_run, tested.offset);
        if let Some((run_before, value_before)) = self.concrete_latch_visits.insert(pc, now) {
            let closing = value_before - tested.offset;
            let per_iteration = (self.instructions_run - run_before) as i64;
            if closing != 0 && tested.offset.signum() == closing.signum() {
                let remaining = tested.offset / closing;
                if remaining.saturating_mul(per_iteration) > UNROLLING_INSTRUCTION_BUDGET {
                    log::info!(
                        "line {pc} would unroll {remaining} more iterations of {per_iteration} instructions, tracking it as a loop guard"
                    );
                    self.costly_latches.insert(pc);
                    return Some((condition, label));
                }
            }
        }
        None
    }

    fn unrolling_costs_too_much(
        &self,
        pc: usize,
        taken: bool,
        expression: &AbstractComparison,
    ) -> bool {
        if self.active_loops.iter().any(|open| open.pc == pc) {
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
        let costs_too_much = remaining.saturating_mul(per_iteration) > UNROLLING_INSTRUCTION_BUDGET;
        if costs_too_much {
            log::info!(
                "line {pc} would unroll {remaining} more iterations of {per_iteration} instructions, summarizing instead"
            );
        }
        costs_too_much
    }

    fn invariants_while_staying(
        &mut self,
        condition: &AbstractComparison,
        continues_when: bool,
        entry_state: &mut MachineState,
        current_state: &mut MachineState,
    ) -> Vec<LoopInvariant> {
        self.assume_staying(condition, continues_when);
        self.resolve_selects(entry_state);
        self.resolve_selects(current_state);
        let mut observed = invariant_of_registers(&entry_state.0, &current_state.0);
        self.pin_unknown_steps(&mut observed, &entry_state.0, &current_state.0, condition);
        self.computer.solver().pop(1);
        observed
    }

    fn assume_staying(&mut self, condition: &AbstractComparison, continues_when: bool) {
        let staying = comparison_to_ast(if continues_when {
            condition.clone()
        } else {
            condition.clone().not()
        });
        self.computer.solver().push();
        if let Some(staying) = staying {
            self.computer.solver().assert(staying);
        }
    }

    fn pin_unknown_steps(
        &self,
        observed: &mut [LoopInvariant],
        entry: &[RegisterValue],
        current: &[RegisterValue],
        guard: &AbstractComparison,
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
            if !(self.computer.carries_region(prev)
                || self.computer.carries_region(cur)
                || named_in_guard(prev)
                || named_in_guard(cur))
            {
                continue;
            }
            let step = generate_expression("-", cur.expression(), prev.expression());
            if !is_translatable(&step) || step.size() > MAX_EXPRESSION_NODES {
                continue;
            }
            if let Some(value) = self.pinned_value(&step) {
                log::info!("x{i} step pinned to {value} by the path");
                *invariant = LoopInvariant::Linear(AbstractExpression::Immediate(value));
            }
        }
        let registers = observed.len().min(entry.len()).min(current.len());
        let guarded = registers_in(guard);
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
                && step
                    .terms
                    .keys()
                    .all(|name| at_entry.binary_search(name).is_err() && !name.contains("_?"));
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
                    || !guarded.contains(&current[j])
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
    }

    fn try_summarize(
        &mut self,
        pc: usize,
        depth: usize,
        expression: &AbstractComparison,
    ) -> Option<bool> {
        if self.active_loops.iter().any(|open| open.pc == pc) {
            return None;
        }
        let history = self.jump_history.clone();
        let this_iteration = self
            .active_loops
            .last()
            .map_or(0, |open| open.history_len.min(history.len()));
        let (index, record) = history
            .iter()
            .enumerate()
            .skip(this_iteration)
            .rev()
            .find(|(_, record)| record.point.pc == pc)?;
        let (previous, branch_decision) = (record.point.clone(), record.taken);
        if self.reads_a_changing_load(expression, &previous.state) {
            log::info!("line {pc} tests a load that changed since the last visit, unrolling");
            return None;
        }
        let failures = self.failed_summaries.borrow().get(&pc).copied();
        if failures.is_some_and(|n| n >= MAX_SUMMARY_TRIES) {
            log::info!("loop at line {pc} failed {MAX_SUMMARY_TRIES} summaries, unrolling");
            return None;
        }
        if let Some((source, header, walked)) =
            self.cycle_back_edge(pc, branch_decision, &history[index + 1..])
            && let Some(successors) = self.static_successors(pc)
            && let [target, fallthrough] = successors.as_slice()
            && let other = if branch_decision {
                *fallthrough
            } else {
                *target
            }
            && self.stays_in_loop(other, header, source, pc != source)
            && !self.can_leave_cycle(other, &walked)
        {
            log::info!("line {pc} branches inside a loop body, not summarized there");
            return None;
        }
        if let Some((_, _, walked)) =
            self.cycle_back_edge(pc, branch_decision, &history[index + 1..])
            && let Some(open) = self
                .active_loops
                .iter()
                .find(|open| walked.contains(&open.pc))
        {
            log::info!(
                "line {pc} is on the cycle of {} at line {}, not summarized again",
                open.id,
                open.pc
            );
            return None;
        }

        let mut entry_state = previous.state.clone();
        self.forget_dead_registers(pc, expression, &mut [&mut entry_state]);
        let mut current_state = self.computer.get_state();
        let mut observed = self.invariants_while_staying(
            expression,
            branch_decision,
            &mut entry_state,
            &mut current_state,
        );
        self.step_past_inner_loops(&mut observed, &entry_state, &current_state);

        let mut attempt = match self.loop_attempts.get(&pc) {
            Some(earlier) if earlier.widened => LoopAttempt {
                widened: false,
                ..earlier.clone()
            },
            Some(earlier) => {
                let joined = join_all(&earlier.invariants, &observed);
                if joined == earlier.invariants {
                    log::info!(
                        "{} at line {pc} reached a fixpoint without closing",
                        earlier.id
                    );
                    return None;
                }
                if earlier.rounds >= max_ascents(observed.len()) {
                    log::error!("{} at line {pc} exceeded its bound", earlier.id);
                    return None;
                }
                LoopAttempt {
                    id: earlier.id,
                    invariants: joined,
                    rounds: earlier.rounds + 1,
                    widened: false,
                    rejected_bounds: earlier.rejected_bounds.clone(),
                }
            }
            None => LoopAttempt {
                id: self.allocate_loop_id(),
                invariants: observed,
                rounds: 1,
                widened: false,
                rejected_bounds: Vec::new(),
            },
        };
        if let Some(unstable) = self.unstable_registers.borrow().get(&pc) {
            for &i in unstable {
                if let Some(invariant) = attempt.invariants.get_mut(i) {
                    *invariant = LoopInvariant::Unknown;
                }
            }
        }
        if let Some((i, _)) = attempt.invariants.iter().enumerate().find(|(i, inv)| {
            matches!(inv, LoopInvariant::Unknown)
                && self.computer.carries_region(&current_state.0[*i])
        }) {
            log::info!(
                "{} at line {pc} declined: would widen a region in x{i} (entry {:?} exit {:?})",
                attempt.id,
                entry_state.0[i],
                current_state.0[i]
            );
            return None;
        }

        let cycle_start = previous
            .journal_len
            .min(self.computer.write_journal().len());
        let unstable_cells = self
            .unstable_cells
            .borrow()
            .get(&pc)
            .cloned()
            .unwrap_or_default();
        let mut cells: Vec<(MemoryCell, LoopInvariant)> =
            cells_written(&self.computer.write_journal()[cycle_start..])
                .into_iter()
                .map(|(cell, before)| {
                    let now = self.computer.cell_content(&cell);
                    let invariant = match invariant_of_register(&before, &now) {
                        _ if unstable_cells.contains(&cell) => LoopInvariant::Unknown,
                        LoopInvariant::Fixed => LoopInvariant::Fixed,
                        LoopInvariant::Linear(step)
                            if matches!(step, AbstractExpression::Immediate(_)) =>
                        {
                            LoopInvariant::Linear(step)
                        }
                        _ => LoopInvariant::Unknown,
                    };
                    (cell, invariant)
                })
                .collect();
        for cell in unstable_cells {
            if cells.iter().all(|(known, _)| *known != cell) {
                cells.push((cell, LoopInvariant::Unknown));
            }
        }

        self.anchor_past_inner_loops(pc, &attempt.invariants, &history, &mut current_state);
        let id = attempt.id;
        let ghosts = ghost_operands(
            &previous.condition,
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
                &guard_operands(
                    &previous.condition,
                    expression,
                    &entry_state.0,
                    &current_state.0,
                ),
            ),
            branch_decision,
            self.bound_values(
                pc,
                &self.pin_steps(&attempt.invariants),
                &entry_state.0,
                &current_state.0,
            ),
            (
                &entry_state,
                &current_state,
                &self.exit_ghosts(
                    self.loop_exits(pc, branch_decision, &history[index + 1..]),
                    &history[..index],
                    (pc, &entry_state.0, &attempt.invariants),
                ),
                &self.exit_ghosts(
                    branches_walked(pc, &history[index + 1..]),
                    &history[..index],
                    (pc, &entry_state.0, &attempt.invariants),
                ),
            ),
        );
        let continuing_now = if branch_decision {
            expression.clone()
        } else {
            expression.clone().not()
        };
        self.bound_geometric_walks(&mut summary, &continuing_now, &current_state);
        let settled_steps = self.settle_select_steps(
            &mut summary,
            &entry_state,
            &current_state,
            &ghosts,
            &continuing_now,
        );
        let continuing_at_summary = summary.continuing.clone();
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
        let round = attempt.rounds;
        let bounds: Vec<Bound> = bound_candidates(&summary.invariants, &current_state.0)
            .into_iter()
            .filter(|bound| !attempt.rejected_bounds.contains(&bound.key()))
            .filter(|bound| self.plausible(bound, &entry_state.0, &current_state.0))
            .collect();
        self.loop_attempts.insert(pc, attempt);

        let unjustified: Vec<AbstractComparison> = summary
            .landings
            .iter()
            .filter(|(requirement, _)| {
                summary_fact_to_ast(requirement).is_none_or(|required| {
                    self.computer.solver().check_assumptions(&[required.not()]) != SatResult::Unsat
                })
            })
            .map(|(_, landing)| landing.clone())
            .collect();
        for landing in &unjustified {
            log::info!("{id} at line {pc} may step over its bound, dropping {landing}");
        }
        summary.facts.retain(|fact| !unjustified.contains(fact));
        if !unjustified.is_empty()
            && let Some(ordered) = self.ordered_by_consecutive_exits(
                (&previous, expression, branch_decision),
                &history[index + 1..],
                &summary.continuing,
            )
        {
            log::info!("{id} at line {pc} exits at every value its walk takes: {ordered}");
            summary.facts.push(ordered);
        }
        summary
            .exit_facts
            .retain(|fact| !unjustified.contains(fact));

        let fallback = self.fork();
        let scope_id = self.push_scope();
        for fact in summary.facts.iter().filter_map(summary_fact_to_ast) {
            self.computer.solver().assert(fact);
        }
        let mut summarized = self.computer.get_state();
        for (i, new_reg) in summary.updates.iter().cloned() {
            summarized.0[i] = new_reg;
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
        for counter in mentioned.iter().filter(|symbol| symbol.contains("_?")) {
            self.computer
                .symbols_bounding_counter_mut()
                .entry(counter.clone())
                .or_default()
                .extend(mentioned.iter().cloned());
        }
        if self.computer.solver().check() == SatResult::Unsat {
            self.pop_scope(scope_id);
            *self.failed_summaries.borrow_mut().entry(pc).or_insert(0) += 1;
            log::info!("{id} at line {pc} summary contradicts the path, unrolling");
            return None;
        }

        self.computer.set_state(summarized);
        if self.unstable_slots.borrow().contains(&pc) {
            self.computer.set_symbolic_slots(Vec::new());
        }
        let kept = self
            .computer
            .symbolic_slots()
            .into_iter()
            .filter(|slot| previous.slots.contains(slot))
            .collect();
        self.computer.set_symbolic_slots(kept);
        let counter = LoopCounter::for_loop(id);
        for (cell, invariant) in &cells {
            let stored = self.computer.cell_content(cell);
            let generalized = match invariant {
                LoopInvariant::Fixed => continue,
                LoopInvariant::Linear(step) => stepped_by_the_counter(&stored, step, &counter),
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
        self.value_ranges.extend(summary.ranges.iter().cloned());
        self.computer.set_flags(summary.flags.clone());
        let invariants = summary.invariants.clone();
        let exit_facts = summary.exit_facts.clone();
        let facts = summary.facts.clone();
        let exits = summary.exits.clone();
        let ghost_checks = summary.ghost_checks.clone();
        let operand_checks = summary.operand_checks.clone();
        self.summaries.borrow_mut().push(summary);

        let instance = {
            let mut ledger = self.ledger.borrow_mut();
            ledger.next_instance += 1;
            ledger.next_instance
        };
        self.relied_on.push(instance);
        self.pending_summary = Some((instance, Box::new(fallback)));
        self.active_loops.push(ActiveLoop {
            id,
            instance,
            pc,
            depth,
            scope_id,
            entry_decision: branch_decision,
            invariants,
            exit_facts,
            state: self.computer.get_state(),
            entry_state: current_state,
            history_len: self.jump_history.len(),
            facts,
            exits,
            round,
            nested_facts: Vec::new(),
            ghost_checks,
            operand_checks,
            cells,
            journal_after_summary,
            blind_writes_at_summary: self.computer.blind_stack_writes().len(),
            slots: self.computer.symbolic_slots(),
            settled_steps,
            continuing: continuing_at_summary,
            bounds,
        });
        Some(branch_decision)
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
            let Some(bound) = self.proven_upper_bound(&current.0[i]) else {
                continue;
            };
            let widened = AbstractExpression::Abstract(format!("{}_widened_{i}", counter.name()));
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

    fn pinned_value(&self, e: &AbstractExpression) -> Option<i64> {
        let term = expression_to_ast(e.clone())?;
        let mut assuming = self.computer.select_assumptions(e);
        if self.computer.solver().check_assumptions(&assuming) != SatResult::Sat {
            return None;
        }
        let value = self
            .computer
            .solver()
            .get_model()?
            .eval(&term, true)?
            .as_i64()?;
        assuming.push(term.eq(ast::Int::from_i64(value)).not());
        (self.computer.solver().check_assumptions(&assuming) == SatResult::Unsat).then_some(value)
    }

    fn select_bound(&self, name: &str, fuel: usize) -> Option<i64> {
        if let Some(bound) = self.value_ranges.get(name) {
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
        match value_of(register) {
            AbstractExpression::Immediate(value) => (value >= 0).then_some(value),
            AbstractExpression::Abstract(name) => self.select_bound(&name, MAX_SELECT_CHAIN),
            _ => None,
        }
    }

    fn bound_values(
        &self,
        pc: usize,
        invariants: &[LoopInvariant],
        entry: &[RegisterValue],
        current: &[RegisterValue],
    ) -> Vec<LoopInvariant> {
        let unstable = self
            .unstable_registers
            .borrow()
            .get(&pc)
            .cloned()
            .unwrap_or_default();
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
                    } else {
                        self.bounded_step(step)
                            .map_or_else(|| invariant.clone(), LoopInvariant::AtMost)
                    }
                }
                other => other.clone(),
            })
            .collect()
    }

    fn static_successors(&self, pc: usize) -> Option<Vec<usize>> {
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
            self.computer.solver().check_assumptions(&with) == SatResult::Unsat
        })
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
        self.within_candidate_budget(|solver| solver.check_assumptions(&assuming))
            == SatResult::Unsat
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
    ) {
        for (i, invariant) in observed.iter_mut().enumerate() {
            if *invariant != LoopInvariant::Unknown {
                continue;
            }
            let (before, after) = (&entry.0[i], &current.0[i]);
            if before.kind == RegisterKind::Number || after.kind == RegisterKind::Number {
                continue;
            }
            let mentioned: Vec<String> = [value_of(before), value_of(after)]
                .iter()
                .flat_map(|e| e.get_abstracts())
                .collect();
            let relevant: Vec<&(AbstractExpression, Vec<AbstractExpression>)> = self
                .closed_counters
                .iter()
                .rev()
                .filter(|(counter, _)| match counter {
                    AbstractExpression::Abstract(name) => mentioned.contains(name),
                    _ => false,
                })
                .collect();
            if relevant.is_empty() {
                if let Some(step) = self.step_held_by_invariant_symbols(i, entry, current) {
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
                if let Some(step) =
                    self.proven_settled_step(before, after, &settled_before, &settled_after)
                {
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
        if !invariant {
            return None;
        }
        let step = moved.to_expression();
        self.proves_step(before, after, &step).then_some(step)
    }

    fn anchor_past_inner_loops(
        &self,
        pc: usize,
        invariants: &[LoopInvariant],
        history: &[JumpRecord],
        current: &mut MachineState,
    ) {
        let closed: Vec<String> = self
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
        let cleaned = Affine::of_register(first)?.without_terms_tied_to(closed);
        let with_kind_of_first = |affine: &Affine| {
            let mut register = affine.to_register();
            if register.base.is_some() {
                register.kind = first.kind.clone();
            }
            register
        };
        let anchor = with_kind_of_first(&cleaned);
        if !self.proves_step(&anchor, first, &AbstractExpression::Immediate(0)) {
            return None;
        }
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

    fn proven_settled_step(
        &self,
        before: &RegisterValue,
        after: &RegisterValue,
        settled_before: &AbstractExpression,
        settled_after: &AbstractExpression,
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
        let held_throughout = step
            .get_abstracts()
            .iter()
            .all(|symbol| known_before.contains(symbol) && known_after.contains(symbol));
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
        counter: &str,
    ) -> bool {
        let any = AbstractExpression::Abstract(format!("{counter}_any"));
        let rare_at_any = comparison_with_counter_at(rare_when, counter, &any);
        let continues_after = comparison_with_counter_at(
            continuing,
            counter,
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
        self.computer.solver().check_assumptions(&assuming) == SatResult::Unsat
    }

    fn settle_select_steps(
        &mut self,
        summary: &mut Summary,
        entry: &MachineState,
        current: &MachineState,
        ghosts: &[Ghost],
        continuing_now: &AbstractComparison,
    ) -> Vec<SettledSelectStep> {
        if self.refuted_select_steps.borrow().contains(&summary.pc) {
            return Vec::new();
        }
        let counter = summary.counter.clone();
        let name = counter.name().to_string();
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
            let Some((latest, rare, usual)) = orientations.into_iter().find(|(rare_when, _, _)| {
                self.rare_only_at_the_latest(rare_when, &summary.continuing, &name)
            }) else {
                log::info!(
                    "{} x{i}: either arm of {select} may be taken before the latest iteration",
                    summary.id
                );
                continue;
            };

            let latest_name = format!("{name}_latest_{i}");
            self.computer.select_definitions_mut().insert(
                latest_name.clone(),
                (
                    latest.clone(),
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
                AbstractExpression::Abstract(latest_name),
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
                "{} x{i} steps {usual} except possibly the latest, {rare} when {latest}",
                summary.id
            );
            match summary.updates.iter_mut().find(|(j, _)| *j == i) {
                Some(update) => update.1 = settled_register,
                None => summary.updates.push((i, settled_register)),
            }
            settled.push(SettledSelectStep {
                register: i,
                holds_the_select: false,
                condition: latest.clone(),
                rare,
                usual,
            });
            let latest_value = AbstractExpression::Abstract(format!("{name}_latest_{i}"));
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
                    condition: latest.clone(),
                    rare,
                    usual,
                });
            }
        }
        settled
    }

    fn settled_steps_repeat(&self, active: &ActiveLoop) -> bool {
        let name = LoopCounter::for_loop(active.id).name().to_string();
        let next_iteration = generate_expression(
            "+",
            AbstractExpression::Abstract(name.clone()),
            AbstractExpression::Immediate(1),
        );
        let continues = comparison_with_counter_at(&active.continuing, &name, &next_iteration);
        let repeats = active.settled_steps.iter().all(|settled| {
            let now = value_of(&self.computer.register_at(settled.register));
            let step = if settled.holds_the_select {
                now
            } else {
                generate_expression("-", now, value_of(&active.state.0[settled.register]))
            };
            let condition = comparison_with_counter_at(&settled.condition, &name, &next_iteration);
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
                self.computer.solver().check_assumptions(&with) == SatResult::Unsat
            };
            refuted_when(condition.clone(), settled.rare)
                && refuted_when(condition.not(), settled.usual)
        });
        if !repeats {
            log::info!(
                "{} a settled select step did not repeat; summarizing it as bounded instead",
                active.id
            );
            self.refuted_select_steps.borrow_mut().insert(active.pc);
        }
        repeats
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
            let cell_end = ast::Int::add(&[&cell_start, &ast::Int::from_i64(WIDEST_STORED_VALUE)]);
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
                self.computer.solver().check_assumptions(&[overlap]) != SatResult::Unsat
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
        has_calls: bool,
    ) -> bool {
        let mut seen = BTreeSet::new();
        let mut pending = self.static_successors(from).unwrap_or_default();
        if pending.is_empty() {
            return false;
        }
        while let Some(pc) = pending.pop() {
            if !seen.insert(pc) {
                continue;
            }
            let Some(instruction) = self.program.code.get(pc) else {
                return false;
            };
            if matches!(instruction.flow(), Flow::Call | Flow::Indirect) {
                return false;
            }
            if instruction.overwrites_without_reading(register) {
                continue;
            }
            if instruction.mentions(register) {
                return false;
            }
            match self.static_successors(pc) {
                Some(successors) if successors.is_empty() => {
                    if has_calls {
                        return false;
                    }
                }
                Some(successors) => pending.extend(successors),
                None => return false,
            }
        }
        true
    }

    fn dead_after(&self, pc: usize) -> Rc<Vec<usize>> {
        if let Some(known) = self.dead_registers.borrow().get(&pc) {
            return Rc::clone(known);
        }
        let has_calls = self
            .program
            .code
            .iter()
            .any(|instruction| instruction.flow() == Flow::Call);
        let dead: Vec<usize> = (0..M::Instruction::TRACKED_REGISTERS)
            .filter(|&register| self.is_overwritten_before_any_read(pc, register, has_calls))
            .collect();
        let dead = Rc::new(dead);
        self.dead_registers
            .borrow_mut()
            .insert(pc, Rc::clone(&dead));
        dead
    }

    fn forget_dead_registers(
        &mut self,
        pc: usize,
        guard: &AbstractComparison,
        snapshots: &mut [&mut MachineState],
    ) {
        let read_by_guard = registers_in(guard);
        let dead = self.dead_after(pc);
        let live: Vec<RegisterValue> = (0..M::Instruction::TRACKED_REGISTERS)
            .filter(|other| !dead.contains(other))
            .map(|other| self.computer.register_at(other))
            .collect();
        for &register in dead.iter() {
            let value = self.computer.register_at(register);
            if read_by_guard.contains(&value) && !live.contains(&value) {
                continue;
            }
            let forgotten = RegisterValue::new(RegisterKind::Number, None, 0);
            self.computer.set_register_at(register, forgotten.clone());
            for snapshot in snapshots.iter_mut() {
                snapshot.0[register] = forgotten.clone();
            }
        }
    }

    fn cycle_back_edge(
        &self,
        loop_pc: usize,
        continues: bool,
        cycle: &[JumpRecord],
    ) -> Option<(usize, usize, BTreeSet<usize>)> {
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

    fn stays_in_loop(
        &self,
        from: usize,
        header: usize,
        source: usize,
        other_back_edges: bool,
    ) -> bool {
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
        exits: Vec<JumpRecord>,
        before: &[JumpRecord],
        (loop_pc, entry, steps): (usize, &[RegisterValue], &[LoopInvariant]),
    ) -> Vec<GhostedRecord> {
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
                                leaf_path(&record.point.condition, value).map(|path| Ghost {
                                    path,
                                    value: value.clone(),
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

    fn loop_exits(&self, loop_pc: usize, continues: bool, cycle: &[JumpRecord]) -> Vec<JumpRecord> {
        let Some((source, header, walked)) = self.cycle_back_edge(loop_pc, continues, cycle) else {
            return Vec::new();
        };
        let mut exits: Vec<JumpRecord> = Vec::new();
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

    fn resolve_selects(&self, state: &mut MachineState) {
        if self.computer.select_definitions().is_empty() {
            return;
        }
        for register in state.0.iter_mut() {
            let Some(base) = register.base.clone() else {
                continue;
            };
            let mut resolved = base;
            for name in resolved.get_abstracts() {
                let Some((condition, taken, skipped)) =
                    self.computer.select_definitions().get(&name)
                else {
                    continue;
                };
                let Some(holds) = comparison_to_ast(condition.clone()) else {
                    continue;
                };
                let settled = if self
                    .computer
                    .solver()
                    .check_assumptions(std::slice::from_ref(&holds))
                    == SatResult::Unsat
                {
                    skipped
                } else if self.computer.solver().check_assumptions(&[holds.not()])
                    == SatResult::Unsat
                {
                    taken
                } else {
                    continue;
                };
                let settled = settled.clone();
                let settled = match self.pinned_value(&settled) {
                    Some(value) => AbstractExpression::Immediate(value),
                    None => settled,
                };
                resolved = substitute(&resolved, &name, &settled);
            }
            register.base = Some(resolved);
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
        {
            let mut unstable = self.unstable_registers.borrow_mut();
            let known = unstable.entry(active.pc).or_default();
            for (i, inv) in joined.iter().enumerate() {
                if *inv == LoopInvariant::Unknown && active.invariants[i] != LoopInvariant::Unknown
                {
                    known.insert(i);
                }
            }
        }
        let failures = self.failed_summaries.borrow().get(&active.pc).copied();
        if failures.is_some_and(|n| n >= MAX_SUMMARY_TRIES) {
            return;
        }
        if joined == active.invariants && unbounded.is_empty() {
            return;
        }
        let (rounds, mut rejected_bounds) = self
            .loop_attempts
            .get(&active.pc)
            .map_or((1, Vec::new()), |earlier| {
                (earlier.rounds, earlier.rejected_bounds.clone())
            });
        if rounds >= max_ascents(observed.len()) {
            return;
        }
        rejected_bounds.extend(unbounded);
        self.loop_attempts.insert(
            active.pc,
            LoopAttempt {
                id: active.id,
                invariants: joined,
                rounds: rounds + 1,
                widened: true,
                rejected_bounds,
            },
        );
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
        self.loop_attempts.remove(&active.pc);
    }

    fn keep_facts(&mut self, facts: Vec<ast::Bool>) {
        for fact in &facts {
            self.computer.solver().assert(fact);
        }
        if let Some(enclosing) = self.active_loops.last_mut() {
            enclosing.nested_facts.extend(facts);
        }
    }

    pub(super) fn suspend_for_call(&mut self, pc: usize) {
        let loops = std::mem::take(&mut self.active_loops);
        log::info!(
            "suspended {} loop(s) across the call at line {pc}",
            loops.len()
        );
        self.suspended.push(SuspendedCall {
            resume: pc + 1,
            loops,
            history_len: self.jump_history.len(),
        });
    }

    pub(super) fn resume_suspended(&mut self) {
        let Some(call) = self.suspended.pop() else {
            return;
        };
        while let Some(inner) = self.active_loops.pop() {
            log::info!("{} released at the return", inner.id);
            self.release_loop(&inner);
        }
        self.jump_history
            .truncate(call.history_len.min(self.jump_history.len()));
        log::info!("resumed {} loop(s) after the call", call.loops.len());
        self.active_loops = call.loops;
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
            Some(_) => self.implied(&moved) && !self.implied(&stayed),
            None => self.implied(&bound.at(previous)) && self.implied(&bound.at(current)),
        }
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
        (previous, current, continues): (&BranchPoint, &AbstractComparison, bool),
        cycle: &[JumpRecord],
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
                without_registers(&condition.left)?,
                without_registers(&condition.right)?,
            ))
        };
        let held_now = continuing(current, continues);
        if held_now.op != "!=" || at_summary.op != "!=" {
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
                || !matches!(
                    continuing(&record.point.condition, record.taken)
                        .op
                        .as_str(),
                    "!=" | "<" | ">"
                )
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
                    .check_assumptions(&[held_now.clone(), requirement.not()])
                    == SatResult::Unsat
            })
        });
        proved.then(|| {
            AbstractComparison::new(
                toward,
                generate_expression("-", (*at_summary.left).clone(), (*at_summary.right).clone()),
                AbstractExpression::Immediate(0),
            )
        })
    }

    pub(super) fn proves(&self, fact: AbstractComparison) -> bool {
        comparison_to_ast(fact).is_some_and(|c| {
            self.computer.solver().check_assumptions(&[c.not()]) == SatResult::Unsat
        })
    }

    fn repeat_round(
        &mut self,
        pc: usize,
        exit: usize,
        prefix: &[(AbstractComparison, bool)],
        expression: &mut AbstractComparison,
    ) -> bool {
        let current = self.computer.get_state();
        let Some(entry) = self
            .round_entries
            .get(&pc)
            .filter(|entry| entry.exit == exit)
            .cloned()
        else {
            self.round_entries.insert(
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
            self.round_entries.insert(
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
        self.round_entries.insert(pc, entry);
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
        let mut unit =
            invariants
                .iter()
                .zip(current.0.iter())
                .find_map(|(invariant, register)| match invariant {
                    LoopInvariant::Linear(step) if register.base.is_some() => Some(step.clone()),
                    _ => None,
                })?;
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
                    [1, -1].into_iter().find(|sign| {
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
                        RegisterValue::new_empty(&format!("{}_widened_{i}", counter.name())),
                    ));
                    free_registers.push(i);
                }
            }
        }
        if steps.is_empty() {
            return None;
        }
        let rewritten = |c: &AbstractComparison| -> Option<AbstractComparison> {
            Some(AbstractComparison::new(
                &c.op,
                shifted_leaves(&c.left, &current.0, &shifts, &free_registers)?,
                shifted_leaves(&c.right, &current.0, &shifts, &free_registers)?,
            ))
        };
        let condition = rewritten(expression)?;
        let guards: Vec<ast::Bool> = prefix
            .iter()
            .filter_map(|(guard, taken)| {
                let c = comparison_to_ast(rewritten(guard)?)?;
                Some(if *taken { c } else { c.not() })
            })
            .collect();
        let mut free_flags = Vec::new();
        let mut flag = |k: usize, value: &Option<FlagValue>| match value {
            Some(FlagValue::Abstract(c)) => match rewritten(c) {
                Some(rebuilt) => Some(FlagValue::Abstract(rebuilt)),
                None => {
                    free_flags.push(k);
                    widen_flag(&format!("{}_flag_{k}", counter.name()), &None, value)
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
        for guard in guards {
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
                steps,
                free_registers,
                free_flags,
                nonnegative,
            },
        ))
    }

    fn round_covers(
        &self,
        generalized: &MachineState,
        next: &MachineState,
        generalization: &Generalization,
    ) -> bool {
        let Some(&(first, sign)) = generalization.steps.first() else {
            return false;
        };
        let moved =
            |i: usize| generate_expression("-", value_of(&next.0[i]), value_of(&generalized.0[i]));
        let shift = generate_expression("*", AbstractExpression::Immediate(sign), moved(first));
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
        if !registers
            || !generalization
                .nonnegative
                .iter()
                .all(|&i| self.proves(at_least_zero(&next.0[i])))
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
                                self.computer
                                    .solver()
                                    .check_assumptions(&[was.eq(now).not()])
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
            self.active_loops.pop();
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
        self.forget_dead_registers(active.pc, &expression, &mut [&mut summarized, &mut entered]);
        active.state = summarized;
        active.entry_state = entered;
        let current = self.computer.get_state();
        let (mut before, mut after) = (active.state.clone(), current.clone());
        self.assume_staying(&expression, active.entry_decision);
        self.resolve_selects(&mut before);
        self.resolve_selects(&mut after);
        self.computer.solver().pop(1);
        let mut observed = self.pin_steps(&invariant_of_registers(&before.0, &after.0));
        self.assume_staying(&expression, active.entry_decision);
        self.pin_unknown_steps(&mut observed, &before.0, &after.0, &expression);
        self.computer.solver().pop(1);
        let mut observed = self.bound_values(active.pc, &observed, &before.0, &after.0);
        for (i, recorded) in active.invariants.iter().enumerate() {
            if let LoopInvariant::Linear(step) = recorded
                && !recorded.subsumes(&observed[i])
                && self.proves_step(&before.0[i], &after.0[i], step)
            {
                observed[i] = recorded.clone();
            }
        }
        let ghosts_repeat =
            active.ghost_checks.iter().all(|(path, expected)| {
                match condition_side(&expression, path) {
                    Some(AbstractExpression::Register(now)) => self.proves(
                        AbstractComparison::new("==", value_of(now), expected.clone()),
                    ),
                    _ => false,
                }
            }) && active.operand_checks.iter().all(|(path, i)| {
                match condition_side(&expression, path) {
                    Some(AbstractExpression::Register(now)) => {
                        **now == current.0[*i]
                            || self.proves(AbstractComparison::new(
                                "==",
                                value_of(now),
                                value_of(&current.0[*i]),
                            ))
                    }
                    _ => false,
                }
            });
        if !ghosts_repeat {
            log::info!("{} guard operand did not repeat its step", active.id);
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
        let clobbered_cells = self.stack_cells_a_blind_write_may_reach(&active);
        let drifting_cells: Vec<MemoryCell> = rewritten
            .into_iter()
            .filter(|(cell, before)| {
                let now = self.computer.cell_content(cell);
                let seen = self.pin_steps(&[invariant_of_register(before, &now)]);
                let recorded = active
                    .cells
                    .iter()
                    .find(|(known, _)| known == cell)
                    .map_or(LoopInvariant::Fixed, |(_, invariant)| invariant.clone());
                !recorded.subsumes(&seen[0])
            })
            .map(|(cell, _)| cell)
            .chain(clobbered_cells)
            .collect();
        let cells_hold = drifting_cells.is_empty();
        if !cells_hold {
            log::info!(
                "{} memory cells did not repeat their step: {drifting_cells:?}",
                active.id
            );
            self.unstable_cells
                .borrow_mut()
                .entry(active.pc)
                .or_default()
                .extend(drifting_cells);
        }
        let steps_hold = self.settled_steps_repeat(&active);
        let slots_hold = self.computer.slots_kept(&active.slots);
        let confinements_hold = active
            .state
            .0
            .iter()
            .zip(&current.0)
            .all(|(summarized, now)| {
                match summarized
                    .base
                    .as_ref()
                    .filter(|_| summarized.kind == RegisterKind::RegisterBase)
                    .and_then(confined_load_width)
                {
                    Some(width) => {
                        now.kind == RegisterKind::RegisterBase
                            && self
                                .computer
                                .fits_unsigned(&value_of(now), 8 * width as u32)
                    }
                    None => true,
                }
            });
        if !confinements_hold {
            log::info!("{} a widened load left its width", active.id);
        }
        if !slots_hold {
            log::info!("{} a saved slot did not survive the body", active.id);
            self.unstable_slots.borrow_mut().insert(active.pc);
        }
        let unbounded: Vec<String> = active
            .bounds
            .iter()
            .filter(|bound| !self.implied(&bound.at(&current.0)))
            .map(Bound::key)
            .collect();
        if !unbounded.is_empty() {
            log::info!("{} bounds {unbounded:?} not re-established", active.id);
        }
        let holds = cells_hold
            && slots_hold
            && confinements_hold
            && steps_hold
            && ghosts_repeat
            && unbounded.is_empty()
            && active
                .invariants
                .iter()
                .zip(observed.iter())
                .all(|(recorded, seen)| recorded.subsumes(seen));

        if !holds {
            let read_by_guard = registers_in(&expression);
            let only_data_moved = ghosts_repeat
                && active
                    .invariants
                    .iter()
                    .zip(&observed)
                    .enumerate()
                    .filter(|(_, (recorded, seen))| !recorded.subsumes(seen))
                    .all(|(i, _)| {
                        [&active.entry_state.0[i], &active.state.0[i], &current.0[i]]
                            .into_iter()
                            .all(|r| !self.computer.carries_region(r) && !read_by_guard.contains(r))
                    });
            self.refute_active_loop(
                &active,
                &observed,
                unbounded,
                only_data_moved,
                !cells_hold || !slots_hold,
            );
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

        let above = self.scopes_above(active.scope_id);
        self.pop_scope(active.scope_id);
        self.active_loops.pop();
        let left_by = if active.entry_decision {
            expression.not()
        } else {
            expression.clone()
        };
        let counter = AbstractExpression::Abstract(format!("{}_?", active.id));
        if let (Some(left), Some(right)) = (Affine::of(&left_by.left), Affine::of(&left_by.right))
            && let Some(distance) = left.combine(&right, -1)
        {
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
                self.closed_counters.push((counter, values));
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
        for bound in active.bounds.iter().map(|bound| bound.at(&current.0)) {
            kept.extend(self.select_definitions_in(&bound));
            kept.extend(comparison_to_ast(bound));
        }
        self.keep_facts(kept);
        self.jump_history.truncate(active.history_len);
        for record in &mut self.jump_history {
            record.resolved |= record.point.pc == active.pc;
        }
        self.loop_attempts.remove(&active.pc);
        self.rebuild_scopes(above);
        if self.computer.solver().check() == SatResult::Unsat {
            log::info!(
                "{} at line {} has no feasible exit on this path",
                active.id,
                active.pc
            );
            self.path_ends = true;
        }
        Discharge::Closed(!active.entry_decision)
    }

    fn refute_active_loop(
        &mut self,
        active: &ActiveLoop,
        observed: &[LoopInvariant],
        unbounded: Vec<String>,
        only_data_moved: bool,
        memory_drifted: bool,
    ) {
        if !only_data_moved
            && self
                .counted_failures
                .borrow_mut()
                .insert((active.pc, active.id, active.round))
        {
            *self
                .failed_summaries
                .borrow_mut()
                .entry(active.pc)
                .or_insert(0) += 1;
        }
        self.widen_for_retry(active, observed, unbounded);
        if memory_drifted {
            let mut retries = self.cell_retries.borrow_mut();
            let used = retries.entry(active.pc).or_insert(0);
            if *used < MAX_CELL_RETRIES {
                *used += 1;
                self.loop_attempts.remove(&active.pc);
            }
        }
        self.ledger.borrow_mut().failures.push(FailedDischarge {
            instance: active.instance,
            relied_on: self.relied_on.clone(),
            retry: self.loop_attempts.get(&active.pc).cloned(),
        });
    }
}
