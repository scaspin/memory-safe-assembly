use super::*;

fn run(computer: &mut X86_64, line: &str) -> ExecuteReturnType<Operand> {
    computer
        .execute(0, &Instruction::new(line.to_string()))
        .unwrap_or_else(|e| panic!("{line}: {e}"))
}

#[test]
fn add_immediate_to_abstract_keeps_the_base() {
    let mut c = X86_64::new();
    c.set_abstract("rdi".to_string(), abstract_of("buf"));
    run(&mut c, "addq $16,%rdi");
    assert_eq!(c.registers[RDI].base, Some(abstract_of("buf")));
    assert_eq!(c.registers[RDI].offset, 16);
}

#[test]
fn xor_of_a_register_with_itself_is_zero() {
    let mut c = X86_64::new();
    run(&mut c, "xorl %eax,%eax");
    assert_eq!(c.registers[RAX], RegisterValue::new_imm(0));
}

#[test]
fn a_32_bit_write_zero_extends() {
    let mut c = X86_64::new();
    c.set_immediate("rax".to_string(), u64::MAX);
    run(&mut c, "movl $5,%eax");
    assert_eq!(c.registers[RAX], RegisterValue::new_imm(5));
}

#[test]
fn an_8_bit_write_merges_into_the_register() {
    let mut c = X86_64::new();
    c.set_immediate("rax".to_string(), 0x1234);
    run(&mut c, "movb $0xff,%al");
    assert_eq!(c.registers[RAX], RegisterValue::new_imm(0x12ff));
    run(&mut c, "movb $0x56,%ah");
    assert_eq!(c.registers[RAX], RegisterValue::new_imm(0x56ff));
}

#[test]
fn push_and_pop_round_trip_through_the_stack() {
    let mut c = X86_64::new();
    c.set_abstract("rbx".to_string(), abstract_of("saved"));
    run(&mut c, "pushq %rbx");
    assert_eq!(c.registers[RSP].offset, -8);
    run(&mut c, "movq $0,%rbx");
    run(&mut c, "popq %rbx");
    assert_eq!(c.registers[RBX].base, Some(abstract_of("saved")));
    assert_eq!(c.registers[RSP].offset, 0);
}

#[test]
fn ret_at_entry_returns_to_the_caller() {
    let mut c = X86_64::new();
    assert_eq!(
        run(&mut c, "ret"),
        ExecuteReturnType::JumpLabel(RETURN.to_string())
    );
}

#[test]
fn ret_after_the_return_address_is_overwritten_is_an_error() {
    let mut c = X86_64::new();
    run(&mut c, "movq $0,(%rsp)");
    assert!(c.execute(0, &Instruction::new("ret".to_string())).is_err());
}

#[test]
fn a_load_within_a_region_is_accepted() {
    let mut c = X86_64::new();
    c.add_memory_region(
        "buf".to_string(),
        RegionType::READ,
        AbstractExpression::Immediate(64),
    );
    c.set_abstract("rsi".to_string(), abstract_of("buf"));
    run(&mut c, "movq 56(%rsi),%rax");
    assert!(
        c.execute(0, &Instruction::new("movq 57(%rsi),%rax".to_string()))
            .is_err()
    );
}

#[test]
fn a_store_into_a_read_only_region_is_rejected() {
    let mut c = X86_64::new();
    c.add_memory_region(
        "buf".to_string(),
        RegionType::READ,
        AbstractExpression::Immediate(64),
    );
    c.set_abstract("rdi".to_string(), abstract_of("buf"));
    assert!(
        c.execute(0, &Instruction::new("movq %rax,(%rdi)".to_string()))
            .is_err()
    );
}

#[test]
fn a_vector_load_is_checked_at_its_full_width() {
    let mut c = X86_64::new();
    c.add_memory_region(
        "buf".to_string(),
        RegionType::READ,
        AbstractExpression::Immediate(32),
    );
    c.set_abstract("rsi".to_string(), abstract_of("buf"));
    run(&mut c, "movdqu 16(%rsi),%xmm0");
    assert!(
        c.execute(0, &Instruction::new("vmovdqu 8(%rsi),%ymm0".to_string()))
            .is_err()
    );
}

#[test]
fn a_pointer_parked_in_an_xmm_register_comes_back() {
    let mut c = X86_64::new();
    c.set_abstract("rdi".to_string(), abstract_of("out"));
    run(&mut c, "movq %rdi,%xmm0");
    run(&mut c, "xorl %edi,%edi");
    run(&mut c, "movq %xmm0,%rdi");
    assert_eq!(c.registers[RDI].base, Some(abstract_of("out")));
}

