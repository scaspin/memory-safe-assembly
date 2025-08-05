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
        // if let Some((_, arrange)) = reg1.split_once(".") {
        //
        // }
    }
}
