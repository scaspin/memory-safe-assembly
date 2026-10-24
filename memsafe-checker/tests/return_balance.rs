fn outcome_of(lines: &[&str]) -> Result<(), String> {
    let program = lines.iter().map(|s| s.to_string()).collect::<Vec<_>>();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(1, "buf".to_string());
    engine.add_abstract_from(2, "amount".to_string());
    engine.add_region(
        bums::common::RegionType::READ,
        "buf".to_string(),
        bums::common::AbstractExpression::Immediate(8),
    );
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

fn assert_unbalanced(lines: &[&str], line: usize) {
    let outcome = outcome_of(lines);
    assert!(
        outcome.as_ref().is_err_and(|e| e.contains(&format!(
            "line {line}: stack pointer not restored on return"
        ))),
        "{lines:?}: {outcome:?}"
    );
}

#[test]
fn a_return_with_the_stack_pointer_moved_is_rejected() {
    assert_eq!(
        outcome_of(&[
            "start:",
            "stp x29,x30,[sp,#-0x10]!",
            "ldp x29,x30,[sp],#0x10",
            "ret"
        ]),
        Ok(())
    );
    assert_unbalanced(&["start:", "stp x29,x30,[sp,#-0x10]!", "ret"], 2);
    assert_unbalanced(&["start:", "sub sp,sp,x2", "ret"], 2);
    assert_unbalanced(
        &["start:", "cbz x2,done", "sub sp,sp,#16", "done:", "ret"],
        3,
    );
}

#[test]
fn a_stack_pointer_spelled_differently_is_proved_restored() {
    assert_eq!(
        outcome_of(&["start:", "sub sp,sp,x2", "add sp,sp,x2", "ret"]),
        Ok(())
    );
    assert_eq!(
        outcome_of(&["start:", "mov x9,sp", "sub sp,sp,#32", "mov sp,x9", "ret"]),
        Ok(())
    );
}

#[test]
fn a_trap_ends_the_path_without_a_stack_check() {
    for trap in ["brk #0x1", "udf #0x0"] {
        assert_eq!(
            outcome_of(&["start:", "stp x29,x30,[sp,#-0x10]!", trap]),
            Ok(())
        );
    }
    assert_eq!(
        outcome_of(&["start:", "brk #0x1", "ldr x0,[x1,#64]"]),
        Ok(())
    );
    assert!(outcome_of(&["start:", "ldr x0,[x1,#64]", "ret"]).is_err());
}

#[test]
fn a_path_that_runs_past_the_end_of_the_code_is_rejected() {
    for lines in [
        &["start:", "ldr x0,[x1]"][..],
        &["start:", "cbz x0,end", "ret", "end:"][..],
    ] {
        let outcome = outcome_of(lines);
        assert!(
            outcome
                .as_ref()
                .is_err_and(|e| e.contains("runs past the end of the code")),
            "{lines:?}: {outcome:?}"
        );
    }
    assert_eq!(outcome_of(&["start:", "ldr x0,[x1]", "ret"]), Ok(()));
}
