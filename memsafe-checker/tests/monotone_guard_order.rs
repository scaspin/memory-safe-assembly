use bums::common::*;
use bums::engine::ExecutionEngine;

fn abs(n: &str) -> AbstractExpression {
    AbstractExpression::Abstract(n.to_string())
}
fn imm(v: i64) -> AbstractExpression {
    AbstractExpression::Immediate(v)
}
fn at_least(name: &str, value: i64) -> AbstractComparison {
    AbstractComparison::new(">=", abs(name), imm(value))
}
fn elements(count: AbstractExpression) -> AbstractExpression {
    generate_expression("*", count, imm(8))
}

const ORDERED: ([&str; 2], [&str; 2]) = (["cmp x8,x2", "b.hs done"], ["cmp x8,x7", "b.lo loop"]);

fn two_guards(
    start_at: i64,
    step: i64,
    second_extent: AbstractExpression,
    bounds: &[AbstractComparison],
) -> Result<(), String> {
    two_guards_shaped(
        (["cmp x2,x8", "b.eq done"], ["cmp x7,x8", "b.ne loop"]),
        start_at,
        step,
        second_extent,
        bounds,
    )
}

fn two_guards_shaped(
    (head, back_edge): ([&str; 2], [&str; 2]),
    start_at: i64,
    step: i64,
    second_extent: AbstractExpression,
    bounds: &[AbstractComparison],
) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut program = vec!["start:".to_string(), format!("mov x8,#{start_at}")];
    program.push("loop:".to_string());
    program.extend(head.iter().map(|l| l.to_string()));
    program.extend(
        [
            "cmp x3,x8",
            "b.eq done",
            "ldr x4,[x1]",
            "ldr x5,[x6]",
            "add x1,x1,#8",
            "add x6,x6,#8",
        ]
        .iter()
        .map(|l| l.to_string()),
    );
    program.push(format!("add x8,x8,#{step}"));
    program.extend(
        back_edge
            .iter()
            .chain(&["done:", "ret"])
            .map(|l| l.to_string()),
    );

    let mut e = ExecutionEngine::new(program);
    e.add_abstract_from(1, "first".to_string());
    e.add_region(
        RegionType::READ,
        "first".to_string(),
        elements(abs("count")),
    );
    e.add_abstract_from(2, "count".to_string());
    e.add_invariant(at_least("count", start_at + 1));
    e.add_abstract_from(6, "second".to_string());
    e.add_region(
        RegionType::READ,
        "second".to_string(),
        elements(second_extent),
    );
    e.add_abstract_from(3, "limit".to_string());
    e.add_abstract_from(7, "rounds".to_string());
    e.add_invariant(AbstractComparison::new(">=", abs("rounds"), abs("count")));
    e.add_invariant(AbstractComparison::new(">=", abs("rounds"), abs("limit")));
    for bound in bounds {
        e.add_invariant(bound.clone());
    }
    e.start("start".to_string()).map_err(|e| e.to_string())
}

#[test]
fn a_second_guard_bounds_its_own_walk() {
    let res = two_guards(0, 1, abs("limit"), &[]);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn a_second_guard_does_not_cover_one_element_more() {
    let short = generate_expression("-", abs("limit"), imm(1));
    let err = two_guards(0, 1, short, &[at_least("limit", 2)])
        .expect_err("the last iteration reads one element past the second slice");
    assert!(
        err.contains("not provably within region"),
        "expected a read past the second slice, got: {err}"
    );
}

#[test]
fn a_walk_that_may_start_past_the_bound_gets_no_ordering() {
    let err = two_guards(4, 1, abs("limit"), &[at_least("limit", 1)])
        .expect_err("a bound the walk may already be past bounds nothing");
    assert!(
        err.contains("not provably within region"),
        "expected the second walk to be unbounded, got: {err}"
    );
}

#[test]
fn a_walk_of_two_at_a_time_gets_no_ordering() {
    let err = two_guards(0, 2, abs("limit"), &[at_least("limit", 1)])
        .expect_err("a step of two can pass the bound without landing on it");
    assert!(
        err.contains("not provably within region"),
        "expected the second walk to be unbounded, got: {err}"
    );
}

#[test]
fn a_second_guard_bounds_its_own_walk_under_ordered_guards() {
    let res = two_guards_shaped(ORDERED, 0, 1, abs("limit"), &[]);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn ordered_guards_do_not_cover_one_element_more() {
    let short = generate_expression("-", abs("limit"), imm(1));
    let err = two_guards_shaped(ORDERED, 0, 1, short, &[at_least("limit", 2)])
        .expect_err("the last iteration reads one element past the second slice");
    assert!(
        err.contains("not provably within region"),
        "expected a read past the second slice, got: {err}"
    );
}

#[test]
fn ordered_guards_with_a_walk_that_may_start_past_the_bound_gets_no_ordering() {
    let err = two_guards_shaped(ORDERED, 4, 1, abs("limit"), &[at_least("limit", 1)])
        .expect_err("a bound the walk may already be past bounds nothing");
    assert!(
        err.contains("not provably within region"),
        "expected the second walk to be unbounded, got: {err}"
    );
}

fn guard_behind_a_branch(selector: &[&str]) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut program: Vec<String> = ["start:", "mov x8,#0", "loop:", "cmp x2,x8", "b.eq done"]
        .iter()
        .map(|l| l.to_string())
        .collect();
    program.extend(selector.iter().map(|l| l.to_string()));
    program.extend(
        [
            "cbz x9,skip",
            "cmp x3,x8",
            "b.eq done",
            "ldr x5,[x6]",
            "skip:",
            "ldr x4,[x1]",
            "add x1,x1,#8",
            "add x6,x6,#8",
            "add x8,x8,#1",
            "cmp x7,x8",
            "b.ne loop",
            "done:",
            "ret",
        ]
        .iter()
        .map(|l| l.to_string()),
    );

    let mut e = ExecutionEngine::new(program);
    e.add_abstract_from(0, "skips".to_string());
    e.add_region(
        RegionType::READ,
        "skips".to_string(),
        elements(abs("count")),
    );
    e.add_abstract_from(1, "first".to_string());
    e.add_region(
        RegionType::READ,
        "first".to_string(),
        elements(abs("count")),
    );
    e.add_abstract_from(2, "count".to_string());
    e.add_invariant(at_least("count", 1));
    e.add_abstract_from(6, "second".to_string());
    e.add_region(
        RegionType::READ,
        "second".to_string(),
        elements(abs("limit")),
    );
    e.add_abstract_from(3, "limit".to_string());
    e.add_invariant(at_least("limit", 1));
    e.add_abstract_from(9, "runs_the_guard".to_string());
    e.add_abstract_from(7, "rounds".to_string());
    e.add_invariant(AbstractComparison::new(">=", abs("rounds"), abs("count")));
    e.add_invariant(AbstractComparison::new(">=", abs("rounds"), abs("limit")));
    e.start("start".to_string()).map_err(|e| e.to_string())
}

#[test]
fn a_guard_behind_a_branch_gets_no_ordering() {
    let err = guard_behind_a_branch(&["ldr x9,[x0],#8"])
        .expect_err("a guard an iteration can skip bounds nothing");
    assert!(
        err.contains("not provably within region"),
        "expected the second walk to be unbounded, got: {err}"
    );
}

#[test]
fn a_guard_behind_a_branch_that_never_changes_bounds_its_walk() {
    let res = guard_behind_a_branch(&[]);
    assert!(res.is_ok(), "{res:?}");
}
