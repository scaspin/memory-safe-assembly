use crate::computer::*;

impl ARMCORTEXA {
    pub fn arithmetic(
        &mut self,
        op_string: &str,
        op: impl Fn(i64, i64) -> i64,
        operands: Vec<Operand>,
    ) {
        let reg0 = operands.first().expect("Need destination register").clone();
        match self.arithmetic_value(op_string, op, &operands) {
            Some(v) => self.set_register(&reg0, v.kind, v.base, v.offset),
            None => log::error!("no rule for {op_string} on these operand kinds"),
        }
    }

    pub fn carry_select(
        &mut self,
        op_string: &str,
        with_carry: impl Fn(i64, i64) -> i64,
        without_carry: impl Fn(i64, i64) -> i64,
        condition: &AbstractComparison,
        operands: &[Operand],
    ) -> Result<ExecuteReturnType, String> {
        let dest = operands.first().expect("Need destination register").clone();
        let set = self.arithmetic_value(op_string, with_carry, operands);
        let clear = self.arithmetic_value(op_string, without_carry, operands);
        match (set, clear) {
            (Some(set), Some(clear)) if set == clear => {
                self.set_register(&dest, set.kind, set.base, set.offset);
                Ok(ExecuteReturnType::Next)
            }
            (Some(set), Some(clear)) => {
                match (
                    comparison_to_ast(condition.clone()),
                    expression_to_ast(set.expression()),
                    expression_to_ast(clear.expression()),
                ) {
                    (Some(_cond), Some(set_ast), Some(clear_ast)) => {
                        let name = format!("carry_{}", self.next_carry());
                        let result = ast::Int::new_const(name.clone());
                        let constants_did_not_wrap = clear.offset <= set.offset;
                        if constants_did_not_wrap {
                            self.solver.assert(result.ge(&clear_ast));
                            self.solver.assert(result.le(&set_ast));
                        }
                        self.set_register(
                            &dest,
                            RegisterKind::RegisterBase,
                            Some(AbstractExpression::Abstract(name)),
                            0,
                        );
                        Ok(ExecuteReturnType::Next)
                    }
                    _ => Ok(ExecuteReturnType::Select(
                        condition.clone(),
                        dest,
                        set,
                        clear,
                    )),
                }
            }
            _ => Err(format!("no rule for {op_string} on these operand kinds")),
        }
    }

    fn capped(&mut self, e: AbstractExpression) -> AbstractExpression {
        if e.size() <= MAX_EXPRESSION_NODES
            || e.get_abstracts()
                .iter()
                .any(|name| self.memory.contains_key(name))
        {
            return e;
        }
        AbstractExpression::Abstract(format!("wide_{}", self.next_carry()))
    }

    fn carried_base(
        base: Option<AbstractExpression>,
        op_string: &str,
    ) -> Option<AbstractExpression> {
        match (base, op_string) {
            (Some(b), "-") => Some(generate_expression(
                "-",
                AbstractExpression::Immediate(0),
                b,
            )),
            (other, _) => other,
        }
    }

