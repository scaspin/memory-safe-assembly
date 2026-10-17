use bums_macros as bums;

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride / 2 + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride / 2 + 8, src_stride >= 38, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_h16_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride / 2 + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride / 2 + 8, src_stride >= 38, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_h16_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride / 2 + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride / 2 + 8, src_stride >= 22, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_h8_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride / 2 + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride / 2 + 8, src_stride >= 22, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_h8_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride / 2 + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride / 2 + 8, src_stride >= 262, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_h_x16_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride / 2 + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride / 2 + 8, src_stride >= 262, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_h_x16_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 38, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_hv16_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 38, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_hv16_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 22, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_hv8_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 22, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_hv8_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 262, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_hv_x16_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 262, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_hv_x16_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 32, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_v16_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 32, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_v16_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 8, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_v4_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 8, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_v4_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 16, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_v8_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 16, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_v8_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 256, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_v_x16_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride / 2 + 8, src_stride >= 256, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 4, vf.len() == 4, src_stride % 2 == 0])]
fn ff_vvc_put_chroma_v_x16_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 131, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 128, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_h128_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 19, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_h16_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 19, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_h16_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 131, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_h32_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 35, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_h32_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 7, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_h4_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 7, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_h4_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 67, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 64, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_h64_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 11, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_h8_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 11, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_h8_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride + 16, src_stride >= 131, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 128, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_hv128_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride + 16, src_stride >= 131, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 128, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_hv128_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride + 16, src_stride >= 19, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_hv16_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride + 16, src_stride >= 19, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_hv16_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride + 16, src_stride >= 35, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_hv32_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride + 16, src_stride >= 35, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_hv32_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride + 16, src_stride >= 7, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_hv4_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride + 16, src_stride >= 7, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_hv4_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride + 16, src_stride >= 67, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 64, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_hv64_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride + 16, src_stride >= 67, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 64, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_hv64_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride + 16, src_stride >= 11, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_hv8_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * src_stride + 1), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 4) * src_stride + 16, src_stride >= 11, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_epel_hv8_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride / 2 + 8, src_stride >= 46, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_h16_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride / 2 + 8, src_stride >= 46, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_h16_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride / 2 + 8, src_stride >= 30, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_h8_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride / 2 + 8, src_stride >= 30, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_h8_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride / 2 + 8, src_stride >= 270, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_h_x16_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride / 2 + 8, src_stride >= 270, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_h_x16_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 46, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_hv16_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 46, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_hv16_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 30, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_hv8_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 30, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_hv8_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 270, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_hv_x16_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 270, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_hv_x16_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 32, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_v16_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 32, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_v16_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 8, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_v4_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 8, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_v4_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 16, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_v8_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 16, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_v8_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 256, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_v_x16_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride / 2 + 8, src_stride >= 256, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 8, vf.len() == 8, src_stride % 2 == 0])]
fn ff_vvc_put_luma_v_x16_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 128, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 128, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_pel_pixels128_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 16, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_pel_pixels16_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 32, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_pel_pixels32_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 4, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_pel_pixels4_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 64, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 64, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_pel_pixels64_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 8, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 4, vf.len() == 4])]
fn ff_vvc_put_pel_pixels8_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 128, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 128, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 128, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_pel_uni_pixels128_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 16, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 16, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_pel_uni_pixels16_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 32, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 32, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_pel_uni_pixels32_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 4, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 4, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_pel_uni_pixels4_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 64, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 64, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 64, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_pel_uni_pixels64_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 8, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 8, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_pel_uni_pixels8_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 0), src_stride, height, denom, wx, ox, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 128, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 128, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 128, hf.len() == 8, vf.len() == 8, denom <= 14])]
fn ff_vvc_put_pel_uni_w_pixels128_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, denom: i32, wx: i32, ox: i32, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 0), src_stride, height, denom, wx, ox, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 16, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 16, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8, denom <= 14])]
fn ff_vvc_put_pel_uni_w_pixels16_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, denom: i32, wx: i32, ox: i32, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 0), src_stride, height, denom, wx, ox, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 32, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 32, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32, hf.len() == 8, vf.len() == 8, denom <= 14])]
fn ff_vvc_put_pel_uni_w_pixels32_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, denom: i32, wx: i32, ox: i32, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 0), src_stride, height, denom, wx, ox, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 4, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 4, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 8, vf.len() == 8, denom <= 14])]
fn ff_vvc_put_pel_uni_w_pixels4_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, denom: i32, wx: i32, ox: i32, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 0), src_stride, height, denom, wx, ox, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 64, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 64, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 64, hf.len() == 8, vf.len() == 8, denom <= 14])]
fn ff_vvc_put_pel_uni_w_pixels64_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, denom: i32, wx: i32, ox: i32, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 0), src_stride, height, denom, wx, ox, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 8, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 8, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8, denom <= 14])]
fn ff_vvc_put_pel_uni_w_pixels8_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, denom: i32, wx: i32, ox: i32, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 135, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 128, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_h128_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 23, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_h16_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 23, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_h16_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 135, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_h32_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 39, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_h32_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 11, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_h4_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 11, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_h4_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 71, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 64, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_h64_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 15, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_h8_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 1) * src_stride + 16, src_stride >= 15, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_h8_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 135, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 128, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_hv128_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 135, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 128, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_hv128_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 23, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_hv16_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 23, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_hv16_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 39, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_hv32_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 39, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_hv32_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 11, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_hv4_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 11, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_hv4_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 71, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 64, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_hv64_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 71, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 64, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_hv64_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 15, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_hv8_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 15, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_hv8_8_neon_i8mm(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 16, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 23, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 16, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_uni_h16_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 128, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 135, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 32 || width == 64 || width == 128, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_uni_h32_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 4, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 11, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_uni_h4_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == (height - 1) * dst_stride + width, dst_stride >= 8, dst_stride <= 1073741824, src.len() == (height + 1) * src_stride + 16, src_stride >= 15, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_uni_h8_8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 4, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 4, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_v4_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 0), src_stride, height, hf.as_ptr(), vf.as_ptr(), width,
    [dst.len() == 16384, src.len() == (height + 8) * src_stride + 16, src_stride >= 128, src_stride <= 1073741824, height % 2 == 0, height >= 2, height <= 128, width == 8 || width == 16 || width == 32 || width == 64 || width == 128, hf.len() == 8, vf.len() == 8])]
