use std::collections::HashMap;
use std::fmt;
use std::str::FromStr;
use z3::*;

#[derive(Debug, Clone, PartialEq)]
pub enum RegisterKind {
    RegisterBase, // abstract name / asbtract expression + immediate offset
    Number,       // abstract number (from input for example), do not know this number
    Immediate,    // immediate number
}

#[derive(Debug, Clone, PartialEq)]
pub struct RegisterValue {
    pub kind: RegisterKind,
    pub base: Option<AbstractExpression>,
    pub offset: i64,
}

impl RegisterValue {
    pub fn new(kind: RegisterKind, base: Option<AbstractExpression>, offset: i64) -> Self {
        Self { kind, base, offset }
    }

    pub fn new_empty(name: &str) -> Self {
        Self {
            kind: RegisterKind::RegisterBase,
            base: Some(AbstractExpression::Abstract(name.to_string())),
            offset: 0,
        }
    }

    pub fn set(&mut self, kind: RegisterKind, base: Option<AbstractExpression>, offset: i64) {
        self.kind = kind;
        self.base = base;
        self.offset = offset;
    }
}

// TODO: add way to mark endianess if necessary
#[derive(Debug, Clone, PartialEq)]
pub struct SimdRegister {
    pub kind: RegisterKind,
    pub base: [Option<AbstractExpression>; 16],
    pub offset: [u8; 16],
}

pub const BASE_INIT: Option<AbstractExpression> = None;

impl SimdRegister {
    pub fn new(_name: &str) -> Self {
        // let string_name = name.to_string();
        let bases = [BASE_INIT; 16];
        // for i in 0..16 {
        //     bases[i] = Some(AbstractExpression::Abstract(
        //         string_name.clone() + "_" + &i.to_string(),
        //     ));
        // }
        Self {
            kind: RegisterKind::Number,
            base: bases,
            offset: [0; 16],
        }
    }

    //https://developer.arm.com/documentation/102474/0100/Fundamentals-of-Armv8-Neon-technology/Registers--vectors--lanes-and-elements
    // TODO: unclear whether we need to use these getters and setters in this way when actually doing SIMD,
    // to be fixed once implement interpreter and instructions,
    // at least useful for setting/getting scalars from vectors if necessary
    // i.e. V3.S[2]  -> get_word(2)
    pub fn get_byte(&self, index: usize) -> (Option<AbstractExpression>, u8) {
        assert!(index < 16);
        return (self.base[index].clone(), self.offset[index]);
    }
    pub fn get_halfword(&self, index: usize) -> ([Option<AbstractExpression>; 2], [u8; 2]) {
        assert!(index <= 8);
        let index = index * 2;
        let base: [Option<AbstractExpression>; 2] =
            [self.base[index].clone(), self.base[index + 1].clone()];
        let offset: [u8; 2] = [self.offset[index], self.offset[index + 1]];
        return (base, offset);
    }

    pub fn get_word(&self, index: usize) -> ([Option<AbstractExpression>; 4], [u8; 4]) {
        assert!(index <= 4);
        let index = index * 4;
        let mut base: [Option<AbstractExpression>; 4] = Default::default();
        base.clone_from_slice(&self.base[index..(index + 4)]);
        let mut offset: [u8; 4] = Default::default();
        offset.clone_from_slice(&self.offset[index..(index + 4)]);
        return (base, offset);
    }

    pub fn get_double(&self, index: usize) -> ([Option<AbstractExpression>; 8], [u8; 8]) {
        assert!(index <= 1);
        let index = index * 8;
        let mut base: [Option<AbstractExpression>; 8] = Default::default();
        base.clone_from_slice(&self.base[index..(index + 8)]);
        let mut offset: [u8; 8] = Default::default();
        offset.clone_from_slice(&self.offset[index..(index + 8)]);
        return (base, offset);
    }

    pub fn set_byte(&mut self, index: usize, base: Option<AbstractExpression>, offset: u8) {
        assert!(index < 16);
        self.base[index] = base;
        self.offset[index] = offset;
    }
    pub fn set_halfword(
        &mut self,
        index: usize,
        base: [Option<AbstractExpression>; 2],
        offset: [u8; 2],
    ) {
        assert!(index <= 8);
        let index = index * 2;
        for i in 0..2 {
            self.base[index + i] = base[i].clone();
            self.offset[index + i] = offset[i];
        }
    }

