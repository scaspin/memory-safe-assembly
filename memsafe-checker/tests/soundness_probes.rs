use bums::common::*;

fn run(
    program: &[&str],
    length: Option<i64>,
    invariants: &[AbstractComparison],
) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut engine = bums::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(0, "base");
    let len = match length {
        Some(n) => AbstractExpression::Immediate(n),
        None => abstract_of("length"),
    };
    engine.add_region(RegionType::READ, "base", len);
    engine.add_abstract_from(1, "length");
    engine.add_abstract_from(2, "flag");
    for i in invariants {
        engine.add_invariant(i.clone());
    }
    engine.start("start").map_err(|e| e.to_string())
}

fn length_mod(n: i64) -> AbstractComparison {
    AbstractComparison::new(
        "==",
        generate_expression("%", abstract_of("length"), AbstractExpression::Immediate(n)),
        AbstractExpression::Immediate(0),
    )
}

fn length_at_least(n: i64) -> AbstractComparison {
    AbstractComparison::new(
        ">=",
        abstract_of("length"),
        AbstractExpression::Immediate(n),
    )
}

#[test]
fn csel_false_side_uses_its_own_option() {
    let r = run(
        &[
            "start:",
            "mov x3, x0",
            "add x4, x0, x1",
            "cmp x2, #0",
            "csel x3, x0, x4, eq",
            "ldr w5, [x3]",
            "ret",
        ],
        None,
        &[length_at_least(4)],
    );
    assert!(
        r.is_err(),
        "accepted a read at base+length on the csel's false side"
    );
}

#[test]
fn compare_of_unknown_data_does_not_reuse_stale_flags() {
    let r = run(
        &[
            "start:",
            "cmp x0, x0",
            "ldr x2, [x0]",
            "cmp x2, #0",
            "b.eq ok",
            "ldr x3, [x0, #4096]",
            "ok:",
            "ret",
        ],
        Some(8),
        &[],
    );
    assert!(
        r.is_err(),
        "accepted the read at base+4096 behind a data-dependent branch"
    );
}

#[test]
fn stride_that_can_step_over_a_ne_bound_is_rejected() {
    let r = run(
        &[
            "start:",
            "add x1, x0, x1",
            "loop:",
            "cmp x0, x1",
            "b.eq end",
            "ldr w2, [x0]",
            "add x0, x0, #8",
            "b loop",
            "end:",
            "ret",
        ],
        None,
        &[length_mod(4), length_at_least(4)],
    );
    assert!(r.is_err(), "accepted a walk that steps over its bound");
}

#[test]
fn inclusive_bound_overshoot_is_rejected() {
    let r = run(
        &[
            "start:",
            "add x1, x0, x1",
            "loop:",
            "cmp x0, x1",
            "b.hi end",
            "ldr w2, [x0]",
            "add x0, x0, #4",
            "b loop",
            "end:",
            "ret",
        ],
        None,
        &[length_mod(4), length_at_least(4)],
    );
    assert!(r.is_err(), "accepted the read at base+length");
}

#[test]
fn arms_advancing_differently_are_rejected() {
    let r = run(
        &[
            "start:",
            "add x1, x0, x1",
            "loop:",
            "cmp x0, x1",
            "b.eq end",
            "ldr w2, [x0]",
            "cmp x2, #0",
            "b.eq slow",
            "add x0, x0, #8",
            "b loop",
            "slow:",
            "add x0, x0, #4",
            "b loop",
            "end:",
            "ret",
        ],
        None,
        &[length_mod(4), length_at_least(4)],
    );
    assert!(r.is_err(), "accepted arms that can step over the bound");
}

#[test]
fn early_exit_after_a_widened_register_is_rejected() {
    let r = run(
        &[
            "start:",
            "add x1, x0, x1",
            "mov x5, #0",
            "loop:",
            "cmp x0, x1",
            "b.eq end",
            "mul x5, x5, x5",
            "add x5, x5, #1",
            "ldr w2, [x0]",
            "cmp x2, #0",
            "b.eq out",
            "add x0, x0, #4",
            "b loop",
            "out:",
            "ldr w3, [x0, x5]",
            "end:",
            "ret",
        ],
        None,
        &[length_mod(4), length_at_least(4)],
    );
    assert!(
        r.is_err(),
        "accepted a read indexed by an unbounded value on the early exit"
    );
}

fn run_rw(program: &[&str], length: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut engine = bums::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(0, "base");
    engine.add_region(
        RegionType::RW,
        "base",
        AbstractExpression::Immediate(length),
    );
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn index_loaded_from_the_stack_is_not_checked_as_a_stack_access() {
    let r = run_rw(
        &["start:", "ldr x3, [sp, #8]", "ldr w4, [x0, x3]", "ret"],
        16,
    );
    assert!(
        r.is_err(),
        "accepted a read at base + an unknown value from the stack"
    );
}

#[test]
fn store_through_a_computed_index_forgets_the_slot() {
    let r = run_rw(
        &[
            "start:",
            "mov x2, #0",
            "str x2, [x0]",
            "and x7, x7, #8",
            "str x9, [x0, x7]",
            "ldr x3, [x0]",
            "ldr w4, [x0, x3]",
            "ret",
        ],
        16,
    );
    assert!(r.is_err(), "used a stale slot value as an index");
}

#[test]
fn narrow_store_inside_a_word_forgets_the_word() {
    let r = run_rw(
        &[
            "start:",
            "mov x2, #0",
            "str x2, [x0]",
            "str w9, [x0, #4]",
            "ldr x3, [x0]",
            "ldr w4, [x0, x3]",
            "ret",
        ],
        16,
    );
    assert!(
        r.is_err(),
        "used a stale word as an index after a narrower store into it"
    );
}

#[test]
fn offset_beyond_a_table_reached_through_a_label_is_rejected() {
    let r = run_rw(
        &[
            "start:",
            "adr x1, table",
            "and x2, x2, #1",
            "add x1, x1, x2, lsl #3",
            "ldr x3, [x1, #4096]",
            "ret",
            "table:",
            ".quad 0",
            ".quad 0",
        ],
        16,
    );
    assert!(
        r.is_err(),
        "accepted a read 4096 bytes past a 16-byte table"
    );
}

#[test]
fn stride_stepping_over_a_long_bound_is_rejected() {
    let r = run(
        &[
            "start:",
            "add x1, x0, x1",
            "loop:",
            "cmp x0, x1",
            "b.eq end",
            "ldr w2, [x0]",
            "add x0, x0, #8",
            "b loop",
            "end:",
            "ret",
        ],
        None,
        &[length_mod(4), length_at_least(1000)],
    );
    assert!(r.is_err(), "accepted a walk that steps over its bound");
}
