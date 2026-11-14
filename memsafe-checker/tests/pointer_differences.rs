use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn accepts(tail: &[&str]) -> bool {
    init();
    let program: Vec<String> = [
        "start:",
        "add x4, x1, x0",
        "mov x3, x1",
        "mov w6, #0",
        "walk:",
        "cmp x3, x4",
        "b.hs done",
        "ldrb w7, [x3]",
        "add x3, x3, #1",
        "sub w5, w4, w3",
        "lsl w5, w5, #3",
        "add w6, w6, w5",
        "cbnz w7, walk",
        "done:",
    ]
    .iter()
    .chain(tail.iter())
    .chain(["ret"].iter())
    .map(|line| line.to_string())
    .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "n");
    engine.add_abstract_from(1, "buf");
    engine.add_region(
        RegionType::READ,
        "buf",
        AbstractExpression::Abstract("n".to_string()),
    );
    engine.add_invariant(AbstractComparison::new(
        ">=",
        AbstractExpression::Abstract("n".to_string()),
        AbstractExpression::Immediate(1),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<",
        AbstractExpression::Abstract("n".to_string()),
        AbstractExpression::Immediate(1 << 20),
    ));
    engine.start("start").is_ok()
}

#[test]
fn a_count_built_from_pointer_differences_does_not_stop_the_summary() {
    assert!(accepts(&[]));
}

#[test]
fn reading_at_an_accumulated_pointer_difference_is_rejected() {
    assert!(!accepts(&["ldrb w8, [x1, w6, uxtw]"]));
}

#[test]
fn reading_past_the_walked_pointer_is_rejected() {
    assert!(!accepts(&["ldrb w8, [x3]"]));
}
