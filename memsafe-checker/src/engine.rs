use std::cell::{Cell, RefCell};
use std::collections::HashMap;
use std::io::Error;
use std::rc::Rc;

// Unconditional jumps have no condition to resolve, so a cycle among them never reaches looping_too_deep.
const MAX_UNCONDITIONAL_REVISITS: usize = 1000;
// run recurses once per explored branch, so this bounds stack growth.
const MAX_BRANCH_DEPTH: usize = 20;
// Below this many branches a path is too short for a revisit count to mean anything.
const MAX_JUMP_HISTORY: usize = 30;
// Revisits of one branch before the loop there is called unresolvable.
const MAX_REVISITS_PER_BRANCH: usize = 20;
use z3::ast::Ast;
use z3::*;

use crate::common::*;
use crate::computer::*;
use crate::instruction_parser::*;
use crate::widening::*;

enum BranchOutcome {
    BothExplored,
    Next(usize),
}

// What one executed instruction says about where the run goes next.
enum Step {
    Continue(usize),
    // Both sides of a branch were explored, so this path is finished.
    Stop,
    Done,
}

// Bytes one item of a data directive occupies.
fn item_size(directive: &str) -> Option<i64> {
    match directive {
        ".byte" => Some(1),
        ".hword" | ".short" => Some(2),
        ".word" | ".long" => Some(4),
        ".quad" | ".xword" | ".dword" => Some(8),
        _ => None,
    }
}

// Register values an expression is built from.
fn registers_in_expression(e: &AbstractExpression) -> Vec<RegisterValue> {
    fn walk(e: &AbstractExpression, found: &mut Vec<RegisterValue>) {
        match e {
            AbstractExpression::Register(r) => found.push(*r.clone()),
            AbstractExpression::Expression(_, a, b) => {
                walk(a, found);
                walk(b, found);
            }
            _ => (),
        }
    }
    let mut found = Vec::new();
    walk(e, &mut found);
    found
}

// Both branches usually fail the same way, so report one message rather than two.
fn join_branch_errors(e1: Error, e2: Error) -> String {
    let (e1, e2) = (e1.to_string(), e2.to_string());
    if e1 == e2 { e1 } else { format!("{e1}; {e2}") }
}

#[derive(Clone)]
struct Program {
    // defs: Vec<String>,
    code: Vec<Instruction>,
    labels: Vec<(String, usize)>,
    // ifdefs: Vec<((String, usize), usize)>,
}

// What the engine observes at a conditional branch.
#[derive(Debug, Clone)]
#[allow(dead_code)]
struct BranchPoint {
    pc: usize,
    condition: AbstractComparison,
    accesses: Vec<MemoryAccess>,
    state: ComputerState,
}

// A branch already explored, and which way it went.
#[derive(Debug, Clone)]
struct JumpRecord {
    point: BranchPoint,
    taken: bool,
}

// What the accelerator proposes for one loop: the registers it rewrites and the
// facts that justify them, in the term language rather than as solver calls.
#[derive(Debug, Clone)]
#[allow(dead_code)]
struct Summary {
    id: LoopId,
    pc: usize,
    // The enclosing label, kept only to make diagnostics readable.
    label: Option<String>,
    counter: LoopCounter,
    invariants: Vec<LoopInvariant>,
    updates: Vec<(usize, RegisterValue)>,
    // zero, neg, carry and overflow, in the order ComputerState holds them.
    flags: [Option<FlagValue>; 4],
    facts: Vec<AbstractComparison>,
}

impl Summary {
    // The rewritten value of a register, if the summary changed it.
    #[allow(dead_code)]
    fn register(&self, index: usize) -> Option<&RegisterValue> {
        self.updates
            .iter()
            .find(|(i, _)| *i == index)
            .map(|(_, r)| r)
    }
}

// A register's value at loop entry: a walking register drops the distance it has
// already covered, since the summary counts iterations from the loop's start.
fn anchor_of(r: &RegisterValue, walking: bool) -> AbstractExpression {
    match (&r.base, r.offset) {
        (Some(b), _) if walking => b.clone(),
        (Some(b), 0) => b.clone(),
        (Some(b), n) => generate_expression("+", b.clone(), AbstractExpression::Immediate(n)),
        (None, n) => AbstractExpression::Immediate(n),
    }
}

// Rewrites a condition in terms of loop-entry values, so a trip count derived from
// it counts from where the loop started rather than where it happens to be now.
fn anchored(
    e: &AbstractExpression,
    current: &[RegisterValue],
    invariants: &[LoopInvariant],
) -> AbstractExpression {
    match e {
        AbstractExpression::Register(r) => {
            let walking = current
                .iter()
                .position(|c| c == &**r)
                .is_some_and(|i| matches!(invariants[i], LoopInvariant::Linear(_)));
            anchor_of(r, walking)
        }
        AbstractExpression::Expression(op, a, b) => generate_expression(
            op,
            anchored(a, current, invariants),
            anchored(b, current, invariants),
        ),
        other => other.clone(),
    }
}

