use crate::x86::computer::*;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Carry {
    Cleared,
    Kept,
    Unknown,
}

fn real(b: bool) -> Option<FlagValue> {
    Some(FlagValue::Real(b))
}

fn compare(op: &str, left: AbstractExpression, right: AbstractExpression) -> Option<FlagValue> {
    Some(FlagValue::Abstract(AbstractComparison::new(
        op, left, right,
    )))
}

fn mask(width: i64) -> u64 {
    if width >= 8 {
        u64::MAX
    } else {
        (1u64 << (width * 8)) - 1
    }
}

fn signed(value: i64, width: i64) -> i64 {
    sign_extend(&RegisterValue::new_imm(value), width).offset
}

fn half_range(width: i64) -> i128 {
    1i128 << (width * 8 - 1)
}

fn overflows(exact: i128, width: i64) -> bool {
    !(-half_range(width)..half_range(width)).contains(&exact)
}

fn is_constant(value: &RegisterValue) -> bool {
    value.kind == RegisterKind::Immediate && value.base.is_none()
}

fn combined(
    op: &str,
    left: AbstractExpression,
    right: AbstractExpression,
    extra: i64,
) -> AbstractExpression {
    let exact = generate_expression(op, left, right);
    if extra == 0 {
        exact
    } else {
        generate_expression(op, exact, AbstractExpression::Immediate(extra))
    }
}

impl X86_64 {
    pub fn set_unknown_flags(&mut self) {
        let flag = |s: &mut Self, which: &str| {
            let symbol = s.fresh(&format!("{which}_flag"));
            compare("==", symbol, AbstractExpression::Immediate(1))
        };
        self.zero = flag(self, "zero");
        self.neg = flag(self, "neg");
        self.carry = flag(self, "carry");
        self.overflow = flag(self, "overflow");
    }

    pub fn set_carry(&mut self, value: Option<bool>) {
        self.carry = match value {
            Some(b) => real(b),
            None => {
                let symbol = self.fresh("carry_flag");
                compare("==", symbol, AbstractExpression::Immediate(1))
            }
        };
    }

    pub fn flags_of_compare(&mut self, dst: &RegisterValue, src: &RegisterValue, width: i64) {
        if dst == src && dst.kind != RegisterKind::Number {
            self.zero = real(true);
            self.neg = real(false);
            self.carry = real(false);
            self.overflow = real(false);
            return;
        }
        match (&dst.kind, &src.kind) {
            (RegisterKind::Number, _) | (_, RegisterKind::Number) => self.set_unknown_flags(),
            (RegisterKind::Immediate, RegisterKind::Immediate) => {
                let (a, b) = (
                    dst.offset as u64 & mask(width),
                    src.offset as u64 & mask(width),
                );
                let (sa, sb) = (signed(dst.offset, width), signed(src.offset, width));
                self.zero = real(a == b);
                self.neg = real(sa < sb);
                self.carry = real(a < b);
                self.overflow = real(overflows(sa as i128 - sb as i128, width));
            }
            (RegisterKind::RegisterBase, RegisterKind::RegisterBase)
                if dst.base == src.base && width == 8 =>
            {
                self.zero = real(dst.offset == src.offset);
                self.neg = real(dst.offset < src.offset);
                self.carry = real(dst.offset < src.offset);
                self.overflow = real(false);
            }
            _ => {
                let left = AbstractExpression::Register(Box::new(dst.clone()));
                let right = AbstractExpression::Register(Box::new(src.clone()));
                let difference = generate_expression("-", left.clone(), right.clone());
                self.zero = compare("==", difference.clone(), AbstractExpression::Immediate(0));
                self.neg = compare("<", difference, AbstractExpression::Immediate(0));
                self.carry = compare("<", left, right);
                self.set_signed_order("-", (dst, src, 0), width, true);
            }
        }
    }

