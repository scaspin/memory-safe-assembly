use bums;
use bums::common::*;
use z3::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

#[test]
fn example_stack_push_pop() {
    init();

    let mut program = Vec::new();
    let start_label = "test".to_string();
    program.push("test:".to_string());
    program.push("add x3,x3,#21".to_string());
    program.push("str x3,[sp,#4]".to_string());
    program.push("ldr x0,[sp,#4]".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_immediate(String::from("x3"), 1);

    let res = engine.start(start_label);

    assert!(res.is_ok());
    assert_eq!(engine.get_register_output(0).base, None);
    assert_eq!(engine.get_register_output(0).offset, 22);
}

/*
 * This should fail since first memory access can succeed when length is 0,
 */
#[test]
fn example_basic_abstract_loop() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    let start_label = "test".to_string();
    program.push("test:".to_string());
    program.push("add x3,x1,x2".to_string());
    program.push("loop:".to_string());
    program.push("ldr x4,[x1]".to_string());
    program.push("add x1,x1,#4".to_string());
    program.push("cmp x1,x3".to_string());
    program.push("b.ne loop".to_string());
    program.push("add x4,x4,#4".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    let length = AbstractExpression::Abstract("Length".to_string());
    let base = AbstractExpression::Abstract("Base".to_string());
    // Base is the base address of the input buffer
    engine.add_abstract(String::from("x1"), base.clone());
    engine.add_region(RegionType::READ, "Base".to_string(), length.clone());

    engine.add_abstract(String::from("x2"), length);

    engine.change_alignment(1);
    let res = engine.start(start_label);
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_bad_increment_abstract_loop() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    let start_label = "test".to_string();
    program.push("test:".to_string());
    program.push("add x3,x1,x2".to_string());
    program.push("loop:".to_string());
    program.push("add x1,x1,#1".to_string());
    program.push("ldr x4,[x1]".to_string());
    program.push("cmp x1,x3".to_string());
    program.push("b.ne loop".to_string());
    program.push("add x4,x4,#4".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    let length = AbstractExpression::Abstract("Length".to_string());
    let base = AbstractExpression::Abstract("Base".to_string());
    // Base is the base address of the input buffer
    engine.add_abstract(String::from("x1"), base.clone());
    engine.add_region(RegionType::READ, "Base".to_string(), length.clone());

    engine.add_abstract(String::from("x2"), length);

    engine.change_alignment(1);
    let res = engine.start(start_label);
    assert!(res.is_err());
    Ok(())
}

// x1 region isn't bounded by length 2, so loop
// over x1 from 0 to a random abstract length2
// doesn't work, since we're missing length 2
// being connected to the memory region
#[test]
fn example_loop_on_input_abstract_loop() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    let start_label = "test".to_string();
    program.push("test:".to_string());
    program.push("add x3,x1,x2".to_string());
    program.push("loop:".to_string());
    program.push("ldr x5,[x1]".to_string());
    program.push("add x1,x1,#1".to_string());
    program.push("cmp x1,x3".to_string());
    program.push("b.ne loop".to_string());
    program.push("add x4,x4,#4".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    let length1 = AbstractExpression::Abstract("Length1".to_string());
    let length2 = AbstractExpression::Abstract("Length2".to_string());
    let base1 = AbstractExpression::Abstract("Base1".to_string());

    engine.add_abstract(String::from("x1"), base1.clone());
    engine.add_region(RegionType::READ, "Base1".to_string(), length1);
    engine.add_abstract(String::from("x2"), length2.clone());

    engine.change_alignment(1);
    let res = engine.start(start_label);
    assert!(res.is_err());
    Ok(())
}

// #[test]
// fn example_double_loop() -> std::io::Result<()> {
//     init();

//     let mut program = Vec::new();
//     let start_label = "test".to_string();
//     program.push("test:".to_string());
//     program.push("add x3,x1,x2".to_string());
//     program.push("add x4,x1,#0".to_string());
//     program.push("loop_1:".to_string());
//     program.push("ldr x5,[x1]".to_string());
//     program.push("add x1,x1,#1".to_string());
//     program.push("cmp x1,x3".to_string());
//     program.push("b.ne loop_1".to_string());
//     program.push("loop_2:".to_string());
//     program.push("sub x1,x1,#1".to_string());
//     program.push("ldr x5,[x1]".to_string());
//     program.push("cmp x1,x4".to_string());
//     program.push("b.ne loop_2".to_string());
//     program.push("ret".to_string());

//     let cfg = Config::new();
//     let ctx = Context::new(&cfg);
//     let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

//     let length = AbstractExpression::Abstract("Length".to_string());
//     let base = AbstractExpression::Abstract("Base".to_string());
//     // Base is the base address of the input buffer
//     engine.add_abstract(String::from("x1"), base.clone());
//     engine.add_abstract(String::from("x2"), length.clone());

//     engine.add_region(RegionType::READ, "Base".to_string(), length.clone());
//     engine.add_invariant(generate_comparison("<", AbstractExpression::Immediate(0), length));

//     engine.change_alignment(1);
//     let res = engine.start(start_label);
//     assert!(res.is_ok());
//     Ok(())
// }

#[test]
fn example_z3_abstract_bound_unsafe() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    for _ in 0..5 {
        program.push("ldr x1,[x0,#4]".to_string());
    }

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        AbstractExpression::Abstract("length".to_string()),
    );

    let res = engine.start("start".to_string());
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_z3_abstract_bound_unsafe_zero() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());

    program.push("ldr x1,[x0,#0]".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        AbstractExpression::Abstract("length".to_string()),
    );

    let res = engine.start("start".to_string());
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_z3_real_bound_safe() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());

    program.push("ldr x1,[x0,#0]".to_string());
    program.push("ldr x1,[x0,#4]".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        AbstractExpression::Immediate(8),
    );

    let res = engine.start("start".to_string());
    assert!(res.is_ok());
    Ok(())
}

