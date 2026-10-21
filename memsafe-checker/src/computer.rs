use crate::common::*;
use crate::instruction_parser::*;
use crate::machine::*;
use std::cell::RefCell;
use std::collections::{BTreeMap, BTreeSet};
use std::fmt;
use std::rc::Rc;
use z3::*;

mod instruction_aux;
mod instructions;
pub(crate) use instructions::is_floating_point;
mod machine;
mod memory;
mod simd;
pub(crate) use simd::{
    arrangement_of, range_fits_lane, split_vector_operands, vector_access_width, vector_index,
};

pub const MAX_EXPRESSION_NODES: usize = 150;
const WORD_FIT_RESOURCE_LIMIT: u32 = 5_000_000;

#[derive(Clone)]
pub struct ARMCORTEXA {
    pub registers: [RegisterValue; 33],
    pub loaded: [bool; 33],
    pub simd_registers: Box<[SimdRegister; 32]>,
    zero: Option<FlagValue>,
    neg: Option<FlagValue>,
    pub carry: Option<FlagValue>,
    overflow: Option<FlagValue>,
    pub memory: BTreeMap<String, MemorySafeRegion>,
    pub memory_labels: BTreeMap<String, (String, i64)>,
    pub data_symbol_sizes: BTreeMap<String, i64>,
    pub code_labels: Rc<BTreeSet<String>>,
    pub select_definitions: SelectDefinitions,
    pub symbols_bounding_counter: BTreeMap<String, Vec<String>>,
    rw_queue: Vec<MemoryAccess>,
    element_facts: ElementFacts,
    stack_arguments: i64,
    pub red_zone: i64,
    findings: Rc<RefCell<Vec<String>>>,
    current_line: usize,
    alignment: i64,
    flag_counter: usize,
    pub solver: Solver,
    pub lane_bounds: Box<LaneBounds>,
    pub write_journal: Vec<CellWrite>,
    pub blind_stack_writes: Vec<(AbstractExpression, i64, i64)>,
    pub symbolic_slots: Vec<SymbolicSlot>,
    pointer_elements: BTreeMap<String, String>,
    element_ranges: BTreeMap<String, Vec<ElementRange>>,
    pristine_read: Option<String>,
}

#[derive(Debug, Clone)]
pub struct LaneBounds {
    pub bytes: [[u8; 16]; 32],
    pub scalar: [Option<u64>; 32],
    pub maxima: [Vec<AbstractExpression>; 32],
}

impl Default for LaneBounds {
    fn default() -> Self {
        Self {
            bytes: [[u8::MAX; 16]; 32],
            scalar: [None; 32],
            maxima: std::array::from_fn(|_| Vec::new()),
        }
    }
}

impl fmt::Debug for ARMCORTEXA {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        writeln!(f, "registers {:#?}", &self.registers)?;
        write!(f, "simd registers {:?}", &self.simd_registers)
    }
}

impl Default for ARMCORTEXA {
    fn default() -> Self {
        Self::new()
    }
}

impl ARMCORTEXA {
    pub fn new() -> ARMCORTEXA {
        let registers = [
            RegisterValue::new_empty("x0"),
            RegisterValue::new_empty("x1"),
            RegisterValue::new_empty("x2"),
            RegisterValue::new_empty("x3"),
            RegisterValue::new_empty("x4"),
            RegisterValue::new_empty("x5"),
            RegisterValue::new_empty("x6"),
            RegisterValue::new_empty("x7"),
            RegisterValue::new_empty("x8"),
            RegisterValue::new_empty("x9"),
            RegisterValue::new_empty("x10"),
            RegisterValue::new_empty("x11"),
            RegisterValue::new_empty("x12"),
            RegisterValue::new_empty("x13"),
            RegisterValue::new_empty("x14"),
            RegisterValue::new_empty("x15"),
            RegisterValue::new_empty("x16"),
            RegisterValue::new_empty("x17"),
            RegisterValue::new_empty("x18"),
            RegisterValue::new_empty("x19"),
            RegisterValue::new_empty("x20"),
            RegisterValue::new_empty("x21"),
            RegisterValue::new_empty("x22"),
            RegisterValue::new_empty("x23"),
            RegisterValue::new_empty("x24"),
            RegisterValue::new_empty("x25"),
            RegisterValue::new_empty("x26"),
            RegisterValue::new_empty("x27"),
            RegisterValue::new_empty("x28"),
            RegisterValue::new_empty("x29"),
            RegisterValue::new(
                RegisterKind::RegisterBase,
                Some(AbstractExpression::Abstract("return".to_string())),
                0,
            ),
            RegisterValue::new_empty("sp"),
            RegisterValue::new(RegisterKind::Immediate, None, 0),
        ];

        let simd_registers = Box::new([
            SimdRegister::new("v0"),
            SimdRegister::new("v1"),
            SimdRegister::new("v2"),
            SimdRegister::new("v3"),
            SimdRegister::new("v4"),
            SimdRegister::new("v5"),
            SimdRegister::new("v6"),
            SimdRegister::new("v7"),
            SimdRegister::new("v8"),
            SimdRegister::new("v9"),
            SimdRegister::new("v10"),
            SimdRegister::new("v11"),
            SimdRegister::new("v12"),
            SimdRegister::new("v13"),
            SimdRegister::new("v14"),
            SimdRegister::new("v15"),
            SimdRegister::new("v16"),
            SimdRegister::new("v17"),
            SimdRegister::new("v18"),
            SimdRegister::new("v19"),
            SimdRegister::new("v20"),
            SimdRegister::new("v21"),
            SimdRegister::new("v22"),
            SimdRegister::new("v23"),
            SimdRegister::new("v24"),
            SimdRegister::new("v25"),
            SimdRegister::new("v26"),
            SimdRegister::new("v27"),
            SimdRegister::new("v28"),
            SimdRegister::new("v29"),
            SimdRegister::new("v30"),
            SimdRegister::new("v31"),
        ]);

        let solver = Solver::new();
        let mut memory = BTreeMap::new();

        let max = ast::Int::from_i64(i64::MAX);
        let stack_max = ast::Int::new_const("MAX");
        solver.assert(stack_max.ge(&max));

        memory.insert(
            "sp".to_string(),
            MemorySafeRegion::new(
                AbstractExpression::Abstract("MAX".to_string()),
                RegionType::RW,
            ),
        );

        ARMCORTEXA {
            registers,
            loaded: [false; 33],
            simd_registers,
            zero: None,
            neg: None,
            carry: None,
            overflow: None,
            memory,
            memory_labels: BTreeMap::new(),
            data_symbol_sizes: BTreeMap::new(),
            code_labels: Rc::default(),
            select_definitions: BTreeMap::new(),
            symbols_bounding_counter: BTreeMap::new(),
            rw_queue: Vec::new(),
            element_facts: Rc::new(RefCell::new(BTreeMap::new())),
            stack_arguments: 0,
            red_zone: 0,
            findings: Rc::default(),
            current_line: 0,
            alignment: 4,
            flag_counter: 0,
            lane_bounds: Box::default(),
            write_journal: Vec::new(),
            blind_stack_writes: Vec::new(),
            symbolic_slots: Vec::new(),
            pointer_elements: BTreeMap::new(),
            element_ranges: BTreeMap::new(),
            pristine_read: None,
            solver,
        }
    }

