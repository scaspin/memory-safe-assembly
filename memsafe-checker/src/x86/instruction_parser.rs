use std::fmt;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Register {
    Gpr {
        index: usize,
        width: i64,
        high: bool,
    },
    Vector {
        index: usize,
        width: i64,
    },
    Mask(usize),
    Rip,
    Segment,
}

impl Register {
    pub fn width(&self) -> i64 {
        match self {
            Register::Gpr { width, .. } | Register::Vector { width, .. } => *width,
            Register::Mask(_) | Register::Rip => 8,
            Register::Segment => 2,
        }
    }

    pub fn is_gpr(&self) -> bool {
        matches!(self, Register::Gpr { .. })
    }

    pub fn is_vector(&self) -> bool {
        matches!(self, Register::Vector { .. })
    }
}

pub const RAX: usize = 0;
pub const RCX: usize = 1;
pub const RDX: usize = 2;
pub const RBX: usize = 3;
pub const RSP: usize = 4;
pub const RBP: usize = 5;
pub const RSI: usize = 6;
pub const RDI: usize = 7;

const GPR64: [&str; 16] = [
    "rax", "rcx", "rdx", "rbx", "rsp", "rbp", "rsi", "rdi", "r8", "r9", "r10", "r11", "r12", "r13",
    "r14", "r15",
];
const GPR32: [&str; 8] = ["eax", "ecx", "edx", "ebx", "esp", "ebp", "esi", "edi"];
const GPR16: [&str; 8] = ["ax", "cx", "dx", "bx", "sp", "bp", "si", "di"];
const GPR8: [&str; 8] = ["al", "cl", "dl", "bl", "spl", "bpl", "sil", "dil"];
const GPR8_HIGH: [&str; 4] = ["ah", "ch", "dh", "bh"];

pub fn gpr(index: usize, width: i64) -> Register {
    Register::Gpr {
        index,
        width,
        high: false,
    }
}

pub fn register_name(r: &Register) -> String {
    match r {
        Register::Gpr { index, width, high } => {
            if *high {
                return GPR8_HIGH[*index].to_string();
            }
            match (*index, *width) {
                (i, 8) => GPR64[i].to_string(),
                (i, 4) if i < 8 => GPR32[i].to_string(),
                (i, 2) if i < 8 => GPR16[i].to_string(),
                (i, 1) if i < 8 => GPR8[i].to_string(),
                (i, 4) => format!("r{i}d"),
                (i, 2) => format!("r{i}w"),
                (i, _) => format!("r{i}b"),
            }
        }
        Register::Vector { index, width } => match width {
            16 => format!("xmm{index}"),
            32 => format!("ymm{index}"),
            _ => format!("zmm{index}"),
        },
        Register::Mask(i) => format!("k{i}"),
        Register::Rip => "rip".to_string(),
        Register::Segment => "segment".to_string(),
    }
}

