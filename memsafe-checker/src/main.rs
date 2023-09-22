use log::{error, warn};
use std::collections::HashMap;
use std::fmt;
use std::fs::File;
use std::io::{BufRead, BufReader};
use std::result::Result;
use std::str::FromStr;

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

    // need to account for # addressing modes
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let v: Vec<&str> = s.split(|c| c == '\t' || c == ',').collect();

        let v0 = v[0].to_string();
        let v1: Option<String>;
        let v2: Option<String>;
        let v3: Option<String>;
        let v4: Option<String>;

        if v.len() > 1 {
            v1 = Some(v[1].to_string());
        } else {
            v1 = None;
        }
        if v.len() > 2 {
            v2 = Some(v[2].to_string());
        } else {
            v2 = None;
        }
        if v.len() > 3 {
            v3 = Some(v[3].to_string());
        } else {
            v3 = None;
        }
        if v.len() > 3 {
            v4 = Some(v[3].to_string());
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

fn get_register_index(reg_name: Option<String>) -> usize {
    let name = reg_name.clone().expect("Invalid register value");
    let r: usize = name
        .strip_prefix("x")
        .unwrap_or(&name)
        .strip_prefix("w")
        .expect("Invalid register name 2")
        .parse::<usize>()
        .expect("Invalid register value 3");
    return r;
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
    offset: u64,
}

impl RegisterValue {
    fn new(name: &str) -> RegisterValue {
        RegisterValue {
            kind: RegisterKind::RegisterBase,
            base: Some(name.to_string()),
            offset: 0,
        }
    }

    // FIX trailing backslashes issue
    pub fn to_string(&self) -> String {
        let mut base = "".to_string();
        match &self.base {
            Some(inner) => base = inner.to_string(),
            None => (),
        }
        format!("base: {:?}, offset: {:?}", base, self.offset)
    }

    fn set(&mut self, kind: RegisterKind, base: Option<String>, offset: u64) {
        self.kind = kind;
        self.base = base;
        self.offset = offset;
    }

    fn simplify(&mut self) {
        unimplemented!();
        // TODO: simplify expression when possible
    }
}

// all the allowable cases in which registers can be compared or used together
fn comparable(r1: RegisterValue, r2: RegisterValue) -> bool {
    if r1.kind == r2.kind {
        return true;
    }
    if r1.kind == RegisterKind::RegisterBase && r2.kind == RegisterKind::Immediate {
        return true;
    }
    if r2.kind == RegisterKind::RegisterBase && r1.kind == RegisterKind::Immediate {
        return true;
    }
    if r1.kind == RegisterKind::Address && r2.kind == RegisterKind::Immediate {
        return true;
    }
    if r2.kind == RegisterKind::Address && r1.kind == RegisterKind::Immediate {
        return true;
    }

    error!("uncomparable registers");
    false
}

fn generate_expression(op: &str, a: String, b: String) -> String {
    "[".to_owned() + &a + &op.to_string() + &b + "]"
}

struct ARMCORTEXA {
    registers: [RegisterValue; 33],
    zero: Option<bool>,
    neg: Option<bool>,
    carry: Option<bool>,
    overflow: Option<bool>,
    memory: HashMap<usize, String>,
    stack: Vec<RegisterValue>,
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
                instruction.r1.clone(),
                instruction.r2.clone(),
                instruction.r3.clone(),
            );
        } else if instruction.op == "and" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x & y,
                instruction.r1.clone(),
                instruction.r2.clone(),
                instruction.r3.clone(),
            );
        } else if instruction.op == "orr" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x | y,
                instruction.r1.clone(),
                instruction.r2.clone(),
                instruction.r3.clone(),
            );
        } else if instruction.op == "eor" {
            self.arithmetic(
                &instruction.op,
                &|x, y| x ^ y,
                instruction.r1.clone(),
                instruction.r2.clone(),
                instruction.r3.clone(),
            );
        } else if instruction.op == "cmp" {
            self.cmp(instruction.r1.clone(), instruction.r2.clone());
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
                instruction.r1.clone(),
                instruction.r2.clone(),
                instruction.r3.clone(),
            );
        } else if instruction.op == "ld1" {
        } else if instruction.op == "ldp" {
            //post index

            //pre index

            //signed offset
            unimplemented!();
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
                let r1 = self.registers[get_register_index(instruction.r1.clone())].clone();
                if r1.kind == RegisterKind::Address {
                    unimplemented!();
                    //return r1.index;
                } else {
                    unimplemented!();
                    //return Err("cannot return to a non-address")
                }
            }
        } else if instruction.op == "st1" {
            unimplemented!();
        } else if instruction.op == "stp" {
            unimplemented!();
        } else {
            println!("Instruction not supported {:?}", instruction);
        }

        Ok(None)
    }

    fn restored(&self) -> bool {
        self.stack.is_empty()
    }

    fn arithmetic(
        &mut self,
        op_string: &str,
        op: &dyn Fn(u64, u64) -> u64,
        reg0: Option<String>,
        reg1: Option<String>,
        reg2: Option<String>,
    ) {
        let r1 = self.registers[get_register_index(reg1)].clone();
        let r2 = self.registers[get_register_index(reg2)].clone();

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    let mut base: Option<String> = None;
                    match r1.clone().base {
                        Some(reg1base) => match r2.clone().base {
                            Some(reg2base) => {
                                let concat = generate_expression(op_string, reg1base, reg2base);
                                base = Some(concat)
                            }
                            None => {
                                base = Some(reg1base);
                            }
                        },
                        None => match r2.clone().base {
                            Some(reg2base) => base = Some(reg2base),
                            None => {
                                base = None;
                            }
                        },
                    }
                    self.registers[get_register_index(reg0)].set(
                        RegisterKind::RegisterBase,
                        base,
                        op(r1.offset, r2.offset),
                    )
                }
                RegisterKind::Number => {
                    // abstract numbers, value doesn't matter
                    self.registers[get_register_index(reg0)].set(RegisterKind::Number, None, 0);
                }
                RegisterKind::Immediate => self.registers[get_register_index(reg0)].set(
                    RegisterKind::Immediate,
                    None,
                    op(r1.offset, r2.offset),
                ),
                RegisterKind::Address => {
                    // why would someone add two addresses? bad
                    // I guess ok as long as we don't use as address
                    warn!("Not advisable to add two addresses");
                    self.registers[get_register_index(reg0)].set(
                        RegisterKind::Address,
                        None,
                        op(r1.offset, r2.offset),
                    )
                }
            }
        } else if r1.kind == RegisterKind::Immediate {
            self.registers[get_register_index(reg0)].set(
                r2.kind,
                r2.base,
                op(r1.offset, r2.offset),
            );
        } else if r2.kind == RegisterKind::Immediate {
            self.registers[get_register_index(reg0)].set(
                r1.kind,
                r1.base,
                op(r1.offset, r2.offset),
            );
        } else {
            error!("Cannot perform arithmetic on these two registers")
        }
    }

    fn cmp(&mut self, reg1: Option<String>, reg2: Option<String>) {
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

    fn ld1(
        &self,
        reg1: Option<String>,
        reg2: Option<String>,
        reg3: Option<String>,
        reg4: Option<String>,
    ) {
        unimplemented!();
    }
    fn ldp(
        &self,
        reg1: Option<String>,
        reg2: Option<String>,
        val1: RegisterValue,
        val2: RegisterValue,
    ) {
        unimplemented!();
    }

    fn st1(
        &self,
        reg1: Option<String>,
        reg2: Option<String>,
        reg3: Option<String>,
        reg4: Option<String>,
    ) {
        unimplemented!();
    }
    fn stp(
        &self,
        reg1: Option<String>,
        reg2: Option<String>,
        val1: RegisterValue,
        val2: RegisterValue,
    ) {
        unimplemented!();
    }
}

fn main() -> std::io::Result<()> {
    let file = File::open("./assets/processed-sha256-armv8-ios64.S")?;
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

            if text.contains(':') || text.contains("#") || text.contains("_") || text.contains("@")
            {
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

    // FIX: put defs into memory in a more elegant way, this is bad
    let mut alignment = 4;
    let mut address = 0;
    for def in defs.iter() {
        let v: Vec<&str> = def.split(|c| c == '\t' || c == ',').collect();
        if v[0] == ".align" {
            alignment = v[1].parse::<usize>().unwrap();
        } else if v[0] == ".byte" || v[0] == ".long" {
            for i in v.iter().skip(1) {
                println!("{:?}", i.clone());
                println!("{:?}", address.clone());
                computer.memory.insert(address, i.to_string());
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
            Err(e) => println!(
                "Instruction could not execute at line {:?} : {:?}",
                pc, instruction
            ),
        }
    }

    // check stack and required registers are restored
    computer.restored();

    allops.sort_unstable();
    allops.dedup();
    println!("all instructions used: {:?}", allops);

    Ok(())
}