    pub fn set_signed_order(
        &mut self,
        op: &str,
        (dst, src, extra): (&RegisterValue, &RegisterValue, i64),
        width: i64,
        neg_is_the_result_sign: bool,
    ) {
        if dst.kind == RegisterKind::Number || src.kind == RegisterKind::Number {
            self.forget_signed_order();
            return;
        }
        if is_constant(dst) && is_constant(src) {
            let step = |x: i128, y: i128| if op == "+" { x + y } else { x - y };
            let exact = step(
                step(
                    signed(dst.offset, width) as i128,
                    signed(src.offset, width) as i128,
                ),
                extra as i128,
            );
            self.neg = real(exact < 0);
            self.overflow = real(overflows(exact, width));
            return;
        }
        let raw = combined(
            op,
            AbstractExpression::Register(Box::new(dst.clone())),
            AbstractExpression::Register(Box::new(src.clone())),
            extra,
        );
        if !neg_is_the_result_sign {
            self.neg = compare("<", raw.clone(), AbstractExpression::Immediate(0));
        }
        if width >= 8 {
            self.overflow = Some(FlagValue::Abstract(outside_signed_range(raw, 64)));
            return;
        }
        if self.stays_below_the_sign_bit(&[dst, src], &raw, width) {
            self.overflow = real(false);
            return;
        }
        let view = |value: &RegisterValue| {
            AbstractExpression::Register(Box::new(sign_extend(value, width)))
        };
        let exact = combined(op, view(dst), view(src), extra);
        self.neg = compare("<", exact.clone(), AbstractExpression::Immediate(0));
        self.overflow = Some(FlagValue::Abstract(outside_signed_range(
            exact,
            (width * 8) as u32,
        )));
    }

    pub fn forget_signed_order(&mut self) {
        self.neg = Some(self.unknown_condition());
        self.overflow = Some(self.unknown_condition());
    }

    fn stays_below_the_sign_bit(
        &self,
        operands: &[&RegisterValue],
        result: &AbstractExpression,
        width: i64,
    ) -> bool {
        let half = half_range(width) as i64;
        let mut outside = Vec::new();
        for operand in operands {
            let Some(value) = expression_to_ast(operand.expression()) else {
                return false;
            };
            outside.push(value.lt(ast::Int::from_i64(0)));
            outside.push(value.ge(ast::Int::from_i64(half)));
        }
        let Some(value) = expression_to_ast(result.clone()) else {
            return false;
        };
        outside.push(value.lt(ast::Int::from_i64(-half)));
        outside.push(value.ge(ast::Int::from_i64(half)));
        let any = ast::Bool::or(&outside.iter().collect::<Vec<_>>());
        check(&self.solver, &[any]) == SatResult::Unsat
    }

    pub fn flags_of_result(&mut self, result: &RegisterValue, width: i64, carry: Carry) {
        let carry_flag = match carry {
            Carry::Kept => self.carry.clone(),
            Carry::Cleared => real(false),
            _ => None,
        };
        match result.kind {
            RegisterKind::Number => {
                self.set_unknown_flags();
                if carry == Carry::Kept || carry == Carry::Cleared {
                    self.carry = carry_flag;
                }
                if carry == Carry::Cleared {
                    self.overflow = real(false);
                }
                return;
            }
            RegisterKind::Immediate => {
                let value = result.offset as u64 & mask(width);
                self.zero = real(value == 0);
                self.neg = real(signed(result.offset, width) < 0);
                self.overflow = real(false);
            }
            RegisterKind::RegisterBase => {
                let signed = AbstractExpression::Register(Box::new(sign_extend(result, width)));
                self.zero = compare("==", signed.clone(), AbstractExpression::Immediate(0));
                self.neg = compare("<", signed, AbstractExpression::Immediate(0));
                self.overflow = real(false);
            }
        }
        self.carry = match carry {
            Carry::Kept | Carry::Cleared => carry_flag,
            Carry::Unknown => {
                let symbol = self.fresh("carry_flag");
                compare("==", symbol, AbstractExpression::Immediate(1))
            }
        };
    }

    pub fn set_arithmetic_carry(
        &mut self,
        add: bool,
        (dst, src, result): (&RegisterValue, &RegisterValue, &RegisterValue),
        width: i64,
    ) {
        let largest = mask(width);
        self.carry = match (&dst.kind, &src.kind) {
            (RegisterKind::Immediate, RegisterKind::Immediate) => {
                let (a, b) = (dst.offset as u64 & largest, src.offset as u64 & largest);
                real(if add {
                    a.checked_add(b).is_none_or(|sum| sum > largest)
                } else {
                    a < b
                })
            }
            (RegisterKind::Number, _) | (_, RegisterKind::Number) => {
                let symbol = self.fresh("carry_flag");
                compare("==", symbol, AbstractExpression::Immediate(1))
            }
            _ => {
                let (left, right) = if width >= 8 {
                    (
                        AbstractExpression::Register(Box::new(result.clone())),
                        AbstractExpression::Immediate(0),
                    )
                } else {
                    (
                        AbstractExpression::Register(Box::new(dst.clone())),
                        AbstractExpression::Register(Box::new(src.clone())),
                    )
                };
                if add {
                    let beyond = AbstractExpression::Expression(
                        "+".to_string(),
                        Box::new(AbstractExpression::Expression(
                            "*".to_string(),
                            Box::new(AbstractExpression::Immediate((largest / 2) as i64)),
                            Box::new(AbstractExpression::Immediate(2)),
                        )),
                        Box::new(AbstractExpression::Immediate(1)),
                    );
                    compare(">", generate_expression("+", left, right), beyond)
                } else {
                    compare("<", left, right)
                }
            }
        };
    }

