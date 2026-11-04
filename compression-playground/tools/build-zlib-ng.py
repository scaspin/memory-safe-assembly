"""Compile zlib-ng's SIMD kernels and extract them into ../asm as zng_*.S.

Usage: python3 build-zlib-ng.py <zlib-ng checkout> <scratch dir>

zlib-ng has no hand-written assembly: its hot paths are C intrinsics under
arch/x86 and arch/arm, selected at run time by functable.c. Each kernel file is
compiled here with the ISA flags its arch Makefile.in uses and every feature
macro defined, for the Linux ELF triple so extract-asm.py can resolve
relocations, then extracted per architecture. The checked code is therefore
clang's output for these sources, not a shipped binary.

zlib-ng's build system is not run. The three generated headers are rendered
from their .in templates with an empty symbol prefix, and the C library
headers come from the macOS SDK (the kernels only use stdint/stddef/string
declarations, which match on LP64 Linux). CPU detection (x86_features.c,
arm_features.c) and the 32-bit ARMv6 kernel are skipped. The generic C CRC
routines the kernels fall back to (crc32_braid_c.c, crc32_chorba_c.c) are
compiled beside them so extract-asm.py appends them to their callers.

Outputs are named zng_<source>-x86_64.S and zng_<source>.S so they sit beside
the ISA-L and zstd files without colliding.
"""

import shutil
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ASM = HERE.parent / "asm"
TEMPLATES = ["zconf-ng.h", "zlib-ng.h", "zlib_name_mangling-ng.h"]
COMMON = ["-O2", "-DNDEBUG", "-U_FORTIFY_SOURCE", "-D_FORTIFY_SOURCE=0", "-fno-stack-protector", "-fno-asynchronous-unwind-tables",
          "-DHAVE_BUILTIN_CTZ", "-DHAVE_BUILTIN_CTZLL", "-DHAVE_ATTRIBUTE_ALIGNED",
          "-DHAVE_BUILTIN_ASSUME_ALIGNED", "-DWITH_GZFILEOP"]
X86_FEATURES = ["-DX86_FEATURES", "-DX86_SSE2", "-DX86_SSSE3", "-DX86_SSE41", "-DX86_SSE42",
                "-DX86_PCLMULQDQ_CRC", "-DX86_VPCLMULQDQ_CRC", "-DX86_AVX2", "-DX86_AVX512",
                "-DX86_AVX512VNNI"]
X86_FLAGS = {
    "avx512_vnni": ["-mavx512f", "-mavx512dq", "-mavx512vl", "-mavx512bw", "-mbmi2", "-mavx512vnni"],
    "avx512": ["-mavx512f", "-mavx512dq", "-mavx512vl", "-mavx512bw", "-mbmi2"],
    "vpclmulqdq": ["-mpclmul", "-mvpclmulqdq", "-mavx512f", "-mavx512dq", "-mavx512vl",
                   "-mavx512bw", "-mbmi2"],
    "pclmulqdq": ["-mpclmul", "-msse4.2"],
    "avx2": ["-mavx2", "-mbmi2"],
    "sse42": ["-msse4.2"],
    "sse41": ["-msse4.1"],
    "ssse3": ["-mssse3"],
    "sse2": ["-msse2"],
}
ARM_FEATURES = ["-DARM_FEATURES", "-DARM_NEON", "-DARM_NEON_HASLD4", "-DARM_CRC32", "-D__arm64__",
                "-march=armv8-a+crc"]
SKIPPED = {"x86_features.c", "arm_features.c", "slide_hash_armv6.c"}
CALLEES = ["crc32_braid_c.c", "crc32_chorba_c.c"]


def run(*args):
    result = subprocess.run([str(a) for a in args], capture_output=True, text=True)
    if result.returncode != 0:
        raise RuntimeError(f"{' '.join(map(str, args))}\n{result.stderr}")
    return result.stdout


def render_headers(zng, include):
    include.mkdir(parents=True)
    for name in TEMPLATES:
        text = (zng / (name + ".in")).read_text().replace("@ZLIB_SYMBOL_PREFIX@", "")
        (include / name).write_text(text)


def x86_flags(source):
    return next(flags for key, flags in X86_FLAGS.items() if key in source.stem)


def compile_all(zng, include, scratch):
    sdk = run("xcrun", "--show-sdk-path").strip()
    resource = run("clang", "-print-resource-dir").strip()
    headers = ["-nostdinc", "-isystem", f"{resource}/include", "-isystem", f"{sdk}/usr/include",
               f"-I{include}", f"-I{zng}"]
    failures = []
    jobs = [("x86_64", "x86_64-unknown-linux-gnu", zng / "arch/x86", X86_FEATURES),
            ("aarch64", "aarch64-unknown-linux-gnu", zng / "arch/arm", ARM_FEATURES)]
    for arch, triple, directory, features in jobs:
        objects = scratch / f"{arch}-obj"
        objects.mkdir(parents=True)
        callees = [zng / "arch/generic" / name for name in CALLEES]
        for source in [*sorted(directory.glob("*.c")), *callees]:
            if source.name in SKIPPED:
                continue
            isa = x86_flags(source) if arch == "x86_64" and source not in callees else []
            try:
                run("clang", f"--target={triple}", "-c", *COMMON, *features, *isa, *headers,
                    "-I", directory, "-o", objects / (source.stem + ".o"), source)
            except RuntimeError as e:
                failures.append(str(e).splitlines()[-1] if str(e).splitlines() else str(e))
    return failures


def main():
    zng, scratch = (Path(a).resolve() for a in sys.argv[1:3])
    shutil.rmtree(scratch, ignore_errors=True)
    include = scratch / "include"
    render_headers(zng, include)
    failures = compile_all(zng, include, scratch)
    written = 0
    for arch in ["x86_64", "aarch64"]:
        out = scratch / f"{arch}-asm"
        out.mkdir()
        run("python3", HERE / "extract-asm.py", scratch / f"{arch}-obj", out)
        for path in sorted(out.glob("*.S")):
            if path.stem + ".c" in CALLEES:
                continue
            suffix = "-x86_64" if arch == "x86_64" else ""
            shutil.copy(path, ASM / f"zng_{path.stem}{suffix}.S")
            written += 1
    for failure in failures:
        print("failed:", failure, file=sys.stderr)
    print(f"{written} zlib-ng files in {ASM}")


if __name__ == "__main__":
    main()
