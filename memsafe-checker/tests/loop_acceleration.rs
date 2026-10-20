use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn analyze(program: Vec<String>) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));
    engine.add_abstract_from(1, "length");
    engine.start("start").map_err(|e| e.to_string())
}

fn walking_loop(stride: i64, body: &[&str]) -> Vec<String> {
    walking_loop_with_tail(stride, body, &[])
}

fn walking_loop_with_tail(stride: i64, body: &[&str], tail: &[&str]) -> Vec<String> {
    let mut program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "loop:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq end".to_string(),
    ];
    program.extend(body.iter().map(|s| s.to_string()));
    program.push(format!("add x0,x0,#{stride}"));
    program.push("b loop".to_string());
    program.push("end:".to_string());
    program.extend(tail.iter().map(|s| s.to_string()));
    program.push("ret".to_string());
    program
}

fn bottom_tested_loop(body: &[&str]) -> Vec<String> {
    let mut program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "loop:".to_string(),
    ];
    program.extend(body.iter().map(|s| s.to_string()));
    program.push("add x0,x0,#4".to_string());
    program.push("cmp x0,x1".to_string());
    program.push("b.ne loop".to_string());
    program.push("ret".to_string());
    program
}

const SYMBOLIC_LIMIT: &str = "add x5,x1,#0";
const SYMBOLIC_INNER_LIMIT: &str = "add x3,x1,#0";

fn nested_walk(
    outer_limit: &str,
    inner_limit: &str,
    outer_stride: i64,
    inner_stride: i64,
    body: &[&str],
) -> Vec<String> {
    let mut program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        outer_limit.to_string(),
        "outer:".to_string(),
        "cmp x0,x5".to_string(),
        "b.eq done".to_string(),
        "add x2,x0,#0".to_string(),
        inner_limit.to_string(),
        "inner:".to_string(),
        "cmp x2,x3".to_string(),
        "b.eq next".to_string(),
    ];
    program.extend(body.iter().map(|s| s.to_string()));
    program.push(format!("add x2,x2,#{inner_stride}"));
    program.push("b inner".to_string());
    program.push("next:".to_string());
    program.push(format!("add x0,x0,#{outer_stride}"));
    program.push("b outer".to_string());
    program.push("done:".to_string());
    program.push("ret".to_string());
    program
}

#[track_caller]
fn assert_rejected_access(res: Result<(), String>) {
    let err = res.expect_err("expected a rejected access");
    assert!(err.contains("not provably within region"), "{err}");
}

#[track_caller]
fn assert_unresolved(res: Result<(), String>) {
    let err = res.expect_err("expected an unresolved loop");
    assert!(err.contains("not summarized after"), "{err}");
}

#[track_caller]
fn assert_out_of_bounds(res: Result<(), String>, offset: i64) {
    let err = res.expect_err("expected a rejected access");
    let addr = if offset < 0 {
        format!("base - {}", -offset)
    } else {
        format!("base + {offset}")
    };
    assert!(err.contains("not provably within region"), "{err}");
    assert!(err.contains(&format!(" at {addr} ")), "{err}");
}

#[test]
fn accelerates_constant_stride_loop() {
    assert_eq!(analyze(walking_loop(4, &[])), Ok(()));
}

#[test]
fn accelerates_every_stride() {
    for stride in [1, 2, 4, 8, 16, 32] {
        assert_eq!(
            analyze(walking_loop(stride, &[])),
            Ok(()),
            "stride {stride}"
        );
    }
}

#[test]
fn every_stride_still_catches_out_of_bounds_read() {
    for stride in [1, 2, 4, 8, 16, 32] {
        let res = analyze(walking_loop(stride, &["ldr x2,[x0,#100000]"]));
        assert!(res.is_err(), "stride {stride} proved an out of bounds read");
    }
}

fn countdown_loop(body: &[&str]) -> Vec<String> {
    let mut program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "loop:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq end".to_string(),
    ];
    program.extend(body.iter().map(|s| s.to_string()));
    program.push("sub x1,x1,#4".to_string());
    program.push("b loop".to_string());
    program.push("end:".to_string());
    program.push("ret".to_string());
    program
}

#[test]
fn countdown_loop_resolves() {
    assert_eq!(analyze(countdown_loop(&[])), Ok(()));
}

#[test]
fn countdown_loop_still_catches_out_of_bounds_read() {
    assert!(analyze(countdown_loop(&["ldr x2,[x0,#100000]"])).is_err());
}

fn negative_index_tail(read: &str) -> Vec<String> {
    [
        "start:",
        "add x3,x1,#0",
        "add x1,x0,x1",
        "neg x2,x3",
        "loop:",
        read,
        "add x2,x2,#1",
        "cbnz x2,loop",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect()
}

fn analyze_nonempty(program: Vec<String>) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));
    engine.add_abstract_from(1, "length");
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("length"),
        AbstractExpression::Immediate(1),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_register_indexed_tail_read_is_proved_safe() {
    assert_eq!(
        analyze_nonempty(negative_index_tail("ldrb w4,[x1,x2]")),
        Ok(())
    );
}

#[test]
fn a_register_indexed_tail_read_one_past_the_end_is_rejected() {
    assert!(analyze_nonempty(negative_index_tail("ldrb w4,[x1,x3]")).is_err());
}

#[test]
fn mixed_sign_deltas_still_resolve() {
    let mut program = walking_loop(4, &["sub x3,x3,#4"]);
    program.insert(2, "add x3,x0,#0".to_string());
    assert_eq!(analyze(program), Ok(()));
}

#[test]
fn two_pointers_with_different_strides_resolve() {
    let mut program = walking_loop(4, &["add x3,x3,#8"]);
    program.insert(2, "add x3,x0,#0".to_string());
    assert_eq!(analyze(program), Ok(()));
}

#[test]
fn two_pointers_still_catch_out_of_bounds_read() {
    let mut program = walking_loop(4, &["add x3,x3,#8", "ldr x4,[x0,#100000]"]);
    program.insert(2, "add x3,x0,#0".to_string());
    assert!(analyze(program).is_err());
}

#[test]
fn immediate_counter_loop_resolves() {
    let mut program = walking_loop(4, &["add x2,x2,#1"]);
    program.insert(2, "add x2,#0,#0".to_string());
    assert_eq!(analyze(program), Ok(()));
}

#[test]
#[ignore = "passed only because the body reads nothing; the inner loop unrolls to the depth limit"]
fn nested_loops_resolve() {
    let program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "outer:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq done".to_string(),
        "add x2,x0,#0".to_string(),
        "inner:".to_string(),
        "cmp x2,x1".to_string(),
        "b.eq next".to_string(),
        "add x2,x2,#4".to_string(),
        "b inner".to_string(),
        "next:".to_string(),
        "add x0,x0,#4".to_string(),
        "b outer".to_string(),
        "done:".to_string(),
        "ret".to_string(),
    ];
    assert_eq!(analyze(program), Ok(()));
}

#[test]
fn nested_loops_still_catch_out_of_bounds_read() {
    let program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "outer:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq done".to_string(),
        "add x2,x0,#0".to_string(),
        "inner:".to_string(),
        "cmp x2,x1".to_string(),
        "b.eq next".to_string(),
        "ldr x4,[x2,#100000]".to_string(),
        "add x2,x2,#4".to_string(),
        "b inner".to_string(),
        "next:".to_string(),
        "add x0,x0,#4".to_string(),
        "b outer".to_string(),
        "done:".to_string(),
        "ret".to_string(),
    ];
    assert!(analyze(program).is_err());
}

#[test]
#[ignore = "detection is gated on no loop being open, so an inner loop never summarizes"]
fn nested_both_accelerated_is_safe() {
    let program = nested_walk(
        SYMBOLIC_LIMIT,
        SYMBOLIC_INNER_LIMIT,
        4,
        4,
        &["ldr w4,[x2,#0]"],
    );
    assert_eq!(analyze_accelerated(program, 4, 4), Ok(()));
}

#[test]
fn nested_both_accelerated_catches_out_of_bounds() {
    let program = nested_walk(
        SYMBOLIC_LIMIT,
        SYMBOLIC_INNER_LIMIT,
        4,
        4,
        &["ldr w4,[x2,#100000]"],
    );
    assert_rejected_access(analyze_accelerated(program, 4, 4));
}

#[test]
fn nested_outer_accelerated_inner_unrolled_is_safe() {
    let program = nested_walk(SYMBOLIC_LIMIT, "add x3,x0,#16", 16, 4, &["ldr w4,[x2,#0]"]);
    assert_eq!(analyze_accelerated(program, 16, 16), Ok(()));
}

#[test]
fn nested_outer_accelerated_inner_unrolled_catches_out_of_bounds() {
    let program = nested_walk(
        SYMBOLIC_LIMIT,
        "add x3,x0,#16",
        16,
        4,
        &["ldr w4,[x2,#100000]"],
    );
    assert_rejected_access(analyze_accelerated(program, 16, 16));
}

#[test]
fn nested_inner_accelerated_outer_unrolled_is_safe() {
    let program = nested_walk(
        "add x5,x0,#8",
        SYMBOLIC_INNER_LIMIT,
        4,
        4,
        &["ldr w4,[x2,#0]"],
    );
    assert_eq!(analyze_accelerated(program, 4, 8), Ok(()));
}

#[test]
fn nested_inner_accelerated_outer_unrolled_catches_out_of_bounds() {
    let program = nested_walk(
        "add x5,x0,#8",
        SYMBOLIC_INNER_LIMIT,
        4,
        4,
        &["ldr w4,[x2,#100000]"],
    );
    assert_rejected_access(analyze_accelerated(program, 4, 8));
}

#[test]
fn nested_both_unrolled_is_safe() {
    let program = nested_walk("add x5,x0,#32", "add x3,x0,#16", 16, 4, &["ldr w4,[x2,#0]"]);
    assert_eq!(analyze_accelerated(program, 4, 32), Ok(()));
}

#[test]
fn nested_both_unrolled_catches_out_of_bounds() {
    let program = nested_walk(
        "add x5,x0,#32",
        "add x3,x0,#16",
        16,
        4,
        &["ldr w4,[x2,#100000]"],
    );
    assert_rejected_access(analyze_accelerated(program, 4, 32));
}

#[test]
fn a_rejected_access_is_reported_with_its_line_and_width() {
    let err = analyze(walking_loop(4, &["ldr x2,[x0,#100000]"])).unwrap_err();
    assert_eq!(
        err,
        "line 5 (ldr): read of 8 bytes at base + 100000 not provably within region of \
         length length"
    );
}