    pub fn condition(&mut self, cc: &str) -> Result<FlagValue, String> {
        let unset = || format!("condition {cc} reads a flag the program never set");
        let negate = |f: FlagValue| f.not();
        let flag = |f: &Option<FlagValue>| f.clone().ok_or_else(unset);
        Ok(match cc {
            "e" | "z" => flag(&self.zero)?,
            "ne" | "nz" => negate(flag(&self.zero)?),
            "s" => self.sign()?,
            "ns" => negate(self.sign()?),
            "b" | "c" | "nae" => flag(&self.carry)?,
            "ae" | "nb" | "nc" => negate(flag(&self.carry)?),
            "o" => flag(&self.overflow)?,
            "no" => negate(flag(&self.overflow)?),
            "be" | "na" => self.below_or_equal()?,
            "a" | "nbe" => negate(self.below_or_equal()?),
            "l" | "nge" => self.less()?,
            "ge" | "nl" => negate(self.less()?),
            "le" | "ng" => self.less_or_equal()?,
            "g" | "nle" => negate(self.less_or_equal()?),
            "p" | "pe" | "np" | "po" => self.unknown_condition(),
            _ => return Err(format!("unknown condition code {cc}")),
        })
    }

    fn unknown_condition(&mut self) -> FlagValue {
        let symbol = self.fresh("condition");
        FlagValue::Abstract(AbstractComparison::new(
            "==",
            symbol,
            AbstractExpression::Immediate(1),
        ))
    }

    fn ordered(&self, strict: &Option<FlagValue>, op: &str) -> Option<FlagValue> {
        let (Some(FlagValue::Abstract(z)), Some(FlagValue::Abstract(s))) = (&self.zero, strict)
        else {
            return None;
        };
        if z.op != "==" || s.op != "<" {
            return None;
        }
        let difference = generate_expression("-", *s.left.clone(), *s.right.clone());
        let same = (z.left == s.left && z.right == s.right)
            || (*z.left == difference && *z.right == AbstractExpression::Immediate(0));
        same.then(|| {
            FlagValue::Abstract(AbstractComparison::new(
                op,
                *s.left.clone(),
                *s.right.clone(),
            ))
        })
    }

    fn below_or_equal(&mut self) -> Result<FlagValue, String> {
        let (carry, zero) = match (&self.carry, &self.zero) {
            (Some(c), Some(z)) => (c.clone(), z.clone()),
            _ => return Err("unsigned comparison reads a flag the program never set".to_string()),
        };
        Ok(match (carry, zero) {
            (_, FlagValue::Real(true)) => FlagValue::Real(true),
            (FlagValue::Real(false), z) => z,
            (c, FlagValue::Real(false)) => c,
            _ => match self.ordered(&self.carry.clone(), "<=") {
                Some(f) => f,
                None => self.unknown_condition(),
            },
        })
    }

    fn sign(&mut self) -> Result<FlagValue, String> {
        match (&self.neg, &self.overflow) {
            (Some(less), Some(FlagValue::Real(false))) => Ok(less.clone()),
            (Some(FlagValue::Real(less)), Some(FlagValue::Real(overflow))) => {
                Ok(FlagValue::Real(less != overflow))
            }
            (Some(less), Some(FlagValue::Abstract(overflow))) => {
                let refuted = comparison_to_ast(overflow.clone())
                    .is_some_and(|holds| check(&self.solver, &[holds]) == SatResult::Unsat);
                if refuted {
                    Ok(less.clone())
                } else {
                    Ok(self.unknown_condition())
                }
            }
            _ => Err("sign condition reads a flag the program never set".to_string()),
        }
    }

    fn less(&mut self) -> Result<FlagValue, String> {
        match (&self.neg, &self.overflow) {
            (Some(less), Some(_)) => Ok(less.clone()),
            _ => Err("signed comparison reads a flag the program never set".to_string()),
        }
    }

    fn less_or_equal(&mut self) -> Result<FlagValue, String> {
        let less = self.less()?;
        let zero = self
            .zero
            .clone()
            .ok_or("signed comparison reads an unset zero flag")?;
        Ok(match (less, zero) {
            (_, FlagValue::Real(true)) | (FlagValue::Real(true), _) => FlagValue::Real(true),
            (FlagValue::Real(false), z) => z,
            (l, FlagValue::Real(false)) => l,
            _ => match self.ordered(&self.neg.clone(), "<=") {
                Some(f) => f,
                None => self.unknown_condition(),
            },
        })
    }
}