    fn fits_in_32(&self, base: &Option<AbstractExpression>, offset: i64) -> bool {
        const MODULUS: i64 = 1 << 32;
        let Some(base) = base else {
            return (0..MODULUS).contains(&offset);
        };
        if base.size() > MAX_EXPRESSION_NODES {
            return false;
        }
        let whole = if offset == 0 {
            base.clone()
        } else {
            generate_expression("+", base.clone(), AbstractExpression::Immediate(offset))
        };
        if !is_translatable(&whole) {
            return false;
        }
        let Some(value) = expression_to_ast(whole) else {
            return false;
        };
        let unsat_within_budget = |outside: ast::Bool| {
            let mut bounded = Params::new();
            bounded.set_u32("rlimit", WORD_FIT_RESOURCE_LIMIT);
            self.solver.set_params(&bounded);
            let result = self.solver.check_assumptions(&[outside]);
            let mut unbounded = Params::new();
            unbounded.set_u32("rlimit", 0);
            self.solver.set_params(&unbounded);
            result == SatResult::Unsat
        };
        unsat_within_budget(value.lt(ast::Int::from_i64(0)))
            && unsat_within_budget(value.ge(ast::Int::from_i64(MODULUS)))
    }

    pub fn substitute_symbol(&mut self, symbol: &str, value: i64) {
        for i in 0..self.registers.len() {
            if let Some(register) = respelled(&self.registers[i], symbol, value) {
                self.registers[i] = register;
            }
        }
        for slot in self.symbolic_slots.iter_mut() {
            slot.base = substituted(&slot.base, symbol, value);
            if let Some(register) = respelled(&slot.value, symbol, value) {
                slot.value = register;
            }
        }
        self.canonical_stack_pointer();
    }

    pub fn add_pointer_elements(&mut self, region: &str, target: &str) {
        match self.memory.get(target) {
            Some(rows) if rows.kind == RegionType::READ => {
                self.pointer_elements
                    .insert(region.to_string(), target.to_string());
            }
            _ => panic!("pointer elements need a read-only region {target} to point into"),
        }
    }

    pub fn add_element_range(&mut self, region: &str, range: ElementRange) {
        self.element_ranges
            .entry(region.to_string())
            .or_default()
            .push(range);
    }

    pub fn remember_slot(
        &mut self,
        base: AbstractExpression,
        offset: i64,
        value: RegisterValue,
        width: i64,
    ) {
        self.symbolic_slots.push(SymbolicSlot {
            base,
            offset,
            width,
            value,
        });
    }

    pub fn recall_slot(
        &self,
        base: &AbstractExpression,
        offset: i64,
        width: i64,
    ) -> Option<RegisterValue> {
        self.symbolic_slots
            .iter()
            .rev()
            .find(|slot| slot.base == *base && slot.offset == offset && slot.width == width)
            .map(|slot| slot.value.clone())
    }

    pub fn forget_slots_overlapping(&mut self, base: &AbstractExpression, offset: i64, width: i64) {
        if self.symbolic_slots.is_empty() {
            return;
        }
        let written_region = self.region_of(base).map(|(region, ..)| region);
        let written = expression_to_ast(base.clone());
        let slots = std::mem::take(&mut self.symbolic_slots);
        self.symbolic_slots = slots
            .into_iter()
            .filter(|slot| {
                let slot_region = self.region_of(&slot.base).map(|(region, ..)| region);
                if written_region.is_some()
                    && slot_region.is_some()
                    && written_region != slot_region
                {
                    return true;
                }
                if slot.base == *base {
                    return offset + width <= slot.offset || slot.offset + slot.width <= offset;
                }
                let (Some(written), Some(kept)) = (&written, expression_to_ast(slot.base.clone()))
                else {
                    return false;
                };
                let start = ast::Int::add(&[written, &ast::Int::from_i64(offset)]);
                let slot_start = ast::Int::add(&[&kept, &ast::Int::from_i64(slot.offset)]);
                let overlap = ast::Bool::and(&[
                    &start.lt(ast::Int::add(&[
                        &slot_start,
                        &ast::Int::from_i64(slot.width),
                    ])),
                    &slot_start.lt(ast::Int::add(&[&start, &ast::Int::from_i64(width)])),
                ]);
                self.solver.check_assumptions(&[overlap]) == SatResult::Unsat
            })
            .collect();
    }

    pub fn get_state(&self) -> MachineState {
        (
            self.registers.to_vec(),
            self.zero.clone(),
            self.neg.clone(),
            self.carry.clone(),
            self.overflow.clone(),
        )
    }

    pub fn fingerprint(&self, with_flags: bool) -> String {
        use std::fmt::Write;
        let mut out = format!(
            "{:?}|{:?}|{:?}|",
            self.registers, self.loaded, self.simd_registers
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
            "{:?}|{:?}|{:?}|{:?}|{:?}|{:?}|{}|{}|{}|{}|{:?}|{:?}|{:?}|{:?}|{:?}",
            self.memory,
            self.select_definitions,
            self.symbols_bounding_counter,
            self.pointer_elements,
            self.element_ranges,
            self.rw_queue,
            self.stack_arguments,
            self.red_zone,
            self.alignment,
            self.flag_counter,
            self.lane_bounds,
            self.write_journal,
            self.blind_stack_writes,
            self.symbolic_slots,
            self.pristine_read,
        );
        out
    }

    pub fn set_state(&mut self, state: MachineState) {
        let (registers, zero, neg, carry, overflow) = state;
        self.registers = registers
            .try_into()
            .expect("an AArch64 state holds 33 registers");
        self.zero = zero;
        self.neg = neg;
        self.carry = carry;
        self.overflow = overflow;
    }

    pub fn unknown_flag(&mut self, which: &str) -> Option<FlagValue> {
        let n = self.flag_counter;
        self.flag_counter += 1;
        Some(FlagValue::Abstract(AbstractComparison::new(
            "==",
            AbstractExpression::Abstract(format!("{which}_flag_{n}")),
            AbstractExpression::Immediate(1),
        )))
    }

    pub fn next_carry(&mut self) -> usize {
        let n = self.flag_counter;
        self.flag_counter += 1;
        n
    }

    pub fn fresh_symbol(&mut self, which: &str) -> String {
        let n = self.flag_counter;
        self.flag_counter += 1;
        format!("{which}_{n}")
    }

    pub fn set_unknown_flags(&mut self) {
        let n = self.flag_counter;
        self.flag_counter += 1;
        let flag = |which: &str| {
            Some(FlagValue::Abstract(AbstractComparison::new(
                "==",
                AbstractExpression::Abstract(format!("{which}_flag_{n}")),
                AbstractExpression::Immediate(1),
            )))
        };
        self.neg = flag("neg");
        self.zero = flag("zero");
        self.carry = flag("carry");
        self.overflow = flag("overflow");
    }

    pub fn set_flags(&mut self, flags: [Option<FlagValue>; 4]) {
        let [zero, neg, carry, overflow] = flags;
        self.zero = zero;
        self.neg = neg;
        self.carry = carry;
        self.overflow = overflow;
    }

    pub fn set_immediate(&mut self, register: String, value: u64) {
        self.set_register(
            &operand_from_string(register),
            RegisterKind::Immediate,
            None,
            value as i64,
        );
    }

    pub fn set_abstract(&mut self, register: String, value: AbstractExpression) {
        self.set_register(
            &operand_from_string(register),
            RegisterKind::RegisterBase,
            Some(value),
            0,
        );
    }

