"""Render corecrypto's arm64 assembly into the `.S` form the checker reads.

corecrypto's sources are written for Apple's assembler: Darwin-style `.macro`s
with `$0` arguments, numeric local labels and `.rept` blocks, none of which the
checker parses. Each arm64 file is

1. preprocessed for arm64 Darwin, with corecrypto's own include directories;
2. assembled and printed back by `llvm-mc -filetype=asm`, which expands every
   macro and repetition, names every label, and prints the generic (GNU)
   instruction syntax;
3. rewritten so that every address is an `adrp sym@PAGE` the checker resolves:
   GOT loads become `adrp`/`add`, and a `@PAGEOFF` folded into a memory operand
   is dropped, since the checker's `adrp` already yields the whole address;
4. given the data of the C tables it addresses (`ccmlkem_zetas`, the SHA-512
   round constants), so that reads from them land in a declared region.

corecrypto's license forbids redistribution, so the output is written to a
directory that git ignores rather than committed.

Usage: python3 import-corecrypto.py [<corecrypto clone> [<output dir>]]
The defaults are the pinned `corecrypto` submodule and `asm/`.
Set LLVM_BIN to the directory holding LLVM's `clang` and `llvm-mc` (default:
Homebrew's).
"""

import os
import re
import subprocess
import sys
from pathlib import Path

LLVM_BIN = Path(os.environ.get("LLVM_BIN", "/opt/homebrew/opt/llvm/bin"))
TRIPLE = "arm64-apple-macos13"
FEATURES = "+crypto,+sha3,+sha2,+aes,+fullfp16,+dotprod"

# Fragments `#include`d by other files rather than assembled on their own.
FRAGMENTS = {"ccn_mul_256-arm64.s", "aes_cbc.s"}

# Tables defined in C that the assembly addresses: symbol -> (source, directive).
C_TABLES = {
    "_ccmlkem_zetas": ("ccmlkem/src/ccmlkem_ntt.c", ".long"),
    "_ccsha512_K": ("ccsha2/src/ccsha512_K.c", ".quad"),
    "_sha512_K": ("acceleratecrypto/Source/sha512/sha512_K.c", ".quad"),
}


def sdk_path():
    return subprocess.run(
        ["xcrun", "--show-sdk-path"], check=True, capture_output=True, text=True
    ).stdout.strip()


def preprocess(clone, source):
    includes = [
        "cc",
        "cc/corecrypto",
        "acceleratecrypto/Include",
        "ccaes/src/arm",
        "ccn/src/arm",
    ]
    command = [
        str(LLVM_BIN / "clang"),
        "-E",
        "-P",
        "-x",
        "assembler-with-cpp",
        "-target",
        TRIPLE,
        "-isysroot",
        sdk_path(),
        # The ISA compatibility headers only pick the `vN.16b` crypto
        # mnemonics for Apple's clang; without this they emit `qN` forms.
        "-D__apple_build_version__=17000000",
        f"-I{source.parent}",
        *(f"-I{clone / d}" for d in includes),
        str(source),
    ]
    return subprocess.run(command, check=True, capture_output=True, text=True).stdout


def expand(text):
    command = [
        str(LLVM_BIN / "llvm-mc"),
        f"-triple={TRIPLE}",
        f"-mattr={FEATURES}",
        "--output-asm-variant=0",
        "-filetype=asm",
        "-",
    ]
    return subprocess.run(
        command, input=text, check=True, capture_output=True, text=True
    ).stdout


def c_table(clone, symbol):
    source, directive = C_TABLES[symbol]
    text = (clone / source).read_text()
    name = symbol.lstrip("_")
    body = re.search(rf"\b{name}\s*\[[^\]]*\][^=]*=\s*\{{(.*?)\}};", text, re.S)
    if body is None:
        sys.exit(f"cannot find the initializer of {name} in {source}")
    items = re.findall(r"0x[0-9a-fA-F]+|\d+", re.sub(r"/\*.*?\*/|//[^\n]*", "", body.group(1)))
    lines = ["\t.section\t__TEXT,__const", "\t.align\t4", f"{symbol}:"]
    for start in range(0, len(items), 4):
        lines.append(f"\t{directive}\t" + ", ".join(items[start : start + 4]))
    return lines


def rewrite(text, clone):
    lines = []
    for line in text.splitlines():
        line = re.sub(r"\s*;.*$", "", line)
        if not line.strip():
            continue
        lines.append(line)

    # Labels the parser cannot read (`L$bswap_mask`,
    # `l___const.cckeccak_f1600_c.keccak_round_constants`) get plain names.
    renames = {}
    for line in lines:
        m = re.match(r"^([^\s:]+):$", line)
        if m and re.search(r"[^A-Za-z0-9_]", m.group(1)):
            renames[m.group(1)] = re.sub(r"[^A-Za-z0-9_]", "_", m.group(1))

    def rename(line):
        for old, new in renames.items():
            line = line.replace(old, new)
        return line

    out = []
    for line in map(rename, lines):
        # A GOT load of a symbol's address is the address itself.
        line = re.sub(r"@GOTPAGE\b", "@PAGE", line)
        m = re.match(r"^\s*ldr\s+(x\d+),\s*\[(x\d+),\s*(\S+)@GOTPAGEOFF\]$", line)
        if m:
            line = f"\tadd\t{m.group(1)}, {m.group(2)}, {m.group(3)}@PAGEOFF"
        # `[xN, sym@PAGEOFF]`: the `adrp` that set xN already holds the address.
        line = re.sub(r"\[(x\d+),\s*[^\]\s]+@PAGEOFF\]", r"[\1]", line)
        line = re.sub(r"^(\s*)\.p2align\b", r"\1.align", line)
        out.append(line)

    defined = {m.group(1) for line in out if (m := re.match(r"^([^\s:]+):$", line))}
    for symbol in sorted(C_TABLES):
        if symbol not in defined and any(f"{symbol}@PAGE" in line for line in out):
            out.extend(c_table(clone, symbol))
    return "\n".join(out) + "\n"


def main():
    here = Path(__file__).resolve().parent
    clone = Path(sys.argv[1]).resolve() if len(sys.argv) > 1 else here / "corecrypto"
    output = Path(sys.argv[2]) if len(sys.argv) > 2 else here / "asm"
    sources = sorted(
        p
        for p in clone.rglob("*")
        if p.suffix in (".s", ".S") and "arm" in p.parts[-2] and p.name not in FRAGMENTS
    )
    for source in sources:
        preprocessed = preprocess(clone, source)
        # Files guarded for other architectures preprocess to nothing.
        if not re.search(r"^\s*[a-z]", preprocessed, re.M):
            continue
        component = source.relative_to(clone).parts[0]
        target = output / "aarch64" / component / (source.stem + ".S")
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(rewrite(expand(preprocessed), clone))
        print(target)


if __name__ == "__main__":
    main()
