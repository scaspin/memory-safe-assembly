"""Extract candle-core functions that contain inlined asm! into per-function .S files.

Usage:
    for o in *.o; do
        llvm-objdump -d -r --no-show-raw-insn --triple=aarch64-unknown-linux-gnu \
            --mattr=+dotprod,+fullfp16 "$o"
    done > dump.txt
    python3 extract-asm.py dump.txt asm/

The objects come from `ar x libcandle_core-*.rlib` of a release build. The non-Darwin
triple makes LLVM print GNU syntax (`fadd v2.8h, v0.8h, v1.8h`), the dialect bums parses
(see rav1d-playground/src/edited-ipred.S); a Darwin triple gives Apple's dotted syntax
(`fadd.8h v2, v0, v1`), which bums does not understand. `+fullfp16` is needed or fp16 ops
print as `<unknown>`.

Branch targets inside the function get a real label (`<label>_<hex offset>`), since bums
only resolves `label+offset` for conditional branches.

The objects are unlinked, so relocated operands are rewritten using the `-r` records:
  - `bl` to a `core::panicking` function becomes `brk #0x1`: those functions diverge, so
    the path ends there. It must not become `ret` - a panic block is reached after the
    prologue and never runs the epilogue, so a `ret` there looks like a function
    returning with the stack pointer 16 bytes low.
  - `adrp`+`ldr` from an LLVM constant pool (`lCPI*`) becomes `mov`+`movi`: the loaded
    vector is plain data, and bums has no model for pool memory.
  - any other `adrp` becomes `adrp xN, <sym>@PAGE`.
"""

import re
import sys
from pathlib import Path

HEADER = re.compile(r"^([0-9a-f]+) <(.+)>:$")
INSN = re.compile(r"^\s+([0-9a-f]+):\s+(.*)$")
RELOC = re.compile(r"^\s+[0-9a-f]+:\s+ARM64_RELOC_(\w+)\s+(\S+)$")
BRANCH_TARGET = re.compile(r"0x[0-9a-f]+ <([^>+]+)(?:\+0x([0-9a-f]+))?>")

# label used in the .S / Rust fn name  ->  substring of the mangled symbol
CANDIDATES = {
    "candle_vec_add_f16": "candle_core3cpu11vec_add_f16",
    "candle_vec_dot_f16": "candle_core3cpu11vec_dot_f16",
    "candle_f16_vec_reduce": "CurrentCpuF16$u20$as$u20$candle_core..cpu..CpuF16$GT$10vec_reduce",
    "candle_f16_vecops_vec_add": "f16$u20$as$u20$candle_core..cpu..kernels..VecOps$GT$7vec_add",
    "candle_f16_vec_dot": "binary16..f16$u20$as$u20$candle_core..quantized..k_quants..GgmlType$GT$7vec_dot17",
    "candle_q4_0_vec_dot": "BlockQ4_0$u20$as$u20$candle_core..quantized..k_quants..GgmlType$GT$7vec_dot17",
    "candle_q8_0_vec_dot": "BlockQ8_0$u20$as$u20$candle_core..quantized..k_quants..GgmlType$GT$7vec_dot17",
    "candle_q2k_vec_dot": "BlockQ2K$u20$as$u20$candle_core..quantized..k_quants..GgmlType$GT$7vec_dot17",
    "candle_q3k_vec_dot": "BlockQ3K$u20$as$u20$candle_core..quantized..k_quants..GgmlType$GT$7vec_dot17",
    "candle_q4k_vec_dot": "BlockQ4K$u20$as$u20$candle_core..quantized..k_quants..GgmlType$GT$7vec_dot17",
    "candle_q5k_vec_dot": "BlockQ5K$u20$as$u20$candle_core..quantized..k_quants..GgmlType$GT$7vec_dot17",
    "candle_q6k_vec_dot": "BlockQ6K$u20$as$u20$candle_core..quantized..k_quants..GgmlType$GT$7vec_dot17",
    "candle_q8k_vec_dot": "BlockQ8K$u20$as$u20$candle_core..quantized..k_quants..GgmlType$GT$7vec_dot17",
    "candle_q4k_vec_dot_4": "BlockQ4K$u20$as$u20$candle_core..quantized..k_quants..GgmlType$GT$9vec_dot_4",
    "candle_q6k_vec_dot_4": "BlockQ6K$u20$as$u20$candle_core..quantized..k_quants..GgmlType$GT$9vec_dot_4",
}