    pub fn set_stack_element(
        &mut self,
        address: i64,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        self.stack_arguments = self.stack_arguments.max(address + 8);
        let stack = self
            .memory
            .get_mut("sp")
            .expect("stack region created at startup");
        stack.insert(
            address,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base,
                offset,
            },
        );
    }

    pub fn set_register(
        &mut self,
        register: &Operand,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        if let Operand::Register(RePrefix::X | RePrefix::W, n) = register {
            self.loaded[*n] = false;
        }
        match register {
            Operand::Register(prefix, num) => match prefix {
                RePrefix::X => self.registers[*num].set(kind, base, offset),
                RePrefix::W => {
                    if *num < 31 {
                        let (base, offset) = if self.fits_in_32(&base, offset) {
                            (base, offset)
                        } else {
                            narrow_to_32(base, offset)
                        };
                        self.registers[*num].set(kind, base, offset);
                    } else {
                        log::error!("Cannot set W register for xzr or sp");
                    }
                }
                RePrefix::Fp => self.registers[29].set(kind, base, offset),
                RePrefix::Ra => self.registers[30].set(kind, base, offset),
                RePrefix::Sp => {
                    self.registers[31].set(kind, base, offset);
                    self.canonical_stack_pointer();
                }
                RePrefix::Ze => (),
                RePrefix::V => unreachable!(),
            },
            Operand::VectorRegister(_, num) => {
                self.simd_registers[*num].set_from_register(
                    Arrangement::B16,
                    0,
                    kind,
                    base,
                    offset as u128,
                );
            }
            Operand::Vector(_, num, arr) => {
                self.simd_registers[*num].set_from_register(
                    arr.clone(),
                    0,
                    kind,
                    base,
                    offset as u128,
                );
            }
            Operand::VectorAccess(_, num, arr, index) => {
                self.simd_registers[*num].set_from_register(
                    arr.clone(),
                    *index as usize,
                    kind,
                    base,
                    offset as u128,
                );
            }
            a => todo!("not a valid register type for set register {:?}", a),
        }
    }

    pub fn region_named_by(&self, expression: &AbstractExpression) -> Option<String> {
        expression
            .get_abstracts()
            .into_iter()
            .find(|name| self.memory.contains_key(name) || self.memory_labels.contains_key(name))
    }

    pub fn set_current_line(&mut self, line: usize) {
        self.current_line = line;
    }

    pub fn note_finding(&self, what: &str) {
        let finding = format!("line {}: {what}", self.current_line);
        let mut findings = self.findings.borrow_mut();
        if !findings.contains(&finding) {
            log::warn!("{finding}");
            findings.push(finding);
        }
    }

    pub fn findings(&self) -> Vec<String> {
        self.findings.borrow().clone()
    }

    fn canonical_stack_pointer(&mut self) {
        if let Some(AbstractExpression::Immediate(displacement)) = self.stack_displacement() {
            self.registers[31].set(
                RegisterKind::RegisterBase,
                Some(AbstractExpression::Abstract("sp".to_string())),
                displacement,
            );
        }
    }

    pub fn stack_displacement(&self) -> Option<AbstractExpression> {
        let sp = &self.registers[31];
        if sp.kind != RegisterKind::RegisterBase {
            return None;
        }
        let entry = AbstractExpression::Abstract("sp".to_string());
        let form = crate::widening::Affine::of_register(sp)?;
        if form.coefficient(&entry) != 1 || !form.mentions_only_as_term(&entry) {
            return None;
        }
        Some(form.without(&entry).to_expression())
    }

    pub fn stack_bounds(&self) -> Option<(i64, i64)> {
        let sp = &self.registers[31];
        if sp.kind != RegisterKind::RegisterBase {
            return None;
        }
        match &sp.base {
            Some(AbstractExpression::Abstract(name)) if name == "sp" => {
                Some((std::cmp::min(sp.offset, 0), self.stack_arguments))
            }
            _ => None,
        }
    }

    pub fn get_register(&mut self, reg: &Operand) -> RegisterValue {
        match reg {
            Operand::Register(prefix, index) => match prefix {
                RePrefix::Fp => self.registers[29].clone(),
                RePrefix::Ra => self.registers[30].clone(),
                RePrefix::Sp => self.registers[31].clone(),
                RePrefix::Ze => self.registers[32].clone(),
                RePrefix::X => self.registers[*index].clone(),
                RePrefix::W => {
                    let whole = self.registers[*index].clone();
                    let (base, offset) = narrow_to_32(whole.base, whole.offset);
                    RegisterValue::new(whole.kind, base, offset)
                }
                RePrefix::V => unreachable!(),
            },
            Operand::Immediate(value) => RegisterValue::new_imm(*value),
            Operand::VectorRegister(_, index) => self.simd_registers[*index].get_as_register(),
            Operand::Vector(_, index, _) => self.simd_registers[*index].clone().get_as_register(),
            Operand::VectorAccess(_, index, _, _) => {
                self.simd_registers[*index].clone().get_as_register()
            }
            Operand::ShiftedRegister(register, op, amount) => {
                let value = self.get_register(register);
                instruction_aux::shift_imm(op.clone(), value, *amount)
            }
            a => panic!("Not a valid register operand for get operation {:?}", a),
        }
    }

    pub fn get_simd_register(&mut self, reg: &Operand) -> SimdRegister {
        match reg {
            Operand::VectorRegister(_, index) => self.simd_registers[*index].clone(),
            Operand::Vector(_, index, _) => self.simd_registers[*index].clone(),
            Operand::VectorAccess(_, index, _, _) => self.simd_registers[*index].clone(),
            _ => panic!("cannot get register {:?} as a simd register", reg),
        }
    }

    pub fn set_simd_register(&mut self, reg: &Operand, src: SimdRegister) {
        match reg {
            Operand::VectorRegister(_, index) => self.simd_registers[*index] = src,
            Operand::Vector(_, index, _) => self.simd_registers[*index] = src,
            Operand::VectorAccess(_, index, _, _) => self.simd_registers[*index] = src,
            _ => panic!("cannot get register {:?} as a simd register", reg),
        }
    }

    pub fn grow_memory_region(&mut self, name: String, end: i64) {
        if let Some(r) = self.memory.get_mut(&name) {
            r.grow_to(end);
        }
    }

    fn label_to_memory_index(&self, label: &str) -> Option<(String, i64)> {
        let label = label
            .trim_start_matches(":pg_hi21_nc:")
            .trim_start_matches(":pg_hi21:")
            .trim_start_matches(":lo12:");
        let split_addend = label.rfind(['+', '-']).filter(|&at| at > 0).and_then(|at| {
            let addend: String = label[at..].chars().filter(|c| !c.is_whitespace()).collect();
            let addend = crate::loader::parse_integer(addend.trim_start_matches('+'))?;
            Some((label[..at].trim(), addend))
        });
        let (symbol, addend) = split_addend.unwrap_or((label, 0));
        let (base, offset) = self.symbol_address(symbol)?;
        Some((base, offset + addend))
    }

    pub fn check_stack_pointer_restored(&self, pc: usize) {
        let s = &self.registers[31];
        match &s.base {
            Some(b) => {
                if b == &AbstractExpression::Abstract("sp".to_string()) && s.offset == 0 {
                    log::info!("Stack pointer restored to start");
                } else {
                    log::error!(
                        "line {pc}: stack pointer not restored on return: sp is {} {:+}",
                        b,
                        s.offset
                    );
                }
            }
            None => {
                log::error!("line {pc}: stack pointer not restored on return: sp has no base");
            }
        }
    }

    pub fn clear_rw_queue(&mut self) {
        self.rw_queue = Vec::new();
    }

    pub fn read_rw_queue(&self) -> Vec<MemoryAccess> {
        self.rw_queue.clone()
    }

    pub fn change_alignment(&mut self, value: i64) {
        self.alignment = value;
    }

    pub fn get_alignment(&mut self) -> i64 {
        self.alignment
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_arithmetic_add_imm_registers() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::Immediate,
            None,
            2,
        );
        computer.set_register(
            &Operand::Register(RePrefix::X, 2),
            RegisterKind::Immediate,
            None,
            3,
        );
        let _ = computer.execute(0, &Instruction::new("add x0, x1, x2".to_string()));
        let result = computer
            .get_register(&Operand::Register(RePrefix::X, 0))
            .offset;
        assert_eq!(result, 5);
    }

    #[test]
    fn test_arithmetic_add_abstract_and_imm() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("hello,".to_string())),
            0,
        );
        computer.set_register(
            &Operand::Register(RePrefix::X, 2),
            RegisterKind::Immediate,
            None,
            5,
        );
        let _ = computer.execute(0, &Instruction::new("add x0, x1, x2".to_string()));
        let result = computer.get_register(&Operand::Register(RePrefix::X, 0));
        assert_eq!(
            result,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(AbstractExpression::Abstract("hello,".to_string())),
                offset: 5,
            }
        );
    }

    #[test]
    fn test_arithmetic_and_abstract_and_imm() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("len".to_string())),
            0,
        );
        let _ = computer.execute(0, &Instruction::new("and x0, x1, #1".to_string()));
        let result = computer.get_register(&Operand::Register(RePrefix::X, 0));
        assert_eq!(
            result,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(generate_expression(
                    "&",
                    AbstractExpression::Abstract("len".to_string()),
                    AbstractExpression::Immediate(1),
                )),
                offset: 0,
            }
        );
    }

    #[test]
    fn test_arithmetic_add_abstract_registers() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("hello,".to_string())),
            0,
        );
        computer.set_register(
            &Operand::Register(RePrefix::X, 2),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("world!".to_string())),
            0,
        );
        let _ = computer.execute(0, &Instruction::new("add x0, x1, x2".to_string()));
        let result = computer.get_register(&Operand::Register(RePrefix::X, 0));
        assert_eq!(
            result,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(generate_expression(
                    "+",
                    AbstractExpression::Abstract("hello,".to_string()),
                    AbstractExpression::Abstract("world!".to_string())
                )),
                offset: 0,
            }
        );
    }

    #[test]
    fn test_arithmetic_add_with_shift() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("hello,".to_string())),
            0,
        );
        computer.set_register(
            &Operand::Register(RePrefix::X, 2),
            RegisterKind::Immediate,
            None,
            3,
        );
        let _ = computer.execute(0, &Instruction::new("add x0, x1, x2, lsl#2".to_string()));
        let result = computer.get_register(&Operand::Register(RePrefix::X, 0));
        assert_eq!(
            result,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(AbstractExpression::Abstract("hello,".to_string())),
                offset: 12,
            }
        );
    }

    #[test]
    fn test_arithmetic_add_abstract_and_imm_instruction() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("hello,".to_string())),
            0,
        );
        let _ = computer.execute(0, &Instruction::new("add x0, x1, #7".to_string()));
        let result = computer.get_register(&Operand::Register(RePrefix::X, 0));
        assert_eq!(
            result,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(AbstractExpression::Abstract("hello,".to_string())),
                offset: 7,
            }
        );
    }

    #[test]
    fn test_vector_writeback_symbolic_register_step() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 0),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("dst".to_string())),
            4,
        );
        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("stride".to_string())),
            2,
        );
        let address = computer.get_register(&Operand::Register(RePrefix::X, 0));
        computer.apply_writeback(
            &RePrefix::X,
            0,
            &address,
            &None,
            &Some(Box::new(Operand::Register(RePrefix::X, 1))),
            &None,
        );
        let result = computer.get_register(&Operand::Register(RePrefix::X, 0));
        assert_eq!(
            result,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(generate_expression(
                    "+",
                    AbstractExpression::Abstract("dst".to_string()),
                    AbstractExpression::Abstract("stride".to_string())
                )),
                offset: 6,
            }
        );
    }

    #[test]
    fn vector_eor_stores_its_result() {
        let mut computer = ARMCORTEXA::new();
        computer.simd_registers[1].offset = [0xff; 16];
        computer.simd_registers[2].offset = [0x0f; 16];

        let _ = computer.execute(
            0,
            &Instruction::new("eor v0.16b, v1.16b, v2.16b".to_string()),
        );

        assert_eq!(computer.simd_registers[0].offset, [0xf0; 16]);
    }

    #[test]
    fn movk_replaces_only_the_halfword_the_shift_selects() {
        let mut computer = ARMCORTEXA::new();

        let _ = computer.execute(0, &Instruction::new("movz w28, #31129".to_string()));
        let _ = computer.execute(0, &Instruction::new("movk w28, #23170, lsl#16".to_string()));

        assert_eq!(
            computer.get_register(&Operand::Register(RePrefix::W, 28)),
            RegisterValue {
                kind: RegisterKind::Immediate,
                base: None,
                offset: (23170 << 16) | 31129,
            }
        );
    }

    #[test]
    fn test_branch_ge_concrete_and_abstract() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::Immediate,
            None,
            5,
        );
        computer.set_register(
            &Operand::Register(RePrefix::X, 2),
            RegisterKind::Immediate,
            None,
            3,
        );
        let _ = computer.execute(0, &Instruction::new("cmp x1, x2".to_string()));
        let taken = computer.execute(1, &Instruction::new("b.ge target".to_string()));
        assert!(matches!(taken, Ok(ExecuteReturnType::JumpLabel(ref l)) if l == "target"));

        let _ = computer.execute(2, &Instruction::new("cmp x2, x1".to_string()));
        let skipped = computer.execute(3, &Instruction::new("b.ge target".to_string()));
        assert!(matches!(skipped, Ok(ExecuteReturnType::Next)));

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("n".to_string())),
            0,
        );
        let _ = computer.execute(4, &Instruction::new("cmp x1, x2".to_string()));
        let forked = computer.execute(5, &Instruction::new("b.ge target".to_string()));
        assert!(matches!(
            forked,
            Ok(ExecuteReturnType::ConditionalJumpLabel(ref c, ref l)) if c.op == ">=" && l == "target"
        ));
    }

    #[test]
    fn test_shift_immediate_uses_opcode() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::Immediate,
            None,
            256,
        );
        let _ = computer.execute(0, &Instruction::new("lsr x0, x1, #6".to_string()));
        let _ = computer.execute(1, &Instruction::new("lsl x2, x1, #2".to_string()));
        computer.set_register(
            &Operand::Register(RePrefix::X, 4),
            RegisterKind::Immediate,
            None,
            -256,
        );
        let _ = computer.execute(2, &Instruction::new("asr x5, x4, #4".to_string()));
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 5))
                .offset,
            -16
        );
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 0))
                .offset,
            4
        );
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 2))
                .offset,
            1024
        );
    }

    #[test]
    fn test_memory_address_extended_register_offset() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 2),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("p".to_string())),
            0,
        );
        computer.set_register(
            &Operand::Register(RePrefix::X, 8),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("i".to_string())),
            3,
        );
        let address = computer.memory_address(
            &RePrefix::X,
            2,
            &Some(4),
            &Some(Box::new(Operand::ShiftedRegister(
                Box::new(Operand::Register(RePrefix::W, 8)),
                "uxtw".to_string(),
                1,
            ))),
        );
        assert_eq!(
            address,
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(generate_expression(
                    "+",
                    AbstractExpression::Abstract("p".to_string()),
                    generate_expression(
                        "lsl",
                        generate_expression(
                            "%",
                            generate_expression(
                                "+",
                                AbstractExpression::Abstract("i".to_string()),
                                AbstractExpression::Immediate(3)
                            ),
                            AbstractExpression::Immediate(1 << 32)
                        ),
                        AbstractExpression::Immediate(1)
                    )
                )),
                offset: 4,
            }
        );
    }

    #[test]
    fn test_pre_and_post_index_writeback() {
        let mut computer = ARMCORTEXA::new();
        let sp = Operand::Register(RePrefix::Sp, 0);

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::Immediate,
            None,
            7,
        );
        computer.set_register(
            &Operand::Register(RePrefix::X, 2),
            RegisterKind::Immediate,
            None,
            9,
        );
        let sp_start = computer.get_register(&sp).offset;

        for (pc, text, expected_sp) in [
            (0, "str x1, [sp, #-32]!", sp_start - 32),
            (1, "stp x1, x2, [sp, #-16]!", sp_start - 48),
            (2, "str x2, [sp, #8]", sp_start - 48),
            (3, "ldp x3, x4, [sp], #16", sp_start - 32),
            (4, "ldr x5, [sp], #32", sp_start),
        ] {
            let result = computer.execute(pc, &Instruction::new(text.to_string()));
            assert!(result.is_ok(), "{}: {:?}", text, result);
            assert_eq!(computer.get_register(&sp).offset, expected_sp, "{}", text);
        }

        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 3))
                .offset,
            7
        );
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 4))
                .offset,
            9
        );
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 5))
                .offset,
            7
        );
    }

    fn set_imm(computer: &mut ARMCORTEXA, register: usize, value: i64) {
        computer.set_register(
            &Operand::Register(RePrefix::X, register),
            RegisterKind::Immediate,
            None,
            value,
        );
    }

    fn set_symbolic(computer: &mut ARMCORTEXA, register: usize, name: &str, offset: i64) {
        computer.set_register(
            &Operand::Register(RePrefix::X, register),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract(name.to_string())),
            offset,
        );
    }

    fn run(computer: &mut ARMCORTEXA, text: &str) -> ExecuteReturnType {
        computer
            .execute(0, &Instruction::new(text.to_string()))
            .unwrap_or_else(|e| panic!("{}: {}", text, e))
    }

    fn taken(computer: &mut ARMCORTEXA, branch: &str) -> bool {
        match run(computer, &format!("{} target", branch)) {
            ExecuteReturnType::JumpLabel(_) => true,
            ExecuteReturnType::Next => false,
            other => panic!("{} was not decided: {:?}", branch, other),
        }
    }

    #[test]
    fn test_subs_flags_use_source_operands() {
        let mut computer = ARMCORTEXA::new();

        set_imm(&mut computer, 0, 5);
        run(&mut computer, "subs x0, x0, #2");
        assert!(taken(&mut computer, "b.gt"));
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 0))
                .offset,
            3
        );
        run(&mut computer, "subs x0, x0, #3");
        assert!(!taken(&mut computer, "b.gt"));
        assert!(taken(&mut computer, "b.eq"));
        assert!(taken(&mut computer, "b.hs"));
    }

    #[test]
    fn test_compare_concrete_signed_unsigned_and_width() {
        let mut computer = ARMCORTEXA::new();

        set_imm(&mut computer, 1, -1);
        set_imm(&mut computer, 2, 1);
        run(&mut computer, "cmp x1, x2");
        assert!(taken(&mut computer, "b.lt"));
        assert!(!taken(&mut computer, "b.ge"));
        assert!(!taken(&mut computer, "b.lo"));
        assert!(taken(&mut computer, "b.hi"));
        assert!(taken(&mut computer, "b.mi"));

        set_imm(&mut computer, 3, 0x1_0000_0001);
        run(&mut computer, "cmp w3, #1");
        assert!(taken(&mut computer, "b.eq"));
        run(&mut computer, "cmp x3, #1");
        assert!(!taken(&mut computer, "b.eq"));

        set_imm(&mut computer, 4, 1);
        run(&mut computer, "cmp x4, x2, lsl #1");
        assert!(taken(&mut computer, "b.lt"));

        run(&mut computer, "cmn x1, #1");
        assert!(taken(&mut computer, "b.eq"));
        assert!(taken(&mut computer, "b.cs"));
        assert!(!taken(&mut computer, "b.vs"));

        set_imm(&mut computer, 5, i64::MAX);
        run(&mut computer, "cmn x5, #1");
        assert!(taken(&mut computer, "b.vs"));
        assert!(taken(&mut computer, "b.mi"));
        assert!(!taken(&mut computer, "b.lt"));
    }

    #[test]
    fn test_compare_unknown_operand_is_symbolic() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::Number,
            None,
            0,
        );
        run(&mut computer, "cmp x1, #0");
        match run(&mut computer, "b.eq target") {
            ExecuteReturnType::ConditionalJumpLabel(condition, _) => {
                assert!(
                    condition
                        .get_abstracts()
                        .iter()
                        .any(|a| a.contains("_flag_"))
                );
            }
            other => panic!("expected a symbolic branch, got {:?}", other),
        }
    }

    fn register_ast(computer: &mut ARMCORTEXA, operand: Operand) -> ast::Int {
        let value = computer.get_register(&operand);
        expression_to_ast(AbstractExpression::Register(Box::new(value))).unwrap()
    }

    fn proves(computer: &ARMCORTEXA, fact: ast::Bool) -> bool {
        computer.solver.check_assumptions(&[fact.not()]) == SatResult::Unsat
    }

    fn with_region(name: &str, length: i64) -> ARMCORTEXA {
        let mut computer = ARMCORTEXA::new();
        computer.add_memory_region(
            name.to_string(),
            RegionType::RW,
            AbstractExpression::Immediate(length),
        );
        set_symbolic(&mut computer, 0, name, 0);
        computer
    }

    fn x(computer: &mut ARMCORTEXA, n: usize) -> RegisterValue {
        computer.get_register(&Operand::Register(RePrefix::X, n))
    }

    #[test]
    fn test_unwritten_memory_loads_as_a_named_location() {
        let mut computer = with_region("rr", 64);
        run(&mut computer, "ldr x1, [x0, #8]");
        run(&mut computer, "ldr x2, [x0, #8]");
        run(&mut computer, "ldr x3, [x0, #16]");
        assert_eq!(
            x(&mut computer, 1).base,
            Some(AbstractExpression::Abstract("rr[8:8]".to_string()))
        );
        assert_eq!(x(&mut computer, 1), x(&mut computer, 2));
        assert_ne!(x(&mut computer, 1), x(&mut computer, 3));
    }

    #[test]
    fn test_a_store_to_one_field_keeps_the_next_fields_name() {
        let mut computer = with_region("s", 32);
        set_imm(&mut computer, 1, 7);
        run(&mut computer, "ldr x2, [x0, #8]");
        run(&mut computer, "str x1, [x0]");
        run(&mut computer, "ldr x3, [x0, #8]");
        assert_eq!(x(&mut computer, 2), x(&mut computer, 3));
    }

    #[test]
    fn test_a_store_is_read_back_and_replaces_what_it_overlaps() {
        let mut computer = with_region("buf", 64);
        set_imm(&mut computer, 1, 7);
        set_imm(&mut computer, 2, 9);
        run(&mut computer, "str x1, [x0, #8]");
        run(&mut computer, "ldr x3, [x0, #8]");
        assert_eq!(x(&mut computer, 3).offset, 7);
        run(&mut computer, "str w2, [x0, #12]");
        run(&mut computer, "ldr x4, [x0, #8]");
        assert_ne!(x(&mut computer, 4).kind, RegisterKind::Immediate);
    }

    #[test]
    fn test_a_store_at_a_symbolic_address_forgets_the_region() {
        let mut computer = with_region("buf", 64);
        set_imm(&mut computer, 1, 7);
        run(&mut computer, "str x1, [x0, #8]");
        run(&mut computer, "ldr x5, [x0, #24]");
        set_symbolic(&mut computer, 2, "i", 0);
        computer
            .solver
            .assert(ast::Int::new_const("i").ge(ast::Int::from_i64(0)));
        computer
            .solver
            .assert(ast::Int::new_const("i").le(ast::Int::from_i64(7)));
        run(&mut computer, "str x1, [x0, x2, lsl #3]");
        run(&mut computer, "ldr x3, [x0, #8]");
        run(&mut computer, "ldr x4, [x0, #24]");
        assert_ne!(x(&mut computer, 3).kind, RegisterKind::Immediate);
        assert_ne!(x(&mut computer, 4), x(&mut computer, 5));
    }

    #[test]
    fn test_a_wide_load_assembles_the_bytes_it_covers() {
        let mut computer = with_region("tbl", 8);
        for (at, byte) in [(0, 0x00), (1, 0x04), (2, 0x2c), (3, 0x01)] {
            computer.add_memory_value("tbl".to_string(), at, byte, 1);
        }
        run(&mut computer, "ldrh w1, [x0]");
        run(&mut computer, "ldrh w2, [x0, #2]");
        run(&mut computer, "ldr w3, [x0]");
        assert_eq!(x(&mut computer, 1).offset, 1024);
        assert_eq!(x(&mut computer, 2).offset, 300);
        assert_eq!(x(&mut computer, 3).offset, 0x012c_0400);
    }

    #[test]
    fn test_tbz_and_tbnz_test_one_bit() {
        let mut computer = ARMCORTEXA::new();
        set_imm(&mut computer, 14, 0b10000);
        assert!(taken(&mut computer, "tbnz w14, #4,"));
        assert!(!taken(&mut computer, "tbz w14, #4,"));
        assert!(taken(&mut computer, "tbz w14, #3,"));
        set_symbolic(&mut computer, 14, "edges", 0);
        match run(&mut computer, "tbnz w14, #4, target") {
            ExecuteReturnType::ConditionalJumpLabel(condition, _) => assert_eq!(condition.op, "!="),
            other => panic!("expected a split, got {other:?}"),
        }
    }

    #[test]
    fn test_an_extend_without_an_amount_is_arithmetic() {
        let i = Instruction::new("sub x9, x2, w9, sxtb".to_string());
        assert_eq!(i.ty, InstructionType::Arithmetic);
        let mut computer = ARMCORTEXA::new();
        set_imm(&mut computer, 2, 100);
        set_imm(&mut computer, 9, 0xfe);
        run(&mut computer, "sub x9, x2, w9, sxtb");
        assert_eq!(x(&mut computer, 9).offset, 102);
    }

    #[test]
    fn test_clz_of_constants_counts_within_the_register_width() {
        let mut computer = ARMCORTEXA::new();
        for (value, text, expected) in [
            (4, "clz w0, w1", 29),
            (0, "clz w0, w1", 32),
            (0x1_0000_0001, "clz w0, w1", 31),
            (1, "clz x0, x1", 63),
            (-1, "clz x0, x1", 0),
            (0, "clz x0, x1", 64),
        ] {
            set_imm(&mut computer, 1, value);
            run(&mut computer, text);
            let result = computer.get_register(&Operand::Register(RePrefix::X, 0));
            assert_eq!(result.kind, RegisterKind::Immediate, "{text} of {value}");
            assert_eq!(result.offset, expected, "{text} of {value}");
        }
    }

    #[test]
    fn test_clz_of_a_symbol_is_bounded_by_the_width() {
        let mut computer = ARMCORTEXA::new();
        set_symbolic(&mut computer, 1, "v", 0);
        run(&mut computer, "clz w0, w1");
        let count = register_ast(&mut computer, Operand::Register(RePrefix::X, 0));
        assert!(proves(&computer, count.ge(ast::Int::from_i64(0))));
        assert!(proves(&computer, count.le(ast::Int::from_i64(32))));
        run(&mut computer, "clz x2, x1");
        let count = register_ast(&mut computer, Operand::Register(RePrefix::X, 2));
        assert!(proves(&computer, count.le(ast::Int::from_i64(64))));
        assert!(!proves(&computer, count.le(ast::Int::from_i64(63))));
    }

    #[test]
    fn test_clz_ties_the_count_to_the_input_range() {
        let mut computer = ARMCORTEXA::new();
        set_symbolic(&mut computer, 3, "width", 0);
        let width = ast::Int::new_const("width");
        computer.solver.assert(width.ge(ast::Int::from_i64(4)));
        computer.solver.assert(width.le(ast::Int::from_i64(64)));
        run(&mut computer, "clz w3, w3");
        let count = register_ast(&mut computer, Operand::Register(RePrefix::X, 3));
        assert!(proves(&computer, count.ge(ast::Int::from_i64(25))));
        assert!(proves(&computer, count.le(ast::Int::from_i64(29))));
        computer.solver.push();
        computer.solver.assert(count.eq(ast::Int::from_i64(29)));
        assert!(proves(&computer, width.lt(ast::Int::from_i64(8))));
        computer.solver.pop(1);
    }

    #[test]
    fn test_clz_dispatch_index_stays_inside_the_table() {
        let mut computer = ARMCORTEXA::new();
        set_symbolic(&mut computer, 3, "width", 0);
        let width = ast::Int::new_const("width");
        computer.solver.assert(width.ge(ast::Int::from_i64(4)));
        computer.solver.assert(width.le(ast::Int::from_i64(64)));
        run(&mut computer, "clz w3, w3");
        run(&mut computer, "sub w3, w3, #25");
        let index = register_ast(&mut computer, Operand::Register(RePrefix::W, 3));
        assert!(proves(&computer, index.ge(ast::Int::from_i64(0))));
        assert!(proves(&computer, index.le(ast::Int::from_i64(4))));
    }

    #[test]
    fn test_clz_of_an_unknown_stays_unknown() {
        let mut computer = ARMCORTEXA::new();
        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::Number,
            None,
            0,
        );
        run(&mut computer, "clz w0, w1");
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 0))
                .kind,
            RegisterKind::Number
        );
    }

    #[test]
    fn test_conditional_select_ne_le_ge_on_concrete_flags() {
        let mut computer = ARMCORTEXA::new();
        set_imm(&mut computer, 1, 3);
        set_imm(&mut computer, 2, 5);
        run(&mut computer, "cmp x1, x2");
        for (cc, expected) in [("ne", 3), ("le", 3), ("ge", 5)] {
            run(&mut computer, &format!("csel x0, x1, x2, {cc}"));
            assert_eq!(
                computer
                    .get_register(&Operand::Register(RePrefix::X, 0))
                    .offset,
                expected,
                "csel {cc}"
            );
        }
        run(&mut computer, "cmp x1, x1");
        run(&mut computer, "csel x0, x1, x2, le");
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 0))
                .offset,
            3
        );
        run(&mut computer, "csel x0, x1, x2, ne");
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 0))
                .offset,
            5
        );
    }

    #[test]
    fn test_conditional_select_on_carry() {
        let mut computer = ARMCORTEXA::new();

        set_symbolic(&mut computer, 1, "a", 0);
        set_symbolic(&mut computer, 2, "b", 0);
        run(&mut computer, "cmp x1, x2");
        let zext = |name: &str| {
            generate_expression(
                "zext",
                AbstractExpression::Register(Box::new(RegisterValue {
                    kind: RegisterKind::RegisterBase,
                    base: Some(AbstractExpression::Abstract(name.to_string())),
                    offset: 0,
                })),
                AbstractExpression::Immediate(64),
            )
        };
        assert_eq!(
            run(&mut computer, "cset w0, lo"),
            ExecuteReturnType::Select(
                AbstractComparison::new("<", zext("a"), zext("b")),
                Operand::Register(RePrefix::W, 0),
                RegisterValue::new_imm(1),
                RegisterValue::new_imm(0),
            )
        );
        let a = computer.get_register(&Operand::Register(RePrefix::X, 1));
        let b = computer.get_register(&Operand::Register(RePrefix::X, 2));
        assert_eq!(
            run(&mut computer, "csel x3, x1, x2, hs"),
            ExecuteReturnType::Select(
                AbstractComparison::new(">=", zext("a"), zext("b")),
                Operand::Register(RePrefix::X, 3),
                a,
                b,
            )
        );

        set_imm(&mut computer, 1, 5);
        set_imm(&mut computer, 2, 3);
        run(&mut computer, "cmp x1, x2");
        run(&mut computer, "csel x3, x1, x2, hs");
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 3))
                .offset,
            5
        );
        run(&mut computer, "csel x3, x1, x2, lo");
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 3))
                .offset,
            3
        );
        run(&mut computer, "csetm x4, eq");
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 4))
                .offset,
            0
        );
        run(&mut computer, "cmp x1, x1");
        run(&mut computer, "csetm x4, eq");
        assert_eq!(
            computer
                .get_register(&Operand::Register(RePrefix::X, 4))
                .offset,
            -1
        );
    }

    #[test]
    fn test_logic_flags() {
        let mut computer = ARMCORTEXA::new();

        set_imm(&mut computer, 1, 6);
        run(&mut computer, "tst x1, #4");
        assert!(taken(&mut computer, "b.ne"));
        run(&mut computer, "tst x1, #1");
        assert!(taken(&mut computer, "b.eq"));
        assert!(!taken(&mut computer, "b.hs"));

        set_symbolic(&mut computer, 5, "v", 0);
        run(&mut computer, "ands x6, x5, #1");
        assert!(matches!(
            run(&mut computer, "b.eq target"),
            ExecuteReturnType::ConditionalJumpLabel(..)
        ));
    }

    #[test]
    fn test_same_base_compare_is_decided() {
        let mut computer = ARMCORTEXA::new();

        set_symbolic(&mut computer, 0, "p", 8);
        set_symbolic(&mut computer, 1, "p", 16);
        run(&mut computer, "cmp x0, x1");
        assert!(taken(&mut computer, "b.lo"));
        assert!(taken(&mut computer, "b.ne"));
        assert!(!taken(&mut computer, "b.hs"));
    }

    #[test]
    fn test_bitfield_extraction_concrete() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::Immediate,
            None,
            0x1234_8765,
        );
        for (text, expected) in [
            ("ubfx w0, w1, #7, #7", (0x1234_8765i64 >> 7) & 0x7f),
            ("sbfx x0, x1, #16, #16", 0x1234),
            ("sbfx x0, x1, #0, #16", 0x8765 - 0x10000),
            ("sxth x0, w1", 0x8765 - 0x10000),
            ("sxtb x0, w1", 0x65),
            ("uxth w0, w1", 0x8765),
            ("sxtw x0, w1", 0x1234_8765),
        ] {
            let _ = computer.execute(0, &Instruction::new(text.to_string()));
            let result = computer.get_register(&Operand::Register(RePrefix::X, 0));
            assert_eq!(result.kind, RegisterKind::Immediate, "{}", text);
            assert_eq!(result.offset, expected, "{}", text);
        }
    }

    #[test]
    fn test_bitfield_extraction_symbolic() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 1),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("v".to_string())),
            0,
        );
        let _ = computer.execute(0, &Instruction::new("ubfx w0, w1, #7, #7".to_string()));
        let wrap = |e| generate_expression("%", e, AbstractExpression::Immediate(1 << 32));
        assert_eq!(
            computer.get_register(&Operand::Register(RePrefix::X, 0)),
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(generate_expression(
                    "%",
                    generate_expression(
                        "lsr",
                        wrap(AbstractExpression::Abstract("v".to_string())),
                        AbstractExpression::Immediate(7)
                    ),
                    AbstractExpression::Immediate(128)
                )),
                offset: 0,
            }
        );

        computer.set_register(
            &Operand::Register(RePrefix::X, 2),
            RegisterKind::Number,
            None,
            0,
        );
        let _ = computer.execute(1, &Instruction::new("sxth x3, w2".to_string()));
        let extended = computer.get_register(&Operand::Register(RePrefix::X, 3));
        assert_eq!(extended.kind, RegisterKind::RegisterBase);
        let shown = extended.base.expect("a bounded field").to_string();
        assert!(
            shown.contains("-32768") && shown.contains("32767"),
            "{shown}"
        );
    }

    #[test]
    fn movk_over_an_unknown_destination_stays_unknown() {
        let mut computer = ARMCORTEXA::new();

        computer.set_register(
            &Operand::Register(RePrefix::X, 4),
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract("len".to_string())),
            0,
        );
        let _ = computer.execute(0, &Instruction::new("movk x4, #23170, lsl#16".to_string()));

        assert_eq!(
            computer.get_register(&Operand::Register(RePrefix::X, 4)),
            RegisterValue {
                kind: RegisterKind::Number,
                base: None,
                offset: 0,
            }
        );
    }

    fn counter_can_reach_ten(counter_is_bounded_by_its_facts: bool) -> bool {
        let mut computer = ARMCORTEXA::new();
        let (counter, clamp, length) = (
            AbstractExpression::Abstract("loop7_?".to_string()),
            AbstractExpression::Abstract("select_3".to_string()),
            AbstractExpression::Abstract("len".to_string()),
        );
        computer.select_definitions.insert(
            "select_3".to_string(),
            (
                AbstractComparison::new("<", length.clone(), AbstractExpression::Immediate(10)),
                length,
                AbstractExpression::Immediate(10),
            ),
        );
        let trip_fact = AbstractComparison::new("<", counter.clone(), clamp);
        computer
            .solver
            .assert(comparison_to_ast(trip_fact.clone()).expect("trip fact"));
        if counter_is_bounded_by_its_facts {
            computer
                .symbols_bounding_counter
                .insert("loop7_?".to_string(), trip_fact.get_abstracts());
        }
        let mut assuming = computer.select_assumptions(&counter);
        assuming.push(
            comparison_to_ast(AbstractComparison::new(
                ">=",
                counter,
                AbstractExpression::Immediate(10),
            ))
            .expect("reach"),
        );
        computer.solver.check_assumptions(&assuming) == SatResult::Sat
    }

    #[test]
    fn a_counter_brings_the_definitions_of_the_selects_bounding_it() {
        assert!(!counter_can_reach_ten(true));
        assert!(counter_can_reach_ten(false));
    }
}

