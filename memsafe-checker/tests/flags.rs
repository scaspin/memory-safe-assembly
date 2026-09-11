
use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn run_for_x0(body: &[&str]) -> (Result<(), String>, i64) {
    init();
    let program: Vec<String> = std::iter::once("start:".to_string())
        .chain(body.iter().map(|s| s.to_string()))
        .chain(std::iter::once("ret".to_string()))
        .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    let res = engine.start("start").map_err(|e| e.to_string());
    let x0 = engine.get_register_output(0).offset;
    (res, x0)
}

fn run_with_unknown_flags(body: &[&str]) -> Result<(), String> {
    init();
    let program: Vec<String> = ["start:", "ldr w2,[x0,#0]", "ldr w3,[x0,#8]"]
        .iter()
        .map(|s| s.to_string())
        .chain(body.iter().map(|s| s.to_string()))
        .chain(std::iter::once("ret".to_string()))
        .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(64));
    engine.start("start").map_err(|e| e.to_string())
}

const CARRY_SET: [&str; 3] = ["add x1,#0,#7", "add x2,#0,#3", "cmp x1,x2"];
const CARRY_CLEAR: [&str; 3] = ["add x1,#0,#3", "add x2,#0,#7", "cmp x1,x2"];

fn with(prefix: [&str; 3], rest: &[&str]) -> Vec<String> {
    prefix
        .iter()
        .chain(rest.iter())
        .map(|s| s.to_string())
        .collect()
}

fn x0_after(prefix: [&str; 3], rest: &[&str]) -> i64 {
    let program = with(prefix, rest);
    let refs: Vec<&str> = program.iter().map(|s| s.as_str()).collect();
    let (res, x0) = run_for_x0(&refs);
    assert_eq!(res, Ok(()), "program failed");
    x0
}

#[test]
fn cset_cs_follows_the_carry() {
    assert_eq!(x0_after(CARRY_SET, &["cset x0, cs"]), 1);
    assert_eq!(x0_after(CARRY_CLEAR, &["cset x0, cs"]), 0);
}

#[test]
fn cset_cc_is_the_negation_of_cs() {
    assert_eq!(x0_after(CARRY_SET, &["cset x0, cc"]), 0);
    assert_eq!(x0_after(CARRY_CLEAR, &["cset x0, cc"]), 1);
}

#[test]
fn csel_cs_takes_the_first_operand_while_the_carry_is_set() {
    let opts = ["add x5,#0,#100", "add x6,#0,#200"];
    assert_eq!(
        x0_after(CARRY_SET, &[opts[0], opts[1], "csel x0, x5, x6, cs"]),
        100
    );
    assert_eq!(
        x0_after(CARRY_CLEAR, &[opts[0], opts[1], "csel x0, x5, x6, cs"]),
        200
    );
}

#[test]
fn csel_cc_takes_the_first_operand_while_the_carry_is_clear() {
    let opts = ["add x5,#0,#100", "add x6,#0,#200"];
    assert_eq!(
        x0_after(CARRY_SET, &[opts[0], opts[1], "csel x0, x5, x6, cc"]),
        200
    );
    assert_eq!(
        x0_after(CARRY_CLEAR, &[opts[0], opts[1], "csel x0, x5, x6, cc"]),
        100
    );
}

#[test]
fn cset_after_an_unknown_comparison_is_analyzed() {
    assert_eq!(
        run_with_unknown_flags(&["cmp x2,x3", "cset x4, cs"]),
        Ok(())
    );
    assert_eq!(
        run_with_unknown_flags(&["cmp x2,x3", "cset x4, cc"]),
        Ok(())
    );
}

#[test]
fn add_with_carry_on_a_symbolic_carry_is_analyzed() {
    assert_eq!(
        run_with_unknown_flags(&["cmp x2,x3", "adc x5,x2,x3"]),
        Ok(())
    );
    assert_eq!(
        run_with_unknown_flags(&["cmp x2,x3", "adcs x5,x2,x3"]),
        Ok(())
    );
}

#[test]
fn csetm_eq_writes_all_ones_when_equal() {
    assert_eq!(
        x0_after(
            ["add x1,#0,#7", "add x2,#0,#7", "cmp x1,x2"],
            &["csetm x0, eq"]
        ),
        -1
    );
    assert_eq!(
        x0_after(
            ["add x1,#0,#7", "add x2,#0,#3", "cmp x1,x2"],
            &["csetm x0, eq"]
        ),
        0
    );
}

#[test]
fn subtract_with_a_clear_carry_subtracts_the_bases() {
    init();
    let program: Vec<String> = ["start:", "add x3,#0,#3", "add x4,#0,#7", "cmp x3,x4"]
        .iter()
        .chain(["sbc x0,x1,x2", "ret"].iter())
        .map(|s| s.to_string())
        .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(1, "a");
    engine.add_abstract_from(2, "b");
    assert_eq!(engine.start("start").map_err(|e| e.to_string()), Ok(()));
    assert_eq!(
        engine.get_register_output(0).base.map(|b| b.to_string()),
        Some("a - b".to_string())
    );
}

#[test]
fn tst_sets_zero_from_the_masked_bits() {
    assert_eq!(
        x0_after(
            ["add x1,#0,#8", "add x2,#0,#8", "tst x1,x2"],
            &["csetm x0, eq"]
        ),
        0
    );
    assert_eq!(
        x0_after(
            ["add x1,#0,#8", "add x2,#0,#1", "tst x1,x2"],
            &["csetm x0, eq"]
        ),
        -1
    );
}

#[test]
fn tst_leaves_its_operand_alone() {
    assert_eq!(
        x0_after(["add x0,#0,#8", "add x2,#0,#1", "tst x0,x2"], &[]),
        8
    );
}

#[test]
fn tst_on_an_unknown_value_is_analyzed() {
    assert_eq!(
        run_with_unknown_flags(&["tst x2,#8", "csetm x4, eq"]),
        Ok(())
    );
}

#[test]
fn subtract_with_carry_on_a_symbolic_carry_is_analyzed() {
    assert_eq!(
        run_with_unknown_flags(&["cmp x2,x3", "sbc x5,x2,x3"]),
        Ok(())
    );
    assert_eq!(
        run_with_unknown_flags(&["cmp x2,x3", "sbcs x5,x2,x3"]),
        Ok(())
    );
}

#[test]
fn the_unselected_branch_carries_its_own_option() {
    init();
    let program: Vec<String> = [
        "start:",
        "ldr w2,[x0,#0]",
        "ldr w3,[x0,#8]",
        "cmp w2,w3",
        "add x1,#0,#0",
        "add x4,#0,#0",
        "add x5,#0,#64",
        "csel x1,x4,x5,eq",
        "add x0,x0,x1",
        "ldr x6,[x0]",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(16));

    let res = engine.start("start").map_err(|e| e.to_string());
    let message = res.expect_err("the second option reads past the region");
    assert!(
        message.contains("not provably within region"),
        "expected an out of bounds report, got {message}"
    );
}
