use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn accepts(body: &[&str], length: i64) -> bool {
    init();
    let program: Vec<String> = std::iter::once("start:")
        .chain(body.iter().copied())
        .chain(std::iter::once("ret"))
        .map(String::from)
        .collect();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "n");
    engine.add_abstract_from(1, "buf");
    engine.add_region(RegionType::RW, "buf", AbstractExpression::Immediate(length));
    engine.add_invariant(AbstractComparison::new(
        ">=",
        AbstractExpression::Abstract("n".to_string()),
        AbstractExpression::Immediate(1),
    ));
    engine.start("start").is_ok()
}

fn ring(last_move: &str) -> Vec<String> {
    [
        "mov x11, x1",
        "add x12, x1, #16",
        "add x13, x1, #32",
        "rotate:",
        "ldr q0, [x11]",
        "mov x14, x11",
        "mov x11, x12",
        "mov x12, x13",
        last_move,
        "subs x0, x0, #1",
        "b.ne rotate",
    ]
    .map(String::from)
    .to_vec()
}

fn accepts_ring(last_move: &str, length: i64) -> bool {
    let body = ring(last_move);
    accepts(&body.iter().map(String::as_str).collect::<Vec<_>>(), length)
}

#[test]
fn pointers_that_only_trade_places_stay_on_their_buffers() {
    assert!(accepts_ring("mov x13, x14", 48));
}

#[test]
fn a_pointer_that_moves_while_trading_places_is_rejected() {
    assert!(!accepts_ring("add x13, x14, #16", 48));
}

#[test]
fn a_ring_one_byte_too_short_is_rejected() {
    assert!(!accepts_ring("mov x13, x14", 47));
}
