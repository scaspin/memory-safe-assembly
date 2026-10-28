use crate::computer::*;

const REGISTER_BYTES: usize = 16;

#[derive(Debug, Clone, PartialEq)]
pub struct ExactLanes {
    pub bytes: usize,
    pub values: Vec<AbstractExpression>,
}

fn modulus(bytes: usize) -> AbstractExpression {
    AbstractExpression::Immediate(1i64 << (8 * bytes))
}

fn wrapped(value: AbstractExpression, bytes: usize) -> AbstractExpression {
    if bytes >= 8 {
        generate_expression("zext", value, AbstractExpression::Immediate(64))
    } else {
        generate_expression("%", value, modulus(bytes))
    }
}

fn signed(value: AbstractExpression, bytes: usize) -> AbstractExpression {
    generate_expression(
        "sext",
        value,
        AbstractExpression::Immediate(8 * bytes as i64),
    )
}

impl ExactLanes {
    fn filled(bytes: usize, written: usize, value: AbstractExpression) -> Option<ExactLanes> {
        if !matches!(bytes, 1 | 2 | 4 | 8)
            || !written.is_multiple_of(bytes)
            || written > REGISTER_BYTES
        {
            return None;
        }
        let zero = AbstractExpression::Immediate(0);
        Some(ExactLanes {
            bytes,
            values: (0..REGISTER_BYTES / bytes)
                .map(|lane| {
                    if lane < written / bytes {
                        value.clone()
                    } else {
                        zero.clone()
                    }
                })
                .collect(),
        })
    }

    fn from_values(bytes: usize, values: Vec<AbstractExpression>) -> Option<ExactLanes> {
        if !matches!(bytes, 1 | 2 | 4 | 8) || values.len() * bytes > REGISTER_BYTES {
            return None;
        }
        let mut values = values;
        values.resize(REGISTER_BYTES / bytes, AbstractExpression::Immediate(0));
        Some(ExactLanes { bytes, values })
    }

    pub fn relaned(&self, bytes: usize) -> Option<ExactLanes> {
        if bytes == self.bytes {
            return Some(self.clone());
        }
        if !matches!(bytes, 1 | 2 | 4 | 8) {
            return None;
        }
        if bytes > self.bytes {
            let group = bytes / self.bytes;
            let values = self
                .values
                .chunks(group)
                .map(|parts| {
                    parts
                        .iter()
                        .enumerate()
                        .map(|(k, part)| {
                            generate_expression(
                                "*",
                                part.clone(),
                                AbstractExpression::Immediate(1i64 << (8 * self.bytes * k)),
                            )
                        })
                        .reduce(|sum, part| generate_expression("+", sum, part))
                        .expect("a lane has parts")
                })
                .collect();
            return Some(ExactLanes { bytes, values });
        }
        let parts = self.bytes / bytes;
        let values = self
            .values
            .iter()
            .flat_map(|whole| {
                (0..parts).map(move |k| {
                    let shifted = generate_expression(
                        "lsr",
                        whole.clone(),
                        AbstractExpression::Immediate((8 * bytes * k) as i64),
                    );
                    generate_expression("%", shifted, modulus(bytes))
                })
            })
            .collect();
        Some(ExactLanes { bytes, values })
    }
}

pub struct ExactPlan {
    vectors: Vec<(usize, Option<ExactLanes>)>,
    scalar: Option<(Operand, AbstractExpression)>,
}

pub fn vectors_written(instruction: &Instruction) -> Vec<usize> {
    let opcode = instruction.opcode.as_str();
    if opcode.starts_with("st") {
        return Vec::new();
    }
    let vectors: Vec<usize> = instruction
        .operands
        .iter()
        .filter_map(vector_index)
        .collect();
    if opcode.starts_with("ld") {
        let spanned: std::collections::BTreeSet<usize> =
            match (vectors.iter().min(), vectors.iter().max()) {
                (Some(low), Some(high)) => (*low..=*high).collect(),
                _ => Default::default(),
            };
        return spanned.into_iter().collect();
    }
    instruction
        .operands
        .first()
        .and_then(vector_index)
        .into_iter()
        .collect()
}

fn lane_width(operand: &Operand) -> Option<(usize, usize)> {
    match operand {
        Operand::Vector(_, _, arrangement) => {
            Some((arrangement.lane_bytes(), arrangement.width() as usize))
        }
        _ => None,
    }
}

impl ARMCORTEXA {
    pub fn forget_exact_lanes(&mut self) {
        for lanes in self.lane_bounds.exact.iter_mut() {
            *lanes = None;
        }
    }

    pub(crate) fn note_pc_for_exact_lanes(&mut self, pc: usize) {
        if self.last_executed.is_some_and(|last| pc <= last) {
            self.forget_exact_lanes();
        }
        self.last_executed = Some(pc);
    }

