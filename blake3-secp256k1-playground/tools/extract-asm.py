"""Disassemble ELF objects into the `.S` form the checker reads.

The objects are assembled for aarch64-linux-gnu or x86_64-linux-gnu purely for
analysis: ELF keeps the relocations that say which table an instruction
addresses and which instruction each jump-table entry lands on, and LLVM's
disassembly of those triples is the GNU (AArch64) or AT&T (x86-64) syntax the
parser expects. The output is:

- every function under its own name, and a label `L_<hex offset>` at every
  other branch or jump-table target, so no target is written as `symbol+offset`;
- AArch64 `adrp xN, table` / `add xN, xN, :lo12:table` and x86-64
  `table+off(%rip)` naming the data they address;
- each data section after the code, byte for byte, with every table entry
  written as `.word <target> - <table>` (relative) or `.quad <target>`
  (absolute) and each sized symbol's `.size`.

Absolute symbols (`*ABS*`, the struct offsets the sources `.set`) are dropped:
they are already folded into the instructions. Constants NASM keeps in .text
move to a `.rodata_in_text` section. A call to memset, memcpy or memmove that no object
defines gets a byte-at-a-time reference implementation appended (memmove too: it touches
the same bytes as memcpy), so the checker
sees exactly the bytes the libc routine touches.

Usage: python3 extract-asm.py <object dir> <output dir>
Set OBJDUMP to choose the objdump binary (default: llvm-objdump).
"""

import os
import re
import subprocess
import sys

OBJDUMP = os.environ.get("OBJDUMP", "llvm-objdump")
PREFIXES = ()
TEXT_DATA = ".rodata_in_text"
LIBC = {
    "aarch64": {
        "memset": """// ---- reference memset: stores the low byte of w1 to x0[0..x2)
\t.text
memset:
mov\tx3, x0
cbz\tx2, memset_done
memset_loop:
strb\tw1, [x3], #1
subs\tx2, x2, #1
b.ne\tmemset_loop
memset_done:
ret
""",
        "memcpy": """// ---- reference memcpy: copies x1[0..x2) to x0[0..x2)
\t.text
memcpy:
mov\tx3, x0
cbz\tx2, memcpy_done
memcpy_loop:
ldrb\tw4, [x1], #1
strb\tw4, [x3], #1
subs\tx2, x2, #1
b.ne\tmemcpy_loop
memcpy_done:
ret
""",
        "memmove": """// ---- reference memmove: reads x1[0..x2) and writes x0[0..x2), the bytes memcpy touches
\t.text
memmove:
mov\tx3, x0
cbz\tx2, memmove_done
memmove_loop:
ldrb\tw4, [x1], #1
strb\tw4, [x3], #1
subs\tx2, x2, #1
b.ne\tmemmove_loop
memmove_done:
ret
""",
    },
    "x86_64": {
        "memset": """# ---- reference memset: stores %sil to (%rdi)[0..%rdx)
\t.text
memset:
movq\t%rdi, %rax
testq\t%rdx, %rdx
je\tmemset_done
memset_loop:
movb\t%sil, (%rdi)
incq\t%rdi
decq\t%rdx
jne\tmemset_loop
memset_done:
retq
""",
        "memcpy": """# ---- reference memcpy: copies (%rsi)[0..%rdx) to (%rdi)[0..%rdx)
\t.text
memcpy:
movq\t%rdi, %rax
testq\t%rdx, %rdx
je\tmemcpy_done
memcpy_loop:
movb\t(%rsi), %cl
movb\t%cl, (%rdi)
incq\t%rsi
incq\t%rdi
decq\t%rdx
jne\tmemcpy_loop
memcpy_done:
retq
""",
        "memmove": """# ---- reference memmove: reads (%rsi)[0..%rdx) and writes (%rdi)[0..%rdx), the bytes memcpy touches
\t.text
memmove:
movq\t%rdi, %rax
testq\t%rdx, %rdx
je\tmemmove_done
memmove_loop:
movb\t(%rsi), %cl
movb\t%cl, (%rdi)
incq\t%rsi
incq\t%rdi
decq\t%rdx
jne\tmemmove_loop
memmove_done:
retq
""",
    },
}


