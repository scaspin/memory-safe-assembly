use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn reads(body: &[&str], count: i64, region: i64) -> Result<(), String> {
    init();
    let mut program = vec!["start:".to_string()];
    program.extend(body.iter().map(|l| l.to_string()));
    program.push("ret".to_string());

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(1, "buf".to_string());
    engine.add_region(
        RegionType::READ,
        "buf".to_string(),
        AbstractExpression::Immediate(region),
    );
    engine.add_immediate("x10", count as usize);
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

#[test]
fn bfi_builds_a_scaled_index() {
    let body = &[
        "add x8, x10, x10, lsl #3",
        "mov w9, #0x4",
        "bfi x9, x8, #4, #60",
        "ldrb w0, [x1, x9]",
    ];
    assert!(reads(body, 2, 293).is_ok());
    assert!(reads(body, 2, 292).is_err());
}

#[test]
fn bfi_scales_a_symbolic_index() {
    init();
    let program = [
        "start:",
        "add x8, x10, x10, lsl #3",
        "mov w9, #0x4",
        "bfi x9, x8, #4, #60",
        "ldrb w0, [x1, x9]",
        "ret",
    ];
    let engine_for = |region: i64| {
        let mut engine = bums::engine::ExecutionEngine::new(
            program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
        );
        engine.add_abstract_from(1, "buf".to_string());
        engine.add_region(
            RegionType::READ,
            "buf".to_string(),
            AbstractExpression::Immediate(region),
        );
        engine.add_abstract("x10", AbstractExpression::Abstract("block".to_string()));
        for (op, bound) in [(">=", 0), ("<=", 1)] {
            engine.add_invariant(AbstractComparison::new(
                op,
                AbstractExpression::Abstract("block".to_string()),
                AbstractExpression::Immediate(bound),
            ));
        }
        engine
    };
    assert!(engine_for(149).start("start".to_string()).is_ok());
    assert!(engine_for(148).start("start".to_string()).is_err());
}

#[test]
fn bfi_keeps_the_bits_below_the_insert() {
    let body = &[
        "add x8, x10, x10, lsl #3",
        "mov w9, #0xf",
        "bfi x9, x8, #4, #60",
        "ldrb w0, [x1, x9]",
    ];
    assert!(reads(body, 1, 160).is_ok());
    assert!(reads(body, 1, 159).is_err());
}

#[test]
fn a_tag_bit_on_a_stack_address_is_an_add() {
    init();
    let program = [
        "start:",
        "sub sp, sp, #0x40",
        "add x8, sp, #0x20",
        "orr x8, x8, #0x1",
        "ldurb w0, [x8, #-0x1]",
        "add sp, sp, #0x40",
        "ret",
    ];
    let mut engine = bums::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    assert!(engine.start("start".to_string()).is_ok());
}

#[test]
fn a_tag_bit_does_not_reach_past_the_frame() {
    init();
    let program = [
        "start:",
        "sub sp, sp, #0x40",
        "add x8, sp, #0x20",
        "orr x8, x8, #0x1",
        "ldrb w0, [x8, #0x40]",
        "add sp, sp, #0x40",
        "ret",
    ];
    let mut engine = bums::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    assert!(engine.start("start".to_string()).is_err());
}

#[test]
fn a_tag_the_offset_does_not_leave_room_for_is_not_an_add() {
    init();
    let program = [
        "start:",
        "sub sp, sp, #0x40",
        "add x8, sp, #0x21",
        "orr x8, x8, #0x1",
        "ldurb w0, [x8, #-0x1]",
        "add sp, sp, #0x40",
        "ret",
    ];
    let mut engine = bums::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    assert!(engine.start("start".to_string()).is_err());
}
