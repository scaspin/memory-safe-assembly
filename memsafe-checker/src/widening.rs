// Classifies how state components change across loop iterations, independent of
// any acceleration strategy and without consulting the solver.

use crate::common::*;
use std::fmt;

// An opaque identity handed out when detection decides something is a loop. Neither pc
// nor a label works as the key: pc does not line up with source lines, and disassembled
// input yields label+offset forms once non-external labels are discarded.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
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

// A fresh symbol standing for how many iterations a loop has run.
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
}

// What holds for one state component across iterations.
#[derive(Debug, Clone, PartialEq)]
pub enum LoopInvariant {
    Fixed,
    Linear(AbstractExpression),
    Unknown,
}

impl LoopInvariant {
    // Unknown covers everything, and the precise elements only cover themselves.
    pub fn subsumes(&self, other: &LoopInvariant) -> bool {
        matches!(self, LoopInvariant::Unknown) || self == other
    }

    // Least element covering both, which is Unknown unless they already agree.
    pub fn join(&self, other: &LoopInvariant) -> LoopInvariant {
        if self == other {
            self.clone()
        } else {
            LoopInvariant::Unknown
        }
    }
}

// Recognises `cur == prev + k` for a literal k.
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

// A changed base is Unknown, not Fixed: only the offset delta is expressible.
pub fn invariant_of_register(prev: &RegisterValue, cur: &RegisterValue) -> LoopInvariant {
    if prev.base != cur.base {
        return LoopInvariant::Unknown;
    }
    match cur.offset.checked_sub(prev.offset) {
        Some(0) => LoopInvariant::Fixed,
        Some(step) => LoopInvariant::Linear(AbstractExpression::Immediate(step)),
        None => LoopInvariant::Unknown,
    }
}

// Componentwise join, so a retry can only weaken what an earlier attempt claimed.
pub fn join_all(a: &[LoopInvariant], b: &[LoopInvariant]) -> Vec<LoopInvariant> {
    a.iter().zip(b.iter()).map(|(x, y)| x.join(y)).collect()
}

// How many times a componentwise join can strictly ascend: the lattice is flat, so each
// component moves at most once, to Unknown.
pub fn max_ascents(components: usize) -> usize {
    components
}

pub fn invariant_of_registers(prev: &[RegisterValue], cur: &[RegisterValue]) -> Vec<LoopInvariant> {
    prev.iter()
        .zip(cur.iter())
        .map(|(p, c)| invariant_of_register(p, c))
        .collect()
}

// Flags are re-derived by the next comparison, so a flag that changed across the back
// edge is widened rather than carried forward. None stays None: it is the unset error
// state, not top, and widening it would hide an instruction that was never modelled.
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

// Value after `counter` iterations of `step`, starting from `anchor`.
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

    // The defect this classification exists to prevent.
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

    // An immediate counter carries its whole value in the offset.
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

    // Fixed and Linear are different claims, so neither covers the other.
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

    // The lattice is flat, so any disagreement goes straight to Unknown.
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

    // Joining is idempotent, so a round that adds nothing leaves the vector unchanged.
    #[test]
    fn join_all_is_idempotent() {
        let a = [
            LoopInvariant::Linear(AbstractExpression::Immediate(4)),
            LoopInvariant::Unknown,
        ];
        assert_eq!(join_all(&a, &a), a.to_vec());
    }

    // Once a component is Unknown it cannot move again, which is what bounds the rounds.
    #[test]
    fn unknown_absorbs() {
        let a = [LoopInvariant::Unknown];
        let b = [LoopInvariant::Fixed];
        assert_eq!(join_all(&a, &b), vec![LoopInvariant::Unknown]);
        assert_eq!(join_all(&b, &a), vec![LoopInvariant::Unknown]);
    }

    // A vector can ascend at most once per component before it is all Unknown.
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

    // A flag first set inside the loop is not invariant just because it was unset before.
    #[test]
    fn newly_set_flag_is_widened() {
        assert_eq!(widen_flag("w", &None, &flag("a")), flag("w"));
    }

    // None is the unset error state, not top, so widening must never produce or hide it.
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