// Builds a summary of `current` given the state one iteration earlier. Pure: no
// solver contact, and the caller asserts the facts it returns.
fn summarize(
    id: LoopId,
    pc: usize,
    label: Option<String>,
    condition: &AbstractComparison,
    invariants: Vec<LoopInvariant>,
    previous: &ComputerState,
    current: &ComputerState,
) -> Summary {
    let counter = LoopCounter::for_loop(id);
    let name = counter.name().to_string();

    let mut updates = Vec::new();

    for (i, (invariant, cur)) in invariants.iter().cloned().zip(current.0.iter()).enumerate() {
        match invariant {
            LoopInvariant::Fixed => (),
            LoopInvariant::Linear(step) => {
                // An immediate holds its whole value in the offset.
                let anchor = cur
                    .base
                    .clone()
                    .unwrap_or(AbstractExpression::Immediate(cur.offset));
                let kind = if cur.base.is_some() {
                    cur.kind.clone()
                } else {
                    RegisterKind::RegisterBase
                };
                updates.push((
                    i,
                    RegisterValue {
                        kind,
                        base: Some(advance(anchor, &step, &counter)),
                        offset: 0,
                    },
                ));
            }
            // Not expressible, so widen rather than claim it is invariant.
            LoopInvariant::Unknown => {
                updates.push((i, RegisterValue::new_empty(&format!("{name}_widened_{i}"))));
            }
        }
    }

    let flags = [
        widen_flag(&format!("{name}_zero"), &previous.1, &current.1),
        widen_flag(&format!("{name}_neg"), &previous.2, &current.2),
        widen_flag(&format!("{name}_carry"), &previous.3, &current.3),
        widen_flag(&format!("{name}_overflow"), &previous.4, &current.4),
    ];

    // The concrete prefix already covered the first few iterations.
    let mut facts = vec![AbstractComparison::new(
        ">",
        counter.expression(),
        AbstractExpression::Immediate(2),
    )];

    // q+1 more steps carry the walking register from where the loop started to the
    // value the exit compares it against, whatever each side is derived from. This
    // holds when the counter and the walking register advance at different rates,
    // which a single shared multiple could not express.
    let step_of = |side: &AbstractExpression| -> Option<i64> {
        registers_in_expression(side).into_iter().find_map(|r| {
            match invariants.get(current.0.iter().position(|c| *c == r)?)? {
                LoopInvariant::Linear(AbstractExpression::Immediate(s)) => Some(*s),
                _ => None,
            }
        })
    };

    let trip = match (step_of(&condition.left), step_of(&condition.right)) {
        (Some(s), None) => Some((&condition.right, &condition.left, s)),
        (None, Some(s)) => Some((&condition.left, &condition.right, s)),
        _ => None,
    };

    if let Some((exit, walker, step)) = trip {
        let distance = generate_expression(
            "-",
            anchored(exit, &current.0, &invariants),
            anchored(walker, &current.0, &invariants),
        );
        let trips =
            generate_expression("+", counter.expression(), AbstractExpression::Immediate(1));
        facts.push(AbstractComparison::new(
            "==",
            distance,
            generate_expression("*", trips, AbstractExpression::Immediate(step)),
        ));
    }

    Summary {
        id,
        pc,
        label,
        counter,
        invariants,
        updates,
        flags,
        facts,
    }
}

// What earlier attempts at one loop established, so a retry starts from their join
// rather than from a fresh reading of two states.
#[derive(Debug, Clone)]
struct LoopAttempt {
    id: LoopId,
    invariants: Vec<LoopInvariant>,
    rounds: usize,
}

// A summary awaiting its inductive check, held while the loop scope is pushed.
#[derive(Debug, Clone)]
struct ActiveLoop {
    id: LoopId,
    pc: usize,
    // The run invocation that opened the scope, and so the one that must close it.
    depth: usize,
    // Which solver scope holds its facts, so closing it never depends on position.
    scope_id: usize,
    entry_decision: bool,
    invariants: Vec<LoopInvariant>,
    state: ComputerState,
    // The state before the summary overwrote it, to fall back on if the loop never closes.
    entry_state: ComputerState,
}

#[derive(Clone)]
pub struct ExecutionEngine {
    program: Program,
    computer: ARMCORTEXA,
    // abstracts: HashMap<String, String>,
    active_loop: Option<ActiveLoop>,
    // Per path, not shared: each explored path has to converge on its own.
    loop_attempts: HashMap<usize, LoopAttempt>,
    jump_history: Vec<JumpRecord>,
    fail_fast: bool,
    // Shared so summaries survive the clones made to explore branches.
    summaries: Rc<RefCell<Vec<Summary>>>,
    // Shared too, so branches explored from a clone cannot reuse an id.
    next_loop_id: Rc<Cell<usize>>,
    // Not shared: a cloned solver carries its own copy of the scope stack.
    scopes: Vec<Scope>,
    next_scope_id: usize,
}

