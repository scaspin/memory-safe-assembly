use bums::common::*;
use bums::engine::ExecutionEngine;

fn imm(v: i64) -> AbstractExpression {
    AbstractExpression::Immediate(v)
}
fn abs(n: &str) -> AbstractExpression {
    AbstractExpression::Abstract(n.to_string())
}
fn cmp(op: &str, a: AbstractExpression, b: AbstractExpression) -> AbstractComparison {
    AbstractComparison::new(op, a, b)
}
fn blocks(name: &str, block: i64) -> AbstractExpression {
    generate_expression("/", abs(&format!("{name}_len")), imm(block))
}

fn setup(label: &str, xs_block: i64) -> Result<(), String> {
    setup_with_short_ys_by(label, xs_block, 0)
}

fn setup_with_short_ys(label: &str, xs_block: i64) -> Result<(), String> {
    setup_with_short_ys_by(label, xs_block, 292)
}

fn setup_with_short_ys_by(label: &str, xs_block: i64, ys_shortfall: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(false).try_init();
    let program: Vec<String> = std::fs::read_to_string(format!("tests/asm/{label}.S"))
        .unwrap()
        .lines()
        .map(str::to_string)
        .collect();
    let mut e = ExecutionEngine::new(program);

    e.add_abstract_from(0, "n".to_string());
    e.add_invariant(cmp(">=", abs("n"), imm(0)));

    let slices = [
        (1usize, 2usize, "xs0", xs_block),
        (3, 4, "xs1", xs_block),
        (5, 6, "xs2", xs_block),
        (7, 8, "xs3", xs_block),
        (9, 10, "ys", 292),
    ];
    for (ptr, count, name, block) in slices {
        let region = format!("{name}_ptr");
        let mut length = abs(&format!("{name}_len"));
        if name == "ys" && ys_shortfall != 0 {
            length = generate_expression("-", length, imm(ys_shortfall));
        }
        e.add_abstract_from(ptr, region.clone());
        e.add_region(RegionType::READ, region, length);
        e.add_abstract_expression_from(count, blocks(name, block));
        e.add_invariant(cmp("<=", abs(&format!("{name}_len")), imm(i64::MAX)));
        e.add_invariant(cmp(
            "==",
            generate_expression("%", abs(&format!("{name}_len")), imm(block)),
            imm(0),
        ));
    }

    e.add_abstract("x8", abs("out_ptr"));
    e.add_region(RegionType::WRITE, "out_ptr".to_string(), imm(16));

    e.start(label.to_string()).map_err(|e| e.to_string())
}

#[test]
fn q4k_vec_dot_4_is_safe() {
    let res = setup("candle_q4k_vec_dot_4", 144);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn q6k_vec_dot_4_is_safe() {
    let res = setup("candle_q6k_vec_dot_4", 210);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn a_short_ys_row_is_unsafe() {
    let res = setup_with_short_ys("candle_q4k_vec_dot_4", 144);
    let err = res.expect_err("one ys block short of what the kernel reads");
    assert!(
        err.contains("not provably within region"),
        "expected an out-of-bounds read, got: {err}"
    );
}
