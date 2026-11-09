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
fn asr_of_a_negative_word_stays_negative() {
    let r = run(
        &[
            "start:",
            "ldrb w1, [x0]",
            "sub w1, w1, #256",
            "asr w1, w1, #28",
            "sxtw x1, w1",
            "ldrb w2, [x0, x1]",
            "ret",
        ],
        Some(64),
        &[],
    );
    assert!(
        r.is_err(),
        "accepted an index that a word asr made negative"
    );
}

#[test]
fn asr_of_a_negative_word_constant_stays_negative() {
    let r = run(
        &[
            "start:",
            "mov w1, #-16",
            "asr w1, w1, #28",
            "sxtw x1, w1",
            "ldrb w2, [x0, x1]",
            "ret",
        ],
        Some(64),
        &[],
    );
    assert!(
        r.is_err(),
        "accepted an index that a word asr made negative"
    );
}

#[test]
fn a_word_operand_shifted_by_asr_stays_negative() {
    let r = run(
        &[
            "start:",
            "ldrb w1, [x0]",
            "sub w1, w1, #256",
            "add w3, wzr, w1, asr #28",
            "sxtw x3, w3",
            "ldrb w2, [x0, x3]",
            "ret",
        ],
        Some(64),
        &[],
    );
    assert!(
        r.is_err(),
        "accepted an index that a word asr made negative"
    );
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

#[test]
fn unbounded_recursion_is_rejected() {
    let r = run(&["start:", "bl start", "ret"], Some(64), &[]);
    assert!(r.is_err(), "accepted a function that calls itself forever");
}

#[test]
fn a_concrete_loop_in_a_helper_called_many_times_is_not_a_cycle() {
    let r = run(
        &[
            "start:",
            "stp x29, x30, [sp, #-16]!",
            "mov x9, #0",
            "outer:",
            "bl helper",
            "add x9, x9, #1",
            "cmp x9, #40",
            "b.lt outer",
            "ldp x29, x30, [sp], #16",
            "ret",
            "helper:",
            "mov x10, #0",
            "inner:",
            "add x10, x10, #1",
            "cmp x10, #30",
            "b.lt inner",
            "ret",
        ],
        Some(64),
        &[],
    );
    assert!(r.is_ok(), "{r:?}");
}

fn index_from_packed_halfwords(extract: &[&str], bounded: &[i64]) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut program = vec!["start:", "add x0, x0, #32", "ldr x4, [x1]"];
    program.extend_from_slice(extract);
    program.extend(["ldrb w6, [x0, x5]", "ret"]);
    let mut engine = bums::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(0, "table");
    engine.add_region(RegionType::READ, "table", AbstractExpression::Immediate(64));
    engine.add_abstract_from(1, "fields");
    engine.add_region(RegionType::READ, "fields", AbstractExpression::Immediate(8));
    for index in 0..4 {
        engine.add_element_fact("fields", index, 2, format!("fields[{index}]"));
    }
    for &index in bounded {
        let field = abstract_of(format!("fields[{index}]"));
        for (op, value) in [(">=", -8), ("<=", 8)] {
            engine.add_invariant(AbstractComparison::new(
                op,
                field.clone(),
                AbstractExpression::Immediate(value),
            ));
        }
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_wide_load_does_not_lend_one_fields_bound_to_its_neighbour() {
    assert_eq!(
        index_from_packed_halfwords(&["sxth x5, w4"], &[0]),
        Ok(()),
        "the bounded low field was not recovered from the wide load"
    );
    for extract in [
        &["sbfx x5, x4, #16, #16"][..],
        &["sxth x5, w4", "asr x7, x4, #48", "add x5, x5, x7"][..],
    ] {
        assert!(
            index_from_packed_halfwords(extract, &[0, 2]).is_err(),
            "{extract:?} accepted an index taken from an unbounded field"
        );
    }
}

#[test]
fn shifting_a_wide_load_keeps_the_fields_above_the_shift() {
    for extract in [&["lsr x5, x4, #16"][..], &["asr x5, x4, #32"][..]] {
        assert!(
            index_from_packed_halfwords(extract, &[0, 1, 2, 3]).is_err(),
            "{extract:?} dropped the higher fields that make the index large"
        );
    }
    assert_eq!(
        index_from_packed_halfwords(&["asr x5, x4, #48"], &[0, 1, 2, 3]),
        Ok(()),
        "the top field alone is bounded"
    );
}

fn lane_indexes_table(prefix: &[&str], read_lane: &str, table: AbstractExpression) -> bool {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut program = vec!["start:".to_string()];
    program.extend(prefix.iter().map(|line| line.to_string()));
    program.extend([read_lane, "add x14, x14, x0", "ldrb w2, [x14]", "ret"].map(String::from));
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "table");
    engine.add_region(RegionType::READ, "table", table);
    engine.add_abstract_from(1, "max");
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("max"),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        abstract_of("max"),
        AbstractExpression::Immediate(4095),
    ));
    engine.start("start").is_ok()
}

fn past_max() -> AbstractExpression {
    generate_expression("+", abstract_of("max"), AbstractExpression::Immediate(1))
}

#[test]
fn a_shifted_lane_mask_bounds_only_up_to_its_value() {
    let mask_0fff = &["mvni v4.8h, #0xf0, lsl #8", "and v0.16b, v0.16b, v4.16b"];
    let read = "umov w14, v0.h[3]";
    assert!(lane_indexes_table(
        mask_0fff,
        read,
        AbstractExpression::Immediate(4096)
    ));
    assert!(
        !lane_indexes_table(mask_0fff, read, AbstractExpression::Immediate(4095)),
        "a lane masked to 0x0fff indexed a 4095-byte table"
    );
    let mask_f000 = &["movi v4.8h, #0xf0, lsl #8", "and v0.16b, v0.16b, v4.16b"];
    assert!(
        !lane_indexes_table(mask_f000, read, AbstractExpression::Immediate(4096)),
        "movi with a shift was read as its unshifted immediate"
    );
}

#[test]
fn a_halfword_lane_bound_does_not_bound_a_word_lane() {
    for clamp in ["umin v3.8h, v0.8h, v7.8h", "and v3.16b, v0.16b, v7.16b"] {
        let prefix = &["dup v7.8h, w1", clamp];
        assert!(lane_indexes_table(prefix, "umov w14, v3.h[2]", past_max()));
        assert!(
            !lane_indexes_table(prefix, "umov w14, v3.s[1]", past_max()),
            "{clamp}: a word lane borrowed the bound of its halfwords"
        );
        assert!(
            !lane_indexes_table(prefix, "mov w14, v3.s[1]", past_max()),
            "{clamp}: mov of a word lane borrowed the bound of its halfwords"
        );
    }
}

#[test]
fn a_signed_clamp_bounds_a_lane_only_with_a_zero_floor() {
    let read = "umov w14, v0.h[1]";
    let clamped = &[
        "dup v23.8h, w1",
        "movi v2.8h, #0",
        "smin v0.8h, v0.8h, v23.8h",
        "smax v0.8h, v0.8h, v2.8h",
    ];
    assert!(lane_indexes_table(clamped, read, past_max()));
    let no_floor = &["dup v23.8h, w1", "smin v0.8h, v0.8h, v23.8h"];
    assert!(
        !lane_indexes_table(no_floor, read, past_max()),
        "smin alone left negative lanes that index far past the table"
    );
    let unknown_floor = &[
        "dup v23.8h, w1",
        "mul v2.8h, v4.8h, v5.8h",
        "smin v0.8h, v0.8h, v23.8h",
        "smax v0.8h, v0.8h, v2.8h",
    ];
    assert!(
        !lane_indexes_table(unknown_floor, read, past_max()),
        "smax against an unknown vector kept the smin bound"
    );
    let floor_before_clamp = &[
        "dup v23.8h, w1",
        "movi v2.8h, #0",
        "smax v0.8h, v0.8h, v2.8h",
        "add v0.8h, v0.8h, v0.8h",
        "smin v0.8h, v0.8h, v23.8h",
    ];
    assert!(
        !lane_indexes_table(floor_before_clamp, read, past_max()),
        "a floor applied before an overflowing add still counted"
    );
    let wider_floor = &[
        "dup v23.8h, w1",
        "movi v2.4s, #0",
        "smin v0.8h, v0.8h, v23.8h",
        "smax v0.4s, v0.4s, v2.4s",
    ];
    assert!(
        !lane_indexes_table(wider_floor, read, past_max()),
        "a halfword smin bound survived a word-wide smax"
    );
}

