use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn words(name: &str) -> AbstractExpression {
    generate_expression(
        "*",
        AbstractExpression::Abstract(name.to_string()),
        AbstractExpression::Immediate(8),
    )
}

fn ccn_add(output_words: &str) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "adds x4,x4,#0",
        "cbnz x0,Ltmp0",
        "ret",
        "Ltmp0:",
        "and w12,w0,#0x1",
        "cbz w12,L_skip1",
        "ldr x4,[x2],#8",
        "ldr x8,[x3],#8",
        "adds x8,x4,x8",
        "str x8,[x1],#8",
        "L_skip1:",
        "and w12,w0,#0x2",
        "cbz w12,L_skip2",
        "ldp x4,x5,[x2],#16",
        "ldp x8,x9,[x3],#16",
        "adcs x8,x4,x8",
        "adcs x9,x5,x9",
        "stp x8,x9,[x1],#16",
        "L_skip2:",
        "and w0,w0,#0xfffffffc",
        "cbz w0,L_done",
        "sub w0,w0,#4",
        "ldp x4,x5,[x2],#16",
        "ldp x8,x9,[x3],#16",
        "ldp x6,x7,[x2],#16",
        "ldp x10,x11,[x3],#16",
        "cbz w0,L_loop4_finishup",
        "L_loop4:",
        "adcs x8,x4,x8",
        "adcs x9,x5,x9",
        "ldp x4,x5,[x2],#16",
        "adcs x10,x6,x10",
        "stp x8,x9,[x1],#16",
        "adcs x11,x7,x11",
        "ldp x8,x9,[x3],#16",
        "stp x10,x11,[x1],#16",
        "sub w0,w0,#4",
        "ldp x6,x7,[x2],#16",
        "ldp x10,x11,[x3],#16",
        "cbnz w0,L_loop4",
        "L_loop4_finishup:",
        "adcs x8,x4,x8",
        "adcs x9,x5,x9",
        "adcs x10,x6,x10",
        "adcs x11,x7,x11",
        "stp x8,x9,[x1],#16",
        "stp x10,x11,[x1],#16",
        "L_done:",
        "mov w0,#0",
        "adc w0,w0,w0",
        "ret",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "n");
    engine.add_abstract_from(1, "r");
    engine.add_region(RegionType::RW, "r", words(output_words));
    engine.add_abstract_from(2, "s");
    engine.add_region(RegionType::READ, "s", words("n"));
    engine.add_abstract_from(3, "t");
    engine.add_region(RegionType::READ, "t", words("n"));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        AbstractExpression::Abstract("n".to_string()),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(AbstractComparison::new(
        "==",
        AbstractExpression::Abstract("short".to_string()),
        generate_expression(
            "-",
            AbstractExpression::Abstract("n".to_string()),
            AbstractExpression::Immediate(1),
        ),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_masked_word_countdown_bounds_its_walk() {
    assert_eq!(ccn_add("n"), Ok(()));
}

#[test]
fn the_same_walk_into_an_output_one_word_short_is_rejected() {
    let err = ccn_add("short").expect_err("the last word lands past the output");
    assert!(err.contains("not provably within region"), "{err}");
}
