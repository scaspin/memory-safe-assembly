use crate::x86::computer::flags::Carry;
use crate::x86::computer::memory::add_values;
use crate::x86::computer::*;

type Step = Result<ExecuteReturnType<Operand>, String>;

const WIDEST_LOWEST_BIT_CASE: i64 = 62;

fn translatable_mask(mask: i64) -> bool {
    let low_bits = mask > 0 && (mask as u64).wrapping_add(1).is_power_of_two();
    let single = mask > 0 && (mask as u64).is_power_of_two();
    let cleared = mask < 0 && (!mask as u64).is_power_of_two();
    low_bits || single || cleared
}

fn alignment_mask(mask: i64) -> Option<i64> {
    (mask < 0 && (mask.wrapping_neg() as u64).is_power_of_two() && mask != i64::MIN)
        .then(|| mask.wrapping_neg())
}

pub fn combine(op: &str, a: &RegisterValue, b: &RegisterValue) -> RegisterValue {
    use RegisterKind::*;
    if a.kind == Number || b.kind == Number {
        return unknown();
    }
    if a.kind == Immediate && b.kind == Immediate {
        let (x, y) = (a.offset, b.offset);
        let v = match op {
            "+" => x.wrapping_add(y),
            "-" => x.wrapping_sub(y),
            "*" => x.wrapping_mul(y),
            "&" => x & y,
            "|" => x | y,
            "^" => x ^ y,
            _ => return unknown(),
        };
        return RegisterValue::new_imm(v);
    }
    match op {
        "+" | "-" => {
            let negate = op == "-";
            let base = match (&a.base, &b.base) {
                (Some(x), Some(y)) => Some(generate_expression(op, x.clone(), y.clone())),
                (Some(x), None) => Some(x.clone()),
                (None, Some(y)) if negate => Some(generate_expression(
                    "-",
                    AbstractExpression::Immediate(0),
                    y.clone(),
                )),
                (None, Some(y)) => Some(y.clone()),
                (None, None) => None,
            };
            let offset = if negate {
                a.offset.wrapping_sub(b.offset)
            } else {
                a.offset.wrapping_add(b.offset)
            };
            RegisterValue::new(RegisterBase, base, offset)
        }
        "*" => {
            let (value, factor) = match (&a.kind, &b.kind) {
                (RegisterBase, Immediate) => (a, b.offset),
                (Immediate, RegisterBase) => (b, a.offset),
                _ => {
                    return RegisterValue::new(
                        RegisterBase,
                        Some(generate_expression("*", a.expression(), b.expression())),
                        0,
                    );
                }
            };
            let base = value
                .base
                .clone()
                .map(|base| generate_expression("*", base, AbstractExpression::Immediate(factor)));
            RegisterValue::new(RegisterBase, base, value.offset.wrapping_mul(factor))
        }
        "&" => {
            let (value, mask) = match (&a.kind, &b.kind) {
                (RegisterBase, Immediate) => (a, b.offset),
                (Immediate, RegisterBase) => (b, a.offset),
                _ => return unknown(),
            };
            if let Some(boundary) = alignment_mask(mask) {
                let whole = value.expression();
                let remainder = generate_expression(
                    "%",
                    whole.clone(),
                    AbstractExpression::Immediate(boundary),
                );
                return RegisterValue::new(
                    RegisterBase,
                    Some(generate_expression("-", whole, remainder)),
                    0,
                );
            }
            let low = mask.trailing_zeros();
            if mask > 0 && low > 0 && ((mask >> low) as u64).wrapping_add(1).is_power_of_two() {
                let field = 1i64 << low;
                let width = (mask >> low) + 1;
                let shifted = generate_expression(
                    "/",
                    value.expression(),
                    AbstractExpression::Immediate(field),
                );
                let kept = generate_expression("%", shifted, AbstractExpression::Immediate(width));
                return RegisterValue::new(
                    RegisterBase,
                    Some(generate_expression(
                        "*",
                        kept,
                        AbstractExpression::Immediate(field),
                    )),
                    0,
                );
            }
            if translatable_mask(mask) {
                return RegisterValue::new(
                    RegisterBase,
                    Some(generate_expression(
                        "&",
                        value.expression(),
                        AbstractExpression::Immediate(mask),
                    )),
                    0,
                );
            }
            unknown()
        }
        "^" | "|" => {
            let (value, constant) = match (&a.kind, &b.kind) {
                (RegisterBase, Immediate) => (a, b.offset),
                (Immediate, RegisterBase) => (b, a.offset),
                _ => return unknown(),
            };
            if constant > 0 && (constant as u64).count_ones() <= 16 {
                RegisterValue::new(
                    RegisterBase,
                    Some(generate_expression(
                        op,
                        value.expression(),
                        AbstractExpression::Immediate(constant),
                    )),
                    0,
                )
            } else {
                unknown()
            }
        }
        _ => unknown(),
    }
}

