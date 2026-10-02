#[derive(Debug, Clone, PartialEq)]
pub struct Instruction {
    pub ty: InstructionType,
    pub opcode: String,
    pub operands: Vec<Operand>,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Arrangement {
    B8,
    B16,
    H4,
    H8,
    S2,
    S4,
    D2,
    D,
    S,
    H,
    B,
    Q,
}

#[derive(Debug, Clone, PartialEq)]
pub enum RePrefix {
    X,
    W,
    V,
    Fp,
    Sp,
    Ra,
    Ze,
}

impl Arrangement {
    pub fn width(&self) -> i64 {
        match self {
            Arrangement::B16
            | Arrangement::H8
            | Arrangement::S4
            | Arrangement::D2
            | Arrangement::Q => 16,
            Arrangement::B8 | Arrangement::H4 | Arrangement::S2 | Arrangement::D => 8,
            Arrangement::S => 4,
            Arrangement::H => 2,
            Arrangement::B => 1,
        }
    }

    pub fn element_width(&self) -> i64 {
        match self {
            Arrangement::B8 | Arrangement::B16 | Arrangement::B => 1,
            Arrangement::H4 | Arrangement::H8 | Arrangement::H => 2,
            Arrangement::S2 | Arrangement::S4 | Arrangement::S => 4,
            Arrangement::D | Arrangement::D2 => 8,
            Arrangement::Q => 16,
        }
    }

