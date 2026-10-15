use crate::machine::*;
use crate::x86::computer::*;

fn is_label(text: &str) -> bool {
    text.strip_suffix(':')
        .is_some_and(|l| !l.is_empty() && !l.contains(char::is_whitespace) && !l.contains('"'))
}

fn strip_comment(line: &str) -> String {
    let mut text = line.to_string();
    while let Some(start) = text.find("/*") {
        match text[start..].find("*/") {
            Some(end) => text.replace_range(start..start + end + 2, " "),
            None => {
                text.truncate(start);
                break;
            }
        }
    }
    let mut in_string = false;
    let bytes = text.as_bytes();
    for (i, c) in text.char_indices() {
        match c {
            '"' => in_string = !in_string,
            '#' if !in_string => return text[..i].trim().to_string(),
            '/' if !in_string && bytes.get(i + 1) == Some(&b'/') => {
                return text[..i].trim().to_string();
            }
            _ => (),
        }
    }
    text.trim().to_string()
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Context {
    Code,
    Uncertain,
}

const DATA_DIRECTIVES: [&str; 14] = [
    ".long", ".quad", ".value", ".short", ".word", ".int", ".octa", ".asciz", ".ascii", ".string",
    ".zero", ".space", ".skip", ".hword",
];

fn ends_block(text: &str) -> bool {
    let opcode = text.split_whitespace().next().unwrap_or_default();
    matches!(opcode, "ret" | "retq" | "jmp" | "jmpq" | "ud2" | "hlt")
}

fn condition_code<'a>(mnemonic: &'a str, stem: &str) -> Option<&'a str> {
    mnemonic
        .strip_prefix(stem)
        .filter(|cc| CONDITION_CODES.contains(cc))
}

impl Instruction {
    fn target(&self) -> Option<&str> {
        match self.operands.first() {
            Some(Operand::Label(label)) => Some(label),
            _ => None,
        }
    }

    fn may_select(&self) -> bool {
        let m = self.mnemonic.as_str();
        condition_code(m, "cmov").is_some()
            || condition_code(m, "set").is_some()
            || matches!(m, "adc" | "sbb" | "tzcnt" | "bsf")
    }
}

impl MachineInstruction for Instruction {
    type Operand = Operand;
    const FIXED_WIDTH: Option<usize> = None;

    fn statements(lines: Vec<String>) -> Vec<String> {
        let mut out = Vec::new();
        let mut context = Context::Uncertain;
        for line in lines {
            let text = strip_comment(&line);
            let statements: Vec<String> = if text.starts_with('.') || !text.contains(';') {
                vec![text]
            } else {
                text.split(';').map(|s| s.trim().to_string()).collect()
            };
            for text in statements {
                if text.is_empty() || is_label(&text) {
                    out.push(text);
                    continue;
                }
                if let Some(bytes) = byte_values(&text) {
                    let decoded = decode_encoded(&bytes);
                    let exact = decoded
                        .as_deref()
                        .is_some_and(|d| !d.starts_with("bums.encoded_memory_access"));
                    match (context, decoded) {
                        (Context::Code, Some(instruction)) => out.push(instruction),
                        (Context::Code, None) => {
                            out.push(format!("bums.encoded_unknown {}", &text[5..].trim()))
                        }
                        (Context::Uncertain, Some(instruction)) if exact => {
                            context = Context::Code;
                            out.push(instruction);
                        }
                        _ => out.push(text),
                    }
                    if let Some(last) = out.last()
                        && ends_block(last)
                    {
                        context = Context::Uncertain;
                    }
                    continue;
                }
                if text.starts_with('.') {
                    let directive = text.split_whitespace().next().unwrap_or_default();
                    if DATA_DIRECTIVES.contains(&directive)
                        || directive.contains("align")
                        || matches!(directive, ".text" | ".data" | ".section" | ".previous")
                    {
                        context = Context::Uncertain;
                    }
                    out.push(text);
                    continue;
                }
                context = if ends_block(&text) {
                    Context::Uncertain
                } else {
                    Context::Code
                };
                out.push(text);
            }
        }
        out
    }

    fn alignment(directive: &str, argument: i64) -> Option<i64> {
        match directive {
            ".p2align" => (0..32).contains(&argument).then(|| 1 << argument),
            ".align" | ".balign" => Some(argument.max(1)),
            _ => None,
        }
    }

