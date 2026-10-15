use crate::computer::*;

fn immediate(value: i64) -> RegisterValue {
    RegisterValue {
        kind: RegisterKind::Immediate,
        base: None,
        offset: value,
    }
}

fn signed_sides(
    zero: &FlagValue,
    neg: &FlagValue,
) -> Option<(AbstractExpression, AbstractExpression)> {
    match (neg, zero) {
        (FlagValue::Abstract(n), _) => Some((*n.left.clone(), *n.right.clone())),
        (_, FlagValue::Abstract(z)) => Some((*z.left.clone(), *z.right.clone())),
        _ => None,
    }
}

fn permuted(opcode: &str, word: bool, value: u64) -> u64 {
    let per_half =
        |f: &dyn Fn(u32) -> u32| ((f((value >> 32) as u32) as u64) << 32) | f(value as u32) as u64;
    let swap_halfword_bytes = |x: u32| ((x & 0x00ff_00ff) << 8) | ((x >> 8) & 0x00ff_00ff);
    match (opcode, word) {
        ("rev", true) => (value as u32).swap_bytes() as u64,
        ("rev", false) => value.swap_bytes(),
        ("rev32", _) => per_half(&|x| x.swap_bytes()),
        ("rev16", true) => swap_halfword_bytes(value as u32) as u64,
        ("rev16", false) => per_half(&swap_halfword_bytes),
        ("rbit", true) => (value as u32).reverse_bits() as u64,
        _ => value.reverse_bits(),
    }
}

fn changed(value: RegisterValue, change: &str) -> RegisterValue {
    if value.kind == RegisterKind::Number {
        return value;
    }
    let negated = |base: Option<AbstractExpression>| {
        base.map(|b| generate_expression("-", AbstractExpression::Immediate(0), b))
    };
    match change {
        "inc" => RegisterValue {
            offset: value.offset.wrapping_add(1),
            ..value
        },
        "inv" => RegisterValue {
            base: negated(value.base),
            offset: !value.offset,
            ..value
        },
        _ => RegisterValue {
            base: negated(value.base),
            offset: value.offset.wrapping_neg(),
            ..value
        },
    }
}

enum Tested {
    Known(i64),
    Symbolic(AbstractExpression),
}

