use crate::computer::*;
use crate::instruction_parser::decode_vector_only_word;

fn is_conditional_branch(opcode: &str) -> bool {
    matches!(
        opcode,
        "cbz"
            | "cbnz"
            | "tbz"
            | "tbnz"
            | "bne"
            | "beq"
            | "bgt"
            | "bt"
            | "bge"
            | "bhi"
            | "bcs"
            | "blo"
    ) || opcode.starts_with("b.")
}

fn item_width(directive: &str) -> Option<i64> {
    match directive {
        ".byte" => Some(1),
        ".hword" | ".short" | ".2byte" => Some(2),
        ".word" | ".long" | ".int" | ".4byte" => Some(4),
        ".quad" | ".xword" | ".dword" | ".8byte" => Some(8),
        _ => None,
    }
}

fn general_register_index(prefix: &RePrefix, number: usize) -> Option<usize> {
    match prefix {
        RePrefix::X | RePrefix::W => Some(number),
        RePrefix::Fp => Some(29),
        RePrefix::Ra => Some(30),
        _ => None,
    }
}

fn operand_mentions(operand: &Operand, register: usize) -> bool {
    match operand {
        Operand::Register(prefix, number) => {
            general_register_index(prefix, *number) == Some(register)
        }
        Operand::Memory(prefix, number, _, index, _) => {
            general_register_index(prefix, *number) == Some(register)
                || index
                    .as_ref()
                    .is_some_and(|index| operand_mentions(index, register))
        }
        Operand::ShiftedRegister(inner, ..) => operand_mentions(inner, register),
        _ => false,
    }
}

impl Instruction {
    fn overwritten_operands(&self) -> usize {
        let keeps_part_of_destination = matches!(self.opcode.as_str(), "movk" | "bfi" | "bfxil");
        if keeps_part_of_destination {
            return 0;
        }
        if self.ty == InstructionType::Memory {
            return match self.opcode.as_str() {
                "ldr" | "ldur" | "ldrb" | "ldrh" | "ldrsw" | "ldrsb" | "ldrsh" => 1,
                "ldp" | "ldnp" => 2,
                _ => 0,
            };
        }
        match self.register_written() {
            Some(Some(_)) => 1,
            _ => 0,
        }
    }

    fn branch_label(&self) -> Option<&str> {
        self.operands.iter().rev().find_map(|op| match op {
            Operand::Label(label) => Some(label.as_str()),
            _ => None,
        })
    }
}

impl MachineInstruction for Instruction {
    type Operand = Operand;
    const FIXED_WIDTH: Option<usize> = Some(4);
    const TRACKED_REGISTERS: usize = 30;

    fn statements(lines: Vec<String>) -> Vec<String> {
        lines
            .iter()
            .flat_map(|line| {
                let code = line.split_once("//").map_or(line.as_str(), |(c, _)| c);
                let code = code.split_once(';').map_or(code, |(c, _)| c);
                code.split("%%")
                    .map(|statement| statement.trim().to_string())
                    .collect::<Vec<_>>()
            })
            .collect()
    }

    fn alignment(directive: &str, argument: i64) -> Option<i64> {
        match directive {
            ".align" | ".p2align" => (0..32).contains(&argument).then(|| 1 << argument),
            ".balign" => Some(argument),
            _ => None,
        }
    }

    fn item_width(directive: &str) -> Option<i64> {
        item_width(directive)
    }

    fn parse(text: String) -> Self {
        Instruction::new(text)
    }

    fn decode_word(word: u32) -> Option<String> {
        decode_vector_only_word(word)
    }

    fn label(&self) -> Option<&str> {
        self.is_label().then_some(self.opcode.as_str())
    }

    fn opcode(&self) -> &str {
        &self.opcode
    }

