"""Assemble OpenBLAS kernels and disassemble them into the .S files bums reads.

Usage:
    python3 extract-asm.py aarch64 <OpenBLAS checkout configured for ARMV8> asm/
    python3 extract-asm.py x86_64 <OpenBLAS checkout configured for x86-64> asm/

OpenBLAS kernels are written with cpp `#define`s and gas `.macro`s on top of
common_arm64.h, and the same source is built several times with different -D flags (the
real/double/complex/abs variants; see kernel/Makefile.L1). Rather than re-implementing
either macro layer, each variant is assembled exactly as the OpenBLAS build does it, and
the object is disassembled. The checkout needs a config.h, which
`make -f Makefile.prebuild TARGET=ARMV8 HOSTCC=cc CC=cc` produces (it errors out after
writing config.h, which is enough for the kernels used here). For x86-64 use a separate
checkout and `TARGET=NEHALEM BINARY=64 HOSTCC="cc -arch x86_64" CC="cc -arch x86_64"`
(getarch then runs under Rosetta), and change `OS_DARWIN` to `OS_LINUX` in its config.h
so the ELF flavour of the OpenBLAS macros matches the triple below.

The non-Darwin triples make LLVM print GNU syntax on AArch64 (and AT&T on x86-64), the
dialects bums parses. x86-64 files are named `<label>-x86_64.S`. The kernels
are leaf functions with no relocations, so the only rewrite is turning branch targets
(`0x6c <dsum_k+0x6c>`) into labels.
"""

import re
import subprocess
import sys
import tempfile
from pathlib import Path

LLVM = "/opt/homebrew/opt/llvm/bin/"
HEADER = re.compile(r"^([0-9a-f]+) <(.+)>:$")
INSN = re.compile(r"^\s+([0-9a-f]+):\s+(.*)$")
# zscal.S keeps four float constants in its code and loads them pc-relative; the words
# are dropped and each load becomes a move of an unknown float into the register.
LITERAL_LOAD = re.compile(r"^ldr\t(s[0-9]+), 0x[0-9a-f]+ <[^>]+>$")
BRANCH_TARGET = re.compile(r"0x[0-9a-f]+ <([^>+]+)(?:\+0x([0-9a-f]+))?>")

# label -> (kernel source under kernel/<arch>, -D flags), flags as in kernel/Makefile.L1/L2
AARCH64 = {
    "dsum_k": ("sum.S", ["DOUBLE"]),
    "dasum_k": ("asum.S", ["DOUBLE"]),
    "damax_k": ("amax.S", ["DOUBLE", "USE_ABS"]),
    "dmax_k": ("amax.S", ["DOUBLE"]),
    "idamax_k": ("iamax.S", ["DOUBLE", "USE_ABS"]),
    "ddot_k": ("dot.S", ["DOUBLE"]),
    "daxpy_k": ("axpy.S", ["DOUBLE"]),
    "dcopy_k": ("copy.S", ["DOUBLE"]),
    "dscal_k": ("scal.S", ["DOUBLE"]),
    "dswap_k": ("swap.S", ["DOUBLE"]),
    "drot_k": ("rot.S", ["DOUBLE"]),
    "dnrm2_k": ("nrm2.S", ["DOUBLE"]),
    "sdot_k": ("dot.S", []),
    "saxpy_k": ("axpy.S", []),
    "zdotu_k": ("zdot.S", ["DOUBLE", "COMPLEX"]),
    "zaxpy_k": ("zaxpy.S", ["DOUBLE", "COMPLEX"]),
    "zscal_k": ("zscal.S", ["DOUBLE", "COMPLEX"]),
    "zasum_k": ("zasum.S", ["DOUBLE", "COMPLEX"]),
    "dgemv_n": ("gemv_n.S", ["DOUBLE"]),
    "dgemv_t": ("gemv_t.S", ["DOUBLE", "TRANS"]),
    "dgemm_beta": ("dgemm_beta.S", ["DOUBLE"]),
    "dgemm_ncopy_4": ("dgemm_ncopy_4.S", ["DOUBLE"]),
    "dgemm_tcopy_4": ("dgemm_tcopy_4.S", ["DOUBLE"]),
}

