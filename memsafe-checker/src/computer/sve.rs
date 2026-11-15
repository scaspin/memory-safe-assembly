use crate::common::*;
use crate::computer::ARMCORTEXA;
use crate::computer::instruction_aux::add_values;
use crate::instruction_parser::*;
use z3::ast;

pub const VECTOR_BYTES: &str = "sve_vector_bytes";
const SHORTEST_VECTOR_BYTES: i64 = 16;
const LONGEST_VECTOR_BYTES: i64 = 256;
const VECTOR_LENGTH_GRANULE: i64 = 16;
const VECTOR_LENGTH_COUNTS: [&str; 15] = [
    "incb", "inch", "incw", "incd", "decb", "dech", "decw", "decd", "cntb", "cnth", "cntw", "cntd",
    "addvl", "addpl", "rdvl",
];

#[derive(Debug, Clone, PartialEq)]
pub struct ActiveLanes {
    pub start: RegisterValue,
    pub end: RegisterValue,
    pub element_bytes: i64,
    pub tie: PredicateTie,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct PredicateTie {
    pub start_register: usize,
    pub end_register: usize,
    pub element_bytes: i64,
    pub every_lane: bool,
}

pub type PredicateTies = [Option<PredicateTie>; 16];

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum ScalableKind {
    Vector,
    Predicate,
}

fn element_bytes(suffix: &str) -> Option<i64> {
    match suffix {
        "b" => Some(1),
        "h" => Some(2),
        "s" => Some(4),
        "d" => Some(8),
        "q" => Some(16),
        _ => None,
    }
}

fn scalable_register(operand: &Operand) -> Option<(ScalableKind, usize, Option<i64>)> {
    let Operand::Label(name) = operand else {
        return None;
    };
    let name = name
        .strip_suffix("/z")
        .or_else(|| name.strip_suffix("/m"))
        .unwrap_or(name);
    let (register, suffix) = match name.split_once('.') {
        Some((register, suffix)) => (register, Some(suffix)),
        None => (name, None),
    };
    let kind = match register.chars().next()? {
        'z' => ScalableKind::Vector,
        'p' => ScalableKind::Predicate,
        _ => return None,
    };
    let number = register[1..].parse::<usize>().ok()?;
    let limit = if kind == ScalableKind::Vector { 32 } else { 16 };
    if number >= limit {
        return None;
    }
    let bytes = match suffix {
        Some(suffix) => Some(element_bytes(suffix)?),
        None => None,
    };
    Some((kind, number, bytes))
}

fn mnemonic_element_bytes(suffix: &str) -> Option<i64> {
    match suffix {
        "b" => Some(1),
        "h" => Some(2),
        "w" => Some(4),
        "d" => Some(8),
        _ => None,
    }
}

fn counted_element_bytes(opcode: &str) -> Option<i64> {
    let suffix = opcode
        .strip_prefix("cnt")
        .or_else(|| opcode.strip_prefix("inc"))
        .or_else(|| opcode.strip_prefix("dec"))?;
    mnemonic_element_bytes(suffix)
}

fn contiguous_shape(opcode: &str) -> Option<(RegionType, i64, i64)> {
    let (ty, rest) = if let Some(rest) = opcode.strip_prefix("ld") {
        (RegionType::READ, rest)
    } else {
        (RegionType::WRITE, opcode.strip_prefix("st")?)
    };
    let mut characters = rest.chars();
    let structures = characters
        .next()?
        .to_digit(10)
        .filter(|n| (1..=4).contains(n))?;
    let element = mnemonic_element_bytes(characters.as_str())?;
    Some((ty, structures as i64, element))
}

fn every_lane(element_bytes: i64) -> ActiveLanes {
    let nowhere = RegisterValue::new(RegisterKind::Immediate, None, 0);
    ActiveLanes {
        start: nowhere.clone(),
        end: nowhere,
        element_bytes,
        tie: PredicateTie {
            start_register: 32,
            end_register: 32,
            element_bytes,
            every_lane: true,
        },
    }
}

fn general_register(operand: &Operand) -> Option<usize> {
    match operand {
        Operand::Register(RePrefix::X, n) => Some(*n),
        Operand::Register(RePrefix::Ze, _) => Some(32),
        _ => None,
    }
}

pub fn is_scalable(instruction: &Instruction) -> bool {
    VECTOR_LENGTH_COUNTS.contains(&instruction.opcode.as_str())
        || instruction
            .operands
            .iter()
            .any(|operand| scalable_register(operand).is_some())
}

impl ARMCORTEXA {
    pub(crate) fn scalable(
        &mut self,
        instruction: &Instruction,
    ) -> Result<ExecuteReturnType, String> {
        let operands = instruction.operands.as_slice();
        if let Some((ty, structures, element)) = contiguous_shape(&instruction.opcode) {
            self.contiguous_access(operands, ty, structures, element)?;
            if ty == RegionType::READ {
                self.forget_loaded_vectors(operands);
            }
            return Ok(ExecuteReturnType::Next);
        }
        match instruction.opcode.as_str() {
            "whilelo" => self.while_lower(operands)?,
            "ptrue" | "ptrues" => self.all_lanes_true(operands)?,
            "addvl" | "addpl" => self.add_vector_lengths(instruction.opcode.as_str(), operands)?,
            "rdvl" => self.read_vector_length(operands)?,
            opcode if counted_element_bytes(opcode).is_some() => {
                self.count_vector_elements(opcode, operands)?
            }
            opcode if opcode.starts_with("prf") => {}
            opcode if operands.iter().any(|o| matches!(o, Operand::Memory(..))) => {
                return Err(format!("SVE memory instruction {opcode} is not modelled"));
            }
            _ => self.forget_written_scalable(operands)?,
        }
        Ok(ExecuteReturnType::Next)
    }

