use std::collections::BTreeMap;

use crate::instruction_parser::Instruction;
use crate::machine::{Flow, MachineInstruction};

const PAGE: i64 = 1 << 12;
const TEXT_DATA: &str = ".text.data";
const UNSUPPORTED_ENCODING: &str = "bums.encoded_unknown";

#[derive(Debug, Clone, PartialEq)]
pub enum DataValue {
    Literal(i64),
    LabelDifference {
        target: String,
        base: String,
        value: i64,
    },
    Pointer(String, i64),
    Unknown,
}

#[derive(Debug, Clone)]
pub struct DataItem {
    pub offset: i64,
    pub width: i64,
    pub value: DataValue,
}

#[derive(Debug, Clone)]
pub struct DataSection {
    pub name: String,
    pub writable: bool,
    pub address: i64,
    pub size: i64,
    pub alignment: i64,
    pub items: Vec<DataItem>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct DataSymbol {
    pub section: String,
    pub offset: i64,
    pub size: Option<i64>,
}

#[derive(Debug, Clone)]
pub struct Listing<I = Instruction> {
    pub code: Vec<I>,
    pub labels: Vec<(String, usize)>,
    pub line_addresses: Vec<i64>,
    pub line_at: BTreeMap<i64, usize>,
    pub data: Vec<DataSection>,
    pub data_symbols: BTreeMap<String, DataSymbol>,
    text_block: Option<usize>,
    held_alignment: Vec<(String, String)>,
    falls_through: bool,
}

impl<I> Default for Listing<I> {
    fn default() -> Self {
        Listing {
            code: Vec::new(),
            labels: Vec::new(),
            line_addresses: Vec::new(),
            line_at: BTreeMap::new(),
            data: Vec::new(),
            data_symbols: BTreeMap::new(),
            text_block: None,
            held_alignment: Vec::new(),
            falls_through: false,
        }
    }
}

impl<I> Listing<I> {
    pub fn address_of(&self, name: &str) -> Option<i64> {
        if let Some(&(_, line)) = self.labels.iter().find(|(l, _)| l == name) {
            return self.line_addresses.get(line).copied();
        }
        let symbol = self.data_symbols.get(name)?;
        let section = self.data.iter().find(|s| s.name == symbol.section)?;
        Some(section.address + symbol.offset)
    }

