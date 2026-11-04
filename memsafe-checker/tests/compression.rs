use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn imm(v: i64) -> AbstractExpression {
    AbstractExpression::Immediate(v)
}

fn fact(op: &str, l: AbstractExpression, r: AbstractExpression) -> AbstractComparison {
    AbstractComparison::new(op, l, r)
}

fn writable_rows(program: &str) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "rows");
    engine.add_region(RegionType::READ, "rows", imm(16));
    engine.add_abstract_from(2, "len");
    engine.add_region(RegionType::RW, "rows_row", abstract_of("len"));
    engine.add_pointer_elements("rows", "rows_row");
    engine.add_invariant(fact(">=", abstract_of("len"), imm(8)));
    engine.add_invariant(fact("<=", abstract_of("len"), imm(1 << 20)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_write_inside_a_writable_row_is_accepted() {
    let program = "start:
        ldr x3, [x0, #8]
        sub x4, x2, #1
        strb w1, [x3, x4]
        ret";
    assert_eq!(writable_rows(program), Ok(()));
}

#[test]
fn a_write_past_a_writable_row_is_caught() {
    let program = "start:
        ldr x3, [x0, #8]
        strb w1, [x3, x2]
        ret";
    assert!(writable_rows(program).is_err());
}

#[test]
fn a_value_written_to_one_row_is_not_read_back_from_another() {
    let program = "start:
        ldr x3, [x0]
        ldr x4, [x0, #8]
        str x0, [x3]
        ldr x5, [x4]
        ldr x6, [x5]
        ret";
    assert!(
        writable_rows(program).is_err(),
        "a pointer stored in row 0 came back from row 1"
    );
}

fn table_of(length: i64, program: &str) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "table");
    engine.add_region(
        RegionType::READ,
        "table",
        generate_expression("+", abstract_of("mask"), imm(length)),
    );
    engine.add_abstract_from(1, "mask");
    engine.add_invariant(fact(">=", abstract_of("mask"), imm(0)));
    engine.add_invariant(fact("<=", abstract_of("mask"), imm(65535)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_register_mask_bounds_an_unknown_index() {
    let program = "start:
        crc32cw w2, w2, w3
        and w2, w2, w1
        ldrb w4, [x0, x2]
        ret";
    assert_eq!(table_of(1, program), Ok(()));
}

#[test]
fn a_register_mask_one_past_the_table_is_caught() {
    let program = "start:
        crc32cw w2, w2, w3
        and w2, w2, w1
        ldrb w4, [x0, x2]
        ret";
    assert!(table_of(0, program).is_err());
}

fn byte_table(length: i64, program: &str) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "table");
    engine.add_region(RegionType::READ, "table", imm(length));
    engine.add_abstract_from(1, "input");
    engine.add_region(RegionType::READ, "input", imm(1));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn an_eor_of_two_bytes_stays_a_byte() {
    let program = "start:
        ldrb w3, [x1]
        uxth w2, w2
        eor w4, w3, w2, lsr #8
        ldrb w5, [x0, w4, uxtw]
        ret";
    assert_eq!(byte_table(256, program), Ok(()));
}

#[test]
fn an_eor_of_two_bytes_can_reach_255() {
    let program = "start:
        ldrb w3, [x1]
        uxth w2, w2
        eor w4, w3, w2, lsr #8
        ldrb w5, [x0, w4, uxtw]
        ret";
    assert!(byte_table(255, program).is_err());
}

#[test]
fn an_eor_with_a_wider_operand_is_not_a_byte() {
    let program = "start:
        ldrb w3, [x1]
        uxth w2, w2
        eor w4, w3, w2, lsr #7
        ldrb w5, [x0, w4, uxtw]
        ret";
    assert!(byte_table(256, program).is_err());
}

fn anchored_table(offset: i64) -> Result<(), String> {
    init();
    let load = format!("ldr w0, [x6, #{offset}]");
    let program = [
        "start:",
        "adrp x7, tbl",
        "add x6, x7, :lo12:tbl",
        load.as_str(),
        "ret",
        "\t.section .rodata",
        "tbl:",
        "\t.size tbl, 16",
        "\t.word 1, 2, 3, 4",
    ];
    let engine = bums::engine::ExecutionEngine::new(program.iter().map(|s| s.to_string()));
    let mut engine = engine;
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_lo12_add_into_another_register_carries_the_address() {
    assert_eq!(anchored_table(12), Ok(()));
}

#[test]
fn a_lo12_add_into_another_register_keeps_the_table_bound() {
    assert!(anchored_table(16).is_err());
}

fn x86_input(length: i64, program: &[&str]) -> Result<(), String> {
    init();
    let mut engine = bums::x86::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(1, "in");
    engine.add_region(RegionType::READ, "in", imm(length));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn x86_shift_right_bounds_an_unknown() {
    let program = [
        "start:",
        "movq (%rsi), %rax",
        "shrq $56, %rax",
        "movb (%rsi,%rax), %cl",
        "ret",
    ];
    assert_eq!(x86_input(256, &program), Ok(()));
    assert!(x86_input(255, &program).is_err());
}

#[test]
fn x86_bmi2_shift_right_bounds_an_unknown() {
    let program = [
        "start:",
        "movq (%rsi), %rax",
        "movq $0x38, %rdx",
        "shrxq %rdx, %rax, %rax",
        "movb (%rsi,%rax), %cl",
        "ret",
    ];
    assert_eq!(x86_input(256, &program), Ok(()));
    assert!(x86_input(255, &program).is_err());
}

#[test]
fn x86_and_with_an_immediate_bounds_an_unknown() {
    let program = [
        "start:",
        "movq (%rsi), %rax",
        "andl $0xff, %eax",
        "movb (%rsi,%rax), %cl",
        "ret",
    ];
    assert_eq!(x86_input(256, &program), Ok(()));
    assert!(x86_input(255, &program).is_err());
}

#[test]
fn x86_zero_extended_byte_load_is_a_byte() {
    let program = [
        "start:",
        "movzbl (%rsi), %eax",
        "movb (%rsi,%rax), %cl",
        "ret",
    ];
    assert_eq!(x86_input(256, &program), Ok(()));
    assert!(x86_input(255, &program).is_err());
}

#[test]
fn x86_bit_scan_into_its_own_register_is_below_64() {
    let program = [
        "start:",
        "movq (%rsi), %rax",
        "bsfq %rax, %rax",
        "movb (%rsi,%rax), %cl",
        "ret",
    ];
    assert_eq!(x86_input(64, &program), Ok(()));
    assert!(x86_input(63, &program).is_err());
}

#[test]
fn x86_bit_scan_into_another_register_is_unknown() {
    let program = [
        "start:",
        "movq (%rsi), %rax",
        "bsfq %rax, %rbx",
        "movb (%rsi,%rbx), %cl",
        "ret",
    ];
    assert!(x86_input(1 << 20, &program).is_err());
}

#[test]
fn x86_crc32_is_a_32_bit_value() {
    let program = [
        "start:",
        "movq (%rsi), %rax",
        "crc32q %rax, %rbx",
        "shrl $24, %ebx",
        "movb (%rsi,%rbx), %cl",
        "ret",
    ];
    assert_eq!(x86_input(256, &program), Ok(()));
    assert!(x86_input(255, &program).is_err());
}

fn x86_division(program: &[&str]) -> Result<(), String> {
    init();
    let mut engine = bums::x86::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(1, "in");
    engine.add_region(RegionType::READ, "in", abstract_of("len"));
    engine.add_abstract_from(2, "len");
    engine.add_invariant(fact(">=", abstract_of("len"), imm(5)));
    engine.add_invariant(fact("<=", abstract_of("len"), imm(1 << 40)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn x86_multiply_high_by_a_magic_constant_divides() {
    let program = [
        "start:",
        "movq %rdx, %rax",
        "movabsq $-0x3333333333333333, %rdx",
        "mulq %rdx",
        "shrq $0x2, %rdx",
        "leaq (%rdx,%rdx,4), %rcx",
        "movb -0x1(%rsi,%rcx), %al",
        "ret",
    ];
    assert_eq!(x86_division(&program), Ok(()));
}

#[test]
fn x86_multiply_high_quotient_times_divisor_can_reach_the_end() {
    let program = [
        "start:",
        "movq %rdx, %rax",
        "movabsq $-0x3333333333333333, %rdx",
        "mulq %rdx",
        "shrq $0x2, %rdx",
        "leaq (%rdx,%rdx,4), %rcx",
        "movb (%rsi,%rcx), %al",
        "ret",
    ];
    assert!(x86_division(&program).is_err());
}

fn x86_rows(program: &[&str]) -> Result<(), String> {
    init();
    let mut engine = bums::x86::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(0, "rows");
    engine.add_region(RegionType::READ, "rows", imm(16));
    engine.add_abstract_from(1, "len");
    engine.add_region(RegionType::RW, "rows_row", abstract_of("len"));
    engine.add_pointer_elements("rows", "rows_row");
    engine.add_invariant(fact(">=", abstract_of("len"), imm(8)));
    engine.add_invariant(fact("<=", abstract_of("len"), imm(1 << 20)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn x86_a_row_loaded_from_a_pointer_array_bounds_its_writes() {
    let program = [
        "start:",
        "movq 0x8(%rdi), %rax",
        "movb %cl, -0x1(%rax,%rsi)",
        "ret",
    ];
    assert_eq!(x86_rows(&program), Ok(()));
}

#[test]
fn x86_a_write_past_a_row_is_caught() {
    let program = [
        "start:",
        "movq 0x8(%rdi), %rax",
        "movb %cl, (%rax,%rsi)",
        "ret",
    ];
    assert!(x86_rows(&program).is_err());
}

#[test]
fn x86_a_misaligned_pointer_array_load_is_not_a_row() {
    let program = ["start:", "movq 0x4(%rdi), %rax", "movb %cl, (%rax)", "ret"];
    assert!(x86_rows(&program).is_err());
}

#[test]
fn x86_a_value_written_to_one_row_is_not_read_back_from_another() {
    let program = [
        "start:",
        "movq (%rdi), %rax",
        "movq 0x8(%rdi), %rbx",
        "movq %rdi, (%rax)",
        "movq (%rbx), %rcx",
        "movb (%rcx), %dl",
        "ret",
    ];
    assert!(x86_rows(&program).is_err());
}

fn x86_masked(table: i64) -> Result<(), String> {
    init();
    let program = [
        "start:",
        "crc32l (%rdi), %eax",
        "andl %esi, %eax",
        "movw %dx, (%rdi,%rax,2)",
        "ret",
    ];
    let mut engine = bums::x86::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(0, "table");
    engine.add_region(
        RegionType::RW,
        "table",
        generate_expression(
            "*",
            generate_expression("+", abstract_of("mask"), imm(table)),
            imm(2),
        ),
    );
    engine.add_abstract_from(1, "mask");
    engine.add_invariant(fact(">=", abstract_of("mask"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("mask"), imm(65535)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn x86_a_register_mask_bounds_an_unknown_index() {
    assert_eq!(x86_masked(1), Ok(()));
}

#[test]
fn x86_a_register_mask_one_past_the_table_is_caught() {
    assert!(x86_masked(0).is_err());
}

fn crc64_table(entries: i64, shift: i64) -> Result<(), String> {
    init();
    let index = format!("eor x7, x7, x0, lsr #{shift}");
    let program = [
        "start:",
        "mvn x0, x0",
        "ldrb w7, [x1]",
        index.as_str(),
        "ldr x7, [x6, x7, lsl #3]",
        "ret",
    ];
    let mut engine = bums::engine::ExecutionEngine::new(program.iter().map(|s| s.to_string()));
    engine.add_abstract_from(1, "input");
    engine.add_region(RegionType::READ, "input", imm(1));
    engine.add_abstract_from(6, "table");
    engine.add_region(RegionType::READ, "table", imm(entries * 8));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn an_eor_with_the_top_byte_of_an_unknown_is_a_byte() {
    assert_eq!(crc64_table(256, 56), Ok(()));
    assert!(crc64_table(255, 56).is_err());
}

#[test]
fn an_eor_with_the_top_nine_bits_of_an_unknown_is_not_a_byte() {
    assert!(crc64_table(256, 55).is_err());
}

fn x86_short_buffer(program: &[&str]) -> Result<(), String> {
    init();
    let mut engine = bums::x86::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(1, "buf");
    engine.add_abstract_from(2, "len");
    let len = || AbstractExpression::Abstract("len".to_string());
    engine.add_region(RegionType::READ, "buf", len());
    engine.add_invariant(fact(">=", len(), imm(0)));
    engine.add_invariant(fact("<=", len(), imm(1 << 31)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn x86_masked_load_of_the_low_len_bytes_stays_in_a_short_buffer() {
    let program = |count: &'static str| {
        [
            "start:",
            "testq %rdx, %rdx",
            "je done",
            "cmpq $0x10, %rdx",
            "jge done",
            "xorq %rax, %rax",
            count,
            "decq %rax",
            "kmovw %eax, %k2",
            "vmovdqu8 (%rsi), %xmm7 {%k2} {z}",
            "done:",
            "ret",
        ]
    };
    assert_eq!(x86_short_buffer(&program("btsq %rdx, %rax")), Ok(()));
    let wider = [
        "start:",
        "testq %rdx, %rdx",
        "je done",
        "cmpq $0x10, %rdx",
        "jge done",
        "xorq %rax, %rax",
        "btsq %rdx, %rax",
        "kmovw %eax, %k2",
        "vmovdqu8 (%rsi), %xmm7 {%k2} {z}",
        "done:",
        "ret",
    ];
    assert!(x86_short_buffer(&wider).is_err());
}

fn bytes_down_to_a_multiple_of_eight(read: &'static str) -> Vec<&'static str> {
    vec![
        "start:",
        "testq %rdx, %rdx",
        "je done",
        "testq $0x7, %rdx",
        "je done",
        "bytes:",
        read,
        "subq $0x1, %rdx",
        "testq $0x7, %rdx",
        "jne bytes",
        "done:",
        "ret",
    ]
}

#[test]
fn x86_byte_loop_down_to_a_multiple_of_eight_stays_in_the_buffer() {
    let program = bytes_down_to_a_multiple_of_eight("movb -0x1(%rsi,%rdx), %al");
    assert_eq!(x86_short_buffer(&program), Ok(()));
    let one_past = bytes_down_to_a_multiple_of_eight("movb (%rsi,%rdx), %al");
    assert!(x86_short_buffer(&one_past).is_err());
}

fn word_offset_walk(tail_end: &str) -> Result<(), String> {
    init();
    let program = format!(
        "start:
        mov w6, #0
        add x4, x0, #0
        add x5, x0, x1
        sub x7, x5, #128
        {tail_end}
        blocks:
        cmp x4, x7
        b.hi tail
        ldr q0, [x0, x6]
        add w6, w6, #128
        add x4, x4, #128
        b blocks
        tail:
        cmp x4, x5
        b.hi done
        ldr q0, [x0, x6]
        add w6, w6, #16
        add x4, x4, #16
        b tail
        done:
        ret"
    );
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    let len = || AbstractExpression::Abstract("len".to_string());
    engine.add_abstract_from(0, "buf");
    engine.add_abstract_from(1, "len");
    engine.add_region(RegionType::READ, "buf", len());
    engine.add_invariant(fact(">=", len(), imm(128)));
    engine.add_invariant(fact("<=", len(), imm(2147483647)));
    engine.add_invariant(fact("==", generate_expression("%", len(), imm(16)), imm(0)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_word_offset_carried_from_a_finished_loop_stays_in_range() {
    assert_eq!(word_offset_walk("sub x5, x5, #16"), Ok(()));
    assert!(word_offset_walk("add x5, x5, #0").is_err());
}

fn rewritten_icf_lookup(rewrite: &str) -> Result<(), String> {
    init();
    let program = format!(
        "start:
        ldr w1, [x0]
        {rewrite}
        str w4, [x0, x6, lsl #2]
        ldr w1, [x0, x7, lsl #2]
        ubfx x2, x1, #10, #9
        ldr w3, [x5, x2, lsl #2]
        ret"
    );
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    let count = || AbstractExpression::Abstract("count".to_string());
    engine.add_abstract_from(0, "icf");
    engine.add_region(
        RegionType::RW,
        "icf",
        generate_expression("*", count(), imm(4)),
    );
    engine.add_abstract_from(5, "dist_start");
    engine.add_region(RegionType::READ, "dist_start", imm(128));
    engine.add_abstract_from(6, "written");
    engine.add_abstract_from(7, "read");
    engine.add_abstract_from(8, "other");
    engine.add_region(RegionType::READ, "other", imm(4));
    for index in ["written", "read"] {
        let index = || AbstractExpression::Abstract(index.to_string());
        engine.add_invariant(fact(">=", index(), imm(0)));
        engine.add_invariant(fact("<", index(), count()));
    }
    engine.add_invariant(fact(">=", count(), imm(1)));
    engine.add_invariant(fact("<=", count(), imm(1 << 20)));
    engine.add_element_field_range("icf", 4, "<=", imm(30), (10, 9));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn icf_fields_survive_writes_that_keep_them_in_range() {
    assert_eq!(rewritten_icf_lookup("and w4, w1, #0xfffffc00"), Ok(()));
    assert_eq!(rewritten_icf_lookup("mov w4, #0x7800"), Ok(()));
    assert!(rewritten_icf_lookup("ldr w4, [x8]").is_err());
    assert!(rewritten_icf_lookup("mov w4, #0x7c00").is_err());
}

#[test]
fn x86_a_broadcast_mask_survives_a_round_trip_through_a_vector() {
    let program = |extract: &'static str| {
        [
            "start:",
            "movl (%rsi), %eax",
            "andl $0x7f, %eax",
            "movd %eax, %xmm3",
            "pshufd $0x0, %xmm3, %xmm3",
            "movdqu (%rsi), %xmm2",
            "pand %xmm3, %xmm2",
            extract,
            "movb (%rsi,%rdx), %cl",
            "ret",
        ]
    };
    for extract in ["movd %xmm2, %edx", "pextrd $0x1, %xmm2, %edx"] {
        assert_eq!(x86_input(128, &program(extract)), Ok(()));
        assert!(x86_input(127, &program(extract)).is_err());
    }
    assert!(x86_input(1 << 20, &program("pextrd $0x2, %xmm2, %edx")).is_err());
}

fn x86_gather(displacement: &'static str, bound: &'static str) -> [&'static str; 13] {
    [
        "start:",
        bound,
        "vmovd %eax, %xmm1",
        "vpbroadcastd %xmm1, %ymm1",
        "movl $0x100, %ecx",
        "vmovd %ecx, %xmm5",
        "vpbroadcastd %xmm5, %ymm5",
        "vmovdqu (%rsi), %ymm2",
        "vpand %ymm1, %ymm2, %ymm2",
        "vpsubd %ymm5, %ymm2, %ymm2",
        displacement,
        "vpcmpeqd %ymm3, %ymm3, %ymm3",
        "vpgatherdd %ymm3, (%rdi,%ymm2,1), %ymm4",
    ]
}

#[test]
fn x86_a_gather_reads_within_the_interval_of_its_index_lanes() {
    let gather = |displacement, bound| {
        let mut program = x86_gather(displacement, bound).to_vec();
        program.push("ret");
        program
    };
    let masked = "movl $0xff, %eax";
    assert_eq!(
        x86_input(259, &gather("leaq 0x100(%rsi), %rdi", masked)),
        Ok(())
    );
    assert!(x86_input(258, &gather("leaq 0x100(%rsi), %rdi", masked)).is_err());
    assert!(x86_input(1 << 20, &gather("leaq 0xff(%rsi), %rdi", masked)).is_err());
    assert!(
        x86_input(
            1 << 20,
            &gather("leaq 0x100(%rsi), %rdi", "movl (%rsi), %eax")
        )
        .is_err()
    );
}

fn x86_writable(length: i64, program: &[&str]) -> Result<(), String> {
    init();
    let mut engine = bums::x86::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(1, "out");
    engine.add_region(RegionType::RW, "out", imm(length));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn x86_a_scatter_writes_within_the_interval_of_its_index_lanes() {
    let program = |mask: &'static str| {
        [
            "start:",
            mask,
            "vmovd %eax, %xmm1",
            "vpbroadcastd %xmm1, %zmm1",
            "vmovdqu64 (%rsi), %zmm2",
            "vpandd %zmm1, %zmm2, %zmm2",
            "kxnorw %k1, %k1, %k1",
            "vpscatterdd %zmm0, (%rsi,%zmm2,4) {%k1}",
            "ret",
        ]
    };
    assert_eq!(x86_writable(256, &program("movl $0x3f, %eax")), Ok(()));
    assert!(x86_writable(255, &program("movl $0x3f, %eax")).is_err());
    assert!(x86_writable(1 << 20, &program("movl (%rsi), %eax")).is_err());
}

#[test]
fn x86_a_mask_test_sets_the_flags_its_branch_reads() {
    let program = [
        "start:",
        "vmovdqu (%rsi), %xmm0",
        "vpcmpeqb (%rsi), %xmm0, %k0",
        "kortestw %k0, %k0",
        "jb done",
        "done:",
        "ret",
    ];
    assert_eq!(x86_input(16, &program), Ok(()));
}

#[test]
fn x86_an_embedded_broadcast_reads_one_element() {
    let program = |load: &'static str| ["start:", load, "ret"];
    assert_eq!(
        x86_input(16, &program("vpxord 12(%rsi){1to4}, %xmm1, %xmm2")),
        Ok(())
    );
    assert!(x86_input(16, &program("vpxord 13(%rsi){1to4}, %xmm1, %xmm2")).is_err());
    assert!(x86_input(16, &program("vpxord 4(%rsi), %xmm1, %xmm2")).is_err());
}

#[test]
fn x86_a_copy_loop_into_the_callers_frame_keeps_its_return_address() {
    let program = [
        "start:",
        "subq $32, %rsp",
        "movzbl (%rsi), %edx",
        "andl $31, %edx",
        "testq %rdx, %rdx",
        "je skip",
        "movq %rsp, %rdi",
        "callq copy",
        "skip:",
        "addq $32, %rsp",
        "ret",
        "copy:",
        "movb $0, (%rdi)",
        "incq %rdi",
        "decq %rdx",
        "jne copy",
        "ret",
    ];
    assert_eq!(x86_input(1, &program), Ok(()));
}

fn arm_flag_counted_walk(region: i64, after: &str) -> Result<(), String> {
    init();
    let program = format!(
        "start:
        mov x10, #-1024
        mov x9, x0
        walk:
        adds x10, x10, #1
        ldr x3, [x9]
        add x9, x9, #8
        b.lo walk
        {after}
        ret"
    );
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("len"));
    engine.add_invariant(fact("==", abstract_of("len"), imm(region)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_long_loop_counted_by_a_carry_flag_is_summarized() {
    assert_eq!(arm_flag_counted_walk(8192, ""), Ok(()));
    assert!(arm_flag_counted_walk(8191, "").is_err());
}

#[test]
fn a_long_loop_counted_by_a_carry_flag_still_reaches_its_exit() {
    assert_eq!(arm_flag_counted_walk(8200, "ldr x4, [x9]"), Ok(()));
    assert!(arm_flag_counted_walk(8192, "ldr x4, [x9]").is_err());
}

fn x86_wrapping_counted_walk(length: i64, after: &'static str) -> Result<(), String> {
    let program = [
        "start:",
        "movl $0xffff0000, %edx",
        "movq %rsi, %rcx",
        "walk:",
        "movq (%rcx), %rax",
        "addq $8, %rcx",
        "addl $0x20, %edx",
        "jne walk",
        after,
        "ret",
    ];
    init();
    let mut engine = bums::x86::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(1, "in");
    engine.add_region(RegionType::READ, "in", abstract_of("len"));
    engine.add_invariant(fact("==", abstract_of("len"), imm(length)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn x86_a_long_loop_counted_to_a_32_bit_wrap_is_summarized() {
    assert_eq!(x86_wrapping_counted_walk(16384, ""), Ok(()));
    assert!(x86_wrapping_counted_walk(16383, "").is_err());
}

#[test]
fn x86_a_long_loop_counted_to_a_32_bit_wrap_still_reaches_its_exit() {
    assert_eq!(
        x86_wrapping_counted_walk(16392, "movq (%rcx), %rax"),
        Ok(())
    );
    assert!(x86_wrapping_counted_walk(16384, "movq (%rcx), %rax").is_err());
}

fn x86_complemented_bits_skip(size: i64) -> Result<(), String> {
    let program = [
        "start:",
        "movl %edi, %edx",
        "notl %edx",
        "testb $0x30, %dl",
        "je done",
        "movq 64(%rsi), %rax",
        "done:",
        "ret",
    ];
    init();
    let mut engine = bums::x86::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(0, "size");
    engine.add_abstract_from(1, "in");
    engine.add_region(RegionType::READ, "in", imm(64));
    engine.add_invariant(fact("==", abstract_of("size"), imm(size)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn x86_a_branch_on_complemented_bits_is_decided() {
    assert_eq!(x86_complemented_bits_skip(0x30), Ok(()));
    assert_eq!(x86_complemented_bits_skip(0x7ff0), Ok(()));
}

#[test]
fn x86_a_branch_on_complemented_bits_still_takes_the_unsafe_side() {
    assert!(x86_complemented_bits_skip(0x20).is_err());
    assert!(x86_complemented_bits_skip(0x7fc0).is_err());
}

fn arm_pinned_count_walk(region: i64, after: &str) -> Result<(), String> {
    init();
    let program = format!(
        "start:
        walk:
        ldr x3, [x0]
        add x0, x0, #8
        subs x2, x2, #1
        b.ne walk
        {after}
        ret"
    );
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "base");
    engine.add_abstract_from(2, "count");
    engine.add_region(RegionType::READ, "base", abstract_of("len"));
    engine.add_invariant(fact("==", abstract_of("len"), imm(region)));
    engine.add_invariant(fact("==", abstract_of("count"), imm(64)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_loop_whose_count_the_solver_pins_is_summarized_before_the_revisit_cap() {
    assert_eq!(arm_pinned_count_walk(512, ""), Ok(()));
    assert!(arm_pinned_count_walk(511, "").is_err());
}

#[test]
fn a_loop_whose_count_the_solver_pins_still_reaches_its_exit() {
    assert_eq!(arm_pinned_count_walk(520, "ldr x4, [x0]"), Ok(()));
    assert!(arm_pinned_count_walk(512, "ldr x4, [x0]").is_err());
}

#[test]
fn x86_a_32_bit_counter_that_steps_over_zero_is_not_summarized_away() {
    let program = [
        "start:",
        "movl $0xffff0000, %edx",
        "movq %rsi, %rcx",
        "walk:",
        "movq (%rcx), %rax",
        "addl $0x30, %edx",
        "jne walk",
        "ret",
    ];
    init();
    let mut engine = bums::x86::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(1, "in");
    engine.add_region(RegionType::READ, "in", abstract_of("len"));
    engine.add_invariant(fact("==", abstract_of("len"), imm(8)));
    assert!(engine.start("start").is_err());
}

#[test]
fn a_pinned_count_that_steps_over_zero_is_not_summarized_away() {
    init();
    let program = "start:
        walk:
        ldr x3, [x0]
        subs x2, x2, #3
        b.ne walk
        ret";
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "base");
    engine.add_abstract_from(2, "count");
    engine.add_region(RegionType::READ, "base", abstract_of("len"));
    engine.add_invariant(fact("==", abstract_of("len"), imm(8)));
    engine.add_invariant(fact("==", abstract_of("count"), imm(64)));
    assert!(engine.start("start").is_err());
}
