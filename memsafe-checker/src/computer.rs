use crate::common::*;
use std::collections::HashMap;
use std::fmt;
use z3::*;

fn get_register_index(reg_name: String) -> usize {
    let name = reg_name.clone();
    if reg_name == "sp" {
        return 31;
    }
    if reg_name == "xzr" {
        return 32;
    }

    if name.contains("v") {
        let r = name.trim_matches(|c| c == 'v' || c == '{' || c == '}');
        if let Some((num, _)) = r.split_once(".") {
            return num
                .parse::<usize>()
                .expect(format!("Invalid register value 1 {:?}", reg_name).as_str());
        } else {
            return r
                .parse::<usize>()
                .expect(format!("Invalid register value 2 {:?}", reg_name).as_str());
        }
    } else {
        let clean = name.replace(
            &['(', ')', ',', '\"', '.', ';', ':', '\'', '#', ']', '['][..],
            "",
        );
        let mut r = clean.strip_prefix("x").unwrap_or(&clean);
        r = r.strip_prefix("w").unwrap_or(&r);

        return r
            .strip_prefix("d")
            .unwrap_or(&r)
            .parse::<usize>()
            .expect(format!("Invalid register value 3 {:?}", name).as_str());
    }
}

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
        self.set_register(register, RegisterKind::Immediate, None, value as i64);
    }

    pub fn set_abstract(&mut self, register: String, value: AbstractExpression) {
        self.set_register(register, RegisterKind::RegisterBase, Some(value), 0);
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
        name: String,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        if name.contains("w") {
            self.registers[get_register_index(name.clone())].set(kind, base, (offset as i32) as i64)
        } else if name.contains("x") {
            self.registers[get_register_index(name.clone())].set(kind, base, offset as i64)
        } else if name.contains("v") {
            if let Some((_, arrangement)) = name.split_once(".") {
                self.simd_registers[get_register_index(name.clone())].set_register(
                    arrangement.to_string(),
                    kind,
                    base,
                    offset as u128,
                );
            }
        } else if name.contains("d") {
            self.simd_registers[get_register_index(name.clone())].set_register(
                "2d".to_string(),
                kind,
                base,
                offset as u128,
            );
        }
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

    // handle different addressing modes
    fn operand(&self, v: String) -> RegisterValue {
        if !v.contains('[') && v.contains('#') {
            let mut base: Option<AbstractExpression> = None;
            let mut offset: &str = &v;

            if v.contains("ror") {
                base = Some(AbstractExpression::Abstract("ror".to_string()));
                offset = v.strip_prefix("ror#").unwrap_or("0");
            }

            return RegisterValue {
                kind: RegisterKind::Immediate,
                base: base,
                offset: string_to_int(&offset),
            };

        // address within register
        } else if v.contains('[') && !v.contains(',') {
            let reg = self.registers[get_register_index(v.trim_matches('[').to_string())].clone();
            return RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: reg.base,
                offset: reg.offset,
            };
        } else if v.contains('[') && v.contains(',') && v.contains('#') && !v.contains('@') {
            let a = v.split_once(',').expect("computer1");
            let reg = self.registers[get_register_index(a.0.trim_matches('[').to_string())].clone();
            return RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: reg.base,
                offset: reg.offset + string_to_int(a.1.trim_matches(']')),
            };
        } else if v.contains("@") {
            let parts = v
                .split_once("@")
                .expect("Need two parts on either side of @");
            // TODO : expand functionality
            if parts.1.contains("OFF") || parts.1.contains("PAGE") {
                return RegisterValue {
                    kind: RegisterKind::Immediate,
                    base: Some(AbstractExpression::Abstract(parts.0.to_string())),
                    offset: 0,
                };
            } else {
                // TODO: use label as memory key
                return RegisterValue {
                    kind: RegisterKind::RegisterBase,
                    base: Some(AbstractExpression::Abstract("memory".to_string())),
                    offset: 0,
                };
            }
        } else if v.contains('+') {
            if let Some((base, offset)) = v.clone().split_once('+') {
                let off: i64 = i64::from_str_radix(offset.trim_start_matches("0x"), 16)
                    .expect("unable to parse label offset");
                return RegisterValue {
                    kind: RegisterKind::RegisterBase,
                    base: Some(AbstractExpression::Abstract(base.to_string())),
                    offset: off,
                };
            } else {
                todo!("something wrong")
            }
        } else if v.ends_with(&['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']) {
            return self.registers[get_register_index(v)].clone();
        } else {
            return RegisterValue {
                kind: RegisterKind::Number,
                base: Some(AbstractExpression::Abstract(v)),
                offset: 0,
            };
        }
    }

    pub fn execute(
        &mut self,
        pc: usize,
        instruction: &Instruction,
    ) -> Result<ExecuteReturnType, String> {
        if !instruction.is_simd() {
            match instruction.op.as_str() {
                "add" => {
                    self.arithmetic(
                        "+",
                        &|x, y| x + y,
                        instruction.r1.clone().expect("Need dst register"),
                        instruction.r2.clone().expect("Need one operand"),
                        instruction.r3.clone().expect("Need two operand"),
                        instruction.r4.clone(),
                    );
                }
                "mul" | "umulh" => { // separate
                    self.arithmetic(
                        "*",
                        &|x, y| x * y,
                        instruction.r1.clone().expect("Need dst register"),
                        instruction.r2.clone().expect("Need one operand"),
                        instruction.r3.clone().expect("Need two operand"),
                        instruction.r4.clone(),
                    );
                }
                "adds" => {
                    self.cmn(
                        instruction.r2.clone().expect("need register to compare"),
                        instruction.r3.clone().expect("need register to compare"),
                    );

                    self.arithmetic(
                        "+",
                        &|x, y| x + y,
                        instruction.r1.clone().expect("Need dst register"),
                        instruction.r2.clone().expect("Need one operand"),
                        instruction.r3.clone().expect("Need two operand"),
                        instruction.r4.clone(),
                    );
                }
                "sub" => {
                    self.arithmetic(
                        "-",
                        &|x, y| x - y,
                        instruction.r1.clone().expect("Need dst register"),
                        instruction.r2.clone().expect("Need one operand"),
                        instruction.r3.clone().expect("Need two operand"),
                        instruction.r4.clone(),
                    );
                }
                "subs" => {
                    self.cmp(
                        instruction.r2.clone().expect("need register to compare"),
                        instruction.r3.clone().expect("need register to compare"),
                    );

                    self.arithmetic(
                        "-",
                        &|x, y| x - y,
                        instruction.r1.clone().expect("Need dst register"),
                        instruction.r2.clone().expect("Need one operand"),
                        instruction.r3.clone().expect("Need two operand"),
                        instruction.r4.clone(),
                    );
                }
                "and" => {
                    self.arithmetic(
                        &instruction.op,
                        &|x, y| x & y,
                        instruction.r1.clone().expect("Need dst register"),
                        instruction.r2.clone().expect("Need one operand"),
                        instruction.r3.clone().expect("Need two operand"),
                        instruction.r4.clone(),
                    );
                }
                "tst" | "ands" => {
                    let r1 = self.operand(instruction.r1.clone().expect("need src"));
                    let mut r2 = self.operand(instruction.r2.clone().expect("need imm"));

                    if let Some(op) = instruction.r3.clone() {
                        match op.as_str() {
                            "<<" => {
                                let imm = instruction.r4.clone().expect("need shft amt in tst/ands").replace(&['(', ')', ',', '\"', '.', ';', ':', '\'', '#'][..], "").parse::<i64>().expect("expected valid number from parse");
                                r2.offset =  r2.offset << imm;
                            }
                            _ => todo!("tst/ands op on imm {:?}", op),
                        }
                    }

                    self.zero = if r1.offset == r2.offset {
                        Some(FlagValue::Real(true))
                    } else {
                        Some(FlagValue::Abstract(AbstractComparison::new(
                            "==",
                            AbstractExpression::Abstract("true".to_string()),
                            AbstractExpression::Abstract("HW_SUPPORT".to_string()),
                        )))
                    };

                    // TODO: this is a really bad way to do this, get expressions from include/arm_arch.h
                }
                "orr" => {
                    self.arithmetic(
                        &instruction.op,
                        &|x, y| x | y,
                        instruction.r1.clone().expect("Need dst register"),
                        instruction.r2.clone().expect("Need one operand"),
                        instruction.r3.clone().expect("Need two operand"),
                        instruction.r4.clone(),
                    );
                }
                "orn" => {
                    self.arithmetic(
                        &instruction.op,
                        &|x, y: i64| x | !y,
                        instruction.r1.clone().expect("Need dst register"),
                        instruction.r2.clone().expect("Need one operand"),
                        instruction.r3.clone().expect("Need two operand"),
                        instruction.r4.clone(),
                    );
                }
                "eor" => {
                    if instruction.r2.clone() == instruction.r3.clone() {
                        self.set_register(
                            instruction.r1.clone().expect("Need destination register"),
                            RegisterKind::Immediate,
                            None,
                            0,
                        );
                    } else {
                        self.arithmetic(
                            &instruction.op,
                            &|x, y| x ^ y,
                            instruction.r1.clone().expect("Need dst register"),
                            instruction.r2.clone().expect("Need one operand"),
                            instruction.r3.clone().expect("Need two operand"),
                            instruction.r4.clone(),
                        );
                    }
                }
                "bic" => {
                    self.arithmetic(
                        &instruction.op,
                        &|x, y: i64| x & !y,
                        instruction.r1.clone().expect("Need dst register"),
                        instruction.r2.clone().expect("Need one operand"),
                        instruction.r3.clone().expect("Need two operand"),
                        instruction.r4.clone(),
                    );
                }
                "lsr" | "lsl" => {
                    let r2 = self.registers
                        [get_register_index(instruction.r2.clone().expect("Need register"))]
                    .clone();
                    let shift = self
                        .operand(instruction.r3.clone().expect("Need shift amt"))
                        .offset;
                    let new_offset = r2.offset >> shift;
                    if new_offset == 0 {
                        self.set_register(
                            instruction.r1.clone().expect("Need destination register"),
                            r2.clone().kind,
                            None,
                            new_offset,
                        );
                    } else {
                        self.set_register(
                            instruction.r1.clone().expect("Need destination register"),
                            r2.clone().kind,
                            Some(generate_expression(
                                "lsr",
                                r2.base.unwrap_or(AbstractExpression::Empty),
                                AbstractExpression::Immediate(new_offset),
                            )),
                            new_offset,
                        );
                    }
                }
                "ror" => {
                    self.shift_reg(
                        instruction.r1.clone().expect("Need dst register"),
                        instruction.r2.clone().expect("Need one operand"),
                        instruction.r3.clone().expect("Need two operand"),
                    );
                }
                "adcs" | "adc" => {
                    match self.carry.clone() {
                    Some(FlagValue::Real(b)) => {
                        if b == true {
                            self.arithmetic(
                                "+",
                                &|x, y| x + y,
                                instruction.r1.clone().expect("Need dst register"),
                                instruction.r2.clone().expect("Need one operand"),
                                instruction.r2.clone().expect("Need one operand"),
                                Some("#1".to_string()),
                            );
                        } else {
                            self.arithmetic(
                                "+",
                                &|x, y| x + y,
                                instruction.r1.clone().expect("Need dst register"),
                                instruction.r2.clone().expect("Need one operand"),
                                instruction.r2.clone().expect("Need one operand"),
                                Some("#0".to_string()),
                            );
                        }
                    }
                    Some(FlagValue::Abstract(c)) => {
                        let opt1 = self.registers[get_register_index(
                            instruction.r2.clone().expect("Need first source register"),
                        )]
                        .clone();

                        let mut opt2 = self.registers[get_register_index(
                            instruction.r3.clone().expect("Need second source register"),
                        )]
                        .clone();
                        opt2.offset = opt2.offset + 1;

                        return Ok(ExecuteReturnType::Select(c,
                         instruction.r1.clone().expect("need dst register"), opt1, opt2));
                    }
                    None => {
                        let opt1 = self.registers[get_register_index(
                            instruction.r2.clone().expect("Need first source register"),
                        )]
                        .clone();

                        let mut opt2 = self.registers[get_register_index(
                            instruction.r3.clone().expect("Need second source register"),
                        )]
                        .clone();
                        opt2.offset = opt2.offset + 1;

                        return Ok(ExecuteReturnType::Select(AbstractComparison::new(
                            "==",
                            AbstractExpression::Abstract("carry".to_string()),
                            AbstractExpression::Immediate(1)),
                         instruction.r1.clone().expect("need dst register"), opt1, opt2));
                    }
                    }
                    //update flags
                    self.cmn(instruction.r1.clone().expect("need register to compare"),instruction.r2.clone().expect("need register to compare"), );
                },
                "sbcs" | "sbc" => match self.carry.clone() { // FIX: split
                    Some(FlagValue::Real(b)) => {
                        if b == true {
                            self.arithmetic(
                                "-",
                                &|x, y| x - y,
                                instruction.r1.clone().expect("Need dst register"),
                                instruction.r2.clone().expect("Need one operand"),
                                instruction.r2.clone().expect("Need one operand"),
                                Some("#1".to_string()),
                            );
                        } else {
                            self.arithmetic(
                                "-",
                                &|x, y| x - y,
                                instruction.r1.clone().expect("Need dst register"),
                                instruction.r2.clone().expect("Need one operand"),
                                instruction.r2.clone().expect("Need one operand"),
                                Some("#0".to_string()),
                            );
                        }
                    }
                    Some(FlagValue::Abstract(a)) => {
                        let opt1 = self.registers[get_register_index(
                            instruction.r2.clone().expect("Need first source register"),
                        )]
                        .clone();

                        let mut opt2 = self.registers[get_register_index(
                            instruction.r3.clone().expect("Need second source register"),
                        )]
                        .clone();
                        opt2.offset = opt2.offset + 1;

                        return Ok(ExecuteReturnType::Select(a,
                         instruction.r1.clone().expect("need dst register"), opt1, opt2));
                    }
                    None => {
                        let opt1 = self.registers[get_register_index(
                            instruction.r2.clone().expect("Need first source register"),
                        )]
                        .clone();

                        let mut opt2 = self.registers[get_register_index(
                            instruction.r3.clone().expect("Need second source register"),
                        )]
                        .clone();
                        opt2.offset = opt2.offset -1 ;

                        return Ok(ExecuteReturnType::Select(AbstractComparison::new(
                            "==",
                            AbstractExpression::Abstract("carry".to_string()),
                            AbstractExpression::Immediate(1)),
                            instruction.r1.clone().expect("need dst register"), opt1, opt2));
                    }
                },
                "adrp"=> {
                    let address = self.operand(instruction.r2.clone().expect("Need address label"));
                    self.set_register(
                        instruction.r1.clone().expect("need dst register"),
                        RegisterKind::RegisterBase,
                        address.base,
                        address.offset,
                    );
                }
                "adr" => {
                    let address = self.operand(instruction.r2.clone().expect("Need address label"));
                    self.set_register(
                        instruction.r1.clone().expect("need dst register"),
                        RegisterKind::RegisterBase,
                        address.base,
                        address.offset,
                    );
                }
                "cbnz" => {
                    let register = self.registers
                        [get_register_index(instruction.r1.clone().expect("Need one register"))]
                    .clone();
                    if (register.base.is_none()
                        || register.base.clone().expect("computer2") == AbstractExpression::Empty)
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
                            instruction.r2.clone().expect("need jump label 1 "),
                        ));
                    } else {
                        return Ok(ExecuteReturnType::JumpLabel(instruction.r2.clone().expect("need jump label 2")));
                    }
                }
                // Compare and Branch on Zero compares the value in a register with zero, and conditionally branches to a label at a PC-relative offset if the comparison is equal. It provides a hint that this is not a subroutine call or return. This instruction does not affect condition flags.
                "cbz" => {
                    let register = self.registers
                        [get_register_index(instruction.r1.clone().expect("Need one register"))]
                    .clone();

                    if (register.base.is_none()
                        || register.base.clone().expect("computer3") == AbstractExpression::Empty)
                        && register.offset == 0
                    {
                        return Ok(ExecuteReturnType::JumpLabel(instruction.r2.clone().expect("need jump label 3")));
                    } else if register.kind == RegisterKind::RegisterBase {
                        return Ok(ExecuteReturnType::ConditionalJumpLabel(
                            AbstractComparison::new(
                                "==",
                                AbstractExpression::Immediate(0),
                                AbstractExpression::Register(Box::new(register)),
                            ),
                            instruction.r2.clone().expect("need jump label 4"),
                        ));
                    } else {
                        return Ok(ExecuteReturnType::Next);
                    }
                }
                "cset" => {
                    // match on condition based on flags
                    match instruction
                        .r2
                        .clone()
                        .expect("Need to provide a condition")
                        .as_str()
                    {
                        "cs" => match self.carry.clone().expect("Need carry flag set cset cs") {
                            FlagValue::Real(b) => {
                                if b == true {
                                    self.set_register(
                                        instruction.r1.clone().expect("need dst register"),
                                        RegisterKind::Immediate,
                                        None,
                                        1,
                                    );
                                } else {
                                    self.set_register(
                                        instruction.r1.clone().expect("need dst register"),
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
                        "cc" | "lo" => match self.carry.clone().expect("Need carry flag set cset cc") {
                            FlagValue::Real(b) => {
                                if b == false {
                                    self.set_register(
                                        instruction.r1.clone().expect("need dst register"),
                                        RegisterKind::Immediate,
                                        None,
                                        0,
                                    );
                                } else {
                                    self.set_register(
                                        instruction.r1.clone().expect("need dst register"),
                                        RegisterKind::Immediate,
                                        None,
                                        1,
                                    );
                                }
                            }
                            FlagValue::Abstract(_) => {
                                log::error!("Can't support this yet :)");
                                todo!("Abstract flag expressions 4");
                            }
                        },
                        _ => todo!("unsupported comparison type {:?}", instruction.r2),
                    }
                }
                "csel" => {
                    // match on condition based on flags
                    match instruction
                        .r4
                        .clone()
                        .expect("Need to provide a condition")
                        .as_str()
                    {
                        "cc" | "lo" => match self.carry.clone().expect("Need carry flag set csel cc") {
                            FlagValue::Real(b) => {
                                if b == true {
                                    let register = self.registers[get_register_index(
                                        instruction.r2.clone().expect("Need first source register"),
                                    )]
                                    .clone();
                                    self.set_register(
                                        instruction.r1.clone().expect("need dst register"),
                                        register.kind,
                                        register.base,
                                        register.offset,
                                    );
                                } else {
                                    let register = self.registers[get_register_index(
                                        instruction.r3.clone().expect("Need first source register"),
                                    )]
                                    .clone();
                                    self.set_register(
                                        instruction.r1.clone().expect("need dst register"),
                                        register.kind,
                                        register.base,
                                        register.offset,
                                    );
                                }
                            }
                            FlagValue::Abstract(a) => {
                                let opt1 = self.registers[get_register_index(
                                    instruction.r2.clone().expect("Need first source register"),
                                )]
                                .clone();

                                let opt2 = self.registers[get_register_index(
                                    instruction.r3.clone().expect("Need second source register"),
                                )]
                                .clone();

                                return Ok(ExecuteReturnType::Select(a, instruction.r1.clone().expect("need dst register"), opt1, opt2));
                            }
                        },
                        "cs" => match self.carry.clone() {
                            Some(FlagValue::Real(b)) => {
                                if b == false {
                                    let register = self.registers[get_register_index(
                                        instruction.r2.clone().expect("Need first source register"),
                                    )]
                                    .clone();
                                    self.set_register(
                                        instruction.r1.clone().expect("need dst register"),
                                        register.kind,
                                        register.base,
                                        register.offset,
                                    );
                                } else {
                                    let register = self.registers[get_register_index(
                                        instruction.r3.clone().expect("Need first source register"),
                                    )]
                                    .clone();
                                    self.set_register(
                                        instruction.r1.clone().expect("need dst register"),
                                        register.kind,
                                        register.base,
                                        register.offset,
                                    );
                                }
                            }
                            Some(FlagValue::Abstract(a)) => {
                                let opt1 = self.registers[get_register_index(
                                    instruction.r2.clone().expect("Need first source register"),
                                )]
                                .clone();

                                let opt2 = self.registers[get_register_index(
                                    instruction.r3.clone().expect("Need second source register"),
                                )]
                                .clone();

                                return Ok(ExecuteReturnType::Select(a.not(), instruction.r1.clone().expect("need dst register"), opt1, opt2));
                            }
                            None => {
                                let opt1 = self.registers[get_register_index(
                                    instruction.r2.clone().expect("Need first source register"),
                                )]
                                .clone();

                                let opt2 = self.registers[get_register_index(
                                    instruction.r3.clone().expect("Need second source register"),
                                )]
                                .clone();
                                return Ok(ExecuteReturnType::Select(AbstractComparison::new("==", AbstractExpression::Abstract("c_flag".to_string()), AbstractExpression::Immediate(1)), instruction.r1.clone().expect("need dst register"), opt1, opt2)); 
                            }
                        },
                        "eq" => {
                            match self.zero.clone().expect("Need zero flag set") {
                                FlagValue::Real(z) => {
                                    if z == true {
                                        let register = self.registers[get_register_index(
                                            instruction.r2.clone().expect("Need first source register"),
                                        )]
                                        .clone();
                                        self.set_register(
                                            instruction.r1.clone().expect("need dst register"),
                                            register.kind,
                                            register.base,
                                            register.offset,
                                        );
                                    } else {
                                        let register = self.registers[get_register_index(
                                            instruction.r3.clone().expect("Need first source register"),
                                        )]
                                        .clone();
                                        self.set_register(
                                            instruction.r1.clone().expect("need dst register"),
                                            register.kind,
                                            register.base,
                                            register.offset,
                                        );
                                    }
                                }
                                FlagValue::Abstract(z) => {
                                    let opt1 = self.registers[get_register_index(
                                        instruction.r2.clone().expect("Need first source register"),
                                    )]
                                    .clone();
                                    let opt2 = self.registers[get_register_index(
                                        instruction.r3.clone().expect("Need second source register"),
                                    )]
                                    .clone();
                                    return Ok(ExecuteReturnType::Select(z, instruction.r1.clone().expect("need dst register"), opt1, opt2));
                                }
                            };
                        },
                        _ => todo!("unsupported comparison type for csel {:?}", instruction.r4),
                    }
                }
                "csetm" => {
                    // match on condition based on flags
                    match instruction
                        .r2
                        .clone()
                        .expect("Need to provide a condition")
                        .as_str()
                    {
                        "eq" => match self.zero.clone().expect("Need zero flag set") {
                            FlagValue::Real(b) => {
                                if b == true {
                                    self.set_register(
                                        instruction.r1.clone().expect("need dst register"),
                                        RegisterKind::Immediate,
                                        None,
                                        1,
                                    );
                                } else {
                                    self.set_register(
                                        instruction.r1.clone().expect("need dst register"),
                                        RegisterKind::Immediate,
                                        None,
                                        0,
                                    );
                                }
                            }
                            FlagValue::Abstract(a) => {
                                let opt1 = RegisterValue {
                                    kind: RegisterKind::Immediate,
                                    base: None,
                                    offset: 1,
                                };
                                let opt2= RegisterValue {
                                    kind: RegisterKind::Immediate,
                                    base: None,
                                    offset: 1,
                                };

                                return Ok(ExecuteReturnType::Select(a, instruction.r1.clone().expect("need dst register"), opt1, opt2));
                            }
                        },
                        _ => todo!("unsupported comparison type {:?}", instruction.r2),
                    }
                }
                "cmp" => {
                    self.cmp(
                        instruction.r1.clone().expect("need register to compare"),
                        instruction.r2.clone().expect("need register to compare"),
                    );
                    // TODO: make branch more general
                    // https://developer.arm.com/documentation/dui0068/b/ARM-Instruction-Reference/Conditional-execution
                }
                "cmn" => {
                    self.cmn(
                        instruction.r1.clone().expect("need register to compare"),
                        instruction.r2.clone().expect("need register to compare"),
                    );
                }
                "b" => {
                    return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 5")));
                }
                "bl" => {
                    let label = instruction
                        .r1
                        .clone()
                        .expect("need label to jump")
                        .to_string();
                    self.set_register("x30".to_string(), RegisterKind::Immediate, None, pc as i64);
                    return Ok(ExecuteReturnType::JumpLabel(label));
                }
                "b.ne" | "bne" => {
                    match &self.zero {
                        // if zero is set to false, then cmp -> not equal and we branch
                        Some(flag) => match flag {
                            FlagValue::Real(b) => {
                                if !b {
                                    return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 7")));
                                } else {
                                    return Ok(ExecuteReturnType::Next);
                                }
                            }
                            FlagValue::Abstract(s) => {
                                return Ok(ExecuteReturnType::ConditionalJumpLabel(s.clone().not(), instruction.r1.clone().expect("need jump label 8")));
                            }
                        },
                        None => return Err(
                            "Flag cannot be branched on since it has not been set within the program yet"
                                .to_string(),
                        ),
                    }
                }
                "b.eq" | "beq" => {
                    match &self.zero {
                        // if zero is set to false, then cmp -> not equal and we branch
                        Some(flag) => match flag {
                            FlagValue::Real(b) => {
                                if *b {
                                    return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 9")));
                                } else {
                                    return Ok(ExecuteReturnType::Next);
                                }
                            }
                            FlagValue::Abstract(s) => {
                                return Ok(ExecuteReturnType::ConditionalJumpLabel(s.clone(), instruction.r1.clone().expect("need jump label 10")));
                            }
                        },
                        None => return Err(
                            "Flag cannot be branched on since it has not been set within the program yet"
                                .to_string(),
                        ),
                    }
                }
                "bt" | "b.gt" => {
                    match (&self.zero, &self.neg, &self.overflow) {
                        (Some(zero), Some(neg), Some(ove)) => {
                            match  (zero, neg, ove) {
                            (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(v)) => {
                               if !z && n == v {  // Z = 0 AND N = V
                                    return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 11")))
                               } else {
                                    return Ok(ExecuteReturnType::Next)
                               }
                            },
                            (FlagValue::Abstract(z) , _, _ ) =>  {
                                let expression = generate_comparison(">", *z.left.clone(), *z.right.clone());
                                return Ok(ExecuteReturnType::ConditionalJumpLabel( expression, instruction.r1.clone().expect("need jump label 12")));
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
                "b.lt" => {
                    match (&self.zero, &self.neg, &self.overflow) {
                        (Some(zero), Some(neg), Some(ove)) => {
                            match  (zero, neg, ove) {
                            (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(v)) => {
                               if !z && n != v {  // Z = 0 AND N = V
                                    return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 11")))
                               } else {
                                    return Ok(ExecuteReturnType::Next)
                               }
                            },
                            (FlagValue::Abstract(z) , _, _ ) =>  {
                                let expression = generate_comparison("<", *z.left.clone(), *z.right.clone());
                                return Ok(ExecuteReturnType::ConditionalJumpLabel( expression, instruction.r1.clone().expect("need jump label 12")));
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
                "b.ls" | "b.le" => {
                    match (&self.zero, &self.carry) {
                        (Some(zero), Some(carry)) => {
                            match  (zero, carry) {
                            (FlagValue::Real(z), FlagValue::Real(c)) => {
                               if !z && *c {
                                    return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 13")));
                               } else {
                                    return Ok(ExecuteReturnType::Next)
                               }
                            },
                            (FlagValue::Abstract(z) , _ ) | (_, FlagValue::Abstract(z) ) =>  {
                                let expression = generate_comparison("<=", *z.left.clone(), *z.right.clone());
                                return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, instruction.r1.clone().expect("need jump label 14")));
                            },
                            }
                        },
                        (_, _) => return Err(
                            "Flag cannot be branched on since it has not been set within the program yet"
                                .to_string(),
                        ),
                    }
                }
                "b.cs" | "b.hs" | "bcs" => {
                    match&self.carry{
                        Some(carry) => {
                            match  carry {
                            FlagValue::Real(c) => {
                               if *c {
                                    return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 15")));
                               } else {
                                    return Ok(ExecuteReturnType::Next)
                               }
                            },
                            FlagValue::Abstract(c) =>  {
                                let expression = generate_comparison("<", *c.left.clone(), *c.right.clone());
                                return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, instruction.r1.clone().expect("need jump label 16")));
                            },
                            }
                        },
                        None => return Err(
                            "Flag cannot be branched on since it has not been set within the program yet"
                                .to_string(),
                        ),
                    }
                }
                "b.cc" | "b.lo" | "blo" => {
                    match&self.carry{
                        Some(carry) => {
                            match  carry {
                            FlagValue::Real(c) => {
                               if !*c {
                                    return Ok(ExecuteReturnType::JumpLabel(instruction.r1.clone().expect("need jump label 15")));
                               } else {
                                    return Ok(ExecuteReturnType::Next)
                               }
                            },
                            FlagValue::Abstract(c) =>  {
                                let expression = generate_comparison(">=", *c.left.clone(), *c.right.clone());
                                return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, instruction.r1.clone().expect("need jump label 16")));
                            },
                            }
                        },
                        None => return Err(
                            "Flag cannot be branched on since it has not been set within the program yet"
                                .to_string(),
                        ),
                    }
                }
                "ret" => {
                    if instruction.r1.is_none() {
                        let x30 = self.registers[30].clone();
                        if x30.kind == RegisterKind::RegisterBase {
                            if let Some(AbstractExpression::Abstract(address)) = x30.base {
                                if address == "return" && x30.offset == 0 {
                                    return Ok(ExecuteReturnType::JumpLabel("return".to_string()));
                                } else {
                                    return Ok(ExecuteReturnType::JumpLabel(address.to_string()));
                                }
                            }
                            return Ok(ExecuteReturnType::JumpAddress(x30.offset.try_into().expect("computer4")));
                        } else {
                            return Ok(ExecuteReturnType::JumpLabel("return".to_string()));
                        }
                    } else {
                        let _r1 = &self.registers[get_register_index(
                            instruction
                                .r1
                                .clone()
                                .expect("provide valid return register"),
                        )];
                    }
                }
                "ldr" => {
                    let reg1 = instruction.r1.clone().expect("computer5");
                    let reg2 = instruction.r2.clone().expect("computer6");

                    let reg2base = get_register_name_string(reg2.clone());
                    let mut base_add_reg =
                        self.registers[get_register_index(reg2base.clone())].clone();

                    // pre-index increment
                    if reg2.contains(",") {
                        if let Some((base, offset)) = reg2.split_once(",") {
                            base_add_reg = self.operand(base.to_string());
                            base_add_reg.offset = base_add_reg.offset + self.operand(offset.to_string()).offset;
                        } else {
                            base_add_reg = self.operand(reg2.clone());
                        }

                        if reg2.contains("!") {
                            let new_reg = base_add_reg.clone();
                            self.set_register(
                                reg2base.clone(),
                                new_reg.kind,
                                new_reg.base,
                                new_reg.offset,
                            );
                        }
                    }

                    let res = self.load(reg1, base_add_reg.clone());
                    match res {
                        Err(e) => return Err(e.to_string()),
                        _ => (),
                    }

                    // post-index
                    if instruction.r3.is_some() {
                        let new_imm = self.operand(instruction.r3.clone().expect("computer7"));
                        self.set_register(
                            reg2base,
                            base_add_reg.kind,
                            base_add_reg.base,
                            base_add_reg.offset + new_imm.offset,
                        );
                    }
                }
                "ldrb" => {
                    let reg1 = instruction.r1.clone().expect("computer5");
                    let reg2 = instruction.r2.clone().expect("computer6");

                    let reg2base = get_register_name_string(reg2.clone());
                    let mut base_add_reg =
                        self.registers[get_register_index(reg2base.clone())].clone();

                    // pre-index increment
                    if reg2.contains(",") {
                        if let Some((base, offset)) = reg2.split_once(",") {
                            base_add_reg = self.operand(base.to_string());
                            base_add_reg.offset = base_add_reg.offset + self.operand(offset.to_string()).offset;
                        } else {
                            base_add_reg = self.operand(reg2.clone());
                        }

                        if reg2.contains("!") {
                            let new_reg = base_add_reg.clone();
                            self.set_register(
                                reg2base.clone(),
                                new_reg.kind,
                                new_reg.base,
                                new_reg.offset,
                            );
                        }
                    }

                    let res = self.load(reg1, base_add_reg.clone());
                    match res {
                        Err(e) => return Err(e.to_string()),
                        _ => (),
                    }

                    // post-index
                    if instruction.r3.is_some() {
                        let new_imm = self.operand(instruction.r3.clone().expect("computer7"));
                        self.set_register(
                            reg2base,
                            base_add_reg.kind,
                            base_add_reg.base,
                            base_add_reg.offset + new_imm.offset,
                        );
                    }
                }
                "ldp" => {
                    let reg1 = instruction.r1.clone().expect("computer8");
                    let reg2 = instruction.r2.clone().expect("computer9");
                    let reg3 = instruction.r3.clone().expect("computer10");

                    let reg3base = get_register_name_string(reg3.clone());
                    let mut base_add_reg =
                        self.registers[get_register_index(reg3base.clone())].clone();

                    // pre-index increment
                    if reg3.contains(",") {
                        base_add_reg = self.operand(reg3.clone().trim_end_matches("!").to_string());
                        // with writeback
                        if reg3.contains("!") {
                            let new_reg = base_add_reg.clone();
                            self.set_register(
                                reg3base.clone(),
                                new_reg.kind,
                                new_reg.base,
                                new_reg.offset,
                            );
                        }
                    }

                    let res1 = self.load(reg1, base_add_reg.clone());

                    let mut next = base_add_reg.clone();
                    next.offset = next.offset + 8;
                    let res2 = self.load(reg2, next);

                    // post-index
                    if instruction.r4.is_some() {
                        let new_imm = self.operand(instruction.r4.clone().expect("computer11"));
                        self.set_register(
                            reg3base,
                            base_add_reg.kind,
                            base_add_reg.base,
                            base_add_reg.offset + new_imm.offset,
                        );
                    }

                    match res1 {
                        Err(e) => return Err(e.to_string()),
                        _ => (),
                    }
                    match res2 {
                        Err(e) => return Err(e.to_string()),
                        _ => (),
                    }
                }
                "str" | "strb" => { // TODO: split
                    let reg1 = instruction.r1.clone().expect("computer12");
                    let reg2 = instruction.r2.clone().expect("computer13");

                    let reg2base = get_register_name_string(reg2.clone());
                    let mut base_add_reg =
                        self.registers[get_register_index(reg2base.clone())].clone();

                    // pre-index increment
                    if reg2.contains(",") {
                        base_add_reg = self.operand(reg2.clone().trim_end_matches("!").to_string());
                        // with writeback
                        if reg2.contains("!") {
                            let new_reg = base_add_reg.clone();
                            self.set_register(
                                reg2base.clone(),
                                new_reg.kind,
                                new_reg.base,
                                new_reg.offset,
                            );
                        }
                    }

                    let reg2base = get_register_name_string(reg2.clone());
                    let res = self.store(reg1, base_add_reg.clone());
                    match res {
                        Err(e) => return Err(e.to_string()),
                        _ => (),
                    }

                    // post-index
                    if instruction.r3.is_some() {
                        let new_imm = self.operand(instruction.r3.clone().expect("computer14"));
                        self.set_register(
                            reg2base,
                            base_add_reg.kind,
                            base_add_reg.base,
                            base_add_reg.offset + new_imm.offset,
                        );
                    }
                }
                "stp" => {
                    let reg1 = instruction.r1.clone().expect("computer15");
                    let reg2 = instruction.r2.clone().expect("computer16");
                    let reg3 = instruction.r3.clone().expect("computer17");

                    let reg3base = get_register_name_string(reg3.clone());
                    let mut base_add_reg =
                        self.registers[get_register_index(reg3base.clone())].clone();

                    // pre-index increment
                    if reg3.contains(",") {
                        base_add_reg = self.operand(reg3.clone().trim_end_matches("!").to_string());
                        // with writeback
                        if reg3.contains("!") {
                            let new_reg = base_add_reg.clone();
                            self.set_register(
                                reg3base.clone(),
                                new_reg.kind,
                                new_reg.base,
                                new_reg.offset,
                            );
                        }
                    }

                    let res = self.store(reg1, base_add_reg.clone());
                    match res {
                        Err(e) => return Err(e.to_string()),
                        _ => (),
                    }
                    let mut next = base_add_reg.clone();
                    next.offset = next.offset + 8;
                    let res = self.store(reg2, next);
                    match res {
                        Err(e) => return Err(e.to_string()),
                        _ => (),
                    }

                    // post-index
                    if instruction.r4.is_some() {
                        let new_imm = self.operand(instruction.r4.clone().expect("computer18"));
                        self.set_register(
                            reg3base,
                            base_add_reg.kind,
                            base_add_reg.base,
                            base_add_reg.offset + new_imm.offset,
                        );
                    }
                }
                "mov" | "movz" => {
                    let reg1 = instruction.r1.clone().expect("Need dst reg");
                    let reg2 = instruction.r2.clone().expect("Need src reg");

                    let src = self.operand(reg2);
                    self.set_register(reg1, src.kind, src.base, src.offset);
                }
                "movk" => {
                    let reg1 = instruction.r1.clone().expect("Need dst reg");
                    let reg2 = instruction.r2.clone().expect("Need src reg");

                    let src = self.operand(reg1.clone());
                    let mut offset = self.operand(reg2).offset;

                    if let Some(op) = instruction.r3.clone() {
                        match op.as_str() {
                            "lsl" | "lsl#16" => offset = offset << 16,
                            _ => todo!("implement more shifting strategies for movk: {:?}", op),
                        }
                    }
                    self.set_register(reg1, src.kind, src.base, src.offset + offset);
                }
                "rev" | "rev32" | "rbit" => { //TODO: reimpl rev32
                    let reg1 = instruction.r1.clone().expect("Need dst register");
                    let reg2 = instruction.r2.clone().expect("Need source register");

                    let mut src = self.operand(reg2);

                    if let Some(base) = src.base {
                        src.base =
                            Some(generate_expression("rev", base, AbstractExpression::Empty));
                    }

                    src.offset = src.offset.swap_bytes();
                    self.set_register(reg1, src.kind, src.base, src.offset);
                }
                "clz" => {
                    // TODO: actually count
                    let reg1 = instruction.r1.clone().expect("Need dst register");
                    self.set_register(reg1, RegisterKind::Number, None, 0);
                }
                _ => {
                    log::warn!("Instruction not supported {:?}", instruction);
                    todo!("Instruction not implemented {:?}", instruction)
                }
            }
        } else {
            // SIMD
            if instruction.op.contains(".") {
                if let Some((op, vec)) = instruction.op.split_once(".") {
                    match op {
                        "rev64" => {
                            let reg1 = instruction.r1.clone().expect("Need dst register");
                            let reg2 = instruction.r2.clone().expect("Need source register");

                            let src =
                                &self.simd_registers[get_register_index(reg2.clone())].clone();
                            let dest = &mut self.simd_registers[get_register_index(reg1.clone())];

                            dest.kind = src.kind.clone();
                            match vec {
                                "8h" => {
                                    for i in 0..8 {
                                        let (base, offset) = src.get_halfword(7 - i);
                                        dest.set_halfword(i, base, offset);
                                    }
                                }
                                "16b" => {
                                    for i in 0..16 {
                                        let (base, offset) = src.get_byte(15 - i);
                                        dest.set_byte(i, base, offset);
                                    }
                                }
                                _ => todo!("rev64 support more vector modes"),
                            }
                        }
                        "ld1" => {
                            // TODO: fix parser to not consider { as register
                            // using 2 and 4 because instruction gets parsed like this:
                            // Instruction { op: "ld1.8h", r1: Some("{"), r2: Some("v0"), r3: Some("}"), r4: Some("[x1"), r5: None, r6: None }
                            let reg2 = instruction.r2.clone().expect("Need dst register");
                            let reg4 = instruction.r4.clone().expect("Need source register");

                            let src = &self.registers[get_register_index(
                                reg4.strip_prefix('[').unwrap_or(&reg4).to_string(),
                            )]
                            .clone();

                            let res = self.load_vector(reg2, src.clone());
                            match res {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }
                        }
                        "st1" => {
                            // TODO: fix parser because instruction gets parsed like this:
                            // Instruction { op: "st1.d", r1: Some("{"), r2: Some("v0"), r3: Some("[1], [x0"), r4: Some("[1], [x0"), r5: Some("x4"), r6: None }
                            let reg2 = instruction.r2.clone().expect("Need src register");
                            let reg3 = instruction.r3.clone().expect("Need index and dest");

                            let mut parts = reg3.split(",");
                            let _index = parts
                                .next()
                                .expect("expecting index")
                                .strip_prefix('[')
                                .expect("something")
                                .strip_suffix("]")
                                .expect("something else")
                                .parse::<i32>()
                                .expect("expected int");

                            let dest = get_register_name_string(
                                parts
                                    .next()
                                    .expect("need another reg")
                                    .strip_prefix(" [")
                                    .expect("storage dest")
                                    .to_string(),
                            );
                            let address = self.registers[get_register_index(dest.clone())].clone();

                            // TODO: use offset to grab only low/high parts of vector
                            let res = self.store_vector(reg2, address.clone());
                            match res {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }

                            if let Some(reg5) = instruction.r5.clone() {
                                let offset = self.operand(reg5);

                                self.set_register(
                                    dest,
                                    address.kind,
                                    address.base,
                                    address.offset + offset.offset,
                                );
                            }
                        }
                        "ld1r" => {
                            let dst = instruction.r2.clone().expect("need dst ld1r") + vec;
                            let src = instruction.r4.clone().expect("need src ld1r");

                            let address = self.registers[get_register_index(src.clone())].clone();
                            let _ = self.load(dst, address);

                            //    match vec {
                            //     "16b" => {
                            //         for i in 0..15 {
                            //             set_byte
                            //         }
                            // },

                            // _ => todo!("support more ld1r types")
                            //    }
                        }
                        "dup" | "neg" | "shl" => {
                            println!("here");
                        }
                        _ => todo!("support simd operation with notation {:?}", instruction),
                    }
                }
            } else {
                match instruction.op.as_str() {
                    "ld1" => {
                        let reg1 = instruction.r1.clone().expect("Need first source register");
                        let reg2 = instruction
                            .r2
                            .clone()
                            .expect("Need second source or dst register");
                        // either two vector registers in r1 and r2, or four in r1-r4, followed by address and potentially followed by immediate increment value
                        if let Some(reg5) = &instruction.r5 {
                            let reg3 = instruction.r3.clone().expect("Need 3rd vector");
                            let reg4 = instruction.r4.clone().expect("Need 4th vector");
                            if reg4.contains("}") {
                                let base_name = get_register_name_string(reg5.clone());
                                let base_add_reg =
                                    self.registers[get_register_index(base_name.clone())].clone();

                                match self.load_vector(reg1, base_add_reg.clone()) {
                                    Err(e) => return Err(e.to_string()),
                                    _ => (),
                                }
                                match self.load_vector(reg2, base_add_reg.clone()) {
                                    Err(e) => return Err(e.to_string()),
                                    _ => (),
                                }
                                match self.load_vector(reg3, base_add_reg.clone()) {
                                    Err(e) => return Err(e.to_string()),
                                    _ => (),
                                }
                                match self.load_vector(reg4, base_add_reg.clone()) {
                                    Err(e) => return Err(e.to_string()),
                                    _ => (),
                                }

                                if let Some(reg6) = &instruction.r6 {
                                    let new_imm =
                                        self.operand(get_register_name_string(reg6.clone()));
                                    let peeled_reg5 =
                                        reg5.strip_prefix("[").unwrap_or(reg5).to_string();
                                    self.set_register(
                                        peeled_reg5,
                                        base_add_reg.kind,
                                        base_add_reg.base,
                                        base_add_reg.offset + new_imm.offset,
                                    );
                                }
                            } else {
                                let imm = self.operand(reg3.to_string());
                                let base_name = get_register_name_string(reg2.clone());
                                let mut base_add_reg =
                                    self.registers[get_register_index(base_name.clone())].clone();

                                base_add_reg.offset = base_add_reg.offset + imm.offset;
                                let res = self.load_vector(reg1, base_add_reg.clone());
                                match res {
                                    Err(e) => return Err(e.to_string()),
                                    _ => (),
                                }
                            }
                        } else if let Some(reg3) = &instruction.r3 {
                            if reg2.contains("}") {
                                let base_name = get_register_name_string(reg3.clone());
                                let base_add_reg =
                                    self.registers[get_register_index(base_name.clone())].clone();

                                match self.load_vector(reg1, base_add_reg.clone()) {
                                    Err(e) => return Err(e.to_string()),
                                    _ => (),
                                }
                                match self.load_vector(reg2, base_add_reg.clone()) {
                                    Err(e) => return Err(e.to_string()),
                                    _ => (),
                                }
                                if let Some(reg4) = &instruction.r4 {
                                    let new_imm =
                                        self.operand(get_register_name_string(reg4.clone()));
                                    let peeled_reg3 =
                                        reg3.strip_prefix("[").unwrap_or(reg3).to_string();
                                    self.set_register(
                                        peeled_reg3,
                                        base_add_reg.kind,
                                        base_add_reg.base,
                                        base_add_reg.offset + new_imm.offset,
                                    );
                                }
                            } else if reg3.contains("#") {
                                let base_name = get_register_name_string(reg2.clone());
                                let base_add_reg =
                                    self.registers[get_register_index(base_name.clone())].clone();

                                let res = self.load_vector(reg1, base_add_reg.clone());
                                match res {
                                    Err(e) => return Err(e.to_string()),
                                    _ => (),
                                }

                                //post index
                                let imm = self.operand(reg3.to_string());
                                self.set_register(
                                    base_name,
                                    base_add_reg.kind,
                                    base_add_reg.base,
                                    base_add_reg.offset + imm.offset,
                                );
                            } else {
                                let imm = self.operand(reg3.to_string());
                                let base_name = get_register_name_string(reg2.clone());
                                let mut base_add_reg =
                                    self.registers[get_register_index(base_name.clone())].clone();

                                base_add_reg.offset = base_add_reg.offset + imm.offset;
                                let res = self.load_vector(reg1, base_add_reg.clone());
                                match res {
                                    Err(e) => return Err(e.to_string()),
                                    _ => (),
                                }
                            }
                        } else {
                            let base_name = get_register_name_string(reg2.clone());
                            let base_add_reg =
                                self.registers[get_register_index(base_name.clone())].clone();
                            let res = self.load_vector(reg1, base_add_reg.clone());
                            match res {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }
                        }
                    }
                    "st1" => {
                        let reg1 = instruction.r1.clone().expect("computer19");
                        let reg2 = instruction.r2.clone().expect("computer20");
                        if let Some(reg3) = instruction.r3.clone() {
                            if reg3.contains("#") {
                                let offset = self.operand(reg3).offset;
                                let reg2base = get_register_name_string(reg2.clone());
                                let mut base_add_reg =
                                    self.registers[get_register_index(reg2base.clone())].clone();
                                base_add_reg.offset = base_add_reg.offset + offset;

                                let res = self.store_vector(reg1, base_add_reg.clone());
                                match res {
                                    Err(e) => return Err(e.to_string()),
                                    _ => (),
                                }
                            } else {
                                let reg3base = get_register_name_string(reg3.clone());
                                let base_add_reg =
                                    self.registers[get_register_index(reg3base.clone())].clone();

                                let res = self.store_vector(reg1, base_add_reg.clone());
                                match res {
                                    Err(e) => return Err(e.to_string()),
                                    _ => (),
                                }
                                let res = self.store_vector(reg2, base_add_reg.clone());
                                match res {
                                    Err(e) => return Err(e.to_string()),
                                    _ => (),
                                }
                            }
                        } else {
                            let reg2base = get_register_name_string(reg2.clone());
                            let base_add_reg =
                                self.registers[get_register_index(reg2base.clone())].clone();

                            let res = self.store_vector(reg1, base_add_reg.clone());
                            match res {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }
                        }
                    }
                    "movi" => {
                        let reg1 = instruction.r1.clone().expect("Need first register name");
                        let reg2 = instruction.r2.clone().expect("Need immediate");
                        let imm = self.operand(reg2);
                        self.set_register(reg1, RegisterKind::Immediate, None, imm.offset);
                    }
                    "mov" => {
                        let reg1 = instruction.r1.clone().expect("Need dst reg");
                        let reg2 = instruction.r2.clone().expect("Need src reg");
                        let src = self.operand(reg2);
                        self.set_register(reg1, src.kind, src.base, src.offset);
                    }
                    "fmov" => {
                        let reg1 = instruction.r1.clone().expect("Need dst reg");
                        let reg2 = instruction.r2.clone().expect("Need src reg");
                        let src = self.operand(reg2);
                        self.set_register(reg1, src.kind, src.base, src.offset);
                    }
                    "shl" => {
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let reg2 = instruction.r2.clone().expect("Need source register");
                        let reg3 = instruction.r3.clone().expect("Need immediate");
                        let imm = self.operand(reg3);

                        if let Some((_, arrange)) = reg1.split_once(".") {
                            match arrange {
                                "2d" => {
                                    for i in 0..2 {
                                        let (bases, offsets) = self.simd_registers
                                            [get_register_index(reg2.clone())]
                                        .get_double(i);
                                        let mut offset = u64::from_be_bytes(offsets);
                                        (offset, _) = offset.overflowing_shl(
                                            imm.offset.try_into().expect("computer21"),
                                        );
                                        // TODO: figure out best way to modify bases
                                        let dest = &mut self.simd_registers
                                            [get_register_index(reg1.clone())];
                                        dest.set_double(i, bases, offset.to_be_bytes());
                                    }
                                }
                                _ => todo!("unsupported shl vector type"),
                            }
                        }
                    }
                    "ushr" | "sshr" => {
                        // FIX figure out how to do sshr over byte strings
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let reg2 = instruction.r2.clone().expect("Need source register");
                        let reg3 = instruction.r3.clone().expect("Need immediate");
                        let imm = self.operand(reg3);

                        if let Some((_, arrange)) = reg1.split_once(".") {
                            match arrange {
                                "2d" => {
                                    for i in 0..2 {
                                        let (bases, offsets) = self.simd_registers
                                            [get_register_index(reg2.clone())]
                                        .get_double(i);
                                        let mut offset = u64::from_be_bytes(offsets);
                                        (offset, _) = offset.overflowing_shr(
                                            imm.offset.try_into().expect("computer22"),
                                        );
                                        // TODO: figure out best way to modify bases
                                        let dest = &mut self.simd_registers
                                            [get_register_index(reg1.clone())];
                                        dest.set_double(i, bases, offset.to_be_bytes());
                                    }
                                }
                                "4s" => {
                                    for i in 0..4 {
                                        let (bases, offsets) = self.simd_registers
                                            [get_register_index(reg2.clone())]
                                        .get_word(i);
                                        let mut offset = u32::from_be_bytes(offsets);
                                        (offset, _) = offset.overflowing_shr(
                                            imm.offset.try_into().expect("computer23"),
                                        );
                                        // TODO: figure out best way to modify bases
                                        let dest = &mut self.simd_registers
                                            [get_register_index(reg1.clone())];
                                        dest.set_word(i, bases, offset.to_be_bytes());
                                    }
                                }
                                _ => todo!("unsupported ushr vector type"),
                            }
                        }
                    }
                    "ext" => {
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let reg2 = instruction.r2.clone().expect("Need source register");
                        let reg3 = instruction.r3.clone().expect("Need immediate");
                        let reg4 = instruction.r4.clone().expect("Need immediate");
                        let imm = self.operand(reg4);

                        if let Some((_, arrange)) = reg1.split_once(".") {
                            match arrange {
                                "8b" => {
                                    let amt = imm.offset as usize;
                                    assert!(amt < 8);
                                    for i in 0..amt {
                                        let (base, offset) = self.simd_registers
                                            [get_register_index(reg2.clone())]
                                        .get_byte(i);
                                        let dest = &mut self.simd_registers
                                            [get_register_index(reg1.clone())];
                                        dest.set_byte(i, base.clone(), offset);
                                    }
                                    for i in amt..8 {
                                        let (base, offset) = self.simd_registers
                                            [get_register_index(reg3.clone())]
                                        .get_byte(i);
                                        let dest = &mut self.simd_registers
                                            [get_register_index(reg1.clone())];
                                        dest.set_byte(i, base.clone(), offset);
                                    }
                                }
                                "16b" => {
                                    let amt = imm.offset as usize;
                                    assert!(amt < 16);
                                    for i in 0..amt {
                                        let (base, offset) = self.simd_registers
                                            [get_register_index(reg2.clone())]
                                        .get_byte(i);
                                        let dest = &mut self.simd_registers
                                            [get_register_index(reg1.clone())];
                                        dest.set_byte(i, base.clone(), offset);
                                    }
                                    for i in amt..16 {
                                        let (base, offset) = self.simd_registers
                                            [get_register_index(reg3.clone())]
                                        .get_byte(i);
                                        let dest = &mut self.simd_registers
                                            [get_register_index(reg1.clone())];
                                        dest.set_byte(i, base.clone(), offset);
                                    }
                                }
                                _ => todo!("unsupported ext vector type"),
                            }
                        }
                    }
                    "dup" => {
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let mut reg2 = instruction.r2.clone().expect("Need source register");
                        if reg2.contains("[") {
                            let left_brac = reg2.find("[").expect("need left bracket");
                            let right_brac = reg2.find("]").expect("need right bracket");
                            let index_string = reg2
                                .get((left_brac + 1)..right_brac)
                                .expect("need brackets");
                            let index = index_string
                                .parse::<usize>()
                                .expect("index into vector must be an integer");

                            reg2 = reg2.split_at(left_brac).0.to_string();
                            if let Some((vector1, arrangement1)) = reg1.split_once(".") {
                                if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                                    assert!(arrangement1.contains(arrangement2));
                                    let src = self.simd_registers
                                        [get_register_index(vector2.to_string())]
                                    .clone();
                                    let dest = &mut self.simd_registers
                                        [get_register_index(vector1.to_string())];

                                    match arrangement2 {
                                        "b" => {
                                            let elem = src.get_byte(index);
                                            for i in 0..16 {
                                                dest.set_byte(i, elem.0.clone(), elem.1);
                                            }
                                        }
                                        "h" => {
                                            let elem = src.get_halfword(index);
                                            for i in 0..8 {
                                                dest.set_halfword(i, elem.0.clone(), elem.1);
                                            }
                                        }
                                        "s" => {
                                            let elem = src.get_word(index);
                                            for i in 0..4 {
                                                dest.set_word(i, elem.0.clone(), elem.1);
                                            }
                                        }
                                        "d" => {
                                            let elem = src.get_double(index);
                                            for i in 0..2 {
                                                dest.set_double(i, elem.0.clone(), elem.1);
                                            }
                                        }
                                        _ => log::error!(
                                            "Not a valid vector arrangement {:?}",
                                            arrangement1
                                        ),
                                    }
                                }
                            };
                        } else {
                            if let Some((vector1, arrangement1)) = reg1.split_once(".") {
                                let dest = &mut self.simd_registers
                                    [get_register_index(vector1.to_string())];
                                let src = &mut self.registers[get_register_index(reg2)];

                                dest.set_register(
                                    arrangement1.to_string(),
                                    src.kind.clone(),
                                    src.base.clone(),
                                    src.offset as u128,
                                );
                            };
                        }
                    }
                    "and" => {
                        self.vector_arithmetic(
                            "&",
                            &|x, y| x & y,
                            &|x, y| x & y,
                            &|x, y| x & y,
                            &|x, y| x & y,
                            instruction,
                        );
                    }
                    "add" => {
                        self.vector_arithmetic(
                            "+",
                            &|x, y| x + y,
                            &|x, y| x + y,
                            &|x, y| x + y,
                            &|x, y| x + y,
                            instruction,
                        );
                    }
                    "orr" => {
                        self.vector_arithmetic(
                            "|",
                            &|x, y| x | y,
                            &|x, y| x | y,
                            &|x, y| x | y,
                            &|x, y| x | y,
                            instruction,
                        );
                    }
                    "eor" => {
                        self.vector_arithmetic(
                            "^",
                            &|x, y| x ^ y,
                            &|x, y| x ^ y,
                            &|x, y| x ^ y,
                            &|x, y| x ^ y,
                            instruction,
                        );
                    }
                    "mul" => {
                        self.vector_arithmetic(
                            "*",
                            &|x, y| x * y,
                            &|x, y| x * y,
                            &|x, y| x * y,
                            &|x, y| x * y,
                            instruction,
                        );
                    }
                    "sub" => {
                        self.vector_arithmetic(
                            "-",
                            &|x, y| x - y,
                            &|x, y| x - y,
                            &|x, y| x - y,
                            &|x, y| x - y,
                            instruction,
                        );
                    }
                    "rev64" => {
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let reg2 = instruction.r2.clone().expect("Need source register");

                        let src = &self.simd_registers[get_register_index(reg2.clone())].clone();
                        let dest = &mut self.simd_registers[get_register_index(reg1.clone())];

                        dest.kind = src.kind.clone();
                        for i in 0..16 {
                            let (base, offset) = src.get_byte(15 - i);
                            dest.set_byte(i, base, offset);
                        }
                    }
                    "rev32" => {
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let reg2 = instruction.r2.clone().expect("Need source register");

                        let src = &self.simd_registers[get_register_index(reg2.clone())].clone();
                        let dest = &mut self.simd_registers[get_register_index(reg1.clone())];

                        dest.kind = src.kind.clone();
                        for i in 0..8 {
                            let (base, offset) = src.get_byte(7 - i);
                            dest.set_byte(i, base, offset);
                        }

                        for i in 8..16 {
                            let (base, offset) = src.get_byte(15 - i);
                            dest.set_byte(i, base, offset);
                        }
                    }
                    "ins" => {
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let mut reg2 = instruction.r2.clone().expect("Need source register");

                        // vector, element
                        if reg2.contains("v") {
                            let left_brac = reg2.find("[").expect("need left bracket");
                            let right_brac = reg2.find("]").expect("need right bracket");
                            let index_string = reg2
                                .get((left_brac + 1)..right_brac)
                                .expect("need brackets");
                            let index = index_string
                                .parse::<usize>()
                                .expect("index into vector must be an integer");

                            reg2 = reg2.split_at(left_brac).0.to_string();
                            if let Some((vector1, arrangement1)) = reg1.split_once(".") {
                                if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                                    assert!(arrangement1.contains(arrangement2));
                                    let src = self.simd_registers
                                        [get_register_index(vector2.to_string())]
                                    .clone();
                                    let dest = &mut self.simd_registers
                                        [get_register_index(vector1.to_string())];

                                    match arrangement2 {
                                        "b" => {
                                            let (base, offset) = src.get_byte(index);
                                            dest.set_byte(index, base, offset);
                                        }
                                        "h" => {
                                            let (base, offset) = src.get_halfword(index);
                                            dest.set_halfword(index, base, offset);
                                        }
                                        "s" => {
                                            let (base, offset) = src.get_word(index);
                                            dest.set_word(index, base, offset);
                                        }
                                        "d" => {
                                            let (base, offset) = src.get_double(index);
                                            dest.set_double(index, base, offset);
                                        }
                                        _ => log::error!(
                                            "Not a valid vector arrangement {:?}",
                                            arrangement1
                                        ),
                                    }
                                }
                            }
                        // vector, general
                        } else {
                            todo!("vector general ins unsupported");
                        }
                    }
                    "pmull" | "pmull2" => {
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let reg2 = instruction.r2.clone().expect("Need first source register");
                        let reg3 = instruction.r3.clone().expect("Need second source register");

                        if let Some((vector1, _)) = reg1.split_once(".") {
                            if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                                if let Some((vector3, arrangement3)) = reg3.split_once(".") {
                                    assert_eq!(arrangement2, arrangement3);

                                    let src1 = self.simd_registers
                                        [get_register_index(vector2.to_string())]
                                    .clone();
                                    let src2 = self.simd_registers
                                        [get_register_index(vector3.to_string())]
                                    .clone();
                                    let dest = &mut self.simd_registers
                                        [get_register_index(vector1.to_string())];

                                    match arrangement2 {
                                        "8b" => {
                                            for i in 0..8 {
                                                let base = generate_expression_from_options(
                                                    "*",
                                                    src1.get_byte(i).0,
                                                    src2.get_byte(i).0,
                                                );
                                                let offset =
                                                    src1.get_byte(i).1 * src2.get_byte(i).1;

                                                dest.set_byte(i, base, offset);
                                            }
                                        }
                                        "4h" => {
                                            for i in 0..8 {
                                                let (bases1, offsets1) = self.simd_registers
                                                    [get_register_index(reg2.clone())]
                                                .get_halfword(i);

                                                let (bases2, offsets2) = self.simd_registers
                                                    [get_register_index(reg3.clone())]
                                                .get_halfword(i);
                                                let a = u16::from_be_bytes(offsets1);
                                                let b = u16::from_be_bytes(offsets2);
                                                let offset = a * b;

                                                let mut new_bases = [BASE_INIT; 2];
                                                for i in 0..2 {
                                                    new_bases[i] = generate_expression_from_options(
                                                        "*",
                                                        bases1[i].clone(),
                                                        bases2[i].clone(),
                                                    );
                                                }

                                                let dest = &mut self.simd_registers
                                                    [get_register_index(reg1.clone())];
                                                dest.set_halfword(
                                                    i,
                                                    new_bases,
                                                    offset.to_be_bytes(),
                                                );
                                            }
                                        }
                                        _ => todo!("pmull unsupported vector access"),
                                    }
                                }
                            }
                        }
                    }
                    "zip1" => {
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let reg2 = instruction.r2.clone().expect("Need first source register");
                        let reg3 = instruction.r3.clone().expect("Need second source register");

                        if let Some((vector1, _)) = reg1.split_once(".") {
                            if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                                if let Some((vector3, arrangement3)) = reg3.split_once(".") {
                                    assert_eq!(arrangement2, arrangement3);

                                    let src1 = self.simd_registers
                                        [get_register_index(vector2.to_string())]
                                    .clone();
                                    let src2 = self.simd_registers
                                        [get_register_index(vector3.to_string())]
                                    .clone();
                                    let dest = &mut self.simd_registers
                                        [get_register_index(vector1.to_string())];

                                    match arrangement2 {
                                        "2d" => {
                                            let elem = src1.get_double(0);
                                            dest.set_double(0, elem.0, elem.1);

                                            let elem = src2.get_double(0);
                                            dest.set_double(1, elem.0, elem.1);
                                        }
                                        "16b" => {
                                            for i in 0..16 {
                                                if i % 2 == 0 {
                                                    let elem = src1.get_byte(0);
                                                    dest.set_byte(i, elem.0, elem.1);
                                                } else {
                                                    let elem = src2.get_byte(0);
                                                    dest.set_byte(i, elem.0, elem.1);
                                                }
                                            }
                                        }
                                        _ => todo!("zip1 unsupported vector access"),
                                    }
                                }
                            }
                        }
                    }
                    "zip2" => {
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let reg2 = instruction.r2.clone().expect("Need first source register");
                        let reg3 = instruction.r3.clone().expect("Need second source register");

                        if let Some((vector1, _)) = reg1.split_once(".") {
                            if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                                if let Some((vector3, arrangement3)) = reg3.split_once(".") {
                                    assert_eq!(arrangement2, arrangement3);

                                    let src1 = self.simd_registers
                                        [get_register_index(vector2.to_string())]
                                    .clone();
                                    let src2 = self.simd_registers
                                        [get_register_index(vector3.to_string())]
                                    .clone();
                                    let dest = &mut self.simd_registers
                                        [get_register_index(vector1.to_string())];

                                    match arrangement2 {
                                        "2d" => {
                                            let elem = src1.get_double(1);
                                            dest.set_double(0, elem.0, elem.1);

                                            let elem = src2.get_double(1);
                                            dest.set_double(1, elem.0, elem.1);
                                        }
                                        "16b" => {
                                            //FIX
                                            for i in 0..16 {
                                                if i % 2 == 1 {
                                                    let elem = src1.get_byte(0);
                                                    dest.set_byte(i, elem.0, elem.1);
                                                } else {
                                                    let elem = src2.get_byte(0);
                                                    dest.set_byte(i, elem.0, elem.1);
                                                }
                                            }
                                        }
                                        _ => todo!("zip2 unsupported vector access"),
                                    }
                                }
                            }
                        }
                    }
                    "aese" | "aesmc" => {
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let reg2 = instruction.r2.clone().expect("Need first source register");

                        let src = &self.simd_registers[get_register_index(reg2.clone())].clone();
                        let dest = &mut self.simd_registers[get_register_index(reg1.clone())];

                        match (src.kind.clone(), dest.kind.clone()) {
                            (RegisterKind::Number, RegisterKind::Number) => {
                                // don't need to do anything
                                ()
                            }
                            _ => todo!(),
                        }
                    }
                    "trn1" => {
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let reg2 = instruction.r2.clone().expect("Need first source register");
                        let reg3 = instruction.r3.clone().expect("Need second source register");

                        if let Some((vector1, _)) = reg1.split_once(".") {
                            if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                                if let Some((vector3, arrangement3)) = reg3.split_once(".") {
                                    assert_eq!(arrangement2, arrangement3);

                                    let src1 = self.simd_registers
                                        [get_register_index(vector2.to_string())]
                                    .clone();
                                    let src2 = self.simd_registers
                                        [get_register_index(vector3.to_string())]
                                    .clone();
                                    let dest = &mut self.simd_registers
                                        [get_register_index(vector1.to_string())];

                                    match arrangement2 {
                                        "2d" => {
                                            let elem = src1.get_double(0);
                                            dest.set_double(0, elem.0, elem.1);

                                            let elem = src2.get_double(0);
                                            dest.set_double(1, elem.0, elem.1);
                                        }
                                        _ => todo!("trn1 unsupported vector access"),
                                    }
                                }
                            }
                        }
                    }
                    "trn2" => {
                        let reg1 = instruction.r1.clone().expect("Need dst register");
                        let reg2 = instruction.r2.clone().expect("Need first source register");
                        let reg3 = instruction.r3.clone().expect("Need second source register");

                        if let Some((vector1, _)) = reg1.split_once(".") {
                            if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                                if let Some((vector3, arrangement3)) = reg3.split_once(".") {
                                    assert_eq!(arrangement2, arrangement3);

                                    let src1 = self.simd_registers
                                        [get_register_index(vector2.to_string())]
                                    .clone();
                                    let src2 = self.simd_registers
                                        [get_register_index(vector3.to_string())]
                                    .clone();
                                    let dest = &mut self.simd_registers
                                        [get_register_index(vector1.to_string())];

                                    match arrangement2 {
                                        "2d" => {
                                            let elem = src1.get_double(1);
                                            dest.set_double(0, elem.0, elem.1);

                                            let elem = src2.get_double(1);
                                            dest.set_double(1, elem.0, elem.1);
                                        }
                                        _ => todo!("trn2 unsupported vector access"),
                                    }
                                }
                            }
                        }
                    }
                    "ld1r" => {
                        let dst = instruction.r1.clone().expect("need dst ld1r");
                        let src = instruction.r2.clone().expect("need src ld1r");

                        let address = self.registers[get_register_index(src.clone())].clone();
                        let _ = self.load(dst, address);
                    }
                    "bit" | "uaddl" | "uaddl2" | "sqrshrun" | "sqrshrun2" | "umull" | "umull2"
                    | "umlal" | "umlal2" | "rshrn" | "rshrn2" => {
                        let dest = instruction.r1.clone().expect("need dest");
                        let reg = &mut self.simd_registers[get_register_index(dest.to_string())];
                        reg.set(
                            "16b".to_string(),
                            RegisterKind::Number,
                            [BASE_INIT; 16],
                            [0; 16],
                        );
                    }
                    _ => {
                        log::warn!("SIMD instruction not supported {:?}", instruction);
                        todo!("unsupported vector operation {:?}", instruction);
                    }
                }
            }
        }
        Ok(ExecuteReturnType::Next)
    }

    fn arithmetic(
        &mut self,
        op_string: &str,
        op: impl Fn(i64, i64) -> i64,
        reg0: String,
        reg1: String,
        reg2: String,
        reg3: Option<String>,
    ) {
        let r1 = self.operand(reg1.clone());
        let mut r2 = self.operand(reg2.clone());

        if reg3.is_some() {
            if let Some(expr) = reg3 {
                if expr.starts_with('u') | expr.starts_with('s') {
                    // TODO: zero extend?
                } else {
                    // FIX: account for possibility of space between # and number
                    let parts = expr
                        .split_once('#')
                        .expect(&format!("computer24 {:?}", expr).to_string());
                    r2 = shift_imm(parts.0.to_string(), r2.clone(), string_to_int(parts.1));
                }
            }
        }

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    let base = match r1.clone().base {
                        Some(reg1base) => match r2.clone().base {
                            Some(reg2base) => {
                                let concat = generate_expression(op_string, reg1base, reg2base);
                                Some(concat)
                            }
                            None => Some(reg1base),
                        },
                        None => match r2.clone().base {
                            Some(reg2base) => Some(reg2base),
                            None => None,
                        },
                    };
                    self.set_register(
                        reg0,
                        RegisterKind::RegisterBase,
                        base,
                        op(r1.offset, r2.offset),
                    )
                }
                RegisterKind::Number => {
                    // abstract numbers, value doesn't matter
                    self.set_register(reg0, RegisterKind::Number, None, 0)
                }
                RegisterKind::Immediate => self.set_register(
                    reg0,
                    RegisterKind::Immediate,
                    None,
                    op(r1.offset, r2.offset),
                ),
            }
        } else if r1.kind == RegisterKind::Immediate {
            self.set_register(
                reg0,
                r2.kind.clone(),
                r2.base.clone(),
                op(r1.offset, r2.offset),
            );
        } else if r2.kind == RegisterKind::Immediate {
            self.set_register(
                reg0,
                r1.kind.clone(),
                r1.base.clone(),
                op(r1.offset, r2.offset),
            );
        } else if r1.kind == RegisterKind::Number || r2.kind == RegisterKind::Number {
            // abstract numbers, value doesn't matter
            self.set_register(reg0, RegisterKind::Number, None, 0)
        } else if r1.kind == RegisterKind::RegisterBase || r2.kind == RegisterKind::RegisterBase {
            let base = match r2.clone().base {
                Some(reg1base) => match r1.clone().base {
                    Some(reg2base) => {
                        let concat = generate_expression(op_string, reg1base, reg2base);
                        Some(concat)
                    }
                    None => Some(reg1base),
                },
                None => match r1.clone().base {
                    Some(reg2base) => Some(reg2base),
                    None => None,
                },
            };
            self.set_register(
                reg0,
                RegisterKind::RegisterBase,
                base,
                op(r1.offset, r2.offset),
            )
        } else {
            // println!("op: {:?}, r1: {:?}, r2:{:?}", op_string, r1, r2 );
            log::error!("Cannot perform arithmetic on these two registers")
        }
    }

    fn vector_arithmetic(
        &mut self,
        op_string: &str,
        op_byte: impl Fn(u8, u8) -> u8,
        op_half: impl Fn(u16, u16) -> u16,
        op_word: impl Fn(u32, u32) -> u32,
        op_double: impl Fn(u64, u64) -> u64,
        instruction: &Instruction,
    ) {
        let reg1 = instruction.r1.clone().expect("Need dst register");
        let reg2 = instruction.r2.clone().expect("Need source register");
        let reg3 = instruction.r3.clone().expect("Need immediate");

        if let Some((_, arrange)) = reg1.split_once(".") {
            match arrange {
                "2d" => {
                    for i in 0..2 {
                        let (bases1, offsets1) =
                            self.simd_registers[get_register_index(reg2.clone())].get_double(i);

                        let (bases2, offsets2) =
                            self.simd_registers[get_register_index(reg3.clone())].get_double(i);

                        let a = u64::from_be_bytes(offsets1);
                        let b = u64::from_be_bytes(offsets2);
                        let offset = op_double(a, b);

                        let mut new_bases = [BASE_INIT; 8];
                        for i in 0..8 {
                            if bases1[i].is_some() && bases2[i].is_some() {
                                new_bases[i] = generate_expression_from_options(
                                    op_string,
                                    bases1[i].clone(),
                                    bases2[i].clone(),
                                );
                            }
                        }

                        let dest = &mut self.simd_registers[get_register_index(reg1.clone())];
                        dest.set_double(i, new_bases, offset.to_be_bytes());
                    }
                }
                "4s" => {
                    for i in 0..4 {
                        let (bases1, offsets1) =
                            self.simd_registers[get_register_index(reg2.clone())].get_word(i);

                        let (bases2, offsets2) =
                            self.simd_registers[get_register_index(reg3.clone())].get_word(i);
                        let a = u32::from_be_bytes(offsets1);
                        let b = u32::from_be_bytes(offsets2);
                        let offset = op_word(a, b);

                        let mut new_bases = [BASE_INIT; 4];
                        for i in 0..4 {
                            new_bases[i] = generate_expression_from_options(
                                op_string,
                                bases1[i].clone(),
                                bases2[i].clone(),
                            );
                        }

                        let dest = &mut self.simd_registers[get_register_index(reg1.clone())];
                        dest.set_word(i, new_bases, offset.to_be_bytes());
                    }
                }
                "4h" => {
                    for i in 0..4 {
                        let (bases1, offsets1) =
                            self.simd_registers[get_register_index(reg2.clone())].get_halfword(i);

                        let (bases2, offsets2) =
                            self.simd_registers[get_register_index(reg3.clone())].get_halfword(i);
                        let a = u16::from_be_bytes(offsets1);
                        let b = u16::from_be_bytes(offsets2);
                        let offset = op_half(a, b);

                        let mut new_bases = [BASE_INIT; 2];
                        for i in 0..4 {
                            new_bases[i] = generate_expression_from_options(
                                op_string,
                                bases1[i].clone(),
                                bases2[i].clone(),
                            );
                        }

                        let dest = &mut self.simd_registers[get_register_index(reg1.clone())];
                        dest.set_halfword(i, new_bases, offset.to_be_bytes());
                    }
                }
                "8h" => {
                    for i in 0..8 {
                        let (bases1, offsets1) =
                            self.simd_registers[get_register_index(reg2.clone())].get_halfword(i);

                        let (bases2, offsets2) =
                            self.simd_registers[get_register_index(reg3.clone())].get_halfword(i);
                        let a = u16::from_be_bytes(offsets1);
                        let b = u16::from_be_bytes(offsets2);
                        let offset = op_half(a, b);

                        let mut new_bases = [BASE_INIT; 2];
                        for i in 0..2 {
                            new_bases[i] = generate_expression_from_options(
                                op_string,
                                bases1[i].clone(),
                                bases2[i].clone(),
                            );
                        }

                        let dest = &mut self.simd_registers[get_register_index(reg1.clone())];
                        dest.set_halfword(i, new_bases, offset.to_be_bytes());
                    }
                }
                "8b" => {
                    for i in 0..8 {
                        let (bases1, a) =
                            self.simd_registers[get_register_index(reg2.clone())].get_byte(i);

                        let (bases2, b) =
                            self.simd_registers[get_register_index(reg3.clone())].get_byte(i);

                        let offset = op_byte(a, b);

                        let new_base = generate_expression_from_options(
                            op_string,
                            bases1.clone(),
                            bases2.clone(),
                        );

                        let dest = &mut self.simd_registers[get_register_index(reg1.clone())];
                        dest.set_byte(i, new_base, offset);
                    }
                }
                "16b" => {
                    for i in 0..16 {
                        let (bases1, a) =
                            self.simd_registers[get_register_index(reg2.clone())].get_byte(i);

                        let (bases2, b) =
                            self.simd_registers[get_register_index(reg3.clone())].get_byte(i);

                        let offset = op_byte(a, b);

                        let new_base = generate_expression_from_options(
                            op_string,
                            bases1.clone(),
                            bases2.clone(),
                        );

                        let dest = &mut self.simd_registers[get_register_index(reg1.clone())];
                        dest.set_byte(i, new_base, offset);
                    }
                }
                _ => todo!("unsupported vector arithmetic access"),
            }
        }
    }

    fn shift_reg(&mut self, reg1: String, reg2: String, reg3: String) {
        let r2 = self.registers[get_register_index(reg2)].clone();

        let shift = self.operand(reg3).offset;
        let new_offset = r2.offset >> (shift);
        self.set_register(
            reg1,
            r2.clone().kind,
            Some(generate_expression(
                "ror",
                r2.base.unwrap_or(AbstractExpression::Empty),
                AbstractExpression::Immediate(new_offset),
            )),
            new_offset,
        );
    }

    fn cmp(&mut self, reg1: String, reg2: String) {
        let r1 = self.operand(reg1.clone()).clone();
        let r2 = self.operand(reg2.clone()).clone();

        if r1 == r2 {
            self.neg = Some(FlagValue::Real(false));
            self.zero = Some(FlagValue::Real(true));
            self.carry = Some(FlagValue::Real(false));
            self.overflow = Some(FlagValue::Real(false));
            return;
        }

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    if r1.base.eq(&r2.base) {
                        self.neg = if r1.offset < r2.offset {
                            Some(FlagValue::Real(true))
                        } else {
                            Some(FlagValue::Real(false))
                        };
                        self.zero = if r1.offset == r2.offset {
                            Some(FlagValue::Real(true))
                        } else {
                            Some(FlagValue::Real(false))
                        };
                        // signed vs signed distinction, maybe make offset generic to handle both?
                        self.carry = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                            Some(FlagValue::Real(true))
                        } else {
                            Some(FlagValue::Real(false))
                        };
                        self.overflow = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                            Some(FlagValue::Real(true))
                        } else {
                            Some(FlagValue::Real(false))
                        };
                    } else {
                        let expression = AbstractExpression::Expression(
                            "-".to_string(),
                            Box::new(AbstractExpression::Register(Box::new(r1))),
                            Box::new(AbstractExpression::Register(Box::new(r2))),
                        );
                        self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
                            "<",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                            "==",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        // FIX carry + overflow
                        self.carry = Some(FlagValue::Abstract(AbstractComparison::new(
                            "<",
                            expression.clone(),
                            AbstractExpression::Immediate(std::i64::MIN),
                        )));
                        self.overflow = Some(FlagValue::Abstract(AbstractComparison::new(
                            "<",
                            expression,
                            AbstractExpression::Immediate(std::i64::MIN),
                        )));
                    }
                }
                RegisterKind::Number => {
                    log::error!("Cannot compare these two registers")
                }
                RegisterKind::Immediate => {
                    self.neg = if r1.offset < r2.offset {
                        Some(FlagValue::Real(true))
                    } else {
                        Some(FlagValue::Real(false))
                    };
                    self.zero = if r1.offset == r2.offset {
                        Some(FlagValue::Real(true))
                    } else {
                        Some(FlagValue::Real(false))
                    };
                    // signed vs signed distinction, maybe make offset generic to handle both?
                    self.carry = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                        Some(FlagValue::Real(true))
                    } else {
                        Some(FlagValue::Real(false))
                    };
                    self.overflow = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                        Some(FlagValue::Real(true))
                    } else {
                        Some(FlagValue::Real(false))
                    };
                }
            }
        } else if r1.kind == RegisterKind::RegisterBase || r2.kind == RegisterKind::RegisterBase {
            let expression = AbstractExpression::Expression(
                "-".to_string(),
                Box::new(AbstractExpression::Register(Box::new(r1))),
                Box::new(AbstractExpression::Register(Box::new(r2))),
            );
            self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
                "<",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                "==",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            // FIX carry + overflow
            self.carry = Some(FlagValue::Abstract(AbstractComparison::new(
                "<",
                expression.clone(),
                AbstractExpression::Immediate(std::i64::MIN),
            )));
            self.overflow = Some(FlagValue::Abstract(AbstractComparison::new(
                "<",
                expression,
                AbstractExpression::Immediate(std::i64::MIN),
            )));
        }
    }

    fn cmn(&mut self, reg1: String, reg2: String) {
        let r1 = self.operand(reg1.clone()).clone();
        let r2 = self.operand(reg2.clone()).clone();

        if r1 == r2 {
            self.neg = Some(FlagValue::Real(false));
            self.zero = Some(FlagValue::Real(true));
            self.carry = Some(FlagValue::Real(false));
            self.overflow = Some(FlagValue::Real(false));

            return;
        }

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    if r1.base.eq(&r2.base) {
                        self.neg = if r1.offset + r2.offset < 0 {
                            Some(FlagValue::Real(true))
                        } else {
                            Some(FlagValue::Real(false))
                        };
                        self.zero = if r1.offset + r2.offset == 0 {
                            Some(FlagValue::Real(true))
                        } else {
                            Some(FlagValue::Real(false))
                        };
                        self.carry = if r2.offset + r1.offset > std::i64::MAX {
                            Some(FlagValue::Real(true))
                        } else {
                            Some(FlagValue::Real(false))
                        };
                        self.overflow = if r2.offset + r1.offset > std::i64::MAX {
                            Some(FlagValue::Real(true))
                        } else {
                            Some(FlagValue::Real(false))
                        };
                    } else {
                        let expression = AbstractExpression::Expression(
                            "+".to_string(),
                            Box::new(AbstractExpression::Register(Box::new(r1))),
                            Box::new(AbstractExpression::Register(Box::new(r2))),
                        );
                        self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
                            "<",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                            "==",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        // FIX carry + overflow
                        self.carry = Some(FlagValue::Abstract(AbstractComparison::new(
                            ">",
                            expression.clone(),
                            AbstractExpression::Immediate(std::i64::MAX),
                        )));
                        self.overflow = Some(FlagValue::Abstract(AbstractComparison::new(
                            ">",
                            expression,
                            AbstractExpression::Immediate(std::i64::MAX),
                        )));
                    }
                }
                RegisterKind::Number => {
                    log::error!("Cannot compare these two registers")
                }
                RegisterKind::Immediate => {
                    self.neg = if r1.offset + r2.offset < 0 {
                        Some(FlagValue::Real(true))
                    } else {
                        Some(FlagValue::Real(false))
                    };
                    self.zero = if r1.offset + r2.offset == 0 {
                        Some(FlagValue::Real(true))
                    } else {
                        Some(FlagValue::Real(false))
                    };
                    // signed vs signed distinction, maybe make offset generic to handle both?
                    self.carry = if r2.offset + r1.offset > std::i64::MAX {
                        Some(FlagValue::Real(true))
                    } else {
                        Some(FlagValue::Real(false))
                    };
                    self.overflow = if r2.offset + r1.offset > std::i64::MAX {
                        Some(FlagValue::Real(true))
                    } else {
                        Some(FlagValue::Real(false))
                    };
                }
            }
        } else if r1.kind == RegisterKind::RegisterBase || r2.kind == RegisterKind::RegisterBase {
            let expression = AbstractExpression::Expression(
                "+".to_string(),
                Box::new(AbstractExpression::Register(Box::new(r1))),
                Box::new(AbstractExpression::Register(Box::new(r2))),
            );
            self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
                "<",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                "==",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            // FIX carry + overflow
            self.carry = Some(FlagValue::Abstract(AbstractComparison::new(
                ">",
                expression.clone(),
                AbstractExpression::Immediate(std::i64::MAX),
            )));
            self.overflow = Some(FlagValue::Abstract(AbstractComparison::new(
                ">",
                expression,
                AbstractExpression::Immediate(std::i64::MAX),
            )));
        }
    }

    /*
     * t: register name to load into
     * address: register with address as value
     */
    fn load(&mut self, t: String, address: RegisterValue) -> Result<(), MemorySafetyError> {
        let res = self.mem_safe_access(
            address.base.clone().expect("Need a name for region"),
            address.offset,
            RegionType::READ,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = address.base {
                let (region_name, offset) = self.get_memory_pointer(base.clone(), address.offset);
                let region = self
                    .memory
                    .get(&region_name)
                    .expect(format!("Need memory region to load from {:?}", region_name).as_str());
                match region.get(offset) {
                    Some(v) => {
                        self.set_register(t, v.kind.clone(), v.base.clone(), v.offset);
                        self.rw_queue.push(MemoryAccess {
                            kind: RegionType::READ,
                            base: base.clone(),
                            offset: address.offset,
                        });
                        log::info!(
                            "Load from address {:?} + {}",
                            base.clone(),
                            address.offset.clone()
                        );
                        return Ok(());
                    }
                    None => {
                        log::error!("No element at this address in region {:?}", region);
                        return Err(MemorySafetyError::new(
                            "Cannot read element at this address from region",
                        ));
                    }
                }
            } else {
                log::info!(
                    "Loading from an abstract but safe region of memory {:?}",
                    address
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::READ,
                    base: address.base.expect("Need base").to_string(),
                    offset: address.offset,
                });
                self.set_register(t, RegisterKind::Number, None, 0);
                Ok(())
            }
        } else {
            return res;
        }
    }

    fn load_vector(&mut self, t: String, address: RegisterValue) -> Result<(), MemorySafetyError> {
        let res = self.mem_safe_access(
            address.base.clone().expect("Need a name for region"),
            address.offset,
            RegionType::READ,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = address.base {
                let (region_name, offset) = self.get_memory_pointer(base.clone(), address.offset);
                let region = self
                    .memory
                    .get(&region_name)
                    .expect(format!("Need memory region to load from {:?}", region_name).as_str());
                match region.get(offset) {
                    Some(v) => {
                        self.set_register(t, v.kind.clone(), v.base, v.offset);
                        self.rw_queue.push(MemoryAccess {
                            kind: RegionType::READ,
                            base: base.clone(),
                            offset: address.offset,
                        });
                        log::info!(
                            "Load from address {:?} + {}",
                            base.clone(),
                            address.offset.clone()
                        );
                        return Ok(());
                    }
                    None => {
                        log::error!("No element at this address in region {:?}", region);
                        return Err(MemorySafetyError::new(
                            "Cannot read element at this address from region",
                        ));
                    }
                }
            } else {
                log::info!(
                    "Loading from an abstract but safe region of memory {:?}",
                    address
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::READ,
                    base: address.base.expect("Need base").to_string(),
                    offset: address.offset,
                });
                self.set_register(t, RegisterKind::Number, None, 0);
                Ok(())
            }
        } else {
            return res;
        }
    }

    /*
     * t: register to be stored
     * address: where to store it
     */
    fn store(&mut self, register: String, address: RegisterValue) -> Result<(), MemorySafetyError> {
        let region = address.base.clone();
        let res = self.mem_safe_access(
            region.clone().expect("Need region base"),
            address.offset,
            RegionType::WRITE,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = region.clone() {
                let (region, offset) = self.get_memory_pointer(base.clone(), address.offset);

                let region = self.memory.get_mut(&region).expect("No region");
                let register = &self.registers[get_register_index(register)];
                region.insert(offset.clone(), register.clone());

                log::info!(
                    "Store to address {:?} + {}",
                    base.clone(),
                    address.offset.clone()
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base,
                    offset: address.offset,
                });
                return Ok(());
            } else {
                log::info!(
                    "Storing from an abstract but safe region of memory {:?}",
                    address
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base: address.base.expect("Need base").to_string(),
                    offset: address.offset,
                });
                Ok(())
            }
        } else {
            return res;
        }
    }

    fn store_vector(
        &mut self,
        register: String,
        address: RegisterValue,
    ) -> Result<(), MemorySafetyError> {
        let region = address.base.clone();
        let res = self.mem_safe_access(
            region.clone().expect("Need region base"),
            address.offset,
            RegionType::WRITE,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = region.clone() {
                let (region, offset) = self.get_memory_pointer(base.clone(), address.offset);

                let region = self.memory.get_mut(&region).expect("No region");
                let register = &self.registers[get_register_index(register)];
                region.insert(offset.clone(), register.clone());

                log::info!(
                    "Store to address {:?} + {}",
                    base.clone(),
                    address.offset.clone()
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base,
                    offset: address.offset,
                });
                return Ok(());
            } else {
                log::info!(
                    "Storing from an abstract but safe region of memory {:?}",
                    address
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base: address.base.expect("Need base").to_string(),
                    offset: address.offset,
                });
                Ok(())
            }
        } else {
            return res;
        }
    }

    fn get_memory_pointer(&self, base: String, offset: i64) -> (String, i64) {
        if let Some(_) = self.memory.get(&base) {
            return (base, offset);
        } else {
            if let Some(address) = self.memory_labels.get(&base) {
                return ("memory".to_string(), address + offset);
            } else {
                return ("memory".to_string(), offset);
            }
        }
    }

    // SAFETY CHECKS
    fn mem_safe_access(
        &self,
        base_expr: AbstractExpression,
        mut offset: i64,
        ty: RegionType,
    ) -> Result<(), MemorySafetyError> {
        let mut symbolic_base = false;
        let (region, base, base_access) = match base_expr.clone() {
            AbstractExpression::Abstract(regbase) => {
                if let Some(region) = self.memory.get(&regbase.clone()) {
                    (
                        region,
                        ast::Int::new_const(self.context, regbase.clone()),
                        ast::Int::new_const(self.context, regbase),
                    )
                } else {
                    if let Some(address) = self.memory_labels.get(&regbase.clone()) {
                        offset = offset + address;
                        (
                            self.memory
                                .get(&"memory".to_string())
                                .expect("memory should exist"),
                            ast::Int::new_const(self.context, regbase.clone()),
                            ast::Int::new_const(self.context, regbase),
                        )
                    } else {
                        println!("region: {:?}", base_expr);
                        todo!("memory regions in access check");
                    }
                }
            }
            _ => {
                symbolic_base = true;
                let abstracts = base_expr.get_abstracts();
                let mut result: Option<(&MemorySafeRegion, z3::ast::Int<'_>, z3::ast::Int<'_>)> =
                    None;
                for r in self.memory.keys() {
                    if abstracts.contains(r) {
                        result = Some((
                            self.memory.get(r).expect("Region not in memory 2"),
                            expression_to_ast(
                                self.context,
                                AbstractExpression::Abstract(r.to_string()),
                            )
                            .expect("computer25"),
                            expression_to_ast(self.context, base_expr.clone())
                                .expect("computer251"),
                        ));
                        break;
                    }
                    for r in self.memory_labels.clone() {
                        if abstracts.contains(&r.0) {
                            if let Some(address) = self.memory_labels.get(&r.0.clone()) {
                                offset = *address;
                                result = Some((
                                    self.memory.get("memory").expect("Region not in memory 2"),
                                    expression_to_ast(
                                        self.context,
                                        AbstractExpression::Abstract(r.0.to_string()),
                                    )
                                    .expect("computer25"),
                                    expression_to_ast(self.context, base_expr.clone())
                                        .expect("computer251"),
                                ));
                                break;
                            }
                        }
                    }
                }
                if let Some(res) = result {
                    res
                } else {
                    return Err(MemorySafetyError::new(
                        format!(
                            "No matching region found for access {:?}, {:?}",
                            base_expr, offset
                        )
                        .as_str(),
                    ));
                }
            }
        };

        if ty == RegionType::WRITE && region.kind == RegionType::READ {
            return Err(MemorySafetyError::new(&format!(
                "Access does not match region type {:#?} {:?} {:?}",
                region.kind, ty, base_expr
            )));
        }

        let mut abs_offset = ast::Int::from_i64(self.context, offset);
        if base_expr.contains("sp") {
            abs_offset = ast::Int::from_i64(self.context, offset.abs());
        }
        let access = ast::Int::add(self.context, &[&base_access, &abs_offset]);

        // let width = ast::Int::from_i64(self.context, 2);    // how wide is memory access, two bytes
        let lowerbound_value = ast::Int::from_i64(self.context, 0);
        let low_access = ast::Int::add(self.context, &[&base, &lowerbound_value]);
        let upperbound_value =
            expression_to_ast(self.context, region.get_length()).expect("computer26");
        let up_access = ast::Int::add(self.context, &[&base, &upperbound_value]);
        let l = access.lt(&low_access);
        let u = {
            if offset == 0 && !symbolic_base {
                access.ge(&up_access)
            } else {
                access.gt(&up_access)
            }
        };

        match (
            self.solver.check_assumptions(&[l.clone()]),
            self.solver.check_assumptions(&[u.clone()]),
        ) {
            (SatResult::Unsat, SatResult::Unsat) => {
                log::info!("Memory safe with solver's check!");
                log::info!("Unsat core {:?}", self.solver.get_unsat_core());
                return Ok(());
            }
            (a, b) => {
                log::info!("Load from address {:?} + {} unsafe", base_expr, offset);
                log::info!(
                    "impossibility lower bound {:?}, impossibility upper bound {:?}, model: {:?}",
                    a,
                    b,
                    self.solver.get_model()
                );
                log::info!("Memory unsafe with solver's check!");
            }
        }
        return Err(MemorySafetyError::new(
            format!(
                "Accessing address outside allowable memory regions {:?}, {:?}",
                base_expr, offset
            )
            .as_str(),
        ));
    }
}