    pub fn arithmetic_value(
        &mut self,
        op_string: &str,
        op: impl Fn(i64, i64) -> i64,
        operands: &[Operand],
    ) -> Option<RegisterValue> {
        let mut reg_iter = operands.iter();

        let _ = reg_iter.next().expect("Need destination register");
        let reg1 = reg_iter.next().expect("Need first source register");
        let reg2 = reg_iter.next().expect("Need second source register");

        let r1 = self.get_register(reg1);
        let mut r2 = self.get_register(reg2);

        if let Some(Operand::Bitwise(op, num)) = &reg_iter.next() {
            r2 = shift_imm(op.to_string(), r2.clone(), *num);
        }

        let based = |base, offset| {
            Some(RegisterValue {
                kind: RegisterKind::RegisterBase,
                base,
                offset,
            })
        };

        if !matches!(op_string, "+" | "-") && (r1.base.is_some() || r2.base.is_some()) {
            if r1.kind == RegisterKind::Number || r2.kind == RegisterKind::Number {
                return Some(RegisterValue {
                    kind: RegisterKind::Number,
                    base: None,
                    offset: 0,
                });
            }
            let whole = generate_expression(op_string, r1.expression(), r2.expression());
            return based(Some(self.capped(whole)), 0);
        }

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    let base = match r1.clone().base {
                        Some(reg1base) => match r2.clone().base {
                            Some(reg2base) => {
                                Some(generate_expression(op_string, reg1base, reg2base))
                            }
                            None => Some(reg1base),
                        },
                        None => Self::carried_base(r2.clone().base, op_string),
                    };
                    based(base, op(r1.offset, r2.offset))
                }
                RegisterKind::Number => Some(RegisterValue {
                    kind: RegisterKind::Number,
                    base: None,
                    offset: 0,
                }),
                RegisterKind::Immediate => Some(RegisterValue {
                    kind: RegisterKind::Immediate,
                    base: None,
                    offset: op(r1.offset, r2.offset),
                }),
            }
        } else if r1.kind == RegisterKind::Immediate {
            Some(RegisterValue {
                kind: r2.kind.clone(),
                base: Self::carried_base(r2.base.clone(), op_string),
                offset: op(r1.offset, r2.offset),
            })
        } else if r2.kind == RegisterKind::Immediate {
            Some(RegisterValue {
                kind: r1.kind.clone(),
                base: r1.base.clone(),
                offset: op(r1.offset, r2.offset),
            })
        } else if r1.kind == RegisterKind::Number || r2.kind == RegisterKind::Number {
            Some(RegisterValue {
                kind: RegisterKind::Number,
                base: None,
                offset: 0,
            })
        } else if r1.kind == RegisterKind::RegisterBase || r2.kind == RegisterKind::RegisterBase {
            let base = match r2.clone().base {
                Some(reg1base) => match r1.clone().base {
                    Some(reg2base) => Some(generate_expression(op_string, reg1base, reg2base)),
                    None => Some(reg1base),
                },
                None => r1.clone().base,
            };
            based(base, op(r1.offset, r2.offset))
        } else {
            None
        }
    }

    pub fn bound_bitwise_result(&mut self, instruction: &Instruction) {
        let Some(destination @ Operand::Register(RePrefix::W, _)) = instruction.operands.first()
        else {
            return;
        };
        if instruction
            .operands
            .iter()
            .any(|o| matches!(o, Operand::Immediate(_)))
        {
            return;
        }
        let value = self.get_register(destination);
        let translatable = value
            .base
            .as_ref()
            .is_none_or(|b| expression_to_ast(b.clone()).is_some());
        if translatable {
            return;
        }
        let name = self.fresh_symbol("bitwise");
        let bounded = generate_expression(
            "atmost",
            generate_expression(
                "atleast",
                AbstractExpression::Abstract(name),
                AbstractExpression::Immediate(0),
            ),
            AbstractExpression::Immediate((1i64 << 32) - 1),
        );
        self.set_register(destination, RegisterKind::RegisterBase, Some(bounded), 0);
    }

    pub fn shift_reg(&mut self, op: &str, reg1: &Operand, reg2: &Operand, reg3: &Operand) {
        let r2 = self.get_register(reg2);

        let rotates_a_32_bit_constant = op == "ror"
            && matches!(reg2, Operand::Register(RePrefix::W, _))
            && r2.kind == RegisterKind::Immediate
            && r2.base.is_none();
        if rotates_a_32_bit_constant
            && let Operand::Bitwise(_, amount) | Operand::Immediate(amount) = reg3
        {
            let rotated = (r2.offset as u32).rotate_right(*amount as u32);
            self.set_register(reg1, RegisterKind::Immediate, None, rotated as i64);
            return;
        }

        let shifted_reg = match reg3 {
            Operand::Bitwise(op, shift) => shift_imm(op.to_string(), r2, *shift),
            Operand::Immediate(shift) => shift_imm(op.to_string(), r2, *shift),
            _ => {
                log::info!("shift by register amount {:?} is not modelled", reg3);
                RegisterValue {
                    kind: RegisterKind::Number,
                    base: None,
                    offset: 0,
                }
            }
        };

        self.set_register(reg1, shifted_reg.kind, shifted_reg.base, shifted_reg.offset);
    }

    pub fn extend_loaded(&mut self, dst: &Operand, opcode: &str, width: i64) {
        if width >= 8 {
            return;
        }
        let value = self.get_register(dst);
        if value.kind != RegisterKind::Immediate {
            return;
        }
        let bits = 8 * width as u32;
        let low = (value.offset as u64) & ((1u64 << bits) - 1);
        let extended = if opcode.starts_with("ldrs") || opcode.starts_with("ldurs") {
            ((low << (64 - bits)) as i64) >> (64 - bits)
        } else {
            low as i64
        };
        self.set_register(dst, RegisterKind::Immediate, None, extended);
        if let Operand::Register(RePrefix::X | RePrefix::W, n) = dst {
            self.loaded[*n] = true;
        }
    }

    pub fn memory_address(
        &mut self,
        prefix: &RePrefix,
        num: usize,
        offset: &Option<i64>,
        register_offset: &Option<Box<Operand>>,
    ) -> RegisterValue {
        let mut address = self.get_register(&Operand::Register(prefix.clone(), num));
        address.offset += offset.unwrap_or(0);
        match register_offset {
            Some(register) => add_values(address, self.get_register(register)),
            None => address,
        }
    }

    pub fn indexed_address(
        &mut self,
        prefix: &RePrefix,
        num: usize,
        offset: &Option<i64>,
        register_offset: &Option<Box<Operand>>,
        mode: &Option<bool>,
    ) -> (RegisterValue, Option<RegisterValue>) {
        let target = self.memory_address(prefix, num, offset, register_offset);
        match mode {
            Some(true) => (
                self.get_register(&Operand::Register(prefix.clone(), num)),
                Some(target),
            ),
            Some(false) => {
                self.write_back(prefix, num, Some(target.clone()));
                (target.clone(), Some(target))
            }
            None => (target, None),
        }
    }

    pub fn write_back(&mut self, prefix: &RePrefix, num: usize, value: Option<RegisterValue>) {
        if let Some(value) = value {
            self.set_register(
                &Operand::Register(prefix.clone(), num),
                value.kind,
                value.base,
                value.offset,
            );
        }
    }

    pub fn flag_bits(operands: &[Operand]) -> u32 {
        let of = |operand: Option<&Operand>| match operand {
            Some(Operand::Register(RePrefix::W, _)) => Some(32),
            Some(Operand::Register(_, _)) => Some(64),
            Some(Operand::ShiftedRegister(inner, _, _)) => match **inner {
                Operand::Register(RePrefix::W, _) => Some(32),
                Operand::Register(_, _) => Some(64),
                _ => None,
            },
            _ => None,
        };
        of(operands.first())
            .or_else(|| of(operands.get(1)))
            .unwrap_or(64)
    }

    pub fn flag_operands(&mut self, operands: &[Operand]) -> (RegisterValue, RegisterValue) {
        let r1 = self.get_register(&operands[0]);
        let mut r2 = self.get_register(&operands[1]);
        if let Some(Operand::Bitwise(op, amount)) = operands.get(2) {
            r2 = shift_imm(op.to_string(), r2, *amount);
        }
        (r1, r2)
    }

    pub fn cmp(&mut self, reg1: &Operand, reg2: &Operand) {
        let (r1, r2) = (self.get_register(reg1), self.get_register(reg2));
        let bits = Self::flag_bits(&[reg1.clone(), reg2.clone()]);
        self.cmp_values_sized(r1, r2, bits);
    }

    pub fn cmp_values(&mut self, r1: RegisterValue, r2: RegisterValue) {
        self.cmp_values_sized(r1, r2, 64);
    }

    pub fn cmp_values_sized(&mut self, r1: RegisterValue, r2: RegisterValue, bits: u32) {
        if r1.kind == RegisterKind::Number || r2.kind == RegisterKind::Number {
            self.set_unknown_flags();
            return;
        }

        if r1 == r2 && r1.kind != RegisterKind::Number {
            self.neg = Some(FlagValue::Real(false));
            self.zero = Some(FlagValue::Real(true));
            self.carry = Some(FlagValue::Real(true));
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
                        self.carry = Some(FlagValue::Real(r1.offset >= r2.offset));
                        self.overflow =
                            Some(FlagValue::Real(r1.offset.overflowing_sub(r2.offset).1));
                    } else {
                        let left = AbstractExpression::Register(Box::new(r1));
                        let right = AbstractExpression::Register(Box::new(r2));
                        let expression = AbstractExpression::Expression(
                            "-".to_string(),
                            Box::new(left.clone()),
                            Box::new(right.clone()),
                        );
                        let signed = signed_combination(bits, "-", &left, &right);
                        self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
                            "<",
                            signed,
                            AbstractExpression::Immediate(0),
                        )));
                        self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                            "==",
                            expression.clone(),
                            AbstractExpression::Immediate(0),
                        )));
                        self.carry = Some(FlagValue::Abstract(unsigned_no_borrow(left, right)));
                        self.overflow = Some(FlagValue::Abstract(AbstractComparison::new(
                            "<",
                            expression,
                            AbstractExpression::Immediate(i64::MIN),
                        )));
                    }
                }
                RegisterKind::Number => self.set_unknown_flags(),
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
                    self.carry = Some(FlagValue::Real((r1.offset as u64) >= (r2.offset as u64)));
                    self.overflow = Some(FlagValue::Real(r1.offset.overflowing_sub(r2.offset).1));
                }
            }
        } else if r1.kind == RegisterKind::RegisterBase || r2.kind == RegisterKind::RegisterBase {
            let left = AbstractExpression::Register(Box::new(r1));
            let right = AbstractExpression::Register(Box::new(r2));
            let expression = AbstractExpression::Expression(
                "-".to_string(),
                Box::new(left.clone()),
                Box::new(right.clone()),
            );
            self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
                "<",
                signed_combination(bits, "-", &left, &right),
                AbstractExpression::Immediate(0),
            )));
            self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                "==",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            self.carry = Some(FlagValue::Abstract(unsigned_no_borrow(left, right)));
            self.overflow = Some(FlagValue::Abstract(AbstractComparison::new(
                "<",
                expression,
                AbstractExpression::Immediate(i64::MIN),
            )));
        } else {
            self.set_unknown_flags();
        }
    }

    pub fn tst(&mut self, reg1: &Operand, reg2: &Operand) {
        let (r1, r2) = (self.get_register(reg1), self.get_register(reg2));
        self.tst_values(r1, r2);
    }

    pub fn tst_values(&mut self, r1: RegisterValue, r2: RegisterValue) {
        if r1.kind == RegisterKind::Number || r2.kind == RegisterKind::Number {
            self.set_unknown_flags();
        } else if r1.base.is_none() && r2.base.is_none() {
            let result = r1.offset & r2.offset;
            self.neg = Some(FlagValue::Real(result < 0));
            self.zero = Some(FlagValue::Real(result == 0));
        } else {
            let result = generate_expression("&", r1.expression(), r2.expression());
            self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
                "<",
                result.clone(),
                AbstractExpression::Immediate(0),
            )));
            self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                "==",
                result,
                AbstractExpression::Immediate(0),
            )));
        }

        self.carry = Some(FlagValue::Real(false));
        self.overflow = Some(FlagValue::Real(false));
    }

    pub fn cmn(&mut self, reg1: &Operand, reg2: &Operand) {
        let (r1, r2) = (self.get_register(reg1), self.get_register(reg2));
        let bits = Self::flag_bits(&[reg1.clone(), reg2.clone()]);
        self.cmn_values_sized(r1, r2, bits);
    }

    pub fn cmn_values(&mut self, r1: RegisterValue, r2: RegisterValue) {
        self.cmn_values_sized(r1, r2, 64);
    }

    pub fn cmn_values_sized(&mut self, r1: RegisterValue, r2: RegisterValue, bits: u32) {
        if r1.kind == RegisterKind::Number || r2.kind == RegisterKind::Number {
            self.set_unknown_flags();
            return;
        }

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    let left = AbstractExpression::Register(Box::new(r1));
                    let right = AbstractExpression::Register(Box::new(r2));
                    let expression = AbstractExpression::Expression(
                        "+".to_string(),
                        Box::new(left.clone()),
                        Box::new(right.clone()),
                    );
                    self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
                        "<",
                        signed_combination(bits, "+", &left, &right),
                        AbstractExpression::Immediate(0),
                    )));
                    self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                        "==",
                        expression.clone(),
                        AbstractExpression::Immediate(0),
                    )));
                    let carry = self.unknown_flag("carry");
                    let overflow = self.unknown_flag("overflow");
                    self.carry = carry;
                    self.overflow = overflow;
                }
                RegisterKind::Number => self.set_unknown_flags(),
                RegisterKind::Immediate => {
                    let (sum, signed_overflow) = r1.offset.overflowing_add(r2.offset);
                    self.neg = Some(FlagValue::Real((r1.offset as i128 + r2.offset as i128) < 0));
                    self.zero = Some(FlagValue::Real(sum == 0));
                    self.carry = Some(FlagValue::Real(
                        (r1.offset as u64).overflowing_add(r2.offset as u64).1,
                    ));
                    self.overflow = Some(FlagValue::Real(signed_overflow));
                }
            }
        } else if r1.kind == RegisterKind::RegisterBase || r2.kind == RegisterKind::RegisterBase {
            let left = AbstractExpression::Register(Box::new(r1));
            let right = AbstractExpression::Register(Box::new(r2));
            let expression = AbstractExpression::Expression(
                "+".to_string(),
                Box::new(left.clone()),
                Box::new(right.clone()),
            );
            self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
                "<",
                signed_combination(bits, "+", &left, &right),
                AbstractExpression::Immediate(0),
            )));
            self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                "==",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            let carry = self.unknown_flag("carry");
            let overflow = self.unknown_flag("overflow");
            self.carry = carry;
            self.overflow = overflow;
        } else {
            self.set_unknown_flags();
        }
    }
}

