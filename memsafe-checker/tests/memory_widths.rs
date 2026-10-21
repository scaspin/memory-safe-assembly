use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn accepts(n: i64, body: &[&str]) -> bool {
    init();
    let mut program = vec!["start:".to_string()];
    program.extend(body.iter().map(|line| line.to_string()));
    program.push("ret".to_string());

    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Immediate(n),
    );
    engine.add_immediate("x1", 0);
    engine.start("start".to_string()).is_ok()
}

fn pins_width(access: &str, width: i64) {
    assert!(
        accepts(width, &[access]),
        "`{access}` rejected in {width} bytes"
    );
    assert!(
        !accepts(width - 1, &[access]),
        "`{access}` accepted in {} bytes",
        width - 1
    );
}

fn round_trip(store: &str, load: &str, value: usize) -> i64 {
    init();
    let program = vec![
        "start:".to_string(),
        store.to_string(),
        load.to_string(),
        "ret".to_string(),
    ];
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::RW,
        "base".to_string(),
        AbstractExpression::Immediate(8),
    );
    engine.add_immediate("x1", value);
    engine.start("start".to_string()).expect("runs");
    engine.get_register_output(2).offset
}

#[test]
fn ldr_reads_eight_bytes() {
    pins_width("ldr x2,[x0]", 8);
}

#[test]
fn ldr_into_w_reads_four_bytes() {
    pins_width("ldr w2,[x0]", 4);
}

#[test]
fn ldrb_reads_one_byte() {
    pins_width("ldrb w2,[x0]", 1);
}

#[test]
fn ldrh_reads_two_bytes() {
    pins_width("ldrh w2,[x0]", 2);
}

#[test]
fn ldrsb_reads_one_byte() {
    pins_width("ldrsb x2,[x0]", 1);
}

#[test]
fn ldrsh_reads_two_bytes() {
    pins_width("ldrsh x2,[x0]", 2);
}

#[test]
fn ldrsw_reads_four_bytes() {
    pins_width("ldrsw x2,[x0]", 4);
}

#[test]
fn ldur_reads_eight_bytes() {
    pins_width("ldur x2,[x0,#0]", 8);
}

#[test]
fn ldurb_reads_one_byte() {
    pins_width("ldurb w2,[x0,#0]", 1);
}

#[test]
fn ldurh_reads_two_bytes() {
    pins_width("ldurh w2,[x0,#0]", 2);
}

#[test]
fn ldursb_reads_one_byte() {
    pins_width("ldursb x2,[x0,#0]", 1);
}

#[test]
fn ldursh_reads_two_bytes() {
    pins_width("ldursh x2,[x0,#0]", 2);
}

#[test]
fn ldursw_reads_four_bytes() {
    pins_width("ldursw x2,[x0,#0]", 4);
}

#[test]
fn str_writes_eight_bytes() {
    pins_width("str x1,[x0]", 8);
}

#[test]
fn strb_writes_one_byte() {
    pins_width("strb w1,[x0]", 1);
}

#[test]
fn strh_writes_two_bytes() {
    pins_width("strh w1,[x0]", 2);
}

#[test]
fn stur_writes_eight_bytes() {
    pins_width("stur x1,[x0,#0]", 8);
}

#[test]
fn sturb_writes_one_byte() {
    pins_width("sturb w1,[x0,#0]", 1);
}

#[test]
fn sturh_writes_two_bytes() {
    pins_width("sturh w1,[x0,#0]", 2);
}

#[test]
fn ldur_reaches_back_from_the_end() {
    assert!(accepts(16, &["add x3,x0,#16", "ldur x2,[x3,#-8]"]));
    assert!(!accepts(16, &["add x3,x0,#16", "ldur x2,[x3,#-24]"]));
}

#[test]
fn stur_reaches_back_from_the_end() {
    assert!(accepts(16, &["add x3,x0,#16", "stur x1,[x3,#-8]"]));
    assert!(!accepts(16, &["add x3,x0,#16", "stur x1,[x3,#-24]"]));
}

#[test]
fn ldrb_zero_extends() {
    assert_eq!(round_trip("strb w1,[x0]", "ldrb w2,[x0]", 0xff), 255);
}

#[test]
fn ldrsb_sign_extends() {
    assert_eq!(round_trip("strb w1,[x0]", "ldrsb x2,[x0]", 0xff), -1);
}

#[test]
fn ldrsb_leaves_a_positive_byte_alone() {
    assert_eq!(round_trip("strb w1,[x0]", "ldrsb x2,[x0]", 0x7f), 127);
}

#[test]
fn ldrh_zero_extends() {
    assert_eq!(round_trip("strh w1,[x0]", "ldrh w2,[x0]", 0xfffe), 65534);
}

#[test]
fn ldrsh_sign_extends() {
    assert_eq!(round_trip("strh w1,[x0]", "ldrsh x2,[x0]", 0xfffe), -2);
}

#[test]
fn ldrsw_sign_extends() {
    assert_eq!(round_trip("str w1,[x0]", "ldrsw x2,[x0]", 0xffff_fffe), -2);
}

#[test]
fn ldursb_sign_extends() {
    assert_eq!(
        round_trip("sturb w1,[x0,#0]", "ldursb x2,[x0,#0]", 0x80),
        -128
    );
}

#[test]
fn ldursh_sign_extends() {
    assert_eq!(
        round_trip("sturh w1,[x0,#0]", "ldursh x2,[x0,#0]", 0x8000),
        -32768
    );
}

#[test]
fn ldursw_sign_extends() {
    assert_eq!(
        round_trip("stur w1,[x0,#0]", "ldursw x2,[x0,#0]", 0x8000_0000),
        -2147483648
    );
}

#[test]
fn ldurb_zero_extends() {
    assert_eq!(
        round_trip("sturb w1,[x0,#0]", "ldurb w2,[x0,#0]", 0x80),
        128
    );
}
