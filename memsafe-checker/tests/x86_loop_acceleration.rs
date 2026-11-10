use bums::common::*;
use bums::x86::engine::ExecutionEngine;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn lines(program: &[&str]) -> Vec<String> {
    program.iter().map(|s| s.to_string()).collect()
}

fn engine_for(program: Vec<String>, ty: RegionType) -> ExecutionEngine {
    init();
    let mut engine = ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base");
    engine.add_region(ty, "base", abstract_of("length"));
    engine.add_abstract_from(1, "length");
    engine
}

fn analyze(program: Vec<String>) -> Result<(), String> {
    engine_for(program, RegionType::READ)
        .start("start")
        .map_err(|e| e.to_string())
}

fn multiple_of(n: i64) -> AbstractComparison {
    AbstractComparison::new(
        "==",
        generate_expression("%", abstract_of("length"), AbstractExpression::Immediate(n)),
        AbstractExpression::Immediate(0),
    )
}

fn at_least(n: i64) -> AbstractComparison {
    AbstractComparison::new(
        ">=",
        abstract_of("length"),
        AbstractExpression::Immediate(n),
    )
}

fn length_is(n: i64) -> AbstractComparison {
    AbstractComparison::new(
        "==",
        abstract_of("length"),
        AbstractExpression::Immediate(n),
    )
}

fn analyze_accelerated(
    program: Vec<String>,
    ty: RegionType,
    stride: i64,
    least: i64,
) -> Result<(), String> {
    let mut engine = engine_for(program, ty);
    engine.add_invariant(multiple_of(stride));
    engine.add_invariant(at_least(least));
    engine.start("start").map_err(|e| e.to_string())
}

fn analyze_with(program: Vec<String>, bound: AbstractComparison) -> Result<(), String> {
    let mut engine = engine_for(program, RegionType::READ);
    engine.add_invariant(bound);
    engine.start("start").map_err(|e| e.to_string())
}

#[track_caller]
fn assert_rejected_access(res: Result<(), String>) {
    let err = res.expect_err("expected a rejected access");
    assert!(err.contains("not provably within region"), "{err}");
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

fn walking_loop(stride: i64, body: &[&str], tail: &[&str]) -> Vec<String> {
    let mut program = lines(&[
        "start:",
        "leaq (%rdi,%rsi,1),%rsi",
        "L$loop:",
        "cmpq %rsi,%rdi",
        "je L$end",
    ]);
    program.extend(lines(body));
    program.push(format!("addq ${stride},%rdi"));
    program.push("jmp L$loop".to_string());
    program.push("L$end:".to_string());
    program.extend(lines(tail));
    program.push("ret".to_string());
    program
}

fn bottom_tested_loop(body: &[&str]) -> Vec<String> {
    let mut program = lines(&["start:", "leaq (%rdi,%rsi,1),%rsi", "L$loop:"]);
    program.extend(lines(body));
    program.extend(lines(&[
        "leaq 4(%rdi),%rdi",
        "cmpq %rsi,%rdi",
        "jne L$loop",
        "ret",
    ]));
    program
}

fn countdown_loop(body: &[&str]) -> Vec<String> {
    let mut program = lines(&["start:", "movq %rsi,%rdx", "shrq $2,%rdx", "L$loop:"]);
    program.extend(lines(body));
    program.extend(lines(&[
        "leaq 4(%rdi),%rdi",
        "decq %rdx",
        "jnz L$loop",
        "ret",
    ]));
    program
}

#[test]
fn accelerates_constant_stride_loop() {
    assert_eq!(analyze(walking_loop(4, &[], &[])), Ok(()));
}

#[test]
fn unbounded_abstract_length_proves_nothing() {
    assert_out_of_bounds(analyze(walking_loop(4, &["movl (%rdi),%eax"], &[])), 0);
}

#[test]
fn accelerated_walking_read_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(
            walking_loop(4, &["movl (%rdi),%eax"], &[]),
            RegionType::READ,
            4,
            4
        ),
        Ok(())
    );
}

