"""Disassemble ELF objects into the `.S` form the checker reads.

The objects are assembled for aarch64-linux-gnu purely for analysis: ELF keeps
the relocations that say which table an `adrp`/`add` pair addresses and which
instruction each jump-table entry lands on, and its disassembly uses the GNU
syntax the parser expects. The output is:

- every function under its own name (without the `dav1d_` prefix), and a label
  `L_<hex offset>` at every other branch, `adr` or jump-table target, so no
  target is written as `symbol+offset`;
- `adrp xN, table` / `add xN, xN, :lo12:table` naming the data they address;
- each data section after the code, byte for byte, with every table entry
  written as `.word <target label> - <table>` and each sized symbol's `.size`.

Usage: python3 disassemble-elf.py <object dir> <output dir>
Set OBJDUMP to choose the objdump binary (default: objdump, which must be
LLVM's on macOS).
"""

import os
import re
import subprocess
import sys

OBJDUMP = os.environ.get("OBJDUMP", "objdump")
PREFIXES = ("_dav1d_", "dav1d_")


def objdump(*args):
    return subprocess.run(
        [OBJDUMP, *args], check=True, capture_output=True, text=True
    ).stdout


def plain_name(name):
    for prefix in PREFIXES:
        if name.startswith(prefix):
            return name[len(prefix):]
    return name


def read_symbols(obj):
    """(section, address, size, name) for every named symbol."""
    symbols = []
    pattern = re.compile(r"^([0-9a-f]+) (.{7}) (\S+)\s+([0-9a-f]+) (\S+)$")
    for line in objdump("-t", obj).splitlines():
        m = pattern.match(line)
        if not m:
            continue
        address, flags, section, size, name = m.groups()
        # Section symbols and the $x/$d mapping symbols are not names.
        if "d" in flags[5:] or name.startswith("$") or name == section:
            continue
        symbols.append((section, int(address, 16), int(size, 16), name))
    return symbols


def read_relocations(obj):
    """section -> {offset: (type, target section or symbol, addend)}."""
    relocations = {}
    current = None
    pattern = re.compile(r"^([0-9a-f]+) (R_AARCH64_\S+)\s+(\S+?)(?:([+-])0x([0-9a-f]+))?$")
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


def read_section_bytes(obj, section):
    data = bytearray()
    for line in objdump("-s", "-j", section, obj).splitlines():
        m = re.match(r"^ ([0-9a-f]+) ((?:[0-9a-f]{2,8} ){1,4})", line)
        if m:
            data += bytes.fromhex(m.group(2).replace(" ", ""))
    return bytes(data)


def read_instructions(obj):
    """(address, mnemonic, operands) for each instruction in .text."""
    instructions = []
    pattern = re.compile(r"^\s*([0-9a-f]+):\s+(\S+)(?:\s+(.*?))?\s*$")
    for line in objdump("-d", "--no-show-raw-insn", "-j", ".text", obj).splitlines():
        if line.endswith(">:") or not line.strip():
            continue
        m = pattern.match(line)
        if m:
            address, mnemonic, operands = m.groups()
            operands = (operands or "").split("//")[0].strip()
            instructions.append((int(address, 16), mnemonic, operands))
    return instructions


