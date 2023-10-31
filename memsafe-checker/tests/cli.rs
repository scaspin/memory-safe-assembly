use assert_cmd::prelude::*; // Add methods on commands
use predicates::prelude::*; // Used for writing assertions
use std::process::Command; // Run programs

#[test]
fn stack_is_ok() -> Result<(), Box<dyn std::error::Error>> {
    let mut cmd = Command::cargo_bin("memsafe-checker")?;

    cmd.arg("./tests/asm-examples/stack_push_pop.S").arg("test_stack");
    cmd.assert()
        .success()
        .stdout(predicate::str::contains("Symbolic execution done"));
    Ok(())
}

#[test]
fn bad_stack_read_is_flagged() -> Result<(), Box<dyn std::error::Error>> {
    let mut cmd = Command::cargo_bin("memsafe-checker")?;

    cmd.arg("./tests/asm-examples/stack_misalign.S").arg("stack_test");
    cmd.assert()
        .stderr(predicate::str::contains("MemorySafetyError"));
    Ok(())
}
