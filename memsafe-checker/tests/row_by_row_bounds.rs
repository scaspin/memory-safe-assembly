use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn immediate(value: i64) -> AbstractExpression {
    AbstractExpression::Immediate(value)
}

struct Rows {
    least_stride: i64,
    heights_divide: Option<i64>,
}

fn rows_walked_then_filled(rows: Rows) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "mov w7,w5",
        "walk:",
        "lsr w8,w7,#6",
        "add w7,w7,w5",
        "cmp w8,w6",
        "b.ge fill",
        "ldrb w9,[x2,w8,uxtw]",
        "st1 {v16.4h}, [x0], x1",
        "add w7,w7,w5",
        "subs w4,w4,#2",
        "st1 {v17.4h}, [x0], x1",
        "b.gt walk",
        "ret",
        "fill:",
        "st1 {v31.4h}, [x0], x1",
        "subs w4,w4,#2",
        "st1 {v31.4h}, [x0], x1",
        "b.gt fill",
        "ret",
    ]
    .iter()
    .map(|line| line.to_string())
    .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "dst");
    engine.add_region(
        RegionType::WRITE,
        "dst",
        generate_expression("*", symbol("stride"), symbol("height")),
    );
    engine.add_abstract_from(1, "stride");
    engine.add_abstract_from(2, "top");
    engine.add_region(RegionType::READ, "top", immediate(128));
    engine.add_abstract_from(4, "height");
    engine.add_abstract_from(5, "dx");
    engine.add_abstract_from(6, "max_base");
    let mut facts = vec![
        (">=", symbol("stride"), immediate(rows.least_stride)),
        ("<=", symbol("stride"), immediate(1 << 20)),
        (">=", symbol("height"), immediate(4)),
        ("<=", symbol("height"), immediate(64)),
        (">=", symbol("dx"), immediate(1)),
        ("<=", symbol("dx"), immediate(1023)),
        (">=", symbol("max_base"), immediate(1)),
        ("<=", symbol("max_base"), immediate(127)),
    ];
    if let Some(dividend) = rows.heights_divide {
        facts.push((
            "==",
            generate_expression("%", immediate(dividend), symbol("height")),
            immediate(0),
        ));
    }
    for (op, left, right) in facts {
        engine.add_invariant(AbstractComparison::new(op, left, right));
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn paired_rows_stay_within_a_height_dividing_sixty_four() {
    let rows = Rows {
        least_stride: 8,
        heights_divide: Some(64),
    };
    assert_eq!(rows_walked_then_filled(rows), Ok(()));
}

#[test]
fn a_row_wider_than_the_stride_is_rejected() {
    let rows = Rows {
        least_stride: 4,
        heights_divide: Some(64),
    };
    assert!(rows_walked_then_filled(rows).is_err());
}

#[test]
fn paired_rows_over_an_odd_height_are_rejected() {
    let rows = Rows {
        least_stride: 8,
        heights_divide: None,
    };
    assert!(rows_walked_then_filled(rows).is_err());
}

#[test]
fn paired_rows_over_a_height_dividing_twenty_are_rejected() {
    let rows = Rows {
        least_stride: 8,
        heights_divide: Some(20),
    };
    assert!(rows_walked_then_filled(rows).is_err());
}
