use std::cell::{Cell, RefCell};
use std::collections::{HashMap, HashSet};
use std::io::Error;
use std::rc::Rc;

const MAX_UNCONDITIONAL_REVISITS: usize = 1000;
const MAX_BRANCH_DEPTH: usize = 32;
const MAX_JUMP_HISTORY: usize = 30;
const MIN_REVISITS_PER_BRANCH: usize = 20;
const MAX_SPLIT_VALUES: usize = 4;
const MAX_SUMMARY_TRIES: usize = 3;
const MAX_SELECT_CHAIN: usize = 16;
const SUMMARY_ITERATION: i64 = 3;
const DECIDED_REPEATS_BEFORE_SUMMARY: usize = 3;
const UNROLLING_INSTRUCTION_BUDGET: i64 = 200_000;
const MAX_MERGED_BLOCK: usize = 16;
const MAX_STEPS: usize = 200_000;

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
use crate::computer::*;
use crate::instruction_parser::*;
use crate::loader::{DataItem, DataValue, Listing};
use crate::widening::*;

enum BranchOutcome {
    BothExplored,
    Next(usize),
}

enum Step {
    Continue(usize),
    Stop,
    Done,
}

fn join_branch_errors(e1: Error, e2: Error) -> String {
    let (e1, e2) = (e1.to_string(), e2.to_string());
    if e1 == e2 { e1 } else { format!("{e1}; {e2}") }
}

#[derive(Clone)]
struct Program {
    code: Vec<Instruction>,
    labels: Vec<(String, usize)>,
    loop_ends: HashMap<usize, usize>,
    line_at: HashMap<i64, usize>,
    addresses: HashMap<String, i64>,
}

fn store_data_item(computer: &mut ARMCORTEXA, section: &str, item: &DataItem) {
    match &item.value {
        DataValue::Literal(value) | DataValue::LabelDifference { value, .. } => {
            computer.add_memory_value(section.to_string(), item.offset, *value, item.width)
        }
        DataValue::Pointer(symbol, addend) => {
            if let Some((base, offset)) = computer.symbol_address(symbol) {
                let pointer = RegisterValue::new(
                    RegisterKind::RegisterBase,
                    Some(AbstractExpression::Abstract(base)),
                    offset + addend,
                );
                computer.add_memory_pointer(section, item.offset, pointer, item.width);
            }
        }
        DataValue::Unknown => (),
    }
}

