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

fn run_with(
    lines: &[&str],
    setup: impl FnOnce(&mut bums::engine::ExecutionEngine),
) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let program: Vec<String> = lines.iter().map(|s| s.to_string()).collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    setup(&mut engine);
    engine.start("start").map_err(|e| e.to_string())
}

fn buffer(engine: &mut bums::engine::ExecutionEngine, register: usize, name: &str, length: i64) {
    engine.add_abstract_from(register, name);
    engine.add_region(RegionType::RW, name, AbstractExpression::Immediate(length));
}

fn stale_after_symbolic_store(index: i64) -> Result<(), String> {
    run_with(
        &[
            "start:",
            &format!("mov x3,#{index}"),
            "str x3,[x1]",
            "and x4,x2,#1",
            "lsl x4,x4,#3",
            "str x5,[x1,x4]",
            "ldr x6,[x1]",
            "ldr x7,[x0,x6]",
            "ret",
        ],
        |e| {
            buffer(e, 0, "data", 64);
            buffer(e, 1, "scratch", 16);
            e.add_abstract_from(2, "selector");
        },
    )
}

#[test]
fn a_symbolic_store_forgets_what_it_may_overwrite() {
    assert!(stale_after_symbolic_store(0).is_err());
}

fn stale_after_narrow_store() -> Result<(), String> {
    run_with(
        &[
            "start:",
            "mov x3,#0",
            "str x3,[x1]",
            "strb w5,[x1,#1]",
            "ldr x6,[x1]",
            "ldr x7,[x0,x6]",
            "ret",
        ],
        |e| {
            buffer(e, 0, "data", 64);
            buffer(e, 1, "scratch", 16);
        },
    )
}

#[test]
fn a_narrow_store_inside_a_stored_value_invalidates_it() {
    assert!(stale_after_narrow_store().is_err());
}

fn wide_read_of_a_narrow_table(item: &str) -> Result<(), String> {
    run_with(
        &[
            "table:",
            item,
            "start:",
            "adr x1,table",
            "ldr x6,[x1]",
            "ldr x7,[x0,x6]",
            "ret",
        ],
        |e| buffer(e, 0, "data", 64),
    )
}

#[test]
fn a_wide_load_assembles_every_item_it_covers() {
    assert_eq!(wide_read_of_a_narrow_table(".long 0, 0"), Ok(()));
    assert!(wide_read_of_a_narrow_table(".long 0, 1").is_err());
}

fn indexed_table_read(immediate: i64) -> Result<(), String> {
    run_with(
        &[
            ".quad 1,2",
            "second:",
            ".quad 3,4",
            "start:",
            "adr x1,second",
            "and x2,x2,#1",
            "lsl x2,x2,#3",
            "add x1,x1,x2",
            &format!("ldr x3,[x1,#{immediate}]"),
            "ret",
        ],
        |e| e.add_abstract_from(2, "selector"),
    )
}

#[test]
fn an_immediate_after_a_symbolic_table_index_is_kept() {
    assert_eq!(indexed_table_read(0), Ok(()));
    assert!(indexed_table_read(8).is_err());
    assert!(indexed_table_read(64).is_err());
}

#[test]
fn an_undefined_symbol_is_not_the_start_of_the_data() {
    let result = run_with(
        &[
            ".quad 1,2",
            "start:",
            "adrp x1,external@PAGE",
            "ldr x3,[x1]",
            "ret",
        ],
        |_| {},
    );
    assert!(result.is_err(), "{result:?}");
}

fn stack_access(lines: &[&str]) -> Result<(), String> {
    let mut program = vec!["start:"];
    program.extend_from_slice(lines);
    program.push("ret");
    run_with(&program, |_| {})
}

#[test]
fn the_stack_is_bounded_by_its_frame() {
    assert_eq!(
        stack_access(&[
            "sub sp,sp,#32",
            "str x1,[sp,#24]",
            "ldr x1,[sp,#24]",
            "add sp,sp,#32"
        ]),
        Ok(())
    );
    assert!(stack_access(&["sub sp,sp,#32", "str x1,[sp,#4096]", "add sp,sp,#32"]).is_err());
    assert!(stack_access(&["str x1,[sp,#-8]"]).is_err());
    assert!(stack_access(&["str x1,[sp,#-144]"]).is_err());
}

#[test]
fn a_region_named_like_the_stack_is_not_the_stack() {
    let result = run_with(&["start:", "ldr x3,[x0,#-8]", "ret"], |e| {
        buffer(e, 0, "dsp", 64)
    });
    assert!(result.is_err(), "{result:?}");
}