fn shift_by_register(value: &RegisterValue, count: &RegisterValue, width: i64) -> RegisterValue {
    if value.kind == RegisterKind::Number || count.kind == RegisterKind::Number {
        return unknown();
    }
    let bits = if width == 8 { 64 } else { 32 };
    let amount = generate_expression("%", count.expression(), AbstractExpression::Immediate(bits));
    RegisterValue::new(
        RegisterKind::RegisterBase,
        Some(generate_expression("lsl", value.expression(), amount)),
        0,
    )
}

fn enabled_bytes(mnemonic: &str, mask: &RegisterValue, width: i64) -> Option<AbstractExpression> {
    let element = match mnemonic {
        "vmovdqu8" => 1,
        "vmovdqu16" => 2,
        "vmovdqu32" => 4,
        "vmovdqu64" => 8,
        _ => return None,
    };
    let lanes = AbstractExpression::Immediate(width / element);
    let enabled = match (&mask.kind, &mask.base, mask.offset) {
        (RegisterKind::Immediate, None, bits)
            if bits >= 0 && (bits as u64).wrapping_add(1).is_power_of_two() =>
        {
            AbstractExpression::Immediate((bits as u64).wrapping_add(1).trailing_zeros() as i64)
        }
        (RegisterKind::RegisterBase, Some(AbstractExpression::Expression(op, one, w)), -1)
            if op == "lsl" && **one == AbstractExpression::Immediate(1) =>
        {
            (**w).clone()
        }
        _ => return None,
    };
    Some(generate_expression(
        "*",
        generate_expression("atmost", enabled, lanes),
        AbstractExpression::Immediate(element),
    ))
}

fn shift(op: &str, value: &RegisterValue, count: i64, width: i64) -> RegisterValue {
    let count = count & if width == 8 { 63 } else { 31 };
    if count == 0 {
        return value.clone();
    }
    match value.kind {
        RegisterKind::Number => unknown(),
        RegisterKind::Immediate => {
            let v = value.offset;
            let bits = (width * 8) as u32;
            let low = if width >= 8 {
                v as u64
            } else {
                (v as u64) & ((1u64 << bits) - 1)
            };
            let c = count as u32;
            RegisterValue::new_imm(match op {
                "shl" | "sal" => (low << c) as i64,
                "shr" => (low >> c) as i64,
                "sar" => sign_extend(&RegisterValue::new_imm(v), width).offset >> c,
                "rol" if width >= 8 => low.rotate_left(c) as i64,
                "ror" if width >= 8 => low.rotate_right(c) as i64,
                "rol" if width == 4 => (low as u32).rotate_left(c) as i64,
                "ror" if width == 4 => (low as u32).rotate_right(c) as i64,
                _ => return unknown(),
            })
        }
        RegisterKind::RegisterBase => {
            let shifted = |shift: &str, v: &RegisterValue| {
                RegisterValue::new(
                    RegisterKind::RegisterBase,
                    Some(generate_expression(
                        shift,
                        v.expression(),
                        AbstractExpression::Immediate(count),
                    )),
                    0,
                )
            };
            match op {
                "shl" | "sal" if count < 62 => {
                    combine("*", value, &RegisterValue::new_imm(1 << count))
                }
                "shr" => shifted("lsr", value),
                "sar" => shifted("asr", &sign_extend(value, width)),
                _ => unknown(),
            }
        }
    }
}

fn condition_code<'a>(mnemonic: &'a str, stem: &str) -> Option<&'a str> {
    mnemonic
        .strip_prefix(stem)
        .filter(|cc| CONDITION_CODES.contains(cc))
}

fn vector_access_width(i: &Instruction) -> i64 {
    let m = i.mnemonic.trim_start_matches('v');
    let widest = i
        .operands
        .iter()
        .filter_map(|o| o.register().filter(|r| r.is_vector()).map(|r| r.width()))
        .max()
        .unwrap_or(16);
    match m {
        "movd" | "movss" | "pinsrd" | "pextrd" | "broadcastss" | "pbroadcastd" | "insertps"
        | "extractps" | "cvtsi2ssl" | "cvtsi2sdl" => 4,
        "movq" | "movsd" | "pinsrq" | "pextrq" | "movhps" | "movlps" | "movhpd" | "movlpd"
        | "broadcastsd" | "pbroadcastq" | "movddup" | "cvtsi2ssq" | "cvtsi2sdq" => 8,
        "pinsrb" | "pextrb" | "pbroadcastb" => 1,
        "pinsrw" | "pextrw" | "pbroadcastw" => 2,
        "broadcasti128" | "broadcastf128" | "inserti128" | "insertf128" | "extracti128"
        | "extractf128" | "broadcasti32x4" | "broadcastf32x4" | "broadcasti64x2"
        | "broadcastf64x2" | "inserti32x4" | "inserti64x2" | "extracti32x4" | "extracti64x2" => 16,
        "pmovzxbw" | "pmovsxbw" | "pmovzxwd" | "pmovsxwd" | "pmovzxdq" | "pmovsxdq" => widest / 2,
        "pmovzxbd" | "pmovsxbd" | "pmovzxwq" | "pmovsxwq" => widest / 4,
        "pmovzxbq" | "pmovsxbq" => widest / 8,
        "cvtph2ps" => widest / 2,
        "cvtsd2ss" | "cvtsd2si" | "cvttsd2si" => 8,
        "cvtss2sd" | "cvtss2si" | "cvttss2si" => 4,
        m if !m.starts_with('p') && m.ends_with("sd") => 8,
        m if !m.starts_with('p') && m.ends_with("ss") => 4,
        _ => widest,
    }
}

