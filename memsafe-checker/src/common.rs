use std::fmt;
use std::str::FromStr;
use z3::*;

// TODO: find a way to make solving easier? less verbose
// static OPERATIONS : [(&str, &str); 3] = [("+", "-"), ("-", "+"), ("<", ">")];

#[derive(Debug, Clone, PartialEq)]
pub enum RegisterKind {
    RegisterBase, // register name / expression + offset
    Number,       // abstract number (from input for example)
    Abstract,     // abstract name / asbtract expression + offset
    Immediate,    // known number
    Address,      // known number we can jump to!
}

#[derive(Debug, Clone, PartialEq)]
pub struct RegisterValue {
    pub name: String,
    pub kind: RegisterKind,
    pub base: Option<AbstractExpression>,
    pub offset: i64,
}

impl RegisterValue {
    pub fn new(name: &str) -> Self {
        let string_name = name.to_string();
        if name == "sp" || name == "x29" {
            return RegisterValue {
                name: string_name,
                kind: RegisterKind::Address,
                base: Some(AbstractExpression::Abstract("sp".to_string())),
                offset: 0,
            };
        } else if name == "x30" {
            return Self {
                name: string_name,
                kind: RegisterKind::Address,
                base: Some(AbstractExpression::Abstract("Return".to_string())),
                offset: 0,
            };
        } else if name == "xzr" {
            return RegisterValue {
                name: string_name,
                kind: RegisterKind::Immediate,
                base: None,
                offset: 0,
            };
        }
        Self {
            name: string_name.clone(),
            kind: RegisterKind::RegisterBase,
            base: Some(AbstractExpression::Abstract(string_name.to_string())),
            offset: 0,
        }
    }

    pub fn set(
        &mut self,
        name: String,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        self.name = name;
        self.kind = kind;
        self.base = base;
        self.offset = offset;
    }
}

// TODO: add way to mark endianess if necessary
#[derive(Debug, Clone, PartialEq)]
pub struct SimdRegister {
    pub name: String,
    pub kind: RegisterKind,
    pub base: [Option<AbstractExpression>; 16],
    pub offset: [u8; 16],
}

const ARRAY_REPEAT_VALUE: Option<AbstractExpression> = None;

