"""Assemble the zstd and ISA-L sources and extract them into ../asm.

Usage: python3 build-asm.py <zstd checkout> <isa-l checkout> <scratch dir>

zstd ships one x86-64 file, huf_decompress_amd64.S (GNU, cpp-preprocessed).
ISA-L ships NASM for x86-64 (the `lsrc_x86_64` lists of each Makefile.am) and
GNU assembly for AArch64 (every `.S` under <component>/aarch64, which the
`-D__ASSEMBLY__` cpp pass expands). Each object is assembled for the Linux ELF
triple so extract-asm.py can resolve relocations, then extracted per
architecture. The x86-64 outputs are named `<source>-x86_64.S`.

Runtime dispatchers (`*multibinary*`) only pick an implementation from CPUID or
HWCAP and are not extracted.
"""

import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ASM = HERE.parent / "asm"
COMPONENTS = ["igzip", "crc", "mem", "raid", "erasure_code"]


def run(*args, cwd=None):
    result = subprocess.run(args, cwd=cwd, capture_output=True, text=True)
    if result.returncode != 0:
        raise RuntimeError(f"{' '.join(map(str, args))}\n{result.stderr}")
    return result.stdout


def x86_sources(isal, component):
    text = (isal / component / "Makefile.am").read_text()
    blocks = re.findall(r"lsrc_x86_64\s*\+?=((?:[^\n]*\\\n)*[^\n]*)", text)
    names = [n for block in blocks for n in re.findall(r"(\S+\.asm)", block)]
    return [isal / n for n in names if "multibinary" not in n]


def aarch64_sources(isal, component):
    return sorted(
        p for p in (isal / component / "aarch64").glob("*.S") if "multibinary" not in p.name
    )


def extract(objects, out):
    out.mkdir(parents=True, exist_ok=True)
    run("python3", HERE / "extract-asm.py", objects, out)


def main():
    zstd, isal, scratch = (Path(a).resolve() for a in sys.argv[1:4])
    shutil.rmtree(scratch, ignore_errors=True)
    failures = []

    x86_objects = scratch / "x86_64-obj"
    a64_objects = scratch / "aarch64-obj"
    x86_objects.mkdir(parents=True)
    a64_objects.mkdir(parents=True)

    run("clang", "--target=x86_64-unknown-linux-gnu", "-c",
        "-o", x86_objects / "huf_decompress_amd64.o",
        zstd / "lib/decompress/huf_decompress_amd64.S")

    includes = [f"-I{isal / d}/" for d in ["include", *COMPONENTS]]
    for component in COMPONENTS:
        for source in x86_sources(isal, component):
            try:
                run("nasm", "-f", "elf64", *includes, "-o",
                    x86_objects / (source.stem + ".o"), source)
            except RuntimeError as e:
                failures.append(str(e).splitlines()[0])
        for source in aarch64_sources(isal, component):
            try:
                run("clang", "--target=aarch64-unknown-linux-gnu", "-D__ASSEMBLY__", "-c",
                    f"-I{isal / 'include'}", f"-I{isal / component}", f"-I{source.parent}",
                    "-o", a64_objects / (source.stem + ".o"), source)
            except RuntimeError as e:
                failures.append(str(e).splitlines()[0])

    x86_out = scratch / "x86_64-asm"
    a64_out = scratch / "aarch64-asm"
    extract(x86_objects, x86_out)
    extract(a64_objects, a64_out)

    shutil.rmtree(ASM, ignore_errors=True)
    ASM.mkdir()
    for path in sorted(x86_out.glob("*.S")):
        name = path.stem if path.stem.endswith("amd64") else path.stem + "-x86_64"
        shutil.copy(path, ASM / (name + ".S"))
    for path in sorted(a64_out.glob("*.S")):
        shutil.copy(path, ASM / path.name)

    for failure in failures:
        print("failed:", failure, file=sys.stderr)
    print(f"{len(list(ASM.glob('*.S')))} files in {ASM}")


if __name__ == "__main__":
    main()
