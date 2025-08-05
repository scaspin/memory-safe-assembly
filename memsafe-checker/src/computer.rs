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
            Operand::Register(_, index) => self.registers[*index].clone(),
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
                "cmp" => {
                    self.cmp(&instruction.operands[0], &instruction.operands[1]);
                }
                "cmn" => {
                    self.cmn(&instruction.operands[0], &instruction.operands[1]);
                }
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
                "ror" => {
                    let mut reg_iter = instruction.operands.iter();

                    let reg0 = reg_iter.next().expect("Need destination register");
                    let reg1 = reg_iter.next().expect("Need first source register");
                    let reg2 = reg_iter.next().expect("Need second source register");

                    self.shift_reg(reg0, reg1, reg2);
                }

                // TODO: this is a really bad way to do this, get expressions from include/arm_arch.h
                //"ands"
                //     "lsr" | "lsl" => {
                //         let r2 = self.registers
                //             [get_register_index(instruction.r2.clone().expect("Need register"))]
                //         .clone();
                //         let shift = self
                //             .operand(instruction.r3.clone().expect("Need shift amt"))
                //             .offset;
                //         let new_offset = r2.offset >> shift;
                //         if new_offset == 0 {
                //             self.set_register(
                //                 instruction.r1.clone().expect("Need destination register"),
                //                 r2.clone().kind,
                //                 None,
                //                 new_offset,
                //             );
                //         } else {
                //             self.set_register(
                //                 instruction.r1.clone().expect("Need destination register"),
                //                 r2.clone().kind,
                //                 Some(generate_expression(
                //                     "lsr",
                //                     r2.base.unwrap_or(AbstractExpression::Empty),
                //                     AbstractExpression::Immediate(new_offset),
                //                 )),
                //                 new_offset,
                //             );
                //         }
                //     }

                //     "adcs" | "adc" => {
                //         match self.carry.clone() {
                //         Some(FlagValue::Real(b)) => {
                //             if b == true {
                //                 self.arithmetic(
                //                     "+",
                //                     &|x, y| x + y,
                //                     instruction.r1.clone().expect("Need dst register"),
                //                     instruction.r2.clone().expect("Need one operand"),
                //                     instruction.r2.clone().expect("Need one operand"),
                //                     Some("#1".to_string()),
                //                 );
                //             } else {
                //                 self.arithmetic(
                //                     "+",
                //                     &|x, y| x + y,
                //                     instruction.r1.clone().expect("Need dst register"),
                //                     instruction.r2.clone().expect("Need one operand"),
                //                     instruction.r2.clone().expect("Need one operand"),
                //                     Some("#0".to_string()),
                //                 );
                //             }
                //         }
                //         Some(FlagValue::Abstract(c)) => {
                //             let opt1 = self.registers[get_register_index(
                //                 instruction.r2.clone().expect("Need first source register"),
                //             )]
                //             .clone();

                //             let mut opt2 = self.registers[get_register_index(
                //                 instruction.r3.clone().expect("Need second source register"),
                //             )]
                //             .clone();
                //             opt2.offset = opt2.offset + 1;

                //             return Ok(ExecuteReturnType::Select(c,
                //              instruction.r1.clone().expect("need dst register"), opt1, opt2));
                //         }
                //         None => {
                //             let opt1 = self.registers[get_register_index(
                //                 instruction.r2.clone().expect("Need first source register"),
                //             )]
                //             .clone();

                //             let mut opt2 = self.registers[get_register_index(
                //                 instruction.r3.clone().expect("Need second source register"),
                //             )]
                //             .clone();
                //             opt2.offset = opt2.offset + 1;

                //             return Ok(ExecuteReturnType::Select(AbstractComparison::new(
                //                 "==",
                //                 AbstractExpression::Abstract("carry".to_string()),
                //                 AbstractExpression::Immediate(1)),
                //              instruction.r1.clone().expect("need dst register"), opt1, opt2));
                //         }
                //         }
                //         //update flags
                //         self.cmn(instruction.r1.clone().expect("need register to compare"),instruction.r2.clone().expect("need register to compare"), );
                //     },
                //     "sbcs" | "sbc" => match self.carry.clone() { // FIX: split
                //         Some(FlagValue::Real(b)) => {
                //             if b == true {
                //                 self.arithmetic(
                //                     "-",
                //                     &|x, y| x - y,
                //                     instruction.r1.clone().expect("Need dst register"),
                //                     instruction.r2.clone().expect("Need one operand"),
                //                     instruction.r2.clone().expect("Need one operand"),
                //                     Some("#1".to_string()),
                //                 );
                //             } else {
                //                 self.arithmetic(
                //                     "-",
                //                     &|x, y| x - y,
                //                     instruction.r1.clone().expect("Need dst register"),
                //                     instruction.r2.clone().expect("Need one operand"),
                //                     instruction.r2.clone().expect("Need one operand"),
                //                     Some("#0".to_string()),
                //                 );
                //             }
                //         }
                //         Some(FlagValue::Abstract(a)) => {
                //             let opt1 = self.registers[get_register_index(
                //                 instruction.r2.clone().expect("Need first source register"),
                //             )]
                //             .clone();

                //             let mut opt2 = self.registers[get_register_index(
                //                 instruction.r3.clone().expect("Need second source register"),
                //             )]
                //             .clone();
                //             opt2.offset = opt2.offset + 1;

                //             return Ok(ExecuteReturnType::Select(a,
                //              instruction.r1.clone().expect("need dst register"), opt1, opt2));
                //         }
                //         None => {
                //             let opt1 = self.registers[get_register_index(
                //                 instruction.r2.clone().expect("Need first source register"),
                //             )]
                //             .clone();

                //             let mut opt2 = self.registers[get_register_index(
                //                 instruction.r3.clone().expect("Need second source register"),
                //             )]
                //             .clone();
                //             opt2.offset = opt2.offset -1 ;

                //             return Ok(ExecuteReturnType::Select(AbstractComparison::new(
                //                 "==",
                //                 AbstractExpression::Abstract("carry".to_string()),
                //                 AbstractExpression::Immediate(1)),
                //                 instruction.r1.clone().expect("need dst register"), opt1, opt2));
                //         }
                //     },
                //     "adrp"=> {
                //         let address = self.operand(instruction.r2.clone().expect("Need address label"));
                //         self.set_register(
                //             instruction.r1.clone().expect("need dst register"),
                //             RegisterKind::RegisterBase,
                //             address.base,
                //             address.offset,
                //         );
                //     }
                //     "adr" => {
                //         let address = self.operand(instruction.r2.clone().expect("Need address label"));
                //         self.set_register(
                //             instruction.r1.clone().expect("need dst register"),
                //             RegisterKind::RegisterBase,
                //             address.base,
                //             address.offset,
                //         );
                //     }
                //     "cbnz" => {
                //         let register = self.registers
                //             [get_register_index(instruction.r1.clone().expect("Need one register"))]
                //         .clone();
                //         if (register.base.is_none()
                //             || register.base.clone().expect("computer2") == AbstractExpression::Empty)
                //             && register.offset == 0
                //         {
                //             return Ok(ExecuteReturnType::Next);
                //         } else if register.kind == RegisterKind::RegisterBase {
                //             return Ok(ExecuteReturnType::ConditionalJumpLabel(
                //                 AbstractComparison::new(
                //                     "!=",
                //                     AbstractExpression::Immediate(0),
                //                     AbstractExpression::Register(Box::new(register)),
                //                 ),
                //                 instruction.r2.clone().expect("need jump label 1 "),
                //             ));
                //         } else {
                //             return Ok(ExecuteReturnType::JumpLabel(instruction.r2.clone().expect("need jump label 2")));
                //         }
                //     }
                //     // Compare and Branch on Zero compares the value in a register with zero, and conditionally branches to a label at a PC-relative offset if the comparison is equal. It provides a hint that this is not a subroutine call or return. This instruction does not affect condition flags.
                //     "cbz" => {
                //         let register = self.registers
                //             [get_register_index(instruction.r1.clone().expect("Need one register"))]
                //         .clone();

                //         if (register.base.is_none()
                //             || register.base.clone().expect("computer3") == AbstractExpression::Empty)
                //             && register.offset == 0
                //         {
                //             return Ok(ExecuteReturnType::JumpLabel(instruction.r2.clone().expect("need jump label 3")));
                //         } else if register.kind == RegisterKind::RegisterBase {
                //             return Ok(ExecuteReturnType::ConditionalJumpLabel(
                //                 AbstractComparison::new(
                //                     "==",
                //                     AbstractExpression::Immediate(0),
                //                     AbstractExpression::Register(Box::new(register)),
                //                 ),
                //                 instruction.r2.clone().expect("need jump label 4"),
                //             ));
                //         } else {
                //             return Ok(ExecuteReturnType::Next);
                //         }
                //     }
                //     "cset" => {
                //         // match on condition based on flags
                //         match instruction
                //             .r2
                //             .clone()
                //             .expect("Need to provide a condition")
                //             .as_str()
                //         {
                //             "cs" => match self.carry.clone().expect("Need carry flag set cset cs") {
                //                 FlagValue::Real(b) => {
                //                     if b == true {
                //                         self.set_register(
                //                             instruction.r1.clone().expect("need dst register"),
                //                             RegisterKind::Immediate,
                //                             None,
                //                             1,
                //                         );
                //                     } else {
                //                         self.set_register(
                //                             instruction.r1.clone().expect("need dst register"),
                //                             RegisterKind::Immediate,
                //                             None,
                //                             0,
                //                         );
                //                     }
                //                 }
                //                 FlagValue::Abstract(_) => {
                //                     log::error!("Can't support this yet :)");
                //                     todo!("Abstract Flag Expression3");
                //                 }
                //             },
                //             "cc" | "lo" => match self.carry.clone().expect("Need carry flag set cset cc") {
                //                 FlagValue::Real(b) => {
                //                     if b == false {
                //                         self.set_register(
                //                             instruction.r1.clone().expect("need dst register"),
                //                             RegisterKind::Immediate,
                //                             None,
                //                             0,
                //                         );
                //                     } else {
                //                         self.set_register(
                //                             instruction.r1.clone().expect("need dst register"),
                //                             RegisterKind::Immediate,
                //                             None,
                //                             1,
                //                         );
                //                     }
                //                 }
                //                 FlagValue::Abstract(_) => {
                //                     log::error!("Can't support this yet :)");
                //                     todo!("Abstract flag expressions 4");
                //                 }
                //             },
                //             _ => todo!("unsupported comparison type {:?}", instruction.r2),
                //         }
                //     }
                //     "csel" => {
                //         // match on condition based on flags
                //         match instruction
                //             .r4
                //             .clone()
                //             .expect("Need to provide a condition")
                //             .as_str()
                //         {
                //             "cc" | "lo" => match self.carry.clone().expect("Need carry flag set csel cc") {
                //                 FlagValue::Real(b) => {
                //                     if b == true {
                //                         let register = self.registers[get_register_index(
                //                             instruction.r2.clone().expect("Need first source register"),
                //                         )]
                //                         .clone();
                //                         self.set_register(
                //                             instruction.r1.clone().expect("need dst register"),
                //                             register.kind,
                //                             register.base,
                //                             register.offset,
                //                         );
                //                     } else {
                //                         let register = self.registers[get_register_index(
                //                             instruction.r3.clone().expect("Need first source register"),
                //                         )]
                //                         .clone();
                //                         self.set_register(
                //                             instruction.r1.clone().expect("need dst register"),
                //                             register.kind,
                //                             register.base,
                //                             register.offset,
                //                         );
                //                     }
                //                 }
                //                 FlagValue::Abstract(a) => {
                //                     let opt1 = self.registers[get_register_index(
                //                         instruction.r2.clone().expect("Need first source register"),
                //                     )]
                //                     .clone();

                //                     let opt2 = self.registers[get_register_index(
                //                         instruction.r3.clone().expect("Need second source register"),
                //                     )]
                //                     .clone();

                //                     return Ok(ExecuteReturnType::Select(a, instruction.r1.clone().expect("need dst register"), opt1, opt2));
                //                 }
                //             },
                //             "cs" => match self.carry.clone() {
                //                 Some(FlagValue::Real(b)) => {
                //                     if b == false {
                //                         let register = self.registers[get_register_index(
                //                             instruction.r2.clone().expect("Need first source register"),
                //                         )]
                //                         .clone();
                //                         self.set_register(
                //                             instruction.r1.clone().expect("need dst register"),
                //                             register.kind,
                //                             register.base,
                //                             register.offset,
                //                         );
                //                     } else {
                //                         let register = self.registers[get_register_index(
                //                             instruction.r3.clone().expect("Need first source register"),
                //                         )]
                //                         .clone();
                //                         self.set_register(
                //                             instruction.r1.clone().expect("need dst register"),
                //                             register.kind,
                //                             register.base,
                //                             register.offset,
                //                         );
                //                     }
                //                 }
                //                 Some(FlagValue::Abstract(a)) => {
                //                     let opt1 = self.registers[get_register_index(
                //                         instruction.r2.clone().expect("Need first source register"),
                //                     )]
                //                     .clone();

                //                     let opt2 = self.registers[get_register_index(
                //                         instruction.r3.clone().expect("Need second source register"),
                //                     )]
                //                     .clone();

                //                     return Ok(ExecuteReturnType::Select(a.not(), instruction.r1.clone().expect("need dst register"), opt1, opt2));
                //                 }
                //                 None => {
                //                     let opt1 = self.registers[get_register_index(
                //                         instruction.r2.clone().expect("Need first source register"),
                //                     )]
                //                     .clone();

                //                     let opt2 = self.registers[get_register_index(
                //                         instruction.r3.clone().expect("Need second source register"),
                //                     )]
                //                     .clone();
                //                     return Ok(ExecuteReturnType::Select(AbstractComparison::new("==", AbstractExpression::Abstract("c_flag".to_string()), AbstractExpression::Immediate(1)), instruction.r1.clone().expect("need dst register"), opt1, opt2));
                //                 }
                //             },
                //             "eq" => {
                //                 match self.zero.clone().expect("Need zero flag set") {
                //                     FlagValue::Real(z) => {
                //                         if z == true {
                //                             let register = self.registers[get_register_index(
                //                                 instruction.r2.clone().expect("Need first source register"),
                //                             )]
                //                             .clone();
                //                             self.set_register(
                //                                 instruction.r1.clone().expect("need dst register"),
                //                                 register.kind,
                //                                 register.base,
                //                                 register.offset,
                //                             );
                //                         } else {
                //                             let register = self.registers[get_register_index(
                //                                 instruction.r3.clone().expect("Need first source register"),
                //                             )]
                //                             .clone();
                //                             self.set_register(
                //                                 instruction.r1.clone().expect("need dst register"),
                //                                 register.kind,
                //                                 register.base,
                //                                 register.offset,
                //                             );
                //                         }
                //                     }
                //                     FlagValue::Abstract(z) => {
                //                         let opt1 = self.registers[get_register_index(
                //                             instruction.r2.clone().expect("Need first source register"),
                //                         )]
                //                         .clone();
                //                         let opt2 = self.registers[get_register_index(
                //                             instruction.r3.clone().expect("Need second source register"),
                //                         )]
                //                         .clone();
                //                         return Ok(ExecuteReturnType::Select(z, instruction.r1.clone().expect("need dst register"), opt1, opt2));
                //                     }
                //                 };
                //             },
                //             _ => todo!("unsupported comparison type for csel {:?}", instruction.r4),
                //         }
                //     }
                //     "csetm" => {
                //         // match on condition based on flags
                //         match instruction
                //             .r2
                //             .clone()
                //             .expect("Need to provide a condition")
                //             .as_str()
                //         {
                //             "eq" => match self.zero.clone().expect("Need zero flag set") {
                //                 FlagValue::Real(b) => {
                //                     if b == true {
                //                         self.set_register(
                //                             instruction.r1.clone().expect("need dst register"),
                //                             RegisterKind::Immediate,
                //                             None,
                //                             1,
                //                         );
                //                     } else {
                //                         self.set_register(
                //                             instruction.r1.clone().expect("need dst register"),
                //                             RegisterKind::Immediate,
                //                             None,
                //                             0,
                //                         );
                //                     }
                //                 }
                //                 FlagValue::Abstract(a) => {
                //                     let opt1 = RegisterValue {
                //                         kind: RegisterKind::Immediate,
                //                         base: None,
                //                         offset: 1,
                //                     };
                //                     let opt2= RegisterValue {
                //                         kind: RegisterKind::Immediate,
                //                         base: None,
                //                         offset: 1,
                //                     };

                //                     return Ok(ExecuteReturnType::Select(a, instruction.r1.clone().expect("need dst register"), opt1, opt2));
                //                 }
                //             },
                //             _ => todo!("unsupported comparison type {:?}", instruction.r2),
                //         }
                //     }
                //     "b" => {
                //         return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 5")));
                //     }
                //     "bl" => {
                //         let label = instruction
                //             .r1
                //             .clone()
                //             .expect("need label to jump")
                //             .to_string();
                //         self.set_register("x30".to_string(), RegisterKind::Immediate, None, pc as i64);
                //         return Ok(ExecuteReturnType::JumpLabel(label));
                //     }
                //     "b.ne" | "bne" => {
                //         match &self.zero {
                //             // if zero is set to false, then cmp -> not equal and we branch
                //             Some(flag) => match flag {
                //                 FlagValue::Real(b) => {
                //                     if !b {
                //                         return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 7")));
                //                     } else {
                //                         return Ok(ExecuteReturnType::Next);
                //                     }
                //                 }
                //                 FlagValue::Abstract(s) => {
                //                     return Ok(ExecuteReturnType::ConditionalJumpLabel(s.clone().not(), instruction.r1.clone().expect("need jump label 8")));
                //                 }
                //             },
                //             None => return Err(
                //                 "Flag cannot be branched on since it has not been set within the program yet"
                //                     .to_string(),
                //             ),
                //         }
                //     }
                //     "b.eq" | "beq" => {
                //         match &self.zero {
                //             // if zero is set to false, then cmp -> not equal and we branch
                //             Some(flag) => match flag {
                //                 FlagValue::Real(b) => {
                //                     if *b {
                //                         return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 9")));
                //                     } else {
                //                         return Ok(ExecuteReturnType::Next);
                //                     }
                //                 }
                //                 FlagValue::Abstract(s) => {
                //                     return Ok(ExecuteReturnType::ConditionalJumpLabel(s.clone(), instruction.r1.clone().expect("need jump label 10")));
                //                 }
                //             },
                //             None => return Err(
                //                 "Flag cannot be branched on since it has not been set within the program yet"
                //                     .to_string(),
                //             ),
                //         }
                //     }
                //     "bt" | "b.gt" => {
                //         match (&self.zero, &self.neg, &self.overflow) {
                //             (Some(zero), Some(neg), Some(ove)) => {
                //                 match  (zero, neg, ove) {
                //                 (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(v)) => {
                //                    if !z && n == v {  // Z = 0 AND N = V
                //                         return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 11")))
                //                    } else {
                //                         return Ok(ExecuteReturnType::Next)
                //                    }
                //                 },
                //                 (FlagValue::Abstract(z) , _, _ ) =>  {
                //                     let expression = generate_comparison(">", *z.left.clone(), *z.right.clone());
                //                     return Ok(ExecuteReturnType::ConditionalJumpLabel( expression, instruction.r1.clone().expect("need jump label 12")));
                //                 },
                //                 (_,_,_) => todo!("match on undefined flags!")
                //                 }
                //             },
                //             (_, _, _) => return Err(
                //                 "Flag cannot be branched on since it has not been set within the program yet"
                //                     .to_string(),
                //             ),
                //         }
                //     }
                //     "b.lt" => {
                //         match (&self.zero, &self.neg, &self.overflow) {
                //             (Some(zero), Some(neg), Some(ove)) => {
                //                 match  (zero, neg, ove) {
                //                 (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(v)) => {
                //                    if !z && n != v {  // Z = 0 AND N = V
                //                         return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 11")))
                //                    } else {
                //                         return Ok(ExecuteReturnType::Next)
                //                    }
                //                 },
                //                 (FlagValue::Abstract(z) , _, _ ) =>  {
                //                     let expression = generate_comparison("<", *z.left.clone(), *z.right.clone());
                //                     return Ok(ExecuteReturnType::ConditionalJumpLabel( expression, instruction.r1.clone().expect("need jump label 12")));
                //                 },
                //                 (_,_,_) => todo!("match on undefined flags!")
                //                 }
                //             },
                //             (_, _, _) => return Err(
                //                 "Flag cannot be branched on since it has not been set within the program yet"
                //                     .to_string(),
                //             ),
                //         }
                //     }
                //     "b.ls" | "b.le" => {
                //         match (&self.zero, &self.carry) {
                //             (Some(zero), Some(carry)) => {
                //                 match  (zero, carry) {
                //                 (FlagValue::Real(z), FlagValue::Real(c)) => {
                //                    if !z && *c {
                //                         return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 13")));
                //                    } else {
                //                         return Ok(ExecuteReturnType::Next)
                //                    }
                //                 },
                //                 (FlagValue::Abstract(z) , _ ) | (_, FlagValue::Abstract(z) ) =>  {
                //                     let expression = generate_comparison("<=", *z.left.clone(), *z.right.clone());
                //                     return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, instruction.r1.clone().expect("need jump label 14")));
                //                 },
                //                 }
                //             },
                //             (_, _) => return Err(
                //                 "Flag cannot be branched on since it has not been set within the program yet"
                //                     .to_string(),
                //             ),
                //         }
                //     }
                //     "b.cs" | "b.hs" | "bcs" => {
                //         match&self.carry{
                //             Some(carry) => {
                //                 match  carry {
                //                 FlagValue::Real(c) => {
                //                    if *c {
                //                         return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 15")));
                //                    } else {
                //                         return Ok(ExecuteReturnType::Next)
                //                    }
                //                 },
                //                 FlagValue::Abstract(c) =>  {
                //                     let expression = generate_comparison("<", *c.left.clone(), *c.right.clone());
                //                     return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, instruction.r1.clone().expect("need jump label 16")));
                //                 },
                //                 }
                //             },
                //             None => return Err(
                //                 "Flag cannot be branched on since it has not been set within the program yet"
                //                     .to_string(),
                //             ),
                //         }
                //     }
                //     "b.cc" | "b.lo" | "blo" => {
                //         match&self.carry{
                //             Some(carry) => {
                //                 match  carry {
                //                 FlagValue::Real(c) => {
                //                    if !*c {
                //                         return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 15")));
                //                    } else {
                //                         return Ok(ExecuteReturnType::Next)
                //                    }
                //                 },
                //                 FlagValue::Abstract(c) =>  {
                //                     let expression = generate_comparison(">=", *c.left.clone(), *c.right.clone());
                //                     return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, instruction.r1.clone().expect("need jump label 16")));
                //                 },
                //                 }
                //             },
                //             None => return Err(
                //                 "Flag cannot be branched on since it has not been set within the program yet"
                //                     .to_string(),
                //             ),
                //         }
                //     }
                //     "ret" => {
                //         if instruction.r1.is_none() {
                //             let x30 = self.registers[30].clone();
                //             if x30.kind == RegisterKind::RegisterBase {
                //                 if let Some(AbstractExpression::Abstract(address)) = x30.base {
                //                     if address == "return" && x30.offset == 0 {
                //                         return Ok(ExecuteReturnType::JumpLabel("return".to_string()));
                //                     } else {
                //                         return Ok(ExecuteReturnType::JumpLabel(address.to_string()));
                //                     }
                //                 }
                //                 return Ok(ExecuteReturnType::JumpAddress(x30.offset.try_into().expect("computer4")));
                //             } else {
                //                 return Ok(ExecuteReturnType::JumpLabel("return".to_string()));
                //             }
                //         } else {
                //             let _r1 = &self.registers[get_register_index(
                //                 instruction
                //                     .r1
                //                     .clone()
                //                     .expect("provide valid return register"),
                //             )];
                //         }
                //     }
                //     "ldr" => {
                //         let reg1 = instruction.r1.clone().expect("computer5");
                //         let reg2 = instruction.r2.clone().expect("computer6");

                //         let reg2base = get_register_name_string(reg2.clone());
                //         let mut base_add_reg =
                //             self.registers[get_register_index(reg2base.clone())].clone();

                //         // pre-index increment
                //         if reg2.contains(",") {
                //             if let Some((base, offset)) = reg2.split_once(",") {
                //                 base_add_reg = self.operand(base.to_string());
                //                 base_add_reg.offset = base_add_reg.offset + self.operand(offset.to_string()).offset;
                //             } else {
                //                 base_add_reg = self.operand(reg2.clone());
                //             }

                //             if reg2.contains("!") {
                //                 let new_reg = base_add_reg.clone();
                //                 self.set_register(
                //                     reg2base.clone(),
                //                     new_reg.kind,
                //                     new_reg.base,
                //                     new_reg.offset,
                //                 );
                //             }
                //         }

                //         let res = self.load(reg1, base_add_reg.clone());
                //         match res {
                //             Err(e) => return Err(e.to_string()),
                //             _ => (),
                //         }

                //         // post-index
                //         if instruction.r3.is_some() {
                //             let new_imm = self.operand(instruction.r3.clone().expect("computer7"));
                //             self.set_register(
                //                 reg2base,
                //                 base_add_reg.kind,
                //                 base_add_reg.base,
                //                 base_add_reg.offset + new_imm.offset,
                //             );
                //         }
                //     }
                //     "ldrb" => {
                //         let reg1 = instruction.r1.clone().expect("computer5");
                //         let reg2 = instruction.r2.clone().expect("computer6");

                //         let reg2base = get_register_name_string(reg2.clone());
                //         let mut base_add_reg =
                //             self.registers[get_register_index(reg2base.clone())].clone();

                //         // pre-index increment
                //         if reg2.contains(",") {
                //             if let Some((base, offset)) = reg2.split_once(",") {
                //                 base_add_reg = self.operand(base.to_string());
                //                 base_add_reg.offset = base_add_reg.offset + self.operand(offset.to_string()).offset;
                //             } else {
                //                 base_add_reg = self.operand(reg2.clone());
                //             }

                //             if reg2.contains("!") {
                //                 let new_reg = base_add_reg.clone();
                //                 self.set_register(
                //                     reg2base.clone(),
                //                     new_reg.kind,
                //                     new_reg.base,
                //                     new_reg.offset,
                //                 );
                //             }
                //         }

                //         let res = self.load(reg1, base_add_reg.clone());
                //         match res {
                //             Err(e) => return Err(e.to_string()),
                //             _ => (),
                //         }

                //         // post-index
                //         if instruction.r3.is_some() {
                //             let new_imm = self.operand(instruction.r3.clone().expect("computer7"));
                //             self.set_register(
                //                 reg2base,
                //                 base_add_reg.kind,
                //                 base_add_reg.base,
                //                 base_add_reg.offset + new_imm.offset,
                //             );
                //         }
                //     }
                //     "ldp" => {
                //         let reg1 = instruction.r1.clone().expect("computer8");
                //         let reg2 = instruction.r2.clone().expect("computer9");
                //         let reg3 = instruction.r3.clone().expect("computer10");

                //         let reg3base = get_register_name_string(reg3.clone());
                //         let mut base_add_reg =
                //             self.registers[get_register_index(reg3base.clone())].clone();

                //         // pre-index increment
                //         if reg3.contains(",") {
                //             base_add_reg = self.operand(reg3.clone().trim_end_matches("!").to_string());
                //             // with writeback
                //             if reg3.contains("!") {
                //                 let new_reg = base_add_reg.clone();
                //                 self.set_register(
                //                     reg3base.clone(),
                //                     new_reg.kind,
                //                     new_reg.base,
                //                     new_reg.offset,
                //                 );
                //             }
                //         }

                //         let res1 = self.load(reg1, base_add_reg.clone());

                //         let mut next = base_add_reg.clone();
                //         next.offset = next.offset + 8;
                //         let res2 = self.load(reg2, next);

                //         // post-index
                //         if instruction.r4.is_some() {
                //             let new_imm = self.operand(instruction.r4.clone().expect("computer11"));
                //             self.set_register(
                //                 reg3base,
                //                 base_add_reg.kind,
                //                 base_add_reg.base,
                //                 base_add_reg.offset + new_imm.offset,
                //             );
                //         }

                //         match res1 {
                //             Err(e) => return Err(e.to_string()),
                //             _ => (),
                //         }
                //         match res2 {
                //             Err(e) => return Err(e.to_string()),
                //             _ => (),
                //         }
                //     }
                //     "str" | "strb" => { // TODO: split
                //         let reg1 = instruction.r1.clone().expect("computer12");
                //         let reg2 = instruction.r2.clone().expect("computer13");

                //         let reg2base = get_register_name_string(reg2.clone());
                //         let mut base_add_reg =
                //             self.registers[get_register_index(reg2base.clone())].clone();

                //         // pre-index increment
                //         if reg2.contains(",") {
                //             base_add_reg = self.operand(reg2.clone().trim_end_matches("!").to_string());
                //             // with writeback
                //             if reg2.contains("!") {
                //                 let new_reg = base_add_reg.clone();
                //                 self.set_register(
                //                     reg2base.clone(),
                //                     new_reg.kind,
                //                     new_reg.base,
                //                     new_reg.offset,
                //                 );
                //             }
                //         }

                //         let reg2base = get_register_name_string(reg2.clone());
                //         let res = self.store(reg1, base_add_reg.clone());
                //         match res {
                //             Err(e) => return Err(e.to_string()),
                //             _ => (),
                //         }

                //         // post-index
                //         if instruction.r3.is_some() {
                //             let new_imm = self.operand(instruction.r3.clone().expect("computer14"));
                //             self.set_register(
                //                 reg2base,
                //                 base_add_reg.kind,
                //                 base_add_reg.base,
                //                 base_add_reg.offset + new_imm.offset,
                //             );
                //         }
                //     }
                //     "stp" => {
                //         let reg1 = instruction.r1.clone().expect("computer15");
                //         let reg2 = instruction.r2.clone().expect("computer16");
                //         let reg3 = instruction.r3.clone().expect("computer17");

                //         let reg3base = get_register_name_string(reg3.clone());
                //         let mut base_add_reg =
                //             self.registers[get_register_index(reg3base.clone())].clone();

                //         // pre-index increment
                //         if reg3.contains(",") {
                //             base_add_reg = self.operand(reg3.clone().trim_end_matches("!").to_string());
                //             // with writeback
                //             if reg3.contains("!") {
                //                 let new_reg = base_add_reg.clone();
                //                 self.set_register(
                //                     reg3base.clone(),
                //                     new_reg.kind,
                //                     new_reg.base,
                //                     new_reg.offset,
                //                 );
                //             }
                //         }

                //         let res = self.store(reg1, base_add_reg.clone());
                //         match res {
                //             Err(e) => return Err(e.to_string()),
                //             _ => (),
                //         }
                //         let mut next = base_add_reg.clone();
                //         next.offset = next.offset + 8;
                //         let res = self.store(reg2, next);
                //         match res {
                //             Err(e) => return Err(e.to_string()),
                //             _ => (),
                //         }

                //         // post-index
                //         if instruction.r4.is_some() {
                //             let new_imm = self.operand(instruction.r4.clone().expect("computer18"));
                //             self.set_register(
                //                 reg3base,
                //                 base_add_reg.kind,
                //                 base_add_reg.base,
                //                 base_add_reg.offset + new_imm.offset,
                //             );
                //         }
                //     }
                //     "mov" | "movz" => {
                //         let reg1 = instruction.r1.clone().expect("Need dst reg");
                //         let reg2 = instruction.r2.clone().expect("Need src reg");

                //         let src = self.operand(reg2);
                //         self.set_register(reg1, src.kind, src.base, src.offset);
                //     }
                //     "movk" => {
                //         let reg1 = instruction.r1.clone().expect("Need dst reg");
                //         let reg2 = instruction.r2.clone().expect("Need src reg");

                //         let src = self.operand(reg1.clone());
                //         let mut offset = self.operand(reg2).offset;

                //         if let Some(op) = instruction.r3.clone() {
                //             match op.as_str() {
                //                 "lsl" | "lsl#16" => offset = offset << 16,
                //                 _ => todo!("implement more shifting strategies for movk: {:?}", op),
                //             }
                //         }
                //         self.set_register(reg1, src.kind, src.base, src.offset + offset);
                //     }
                //     "rev" | "rev32" | "rbit" => { //TODO: reimpl rev32
                //         let reg1 = instruction.r1.clone().expect("Need dst register");
                //         let reg2 = instruction.r2.clone().expect("Need source register");

                //         let mut src = self.operand(reg2);

                //         if let Some(base) = src.base {
                //             src.base =
                //                 Some(generate_expression("rev", base, AbstractExpression::Empty));
                //         }

                //         src.offset = src.offset.swap_bytes();
                //         self.set_register(reg1, src.kind, src.base, src.offset);
                //     }
                //     "clz" => {
                //         // TODO: actually count
                //         let reg1 = instruction.r1.clone().expect("Need dst register");
                //         self.set_register(reg1, RegisterKind::Number, None, 0);
                //     }
                _ => todo!(),
            },
            InstructionType::Memory => match instruction.opcode.as_str() {
                _ => todo!(),
            },
            InstructionType::ControlFlow => match instruction.opcode.as_str() {
                _ => todo!(),
            },
            InstructionType::SIMDArithmetic => {
                todo!();
            }
            InstructionType::SIMDManagement => {
                todo!();
            }
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