pub fn signed_combination(
    bits: u32,
    op: &str,
    left: &AbstractExpression,
    right: &AbstractExpression,
) -> AbstractExpression {
    let widen = |e: &AbstractExpression| match (bits, e) {
        (64, _) => e.clone(),
        (_, AbstractExpression::Immediate(n)) if i32::try_from(*n).is_ok() => e.clone(),
        (_, AbstractExpression::Register(r))
            if r.base.is_none() && i32::try_from(r.offset).is_ok() =>
        {
            e.clone()
        }
        _ => generate_expression(
            "sext",
            e.clone(),
            AbstractExpression::Immediate(bits as i64),
        ),
    };
    generate_expression(op, widen(left), widen(right))
}

fn unsigned_no_borrow(left: AbstractExpression, right: AbstractExpression) -> AbstractComparison {
    let unsigned = |e| generate_expression("zext", e, AbstractExpression::Immediate(64));
    AbstractComparison::new(">=", unsigned(left), unsigned(right))
}

pub fn count_leading_zeros(value: RegisterValue, width: u32) -> RegisterValue {
    match value.kind {
        RegisterKind::Immediate => {
            let count = if width == 32 {
                (value.offset as u32).leading_zeros()
            } else {
                (value.offset as u64).leading_zeros()
            };
            RegisterValue::new_imm(count as i64)
        }
        RegisterKind::RegisterBase => RegisterValue {
            kind: RegisterKind::RegisterBase,
            base: Some(generate_expression(
                "clz",
                value.expression(),
                AbstractExpression::Immediate(width as i64),
            )),
            offset: 0,
        },
        RegisterKind::Number => value,
    }
}

