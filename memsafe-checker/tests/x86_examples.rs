use bums::common::*;
use bums::engine::AnyEngine;
use bums::machine::Isa;
use bums::x86::engine::ExecutionEngine;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn lines(program: &[&str]) -> Vec<String> {
    program.iter().map(|s| s.to_string()).collect()
}

fn check(program: &[&str], invariants: &[AbstractComparison]) -> Result<(), String> {
    init();
    let mut engine = ExecutionEngine::new(lines(program));
    engine.add_abstract_from(0, "out");
    engine.add_region(RegionType::WRITE, "out", AbstractExpression::Immediate(16));
    engine.add_abstract_from(1, "in");
    engine.add_region(RegionType::READ, "in", abstract_of("len"));
    engine.add_abstract_from(2, "len");
    for i in invariants {
        engine.add_invariant(i.clone());
    }
    engine.start("start").map_err(|e| e.to_string())
}

fn len_is_blocks_of(n: i64) -> Vec<AbstractComparison> {
    vec![
        AbstractComparison::new(">=", abstract_of("len"), AbstractExpression::Immediate(n)),
        AbstractComparison::new(
            "==",
            generate_expression("%", abstract_of("len"), AbstractExpression::Immediate(n)),
            AbstractExpression::Immediate(0),
        ),
    ]
}

#[test]
fn att_assembly_is_detected_as_x86() {
    let program = lines(&["start:", "movq (%rsi),%rax", "ret"]);
    assert_eq!(Isa::detect(&program), Isa::X86_64);
    assert_eq!(AnyEngine::new(program).isa(), Isa::X86_64);
}

#[test]
fn hand_encoded_return_ends_the_function() {
    let program = [
        "start:",
        "movq (%rsi),%rax",
        ".byte 0xf3,0xc3",
        "movq 4096(%rsi),%rax",
    ];
    assert_eq!(
        check(
            &program,
            &[AbstractComparison::new(
                ">=",
                abstract_of("len"),
                AbstractExpression::Immediate(8)
            )]
        ),
        Ok(())
    );
}

#[test]
fn pointer_parked_in_xmm_with_encoded_movq_is_followed() {
    let program = [
        "start:",
        "movq %rdi,%rdi",
        ".byte 102,72,15,110,199",
        "xorl %edi,%edi",
        ".byte 102,72,15,126,199",
        "movq %rax,8(%rdi)",
        "ret",
    ];
    assert_eq!(check(&program, &[]), Ok(()));
}

#[test]
fn unknown_encoding_in_code_is_rejected() {
    let program = [
        "start:",
        "movq %rdi,%rax",
        ".byte 0xc5,0xfd,0x6f,0x06",
        "ret",
    ];
    let err = check(&program, &[]).unwrap_err();
    assert!(err.contains("hand-encoded"), "{err}");
}

#[test]
fn overwriting_the_return_address_is_rejected() {
    let program = [
        "start:",
        "subq $8,%rsp",
        "movq %rdx,8(%rsp)",
        "addq $8,%rsp",
        "ret",
    ];
    let err = check(&program, &[]).unwrap_err();
    assert!(err.contains("return address"), "{err}");
}

#[test]
fn loop_tested_by_a_conditional_move_is_summarized() {
    let program = [
        "start:",
        "shrq $4,%rdx",
        "movdqu (%rsi),%xmm0",
        "L$loop:",
        "decq %rdx",
        "leaq 16(%rsi),%r8",
        "cmovneq %r8,%rsi",
        "pxor %xmm1,%xmm0",
        "movdqu (%rsi),%xmm1",
        "jnz L$loop",
        "movdqu %xmm0,(%rdi)",
        "ret",
    ];
    assert_eq!(check(&program, &len_is_blocks_of(16)), Ok(()));
}

#[test]
fn loop_without_the_clamp_reads_past_the_end() {
    let program = [
        "start:",
        "shrq $4,%rdx",
        "movdqu (%rsi),%xmm0",
        "L$loop:",
        "decq %rdx",
        "leaq 16(%rsi),%rsi",
        "pxor %xmm1,%xmm0",
        "movdqu (%rsi),%xmm1",
        "jnz L$loop",
        "movdqu %xmm0,(%rdi)",
        "ret",
    ];
    assert!(check(&program, &len_is_blocks_of(16)).is_err());
}

#[test]
fn table_walk_ending_on_a_sentinel_byte_is_bounded_by_the_table() {
    let program = [
        "start:",
        "leaq K(%rip),%rbp",
        "L$loop:",
        "movl (%rbp),%eax",
        "leaq 4(%rbp),%rbp",
        "cmpb $0,3(%rbp)",
        "jne L$loop",
        "ret",
        ".p2align 4",
        "K:",
        ".long 0x01020304,0x05060708,0x090a0b0c,0x00010203",
    ];
    assert_eq!(check(&program, &[]), Ok(()));
}

#[test]
fn scalar_sse_reads_one_element() {
    let len_is = |n: i64| {
        vec![AbstractComparison::new(
            "==",
            abstract_of("len"),
            AbstractExpression::Immediate(n),
        )]
    };
    assert!(check(&["start:", "mulsd 8(%rsi), %xmm0", "retq"], &len_is(16)).is_ok());
    assert!(check(&["start:", "mulsd 8(%rsi), %xmm0", "retq"], &len_is(15)).is_err());
    assert!(check(&["start:", "addss 12(%rsi), %xmm0", "retq"], &len_is(16)).is_ok());
    assert!(check(&["start:", "mulpd 8(%rsi), %xmm0", "retq"], &len_is(16)).is_err());
    assert!(check(&["start:", "pminsd (%rsi), %xmm0", "retq"], &len_is(8)).is_err());
}