#[test]
fn accelerated_walking_write_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(
            walking_loop(4, &["movl %eax,(%rdi)"], &[]),
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
        walking_loop(4, &["movl 4(%rdi),%eax"], &[]),
        RegionType::READ,
        4,
        16,
    ));
}

#[test]
fn load_wider_than_the_stride_is_rejected_at_the_end() {
    assert_rejected_access(analyze_accelerated(
        walking_loop(4, &["movq (%rdi),%rax"], &[]),
        RegionType::READ,
        4,
        16,
    ));
}

#[test]
fn read_of_the_last_element_after_the_loop_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(
            walking_loop(4, &[], &["movl -4(%rdi),%eax"]),
            RegionType::READ,
            4,
            16
        ),
        Ok(())
    );
}

#[test]
fn read_at_the_exit_pointer_is_rejected() {
    let err = analyze_accelerated(
        walking_loop(4, &[], &["movl (%rdi),%eax"]),
        RegionType::READ,
        4,
        16,
    )
    .unwrap_err();
    assert!(err.contains("not provably within region"), "{err}");
}

#[test]
fn zero_length_never_enters_the_loop() {
    assert_eq!(
        analyze_with(walking_loop(4, &["movl (%rdi),%eax"], &[]), length_is(0)),
        Ok(())
    );
}

#[test]
fn zero_length_still_enters_a_bottom_tested_loop() {
    assert_out_of_bounds(
        analyze_with(bottom_tested_loop(&["movl (%rdi),%eax"]), length_is(0)),
        0,
    );
}

#[test]
fn accelerated_bottom_tested_loop_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(
            bottom_tested_loop(&["movl (%rdi),%eax"]),
            RegionType::READ,
            4,
            4
        ),
        Ok(())
    );
}

#[test]
fn countdown_loop_is_proved_safe() {
    assert_eq!(
        analyze_accelerated(
            countdown_loop(&["movl (%rdi),%eax"]),
            RegionType::READ,
            4,
            4
        ),
        Ok(())
    );
}

#[test]
fn countdown_loop_still_catches_reading_ahead() {
    assert_rejected_access(analyze_accelerated(
        countdown_loop(&["movl 4(%rdi),%eax"]),
        RegionType::READ,
        4,
        16,
    ));
}

#[test]
fn unsigned_end_pointer_loop_is_proved_safe() {
    let program = lines(&[
        "start:",
        "leaq (%rdi,%rsi,1),%rsi",
        "L$loop:",
        "movdqu (%rdi),%xmm0",
        "leaq 16(%rdi),%rdi",
        "cmpq %rsi,%rdi",
        "jb L$loop",
        "ret",
    ]);
    assert_eq!(
        analyze_accelerated(program, RegionType::READ, 16, 16),
        Ok(())
    );
}

#[test]
fn borrow_tested_loop_is_proved_safe() {
    let program = lines(&[
        "start:",
        "movq %rsi,%rdx",
        "subq $16,%rdx",
        "L$loop:",
        "movdqu (%rdi),%xmm0",
        "leaq 16(%rdi),%rdi",
        "subq $16,%rdx",
        "jnc L$loop",
        "ret",
    ]);
    assert_eq!(
        analyze_accelerated(program, RegionType::READ, 16, 16),
        Ok(())
    );
}

#[test]
fn local_call_returns_and_is_checked() {
    let program = lines(&[
        "start:",
        "call L$load",
        "addq $4,%rdi",
        "call L$load",
        "ret",
        "L$load:",
        "movl (%rdi),%eax",
        "ret",
    ]);
    assert_eq!(analyze_with(program.clone(), length_is(8)), Ok(()));
    assert_out_of_bounds(analyze_with(program, length_is(4)), 4);
}

#[test]
fn saved_registers_are_restored_from_the_stack() {
    let program = lines(&[
        "start:",
        "pushq %rbx",
        "pushq %rbp",
        "movq %rdi,%rbx",
        "xorl %edi,%edi",
        "movq %rbx,%rdi",
        "movl (%rdi),%eax",
        "popq %rbp",
        "popq %rbx",
        "ret",
    ]);
    assert_eq!(analyze_with(program, length_is(4)), Ok(()));
}