    fn forget_written_scalable(&mut self, operands: &[Operand]) -> Result<(), String> {
        match operands.first().and_then(scalable_register) {
            Some((ScalableKind::Vector, n, _)) => self.forget_vector(n),
            Some((ScalableKind::Predicate, n, _)) => {
                self.predicates[n] = None;
                self.set_unknown_flags();
            }
            None => match operands.first() {
                Some(destination @ Operand::Register(RePrefix::X | RePrefix::W, _)) => {
                    self.set_register(destination, RegisterKind::Number, None, 0)
                }
                Some(
                    destination @ (Operand::VectorRegister(..)
                    | Operand::Vector(..)
                    | Operand::VectorAccess(..)),
                ) => self.vector_unknown(destination),
                _ => {
                    return Err(
                        "SVE instruction that writes no vector or predicate is not modelled"
                            .to_string(),
                    );
                }
            },
        }
        Ok(())
    }

    fn vector_bytes(&mut self) -> AbstractExpression {
        if !self.vector_bytes_bounded {
            self.vector_bytes_bounded = true;
            let length = ast::Int::new_const(VECTOR_BYTES);
            self.bound_fresh(length.ge(ast::Int::from_i64(SHORTEST_VECTOR_BYTES)));
            self.bound_fresh(length.le(ast::Int::from_i64(LONGEST_VECTOR_BYTES)));
            self.bound_fresh(
                length
                    .modulo(ast::Int::from_i64(VECTOR_LENGTH_GRANULE))
                    .eq(ast::Int::from_i64(0)),
            );
        }
        AbstractExpression::Abstract(VECTOR_BYTES.to_string())
    }

    pub(crate) fn intact_predicate_ties(&self) -> PredicateTies {
        self.predicates.clone().map(|lanes| {
            lanes
                .filter(|lanes| {
                    lanes.tie.every_lane
                        || (self.registers[lanes.tie.start_register] == lanes.start
                            && self.registers[lanes.tie.end_register] == lanes.end)
                })
                .map(|lanes| lanes.tie)
        })
    }

    pub(crate) fn keep_predicates_tied_in_both(
        &mut self,
        previous: &PredicateTies,
        current: PredicateTies,
    ) {
        for (n, tie) in current.into_iter().enumerate() {
            self.predicates[n] = match tie {
                Some(tie) if previous[n] == Some(tie) && tie.every_lane => {
                    Some(every_lane(tie.element_bytes))
                }
                Some(tie) if previous[n] == Some(tie) => Some(ActiveLanes {
                    start: self.registers[tie.start_register].clone(),
                    end: self.registers[tie.end_register].clone(),
                    element_bytes: tie.element_bytes,
                    tie,
                }),
                _ => None,
            };
        }
    }

