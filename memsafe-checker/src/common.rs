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
    pub base: Option<AbstractExpression>,
    pub offset: i64,
}

impl RegisterValue {
    pub fn new(name: &str) -> RegisterValue {
        let string_name = name.to_string();
        if name == "sp" || name == "x29" {
            return RegisterValue {
                name: string_name,
                kind: RegisterKind::Address,
                base: Some(AbstractExpression::Abstract("sp".to_string())),
                offset: 0,
            };
        }
        if name == "x30" {
            return RegisterValue {
                name: string_name,
                kind: RegisterKind::Address,
                base: Some(AbstractExpression::Abstract("Return".to_string())),
                offset: 0,
            };
        }
        RegisterValue {
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
    Solution(i64, Box<AbstractExpression>),
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
            AbstractExpression::Solution(num, expr) => {
                write!(f, "{} == {}", num, expr)
            }
            AbstractExpression::Expression(func, arg1, arg2) => {
                write!(f, "({} {} {})", arg1, func, arg2)
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
            AbstractExpression::Solution(_, expr) => {
                abstracts.append(&mut expr.get_abstracts());
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
            AbstractExpression::Solution(_, expr) => {
                return expr.contains(token);
            }
            AbstractExpression::Expression(_, arg1, arg2) => {
                return arg1.contains(token) || arg2.contains(token);
            }
            _ => return false,
        }
    }

    pub fn replace(&self, token: &str, value: &str) -> AbstractExpression {
        match self {
            AbstractExpression::Immediate(num) => {
                return AbstractExpression::Immediate(*num);
            }
            AbstractExpression::Abstract(_) => {
                return AbstractExpression::Abstract(value.to_string())
            }
            AbstractExpression::Register(reg) => return AbstractExpression::Register(reg.clone()),
            AbstractExpression::Solution(num, old) => {
                let new = old.replace(token, value);
                return AbstractExpression::Solution(*num, Box::new(new));
            }
            AbstractExpression::Expression(op, old1, old2) => {
                let new1 = old1.replace(token, value);
                let new2 = old2.replace(token, value);
                return AbstractExpression::Expression(
                    op.to_string(),
                    Box::new(new1),
                    Box::new(new2),
                );
            }
            AbstractExpression::Empty => return AbstractExpression::Empty,
        }
    }

    pub fn reduce_solution(&self) -> (AbstractExpression, AbstractExpression) {
        match self {
            AbstractExpression::Solution(num, old) => {
                if *num == 0 {
                    if let AbstractExpression::Expression(op, exp1, exp2) = *old.clone() {
                        if op == "-" {
                            if exp1 == exp2 {
                                return (AbstractExpression::Empty, AbstractExpression::Empty);
                            }
                            return simplify_equality(*exp1, *exp2);
                        }
                    }
                }
            }
            AbstractExpression::Expression(op, exp1, exp2) => {
                if *exp1.clone() == AbstractExpression::Immediate(0) {
                    if let AbstractExpression::Expression(op, left, right) = *exp2.clone() {
                        if op == "-" {
                            if left == right {
                                return (AbstractExpression::Empty, AbstractExpression::Empty);
                            }
                            return simplify_equality(*left, *right);
                        }
                    }
                } else if *exp2.clone() == AbstractExpression::Immediate(0) {
                    if let AbstractExpression::Expression(op, left, right) = *exp1.clone() {
                        if op == "-" {
                            if left == right {
                                return (AbstractExpression::Empty, AbstractExpression::Empty);
                            }
                            return simplify_equality(*left, *right);
                        }
                    }
                }
            }
            _ => {
                log::error!(
                    "Can't reduce solution on an abstract expression that is not a solution"
                );
                return (AbstractExpression::Empty, AbstractExpression::Empty);
            }
        }
        (AbstractExpression::Empty, AbstractExpression::Empty)
    }
}

fn same_exp_type(left: AbstractExpression, right: AbstractExpression) -> bool {
    match (left, right) {
        (AbstractExpression::Empty, AbstractExpression::Empty) => true,
        (AbstractExpression::Immediate(_), AbstractExpression::Immediate(_)) => true,
        (AbstractExpression::Register(_), AbstractExpression::Register(_)) => true,
        (AbstractExpression::Solution(_, _), AbstractExpression::Solution(_, _)) => true,
        (AbstractExpression::Expression(_, _, _), AbstractExpression::Expression(_, _, _)) => true,
        (_, _) => false,
    }
}

fn simplify_expression(exp: AbstractExpression) -> AbstractExpression {
    match exp.clone() {
        AbstractExpression::Expression(func, arg1, arg2) => {
            if func == "+" || func == "-" {
                if *arg1 == AbstractExpression::Immediate(0) {
                    return *arg2;
                } else if *arg2 == AbstractExpression::Immediate(0) {
                    return *arg1;
                } else {
                    return exp;
                }
            } else {
                return exp;
            }
        }
        _ => return exp,
    }
}

fn simplify_equality(
    left: AbstractExpression,
    right: AbstractExpression,
) -> (AbstractExpression, AbstractExpression) {
    if same_exp_type(left.clone(), right.clone()) {
        match left.clone() {
            AbstractExpression::Immediate(_) => {
                // cant simplify numbers
                return (left, right);
            }
            AbstractExpression::Register(left_reg) => {
                if let AbstractExpression::Register(right_reg) = right {
                    let left_expr = AbstractExpression::Expression(
                        "+".to_string(),
                        Box::new(left_reg.base.unwrap_or(AbstractExpression::Empty)),
                        Box::new(AbstractExpression::Immediate(left_reg.offset)),
                    );
                    let right_expr = AbstractExpression::Expression(
                        "+".to_string(),
                        Box::new(right_reg.base.unwrap_or(AbstractExpression::Empty)),
                        Box::new(AbstractExpression::Immediate(right_reg.offset)),
                    );
                    return simplify_equality(left_expr, right_expr);
                }
            }
            AbstractExpression::Expression(left_op, left_expr1, left_expr2) => {
                if let AbstractExpression::Expression(right_op, right_expr1, right_expr2) =
                    right.clone()
                {
                    if left_op == right_op && left_op == "+" {
                        // imagine a + b = c + d
                        let (a, c) = simplify_equality(
                            simplify_expression(*left_expr1),
                            simplify_expression(*right_expr1),
                        );
                        let (b, d) = simplify_equality(
                            simplify_expression(*left_expr2),
                            simplify_expression(*right_expr2),
                        );
                        let (e, f) = simplify_equality(a, d);
                        let (g, h) = simplify_equality(b, c);

                        let new_left = AbstractExpression::Expression(
                            "+".to_string(),
                            Box::new(e),
                            Box::new(g),
                        );
                        let new_right = AbstractExpression::Expression(
                            "+".to_string(),
                            Box::new(f),
                            Box::new(h),
                        );
                        return (simplify_expression(new_left), simplify_expression(new_right));
                    } else {
                        return (simplify_expression(left), simplify_expression(right));
                    }
                }
            }
            // solution needs to be expanded first before we can simplify, see reduce_solution
            // others don't make much sense
            _ => return (left, right),
        }
    }
    (left, right)
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
