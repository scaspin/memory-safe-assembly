use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn padded_rows(row_advance: &[&str], least_stride: AbstractExpression) -> bool {
    init();
    let before = [
        "start:",
        "lsl x1, x1, #1",
        "lsr x1, x1, #1",
        "sub x1, x1, w3, uxtw",
        "mov w12, w3",
        "row:",
        "ands w5, w3, #0xf",
        "b.eq chunks",
        "sub w3, w3, w5",
        "st1 {v31.16b}, [x0]",
        "add x0, x0, w5, uxtw",
        "chunks:",
        "subs w3, w3, #0x10",
        "st1 {v31.16b}, [x0], #16",
        "b.gt chunks",
        "subs w4, w4, #0x1",
    ];
    let after = ["b.le done", "mov w3, w12", "b row", "done:", "ret"];
    let program: Vec<String> = before
        .iter()
        .chain(row_advance)
        .chain(after.iter())
        .map(|line| line.to_string())
        .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "dst");
    engine.add_abstract_from(1, "stride");
    engine.add_abstract_from(3, "width");
    engine.add_abstract_from(4, "height");
    engine.add_region(
        RegionType::WRITE,
        "dst",
        generate_expression("*", symbol("stride"), symbol("height")),
    );
    let facts = [
        (">=", symbol("width"), AbstractExpression::Immediate(17)),
        ("<=", symbol("width"), AbstractExpression::Immediate(64)),
        (">=", symbol("height"), AbstractExpression::Immediate(1)),
        (
            "<=",
            symbol("height"),
            AbstractExpression::Immediate(1 << 16),
        ),
        (">=", symbol("stride"), least_stride),
        (
            "<=",
            symbol("stride"),
            AbstractExpression::Immediate(1 << 20),
        ),
    ];
    for (op, left, right) in facts {
        engine.add_invariant(AbstractComparison::new(op, left, right));
    }
    engine.start("start").is_ok()
}

#[test]
fn rows_padded_in_a_partial_chunk_then_whole_chunks_stay_in_bounds() {
    assert!(padded_rows(&["add x0, x0, x1"], symbol("width")));
}

#[test]
fn padded_rows_wider_than_the_stride_are_rejected() {
    assert!(!padded_rows(
        &["add x0, x0, x1"],
        generate_expression("-", symbol("width"), AbstractExpression::Immediate(1)),
    ));
}

#[test]
fn padded_rows_that_drift_a_byte_each_row_are_rejected() {
    assert!(!padded_rows(
        &["add x0, x0, x1", "add x0, x0, #1"],
        symbol("width")
    ));
}