// One open solver scope: what it asserted, under a name that survives the scopes below
// it being removed and it being rebuilt on top of what is left.
#[derive(Clone)]
struct Scope {
    id: usize,
    facts: Vec<ast::Bool>,
}

impl ExecutionEngine {
    pub fn new<S: Into<String>>(lines: impl IntoIterator<Item = S>) -> ExecutionEngine {
        // let _ = env_logger::try_init();
        // log::info!("--------");
        // log::info!("NEW EXECUTION ENGINE");
        // log::info!("-------");

        // represent code this way, highly unoptimized
        let mut defs: Vec<String> = Vec::new();
        let mut code: Vec<Instruction> = Vec::new();
        let mut labels: Vec<(String, usize)> = Vec::new();
        let mut ifdefs: Vec<((String, usize), usize)> = Vec::new();

        // grab lines into array
        let mut line_number = 0;
        let mut inifdef = false;
        let mut lastifdef: (String, usize) = ("Start".to_string(), 0);

        // first pass, move text into array
        for line in lines {
            // trim trailing comments and whitespace
            let line: String = line.into();
            let trimmed = line.trim();
            let text = match trimmed.split_once("//") {
                Some(strings) => strings.0.to_string(),
                None => trimmed.to_string(),
            };

            if text.is_empty() || text.starts_with("#") {
                continue;
            } else if text.starts_with('.') {
                defs.push(text);
            } else {
                // check if ifdef but keep them in the code
                if text.starts_with('#') {
                    if inifdef {
                        ifdefs.push((lastifdef.clone(), line_number));
                        inifdef = false;
                    } else {
                        inifdef = true;
                        lastifdef = (text.clone(), line_number);
                    }
                }

                let i = Instruction::new(text.clone());
                if i.ty == InstructionType::Label {
                    labels.push((i.opcode, line_number));
                }
                code.push(Instruction::new(text));

                line_number += 1;
            }
        }

        let mut computer = ARMCORTEXA::new();

        // load computer static memory
        let mut address: i64 = 0;
        for def in defs.iter() {
            let v: Vec<&str> = def.split(['\t', ',', ' ']).collect();
            // `.align n` on AArch64 aligns to a 2^n boundary.
            if v[0] == ".align" {
                if let Some(n) = v.get(1).and_then(|n| n.parse::<u32>().ok()) {
                    let boundary = 1i64 << n;
                    address = (address + boundary - 1) & !(boundary - 1);
                }
            } else if let Some(item) = item_size(v[0]) {
                for i in v.iter().skip(1) {
                    if i.is_empty() {
                        continue;
                    }
                    // An item whose value is not a literal still occupies its space.
                    let num = match i.strip_prefix("0x") {
                        Some(hex) => u64::from_str_radix(hex, 16).ok().map(|v| v as i64),
                        None => i.parse::<i64>().ok(),
                    };
                    if let Some(num) = num {
                        computer.add_memory_value("memory".to_string(), address, num, item);
                    }
                    address += item;
                }
            } else if v[0] == ".globl" || v[0] == ".private_extern" {
                computer.memory_labels.insert(v[1].to_string(), address);
            } else if def.contains(":") {
                computer
                    .memory_labels
                    .insert(def.strip_suffix(":").unwrap_or(def).to_string(), address);
            }
        }
        computer.grow_memory_region("memory".to_string(), address);

        ExecutionEngine {
            program: Program {
                // defs,
                code,
                labels,
                // ifdefs,
            },
            computer,
            jump_history: Vec::new(),
            active_loop: None,
            // abstracts: HashMap::new(),
            fail_fast: true,
            summaries: Rc::new(RefCell::new(Vec::new())),
            next_loop_id: Rc::new(Cell::new(0)),
            loop_attempts: HashMap::new(),
            scopes: Vec::new(),
            next_scope_id: 0,
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
            self.computer.solver.assert(temp.ge(&zero));
        }

        self.computer.add_memory_region(base.into(), ty, length);
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
        if register < 8 {
            let name = ("x".to_owned() + &register.to_string()).to_string();
            self.computer.set_abstract(name.clone(), value);
        } else {
            let stack_index = ((register as i64) - 3) * -8;
            self.computer.set_stack_element(stack_index, Some(value), 0);
        }
    }

    pub fn add_abstract_from(&mut self, register: usize, value: impl Into<String>) {
        let value = AbstractExpression::Abstract(value.into());
        if register < 8 {
            let name = ("x".to_owned() + &register.to_string()).to_string();
            self.computer.set_abstract(name.clone(), value);
        } else {
            let stack_index = ((register as i64) - 3) * -8;
            self.computer.set_stack_element(stack_index, Some(value), 0);
        }
    }

    pub fn get_register_output(&self, register: usize) -> RegisterValue {
        self.computer.registers[register].clone()
    }

    pub fn dont_fail_fast(&mut self) {
        self.fail_fast = false;
    }

