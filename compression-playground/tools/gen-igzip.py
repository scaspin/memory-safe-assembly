"""Generate src/igzip_stream.rs: the igzip entry points that take ISA-L structs
(and the x86 Huffman heap helpers, which take the heap_tree array).

Usage: python3 gen-igzip.py <entries.tsv>

`struct isal_zstream` (82384 bytes) is written as a #[repr(C)] tuple whose
field offsets match the C layout. Pointer fields the preconditions bind to a
buffer (`zs.0 == input.as_ptr().add(..)`) are spelled `usize`, the hufftables
as a fixed-size blob, and the level buffer as a blob that exposes struct
level_buf's icf_buf_next (0x1250) with its byte count icf_buf_avail_out, so the
ICF output is a region of that length; the rest of the layout (checked against the `_field` offsets the
AArch64 sources `.set`, and sizeof from the C headers):

  0 next_in  1 avail_in  2 total_in  3 next_out  4 avail_out  5 total_out
  6 hufftables  7 level  8 level_buf_size  9 level_buf  10 end_of_stream
  11 flush  12 gzip_flag  13 hist_bits
  internal_state: 14 total_in_start  15 block_next  16 block_end
  17 dist_mask  18 hash_mask  19 state  20 m_bits  21 m_bit_count
  22 m_out_buf  23 m_out_end  24 m_out_start  25 crc  26 has_wrap_hdr
  27 has_eob_hdr  28 has_eob  29 has_hist  30 has_level_buf_init  31 count
  32 tmp_out_buff  33 tmp_out_start  34 tmp_out_end  35 b_bytes_valid
  36 b_bytes_processed  37 buffer  38 head

The preconditions are the state igzip.c sets up before calling the kernels:
32 KiB of history before next_in (`input` starts IGZIP_HIST_SIZE bytes before
it), the bit buffer pointing into next_out with its 8-byte slop
(set_buf in bitbuf2.h), the default 32 KiB window (dist_mask) and the level-0
hash (hash_mask), and a level buffer of the level-1 default size. ICF entries
(struct deflate_icf: lit_len bits 0-9, lit_dist bits 10-18) satisfy what
gen_icf_map produces: lit_len <= 512 (lit_len_table has 513 entries) and
lit_dist <= 30 (31 distance codes; literals carry NULL_DIST_SYM, 30).
gen_icf_map and set_long_icf_fg work in the hash_map level buffer's
matches[MATCH_BUF_SIZE] followed by overflow[ISAL_LOOK_AHEAD] (4384 entries),
and igzip_icf_body.c calls them with ISAL_LOOK_AHEAD < input_size <= MATCH_BUF_SIZE.

`struct inflate_state` (87368 bytes) is a 28-field tuple: 0 next_out
1 avail_out 2 total_out 3 next_in 4 read_in 5 avail_in 6 read_in_length,
7-8 lit_huff_code (short, long), 9-10 dist_huff_code, 11 block_state ...
16 hist_bits ... 26 tmp_in_buffer 27 tmp_out_buffer. The decoder's output
buffer starts at start_out and next_out is `produced` bytes into it; the
Huffman tables are left unconstrained.

build_heap and build_huff_tree take heap_size >= 2: huff_codes.c pads a
histogram with fewer than two symbols to two, and the assembly's do-while
heapify loop would underflow its index for heap_size 1.
"""

import sys
from pathlib import Path

OUT = Path(__file__).resolve().parent.parent / "src" / "igzip_stream.rs"
HIST = 32768
HUFFTABLES = 2232
LEVEL_BUF = 282624
HUFFTABLES_ICF = 2176

ICF_BUF_NEXT = 0x1250
LEVEL_BUF_STRUCT = "([u8; %d], *mut u8, usize, usize, [u8; %d])" % (ICF_BUF_NEXT, LEVEL_BUF - ICF_BUF_NEXT - 24)

ZSTREAM = ("(usize, u32, u32, usize, u32, u32, *const [u8; %d], u32, u32, *mut %s, "
           "u16, u16, u16, u16, u32, u32, u32, u32, u32, u32, u64, u32, usize, usize, usize, u32, "
           "u8, u8, u8, u8, u16, u32, [u8; 16], u32, u32, u32, u32, [u8; 65824], [u16; 8192])"
           % (HUFFTABLES, LEVEL_BUF_STRUCT))

STREAM_FACTS = [
    f"input.len() == {HIST} + avail_in", "avail_in <= 1073741824",
    f"zs.0 == input.as_ptr().add({HIST})", "zs.1 == avail_in", f"zs.2 <= {HIST}",
    "output.len() == avail_out", "avail_out >= 8", "avail_out <= 1073741824",
    "zs.3 == output.as_mut_ptr()", "zs.4 == avail_out",
    "zs.22 == output.as_mut_ptr()", "zs.23 == output.as_mut_ptr().add(avail_out - 8)",
    "zs.24 == output.as_mut_ptr()", "zs.21 <= 63",
    f"zs.17 == {HIST - 1}", "zs.18 == 8191",
    "zs.35 <= 65824", "zs.36 <= zs.35",
]

STREAM_ARGS = "input: &[u8], avail_in: usize, output: &mut [u8], avail_out: usize"


def asm_file(arch, obj):
    return f"{obj}-x86_64.S" if arch == "x86_64" else f"{obj}.S"


