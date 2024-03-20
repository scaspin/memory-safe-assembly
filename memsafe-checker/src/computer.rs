use std::collections::HashMap;
use std::fmt;
use z3::*;

use crate::common;
use crate::common::{AbstractComparison, AbstractExpression, RegisterKind, RegisterValue};

fn get_register_index(reg_name: String) -> usize {
    let name = reg_name.clone();
    if reg_name == "sp" {
        return 31;
    }
    let r0 = name.strip_prefix("x").unwrap_or(&name);
    let r1: usize = r0
        .strip_prefix("w")
        .unwrap_or(&r0)
        .parse::<usize>()
        .expect(format!("Invalid register value {:?}", reg_name).as_str());
    return r1;
}

pub struct ARMCORTEXA<'ctx> {
    registers: [RegisterValue; 33],
    zero: Option<common::FlagValue>,
    neg: Option<common::FlagValue>,
    carry: Option<common::FlagValue>,
    overflow: Option<common::FlagValue>,
    memory: HashMap<i64, i64>,
    stack: HashMap<i64, RegisterValue>,
    stack_size: i64,
    memory_safe_regions: Vec<common::MemorySafeRegion>,
    // constraints: Vec<AbstractExpression>,
    tracked_loop_abstracts: Vec<String>,
    rw_queue: Vec<common::MemoryAccess>,
    pub alignment: i64,
    pub context: &'ctx Context,
    pub solver: Solver<'ctx>,
}

impl<'ctx> fmt::Debug for ARMCORTEXA<'ctx> {
    fn fmt(&self, _f: &mut fmt::Formatter<'_>) -> fmt::Result {
        // write!(f, "stack: {:?}", &self.stack);
        // for i in [0..31] {
        //     println!("register {:?}", &self.registers[i]);
        // }
        println!("registers {:?}", &self.registers);
        Ok(())
    }
}