def parse(path):
    """symbol -> (start address, list of [address, instruction text, relocation or None])"""
    funcs, cur = {}, None
    for line in Path(path).read_text().splitlines():
        if m := HEADER.match(line):
            cur = m.group(2)
            funcs[cur] = (int(m.group(1), 16), [])
        elif not cur:
            continue
        elif m := RELOC.match(line):
            if funcs[cur][1]:
                funcs[cur][1][-1][2] = (m.group(1), m.group(2))
        elif m := INSN.match(line):
            funcs[cur][1].append([int(m.group(1), 16), m.group(2), None])
    return funcs


def sanitize(symbol):
    return re.sub(r"[^A-Za-z0-9_]", "_", symbol)


def rewrite(symbol, label, start, insns):
    targets, notes = set(), []

    def repl(m):
        target, offset = m.group(1), int(m.group(2) or "0", 16)
        if target != symbol:
            notes.append(f"branch to other symbol {target}")
            return sanitize(target) + (f"+{offset:#x}" if offset else "")
        targets.add(offset)
        return f"{label}_{offset:x}"

    body = []
    for addr, insn, reloc in insns:
        offset = addr - start
        insn = insn.split(";")[0].rstrip()
        fields = insn.split("\t")
        opcode, operands = fields[0], fields[1] if len(fields) > 1 else ""
        reg = operands.split(",")[0].strip()

        if reloc and reloc[0] == "BRANCH26" and opcode == "bl":
            if "panicking" in reloc[1]:
                body.append((offset, "brk #0x1"))
                notes.append(f"panic call -> brk ({reloc[1]})")
            else:
                body.append((offset, f"bl {sanitize(reloc[1])}"))
                notes.append(f"UNRESOLVED CALL {reloc[1]}")
            continue
        if reloc and reloc[0] == "PAGE21" and opcode == "adrp":
            if reloc[1].startswith("lCPI"):
                body.append((offset, f"mov {reg}, #0x0"))
            else:
                body.append((offset, f"adrp {reg}, {sanitize(reloc[1])}@PAGE"))
            continue
        if reloc and reloc[0] == "PAGEOFF12" and reloc[1].startswith("lCPI") and opcode == "ldr":
            width = {"q": "movi v{}.16b, #0x0", "d": "movi d{}, #0000000000000000"}
            if reg[0] not in width:
                raise SystemExit(f"{label}: unhandled constant-pool load {insn}")
            body.append((offset, width[reg[0]].format(reg[1:])))
            notes.append(f"constant-pool load -> movi ({reloc[1]})")
            continue
        if reloc:
            notes.append(f"relocation left as-is: {reloc[0]} {reloc[1]} on `{insn}`")
        body.append((offset, BRANCH_TARGET.sub(repl, insn).replace("\t", " ")))

    out = [f"{label}:"]
    for offset, text in body:
        if offset in targets and offset != 0:
            out.append(f"{label}_{offset:x}:")
        out.append(text)
    # a branch to offset 0 re-enters at the function label
    out = [l.replace(f"{label}_0", label) if l != f"{label}_0:" else l for l in out]
    return out, notes


def main():
    dump, out_dir = sys.argv[1], Path(sys.argv[2])
    out_dir.mkdir(parents=True, exist_ok=True)
    funcs = parse(dump)
    for label, needle in CANDIDATES.items():
        matches = [s for s in funcs if needle in s]
        if len(matches) != 1:
            print(f"{label}: {len(matches)} symbol matches, skipping")
            continue
        start, insns = funcs[matches[0]]
        lines, notes = rewrite(matches[0], label, start, insns)
        (out_dir / f"{label}.S").write_text("\n".join(lines) + "\n")
        print(f"{label}: {len(insns)} insns")
        for note in sorted(set(notes)):
            print(f"    {note}")


if __name__ == "__main__":
    main()