    fn flow(&self) -> Flow<'_> {
        let label = self.branch_label();
        match self.opcode.as_str() {
            "ret" => Flow::Return,
            "brk" | "udf" | "hlt" => Flow::Trap,
            "br" => Flow::Indirect,
            "bl" | "blr" => Flow::Call,
            "b" if self.ty == InstructionType::ControlFlow => {
                label.map_or(Flow::Indirect, Flow::Jump)
            }
            op if self.ty == InstructionType::ControlFlow && is_conditional_branch(op) => {
                label.map_or(Flow::Indirect, Flow::Branch)
            }
            _ => Flow::Next,
        }
    }

    fn is_straight_line(&self) -> bool {
        !matches!(
            self.ty,
            InstructionType::ControlFlow | InstructionType::Label
        ) && !matches!(self.opcode.as_str(), "brk" | "udf" | "hlt")
    }

    fn data_only(&self) -> bool {
        let vector_floating_point = is_floating_point(&self.opcode)
            && self
                .operands
                .first()
                .is_none_or(|destination| vector_index(destination).is_some());
        match self.ty {
            InstructionType::Arithmetic => true,
            InstructionType::Other => self.opcode == "mov",
            InstructionType::SIMDArithmetic | InstructionType::SIMDManagement => {
                vector_floating_point
            }
            _ => false,
        }
    }

    fn register_written(&self) -> Option<Option<Operand>> {
        let destination = || match self.operands.first() {
            Some(Operand::Register(prefix, n)) if *prefix != RePrefix::Sp => {
                Some(Some(Operand::Register(prefix.clone(), *n)))
            }
            _ => None,
        };
        match self.ty {
            InstructionType::Label => Some(None),
            InstructionType::Arithmetic => destination(),
            InstructionType::Other => match self.opcode.as_str() {
                "nop" | "hint" | "cmp" | "cmn" | "tst" => Some(None),
                "mov" | "movz" | "movk" | "mvn" | "neg" | "negs" | "ngc" | "ngcs" | "rbit"
                | "rev" | "clz" | "cls" => destination(),
                _ => None,
            },
            InstructionType::ControlFlow => match self.opcode.as_str() {
                "csel" | "csinc" | "csinv" | "csneg" | "cset" | "csetm" | "cinc" | "cinv"
                | "cneg" | "mrs" => destination(),
                _ if matches!(self.flow(), Flow::Jump(_) | Flow::Branch(_)) => Some(None),
                _ => None,
            },
            _ => None,
        }
    }

    fn overwrites_without_reading(&self, register: usize) -> bool {
        let (written, read) = self
            .operands
            .split_at(self.overwritten_operands().min(self.operands.len()));
        written.iter().any(|operand| {
            matches!(operand, Operand::Register(..)) && operand_mentions(operand, register)
        }) && !read
            .iter()
            .any(|operand| operand_mentions(operand, register))
    }

    fn mentions(&self, register: usize) -> bool {
        self.operands
            .iter()
            .any(|operand| operand_mentions(operand, register))
    }

    fn zero_test(&self) -> Option<(&'static str, &Operand, &str)> {
        let op = match self.opcode.as_str() {
            "cbz" => "==",
            "cbnz" => "!=",
            _ => return None,
        };
        match self.operands.as_slice() {
            [tested, Operand::Label(label), ..] => Some((op, tested, label.as_str())),
            _ => None,
        }
    }

    fn flags_dead(code: &[Self], pc: usize) -> bool {
        for instruction in code.iter().skip(pc) {
            let opcode = instruction.opcode.as_str();
            if instruction.is_label()
                || matches!(
                    opcode,
                    "nop" | "hint" | "mov" | "movz" | "movk" | "movn" | "mvn" | "adr" | "adrp"
                )
            {
                continue;
            }
            if matches!(
                opcode,
                "cmp"
                    | "cmn"
                    | "tst"
                    | "subs"
                    | "adds"
                    | "ands"
                    | "bics"
                    | "negs"
                    | "fcmp"
                    | "fcmpe"
            ) {
                return true;
            }
            let reads_flags = matches!(
                opcode,
                "adc"
                    | "adcs"
                    | "sbc"
                    | "sbcs"
                    | "ngc"
                    | "ngcs"
                    | "csel"
                    | "csinc"
                    | "csinv"
                    | "csneg"
                    | "cset"
                    | "csetm"
                    | "cinc"
                    | "cinv"
                    | "cneg"
                    | "ccmp"
                    | "ccmn"
                    | "fcsel"
                    | "fccmp"
                    | "fccmpe"
            );
            let straight_line = matches!(
                instruction.ty,
                InstructionType::Arithmetic
                    | InstructionType::Memory
                    | InstructionType::SIMDArithmetic
                    | InstructionType::SIMDManagement
            );
            if reads_flags || !straight_line {
                return false;
            }
        }
        false
    }

    fn flag_source(code: &[Self], branch_pc: usize) -> Option<usize> {
        let mut pc = branch_pc;
        loop {
            pc = pc.checked_sub(1)?;
            let instruction = code.get(pc)?;
            if matches!(
                instruction.ty,
                InstructionType::Label | InstructionType::ControlFlow
            ) {
                return None;
            }
            let source = match instruction.opcode.as_str() {
                "subs" | "adds" => instruction.operands.get(1),
                "cmp" | "cmn" => instruction.operands.first(),
                op if op.ends_with('s') || op == "tst" || op == "ccmp" || op == "ccmn" => {
                    return None;
                }
                _ => continue,
            };
            return match source {
                Some(Operand::Register(RePrefix::X, n)) => Some(*n),
                _ => None,
            };
        }
    }
}