#[test]
fn unbalanced_stack_is_reported_at_ret() {
    let program = lines(&["start:", "pushq %rbx", "ret"]);
    let err = analyze(program).unwrap_err();
    assert!(err.contains("return address"), "{err}");
}

#[test]
fn loop_reached_only_through_a_branch_is_accelerated() {
    let program = lines(&[
        "start:",
        "leaq (%rdi,%rsi,1),%rsi",
        "testq %rdx,%rdx",
        "jz L$done",
        "L$loop:",
        "cmpq %rsi,%rdi",
        "je L$done",
        "movl (%rdi),%eax",
        "addq $4,%rdi",
        "jmp L$loop",
        "L$done:",
        "ret",
    ]);
    let mut engine = engine_for(program, RegionType::READ);
    engine.add_abstract_from(2, "flag");
    engine.add_invariant(multiple_of(4));
    engine.add_invariant(at_least(4));
    assert_eq!(engine.start("start").map_err(|e| e.to_string()), Ok(()));
}

#[test]
fn stack_argument_is_read_from_above_the_return_address() {
    init();
    let program = lines(&["start:", "movq 8(%rsp),%rax", "movl (%rax),%eax", "ret"]);
    let mut engine = ExecutionEngine::new(program);
    engine.add_abstract_from(6, "seventh");
    engine.add_region(
        RegionType::READ,
        "seventh",
        AbstractExpression::Immediate(4),
    );
    assert!(engine.start("start").is_ok());
}

#[test]
fn rep_movs_checks_source_and_destination() {
    init();
    let program = lines(&["start:", "movq %rdx,%rcx", "rep movsb", "ret"]);
    let mut engine = ExecutionEngine::new(program.clone());
    engine.add_abstract_from(0, "dst");
    engine.add_abstract_from(1, "src");
    engine.add_abstract_from(2, "n");
    engine.add_region(RegionType::WRITE, "dst", abstract_of("n"));
    engine.add_region(RegionType::READ, "src", abstract_of("n"));
    assert!(engine.start("start").is_ok());

    let mut short = ExecutionEngine::new(program);
    short.add_abstract_from(0, "dst");
    short.add_abstract_from(1, "src");
    short.add_abstract_from(2, "n");
    short.add_region(RegionType::WRITE, "dst", abstract_of("n"));
    short.add_region(
        RegionType::READ,
        "src",
        generate_expression("-", abstract_of("n"), AbstractExpression::Immediate(1)),
    );
    assert!(short.start("start").is_err());
}

#[test]
fn rip_relative_table_reads_are_bounded_by_the_data() {
    let table = |offset: i64| {
        lines(&[
            "start:",
            "leaq K(%rip),%r10",
            &format!("movl {offset}(%r10),%eax"),
            "ret",
            ".p2align 4",
            "K:",
            ".long 1,2,3,4",
        ])
    };
    assert_eq!(analyze(table(12)), Ok(()));
    assert!(analyze(table(16)).is_err());
}

fn width_dispatch(widths: &[(i64, &str)]) -> Vec<String> {
    let mut program = lines(&["start:", "tzcntl %esi,%eax"]);
    let table: Vec<String> = widths
        .iter()
        .map(|(w, label)| format!("{}:{label}", w.trailing_zeros()))
        .collect();
    program.push(format!("bums.jump_table %rax, {}", table.join(", ")));
    for (w, label) in widths {
        program.push(format!("{label}:"));
        program.push(format!("movl {}(%rdi),%ecx", w - 4));
        program.push("ret".to_string());
    }
    program
}

