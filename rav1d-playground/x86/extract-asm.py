"""Turn a dav1d x86 NASM file into AT&T assembly that bums can analyse.

Usage:
    python3 extract-asm.py SOURCE.asm CONFIG_DIR INCLUDE_DIR OUTPUT.S [function ...]

The AArch64 sources are GNU assembly, which bums reads after preprocessing. dav1d's x86
sources are NASM built on x86inc.asm macros, so this assembles them (ELF, so relocations
carry explicit addends) and reads the result back with llvm-objdump:

  - Read-only data (.rodata) is emitted byte for byte under a `bums_rodata` label, with the
    data symbols NASM keeps as labels at their offsets, so rip-relative loads of constants
    are checked against the data that is really there.
  - Rip-relative operands are rewritten against that label using their PC32 relocations.
  - Local branch targets keep NASM's names (`dav1d_pal_idx_finish_ssse3.w4`).
  - A jump through a JMP_TABLE (`movslq (%base,%idx,4)`, `add %base`, `jmp *`) becomes
    `bums.jump_table %idx, i:label, ...`, with the entries read from the JMP_TABLE lines of
    the source. The table read and the add are dropped: the pseudo-instruction stands for
    them, and rejects an index the table does not cover.

Only the named functions are kept (all global functions if none are named).
"""

import os
import re
import subprocess
import sys
from pathlib import Path

OBJDUMP = os.environ.get("LLVM_OBJDUMP", "llvm-objdump")

INSN = re.compile(r"^\s*([0-9a-f]+):\s+(.*)$")
HEADER = re.compile(r"^([0-9a-f]+) <(.+)>:$")
RELOC = re.compile(r"^\s*([0-9a-f]+):\s+(R_X86_64_\w+)\s+(\S+)$")
TARGET = re.compile(r"0x[0-9a-f]+ <([^>+]+)(?:\+0x([0-9a-f]+))?>")


def run(*args):
    return subprocess.run(args, check=True, capture_output=True, text=True).stdout


def jump_tables(source):
    """table symbol -> list of (index, label suffix), from the JMP_TABLE macro and its uses."""
    text = Path(source).read_text()
    skip = re.search(r"%xdefine %1_table \(%%table - (\d+)\*4\)", text)
    first = int(skip.group(1)) if skip else 0
    tables = {}
    for m in re.finditer(r"^JMP_TABLE\s+(\w+),\s*(.+)$", text, re.M):
        name, widths = m.group(1), [w.strip() for w in m.group(2).split(",")]
        tables[name] = [(first + i, f".w{w}") for i, w in enumerate(widths)]
    return tables


def symbols(obj):
    """(section, address, name) for every symbol."""
    out = []
    for line in run(OBJDUMP, "-t", obj).splitlines():
        parts = line.split()
        if len(parts) >= 5 and re.fullmatch(r"[0-9a-f]{16}", parts[0]):
            out.append((parts[-3], int(parts[0], 16), parts[-1]))
    return out


def rodata(obj):
    """The bytes of .rodata, in order."""
    data = bytearray()
    for line in run(OBJDUMP, "-s", "-j", ".rodata", obj).splitlines():
        m = re.match(r"^\s*([0-9a-f]{4,}) ((?:[0-9a-f]{2,8} ){1,4})", line + " ")
        if m:
            data += bytes.fromhex("".join(m.group(2).split()))
    return data


def disassemble(obj):
    """function -> list of [address, text, relocation or None]"""
    funcs, current = {}, None
    dump = run(OBJDUMP, "-d", "-r", "--no-show-raw-insn", "--x86-asm-syntax=att", obj)
    for line in dump.splitlines():
        if m := HEADER.match(line):
            current = m.group(2)
            funcs[current] = []
        elif current is None:
            continue
        elif m := RELOC.match(line):
            funcs[current][-1][2] = (int(m.group(1), 16), m.group(2), m.group(3))
        elif m := INSN.match(line):
            funcs[current].append([int(m.group(1), 16), m.group(2).split("#")[0].strip(), None])
    return funcs