fn two_row_walk_with_a_fill_exit(latch: &str, rows_in_region: AbstractExpression) -> bool {
    let _ = env_logger::builder().is_test(true).try_init();
    let program = [
        "start:",
        "mov w7,w5",
        "walk:",
        "lsr w8,w7,#6",
        "add w7,w7,w5",
        "cmp w8,w6",
        "b.ge fill",
        "ldrb w9,[x2,w8,uxtw]",
        "st1 {v16.s}[0], [x0], x1",
        "add w7,w7,w5",
        latch,
        "st1 {v17.s}[0], [x0], x1",
        "b.gt walk",
        "ret",
        "fill:",
        "st1 {v31.s}[0], [x0], x1",
        "subs w4,w4,#2",
        "st1 {v31.s}[0], [x0], x1",
        "b.gt fill",
        "ret",
    ];
    let mut engine = bums::engine::ExecutionEngine::new(program.iter().map(|s| s.to_string()));
    engine.add_abstract_from(0, "dst");
    engine.add_region(
        RegionType::WRITE,
        "dst",
        generate_expression("*", abstract_of("stride"), rows_in_region),
    );
    engine.add_abstract_from(1, "stride");
    engine.add_abstract_from(2, "top");
    engine.add_region(RegionType::READ, "top", AbstractExpression::Immediate(64));
    engine.add_abstract_expression_from(
        4,
        generate_expression(
            "%",
            abstract_of("height"),
            AbstractExpression::Immediate(1 << 32),
        ),
    );
    engine.add_abstract_from(5, "step");
    engine.add_abstract_from(6, "limit");
    for (op, name, value) in [
        (">=", "stride", 4),
        ("<=", "stride", 64),
        (">=", "height", 4),
        ("<=", "height", 12),
        (">=", "step", 0),
        ("<=", "step", 102),
        (">=", "limit", 1),
        ("<=", "limit", 30),
    ] {
        engine.add_invariant(AbstractComparison::new(
            op,
            abstract_of(name),
            AbstractExpression::Immediate(value),
        ));
    }
    engine.add_invariant(AbstractComparison::new(
        "==",
        abstract_of("height"),
        generate_expression("*", abstract_of("pairs"), AbstractExpression::Immediate(2)),
    ));
    engine.start("start").is_ok()
}

#[test]
fn a_two_row_walk_leaving_from_the_middle_still_needs_its_last_row() {
    let one_row_short =
        generate_expression("-", abstract_of("height"), AbstractExpression::Immediate(1));
    assert!(
        !two_row_walk_with_a_fill_exit("subs w4,w4,#2", one_row_short),
        "a walk writing one row past its region was accepted"
    );
}

#[test]
fn a_latch_counting_rows_one_at_a_time_does_not_bound_a_two_row_walk() {
    assert!(
        !two_row_walk_with_a_fill_exit("subs w4,w4,#1", abstract_of("height")),
        "a walk whose latch counts half its rows was accepted"
    );
}

fn word_countdown_walk(prologue: &[&str], slack: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let program: Vec<String> = std::iter::once("start:")
        .chain(prologue.iter().copied())
        .chain([
            "walk:",
            "ld1 { v0.16b, v1.16b }, [x0], #32",
            "subs w1, w1, #32",
            "b.pl walk",
            "done:",
            "ret",
        ])
        .map(str::to_string)
        .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "src");
    engine.add_region(
        RegionType::READ,
        "src",
        generate_expression(
            "+",
            abstract_of("size"),
            AbstractExpression::Immediate(slack),
        ),
    );
    engine.add_abstract_from(1, "size");
    for (op, bound) in [(">=", 0), ("<=", 1 << 30)] {
        engine.add_invariant(AbstractComparison::new(
            op,
            abstract_of("size"),
            AbstractExpression::Immediate(bound),
        ));
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_word_countdown_walk_one_byte_short_is_rejected() {
    let err = word_countdown_walk(&["subs w1, w1, #32", "b.mi done"], -1)
        .expect_err("the last load ends one byte past the region");
    assert!(err.contains("not provably within region"), "{err}");
}

#[test]
fn a_rebased_word_countdown_walk_one_byte_short_is_rejected() {
    let err = word_countdown_walk(&["subs w1, w1, #48", "b.mi done", "add w1, w1, #16"], -1)
        .expect_err("the last load ends one byte past the region");
    assert!(err.contains("not provably within region"), "{err}");
}

#[test]
fn a_minus_branch_falls_through_when_the_word_subtraction_overflows() {
    let _ = env_logger::builder().is_test(true).try_init();
    let program: Vec<String> = [
        "start:",
        "mov w3, w1",
        "subs w1, w1, #32",
        "b.mi done",
        "ldr x2, [x0, x3]",
        "done:",
        "ret",
    ]
    .map(str::to_string)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(
        RegionType::READ,
        "base",
        AbstractExpression::Immediate((1 << 31) + 8),
    );
    engine.add_abstract_from(1, "size");
    for (op, bound) in [(">=", 0), ("<", 1 << 32)] {
        engine.add_invariant(AbstractComparison::new(
            op,
            abstract_of("size"),
            AbstractExpression::Immediate(bound),
        ));
    }
    let err = engine
        .start("start")
        .map_err(|e| e.to_string())
        .expect_err("2^31 <= size < 2^31 + 32 overflows, clears N and reads past the region");
    assert!(err.contains("not provably within region"), "{err}");
}

fn within(engine: &bums::engine::ExecutionEngine, name: &str, low: i64, high: i64, unit: i64) {
    for (op, bound) in [(">=", low), ("<=", high)] {
        engine.add_invariant(AbstractComparison::new(
            op,
            abstract_of(name),
            AbstractExpression::Immediate(bound),
        ));
    }
    engine.add_invariant(AbstractComparison::new(
        "==",
        generate_expression("%", abstract_of(name), AbstractExpression::Immediate(unit)),
        AbstractExpression::Immediate(0),
    ));
}

#[test]
fn rows_walked_by_an_inner_word_countdown_one_byte_short_are_rejected() {
    let _ = env_logger::builder().is_test(true).try_init();
    let program: Vec<String> = [
        "start:",
        "sub x3, x3, w6, uxtw",
        "rows:",
        "mov w10, w6",
        "columns:",
        "ld1 { v0.16b }, [x2], #16",
        "subs w10, w10, #16",
        "b.ne columns",
        "add x2, x2, x3",
        "subs w7, w7, #1",
        "b.ne rows",
        "ret",
    ]
    .map(str::to_string)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(2, "src");
    let rows_before_last = generate_expression(
        "*",
        generate_expression("-", abstract_of("h"), AbstractExpression::Immediate(1)),
        abstract_of("stride"),
    );
    engine.add_region(
        RegionType::READ,
        "src",
        generate_expression(
            "-",
            generate_expression("+", rows_before_last, abstract_of("w")),
            AbstractExpression::Immediate(1),
        ),
    );
    engine.add_abstract_from(3, "stride");
    engine.add_abstract_from(6, "w");
    engine.add_abstract_from(7, "h");
    within(&engine, "w", 16, 4096, 16);
    within(&engine, "h", 1, 4096, 1);
    within(&engine, "stride", 16, 1 << 20, 1);
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("stride"),
        abstract_of("w"),
    ));
    let err = engine
        .start("start")
        .map_err(|e| e.to_string())
        .expect_err("the last row ends one byte past the region");
    assert!(err.contains("not provably within region"), "{err}");
}