    pub fn set_word(
        &mut self,
        index: usize,
        base: [Option<AbstractExpression>; 4],
        offset: [u8; 4],
    ) {
        assert!(index < 4);
        let index = index * 4;
        for i in 0..4 {
            self.base[index + i] = base[i].clone();
            self.offset[index + i] = offset[i];
        }
    }

    pub fn set_double(
        &mut self,
        index: usize,
        base: [Option<AbstractExpression>; 8],
        offset: [u8; 8],
    ) {
        assert!(index < 2);
        let index = index * 8;
        for i in 0..8 {
            self.base[index + i] = base[i].clone();
            self.offset[index + i] = offset[i];
        }
    }

    pub fn set(
        &mut self,
        _arrangement: String,
        kind: RegisterKind,
        base: [Option<AbstractExpression>; 16],
        offset: [u8; 16],
    ) {
        self.kind = kind;
        self.base = base;
        self.offset = offset;
    }

    pub fn set_register(
        &mut self,
        arrangement: String,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: u128,
    ) {
        self.kind = kind;
        if let Some(b) = base {
            for i in 0..15 {
                self.base[i] = Some(AbstractExpression::Expression(
                    "&".to_string(),
                    Box::new(AbstractExpression::Abstract(format!(
                        "{}{}",
                        arrangement, i
                    ))),
                    Box::new(b.clone()),
                ));
            }
        } else {
            self.base = [BASE_INIT; 16];
        }

        self.offset = offset.to_be_bytes();
    }

    pub fn get_as_register(&self) -> RegisterValue {
        let mut offset_buf: [u8; 8] = Default::default();
        offset_buf.clone_from_slice(&self.offset[0..8]);
        let offset: i64 = i64::from_be_bytes(offset_buf);

        let base = generate_expression_from_options(
            ",",
            generate_expression_from_options(
                ",",
                generate_expression_from_options(
                    ",",
                    generate_expression_from_options(
                        ",",
                        self.base[0].clone(),
                        self.base[1].clone(),
                    ),
                    generate_expression_from_options(
                        ",",
                        self.base[2].clone(),
                        self.base[3].clone(),
                    ),
                ),
                generate_expression_from_options(
                    ",",
                    generate_expression_from_options(
                        ",",
                        self.base[4].clone(),
                        self.base[5].clone(),
                    ),
                    generate_expression_from_options(
                        ",",
                        self.base[6].clone(),
                        self.base[7].clone(),
                    ),
                ),
            ),
            generate_expression_from_options(
                ",",
                generate_expression_from_options(
                    ",",
                    generate_expression_from_options(
                        ",",
                        self.base[8].clone(),
                        self.base[9].clone(),
                    ),
                    generate_expression_from_options(
                        ",",
                        self.base[10].clone(),
                        self.base[11].clone(),
                    ),
                ),
                generate_expression_from_options(
                    ",",
                    generate_expression_from_options(
                        ",",
                        self.base[12].clone(),
                        self.base[13].clone(),
                    ),
                    generate_expression_from_options(
                        ",",
                        self.base[14].clone(),
                        self.base[15].clone(),
                    ),
                ),
            ),
        );

        return RegisterValue {
            kind: self.kind.clone(),
            base,
            offset,
        };
    }
}

pub fn generate_expression(
    op: &str,
    a: AbstractExpression,
    b: AbstractExpression,
) -> AbstractExpression {
    AbstractExpression::Expression(op.to_string(), Box::new(a), Box::new(b))
}

