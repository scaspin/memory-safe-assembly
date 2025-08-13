use crate::common::*;
use crate::instruction_parser::*;
use std::collections::HashMap;
use std::fmt;
use z3::*;

mod instruction_aux;
mod memory;
mod simd;

#[derive(Clone)]
pub struct ARMCORTEXA<'ctx> {
    pub registers: [RegisterValue; 33],
    pub simd_registers: [SimdRegister; 32],
    zero: Option<FlagValue>,
    neg: Option<FlagValue>,
    pub carry: Option<FlagValue>,
    overflow: Option<FlagValue>,
    pub memory: HashMap<String, MemorySafeRegion>,
    pub memory_labels: HashMap<String, i64>,
    rw_queue: Vec<MemoryAccess>,
    alignment: i64,
    pub context: &'ctx Context,
    pub solver: Solver<'ctx>,
}

impl<'ctx> fmt::Debug for ARMCORTEXA<'ctx> {
    fn fmt(&self, _f: &mut fmt::Formatter<'_>) -> fmt::Result {
        println!("registers {:#?}", &self.registers);
        println!("simd registers {:?}", &self.simd_registers);
        Ok(())
    }
}

impl<'ctx> ARMCORTEXA<'_> {
    pub fn new(context: &'ctx Context) -> ARMCORTEXA<'ctx> {
        let registers = [
            RegisterValue::new_empty("x0"),
            RegisterValue::new_empty("x1"),
            RegisterValue::new_empty("x2"),
            RegisterValue::new_empty("x3"),
            RegisterValue::new_empty("x4"),
            RegisterValue::new_empty("x5"),
            RegisterValue::new_empty("x6"),
            RegisterValue::new_empty("x7"),
            RegisterValue::new_empty("x8"),
            RegisterValue::new_empty("x9"),
            RegisterValue::new_empty("x10"),
            RegisterValue::new_empty("x11"),
            RegisterValue::new_empty("x12"),
            RegisterValue::new_empty("x13"),
            RegisterValue::new_empty("x14"),
            RegisterValue::new_empty("x15"),
            RegisterValue::new_empty("x16"),
            RegisterValue::new_empty("x17"),
            RegisterValue::new_empty("x18"),
            RegisterValue::new_empty("x19"),
            RegisterValue::new_empty("x20"),
            RegisterValue::new_empty("x21"),
            RegisterValue::new_empty("x22"),
            RegisterValue::new_empty("x23"),
            RegisterValue::new_empty("x24"),
            RegisterValue::new_empty("x25"),
            RegisterValue::new_empty("x26"),
            RegisterValue::new_empty("x27"),
            RegisterValue::new_empty("x28"),
            RegisterValue::new_empty("x29"), // frame pointer
            RegisterValue::new(
                RegisterKind::RegisterBase,
                Some(AbstractExpression::Abstract("return".to_string())),
                0,
            ), // link
            RegisterValue::new_empty("sp"),  // stack pointer
            RegisterValue::new(RegisterKind::Immediate, None, 0), // 64-bit zero
        ];

        let simd_registers = [
            SimdRegister::new("v0"),
            SimdRegister::new("v1"),
            SimdRegister::new("v2"),
            SimdRegister::new("v3"),
            SimdRegister::new("v4"),
            SimdRegister::new("v5"),
            SimdRegister::new("v6"),
            SimdRegister::new("v7"),
            SimdRegister::new("v8"),
            SimdRegister::new("v9"),
            SimdRegister::new("v10"),
            SimdRegister::new("v11"),
            SimdRegister::new("v12"),
            SimdRegister::new("v13"),
            SimdRegister::new("v14"),
            SimdRegister::new("v15"),
            SimdRegister::new("v16"),
            SimdRegister::new("v17"),
            SimdRegister::new("v18"),
            SimdRegister::new("v19"),
            SimdRegister::new("v20"),
            SimdRegister::new("v21"),
            SimdRegister::new("v22"),
            SimdRegister::new("v23"),
            SimdRegister::new("v24"),
            SimdRegister::new("v25"),
            SimdRegister::new("v26"),
            SimdRegister::new("v27"),
            SimdRegister::new("v28"),
            SimdRegister::new("v29"),
            SimdRegister::new("v30"),
            SimdRegister::new("v31"),
        ];

        let solver = Solver::new(&context);
        let mut memory = HashMap::new();

        let max = ast::Int::from_i64(context, i64::MAX);
        let stack_max = ast::Int::new_const(context, "MAX");
        solver.assert(&stack_max.ge(&max));

        memory.insert(
            "sp".to_string(),
            MemorySafeRegion::new(
                AbstractExpression::Abstract("MAX".to_string()),
                RegionType::RW,
            ),
        );

        ARMCORTEXA {
            registers,
            simd_registers,
            zero: None,
            neg: None,
            carry: None,
            overflow: None,
            memory,
            memory_labels: HashMap::new(),
            rw_queue: Vec::new(),
            alignment: 4,
            context,
            solver,
        }
    }

    pub fn get_state(
        &self,
    ) -> (
        [RegisterValue; 33],
        // [SimdRegister; 32],
        Option<FlagValue>,
        Option<FlagValue>,
        Option<FlagValue>,
        Option<FlagValue>,
    ) {
        return (
            self.registers.clone(),
            // self.simd_registers.clone(),
            self.zero.clone(),
            self.neg.clone(),
            self.carry.clone(),
            self.overflow.clone(),
        );
    }

    pub fn set_immediate(&mut self, register: String, value: u64) {
        self.set_register(
            &operand_from_string(register),
            RegisterKind::Immediate,
            None,
            value as i64,
        );
    }

    pub fn set_abstract(&mut self, register: String, value: AbstractExpression) {
        self.set_register(
            &operand_from_string(register),
            RegisterKind::RegisterBase,
            Some(value),
            0,
        );
    }

    pub fn set_stack_element(
        &mut self,
        address: i64,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        let stack = self.memory.get_mut("sp").expect("Stack not found");
        stack.insert(
            address,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base,
                offset,
            },
        );
    }

