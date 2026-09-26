
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

fn register_form(register: &RegisterValue) -> Option<LinearForm> {
    match &register.base {
        None if register.kind == RegisterKind::Number => None,
        None => Some(LinearForm::constant(register.offset)),
        Some(base) => linear_form(base)?.combine(&LinearForm::constant(register.offset), 1),
    }
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

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
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

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct LoopCounter {
    name: String,
}

impl LoopCounter {
    pub fn new(name: impl Into<String>) -> Self {
        Self { name: name.into() }
    }

    pub fn for_loop(id: LoopId) -> Self {
        Self::new(format!("{id}_?"))
    }

    pub fn name(&self) -> &str {
        &self.name
    }

    pub fn expression(&self) -> AbstractExpression {
        AbstractExpression::Abstract(self.name.clone())
    }

    pub fn total(&self) -> AbstractExpression {
        AbstractExpression::Abstract(format!("{}_trips", self.name))
    }

    pub fn total_for(&self, exit: usize) -> AbstractExpression {
        AbstractExpression::Abstract(format!("{}_trips{exit}", self.name))
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum LoopInvariant {
    Fixed,
    Linear(AbstractExpression),
    AtMost(i64),
    Within(i64),
    Tracks(usize, i64),
    NonDecreasing,
    NonIncreasing,
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

    pub fn subsumes(&self, other: &LoopInvariant) -> bool {
        if matches!(self, LoopInvariant::Unknown) || self == other {
            return true;
        }
        match (self, other) {
            (LoopInvariant::Within(bound), LoopInvariant::Within(seen)) => seen <= bound,
            (LoopInvariant::Within(_), LoopInvariant::Fixed) => true,
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
            self.clone()
        } else {
            LoopInvariant::Unknown
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

fn symbolic_step(
    prev: &AbstractExpression,
    cur: &AbstractExpression,
) -> Option<AbstractExpression> {
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
    None
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
        {
            return LoopInvariant::Linear(step);
        }
        return LoopInvariant::Unknown;
    }
    match cur.offset.checked_sub(prev.offset) {
        Some(0) => LoopInvariant::Fixed,
        Some(step) => LoopInvariant::Linear(AbstractExpression::Immediate(step)),
        None => LoopInvariant::Unknown,
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
        LoopCounter::new("loop_?")
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
                    AbstractExpression::Abstract("loop_?".to_string()),
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
}