#[cfg(test)]
mod lane_range_tests {
    use super::*;

    fn vector(index: usize) -> Operand {
        Operand::Vector(RePrefix::V, index, Arrangement::H8)
    }

    #[test]
    fn test_parse_lane_reduction() {
        let addv = Instruction::new("addv h31, v6.8h".to_string());
        assert_eq!(addv.opcode, "addv");
        assert_eq!(addv.ty, InstructionType::SIMDArithmetic);
        assert_eq!(
            addv.operands[1],
            Operand::Vector(RePrefix::V, 6, Arrangement::H8)
        );

        let smov = Instruction::new("smov w15, v31.h[0]".to_string());
        assert_eq!(smov.opcode, "smov");
        assert_eq!(smov.ty, InstructionType::SIMDManagement);
        assert_eq!(smov.operands[0], Operand::Register(RePrefix::W, 15));
        assert_eq!(
            smov.operands[1],
            Operand::VectorAccess(RePrefix::V, 31, Arrangement::H, 0)
        );
    }

    #[test]
    fn test_compare_sets_lane_range() {
        let mut computer = ARMCORTEXA::new();
        let _ = computer.execute(
            0,
            &Instruction::new("cmhs v2.8h, v30.8h, v4.8h".to_string()),
        );
        assert_eq!(computer.lane_range(&vector(2)), Some((-1, 0)));
    }

