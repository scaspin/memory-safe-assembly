"""Generate ../src/zlib_ng.rs, the annotations for zlib-ng's SIMD kernels.

Usage: python3 gen-zlib-ng.py

Each kernel gets the contract its caller in zlib-ng (2.3.3) gives it:

- adler32_* and crc32_* take `buf[..len]`; the fold_copy variants also write
  `dst[..len]`.
- the crc32_fold_* family works on `crc32_fold` (crc32.h: a 64-byte fold
  buffer and a u32 value), written as the tuple `([u8; 64], u32)`.
- compare256_* compares two buffers of 256 bytes (deflate's window keeps
  MAX_MATCH plus slack readable past every match start).
- chunkmemset_safe_* is inflate.c's `put = chunkmemset_safe(put, put -
  state->offset, copy, left)`: one output buffer, `out` at `pos`, `from` `dist`
  bytes back with `1 <= dist <= pos`, and `1 <= len <= left`, where `left`
  is the space after `out`.
- slide_hash_* reads w_size (0x40), prev (0x60) and head (0x68) from
  deflate_state, written as a blob tuple; head has HASH_SIZE (65536) u16
  entries, prev has w_size, and w_size is a power of two from 256 to 32768
  (windowBits 8..15).

longest_match_* and inflate_fast_* take the whole deflate_state or inflate
state and are not annotated yet.
"""

from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE.parent / "src" / "zlib_ng.rs"
LONG_MAX = "1099511627776"
LEN_MAX = "2147483647"
X86 = ("x86_64", "x86_64")
A64 = ("aarch64", "aarch64")

ADLER32 = [(X86, "adler32_ssse3"), (X86, "adler32_avx2"), (X86, "adler32_avx512"),
           (X86, "adler32_avx512_vnni"), (A64, "adler32_neon")]
ADLER32_COPY = [(X86, "adler32_sse42", "adler32_fold_copy_sse42"),
                (X86, "adler32_avx2", "adler32_fold_copy_avx2"),
                (X86, "adler32_avx512", "adler32_fold_copy_avx512"),
                (X86, "adler32_avx512_vnni", "adler32_fold_copy_avx512_vnni"),
                (A64, "adler32_neon", "adler32_fold_copy_neon")]
CRC32 = [(X86, "crc32_pclmulqdq", "crc32_pclmulqdq"), (X86, "crc32_vpclmulqdq", "crc32_vpclmulqdq"),
         (X86, "chorba_sse2", "crc32_chorba_sse2"), (X86, "chorba_sse41", "crc32_chorba_sse41"),
         (A64, "crc32_armv8", "crc32_armv8")]
CRC32_FOLD = [(X86, "crc32_pclmulqdq", "pclmulqdq"), (X86, "crc32_vpclmulqdq", "vpclmulqdq")]
COMPARE256 = [(X86, "compare256_sse2"), (X86, "compare256_avx2"), (X86, "compare256_avx512"),
              (A64, "compare256_neon")]
CHUNKMEMSET = [(X86, "chunkset_sse2", "sse2"), (X86, "chunkset_ssse3", "ssse3"),
               (X86, "chunkset_avx2", "avx2"), (X86, "chunkset_avx512", "avx512"),
               (A64, "chunkset_neon", "neon")]
SLIDE_HASH = [(X86, "slide_hash_sse2"), (X86, "slide_hash_avx2"), (A64, "slide_hash_neon")]

CRC32_FOLD_STATE = "([u8; 64], u32)"
DEFLATE_STATE = "([u8; 64], u32, [u8; 28], usize, usize)"
WINDOW_SIZES = " || ".join(f"w_size == {1 << bits}" for bits in range(8, 16))


def annotation(arch, source, function, args, facts, params, returns=""):
    target, _ = arch
    asm = f"zng_{source}-x86_64.S" if target == "x86_64" else f"zng_{source}.S"
    lines = ",\n     ".join(facts)
    return (f'#[cfg_attr(target_arch = "{target}", bums::check_mem_safe("{asm}", {args},\n'
            f"    [{lines}]))]\nfn {function}({params}){returns};\n")