#[test]
fn unbounded_abstract_length_proves_nothing() {
    assert_out_of_bounds(analyze(walking_loop(4, &["ldr w2,[x0,#0]"])), 0);
}

#[test]
fn accelerated_walking_read_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(walking_loop(4, &["ldr w2,[x0,#0]"]), 4, 4),
        Ok(())
    );
}

#[test]
fn accelerated_walking_write_is_proved_safe() {
    assert_eq!(
        analyze_region_accelerated(
            walking_loop(4, &["str w2,[x0,#0]"]),
            RegionType::WRITE,
            4,
            4
        ),
        Ok(())
    );
}

#[test]
fn read_one_element_ahead_is_rejected() {
    assert_rejected_access(analyze_accelerated(
        walking_loop(4, &["ldr w2,[x0,#4]"]),
        4,
        16,
    ));
}

#[test]
fn read_exactly_one_past_the_end_is_rejected() {
    assert_out_of_bounds(
        analyze_with_length(walking_loop(4, &["ldr x2,[x0,#64]"]), length_is(64)),
        64,
    );
}

#[test]
fn read_before_the_slice_is_rejected() {
    assert_out_of_bounds(
        analyze_accelerated(walking_loop(4, &["sub x3,x0,#4", "ldr x2,[x3,#0]"]), 4, 16),
        -4,
    );
}

#[test]
fn read_at_the_exit_pointer_is_rejected() {
    let err = analyze_accelerated(walking_loop_with_tail(4, &[], &["ldr w2,[x0,#0]"]), 4, 16)
        .unwrap_err();
    assert!(err.contains("not provably within region"), "{err}");
    assert!(err.contains("loop0_?"), "{err}");
}

#[test]
fn read_of_the_last_element_after_the_loop_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(walking_loop_with_tail(4, &[], &["ldr w2,[x0,#-4]"]), 4, 16),
        Ok(())
    );
}

#[test]
fn write_one_element_ahead_is_rejected() {
    assert_rejected_access(analyze_region_accelerated(
        walking_loop(4, &["str w2,[x0,#4]"]),
        RegionType::WRITE,
        4,
        16,
    ));
}

#[test]
fn load_wider_than_the_stride_is_rejected_at_the_end() {
    assert_rejected_access(analyze_accelerated(
        walking_loop(4, &["ldr x2,[x0,#0]"]),
        4,
        16,
    ));
}

#[test]
fn zero_length_never_enters_the_loop() {
    assert_eq!(
        analyze_with_length(walking_loop(4, &["ldr w2,[x0,#0]"]), length_is(0)),
        Ok(())
    );
}

#[test]
fn zero_length_still_enters_a_bottom_tested_loop() {
    assert_out_of_bounds(
        analyze_with_length(bottom_tested_loop(&["ldr w2,[x0,#0]"]), length_is(0)),
        0,
    );
}

#[test]
fn accelerated_bottom_tested_loop_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(bottom_tested_loop(&["ldr w2,[x0,#0]"]), 4, 4),
        Ok(())
    );
}

#[test]
fn loop_stopping_one_element_short_makes_the_read_ahead_safe() {
    let mut program = walking_loop(4, &["ldr w2,[x0,#4]"]);
    program.insert(2, "sub x1,x1,#4".to_string());
    assert_eq!(analyze_accelerated(program, 4, 16), Ok(()));
}

#[test]
fn branching_body_is_proved_safe() {
    let program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "loop:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq end".to_string(),
        "ldr w2,[x0,#0]".to_string(),
        "cmp x2,#0".to_string(),
        "b.eq skip".to_string(),
        "ldr w3,[x0,#0]".to_string(),
        "skip:".to_string(),
        "add x0,x0,#4".to_string(),
        "b loop".to_string(),
        "end:".to_string(),
        "ret".to_string(),
    ];
    assert_eq!(analyze_accelerated(program, 4, 4), Ok(()));
}

#[test]
fn back_edge_loop_resolves() {
    let program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "loop:".to_string(),
        "add x0,x0,#4".to_string(),
        "cmp x0,x1".to_string(),
        "b.ne loop".to_string(),
        "ret".to_string(),
    ];
    assert_eq!(analyze(program), Ok(()));
}

#[test]
fn concrete_bound_loop_resolves_without_acceleration() {
    init();
    let program = vec![
        "start:".to_string(),
        "add x1,#0,#0".to_string(),
        "add x2,#0,#4".to_string(),
        "loop:".to_string(),
        "add x1,x1,#1".to_string(),
        "cmp x1,x2".to_string(),
        "b.ne loop".to_string(),
        "ret".to_string(),
    ];
    let mut engine = bums::engine::ExecutionEngine::new(program);
    assert!(engine.start("start".to_string()).is_ok());
}

#[test]
fn acceleration_does_not_depend_on_how_the_length_is_spelled() {
    for name in ["length", "Length", "n", "SIZE_IN_BYTES"] {
        init();
        let mut engine = bums::engine::ExecutionEngine::new(walking_loop(4, &[]));
        engine.add_abstract_from(0, "base");
        engine.add_region(RegionType::READ, "base", abstract_of(name));
        engine.add_abstract_from(1, name);
        assert_eq!(
            engine.start("start").map_err(|e| e.to_string()),
            Ok(()),
            "{name}"
        );
    }
}

#[test]
fn loop_bounded_by_an_unrelated_symbol_is_accelerated() {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(walking_loop(4, &[]));
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(64));
    engine.add_abstract_from(1, "steps");
    assert_eq!(engine.start("start").map_err(|e| e.to_string()), Ok(()));
}

#[test]
fn nonlinear_update_does_not_block_acceleration() {
    assert_eq!(analyze(walking_loop(4, &["mul x3,x3,x3"])), Ok(()));
}

fn analyze_with_length(program: Vec<String>, bound: AbstractComparison) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));
    engine.add_abstract_from(1, "length");
    engine.add_invariant(bound);
    engine.start("start").map_err(|e| e.to_string())
}

fn length_is(n: i64) -> AbstractComparison {
    AbstractComparison::new(
        "==",
        AbstractExpression::Abstract("length".to_string()),
        AbstractExpression::Immediate(n),
    )
}

fn analyze_accelerated(program: Vec<String>, stride: i64, least: i64) -> Result<(), String> {
    analyze_region_accelerated(program, RegionType::READ, stride, least)
}

fn analyze_region_accelerated(
    program: Vec<String>,
    ty: RegionType,
    stride: i64,
    least: i64,
) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(ty, "base", abstract_of("length"));
    engine.add_abstract_from(1, "length");
    engine.add_invariant(AbstractComparison::new(
        "==",
        AbstractExpression::Expression(
            "%".to_string(),
            Box::new(abstract_of("length")),
            Box::new(AbstractExpression::Immediate(stride)),
        ),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("length"),
        AbstractExpression::Immediate(least),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

fn diamond_body_loop(fallthrough: &[&str], arm: &[&str]) -> Vec<String> {
    let mut program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "loop:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq end".to_string(),
        "ldr w2,[x0,#0]".to_string(),
        "cmp x2,#0".to_string(),
        "b.eq other".to_string(),
    ];
    program.extend(fallthrough.iter().map(|s| s.to_string()));
    program.push("b next".to_string());
    program.push("other:".to_string());
    program.extend(arm.iter().map(|s| s.to_string()));
    program.push("next:".to_string());
    program.push("add x0,x0,#4".to_string());
    program.push("b loop".to_string());
    program.push("end:".to_string());
    program.push("ret".to_string());
    program
}

#[test]
fn stride_dividing_the_length_resolves() {
    assert_eq!(
        analyze_with_length(walking_loop(4, &[]), length_is(64)),
        Ok(())
    );
}

#[test]
fn stride_not_dividing_the_length_is_reported() {
    assert_unresolved(analyze_with_length(walking_loop(4, &[]), length_is(10)));
}

fn guarded_loop(body: &[&str]) -> Vec<String> {
    let mut program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "cmp x5,#0".to_string(),
        "b.eq done".to_string(),
        "loop:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq done".to_string(),
    ];
    program.extend(body.iter().map(|s| s.to_string()));
    program.push("add x0,x0,#4".to_string());
    program.push("b loop".to_string());
    program.push("done:".to_string());
    program.push("ret".to_string());
    program
}

fn analyze_guarded(program: Vec<String>, least: i64) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));
    engine.add_abstract_from(1, "length");
    engine.add_abstract_from(5, "flag");
    engine.add_invariant(AbstractComparison::new(
        "==",
        AbstractExpression::Expression(
            "%".to_string(),
            Box::new(abstract_of("length")),
            Box::new(AbstractExpression::Immediate(4)),
        ),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("length"),
        AbstractExpression::Immediate(least),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn loop_reached_only_through_a_branch_is_accelerated() {
    assert_eq!(
        analyze_guarded(guarded_loop(&["ldr w2,[x0,#0]"]), 4),
        Ok(())
    );
}

#[test]
fn loop_reached_only_through_a_branch_still_catches_out_of_bounds() {
    assert_rejected_access(analyze_guarded(guarded_loop(&["ldr w2,[x0,#4]"]), 16));
}

#[test]
fn interleaved_accesses_around_a_branch_are_proved_safe() {
    let program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "loop:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq end".to_string(),
        "ldr w2,[x0,#0]".to_string(),
        "cmp x2,#0".to_string(),
        "b.eq skip".to_string(),
        "ldr w3,[x0,#0]".to_string(),
        "skip:".to_string(),
        "ldr w4,[x0,#0]".to_string(),
        "add x0,x0,#4".to_string(),
        "b loop".to_string(),
        "end:".to_string(),
        "ret".to_string(),
    ];
    assert_eq!(analyze_accelerated(program, 4, 4), Ok(()));
}

#[test]
fn nested_branches_in_the_body_are_proved_safe() {
    let program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "loop:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq end".to_string(),
        "ldr w2,[x0,#0]".to_string(),
        "cmp x2,#0".to_string(),
        "b.eq outer_skip".to_string(),
        "cmp x2,#1".to_string(),
        "b.eq inner_skip".to_string(),
        "ldr w3,[x0,#0]".to_string(),
        "inner_skip:".to_string(),
        "ldr w4,[x0,#0]".to_string(),
        "outer_skip:".to_string(),
        "add x0,x0,#4".to_string(),
        "b loop".to_string(),
        "end:".to_string(),
        "ret".to_string(),
    ];
    assert_eq!(analyze_accelerated(program, 4, 4), Ok(()));
}