fn analyze_width(program: Vec<String>) -> Result<(), String> {
    let mut engine = engine_for(program, RegionType::READ);
    let width = abstract_of("length");
    engine.add_invariant(AbstractComparison::new(
        "==",
        generate_expression("%", AbstractExpression::Immediate(16), width.clone()),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        width,
        AbstractExpression::Immediate(4),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn jump_table_on_a_power_of_two_width_explores_each_width() {
    let program = width_dispatch(&[(4, ".w4"), (8, ".w8"), (16, ".w16")]);
    assert_eq!(analyze_width(program), Ok(()));
}

#[test]
fn jump_table_missing_a_feasible_width_is_reported() {
    let program = width_dispatch(&[(4, ".w4"), (8, ".w8")]);
    let err = analyze_width(program).unwrap_err();
    assert!(err.contains("jump table has no entry 4"), "{err}");
}

fn two_blocks_a_round(before_the_loop: &str, in_the_loop: &str) -> Vec<String> {
    let advance_second =
        |choose_second| lines(&["leaq 64(%rdi),%r11", "cmpq %r10,%r11", choose_second]);
    let mut program = lines(&["start:", "leaq (%rdi,%rsi,1),%r10"]);
    program.extend(advance_second(before_the_loop));
    program.extend(lines(&[
        "L$loop:",
        "movdqu (%rdi),%xmm0",
        "movdqu 48(%rdi),%xmm0",
        "movdqu (%r11),%xmm1",
        "movdqu 48(%r11),%xmm1",
        "addq $128,%rdi",
    ]));
    program.extend(advance_second(in_the_loop));
    program.extend(lines(&["cmpq %r10,%rdi", "jb L$loop", "ret"]));
    program
}

#[test]
fn a_second_block_chosen_afresh_each_round_stays_in_the_buffer() {
    assert_eq!(
        analyze_accelerated(
            two_blocks_a_round("cmovaeq %rdi,%r11", "cmovaeq %rdi,%r11"),
            RegionType::READ,
            64,
            64
        ),
        Ok(())
    );
}

#[test]
fn a_second_block_kept_when_it_starts_at_the_end_is_rejected() {
    assert_rejected_access(analyze_accelerated(
        two_blocks_a_round("cmovaq %rdi,%r11", "cmovaq %rdi,%r11"),
        RegionType::READ,
        64,
        64,
    ));
}

#[test]
fn a_second_block_kept_at_the_end_only_inside_the_loop_is_rejected() {
    assert_rejected_access(analyze_accelerated(
        two_blocks_a_round("cmovaeq %rdi,%r11", "cmovaq %rdi,%r11"),
        RegionType::READ,
        64,
        64,
    ));
}

fn search_then_tail(length: i64) -> Result<(), String> {
    let program = lines(&[
        "start:",
        "movq $5, %rcx",
        "L$loop:",
        "movq (%rdi), %rax",
        "testq %rax, %rax",
        "jne L$found",
        "addq $8, %rdi",
        "decq %rcx",
        "jg L$loop",
        "movq (%rdi), %rax",
        "L$found:",
        "ret",
    ]);
    let mut engine = engine_for(program, RegionType::READ);
    engine.add_invariant(length_is(length));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_search_with_a_concrete_count_reads_its_tail_in_bounds() {
    assert_eq!(search_then_tail(48), Ok(()));
}

#[test]
fn a_search_with_a_concrete_count_reading_a_tail_past_the_end_is_rejected() {
    assert_rejected_access(search_then_tail(40));
}

#[test]
fn a_helper_called_from_four_sites_of_a_long_concrete_loop_is_followed() {
    let program = lines(&[
        "start:",
        "pushq %rbx",
        "movl $300,%ebx",
        ".Lround:",
        "callq helper",
        "callq helper",
        "callq helper",
        "callq helper",
        "decl %ebx",
        "jne .Lround",
        "popq %rbx",
        "retq",
        "helper:",
        "xorl %eax,%eax",
        "retq",
    ]);
    assert_eq!(analyze(program), Ok(()));
}

#[test]
fn unbounded_recursion_is_still_rejected() {
    let program = lines(&["start:", "callq start", "retq"]);
    assert!(analyze(program).is_err());
}

fn four_byte_walk_from(start: &[&str]) -> Vec<String> {
    let mut program = vec!["start:"];
    program.extend_from_slice(start);
    program.extend_from_slice(&[
        "cmpq %rcx,%rsi",
        "je .Ldone",
        ".Lfour:",
        "movzbl (%rdi,%rcx),%eax",
        "movzbl 1(%rdi,%rcx),%eax",
        "movzbl 2(%rdi,%rcx),%eax",
        "movzbl 3(%rdi,%rcx),%eax",
        "addq $4,%rcx",
        "cmpq %rcx,%rsi",
        "jne .Lfour",
        ".Ldone:",
        "retq",
    ]);
    lines(&program)
}

#[test]
fn a_four_byte_walk_that_lands_exactly_on_the_length_is_proved_safe() {
    let program = four_byte_walk_from(&["movq %rsi,%rcx", "andq $3,%rcx"]);
    assert_eq!(analyze_with(program, at_least(0)), Ok(()));
}

#[test]
fn a_four_byte_walk_that_can_step_over_the_length_is_rejected() {
    let program = four_byte_walk_from(&["movq %rsi,%rcx", "andq $1,%rcx"]);
    assert_rejected_access(analyze_with(program, at_least(0)));
    let from_zero = four_byte_walk_from(&["xorl %ecx,%ecx"]);
    assert_rejected_access(analyze_with(from_zero, at_least(0)));
}

#[test]
fn rep_stos_whose_count_can_wrap_below_zero_is_rejected() {
    init();
    let program = lines(&[
        "start:",
        "movl $16,%ecx",
        "subq %rsi,%rcx",
        "xorl %eax,%eax",
        "rep stosb",
        "ret",
    ]);
    let mut engine = ExecutionEngine::new(program.clone());
    engine.add_abstract_from(0, "dst");
    engine.add_abstract_from(1, "used");
    engine.add_region(RegionType::WRITE, "dst", AbstractExpression::Immediate(16));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("used"),
        AbstractExpression::Immediate(0),
    ));
    let err = engine.start("start").unwrap_err().to_string();
    assert!(err.contains("may be negative"), "{err}");

    let mut bounded = ExecutionEngine::new(program);
    bounded.add_abstract_from(0, "dst");
    bounded.add_abstract_from(1, "used");
    bounded.add_region(RegionType::WRITE, "dst", AbstractExpression::Immediate(16));
    bounded.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("used"),
        AbstractExpression::Immediate(0),
    ));
    bounded.add_invariant(AbstractComparison::new(
        "<=",
        abstract_of("used"),
        AbstractExpression::Immediate(16),
    ));
    assert!(bounded.start("start").is_ok());
}

