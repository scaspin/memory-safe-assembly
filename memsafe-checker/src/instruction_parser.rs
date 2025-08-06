#[derive(Debug, Clone, PartialEq)]
pub struct Instruction {
    pub ty: InstructionType,
    pub opcode: String,
    pub operands: Vec<Operand>,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Arrangement {
    B8,
    B16,
    H4,
    H8,
    S2,
    S4,
    D2,
    D,
    S,
    H,
    B,
}

#[derive(Debug, Clone, PartialEq)]
pub enum RePrefix {
    X,
    W,
    V,
    Fp,
    Sp,
    Ra,
    Ze,
}

impl Arrangement {
    pub fn from_string(s: &str) -> Arrangement {
        match s {
            "8b" => Arrangement::B8,
            "16b" => Arrangement::B16,
            "4h" => Arrangement::H4,
            "8h" => Arrangement::H8,
            "2s" => Arrangement::S2,
            "4s" => Arrangement::S4,
            "2d" => Arrangement::D2,
            "d" => Arrangement::D,
            "s" => Arrangement::S,
            "h" => Arrangement::H,
            "b" => Arrangement::B,
            _ => panic!("Invalid arrangement string {:?}", s),
        }
    }
}

// BIG TODO: get rid of all the strings!
#[derive(Debug, Clone, PartialEq)]
pub enum Operand {
    Register(RePrefix, usize),
    Immediate(i64),
    Memory(RePrefix, usize, Option<i64>, Option<String>, Option<bool>), // like [x0, #16] // bool to represent pre/post index false = pre, true = post
    Bitwise(String, i64), // like lsl#2, TODO: make enum for shift types
    // the "string" param is probably always going to be "v"
    VectorRegister(RePrefix, usize),
    Vector(RePrefix, usize, Arrangement),
    VectorAccess(RePrefix, usize, Arrangement, i64), // like v1.d[1] or v2.b[3]
    Label(String),
    Address(String, i64), // for relative addresses, i.e. LK256@PAGEOFF
    Other,
}
pub fn register_to_tuple(r: &Operand) -> (RePrefix, usize) {
    match r.clone() {
        Operand::Register(prefix, index) => (prefix, index),
        Operand::VectorRegister(prefix, index) => (prefix, index),
        Operand::Memory(prefix, index, _, _, _) => (prefix, index),
        _ => panic!("Expected a register or vector register operand"),
    }
}

pub fn operand_from_string(a: String) -> Operand {
    if a.starts_with("x")
        || a.starts_with("z")
        || a.starts_with("w")
        || a.starts_with("fp")
        || a.starts_with("sp")
    {
        match a.as_str() {
            "sp" => return Operand::Register(RePrefix::Sp, 0),
            "fp" => return Operand::Register(RePrefix::Fp, 0),
            "ra" => return Operand::Register(RePrefix::Ra, 0),
            "ze" => return Operand::Register(RePrefix::Ze, 0),
            _ => {
                let parts = a.split_at(1);
                let prefix = parts.0;
                if let Ok(num) = parts.1.parse::<usize>() {
                    return Operand::Register(
                        match prefix {
                            "x" => RePrefix::X,
                            "w" => RePrefix::W,
                            _ => panic!("Unknown register prefix: {}", prefix),
                        },
                        num,
                    );
                }
            }
        }
    }

    // is number
    if a.starts_with("#") {
        if let Ok(n) = a.trim_start_matches("#").parse::<i64>() {
            return Operand::Immediate(n);
        } else {
            return Operand::Immediate(string_to_int(&a));
        }
    }

    if a.contains('@') {
        // TODO: extrapolate offset based on context
        return Operand::Address(a, 0);
    }

    // is a shift indicator (if it has # but is not just a number, should fall into this)
    // FIX: potential issue with this that can be fixed by checking shift indicator matches expected ones, i.e. lsl, lsr, asr, ror
    if a.contains("#") & !a.contains("[") {
        let mut parts = a.split('#').peekable();
        if !parts
            .peek()
            .expect("need some strings in shift parsing")
            .is_empty()
        {
            return Operand::Bitwise(
                parts
                    .next()
                    .expect("need part before # in shift parsing")
                    .to_string(),
                parts
                    .next()
                    .and_then(|s| s.parse::<i64>().ok())
                    .expect("need part after # in shift parsing"),
            );
        }
    }

    if a.contains("v") {
        if a.contains(".") {
            let mut parts = a.split('.').into_iter();
            let base = parts
                .next()
                .expect("require base register for simd register");
            let arrangement = parts.next().expect("require a valid simd arrangement");
            if arrangement.contains("[") {
                let mut parts = arrangement.split(&['[', ']']).into_iter();
                println!("{:?}", parts);
                let a = Arrangement::from_string(
                    parts
                        .next()
                        .expect("size indication required for index into vector"),
                );
                let index = string_to_int(parts.next().expect("index required"));
                // TODO: maybe runtime check index is valid for arrangement?

                let parts = base.split_at(1);
                let i = parts
                    .1
                    .parse::<usize>()
                    .expect("vector number must be a number");
                return Operand::VectorAccess(RePrefix::V, i, a, index);
            } else {
                let a = Arrangement::from_string(arrangement);
                let parts = base.split_at(1);
                let i = parts
                    .1
                    .parse::<usize>()
                    .expect("vector number must be a number");
                return Operand::Vector(RePrefix::V, i, a);
            }
        }
        let parts = a.split_at(1);
        let i = parts
            .1
            .parse::<usize>()
            .expect("vector number must be a number");
        return Operand::VectorRegister(RePrefix::V, i);
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
            offset = Some(string_to_int(o.trim_matches(&['[', ']', ',', '#', '!'])));
        }

        if a.contains("!") {
            indexing = Some(false);
        }

        let parts = base.split_at(1);
        let prefix = match parts.0 {
            "x" => RePrefix::X,
            "w" => RePrefix::W,
            e => panic!("Unknown register prefix: {}", e),
        };
        let num = parts
            .1
            .parse::<usize>()
            .expect(&format!("register name must include a number {:?}", parts));
        // TODO: include shift
        return Operand::Memory(prefix, num, offset, None, indexing);
    }