impl<'ctx> ARMCORTEXA<'_> {
    pub fn new(context: &'ctx Context) -> ARMCORTEXA<'ctx> {
        let registers = [
            RegisterValue::new("x0"),
            RegisterValue::new("x1"),
            RegisterValue::new("x2"),
            RegisterValue::new("x3"),
            RegisterValue::new("x4"),
            RegisterValue::new("x5"),
            RegisterValue::new("x6"),
            RegisterValue::new("x7"),
            RegisterValue::new("x8"),
            RegisterValue::new("x9"),
            RegisterValue::new("x10"),
            RegisterValue::new("x11"),
            RegisterValue::new("x12"),
            RegisterValue::new("x13"),
            RegisterValue::new("x14"),
            RegisterValue::new("x15"),
            RegisterValue::new("x16"),
            RegisterValue::new("x17"),
            RegisterValue::new("x18"),
            RegisterValue::new("x19"),
            RegisterValue::new("x20"),
            RegisterValue::new("x21"),
            RegisterValue::new("x22"),
            RegisterValue::new("x23"),
            RegisterValue::new("x24"),
            RegisterValue::new("x25"),
            RegisterValue::new("x26"),
            RegisterValue::new("x27"),
            RegisterValue::new("x28"),
            RegisterValue::new("x29"), // frame pointer
            RegisterValue::new("x30"), // link
            RegisterValue::new("sp"),  // stack pointer
            RegisterValue::new("xzr"), // 64-bit zero
        ];

        let solver = Solver::new(&context);

        ARMCORTEXA {
            registers,
            zero: None,
            neg: None,
            carry: None,
            overflow: None,
            memory: HashMap::new(),
            stack: HashMap::new(),
            stack_size: 0,
            memory_safe_regions: Vec::new(),
            tracked_loop_abstracts: Vec::new(),
            rw_queue: Vec::new(),
            alignment: 4,
            context,
            solver,
        }
    }

    pub fn set_region(&mut self, region: common::MemorySafeRegion) {
        self.memory_safe_regions.push(region.clone());
    }

    pub fn set_immediate(&mut self, register: String, value: u64) {
        self.set_register(register, RegisterKind::Immediate, None, value as i64);
    }

    pub fn set_abstract(&mut self, register: String, value: AbstractExpression) {
        self.set_register(register, RegisterKind::Abstract, Some(value), 0);
    }

    // pub fn add_constraint(&mut self, constraint: AbstractExpression) {
    //     if !self.constraints.contains(&constraint.clone()) {
    //         self.constraints.push(constraint);
    //     }
    // }

    fn set_register(
        &mut self,
        name: String,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        if name.contains("w") {
            self.registers[get_register_index(name.clone())].set(
                name,
                kind,
                base,
                (offset as i32) as i64,
            )
        } else {
            self.registers[get_register_index(name.clone())].set(name, kind, base, offset as i64)
        }
    }

    pub fn add_memory(&mut self, address: i64, value: i64) {
        self.memory.insert(address, value);
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

    pub fn read_rw_queue(&self) -> Vec<common::MemoryAccess> {
        self.rw_queue.clone()
    }

    pub fn track_register(&mut self, register: String) {
        self.tracked_loop_abstracts.push(register);
    }

    pub fn untrack_register(&mut self, register: String) {
        let index = self
            .tracked_loop_abstracts
            .iter()
            .position(|n| n == &register);
        match index {
            Some(i) => self.tracked_loop_abstracts.remove(i),
            None => return,
        };
    }

    // FIX: better name for what this is? make tokens not just ?
    pub fn replace_abstract(&mut self, token: &str, value: AbstractExpression) {
        for i in 0..self.registers.len() {
            if let Some(b) = &self.registers[i].base {
                if b.contains(&token) {
                    self.registers[i].base = Some(b.replace(token, value.clone()));
                }
            }
        }
        // TODO: update flags and stack as well?
    }

    pub fn change_alignment(&mut self, value: i64) {
        self.alignment = value;
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
                name: "IntermediateRegister".to_string(),
                kind: RegisterKind::Immediate,
                base: base,
                offset: common::string_to_int(&offset),
            };

        // address within register
        } else if v.contains('[') && !v.contains(',') {
            let reg = self.registers[get_register_index(v.trim_matches('[').to_string())].clone();
            return RegisterValue {
                name: "IntermediateRegister".to_string(),
                kind: RegisterKind::Address,
                base: reg.base,
                offset: reg.offset,
            };
        } else if v.contains('[') && v.contains(',') && v.contains('#') {
            let a = v.split_once(',').unwrap();
            let reg = self.registers[get_register_index(a.0.trim_matches('[').to_string())].clone();
            return RegisterValue {
                name: "IntermediateRegister".to_string(),
                kind: RegisterKind::Address,
                base: reg.base,
                offset: reg.offset + common::string_to_int(a.1.trim_matches(']')),
            };
        } else if v.contains("@") {
            // TODO : expand functionality
            if v.contains("OFF") {
                return RegisterValue {
                    name: "IntermediateRegister".to_string(),
                    kind: RegisterKind::Immediate,
                    base: None,
                    offset: self.alignment,
                };
            } else {
                return RegisterValue {
                    name: "IntermediateRegister".to_string(),
                    kind: RegisterKind::Address,
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
        instruction: &common::Instruction,
    ) -> Result<Option<(Option<AbstractComparison>, Option<String>, Option<u128>)>, String> {
        if instruction.op == "add" {
            self.arithmetic(
                "+",
                &|x, y| x + y,
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
                instruction.r4.clone(),
            );
        } else if instruction.op == "sub" {
            self.arithmetic(
                "-",
                &|x, y| x - y,
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
                instruction.r4.clone(),
            );
        } else if instruction.op == "and" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x & y,
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
                instruction.r4.clone(),
            );
        } else if instruction.op == "orr" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x | y,
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
                instruction.r4.clone(),
            );
        } else if instruction.op == "eor" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x ^ y,
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
                instruction.r4.clone(),
            );
        } else if instruction.op == "bic" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x & !y,
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
                instruction.r4.clone(),
            );
        } else if instruction.op == "ror" {
            self.shift_reg(
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
            );
        } else if instruction.op == "adrp" {
            let address = self.operand(instruction.r2.clone().expect("Need address label"));
            self.set_register(
                instruction.r1.clone().expect("need dst register"),
                RegisterKind::Address,
                Some(AbstractExpression::Abstract("Memory".to_string())), // FIX: needs to be more general
                address.offset,
            );
        } else if instruction.op == "cbnz" {
            let register = self.registers
                [get_register_index(instruction.r1.clone().expect("Need one register"))]
            .clone();
            if (register.base.is_none()
                || register.base.clone().unwrap() == AbstractExpression::Empty)
                && register.offset == 0
            {
                return Ok(None);
            } else if register.kind == RegisterKind::Abstract {
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
                return Ok(Some((None, instruction.r2.clone(), None)));
            }
        } else if instruction.op == "cmp" {
            self.cmp(
                instruction.r1.clone().expect("need register to compare"),
                instruction.r2.clone().expect("need register to compare"),
            );
        // TODO: make branch more general
        // https://developer.arm.com/documentation/dui0068/b/ARM-Instruction-Reference/Conditional-execution
        } else if instruction.op == "b" {
            return Ok(Some((None, instruction.r1.clone(), None)));
        } else if instruction.op == "b.ne" {
            match &self.zero {
                // if zero is set to false, then cmp -> not equal and we branch
                Some(flag) => match flag {
                    common::FlagValue::REAL(b) => {
                        if !b {
                            return Ok(Some((None, instruction.r1.clone(), None)));
                        } else {
                            return Ok(None);
                        }
                    }
                    common::FlagValue::ABSTRACT(s) => {
                        return Ok(Some((Some(s.clone()), instruction.r1.clone(), None)));
                    }
                },
                None => return Err(
                    "Flag cannot be branched on since it has not been set within the program yet"
                        .to_string(),
                ),
            }
        } else if instruction.op == "b.eq" {
            match &self.zero {
                // if zero is set to false, then cmp -> not equal and we branch
                Some(flag) => match flag {
                    common::FlagValue::REAL(b) => {
                        if *b {
                            return Ok(Some((None, instruction.r1.clone(), None)));
                        } else {
                            return Ok(None);
                        }
                    }
                    common::FlagValue::ABSTRACT(s) => {
                        return Ok(Some((Some(s.clone()), instruction.r1.clone(), None)));
                    }
                },
                None => return Err(
                    "Flag cannot be branched on since it has not been set within the program yet"
                        .to_string(),
                ),
            }
        } else if instruction.op == "ret" {
            if instruction.r1.is_none() {
                let x30 = self.registers[30].clone();
                if x30.kind == RegisterKind::Address {
                    if let Some(AbstractExpression::Abstract(address)) = x30.base {
                        if address == "Return" && x30.offset == 0 {
                            return Ok(Some((None, None, Some(0))));
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
        } else if instruction.op == "ldr" {
            let reg1 = instruction.r1.clone().unwrap();
            let reg2 = instruction.r2.clone().unwrap();

            let reg2base = common::get_register_name_string(reg2.clone());
            let mut base_add_reg = self.registers[get_register_index(reg2base.clone())].clone();

            // pre-index increment
            if reg2.contains(",") {
                base_add_reg = self.operand(reg2.clone().trim_end_matches("!").to_string());
                // with writeback
                if reg2.contains("!") {
                    let new_reg = base_add_reg.clone();
                    self.set_register(reg2base.clone(), new_reg.kind, new_reg.base, new_reg.offset);
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
        } else if instruction.op == "ldp" {
            let reg1 = instruction.r1.clone().unwrap();
            let reg2 = instruction.r2.clone().unwrap();
            let reg3 = instruction.r3.clone().unwrap();

            let reg3base = common::get_register_name_string(reg3.clone());
            let mut base_add_reg = self.registers[get_register_index(reg3base.clone())].clone();

            // pre-index increment
            if reg3.contains(",") {
                base_add_reg = self.operand(reg3.clone().trim_end_matches("!").to_string());
                // with writeback
                if reg3.contains("!") {
                    let new_reg = base_add_reg.clone();
                    self.set_register(reg3base.clone(), new_reg.kind, new_reg.base, new_reg.offset);
                }
            }

            let res1 = self.load(reg1, base_add_reg.clone());

            let mut next = base_add_reg.clone();
            next.offset = next.offset + 8;
            let res2 = self.load(reg2, next);

            // post-index
            if instruction.r4.is_some() {
                if self.tracked_loop_abstracts.contains(&reg3base)
                    || reg3base.contains(&"?".to_string())
                {
                    return Ok(None);
                }
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
        } else if instruction.op == "str" {
            let reg1 = instruction.r1.clone().unwrap();
            let reg2 = instruction.r2.clone().unwrap();

            let reg2base = common::get_register_name_string(reg2.clone());
            let mut base_add_reg = self.registers[get_register_index(reg2base.clone())].clone();

            // pre-index increment
            if reg2.contains(",") {
                base_add_reg = self.operand(reg2.clone().trim_end_matches("!").to_string());
                // with writeback
                if reg2.contains("!") {
                    let new_reg = base_add_reg.clone();
                    self.set_register(reg2base.clone(), new_reg.kind, new_reg.base, new_reg.offset);
                }
            }

            let reg2base = common::get_register_name_string(reg2.clone());
            let res = self.store(reg1, base_add_reg.clone());
            match res {
                Err(e) => return Err(e.to_string()),
                _ => (),
            }

            // post-index
            if instruction.r3.is_some() {
                if self.tracked_loop_abstracts.contains(&reg2base)
                    || reg2base.contains(&"?".to_string())
                {
                    return Ok(None);
                }
                let new_imm = self.operand(instruction.r3.clone().unwrap());
                self.set_register(
                    reg2base,
                    base_add_reg.kind,
                    base_add_reg.base,
                    base_add_reg.offset + new_imm.offset,
                );
            }
        } else if instruction.op == "stp" {
            let reg1 = instruction.r1.clone().unwrap();
            let reg2 = instruction.r2.clone().unwrap();
            let reg3 = instruction.r3.clone().unwrap();

            let reg3base = common::get_register_name_string(reg3.clone());
            let mut base_add_reg = self.registers[get_register_index(reg3base.clone())].clone();

            // pre-index increment
            if reg3.contains(",") {
                base_add_reg = self.operand(reg3.clone().trim_end_matches("!").to_string());
                // with writeback
                if reg3.contains("!") {
                    let new_reg = base_add_reg.clone();
                    self.set_register(reg3base.clone(), new_reg.kind, new_reg.base, new_reg.offset);
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
                if self.tracked_loop_abstracts.contains(&reg3base)
                    || reg3base.contains(&"?".to_string())
                {
                    return Ok(None);
                }
                let new_imm = self.operand(instruction.r4.clone().unwrap());
                self.set_register(
                    reg3base,
                    base_add_reg.kind,
                    base_add_reg.base,
                    base_add_reg.offset + new_imm.offset,
                );
            }
        } else {
            log::warn!("Instruction not supported {:?}", instruction);
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
        // let saved_reg0 = reg0.clone();
        let r1 = self.operand(reg1.clone());
        let mut r2 = self.operand(reg2.clone());

        // if we're tracking r1 or r2 for abstract looping, we're just gonna operate
        // some abstract
        if self.tracked_loop_abstracts.contains(&reg1)
            || self.tracked_loop_abstracts.contains(&reg2)
        {
            // need to make sure this works if r2 isn't immediate
            if let Some(b) = r1.base.clone() {
                if !b.contains("?") {
                    let new_base = AbstractExpression::Expression(
                        op_string.to_string(),
                        Box::new(b),
                        Box::new(AbstractExpression::Abstract("?".to_string())),
                    );
                    self.set_register(reg0, r1.kind, Some(new_base), 0);
                    // self.add_constraint(AbstractExpression::Expression(
                    //     ">".to_string(),
                    //     Box::new(AbstractExpression::Abstract("?".to_string())),
                    //     Box::new(AbstractExpression::Immediate(op(r1.offset, r2.offset))),
                    // ));
                    // self.add_constraint(AbstractExpression::Expression(
                    //     ">".to_string(),
                    //     Box::new(AbstractExpression::Abstract("?".to_string())),
                    //     Box::new(AbstractExpression::Immediate(0)),
                    // ));
                    // self.untrack_register(reg1);
                    // self.untrack_register(reg2);
                }
                return;
            }

            if let Some(b) = r2.base.clone() {
                if !b.contains("?") {
                    let new_base = AbstractExpression::Expression(
                        op_string.to_string(),
                        Box::new(b),
                        Box::new(AbstractExpression::Abstract("?".to_string())),
                    );
                    self.set_register(reg0, r2.kind, Some(new_base), op(r1.offset, r2.offset));
                    self.untrack_register(reg1);
                    self.untrack_register(reg2);
                }
                return;
            }
        }

        if reg3.is_some() {
            if let Some(expr) = reg3 {
                let parts = expr.split_once('#').unwrap();

                r2 = common::shift_imm(
                    parts.0.to_string(),
                    r2.clone(),
                    common::string_to_int(parts.1),
                );
            }
        }

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    let base = match r1.clone().base {
                        Some(reg1base) => match r2.clone().base {
                            Some(reg2base) => {
                                let concat =
                                    common::generate_expression(op_string, reg1base, reg2base);
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
                RegisterKind::Abstract => {
                    let base = match r1.clone().base {
                        Some(reg1base) => match r2.clone().base {
                            Some(reg2base) => {
                                let concat =
                                    common::generate_expression(op_string, reg1base, reg2base);
                                Some(concat)
                            }
                            None => Some(reg1base),
                        },
                        None => match r2.clone().base {
                            Some(reg2base) => Some(reg2base),
                            None => None,
                        },
                    };
                    self.set_register(reg0, RegisterKind::Abstract, base, op(r1.offset, r2.offset))
                }
                RegisterKind::Immediate => self.set_register(
                    reg0,
                    RegisterKind::Immediate,
                    None,
                    op(r1.offset, r2.offset),
                ),
                RegisterKind::Address => {
                    // why would someone add two addresses? bad
                    // I guess ok as long as we don't use as address
                    log::warn!("Not advisable to add two addresses");
                    self.set_register(reg0, RegisterKind::Address, None, op(r1.offset, r2.offset))
                }
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
        } else if r1.kind == RegisterKind::Abstract || r2.kind == RegisterKind::Abstract {
            let base = match r2.clone().base {
                Some(reg1base) => match r1.clone().base {
                    Some(reg2base) => {
                        let concat = common::generate_expression(op_string, reg1base, reg2base);
                        Some(concat)
                    }
                    None => Some(reg1base),
                },
                None => match r1.clone().base {
                    Some(reg2base) => Some(reg2base),
                    None => None,
                },
            };
            self.set_register(reg0, RegisterKind::Abstract, base, op(r1.offset, r2.offset))
        } else {
            // println!("op: {:?}, r1: {:?}, r2:{:?}", op_string, r1, r2 );
            log::error!("Cannot perform arithmetic on these two registers")
        }

        // remove constraints on the base of the result
        // since performing arithmetic potentially invalidates these
        // let result = self.operand(saved_reg0);
        // if let Some(base) = result.base {
        //     let mut new_constraints = Vec::new();
        //     for exp in &self.constraints {
        //         if exp.contains_expression(&base.clone()) {
        //             let comparison = exp.contradicts(base.clone());
        //             match comparison {
        //                 Some(true) => (),
        //                 _ => new_constraints.push(exp.clone()),
        //             }
        //         } else {
        //             new_constraints.push(exp.clone());
        //         }
        //     }
        //     self.constraints = new_constraints;
        // }
    }

    fn shift_reg(&mut self, reg1: String, reg2: String, reg3: String) {
        let r1 = self.registers[get_register_index(reg1.clone())].clone();
        let r2 = self.registers[get_register_index(reg2)].clone();

        let shift = self.operand(reg3).offset;
        let new_offset = r2.offset >> (shift % 64);
        self.set_register(
            reg1,
            r2.clone().kind,
            Some(common::generate_expression(
                "ror",
                r1.base.unwrap_or(AbstractExpression::Empty),
                AbstractExpression::Immediate(r2.offset),
            )),
            new_offset,
        );
    }

    fn cmp(&mut self, reg1: String, reg2: String) {
        let r1 = self.registers[get_register_index(reg1.clone())].clone();
        let r2 = self.registers[get_register_index(reg2.clone())].clone();

        // println!("Comparing r1: {:?}, r2: {:?}", r1, r2);

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    if r1.base.eq(&r2.base) {
                        self.neg = if r1.offset < r2.offset {
                            Some(common::FlagValue::REAL(true))
                        } else {
                            Some(common::FlagValue::REAL(false))
                        };
                        self.zero = if r1.offset == r2.offset {
                            Some(common::FlagValue::REAL(true))
                        } else {
                            Some(common::FlagValue::REAL(false))
                        };
                        // signed vs signed distinction, maybe make offset generic to handle both?
                        self.carry = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                            Some(common::FlagValue::REAL(true))
                        } else {
                            Some(common::FlagValue::REAL(false))
                        };
                        self.overflow = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                            Some(common::FlagValue::REAL(true))
                        } else {
                            Some(common::FlagValue::REAL(false))
                        };
                    } else {
                        let expression = AbstractExpression::Expression(
                            "-".to_string(),
                            Box::new(AbstractExpression::Register(Box::new(r1))),
                            Box::new(AbstractExpression::Register(Box::new(r2))),
                        );
                        self.neg = Some(common::FlagValue::ABSTRACT(AbstractComparison::new(
                            "<",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        self.zero = Some(common::FlagValue::ABSTRACT(AbstractComparison::new(
                            "==",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        // FIX carry + overflow
                        self.carry = Some(common::FlagValue::ABSTRACT(AbstractComparison::new(
                            "<",
                            expression.clone(),
                            AbstractExpression::Immediate(std::i64::MIN),
                        )));
                        self.overflow = Some(common::FlagValue::ABSTRACT(AbstractComparison::new(
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
                        Some(common::FlagValue::REAL(true))
                    } else {
                        Some(common::FlagValue::REAL(false))
                    };
                    self.zero = if r1.offset == r2.offset {
                        Some(common::FlagValue::REAL(true))
                    } else {
                        Some(common::FlagValue::REAL(false))
                    };
                    // signed vs signed distinction, maybe make offset generic to handle both?
                    self.carry = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                        Some(common::FlagValue::REAL(true))
                    } else {
                        Some(common::FlagValue::REAL(false))
                    };
                    self.overflow = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                        Some(common::FlagValue::REAL(true))
                    } else {
                        Some(common::FlagValue::REAL(false))
                    };
                }
                RegisterKind::Address => {
                    self.neg = if r1.offset < r2.offset {
                        Some(common::FlagValue::REAL(true))
                    } else {
                        Some(common::FlagValue::REAL(false))
                    };
                    self.zero = if r1.offset == r2.offset {
                        Some(common::FlagValue::REAL(true))
                    } else {
                        Some(common::FlagValue::REAL(false))
                    };
                    // signed vs signed distinction, maybe make offset generic to handle both?
                    self.carry = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                        Some(common::FlagValue::REAL(true))
                    } else {
                        Some(common::FlagValue::REAL(false))
                    };
                    self.overflow = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                        Some(common::FlagValue::REAL(true))
                    } else {
                        Some(common::FlagValue::REAL(false))
                    };
                }
                RegisterKind::Abstract => {
                    if r1.base.eq(&r2.base) {
                        self.neg = if r1.offset < r2.offset {
                            Some(common::FlagValue::REAL(true))
                        } else {
                            Some(common::FlagValue::REAL(false))
                        };
                        self.zero = if r1.offset == r2.offset {
                            Some(common::FlagValue::REAL(true))
                        } else {
                            Some(common::FlagValue::REAL(false))
                        };
                        // signed vs signed distinction, maybe make offset generic to handle both?
                        self.carry = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                            Some(common::FlagValue::REAL(true))
                        } else {
                            Some(common::FlagValue::REAL(false))
                        };
                        self.overflow = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                            Some(common::FlagValue::REAL(true))
                        } else {
                            Some(common::FlagValue::REAL(false))
                        };
                    } else {
                        let expression = AbstractExpression::Expression(
                            "-".to_string(),
                            Box::new(AbstractExpression::Register(Box::new(r1))),
                            Box::new(AbstractExpression::Register(Box::new(r2))),
                        );
                        self.neg = Some(common::FlagValue::ABSTRACT(AbstractComparison::new(
                            "<",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        self.zero = Some(common::FlagValue::ABSTRACT(AbstractComparison::new(
                            "==",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        // FIX carry + overflow
                        self.carry = Some(common::FlagValue::ABSTRACT(AbstractComparison::new(
                            "<",
                            expression.clone(),
                            AbstractExpression::Immediate(std::i64::MIN),
                        )));
                        self.overflow = Some(common::FlagValue::ABSTRACT(AbstractComparison::new(
                            "<",
                            expression.clone(),
                            AbstractExpression::Immediate(std::i64::MIN),
                        )));
                    }
                }
            }
        } else if r1.kind == RegisterKind::Abstract || r2.kind == RegisterKind::Abstract {
            let expression = AbstractExpression::Expression(
                "-".to_string(),
                Box::new(AbstractExpression::Register(Box::new(r1))),
                Box::new(AbstractExpression::Register(Box::new(r2))),
            );
            self.neg = Some(common::FlagValue::ABSTRACT(AbstractComparison::new(
                "<",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            self.zero = Some(common::FlagValue::ABSTRACT(AbstractComparison::new(
                "==",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            // FIX carry + overflow
            self.carry = Some(common::FlagValue::ABSTRACT(AbstractComparison::new(
                "<",
                expression.clone(),
                AbstractExpression::Immediate(std::i64::MIN),
            )));
            self.overflow = Some(common::FlagValue::ABSTRACT(AbstractComparison::new(
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
    fn load(&mut self, t: String, address: RegisterValue) -> Result<(), common::MemorySafetyError> {
        let res = self.mem_safe_read(address.base.clone(), address.offset);

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = address.base {
                if base == "sp" {
                    let val = self.stack.get(&address.offset);
                    match val {
                        Some(v) => {
                            self.set_register(t, v.kind.clone(), v.base.clone(), v.offset);
                            Ok(())
                        }
                        None => {
                            log::error!("No element at this address in stack");
                            return Err(common::MemorySafetyError::new(
                                "Cannot read element at this address from the stack",
                            ));
                        }
                    }
                } else if base == "Memory" {
                    let num = &self.memory.get(&(address.offset)).unwrap();
                    self.set_register(t, RegisterKind::Immediate, None, **num);
                    Ok(())
                } else {
                    let mut exists = false;
                    for r in &self.memory_safe_regions {
                        if r.base.contains(&base) {
                            exists = true;
                        }
                    }
                    if exists {
                        log::info!("Load from base {:?} + offset {}", base, address.offset);
                        self.set_register(t, RegisterKind::Number, None, 0);
                        self.rw_queue.push(common::MemoryAccess {
                            kind: common::RegionType::READ,
                            base: base,
                            offset: address.offset,
                        });
                        Ok(())
                    } else {
                        log::error!("Cannot read from base {:?}", base);
                        return Err(common::MemorySafetyError::new(
                            "Cannot read from address with this base",
                        ));
                    }
                }
            } else {
                let base = address
                    .base
                    .unwrap_or(AbstractExpression::Empty)
                    .to_string();
                log::info!(
                    "Load from base {:?} + offset {}",
                    base,
                    address.offset.clone()
                );
                self.rw_queue.push(common::MemoryAccess {
                    kind: common::RegionType::READ,
                    base: base,
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
    fn store(
        &mut self,
        reg: String,
        address: RegisterValue,
    ) -> Result<(), common::MemorySafetyError> {
        let res = self.mem_safe_write(address.base.clone(), address.offset);

        if res.is_ok() {
            let reg = self.registers[get_register_index(reg)].clone();
            if let Some(AbstractExpression::Abstract(base)) = address.base {
                if base == "sp" {
                    // FIX: stack addressing
                    let index = address.offset;
                    if self.stack.get(&index).is_some() {
                        self.stack.remove(&index);
                        self.stack.insert(index, reg.clone());
                    } else {
                        self.stack.insert(address.offset, reg.clone());
                    }

                    // check stack sizing
                    if index > self.stack_size {
                        self.stack_size = self.stack_size + self.alignment;
                    }
                    Ok(())
                } else {
                    let mut exists = false;
                    for r in &self.memory_safe_regions {
                        if r.base.contains(&base) {
                            exists = true;
                        }
                    }
                    if exists {
                        log::info!(
                            "Store to address {:?} + {}",
                            base.clone(),
                            address.offset.clone()
                        );
                        self.rw_queue.push(common::MemoryAccess {
                            kind: common::RegionType::WRITE,
                            base,
                            offset: address.offset,
                        });
                        Ok(())
                    } else {
                        log::error!("Could not write to base {:?}", base);
                        return Err(common::MemorySafetyError::new(
                            "Cannot store to address with this base",
                        ));
                    }
                }
            } else {
                let base = address
                    .base
                    .unwrap_or(AbstractExpression::Empty)
                    .to_string();
                log::info!(
                    "Store to base {:?} + offset {}",
                    base,
                    address.offset.clone()
                );
                self.rw_queue.push(common::MemoryAccess {
                    kind: common::RegionType::READ,
                    base: base,
                    offset: address.offset,
                });
                Ok(())
            }
        } else {
            return res;
        }
    }

    // SAFETY CHECKS

    fn mem_safe_read(
        &self,
        base: Option<AbstractExpression>,
        offset: i64,
    ) -> Result<(), common::MemorySafetyError> {
        match base.clone() {
            Some(AbstractExpression::Abstract(regbase)) => {
                // read from stack
                if regbase == "sp" || regbase == "x31" {
                    if self.stack.contains_key(&offset) {
                        return Ok(());
                    } else {
                        return Err(common::MemorySafetyError::new(
                            "Element at this address not in stack",
                        ));
                    }
                // read from static memory
                } else if regbase == "Memory" {
                    // read from defs
                    if self.memory.get(&(offset)).is_some() {
                        return Ok(());
                    }
                } else {
                    // check if read from memory safe region
                    for region in self.memory_safe_regions.clone() {
                        if region.base.contains(&regbase)
                            && (region.region_type == common::RegionType::READ
                                || region.region_type == common::RegionType::RW)
                        {
                            let abs_offset = ast::Int::from_i64(self.context, offset);
                            let base = ast::Int::new_const(self.context, regbase.clone());
                            let abstract_pointer_from_base = ast::Int::new_const(
                                self.context,
                                &*("pointer_".to_owned() + &regbase),
                            );
                            let access = ast::Int::add(self.context, &[&base, &abs_offset]);
                            // pointer = base + index
                            let assignment1 = access.ge(&abstract_pointer_from_base);
                            let assignment2 = access.le(&abstract_pointer_from_base);

                            let lowerbound_value =
                                common::expression_to_ast(self.context, region.start.clone())
                                    .unwrap();
                            let low_access =
                                ast::Int::add(self.context, &[&base, &lowerbound_value]);
                            let upperbound_value =
                                common::expression_to_ast(self.context, region.end.clone())
                                    .unwrap();
                            let up_access =
                                ast::Int::add(self.context, &[&base, &upperbound_value]);
                            let l = access.lt(&low_access);
                            let u = access.gt(&up_access);

                            match self.solver.check_assumptions(&[assignment1, assignment2]) {
                                SatResult::Sat => {
                                    log::info!("Memory safe with solver's first check!");
                                    match (
                                        self.solver.check_assumptions(&[l]),
                                        self.solver.check_assumptions(&[u]),
                                    ) {
                                        (SatResult::Unsat, SatResult::Unsat) => {
                                            log::info!("Memory safe with solver's second check!");
                                            return Ok(());
                                        }
                                        (a, b) => {
                                            println!("impossibility lower bound {:?}, impossibility upper bound {:?}", a, b);
                                            log::error!(
                                                "Memory unsafe with solver's second check!"
                                            );
                                        }
                                    }
                                }
                                _ => log::info!("Memory unsafe with solver first check!"),
                            }
                        }
                    }
                    return Err(common::MemorySafetyError::new(
                        format!(
                            "Reading at address outside allowable memory regions {:?}, {:?}",
                            regbase, offset
                        )
                        .as_str(),
                    ));
                }
            }
            Some(AbstractExpression::Expression(_, _, _)) => {
                let base = base.clone().unwrap();
                for region in self.memory_safe_regions.clone() {
                    if base.contains(&region.base)
                        && (region.region_type == common::RegionType::READ
                            || region.region_type == common::RegionType::RW)
                    {
                        // the name of the base of the region
                        let regbase = ast::Int::from_str(self.context, &region.base).unwrap();
                        let abs_offset = ast::Int::from_i64(self.context, offset);

                        //the base of the access (which is a complex expression) and the access itself
                        let base = common::expression_to_ast(self.context, base.clone()).unwrap();
                        let access = ast::Int::add(self.context, &[&base, &abs_offset]);

                        let lowerbound_value =
                            common::expression_to_ast(self.context, region.start.clone()).unwrap();
                        let low_access =
                            ast::Int::add(self.context, &[&regbase, &lowerbound_value]);
                        let upperbound_value =
                            common::expression_to_ast(self.context, region.end.clone()).unwrap();
                        let up_access = ast::Int::add(self.context, &[&regbase, &upperbound_value]);
                        let l = access.lt(&low_access);
                        let u = access.gt(&up_access);

                        match (
                            self.solver.check_assumptions(&[l]),
                            self.solver.check_assumptions(&[u]),
                        ) {
                            (SatResult::Unsat, SatResult::Unsat) => {
                                log::info!("Memory safe with solver's only check!");
                                return Ok(());
                            }
                            (a, b) => {
                                println!("impossibility lower bound {:?}, impossibility upper bound {:?}", a, b);
                                log::error!("Memory unsafe with solver's only check!");
                            }
                        }
                    }
                }
                return Err(common::MemorySafetyError::new(
                    format!(
                        "Reading at address outside allowable memory regions {:?}, {:?}",
                        base, offset
                    )
                    .as_str(),
                ));
            }
            _ => (),
        }
        Err(common::MemorySafetyError::new(
            format!(
                "Cannot read safely from address with base {:?} offset {:?}",
                base, offset
            )
            .as_str(),
        ))
    }

    fn mem_safe_write(
        &self,
        base: Option<AbstractExpression>,
        offset: i64,
    ) -> Result<(), common::MemorySafetyError> {
        match base.clone() {
            Some(AbstractExpression::Abstract(regbase)) => {
                // write to stack
                if regbase == "sp" {
                    return Ok(());
                // Write from static memory
                } else if regbase == "Memory" {
                    //address has to exist
                    if self.memory.get(&(offset)).is_some() {
                        return Ok(());
                    }
                } else {
                    // check if write from memory safe region
                    for region in self.memory_safe_regions.clone() {
                        if region.base.contains(&regbase)
                            && (region.region_type == common::RegionType::WRITE
                                || region.region_type == common::RegionType::RW)
                        {
                            let abs_offset = ast::Int::from_i64(self.context, offset);
                            let base = ast::Int::new_const(self.context, regbase.clone());
                            let abstract_pointer_from_base = ast::Int::new_const(
                                self.context,
                                &*("pointer_".to_owned() + &regbase),
                            );
                            let access = ast::Int::add(self.context, &[&base, &abs_offset]);
                            // pointer = base + index
                            let assignment1 = access.ge(&abstract_pointer_from_base);
                            let assignment2 = access.le(&abstract_pointer_from_base);

                            let lowerbound_value =
                                common::expression_to_ast(self.context, region.start.clone())
                                    .unwrap();
                            let low_access =
                                ast::Int::add(self.context, &[&base, &lowerbound_value]);
                            let upperbound_value =
                                common::expression_to_ast(self.context, region.end.clone())
                                    .unwrap();
                            let up_access =
                                ast::Int::add(self.context, &[&base, &upperbound_value]);
                            let l = access.lt(&low_access);
                            let u = access.gt(&up_access);

                            match self.solver.check_assumptions(&[assignment1, assignment2]) {
                                SatResult::Sat => {
                                    log::info!("Memory safe with solver's first check!");
                                    match (
                                        self.solver.check_assumptions(&[l]),
                                        self.solver.check_assumptions(&[u]),
                                    ) {
                                        (SatResult::Unsat, SatResult::Unsat) => {
                                            log::info!("Memory safe with solver's second check!");
                                            return Ok(());
                                        }
                                        (a, b) => {
                                            println!("impossibility lower bound {:?}, impossibility upper bound {:?}", a, b);
                                            log::error!(
                                                "Memory unsafe with solver's second check!"
                                            );
                                        }
                                    }
                                }
                                _ => log::info!("Memory unsafe with solver first check!"),
                            }
                        }
                    }
                    return Err(common::MemorySafetyError::new(
                        format!(
                            "Writing to address outside allowable memory regions {:?}, {:?}",
                            regbase, offset
                        )
                        .as_str(),
                    ));
                }
            }
            Some(AbstractExpression::Expression(_, _, _)) => {
                let base = base.clone().unwrap();
                for region in self.memory_safe_regions.clone() {
                    if base.contains(&region.base)
                        && (region.region_type == common::RegionType::WRITE
                            || region.region_type == common::RegionType::RW)
                    {
                        // the name of the base of the region
                        let regbase = ast::Int::from_str(self.context, &region.base).unwrap();
                        let abs_offset = ast::Int::from_i64(self.context, offset);

                        //the base of the access (which is a complex expression) and the access itself
                        let base = common::expression_to_ast(self.context, base.clone()).unwrap();
                        let access = ast::Int::add(self.context, &[&base, &abs_offset]);

                        let lowerbound_value =
                            common::expression_to_ast(self.context, region.start.clone()).unwrap();
                        let low_access =
                            ast::Int::add(self.context, &[&regbase, &lowerbound_value]);
                        let upperbound_value =
                            common::expression_to_ast(self.context, region.end.clone()).unwrap();
                        let up_access = ast::Int::add(self.context, &[&regbase, &upperbound_value]);
                        let l = access.lt(&low_access);
                        let u = access.gt(&up_access);

                        match (
                            self.solver.check_assumptions(&[l]),
                            self.solver.check_assumptions(&[u]),
                        ) {
                            (SatResult::Unsat, SatResult::Unsat) => {
                                log::info!("Memory safe with solver's only check!");
                                return Ok(());
                            }
                            (a, b) => {
                                println!("impossibility lower bound {:?}, impossibility upper bound {:?}", a, b);
                                log::error!("Memory unsafe with solver's only check!");
                            }
                        }
                    }
                }
                return Err(common::MemorySafetyError::new(
                    format!(
                        "Writing to address outside allowable memory regions {:?}, {:?}",
                        base, offset
                    )
                    .as_str(),
                ));
            }
            _ => (),
        }
        Err(common::MemorySafetyError::new(
            format!(
                "Cannot write safely to address with base {:?} offset {:?}",
                base, offset
            )
            .as_str(),
        ))
    }
}
