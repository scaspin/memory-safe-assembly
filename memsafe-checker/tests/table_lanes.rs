use bums::common::*;
use bums::engine::ExecutionEngine;

fn taps_then(after_dup: &[&str]) -> Vec<String> {
    let mut asm: Vec<String> = [
        "f:",
        "adrp x9, taps",
        "add x9, x9, :lo12:taps",
        "add x12, x9, x4, lsl #1",
        "ldrb w10, [x12]",
        "dup v0.8h, w10",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();
    asm.extend(after_dup.iter().map(|s| s.to_string()));
    asm.push("ret".into());
    asm.push("\t.section .rodata".into());
    asm.push("taps:".into());
    asm.push("\t.size taps, 32".into());
    for entry in 0..16 {
        let first = if entry == 7 { 20 } else { entry % 8 };
        asm.push(format!("\t.byte {first}"));
        asm.push("\t.byte 1".into());
    }
    asm
}

fn run(asm: Vec<String>) -> std::io::Result<()> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut engine = ExecutionEngine::new(asm);
    engine.add_abstract_from(0, "dst");
    engine.add_region(RegionType::WRITE, "dst", AbstractExpression::Immediate(16));
    engine.add_abstract_from(4, "mx");
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("mx"),
        AbstractExpression::Immediate(0),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        abstract_of("mx"),
        AbstractExpression::Immediate(15),
    ));
    engine.start("f")
}

#[test]
fn a_table_tap_that_only_fills_lanes_needs_no_split() {
    let res = run(taps_then(&["mov w10, #0", "str q0, [x0]"]));
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn a_table_tap_used_as_an_offset_after_filling_lanes_is_still_checked() {
    let res = run(taps_then(&["strb w1, [x0, x10]"]));
    assert!(res.is_err(), "{res:?}");
}

#[test]
fn a_table_tap_whose_every_offset_fits_is_accepted() {
    let mut asm = taps_then(&["strb w1, [x0, x10]"]);
    for line in asm.iter_mut() {
        if line == "\t.byte 20" {
            *line = "\t.byte 15".into();
        }
    }
    let res = run(asm);
    assert!(res.is_ok(), "{res:?}");
}