    #[test]
    fn test_add_sums_lane_ranges() {
        let mut computer = ARMCORTEXA::new();
        let _ = computer.execute(
            0,
            &Instruction::new("cmhs v2.8h, v30.8h, v4.8h".to_string()),
        );
        let _ = computer.execute(
            0,
            &Instruction::new("cmhs v3.8h, v30.8h, v5.8h".to_string()),
        );
        let _ = computer.execute(0, &Instruction::new("add v6.8h, v2.8h, v3.8h".to_string()));
        assert_eq!(computer.lane_range(&vector(6)), Some((-2, 0)));
    }

    #[test]
    fn test_add_without_ranges_keeps_none() {
        let mut computer = ARMCORTEXA::new();
        let _ = computer.execute(
            0,
            &Instruction::new("cmhs v6.8h, v30.8h, v4.8h".to_string()),
        );
        let _ = computer.execute(0, &Instruction::new("add v6.8h, v0.8h, v1.8h".to_string()));
        assert_eq!(computer.lane_range(&vector(6)), None);
    }

    #[test]
    fn test_unrelated_write_clears_lane_range() {
        let mut computer = ARMCORTEXA::new();
        let _ = computer.execute(
            0,
            &Instruction::new("cmhs v2.8h, v30.8h, v4.8h".to_string()),
        );
        let _ = computer.execute(0, &Instruction::new("mul v2.8h, v0.8h, v1.8h".to_string()));
        assert_eq!(computer.lane_range(&vector(2)), None);
    }

