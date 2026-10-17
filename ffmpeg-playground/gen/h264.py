# Generates ffmpeg-playground/src/h264.rs: h264pred, h264qpel, h264cmc.
import csv, sys
exports = [l.split("\t")[1].strip() for l in open(sys.argv[1]) if l.split("\t")[0].endswith(("h264pred_neon", "h264qpel_neon", "h264cmc_neon"))]
out = ['''//! libavcodec/aarch64 h264pred_neon.S, h264qpel_neon.S, h264cmc_neon.S.
//! Intra prediction reads the row above and the column left of the block,
//! with the top-left corner. Quarter-pel interpolation reads 2 pixels before
//! and 3 after the block in each direction (the 6-tap filter). Chroma MC is
//! bilinear: one row and column beyond the block. 10-bit pixels are u16 with
//! byte strides; strides are positive.
//!
//! MC sources are whole rows: the footprint plus one more row and 16 bytes.
//! The NEON code loads whole vectors past the footprint. FFmpeg allocates
//! H.264 and VC-1 frames two lines taller for exactly this ("some of the
//! optimized chroma MC reads one line too much", avcodec_align_dimensions2);
//! RV40 reads in place only with four luma rows to spare below the block
//! (rv34_mc); out-of-frame blocks come from edge_emu_buffer (21 or
//! EMU_EDGE_HEIGHT rows of the frame's stride); a plane's pool adds
//! 16 + STRIDE_ALIGN - 1 bytes after its last row.
use bums_macros as bums;
''']
for name in exports:
    ten = name.endswith("_10")
    ty = "u16" if ten else "u8"
    rs = "stride / 2" if ten else "stride"   # a row in elements
    even = ", stride % 2 == 0" if ten else ""
    el = 2 if ten else 1
    if name.startswith("ff_pred"):
        n = 16 if name.startswith("ff_pred16x16") else 8
        out.append(f'''#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add({rs} + 1), stride,
    [src.len() == {n} * {rs} + {n + 1}, stride >= {(n + 1) * el}, stride <= 1073741824{even}])]
fn {name}(src: &mut [{ty}], stride: usize);
''')
    elif "qpel" in name:
        n = 16 if "qpel16" in name else 8
        out.append(f'''#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * {rs} + 2), stride,
    [dst.len() == {n - 1} * {rs} + {n}, src.len() == {n + 6} * {rs} + {16 // el}, stride >= {(n + 5) * el}, stride <= 1073741824{even}])]
fn {name}(dst: &mut [{ty}], src: &[{ty}], stride: usize);
''')
    elif "chroma_mc" in name:
        w = int(name.split("chroma_mc")[1][0])
        hs = {8: "h % 4 == 0, h >= 4, h <= 16", 4: "h % 2 == 0, h >= 2, h <= 16", 2: "h % 2 == 0, h >= 2, h <= 16"}[w]
        out.append(f'''#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + {w}, src.len() == (h + 2) * stride + 16, stride >= {w + 1}, stride <= 1073741824, {hs}, x <= 7, y <= 7])]
fn {name}(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);
''')
    else:
        print("skipped", name, file=sys.stderr)
print("\n".join(out))
