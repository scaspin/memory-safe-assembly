
use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

const REDUCE: &[&str] = &[
    "cmhs v2.8h, v30.8h, v4.8h",
    "cmhs v3.8h, v30.8h, v5.8h",
    "add v6.8h, v2.8h, v3.8h",
    "addv h31, v6.8h",
    "smov w15, v31.h[0]",
    "add x1, x0, w15, sxtw #1",
];

fn accepts(prefix: &[&str], access: &str, length: i64) -> bool {
    init();
    let mut program = vec!["start:".to_string()];
    program.extend(prefix.iter().map(|line| line.to_string()));
    program.push(access.to_string());
    program.push("ret".to_string());

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Immediate(length),
    );
    engine.start("start".to_string()).is_ok()
}

#[test]
fn reduced_mask_index_bounds_an_access() {
    assert!(accepts(REDUCE, "ldrb w2, [x1, #32]", 33));
}

#[test]
fn reduced_mask_index_is_still_checked_above() {
    assert!(!accepts(REDUCE, "ldrb w2, [x1, #32]", 32));
}

#[test]
fn reduced_mask_index_is_still_checked_below() {
    assert!(!accepts(REDUCE, "ldrb w2, [x1, #31]", 1024));
}

#[test]
fn an_unreduced_lane_is_not_bounded() {
    let unreduced = &["smov w15, v31.h[0]", "add x1, x0, w15, sxtw #1"];
    assert!(!accepts(unreduced, "ldrb w2, [x1, #32]", 1024));
}

#[test]
fn an_overwritten_mask_is_not_bounded() {
    let overwritten = &[
        "cmhs v2.8h, v30.8h, v4.8h",
        "mul v2.8h, v4.8h, v5.8h",
        "addv h31, v2.8h",
        "smov w15, v31.h[0]",
        "add x1, x0, w15, sxtw #1",
    ];
    assert!(!accepts(overwritten, "ldrb w2, [x1, #32]", 1024));
}
