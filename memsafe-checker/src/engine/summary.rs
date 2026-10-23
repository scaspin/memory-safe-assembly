use super::*;

pub(super) const WIDEST_STORED_VALUE: i64 = 16;
const MAX_EXIT_WINDOW: i64 = 8;
pub(super) const MAX_SETTLING_CHOICES: usize = 64;
pub(super) const CANDIDATE_PROOF_RESOURCE_LIMIT: u32 = 50_000_000;
pub(super) const MAX_CELL_RETRIES: usize = 4;

#[derive(Debug, Clone)]
pub(super) struct Summary {
    pub(super) id: LoopId,
    pub(super) pc: usize,
    pub(super) label: Option<String>,
    pub(super) counter: LoopCounter,
    pub(super) invariants: Vec<LoopInvariant>,
    pub(super) updates: Vec<(usize, RegisterValue)>,
    pub(super) flags: [Option<FlagValue>; 4],
    pub(super) facts: Vec<AbstractComparison>,
    pub(super) exit_facts: Vec<AbstractComparison>,
    pub(super) landings: Vec<(AbstractComparison, AbstractComparison)>,
    pub(super) exits: Vec<(usize, bool)>,
    pub(super) branch_facts: Vec<(usize, AbstractComparison)>,
    pub(super) ranges: Vec<(String, i64)>,
    pub(super) ghost_checks: Vec<(Vec<bool>, AbstractExpression)>,
    pub(super) operand_checks: Vec<(Vec<bool>, usize)>,
    pub(super) continuing: AbstractComparison,
}

pub(super) fn value_of(r: &RegisterValue) -> AbstractExpression {
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

fn operand_index(
    operands: &[(RegisterValue, usize)],
    current: &[RegisterValue],
    r: &RegisterValue,
) -> Option<usize> {
    operands
        .iter()
        .find(|(value, _)| value == r)
        .map(|(_, i)| *i)
        .or_else(|| current.iter().position(|c| c == r))
}

pub(super) fn guard_operands(
    before: &AbstractComparison,
    after: &AbstractComparison,
    previous: &[RegisterValue],
    current: &[RegisterValue],
) -> Vec<(RegisterValue, usize)> {
    pub(super) fn pair(
        before: &AbstractExpression,
        after: &AbstractExpression,
        states: (&[RegisterValue], &[RegisterValue]),
        found: &mut Vec<(RegisterValue, usize)>,
    ) {
        match (before, after) {
            (AbstractExpression::Register(was), AbstractExpression::Register(is)) => {
                let (previous, current) = states;
                let moved_alike = |i: &usize| previous[*i] == **was && current[*i] == **is;
                let first = current.iter().position(|c| c == &**is);
                if first.is_some_and(|i| !moved_alike(&i))
                    && let Some(i) = (0..current.len()).find(moved_alike)
                {
                    found.push(((**is).clone(), i));
                }
            }
            (
                AbstractExpression::Expression(op_before, left_before, right_before),
                AbstractExpression::Expression(op_after, left_after, right_after),
            ) if op_before == op_after => {
                pair(left_before, left_after, states, found);
                pair(right_before, right_after, states, found);
            }
            _ => (),
        }
    }
    let mut found = Vec::new();
    if before.op == after.op {
        pair(&before.left, &after.left, (previous, current), &mut found);
        pair(&before.right, &after.right, (previous, current), &mut found);
    }
    found
}

pub(super) fn anchored(
    e: &AbstractExpression,
    (current, previous, operands): (
        &[RegisterValue],
        &[RegisterValue],
        &[(RegisterValue, usize)],
    ),
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
            let found = operand_index(operands, current, r)
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
            anchored(a, (current, previous, operands), invariants, ghosts),
            anchored(b, (current, previous, operands), invariants, ghosts),
        ),
        other => other.clone(),
    }
}

pub(super) fn word_view(register: &RegisterValue) -> RegisterValue {
    let (base, offset) = narrow_to_32(register.base.clone(), register.offset);
    RegisterValue::new(register.kind.clone(), base, offset)
}

