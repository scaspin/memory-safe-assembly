// Reproduction of bn_add_words from bn-armv8.S: two u64 per iteration, odd tail.

use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn bytes(len: &str) -> AbstractExpression {
    generate_expression("*", abstract_of(len), AbstractExpression::Immediate(8))
}

fn same_length(a: &str, b: &str) -> AbstractComparison {
    AbstractComparison::new("==", abstract_of(a), abstract_of(b))
}

// The real loop uses adcs; add keeps the addressing shape without a symbolic carry.
fn run() -> Result<(), String> {
    init();
    let program = [
        "start:",
        "cmn xzr, xzr",
        "lsr x8, x3, #1",
        "and x3, x3, #1",
        "cbz x8, tail",
        "loop:",
        "ldp x4, x5, [x1], #16",
        "ldp x6, x7, [x2], #16",
        "sub x8, x8, #1",
        "add x4, x4, x6",
        "add x5, x5, x7",
        "stp x4, x5, [x0], #16",
        "cbnz x8, loop",
        "tail:",
        "cbz x3, exit",
        "ldr x4, [x1], #8",
        "ldr x6, [x2], #8",
        "add x4, x4, x6",
        "str x4, [x0], #8",
        "exit:",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "output");
    engine.add_region(RegionType::WRITE, "output", bytes("output_len"));
    engine.add_abstract_from(1, "a");
    engine.add_region(RegionType::READ, "a", bytes("a_len"));
    engine.add_abstract_from(2, "b");
    engine.add_region(RegionType::READ, "b", bytes("b_len"));
    engine.add_abstract_from(3, "output_len");

    engine.add_invariant(same_length("output_len", "a_len"));
    engine.add_invariant(same_length("output_len", "b_len"));

    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn bn_add_words_is_memory_safe() {
    assert_eq!(run(), Ok(()));
}

// The same loop shape with the counter driving a single element per iteration.
fn variant(setup: &str, step: &str) -> Result<(), String> {
    init();
    let program = [
        "start:",
        setup,
        "cbz x8, exit",
        "loop:",
        step,
        "sub x8, x8, #1",
        "cbnz x8, loop",
        "exit:",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(1, "a");
    engine.add_region(RegionType::READ, "a", bytes("a_len"));
    engine.add_abstract_from(3, "a_len");
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn counter_halved_reading_one_element_a_step() {
    assert_eq!(variant("lsr x8, x3, #1", "ldr x4, [x1], #8"), Ok(()));
}

#[test]
fn counter_is_the_length_reading_one_element_a_step() {
    assert_eq!(variant("add x8, x3, #0", "ldr x4, [x1], #8"), Ok(()));
}