pub fn extract_bits(value: RegisterValue, lsb: i64, width: i64, signed: bool) -> RegisterValue {
    let unknown = RegisterValue {
        kind: RegisterKind::Number,
        base: None,
        offset: 0,
    };
    if lsb < 0 || width <= 0 || width >= 64 || lsb + width > 64 {
        return unknown;
    }
    let modulus = 1i64 << width;
    let half = 1i64 << (width - 1);
    match value.kind {
        RegisterKind::Immediate => {
            let field = (((value.offset as u64) >> lsb) & ((1u64 << width) - 1)) as i64;
            let offset = if signed && field >= half {
                field - modulus
            } else {
                field
            };
            RegisterValue {
                kind: RegisterKind::Immediate,
                base: None,
                offset,
            }
        }
        RegisterKind::RegisterBase => {
            let mut expression = full_value(&value);
            if lsb > 0 {
                expression =
                    generate_expression("lsr", expression, AbstractExpression::Immediate(lsb));
            }
            expression =
                generate_expression("%", expression, AbstractExpression::Immediate(modulus));
            if signed {
                expression = generate_expression(
                    "-",
                    generate_expression(
                        "%",
                        generate_expression("+", expression, AbstractExpression::Immediate(half)),
                        AbstractExpression::Immediate(modulus),
                    ),
                    AbstractExpression::Immediate(half),
                );
            }
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(expression),
                offset: 0,
            }
        }
        RegisterKind::Number => unknown,
    }
}

