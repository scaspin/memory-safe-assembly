use bums::common::*;

const MLKEM: &str = include_str!("asm/mlkem_rej_uniform.S");
const MLDSA_ETA2: &str = include_str!("asm/mldsa_rej_uniform_eta2.S");

fn sample(asm: &str, frame: &str, output: i64, block: i64) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let program = asm.replace("#0x240", frame);
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::to_string));
    let length = || AbstractExpression::Abstract("length".to_string());
    engine.add_abstract_from(0, "r");
    engine.add_region(RegionType::RW, "r", AbstractExpression::Immediate(output));
    engine.add_abstract_from(1, "buf");
    engine.add_region(RegionType::READ, "buf", length());
    engine.add_abstract_from(2, "length");
    engine.add_abstract_from(3, "table");
    engine.add_region(
        RegionType::READ,
        "table",
        AbstractExpression::Immediate(4096),
    );
    engine.add_invariant(AbstractComparison::new(
        ">=",
        length(),
        AbstractExpression::Immediate(block),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        length(),
        AbstractExpression::Immediate(u32::MAX as i64),
    ));
    engine.add_invariant(AbstractComparison::new(
        "==",
        generate_expression("%", length(), AbstractExpression::Immediate(block)),
        AbstractExpression::Immediate(0),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn mldsa_eta2_sampling_stays_in_its_frame() {
    assert_eq!(sample(MLDSA_ETA2, "#0x240", 1024, 8), Ok(()));
}

#[test]
fn mldsa_eta2_sampling_overflows_a_smaller_frame() {
    let rejected = sample(MLDSA_ETA2, "#0x200", 1024, 8).unwrap_err();
    assert!(rejected.contains("stack frame"), "{rejected}");
}

#[test]
fn mlkem_sampling_stays_in_its_frame() {
    assert_eq!(sample(MLKEM, "#0x240", 512, 24), Ok(()));
}

#[test]
fn mlkem_sampling_overflows_a_smaller_frame() {
    let rejected = sample(MLKEM, "#0x210", 512, 24).unwrap_err();
    assert!(rejected.contains("stack frame"), "{rejected}");
}
