use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn abs(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn imm(value: i64) -> AbstractExpression {
    AbstractExpression::Immediate(value)
}

fn accepts(body: &[&str], length: i64, invariants: &[AbstractComparison]) -> bool {
    init();
    let program: Vec<String> = std::iter::once("start:")
        .chain(body.iter().copied())
        .chain(std::iter::once("ret"))
        .map(String::from)
        .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "n");
    engine.add_abstract_from(1, "buf");
    engine.add_region(RegionType::RW, "buf", imm(length));
    for invariant in invariants {
        engine.add_invariant(invariant.clone());
    }
    engine.start("start").is_ok()
}

fn n_is(value: i64) -> AbstractComparison {
    AbstractComparison::new("==", abs("n"), imm(value))
}

#[test]
fn subs_counts_down_a_loop() {
    let walk = ["loop:", "ldr x3, [x1], #8", "subs x0, x0, #1", "b.ne loop"];
    assert!(!accepts(&walk, 8, &[]));
    assert!(!accepts(&walk, 8, &[n_is(2)]));
    assert!(accepts(&walk, 16, &[n_is(2)]));
}

#[test]
fn subs_from_another_register_counts_down_a_loop() {
    let walk = [
        "mov x5, x0",
        "loop:",
        "ldr x3, [x1], #8",
        "subs x5, x5, #1",
        "b.ne loop",
    ];
    assert!(!accepts(&walk, 8, &[]));
}

#[test]
fn ands_tests_its_sources() {
    let body = ["ands x5, x0, #7", "b.eq done", "ldr x3, [x1, #8]", "done:"];
    assert!(accepts(&body, 8, &[n_is(8)]));
    assert!(!accepts(&body, 8, &[n_is(9)]));
}

#[test]
fn register_offset_addressing_is_checked_at_the_offset() {
    assert!(!accepts(&["mov x2, #16", "str x3, [x1, x2]"], 8, &[]));
    assert!(!accepts(&["mov x2, #16", "str x3, [x1, x2]"], 23, &[]));
    assert!(accepts(&["mov x2, #16", "str x3, [x1, x2]"], 24, &[]));
    assert!(!accepts(
        &["mov x2, #2", "str x3, [x1, x2, lsl #3]"],
        23,
        &[]
    ));
    assert!(accepts(
        &["mov x2, #2", "str x3, [x1, x2, lsl #3]"],
        24,
        &[]
    ));
}

#[test]
fn scalar_vector_registers_move_their_own_width() {
    assert!(accepts(&["ldr d0, [x1, #8]"], 16, &[]));
    assert!(!accepts(&["ldr q0, [x1, #8]"], 16, &[]));
    assert!(accepts(&["ldr s0, [x1, #12]"], 16, &[]));
    assert!(accepts(&["stp d0, d1, [x1]"], 16, &[]));
    assert!(!accepts(&["stp q0, q1, [x1]"], 16, &[]));
}

#[test]
fn structure_accesses_cover_every_register() {
    assert!(accepts(&["ld1 { v0.2d, v1.2d }, [x1]"], 32, &[]));
    assert!(!accepts(&["ld1 { v0.2d, v1.2d, v2.2d }, [x1]"], 32, &[]));
    assert!(!accepts(&["st2 { v0.2d, v1.2d }, [x1]"], 16, &[]));
    assert!(accepts(&["ld1 { v0.d }[1], [x1]"], 8, &[]));
}

#[test]
fn register_post_index_advances_the_base() {
    let body = [
        "mov x2, #8",
        "st1 { v0.d }[0], [x1], x2",
        "st1 { v0.d }[0], [x1]",
    ];
    assert!(accepts(&body, 16, &[]));
    assert!(!accepts(&body, 8, &[]));
}

#[test]
fn floating_point_compare_explores_both_sides() {
    let body = [
        "fmov d0, xzr",
        "fadd d1, d0, d0",
        "fcmp d0, d1",
        "b.gt skip",
        "ldr x3, [x1, #8]",
        "skip:",
    ];
    assert!(!accepts(&body, 8, &[]));
    assert!(accepts(&body, 16, &[]));
}