class Object:
    def __init__(self, obj):
        self.symbols = read_symbols(obj)
        self.relocations = read_relocations(obj)
        self.instructions = read_instructions(obj)
        self.data_sections = sorted(
            {s for s, *_ in self.symbols if s != ".text"}
            | {s for s in self.relocations if s != ".text"}
        )
        self.data = {s: read_section_bytes(obj, s) for s in self.data_sections}

        # Every name at a code address, prefix stripped; the first is the one
        # references use. `_dav1d_f` and `f` collapse into one.
        self.names = {}
        for section, address, _, name in self.symbols:
            if section == ".text":
                names = self.names.setdefault(address, [])
                if plain_name(name) not in names:
                    names.append(plain_name(name))
        self.functions = {a: names[0] for a, names in self.names.items()}

        self.instruction_at = {a for a, _, _ in self.instructions}
        self.targets = set()

    def data_symbol(self, section, offset):
        """The data symbol containing `offset`, and how far into it."""
        best = None
        for s, address, size, name in self.symbols:
            if s == section and address <= offset < address + max(size, 1):
                if best is None or address > best[1]:
                    best = (name, address)
        if best is None:
            raise ValueError(f"no symbol covers {section}+{offset:#x}")
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
        else:
            # Data defined outside the assembly, such as a table in the C code.
            name, into = plain_name(target), addend
        if into == 0:
            return name
        return f"{name}+{into}" if into > 0 else f"{name}-{-into}"

    def table_entries(self, section):
        """offset -> (target label, table) for each PC-relative entry."""
        entries = {}
        for offset, (kind, target, addend) in self.relocations.get(section, {}).items():
            if kind != "R_AARCH64_PREL32" or target != ".text":
                raise ValueError(f"unhandled data relocation {kind} {target} at {offset:#x}")
            # `.word L - table` is emitted as PREL32 against L with the distance
            # from the table's start to this entry folded into the addend.
            table, into = self.data_symbol(section, offset)
            entries[offset] = (self.code_label(addend - into), table)
        return entries

    def rewrite(self, address, mnemonic, operands):
        relocation = self.relocations.get(".text", {}).get(address)
        if relocation:
            kind, target, addend = relocation
            if kind == "R_AARCH64_ADR_PREL_PG_HI21":
                operands = re.sub(r",\s*.*$", ", " + self.data_reference(target, addend), operands)
            elif kind == "R_AARCH64_ADD_ABS_LO12_NC":
                reference = self.data_reference(target, addend)
                operands = re.sub(r"#0x0$|#0$", ":lo12:" + reference, operands)
            elif kind in ("R_AARCH64_CALL26", "R_AARCH64_JUMP26"):
                # A call into another file keeps the callee's name.
                operands = plain_name(target)
            else:
                raise ValueError(f"unhandled text relocation {kind} at {address:#x}")
            return operands

        # `b.gt 0x28 <ipred_dc_128_8bpc_neon+0x28>` names its target by address.
        def label(m):
            return self.code_label(int(m.group(1), 16))

        return re.sub(r"(?:0x)?([0-9a-f]+) <[^>]+>", label, operands)

    def render(self):
        body = [(a, m, self.rewrite(a, m, o)) for a, m, o in self.instructions]
        data = {s: self.table_entries(s) for s in self.data_sections}

        lines = ["\t.text"]
        for address, mnemonic, operands in body:
            if address in self.names:
                lines.extend(f"{name}:" for name in self.names[address])
            elif address in self.targets:
                lines.append(f"L_{address:x}:")
            lines.append(f"{mnemonic}\t{operands}".rstrip())

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
                        # The object's size, so the checker can bound this symbol
                        # rather than only its section.
                        if name in sizes:
                            lines.append(f"\t.size {name}, {sizes[name]}")
                if offset in entries:
                    flush()
                    target, table = entries[offset]
                    lines.append(f"\t.word {target} - {table}")
                    offset += 4
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
            for relocations in self.relocations.values()
            for (_, target, _) in relocations.values()
            if target not in sections
        }
        return referenced - self.defined()


def merged(name, text, objects, rendered):
    """Append the listing of each rav1d object that defines functions `name`
    calls (itx16 calls itx's transforms, mc_dotprod tail-calls mc's put/prep)
    or data it reads (the const tables rav1d defines in Rust), so the checker
    sees one program. Names the appended listing shares with the host, and all
    its offset labels, get a file prefix, applied to the whole appended text,
    so each file's code keeps reaching its own data."""
    host = objects[name]
    appended = []
    for other, obj in objects.items():
        provided = {n for names in obj.names.values() for n in names}
        provided |= {plain_name(n) for s, _, _, n in obj.symbols if s != ".text"}
        needed = host.external_references() & provided
        if other == name or not needed:
            continue
        clashes = host.defined() & obj.defined()
        prefix = other.replace("-", "_") + "__"
        body = rendered[other]
        body = re.sub(r"\bL_([0-9a-f]+)\b", lambda m: f"L{prefix}{m.group(1)}", body)
        if clashes:
            pattern = re.compile(r"\b(" + "|".join(map(re.escape, sorted(clashes, key=len, reverse=True))) + r")\b")
            body = pattern.sub(lambda m: prefix + m.group(1), body)
        appended.append(f"// ---- {other}.S, for {', '.join(sorted(needed))}\n\t.text\n" + body)
    return text + "".join(appended)


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    source, output = sys.argv[1:]
    os.makedirs(output, exist_ok=True)
    objects = {}
    for entry in sorted(os.listdir(source)):
        if entry.endswith(".o"):
            # cc names intermediates `<hash>-<file>.o`.
            objects[entry[:-2].split("-", 1)[-1]] = Object(os.path.join(source, entry))
    rendered = {name: obj.render() for name, obj in objects.items()}
    for name, text in rendered.items():
        with open(os.path.join(output, name + ".S"), "w") as f:
            f.write(merged(name, text, objects, rendered))
        print(f"{name}.o -> {name}.S")


if __name__ == "__main__":
    main()
