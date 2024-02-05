use std::fmt;
use std::str::FromStr;

#[derive(Debug, Clone, PartialEq)]
pub enum RegisterKind {
    RegisterBase, // register name / expression + offset
    Number,       // abstract number (from input for example)
    Abstract,     // abstract name / asbtract expression + offset
    Immediate,    // known number
    Address,      // known number we can jump to!
}

// TODO: add a field for "name" which will hold the current register location
#[derive(Debug, Clone, PartialEq)]
pub struct RegisterValue {
    pub name: String,
    pub kind: RegisterKind,
    pub base: Option<String>,
    pub offset: i64,
}

impl RegisterValue {
    pub fn new(name: &str) -> RegisterValue {
        let string_name = name.to_string();
        if name == "sp" || name == "x29" {
            return RegisterValue {
                name: string_name,
                kind: RegisterKind::Address,
                base: Some("sp".to_string()),
                offset: 0,
            };
        }
        if name == "x30" {
            return RegisterValue {
                name: string_name,
                kind: RegisterKind::Address,
                base: Some("Return".to_string()),
                offset: 0,
            };
        }
        RegisterValue {
            name: string_name.clone(),
            kind: RegisterKind::RegisterBase,
            base: Some(string_name),
            offset: 0,
        }
    }

    pub fn set(&mut self, name: String, kind: RegisterKind, base: Option<String>, offset: i64) {
        self.name = name;
        self.kind = kind;
        self.base = base;
        self.offset = offset;
    }
}

// is there a better way to do this?
#[derive(Debug, Clone, PartialEq)]
pub enum AbstractExpression {
    Immediate(i64),
    Abstract(String),
    Register(RegisterValue),
    Solution(i64, Box<AbstractExpression>),
    Expression(String, Box<AbstractExpression>, Box<AbstractExpression>),
}

impl fmt::Display for AbstractExpression {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            AbstractExpression::Immediate(value) => write!(f, "{}", value),
            AbstractExpression::Abstract(name) => write!(f, "{}", name),
            AbstractExpression::Register(reg) => {
                write!(f, "({:?})", reg)
            }
            AbstractExpression::Solution(num, expr) => {
                write!(f, "{} == {}", num, expr)
            }
            AbstractExpression::Expression(func, arg1, arg2) => {
                write!(f, "{}({}, {})", func, arg1, arg2)
            }
        }
    }
}

impl AbstractExpression {
    pub fn get_register_names(&self) -> Vec<String> {
        let mut registers = Vec::new();
        match self {
            AbstractExpression::Register(reg) => {
                registers.push(reg.name.clone());
            }
            AbstractExpression::Solution(_, expr) => {
                registers.append(&mut expr.get_register_names());
            }
            AbstractExpression::Expression(_, arg1, arg2) => {
                registers.append(&mut arg1.get_register_names());
                registers.append(&mut arg2.get_register_names());
            }
            _ => (),
        }

        registers
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
pub struct AbstractValue {
    pub name: String,
    pub min: Option<usize>,
    pub max: Option<usize>,
}

#[derive(Debug, Clone)]
pub enum ValueType {
    ABSTRACT(AbstractValue), // string will be an identifier
    REAL(usize),
}

#[derive(Debug, Clone)]
pub enum FlagValue {
    ABSTRACT(AbstractExpression),
    REAL(bool),
}

#[derive(Debug, Clone, Copy, Eq, PartialEq)]
pub enum RegionType {
    READ,
    WRITE,
}

impl fmt::Display for RegionType {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            RegionType::READ => write!(f, "Read"),
            RegionType::WRITE => write!(f, "Write"),
        }
    }
}

#[derive(Debug, Clone)]
pub struct MemorySafeRegion {
    pub region_type: RegionType,
    pub base: String,
    pub start_offset: ValueType,
    pub end_offset: ValueType,
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

        let v: Vec<&str> = s.split(|c| c == '\t' || c == ',' || c == ' ').collect();

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

pub fn generate_expression(op: &str, a: String, b: String) -> String {
    if a == String::new() {
        return b;
    }
    if b == String::new() {
        return a;
    }
    format!("({} {} {})", a, op, b)
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
            register.base.unwrap_or("".to_string()),
            shift.to_string(),
        )),
        offset: new_offset,
    }
}
