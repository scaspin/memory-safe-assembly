"""Generate the annotations for ISA-L's regular kernel families.

Usage: python3 gen-annotations.py <isa-l checkout> <entries.tsv>

entries.tsv lists `arch<TAB>object<TAB>function` for every global function the
extracted objects define (build-asm.py's objects, read with objdump -t). The
families written here share one C signature each, so their preconditions are
the API contract in include/*.h, instantiated per kernel:

- crc.rs: crc16/crc32/crc64 over `buf[..len]` (the iSCSI order takes `buf,
  len, crc`), and crc16_t10dif_copy, which also writes `dst[..len]`.
- mem.rs: mem_zero_detect over `mem[..len]`.
- raid.rs: xor/pq gen and check over `vects` rows of `len` bytes.
- erasure_code.rs: dot_prod, mad and mul over 32-byte-per-coefficient tables.

The minimum lengths come from the `Must be >= N` / `aligned to N` notes in
erasure_code.h and gf_vect_mul.h where a kernel has one, and otherwise from
the kernel's vector width (sse/avx/neon/sve 16, avx2 32, avx512 64).
"""

import re
import sys
from pathlib import Path

OUT = Path(__file__).resolve().parent.parent / "src"
LEN_MAX = "2147483647"
LONG_MAX = "1099511627776"


def asm_file(arch, obj):
    return f"{obj}-x86_64.S" if arch == "x86_64" else f"{obj}.S"


def attribute(arch, file, args, conditions):
    target = "x86_64" if arch == "x86_64" else "aarch64"
    lines = ",\n     ".join(conditions)
    return (f'#[cfg_attr(target_arch = "{target}", bums::check_mem_safe("{file}", {args},\n'
            f"    [{lines}]))]")


def documented_minimums(isal):
    minimums = {}
    for header in ["erasure_code.h", "gf_vect_mul.h"]:
        text = (isal / "include" / header).read_text()
        for comment, name in re.findall(r"/\*\*(.*?)\*/\s*\n\s*\w[\w\s\*]*?\n?(\w+)\s*\(", text, re.S):
            m = re.search(r"@param len[^\n]*(?:Must be >= (\d+)|aligned to (\d+)B)", comment)
            if m:
                minimums[name] = (int(m.group(1) or 0), int(m.group(2) or 1))
    return minimums


def width_minimum(name):
    if "avx512" in name:
        return 64
    if "avx2" in name:
        return 32
    return 16


def crc(arch, obj, name):
    file = asm_file(arch, obj)
    seed = {"crc16": "u16", "crc32": "u32", "crc64": "u64"}[name[:5]]
    if name.startswith("crc16_t10dif_copy"):
        return (attribute(arch, file, "seed, dst.as_mut_ptr(), src.as_ptr(), len",
                          ["dst.len() == len", "src.len() == len", f"len <= {LONG_MAX}"])
                + f"\nfn {name}(seed: u16, dst: &mut [u8], src: &[u8], len: usize) -> u16;\n")
    if (name.startswith("crc32_iscsi") or name.startswith("crc32c_")) and not name.endswith("_internal"):
        return (attribute(arch, file, "buf.as_ptr(), len, seed",
                          ["buf.len() == len", f"len <= {LEN_MAX}"])
                + f"\nfn {name}(buf: &[u8], len: usize, seed: u32) -> u32;\n")
    return (attribute(arch, file, "seed, buf.as_ptr(), len",
                      ["buf.len() == len", f"len <= {LONG_MAX}"])
            + f"\nfn {name}(seed: {seed}, buf: &[u8], len: usize) -> {seed};\n")


def mem(arch, obj, name):
    return (attribute(arch, asm_file(arch, obj), "mem.as_ptr(), len",
                      ["mem.len() == len", f"len <= {LONG_MAX}"])
            + f"\nfn {name}(mem: &[u8], len: usize) -> i32;\n")