#[test]
fn example_z3_real_bound_unsafe() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("ldr x1,[x0,#0]".to_string());
    program.push("ldr x1,[x0,#16]".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        AbstractExpression::Immediate(1),
    );

    let res = engine.start("start".to_string());
    assert!(res.is_err());
    let Err(e) = res else { panic!() };
    assert_eq!(
        e.to_string(),
        "Accessing address outside allowable memory regions Abstract(\"base\"), 16"
    );
    Ok(())
}

#[test]
fn example_z3_simple_loop_with_no_mem_access() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("add x1,#0,#0".to_string());
    program.push("add x2,#0,#4".to_string());
    program.push("loop:".to_string());
    program.push("add x1,x1,#1".to_string());
    program.push("cmp x1,x2".to_string());
    program.push("b.ne loop".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    let res = engine.start("start".to_string());
    assert!(res.is_ok());
    Ok(())
}

#[test]
fn example_z3_simple_loop_with_mem_access_safe() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("add x1,#0,#0".to_string());
    program.push("add x2,#0,#4".to_string());
    program.push("loop:".to_string());
    program.push("ldr x3,[x0,#0]".to_string());
    program.push("add x1,x1,#1".to_string());
    program.push("add x0,x0,#4".to_string());
    program.push("cmp x1,x2".to_string());
    program.push("b.ne loop".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        AbstractExpression::Immediate(16),
    );

    let res = engine.start("start".to_string());
    assert!(res.is_ok());
    Ok(())
}

// #[test]
// fn example_z3_complex_loop_with_mem_access_safe() -> std::io::Result<()> {
//     init();

//     let mut program = Vec::new();
//     program.push("start:".to_string());
//     program.push("add x1,x0,x1,lsl#2".to_string());
//     program.push("loop:".to_string());
//     program.push("cmp x0,x1".to_string());
//     program.push("b.eq end".to_string());
//     program.push("ldr x3,[x0,#0]".to_string());
//     program.push("add x0,x0,#4".to_string());
//     program.push("b loop".to_string());
//     program.push("end:".to_string());
//     program.push("ret".to_string());

//     let mut cfg = Config::new();
//     cfg.set_proof_generation(true);
//     let ctx = Context::new(&cfg);
//     let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

//     engine.add_abstract_from(0, "base".to_string());
//     engine.add_abstract_from(1, "blocks".to_string());

//     let length = AbstractExpression::Expression(
//         "lsl".to_string(),
//         Box::new(AbstractExpression::Abstract("blocks".to_string())),
//         Box::new(AbstractExpression::Immediate(2)),
//     );
//     engine.add_region(RegionType::READ, "base".to_string(), length);

//     let res = engine.start("start".to_string());
//     assert!(res.is_ok());
//     Ok(())
// }

#[test]
fn example_z3_complex_loop_with_mem_access_unsafe() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("add x1,x0,x1".to_string());
    program.push("loop:".to_string());
    program.push("cmp x0,x1".to_string());
    program.push("b.eq end".to_string());
    program.push("ldr x3,[x0,#0]".to_string());
    program.push("add x0,x0,#4".to_string());
    program.push("b loop".to_string());
    program.push("end:".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        AbstractExpression::Abstract("length".to_string()),
    );
    engine.add_abstract_from(1, "length".to_string());

    let res = engine.start("start".to_string());
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_z3_complex_loop_with_no_mem_access() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("add x1,x0,x1".to_string());
    program.push("loop:".to_string());
    program.push("cmp x0,x1".to_string());
    program.push("b.eq end".to_string());
    program.push("add x0,x0,#4".to_string());
    program.push("b loop".to_string());
    program.push("end:".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        AbstractExpression::Abstract("length".to_string()),
    );
    engine.add_abstract_from(1, "length".to_string());

    let res = engine.start("start".to_string());
    assert!(res.is_ok());
    Ok(())
}

#[test]
fn example_z3_example_branch() -> std::io::Result<()> {
    //env_logger::init();;

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("cmp x1,x2".to_string());
    program.push("b.ne branch".to_string());
    program.push("add x0,x0,#4".to_string());
    program.push("b end".to_string());
    program.push("branch:".to_string());
    program.push("add x0,x0,#2".to_string());
    program.push("end:".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_abstract_from(0, "left".to_string());
    engine.add_abstract_from(1, "right".to_string());

    let res = engine.start("start".to_string());
    assert!(res.is_ok());
    Ok(())
}