fn ff_vvc_put_qpel_v8_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, hf: &[i8], vf: &[i8], width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), dst_stride, src0.as_ptr(), src1.as_ptr(), width, height,
    [dst.len() == (height - 1) * dst_stride + width, src0.len() == 16384, src1.len() == 16384, (width - 2) * (width - 4) * (width - 8) * (width - 16) * (width - 32) * (width - 64) * (width - 128) == 0, (height - 2) * (height - 4) * (height - 8) * (height - 16) * (height - 32) * (height - 64) * (height - 128) == 0, dst_stride >= 128, dst_stride <= 1073741824])]
fn ff_vvc_avg_8_neon(dst: &mut [u8], dst_stride: usize, src0: &[i16], src1: &[i16], width: usize, height: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), dst_stride, src0.as_ptr(), src1.as_ptr(), width, height, w0_w1, offset_shift,
    [dst.len() == (height - 1) * dst_stride + width, src0.len() == 16384, src1.len() == 16384, (width - 2) * (width - 4) * (width - 8) * (width - 16) * (width - 32) * (width - 64) * (width - 128) == 0, (height - 2) * (height - 4) * (height - 8) * (height - 16) * (height - 32) * (height - 64) * (height - 128) == 0, dst_stride >= 128, dst_stride <= 1073741824])]
fn ff_vvc_w_avg_8_neon(dst: &mut [u8], dst_stride: usize, src0: &[i16], src1: &[i16], width: usize, height: usize, w0_w1: u64, offset_shift: u64);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr(), src_stride, height, mx, my, width,
    [dst.len() == 16384, src.len() == (height - 1 + 0) * src_stride + width + 0, (width - 12) * (width - 20) == 0, (height - 12) * (height - 20) == 0, src_stride >= 21, src_stride <= 1073741824, mx <= 15, my <= 15])]
fn ff_vvc_dmvr_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr(), src_stride, height, mx, my, width,
    [dst.len() == 16384, src.len() == (height - 1 + 0) * src_stride + width + 1, (width - 12) * (width - 20) == 0, (height - 12) * (height - 20) == 0, src_stride >= 21, src_stride <= 1073741824, mx <= 15, my <= 15])]