    pub fn line_for_address(&self, address: i64) -> Option<usize> {
        self.line_at.get(&address).copied()
    }
}

struct TextRun {
    labels: Vec<String>,
    directives: Vec<(String, String)>,
}

enum Section {
    Text,
    Data(usize),
}

pub(crate) fn parse_integer(text: &str) -> Option<i64> {
    let (negative, digits) = match text.strip_prefix('-') {
        Some(rest) => (true, rest),
        None => (false, text),
    };
    let value = match digits
        .strip_prefix("0x")
        .or_else(|| digits.strip_prefix("0X"))
    {
        Some(hex) => u64::from_str_radix(hex, 16).ok()? as i64,
        None => digits.parse::<i64>().ok()?,
    };
    Some(if negative {
        value.wrapping_neg()
    } else {
        value
    })
}

fn section_name(rest: &str) -> String {
    let token = rest.split_whitespace().next().unwrap_or("");
    if token.starts_with("__") {
        token.split(',').take(2).collect::<Vec<_>>().join(",")
    } else {
        token.split(',').next().unwrap_or("").to_string()
    }
}

fn is_text_section(name: &str) -> bool {
    name.starts_with(".text") || name.starts_with("__TEXT,__text")
}

fn is_writable_section(name: &str) -> bool {
    name.starts_with(".data") || name.starts_with(".bss") || name.starts_with("__DATA")
}

fn encoded_instructions<I: MachineInstruction>(directives: &[(String, String)]) -> i64 {
    let bytes: i64 = directives
        .iter()
        .filter(|(directive, _)| emits_bytes::<I>(directive))
        .map(|(directive, rest)| {
            let items = rest.split(',').filter(|o| !o.trim().is_empty()).count() as i64;
            match (directive.as_str(), I::item_width(directive)) {
                (_, Some(width)) => width * items,
                (".zero" | ".space" | ".skip", _) => {
                    parse_integer(rest.split(',').next().unwrap_or("").trim()).unwrap_or(4)
                }
                _ => 4 * items.max(1),
            }
        })
        .sum();
    (bytes + 3) / 4
}

fn emits_bytes<I: MachineInstruction>(directive: &str) -> bool {
    I::item_width(directive).is_some()
        || matches!(
            directive,
            ".zero" | ".space" | ".skip" | ".fill" | ".ascii" | ".asciz" | ".string" | ".inst"
        )
}

impl<I: MachineInstruction> Listing<I> {
    pub fn parse<S: Into<String>>(lines: impl IntoIterator<Item = S>) -> Listing<I> {
        let mut listing = Listing::default();
        let mut section = Section::Text;
        let mut pending: Vec<(usize, usize, String)> = Vec::new();
        let mut sizes: Vec<(String, i64)> = Vec::new();
        let mut waiting: Vec<String> = Vec::new();
        let mut run: Option<TextRun> = None;

        let statements = I::statements(lines.into_iter().map(Into::into).collect());
        for text in statements {
            if text.is_empty() || text.starts_with('#') {
                continue;
            }

            let is_label = text.ends_with(':') && !text.contains(char::is_whitespace);
            if !is_label && text.starts_with('.') {
                let (directive, rest) = match text.split_once(char::is_whitespace) {
                    Some((d, r)) => (d, r.trim()),
                    None => (text.as_str(), ""),
                };
                match directive {
                    ".text" => {
                        listing.commit(run.take(), &mut pending);
                        section = Section::Text;
                    }
                    ".data" | ".bss" | ".rodata" | ".const" | ".const_data" | ".section" => {
                        listing.commit(run.take(), &mut pending);
                        let name = if directive == ".section" {
                            section_name(rest)
                        } else {
                            directive.to_string()
                        };
                        section = if is_text_section(&name) {
                            Section::Text
                        } else {
                            Section::Data(listing.data_section(&name))
                        };
                    }
                    ".size" => {
                        if let Some((name, size)) = rest.split_once(',')
                            && let Some(size) = parse_integer(size.trim())
                        {
                            sizes.push((name.trim().to_string(), size));
                        }
                    }
                    _ => match section {
                        Section::Data(index) => {
                            listing.data_directive(index, directive, rest, &mut pending);
                        }
                        Section::Text => {
                            let aligns = matches!(directive, ".align" | ".p2align" | ".balign");
                            if emits_bytes::<I>(directive)
                                || (aligns && (run.is_some() || waiting.is_empty()))
                            {
                                run.get_or_insert_with(|| TextRun {
                                    labels: std::mem::take(&mut waiting),
                                    directives: Vec::new(),
                                })
                                .directives
                                .push((directive.to_string(), rest.to_string()));
                            }
                        }
                    },
                }
                continue;
            }

            match section {
                Section::Data(index) if is_label => {
                    listing.add_data_symbol(index, text.trim_end_matches(':').to_string());
                }
                Section::Text if is_label => {
                    listing.commit(run.take(), &mut pending);
                    waiting.push(text);
                }
                _ => {
                    if let Some(run) = run.take() {
                        for label in run.labels {
                            listing.push_code(I::parse(label));
                        }
                        for _ in 0..encoded_instructions::<I>(&run.directives) {
                            listing.push_code(I::parse(UNSUPPORTED_ENCODING.to_string()));
                        }
                    }
                    for label in waiting.drain(..) {
                        listing.push_code(I::parse(label));
                    }
                    listing.push_code(I::parse(text));
                }
            }
        }
        listing.commit(run.take(), &mut pending);
        for label in waiting.drain(..) {
            listing.push_code(I::parse(label));
        }

        listing.lay_out();
        for (name, size) in sizes {
            if let Some(symbol) = listing.data_symbols.get_mut(&name) {
                symbol.size = Some(size);
            }
        }
        for (section, item, operand) in pending {
            let value = listing.evaluate(&operand);
            listing.data[section].items[item].value = value;
        }
        listing
    }