pub(super) fn at_summary(
    e: &AbstractExpression,
    (current, previous, operands): (
        &[RegisterValue],
        &[RegisterValue],
        &[(RegisterValue, usize)],
    ),
    updates: &[(usize, RegisterValue)],
) -> AbstractExpression {
    match e {
        AbstractExpression::Register(r) => {
            let index = operand_index(operands, current, r)
                .or_else(|| previous.iter().position(|p| p == &**r));
            if let Some((_, rewritten)) = index.and_then(|i| updates.iter().find(|(j, _)| *j == i))
            {
                return AbstractExpression::Register(Box::new(rewritten.clone()));
            }
            let word = current.iter().position(|c| word_view(c) == **r);
            match word.and_then(|i| updates.iter().find(|(j, _)| *j == i)) {
                Some((_, rewritten)) => {
                    AbstractExpression::Register(Box::new(word_view(rewritten)))
                }
                None => e.clone(),
            }
        }
        AbstractExpression::Expression(op, a, b) => generate_expression(
            op,
            at_summary(a, (current, previous, operands), updates),
            at_summary(b, (current, previous, operands), updates),
        ),
        other => other.clone(),
    }
}

pub(super) fn flag_at_summary(
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

pub(super) fn shifted_leaves(
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

pub(super) fn negate_step(step: AbstractExpression) -> AbstractExpression {
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
pub(super) struct Ghost {
    pub(super) path: Vec<bool>,
    pub(super) value: RegisterValue,
    pub(super) step: i64,
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

pub(super) fn ghost_operands<F>(
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

pub(super) fn condition_side<'a>(
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

pub(super) fn ghost_at_summary(
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

pub(super) fn registers_in(condition: &AbstractComparison) -> Vec<RegisterValue> {
    register_leaves(condition)
        .into_iter()
        .map(|(_, register)| register)
        .collect()
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

pub(super) fn without_registers(e: &AbstractExpression) -> Option<AbstractExpression> {
    match e {
        AbstractExpression::Register(r) if r.kind == RegisterKind::Number => None,
        AbstractExpression::Register(r) => without_registers(&value_of(r)),
        AbstractExpression::Expression(op, left, right) => Some(generate_expression(
            op,
            without_registers(left)?,
            without_registers(right)?,
        )),
        other => Some(other.clone()),
    }
}

pub(super) fn counter_affine(
    e: &AbstractExpression,
    counter: &str,
) -> Option<(AbstractExpression, i64)> {
    match e {
        AbstractExpression::Abstract(name) if name == counter => {
            Some((AbstractExpression::Immediate(0), 1))
        }
        AbstractExpression::Expression(op, left, right)
            if matches!(op.as_str(), "+" | "-" | "*") =>
        {
            let (a, b) = (
                counter_affine(left, counter)?,
                counter_affine(right, counter)?,
            );
            match (op.as_str(), a, b) {
                ("+", (s, x), (t, y)) => Some((generate_expression("+", s, t), x.checked_add(y)?)),
                ("-", (s, x), (t, y)) => Some((generate_expression("-", s, t), x.checked_sub(y)?)),
                ("*", (s, 0), (t, 0)) => Some((generate_expression("*", s, t), 0)),
                ("*", (s, x), (AbstractExpression::Immediate(k), 0))
                | ("*", (AbstractExpression::Immediate(k), 0), (s, x)) => Some((
                    generate_expression("*", s, AbstractExpression::Immediate(k)),
                    x.checked_mul(k)?,
                )),
                _ => None,
            }
        }
        _ if e
            .get_abstracts()
            .iter()
            .any(|name| LoopSymbol::names_any(name)) =>
        {
            None
        }
        _ => Some((e.clone(), 0)),
    }
}

fn landing_requirements(
    op: &str,
    distance: &AbstractExpression,
    step: &AbstractExpression,
) -> Vec<AbstractComparison> {
    if is_ordered(op) && bound_toward(step).is_some() {
        return Vec::new();
    }
    let zero = AbstractExpression::Immediate(0);
    let (modulus, ahead) = match step {
        AbstractExpression::Immediate(0) => return Vec::new(),
        AbstractExpression::Immediate(n) => (
            AbstractExpression::Immediate(n.abs()),
            AbstractComparison::new(
                if *n > 0 { ">=" } else { "<=" },
                distance.clone(),
                zero.clone(),
            ),
        ),
        other => (
            other.clone(),
            AbstractComparison::new(
                ">=",
                generate_expression("*", distance.clone(), other.clone()),
                zero.clone(),
            ),
        ),
    };
    vec![
        AbstractComparison::new(
            "==",
            generate_expression("%", distance.clone(), modulus),
            zero,
        ),
        ahead,
    ]
}

fn is_unsigned(e: &AbstractExpression) -> bool {
    matches!(e, AbstractExpression::Expression(op, _, width)
        if op == "zext" && **width == AbstractExpression::Immediate(64))
}

pub(super) fn peel_unsigned(e: &AbstractExpression) -> &AbstractExpression {
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

pub(super) fn iterations_before_leaving(op: &str, step: i64, bound: i64) -> Option<i64> {
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

pub(super) fn continues_while_nonzero(
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

pub(super) fn at_least_zero(register: &RegisterValue) -> AbstractComparison {
    AbstractComparison::new(">=", value_of(register), AbstractExpression::Immediate(0))
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

pub(super) fn summary_fact_to_ast(fact: &AbstractComparison) -> Option<ast::Bool> {
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
    let requirements = landing_requirements(&branch.op, &distance, &step);
    let unwrapped = unwrapped_requirements(branch, record.taken, (exit, walker, &step), &distance);
    let mut facts = trip_facts(&branch.op, at_equality, distance, trips.clone(), &step);
    if let Some(landing) = facts.first() {
        landings.extend(
            requirements
                .into_iter()
                .map(|requirement| (requirement, landing.clone())),
        );
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

pub(super) fn leaf_path(
    condition: &AbstractComparison,
    target: &RegisterValue,
) -> Option<Vec<bool>> {
    register_leaves(condition)
        .into_iter()
        .find(|(_, register)| register == target)
        .map(|(path, _)| path)
}

pub(super) type GhostedRecord = (JumpRecord, Vec<Ghost>);

pub(super) fn branches_walked(loop_pc: usize, cycle: &[JumpRecord]) -> Vec<JumpRecord> {
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

pub(super) fn stepped_by_the_counter(
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

pub(super) fn cells_written(journal: &[CellWrite]) -> Vec<(MemoryCell, RegisterValue)> {
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

pub(super) fn summarize(
    id: LoopId,
    pc: usize,
    label: Option<String>,
    guard: (&AbstractComparison, &[Ghost], &[(RegisterValue, usize)]),
    continues_when: bool,
    invariants: Vec<LoopInvariant>,
    states: (
        &MachineState,
        &MachineState,
        &[GhostedRecord],
        &[GhostedRecord],
    ),
) -> Summary {
    let (condition, ghosts, operands) = guard;
    let (previous, current, cycle, walked) = states;
    let counter = LoopCounter::for_loop(id);

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
                let progress = counter.symbol(LoopRole::Progress(i)).expression();
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
                let symbol = counter.symbol(LoopRole::Within(i)).to_string();
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
                let widened =
                    RegisterValue::new_empty(&counter.symbol(LoopRole::Widened(i)).to_string());
                let confined = [&previous.0[i], cur].map(|r| {
                    r.base
                        .as_ref()
                        .filter(|_| r.offset == 0)
                        .and_then(confined_load_width)
                });
                updates.push((
                    i,
                    match confined {
                        [Some(before), Some(now)] if before == now => RegisterValue {
                            base: widened.base.map(|symbol| confined_load(symbol, now)),
                            ..widened
                        },
                        _ => widened,
                    },
                ));
            }
            LoopInvariant::Tracks(..) => {}
            LoopInvariant::NonDecreasing | LoopInvariant::NonIncreasing => {
                let progress = counter.symbol(LoopRole::Progress(i)).expression();
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
    let flag = |k: usize, prev: &Option<FlagValue>, cur: &Option<FlagValue>| match cur {
        Some(FlagValue::Abstract(c)) if prev != cur => match (
            flag_at_summary(&c.left, &current.0, &updates, &clobbered_operand),
            flag_at_summary(&c.right, &current.0, &updates, &clobbered_operand),
        ) {
            (Some(left), Some(right)) => Some(FlagValue::Abstract(AbstractComparison::new(
                &c.op, left, right,
            ))),
            _ => widen_flag(&counter.symbol(LoopRole::Status(k)).to_string(), prev, cur),
        },
        _ => widen_flag(&counter.symbol(LoopRole::Status(k)).to_string(), prev, cur),
    };
    let flags = [
        flag(0, &previous.1, &current.1),
        flag(1, &previous.2, &current.2),
        flag(2, &previous.3, &current.3),
        flag(3, &previous.4, &current.4),
    ];

    let mut facts = vec![AbstractComparison::new(
        ">",
        counter.expression(),
        AbstractExpression::Immediate(SUMMARY_ITERATION - 1),
    )];
    facts.extend(progress_facts);

    let index_of = |r: &RegisterValue| -> Option<usize> {
        operand_index(operands, &current.0, r).or_else(|| previous.0.iter().position(|c| c == r))
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
            anchored(
                exit,
                (&current.0, &previous.0, operands),
                &invariants,
                ghosts,
            ),
            anchored(
                peel_unsigned(walker),
                (&current.0, &previous.0, operands),
                &invariants,
                ghosts,
            ),
        );
        let requirements = landing_requirements(&condition.op, &distance, &step);
        let unwrapped =
            unwrapped_requirements(condition, continues_when, (exit, walker, &step), &distance);
        let totals = trip_facts(
            &condition.op,
            continues_at_equality(&condition.op, continues_when),
            distance,
            counter.total(),
            &step,
        );
        if let Some(landing) = totals.first() {
            landings.extend(
                requirements
                    .into_iter()
                    .map(|requirement| (requirement, landing.clone())),
            );
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
    let mut branch_facts = Vec::new();
    for (record, exit_ghosts) in cycle {
        let held = facts_for_exit(
            (record, exit_ghosts),
            &counter,
            &invariants,
            bounded,
            &mut landings,
        );
        branch_facts.extend(held.into_iter().map(|fact| (record.point.pc, fact)));
    }
    for (record, branch_ghosts) in walked {
        let held = held_on_the_cycle(
            (record, branch_ghosts),
            &counter,
            &invariants,
            &mut landings,
        );
        branch_facts.extend(held.map(|fact| (record.point.pc, fact)));
    }
    facts.extend(branch_facts.iter().map(|(_, fact)| fact.clone()));

    let side_at_summary = |on_left: bool, side: &AbstractExpression| {
        let substituted = ghosts
            .iter()
            .filter(|g| g.path[0] == on_left)
            .fold(side.clone(), |e, ghost| {
                replaced_at(&e, &ghost.path[1..], &ghost_at_summary(ghost, &counter, 0))
            });
        at_summary(&substituted, (&current.0, &previous.0, operands), &updates)
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
    let operand_checks = register_leaves(condition)
        .into_iter()
        .filter(|(_, r)| ghost_step(ghosts, r).is_none())
        .filter_map(|(path, r)| {
            let i = operand_index(operands, &current.0, &r)?;
            (invariants[i] != LoopInvariant::Fixed).then_some((path, i))
        })
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
        branch_facts,
        ranges,
        ghost_checks,
        operand_checks,
        continuing,
    }
}

fn register_leaves(condition: &AbstractComparison) -> Vec<(Vec<bool>, RegisterValue)> {
    pub(super) fn collect(
        e: &AbstractExpression,
        path: &mut Vec<bool>,
        found: &mut Vec<(Vec<bool>, RegisterValue)>,
    ) {
        match e {
            AbstractExpression::Register(r) => found.push((path.clone(), (**r).clone())),
            AbstractExpression::Expression(_, a, b) => {
                for (side, child) in [(true, a), (false, b)] {
                    path.push(side);
                    collect(child, path, found);
                    path.pop();
                }
            }
            _ => (),
        }
    }
    let mut found = Vec::new();
    for (side, e) in [(true, &condition.left), (false, &condition.right)] {
        collect(e, &mut vec![side], &mut found);
    }
    found
}

pub(super) fn exit_window(op: &str, per_iteration: i64) -> Vec<i64> {
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

pub(super) fn with_counter_at(
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

pub(super) fn comparison_with_counter_at(
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
pub(super) struct SettledSelectStep {
    pub(super) register: usize,
    pub(super) holds_the_select: bool,
    pub(super) condition: AbstractComparison,
    pub(super) rare: i64,
    pub(super) usual: i64,
}

pub(super) fn constant_value(e: &AbstractExpression) -> Option<i64> {
    linear_form(e).and_then(|form| form.terms.is_empty().then_some(form.constant))
}

#[derive(Debug, Clone)]
pub(super) struct LoopAttempt {
    pub(super) id: LoopId,
    pub(super) invariants: Vec<LoopInvariant>,
    pub(super) rounds: usize,
    pub(super) widened: bool,
    pub(super) rejected_bounds: Vec<String>,
}

#[derive(Debug, Clone, PartialEq)]
pub(super) struct Bound {
    pub(super) register: usize,
    pub(super) op: &'static str,
    pub(super) other: Option<usize>,
    pub(super) offset: i64,
    pub(super) anchor: Option<AbstractExpression>,
}

impl Bound {
    pub(super) fn at(&self, registers: &[RegisterValue]) -> AbstractComparison {
        let right = match (&self.other, &self.anchor) {
            (Some(j), _) => generate_expression(
                "+",
                registers[*j].expression(),
                AbstractExpression::Immediate(self.offset),
            ),
            (None, Some(anchor)) => anchor.clone(),
            (None, None) => unreachable!("a bound names another register or an anchor"),
        };
        AbstractComparison::new(self.op, registers[self.register].expression(), right)
    }

    pub(super) fn key(&self) -> String {
        if let Some(AbstractExpression::Immediate(limit)) = self.anchor {
            return format!("{}{}{limit}", self.register, self.op);
        }
        format!(
            "{}{}{:?}{}",
            self.register, self.op, self.other, self.offset
        )
    }
}

pub(super) fn bound_candidates(
    invariants: &[LoopInvariant],
    current: &[RegisterValue],
) -> Vec<Bound> {
    let mut candidates = Vec::new();
    for (i, invariant) in invariants.iter().enumerate() {
        if *invariant != LoopInvariant::Unknown || current[i].kind == RegisterKind::Number {
            continue;
        }
        let anchor = current[i].expression();
        for op in [">=", "<="] {
            candidates.push(Bound {
                register: i,
                op,
                other: None,
                offset: 0,
                anchor: Some(anchor.clone()),
            });
        }
        for (j, other) in invariants.iter().enumerate() {
            let LoopInvariant::Linear(AbstractExpression::Immediate(step)) = other else {
                continue;
            };
            if j == i || *step == 0 {
                continue;
            }
            let op = if *step > 0 { "<=" } else { ">=" };
            for offset in [0, -step] {
                candidates.push(Bound {
                    register: i,
                    op,
                    other: Some(j),
                    offset,
                    anchor: None,
                });
            }
        }
    }
    candidates
}

#[derive(Debug, Clone)]
pub(super) struct ActiveLoop {
    pub(super) id: LoopId,
    pub(super) instance: usize,
    pub(super) pc: usize,
    pub(super) depth: usize,
    pub(super) scope_id: usize,
    pub(super) entry_decision: bool,
    pub(super) invariants: Vec<LoopInvariant>,
    pub(super) exit_facts: Vec<AbstractComparison>,
    pub(super) state: MachineState,
    pub(super) entry_state: MachineState,
    pub(super) history_len: usize,
    pub(super) facts: Vec<AbstractComparison>,
    pub(super) exits: Vec<(usize, bool)>,
    pub(super) branch_facts: Vec<(usize, AbstractComparison)>,
    pub(super) round: usize,
    pub(super) nested_facts: Vec<ast::Bool>,
    pub(super) fresh_bounds_at_entry: usize,
    pub(super) ghost_checks: Vec<(Vec<bool>, AbstractExpression)>,
    pub(super) operand_checks: Vec<(Vec<bool>, usize)>,
    pub(super) cells: Vec<(MemoryCell, LoopInvariant)>,
    pub(super) journal_after_summary: usize,
    pub(super) blind_writes_at_summary: usize,
    pub(super) slots: Vec<SymbolicSlot>,
    pub(super) settled_steps: Vec<SettledSelectStep>,
    pub(super) continuing: AbstractComparison,
    pub(super) bounds: Vec<Bound>,
}

#[derive(Debug, Clone)]
pub(super) struct RoundEntry {
    pub(super) exit: usize,
    pub(super) state: MachineState,
    pub(super) generalization: Option<Generalization>,
}

#[derive(Debug, Clone)]
pub(super) struct Generalization {
    pub(super) steps: Vec<(usize, i64)>,
    pub(super) free_registers: Vec<usize>,
    pub(super) free_flags: Vec<usize>,
    pub(super) nonnegative: Vec<usize>,
}
