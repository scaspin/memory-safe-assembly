use crate::computer::*;

impl ARMCORTEXA {
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

        let mut result = self.get_simd_register(reg0);
        let r0 = &mut result;
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

        self.set_simd_register(reg0, result);
    }
}

pub enum LaneEffect {
    Vectors(Vec<(usize, [u8; 16], Option<u64>)>),
    General(Operand, u64),
    Nothing,
}

fn vector_index(operand: &Operand) -> Option<usize> {
    match operand {
        Operand::Vector(_, n, _)
        | Operand::VectorRegister(_, n)
        | Operand::VectorAccess(_, n, _, _) => Some(*n),
        _ => None,
    }
}

fn lane_max(bytes: &[u8; 16], lane: usize, width: usize) -> u64 {
    (0..width).fold(0u64, |value, k| {
        value | (u64::from(bytes[lane * width + k]) << (8 * k))
    })
}

fn truncated(value: i64, width: usize) -> [u8; 16] {
    let mut bytes = [0u8; 16];
    let le = value.to_le_bytes();
    let kept = width.min(8);
    bytes[..kept].copy_from_slice(&le[..kept]);
    bytes
}

impl ARMCORTEXA {
    fn immediate_of(&mut self, operand: &Operand) -> Option<i64> {
        let value = self.get_register(operand);
        (value.kind == RegisterKind::Immediate && value.base.is_none()).then_some(value.offset)
    }

    pub fn plan_lane_effect(&mut self, instruction: &Instruction) -> LaneEffect {
        let operands = &instruction.operands;
        let opcode = instruction.opcode.as_str();
        let bounds = (*self.lane_bounds).clone();
        if opcode.starts_with("st") {
            return LaneEffect::Nothing;
        }
        if opcode.starts_with("ld") {
            let written = operands
                .iter()
                .filter(|op| !matches!(op, Operand::Memory(..)))
                .filter_map(vector_index)
                .map(|n| (n, [u8::MAX; 16], None))
                .collect();
            return LaneEffect::Vectors(written);
        }
        let Some(first) = operands.first() else {
            return LaneEffect::Nothing;
        };
        if let Some(source) = operands.get(1).and_then(vector_index)
            && matches!(opcode, "fmov" | "umov" | "mov")
            && matches!(first, Operand::Register(..))
        {
            let bound = match operands.get(1) {
                Some(Operand::VectorAccess(_, _, arrangement, lane)) => {
                    let width = arrangement.element_width() as usize;
                    Some(lane_max(&bounds.bytes[source], *lane as usize, width))
                }
                _ => bounds.scalar[source],
            };
            return match bound {
                Some(bound) => LaneEffect::General(first.clone(), bound),
                None => LaneEffect::Nothing,
            };
        }
        let Some(dst) = vector_index(first) else {
            return LaneEffect::Nothing;
        };
        let unknown = LaneEffect::Vectors(vec![(dst, [u8::MAX; 16], None)]);
        match (opcode, operands.as_slice()) {
            (
                "mov" | "ins",
                [
                    Operand::VectorAccess(_, _, arrangement, lane),
                    source @ Operand::Register(..),
                ],
            ) => {
                let width = arrangement.element_width() as usize;
                let mut bytes = bounds.bytes[dst];
                let value = self
                    .immediate_of(source)
                    .map_or([u8::MAX; 16], |v| truncated(v, width));
                let start = *lane as usize * width;
                bytes[start..start + width].copy_from_slice(&value[..width]);
                LaneEffect::Vectors(vec![(dst, bytes, None)])
            }
            (
                "dup",
                [
                    Operand::Vector(_, _, arrangement),
                    source @ Operand::Register(..),
                ],
            ) => {
                let width = arrangement.element_width() as usize;
                match self.immediate_of(source) {
                    Some(v) => {
                        let lane = truncated(v, width);
                        let mut bytes = [0u8; 16];
                        for (k, byte) in bytes
                            .iter_mut()
                            .enumerate()
                            .take(arrangement.width() as usize)
                        {
                            *byte = lane[k % width];
                        }
                        LaneEffect::Vectors(vec![(dst, bytes, None)])
                    }
                    None => unknown,
                }
            }
            ("eor", [_, Operand::Vector(_, a, _), Operand::Vector(_, b, _)]) if a == b => {
                LaneEffect::Vectors(vec![(dst, [0u8; 16], None)])
            }
            (
                "and",
                [
                    Operand::Vector(_, _, arrangement),
                    Operand::Vector(_, a, _),
                    Operand::Vector(_, b, _),
                ],
            ) => {
                let mut bytes = [0u8; 16];
                for (k, byte) in bytes
                    .iter_mut()
                    .enumerate()
                    .take(arrangement.width() as usize)
                {
                    *byte = bounds.bytes[*a][k].min(bounds.bytes[*b][k]);
                }
                LaneEffect::Vectors(vec![(dst, bytes, None)])
            }
            ("cnt", [Operand::Vector(_, _, arrangement), Operand::Vector(..)]) => {
                let mut bytes = [0u8; 16];
                for byte in bytes.iter_mut().take(arrangement.width() as usize) {
                    *byte = 8;
                }
                LaneEffect::Vectors(vec![(dst, bytes, None)])
            }
            ("uaddlv", [_, Operand::Vector(_, source, arrangement)]) => {
                let width = arrangement.element_width() as usize;
                let lanes = arrangement.width() as usize / width;
                let sum = (0..lanes)
                    .map(|lane| lane_max(&bounds.bytes[*source], lane, width))
                    .sum();
                LaneEffect::Vectors(vec![(dst, [u8::MAX; 16], Some(sum))])
            }
            _ => unknown,
        }
    }

    pub fn apply_lane_effect(&mut self, effect: LaneEffect) {
        match effect {
            LaneEffect::Vectors(written) => {
                for (n, bytes, scalar) in written {
                    self.lane_bounds.bytes[n] = bytes;
                    self.lane_bounds.scalar[n] = scalar;
                }
            }
            LaneEffect::General(register, bound) => {
                let name = format!("lane_value_{}", self.next_carry());
                let value = ast::Int::new_const(name.clone());
                self.solver.assert(value.ge(ast::Int::from_i64(0)));
                self.solver.assert(value.le(ast::Int::from_u64(bound)));
                self.set_register(
                    &register,
                    RegisterKind::RegisterBase,
                    Some(AbstractExpression::Abstract(name)),
                    0,
                );
            }
            LaneEffect::Nothing => {}
        }
    }
}