def objdump(*args):
    return subprocess.run(
        [OBJDUMP, *args], check=True, capture_output=True, text=True
    ).stdout


def plain_name(name):
    for prefix in PREFIXES:
        if name.startswith(prefix):
            return name[len(prefix):]
    return name


def read_arch(obj):
    header = objdump("-f", obj)
    return "x86_64" if "x86-64" in header else "aarch64"


def read_symbols(obj):
    """(section, address, size, name) for every named symbol."""
    symbols = []
    pattern = re.compile(r"^([0-9a-f]+) (.{7}) (\S+)\s+([0-9a-f]+) (?:\.(?:hidden|internal|protected) )?(\S+)$")
    for line in objdump("-t", obj).splitlines():
        m = pattern.match(line)
        if not m:
            continue
        address, flags, section, size, name = m.groups()
        if (
            "d" in flags[5:]
            or name.startswith("$")
            or name == section
            or section in ("*UND*", "*ABS*")
        ):
            continue
        symbols.append((section, int(address, 16), int(size, 16), name))
    return symbols


def read_relocations(obj):
    """section -> {offset: (type, target section or symbol, addend)}."""
    relocations = {}
    current = None
    pattern = re.compile(
        r"^([0-9a-f]+) (R_(?:AARCH64|X86_64)_\S+)\s+(\S+?)(?:([+-])0x([0-9a-f]+))?$"
    )
    for line in objdump("-r", obj).splitlines():
        header = re.match(r"^RELOCATION RECORDS FOR \[(.*)\]:", line)
        if header:
            current = relocations.setdefault(header.group(1), {})
            continue
        m = pattern.match(line)
        if m and current is not None:
            offset, kind, target, sign, addend = m.groups()
            addend = int(addend or "0", 16) * (-1 if sign == "-" else 1)
            current[int(offset, 16)] = (kind, target, addend)
    return relocations


def read_section_names(obj):
    names = set()
    for line in objdump("-h", obj).splitlines():
        m = re.match(r"^\s*\d+ (\S+)\s+[0-9a-f]+ [0-9a-f]+", line)
        if m:
            names.add(m.group(1))
    return names


def read_section_bytes(obj, section):
    data = bytearray()
    for line in objdump("-s", "-j", section, obj).splitlines():
        m = re.match(r"^ ([0-9a-f]+) ((?:[0-9a-f]{2,8} ){1,4})", line)
        if m:
            data += bytes.fromhex(m.group(2).replace(" ", ""))
    return bytes(data)


def read_instructions(obj, arch):
    """(address, mnemonic, operands) for each instruction in .text."""
    instructions = []
    pattern = re.compile(r"^\s*([0-9a-f]+):\s+(\S+)(?:\s+(.*?))?\s*$")
    comment = "#" if arch == "x86_64" else "//"
    for line in objdump("-d", "-z", "--no-show-raw-insn", "-j", ".text", obj).splitlines():
        if line.endswith(">:") or not line.strip():
            continue
        m = pattern.match(line)
        if m:
            address, mnemonic, operands = m.groups()
            data = re.search(r"\.(word|byte|short|xword|long|quad)\s+(\S+)", line)
            if data:
                instructions.append((int(address, 16), "." + data.group(1), data.group(2)))
                continue
            operands = (operands or "").split(comment)[0].strip()
            instructions.append((int(address, 16), mnemonic, operands))
    return instructions