fn masked_tail_copy(byte_mask: i64) -> Vec<String> {
    lines(&[
        "start:",
        "movq %rsi,%rcx",
        "andq $8,%rcx",
        "movq %rcx,%rdx",
        "notq %rdx",
        "addq %rsi,%rdx",
        "movq %rsi,%r8",
        &format!("andq ${byte_mask},%r8"),
        "je .Lquads",
        ".Lsingle:",
        "movzbl (%rdi,%rcx),%eax",
        "incq %rcx",
        "decq %r8",
        "jne .Lsingle",
        ".Lquads:",
        "cmpq $3,%rdx",
        "jb .Ldone",
        ".Lquad:",
        "movzbl (%rdi,%rcx),%eax",
        "movzbl 3(%rdi,%rcx),%eax",
        "addq $4,%rcx",
        "cmpq %rcx,%rsi",
        "jne .Lquad",
        ".Ldone:",
        "retq",
    ])
}

fn below(n: i64) -> AbstractComparison {
    AbstractComparison::new("<", abstract_of("length"), AbstractExpression::Immediate(n))
}

#[test]
fn a_tail_split_by_length_masks_is_proved_safe() {
    let mut engine = engine_for(masked_tail_copy(3), RegionType::READ);
    engine.add_invariant(below(16));
    engine.add_invariant(at_least(0));
    assert_eq!(engine.start("start").map_err(|e| e.to_string()), Ok(()));
}

#[test]
fn a_tail_whose_single_bytes_overlap_the_quads_is_rejected() {
    let mut engine = engine_for(masked_tail_copy(7), RegionType::READ);
    engine.add_invariant(below(16));
    engine.add_invariant(at_least(0));
    assert!(engine.start("start").is_err());
}

