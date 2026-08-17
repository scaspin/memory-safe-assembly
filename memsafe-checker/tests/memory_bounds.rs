// Pins the byte extent of a memory region and the width of an access.

use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

// Single byte access, so the extent is measured without the access width.
fn accepts_byte_at(length: AbstractExpression, offset: i64) -> bool {
    accepts(length, &format!("ldrb w2,[x0,#{offset}]"), None)
}

fn accepts(length: AbstractExpression, access: &str, bound: Option<AbstractComparison>) -> bool {
    init();
    let program = vec!["start:".to_string(), access.to_string(), "ret".to_string()];
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(RegionType::RW, "base".to_string(), length);
    if let Some(bound) = bound {
        engine.add_invariant(bound);
    }
    engine.start("start".to_string()).is_ok()
}

fn length_is(n: i64) -> AbstractComparison {
    AbstractComparison::new(
        "==",
        AbstractExpression::Abstract("length".to_string()),
        AbstractExpression::Immediate(n),
    )
}

#[test]
fn immediate_region_length_is_in_bytes() {
    for n in [1, 2, 8, 16, 64, 128] {
        assert!(
            accepts_byte_at(AbstractExpression::Immediate(n), n - 1),
            "Immediate({n}) rejected offset {}",
            n - 1
        );
        assert!(
            !accepts_byte_at(AbstractExpression::Immediate(n), n),
            "Immediate({n}) accepted offset {n}"
        );
    }
}

// An abstract length is used directly, so its unit really is bytes.
#[test]
fn abstract_region_length_is_in_bytes() {
    let length = AbstractExpression::Abstract("length".to_string());
    assert!(accepts(
        length.clone(),
        "ldrb w2,[x0,#63]",
        Some(length_is(64))
    ));
    assert!(!accepts(length, "ldrb w2,[x0,#64]", Some(length_is(64))));
}

#[test]
fn negative_offset_is_rejected() {
    assert!(!accepts_byte_at(AbstractExpression::Immediate(64), -1));
}

// An access is checked across every byte it touches, not just its first.
#[test]
fn access_width_past_the_end_is_caught() {
    let region = AbstractExpression::Immediate(64);
    assert!(!accepts(region.clone(), "ldr x2,[x0,#63]", None));
    assert!(!accepts(region.clone(), "str x2,[x0,#63]", None));
    assert!(!accepts(region.clone(), "ldr w2,[x0,#63]", None));
    assert!(!accepts(region.clone(), "ldrh w2,[x0,#63]", None));
    assert!(!accepts(region.clone(), "strh w2,[x0,#63]", None));
    assert!(accepts(region.clone(), "ldrh w2,[x0,#62]", None));
    // The widest access that still fits, and the narrowest that does not.
    assert!(accepts(region.clone(), "ldr x2,[x0,#56]", None));
    assert!(!accepts(region.clone(), "ldr x2,[x0,#57]", None));
    assert!(accepts(region.clone(), "ldr w2,[x0,#60]", None));
    assert!(!accepts(region.clone(), "ldr w2,[x0,#61]", None));
    assert!(accepts(region, "ldrb w2,[x0,#63]", None));
}

// A pair is modelled as two accesses, so its second half is checked.
#[test]
fn pair_access_checks_its_second_half() {
    assert!(!accepts(
        AbstractExpression::Immediate(64),
        "ldp x2,x3,[x0,#56]",
        None
    ));
}
