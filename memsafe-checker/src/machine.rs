use std::cell::RefCell;
use std::collections::{BTreeMap, BTreeSet};
use std::fmt::Debug;
use std::rc::Rc;
use z3::*;

use crate::common::*;
use crate::loader::{DataItem, DataValue};

pub type MachineState = (
    Vec<RegisterValue>,
    Option<FlagValue>,
    Option<FlagValue>,
    Option<FlagValue>,
    Option<FlagValue>,
);

pub type SelectDefinitions =
    BTreeMap<String, (AbstractComparison, AbstractExpression, AbstractExpression)>;

pub type ElementFacts = Rc<RefCell<BTreeMap<(String, i64), (String, bool)>>>;

#[derive(Debug, Clone)]
pub struct ElementRange {
    pub width: i64,
    pub signed: bool,
    pub op: String,
    pub bound: AbstractExpression,
}

#[derive(Debug, Clone, PartialEq)]
pub struct SymbolicSlot {
    pub base: AbstractExpression,
    pub offset: i64,
    pub width: i64,
    pub value: RegisterValue,
}

#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct MemoryCell {
    pub region: String,
    pub offset: i64,
}

#[derive(Debug, Clone)]
pub struct CellWrite {
    pub cell: MemoryCell,
    pub previous: Option<RegisterValue>,
    pub previous_width: Option<i64>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Flow<'a> {
    Next,
    Jump(&'a str),
    Branch(&'a str),
    Call,
    Return,
    Trap,
    Indirect,
}

pub trait MachineInstruction: Clone + Debug {
    type Operand: Clone + Debug + PartialEq;
    const FIXED_WIDTH: Option<usize>;
    const TRACKED_REGISTERS: usize = 0;

    fn statements(lines: Vec<String>) -> Vec<String>;
    fn alignment(directive: &str, argument: i64) -> Option<i64>;
    fn item_width(directive: &str) -> Option<i64>;
    fn parse(text: String) -> Self;
    fn label(&self) -> Option<&str>;
    fn opcode(&self) -> &str;
    fn flow(&self) -> Flow<'_>;
    fn is_straight_line(&self) -> bool;

    fn is_label(&self) -> bool {
        self.label().is_some()
    }

    fn data_only(&self) -> bool {
        false
    }

    fn register_written(&self) -> Option<Option<Self::Operand>> {
        None
    }

    fn overwrites_without_reading(&self, _register: usize) -> bool {
        false
    }

    fn mentions(&self, _register: usize) -> bool {
        true
    }

    fn zero_test(&self) -> Option<(&'static str, &Self::Operand, &str)> {
        None
    }

    fn flags_dead(_code: &[Self], _pc: usize) -> bool {
        false
    }

    fn flag_source(_code: &[Self], _branch_pc: usize) -> Option<usize> {
        None
    }
}

pub trait Machine: Clone {
    type Operand: Clone + Debug + PartialEq;
    type Instruction: MachineInstruction<Operand = Self::Operand>;
    type Lanes: Clone;

    fn new() -> Self;
    fn execute(
        &mut self,
        pc: usize,
        instruction: &Self::Instruction,
    ) -> Result<ExecuteReturnType<Self::Operand>, String>;

    fn fingerprint(&self, _with_flags: bool) -> Option<String> {
        None
    }

    fn solver(&self) -> &Solver;
    fn set_solver(&mut self, solver: Solver);
    fn get_state(&self) -> MachineState;
    fn set_state(&mut self, state: MachineState);
    fn register_at(&self, index: usize) -> RegisterValue;
    fn set_register_at(&mut self, index: usize, value: RegisterValue);
    fn get_register(&mut self, register: &Self::Operand) -> RegisterValue;
    fn set_register(
        &mut self,
        register: &Self::Operand,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: i64,
    );
    fn loaded(&self, index: usize) -> bool;
    fn lanes(&self) -> Self::Lanes;
    fn set_lanes(&mut self, lanes: Self::Lanes);
    fn set_flags(&mut self, flags: [Option<FlagValue>; 4]);
    fn set_unknown_flags(&mut self);
    fn fresh_index(&mut self) -> usize;
    fn substitute_symbol(&mut self, symbol: &str, value: i64);
    fn check_stack_pointer_restored(&self, pc: usize);
    fn read_rw_queue(&self) -> Vec<MemoryAccess>;
    fn clear_rw_queue(&mut self);

    fn memory(&self) -> &BTreeMap<String, MemorySafeRegion>;
    fn memory_mut(&mut self) -> &mut BTreeMap<String, MemorySafeRegion>;
    fn memory_labels(&self) -> &BTreeMap<String, (String, i64)>;
    fn code_labels(&self) -> &BTreeSet<String>;
    fn set_code_labels(&mut self, labels: Rc<BTreeSet<String>>);
    fn add_data_symbol(&mut self, name: &str, section: &str, offset: i64, size: Option<i64>);
    fn write_journal(&self) -> &[CellWrite];
    fn write_journal_mut(&mut self) -> &mut Vec<CellWrite>;
    fn blind_stack_writes(&self) -> &[(AbstractExpression, i64, i64)];
    fn select_definitions(&self) -> &SelectDefinitions;
    fn select_definitions_mut(&mut self) -> &mut SelectDefinitions;
    fn symbols_bounding_counter(&self) -> &BTreeMap<String, Vec<String>>;
    fn symbols_bounding_counter_mut(&mut self) -> &mut BTreeMap<String, Vec<String>>;
    fn element_facts(&self) -> &ElementFacts;

    fn set_immediate(&mut self, register: String, value: u64);
    fn set_abstract(&mut self, register: String, value: AbstractExpression);
    fn set_argument(&mut self, index: usize, value: AbstractExpression);

    fn change_alignment(&mut self, _value: i64) {}

    fn symbolic_slots(&self) -> Vec<SymbolicSlot> {
        Vec::new()
    }

    fn set_symbolic_slots(&mut self, _slots: Vec<SymbolicSlot>) {}

    fn add_pointer_elements(&mut self, _region: &str, _target: &str) {}

    fn add_element_range(&mut self, _region: &str, _range: ElementRange) {}

    fn allow_red_zone(&mut self, _bytes: i64) {}

    fn findings(&self) -> Vec<String> {
        Vec::new()
    }

    fn names_region(&self, symbol: &str) -> bool {
        self.memory().contains_key(symbol) || self.memory_labels().contains_key(symbol)
    }

    fn carries_region(&self, register: &RegisterValue) -> bool {
        register.base.as_ref().is_some_and(|base| {
            base.get_abstracts()
                .iter()
                .any(|symbol| self.names_region(symbol))
        })
    }

    fn add_memory_region(&mut self, name: String, ty: RegionType, length: AbstractExpression) {
        self.memory_mut()
            .insert(name, MemorySafeRegion::new(length, ty));
    }

    fn add_data_section(&mut self, name: &str, ty: RegionType, size: i64, alignment: i64) {
        let region = MemorySafeRegion::new(AbstractExpression::Immediate(size), ty)
            .with_alignment(alignment);
        self.memory_mut().insert(name.to_string(), region);
        if alignment > 1 {
            self.solver().assert(
                ast::Int::new_const(name)
                    .modulo(ast::Int::from_i64(alignment))
                    .eq(ast::Int::from_i64(0)),
            );
        }
    }

    fn add_memory_value(&mut self, region: String, address: i64, value: i64, width: i64) {
        let value = RegisterValue::new(RegisterKind::Immediate, None, value);
        let region = self.memory_mut().entry(region).or_insert_with(|| {
            MemorySafeRegion::new(AbstractExpression::Immediate(0), RegionType::RW)
                .with_alignment(4096)
        });
        region.insert_sized(address, value, width);
        region.grow_to(address + width);
    }

    fn add_memory_value_abstract(
        &mut self,
        region: String,
        address: i64,
        value: AbstractExpression,
    ) {
        let value = RegisterValue::new(RegisterKind::RegisterBase, Some(value), 0);
        self.memory_mut()
            .entry(region)
            .or_insert_with(|| {
                MemorySafeRegion::new(AbstractExpression::Immediate(0), RegionType::RW)
                    .with_alignment(4096)
            })
            .insert(address, value);
    }

    fn add_memory_pointer(&mut self, region: &str, at: i64, pointer: RegisterValue, width: i64) {
        if let Some(r) = self.memory_mut().get_mut(region) {
            r.insert_sized(at, pointer, width);
        }
    }

    fn symbol_address(&self, symbol: &str) -> Option<(String, i64)> {
        let name = symbol.split('@').next().unwrap_or(symbol).trim();
        [name, name.trim_start_matches('_')]
            .into_iter()
            .find_map(|name| match self.memory_labels().get(name) {
                Some(placed) => Some(placed.clone()),
                None => self
                    .code_labels()
                    .contains(name)
                    .then(|| (name.to_string(), 0)),
            })
    }

    fn store_data_item(&mut self, section: &str, item: &DataItem) {
        match &item.value {
            DataValue::Literal(value) | DataValue::LabelDifference { value, .. } => {
                self.add_memory_value(section.to_string(), item.offset, *value, item.width)
            }
            DataValue::Pointer(symbol, addend) => {
                if let Some((base, offset)) = self.symbol_address(symbol) {
                    let pointer = RegisterValue::new(
                        RegisterKind::RegisterBase,
                        Some(AbstractExpression::Abstract(base)),
                        offset + addend,
                    );
                    self.add_memory_pointer(section, item.offset, pointer, item.width);
                }
            }
            DataValue::Unknown => (),
        }
    }

    fn region_of(&self, base: &AbstractExpression) -> Option<(String, String, i64)> {
        let counted_once: Vec<String> = crate::widening::Affine::of(base)
            .map(|form| {
                form.terms
                    .into_iter()
                    .filter_map(|(atom, coefficient)| match atom {
                        AbstractExpression::Abstract(name) if coefficient == 1 => Some(name),
                        _ => None,
                    })
                    .collect()
            })
            .unwrap_or_default();
        let abstracts: Vec<String> = counted_once
            .into_iter()
            .chain(base.get_abstracts())
            .collect();
        if let Some(region) = abstracts.iter().find(|a| self.memory().contains_key(*a)) {
            return Some((region.clone(), region.clone(), 0));
        }
        abstracts.into_iter().find_map(|label| {
            let (section, address) = self.memory_labels().get(&label)?.clone();
            Some((section, label, address))
        })
    }

    fn get_memory_pointer(&self, base: String, offset: i64) -> (String, i64) {
        match self.memory_labels().get(&base) {
            Some((section, address)) if !self.memory().contains_key(&base) => {
                (section.clone(), address + offset)
            }
            _ => (base, offset),
        }
    }

    fn cell_content(&self, cell: &MemoryCell) -> RegisterValue {
        self.memory()
            .get(&cell.region)
            .and_then(|region| region.content.get(&cell.offset).cloned())
            .unwrap_or_else(|| RegisterValue::new(RegisterKind::Number, None, 0))
    }

    fn write_cell(&mut self, cell: &MemoryCell, value: RegisterValue) {
        let Some(region) = self.memory_mut().get_mut(&cell.region) else {
            return;
        };
        let previous = region.content.get(&cell.offset).cloned();
        let previous_width = region.width_at(cell.offset);
        region.insert(cell.offset, value);
        self.write_journal_mut().push(CellWrite {
            cell: cell.clone(),
            previous,
            previous_width,
        });
    }

    fn forget_cell(&mut self, region_name: &str, offset: i64) {
        let Some(region) = self.memory_mut().get_mut(region_name) else {
            return;
        };
        let previous = region.content.get(&offset).cloned();
        let previous_width = region.width_at(offset);
        region.put(offset, None);
        self.write_journal_mut().push(CellWrite {
            cell: MemoryCell {
                region: region_name.to_string(),
                offset,
            },
            previous,
            previous_width,
        });
    }

    fn store_cell(&mut self, cell: &MemoryCell, value: RegisterValue, width: i64) {
        let Some(region) = self.memory().get(&cell.region) else {
            return;
        };
        for k in region.overlapping(cell.offset, width) {
            self.forget_cell(&cell.region, k);
        }
        let Some(region) = self.memory_mut().get_mut(&cell.region) else {
            return;
        };
        let value = if width > 8 {
            RegisterValue::new(RegisterKind::Number, None, 0)
        } else {
            value
        };
        region.put(cell.offset, Some((value, Some(width))));
        region.mark_written(cell.offset, width);
        self.write_journal_mut().push(CellWrite {
            cell: cell.clone(),
            previous: None,
            previous_width: None,
        });
    }

    fn forget_where_written(&mut self, base: &AbstractExpression, offset: i64, width: i64) {
        let named = base.get_abstracts();
        let regions: Vec<String> = self
            .memory()
            .keys()
            .filter(|name| {
                named.contains(name)
                    || named.iter().any(|n| {
                        self.memory_labels()
                            .get(n)
                            .is_some_and(|(section, _)| section == *name)
                    })
            })
            .cloned()
            .collect();
        let start = expression_to_ast(base.clone())
            .map(|b| ast::Int::add(&[&b, &ast::Int::from_i64(offset)]));
        for name in regions {
            let region = &self.memory()[&name];
            let slots: Vec<(i64, i64)> = region
                .content
                .keys()
                .map(|k| (*k, region.width_at(*k).unwrap_or(8)))
                .collect();
            for (k, slot_width) in slots {
                let apart = start.as_ref().is_some_and(|start| {
                    let slot_start = ast::Int::add(&[
                        &ast::Int::new_const(name.clone()),
                        &ast::Int::from_i64(k),
                    ]);
                    let slot_end = ast::Int::add(&[&slot_start, &ast::Int::from_i64(slot_width)]);
                    let end = ast::Int::add(&[start, &ast::Int::from_i64(width)]);
                    let overlap = ast::Bool::and(&[&start.lt(&slot_end), &slot_start.lt(&end)]);
                    self.solver().check_assumptions(&[overlap]) == SatResult::Unsat
                });
                if !apart {
                    self.forget_cell(&name, k);
                }
            }
            if let Some(region) = self.memory_mut().get_mut(&name) {
                region.renew_unwritten();
            }
        }
    }

    fn undo_writes_since(&mut self, journal_len: usize) {
        while self.write_journal().len() > journal_len {
            let Some(write) = self.write_journal_mut().pop() else {
                break;
            };
            let Some(region) = self.memory_mut().get_mut(&write.cell.region) else {
                continue;
            };
            region.put(
                write.cell.offset,
                write.previous.map(|value| (value, write.previous_width)),
            );
        }
    }

    fn slots_kept(&self, slots: &[SymbolicSlot]) -> bool {
        let kept = self.symbolic_slots();
        slots.iter().all(|slot| kept.contains(slot))
    }

    fn add_element_fact(&mut self, region: &str, address: i64, width: i64, symbol: &str) {
        let value = RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(AbstractExpression::Abstract(symbol.to_string())),
            0,
        );
        match self.memory_mut().get_mut(region) {
            Some(r) => r.insert_sized(address, value, width),
            None => panic!("no region {region} to place {symbol} in"),
        }
        self.element_facts()
            .borrow_mut()
            .insert((region.to_string(), address), (symbol.to_string(), false));
    }

    fn note_element_read(&self, region: &str, address: i64) {
        if let Some(entry) = self
            .element_facts()
            .borrow_mut()
            .get_mut(&(region.to_string(), address))
        {
            entry.1 = true;
        }
    }

    fn unread_element_facts(&self) -> Vec<String> {
        let mut unread: Vec<String> = self
            .element_facts()
            .borrow()
            .values()
            .filter(|(_, read)| !read)
            .map(|(symbol, _)| symbol.clone())
            .collect();
        unread.sort();
        unread
    }

    fn select_assumptions(&self, e: &AbstractExpression) -> Vec<ast::Bool> {
        let mut seen = BTreeSet::new();
        let mut pending = e.get_abstracts();
        let mut assumptions = Vec::new();
        while let Some(name) = pending.pop() {
            if !seen.insert(name.clone()) {
                continue;
            }
            if let Some(bounding) = self.symbols_bounding_counter().get(&name) {
                pending.extend(bounding.iter().cloned());
            }
            let Some((condition, taken, skipped)) = self.select_definitions().get(&name) else {
                continue;
            };
            pending.extend(taken.get_abstracts());
            pending.extend(skipped.get_abstracts());
            if !is_translatable(taken) || !is_translatable(skipped) {
                continue;
            }
            if let (Some(condition), Some(taken), Some(skipped)) = (
                comparison_to_ast(condition.clone()),
                expression_to_ast(taken.clone()),
                expression_to_ast(skipped.clone()),
            ) {
                let chosen = ast::Int::new_const(name);
                assumptions.push(ast::Bool::or(&[&condition.not(), &chosen.eq(taken)]));
                assumptions.push(ast::Bool::or(&[&condition, &chosen.eq(skipped)]));
            }
        }
        assumptions
    }

    fn finite_values(&self, symbol: &str, cap: usize) -> Option<Vec<i64>> {
        let var = ast::Int::new_const(symbol.to_string());
        let mut found: Vec<i64> = Vec::new();
        loop {
            let excluded: Vec<ast::Bool> = found
                .iter()
                .map(|v| var.eq(ast::Int::from_i64(*v)).not())
                .collect();
            match self.solver().check_assumptions(&excluded) {
                SatResult::Unsat => return Some(found),
                SatResult::Unknown => return None,
                SatResult::Sat => {
                    let value = self.solver().get_model()?.eval(&var, true)?.as_i64()?;
                    if found.contains(&value) || found.len() >= cap {
                        return None;
                    }
                    found.push(value);
                }
            }
        }
    }

    fn fits_unsigned(&self, value: &AbstractExpression, bits: u32) -> bool {
        let limit = if bits >= 63 { i64::MAX } else { 1i64 << bits };
        [
            AbstractComparison::new(">=", value.clone(), AbstractExpression::Immediate(0)),
            AbstractComparison::new("<", value.clone(), AbstractExpression::Immediate(limit)),
        ]
        .into_iter()
        .all(|fact| {
            comparison_to_ast(fact)
                .is_some_and(|c| self.solver().check_assumptions(&[c.not()]) == SatResult::Unsat)
        })
    }
}

pub fn respelled(register: &RegisterValue, symbol: &str, value: i64) -> Option<RegisterValue> {
    let base = register.base.as_ref()?;
    if register.kind != RegisterKind::RegisterBase
        || !base.get_abstracts().iter().any(|name| name == symbol)
    {
        return None;
    }
    let value = RegisterValue {
        base: Some(substituted(base, symbol, value)),
        ..register.clone()
    };
    Some(match crate::widening::Affine::of_register(&value) {
        Some(form) if form.terms.is_empty() => RegisterValue::new_imm(form.constant),
        _ => value,
    })
}

pub fn substituted(e: &AbstractExpression, symbol: &str, value: i64) -> AbstractExpression {
    match e {
        AbstractExpression::Abstract(name) if name == symbol => {
            AbstractExpression::Immediate(value)
        }
        AbstractExpression::Register(r) => AbstractExpression::Register(Box::new(RegisterValue {
            base: r.base.as_ref().map(|b| substituted(b, symbol, value)),
            ..(**r).clone()
        })),
        AbstractExpression::Expression(op, a, b) => generate_expression(
            op,
            substituted(a, symbol, value),
            substituted(b, symbol, value),
        ),
        other => other.clone(),
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Isa {
    Aarch64,
    X86_64,
}

impl Isa {
    pub fn detect<S: AsRef<str>>(lines: &[S]) -> Isa {
        const X86_REGISTERS: [&str; 12] = [
            "%rax", "%rsp", "%rdi", "%rsi", "%eax", "%rip", "%xmm", "%ymm", "%r8", "%rbp", "%rcx",
            "%rdx",
        ];
        let is_arm_register = |word: &str| {
            let word = word.trim_matches(|c: char| !c.is_ascii_alphanumeric());
            word.len() >= 2
                && (word.starts_with('x') || word.starts_with('w'))
                && word[1..].parse::<u8>().is_ok_and(|n| n <= 30)
        };
        let (mut x86, mut arm) = (0usize, 0usize);
        for line in lines {
            let line = line.as_ref().trim();
            if line.starts_with('#') || line.starts_with("//") || line.starts_with("/*") {
                continue;
            }
            let code = line.split("//").next().unwrap_or_default();
            let code = code.split("##").next().unwrap_or_default();
            if X86_REGISTERS.iter().any(|r| code.contains(r)) {
                x86 += 1;
            }
            if code.split([' ', ',', '\t', '[', ']']).any(is_arm_register) {
                arm += 1;
            }
        }
        if x86 > arm { Isa::X86_64 } else { Isa::Aarch64 }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn detects_att_x86() {
        assert_eq!(Isa::detect(&["movq %rdi,%rax", "ret"]), Isa::X86_64);
    }

    #[test]
    fn detects_aarch64() {
        assert_eq!(
            Isa::detect(&["add x0,x1,x2", "ldr w3,[x0]", "ret"]),
            Isa::Aarch64
        );
    }

    #[test]
    fn x86_registers_in_comments_do_not_make_aarch64_x86() {
        let lines = [
            "## AES-encrypt %xmm0.",
            "## %xmm0 = input",
            "ld1 {v0.16b}, [x0]",
            "add x1, x1, #16 // %rsi in the x86 version",
        ];
        assert_eq!(Isa::detect(&lines), Isa::Aarch64);
    }
}
