use bums::common::*;
use bums::engine::ExecutionEngine;

fn dispatch(wide_case_offset: u32) -> Vec<String> {
    let mut asm: Vec<String> = [
        "f:",
        "clz w3, w3",
        "adrp x5, tbl",
        "add x5, x5, :lo12:tbl",
        "sub w3, w3, #27",
        "ldrsw x3, [x5, w3, uxtw #2]",
        "add x5, x5, x3",
        "br x5",
    ]
    .iter()
    .map(|s| s.to_string())
    .collect();
    asm.push("L_w16:".into());
    asm.push(format!("strb w1, [x0, #{wide_case_offset}]"));
    asm.push("ret".into());
    for (label, last) in [("L_w8", 7), ("L_w4", 3)] {
        asm.push(format!("{label}:"));
        asm.push(format!("strb w1, [x0, #{last}]"));
        asm.push("ret".into());
    }
    for line in [
        "\t.section .rodata",
        "tbl:",
        "\t.size tbl, 12",
        "\t.word L_w16 - tbl",
        "\t.word L_w8 - tbl",
        "\t.word L_w4 - tbl",
    ] {
        asm.push(line.into());
    }
    asm
}

fn run(asm: Vec<String>, max_width: i64) -> std::io::Result<()> {
    let mut engine = ExecutionEngine::new(asm);
    engine.add_abstract_from(0, "dst");
    engine.add_region(RegionType::WRITE, "dst", abstract_of("width"));
    engine.add_abstract_from(3, "width");
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("width"),
        AbstractExpression::Immediate(4),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        abstract_of("width"),
        AbstractExpression::Immediate(max_width),
    ));
    engine.start("f")
}

#[test]
fn each_case_writes_within_its_width_class() {
    let res = run(dispatch(15), 31);
    assert!(res.is_ok(), "{res:?}");
}

#[test]
fn a_case_writing_past_its_width_class_is_caught() {
    assert!(run(dispatch(31), 31).is_err());
}

#[test]
fn a_width_past_the_table_reads_outside_it() {
    let err = run(dispatch(15), 63).unwrap_err().to_string();
    assert!(err.contains("tbl"), "{err}");
}

fn indirect_call(callee_offset: u32, after_call_offset: u32) -> Vec<String> {
    [
        "wrapper:".to_string(),
        "mov x15, x30".into(),
        "adr x4, transform".into(),
        "b body".into(),
        "body:".into(),
        "blr x4".into(),
        format!("strb w1, [x0, #{after_call_offset}]"),
        "ret x15".into(),
        "transform:".into(),
        format!("strb w1, [x0, #{callee_offset}]"),
        "ret".into(),
    ]
    .to_vec()
}

fn run_call(asm: Vec<String>) -> std::io::Result<()> {
    let mut engine = ExecutionEngine::new(asm);
    engine.add_abstract_from(0, "dst");
    engine.add_region(RegionType::WRITE, "dst", AbstractExpression::Immediate(8));
    engine.start("wrapper")
}

#[test]
fn an_indirect_call_runs_the_callee_and_returns() {
    assert!(run_call(indirect_call(0, 7)).is_ok());
}

#[test]
fn a_bad_write_in_the_callee_is_caught() {
    assert!(run_call(indirect_call(8, 7)).is_err());
}

#[test]
fn a_bad_write_after_the_call_returns_is_caught() {
    assert!(run_call(indirect_call(0, 8)).is_err());
}

fn call_chosen_by_csel(first_offset: u32, second_offset: u32) -> Vec<String> {
    [
        "wrapper:".to_string(),
        "mov x15, x30".into(),
        "adr x4, first".into(),
        "adr x5, second".into(),
        "cmp x2, #0".into(),
        "csel x6, x4, x5, ne".into(),
        "blr x6".into(),
        "ret x15".into(),
        "first:".into(),
        format!("strb w1, [x0, #{first_offset}]"),
        "ret".into(),
        "second:".into(),
        format!("strb w1, [x0, #{second_offset}]"),
        "ret".into(),
    ]
    .to_vec()
}

#[test]
fn a_call_through_a_selected_code_address_runs_either_callee() {
    assert!(run_call(call_chosen_by_csel(0, 7)).is_ok());
    assert!(run_call(call_chosen_by_csel(8, 7)).is_err());
    assert!(run_call(call_chosen_by_csel(0, 8)).is_err());
}
