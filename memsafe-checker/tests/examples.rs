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
fn example_unrelated_unknowns_not_treated_as_equal() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("ldr x1,[x0,#0]".to_string());
    program.push("ldr x2,[x0,#4]".to_string());
    program.push("cmp x1,x2".to_string());
    program.push("b.eq bad".to_string());
    program.push("ret".to_string());
    program.push("bad:".to_string());
    program.push("ret".to_string());

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
    assert!(res.is_err());
    Ok(())
}

// `cmn` carries its own copy of the `r1 == r2` shortcut.
#[test]
fn example_unrelated_unknowns_not_treated_as_equal_cmn() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("ldr x1,[x0,#0]".to_string());
    program.push("ldr x2,[x0,#4]".to_string());
    program.push("cmn x1,x2".to_string());
    program.push("b.eq bad".to_string());
    program.push("ret".to_string());
    program.push("bad:".to_string());
    program.push("ret".to_string());

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

// Symbolic base landing exactly one past the end of an 8-byte region.
#[test]
fn example_z3_symbolic_base_boundary_unsafe() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("add x0,x0,#8".to_string());
    program.push("ldr x1,[x0,#0]".to_string());

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
    Ok(())
}

// Same path, landing inside the region.
#[test]
fn example_z3_symbolic_base_boundary_safe() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("add x0,x0,#4".to_string());
    program.push("ldr x1,[x0,#0]".to_string());

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
    assert!(res.is_ok());
    Ok(())
}

// Last byte of an 8-byte region; pins the boundary from the safe side.
#[test]
fn example_z3_symbolic_base_last_byte_safe() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("add x0,x0,#7".to_string());
    program.push("ldr x1,[x0,#0]".to_string());

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
    assert!(res.is_ok());
    Ok(())
}

// Lower bound: backing the pointer below its region.
#[test]
fn example_z3_symbolic_base_below_region_unsafe() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("sub x0,x0,#8".to_string());
    program.push("ldr x1,[x0,#0]".to_string());

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
    Ok(())
}

// In-bounds store into a READ-only region.
#[test]
fn example_z3_write_to_read_only_region_unsafe() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("str x1,[x0,#0]".to_string());

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
    assert!(res.is_err());
    Ok(())
}