pub fn add_values(left: RegisterValue, right: RegisterValue) -> RegisterValue {
    match (&left.kind, &right.kind) {
        (RegisterKind::Number, _) | (_, RegisterKind::Number) => RegisterValue {
            kind: RegisterKind::Number,
            base: None,
            offset: 0,
        },
        (RegisterKind::Immediate, RegisterKind::Immediate) => RegisterValue {
            kind: RegisterKind::Immediate,
            base: None,
            offset: left.offset + right.offset,
        },
        _ => {
            let symbolic = |value: &RegisterValue| match value.kind {
                RegisterKind::RegisterBase => value.base.clone(),
                _ => None,
            };
            let base = match (symbolic(&left), symbolic(&right)) {
                (Some(l), Some(r)) => Some(generate_expression("+", l, r)),
                (Some(b), None) | (None, Some(b)) => Some(b),
                (None, None) => None,
            };
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base,
                offset: left.offset + right.offset,
            }
        }
    }
}

pub fn full_value(register: &RegisterValue) -> AbstractExpression {
    match (&register.kind, &register.base) {
        (RegisterKind::RegisterBase, Some(base)) if register.offset == 0 => base.clone(),
        (RegisterKind::RegisterBase, Some(base)) => generate_expression(
            "+",
            base.clone(),
            AbstractExpression::Immediate(register.offset),
        ),
        _ => AbstractExpression::Immediate(register.offset),
    }
}