#[test]
fn early_exit_from_the_body_is_accelerated() {
    let program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "loop:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq end".to_string(),
        "ldr w2,[x0,#0]".to_string(),
        "cmp x2,#0".to_string(),
        "b.eq end".to_string(),
        "add x0,x0,#4".to_string(),
        "b loop".to_string(),
        "end:".to_string(),
        "ret".to_string(),
    ];
    assert_eq!(analyze_accelerated(program, 4, 4), Ok(()));
}

#[test]
fn early_exit_from_a_bottom_tested_body_is_accelerated() {
    let program = [
        "start:",
        "add x1,x0,x1",
        "loop:",
        "ldr w2,[x0,#0]",
        "cmp x2,#0",
        "b.eq end",
        "add x0,x0,#4",
        "cmp x0,x1",
        "b.ne loop",
        "end:",
        "ret",
    ];
    assert_eq!(
        analyze_accelerated(program.iter().map(|s| s.to_string()).collect(), 4, 4),
        Ok(())
    );
}

fn analyze_copy(program: Vec<String>) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));
    engine.add_abstract_from(1, "length");
    engine.add_abstract_from(2, "out");
    engine.add_region(RegionType::RW, "out", abstract_of("out_len"));
    engine.add_abstract_from(3, "out_len");
    for name in ["length", "out_len"] {
        engine.add_invariant(AbstractComparison::new(
            "==",
            AbstractExpression::Expression(
                "%".to_string(),
                Box::new(abstract_of(name)),
                Box::new(AbstractExpression::Immediate(4)),
            ),
            AbstractExpression::Immediate(0),
        ));
        engine.add_invariant(AbstractComparison::new(
            ">=",
            abstract_of(name),
            AbstractExpression::Immediate(4),
        ));
    }
    engine.start("start").map_err(|e| e.to_string())
}

fn copy_body(write_before_check: bool) -> Vec<&'static str> {
    let write = "str w4,[x2,#0]";
    let mut body = vec!["ldr w4,[x0,#0]"];
    if write_before_check {
        body.push(write);
    }
    body.extend(["cmp x2,x3", "b.eq done"]);
    if !write_before_check {
        body.push(write);
    }
    body.extend(["add x0,x0,#4", "add x2,x2,#4"]);
    body
}

fn copy_loop(top_tested: bool, write_before_check: bool) -> Vec<String> {
    let mut program = vec!["start:", "add x1,x0,x1", "add x3,x2,x3", "loop:"];
    if top_tested {
        program.extend(["cmp x0,x1", "b.eq done"]);
        program.extend(copy_body(write_before_check));
        program.push("b loop");
    } else {
        program.extend(copy_body(write_before_check));
        program.extend(["cmp x0,x1", "b.ne loop"]);
    }
    program.extend(["done:", "ret"]);
    program.iter().map(|s| s.to_string()).collect()
}

fn refilling_copy_loop(top_tested: bool, write_before_check: bool) -> Vec<String> {
    let mut program = vec![
        "start:",
        "add x1,x0,x1",
        "add x3,x2,x3",
        "add x5,x0,#0",
        "add x9,#0,#2",
        "block:",
        "add x0,x5,#0",
        "lane:",
    ];
    if top_tested {
        program.extend(["cmp x0,x1", "b.eq refill"]);
        program.extend(copy_body(write_before_check));
        program.extend(["b lane", "refill:"]);
    } else {
        program.extend(copy_body(write_before_check));
        program.extend(["cmp x0,x1", "b.ne lane"]);
    }
    program.extend([
        "add x8,x8,x4",
        "sub x9,x9,#1",
        "cmp x9,#0",
        "b.ne block",
        "done:",
        "ret",
    ]);
    program.iter().map(|s| s.to_string()).collect()
}

#[test]
fn top_tested_copy_that_stops_when_the_output_fills_is_proved_safe() {
    assert_eq!(analyze_copy(copy_loop(true, false)), Ok(()));
}

#[test]
fn top_tested_copy_writing_before_the_output_check_is_rejected() {
    assert_rejected_access(analyze_copy(copy_loop(true, true)));
}

#[test]
fn bottom_tested_copy_that_stops_when_the_output_fills_is_proved_safe() {
    assert_eq!(analyze_copy(copy_loop(false, false)), Ok(()));
}

#[test]
fn bottom_tested_copy_writing_before_the_output_check_is_rejected() {
    assert_rejected_access(analyze_copy(copy_loop(false, true)));
}

#[test]
fn top_tested_lane_loop_reentered_after_a_refill_is_proved_safe() {
    assert_eq!(analyze_copy(refilling_copy_loop(true, false)), Ok(()));
}

#[test]
fn top_tested_lane_loop_writing_before_the_output_check_is_rejected() {
    assert_rejected_access(analyze_copy(refilling_copy_loop(true, true)));
}

#[test]
fn bottom_tested_lane_loop_reentered_after_a_refill_is_proved_safe() {
    assert_eq!(analyze_copy(refilling_copy_loop(false, false)), Ok(()));
}

#[test]
fn bottom_tested_lane_loop_writing_before_the_output_check_is_rejected() {
    assert_rejected_access(analyze_copy(refilling_copy_loop(false, true)));
}

fn refill_into_the_lane_header(write_before_check: bool) -> Vec<String> {
    let mut program = vec![
        "start:",
        "add x1,x0,x1",
        "add x3,x2,x3",
        "add x5,x0,#0",
        "add x9,#0,#2",
        "lane:",
    ];
    program.extend(copy_body(write_before_check));
    program.extend([
        "cmp x0,x1",
        "b.ne lane",
        "add x0,x5,#0",
        "sub x9,x9,#1",
        "cmp x9,#0",
        "b.ne lane",
        "done:",
        "ret",
    ]);
    program.iter().map(|s| s.to_string()).collect()
}

#[test]
fn lane_loop_refilled_straight_into_its_header_is_proved_safe() {
    assert_eq!(analyze_copy(refill_into_the_lane_header(false)), Ok(()));
}

#[test]
fn lane_loop_refilled_straight_into_its_header_writing_before_the_output_check_is_rejected() {
    assert_rejected_access(analyze_copy(refill_into_the_lane_header(true)));
}

fn squeeze_until_the_output_fills(write_before_check: bool) -> Vec<String> {
    let write = "str w4,[x2,#0]";
    let mut program = vec![
        "start:",
        "add x5,x0,#0",
        "add x6,x1,#0",
        "add x9,x0,#0",
        "add x10,x1,#0",
        "lane:",
        "ldr w4,[x9,#0]",
    ];
    if write_before_check {
        program.push(write);
    }
    program.extend(["cmp x3,#4", "b.lo done"]);
    if !write_before_check {
        program.push(write);
    }
    program.extend([
        "add x9,x9,#4",
        "add x2,x2,#4",
        "sub x3,x3,#4",
        "subs x10,x10,#4",
        "b.hi lane",
        "add x9,x5,#0",
        "add x10,x6,#0",
        "b lane",
        "done:",
        "ret",
    ]);
    program.iter().map(|s| s.to_string()).collect()
}

#[test]
fn lanes_squeezed_until_the_output_fills_are_proved_safe() {
    assert_eq!(analyze_copy(squeeze_until_the_output_fills(false)), Ok(()));
}

#[test]
fn lanes_squeezed_writing_before_the_output_check_are_rejected() {
    assert_rejected_access(analyze_copy(squeeze_until_the_output_fills(true)));
}