    if !a.is_empty() {
        return Operand::Label(a);
    }

    return Operand::Other;
}

fn combine_addressing_modes_operands(parts: Vec<String>) -> Vec<String> {
    let mut result = Vec::new();

    for i in 0..parts.len() {
        if parts[i].starts_with('[') {
            // ignores SIMD/SVE indexing like v1.d[1]
            let rest = parts[i..].join(",");
            result.push(rest);
            break;
        } else {
            result.push(parts[i].clone());
        }
    }
    return result;
}

#[derive(Debug, Clone, PartialEq)]
pub enum InstructionType {
    Arithmetic,
    Memory,
    ControlFlow,
    SIMDArithmetic,
    SIMDManagement, // loading and storing vectors
    Label,
    Other, // catchall for now, add other subtypes like jumps, comparisons, etc... if necessary
}

fn match_instruction_type(opcode: &str, operands: &[Operand]) -> InstructionType {
    if operands.is_empty() {
        if opcode.ends_with(':') {
            return InstructionType::Label;
        }
        return InstructionType::Other;
    // considered SIMDManagement when there is a vector access or when a vector is loaded/stored from a regular register
    } else if operands
        .iter()
        .any(|op| matches!(op, Operand::VectorAccess(..)))
        || ((operands.iter().any(|op| matches!(op, Operand::Vector(..)))
            || operands
                .iter()
                .any(|op| matches!(op, Operand::VectorRegister(..))))
            && (operands
                .iter()
                .any(|op| matches!(op, Operand::Register(..)))
                || operands.iter().any(|op| matches!(op, Operand::Memory(..)))))
    {
        return InstructionType::SIMDManagement;
    } else if operands.iter().any(|op| matches!(op, Operand::Memory(..))) {
        return InstructionType::Memory;
    } else if operands.len() > 2
        && operands.iter().all(|op| {
            matches!(op, Operand::Register(..))
                || matches!(op, Operand::Immediate(_))
                || matches!(op, Operand::Bitwise(..))
        })
    {
        return InstructionType::Arithmetic;
    } else if operands
        .iter()
        .any(|op| matches!(op, Operand::Vector(..)) || matches!(op, Operand::VectorRegister(..)))
    {
        return InstructionType::SIMDArithmetic;
    } else if opcode.starts_with("b")
        || opcode.starts_with("j")
        || opcode.contains("adr")
        || opcode == "ret"
    {
        return InstructionType::ControlFlow;
    }
    return InstructionType::Other;
}