    pub fn set_register(
        &mut self,
        register: &Operand,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        self.set_register_from_tuple(register_to_tuple(&register), kind, base, offset);
    }

    fn set_register_from_tuple(
        &mut self,
        register: (RePrefix, usize),
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        match register.0 {
            RePrefix::X => {
                self.registers[register.1].set(kind, base, offset);
            }
            RePrefix::W => {
                if register.1 < 31 {
                    self.registers[register.1].set(kind, base, (offset as i32) as i64);
                } else {
                    log::error!("Cannot set W register for xzr or sp");
                }
            }
            RePrefix::V => {
                self.simd_registers[register.1].set_register(
                    "b".to_string(),
                    kind,
                    base,
                    offset as u128,
                ); // FIX
            }
            _ => todo!(),
        }
    }

    pub fn get_register(&mut self, reg: &Operand) -> RegisterValue {
        return match reg {
            // TODO: reimplement accessing half a register using w
            Operand::Register(prefix, index) => match prefix {
                RePrefix::Fp => self.registers[29].clone(),
                RePrefix::Ra => self.registers[30].clone(),
                RePrefix::Sp => self.registers[31].clone(),
                RePrefix::Ze => self.registers[32].clone(),
                RePrefix::X | RePrefix::W => self.registers[*index].clone(),
                _ => todo!("invalid register prefix in get register"),
            },
            Operand::Immediate(value) => RegisterValue::new_imm(*value),
            Operand::VectorRegister(_, index) => self.simd_registers[*index].get_as_register(),
            _ => panic!("Not a valid register operand for operation"),
        };
    }

    fn get_simd_register(&mut self, reg: &Operand) -> SimdRegister {
        return match reg {
            Operand::VectorRegister(_, index) => self.simd_registers[*index].clone(),
            Operand::Vector(_, index, _) => self.simd_registers[*index].clone(),
            Operand::VectorAccess(_, index, _, _) => self.simd_registers[*index].clone(),
            _ => panic!("Not a valid vector register operand for operation"),
        };
    }

    pub fn add_memory_value(&mut self, region: String, address: i64, value: i64) {
        let reg_value = RegisterValue::new(RegisterKind::Immediate, None, value);
        match self.memory.get_mut(&region) {
            Some(r) => {
                r.insert(address, reg_value);
            }
            None => {
                let mut region_map =
                    MemorySafeRegion::new(AbstractExpression::Immediate(0), RegionType::RW);
                region_map.insert(address, reg_value);
                self.memory.insert(region, region_map);
            }
        }
    }

    pub fn add_memory_value_abstract(
        &mut self,
        region: String,
        address: i64,
        value: AbstractExpression,
    ) {
        let reg_value = RegisterValue::new(RegisterKind::RegisterBase, Some(value), 0);
        match self.memory.get_mut(&region) {
            Some(r) => {
                r.insert(address, reg_value);
            }
            None => {
                let mut region_map =
                    MemorySafeRegion::new(AbstractExpression::Immediate(0), RegionType::RW);
                region_map.insert(address, reg_value);
                self.memory.insert(region, region_map);
            }
        }
    }

    pub fn add_memory_region(&mut self, name: String, ty: RegionType, length: AbstractExpression) {
        let new_region = MemorySafeRegion::new(length, ty);
        self.memory.insert(name, new_region);
    }

    fn label_to_memory_index(&self, label: String) -> (String, i64) {
        return ("memory".to_string(), 0);
    }