fn branch_label(instruction: &Instruction) -> Option<&str> {
    let is_branch = instruction.ty == InstructionType::ControlFlow
        && (instruction.opcode == "b" || is_conditional_branch(&instruction.opcode));
    if !is_branch {
        return None;
    }
    instruction.operands.iter().rev().find_map(|op| match op {
        Operand::Label(label) => Some(label.as_str()),
        _ => None,
    })
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

fn loop_ends_of(code: &[Instruction], labels: &[(String, usize)]) -> HashMap<usize, usize> {
    let mut ends: HashMap<usize, usize> = HashMap::new();
    for (pc, instruction) in code.iter().enumerate() {
        if let Some(target) = branch_label(instruction).and_then(|l| label_line(labels, l, pc))
            && target <= pc
        {
            let end = ends.entry(target).or_insert(pc);
            *end = (*end).max(pc);
        }
    }
    ends
}

fn register_destination(instruction: &Instruction) -> Option<Option<Operand>> {
    let destination = || match instruction.operands.first() {
        Some(Operand::Register(prefix, n)) if *prefix != RePrefix::Sp => {
            Some(Some(Operand::Register(prefix.clone(), *n)))
        }
        _ => None,
    };
    match instruction.ty {
        InstructionType::Label => Some(None),
        InstructionType::Arithmetic => destination(),
        InstructionType::Other => match instruction.opcode.as_str() {
            "nop" | "hint" | "cmp" | "cmn" | "tst" => Some(None),
            "mov" | "movz" | "movk" | "mvn" | "neg" | "negs" | "ngc" | "ngcs" | "rbit" | "rev"
            | "clz" | "cls" => destination(),
            _ => None,
        },
        InstructionType::ControlFlow => match instruction.opcode.as_str() {
            "csel" | "csinc" | "csinv" | "csneg" | "cset" | "csetm" | "cinc" | "cinv" | "cneg"
            | "mrs" => destination(),
            _ if branch_label(instruction).is_some() => Some(None),
            _ => None,
        },
        _ => None,
    }
}

const LIVENESS_TRACKED_REGISTERS: usize = 30;
const WIDEST_STORED_VALUE: i64 = 16;
const MAX_EXIT_WINDOW: i64 = 8;
const MAX_SETTLING_CHOICES: usize = 64;
const CANDIDATE_PROOF_RESOURCE_LIMIT: u32 = 50_000_000;
const MAX_CELL_RETRIES: usize = 4;

fn general_register_index(prefix: &RePrefix, number: usize) -> Option<usize> {
    match prefix {
        RePrefix::X | RePrefix::W => Some(number),
        RePrefix::Fp => Some(29),
        RePrefix::Ra => Some(30),
        _ => None,
    }
}

fn operand_mentions(operand: &Operand, register: usize) -> bool {
    match operand {
        Operand::Register(prefix, number) => {
            general_register_index(prefix, *number) == Some(register)
        }
        Operand::Memory(prefix, number, _, index, _) => {
            general_register_index(prefix, *number) == Some(register)
                || index
                    .as_ref()
                    .is_some_and(|index| operand_mentions(index, register))
        }
        _ => false,
    }
}

fn overwritten_operands(instruction: &Instruction) -> usize {
    let keeps_part_of_destination = matches!(instruction.opcode.as_str(), "movk" | "bfi" | "bfxil");
    if keeps_part_of_destination {
        return 0;
    }
    if instruction.ty == InstructionType::Memory {
        return match instruction.opcode.as_str() {
            "ldr" | "ldur" | "ldrb" | "ldrh" | "ldrsw" | "ldrsb" | "ldrsh" => 1,
            "ldp" => 2,
            _ => 0,
        };
    }
    match register_destination(instruction) {
        Some(Some(_)) => 1,
        _ => 0,
    }
}

fn overwrites_without_reading(instruction: &Instruction, register: usize) -> bool {
    let (written, read) = instruction
        .operands
        .split_at(overwritten_operands(instruction).min(instruction.operands.len()));
    written.iter().any(|operand| {
        matches!(operand, Operand::Register(..)) && operand_mentions(operand, register)
    }) && !read
        .iter()
        .any(|operand| operand_mentions(operand, register))
}

fn mentions(instruction: &Instruction, register: usize) -> bool {
    instruction
        .operands
        .iter()
        .any(|operand| operand_mentions(operand, register))
}

#[derive(Debug, Clone)]
#[allow(dead_code)]
struct BranchPoint {
    pc: usize,
    condition: AbstractComparison,
    accesses: Vec<MemoryAccess>,
    state: ComputerState,
    journal_len: usize,
    instructions_run: usize,
}

#[derive(Debug, Clone)]
struct JumpRecord {
    point: BranchPoint,
    taken: bool,
    resolved: bool,
}

#[derive(Debug, Clone)]
#[allow(dead_code)]
struct Summary {
    id: LoopId,
    pc: usize,
    label: Option<String>,
    counter: LoopCounter,
    invariants: Vec<LoopInvariant>,
    updates: Vec<(usize, RegisterValue)>,
    flags: [Option<FlagValue>; 4],
    facts: Vec<AbstractComparison>,
    exit_facts: Vec<AbstractComparison>,
    landings: Vec<(AbstractComparison, AbstractComparison)>,
    exits: Vec<(usize, bool)>,
    ranges: Vec<(String, i64)>,
    ghost_checks: Vec<(Vec<bool>, AbstractExpression)>,
    continuing: AbstractComparison,
}

impl Summary {
    #[allow(dead_code)]
    fn register(&self, index: usize) -> Option<&RegisterValue> {
        self.updates
            .iter()
            .find(|(i, _)| *i == index)
            .map(|(_, r)| r)
    }
}

fn value_of(r: &RegisterValue) -> AbstractExpression {
    match (&r.base, r.offset) {
        (Some(b), 0) => b.clone(),
        (Some(b), n) => generate_expression("+", b.clone(), AbstractExpression::Immediate(n)),
        (None, n) => AbstractExpression::Immediate(n),
    }
}

fn rewind(value: AbstractExpression, steps: i64, step: &AbstractExpression) -> AbstractExpression {
    if steps == 0 {
        return value;
    }
    generate_expression(
        "+",
        value,
        generate_expression("*", AbstractExpression::Immediate(-steps), step.clone()),
    )
}

fn anchored(
    e: &AbstractExpression,
    current: &[RegisterValue],
    previous: &[RegisterValue],
    invariants: &[LoopInvariant],
    ghosts: &[Ghost],
) -> AbstractExpression {
    match e {
        AbstractExpression::Register(r) => {
            if let Some(step) = ghost_step(ghosts, r) {
                return rewind(
                    value_of(r),
                    SUMMARY_ITERATION,
                    &AbstractExpression::Immediate(step),
                );
            }
            let found = current
                .iter()
                .position(|c| c == &**r)
                .map(|i| (i, 0))
                .or_else(|| previous.iter().position(|p| p == &**r).map(|i| (i, 1)));
            match found.map(|(i, behind)| (&invariants[i], behind)) {
                Some((LoopInvariant::Linear(step), behind)) => {
                    rewind(value_of(r), SUMMARY_ITERATION - behind, step)
                }
                None => match ghost_step(ghosts, r) {
                    Some(step) => rewind(
                        value_of(r),
                        SUMMARY_ITERATION,
                        &AbstractExpression::Immediate(step),
                    ),
                    None => value_of(r),
                },
                _ => value_of(r),
            }
        }
        AbstractExpression::Expression(op, a, b) => generate_expression(
            op,
            anchored(a, current, previous, invariants, ghosts),
            anchored(b, current, previous, invariants, ghosts),
        ),
        other => other.clone(),
    }
}

fn at_summary(
    e: &AbstractExpression,
    current: &[RegisterValue],
    previous: &[RegisterValue],
    updates: &[(usize, RegisterValue)],
) -> AbstractExpression {
    match e {
        AbstractExpression::Register(r) => {
            let index = current
                .iter()
                .position(|c| c == &**r)
                .or_else(|| previous.iter().position(|p| p == &**r));
            match index.and_then(|i| updates.iter().find(|(j, _)| *j == i)) {
                Some((_, rewritten)) => AbstractExpression::Register(Box::new(rewritten.clone())),
                None => e.clone(),
            }
        }
        AbstractExpression::Expression(op, a, b) => generate_expression(
            op,
            at_summary(a, current, previous, updates),
            at_summary(b, current, previous, updates),
        ),
        other => other.clone(),
    }
}

fn flag_at_summary(
    e: &AbstractExpression,
    current: &[RegisterValue],
    updates: &[(usize, RegisterValue)],
    clobbered_operand: &dyn Fn(&RegisterValue) -> Option<AbstractExpression>,
) -> Option<AbstractExpression> {
    match e {
        AbstractExpression::Register(r) => {
            if let Some(tracked) = clobbered_operand(r) {
                return Some(tracked);
            }
            let mut rewrites = current
                .iter()
                .enumerate()
                .filter(|(_, c)| *c == &**r)
                .map(|(i, _)| updates.iter().find(|(j, _)| *j == i).map(|(_, u)| u));
            let first = rewrites.next();
            if rewrites.any(|rewrite| Some(rewrite) != first) {
                return None;
            }
            match (first, &r.base) {
                (None, None) | (Some(None), _) => Some(e.clone()),
                (Some(Some(rewritten)), Some(_)) => {
                    Some(AbstractExpression::Register(Box::new(rewritten.clone())))
                }
                _ => None,
            }
        }
        AbstractExpression::Expression(op, a, b) => Some(generate_expression(
            op,
            flag_at_summary(a, current, updates, clobbered_operand)?,
            flag_at_summary(b, current, updates, clobbered_operand)?,
        )),
        AbstractExpression::Immediate(_) => Some(e.clone()),
        _ => None,
    }
}

fn shifted_leaves(
    e: &AbstractExpression,
    current: &[RegisterValue],
    shifts: &[(usize, AbstractExpression)],
    free: &[usize],
) -> Option<AbstractExpression> {
    match e {
        AbstractExpression::Register(r) => {
            let exact: Vec<usize> = current
                .iter()
                .enumerate()
                .filter(|(_, c)| *c == &**r)
                .map(|(i, _)| i)
                .collect();
            let candidates = if exact.is_empty() && r.base.is_some() {
                current
                    .iter()
                    .enumerate()
                    .filter(|(_, c)| c.base == r.base)
                    .map(|(i, _)| i)
                    .collect()
            } else {
                exact
            };
            if candidates.iter().any(|i| free.contains(i)) {
                return None;
            }
            let shift_of = |i: usize| shifts.iter().find(|(j, _)| *j == i).map(|(_, s)| s);
            let mut found = candidates.iter().map(|&i| shift_of(i));
            let Some(first) = found.next() else {
                return r.base.is_none().then(|| e.clone());
            };
            if found.any(|shift| shift != first) {
                return None;
            }
            match (first, &r.base) {
                (None, _) => Some(e.clone()),
                (Some(shift), Some(base)) => {
                    Some(AbstractExpression::Register(Box::new(RegisterValue {
                        kind: r.kind.clone(),
                        base: Some(generate_expression("+", base.clone(), shift.clone())),
                        offset: r.offset,
                    })))
                }
                (Some(_), None) => None,
            }
        }
        AbstractExpression::Expression(op, a, b) => Some(generate_expression(
            op,
            shifted_leaves(a, current, shifts, free)?,
            shifted_leaves(b, current, shifts, free)?,
        )),
        AbstractExpression::Immediate(_) => Some(e.clone()),
        _ => None,
    }
}

fn is_zero_step(step: &AbstractExpression) -> bool {
    matches!(step, AbstractExpression::Immediate(0))
}

fn add_steps(a: AbstractExpression, b: AbstractExpression) -> AbstractExpression {
    match (&a, &b) {
        (AbstractExpression::Immediate(0), _) => b,
        (_, AbstractExpression::Immediate(0)) => a,
        (AbstractExpression::Immediate(x), AbstractExpression::Immediate(y)) => {
            AbstractExpression::Immediate(x + y)
        }
        _ => generate_expression("+", a, b),
    }
}

fn negate_step(step: AbstractExpression) -> AbstractExpression {
    match step {
        AbstractExpression::Immediate(n) => AbstractExpression::Immediate(-n),
        AbstractExpression::Expression(op, zero, inner)
            if op == "-" && *zero == AbstractExpression::Immediate(0) =>
        {
            *inner
        }
        other => generate_expression("-", AbstractExpression::Immediate(0), other),
    }
}

fn expression_step<F>(e: &AbstractExpression, register_step: &F) -> Option<AbstractExpression>
where
    F: Fn(&RegisterValue) -> AbstractExpression,
{
    match e {
        AbstractExpression::Register(r) => Some(register_step(r)),
        AbstractExpression::Expression(op, a, _) if op == "%" && is_narrowed(e) => {
            expression_step(a, register_step)
        }
        AbstractExpression::Expression(..) if is_unsigned(e) => match e {
            AbstractExpression::Expression(_, a, _) => expression_step(a, register_step),
            _ => None,
        },
        AbstractExpression::Expression(op, a, b) => {
            let left = expression_step(a, register_step)?;
            let right = expression_step(b, register_step)?;
            match op.as_str() {
                "+" => Some(add_steps(left, right)),
                "-" => Some(add_steps(left, negate_step(right))),
                _ if is_zero_step(&left) && is_zero_step(&right) => {
                    Some(AbstractExpression::Immediate(0))
                }
                _ => None,
            }
        }
        _ => Some(AbstractExpression::Immediate(0)),
    }
}

fn step_at_exit(
    r: &RegisterValue,
    (at_exit, ghosts): (&[RegisterValue], &[Ghost]),
    invariants: &[LoopInvariant],
) -> AbstractExpression {
    match ghost_step(ghosts, r) {
        Some(step) => AbstractExpression::Immediate(step),
        None => step_at(at_exit.iter().position(|c| c == r), invariants),
    }
}

fn anchored_at_exit(
    e: &AbstractExpression,
    states: (&[RegisterValue], &[Ghost]),
    invariants: &[LoopInvariant],
) -> AbstractExpression {
    match e {
        AbstractExpression::Register(r) => match step_at_exit(r, states, invariants) {
            AbstractExpression::Immediate(0) => value_of(r),
            step => rewind(value_of(r), SUMMARY_ITERATION - 1, &step),
        },
        AbstractExpression::Expression(op, a, b) => generate_expression(
            op,
            anchored_at_exit(a, states, invariants),
            anchored_at_exit(b, states, invariants),
        ),
        other => other.clone(),
    }
}

#[derive(Debug, Clone)]
struct Ghost {
    path: Vec<bool>,
    value: RegisterValue,
    step: i64,
}

fn ghost_leaves<F>(
    before: &AbstractExpression,
    after: &AbstractExpression,
    path: &mut Vec<bool>,
    live: &dyn Fn(&RegisterValue, &RegisterValue) -> bool,
    pin: &F,
    found: &mut Vec<Ghost>,
) where
    F: Fn(&AbstractExpression) -> Option<i64>,
{
    match (before, after) {
        (AbstractExpression::Register(before), AbstractExpression::Register(after))
            if !live(before, after) =>
        {
            let step = match invariant_of_register(before, after) {
                LoopInvariant::Linear(AbstractExpression::Immediate(step)) => Some(step),
                LoopInvariant::Unknown => {
                    pin(&generate_expression("-", value_of(after), value_of(before)))
                }
                _ => None,
            };
            if let Some(step) = step.filter(|step| *step != 0) {
                found.push(Ghost {
                    path: path.clone(),
                    value: (**after).clone(),
                    step,
                });
            }
        }
        (
            AbstractExpression::Expression(op_before, left_before, right_before),
            AbstractExpression::Expression(op_after, left_after, right_after),
        ) if op_before == op_after => {
            for (side, b, a) in [
                (true, left_before, left_after),
                (false, right_before, right_after),
            ] {
                path.push(side);
                ghost_leaves(b, a, path, live, pin, found);
                path.pop();
            }
        }
        _ => (),
    }
}

fn ghost_operands<F>(
    previous: &AbstractComparison,
    current: &AbstractComparison,
    entry: &[RegisterValue],
    now: &[RegisterValue],
    pin: F,
) -> Vec<Ghost>
where
    F: Fn(&AbstractExpression) -> Option<i64>,
{
    let mut found = Vec::new();
    if previous.op != current.op {
        return found;
    }
    let live = |before: &RegisterValue, after: &RegisterValue| {
        let moved = invariant_of_register(before, after);
        entry
            .iter()
            .zip(now)
            .any(|(was, is)| is == after && invariant_of_register(was, is) == moved)
    };
    for (side, before, after) in [
        (true, &previous.left, &current.left),
        (false, &previous.right, &current.right),
    ] {
        ghost_leaves(before, after, &mut vec![side], &live, &pin, &mut found);
    }
    found
}

fn leaf_at<'a>(e: &'a AbstractExpression, path: &[bool]) -> Option<&'a AbstractExpression> {
    match (path.split_first(), e) {
        (None, _) => Some(e),
        (Some((left, rest)), AbstractExpression::Expression(_, a, b)) => {
            leaf_at(if *left { a } else { b }, rest)
        }
        _ => None,
    }
}

fn replaced_at(
    e: &AbstractExpression,
    path: &[bool],
    with: &AbstractExpression,
) -> AbstractExpression {
    match (path.split_first(), e) {
        (None, _) => with.clone(),
        (Some((left, rest)), AbstractExpression::Expression(op, a, b)) => {
            if *left {
                generate_expression(op, replaced_at(a, rest, with), (**b).clone())
            } else {
                generate_expression(op, (**a).clone(), replaced_at(b, rest, with))
            }
        }
        _ => e.clone(),
    }
}

fn condition_side<'a>(
    condition: &'a AbstractComparison,
    path: &[bool],
) -> Option<&'a AbstractExpression> {
    let (left, rest) = path.split_first()?;
    leaf_at(
        if *left {
            &condition.left
        } else {
            &condition.right
        },
        rest,
    )
}

fn ghost_step(ghosts: &[Ghost], r: &RegisterValue) -> Option<i64> {
    ghosts.iter().find(|g| g.value == *r).map(|g| g.step)
}

fn ghost_at_summary(
    ghost: &Ghost,
    counter: &LoopCounter,
    iterations_ahead: i64,
) -> AbstractExpression {
    let step = AbstractExpression::Immediate(ghost.step);
    advance(
        rewind(
            value_of(&ghost.value),
            SUMMARY_ITERATION - iterations_ahead,
            &step,
        ),
        &step,
        counter,
    )
}

fn registers_in(condition: &AbstractComparison) -> Vec<RegisterValue> {
    fn collect(e: &AbstractExpression, found: &mut Vec<RegisterValue>) {
        match e {
            AbstractExpression::Register(r) => found.push((**r).clone()),
            AbstractExpression::Expression(_, a, b) => {
                collect(a, found);
                collect(b, found);
            }
            _ => (),
        }
    }
    let mut found = Vec::new();
    collect(&condition.left, &mut found);
    collect(&condition.right, &mut found);
    found
}

fn is_conditional_branch(opcode: &str) -> bool {
    matches!(
        opcode,
        "cbz"
            | "cbnz"
            | "tbz"
            | "tbnz"
            | "bne"
            | "beq"
            | "bgt"
            | "bt"
            | "bge"
            | "bhi"
            | "bcs"
            | "blo"
    ) || opcode.starts_with("b.")
}

