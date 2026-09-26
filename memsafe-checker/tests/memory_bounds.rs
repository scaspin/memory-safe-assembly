
use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

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

#[test]
fn access_width_past_the_end_is_caught() {
    let region = AbstractExpression::Immediate(64);
    assert!(!accepts(region.clone(), "ldr x2,[x0,#63]", None));
    assert!(!accepts(region.clone(), "str x2,[x0,#63]", None));
    assert!(!accepts(region.clone(), "ldr w2,[x0,#63]", None));
    assert!(!accepts(region.clone(), "ldrh w2,[x0,#63]", None));
    assert!(!accepts(region.clone(), "strh w2,[x0,#63]", None));
    assert!(accepts(region.clone(), "ldrh w2,[x0,#62]", None));
    assert!(accepts(region.clone(), "ldr x2,[x0,#56]", None));
    assert!(!accepts(region.clone(), "ldr x2,[x0,#57]", None));
    assert!(accepts(region.clone(), "ldr w2,[x0,#60]", None));
    assert!(!accepts(region.clone(), "ldr w2,[x0,#61]", None));
    assert!(accepts(region, "ldrb w2,[x0,#63]", None));
}

fn accepts_shifted_index(region: i64, least: i64, greatest: i64, extra: i64) -> bool {
    init();
    let program = vec![
        "start:".to_string(),
        "add x3,x0,x1,lsl#4".to_string(),
        format!("ldr x2,[x3,#{extra}]"),
        "ret".to_string(),
    ];
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(
        RegionType::READ,
        "base",
        AbstractExpression::Immediate(region),
    );
    engine.add_abstract_from(1, "rounds");
    for (op, bound) in [(">=", least), ("<=", greatest)] {
        engine.add_invariant(AbstractComparison::new(
            op,
            abstract_of("rounds"),
            AbstractExpression::Immediate(bound),
        ));
    }
    engine.start("start").is_ok()
}

#[test]
fn a_bounded_index_shifted_left_stays_a_bounded_address() {
    assert!(accepts_shifted_index(244, 10, 14, 8));
    assert!(!accepts_shifted_index(244, 10, 15, 8));
    assert!(!accepts_shifted_index(244, 10, i64::MAX, 8));
}

#[test]
fn pair_access_checks_its_second_half() {
    assert!(!accepts(
        AbstractExpression::Immediate(64),
        "ldp x2,x3,[x0,#56]",
        None
    ));
}

fn x0_offset_after(access: &str) -> i64 {
    init();
    let program = vec!["start:".to_string(), access.to_string(), "ret".to_string()];
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Immediate(256),
    );
    engine.start("start".to_string()).expect("runs");
    engine.get_register_output(0).offset
}

#[test]
fn ld1r_post_index_advances_the_pointer() {
    assert_eq!(x0_offset_after("ld1r {v26.2d},[x0],#8"), 8);
}

#[test]
fn ld4r_post_index_advances_the_pointer() {
    assert_eq!(
        x0_offset_after("ld4r {v0.4s,v1.4s,v2.4s,v3.4s},[x0],#16"),
        16
    );
}

#[test]
fn ld1r_without_writeback_leaves_the_pointer() {
    assert_eq!(x0_offset_after("ld1r {v26.2d},[x0]"), 0);
}

fn accepts_scaled_index(index: i64) -> bool {
    init();
    let program: Vec<String> = [
        "start:".to_string(),
        format!("mov x1, #{index}"),
        "ldr x2,[x0,x1,lsl #3]".to_string(),
        "ret".to_string(),
    ]
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Immediate(64),
    );
    engine.start("start".to_string()).is_ok()
}

#[test]
fn a_shifted_register_index_is_scaled() {
    assert!(accepts_scaled_index(7));
    assert!(!accepts_scaled_index(8));
}
