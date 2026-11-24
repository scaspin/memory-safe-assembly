use bums::common::*;
use bums::x86::engine::ExecutionEngine;

fn check(program: &[&str], invariants: &[AbstractComparison]) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut engine = ExecutionEngine::new(program.iter().copied());
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

fn len_at_most(n: i64) -> Vec<AbstractComparison> {
    vec![
        AbstractComparison::new("<=", abstract_of("len"), AbstractExpression::Immediate(n)),
        AbstractComparison::new(">=", abstract_of("len"), AbstractExpression::Immediate(0)),
    ]
}

#[test]
fn memset_of_the_whole_buffer_is_proved_safe() {
    let program = [
        "start:",
        "movl $16,%edx",
        "xorl %esi,%esi",
        "callq memset@PLT",
        "retq",
    ];
    assert_eq!(check(&program, &[]), Ok(()));
}

#[test]
fn memset_one_byte_past_the_buffer_is_rejected() {
    let program = [
        "start:",
        "movl $17,%edx",
        "xorl %esi,%esi",
        "callq memset@PLT",
        "retq",
    ];
    assert!(check(&program, &[]).is_err());
}

#[test]
fn memcpy_of_a_bounded_length_is_proved_safe() {
    let program = ["start:", "callq memcpy@PLT", "retq"];
    assert_eq!(check(&program, &len_at_most(16)), Ok(()));
}

#[test]
fn memcpy_of_an_unbounded_length_is_rejected() {
    let program = ["start:", "callq memcpy@PLT", "retq"];
    assert!(check(&program, &len_at_most(17)).is_err());
}

#[test]
fn memcpy_reading_past_its_source_is_rejected() {
    let program = ["start:", "movl $16,%edx", "callq memcpy", "retq"];
    assert!(check(&program, &len_at_most(16)).is_err());
}

#[test]
fn memcpy_into_a_stack_buffer_is_bounded_by_the_frame() {
    let fits = [
        "start:",
        "subq $40,%rsp",
        "movq %rsi,%rax",
        "movq %rsp,%rdi",
        "movq %rax,%rsi",
        "callq memcpy@PLT",
        "addq $40,%rsp",
        "retq",
    ];
    assert_eq!(check(&fits, &len_at_most(16)), Ok(()));
    let overflows = [
        "start:",
        "subq $8,%rsp",
        "movq %rsp,%rdi",
        "callq memcpy@PLT",
        "addq $8,%rsp",
        "retq",
    ];
    assert!(check(&overflows, &len_at_most(32)).is_err());
}

#[test]
fn memset_returns_its_destination_and_clobbers_argument_registers() {
    let through_result = [
        "start:",
        "movl $16,%edx",
        "callq memset@PLT",
        "movb $1,15(%rax)",
        "retq",
    ];
    assert_eq!(check(&through_result, &[]), Ok(()));
    let through_clobbered = [
        "start:",
        "movl $16,%edx",
        "callq memset@PLT",
        "movb $1,15(%rdi)",
        "retq",
    ];
    assert!(check(&through_clobbered, &[]).is_err());
}

#[test]
fn memset_with_an_unknown_length_is_rejected() {
    let program = ["start:", "movq (%rdi),%rdx", "callq memset@PLT", "retq"];
    assert!(check(&program, &[]).is_err());
}

#[test]
fn a_pointer_spilled_where_memcpy_writes_is_forgotten() {
    let spilled_inside = [
        "start:",
        "subq $40,%rsp",
        "movq %rdi,8(%rsp)",
        "movq %rsp,%rdi",
        "callq memcpy@PLT",
        "movq 8(%rsp),%rax",
        "movb $1,(%rax)",
        "addq $40,%rsp",
        "retq",
    ];
    assert!(check(&spilled_inside, &len_at_most(16)).is_err());
    let spilled_beyond = [
        "start:",
        "subq $40,%rsp",
        "movq %rdi,16(%rsp)",
        "movq %rsp,%rdi",
        "callq memcpy@PLT",
        "movq 16(%rsp),%rax",
        "movb $1,(%rax)",
        "addq $40,%rsp",
        "retq",
    ];
    assert_eq!(check(&spilled_beyond, &len_at_most(16)), Ok(()));
}

#[test]
fn a_field_beyond_a_masked_memcpy_length_survives_the_call() {
    let program = [
        "start:",
        "pushq %rbx",
        "subq $224,%rsp",
        "movq %rdi,%rbx",
        "movl $64,220(%rsp)",
        "movq %rdx,%rax",
        "andl $127,%eax",
        "leaq 88(%rsp),%rdi",
        "movq %rax,%rdx",
        "callq memcpy@PLT",
        "movl 220(%rsp),%ecx",
        "shrl $4,%ecx",
        "movb $1,-1(%rbx,%rcx)",
        "addq $224,%rsp",
        "popq %rbx",
        "retq",
    ];
    assert_eq!(check(&program, &len_at_most(1 << 20)), Ok(()));
}

#[test]
fn memset_whose_length_can_wrap_below_zero_is_rejected() {
    let program = [
        "start:",
        "movl $16,%eax",
        "subq %rdx,%rax",
        "movq %rax,%rdx",
        "xorl %esi,%esi",
        "callq memset@PLT",
        "retq",
    ];
    assert!(check(&program, &len_at_most(1 << 20)).is_err());
}