    fn exact(&self, operand: &Operand, bytes: usize) -> Option<ExactLanes> {
        let index = vector_index(operand)?;
        self.lane_bounds.exact[index].as_ref()?.relaned(bytes)
    }

    pub(crate) fn plan_exact_lanes(&mut self, instruction: &Instruction) -> ExactPlan {
        let written = vectors_written(instruction);
        let mut plan = ExactPlan {
            vectors: written.iter().map(|v| (*v, None)).collect(),
            scalar: None,
        };
        match self.exact_effect(instruction) {
            Some(Effect::Vectors(planned)) => {
                for (register, lanes) in planned {
                    if let Some(entry) = plan.vectors.iter_mut().find(|(v, _)| *v == register) {
                        entry.1 = Some(lanes);
                    }
                }
            }
            Some(Effect::Scalar(register, value)) => plan.scalar = Some((register, value)),
            None => (),
        }
        plan
    }

    pub(crate) fn apply_exact_lanes(&mut self, plan: ExactPlan) {
        for (register, lanes) in &plan.vectors {
            log::info!("exact lanes of v{register}: {lanes:?}");
        }
        for (register, lanes) in plan.vectors {
            self.lane_bounds.exact[register] = lanes;
        }
        if let Some((register, value)) = plan.scalar {
            self.set_register(&register, RegisterKind::RegisterBase, Some(value), 0);
        }
    }

