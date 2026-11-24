use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn run(body: &[&str]) -> Result<(), String> {
    init();
    let mut program = vec!["start:".to_string()];
    program.extend(body.iter().map(|line| line.to_string()));

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Immediate(16),
    );
    engine.add_abstract_from(1, "index".to_string());
    engine.add_invariant(AbstractComparison::new(
        ">=",
        AbstractExpression::Abstract("index".to_string()),
        AbstractExpression::Immediate(0),
    ));
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

const TWO_WAY: &[&str] = &[
    "cmp x1, #8",
    "b.hi big",
    "ldrb w2,[x0,x1]",
    "ret",
    "big:",
    "ldrb w2,[x0,x1]",
    "ret",
];

#[test]
fn a_branch_constraint_does_not_reach_its_sibling() {
    let error = run(TWO_WAY).expect_err("the unbounded side cannot be proved");
    assert!(
        error.contains("not provably within"),
        "expected a bounds failure, got: {error}"
    );
    assert!(
        !error.contains("no model"),
        "the sibling saw a contradictory path, so a scope outlived its branch: {error}"
    );
}

#[test]
fn both_sides_of_a_branch_keep_the_preconditions() {
    assert!(
        run(&[
            "cmp x1, #8",
            "b.hi big",
            "ldrb w2,[x0,#1]",
            "ret",
            "big:",
            "ldrb w2,[x0,#2]",
            "ret",
        ])
        .is_ok()
    );
}

#[test]
fn a_bound_proved_on_one_side_is_used_there() {
    assert!(
        run(&[
            "cmp x1, #8",
            "b.hi out",
            "ldrb w2,[x0,x1]",
            "ret",
            "out:",
            "ret",
        ])
        .is_ok()
    );
}

#[test]
fn a_widened_pointer_is_still_measured_against_its_region() {
    init();
    let program: Vec<String> = [
        "start:",
        "loop:",
        "add x0, x0, x3",
        "add x0, x0, #8",
        "str x1, [x0]",
        "subs x4, x4, #1",
        "b.ne loop",
        "ret",
    ]
    .iter()
    .map(|l| l.to_string())
    .collect();

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Immediate(1024),
    );
    engine.add_abstract_from(3, "stride".to_string());
    engine.add_abstract_from(4, "count".to_string());
    for (register, op, value) in [
        ("stride", ">=", 1i64),
        ("stride", "<=", 8),
        ("count", ">=", 1),
        ("count", "<=", 1000),
    ] {
        engine.add_invariant(AbstractComparison::new(
            op,
            AbstractExpression::Abstract(register.to_string()),
            AbstractExpression::Immediate(value),
        ));
    }

    let error = engine
        .start("start".to_string())
        .expect_err("a thousand nine-byte steps leave a 1024-byte region")
        .to_string();
    assert!(
        error.contains("within region of length 1024"),
        "the widened pointer was not measured against its region: {error}"
    );
}

#[test]
fn an_element_fact_binds_where_it_was_placed() {
    init();
    let read_at = |opcode: &str| {
        let program: Vec<String> = ["start:", opcode, "add x0, x0, x9", "ldrb w2, [x0]", "ret"]
            .iter()
            .map(|l| l.to_string())
            .collect();
        let mut engine = bums::engine::ExecutionEngine::new(program);
        engine.add_abstract_from(0, "base".to_string());
        engine.add_region(
            RegionType::RW,
            "base".to_string(),
            AbstractExpression::Immediate(64),
        );
        engine.add_element_fact("base", 4, 4, "base[4]");
        for (op, v) in [(">=", 0i64), ("<=", 3)] {
            engine.add_invariant(AbstractComparison::new(
                op,
                AbstractExpression::Abstract("base[4]".to_string()),
                AbstractExpression::Immediate(v),
            ));
        }
        let result = engine.start("start".to_string());
        (result.is_ok(), engine.unread_element_facts())
    };

    let (ok, unread) = read_at("ldr w9, [x0, #16]");
    assert!(ok, "the bounded element did not make the access provable");
    assert!(unread.is_empty(), "reported unread: {unread:?}");

    let (ok, unread) = read_at("ldrh w9, [x0, #16]");
    assert!(ok, "a narrower load lost the bound");
    assert!(unread.is_empty(), "reported unread: {unread:?}");

    let (ok, unread) = read_at("ldr w9, [x0, #20]");
    assert!(!ok, "an unbounded index was accepted");
    assert_eq!(unread, vec!["base[4]".to_string()]);
}

#[test]
fn a_stack_argument_read_as_a_word_keeps_its_bound() {
    init();
    let program: Vec<String> = [
        "start:",
        "ldr w9, [sp, #8]",
        "add x0, x0, w9, uxtw #2",
        "ldrb w2, [x0]",
        "ret",
    ]
    .iter()
    .map(|l| l.to_string())
    .collect();

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Immediate(64),
    );
    engine.add_abstract_from(9, "ty".to_string());
    for (op, v) in [(">=", 0i64), ("<=", 3)] {
        engine.add_invariant(AbstractComparison::new(
            op,
            AbstractExpression::Abstract("ty".to_string()),
            AbstractExpression::Immediate(v),
        ));
    }

    assert!(
        engine.start("start".to_string()).is_ok(),
        "the bound on the stack argument did not reach the index"
    );
}

#[test]
fn an_untranslatable_address_is_reported_not_fatal() {
    init();
    let program: Vec<String> = [
        "start:",
        "eor x9, x1, x2",
        "add x0, x0, x9",
        "ldrb w3, [x0]",
        "ret",
    ]
    .iter()
    .map(|l| l.to_string())
    .collect();

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Immediate(64),
    );
    engine.add_abstract_from(1, "one".to_string());
    engine.add_abstract_from(2, "two".to_string());

    let error = engine
        .start("start".to_string())
        .expect_err("an xor of two unknowns cannot be placed")
        .to_string();
    assert!(
        error.contains("does not model"),
        "expected an unsupported-operation report, got: {error}"
    );
}

#[test]
fn an_inexpressible_branch_condition_explores_both_sides() {
    assert!(
        run(&[
            "eor x9, x1, x2",
            "cmp x9, #4",
            "b.hi big",
            "ldrb w3,[x0,#1]",
            "ret",
            "big:",
            "ldrb w3,[x0,#2]",
            "ret",
        ])
        .is_ok()
    );
    let error = run(&[
        "eor x9, x1, x2",
        "cmp x9, #4",
        "b.hi big",
        "ldrb w3,[x0,#1]",
        "ret",
        "big:",
        "ldrb w3,[x0,#16]",
        "ret",
    ])
    .expect_err("the side past the region is explored");
    assert!(error.contains("not provably within"), "{error}");
}
