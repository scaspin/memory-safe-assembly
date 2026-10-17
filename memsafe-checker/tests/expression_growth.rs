use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn mix_then_store(store: &str) -> Result<(), String> {
    init();
    let mut program = vec![
        "start:".to_string(),
        "ldp w4,w5,[x0]".to_string(),
        "ldp w6,w7,[x0,#8]".to_string(),
    ];
    for _ in 0..48 {
        program.extend([
            "add w4,w4,w5".to_string(),
            "add w5,w5,w6".to_string(),
            "add w6,w6,w7".to_string(),
            "add w7,w7,w4".to_string(),
        ]);
    }
    program.push(store.to_string());
    program.push("ret".to_string());
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "words".to_string());
    engine.add_region(
        RegionType::RW,
        "words".to_string(),
        AbstractExpression::Immediate(16),
    );
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

#[test]
fn sums_of_loaded_words_stay_small_enough_to_check() {
    assert_eq!(mix_then_store("stp w4,w7,[x0,#8]"), Ok(()));
}

#[test]
fn a_store_past_the_region_after_mixing_is_still_rejected() {
    let err = mix_then_store("stp w4,w7,[x0,#12]").expect_err("a store past 16 bytes");
    assert!(err.contains("not provably within region"), "{err}");
}