fn vector_reads_only(mnemonic: &str) -> bool {
    matches!(
        mnemonic.trim_start_matches('v'),
        "ptest"
            | "testps"
            | "testpd"
            | "ucomiss"
            | "ucomisd"
            | "comiss"
            | "comisd"
            | "pcmpestri"
            | "pcmpistri"
            | "pcmpestrm"
            | "pcmpistrm"
    )
}

fn vector_copies(mnemonic: &str) -> bool {
    matches!(
        mnemonic.trim_start_matches('v'),
        "movq"
            | "movd"
            | "movdqa"
            | "movdqu"
            | "movaps"
            | "movups"
            | "movapd"
            | "movupd"
            | "movdqa64"
            | "movdqu64"
            | "movdqa32"
            | "movdqu32"
            | "movdqu8"
    )
}

impl X86_64 {
    pub fn execute(&mut self, pc: usize, instruction: &Instruction) -> Step {
        let ops = &instruction.operands;
        let m = instruction.mnemonic.as_str();
        let width = instruction.operand_width().unwrap_or(8);

        if let Some(cc) = condition_code(m, "j") {
            return self.conditional_jump(cc, ops);
        }
        if let Some(cc) = condition_code(m, "cmov") {
            return self.cmov(cc, ops, width);
        }
        if let Some(cc) = condition_code(m, "set") {
            return self.setcc(cc, ops);
        }

        match m {
            "nop" | "endbr64" | "pause" | "lfence" | "mfence" | "sfence" | "vzeroupper"
            | "vzeroall" | "emms" | "cld" => (),
            _ if m.starts_with("prefetch") => (),
            _ if m.starts_with('f') => self.x87(instruction)?,
            "ud2" | "int3" | "hlt" => return Ok(ExecuteReturnType::Trap),

            "mov" | "movabs" => {
                let value = self.read(&ops[0], width)?;
                self.write(&ops[1], width, value)?;
                if ops[0].is_memory() {
                    self.mark_loaded(&ops[1]);
                }
            }
            "movzxb" | "movzxw" | "movsxb" | "movsxw" | "movsxl" => {
                let from = match m.chars().last() {
                    Some('b') => 1,
                    Some('w') => 2,
                    _ => 4,
                };
                let value = self.read(&ops[0], from)?;
                let value = if m.starts_with("movz") {
                    narrow(&value, from, false)
                } else {
                    sign_extend(&value, from)
                };
                self.write(&ops[1], width, value)?;
                if ops[0].is_memory() {
                    self.mark_loaded(&ops[1]);
                }
            }
            "movzx" | "movsx" | "movsxd" => {
                let from = ops[0].register().map(|r| r.width()).unwrap_or(1);
                let value = self.read(&ops[0], from)?;
                let value = if m == "movzx" {
                    narrow(&value, from, false)
                } else {
                    sign_extend(&value, from)
                };
                self.write(&ops[1], width, value)?;
                if ops[0].is_memory() {
                    self.mark_loaded(&ops[1]);
                }
            }
            "cltq" | "cdqe" => {
                let value = sign_extend(&self.read_gpr(RAX, 4, false), 4);
                self.write_gpr(RAX, 8, false, value);
            }
            "cwtl" | "cwde" => {
                let value = sign_extend(&self.read_gpr(RAX, 2, false), 2);
                self.write_gpr(RAX, 4, false, value);
            }
            "cqto" | "cqo" | "cltd" | "cdq" => self.registers[RDX] = unknown(),
            "lea" => {
                let Operand::Memory(memory) = &ops[0] else {
                    return Err("lea needs a memory operand".to_string());
                };
                let address = self.effective_address(memory)?;
                self.write(&ops[1], width, address)?;
            }

            "add" | "sub" | "and" | "or" | "xor" => {
                let src = self.read(&ops[0], width)?;
                let dst = self.read(&ops[1], width)?;
                let same_register = ops[0] == ops[1] && !ops[0].is_memory();
                let result = match (m, same_register) {
                    ("sub" | "xor", true) => RegisterValue::new_imm(0),
                    ("and" | "or", true) => dst.clone(),
                    _ => {
                        let op = match m {
                            "add" => "+",
                            "sub" => "-",
                            "and" => "&",
                            "or" => "|",
                            _ => "^",
                        };
                        let r = combine(op, &dst, &src);
                        if m == "and"
                            && ops[1] == Operand::Register(gpr(RSP, 8))
                            && dst.base == Some(abstract_of(STACK))
                            && src.kind == RegisterKind::Immediate
                            && alignment_mask(src.offset).is_some()
                        {
                            RegisterValue::new(
                                dst.kind.clone(),
                                dst.base.clone(),
                                dst.offset & src.offset,
                            )
                        } else {
                            r
                        }
                    }
                };
                self.write(&ops[1], width, result)?;
                let written = self.read(&ops[1], width)?;
                let carry = match m {
                    "add" => Carry::Overflowed,
                    "sub" => Carry::Borrow,
                    _ => Carry::Cleared,
                };
                self.flags_of_result(&written, width, carry);
            }
            "adc" | "sbb" => return self.with_carry(m, ops, width),
            "adcx" | "adox" => {
                let src = self.read(&ops[0], width)?;
                let dst = self.read(&ops[1], width)?;
                let carry = if m == "adcx" {
                    &self.carry
                } else {
                    &self.overflow
                };
                let result = match carry {
                    Some(FlagValue::Real(c)) => {
                        let sum = combine("+", &dst, &src);
                        combine("+", &sum, &RegisterValue::new_imm(*c as i64))
                    }
                    _ => unknown(),
                };
                self.write(&ops[1], width, result)?;
                let flag = Some(FlagValue::Abstract(AbstractComparison::new(
                    "==",
                    self.fresh("carry_flag"),
                    AbstractExpression::Immediate(1),
                )));
                if m == "adcx" {
                    self.carry = flag;
                } else {
                    self.overflow = flag;
                }
            }
            "inc" | "dec" => {
                let dst = self.read(&ops[0], width)?;
                let step = RegisterValue::new_imm(1);
                let result = combine(if m == "inc" { "+" } else { "-" }, &dst, &step);
                self.write(&ops[0], width, result)?;
                let written = self.read(&ops[0], width)?;
                self.flags_of_result(&written, width, Carry::Kept);
            }
            "neg" => {
                let dst = self.read(&ops[0], width)?;
                let result = combine("-", &RegisterValue::new_imm(0), &dst);
                self.write(&ops[0], width, result)?;
                let written = self.read(&ops[0], width)?;
                self.flags_of_result(&written, width, Carry::Unknown);
                if dst.kind == RegisterKind::Immediate {
                    self.set_carry(Some(dst.offset != 0));
                }
            }
            "not" => {
                let dst = self.read(&ops[0], width)?;
                let result = match dst.kind {
                    RegisterKind::Immediate => RegisterValue::new_imm(!dst.offset),
                    _ => unknown(),
                };
                self.write(&ops[0], width, result)?;
            }
            "cmp" => {
                let src = self.read(&ops[0], width)?;
                let dst = self.read(&ops[1], width)?;
                self.flags_of_compare(&dst, &src, width);
            }
            "test" => {
                let src = self.read(&ops[0], width)?;
                let dst = self.read(&ops[1], width)?;
                let result = if ops[0] == ops[1] {
                    dst
                } else {
                    combine("&", &dst, &src)
                };
                self.flags_of_result(&result, width, Carry::Cleared);
            }
            "bt" | "bts" | "btr" | "btc" => {
                let _ = self.read(&ops[1], width)?;
                if m != "bt" {
                    self.write(&ops[1], width, unknown())?;
                }
                self.set_carry(None);
            }

            "shl" | "sal" | "shr" | "sar" | "rol" | "ror" | "rcl" | "rcr" => {
                let (count, target) = match ops.len() {
                    1 => (Some(1), &ops[0]),
                    _ => {
                        let c = self.read(&ops[0], 1)?;
                        let count = (c.kind == RegisterKind::Immediate).then_some(c.offset);
                        (count, &ops[1])
                    }
                };
                let dst = self.read(target, width)?;
                let result = match count {
                    Some(c) if !m.starts_with("rc") => shift(m, &dst, c, width),
                    None if (m == "shl" || m == "sal") && ops.len() == 2 => {
                        let c = self.read(&ops[0], 1)?;
                        shift_by_register(&dst, &c, width)
                    }
                    _ => unknown(),
                };
                self.write(target, width, result.clone())?;
                if count.is_none_or(|c| c & 63 != 0) {
                    let written = self.read(target, width)?;
                    if m.starts_with("ro") || m.starts_with("rc") {
                        self.set_carry(None);
                    } else {
                        self.flags_of_result(&written, width, Carry::Unknown);
                    }
                }
            }
            "shld" | "shrd" => {
                let target = ops.last().expect("shld destination");
                let _ = self.read(target, width)?;
                self.write(target, width, unknown())?;
                self.set_unknown_flags();
            }
            "tzcnt" | "bsf" => {
                let src = self.read(&ops[0], width)?;
                let dst = ops.last().expect("destination");
                let value = match src.kind {
                    RegisterKind::Immediate if src.offset != 0 => {
                        RegisterValue::new_imm(src.offset.trailing_zeros() as i64)
                    }
                    RegisterKind::RegisterBase => {
                        let mut cases = self.lowest_set_bit_cases(&src, width);
                        match cases.len() {
                            1 => cases
                                .pop()
                                .and_then(|(_, bit)| bit)
                                .map_or_else(unknown, RegisterValue::new_imm),
                            _ => {
                                return Ok(ExecuteReturnType::Split(
                                    cases.into_iter().map(|(case, _)| case).collect(),
                                ));
                            }
                        }
                    }
                    _ => unknown(),
                };
                self.write(dst, width, value)?;
                self.set_unknown_flags();
            }
            "sarx" | "shlx" | "shrx" | "rorx" | "andn" | "bzhi" | "popcnt" | "lzcnt" | "bsr" => {
                for source in &ops[..ops.len() - 1] {
                    self.read(source, width)?;
                }
                self.write(ops.last().expect("destination"), width, unknown())?;
                if !matches!(m, "sarx" | "shlx" | "shrx" | "rorx") {
                    self.set_unknown_flags();
                }
            }
            "bswap" => {
                let dst = self.read(&ops[0], width)?;
                let result = match dst.kind {
                    RegisterKind::Immediate if width == 8 => {
                        RegisterValue::new_imm(dst.offset.swap_bytes())
                    }
                    RegisterKind::Immediate => {
                        RegisterValue::new_imm((dst.offset as u32).swap_bytes() as i64)
                    }
                    _ => unknown(),
                };
                self.write(&ops[0], width, result)?;
            }

            "imul" => {
                match ops.len() {
                    1 => {
                        let src = self.read(&ops[0], width)?;
                        let rax = self.read_gpr(RAX, width, false);
                        let product = combine("*", &rax, &src);
                        self.write_gpr(RAX, width, false, product);
                        self.write_gpr(RDX, width, false, unknown());
                    }
                    2 => {
                        let src = self.read(&ops[0], width)?;
                        let dst = self.read(&ops[1], width)?;
                        self.write(&ops[1], width, combine("*", &dst, &src))?;
                    }
                    _ => {
                        let factor = self.read(&ops[0], width)?;
                        let src = self.read(&ops[1], width)?;
                        self.write(&ops[2], width, combine("*", &src, &factor))?;
                    }
                }
                self.set_unknown_flags();
            }
            "mul" => {
                let src = self.read(&ops[0], width)?;
                let rax = self.read_gpr(RAX, width, false);
                let low = match (&rax.kind, &src.kind) {
                    (RegisterKind::Immediate, RegisterKind::Immediate) => {
                        RegisterValue::new_imm(rax.offset.wrapping_mul(src.offset))
                    }
                    _ => unknown(),
                };
                self.write_gpr(RAX, width, false, low);
                self.write_gpr(RDX, width, false, unknown());
                self.set_unknown_flags();
            }
            "mulx" => {
                self.read(&ops[0], width)?;
                self.write(&ops[1], width, unknown())?;
                self.write(&ops[2], width, unknown())?;
            }
            "div" | "idiv" => {
                self.read(&ops[0], width)?;
                self.write_gpr(RAX, width, false, unknown());
                self.write_gpr(RDX, width, false, unknown());
                self.set_unknown_flags();
            }
            "xchg" => {
                let a = self.read(&ops[0], width)?;
                let b = self.read(&ops[1], width)?;
                self.write(&ops[0], width, b)?;
                self.write(&ops[1], width, a)?;
            }
            "xadd" | "cmpxchg" => {
                for o in ops {
                    self.read(o, width)?;
                    self.write(o, width, unknown())?;
                }
                if m == "cmpxchg" {
                    self.write_gpr(RAX, width, false, unknown());
                }
                self.set_unknown_flags();
            }

            "push" => {
                let value = self.read(&ops[0], 8)?;
                self.push(value)?;
            }
            "pop" => {
                let value = self.pop()?;
                self.write(&ops[0], 8, value)?;
            }
            "leave" => {
                self.registers[RSP] = self.registers[RBP].clone();
                let value = self.pop()?;
                self.registers[RBP] = value;
            }
            "call" => match ops.first() {
                Some(Operand::Label(label)) => {
                    self.push(RegisterValue::new(
                        RegisterKind::RegisterBase,
                        Some(abstract_of(RETURN_TO)),
                        (pc + 1) as i64,
                    ))?;
                    return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                }
                other => return Err(format!("indirect call through {other:?} is not modelled")),
            },
            "ret" => {
                let target = self.pop()?;
                if let Some(Operand::Immediate(n)) = ops.first() {
                    self.registers[RSP].offset += n;
                }
                return match (&target.kind, &target.base) {
                    (RegisterKind::RegisterBase, Some(AbstractExpression::Abstract(r)))
                        if r == RETURN && target.offset == 0 =>
                    {
                        Ok(ExecuteReturnType::JumpLabel(RETURN.to_string()))
                    }
                    (RegisterKind::RegisterBase, Some(AbstractExpression::Abstract(r)))
                        if r == RETURN_TO =>
                    {
                        Ok(ExecuteReturnType::JumpAddress(
                            u128::try_from(target.offset)
                                .map_err(|_| "ret to a negative address".to_string())?,
                        ))
                    }
                    _ => Err(format!(
                        "ret through an overwritten or unknown return address {target:?}"
                    )),
                };
            }
            "jmp" => match ops.first() {
                Some(Operand::Label(label)) => {
                    return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                }
                other => return Err(format!("indirect jump through {other:?} is not modelled")),
            },
            "jrcxz" | "jecxz" | "loop" => {
                let count_width = if m == "jecxz" { 4 } else { 8 };
                let mut count = self.read_gpr(RCX, count_width, false);
                if m == "loop" {
                    count = combine("-", &count, &RegisterValue::new_imm(1));
                    self.write_gpr(RCX, 8, false, count.clone());
                }
                let Some(Operand::Label(label)) = ops.first() else {
                    return Err(format!("{m} needs a label"));
                };
                let zero = match count.kind {
                    RegisterKind::Immediate => FlagValue::Real(count.offset == 0),
                    RegisterKind::RegisterBase => FlagValue::Abstract(AbstractComparison::new(
                        "==",
                        AbstractExpression::Register(Box::new(count)),
                        AbstractExpression::Immediate(0),
                    )),
                    RegisterKind::Number => FlagValue::Abstract(AbstractComparison::new(
                        "==",
                        self.fresh("count"),
                        AbstractExpression::Immediate(0),
                    )),
                };
                let jump_when = if m == "loop" { zero.not() } else { zero };
                return Ok(jump_on(jump_when, label));
            }

            "stos" | "movs" | "lods" | "cmps" | "scas" => {
                return self.string_operation(m, instruction);
            }

            "clc" => self.set_carry(Some(false)),
            "stc" => self.set_carry(Some(true)),
            "cmc" => {
                self.carry = self.carry.clone().map(|c| c.not());
            }
            "rdrand" | "rdseed" => {
                self.write(&ops[0], width, unknown())?;
                self.set_unknown_flags();
            }
            "cpuid" | "xgetbv" | "rdtsc" => {
                for r in [RAX, RBX, RCX, RDX] {
                    if m == "cpuid" || r == RAX || r == RDX {
                        self.registers[r] = unknown();
                    }
                }
            }

            "bums.vector_op" => {
                if ops[0].is_memory() {
                    self.read(&ops[0], 16)?;
                }
                if let Some(Operand::Register(Register::Vector { index, .. })) = ops.last() {
                    self.vectors[*index] = unknown();
                }
            }
            "movbe" => {
                self.read(&ops[0], width)?;
                self.write(&ops[1], width, unknown())?;
            }
            "bums.jump_table" => {
                let index = self.read(&ops[0], 8)?;
                let entries: Vec<(i64, String)> = instruction.operands[1..]
                    .iter()
                    .filter_map(|o| match o {
                        Operand::Label(l) => {
                            let (i, target) = l.split_once(':')?;
                            Some((i.parse().ok()?, target.to_string()))
                        }
                        _ => None,
                    })
                    .collect();
                return match index.kind {
                    RegisterKind::Immediate => entries
                        .iter()
                        .find(|(i, _)| *i == index.offset)
                        .map(|(_, target)| ExecuteReturnType::JumpLabel(target.clone()))
                        .ok_or_else(|| format!("jump table has no entry {}", index.offset)),
                    _ => Err(format!("jump table index of unknown value {index:?}")),
                };
            }
            "bums.encoded_memory_access" | "bums.encoded_unknown" => {
                return Err(format!(
                    "hand-encoded instruction {} is not modelled",
                    instruction.opcode
                ));
            }

            _ => return self.vector_or_unsupported(instruction),
        }
        Ok(ExecuteReturnType::Next)
    }

