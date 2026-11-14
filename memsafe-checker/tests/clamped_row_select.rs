use bums::common::*;

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn immediate(value: i64) -> AbstractExpression {
    AbstractExpression::Immediate(value)
}

fn store_at_clamped_row(upper_clamp: &str, slack: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let program: Vec<String> = [
        "start:",
        "neg x5, x1",
        "bic x5, x5, x5, asr #63",
        "sub x12, x2, #1",
        "cmp x5, x2",
        &format!("csel x5, x5, {upper_clamp}, lt"),
        "madd x6, x5, x7, x0",
        "str q0, [x6]",
        "ret",
    ]
    .iter()
    .map(|line| line.to_string())
    .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "dst");
    engine.add_abstract_from(1, "y");
    engine.add_abstract_from(2, "h");
    engine.add_abstract_from(7, "stride");
    engine.add_region(
        RegionType::RW,
        "dst",
        generate_expression(
            "+",
            generate_expression("*", symbol("stride"), symbol("h")),
            immediate(slack),
        ),
    );
    for (op, left, right) in [
        (">=", symbol("y"), immediate(-(1 << 16))),
        ("<=", symbol("y"), immediate(1 << 16)),
        (">=", symbol("h"), immediate(1)),
        ("<=", symbol("h"), immediate(1 << 16)),
        (">=", symbol("stride"), immediate(16)),
        ("<=", symbol("stride"), immediate(1 << 16)),
    ] {
        engine.add_invariant(AbstractComparison::new(op, left, right));
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_row_clamped_below_the_height_stays_in_the_image() {
    assert_eq!(store_at_clamped_row("x12", 0), Ok(()));
}

#[test]
fn a_row_clamped_to_the_height_itself_is_rejected() {
    assert!(store_at_clamped_row("x2", 0).is_err());
}

#[test]
fn a_clamped_row_into_an_image_one_byte_short_is_rejected() {
    assert!(store_at_clamped_row("x12", -1).is_err());
}