#[test]
fn clz_of_a_word_counts_32_bits() {
    let read = |offset: &str| {
        run_with(
            &[
                "start:",
                "mov w2,#1",
                "clz w3,w2",
                &format!("add x3,x3,#{offset}"),
                "ldrb w4,[x0,x3]",
                "ret",
            ],
            |e| buffer(e, 0, "data", 32),
        )
    };
    assert_eq!(read("0"), Ok(()));
    assert!(read("1").is_err());
}

#[test]
fn a_sign_extended_index_is_negative() {
    let read = |value: i64| {
        run_with(
            &[
                "start:",
                &format!("mov x2,#{value}"),
                "add x1,x0,#8",
                "ldrb w3,[x1,w2,sxtb]",
                "ret",
            ],
            |e| buffer(e, 0, "data", 16),
        )
    };
    assert_eq!(read(0x07), Ok(()));
    assert_eq!(read(0xf8), Ok(()));
    assert!(read(0xf7).is_err());
}

#[test]
fn a_w_countdown_exits_on_odd_counts_too() {
    let result = run_with(
        &[
            "start:",
            "loop:",
            "add x0,x0,#8",
            "subs w1,w1,#2",
            "b.gt loop",
            "ldr x4,[x0,#-8]",
            "ret",
        ],
        |e| {
            e.add_abstract_from(0, "base");
            e.add_abstract_from(1, "h");
            e.add_region(
                RegionType::READ,
                "base",
                generate_expression("*", abstract_of("h"), AbstractExpression::Immediate(4)),
            );
            e.add_invariant(AbstractComparison::new(
                ">=",
                abstract_of("h"),
                AbstractExpression::Immediate(1),
            ));
            e.add_invariant(AbstractComparison::new(
                "<=",
                abstract_of("h"),
                AbstractExpression::Immediate(128),
            ));
        },
    );
    assert!(result.is_err(), "{result:?}");
}

#[test]
fn an_extend_without_an_amount_still_computes() {
    let read = |value: i64| {
        run_with(
            &[
                "start:",
                &format!("mov x2,#{value}"),
                "add x1,x0,w2,uxtw",
                "ldrb w3,[x1]",
                "ret",
            ],
            |e| buffer(e, 0, "data", 16),
        )
    };
    assert_eq!(read(15), Ok(()));
    assert!(read(16).is_err());
}

#[test]
fn an_encoded_word_among_the_code_is_refused() {
    let r = run(
        &["start:", "loop:", ".long 0x8b000000", "ldr x3,[x0]", "ret"],
        Some(8),
        &[],
    );
    let err = r.expect_err("executed an instruction it cannot see");
    assert!(err.contains("unsupported encoded instruction"), "{err}");
}

#[test]
fn a_word_reached_by_falling_through_is_refused() {
    let r = run(
        &["start:", "add x0,x0,#0", ".inst 0x8b000000", "next:", "ret"],
        Some(8),
        &[],
    );
    assert!(r.is_err(), "fell through an instruction it cannot see");
}

#[test]
fn a_ne_guard_whose_eq_side_stays_in_the_loop_does_not_order_the_walker() {
    let r = run(
        &[
            "start:",
            "mov x9, #0",
            "mov x10, #0",
            "loop:",
            "cmp x9, x2",
            "b.hs done",
            "cmp x10, x1",
            "b.eq skip",
            "ldrb w3, [x0, x10]",
            "skip:",
            "add x10, x10, #1",
            "add x9, x9, #1",
            "b loop",
            "done:",
            "ret",
        ],
        None,
        &[length_at_least(1)],
    );
    assert!(
        r.is_err(),
        "accepted a walker that passes the bound on the side that keeps looping"
    );
}

#[test]
fn asr_of_a_value_above_2_63_is_negative() {
    let r = run(
        &[
            "start:",
            "ldrb w1, [x0]",
            "sub x1, x1, #256",
            "lsr x1, x1, #8",
            "lsl x1, x1, #8",
            "asr x1, x1, #60",
            "ldrb w2, [x0, x1]",
            "ret",
        ],
        Some(64),
        &[],
    );
    assert!(r.is_err(), "accepted an index that asr made negative");
}

