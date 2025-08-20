use crate::computer::*;

impl<'ctx> ARMCORTEXA<'_> {
    //TODO: generics instead
    pub fn vector_arithmetic(
        &mut self,
        op_string: &str,
        op_byte: impl Fn(u8, u8) -> u8,
        op_half: impl Fn(u16, u16) -> u16,
        op_word: impl Fn(u32, u32) -> u32,
        op_double: impl Fn(u64, u64) -> u64,
        instruction: &Instruction,
    ) {
        let mut reg_iter = instruction.operands.iter();

        let reg0 = reg_iter.next().expect("Need destination register");
        let reg1 = reg_iter.next().expect("Need first source register");
        let reg2 = reg_iter.next().expect("Need second source register");

        let r0 = &mut self.get_simd_register(reg0);
        let r1 = self.get_simd_register(reg1);
        let r2 = self.get_simd_register(reg2);

        match (reg0, reg1, reg2) {
            (Operand::Vector(_, _, a), Operand::Vector(..), Operand::Vector(..)) => match a {
                Arrangement::D2 => {
                    for i in 0..2 {
                        let (bases1, offsets1) = r1.get_double(i);

                        let (bases2, offsets2) = r2.get_double(i);

                        let a = u64::from_be_bytes(offsets1);
                        let b = u64::from_be_bytes(offsets2);
                        let offset = op_double(a, b);

                        let mut new_bases = [BASE_INIT; 8];
                        for i in 0..8 {
                            if bases1[i].is_some() && bases2[i].is_some() {
                                new_bases[i] = generate_expression_from_options(
                                    op_string,
                                    bases1[i].clone(),
                                    bases2[i].clone(),
                                );
                            }
                        }

                        r0.set_double(i, new_bases, offset.to_be_bytes());
                    }
                }
                Arrangement::S4 => {
                    for i in 0..4 {
                        let (bases1, offsets1) = r1.get_word(i);

                        let (bases2, offsets2) = r2.get_word(i);
                        let a = u32::from_be_bytes(offsets1);
                        let b = u32::from_be_bytes(offsets2);
                        let offset = op_word(a, b);

                        let mut new_bases = [BASE_INIT; 4];
                        for i in 0..4 {
                            new_bases[i] = generate_expression_from_options(
                                op_string,
                                bases1[i].clone(),
                                bases2[i].clone(),
                            );
                        }

                        r0.set_word(i, new_bases, offset.to_be_bytes());
                    }
                }
                Arrangement::H4 => {
                    for i in 0..4 {
                        let (bases1, offsets1) = r1.get_halfword(i);

                        let (bases2, offsets2) = r2.get_halfword(i);
                        let a = u16::from_be_bytes(offsets1);
                        let b = u16::from_be_bytes(offsets2);
                        let offset = op_half(a, b);

                        let mut new_bases = [BASE_INIT; 2];
                        for i in 0..4 {
                            new_bases[i] = generate_expression_from_options(
                                op_string,
                                bases1[i].clone(),
                                bases2[i].clone(),
                            );
                        }

                        r0.set_halfword(i, new_bases, offset.to_be_bytes());
                    }
                }
                Arrangement::H8 => {
                    for i in 0..8 {
                        let (bases1, offsets1) = r1.get_halfword(i);

                        let (bases2, offsets2) = r2.get_halfword(i);
                        let a = u16::from_be_bytes(offsets1);
                        let b = u16::from_be_bytes(offsets2);
                        let offset = op_half(a, b);

                        let mut new_bases = [BASE_INIT; 2];
                        for i in 0..2 {
                            new_bases[i] = generate_expression_from_options(
                                op_string,
                                bases1[i].clone(),
                                bases2[i].clone(),
                            );
                        }

                        r0.set_halfword(i, new_bases, offset.to_be_bytes());
                    }
                }
                Arrangement::B8 => {
                    for i in 0..8 {
                        let (bases1, a) = r1.get_byte(i);

                        let (bases2, b) = r2.get_byte(i);

                        let offset = op_byte(a, b);

                        let new_base = generate_expression_from_options(
                            op_string,
                            bases1.clone(),
                            bases2.clone(),
                        );

                        r0.set_byte(i, new_base, offset);
                    }
                }
                Arrangement::B16 => {
                    for i in 0..16 {
                        let (bases1, a) = r1.get_byte(i);

                        let (bases2, b) = r2.get_byte(i);

                        let offset = op_byte(a, b);

                        let new_base = generate_expression_from_options(
                            op_string,
                            bases1.clone(),
                            bases2.clone(),
                        );

                        r0.set_byte(i, new_base, offset);
                    }
                }
                _ => todo!("unsupported vector arithmetic access"),
            },
            (_, _, _) => todo!("more simd arithmetic support"),
        }
    }
}

