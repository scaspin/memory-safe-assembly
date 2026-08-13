// Characterization tests for the loop acceleration algorithm in engine.rs.

use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

// Named `length` because the accelerator only engages on "len"/"loop" abstracts.
fn analyze(program: Vec<String>) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        AbstractExpression::Abstract("length".to_string()),
    );
    engine.add_abstract_from(1, "length".to_string());
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

// Walks x0 from base to base+length by `stride`.
fn walking_loop(stride: i64, body: &[&str], tail: &[&str]) -> Vec<String> {
    let mut program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "loop:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq end".to_string(),
    ];
    program.extend(body.iter().map(|s| s.to_string()));
    program.push(format!("add x0,x0,#{stride}"));
    program.push("b loop".to_string());
    program.push("end:".to_string());
    program.extend(tail.iter().map(|s| s.to_string()));
    program.push("ret".to_string());
    program
}

#[test]
fn accelerates_constant_stride_loop() {
    assert_eq!(analyze(walking_loop(4, &[], &[])), Ok(()));
}

#[test]
fn accelerated_loop_still_catches_out_of_bounds_read() {
    let res = analyze(walking_loop(4, &["ldr x2,[x0,#100000]"], &[]));
    assert!(
        res.unwrap_err()
            .contains("outside allowable memory regions")
    );
}

// max_diff of 1 contradicts `multiple > 1`.
#[test]
fn stride_one_loop_fails_to_resolve() {
    assert_eq!(
        analyze(walking_loop(1, &[], &[])),
        Err("could not resolve loop".to_string())
    );
}

// All deltas negative, so max_diff stays 0.
#[test]
fn countdown_loop_fails_to_resolve() {
    let program = vec![
        "start:".to_string(),
        "add x1,x0,x1".to_string(),
        "loop:".to_string(),
        "cmp x0,x1".to_string(),
        "b.eq end".to_string(),
        "sub x1,x1,#4".to_string(),
        "b loop".to_string(),
        "end:".to_string(),
        "ret".to_string(),
    ];
    assert_eq!(analyze(program), Err("could not resolve loop".to_string()));
}

// An immediate counter has no base, so the accelerator bails partway.
#[test]
fn immediate_counter_defeats_acceleration() {
    let mut program = walking_loop(4, &["add x2,x2,#1"], &[]);
    program.insert(2, "add x2,#0,#0".to_string());
    assert_eq!(analyze(program), Err("could not resolve loop".to_string()));
}

// The summary never bounds the walking address by `length`.
#[test]
fn accelerated_loop_cannot_prove_walking_read_safe() {
    let res = analyze(walking_loop(4, &["ldr x2,[x0,#0]"], &[]));
    assert_eq!(
        res,
        Err("Accessing address outside allowable memory regions Abstract(\"base\"), 4".to_string())
    );
}