impl Machine for ARMCORTEXA {
    type Operand = Operand;
    type Instruction = Instruction;
    type Lanes = (Box<[SimdRegister; 32]>, Box<LaneBounds>);

    fn new() -> Self {
        ARMCORTEXA::new()
    }

    fn execute(
        &mut self,
        pc: usize,
        instruction: &Instruction,
    ) -> Result<ExecuteReturnType, String> {
        ARMCORTEXA::execute(self, pc, instruction)
    }

    fn fingerprint(&self, with_flags: bool) -> Option<String> {
        Some(ARMCORTEXA::fingerprint(self, with_flags))
    }

    fn solver(&self) -> &Solver {
        &self.solver
    }

    fn set_solver(&mut self, solver: Solver) {
        self.solver = solver;
    }

    fn get_state(&self) -> MachineState {
        ARMCORTEXA::get_state(self)
    }

    fn set_state(&mut self, state: MachineState) {
        ARMCORTEXA::set_state(self, state)
    }

    fn register_at(&self, index: usize) -> RegisterValue {
        self.registers[index].clone()
    }

    fn set_register_at(&mut self, index: usize, value: RegisterValue) {
        self.registers[index] = value;
    }

    fn get_register(&mut self, register: &Operand) -> RegisterValue {
        ARMCORTEXA::get_register(self, register)
    }

    fn set_register(
        &mut self,
        register: &Operand,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        ARMCORTEXA::set_register(self, register, kind, base, offset)
    }

    fn loaded(&self, index: usize) -> bool {
        self.loaded[index]
    }

    fn lanes(&self) -> Self::Lanes {
        (self.simd_registers.clone(), self.lane_bounds.clone())
    }

    fn set_lanes(&mut self, (simd_registers, lane_bounds): Self::Lanes) {
        self.simd_registers = simd_registers;
        self.lane_bounds = lane_bounds;
    }

    fn set_flags(&mut self, flags: [Option<FlagValue>; 4]) {
        ARMCORTEXA::set_flags(self, flags)
    }

    fn set_unknown_flags(&mut self) {
        ARMCORTEXA::set_unknown_flags(self)
    }

    fn fresh_index(&mut self) -> usize {
        self.next_carry()
    }

