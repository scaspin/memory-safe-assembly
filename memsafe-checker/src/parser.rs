use std::str::FromStr;

// #[derive(Debug, Clone, PartialEq)]
// enum InstructionType {
//     Arithmetic,
//     MultiArithmetic, //SIMD or FP
//     Logical,        // Move, shift, anything with one input register
//     Memory,
//     MultiMemory,
//     Comparison,
//     Jump,
//     Shift,
//     Other,
// }

#[derive(Debug, Clone, PartialEq)]
pub enum Operand {
    Register(String),
    Immediate(i64),
    Memory(String, Option<i64>, Option<bool>), // like [x0, #16] // bool to represent pre/post index 0 = false, 1 = true
    TAATMemory(String, String, Option<i64>, Option<bool>), // like [x0, x1]
    Bitwise(String, i64),                      // like lsl#2
    SVERegister(String),                       // for SVE registers
    SIMDRegister(String),                      // for SIMD registers
    Label(String), // strings, potentially label addresses (i.e. @) for branching and jumping
    Other,
}

#[derive(Debug, Clone, PartialEq)]
pub struct NewInstruction {
    opcode: String,
    operands: Vec<Operand>,
}

fn is_register(n: String) -> bool {
    n.starts_with("x")
        || n.starts_with("z")
        || n.starts_with("w")
        || n.starts_with("fp")
        || n.starts_with("sp")
}

fn operand_from_string(a: String) -> Operand {
    if is_register(a.clone()) {
        return Operand::Register(a);
    }

    // is number
    if a.starts_with("#") {
        if let Ok(n) = a.trim_start_matches("#").parse::<i64>() {
            return Operand::Immediate(n);
        }
    }

    // is a shift indicator (if it has # but is not a number, should fall into this)
    // FIX: potential issue with this that can be fixed by checking shift indicator matches expected ones, i.e. lsl, lsr, asr, ror
    if a.contains("#") & !a.contains("[") {
        let mut parts = a.split('#').peekable();
        if !parts.peek().unwrap_or(&"").is_empty() {
            return Operand::Bitwise(
                parts.next().unwrap_or("").to_string(),
                parts
                    .next()
                    .and_then(|s| s.parse::<i64>().ok())
                    .unwrap_or(0),
            );
        }
    }

    if a.contains("[") || a.contains("]") {
        let mut parts = a.split(',').peekable();
        let mut base: String = String::new();
        let mut offset: Option<i64> = None;
        let mut indexing: Option<bool> = None;

        if let Some(b) = parts.next() {
            if b.contains("]") && parts.peek().is_some() {
                indexing = Some(true); // the notation for post-indexing is [address], <offset>
            }
            base = b.trim_matches(&['[', ']', ',']).to_string();
        }

        if let Some(o) = parts.next() {
            println!("Offset part: {}", o);
            offset = Some(
                o.trim_matches(&['[', ']', ',', '#', '!'])
                    .to_string()
                    .parse::<i64>()
                    .unwrap_or(0),
            );
        }

        if a.contains("!") {
            indexing = Some(false);
        }

        return Operand::Memory(base, offset, indexing);
    }

    return Operand::Other;
}

//TODO: find a more efficient way to do this
fn combine_elems_between_brackets(parts: Vec<String>) -> Vec<String> {
    let mut inside_brackets = false;
    let mut bracket_content = Vec::new();
    let mut combined_parts = Vec::new();

    for p in parts {
        if inside_brackets {
            bracket_content.push(p.clone());
            if p.contains("]") {
                combined_parts.push(bracket_content.join(","));
                bracket_content.clear();
                inside_brackets = false;
            }
        } else if p.contains("[") && p.contains("]") {
            combined_parts.push(p.clone());
        } else if p.contains("[") {
            inside_brackets = true;
            bracket_content.push(p.clone());
        } else {
            combined_parts.push(p.clone());
        }
    }

    return combined_parts;
}

impl NewInstruction {
    pub fn new(input: String) -> Self {
        let mut parts = input
            .split(|c| c == '\t' || c == ',' || c == ' ')
            .collect::<Vec<&str>>()
            .into_iter()
            .filter(|x| !x.is_empty());
        let opcode = parts.next().unwrap_or("").to_string();
        let combine_brackets =
            combine_elems_between_brackets(parts.into_iter().map(|s| s.to_string()).collect());
        let operands = combine_brackets
            .into_iter()
            .map(|s| operand_from_string(s.to_string()))
            .collect();

        NewInstruction { opcode, operands }
    }