    fn commit(&mut self, run: Option<TextRun>, pending: &mut Vec<(usize, usize, String)>) {
        let Some(run) = run else {
            return;
        };
        let encoded = encoded_instructions::<I>(&run.directives);
        if run.labels.is_empty() && encoded == 0 {
            self.held_alignment.extend(run.directives);
            return;
        }
        let index = self.text_block();
        for (directive, rest) in std::mem::take(&mut self.held_alignment) {
            self.data_directive(index, &directive, &rest, pending);
        }
        for label in run.labels {
            self.add_data_symbol(index, label.trim_end_matches(':').to_string());
        }
        for (directive, rest) in &run.directives {
            self.data_directive(index, directive, rest, pending);
        }
        if self.falls_through {
            for _ in 0..encoded {
                self.push_code(I::parse(UNSUPPORTED_ENCODING.to_string()));
            }
        }
    }

    fn push_code(&mut self, instruction: I) {
        if let Some(label) = instruction.label() {
            self.labels.push((label.to_string(), self.code.len()));
        } else {
            self.text_block = None;
            self.held_alignment.clear();
            self.falls_through = !matches!(
                instruction.flow(),
                Flow::Jump(_) | Flow::Return | Flow::Trap | Flow::Indirect
            );
        }
        self.code.push(instruction);
    }

    fn text_block(&mut self) -> usize {
        if let Some(index) = self.text_block {
            return index;
        }
        let name = match self
            .data
            .iter()
            .filter(|s| s.name.starts_with(TEXT_DATA))
            .count()
        {
            0 => TEXT_DATA.to_string(),
            n => format!("{TEXT_DATA}.{n}"),
        };
        let index = self.data_section(&name);
        self.text_block = Some(index);
        index
    }

    fn add_data_symbol(&mut self, index: usize, name: String) {
        let data = &self.data[index];
        self.data_symbols.insert(
            name,
            DataSymbol {
                section: data.name.clone(),
                offset: data.size,
                size: None,
            },
        );
    }

    fn data_section(&mut self, name: &str) -> usize {
        if let Some(index) = self.data.iter().position(|s| s.name == name) {
            return index;
        }
        self.data.push(DataSection {
            name: name.to_string(),
            writable: is_writable_section(name),
            address: 0,
            size: 0,
            alignment: 1,
            items: Vec::new(),
        });
        self.data.len() - 1
    }

    fn data_directive(
        &mut self,
        index: usize,
        directive: &str,
        rest: &str,
        pending: &mut Vec<(usize, usize, String)>,
    ) {
        let data = &mut self.data[index];
        let align_to = |data: &mut DataSection, boundary: i64| {
            if boundary > 1 {
                data.size = (data.size + boundary - 1) / boundary * boundary;
                data.alignment = data.alignment.max(boundary);
            }
        };
        let argument = || parse_integer(rest.split(',').next().unwrap_or("").trim());
        match directive {
            ".align" | ".p2align" | ".balign" => {
                if let Some(boundary) = argument().and_then(|n| I::alignment(directive, n)) {
                    align_to(data, boundary);
                }
            }
            ".zero" | ".space" | ".skip" => {
                if let Some(n) = argument() {
                    data.size += n;
                }
            }
            ".globl" | ".global" | ".private_extern" | ".hidden" | ".type" | ".local" | ".weak" => {
            }
            _ => {
                let Some(width) = I::item_width(directive) else {
                    log::warn!("data directive {directive} not modelled");
                    return;
                };
                for operand in rest.split(',').map(str::trim).filter(|o| !o.is_empty()) {
                    let value = match parse_integer(operand) {
                        Some(n) => DataValue::Literal(n),
                        None => {
                            pending.push((index, data.items.len(), operand.to_string()));
                            DataValue::Unknown
                        }
                    };
                    data.items.push(DataItem {
                        offset: data.size,
                        width,
                        value,
                    });
                    data.size += width;
                }
            }
        }
    }

    fn lay_out(&mut self) {
        let mut address = 0;
        for instruction in &self.code {
            self.line_addresses.push(address);
            if !instruction.is_label() {
                self.line_at.insert(address, self.line_addresses.len() - 1);
                address += 4;
            }
        }
        let mut next = (address / PAGE + 1) * PAGE;
        for section in &mut self.data {
            next = (next + 15) / 16 * 16;
            section.address = next;
            next += section.size;
        }
    }