    pub fn from_string(s: &str) -> Arrangement {
        match s.to_ascii_lowercase().as_str() {
            "8b" => Arrangement::B8,
            "16b" => Arrangement::B16,
            "4h" => Arrangement::H4,
            "8h" => Arrangement::H8,
            "2s" => Arrangement::S2,
            "4s" => Arrangement::S4,
            "2d" => Arrangement::D2,
            "d" | "1d" => Arrangement::D,
            "s" => Arrangement::S,
            "h" => Arrangement::H,
            "b" => Arrangement::B,
            "q" | "1q" => Arrangement::Q,
            _ => panic!("Invalid arrangement string {:?}", s),
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum Operand {
    Register(RePrefix, usize),
    Immediate(i64),
    Memory(
        RePrefix,
        usize,
        Option<i64>,
        Option<Box<Operand>>,
        Option<bool>,
    ),
    Bitwise(String, i64),
    VectorRegister(RePrefix, usize),
    Vector(RePrefix, usize, Arrangement),
    VectorAccess(RePrefix, usize, Arrangement, i64),
    Label(String),
    Address(String, i64),
    Other,
}
pub fn register_to_tuple(r: &Operand) -> (RePrefix, usize) {
    match r.clone() {
        Operand::Register(prefix, index) => (prefix, index),
        Operand::VectorRegister(prefix, index) => (prefix, index),
        Operand::Memory(prefix, index, _, _, _) => (prefix, index),
        _ => panic!("Expected a register or vector register operand"),
    }
}

pub fn operand_from_string(a: String) -> Operand {
    if a.starts_with("x")
        || a.starts_with("z")
        || a.starts_with("w")
        || a.starts_with("fp")
        || a.starts_with("sp")
    {
        match a.as_str() {
            "sp" => return Operand::Register(RePrefix::Sp, 0),
            "fp" => return Operand::Register(RePrefix::Fp, 0),
            "ra" => return Operand::Register(RePrefix::Ra, 0),
            "xzr" | "wzr" | "ze" => return Operand::Register(RePrefix::Ze, 0),
            _ => {
                let parts = a.split_at(1);
                let prefix = parts.0;
                if let Ok(num) = parts.1.parse::<usize>() {
                    return Operand::Register(
                        match prefix {
                            "x" => RePrefix::X,
                            "w" => RePrefix::W,
                            _ => panic!("Unknown register prefix: {}", prefix),
                        },
                        num,
                    );
                }
            }
        }
    }

    if a.starts_with("#") {
        if let Ok(n) = a.trim_start_matches("#").parse::<i64>() {
            return Operand::Immediate(n);
        } else {
            return Operand::Immediate(string_to_int(&a));
        }
    }

    if let Some(hex) = a.strip_prefix("0x")
        && let Ok(n) = u64::from_str_radix(hex, 16)
    {
        return Operand::Immediate(n as i64);
    }

    if let Ok(n) = a.parse::<i64>() {
        return Operand::Immediate(n);
    }

    if a.contains('@') {
        return Operand::Address(a, 0);
    }

    if a.contains("#") & !a.contains("[") {
        let mut parts = a.split('#').peekable();
        if !parts
            .peek()
            .expect("need some strings in shift parsing")
            .is_empty()
        {
            return Operand::Bitwise(
                parts
                    .next()
                    .expect("need part before # in shift parsing")
                    .to_string(),
                parts
                    .next()
                    .and_then(|s| constant_expression(s.trim()))
                    .expect("need part after # in shift parsing"),
            );
        }
    }

    if a == "uxtw" || a == "uxtb" || a == "uxth" {
        return Operand::Bitwise(a, 0);
    }

    if a.starts_with("v") {
        if a.contains(".") {
            let mut parts = a.split('.');
            let base = parts
                .next()
                .expect("require base register for simd register");
            let arrangement = parts.next().expect("require a valid simd arrangement");
            if arrangement.contains("[") {
                let mut parts = arrangement.split(&['[', ']']);
                let a = Arrangement::from_string(
                    parts
                        .next()
                        .expect("size indication required for index into vector"),
                );
                let index = string_to_int(parts.next().expect("index required"));

                let parts = base.split_at(1);
                let i = parts
                    .1
                    .parse::<usize>()
                    .expect("vector access number must be a number");
                return Operand::VectorAccess(RePrefix::V, i, a, index);
            } else {
                let a = Arrangement::from_string(arrangement);
                let parts = base.split_at(1);
                let i = parts
                    .1
                    .parse::<usize>()
                    .expect("vector number must be a number");
                return Operand::Vector(RePrefix::V, i, a);
            }
        } else if a.contains("[") && a.contains("]") {
            let mut parts = a.split('[');
            let base = parts
                .next()
                .expect("require base register for simd register");
            let index = string_to_int(parts.next().expect("index required").trim_matches(']'));

            let parts = base.split_at(1);
            let i = parts
                .1
                .parse::<usize>()
                .expect("vector access number must be a number");
            return Operand::VectorAccess(RePrefix::V, i, Arrangement::S, index);
        }
        let parts = a.split_at(1);
        if let Ok(value) = parts.1.parse::<usize>() {
            return Operand::VectorRegister(RePrefix::V, value);
        }
    }

    if a.starts_with("Q") || a.starts_with("q") {
        let parts = a.split_at(1);
        if let Ok(value) = parts.1.parse::<usize>() {
            return Operand::VectorRegister(RePrefix::V, value);
        }
    }

    if a.starts_with("D")
        || a.starts_with("S")
        || a.starts_with("H")
        || a.starts_with("B")
        || a.starts_with("d")
        || a.starts_with("s")
        || a.starts_with("h")
        || a.starts_with("b")
    {
        let parts = a.split_at(1);
        let arr: Arrangement = match parts.0 {
            "B" | "b" => Arrangement::B,
            "S" | "s" => Arrangement::S,
            "D" | "d" => Arrangement::D,
            "H" | "h" => Arrangement::H,
            a => panic!("invalid arrangement {}", a),
        };

        if let Ok(value) = parts.1.parse::<usize>() {
            return Operand::Vector(RePrefix::V, value, arr);
        }
    }

    if a.contains("[") || a.contains("]") {
        let mut parts = a.split(',').peekable();
        let mut base: String = String::new();
        let mut offset: Option<i64> = None;
        let mut register_offset: Option<Box<Operand>> = None;
        let mut indexing: Option<bool> = None;

        if let Some(b) = parts.next() {
            if b.contains("]") && parts.peek().is_some() {
                indexing = Some(true);
            }
            base = b.trim_matches(['[', ']', ',']).to_string();
        }

        if let Some(o) = parts.next() {
            let o = o.trim();
            if o.starts_with("x") || o.starts_with("w") {
                let index = operand_from_string(o.trim_matches(']').to_string());
                let scale = match parts.next().map(|s| s.trim().trim_matches(']')) {
                    None => 0,
                    Some(extension) => {
                        let (kind, amount) = extension
                            .split_once('#')
                            .map_or((extension, "0"), |(k, a)| (k.trim(), a));
                        match kind {
                            "lsl" | "uxtw" | "uxtx" => string_to_int(amount),
                            _ => panic!("unsupported index extension {extension}"),
                        }
                    }
                };
                register_offset = Some(Box::new(match index {
                    Operand::Register(prefix, n) if scale != 0 => {
                        Operand::Memory(prefix, n, Some(scale), None, None)
                    }
                    other => other,
                }));
            } else {
                offset = Some(string_to_int(o.trim_matches(['[', ']', ',', '#', '!'])));
                if let Some(unparsed) = parts.next() {
                    panic!("memory operand {a} has an unparsed tail {unparsed}");
                }
            }
        }

        if a.contains("!") {
            indexing = Some(false);
        }

        let mut num = 0;

        let prefix = {
            match base.as_str() {
                "sp" => RePrefix::Sp,
                "fp" => RePrefix::Fp,
                "ra" => RePrefix::Ra,
                "xzr" | "ze" => RePrefix::Ze,
                _ => {
                    let reg = base.split_at(1);
                    if let Ok(n) = reg.1.parse::<usize>() {
                        num = n;
                    }
                    match reg.0 {
                        "x" => RePrefix::X,
                        "w" => RePrefix::W,
                        _ => panic!("Unknown register prefix: {}", reg.0),
                    }
                }
            }
        };

        return Operand::Memory(prefix, num, offset, register_offset, indexing);
    }

    if !a.is_empty() {
        let stripped = a.trim_matches(|c| c == ':');
        return Operand::Label(stripped.to_string());
    }

    Operand::Other
}

fn combine_shifted_operands(parts: Vec<String>) -> Vec<String> {
    let mut result: Vec<String> = Vec::new();
    let mut parts = parts.into_iter().peekable();

    while let Some(part) = parts.next() {
        let shift = matches!(
            part.as_str(),
            "lsl"
                | "lsr"
                | "asr"
                | "ror"
                | "uxtb"
                | "uxth"
                | "uxtw"
                | "uxtx"
                | "sxtb"
                | "sxth"
                | "sxtw"
                | "sxtx"
        );
        if shift
            && let Some(amount) = parts.peek()
            && amount.starts_with('#')
        {
            let amount = parts.next().expect("peeked");
            result.push(format!("{part}{amount}"));
            continue;
        }
        result.push(part);
    }

    result
}

fn combine_addressing_modes_operands(parts: Vec<String>) -> Vec<String> {
    let mut result = Vec::new();

    let mut last_instance = parts.len() + 1;
    for (i, part) in parts.iter().enumerate().skip(1) {
        if part.contains("[") {
            last_instance = i;
        }
    }

    for j in 0..parts.len() {
        if j == last_instance {
            let rest = parts[j..].join(",");
            result.push(rest);
            break;
        } else {
            result.push(parts[j].clone());
        }
    }

    result
}

#[derive(Debug, Clone, PartialEq)]
pub enum InstructionType {
    Arithmetic,
    Memory,
    ControlFlow,
    SIMDArithmetic,
    SIMDManagement,
    Label,
    Def,
    Other,
}

fn match_instruction_type(opcode: &str, operands: &[Operand]) -> InstructionType {
    if operands.is_empty() {
        if opcode.ends_with(':') {
            return InstructionType::Label;
        }
        return InstructionType::Other;
    } else if opcode.starts_with('.') || opcode.starts_with('#') {
        return InstructionType::Def;
    } else if matches!(
        opcode,
        "ldr" | "ldp" | "str" | "stp" | "ldur" | "ldurb" | "ldurh" | "stur" | "sturb" | "sturh"
    ) && operands.iter().any(|op| matches!(op, Operand::Memory(..)))
    {
        return InstructionType::Memory;
    } else if operands
        .iter()
        .any(|op| matches!(op, Operand::VectorAccess(..)))
        || ((operands.iter().any(|op| matches!(op, Operand::Vector(..)))
            || operands
                .iter()
                .any(|op| matches!(op, Operand::VectorRegister(..))))
            && (operands
                .iter()
                .any(|op| matches!(op, Operand::Register(..)))
                || operands.iter().any(|op| matches!(op, Operand::Memory(..)))))
    {
        return InstructionType::SIMDManagement;
    } else if operands.iter().any(|op| matches!(op, Operand::Memory(..))) {
        return InstructionType::Memory;
    } else if operands.iter().any(|op| matches!(op, Operand::Address(..))) {
        return InstructionType::ControlFlow;
    } else if !matches!(opcode, "mov" | "movz" | "movk")
        && (operands.len() > 2 || opcode == "clz")
        && operands.iter().all(|op| {
            matches!(op, Operand::Register(..))
                || matches!(op, Operand::Immediate(_))
                || matches!(op, Operand::Bitwise(..))
        })
    {
        return InstructionType::Arithmetic;
    } else if operands
        .iter()
        .any(|op| matches!(op, Operand::Vector(..)) || matches!(op, Operand::VectorRegister(..)))
    {
        return InstructionType::SIMDArithmetic;
    } else if opcode.starts_with("b")
        || opcode.starts_with("j")
        || opcode.contains("adr")
        || opcode.starts_with("adrp")
        || opcode == "ret"
        || operands.iter().any(|op| matches!(op, Operand::Label(..)))
    {
        return InstructionType::ControlFlow;
    }
    InstructionType::Other
}

const CONDITION_CODES: [&str; 16] = [
    "eq", "ne", "cs", "hs", "cc", "lo", "mi", "pl", "vs", "vc", "hi", "ls", "ge", "lt", "gt", "le",
];

fn split_operands(input: &str) -> Vec<String> {
    let mut parts = Vec::new();
    let mut current = String::new();
    let mut depth = 0usize;
    for (at, c) in input.char_indices() {
        let continues_immediate = (c == ' ' || c == '\t')
            && current.contains('#')
            && (current.ends_with(['+', '-', '*'])
                || input[at..].trim_start().starts_with(['+', '-', '*']));
        if continues_immediate {
            continue;
        }
        match c {
            '(' => {
                depth += 1;
                current.push(c);
            }
            ')' => {
                depth = depth.saturating_sub(1);
                current.push(c);
            }
            ',' | ' ' | '\t' if depth == 0 => {
                if !current.is_empty() {
                    parts.push(std::mem::take(&mut current));
                }
            }
            _ => current.push(c),
        }
    }
    if !current.is_empty() {
        parts.push(current);
    }
    parts
}

fn split_vector_name(name: &str) -> (usize, String) {
    let (register, arrangement) = name
        .split_once('.')
        .expect("vector range endpoint needs an arrangement");
    let number = register
        .trim_start_matches(['v', 'V'])
        .parse::<usize>()
        .expect("vector range endpoint needs a register number");
    (number, arrangement.to_string())
}

fn expand_vector_ranges(input: &str) -> String {
    let Some(open) = input.find('{') else {
        return input.to_string();
    };
    let Some(close) = input[open..].find('}').map(|i| i + open) else {
        return input.to_string();
    };
    let group = &input[open + 1..close];
    if !group.contains('-') {
        return input.to_string();
    }

    let mut ends = group.split('-');
    let first = ends.next().expect("vector range start").trim();
    let last = ends.next().expect("vector range end").trim();
    let (first_num, arrangement) = split_vector_name(first);
    let (last_num, _) = split_vector_name(last);

    let count = if last_num >= first_num {
        last_num - first_num
    } else {
        last_num + 32 - first_num
    };
    let expanded = (0..=count)
        .map(|i| format!("v{}.{}", (first_num + i) % 32, arrangement))
        .collect::<Vec<_>>()
        .join(", ");

    format!("{}{{{}}}{}", &input[..open], expanded, &input[close + 1..])
}

impl Instruction {
    pub fn new(input: String) -> Self {
        let input = expand_vector_ranges(&input);
        let delete_curly_brackets = input
            .replace(" }", "")
            .replace("} ", "")
            .replace("{", " ")
            .replace("\t", " ")
            .replace("}", "");
        let mut parts = split_operands(&delete_curly_brackets).into_iter();
        let mut opcode = parts
            .next()
            .expect("Require opcode for instruction")
            .to_string();
        if let Some(condition) = opcode.strip_prefix('b')
            && CONDITION_CODES.contains(&condition)
        {
            opcode = format!("b.{condition}");
        }

        let combine_brackets = combine_addressing_modes_operands(combine_shifted_operands(
            parts.map(|s| s.to_string()).collect(),
        ));

        let operands: Vec<Operand> = combine_brackets
            .into_iter()
            .map(|s| operand_from_string(s.to_string()))
            .collect();

        let ty = match_instruction_type(&opcode, &operands);

        if ty == InstructionType::Label {
            opcode = opcode.trim_matches(|c| c == ':').to_string();
        }

        Instruction {
            ty,
            opcode,
            operands,
        }
    }

    pub fn is_simd(&self) -> bool {
        self.operands.iter().any(|op| {
            matches!(
                op,
                Operand::VectorRegister(..) | Operand::Vector(..) | Operand::VectorAccess(..)
            )
        })
    }

    pub fn is_label(&self) -> bool {
        self.ty == InstructionType::Label
    }
}

struct ConstantExpression<'a> {
    rest: &'a str,
}

impl ConstantExpression<'_> {
    fn eat(&mut self, token: &str) -> bool {
        self.rest = self.rest.trim_start();
        match self.rest.strip_prefix(token) {
            Some(after) => {
                self.rest = after;
                true
            }
            None => false,
        }
    }

    fn sum(&mut self) -> Option<i64> {
        let mut value = self.product()?;
        loop {
            if self.eat("+") {
                value = value.wrapping_add(self.product()?);
            } else if self.eat("-") {
                value = value.wrapping_sub(self.product()?);
            } else {
                return Some(value);
            }
        }
    }

    fn product(&mut self) -> Option<i64> {
        let mut value = self.unary()?;
        loop {
            if self.eat("*") {
                value = value.wrapping_mul(self.unary()?);
            } else if self.eat("/") {
                value = value.checked_div(self.unary()?)?;
            } else if self.eat("<<") {
                value = value.checked_shl(u32::try_from(self.unary()?).ok()?)?;
            } else if self.eat(">>") {
                value = value.checked_shr(u32::try_from(self.unary()?).ok()?)?;
            } else {
                return Some(value);
            }
        }
    }

    fn unary(&mut self) -> Option<i64> {
        if self.eat("-") {
            return self.unary().map(i64::wrapping_neg);
        }
        if self.eat("~") {
            return self.unary().map(|v| !v);
        }
        if self.eat("(") {
            let value = self.sum()?;
            return self.eat(")").then_some(value);
        }
        self.rest = self.rest.trim_start();
        let (digits, radix) = match self.rest.strip_prefix("0x") {
            Some(hex) => (hex, 16),
            None => (self.rest, 10),
        };
        let end = digits
            .find(|c: char| !c.is_digit(radix))
            .unwrap_or(digits.len());
        if end == 0 {
            return None;
        }
        let value = u64::from_str_radix(&digits[..end], radix).ok()? as i64;
        self.rest = &digits[end..];
        Some(value)
    }
}

fn constant_expression(s: &str) -> Option<i64> {
    let mut parser = ConstantExpression { rest: s };
    let value = parser.sum()?;
    parser.rest.trim().is_empty().then_some(value)
}

pub fn string_to_int(s: &str) -> i64 {
    let value: i64;
    let v = s.trim().trim_start_matches('#').trim();
    if let Some(value) = constant_expression(v) {
        return value;
    }
    if let Some(rest) = v.strip_prefix('~') {
        return !string_to_int(rest);
    }
    if let Some(inner) = v.strip_prefix('(').and_then(|i| i.strip_suffix(')')) {
        return string_to_int(inner);
    }
    if let Some((base, shift)) = v.split_once("<<") {
        value = string_to_int(base) << string_to_int(shift);
    } else if v.contains('*') {
        value = v.split('*').map(string_to_int).product();
    } else if v.contains('+') {
        value = v.split('+').map(string_to_int).sum();
    } else if v.starts_with("0x") {
        value = i128::from_str_radix(
            v.strip_prefix("0x").expect("radix parse strip 0x failed"),
            16,
        )
        .expect("radix parse failed") as i64;
    } else if v.starts_with("-0x") {
        value = -i128::from_str_radix(
            v.strip_prefix("-0x").expect("radix parse strip -0x failed"),
            16,
        )
        .expect("radix parse negative failed") as i64;
    } else {
        let clean = &v.replace(
            &['(', ')', ',', '\"', '.', ';', ':', '\'', '#', '[', ']'][..],
            "",
        );
        value = clean
            .parse::<i64>()
            .unwrap_or_else(|_| panic!("integer parsing failed {:?}", clean));
    }

    value
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn immediates_evaluate_with_assembler_precedence() {
        assert_eq!(string_to_int("#64*4-16"), 240);
        assert_eq!(string_to_int("#32*(12-4)"), 256);
        assert_eq!(string_to_int("#8*(10+2)"), 96);
        assert_eq!(string_to_int("#2+3*4"), 14);
        assert_eq!(string_to_int("#-8*8"), -64);
        assert_eq!(string_to_int("#1<<12"), 4096);
        assert_eq!(string_to_int("#0x10+1"), 17);
        assert_eq!(string_to_int("#~0"), -1);
    }

    #[test]
    fn a_shifted_register_index_keeps_its_shift() {
        let instruction = Instruction::new("ldr q24, [x3, x12, lsl #4]".to_string());
        let Operand::Memory(_, 3, None, Some(index), None) = &instruction.operands[1] else {
            panic!("{:?}", instruction.operands[1]);
        };
        assert_eq!(
            **index,
            Operand::Memory(RePrefix::X, 12, Some(4), None, None)
        );
    }

    #[test]
    fn mrs_reads_a_system_register_into_a_general_one() {
        let instruction = Instruction::new("mrs x2, s3_3_c2_c4_0".to_string());
        assert_eq!(instruction.opcode, "mrs");
        assert_eq!(instruction.operands[0], Operand::Register(RePrefix::X, 2));
    }

    #[test]
    fn test_parse_add_register() {
        let good_result = Instruction {
            ty: InstructionType::Arithmetic,
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 1),
            ]),
        };

