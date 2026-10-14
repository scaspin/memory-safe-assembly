// `tbz` and `tbnz` branch on one bit of a register. With a known value only one way is
// possible; otherwise both are, so an unsafe access either way has to be caught.

use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

// x0 holds a 16-byte region; x1 holds `x1`. `taken` is the body at the branch target,
// `fallen` the body after the branch.
fn run(branch: &str, x1: Option<usize>, taken: &[&str], fallen: &[&str]) -> std::io::Result<()> {
    init();
    let mut program = vec!["start:".to_string()];
    if x1.is_none() {
        // A value the engine does not model: an unknown number rather than a symbol.
        program.push("mov x1,v0.d[0]".to_string());
    }
    program.push(branch.to_string());
    program.extend(fallen.iter().map(|line| line.to_string()));
    program.push("ret".to_string());
    program.push("target:".to_string());
    program.extend(taken.iter().map(|line| line.to_string()));
    program.push("ret".to_string());

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Immediate(16),
    );
    match x1 {
        Some(value) => engine.add_immediate("x1", value),
        // A symbolic value: the bit is unknown, but the register has a base.
        None => (),
    }
    engine.start("start".to_string())
}

fn symbolic(branch: &str, taken: &[&str], fallen: &[&str]) -> std::io::Result<()> {
    init();
    let mut program = vec!["start:".to_string(), branch.to_string()];
    program.extend(fallen.iter().map(|line| line.to_string()));
    program.push("ret".to_string());
    program.push("target:".to_string());
    program.extend(taken.iter().map(|line| line.to_string()));
    program.push("ret".to_string());

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Immediate(16),
    );
    engine.add_abstract_from(1, "flags".to_string());
    engine.start("start".to_string())
}

const SAFE: &[&str] = &["ldr x2,[x0]"];
const UNSAFE: &[&str] = &["ldr x2,[x0,#16]"];

// bit 2 of 0b100 is set: tbnz jumps, tbz does not.
#[test]
fn tbnz_takes_a_set_bit() {
    assert!(run("tbnz x1,#2,target", Some(0b100), UNSAFE, SAFE).is_err());
}

#[test]
fn tbnz_skips_a_clear_bit() {
    assert!(run("tbnz x1,#2,target", Some(0b011), UNSAFE, SAFE).is_ok());
}

#[test]
fn tbz_takes_a_clear_bit() {
    assert!(run("tbz x1,#2,target", Some(0b011), UNSAFE, SAFE).is_err());
}

#[test]
fn tbz_skips_a_set_bit() {
    assert!(run("tbz x1,#2,target", Some(0b100), UNSAFE, SAFE).is_ok());
}

// The bit index counts from the bottom of the register, so a w register reaches bit 31.
#[test]
fn tbnz_reads_the_top_bit_of_a_w_register() {
    assert!(run("tbnz w1,#31,target", Some(1 << 31), UNSAFE, SAFE).is_err());
    assert!(run("tbnz w1,#31,target", Some(1 << 30), UNSAFE, SAFE).is_ok());
}

#[test]
fn tbz_counts_from_the_bottom() {
    assert!(run("tbz x1,#0,target", Some(0b10), UNSAFE, SAFE).is_err());
    assert!(run("tbz x1,#0,target", Some(0b11), UNSAFE, SAFE).is_ok());
}

// A symbolic bit leaves both ways open, so either path being unsafe is an error.
#[test]
fn symbolic_bit_explores_the_branch() {
    assert!(symbolic("tbnz x1,#3,target", UNSAFE, SAFE).is_err());
}

#[test]
fn symbolic_bit_explores_the_fall_through() {
    assert!(symbolic("tbnz x1,#3,target", SAFE, UNSAFE).is_err());
}

#[test]
fn symbolic_bit_accepts_two_safe_paths() {
    assert!(symbolic("tbnz x1,#3,target", SAFE, SAFE).is_ok());
}

// Neither does an unknown value stop the walk: both paths are still checked.
#[test]
fn unknown_bit_explores_both_paths() {
    assert!(run("tbnz x1,#3,target", None, UNSAFE, SAFE).is_err());
    assert!(run("tbnz x1,#3,target", None, SAFE, UNSAFE).is_err());
}

#[test]
fn unknown_bit_accepts_two_safe_paths() {
    assert!(run("tbnz x1,#3,target", None, SAFE, SAFE).is_ok());
}