def annotation(arch, obj, name, args, facts, params, returns=""):
    target = "x86_64" if arch == "x86_64" else "aarch64"
    lines = ",\n     ".join(facts)
    return (f'#[cfg_attr(target_arch = "{target}", bums::check_mem_safe("{asm_file(arch, obj)}", {args},\n'
            f"    [{lines}]))]\nfn {name}({params}){returns};\n")


def stream_function(arch, obj, name):
    params = f"zs: &mut {ZSTREAM}, {STREAM_ARGS}"
    return annotation(arch, obj, name, "zs as *mut _", STREAM_FACTS, params)


MATCH_BUF_SIZE = 4096
ISAL_LOOK_AHEAD = 288


def gen_icf_map(arch, obj, name):
    params = f"zs: &mut {ZSTREAM}, matches: &mut [u32], input_size: usize, {STREAM_ARGS}"
    facts = STREAM_FACTS + [f"matches.len() == {MATCH_BUF_SIZE + ISAL_LOOK_AHEAD}",
                            f"input_size > {ISAL_LOOK_AHEAD}", f"input_size <= {MATCH_BUF_SIZE}",
                            "input_size <= avail_in"]
    return annotation(arch, obj, name, "zs as *mut _, matches.as_mut_ptr(), input_size", facts, params, " -> u32")


def set_long_icf_fg(arch, obj, name):
    params = "input: &[u8], processed: usize, input_size: usize, matches: &mut [u32]"
    facts = [f"input.len() == {HIST} + input_size", f"input_size > {ISAL_LOOK_AHEAD}",
             f"input_size <= {MATCH_BUF_SIZE}", "processed <= input_size",
             f"matches.len() == {MATCH_BUF_SIZE + ISAL_LOOK_AHEAD}",
             "matches[..] & 1023 <= 512", "(matches[..] >> 10) & 511 <= 30"]
    return annotation(arch, obj, name, f"input.as_ptr().add({HIST}), processed, input_size, matches.as_mut_ptr()",
                      facts, params)


def encode_deflate_icf(arch, obj, name):
    params = ("icf: &[u32], bb: &mut (u64, u32, usize, usize, usize), "
              f"hufftables: &[u8; {HUFFTABLES_ICF}], output: &mut [u8], avail_out: usize")
    facts = ["icf.len() <= 1073741824", "icf[..] & 1023 <= 512", "(icf[..] >> 10) & 511 <= 30",
             "output.len() == avail_out", "avail_out >= 8", "avail_out <= 1073741824",
             "bb.2 == output.as_mut_ptr()", "bb.3 == output.as_mut_ptr().add(avail_out - 8)",
             "bb.4 == output.as_mut_ptr()", "bb.1 <= 63"]
    return annotation(arch, obj, name, "icf.as_ptr(), icf.as_ptr_range().end, bb as *mut _, hufftables.as_ptr()",
                      facts, params, " -> usize")


INFLATE_STATE = ("(usize, u32, u32, usize, u64, u32, i32, [u32; 4096], [u16; 1264], [u16; 1024], [u16; 80], "
                 "u32, u32, u32, u32, u32, u32, i32, i32, i32, i32, i32, i16, i16, i32, i32, [u8; 328], [u8; 65824])")


def decode_huffman(arch, obj, name):
    params = (f"st: &mut {INFLATE_STATE}, input: &[u8], avail_in: usize, "
              "output: &mut [u8], produced: usize, avail_out: usize")
    facts = ["input.len() == avail_in", "avail_in <= 1073741824",
             "st.3 == input.as_ptr()", "st.5 == avail_in",
             "output.len() == produced + avail_out", "produced <= 1073741824", "avail_out <= 1073741824",
             "st.0 == output.as_mut_ptr().add(produced)", "st.1 == avail_out",
             "st.6 >= 0", "st.6 <= 64", "st.16 <= 15"]
    return annotation(arch, obj, name, "st as *mut _, output.as_mut_ptr()", facts, params, " -> i32")


def build_heap(arch, obj, name):
    params = "heap: &mut [u64; 859], heap_size: usize"
    facts = ["heap_size >= 2", "heap_size <= 286"]
    return annotation(arch, obj, name, "heap.as_mut_ptr(), heap_size", facts, params)


def build_huff_tree(arch, obj, name):
    params = "heap: &mut [u64; 859], heap_size: usize, node_ptr: usize"
    facts = ["heap_size >= 2", "heap_size <= 286", "node_ptr == 858"]
    return annotation(arch, obj, name, "heap.as_mut_ptr(), heap_size, node_ptr", facts, params, " -> u32")


FAMILIES = {
    "decode_huffman_code_block_stateless": decode_huffman,
    "build_heap": build_heap,
    "build_huff_tree": build_huff_tree,
    "isal_deflate_body": stream_function,
    "isal_deflate_finish": stream_function,
    "isal_deflate_icf_body": stream_function,
    "isal_deflate_icf_finish": stream_function,
    "gen_icf_map": gen_icf_map,
    "set_long_icf_fg": set_long_icf_fg,
    "encode_deflate_icf": encode_deflate_icf,
}


def main():
    entries = Path(sys.argv[1]).read_text().splitlines()
    items = []
    for line in sorted(entries, key=lambda l: l.split("\t")[2]):
        arch, obj, name = line.split("\t")
        family = next((f for prefix, f in FAMILIES.items() if name.startswith(prefix)), None)
        if family:
            items.append(family(arch, obj, name))
    OUT.write_text("use bums_macros as bums;\n\n" + "\n".join(items))
    print(f"{OUT.name}: {len(items)} annotations")


if __name__ == "__main__":
    main()