#[test]
fn rows_walked_by_an_inner_word_count_up_one_byte_short_are_rejected() {
    let _ = env_logger::builder().is_test(true).try_init();
    let program: Vec<String> = [
        "start:",
        "mov w8, #0",
        "rows:",
        "mov w9, #0",
        "columns:",
        "st1 { v0.8h }, [x7], #16",
        "add w9, w9, #8",
        "cmp w9, w4",
        "b.lt columns",
        "add w8, w8, #2",
        "cmp w8, w5",
        "b.lt rows",
        "ret",
    ]
    .map(str::to_string)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(7, "out");
    engine.add_region(
        RegionType::RW,
        "out",
        generate_expression(
            "-",
            generate_expression("*", abstract_of("width"), abstract_of("height")),
            AbstractExpression::Immediate(1),
        ),
    );
    engine.add_abstract_from(4, "width");
    engine.add_abstract_from(5, "height");
    within(&engine, "width", 8, 64, 8);
    within(&engine, "height", 2, 64, 2);
    let err = engine
        .start("start")
        .map_err(|e| e.to_string())
        .expect_err("the last row ends one byte past the region");
    assert!(err.contains("not provably within region"), "{err}");
}

const NON_NEGATIVE: (i64, i64) = (0, i64::MAX);
const NEGATIVE: (i64, i64) = (i64::MIN, -1);

fn operands_within(invariants: &mut Vec<AbstractComparison>, name: &str, (low, high): (i64, i64)) {
    for (op, bound) in [(">=", low), ("<=", high)] {
        invariants.push(AbstractComparison::new(
            op,
            abstract_of(name),
            AbstractExpression::Immediate(bound),
        ));
    }
}

fn operand_invariants(a: (i64, i64), b: (i64, i64)) -> Vec<AbstractComparison> {
    let mut invariants = Vec::new();
    operands_within(&mut invariants, "a", a);
    operands_within(&mut invariants, "b", b);
    invariants
}

fn reaches_bad_on_arm(lines: &[&str], a: (i64, i64), b: (i64, i64)) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let program: Vec<String> = std::iter::once("start:")
        .chain(lines.iter().copied())
        .chain(["ret", "bad:", "ldr x5, [x0, #8]", "ret"])
        .map(str::to_string)
        .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(8));
    engine.add_abstract_from(1, "a");
    engine.add_abstract_from(2, "b");
    for invariant in operand_invariants(a, b) {
        engine.add_invariant(invariant);
    }
    engine.start("start").map_err(|e| e.to_string())
}

fn reaches_bad_on_x86(lines: &[&str], a: (i64, i64), b: (i64, i64)) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let program: Vec<String> = std::iter::once("start:")
        .chain(lines.iter().copied())
        .chain(["retq", "bad:", "movq 8(%rdi), %rax", "retq"])
        .map(str::to_string)
        .collect();
    let mut engine = bums::x86::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(8));
    engine.add_abstract_from(1, "a");
    engine.add_abstract_from(2, "b");
    for invariant in operand_invariants(a, b) {
        engine.add_invariant(invariant);
    }
    engine.start("start").map_err(|e| e.to_string())
}

type Probe = fn(&[&str], (i64, i64), (i64, i64)) -> Result<(), String>;

fn assert_reaches_bad(result: Result<(), String>, why: &str) {
    let err = result.expect_err(why);
    assert!(err.contains("not provably within region"), "{err}");
}

type Range = (i64, i64);

fn assert_all_reach_bad(probe: Probe, cases: &[(&[&str], Range, Range)], why: &str) {
    let missed: Vec<String> = cases
        .iter()
        .filter_map(|(lines, a, b)| match probe(lines, *a, *b) {
            Err(e) if e.contains("not provably within region") => None,
            other => Some(format!("{lines:?} -> {other:?}")),
        })
        .collect();
    assert!(missed.is_empty(), "{why}; accepted: {missed:#?}");
}

#[test]
fn a_doubleword_compare_that_overflows_upward_sets_v() {
    let cases: Vec<(&[&str], _, _)> = [
        &["cmp x1, x2", "b.vs bad"][..],
        &["cmp x1, x2", "b.vc done", "b bad", "done:"],
        &["subs x3, x1, x2", "b.vs bad"],
        &["cmp x1, x2", "cset x4, vs", "cbnz x4, bad"],
        &["cmp x1, x2", "b.mi bad"],
    ]
    .into_iter()
    .map(|lines| (lines, NON_NEGATIVE, NEGATIVE))
    .collect();
    assert_all_reach_bad(
        reaches_bad_on_arm,
        &cases,
        "2^62 - (-2^62) overflows, sets V and wraps negative",
    );
}

#[test]
fn a_doubleword_compare_that_overflows_downward_sets_v() {
    assert_reaches_bad(
        reaches_bad_on_arm(&["cmp x2, x1", "b.vs bad"], (1, i64::MAX), NEGATIVE),
        "-2^62 - 2^62 - 1 overflows and sets V",
    );
}

#[test]
fn a_doubleword_compare_keeps_the_signed_order_across_overflow() {
    assert_reaches_bad(
        reaches_bad_on_arm(
            &["cmp x1, x2", "b.lt done", "b bad", "done:"],
            NON_NEGATIVE,
            NEGATIVE,
        ),
        "a non-negative value is never less than a negative one",
    );
}

#[test]
fn a_doubleword_add_that_overflows_sets_v() {
    let cases: Vec<(&[&str], _, _)> = [
        &["cmn x1, x2", "b.vs bad"][..],
        &["adds x3, x1, x2", "b.vc done", "b bad", "done:"],
        &["adds x3, x1, x2", "b.mi bad"],
        &["adds x3, x1, x2", "b.lt done", "b bad", "done:"],
    ]
    .into_iter()
    .map(|lines| (lines, NON_NEGATIVE, NON_NEGATIVE))
    .collect();
    assert_all_reach_bad(
        reaches_bad_on_arm,
        &cases,
        "2^62 + 2^62 overflows, sets V and wraps negative",
    );
    assert_reaches_bad(
        reaches_bad_on_arm(&["cmn x1, x2", "b.vs bad"], NEGATIVE, NEGATIVE),
        "-2^63 + -1 overflows and sets V",
    );
}

#[test]
fn a_doubleword_compare_that_cannot_overflow_clears_v() {
    let small = (-(1i64 << 40), 1i64 << 40);
    for lines in [
        &["cmp x1, x2", "b.vs bad"][..],
        &["cmn x1, x2", "b.vc done", "b bad", "done:"],
        &["adds x3, x1, x2", "b.vs bad"],
    ] {
        assert_eq!(reaches_bad_on_arm(lines, small, small), Ok(()), "{lines:?}");
    }
}

#[test]
fn an_x86_quadword_compare_that_overflows_sets_of_and_wraps_the_sign() {
    let cases: Vec<(&[&str], _, _)> = [
        &["cmpq %rdx, %rsi", "jo bad"][..],
        &["cmpq %rdx, %rsi", "jno done", "jmp bad", "done:"],
        &["cmpq %rdx, %rsi", "js bad"],
        &["subq %rdx, %rsi", "jo bad"],
        &["subq %rdx, %rsi", "js bad"],
    ]
    .into_iter()
    .map(|lines| (lines, NON_NEGATIVE, NEGATIVE))
    .collect();
    assert_all_reach_bad(
        reaches_bad_on_x86,
        &cases,
        "2^62 - (-2^62) overflows, sets OF and wraps negative",
    );
}

#[test]
fn an_x86_quadword_add_that_overflows_sets_of_and_wraps_the_sign() {
    let cases: Vec<(&[&str], _, _)> = [
        &["addq %rdx, %rsi", "jo bad"][..],
        &["addq %rdx, %rsi", "js bad"],
        &["addq %rdx, %rsi", "jl done", "jmp bad", "done:"],
    ]
    .into_iter()
    .map(|lines| (lines, NON_NEGATIVE, NON_NEGATIVE))
    .collect();
    assert_all_reach_bad(
        reaches_bad_on_x86,
        &cases,
        "2^62 + 2^62 overflows, sets OF and wraps negative",
    );
}

#[test]
fn an_x86_quadword_compare_keeps_the_signed_order_across_overflow() {
    assert_reaches_bad(
        reaches_bad_on_x86(
            &["cmpq %rdx, %rsi", "jl done", "jmp bad", "done:"],
            NON_NEGATIVE,
            NEGATIVE,
        ),
        "a non-negative value is never less than a negative one",
    );
}

#[test]
fn an_x86_doubleword_compare_is_signed() {
    let word = (0, (1i64 << 32) - 1);
    assert_reaches_bad(
        reaches_bad_on_x86(&["cmpl %edx, %esi", "jl bad"], word, (0, 0)),
        "esi = 0xffffffff is -1, less than 0",
    );
    assert_reaches_bad(
        reaches_bad_on_x86(&["cmpl %edx, %esi", "jo bad"], word, (1, 1)),
        "0x80000000 - 1 overflows",
    );
}

