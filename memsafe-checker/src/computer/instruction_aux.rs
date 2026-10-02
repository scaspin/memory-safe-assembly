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
                self.set_register(reg1, RegisterKind::Number, None, 0);
                return;
            }
        };

        self.set_register(reg1, shifted_reg.kind, shifted_reg.base, shifted_reg.offset);
    }

    pub fn cmp(&mut self, reg1: &Operand, reg2: &Operand) {
        let r1 = self.get_register(reg1);
        let r2 = self.get_register(reg2);

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
                        self.carry = Some(FlagValue::Abstract(AbstractComparison::new(
                            ">=", left, right,
                        )));
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
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                "==",
                expression.clone(),
                AbstractExpression::Immediate(0),
            )));
            self.carry = Some(FlagValue::Abstract(AbstractComparison::new(
                ">=", left, right,
            )));
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
        let r1 = self.get_register(reg1);
        let r2 = self.get_register(reg2);

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
        let r1 = self.get_register(reg1);
        let r2 = self.get_register(reg2);

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
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
                    let carry = self.unknown_flag("carry");
                    let overflow = self.unknown_flag("overflow");
                    self.carry = carry;
                    self.overflow = overflow;
                }
                RegisterKind::Number => self.set_unknown_flags(),
                RegisterKind::Immediate => {
                    let (sum, signed_overflow) = r1.offset.overflowing_add(r2.offset);
                    self.neg = Some(FlagValue::Real(sum < 0));
                    self.zero = Some(FlagValue::Real(sum == 0));
                    self.carry = Some(FlagValue::Real(
                        (r1.offset as u64).overflowing_add(r2.offset as u64).1,
                    ));
                    self.overflow = Some(FlagValue::Real(signed_overflow));
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
            let carry = self.unknown_flag("carry");
            let overflow = self.unknown_flag("overflow");
            self.carry = carry;
            self.overflow = overflow;
        } else {
            self.set_unknown_flags();
        }
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
                    "lsr" => ((register.offset as u64) >> amount) as i64,
                    "asr" => register.offset >> amount,
                    _ => register.offset.rotate_right(amount),
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
        "uxtw" => {
            RegisterValue {
                kind: register.kind,
                base: register.base,
                offset: register.offset,
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