fn continues_at_equality(op: &str, continues_when: bool) -> bool {
    matches!(op, "<=" | ">=" | "==") == continues_when
}

fn bound_toward(step: &AbstractExpression) -> Option<&'static str> {
    match step {
        AbstractExpression::Immediate(n) if *n > 0 => Some("<="),
        AbstractExpression::Immediate(n) if *n < 0 => Some(">="),
        _ => None,
    }
}

fn is_ordered(op: &str) -> bool {
    matches!(op, "<" | "<=" | ">" | ">=")
}

fn landing_requirement(
    op: &str,
    distance: &AbstractExpression,
    step: &AbstractExpression,
) -> Option<AbstractComparison> {
    if is_ordered(op) && bound_toward(step).is_some() {
        return None;
    }
    let modulus = match step {
        AbstractExpression::Immediate(0) => return None,
        AbstractExpression::Immediate(n) => AbstractExpression::Immediate(n.abs()),
        other => other.clone(),
    };
    Some(AbstractComparison::new(
        "==",
        generate_expression("%", distance.clone(), modulus),
        AbstractExpression::Immediate(0),
    ))
}

fn is_unsigned(e: &AbstractExpression) -> bool {
    matches!(e, AbstractExpression::Expression(op, _, width)
        if op == "zext" && **width == AbstractExpression::Immediate(64))
}

fn peel_unsigned(e: &AbstractExpression) -> &AbstractExpression {
    match e {
        AbstractExpression::Expression(_, inner, _) if is_unsigned(e) => inner,
        _ => e,
    }
}

fn unwrapped_requirements(
    condition: &AbstractComparison,
    continues_when: bool,
    (exit, walker, step): (
        &AbstractExpression,
        &AbstractExpression,
        &AbstractExpression,
    ),
    distance: &AbstractExpression,
) -> Vec<AbstractComparison> {
    if !is_unsigned(walker) {
        return Vec::new();
    }
    let present = AbstractComparison::new(
        ">=",
        peel_unsigned(walker).clone(),
        AbstractExpression::Immediate(0),
    );
    match crossing_requirement(condition, continues_when, (exit, walker, step), distance) {
        Some(crossing) => vec![present, crossing],
        None => vec![present],
    }
}

fn crossing_requirement(
    condition: &AbstractComparison,
    continues_when: bool,
    (exit, walker, step): (
        &AbstractExpression,
        &AbstractExpression,
        &AbstractExpression,
    ),
    distance: &AbstractExpression,
) -> Option<AbstractComparison> {
    if !is_ordered(&condition.op) {
        return None;
    }
    let continuing = if continues_when {
        condition.clone()
    } else {
        condition.not()
    };
    let op = match (*continuing.left == *walker, continuing.op.as_str()) {
        (true, op) => op.to_string(),
        (false, "<") => ">".to_string(),
        (false, ">") => "<".to_string(),
        (false, "<=") => ">=".to_string(),
        (false, _) => "<=".to_string(),
    };
    let never = AbstractComparison::new(
        "<",
        AbstractExpression::Immediate(0),
        AbstractExpression::Immediate(0),
    );
    let AbstractExpression::Immediate(stride) = step else {
        return Some(never);
    };
    let at_least =
        |n: i64| AbstractComparison::new(">=", exit.clone(), AbstractExpression::Immediate(n));
    Some(match (*stride < 0, op.as_str()) {
        (true, ">=") => at_least(stride.abs()),
        (true, ">") => {
            let clearance = generate_expression(
                "-",
                exit.clone(),
                AbstractExpression::Immediate(stride.abs() - 1),
            );
            let misses = generate_expression(
                "-",
                AbstractExpression::Immediate(0),
                generate_expression(
                    "%",
                    distance.clone(),
                    AbstractExpression::Immediate(stride.abs()),
                ),
            );
            AbstractComparison::new(
                ">=",
                generate_expression("atleast", clearance, misses),
                AbstractExpression::Immediate(0),
            )
        }
        (false, "<" | "<=") => {
            AbstractComparison::new("<=", exit.clone(), AbstractExpression::Immediate(1 << 62))
        }
        _ => never,
    })
}

fn constant_of(e: &AbstractExpression) -> Option<i64> {
    match e {
        AbstractExpression::Immediate(n) => Some(*n),
        AbstractExpression::Register(r) if r.base.is_none() => Some(r.offset),
        _ => None,
    }
}

fn sign_extended_word(e: &AbstractExpression) -> Option<(&AbstractExpression, i64)> {
    match e {
        AbstractExpression::Expression(op, inner, width)
            if op == "sext" && **width == AbstractExpression::Immediate(32) =>
        {
            Some((inner, 0))
        }
        AbstractExpression::Expression(op, word, offset) if op == "+" || op == "-" => {
            let (inner, base) = sign_extended_word(word)?;
            let n = constant_of(offset)?;
            let shift = if op == "+" { n } else { n.checked_neg()? };
            Some((inner, base.checked_add(shift)?))
        }
        _ => None,
    }
}

fn iterations_before_leaving(op: &str, step: i64, bound: i64) -> Option<i64> {
    const HALF: i64 = 1 << 31;
    if !(-HALF..HALF).contains(&bound) {
        return None;
    }
    let span = match (op, step) {
        (">" | ">=", i64::MIN..0) => HALF - 1 - bound,
        ("<" | "<=", 1..) => bound + HALF,
        _ => return None,
    };
    Some(span / step.abs() + 1)
}

fn word_counter_bound<F>(
    condition: &AbstractComparison,
    continues_when: bool,
    register_step: &F,
) -> Option<i64>
where
    F: Fn(&RegisterValue) -> AbstractExpression,
{
    let continuing = if continues_when {
        condition.clone()
    } else {
        condition.not()
    };
    let (word, other, op) = match (
        sign_extended_word(&continuing.left),
        sign_extended_word(&continuing.right),
    ) {
        (Some(word), None) => (word, &continuing.right, continuing.op.clone()),
        (None, Some(word)) => {
            let flipped = match continuing.op.as_str() {
                "<" => ">",
                ">" => "<",
                "<=" => ">=",
                ">=" => "<=",
                other => other,
            };
            (word, &continuing.left, flipped.to_string())
        }
        _ => return None,
    };
    let (inner, shift) = word;
    let bound = constant_of(other)?;
    let AbstractExpression::Immediate(step) = expression_step(inner, register_step)? else {
        return None;
    };
    iterations_before_leaving(&op, step, bound.checked_sub(shift)?)
}

fn continues_while_nonzero(
    continuing: &AbstractComparison,
    walked: &RegisterValue,
    bound: i64,
) -> bool {
    let word = generate_expression(
        "%",
        value_of(walked),
        AbstractExpression::Immediate(1 << 32),
    );
    let is_walked = |e: &AbstractExpression| match e {
        AbstractExpression::Register(r) => {
            **r == *walked || (bound < 1 << 32 && value_of(r) == word)
        }
        _ => false,
    };
    let zero = AbstractExpression::Immediate(0);
    continuing.op == "!="
        && ((*continuing.left == zero && is_walked(&continuing.right))
            || (*continuing.right == zero && is_walked(&continuing.left)))
}

fn trip_facts(
    op: &str,
    inclusive: bool,
    distance: AbstractExpression,
    trips: AbstractExpression,
    step: &AbstractExpression,
) -> Vec<AbstractComparison> {
    let scaled = |n: i64| {
        let count = match n {
            0 => trips.clone(),
            _ => generate_expression("+", trips.clone(), AbstractExpression::Immediate(n)),
        };
        generate_expression("*", count, step.clone())
    };
    match bound_toward(step) {
        Some(toward) if is_ordered(op) => {
            let strict = if toward == "<=" { "<" } else { ">" };
            if inclusive {
                vec![
                    AbstractComparison::new(toward, scaled(0), distance.clone()),
                    AbstractComparison::new(strict, distance, scaled(1)),
                ]
            } else {
                vec![
                    AbstractComparison::new(toward, distance.clone(), scaled(0)),
                    AbstractComparison::new(strict, scaled(-1), distance),
                ]
            }
        }
        _ => vec![AbstractComparison::new("==", distance, scaled(0))],
    }
}

enum Decision {
    Take(bool),
    Explore,
    Unreachable,
}

fn step_at(index: Option<usize>, invariants: &[LoopInvariant]) -> AbstractExpression {
    match index.and_then(|i| invariants.get(i)) {
        Some(LoopInvariant::Linear(step)) => step.clone(),
        _ => AbstractExpression::Immediate(0),
    }
}

type Trip<'a> = (
    &'a AbstractExpression,
    &'a AbstractExpression,
    AbstractExpression,
);

fn trip_of<'a, F>(condition: &'a AbstractComparison, step_of: &F) -> Option<Trip<'a>>
where
    F: Fn(&RegisterValue) -> AbstractExpression,
{
    match (
        expression_step(&condition.left, step_of),
        expression_step(&condition.right, step_of),
    ) {
        (Some(s), Some(z)) if is_zero_step(&z) && !is_zero_step(&s) => {
            Some((&condition.right, &condition.left, s))
        }
        (Some(z), Some(s)) if is_zero_step(&z) && !is_zero_step(&s) => {
            Some((&condition.left, &condition.right, s))
        }
        _ => None,
    }
}

fn summary_fact_to_ast(fact: &AbstractComparison) -> Option<ast::Bool> {
    let translated = comparison_to_ast(fact.clone());
    if translated.is_none() {
        log::info!("summary fact not expressible, dropped: {fact}");
    }
    translated
}

fn facts_for_exit(
    (record, ghosts): (&JumpRecord, &[Ghost]),
    counter: &LoopCounter,
    invariants: &[LoopInvariant],
    bounded: bool,
    landings: &mut Vec<(AbstractComparison, AbstractComparison)>,
) -> Vec<AbstractComparison> {
    let states = (record.point.state.0.as_slice(), ghosts);
    let branch = &record.point.condition;
    let exit_step = |r: &RegisterValue| step_at_exit(r, states, invariants);
    let Some((exit, walker, step)) = trip_of(branch, &exit_step) else {
        return Vec::new();
    };
    let Some(op) = bound_toward(&step) else {
        return Vec::new();
    };
    if bounded && !is_ordered(&branch.op) {
        return Vec::new();
    }
    let at_equality = continues_at_equality(&branch.op, record.taken);
    let trips = counter.total_for(record.point.pc);
    let distance = generate_expression(
        "-",
        anchored_at_exit(exit, states, invariants),
        anchored_at_exit(peel_unsigned(walker), states, invariants),
    );
    let requirement = landing_requirement(&branch.op, &distance, &step);
    let unwrapped = unwrapped_requirements(branch, record.taken, (exit, walker, &step), &distance);
    let mut facts = trip_facts(&branch.op, at_equality, distance, trips.clone(), &step);
    if let (Some(requirement), Some(landing)) = (requirement, facts.first()) {
        landings.push((requirement, landing.clone()));
    }
    let reached = generate_expression(
        "+",
        counter.expression(),
        AbstractExpression::Immediate(if at_equality { -1 } else { 0 }),
    );
    facts.push(AbstractComparison::new(
        op,
        generate_expression("*", reached, step.clone()),
        generate_expression("*", trips, step),
    ));
    for requirement in unwrapped {
        landings.extend(facts.iter().map(|fact| (requirement.clone(), fact.clone())));
    }
    facts
}