    pub fn is_simd(&self) -> bool {
        self.operands.iter().any(|op| match op {
            Operand::SIMDRegister(_) => true,
            _ => false,
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_add_register() {
        let good_result = NewInstruction {
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(String::from("x0")),
                Operand::Register(String::from("x0")),
                Operand::Register(String::from("x1")),
            ]),
        };

        // test multiple variations of spacing around commas
        assert_eq!(NewInstruction::new("add x0,x0,x1".to_string()), good_result,);
        assert_eq!(
            NewInstruction::new("add x0 , x0 , x1".to_string()),
            good_result,
        );
        assert_eq!(
            NewInstruction::new(" add x0 , x0 , x1".to_string()),
            good_result,
        );
    }

    #[test]
    fn test_parse_add_shifted_register() {
        let good_result = NewInstruction {
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(String::from("x0")),
                Operand::Register(String::from("x0")),
                Operand::Register(String::from("x1")),
                Operand::Bitwise(String::from("lsl"), 2),
            ]),
        };

        assert_eq!(
            NewInstruction::new("add x0,x0,x1,lsl#2".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_add_immediate() {
        let good_result = NewInstruction {
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(String::from("x0")),
                Operand::Register(String::from("x0")),
                Operand::Immediate(4),
            ]),
        };

        assert_eq!(NewInstruction::new("add x0,x0,#4".to_string()), good_result);
    }

    #[test]
    fn test_parse_add_shifted_immediate() {
        let good_result = NewInstruction {
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(String::from("x0")),
                Operand::Register(String::from("x0")),
                Operand::Immediate(2),
                Operand::Bitwise(String::from("lsl"), 12),
            ]),
        };

        assert_eq!(
            NewInstruction::new("add x0,x0,#2,lsl#12".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_str() {
        let good_result = NewInstruction {
            opcode: String::from("str"),
            operands: Vec::from([
                Operand::Register(String::from("x0")),
                Operand::Memory(String::from("x29"), None, None),
            ]),
        };
        assert_eq!(NewInstruction::new("str x0,[x29]".to_string()), good_result);
    }

    #[test]
    fn test_parse_str_immediate() {
        let good_result = NewInstruction {
            opcode: String::from("str"),
            operands: Vec::from([
                Operand::Register(String::from("x0")),
                Operand::Memory(String::from("x29"), Some(112), None),
            ]),
        };
        assert_eq!(
            NewInstruction::new("str x0,[x29,#112]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_register_address() {
        let good_result = NewInstruction {
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(String::from("x20")),
                Operand::Register(String::from("x21")),
                Operand::Memory(String::from("x0"), None, None),
            ]),
        };
        assert_eq!(
            NewInstruction::new("stp x20,x21,[x0]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_signed_offset() {
        let good_result = NewInstruction {
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(String::from("x22")),
                Operand::Register(String::from("x23")),
                Operand::Memory(String::from("x0"), Some(8), None),
            ]),
        };
        assert_eq!(
            NewInstruction::new("stp x22,x23,[x0,#8]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_signed_offset_arithmetic() {
        let good_result = NewInstruction {
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(String::from("x22")),
                Operand::Register(String::from("x23")),
                Operand::Memory(String::from("x0"), Some(8), None),
            ]),
        };
        assert_eq!(
            NewInstruction::new("stp x22,x23,[x0,#2*4]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_post_index() {
        let good_result = NewInstruction {
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(String::from("x22")),
                Operand::Register(String::from("x23")),
                Operand::Memory(String::from("x0"), Some(8), Some(true)),
            ]),
        };
        assert_eq!(
            NewInstruction::new("stp x22,x23,[x0],#8".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_post_index_arithmetic() {
        let good_result = NewInstruction {
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(String::from("x22")),
                Operand::Register(String::from("x23")),
                Operand::Memory(String::from("x0"), Some(8), Some(true)),
            ]),
        };
        assert_eq!(
            NewInstruction::new("stp x22,x23,[x0],#2*4".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_pre_index() {
        let good_result = NewInstruction {
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(String::from("x29")),
                Operand::Register(String::from("x30")),
                Operand::Memory(String::from("x0"), Some(-128), Some(false)),
            ]),
        };
        assert_eq!(
            NewInstruction::new("stp x29,x30,[x0,#-128]!".to_string()),
            good_result
        );
    }
}

// TODO: rewrite instruction structure (from here down)
// to make decision branches in execute simpler
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
