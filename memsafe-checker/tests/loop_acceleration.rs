
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
    assert_out_of_bounds(
        analyze_accelerated(walking_loop(4, &["ldr w2,[x0,#4]"]), 4, 16),
        16,
    );
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
    assert_out_of_bounds(
        analyze_region_accelerated(
            walking_loop(4, &["str w2,[x0,#4]"]),
            RegionType::WRITE,
            4,
            16,
        ),
        16,
    );
}

#[test]
fn load_wider_than_the_stride_is_rejected_at_the_end() {
    assert_out_of_bounds(
        analyze_accelerated(walking_loop(4, &["ldr x2,[x0,#0]"]), 4, 16),
        12,
    );
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
    assert_out_of_bounds(analyze_guarded(guarded_loop(&["ldr w2,[x0,#4]"]), 16), 16);
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
    assert_out_of_bounds(analyze_accelerated(program, 4, 4), 8);
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