// }
//     // SIMD
//     if instruction.op.contains(".") {
//         if let Some((op, vec)) = instruction.op.split_once(".") {
//             match op {
//                 "rev64" => {
//                     let reg1 = instruction.r1.clone().expect("Need dst register");
//                     let reg2 = instruction.r2.clone().expect("Need source register");

//                     let src =
//                         &self.simd_registers[get_register_index(reg2.clone())].clone();
//                     let dest = &mut self.simd_registers[get_register_index(reg1.clone())];

//                     dest.kind = src.kind.clone();
//                     match vec {
//                         "8h" => {
//                             for i in 0..8 {
//                                 let (base, offset) = src.get_halfword(7 - i);
//                                 dest.set_halfword(i, base, offset);
//                             }
//                         }
//                         "16b" => {
//                             for i in 0..16 {
//                                 let (base, offset) = src.get_byte(15 - i);
//                                 dest.set_byte(i, base, offset);
//                             }
//                         }
//                         _ => todo!("rev64 support more vector modes"),
//                     }
//                 }
//                 "ld1" => {
//                     // TODO: fix parser to not consider { as register
//                     // using 2 and 4 because instruction gets parsed like this:
//                     // Instruction { op: "ld1.8h", r1: Some("{"), r2: Some("v0"), r3: Some("}"), r4: Some("[x1"), r5: None, r6: None }
//                     let reg2 = instruction.r2.clone().expect("Need dst register");
//                     let reg4 = instruction.r4.clone().expect("Need source register");

//                     let src = &self.registers[get_register_index(
//                         reg4.strip_prefix('[').unwrap_or(&reg4).to_string(),
//                     )]
//                     .clone();

//                     let res = self.load_vector(reg2, src.clone());
//                     match res {
//                         Err(e) => return Err(e.to_string()),
//                         _ => (),
//                     }
//                 }
//                 "st1" => {
//                     // TODO: fix parser because instruction gets parsed like this:
//                     // Instruction { op: "st1.d", r1: Some("{"), r2: Some("v0"), r3: Some("[1], [x0"), r4: Some("[1], [x0"), r5: Some("x4"), r6: None }
//                     let reg2 = instruction.r2.clone().expect("Need src register");
//                     let reg3 = instruction.r3.clone().expect("Need index and dest");

//                     let mut parts = reg3.split(",");
//                     let _index = parts
//                         .next()
//                         .expect("expecting index")
//                         .strip_prefix('[')
//                         .expect("something")
//                         .strip_suffix("]")
//                         .expect("something else")
//                         .parse::<i32>()
//                         .expect("expected int");

//                     let dest = get_register_name_string(
//                         parts
//                             .next()
//                             .expect("need another reg")
//                             .strip_prefix(" [")
//                             .expect("storage dest")
//                             .to_string(),
//                     );
//                     let address = self.registers[get_register_index(dest.clone())].clone();

//                     // TODO: use offset to grab only low/high parts of vector
//                     let res = self.store_vector(reg2, address.clone());
//                     match res {
//                         Err(e) => return Err(e.to_string()),
//                         _ => (),
//                     }

//                     if let Some(reg5) = instruction.r5.clone() {
//                         let offset = self.operand(reg5);

//                         self.set_register(
//                             dest,
//                             address.kind,
//                             address.base,
//                             address.offset + offset.offset,
//                         );
//                     }
//                 }
//                 "ld1r" => {
//                     let dst = instruction.r2.clone().expect("need dst ld1r") + vec;
//                     let src = instruction.r4.clone().expect("need src ld1r");

//                     let address = self.registers[get_register_index(src.clone())].clone();
//                     let _ = self.load(dst, address);

//                     //    match vec {
//                     //     "16b" => {
//                     //         for i in 0..15 {
//                     //             set_byte
//                     //         }
//                     // },

//                     // _ => todo!("support more ld1r types")
//                     //    }
//                 }
//                 "dup" | "neg" | "shl" => {
//                     println!("here");
//                 }
//                 _ => todo!("support simd operation with notation {:?}", instruction),
//             }
//         }
//     } else {
//         match instruction.op.as_str() {
//
//             _ => {
//                 log::warn!("SIMD instruction not supported {:?}", instruction);
//                 todo!("unsupported vector operation {:?}", instruction);
//             }
//         }
//     }