    fn item_width(directive: &str) -> Option<i64> {
        match directive {
            ".byte" => Some(1),
            ".value" | ".short" | ".word" | ".hword" | ".2byte" => Some(2),
            ".long" | ".int" | ".4byte" => Some(4),
            ".quad" | ".8byte" => Some(8),
            ".octa" => Some(16),
            _ => None,
        }
    }

    fn parse(text: String) -> Self {
        Instruction::new(text)
    }

    fn label(&self) -> Option<&str> {
        self.is_label().then_some(self.opcode.as_str())
    }

    fn opcode(&self) -> &str {
        &self.opcode
    }

    fn flow(&self) -> Flow<'_> {
        let m = self.mnemonic.as_str();
        let target = self.target();
        match m {
            _ if self.is_label() => Flow::Next,
            "ret" => Flow::Return,
            "ud2" | "int3" | "hlt" => Flow::Trap,
            "call" => Flow::Call,
            "jmp" => target.map_or(Flow::Indirect, Flow::Jump),
            "jrcxz" | "jecxz" | "loop" => target.map_or(Flow::Indirect, Flow::Branch),
            "bums.jump_table" => Flow::Indirect,
            _ if condition_code(m, "j").is_some() => target.map_or(Flow::Indirect, Flow::Branch),
            _ => Flow::Next,
        }
    }

    fn is_straight_line(&self) -> bool {
        !self.is_label() && self.flow() == Flow::Next && !self.may_select()
    }
}

impl Machine for X86_64 {
    type Operand = Operand;
    type Instruction = Instruction;
    type Lanes = ();

    fn new() -> Self {
        X86_64::new()
    }

    fn execute(
        &mut self,
        pc: usize,
        instruction: &Instruction,
    ) -> Result<ExecuteReturnType<Operand>, String> {
        X86_64::execute(self, pc, instruction)
    }

    fn fingerprint(&self, with_flags: bool) -> Option<String> {
        Some(X86_64::fingerprint(self, with_flags))
    }

    fn solver(&self) -> &Solver {
        &self.solver
    }

    fn set_solver(&mut self, solver: Solver) {
        self.solver = solver;
    }

    fn get_state(&self) -> MachineState {
        X86_64::get_state(self)
    }

    fn set_state(&mut self, state: MachineState) {
        X86_64::set_state(self, state)
    }

    fn register_at(&self, index: usize) -> RegisterValue {
        X86_64::register_at(self, index)
    }

    fn set_register_at(&mut self, index: usize, value: RegisterValue) {
        X86_64::set_register_at(self, index, value)
    }

    fn get_register(&mut self, register: &Operand) -> RegisterValue {
        X86_64::get_register(self, register)
    }

    fn set_register(
        &mut self,
        register: &Operand,
        kind: RegisterKind,
        base: Option<AbstractExpression>,
        offset: i64,
    ) {
        X86_64::set_register(self, register, kind, base, offset)
    }

    fn loaded(&self, index: usize) -> bool {
        self.loaded.get(index).copied().unwrap_or(false)
    }

    fn lanes(&self) {}

    fn set_lanes(&mut self, _lanes: ()) {}

    fn set_flags(&mut self, flags: [Option<FlagValue>; 4]) {
        X86_64::set_flags(self, flags)
    }

    fn set_unknown_flags(&mut self) {
        X86_64::set_unknown_flags(self)
    }

    fn fresh_index(&mut self) -> usize {
        self.unknown_counter += 1;
        self.unknown_counter - 1
    }

    fn substitute_symbol(&mut self, symbol: &str, value: i64) {
        X86_64::substitute_symbol(self, symbol, value)
    }

    fn check_stack_pointer_restored(&self, pc: usize) {
        X86_64::check_stack_pointer_restored(self, pc)
    }

    fn read_rw_queue(&self) -> Vec<MemoryAccess> {
        self.rw_queue.clone()
    }

    fn clear_rw_queue(&mut self) {
        self.rw_queue.clear();
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

    fn add_data_symbol(&mut self, name: &str, section: &str, offset: i64, _size: Option<i64>) {
        self.memory_labels
            .insert(name.to_string(), (section.to_string(), offset));
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

    fn set_immediate(&mut self, register: String, value: u64) {
        X86_64::set_immediate(self, register, value)
    }

    fn set_abstract(&mut self, register: String, value: AbstractExpression) {
        X86_64::set_abstract(self, register, value)
    }

    fn set_argument(&mut self, index: usize, value: AbstractExpression) {
        X86_64::set_argument(self, index, value)
    }
}
