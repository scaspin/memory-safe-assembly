use clap::Parser;
use log::{error, warn};
use std::collections::HashMap;
use std::fmt;
use std::fs::File;
use std::io::{BufRead, BufReader};
use std::path::PathBuf;
use std::result::Result;
use std::str::FromStr;

#[derive(Debug, Clone)]
struct MemorySafetyError {
    details: String,
}

impl MemorySafetyError {
    fn new(msg: &str) -> MemorySafetyError {
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
struct Instruction {
    op: String,
    r1: Option<String>,
    r2: Option<String>,
    r3: Option<String>,
    r4: Option<String>,
}

#[derive(Debug, Clone)]
struct ParseInstructionError;

impl FromStr for Instruction {
    type Err = ParseInstructionError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        //find if there's anything in brackets to allow fun addressing modes
        let mut brac: String = Default::default();
        if s.contains("[") {
            let left = s.find('[');
            let right = s.rfind(']');
            if left.is_some() && right.is_some() {
                brac = s[left.unwrap()..right.unwrap()].to_string();
            }
        }

        let v: Vec<&str> = s.split(|c| c == '\t' || c == ',').collect();

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

fn get_register_index(reg_name: String) -> usize {
    let name = reg_name.clone();
    if reg_name == "sp" {
        return 31;
    }
    let r0 = name.strip_prefix("x").unwrap_or(&name);
    let r1: usize = r0
        .strip_prefix("w")
        .unwrap_or(&r0)
        .parse::<usize>()
        .expect("Invalid register value 3");
    return r1;
}

fn string_to_int(s: &str) -> i64 {
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

#[derive(Debug, Clone, PartialEq)]
enum RegisterKind {
    RegisterBase, // register name / expression + offset
    Number,       // abstract number (from input for example)
    Immediate,    // known number
    Address,
}

#[derive(Debug, Clone)]
struct RegisterValue {
    kind: RegisterKind,
    base: Option<String>,
    offset: i64,
}

impl RegisterValue {
    fn new(name: &str) -> RegisterValue {
        RegisterValue {
            kind: RegisterKind::RegisterBase,
            base: Some(name.to_string()),
            offset: 0,
        }
    }

    fn set(&mut self, kind: RegisterKind, base: Option<String>, offset: i64) {
        self.kind = kind;
        self.base = base;
        self.offset = offset;
    }

}

fn generate_expression(op: &str, a: String, b: String) -> String {
    "[".to_owned() + &a + &op.to_string() + &b + "]"
}

fn get_register_name_string(r: String) -> String {
    let a: Vec<&str> = r.split(",").collect();
    for i in a {
        let name = i.trim_matches('[').to_string();
        return name;
    }

    return r;
}

struct ARMCORTEXA {
    registers: [RegisterValue; 33],
    zero: Option<bool>,
    neg: Option<bool>,
    carry: Option<bool>,
    overflow: Option<bool>,
    memory: HashMap<usize, i64>,
    stack: Vec<RegisterValue>,
    stack_index: i64,
}

impl fmt::Debug for ARMCORTEXA {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "registers: {:?}", &self.stack)
    }
}

impl ARMCORTEXA {
    fn new() -> ARMCORTEXA {
        let registers = [
            RegisterValue::new("x0"),
            RegisterValue::new("x1"),
            RegisterValue::new("x2"),
            RegisterValue::new("x3"),
            RegisterValue::new("x4"),
            RegisterValue::new("x5"),
            RegisterValue::new("x6"),
            RegisterValue::new("x7"),
            RegisterValue::new("x8"),
            RegisterValue::new("x9"),
            RegisterValue::new("x10"),
            RegisterValue::new("x11"),
            RegisterValue::new("x12"),
            RegisterValue::new("x13"),
            RegisterValue::new("x14"),
            RegisterValue::new("x15"),
            RegisterValue::new("x16"),
            RegisterValue::new("x17"),
            RegisterValue::new("x18"),
            RegisterValue::new("x19"),
            RegisterValue::new("x20"),
            RegisterValue::new("x21"),
            RegisterValue::new("x22"),
            RegisterValue::new("x23"),
            RegisterValue::new("x24"),
            RegisterValue::new("x25"),
            RegisterValue::new("x26"),
            RegisterValue::new("x27"),
            RegisterValue::new("x28"),
            RegisterValue::new("x29"), // frame pointer
            RegisterValue::new("x30"), // link
            RegisterValue::new("sp"),  // stack pointer
            RegisterValue::new("xzr"), // 64-bit zero
        ];

        ARMCORTEXA {
            registers,
            zero: None,
            neg: None,
            carry: None,
            overflow: None,
            memory: HashMap::new(),
            stack: Vec::new(),
            stack_index: 0,
        }
    }

    fn set_input(&mut self, register: String) {
        self.registers[get_register_index(register)].set(
            RegisterKind::Address,
            Some("Input".to_string()),
            0,
        )
    }

    fn set_output(&mut self, register: String) {
        self.registers[get_register_index(register)].set(
            RegisterKind::Address,
            Some("Output".to_string()),
            0,
        )
    }

    fn set_register(
        &mut self,
        name: String,
        kind: RegisterKind,
        base: Option<String>,
        offset: i64,
    ) {
        if name.contains("w") {
            self.registers[get_register_index(name)].set(kind, base, (offset as i32) as i64)
        } else {
            self.registers[get_register_index(name)].set(kind, base, (offset as i32) as i64)
        }
    }

    // handle different addressing modes
    fn operand(&mut self, v: String) -> RegisterValue {
        if !v.contains('[') && v.contains('#') {
            let mut base: Option<String> = None;
            if v.contains("ror") {
                base = Some("ror".to_string());
            }
            return RegisterValue {
                kind: RegisterKind::Immediate,
                base: base,
                offset: string_to_int(&v.trim_matches('#')),
            };
        } else if v.contains('[') && !v.contains(',') {
            return RegisterValue {
                kind: RegisterKind::Address,
                base: Some(get_register_name_string(v).to_string()),
                offset: 0,
            };
        } else if v.contains('[') && v.contains(',') && v.contains('#') {
            let a = v.split_once(',').unwrap();
            return RegisterValue {
                kind: RegisterKind::Address,
                base: Some(a.0.trim_matches('[').to_string()),
                offset: string_to_int(a.1.trim_matches(']')),
            };
        } else {
            return self.registers[get_register_index(v)].clone();
        }
    }

    fn execute(
        &mut self,
        instruction: &Instruction,
    ) -> Result<Option<(Option<String>, Option<u128>)>, String> {
        if instruction.op == "add" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x + y,
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
            );
        } else if instruction.op == "sub" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x - y,
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
            );
        } else if instruction.op == "and" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x & y,
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
            );
        } else if instruction.op == "orr" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x | y,
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
            );
        } else if instruction.op == "eor" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x ^ y,
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
            );
            if instruction.r4.is_some() {
                if let Some(expr) = &instruction.r4 {
                    let parts = expr.split_once('#').unwrap();
                    if parts.0 == "ror" {
                        self.rotate(instruction.r1.clone().expect("Should be here"), instruction.r1.clone().expect("Again"), parts.1.to_string());
                    }
                }
            }
        } else if instruction.op == "ror" {
            self.rotate(
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
            );
        } else if instruction.op == "cmp" {
            self.cmp(
                instruction.r1.clone().expect("need register to compare"),
                instruction.r2.clone().expect("need register to compare"),
            );
        } else if instruction.op == "b.ne" {
            match self.zero {
                Some(b) => {
                    if b {
                        return Ok(Some((instruction.r1.clone(), None)));
                    } else {
                        return Ok(None);
                    }
                }
                None => return Err(
                    "Flag cannot be branched on since it has not been set within the program yet"
                        .to_string(),
                ),
            }
        } else if instruction.op == "bic" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x & !y,
                instruction.r1.clone().expect("Need dst register"),
                instruction.r2.clone().expect("Need one operand"),
                instruction.r3.clone().expect("Need two operand"),
            );
        } else if instruction.op == "ret" {
            if instruction.r1.is_none() {
                // return w30
                let w30 = self.registers[30].clone();
                if w30.kind == RegisterKind::Address {
                    return Ok(Some((None, Some(w30.offset.try_into().unwrap()))));
                } else {
                    error!("cannot jump on non-address");
                }
            } else {
                let _r1 = &self.registers[get_register_index(
                    instruction
                        .r1
                        .clone()
                        .expect("provide valid return register"),
                )];
            }
        } else if instruction.op == "ldr" {
            let reg1 = instruction.r1.clone().unwrap();
            let reg2 = instruction.r2.clone().unwrap();

            // pre-index
            if reg2.contains(",") {
                let new_reg = self.operand(reg2.clone());
                self.set_register(
                    get_register_name_string(reg2.clone()).to_string(),
                    new_reg.kind,
                    new_reg.base,
                    new_reg.offset,
                );
            }

            let reg2base = get_register_name_string(reg2.clone());
            let base_add_reg = self.registers[get_register_index(reg2base.clone())].clone();
            self.load(reg1, base_add_reg.clone());

            // post-index
            if instruction.r3.is_some() {
                let new_imm = self.operand(instruction.r3.clone().unwrap());
                self.set_register(
                    reg2base,
                    base_add_reg.kind,
                    base_add_reg.base,
                    base_add_reg.offset + new_imm.offset,
                );
            }
        } else if instruction.op == "ldp" {
            let reg1 = instruction.r1.clone().unwrap();
            let reg2 = instruction.r2.clone().unwrap();
            let reg3 = instruction.r3.clone().unwrap();

            // pre-index
            if reg3.contains(",") {
                let reg3base = get_register_name_string(reg3.clone());
                let new_reg = self.operand(reg3.clone());
                self.set_register(reg3base, new_reg.kind, new_reg.base, new_reg.offset);
            }

            let reg3base = get_register_name_string(reg3.clone());
            let base_add_reg = self.registers[get_register_index(reg3base.clone())].clone();
            let mut base_add_reg_mutable = base_add_reg.clone();
            self.load(reg1, base_add_reg.clone());
            base_add_reg_mutable.offset = base_add_reg.offset + 8;
            self.load(reg2, base_add_reg_mutable);

            // post-index
            if instruction.r4.is_some() {
                let new_imm = self.operand(instruction.r4.clone().unwrap());
                self.set_register(
                    reg3base,
                    base_add_reg.kind,
                    base_add_reg.base,
                    base_add_reg.offset + new_imm.offset,
                );
            }
        } else if instruction.op == "str" {
            let reg1 = instruction.r1.clone().unwrap();
            let reg2 = instruction.r2.clone().unwrap();

            // pre-index
            if reg2.contains(",") {
                let new_reg = self.operand(reg2.clone());
                self.set_register(
                    get_register_name_string(reg2.clone()).to_string(),
                    new_reg.kind,
                    new_reg.base,
                    new_reg.offset,
                );
            }

            let reg2base = get_register_name_string(reg2.clone());
            let base_add_reg = self.registers[get_register_index(reg2base.clone())].clone();
            self.store(reg1, base_add_reg.clone());

            // post-index
            if instruction.r3.is_some() {
                let new_imm = self.operand(instruction.r3.clone().unwrap());
                self.set_register(
                    reg2base,
                    base_add_reg.kind,
                    base_add_reg.base,
                    base_add_reg.offset + new_imm.offset,
                );
            }
        } else if instruction.op == "stp" {
            let reg1 = instruction.r1.clone().unwrap();
            let reg2 = instruction.r2.clone().unwrap();
            let reg3 = instruction.r3.clone().unwrap();

            // pre-index
            if reg3.contains(",") {
                let reg3base = get_register_name_string(reg3.clone());
                let new_reg = self.operand(reg3.clone());
                self.set_register(reg3base, new_reg.kind, new_reg.base, new_reg.offset);
            }

            let reg3base = get_register_name_string(reg3.clone());
            let base_add_reg = self.registers[get_register_index(reg3base.clone())].clone();
            let mut base_add_reg_mutable = base_add_reg.clone();
            self.store(reg1, base_add_reg.clone());
            base_add_reg_mutable.offset = base_add_reg.offset + 8;
            self.store(reg2, base_add_reg_mutable);

            // post-index
            if instruction.r4.is_some() {
                let new_imm = self.operand(instruction.r4.clone().unwrap());
                self.set_register(
                    reg3base,
                    base_add_reg.kind,
                    base_add_reg.base,
                    base_add_reg.offset + new_imm.offset,
                );
            }
        } else {
            println!("Instruction not supported {:?}", instruction);
        }

        Ok(None)
    }

    fn mem_safe_read(&self, base: Option<String>, offset: i64) -> Result<(), MemorySafetyError> {
        if let Some(regbase) = base {
            if regbase == "sp" {
                if self.stack_index + offset.abs() < ((self.stack.len() * 8) as i64) {
                    return Ok(());
                } else {
                    return Err(MemorySafetyError::new("reading past size of stack"));
                }
            } else if regbase == "Input" {
                if offset < 505 {
                    //again, keeping input size to 512 for now
                    return Ok(());
                } else {
                    return Err(MemorySafetyError::new("reading past input size"));
                }
            }
            return Err(MemorySafetyError::new(
                "Cannot read using offsets from not the stack pointer or the input",
            ));
        } else {
            // read from defs
            if self.memory.get(&(offset as usize)).is_some() {
                return Ok(());
            }
        }
        Err(MemorySafetyError::new(
            "Cannot read safely from this address",
        ))
    }

    fn mem_safe_write(&self, base: Option<String>, offset: i64) -> Result<(), MemorySafetyError> {
        if let Some(regbase) = base {
            if regbase == "sp" {
                if offset < self.stack_index + 1 {
                    return Ok(());
                } else {
                    return Err(MemorySafetyError::new(
                        "writing past allocated size of stack",
                    ));
                }
            } else if regbase == "Output" {
                if offset < 249 {
                    return Ok(());
                } else {
                    return Err(MemorySafetyError::new("wring past output size"));
                }
            };
            return Err(MemorySafetyError::new(
                "Cannot write using offsets from not the stack pointer or the input",
            ));
        } else {
            // overwrite def
            if self.memory.get(&(offset as usize)).is_some() {
                return Ok(());
            }
            return Err(MemorySafetyError::new(
                "Cannot write to a random memory address",
            ));
        };
    }

    fn arithmetic(
        &mut self,
        op_string: &str,
        op: &dyn Fn(i64, i64) -> i64,
        reg0: String,
        reg1: String,
        reg2: String,
    ) {
        let r1 = self.operand(reg1);
        let r2 = self.operand(reg2);

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    let base = match r1.clone().base {
                        Some(reg1base) => match r2.clone().base {
                            Some(reg2base) => {
                                let concat = generate_expression(op_string, reg1base, reg2base);
                                Some(concat)
                            }
                            None => {
                                Some(reg1base)
                            }
                        },
                        None => match r2.clone().base {
                            Some(reg2base) => Some(reg2base),
                            None => {
                                None
                            }
                        },
                    };
                    self.set_register(
                        reg0,
                        RegisterKind::RegisterBase,
                        base,
                        op(r1.offset, r2.offset),
                    )
                }
                RegisterKind::Number => {
                    // abstract numbers, value doesn't matter
                    self.set_register(reg0, RegisterKind::Number, None, 0);
                }
                RegisterKind::Immediate => self.set_register(
                    reg0,
                    RegisterKind::Immediate,
                    None,
                    op(r1.offset, r2.offset),
                ),
                RegisterKind::Address => {
                    // why would someone add two addresses? bad
                    // I guess ok as long as we don't use as address
                    warn!("Not advisable to add two addresses");
                    self.set_register(reg0, RegisterKind::Address, None, op(r1.offset, r2.offset))
                }
            }
        } else if r1.kind == RegisterKind::Immediate {
            self.set_register(reg0, r2.kind, r2.base, op(r1.offset, r2.offset));
        } else if r2.kind == RegisterKind::Immediate {
            self.set_register(reg0, r1.kind, r1.base, op(r1.offset, r2.offset));
        } else {
            error!("Cannot perform arithmetic on these two registers")
        }
    }

    fn rotate(&mut self, reg1: String, reg2: String, reg3: String) {
        let r1 = self.registers[get_register_index(reg1.clone())].clone();
        let r2 = self.registers[get_register_index(reg2)].clone();

        let shift = self.operand(reg3).offset;
        let new_offset = r2.offset >> shift;
        self.set_register(reg1, r2.clone().kind, Some(generate_expression("ror", r1.base.unwrap_or("".to_string()), r2.offset.to_string())), new_offset);
    }

    fn cmp(&mut self, reg1: String, reg2: String) {
        let r1 = self.registers[get_register_index(reg1)].clone();
        let r2 = self.registers[get_register_index(reg2)].clone();

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    if r1.base.eq(&r2.base) {
                        self.neg = if r1.offset < r2.offset {
                            Some(true)
                        } else {
                            Some(false)
                        };
                        self.zero = if r1.offset == r2.offset {
                            Some(true)
                        } else {
                            Some(false)
                        };
                        // signed vs signed distinction, maybe make offset generic to handle both?
                        self.carry = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                            Some(true)
                        } else {
                            Some(false)
                        };
                        self.overflow = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                            Some(true)
                        } else {
                            Some(false)
                        };
                    }
                }
                RegisterKind::Number => {
                    error!("Cannot compare two undefined numbers")
                }
                RegisterKind::Immediate => {
                    self.neg = if r1.offset < r2.offset {
                        Some(true)
                    } else {
                        Some(false)
                    };
                    self.zero = if r1.offset == r2.offset {
                        Some(true)
                    } else {
                        Some(false)
                    };
                    // signed vs signed distinction, maybe make offset generic to handle both?
                    self.carry = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                        Some(true)
                    } else {
                        Some(false)
                    };
                    self.overflow = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                        Some(true)
                    } else {
                        Some(false)
                    };
                }
                RegisterKind::Address => {
                    self.neg = if r1.offset < r2.offset {
                        Some(true)
                    } else {
                        Some(false)
                    };
                    self.zero = if r1.offset == r2.offset {
                        Some(true)
                    } else {
                        Some(false)
                    };
                    // signed vs signed distinction, maybe make offset generic to handle both?
                    self.carry = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                        Some(true)
                    } else {
                        Some(false)
                    };
                    self.overflow = if r2.offset > r1.offset && r1.offset - r2.offset > 0 {
                        Some(true)
                    } else {
                        Some(false)
                    };
                }
            }
        } else {
            error!("Cannot compare these two registers")
        }
    }

    /*
     * t: register name to load into
     * address: register with address as value
     */
    fn load(&mut self, t: String, address: RegisterValue) {
        let res = self.mem_safe_read(address.base.clone(), address.offset);
        if res.is_ok() {
            if let Some(base) = address.base {
                if base == "sp" {
                    let index = self.stack_index + (address.offset / 8);
                    let val = self.stack.get(index as usize).unwrap();
                    self.set_register(t, val.kind.clone(), val.base.clone(), val.offset);
                } else if base == "Input" {
                    self.set_register(t, RegisterKind::Number, None, 0);
                } else {
                    let num = self.memory.get(&(address.offset as usize)).unwrap();
                    self.set_register(t, RegisterKind::Immediate, None, *num);
                }
            }
        } else {
            error!("{:?}", res)
        }
    }

    /*
     * t: register to be stored
     * address: where to store it
     */
    fn store(&mut self, reg: String, address: RegisterValue) {
        let res = self.mem_safe_write(address.base.clone(), address.offset);
        if res.is_ok() {
            let reg = self.registers[get_register_index(reg)].clone();
            if let Some(base) = address.base {
                if base == "sp" {
                    let index = self.stack_index + (address.offset / 8);
                    if self.stack.get(index as usize).is_some() {
                        self.stack.remove(index as usize);
                        self.stack.insert(index as usize, reg.clone());
                    } else {
                        self.stack.push(reg.clone())
                    }
                }
            }
        } else {
            error!("{:?}", res)
        }
    }
}

