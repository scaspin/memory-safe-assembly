use crate::common::*;
use crate::instruction_parser::*;
use std::collections::HashMap;
use std::fmt;
use z3::*;

mod instruction_aux;
mod instructions;
mod memory;
mod simd;

pub const MAX_EXPRESSION_NODES: usize = 150;

pub type ComputerState = (
    [RegisterValue; 33],
    Option<FlagValue>,
    Option<FlagValue>,
    Option<FlagValue>,
    Option<FlagValue>,
);

#[derive(Clone)]
pub struct ARMCORTEXA {
    pub registers: [RegisterValue; 33],
    pub simd_registers: Box<[SimdRegister; 32]>,
    zero: Option<FlagValue>,
    neg: Option<FlagValue>,
    pub carry: Option<FlagValue>,
    overflow: Option<FlagValue>,
    pub memory: HashMap<String, MemorySafeRegion>,
    pub memory_labels: HashMap<String, i64>,
    pub select_definitions:
        HashMap<String, (AbstractComparison, AbstractExpression, AbstractExpression)>,
    pub symbols_bounding_counter: HashMap<String, Vec<String>>,
    rw_queue: Vec<MemoryAccess>,
    alignment: i64,
    flag_counter: usize,
    pub solver: Solver,
    pub lane_bounds: Box<LaneBounds>,
    pub write_journal: Vec<CellWrite>,
    pub blind_stack_writes: Vec<(AbstractExpression, i64, i64)>,
}

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct MemoryCell {
    pub region: String,
    pub offset: i64,
}

#[derive(Debug, Clone)]
pub struct CellWrite {
    pub cell: MemoryCell,
    pub previous: Option<RegisterValue>,
}

#[derive(Clone)]
pub struct LaneBounds {
    pub bytes: [[u8; 16]; 32],
    pub scalar: [Option<u64>; 32],
}

