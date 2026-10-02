use crate::computer::*;

fn is_byte_vector(operand: &Operand) -> bool {
    matches!(operand, Operand::Vector(_, _, Arrangement::B16))
}

fn vector_operand_width(operand: &Operand) -> i64 {
    match operand {
        Operand::Vector(_, _, arrangement) | Operand::VectorAccess(_, _, arrangement, _) => {
            arrangement.width()
        }
        _ => 16,
    }
}

fn element_operand_width(operand: &Operand) -> i64 {
    match operand {
        Operand::Vector(_, _, arrangement) | Operand::VectorAccess(_, _, arrangement, _) => {
            arrangement.element_width()
        }
        _ => 1,
    }
}

fn immediate(value: i64) -> RegisterValue {
    RegisterValue {
        kind: RegisterKind::Immediate,
        base: None,
        offset: value,
    }
}

fn indexed_address(
    base: RegisterValue,
    offset: i64,
    mode: Option<bool>,
) -> (RegisterValue, Option<RegisterValue>) {
    let mut shifted = base.clone();
    shifted.offset += offset;
    match mode {
        Some(true) => (base, Some(shifted)),
        Some(false) => (shifted.clone(), Some(shifted)),
        None => (shifted, None),
    }
}

enum Tested {
    Known(i64),
    Symbolic(AbstractExpression),
}

impl ARMCORTEXA {
    fn condition_holds(&self, condition: &str) -> Option<Result<bool, AbstractComparison>> {
        let single = |flag: &Option<FlagValue>, negated: bool| match flag.as_ref()? {
            FlagValue::Real(set) => Some(Ok(*set != negated)),
            FlagValue::Abstract(holds) => Some(Err(if negated {
                holds.clone().not()
            } else {
                holds.clone()
            })),
        };
        let real = |flag: &Option<FlagValue>| match flag {
            Some(FlagValue::Real(set)) => Some(*set),
            _ => None,
        };
        match condition {
            "eq" => single(&self.zero, false),
            "ne" => single(&self.zero, true),
            "cs" | "hs" => single(&self.carry, false),
            "cc" | "lo" => single(&self.carry, true),
            "mi" | "lt" => single(&self.neg, false),
            "pl" | "ge" => single(&self.neg, true),
            "vs" => single(&self.overflow, false),
            "vc" => single(&self.overflow, true),
            "hi" => Some(Ok(real(&self.carry)? && !real(&self.zero)?)),
            "ls" => Some(Ok(!real(&self.carry)? || real(&self.zero)?)),
            "gt" => Some(Ok(!real(&self.zero)? && !real(&self.neg)?)),
            "le" => Some(Ok(real(&self.zero)? || real(&self.neg)?)),
            _ => None,
        }
    }

    fn set_on_condition(
        &mut self,
        dest: &Operand,
        condition: &str,
        value: i64,
    ) -> ExecuteReturnType {
        match self.condition_holds(condition) {
            Some(Ok(holds)) => {
                self.set_register(
                    dest,
                    RegisterKind::Immediate,
                    None,
                    if holds { value } else { 0 },
                );
                ExecuteReturnType::Next
            }
            Some(Err(holds)) => {
                ExecuteReturnType::Select(holds, dest.clone(), immediate(value), immediate(0))
            }
            None => {
                self.set_register(dest, RegisterKind::Number, None, 0);
                ExecuteReturnType::Next
            }
        }
    }

    fn tested_value(&mut self, register: RegisterValue) -> Tested {
        let no_base = register.base.is_none() || register.base == Some(AbstractExpression::Empty);
        match (no_base, register.kind == RegisterKind::Number) {
            (true, false) => Tested::Known(register.offset),
            (true, true) => Tested::Symbolic(AbstractExpression::Abstract(format!(
                "unknown_{}",
                self.next_carry()
            ))),
            (false, _) => Tested::Symbolic(AbstractExpression::Register(Box::new(register))),
        }
    }