fn squeeze_lanes(rate_limit: i64) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "add x19,x0,#0",
        "add x20,x2,#0",
        "add x21,x3,#0",
        "add x22,x1,#0",
        "add x3,x1,#0",
        "loop:",
        "ldr x4,[x0],#8",
        "cmp x21,#8",
        "b.lo tail",
        "str x4,[x20],#8",
        "subs x21,x21,#8",
        "b.eq done",
        "subs x3,x3,#8",
        "b.hi loop",
        "add x0,x19,#0",
        "add x3,x22,#0",
        "b loop",
        "tail:",
        "strb w4,[x20],#1",
        "done:",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "lanes");
    engine.add_region(RegionType::READ, "lanes", AbstractExpression::Immediate(64));
    engine.add_abstract_from(1, "rate");
    engine.add_abstract_from(2, "out");
    engine.add_region(RegionType::RW, "out", abstract_of("out_len"));
    engine.add_abstract_from(3, "out_len");
    for (name, limit) in [("rate", Some(rate_limit)), ("out_len", None)] {
        engine.add_invariant(AbstractComparison::new(
            "==",
            AbstractExpression::Expression(
                "%".to_string(),
                Box::new(abstract_of(name)),
                Box::new(AbstractExpression::Immediate(8)),
            ),
            AbstractExpression::Immediate(0),
        ));
        engine.add_invariant(AbstractComparison::new(
            ">=",
            abstract_of(name),
            AbstractExpression::Immediate(8),
        ));
        if let Some(limit) = limit {
            engine.add_invariant(AbstractComparison::new(
                "<=",
                abstract_of(name),
                AbstractExpression::Immediate(limit),
            ));
        }
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn squeezed_lanes_that_fit_the_state_are_proved_safe() {
    assert_eq!(squeeze_lanes(64), Ok(()));
}

#[test]
fn squeezed_lanes_one_past_the_state_are_rejected() {
    assert_rejected_access(squeeze_lanes(72));
}

fn analyze_symbolic_stride(program: Vec<String>, table_len: i64) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));
    engine.add_abstract_from(1, "length");
    engine.add_abstract_from(3, "s");
    engine.add_abstract_from(5, "table");
    engine.add_region(
        RegionType::READ,
        "table",
        AbstractExpression::Immediate(table_len),
    );
    engine.add_invariant(AbstractComparison::new(
        "==",
        AbstractExpression::Expression(
            "%".to_string(),
            Box::new(abstract_of("length")),
            Box::new(AbstractExpression::Immediate(8)),
        ),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("length"),
        AbstractExpression::Immediate(128),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        abstract_of("length"),
        AbstractExpression::Immediate(168),
    ));
    engine.add_invariant(AbstractComparison::new(
        "==",
        abstract_of("s"),
        AbstractExpression::Immediate(8),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

fn remaining_length_stepped_by_a_symbol() -> Vec<String> {
    [
        "start:",
        "add x2,x1,#0",
        "loop:",
        "cmp x2,x3",
        "b.lo done",
        "ldr x4,[x5,#0]",
        "add x5,x5,#8",
        "add x0,x0,#8",
        "sub x2,x2,x3",
        "b loop",
        "done:",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect()
}

#[test]
fn a_table_walked_beside_a_symbolic_countdown_is_proved_safe_when_every_entry_fits() {
    assert_eq!(
        analyze_symbolic_stride(remaining_length_stepped_by_a_symbol(), 168),
        Ok(())
    );
}

#[test]
fn a_table_walked_beside_a_symbolic_countdown_is_rejected_when_the_last_entry_is_missing() {
    let err = analyze_symbolic_stride(remaining_length_stepped_by_a_symbol(), 160)
        .expect_err("the last iteration reads one entry past the table");
    assert!(err.contains("table + loop"), "{err}");
}

fn word_copy_with_a_byte_tail(tail_write: &str) -> Vec<String> {
    [
        "start:",
        "loop:",
        "cmp x3,#8",
        "b.lo tail",
        "str x4,[x2,#0]",
        "b.eq done",
        "add x2,x2,#8",
        "sub x3,x3,#8",
        "b loop",
        "tail:",
        tail_write,
        "done:",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect()
}

#[test]
fn a_tail_after_the_guard_exit_keeps_what_the_last_iteration_proved() {
    let program = word_copy_with_a_byte_tail("strb w4,[x2,#0]");
    assert_eq!(analyze_copy(program), Ok(()));
}

#[test]
fn a_tail_writing_a_full_word_after_the_guard_exit_is_rejected() {
    let program = word_copy_with_a_byte_tail("str x4,[x2,#0]");
    assert_rejected_access(analyze_copy(program));
}

#[test]
fn diamond_arms_updating_one_register_close_the_loop() {
    let program = diamond_body_loop(&["ldr w3,[x0,#0]"], &["ldr w3,[x0,#0]"]);
    assert_eq!(analyze_accelerated(program, 4, 4), Ok(()));
}

#[test]
fn diamond_arms_updating_different_registers_close_the_loop_after_widening() {
    let program = diamond_body_loop(&["add x3,x3,#1"], &["add x4,x4,#1"]);
    assert_eq!(analyze_accelerated(program, 4, 4), Ok(()));
}

#[test]
fn arms_advancing_the_pointer_differently_do_not_close_the_loop() {
    let program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "loop:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq end".to_string(),
        "ldr w2,[x0,#0]".to_string(),
        "cmp x2,#0".to_string(),
        "b.eq slow".to_string(),
        "add x0,x0,#8".to_string(),
        "b loop".to_string(),
        "slow:".to_string(),
        "add x0,x0,#4".to_string(),
        "b loop".to_string(),
        "end:".to_string(),
        "ret".to_string(),
    ];
    assert_rejected_access(analyze_accelerated(program, 4, 4));
}

fn rotated_loop(stride: i64, body: &[&str]) -> Vec<String> {
    let mut program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "cmp x0,x1".to_string(),
        "loop:".to_string(),
        "b.eq end".to_string(),
    ];
    program.extend(body.iter().map(|s| s.to_string()));
    program.push(format!("add x0,x0,#{stride}"));
    program.push("cmp x0,x1".to_string());
    program.push("b loop".to_string());
    program.push("end:".to_string());
    program.push("ret".to_string());
    program
}

#[test]
fn accelerates_loop_with_a_flag_live_across_the_back_edge() {
    assert_eq!(analyze(rotated_loop(4, &[])), Ok(()));
}

#[test]
#[ignore = "slow: unrolls to MAX_BRANCH_DEPTH"]
fn growing_stride_is_reported() {
    let program = walking_loop(4, &["add x2,x2,#4", "add x0,x0,x2"]);
    assert_eq!(
        analyze(program),
        Err("branch exploration too deep".to_string())
    );
}

#[test]
fn accelerated_read_in_a_rotated_loop_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(rotated_loop(8, &["ldr x2,[x0,#0]"]), 8, 8),
        Ok(())
    );
}

#[test]
fn read_one_element_ahead_in_a_rotated_loop_is_rejected() {
    assert_out_of_bounds(
        analyze_accelerated(rotated_loop(8, &["ldr x2,[x0,#8]"]), 8, 16),
        16,
    );
}

fn select_stride_loop(stride: i64, body: &[&str]) -> Vec<String> {
    let mut program = vec!["start:".to_string(), "loop:".to_string()];
    program.extend(body.iter().map(|s| s.to_string()));
    program.push(format!("subs x1,x1,#{stride}"));
    program.push(format!("mov x4,#{stride}"));
    program.push("csel x4,xzr,x4,eq".to_string());
    program.push("add x0,x0,x4".to_string());
    program.push("b.hs loop".to_string());
    program.push("ret".to_string());
    program
}

#[test]
fn a_two_valued_select_stride_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(select_stride_loop(8, &["ldr x2,[x0]"]), 8, 8),
        Ok(())
    );
}

#[test]
fn a_two_valued_select_stride_still_catches_a_read_ahead() {
    assert_rejected_access(analyze_accelerated(
        select_stride_loop(8, &["ldr x2,[x0,#8]"]),
        8,
        8,
    ));
}

#[test]
fn a_two_valued_select_stride_still_catches_a_write_ahead() {
    assert_rejected_access(analyze_region_accelerated(
        select_stride_loop(8, &["str x2,[x0,#8]"]),
        RegionType::WRITE,
        8,
        8,
    ));
}

#[test]
fn a_two_valued_select_stride_proves_nothing_unbounded() {
    assert!(analyze(select_stride_loop(8, &["ldr x2,[x0]"])).is_err());
}

fn chained_select_stride_loop(stride: i64, body: &[&str]) -> Vec<String> {
    let mut program = vec![
        "start:".to_string(),
        format!("mov x4,#{stride}"),
        "loop:".to_string(),
    ];
    program.extend(body.iter().map(|s| s.to_string()));
    program.push(format!("subs x1,x1,#{stride}"));
    program.push("csel x4,xzr,x4,eq".to_string());
    program.push("add x0,x0,x4".to_string());
    program.push("b.hs loop".to_string());
    program.push("ret".to_string());
    program
}

#[test]
fn a_chained_select_stride_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(chained_select_stride_loop(8, &["ldr x2,[x0]"]), 8, 8),
        Ok(())
    );
}

fn select_stride_choosing(condition: &[&str], when: &str, rare: i64) -> Vec<String> {
    let mut program = vec!["start:".to_string(), "loop:".to_string()];
    program.push("ldr x2,[x0]".to_string());
    program.extend(condition.iter().map(|s| s.to_string()));
    program.push("mov x4,#8".to_string());
    program.push(format!("mov x6,#{rare}"));
    program.push(format!("csel x4,x6,x4,{when}"));
    program.push("add x0,x0,x4".to_string());
    program.push("subs x1,x1,#8".to_string());
    program.push("b.hs loop".to_string());
    program.push("ret".to_string());
    program
}

fn analyze_with_one_step_of_slack(program: Vec<String>) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(
        RegionType::READ,
        "base",
        generate_expression("+", abstract_of("length"), AbstractExpression::Immediate(8)),
    );
    engine.add_abstract_from(1, "length");
    engine.add_invariant(AbstractComparison::new(
        "==",
        generate_expression("%", abstract_of("length"), AbstractExpression::Immediate(8)),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("length"),
        AbstractExpression::Immediate(8),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_larger_step_chosen_by_data_is_not_assumed_to_be_rare() {
    let program = select_stride_choosing(&["ldr x5,[x0]", "cmp x5,#0"], "eq", 16);
    assert!(analyze_with_one_step_of_slack(program).is_err());
}

#[test]
fn a_larger_step_chosen_mid_loop_is_not_assumed_to_be_the_latest() {
    let program = select_stride_choosing(&["cmp x1,#64"], "hs", 16);
    assert!(analyze_with_one_step_of_slack(program).is_err());
}

#[test]
fn a_chained_select_stride_still_catches_a_read_ahead() {
    assert_rejected_access(analyze_accelerated(
        chained_select_stride_loop(8, &["ldr x2,[x0,#8]"]),
        8,
        8,
    ));
}

fn negated_chained_select_stride_loop(body: &[&str]) -> Vec<String> {
    let mut program = vec!["start:", "mov x4,#8", "loop:"];
    program.extend(body);
    program.extend([
        "subs x1,x1,#8",
        "csel x4,x4,xzr,ne",
        "add x0,x0,x4",
        "b.hs loop",
        "ret",
    ]);
    program.iter().map(|s| s.to_string()).collect()
}

#[test]
fn a_chained_select_stride_spelled_with_ne_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(negated_chained_select_stride_loop(&["ldr x2,[x0]"]), 8, 8),
        Ok(())
    );
}

#[test]
fn a_chained_select_stride_spelled_with_ne_still_catches_a_read_ahead() {
    assert_rejected_access(analyze_accelerated(
        negated_chained_select_stride_loop(&["ldr x2,[x0,#8]"]),
        8,
        8,
    ));
}

fn stepping_loop(choose_step: &[&str]) -> Vec<String> {
    let mut program = vec!["start:", "loop:", "ldr x2,[x0]", "subs x1,x1,#8"];
    program.extend(choose_step);
    program.extend(["cmp x1,#0", "b.ge loop", "ret"]);
    program.iter().map(|s| s.to_string()).collect()
}

#[test]
fn a_common_larger_step_is_never_treated_as_the_rare_one() {
    let program = stepping_loop(&[
        "mov x4,#8",
        "mov x6,#16",
        "cmp x1,#0",
        "csel x4,x6,x4,ne",
        "add x0,x0,x4",
    ]);
    assert!(analyze_accelerated(program, 8, 64).is_err());
}