fn leaf_path(condition: &AbstractComparison, target: &RegisterValue) -> Option<Vec<bool>> {
    fn search(e: &AbstractExpression, target: &RegisterValue, path: &mut Vec<bool>) -> bool {
        match e {
            AbstractExpression::Register(r) => **r == *target,
            AbstractExpression::Expression(_, a, b) => {
                for (side, child) in [(true, a), (false, b)] {
                    path.push(side);
                    if search(child, target, path) {
                        return true;
                    }
                    path.pop();
                }
                false
            }
            _ => false,
        }
    }
    for (side, e) in [(true, &condition.left), (false, &condition.right)] {
        let mut path = vec![side];
        if search(e, target, &mut path) {
            return Some(path);
        }
    }
    None
}

type GhostedRecord = (JumpRecord, Vec<Ghost>);

fn branches_walked(loop_pc: usize, cycle: &[JumpRecord]) -> Vec<JumpRecord> {
    let mut walked: Vec<JumpRecord> = Vec::new();
    for record in cycle {
        let pc = record.point.pc;
        if pc == loop_pc
            || walked.iter().any(|r| r.point.pc == pc)
            || cycle
                .iter()
                .any(|other| other.point.pc == pc && other.taken != record.taken)
        {
            continue;
        }
        walked.push(record.clone());
    }
    walked
}

fn held_on_the_cycle(
    (record, ghosts): (&JumpRecord, &[Ghost]),
    counter: &LoopCounter,
    invariants: &[LoopInvariant],
    landings: &mut Vec<(AbstractComparison, AbstractComparison)>,
) -> Option<AbstractComparison> {
    let states = (record.point.state.0.as_slice(), ghosts);
    let branch = &record.point.condition;
    let exit_step = |r: &RegisterValue| step_at_exit(r, states, invariants);
    let (exit, walker, step) = trip_of(branch, &exit_step)?;
    if !is_unsigned(walker) {
        return None;
    }
    let exit_anchor = anchored_at_exit(exit, states, invariants);
    let walker_anchor = anchored_at_exit(peel_unsigned(walker), states, invariants);
    let distance = generate_expression("-", exit_anchor.clone(), walker_anchor.clone());
    let requirements =
        unwrapped_requirements(branch, record.taken, (exit, walker, &step), &distance);
    let last = generate_expression(
        "+",
        walker_anchor,
        generate_expression(
            "*",
            generate_expression("-", counter.expression(), AbstractExpression::Immediate(1)),
            step,
        ),
    );
    let continuing = if record.taken {
        branch.clone()
    } else {
        branch.not()
    };
    let fact = if *continuing.left == *walker {
        AbstractComparison::new(&continuing.op, last, exit_anchor)
    } else {
        AbstractComparison::new(&continuing.op, exit_anchor, last)
    };
    landings.extend(
        requirements
            .into_iter()
            .map(|requirement| (requirement, fact.clone())),
    );
    Some(fact)
}

fn stepped_by_the_counter(
    cur: &RegisterValue,
    step: &AbstractExpression,
    counter: &LoopCounter,
) -> RegisterValue {
    let kind = if cur.base.is_some() {
        cur.kind.clone()
    } else {
        RegisterKind::RegisterBase
    };
    let narrowed = cur.base.as_ref().is_some_and(is_narrowed);
    match (&cur.base, step) {
        (Some(base), AbstractExpression::Immediate(stride)) if !narrowed => RegisterValue {
            kind,
            base: Some(advance(base.clone(), step, counter)),
            offset: cur.offset - SUMMARY_ITERATION * stride,
        },
        _ => {
            let anchor = rewind(value_of(cur), SUMMARY_ITERATION, step);
            let advanced = advance(anchor, step, counter);
            RegisterValue {
                kind,
                base: Some(if narrowed {
                    generate_expression("%", advanced, AbstractExpression::Immediate(1i64 << 32))
                } else {
                    advanced
                }),
                offset: 0,
            }
        }
    }
}

fn cells_written(journal: &[CellWrite]) -> Vec<(MemoryCell, RegisterValue)> {
    let mut seen: Vec<(MemoryCell, RegisterValue)> = Vec::new();
    for write in journal {
        if seen.iter().all(|(cell, _)| *cell != write.cell) {
            let before = write
                .previous
                .clone()
                .unwrap_or_else(|| RegisterValue::new(RegisterKind::Number, None, 0));
            seen.push((write.cell.clone(), before));
        }
    }
    seen
}

fn summarize(
    id: LoopId,
    pc: usize,
    label: Option<String>,
    guard: (&AbstractComparison, &[Ghost]),
    continues_when: bool,
    invariants: Vec<LoopInvariant>,
    states: (
        &ComputerState,
        &ComputerState,
        &[GhostedRecord],
        &[GhostedRecord],
    ),
) -> Summary {
    let (condition, ghosts) = guard;
    let (previous, current, cycle, walked) = states;
    let counter = LoopCounter::for_loop(id);
    let name = counter.name().to_string();

    let mut updates = Vec::new();
    let mut progress_facts: Vec<AbstractComparison> = Vec::new();
    let mut ranges = Vec::new();

    for (i, (invariant, cur)) in invariants.iter().cloned().zip(current.0.iter()).enumerate() {
        match invariant {
            LoopInvariant::Fixed => (),
            LoopInvariant::Linear(step) => {
                updates.push((i, stepped_by_the_counter(cur, &step, &counter)));
            }
            LoopInvariant::AtMost(bound) => {
                let progress = AbstractExpression::Abstract(format!("{name}_progress_{i}"));
                let rounds = generate_expression(
                    "-",
                    counter.expression(),
                    AbstractExpression::Immediate(SUMMARY_ITERATION),
                );
                let span = generate_expression("*", AbstractExpression::Immediate(bound), rounds);
                progress_facts.push(AbstractComparison::new(
                    ">=",
                    progress.clone(),
                    AbstractExpression::Immediate(0),
                ));
                progress_facts.push(AbstractComparison::new(">=", span, progress.clone()));
                updates.push((
                    i,
                    RegisterValue {
                        kind: if cur.base.is_some() {
                            cur.kind.clone()
                        } else {
                            RegisterKind::RegisterBase
                        },
                        base: Some(generate_expression("+", value_of(cur), progress)),
                        offset: 0,
                    },
                ));
            }
            LoopInvariant::Within(bound) => {
                let symbol = format!("{name}_within_{i}");
                let value = AbstractExpression::Abstract(symbol.clone());
                progress_facts.push(AbstractComparison::new(
                    ">=",
                    value.clone(),
                    AbstractExpression::Immediate(0),
                ));
                progress_facts.push(AbstractComparison::new(
                    "<=",
                    value.clone(),
                    AbstractExpression::Immediate(bound),
                ));
                ranges.push((symbol, bound));
                updates.push((
                    i,
                    RegisterValue {
                        kind: RegisterKind::RegisterBase,
                        base: Some(value),
                        offset: 0,
                    },
                ));
            }
            LoopInvariant::Unknown | LoopInvariant::Geometric(_) => {
                updates.push((i, RegisterValue::new_empty(&format!("{name}_widened_{i}"))));
            }
            LoopInvariant::Tracks(..) => {}
            LoopInvariant::NonDecreasing | LoopInvariant::NonIncreasing => {
                let progress = AbstractExpression::Abstract(format!("{name}_progress_{i}"));
                progress_facts.push(AbstractComparison::new(
                    ">=",
                    progress.clone(),
                    AbstractExpression::Immediate(0),
                ));
                let direction = if invariant == LoopInvariant::NonDecreasing {
                    "+"
                } else {
                    "-"
                };
                updates.push((
                    i,
                    RegisterValue {
                        kind: RegisterKind::RegisterBase,
                        base: Some(generate_expression(direction, value_of(cur), progress)),
                        offset: 0,
                    },
                ));
            }
        }
    }
    for (i, invariant) in invariants.iter().enumerate() {
        let LoopInvariant::Tracks(j, k) = invariant else {
            continue;
        };
        let leader_now = value_of(&current.0[*j]);
        let leader_then = updates
            .iter()
            .find(|(index, _)| index == j)
            .map_or_else(|| leader_now.clone(), |(_, value)| value_of(value));
        let moved = generate_expression(
            "*",
            AbstractExpression::Immediate(*k),
            generate_expression("-", leader_then, leader_now),
        );
        updates.push((
            i,
            RegisterValue {
                kind: current.0[i].kind.clone(),
                base: Some(generate_expression("+", value_of(&current.0[i]), moved)),
                offset: 0,
            },
        ));
    }

    let clobbered_operand = |r: &RegisterValue| {
        ghosts
            .iter()
            .find(|ghost| ghost.value == *r && !current.0.contains(r))
            .map(|ghost| ghost_at_summary(ghost, &counter, 0))
    };
    let flag = |label: &str, prev: &Option<FlagValue>, cur: &Option<FlagValue>| match cur {
        Some(FlagValue::Abstract(c)) if prev != cur => match (
            flag_at_summary(&c.left, &current.0, &updates, &clobbered_operand),
            flag_at_summary(&c.right, &current.0, &updates, &clobbered_operand),
        ) {
            (Some(left), Some(right)) => Some(FlagValue::Abstract(AbstractComparison::new(
                &c.op, left, right,
            ))),
            _ => widen_flag(&format!("{name}_{label}"), prev, cur),
        },
        _ => widen_flag(&format!("{name}_{label}"), prev, cur),
    };
    let flags = [
        flag("zero", &previous.1, &current.1),
        flag("neg", &previous.2, &current.2),
        flag("carry", &previous.3, &current.3),
        flag("overflow", &previous.4, &current.4),
    ];

    let mut facts = vec![AbstractComparison::new(
        ">",
        counter.expression(),
        AbstractExpression::Immediate(SUMMARY_ITERATION - 1),
    )];
    facts.extend(progress_facts);

    let index_of = |r: &RegisterValue| -> Option<usize> {
        current
            .0
            .iter()
            .position(|c| c == r)
            .or_else(|| previous.0.iter().position(|c| c == r))
    };

    let register_step = |r: &RegisterValue| match (ghost_step(ghosts, r), index_of(r)) {
        (Some(step), _) => AbstractExpression::Immediate(step),
        (None, Some(i)) => step_at(Some(i), &invariants),
        (None, None) => AbstractExpression::Immediate(0),
    };
    let trip = trip_of(condition, &register_step);

    let mut exit_facts = Vec::new();
    let mut landings = Vec::new();
    let bounded = is_ordered(&condition.op)
        && trip
            .as_ref()
            .is_some_and(|(_, _, step)| bound_toward(step).is_some());
    if let Some((exit, walker, step)) = trip {
        let distance = generate_expression(
            "-",
            anchored(exit, &current.0, &previous.0, &invariants, ghosts),
            anchored(
                peel_unsigned(walker),
                &current.0,
                &previous.0,
                &invariants,
                ghosts,
            ),
        );
        let requirement = landing_requirement(&condition.op, &distance, &step);
        let unwrapped =
            unwrapped_requirements(condition, continues_when, (exit, walker, &step), &distance);
        let totals = trip_facts(
            &condition.op,
            continues_at_equality(&condition.op, continues_when),
            distance,
            counter.total(),
            &step,
        );
        if let (Some(requirement), Some(landing)) = (requirement, totals.first()) {
            landings.push((requirement, landing.clone()));
        }
        for requirement in &unwrapped {
            landings.extend(
                totals
                    .iter()
                    .map(|fact| (requirement.clone(), fact.clone())),
            );
        }
        facts.extend(totals.iter().cloned());
        exit_facts.extend(totals);
        if let Some(op) = bound_toward(&step) {
            let reached = generate_expression(
                "+",
                counter.expression(),
                AbstractExpression::Immediate(
                    if continues_at_equality(&condition.op, continues_when) {
                        0
                    } else {
                        1
                    },
                ),
            );
            let fact = AbstractComparison::new(
                op,
                generate_expression("*", reached, step.clone()),
                generate_expression("*", counter.total(), step),
            );
            for requirement in unwrapped {
                landings.push((requirement, fact.clone()));
            }
            facts.push(fact);
        }
    }

    let exits = cycle.iter().map(|(r, _)| (r.point.pc, r.taken)).collect();
    for (record, exit_ghosts) in cycle {
        facts.extend(facts_for_exit(
            (record, exit_ghosts),
            &counter,
            &invariants,
            bounded,
            &mut landings,
        ));
    }
    for (record, branch_ghosts) in walked {
        facts.extend(held_on_the_cycle(
            (record, branch_ghosts),
            &counter,
            &invariants,
            &mut landings,
        ));
    }

    let side_at_summary = |on_left: bool, side: &AbstractExpression| {
        let substituted = ghosts
            .iter()
            .filter(|g| g.path[0] == on_left)
            .fold(side.clone(), |e, ghost| {
                replaced_at(&e, &ghost.path[1..], &ghost_at_summary(ghost, &counter, 0))
            });
        at_summary(&substituted, &current.0, &previous.0, &updates)
    };
    let held = AbstractComparison::new(
        &condition.op,
        side_at_summary(true, &condition.left),
        side_at_summary(false, &condition.right),
    );
    let continuing = if continues_when { held } else { held.not() };
    if let Some(most) = word_counter_bound(condition, continues_when, &register_step) {
        facts.push(AbstractComparison::new(
            "<=",
            counter.expression(),
            AbstractExpression::Immediate(most + SUMMARY_ITERATION),
        ));
    }
    facts.push(continuing.clone());
    let ghost_checks = ghosts
        .iter()
        .map(|ghost| (ghost.path.clone(), ghost_at_summary(ghost, &counter, 1)))
        .collect();

    Summary {
        id,
        pc,
        label,
        counter,
        invariants,
        updates,
        flags,
        facts,
        exit_facts,
        landings,
        exits,
        ranges,
        ghost_checks,
        continuing,
    }
}

