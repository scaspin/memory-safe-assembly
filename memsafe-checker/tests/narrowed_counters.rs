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

fn position_walk(body: &[&str], slack: i64) -> Result<(), String> {
    init();
    let mut program: Vec<String> = [
        "start:",
        "mov w7,w5",
        "walk:",
        "lsr w8,w7,#6",
        "add w7,w7,w5",
        "lsr w10,w7,#6",
        "cmp w8,w6",
        "b.ge done",
    ]
    .iter()
    .map(|line| line.to_string())
    .collect();
    program.extend(body.iter().map(|line| line.to_string()));
    program.extend(["b walk", "done:", "ret"].map(str::to_string));
    let mut engine = bums::engine::ExecutionEngine::new(program);
    let symbol = |name: &str| AbstractExpression::Abstract(name.to_string());
    engine.add_abstract_from(2, "top");
    engine.add_region(
        RegionType::READ,
        "top",
        generate_expression("+", symbol("limit"), AbstractExpression::Immediate(slack)),
    );
    engine.add_abstract_from(5, "step");
    engine.add_abstract_from(6, "limit");
    for (op, name, value) in [
        (">=", "step", 1),
        ("<=", "step", 102),
        (">=", "limit", 1),
        ("<=", "limit", 30),
    ] {
        engine.add_invariant(AbstractComparison::new(
            op,
            symbol(name),
            AbstractExpression::Immediate(value),
        ));
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_shifted_word_position_below_its_guard_indexes_the_region() {
    assert_eq!(position_walk(&["ldrb w9,[x2,w8,uxtw]"], 0), Ok(()));
}

#[test]
fn a_shifted_word_position_read_one_past_its_guard_is_rejected() {
    assert!(position_walk(&["ldrh w9,[x2,w8,uxtw]"], 0).is_err());
}

#[test]
fn a_position_one_step_ahead_stays_near_the_guarded_one() {
    assert_eq!(
        position_walk(&["ldrb w9,[x2,w10,uxtw]", "ldrb w9,[x2,w8,uxtw]"], 2),
        Ok(())
    );
}

#[test]
fn a_position_one_step_ahead_can_pass_the_guard() {
    assert!(position_walk(&["ldrb w9,[x2,w10,uxtw]", "ldrb w9,[x2,w8,uxtw]"], 0).is_err());
}

fn symbolic_word_walk(most_rows: i64) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "add x0, x0, #1200",
        "mov w8, #0",
        "sub w8, w8, w1",
        "walk:",
        "ldrb w2, [x0, w8, sxtw]",
        "sub w8, w8, w1",
        "subs w5, w5, #1",
        "b.gt walk",
        "ret",
    ]
    .iter()
    .map(|line| line.to_string())
    .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    let symbol = |name: &str| AbstractExpression::Abstract(name.to_string());
    engine.add_abstract_from(0, "row");
    engine.add_region(RegionType::READ, "row", AbstractExpression::Immediate(1201));
    engine.add_abstract_expression_from(
        1,
        generate_expression(
            "+",
            symbol("dx"),
            generate_expression(
                "*",
                AbstractExpression::Immediate(1 << 32),
                symbol("dx_upper_bits"),
            ),
        ),
    );
    engine.add_abstract_from(5, "rows");
    for (op, name, value) in [
        (">=", "dx", 0),
        ("<=", "dx", 2),
        (">=", "rows", 1),
        ("<=", "rows", most_rows),
    ] {
        engine.add_invariant(AbstractComparison::new(
            op,
            symbol(name),
            AbstractExpression::Immediate(value),
        ));
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_word_walking_down_by_a_symbolic_step_stays_in_its_row() {
    assert_eq!(symbolic_word_walk(600), Ok(()));
}

#[test]
fn a_word_walking_down_by_a_symbolic_step_one_row_too_many_is_rejected() {
    assert!(symbolic_word_walk(601).is_err());
}

fn two_row_walk_with_a_fill_exit(rows_in_region: AbstractExpression) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "mov w7,w5",
        "walk:",
        "lsr w8,w7,#6",
        "add w7,w7,w5",
        "cmp w8,w6",
        "b.ge fill",
        "ldrb w9,[x2,w8,uxtw]",
        "st1 {v16.s}[0], [x0], x1",
        "add w7,w7,w5",
        "subs w4,w4,#2",
        "st1 {v17.s}[0], [x0], x1",
        "b.gt walk",
        "ret",
        "fill:",
        "st1 {v31.s}[0], [x0], x1",
        "subs w4,w4,#2",
        "st1 {v31.s}[0], [x0], x1",
        "b.gt fill",
        "ret",
    ]
    .iter()
    .map(|line| line.to_string())
    .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    let symbol = |name: &str| AbstractExpression::Abstract(name.to_string());
    engine.add_abstract_from(0, "dst");
    engine.add_region(
        RegionType::WRITE,
        "dst",
        generate_expression("*", symbol("stride"), rows_in_region),
    );
    engine.add_abstract_from(1, "stride");
    engine.add_abstract_from(2, "top");
    engine.add_region(RegionType::READ, "top", AbstractExpression::Immediate(64));
    engine.add_abstract_expression_from(
        4,
        generate_expression(
            "%",
            symbol("height"),
            AbstractExpression::Immediate(1 << 32),
        ),
    );
    engine.add_abstract_from(5, "step");
    engine.add_abstract_from(6, "limit");
    for (op, name, value) in [
        (">=", "stride", 4),
        ("<=", "stride", 64),
        (">=", "height", 4),
        ("<=", "height", 12),
        (">=", "step", 0),
        ("<=", "step", 102),
        (">=", "limit", 1),
        ("<=", "limit", 30),
    ] {
        engine.add_invariant(AbstractComparison::new(
            op,
            symbol(name),
            AbstractExpression::Immediate(value),
        ));
    }
    engine.add_invariant(AbstractComparison::new(
        "==",
        symbol("height"),
        generate_expression("*", symbol("pairs"), AbstractExpression::Immediate(2)),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_word_latch_bounds_a_two_row_walk_that_may_leave_from_the_middle() {
    let rows = AbstractExpression::Abstract("height".to_string());
    assert_eq!(two_row_walk_with_a_fill_exit(rows), Ok(()));
}

fn bounded(engine: &bums::engine::ExecutionEngine, name: &str, low: i64, high: i64) {
    for (op, bound) in [(">=", low), ("<=", high)] {
        engine.add_invariant(AbstractComparison::new(
            op,
            abstract_of(name),
            AbstractExpression::Immediate(bound),
        ));
    }
}

fn multiple_of(engine: &bums::engine::ExecutionEngine, name: &str, unit: i64) {
    engine.add_invariant(AbstractComparison::new(
        "==",
        generate_expression("%", abstract_of(name), AbstractExpression::Immediate(unit)),
        AbstractExpression::Immediate(0),
    ));
}

fn rows_of_a_word_countdown(slack: i64) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "sub x3, x3, w6, uxtw",
        "rows:",
        "mov w10, w6",
        "columns:",
        "ld1 { v0.16b }, [x2], #16",
        "subs w10, w10, #16",
        "b.ne columns",
        "add x2, x2, x3",
        "subs w7, w7, #1",
        "b.ne rows",
        "ret",
    ]
    .map(str::to_string)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(2, "src");
    engine.add_region(
        RegionType::READ,
        "src",
        generate_expression(
            "+",
            generate_expression(
                "+",
                generate_expression(
                    "*",
                    generate_expression("-", abstract_of("h"), AbstractExpression::Immediate(1)),
                    abstract_of("stride"),
                ),
                abstract_of("w"),
            ),
            AbstractExpression::Immediate(slack),
        ),
    );
    engine.add_abstract_from(3, "stride");
    engine.add_abstract_from(6, "w");
    engine.add_abstract_from(7, "h");
    bounded(&engine, "w", 16, 4096);
    multiple_of(&engine, "w", 16);
    bounded(&engine, "h", 1, 4096);
    bounded(&engine, "stride", 16, 1 << 20);
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("stride"),
        abstract_of("w"),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn rows_walked_by_an_inner_word_countdown_are_summarized() {
    assert_eq!(rows_of_a_word_countdown(0), Ok(()));
}

fn rows_of_a_word_count_up(slack: i64) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "mov w8, #0",
        "rows:",
        "mov w9, #0",
        "columns:",
        "st1 { v0.8h }, [x7], #16",
        "add w9, w9, #8",
        "cmp w9, w4",
        "b.lt columns",
        "add w8, w8, #2",
        "cmp w8, w5",
        "b.lt rows",
        "ret",
    ]
    .map(str::to_string)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(7, "out");
    engine.add_region(
        RegionType::RW,
        "out",
        generate_expression(
            "+",
            generate_expression("*", abstract_of("width"), abstract_of("height")),
            AbstractExpression::Immediate(slack),
        ),
    );
    engine.add_abstract_from(4, "width");
    engine.add_abstract_from(5, "height");
    bounded(&engine, "width", 8, 64);
    multiple_of(&engine, "width", 8);
    bounded(&engine, "height", 2, 64);
    multiple_of(&engine, "height", 2);
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn rows_walked_by_an_inner_word_count_up_are_summarized() {
    assert_eq!(rows_of_a_word_count_up(0), Ok(()));
}

fn pixel_set(least: i64, slack: i64) -> Result<(), String> {
    init();
    let program: Vec<String> = [
        "start:",
        "dup v0.16b, w1",
        "fill:",
        "subs w2, w2, #0x10",
        "st1 { v0.16b }, [x0], #16",
        "b.gt fill",
        "ret",
    ]
    .map(str::to_string)
    .to_vec();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "out");
    engine.add_region(
        RegionType::RW,
        "out",
        generate_expression("+", abstract_of("n"), AbstractExpression::Immediate(slack)),
    );
    engine.add_abstract_from(1, "px");
    engine.add_abstract_from(2, "n");
    bounded(&engine, "out", 0, i64::MAX);
    bounded(&engine, "px", 0, 255);
    bounded(&engine, "n", least, i64::MAX);
    multiple_of(&engine, "n", 16);
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_signed_word_countdown_fills_its_region_in_blocks() {
    let started = std::time::Instant::now();
    assert_eq!(pixel_set(16, 0), Ok(()));
    assert!(started.elapsed() < std::time::Duration::from_secs(60));
}

#[test]
fn a_signed_word_countdown_into_a_region_one_block_short_is_rejected() {
    let err = pixel_set(64, -16).expect_err("the last block lands past the region");
    assert!(err.contains("not provably within region"), "{err}");
}
