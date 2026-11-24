use bums::common::*;
use bums::engine::ExecutionEngine;

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn number(value: i64) -> AbstractExpression {
    AbstractExpression::Immediate(value)
}

fn rows_scanned_until_a_hit(before_loop: &[&str], rows_granted: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut program = vec!["start:".to_string()];
    program.extend(before_loop.iter().map(|l| l.to_string()));
    program.extend(
        [
            "row:",
            "ldr q5, [x0]",
            "umaxv b17, v5.16b",
            "subs x5, x5, #1",
            "umov w9, v17.b[0]",
            "add x0, x0, x1",
            "cbnz w9, hit",
            "b.gt row",
            "mov x0, #0",
            "ret",
            "hit:",
            "mov x0, #1",
            "ret",
        ]
        .iter()
        .map(|l| l.to_string()),
    );

    let mut engine = ExecutionEngine::new(program);
    engine.add_abstract_from(0, "data".to_string());
    engine.add_abstract_from(1, "stride".to_string());
    engine.add_abstract_from(5, "rows".to_string());
    engine.add_region(
        RegionType::READ,
        "data".to_string(),
        generate_expression(
            "+",
            generate_expression(
                "*",
                generate_expression("-", symbol("rows"), number(rows_granted)),
                symbol("stride"),
            ),
            number(16),
        ),
    );
    for (name, op, bound) in [
        ("rows", ">=", 2),
        ("rows", "<=", 16384),
        ("stride", ">=", 16),
        ("stride", "<=", 1 << 30),
    ] {
        engine.add_invariant(AbstractComparison::new(op, symbol(name), number(bound)));
    }
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

#[test]
fn a_row_scan_that_stops_on_data_is_bounded_by_its_row_latch() {
    let res = rows_scanned_until_a_hit(&[], 1);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn a_row_scan_one_row_past_its_buffer_is_rejected() {
    let res = rows_scanned_until_a_hit(&[], 2);
    assert!(res.is_err(), "{res:?}");
}

#[test]
fn a_row_latch_that_counts_one_row_too_many_is_rejected() {
    let res = rows_scanned_until_a_hit(&["add x5, x5, #1"], 1);
    assert!(res.is_err(), "{res:?}");
}
