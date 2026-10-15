use bums::common::*;
use bums::instruction_parser::{Arrangement, Instruction, Operand, RePrefix};

const Q8K: &str = include_str!("asm/candle_q8k_vec_dot.S");
const LABEL: &str = "candle_q8k_vec_dot";
const BLOCK: i64 = 292;

const Q2K: &str = include_str!("asm/candle_q2k_vec_dot.S");
const Q2K_LABEL: &str = "candle_q2k_vec_dot";

const Q4_0: &str = include_str!("asm/candle_q4_0_vec_dot.S");
const Q4_0_LABEL: &str = "candle_q4_0_vec_dot";

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn program() -> Vec<String> {
    Q8K.lines().map(str::to_string).collect()
}

fn blocks_of(len: &str, block: i64) -> AbstractExpression {
    generate_expression(
        "/",
        AbstractExpression::Abstract(len.to_string()),
        AbstractExpression::Immediate(block),
    )
}

fn blocks(len: &str) -> AbstractExpression {
    blocks_of(len, BLOCK)
}

fn multiple_of(len: &str, block: i64) -> AbstractComparison {
    AbstractComparison::new(
        "==",
        generate_expression(
            "%",
            AbstractExpression::Abstract(len.to_string()),
            AbstractExpression::Immediate(block),
        ),
        AbstractExpression::Immediate(0),
    )
}

fn multiple_of_block(len: &str) -> AbstractComparison {
    multiple_of(len, BLOCK)
}

fn quantized_engine(asm: &str, xs_block: i64, ys_block: i64) -> bums::engine::ExecutionEngine {
    let mut engine =
        bums::engine::ExecutionEngine::new(asm.lines().map(str::to_string).collect::<Vec<_>>());

    engine.add_invariant(AbstractComparison::new(
        ">=",
        AbstractExpression::Abstract("n".to_string()),
        AbstractExpression::Immediate(0),
    ));
    engine.add_abstract_from(0, "n".to_string());

    for (reg, name, block) in [(1, "xs", xs_block), (3, "ys", ys_block)] {
        let ptr = format!("{name}_as_ptr");
        let len = format!("{name}_len");
        engine.add_abstract_from(reg, ptr.clone());
        engine.add_region(
            RegionType::READ,
            ptr,
            AbstractExpression::Abstract(len.clone()),
        );
        engine.add_abstract_expression_from(reg + 1, blocks_of(&len, block));
        engine.add_invariant(AbstractComparison::new(
            "<=",
            AbstractExpression::Abstract(len.clone()),
            AbstractExpression::Immediate(i64::MAX),
        ));
        engine.add_invariant(multiple_of(&len, block));
    }
    engine
}

fn annotated_engine() -> bums::engine::ExecutionEngine {
    let mut engine = bums::engine::ExecutionEngine::new(program());

    engine.add_invariant(AbstractComparison::new(
        ">=",
        AbstractExpression::Abstract("n".to_string()),
        AbstractExpression::Immediate(0),
    ));
    engine.add_abstract_from(0, "n".to_string());

    engine.add_abstract_from(1, "xs_as_ptr".to_string());
    engine.add_region(
        RegionType::READ,
        "xs_as_ptr".to_string(),
        AbstractExpression::Abstract("xs_len".to_string()),
    );
    engine.add_abstract_expression_from(2, blocks("xs_len"));

    engine.add_abstract_from(3, "ys_as_ptr".to_string());
    engine.add_region(
        RegionType::READ,
        "ys_as_ptr".to_string(),
        AbstractExpression::Abstract("ys_len".to_string()),
    );
    engine.add_abstract_expression_from(4, blocks("ys_len"));

    for len in ["xs_len", "ys_len"] {
        engine.add_invariant(AbstractComparison::new(
            "<=",
            AbstractExpression::Abstract(len.to_string()),
            AbstractExpression::Immediate(i64::MAX),
        ));
    }

    engine.add_invariant(multiple_of_block("xs_len"));
    engine.add_invariant(multiple_of_block("ys_len"));
    engine
}

