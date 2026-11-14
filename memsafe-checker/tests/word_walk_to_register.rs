use bums::common::*;

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn immediate(value: i64) -> AbstractExpression {
    AbstractExpression::Immediate(value)
}

fn walk_up_to_a_register(end_past_length: i64, lowest_start: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let program: Vec<String> = [
        "start:",
        "mov w11, w6",
        "walk:",
        "ldrb w9, [x0, x11]",
        "add w11, w11, #1",
        "cmp w11, w7",
        "b.lt walk",
        "ret",
    ]
    .iter()
    .map(|line| line.to_string())
    .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "buf");
    engine.add_abstract_from(6, "first");
    engine.add_abstract_from(7, "end");
    engine.add_abstract_from(1, "len");
    engine.add_region(RegionType::READ, "buf", symbol("len"));
    for (op, left, right) in [
        (">=", symbol("first"), immediate(lowest_start)),
        ("<", symbol("first"), symbol("end")),
        (
            "<=",
            symbol("end"),
            generate_expression("+", symbol("len"), immediate(end_past_length)),
        ),
        ("<=", symbol("len"), immediate(1 << 14)),
    ] {
        engine.add_invariant(AbstractComparison::new(op, left, right));
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_word_index_walking_up_to_a_register_bound_stays_in_its_buffer() {
    assert_eq!(walk_up_to_a_register(0, 0), Ok(()));
}

#[test]
fn a_word_index_walking_one_past_the_buffer_is_rejected() {
    assert!(walk_up_to_a_register(1, 0).is_err());
}

#[test]
fn a_word_index_starting_below_the_buffer_is_rejected() {
    assert!(walk_up_to_a_register(0, -1).is_err());
}