#[test]
fn compare_of_immediates_sets_unsigned_borrow() {
    let mut c = X86_64::new();
    c.set_immediate("rax".to_string(), 1);
    run(&mut c, "cmpq $2,%rax");
    assert_eq!(
        run(&mut c, "jb L$taken"),
        ExecuteReturnType::JumpLabel("L$taken".to_string())
    );
    assert_eq!(run(&mut c, "ja L$taken"), ExecuteReturnType::Next);
    assert_eq!(
        run(&mut c, "jl L$taken"),
        ExecuteReturnType::JumpLabel("L$taken".to_string())
    );
}

#[test]
fn compare_of_abstracts_branches_on_their_ordering() {
    let mut c = X86_64::new();
    c.set_abstract("rsi".to_string(), abstract_of("p"));
    c.set_abstract("rdi".to_string(), abstract_of("end"));
    run(&mut c, "cmpq %rdi,%rsi");
    match run(&mut c, "jbe L$x") {
        ExecuteReturnType::ConditionalJumpLabel(cond, label) => {
            assert_eq!(label, "L$x");
            assert_eq!(cond.op, "<=");
        }
        other => panic!("{other:?}"),
    }
}

#[test]
fn rep_stos_checks_the_whole_range() {
    let mut c = X86_64::new();
    c.add_memory_region("buf".to_string(), RegionType::RW, abstract_of("len"));
    c.set_abstract("rdi".to_string(), abstract_of("buf"));
    c.set_abstract("rcx".to_string(), abstract_of("len"));
    run(&mut c, "rep stosb");
    assert_eq!(c.registers[RCX], RegisterValue::new_imm(0));
    c.set_abstract("rdi".to_string(), abstract_of("buf"));
    c.set_abstract("rcx".to_string(), abstract_of("len"));
    assert!(
        c.execute(0, &Instruction::new("rep stosq".to_string()))
            .is_err()
    );
}

#[test]
fn stack_arguments_sit_above_the_return_address() {
    let mut c = X86_64::new();
    c.set_argument(6, abstract_of("seventh"));
    run(&mut c, "movq 8(%rsp),%rax");
    assert_eq!(c.registers[RAX].base, Some(abstract_of("seventh")));
    assert!(
        c.execute(0, &Instruction::new("movq 16(%rsp),%rax".to_string()))
            .is_err()
    );
}

#[test]
fn aligning_the_stack_pointer_keeps_it_on_the_stack() {
    let mut c = X86_64::new();
    run(&mut c, "subq $72,%rsp");
    run(&mut c, "andq $-64,%rsp");
    assert_eq!(c.registers[RSP].base, Some(abstract_of(STACK)));
    assert_eq!(c.registers[RSP].offset, -128);
}

#[test]
fn an_arithmetic_shift_of_a_negative_value_rounds_down() {
    let mut c = X86_64::new();
    c.set_abstract("rax".to_string(), abstract_of("v"));
    c.solver
        .assert(ast::Int::new_const("v").eq(ast::Int::from_i64(-9)));
    run(&mut c, "sarq $3,%rax");
    let value = expression_to_ast(c.registers[RAX].expression()).unwrap();
    let other = value.eq(ast::Int::from_i64(-2)).not();
    assert_eq!(c.solver.check_assumptions(&[other]), SatResult::Unsat);
}

#[test]
fn a_subtraction_of_immediates_borrows_when_it_wraps() {
    let mut c = X86_64::new();
    c.set_immediate("rax".to_string(), 16);
    run(&mut c, "subq $32,%rax");
    assert_eq!(
        run(&mut c, "jb L$taken"),
        ExecuteReturnType::JumpLabel("L$taken".to_string())
    );
}

#[test]
fn a_32_bit_result_below_zero_sets_the_sign_flag() {
    let mut c = X86_64::new();
    c.set_abstract("rcx".to_string(), abstract_of("v"));
    c.solver
        .assert(ast::Int::new_const("v").eq(ast::Int::from_i64(0)));
    run(&mut c, "decl %ecx");
    let ExecuteReturnType::ConditionalJumpLabel(condition, _) = run(&mut c, "jg L$loop") else {
        panic!("a symbolic count gives a symbolic condition");
    };
    let taken = comparison_to_ast(condition).unwrap();
    assert_eq!(c.solver.check_assumptions(&[taken]), SatResult::Unsat);
}
