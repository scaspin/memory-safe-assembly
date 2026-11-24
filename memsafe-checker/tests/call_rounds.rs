use bums::common::*;
use bums::engine::ExecutionEngine;

fn helper_called_twice(second_offset: i64, region: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let program: Vec<String> = [
        "start:",
        "sub sp, sp, #16",
        "str x30, [sp]",
        "mov x9, x0",
        "bl fill",
        &format!("add x0, x9, #{second_offset}"),
        "bl fill",
        "ldr x30, [sp]",
        "add sp, sp, #16",
        "ret",
        "fill:",
        "ldrb w10, [x1]",
        "cbz w10, done",
        "str q0, [x0]",
        "str q0, [x0, #16]",
        "str q0, [x0, #32]",
        "str q0, [x0, #48]",
        "done:",
        "ret",
    ]
    .iter()
    .map(|l| l.to_string())
    .collect();

    let mut engine = ExecutionEngine::new(program);
    engine.add_abstract_from(0, "dst".to_string());
    engine.add_region(
        RegionType::WRITE,
        "dst".to_string(),
        AbstractExpression::Immediate(region),
    );
    engine.add_abstract_from(1, "flag".to_string());
    engine.add_region(
        RegionType::READ,
        "flag".to_string(),
        AbstractExpression::Immediate(1),
    );
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

#[test]
fn two_calls_of_one_helper_are_not_rounds_of_a_loop() {
    let res = helper_called_twice(64, 128);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn a_second_call_past_the_buffer_is_rejected() {
    let res = helper_called_twice(80, 128);
    assert!(res.is_err(), "{res:?}");
}
