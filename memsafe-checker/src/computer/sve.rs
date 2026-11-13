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
        match instruction.opcode.as_str() {
            "whilelo" => self.while_lower(operands)?,
            "incb" => self.count_vector_bytes(operands)?,
            "ld1b" => {
                self.predicated_bytes(operands, RegionType::READ)?;
                self.forget_written_scalable(operands)?;
            }
            "st1b" => self.predicated_bytes(operands, RegionType::WRITE)?,
            "prfb" => {}
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
            None => {
                return Err(
                    "SVE instruction that writes no vector or predicate is not modelled"
                        .to_string(),
                );
            }
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
                    self.registers[lanes.tie.start_register] == lanes.start
                        && self.registers[lanes.tie.end_register] == lanes.end
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
        let [
            predicate,
            start @ Operand::Register(RePrefix::X, start_register),
            end @ Operand::Register(RePrefix::X, end_register),
        ] = operands
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
                start_register: *start_register,
                end_register: *end_register,
                element_bytes,
            },
        });
        Ok(())
    }

    fn count_vector_bytes(&mut self, operands: &[Operand]) -> Result<(), String> {
        let [counter @ Operand::Register(RePrefix::X, _)] = operands else {
            return Err("incb is modelled only on an x register with no pattern".to_string());
        };
        let length = self.vector_bytes();
        let current = self.get_register(counter);
        let advanced = add_values(
            current,
            RegisterValue::new(RegisterKind::RegisterBase, Some(length), 0),
        );
        self.set_register(counter, advanced.kind, advanced.base, advanced.offset);
        Ok(())
    }

    fn predicated_bytes(&mut self, operands: &[Operand], ty: RegionType) -> Result<(), String> {
        let [
            _,
            governing,
            Operand::Memory(prefix, base, None, Some(index), None),
        ] = operands
        else {
            return Err("predicated byte access is modelled only at [xn, xm]".to_string());
        };
        let Operand::Register(RePrefix::X, _) = index.as_ref() else {
            return Err("predicated byte access needs an unshifted x index".to_string());
        };
        let Some((ScalableKind::Predicate, n, _)) = scalable_register(governing) else {
            return Err("predicated byte access needs a governing predicate".to_string());
        };
        let Some(lanes) = self.predicates[n].clone() else {
            return Err(format!("predicate p{n} has no known active lanes"));
        };
        if lanes.element_bytes != 1 {
            return Err(format!("predicate p{n} does not govern byte elements"));
        }
        if self.get_register(index) != lanes.start {
            return Err(format!(
                "the index of a predicated access is not where p{n} starts"
            ));
        }
        let address_base = self.get_register(&Operand::Register(prefix.clone(), *base));
        let first = add_values(address_base.clone(), lanes.start.clone());
        let mut last = add_values(address_base, lanes.end.clone());
        last.offset -= 1;
        self.access_span(&first, &last, LONGEST_VECTOR_BYTES, ty)
            .map_err(|e| e.to_string())
    }
}
