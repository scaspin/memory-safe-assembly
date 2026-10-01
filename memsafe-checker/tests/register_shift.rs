
fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

#[test]
fn a_register_shift_does_not_leave_the_destination_alone() {
    init();
    let program = vec![
        "start:".to_string(),
        "mov x1, x0".to_string(),
        "lsr x1, x1, x2".to_string(),
        "ldrb w3, [x1]".to_string(),
        "ret".to_string(),
    ];
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        bums::common::RegionType::RW,
        "base".to_string(),
        bums::common::AbstractExpression::Immediate(1024),
    );
    assert!(engine.start("start".to_string()).is_err());
}