impl ARMCORTEXA {
    fn set_label_address(&mut self, register: &Operand, label: &str) {
        match self.label_to_memory_index(label) {
            Some((region, index)) => self.set_register(
                register,
                RegisterKind::RegisterBase,
                Some(AbstractExpression::Abstract(region)),
                index,
            ),
            None => self.set_register(register, RegisterKind::Number, None, 0),
        }
    }

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
            "hi" | "ls" => match (real(&self.carry), real(&self.zero)) {
                (Some(c), Some(z)) => Some(Ok((c && !z) == (condition == "hi"))),
                _ => {
                    let (left, right) = self.unsigned_order()?;
                    let op = if condition == "hi" { ">" } else { "<=" };
                    Some(Err(AbstractComparison::new(op, left, right)))
                }
            },
            "gt" => Some(Ok(!real(&self.zero)? && !real(&self.neg)?)),
            "le" => Some(Ok(real(&self.zero)? || real(&self.neg)?)),
            _ => None,
        }
    }

    pub(crate) fn field_of_unknown(
        &mut self,
        value: RegisterValue,
        width: i64,
        signed: bool,
    ) -> RegisterValue {
        if value.kind != RegisterKind::Number || !(1..=62).contains(&width) {
            return value;
        }
        let (low, high) = if signed {
            (-(1i64 << (width - 1)), (1i64 << (width - 1)) - 1)
        } else {
            (0, (1i64 << width) - 1)
        };
        let name = self.fresh_symbol("field");
        let bounded = generate_expression(
            "atmost",
            generate_expression(
                "atleast",
                AbstractExpression::Abstract(name),
                AbstractExpression::Immediate(low),
            ),
            AbstractExpression::Immediate(high),
        );
        RegisterValue::new(RegisterKind::RegisterBase, Some(bounded), 0)
    }

    fn unsigned_order(&self) -> Option<(AbstractExpression, AbstractExpression)> {
        let (Some(FlagValue::Abstract(carry)), Some(FlagValue::Abstract(_))) =
            (&self.carry, &self.zero)
        else {
            return None;
        };
        let widened = |e: &AbstractExpression| {
            matches!(e, AbstractExpression::Expression(op, _, width)
                if op == "zext" && **width == AbstractExpression::Immediate(64))
        };
        (carry.op == ">=" && widened(&carry.left) && widened(&carry.right))
            .then(|| (*carry.left.clone(), *carry.right.clone()))
    }

    fn unsigned_extreme(
        &self,
        dest: &Operand,
        opt1: &RegisterValue,
        opt2: &RegisterValue,
        cond: &str,
    ) -> Option<AbstractExpression> {
        if !matches!(dest, Operand::Register(RePrefix::W, _)) || !matches!(cond, "hi" | "ls") {
            return None;
        }
        let (left, right) = self.unsigned_order()?;
        let compared = |e: &AbstractExpression| match e {
            AbstractExpression::Expression(_, inner, _) => match inner.as_ref() {
                AbstractExpression::Register(r) => Some((**r).clone()),
                _ => None,
            },
            _ => None,
        };
        let (left, right) = (compared(&left)?, compared(&right)?);
        let in_order = *opt1 == left && *opt2 == right;
        if !in_order && !(*opt1 == right && *opt2 == left) {
            return None;
        }
        if opt1.kind == RegisterKind::Number || opt2.kind == RegisterKind::Number {
            return None;
        }
        let extreme = if in_order == (cond == "ls") {
            "atmost"
        } else {
            "atleast"
        };
        Some(generate_expression(
            extreme,
            instruction_aux::full_value(opt1),
            instruction_aux::full_value(opt2),
        ))
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

    fn conditional_select(
        &mut self,
        dest: &Operand,
        opt1: RegisterValue,
        opt2: RegisterValue,
        cond: &str,
    ) -> Result<ExecuteReturnType, String> {
        if let Some(extreme) = self.unsigned_extreme(dest, &opt1, &opt2, cond) {
            self.set_register(dest, RegisterKind::RegisterBase, Some(extreme), 0);
            return Ok(ExecuteReturnType::Next);
        }
        match cond {
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
                        return Ok(ExecuteReturnType::Select(a.not(), dest.clone(), opt1, opt2));
                    }
                }
            }
            "cs" | "hs" => match self.carry.clone() {
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
                        return Ok(ExecuteReturnType::Select(z, dest.clone(), opt1, opt2));
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
                    (zero, neg) => {
                        let Some((left, right)) = signed_sides(zero, neg) else {
                            todo!("csel lt needs concrete flags")
                        };
                        return Ok(ExecuteReturnType::Select(
                            generate_comparison("<", left, right),
                            dest.clone(),
                            opt1,
                            opt2,
                        ));
                    }
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
                    (zero, neg) => {
                        let Some((left, right)) = signed_sides(zero, neg) else {
                            todo!("csel gt needs concrete flags")
                        };
                        return Ok(ExecuteReturnType::Select(
                            generate_comparison(">", left, right),
                            dest.clone(),
                            opt1,
                            opt2,
                        ));
                    }
                },
                (_, _, _) => {
                    return Err("csel reads a flag the program never set".to_string());
                }
            },
            "le" | "ge" => {
                let (Some(zero), Some(neg)) = (&self.zero, &self.neg) else {
                    return Err("csel reads a flag the program never set".to_string());
                };
                let taken = match (cond, zero, neg) {
                    ("le", FlagValue::Real(z), FlagValue::Real(n)) => Some(*z || *n),
                    ("ge", _, FlagValue::Real(n)) => Some(!n),
                    _ => None,
                };
                match (taken, zero) {
                    (Some(true), _) => self.set_register(dest, opt1.kind, opt1.base, opt1.offset),
                    (Some(false), _) => self.set_register(dest, opt2.kind, opt2.base, opt2.offset),
                    (None, _) if signed_sides(zero, neg).is_some() => {
                        let Some((left, right)) = signed_sides(zero, neg) else {
                            unreachable!()
                        };
                        let op = if cond == "le" { "<=" } else { ">=" };
                        return Ok(ExecuteReturnType::Select(
                            generate_comparison(op, left, right),
                            dest.clone(),
                            opt1,
                            opt2,
                        ));
                    }
                    (_, _) => todo!("csel {cond} needs concrete flags"),
                }
            }
            other => match self.condition_holds(other) {
                Some(Ok(true)) => {
                    self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                }
                Some(Ok(false)) => {
                    self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                }
                Some(Err(holds)) => {
                    return Ok(ExecuteReturnType::Select(holds, dest.clone(), opt1, opt2));
                }
                None => {
                    self.set_register(dest, RegisterKind::Number, None, 0);
                }
            },
        }
        Ok(ExecuteReturnType::Next)
    }

    pub fn execute(
        &mut self,
        pc: usize,
        instruction: &Instruction,
    ) -> Result<ExecuteReturnType, String> {
        self.set_current_line(pc);
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
                "neg" => {
                    let mut operands = instruction.operands.clone();
                    operands.insert(1, Operand::Register(RePrefix::Ze, 0));
                    self.arithmetic("-", |x, y| x - y, operands);
                }
                "mul" => {
                    self.arithmetic("*", |x, y| x * y, instruction.operands.clone());
                }
                "and" => {
                    self.arithmetic("&", |x, y| x & y, instruction.operands.clone());
                }
                "orr" => {
                    self.arithmetic("|", |x, y| x | y, instruction.operands.clone());
                    self.bound_bitwise_result(instruction);
                }
                "orn" => {
                    self.arithmetic("!|", |x, y: i64| x | !y, instruction.operands.clone());
                }
                "eor" => {
                    self.arithmetic("^", |x, y| x ^ y, instruction.operands.clone());
                    self.bound_bitwise_result(instruction);
                }
                "bic" => {
                    self.arithmetic("!&", |x, y: i64| x & !y, instruction.operands.clone());
                }
                "adds" => {
                    let (r1, r2) = self.flag_operands(&instruction.operands[1..]);
                    let bits = Self::flag_bits(&instruction.operands[1..]);
                    self.cmn_values_sized(r1, r2, bits);
                    self.arithmetic("+", |x, y| x + y, instruction.operands.clone());
                }
                "subs" => {
                    let (r1, r2) = self.flag_operands(&instruction.operands[1..]);
                    let bits = Self::flag_bits(&instruction.operands[1..]);
                    self.cmp_values_sized(r1, r2, bits);
                    self.arithmetic("-", |x, y| x - y, instruction.operands.clone());
                }
                "ror" | "lsl" | "lsr" | "asr" => {
                    let mut reg_iter = instruction.operands.iter();

                    let reg0 = reg_iter.next().expect("Need destination register");
                    let reg1 = reg_iter.next().expect("Need first source register");
                    let reg2 = reg_iter.next().expect("Need second source register");

                    self.shift_reg(&instruction.opcode, reg0, reg1, reg2);
                }
                "ands" => {
                    let (r1, r2) = self.flag_operands(&instruction.operands[1..]);
                    let bits = Self::flag_bits(&instruction.operands[1..]);
                    self.tst_values_sized(r1, r2, bits);
                    self.arithmetic("&", |x, y| x & y, instruction.operands.clone());
                }
                "bics" => {
                    let (r1, r2) = self.flag_operands(&instruction.operands[1..]);
                    let bits = Self::flag_bits(&instruction.operands[1..]);
                    if r2.kind == RegisterKind::Immediate && r2.base.is_none() {
                        self.tst_values_sized(r1, immediate(!r2.offset), bits);
                    } else {
                        self.set_unknown_flags();
                    }
                    self.arithmetic("!&", |x, y: i64| x & !y, instruction.operands.clone());
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
                    let dst = &instruction.operands[0];
                    let width = match dst {
                        Operand::Register(RePrefix::W, _) => 32,
                        _ => 64,
                    };
                    let source = self.get_register(&instruction.operands[1]);
                    let value = instruction_aux::count_leading_zeros(source, width);
                    self.set_register(dst, value.kind, value.base, value.offset);
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
                "udiv" => {
                    let [dst, dividend, divisor] = instruction.operands.as_slice() else {
                        return Err("udiv needs three registers".to_string());
                    };
                    let (dividend, divisor) =
                        (self.get_register(dividend), self.get_register(divisor));
                    let word = matches!(dst, Operand::Register(RePrefix::W, _));
                    let constant = |v: &RegisterValue| {
                        (v.kind == RegisterKind::Immediate && v.base.is_none()).then_some(v.offset)
                    };
                    let positive = match constant(&divisor) {
                        Some(d) => d > 0,
                        None => {
                            divisor.kind == RegisterKind::RegisterBase
                                && comparison_to_ast(AbstractComparison::new(
                                    "<=",
                                    instruction_aux::full_value(&divisor),
                                    AbstractExpression::Immediate(0),
                                ))
                                .is_some_and(|c| {
                                    self.solver.check_assumptions(&[c]) == SatResult::Unsat
                                })
                        }
                    };
                    match (constant(&dividend), constant(&divisor)) {
                        _ if !word || !positive || dividend.kind == RegisterKind::Number => {
                            self.set_register(dst, RegisterKind::Number, None, 0);
                        }
                        (Some(n), Some(d)) => self.set_register(
                            dst,
                            RegisterKind::Immediate,
                            None,
                            ((n as u64 & 0xffff_ffff) / d as u64) as i64,
                        ),
                        _ => self.set_register(
                            dst,
                            RegisterKind::RegisterBase,
                            Some(generate_expression(
                                "/",
                                instruction_aux::full_value(&dividend),
                                instruction_aux::full_value(&divisor),
                            )),
                            0,
                        ),
                    }
                }
                "ubfiz" | "sbfiz" => {
                    let [dst, src, Operand::Immediate(lsb), Operand::Immediate(width)] =
                        instruction.operands.as_slice()
                    else {
                        return Err(format!("{} needs an lsb and a width", instruction.opcode));
                    };
                    let bits = match dst {
                        Operand::Register(RePrefix::W, _) => 32,
                        _ => 64,
                    };
                    let signed = instruction.opcode == "sbfiz";
                    let field =
                        instruction_aux::extract_bits(self.get_register(src), 0, *width, signed);
                    let field = self.field_of_unknown(field, *width, signed);
                    let value = if *lsb < 0 || lsb + width > bits {
                        RegisterValue::new(RegisterKind::Number, None, 0)
                    } else {
                        instruction_aux::shift_imm("lsl".to_string(), field, *lsb)
                    };
                    self.set_register(dst, value.kind, value.base, value.offset);
                }
                "bfxil" => {
                    let [dst, src, Operand::Immediate(lsb), Operand::Immediate(width)] =
                        instruction.operands.as_slice()
                    else {
                        return Err("bfxil needs an lsb and a width".to_string());
                    };
                    let bits = match dst {
                        Operand::Register(RePrefix::W, _) => 32,
                        _ => 64,
                    };
                    let field =
                        instruction_aux::extract_bits(self.get_register(src), *lsb, *width, false);
                    let value = instruction_aux::insert_bits(
                        self.get_register(dst),
                        field,
                        0,
                        *width,
                        bits,
                    );
                    self.set_register(dst, value.kind, value.base, value.offset);
                }
                "crc32b" | "crc32h" | "crc32w" | "crc32x" | "crc32cb" | "crc32ch" | "crc32cw"
                | "crc32cx" => {
                    self.set_register(&instruction.operands[0], RegisterKind::Number, None, 0);
                }
                "umull" | "smull" | "umnegl" | "smnegl" | "smulh" | "sdiv" | "mneg" | "ubfm"
                | "sbfm" => {
                    let dest = instruction
                        .operands
                        .first()
                        .expect("Need destination register");
                    self.set_register(dest, RegisterKind::Number, None, 0);
                }
                "madd" | "msub" | "smaddl" | "umaddl" | "smsubl" | "umsubl" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dst = reg_iter.next().expect("Need destination register for madd");
                    let lhs = self.get_register(reg_iter.next().expect("madd first factor"));
                    let rhs = self.get_register(reg_iter.next().expect("madd second factor"));
                    let addend = self.get_register(reg_iter.next().expect("madd addend"));

                    let operands = [&lhs, &rhs, &addend];
                    let subtracts = instruction.opcode.contains("sub");

                    if operands
                        .iter()
                        .all(|r| matches!(r.kind, RegisterKind::Immediate))
                    {
                        let product = lhs.offset.wrapping_mul(rhs.offset);
                        let value = if subtracts {
                            addend.offset.wrapping_sub(product)
                        } else {
                            addend.offset.wrapping_add(product)
                        };
                        self.set_register(dst, RegisterKind::Immediate, None, value);
                    } else if operands
                        .iter()
                        .any(|r| matches!(r.kind, RegisterKind::Number))
                    {
                        self.set_register(dst, RegisterKind::Number, None, 0);
                    } else {
                        let product = generate_expression(
                            "*",
                            instruction_aux::full_value(&lhs),
                            instruction_aux::full_value(&rhs),
                        );
                        let expression = generate_expression(
                            if subtracts { "-" } else { "+" },
                            instruction_aux::full_value(&addend),
                            product,
                        );
                        self.set_register(dst, RegisterKind::RegisterBase, Some(expression), 0);
                    }
                }
                "bfi" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dst = reg_iter.next().expect("Need destination register");
                    let src = reg_iter.next().expect("Need source register");
                    let (Some(Operand::Immediate(lsb)), Some(Operand::Immediate(width))) =
                        (reg_iter.next(), reg_iter.next())
                    else {
                        return Err("bfi needs an lsb and a width".to_string());
                    };
                    let bits = match dst {
                        Operand::Register(RePrefix::W, _) => 32,
                        _ => 64,
                    };
                    let value = instruction_aux::insert_bits(
                        self.get_register(dst),
                        self.get_register(src),
                        *lsb,
                        *width,
                        bits,
                    );
                    self.set_register(dst, value.kind, value.base, value.offset);
                }
                "ubfx" | "sbfx" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dst = reg_iter.next().expect("Need destination register");
                    let src = reg_iter.next().expect("Need source register");
                    let (Some(Operand::Immediate(lsb)), Some(Operand::Immediate(width))) =
                        (reg_iter.next(), reg_iter.next())
                    else {
                        return Err(format!("{} needs an lsb and a width", instruction.opcode));
                    };
                    let signed = instruction.opcode == "sbfx";
                    let value =
                        instruction_aux::extract_bits(self.get_register(src), *lsb, *width, signed);
                    let value = self.field_of_unknown(value, *width, signed);
                    self.set_register(dst, value.kind, value.base, value.offset);
                }
                "cmp" => {
                    let (r1, r2) = self.flag_operands(&instruction.operands);
                    let bits = Self::flag_bits(&instruction.operands);
                    self.cmp_values_sized(r1, r2, bits);
                }
                "cmn" => {
                    let (r1, r2) = self.flag_operands(&instruction.operands);
                    let bits = Self::flag_bits(&instruction.operands);
                    self.cmn_values_sized(r1, r2, bits);
                }
                "tst" => {
                    let (r1, r2) = self.flag_operands(&instruction.operands);
                    let bits = Self::flag_bits(&instruction.operands);
                    self.tst_values_sized(r1, r2, bits);
                }
                _ => todo!("Unsupported arithmetic instruction: {:?}", instruction),
            },
            InstructionType::ControlFlow => match instruction.opcode.as_str() {
                "add" => (),
                "adr" => {
                    if let Operand::Address(label, _) = &instruction.operands[1] {
                        self.set_label_address(&instruction.operands[0], label);
                    } else if let Operand::Label(label) = &instruction.operands[1] {
                        self.set_label_address(&instruction.operands[0], label);
                    } else {
                        panic!("adr not invoked correctly with register and label")
                    }
                }
                "adrp" | "ldr" => {
                    if let Operand::Address(label, _) | Operand::Label(label) =
                        &instruction.operands[1]
                    {
                        self.set_label_address(&instruction.operands[0], label);
                    } else {
                        panic!("adrp not invoked correctly with register and label")
                    }
                }
                "tbz" | "tbnz" => {
                    let (
                        Some(register),
                        Some(Operand::Immediate(bit)),
                        Some(Operand::Label(label)),
                    ) = (
                        instruction.operands.first(),
                        instruction.operands.get(1),
                        instruction.operands.get(2),
                    )
                    else {
                        return Err(format!(
                            "{} needs a register, a bit and a label",
                            instruction.opcode
                        ));
                    };
                    let set_branches = instruction.opcode == "tbnz";
                    let value = self.get_register(register);
                    let condition = match value.kind {
                        RegisterKind::Immediate => {
                            let set = (value.offset >> bit) & 1 == 1;
                            return Ok(if set == set_branches {
                                ExecuteReturnType::JumpLabel(label.clone())
                            } else {
                                ExecuteReturnType::Next
                            });
                        }
                        RegisterKind::RegisterBase => AbstractComparison::new(
                            if set_branches { "!=" } else { "==" },
                            generate_expression(
                                "&",
                                value.expression(),
                                AbstractExpression::Immediate(1i64 << bit),
                            ),
                            AbstractExpression::Immediate(0),
                        ),
                        RegisterKind::Number => match self.unknown_flag("bit") {
                            Some(FlagValue::Abstract(c)) => c,
                            _ => return Err("no condition for an unknown bit".to_string()),
                        },
                    };
                    return Ok(ExecuteReturnType::ConditionalJumpLabel(
                        condition,
                        label.clone(),
                    ));
                }
                "br" => {
                    let target = self.get_register(&instruction.operands[0]);
                    return Ok(ExecuteReturnType::JumpIndirect(target));
                }
                "blr" => {
                    let target = self.get_register(&instruction.operands[0]);
                    self.set_register(
                        &Operand::Register(RePrefix::X, 30),
                        RegisterKind::Immediate,
                        None,
                        (pc + 1) as i64,
                    );
                    return Ok(ExecuteReturnType::JumpIndirect(target));
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
                "b.mi" | "b.pl" | "b.vs" | "b.vc" => {
                    let Operand::Label(label) = &instruction.operands[0] else {
                        return Err(format!("{} without a label", instruction.opcode));
                    };
                    let (Some(neg), Some(overflow)) = (&self.neg, &self.overflow) else {
                        return Err("branch reads a flag the program never set".to_string());
                    };
                    let flag = match instruction.opcode.as_str() {
                        "b.vs" | "b.vc" => overflow.clone(),
                        _ => match (neg, overflow) {
                            (FlagValue::Real(n), FlagValue::Real(v)) => FlagValue::Real(n != v),
                            (n, FlagValue::Real(false)) => n.clone(),
                            _ => {
                                return Err(format!(
                                    "{} after a comparison that may overflow is not modelled",
                                    instruction.opcode
                                ));
                            }
                        },
                    };
                    let when = matches!(instruction.opcode.as_str(), "b.mi" | "b.vs");
                    return match flag {
                        FlagValue::Real(b) if b == when => {
                            Ok(ExecuteReturnType::JumpLabel(label.clone()))
                        }
                        FlagValue::Real(_) => Ok(ExecuteReturnType::Next),
                        FlagValue::Abstract(s) => Ok(ExecuteReturnType::ConditionalJumpLabel(
                            if when { s } else { s.not() },
                            label.clone(),
                        )),
                    };
                }
                "bgt" | "bt" | "b.gt" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.neg, &self.overflow) {
                            (Some(zero), Some(neg), Some(ove)) => match (zero, neg, ove) {
                                (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(_)) => {
                                    if !z && !n {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                (zero, neg, _) => {
                                    let Some((left, right)) = signed_sides(zero, neg) else {
                                        todo!("branch needs concrete flags")
                                    };
                                    let expression = generate_comparison(">", left, right);
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                        expression,
                                        label.clone(),
                                    ));
                                }
                            },
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
                            (Some(zero), Some(neg), Some(ove)) => match (zero, neg, ove) {
                                (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(_)) => {
                                    if !z && *n {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                (zero, neg, _) => {
                                    let Some((left, right)) = signed_sides(zero, neg) else {
                                        todo!("branch needs concrete flags")
                                    };
                                    let expression = generate_comparison("<", left, right);
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                        expression,
                                        label.clone(),
                                    ));
                                }
                            },
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
                                (zero, neg, _) => {
                                    let Some((left, right)) = signed_sides(zero, neg) else {
                                        todo!("branch needs concrete flags")
                                    };
                                    let expression = generate_comparison(">=", left, right);
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                        expression,
                                        label.clone(),
                                    ));
                                }
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
                            (Some(zero), Some(carry)) => match (zero, carry) {
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
                            },
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
                            (Some(zero), Some(neg)) => match (zero, neg) {
                                (FlagValue::Real(z), FlagValue::Real(n)) => {
                                    if *z || *n {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                (zero, neg) => {
                                    let Some((left, right)) = signed_sides(zero, neg) else {
                                        return Err(
                                            "b.le reads a flag the program never set".to_string()
                                        );
                                    };
                                    let expression = generate_comparison("<=", left, right);
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
                "cset" | "csetm" => {
                    let Some(dest) = instruction.operands.first() else {
                        return Err(format!("{} needs a destination", instruction.opcode));
                    };
                    let Some(Operand::Label(cond)) = instruction.operands.get(1) else {
                        return Err(format!("{} needs a condition", instruction.opcode));
                    };
                    let set = if instruction.opcode == "cset" { 1 } else { -1 };
                    return self.conditional_select(dest, immediate(set), immediate(0), cond);
                }
                "csel" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dest = reg_iter.next().expect("csel register");
                    let opt1 = self.get_register(reg_iter.next().expect("csel register"));
                    let opt2 = self.get_register(reg_iter.next().expect("csel register"));
                    let Operand::Label(cond) = reg_iter.next().expect("csel condition code") else {
                        panic!("not a valid condition code")
                    };
                    return self.conditional_select(dest, opt1, opt2, cond);
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
                    let ops = &instruction.operands;
                    let (dest, first, second, cond, first_changed) = match ops.as_slice() {
                        [dest, source, Operand::Label(cond)] => (dest, source, source, cond, true),
                        [dest, first, second, Operand::Label(cond)] => {
                            (dest, first, second, cond, false)
                        }
                        _ => return Err(format!("{} needs a condition", instruction.opcode)),
                    };
                    let change = &instruction.opcode[instruction.opcode.len() - 3..];
                    let (first, second) = (self.get_register(first), self.get_register(second));
                    let (taken, otherwise) = if first_changed {
                        (changed(first, change), second)
                    } else {
                        (first, changed(second, change))
                    };
                    return self.conditional_select(dest, taken, otherwise, cond);
                }
                "ccmp" | "ccmn" => {
                    let [left, right, Operand::Immediate(nzcv), Operand::Label(cond)] =
                        instruction.operands.as_slice()
                    else {
                        return Err(format!(
                            "{} needs two operands, flags and a condition",
                            instruction.opcode
                        ));
                    };
                    match self.condition_holds(cond) {
                        Some(Ok(true)) => {
                            let bits = Self::flag_bits(&instruction.operands);
                            let (left, right) = (self.get_register(left), self.get_register(right));
                            if instruction.opcode == "ccmp" {
                                self.cmp_values_sized(left, right, bits);
                            } else {
                                self.cmn_values_sized(left, right, bits);
                            }
                        }
                        Some(Ok(false)) => {
                            let (n, v) = (nzcv & 8 != 0, nzcv & 1 != 0);
                            self.set_flags([
                                Some(FlagValue::Real(nzcv & 4 != 0)),
                                Some(FlagValue::Real(n != v)),
                                Some(FlagValue::Real(nzcv & 2 != 0)),
                                Some(FlagValue::Real(v)),
                            ]);
                        }
                        _ => self.set_unknown_flags(),
                    }
                }
                _ => todo!(
                    "control flow instruction not yet implemented {:?}",
                    instruction
                ),
            },
            InstructionType::Memory => match instruction.opcode.as_str() {
                "ldr" | "ldrb" | "ldrh" | "ldrsb" | "ldrsh" | "ldrsw" | "ldur" | "ldurb"
                | "ldurh" | "ldursb" | "ldursh" | "ldursw" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("ldr dst");
                    let src_addr = reg_iter.next().expect("ldr src");

                    match src_addr {
                        Operand::Memory(w, reg_num, offset, reg_offset, mode) => {
                            let (mut address, writeback) =
                                self.indexed_address(w, *reg_num, offset, reg_offset, mode);

                            let width = access_width(&instruction.opcode, dst);
                            match self.table_load(&address, width) {
                                memory::TableLoad::Split(cases) => {
                                    return Ok(ExecuteReturnType::Split(cases));
                                }
                                memory::TableLoad::Concrete(entry) => address = entry,
                                memory::TableLoad::NotATable => (),
                            }
                            let res = self.load(dst.clone(), address, width);
                            if let Err(e) = res {
                                return Err(e.to_string());
                            }
                            self.extend_loaded(dst, &instruction.opcode, width);

                            self.write_back(w, *reg_num, writeback);
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
                        Operand::Memory(w, reg_num, offset, reg_offset, mode) => {
                            let (address, writeback) =
                                self.indexed_address(w, *reg_num, offset, reg_offset, mode);

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

                            self.write_back(w, *reg_num, writeback);
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
                        Operand::Memory(w, reg_num, offset, reg_offset, mode) => {
                            let (address, writeback) =
                                self.indexed_address(w, *reg_num, offset, reg_offset, mode);

                            let width = access_width(&instruction.opcode, dst);
                            let res = self.store(dst.clone(), address, width);
                            if let Err(e) = res {
                                return Err(e.to_string());
                            }

                            self.write_back(w, *reg_num, writeback);
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
                        Operand::Memory(w, reg_num, offset, reg_offset, mode) => {
                            let (address, writeback) =
                                self.indexed_address(w, *reg_num, offset, reg_offset, mode);

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

                            self.write_back(w, *reg_num, writeback);
                        }
                        _ => {
                            panic!("ldr not with correct syntax for memory operand");
                        }
                    }
                }
                "prfm" | "prfum" => {}
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
                "rev64" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dst = reg_iter.next().expect("rev64 dst");
                    let src = reg_iter.next().expect("rev64 src");

                    match dst {
                        Operand::Vector(_, _, arrangement) => {
                            let arrangement = arrangement.clone();
                            let per_double = 8 / arrangement.lane_bytes();
                            self.vector_permute(dst, src, &arrangement, |lane| {
                                let group = lane / per_double;
                                group * per_double + (per_double - 1 - (lane % per_double))
                            });
                        }
                        _ => self.vector_unknown(dst),
                    }
                }
                "mov" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dst = reg_iter.next().expect("mov dst");
                    let src = reg_iter.next().expect("mov src");
                    let copied = self.get_simd_register(src);
                    self.set_simd_register(dst, copied);
                }
                "and" => self.vector_arithmetic("&", |x, y| x & y, instruction),
                "orr" => self.vector_arithmetic("|", |x, y| x | y, instruction),
                "eor" => self.vector_arithmetic("^", |x, y| x ^ y, instruction),
                "cmeq" | "cmhs" | "cmhi" | "cmls" | "cmlo" | "cmge" | "cmgt" | "cmle" | "cmlt"
                | "cmtst" => {
                    if let Some(dst) = instruction.operands.first() {
                        self.vector_unknown(dst);
                        let range = arrangement_of(dst)
                            .and_then(|a| range_fits_lane((-1, 0), a.lane_bytes()));
                        self.set_lane_range(dst, range);
                    }
                }
                "add" => {
                    let summed = match (
                        instruction.operands.get(1).map(|o| self.lane_range(o)),
                        instruction.operands.get(2).map(|o| self.lane_range(o)),
                    ) {
                        (Some(Some((lo1, hi1))), Some(Some((lo2, hi2)))) => {
                            Some((lo1 + lo2, hi1 + hi2))
                        }
                        _ => None,
                    };
                    self.vector_arithmetic("+", |x, y| x.wrapping_add(y), instruction);
                    if let (Some(dst), Some(summed)) = (instruction.operands.first(), summed) {
                        let range = arrangement_of(dst)
                            .and_then(|a| range_fits_lane(summed, a.lane_bytes()));
                        self.set_lane_range(dst, range);
                    }
                }
                "addv" => {
                    let summed = match (
                        instruction.operands.get(1).map(|o| self.lane_range(o)),
                        instruction.operands.get(1).and_then(arrangement_of),
                    ) {
                        (Some(Some((lo, hi))), Some(arrangement)) => {
                            let lanes = arrangement.lanes() as i64;
                            range_fits_lane(
                                (std::cmp::min(lo * lanes, 0), std::cmp::max(hi * lanes, 0)),
                                arrangement.lane_bytes(),
                            )
                        }
                        _ => None,
                    };
                    if let Some(dst) = instruction.operands.first() {
                        self.vector_unknown(dst);
                        self.set_lane_range(dst, summed);
                    }
                }
                "sub" => self.vector_arithmetic("-", |x, y| x.wrapping_sub(y), instruction),
                "mul" => self.vector_arithmetic("*", |x, y| x.wrapping_mul(y), instruction),
                "uaddw" | "uaddw2" | "saddw" | "saddw2" => {
                    if let Err(e) = self.vector_widening_add("+", instruction) {
                        return Err(e);
                    }
                }
                "movi" | "mvni" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dst = reg_iter.next().expect("Need destination register");

                    match (dst, reg_iter.next()) {
                        (Operand::Vector(_, _, arrangement), Some(Operand::Immediate(value))) => {
                            let arrangement = arrangement.clone();
                            let lane_bytes = arrangement.lane_bytes();
                            let mut value = *value as u128;
                            if instruction.opcode == "mvni" {
                                value = !value;
                            }
                            let shifted = instruction
                                .operands
                                .iter()
                                .any(|o| matches!(o, Operand::Bitwise(..)));
                            if shifted {
                                self.vector_unknown(dst);
                            } else {
                                let value = value & ((1u128 << (8 * lane_bytes)) - 1);
                                self.vector_broadcast(
                                    dst,
                                    &arrangement,
                                    vec![None; lane_bytes],
                                    value,
                                    RegisterKind::Immediate,
                                );
                            }
                        }
                        _ => self.vector_unknown(dst),
                    }
                }
                "dup" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dst = reg_iter.next().expect("Need destination register");
                    let src = reg_iter.next().expect("dup needs a source");

                    let Operand::Vector(_, _, arrangement) = dst else {
                        self.vector_unknown(dst);
                        return Ok(ExecuteReturnType::Next);
                    };
                    let arrangement = arrangement.clone();
                    let lane_bytes = arrangement.lane_bytes();

                    match src {
                        Operand::VectorAccess(_, index, element, lane) => {
                            let element = element.clone();
                            let source = self.simd_registers[*index].clone();
                            let (bases, value) = source.get_lane(&element, *lane as usize);
                            let kind = source.kind.clone();
                            self.vector_broadcast(dst, &arrangement, bases, value, kind);
                        }
                        Operand::Register(..) => {
                            let source = self.get_register(src);
                            match source.kind {
                                RegisterKind::Immediate => {
                                    let value =
                                        (source.offset as u128) & ((1u128 << (8 * lane_bytes)) - 1);
                                    self.vector_broadcast(
                                        dst,
                                        &arrangement,
                                        vec![None; lane_bytes],
                                        value,
                                        RegisterKind::Immediate,
                                    );
                                }
                                _ => self.vector_unknown(dst),
                            }
                        }
                        _ => self.vector_unknown(dst),
                    }
                }
                "shl" | "ushr" | "sshr" | "sshl" | "ushl" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dst = reg_iter.next().expect("Need destination register");
                    let src = reg_iter.next().expect("need src register for shift");
                    let amount = reg_iter.next();

                    match (arrangement_of(dst), amount) {
                        (Some(arrangement), Some(Operand::Immediate(shift))) => {
                            let shift = (*shift) as u32;
                            let lane_bytes = arrangement.lane_bytes();
                            let source = self.get_simd_register(src);
                            let mut destination = self.get_simd_register(dst);

                            for lane in 0..arrangement.lanes() {
                                let (_bases, value) = source.get_lane(&arrangement, lane);
                                let value = match instruction.opcode.as_str() {
                                    "shl" | "sshl" | "ushl" => {
                                        value.checked_shl(shift).unwrap_or(0)
                                    }
                                    _ => value.checked_shr(shift).unwrap_or(0),
                                };
                                let value = if lane_bytes >= 16 {
                                    value
                                } else {
                                    value & ((1u128 << (8 * lane_bytes)) - 1)
                                };
                                destination.set_lane(
                                    &arrangement,
                                    lane,
                                    vec![None; lane_bytes],
                                    value,
                                );
                            }

                            self.set_simd_register(dst, destination);
                        }
                        _ => self.vector_unknown(dst),
                    }
                }
                _ => {
                    if let Some(dst) = instruction.operands.first() {
                        match dst {
                            Operand::Vector(..)
                            | Operand::VectorRegister(..)
                            | Operand::VectorAccess(..) => self.vector_unknown(dst),
                            _ => self.set_register(dst, RegisterKind::Number, None, 0),
                        }
                    }
                }
            },
            InstructionType::SIMDManagement => match instruction.opcode.as_str() {
                "ld1r" | "ld2r" | "ld3r" | "ld4r" => {
                    let (destinations, addr) = split_vector_operands(instruction);

                    let Some(Operand::Memory(prefix, num, offset, reg_offset, indexing)) = addr
                    else {
                        return Err(format!("{} without an address", instruction.opcode));
                    };
                    let address = self.get_register(&Operand::Register(prefix.clone(), *num));

                    let mut cursor = address.clone();
                    for destination in &destinations {
                        let element = arrangement_of(destination)
                            .map(|a| a.element())
                            .unwrap_or(Arrangement::B);
                        let width = element.lane_bytes();

                        if let Err(e) =
                            self.mem_safe_vector_access(&cursor, width as i64, RegionType::READ)
                        {
                            return Err(e.to_string());
                        }
                        self.vector_unknown(destination);
                        cursor.offset += width as i64;
                    }

                    self.apply_writeback(prefix, *num, &address, offset, reg_offset, indexing);
                }
                "ld1" | "ld2" | "ld3" | "ld4" => {
                    let (destinations, addr) = split_vector_operands(instruction);

                    let Some(Operand::Memory(prefix, num, offset, reg_offset, indexing)) = addr
                    else {
                        return Err(format!("{} without an address", instruction.opcode));
                    };
                    let address = self.get_register(&Operand::Register(prefix.clone(), *num));

                    let mut cursor = address.clone();
                    for destination in &destinations {
                        let width = vector_access_width(destination) as i64;
                        match self.load_vector(destination.clone(), cursor.clone(), width) {
                            Err(e) => return Err(e.to_string()),
                            _ => (),
                        }
                        cursor.offset += width;
                    }

                    self.apply_writeback(prefix, *num, &address, offset, reg_offset, indexing);
                }
                "st1" | "st2" | "st3" | "st4" => {
                    let (sources, addr) = split_vector_operands(instruction);

                    let Some(Operand::Memory(prefix, num, offset, reg_offset, indexing)) = addr
                    else {
                        return Err(format!("{} without an address", instruction.opcode));
                    };
                    let address = self.get_register(&Operand::Register(prefix.clone(), *num));

                    let mut cursor = address.clone();
                    for source in &sources {
                        let width = vector_access_width(source) as i64;
                        match self.store_vector(source.clone(), cursor.clone(), width) {
                            Err(e) => return Err(e.to_string()),
                            _ => (),
                        }
                        cursor.offset += width;
                    }

                    self.apply_writeback(prefix, *num, &address, offset, reg_offset, indexing);
                }
                "ldr" | "str" | "ldur" | "stur" => {
                    let mut reg_iter = instruction.operands.iter();
                    let reg = reg_iter.next().expect("need a register").clone();
                    let addr = reg_iter.next().expect("need an address");

                    let Operand::Memory(prefix, num, offset, reg_offset, mode) = addr else {
                        return Err(format!("{} without an address", instruction.opcode));
                    };

                    let (address, writeback) =
                        self.indexed_address(prefix, *num, offset, reg_offset, mode);

                    let width = vector_access_width(&reg) as i64;
                    let result = if instruction.opcode.starts_with('l') {
                        self.load_vector(reg, address, width)
                    } else {
                        self.store_vector(reg, address, width)
                    };
                    if let Err(e) = result {
                        return Err(e.to_string());
                    }

                    self.write_back(prefix, *num, writeback);
                }
                "stp" | "ldp" => {
                    let mut reg_iter = instruction.operands.iter();

                    let reg1 = reg_iter.next().expect("stp/ldp first register");
                    let reg2 = reg_iter.next().expect("stp/ldp second register");
                    let src_addr = reg_iter.next().expect("stp/ldp address");

                    match src_addr {
                        Operand::Memory(w, reg_num, offset, reg_offset, mode) => {
                            let (mut address, writeback) =
                                self.indexed_address(w, *reg_num, offset, reg_offset, mode);

                            let width = vector_access_width(reg1) as i64;
                            let loading = instruction.opcode.starts_with('l');

                            let res1 = if loading {
                                self.load_vector(reg1.clone(), address.clone(), width)
                            } else {
                                self.store_vector(reg1.clone(), address.clone(), width)
                            };
                            address.offset += width;
                            let res2 = if loading {
                                self.load_vector(reg2.clone(), address.clone(), width)
                            } else {
                                self.store_vector(reg2.clone(), address.clone(), width)
                            };
                            match res1 {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }
                            match res2 {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }

                            self.write_back(w, *reg_num, writeback);
                        }
                        _ => {
                            return Err("stp/ldp without a memory operand".to_string());
                        }
                    }
                }
                "movi" | "mvni" | "dup" => {
                    return self.execute(
                        pc,
                        &Instruction {
                            ty: InstructionType::SIMDArithmetic,
                            opcode: instruction.opcode.clone(),
                            operands: instruction.operands.clone(),
                        },
                    );
                }
                "smov" | "umov" => {
                    let source = instruction.operands.get(1);
                    let signed = instruction.opcode == "smov";
                    let width = source
                        .and_then(|o| arrangement_of(o).map(|a| a.lane_bytes()))
                        .filter(|bytes| (1..=4).contains(bytes));
                    let from_width = width.map(|bytes| {
                        let bits = 8 * bytes as u32;
                        if signed {
                            (-(1i64 << (bits - 1)), (1i64 << (bits - 1)) - 1)
                        } else {
                            (0, (1i64 << bits) - 1)
                        }
                    });
                    let range = if signed {
                        source.and_then(|o| self.lane_range(o)).or(from_width)
                    } else {
                        from_width
                    };
                    let maxima = match source.and_then(vector_index) {
                        Some(n) if !signed => self.lane_bounds.maxima[n].clone(),
                        _ => Vec::new(),
                    };
                    let Some(dst) = instruction.operands.first() else {
                        return Ok(ExecuteReturnType::Next);
                    };
                    match range {
                        Some((low, high)) => {
                            let name = self.fresh_symbol("lane");
                            let lane = generate_expression(
                                "atmost",
                                generate_expression(
                                    "atleast",
                                    AbstractExpression::Abstract(name),
                                    AbstractExpression::Immediate(low),
                                ),
                                AbstractExpression::Immediate(high),
                            );
                            let bounded = maxima.into_iter().fold(lane, |value, maximum| {
                                generate_expression("atmost", value, maximum)
                            });
                            self.set_register(dst, RegisterKind::RegisterBase, Some(bounded), 0);
                        }
                        None => self.set_register(dst, RegisterKind::Number, None, 0),
                    }
                }
                _ => {
                    if let Some(dst) = instruction.operands.first() {
                        match dst {
                            Operand::Vector(..)
                            | Operand::VectorRegister(..)
                            | Operand::VectorAccess(..) => self.vector_unknown(dst),
                            _ => self.set_register(dst, RegisterKind::Number, None, 0),
                        }
                    }
                }
            },
            InstructionType::Other => match instruction.opcode.as_str() {
                "nop" | "hint" => {}
                "brk" | "udf" | "hlt" => return Ok(ExecuteReturnType::Trap),
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
                    let link = instruction
                        .operands
                        .first()
                        .cloned()
                        .unwrap_or(Operand::Register(RePrefix::X, 30));
                    let x30 = self.get_register(&link);
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
                "sxtb" | "sxth" | "sxtw" | "uxtb" | "uxth" => {
                    let mut reg_iter = instruction.operands.iter();
                    let dst = reg_iter.next().expect("Need destination register");
                    let src = self.get_register(reg_iter.next().expect("Need source register"));
                    let width = match &instruction.opcode[3..] {
                        "b" => 8,
                        "h" => 16,
                        _ => 32,
                    };
                    let signed = instruction.opcode.starts_with('s');
                    let value = instruction_aux::extract_bits(src, 0, width, signed);
                    let value = self.field_of_unknown(value, width, signed);
                    self.set_register(dst, value.kind, value.base, value.offset);
                }
                "rev" | "rev16" | "rev32" | "rbit" => {
                    let [dst, src] = instruction.operands.as_slice() else {
                        return Err(format!("{} needs two registers", instruction.opcode));
                    };
                    let word = matches!(dst, Operand::Register(RePrefix::W, _));
                    let value = self.get_register(src);
                    let value = match value.kind {
                        RegisterKind::Immediate if value.base.is_none() => {
                            immediate(
                                permuted(&instruction.opcode, word, value.offset as u64) as i64
                            )
                        }
                        _ if word => self.field_of_unknown(
                            RegisterValue::new(RegisterKind::Number, None, 0),
                            32,
                            false,
                        ),
                        _ => RegisterValue::new(RegisterKind::Number, None, 0),
                    };
                    self.set_register(dst, value.kind, value.base, value.offset);
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
