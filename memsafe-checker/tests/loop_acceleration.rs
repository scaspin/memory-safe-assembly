
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
#[ignore = "the two-valued step cannot be settled, so the summary is declined and the loop unrolls; aes_hw_cbc_encrypt fails this way"]
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
