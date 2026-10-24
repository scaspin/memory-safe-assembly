use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

#[test]
fn example_stack_push_pop() {
    init();

    let mut program = Vec::new();
    let start_label = "test";
    program.push("test:");
    program.push("sub sp,sp,#16");
    program.push("add x3,x3,#21");
    program.push("str x3,[sp,#4]");
    program.push("ldr x0,[sp,#4]");
    program.push("add sp,sp,#16");
    program.push("ret");

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_immediate("x3", 1);

    let res = engine.start(start_label);

    assert!(res.is_ok());
    assert_eq!(engine.get_register_output(0).base, None);
    assert_eq!(engine.get_register_output(0).offset, 22);
}

#[test]
fn example_basic_abstract_loop() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    let start_label = "test";
    program.push("test:");
    program.push("add x3,x1,x2");
    program.push("loop:");
    program.push("ldr x4,[x1]");
    program.push("add x1,x1,#4");
    program.push("cmp x1,x3");
    program.push("b.ne loop");
    program.push("add x4,x4,#4");
    program.push("ret");

    let mut engine = bums::engine::ExecutionEngine::new(program);

    let length = abstract_of("Length");
    let base = abstract_of("Base");
    engine.add_abstract("x1", base.clone());
    engine.add_region(RegionType::READ, "Base", length.clone());

    engine.add_abstract("x2", length);

    engine.change_alignment(1);
    let res = engine.start(start_label);
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_bad_increment_abstract_loop() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    let start_label = "test";
    program.push("test:");
    program.push("add x3,x1,x2");
    program.push("loop:");
    program.push("add x1,x1,#1");
    program.push("ldr x4,[x1]");
    program.push("cmp x1,x3");
    program.push("b.ne loop");
    program.push("add x4,x4,#4");

    let mut engine = bums::engine::ExecutionEngine::new(program);

    let length = abstract_of("Length");
    let base = abstract_of("Base");
    engine.add_abstract("x1", base.clone());
    engine.add_region(RegionType::READ, "Base", length.clone());

    engine.add_abstract("x2", length);

    engine.change_alignment(1);
    let res = engine.start(start_label);
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_loop_on_input_abstract_loop() -> std::io::Result<()> {
    init();

    let mut program = Vec::new();
    let start_label = "test";
    program.push("test:");
    program.push("add x3,x1,x2");
    program.push("loop:");
    program.push("ldr x5,[x1]");
    program.push("add x1,x1,#1");
    program.push("cmp x1,x3");
    program.push("b.ne loop");
    program.push("add x4,x4,#4");
    program.push("ret");

    let mut engine = bums::engine::ExecutionEngine::new(program);

    let length1 = abstract_of("Length1");
    let length2 = abstract_of("Length2");
    let base1 = abstract_of("Base1");

    engine.add_abstract("x1", base1.clone());
    engine.add_region(RegionType::READ, "Base1", length1);
    engine.add_abstract("x2", length2.clone());

    engine.change_alignment(1);
    let res = engine.start(start_label);
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_z3_abstract_bound_unsafe() -> std::io::Result<()> {
    init();

    let mut program = vec!["start:"];
    program.extend(["ldr x1,[x0,#4]"; 5]);

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));

    let res = engine.start("start");
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_z3_abstract_bound_unsafe_zero() -> std::io::Result<()> {
    init();

    let program = vec!["start:", "ldr x1,[x0,#0]"];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));

    let res = engine.start("start");
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_unrelated_unknowns_not_treated_as_equal() -> std::io::Result<()> {
    init();

    let program = vec![
        "start:",
        "ldr x1,[x0,#0]",
        "ldr x2,[x0,#4]",
        "cmp x1,x2",
        "b.eq bad",
        "ret",
        "bad:",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(8));

    let res = engine.start("start");
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_unrelated_unknowns_not_treated_as_equal_cmn() -> std::io::Result<()> {
    init();

    let program = vec![
        "start:",
        "ldr x1,[x0,#0]",
        "ldr x2,[x0,#4]",
        "cmn x1,x2",
        "b.eq bad",
        "ret",
        "bad:",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(8));

    let res = engine.start("start");
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_z3_real_bound_safe() -> std::io::Result<()> {
    init();

    let program = vec!["start:", "ldr x1,[x0,#0]", "ldr x1,[x0,#4]", "ret"];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(12));

    let res = engine.start("start");
    assert!(res.is_ok());
    Ok(())
}

#[test]
fn example_z3_symbolic_base_boundary_unsafe() -> std::io::Result<()> {
    init();

    let program = vec!["start:", "add x0,x0,#8", "ldr x1,[x0,#0]"];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(1));

    let res = engine.start("start");
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_z3_symbolic_base_boundary_safe() -> std::io::Result<()> {
    init();

    let program = vec!["start:", "add x0,x0,#4", "ldr x1,[x0,#0]", "ret"];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(12));

    let res = engine.start("start");
    assert!(res.is_ok());
    Ok(())
}