fn ff_vvc_dmvr_h_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr(), src_stride, height, mx, my, width,
    [dst.len() == 16384, src.len() == (height - 1 + 1) * src_stride + width + 0, (width - 12) * (width - 20) == 0, (height - 12) * (height - 20) == 0, src_stride >= 21, src_stride <= 1073741824, mx <= 15, my <= 15])]
fn ff_vvc_dmvr_v_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr(), src_stride, height, mx, my, width,
    [dst.len() == 16384, src.len() == (height - 1 + 1) * src_stride + width + 1, (width - 12) * (width - 20) == 0, (height - 12) * (height - 20) == 0, src_stride >= 21, src_stride <= 1073741824, mx <= 15, my <= 15])]
fn ff_vvc_dmvr_hv_8_neon(dst: &mut [i16], src: &[u8], src_stride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), dst_stride, src0.as_ptr().add(160), src1.as_ptr().add(160), block_w, block_h,
    [dst.len() == (block_h - 1) * dst_stride + block_w, src0.len() == 16384, src1.len() == 16384, (block_w - 8) * (block_w - 16) == 0, (block_h - 8) * (block_h - 16) == 0, dst_stride >= 16, dst_stride <= 1073741824])]
fn ff_vvc_apply_bdof_8_neon(dst: &mut [u8], dst_stride: usize, src0: &[i16], src1: &[i16], block_w: usize, block_h: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), dst_stride, src0.as_ptr(), src1.as_ptr(), width, height,
    [dst.len() == (height - 1) * dst_stride / 2 + width, src0.len() == 16384, src1.len() == 16384, (width - 2) * (width - 4) * (width - 8) * (width - 16) * (width - 32) * (width - 64) * (width - 128) == 0, (height - 2) * (height - 4) * (height - 8) * (height - 16) * (height - 32) * (height - 64) * (height - 128) == 0, dst_stride >= 256, dst_stride <= 1073741824, dst_stride % 2 == 0])]
fn ff_vvc_avg_10_neon(dst: &mut [u16], dst_stride: usize, src0: &[i16], src1: &[i16], width: usize, height: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), dst_stride, src0.as_ptr(), src1.as_ptr(), width, height, w0_w1, offset_shift,
    [dst.len() == (height - 1) * dst_stride / 2 + width, src0.len() == 16384, src1.len() == 16384, (width - 2) * (width - 4) * (width - 8) * (width - 16) * (width - 32) * (width - 64) * (width - 128) == 0, (height - 2) * (height - 4) * (height - 8) * (height - 16) * (height - 32) * (height - 64) * (height - 128) == 0, dst_stride >= 256, dst_stride <= 1073741824, dst_stride % 2 == 0])]
fn ff_vvc_w_avg_10_neon(dst: &mut [u16], dst_stride: usize, src0: &[i16], src1: &[i16], width: usize, height: usize, w0_w1: u64, offset_shift: u64);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr(), src_stride, height, mx, my, width,
    [dst.len() == 16384, src.len() == (height - 1 + 0) * src_stride / 2 + width + 1, (width - 12) * (width - 20) == 0, (height - 12) * (height - 20) == 0, src_stride >= 42, src_stride <= 1073741824, mx <= 15, my <= 15, src_stride % 2 == 0])]
fn ff_vvc_dmvr_h_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr(), src_stride, height, mx, my, width,
    [dst.len() == 16384, src.len() == (height - 1 + 1) * src_stride / 2 + width + 1, (width - 12) * (width - 20) == 0, (height - 12) * (height - 20) == 0, src_stride >= 42, src_stride <= 1073741824, mx <= 15, my <= 15, src_stride % 2 == 0])]
fn ff_vvc_dmvr_hv_10_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), dst_stride, src0.as_ptr().add(160), src1.as_ptr().add(160), block_w, block_h,
    [dst.len() == (block_h - 1) * dst_stride / 2 + block_w, src0.len() == 16384, src1.len() == 16384, (block_w - 8) * (block_w - 16) == 0, (block_h - 8) * (block_h - 16) == 0, dst_stride >= 32, dst_stride <= 1073741824, dst_stride % 2 == 0])]
fn ff_vvc_apply_bdof_10_neon(dst: &mut [u16], dst_stride: usize, src0: &[i16], src1: &[i16], block_w: usize, block_h: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), dst_stride, src0.as_ptr(), src1.as_ptr(), width, height,
    [dst.len() == (height - 1) * dst_stride / 2 + width, src0.len() == 16384, src1.len() == 16384, (width - 2) * (width - 4) * (width - 8) * (width - 16) * (width - 32) * (width - 64) * (width - 128) == 0, (height - 2) * (height - 4) * (height - 8) * (height - 16) * (height - 32) * (height - 64) * (height - 128) == 0, dst_stride >= 256, dst_stride <= 1073741824, dst_stride % 2 == 0])]
