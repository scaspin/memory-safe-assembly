use crate::common::*;
use crate::machine::*;
use crate::x86::instruction_parser::*;
use std::collections::{BTreeMap, BTreeSet};
use std::fmt;
use std::rc::Rc;
use z3::*;

mod flags;
mod instructions;
mod machine;
mod memory;

pub const GPR_COUNT: usize = 16;
pub const VECTOR_COUNT: usize = 32;
pub const MASK_COUNT: usize = 8;

pub const ARGUMENT_REGISTERS: [usize; 6] = [RDI, RSI, RDX, RCX, 8, 9];

const EXTERNAL_REGIONS: [(&str, i64); 1] = [("OPENSSL_ia32cap_P", 16)];

pub const STACK: &str = "sp";
pub const RETURN: &str = "return";
pub const RETURN_TO: &str = "return_to";
pub const RETURN_ADDRESS_BYTES: i64 = 8;

#[derive(Clone)]
pub struct X86_64 {
    pub registers: [RegisterValue; GPR_COUNT],
    loaded: [bool; GPR_COUNT],
    pub vectors: Box<[RegisterValue; VECTOR_COUNT]>,
    pub masks: [RegisterValue; MASK_COUNT],
    zero: Option<FlagValue>,
    neg: Option<FlagValue>,
    carry: Option<FlagValue>,
    overflow: Option<FlagValue>,
    pub memory: BTreeMap<String, MemorySafeRegion>,
    pub memory_labels: BTreeMap<String, (String, i64)>,
    code_labels: Rc<BTreeSet<String>>,
    select_definitions: SelectDefinitions,
    symbols_bounding_counter: BTreeMap<String, Vec<String>>,
    element_facts: ElementFacts,
    write_journal: Vec<CellWrite>,
    blind_stack_writes: Vec<(AbstractExpression, i64, i64)>,
    rw_queue: Vec<MemoryAccess>,
    unknown_counter: usize,
    stack_top: i64,
    pub solver: Solver,
}

impl fmt::Debug for X86_64 {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        writeln!(f, "registers {:#?}", &self.registers)?;
        write!(f, "vector registers {:?}", &self.vectors)
    }
}

impl Default for X86_64 {
    fn default() -> Self {
        Self::new()
    }
}

fn unknown() -> RegisterValue {
    RegisterValue::new(RegisterKind::Number, None, 0)
}

impl X86_64 {
    pub fn new() -> X86_64 {
        let registers = std::array::from_fn(|i| {
            if i == RSP {
                RegisterValue::new_empty(STACK)
            } else {
                RegisterValue::new_empty(&register_name(&gpr(i, 8)))
            }
        });

        let solver = Solver::new();
        let max = ast::Int::from_i64(i64::MAX);
        let stack_max = ast::Int::new_const("MAX");
        solver.assert(stack_max.ge(&max));

        let mut memory = BTreeMap::new();
        let mut stack = MemorySafeRegion::new(abstract_of("MAX"), RegionType::RW);
        stack.insert_sized(0, RegisterValue::new_empty(RETURN), 8);
        memory.insert(STACK.to_string(), stack);
        for (name, length) in EXTERNAL_REGIONS {
            memory.insert(
                name.to_string(),
                MemorySafeRegion::new(AbstractExpression::Immediate(length), RegionType::READ),
            );
        }

        X86_64 {
            registers,
            loaded: [false; GPR_COUNT],
            vectors: Box::new(std::array::from_fn(|_| unknown())),
            masks: std::array::from_fn(|_| unknown()),
            zero: None,
            neg: None,
            carry: None,
            overflow: None,
            memory,
            memory_labels: BTreeMap::new(),
            code_labels: Rc::default(),
            select_definitions: BTreeMap::new(),
            symbols_bounding_counter: BTreeMap::new(),
            element_facts: Rc::default(),
            write_journal: Vec::new(),
            blind_stack_writes: Vec::new(),
            rw_queue: Vec::new(),
            unknown_counter: 0,
            stack_top: 8,
            solver,
        }
    }

    pub fn get_state(&self) -> MachineState {
        let mut registers = self.registers.to_vec();
        registers.extend(self.vectors.iter().cloned());
        registers.extend(self.masks.iter().cloned());
        (
            registers,
            self.zero.clone(),
            self.neg.clone(),
            self.carry.clone(),
            self.overflow.clone(),
        )
    }

    pub fn set_state(&mut self, state: MachineState) {
        let (registers, zero, neg, carry, overflow) = state;
        for (i, r) in registers.into_iter().enumerate() {
            self.set_register_at(i, r);
        }
        self.set_flags([zero, neg, carry, overflow]);
    }

