use bums::common::*;

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn refill_loop(guard: &[&str], advance: &[&str]) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut lines = vec!["start:", "refill:", "ldp x3, x4, [x0]"];
    lines.extend(guard);
    lines.push("ldr x8, [x3]");
    lines.extend(advance);
    lines.extend([
        "str x3, [x0]",
        "skip:",
        "subs w1, w1, #1",
        "b.ne refill",
        "ret",
    ]);
    let mut engine =
        bums::engine::ExecutionEngine::new(lines.iter().map(|l| l.to_string()).collect::<Vec<_>>());
    engine.add_abstract_from(0, "state");
    engine.add_region(RegionType::RW, "state", AbstractExpression::Immediate(16));
    engine.add_region(RegionType::READ, "data", symbol("len"));
    engine.add_abstract_from(1, "rounds");
    engine.add_abstract_from(2, "step");
    let cursor = generate_expression("+", symbol("data"), symbol("pos"));
    let end = generate_expression("+", symbol("data"), symbol("len"));
    engine.add_field("state", 0, 8, cursor)?;
    engine.add_field("state", 8, 8, end)?;
    for (op, left, right) in [
        (">=", symbol("len"), AbstractExpression::Immediate(8)),
        (">=", symbol("pos"), AbstractExpression::Immediate(0)),
        ("<=", symbol("pos"), symbol("len")),
        (">=", symbol("rounds"), AbstractExpression::Immediate(1)),
    ] {
        engine.add_invariant(AbstractComparison::new(op, left, right));
    }
    engine.start("start").map_err(|e| e.to_string())
}

const GUARDED: [&str; 3] = ["add x5, x3, #8", "cmp x5, x4", "b.hi skip"];

#[test]
fn a_stored_cursor_that_only_moves_forward_keeps_its_region() {
    let advance = ["and x9, x2, #7", "add x3, x3, x9"];
    assert_eq!(refill_loop(&GUARDED, &advance), Ok(()));
}

#[test]
fn a_stored_cursor_that_moves_backward_is_rejected() {
    let advance = ["and x9, x2, #7", "sub x3, x3, x9"];
    let verdict = refill_loop(&GUARDED, &advance);
    assert!(
        verdict.as_ref().is_err_and(|e| e.contains("ldr")),
        "{verdict:?}"
    );
}

#[test]
fn a_forward_cursor_read_past_its_end_is_rejected() {
    let guard = ["cmp x3, x4", "b.hs skip"];
    let advance = ["and x9, x2, #7", "add x3, x3, x9"];
    let verdict = refill_loop(&guard, &advance);
    assert!(
        verdict.as_ref().is_err_and(|e| e.contains("ldr")),
        "{verdict:?}"
    );
}