#[test]
fn an_x86_doubleword_step_across_the_signed_bound_sets_of() {
    let minimum = (1i64 << 31, 1i64 << 31);
    let maximum = ((1i64 << 31) - 1, (1i64 << 31) - 1);
    let cases: Vec<(&[&str], _, _)> = [
        (&["decl %esi", "jl bad"][..], minimum),
        (&["decl %esi", "jo bad"], minimum),
        (&["subl $1, %esi", "jl bad"], minimum),
        (&["incl %esi", "jo bad"], maximum),
        (&["addl $1, %esi", "jge bad"], maximum),
    ]
    .into_iter()
    .map(|(lines, a)| (lines, a, (0, 0)))
    .collect();
    assert_all_reach_bad(
        reaches_bad_on_x86,
        &cases,
        "the word wraps across its signed bound and sets OF",
    );
}

#[test]
fn an_x86_compare_that_cannot_overflow_clears_of() {
    let small = (-(1i64 << 40), 1i64 << 40);
    for lines in [
        &["cmpq %rdx, %rsi", "jo bad"][..],
        &["addq %rdx, %rsi", "jno done", "jmp bad", "done:"],
    ] {
        assert_eq!(reaches_bad_on_x86(lines, small, small), Ok(()), "{lines:?}");
    }
}

const SET_CARRY: &str = "cmp x0, x0";
const CLEAR_CARRY: &str = "cmn xzr, xzr";

