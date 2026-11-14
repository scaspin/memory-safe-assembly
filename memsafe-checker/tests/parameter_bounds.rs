use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn engine_reading_byte_at_word_index(
    length: i64,
    largest_index: Option<i64>,
) -> bums::engine::ExecutionEngine {
    init();
    let program = ["start:", "ldrb w2, [x1, w0, uxtw]", "ret"]
        .map(String::from)
        .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "n");
    engine.add_abstract_from(1, "buf");
    engine.add_region(RegionType::RW, "buf", AbstractExpression::Immediate(length));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        AbstractExpression::Abstract("n".to_string()),
        AbstractExpression::Immediate(0),
    ));
    if let Some(largest) = largest_index {
        engine.add_invariant(AbstractComparison::new(
            "<=",
            AbstractExpression::Abstract("n".to_string()),
            AbstractExpression::Immediate(largest),
        ));
    }
    engine
}

#[test]
fn a_declared_bound_on_a_parameter_proves_its_word_view_in_range() {
    let mut engine = engine_reading_byte_at_word_index(16, Some(15));
    assert!(engine.start("start").is_ok());
}

#[test]
fn a_declared_bound_one_past_the_region_is_still_rejected() {
    let mut engine = engine_reading_byte_at_word_index(16, Some(16));
    assert!(engine.start("start").is_err());
}