    fn lowest_set_bit_cases(
        &self,
        src: &RegisterValue,
        width: i64,
    ) -> Vec<(AbstractComparison, Option<i64>)> {
        let value = AbstractExpression::Register(Box::new(src.clone()));
        let low_bits = |bits: i64, equal: i64| {
            AbstractComparison::new(
                "==",
                generate_expression("%", value.clone(), AbstractExpression::Immediate(1 << bits)),
                AbstractExpression::Immediate(equal),
            )
        };
        let widest = (width * 8).min(WIDEST_LOWEST_BIT_CASE);
        (0..widest)
            .map(|bit| (low_bits(bit + 1, 1 << bit), Some(bit)))
            .chain([(low_bits(widest, 0), None)])
            .filter(|(case, _)| {
                comparison_to_ast(case.clone())
                    .is_some_and(|c| check(&self.solver, &[c]) != SatResult::Unsat)
            })
            .collect()
    }

    pub fn read(&mut self, operand: &Operand, width: i64) -> Result<RegisterValue, String> {
        match operand {
            Operand::Register(Register::Gpr {
                index,
                width: w,
                high,
            }) => Ok(self.read_gpr(*index, *w, *high)),
            Operand::Register(Register::Vector { index, .. }) => Ok(self.vectors[*index].clone()),
            Operand::Register(Register::Mask(k)) => Ok(self.masks[*k].clone()),
            Operand::Register(_) => Ok(unknown()),
            Operand::Immediate(v) => Ok(RegisterValue::new_imm(*v)),
            Operand::Memory(m) if m.segment => Ok(unknown()),
            Operand::Memory(m) => {
                let address = self.effective_address(m)?;
                self.load(&address, width)
            }
            other => Err(format!("cannot read operand {other:?}")),
        }
    }