    #[test]
    fn test_addv_scales_by_lane_count() {
        let mut computer = ARMCORTEXA::new();
        let _ = computer.execute(
            0,
            &Instruction::new("cmhs v2.8h, v30.8h, v4.8h".to_string()),
        );
        let _ = computer.execute(
            0,
            &Instruction::new("cmhs v3.8h, v30.8h, v5.8h".to_string()),
        );
        let _ = computer.execute(0, &Instruction::new("add v6.8h, v2.8h, v3.8h".to_string()));
        let _ = computer.execute(0, &Instruction::new("addv h31, v6.8h".to_string()));
        assert_eq!(
            computer.lane_range(&Operand::VectorRegister(RePrefix::V, 31)),
            Some((-16, 0))
        );
    }

    #[test]
    fn test_addv_drops_a_range_that_would_wrap() {
        let mut computer = ARMCORTEXA::new();
        let _ = computer.execute(
            0,
            &Instruction::new("cmhs v2.16b, v30.16b, v4.16b".to_string()),
        );
        let _ = computer.execute(
            0,
            &Instruction::new("add v6.16b, v2.16b, v2.16b".to_string()),
        );
        let _ = computer.execute(
            0,
            &Instruction::new("add v7.16b, v6.16b, v6.16b".to_string()),
        );
        let _ = computer.execute(
            0,
            &Instruction::new("add v8.16b, v7.16b, v7.16b".to_string()),
        );
        let _ = computer.execute(
            0,
            &Instruction::new("add v9.16b, v8.16b, v8.16b".to_string()),
        );
        let _ = computer.execute(0, &Instruction::new("addv b31, v9.16b".to_string()));
        assert_eq!(
            computer.lane_range(&Operand::VectorRegister(RePrefix::V, 31)),
            None
        );
    }

