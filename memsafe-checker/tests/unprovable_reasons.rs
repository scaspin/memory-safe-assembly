// An access that violates neither bound is proved only when the path it sits on can
// actually happen. These pin the outcomes apart: proved, out of bounds, and nothing
// proved at all because the path has no model.

use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn analyze(bounds: &[AbstractComparison], access: &str) -> Result<(), String> {
    init();
    let program = vec!["start:".to_string(), access.to_string(), "ret".to_string()];
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Abstract("length".to_string()),
    );
    for bound in bounds {
        engine.add_invariant(bound.clone());
    }
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

fn length_is(n: i64) -> AbstractComparison {
    AbstractComparison::new(
        "==",
        AbstractExpression::Abstract("length".to_string()),
        AbstractExpression::Immediate(n),
    )
}

#[test]
fn an_access_inside_the_region_is_proved() {
    assert!(analyze(&[length_is(8)], "ldr x1,[x0]").is_ok());
}

#[test]
fn an_access_past_the_region_names_the_region() {
    let err = analyze(&[length_is(8)], "ldr x1,[x0,#8]").expect_err("out of bounds");
    assert!(
        err.contains("not provably within region"),
        "unexpected report: {err}"
    );
}

// Both bound queries come back unsat on a path that cannot happen, which proves
// nothing. Saying so is the point: contradictory facts are a bug in the analysis,
// and reading them as a safe access is how a vacuous proof slips through.
#[test]
fn contradictory_facts_report_a_dead_path() {
    let err = analyze(&[length_is(8), length_is(9)], "ldr x1,[x0]").expect_err("dead path");
    assert!(
        err.contains("path has no model"),
        "unexpected report: {err}"
    );
}

// An undecided path is a different thing from an impossible one, and must not be
// reported as one. The wording is pinned by the unit tests on `unproved_reason`;
// this checks the two messages cannot be confused.
#[test]
fn the_dead_path_report_does_not_claim_the_solver_gave_up() {
    let err = analyze(&[length_is(8), length_is(9)], "ldr x1,[x0]").expect_err("dead path");
    assert!(
        !err.contains("solver did not decide"),
        "dead path reported as undecided: {err}"
    );
}