#[derive(Parser)]
struct Args {
    file: PathBuf
}

fn main() -> std::io::Result<()> {
    let args = Args::parse();
    let file = File::open(args.file)?;
    let reader = BufReader::new(file);

    // represent code this way, highly stupid and unoptimized
    let mut defs: Vec<String> = Vec::new();
    let mut code: Vec<String> = Vec::new();
    let mut labels: Vec<(String, usize)> = Vec::new();
    let mut ifdefs: Vec<((String, usize), usize)> = Vec::new();

    let mut parsed_code = Vec::new();

    // grab lines into array
    let mut line_number = 0;
    let mut inifdef = false;
    let mut lastifdef: (String, usize) = ("Start".to_string(), 0);

    // first pass, move text into array
    for line in reader.lines() {
        let unwrapped = line?;
        let trimmed = unwrapped.trim();
        let nocomment = trimmed.split_once("//");
        let text: String;
        match nocomment {
            Some(strings) => text = strings.0.to_string(),
            None => text = trimmed.to_string(),
        }

        if text.is_empty() {
            continue;
        } else if text.starts_with('.') {
            defs.push(text);
        } else {
            // check if ifdef but keep them in the code
            if text.starts_with('#') {
                if inifdef {
                    ifdefs.push((lastifdef.clone(), line_number));
                    inifdef = false;
                } else {
                    inifdef = true;
                    lastifdef = (text.clone(), line_number);
                }
            }

            code.push(text.clone());

            if text.contains(":") && !text.contains(":_") {
                labels.push((text.to_string(), line_number))
            }

            line_number = line_number + 1;

            if text.contains(':') || text.contains("_") || text.contains("@") {
                // handle these later
                continue;
            }
            let parsed = text.parse::<Instruction>();
            match parsed {
                Ok(i) => parsed_code.push(i),
                Err(_) => todo!(),
            }
        }
    }

    // set up simulation structures
    let mut computer = ARMCORTEXA::new();

    computer.set_input("x0".to_string());
    computer.set_output("x2".to_string());

    // FIX: put defs into memory in a more elegant way, this is bad
    let mut alignment = 8;
    let mut address = 0;
    for def in defs.iter() {
        let v: Vec<&str> = def.split(|c| c == '\t' || c == ',').collect();
        if v[0] == ".align" {
            alignment = v[1].parse::<usize>().unwrap();
        } else if v[0] == ".byte" || v[0] == ".long" {
            for i in v.iter().skip(1) {
                let num: i64;
                if i.contains("x") {
                    num = i64::from_str_radix(i.strip_prefix("0x").unwrap(), 16).unwrap();
                } else {
                    if i.is_empty() {
                        continue;
                    }
                    num = i.parse::<i64>().unwrap();
                }
                computer.memory.insert(address, num);
                address = address + alignment;
            }
        }
    }

    let mut allops = Vec::new();

    // second pass, begin processing line by line
    let program_length = parsed_code.len();
    let mut pc = 0;
    while pc < program_length {
        let instruction = parsed_code[pc].clone();
        println!("{:?}", instruction);
        allops.push(instruction.op.clone());

        let execute_result = computer.execute(&parsed_code[pc]);
        match execute_result {
            Ok(some) => match some {
                Some(jump) => match jump {
                    (Some(label), None) => {
                        for l in labels.iter() {
                            if l.0 == label {
                                pc = l.1;
                            }
                        }
                    }
                    (None, Some(address)) => {
                        pc = address as usize;
                    }
                    (None, None) | (Some(_), Some(_)) => {
                        error!("Execute did not return valid response for jump or continue")
                    }
                },
                None => pc = pc + 1,
            },
            Err(_) => println!(
                "Instruction could not execute at line {:?} : {:?}",
                pc, instruction
            ),
        }
    }

    // TODO: check stack and required registers are restored

    allops.sort_unstable();
    allops.dedup();
    println!("all instructions used: {:?}", allops);

    Ok(())
}