def generate():
    items = []
    for arch, name in ADLER32:
        items.append(annotation(arch, name, name, "adler, buf.as_ptr(), len",
                                ["buf.len() == len", f"len <= {LONG_MAX}"],
                                "adler: u32, buf: &[u8], len: usize", " -> u32"))
    for arch, source, name in ADLER32_COPY:
        items.append(annotation(arch, source, name, "adler, dst.as_mut_ptr(), src.as_ptr(), len",
                                ["dst.len() == len", "src.len() == len", f"len <= {LONG_MAX}"],
                                "adler: u32, dst: &mut [u8], src: &[u8], len: usize", " -> u32"))
    for arch, source, name in CRC32:
        items.append(annotation(arch, source, name, "crc, buf.as_ptr(), len",
                                ["buf.len() == len", f"len <= {LONG_MAX}"],
                                "crc: u32, buf: &[u8], len: usize", " -> u32"))
    fold = f"crc: &mut {CRC32_FOLD_STATE}"
    for arch, source, isa in CRC32_FOLD:
        items.append(annotation(arch, source, f"crc32_fold_{isa}_reset", "crc as *mut _", [], fold, " -> u32"))
        items.append(annotation(arch, source, f"crc32_fold_{isa}", "crc as *mut _, src.as_ptr(), len, init_crc",
                                ["src.len() == len", f"len <= {LONG_MAX}"],
                                f"{fold}, src: &[u8], len: usize, init_crc: u32"))
        items.append(annotation(arch, source, f"crc32_fold_{isa}_copy",
                                "crc as *mut _, dst.as_mut_ptr(), src.as_ptr(), len",
                                ["dst.len() == len", "src.len() == len", f"len <= {LONG_MAX}"],
                                f"{fold}, dst: &mut [u8], src: &[u8], len: usize"))
        items.append(annotation(arch, source, f"crc32_fold_{isa}_final", "crc as *mut _", [], fold, " -> u32"))
    items.append(annotation(A64, "crc32_armv8", "crc32_fold_armv8", "crc as *mut _, src.as_ptr(), len, init_crc",
                            ["src.len() == len", f"len <= {LONG_MAX}"],
                            f"{fold}, src: &[u8], len: usize, init_crc: u32"))
    items.append(annotation(A64, "crc32_armv8", "crc32_fold_copy_armv8",
                            "crc as *mut _, dst.as_mut_ptr(), src.as_ptr(), len",
                            ["dst.len() == len", "src.len() == len", f"len <= {LONG_MAX}"],
                            f"{fold}, dst: &mut [u8], src: &[u8], len: usize"))
    for arch, name in COMPARE256:
        items.append(annotation(arch, name, name, "src0.as_ptr(), src1.as_ptr()",
                                ["src0.len() == 256", "src1.len() == 256"],
                                "src0: &[u8], src1: &[u8]", " -> u32"))
    for arch, source, isa in CHUNKMEMSET:
        items.append(annotation(arch, source, f"chunkmemset_safe_{isa}",
                                "buf.as_mut_ptr().add(pos), buf.as_mut_ptr().add(pos - dist), len, left",
                                ["buf.len() == pos + left", f"pos <= {LEN_MAX}", f"left <= {LEN_MAX}",
                                 "dist >= 1", "dist <= pos", "len >= 1", "len <= left"],
                                "buf: &mut [u8], pos: usize, dist: usize, len: u32, left: u32", " -> *mut u8"))
    for arch, name in SLIDE_HASH:
        items.append(annotation(arch, name, name, "s as *mut _",
                                ["s.1 == w_size", "s.3 == prev.as_mut_ptr()", "s.4 == head.as_mut_ptr()",
                                 "prev.len() == w_size", "head.len() == 65536", WINDOW_SIZES],
                                f"s: &mut {DEFLATE_STATE}, prev: &mut [u16], head: &mut [u16], w_size: u32"))
    return items


def main():
    items = generate()
    OUT.write_text("use bums_macros as bums;\n\n" + "\n".join(items))
    print(f"{OUT.name}: {len(items)} annotations")


if __name__ == "__main__":
    main()