    fn indexed_target(
        &mut self,
        base: RegisterValue,
        offset: Option<i64>,
        index: &Option<Box<Operand>>,
        mode: Option<bool>,
    ) -> (RegisterValue, Option<RegisterValue>) {
        let Some(index) = index else {
            return indexed_address(base, offset.unwrap_or(0), mode);
        };
        let (w, reg_num, scale) = match &**index {
            Operand::Memory(w, reg_num, scale, _, _) => (w, reg_num, scale.unwrap_or(0)),
            Operand::Register(w, reg_num) => (w, reg_num, 0),
            _ => panic!("unsupported memory index operand {index:?}"),
        };
        assert!(
            mode.is_none(),
            "register index with pre/post-index writeback is not supported"
        );
        let idx = self.get_register(&Operand::Register(w.clone(), *reg_num));
        let scaled = match scale {
            0 => idx.expression(),
            k => generate_expression(
                "*",
                idx.expression(),
                AbstractExpression::Immediate(1i64 << k),
            ),
        };
        let mut combined = generate_expression("+", base.expression(), scaled);
        if let Some(off) = offset
            && off != 0
        {
            combined = generate_expression("+", combined, AbstractExpression::Immediate(off));
        }
        (
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(combined),
                offset: 0,
            },
            None,
        )
    }

    pub fn execute(
        &mut self,
        pc: usize,
        instruction: &Instruction,
    ) -> Result<ExecuteReturnType, String> {
        let effect = self.plan_lane_effect(instruction);
        let result = self.execute_instruction(pc, instruction);
        if result.is_ok() {
            self.apply_lane_effect(effect);
        }
        result
    }

    fn execute_instruction(
        &mut self,
        pc: usize,
        instruction: &Instruction,
    ) -> Result<ExecuteReturnType, String> {
        match instruction.ty {
            InstructionType::Arithmetic => match instruction.opcode.as_str() {
                "add" => {
                    self.arithmetic("+", |x, y| x + y, instruction.operands.clone());
                }
                "sub" => {
                    self.arithmetic("-", |x, y| x - y, instruction.operands.clone());
                }
                "mul" => {
                    self.arithmetic("*", |x, y| x * y, instruction.operands.clone());
                }
                "and" => {
                    self.arithmetic("&", |x, y| x & y, instruction.operands.clone());
                }
                "orr" => {
                    self.arithmetic("|", |x, y| x | y, instruction.operands.clone());
                }
                "orn" => {
                    self.arithmetic("!|", |x, y: i64| x | !y, instruction.operands.clone());
                }
                "eor" => {
                    self.arithmetic("^", |x, y| x ^ y, instruction.operands.clone());
                }
                "bic" => {
                    self.arithmetic("!&", |x, y: i64| x & !y, instruction.operands.clone());
                }
                "adds" => {
                    self.cmn(&instruction.operands[1], &instruction.operands[2]);
                    self.arithmetic("+", |x, y| x + y, instruction.operands.clone());
                }
                "subs" => {
                    self.cmp(&instruction.operands[1], &instruction.operands[2]);
                    self.arithmetic("-", |x, y| x - y, instruction.operands.clone());
                }
                "ror" | "lsl" | "lsr" => {
                    let mut reg_iter = instruction.operands.iter();

                    let reg0 = reg_iter.next().expect("Need destination register");
                    let reg1 = reg_iter.next().expect("Need first source register");
                    let reg2 = reg_iter.next().expect("Need second source register");

                    self.shift_reg(&instruction.opcode, reg0, reg1, reg2);
                }
                "ands" => {
                    self.tst(&instruction.operands[1], &instruction.operands[2]);
                    self.arithmetic("&", |x, y| x & y, instruction.operands.clone());
                }
                "adc" => match &self.carry {
                    Some(FlagValue::Real(b)) => {
                        if *b {
                            self.arithmetic("+", |x, y| x + y + 1, instruction.operands.clone());
                        } else {
                            self.arithmetic("+", |x, y| x + y, instruction.operands.clone());
                        }
                    }
                    Some(FlagValue::Abstract(c)) => {
                        let c = c.clone();
                        return self.carry_select(
                            "+",
                            |x, y| x + y + 1,
                            |x, y| x + y,
                            &c,
                            &instruction.operands,
                        );
                    }
                    None => todo!("adc reads a carry flag the program never set"),
                },
                "adcs" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let _ = reg_iter.next().expect("Need destination register");
                    let reg1 = reg_iter.next().expect("Need first choice register");
                    let reg2 = reg_iter.next().expect("Need second choice source register");

                    match &self.carry {
                        Some(FlagValue::Real(b)) => {
                            if *b {
                                self.arithmetic(
                                    "+",
                                    |x, y| x + y + 1,
                                    instruction.operands.clone(),
                                );
                                self.cmn(reg1, reg2);
                            } else {
                                self.arithmetic("+", |x, y| x + y, instruction.operands.clone());
                                self.cmn(reg1, reg2);
                            }
                        }
                        Some(FlagValue::Abstract(c)) => {
                            let c = c.clone();
                            self.set_unknown_flags();
                            return self.carry_select(
                                "+",
                                |x, y| x + y + 1,
                                |x, y| x + y,
                                &c,
                                &instruction.operands,
                            );
                        }
                        None => todo!("adcs reads a carry flag the program never set"),
                    }
                }
                "sbc" => match &self.carry {
                    Some(FlagValue::Real(b)) => {
                        if *b {
                            self.arithmetic("-", |x, y| x - y, instruction.operands.clone());
                        } else {
                            self.arithmetic("-", |x, y| x - y - 1, instruction.operands.clone());
                        }
                    }
                    Some(FlagValue::Abstract(c)) => {
                        let c = c.clone();
                        return self.carry_select(
                            "-",
                            |x, y| x - y,
                            |x, y| x - y - 1,
                            &c,
                            &instruction.operands,
                        );
                    }
                    None => todo!("sbc reads a carry flag the program never set"),
                },
                "sbcs" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let _ = reg_iter.next().expect("Need destination register");
                    let reg1 = reg_iter.next().expect("Need first choice register");
                    let reg2 = reg_iter.next().expect("Need second choice source register");

                    match &self.carry {
                        Some(FlagValue::Real(b)) => {
                            if *b {
                                self.arithmetic("-", |x, y| x - y, instruction.operands.clone());
                                self.cmp(reg1, reg2);
                            } else {
                                self.arithmetic(
                                    "-",
                                    |x, y| x - y - 1,
                                    instruction.operands.clone(),
                                );
                                self.cmp(reg1, reg2);
                            }
                        }
                        Some(FlagValue::Abstract(c)) => {
                            let c = c.clone();
                            self.set_unknown_flags();
                            return self.carry_select(
                                "-",
                                |x, y| x - y,
                                |x, y| x - y - 1,
                                &c,
                                &instruction.operands,
                            );
                        }
                        None => todo!("sbcs reads a carry flag the program never set"),
                    }
                }
                "clz" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let reg0 = reg_iter.next().expect("Need register output for clz");
                    let reg1 = reg_iter.next().expect("Need register output for clz");

                    let r1 = self.get_register(reg1);
                    match r1.kind {
                        RegisterKind::Immediate => {
                            let zeros = match reg1 {
                                Operand::Register(RePrefix::W, _) => {
                                    (r1.offset as u32).leading_zeros()
                                }
                                _ => r1.offset.leading_zeros(),
                            };
                            self.set_register(reg0, RegisterKind::Immediate, None, zeros as i64);
                        }
                        _ => {
                            self.set_register(reg0, RegisterKind::Number, None, 0);
                        }
                    }
                }
                "extr" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let reg0 = reg_iter.next().expect("Need register output for extr");
                    let reg1 = reg_iter.next().expect("Need high register for extr");
                    let reg2 = reg_iter.next().expect("Need low register for extr");
                    let lsb = match reg_iter.next() {
                        Some(Operand::Immediate(i)) => *i as u32,
                        _ => panic!("extr needs an immediate lsb"),
                    };

                    let high = self.get_register(reg1);
                    let low = self.get_register(reg2);

                    if high.kind == RegisterKind::Immediate
                        && low.kind == RegisterKind::Immediate
                        && lsb < 64
                    {
                        let value = if lsb == 0 {
                            low.offset
                        } else {
                            (((high.offset as u64) << (64 - lsb)) | ((low.offset as u64) >> lsb))
                                as i64
                        };
                        self.set_register(reg0, RegisterKind::Immediate, None, value);
                    } else {
                        self.set_register(reg0, RegisterKind::Number, None, 0);
                    }
                }
                "umulh" => {
                    let dest = &instruction.operands[0];
                    let left = self.get_register(&instruction.operands[1]);
                    let right = self.get_register(&instruction.operands[2]);
                    let constant = |value: &RegisterValue| {
                        (value.kind == RegisterKind::Immediate && value.base.is_none())
                            .then_some(value.offset)
                    };
                    let region_length_symbols: Vec<String> = self
                        .memory
                        .values()
                        .flat_map(|region| region.get_length().get_abstracts())
                        .collect();
                    let symbolic = |value: &RegisterValue| {
                        let base = value.base.as_ref()?;
                        let symbols = base.get_abstracts();
                        let built_from_region_lengths = !symbols.is_empty()
                            && symbols.iter().all(|s| region_length_symbols.contains(s));
                        (value.kind != RegisterKind::Number && built_from_region_lengths)
                            .then(|| value.expression())
                    };
                    let high_half = |a: i64, b: i64| {
                        (((a as u64 as u128) * (b as u64 as u128)) >> 64) as u64 as i64
                    };
                    match (constant(&left), constant(&right)) {
                        (Some(a), Some(b)) => {
                            self.set_register(dest, RegisterKind::Immediate, None, high_half(a, b));
                        }
                        (Some(factor), None) | (None, Some(factor)) => {
                            let other = if constant(&left).is_some() {
                                &right
                            } else {
                                &left
                            };
                            match symbolic(other) {
                                Some(value) => self.set_register(
                                    dest,
                                    RegisterKind::RegisterBase,
                                    Some(generate_expression(
                                        "umulh",
                                        value,
                                        AbstractExpression::Immediate(factor),
                                    )),
                                    0,
                                ),
                                None => self.set_register(dest, RegisterKind::Number, None, 0),
                            }
                        }
                        (None, None) => self.set_register(dest, RegisterKind::Number, None, 0),
                    }
                }
                "umull" | "smull" | "umaddl" | "smaddl" | "umsubl" | "smsubl" | "umnegl"
                | "smnegl" | "smulh" | "udiv" | "sdiv" | "madd" | "msub" | "mneg" | "asr"
                | "ubfx" | "sbfx" | "ubfiz" | "sbfiz" | "bfi" | "bfxil" | "ubfm" | "sbfm" => {
                    let dest = instruction
                        .operands
                        .first()
                        .expect("Need destination register");
                    self.set_register(dest, RegisterKind::Number, None, 0);
                }
                _ => todo!("Unsupported arithmetic instruction: {:?}", instruction),
            },
            InstructionType::ControlFlow => match instruction.opcode.as_str() {
                "add" => (),
                "adr" => {
                    if let Operand::Address(label, _) = &instruction.operands[1] {
                        let (region, index) = self.label_to_memory_index(label.clone());
                        self.set_register(
                            &instruction.operands[0],
                            RegisterKind::RegisterBase,
                            Some(AbstractExpression::Abstract(region)),
                            index,
                        );
                    } else if let Operand::Label(label) = &instruction.operands[1] {
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
                "adrp" | "ldr" => {
                    if let Operand::Address(label, _) = &instruction.operands[1] {
                        let (region, index) = self.label_to_memory_index(label.clone());
                        self.set_register(
                            &instruction.operands[0],
                            RegisterKind::RegisterBase,
                            Some(AbstractExpression::Abstract(region)),
                            index,
                        );
                    } else {
                        panic!("adrp not invoked correctly with register and label")
                    }
                }
                "cbz" => {
                    let register = self.get_register(&instruction.operands[0]);
                    let Operand::Label(label) = &instruction.operands[1] else {
                        panic!("cbz not invoked correctly with register and label");
                    };
                    return Ok(match self.tested_value(register) {
                        Tested::Known(0) => ExecuteReturnType::JumpLabel(label.to_string()),
                        Tested::Known(_) => ExecuteReturnType::Next,
                        Tested::Symbolic(value) => ExecuteReturnType::ConditionalJumpLabel(
                            AbstractComparison::new("==", AbstractExpression::Immediate(0), value),
                            label.to_string(),
                        ),
                    });
                }
                "cbnz" => {
                    let register = self.get_register(&instruction.operands[0]);
                    let Operand::Label(label) = &instruction.operands[1] else {
                        panic!("cbnz not invoked correctly with register and label");
                    };
                    return Ok(match self.tested_value(register) {
                        Tested::Known(0) => ExecuteReturnType::Next,
                        Tested::Known(_) => ExecuteReturnType::JumpLabel(label.to_string()),
                        Tested::Symbolic(value) => ExecuteReturnType::ConditionalJumpLabel(
                            AbstractComparison::new("!=", AbstractExpression::Immediate(0), value),
                            label.to_string(),
                        ),
                    });
                }
                "tbz" | "tbnz" => {
                    let register = self.get_register(&instruction.operands[0]);
                    let Operand::Immediate(bit) = &instruction.operands[1] else {
                        panic!("{} needs a bit position", instruction.opcode);
                    };
                    let Operand::Label(label) = &instruction.operands[2] else {
                        panic!("{} needs a target label", instruction.opcode);
                    };
                    let jump_when_zero = instruction.opcode == "tbz";
                    let mask = 1i64 << bit;
                    match self.tested_value(register) {
                        Tested::Known(value) => {
                            let bit_set = value & mask != 0;
                            if bit_set != jump_when_zero {
                                return Ok(ExecuteReturnType::JumpLabel(label.to_string()));
                            } else {
                                return Ok(ExecuteReturnType::Next);
                            }
                        }
                        Tested::Symbolic(value) => {
                            let masked = AbstractExpression::Expression(
                                "&".to_string(),
                                Box::new(value),
                                Box::new(AbstractExpression::Immediate(mask)),
                            );
                            let op = if jump_when_zero { "==" } else { "!=" };
                            return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                AbstractComparison::new(
                                    op,
                                    masked,
                                    AbstractExpression::Immediate(0),
                                ),
                                label.to_string(),
                            ));
                        }
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
                            (pc + 1) as i64,
                        );
                        return Ok(ExecuteReturnType::JumpLabel(label.to_string()));
                    } else {
                        panic!("bl not invoked correctly");
                    }
                }
                "b.ne" | "bne" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match &self.zero {
                            Some(flag) => match flag {
                                FlagValue::Real(b) => {
                                    if !b {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                FlagValue::Abstract(s) => {
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                        s.clone().not(),
                                        label.clone(),
                                    ));
                                }
                            },
                            None => {
                                return Err("branch reads a flag the program never set".to_string());
                            }
                        }
                    }
                    panic!("bne not invoked correctly with label");
                }
                "b.eq" | "beq" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match &self.zero {
                            Some(flag) => match flag {
                                FlagValue::Real(b) => {
                                    if *b {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                FlagValue::Abstract(s) => {
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                        s.clone(),
                                        label.clone(),
                                    ));
                                }
                            },
                            None => {
                                return Err("branch reads a flag the program never set".to_string());
                            }
                        }
                    }
                    panic!("beq not invoked correctly with label");
                }
                "bgt" | "bt" | "b.gt" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.neg, &self.overflow) {
                            (Some(zero), Some(neg), Some(ove)) => {
                                match (zero, neg, ove) {
                                    (
                                        FlagValue::Real(z),
                                        FlagValue::Real(n),
                                        FlagValue::Real(_),
                                    ) => {
                                        if !z && !n {
                                            return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                        } else {
                                            return Ok(ExecuteReturnType::Next);
                                        }
                                    }
                                    (FlagValue::Abstract(z), _, _) => {
                                        let expression = generate_comparison(
                                            ">",
                                            *z.left.clone(),
                                            *z.right.clone(),
                                        );
                                        return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                            expression,
                                            label.clone(),
                                        ));
                                    }
                                    (_, _, _) => todo!("branch needs concrete flags"),
                                }
                            }
                            (_, _, _) => {
                                return Err("branch reads a flag the program never set".to_string());
                            }
                        }
                    }
                    panic!("b.gt not invoked correctly with label");
                }
                "b.lt" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.neg, &self.overflow) {
                            (Some(zero), Some(neg), Some(ove)) => {
                                match (zero, neg, ove) {
                                    (
                                        FlagValue::Real(z),
                                        FlagValue::Real(n),
                                        FlagValue::Real(_),
                                    ) => {
                                        if !z && *n {
                                            return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                        } else {
                                            return Ok(ExecuteReturnType::Next);
                                        }
                                    }
                                    (FlagValue::Abstract(z), _, _) => {
                                        let expression = generate_comparison(
                                            "<",
                                            *z.left.clone(),
                                            *z.right.clone(),
                                        );
                                        return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                            expression,
                                            label.clone(),
                                        ));
                                    }
                                    (_, _, _) => todo!("branch needs concrete flags"),
                                }
                            }
                            (_, _, _) => {
                                return Err("branch reads a flag the program never set".to_string());
                            }
                        }
                    }
                }
                "b.ge" | "bge" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.neg, &self.overflow) {
                            (Some(zero), Some(neg), Some(ove)) => match (zero, neg, ove) {
                                (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(_)) => {
                                    if *z || !n {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                (FlagValue::Abstract(z), _, _) => {
                                    let expression = generate_comparison(
                                        ">=",
                                        *z.left.clone(),
                                        *z.right.clone(),
                                    );
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                        expression,
                                        label.clone(),
                                    ));
                                }
                                (_, _, _) => todo!("branch needs concrete flags"),
                            },
                            (_, _, _) => {
                                return Err("branch reads a flag the program never set".to_string());
                            }
                        }
                    }
                }
                "b.ls" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.carry) {
                            (Some(zero), Some(carry)) => {
                                match (zero, carry) {
                                    (FlagValue::Real(z), FlagValue::Real(c)) => {
                                        if *z || !c {
                                            return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                        } else {
                                            return Ok(ExecuteReturnType::Next);
                                        }
                                    }
                                    (_, FlagValue::Abstract(c)) => {
                                        let expression = generate_comparison(
                                            "<=",
                                            *c.left.clone(),
                                            *c.right.clone(),
                                        );
                                        return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                            expression,
                                            label.clone(),
                                        ));
                                    }
                                    (FlagValue::Abstract(z), _) => {
                                        let expression = generate_comparison(
                                            "<=",
                                            *z.left.clone(),
                                            *z.right.clone(),
                                        );
                                        return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                            expression,
                                            label.clone(),
                                        ));
                                    }
                                }
                            }
                            (_, _) => {
                                return Err("branch reads a flag the program never set".to_string());
                            }
                        }
                    }
                    panic!("b.ls not invoked correctly with label");
                }
                "b.hi" | "bhi" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.carry) {
                            (Some(zero), Some(carry)) => match (zero, carry) {
                                (FlagValue::Real(z), FlagValue::Real(c)) => {
                                    if !z && *c {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                (_, FlagValue::Abstract(c)) => {
                                    let expression =
                                        generate_comparison(">", *c.left.clone(), *c.right.clone());
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                        expression,
                                        label.clone(),
                                    ));
                                }
                                (FlagValue::Abstract(z), _) => {
                                    let expression =
                                        generate_comparison(">", *z.left.clone(), *z.right.clone());
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                        expression,
                                        label.clone(),
                                    ));
                                }
                            },
                            (_, _) => {
                                return Err("branch reads a flag the program never set".to_string());
                            }
                        }
                    }
                    panic!("b.hi not invoked correctly with label");
                }
                "b.le" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.neg) {
                            (Some(zero), Some(neg)) => {
                                match (zero, neg) {
                                    (FlagValue::Real(z), FlagValue::Real(n)) => {
                                        if *z || *n {
                                            return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                        } else {
                                            return Ok(ExecuteReturnType::Next);
                                        }
                                    }
                                    (FlagValue::Abstract(z), _) | (_, FlagValue::Abstract(z)) => {
                                        let expression = generate_comparison(
                                            "<=",
                                            *z.left.clone(),
                                            *z.right.clone(),
                                        );
                                        return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                            expression,
                                            label.clone(),
                                        ));
                                    }
                                }
                            }
                            (_, _) => {
                                return Err("branch reads a flag the program never set".to_string());
                            }
                        }
                    }
                    panic!("b.le not invoked correctly with label");
                }
                "b.cs" | "b.hs" | "bcs" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match &self.carry {
                            Some(carry) => match carry {
                                FlagValue::Real(c) => {
                                    if *c {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                FlagValue::Abstract(c) => {
                                    let expression = generate_comparison(
                                        ">=",
                                        *c.left.clone(),
                                        *c.right.clone(),
                                    );
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                        expression,
                                        label.clone(),
                                    ));
                                }
                            },
                            None => {
                                return Err("branch reads a flag the program never set".to_string());
                            }
                        }
                    }
                    panic!("b.cs not invoked correctly");
                }
                "b.cc" | "b.lo" | "blo" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match &self.carry {
                            Some(carry) => match carry {
                                FlagValue::Real(c) => {
                                    if !*c {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                FlagValue::Abstract(c) => {
                                    let expression =
                                        generate_comparison("<", *c.left.clone(), *c.right.clone());
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                        expression,
                                        label.clone(),
                                    ));
                                }
                            },
                            None => {
                                return Err("branch reads a flag the program never set".to_string());
                            }
                        }
                    }
                    panic!("b.cc/lo/blo not invoked correctly");
                }
                "cset" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dest = reg_iter.next().expect("cset register");
                    let register = register_to_tuple(dest);
                    let Operand::Label(cond) = reg_iter.next().expect("cset condition code") else {
                        panic!("not a valid condition code")
                    };

                    match cond.as_str() {
                        "cs" => match self
                            .carry
                            .clone()
                            .expect("cset cs reads a carry flag the program never set")
                        {
                            FlagValue::Real(b) => {
                                self.set_register_from_tuple(
                                    register,
                                    RegisterKind::Immediate,
                                    None,
                                    b as i64,
                                );
                            }
                            FlagValue::Abstract(c) => {
                                return Ok(ExecuteReturnType::Select(
                                    c,
                                    dest.clone(),
                                    immediate(1),
                                    immediate(0),
                                ));
                            }
                        },
                        "cc" | "lo" => {
                            match self
                                .carry
                                .clone()
                                .expect("cset cc reads a carry flag the program never set")
                            {
                                FlagValue::Real(b) => {
                                    self.set_register_from_tuple(
                                        register,
                                        RegisterKind::Immediate,
                                        None,
                                        !b as i64,
                                    );
                                }
                                FlagValue::Abstract(c) => {
                                    return Ok(ExecuteReturnType::Select(
                                        c.not(),
                                        dest.clone(),
                                        immediate(1),
                                        immediate(0),
                                    ));
                                }
                            }
                        }
                        other => return Ok(self.set_on_condition(dest, other, 1)),
                    }
                }
                "csel" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dest = reg_iter.next().expect("cset register");
                    let opt1 = self.get_register(reg_iter.next().expect("csel register"));
                    let opt2 = self.get_register(reg_iter.next().expect("csel register"));
                    let Operand::Label(cond) = reg_iter.next().expect("csel condition code") else {
                        panic!("not a valid condition code")
                    };

                    match cond.as_str() {
                        "cc" | "lo" => {
                            match self
                                .carry
                                .clone()
                                .expect("csel cc reads a carry flag the program never set")
                            {
                                FlagValue::Real(b) => {
                                    if b {
                                        self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                                    } else {
                                        self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                                    }
                                }
                                FlagValue::Abstract(a) => {
                                    return Ok(ExecuteReturnType::Select(
                                        a.not(),
                                        dest.clone(),
                                        opt1,
                                        opt2,
                                    ));
                                }
                            }
                        }
                        "cs" => match self.carry.clone() {
                            Some(FlagValue::Real(b)) => {
                                if b {
                                    self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                                } else {
                                    self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                                }
                            }
                            Some(FlagValue::Abstract(a)) => {
                                return Ok(ExecuteReturnType::Select(a, dest.clone(), opt1, opt2));
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
                        "eq" | "ne" => {
                            match self
                                .zero
                                .clone()
                                .expect("reads a zero flag the program never set")
                            {
                                FlagValue::Real(z) => {
                                    let first = if cond == "ne" { !z } else { z };
                                    if first {
                                        self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                                    } else {
                                        self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                                    }
                                }
                                FlagValue::Abstract(z) => {
                                    let z = if cond == "ne" { z.not() } else { z };
                                    return Ok(ExecuteReturnType::Select(
                                        z,
                                        dest.clone(),
                                        opt1,
                                        opt2,
                                    ));
                                }
                            };
                        }
                        "lt" => match (&self.zero, &self.neg, &self.overflow) {
                            (Some(zero), Some(neg), Some(_)) => match (zero, neg) {
                                (FlagValue::Real(z), FlagValue::Real(n)) => {
                                    if !*z && *n {
                                        self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                                    } else {
                                        self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                                    }
                                }
                                (FlagValue::Abstract(z), _) => {
                                    return Ok(ExecuteReturnType::Select(
                                        generate_comparison("<", *z.left.clone(), *z.right.clone()),
                                        dest.clone(),
                                        opt1,
                                        opt2,
                                    ));
                                }
                                (_, _) => todo!("csel lt needs concrete flags"),
                            },
                            (_, _, _) => {
                                return Err("csel reads a flag the program never set".to_string());
                            }
                        },
                        "gt" => match (&self.zero, &self.neg, &self.overflow) {
                            (Some(zero), Some(neg), Some(_)) => match (zero, neg) {
                                (FlagValue::Real(z), FlagValue::Real(n)) => {
                                    if !*z && !*n {
                                        self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                                    } else {
                                        self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                                    }
                                }
                                (FlagValue::Abstract(z), _) => {
                                    return Ok(ExecuteReturnType::Select(
                                        generate_comparison(">", *z.left.clone(), *z.right.clone()),
                                        dest.clone(),
                                        opt1,
                                        opt2,
                                    ));
                                }
                                (_, _) => todo!("csel gt needs concrete flags"),
                            },
                            (_, _, _) => {
                                return Err("csel reads a flag the program never set".to_string());
                            }
                        },
                        "le" | "ge" => match (&self.zero, &self.neg, &self.overflow) {
                            (Some(zero), Some(neg), Some(_)) => match (zero, neg) {
                                (FlagValue::Real(z), FlagValue::Real(n)) => {
                                    let holds = if cond == "le" { *z || *n } else { *z || !*n };
                                    if holds {
                                        self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                                    } else {
                                        self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                                    }
                                }
                                (FlagValue::Abstract(z), _) => {
                                    let op = if cond == "le" { "<=" } else { ">=" };
                                    return Ok(ExecuteReturnType::Select(
                                        generate_comparison(op, *z.left.clone(), *z.right.clone()),
                                        dest.clone(),
                                        opt1,
                                        opt2,
                                    ));
                                }
                                (_, _) => todo!("csel {cond} needs concrete flags"),
                            },
                            (_, _, _) => {
                                return Err("csel reads a flag the program never set".to_string());
                            }
                        },
                        other => match self.condition_holds(other) {
                            Some(Ok(true)) => {
                                self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                            }
                            Some(Ok(false)) => {
                                self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                            }
                            Some(Err(holds)) => {
                                return Ok(ExecuteReturnType::Select(
                                    holds,
                                    dest.clone(),
                                    opt1,
                                    opt2,
                                ));
                            }
                            None => {
                                self.set_register(dest, RegisterKind::Number, None, 0);
                            }
                        },
                    }
                }
                "csetm" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dest = reg_iter.next().expect("cset register");
                    let Operand::Label(cond) = reg_iter.next().expect("cset condition code") else {
                        panic!("not a valid condition code")
                    };

                    match cond.as_str() {
                        "eq" | "ne" => match self
                            .zero
                            .clone()
                            .expect("reads a zero flag the program never set")
                        {
                            FlagValue::Real(b) => {
                                let holds = if cond == "ne" { !b } else { b };
                                let value = if holds { -1 } else { 0 };
                                self.set_register(dest, RegisterKind::Immediate, None, value);
                            }
                            FlagValue::Abstract(a) => {
                                let a = if cond == "ne" { a.not() } else { a };
                                return Ok(ExecuteReturnType::Select(
                                    a,
                                    dest.clone(),
                                    immediate(-1),
                                    immediate(0),
                                ));
                            }
                        },
                        other => return Ok(self.set_on_condition(dest, other, -1)),
                    }
                }
                "mov" | "movz" | "movk" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let reg0 = reg_iter.next().expect("Need register output for mov");
                    let reg1 = reg_iter.next().expect("Need register output for mov");

                    let r1 = self.get_register(reg1);

                    self.set_register(reg0, r1.kind, r1.base, r1.offset);
                }
                "mrs" => {
                    let dest = instruction
                        .operands
                        .first()
                        .expect("mrs needs a destination register");
                    self.set_register(dest, RegisterKind::Number, None, 0);
                }
                op if op.starts_with("b.") => {
                    let Some(Operand::Label(label)) = instruction.operands.first() else {
                        panic!("{op} needs a target label");
                    };
                    return Ok(match self.condition_holds(&op[2..]) {
                        Some(Ok(true)) => ExecuteReturnType::JumpLabel(label.clone()),
                        Some(Ok(false)) => ExecuteReturnType::Next,
                        Some(Err(condition)) => {
                            ExecuteReturnType::ConditionalJumpLabel(condition, label.clone())
                        }
                        None => ExecuteReturnType::ConditionalJumpLabel(
                            AbstractComparison::new(
                                "==",
                                fresh_unknown(),
                                AbstractExpression::Immediate(0),
                            ),
                            label.clone(),
                        ),
                    });
                }
                "cinv" | "cinc" | "cneg" | "csinv" | "csinc" | "csneg" => {
                    let dest = instruction
                        .operands
                        .first()
                        .expect("conditional operation needs a destination");
                    self.set_register(dest, RegisterKind::Number, None, 0);
                }
                "ccmp" | "ccmn" => self.set_unknown_flags(),
                _ => todo!(
                    "control flow instruction not yet implemented {:?}",
                    instruction
                ),
            },
            InstructionType::Memory => match instruction.opcode.as_str() {
                "ldr" | "ldrb" | "ldrh" | "ldur" | "ldurb" | "ldurh" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("ldr dst");
                    let src_addr = reg_iter.next().expect("ldr src");

                    match src_addr {
                        Operand::Memory(w, reg_num, offset, index, mode) => {
                            let base = self
                                .get_register(&Operand::Register(w.clone(), *reg_num))
                                .clone();
                            let (address, writeback) =
                                self.indexed_target(base, *offset, index, *mode);

                            let width = access_width(&instruction.opcode, dst);
                            let res = self.load(dst.clone(), address, width);
                            if let Err(e) = res {
                                return Err(e.to_string());
                            }

                            if let Some(updated) = writeback {
                                self.set_register(
                                    &Operand::Register(w.clone(), *reg_num),
                                    updated.kind,
                                    updated.base,
                                    updated.offset,
                                );
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
                        Operand::Memory(w, reg_num, offset, index, mode) => {
                            let base = self
                                .get_register(&Operand::Register(w.clone(), *reg_num))
                                .clone();
                            let (address, writeback) =
                                self.indexed_target(base, *offset, index, *mode);

                            let width = access_width(&instruction.opcode, dst1);
                            let mut second = address.clone();
                            second.offset += width;
                            let res1 = self.load(dst1.clone(), address, width);
                            let res2 = self.load(dst2.clone(), second, width);
                            if let Err(e) = res1 {
                                return Err(e.to_string());
                            }
                            if let Err(e) = res2 {
                                return Err(e.to_string());
                            }

                            if let Some(updated) = writeback {
                                self.set_register(
                                    &Operand::Register(w.clone(), *reg_num),
                                    updated.kind,
                                    updated.base,
                                    updated.offset,
                                );
                            }
                        }
                        _ => {
                            panic!("ldr not with correct syntax for memory operand");
                        }
                    }
                }
                "str" | "strb" | "strh" | "stur" | "sturb" | "sturh" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("ldr dst");
                    let src_addr = reg_iter.next().expect("ldr src");

                    match src_addr {
                        Operand::Memory(w, reg_num, offset, index, mode) => {
                            let base = self
                                .get_register(&Operand::Register(w.clone(), *reg_num))
                                .clone();
                            let (address, writeback) =
                                self.indexed_target(base, *offset, index, *mode);

                            let width = access_width(&instruction.opcode, dst);
                            let res = self.store(dst.clone(), address, width);
                            if let Err(e) = res {
                                return Err(e.to_string());
                            }

                            if let Some(updated) = writeback {
                                self.set_register(
                                    &Operand::Register(w.clone(), *reg_num),
                                    updated.kind,
                                    updated.base,
                                    updated.offset,
                                );
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
                        Operand::Memory(w, reg_num, offset, index, mode) => {
                            let base = self
                                .get_register(&Operand::Register(w.clone(), *reg_num))
                                .clone();
                            let (address, writeback) =
                                self.indexed_target(base, *offset, index, *mode);

                            let width = access_width(&instruction.opcode, dst1);
                            let mut second = address.clone();
                            second.offset += width;
                            let res1 = self.store(dst1.clone(), address, width);
                            let res2 = self.store(dst2.clone(), second, width);
                            if let Err(e) = res1 {
                                return Err(e.to_string());
                            }
                            if let Err(e) = res2 {
                                return Err(e.to_string());
                            }

                            if let Some(updated) = writeback {
                                self.set_register(
                                    &Operand::Register(w.clone(), *reg_num),
                                    updated.kind,
                                    updated.base,
                                    updated.offset,
                                );
                            }
                        }
                        _ => {
                            panic!("ldr not with correct syntax for memory operand");
                        }
                    }
                }
                _ => todo!("memory instruction not supported yet {:?}", instruction),
            },
            InstructionType::SIMDArithmetic
                if matches!(instruction.opcode.as_str(), "orr" | "bic" | "and" | "eor")
                    && instruction
                        .operands
                        .iter()
                        .skip(1)
                        .any(|op| matches!(op, Operand::Immediate(_))) =>
            {
                let dst = instruction
                    .operands
                    .first()
                    .expect("Need destination register");
                self.set_register(dst, RegisterKind::Number, None, 0);
            }
            InstructionType::SIMDArithmetic => match instruction.opcode.as_str() {
                "rev64" | "rev64.16b" | "rev64.8h" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dest_op = reg_iter.next().expect("rev64 dst");
                    let mut result = self.get_simd_register(dest_op);
                    let dest = &mut result;
                    let src = self.get_simd_register(reg_iter.next().expect("rev64 src"));

                    match dest_op {
                        Operand::Vector(_, _, arr) => match arr {
                            Arrangement::H8 => {
                                for i in 0..8 {
                                    let (base, offset) = src.get_halfword(7 - i);
                                    dest.set_halfword(i, base, offset);
                                }
                            }
                            Arrangement::B16 => {
                                for i in 0..16 {
                                    let (base, offset) = src.get_byte(15 - i);
                                    dest.set_byte(i, base, offset);
                                }
                            }
                            _ => *dest = SimdRegister::default(),
                        },
                        Operand::VectorRegister(_, _) => {
                            let arr = instruction.opcode.split(".").collect::<Vec<&str>>()[1];
                            match arr {
                                "16b" => {
                                    dest.kind = src.kind.clone();
                                    for i in 0..16 {
                                        let (base, offset) = src.get_byte(15 - i);
                                        dest.set_byte(i, base, offset);
                                    }
                                }
                                "8h" => {
                                    for i in 0..8 {
                                        let (base, offset) = src.get_halfword(7 - i);
                                        dest.set_halfword(i, base, offset);
                                    }
                                }
                                _ => todo!("support arr in rav1d for rev64"),
                            }
                        }
                        a => todo!("unsupported operand in simd rev64 {:?}", a),
                    }
                    self.set_simd_register(dest_op, result);
                }
                "mov" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dest = reg_iter.next().expect("mov dst");
                    let src = self.get_simd_register(reg_iter.next().expect("mov src"));
                    self.set_simd_register(dest, src);
                }
                "tbl" => {
                    let dest = instruction.operands.first().expect("tbl dst");
                    self.set_simd_register(dest, SimdRegister::default());
                }
                "not" | "mvn" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dest = reg_iter.next().expect("not dst");
                    let src = self.get_simd_register(reg_iter.next().expect("not src"));
                    let lanes = vector_operand_width(dest) as usize;
                    let mut result = SimdRegister::default();
                    for i in 0..lanes {
                        let (_, byte) = src.get_byte(i);
                        result.set_byte(i, None, !byte);
                    }
                    self.set_simd_register(dest, result);
                }
                "ushr" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dest = reg_iter.next().expect("ushr dst");
                    let src = self.get_simd_register(reg_iter.next().expect("ushr src"));
                    let Some(Operand::Immediate(shift)) = reg_iter.next() else {
                        todo!("ushr by a register")
                    };
                    let mut result = SimdRegister::default();
                    if is_byte_vector(dest) && *shift < 8 {
                        for i in 0..16 {
                            let (_, byte) = src.get_byte(i);
                            result.set_byte(i, None, byte >> shift);
                        }
                    }
                    self.set_simd_register(dest, result);
                }
                "ext" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dest = reg_iter.next().expect("ext dst");
                    let low = self.get_simd_register(reg_iter.next().expect("ext low source"));
                    let high = self.get_simd_register(reg_iter.next().expect("ext high source"));
                    let Some(Operand::Immediate(index)) = reg_iter.next() else {
                        todo!("ext without an immediate index")
                    };
                    let index = *index as usize;
                    let mut result = SimdRegister::default();
                    if is_byte_vector(dest) && index < 16 {
                        for i in 0..16 {
                            let (base, byte) = if index + i < 16 {
                                low.get_byte(index + i)
                            } else {
                                high.get_byte(index + i - 16)
                            };
                            result.set_byte(i, base, byte);
                        }
                    }
                    self.set_simd_register(dest, result);
                }
                "and" => {
                    self.vector_arithmetic(
                        "&",
                        |x, y| x & y,
                        |x, y| x & y,
                        |x, y| x & y,
                        |x, y| x & y,
                        instruction,
                    );
                }
                "add" => {
                    self.vector_arithmetic(
                        "+",
                        |x, y| x.wrapping_add(y),
                        |x, y| x.wrapping_add(y),
                        |x, y| x.wrapping_add(y),
                        |x, y| x.wrapping_add(y),
                        instruction,
                    );
                }
                "orr" => {
                    self.vector_arithmetic(
                        "|",
                        |x, y| x | y,
                        |x, y| x | y,
                        |x, y| x | y,
                        |x, y| x | y,
                        instruction,
                    );
                }
                "eor" => {
                    self.vector_arithmetic(
                        "^",
                        |x, y| x ^ y,
                        |x, y| x ^ y,
                        |x, y| x ^ y,
                        |x, y| x ^ y,
                        instruction,
                    );
                }
                "mul" => {
                    self.vector_arithmetic(
                        "*",
                        |x, y| x.wrapping_mul(y),
                        |x, y| x.wrapping_mul(y),
                        |x, y| x.wrapping_mul(y),
                        |x, y| x.wrapping_mul(y),
                        instruction,
                    );
                }
                "sub" => {
                    self.vector_arithmetic(
                        "-",
                        |x, y| x.wrapping_sub(y),
                        |x, y| x.wrapping_sub(y),
                        |x, y| x.wrapping_sub(y),
                        |x, y| x.wrapping_sub(y),
                        instruction,
                    );
                }
                "shl" | "sli" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("Need destination register");
                    let old_reg = self.get_simd_register(dst);
                    let mut dst_reg = SimdRegister::default();
                    let src_name = reg_iter.next().expect("need src register shl");
                    let src_reg = self.get_simd_register(src_name);

                    let Operand::Vector(_, _, arr) = src_name else {
                        panic!("need appropriate vector notation for shl")
                    };
                    let Operand::Immediate(shift) = reg_iter.next().expect("Need shift amount")
                    else {
                        panic!("cannot call shl without a shift amount")
                    };
                    let small_shift = u32::try_from(*shift).expect("shift shoudl fit into u32");
                    let insert = instruction.opcode == "sli";

                    match arr {
                        Arrangement::B16 | Arrangement::B8 | Arrangement::B => {
                            let lanes = match arr {
                                Arrangement::B16 => 16,
                                Arrangement::B8 => 8,
                                _ => 1,
                            };
                            for i in 0..lanes {
                                let (base, offset) = src_reg.get_byte(i);
                                let mut value = offset.wrapping_shl(small_shift);
                                if insert {
                                    let (_, old) = old_reg.get_byte(i);
                                    value |= old & !u8::MAX.wrapping_shl(small_shift);
                                }
                                dst_reg.set_byte(i, base, value);
                            }
                        }
                        Arrangement::H8 | Arrangement::H4 | Arrangement::H => {
                            let lanes = match arr {
                                Arrangement::H8 => 8,
                                Arrangement::H4 => 4,
                                _ => 1,
                            };
                            for i in 0..lanes {
                                let (bases, offsets) = src_reg.get_halfword(i);
                                let mut value =
                                    u16::from_be_bytes(offsets).wrapping_shl(small_shift);
                                if insert {
                                    let (_, old) = old_reg.get_halfword(i);
                                    value |= u16::from_be_bytes(old)
                                        & !u16::MAX.wrapping_shl(small_shift);
                                }
                                dst_reg.set_halfword(i, bases, value.to_be_bytes());
                            }
                        }
                        Arrangement::S4 | Arrangement::S2 | Arrangement::S => {
                            let lanes = match arr {
                                Arrangement::S4 => 4,
                                Arrangement::S2 => 2,
                                _ => 1,
                            };
                            for i in 0..lanes {
                                let (bases, offsets) = src_reg.get_word(i);
                                let mut value =
                                    u32::from_be_bytes(offsets).wrapping_shl(small_shift);
                                if insert {
                                    let (_, old) = old_reg.get_word(i);
                                    value |= u32::from_be_bytes(old)
                                        & !u32::MAX.wrapping_shl(small_shift);
                                }
                                dst_reg.set_word(i, bases, value.to_be_bytes());
                            }
                        }
                        Arrangement::D2 | Arrangement::D => {
                            let lanes = if *arr == Arrangement::D2 { 2 } else { 1 };
                            for i in 0..lanes {
                                let (bases, offsets) = src_reg.get_double(i);
                                let mut value =
                                    u64::from_be_bytes(offsets).wrapping_shl(small_shift);
                                if insert {
                                    let (_, old) = old_reg.get_double(i);
                                    value |= u64::from_be_bytes(old)
                                        & !u64::MAX.wrapping_shl(small_shift);
                                }
                                dst_reg.set_double(i, bases, value.to_be_bytes());
                            }
                        }
                        _ => todo!("unsupported shl vector type"),
                    }

                    self.set_simd_register(dst, dst_reg);
                }
                "aese" | "aesmc" | "aesd" | "aesimc" | "movi" | "dup" | "sshr" | "pmull"
                | "pmull2" | "zip1" | "zip2" | "trn1" | "trn2" | "bit" | "bif" | "uaddl"
                | "uaddl2" | "sqrshrun" | "sqrshrun2" | "umull" | "umull2" | "umlal" | "umlal2"
                | "rshrn" | "rshrn2" | "rev32" | "mls" | "mla" | "sqrdmulh" | "sqdmulh"
                | "smlal" | "smlal2" | "smlsl" | "smlsl2" | "smull" | "smull2" | "uzp1"
                | "uzp2" | "srshr" | "uaddlv" | "umaxv" | "cmgt" | "cmge" | "cmle" | "cmhi"
                | "cnt" | "xtn" | "shrn" | "ushl" | "ushll" | "ushll2" | "sshll" | "sshll2"
                | "abs" | "umin" | "bic" | "eor3" | "bcax" | "rax1" | "xar" | "sri" | "usra"
                | "fcsel" | "ssra" | "uaddlp" | "saddlp" | "uadalp" | "sadalp" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("Need destination register");
                    self.set_register(dst, RegisterKind::Number, None, 0);
                }
                a => todo!("simd arithmetic instruction not supported yet {:?}", a),
            },
            InstructionType::SIMDManagement => match instruction.opcode.as_str() {
                "ld1r" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("Need destination register");
                    if let Some(Operand::Memory(prefix, num, offset, reg_offset, index)) =
                        reg_iter.next()
                    {
                        let a = self.get_register(&Operand::Register(prefix.clone(), *num));

                        let element = element_operand_width(dst);
                        if let Err(e) = self.load_vector(dst.clone(), a.clone(), element) {
                            return Err(e.to_string());
                        }

                        if *index == Some(true)
                            && let Some(off) = offset
                        {
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind.clone(),
                                a.base.clone(),
                                a.offset + off,
                            );
                        }

                        if let Some(step) = reg_offset {
                            let step = self.get_register(step);
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind,
                                generate_expression_from_options("+", a.base, step.base),
                                a.offset + step.offset,
                            );
                        }
                    }
                }
                "ld4r" => {
                    let mut destinations = Vec::new();
                    let mut addr = None;
                    for o in instruction.operands.iter() {
                        match o {
                            Operand::Vector(..) | Operand::VectorAccess(..) => destinations.push(o),
                            Operand::Memory(..) => addr = Some(o),
                            _ => panic!("not a valid operand for instruction ld4r"),
                        }
                    }

                    if let Some(Operand::Memory(prefix, num, offset, reg_offset, index)) = addr {
                        let a = self.get_register(&Operand::Register(prefix.clone(), *num));
                        let mut address = a.clone();
                        for d in &destinations {
                            let elem = element_operand_width(d);
                            if let Err(e) = self.load_vector((*d).clone(), address.clone(), elem) {
                                return Err(e.to_string());
                            }
                            address.offset += elem;
                        }

                        if *index == Some(true)
                            && let Some(off) = offset
                        {
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind.clone(),
                                a.base.clone(),
                                a.offset + off,
                            );
                        }

                        if let Some(step) = reg_offset {
                            let step = self.get_register(step);
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind,
                                generate_expression_from_options("+", a.base, step.base),
                                a.offset + step.offset,
                            );
                        }
                    } else {
                        panic!("ld4r does not include address {:?}", instruction)
                    };
                }
                "ld1" | "ld1.16b" | "ld1.8h" | "ld2" | "ld3" | "ld4" => {
                    let mut destinations = Vec::new();
                    let mut addr = None;
                    for o in instruction.operands.iter() {
                        match o {
                            Operand::Vector(..) | Operand::VectorAccess(..) => destinations.push(o),
                            Operand::VectorRegister(..) => addr = Some(o),
                            Operand::Memory(..) => addr = Some(o),
                            _ => panic!("not a valid operand for instruction ld1"),
                        }
                    }

                    if let Some(Operand::Memory(prefix, num, offset, reg_offset, index)) = addr {
                        let a = self.get_register(&Operand::Register(prefix.clone(), *num));
                        let mut address = a.clone();
                        for d in destinations {
                            let width = vector_operand_width(d);
                            if let Err(e) = self.load_vector(d.clone(), address.clone(), width) {
                                return Err(e.to_string());
                            }
                            address.offset += width;
                        }
                        if matches!(instruction.opcode.as_str(), "ld2" | "ld3" | "ld4") {
                            for d in instruction.operands.iter().filter(|o| {
                                matches!(o, Operand::Vector(..) | Operand::VectorAccess(..))
                            }) {
                                self.set_register(d, RegisterKind::Number, None, 0);
                            }
                        }

                        if *index == Some(true)
                            && let Some(off) = offset
                        {
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind.clone(),
                                a.base.clone(),
                                a.offset + off,
                            );
                        }

                        if let Some(step) = reg_offset {
                            let step = self.get_register(step);
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind,
                                generate_expression_from_options("+", a.base, step.base),
                                a.offset + step.offset,
                            );
                        }
                    } else {
                        panic!("ld1 does not include address {:?}", instruction)
                    };
                }
                "st1" | "st1.d" | "st2" | "st3" | "st4" => {
                    let mut sources = Vec::new();
                    let mut addr = None;
                    for o in instruction.operands.iter() {
                        match o {
                            Operand::Vector(..) | Operand::VectorAccess(..) => sources.push(o),
                            Operand::Memory(..) => addr = Some(o),
                            _ => panic!("not a valid operand for instruction st1"),
                        }
                    }

                    if let Some(Operand::Memory(prefix, num, num_offset, reg_offset, indexing)) =
                        addr
                    {
                        let a = self.get_register(&Operand::Register(prefix.clone(), *num));
                        let mut address = a.clone();
                        for d in sources {
                            let width = vector_operand_width(d);
                            if let Err(e) = self.store_vector(d.clone(), address.clone(), width) {
                                return Err(e.to_string());
                            }
                            address.offset += width;
                        }

                        if *indexing == Some(true)
                            && let Some(i) = num_offset
                        {
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind.clone(),
                                a.base.clone(),
                                a.offset + i,
                            );
                        };

                        if let Some(reg) = reg_offset {
                            let step = self.get_register(reg);
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind,
                                generate_expression_from_options("+", a.base, step.base),
                                a.offset + step.offset,
                            );
                        };
                    } else {
                        panic!("str1 does not include address {:?}", instruction);
                    };
                }
                "movi" | "mov" | "fmov" | "aese" | "dup" | "ins" | "umov" | "smov" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("Need destination register");
                    self.set_register(dst, RegisterKind::Number, None, 0);
                }
                "mul" | "mla" | "mls" | "sqrdmulh" | "sqdmulh" | "smull" | "smull2" | "smlal"
                | "smlal2" | "smlsl" | "smlsl2" | "umull" | "umull2" | "umlal" | "umlal2" => {
                    let dst = instruction
                        .operands
                        .first()
                        .expect("Need destination register");
                    self.set_register(dst, RegisterKind::Number, None, 0);
                }
                a => todo!("simd instruction {} not supported yet", a),
            },
            InstructionType::Other => match instruction.opcode.as_str() {
                "nop" => {}
                "cmp" => {
                    self.cmp(&instruction.operands[0], &instruction.operands[1]);
                }
                "cmn" => {
                    self.cmn(&instruction.operands[0], &instruction.operands[1]);
                }
                "tst" => {
                    self.tst(&instruction.operands[0], &instruction.operands[1]);
                }
                "ret" => {
                    let x30 = self.get_register(&Operand::Register(RePrefix::X, 30));
                    match x30.kind {
                        RegisterKind::RegisterBase => {
                            if let Some(AbstractExpression::Abstract(address)) = x30.base {
                                if address == "return" && x30.offset == 0 {
                                    return Ok(ExecuteReturnType::JumpLabel("return".to_string()));
                                } else {
                                    return Ok(ExecuteReturnType::JumpLabel(address.to_string()));
                                }
                            }
                            return Ok(ExecuteReturnType::JumpAddress(
                                x30.offset
                                    .try_into()
                                    .expect("ret: return address must be non-negative"),
                            ));
                        }
                        RegisterKind::Immediate => {
                            return Ok(ExecuteReturnType::JumpAddress(
                                x30.offset
                                    .try_into()
                                    .expect("ret: return address must be non-negative"),
                            ));
                        }
                        RegisterKind::Number => {
                            return Ok(ExecuteReturnType::JumpLabel("return".to_string()));
                        }
                    }
                }
                "mov" | "movz" | "movk" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let reg0 = reg_iter.next().expect("Need register output for mov");
                    let reg1 = reg_iter.next().expect("Need register output for mov");

                    let mut r1 = self.get_register(reg1);
                    let mut shift = 0;

                    if let Some(a) = reg_iter.next() {
                        match a {
                            Operand::Bitwise(op, s) => {
                                shift = *s;
                                r1 = instruction_aux::shift_imm(op.to_string(), r1, *s);
                            }
                            other => todo!("unsupported trailing operand {other:?}"),
                        }
                    }

                    if instruction.opcode == "movk" {
                        let r0 = self.get_register(reg0);
                        r1 = if r0.kind == RegisterKind::Immediate
                            && r1.kind == RegisterKind::Immediate
                        {
                            RegisterValue {
                                kind: RegisterKind::Immediate,
                                base: None,
                                offset: (r0.offset & !(0xffff << shift)) | r1.offset,
                            }
                        } else {
                            RegisterValue {
                                kind: RegisterKind::Number,
                                base: None,
                                offset: 0,
                            }
                        };
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
                "neg" | "mvn" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let reg0 = reg_iter.next().expect("Need register output for neg");
                    let reg1 = reg_iter.next().expect("Need register input for neg");

                    let mut r1 = self.get_register(reg1);

                    if let Some(base) = r1.base {
                        r1.base = Some(generate_expression(
                            "-",
                            AbstractExpression::Immediate(0),
                            base,
                        ));
                    }

                    r1.offset = if instruction.opcode == "mvn" {
                        !r1.offset
                    } else {
                        r1.offset.wrapping_neg()
                    };
                    self.set_register(reg0, r1.kind, r1.base, r1.offset);
                }
                "ngc" | "ngcs" | "negs" => {
                    let dest = instruction
                        .operands
                        .first()
                        .expect("Need destination register");
                    self.set_register(dest, RegisterKind::Number, None, 0);
                    if instruction.opcode.ends_with('s') {
                        self.set_unknown_flags();
                    }
                }
                _ => todo!("other instruction not implemented yet {:?}", instruction),
            },
            _ => panic!(
                "instruction reached the executor with a non-executable type: {:?}",
                instruction
            ),
        }

        Ok(ExecuteReturnType::Next)
    }
}
