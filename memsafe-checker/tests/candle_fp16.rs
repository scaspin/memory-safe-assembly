use bums::common::*;
use bums::engine::ExecutionEngine;

fn abs(n: &str) -> AbstractExpression {
    AbstractExpression::Abstract(n.to_string())
}
fn imm(v: i64) -> AbstractExpression {
    AbstractExpression::Immediate(v)
}
fn cmp(op: &str, a: AbstractExpression, b: AbstractExpression) -> AbstractComparison {
    AbstractComparison::new(op, a, b)
}

fn engine_for(label: &str) -> ExecutionEngine {
    let _ = env_logger::builder().is_test(true).try_init();
    let program: Vec<String> = std::fs::read_to_string(format!("tests/asm/{label}.S"))
        .expect("fixture")
        .lines()
        .map(str::to_string)
        .collect();
    ExecutionEngine::new(program)
}

fn add_slice(e: &mut ExecutionEngine, ptr: usize, count: usize, name: &str, kind: RegionType) {
    let region = format!("{name}_ptr");
    let bytes = generate_expression("*", abs(&format!("{name}_len")), imm(2));
    e.add_abstract_from(ptr, region.clone());
    e.add_region(kind, region, bytes.clone());
    e.add_abstract_from(count, format!("{name}_len"));
    e.add_invariant(cmp("<=", bytes, imm(i64::MAX)));
}

fn vecops_vec_add(matched: bool) -> Result<(), String> {
    let mut e = engine_for("candle_f16_vecops_vec_add");
    add_slice(&mut e, 0, 1, "lhs", RegionType::READ);
    add_slice(&mut e, 2, 3, "rhs", RegionType::READ);
    add_slice(&mut e, 4, 5, "res", RegionType::WRITE);
    if matched {
        e.add_invariant(cmp("==", abs("lhs_len"), abs("rhs_len")));
        e.add_invariant(cmp("==", abs("lhs_len"), abs("res_len")));
    }
    e.start("candle_f16_vecops_vec_add".to_string())
        .map_err(|e| e.to_string())
}

#[test]
fn vecops_vec_add_is_safe() {
    let res = vecops_vec_add(true);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn vecops_vec_add_needs_its_lengths_matched() {
    let err = vecops_vec_add(false).expect_err("rhs is indexed by lhs's length");
    assert!(
        err.contains("not provably within region"),
        "expected an unbounded access, got: {err}"
    );
}

fn f16_vec_dot(shortfall: i64) -> Result<(), String> {
    let mut e = engine_for("candle_f16_vec_dot");
    e.add_abstract_from(0, "n".to_string());
    e.add_invariant(cmp(">=", abs("n"), imm(0)));
    add_slice(&mut e, 1, 2, "xs", RegionType::READ);
    add_slice(&mut e, 3, 4, "ys", RegionType::READ);
    e.add_invariant(cmp(
        "<=",
        abs("n"),
        generate_expression("+", abs("xs_len"), imm(shortfall)),
    ));
    e.add_invariant(cmp("<=", abs("n"), abs("ys_len")));
    e.start("candle_f16_vec_dot".to_string())
        .map_err(|e| e.to_string())
}

#[test]
fn f16_vec_dot_is_safe() {
    let res = f16_vec_dot(0);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn f16_vec_dot_past_the_end_of_xs_is_unsafe() {
    let err = f16_vec_dot(1).expect_err("n reaches one element past xs");
    assert!(
        err.contains("not provably within region"),
        "expected a read past xs, got: {err}"
    );
}