    pub fn change_alignment(&mut self, value: i64) {
        self.computer.change_alignment(value);
    }

    pub fn start(&mut self, start: impl Into<String>) -> std::io::Result<()> {
        let start: String = start.into();
        let pc = match self
            .get_linenumber_of_label(start.trim_matches(|c| c == '_' || c == ':').to_string())
        {
            Some(n) => n,
            None => return Err(Error::other("Start label not found in program")),
        };

        // run is recursive
        let res = self.run(pc, 0);
        debug_assert!(self.scopes.is_empty(), "solver scopes left open");
        res
    }

    // Branch exploration and loop acceleration push onto the same solver stack, and a
    // scope can be removed from under others, so scopes are named rather than counted.
    fn push_scope(&mut self) -> usize {
        let id = self.next_scope_id;
        self.next_scope_id += 1;
        self.push_scope_with(id);
        id
    }

    fn push_scope_with(&mut self, id: usize) {
        self.computer.solver.push();
        self.scopes.push(Scope {
            id,
            facts: Vec::new(),
        });
    }

    // Pops through the named scope, or does nothing if it is already gone.
    fn pop_scope(&mut self, id: usize) {
        if !self.scopes.iter().any(|s| s.id == id) {
            return;
        }
        while let Some(top) = self.scopes.pop() {
            self.computer.solver.pop(1);
            if top.id == id {
                break;
            }
        }
    }

    // Recorded against the innermost scope, so rebuilding it restores what it asserted.
    fn assert_in_scope(&mut self, c: ast::Bool) {
        self.computer.solver.assert(&c);
        if let Some(scope) = self.scopes.last_mut() {
            scope.facts.push(c);
        }
    }

    // A loop detected here opens a solver scope. Discharge closes it on the way out of
    // the back edge; if control leaves without ever reaching the back edge again, this
    // closes it instead, so the push at detection always has exactly one pop.
    fn run(&mut self, start_pc: usize, depth: usize) -> std::io::Result<()> {
        let result = self.run_from(start_pc, depth);
        if let Some(active) = self.active_loop.clone()
            && active.depth == depth
        {
            log::info!("{} abandoned at line {}", active.id, active.pc);
            self.pop_scope(active.scope_id);
            self.active_loop = None;
        }
        result
    }

    fn run_from(&mut self, start_pc: usize, depth: usize) -> std::io::Result<()> {
        if depth > MAX_BRANCH_DEPTH {
            return Err(Error::other(format!(
                "line {start_pc}: branch depth exceeded {MAX_BRANCH_DEPTH}"
            )));
        }
        let mut pc = start_pc;
        let mut unconditional_visits: HashMap<usize, usize> = HashMap::new();
        let length = self.program.code.len();
        while pc < length {
            match self.step(pc, depth, &mut unconditional_visits)? {
                Step::Continue(next) => pc = next,
                Step::Stop => return Ok(()),
                Step::Done => break,
            }
        }
        self.computer.check_stack_pointer_restored();
        Ok(())
    }