pub fn parse_register(name: &str) -> Option<Register> {
    let name = name.trim().trim_start_matches('%').to_lowercase();
    if let Some(i) = GPR64.iter().position(|r| *r == name) {
        return Some(gpr(i, 8));
    }
    if let Some(i) = GPR32.iter().position(|r| *r == name) {
        return Some(gpr(i, 4));
    }
    if let Some(i) = GPR16.iter().position(|r| *r == name) {
        return Some(gpr(i, 2));
    }
    if let Some(i) = GPR8.iter().position(|r| *r == name) {
        return Some(gpr(i, 1));
    }
    if let Some(i) = GPR8_HIGH.iter().position(|r| *r == name) {
        return Some(Register::Gpr {
            index: i,
            width: 1,
            high: true,
        });
    }
    if let Some(rest) = name.strip_prefix('r') {
        let digits: String = rest.chars().take_while(|c| c.is_ascii_digit()).collect();
        if let Ok(i) = digits.parse::<usize>()
            && (8..16).contains(&i)
        {
            let width = match &rest[digits.len()..] {
                "" => 8,
                "d" => 4,
                "w" => 2,
                "b" | "l" => 1,
                _ => return None,
            };
            return Some(gpr(i, width));
        }
    }
    for (prefix, width) in [("xmm", 16), ("ymm", 32), ("zmm", 64)] {
        if let Some(i) = name
            .strip_prefix(prefix)
            .and_then(|n| n.parse::<usize>().ok())
            && i < 32
        {
            return Some(Register::Vector { index: i, width });
        }
    }
    if let Some(i) = name.strip_prefix('k').and_then(|n| n.parse::<usize>().ok())
        && i < 8
    {
        return Some(Register::Mask(i));
    }
    match name.as_str() {
        "rip" => Some(Register::Rip),
        "cs" | "ds" | "es" | "ss" | "fs" | "gs" => Some(Register::Segment),
        _ => None,
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct MemoryOperand {
    pub segment: bool,
    pub symbol: Option<String>,
    pub displacement: i64,
    pub base: Option<Register>,
    pub index: Option<Register>,
    pub scale: i64,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Operand {
    Register(Register),
    Immediate(i64),
    Memory(MemoryOperand),
    Label(String),
    Indirect(Box<Operand>),
    Other(String),
}

impl Operand {
    pub fn is_memory(&self) -> bool {
        matches!(self, Operand::Memory(_))
    }

    pub fn register(&self) -> Option<Register> {
        match self {
            Operand::Register(r) => Some(*r),
            _ => None,
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum InstructionType {
    Label,
    Instruction,
}

#[derive(Debug, Clone, PartialEq)]
pub struct Instruction {
    pub ty: InstructionType,
    pub opcode: String,
    pub mnemonic: String,
    pub suffix_width: Option<i64>,
    pub prefixes: Vec<String>,
    pub operands: Vec<Operand>,
    pub mask: Option<usize>,
}

impl fmt::Display for Instruction {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{} {:?}", self.opcode, self.operands)
    }
}

const PREFIXES: [&str; 17] = [
    "rep", "repe", "repz", "repne", "repnz", "lock", "notrack", "bnd", "data16", "data32",
    "addr32", "cs", "ds", "ss", "es", "fs", "gs",
];

pub const CONDITION_CODES: [&str; 30] = [
    "e", "z", "ne", "nz", "b", "c", "nae", "ae", "nb", "nc", "be", "na", "a", "nbe", "s", "ns",
    "l", "nge", "ge", "nl", "le", "ng", "g", "nle", "o", "no", "p", "pe", "np", "po",
];

const SUFFIXED: [&str; 63] = [
    "mov", "movabs", "lea", "add", "sub", "adc", "sbb", "and", "or", "xor", "not", "neg", "inc",
    "dec", "cmp", "test", "shl", "sal", "shr", "sar", "rol", "ror", "rcl", "rcr", "shld", "shrd",
    "imul", "mul", "div", "idiv", "bswap", "xchg", "bt", "bts", "btr", "btc", "push", "pop",
    "call", "ret", "jmp", "nop", "xadd", "cmpxchg", "popcnt", "lzcnt", "tzcnt", "bsf", "bsr",
    "andn", "mulx", "adcx", "adox", "rorx", "sarx", "shlx", "shrx", "bzhi", "leave", "stos",
    "lods", "movs", "movbe",
];

fn is_conditional(mnemonic: &str, stem: &str) -> bool {
    mnemonic
        .strip_prefix(stem)
        .is_some_and(|cc| CONDITION_CODES.contains(&cc))
}

fn is_plain(m: &str) -> bool {
    SUFFIXED.contains(&m)
        || is_conditional(m, "j")
        || is_conditional(m, "cmov")
        || is_conditional(m, "set")
        || matches!(
            m,
            "cltq"
                | "cqto"
                | "cltd"
                | "cwtl"
                | "cdqe"
                | "cqo"
                | "cdq"
                | "cwde"
                | "endbr64"
                | "ud2"
                | "int3"
                | "hlt"
                | "rdrand"
                | "rdseed"
                | "cpuid"
                | "xgetbv"
                | "rdtsc"
                | "lfence"
                | "mfence"
                | "sfence"
                | "pause"
                | "vzeroupper"
                | "vzeroall"
                | "emms"
                | "clc"
                | "stc"
                | "cmc"
                | "cld"
                | "std"
                | "jrcxz"
                | "jecxz"
                | "loop"
        )
        || m.starts_with("prefetch")
}

fn suffix_bytes(c: char) -> Option<i64> {
    match c {
        'b' => Some(1),
        'w' => Some(2),
        'l' => Some(4),
        'q' => Some(8),
        _ => None,
    }
}

pub fn split_suffix(opcode: &str, operand_count: usize) -> (String, Option<i64>) {
    for stem in ["movz", "movs"] {
        if let Some(widths) = opcode.strip_prefix(stem)
            && widths.len() == 2
            && operand_count == 2
        {
            let mut cs = widths.chars();
            if let (Some(from), Some(to)) = (cs.next(), cs.next())
                && let (Some(_), Some(to_width)) = (suffix_bytes(from), suffix_bytes(to))
            {
                return (format!("{stem}x{from}"), Some(to_width));
            }
        }
    }
    for stem in ["movs", "stos", "lods", "cmps", "scas"] {
        if let Some(w) = opcode.strip_prefix(stem)
            && operand_count == 0
            && let Some(width) = w.chars().next().and_then(suffix_bytes)
            && w.len() == 1
        {
            return (stem.to_string(), Some(width));
        }
    }
    if is_plain(opcode) {
        return (opcode.to_string(), None);
    }
    if let Some(last) = opcode.chars().last()
        && let Some(width) = suffix_bytes(last)
    {
        let stem = &opcode[..opcode.len() - 1];
        if is_plain(stem) {
            return (stem.to_string(), Some(width));
        }
    }
    (opcode.to_string(), None)
}

pub fn evaluate(text: &str) -> Option<i64> {
    let tokens = tokenize(text)?;
    let mut position = 0;
    let value = sum(&tokens, &mut position)?;
    (position == tokens.len()).then_some(value)
}

#[derive(Debug, Clone, PartialEq)]
enum Token {
    Number(i64),
    Op(&'static str),
}

fn tokenize(text: &str) -> Option<Vec<Token>> {
    let chars: Vec<char> = text.trim().chars().collect();
    let mut tokens = Vec::new();
    let mut i = 0;
    while i < chars.len() {
        let c = chars[i];
        if c.is_whitespace() {
            i += 1;
        } else if c.is_ascii_digit() {
            let start = i;
            while i < chars.len() && chars[i].is_ascii_alphanumeric() {
                i += 1;
            }
            let literal: String = chars[start..i].iter().collect();
            let value = match literal
                .strip_prefix("0x")
                .or_else(|| literal.strip_prefix("0X"))
            {
                Some(hex) => u64::from_str_radix(hex, 16).ok()? as i64,
                None => literal.parse::<u64>().ok()? as i64,
            };
            tokens.push(Token::Number(value));
        } else {
            let two: String = chars[i..chars.len().min(i + 2)].iter().collect();
            let op = match two.as_str() {
                "<<" => "<<",
                ">>" => ">>",
                _ => match c {
                    '+' => "+",
                    '-' => "-",
                    '*' => "*",
                    '/' => "/",
                    '%' => "%",
                    '~' => "~",
                    '(' => "(",
                    ')' => ")",
                    _ => return None,
                },
            };
            i += op.len();
            tokens.push(Token::Op(op));
        }
    }
    Some(tokens)
}

fn sum(tokens: &[Token], position: &mut usize) -> Option<i64> {
    let mut value = product(tokens, position)?;
    while let Some(Token::Op(op @ ("+" | "-"))) = tokens.get(*position) {
        *position += 1;
        let right = product(tokens, position)?;
        value = if *op == "+" {
            value.wrapping_add(right)
        } else {
            value.wrapping_sub(right)
        };
    }
    Some(value)
}

fn product(tokens: &[Token], position: &mut usize) -> Option<i64> {
    let mut value = unary(tokens, position)?;
    while let Some(Token::Op(op @ ("*" | "/" | "%" | "<<" | ">>"))) = tokens.get(*position) {
        *position += 1;
        let right = unary(tokens, position)?;
        value = match *op {
            "*" => value.wrapping_mul(right),
            "/" => value.checked_div(right)?,
            "%" => value.checked_rem(right)?,
            "<<" => value.checked_shl(u32::try_from(right).ok()?)?,
            _ => value.checked_shr(u32::try_from(right).ok()?)?,
        };
    }
    Some(value)
}

fn unary(tokens: &[Token], position: &mut usize) -> Option<i64> {
    let token = tokens.get(*position)?.clone();
    *position += 1;
    match token {
        Token::Number(n) => Some(n),
        Token::Op("-") => unary(tokens, position).map(i64::wrapping_neg),
        Token::Op("+") => unary(tokens, position),
        Token::Op("~") => unary(tokens, position).map(|v| !v),
        Token::Op("(") => {
            let value = sum(tokens, position)?;
            (tokens.get(*position) == Some(&Token::Op(")"))).then(|| {
                *position += 1;
                value
            })
        }
        _ => None,
    }
}

fn symbol_and_offset(text: &str) -> Option<(Option<String>, i64)> {
    let text = text.trim();
    if text.is_empty() {
        return Some((None, 0));
    }
    if let Some(v) = evaluate(text) {
        return Some((None, v));
    }
    let starts_symbol = |c: char| c.is_ascii_alphabetic() || c == '_' || c == '.' || c == '$';
    if !text.starts_with(starts_symbol) {
        return None;
    }
    let end = text.find(['+', '-']).unwrap_or(text.len());
    let symbol = text[..end].trim().to_string();
    let offset = if end < text.len() {
        evaluate(text[end..].trim_start_matches('+'))?
    } else {
        0
    };
    Some((Some(symbol), offset))
}

fn parse_memory(text: &str) -> Option<MemoryOperand> {
    let mut text = text.trim();
    let mut segment = false;
    if let Some((seg, rest)) = text.split_once(':')
        && parse_register(seg) == Some(Register::Segment)
    {
        segment = true;
        text = rest;
    }
    let open = text.rfind('(')?;
    let close = text.rfind(')')?;
    if close < open || !text[close + 1..].trim().is_empty() {
        return None;
    }
    let (symbol, displacement) = symbol_and_offset(&text[..open])?;
    let inside: Vec<&str> = text[open + 1..close].split(',').map(str::trim).collect();
    let base = match inside.first() {
        Some(b) if !b.is_empty() => Some(parse_register(b)?),
        _ => None,
    };
    let index = match inside.get(1) {
        Some(i) if !i.is_empty() => Some(parse_register(i)?),
        _ => None,
    };
    let scale = match inside.get(2) {
        Some(s) if !s.is_empty() => evaluate(s)?,
        _ => 1,
    };
    Some(MemoryOperand {
        segment,
        symbol,
        displacement,
        base,
        index,
        scale,
    })
}

pub fn parse_operand(text: &str) -> Operand {
    let text = match text.find('{') {
        Some(i) => text[..i].trim(),
        None => text.trim(),
    };
    if let Some(rest) = text.strip_prefix('*') {
        return Operand::Indirect(Box::new(parse_operand(rest)));
    }
    if let Some(imm) = text.strip_prefix('$') {
        return match evaluate(imm) {
            Some(v) => Operand::Immediate(v),
            None => Operand::Other(text.to_string()),
        };
    }
    if text.starts_with('%') && !text.contains('(') {
        if let Some(memory) = text.contains(':').then(|| parse_memory(text)).flatten() {
            return Operand::Memory(memory);
        }
        return match parse_register(text) {
            Some(r) => Operand::Register(r),
            None => Operand::Other(text.to_string()),
        };
    }
    if text.contains('(')
        && let Some(memory) = parse_memory(text)
    {
        return Operand::Memory(memory);
    }
    if let Some((index, target)) = text.split_once(':')
        && index.parse::<i64>().is_ok()
    {
        return Operand::Label(format!("{index}:{target}"));
    }
    if let Some(v) = evaluate(text) {
        return Operand::Other(format!("{v:#x}"));
    }
    Operand::Label(text.to_string())
}

fn split_operands(input: &str) -> Vec<String> {
    let mut parts = Vec::new();
    let mut current = String::new();
    let mut depth = 0usize;
    for c in input.chars() {
        match c {
            '(' | '{' => {
                depth += 1;
                current.push(c);
            }
            ')' | '}' => {
                depth = depth.saturating_sub(1);
                current.push(c);
            }
            ',' if depth == 0 => parts.push(std::mem::take(&mut current).trim().to_string()),
            _ => current.push(c),
        }
    }
    if !current.trim().is_empty() {
        parts.push(current.trim().to_string());
    }
    parts
}

impl Instruction {
    pub fn new(input: String) -> Self {
        let text = input.replace('\t', " ");
        let text = text.trim();

        if let Some(label) = text.strip_suffix(':')
            && !label.contains(char::is_whitespace)
        {
            return Instruction {
                ty: InstructionType::Label,
                opcode: label.to_string(),
                mnemonic: String::new(),
                suffix_width: None,
                prefixes: Vec::new(),
                operands: Vec::new(),
                mask: None,
            };
        }

        let mut words = text.splitn(2, ' ');
        let mut opcode = words.next().unwrap_or_default().to_lowercase();
        let mut rest = words.next().unwrap_or_default().trim().to_string();
        let mut prefixes = Vec::new();
        while PREFIXES.contains(&opcode.as_str()) && !rest.is_empty() {
            prefixes.push(opcode);
            let mut words = rest.splitn(2, ' ');
            opcode = words.next().unwrap_or_default().to_lowercase();
            rest = words.next().unwrap_or_default().trim().to_string();
        }
        if let Some(p) = opcode.strip_suffix(';')
            && PREFIXES.contains(&p)
        {
            prefixes.push(p.to_string());
            let mut words = rest.splitn(2, ' ');
            opcode = words.next().unwrap_or_default().to_lowercase();
            rest = words.next().unwrap_or_default().trim().to_string();
        }

        let operands: Vec<Operand> = split_operands(&rest)
            .iter()
            .filter(|s| !s.is_empty())
            .map(|s| parse_operand(s))
            .collect();
        let (mnemonic, suffix_width) = split_suffix(&opcode, operands.len());
        let mask = rest.split("{%k").nth(1).and_then(|after| {
            after
                .split('}')
                .next()
                .and_then(|n| n.parse::<usize>().ok())
                .filter(|k| (1..8).contains(k))
        });

        Instruction {
            ty: InstructionType::Instruction,
            opcode,
            mnemonic,
            suffix_width,
            prefixes,
            operands,
            mask,
        }
    }

    pub fn is_label(&self) -> bool {
        self.ty == InstructionType::Label
    }

    pub fn operand_width(&self) -> Option<i64> {
        self.suffix_width.or_else(|| {
            self.operands
                .iter()
                .filter_map(|o| o.register().filter(|r| r.is_gpr()).map(|r| r.width()))
                .max()
        })
    }
}

fn modrm_operand(bytes: &[u8], rex: u8, wide: bool) -> Option<(String, usize, u8)> {
    let modrm = *bytes.first()?;
    let (mode, reg, rm) = (
        modrm >> 6,
        ((modrm >> 3) & 7) | (((rex >> 2) & 1) << 3),
        modrm & 7,
    );
    let (rex_x, rex_b) = ((rex >> 1) & 1, rex & 1);
    if mode == 3 {
        let r = register_name(&gpr((rm | (rex_b << 3)) as usize, if wide { 8 } else { 4 }));
        return Some((format!("%{r}"), 1, reg));
    }
    let mut used = 1;
    let (mut base, mut index, mut scale) = (Some(rm | (rex_b << 3)), None, 1);
    if rm == 4 {
        let sib = *bytes.get(1)?;
        used += 1;
        scale = 1 << (sib >> 6);
        let i = ((sib >> 3) & 7) | (rex_x << 3);
        index = (i != 4).then_some(i);
        base = Some((sib & 7) | (rex_b << 3));
        if sib & 7 == 5 && mode == 0 {
            base = None;
        }
    } else if rm == 5 && mode == 0 {
        return None;
    }
    let displacement = match (mode, base) {
        (1, _) => {
            let d = *bytes.get(used)? as i8 as i64;
            used += 1;
            d
        }
        (2, _) | (0, None) => {
            let d = i32::from_le_bytes(bytes.get(used..used + 4)?.try_into().ok()?) as i64;
            used += 4;
            d
        }
        _ => 0,
    };
    let name = |r: u8| format!("%{}", register_name(&gpr(r as usize, 8)));
    let inside = match (base, index) {
        (Some(b), Some(i)) => format!("{},{},{scale}", name(b), name(i)),
        (Some(b), None) => name(b),
        (None, Some(i)) => format!(",{},{scale}", name(i)),
        (None, None) => String::new(),
    };
    Some((format!("{displacement}({inside})"), used, reg))
}

pub fn decode_encoded(bytes: &[u8]) -> Option<String> {
    match bytes {
        [0xf3, 0xc3] => return Some("ret".to_string()),
        [0xf3, 0x0f, 0x1e, 0xfa] => return Some("endbr64".to_string()),
        [0xf3, 0x0f, 0x1e, 0xfb] => return Some("nop".to_string()),
        [0x66] | [0x67] | [0x67, 0x67] | [0x2e] | [0x3e] | [0x66, 0x90] | [0x90] => {
            return Some("nop".to_string());
        }
        _ => (),
    }
    if let [0xc4, b1, b2, 0xf6, rest @ ..] = bytes
        && b1 & 0x1f == 2
        && b2 & 3 == 3
    {
        let rex = (!b1 >> 5) & 7;
        let wide = b2 & 0x80 != 0;
        let (source, used, reg) = modrm_operand(rest, rex, wide)?;
        if used != rest.len() {
            return None;
        }
        let low = (!b2 >> 3) & 15;
        let width = if wide { 8 } else { 4 };
        let hi = register_name(&gpr(reg as usize, width));
        let lo = register_name(&gpr(low as usize, width));
        return Some(format!("mulx {source},%{lo},%{hi}"));
    }
    let mut i = 0;
    let mut operand_size = false;
    while i < bytes.len() && matches!(bytes[i], 0x66 | 0xf2 | 0xf3) {
        operand_size |= bytes[i] == 0x66;
        i += 1;
    }
    let rex = match bytes.get(i) {
        Some(b) if (0x40..=0x4f).contains(b) => {
            i += 1;
            *b
        }
        _ => 0,
    };
    let wide = rex & 8 != 0;
    if bytes.get(i) != Some(&0x0f) {
        return None;
    }
    i += 1;
    let map = match bytes.get(i) {
        Some(0x38) => {
            i += 1;
            0x38
        }
        Some(0x3a) => {
            i += 1;
            0x3a
        }
        _ => 0,
    };
    let opcode = *bytes.get(i)?;
    i += 1;
    let (operand, used, reg) = modrm_operand(bytes.get(i..)?, rex, wide)?;
    let immediate = if map == 0x3a { 1 } else { 0 };
    if i + used + immediate != bytes.len() {
        return None;
    }
    let register_form = operand.starts_with('%');
    let gpr_name = |index: u8| register_name(&gpr(index as usize, if wide { 8 } else { 4 }));
    let xmm = |index: u8| format!("%xmm{index}");
    let rm_vector = |operand: &str| -> String {
        let n = bytes[i] & 7 | ((rex & 1) << 3);
        if operand.starts_with('%') {
            xmm(n)
        } else {
            operand.to_string()
        }
    };
    Some(match (map, opcode) {
        (0, 0x1f) | (0, 0x18) | (0, 0x0d) => "nop".to_string(),
        (0, 0x7e) if operand_size => {
            let mnemonic = if wide { "movq" } else { "movd" };
            format!("{mnemonic} {},{operand}", xmm(reg))
        }
        (0, 0x6e) if operand_size => {
            let mnemonic = if wide { "movq" } else { "movd" };
            format!("{mnemonic} {operand},{}", xmm(reg))
        }
        (0, 0xc7) if register_form && reg & 7 == 6 => format!("rdrand {operand}"),
        (0, 0xc7) if register_form && reg & 7 == 7 => format!("rdseed {operand}"),
        (0x38, 0xf0) if !register_form => format!("movbe {operand},%{}", gpr_name(reg)),
        (0x38, 0xf1) if !register_form => format!("movbe %{},{operand}", gpr_name(reg)),
        _ if updates_only_its_vector(map, opcode) => {
            format!("bums.vector_op {},{}", rm_vector(&operand), xmm(reg))
        }
        _ => return None,
    })
}

fn updates_only_its_vector(map: u8, opcode: u8) -> bool {
    match map {
        0x38 => matches!(
            opcode,
            0x00..=0x0b
                | 0x10
                | 0x14
                | 0x15
                | 0x1c..=0x1e
                | 0x20..=0x25
                | 0x28..=0x2b
                | 0x30..=0x35
                | 0x37..=0x41
                | 0xc8..=0xcd
                | 0xdb..=0xdf
        ),
        0x3a => matches!(
            opcode,
            0x08..=0x0f | 0x20..=0x22 | 0x40..=0x42 | 0x44 | 0xcc | 0xdf
        ),
        _ => matches!(
            opcode,
            0x10 | 0x12
                | 0x14..=0x16
                | 0x28
                | 0x51..=0x5f
                | 0x60..=0x6d
                | 0x6f
                | 0x74..=0x76
                | 0xd1..=0xd5
                | 0xd8..=0xdf
                | 0xe0..=0xe5
                | 0xe8..=0xef
                | 0xf1..=0xf6
                | 0xf8..=0xfe
        ),
    }
}

pub fn byte_values(line: &str) -> Option<Vec<u8>> {
    let rest = line.trim().strip_prefix(".byte")?;
    rest.split(',')
        .map(|v| evaluate(v.trim()).and_then(|v| u8::try_from(v & 0xff).ok()))
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn memory(base: Option<Register>, index: Option<Register>, scale: i64, d: i64) -> Operand {
        Operand::Memory(MemoryOperand {
            segment: false,
            symbol: None,
            displacement: d,
            base,
            index,
            scale,
        })
    }

    #[test]
    fn parses_register_to_register() {
        let i = Instruction::new("movq %rdi,%rbp".to_string());
        assert_eq!(i.mnemonic, "mov");
        assert_eq!(i.suffix_width, Some(8));
        assert_eq!(
            i.operands,
            vec![
                Operand::Register(gpr(RDI, 8)),
                Operand::Register(gpr(RBP, 8))
            ]
        );
    }

    #[test]
    fn parses_scaled_index_with_displacement() {
        let i = Instruction::new("leal -680876936(%rax,%r10,1),%eax".to_string());
        assert_eq!(i.mnemonic, "lea");
        assert_eq!(
            i.operands[0],
            memory(Some(gpr(RAX, 8)), Some(gpr(10, 8)), 1, -680876936)
        );
        assert_eq!(i.operands[1], Operand::Register(gpr(RAX, 4)));
    }

    #[test]
    fn evaluates_perlasm_arithmetic() {
        let i = Instruction::new("movq %rdi,64+0(%rsp)".to_string());
        assert_eq!(i.operands[1], memory(Some(gpr(RSP, 8)), None, 1, 64));
        assert_eq!(evaluate("64+32"), Some(96));
        assert_eq!(evaluate("16*4-8"), Some(56));
        assert_eq!(evaluate("-0x40"), Some(-64));
        assert_eq!(evaluate("1<<3"), Some(8));
    }

    #[test]
    fn parses_rip_relative_symbol() {
        let i = Instruction::new("leaq K256+128(%rip),%rbp".to_string());
        match &i.operands[0] {
            Operand::Memory(m) => {
                assert_eq!(m.symbol.as_deref(), Some("K256"));
                assert_eq!(m.displacement, 128);
                assert_eq!(m.base, Some(Register::Rip));
            }
            other => panic!("{other:?}"),
        }
    }

    #[test]
    fn parses_index_without_base() {
        let i = Instruction::new("movl (,%rax,4),%ecx".to_string());
        assert_eq!(i.operands[0], memory(None, Some(gpr(RAX, 8)), 4, 0));
    }

    #[test]
    fn parses_labels_both_spellings() {
        assert!(Instruction::new("L$loop:".to_string()).is_label());
        assert!(Instruction::new(".Lloop:".to_string()).is_label());
        assert_eq!(
            Instruction::new("_md5_block:".to_string()).opcode,
            "_md5_block"
        );
    }

    #[test]
    fn splits_size_suffixes_without_breaking_condition_codes() {
        assert_eq!(split_suffix("addq", 2), ("add".to_string(), Some(8)));
        assert_eq!(split_suffix("cmovl", 2), ("cmovl".to_string(), None));
        assert_eq!(split_suffix("cmovaeq", 2), ("cmovae".to_string(), Some(8)));
        assert_eq!(split_suffix("setb", 1), ("setb".to_string(), None));
        assert_eq!(split_suffix("movzbl", 2), ("movzxb".to_string(), Some(4)));
        assert_eq!(split_suffix("movslq", 2), ("movsxl".to_string(), Some(8)));
        assert_eq!(split_suffix("movsq", 0), ("movs".to_string(), Some(8)));
        assert_eq!(split_suffix("movsd", 2), ("movsd".to_string(), None));
        assert_eq!(split_suffix("pxor", 2), ("pxor".to_string(), None));
        assert_eq!(split_suffix("jne", 1), ("jne".to_string(), None));
    }

    #[test]
    fn parses_prefixes_and_indirect_targets() {
        let i = Instruction::new("rep stosq".to_string());
        assert_eq!(i.prefixes, vec!["rep".to_string()]);
        assert_eq!(i.mnemonic, "stos");
        let j = Instruction::new("jmp *%rax".to_string());
        assert_eq!(
            j.operands[0],
            Operand::Indirect(Box::new(Operand::Register(gpr(RAX, 8))))
        );
    }

    #[test]
    fn parses_objdump_hex_and_avx512_decorations() {
        let i = Instruction::new("vmovdqu8 %zmm1, -0x40(%rdi,%rax){%k1}".to_string());
        assert_eq!(
            i.operands[1],
            memory(Some(gpr(RDI, 8)), Some(gpr(RAX, 8)), 1, -64)
        );
        assert_eq!(
            Instruction::new("andq $-0x40, %rsp".to_string()).operands[0],
            Operand::Immediate(-64)
        );
    }

    #[test]
    fn decodes_perlasm_byte_encodings() {
        assert_eq!(decode_encoded(&[0xf3, 0xc3]).as_deref(), Some("ret"));
        assert_eq!(
            decode_encoded(&[243, 15, 30, 250]).as_deref(),
            Some("endbr64")
        );
        assert_eq!(
            decode_encoded(&[102, 72, 15, 126, 199]).as_deref(),
            Some("movq %xmm0,%rdi")
        );
        assert_eq!(
            decode_encoded(&[102, 72, 15, 110, 199]).as_deref(),
            Some("movq %rdi,%xmm0")
        );
        assert_eq!(
            decode_encoded(&[72, 15, 199, 242]).as_deref(),
            Some("rdrand %rdx")
        );
        assert_eq!(
            decode_encoded(&[102, 15, 58, 68, 194, 0]).as_deref(),
            Some("bums.vector_op %xmm2,%xmm0")
        );
        assert_eq!(
            decode_encoded(&[0x0f, 0x38, 0xf1, 0x44, 0x24, 12]).as_deref(),
            Some("movbe %eax,12(%rsp)")
        );
        assert_eq!(
            decode_encoded(&[0xc4, 0xe2, 0xfb, 0xf6, 0x5e, 8]).as_deref(),
            Some("mulx 8(%rsi),%rax,%rbx")
        );
        assert_eq!(
            decode_encoded(&[0x0f, 0x1f, 0x40, 0x00]).as_deref(),
            Some("nop")
        );
        assert_eq!(decode_encoded(&[71, 72, 65, 83, 72]), None);
        assert_eq!(decode_encoded(&[0x66, 0x0f, 0x7f, 0x07]), None);
        assert_eq!(decode_encoded(&[0x66, 0x0f, 0xf7, 0xc1]), None);
        assert_eq!(decode_encoded(&[0x66, 0x0f, 0x3a, 0x16, 0xc0, 1]), None);
        assert_eq!(decode_encoded(&[0x66, 0x0f, 0x38, 0x17, 0xc1]), None);
    }
}