fn one_block_engine(xs_bytes: i64, ys_bytes: i64) -> bums::engine::ExecutionEngine {
    let mut engine = bums::engine::ExecutionEngine::new(program());
    engine.add_abstract_from(1, "xs".to_string());
    engine.add_region(
        RegionType::READ,
        "xs".to_string(),
        AbstractExpression::Immediate(xs_bytes),
    );
    engine.add_immediate("x2".to_string(), 1);
    engine.add_abstract_from(3, "ys".to_string());
    engine.add_region(
        RegionType::READ,
        "ys".to_string(),
        AbstractExpression::Immediate(ys_bytes),
    );
    engine.add_immediate("x4".to_string(), 1);
    engine
}

#[test]
fn q8k_fixture_parses() {
    for line in Q8K.lines().filter(|l| !l.trim().is_empty()) {
        let _ = Instruction::new(line.to_string());
    }

    let load_scale = Instruction::new("ldur s1, [x9, #-0x84]".to_string());
    assert_eq!(
        load_scale.operands[0],
        Operand::Vector(RePrefix::V, 1, Arrangement::S)
    );
    let load_pair = Instruction::new("ldp q6, q3, [x9, #-0x80]".to_string());
    assert_eq!(
        load_pair.operands[0],
        Operand::VectorRegister(RePrefix::V, 6)
    );
}

#[test]
fn q8k_annotation_is_safe() {
    init();
    let mut engine = annotated_engine();

    let res = engine.start(LABEL.to_string());
    assert!(res.is_ok(), "{:?}", res);
}

#[test]
fn q8k_one_block_is_safe() {
    init();
    let mut engine = one_block_engine(BLOCK, BLOCK);

    let res = engine.start(LABEL.to_string());
    assert!(res.is_ok(), "{:?}", res);
}

const BYTES_READ_PER_BLOCK: i64 = 260;

#[test]
fn q8k_one_block_without_bsums_is_safe() {
    init();
    let mut engine = one_block_engine(BYTES_READ_PER_BLOCK, BYTES_READ_PER_BLOCK);

    let res = engine.start(LABEL.to_string());
    assert!(res.is_ok(), "{:?}", res);
}

#[test]
fn q8k_xs_one_byte_short_is_unsafe() {
    init();
    let mut engine = one_block_engine(BYTES_READ_PER_BLOCK - 1, BLOCK);

    let res = engine.start(LABEL.to_string());
    assert!(res.is_err());
}

#[test]
fn q8k_ys_one_byte_short_is_unsafe() {
    init();
    let mut engine = one_block_engine(BLOCK, BYTES_READ_PER_BLOCK - 1);

    let res = engine.start(LABEL.to_string());
    assert!(res.is_err());
}

#[test]
fn q8k_block_count_past_ys_is_unsafe() {
    init();
    let mut engine = annotated_engine();
    engine.add_abstract_expression_from(
        4,
        generate_expression("+", blocks("ys_len"), AbstractExpression::Immediate(1)),
    );

    let res = engine.start(LABEL.to_string());
    assert!(res.is_err());
}

#[test]
fn q8k_block_count_unrelated_to_ys_is_unsafe() {
    init();
    let mut engine = annotated_engine();
    engine.add_abstract_from(4, "ys_blocks".to_string());

    let res = engine.start(LABEL.to_string());
    assert!(res.is_err());
}

#[test]
fn simd_value_ops_run() {
    init();
    let program = [
        "test:",
        "sdot v5.4s, v6.16b, v7.16b",
        "addv s2, v3.4s",
        "scvtf s2, s2",
        "fmul s1, s1, s2",
        "fadd s0, s0, s1",
        "ret",
    ];
    let mut engine = bums::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );

    let res = engine.start("test".to_string());
    assert!(res.is_ok(), "{:?}", res);
}