fn with_prelude<'a>(prelude: &[&'a str], lines: &[&'a str]) -> Vec<&'a str> {
    prelude.iter().chain(lines).copied().collect()
}

fn assert_each_reaches_bad(
    probe: Probe,
    prelude: &[&str],
    cases: &[(&[&str], Range, Range)],
    why: &str,
) {
    let missed: Vec<String> = cases
        .iter()
        .filter_map(|(lines, a, b)| {
            let program = with_prelude(prelude, lines);
            match probe(&program, *a, *b) {
                Err(e) if e.contains("not provably within region") => None,
                other => Some(format!("{program:?} a={a:?} b={b:?} -> {other:?}")),
            }
        })
        .collect();
    assert!(missed.is_empty(), "{why}; accepted: {missed:#?}");
}

fn assert_each_stays_clear(probe: Probe, prelude: &[&str], cases: &[(&[&str], Range, Range)]) {
    for (lines, a, b) in cases {
        let program = with_prelude(prelude, lines);
        assert_eq!(
            probe(&program, *a, *b),
            Ok(()),
            "{program:?} a={a:?} b={b:?}"
        );
    }
}

#[test]
fn a_doubleword_add_with_a_set_carry_flags_the_sum_plus_one() {
    let below_zero = ((0, 5), (-6, -6));
    let cases: Vec<(&[&str], Range, Range)> = vec![
        (&["adcs x3, x1, x2", "b.eq bad"], below_zero.0, below_zero.1),
        (
            &["adcs x3, x1, x2", "b.ne done", "b bad", "done:"],
            below_zero.0,
            below_zero.1,
        ),
        (
            &["adcs x3, x1, x2", "b.mi done", "b bad", "done:"],
            below_zero.0,
            below_zero.1,
        ),
        (
            &["adcs x3, x1, x2", "b.lt done", "b bad", "done:"],
            below_zero.0,
            below_zero.1,
        ),
        (
            &["adcs x3, x1, x2", "b.vs bad"],
            (i64::MAX - 5, i64::MAX),
            (0, 0),
        ),
        (
            &["adcs x3, x1, x2", "b.mi bad"],
            (i64::MAX - 5, i64::MAX),
            (0, 0),
        ),
        (
            &[
                "mov x4, #-1",
                "mov x5, #0",
                SET_CARRY,
                "adcs x3, x4, x5",
                "b.cs bad",
            ],
            (0, 0),
            (0, 0),
        ),
        (
            &[
                "mov x4, #-1",
                "mov x5, #0",
                SET_CARRY,
                "adcs x3, x4, x5",
                "b.eq bad",
            ],
            (0, 0),
            (0, 0),
        ),
        (
            &[
                "mov x4, #-1",
                "mov x5, #0",
                SET_CARRY,
                "adcs x3, x4, x5",
                "b.pl bad",
            ],
            (0, 0),
            (0, 0),
        ),
    ];
    assert_each_reaches_bad(
        reaches_bad_on_arm,
        &[SET_CARRY],
        &cases,
        "adcs with C set computes a + b + 1",
    );
}

#[test]
fn a_doubleword_subtract_with_a_clear_carry_flags_the_difference_minus_one() {
    let cases: Vec<(&[&str], Range, Range)> = vec![
        (&["sbcs x3, x1, x2", "b.eq bad"], (1, 5), (0, 0)),
        (&["sbcs x3, x1, x2", "b.mi bad"], (1, 5), (1, 1)),
        (&["sbcs x3, x1, x2", "b.lt bad"], (1, 5), (1, 1)),
        (&["sbcs x3, x1, x2", "b.cc bad"], (3, 3), (3, 3)),
        (&["sbcs x3, x1, x2", "b.ls bad"], (3, 4), (3, 3)),
        (&["sbcs x3, x1, x2", "b.hi bad"], (4, 5), (3, 3)),
        (&["sbcs x3, x1, x2", "b.ls bad"], (-1, -1), (-3, -2)),
        (
            &["sbcs x3, x1, x2", "b.vs bad"],
            (i64::MIN, i64::MIN + 5),
            (0, 0),
        ),
        (
            &[
                "mov x4, #3",
                "mov x5, #3",
                CLEAR_CARRY,
                "sbcs x3, x4, x5",
                "b.cc bad",
            ],
            (0, 0),
            (0, 0),
        ),
        (
            &[
                "mov x4, #3",
                "mov x5, #3",
                CLEAR_CARRY,
                "sbcs x3, x4, x5",
                "b.ne bad",
            ],
            (0, 0),
            (0, 0),
        ),
        (
            &[
                "mov x4, #3",
                "mov x5, #3",
                CLEAR_CARRY,
                "sbcs x3, x4, x5",
                "b.mi bad",
            ],
            (0, 0),
            (0, 0),
        ),
    ];
    assert_each_reaches_bad(
        reaches_bad_on_arm,
        &[CLEAR_CARRY],
        &cases,
        "sbcs with C clear computes a - b - 1 and borrows when a <= b",
    );
}

#[test]
fn a_word_add_with_a_set_carry_flags_the_sum_plus_one() {
    let top = (0x7fff_fff0, 0x7fff_ffff);
    let cases: Vec<(&[&str], Range, Range)> = vec![
        (&["adcs w3, w1, w2", "b.vs bad"], top, (0, 0)),
        (&["adcs w3, w1, w2", "b.mi bad"], top, (0, 0)),
        (
            &["adcs w3, w1, w2", "b.lt done", "b bad", "done:"],
            (0, 5),
            (0xffff_fffa, 0xffff_fffa),
        ),
        (
            &["adcs w3, w1, w2", "b.eq bad"],
            (0xffff_fff0, 0xffff_ffff),
            (0, 0),
        ),
        (
            &[
                "mov w4, #-1",
                "mov w5, #0",
                SET_CARRY,
                "adcs w3, w4, w5",
                "b.cs bad",
            ],
            (0, 0),
            (0, 0),
        ),
        (
            &[
                "mov w4, #-1",
                "mov w5, #0",
                SET_CARRY,
                "adcs w3, w4, w5",
                "b.eq bad",
            ],
            (0, 0),
            (0, 0),
        ),
    ];
    assert_each_reaches_bad(
        reaches_bad_on_arm,
        &[SET_CARRY],
        &cases,
        "a word adcs with C set computes a + b + 1",
    );
}

#[test]
fn a_word_subtract_with_a_clear_carry_flags_the_difference_minus_one() {
    let cases: Vec<(&[&str], Range, Range)> = vec![
        (&["sbcs w3, w1, w2", "b.eq bad"], (1, 5), (0, 0)),
        (&["sbcs w3, w1, w2", "b.mi bad"], (1, 5), (1, 1)),
        (&["sbcs w3, w1, w2", "b.lt bad"], (1, 5), (1, 1)),
        (&["sbcs w3, w1, w2", "b.cc bad"], (3, 3), (3, 3)),
        (
            &["sbcs w3, w1, w2", "b.vs bad"],
            (0x8000_0000, 0x8000_0005),
            (0, 0),
        ),
        (
            &[
                "mov w4, #3",
                "mov w5, #3",
                CLEAR_CARRY,
                "sbcs w3, w4, w5",
                "b.cc bad",
            ],
            (0, 0),
            (0, 0),
        ),
    ];
    assert_each_reaches_bad(
        reaches_bad_on_arm,
        &[CLEAR_CARRY],
        &cases,
        "a word sbcs with C clear computes a - b - 1",
    );
}

#[test]
fn an_add_with_a_symbolic_carry_does_not_keep_the_carryless_flags() {
    let cases: Vec<(&[&str], Range, Range)> = vec![
        (
            &[
                "cmp x1, x1",
                "adds x6, x2, x2",
                "adcs x3, x1, x2",
                "b.eq bad",
            ],
            (0, 5),
            (-6, -6),
        ),
        (
            &["cmp x2, x1", "sbcs x3, x1, x2", "b.eq bad"],
            (1, 5),
            (0, 0),
        ),
        (
            &["cmp x2, x1", "sbcs x3, x1, x2", "b.cc bad"],
            (3, 3),
            (3, 3),
        ),
    ];
    assert_each_reaches_bad(
        reaches_bad_on_arm,
        &[],
        &cases,
        "a carry that may be set or clear leaves both outcomes open",
    );
}

#[test]
fn a_carrying_op_that_overwrites_its_source_flags_the_original_operands() {
    assert_each_reaches_bad(
        reaches_bad_on_arm,
        &[CLEAR_CARRY],
        &[(&["adcs x1, x1, x2", "b.eq bad"], (0, 5), (-5, -5))],
        "x1 + x2 reaches zero at x1 = 5, before x1 is overwritten",
    );
    assert_each_reaches_bad(
        reaches_bad_on_arm,
        &[SET_CARRY],
        &[
            (&["sbcs x1, x1, x2", "b.eq bad"], (0, 5), (5, 5)),
            (&["adcs x2, x1, x2", "b.eq bad"], (0, 5), (-6, -6)),
        ],
        "the flags describe the operands as they were read",
    );
}

#[test]
fn a_sum_that_wraps_to_zero_sets_z() {
    assert_each_reaches_bad(
        reaches_bad_on_arm,
        &[],
        &[
            (
                &["adds w3, w1, w2", "b.eq bad"],
                (0xffff_fff0, 0xffff_ffff),
                (1, 1),
            ),
            (
                &["cmn w1, w2", "b.eq bad"],
                (0xffff_fff0, 0xffff_ffff),
                (1, 1),
            ),
            (
                &["adds x3, x1, x2", "b.eq bad"],
                (i64::MIN, i64::MIN),
                (i64::MIN, i64::MIN),
            ),
            (
                &[CLEAR_CARRY, "adcs w3, w1, w2", "b.eq bad"],
                (0xffff_fff0, 0xffff_ffff),
                (1, 1),
            ),
            (
                &[CLEAR_CARRY, "sbcs x3, x1, x2", "b.eq bad"],
                (i64::MIN, i64::MIN),
                (i64::MAX, i64::MAX),
            ),
            (
                &["adds w3, w1, #1", "b.ne done", "b bad", "done:"],
                (0xffff_fff0, 0xffff_ffff),
                (0, 0),
            ),
            (
                &["cmn w1, #16", "cset w4, eq", "cbnz w4, bad"],
                (0xffff_fff0, 0xffff_ffff),
                (0, 0),
            ),
            (
                &["subs w3, w1, w2", "b.eq bad"],
                (0, 0),
                (-(1 << 32), -(1 << 32)),
            ),
        ],
        "the zero flag tests the wrapped sum",
    );
}

#[test]
fn a_carry_chain_that_cannot_reach_the_flag_stays_clear() {
    let small = (0, 5);
    assert_each_stays_clear(
        reaches_bad_on_arm,
        &[SET_CARRY],
        &[
            (&["adcs x3, x1, x2", "b.eq bad"], small, small),
            (&["adcs x3, x1, x2", "b.vs bad"], small, small),
            (&["adcs x3, x1, x2", "b.mi bad"], small, small),
            (&["adcs w3, w1, w2", "b.mi bad"], small, small),
            (
                &["adcs x3, x1, x2", "b.gt done", "b bad", "done:"],
                small,
                small,
            ),
        ],
    );
    assert_each_stays_clear(
        reaches_bad_on_arm,
        &[CLEAR_CARRY],
        &[
            (&["sbcs x3, x1, x2", "b.cc bad"], (5, 9), (0, 3)),
            (&["sbcs x3, x1, x2", "b.mi bad"], (5, 9), (0, 3)),
            (&["sbcs x3, x1, x2", "b.eq bad"], (5, 9), (0, 3)),
            (&["sbcs x3, x1, x2", "b.vs bad"], (5, 9), (0, 3)),
            (&["sbcs w3, w1, w2", "b.cc bad"], (5, 9), (0, 3)),
            (&["sbcs x3, x1, x2", "b.lt bad"], (5, 9), (0, 3)),
            (&["sbcs x3, x1, x2", "b.ls bad"], (5, 9), (0, 3)),
        ],
    );
}

#[test]
fn an_x86_add_with_a_set_carry_flags_the_sum_plus_one() {
    let cases: Vec<(&[&str], Range, Range)> = vec![
        (&["adcq %rdx, %rsi", "je bad"], (0, 5), (-6, -6)),
        (
            &["adcq %rdx, %rsi", "js done", "jmp bad", "done:"],
            (0, 5),
            (-6, -6),
        ),
        (
            &["adcq %rdx, %rsi", "jl done", "jmp bad", "done:"],
            (0, 5),
            (-6, -6),
        ),
        (
            &["adcq %rdx, %rsi", "jo bad"],
            (i64::MAX - 5, i64::MAX),
            (0, 0),
        ),
        (
            &["adcl %edx, %esi", "jo bad"],
            (0x7fff_fff0, 0x7fff_ffff),
            (0, 0),
        ),
        (
            &["adcl %edx, %esi", "js bad"],
            (0x7fff_fff0, 0x7fff_ffff),
            (0, 0),
        ),
        (
            &["adcl %edx, %esi", "je bad"],
            (0xffff_fff0, 0xffff_ffff),
            (0, 0),
        ),
        (
            &[
                "movq $-1, %rax",
                "movq $0, %rcx",
                "stc",
                "adcq %rcx, %rax",
                "jc bad",
            ],
            (0, 0),
            (0, 0),
        ),
        (
            &[
                "movq $-1, %rax",
                "movq $0, %rcx",
                "stc",
                "adcq %rcx, %rax",
                "je bad",
            ],
            (0, 0),
            (0, 0),
        ),
    ];
    assert_each_reaches_bad(
        reaches_bad_on_x86,
        &["stc"],
        &cases,
        "adc with CF set computes a + b + 1",
    );
}

#[test]
fn an_x86_subtract_with_a_set_borrow_flags_the_difference_minus_one() {
    let cases: Vec<(&[&str], Range, Range)> = vec![
        (&["sbbq %rdx, %rsi", "je bad"], (1, 5), (0, 0)),
        (&["sbbq %rdx, %rsi", "jl bad"], (1, 5), (1, 1)),
        (&["sbbq %rdx, %rsi", "js bad"], (1, 5), (1, 1)),
        (
            &["sbbq %rdx, %rsi", "jo bad"],
            (i64::MIN, i64::MIN + 5),
            (0, 0),
        ),
        (
            &["sbbl %edx, %esi", "jo bad"],
            (0x8000_0000, 0x8000_0005),
            (0, 0),
        ),
        (&["sbbq %rdx, %rsi", "jc bad"], (3, 3), (3, 3)),
        (
            &[
                "movq $3, %rax",
                "movq $3, %rcx",
                "stc",
                "sbbq %rcx, %rax",
                "jne bad",
            ],
            (0, 0),
            (0, 0),
        ),
    ];
    assert_each_reaches_bad(
        reaches_bad_on_x86,
        &["stc"],
        &cases,
        "sbb with CF set computes a - b - 1",
    );
}

fn load_of_a_declared_element(load: &str, least: i64, most: i64) -> Result<(), String> {
    let past_base = if least < 0 { 65536 } else { 0 };
    run_with(
        &[
            "start:",
            &format!("{load},[x1]"),
            &format!("add x4,x0,#{past_base}"),
            "ldrb w5,[x4,x3]",
            "ret",
        ],
        |e| {
            buffer(e, 0, "data", 65538);
            e.add_abstract_from(1, "fields");
            e.add_region(RegionType::READ, "fields", AbstractExpression::Immediate(2));
            e.add_element_fact("fields", 0, 2, "fields[0]");
            for (op, bound) in [(">=", least), ("<=", most)] {
                e.add_invariant(AbstractComparison::new(
                    op,
                    abstract_of("fields[0]"),
                    AbstractExpression::Immediate(bound),
                ));
            }
        },
    )
}

#[test]
fn a_declared_element_loads_as_the_bits_the_load_extends() {
    assert!(
        load_of_a_declared_element("ldrh w3", -2, -1).is_err(),
        "an i16 element of -1 zero-extends to 65535, past the end"
    );
    assert!(
        load_of_a_declared_element("ldrsh x3", 65534, 65535).is_err(),
        "a u16 element of 65535 sign-extends to -1, before the base"
    );
    assert!(
        load_of_a_declared_element("ldrsh w3", -2, -1).is_err(),
        "a sign-extended word leaves the upper half of x3 zero"
    );
    assert_eq!(load_of_a_declared_element("ldrsh x3", -2, -1), Ok(()));
    assert_eq!(load_of_a_declared_element("ldrh w3", 65534, 65535), Ok(()));
}

fn small_cdf_entry(first: &str, end: AbstractExpression) -> IndexedFact {
    IndexedFact::elements(format!("cdf[{first}..]"), abstract_of(first), end, 2, false)
        .bounded("<=", AbstractExpression::Immediate(32))
}

fn at_one_entry(first: &str) -> IndexedFact {
    small_cdf_entry(
        first,
        generate_expression("+", abstract_of(first), AbstractExpression::Immediate(1)),
    )
}

fn between(name: &str, least: i64, most: i64) -> [AbstractComparison; 2] {
    [
        AbstractComparison::new(
            ">=",
            abstract_of(name),
            AbstractExpression::Immediate(least),
        ),
        AbstractComparison::new("<=", abstract_of(name), AbstractExpression::Immediate(most)),
    ]
}

fn reading_cdf(
    body: &[&str],
    fact: IndexedFact,
    facts: &[AbstractComparison],
) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut lines = vec!["start:"];
    lines.extend_from_slice(body);
    lines.push("ret");
    let program: Vec<String> = lines.iter().map(|s| s.to_string()).collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    buffer(&mut engine, 0, "cdf", 32);
    engine.add_abstract_from(1, "n");
    engine.add_abstract_from(2, "j");
    buffer(&mut engine, 3, "data", 33);
    for fact in between("n", 0, 15)
        .iter()
        .chain(&between("j", 0, 15))
        .chain(facts)
    {
        engine.add_invariant(fact.clone());
    }
    engine.add_indexed_fact("cdf", fact)?;
    let verdict = engine.start("start").map_err(|e| e.to_string());
    let unread = engine.unread_element_facts();
    verdict.and(if unread.is_empty() {
        Ok(())
    } else {
        Err(format!("never read: {}", unread.join(", ")))
    })
}

