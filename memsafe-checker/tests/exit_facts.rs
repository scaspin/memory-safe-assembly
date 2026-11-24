use bums::common::*;
use bums::engine::ExecutionEngine;

fn analyze_with_slack(lines: &[&str], slack: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut program = vec!["start:".to_string(), "mov x0,#0".to_string()];
    program.extend(lines.iter().map(|line| line.to_string()));
    let mut engine = ExecutionEngine::new(program);
    engine.add_abstract_from(1, "buf");
    engine.add_abstract_from(2, "len");
    engine.add_region(
        RegionType::READ,
        "buf",
        generate_expression(
            "+",
            abstract_of("len"),
            AbstractExpression::Immediate(slack),
        ),
    );
    engine.add_abstract_from(7, "flags");
    engine.add_abstract_from(6, "flen");
    engine.add_region(RegionType::READ, "flags", abstract_of("flen"));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("len"),
        AbstractExpression::Immediate(16),
    ));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("flen"),
        AbstractExpression::Immediate(1),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<",
        abstract_of("flen"),
        AbstractExpression::Immediate(1 << 20),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<",
        abstract_of("len"),
        AbstractExpression::Immediate(1 << 20),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

fn analyze(lines: &[&str]) -> Result<(), String> {
    analyze_with_slack(lines, 1)
}

fn assert_rejected(res: Result<(), String>) {
    assert!(res.is_err(), "unsafe loop accepted");
}

fn assert_accepted(res: Result<(), String>) {
    assert!(res.is_ok(), "{res:?}");
}

fn flag_guarded_check(guard: &str) -> Vec<&str> {
    vec![
        "loop:",
        "ldrb w5,[x7,x0]",
        guard,
        "cmp x0,x2",
        "b.hs out",
        "skip:",
        "ldrb w3,[x1,x0]",
        "add x0,x0,#1",
        "cmp x0,x6",
        "b.lo loop",
        "out:",
        "ret",
    ]
}

#[test]
fn an_exit_behind_a_loaded_flag_does_not_bound_later_iterations() {
    assert_rejected(analyze(&flag_guarded_check("cbz w5,skip")));
}

#[test]
fn an_exit_behind_a_nonzero_flag_does_not_bound_later_iterations() {
    assert_rejected(analyze(&flag_guarded_check("cbnz w5,skip")));
}

#[test]
fn an_exit_taken_every_iteration_bounds_the_walk() {
    assert_accepted(analyze(&flag_guarded_check("nop")));
}

fn parity_guarded_check(guard: &str) -> Vec<&str> {
    vec![
        "loop:",
        "tst x0,#1",
        guard,
        "cmp x0,x2",
        "b.hs out",
        "skip:",
        "ldrb w3,[x1,x0]",
        "add x0,x0,#1",
        "cmp x0,x6",
        "b.lo loop",
        "out:",
        "ret",
    ]
}

#[test]
fn an_exit_checked_on_even_iterations_does_not_bound_odd_ones() {
    assert_rejected(analyze_with_slack(&parity_guarded_check("b.ne skip"), 0));
}

#[test]
fn an_exit_checked_on_odd_iterations_does_not_bound_even_ones() {
    assert_rejected(analyze_with_slack(&parity_guarded_check("b.eq skip"), 0));
}

fn equality_chain<'a>(guard: &[&'a str]) -> Vec<&'a str> {
    let mut program = vec!["loop:", "ldrb w5,[x1,x0]", "add x0,x0,#1"];
    program.extend(guard);
    program.extend([
        "cmp x0,x2",
        "b.eq out",
        "skip:",
        "add x0,x0,#1",
        "cmp x0,x2",
        "b.eq out",
        "b loop",
        "out:",
        "ret",
    ]);
    program
}

#[test]
fn an_equality_exit_skipped_by_a_branch_lets_the_walk_step_over_its_bound() {
    assert_rejected(analyze(&equality_chain(&["cbz w5,skip"])));
}

#[test]
fn an_equality_exit_skipped_on_odd_iterations_lets_the_walk_step_over_its_bound() {
    assert_rejected(analyze(&equality_chain(&["tbnz x0,#1,skip"])));
}

#[test]
fn an_equality_chain_checked_every_iteration_bounds_the_walk() {
    assert_accepted(analyze(&equality_chain(&[])));
}

fn threshold_guarded_check() -> Vec<&'static str> {
    vec![
        "loop:",
        "cmp x0,#8",
        "b.hs skip",
        "cmp x0,x2",
        "b.hs out",
        "skip:",
        "ldrb w3,[x1,x0]",
        "add x0,x0,#1",
        "cmp x0,x6",
        "b.lo loop",
        "out:",
        "ret",
    ]
}

#[test]
fn an_exit_checked_only_on_early_iterations_does_not_bound_later_ones() {
    assert_rejected(analyze(&threshold_guarded_check()));
}

#[test]
fn an_equality_exit_skipped_only_on_later_iterations_lets_the_walk_step_over_its_bound() {
    assert_rejected(analyze(&equality_chain(&["cmp x0,#9", "b.hs skip"])));
}

#[test]
fn an_exit_that_tests_a_lagging_copy_on_some_paths_does_not_bound_the_walk() {
    assert_rejected(analyze(&[
        "loop:",
        "ldrb w5,[x7,x0]",
        "mov x9,x0",
        "cbz w5,check",
        "sub x9,x9,#4",
        "check:",
        "cmp x9,x2",
        "b.hs out",
        "ldrb w3,[x1,x0]",
        "add x0,x0,#1",
        "cmp x0,x6",
        "b.lo loop",
        "out:",
        "ret",
    ]));
}
