use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn rows_of_sixteen_byte_stores(
    region_length: AbstractExpression,
    width_multiple: i64,
) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "row:",
        "mov w8, w3",
        "column:",
        "str q0, [x0], #16",
        "subs w8, w8, #16",
        "b.gt column",
        "sub x0, x0, x3",
        "add x0, x0, x1",
        "subs w4, w4, #1",
        "b.gt row",
        "ret",
    ]
    .iter()
    .map(|line| line.to_string())
    .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "dst");
    engine.add_abstract_from(1, "stride");
    engine.add_abstract_from(3, "w");
    engine.add_abstract_from(4, "h");
    engine.add_region(RegionType::RW, "dst", region_length);
    for (op, left, right) in [
        (">=", symbol("w"), AbstractExpression::Immediate(32)),
        ("<=", symbol("w"), AbstractExpression::Immediate(128)),
        (
            "==",
            generate_expression(
                "%",
                symbol("w"),
                AbstractExpression::Immediate(width_multiple),
            ),
            AbstractExpression::Immediate(0),
        ),
        (">=", symbol("stride"), symbol("w")),
        (
            "<=",
            symbol("stride"),
            AbstractExpression::Immediate(1 << 20),
        ),
        (">=", symbol("h"), AbstractExpression::Immediate(1)),
        ("<=", symbol("h"), AbstractExpression::Immediate(128)),
    ] {
        engine.add_invariant(AbstractComparison::new(op, left, right));
    }
    engine.start("start").map_err(|e| e.to_string())
}

fn rows_times_stride(slack: i64) -> AbstractExpression {
    generate_expression(
        "+",
        generate_expression("*", symbol("stride"), symbol("h")),
        AbstractExpression::Immediate(slack),
    )
}

#[test]
fn rows_of_whole_sixteen_byte_columns_stay_in_their_image() {
    assert_eq!(
        rows_of_sixteen_byte_stores(rows_times_stride(0), 16),
        Ok(())
    );
}

#[test]
fn the_same_rows_into_an_image_one_byte_short_are_rejected() {
    assert!(rows_of_sixteen_byte_stores(rows_times_stride(-1), 16).is_err());
}

#[test]
fn a_width_that_is_not_a_whole_number_of_columns_overruns_its_row() {
    assert!(rows_of_sixteen_byte_stores(rows_times_stride(0), 8).is_err());
}