#[test]
fn sdot_result_is_not_a_safe_index() {
    init();
    let program = [
        "test:",
        "movi v5.2d, #0000000000000000",
        "sdot v5.4s, v6.16b, v7.16b",
        "mov w8, v5.s[0]",
        "ldrb w9, [x1, x8]",
        "ret",
    ];
    let mut engine = bums::engine::ExecutionEngine::new(
        program.iter().map(|s| s.to_string()).collect::<Vec<_>>(),
    );
    engine.add_abstract_from(1, "buf".to_string());
    engine.add_region(
        RegionType::READ,
        "buf".to_string(),
        AbstractExpression::Immediate(16),
    );

    let res = engine.start("test".to_string());
    assert!(res.is_err());
}

#[test]
fn q2k_annotation_is_safe() {
    init();
    let mut engine = quantized_engine(Q2K, 84, 292);

    let res = engine.start(Q2K_LABEL.to_string());
    assert!(res.is_ok(), "{:?}", res);
}

#[test]
fn q2k_xs_one_byte_short_is_unsafe() {
    init();
    let mut engine =
        bums::engine::ExecutionEngine::new(Q2K.lines().map(str::to_string).collect::<Vec<_>>());
    engine.add_abstract_from(1, "xs".to_string());
    engine.add_region(
        RegionType::READ,
        "xs".to_string(),
        AbstractExpression::Immediate(83),
    );
    engine.add_immediate("x2".to_string(), 1);
    engine.add_abstract_from(3, "ys".to_string());
    engine.add_region(
        RegionType::READ,
        "ys".to_string(),
        AbstractExpression::Immediate(292),
    );
    engine.add_immediate("x4".to_string(), 1);

    let res = engine.start(Q2K_LABEL.to_string());
    assert!(res.is_err(), "a read past xs was accepted");
}

#[test]
fn q4_0_division_form_is_safe() {
    init();
    let mut engine = quantized_engine(Q4_0, 18, 34);

    let res = engine.start(Q4_0_LABEL.to_string());
    assert!(res.is_ok(), "{:?}", res);
}

#[test]
fn q4_0_division_form_with_matched_counts_is_safe() {
    init();
    let mut engine = quantized_engine(Q4_0, 18, 34);
    engine.add_invariant(AbstractComparison::new(
        "==",
        blocks_of("xs_len", 18),
        blocks_of("ys_len", 34),
    ));

    let res = engine.start(Q4_0_LABEL.to_string());
    assert!(res.is_ok(), "{:?}", res);
}

#[test]
fn q4_0_division_form_is_safe_whichever_slice_is_shorter() {
    init();
    for (longer, shorter) in [("ys_len", "xs_len"), ("xs_len", "ys_len")] {
        let mut engine = quantized_engine(Q4_0, 18, 34);
        let block_of = |len: &str| if len == "xs_len" { 18 } else { 34 };
        engine.add_invariant(AbstractComparison::new(
            ">=",
            blocks_of(longer, block_of(longer)),
            blocks_of(shorter, block_of(shorter)),
        ));
        let res = engine.start(Q4_0_LABEL.to_string());
        assert!(res.is_ok(), "with {shorter} the shorter: {res:?}");
    }
}

#[test]
fn q4_0_ys_one_byte_short_is_unsafe() {
    init();
    let mut engine =
        bums::engine::ExecutionEngine::new(Q4_0.lines().map(str::to_string).collect::<Vec<_>>());
    engine.add_immediate("x0".to_string(), 32);
    engine.add_abstract_from(1, "xs".to_string());
    engine.add_region(
        RegionType::READ,
        "xs".to_string(),
        AbstractExpression::Immediate(18),
    );
    engine.add_immediate("x2".to_string(), 1);
    engine.add_abstract_from(3, "ys".to_string());
    engine.add_region(
        RegionType::READ,
        "ys".to_string(),
        AbstractExpression::Immediate(33),
    );
    engine.add_immediate("x4".to_string(), 1);

    let res = engine.start(Q4_0_LABEL.to_string());
    assert!(res.is_err(), "a read past ys was accepted");
}
