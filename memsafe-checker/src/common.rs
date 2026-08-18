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

    // The register as a single expression, for operators that do not distribute over base+offset.
    pub fn expression(&self) -> AbstractExpression {
        match (&self.base, self.offset) {
            (Some(base), 0) => base.clone(),
            (Some(base), offset) => {
                generate_expression("+", base.clone(), AbstractExpression::Immediate(offset))
            }
            (None, offset) => AbstractExpression::Immediate(offset),
        }
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

impl Default for SimdRegister {
    fn default() -> Self {
        Self::new("")
    }
}

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

pub fn abstract_of(name: impl Into<String>) -> AbstractExpression {
    AbstractExpression::Abstract(name.into())
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

// How tightly an operator binds, so printing can drop the parentheses it implies.
fn binding_power(op: &str) -> u8 {
    match op {
        "|" => 1,
        "^" => 2,
        "&" => 3,
        "<<" | ">>" | "lsl" | "lsr" | "asr" => 4,
        "+" | "-" => 5,
        _ => 6,
    }
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
            // Adding a negative immediate reads as a subtraction.
            AbstractExpression::Expression(op, left, right)
                if op == "+" && matches!(**right, AbstractExpression::Immediate(n) if n < 0) =>
            {
                let AbstractExpression::Immediate(n) = **right else {
                    unreachable!()
                };
                write!(f, "{} - {}", Parenthesized(left, 5, false), -n)
            }
            AbstractExpression::Expression(op, left, right) => {
                let outer = binding_power(op);
                // The right operand of a non-associative operator still needs them.
                let tight = matches!(op.as_str(), "-" | "/" | "%" | "<<" | ">>");
                write!(f, "{}", Parenthesized(left, outer, false))?;
                write!(f, " {} ", op)?;
                write!(f, "{}", Parenthesized(right, outer, tight))
            }
        }
    }
}

// An operand, wrapped in parentheses only where its own operator binds too loosely.
struct Parenthesized<'a>(&'a AbstractExpression, u8, bool);

