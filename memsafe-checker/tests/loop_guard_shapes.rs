// Which operand of the exit test holds the counter decides the sign of the trip fact.
// `cmp counter, bound` walks the comparison's value up, `cmp bound, counter` walks it
// down, and a counter nested inside a subtraction walks the whole expression down even
// though the counter itself steps up.

use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

// Reads 8 bytes per iteration through x1, stepping by `stride`, counting iterations in
// x8 and exiting when x8 reaches x2. `guard` writes that test.
fn counted_loop(guard: &str, stride: i64) -> Vec<String> {
    vec![
        "start:".to_string(),
        "mov x8,#0".to_string(),
        "loop:".to_string(),
        "ldr x4,[x1]".to_string(),
        format!("add x1,x1,#{stride}"),
        "add x8,x8,#1".to_string(),
        guard.to_string(),
        "b.ne loop".to_string(),
        "ret".to_string(),
    ]
}

// x1 covers `count` blocks of `stride` bytes, which is exactly what the loop reads.
fn analyze(program: Vec<String>, stride: i64) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(1, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        generate_expression(
            "*",
            AbstractExpression::Abstract("count".to_string()),
            AbstractExpression::Immediate(stride),
        ),
    );
    engine.add_abstract_from(2, "count".to_string());
    engine.add_invariant(AbstractComparison::new(
        ">=",
        AbstractExpression::Abstract("count".to_string()),
        AbstractExpression::Immediate(1),
    ));
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

// The shape the accelerator was built for: the counter is the comparison's left operand.
#[test]
fn counter_on_the_left_resolves() {
    let res = analyze(counted_loop("cmp x8,x2", 8), 8);
    assert!(res.is_ok(), "{res:?}");
}

// The same loop with the operands swapped. The counter is now the right operand, so the
// compared value walks down by one per iteration while the counter walks up; the trip
// fact has to carry the compared expression's sign, not the counter's.
#[test]
fn counter_on_the_right_resolves() {
    let res = analyze(counted_loop("cmp x2,x8", 8), 8);
    assert!(res.is_ok(), "{res:?}");
}

// x9 is recomputed from the induction variables every iteration (`sub x9,x2,x8`) rather
// than stepped in place, so the summary only works if it agrees with itself about what
// the counter counts. It used to not: a based register dropped its whole offset as
// "distance already covered" while a base-less counter kept its value, so a pointer
// became `base + step*counter` while the counter became `2 + counter`, and one symbolic
// iteration moved x9 by -3 where the summary had recorded -1. Every register now
// anchors at the value it holds here, and the counter counts forward from there.
#[test]
fn counter_inside_a_subtraction_resolves() {
    let program = vec![
        "start:".to_string(),
        "mov x8,#0".to_string(),
        "loop:".to_string(),
        "sub x9,x2,x8".to_string(),
        "cbz x9,done".to_string(),
        "ldr x4,[x1]".to_string(),
        "add x1,x1,#8".to_string(),
        "add x8,x8,#1".to_string(),
        "b loop".to_string(),
        "done:".to_string(),
        "ret".to_string(),
    ];
    let res = analyze(program, 8);
    assert!(res.is_ok(), "{res:?}");
}