fn analyze_with_slack(program: Vec<String>, slack: i64) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(
        RegionType::READ,
        "base",
        generate_expression(
            "+",
            abstract_of("length"),
            AbstractExpression::Immediate(slack),
        ),
    );
    engine.add_abstract_from(1, "length");
    engine.add_invariant(AbstractComparison::new(
        "==",
        generate_expression("%", abstract_of("length"), AbstractExpression::Immediate(8)),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("length"),
        AbstractExpression::Immediate(8),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_common_larger_step_with_slack_for_one_overshoot_is_rejected() {
    let program = stepping_loop(&[
        "mov x4,#8",
        "mov x6,#16",
        "cmp x1,#0",
        "csel x4,x6,x4,ne",
        "add x0,x0,x4",
    ]);
    assert!(analyze_with_slack(program, 32).is_err());
}

#[test]
fn a_three_way_step_that_overshoots_mid_loop_is_rejected() {
    let program = stepping_loop(&[
        "mov x4,#8",
        "mov x6,#24",
        "cmp x1,#16",
        "csel x4,x6,x4,eq",
        "cmp x1,#0",
        "csel x4,xzr,x4,eq",
        "add x0,x0,x4",
    ]);
    assert!(analyze_accelerated(program, 8, 64).is_err());
}

#[test]
fn a_step_summing_two_selects_that_overshoots_is_rejected() {
    let program = stepping_loop(&[
        "mov x4,#8",
        "cmp x1,#0",
        "csel x4,xzr,x4,eq",
        "mov x6,#16",
        "cmp x1,#16",
        "csel x5,x6,xzr,eq",
        "add x0,x0,x4",
        "add x0,x0,x5",
    ]);
    assert!(analyze_accelerated(program, 8, 64).is_err());
}

#[test]
fn a_rare_step_taken_from_memory_is_not_trusted() {
    let program = stepping_loop(&[
        "ldr x5,[x0]",
        "mov x4,#8",
        "cmp x1,#0",
        "csel x4,x5,x4,eq",
        "add x0,x0,x4",
    ]);
    assert!(analyze_accelerated(program, 8, 64).is_err());
}

fn shared_header_loop(reenter_on: &str) -> Vec<String> {
    [
        "start:",
        "mov x3,#2",
        "loop:",
        "subs x3,x3,#1",
        "b.gt loop",
        "ldr x2,[x0]",
        "add x0,x0,#8",
        "mov x3,#2",
        "subs x1,x1,#8",
        "b.hi loop",
        "cmp x1,#0",
        reenter_on,
        "ret",
    ]
    .map(String::from)
    .to_vec()
}

#[test]
fn an_outer_loop_sharing_its_header_with_a_round_loop_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(shared_header_loop("b.lt loop"), 8, 8),
        Ok(())
    );
}

#[test]
fn reentering_a_shared_header_loop_past_the_end_is_rejected() {
    assert_rejected_access(analyze_accelerated(shared_header_loop("b.eq loop"), 8, 8));
}

fn clobbered_guard_loop(read: &str) -> Vec<String> {
    [
        "start:",
        "add x5,x0,x1",
        "loop:",
        read,
        "add x0,x0,#8",
        "sub x3,x5,x0",
        "cmp x3,#0",
        "mov x3,#0",
        "b.ne loop",
        "ret",
    ]
    .map(String::from)
    .to_vec()
}

#[test]
fn a_guard_on_a_clobbered_register_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(clobbered_guard_loop("ldr x2,[x0]"), 8, 8),
        Ok(())
    );
}

#[test]
fn a_guard_on_a_clobbered_register_still_catches_a_read_ahead() {
    assert_rejected_access(analyze_accelerated(
        clobbered_guard_loop("ldr x2,[x0,#8]"),
        8,
        8,
    ));
}

fn analyze_long_decided_walk(read: &str) -> Result<(), String> {
    init();
    let program = [
        "start:",
        "add x5,x0,x1",
        "loop:",
        read,
        "add x0,x0,#8",
        "cmp x0,x5",
        "b.ne loop",
        "ret",
    ]
    .map(String::from)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));
    engine.add_abstract_from(1, "length");
    engine.add_invariant(AbstractComparison::new(
        "==",
        AbstractExpression::Expression(
            "%".to_string(),
            Box::new(abstract_of("length")),
            Box::new(AbstractExpression::Immediate(8)),
        ),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("length"),
        AbstractExpression::Immediate(4096),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        abstract_of("length"),
        AbstractExpression::Immediate(8192),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_guard_decided_for_hundreds_of_iterations_is_summarized() {
    assert_eq!(analyze_long_decided_walk("ldr x2,[x0]"), Ok(()));
}

#[test]
fn a_guard_decided_for_hundreds_of_iterations_still_catches_a_read_ahead() {
    assert_rejected_access(analyze_long_decided_walk("ldr x2,[x0,#8]"));
}

fn rewinding_last_block_loop(adjust: &str) -> Vec<String> {
    [
        "start:",
        "ldr x5,[x0]",
        "add x0,x0,#8",
        "loop:",
        "subs x1,x1,#8",
        adjust,
        "csel x0,x0,x4,ne",
        "ldr x5,[x0],#8",
        "cbnz x1,loop",
        "ret",
    ]
    .map(String::from)
    .to_vec()
}

#[test]
fn rewinding_the_pointer_on_the_last_block_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(rewinding_last_block_loop("sub x4,x0,#8"), 8, 8),
        Ok(())
    );
}

#[test]
fn skipping_ahead_on_the_last_block_is_rejected() {
    assert_rejected_access(analyze_accelerated(
        rewinding_last_block_loop("add x4,x0,#8"),
        8,
        8,
    ));
}

fn analyze_counted_staging(store: &str) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "mov w6, #1",
        "dup v31.8h, w6",
        "mov x9, #0",
        "add x7, x0, #0",
        "loop:",
        "cmp x9, #24",
        "b.hs done",
        "ld1 {v5.16b}, [x2]",
        "and v4.16b, v5.16b, v31.16b",
        "uaddlv s20, v4.8h",
        "fmov w12, s20",
        store,
        "add x7, x7, x12, lsl #1",
        "add x9, x9, x12",
        "b loop",
        "done:",
        "ret",
    ]
    .map(String::from)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "staging");
    engine.add_region(RegionType::RW, "staging", AbstractExpression::Immediate(64));
    engine.add_abstract_from(2, "source");
    engine.add_region(
        RegionType::READ,
        "source",
        AbstractExpression::Immediate(16),
    );
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_pointer_that_moves_twice_as_far_as_a_count_is_bounded_by_the_count() {
    assert_eq!(analyze_counted_staging("str x5, [x7]"), Ok(()));
}

#[test]
fn a_pointer_tracking_a_count_still_catches_a_store_past_the_end() {
    assert_rejected_access(analyze_counted_staging("str x5, [x7, #16]"));
}

fn schoolbook_multiply() -> Vec<String> {
    [
        "start:",
        "cbz x0, end",
        "mov x6, xzr",
        "mov x7, xzr",
        "mov x9, xzr",
        "outerloop:",
        "mov x8, xzr",
        "add x11, x9, #1",
        "cmp x11, x2",
        "csel x12, x11, x2, cc",
        "subs x11, x11, x4",
        "csel x11, x11, xzr, cs",
        "subs x10, x12, x11",
        "b.ls innerend",
        "lsl x14, x11, #3",
        "add x14, x14, x3",
        "sub x15, x9, x12",
        "lsl x15, x15, #3",
        "add x15, x15, x5",
        "innerloop:",
        "ldr x11, [x14], #8",
        "ldr x12, [x15, x10, lsl #3]",
        "mul x13, x11, x12",
        "umulh x11, x11, x12",
        "adds x6, x6, x13",
        "adcs x7, x7, x11",
        "adc x8, x8, xzr",
        "subs x10, x10, #1",
        "b.ne innerloop",
        "innerend:",
        "str x6, [x1, x9, lsl #3]",
        "mov x6, x7",
        "mov x7, x8",
        "add x9, x9, #1",
        "cmp x9, x0",
        "b.cc outerloop",
        "end:",
        "ret",
    ]
    .map(String::from)
    .to_vec()
}