    fn exact_effect(&mut self, instruction: &Instruction) -> Option<Effect> {
        let operands = instruction.operands.as_slice();
        let opcode = instruction.opcode.as_str();
        let one = |register: &Operand, lanes: ExactLanes| {
            Some(Effect::Vectors(vec![(vector_index(register)?, lanes)]))
        };
        match (opcode, operands) {
            ("movi" | "mvni", [destination, ..]) => {
                let (bytes, written) = lane_width(destination)?;
                let value = simd::shifted_immediate(instruction)?;
                let masked = if bytes >= 8 {
                    i64::try_from(value as u64).ok()?
                } else {
                    (value & ((1u128 << (8 * bytes)) - 1)) as i64
                };
                one(
                    destination,
                    ExactLanes::filled(bytes, written, AbstractExpression::Immediate(masked))?,
                )
            }
            ("orr" | "bic", [destination, Operand::Immediate(_), ..]) => {
                let (bytes, written) = lane_width(destination)?;
                if bytes >= 8 || written != REGISTER_BYTES && written != 8 {
                    return None;
                }
                let value = simd::shifted_immediate(instruction)?;
                let mask = (1u128 << (8 * bytes)) - 1;
                let immediate = (value & mask) as i64;
                let current = self.exact(destination, bytes)?;
                let values = current
                    .values
                    .iter()
                    .take(written / bytes)
                    .map(|lane| match opcode {
                        "orr" => generate_expression(
                            "|",
                            lane.clone(),
                            AbstractExpression::Immediate(immediate),
                        ),
                        _ => generate_expression(
                            "&",
                            lane.clone(),
                            AbstractExpression::Immediate(!immediate & mask as i64),
                        ),
                    })
                    .collect();
                one(destination, ExactLanes::from_values(bytes, values)?)
            }
            ("dup", [destination, source]) => {
                let (bytes, written) = lane_width(destination)?;
                let value = match source {
                    Operand::Register(..) => {
                        let value = self.get_register(source);
                        if value.kind == RegisterKind::Number {
                            return None;
                        }
                        wrapped(instruction_aux::full_value(&value), bytes)
                    }
                    Operand::VectorAccess(_, _, element, lane) => {
                        if element.lane_bytes() != bytes {
                            return None;
                        }
                        self.exact(source, bytes)?
                            .values
                            .get(usize::try_from(*lane).ok()?)?
                            .clone()
                    }
                    _ => return None,
                };
                one(destination, ExactLanes::filled(bytes, written, value)?)
            }
            (
                "and" | "orr" | "eor" | "bic" | "add" | "sub" | "mul" | "sqdmulh" | "cmhs" | "cmhi"
                | "cmeq" | "cmge" | "cmgt",
                [
                    destination @ Operand::Vector(..),
                    left @ Operand::Vector(..),
                    right @ Operand::Vector(..),
                ],
            ) => {
                let (named_bytes, written) = lane_width(destination)?;
                let bitwise = matches!(opcode, "and" | "orr" | "eor" | "bic");
                let own_bytes = |operand: &Operand| {
                    vector_index(operand)
                        .and_then(|v| self.lane_bounds.exact[v].as_ref())
                        .map(|lanes| lanes.bytes)
                };
                let bytes = match (bitwise, own_bytes(left), own_bytes(right)) {
                    (true, Some(a), Some(b)) if a == b && written % a == 0 => a,
                    _ => named_bytes,
                };
                let (left, right) = (self.exact(left, bytes)?, self.exact(right, bytes)?);
                let mut values = Vec::new();
                for (a, b) in left.values.iter().zip(&right.values).take(written / bytes) {
                    values.push(self.lane_operation(opcode, a.clone(), b.clone(), bytes)?);
                }
                one(destination, ExactLanes::from_values(bytes, values)?)
            }
            (
                "addv",
                [
                    destination @ Operand::Vector(..),
                    source @ Operand::Vector(..),
                ],
            ) => {
                let (bytes, _) = lane_width(destination)?;
                let (source_bytes, source_width) = lane_width(source)?;
                if bytes != source_bytes || bytes >= 8 {
                    return None;
                }
                let lanes = self.exact(source, bytes)?;
                let sum = lanes
                    .values
                    .iter()
                    .take(source_width / bytes)
                    .cloned()
                    .reduce(|sum, lane| generate_expression("+", sum, lane))?;
                one(
                    destination,
                    ExactLanes::from_values(bytes, vec![wrapped(sum, bytes)])?,
                )
            }
            ("umov" | "smov" | "mov" | "fmov", [destination @ Operand::Register(..), source]) => {
                let (bytes, lane) = match source {
                    Operand::VectorAccess(_, _, element, lane) => {
                        (element.lane_bytes(), usize::try_from(*lane).ok()?)
                    }
                    Operand::Vector(_, _, arrangement) if arrangement.lanes() == 1 => {
                        (arrangement.lane_bytes(), 0)
                    }
                    _ => return None,
                };
                if bytes > 8 {
                    return None;
                }
                let value = self.exact(source, bytes)?.values.get(lane)?.clone();
                let value = if opcode == "smov" {
                    signed(value, bytes)
                } else {
                    value
                };
                Some(Effect::Scalar(destination.clone(), value))
            }
            (
                "ld1",
                [
                    registers @ ..,
                    Operand::Memory(prefix, number, None, None, _),
                ],
            ) if registers.iter().all(|r| matches!(r, Operand::Vector(..))) => {
                let address = self.get_register(&Operand::Register(prefix.clone(), *number));
                let mut planned = Vec::new();
                let mut at = 0;
                for register in registers {
                    let (bytes, written) = lane_width(register)?;
                    if bytes > 8 {
                        return None;
                    }
                    let mut values = Vec::new();
                    for lane in 0..written / bytes {
                        values.push(self.loaded_lane(
                            &address,
                            at + (lane * bytes) as i64,
                            bytes,
                        )?);
                    }
                    at += written as i64;
                    planned.push((
                        vector_index(register)?,
                        ExactLanes::from_values(bytes, values)?,
                    ));
                }
                Some(Effect::Vectors(planned))
            }
            (
                "ld1r",
                [
                    register @ Operand::Vector(..),
                    Operand::Memory(prefix, number, None, None, _),
                ],
            ) => {
                let address = self.get_register(&Operand::Register(prefix.clone(), *number));
                let (bytes, written) = lane_width(register)?;
                let value = self.loaded_lane(&address, 0, bytes)?;
                one(register, ExactLanes::filled(bytes, written, value)?)
            }
            (
                "ldr" | "ldur",
                [
                    register,
                    Operand::Memory(prefix, number, offset, None, None),
                ],
            ) if matches!(register, Operand::Vector(..) | Operand::VectorRegister(..)) => {
                let width = vector_access_width(register);
                let address = self.get_register(&Operand::Register(prefix.clone(), *number));
                let start = offset.unwrap_or(0);
                let bytes = width.min(8);
                let mut values = Vec::new();
                for part in 0..width / bytes {
                    values.push(self.loaded_lane(
                        &address,
                        start + (part * bytes) as i64,
                        bytes,
                    )?);
                }
                one(register, ExactLanes::from_values(bytes, values)?)
            }
            _ => None,
        }
    }

    fn loaded_lane(
        &mut self,
        address: &RegisterValue,
        offset: i64,
        bytes: usize,
    ) -> Option<AbstractExpression> {
        let (value, read) = self.peek(address, offset, bytes as i64)?;
        if let Some(read) = read {
            let name = self.fresh_symbol("lane_read");
            let lane = ast::Int::new_const(name.clone());
            let defined = expression_to_ast(value)?;
            self.solver.assert(lane.eq(&defined));
            if bytes < 8 {
                self.bound_fresh(lane.ge(ast::Int::from_i64(0)));
                self.bound_fresh(lane.lt(ast::Int::from_i64(1i64 << (8 * bytes))));
            }
            self.bind_indexed_facts(&read, &lane, &|fact, element| {
                if fact.signed {
                    generate_expression(
                        "zext",
                        element,
                        AbstractExpression::Immediate(8 * fact.width),
                    )
                } else {
                    element
                }
            });
            return Some(AbstractExpression::Abstract(name));
        }
        Some(value)
    }

