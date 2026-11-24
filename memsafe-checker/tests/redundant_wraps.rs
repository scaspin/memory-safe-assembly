use bums::common::*;
use std::str::FromStr;
use z3::SatResult;
use z3::ast::Int;

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn imm(value: i64) -> AbstractExpression {
    AbstractExpression::Immediate(value)
}

fn big(value: u128) -> Int {
    Int::from_str(&value.to_string()).expect("constant")
}

fn always_equal(left: &Int, right: &Int) -> bool {
    let solver = z3::Solver::new();
    solver.check_assumptions(&[left.eq(right).not()]) == SatResult::Unsat
}

fn loaded_word(name: &str) -> AbstractExpression {
    generate_expression(
        "atmost",
        generate_expression("atleast", symbol(name), imm(0)),
        imm(u32::MAX as i64),
    )
}

fn clamped_word(x: &Int) -> Int {
    let zero = Int::from_i64(0);
    let most = Int::from_i64(u32::MAX as i64);
    let floored = x.lt(&zero).ite(&zero, x);
    floored.gt(&most).ite(&most, &floored)
}

#[test]
fn a_shifted_loaded_word_translates_to_its_full_wrapped_meaning() {
    let word = generate_expression("%", loaded_word("m"), imm(1 << 32));
    let shifted = generate_expression("%", generate_expression("lsr", word, imm(4)), imm(1 << 32));
    let twice = generate_expression("lsr", shifted, imm(4));
    let translated = expression_to_ast(twice).expect("translatable");
    let m = Int::new_const("m");
    let wrap = |x: &Int, bits: u32| x.modulo(big(1u128 << bits));
    let reference = wrap(
        &wrap(&wrap(&clamped_word(&m), 32), 64).div(Int::from_i64(16)),
        32,
    );
    let reference = wrap(&reference, 64).div(Int::from_i64(16));
    assert!(always_equal(&translated, &reference));
}

#[test]
fn a_shift_of_a_possibly_negative_value_keeps_its_wrap() {
    let shifted = generate_expression("lsr", generate_expression("-", symbol("n"), imm(5)), imm(4));
    let translated = expression_to_ast(shifted).expect("translatable");
    let n = Int::new_const("n");
    let solver = z3::Solver::new();
    solver.assert(n.eq(Int::from_i64(0)));
    solver.assert(translated.eq(big(((1u128 << 64) - 5) >> 4)).not());
    assert_eq!(solver.check(), SatResult::Unsat);
}

#[test]
fn a_remainder_of_a_value_that_can_exceed_the_modulus_is_kept() {
    let floored = generate_expression("atleast", symbol("k"), imm(0));
    let translated =
        expression_to_ast(generate_expression("%", floored, imm(16))).expect("translatable");
    let k = Int::new_const("k");
    let solver = z3::Solver::new();
    solver.assert(k.eq(Int::from_i64(20)));
    solver.assert(translated.eq(Int::from_i64(4)).not());
    assert_eq!(solver.check(), SatResult::Unsat);
}

#[test]
fn a_mask_of_a_negative_value_is_kept() {
    let translated = expression_to_ast(generate_expression(
        "&",
        generate_expression("atmost", symbol("v"), imm(3)),
        imm(15),
    ))
    .expect("translatable");
    let v = Int::new_const("v");
    let solver = z3::Solver::new();
    solver.assert(v.eq(Int::from_i64(-1)));
    solver.assert(translated.eq(Int::from_i64(15)).not());
    assert_eq!(solver.check(), SatResult::Unsat);
}

fn rows_walked_by_three_loaded_masks(rows: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let lines = [
        "start:",
        "mov x11, x30",
        "ldp w6, w7, [x2]",
        "ldr w2, [x2, #8]",
        "orr w7, w7, w2",
        "orr w6, w6, w7",
        "row:",
        "tst w6, #0xf",
        "b.eq skip",
        "tst w2, #0xf",
        "b.eq narrow",
        "bl read_wide",
        "b skip",
        "narrow:",
        "tst w7, #0xf",
        "b.eq skip",
        "bl read_narrow",
        "skip:",
        "lsr w6, w6, #4",
        "lsr w7, w7, #4",
        "lsr w2, w2, #4",
        "add x0, x0, #16",
        "cbnz w6, row",
        "ret x11",
        "read_wide:",
        "ldr q0, [x0]",
        "ret",
        "read_narrow:",
        "ldr d0, [x0, #8]",
        "ret",
    ];
    let mut engine =
        bums::engine::ExecutionEngine::new(lines.iter().map(|l| l.to_string()).collect::<Vec<_>>());
    engine.add_abstract_from(0, "rows");
    engine.add_region(RegionType::RW, "rows", imm(rows * 16));
    engine.add_abstract_from(2, "masks");
    engine.add_region(RegionType::READ, "masks", imm(12));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_walk_over_three_loaded_words_stays_within_eight_rows() {
    assert_eq!(rows_walked_by_three_loaded_masks(8), Ok(()));
}

#[test]
fn a_walk_over_three_loaded_words_past_seven_rows_is_rejected() {
    let verdict = rows_walked_by_three_loaded_masks(7);
    assert!(
        verdict.as_ref().is_err_and(|e| e.contains("ldr")),
        "{verdict:?}"
    );
}