const INDEX_BY_ENTRY: [&str; 2] = ["ldrh w4,[x0,x1,lsl #1]", "ldrb w5,[x3,x4]"];

#[test]
fn an_entry_at_a_symbolic_index_carries_its_fact() {
    assert_eq!(reading_cdf(&INDEX_BY_ENTRY, at_one_entry("n"), &[]), Ok(()));
    assert_eq!(
        reading_cdf(
            &[
                "cmp x1,x2",
                "b.ne skip",
                "ldrh w4,[x0,x2,lsl #1]",
                "ldrb w5,[x3,x4]",
                "skip:",
            ],
            at_one_entry("n"),
            &[]
        ),
        Ok(())
    );
}

#[test]
fn an_entry_at_another_index_does_not_get_the_fact() {
    assert!(
        reading_cdf(
            &["ldrh w4,[x0,x2,lsl #1]", "ldrb w5,[x3,x4]"],
            at_one_entry("n"),
            &[]
        )
        .is_err(),
        "cdf[j] got the fact of cdf[n] though j may differ from n"
    );
    assert!(
        reading_cdf(&["ldrh w4,[x0]", "ldrb w5,[x3,x4]"], at_one_entry("n"), &[]).is_err(),
        "cdf[0] got the fact of cdf[n] though n may be 3"
    );
    assert!(
        reading_cdf(
            &["ldrb w4,[x0,x1,lsl #1]", "ldrb w5,[x3,x4]"],
            at_one_entry("n"),
            &[]
        )
        .is_err(),
        "a byte read of a 16-bit entry got the entry's fact"
    );
    assert!(
        reading_cdf(
            &["add x6,x0,#1", "ldrh w4,[x6,x1,lsl #1]", "ldrb w5,[x3,x4]"],
            at_one_entry("n"),
            &[]
        )
        .is_err(),
        "a read straddling two entries got the fact"
    );
}

#[test]
fn a_write_that_may_alias_the_entry_drops_its_fact() {
    let rewritten = |write: &str, facts: &[AbstractComparison]| {
        reading_cdf(
            &[
                "mov w6,#1000",
                write,
                "ldrh w4,[x0,x1,lsl #1]",
                "ldrb w5,[x3,x4]",
            ],
            at_one_entry("n"),
            facts,
        )
    };
    assert!(
        rewritten("strh w6,[x0,x2,lsl #1]", &[]).is_err(),
        "a write to cdf[j] kept the fact of cdf[n]"
    );
    assert!(
        rewritten("strh w6,[x0]", &[]).is_err(),
        "a write to cdf[0] kept the fact of cdf[n]"
    );
    assert!(
        rewritten("strb w6,[x0,#7]", &[]).is_err(),
        "a byte written into cdf[3] kept the fact of cdf[n]"
    );
    let apart = AbstractComparison::new("!=", abstract_of("j"), abstract_of("n"));
    assert_eq!(rewritten("strh w6,[x0,x2,lsl #1]", &[apart]), Ok(()));
    let past_zero =
        AbstractComparison::new(">=", abstract_of("n"), AbstractExpression::Immediate(1));
    assert_eq!(rewritten("strh w6,[x0]", &[past_zero]), Ok(()));
}

#[test]
fn an_entry_fact_needs_an_index_inside_the_region() {
    let past_the_end =
        AbstractComparison::new("<=", abstract_of("n"), AbstractExpression::Immediate(16));
    let mut engine = bums::engine::ExecutionEngine::new(vec!["start:".to_string()]);
    buffer(&mut engine, 0, "cdf", 32);
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("n"),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(past_the_end);
    let refused = engine.add_indexed_fact("cdf", at_one_entry("n"));
    assert!(
        refused.is_err(),
        "cdf[n] with n <= 16 was accepted for 16 entries"
    );
    let negative = generate_expression("-", abstract_of("n"), AbstractExpression::Immediate(1));
    let before = IndexedFact {
        first: negative.clone(),
        end: abstract_of("n"),
        ..at_one_entry("n")
    };
    assert!(engine.add_indexed_fact("cdf", before).is_err());
}

#[test]
fn a_range_fact_covers_every_entry_from_its_index() {
    let tail = small_cdf_entry("n", AbstractExpression::Immediate(16));
    let at_or_past_n = AbstractComparison::new(">=", abstract_of("j"), abstract_of("n"));
    assert_eq!(
        reading_cdf(
            &["ldrh w4,[x0,x2,lsl #1]", "ldrb w5,[x3,x4]"],
            tail.clone(),
            &[at_or_past_n]
        ),
        Ok(())
    );
    assert!(
        reading_cdf(&["ldrh w4,[x0,x2,lsl #1]", "ldrb w5,[x3,x4]"], tail, &[]).is_err(),
        "cdf[j] for j below n got the fact of cdf[n..]"
    );
}

