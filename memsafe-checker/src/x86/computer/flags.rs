use crate::x86::computer::*;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Carry {
    Cleared,
    Borrow,
    Overflowed,
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
                self.overflow = real(false);
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
                self.overflow = real(false);
            }
        }
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
                let value = AbstractExpression::Register(Box::new(result.clone()));
                self.zero = compare("==", value.clone(), AbstractExpression::Immediate(0));
                self.neg = compare("<", value, AbstractExpression::Immediate(0));
                self.overflow = real(false);
            }
        }
        let value = AbstractExpression::Register(Box::new(result.clone()));
        self.carry = match carry {
            Carry::Kept | Carry::Cleared => carry_flag,
            Carry::Borrow => match result.kind {
                RegisterKind::Immediate => real(false),
                _ => compare("<", value, AbstractExpression::Immediate(0)),
            },
            Carry::Overflowed => match result.kind {
                RegisterKind::Immediate => real(false),
                _ => compare(">", value, AbstractExpression::Immediate(i64::MAX)),
            },
            Carry::Unknown => {
                let symbol = self.fresh("carry_flag");
                compare("==", symbol, AbstractExpression::Immediate(1))
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
            "s" => flag(&self.neg)?,
            "ns" => negate(flag(&self.neg)?),
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

    fn less(&mut self) -> Result<FlagValue, String> {
        match (&self.neg, &self.overflow) {
            (Some(n), Some(FlagValue::Real(false))) => Ok(n.clone()),
            (Some(FlagValue::Real(n)), Some(FlagValue::Real(o))) => Ok(FlagValue::Real(n != o)),
            (Some(_), Some(_)) => Ok(self.unknown_condition()),
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
            _ => match (self.overflow.clone(), self.ordered(&self.neg.clone(), "<=")) {
                (Some(FlagValue::Real(false)), Some(f)) => f,
                _ => self.unknown_condition(),
            },
        })
    }
}
