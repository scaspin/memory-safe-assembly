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
    let r0 = name.strip_prefix("x").unwrap_or(&name);
    let r1: usize = r0
        .strip_prefix("w")
        .unwrap_or(&r0)
        .parse::<usize>()
        .expect(format!("Invalid register value {:?}", reg_name).as_str());
    return r1;
}

#[derive(Clone)]
pub struct ARMCORTEXA<'ctx> {
    pub registers: [RegisterValue; 33],
    zero: Option<FlagValue>,
    neg: Option<FlagValue>,
    carry: Option<FlagValue>,
    overflow: Option<FlagValue>,
    memory: HashMap<String, MemorySafeRegion>,
    rw_queue: Vec<MemoryAccess>,
    pub alignment: i64,
    pub context: &'ctx Context,
    pub solver: Solver<'ctx>,
}

impl<'ctx> fmt::Debug for ARMCORTEXA<'ctx> {
    fn fmt(&self, _f: &mut fmt::Formatter<'_>) -> fmt::Result {
        println!("registers {:?}", &self.registers);
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
            zero: None,
            neg: None,
            carry: None,
            overflow: None,
            memory,
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
        Option<FlagValue>,
        Option<FlagValue>,
        Option<FlagValue>,
        Option<FlagValue>,
    ) {
        return (
            self.registers.clone(),
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

    fn set_register(
        &mut self,
        name: String,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        if name.contains("w") {
            self.registers[get_register_index(name.clone())].set(kind, base, (offset as i32) as i64)
        } else {
            self.registers[get_register_index(name.clone())].set(kind, base, offset as i64)
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
        } else if v.contains('[') && v.contains(',') && v.contains('#') {
            let a = v.split_once(',').unwrap();
            let reg = self.registers[get_register_index(a.0.trim_matches('[').to_string())].clone();
            return RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: reg.base,
                offset: reg.offset + string_to_int(a.1.trim_matches(']')),
            };
        } else if v.contains("@") {
            // TODO : expand functionality
            if v.contains("OFF") {
                return RegisterValue {
                    kind: RegisterKind::Immediate,
                    base: None,
                    offset: self.alignment,
                };
            } else {
                return RegisterValue {
                    kind: RegisterKind::RegisterBase,
                    base: None,
                    offset: 0,
                };
            }
        } else {
            //if v.contains("x") || v.contains("w"){
            return self.registers[get_register_index(v)].clone();
        }
    }

    pub fn execute(
        &mut self,
        instruction: &Instruction,
    ) -> Result<Option<(Option<AbstractComparison>, Option<String>, Option<u128>)>, String> {
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
            "eor" => {
                self.arithmetic(
                    &instruction.op,
                    &|x, y| x ^ y,
                    instruction.r1.clone().expect("Need dst register"),
                    instruction.r2.clone().expect("Need one operand"),
                    instruction.r3.clone().expect("Need two operand"),
                    instruction.r4.clone(),
                );
            }
            "bic" => {
                self.arithmetic(
                    &instruction.op,
                    &|x, y| x & !y,
                    instruction.r1.clone().expect("Need dst register"),
                    instruction.r2.clone().expect("Need one operand"),
                    instruction.r3.clone().expect("Need two operand"),
                    instruction.r4.clone(),
                );
            }
            "lsr" => {
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
            "adcs" => match self.carry.clone().expect("Need carry flag set") {
                FlagValue::REAL(b) => {
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
                FlagValue::ABSTRACT(_) => {
                    log::error!("Can't support this yet :)");
                    todo!();
                }
            },
            "sbcs" => match self.carry.clone().expect("Need carry flag set") {
                FlagValue::REAL(b) => {
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
                FlagValue::ABSTRACT(_) => {
                    log::error!("Can't support this yet :)");
                    todo!();
                }
            },
            "adrp" => {
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
                    || register.base.clone().unwrap() == AbstractExpression::Empty)
                    && register.offset == 0
                {
                    return Ok(None);
                } else if register.kind == RegisterKind::RegisterBase {
                    return Ok(Some((
                        Some(AbstractComparison::new(
                            "!=",
                            AbstractExpression::Immediate(0),
                            AbstractExpression::Register(Box::new(register)),
                        )),
                        instruction.r2.clone(),
                        None,
                    )));
                } else {
                    return Ok(Some((None, instruction.r2.clone(), None)));
                }
            }
            "cbz" => {
                let register = self.registers
                    [get_register_index(instruction.r1.clone().expect("Need one register"))]
                .clone();

                if (register.base.is_none()
                    || register.base.clone().unwrap() == AbstractExpression::Empty)
                    && register.offset == 0
                {
                    return Ok(Some((None, instruction.r2.clone(), None)));
                } else if register.kind == RegisterKind::RegisterBase {
                    return Ok(Some((
                        Some(AbstractComparison::new(
                            "==",
                            AbstractExpression::Immediate(0),
                            AbstractExpression::Register(Box::new(register)),
                        )),
                        instruction.r2.clone(),
                        None,
                    )));
                } else {
                    return Ok(None);
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
                    "cs" => match self.carry.clone().expect("Need carry flag set") {
                        FlagValue::REAL(b) => {
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
                        FlagValue::ABSTRACT(_) => {
                            log::error!("Can't support this yet :)");
                            todo!();
                        }
                    },
                    "cc" => match self.carry.clone().expect("Need carry flag set") {
                        FlagValue::REAL(b) => {
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
                        FlagValue::ABSTRACT(_) => {
                            log::error!("Can't support this yet :)");
                            todo!();
                        }
                    },
                    _ => todo!(),
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
                return Ok(Some((None, instruction.r1.clone(), None)));
            }
            "b.ne" => {
                match &self.zero {
                // if zero is set to false, then cmp -> not equal and we branch
                Some(flag) => match flag {
                    FlagValue::REAL(b) => {
                        if !b {
                            return Ok(Some((None, instruction.r1.clone(), None)));
                        } else {
                            return Ok(None);
                        }
                    }
                    FlagValue::ABSTRACT(s) => {
                        return Ok(Some((Some(s.clone()), instruction.r1.clone(), None)));
                    }
                },
                None => return Err(
                    "Flag cannot be branched on since it has not been set within the program yet"
                        .to_string(),
                ),
            }
            }
            "b.eq" => {
                match &self.zero {
                // if zero is set to false, then cmp -> not equal and we branch
                Some(flag) => match flag {
                    FlagValue::REAL(b) => {
                        if *b {
                            return Ok(Some((None, instruction.r1.clone(), None)));
                        } else {
                            return Ok(None);
                        }
                    }
                    FlagValue::ABSTRACT(s) => {
                        return Ok(Some((Some(s.clone()), instruction.r1.clone(), None)));
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
                                return Ok(Some((None, Some("return".to_string()), None)));
                            }
                        }
                        return Ok(Some((None, None, Some(x30.offset.try_into().unwrap()))));
                    } else {
                        log::error!("cannot jump on non-address");
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
                let reg1 = instruction.r1.clone().unwrap();
                let reg2 = instruction.r2.clone().unwrap();

                let reg2base = get_register_name_string(reg2.clone());
                let mut base_add_reg = self.registers[get_register_index(reg2base.clone())].clone();

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

                let res = self.load(reg1, base_add_reg.clone());
                match res {
                    Err(e) => return Err(e.to_string()),
                    _ => (),
                }

                // post-index
                if instruction.r3.is_some() {
                    let new_imm = self.operand(instruction.r3.clone().unwrap());
                    self.set_register(
                        reg2base,
                        base_add_reg.kind,
                        base_add_reg.base,
                        base_add_reg.offset + new_imm.offset,
                    );
                }
            }
            "ldp" => {
                let reg1 = instruction.r1.clone().unwrap();
                let reg2 = instruction.r2.clone().unwrap();
                let reg3 = instruction.r3.clone().unwrap();

                let reg3base = get_register_name_string(reg3.clone());
                let mut base_add_reg = self.registers[get_register_index(reg3base.clone())].clone();

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
                    let new_imm = self.operand(instruction.r4.clone().unwrap());
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
            "str" => {
                let reg1 = instruction.r1.clone().unwrap();
                let reg2 = instruction.r2.clone().unwrap();

                let reg2base = get_register_name_string(reg2.clone());
                let mut base_add_reg = self.registers[get_register_index(reg2base.clone())].clone();

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
                    let new_imm = self.operand(instruction.r3.clone().unwrap());
                    self.set_register(
                        reg2base,
                        base_add_reg.kind,
                        base_add_reg.base,
                        base_add_reg.offset + new_imm.offset,
                    );
                }
            }
            "stp" => {
                let reg1 = instruction.r1.clone().unwrap();
                let reg2 = instruction.r2.clone().unwrap();
                let reg3 = instruction.r3.clone().unwrap();

                let reg3base = get_register_name_string(reg3.clone());
                let mut base_add_reg = self.registers[get_register_index(reg3base.clone())].clone();

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
                    let new_imm = self.operand(instruction.r4.clone().unwrap());
                    self.set_register(
                        reg3base,
                        base_add_reg.kind,
                        base_add_reg.base,
                        base_add_reg.offset + new_imm.offset,
                    );
                }
            }
            _ => {
                log::warn!("Instruction not supported {:?}", instruction);
            }
        }
        Ok(None)
    }

    fn arithmetic(
        &mut self,
        op_string: &str,
        op: &dyn Fn(i64, i64) -> i64,
        reg0: String,
        reg1: String,
        reg2: String,
        reg3: Option<String>,
    ) {
        let r1 = self.operand(reg1.clone());
        let mut r2 = self.operand(reg2.clone());

        if reg3.is_some() {
            if let Some(expr) = reg3 {
                let parts = expr.split_once('#').unwrap();

                r2 = shift_imm(parts.0.to_string(), r2.clone(), string_to_int(parts.1));
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
        let r1 = self.registers[get_register_index(reg1.clone())].clone();
        let r2 = self.registers[get_register_index(reg2.clone())].clone();

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    if r1.base.eq(&r2.base) {
                        self.neg = if r1.offset < r2.offset {
                            Some(FlagValue::REAL(true))
                        } else {
                            Some(FlagValue::REAL(false))
                        };
                        self.zero = if r1.offset == r2.offset {
                            Some(FlagValue::REAL(true))
                        } else {
                            Some(FlagValue::REAL(false))
                        };
                        // signed vs signed distinction, maybe make offset generic to handle both?
                        self.carry = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                            Some(FlagValue::REAL(true))
                        } else {
                            Some(FlagValue::REAL(false))
                        };
                        self.overflow = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                            Some(FlagValue::REAL(true))
                        } else {
                            Some(FlagValue::REAL(false))
                        };
                    } else {
                        let expression = AbstractExpression::Expression(
                            "-".to_string(),
                            Box::new(AbstractExpression::Register(Box::new(r1))),
                            Box::new(AbstractExpression::Register(Box::new(r2))),
                        );
                        self.neg = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                            "<",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        self.zero = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                            "==",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        // FIX carry + overflow
                        self.carry = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                            "<",
                            expression.clone(),
                            AbstractExpression::Immediate(std::i64::MIN),
                        )));
                        self.overflow = Some(FlagValue::ABSTRACT(AbstractComparison::new(
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
                        Some(FlagValue::REAL(true))
                    } else {
                        Some(FlagValue::REAL(false))
                    };
                    self.zero = if r1.offset == r2.offset {
                        Some(FlagValue::REAL(true))
                    } else {
                        Some(FlagValue::REAL(false))
                    };
                    // signed vs signed distinction, maybe make offset generic to handle both?
                    self.carry = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                        Some(FlagValue::REAL(true))
                    } else {
                        Some(FlagValue::REAL(false))
                    };
                    self.overflow = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                        Some(FlagValue::REAL(true))
                    } else {
                        Some(FlagValue::REAL(false))
                    };
                }
            }
        } else if r1.kind == RegisterKind::RegisterBase || r2.kind == RegisterKind::RegisterBase {
            let expression = AbstractExpression::Expression(
                "-".to_string(),
                Box::new(AbstractExpression::Register(Box::new(r1))),
                Box::new(AbstractExpression::Register(Box::new(r2))),
            );
            self.neg = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                "<",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            self.zero = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                "==",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            // FIX carry + overflow
            self.carry = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                "<",
                expression.clone(),
                AbstractExpression::Immediate(std::i64::MIN),
            )));
            self.overflow = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                "<",
                expression,
                AbstractExpression::Immediate(std::i64::MIN),
            )));
        }
    }

    fn cmn(&mut self, reg1: String, reg2: String) {
        let r1 = self.registers[get_register_index(reg1.clone())].clone();
        let r2 = self.registers[get_register_index(reg2.clone())].clone();

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    if r1.base.eq(&r2.base) {
                        self.neg = if r1.offset + r2.offset < 0 {
                            Some(FlagValue::REAL(true))
                        } else {
                            Some(FlagValue::REAL(false))
                        };
                        self.zero = if r1.offset + r2.offset == 0 {
                            Some(FlagValue::REAL(true))
                        } else {
                            Some(FlagValue::REAL(false))
                        };
                        self.carry = if r2.offset + r1.offset > std::i64::MAX {
                            Some(FlagValue::REAL(true))
                        } else {
                            Some(FlagValue::REAL(false))
                        };
                        self.overflow = if r2.offset + r1.offset > std::i64::MAX {
                            Some(FlagValue::REAL(true))
                        } else {
                            Some(FlagValue::REAL(false))
                        };
                    } else {
                        let expression = AbstractExpression::Expression(
                            "+".to_string(),
                            Box::new(AbstractExpression::Register(Box::new(r1))),
                            Box::new(AbstractExpression::Register(Box::new(r2))),
                        );
                        self.neg = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                            "<",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        self.zero = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                            "==",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        // FIX carry + overflow
                        self.carry = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                            "<",
                            expression.clone(),
                            AbstractExpression::Immediate(std::i64::MAX),
                        )));
                        self.overflow = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                            "<",
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
                        Some(FlagValue::REAL(true))
                    } else {
                        Some(FlagValue::REAL(false))
                    };
                    self.zero = if r1.offset + r2.offset == 0 {
                        Some(FlagValue::REAL(true))
                    } else {
                        Some(FlagValue::REAL(false))
                    };
                    // signed vs signed distinction, maybe make offset generic to handle both?
                    self.carry = if r2.offset + r1.offset > std::i64::MAX {
                        Some(FlagValue::REAL(true))
                    } else {
                        Some(FlagValue::REAL(false))
                    };
                    self.overflow = if r2.offset + r1.offset > std::i64::MAX {
                        Some(FlagValue::REAL(true))
                    } else {
                        Some(FlagValue::REAL(false))
                    };
                }
            }
        } else if r1.kind == RegisterKind::RegisterBase || r2.kind == RegisterKind::RegisterBase {
            let expression = AbstractExpression::Expression(
                "+".to_string(),
                Box::new(AbstractExpression::Register(Box::new(r1))),
                Box::new(AbstractExpression::Register(Box::new(r2))),
            );
            self.neg = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                "<",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            self.zero = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                "==",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            // FIX carry + overflow
            self.carry = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                "<",
                expression.clone(),
                AbstractExpression::Immediate(std::i64::MIN),
            )));
            self.overflow = Some(FlagValue::ABSTRACT(AbstractComparison::new(
                "<",
                expression,
                AbstractExpression::Immediate(std::i64::MIN),
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
                let region = self
                    .memory
                    .get(&base)
                    .expect("Need memory region to load from");
                match region.get(address.offset) {
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
                let region = self.memory.get_mut(&base.clone()).expect("No region");
                let register = &self.registers[get_register_index(register)];
                region.insert(address.offset.clone(), register.clone());

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
                log::error!("No element at this address in region");
                return Err(MemorySafetyError::new(
                    "Cannot read element at this address from region",
                ));
            }
        } else {
            return res;
        }
    }

    // SAFETY CHECKS
    fn mem_safe_access(
        &self,
        base_expr: AbstractExpression,
        offset: i64,
        ty: RegionType,
    ) -> Result<(), MemorySafetyError> {
        let (region, base) = match base_expr.clone() {
            AbstractExpression::Abstract(regbase) => (
                self.memory
                    .get(&regbase.clone())
                    .expect("Region not in memory"),
                ast::Int::new_const(self.context, regbase),
            ),
            _ => {
                let abstracts = base_expr.get_abstracts();
                let mut result: Option<(&MemorySafeRegion, z3::ast::Int<'_>)> = None;
                for r in self.memory.keys() {
                    if abstracts.contains(r) {
                        result = Some((
                            self.memory.get(r).expect("Region not in memory"),
                            expression_to_ast(self.context, base_expr.clone()).unwrap(),
                        ));
                        break;
                    };
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

        if region.kind != ty && region.kind != RegionType::RW {
            return Err(MemorySafetyError::new("Access does not match region type"));
        }

        let abs_offset = ast::Int::from_i64(self.context, offset);
        let access = ast::Int::add(self.context, &[&base, &abs_offset]);

        // let width = ast::Int::from_i64(self.context, 2);    // how wide is memory access, two bytes
        let lowerbound_value = ast::Int::from_i64(self.context, 0);
        let low_access = ast::Int::add(self.context, &[&base, &lowerbound_value]);
        let upperbound_value = expression_to_ast(self.context, region.get_length()).unwrap();
        let up_access = ast::Int::add(self.context, &[&base, &upperbound_value]);
        let l = access.lt(&low_access);
        let u = access.ge(&up_access);

        match (
            self.solver.check_assumptions(&[l]),
            self.solver.check_assumptions(&[u]),
        ) {
            (SatResult::Unsat, SatResult::Unsat) => {
                log::info!("Memory safe with solver's check!");
                log::info!("Unsat core {:?}", self.solver.get_unsat_core());
                return Ok(());
            }
            (a, b) => {
                log::error!(
                    "impossibility lower bound {:?}, impossibility upper bound {:?}, model: {:?}",
                    a,
                    b,
                    self.solver.get_model()
                );
                log::error!("Memory unsafe with solver's check!");
            }
        }

        return Err(MemorySafetyError::new(
            format!(
                "Writing to address outside allowable memory regions {:?}, {:?}",
                base_expr, offset
            )
            .as_str(),
        ));
    }
}
