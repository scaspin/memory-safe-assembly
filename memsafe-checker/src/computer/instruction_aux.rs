use crate::computer::*;

impl ARMCORTEXA {
    pub fn arithmetic(
        &mut self,
        op_string: &str,
        op: impl Fn(i64, i64) -> i64,
        operands: Vec<Operand>,
    ) {
        let mut reg_iter = operands.iter();

        let reg0 = reg_iter.next().expect("Need destination register");
        let reg1 = reg_iter.next().expect("Need first source register");
        let reg2 = reg_iter.next().expect("Need second source register");

        let r1 = self.get_register(reg1);
        let mut r2 = self.get_register(reg2);

        if let Some(Operand::Bitwise(op, num)) = &reg_iter.next() {
            r2 = shift_imm(op.to_string(), r2.clone(), *num);
        }

        // Only + and - distribute over the base/offset split; the rest need the whole value.
        if !matches!(op_string, "+" | "-") && (r1.base.is_some() || r2.base.is_some()) {
            let whole = generate_expression(op_string, r1.expression(), r2.expression());
            self.set_register(reg0, RegisterKind::RegisterBase, Some(whole), 0);
            return;
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
                        None => r2.clone().base,
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
                None => r1.clone().base,
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

    // `op` is the opcode, since a bare immediate carries no shift direction.
    pub fn shift_reg(&mut self, op: &str, reg1: &Operand, reg2: &Operand, reg3: &Operand) {
        let r2 = self.get_register(reg2);

        let shifted_reg = match reg3 {
            Operand::Bitwise(op, shift) => shift_imm(op.to_string(), r2, *shift),
            Operand::Immediate(shift) => shift_imm(op.to_string(), r2, *shift),
            _ => {
                log::error!("Cannot shift with this operand: {:?}", reg3);
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
            // x - x borrows nothing, so carry is set.
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
                        // The shared base cancels, so the offsets decide borrow and overflow.
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
                        // Carry is the unsigned no-borrow condition, so compare the operands.
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
                RegisterKind::Number => {
                    log::error!("Cannot compare these two registers");
                    self.neg = None;
                    self.zero = None;
                    self.carry = None;
                    self.overflow = None;
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
                    // Carry is unsigned no-borrow; overflow is signed subtraction overflow.
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
            // Carry is the unsigned no-borrow condition, so compare the operands.
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

    pub fn cmn(&mut self, reg1: &Operand, reg2: &Operand) {
        let r1 = self.get_register(reg1);
        let r2 = self.get_register(reg2);

        if r1.kind == r2.kind {
            match r1.kind {
                // Addition does not cancel a shared base, so no flag follows from the offsets.
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
                    // i64 is the widest immediate available, so carry-out is approximated by it.
                    self.carry = Some(FlagValue::Abstract(AbstractComparison::new(
                        ">",
                        expression.clone(),
                        AbstractExpression::Immediate(i64::MAX),
                    )));
                    self.overflow = Some(FlagValue::Abstract(AbstractComparison::new(
                        ">",
                        expression,
                        AbstractExpression::Immediate(i64::MAX),
                    )));
                }
                RegisterKind::Number => {
                    log::error!("Cannot compare these two registers");
                    self.neg = None;
                    self.zero = None;
                    self.carry = None;
                    self.overflow = None;
                }
                RegisterKind::Immediate => {
                    let (sum, signed_overflow) = r1.offset.overflowing_add(r2.offset);
                    self.neg = Some(FlagValue::Real(sum < 0));
                    self.zero = Some(FlagValue::Real(sum == 0));
                    // Carry is the unsigned carry-out; overflow is signed addition overflow.
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
            // i64 is the widest immediate available, so carry-out is approximated by it.
            self.carry = Some(FlagValue::Abstract(AbstractComparison::new(
                ">",
                expression.clone(),
                AbstractExpression::Immediate(i64::MAX),
            )));
            self.overflow = Some(FlagValue::Abstract(AbstractComparison::new(
                ">",
                expression,
                AbstractExpression::Immediate(i64::MAX),
            )));
        }
    }
}

pub fn shift_imm(op: String, register: RegisterValue, shift: i64) -> RegisterValue {
    match op.as_str() {
        "lsl" => {
            let new_offset = register.offset << shift;
            RegisterValue {
                kind: register.kind,
                base: Some(generate_expression(
                    &op,
                    register.base.unwrap_or(AbstractExpression::Empty),
                    AbstractExpression::Immediate(shift),
                )),
                offset: new_offset,
            }
        }
        "lsr" => {
            let new_offset = register.offset >> shift;
            RegisterValue {
                kind: register.kind,
                base: Some(generate_expression(
                    &op,
                    register.base.unwrap_or(AbstractExpression::Empty),
                    AbstractExpression::Immediate(shift),
                )),
                offset: new_offset,
            }
        }
        "ror" => {
            let new_offset = register.offset >> shift;
            RegisterValue {
                kind: register.kind,
                base: Some(generate_expression(
                    &op,
                    register.base.unwrap_or(AbstractExpression::Empty),
                    AbstractExpression::Immediate(shift),
                )),
                offset: new_offset,
            }
        }
        "" => {
            let new_offset = register.offset + shift;
            RegisterValue {
                kind: register.kind,
                base: register.base,
                offset: new_offset,
            }
        }
        "uxtw" => {
            // TODO
            RegisterValue {
                kind: register.kind,
                base: register.base,
                offset: register.offset,
            }
        }
        _ => todo!("unsupported extend or shift operator {op}"),
    }
}
