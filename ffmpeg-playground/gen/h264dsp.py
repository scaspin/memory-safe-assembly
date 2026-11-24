# Generates ffmpeg-playground/src/h264dsp.rs.
import sys
scan8 = [4+1*8,5+1*8,4+2*8,5+2*8, 6+1*8,7+1*8,6+2*8,7+2*8,
         4+3*8,5+3*8,4+4*8,5+4*8, 6+3*8,7+3*8,6+4*8,7+4*8]
def off(i):
    d = scan8[i] - scan8[0]
    x, y = 4 * (d & 7), 4 * (d >> 3)
    terms = []
    if y: terms.append(f"{y} * stride" if y != 1 else "stride")
    if x: terms.append(str(x))
    return f"({' + '.join(terms)}) as i32" if terms else "0"

out = ['''//! libavcodec/aarch64 h264dsp_neon.S and h264idct_neon.S (8-bit, and the
//! 10-bit loop filters). Loop filters may touch p3..q3, four pixels on each
//! side of the edge, which H.264 guarantees exist around every filtered edge;
//! the pixel region is that neighbourhood. Strides are positive bytes.
//! block_offset holds what h264_slice.c computes from scan8.
#![allow(clippy::all)]
use bums_macros as bums;
''']

EXPORTS = {l.split("\t")[1].strip() for l in open(sys.argv[1])}
def lf(name, vertical, width, rows, tc0, ty="u8", file="h264dsp_neon.S", right=4):
    if name not in EXPORTS:
        return
    # vertical: edge between rows; region rows -4..+3 of `width` pixels.
    # horizontal: edge between columns; `rows` rows of columns -4..+3.
    el = 2 if ty == "u16" else 1
    if vertical:
        ptr = f"pix.as_mut_ptr().add({4 if el == 1 else 2} * stride)"
        length = f"pix.len() == 7 * stride{'' if el == 1 else ' / 2'} + {width}"
    else:
        ptr = "pix.as_mut_ptr().add(4)"
        length = f"pix.len() == {rows - 1} * stride{'' if el == 1 else ' / 2'} + {4 + right}"
    args = [ptr, "stride", "alpha", "beta"] + (["tc0.as_ptr()"] if tc0 else [])
    pre = [length, f"stride >= {(width or 4 + right) * el}", "stride <= 1073741824", "alpha <= 255", "beta <= 255"]
    if el == 2: pre.append("stride % 2 == 0")
    if tc0: pre.append("tc0.len() == 4")
    sig = f"pix: &mut [{ty}], stride: usize, alpha: usize, beta: usize" + (", tc0: &[i8]" if tc0 else "")
    out.append(f'''#[bums::check_mem_safe("{file}", {", ".join(args)},
    [{", ".join(pre)}])]
fn {name}({sig});
''')

for sfx, ty in [("neon", "u8"), ("neon_10", "u16")]:
    s = lambda n: f"ff_h264_{n}_{sfx}" if sfx == "neon" else f"ff_h264_{n}_neon_10"
    lf(s("v_loop_filter_luma"), True, 16, 0, True, ty)
    lf(s("h_loop_filter_luma"), False, 0, 16, True, ty)
    lf(s("v_loop_filter_luma_intra"), True, 16, 0, False, ty)
    lf(s("h_loop_filter_luma_intra"), False, 0, 16, False, ty)
    lf(s("v_loop_filter_chroma"), True, 8, 0, True, ty)
    lf(s("h_loop_filter_chroma"), False, 0, 8, True, ty)
    lf(s("h_loop_filter_chroma422"), False, 0, 16, True, ty)
    lf(s("v_loop_filter_chroma_intra"), True, 8, 0, False, ty)
    # The intra (bS = 4) filter runs only on macroblock edges, so the q side
    # is a whole 8-pixel chroma macroblock; these load 8 pixels from x - 2.
    lf(s("h_loop_filter_chroma_intra"), False, 0, 8, False, ty, right=8)
    lf(s("h_loop_filter_chroma422_intra"), False, 0, 16, False, ty, right=8)
    lf(s("h_loop_filter_chroma_mbaff_intra"), False, 0, 4, False, ty, right=8)

