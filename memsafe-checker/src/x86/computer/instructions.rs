use crate::x86::computer::flags::Carry;
use crate::x86::computer::memory::add_values;
use crate::x86::computer::*;

const PROOF_RESOURCE_LIMIT: u32 = 20_000_000;

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

fn is_low_bits_mask(value: &RegisterValue) -> bool {
    matches!(
        (&value.kind, &value.base, value.offset),
        (RegisterKind::RegisterBase, Some(AbstractExpression::Expression(op, one, _)), -1)
            if op == "lsl" && **one == AbstractExpression::Immediate(1)
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

const NARROWING_SOURCES: [(&str, i64); 14] = [
    ("cvtpd2ps", 2),
    ("cvtpd2dq", 2),
    ("cvttpd2dq", 2),
    ("cvtpd2udq", 2),
    ("cvttpd2udq", 2),
    ("cvtqq2ps", 2),
    ("cvtuqq2ps", 2),
    ("cvtneps2bf16", 2),
    ("cvtps2phx", 2),
    ("cvtdq2ph", 2),
    ("cvtudq2ph", 2),
    ("cvtpd2ph", 4),
    ("cvtqq2ph", 4),
    ("cvtuqq2ph", 4),
];

const MASK_RESULT_SOURCES: [&str; 3] = ["fpclassps", "fpclasspd", "fpclassph"];

fn narrowing_source_width(m: &str, vex: bool, widest: Option<i64>) -> Option<i64> {
    let stems = NARROWING_SOURCES
        .iter()
        .copied()
        .chain(MASK_RESULT_SOURCES.iter().map(|stem| (*stem, 1)));
    for (stem, ratio) in stems {
        let Some(size_suffix) = m.strip_prefix(stem) else {
            continue;
        };
        match size_suffix {
            "x" => return Some(16),
            "y" => return Some(32),
            "z" => return Some(64),
            "" if !vex => return Some(16),
            "" => return Some(widest.map_or(64, |w| (w * ratio).min(64))),
            _ => continue,
        }
    }
    None
}

fn element_bytes(letter: char) -> Option<i64> {
    match letter {
        'b' => Some(1),
        'w' => Some(2),
        'd' => Some(4),
        'q' => Some(8),
        _ => None,
    }
}

fn narrowing_store_ratio(m: &str) -> Option<i64> {
    let elements = m.strip_prefix("pmov")?;
    let elements = elements
        .strip_prefix("us")
        .or_else(|| elements.strip_prefix('s'))
        .unwrap_or(elements);
    let mut letters = elements.chars();
    let (from, to) = (letters.next()?, letters.next()?);
    if letters.next().is_some() {
        return None;
    }
    let (from, to) = (element_bytes(from)?, element_bytes(to)?);
    (from > to).then_some(from / to)
}

fn vector_access_width(i: &Instruction) -> i64 {
    let m = i.mnemonic.trim_start_matches('v');
    let widest_register = i
        .operands
        .iter()
        .filter_map(|o| o.register().filter(|r| r.is_vector()).map(|r| r.width()))
        .max();
    if let (Some(copies), Some(widest)) = (i.broadcast, widest_register) {
        return widest / copies;
    }
    if let Some(width) = narrowing_source_width(m, i.mnemonic.starts_with('v'), widest_register) {
        return width;
    }
    let widest = widest_register.unwrap_or(64);
    if let Some(ratio) = narrowing_store_ratio(m) {
        return widest / ratio;
    }
    match m {
        "kmovb" => 1,
        "kmovw" => 2,
        "kmovd" => 4,
        "kmovq" => 8,
        "movd" | "movss" | "pinsrd" | "pextrd" | "broadcastss" | "pbroadcastd" | "insertps"
        | "extractps" | "cvtsi2ssl" | "cvtsi2sdl" => 4,
        "movddup" if widest > 16 => widest,
        "movq" | "movsd" | "pinsrq" | "pextrq" | "movhps" | "movlps" | "movhpd" | "movlpd"
        | "broadcastsd" | "pbroadcastq" | "movddup" | "cvtsi2ssq" | "cvtsi2sdq" => 8,
        "pinsrb" | "pextrb" | "pbroadcastb" => 1,
        "pinsrw" | "pextrw" | "pbroadcastw" => 2,
        "broadcasti128" | "broadcastf128" | "inserti128" | "insertf128" | "extracti128"
        | "extractf128" | "broadcasti32x4" | "broadcastf32x4" | "broadcasti64x2"
        | "broadcastf64x2" | "inserti32x4" | "inserti64x2" | "extracti32x4" | "extracti64x2"
        | "insertf32x4" | "insertf64x2" | "extractf32x4" | "extractf64x2" => 16,
        "broadcasti32x8" | "broadcastf32x8" | "broadcasti64x4" | "broadcastf64x4"
        | "inserti32x8" | "insertf32x8" | "inserti64x4" | "insertf64x4" | "extracti32x8"
        | "extractf32x8" | "extracti64x4" | "extractf64x4" => 32,
        "pmovzxbw" | "pmovsxbw" | "pmovzxwd" | "pmovsxwd" | "pmovzxdq" | "pmovsxdq" => widest / 2,
        "pmovzxbd" | "pmovsxbd" | "pmovzxwq" | "pmovsxwq" => widest / 4,
        "pmovzxbq" | "pmovsxbq" => widest / 8,
        "cvtph2ps" | "cvtps2ph" | "cvtps2pd" | "cvtdq2pd" | "cvtudq2pd" => widest / 2,
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
            | "kortestb"
            | "kortestw"
            | "kortestd"
            | "kortestq"
            | "ktestb"
            | "ktestw"
            | "ktestd"
            | "ktestq"
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
    fn shifted_right_unknown(
        &mut self,
        op: &str,
        value: RegisterValue,
        count: i64,
        width: i64,
    ) -> RegisterValue {
        let count = count & if width == 8 { 63 } else { 31 };
        match op {
            "shr" if count > 0 => self.unknown_of_bits(value, width * 8 - count),
            _ => value,
        }
    }

    fn high_product_by_constant(
        &self,
        a: &RegisterValue,
        b: &RegisterValue,
        width: i64,
    ) -> RegisterValue {
        let (factor, constant) = match (&a.kind, &b.kind) {
            (RegisterKind::RegisterBase, RegisterKind::Immediate) => (a, b.offset),
            (RegisterKind::Immediate, RegisterKind::RegisterBase) => (b, a.offset),
            _ => return unknown(),
        };
        if width != 8 || !self.proves_within(&factor.expression(), 0, i64::MAX) {
            log::info!(
                "multiply-high factor {} not proved non-negative",
                factor.expression()
            );
            return unknown();
        }
        let half = AbstractExpression::Immediate(1 << 32);
        let product = generate_expression(
            "*",
            factor.expression(),
            AbstractExpression::Immediate(constant),
        );
        let shifted =
            generate_expression("/", generate_expression("/", product, half.clone()), half);
        let high = if constant < 0 {
            generate_expression("+", factor.expression(), shifted)
        } else {
            shifted
        };
        RegisterValue::new(RegisterKind::RegisterBase, Some(high), 0)
    }

    fn low_bits_mask(&self, count: &RegisterValue, width: i64, adjust: i64) -> RegisterValue {
        let bits = width * 8;
        let most = if adjust == 0 { bits - 1 } else { bits };
        match count.kind {
            RegisterKind::Immediate if (0..=most).contains(&count.offset) => {
                let set = if count.offset >= 64 {
                    0
                } else {
                    1i64 << count.offset
                };
                RegisterValue::new_imm(set.wrapping_add(adjust))
            }
            RegisterKind::RegisterBase if self.proves_within(&count.expression(), 0, most) => {
                RegisterValue::new(
                    RegisterKind::RegisterBase,
                    Some(generate_expression(
                        "lsl",
                        AbstractExpression::Immediate(1),
                        count.expression(),
                    )),
                    adjust,
                )
            }
            _ => unknown(),
        }
    }

    fn hint_magic_division(&mut self, a: &RegisterValue, b: &RegisterValue, high: &RegisterValue) {
        let (factor, constant) = match (&a.kind, &b.kind) {
            (RegisterKind::RegisterBase, RegisterKind::Immediate) => (a, b.offset as u64),
            (RegisterKind::Immediate, RegisterKind::RegisterBase) => (b, a.offset as u64),
            _ => return,
        };
        if high.kind != RegisterKind::RegisterBase {
            return;
        }
        let Some((divisor, shift, excess)) = magic_divisor(constant) else {
            return;
        };
        let (Some(x), Some(h)) = (
            expression_to_ast(factor.expression()),
            expression_to_ast(high.expression()),
        ) else {
            return;
        };
        let scaled = ast::Int::mul(&[&x, &ast::Int::from_i64(1 << shift)]);
        let times_divisor = ast::Int::mul(&[&h, &ast::Int::from_i64(divisor)]);
        let low = ast::Int::sub(&[&scaled, &ast::Int::from_i64(divisor - 1)]);
        let top = ast::Int::add(&[&scaled, &ast::Int::from_i64(excess / 2)]);
        self.bound_fresh(times_divisor.ge(&low));
        self.bound_fresh(times_divisor.le(&top));
    }

    fn proves_within(&self, expression: &AbstractExpression, low: i64, high: i64) -> bool {
        let Some(value) = expression_to_ast(expression.clone()) else {
            return false;
        };
        let outside = ast::Bool::or(&[
            value.lt(ast::Int::from_i64(low)),
            value.gt(ast::Int::from_i64(high)),
        ]);
        let mut assumptions = self.select_assumptions(expression);
        assumptions.push(outside);
        let mut bounded = Params::new();
        bounded.set_u32("rlimit", PROOF_RESOURCE_LIMIT);
        self.solver.set_params(&bounded);
        let result = self.solver.check_assumptions(&assumptions);
        let mut unbounded = Params::new();
        unbounded.set_u32("rlimit", 0);
        self.solver.set_params(&unbounded);
        result == SatResult::Unsat
    }

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
                    let narrowed = narrow(&value, from, false);
                    self.unknown_of_bits(narrowed, from * 8)
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
                    let narrowed = narrow(&value, from, false);
                    self.unknown_of_bits(narrowed, from * 8)
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
                let all_ones = if width >= 8 {
                    -1
                } else {
                    (1i64 << (width * 8)) - 1
                };
                let absorbing = [&src, &dst].into_iter().find_map(|v| {
                    let bits = if width >= 8 {
                        v.offset
                    } else {
                        v.offset & all_ones
                    };
                    match (m, v.kind == RegisterKind::Immediate, bits) {
                        ("or", true, b) if b == all_ones => Some(RegisterValue::new_imm(all_ones)),
                        ("and", true, 0) => Some(RegisterValue::new_imm(0)),
                        _ => None,
                    }
                });
                let result = match (m, same_register) {
                    _ if absorbing.is_some() => absorbing.expect("checked by the guard"),
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
                        let mask = [&src, &dst]
                            .into_iter()
                            .find(|v| v.kind == RegisterKind::Immediate)
                            .map(|v| {
                                if width >= 8 {
                                    v.offset
                                } else {
                                    v.offset & ((1i64 << (width * 8)) - 1)
                                }
                            });
                        let register_mask = [&src, &dst]
                            .into_iter()
                            .find(|v| {
                                v.kind == RegisterKind::RegisterBase
                                    && self.proves_within(&v.expression(), 0, i64::MAX)
                            })
                            .map(|v| v.expression());
                        let r = match (mask, register_mask) {
                            (Some(mask), _) if m == "and" => self.unknown_within(r, mask),
                            (None, Some(mask)) if m == "and" => self.unknown_at_most(r, mask),
                            _ => r,
                        };
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
                self.flags_of_result(&written, width, Carry::Cleared);
                if matches!(m, "add" | "sub") {
                    self.set_arithmetic_carry(m == "add", (&dst, &src, &written), width);
                }
                if m == "add" || (m == "sub" && !same_register) {
                    let op = if m == "add" { "+" } else { "-" };
                    self.set_signed_order(op, (&dst, &src, 0), width, !ops[1].is_memory());
                }
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
                    self.forget_signed_order();
                }
            }
            "inc" | "dec" => {
                let dst = self.read(&ops[0], width)?;
                let step = RegisterValue::new_imm(1);
                let op = if m == "inc" { "+" } else { "-" };
                let result = combine(op, &dst, &step);
                self.write(&ops[0], width, result)?;
                let written = self.read(&ops[0], width)?;
                self.flags_of_result(&written, width, Carry::Kept);
                self.set_signed_order(op, (&dst, &step, 0), width, !ops[0].is_memory());
            }
            "neg" => {
                let dst = self.read(&ops[0], width)?;
                let zero = RegisterValue::new_imm(0);
                let result = combine("-", &zero, &dst);
                self.write(&ops[0], width, result)?;
                let written = self.read(&ops[0], width)?;
                self.flags_of_result(&written, width, Carry::Unknown);
                self.set_signed_order("-", (&zero, &dst, 0), width, !ops[0].is_memory());
                if dst.kind == RegisterKind::Immediate {
                    self.set_carry(Some(dst.offset != 0));
                }
            }
            "not" => {
                let dst = self.read(&ops[0], width)?;
                let result = match dst.kind {
                    RegisterKind::Immediate => RegisterValue::new_imm(!dst.offset),
                    _ => combine("-", &RegisterValue::new_imm(-1), &dst),
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
                let bit = self.read(&ops[0], width)?;
                let dst = self.read(&ops[1], width)?;
                if m == "bts" && dst.kind == RegisterKind::Immediate && dst.offset == 0 {
                    let set = self.low_bits_mask(&bit, width, 0);
                    self.write(&ops[1], width, set)?;
                } else if m != "bt" {
                    self.write(&ops[1], width, unknown())?;
                }
                self.set_carry(None);
                self.forget_signed_order();
            }
            "bzhi" => {
                let count = self.read(&ops[0], width)?;
                let src = self.read(&ops[1], width)?;
                let all_ones = src.kind == RegisterKind::Immediate
                    && (src.offset == -1 || (width == 4 && src.offset == 0xffff_ffff));
                let result = if all_ones {
                    self.low_bits_mask(&count, width, -1)
                } else {
                    unknown()
                };
                self.write(&ops[2], width, result)?;
                self.set_unknown_flags();
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
                    Some(c) if !m.starts_with("rc") => {
                        let shifted = shift(m, &dst, c, width);
                        self.shifted_right_unknown(m, shifted, c, width)
                    }
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
                    if m != "sar" {
                        self.forget_signed_order();
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
                    _ if m == "tzcnt" => self.unknown_within(unknown(), width * 8),
                    _ if ops[0] == *dst => self.unknown_within(unknown(), width * 8 - 1),
                    _ => unknown(),
                };
                self.write(dst, width, value)?;
                self.set_unknown_flags();
            }
            "sarx" | "shlx" | "shrx" | "rorx" => {
                let count = self.read(&ops[0], 1)?;
                let src = self.read(&ops[1], width)?;
                let op = match m {
                    "sarx" => "sar",
                    "shlx" => "shl",
                    "shrx" => "shr",
                    _ => "ror",
                };
                let result = match count.kind {
                    RegisterKind::Immediate => {
                        let shifted = shift(op, &src, count.offset, width);
                        self.shifted_right_unknown(op, shifted, count.offset, width)
                    }
                    _ if op == "shl" => shift_by_register(&src, &count, width),
                    _ => unknown(),
                };
                self.write(&ops[2], width, result)?;
            }
            "andn" | "popcnt" | "lzcnt" | "bsr" => {
                for source in &ops[..ops.len() - 1] {
                    self.read(source, width)?;
                }
                self.write(ops.last().expect("destination"), width, unknown())?;
                self.set_unknown_flags();
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
                let high = self.high_product_by_constant(&rax, &src, width);
                self.hint_magic_division(&rax, &src, &high);
                self.write_gpr(RAX, width, false, low);
                self.write_gpr(RDX, width, false, high);
                self.set_unknown_flags();
            }
            "crc32" => {
                self.read(&ops[0], width)?;
                let checksum = self.unknown_of_bits(unknown(), 32);
                let destination = ops[1].register().map_or(4, |r| r.width());
                self.write(&ops[1], destination, checksum)?;
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

            "maskmovdqu" | "vmaskmovdqu" | "maskmovq" => {
                let rdi = self.registers[RDI].clone();
                let bytes = if m == "maskmovq" { 8 } else { 16 };
                self.store_range(&rdi, AbstractExpression::Immediate(bytes))?;
            }
            "bums.vector_op" => {
                if ops[0].is_memory() {
                    self.read(&ops[0], 16)?;
                }
                if let Some(Operand::Register(Register::Vector { index, .. })) = ops.last() {
                    self.set_vector(*index, unknown());
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
                self.set_vector(*index, value);
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
        let carry_in = match carry {
            Some(FlagValue::Real(c)) => Some(c),
            _ => None,
        };
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
        match carry_in {
            Some(c) => {
                self.set_signed_order(op, (&dst, &src, c as i64), width, !ops[1].is_memory())
            }
            None => self.forget_signed_order(),
        }
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

    fn constant_table_entry(
        &self,
        memory: &MemoryOperand,
        width: i64,
    ) -> Result<Option<Result<RegisterValue, Vec<AbstractComparison>>>, String> {
        const MOST_ENTRIES: usize = 64;
        let address = self.effective_address(memory)?;
        let name = self.mem_safe_access(
            &address,
            RegionType::READ,
            AbstractExpression::Immediate(width),
        )?;
        let region = &self.memory[&name];
        let Some(base) = address.base.clone() else {
            return Ok(None);
        };
        if region.kind != RegionType::READ || region.content.is_empty() {
            return Ok(None);
        }
        let Some((_, symbol, label_offset)) = self.region_of(&base) else {
            return Ok(None);
        };
        let within = generate_expression(
            "+",
            generate_expression("-", base, AbstractExpression::Abstract(symbol)),
            AbstractExpression::Immediate(address.offset + label_offset),
        );
        let Some(offset) = expression_to_ast(within.clone()) else {
            return Ok(None);
        };
        let mut offsets: Vec<i64> = Vec::new();
        loop {
            let excluded: Vec<ast::Bool> = offsets
                .iter()
                .map(|v| offset.eq(ast::Int::from_i64(*v)).not())
                .collect();
            match self.solver.check_assumptions(&excluded) {
                SatResult::Unsat => break,
                SatResult::Unknown => return Ok(None),
                SatResult::Sat => {
                    let Some(value) = self
                        .solver
                        .get_model()
                        .and_then(|model| model.eval(&offset, true))
                        .and_then(|value| value.as_i64())
                    else {
                        return Ok(None);
                    };
                    if offsets.contains(&value) || offsets.len() >= MOST_ENTRIES {
                        return Ok(None);
                    }
                    offsets.push(value);
                }
            }
        }
        match offsets.as_slice() {
            [only] => Ok(region.read(*only, width).map(Ok)),
            [] => Ok(None),
            _ => Ok(Some(Err(offsets
                .iter()
                .map(|v| {
                    AbstractComparison::new("==", within.clone(), AbstractExpression::Immediate(*v))
                })
                .collect()))),
        }
    }

    fn replicated_low_dword(
        &mut self,
        mnemonic: &str,
        ops: &[Operand],
    ) -> Result<Option<(RegisterValue, Option<DwordInterval>)>, String> {
        let zeroes_upper = mnemonic.starts_with('v');
        let (source, every_lane) = match (mnemonic.trim_start_matches('v'), ops) {
            (
                "pshufd",
                [
                    Operand::Immediate(order),
                    source @ Operand::Register(Register::Vector { .. }),
                    Operand::Register(Register::Vector { width, .. }),
                ],
            ) if order & 0xff == 0 => (self.read(source, 8)?, zeroes_upper && *width == 16),
            (
                "pbroadcastd",
                [
                    source @ Operand::Register(Register::Vector { .. }),
                    Operand::Register(Register::Vector { .. }),
                ],
            ) => (self.read(source, 8)?, zeroes_upper),
            (
                "pbroadcastd",
                [
                    source @ Operand::Memory(_),
                    Operand::Register(Register::Vector { .. }),
                ],
            ) => (self.read(source, 4)?, zeroes_upper),
            _ => return Ok(None),
        };
        let low = narrow(&source, 4, false);
        let interval = match low.kind {
            RegisterKind::Number => None,
            _ if !every_lane => None,
            _ if self.proves_within(&low.expression(), 0, i32::MAX as i64) => {
                Some((low.expression(), low.expression()))
            }
            _ => None,
        };
        let lanes = match low.kind {
            RegisterKind::Immediate if low.offset < 1 << 31 => {
                RegisterValue::new_imm(low.offset | (low.offset << 32))
            }
            RegisterKind::RegisterBase => RegisterValue::new(
                RegisterKind::RegisterBase,
                Some(generate_expression(
                    "*",
                    low.expression(),
                    AbstractExpression::Immediate((1 << 32) + 1),
                )),
                0,
            ),
            _ => unknown(),
        };
        Ok(Some((lanes, interval)))
    }

    fn low_lanes_within(&mut self, (low, high): &DwordInterval) -> RegisterValue {
        if !self.proves_within(low, 0, i32::MAX as i64) {
            return unknown();
        }
        let first = self.unknown_between(low.clone(), high.clone());
        let second = self.unknown_between(low.clone(), high.clone());
        RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression(
                "+",
                first.expression(),
                generate_expression(
                    "*",
                    second.expression(),
                    AbstractExpression::Immediate(1 << 32),
                ),
            )),
            0,
        )
    }

    fn clamped_to_dword_lanes(&self, source: usize, value: RegisterValue) -> RegisterValue {
        let Some((low, high)) = self.dword_lanes(source).cloned() else {
            return value;
        };
        let dword = narrow(&value, 4, false);
        if dword.kind != RegisterKind::RegisterBase || !self.proves_within(&low, 0, i32::MAX as i64)
        {
            return value;
        }
        RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression(
                "atmost",
                generate_expression("atleast", dword.expression(), low),
                high,
            )),
            0,
        )
    }

    fn vector_sources(ops: &[Operand]) -> Option<Vec<usize>> {
        let (_, sources) = ops.split_last()?;
        sources
            .iter()
            .map(|source| match source {
                Operand::Register(Register::Vector { index, .. }) => Some(*index),
                _ => None,
            })
            .collect()
    }

    fn and_with_bounded_dwords(
        &mut self,
        mnemonic: &str,
        ops: &[Operand],
    ) -> Option<(RegisterValue, Option<DwordInterval>)> {
        if !matches!(mnemonic.trim_start_matches('v'), "pand" | "pandd" | "pandq") {
            return None;
        }
        let indexes = Self::vector_sources(ops)?;
        if mnemonic.starts_with('v') {
            let nonnegative = indexes.iter().find_map(|i| {
                let (low, high) = self.dword_lanes(*i)?.clone();
                self.proves_within(&low, 0, i32::MAX as i64)
                    .then_some((AbstractExpression::Immediate(0), high))
            });
            if let Some(interval) = nonnegative {
                let lanes = self.low_lanes_within(&interval);
                return Some((lanes, Some(interval)));
            }
        }
        let mask = indexes
            .iter()
            .find_map(|i| replicated_dword(&self.vectors[*i]))?;
        let lanes = self.low_lanes_within(&(AbstractExpression::Immediate(0), mask));
        Some((lanes, None))
    }

    fn add_or_subtract_bounded_dwords(
        &mut self,
        mnemonic: &str,
        ops: &[Operand],
    ) -> Option<(RegisterValue, Option<DwordInterval>)> {
        let subtract = match mnemonic {
            "vpaddd" => false,
            "vpsubd" => true,
            _ => return None,
        };
        let [subtrahend, minuend] = Self::vector_sources(ops)?[..] else {
            return None;
        };
        let (a_low, a_high) = self.dword_lanes(minuend)?.clone();
        let (b_low, b_high) = self.dword_lanes(subtrahend)?.clone();
        let (low, high) = if subtract {
            (
                generate_expression("-", a_low, b_high),
                generate_expression("-", a_high, b_low),
            )
        } else {
            (
                generate_expression("+", a_low, b_low),
                generate_expression("+", a_high, b_high),
            )
        };
        let fits = |engine: &Self, e: &AbstractExpression| {
            engine.proves_within(e, i32::MIN as i64, i32::MAX as i64)
        };
        if !fits(self, &low) || !fits(self, &high) {
            return None;
        }
        let interval = (low, high);
        Some((self.low_lanes_within(&interval), Some(interval)))
    }

    fn constant_dword_lanes(&self, memory: &MemoryOperand, width: i64) -> Option<DwordInterval> {
        if !(16..=64).contains(&width) {
            return None;
        }
        let address = self.effective_address(memory).ok()?;
        let Some(AbstractExpression::Abstract(name)) = &address.base else {
            return None;
        };
        let region = self.memory.get(name)?;
        let dwords: Vec<i64> = (0..width / 4)
            .map(|k| {
                let value = region.read(address.offset + 4 * k, 4)?;
                (value.kind == RegisterKind::Immediate).then_some(value.offset as u32 as i32 as i64)
            })
            .collect::<Option<_>>()?;
        Some((
            AbstractExpression::Immediate(*dwords.iter().min()?),
            AbstractExpression::Immediate(*dwords.iter().max()?),
        ))
    }

    fn dword_indexed_gather(&mut self, instruction: &Instruction) -> Step {
        let mnemonic = instruction.mnemonic.trim_start_matches('v');
        let element = match mnemonic {
            "pgatherdd" | "gatherdps" | "pscatterdd" | "scatterdps" => 4,
            "pgatherdq" | "gatherdpd" | "pscatterdq" | "scatterdpd" => 8,
            _ => return Err(format!("unsupported gather {}", instruction.opcode)),
        };
        let scatter = mnemonic.contains("scatter");
        let (memory, destination, completion) = match instruction.operands.as_slice() {
            [
                Operand::Register(Register::Vector { index: mask, .. }),
                Operand::Memory(memory),
                Operand::Register(Register::Vector { index, .. }),
            ] if !scatter && instruction.mask.is_none() => (memory, Some(*index), Some(*mask)),
            [
                Operand::Memory(memory),
                Operand::Register(Register::Vector { index, .. }),
            ] if !scatter && instruction.mask.is_some() => (memory, Some(*index), None),
            [
                Operand::Register(Register::Vector { .. }),
                Operand::Memory(memory),
            ] if scatter && instruction.mask.is_some() => (memory, None, None),
            _ => return Err(format!("unsupported gather {}", instruction.opcode)),
        };
        let Some(Register::Vector { index: lanes, .. }) = memory.index else {
            return Err(format!("unsupported gather {}", instruction.opcode));
        };
        let Some((low, high)) = self.dword_lanes(lanes).cloned() else {
            return Err(format!(
                "{} indexed by {:?} whose lanes have no known bound",
                instruction.mnemonic,
                memory.index.expect("matched above")
            ));
        };
        let fits = |engine: &Self, e: &AbstractExpression| {
            engine.proves_within(e, i32::MIN as i64, i32::MAX as i64)
        };
        if !fits(self, &low) || !fits(self, &high) {
            return Err(format!(
                "{} lanes [{low}, {high}] not proved to be 32-bit indexes",
                instruction.mnemonic
            ));
        }
        let base = self.effective_address(&MemoryOperand {
            index: None,
            ..memory.clone()
        })?;
        let scale = AbstractExpression::Immediate(memory.scale);
        let first = add_values(
            &base,
            &RegisterValue::new(
                RegisterKind::RegisterBase,
                Some(generate_expression("*", low.clone(), scale.clone())),
                0,
            ),
        );
        let span = generate_expression(
            "+",
            generate_expression("*", generate_expression("-", high, low), scale),
            AbstractExpression::Immediate(element),
        );
        if scatter {
            self.store_range(&first, span)?;
        } else {
            self.load_range(&first, span)?;
        }
        if let Some(destination) = destination {
            self.set_vector(destination, unknown());
        }
        if let Some(mask) = completion {
            self.set_vector(mask, RegisterValue::new_imm(0));
        }
        if let Some(k) = instruction.mask {
            self.masks[k] = RegisterValue::new_imm(0);
        }
        Ok(ExecuteReturnType::Next)
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
        if m.starts_with("kmov")
            && let [
                Operand::Memory(memory),
                Operand::Register(Register::Mask(k)),
            ] = ops.as_slice()
        {
            match self.constant_table_entry(memory, width)? {
                Some(Ok(value)) => {
                    self.masks[*k] = value;
                    return Ok(ExecuteReturnType::Next);
                }
                Some(Err(cases)) => return Ok(ExecuteReturnType::Split(cases)),
                None => (),
            }
        }
        if m.contains("gather") || m.contains("scatter") {
            return self.dword_indexed_gather(instruction);
        }
        if instruction.mask.is_none()
            && let Some(Operand::Register(Register::Vector { index, .. })) = ops.last()
            && let Some((lanes, interval)) = match self.replicated_low_dword(m, ops)? {
                Some(replicated) => Some(replicated),
                None => self
                    .and_with_bounded_dwords(m, ops)
                    .or_else(|| self.add_or_subtract_bounded_dwords(m, ops)),
            }
        {
            self.set_vector(*index, lanes);
            if let Some(interval) = interval {
                self.bound_dword_lanes(*index, interval);
            }
            return Ok(ExecuteReturnType::Next);
        }
        if let (
            "pextrd",
            [
                Operand::Immediate(lane @ 0..=3),
                Operand::Register(Register::Vector { index: source, .. }),
                Operand::Register(Register::Gpr {
                    index, high: false, ..
                }),
            ],
        ) = (m.trim_start_matches('v'), ops.as_slice())
        {
            let low = self.vectors[*source].clone();
            let dword = match (low.kind.clone(), *lane, self.dword_lanes(*source).cloned()) {
                (RegisterKind::RegisterBase, 1, _) => RegisterValue::new(
                    RegisterKind::RegisterBase,
                    Some(generate_expression(
                        "/",
                        low.expression(),
                        AbstractExpression::Immediate(1 << 32),
                    )),
                    0,
                ),
                (RegisterKind::Immediate, 1, _) => RegisterValue::new_imm(low.offset >> 32),
                (RegisterKind::Immediate | RegisterKind::RegisterBase, 0, _) => low,
                (_, _, Some((low, high))) => self.unknown_between(low, high),
                _ => unknown(),
            };
            let dword = self.clamped_to_dword_lanes(*source, dword);
            self.write_gpr(*index, 4, false, dword);
            return Ok(ExecuteReturnType::Next);
        }
        if instruction.mask.is_none()
            && matches!(
                m,
                "vextracti128"
                    | "vextracti32x4"
                    | "vextracti64x2"
                    | "vextracti32x8"
                    | "vextracti64x4"
            )
            && let [
                Operand::Immediate(_),
                Operand::Register(Register::Vector { index: source, .. }),
                Operand::Register(Register::Vector { index, .. }),
            ] = ops.as_slice()
            && let Some(interval) = self.dword_lanes(*source).cloned()
        {
            let lanes = self.low_lanes_within(&interval);
            self.set_vector(*index, lanes);
            self.bound_dword_lanes(*index, interval);
            return Ok(ExecuteReturnType::Next);
        }
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
            match m.trim_start_matches('v') {
                "pcmpestri" | "pcmpistri" => self.registers[RCX] = unknown(),
                "pcmpestrm" | "pcmpistrm" => self.set_vector(0, unknown()),
                _ => (),
            }
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
            Operand::Register(Register::Mask(k)) => {
                self.masks[*k] = match sources {
                    [
                        Operand::Register(Register::Gpr {
                            index, high: false, ..
                        }),
                    ] if copy && is_low_bits_mask(&self.registers[*index]) => {
                        self.registers[*index].clone()
                    }
                    _ => value,
                }
            }
            Operand::Memory(_) => {
                let stored = if copy && width == 8 { value } else { unknown() };
                self.write(last, width, stored)?;
            }
            Operand::Register(Register::Gpr {
                index, width: w, ..
            }) => {
                let v = match sources {
                    [Operand::Register(Register::Vector { index: source, .. })]
                        if copy && *w == 4 =>
                    {
                        self.clamped_to_dword_lanes(*source, value)
                    }
                    _ if copy => value,
                    _ => unknown(),
                };
                self.write_gpr(*index, *w, false, v);
            }
            Operand::Register(Register::Vector { index, .. }) => {
                self.set_vector(*index, value);
                if let [Operand::Memory(memory)] = sources
                    && copy
                    && masked.is_none()
                    && m.starts_with('v')
                    && let Some(interval) = self.constant_dword_lanes(memory, width)
                {
                    self.bound_dword_lanes(*index, interval);
                }
            }
            _ => (),
        }
        Ok(ExecuteReturnType::Next)
    }
}

fn replicated_dword(low: &RegisterValue) -> Option<AbstractExpression> {
    match (&low.kind, &low.base) {
        (RegisterKind::Immediate, _) if low.offset >> 32 == low.offset & 0xffff_ffff => {
            Some(AbstractExpression::Immediate(low.offset & 0xffff_ffff))
        }
        (RegisterKind::RegisterBase, Some(AbstractExpression::Expression(op, dword, factor)))
            if op == "*"
                && low.offset == 0
                && **factor == AbstractExpression::Immediate((1 << 32) + 1)
                && matches!(&**dword, AbstractExpression::Expression(m, _, modulus)
                    if m == "%" && **modulus == AbstractExpression::Immediate(1 << 32)) =>
        {
            Some((**dword).clone())
        }
        _ => None,
    }
}

fn jump_on(condition: FlagValue, label: &str) -> ExecuteReturnType<Operand> {
    match condition {
        FlagValue::Real(true) => ExecuteReturnType::JumpLabel(label.to_string()),
        FlagValue::Real(false) => ExecuteReturnType::Next,
        FlagValue::Abstract(c) => ExecuteReturnType::ConditionalJumpLabel(c, label.to_string()),
    }
}

fn magic_divisor(constant: u64) -> Option<(i64, i64, i64)> {
    (0..=8i64).find_map(|shift| {
        (2..=1024i64).find_map(|divisor| {
            let product = constant as u128 * divisor as u128;
            let power = 1u128 << (64 + shift);
            let excess = product.checked_sub(power)?;
            (excess < divisor as u128).then_some((divisor, shift, excess as i64))
        })
    })
}
