use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn reads_after_round_trip(facts: &[(&str, AbstractExpression)]) -> bool {
    init();
    let program = [
        "start:",
        "lsl x2, x1, #1",
        "lsr x2, x2, #1",
        "ldrb w3, [x0, x2]",
        "ret",
    ]
    .map(String::from)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "buf");
    engine.add_abstract_from(1, "index");
    engine.add_region(RegionType::READ, "buf", symbol("n"));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        symbol("n"),
        AbstractExpression::Immediate(1 << 40),
    ));
    for (op, right) in facts {
        engine.add_invariant(AbstractComparison::new(op, symbol("index"), right.clone()));
    }
    engine.start("start").is_ok()
}

#[test]
fn an_index_shifted_out_and_back_reads_where_it_points() {
    assert!(reads_after_round_trip(&[
        (">=", AbstractExpression::Immediate(0)),
        ("<", symbol("n")),
    ]));
}

#[test]
fn an_index_shifted_out_and_back_past_the_end_is_rejected() {
    assert!(!reads_after_round_trip(&[
        (">=", AbstractExpression::Immediate(0)),
        ("<=", symbol("n")),
    ]));
}

#[test]
fn a_negative_index_shifted_out_and_back_is_rejected() {
    assert!(!reads_after_round_trip(&[
        (">=", AbstractExpression::Immediate(-5)),
        ("<", symbol("n")),
    ]));
}