    pub fn write(
        &mut self,
        operand: &Operand,
        width: i64,
        value: RegisterValue,
    ) -> Result<(), String> {
        match operand {
            Operand::Register(Register::Gpr {
                index,
                width: w,
                high,
            }) => {
                self.write_gpr(*index, *w, *high, value);
                Ok(())
            }
            Operand::Register(Register::Vector { index, .. }) => {
                self.vectors[*index] = value;
                Ok(())
            }
            Operand::Register(Register::Mask(k)) => {
                self.masks[*k] = value;
                Ok(())
            }
            Operand::Memory(m) if m.segment => {
                Err("write through a segment register is not modelled".to_string())
            }
            Operand::Memory(m) => {
                let address = self.effective_address(m)?;
                self.store(&address, width, value)
            }
            other => Err(format!("cannot write operand {other:?}")),
        }
    }

    fn push(&mut self, value: RegisterValue) -> Result<(), String> {
        self.registers[RSP].offset -= 8;
        let rsp = self.registers[RSP].clone();
        self.store(&rsp, 8, value)
    }

    fn pop(&mut self) -> Result<RegisterValue, String> {
        let rsp = self.registers[RSP].clone();
        let value = self.load(&rsp, 8)?;
        self.registers[RSP].offset += 8;
        Ok(value)
    }