impl SimdRegister {
    pub fn new(name: &str) -> Self {
        let string_name = name.to_string();
        let mut bases = [ARRAY_REPEAT_VALUE; 16];
        for i in 0..1 {
            bases[i] = Some(AbstractExpression::Abstract(
                string_name.to_string() + &i.to_string(),
            ));
        }
        Self {
            name: string_name.clone(),
            kind: RegisterKind::RegisterBase,
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
    pub fn get_halfword(&self, index: usize) -> (Option<AbstractExpression>, u16) {
        assert!(index <= 8);
        let index = index * 2;
        let half_base = generate_expression(
            "bytes to halfword",
            self.base[index + 1].clone().unwrap(),
            self.base[index].clone().unwrap(),
        );
        let half_index = ((self.offset[index + 1] as u16) << 8) | self.offset[index] as u16;
        return (Some(half_base), half_index);
    }
    pub fn set_byte(&mut self, index: usize, base: Option<AbstractExpression>, offset: u8) {
        assert!(index < 16);
        self.base[index] = base;
        self.offset[index] = offset;
    }
    pub fn set_halfword(&mut self, index: usize, base: Option<AbstractExpression>, offset: u16) {
        assert!(index < 8);
        let index = index * 2;
        self.base[index + 1] = Some(generate_expression(
            "&",
            base.clone().unwrap(),
            AbstractExpression::Immediate(0b11111111),
        ));
        self.base[index] = Some(generate_expression(
            "&",
            base.unwrap(),
            AbstractExpression::Immediate(0b1111111100000000),
        ));
        self.offset[index] = (offset << 8) as u8;
        self.offset[index + 1] = offset as u8;
    }

    pub fn set(
        &mut self,
        name: String,
        kind: RegisterKind,
        base: [Option<AbstractExpression>; 16],
        offset: [u8; 16],
    ) {
        self.name = name;
        self.kind = kind;
        self.base = base;
        self.offset = offset;
    }
}

pub fn generate_expression(
    op: &str,
    a: AbstractExpression,
    b: AbstractExpression,
) -> AbstractExpression {
    AbstractExpression::Expression(op.to_string(), Box::new(a), Box::new(b))
}

// is there a better way to do this?
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
    pub fn get_register_names(&self) -> Vec<String> {
        let mut registers = Vec::new();
        match self {
            AbstractExpression::Register(reg) => {
                registers.push(reg.name.clone());
            }
            AbstractExpression::Expression(_, arg1, arg2) => {
                registers.append(&mut arg1.get_register_names());
                registers.append(&mut arg2.get_register_names());
            }
            _ => (),
        }

        registers
    }

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
            _ => (),
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

    pub fn get_register_names(&self) -> Vec<String> {
        let mut registers = Vec::new();
        registers.append(&mut self.left.get_register_names());
        registers.append(&mut self.right.get_register_names());
        registers
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
    ABSTRACT(AbstractComparison),
    REAL(bool),
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
    pub region_type: RegionType,
    pub base: String,
    pub start: AbstractExpression,
    pub end: AbstractExpression,
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
}

impl Instruction {
    pub fn new(text: String) -> Instruction {
        Instruction {
            op: text,
            r1: None,
            r2: None,
            r3: None,
            r4: None,
        }
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
                brac = s[left.unwrap()..right.unwrap()].to_string();
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

        if v.len() > 1 {
            let val1 = v[1].to_string();
            if val1.contains("[") {
                v1 = Some(brac.clone());
            } else if val1.contains("]") {
                v1 = None;
            } else {
                v1 = Some(val1);
            }
        } else {
            v1 = None;
        }
        if v.len() > 2 {
            let val2 = v[2].to_string();
            if val2.contains("[") {
                v2 = Some(brac.clone());
            } else if val2.contains("]") {
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
                v4 = Some(brac);
            } else if val4.contains("]") {
                v4 = None;
            } else {
                v4 = Some(val4);
            }
        } else {
            v4 = None;
        }

        Ok(Instruction {
            op: v0,
            r1: v1,
            r2: v2,
            r3: v3,
            r4: v4,
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
    let v = s.trim_matches('#');
    if v.contains('*') {
        let parts = v.split('*');
        for part in parts {
            let m = part.parse::<i64>().unwrap();
            value = value * m;
        }
    } else if v.contains("x") {
        value = i64::from_str_radix(v.strip_prefix("0x").unwrap(), 16).unwrap();
    } else {
        value = v.parse::<i64>().unwrap();
    }

    return value;
}

pub fn shift_imm(op: String, register: RegisterValue, shift: i64) -> RegisterValue {
    let new_offset = register.offset >> shift;
    RegisterValue {
        name: register.name,
        kind: register.kind,
        base: Some(generate_expression(
            &op,
            register.base.unwrap_or(AbstractExpression::Empty),
            AbstractExpression::Immediate(shift),
        )),
        offset: new_offset,
    }
}

pub fn expression_to_ast(context: &Context, expression: AbstractExpression) -> Option<ast::Int> {
    match expression {
        AbstractExpression::Immediate(num) => {
            return Some(ast::Int::from_i64(context, num));
        }
        AbstractExpression::Abstract(a) => {
            return Some(ast::Int::new_const(context, a));
        }
        AbstractExpression::Register(reg) => {
            let base = expression_to_ast(context, reg.base.clone().unwrap()).unwrap();
            let offset = ast::Int::from_i64(context, reg.offset);
            return Some(ast::Int::add(context, &[&base, &offset]));
        }
        AbstractExpression::Expression(op, old1, old2) => {
            let new1 = expression_to_ast(context, *old1).unwrap();
            let new2 = expression_to_ast(context, *old2).unwrap();
            match op.as_str() {
                "+" => return Some(ast::Int::add(context, &[&new1, &new2])),
                "-" => return Some(ast::Int::sub(context, &[&new1, &new2])),
                "*" => return Some(ast::Int::mul(context, &[&new1, &new2])),
                "/" => return Some(new1.div(&new2)),
                "lsl" => {
                    let two = ast::Int::from_i64(context, 2);
                    let multiplier = new2.power(&two).to_int();
                    return Some(ast::Int::mul(context, &[&new1, &multiplier]));
                }
                ">>" | "lsr" => {
                    let two = ast::Int::from_i64(context, 2);
                    let divisor = new2.div(&two);
                    return Some(new1.div(&divisor));
                }
                _ => {
                    return None;
                }
            }
        }
        _ => return Some(ast::Int::from_i64(context, 0)),
    }
}

pub fn comparison_to_ast(context: &Context, expression: AbstractComparison) -> Option<ast::Bool> {
    let left = expression_to_ast(context, *expression.left).unwrap();
    let right = expression_to_ast(context, *expression.right).unwrap();
    match expression.op.as_str() {
        "<" => {
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
        _ => todo!(),
    }
}