    pub fn check_stack_pointer_restored(&self) {
        let s = &self.registers[31];
        match &s.base {
            Some(b) => {
                if b == &AbstractExpression::Abstract("sp".to_string()) && s.offset == 0 {
                    log::info!("Stack pointer restored to start");
                } else {
                    log::error!("Stack pointer offset not restored");
                }
            }
            None => {
                log::error!("Stack pointer not restored {:?}", s.base);
            }
        }
    }

    pub fn clear_rw_queue(&mut self) {
        self.rw_queue = Vec::new();
    }

    pub fn read_rw_queue(&self) -> Vec<MemoryAccess> {
        self.rw_queue.clone()
    }

    pub fn change_alignment(&mut self, value: i64) {
        self.alignment = value;
    }

    pub fn get_alignment(&mut self) -> i64 {
        self.alignment
    }

    pub fn execute(
        &mut self,
        pc: usize,
        instruction: &Instruction,
    ) -> Result<ExecuteReturnType, String> {
        match instruction.ty {
            InstructionType::Arithmetic => match instruction.opcode.as_str() {
                "add" => {
                    self.arithmetic("+", &|x, y| x + y, instruction.operands.clone());
                }
                "sub" => {
                    self.arithmetic("-", &|x, y| x - y, instruction.operands.clone());
                }
                "mul" | "umulh" => {
                    self.arithmetic("*", &|x, y| x * y, instruction.operands.clone());
                }
                "and" => {
                    self.arithmetic("&", &|x, y| x & y, instruction.operands.clone());
                }
                "orr" => {
                    self.arithmetic("|", &|x, y| x | y, instruction.operands.clone());
                }
                "orn" => {
                    self.arithmetic("!|", &|x, y: i64| x | !y, instruction.operands.clone());
                }
                "eor" => {
                    // potential TODO: deal with case where registers are the same but not imm
                    self.arithmetic("^", &|x, y| x ^ y, instruction.operands.clone());
                }
                "bic" => {
                    self.arithmetic("!&", &|x, y: i64| x & !y, instruction.operands.clone());
                }
                "adds" => {
                    self.cmn(&instruction.operands[0], &instruction.operands[1]);
                    self.arithmetic("+", &|x, y| x + y, instruction.operands.clone());
                }
                "subs" => {
                    self.cmp(&instruction.operands[0], &instruction.operands[1]);
                    self.arithmetic("-", &|x, y| x - y, instruction.operands.clone());
                }
                "tst" => {
                    todo!();
                }
                "ror" | "lsl" | "lsr" => {
                    let mut reg_iter = instruction.operands.iter();

                    let reg0 = reg_iter.next().expect("Need destination register");
                    let reg1 = reg_iter.next().expect("Need first source register");
                    let reg2 = reg_iter.next().expect("Need second source register");

                    self.shift_reg(reg0, reg1, reg2);
                }
                "ands" => {
                    self.cmp(&instruction.operands[0], &instruction.operands[1]);
                    self.arithmetic("&", &|x, y| x & y, instruction.operands.clone());
                }
                "adc" => {
                    match &self.carry {
                        Some(FlagValue::Real(b)) => {
                            if *b == true {
                                self.arithmetic(
                                    "+",
                                    &|x, y| x + y + 1,
                                    instruction.operands.clone(),
                                );
                            } else {
                                self.arithmetic("+", &|x, y| x + y, instruction.operands.clone());
                            }
                        }
                        _ => todo!(),
                        // Some(FlagValue::Abstract(c)) => {
                        //     let opt0 = self.arithmetic("+", &|x, y| x + y, instruction.operands);
                        //     let opt1 = self.arithmetic("+", &|x, y| x + y + 1, instruction.operands);

                        //     return Ok(ExecuteReturnType::Select(c.clone(), reg0.clone(), opt0, opt1));
                        // }
                        // None => {
                        //     let opt0 = self.arithmetic("+", &|x, y| x + y, instruction.operands);
                        //     let opt1 = self.arithmetic("+", &|x, y| x + y + 1, instruction.operands);

                        //     return Ok(ExecuteReturnType::Select(
                        //         AbstractComparison::new(
                        //             "==",
                        //             AbstractExpression::Abstract("carry".to_string()),
                        //             AbstractExpression::Immediate(1),
                        //         ),
                        //         reg0.clone(),
                        //         opt0,
                        //         opt1,
                        //     ));
                        // }
                    }
                }
                "adcs" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let _ = reg_iter.next().expect("Need destination register");
                    let reg1 = reg_iter.next().expect("Need first choice register");
                    let reg2 = reg_iter.next().expect("Need second choice source register");

                    match &self.carry {
                        Some(FlagValue::Real(b)) => {
                            if *b == true {
                                self.arithmetic(
                                    "+",
                                    &|x, y| x + y + 1,
                                    instruction.operands.clone(),
                                );
                                self.cmn(reg1, reg2);
                            } else {
                                self.arithmetic("+", &|x, y| x + y, instruction.operands.clone());
                                self.cmn(reg1, reg2);
                            }
                        }
                        _ => todo!(),
                    }
                }
                "sbc" => match &self.carry {
                    Some(FlagValue::Real(b)) => {
                        if *b == true {
                            self.arithmetic("-", &|x, y| x - y, instruction.operands.clone());
                        } else {
                            self.arithmetic("+", &|x, y| x - y - 1, instruction.operands.clone());
                        }
                    }
                    _ => todo!(),
                },
                "sbcs" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let _ = reg_iter.next().expect("Need destination register");
                    let reg1 = reg_iter.next().expect("Need first choice register");
                    let reg2 = reg_iter.next().expect("Need second choice source register");

                    match &self.carry {
                        Some(FlagValue::Real(b)) => {
                            if *b == true {
                                self.arithmetic("-", &|x, y| x - y, instruction.operands.clone());
                                self.cmp(reg1, reg2);
                            } else {
                                self.arithmetic(
                                    "-",
                                    &|x, y| x - y - 1,
                                    instruction.operands.clone(),
                                );
                                self.cmp(reg1, reg2);
                            }
                        }
                        _ => todo!(),
                    }
                }
                "clz" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let reg0 = reg_iter.next().expect("Need register output for clz");
                    let reg1 = reg_iter.next().expect("Need register output for clz");

                    let r1 = self.get_register(reg1);
                    match r1.kind {
                        RegisterKind::Immediate => {
                            self.set_register(
                                reg0,
                                RegisterKind::Number,
                                None,
                                r1.offset.leading_zeros() as i64,
                            );
                        }
                        _ => {
                            self.set_register(reg0, RegisterKind::Number, None, 0);
                        }
                    }
                }
                "mov" | "movz" | "movk" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let reg0 = reg_iter.next().expect("Need register output for mov");
                    let reg1 = reg_iter.next().expect("Need register output for mov");

