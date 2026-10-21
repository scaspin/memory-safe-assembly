use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

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

#[test]
fn counter_on_the_left_resolves() {
    let res = analyze(counted_loop("cmp x8,x2", 8), 8);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn counter_on_the_right_resolves() {
    let res = analyze(counted_loop("cmp x2,x8", 8), 8);
    assert!(res.is_ok(), "{res:?}");
}

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

fn unrolled_countdown(last_step: i64) -> Vec<String> {
    let mut program = vec!["start:".to_string(), "loop:".to_string()];
    for _ in 0..2 {
        program.push("ldr x4,[x1],#8".to_string());
        program.push("subs x2,x2,#4".to_string());
        program.push("b.eq done".to_string());
    }
    program.push("ldr x4,[x1],#8".to_string());
    program.push(format!("subs x2,x2,#{last_step}"));
    program.push("b.ne loop".to_string());
    program.push("done:".to_string());
    program.push("ret".to_string());
    program
}

fn analyze_countdown(program: Vec<String>, multiple_of: i64) -> Result<(), String> {
    init();
    let count = AbstractExpression::Abstract("count".to_string());
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(1, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        generate_expression("*", count.clone(), AbstractExpression::Immediate(2)),
    );
    engine.add_abstract_from(2, "count".to_string());
    engine.add_invariant(AbstractComparison::new(
        ">=",
        count.clone(),
        AbstractExpression::Immediate(4),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        count.clone(),
        AbstractExpression::Immediate(1 << 20),
    ));
    engine.add_invariant(AbstractComparison::new(
        "==",
        generate_expression("%", count, AbstractExpression::Immediate(multiple_of)),
        AbstractExpression::Immediate(0),
    ));
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

#[test]
fn equality_exits_that_check_every_value_of_the_walk_bound_it() {
    let res = analyze_countdown(unrolled_countdown(4), 4);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn equality_exits_a_count_off_their_lattice_steps_over_are_rejected() {
    let res = analyze_countdown(unrolled_countdown(4), 2);
    assert!(res.is_err(), "{res:?}");
}

#[test]
fn equality_exits_with_a_gap_in_the_walk_are_rejected() {
    let res = analyze_countdown(unrolled_countdown(8), 4);
    assert!(res.is_err(), "{res:?}");
}