def rip_target(reloc, next_address):
    """The .rodata offset a rip-relative operand names, from its PC32 relocation."""
    place, kind, expr = reloc
    if kind != "R_X86_64_PC32" or not expr.startswith(".rodata"):
        raise SystemExit(f"unhandled relocation {kind} {expr}")
    addend = int(expr[len(".rodata"):].replace("+", "") or "0", 16) if "+" in expr or "-" in expr else 0
    if "-" in expr:
        addend = -int(expr.split("-")[1], 16)
    # S + A - P is stored; the operand is next_address + that.
    return addend + (next_address - place)


def main():
    source, config_dir, include_dir, output = sys.argv[1:5]
    wanted = set(sys.argv[5:])
    obj = str(Path(output).with_suffix(".o"))
    subprocess.run(
        ["nasm", "-f", "elf64", f"-I{config_dir}/", f"-I{include_dir}/", source, "-o", obj],
        check=True,
    )

    tables = jump_tables(source)
    syms = symbols(obj)
    data = rodata(obj)
    funcs = disassemble(obj)

    # Group local labels (`func.w4`) under the function they belong to.
    globals_ = [name for name in funcs if "." not in name]
    if wanted:
        globals_ = [g for g in globals_ if g in wanted]

    out = ["/* Extracted from " + Path(source).name + " by extract-asm.py; do not edit. */", ""]
    out.append(".p2align 6")
    out.append("bums_rodata:")
    data_labels = {}
    for section, addr, name in syms:
        if section == ".rodata" and name != ".rodata":
            data_labels.setdefault(addr, []).append(name.replace("..@", "bums_local_").replace(".", "_"))
    # Break the bytes at every label, sixteen to a line between them.
    cuts = sorted(set(range(0, len(data), 16)) | {a for a in data_labels if a < len(data)})
    for start, end in zip(cuts, cuts[1:] + [len(data)]):
        for label in data_labels.get(start, []):
            out.append(f"{label}:")
        out.append(".byte " + ",".join(str(b) for b in data[start:end]))
    out.append("")

    for name in globals_:
        parts = [n for n in funcs if n == name or n.startswith(name + ".")]
        body = sorted((addr, text, reloc, owner) for owner in parts for addr, text, reloc in funcs[owner])
        starts = {funcs[p][0][0]: p for p in parts if funcs[p]}
        table = next((t for t in tables if name.endswith(t)), None)
        lines = []
        for i, (addr, text, reloc, owner) in enumerate(body):
            if addr in starts:
                lines.append(f"{starts[addr]}:")
            next_address = body[i + 1][0] if i + 1 < len(body) else addr + 16
            if reloc:
                offset = rip_target(reloc, next_address)
                text = re.sub(r"\S*\(%rip\)", f"bums_rodata+{offset}(%rip)", text)
            text = TARGET.sub(lambda m: m.group(1) + (f"+0x{m.group(2)}" if m.group(2) else ""), text)
            lines.append(text)
        # The jump-table idiom, rewritten as one pseudo-instruction.
        if table:
            entries = ", ".join(f"{i}:{name}{suffix}" for i, suffix in tables[table])
            rewritten = []
            k = 0
            while k < len(lines):
                line = lines[k]
                m = re.fullmatch(r"movslq\s+\((%\w+),(%\w+),4\),\s*(%\w+)", line)
                if m and m.group(2) == m.group(3):
                    base, idx = m.group(1), m.group(3)
                    tail = lines[k + 1 :]
                    add = next(j for j, l in enumerate(tail) if re.fullmatch(rf"addq\s+{base},\s*{idx}", l))
                    jump = next(j for j, l in enumerate(tail) if re.fullmatch(rf"jmpq?\s+\*{idx}", l))
                    rewritten += [l for j, l in enumerate(tail[:jump]) if j != add]
                    rewritten.append(f"bums.jump_table {idx}, {entries}")
                    k += 2 + jump
                    continue
                rewritten.append(line)
                k += 1
            lines = rewritten
        out += lines + [""]

    Path(output).write_text("\n".join(out) + "\n")


if __name__ == "__main__":
    main()