    fn while_lower(&mut self, operands: &[Operand]) -> Result<(), String> {
        let [predicate, start, end] = operands else {
            return Err("whilelo is modelled only on two x registers".to_string());
        };
        let (Some(start_register), Some(end_register)) =
            (general_register(start), general_register(end))
        else {
            return Err("whilelo is modelled only on two x registers".to_string());
        };
        let Some((ScalableKind::Predicate, n, Some(element_bytes))) = scalable_register(predicate)
        else {
            return Err("whilelo needs a predicate with an element size".to_string());
        };
        let (start, end) = (self.get_register(start), self.get_register(end));
        if start.kind == RegisterKind::Number || end.kind == RegisterKind::Number {
            self.predicates[n] = None;
            self.set_unknown_flags();
            return Ok(());
        }
        let length = self.vector_bytes();
        let shown = |value: &RegisterValue| AbstractExpression::Register(Box::new(value.clone()));
        let elements =
            generate_expression("/", length, AbstractExpression::Immediate(element_bytes));
        let past_last = generate_expression("+", shown(&start), elements);
        self.set_flags([
            Some(FlagValue::Abstract(AbstractComparison::new(
                ">=",
                shown(&start),
                shown(&end),
            ))),
            Some(FlagValue::Abstract(AbstractComparison::new(
                "<",
                shown(&start),
                shown(&end),
            ))),
            Some(FlagValue::Abstract(AbstractComparison::new(
                ">",
                past_last,
                shown(&end),
            ))),
            Some(FlagValue::Real(false)),
        ]);
        self.predicates[n] = Some(ActiveLanes {
            start,
            end,
            element_bytes,
            tie: PredicateTie {
                start_register,
                end_register,
                element_bytes,
                every_lane: false,
            },
        });
        Ok(())
    }

    fn all_lanes_true(&mut self, operands: &[Operand]) -> Result<(), String> {
        let pattern_is_all = match operands.get(1) {
            None => true,
            Some(Operand::Label(pattern)) => pattern == "all",
            _ => false,
        };
        let Some((ScalableKind::Predicate, n, Some(element_bytes))) =
            operands.first().and_then(scalable_register)
        else {
            return Err("ptrue needs a predicate with an element size".to_string());
        };
        self.predicates[n] = pattern_is_all.then(|| every_lane(element_bytes));
        self.set_unknown_flags();
        Ok(())
    }

    fn vector_lengths(&mut self, multiple: i64, divisor: i64) -> RegisterValue {
        let length = self.vector_bytes();
        let scaled = generate_expression("*", AbstractExpression::Immediate(multiple), length);
        let value = generate_expression("/", scaled, AbstractExpression::Immediate(divisor));
        RegisterValue::new(RegisterKind::RegisterBase, Some(value), 0)
    }

    fn count_vector_elements(&mut self, opcode: &str, operands: &[Operand]) -> Result<(), String> {
        let [counter @ Operand::Register(RePrefix::X, _)] = operands else {
            return Err(format!(
                "{opcode} is modelled only on an x register with no pattern"
            ));
        };
        let element = counted_element_bytes(opcode).unwrap_or(1);
        let elements = self.vector_lengths(1, element);
        let counted = match &opcode[..3] {
            "cnt" => elements,
            "inc" => add_values(self.get_register(counter), elements),
            _ => {
                let mut negated = self.vector_lengths(-1, element);
                negated = add_values(self.get_register(counter), negated);
                negated
            }
        };
        self.set_register(counter, counted.kind, counted.base, counted.offset);
        Ok(())
    }

    fn add_vector_lengths(&mut self, opcode: &str, operands: &[Operand]) -> Result<(), String> {
        let [
            destination @ Operand::Register(RePrefix::X | RePrefix::Sp, _),
            source @ Operand::Register(RePrefix::X | RePrefix::Sp, _),
            Operand::Immediate(multiple),
        ] = operands
        else {
            return Err(format!("{opcode} is modelled only as xd, xn, #imm"));
        };
        let divisor = if opcode == "addpl" { 8 } else { 1 };
        let advance = self.vector_lengths(*multiple, divisor);
        let advanced = add_values(self.get_register(source), advance);
        self.set_register(destination, advanced.kind, advanced.base, advanced.offset);
        Ok(())
    }