pub fn generate_expression_from_options(
    op: &str,
    a: Option<AbstractExpression>,
    b: Option<AbstractExpression>,
) -> Option<AbstractExpression> {
    if a.is_some() || b.is_some() {
        return Some(generate_expression(
            op,
            a.clone().unwrap_or(AbstractExpression::Immediate(0)),
            b.clone().unwrap_or(AbstractExpression::Immediate(0)),
        ));
    } else {
        return None;
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum AbstractExpression {
    Empty,
    Immediate(i64),
    Abstract(String),
    Register(Box<RegisterValue>), // only use to box in expressions for compares
    Expression(String, Box<AbstractExpression>, Box<AbstractExpression>),
}

impl fmt::Display for AbstractExpression {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            AbstractExpression::Empty => write!(f, "Empty"),
            AbstractExpression::Immediate(value) => write!(f, "{}", value),
            AbstractExpression::Abstract(name) => write!(f, "{}", name),
            AbstractExpression::Register(reg) => {
                write!(f, "({:?})", reg)
            }
            AbstractExpression::Expression(func, arg1, arg2) => {
                write!(f, "({} {} {})", arg1, func, arg2)
            }
        }
    }
}

impl fmt::Display for AbstractComparison {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "({} {} {})", self.op, self.left, self.right)
    }
}

impl AbstractExpression {
    pub fn get_abstracts(&self) -> Vec<String> {
        let mut abstracts = Vec::new();
        match self {
            AbstractExpression::Abstract(value) => {
                abstracts.push(value.to_string());
            }
            AbstractExpression::Register(reg) => {
                abstracts.append(
                    &mut reg
                        .base
                        .clone()
                        .unwrap_or(AbstractExpression::Empty)
                        .get_abstracts(),
                );
            }
            AbstractExpression::Expression(_, arg1, arg2) => {
                abstracts.append(&mut arg1.get_abstracts());
                abstracts.append(&mut arg2.get_abstracts());
            }
            AbstractExpression::Empty | AbstractExpression::Immediate(_) => (),
        }
        abstracts
    }

    pub fn contains(&self, token: &str) -> bool {
        match self {
            AbstractExpression::Abstract(value) => {
                if value.contains(token) {
                    return true;
                } else {
                    return false;
                }
            }
            AbstractExpression::Register(reg) => match &reg.base {
                Some(e) => return e.contains(token),
                None => return false,
            },
            AbstractExpression::Expression(_, arg1, arg2) => {
                return arg1.contains(token) || arg2.contains(token);
            }
            _ => return false,
        }
    }

    pub fn contains_expression(&self, expr: &AbstractExpression) -> bool {
        if self == expr {
            return true;
        }
        match self {
            AbstractExpression::Expression(_, arg1, arg2) => {
                return arg1.contains_expression(expr) || arg2.contains_expression(expr);
            }
            _ => return false,
        }
    }
}