fn analyze_multiply(extra_z: i64, extra_x: i64, extra_y: i64) -> Result<(), String> {
    init();
    let count = |name: &str, extra: i64| {
        generate_expression("+", abstract_of(name), AbstractExpression::Immediate(extra))
    };
    let words =
        |name: &str| generate_expression("*", abstract_of(name), AbstractExpression::Immediate(8));
    let mut engine = bums::engine::ExecutionEngine::new(schoolbook_multiply());
    engine.add_abstract_expression_from(0, count("z_len", extra_z));
    engine.add_abstract_from(1, "z");
    engine.add_region(RegionType::WRITE, "z", words("z_len"));
    engine.add_abstract_expression_from(2, count("x_len", extra_x));
    engine.add_abstract_from(3, "x");
    engine.add_region(RegionType::READ, "x", words("x_len"));
    engine.add_abstract_expression_from(4, count("y_len", extra_y));
    engine.add_abstract_from(5, "y");
    engine.add_region(RegionType::READ, "y", words("y_len"));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn pointers_recomputed_every_iteration_do_not_block_the_outer_summary() {
    assert_eq!(analyze_multiply(0, 0, 0), Ok(()));
}

#[test]
fn a_multiply_told_a_longer_operand_than_its_region_is_rejected() {
    assert!(analyze_multiply(1, 0, 0).is_err());
    assert!(analyze_multiply(0, 1, 0).is_err());
    assert!(analyze_multiply(0, 0, 1).is_err());
}

#[test]
fn a_pointer_read_before_it_is_recomputed_is_not_forgotten() {
    let program = [
        "start:",
        "mov x4,#8",
        "mov x3,x0",
        "loop:",
        "cbz x2,skip",
        "add x3,x0,x4",
        "skip:",
        "ldr x5,[x3]",
        "add x4,x4,x4",
        "add x3,x3,x4",
        "subs x1,x1,#8",
        "b.hs loop",
        "ret",
    ]
    .map(String::from)
    .to_vec();
    assert!(analyze(program).is_err());
}

fn analyze_rewinding_rounds(read: &str, after_rewind: &[&str]) -> Result<(), String> {
    init();
    let mut program: Vec<String> = [
        "start:",
        "lsr x5,x1,#2",
        "cbz x5,end",
        "cbz x2,end",
        "lsl x5,x5,#5",
        "outer:",
        "mov x3,x5",
        "inner:",
        read,
        "add x0,x0,#32",
        "subs x3,x3,#32",
        "b.ne inner",
        "sub x0,x0,x5",
    ]
    .map(String::from)
    .to_vec();
    program.extend(after_rewind.iter().map(|s| s.to_string()));
    program.extend(["subs x2,x2,#1", "b.ne outer", "end:", "ret"].map(String::from));
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(
        RegionType::READ,
        "base",
        generate_expression("*", abstract_of("words"), AbstractExpression::Immediate(8)),
    );
    engine.add_abstract_from(1, "words");
    engine.add_abstract_from(2, "rounds");
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_pointer_rewound_by_the_inner_count_lets_the_outer_loop_close() {
    assert_eq!(analyze_rewinding_rounds("ldr x4,[x0,#24]", &[]), Ok(()));
}

#[test]
fn a_pointer_rewound_short_of_the_inner_count_is_rejected() {
    assert!(analyze_rewinding_rounds("ldr x4,[x0,#24]", &["add x0,x0,#8"]).is_err());
}

#[test]
fn a_rewinding_walk_that_reads_one_word_past_the_end_is_rejected() {
    assert!(analyze_rewinding_rounds("ldr x4,[x0,#32]", &[]).is_err());
}

fn analyze_with_stack_frame(
    before: &[&str],
    body: &[&str],
    after: &[&str],
    region_length: AbstractExpression,
) -> Result<(), String> {
    init();
    let mut program = vec!["start:", "sub sp,sp,#16"];
    program.extend(before);
    program.push("loop:");
    program.extend(body);
    program.extend(["b.ne loop", "end:"]);
    program.extend(after);
    program.extend(["add sp,sp,#16", "ret"]);
    let program: Vec<String> = program.iter().map(|s| s.to_string()).collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", region_length);
    engine.add_abstract_from(1, "count");
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("count"),
        AbstractExpression::Immediate(1),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

const EIGHT_BYTES: AbstractExpression = AbstractExpression::Immediate(8);

fn index_kept_on_the_stack(step: &str, after_store: &str) -> Result<(), String> {
    index_on_the_stack_from(0, step, after_store)
}

fn index_on_the_stack_from(first: i64, step: &str, after_store: &str) -> Result<(), String> {
    let set = format!("mov x9,#{first}");
    analyze_with_stack_frame(
        &[set.as_str(), "str x9,[sp,#8]"],
        &[
            "ldr x9,[sp,#8]",
            "ldrb w10,[x0,x9]",
            step,
            "str x9,[sp,#8]",
            after_store,
            "subs x1,x1,#1",
        ],
        &[],
        EIGHT_BYTES,
    )
}

#[test]
fn an_index_kept_only_on_the_stack_still_walks_off_the_region() {
    assert!(index_kept_on_the_stack("add x9,x9,#1", "mov x9,#0").is_err());
}

#[test]
fn an_index_reloaded_from_the_stack_each_iteration_still_walks_off_the_region() {
    assert!(index_kept_on_the_stack("add x9,x9,#1", "nop").is_err());
}

#[test]
fn an_index_on_the_stack_that_doubles_is_not_given_a_step() {
    assert!(index_on_the_stack_from(1, "add x9,x9,x9", "nop").is_err());
    assert_eq!(index_on_the_stack_from(0, "add x9,x9,x9", "nop"), Ok(()));
}

fn counter_kept_on_the_stack(read: &str) -> Result<(), String> {
    analyze_with_stack_frame(
        &["str x1,[sp,#8]"],
        &[
            read,
            "add x0,x0,#1",
            "ldr x9,[sp,#8]",
            "subs x9,x9,#1",
            "str x9,[sp,#8]",
        ],
        &[],
        abstract_of("count"),
    )
}

#[test]
fn a_counter_kept_on_the_stack_bounds_the_walk() {
    assert_eq!(counter_kept_on_the_stack("ldrb w10,[x0]"), Ok(()));
}

#[test]
fn a_counter_kept_on_the_stack_still_catches_a_read_past_the_end() {
    assert!(counter_kept_on_the_stack("ldrb w10,[x0,#1]").is_err());
}

fn slot_rewritten_with_the_same_value(value: i64) -> Result<(), String> {
    let set = format!("mov x5,#{value}");
    analyze_with_stack_frame(
        &[set.as_str()],
        &["str x5,[sp,#8]", "subs x1,x1,#1"],
        &["ldr x9,[sp,#8]", "ldrb w10,[x0,x9]"],
        EIGHT_BYTES,
    )
}

#[test]
fn a_slot_rewritten_with_the_same_value_keeps_it_after_the_loop() {
    assert_eq!(slot_rewritten_with_the_same_value(7), Ok(()));
    assert!(slot_rewritten_with_the_same_value(8).is_err());
}

fn slot_the_loop_never_writes(value: i64) -> Result<(), String> {
    let set = format!("mov x5,#{value}");
    analyze_with_stack_frame(
        &[set.as_str(), "str x5,[sp,#8]"],
        &["add x6,x6,#1", "subs x1,x1,#1"],
        &["ldr x9,[sp,#8]", "ldrb w10,[x0,x9]"],
        EIGHT_BYTES,
    )
}

#[test]
fn a_slot_the_loop_never_writes_keeps_its_value() {
    assert_eq!(slot_the_loop_never_writes(7), Ok(()));
    assert!(slot_the_loop_never_writes(8).is_err());
}

#[test]
fn a_slot_whose_value_the_loop_loses_is_unknown_afterwards() {
    let result = analyze_with_stack_frame(
        &["mov x9,#1", "str x9,[sp,#8]"],
        &[
            "ldr x9,[sp,#8]",
            "add x9,x9,x9",
            "str x9,[sp,#8]",
            "subs x1,x1,#1",
        ],
        &["ldr x9,[sp,#8]", "ldrb w10,[x0,x9]"],
        EIGHT_BYTES,
    );
    assert!(result.is_err());
}

#[test]
fn a_store_to_the_stack_at_an_unknown_offset_may_clobber_the_index_slot() {
    let result = analyze_with_stack_frame(
        &["mov x9,#0", "str x9,[sp,#8]"],
        &[
            "str x9,[sp,x2]",
            "ldr x9,[sp,#8]",
            "ldrb w10,[x0,x9]",
            "subs x1,x1,#1",
        ],
        &[],
        EIGHT_BYTES,
    );
    assert!(result.is_err());
}

fn buffer_filled_below_a_counter_slot(store: &str) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "sub sp,sp,#80",
        "str x1,[sp,#72]",
        "mov x7,sp",
        "mov x6,#8",
        "loop:",
        "ldrb w10,[x0]",
        "add x0,x0,#1",
        store,
        "subs x6,x6,#1",
        "csel x6,x6,xzr,hi",
        "add x7,x7,#8",
        "csel x7,x7,sp,hi",
        "ldr x9,[sp,#72]",
        "subs x9,x9,#1",
        "str x9,[sp,#72]",
        "b.ne loop",
        "add sp,sp,#80",
        "ret",
    ]
    .map(String::from)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("count"));
    engine.add_abstract_from(1, "count");
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("count"),
        AbstractExpression::Immediate(1),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

fn buffer_filled_beside_an_unused_slot(read: &str) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "sub sp,sp,#80",
        "str x5,[sp,#8]",
        "mov x7,sp",
        "mov x4,#8",
        "loop:",
        read,
        "add x0,x0,#1",
        "cmp x2,#0",
        "csel x3,xzr,x4,eq",
        "str x10,[x7,x3]",
        "subs x1,x1,#1",
        "b.ne loop",
        "add sp,sp,#80",
        "ret",
    ]
    .map(String::from)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("count"));
    engine.add_abstract_from(1, "count");
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("count"),
        AbstractExpression::Immediate(1),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_loop_that_may_clobber_a_slot_it_never_reads_is_still_summarized() {
    assert_eq!(buffer_filled_beside_an_unused_slot("ldrb w10,[x0]"), Ok(()));
    assert!(buffer_filled_beside_an_unused_slot("ldrb w10,[x0,#1]").is_err());
}

#[test]
fn a_store_through_an_untracked_stack_pointer_loses_the_counter_slot() {
    assert!(buffer_filled_below_a_counter_slot("str x10,[x7,x2]").is_err());
}

fn chunked_then_blocked_walk(tail_read: &str) -> Vec<String> {
    [
        "start:",
        "big:",
        "ldrb w5,[x0,#127]",
        "add x0,x0,#128",
        "sub x2,x2,#128",
        "cmp x2,#128",
        "b.hs big",
        "cbz x2,end",
        "b small",
        "small:",
        "subs x2,x2,#64",
        "b.lo tail",
        "ldrb w5,[x0,#63]",
        "add x0,x0,#64",
        "b.hi small",
        "ret",
        "tail:",
        "add x2,x2,#64",
        tail_read,
        "end:",
        "ret",
    ]
    .map(String::from)
    .to_vec()
}

fn analyze_chunked_then_blocked_walk(tail_read: &str) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(chunked_then_blocked_walk(tail_read));
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));
    engine.add_abstract_from(2, "length");
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("length"),
        AbstractExpression::Immediate(128),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_block_loop_entered_after_a_chunk_loop_is_proved_safe() {
    assert_eq!(analyze_chunked_then_blocked_walk("ldrb w5,[x0]"), Ok(()));
}

#[test]
fn a_block_loop_entered_after_a_chunk_loop_still_catches_a_tail_read_past_the_end() {
    assert!(analyze_chunked_then_blocked_walk("ldrb w5,[x0,x2]").is_err());
}