#[test]
fn example_z3_symbolic_base_last_byte_safe() -> std::io::Result<()> {
    init();

    let program = vec!["start:", "add x0,x0,#7", "ldrb w1,[x0,#0]", "ret"];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(8));

    let res = engine.start("start");
    assert!(res.is_ok());
    Ok(())
}

#[test]
fn example_z3_symbolic_base_below_region_unsafe() -> std::io::Result<()> {
    init();

    let program = vec!["start:", "sub x0,x0,#8", "ldr x1,[x0,#0]"];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(1));

    let res = engine.start("start");
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_z3_write_to_read_only_region_unsafe() -> std::io::Result<()> {
    init();

    let program = vec!["start:", "str x1,[x0,#0]"];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(8));

    let res = engine.start("start");
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_z3_read_from_write_region_safe() -> std::io::Result<()> {
    init();

    let program = vec!["start:", "ldr x1,[x0,#0]", "ret"];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::WRITE, "base", AbstractExpression::Immediate(8));

    let res = engine.start("start");
    assert!(res.is_ok());
    Ok(())
}

#[test]
fn example_z3_real_bound_unsafe() -> std::io::Result<()> {
    init();

    let program = vec!["start:", "ldr x1,[x0,#0]", "ldr x1,[x0,#16]"];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(8));

    let res = engine.start("start");
    assert!(res.is_err());
    let Err(e) = res else { panic!() };
    assert_eq!(
        e.to_string(),
        "line 2 (ldr): read of 8 bytes at base + 16 not provably within region of length 8"
    );
    Ok(())
}

#[test]
fn example_z3_simple_loop_with_no_mem_access() -> std::io::Result<()> {
    init();

    let program = vec![
        "start:",
        "add x1,#0,#0",
        "add x2,#0,#4",
        "loop:",
        "add x1,x1,#1",
        "cmp x1,x2",
        "b.ne loop",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    let res = engine.start("start");
    assert!(res.is_ok());
    Ok(())
}

#[test]
fn example_z3_simple_loop_with_mem_access_safe() -> std::io::Result<()> {
    init();

    let program = vec![
        "start:",
        "add x1,#0,#0",
        "add x2,#0,#4",
        "loop:",
        "ldr x3,[x0,#0]",
        "add x1,x1,#1",
        "add x0,x0,#4",
        "cmp x1,x2",
        "b.ne loop",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(20));

    let res = engine.start("start");
    assert!(res.is_ok());
    Ok(())
}

#[test]
fn example_z3_complex_loop_with_mem_access_unsafe() -> std::io::Result<()> {
    init();

    let program = vec![
        "start:",
        "add x1,x0,x1",
        "loop:",
        "cmp x0,x1",
        "b.eq end",
        "ldr x3,[x0,#0]",
        "add x0,x0,#4",
        "b loop",
        "end:",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));
    engine.add_abstract_from(1, "length");

    let res = engine.start("start");
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_z3_complex_loop_with_no_mem_access() -> std::io::Result<()> {
    init();

    let program = vec![
        "start:",
        "add x1,x0,x1",
        "loop:",
        "cmp x0,x1",
        "b.eq end",
        "add x0,x0,#4",
        "b loop",
        "end:",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));
    engine.add_abstract_from(1, "length");

    let res = engine.start("start");
    assert!(res.is_ok());
    Ok(())
}