fn exit_window(op: &str, per_iteration: i64) -> Vec<i64> {
    if per_iteration == 0 || per_iteration.abs() > MAX_EXIT_WINDOW {
        return Vec::new();
    }
    match (op, per_iteration.signum()) {
        ("==", _) => vec![0],
        ("<", -1) => (per_iteration..=-1).collect(),
        ("<=", -1) => (per_iteration + 1..=0).collect(),
        (">", 1) => (1..=per_iteration).collect(),
        (">=", 1) => (0..per_iteration).collect(),
        _ => Vec::new(),
    }
}

fn with_counter_at(
    e: &AbstractExpression,
    counter: &str,
    value: &AbstractExpression,
) -> AbstractExpression {
    match e {
        AbstractExpression::Abstract(symbol) if symbol == counter => value.clone(),
        AbstractExpression::Expression(op, left, right) => generate_expression(
            op,
            with_counter_at(left, counter, value),
            with_counter_at(right, counter, value),
        ),
        AbstractExpression::Register(register) => {
            AbstractExpression::Register(Box::new(RegisterValue {
                kind: register.kind.clone(),
                base: register
                    .base
                    .as_ref()
                    .map(|base| with_counter_at(base, counter, value)),
                offset: register.offset,
            }))
        }
        other => other.clone(),
    }
}

fn comparison_with_counter_at(
    comparison: &AbstractComparison,
    counter: &str,
    value: &AbstractExpression,
) -> AbstractComparison {
    AbstractComparison::new(
        &comparison.op,
        with_counter_at(&comparison.left, counter, value),
        with_counter_at(&comparison.right, counter, value),
    )
}

#[derive(Debug, Clone)]
struct SettledSelectStep {
    register: usize,
    holds_the_select: bool,
    condition: AbstractComparison,
    rare: i64,
    usual: i64,
}

fn constant_value(e: &AbstractExpression) -> Option<i64> {
    linear_form(e).and_then(|form| form.terms.is_empty().then_some(form.constant))
}

#[derive(Debug, Clone)]
struct LoopAttempt {
    id: LoopId,
    invariants: Vec<LoopInvariant>,
    rounds: usize,
    widened: bool,
}

#[derive(Debug, Clone)]
struct ActiveLoop {
    id: LoopId,
    pc: usize,
    depth: usize,
    scope_id: usize,
    entry_decision: bool,
    invariants: Vec<LoopInvariant>,
    exit_facts: Vec<AbstractComparison>,
    state: ComputerState,
    entry_state: ComputerState,
    history_len: usize,
    entry_condition: AbstractComparison,
    entry_accesses: Vec<MemoryAccess>,
    facts: Vec<AbstractComparison>,
    exits: Vec<(usize, bool)>,
    round: usize,
    nested_facts: Vec<ast::Bool>,
    ghost_checks: Vec<(Vec<bool>, AbstractExpression)>,
    cells: Vec<(MemoryCell, LoopInvariant)>,
    journal_before_summary: usize,
    journal_after_summary: usize,
    blind_writes_at_summary: usize,
    settled_steps: Vec<SettledSelectStep>,
    continuing: AbstractComparison,
}

#[derive(Clone)]
struct RoundEntry {
    exit: usize,
    state: ComputerState,
    generalization: Option<Generalization>,
}

#[derive(Clone)]
struct Generalization {
    steps: Vec<(usize, i64)>,
    free_registers: Vec<usize>,
    free_flags: Vec<usize>,
}

#[derive(Clone)]
pub struct ExecutionEngine {
    program: Rc<Program>,
    computer: ARMCORTEXA,
    active_loops: Vec<ActiveLoop>,
    loop_attempts: HashMap<usize, LoopAttempt>,
    jump_history: Vec<JumpRecord>,
    concrete_decisions: HashMap<usize, bool>,
    closed_counters: Vec<(AbstractExpression, Vec<AbstractExpression>)>,
    instructions_run: usize,
    concrete_latch_visits: HashMap<usize, (usize, i64)>,
    costly_latches: HashSet<usize>,
    select_history: Vec<usize>,
    value_ranges: HashMap<String, i64>,
    fail_fast: bool,
    summaries: Rc<RefCell<Vec<Summary>>>,
    failed_summaries: Rc<RefCell<HashMap<usize, usize>>>,
    dead_registers: Rc<RefCell<HashMap<usize, Rc<Vec<usize>>>>>,
    unstable_registers: Rc<RefCell<HashMap<usize, HashSet<usize>>>>,
    unstable_cells: Rc<RefCell<HashMap<usize, HashSet<MemoryCell>>>>,
    cell_retries: Rc<RefCell<HashMap<usize, usize>>>,
    refuted_select_steps: Rc<RefCell<HashSet<usize>>>,
    counted_failures: Rc<RefCell<HashSet<(usize, LoopId, usize)>>>,
    next_loop_id: Rc<Cell<usize>>,
    steps_left: Rc<Cell<usize>>,
    scopes: Vec<Scope>,
    next_scope_id: usize,
    round_entries: HashMap<usize, RoundEntry>,
    left_through: Option<(usize, Vec<(AbstractComparison, bool)>)>,
    path_ends: bool,
    suspended: Vec<SuspendedCall>,
}

#[derive(Clone)]
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