        assert_eq!(Instruction::new("add x0,x0,x1".to_string()), good_result,);
        assert_eq!(
            Instruction::new("add x0 , x0 , x1".to_string()),
            good_result,
        );
        assert_eq!(
            Instruction::new(" add x0 , x0 , x1".to_string()),
            good_result,
        );
    }

    #[test]
    fn test_parse_add_immediate() {
        let good_result = Instruction {
            ty: InstructionType::Arithmetic,
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 0),
                Operand::Immediate(4),
            ]),
        };

        assert_eq!(Instruction::new("add x0,x0,#4".to_string()), good_result);
    }

    #[test]
    fn test_parse_add_shifted_immediate() {
        let good_result = Instruction {
            ty: InstructionType::Arithmetic,
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 0),
                Operand::Immediate(2),
                Operand::Bitwise(String::from("lsl"), 12),
            ]),
        };

        assert_eq!(
            Instruction::new("add x0,x0,#2,lsl#12".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_rev_single_src() {
        let good_result = Instruction {
            ty: InstructionType::Other,
            opcode: String::from("rev"),
            operands: Vec::from([
                Operand::Register(RePrefix::W, 3),
                Operand::Register(RePrefix::W, 3),
            ]),
        };

        assert_eq!(Instruction::new("rev w3,w3".to_string()), good_result);
    }

    #[test]
    fn test_parse_add_address() {
        let good_result = Instruction {
            ty: InstructionType::ControlFlow,
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 30),
                Operand::Register(RePrefix::X, 30),
                Operand::Address(String::from("LK256@PAGEOFF"), 0),
            ]),
        };
        assert_eq!(
            Instruction::new("add	x30,x30,LK256@PAGEOFF".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_str() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("str"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Memory(RePrefix::X, 29, None, None, None),
            ]),
        };
        assert_eq!(Instruction::new("str x0,[x29]".to_string()), good_result);
    }

    #[test]
    fn test_parse_str_immediate() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("str"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Memory(RePrefix::X, 29, Some(112), None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("str x0,[x29,#112]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_register_address() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 20),
                Operand::Register(RePrefix::X, 21),
                Operand::Memory(RePrefix::X, 0, None, None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("stp x20,x21,[x0]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_signed_offset() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 22),
                Operand::Register(RePrefix::X, 23),
                Operand::Memory(RePrefix::X, 0, Some(8), None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("stp x22,x23,[x0,#8]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_signed_offset_arithmetic() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 22),
                Operand::Register(RePrefix::X, 23),
                Operand::Memory(RePrefix::X, 0, Some(8), None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("stp x22,x23,[x0,#2*4]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_post_index() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 22),
                Operand::Register(RePrefix::X, 23),
                Operand::Memory(RePrefix::X, 0, Some(8), None, Some(true)),
            ]),
        };
        assert_eq!(
            Instruction::new("stp x22,x23,[x0],#8".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_post_index_arithmetic() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 22),
                Operand::Register(RePrefix::X, 23),
                Operand::Memory(RePrefix::X, 0, Some(8), None, Some(true)),
            ]),
        };
        assert_eq!(
            Instruction::new("stp x22,x23,[x0],#2*4".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_pre_index() {
        let good_result = Instruction {
            opcode: String::from("stp"),
            ty: InstructionType::Memory,
            operands: Vec::from([
                Operand::Register(RePrefix::X, 29),
                Operand::Register(RePrefix::X, 30),
                Operand::Memory(RePrefix::X, 0, Some(-128), None, Some(false)),
            ]),
        };
        assert_eq!(
            Instruction::new("stp x29,x30,[x0,#-128]!".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_cmp_register_immediate() {
        let good_result = Instruction {
            ty: InstructionType::Other,
            opcode: String::from("cmp"),
            operands: Vec::from([Operand::Register(RePrefix::X, 0), Operand::Immediate(2)]),
        };
        assert_eq!(Instruction::new("cmp x0,#2".to_string()), good_result);
    }

    #[test]
    fn test_parse_cmp_register() {
        let good_result = Instruction {
            ty: InstructionType::Other,
            opcode: String::from("cmp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 1),
            ]),
        };
        assert_eq!(Instruction::new("cmp x0,x1".to_string()), good_result);
    }

    #[test]
    fn test_parse_cmp_shifted_register() {
        let good_result = Instruction {
            ty: InstructionType::Arithmetic,
            opcode: String::from("cmp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 1),
                Operand::Bitwise(String::from("lsr"), 2),
            ]),
        };
        assert_eq!(Instruction::new("cmp x0,x1,lsr#2".to_string()), good_result);
    }

    #[test]
    fn test_parse_adrp() {
        let good_result = Instruction {
            ty: InstructionType::ControlFlow,
            opcode: String::from("adrp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 30),
                Operand::Address(String::from("LK256@PAGE"), 0),
            ]),
        };
        assert_eq!(
            Instruction::new("adrp x30,LK256@PAGE".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_adrp_from_sha256() {
        let good_result = Instruction {
            ty: InstructionType::ControlFlow,
            opcode: String::from("adrp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 9),
                Operand::Address(String::from("_BORINGSSL_function_hit@PAGEE"), 0),
            ]),
        };
        assert_eq!(
            Instruction::new("adrp	x9,_BORINGSSL_function_hit@PAGEE".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_b_condition_bne() {
        let good_result = Instruction {
            ty: InstructionType::ControlFlow,
            opcode: String::from("b.ne"),
            operands: Vec::from([Operand::Label(String::from("Loop"))]),
        };
        assert_eq!(Instruction::new("b.ne Loop".to_string()), good_result);
    }

    #[test]
    fn test_parse_b() {
        let good_result = Instruction {
            ty: InstructionType::ControlFlow,
            opcode: String::from("b"),
            operands: Vec::from([Operand::Label(String::from("Loop"))]),
        };
        assert_eq!(Instruction::new("b Loop".to_string()), good_result);
    }

    #[test]
    fn test_parse_cbnz() {
        let good_result = Instruction {
            ty: InstructionType::ControlFlow,
            opcode: String::from("cbnz"),
            operands: Vec::from([
                Operand::Register(RePrefix::W, 19),
                Operand::Label(String::from("Loop_16_xx")),
            ]),
        };
        assert_eq!(
            Instruction::new("cbnz w19,Loop_16_xx".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_spaced_shift_matches_unspaced() {
        assert_eq!(
            Instruction::new("add x19, x8, x17, lsl #4".to_string()),
            Instruction::new("add x19,x8,x17,lsl#4".to_string())
        );
        assert_eq!(
            Instruction::new("and w11, w19, w22, asr #31".to_string()),
            Instruction::new("and w11,w19,w22,asr#31".to_string())
        );
        assert_eq!(
            Instruction::new("add x4, x0, x1, lsr #3".to_string()),
            Instruction::new("add x4,x0,x1,lsr#3".to_string())
        );
    }

    #[test]
    fn test_parse_ret() {
        let good_result = Instruction {
            ty: InstructionType::Other,
            opcode: String::from("ret"),
            operands: Vec::new(),
        };
        assert_eq!(Instruction::new("ret".to_string()), good_result);
    }

    #[test]
    fn test_parse_simd_ld1() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("ld1"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 0, Arrangement::B16),
                Operand::Memory(RePrefix::X, 16, None, None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("ld1 { v0.16b }, [x16]".to_string()),
            good_result
        );
    }
    #[test]
    fn test_parse_simd_ld1_multiple_dst() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("ld1"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 24, Arrangement::D2),
                Operand::Vector(RePrefix::V, 25, Arrangement::D2),
                Operand::Vector(RePrefix::V, 26, Arrangement::D2),
                Operand::Vector(RePrefix::V, 27, Arrangement::D2),
                Operand::Memory(RePrefix::X, 10, None, None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("ld1 {v24.2d,v25.2d,v26.2d,v27.2d}, [x10]".to_string()),
            good_result
        );
    }
    #[test]
    fn test_parse_simd_ld1_multiple_dst_with_offset() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("ld1"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 20, Arrangement::D2),
                Operand::Vector(RePrefix::V, 21, Arrangement::D2),
                Operand::Vector(RePrefix::V, 22, Arrangement::D2),
                Operand::Vector(RePrefix::V, 23, Arrangement::D2),
                Operand::Memory(RePrefix::X, 10, Some(64), None, Some(true)),
            ]),
        };
        assert_eq!(
            Instruction::new("ld1	{v20.2d,v21.2d,v22.2d,v23.2d}, [x10],#64".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_st1() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("st1"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 5, Arrangement::H8),
                Operand::Memory(RePrefix::X, 0, None, None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("st1 { v5.8h }, [x0]".to_string()),
            good_result
        );
    }
    #[test]
    fn test_parse_simd_st1_register_offset() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("st1"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 0, Arrangement::S4),
                Operand::Memory(
                    RePrefix::X,
                    0,
                    None,
                    Some(Box::new(Operand::Register(RePrefix::X, 4))),
                    Some(true),
                ),
            ]),
        };
        assert_eq!(
            Instruction::new("st1{v0.4s},[x0],x4".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_st1_indexed() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("st1"),
            operands: Vec::from([
                Operand::VectorAccess(RePrefix::V, 1, Arrangement::S, 0),
                Operand::Memory(RePrefix::X, 0, None, None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("st1	{v1.s}[0],[x0]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_movi() {
        let good_result = Instruction {
            ty: InstructionType::SIMDArithmetic,
            opcode: String::from("movi"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 19, Arrangement::B16),
                Operand::Immediate(0xe1),
            ]),
        };
        assert_eq!(
            Instruction::new("movi v19.16b, #0xe1".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_aese() {
        let good_result = Instruction {
            ty: InstructionType::SIMDArithmetic,
            opcode: String::from("aese"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 0, Arrangement::B16),
                Operand::Vector(RePrefix::V, 18, Arrangement::B16),
            ]),
        };
        assert_eq!(
            Instruction::new("aese v0.16b, v18.16b".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_fmov() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("fmov"),
            operands: Vec::from([
                Operand::VectorAccess(RePrefix::V, 1, Arrangement::D, 1),
                Operand::Register(RePrefix::X, 9),
            ]),
        };
        assert_eq!(
            Instruction::new("fmov v1.d[1], x9".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_ext() {
        let good_result = Instruction {
            ty: InstructionType::SIMDArithmetic,
            opcode: String::from("ext"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 14, Arrangement::B16),
                Operand::Vector(RePrefix::V, 14, Arrangement::B16),
                Operand::Vector(RePrefix::V, 14, Arrangement::B16),
                Operand::Immediate(8),
            ]),
        };
        assert_eq!(
            Instruction::new("ext v14.16b, v14.16b, v14.16b, #8".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_arithmetic() {
        let good_result = Instruction {
            ty: InstructionType::SIMDArithmetic,
            opcode: String::from("eor"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 1, Arrangement::B16),
                Operand::Vector(RePrefix::V, 1, Arrangement::B16),
                Operand::Vector(RePrefix::V, 31, Arrangement::B16),
            ]),
        };
        assert_eq!(
            Instruction::new("eor v1.16b, v1.16b, v31.16b".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_st1_8h() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("st1.8h"),
            operands: Vec::from([
                Operand::VectorRegister(RePrefix::V, 30),
                Operand::VectorRegister(RePrefix::V, 31),
                Operand::Memory(RePrefix::X, 0, Some(32), None, Some(true)),
            ]),
        };
        assert_eq!(
            Instruction::new("st1.8h { v30, v31 }, [x0], #32".to_string()),
            good_result
        );
    }
    #[test]
    fn test_parse_simd_ushll() {
        let good_result = Instruction {
            ty: InstructionType::SIMDArithmetic,
            opcode: String::from("ushll.8h"),
            operands: Vec::from([
                Operand::VectorRegister(RePrefix::V, 2),
                Operand::VectorRegister(RePrefix::V, 2),
                Operand::Immediate(0),
            ]),
        };
        assert_eq!(
            Instruction::new("ushll.8h v2, v2, #0".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_label() {
        let good_result = Instruction {
            ty: InstructionType::Label,
            opcode: String::from("Loop"),
            operands: Vec::new(),
        };
        assert_eq!(Instruction::new("Loop:".to_string()), good_result);
    }

    #[test]
    fn test_parse_label_with_underscore() {
        let good_result = Instruction {
            ty: InstructionType::Label,
            opcode: String::from("_Loop"),
            operands: Vec::new(),
        };
        assert_eq!(Instruction::new("_Loop:".to_string()), good_result);
    }

    #[test]
    fn test_string_to_int_sums_and_products() {
        assert_eq!(string_to_int("2+1"), 3);
        assert_eq!(string_to_int("8*(2+1)"), 24);
        assert_eq!(string_to_int("8*(1+1)"), 16);
        assert_eq!(string_to_int("8"), 8);
        assert_eq!(string_to_int("8*4"), 32);
    }

    #[test]
    fn test_leading_underscores_distinguish_labels() {
        let public = Instruction::new("_ecp_nistz256_mul_mont:".to_string());
        let internal = Instruction::new("__ecp_nistz256_mul_mont:".to_string());
        assert_ne!(public.opcode, internal.opcode);
    }

    #[test]
    fn test_parse_cset_with_condition() {
        let good_result = Instruction {
            ty: InstructionType::ControlFlow,
            opcode: String::from("cset"),
            operands: Vec::from([
                Operand::Register(RePrefix::W, 0),
                Operand::Label("eq".to_string()),
            ]),
        };
        assert_eq!(Instruction::new("cset w0, eq".to_string()), good_result);
    }

    #[test]
    fn test_parse_def_for_memory_long() {
        let good_result = Instruction {
            ty: InstructionType::Def,
            opcode: String::from(".long"),
            operands: Vec::from([
                Operand::Immediate(0x90befffa),
                Operand::Immediate(0xa4506ceb),
                Operand::Immediate(0xbef9a3f7),
                Operand::Immediate(0xc67178f2),
            ]),
        };
        assert_eq!(
            Instruction::new(".long	0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_globl_def() {
        let good_result = Instruction {
            ty: InstructionType::Def,
            opcode: String::from(".globl"),
            operands: Vec::from([Operand::Label(String::from("_sha256_block_data_order"))]),
        };
        assert_eq!(
            Instruction::new(".globl	_sha256_block_data_order".to_string()),
            good_result
        );
    }

    #[test]
    fn spaced_offset_sum_keeps_every_term() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("strb"),
            operands: Vec::from([
                Operand::Register(RePrefix::W, 13),
                Operand::Memory(RePrefix::X, 23, Some(31), None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("strb w13, [x23, #0 +31]".to_string()),
            good_result
        );
        assert_eq!(
            Instruction::new("strb w13, [x23, #0 + 31]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_rav1d_notation_st1d() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("st1.d"),
            operands: Vec::from([
                Operand::VectorAccess(RePrefix::V, 0, Arrangement::S, 1),
                Operand::Memory(
                    RePrefix::X,
                    0,
                    None,
                    Some(Box::new(Operand::Register(RePrefix::X, 4))),
                    Some(true),
                ),
            ]),
        };
        assert_eq!(
            Instruction::new("st1.d	{ v0 }[1], [x0], x4".to_string()),
            good_result
        );
    }
}