pub fn generate_comparison(
    op: &str,
    a: AbstractExpression,
    b: AbstractExpression,
) -> AbstractComparison {
    AbstractComparison {
        op: op.to_string(),
        left: Box::new(a),
        right: Box::new(b),
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct AbstractComparison {
    pub op: String,
    pub left: Box<AbstractExpression>,
    pub right: Box<AbstractExpression>,
}

impl AbstractComparison {
    pub fn new(op: &str, left: AbstractExpression, right: AbstractExpression) -> Self {
        Self {
            op: op.to_string(),
            left: Box::new(left),
            right: Box::new(right),
        }
    }

    pub fn not(&self) -> Self {
        let left = *self.left.clone();
        let right = *self.right.clone();
        match self.op.as_str() {
            "<" => {
                return Self::new(">=", left, right);
            }
            ">" => {
                return Self::new("<=", left, right);
            }
            ">=" => {
                return Self::new("<", left, right);
            }
            "<=" => {
                return Self::new(">", left, right);
            }
            "==" => {
                return Self::new("!=", left, right);
            }
            "!=" => {
                return Self::new("==", left, right);
            }
            _ => todo!("unsupported op {:?}", self.op),
        }
    }

    pub fn reduce_solution(&self) -> (AbstractExpression, AbstractExpression) {
        todo!()
    }

    pub fn get_abstracts(&self) -> Vec<String> {
        let mut abstracts = Vec::new();
        abstracts.append(&mut self.left.get_abstracts());
        abstracts.append(&mut self.right.get_abstracts());
        abstracts
    }

    pub fn contains(&self, token: &str) -> bool {
        return self.left.contains(token) || self.right.contains(token);
    }
}

#[derive(Debug, Clone)]
pub struct MemoryAccess {
    pub kind: RegionType,
    pub base: String,
    pub offset: i64,
}

impl fmt::Display for MemoryAccess {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{:?}, {}, {:?}", self.kind, self.base, self.offset)
    }
}

impl PartialEq for MemoryAccess {
    fn eq(&self, other: &Self) -> bool {
        self.kind == other.kind && self.base == other.base && self.offset == other.offset
    }
}

impl Eq for MemoryAccess {}

#[derive(Debug, Clone)]
pub enum FlagValue {
    Abstract(AbstractComparison),
    Real(bool),
}

impl FlagValue {
    pub fn to_abstract_expression(&self) -> AbstractComparison {
        match self {
            Self::Abstract(a) => return a.clone(),
            Self::Real(r) => match r {
                true => {
                    generate_comparison("==", AbstractExpression::Empty, AbstractExpression::Empty)
                }
                false => {
                    generate_comparison("!=", AbstractExpression::Empty, AbstractExpression::Empty)
                }
            },
        }
    }

    pub fn not(&self) -> Self {
        match self {
            Self::Abstract(a) => return Self::Abstract(a.clone().not()),
            Self::Real(r) => return Self::Real(!r),
        }
    }
}

impl PartialEq for FlagValue {
    fn eq(&self, other: &Self) -> bool {
        match (self, other) {
            (FlagValue::Abstract(a), FlagValue::Abstract(b)) => return a == b,
            (FlagValue::Real(a), FlagValue::Real(b)) => return a == b,
            _ => return false,
        }
    }
}

#[derive(Debug, Clone, Copy, Eq, PartialEq)]
pub enum RegionType {
    READ,
    WRITE,
    RW,
}

impl fmt::Display for RegionType {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            RegionType::READ => write!(f, "Read"),
            RegionType::WRITE => write!(f, "Write"),
            RegionType::RW => write!(f, "Read and Write"),
        }
    }
}

#[derive(Debug, Clone)]
pub struct MemorySafeRegion {
    pub kind: RegionType,
    length: AbstractExpression, // length of region in BYTES
    pub content: HashMap<i64, RegisterValue>,
}

impl MemorySafeRegion {
    pub fn new(length: AbstractExpression, kind: RegionType) -> Self {
        let mut content = HashMap::new();
        match length {
            AbstractExpression::Immediate(l) => {
                for i in 0..(l) {
                    content.insert(i * 4, RegisterValue::new(RegisterKind::Number, None, 0));
                }
            }
            _ => (),
        }
        Self {
            kind,
            length,
            content,
        }
    }
    pub fn insert(&mut self, address: i64, value: RegisterValue) {
        self.content.insert(address, value);
    }

    pub fn get(&self, address: i64) -> Option<RegisterValue> {
        let res = self.content.get(&address);
        match res.clone() {
            Some(_) => res.cloned(),
            None => Some(RegisterValue::new(RegisterKind::Number, None, 0)),
        }
    }

    pub fn get_length(&self) -> AbstractExpression {
        match self.length {
            AbstractExpression::Immediate(_) => {
                return AbstractExpression::Immediate((self.content.len() * 8) as i64)
            }
            _ => self.length.clone(),
        }
    }
}

#[derive(Debug, Clone)]
pub struct MemorySafetyError {
    details: String,
}

impl MemorySafetyError {
    pub fn new(msg: &str) -> MemorySafetyError {
        MemorySafetyError {
            details: msg.to_string(),
        }
    }

    pub fn to_string(&self) -> String {
        format!("{}", &self.details)
    }
}
impl fmt::Display for MemorySafetyError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.details)
    }
}

#[derive(Debug, Clone)]
pub struct Instruction {
    pub op: String,
    pub r1: Option<String>,
    pub r2: Option<String>,
    pub r3: Option<String>,
    pub r4: Option<String>,
    pub r5: Option<String>,
    pub r6: Option<String>,
}

impl Instruction {
    pub fn new(text: String) -> Instruction {
        Instruction {
            op: text,
            r1: None,
            r2: None,
            r3: None,
            r4: None,
            r5: None,
            r6: None,
        }
    }