pub fn shift_imm(op: String, register: RegisterValue, shift: i64) -> RegisterValue {
    match op.as_str() {
        "lsl" => {
            let new_offset = register.offset << shift;
            RegisterValue {
                kind: register.kind,
                base: register
                    .base
                    .map(|b| generate_expression(&op, b, AbstractExpression::Immediate(shift))),
                offset: new_offset,
            }
        }
        "lsr" | "asr" | "ror" => match register.base {
            None => {
                let amount = shift as u32;
                let shifted = match op.as_str() {
                    "lsr" => (register.offset as u64).checked_shr(amount).unwrap_or(0) as i64,
                    "asr" => register
                        .offset
                        .checked_shr(amount)
                        .unwrap_or(if register.offset < 0 { -1 } else { 0 }),
                    _ => (register.offset as u64).rotate_right(amount) as i64,
                };
                RegisterValue {
                    kind: register.kind,
                    base: None,
                    offset: shifted,
                }
            }
            Some(_) => {
                let whole_value = register.expression();
                RegisterValue {
                    kind: register.kind,
                    base: Some(generate_expression(
                        &op,
                        whole_value,
                        AbstractExpression::Immediate(shift),
                    )),
                    offset: 0,
                }
            }
        },
        "" => {
            let new_offset = register.offset + shift;
            RegisterValue {
                kind: register.kind,
                base: register.base,
                offset: new_offset,
            }
        }
        "uxtw" | "sxtw" | "uxtb" | "uxth" | "sxtb" | "sxth" | "uxtx" | "sxtx" => {
            let bits: u32 = match &op[3..] {
                "b" => 8,
                "h" => 16,
                "w" => 32,
                _ => 64,
            };
            let signed = op.starts_with('s');
            let extended = match register.kind {
                _ if bits == 64 => register,
                RegisterKind::Immediate => {
                    let low = (register.offset as u64) & ((1u64 << bits) - 1);
                    let value = if signed {
                        ((low << (64 - bits)) as i64) >> (64 - bits)
                    } else {
                        low as i64
                    };
                    RegisterValue::new_imm(value)
                }
                RegisterKind::RegisterBase => {
                    let whole = register.expression();
                    if !signed && bits == 32 && register.offset == 0 && is_narrowed(&whole) {
                        register
                    } else {
                        RegisterValue {
                            kind: RegisterKind::RegisterBase,
                            base: Some(generate_expression(
                                if signed { "sext" } else { "zext" },
                                whole,
                                AbstractExpression::Immediate(bits as i64),
                            )),
                            offset: 0,
                        }
                    }
                }
                RegisterKind::Number => register,
            };
            if shift == 0 {
                extended
            } else {
                shift_imm("lsl".to_string(), extended, shift)
            }
        }
        _ => todo!("unsupported extend or shift operator {op}"),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn logical_shift_of_a_negative_constant_fills_with_zeros() {
        let shifted = shift_imm("lsr".to_string(), RegisterValue::new_imm(-1), 60);
        assert_eq!(shifted.offset, 15);
        assert_eq!(shifted.base, None);
    }

    #[test]
    fn arithmetic_shift_of_a_negative_constant_keeps_the_sign() {
        let shifted = shift_imm("asr".to_string(), RegisterValue::new_imm(-16), 2);
        assert_eq!(shifted.offset, -4);
    }

    #[test]
    fn right_shift_applies_to_base_and_offset_together() {
        let mut value = RegisterValue::new_empty("n");
        value.offset = 7;
        let whole = value.expression();
        let shifted = shift_imm("lsr".to_string(), value, 3);
        assert_eq!(shifted.offset, 0);
        assert_eq!(
            shifted.base,
            Some(generate_expression(
                "lsr",
                whole,
                AbstractExpression::Immediate(3)
            ))
        );
    }
}
