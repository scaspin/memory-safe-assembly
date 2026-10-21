use crate::computer::*;

pub fn arrangement_of(operand: &Operand) -> Option<Arrangement> {
    match operand {
        Operand::Vector(_, _, arrangement) => Some(arrangement.clone()),
        Operand::VectorAccess(_, _, element, _) => Some(element.clone()),
        _ => None,
    }
}

fn combine_bases(
    op_string: &str,
    left: &[Option<AbstractExpression>],
    right: &[Option<AbstractExpression>],
) -> Vec<Option<AbstractExpression>> {
    left.iter()
        .zip(right.iter())
        .map(|(l, r)| match (l, r) {
            (Some(_), Some(_)) => generate_expression_from_options(op_string, l.clone(), r.clone()),
            _ => None,
        })
        .collect()
}

pub fn is_vector_operand(operand: &Operand) -> bool {
    matches!(
        operand,
        Operand::Vector(..) | Operand::VectorRegister(..) | Operand::VectorAccess(..)
    )
}

pub fn range_fits_lane(range: (i64, i64), lane_bytes: usize) -> Option<(i64, i64)> {
    if lane_bytes == 0 || lane_bytes > 8 {
        return None;
    }
    let limit = 1i64 << (8 * lane_bytes - 1);
    if range.0 >= -limit && range.1 < limit && range.0 <= range.1 {
        Some(range)
    } else {
        None
    }
}

fn mask_to_lane(value: u128, lane_bytes: usize) -> u128 {
    if lane_bytes >= 16 {
        value
    } else {
        value & ((1u128 << (8 * lane_bytes)) - 1)
    }
}

pub fn vector_access_width(operand: &Operand) -> usize {
    match operand {
        Operand::Vector(_, _, arrangement) => arrangement.bytes(),
        Operand::VectorAccess(_, _, element, _) => element.lane_bytes(),
        Operand::VectorRegister(..) => 16,
        _ => 8,
    }
}

pub fn split_vector_operands(instruction: &Instruction) -> (Vec<Operand>, Option<&Operand>) {
    let mut registers = Vec::new();
    let mut address = None;
    for operand in instruction.operands.iter() {
        match operand {
            Operand::Vector(..) | Operand::VectorRegister(..) | Operand::VectorAccess(..) => {
                registers.push(operand.clone())
            }
            Operand::Memory(..) => address = Some(operand),
            _ => (),
        }
    }
    (registers, address)
}

impl ARMCORTEXA {
    pub fn apply_writeback(
        &mut self,
        prefix: &RePrefix,
        num: usize,
        address: &RegisterValue,
        offset: &Option<i64>,
        register_offset: &Option<Box<Operand>>,
        indexing: &Option<bool>,
    ) {
        let target = Operand::Register(prefix.clone(), num);

        if let Some(register) = register_offset {
            self.arithmetic(
                "+",
                |x, y| x + y,
                vec![target.clone(), target, (**register).clone()],
            );
            return;
        }

        if *indexing == Some(true)
            && let Some(step) = offset
        {
            self.set_register(
                &target,
                address.kind.clone(),
                address.base.clone(),
                address.offset + step,
            );
        }
    }

    pub fn vector_arithmetic(
        &mut self,
        op_string: &str,
        op: impl Fn(u128, u128) -> u128,
        instruction: &Instruction,
    ) {
        let mut reg_iter = instruction.operands.iter();

        let reg0 = reg_iter.next().expect("Need destination register");
        let is_vector = |o: &Operand| {
            matches!(
                o,
                Operand::Vector(..) | Operand::VectorRegister(..) | Operand::VectorAccess(..)
            )
        };
        let (Some(reg1), Some(reg2)) = (reg_iter.next(), reg_iter.next()) else {
            self.vector_unknown(reg0);
            return;
        };
        if !is_vector(reg1) || !is_vector(reg2) {
            self.vector_unknown(reg0);
            return;
        }

        let Some(arrangement) = arrangement_of(reg0) else {
            let mut dst = self.get_simd_register(reg0);
            dst.set_unknown();
            self.set_simd_register(reg0, dst);
            return;
        };

        let src1 = self.get_simd_register(reg1);
        let src2 = self.get_simd_register(reg2);
        let mut dst = self.get_simd_register(reg0);

        let lane_bytes = arrangement.lane_bytes();
        for lane in 0..arrangement.lanes() {
            let (bases1, value1) = src1.get_lane(&arrangement, lane);
            let (bases2, value2) = src2.get_lane(&arrangement, lane);

            let value = mask_to_lane(op(value1, value2), lane_bytes);
            let bases = combine_bases(op_string, &bases1, &bases2);

            dst.set_lane(&arrangement, lane, bases, value);
        }

        self.set_simd_register(reg0, dst);
    }