    fn conditional_jump(&mut self, cc: &str, ops: &[Operand]) -> Step {
        let Some(Operand::Label(label)) = ops.first() else {
            return Err(format!(
                "conditional jump to {:?} is not modelled",
                ops.first()
            ));
        };
        let condition = self.condition(cc)?;
        Ok(jump_on(condition, label))
    }

    fn cmov(&mut self, cc: &str, ops: &[Operand], width: i64) -> Step {
        let src = self.read(&ops[0], width)?;
        let dst = self.read(&ops[1], width)?;
        match self.condition(cc)? {
            FlagValue::Real(true) => self.write(&ops[1], width, src)?,
            FlagValue::Real(false) => self.write(&ops[1], width, dst)?,
            FlagValue::Abstract(_) if src == dst => self.write(&ops[1], width, dst)?,
            FlagValue::Abstract(c) => {
                return Ok(ExecuteReturnType::Select(
                    c,
                    ops[1].clone(),
                    narrow(&src, width, false),
                    narrow(&dst, width, false),
                ));
            }
        }
        Ok(ExecuteReturnType::Next)
    }

    fn setcc(&mut self, cc: &str, ops: &[Operand]) -> Step {
        let condition = self.condition(cc)?;
        let target = &ops[0];
        if target.is_memory() {
            let value = match condition {
                FlagValue::Real(b) => RegisterValue::new_imm(b as i64),
                FlagValue::Abstract(_) => unknown(),
            };
            self.write(target, 1, value)?;
            return Ok(ExecuteReturnType::Next);
        }
        match condition {
            FlagValue::Real(b) => self.write(target, 1, RegisterValue::new_imm(b as i64))?,
            FlagValue::Abstract(c) => {
                return Ok(ExecuteReturnType::Select(
                    c,
                    target.clone(),
                    RegisterValue::new_imm(1),
                    RegisterValue::new_imm(0),
                ));
            }
        }
        Ok(ExecuteReturnType::Next)
    }