    pub fn is_simd(&self) -> bool {
        if self.op.starts_with("b.") {
            return false;
        }
        if let Some(i) = &self.r1 {
            if i.contains("_") {
                return false;
            } else if (i.contains("v") && !i.contains("<"))
                && (self.op.contains(".") || i.contains("."))
            {
                return true;
            }
        }
        if let Some(i) = &self.r2 {
            if (i.contains("v") && !i.contains("<")) && (self.op.contains(".") || i.contains(".")) {
                return true;
            }
        }
        if let Some(i) = &self.r3 {
            if (i.contains("v") && !i.contains("<")) && (self.op.contains(".") || i.contains(".")) {
                return true;
            }
        }
        if let Some(i) = &self.r4 {
            if (i.contains("v") && !i.contains("<")) && (self.op.contains(".") || i.contains(".")) {
                return true;
            }
        }
        false
    }
}
#[derive(Debug, Clone)]
pub struct ParseInstructionError;

impl FromStr for Instruction {
    type Err = ParseInstructionError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        //find if there's anything in brackets to allow fun addressing modes
        let mut brac: String = Default::default();
        if s.contains("[") {
            let left = s.find('[');
            let right = s.rfind(']');
            let exclamation = s.rfind('!');
            if left.is_some() && right.is_some() {
                brac = s[left.expect("common1")..right.expect("common2")].to_string();
            }
            if exclamation.is_some() {
                brac = brac + "!";
            }
        }

        let parsed_v: Vec<&str> = s.split(|c| c == '\t' || c == ',' || c == ' ').collect();

        let mut v: Vec<&str> = vec![];
        for e in parsed_v {
            if e != "" {
                v.push(e);
            }
        }

        let v0 = v[0].to_string();
        let v1: Option<String>;
        let v2: Option<String>;
        let v3: Option<String>;
        let v4: Option<String>;
        let v5: Option<String>;
        let v6: Option<String>;

        if v.len() > 1 {
            let val1 = v[1].to_string();
            if val1.contains("[") && !val1.contains("v") {
                // TODO: clean up parsing so we don't have to do it like this
                v1 = Some(brac.clone());
            } else if val1.contains("]") && !val1.contains("v") {
                v1 = None;
            } else {
                v1 = Some(val1);
            }
        } else {
            v1 = None;
        }
        if v.len() > 2 {
            let val2 = v[2].to_string();
            if val2.contains("[") && !val2.contains("v") {
                v2 = Some(brac.clone());
            } else if val2.contains("]") && !val2.contains("v") {
                v2 = None;
            } else {
                v2 = Some(val2);
            }
        } else {
            v2 = None;
        }
        if v.len() > 3 && !v[3].is_empty() {
            let val3 = v[3].to_string();
            if val3.contains("[") {
                v3 = Some(brac.clone());
            } else if val3.contains("]") {
                v3 = None;
            } else {
                v3 = Some(val3);
            }
        } else {
            v3 = None;
        }
        if v.len() > 4 && !v[4].is_empty() {
            let val4 = v[4].to_string();
            if val4.contains("[") {
                v4 = Some(brac.clone());
            } else if val4.contains("]") {
                v4 = None;
            } else {
                v4 = Some(val4);
            }
        } else {
            v4 = None;
        }

        if v.len() > 5 && !v[5].is_empty() {
            let val5 = v[5].to_string();
            if val5.contains("[") {
                v5 = Some(brac.clone());
            } else if val5.contains("]") {
                v5 = None;
            } else {
                v5 = Some(val5);
            }
        } else {
            v5 = None;
        }

        if v.len() > 6 && !v[6].is_empty() {
            let val6 = v[6].to_string();
            if val6.contains("[") {
                v6 = Some(brac);
            } else if val6.contains("]") {
                v6 = None;
            } else {
                v6 = Some(val6);
            }
        } else {
            v6 = None;
        }

        Ok(Instruction {
            op: v0,
            r1: v1,
            r2: v2,
            r3: v3,
            r4: v4,
            r5: v5,
            r6: v6,
        })
    }
}

