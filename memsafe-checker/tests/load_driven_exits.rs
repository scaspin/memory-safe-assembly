use bums::common::*;
use bums::engine::ExecutionEngine;

fn counted_by(prologue: &[&str], bound: &[&str]) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut program = vec!["start:".to_string()];
    program.extend(prologue.iter().map(|l| l.to_string()));
    program.push("mov x8,#0".to_string());
    program.push("loop:".to_string());
    program.extend(bound.iter().map(|l| l.to_string()));
    program.extend(
        [
            "ldr x4,[x1]",
            "add x1,x1,#8",
            "add x8,x8,#1",
            "cmp x8,x3",
            "b.ne loop",
            "add sp,sp,#16",
            "ret",
        ]
        .iter()
        .map(|l| l.to_string()),
    );

    let mut engine = ExecutionEngine::new(program);
    engine.add_abstract_from(1, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        generate_expression(
            "*",
            AbstractExpression::Abstract("count".to_string()),
            AbstractExpression::Immediate(8),
        ),
    );
    engine.add_abstract_from(2, "count".to_string());
    engine.add_invariant(AbstractComparison::new(
        ">=",
        AbstractExpression::Abstract("count".to_string()),
        AbstractExpression::Immediate(1),
    ));
    engine.add_abstract_from(5, "table".to_string());
    engine.add_region(
        RegionType::READ,
        "table".to_string(),
        AbstractExpression::Immediate(1 << 20),
    );
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

#[test]
fn a_bound_held_in_a_register_summarizes() {
    let res = counted_by(&["sub sp,sp,#16", "mov x3,x2"], &[]);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn a_bound_reloaded_from_a_spill_summarizes() {
    let res = counted_by(&["sub sp,sp,#16", "str x2,[sp,#8]"], &["ldr x3,[sp,#8]"]);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn a_bound_read_fresh_from_a_table_does_not_summarize() {
    let res = counted_by(&["sub sp,sp,#16"], &["ldr x3,[x5]", "add x5,x5,#8"]);
    let err = res.expect_err("a threshold that moves is no basis for a summary");
    assert!(
        err.contains("not provably within region"),
        "expected an unbounded read, got: {err}"
    );
}

#[test]
fn a_bound_reloaded_from_a_cell_the_body_writes_does_not_summarize() {
    let res = counted_by(
        &["sub sp,sp,#16", "str x2,[sp,#8]"],
        &["ldr x3,[sp,#8]", "add x9,x3,#1", "str x9,[sp,#8]"],
    );
    let err = res.expect_err("a cell the body rewrites is no basis for a summary");
    assert!(
        err.contains("not provably within region"),
        "expected an unbounded read, got: {err}"
    );
}

fn thresholds(table: &str) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let program: Vec<String> = [
        "start:",
        "adr x5,thresholds",
        "loop:",
        "ldr x3,[x5]",
        "add x5,x5,#8",
        "cmp x2,x3",
        "b.lt done",
        "b loop",
        "done:",
        "ret",
        ".section .rodata",
        "thresholds:",
        table,
    ]
    .iter()
    .map(|l| l.to_string())
    .collect();
    let mut engine = ExecutionEngine::new(program);
    engine.add_abstract_from(2, "eob".to_string());
    for (op, bound) in [(">=", 0), ("<=", 999)] {
        engine.add_invariant(AbstractComparison::new(
            op,
            AbstractExpression::Abstract("eob".to_string()),
            AbstractExpression::Immediate(bound),
        ));
    }
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

#[test]
fn thresholds_read_from_a_table_are_unrolled_to_the_one_that_always_leaves() {
    let res = thresholds(".quad 1,2,3,4,5,6,1000");
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn thresholds_that_never_leave_read_past_the_table() {
    let err = thresholds(".quad 1,2,3,4,5,6,7").expect_err("eob may outlast every threshold");
    assert!(err.contains(".rodata + 56 not provably within"), "{err}");
}