fn analyze_row_copy(words_short: i64) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "cbz x2,end",
        "cbz x3,end",
        "mov x5,xzr",
        "mov x8,x1",
        "rows:",
        "mov x7,x3",
        "words:",
        "ldr x10,[x8]",
        "add x8,x8,#8",
        "subs x7,x7,#1",
        "b.ne words",
        "add x5,x5,#1",
        "cmp x5,x2",
        "b.ne rows",
        "end:",
        "ret",
    ]
    .map(String::from)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(1, "table");
    engine.add_region(
        RegionType::READ,
        "table",
        generate_expression(
            "*",
            abstract_of("table_words"),
            AbstractExpression::Immediate(8),
        ),
    );
    engine.add_abstract_from(2, "height");
    engine.add_abstract_from(3, "width");
    engine.add_invariant(AbstractComparison::new(
        "==",
        abstract_of("table_words"),
        generate_expression(
            "-",
            generate_expression("*", abstract_of("height"), abstract_of("width")),
            AbstractExpression::Immediate(words_short),
        ),
    ));
    for name in ["height", "width"] {
        engine.add_invariant(AbstractComparison::new(
            ">=",
            abstract_of(name),
            AbstractExpression::Immediate(3),
        ));
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_pointer_advanced_by_an_inner_loop_of_symbolic_count_is_proved_safe() {
    assert_eq!(analyze_row_copy(0), Ok(()));
}

#[test]
fn a_pointer_advanced_by_an_inner_loop_of_symbolic_count_still_catches_the_last_word() {
    assert!(analyze_row_copy(1).is_err());
}

fn analyze_column_walk(bytes_short: i64) -> Result<(), String> {
    analyze_column_walk_rewinding(bytes_short, "mov x6,x6")
}

fn analyze_column_walk_rewinding(bytes_short: i64, rewind_adjustment: &str) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "mul x6,x1,x2",
        rewind_adjustment,
        "columns:",
        "mov x4,x2",
        "rows:",
        "ldr x5,[x0]",
        "add x0,x0,x1",
        "ldr x5,[x0]",
        "add x0,x0,x1",
        "subs x4,x4,#2",
        "b.gt rows",
        "sub x0,x0,x6",
        "add x0,x0,#8",
        "subs x3,x3,#8",
        "b.gt columns",
        "ret",
    ]
    .map(String::from)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(
        RegionType::READ,
        "base",
        generate_expression(
            "-",
            generate_expression("*", abstract_of("stride"), abstract_of("height")),
            AbstractExpression::Immediate(bytes_short),
        ),
    );
    engine.add_abstract_from(1, "stride");
    engine.add_abstract_from(2, "height");
    engine.add_abstract_from(3, "width");
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("stride"),
        abstract_of("width"),
    ));
    engine.add_invariant(AbstractComparison::new(
        "==",
        generate_expression("%", abstract_of("width"), AbstractExpression::Immediate(8)),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(AbstractComparison::new(
        "==",
        generate_expression("%", abstract_of("height"), AbstractExpression::Immediate(2)),
        AbstractExpression::Immediate(0),
    ));
    for name in ["height", "width"] {
        engine.add_invariant(AbstractComparison::new(
            ">=",
            abstract_of(name),
            AbstractExpression::Immediate(24),
        ));
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_column_walk_that_rewinds_its_rows_is_proved_safe() {
    assert_eq!(analyze_column_walk(0), Ok(()));
}

#[test]
fn a_column_walk_that_rewinds_its_rows_still_catches_the_last_byte() {
    assert!(analyze_column_walk(1).is_err());
}

fn analyze_column_walk_with_wide_first_columns(bytes_short: i64) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "mul x6,x1,x2",
        "mov x9,#16",
        "mov x10,#16",
        "columns:",
        "mov x4,x2",
        "rows:",
        "ldr x5,[x0]",
        "add x0,x0,x1",
        "ldr x5,[x0]",
        "add x0,x0,x1",
        "subs x4,x4,#2",
        "b.gt rows",
        "sub x0,x0,x6",
        "add x0,x0,x9",
        "mov x9,x10",
        "mov x10,#8",
        "subs x3,x3,#8",
        "b.gt columns",
        "ret",
    ]
    .map(String::from)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(
        RegionType::READ,
        "base",
        generate_expression(
            "-",
            generate_expression("*", abstract_of("stride"), abstract_of("height")),
            AbstractExpression::Immediate(bytes_short),
        ),
    );
    engine.add_abstract_from(1, "stride");
    engine.add_abstract_from(2, "height");
    engine.add_abstract_from(3, "width");
    engine.add_invariant(AbstractComparison::new(
        "==",
        abstract_of("stride"),
        generate_expression("+", abstract_of("width"), AbstractExpression::Immediate(16)),
    ));
    engine.add_invariant(AbstractComparison::new(
        "==",
        generate_expression("%", abstract_of("width"), AbstractExpression::Immediate(8)),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(AbstractComparison::new(
        "==",
        generate_expression("%", abstract_of("height"), AbstractExpression::Immediate(2)),
        AbstractExpression::Immediate(0),
    ));
    for (name, least) in [("height", 24), ("width", 40)] {
        engine.add_invariant(AbstractComparison::new(
            ">=",
            abstract_of(name),
            AbstractExpression::Immediate(least),
        ));
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_column_walk_whose_first_columns_are_wider_is_proved_safe() {
    assert_eq!(analyze_column_walk_with_wide_first_columns(0), Ok(()));
}

#[test]
fn a_column_walk_whose_first_columns_are_wider_still_catches_the_last_word() {
    assert!(analyze_column_walk_with_wide_first_columns(8).is_err());
}

#[test]
fn a_column_walk_that_rewinds_one_row_short_is_rejected() {
    assert!(analyze_column_walk_rewinding(0, "sub x6,x6,x1").is_err());
}

#[test]
fn a_select_latch_that_grows_is_not_given_a_range() {
    let program = [
        "start:",
        "mov x4,#8",
        "loop:",
        "ldr x2,[x0]",
        "subs x1,x1,#8",
        "add x5,x4,x4",
        "csel x4,xzr,x5,eq",
        "add x0,x0,x4",
        "b.hs loop",
        "ret",
    ]
    .map(String::from)
    .to_vec();
    assert!(analyze_accelerated(program, 8, 8).is_err());
}

fn analyze_long_concrete_loop(region_words: i64) -> Result<(), String> {
    init();
    let trips = 200;
    let mut program = vec![
        "start:".to_string(),
        format!("mov x2,#{trips}"),
        "work:".to_string(),
        format!("mov x4,#{trips}"),
        "sub x4,x4,x2".to_string(),
        "ldr x3,[x0,x4,lsl #3]".to_string(),
    ];
    program.extend(std::iter::repeat_n("add x5,x5,#1".to_string(), 2000));
    program.extend(["sub x2,x2,#1", "cbnz x2,work", "ret"].map(String::from));
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(
        RegionType::READ,
        "base",
        AbstractExpression::Immediate(region_words * 8),
    );
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_long_concrete_loop_with_a_heavy_body_is_summarized_and_proved_safe() {
    assert_eq!(analyze_long_concrete_loop(200), Ok(()));
}

#[test]
fn a_long_concrete_loop_with_a_heavy_body_still_catches_its_last_read() {
    assert!(analyze_long_concrete_loop(199).is_err());
}

fn analyze_chunks_counted_by_a_clamp(bytes_short: i64) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "chunk:",
        "cmp x2,#16",
        "b.lt done",
        "lsr x4,x2,#3",
        "mov x10,#10",
        "cmp x4,x10",
        "csel x7,x4,x10,lt",
        "words:",
        "ldr x3,[x0],#8",
        "subs x7,x7,#1",
        "b.gt words",
        "sub x2,x2,#80",
        "b chunk",
        "done:",
        "ret",
    ]
    .map(String::from)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(
        RegionType::READ,
        "base",
        generate_expression(
            "-",
            abstract_of("len"),
            AbstractExpression::Immediate(bytes_short),
        ),
    );
    engine.add_abstract_from(2, "len");
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("len"),
        AbstractExpression::Immediate(0),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
#[ignore = "the chunk pointer steps by a fresh select every iteration, so the outer loop never summarizes"]
fn chunks_counted_by_a_clamped_length_are_bounded_by_the_clamp() {
    assert_eq!(analyze_chunks_counted_by_a_clamp(0), Ok(()));
}

#[test]
fn chunks_counted_by_a_clamped_length_still_catch_a_short_region() {
    assert!(analyze_chunks_counted_by_a_clamp(1).is_err());
}

#[test]
fn an_index_whose_step_grows_after_the_unrolled_iterations_is_rejected() {
    init();
    let program: Vec<String> = [
        "start:",
        "mov x5,#0",
        "mov x9,#0",
        "loop:",
        "ldr x3,[x0,x5]",
        "cmp x9,#3",
        "mov x7,#8",
        "mov x8,#64",
        "csel x7,x7,x8,lt",
        "add x5,x5,x7",
        "add x9,x9,#1",
        "subs x2,x2,#1",
        "b.ne loop",
        "ret",
    ]
    .map(String::from)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(
        RegionType::READ,
        "base",
        generate_expression("*", abstract_of("n"), AbstractExpression::Immediate(8)),
    );
    engine.add_abstract_from(2, "n");
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("n"),
        AbstractExpression::Immediate(1),
    ));
    assert!(engine.start("start").is_err());
}

fn last_nonzero_index(count: &str) -> Vec<String> {
    [
        "start:",
        "cbz x1, done",
        &format!("mov x4, {count}"),
        "mov x2, x0",
        "mov x0, #0",
        "mov x3, #0",
        "loop:",
        "ldr x5, [x2], #8",
        "add x3, x3, #1",
        "cmp x5, #0",
        "csel x0, x3, x0, ne",
        "cmp x3, x4",
        "b.lo loop",
        "done:",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect()
}

#[test]
fn select_of_the_counter_drops_its_unrolled_range() {
    let engine = |count: &str, extra: Option<i64>| {
        init();
        let mut engine = bums::engine::ExecutionEngine::new(last_nonzero_index(count));
        engine.add_abstract_from(0, "base");
        engine.add_abstract_from(1, "words");
        engine.add_region(
            RegionType::READ,
            "base",
            generate_expression("*", abstract_of("words"), AbstractExpression::Immediate(8)),
        );
        if let Some(extra) = extra {
            engine.add_abstract_from(5, "count");
            engine.add_invariant(AbstractComparison::new(
                "==",
                abstract_of("count"),
                generate_expression(
                    "+",
                    abstract_of("words"),
                    AbstractExpression::Immediate(extra),
                ),
            ));
        }
        engine.start("start").map_err(|e| e.to_string())
    };
    assert_eq!(engine("x1", None), Ok(()));
    assert!(
        engine("x5", Some(1)).is_err(),
        "one word past the region was accepted"
    );
}

#[test]
fn an_inner_loop_left_each_outer_iteration_starts_its_revisits_afresh() {
    let program: Vec<String> = [
        "start:",
        "cbz x1, done",
        "ldr w5, [x0, #240]",
        "cmp w5, #160",
        "b.eq valid",
        "cmp w5, #192",
        "b.eq valid",
        "cmp w5, #224",
        "b.eq valid",
        "mov x0, #-1",
        "ret",
        "valid:",
        "outer:",
        "sub x6, x5, #16",
        "ld1 {v2.4s}, [x0], #16",
        "inner:",
        "ld1 {v2.4s}, [x0], #16",
        "subs x6, x6, #16",
        "b.gt inner",
        "ldr q3, [x0]",
        "sub x0, x0, x5",
        "subs x1, x1, #1",
        "b.gt outer",
        "done:",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();
    let run = |schedule: i64| {
        init();
        let mut engine = bums::engine::ExecutionEngine::new(program.clone());
        engine.add_abstract_from(0, "key");
        engine.add_region(
            RegionType::READ,
            "key",
            AbstractExpression::Immediate(schedule),
        );
        engine.add_abstract_to_memory("key", 240, abstract_of("rounds"));
        engine.add_abstract_from(1, "blocks");
        engine.start("start").map_err(|e| e.to_string())
    };
    assert_eq!(run(244), Ok(()));
    assert!(
        run(243).is_err(),
        "the round count read past a 243-byte context"
    );
}

fn negative_index_rows(extra: i64) -> Vec<String> {
    [
        "start:",
        "cbz x0, exit",
        &format!("add x6, x0, #{extra}"),
        "neg x0, x6, lsl #3",
        "sub x2, x2, x0",
        "mov x10, x0",
        "outer:",
        "mov x9, x0",
        "inner:",
        "ldr x5, [x2, x9]",
        "adds x9, x9, #8",
        "b.ne inner",
        "adds x10, x10, #8",
        "b.ne outer",
        "exit:",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect()
}

#[test]
fn an_inner_guard_equal_to_an_outer_counter_still_steps() {
    let run = |extra: i64| {
        init();
        let mut engine = bums::engine::ExecutionEngine::new(negative_index_rows(extra));
        engine.add_abstract_from(0, "words");
        engine.add_abstract_from(2, "base");
        engine.add_region(
            RegionType::READ,
            "base",
            generate_expression("*", abstract_of("words"), AbstractExpression::Immediate(8)),
        );
        engine.start("start").map_err(|e| e.to_string())
    };
    assert_eq!(run(0), Ok(()));
    assert!(
        run(1).is_err(),
        "a row one word longer than the buffer was accepted"
    );
}

#[test]
fn a_64_bit_countdown_gets_no_32_bit_bound() {
    init();
    let program: Vec<String> = [
        "start:",
        "loop:",
        "ldrb w4,[x0]",
        "add x0,x0,#1",
        "subs x1,x1,#1",
        "b.gt loop",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_abstract_from(1, "h");
    engine.add_region(
        RegionType::READ,
        "base",
        AbstractExpression::Immediate((1i64 << 31) + 16),
    );
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("h"),
        AbstractExpression::Immediate(1),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        abstract_of("h"),
        AbstractExpression::Immediate(1i64 << 40),
    ));

    let err = engine
        .start("start")
        .expect_err("a run of 2^40 bytes leaves the region");
    assert!(err.to_string().contains("not provably within"), "{err}");
}

#[test]
fn a_countdown_that_branches_out_is_bounded_the_same_way() {
    init();
    let program: Vec<String> = [
        "start:",
        "loop:",
        "ldr x4,[x0]",
        "add x0,x0,#8",
        "subs w1,w1,#1",
        "b.le out",
        "b loop",
        "out:",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_abstract_from(1, "h");
    engine.add_region(
        RegionType::READ,
        "base",
        generate_expression("*", abstract_of("h"), AbstractExpression::Immediate(8)),
    );
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("h"),
        AbstractExpression::Immediate(1),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        abstract_of("h"),
        AbstractExpression::Immediate(128),
    ));

    engine
        .start("start")
        .expect("h rows of 8 bytes are in bounds");
}

#[test]
fn a_w_register_countdown_bounds_its_rows() {
    init();
    let program: Vec<String> = [
        "start:",
        "loop:",
        "ldr x4,[x0]",
        "add x0,x0,#8",
        "subs w1,w1,#1",
        "b.gt loop",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_abstract_from(1, "h");
    engine.add_region(
        RegionType::READ,
        "base",
        generate_expression("*", abstract_of("h"), AbstractExpression::Immediate(8)),
    );
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("h"),
        AbstractExpression::Immediate(1),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        abstract_of("h"),
        AbstractExpression::Immediate(128),
    ));

    engine
        .start("start")
        .expect("h rows of 8 bytes are in bounds");
}

#[test]
fn a_w_register_countdown_still_catches_one_row_too_many() {
    init();
    let program: Vec<String> = [
        "start:",
        "loop:",
        "ldr x4,[x0]",
        "add x0,x0,#8",
        "subs w1,w1,#1",
        "b.gt loop",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_abstract_from(1, "h");
    engine.add_region(
        RegionType::READ,
        "base",
        generate_expression(
            "-",
            generate_expression("*", abstract_of("h"), AbstractExpression::Immediate(8)),
            AbstractExpression::Immediate(8),
        ),
    );
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("h"),
        AbstractExpression::Immediate(1),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        abstract_of("h"),
        AbstractExpression::Immediate(128),
    ));

    let err = engine
        .start("start")
        .expect_err("the last row is past the region");
    assert!(err.to_string().contains("not provably within"), "{err}");
}

#[test]
fn what_a_loop_walked_is_known_after_it_closes() {
    init();
    let program: Vec<String> = [
        "start:",
        "mov x6,#2",
        "col:",
        "mov x5,x2",
        "row:",
        "ldr x4,[x0]",
        "add x0,x0,x1",
        "subs x5,x5,#1",
        "b.le endrow",
        "b row",
        "endrow:",
        "msub x0,x1,x2,x0",
        "add x0,x0,#8",
        "subs x6,x6,#1",
        "b.gt col",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_abstract_from(1, "stride");
    engine.add_abstract_from(2, "h");
    engine.add_region(
        RegionType::READ,
        "base",
        generate_expression("*", abstract_of("stride"), abstract_of("h")),
    );
    for (name, op, bound) in [
        ("h", ">=", 1),
        ("h", "<=", 128),
        ("stride", ">=", 16),
        ("stride", "<=", 4096),
    ] {
        engine.add_invariant(AbstractComparison::new(
            op,
            abstract_of(name),
            AbstractExpression::Immediate(bound),
        ));
    }

    engine
        .start("start")
        .expect("both columns stay inside the region");
}

fn nibble_walk(bytes: i64) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "loop:",
        "ldrb w4,[x0]",
        "add x0,x0,#1",
        "lsr w6,w6,#4",
        "cbnz w6,loop",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(
        RegionType::READ,
        "base",
        AbstractExpression::Immediate(bytes),
    );
    engine.add_abstract_from(6, "mask");
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_loop_that_shifts_a_word_to_zero_reads_one_byte_per_nibble() {
    nibble_walk(8).expect("a 32-bit mask runs out after eight nibbles");
}

#[test]
fn a_loop_that_shifts_a_word_to_zero_still_catches_one_byte_too_few() {
    let err = nibble_walk(7).expect_err("the eighth nibble reads past seven bytes");
    assert!(err.contains("not provably within"), "{err}");
}

#[test]
fn a_shift_beside_a_loop_that_counts_something_else_bounds_nothing() {
    init();
    let program: Vec<String> = [
        "start:",
        "loop:",
        "ldrb w4,[x0]",
        "add x0,x0,#1",
        "lsr w6,w6,#4",
        "subs x1,x1,#1",
        "b.ne loop",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(8));
    engine.add_abstract_from(6, "mask");
    engine.add_abstract_from(1, "count");
    for (op, bound) in [(">=", 1), ("<=", 100)] {
        engine.add_invariant(AbstractComparison::new(
            op,
            abstract_of("count"),
            AbstractExpression::Immediate(bound),
        ));
    }
    let err = engine
        .start("start")
        .expect_err("a hundred reads leave an eight-byte region");
    assert!(err.to_string().contains("not provably within"), "{err}");
}

const SPLIT_STEP: [&str; 2] = ["add x4,x4,x3", "add x4,x4,#16"];

fn analyze_with_aux(program: Vec<String>) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));
    engine.add_abstract_from(1, "length");
    engine.add_abstract_from(3, "stride");
    engine.add_abstract_from(4, "aux");
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_split_step_beside_the_walk_still_catches_an_out_of_bounds_read() {
    let mut body = SPLIT_STEP.to_vec();
    body.push("ldr x5,[x0,#100000]");
    assert!(
        analyze_with_aux(walking_loop(4, &body)).is_err(),
        "proved an out of bounds read"
    );
}

fn offset_growing_late(exit: &[&str], growth: &str) -> Vec<String> {
    let head = [
        "start:",
        "mov x2,#0",
        "mov x4,#0",
        "mov x6,#8",
        "loop:",
        "ldrb w9,[x0]",
        "cmp x2,x1",
        "b.eq done",
    ];
    let tail = [
        "cmp x2,#4",
        growth,
        "add x4,x4,x5",
        "add x2,x2,#1",
        "b loop",
        "found:",
        "ldr x3,[x0,x4]",
        "done:",
        "ret",
    ];
    head.iter()
        .chain(exit)
        .chain(tail.iter())
        .map(|s| s.to_string())
        .collect()
}

fn analyze_eight_bytes(lines: Vec<String>) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(lines);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(8));
    engine.add_abstract_from(1, "count");
    engine.add_abstract_from(7, "stop");
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn an_offset_that_starts_moving_after_the_summary_is_caught_on_a_mid_body_exit() {
    let lines = offset_growing_late(&["cmp x2,x7", "b.eq found"], "csel x5,x6,xzr,hs");
    assert_rejected_access(analyze_eight_bytes(lines));
}