    pub fn set_register_at(&mut self, index: usize, value: RegisterValue) {
        if index < GPR_COUNT {
            self.registers[index] = value;
        } else if index < GPR_COUNT + VECTOR_COUNT {
            self.vectors[index - GPR_COUNT] = value;
        } else {
            self.masks[index - GPR_COUNT - VECTOR_COUNT] = value;
        }
    }

    pub fn register_at(&self, index: usize) -> RegisterValue {
        if index < GPR_COUNT {
            self.registers[index].clone()
        } else if index < GPR_COUNT + VECTOR_COUNT {
            self.vectors[index - GPR_COUNT].clone()
        } else {
            self.masks[index - GPR_COUNT - VECTOR_COUNT].clone()
        }
    }

    pub fn set_flags(&mut self, flags: [Option<FlagValue>; 4]) {
        let [zero, neg, carry, overflow] = flags;
        self.zero = zero;
        self.neg = neg;
        self.carry = carry;
        self.overflow = overflow;
    }

    pub fn fresh(&mut self, what: &str) -> AbstractExpression {
        let n = self.unknown_counter;
        self.unknown_counter += 1;
        AbstractExpression::Abstract(format!("{what}_{n}"))
    }

    pub fn fingerprint(&self, with_flags: bool) -> String {
        use std::fmt::Write;
        let mut out = format!(
            "{:?}|{:?}|{:?}|{:?}|",
            self.registers, self.loaded, self.vectors, self.masks
        );
        if with_flags {
            let _ = write!(
                out,
                "{:?}{:?}{:?}{:?}|",
                self.zero, self.neg, self.carry, self.overflow
            );
        }
        let _ = write!(
            out,
            "{:?}|{:?}|{:?}|{:?}|{:?}|{:?}|{}|{}",
            self.memory,
            self.select_definitions,
            self.symbols_bounding_counter,
            self.write_journal,
            self.blind_stack_writes,
            self.rw_queue,
            self.unknown_counter,
            self.stack_top,
        );
        out
    }

    pub fn read_gpr(&self, index: usize, width: i64, high: bool) -> RegisterValue {
        let whole = self.registers[index].clone();
        if width >= 8 {
            return whole;
        }
        if high {
            return narrow(&whole, width, high);
        }
        self.narrow_checked(&whole, width)
    }

    pub fn narrow_checked(&self, value: &RegisterValue, width: i64) -> RegisterValue {
        if width >= 8 || value.kind != RegisterKind::RegisterBase {
            return narrow(value, width, false);
        }
        let Some(v) = expression_to_ast(value.expression()) else {
            return narrow(value, width, false);
        };
        let limit = ast::Int::from_i64(1i64 << (width * 8));
        let outside = ast::Bool::or(&[&v.lt(ast::Int::from_i64(0)), &v.ge(&limit)]);
        if check(&self.solver, &[outside]) == SatResult::Unsat {
            value.clone()
        } else {
            narrow(value, width, false)
        }
    }

    pub fn write_gpr(&mut self, index: usize, width: i64, high: bool, value: RegisterValue) {
        self.loaded[index] = false;
        match width {
            8 => self.registers[index] = value,
            4 => self.registers[index] = self.narrow_checked(&value, 4),
            _ => {
                let old = self.registers[index].clone();
                let merged = match (old.kind.clone(), value.kind.clone()) {
                    (RegisterKind::Immediate, RegisterKind::Immediate) => {
                        let bits = width * 8;
                        let shift = if high { 8 } else { 0 };
                        let mask = ((1i64 << bits) - 1) << shift;
                        RegisterValue::new_imm(
                            (old.offset & !mask) | ((value.offset << shift) & mask),
                        )
                    }
                    (old_kind, new_kind)
                        if !high
                            && old_kind != RegisterKind::Number
                            && new_kind != RegisterKind::Number =>
                    {
                        let modulus = AbstractExpression::Immediate(1i64 << (width * 8));
                        let whole = old.expression();
                        let kept = generate_expression(
                            "-",
                            whole.clone(),
                            generate_expression("%", whole, modulus.clone()),
                        );
                        RegisterValue::new(
                            RegisterKind::RegisterBase,
                            Some(generate_expression(
                                "+",
                                kept,
                                generate_expression("%", value.expression(), modulus),
                            )),
                            0,
                        )
                    }
                    _ => unknown(),
                };
                self.registers[index] = merged;
            }
        }
    }

