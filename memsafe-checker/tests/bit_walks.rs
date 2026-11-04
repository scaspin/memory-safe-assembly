use bums::common::*;

fn symbol(name: &str) -> AbstractExpression {
    AbstractExpression::Abstract(name.to_string())
}

fn rows_selected_by_two_masks(read_row: &[&str], mask_limit: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut lines = vec![
        "start:",
        "mov x11, x30",
        "orr w6, w2, w3",
        "row:",
        "tst w6, #3",
        "b.eq skip",
    ];
    lines.extend(read_row);
    lines.extend([
        "skip:",
        "add x0, x0, #8",
        "lsr w6, w6, #2",
        "cbnz w6, row",
        "ret x11",
        "read_row:",
        "ldr x8, [x0]",
        "ret",
    ]);
    let mut engine =
        bums::engine::ExecutionEngine::new(lines.iter().map(|l| l.to_string()).collect::<Vec<_>>());
    engine.add_abstract_from(0, "rows");
    engine.add_region(RegionType::READ, "rows", AbstractExpression::Immediate(64));
    engine.add_abstract_from(2, "first_mask");
    engine.add_abstract_from(3, "second_mask");
    for mask in ["first_mask", "second_mask"] {
        for (op, value) in [(">=", 0), ("<=", mask_limit)] {
            engine.add_invariant(AbstractComparison::new(
                op,
                symbol(mask),
                AbstractExpression::Immediate(value),
            ));
        }
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_walk_over_two_sixteen_bit_masks_stays_within_eight_rows() {
    assert_eq!(rows_selected_by_two_masks(&["ldr x8, [x0]"], 65535), Ok(()));
}

#[test]
fn a_walk_over_a_seventeen_bit_mask_reaching_a_ninth_row_is_rejected() {
    let verdict = rows_selected_by_two_masks(&["ldr x8, [x0]"], 131071);
    assert!(
        verdict.as_ref().is_err_and(|e| e.contains("ldr")),
        "{verdict:?}"
    );
}

fn rows_read_through_two_call_sites(rows: i64, mask_limit: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let lines = [
        "start:",
        "mov x11, x30",
        "row:",
        "tst w6, #1",
        "b.eq skip",
        "tst w7, #1",
        "b.eq narrow",
        "bl read_wide",
        "b skip",
        "narrow:",
        "bl read_narrow",
        "skip:",
        "add x0, x0, #8",
        "lsr w6, w6, #1",
        "lsr w7, w7, #1",
        "cbnz w6, row",
        "ret x11",
        "read_wide:",
        "ldr x8, [x0]",
        "ret",
        "read_narrow:",
        "ldr w8, [x0]",
        "ret",
    ];
    let mut engine =
        bums::engine::ExecutionEngine::new(lines.iter().map(|l| l.to_string()).collect::<Vec<_>>());
    engine.add_abstract_from(0, "rows");
    engine.add_region(
        RegionType::READ,
        "rows",
        AbstractExpression::Immediate(rows * 8),
    );
    engine.add_abstract_from(6, "selected");
    engine.add_abstract_from(7, "wide");
    for mask in ["selected", "wide"] {
        for (op, value) in [(">=", 0), ("<=", mask_limit)] {
            engine.add_invariant(AbstractComparison::new(
                op,
                symbol(mask),
                AbstractExpression::Immediate(value),
            ));
        }
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn rows_read_through_two_call_sites_stay_within_the_walk() {
    assert_eq!(rows_read_through_two_call_sites(16, 65535), Ok(()));
}

#[test]
fn calls_inside_a_walk_past_its_rows_are_rejected() {
    let verdict = rows_read_through_two_call_sites(15, 65535);
    assert!(
        verdict.as_ref().is_err_and(|e| e.contains("ldr")),
        "{verdict:?}"
    );
}
