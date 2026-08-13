use std::collections::HashMap;
use std::fmt;
use z3::*;

use crate::instruction_parser::{self, Arrangement};

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

    pub fn new_imm(num: i64) -> Self {
        Self {
            kind: RegisterKind::Immediate,
            base: None,
            offset: num,
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
        (self.base[index].clone(), self.offset[index])
    }
    pub fn get_halfword(&self, index: usize) -> ([Option<AbstractExpression>; 2], [u8; 2]) {
        assert!(index <= 8);
        let index = index * 2;
        let base: [Option<AbstractExpression>; 2] =
            [self.base[index].clone(), self.base[index + 1].clone()];
        let offset: [u8; 2] = [self.offset[index], self.offset[index + 1]];
        (base, offset)
    }

    pub fn get_word(&self, index: usize) -> ([Option<AbstractExpression>; 4], [u8; 4]) {
        assert!(index <= 4);
        let index = index * 4;
        let mut base: [Option<AbstractExpression>; 4] = Default::default();
        base.clone_from_slice(&self.base[index..(index + 4)]);
        let mut offset: [u8; 4] = Default::default();
        offset.clone_from_slice(&self.offset[index..(index + 4)]);
        (base, offset)
    }

    pub fn get_double(&self, index: usize) -> ([Option<AbstractExpression>; 8], [u8; 8]) {
        assert!(index <= 1);
        let index = index * 8;
        let mut base: [Option<AbstractExpression>; 8] = Default::default();
        base.clone_from_slice(&self.base[index..(index + 8)]);
        let mut offset: [u8; 8] = Default::default();
        offset.clone_from_slice(&self.offset[index..(index + 8)]);
        (base, offset)
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
        self.base[index..index + 2].clone_from_slice(&base);
        self.offset[index..index + 2].copy_from_slice(&offset);
    }

    pub fn set_word(
        &mut self,
        index: usize,
        base: [Option<AbstractExpression>; 4],
        offset: [u8; 4],
    ) {
        assert!(index < 4);
        let index = index * 4;
        self.base[index..index + 4].clone_from_slice(&base);
        self.offset[index..index + 4].copy_from_slice(&offset);
    }

    pub fn set_double(
        &mut self,
        index: usize,
        base: [Option<AbstractExpression>; 8],
        offset: [u8; 8],
    ) {
        assert!(index < 2);
        let index = index * 8;
        self.base[index..index + 8].clone_from_slice(&base);
        self.offset[index..index + 8].copy_from_slice(&offset);
    }

    pub fn set_from_register(
        &mut self,
        arrangement: Arrangement,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: u128,
    ) {
        self.kind = kind;
        match arrangement {
            Arrangement::B16 | Arrangement::B8 => {
                // FIX
                if let Some(b) = base {
                    for i in 0..15 {
                        self.base[i] = Some(AbstractExpression::Expression(
                            "&".to_string(),
                            Box::new(AbstractExpression::Abstract(format!(
                                "{:?}{}",
                                arrangement, i
                            ))),
                            Box::new(b.clone()),
                        ));
                    }
                } else {
                    self.base = [BASE_INIT; 16];
                }
                self.offset = [offset as u8; 16];
            }
            Arrangement::H8 => {
                let offset = offset as u16;
                let new_bases = [BASE_INIT; 2];
                for i in 0..8 {
                    self.set_halfword(i, new_bases.clone(), offset.to_be_bytes());
                }
            }
            Arrangement::S4 => {
                let offset = offset as u32;
                let new_bases = [BASE_INIT; 4];
                for i in 0..4 {
                    self.set_word(i, new_bases.clone(), offset.to_be_bytes());
                }
            }
            Arrangement::D2 => {
                let offset = offset as u64;
                let new_bases = [BASE_INIT; 8];
                for i in 0..2 {
                    self.set_double(i, new_bases.clone(), offset.to_be_bytes());
                }
            }
            Arrangement::S => {
                let offset = offset as u32;
                let new_bases = [BASE_INIT; 4];
                // FIX to take in index
                self.set_word(0, new_bases.clone(), offset.to_be_bytes());
            }
            Arrangement::D => {
                let offset = offset as u64;
                let new_bases = [BASE_INIT; 8];
                // FIX to take in index
                self.set_double(0, new_bases.clone(), offset.to_be_bytes());
            }
            a => todo!("support setting from register across {:?} channels", a),
        }
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

        RegisterValue {
            kind: self.kind.clone(),
            base,
            offset,
        }
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
        Some(generate_expression(
            op,
            a.clone().unwrap_or(AbstractExpression::Immediate(0)),
            b.clone().unwrap_or(AbstractExpression::Immediate(0)),
        ))
    } else {
        None
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
            AbstractExpression::Abstract(value) => value.contains(token),
            AbstractExpression::Register(reg) => match &reg.base {
                Some(e) => e.contains(token),
                None => false,
            },
            AbstractExpression::Expression(_, arg1, arg2) => {
                arg1.contains(token) || arg2.contains(token)
            }
            _ => false,
        }
    }

    pub fn contains_expression(&self, expr: &AbstractExpression) -> bool {
        if self == expr {
            return true;
        }
        match self {
            AbstractExpression::Expression(_, arg1, arg2) => {
                arg1.contains_expression(expr) || arg2.contains_expression(expr)
            }
            _ => false,
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
            "<" => Self::new(">=", left, right),
            ">" => Self::new("<=", left, right),
            ">=" => Self::new("<", left, right),
            "<=" => Self::new(">", left, right),
            "==" => Self::new("!=", left, right),
            "!=" => Self::new("==", left, right),
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
        self.left.contains(token) || self.right.contains(token)
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
            Self::Abstract(a) => a.clone(),
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
            Self::Abstract(a) => Self::Abstract(a.clone().not()),
            Self::Real(r) => Self::Real(!r),
        }
    }
}

