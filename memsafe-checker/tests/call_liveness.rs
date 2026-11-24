use bums::common::*;

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn rows_with_a_lookup_helper(helper: &[&str], table_bytes: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut lines = vec![
        "start:",
        "stp x29, x30, [sp, #-16]!",
        "row:",
        "ld1 {v0.8h}, [x0], #16",
        "bl lookup",
        "subs w4, w4, #1",
        "b.gt row",
        "ldp x29, x30, [sp], #16",
        "ret",
        "lookup:",
    ];
    lines.extend(helper);
    lines.push("ret");
    let mut engine =
        bums::engine::ExecutionEngine::new(lines.iter().map(|l| l.to_string()).collect::<Vec<_>>());
    engine.add_abstract_from(0, "rows");
    engine.add_region(
        RegionType::READ,
        "rows",
        generate_expression("*", symbol("height"), AbstractExpression::Immediate(16)),
    );
    engine.add_abstract_from(3, "table");
    engine.add_region(
        RegionType::READ,
        "table",
        AbstractExpression::Immediate(table_bytes),
    );
    engine.add_abstract_from(14, "cursor");
    engine.add_abstract_from(4, "height");
    for (op, value) in [(">=", 1), ("<=", 64)] {
        engine.add_invariant(AbstractComparison::new(
            op,
            symbol("height"),
            AbstractExpression::Immediate(value),
        ));
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_scratch_pointer_the_callee_overwrites_does_not_stop_the_loop_summary() {
    let helper = [
        "umov w14, v0.h[0]",
        "and w14, w14, #255",
        "add x14, x14, x3",
        "ldrb w15, [x14]",
    ];
    assert_eq!(rows_with_a_lookup_helper(&helper, 256), Ok(()));
}

#[test]
fn a_pointer_the_callee_reads_and_advances_stays_live() {
    let verdict = rows_with_a_lookup_helper(&["ldrb w15, [x3], #1"], 16);
    assert!(
        verdict.as_ref().is_err_and(|e| e.contains("ldrb")),
        "{verdict:?}"
    );
}

#[test]
fn a_lookup_past_a_short_table_is_rejected() {
    let helper = [
        "umov w14, v0.h[0]",
        "and w14, w14, #255",
        "add x14, x14, x3",
        "ldrb w15, [x14]",
    ];
    let verdict = rows_with_a_lookup_helper(&helper, 128);
    assert!(
        verdict.as_ref().is_err_and(|e| e.contains("ldrb")),
        "{verdict:?}"
    );
}