fn shrinking_block_loop(body: &[&str]) -> Vec<String> {
    let mut program = vec![
        "start:",
        "testq %rsi,%rsi",
        "je .Lout",
        "movq %rsi,%r14",
        ".Lblock:",
        "cmpq $64,%r14",
        "movl $64,%r13d",
        "cmovbq %r14,%r13",
    ];
    program.extend_from_slice(body);
    program.extend_from_slice(&[
        "addq %r13,%rdi",
        "subq %r13,%r14",
        "jne .Lblock",
        ".Lout:",
        "retq",
    ]);
    lines(&program)
}

#[test]
fn a_full_block_read_in_a_shrinking_last_block_is_rejected() {
    let program = shrinking_block_loop(&["movups 48(%rdi),%xmm0"]);
    assert!(analyze_with(program, at_least(0)).is_err());
}

#[test]
fn a_shrinking_block_loop_that_branches_on_the_short_block_is_proved_safe() {
    let program = shrinking_block_loop(&[
        "cmpq $64,%r13",
        "jb .Lshort",
        "addq $1,%rax",
        "jmp .Lnext",
        ".Lshort:",
        "movq %r13,%rcx",
        "andq $3,%rcx",
        "je .Lnext",
        ".Lbyte:",
        "addq $2,%rax",
        "decq %rcx",
        "jne .Lbyte",
        ".Lnext:",
    ]);
    assert_eq!(analyze_with(program, at_least(0)), Ok(()));
}

#[test]
fn reading_the_first_byte_of_each_shrinking_block_is_proved_safe() {
    let program = shrinking_block_loop(&[
        "movzbl (%rdi),%eax",
        "cmpq $64,%r13",
        "jb .Lshort",
        "addq $1,%rax",
        "jmp .Lnext",
        ".Lshort:",
        "movq %r13,%rcx",
        "andq $3,%rcx",
        "je .Lnext",
        ".Lbyte:",
        "addq $2,%rax",
        "decq %rcx",
        "jne .Lbyte",
        ".Lnext:",
    ]);
    assert_eq!(analyze_with(program, at_least(0)), Ok(()));
}

#[test]
fn reading_a_byte_past_each_shrinking_block_is_rejected() {
    let program = shrinking_block_loop(&["movzbl 64(%rdi),%eax"]);
    assert_rejected_access(analyze_with(program, at_least(0)));
}

#[test]
fn a_down_counter_allowed_below_zero_gets_no_floor() {
    let program = lines(&[
        "start:",
        "testq %rsi,%rsi",
        "je .Lout",
        "movq %rsi,%r14",
        ".Lblock:",
        "movzbl (%rdi),%eax",
        "addq $64,%rdi",
        "subq $64,%r14",
        "cmpq $-64,%r14",
        "jg .Lblock",
        ".Lout:",
        "retq",
    ]);
    assert_rejected_access(analyze_with(program, at_least(0)));
}

fn latch_above_the_body(first_read: &str) -> Vec<String> {
    lines(&[
        "start:",
        "testq %rsi,%rsi",
        "je .Lout",
        "movq %rsi,%r14",
        "jmp .Lhead",
        ".Llatch:",
        "addq %r13,%rdi",
        "subq %r13,%r14",
        "je .Lout",
        ".Lhead:",
        "cmpq $64,%r14",
        "movl $64,%r13d",
        "cmovbq %r14,%r13",
        first_read,
        "movq %r13,%rcx",
        "andq $96,%rcx",
        "cmpq %rcx,%r13",
        "je .Llatch",
        "movq %r13,%rdx",
        "andq $3,%rdx",
        "je .Llatch",
        ".Lbyte:",
        "addq $1,%rax",
        "decq %rdx",
        "jne .Lbyte",
        "jmp .Llatch",
        ".Lout:",
        "retq",
    ])
}

#[test]
fn a_loop_with_several_back_edges_into_its_latch_is_summarized_at_the_latch() {
    let program = latch_above_the_body("movzbl (%rdi),%eax");
    assert_eq!(analyze_with(program, at_least(0)), Ok(()));
}

#[test]
fn a_loop_with_several_back_edges_still_catches_a_read_past_the_block() {
    let program = latch_above_the_body("movzbl 64(%rdi),%eax");
    assert_rejected_access(analyze_with(program, at_least(0)));
}