    pub fn vector_broadcast(
        &mut self,
        dst_operand: &Operand,
        arrangement: &Arrangement,
        bases: Vec<Option<AbstractExpression>>,
        value: u128,
        kind: RegisterKind,
    ) {
        let mut dst = self.get_simd_register(dst_operand);
        dst.kind = kind;
        dst.base = [BASE_INIT; 16];
        dst.offset = [0; 16];
        for lane in 0..arrangement.lanes() {
            dst.set_lane(arrangement, lane, bases.clone(), value);
        }
        self.set_simd_register(dst_operand, dst);
    }

    pub fn vector_permute(
        &mut self,
        dst_operand: &Operand,
        src_operand: &Operand,
        arrangement: &Arrangement,
        source_lane: impl Fn(usize) -> usize,
    ) {
        let src = self.get_simd_register(src_operand);
        let mut dst = self.get_simd_register(dst_operand);
        dst.kind = src.kind.clone();

        for lane in 0..arrangement.lanes() {
            let (bases, value) = src.get_lane(arrangement, source_lane(lane));
            dst.set_lane(arrangement, lane, bases, value);
        }

        self.set_simd_register(dst_operand, dst);
    }

    pub fn vector_widening_add(
        &mut self,
        op_string: &str,
        instruction: &Instruction,
    ) -> Result<(), String> {
        let mut reg_iter = instruction.operands.iter();

        let reg0 = reg_iter.next().expect("Need destination register");
        let reg1 = reg_iter.next().expect("Need first source register");
        let reg2 = reg_iter.next().expect("Need second source register");

        let Some(wide) = arrangement_of(reg0) else {
            return Err("widening add without an arrangement".to_string());
        };
        let narrow = match wide {
            Arrangement::H8 | Arrangement::H4 => Arrangement::B8,
            Arrangement::S4 | Arrangement::S2 => Arrangement::H4,
            Arrangement::D2 => Arrangement::S2,
            _ => return Err(format!("no narrower arrangement for {:?}", wide)),
        };

        let src1 = self.get_simd_register(reg1);
        let src2 = self.get_simd_register(reg2);
        let mut dst = self.get_simd_register(reg0);

        let lane_bytes = wide.lane_bytes();
        for lane in 0..wide.lanes() {
            let (bases1, value1) = src1.get_lane(&wide, lane);
            let (bases2, value2) = src2.get_lane(&narrow, lane);

            let value = mask_to_lane(value1.wrapping_add(value2), lane_bytes);
            let bases = if bases1.iter().all(|b| b.is_none()) && bases2.iter().all(|b| b.is_none())
            {
                vec![None; lane_bytes]
            } else {
                combine_bases(op_string, &bases1, &vec![None; lane_bytes])
            };

            dst.set_lane(&wide, lane, bases, value);
        }

        self.set_simd_register(reg0, dst);
        Ok(())
    }

    pub fn lane_range(&mut self, operand: &Operand) -> Option<(i64, i64)> {
        if !is_vector_operand(operand) {
            return None;
        }
        self.get_simd_register(operand).lane_range
    }

    pub fn set_lane_range(&mut self, operand: &Operand, range: Option<(i64, i64)>) {
        if !is_vector_operand(operand) {
            return;
        }
        let mut register = self.get_simd_register(operand);
        register.lane_range = range;
        self.set_simd_register(operand, register);
    }

    pub fn vector_unknown(&mut self, dst_operand: &Operand) {
        let mut dst = self.get_simd_register(dst_operand);
        dst.set_unknown();
        self.set_simd_register(dst_operand, dst);
    }
}

pub enum LaneEffect {
    Vectors(Vec<LaneWrite>),
    General(Operand, u64, Vec<AbstractExpression>),
    Nothing,
}

pub struct LaneWrite {
    register: usize,
    bytes: [u8; 16],
    scalar: Option<u64>,
    maxima: Vec<AbstractExpression>,
}

fn lanes_bounded_by(register: usize, bytes: [u8; 16]) -> LaneWrite {
    LaneWrite {
        register,
        bytes,
        scalar: None,
        maxima: Vec::new(),
    }
}