impl ExecutionEngine {
    pub fn new<S: Into<String>>(lines: impl IntoIterator<Item = S>) -> ExecutionEngine {
        let listing = Listing::parse(lines);
        let mut computer = ARMCORTEXA::new();

        let mut addresses: HashMap<String, i64> = HashMap::new();
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
            computer
                .memory_labels
                .insert(name.clone(), (symbol.section.clone(), symbol.offset));
            if let Some(size) = symbol.size.filter(|s| *s > 0) {
                computer.data_symbol_sizes.insert(name.clone(), size);
            }
        }
        computer.code_labels = Rc::new(listing.labels.iter().map(|(n, _)| n.clone()).collect());
        for section in &listing.data {
            for item in &section.items {
                store_data_item(&mut computer, &section.name, item);
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

        ExecutionEngine {
            program: Rc::new(Program {
                loop_ends: loop_ends_of(&code, &labels),
                code,
                labels,
                line_at,
                addresses,
            }),
            computer,
            jump_history: Vec::new(),
            concrete_decisions: HashMap::new(),
            closed_counters: Vec::new(),
            instructions_run: 0,
            concrete_latch_visits: HashMap::new(),
            costly_latches: HashSet::new(),
            select_history: Vec::new(),
            value_ranges: HashMap::new(),
            active_loops: Vec::new(),
            fail_fast: true,
            summaries: Rc::new(RefCell::new(Vec::new())),
            failed_summaries: Rc::new(RefCell::new(HashMap::new())),
            dead_registers: Rc::new(RefCell::new(HashMap::new())),
            unstable_registers: Rc::new(RefCell::new(HashMap::new())),
            unstable_cells: Rc::new(RefCell::new(HashMap::new())),
            cell_retries: Rc::new(RefCell::new(HashMap::new())),
            refuted_select_steps: Rc::new(RefCell::new(HashSet::new())),
            counted_failures: Rc::new(RefCell::new(HashSet::new())),
            next_loop_id: Rc::new(Cell::new(0)),
            steps_left: Rc::new(Cell::new(limit_from_env("BUMS_MAX_STEPS", MAX_STEPS))),
            loop_attempts: HashMap::new(),
            scopes: Vec::new(),
            next_scope_id: 0,
            round_entries: HashMap::new(),
            left_through: None,
            path_ends: false,
            suspended: Vec::new(),
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
        let base = base.into();
        self.computer
            .solver
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
        if register < 8 {
            let name = ("x".to_owned() + &register.to_string()).to_string();
            self.computer.set_abstract(name.clone(), value);
        } else {
            let stack_index = ((register as i64) - 8) * 8;
            self.computer.set_stack_element(stack_index, Some(value), 0);
        }
    }

    pub fn add_abstract_from(&mut self, register: usize, value: impl Into<String>) {
        let value = AbstractExpression::Abstract(value.into());
        if register < 8 {
            let name = ("x".to_owned() + &register.to_string()).to_string();
            self.computer.set_abstract(name.clone(), value);
        } else {
            let stack_index = ((register as i64) - 8) * 8;
            self.computer.set_stack_element(stack_index, Some(value), 0);
        }
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

    pub fn unread_element_facts(&self) -> Vec<String> {
        self.computer.unread_element_facts()
    }

    pub fn allow_red_zone(&mut self, bytes: i64) {
        self.computer.red_zone = bytes;
    }

    pub fn findings(&self) -> Vec<String> {
        self.computer.findings()
    }

    pub fn get_register_output(&self, register: usize) -> RegisterValue {
        self.computer.registers[register].clone()
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
            branch.computer.solver.assert(&pinned);
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
        let base = self.computer.solver.get_assertions().len();
        self.computer.solver.push();
        self.scopes.push(Scope {
            id,
            base,
            facts: Vec::new(),
        });
    }

    fn fork(&self) -> ExecutionEngine {
        let mut forked = self.clone();
        let assertions = self.computer.solver.get_assertions();
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
        forked.computer.solver = solver;
        forked
    }

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
        self.computer.solver.assert(&c);
        if let Some(scope) = self.scopes.last_mut() {
            scope.facts.push(c);
        }
    }

    fn run(&mut self, start_pc: usize, depth: usize) -> std::io::Result<()> {
        let result = self.run_from(start_pc, depth);
        while let Some(active) = self.active_loops.last()
            && active.depth == depth
        {
            log::info!("{} abandoned at line {}", active.id, active.pc);
            let scope_id = active.scope_id;
            self.active_loops.pop();
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

    fn step(
        &mut self,
        mut pc: usize,
        depth: usize,
        unconditional_visits: &mut HashMap<usize, usize>,
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

            while instruction.is_label() {
                pc += 1;
                if pc >= self.program.code.len() {
                    return Ok(Step::Done);
                }
                instruction = self.program.code[pc].clone();
            }

            log::info!("{:?}: {:?}", pc, instruction);

            let mut execute_result = self.computer.execute(pc, &instruction);
            if matches!(instruction.opcode.as_str(), "bl" | "blr") && execute_result.is_ok() {
                self.suspend_for_call(pc);
            }
            if let Some(condition) = self.costly_concrete_latch(pc, &instruction, &execute_result)
                && let Some(Operand::Label(label)) = instruction.operands.get(1)
            {
                execute_result = Ok(ExecuteReturnType::ConditionalJumpLabel(
                    condition,
                    label.clone(),
                ));
            }

            if is_conditional_branch(&instruction.opcode) {
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
                    ExecuteReturnType::JumpLabel(label) => {
                        if &label == "return" {
                            return Ok(Step::Done);
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
                        if instruction.opcode == "ret"
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
        let parsed_offset = usize::from_str_radix(offset.trim_start_matches("0x"), 16)
            .expect("unable to parse label offset");
        Ok(line + 1 + (parsed_offset / 4))
    }

    fn is_boolean_mask(&self, expr: &AbstractExpression) -> bool {
        match expr {
            AbstractExpression::Immediate(-1) | AbstractExpression::Immediate(0) => true,
            AbstractExpression::Abstract(name) => matches!(
                self.computer
                    .select_definitions
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
        register: Operand,
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
                if let Some(base) = option1.base.clone()
                    && option1.base == option2.base
                    && option1.kind == option2.kind
                {
                    let name = format!("select_{}", self.computer.next_carry());
                    self.computer.select_definitions.insert(
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
                if !self.carries_region(&option1) && !self.carries_region(&option2) {
                    let name = format!("select_{}", self.computer.next_carry());
                    self.computer.select_definitions.insert(
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
                match (res1, res2) {
                    (Ok(_), Ok(_)) => Ok(BranchOutcome::BothExplored),
                    (Err(err), Ok(_)) | (Ok(_), Err(err)) => Err(err),
                    (Err(e1), Err(e2)) => Err(Error::other(join_branch_errors(e1, e2))),
                }
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
        let mut rw_list = self.computer.read_rw_queue();
        if self.active_loops.is_empty()
            && let Some((symbol, values)) = self.concrete_split(&condition)
        {
            return self.split_on(&symbol, &values, pc, depth);
        }
        let decision = self.evaluate_branch_condition(pc, depth, &mut condition, &mut rw_list);
        if std::mem::take(&mut self.path_ends) {
            return Ok(BranchOutcome::BothExplored);
        }
        if decision.is_none()
            && let Some(join) = self.merge_branch_arms(pc, &condition, jump_dest, &rw_list)
        {
            return Ok(BranchOutcome::Next(join));
        }
        match decision {
            None => {
                let clone = &mut self.fork();
                let here = BranchPoint {
                    pc,
                    condition: condition.clone(),
                    accesses: rw_list,
                    state: self.computer.get_state(),
                    journal_len: self.computer.write_journal.len(),
                    instructions_run: self.instructions_run,
                };
                self.jump_history.push(JumpRecord {
                    point: here.clone(),
                    taken: true,
                    resolved: false,
                });
                self.computer.clear_rw_queue();
                log::info!(
                    "exploring jump branch starting line: {:?} (from line {pc}, depth {depth}, history {})",
                    jump_dest,
                    self.jump_history.len()
                );

                let taken_scope = self.push_scope();
                self.add_constraint(condition.clone(), true);
                let res1 = self.run(jump_dest, depth + 1);
                self.pop_scope(taken_scope);

                clone.jump_history.push(JumpRecord {
                    point: here,
                    taken: false,
                    resolved: false,
                });
                clone.computer.clear_rw_queue();
                log::info!("exploring non-jump branch starting line: {:?}", pc + 1);

                let other_scope = clone.push_scope();
                clone.add_constraint(condition, false);
                let res2 = clone.run(pc + 1, depth + 1);
                clone.pop_scope(other_scope);

                match (res1, res2) {
                    (Ok(_), Ok(_)) => Ok(BranchOutcome::BothExplored),
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
                        journal_len: self.computer.write_journal.len(),
                        instructions_run: self.instructions_run,
                    },
                    taken,
                    resolved: false,
                });
                self.computer.clear_rw_queue();
                if self.active_loops.last().is_none_or(|open| open.pc != pc) {
                    self.add_constraint(condition, taken);
                }
                let next = if taken { jump_dest } else { pc + 1 };
                log::info!("exploring line: {}", next);
                Ok(BranchOutcome::Next(next))
            }
        }
    }

    fn memory_free_loop(
        &mut self,
        header: usize,
        end: usize,
    ) -> Option<(Vec<Operand>, Vec<usize>)> {
        let mut written = Vec::new();
        let mut exits = Vec::new();
        let mut conditional_branches = 0;
        let program = Rc::clone(&self.program);
        for pc in header..=end {
            let instruction = program.code.get(pc)?;
            if let Some(destination) = register_destination(instruction)? {
                let current = self.computer.get_register(&destination);
                if self.carries_region(&current) {
                    return None;
                }
                if !written.contains(&destination) {
                    written.push(destination);
                }
            }
            if is_conditional_branch(&instruction.opcode) {
                conditional_branches += 1;
            }
            if let Some(label) = branch_label(instruction) {
                let target = self.resolve_jump_target(label, pc).ok()?;
                if (target < header || target > end) && !exits.contains(&target) {
                    exits.push(target);
                }
            }
        }
        if conditional_branches < 2 {
            return None;
        }
        if self.program.code[end].opcode != "b" && !exits.contains(&(end + 1)) {
            exits.push(end + 1);
        }
        Some((written, exits))
    }

    fn havoc_memory_free_loop(
        &mut self,
        header: usize,
        written: Vec<Operand>,
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

    fn run_data_arm(&mut self, start: usize, stop_at: Option<usize>) -> Option<usize> {
        let mut pc = start;
        for _ in 0..MAX_MERGED_BLOCK {
            if Some(pc) == stop_at {
                return Some(pc);
            }
            let instruction = self.program.code.get(pc)?.clone();
            match instruction.ty {
                InstructionType::Label => {}
                InstructionType::Arithmetic => {}
                InstructionType::Other if matches!(instruction.opcode.as_str(), "mov") => {}
                InstructionType::ControlFlow if instruction.opcode == "b" => {
                    let Some(Operand::Label(label)) = instruction.operands.first() else {
                        return None;
                    };
                    return self.resolve_jump_target(label, pc).ok();
                }
                _ => return None,
            }
            if !instruction.is_label()
                && !matches!(
                    self.computer.execute(pc, &instruction),
                    Ok(ExecuteReturnType::Next)
                )
            {
                return None;
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
        rw_list: &[MemoryAccess],
    ) -> Option<usize> {
        if self.active_loops.iter().any(|open| open.pc == pc)
            || comparison_to_ast(condition.clone()).is_none()
        {
            return None;
        }
        let entry = self.computer.get_state();
        let stop_at = (jump_dest > pc).then_some(jump_dest);
        let Some(fall_end) = self.run_data_arm(pc + 1, stop_at) else {
            self.computer.set_state(entry);
            return None;
        };
        let fallen = self.computer.get_state();
        self.computer.set_state(entry.clone());
        let (taken, join) = if fall_end == jump_dest {
            (entry.clone(), jump_dest)
        } else {
            match self.run_data_arm(jump_dest, None) {
                Some(end) if end == fall_end => (self.computer.get_state(), end),
                _ => {
                    self.computer.set_state(entry);
                    return None;
                }
            }
        };
        let pointer_moved = taken
            .0
            .iter()
            .zip(fallen.0.iter())
            .any(|(a, b)| a != b && (self.carries_region(a) || self.carries_region(b)));
        if pointer_moved {
            self.computer.set_state(entry);
            return None;
        }
        let mut merged = fallen.clone();
        for (i, (if_taken, if_fallen)) in taken.0.iter().zip(fallen.0.iter()).enumerate() {
            if if_taken == if_fallen {
                continue;
            }
            let name = format!("select_{}", self.computer.next_carry());
            self.computer.select_definitions.insert(
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
                accesses: rw_list.to_vec(),
                state: entry,
                journal_len: self.computer.write_journal.len(),
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
    }

    pub fn add_invariant(&self, constraint: AbstractComparison) {
        let shown = constraint.clone();
        let Some(c) = comparison_to_ast(constraint) else {
            log::info!("invariant not expressible, dropped: {shown}");
            return;
        };
        self.computer.solver.assert(c.simplify());
    }

    fn revisit_cap(&self) -> usize {
        let widest_region = self
            .computer
            .memory
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
            self.computer.solver.check_assumptions(&[outside]) == SatResult::Unsat
        })
    }

    fn check_not_stuck(&self, pc: usize, what: &str) -> std::io::Result<()> {
        let cap = self.revisit_cap();
        if self.jump_history.len() > MAX_JUMP_HISTORY {
            let latest = self.jump_history.last().expect("jump history");
            let last = latest.point.pc;
            let loop_count = self
                .jump_history
                .iter()
                .rev()
                .filter(|h| h.point.pc == last)
                .take_while(|h| h.taken == latest.taken)
                .filter(|h| !h.resolved)
                .count();
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

    fn evaluate_branch_condition(
        &mut self,
        pc: usize,
        depth: usize,
        expression: &mut AbstractComparison,
        rw_list: &mut Vec<MemoryAccess>,
    ) -> Option<bool> {
        log::info!("jump condition: {}", expression.clone());
        log::info!("memory accesses: {:?}", rw_list.clone());

        if let Some(active) = self.active_loops.last().cloned()
            && active.pc == pc
        {
            let (entry_condition, entry_accesses) = (
                active.entry_condition.clone(),
                active.entry_accesses.clone(),
            );
            if let Some(decision) = self.discharge_active_loop(active, expression.clone()) {
                return Some(decision);
            }
            match self.left_through.take() {
                Some((exit, prefix)) => {
                    if self.repeat_round(pc, exit, &prefix, expression) {
                        return None;
                    }
                }
                None => {
                    *expression = entry_condition;
                    *rw_list = entry_accesses;
                    if !self
                        .loop_attempts
                        .get(&pc)
                        .is_some_and(|attempt| attempt.widened)
                    {
                        return None;
                    }
                }
            }
        }

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
                self.try_summarize(pc, depth, expression, rw_list)
                    .or(Some(taken))
            }
            Decision::Take(taken) => Some(taken),
            Decision::Explore => self.try_summarize(pc, depth, expression, rw_list),
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

    fn costly_concrete_latch(
        &mut self,
        pc: usize,
        instruction: &Instruction,
        result: &Result<ExecuteReturnType, String>,
    ) -> Option<AbstractComparison> {
        let op = match instruction.opcode.as_str() {
            "cbz" => "==",
            "cbnz" => "!=",
            _ => return None,
        };
        let Ok(ExecuteReturnType::Next | ExecuteReturnType::JumpLabel(_)) = result else {
            return None;
        };
        let Some(Operand::Label(label)) = instruction.operands.get(1) else {
            return None;
        };
        if self.get_linenumber_of_label(label.clone(), pc)? > pc {
            return None;
        }
        let tested = self.computer.get_register(&instruction.operands[0]);
        if tested.base.is_some() || tested.kind == RegisterKind::Number {
            return None;
        }
        let condition = AbstractComparison::new(
            op,
            AbstractExpression::Immediate(0),
            AbstractExpression::Register(Box::new(tested.clone())),
        );
        if self.costly_latches.contains(&pc) {
            return Some(condition);
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
                    return Some(condition);
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
            self.computer.solver.check_assumptions(&assuming)
        };
        match (under(holds), under(fails)) {
            (SatResult::Unsat, SatResult::Unsat) => Decision::Unreachable,
            (SatResult::Sat, SatResult::Unsat) => Decision::Take(true),
            (SatResult::Unsat, _) => Decision::Take(false),
            (SatResult::Unknown, SatResult::Unsat) => Decision::Take(true),
            _ => Decision::Explore,
        }
    }

    fn invariants_while_staying(
        &mut self,
        condition: &AbstractComparison,
        continues_when: bool,
        entry_state: &mut ComputerState,
        current_state: &mut ComputerState,
    ) -> Vec<LoopInvariant> {
        self.assume_staying(condition, continues_when);
        self.resolve_selects(entry_state);
        self.resolve_selects(current_state);
        let mut observed = invariant_of_registers(&entry_state.0, &current_state.0);
        self.pin_unknown_steps(&mut observed, &entry_state.0, &current_state.0, condition);
        self.computer.solver.pop(1);
        observed
    }

    fn assume_staying(&mut self, condition: &AbstractComparison, continues_when: bool) {
        let staying = comparison_to_ast(if continues_when {
            condition.clone()
        } else {
            condition.clone().not()
        });
        self.computer.solver.push();
        if let Some(staying) = staying {
            self.computer.solver.assert(staying);
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
            if !(self.carries_region(prev)
                || self.carries_region(cur)
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
            if !(self.carries_region(&entry[i]) || self.carries_region(&current[i])) {
                continue;
            }
            let Some(follower) = fresh_data_step(i, &observed[i]) else {
                continue;
            };
            let leader = (0..registers).find_map(|j| {
                if j == i
                    || self.carries_region(&entry[j])
                    || self.carries_region(&current[j])
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
        rw_list: &[MemoryAccess],
    ) -> Option<bool> {
        if self.active_loops.iter().any(|open| open.pc == pc) {
            return None;
        }
        let history = self.jump_history.clone();
        let (index, record) = history
            .iter()
            .enumerate()
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
                id: earlier.id,
                invariants: earlier.invariants.clone(),
                rounds: earlier.rounds,
                widened: false,
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
                }
            }
            None => LoopAttempt {
                id: self.allocate_loop_id(),
                invariants: observed,
                rounds: 1,
                widened: false,
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
            matches!(inv, LoopInvariant::Unknown) && self.carries_region(&current_state.0[*i])
        }) {
            log::info!(
                "{} at line {pc} declined: would widen a region in x{i} (entry {:?} exit {:?})",
                attempt.id,
                entry_state.0[i],
                current_state.0[i]
            );
            return None;
        }

        let cycle_start = previous.journal_len.min(self.computer.write_journal.len());
        let unstable_cells = self
            .unstable_cells
            .borrow()
            .get(&pc)
            .cloned()
            .unwrap_or_default();
        let mut cells: Vec<(MemoryCell, LoopInvariant)> =
            cells_written(&self.computer.write_journal[cycle_start..])
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
            (expression, &ghosts),
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
        self.loop_attempts.insert(pc, attempt);

        let unjustified: Vec<AbstractComparison> = summary
            .landings
            .iter()
            .filter(|(requirement, _)| {
                summary_fact_to_ast(requirement).is_none_or(|required| {
                    self.computer.solver.check_assumptions(&[required.not()]) != SatResult::Unsat
                })
            })
            .map(|(_, landing)| landing.clone())
            .collect();
        for landing in &unjustified {
            log::info!("{id} at line {pc} may step over its bound, dropping {landing}");
        }
        summary.facts.retain(|fact| !unjustified.contains(fact));
        summary
            .exit_facts
            .retain(|fact| !unjustified.contains(fact));

        let scope_id = self.push_scope();
        for fact in summary.facts.iter().filter_map(summary_fact_to_ast) {
            self.computer.solver.assert(fact);
        }
        let mentioned: Vec<String> = summary
            .facts
            .iter()
            .chain(&summary.exit_facts)
            .flat_map(|fact| fact.get_abstracts())
            .collect();
        for counter in mentioned.iter().filter(|symbol| symbol.contains("_?")) {
            self.computer
                .symbols_bounding_counter
                .entry(counter.clone())
                .or_default()
                .extend(mentioned.iter().cloned());
        }
        if self.computer.solver.check() == SatResult::Unsat {
            self.pop_scope(scope_id);
            *self.failed_summaries.borrow_mut().entry(pc).or_insert(0) += 1;
            log::info!("{id} at line {pc} summary contradicts the path, unrolling");
            return None;
        }

        for (i, new_reg) in summary.updates.iter().cloned() {
            self.computer.registers[i] = new_reg;
        }
        let journal_before_summary = self.computer.write_journal.len();
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
        let journal_after_summary = self.computer.write_journal.len();
        self.value_ranges.extend(summary.ranges.iter().cloned());
        self.computer.set_flags(summary.flags.clone());
        let invariants = summary.invariants.clone();
        let exit_facts = summary.exit_facts.clone();
        let facts = summary.facts.clone();
        let exits = summary.exits.clone();
        let ghost_checks = summary.ghost_checks.clone();
        self.summaries.borrow_mut().push(summary);

        self.active_loops.push(ActiveLoop {
            id,
            pc,
            depth,
            scope_id,
            entry_decision: branch_decision,
            invariants,
            exit_facts,
            state: self.computer.get_state(),
            entry_state: current_state,
            history_len: self.jump_history.len(),
            entry_condition: expression.clone(),
            entry_accesses: rw_list.to_vec(),
            facts,
            exits,
            round,
            nested_facts: Vec::new(),
            ghost_checks,
            cells,
            journal_before_summary,
            journal_after_summary,
            blind_writes_at_summary: self.computer.blind_stack_writes.len(),
            settled_steps,
            continuing: continuing_at_summary,
        });
        Some(branch_decision)
    }

    fn reads_a_changing_load(
        &self,
        condition: &AbstractComparison,
        previous: &ComputerState,
    ) -> bool {
        let tested = registers_in(condition);
        self.computer
            .registers
            .iter()
            .zip(previous.0.iter())
            .zip(self.computer.loaded.iter())
            .any(|((now, before), loaded)| {
                *loaded
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
        current: &ComputerState,
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
        if self.computer.solver.check_assumptions(&assuming) != SatResult::Sat {
            return None;
        }
        let value = self
            .computer
            .solver
            .get_model()?
            .eval(&term, true)?
            .as_i64()?;
        assuming.push(term.eq(ast::Int::from_i64(value)).not());
        (self.computer.solver.check_assumptions(&assuming) == SatResult::Unsat).then_some(value)
    }

    fn select_bound(&self, name: &str, fuel: usize) -> Option<i64> {
        if let Some(bound) = self.value_ranges.get(name) {
            return Some(*bound);
        }
        let (_, taken, skipped) = self.computer.select_definitions.get(name)?;
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
                        && !self.carries_region(after) =>
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
        let label_at = |i: usize| match instruction.operands.get(i) {
            Some(Operand::Label(label)) => self.resolve_jump_target(label, pc).ok(),
            _ => None,
        };
        let next = pc + 1;
        match instruction.opcode.as_str() {
            "ret" => Some(Vec::new()),
            "br" => None,
            "b" => Some(vec![label_at(0)?]),
            "bl" | "blr" => Some(vec![next]),
            "cbz" | "cbnz" => Some(vec![label_at(1)?, next]),
            "tbz" | "tbnz" => Some(vec![label_at(2)?, next]),
            op if is_conditional_branch(op) => Some(vec![label_at(0)?, next]),
            _ => Some(vec![next]),
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
            && let Some((_, taken, skipped)) = self.computer.select_definitions.get(name)
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
            self.computer.solver.check_assumptions(&with) == SatResult::Unsat
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
        for assertion in self.computer.solver.get_assertions() {
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
        entry: &ComputerState,
        current: &ComputerState,
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
        entry: &ComputerState,
        current: &ComputerState,
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
        current: &mut ComputerState,
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
        self.computer.solver.check_assumptions(&assuming) == SatResult::Unsat
    }

    fn settle_select_steps(
        &mut self,
        summary: &mut Summary,
        entry: &ComputerState,
        current: &ComputerState,
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
                self.computer.select_definitions.get(select).cloned()
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
            self.computer.select_definitions.insert(
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
            let now = value_of(&self.computer.registers[settled.register]);
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
                self.computer.solver.check_assumptions(&with) == SatResult::Unsat
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
            .min(self.computer.blind_stack_writes.len());
        let writes = &self.computer.blind_stack_writes[from..];
        if writes.is_empty() {
            return Vec::new();
        }
        let Some(stack) = self.computer.memory.get("sp") else {
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
                self.computer.solver.check_assumptions(&[overlap]) != SatResult::Unsat
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
        let mut seen = HashSet::new();
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
            if matches!(instruction.opcode.as_str(), "bl" | "blr" | "br") {
                return false;
            }
            if overwrites_without_reading(instruction, register) {
                continue;
            }
            if mentions(instruction, register) {
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
            .any(|instruction| matches!(instruction.opcode.as_str(), "bl" | "blr"));
        let dead: Vec<usize> = (0..LIVENESS_TRACKED_REGISTERS)
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
        snapshots: &mut [&mut ComputerState],
    ) {
        let read_by_guard = registers_in(guard);
        let dead = self.dead_after(pc);
        for &register in dead.iter() {
            if read_by_guard.contains(&self.computer.registers[register]) {
                continue;
            }
            let forgotten = RegisterValue::new(RegisterKind::Number, None, 0);
            self.computer.registers[register] = forgotten.clone();
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
    ) -> Option<(usize, usize, HashSet<usize>)> {
        let branch_step = |pc: usize, taken: bool| -> Option<usize> {
            match self.static_successors(pc)?.as_slice() {
                [target, fallthrough] => Some(if taken { *target } else { *fallthrough }),
                _ => None,
            }
        };
        let mut walked = HashSet::new();
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
            let opcode = &self.program.code.get(pc)?.opcode;
            next = if is_conditional_branch(opcode) {
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
        let mut seen = HashSet::new();
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

    fn can_leave_cycle(&self, from: usize, walked: &HashSet<usize>) -> bool {
        let mut seen = HashSet::new();
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
        let mut pc = branch_pc;
        loop {
            pc = pc.checked_sub(1)?;
            let instruction = self.program.code.get(pc)?;
            if matches!(
                instruction.ty,
                InstructionType::Label | InstructionType::ControlFlow
            ) {
                return None;
            }
            let source = match instruction.opcode.as_str() {
                "subs" | "adds" => instruction.operands.get(1),
                "cmp" | "cmn" => instruction.operands.first(),
                op if op.ends_with('s') || op == "tst" || op == "ccmp" || op == "ccmn" => {
                    return None;
                }
                _ => continue,
            };
            return match source {
                Some(Operand::Register(RePrefix::X, n)) => Some(*n),
                _ => None,
            };
        }
    }

    fn exit_ghosts(
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

    fn resolve_selects(&self, state: &mut ComputerState) {
        if self.computer.select_definitions.is_empty() {
            return;
        }
        for register in state.0.iter_mut() {
            let Some(base) = register.base.clone() else {
                continue;
            };
            let mut resolved = base;
            for name in resolved.get_abstracts() {
                let Some((condition, taken, skipped)) = self.computer.select_definitions.get(&name)
                else {
                    continue;
                };
                let Some(holds) = comparison_to_ast(condition.clone()) else {
                    continue;
                };
                let settled = if self
                    .computer
                    .solver
                    .check_assumptions(std::slice::from_ref(&holds))
                    == SatResult::Unsat
                {
                    skipped
                } else if self.computer.solver.check_assumptions(&[holds.not()]) == SatResult::Unsat
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

    fn carries_region(&self, register: &RegisterValue) -> bool {
        let Some(base) = &register.base else {
            return false;
        };
        base.get_abstracts().iter().any(|symbol| {
            self.computer.memory.contains_key(symbol)
                || self.computer.memory_labels.contains_key(symbol)
        })
    }

    fn widen_for_retry(&mut self, active: &ActiveLoop, observed: &[LoopInvariant]) -> bool {
        let mut joined = join_all(&active.invariants, observed);
        for (i, inv) in joined.iter_mut().enumerate() {
            if *inv != active.invariants[i] && self.carries_region(&active.entry_state.0[i]) {
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
            return false;
        }
        if joined == active.invariants {
            return false;
        }
        let rounds = self
            .loop_attempts
            .get(&active.pc)
            .map_or(1, |earlier| earlier.rounds);
        if rounds >= max_ascents(observed.len()) {
            return false;
        }
        self.loop_attempts.insert(
            active.pc,
            LoopAttempt {
                id: active.id,
                invariants: joined,
                rounds: rounds + 1,
                widened: true,
            },
        );
        log::info!(
            "{} at line {} widening after a failed inductive check",
            active.id,
            active.pc
        );
        true
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
            self.computer.solver.assert(fact);
        }
        if let Some(enclosing) = self.active_loops.last_mut() {
            enclosing.nested_facts.extend(facts);
        }
    }

    fn suspend_for_call(&mut self, pc: usize) {
        if !self.active_loops.is_empty() {
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
    }

    fn resume_suspended(&mut self) {
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

    fn proves(&self, fact: AbstractComparison) -> bool {
        comparison_to_ast(fact)
            .is_some_and(|c| self.computer.solver.check_assumptions(&[c.not()]) == SatResult::Unsat)
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
        previous: &ComputerState,
        current: &ComputerState,
        prefix: &[(AbstractComparison, bool)],
        expression: &mut AbstractComparison,
    ) -> Option<(ComputerState, Generalization)> {
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
        let nonnegative = comparison_to_ast(AbstractComparison::new(">=", progress, zero))?;
        self.computer.solver.assert(nonnegative);
        for guard in guards {
            self.computer.solver.assert(guard);
        }
        for (i, register) in updates {
            self.computer.registers[i] = register;
        }
        self.computer.set_flags(flags);
        *expression = condition;
        Some((
            self.computer.get_state(),
            Generalization {
                steps,
                free_registers,
                free_flags,
            },
        ))
    }

    fn round_covers(
        &self,
        generalized: &ComputerState,
        next: &ComputerState,
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
        if !registers {
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
                                self.computer.solver.check_assumptions(&[was.eq(now).not()])
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
    ) -> Option<bool> {
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
            self.left_through = Some((exit_pc, prefix));
            return None;
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
        self.computer.solver.pop(1);
        let mut observed = self.pin_steps(&invariant_of_registers(&before.0, &after.0));
        self.assume_staying(&expression, active.entry_decision);
        self.pin_unknown_steps(&mut observed, &before.0, &after.0, &expression);
        self.computer.solver.pop(1);
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
            });
        if !ghosts_repeat {
            log::info!("{} guard operand did not repeat its step", active.id);
        }
        let checked_from = active
            .journal_after_summary
            .min(self.computer.write_journal.len());
        let mut rewritten = cells_written(&self.computer.write_journal[checked_from..]);
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
        let holds = cells_hold
            && steps_hold
            && ghosts_repeat
            && active
                .invariants
                .iter()
                .zip(observed.iter())
                .all(|(recorded, seen)| recorded.subsumes(seen));

        let read_by_guard = registers_in(&expression);
        let shown = expression.clone();
        let leaving = comparison_to_ast(expression).map(|condition| {
            if active.entry_decision {
                condition
            } else {
                condition.not()
            }
        });
        let exits = leaving.as_ref().is_some_and(|leaving| {
            self.computer
                .solver
                .check_assumptions(std::slice::from_ref(leaving))
                == SatResult::Unsat
        });

        let unstable: Vec<usize> = active
            .invariants
            .iter()
            .zip(observed.iter())
            .enumerate()
            .filter(|(_, (recorded, seen))| !recorded.subsumes(seen))
            .map(|(i, _)| i)
            .collect();
        let only_data_moved = ghosts_repeat
            && unstable.iter().all(|&i| {
                [&active.entry_state.0[i], &active.state.0[i], &current.0[i]]
                    .into_iter()
                    .all(|r| !self.carries_region(r) && !read_by_guard.contains(r))
            });
        if !holds
            && !only_data_moved
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
        let retrying = !holds && self.widen_for_retry(&active, &observed);

        let above = if retrying {
            Vec::new()
        } else {
            self.scopes_above(active.scope_id)
        };
        self.pop_scope(active.scope_id);
        self.active_loops.pop();

        let closed = holds;
        if closed {
            let left_by = if active.entry_decision {
                shown.not()
            } else {
                shown.clone()
            };
            let counter = AbstractExpression::Abstract(format!("{}_?", active.id));
            if let (Some(left), Some(right)) =
                (Affine::of(&left_by.left), Affine::of(&left_by.right))
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
            let mut kept: Vec<ast::Bool> = leaving.iter().map(|l| l.not().simplify()).collect();
            kept.extend(
                active
                    .facts
                    .iter()
                    .chain(&active.exit_facts)
                    .filter_map(summary_fact_to_ast),
            );
            kept.extend(active.nested_facts.iter().cloned());
            self.keep_facts(kept);
            self.jump_history.truncate(active.history_len);
            for record in &mut self.jump_history {
                record.resolved |= record.point.pc == active.pc;
            }
            self.loop_attempts.remove(&active.pc);
        }

        self.rebuild_scopes(above);

        if closed {
            if self.computer.solver.check() == SatResult::Unsat {
                log::info!(
                    "{} at line {} has no feasible exit on this path",
                    active.id,
                    active.pc
                );
                self.path_ends = true;
            }
            return Some(!active.entry_decision);
        }

        self.computer.set_state(active.entry_state);
        self.computer
            .undo_writes_since(active.journal_before_summary);
        if !cells_hold {
            let mut retries = self.cell_retries.borrow_mut();
            let used = retries.entry(active.pc).or_insert(0);
            if *used < MAX_CELL_RETRIES {
                *used += 1;
                self.loop_attempts.remove(&active.pc);
            }
        }
        self.jump_history.truncate(active.history_len);

        log::info!(
            "{} at line {} not closed: inductive={holds} exits={exits}",
            active.id,
            active.pc
        );
        log::info!("{} exit condition checked: {shown}", active.id);
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
        None
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
        assert!(engine.active_loops.is_empty());
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