    // The body of one instruction, kept out of run_from so its locals do not sit in the
    // recursion's frame.
    fn step(
        &mut self,
        mut pc: usize,
        depth: usize,
        unconditional_visits: &mut HashMap<usize, usize>,
    ) -> std::io::Result<Step> {
        {
            let mut instruction = self.program.code[pc].clone();

            // skip instruction if it is a label
            if instruction.is_label() {
                pc += 1;
                instruction = self.program.code[pc].clone();
            }

            log::info!("{:?}: {:?}", pc, instruction);

            let execute_result = self.computer.execute(pc, &instruction);

            match execute_result {
                Ok(res) => match res {
                    ExecuteReturnType::Next => Ok(Step::Continue(pc + 1)),
                    ExecuteReturnType::JumpLabel(label) => {
                        if &label == "return" {
                            return Ok(Step::Done);
                        }
                        match self.get_linenumber_of_label(label.clone()) {
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
                        Self::note_unconditional_jump(unconditional_visits, dest)?;
                        Ok(Step::Continue(dest))
                    }
                    ExecuteReturnType::ConditionalJumpLabel(condition, label) => {
                        if self.looping_too_deep() {
                            return Err(Error::other(format!(
                                "line {pc}: loop at {label} not summarized after \
                                 {MAX_REVISITS_PER_BRANCH} revisits"
                            )));
                        }
                        let jump_dest = self.resolve_jump_target(&label)?;
                        Ok(
                            match self.take_conditional_branch(pc, condition, jump_dest, depth)? {
                                BranchOutcome::BothExplored => Step::Stop,
                                BranchOutcome::Next(next) => Step::Continue(next),
                            },
                        )
                    }
                    ExecuteReturnType::ConditionalJumpAddress(condition, address) => {
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
                    ExecuteReturnType::Select(condition, register, option1, option2) => Ok(
                        match self.take_select(pc, condition, register, option1, option2, depth)? {
                            BranchOutcome::BothExplored => Step::Stop,
                            BranchOutcome::Next(next) => Step::Continue(next),
                        },
                    ),
                },
                Err(err) => {
                    // The only place a line number is still known, so it is attached here
                    // rather than left to the log.
                    let err = format!("line {pc} ({}): {err}", instruction.opcode);
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

    // The nearest label at or before `pc`, which names the block the loop sits in.
    fn enclosing_label(&self, pc: usize) -> Option<String> {
        self.program
            .labels
            .iter()
            .filter(|(_, line)| *line <= pc)
            .max_by_key(|(_, line)| *line)
            .map(|(name, _)| name.clone())
    }

    fn get_linenumber_of_label(&self, label: String) -> Option<usize> {
        let label = label.strip_prefix("_").unwrap_or(&label);
        for l in self.program.labels.iter() {
            if l.0.contains(label) && label.contains(&l.0.clone()) {
                return Some(l.1);
            }
        }
        None
    }

    fn note_unconditional_jump(
        visits: &mut HashMap<usize, usize>,
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

    fn resolve_jump_target(&self, label: &str) -> std::io::Result<usize> {
        if let Some(i) = self.get_linenumber_of_label(label.to_string()) {
            return Ok(i);
        }
        let (base, offset) = label
            .split_once('+')
            .ok_or_else(|| Error::other(format!("No label found: {:?}", label)))?;
        let line = self
            .get_linenumber_of_label(base.to_string())
            .ok_or_else(|| Error::other(format!("No label found: {:?}", base)))?;
        let parsed_offset = usize::from_str_radix(offset.trim_start_matches("0x"), 16)
            .expect("unable to parse label offset");
        Ok(line + (parsed_offset / 4))
    }

    // Kept out of run so its locals do not sit in that frame for the whole recursion.
    fn take_select(
        &mut self,
        pc: usize,
        condition: AbstractComparison,
        register: Operand,
        option1: RegisterValue,
        option2: RegisterValue,
        depth: usize,
    ) -> std::io::Result<BranchOutcome> {
        let take = comparison_to_ast(condition.clone()).expect("select condition");
        let skip = comparison_to_ast(condition.clone().not()).expect("negated select condition");
        match (
            self.computer.solver.check_assumptions(&[take]),
            self.computer.solver.check_assumptions(&[skip]),
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
                let clone = &mut self.clone();

                self.add_constraint(condition.clone(), true);
                self.computer
                    .set_register(&register, option1.kind, option1.base, option1.offset);
                let res1 = self.run(pc + 1, depth + 1);

                clone.add_constraint(condition, false);
                self.computer
                    .set_register(&register, option2.kind, option2.base, option2.offset);
                let res2 = clone.run(pc + 1, depth + 1);
                match (res1, res2) {
                    (Ok(_), Ok(_)) => Ok(BranchOutcome::BothExplored),
                    // Already carries its line, so it propagates rather than being re-wrapped.
                    (Err(err), Ok(_)) | (Ok(_), Err(err)) => Err(err),
                    (Err(e1), Err(e2)) => Err(Error::other(join_branch_errors(e1, e2))),
                }
            }
        }
    }

    fn take_conditional_branch(
        &mut self,
        pc: usize,
        condition: AbstractComparison,
        jump_dest: usize,
        depth: usize,
    ) -> std::io::Result<BranchOutcome> {
        let rw_list = self.computer.read_rw_queue();
        match self.evaluate_branch_condition(pc, depth, condition.clone(), rw_list.clone()) {
            None => {
                let clone = &mut self.clone();
                let here = BranchPoint {
                    pc,
                    condition: condition.clone(),
                    accesses: rw_list,
                    state: self.computer.get_state(),
                };
                self.jump_history.push(JumpRecord {
                    point: here.clone(),
                    taken: true,
                });
                self.computer.clear_rw_queue();
                log::info!("exploring jump branch starting line: {:?}", jump_dest);

                let taken_scope = self.push_scope();
                self.add_constraint(condition.clone(), true);
                let res1 = self.run(jump_dest, depth + 1);
                self.pop_scope(taken_scope);

                clone.jump_history.push(JumpRecord {
                    point: here,
                    taken: false,
                });
                clone.computer.clear_rw_queue();
                log::info!("exploring non-jump branch starting line: {:?}", pc + 1);

                // The clone's solver is independent, so this scope is not needed to undo
                // the constraint; it keeps it out of any loop scope discharge would drop.
                let other_scope = clone.push_scope();
                clone.add_constraint(condition, false);
                let res2 = clone.run(pc + 1, depth + 1);
                clone.pop_scope(other_scope);

                match (res1, res2) {
                    (Ok(_), Ok(_)) => Ok(BranchOutcome::BothExplored),
                    // Already carries its line, so it propagates rather than being re-wrapped.
                    (Err(err), Ok(_)) | (Ok(_), Err(err)) => Err(err),
                    (Err(e1), Err(e2)) => Err(Error::other(join_branch_errors(e1, e2))),
                }
            }
            Some(taken) => {
                self.jump_history.push(JumpRecord {
                    point: BranchPoint {
                        pc,
                        condition: condition.clone(),
                        accesses: self.computer.read_rw_queue(),
                        state: self.computer.get_state(),
                    },
                    taken,
                });
                self.computer.clear_rw_queue();
                self.add_constraint(condition, taken);
                let next = if taken { jump_dest } else { pc + 1 };
                log::info!("exploring line: {}", next);
                Ok(BranchOutcome::Next(next))
            }
        }
    }

    fn add_constraint(&mut self, constraint: AbstractComparison, decision: bool) {
        let shown = constraint.clone();
        let c = comparison_to_ast(constraint)
            .unwrap_or_else(|| panic!("untranslatable branch condition {shown}"))
            .simplify();
        self.assert_in_scope(if decision { c } else { c.not() });
    }

    pub fn add_invariant(&self, constraint: AbstractComparison) {
        let shown = constraint.clone();
        let c = comparison_to_ast(constraint)
            .unwrap_or_else(|| panic!("untranslatable invariant {shown}"))
            .simplify();
        self.computer.solver.assert(&c);
    }

    fn looping_too_deep(&self) -> bool {
        if self.jump_history.len() > MAX_JUMP_HISTORY {
            // Non-empty because the length was just checked against a positive bound.
            let pc = self.jump_history.last().expect("jump history").point.pc;
            let loop_count = self
                .jump_history
                .iter()
                .filter(|h| h.point.pc == pc)
                .count();
            if loop_count > MAX_REVISITS_PER_BRANCH {
                log::info!("line {pc} revisited {loop_count} times without resolving");
                return true;
            }
        }
        false
    }

    // if true, we jump
    // if false, we continue
    // if None, we explore both paths
    fn evaluate_branch_condition(
        &mut self,
        pc: usize,
        depth: usize,
        expression: AbstractComparison,
        rw_list: Vec<MemoryAccess>,
    ) -> Option<bool> {
        log::info!("jump condition: {}", expression.clone());
        log::info!("memory accesses: {:?}", rw_list.clone());

        // An open summary is discharged before any decision is trusted, since the facts
        // it asserted make its own exit condition provable.
        if let Some(active) = self.active_loop.clone()
            && active.pc == pc
        {
            return self.discharge_active_loop(active, expression);
        }

        // check whether both branches are valid, only take valid branch
        match (
            self.computer
                .solver
                .check_assumptions(&[comparison_to_ast(expression.clone()).expect(
                    "need result of conversion of comparison to ast for evaluation at jump 0",
                )]),
            self.computer
                .solver
                .check_assumptions(&[comparison_to_ast(expression.clone().not()).expect(
                    "need result of conversion of comparison to ast for evaluation at jump 1",
                )]),
        ) {
            (SatResult::Sat, SatResult::Unsat) => return Some(true),
            (SatResult::Sat, SatResult::Sat) => (), // normal! explore both!
            (SatResult::Unsat, _) => return Some(false),
            (SatResult::Unknown, SatResult::Unsat) => return Some(true),
            // Z3 gave up, so explore both branches rather than trust an undecided answer.
            (_, _) => (),
        }

        // A condition with no symbolic part is already decided above, so there is nothing
        // left to gate on here: detection itself decides whether this is a loop.

        if self.active_loop.is_none() {
            for j in self.jump_history.clone().into_iter().rev() {
                let (previous, branch_decision) = (j.point, j.taken);
                if previous.pc == pc && previous.accesses.len() == rw_list.len() {
                    // JUMP TO Kth ITERATION
                    let current_state = self.computer.get_state();

                    let observed = invariant_of_registers(&previous.state.0, &current_state.0);
                    let attempt = match self.loop_attempts.get(&pc) {
                        // A retry starts from the join, so each round is weaker than the
                        // last. The lattice is flat, so a component ascends at most once
                        // and the number of rounds is bounded by the component count.
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
                            }
                        }
                        None => LoopAttempt {
                            id: self.allocate_loop_id(),
                            invariants: observed,
                            rounds: 1,
                        },
                    };
                    let id = attempt.id;
                    let summary = summarize(
                        id,
                        pc,
                        self.enclosing_label(pc),
                        &expression,
                        attempt.invariants.clone(),
                        &previous.state,
                        &current_state,
                    );
                    log::info!(
                        "detected {id} at line {pc} in {:?}, round {}",
                        summary.label.as_deref().unwrap_or("?"),
                        attempt.rounds
                    );
                    self.loop_attempts.insert(pc, attempt);

                    let scope_id = self.push_scope();
                    for fact in &summary.facts {
                        let c = comparison_to_ast(fact.clone())
                            .unwrap_or_else(|| panic!("untranslatable summary fact {fact}"));
                        self.computer.solver.assert(c);
                    }

                    for (i, new_reg) in summary.updates.iter().cloned() {
                        self.computer.registers[i] = new_reg;
                    }
                    self.computer.set_flags(summary.flags.clone());
                    let invariants = summary.invariants.clone();
                    self.summaries.borrow_mut().push(summary);

                    // for i in 0..(last_state.1.len()) {
                    //     let last = &last_state.1[i];
                    //     let cur = &current_state.1[i];
                    //     let diff: [u8; 16] = match cur.kind {
                    //         RegisterKind::RegisterBase | RegisterKind::Number => {
                    //             if last.base == cur.base {
                    //                 (0..16)
                    //                     .map(|i| cur.offset[i] - last.offset[i])
                    //                     .collect::<Vec<_>>()
                    //                     .try_into()
                    //                     .expect("engine9")
                    //             } else {
                    //                 [0; 16]
                    //             }
                    //         }
                    //         RegisterKind::Immediate => (0..16)
                    //             .map(|i| cur.offset[i] - last.offset[i])
                    //             .collect::<Vec<_>>()
                    //             .try_into()
                    //             .expect("enginea"),
                    //     };

                    //     let mut new_reg = SimdRegister {
                    //         kind: cur.kind.clone(),
                    //         base: cur.base.clone(),
                    //         offset: cur.offset,
                    //     };

                    //     for j in 0..16 {
                    //         let d = diff[j];
                    //         if d > 0 {
                    //             let new_base = generate_expression_from_options(
                    //                 "+",
                    //                 cur.base[j].clone(),
                    //                 Some(generate_expression(
                    //                     "*",
                    //                     AbstractExpression::Abstract(loop_var_name.clone()),
                    //                     AbstractExpression::Immediate(d as i64),
                    //                 )),
                    //             );

                    //             new_reg.base[j] = new_base;
                    //         }
                    //     }
                    //     self.computer.simd_registers[i] = new_reg;
                    // }

                    self.active_loop = Some(ActiveLoop {
                        id,
                        pc,
                        depth,
                        scope_id,
                        entry_decision: branch_decision,
                        invariants,
                        state: self.computer.get_state(),
                        entry_state: current_state,
                    });
                    return Some(branch_decision);
                }
            }

            None

        // A different loop is still open, so do not start another one.
        } else {
            None
        }
    }

    // Checks that one more iteration repeats the change the summary claimed. Flags need
    // no check of their own: they are derived from the registers being checked.
    fn discharge_active_loop(
        &mut self,
        active: ActiveLoop,
        expression: AbstractComparison,
    ) -> Option<bool> {
        let current = self.computer.get_state();
        let observed = invariant_of_registers(&active.state.0, &current.0);
        let holds = active
            .invariants
            .iter()
            .zip(observed.iter())
            .all(|(recorded, seen)| recorded.subsumes(seen));

        // The loop leaves the other way from how it was entered, so the condition must
        // be forced to that value. The facts that force it only exist inside the scope.
        let shown = expression.clone();
        let condition = comparison_to_ast(expression)
            .unwrap_or_else(|| panic!("untranslatable exit condition {shown}"));
        let leaving = if active.entry_decision {
            condition.clone()
        } else {
            condition.clone().not()
        };
        let exits = self
            .computer
            .solver
            .check_assumptions(std::slice::from_ref(&leaving))
            == SatResult::Unsat;

        // Scopes a branch opened inside the body sit above the loop's, and popping through
        // the loop takes them with it, so they are rebuilt once it is gone.
        let above: Vec<Scope> = match self.scopes.iter().position(|s| s.id == active.scope_id) {
            Some(i) => self.scopes[i + 1..].to_vec(),
            None => Vec::new(),
        };
        self.pop_scope(active.scope_id);
        self.active_loop = None;

        // Leaving is a fact about the loop, not about the branch it was reached from, so
        // it is asserted below the rebuilt scopes and outlives them.
        let closed = holds && exits;
        if closed {
            // What holds on the way out is the opposite of the continue direction.
            self.computer.solver.assert(leaving.not().simplify());
        }

        for scope in above {
            self.push_scope_with(scope.id);
            for c in scope.facts {
                self.assert_in_scope(c);
            }
        }

        if closed {
            return Some(!active.entry_decision);
        }

        // The summary's registers only mean anything alongside the facts that just went
        // with the scope, so the path resumes from the values it had before summarizing.
        self.computer.set_state(active.entry_state);
        log::info!(
            "{} at line {} not closed: inductive={holds} exits={exits}",
            active.id,
            active.pc
        );
        None
    }
}

// Left from the register-only summary; the simd equivalent is still unwritten.
/*
                // todo!();
                    // for i in 0..(last_state.1.len()) {
                    //     let last = &last_state.1[i];
                    //     let cur = &current_state.1[i];
                    //     let diff: [u8; 16] = match cur.kind {
                    //         RegisterKind::RegisterBase | RegisterKind::Number => {
                    //             if last.base == cur.base {
                    //                 (0..16)
                    //                     .map(|i| cur.offset[i] - last.offset[i])
                    //                     .collect::<Vec<_>>()
                    //                     .try_into()
                    //                     .expect("engined")
                    //             } else {
                    //                 [0; 16]
                    //             }
                    //         }
                    //         RegisterKind::Immediate => (0..16)
                    //             .map(|i| cur.offset[i] - last.offset[i])
                    //             .collect::<Vec<_>>()
                    //             .try_into()
                    //             .expect("enginee"),
                    //     };

                    //     let base = cur.base.clone();

                    //     if base
                    //         .iter()
                    //         .any(|s| s.is_some() && s.clone().expect("enginef").contains(&loop_var_name))
                    //     {
                    //         let mut new_reg = SimdRegister {
                    //             kind: cur.kind.clone(),
                    //             base: cur.base.clone(),
                    //             offset: cur.offset,
                    //         };

                    //         for j in 0..16 {
                    //             let d = diff[j];
                    //             if d > 0 {
                    //                 let new_base = generate_expression_from_options(
                    //                     "+",
                    //                     cur.base[j].clone(),
                    //                     Some(generate_expression(
                    //                         "*",
                    //                         AbstractExpression::Abstract(loop_var_name.clone()),
                    //                         AbstractExpression::Immediate(d as i64),
                    //                     )),
                    //                 );

                    //                 new_reg.base[j] = new_base;
                    //             }
                    //         }
                    //         self.computer.simd_registers[i] = new_reg;
                    //     }
                    // }
*/

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_label_parsing_simple() {
        let asm = vec!["start:".to_string(), "add x0, x1, x2".to_string()];

        let engine = ExecutionEngine::new(asm);

        let labels: Vec<(String, usize)> = engine.program.labels;
        assert_eq!(labels.len(), 1);
        assert_eq!(labels[0], ("start".to_string(), 0));
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

        let labels: Vec<(String, usize)> = engine.program.labels;
        assert_eq!(labels.len(), 2);
        assert_eq!(labels[0], ("start".to_string(), 0));
        assert_eq!(labels[1], ("end".to_string(), 4));
    }

    // Walks x0 from base to base+length by `stride`, over a region of abstract length.
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
        let x0 = format!("{:?}", summaries[0].register(0).expect("x0 summarized"));
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

    // The counter is named from the id, so pc no longer leaks into the symbol.
    #[test]
    fn counter_is_named_from_the_loop_id() {
        let summaries = summaries_of(4, &[]);
        assert_eq!(summaries[0].id, LoopId::new(0));
        assert_eq!(summaries[0].counter.name(), "loop0_?");
    }

    // Every detection gets its own id, so two summaries never share a counter symbol.
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

    // Each arm is explored from its own clone of the engine, so the allocator has to be
    // shared for the two detections not to be handed the same id.
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

    // The body branches on an unconstrained register, splitting exploration before the
    // loop is ever detected. Detection still happens and the scope is still closed.
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
        assert!(engine.active_loop.is_none());
    }

    // A loop whose stride grows cannot be summarized, so discharge fails and detection
    // runs again. The retry is the same loop, and it may not summarize a second time.
    #[test]
    fn a_loop_that_fails_to_close_is_not_summarized_again() {
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
        assert_eq!(at_the_loop.len(), 1, "resummarized: {at_the_loop:?}");
    }

    #[test]
    fn size_probe() {
        eprintln!("ExecutionEngine {}", size_of::<ExecutionEngine>());
        eprintln!("ARMCORTEXA {}", size_of::<ARMCORTEXA>());
        eprintln!("RegisterValue {}", size_of::<RegisterValue>());
        eprintln!("SimdRegister {}", size_of::<SimdRegister>());
        eprintln!("ComputerState {}", size_of::<ComputerState>());
        eprintln!("BranchPoint {}", size_of::<BranchPoint>());
        eprintln!("ExecuteReturnType {}", size_of::<ExecuteReturnType>());
        eprintln!("Instruction {}", size_of::<Instruction>());
        eprintln!("Summary {}", size_of::<Summary>());
        eprintln!("JumpRecord {}", size_of::<JumpRecord>());
        eprintln!("AbstractComparison {}", size_of::<AbstractComparison>());
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

    // The register the summary cannot express must be replaced, not carried over.
    #[test]
    fn widened_register_is_a_fresh_symbol() {
        let summaries = summaries_of(4, &["mul x3,x3,x3"]);
        let x3 = format!("{:?}", summaries[0].register(3).expect("x3 summarized"));
        assert!(x3.contains("widened"), "{x3}");
    }

    #[test]
    fn untouched_register_is_summarized_as_fixed() {
        let summaries = summaries_of(4, &[]);
        assert_eq!(summaries[0].invariants[5], LoopInvariant::Fixed);
    }

    #[test]
    fn test_running_small_program_no_mem_access() {
        let asm = vec!["start:".to_string(), "add x0, x1, x2".to_string()];

        let mut engine = ExecutionEngine::new(asm);

        let _ = engine.start("start".to_string());
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
}