impl Default for LaneBounds {
    fn default() -> Self {
        Self {
            bytes: [[u8::MAX; 16]; 32],
            scalar: [None; 32],
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
        let mut memory = HashMap::new();

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
            simd_registers,
            zero: None,
            neg: None,
            carry: None,
            overflow: None,
            memory,
            memory_labels: HashMap::new(),
            select_definitions: HashMap::new(),
            symbols_bounding_counter: HashMap::new(),
            rw_queue: Vec::new(),
            alignment: 4,
            flag_counter: 0,
            lane_bounds: Box::default(),
            write_journal: Vec::new(),
            blind_stack_writes: Vec::new(),
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
        self.solver
            .check_assumptions(&[value.lt(ast::Int::from_i64(0))])
            == SatResult::Unsat
            && self
                .solver
                .check_assumptions(&[value.ge(ast::Int::from_i64(MODULUS))])
                == SatResult::Unsat
    }

    pub fn write_cell(&mut self, cell: &MemoryCell, value: RegisterValue) {
        let Some(region) = self.memory.get_mut(&cell.region) else {
            return;
        };
        let previous = region.content.get(&cell.offset).cloned();
        region.insert(cell.offset, value);
        self.write_journal.push(CellWrite {
            cell: cell.clone(),
            previous,
        });
    }

    pub fn cell_content(&self, cell: &MemoryCell) -> RegisterValue {
        self.memory
            .get(&cell.region)
            .and_then(|region| region.content.get(&cell.offset).cloned())
            .unwrap_or_else(|| RegisterValue::new(RegisterKind::Number, None, 0))
    }

    pub fn undo_writes_since(&mut self, journal_len: usize) {
        while self.write_journal.len() > journal_len {
            let Some(write) = self.write_journal.pop() else {
                break;
            };
            let Some(region) = self.memory.get_mut(&write.cell.region) else {
                continue;
            };
            match write.previous {
                Some(value) => {
                    region.content.insert(write.cell.offset, value);
                }
                None => {
                    region.content.remove(&write.cell.offset);
                }
            }
        }
    }

    pub fn get_state(&self) -> ComputerState {
        (
            self.registers.clone(),
            self.zero.clone(),
            self.neg.clone(),
            self.carry.clone(),
            self.overflow.clone(),
        )
    }

    pub fn set_state(&mut self, state: ComputerState) {
        let (registers, zero, neg, carry, overflow) = state;
        self.registers = registers;
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
                RePrefix::Sp => self.registers[31].set(kind, base, offset),
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

    fn set_register_from_tuple(
        &mut self,
        register: (RePrefix, usize),
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        self.set_register(
            &Operand::Register(register.0, register.1),
            kind,
            base,
            offset,
        );
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
            a => panic!("Not a valid register operand for get operation {:?}", a),
        }
    }

    pub fn get_simd_register(&mut self, reg: &Operand) -> SimdRegister {
        match reg {
            Operand::VectorRegister(_, index) => self.simd_registers[*index].clone(),
            Operand::Vector(_, index, _) => self.simd_registers[*index].clone(),
            Operand::VectorAccess(_, index, _, _) => {
                self.simd_registers[*index].clone()
            }
            _ => panic!("cannot get register {:?} as a simd register", reg),
        }
    }

    pub fn set_simd_register(&mut self, reg: &Operand, src: SimdRegister) {
        match reg {
            Operand::VectorRegister(_, index) => self.simd_registers[*index] = src,
            Operand::Vector(_, index, _) => self.simd_registers[*index] = src,
            _ => panic!("cannot get register {:?} as a simd register", reg),
        }
    }

    pub fn add_memory_value(&mut self, region: String, address: i64, value: i64, width: i64) {
        let reg_value = RegisterValue::new(RegisterKind::Immediate, None, value);
        match self.memory.get_mut(&region) {
            Some(r) => {
                r.insert(address, reg_value);
                r.grow_to(address + width);
            }
            None => {
                let mut region_map =
                    MemorySafeRegion::new(AbstractExpression::Immediate(0), RegionType::RW)
                        .with_alignment(4096);
                region_map.insert(address, reg_value);
                region_map.grow_to(address + width);
                self.memory.insert(region, region_map);
            }
        }
    }

    pub fn add_memory_value_abstract(
        &mut self,
        region: String,
        address: i64,
        value: AbstractExpression,
    ) {
        let reg_value = RegisterValue::new(RegisterKind::RegisterBase, Some(value), 0);
        match self.memory.get_mut(&region) {
            Some(r) => {
                r.insert(address, reg_value);
            }
            None => {
                let mut region_map =
                    MemorySafeRegion::new(AbstractExpression::Immediate(0), RegionType::RW)
                        .with_alignment(4096);
                region_map.insert(address, reg_value);
                self.memory.insert(region, region_map);
            }
        }
    }

    pub fn grow_memory_region(&mut self, name: String, end: i64) {
        if let Some(r) = self.memory.get_mut(&name) {
            r.grow_to(end);
        }
    }

    pub fn add_memory_region(&mut self, name: String, ty: RegionType, length: AbstractExpression) {
        let new_region = MemorySafeRegion::new(length, ty);
        self.memory.insert(name, new_region);
    }

    fn label_to_memory_index(&self, label: String) -> (String, i64) {
        let (symbol, addend) = match label.rsplit_once('+') {
            Some((symbol, addend)) => (symbol, addend.trim().parse::<i64>().unwrap_or(0)),
            None => (label.as_str(), 0),
        };
        let name = symbol.split('@').next().unwrap_or(symbol).trim();
        let offset = self
            .memory_labels
            .get(name)
            .or_else(|| self.memory_labels.get(name.trim_start_matches('_')))
            .copied()
            .unwrap_or(0);
        ("memory".to_string(), offset + addend)
    }

    pub fn check_stack_pointer_restored(&self) {
        let s = &self.registers[31];
        match &s.base {
            Some(b) => {
                if b == &AbstractExpression::Abstract("sp".to_string()) && s.offset == 0 {
                    log::info!("Stack pointer restored to start");
                } else {
                    log::error!("Stack pointer offset not restored");
                }
            }
            None => {
                log::error!("Stack pointer not restored {:?}", s.base);
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