def raid(arch, obj, name):
    least = {"xor_gen": 3, "xor_check": 2, "pq_gen": 4, "pq_check": 4}[re.sub(r"_(sse|avx\w*|neon)$", "", name)]
    conditions = [f"array == [&mut [u8; len]; vects]", f"vects >= {least}", "vects <= 256",
                  f"len <= {LEN_MAX}"]
    if name.startswith("pq_gen"):
        conditions.append("len % 32 == 0")
    elif name.startswith("pq_check"):
        conditions.append("len % 16 == 0")
    return (attribute(arch, asm_file(arch, obj), "vects, len, array.as_ptr()", conditions)
            + f"\nfn {name}(vects: usize, len: usize, array: &[&mut [u8]]) -> i32;\n")


def erasure(arch, obj, name, minimums):
    file = asm_file(arch, obj)
    least, align = minimums.get(name, (width_minimum(name), 1))
    lengths = [f"len >= {least}", f"len <= {LEN_MAX}"] + ([f"len % {align} == 0"] if align > 1 else [])
    m = re.match(r"gf_(\d)?vect_(dot_prod|mad|mul)_", name)
    dests = int(m.group(1) or 1)
    kind = m.group(2)
    if kind == "mul":
        lengths = [f"len >= {least}", f"len <= {LEN_MAX}", "len % 32 == 0"]
        return (attribute(arch, file, "len, gftbl.as_ptr(), src.as_ptr(), dest.as_mut_ptr()",
                          ["gftbl.len() == 32", "src.len() == len", "dest.len() == len"] + lengths)
                + f"\nfn {name}(len: usize, gftbl: &[u8], src: &[u8], dest: &mut [u8]) -> i32;\n")
    if kind == "dot_prod":
        dest_condition = "dest.len() == len" if dests == 1 else f"dest == [&mut [u8; len]; {dests}]"
        dest_type = "&mut [u8]" if dests == 1 else "&[&mut [u8]]"
        dest_arg = "dest.as_mut_ptr()" if dests == 1 else "dest.as_ptr()"
        return (attribute(arch, file, f"len, vlen, gftbls.as_ptr(), src.as_ptr(), {dest_arg}",
                          [f"gftbls.len() == 32 * vlen * {dests}", "src == [&[u8; len]; vlen]", dest_condition,
                           "vlen >= 1", "vlen <= 255"] + lengths)
                + f"\nfn {name}(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: {dest_type});\n")
    dest_condition = "dest.len() == len" if dests == 1 else f"dest == [&mut [u8; len]; {dests}]"
    dest_type = "&mut [u8]" if dests == 1 else "&[&mut [u8]]"
    dest_arg = "dest.as_mut_ptr()" if dests == 1 else "dest.as_ptr()"
    return (attribute(arch, file, f"len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), {dest_arg}",
                      [f"gftbls.len() == 32 * vec * {dests}", "src.len() == len", dest_condition,
                       "vec >= 1", "vec <= 255", "vec_i < vec"] + lengths)
            + f"\nfn {name}(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: {dest_type});\n")


def main():
    isal, entries = Path(sys.argv[1]), Path(sys.argv[2])
    minimums = documented_minimums(isal)
    modules = {"crc": [], "mem": [], "raid": [], "erasure_code": []}
    seen = set()
    for line in sorted(entries.read_text().splitlines(), key=lambda l: l.split("\t")[2]):
        arch, obj, name = line.split("\t")
        if name in seen or name.startswith("_"):
            continue
        seen.add(name)
        if name.startswith("crc"):
            modules["crc"].append(crc(arch, obj, name))
        elif name.startswith("mem_zero_detect"):
            modules["mem"].append(mem(arch, obj, name))
        elif re.match(r"(xor|pq)_(gen|check)", name):
            modules["raid"].append(raid(arch, obj, name))
        elif re.match(r"gf_\d?vect_", name):
            modules["erasure_code"].append(erasure(arch, obj, name, minimums))
    for module, items in modules.items():
        text = "use bums_macros as bums;\n\n" + "\n".join(items)
        (OUT / f"{module}.rs").write_text(text)
        print(f"{module}.rs: {len(items)} annotations")


if __name__ == "__main__":
    main()
