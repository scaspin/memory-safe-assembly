use crate::computer::*;

impl<'ctx> ARMCORTEXA<'_> {
    fn vector_arithmetic(
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
            (
                Operand::Vector(p0, i0, a),
                Operand::Vector(p1, i1, _),
                Operand::Vector(p2, i2, _),
            ) => match a {
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
//             "ld1" => {
//                 let reg1 = instruction.r1.clone().expect("Need first source register");
//                 let reg2 = instruction
//                     .r2
//                     .clone()
//                     .expect("Need second source or dst register");
//                 // either two vector registers in r1 and r2, or four in r1-r4, followed by address and potentially followed by immediate increment value
//                 if let Some(reg5) = &instruction.r5 {
//                     let reg3 = instruction.r3.clone().expect("Need 3rd vector");
//                     let reg4 = instruction.r4.clone().expect("Need 4th vector");
//                     if reg4.contains("}") {
//                         let base_name = get_register_name_string(reg5.clone());
//                         let base_add_reg =
//                             self.registers[get_register_index(base_name.clone())].clone();

//                         match self.load_vector(reg1, base_add_reg.clone()) {
//                             Err(e) => return Err(e.to_string()),
//                             _ => (),
//                         }
//                         match self.load_vector(reg2, base_add_reg.clone()) {
//                             Err(e) => return Err(e.to_string()),
//                             _ => (),
//                         }
//                         match self.load_vector(reg3, base_add_reg.clone()) {
//                             Err(e) => return Err(e.to_string()),
//                             _ => (),
//                         }
//                         match self.load_vector(reg4, base_add_reg.clone()) {
//                             Err(e) => return Err(e.to_string()),
//                             _ => (),
//                         }

//                         if let Some(reg6) = &instruction.r6 {
//                             let new_imm =
//                                 self.operand(get_register_name_string(reg6.clone()));
//                             let peeled_reg5 =
//                                 reg5.strip_prefix("[").unwrap_or(reg5).to_string();
//                             self.set_register(
//                                 peeled_reg5,
//                                 base_add_reg.kind,
//                                 base_add_reg.base,
//                                 base_add_reg.offset + new_imm.offset,
//                             );
//                         }
//                     } else {
//                         let imm = self.operand(reg3.to_string());
//                         let base_name = get_register_name_string(reg2.clone());
//                         let mut base_add_reg =
//                             self.registers[get_register_index(base_name.clone())].clone();

//                         base_add_reg.offset = base_add_reg.offset + imm.offset;
//                         let res = self.load_vector(reg1, base_add_reg.clone());
//                         match res {
//                             Err(e) => return Err(e.to_string()),
//                             _ => (),
//                         }
//                     }
//                 } else if let Some(reg3) = &instruction.r3 {
//                     if reg2.contains("}") {
//                         let base_name = get_register_name_string(reg3.clone());
//                         let base_add_reg =
//                             self.registers[get_register_index(base_name.clone())].clone();

//                         match self.load_vector(reg1, base_add_reg.clone()) {
//                             Err(e) => return Err(e.to_string()),
//                             _ => (),
//                         }
//                         match self.load_vector(reg2, base_add_reg.clone()) {
//                             Err(e) => return Err(e.to_string()),
//                             _ => (),
//                         }
//                         if let Some(reg4) = &instruction.r4 {
//                             let new_imm =
//                                 self.operand(get_register_name_string(reg4.clone()));
//                             let peeled_reg3 =
//                                 reg3.strip_prefix("[").unwrap_or(reg3).to_string();
//                             self.set_register(
//                                 peeled_reg3,
//                                 base_add_reg.kind,
//                                 base_add_reg.base,
//                                 base_add_reg.offset + new_imm.offset,
//                             );
//                         }
//                     } else if reg3.contains("#") {
//                         let base_name = get_register_name_string(reg2.clone());
//                         let base_add_reg =
//                             self.registers[get_register_index(base_name.clone())].clone();

//                         let res = self.load_vector(reg1, base_add_reg.clone());
//                         match res {
//                             Err(e) => return Err(e.to_string()),
//                             _ => (),
//                         }

//                         //post index
//                         let imm = self.operand(reg3.to_string());
//                         self.set_register(
//                             base_name,
//                             base_add_reg.kind,
//                             base_add_reg.base,
//                             base_add_reg.offset + imm.offset,
//                         );
//                     } else {
//                         let imm = self.operand(reg3.to_string());
//                         let base_name = get_register_name_string(reg2.clone());
//                         let mut base_add_reg =
//                             self.registers[get_register_index(base_name.clone())].clone();

//                         base_add_reg.offset = base_add_reg.offset + imm.offset;
//                         let res = self.load_vector(reg1, base_add_reg.clone());
//                         match res {
//                             Err(e) => return Err(e.to_string()),
//                             _ => (),
//                         }
//                     }
//                 } else {
//                     let base_name = get_register_name_string(reg2.clone());
//                     let base_add_reg =
//                         self.registers[get_register_index(base_name.clone())].clone();
//                     let res = self.load_vector(reg1, base_add_reg.clone());
//                     match res {
//                         Err(e) => return Err(e.to_string()),
//                         _ => (),
//                     }
//                 }
//             }
//             "st1" => {
//                 let reg1 = instruction.r1.clone().expect("computer19");
//                 let reg2 = instruction.r2.clone().expect("computer20");
//                 if let Some(reg3) = instruction.r3.clone() {
//                     if reg3.contains("#") {
//                         let offset = self.operand(reg3).offset;
//                         let reg2base = get_register_name_string(reg2.clone());
//                         let mut base_add_reg =
//                             self.registers[get_register_index(reg2base.clone())].clone();
//                         base_add_reg.offset = base_add_reg.offset + offset;

//                         let res = self.store_vector(reg1, base_add_reg.clone());
//                         match res {
//                             Err(e) => return Err(e.to_string()),
//                             _ => (),
//                         }
//                     } else {
//                         let reg3base = get_register_name_string(reg3.clone());
//                         let base_add_reg =
//                             self.registers[get_register_index(reg3base.clone())].clone();

//                         let res = self.store_vector(reg1, base_add_reg.clone());
//                         match res {
//                             Err(e) => return Err(e.to_string()),
//                             _ => (),
//                         }
//                         let res = self.store_vector(reg2, base_add_reg.clone());
//                         match res {
//                             Err(e) => return Err(e.to_string()),
//                             _ => (),
//                         }
//                     }
//                 } else {
//                     let reg2base = get_register_name_string(reg2.clone());
//                     let base_add_reg =
//                         self.registers[get_register_index(reg2base.clone())].clone();

//                     let res = self.store_vector(reg1, base_add_reg.clone());
//                     match res {
//                         Err(e) => return Err(e.to_string()),
//                         _ => (),
//                     }
//                 }
//             }
//             "movi" => {
//                 let reg1 = instruction.r1.clone().expect("Need first register name");
//                 let reg2 = instruction.r2.clone().expect("Need immediate");
//                 let imm = self.operand(reg2);
//                 self.set_register(reg1, RegisterKind::Immediate, None, imm.offset);
//             }
//             "mov" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst reg");
//                 let reg2 = instruction.r2.clone().expect("Need src reg");
//                 let src = self.operand(reg2);
//                 self.set_register(reg1, src.kind, src.base, src.offset);
//             }
//             "fmov" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst reg");
//                 let reg2 = instruction.r2.clone().expect("Need src reg");
//                 let src = self.operand(reg2);
//                 self.set_register(reg1, src.kind, src.base, src.offset);
//             }
//             "shl" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let reg2 = instruction.r2.clone().expect("Need source register");
//                 let reg3 = instruction.r3.clone().expect("Need immediate");
//                 let imm = self.operand(reg3);

//                 if let Some((_, arrange)) = reg1.split_once(".") {
//                     match arrange {
//                         "2d" => {
//                             for i in 0..2 {
//                                 let (bases, offsets) = self.simd_registers
//                                     [get_register_index(reg2.clone())]
//                                 .get_double(i);
//                                 let mut offset = u64::from_be_bytes(offsets);
//                                 (offset, _) = offset.overflowing_shl(
//                                     imm.offset.try_into().expect("computer21"),
//                                 );
//                                 // TODO: figure out best way to modify bases
//                                 let dest = &mut self.simd_registers
//                                     [get_register_index(reg1.clone())];
//                                 dest.set_double(i, bases, offset.to_be_bytes());
//                             }
//                         }
//                         _ => todo!("unsupported shl vector type"),
//                     }
//                 }
//             }
//             "ushr" | "sshr" => {
//                 // FIX figure out how to do sshr over byte strings
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let reg2 = instruction.r2.clone().expect("Need source register");
//                 let reg3 = instruction.r3.clone().expect("Need immediate");
//                 let imm = self.operand(reg3);

//                 if let Some((_, arrange)) = reg1.split_once(".") {
//                     match arrange {
//                         "2d" => {
//                             for i in 0..2 {
//                                 let (bases, offsets) = self.simd_registers
//                                     [get_register_index(reg2.clone())]
//                                 .get_double(i);
//                                 let mut offset = u64::from_be_bytes(offsets);
//                                 (offset, _) = offset.overflowing_shr(
//                                     imm.offset.try_into().expect("computer22"),
//                                 );
//                                 // TODO: figure out best way to modify bases
//                                 let dest = &mut self.simd_registers
//                                     [get_register_index(reg1.clone())];
//                                 dest.set_double(i, bases, offset.to_be_bytes());
//                             }
//                         }
//                         "4s" => {
//                             for i in 0..4 {
//                                 let (bases, offsets) = self.simd_registers
//                                     [get_register_index(reg2.clone())]
//                                 .get_word(i);
//                                 let mut offset = u32::from_be_bytes(offsets);
//                                 (offset, _) = offset.overflowing_shr(
//                                     imm.offset.try_into().expect("computer23"),
//                                 );
//                                 // TODO: figure out best way to modify bases
//                                 let dest = &mut self.simd_registers
//                                     [get_register_index(reg1.clone())];
//                                 dest.set_word(i, bases, offset.to_be_bytes());
//                             }
//                         }
//                         _ => todo!("unsupported ushr vector type"),
//                     }
//                 }
//             }
//             "ext" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let reg2 = instruction.r2.clone().expect("Need source register");
//                 let reg3 = instruction.r3.clone().expect("Need immediate");
//                 let reg4 = instruction.r4.clone().expect("Need immediate");
//                 let imm = self.operand(reg4);

//                 if let Some((_, arrange)) = reg1.split_once(".") {
//                     match arrange {
//                         "8b" => {
//                             let amt = imm.offset as usize;
//                             assert!(amt < 8);
//                             for i in 0..amt {
//                                 let (base, offset) = self.simd_registers
//                                     [get_register_index(reg2.clone())]
//                                 .get_byte(i);
//                                 let dest = &mut self.simd_registers
//                                     [get_register_index(reg1.clone())];
//                                 dest.set_byte(i, base.clone(), offset);
//                             }
//                             for i in amt..8 {
//                                 let (base, offset) = self.simd_registers
//                                     [get_register_index(reg3.clone())]
//                                 .get_byte(i);
//                                 let dest = &mut self.simd_registers
//                                     [get_register_index(reg1.clone())];
//                                 dest.set_byte(i, base.clone(), offset);
//                             }
//                         }
//                         "16b" => {
//                             let amt = imm.offset as usize;
//                             assert!(amt < 16);
//                             for i in 0..amt {
//                                 let (base, offset) = self.simd_registers
//                                     [get_register_index(reg2.clone())]
//                                 .get_byte(i);
//                                 let dest = &mut self.simd_registers
//                                     [get_register_index(reg1.clone())];
//                                 dest.set_byte(i, base.clone(), offset);
//                             }
//                             for i in amt..16 {
//                                 let (base, offset) = self.simd_registers
//                                     [get_register_index(reg3.clone())]
//                                 .get_byte(i);
//                                 let dest = &mut self.simd_registers
//                                     [get_register_index(reg1.clone())];
//                                 dest.set_byte(i, base.clone(), offset);
//                             }
//                         }
//                         _ => todo!("unsupported ext vector type"),
//                     }
//                 }
//             }
//             "dup" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let mut reg2 = instruction.r2.clone().expect("Need source register");
//                 if reg2.contains("[") {
//                     let left_brac = reg2.find("[").expect("need left bracket");
//                     let right_brac = reg2.find("]").expect("need right bracket");
//                     let index_string = reg2
//                         .get((left_brac + 1)..right_brac)
//                         .expect("need brackets");
//                     let index = index_string
//                         .parse::<usize>()
//                         .expect("index into vector must be an integer");

//                     reg2 = reg2.split_at(left_brac).0.to_string();
//                     if let Some((vector1, arrangement1)) = reg1.split_once(".") {
//                         if let Some((vector2, arrangement2)) = reg2.split_once(".") {
//                             assert!(arrangement1.contains(arrangement2));
//                             let src = self.simd_registers
//                                 [get_register_index(vector2.to_string())]
//                             .clone();
//                             let dest = &mut self.simd_registers
//                                 [get_register_index(vector1.to_string())];

//                             match arrangement2 {
//                                 "b" => {
//                                     let elem = src.get_byte(index);
//                                     for i in 0..16 {
//                                         dest.set_byte(i, elem.0.clone(), elem.1);
//                                     }
//                                 }
//                                 "h" => {
//                                     let elem = src.get_halfword(index);
//                                     for i in 0..8 {
//                                         dest.set_halfword(i, elem.0.clone(), elem.1);
//                                     }
//                                 }
//                                 "s" => {
//                                     let elem = src.get_word(index);
//                                     for i in 0..4 {
//                                         dest.set_word(i, elem.0.clone(), elem.1);
//                                     }
//                                 }
//                                 "d" => {
//                                     let elem = src.get_double(index);
//                                     for i in 0..2 {
//                                         dest.set_double(i, elem.0.clone(), elem.1);
//                                     }
//                                 }
//                                 _ => log::error!(
//                                     "Not a valid vector arrangement {:?}",
//                                     arrangement1
//                                 ),
//                             }
//                         }
//                     };
//                 } else {
//                     if let Some((vector1, arrangement1)) = reg1.split_once(".") {
//                         let dest = &mut self.simd_registers
//                             [get_register_index(vector1.to_string())];
//                         let src = &mut self.registers[get_register_index(reg2)];

//                         dest.set_register(
//                             arrangement1.to_string(),
//                             src.kind.clone(),
//                             src.base.clone(),
//                             src.offset as u128,
//                         );
//                     };
//                 }
//             }
//             "and" => {
//                 self.vector_arithmetic(
//                     "&",
//                     &|x, y| x & y,
//                     &|x, y| x & y,
//                     &|x, y| x & y,
//                     &|x, y| x & y,
//                     instruction,
//                 );
//             }
//             "add" => {
//                 self.vector_arithmetic(
//                     "+",
//                     &|x, y| x + y,
//                     &|x, y| x + y,
//                     &|x, y| x + y,
//                     &|x, y| x + y,
//                     instruction,
//                 );
//             }
//             "orr" => {
//                 self.vector_arithmetic(
//                     "|",
//                     &|x, y| x | y,
//                     &|x, y| x | y,
//                     &|x, y| x | y,
//                     &|x, y| x | y,
//                     instruction,
//                 );
//             }
//             "eor" => {
//                 self.vector_arithmetic(
//                     "^",
//                     &|x, y| x ^ y,
//                     &|x, y| x ^ y,
//                     &|x, y| x ^ y,
//                     &|x, y| x ^ y,
//                     instruction,
//                 );
//             }
//             "mul" => {
//                 self.vector_arithmetic(
//                     "*",
//                     &|x, y| x * y,
//                     &|x, y| x * y,
//                     &|x, y| x * y,
//                     &|x, y| x * y,
//                     instruction,
//                 );
//             }
//             "sub" => {
//                 self.vector_arithmetic(
//                     "-",
//                     &|x, y| x - y,
//                     &|x, y| x - y,
//                     &|x, y| x - y,
//                     &|x, y| x - y,
//                     instruction,
//                 );
//             }
//             "rev64" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let reg2 = instruction.r2.clone().expect("Need source register");

//                 let src = &self.simd_registers[get_register_index(reg2.clone())].clone();
//                 let dest = &mut self.simd_registers[get_register_index(reg1.clone())];

//                 dest.kind = src.kind.clone();
//                 for i in 0..16 {
//                     let (base, offset) = src.get_byte(15 - i);
//                     dest.set_byte(i, base, offset);
//                 }
//             }
//             "rev32" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let reg2 = instruction.r2.clone().expect("Need source register");

//                 let src = &self.simd_registers[get_register_index(reg2.clone())].clone();
//                 let dest = &mut self.simd_registers[get_register_index(reg1.clone())];

//                 dest.kind = src.kind.clone();
//                 for i in 0..8 {
//                     let (base, offset) = src.get_byte(7 - i);
//                     dest.set_byte(i, base, offset);
//                 }

//                 for i in 8..16 {
//                     let (base, offset) = src.get_byte(15 - i);
//                     dest.set_byte(i, base, offset);
//                 }
//             }
//             "ins" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let mut reg2 = instruction.r2.clone().expect("Need source register");

//                 // vector, element
//                 if reg2.contains("v") {
//                     let left_brac = reg2.find("[").expect("need left bracket");
//                     let right_brac = reg2.find("]").expect("need right bracket");
//                     let index_string = reg2
//                         .get((left_brac + 1)..right_brac)
//                         .expect("need brackets");
//                     let index = index_string
//                         .parse::<usize>()
//                         .expect("index into vector must be an integer");

//                     reg2 = reg2.split_at(left_brac).0.to_string();
//                     if let Some((vector1, arrangement1)) = reg1.split_once(".") {
//                         if let Some((vector2, arrangement2)) = reg2.split_once(".") {
//                             assert!(arrangement1.contains(arrangement2));
//                             let src = self.simd_registers
//                                 [get_register_index(vector2.to_string())]
//                             .clone();
//                             let dest = &mut self.simd_registers
//                                 [get_register_index(vector1.to_string())];

//                             match arrangement2 {
//                                 "b" => {
//                                     let (base, offset) = src.get_byte(index);
//                                     dest.set_byte(index, base, offset);
//                                 }
//                                 "h" => {
//                                     let (base, offset) = src.get_halfword(index);
//                                     dest.set_halfword(index, base, offset);
//                                 }
//                                 "s" => {
//                                     let (base, offset) = src.get_word(index);
//                                     dest.set_word(index, base, offset);
//                                 }
//                                 "d" => {
//                                     let (base, offset) = src.get_double(index);
//                                     dest.set_double(index, base, offset);
//                                 }
//                                 _ => log::error!(
//                                     "Not a valid vector arrangement {:?}",
//                                     arrangement1
//                                 ),
//                             }
//                         }
//                     }
//                 // vector, general
//                 } else {
//                     todo!("vector general ins unsupported");
//                 }
//             }
//             "pmull" | "pmull2" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let reg2 = instruction.r2.clone().expect("Need first source register");
//                 let reg3 = instruction.r3.clone().expect("Need second source register");

//                 if let Some((vector1, _)) = reg1.split_once(".") {
//                     if let Some((vector2, arrangement2)) = reg2.split_once(".") {
//                         if let Some((vector3, arrangement3)) = reg3.split_once(".") {
//                             assert_eq!(arrangement2, arrangement3);

//                             let src1 = self.simd_registers
//                                 [get_register_index(vector2.to_string())]
//                             .clone();
//                             let src2 = self.simd_registers
//                                 [get_register_index(vector3.to_string())]
//                             .clone();
//                             let dest = &mut self.simd_registers
//                                 [get_register_index(vector1.to_string())];

//                             match arrangement2 {
//                                 "8b" => {
//                                     for i in 0..8 {
//                                         let base = generate_expression_from_options(
//                                             "*",
//                                             src1.get_byte(i).0,
//                                             src2.get_byte(i).0,
//                                         );
//                                         let offset =
//                                             src1.get_byte(i).1 * src2.get_byte(i).1;

//                                         dest.set_byte(i, base, offset);
//                                     }
//                                 }
//                                 "4h" => {
//                                     for i in 0..8 {
//                                         let (bases1, offsets1) = self.simd_registers
//                                             [get_register_index(reg2.clone())]
//                                         .get_halfword(i);

//                                         let (bases2, offsets2) = self.simd_registers
//                                             [get_register_index(reg3.clone())]
//                                         .get_halfword(i);
//                                         let a = u16::from_be_bytes(offsets1);
//                                         let b = u16::from_be_bytes(offsets2);
//                                         let offset = a * b;

//                                         let mut new_bases = [BASE_INIT; 2];
//                                         for i in 0..2 {
//                                             new_bases[i] = generate_expression_from_options(
//                                                 "*",
//                                                 bases1[i].clone(),
//                                                 bases2[i].clone(),
//                                             );
//                                         }

//                                         let dest = &mut self.simd_registers
//                                             [get_register_index(reg1.clone())];
//                                         dest.set_halfword(
//                                             i,
//                                             new_bases,
//                                             offset.to_be_bytes(),
//                                         );
//                                     }
//                                 }
//                                 _ => todo!("pmull unsupported vector access"),
//                             }
//                         }
//                     }
//                 }
//             }
//             "zip1" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let reg2 = instruction.r2.clone().expect("Need first source register");
//                 let reg3 = instruction.r3.clone().expect("Need second source register");

//                 if let Some((vector1, _)) = reg1.split_once(".") {
//                     if let Some((vector2, arrangement2)) = reg2.split_once(".") {
//                         if let Some((vector3, arrangement3)) = reg3.split_once(".") {
//                             assert_eq!(arrangement2, arrangement3);

//                             let src1 = self.simd_registers
//                                 [get_register_index(vector2.to_string())]
//                             .clone();
//                             let src2 = self.simd_registers
//                                 [get_register_index(vector3.to_string())]
//                             .clone();
//                             let dest = &mut self.simd_registers
//                                 [get_register_index(vector1.to_string())];

//                             match arrangement2 {
//                                 "2d" => {
//                                     let elem = src1.get_double(0);
//                                     dest.set_double(0, elem.0, elem.1);

//                                     let elem = src2.get_double(0);
//                                     dest.set_double(1, elem.0, elem.1);
//                                 }
//                                 "16b" => {
//                                     for i in 0..16 {
//                                         if i % 2 == 0 {
//                                             let elem = src1.get_byte(0);
//                                             dest.set_byte(i, elem.0, elem.1);
//                                         } else {
//                                             let elem = src2.get_byte(0);
//                                             dest.set_byte(i, elem.0, elem.1);
//                                         }
//                                     }
//                                 }
//                                 _ => todo!("zip1 unsupported vector access"),
//                             }
//                         }
//                     }
//                 }
//             }
//             "zip2" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let reg2 = instruction.r2.clone().expect("Need first source register");
//                 let reg3 = instruction.r3.clone().expect("Need second source register");

//                 if let Some((vector1, _)) = reg1.split_once(".") {
//                     if let Some((vector2, arrangement2)) = reg2.split_once(".") {
//                         if let Some((vector3, arrangement3)) = reg3.split_once(".") {
//                             assert_eq!(arrangement2, arrangement3);

//                             let src1 = self.simd_registers
//                                 [get_register_index(vector2.to_string())]
//                             .clone();
//                             let src2 = self.simd_registers
//                                 [get_register_index(vector3.to_string())]
//                             .clone();
//                             let dest = &mut self.simd_registers
//                                 [get_register_index(vector1.to_string())];

//                             match arrangement2 {
//                                 "2d" => {
//                                     let elem = src1.get_double(1);
//                                     dest.set_double(0, elem.0, elem.1);

//                                     let elem = src2.get_double(1);
//                                     dest.set_double(1, elem.0, elem.1);
//                                 }
//                                 "16b" => {
//                                     //FIX
//                                     for i in 0..16 {
//                                         if i % 2 == 1 {
//                                             let elem = src1.get_byte(0);
//                                             dest.set_byte(i, elem.0, elem.1);
//                                         } else {
//                                             let elem = src2.get_byte(0);
//                                             dest.set_byte(i, elem.0, elem.1);
//                                         }
//                                     }
//                                 }
//                                 _ => todo!("zip2 unsupported vector access"),
//                             }
//                         }
//                     }
//                 }
//             }
//             "aese" | "aesmc" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let reg2 = instruction.r2.clone().expect("Need first source register");

//                 let src = &self.simd_registers[get_register_index(reg2.clone())].clone();
//                 let dest = &mut self.simd_registers[get_register_index(reg1.clone())];

//                 match (src.kind.clone(), dest.kind.clone()) {
//                     (RegisterKind::Number, RegisterKind::Number) => {
//                         // don't need to do anything
//                         ()
//                     }
//                     _ => todo!(),
//                 }
//             }
//             "trn1" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let reg2 = instruction.r2.clone().expect("Need first source register");
//                 let reg3 = instruction.r3.clone().expect("Need second source register");

//                 if let Some((vector1, _)) = reg1.split_once(".") {
//                     if let Some((vector2, arrangement2)) = reg2.split_once(".") {
//                         if let Some((vector3, arrangement3)) = reg3.split_once(".") {
//                             assert_eq!(arrangement2, arrangement3);

//                             let src1 = self.simd_registers
//                                 [get_register_index(vector2.to_string())]
//                             .clone();
//                             let src2 = self.simd_registers
//                                 [get_register_index(vector3.to_string())]
//                             .clone();
//                             let dest = &mut self.simd_registers
//                                 [get_register_index(vector1.to_string())];

//                             match arrangement2 {
//                                 "2d" => {
//                                     let elem = src1.get_double(0);
//                                     dest.set_double(0, elem.0, elem.1);

//                                     let elem = src2.get_double(0);
//                                     dest.set_double(1, elem.0, elem.1);
//                                 }
//                                 _ => todo!("trn1 unsupported vector access"),
//                             }
//                         }
//                     }
//                 }
//             }
//             "trn2" => {
//                 let reg1 = instruction.r1.clone().expect("Need dst register");
//                 let reg2 = instruction.r2.clone().expect("Need first source register");
//                 let reg3 = instruction.r3.clone().expect("Need second source register");

//                 if let Some((vector1, _)) = reg1.split_once(".") {
//                     if let Some((vector2, arrangement2)) = reg2.split_once(".") {
//                         if let Some((vector3, arrangement3)) = reg3.split_once(".") {
//                             assert_eq!(arrangement2, arrangement3);

//                             let src1 = self.simd_registers
//                                 [get_register_index(vector2.to_string())]
//                             .clone();
//                             let src2 = self.simd_registers
//                                 [get_register_index(vector3.to_string())]
//                             .clone();
//                             let dest = &mut self.simd_registers
//                                 [get_register_index(vector1.to_string())];

//                             match arrangement2 {
//                                 "2d" => {
//                                     let elem = src1.get_double(1);
//                                     dest.set_double(0, elem.0, elem.1);

//                                     let elem = src2.get_double(1);
//                                     dest.set_double(1, elem.0, elem.1);
//                                 }
//                                 _ => todo!("trn2 unsupported vector access"),
//                             }
//                         }
//                     }
//                 }
//             }
//             "ld1r" => {
//                 let dst = instruction.r1.clone().expect("need dst ld1r");
//                 let src = instruction.r2.clone().expect("need src ld1r");

//                 let address = self.registers[get_register_index(src.clone())].clone();
//                 let _ = self.load(dst, address);
//             }
//             "bit" | "uaddl" | "uaddl2" | "sqrshrun" | "sqrshrun2" | "umull" | "umull2"
//             | "umlal" | "umlal2" | "rshrn" | "rshrn2" => {
//                 let dest = instruction.r1.clone().expect("need dest");
//                 let reg = &mut self.simd_registers[get_register_index(dest.to_string())];
//                 reg.set(
//                     "16b".to_string(),
//                     RegisterKind::Number,
//                     [BASE_INIT; 16],
//                     [0; 16],
//                 );
//             }
//             _ => {
//                 log::warn!("SIMD instruction not supported {:?}", instruction);
//                 todo!("unsupported vector operation {:?}", instruction);
//             }
//         }
//     }