for w, hs in [(16, (8, 16)), (8, (4, 16)), (4, (2, 8))]:
    lo, hi = hs
    out.append(f'''// weight_pixels_tab[{ {16:0,8:1,4:2}[w] }]: {w} wide, {lo}..{hi} rows (even).
#[bums::check_mem_safe("h264dsp_neon.S", dst.as_mut_ptr(), stride, height, log2_den, weight, offset,
    [dst.len() == (height - 1) * stride + {w}, stride >= {w}, stride <= 1073741824, height >= {lo}, height <= {hi}, height % 2 == 0, log2_den <= 7])]
fn ff_weight_h264_pixels_{w}_neon(dst: &mut [u8], stride: usize, height: usize, log2_den: usize, weight: i32, offset: i32);

#[bums::check_mem_safe("h264dsp_neon.S", dst.as_mut_ptr(), src.as_mut_ptr(), stride, height, log2_den, weightd, weights, offset,
    [dst.len() == (height - 1) * stride + {w}, src.len() == (height - 1) * stride + {w}, stride >= {w}, stride <= 1073741824, height >= {lo}, height <= {hi}, height % 2 == 0, log2_den <= 7])]
fn ff_biweight_h264_pixels_{w}_neon(dst: &mut [u8], src: &mut [u8], stride: usize, height: usize, log2_den: usize, weightd: i32, weights: i32, offset: i32);
''')

for n, size, coefs in [("idct_add", 4, 16), ("idct_dc_add", 4, 16), ("idct8_add", 8, 64), ("idct8_dc_add", 8, 64)]:
    out.append(f'''#[bums::check_mem_safe("h264idct_neon.S", dst.as_mut_ptr(), block.as_mut_ptr(), stride,
    [dst.len() == {size - 1} * stride + {size}, block.len() == {coefs}, stride >= {size}, stride <= 1073741824])]
fn ff_h264_{n}_neon(dst: &mut [u8], block: &mut [i16], stride: usize);
''')

luma = ", ".join(f"block_offset[{i}] == {off(i)}" for i in range(16))
for n in ["idct_add16", "idct_add16intra"]:
    out.append(f'''// The 16 4x4 blocks of a 16x16 macroblock; nnzc is the 5 x 8 cache.
#[bums::check_mem_safe("h264idct_neon.S", dst.as_mut_ptr(), block_offset.as_ptr(), block.as_mut_ptr(), stride, nnzc.as_ptr(),
    [dst.len() == 15 * stride + 16, block_offset.len() == 48, block.len() == 256, nnzc.len() == 40, stride >= 16, stride <= 1073741824,
     {luma}])]
fn ff_h264_{n}_neon(dst: &mut [u8], block_offset: &[i32], block: &mut [i16], stride: usize, nnzc: &[u8]);
''')
eight = ", ".join(f"block_offset[{i}] == {off(i)}" for i in (0, 4, 8, 12))
out.append(f'''// The four 8x8 blocks of a macroblock (block_offset 0, 4, 8, 12).
#[bums::check_mem_safe("h264idct_neon.S", dst.as_mut_ptr(), block_offset.as_ptr(), block.as_mut_ptr(), stride, nnzc.as_ptr(),
    [dst.len() == 15 * stride + 16, block_offset.len() == 48, block.len() == 256, nnzc.len() == 40, stride >= 16, stride <= 1073741824,
     {eight}])]
fn ff_h264_idct8_add4_neon(dst: &mut [u8], block_offset: &[i32], block: &mut [i16], stride: usize, nnzc: &[u8]);
''')
chroma = ", ".join(f"block_offset[{b + i}] == {off(i)}" for b in (16, 32) for i in range(4))
out.append(f'''// 4:2:0 chroma: four 4x4 blocks in each 8x8 plane; dest holds the two
// planes, block the macroblock's 768 coefficients, nnzc the 15 x 8 cache.
#[bums::check_mem_safe("h264idct_neon.S", dest.as_ptr(), block_offset.as_ptr(), block.as_mut_ptr(), stride, nnzc.as_ptr(),
    [dest.len() == 2, dest[0] == u.as_mut_ptr(), dest[1] == v.as_mut_ptr(), u.len() == 7 * stride + 8, v.len() == 7 * stride + 8,
     block_offset.len() == 48, block.len() == 768, nnzc.len() == 120, stride >= 8, stride <= 1073741824,
     {chroma}])]
fn ff_h264_idct_add8_neon(dest: &[usize], block_offset: &[i32], block: &mut [i16], stride: usize, nnzc: &[u8], u: &mut [u8], v: &mut [u8]);
''')
print("\n".join(out))
