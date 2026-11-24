use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

const REDUCE: &[&str] = &[
    "cmhs v2.8h, v30.8h, v4.8h",
    "cmhs v3.8h, v30.8h, v5.8h",
    "add v6.8h, v2.8h, v3.8h",
    "addv h31, v6.8h",
    "smov w15, v31.h[0]",
    "add x1, x0, w15, sxtw #1",
];

fn accepts(prefix: &[&str], access: &str, length: i64) -> bool {
    init();
    let mut program = vec!["start:".to_string()];
    program.extend(prefix.iter().map(|line| line.to_string()));
    program.push(access.to_string());
    program.push("ret".to_string());

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Immediate(length),
    );
    engine.start("start".to_string()).is_ok()
}

#[test]
fn reduced_mask_index_bounds_an_access() {
    assert!(accepts(REDUCE, "ldrb w2, [x1, #32]", 33));
}

#[test]
fn reduced_mask_index_is_still_checked_above() {
    assert!(!accepts(REDUCE, "ldrb w2, [x1, #32]", 32));
}

#[test]
fn reduced_mask_index_is_still_checked_below() {
    assert!(!accepts(REDUCE, "ldrb w2, [x1, #31]", 1024));
}

#[test]
fn an_unreduced_lane_is_not_bounded() {
    let unreduced = &["smov w15, v31.h[0]", "add x1, x0, w15, sxtw #1"];
    assert!(!accepts(unreduced, "ldrb w2, [x1, #32]", 1024));
}

#[test]
fn an_overwritten_mask_is_not_bounded() {
    let overwritten = &[
        "cmhs v2.8h, v30.8h, v4.8h",
        "mul v2.8h, v4.8h, v5.8h",
        "addv h31, v2.8h",
        "smov w15, v31.h[0]",
        "add x1, x0, w15, sxtw #1",
    ];
    assert!(!accepts(overwritten, "ldrb w2, [x1, #32]", 1024));
}

const SINGLE_BIT_COUNT: &[&str] = &[
    "mov x7,#0x1",
    "movk x7,#0x2,lsl #16",
    "movk x7,#0x4,lsl #32",
    "movk x7,#0x8,lsl #48",
    "mov v31.d[0],x7",
    "mov x7,#0x10",
    "movk x7,#0x20,lsl #16",
    "movk x7,#0x40,lsl #32",
    "movk x7,#0x80,lsl #48",
    "mov v31.d[1],x7",
    "cmhi v4.8h,v30.8h,v16.8h",
    "and v4.16b,v4.16b,v31.16b",
    "cnt v4.16b,v4.16b",
    "uaddlv s20,v4.8h",
    "fmov w12,s20",
    "add x1,x0,x12",
];

#[test]
fn counting_single_bit_lanes_bounds_the_count_by_the_lanes() {
    assert!(accepts(SINGLE_BIT_COUNT, "ldrb w2,[x1]", 9));
    assert!(!accepts(SINGLE_BIT_COUNT, "ldrb w2,[x1]", 8));
}

#[test]
fn counting_unmasked_lanes_is_bounded_only_by_their_width() {
    let unmasked: Vec<&str> = SINGLE_BIT_COUNT
        .iter()
        .copied()
        .filter(|line| !line.starts_with("and"))
        .collect();
    assert!(!accepts(&unmasked, "ldrb w2,[x1]", 9));
    assert!(accepts(&unmasked, "ldrb w2,[x1]", 8 * 2056 + 1));
}

fn gathers_from_scaling_table(prefix: &[&str], length: AbstractExpression) -> bool {
    init();
    let mut program = vec!["start:".to_string()];
    program.extend(prefix.iter().map(|line| line.to_string()));
    program.extend(
        [
            "umov w14, v0.h[0]",
            "umov w15, v0.h[7]",
            "add x14, x14, x0",
            "add x15, x15, x0",
            "ld1 {v6.b}[0], [x14]",
            "ld1 {v6.b}[1], [x15]",
            "ret",
        ]
        .map(String::from),
    );
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "scaling".to_string());
    engine.add_region(RegionType::READ, "scaling".to_string(), length);
    engine.add_abstract_from(1, "bitdepth_max".to_string());
    for (op, bound) in [(">=", 1023), ("<=", 4095)] {
        engine.add_invariant(AbstractComparison::new(
            op,
            abstract_of("bitdepth_max"),
            AbstractExpression::Immediate(bound),
        ));
    }
    engine.start("start".to_string()).is_ok()
}

fn past_bitdepth_max() -> AbstractExpression {
    generate_expression(
        "+",
        abstract_of("bitdepth_max"),
        AbstractExpression::Immediate(1),
    )
}

#[test]
fn pixels_masked_by_a_shifted_inverted_immediate_index_a_4096_entry_table() {
    let masked = &["mvni v4.8h, #0xf0, lsl #8", "and v0.16b, v0.16b, v4.16b"];
    assert!(gathers_from_scaling_table(
        masked,
        AbstractExpression::Immediate(4096)
    ));
}

#[test]
fn pixels_masked_by_a_broadcast_bitdepth_max_index_the_table() {
    let masked = &["dup v23.8h, w1", "and v0.16b, v0.16b, v23.16b"];
    assert!(gathers_from_scaling_table(masked, past_bitdepth_max()));
}

#[test]
fn pixels_clamped_between_zero_and_bitdepth_max_index_the_table() {
    let clamped = &[
        "dup v23.8h, w1",
        "movi v2.8h, #0",
        "smin v0.8h, v0.8h, v23.8h",
        "smax v0.8h, v0.8h, v2.8h",
    ];
    assert!(gathers_from_scaling_table(clamped, past_bitdepth_max()));
}

#[test]
fn a_zero_floor_on_the_left_of_smax_also_clamps() {
    let clamped = &[
        "dup v23.8h, w1",
        "movi v2.8h, #0",
        "smin v0.8h, v23.8h, v0.8h",
        "smax v0.8h, v2.8h, v0.8h",
    ];
    assert!(gathers_from_scaling_table(clamped, past_bitdepth_max()));
}