impl Instruction {
    pub fn new(input: String) -> Self {
        let mut parts = input
            .split(|c| c == '\t' || c == ',' || c == ' ' || c == '{' || c == '}')
            .collect::<Vec<&str>>()
            .into_iter()
            .filter(|x| !x.is_empty());
        let opcode = parts
            .next()
            .expect("Require opcode for instruction")
            .to_string();

        let combine_brackets =
            combine_addressing_modes_operands(parts.into_iter().map(|s| s.to_string()).collect());

        let operands: Vec<Operand> = combine_brackets
            .into_iter()
            .map(|s| operand_from_string(s.to_string()))
            .collect();

        let ty = match_instruction_type(&opcode, &operands);

        Instruction {
            ty,
            opcode,
            operands,
        }
    }

    pub fn is_simd(&self) -> bool {
        self.operands.iter().any(|op| match op {
            Operand::VectorRegister(..) => true,
            Operand::Vector(..) => true,
            Operand::VectorAccess(..) => true,
            _ => false,
        })
    }

    pub fn is_label(&self) -> bool {
        self.ty == InstructionType::Label
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_add_register() {
        let good_result = Instruction {
            ty: InstructionType::Arithmetic,
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 1),
            ]),
        };

        // test multiple variations of spacing around commas
        assert_eq!(Instruction::new("add x0,x0,x1".to_string()), good_result,);
        assert_eq!(
            Instruction::new("add x0 , x0 , x1".to_string()),
            good_result,
        );
        assert_eq!(
            Instruction::new(" add x0 , x0 , x1".to_string()),
            good_result,
        );
    }

    #[test]
    fn test_parse_add_immediate() {
        let good_result = Instruction {
            ty: InstructionType::Arithmetic,
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 0),
                Operand::Immediate(4),
            ]),
        };

        assert_eq!(Instruction::new("add x0,x0,#4".to_string()), good_result);
    }

    #[test]
    fn test_parse_add_shifted_immediate() {
        let good_result = Instruction {
            ty: InstructionType::Arithmetic,
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 0),
                Operand::Immediate(2),
                Operand::Bitwise(String::from("lsl"), 12),
            ]),
        };

        assert_eq!(
            Instruction::new("add x0,x0,#2,lsl#12".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_add_shifted_immediate_with_space() {
        let good_result = Instruction {
            ty: InstructionType::Arithmetic,
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 1),
                Operand::Bitwise(String::from("lsl"), 12),
            ]),
        };

        assert_eq!(
            Instruction::new("add x0,x0,x1,lsl #12".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_add_address() {
        let good_result = Instruction {
            ty: InstructionType::Other,
            opcode: String::from("add"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 30),
                Operand::Register(RePrefix::X, 30),
                Operand::Address(String::from("LK256@PAGEOFF"), 0),
            ]),
        };
        assert_eq!(
            Instruction::new("add	x30,x30,LK256@PAGEOFF".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_str() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("str"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Memory(RePrefix::X, 29, None, None, None),
            ]),
        };
        assert_eq!(Instruction::new("str x0,[x29]".to_string()), good_result);
    }

    #[test]
    fn test_parse_str_immediate() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("str"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Memory(RePrefix::X, 29, Some(112), None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("str x0,[x29,#112]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_register_address() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 20),
                Operand::Register(RePrefix::X, 21),
                Operand::Memory(RePrefix::X, 0, None, None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("stp x20,x21,[x0]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_signed_offset() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 22),
                Operand::Register(RePrefix::X, 23),
                Operand::Memory(RePrefix::X, 0, Some(8), None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("stp x22,x23,[x0,#8]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_signed_offset_arithmetic() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 22),
                Operand::Register(RePrefix::X, 23),
                Operand::Memory(RePrefix::X, 0, Some(8), None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("stp x22,x23,[x0,#2*4]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_post_index() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 22),
                Operand::Register(RePrefix::X, 23),
                Operand::Memory(RePrefix::X, 0, Some(8), None, Some(true)),
            ]),
        };
        assert_eq!(
            Instruction::new("stp x22,x23,[x0],#8".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_post_index_arithmetic() {
        let good_result = Instruction {
            ty: InstructionType::Memory,
            opcode: String::from("stp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 22),
                Operand::Register(RePrefix::X, 23),
                Operand::Memory(RePrefix::X, 0, Some(8), None, Some(true)),
            ]),
        };
        assert_eq!(
            Instruction::new("stp x22,x23,[x0],#2*4".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_stp_pre_index() {
        let good_result = Instruction {
            opcode: String::from("stp"),
            ty: InstructionType::Memory,
            operands: Vec::from([
                Operand::Register(RePrefix::X, 29),
                Operand::Register(RePrefix::X, 30),
                Operand::Memory(RePrefix::X, 0, Some(-128), None, Some(false)),
            ]),
        };
        assert_eq!(
            Instruction::new("stp x29,x30,[x0,#-128]!".to_string()),
            good_result
        );
    }

    // TODO: copy str/stp tests for ldr/ldp

    #[test]
    fn test_parse_cmp_register_immediate() {
        let good_result = Instruction {
            ty: InstructionType::Other,
            opcode: String::from("cmp"),
            operands: Vec::from([Operand::Register(RePrefix::X, 0), Operand::Immediate(2)]),
        };
        assert_eq!(Instruction::new("cmp x0,#2".to_string()), good_result);
    }

    #[test]
    fn test_parse_cmp_register() {
        let good_result = Instruction {
            ty: InstructionType::Other,
            opcode: String::from("cmp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 1),
            ]),
        };
        assert_eq!(Instruction::new("cmp x0,x1".to_string()), good_result);
    }

    #[test]
    fn test_parse_cmp_shifted_register() {
        let good_result = Instruction {
            ty: InstructionType::Arithmetic,
            opcode: String::from("cmp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 0),
                Operand::Register(RePrefix::X, 1),
                Operand::Bitwise(String::from("lsr"), 2),
            ]),
        };
        assert_eq!(Instruction::new("cmp x0,x1,lsr#2".to_string()), good_result);
    }

    #[test]
    fn test_parse_adrp() {
        let good_result = Instruction {
            ty: InstructionType::Other,
            opcode: String::from("adrp"),
            operands: Vec::from([
                Operand::Register(RePrefix::X, 30),
                Operand::Address(String::from("LK256@PAGE"), 0),
            ]),
        };
        assert_eq!(
            Instruction::new("adrp x30,LK256@PAGE".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_b_condition_bne() {
        let good_result = Instruction {
            ty: InstructionType::ControlFlow,
            opcode: String::from("b.ne"),
            operands: Vec::from([Operand::Label(String::from("Loop"))]),
        };
        assert_eq!(Instruction::new("b.ne Loop".to_string()), good_result);
    }

    #[test]
    fn test_parse_b() {
        let good_result = Instruction {
            ty: InstructionType::ControlFlow,
            opcode: String::from("b"),
            operands: Vec::from([Operand::Label(String::from("Loop"))]),
        };
        assert_eq!(Instruction::new("b Loop".to_string()), good_result);
    }

    #[test]
    fn test_parse_cbnz() {
        let good_result = Instruction {
            ty: InstructionType::ControlFlow,
            opcode: String::from("cbnz"),
            operands: Vec::from([
                Operand::Register(RePrefix::W, 19),
                Operand::Label(String::from("Loop_16_xx")),
            ]),
        };
        assert_eq!(
            Instruction::new("cbnz w19,Loop_16_xx".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_ret() {
        let good_result = Instruction {
            ty: InstructionType::Other,
            opcode: String::from("ret"),
            operands: Vec::new(),
        };
        assert_eq!(Instruction::new("ret".to_string()), good_result);
    }

    #[test]
    fn test_parse_simd_ld1() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("ld1"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 0, Arrangement::B16),
                Operand::Memory(RePrefix::X, 16, None, None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("ld1 { v0.16b }, [x16]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_st1() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("st1"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 5, Arrangement::H8),
                Operand::Memory(RePrefix::X, 0, None, None, None),
            ]),
        };
        assert_eq!(
            Instruction::new("st1 { v5.8h }, [x0]".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_movi() {
        let good_result = Instruction {
            ty: InstructionType::SIMDArithmetic,
            opcode: String::from("movi"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 19, Arrangement::B16),
                Operand::Immediate(0xe1),
            ]),
        };
        assert_eq!(
            Instruction::new("movi v19.16b, #0xe1".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_aese() {
        let good_result = Instruction {
            ty: InstructionType::SIMDArithmetic,
            opcode: String::from("aese"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 0, Arrangement::B16),
                Operand::Vector(RePrefix::V, 18, Arrangement::B16),
            ]),
        };
        assert_eq!(
            Instruction::new("aese v0.16b, v18.16b".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_fmov() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("fmov"),
            operands: Vec::from([
                Operand::VectorAccess(RePrefix::V, 1, Arrangement::D, 1),
                Operand::Register(RePrefix::X, 9),
            ]),
        };
        assert_eq!(
            Instruction::new("fmov v1.d[1], x9".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_ext() {
        let good_result = Instruction {
            ty: InstructionType::SIMDArithmetic,
            opcode: String::from("ext"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 14, Arrangement::B16),
                Operand::Vector(RePrefix::V, 14, Arrangement::B16),
                Operand::Vector(RePrefix::V, 14, Arrangement::B16),
                Operand::Immediate(8),
            ]),
        };
        assert_eq!(
            Instruction::new("ext v14.16b, v14.16b, v14.16b, #8".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_simd_arithmetic() {
        let good_result = Instruction {
            ty: InstructionType::SIMDArithmetic,
            opcode: String::from("eor"),
            operands: Vec::from([
                Operand::Vector(RePrefix::V, 1, Arrangement::B16),
                Operand::Vector(RePrefix::V, 1, Arrangement::B16),
                Operand::Vector(RePrefix::V, 31, Arrangement::B16),
            ]),
        };
        assert_eq!(
            Instruction::new("eor v1.16b, v1.16b, v31.16b".to_string()),
            good_result
        );
    }

    // this is what the SIMD used in rav1d looks like, may change with different decompilation pipeline
    #[test]
    fn test_parse_simd_st1_8h() {
        let good_result = Instruction {
            ty: InstructionType::SIMDManagement,
            opcode: String::from("st1.8h"),
            operands: Vec::from([
                Operand::VectorRegister(RePrefix::V, 30),
                Operand::VectorRegister(RePrefix::V, 31),
                Operand::Memory(RePrefix::X, 0, Some(32), None, Some(true)),
            ]),
        };
        assert_eq!(
            Instruction::new("st1.8h { v30, v31 }, [x0], #32".to_string()),
            good_result
        );
    }
    #[test]
    fn test_parse_simd_ushll() {
        let good_result = Instruction {
            ty: InstructionType::SIMDArithmetic,
            opcode: String::from("ushll.8h"),
            operands: Vec::from([
                Operand::VectorRegister(RePrefix::V, 2),
                Operand::VectorRegister(RePrefix::V, 2),
                Operand::Immediate(0),
            ]),
        };
        assert_eq!(
            Instruction::new("ushll.8h v2, v2, #0".to_string()),
            good_result
        );
    }

    #[test]
    fn test_parse_label() {
        let good_result = Instruction {
            ty: InstructionType::Label,
            opcode: String::from("Loop:"),
            operands: Vec::new(),
        };
        assert_eq!(Instruction::new("Loop:".to_string()), good_result);
    }

    #[test]
    fn test_parse_cset_with_condition() {
        let good_result = Instruction {
            ty: InstructionType::Other,
            opcode: String::from("cset"),
            operands: Vec::from([
                Operand::Register(RePrefix::W, 0),
                Operand::Label("eq".to_string()), // TODO: make this condition code enum
            ]),
        };
        assert_eq!(Instruction::new("cset w0, eq".to_string()), good_result);
    }

    #[test]
    #[should_panic(expected = "not yet implemented")] // TODO
    fn test_parse_bad_register_name_prefix() {
        todo!();
    }

    #[test]
    #[should_panic(expected = "not yet implemented")] // TODO
    fn test_parse_bad_register_name_index() {
        todo!();
    }
}

// // FIX: try to retire this function since errors are sometimes confusing
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