const LOAD_SIXTEEN_ENTRIES: &str = "ld1 {v0.8h, v1.8h}, [x0]";

#[test]
fn a_sixteen_lane_load_gives_the_fact_only_to_the_lane_of_its_index() {
    let lane_three = [LOAD_SIXTEEN_ENTRIES, "umov w4, v0.h[3]", "ldrb w5,[x3,x4]"];
    let pinned = AbstractComparison::new("==", abstract_of("n"), AbstractExpression::Immediate(3));
    assert_eq!(
        reading_cdf(&lane_three, at_one_entry("n"), &[pinned]),
        Ok(())
    );
    let elsewhere =
        AbstractComparison::new("==", abstract_of("n"), AbstractExpression::Immediate(4));
    assert!(
        reading_cdf(&lane_three, at_one_entry("n"), &[elsewhere]).is_err(),
        "lane 3 got the fact of cdf[4]"
    );
    assert!(
        reading_cdf(&lane_three, at_one_entry("n"), &[]).is_err(),
        "lane 3 got the fact of cdf[n] though n may differ from 3"
    );
    let upper_lane = [LOAD_SIXTEEN_ENTRIES, "umov w4, v1.h[2]", "ldrb w5,[x3,x4]"];
    let ten = AbstractComparison::new("==", abstract_of("n"), AbstractExpression::Immediate(10));
    assert_eq!(reading_cdf(&upper_lane, at_one_entry("n"), &[ten]), Ok(()));
}