    pub fn mark_loaded(&mut self, destination: &Operand) {
        if let Some(Register::Gpr { index, .. }) = destination.register() {
            self.loaded[index] = true;
        }
    }

    pub fn get_register(&self, register: &Operand) -> RegisterValue {
        match register {
            Operand::Register(Register::Gpr { index, width, high }) => {
                self.read_gpr(*index, *width, *high)
            }
            Operand::Register(Register::Vector { index, .. }) => self.vectors[*index].clone(),
            Operand::Register(Register::Mask(k)) => self.masks[*k].clone(),
            Operand::Immediate(v) => RegisterValue::new_imm(*v),
            _ => unknown(),
        }
    }

    pub fn set_register(
        &mut self,
        register: &Operand,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        let value = RegisterValue::new(kind, base, offset);
        match register {
            Operand::Register(Register::Gpr { index, width, high }) => {
                self.write_gpr(*index, *width, *high, value)
            }
            Operand::Register(Register::Vector { index, .. }) => self.vectors[*index] = value,
            Operand::Register(Register::Mask(k)) => self.masks[*k] = value,
            other => log::error!("cannot set {other:?} as a register"),
        }
    }

    pub fn set_immediate(&mut self, register: String, value: u64) {
        match parse_register(&register) {
            Some(r) => self.set_register(
                &Operand::Register(r),
                RegisterKind::Immediate,
                None,
                value as i64,
            ),
            None => log::error!("no register named {register}"),
        }
    }

    pub fn set_abstract(&mut self, register: String, value: AbstractExpression) {
        match parse_register(&register) {
            Some(r) => self.set_register(
                &Operand::Register(r),
                RegisterKind::RegisterBase,
                Some(value),
                0,
            ),
            None => log::error!("no register named {register}"),
        }
    }

    pub fn set_argument(&mut self, index: usize, value: AbstractExpression) {
        let value = RegisterValue::new(RegisterKind::RegisterBase, Some(value), 0);
        if let Some(register) = ARGUMENT_REGISTERS.get(index) {
            self.registers[*register] = value;
        } else {
            let slot = 8 * (index as i64 - ARGUMENT_REGISTERS.len() as i64 + 1);
            self.stack_top = self.stack_top.max(slot + 8);
            self.memory
                .get_mut(STACK)
                .expect("stack region created at startup")
                .insert_sized(slot, value, 8);
        }
    }

    pub fn substitute_symbol(&mut self, symbol: &str, value: i64) {
        for i in 0..GPR_COUNT + VECTOR_COUNT + MASK_COUNT {
            if let Some(register) = respelled(&self.register_at(i), symbol, value) {
                self.set_register_at(i, register);
            }
        }
    }
}

pub fn narrow(value: &RegisterValue, width: i64, high: bool) -> RegisterValue {
    if width >= 8 {
        return value.clone();
    }
    let bits = width * 8;
    match value.kind {
        RegisterKind::Number => value.clone(),
        RegisterKind::Immediate => {
            let shifted = if high {
                value.offset >> 8
            } else {
                value.offset
            };
            RegisterValue::new_imm(shifted.rem_euclid(1i64 << bits))
        }
        RegisterKind::RegisterBase => {
            let whole = value.expression();
            let whole = if high {
                generate_expression("/", whole, AbstractExpression::Immediate(256))
            } else {
                whole
            };
            RegisterValue::new(
                RegisterKind::RegisterBase,
                Some(generate_expression(
                    "%",
                    whole,
                    AbstractExpression::Immediate(1i64 << bits),
                )),
                0,
            )
        }
    }
}

pub fn sign_extend(value: &RegisterValue, width: i64) -> RegisterValue {
    if width >= 8 {
        return value.clone();
    }
    let bits = width * 8;
    let half = 1i64 << (bits - 1);
    match value.kind {
        RegisterKind::Number => value.clone(),
        RegisterKind::Immediate => {
            let low = value.offset.rem_euclid(1i64 << bits);
            RegisterValue::new_imm(if low >= half {
                low - (1i64 << bits)
            } else {
                low
            })
        }
        RegisterKind::RegisterBase => {
            let shifted =
                generate_expression("+", value.expression(), AbstractExpression::Immediate(half));
            let wrapped =
                generate_expression("%", shifted, AbstractExpression::Immediate(1i64 << bits));
            RegisterValue::new(
                RegisterKind::RegisterBase,
                Some(generate_expression(
                    "-",
                    wrapped,
                    AbstractExpression::Immediate(half),
                )),
                0,
            )
        }
    }
}

#[cfg(test)]
mod tests;