#[test]
fn asr_of_a_zero_extended_word_shifted_up_is_negative() {
    let r = run(
        &[
            "start:",
            "ldrb w1, [x0]",
            "sub w1, w1, #1",
            "mov w1, w1",
            "lsl x1, x1, #32",
            "asr x1, x1, #60",
            "ldrb w2, [x0, x1]",
            "ret",
        ],
        Some(64),
        &[],
    );
    assert!(r.is_err(), "accepted an index that asr made negative");
}

#[test]
fn smaddl_sign_extends_its_word_factors() {
    let r = run(
        &[
            "start:",
            "ldrb w1, [x0]",
            "mov w2, #-1",
            "smaddl x3, w1, w2, x0",
            "ldrb w4, [x3]",
            "ret",
        ],
        None,
        &[length_at_least(1i64 << 41)],
    );
    assert!(
        r.is_err(),
        "accepted base - byte as base + byte * (2^32 - 1)"
    );
}

#[test]
fn smsubl_sign_extends_its_word_factors() {
    let r = run(
        &[
            "start:",
            "ldrb w1, [x0]",
            "mov w2, #-1",
            "mov x5, #1",
            "lsl x5, x5, #40",
            "add x5, x0, x5",
            "smsubl x3, w1, w2, x5",
            "ldrb w4, [x3]",
            "ret",
        ],
        Some((1i64 << 40) + 1),
        &[],
    );
    assert!(
        r.is_err(),
        "accepted base + 2^40 + byte as base + 2^40 - byte * (2^32 - 1)"
    );
}

#[test]
fn ldnp_of_vectors_is_bounds_checked() {
    let r = run(
        &["start:", "ldnp q0, q1, [x0, #1024]", "ret"],
        Some(16),
        &[],
    );
    assert!(
        r.is_err(),
        "accepted a non-temporal pair load far past the buffer"
    );
}

#[test]
fn stnp_of_vectors_is_bounds_checked() {
    let r = run(
        &["start:", "stnp q0, q1, [x0, #1024]", "ret"],
        Some(16),
        &[],
    );
    assert!(
        r.is_err(),
        "accepted a non-temporal pair store far past the buffer"
    );
}

#[test]
fn non_temporal_pairs_cover_both_registers() {
    let pair = |line: &str, length: i64| run(&["start:", line, "ret"], Some(length), &[]);
    assert_eq!(pair("ldnp q0, q1, [x0]", 32), Ok(()));
    assert!(pair("ldnp q0, q1, [x0]", 31).is_err());
    assert_eq!(pair("ldnp x3, x4, [x0, #8]", 24), Ok(()));
    assert!(pair("ldnp x3, x4, [x0, #8]", 23).is_err());
    assert_eq!(pair("ldnp w3, w4, [x0]", 8), Ok(()));
    assert!(pair("ldnp w3, w4, [x0]", 7).is_err());
    assert_eq!(pair("ldnp d0, d1, [x0]", 16), Ok(()));
    assert!(pair("ldnp d0, d1, [x0]", 15).is_err());
}

#[test]
fn an_unsupported_vector_memory_instruction_is_refused() {
    let r = run(&["start:", "ldaxp q0, q1, [x0]", "ret"], Some(64), &[]);
    let err = r.expect_err("ran a vector memory instruction it does not model");
    assert!(err.contains("unsupported memory instruction"), "{err}");
}

fn run_x86(program: &[&str], input: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut engine = bums::x86::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(0, "out");
    engine.add_region(RegionType::WRITE, "out", AbstractExpression::Immediate(16));
    engine.add_abstract_from(1, "in");
    engine.add_region(RegionType::READ, "in", AbstractExpression::Immediate(input));
    engine.start("start").map_err(|e| e.to_string())
}

fn x86_access(line: &str, input: i64) -> Result<(), String> {
    run_x86(&["start:", line, "retq"], input)
}

#[test]
fn a_narrowing_conversion_reads_its_whole_memory_source() {
    for line in [
        "vcvtpd2psy (%rsi), %xmm0",
        "vcvttpd2dqy (%rsi), %xmm0",
        "vcvtpd2dqy (%rsi), %xmm0",
        "vcvtpd2udqy (%rsi), %xmm0",
        "vcvtqq2psy (%rsi), %xmm0",
        "vcvtneps2bf16y (%rsi), %xmm0",
    ] {
        assert!(
            x86_access(line, 31).is_err(),
            "{line} read fewer than 32 bytes"
        );
        assert_eq!(x86_access(line, 32), Ok(()), "{line}");
    }
    for line in ["vcvtpd2psx (%rsi), %xmm0", "cvtpd2ps (%rsi), %xmm0"] {
        assert!(
            x86_access(line, 15).is_err(),
            "{line} read fewer than 16 bytes"
        );
        assert_eq!(x86_access(line, 16), Ok(()), "{line}");
    }
    for line in [
        "vcvtpd2ps (%rsi), %ymm0",
        "vcvttpd2dq (%rsi), %ymm0",
        "vcvtpd2phz (%rsi), %xmm0",
        "vfpclasspdz $1, (%rsi), %k0",
    ] {
        assert!(
            x86_access(line, 63).is_err(),
            "{line} read fewer than 64 bytes"
        );
    }
    assert!(x86_access("vcvtpd2ps (%rsi), %xmm0", 31).is_err());
    assert!(x86_access("vfpclasspdy $1, (%rsi), %k0", 31).is_err());
}

