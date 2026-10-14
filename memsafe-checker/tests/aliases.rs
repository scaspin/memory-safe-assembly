
use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn accepts(length: i64, body: &[&str]) -> bool {
    init();
    let mut program = vec!["start:".to_string()];
    program.extend(body.iter().map(|line| line.to_string()));
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
fn neg_with_a_shifted_operand() {
    let body = [
        "mov x1, #2",
        "neg x2, x1, lsl #3",
        "sub x3, x0, x2",
        "ldr x4, [x3]",
    ];
    assert!(accepts(24, &body), "base + 16 read 8 bytes within 24");
    assert!(!accepts(16, &body), "base + 16 read 8 bytes past 16");
}

#[test]
fn hint_is_a_no_op() {
    let body = ["hint #34", "ldr x4, [x0, #8]"];
    assert!(accepts(16, &body));
    assert!(!accepts(8, &body));
}