impl PartialEq for FlagValue {
    fn eq(&self, other: &Self) -> bool {
        match (self, other) {
            (FlagValue::Abstract(a), FlagValue::Abstract(b)) => a == b,
            (FlagValue::Real(a), FlagValue::Real(b)) => a == b,
            _ => false,
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
        if let AbstractExpression::Immediate(l) = length {
            for i in 0..(l) {
                content.insert(i * 4, RegisterValue::new(RegisterKind::Number, None, 0));
            }
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
        match res {
            Some(_) => res.cloned(),
            None => Some(RegisterValue::new(RegisterKind::Number, None, 0)),
        }
    }

    pub fn get_length(&self) -> AbstractExpression {
        match self.length {
            AbstractExpression::Immediate(_) => {
                AbstractExpression::Immediate((self.content.len() * 8) as i64)
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
}
impl fmt::Display for MemorySafetyError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.details)
    }
}

pub fn get_register_name_string(r: String) -> String {
    r.split(",")
        .next()
        .unwrap_or(&r)
        .trim_matches('[')
        .to_string()
}

pub fn expression_to_ast(expression: AbstractExpression) -> Option<ast::Int> {
    match expression.clone() {
        AbstractExpression::Immediate(num) => Some(ast::Int::from_i64(num)),
        AbstractExpression::Abstract(a) => Some(ast::Int::new_const(a)),
        AbstractExpression::Register(reg) => {
            if let Some(base) = reg.base.clone() {
                let base = expression_to_ast(base).expect("common7");
                let offset = ast::Int::from_i64(reg.offset);
                Some(ast::Int::add(&[&base, &offset]))
            } else {
                Some(ast::Int::from_i64(reg.offset))
            }
        }
        AbstractExpression::Expression(op, old1, old2) => {
            let new1 = expression_to_ast(*old1).expect("common8");
            let new2 = expression_to_ast(*old2).expect("common8");
            match op.as_str() {
                "+" => Some(ast::Int::add(&[&new1, &new2])),
                "-" => Some(ast::Int::sub(&[&new1, &new2])),
                "*" => Some(ast::Int::mul(&[&new1, &new2])),
                "/" => Some(new1.div(&new2)),
                "lsl" => {
                    let two = ast::Int::from_i64(2);
                    let multiplier = two.power(&new2).to_int();
                    Some(ast::Int::mul(&[&new1, &multiplier]))
                }
                ">>" | "lsr" => {
                    let two = ast::Int::from_i64(2);
                    let divisor = new2.div(&two);
                    Some(new1.div(&divisor))
                }
                "%" => Some(new1.modulo(&new2)),
                _ => {
                    todo!("expression to AST {:?} {:?}", op, expression)
                }
            }
        }
        _ => Some(ast::Int::from_i64(0)),
    }
}

pub fn comparison_to_ast(expression: AbstractComparison) -> Option<ast::Bool> {
    let left = expression_to_ast(*expression.left).expect("common10");
    let right = expression_to_ast(*expression.right).expect("common11");
    match expression.op.as_str() {
        "<" => Some(left.lt(&right)),
        ">" => Some(left.gt(&right)),
        ">=" => Some(left.ge(&right)),
        "<=" => Some(left.le(&right)),
        "==" => Some(ast::Bool::and(&[&left.le(&right), &left.ge(&right)])),
        "!=" => Some(ast::Bool::or(&[&left.lt(&right), &left.gt(&right)])),
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
    Select(
        AbstractComparison,
        instruction_parser::Operand,
        RegisterValue,
        RegisterValue,
    ),
}