pub fn get_register_name_string(r: String) -> String {
    let a: Vec<&str> = r.split(",").collect();
    for i in a {
        let name = i.trim_matches('[').to_string();
        return name;
    }

    return r;
}

pub fn string_to_int(s: &str) -> i64 {
    let mut value = 1;
    let v = s
        .trim_matches(' ')
        .trim_matches('#')
        .trim_matches('(')
        .trim_matches(')');
    if v.contains('*') {
        let parts = v.split('*');
        for part in parts {
            let m = string_to_int(part);
            value = value * m;
        }
    } else if v.contains('+') {
        let parts = v.split('+');
        for part in parts {
            let m = string_to_int(part);
            value = value + m;
        }
    } else if v.contains("x") {
        // FIX: store as two if i128 is needed
        value = i128::from_str_radix(v.strip_prefix("0x").expect("common4"), 16).expect("common5")
            as i64;
    } else {
        let clean = &v.replace(&['(', ')', ',', '\"', '.', ';', ':', '\'', '#'][..], "");
        value = clean.parse::<i64>().expect("common6");
    }

    return value;
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
        _ => todo!("{}", op),
    }
}

pub fn expression_to_ast(context: &Context, expression: AbstractExpression) -> Option<ast::Int> {
    match expression.clone() {
        AbstractExpression::Immediate(num) => {
            return Some(ast::Int::from_i64(context, num));
        }
        AbstractExpression::Abstract(a) => {
            return Some(ast::Int::new_const(context, a));
        }
        AbstractExpression::Register(reg) => {
            if let Some(base) = reg.base.clone() {
                let base = expression_to_ast(context, base).expect("common7");
                let offset = ast::Int::from_i64(context, reg.offset);
                return Some(ast::Int::add(context, &[&base, &offset]));
            } else {
                return Some(ast::Int::from_i64(context, reg.offset));
            }
        }
        AbstractExpression::Expression(op, old1, old2) => {
            let new1 = expression_to_ast(context, *old1).expect("common8");
            let new2 = expression_to_ast(context, *old2).expect("common8");
            match op.as_str() {
                "+" => return Some(ast::Int::add(context, &[&new1, &new2])),
                "-" => return Some(ast::Int::sub(context, &[&new1, &new2])),
                "*" => return Some(ast::Int::mul(context, &[&new1, &new2])),
                "/" => return Some(new1.div(&new2)),
                "lsl" => {
                    let two = ast::Int::from_i64(context, 2);
                    let multiplier = two.power(&new2).to_int();
                    return Some(ast::Int::mul(context, &[&new1, &multiplier]));
                }
                ">>" | "lsr" => {
                    let two = ast::Int::from_i64(context, 2);
                    let divisor = new2.div(&two);
                    return Some(new1.div(&divisor));
                }
                "%" => return Some(new1.modulo(&new2)),
                _ => {
                    todo!("expression to AST {:?} {:?}", op, expression)
                }
            }
        }
        _ => return Some(ast::Int::from_i64(context, 0)),
    }
}

pub fn comparison_to_ast(context: &Context, expression: AbstractComparison) -> Option<ast::Bool> {
    let left = expression_to_ast(context, *expression.left).expect("common10");
    let right = expression_to_ast(context, *expression.right).expect("common11");
    match expression.op.as_str() {
        "<" => {
            return Some(left.lt(&right));
        }
        ">" => {
            return Some(left.gt(&right));
        }
        ">=" => {
            return Some(left.ge(&right));
        }
        "<=" => {
            return Some(left.le(&right));
        }
        "==" => {
            return Some(ast::Bool::and(
                context,
                &[&left.le(&right), &left.ge(&right)],
            ));
        }
        "!=" => {
            return Some(ast::Bool::or(
                context,
                &[&left.lt(&right), &left.gt(&right)],
            ));
        }
        _ => todo!("unsupported op {:?}", expression.op),
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum ExecuteReturnType {
    Next,
    JumpLabel(String),
    JumpAddress(u128),
    ConditionalJumpLabel(AbstractComparison, String),
    ConditionalJumpAddress(AbstractComparison, u128),
    Select(AbstractComparison, String, RegisterValue, RegisterValue),
}