    #[test]
    fn test_smov_bounds_the_general_register() {
        let mut computer = ARMCORTEXA::new();
        let _ = computer.execute(
            0,
            &Instruction::new("cmhs v2.8h, v30.8h, v4.8h".to_string()),
        );
        let _ = computer.execute(
            0,
            &Instruction::new("cmhs v3.8h, v30.8h, v5.8h".to_string()),
        );
        let _ = computer.execute(0, &Instruction::new("add v6.8h, v2.8h, v3.8h".to_string()));
        let _ = computer.execute(0, &Instruction::new("addv h31, v6.8h".to_string()));
        let _ = computer.execute(0, &Instruction::new("smov w15, v31.h[0]".to_string()));

        let result = computer.get_register(&Operand::Register(RePrefix::W, 15));
        assert_eq!(result.kind, RegisterKind::RegisterBase);
        let Some(AbstractExpression::Expression(op, bounded, modulus)) = result.base else {
            panic!("smov did not produce an expression");
        };
        assert_eq!(op, "%");
        assert_eq!(*modulus, AbstractExpression::Immediate(1 << 32));
        let AbstractExpression::Expression(op, inner, high) = *bounded else {
            panic!("smov did not produce a bounded expression");
        };
        assert_eq!(op, "atmost");
        assert_eq!(*high, AbstractExpression::Immediate(0));
        let AbstractExpression::Expression(op, _, low) = *inner else {
            panic!("smov did not produce a lower bound");
        };
        assert_eq!(op, "atleast");
        assert_eq!(*low, AbstractExpression::Immediate(-16));
    }