#[test]
fn x87_memory_operands_are_checked() {
    let len_is = |n: i64| {
        vec![AbstractComparison::new(
            "==",
            abstract_of("len"),
            AbstractExpression::Immediate(n),
        )]
    };
    let load = [
        "start:",
        "fldz",
        "fldl 8(%rsi)",
        "faddp %st, %st(1)",
        "fsqrt",
        "retq",
    ];
    assert!(check(&load, &len_is(16)).is_ok());
    assert!(check(&load, &len_is(15)).is_err());
    let store = ["start:", "fldz", "fstpl 8(%rdi)", "retq"];
    assert!(check(&store, &[]).is_ok());
    let past = ["start:", "fldz", "fstpt 8(%rdi)", "retq"];
    assert!(check(&past, &[]).is_err());
}

fn masked_tail(extra: &str) -> Vec<&str> {
    vec![
        "start:",
        "movq %rdx,%rcx",
        extra,
        "movq $1,%rax",
        "shlq %cl,%rax",
        "decq %rax",
        "kmovq %rax,%k1",
        "vmovdqu8 (%rsi),%xmm1{%k1}{z}",
        "vmovdqu8 %xmm1,(%rdi){%k1}",
        "ret",
    ]
}

fn short_input() -> Vec<AbstractComparison> {
    vec![
        AbstractComparison::new(">=", abstract_of("len"), AbstractExpression::Immediate(0)),
        AbstractComparison::new("<", abstract_of("len"), AbstractExpression::Immediate(16)),
    ]
}

#[test]
fn a_load_masked_to_the_bytes_left_stays_in_bounds() {
    assert_eq!(check(&masked_tail("nop"), &short_input()), Ok(()));
}

#[test]
fn a_mask_one_byte_too_wide_is_caught() {
    let err = check(&masked_tail("incq %rcx"), &short_input()).expect_err("one byte past in");
    assert!(err.contains("not provably within region"), "{err}");
}

#[test]
fn an_unmasked_load_of_a_short_input_is_caught() {
    let program = ["start:", "vmovdqu8 (%rsi),%xmm1", "ret"];
    let err = check(&program, &short_input()).expect_err("16 bytes of a shorter input");
    assert!(err.contains("not provably within region"), "{err}");
}

#[test]
fn a_mask_of_unknown_value_is_checked_at_full_width() {
    let program = [
        "start:",
        "kmovq (%rsi),%k1",
        "vmovdqu8 (%rsi),%xmm1{%k1}{z}",
        "ret",
    ];
    let mut bounds = short_input();
    bounds.push(AbstractComparison::new(
        ">=",
        abstract_of("len"),
        AbstractExpression::Immediate(8),
    ));
    let err = check(&program, &bounds).expect_err("the mask may enable every byte");
    assert!(err.contains("not provably within region"), "{err}");
}

#[test]
fn a_byte_written_into_a_pointer_register_reads_back_as_written() {
    let program = [
        "start:",
        "movq %rdi,%rcx",
        "movb %dl,%cl",
        "movq $1,%rax",
        "shlq %cl,%rax",
        "decq %rax",
        "kmovq %rax,%k1",
        "vmovdqu8 (%rsi),%xmm1{%k1}{z}",
        "ret",
    ];
    assert_eq!(check(&program, &short_input()), Ok(()));
}

#[test]
fn a_masked_store_through_rdi_is_checked() {
    let blocks = len_is_blocks_of(16);
    assert_eq!(
        check(&["start:", "maskmovdqu %xmm1,%xmm0", "ret"], &blocks),
        Ok(())
    );
    let past_the_end = check(
        &["start:", "addq $8,%rdi", "maskmovdqu %xmm1,%xmm0", "ret"],
        &blocks,
    );
    assert!(past_the_end.is_err(), "{past_the_end:?}");
    let read_only = check(
        &["start:", "movq %rsi,%rdi", "maskmovdqu %xmm1,%xmm0", "ret"],
        &blocks,
    );
    assert!(read_only.is_err(), "{read_only:?}");
}

#[test]
fn a_string_compare_leaves_its_index_in_rcx_unknown() {
    let result = check(
        &[
            "start:",
            "xorl %ecx,%ecx",
            "pcmpistri $8,(%rsi),%xmm0",
            "movb (%rdi,%rcx),%al",
            "ret",
        ],
        &len_is_blocks_of(16),
    );
    assert!(result.is_err(), "{result:?}");
}

#[test]
fn a_gather_through_a_vector_index_is_refused() {
    let result = check(
        &["start:", "vpgatherdd %ymm2,(%rsi,%ymm1,4),%ymm0", "ret"],
        &len_is_blocks_of(16),
    );
    assert!(result.is_err(), "{result:?}");
}

#[test]
fn bytes_that_do_not_decode_at_the_start_of_a_block_are_refused() {
    let result = check(
        &["start:", ".byte 0x0f,0x0b", "movq (%rsi),%rax", "ret"],
        &len_is_blocks_of(16),
    );
    assert!(result.is_err(), "{result:?}");
}