    fn substitute_symbol(&mut self, symbol: &str, value: i64) {
        ARMCORTEXA::substitute_symbol(self, symbol, value)
    }

    fn stack_pointer_at_return(&self) -> (RegisterValue, i64) {
        (self.registers[31].clone(), 0)
    }

    fn read_rw_queue(&self) -> Vec<MemoryAccess> {
        ARMCORTEXA::read_rw_queue(self)
    }

    fn clear_rw_queue(&mut self) {
        ARMCORTEXA::clear_rw_queue(self)
    }

    fn memory(&self) -> &BTreeMap<String, MemorySafeRegion> {
        &self.memory
    }

    fn memory_mut(&mut self) -> &mut BTreeMap<String, MemorySafeRegion> {
        &mut self.memory
    }

    fn memory_labels(&self) -> &BTreeMap<String, (String, i64)> {
        &self.memory_labels
    }

    fn code_labels(&self) -> &BTreeSet<String> {
        &self.code_labels
    }

    fn set_code_labels(&mut self, labels: Rc<BTreeSet<String>>) {
        self.code_labels = labels;
    }

    fn add_data_symbol(&mut self, name: &str, section: &str, offset: i64, size: Option<i64>) {
        self.memory_labels
            .insert(name.to_string(), (section.to_string(), offset));
        if let Some(size) = size.filter(|s| *s > 0) {
            self.data_symbol_sizes.insert(name.to_string(), size);
        }
    }

    fn write_journal(&self) -> &[CellWrite] {
        &self.write_journal
    }

    fn write_journal_mut(&mut self) -> &mut Vec<CellWrite> {
        &mut self.write_journal
    }

    fn blind_stack_writes(&self) -> &[(AbstractExpression, i64, i64)] {
        &self.blind_stack_writes
    }

    fn symbolic_slots(&self) -> Vec<SymbolicSlot> {
        self.symbolic_slots.clone()
    }

    fn set_symbolic_slots(&mut self, slots: Vec<SymbolicSlot>) {
        self.symbolic_slots = slots;
    }

    fn select_definitions(&self) -> &SelectDefinitions {
        &self.select_definitions
    }

    fn select_definitions_mut(&mut self) -> &mut SelectDefinitions {
        &mut self.select_definitions
    }

    fn symbols_bounding_counter(&self) -> &BTreeMap<String, Vec<String>> {
        &self.symbols_bounding_counter
    }

    fn symbols_bounding_counter_mut(&mut self) -> &mut BTreeMap<String, Vec<String>> {
        &mut self.symbols_bounding_counter
    }

    fn element_facts(&self) -> &ElementFacts {
        &self.element_facts
    }

    fn fresh_bounds(&self) -> &[ast::Bool] {
        &self.fresh_bounds
    }

    fn set_immediate(&mut self, register: String, value: u64) {
        ARMCORTEXA::set_immediate(self, register, value)
    }

    fn set_abstract(&mut self, register: String, value: AbstractExpression) {
        ARMCORTEXA::set_abstract(self, register, value)
    }

    fn set_argument(&mut self, index: usize, value: AbstractExpression) {
        if index < 8 {
            self.set_abstract(format!("x{index}"), value);
        } else {
            self.set_stack_element(8 * (index as i64 - 8), Some(value), 0);
        }
    }

    fn change_alignment(&mut self, value: i64) {
        ARMCORTEXA::change_alignment(self, value)
    }

    fn add_pointer_elements(&mut self, region: &str, target: &str) {
        ARMCORTEXA::add_pointer_elements(self, region, target)
    }

    fn add_element_range(&mut self, region: &str, range: ElementRange) {
        ARMCORTEXA::add_element_range(self, region, range)
    }

    fn allow_red_zone(&mut self, bytes: i64) {
        self.red_zone = bytes;
    }

    fn findings(&self) -> Vec<String> {
        ARMCORTEXA::findings(self)
    }
}