#[test]
fn ninth_argument_is_at_sp() {
    init();
    let program: Vec<String> = [
        "start:",
        "ldr x2, [sp]",
        "add x0, x0, x2",
        "ldr x3, [x0]",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();
    let run = |offset: i64| {
        let mut engine = bums::engine::ExecutionEngine::new(program.clone());
        engine.add_abstract_from(0, "buf");
        engine.add_region(RegionType::RW, "buf", imm(16));
        engine.add_abstract_expression_from(8, imm(offset));
        engine.start("start").is_ok()
    };
    assert!(run(8));
    assert!(!run(16));
}

#[test]
fn w_counter_going_negative_ends_the_loop() {
    let body = [
        "mov x2, #1",
        "loop:",
        "ldr x3, [x1], #8",
        "subs w2, w2, #16",
        "b.gt loop",
    ];
    assert!(accepts(&body, 8, &[]));
}

#[test]
fn symbolic_stride_walk_is_summarized() {
    init();
    let program: Vec<String> = [
        "start:",
        "lsl x2, x2, #3",
        "loop:",
        "ldr x3, [x1]",
        "add x1, x1, x2",
        "subs x0, x0, #1",
        "b.ne loop",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();
    let run = |slack: i64| {
        let mut engine = bums::engine::ExecutionEngine::new(program.clone());
        engine.add_abstract_from(0, "n");
        engine.add_abstract_from(1, "buf");
        engine.add_abstract_from(2, "inc");
        engine.add_region(
            RegionType::READ,
            "buf",
            generate_expression("*", abs("len"), imm(8)),
        );
        engine.add_invariant(AbstractComparison::new(">=", abs("n"), imm(1)));
        engine.add_invariant(AbstractComparison::new(">=", abs("inc"), imm(1)));
        engine.add_invariant(AbstractComparison::new(
            "<=",
            generate_expression("*", abs("n"), abs("inc")),
            generate_expression("+", abs("len"), imm(slack)),
        ));
        engine.start("start").is_ok()
    };
    assert!(run(0));
    assert!(!run(1));
}

#[test]
fn right_shift_of_an_offset_value_folds_the_offset_first() {
    let body = [
        "sub x0, x0, #1",
        "asr x5, x0, #3",
        "cbz x5, done",
        "ldr x3, [x1, #8]",
        "done:",
    ];
    assert!(!accepts(&body, 8, &[n_is(9)]));
    assert!(accepts(&body, 8, &[n_is(2)]));
}

fn program(lines: &[&str]) -> Vec<String> {
    std::iter::once("start:")
        .chain(lines.iter().copied())
        .chain(std::iter::once("ret"))
        .map(String::from)
        .collect()
}

fn accepts_n_doubles(lines: &[&str]) -> bool {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program(lines));
    engine.add_abstract_from(0, "n");
    engine.add_abstract_from(1, "buf");
    engine.add_region(
        RegionType::RW,
        "buf",
        generate_expression("*", abs("n"), imm(8)),
    );
    engine.add_invariant(AbstractComparison::new(">=", abs("n"), imm(1)));
    engine.start("start").is_ok()
}

fn running_choice(chosen: &str) -> Vec<String> {
    [
        "mov x3, #0",
        "mov x4, #0",
        "mov x5, x0",
        "loop:",
        "add x8, x4, #8",
        "fcmp d0, d1",
        chosen,
        "add x4, x4, #8",
        "subs x5, x5, #1",
        "b.ne loop",
        "add x6, x1, x3",
        "ldr x7, [x6]",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect()
}

#[test]
fn a_select_on_data_keeps_a_bound_on_the_chosen_value() {
    let safe = running_choice("csel x3, x3, x4, ge");
    let lines: Vec<&str> = safe.iter().map(|s| s.as_str()).collect();
    assert!(accepts_n_doubles(&lines));
}

#[test]
fn a_bound_the_loop_does_not_keep_proves_nothing() {
    let ahead = running_choice("csel x3, x3, x8, ge");
    let lines: Vec<&str> = ahead.iter().map(|s| s.as_str()).collect();
    assert!(!accepts_n_doubles(&lines));
}

#[test]
fn paths_that_rejoin_in_different_states_are_both_checked() {
    let body = [
        "mov x2, #0",
        "fcmp d0, d1",
        "b.eq join",
        "mov x2, #8",
        "join:",
        "add x5, x1, x2",
        "ldr x4, [x5]",
    ];
    assert!(!accepts(&body, 8, &[]));
    assert!(accepts(&body, 16, &[]));
}

#[test]
fn paths_that_rejoin_in_the_same_state_are_merged() {
    let mut body = Vec::new();
    for i in 0..30 {
        body.push("fcmp d0, d1".to_string());
        body.push(format!("b.eq join{i}"));
        body.push("fadd d0, d0, d1".to_string());
        body.push(format!("join{i}:"));
    }
    body.push("ldr x4, [x1]".to_string());
    let lines: Vec<&str> = body.iter().map(|s| s.as_str()).collect();
    assert!(accepts(&lines, 8, &[]));
    assert!(!accepts(&lines, 4, &[]));
}