    fn read_vector_length(&mut self, operands: &[Operand]) -> Result<(), String> {
        let [
            destination @ Operand::Register(RePrefix::X, _),
            Operand::Immediate(multiple),
        ] = operands
        else {
            return Err("rdvl is modelled only as xd, #imm".to_string());
        };
        let length = self.vector_lengths(*multiple, 1);
        self.set_register(destination, length.kind, length.base, length.offset);
        Ok(())
    }

    fn forget_loaded_vectors(&mut self, operands: &[Operand]) {
        for operand in operands {
            if let Some((ScalableKind::Vector, n, _)) = scalable_register(operand) {
                self.forget_vector(n);
            }
        }
    }

    fn contiguous_access(
        &mut self,
        operands: &[Operand],
        ty: RegionType,
        structures: i64,
        element: i64,
    ) -> Result<(), String> {
        let [
            ..,
            governing,
            Operand::Memory(prefix, base, offset, index, None),
        ] = operands
        else {
            return Err("SVE contiguous access is modelled only with plain addressing".to_string());
        };
        let Some((ScalableKind::Predicate, n, _)) = scalable_register(governing) else {
            return Err("SVE contiguous access needs a governing predicate".to_string());
        };
        let Some(lanes) = self.predicates[n].clone() else {
            return Err(format!("predicate p{n} has no known active lanes"));
        };
        if lanes.element_bytes != element {
            return Err(format!(
                "predicate p{n} governs {}-byte lanes, not {element}-byte elements",
                lanes.element_bytes
            ));
        }
        let address_base = self.get_register(&Operand::Register(prefix.clone(), *base));
        let first = match (offset, index.as_deref()) {
            (None | Some(0), None) => address_base,
            (Some(multiple), Some(Operand::Label(scaled))) if scaled == SCALED_BY_VECTOR_LENGTH => {
                let skipped = self.vector_lengths(*multiple, 1);
                add_values(address_base, skipped)
            }
            (None, Some(index)) if structures == 1 => {
                let register = match index {
                    Operand::Register(..) if element == 1 => index,
                    Operand::ShiftedRegister(register, shift, amount)
                        if shift == "lsl" && 1i64 << amount == element =>
                    {
                        register.as_ref()
                    }
                    _ => {
                        return Err(
                            "SVE indexed access needs an index scaled by the element size"
                                .to_string(),
                        );
                    }
                };
                if lanes.tie.every_lane {
                    return Err("SVE indexed access under ptrue is not modelled".to_string());
                }
                if self.get_register(register) != lanes.start {
                    return Err(format!(
                        "the index of a predicated access is not where p{n} starts"
                    ));
                }
                let mut last = add_values(
                    address_base.clone(),
                    scaled_value(lanes.end.clone(), element),
                );
                last.offset -= 1;
                let first = add_values(address_base, scaled_value(lanes.start, element));
                return self
                    .access_span(&first, &last, LONGEST_VECTOR_BYTES, ty)
                    .map_err(|e| e.to_string());
            }
            _ => return Err("SVE contiguous access addressing is not modelled".to_string()),
        };
        let span = if lanes.tie.every_lane {
            self.vector_lengths(structures, 1)
        } else {
            let shown =
                |value: &RegisterValue| AbstractExpression::Register(Box::new(value.clone()));
            let requested = generate_expression("-", shown(&lanes.end), shown(&lanes.start));
            let lanes_in_a_vector = self.vector_lengths(1, element);
            let active = generate_expression(
                "atmost",
                requested,
                AbstractExpression::Register(Box::new(lanes_in_a_vector)),
            );
            RegisterValue::new(
                RegisterKind::RegisterBase,
                Some(generate_expression(
                    "*",
                    active,
                    AbstractExpression::Immediate(structures * element),
                )),
                0,
            )
        };
        let mut last = add_values(first.clone(), span);
        last.offset -= 1;
        self.access_span(&first, &last, structures * LONGEST_VECTOR_BYTES, ty)
            .map_err(|e| e.to_string())
    }
}

fn scaled_value(value: RegisterValue, factor: i64) -> RegisterValue {
    match value.kind {
        RegisterKind::Immediate => {
            RegisterValue::new(RegisterKind::Immediate, None, value.offset * factor)
        }
        _ => RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression(
                "*",
                AbstractExpression::Register(Box::new(value)),
                AbstractExpression::Immediate(factor),
            )),
            0,
        ),
    }
}