fn ff_vvc_avg_12_neon(dst: &mut [u16], dst_stride: usize, src0: &[i16], src1: &[i16], width: usize, height: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), dst_stride, src0.as_ptr(), src1.as_ptr(), width, height, w0_w1, offset_shift,
    [dst.len() == (height - 1) * dst_stride / 2 + width, src0.len() == 16384, src1.len() == 16384, (width - 2) * (width - 4) * (width - 8) * (width - 16) * (width - 32) * (width - 64) * (width - 128) == 0, (height - 2) * (height - 4) * (height - 8) * (height - 16) * (height - 32) * (height - 64) * (height - 128) == 0, dst_stride >= 256, dst_stride <= 1073741824, dst_stride % 2 == 0])]
fn ff_vvc_w_avg_12_neon(dst: &mut [u16], dst_stride: usize, src0: &[i16], src1: &[i16], width: usize, height: usize, w0_w1: u64, offset_shift: u64);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr(), src_stride, height, mx, my, width,
    [dst.len() == 16384, src.len() == (height - 1 + 0) * src_stride / 2 + width + 0, (width - 12) * (width - 20) == 0, (height - 12) * (height - 20) == 0, src_stride >= 42, src_stride <= 1073741824, mx <= 15, my <= 15, src_stride % 2 == 0])]
fn ff_vvc_dmvr_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr(), src_stride, height, mx, my, width,
    [dst.len() == 16384, src.len() == (height - 1 + 0) * src_stride / 2 + width + 1, (width - 12) * (width - 20) == 0, (height - 12) * (height - 20) == 0, src_stride >= 42, src_stride <= 1073741824, mx <= 15, my <= 15, src_stride % 2 == 0])]
fn ff_vvc_dmvr_h_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), src.as_ptr(), src_stride, height, mx, my, width,
    [dst.len() == 16384, src.len() == (height - 1 + 1) * src_stride / 2 + width + 1, (width - 12) * (width - 20) == 0, (height - 12) * (height - 20) == 0, src_stride >= 42, src_stride <= 1073741824, mx <= 15, my <= 15, src_stride % 2 == 0])]
fn ff_vvc_dmvr_hv_12_neon(dst: &mut [i16], src: &[u16], src_stride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("inter.S", dst.as_mut_ptr(), dst_stride, src0.as_ptr().add(160), src1.as_ptr().add(160), block_w, block_h,
    [dst.len() == (block_h - 1) * dst_stride / 2 + block_w, src0.len() == 16384, src1.len() == 16384, (block_w - 8) * (block_w - 16) == 0, (block_h - 8) * (block_h - 16) == 0, dst_stride >= 32, dst_stride <= 1073741824, dst_stride % 2 == 0])]
fn ff_vvc_apply_bdof_12_neon(dst: &mut [u16], dst_stride: usize, src0: &[i16], src1: &[i16], block_w: usize, block_h: usize);

#[bums::check_mem_safe("sad.S", src0.as_ptr(), src1.as_ptr(), dx, dy, block_w, block_h,
    [src0.len() == 16384, src1.len() == 16384, dx <= 4, dy <= 4, (block_w - 8) * (block_w - 16) == 0, (block_h - 8) * (block_h - 16) == 0])]
fn ff_vvc_sad_neon(src0: &[i16], src1: &[i16], dx: usize, dy: usize, block_w: usize, block_h: usize);

#[bums::check_mem_safe("inter.S", gh.as_mut_ptr(), gv.as_mut_ptr(), gstride, src.as_ptr().add(src_stride + 1), src_stride, width, height,
    [gh.len() == (height - 1) * gstride + width, gv.len() == (height - 1) * gstride + width,
     src.len() == (height + 1) * src_stride + width + 1,
     width % 8 == 0, width >= 8, width <= 128, height >= 1, height <= 128,
     gstride >= width, gstride <= 1048576, src_stride >= width + 2, src_stride <= 1048576])]
fn ff_vvc_prof_grad_filter_8x_neon(gh: &mut [i16], gv: &mut [i16], gstride: usize, src: &[i16], src_stride: usize, width: usize, height: usize);

