use assert_cmd::prelude::*; // Add methods on commands
use predicates::prelude::*; // Used for writing assertions
use std::process::Command; // Run programs

#[test]
fn test_stack() -> Result<(), Box<dyn std::error::Error>> {
    let mut cmd = Command::cargo_bin("memsafe-checker")?;

    cmd.arg("./tests/asm-examples/stack_push_pop.S").arg("test_stack");
    cmd.assert()
        .success()
        .stdout(predicate::str::contains("Symbolic execution done"));
    Ok(())
}
