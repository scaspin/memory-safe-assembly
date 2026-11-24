use bums::x86::engine::ExecutionEngine;

fn analyze(program: &[&str]) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    ExecutionEngine::new(program.iter().copied())
        .start("start")
        .map_err(|e| e.to_string())
}

#[track_caller]
fn assert_outside_the_frame(result: Result<(), String>) {
    let err = result.expect_err("expected an access outside the stack frame");
    assert!(err.contains("not provably within the stack frame"), "{err}");
}

#[test]
fn a_leaf_spill_into_the_red_zone_is_accepted() {
    let program = [
        "start:",
        "movq %rdi,-64(%rsp)",
        "movq -64(%rsp),%rax",
        "movq %rax,-128(%rsp)",
        "retq",
    ];
    assert_eq!(analyze(&program), Ok(()));
}

#[test]
fn a_write_past_the_red_zone_of_an_unallocated_frame_is_rejected() {
    let program = ["start:", "movq %rdi,-136(%rsp)", "retq"];
    assert_outside_the_frame(analyze(&program));
}

#[test]
fn an_allocated_frame_may_be_used_to_its_end() {
    let program = [
        "start:",
        "subq $256,%rsp",
        "movq %rdi,(%rsp)",
        "movq %rdi,248(%rsp)",
        "movq %rdi,-128(%rsp)",
        "addq $256,%rsp",
        "retq",
    ];
    assert_eq!(analyze(&program), Ok(()));
}

#[test]
fn a_released_frame_is_no_longer_writable() {
    let program = [
        "start:",
        "subq $256,%rsp",
        "addq $256,%rsp",
        "movq %rdi,-200(%rsp)",
        "retq",
    ];
    assert_outside_the_frame(analyze(&program));
}

#[test]
fn a_store_eight_megabytes_below_the_stack_pointer_is_rejected() {
    let program = ["start:", "movq %rbp,-8388616(%rsp)", "retq"];
    assert_outside_the_frame(analyze(&program));
}

#[test]
fn pushes_below_the_red_zone_stay_inside_the_frame() {
    let program = [
        "start:",
        "pushq %rbx",
        "pushq %rbp",
        "subq $512,%rsp",
        "movq %rdi,504(%rsp)",
        "addq $512,%rsp",
        "popq %rbp",
        "popq %rbx",
        "retq",
    ];
    assert_eq!(analyze(&program), Ok(()));
}