    fn with_carry(&mut self, m: &str, ops: &[Operand], width: i64) -> Step {
        let src = self.read(&ops[0], width)?;
        let dst = self.read(&ops[1], width)?;
        let op = if m == "adc" { "+" } else { "-" };
        let without = combine(op, &dst, &src);
        let with = combine(op, &without, &RegisterValue::new_imm(1));
        let carry = self.carry.clone();
        let result = match carry {
            Some(FlagValue::Real(c)) => {
                if c {
                    with
                } else {
                    without
                }
            }
            Some(FlagValue::Abstract(_)) if without.kind == RegisterKind::Number => without,
            Some(FlagValue::Abstract(c)) if !ops[1].is_memory() => {
                self.set_unknown_flags();
                return Ok(ExecuteReturnType::Select(c, ops[1].clone(), with, without));
            }
            Some(FlagValue::Abstract(_)) => unknown(),
            None => return Err(format!("{m} reads a carry flag the program never set")),
        };
        self.write(&ops[1], width, result)?;
        let written = self.read(&ops[1], width)?;
        self.flags_of_result(&written, width, Carry::Unknown);
        Ok(ExecuteReturnType::Next)
    }

    fn string_operation(&mut self, m: &str, instruction: &Instruction) -> Step {
        let element = instruction.suffix_width.unwrap_or(1);
        let repeated = !instruction.prefixes.is_empty()
            && instruction.prefixes.iter().any(|p| p.starts_with("rep"));
        let count = if repeated {
            self.registers[RCX].clone()
        } else {
            RegisterValue::new_imm(1)
        };
        let length = match count.kind {
            RegisterKind::Immediate => AbstractExpression::Immediate(count.offset * element),
            RegisterKind::RegisterBase => generate_expression(
                "*",
                count.expression(),
                AbstractExpression::Immediate(element),
            ),
            RegisterKind::Number => {
                return Err(format!("rep {m} with a count of unknown value"));
            }
        };
        let rdi = self.registers[RDI].clone();
        let rsi = self.registers[RSI].clone();
        let advanced = |r: &RegisterValue| match &length {
            AbstractExpression::Immediate(n) => {
                let mut r = r.clone();
                r.offset += n;
                r
            }
            other => add_values(
                r,
                &RegisterValue::new(RegisterKind::RegisterBase, Some(other.clone()), 0),
            ),
        };
        match m {
            "stos" => {
                self.store_range(&rdi, length.clone())?;
                self.registers[RDI] = advanced(&rdi);
            }
            "movs" => {
                self.load_range(&rsi, length.clone())?;
                self.store_range(&rdi, length.clone())?;
                self.registers[RSI] = advanced(&rsi);
                self.registers[RDI] = advanced(&rdi);
            }
            "lods" => {
                self.load_range(&rsi, length.clone())?;
                self.registers[RSI] = advanced(&rsi);
                self.write_gpr(RAX, element, false, unknown());
            }
            _ => {
                if m == "cmps" {
                    self.load_range(&rsi, length.clone())?;
                }
                self.load_range(&rdi, length.clone())?;
                if repeated {
                    self.registers[RSI] = unknown();
                    self.registers[RDI] = unknown();
                } else {
                    if m == "cmps" {
                        self.registers[RSI] = advanced(&rsi);
                    }
                    self.registers[RDI] = advanced(&rdi);
                }
                self.set_unknown_flags();
            }
        }
        if repeated {
            self.registers[RCX] = if matches!(m, "cmps" | "scas") {
                unknown()
            } else {
                RegisterValue::new_imm(0)
            };
        }
        Ok(ExecuteReturnType::Next)
    }