class Object:
    def __init__(self, obj):
        self.arch = read_arch(obj)
        self.symbols = read_symbols(obj)
        self.relocations = read_relocations(obj)
        self.instructions = read_instructions(obj, self.arch)
        sections = read_section_names(obj)
        self.data_sections = sorted(
            {s for s, *_ in self.symbols if s != ".text"}
            | {s for s in self.relocations if s != ".text" and not s.startswith(".eh_frame")}
            | {
                target
                for relocations in self.relocations.values()
                for _, target, _ in relocations.values()
                if target in sections and target != ".text" and not target.startswith(".eh_frame")
            }
        )
        self.data = {s: read_section_bytes(obj, s) for s in self.data_sections}
        self.name_unnamed_jump_tables()

        self.names = {}
        for section, address, _, name in self.symbols:
            if section == ".text":
                names = self.names.setdefault(address, [])
                if plain_name(name) not in names:
                    names.append(plain_name(name))
        self.functions = {a: names[0] for a, names in self.names.items()}

        self.text_data_at = {}
        if self.arch == "x86_64":
            self.carve_text_data(obj)

        self.instruction_at = {a for a, _, _ in self.instructions}
        addresses = sorted(self.instruction_at)
        self.next_address = dict(zip(addresses, addresses[1:]))
        self.text_relocation = {}
        for place, relocation in self.relocations.get(".text", {}).items():
            owner = max((a for a in addresses if a <= place), default=None)
            if owner is not None:
                self.text_relocation[owner] = (place, *relocation)
        self.targets = set()
        self.page_of = {}

    def carve_text_data(self, obj):
        """Constants NASM keeps in .text, found through the rip-relative
        operands that reach them without a relocation, move to TEXT_DATA."""
        relocated = {p for p in self.relocations.get(".text", {})}
        ordered = sorted(self.instructions)
        targets = set()
        for (address, _, operands), following in zip(ordered, ordered[1:] + [None]):
            m = re.search(r"(-?0x[0-9a-f]+|-?\d+)?\(%rip\)", operands)
            if not m or following is None or any(address < p < following[0] for p in relocated):
                continue
            targets.add(following[0] + int(m.group(1) or "0", 0))
        if not targets:
            return
        labels = sorted({a for s, a, _, _ in self.symbols if s == ".text"})
        text = read_section_bytes(obj, ".text")
        spans = {}
        for target in targets:
            start = max((a for a in labels if a <= target), default=None)
            if start is None:
                raise ValueError(f"rip-relative target {target:#x} precedes every label")
            end = min((a for a in labels if a > start), default=len(text))
            spans[start] = end
        contents = bytearray()
        for start, end in sorted(spans.items()):
            for s, a, size, name in list(self.symbols):
                if s == ".text" and a == start:
                    self.symbols.remove((s, a, size, name))
                    self.symbols.append((TEXT_DATA, len(contents), end - start, name))
                    self.names.pop(a, None)
                    self.functions.pop(a, None)
            self.text_data_at[start] = (end, len(contents))
            contents += text[start:end]
            self.instructions = [i for i in self.instructions if not start <= i[0] < end]
        self.data_sections.append(TEXT_DATA)
        self.data[TEXT_DATA] = bytes(contents)

    def text_data_reference(self, target):
        for start, (end, placed) in self.text_data_at.items():
            if start <= target < end:
                return self.data_reference(TEXT_DATA, placed + target - start)
        raise ValueError(f"rip-relative target {target:#x} is code")

    def name_unnamed_jump_tables(self):
        """A relative jump table no symbol covers (clang's switch tables in .rodata) gets
        its own symbol, so each entry resolves against the table start and not a
        neighbouring constant."""
        for section, relocations in self.relocations.items():
            entries = sorted(offset for offset, (kind, target, _) in relocations.items()
                             if kind in ("R_AARCH64_PREL32", "R_X86_64_PC32") and target == ".text")
            runs = []
            for offset in entries:
                if runs and offset == runs[-1][-1] + 4:
                    runs[-1].append(offset)
                else:
                    runs.append([offset])
            for run in runs:
                covered = any(s == section and a <= run[0] < a + max(size, 1)
                              for s, a, size, _ in self.symbols)
                if not covered:
                    name = f"bums_jump_table{section.replace('.', '_')}_{run[0]:x}"
                    self.symbols.append((section, run[0], 4 * len(run), name))

    def data_symbol(self, section, offset):
        """The data symbol containing `offset`, and how far into it."""
        best = None
        for s, address, size, name in self.symbols:
            if s == section and address <= offset < address + max(size, 1):
                if best is None or address > best[1]:
                    best = (name, address)
        if best is None:
            named = [(abs(address - offset), name, address)
                     for s, address, _, name in self.symbols if s == section]
            if not named:
                name = "bums" + section.replace(".", "_")
                if (section, 0, 0, name) not in self.symbols:
                    self.symbols.append((section, 0, 0, name))
                return name, offset
            _, name, address = min(named)
            return name, offset - address
        return best[0], offset - best[1]

    def code_label(self, address):
        if address not in self.instruction_at:
            raise ValueError(f"target {address:#x} is not an instruction")
        self.targets.add(address)
        return self.functions.get(address, f"L_{address:x}")

    def data_reference(self, target, addend):
        if target == ".text":
            return self.code_label(addend)
        if target in self.data_sections:
            name, into = self.data_symbol(target, addend)
        elif any(n == target and s != ".text" for s, _, _, n in self.symbols):
            name, into = target, addend
        else:
            name, into = plain_name(target), addend
        if into == 0:
            return name
        return f"{name}+{into}" if into > 0 else f"{name}-{-into}"

    def table_entries(self, section):
        """offset -> (directive, value) for each relocated entry."""
        entries = {}
        for offset, (kind, target, addend) in self.relocations.get(section, {}).items():
            if kind in ("R_AARCH64_PREL32", "R_X86_64_PC32") and target == ".text":
                table, into = self.data_symbol(section, offset)
                entries[offset] = (".word" if kind.startswith("R_AARCH64") else ".long",
                                   f"{self.code_label(addend - into)} - {table}", 4)
            elif kind in ("R_X86_64_64", "R_AARCH64_ABS64"):
                entries[offset] = (".quad", self.data_reference(target, addend), 8)
            else:
                raise ValueError(f"unhandled data relocation {kind} {target} at {offset:#x}")
        return entries

    def rewrite_x86(self, address, mnemonic, operands):
        relocation = self.text_relocation.get(address)
        if relocation:
            place, kind, target, addend = relocation
            if kind in ("R_X86_64_PC32", "R_X86_64_PLT32") and "(%rip)" not in operands:
                return plain_name(target) if target != ".text" else self.code_label(addend + 4)
            if kind in ("R_X86_64_PC32", "R_X86_64_PLT32"):
                after = self.next_address.get(address)
                if after is None:
                    raise ValueError(f"rip-relative operand in the last instruction at {address:#x}")
                reference = self.data_reference(target, addend + (after - place))
                return re.sub(r"-?(?:0x[0-9a-f]+)?\(%rip\)", f"{reference}(%rip)", operands)
            if kind in ("R_X86_64_32S", "R_X86_64_32"):
                reference = self.data_reference(target, addend)
                rewritten, replaced = re.subn(r"(^|[\s,$])(?:0x0|0)(?=\(|,|$)", lambda m: m.group(1) + reference, operands, count=1)
                if not replaced:
                    rewritten, replaced = re.subn(r"(^|[\s,])\(", lambda m: m.group(1) + reference + "(", operands, count=1)
                if not replaced:
                    raise ValueError(f"{kind} at {address:#x} has no displacement to name in {operands!r}")
                return rewritten
            raise ValueError(f"unhandled text relocation {kind} at {address:#x}")

        rip = re.search(r"(-?0x[0-9a-f]+|-?\d+)?\(%rip\)", operands)
        if rip:
            after = self.next_address.get(address)
            target = after + int(rip.group(1) or "0", 0)
            return operands.replace(rip.group(0), f"{self.text_data_reference(target)}(%rip)")

        def label(m):
            return self.code_label(int(m.group(1), 16))

        return re.sub(r"0x([0-9a-f]+) <[^>]+>", label, operands)

    def rewrite(self, address, mnemonic, operands):
        if self.arch == "x86_64":
            return self.rewrite_x86(address, mnemonic, operands)
        relocation = self.relocations.get(".text", {}).get(address)
        if relocation:
            kind, target, addend = relocation
            if kind == "R_AARCH64_ADR_PREL_PG_HI21":
                reference = self.data_reference(target, addend)
                self.page_of[operands.split(",")[0].strip()] = reference
                operands = re.sub(r",\s*.*$", ", " + reference, operands)
            elif kind == "R_AARCH64_ADD_ABS_LO12_NC":
                reference = self.data_reference(target, addend)
                operands = re.sub(r"#0x0$|#0$", ":lo12:" + reference, operands)
            elif re.fullmatch(r"R_AARCH64_LDST\d+_ABS_LO12_NC", kind):
                base = re.search(r"\[(x\d+)", operands)
                reference = self.data_reference(target, addend)
                if not base or self.page_of.get(base.group(1)) != reference or not re.search(r"\[x\d+\]", operands):
                    raise ValueError(f"lo12 load at {address:#x} does not complete its adrp")
            elif kind in ("R_AARCH64_CALL26", "R_AARCH64_JUMP26"):
                operands = plain_name(target)
            elif kind in ("R_AARCH64_CONDBR19", "R_AARCH64_TSTBR14"):
                name = self.code_label(addend) if target == ".text" else plain_name(target)
                operands = re.sub(r"(?:0x)?[0-9a-f]+ <[^>]+>$", name, operands)
            elif kind == "R_AARCH64_ADR_PREL_LO21":
                operands = re.sub(r",\s*.*$", ", " + self.data_reference(target, addend), operands)
            else:
                raise ValueError(f"unhandled text relocation {kind} at {address:#x}")
            return operands

        def label(m):
            return self.code_label(int(m.group(1), 16))

        return re.sub(r"(?:0x)?([0-9a-f]+) <[^>]+>", label, operands)

    def render(self):
        body = [(a, m, self.rewrite(a, m, o)) for a, m, o in self.instructions]
        data = {s: self.table_entries(s) for s in self.data_sections}

        lines = ["\t.text"]
        text_data = [(a, m, o) for a, m, o in body if m.startswith(".")]
        body = [(a, m, o) for a, m, o in body if not m.startswith(".")]
        for address, mnemonic, operands in body:
            if address in self.names:
                lines.extend(f"{name}:" for name in self.names[address])
            elif address in self.targets:
                lines.append(f"L_{address:x}:")
            lines.append(f"{mnemonic}\t{operands}".rstrip())

        if text_data:
            lines.append("\t.section .text_data")
            for address, directive, value in text_data:
                if address in self.names:
                    lines.extend(f"{name}:" for name in self.names[address])
                elif address in self.targets:
                    lines.append(f"L_{address:x}:")
                lines.append(f"\t{directive} {value}")

        for section in self.data_sections:
            lines.append(f"\t.section {section}")
            starts = {}
            sizes = {}
            for s, a, size, n in self.symbols:
                if s == section:
                    starts.setdefault(a, []).append(n)
                    if size:
                        sizes[n] = size
            entries = data[section]
            raw = []

            def flush():
                if raw:
                    lines.append("\t.byte " + ",".join(str(b) for b in raw))
                    raw.clear()

            contents = self.data[section]
            if not contents:
                cursor = 0
                for address, names in sorted(starts.items()):
                    if address > cursor:
                        lines.append(f"\t.zero {address - cursor}")
                        cursor = address
                    for name in names:
                        lines.append(f"{name}:")
                        if name in sizes:
                            lines.append(f"\t.size {name}, {sizes[name]}")
                    span = max((sizes.get(n, 0) for n in names), default=0)
                    if span:
                        lines.append(f"\t.zero {span}")
                        cursor += span
                continue
            offset = 0
            while offset < len(contents):
                if offset in starts:
                    flush()
                    for name in starts[offset]:
                        lines.append(f"{name}:")
                        if name in sizes:
                            lines.append(f"\t.size {name}, {sizes[name]}")
                if offset in entries:
                    flush()
                    directive, value, width = entries[offset]
                    lines.append(f"\t{directive} {value}")
                    offset += width
                    continue
                raw.append(contents[offset])
                if len(raw) == 16:
                    flush()
                offset += 1
            flush()

        return "\n".join(lines) + "\n"

    def defined(self):
        """Every name this object defines: functions, data symbols, labels."""
        names = {n for names in self.names.values() for n in names}
        names |= {n for s, _, _, n in self.symbols if s != ".text"}
        return names

    def external_references(self):
        """Names this object's relocations reach outside itself."""
        sections = {".text", *self.data_sections}
        referenced = {
            plain_name(target)
            for section, relocations in self.relocations.items()
            if not section.startswith(".eh_frame")
            for (_, target, _) in relocations.values()
            if target not in sections
        }
        return referenced - self.defined()