// Kind check is one-directional: only WRITE-to-READ is rejected.
#[test]
fn example_z3_read_from_write_region_safe() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("ldr x1,[x0,#0]".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::WRITE,
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

// Code after a `bl` must run: callee adds 10, call site adds 1.
#[test]
fn example_nested_call_returns_to_call_site() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("test:".to_string());
    program.push("str x30,[sp,#0]".to_string());
    program.push("bl sub".to_string());
    program.push("ldr x30,[sp,#0]".to_string());
    program.push("add x0,x0,#1".to_string());
    program.push("ret".to_string());
    program.push("sub:".to_string());
    program.push("add x0,x0,#10".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_immediate(String::from("x0"), 0);

    let res = engine.start("test".to_string());

    assert!(res.is_ok());
    assert_eq!(engine.get_register_output(0).base, None);
    assert_eq!(engine.get_register_output(0).offset, 11);
    Ok(())
}

// `b` to its own label cycles with no condition to resolve; must be bounded, not hang.
#[test]
fn example_unconditional_self_loop_bounded() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("spin:".to_string());
    program.push("add x0,x0,#1".to_string());
    program.push("b spin".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_immediate(String::from("x0"), 0);

    let res = engine.start("spin".to_string());
    assert!(res.is_err());
    Ok(())
}

// Same cycle through the JumpAddress path: `ret` to a concrete address that leads back to it.
#[test]
fn example_ret_to_self_bounded() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("test:".to_string());
    program.push("mov x30,#0".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    let res = engine.start("test".to_string());
    assert!(res.is_err());
    Ok(())
}

// The bound must not reject unconditional jumps that terminate.
#[test]
fn example_unconditional_forward_jump_terminates() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("test:".to_string());
    program.push("add x0,x0,#1".to_string());
    program.push("b second".to_string());
    program.push("add x0,x0,#100".to_string());
    program.push("second:".to_string());
    program.push("add x0,x0,#10".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_immediate(String::from("x0"), 0);

    let res = engine.start("test".to_string());

    assert!(res.is_ok());
    assert_eq!(engine.get_register_output(0).base, None);
    assert_eq!(engine.get_register_output(0).offset, 11);
    Ok(())
}

// Two frames deep: the inner call clobbers x30, so the outer return needs the spill.
#[test]
fn example_nested_call_two_levels_returns_to_call_sites() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("test:".to_string());
    program.push("str x30,[sp,#0]".to_string());
    program.push("bl outer".to_string());
    program.push("ldr x30,[sp,#0]".to_string());
    program.push("add x0,x0,#1".to_string());
    program.push("ret".to_string());
    program.push("outer:".to_string());
    program.push("str x30,[sp,#8]".to_string());
    program.push("bl inner".to_string());
    program.push("ldr x30,[sp,#8]".to_string());
    program.push("add x0,x0,#10".to_string());
    program.push("ret".to_string());
    program.push("inner:".to_string());
    program.push("add x0,x0,#100".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_immediate(String::from("x0"), 0);

    let res = engine.start("test".to_string());

    assert!(res.is_ok());
    assert_eq!(engine.get_register_output(0).base, None);
    assert_eq!(engine.get_register_output(0).offset, 111);
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

// Records which side of a carry-driven branch ran: 2 for taken, 1 for fallthrough.
fn carry_branch_program(compare: &str, branch: &str) -> Vec<String> {
    vec![
        "start:".to_string(),
        compare.to_string(),
        branch.to_string(),
        "add x0,x0,#1".to_string(),
        "ret".to_string(),
        "taken:".to_string(),
        "add x0,x0,#2".to_string(),
        "ret".to_string(),
    ]
}

fn run_carry_branch(program: Vec<String>, x1: usize, x2: usize) -> i64 {
    init();

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_immediate(String::from("x0"), 0);
    engine.add_immediate(String::from("x1"), x1);
    engine.add_immediate(String::from("x2"), x2);

    engine.start("start".to_string()).expect("program runs");
    engine.get_register_output(0).offset
}

#[test]
fn example_cmp_carry_set_when_unsigned_greater_or_equal() -> std::io::Result<()> {
    let program = carry_branch_program("cmp x1,x2", "b.cs taken");
    assert_eq!(run_carry_branch(program, 8, 4), 2);
    Ok(())
}

#[test]
fn example_cmp_carry_clear_when_unsigned_less() -> std::io::Result<()> {
    let program = carry_branch_program("cmp x1,x2", "b.cs taken");
    assert_eq!(run_carry_branch(program, 4, 8), 1);
    Ok(())
}

// -1 is below 1 signed but above it unsigned, so carry must read the operands as u64.
#[test]
fn example_cmp_carry_uses_unsigned_comparison() -> std::io::Result<()> {
    let program = carry_branch_program("cmp x1,x2", "b.cs taken");
    assert_eq!(run_carry_branch(program, usize::MAX, 1), 2);
    Ok(())
}

// b.ls is taken on Z set or carry clear.
#[test]
fn example_cmp_carry_clear_takes_b_ls() -> std::io::Result<()> {
    let program = carry_branch_program("cmp x1,x2", "b.ls taken");
    assert_eq!(run_carry_branch(program, 4, 8), 2);
    Ok(())
}

#[test]
fn example_cmp_equal_operands_set_carry() -> std::io::Result<()> {
    let program = carry_branch_program("cmp x1,x2", "b.cs taken");
    assert_eq!(run_carry_branch(program, 6, 6), 2);
    Ok(())
}

// Signed overflow must not flip b.gt, since neg already holds the signed comparison.
#[test]
fn example_cmp_signed_overflow_does_not_flip_b_gt() -> std::io::Result<()> {
    let program = carry_branch_program("cmp x1,x2", "b.gt taken");
    assert_eq!(run_carry_branch(program, i64::MIN as usize, 1), 1);
    Ok(())
}

// -1 + 1 wraps past u64::MAX, so carry is set even though the signed sum is zero.
#[test]
fn example_cmn_carry_set_on_unsigned_carry_out() -> std::io::Result<()> {
    let program = carry_branch_program("cmn x1,x2", "b.cs taken");
    assert_eq!(run_carry_branch(program, usize::MAX, 1), 2);
    Ok(())
}

#[test]
fn example_cmn_no_carry_out_without_wrap() -> std::io::Result<()> {
    let program = carry_branch_program("cmn x1,x2", "b.cs taken");
    assert_eq!(run_carry_branch(program, 2, 3), 1);
    Ok(())
}

// Guards a symbolic index with `b.cs`, so the fallthrough must carry `x1 < 8`.
fn symbolic_carry_guard(program: Vec<String>) -> std::io::Result<()> {
    init();

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        AbstractExpression::Immediate(8),
    );
    engine.add_abstract_from(1, "i".to_string());
    // The carry guard only bounds the index from above.
    engine.add_invariant(AbstractComparison::new(
        ">=",
        AbstractExpression::Abstract("i".to_string()),
        AbstractExpression::Immediate(0),
    ));

    let res = engine.start("start".to_string());
    assert!(res.is_ok());
    Ok(())
}

#[test]
fn example_symbolic_carry_bounds_index_via_b_cs() -> std::io::Result<()> {
    symbolic_carry_guard(vec![
        "start:".to_string(),
        "cmp x1,#8".to_string(),
        "b.cs done".to_string(),
        "add x0,x0,x1".to_string(),
        "ldr x2,[x0,#0]".to_string(),
        "done:".to_string(),
        "ret".to_string(),
    ])
}

#[test]
fn example_symbolic_carry_bounds_index_via_b_cc() -> std::io::Result<()> {
    symbolic_carry_guard(vec![
        "start:".to_string(),
        "cmp x1,#8".to_string(),
        "b.cc inbounds".to_string(),
        "ret".to_string(),
        "inbounds:".to_string(),
        "add x0,x0,x1".to_string(),
        "ldr x2,[x0,#0]".to_string(),
        "ret".to_string(),
    ])
}

// Addition does not cancel a shared base, so `cmn x1,x1` must not report equality.
#[test]
fn example_cmn_same_register_not_assumed_equal() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("cmn x1,x1".to_string());
    program.push("b.ne bad".to_string());
    program.push("ret".to_string());
    program.push("bad:".to_string());
    program.push("ldr x2,[x0,#64]".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        AbstractExpression::Immediate(8),
    );
    engine.add_abstract_from(1, "val".to_string());

    let res = engine.start("start".to_string());
    assert!(res.is_err());
    Ok(())
}
