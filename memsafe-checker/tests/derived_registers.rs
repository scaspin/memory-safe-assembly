use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

enum Height {
    Exactly(i64),
    DividingSixtyFour,
}

struct Walk {
    height: Height,
    second_row: bool,
    wrapped_height: bool,
    top_bytes: i64,
}

fn two_rows_sampled_by_a_shifted_position(walk: Walk) -> Result<(), String> {
    init();
    let mut lines = vec![
        "start:",
        "mov w7,w5",
        "walk:",
        "lsr w8,w7,#6",
        "add w7,w7,w5",
        "cmp w8,w6",
        "lsr w10,w7,#6",
        "b.ge fill",
        "lsl w8,w8,#1",
        "lsl w10,w10,#1",
        "ldr q0,[x2,w8,uxtw]",
    ];
    if walk.second_row {
        lines.push("ldr q2,[x2,w10,uxtw]");
    }
    lines.extend([
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
    ]);
    let program: Vec<String> = lines.iter().map(|line| line.to_string()).collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "dst");
    engine.add_region(
        RegionType::WRITE,
        "dst",
        generate_expression("*", symbol("stride"), symbol("height")),
    );
    engine.add_abstract_from(1, "stride");
    engine.add_abstract_from(2, "top");
    engine.add_region(
        RegionType::READ,
        "top",
        AbstractExpression::Immediate(walk.top_bytes),
    );
    if walk.wrapped_height {
        engine.add_abstract_expression_from(
            4,
            generate_expression(
                "%",
                symbol("height"),
                AbstractExpression::Immediate(1 << 32),
            ),
        );
    } else {
        engine.add_abstract_from(4, "height");
    }
    match walk.height {
        Height::Exactly(rows) => engine.add_invariant(AbstractComparison::new(
            "==",
            symbol("height"),
            AbstractExpression::Immediate(rows),
        )),
        Height::DividingSixtyFour => {
            for (op, value) in [(">=", 8), ("<=", 64)] {
                engine.add_invariant(AbstractComparison::new(
                    op,
                    symbol("height"),
                    AbstractExpression::Immediate(value),
                ));
            }
            engine.add_invariant(AbstractComparison::new(
                "==",
                generate_expression("%", AbstractExpression::Immediate(64), symbol("height")),
                AbstractExpression::Immediate(0),
            ));
        }
    }
    engine.add_abstract_from(5, "dxy");
    engine.add_abstract_from(6, "max_base");
    for (op, name, value) in [
        (">=", "stride", 8),
        ("<=", "stride", 128),
        (">=", "dxy", 1),
        ("<=", "dxy", 1023),
        (">=", "max_base", 3),
        ("<=", "max_base", 127),
    ] {
        engine.add_invariant(AbstractComparison::new(
            op,
            symbol(name),
            AbstractExpression::Immediate(value),
        ));
    }
    engine.start("start").map_err(|e| e.to_string())
}

const PADDED_TOP_BYTES: i64 = 604;

#[test]
fn a_row_base_derived_from_the_position_stays_under_its_guard() {
    let walk = Walk {
        height: Height::Exactly(64),
        second_row: false,
        wrapped_height: true,
        top_bytes: PADDED_TOP_BYTES,
    };
    assert_eq!(two_rows_sampled_by_a_shifted_position(walk), Ok(()));
}

#[test]
fn an_unguarded_second_row_stays_within_the_padding() {
    let walk = Walk {
        height: Height::Exactly(64),
        second_row: true,
        wrapped_height: true,
        top_bytes: PADDED_TOP_BYTES,
    };
    assert_eq!(two_rows_sampled_by_a_shifted_position(walk), Ok(()));
}

#[test]
fn fill_rows_after_an_early_exit_stay_in_a_split_height() {
    let walk = Walk {
        height: Height::DividingSixtyFour,
        second_row: true,
        wrapped_height: true,
        top_bytes: PADDED_TOP_BYTES,
    };
    assert_eq!(two_rows_sampled_by_a_shifted_position(walk), Ok(()));
}

#[test]
fn fill_rows_after_an_early_exit_stay_in_an_unwrapped_split_height() {
    let walk = Walk {
        height: Height::DividingSixtyFour,
        second_row: true,
        wrapped_height: false,
        top_bytes: PADDED_TOP_BYTES,
    };
    assert_eq!(two_rows_sampled_by_a_shifted_position(walk), Ok(()));
}

#[test]
fn a_second_row_past_a_short_padding_is_rejected() {
    let walk = Walk {
        height: Height::Exactly(64),
        second_row: true,
        wrapped_height: true,
        top_bytes: 2 * 127 + 16,
    };
    assert!(two_rows_sampled_by_a_shifted_position(walk).is_err());
}