#[test]
fn an_offset_that_never_moves_is_safe_on_a_mid_body_exit() {
    let lines = offset_growing_late(&["cmp x2,x7", "b.eq found"], "mov x5,#0");
    assert_eq!(analyze_eight_bytes(lines), Ok(()));
}

#[test]
fn a_return_inside_the_body_sees_an_offset_that_starts_moving_late() {
    let lines = offset_growing_late(
        &["cmp x2,x7", "b.ne stay", "ldr x3,[x0,x4]", "ret", "stay:"],
        "csel x5,x6,xzr,hs",
    );
    assert_rejected_access(analyze_eight_bytes(lines));
}

#[test]
fn an_exit_reached_only_in_late_iterations_sees_the_moved_offset() {
    let lines = offset_growing_late(
        &["cmp x2,#5", "b.lo stay", "cbz x7,found", "stay:"],
        "csel x5,x6,xzr,hs",
    );
    assert_rejected_access(analyze_eight_bytes(lines));
}

#[test]
fn an_exit_at_the_visit_that_summarizes_the_loop_is_explored() {
    let program = walking_loop_with_tail(4, &["ldr w2,[x0,#0]"], &["ldr w3,[x0,#-8]"]);
    assert_rejected_access(analyze_accelerated(program, 4, 4));
}