#[test]
fn a_duplicating_load_into_a_ymm_reads_all_of_it() {
    assert!(x86_access("vmovddup (%rsi), %ymm0", 31).is_err());
    assert_eq!(x86_access("vmovddup (%rsi), %xmm0", 8), Ok(()));
}

#[test]
fn narrowing_and_widening_memory_forms_are_sized_by_memory() {
    let store = |line: &str| run_x86(&["start:", line, "retq"], 16);
    assert_eq!(store("vpmovqd %ymm0, (%rdi)"), Ok(()));
    assert_eq!(store("vpmovusqb %zmm0, 8(%rdi)"), Ok(()));
    assert!(store("vpmovqb %zmm0, 9(%rdi)").is_err());
    assert_eq!(store("vcvtps2ph $0, %ymm0, (%rdi)"), Ok(()));
    assert_eq!(x86_access("vcvtps2pd (%rsi), %ymm0", 16), Ok(()));
    assert!(x86_access("vcvtps2pd (%rsi), %ymm0", 15).is_err());
    assert_eq!(x86_access("kmovw (%rsi), %k1", 2), Ok(()));
    assert!(x86_access("kmovq (%rsi), %k1", 7).is_err());
}

#[test]
fn a_return_through_a_saved_link_overwritten_with_data_is_refused() {
    let r = run(
        &[
            "start:",
            "stp x29, x30, [sp, #-48]!",
            "ldr w2, [x0]",
            "smull x2, w2, w2",
            "add x4, sp, #16",
            "str x2, [x4, #-8]",
            "ldp x29, x30, [sp], #48",
            "ret",
        ],
        Some(8),
        &[],
    );
    let err = r.expect_err("returned through a link register computed from data");
    assert!(err.contains("return to an unknown address"), "{err}");
}

#[test]
fn a_return_through_a_constant_link_is_refused() {
    let r = run(&["start:", "mov x30, #1", "ret"], Some(8), &[]);
    assert!(
        r.is_err(),
        "returned to a line number as if it were an address"
    );
}

#[test]
fn a_return_through_the_restored_link_is_accepted() {
    let r = run(
        &[
            "start:",
            "stp x29, x30, [sp, #-32]!",
            "mov x29, sp",
            "bl helper",
            "ldp x29, x30, [sp], #32",
            "ret",
            "helper:",
            "ldr x3, [x0]",
            "ret",
        ],
        Some(8),
        &[],
    );
    assert_eq!(r, Ok(()));
}

#[test]
fn shift_pair_does_not_cancel_past_the_sign_bit() {
    let r = run(
        &[
            "start:",
            "ldrb w1, [x0]",
            "lsl x1, x1, #60",
            "asr x1, x1, #60",
            "ldrb w2, [x0, x1]",
            "ret",
        ],
        Some(256),
        &[],
    );
    assert!(r.is_err(), "unsafe program accepted: {:?}", r);
}

#[test]
fn asr_of_a_value_past_64_bits_stays_within_a_signed_word() {
    let r = run(
        &[
            "start:",
            "ldrb w1, [x0]",
            "lsl x1, x1, #60",
            "asr x1, x1, #60",
            "add x3, x0, #8",
            "ldrb w2, [x3, x1]",
            "ret",
        ],
        Some(16),
        &[],
    );
    assert!(r.is_ok(), "{:?}", r);
}

#[test]
fn shift_pair_within_the_sign_bit_keeps_the_value() {
    let r = run(
        &[
            "start:",
            "ldrb w1, [x0]",
            "lsl x1, x1, #32",
            "asr x1, x1, #32",
            "ldrb w2, [x0, x1]",
            "ret",
        ],
        Some(256),
        &[],
    );
    assert!(r.is_ok(), "{:?}", r);
}