    fn lane_operation(
        &mut self,
        opcode: &str,
        a: AbstractExpression,
        b: AbstractExpression,
        bytes: usize,
    ) -> Option<AbstractExpression> {
        let comparison = |op: &str, signedness: bool| {
            let (a, b) = if signedness {
                (signed(a.clone(), bytes), signed(b.clone(), bytes))
            } else {
                (a.clone(), b.clone())
            };
            AbstractComparison::new(op, a, b)
        };
        Some(match opcode {
            "and" => generate_expression("&", a, b),
            "orr" => generate_expression("|", a, b),
            "eor" if a == b => AbstractExpression::Immediate(0),
            "eor" => generate_expression("^", a, b),
            "bic" => generate_expression("!&", a, b),
            "add" => wrapped(generate_expression("+", a, b), bytes),
            "sub" => wrapped(generate_expression("-", a, b), bytes),
            "mul" if bytes < 8 => wrapped(generate_expression("*", a, b), bytes),
            "sqdmulh" if matches!(bytes, 2 | 4) && self.fractional_factor(&b, bytes) => {
                self.scaled_down(signed(a, bytes), bytes)?
            }
            "sqdmulh" if matches!(bytes, 2 | 4) && self.fractional_factor(&a, bytes) => {
                self.scaled_down(signed(b, bytes), bytes)?
            }
            "sqdmulh" if matches!(bytes, 2 | 4) => {
                let bits = 8 * bytes as i64;
                let doubled = generate_expression(
                    "*",
                    AbstractExpression::Immediate(2),
                    generate_expression("*", signed(a, bytes), signed(b, bytes)),
                );
                let high = generate_expression("asr", doubled, AbstractExpression::Immediate(bits));
                let saturated = generate_expression(
                    "atmost",
                    high,
                    AbstractExpression::Immediate((1i64 << (bits - 1)) - 1),
                );
                wrapped(saturated, bytes)
            }
            "cmhs" if bytes < 8 => self.lane_mask(comparison(">=", false), bytes)?,
            "cmhi" if bytes < 8 => self.lane_mask(comparison(">", false), bytes)?,
            "cmeq" if bytes < 8 => self.lane_mask(comparison("==", false), bytes)?,
            "cmge" if bytes < 8 => self.lane_mask(comparison(">=", true), bytes)?,
            "cmgt" if bytes < 8 => self.lane_mask(comparison(">", true), bytes)?,
            _ => return None,
        })
    }

    fn fractional_factor(&self, factor: &AbstractExpression, bytes: usize) -> bool {
        let half = 1i64 << (8 * bytes - 1);
        let Some(factor) = expression_to_ast(factor.clone()) else {
            return false;
        };
        self.refutes_ast_within_budget(factor.lt(ast::Int::from_i64(0)))
            && self.refutes_ast_within_budget(factor.ge(ast::Int::from_i64(half)))
    }

    fn scaled_down(
        &mut self,
        scaled: AbstractExpression,
        bytes: usize,
    ) -> Option<AbstractExpression> {
        let value = expression_to_ast(scaled)?;
        let name = self.fresh_symbol("doubled_high_half");
        let result = ast::Int::new_const(name.clone());
        let zero = ast::Int::from_i64(0);
        let non_negative = value.ge(&zero);
        self.bound_fresh(
            non_negative.implies(ast::Bool::and(&[&result.ge(&zero), &result.le(&value)])),
        );
        self.bound_fresh(
            non_negative
                .not()
                .implies(ast::Bool::and(&[&result.ge(&value), &result.le(&zero)])),
        );
        Some(wrapped(AbstractExpression::Abstract(name), bytes))
    }

    fn lane_mask(&mut self, holds: AbstractComparison, bytes: usize) -> Option<AbstractExpression> {
        let holds = comparison_to_ast(holds)?;
        let name = self.fresh_symbol("lane_mask");
        let negated = ast::Int::new_const(name.clone());
        let (minus_one, zero) = (ast::Int::from_i64(-1), ast::Int::from_i64(0));
        self.bound_fresh(negated.ge(&minus_one));
        self.bound_fresh(negated.le(&zero));
        self.bound_fresh(holds.implies(negated.eq(&minus_one)));
        self.bound_fresh(holds.not().implies(negated.eq(&zero)));
        Some(wrapped(AbstractExpression::Abstract(name), bytes))
    }
}

enum Effect {
    Vectors(Vec<(usize, ExactLanes)>),
    Scalar(Operand, AbstractExpression),
}