fn counting_small_entries(threshold: i64, before: &[&str]) -> Result<(), String> {
    let compare = format!("movi v30.8h, #{threshold}");
    let mut body: Vec<&str> = before.to_vec();
    body.extend_from_slice(&[
        LOAD_SIXTEEN_ENTRIES,
        &compare,
        "cmhs v2.8h, v30.8h, v0.8h",
        "cmhs v3.8h, v30.8h, v1.8h",
        "add v6.8h, v2.8h, v3.8h",
        "addv h31, v6.8h",
        "smov w15, v31.h[0]",
        "add x8, x3, w15, sxtw",
        "ldrb w5, [x8, #16]",
    ]);
    let _ = env_logger::builder().is_test(true).try_init();
    let mut lines = vec!["start:"];
    lines.extend_from_slice(&body);
    lines.push("ret");
    let program: Vec<String> = lines.iter().map(|s| s.to_string()).collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    buffer(&mut engine, 0, "cdf", 32);
    engine.add_abstract_from(1, "n");
    engine.add_abstract_from(2, "j");
    buffer(&mut engine, 3, "data", 16);
    for fact in between("n", 0, 15).iter().chain(&between("j", 0, 15)) {
        engine.add_invariant(fact.clone());
    }
    engine.add_indexed_fact("cdf", at_one_entry("n"))?;
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn the_lane_of_the_index_decides_a_lane_count() {
    assert_eq!(counting_small_entries(32, &[]), Ok(()));
    assert!(
        counting_small_entries(31, &[]).is_err(),
        "cdf[n] may be 32, so no lane need be at most 31"
    );
    assert!(
        counting_small_entries(32, &["mov w6, #1000", "strh w6, [x0, x2, lsl #1]"]).is_err(),
        "a write to cdf[j] may have replaced cdf[n]"
    );
}

fn doubled_high_half(first: &str, second: &str, length: i64) -> Result<(), String> {
    run_with(
        &[
            "start:",
            &format!("movi v0.8h, {first}"),
            &format!("movi v1.8h, {second}"),
            "sqdmulh v2.8h, v0.8h, v1.8h",
            "umov w4, v2.h[5]",
            "ldrb w5, [x3, x4]",
            "ret",
        ],
        |e| buffer(e, 3, "data", length),
    )
}

#[test]
fn sqdmulh_is_bounded_by_its_operands_and_saturates() {
    assert_eq!(doubled_high_half("#100", "#0x7f, lsl #8", 101), Ok(()));
    assert!(
        doubled_high_half("#100", "#0x7f, lsl #8", 99).is_err(),
        "2 * 100 * 0x7f00 >> 16 is 99, one past a 99-byte region"
    );
    assert_eq!(
        doubled_high_half("#0x80, lsl #8", "#0x80, lsl #8", 32768),
        Ok(())
    );
    assert!(
        doubled_high_half("#0x80, lsl #8", "#0x80, lsl #8", 32767).is_err(),
        "-32768 * -32768 saturates to 32767, past a 32767-byte region"
    );
}

#[test]
fn exact_lanes_do_not_survive_into_another_loop_iteration() {
    let counted = run_with(
        &[
            "start:",
            "movi v0.8h, #0",
            "movi v1.8h, #1",
            "mov x5, #0",
            "again:",
            "add v0.8h, v0.8h, v1.8h",
            "add x5, x5, #1",
            "cmp x5, x2",
            "b.lo again",
            "umov w4, v0.h[0]",
            "ldrb w6, [x3, x4]",
            "ret",
        ],
        |e| {
            buffer(e, 3, "data", 4);
            e.add_abstract_from(2, "count");
            for fact in between("count", 1, 1000) {
                e.add_invariant(fact);
            }
        },
    );
    assert!(
        counted.is_err(),
        "the lane counts the iterations, up to 1000, past a four-byte region"
    );
}

fn clamped_at_zero(length: i64, least: i64, most: i64) -> Result<(), String> {
    run_with(
        &[
            "start:",
            "sub w6, w2, #8",
            "bic w6, w6, w6, asr #31",
            "ldrb w3, [x0, x6]",
            "ret",
        ],
        |e| {
            buffer(e, 0, "data", length);
            e.add_abstract_from(2, "x");
            for fact in between("x", least, most) {
                e.add_invariant(fact);
            }
        },
    )
}

#[test]
fn a_word_clamped_at_zero_by_bic_is_its_maximum_with_zero() {
    assert_eq!(clamped_at_zero(13, 0, 20), Ok(()));
    assert!(
        clamped_at_zero(12, 0, 20).is_err(),
        "x = 20 clamps to 12, one past the end"
    );
    assert!(
        clamped_at_zero(1, 9, 9).is_err(),
        "x = 9 clamps to 1, past a one-byte region"
    );
}

fn signed_entry(op: &str, bound: i64) -> IndexedFact {
    IndexedFact::elements(
        format!("cdf[n] {op} {bound}"),
        abstract_of("n"),
        generate_expression("+", abstract_of("n"), AbstractExpression::Immediate(1)),
        2,
        true,
    )
    .bounded(op, AbstractExpression::Immediate(bound))
}

fn reading_signed_cdf(body: &[&str], facts: Vec<IndexedFact>) -> Result<(), String> {
    let mut lines = vec!["start:"];
    lines.extend_from_slice(body);
    lines.push("ret");
    let program: Vec<String> = lines.iter().map(|s| s.to_string()).collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    buffer(&mut engine, 0, "cdf", 32);
    engine.add_abstract_from(1, "n");
    buffer(&mut engine, 3, "data", 33);
    for fact in between("n", 0, 15) {
        engine.add_invariant(fact);
    }
    for fact in facts {
        engine.add_indexed_fact("cdf", fact)?;
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_signed_entry_is_read_as_the_bits_the_load_extends() {
    let zero_extended = ["ldrh w4,[x0,x1,lsl #1]", "ldrb w5,[x3,x4]"];
    assert!(
        reading_signed_cdf(&zero_extended, vec![signed_entry("==", -1)]).is_err(),
        "an i16 entry of -1 read by ldrh is 65535, not -1"
    );
    assert_eq!(
        reading_signed_cdf(
            &["ldrsh x4,[x0,x1,lsl #1]", "add x6,x3,#1", "ldrb w5,[x6,x4]"],
            vec![signed_entry("==", -1)]
        ),
        Ok(())
    );
    assert!(
        reading_signed_cdf(&zero_extended, vec![signed_entry("<=", 32)]).is_err(),
        "an i16 entry bounded only above may be negative, which ldrh makes large"
    );
    assert_eq!(
        reading_signed_cdf(
            &zero_extended,
            vec![signed_entry(">=", 0), signed_entry("<=", 32)]
        ),
        Ok(()),
        "two facts about one entry hold together"
    );
}

#[test]
fn an_entry_fact_the_assembly_never_reads_is_reported() {
    let result = reading_cdf(
        &["ldrh w4,[x0,#30]"],
        at_one_entry("n"),
        &[AbstractComparison::new(
            "<=",
            abstract_of("n"),
            AbstractExpression::Immediate(14),
        )],
    );
    assert!(result.is_err_and(|e| e.contains("never read")));
}

fn through_rows(body: &[&str], writable: bool) -> Result<(), String> {
    let mut lines = vec!["start:"];
    lines.extend_from_slice(body);
    lines.push("ret");
    run_with(&lines, |e| {
        e.add_abstract_from(0, "rr");
        e.add_region(RegionType::READ, "rr", AbstractExpression::Immediate(16));
        let kind = if writable {
            RegionType::RW
        } else {
            RegionType::READ
        };
        e.add_region(kind, "rr_row", AbstractExpression::Immediate(12));
        e.add_pointer_elements("rr", "rr_row");
        buffer(e, 1, "data", 16);
        e.add_abstract_from(2, "row");
        for (op, bound) in [(">=", 0), ("<=", 1)] {
            e.add_invariant(AbstractComparison::new(
                op,
                abstract_of("row"),
                AbstractExpression::Immediate(bound),
            ));
        }
    })
}

#[test]
fn a_row_behind_a_pointer_array_is_written_only_within_its_length() {
    assert_eq!(
        through_rows(&["ldr x4,[x0,x2,lsl #3]", "strb w3,[x4,#11]"], true),
        Ok(())
    );
    assert!(
        through_rows(&["ldr x4,[x0,x2,lsl #3]", "strb w3,[x4,#11]"], false).is_err(),
        "a write through a read-only row"
    );
    assert!(
        through_rows(&["ldr x4,[x0,x2,lsl #3]", "strb w3,[x4,#12]"], true).is_err(),
        "a write past the end of a writable row"
    );
    assert!(
        through_rows(
            &["add x5,x2,#1", "ldr x4,[x0,x5,lsl #3]", "strb w3,[x4]"],
            true
        )
        .is_err(),
        "a row index that may equal the row count"
    );
}

#[test]
fn two_rows_of_a_pointer_array_may_be_different_rows() {
    for writable in [false, true] {
        let compared = through_rows(
            &[
                "ldr x4,[x0]",
                "ldr x5,[x0,#8]",
                "cmp x4,x5",
                "b.ne apart",
                "ret",
                "apart:",
                "ldrb w6,[x1,#16]",
            ],
            writable,
        );
        assert!(
            compared.is_err(),
            "rows 0 and 1 were assumed to be the same row, so the unequal arm was never checked"
        );
    }
}

#[test]
fn rows_behind_a_pointer_array_are_not_one_row() {
    assert!(
        through_rows(
            &[
                "ldr x4,[x0]",
                "ldr x5,[x0,#8]",
                "strb wzr,[x4]",
                "ldrb w6,[x5]",
                "ldrb w7,[x1,x6]",
            ],
            true
        )
        .is_err(),
        "a byte written to the first row was read back from the second"
    );
    assert!(
        through_rows(
            &[
                "ldr x4,[x0]",
                "ldr x5,[x0,#8]",
                "ldrb w6,[x4]",
                "ldrb w7,[x5]",
                "sub w8,w6,w7",
                "ldrb w9,[x1,x8]",
            ],
            false
        )
        .is_err(),
        "two rows were assumed to hold the same byte"
    );
}

#[test]
fn an_unknown_word_shifted_into_an_eor_is_not_narrowed_to_its_partner() {
    let r = run(
        &[
            "start:",
            "ld1 {v6.16b}, [x0]",
            "aese v6.16b, v6.16b",
            "fmov x9, d6",
            "mov x11, #7",
            "eor x9, x11, x9, lsl #1",
            "ldrb w3, [x0, x9]",
            "ret",
        ],
        Some(16),
        &[],
    );
    assert!(
        r.is_err(),
        "accepted a read indexed by a doubled unknown word"
    );
}

fn blocks_until_a_nonzero_word(limit: &str) -> Vec<String> {
    [
        "start:",
        "mov w8, #8",
        "loop:",
        "ldr q0, [x0]",
        "fmov x9, d0",
        "cbnz x9, out",
        "mov x9, v0.d[1]",
        "cbnz x9, out",
        "sub w9, w8, #8",
        "add w8, w8, #16",
        "add x0, x0, #16",
        limit,
        "b.lo loop",
        "ret",
        "out:",
        "rbit x9, x9",
        "clz x9, x9",
        "ret",
    ]
    .into_iter()
    .map(String::from)
    .collect()
}

#[test]
fn a_block_scan_that_exits_on_data_or_its_count_stays_in_the_buffer() {
    let program = blocks_until_a_nonzero_word("cmp w9, #0x30");
    let program: Vec<&str> = program.iter().map(String::as_str).collect();
    assert_eq!(run(&program, Some(64), &[]), Ok(()));
}

#[test]
fn a_block_scan_whose_count_runs_one_block_past_the_buffer_is_rejected() {
    let program = blocks_until_a_nonzero_word("cmp w9, #0x40");
    let program: Vec<&str> = program.iter().map(String::as_str).collect();
    assert!(
        run(&program, Some(64), &[]).is_err(),
        "accepted a fifth 16-byte read of a 64-byte buffer"
    );
}

#[test]
fn a_block_scan_bounded_only_by_its_data_is_rejected() {
    let r = run(
        &[
            "start:",
            "loop:",
            "ldr q0, [x0]",
            "add x0, x0, #16",
            "fmov x9, d0",
            "cbz x9, loop",
            "ret",
        ],
        Some(64),
        &[],
    );
    assert!(
        r.is_err(),
        "accepted a scan that only data in the buffer can stop"
    );
}

fn indexed_by_leading_zeros_of_an_unknown(scale: &str) -> Vec<String> {
    [
        "start:",
        "ld1 {v6.16b}, [x0]",
        "aese v6.16b, v6.16b",
        "fmov x9, d6",
        "clz x9, x9",
        scale,
        "ldrb w3, [x0, x9]",
        "ret",
    ]
    .into_iter()
    .map(String::from)
    .collect()
}

#[test]
fn leading_zeros_of_an_unknown_word_count_at_most_its_width() {
    let program = indexed_by_leading_zeros_of_an_unknown("lsr x9, x9, #3");
    let program: Vec<&str> = program.iter().map(String::as_str).collect();
    assert_eq!(run(&program, Some(64), &[]), Ok(()));
    let program = indexed_by_leading_zeros_of_an_unknown("mov x9, x9");
    let program: Vec<&str> = program.iter().map(String::as_str).collect();
    assert!(
        run(&program, Some(64), &[]).is_err(),
        "accepted an index of up to 64 into a 64-byte buffer"
    );
}

fn bytes_from_the_end(read: &[&str]) -> Vec<String> {
    let mut program: Vec<String> = ["start:", "cbz x1, done", "sub x4, x1, #1", "loop:"]
        .into_iter()
        .map(String::from)
        .collect();
    program.extend(read.iter().map(|l| l.to_string()));
    program.extend(
        ["subs x4, x4, #1", "b.ge loop", "done:", "ret"]
            .into_iter()
            .map(String::from),
    );
    program
}

#[test]
fn a_countdown_that_leaves_at_minus_one_reads_every_byte_in_bounds() {
    let program = bytes_from_the_end(&["ldrb w5, [x0, x4]"]);
    let program: Vec<&str> = program.iter().map(String::as_str).collect();
    assert_eq!(run(&program, None, &[]), Ok(()));
}

#[test]
fn a_countdown_that_leaves_at_minus_one_reading_one_ahead_is_rejected() {
    let program = bytes_from_the_end(&["add x6, x4, #1", "ldrb w5, [x0, x6]"]);
    let program: Vec<&str> = program.iter().map(String::as_str).collect();
    assert!(
        run(&program, None, &[]).is_err(),
        "accepted a read one past the end on the first iteration"
    );
}
