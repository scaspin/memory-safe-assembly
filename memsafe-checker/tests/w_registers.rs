// A w register is the low 32 bits of x, zero extended when written.

fn x0_after(program: Vec<String>, x1: usize, x2: usize) -> i64 {
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_immediate(String::from("x0"), 0);
    engine.add_immediate(String::from("x1"), x1);
    engine.add_immediate(String::from("x2"), x2);
    engine.start("start".to_string()).expect("runs");
    engine.get_register_output(0).offset
}

fn program(body: &str) -> Vec<String> {
    vec!["start:".to_string(), body.to_string(), "ret".to_string()]
}

// Zero extension, not sign extension: 0 - 1 in a w register is 0xFFFF_FFFF.
#[test]
fn w_write_zero_extends() {
    assert_eq!(x0_after(program("sub w0,w0,#1"), 0, 0), 4294967295);
}

// Reading w2 must see only its low 32 bits.
#[test]
fn w_read_takes_the_low_word() {
    let x2 = (1usize << 40) + 5;
    assert_eq!(x0_after(program("add x0,x1,w2"), 0, x2), 5);
}

#[test]
fn x_read_takes_the_whole_register() {
    let x2 = (1usize << 40) + 5;
    assert_eq!(x0_after(program("add x0,x1,x2"), 0, x2), 1099511627781);
}

// A value already inside 32 bits is unchanged.
#[test]
fn narrowing_leaves_small_values_alone() {
    assert_eq!(x0_after(program("add w0,w1,w2"), 7, 9), 16);
}