#[test]
fn example_nested_call_returns_to_call_site() -> std::io::Result<()> {
    init();

    let program = vec![
        "test:",
        "sub sp,sp,#16",
        "str x30,[sp,#0]",
        "bl sub",
        "ldr x30,[sp,#0]",
        "add sp,sp,#16",
        "add x0,x0,#1",
        "ret",
        "sub:",
        "add x0,x0,#10",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_immediate("x0", 0);

    let res = engine.start("test");

    assert!(res.is_ok());
    assert_eq!(engine.get_register_output(0).base, None);
    assert_eq!(engine.get_register_output(0).offset, 11);
    Ok(())
}

#[test]
fn example_unconditional_self_loop_bounded() -> std::io::Result<()> {
    init();

    let program = vec!["spin:", "add x0,x0,#1", "b spin"];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_immediate("x0", 0);

    let res = engine.start("spin");
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_ret_to_self_bounded() -> std::io::Result<()> {
    init();

    let program = vec!["test:", "mov x30,#0", "ret"];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    let res = engine.start("test");
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_unconditional_forward_jump_terminates() -> std::io::Result<()> {
    init();

    let program = vec![
        "test:",
        "add x0,x0,#1",
        "b second",
        "add x0,x0,#100",
        "second:",
        "add x0,x0,#10",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_immediate("x0", 0);

    let res = engine.start("test");

    assert!(res.is_ok());
    assert_eq!(engine.get_register_output(0).base, None);
    assert_eq!(engine.get_register_output(0).offset, 11);
    Ok(())
}

#[test]
fn example_nested_call_two_levels_returns_to_call_sites() -> std::io::Result<()> {
    init();

    let program = vec![
        "test:",
        "sub sp,sp,#16",
        "str x30,[sp,#0]",
        "bl outer",
        "ldr x30,[sp,#0]",
        "add sp,sp,#16",
        "add x0,x0,#1",
        "ret",
        "outer:",
        "str x30,[sp,#8]",
        "bl inner",
        "ldr x30,[sp,#8]",
        "add x0,x0,#10",
        "ret",
        "inner:",
        "add x0,x0,#100",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_immediate("x0", 0);

    let res = engine.start("test");

    assert!(res.is_ok());
    assert_eq!(engine.get_register_output(0).base, None);
    assert_eq!(engine.get_register_output(0).offset, 111);
    Ok(())
}

#[test]
fn example_z3_example_branch() -> std::io::Result<()> {
    let program = vec![
        "start:",
        "cmp x1,x2",
        "b.ne branch",
        "add x0,x0,#4",
        "b end",
        "branch:",
        "add x0,x0,#2",
        "end:",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "left");
    engine.add_abstract_from(1, "right");

    let res = engine.start("start");
    assert!(res.is_ok());
    Ok(())
}

fn carry_branch_program<'a>(compare: &'a str, branch: &'a str) -> Vec<&'a str> {
    vec![
        "start:",
        compare,
        branch,
        "add x0,x0,#1",
        "ret",
        "taken:",
        "add x0,x0,#2",
        "ret",
    ]
}

fn run_carry_branch(program: Vec<&str>, x1: usize, x2: usize) -> i64 {
    init();

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_immediate("x0", 0);
    engine.add_immediate("x1", x1);
    engine.add_immediate("x2", x2);

    engine.start("start").expect("program runs");
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

#[test]
fn example_cmp_carry_uses_unsigned_comparison() -> std::io::Result<()> {
    let program = carry_branch_program("cmp x1,x2", "b.cs taken");
    assert_eq!(run_carry_branch(program, usize::MAX, 1), 2);
    Ok(())
}

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

#[test]
fn example_cmp_signed_overflow_does_not_flip_b_gt() -> std::io::Result<()> {
    let program = carry_branch_program("cmp x1,x2", "b.gt taken");
    assert_eq!(run_carry_branch(program, i64::MIN as usize, 1), 1);
    Ok(())
}

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

#[test]
fn example_b_ls_is_unsigned() -> std::io::Result<()> {
    let program = carry_branch_program("cmp x1,x2", "b.ls taken");
    assert_eq!(run_carry_branch(program, usize::MAX, 1), 1);
    Ok(())
}

#[test]
fn example_b_le_is_signed() -> std::io::Result<()> {
    let program = carry_branch_program("cmp x1,x2", "b.le taken");
    assert_eq!(run_carry_branch(program, usize::MAX, 1), 2);
    Ok(())
}

#[test]
fn example_b_le_falls_through_when_greater() -> std::io::Result<()> {
    let program = carry_branch_program("cmp x1,x2", "b.le taken");
    assert_eq!(run_carry_branch(program, 9, 4), 1);
    Ok(())
}

#[test]
fn example_b_ls_and_b_le_agree_on_equality() -> std::io::Result<()> {
    let ls = carry_branch_program("cmp x1,x2", "b.ls taken");
    let le = carry_branch_program("cmp x1,x2", "b.le taken");
    assert_eq!(run_carry_branch(ls, 5, 5), 2);
    assert_eq!(run_carry_branch(le, 5, 5), 2);
    Ok(())
}

fn symbolic_carry_guard(program: Vec<&str>) -> std::io::Result<()> {
    init();

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(16));
    engine.add_abstract_from(1, "i");
    engine.add_invariant(AbstractComparison::new(
        ">=",
        abstract_of("i"),
        AbstractExpression::Immediate(0),
    ));

    let res = engine.start("start");
    assert!(res.is_ok());
    Ok(())
}

#[test]
fn example_symbolic_carry_bounds_index_via_b_cs() -> std::io::Result<()> {
    symbolic_carry_guard(vec![
        "start:",
        "cmp x1,#8",
        "b.cs done",
        "add x0,x0,x1",
        "ldr x2,[x0,#0]",
        "done:",
        "ret",
    ])
}

#[test]
fn example_symbolic_carry_bounds_index_via_b_cc() -> std::io::Result<()> {
    symbolic_carry_guard(vec![
        "start:",
        "cmp x1,#8",
        "b.cc inbounds",
        "ret",
        "inbounds:",
        "add x0,x0,x1",
        "ldr x2,[x0,#0]",
        "ret",
    ])
}

#[test]
fn example_cmn_same_register_not_assumed_equal() -> std::io::Result<()> {
    init();

    let program = vec![
        "start:",
        "cmn x1,x1",
        "b.ne bad",
        "ret",
        "bad:",
        "ldr x2,[x0,#64]",
        "ret",
    ];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", AbstractExpression::Immediate(8));
    engine.add_abstract_from(1, "val");

    let res = engine.start("start");
    assert!(res.is_err());
    Ok(())
}

#[test]
fn example_infeasible_path_does_not_prove_access_safe() -> std::io::Result<()> {
    init();

    let program = vec!["start:", "ldr x2,[x0,#0]", "ret"];

    let mut engine = bums::engine::ExecutionEngine::new(program);

    engine.add_abstract_from(0, "base");
    engine.add_region(RegionType::READ, "base", abstract_of("length"));
    engine.add_invariant(AbstractComparison::new(
        ">",
        abstract_of("length"),
        AbstractExpression::Immediate(10),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<",
        abstract_of("length"),
        AbstractExpression::Immediate(5),
    ));

    let err = engine.start("start").unwrap_err().to_string();
    assert!(err.contains("path has no model"), "{err}");
    Ok(())
}