                    let mut r1 = self.get_register(reg1);

                    if let Some(a) = reg_iter.next() {
                        match a {
                            Operand::Bitwise(op, shift) => {
                                r1 = instruction_aux::shift_imm(op.to_string(), r1, *shift);
                            }
                            _ => todo!("not sure what else can show up here"),
                        }
                    }

                    self.set_register(reg0, r1.kind, r1.base, r1.offset);
                }
                "rev" | "rev32" | "rbit" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let reg0 = reg_iter.next().expect("Need register output for rev");
                    let reg1 = reg_iter.next().expect("Need register output for rev");

                    let mut r1 = self.get_register(reg1);

                    if let Some(base) = r1.base {
                        r1.base = Some(generate_expression("rev", base, AbstractExpression::Empty));
                    }

                    r1.offset = r1.offset.swap_bytes();
                    self.set_register(reg0, r1.kind, r1.base, r1.offset);
                }
                _ => todo!("Unsupported arithmetic instruction: {:?}", instruction),
            },
            InstructionType::ControlFlow => match instruction.opcode.as_str() {
                "adr" => {
                    if let Operand::Label(label) = &instruction.operands[1] {
                        let (region, index) = self.label_to_memory_index(label.clone());
                        self.set_register(
                            &instruction.operands[0],
                            RegisterKind::RegisterBase,
                            Some(AbstractExpression::Abstract(region)),
                            index,
                        );
                    } else {
                        panic!("adr not invoked correctly with register and label")
                    }
                }
                "adrp" => {
                    // Form PC-relative address to 4KB page adds an immediate value that is shifted left by 12 bits, to the PC value to form a PC-relative address, with the bottom 12 bits masked out, and writes the result to the destination register.
                    // TODO: handle case for sha256 where we need @OFF page address
                    if let Operand::Label(label) = &instruction.operands[1] {
                        let (region, index) = self.label_to_memory_index(label.clone());
                        self.set_register(
                            &instruction.operands[0],
                            RegisterKind::RegisterBase,
                            Some(AbstractExpression::Abstract(region)),
                            index << 12,
                        );
                    } else {
                        panic!("adr not invoked correctly with register and label")
                    }
                }
                "cbz" => {
                    // Compare and Branch on Zero compares the value in a register with zero, and conditionally branches to a label at a PC-relative offset if the comparison is equal. It provides a hint that this is not a subroutine call or return. This instruction does not affect condition flags.
                    let register = self.get_register(&instruction.operands[0]);
                    if let Operand::Label(label) = &instruction.operands[1] {
                        if (register.base.is_none()
                            || register.base == Some(AbstractExpression::Empty))
                            && register.offset == 0
                        {
                            return Ok(ExecuteReturnType::JumpLabel(label.to_string()));
                        } else if register.kind == RegisterKind::RegisterBase {
                            return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                AbstractComparison::new(
                                    "==",
                                    AbstractExpression::Immediate(0),
                                    AbstractExpression::Register(Box::new(register)),
                                ),
                                label.to_string(),
                            ));
                        } else {
                            return Ok(ExecuteReturnType::Next);
                        }
                    } else {
                        panic!("cbz not invoked correctly with register and label");
                    }
                }
                "cbnz" => {
                    let register = self.get_register(&instruction.operands[0]);
                    if let Operand::Label(label) = &instruction.operands[1] {
                        if (register.base.is_none()
                            || register.base == Some(AbstractExpression::Empty))
                            && register.offset == 0
                        {
                            return Ok(ExecuteReturnType::Next);
                        } else if register.kind == RegisterKind::RegisterBase {
                            return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                AbstractComparison::new(
                                    "!=",
                                    AbstractExpression::Immediate(0),
                                    AbstractExpression::Register(Box::new(register)),
                                ),
                                label.to_string(),
                            ));
                        } else {
                            return Ok(ExecuteReturnType::JumpLabel(label.to_string()));
                        }
                    } else {
                        panic!("cbnz not invoked correctly with register and label");
                    }
                }
                "b" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        return Ok(ExecuteReturnType::JumpLabel(label.to_string()));
                    } else {
                        panic!("b not invoked correctly");
                    }
                }
                "bl" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        self.set_register(
                            &Operand::Register(RePrefix::X, 30),
                            RegisterKind::Immediate,
                            None,
                            pc as i64,
                        );
                        return Ok(ExecuteReturnType::JumpLabel(label.to_string()));
                    } else {
                        panic!("b not invoked correctly");
                    }
                }
                "b.ne" | "bne" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match &self.zero {
                            // if zero is set to false, then cmp -> not equal and we branch
                            Some(flag) => match flag {
                                FlagValue::Real(b) => {
                                    if !b {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                FlagValue::Abstract(s) => {
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(s.clone().not(), label.clone()));
                                }
                            },
                            None => return Err(
                                "Flag cannot be branched on since it has not been set within the program yet"
                                    .to_string(),
                            ),
                        }
                    }
                    panic!("bne not invoked correctly with label");
                }
                "b.eq" | "beq" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match &self.zero {
                            // if zero is set to false, then cmp -> not equal and we branch
                            Some(flag) => match flag {
                                FlagValue::Real(b) => {
                                    if *b {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                FlagValue::Abstract(s) => {
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(s.clone(), label.clone()));
                                }
                            },
                            None => return Err(
                                "Flag cannot be branched on since it has not been set within the program yet"
                                    .to_string(),
                            ),
                        }
                    }
                    panic!("beq not invoked correctly with label");
                }
                "bgt" | "bt" | "b.gt" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.neg, &self.overflow) {
                            (Some(zero), Some(neg), Some(ove)) => {
                                match  (zero, neg, ove) {
                                (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(v)) => {
                                   if !z && n == v {  // Z = 0 AND N = V
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()))
                                   } else {
                                        return Ok(ExecuteReturnType::Next)
                                   }
                                },
                                (FlagValue::Abstract(z) , _, _ ) =>  {
                                    let expression = generate_comparison(">", *z.left.clone(), *z.right.clone());
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, label.clone()));
                                },
                                (_,_,_) => todo!("match on undefined flags!")
                                }
                            },
                            (_, _, _) => return Err(
                                "Flag cannot be branched on since it has not been set within the program yet"
                                    .to_string(),
                            ),
                        }
                    }
                    panic!("b.gt not invoked correctly with label");
                }
                "b.lt" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.neg, &self.overflow) {
                            (Some(zero), Some(neg), Some(ove)) => {
                                match  (zero, neg, ove) {
                                (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(v)) => {
                                   if !z && n != v {  // Z = 0 AND N = V
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()))
                                   } else {
                                        return Ok(ExecuteReturnType::Next)
                                   }
                                },
                                (FlagValue::Abstract(z) , _, _ ) =>  {
                                    let expression = generate_comparison("<", *z.left.clone(), *z.right.clone());
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel( expression, label.clone()));
                                },
                                (_,_,_) => todo!("match on undefined flags!")
                                }
                            },
                            (_, _, _) => return Err(
                                "Flag cannot be branched on since it has not been set within the program yet"
                                    .to_string(),
                            ),
                        }
                    }
                }
                "b.ls" | "b.le" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.carry) {
                        (Some(zero), Some(carry)) => {
                            match  (zero, carry) {
                            (FlagValue::Real(z), FlagValue::Real(c)) => {
                               if !z && *c {
                                    return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                               } else {
                                    return Ok(ExecuteReturnType::Next)
                               }
                            },
                            (FlagValue::Abstract(z) , _ ) | (_, FlagValue::Abstract(z) ) =>  {
                                let expression = generate_comparison("<=", *z.left.clone(), *z.right.clone());
                                return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, label.clone()));
                            },
                            }
                        },
                        (_, _) => return Err(
                            "Flag cannot be branched on since it has not been set within the program yet"
                                .to_string(),
                        ),
                    }
                    }
                    panic!("b.ls not invoked correctly with label");
                }
                "b.cs" | "b.hs" | "bcs" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match&self.carry{
                            Some(carry) => {
                                match  carry {
                                FlagValue::Real(c) => {
                                   if *c {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                   } else {
                                        return Ok(ExecuteReturnType::Next)
                                   }
                                },
                                FlagValue::Abstract(c) =>  {
                                    let expression = generate_comparison("<", *c.left.clone(), *c.right.clone());
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, label.clone()));
                                },
                                }
                            },
                            None => return Err(
                                "Flag cannot be branched on since it has not been set within the program yet"
                                    .to_string(),
                            ),
                        }
                    }
                    panic!("b.cs not invoked correctly");
                }
                "b.cc" | "b.lo" | "blo" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match&self.carry{
                            Some(carry) => {
                                match  carry {
                                FlagValue::Real(c) => {
                                   if !*c {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                   } else {
                                        return Ok(ExecuteReturnType::Next)
                                   }
                                },
                                FlagValue::Abstract(c) =>  {
                                    let expression = generate_comparison(">=", *c.left.clone(), *c.right.clone());
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, label.clone()));
                                },
                                }
                            },
                            None => return Err(
                                "Flag cannot be branched on since it has not been set within the program yet"
                                    .to_string(),
                            ),
                        }
                    }
                    panic!("b.cc/lo/blo not invoked correctly");
                }
                "cset" => {
                    // match on condition based on flags
                    let mut reg_iter = instruction.operands.iter();

                    let register = register_to_tuple(reg_iter.next().expect("cset register"));
                    let Operand::Label(cond) = reg_iter.next().expect("cset condition code") else {
                        panic!("not a valid condition code")
                    };

                    match cond.as_str() {
                        "cs" => match self.carry.clone().expect("Need carry flag set cset cs") {
                            FlagValue::Real(b) => {
                                if b == true {
                                    self.set_register_from_tuple(
                                        register,
                                        RegisterKind::Immediate,
                                        None,
                                        1,
                                    );
                                } else {
                                    self.set_register_from_tuple(
                                        register,
                                        RegisterKind::Immediate,
                                        None,
                                        0,
                                    );
                                }
                            }
                            FlagValue::Abstract(_) => {
                                log::error!("Can't support this yet :)");
                                todo!("Abstract Flag Expression3");
                            }
                        },
                        "cc" | "lo" => {
                            match self.carry.clone().expect("Need carry flag set cset cc") {
                                FlagValue::Real(b) => {
                                    if b == false {
                                        self.set_register_from_tuple(
                                            register,
                                            RegisterKind::Immediate,
                                            None,
                                            1,
                                        );
                                    } else {
                                        self.set_register_from_tuple(
                                            register,
                                            RegisterKind::Immediate,
                                            None,
                                            0,
                                        );
                                    }
                                }
                                FlagValue::Abstract(_) => {
                                    log::error!("Can't support this yet :)");
                                    todo!("Abstract Flag Expression3");
                                }
                            }
                        }
                        a => todo!("unimplemented condition code for set {}", a),
                    }
                }
                "csel" => {
                    // match on condition based on flags
                    let mut reg_iter = instruction.operands.iter();

                    let dest = reg_iter.next().expect("cset register");
                    let opt1 = self.get_register(reg_iter.next().expect("csel register"));
                    let opt2 = self.get_register(reg_iter.next().expect("csel register"));
                    let Operand::Label(cond) = reg_iter.next().expect("csel condition code") else {
                        panic!("not a valid condition code")
                    };

                    match cond.as_str() {
                        "cc" | "lo" => {
                            match self.carry.clone().expect("Need carry flag set csel cc") {
                                FlagValue::Real(b) => {
                                    if b == true {
                                        self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                                    } else {
                                        self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                                    }
                                }
                                FlagValue::Abstract(a) => {
                                    return Ok(ExecuteReturnType::Select(
                                        a,
                                        dest.clone(),
                                        opt1,
                                        opt2,
                                    ));
                                }
                            }
                        }
                        "cs" => match self.carry.clone() {
                            Some(FlagValue::Real(b)) => {
                                if b == false {
                                    self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                                } else {
                                    self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                                }
                            }
                            Some(FlagValue::Abstract(a)) => {
                                return Ok(ExecuteReturnType::Select(
                                    a.not(),
                                    dest.clone(),
                                    opt1,
                                    opt2,
                                ));
                            }
                            None => {
                                return Ok(ExecuteReturnType::Select(
                                    AbstractComparison::new(
                                        "==",
                                        AbstractExpression::Abstract("c_flag".to_string()),
                                        AbstractExpression::Immediate(1),
                                    ),
                                    dest.clone(),
                                    opt1,
                                    opt2,
                                ));
                            }
                        },
                        "eq" => {
                            match self.zero.clone().expect("Need zero flag set") {
                                FlagValue::Real(z) => {
                                    if z == true {
                                        self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                                    } else {
                                        self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                                    }
                                }
                                FlagValue::Abstract(z) => {
                                    return Ok(ExecuteReturnType::Select(
                                        z,
                                        dest.clone(),
                                        opt1,
                                        opt2,
                                    ));
                                }
                            };
                        }
                        a => todo!("csel with condition code not yet implemented {}", a),
                    }
                }
                "csetm" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dest = reg_iter.next().expect("cset register");
                    let Operand::Label(cond) = reg_iter.next().expect("cset condition code") else {
                        panic!("not a valid condition code")
                    };

                    match cond.as_str() {
                        "eq" => match self.zero.clone().expect("Need zero flag set") {
                            FlagValue::Real(b) => {
                                if b == true {
                                    self.set_register(&dest, RegisterKind::Immediate, None, 1);
                                } else {
                                    self.set_register(&dest, RegisterKind::Immediate, None, 0);
                                }
                            }
                            FlagValue::Abstract(a) => {
                                let opt1 = RegisterValue {
                                    kind: RegisterKind::Immediate,
                                    base: None,
                                    offset: 1,
                                };
                                let opt2 = RegisterValue {
                                    kind: RegisterKind::Immediate,
                                    base: None,
                                    offset: 1,
                                };

                                return Ok(ExecuteReturnType::Select(a, dest.clone(), opt1, opt2));
                            }
                        },
                        _ => todo!("unsupported condition code for csetm {:?}", cond),
                    }
                }
                a => todo!("arithmetic instruction not yet implemented {:?}", a),
            },
            InstructionType::Memory => match instruction.opcode.as_str() {
                "ldr" | "ldrb" => {
                    // TODO: split, have to rewrite load or do post-processing after load to extract meaningful byte
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("ldr dst");
                    let src_addr = reg_iter.next().expect("ldr src");

                    match src_addr {
                        Operand::Memory(w, reg_num, offset, _, mode) => {
                            let mut address = self
                                .get_register(&Operand::Register(w.clone(), *reg_num))
                                .clone();
                            address.offset = address.offset + offset.unwrap_or(0);

                            let res = self.load(dst.clone(), address.clone());
                            match res {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0),
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset,
                                    );
                                }
                                None => {}
                            }
                        }
                        _ => {
                            panic!("ldr not with correct syntax for memory operand");
                        }
                    }
                }
                "ldp" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst1 = reg_iter.next().expect("ldr dst");
                    let dst2 = reg_iter.next().expect("ldr src");
                    let src_addr = reg_iter.next().expect("ldr src");

                    match src_addr {
                        Operand::Memory(w, reg_num, offset, _, mode) => {
                            let mut address = self
                                .get_register(&Operand::Register(w.clone(), *reg_num))
                                .clone();
                            address.offset = address.offset + offset.unwrap_or(0);

                            let res1 = self.load(dst1.clone(), address.clone());
                            address.offset += 8;
                            let res2 = self.load(dst2.clone(), address.clone());
                            match res1 {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }
                            match res2 {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0) - 8,
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset,
                                    );
                                }
                                None => {}
                            }
                        }
                        _ => {
                            panic!("ldr not with correct syntax for memory operand");
                        }
                    }
                }
                "str" | "strb" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("ldr dst");
                    let src_addr = reg_iter.next().expect("ldr src");

                    match src_addr {
                        Operand::Memory(w, reg_num, offset, _, mode) => {
                            let mut address = self
                                .get_register(&Operand::Register(w.clone(), *reg_num))
                                .clone();
                            address.offset = address.offset + offset.unwrap_or(0);

                            let res = self.store(dst.clone(), address.clone());
                            match res {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0),
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset,
                                    );
                                }
                                None => {}
                            }
                        }
                        _ => {
                            panic!("ldr not with correct syntax for memory operand");
                        }
                    }
                }
                "stp" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst1 = reg_iter.next().expect("ldr dst");
                    let dst2 = reg_iter.next().expect("ldr src");
                    let src_addr = reg_iter.next().expect("ldr src");

                    match src_addr {
                        Operand::Memory(w, reg_num, offset, _, mode) => {
                            let mut address = self
                                .get_register(&Operand::Register(w.clone(), *reg_num))
                                .clone();
                            address.offset = address.offset + offset.unwrap_or(0);

                            let res1 = self.store(dst1.clone(), address.clone());
                            address.offset += 8;
                            let res2 = self.store(dst2.clone(), address.clone());
                            match res1 {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }
                            match res2 {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0) - 8,
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset,
                                    );
                                }
                                None => {}
                            }
                        }
                        _ => {
                            panic!("ldr not with correct syntax for memory operand");
                        }
                    }
                }
                _ => todo!(),
            },
            InstructionType::SIMDArithmetic => {
                todo!("simd arithmetic");
            }
            InstructionType::SIMDManagement => {
                todo!("simd register movement");
            }
            InstructionType::Other => match instruction.opcode.as_str() {
                "cmp" => {
                    self.cmp(&instruction.operands[0], &instruction.operands[1]);
                }
                "cmn" => {
                    self.cmn(&instruction.operands[0], &instruction.operands[1]);
                }
                "ret" => {
                    let x30 = self.get_register(&Operand::Register(RePrefix::X, 30));
                    if x30.kind == RegisterKind::RegisterBase {
                        if let Some(AbstractExpression::Abstract(address)) = x30.base {
                            if address == "return" && x30.offset == 0 {
                                return Ok(ExecuteReturnType::JumpLabel("return".to_string()));
                            } else {
                                return Ok(ExecuteReturnType::JumpLabel(address.to_string()));
                            }
                        }
                        return Ok(ExecuteReturnType::JumpAddress(
                            x30.offset.try_into().expect("computer4"),
                        ));
                    } else {
                        panic!("return register not set before calling ret")
                    }
                }
                a => todo!("other instruction not implemented yet {:?}", a),
            },
            _ => panic!(),
        }

        Ok(ExecuteReturnType::Next)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    // TODO: figure out how to refactor computer setup code w/lifetimes

    #[test]
    fn test_arithmetic_add_imm_registers() {
        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut computer = ARMCORTEXA::new(&ctx);

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::Immediate,
            None,
            2,
        );
        computer.set_register(
            &Operand::Register(RePrefix::X, 2),
            RegisterKind::Immediate,
            None,
            3,
        );
        let _ = computer.execute(0, &Instruction::new("add x0, x1, x2".to_string()));
        let result = computer
            .get_register(&Operand::Register(RePrefix::X, 0))
            .offset;
        assert_eq!(result, 5);
    }

    #[test]
    fn test_arithmetic_add_abstract_and_imm() {
        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut computer = ARMCORTEXA::new(&ctx);

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("hello,".to_string())),
            0,
        );
        computer.set_register(
            &Operand::Register(RePrefix::X, 2),
            RegisterKind::Immediate,
            None,
            5,
        );
        let _ = computer.execute(0, &Instruction::new("add x0, x1, x2".to_string()));
        let result = computer.get_register(&Operand::Register(RePrefix::X, 0));
        assert_eq!(
            result,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(AbstractExpression::Abstract("hello,".to_string())),
                offset: 5,
            }
        );
    }

    #[test]
    fn test_arithmetic_add_abstract_registers() {
        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut computer = ARMCORTEXA::new(&ctx);

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("hello,".to_string())),
            0,
        );
        computer.set_register(
            &Operand::Register(RePrefix::X, 2),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("world!".to_string())),
            0,
        );
        let _ = computer.execute(0, &Instruction::new("add x0, x1, x2".to_string()));
        let result = computer.get_register(&Operand::Register(RePrefix::X, 0));
        assert_eq!(
            result,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(generate_expression(
                    "+",
                    AbstractExpression::Abstract("hello,".to_string()),
                    AbstractExpression::Abstract("world!".to_string())
                )),
                offset: 0,
            }
        );
    }

    #[test]
    fn test_arithmetic_add_with_shift() {
        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut computer = ARMCORTEXA::new(&ctx);

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("hello,".to_string())),
            0,
        );
        computer.set_register(
            &Operand::Register(RePrefix::X, 2),
            RegisterKind::Immediate,
            None,
            3,
        );
        let _ = computer.execute(0, &Instruction::new("add x0, x1, x2, lsl#2".to_string()));
        let result = computer.get_register(&Operand::Register(RePrefix::X, 0));
        assert_eq!(
            result,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(AbstractExpression::Abstract("hello,".to_string())),
                offset: 12,
            }
        );
    }

    #[test]
    fn test_arithmetic_add_abstract_and_imm_instruction() {
        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut computer = ARMCORTEXA::new(&ctx);

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("hello,".to_string())),
            0,
        );
        let _ = computer.execute(0, &Instruction::new("add x0, x1, #7".to_string()));
        let result = computer.get_register(&Operand::Register(RePrefix::X, 0));
        assert_eq!(
            result,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(AbstractExpression::Abstract("hello,".to_string())),
                offset: 7,
            }
        );
    }
}