    fn evaluate(&self, operand: &str) -> DataValue {
        let mut constant = 0i64;
        let mut symbols: Vec<(i64, &str)> = Vec::new();
        let mut sign = 1;
        let spaced = operand.replace('+', " + ").replace('-', " - ");
        for token in spaced.split_whitespace() {
            match token {
                "+" => sign = 1,
                "-" => sign = -sign,
                _ => {
                    match parse_integer(token) {
                        Some(n) => constant += sign * n,
                        None => symbols.push((sign, token)),
                    }
                    sign = 1;
                }
            }
        }
        match symbols.as_slice() {
            [] => DataValue::Literal(constant),
            [(1, name)] => DataValue::Pointer(name.to_string(), constant),
            [(1, a), (-1, b)] | [(-1, b), (1, a)] => {
                match (self.address_of(a), self.address_of(b)) {
                    (Some(target), Some(base)) => DataValue::LabelDifference {
                        target: a.to_string(),
                        base: b.to_string(),
                        value: target - base + constant,
                    },
                    _ => DataValue::Unknown,
                }
            }
            _ => DataValue::Unknown,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn listing(lines: &[&str]) -> Listing {
        Listing::parse(lines.iter().copied())
    }

    #[test]
    fn instructions_are_four_bytes_apart_and_labels_take_no_space() {
        let l = listing(&["f:", "add x0, x0, #1", "L_4:", "b L_4", "ret"]);
        assert_eq!(l.address_of("f"), Some(0));
        assert_eq!(l.address_of("L_4"), Some(4));
        assert_eq!(l.line_for_address(4), Some(3));
        assert_eq!(l.line_for_address(8), Some(4));
        assert_eq!(l.line_for_address(2), None);
    }

    #[test]
    fn labels_in_a_data_section_are_data() {
        let l = listing(&[
            "f:",
            "ret",
            "\t.section .rodata",
            "tbl:",
            "\t.word 1",
            "\t.text",
            "g:",
            "ret",
        ]);
        assert!(l.labels.iter().any(|(n, _)| n == "g"));
        assert!(!l.labels.iter().any(|(n, _)| n == "tbl"));
        assert_eq!(l.data_symbols["tbl"].offset, 0);
        assert_eq!(l.address_of("g"), Some(4));
    }

    #[test]
    fn a_dotted_label_in_code_is_code() {
        let l = listing(&["f:", ".loop:", "b.gt .loop", "ret"]);
        assert!(l.labels.iter().any(|(n, _)| n == ".loop"));
    }

    #[test]
    fn data_among_the_code_is_data() {
        let l = listing(&[
            ".text",
            ".align 8",
            ".quad 0,0",
            "iotas:",
            ".quad 1,2",
            "f:",
            "adr x28, iotas",
            "ret",
        ]);
        assert!(!l.labels.iter().any(|(n, _)| n == "iotas"));
        assert_eq!(l.data_symbols["iotas"].section, TEXT_DATA);
        assert_eq!(l.data_symbols["iotas"].offset, 16);
        assert_eq!(l.address_of("f"), Some(0));
    }

    #[test]
    fn data_on_either_side_of_code_is_two_blocks() {
        let l = listing(&[
            ".align 4",
            "first:",
            ".quad 1",
            "f:",
            "ret",
            ".p2align 3",
            "g:",
            "ret",
            "second:",
            ".quad 2",
        ]);
        assert_eq!(l.data.len(), 2);
        assert_eq!(l.data_symbols["first"].section, TEXT_DATA);
        assert_eq!(l.data_symbols["second"].offset, 0);
        assert_ne!(l.data_symbols["second"].section, TEXT_DATA);
        assert_eq!(l.data[0].alignment, 16);
        assert_eq!(l.data[1].alignment, 1);
        assert!(l.labels.iter().any(|(n, _)| n == "g"));
    }

    #[test]
    fn raw_words_among_instructions_stay_code() {
        let l = listing(&[
            "f:",
            "b Loop_ce",
            ".align 4",
            "Loop_ce:",
            ".long 0xce0f2a99",
            "subs x9, x9, #1",
            "b.ne Loop_ce",
            "g:",
            ".cfi_startproc",
            "ret",
        ]);
        assert!(l.labels.iter().any(|(n, _)| n == "Loop_ce"));
        assert!(l.labels.iter().any(|(n, _)| n == "g"));
        assert!(l.data_symbols.is_empty());
        assert_eq!(l.address_of("Loop_ce"), Some(4));
        let encoded = l.labels.iter().find(|(n, _)| n == "Loop_ce").unwrap().1 + 1;
        assert_eq!(l.code[encoded].opcode, UNSUPPORTED_ENCODING);
    }

    fn unsupported_encodings(l: &Listing) -> usize {
        l.code
            .iter()
            .filter(|i| i.opcode == UNSUPPORTED_ENCODING)
            .count()
    }

    #[test]
    fn an_encoded_instruction_directive_among_code_is_unsupported() {
        let l = listing(&["f:", "add x0, x0, #1", ".inst 0xce608c00", "ret"]);
        assert_eq!(unsupported_encodings(&l), 1);
    }

    #[test]
    fn words_reached_by_falling_through_are_unsupported_code() {
        let l = listing(&["f:", "add x0, x0, #1", ".long 0xce0f2a99", "g:", "ret"]);
        assert_eq!(unsupported_encodings(&l), 1);
        assert!(l.labels.iter().any(|(n, _)| n == "g"));
    }

    #[test]
    fn words_after_a_return_are_only_data() {
        let l = listing(&["f:", "ret", "tbl:", ".long 1", "g:", "ret"]);
        assert_eq!(unsupported_encodings(&l), 0);
        assert!(l.data_symbols.contains_key("tbl"));
    }

    #[test]
    fn table_entries_are_label_differences() {
        let l = listing(&[
            "f:",
            "br x5",
            "L_4:",
            "ret",
            "L_8:",
            "ret",
            "\t.section .rodata",
            "tbl:",
            "\t.word L_8 - tbl",
            "\t.word L_4 - tbl",
            "\t.size tbl, 8",
        ]);
        let tbl = l.address_of("tbl").unwrap();
        let data = &l.data[0];
        let entry = |target: &str, value| DataValue::LabelDifference {
            target: target.to_string(),
            base: "tbl".to_string(),
            value,
        };
        assert_eq!(data.items[0].value, entry("L_8", 8 - tbl));
        assert_eq!(data.items[1].value, entry("L_4", 4 - tbl));
        assert_eq!(data.items[1].offset, 4);
        assert_eq!(l.data_symbols["tbl"].size, Some(8));
        assert_eq!(l.line_for_address(tbl + (4 - tbl)), Some(3));
    }

    #[test]
    fn data_is_laid_out_with_alignment_and_widths() {
        let l = listing(&[
            ".section __TEXT,__const",
            ".align 5",
            "Lsigma:",
            ".quad 0x3320646e61707865,0x6b20657479622d32",
            "Lone:",
            ".long 1,0,0,0",
            ".byte 67,104",
            ".align 2",
            "Lend:",
        ]);
        let data = &l.data[0];
        assert_eq!(data.name, "__TEXT,__const");
        assert!(!data.writable);
        assert_eq!(l.data_symbols["Lone"].offset, 16);
        assert_eq!(l.data_symbols["Lend"].offset, 36);
        assert_eq!(data.items.len(), 8);
        assert_eq!(data.items[6].offset, 32);
        assert_eq!(data.items[6].width, 1);
    }

    #[test]
    fn a_reference_outside_the_listing_is_unknown_or_a_pointer() {
        let l = listing(&[
            "\t.section .rodata",
            "t:",
            "\t.quad gaussian_sequence",
            "\t.word elsewhere - t",
        ]);
        assert_eq!(
            l.data[0].items[0].value,
            DataValue::Pointer("gaussian_sequence".to_string(), 0)
        );
        assert_eq!(l.data[0].items[1].value, DataValue::Unknown);
    }
}