impl fmt::Display for Parenthesized<'_> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let Parenthesized(inner, outer, tight) = self;
        match inner {
            AbstractExpression::Expression(op, _, _)
                if binding_power(op) < *outer || (*tight && binding_power(op) == *outer) =>
            {
                write!(f, "({})", inner)
            }
            _ => write!(f, "{}", inner),
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

// A w register holds the low 32 bits of x, zero extended when written. Modulo
// expresses that directly, and unlike a cast it also applies to a symbolic base.
pub fn narrow_to_32(
    base: Option<AbstractExpression>,
    offset: i64,
) -> (Option<AbstractExpression>, i64) {
    const MODULUS: i64 = 1 << 32;
    match base {
        None => (None, offset.rem_euclid(MODULUS)),
        // The value is base + offset, so the sum is what narrows.
        Some(b) => {
            let whole = if offset == 0 {
                b
            } else {
                generate_expression("+", b, AbstractExpression::Immediate(offset))
            };
            let narrowed = generate_expression("%", whole, AbstractExpression::Immediate(MODULUS));
            (Some(narrowed), 0)
        }
    }
}

// Bytes touched by one access, from the opcode suffix and the register form.
pub fn access_width(opcode: &str, register: &instruction_parser::Operand) -> i64 {
    if opcode.ends_with('b') {
        return 1;
    }
    if opcode.ends_with('h') {
        return 2;
    }
    match register {
        instruction_parser::Operand::Register(instruction_parser::RePrefix::W, _) => 4,
        instruction_parser::Operand::VectorRegister(..)
        | instruction_parser::Operand::Vector(..)
        | instruction_parser::Operand::VectorAccess(..) => 16,
        _ => 8,
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct MemoryAccess {
    pub kind: RegionType,
    // Symbolic so an access inside a summarized loop stays parametric in its counter.
    pub base: AbstractExpression,
    pub offset: i64,
}

impl fmt::Display for MemoryAccess {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{:?}, {}, {:?}", self.kind, self.base, self.offset)
    }
}

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
            RegionType::READ => write!(f, "read"),
            RegionType::WRITE => write!(f, "write"),
            RegionType::RW => write!(f, "read/write"),
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
    // `length` is in bytes; content is sparse, since get() defaults for absent addresses.
    pub fn new(length: AbstractExpression, kind: RegionType) -> Self {
        Self {
            kind,
            length,
            content: HashMap::new(),
        }
    }
    pub fn insert(&mut self, address: i64, value: RegisterValue) {
        self.content.insert(address, value);
    }

    // Static data is laid out by writing into it, so the extent grows to match.
    pub fn grow_to(&mut self, end: i64) {
        if let AbstractExpression::Immediate(l) = self.length
            && l < end
        {
            self.length = AbstractExpression::Immediate(end);
        }
    }

    pub fn get(&self, address: i64) -> Option<RegisterValue> {
        let res = self.content.get(&address);
        match res {
            Some(_) => res.cloned(),
            None => Some(RegisterValue::new(RegisterKind::Number, None, 0)),
        }
    }

    pub fn get_length(&self) -> AbstractExpression {
        self.length.clone()
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

// An all-ones mask 2^k - 1 keeps the low k bits, so masking by it is a modulo by 2^k.
fn mask_modulus(expression: &AbstractExpression) -> Option<i64> {
    match expression {
        AbstractExpression::Immediate(mask) if *mask > 0 && *mask < i64::MAX => {
            (mask.wrapping_add(1) as u64)
                .is_power_of_two()
                .then_some(mask + 1)
        }
        _ => None,
    }
}

fn single_bit(expression: &AbstractExpression) -> Option<i64> {
    match expression {
        AbstractExpression::Immediate(mask) if *mask > 0 => {
            (*mask as u64).is_power_of_two().then_some(*mask)
        }
        _ => None,
    }
}

fn cleared_bit(expression: &AbstractExpression) -> Option<i64> {
    match expression {
        AbstractExpression::Immediate(mask) if *mask < 0 => {
            let bit = !*mask;
            (bit > 0 && (bit as u64).is_power_of_two()).then_some(bit)
        }
        _ => None,
    }
}

fn bit_of(value: &ast::Int, bit: i64) -> ast::Int {
    let weight = ast::Int::from_i64(bit);
    let two = ast::Int::from_i64(2);
    ast::Int::mul(&[&value.div(&weight).modulo(&two), &weight])
}

pub fn expression_to_ast(expression: AbstractExpression) -> Option<ast::Int> {
    match expression.clone() {
        AbstractExpression::Immediate(num) => Some(ast::Int::from_i64(num)),
        AbstractExpression::Abstract(a) => Some(ast::Int::new_const(a)),
        AbstractExpression::Register(reg) => {
            if let Some(base) = reg.base.clone() {
                let base = expression_to_ast(base.clone())
                    .unwrap_or_else(|| panic!("no translation for register base {base}"));
                let offset = ast::Int::from_i64(reg.offset);
                Some(ast::Int::add(&[&base, &offset]))
            } else {
                Some(ast::Int::from_i64(reg.offset))
            }
        }
        AbstractExpression::Expression(op, old1, old2) => {
            let new1 = expression_to_ast(*old1.clone())
                .unwrap_or_else(|| panic!("no translation for left operand of {op}: {old1}"));
            let new2 = expression_to_ast(*old2.clone())
                .unwrap_or_else(|| panic!("no translation for right operand of {op}: {old2}"));
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
                    let divisor = two.power(&new2).to_int();
                    Some(new1.div(&divisor))
                }
                "%" => Some(new1.modulo(&new2)),
                // A mask of all ones keeps the low bits, which is the same as a modulo.
                "&" => {
                    if let Some(modulus) = mask_modulus(&old2) {
                        Some(new1.modulo(ast::Int::from_i64(modulus)))
                    } else if let Some(modulus) = mask_modulus(&old1) {
                        Some(new2.modulo(ast::Int::from_i64(modulus)))
                    } else if let Some(bit) = single_bit(&old2) {
                        Some(bit_of(&new1, bit))
                    } else if let Some(bit) = single_bit(&old1) {
                        Some(bit_of(&new2, bit))
                    } else if let Some(bit) = cleared_bit(&old2) {
                        Some(ast::Int::sub(&[&new1, &bit_of(&new1, bit)]))
                    } else if let Some(bit) = cleared_bit(&old1) {
                        Some(ast::Int::sub(&[&new2, &bit_of(&new2, bit)]))
                    } else {
                        todo!("no translation for bitwise and in {expression}")
                    }
                }
                _ => todo!("no translation for operator {op} in {expression}"),
            }
        }
        _ => Some(ast::Int::from_i64(0)),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn mask_modulus_recognizes_all_ones() {
        assert_eq!(mask_modulus(&AbstractExpression::Immediate(1)), Some(2));
        assert_eq!(mask_modulus(&AbstractExpression::Immediate(15)), Some(16));
        assert_eq!(mask_modulus(&AbstractExpression::Immediate(6)), None);
        assert_eq!(mask_modulus(&AbstractExpression::Immediate(0)), None);
        assert_eq!(mask_modulus(&AbstractExpression::Immediate(-1)), None);
        assert_eq!(mask_modulus(&AbstractExpression::Immediate(i64::MAX)), None);
        assert_eq!(mask_modulus(&abstract_of("len")), None);
    }

    fn masked(value: i64, mask: i64) -> ast::Int {
        expression_to_ast(generate_expression(
            "&",
            AbstractExpression::Immediate(value),
            AbstractExpression::Immediate(mask),
        ))
        .expect("mask is translatable")
    }

    fn equals(left: &ast::Int, value: i64) -> bool {
        let solver = Solver::new();
        solver.check_assumptions(&[left.eq(ast::Int::from_i64(value)).not()]) == SatResult::Unsat
    }

    #[test]
    fn a_single_bit_mask_keeps_only_that_bit() {
        assert!(equals(&masked(0b1101, 8), 8));
        assert!(equals(&masked(0b0101, 8), 0));
        assert!(equals(&masked(0b1101, 4), 4));
    }

    #[test]
    fn a_negated_single_bit_mask_clears_only_that_bit() {
        assert!(equals(&masked(0b1101, !8), 0b0101));
        assert!(equals(&masked(0b0101, !8), 0b0101));
        assert!(equals(&masked(200, -65), 200 & -65));
    }

    #[test]
    fn masked_length_is_zero_when_even() {
        let solver = Solver::new();
        let masked = expression_to_ast(generate_expression(
            "&",
            abstract_of("len"),
            AbstractExpression::Immediate(1),
        ))
        .expect("mask is translatable");
        let len = ast::Int::new_const("len");
        let two = ast::Int::from_i64(2);
        solver.assert(len.modulo(&two).eq(ast::Int::from_i64(0)));
        assert_eq!(
            solver.check_assumptions(&[masked.eq(ast::Int::from_i64(0)).not()]),
            SatResult::Unsat
        );
    }
}

pub fn comparison_to_ast(expression: AbstractComparison) -> Option<ast::Bool> {
    let (l, r) = (expression.left.clone(), expression.right.clone());
    let left = expression_to_ast(*expression.left)
        .unwrap_or_else(|| panic!("no translation for left side of comparison: {l}"));
    let right = expression_to_ast(*expression.right)
        .unwrap_or_else(|| panic!("no translation for right side of comparison: {r}"));
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