# The kernels kernel/x86_64/KERNEL assigns to an SSE2-era core.
X86_64 = {
    "dasum_k": ("asum_sse2.S", ["DOUBLE"]),
    "damax_k": ("amax_sse2.S", ["DOUBLE", "USE_ABS"]),
    "dmax_k": ("amax_sse2.S", ["DOUBLE"]),
    "idamax_k": ("iamax_sse2.S", ["DOUBLE", "USE_ABS"]),
    "dnrm2_k": ("nrm2.S", ["DOUBLE"]),
    "zasum_k": ("zasum_sse2.S", ["DOUBLE", "COMPLEX"]),
    "ddot_k": ("dot_sse2.S", ["DOUBLE"]),
    "zdotu_k": ("zdot_sse2.S", ["DOUBLE", "COMPLEX"]),
    "dcopy_k": ("copy_sse2.S", ["DOUBLE"]),
    "drot_k": ("rot_sse2.S", ["DOUBLE"]),
    "daxpy_k": ("axpy_sse2.S", ["DOUBLE"]),
    "saxpy_k": ("axpy_sse.S", []),
    "zaxpy_k": ("zaxpy_sse2.S", ["DOUBLE", "COMPLEX"]),
    "dswap_k": ("swap_sse2.S", ["DOUBLE"]),
    "dscal_k": ("scal_sse2.S", ["DOUBLE"]),
    "dgemv_n": ("dgemv_n.S", ["DOUBLE"]),
    "dgemm_beta": ("gemm_beta.S", ["DOUBLE"]),
}

ARCHES = {
    "aarch64": ("aarch64-linux-gnu", "arm64", AARCH64, ""),
    "x86_64": ("x86_64-linux-gnu", "x86_64", X86_64, "-x86_64"),
}


def disassemble(triple, kdir, openblas, label, src, flags, tmp):
    obj = Path(tmp) / f"{label}.o"
    defines = [f"-D{f}" for f in flags] + [f"-D{n}={label}" for n in ("ASMNAME", "CNAME")]
    subprocess.run(
        ["clang", "-target", triple, "-c", "-w", *defines,
         "-I", openblas, f"{openblas}/kernel/{kdir}/{src}", "-o", obj],
        check=True,
    )
    dump = subprocess.run(
        [LLVM + "llvm-objdump", "-d", "-r", "--no-show-raw-insn", obj],
        check=True, capture_output=True, text=True,
    ).stdout
    if "R_AARCH64" in dump or "R_X86_64" in dump:
        raise SystemExit(f"{label}: has relocations, not handled")
    # Labels inside some kernels' gas macros are not .L-local, so they show up as symbols
    # of their own; a branch to one is a branch to that address in the same function.
    symbols = {m.group(2): int(m.group(1), 16) for m in map(HEADER.match, dump.splitlines()) if m}
    insns = [(int(m.group(1), 16), m.group(2)) for m in map(INSN.match, dump.splitlines()) if m]
    return symbols, insns


def rewrite(label, symbols, insns):
    targets = set()

    def repl(m):
        offset = symbols[m.group(1)] + int(m.group(2) or "0", 16)
        targets.add(offset)
        return f"{label}_{offset:x}" if offset else label

    body = []
    for addr, text in insns:
        text = re.split(r"\s(?://|#)\s", text)[0].strip()
        if ".word" in text:
            continue
        if m := LITERAL_LOAD.match(text):
            body.append((addr, f"fmov {m.group(1)}, wzr"))
            continue
        body.append((addr, BRANCH_TARGET.sub(repl, text).replace("\t", " ")))
    out = [f"{label}:"]
    for addr, text in body:
        if addr in targets and addr != 0:
            out.append(f"{label}_{addr:x}:")
        out.append(text)
    return out


def main():
    arch, openblas, out_dir = sys.argv[1], sys.argv[2], Path(sys.argv[3])
    triple, kdir, kernels, suffix = ARCHES[arch]
    out_dir.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory() as tmp:
        for label, (src, flags) in kernels.items():
            lines = rewrite(label, *disassemble(triple, kdir, openblas, label, src, flags, tmp))
            (out_dir / f"{label}{suffix}.S").write_text("\n".join(lines) + "\n")
            print(f"{label}: {len(lines)} lines from {src} {' '.join(flags)}")


if __name__ == "__main__":
    main()
