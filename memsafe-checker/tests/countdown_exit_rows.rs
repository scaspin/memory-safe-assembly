use bums::common::*;

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn immediate(value: i64) -> AbstractExpression {
    AbstractExpression::Immediate(value)
}

fn rows_then_one_more(lines: &[&str], extra_rows: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut program = vec!["start:".to_string()];
    program.extend(lines.iter().map(|line| line.to_string()));
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "dst");
    engine.add_abstract_from(1, "h");
    engine.add_abstract_from(2, "cap");
    engine.add_abstract_from(7, "stride");
    engine.add_region(
        RegionType::RW,
        "dst",
        generate_expression(
            "*",
            symbol("stride"),
            generate_expression("+", symbol("h"), immediate(extra_rows)),
        ),
    );
    for (op, left, right) in [
        (">=", symbol("h"), immediate(2)),
        ("<=", symbol("h"), immediate(1 << 16)),
        (">=", symbol("cap"), immediate(1)),
        ("<=", symbol("cap"), immediate(1 << 16)),
        (">=", symbol("stride"), immediate(16)),
        ("<=", symbol("stride"), immediate(1 << 16)),
    ] {
        engine.add_invariant(AbstractComparison::new(op, left, right));
    }
    engine.start("start").map_err(|e| e.to_string())
}

const COUNTDOWN_THEN_ROW: [&str; 8] = [
    "mov x6, x0",
    "row:",
    "str q0, [x6]",
    "subs x1, x1, #1",
    "add x6, x6, x7",
    "b.gt row",
    "str q0, [x6]",
    "ret",
];

const CLAMPED_COUNTDOWN_THEN_ROW: [&str; 11] = [
    "cmp x1, x2",
    "mov x3, #2",
    "csel x1, x1, x3, lt",
    "mov x6, x0",
    "row:",
    "str q0, [x6]",
    "subs x1, x1, #1",
    "add x6, x6, x7",
    "b.gt row",
    "str q0, [x6]",
    "ret",
];

#[test]
fn a_row_past_a_countdown_lands_on_the_next_row() {
    assert_eq!(rows_then_one_more(&COUNTDOWN_THEN_ROW, 1), Ok(()));
}

#[test]
fn a_row_past_a_countdown_into_an_image_without_it_is_rejected() {
    assert!(rows_then_one_more(&COUNTDOWN_THEN_ROW, 0).is_err());
}

#[test]
fn a_row_past_a_selected_countdown_lands_on_the_next_row() {
    assert_eq!(rows_then_one_more(&CLAMPED_COUNTDOWN_THEN_ROW, 1), Ok(()));
}

#[test]
fn a_row_past_a_selected_countdown_into_an_image_without_it_is_rejected() {
    assert!(rows_then_one_more(&CLAMPED_COUNTDOWN_THEN_ROW, 0).is_err());
}