pub fn vector_index(operand: &Operand) -> Option<usize> {
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
                .map(|n| lanes_bounded_by(n, [u8::MAX; 16]))
                .collect();
            return LaneEffect::Vectors(written);
        }
        let Some(first) = operands.first() else {
            return LaneEffect::Nothing;
        };
        if let Some(source) = operands.get(1).and_then(vector_index)
            && matches!(opcode, "fmov" | "mov")
            && matches!(first, Operand::Register(..))
        {
            let maxima = bounds.maxima[source].clone();
            let bound = match operands.get(1) {
                Some(Operand::VectorAccess(_, _, arrangement, lane)) => {
                    let width = arrangement.element_width() as usize;
                    Some(lane_max(&bounds.bytes[source], *lane as usize, width))
                }
                _ => bounds.scalar[source],
            };
            return match bound {
                Some(bound) => LaneEffect::General(first.clone(), bound, maxima),
                None => LaneEffect::Nothing,
            };
        }
        let Some(dst) = vector_index(first) else {
            return LaneEffect::Nothing;
        };
        let unknown = LaneEffect::Vectors(vec![lanes_bounded_by(dst, [u8::MAX; 16])]);
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
                LaneEffect::Vectors(vec![lanes_bounded_by(dst, bytes)])
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
                        LaneEffect::Vectors(vec![lanes_bounded_by(dst, bytes)])
                    }
                    None => {
                        let value = self.get_register(source);
                        let whole = instruction_aux::full_value(&value);
                        if value.kind == RegisterKind::RegisterBase
                            && self.fits_unsigned(&whole, 8 * width as u32)
                        {
                            LaneEffect::Vectors(vec![LaneWrite {
                                maxima: vec![whole],
                                ..lanes_bounded_by(dst, [u8::MAX; 16])
                            }])
                        } else {
                            unknown
                        }
                    }
                }
            }
            (
                "umin",
                [
                    Operand::Vector(_, _, arrangement),
                    Operand::Vector(_, a, _),
                    Operand::Vector(_, b, _),
                ],
            ) => {
                let width = arrangement.element_width() as usize;
                let lanes = arrangement.width() as usize / width;
                let mut bytes = [u8::MAX; 16];
                for lane in 0..lanes {
                    let smaller = if lane_max(&bounds.bytes[*a], lane, width)
                        <= lane_max(&bounds.bytes[*b], lane, width)
                    {
                        *a
                    } else {
                        *b
                    };
                    let range = lane * width..(lane + 1) * width;
                    bytes[range.clone()].copy_from_slice(&bounds.bytes[smaller][range]);
                }
                let maxima = bounds.maxima[*a]
                    .iter()
                    .chain(&bounds.maxima[*b])
                    .cloned()
                    .collect();
                LaneEffect::Vectors(vec![LaneWrite {
                    maxima,
                    ..lanes_bounded_by(dst, bytes)
                }])
            }
            ("eor", [_, Operand::Vector(_, a, _), Operand::Vector(_, b, _)]) if a == b => {
                LaneEffect::Vectors(vec![lanes_bounded_by(dst, [0u8; 16])])
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
                LaneEffect::Vectors(vec![lanes_bounded_by(dst, bytes)])
            }
            ("cnt", [Operand::Vector(_, _, arrangement), Operand::Vector(..)]) => {
                let mut bytes = [0u8; 16];
                for byte in bytes.iter_mut().take(arrangement.width() as usize) {
                    *byte = 8;
                }
                LaneEffect::Vectors(vec![lanes_bounded_by(dst, bytes)])
            }
            ("uaddlv", [_, Operand::Vector(_, source, arrangement)]) => {
                let width = arrangement.element_width() as usize;
                let lanes = arrangement.width() as usize / width;
                let sum = (0..lanes)
                    .map(|lane| lane_max(&bounds.bytes[*source], lane, width))
                    .sum();
                LaneEffect::Vectors(vec![LaneWrite {
                    scalar: Some(sum),
                    ..lanes_bounded_by(dst, [u8::MAX; 16])
                }])
            }
            _ => unknown,
        }
    }

    pub fn apply_lane_effect(&mut self, effect: LaneEffect) {
        match effect {
            LaneEffect::Vectors(written) => {
                for write in written {
                    self.lane_bounds.bytes[write.register] = write.bytes;
                    self.lane_bounds.scalar[write.register] = write.scalar;
                    self.lane_bounds.maxima[write.register] = write.maxima;
                }
            }
            LaneEffect::General(register, bound, maxima) => {
                let name = format!("lane_value_{}", self.next_carry());
                let value = ast::Int::new_const(name.clone());
                self.solver.assert(value.ge(ast::Int::from_i64(0)));
                self.solver.assert(value.le(ast::Int::from_u64(bound)));
                let bounded = maxima
                    .into_iter()
                    .fold(AbstractExpression::Abstract(name), |value, maximum| {
                        generate_expression("atmost", value, maximum)
                    });
                self.set_register(&register, RegisterKind::RegisterBase, Some(bounded), 0);
            }
            LaneEffect::Nothing => {}
        }
    }
}
