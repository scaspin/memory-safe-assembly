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
        "leaq K(%rip),%r10",
        "L$loop:",
        "movl (%r10),%eax",
        "leaq 4(%r10),%r10",
        "cmpb $0,3(%r10)",
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

fn call_through_stored_address(callee_offset: i64, after_call_offset: i64) -> Vec<String> {
    vec![
        "start:".to_string(),
        "pushq %rax".into(),
        "movq $transform, (%rsp)".into(),
        "movq %rsp, %r8".into(),
        "callq *(%r8)".into(),
        format!("movb %cl, {after_call_offset}(%rdi)"),
        "popq %rax".into(),
        "retq".into(),
        "transform:".into(),
        format!("movb %cl, {callee_offset}(%rdi)"),
        "retq".into(),
    ]
}

fn check_lines(program: Vec<String>) -> Result<(), String> {
    let program: Vec<&str> = program.iter().map(String::as_str).collect();
    check(&program, &len_is_blocks_of(16))
}

#[test]
fn a_call_through_a_stored_symbol_address_runs_the_callee() {
    let result = check_lines(call_through_stored_address(0, 15));
    assert!(result.is_ok(), "{result:?}");
}

#[test]
fn a_bad_write_in_a_callee_reached_through_a_stored_address_is_caught() {
    let result = check_lines(call_through_stored_address(16, 0));
    assert!(result.is_err(), "{result:?}");
}

#[test]
fn a_bad_write_after_an_indirect_call_returns_is_caught() {
    let result = check_lines(call_through_stored_address(0, 16));
    assert!(result.is_err(), "{result:?}");
}

#[test]
fn a_call_through_a_loaded_unknown_pointer_is_refused() {
    let result = check(&["start:", "callq *(%rsi)", "retq"], &len_is_blocks_of(16));
    assert!(result.is_err(), "{result:?}");
}

#[test]
fn a_jump_through_a_register_holding_a_symbol_address_is_followed() {
    let program = |offset: i64| {
        vec![
            "start:".to_string(),
            "movq $target, %rax".into(),
            "jmpq *%rax".into(),
            "target:".into(),
            format!("movb %cl, {offset}(%rdi)"),
            "retq".into(),
        ]
    };
    assert!(check_lines(program(15)).is_ok());
    assert!(check_lines(program(16)).is_err());
}

fn read_through_symbol_immediate(load_address: &str, read: &str) -> Result<(), String> {
    check(
        &[
            "start:",
            load_address,
            read,
            "retq",
            "\t.section\t.rodata",
            "table:",
            ".long 0x01020304,0x05060708,0x090a0b0c,0x00010203",
        ],
        &[],
    )
}

#[test]
fn a_32_bit_symbol_immediate_holds_the_whole_address() {
    assert!(read_through_symbol_immediate("movl $table, %esi", "movl 12(%rsi), %eax").is_ok());
    assert!(read_through_symbol_immediate("movl $table, %esi", "movl 13(%rsi), %eax").is_err());
}

#[test]
fn a_symbol_immediate_carries_its_offset() {
    assert!(read_through_symbol_immediate("movq $table+8, %rax", "movq (%rax), %rcx").is_ok());
    assert!(read_through_symbol_immediate("movq $table+9, %rax", "movq (%rax), %rcx").is_err());
    assert!(read_through_symbol_immediate("movq $table-4, %rax", "movl 4(%rax), %ecx").is_ok());
    assert!(read_through_symbol_immediate("movq $table-4, %rax", "movl (%rax), %ecx").is_err());
}

fn write_through_low_byte_over_unknown_bits(
    low_byte: i64,
    steps_down: usize,
) -> Result<(), String> {
    let set_low_byte = format!("movb ${low_byte}, %al");
    let mut program = vec!["start:", "movq (%rsi), %rax", set_low_byte.as_str()];
    program.extend(std::iter::repeat_n("decb %al", steps_down));
    program.extend(["movzbl %al, %ecx", "movb %dl, (%rdi,%rcx)", "retq"]);
    check(&program, &len_is_blocks_of(16))
}

#[test]
fn a_byte_written_over_unknown_upper_bits_is_known() {
    assert!(write_through_low_byte_over_unknown_bits(15, 0).is_ok());
    assert!(write_through_low_byte_over_unknown_bits(16, 0).is_err());
    assert!(write_through_low_byte_over_unknown_bits(17, 2).is_ok());
    assert!(write_through_low_byte_over_unknown_bits(18, 2).is_err());
}

#[test]
fn a_byte_countdown_over_unknown_upper_bits_runs_its_exact_trips() {
    let program = [
        "start:",
        "movq (%rsi), %rax",
        "movb $0x7, %al",
        "movq %rdi, %r8",
        "L_round:",
        "movb %dl, (%r8)",
        "incq %r8",
        "decb %al",
        "jne L_round",
        "movb %dl, 8(%rdi)",
        "retq",
    ];
    assert!(check(&program, &len_is_blocks_of(16)).is_ok());
    let overrun = program.map(|line| {
        if line == "movb $0x7, %al" {
            "movb $0x11, %al"
        } else {
            line
        }
    });
    assert!(check(&overrun, &len_is_blocks_of(16)).is_err());
}

fn index_reloaded_from_a_spilled_vector(scale: i64, reloaded_lane: i64) -> Result<(), String> {
    let reload = format!("movl {}(%rsp), %eax", 0x10 + 4 * reloaded_lane);
    let store = format!("movb %dl, (%rdi,%rax,{scale})");
    let program = [
        "start:",
        "subq $0x40, %rsp",
        "movzbl (%rsi), %r9d",
        "andl $1, %r9d",
        "negl %r9d",
        "movd %r9d, %xmm0",
        "pshufd $0x0, %xmm0, %xmm0",
        "movdqu %xmm0, 0x10(%rsp)",
        reload.as_str(),
        "negl %eax",
        store.as_str(),
        "addq $0x40, %rsp",
        "retq",
    ];
    check(&program, &len_is_blocks_of(16))
}

#[test]
fn a_scalar_reload_of_a_spilled_vector_keeps_its_low_lane() {
    assert!(index_reloaded_from_a_spilled_vector(8, 0).is_ok());
    assert!(index_reloaded_from_a_spilled_vector(16, 0).is_err());
}

#[test]
fn a_scalar_reload_past_the_low_quadword_of_a_spilled_vector_is_unknown() {
    assert!(index_reloaded_from_a_spilled_vector(8, 2).is_err());
}