    #[test]
    fn test_smov_without_a_range_falls_back_to_the_lane_width() {
        let mut computer = ARMCORTEXA::new();
        let _ = computer.execute(0, &Instruction::new("smov w15, v31.h[0]".to_string()));
        let result = computer.get_register(&Operand::Register(RePrefix::X, 15));
        assert_eq!(result.kind, RegisterKind::RegisterBase);
        let shown = result.base.expect("a bound").to_string();
        assert!(
            shown.contains("-32768") && shown.contains("32767"),
            "{shown}"
        );
    }
}

#[cfg(test)]
mod lane_move_tests {
    use super::*;

    #[test]
    fn umov_carries_a_lane_range() {
        for opcode in ["smov w5, v31.h[0]", "umov w5, v31.h[0]"] {
            let mut computer = ARMCORTEXA::new();
            let _ = computer.execute(
                0,
                &Instruction::new("cmhs v2.8h, v30.8h, v4.8h".to_string()),
            );
            let _ = computer.execute(0, &Instruction::new("addv h31, v2.8h".to_string()));
            let _ = computer.execute(0, &Instruction::new(opcode.to_string()));
            let moved = computer.get_register(&Operand::Register(RePrefix::X, 5));
            assert_eq!(moved.kind, RegisterKind::RegisterBase, "{opcode}");
            assert!(
                moved.base.expect("a bound").to_string().contains("atmost"),
                "{opcode} did not carry the range"
            );
        }
    }
}