    fn x87(&mut self, instruction: &Instruction) -> Result<(), String> {
        let m = instruction.mnemonic.as_str();
        let Some(memory) = instruction.operands.iter().find(|o| o.is_memory()) else {
            return Ok(());
        };
        let integer = m.starts_with("fi");
        let width = match m {
            "fldcw" | "fnstcw" | "fstcw" | "fnstsw" | "fstsw" => 2,
            _ if m.starts_with("fxsave") || m.starts_with("fxrstor") => 512,
            _ if m.ends_with("ll") => 8,
            _ => match m.chars().last() {
                Some('s') if integer => 2,
                Some('s') => 4,
                Some('l') if integer => 4,
                Some('l') => 8,
                Some('q') => 8,
                _ => 10,
            },
        };
        let stores = ["fst", "fist", "fnst", "fbstp", "fxsave", "fsave", "fnsave"]
            .iter()
            .any(|stem| m.starts_with(stem));
        if stores {
            self.write(memory, width, unknown())
        } else {
            self.read(memory, width).map(|_| ())
        }
    }

    fn vector_or_unsupported(&mut self, instruction: &Instruction) -> Step {
        let ops = &instruction.operands;
        let names_vector = ops.iter().any(|o| {
            matches!(
                o.register(),
                Some(Register::Vector { .. }) | Some(Register::Mask(_))
            )
        });
        let m = instruction.mnemonic.as_str();
        if !names_vector && !m.starts_with('k') {
            return Err(format!("unsupported instruction {}", instruction.opcode));
        }
        let width = vector_access_width(instruction);
        let Some((last, sources)) = ops.split_last() else {
            return Ok(ExecuteReturnType::Next);
        };
        let reads_only = vector_reads_only(m);
        let masked = instruction
            .mask
            .and_then(|k| enabled_bytes(m, &self.masks[k], width));

        let mut moved = None;
        for source in sources.iter().chain(reads_only.then_some(last)) {
            if let (Operand::Memory(memory), Some(bytes)) = (source, &masked) {
                let address = self.effective_address(memory)?;
                self.load_range(&address, bytes.clone())?;
                moved = Some(unknown());
            } else if let Operand::Memory(_) = source {
                let value = self.read(source, width)?;
                moved = Some(value);
            } else if let Operand::Register(_) = source {
                moved = Some(self.read(source, 8)?);
            }
        }
        if reads_only {
            self.set_unknown_flags();
            return Ok(ExecuteReturnType::Next);
        }

        let copy = (vector_copies(m) || m.starts_with("kmov")) && sources.len() == 1;
        let value = match moved {
            Some(v) if copy => v,
            _ => unknown(),
        };
        match last {
            Operand::Memory(memory) if masked.is_some() => {
                let address = self.effective_address(memory)?;
                self.store_range(&address, masked.expect("checked by the guard"))?;
            }
            Operand::Register(Register::Mask(k)) => self.masks[*k] = value,
            Operand::Memory(_) => {
                let stored = if copy && width == 8 { value } else { unknown() };
                self.write(last, width, stored)?;
            }
            Operand::Register(Register::Gpr {
                index, width: w, ..
            }) => {
                let v = if copy { value } else { unknown() };
                self.write_gpr(*index, *w, false, v);
            }
            Operand::Register(Register::Vector { index, .. }) => self.vectors[*index] = value,
            _ => (),
        }
        Ok(ExecuteReturnType::Next)
    }
}

fn jump_on(condition: FlagValue, label: &str) -> ExecuteReturnType<Operand> {
    match condition {
        FlagValue::Real(true) => ExecuteReturnType::JumpLabel(label.to_string()),
        FlagValue::Real(false) => ExecuteReturnType::Next,
        FlagValue::Abstract(c) => ExecuteReturnType::ConditionalJumpLabel(c, label.to_string()),
    }
}