def merged(name, text, objects, rendered):
    """Append the listing of each object that defines functions `name` calls or
    data it reads, and transitively what those listings call, so the checker sees
    one program. Names an appended listing shares with what precedes it, and all
    its offset labels, get a file prefix, applied to the whole appended text, so
    each file's code keeps reaching its own data."""
    host = objects[name]
    references = set(host.external_references())
    included = []
    growing = True
    while growing:
        growing = False
        for other, obj in objects.items():
            if obj.arch != host.arch or other == name or other in (o for o, _ in included):
                continue
            provided = {n for names in obj.names.values() for n in names}
            provided |= {plain_name(n) for s, _, _, n in obj.symbols if s != ".text"}
            needed = references & provided
            if needed:
                included.append((other, needed))
                references |= obj.external_references()
                growing = True
    appended = []
    provided_elsewhere = set()
    defined = set(host.defined())
    for other, needed in included:
        obj = objects[other]
        clashes = defined & obj.defined()
        prefix = other.replace("-", "_") + "__"
        body = rendered[other]
        body = re.sub(r"\bL_([0-9a-f]+)\b", lambda m: f"L{prefix}{m.group(1)}", body)
        if clashes:
            pattern = re.compile(r"\b(" + "|".join(map(re.escape, sorted(clashes, key=len, reverse=True))) + r")\b")
            body = pattern.sub(lambda m: prefix + m.group(1), body)
        comment = "#" if host.arch == "x86_64" else "//"
        appended.append(f"{comment} ---- {other}.S, for {', '.join(sorted(needed))}\n\t.text\n" + body)
        provided_elsewhere.update(needed)
        defined |= obj.defined()
    for routine in sorted(references - provided_elsewhere - defined):
        if routine in LIBC[host.arch]:
            appended.append(LIBC[host.arch][routine])
    return text + "".join(appended)


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    source, output = sys.argv[1:]
    os.makedirs(output, exist_ok=True)
    objects = {}
    for entry in sorted(os.listdir(source)):
        if entry.endswith(".o"):
            objects[entry[:-2]] = Object(os.path.join(source, entry))
    rendered = {}
    for name, obj in list(objects.items()):
        try:
            rendered[name] = obj.render()
        except ValueError as e:
            print(f"{name}.o: skipped, {e}", file=sys.stderr)
            del objects[name]
    for name, text in rendered.items():
        with open(os.path.join(output, name + ".S"), "w") as f:
            f.write(merged(name, text, objects, rendered))
        print(f"{name}.o -> {name}.S")


if __name__ == "__main__":
    main()
