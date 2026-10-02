#![allow(dead_code)]

use bums_macros as bums;

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_dc_128_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_dc_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_dc_top_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_dc_left_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_v_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_h_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_paeth_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_smooth_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_smooth_v_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_smooth_h_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 32, height <= 32, 32 % height == 0, stride >= width, angle >= 0, angle <= 4])]
fn ipred_filter_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, ac.as_ptr(), alpha, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, ac.len() == 1024, width >= 4, height >= 4, width <= 32, height <= 32, 32 % height == 0, stride >= width])]
fn ipred_cfl_128_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    ac: &[i16],
    alpha: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, ac.as_ptr(), alpha, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, ac.len() == 1024, width >= 4, height >= 4, width <= 32, height <= 32, 32 % height == 0, stride >= width])]
fn ipred_cfl_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    ac: &[i16],
    alpha: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, ac.as_ptr(), alpha, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, ac.len() == 1024, width >= 4, height >= 4, width <= 32, height <= 32, 32 % height == 0, stride >= width])]
fn ipred_cfl_top_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    ac: &[i16],
    alpha: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, ac.as_ptr(), alpha, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, ac.len() == 1024, width >= 4, height >= 4, width <= 32, height <= 32, 32 % height == 0, stride >= width])]
fn ipred_cfl_left_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    ac: &[i16],
    alpha: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred.S", ac.as_mut_ptr(), y.as_ptr(), stride, w_pad, h_pad, cw, ch,
    [ac.len() == 1024, y.len() == stride * 2 * ch, cw >= 4, ch >= 4, cw <= 16, ch <= 16, 16 % ch == 0, stride >= 2 * cw, w_pad >= 0, w_pad <= 3, h_pad >= 0, h_pad <= 3])]
fn ipred_cfl_ac_420_8bpc_neon(
    ac: &mut [i16],
    y: &[u8],
    stride: usize,
    w_pad: i32,
    h_pad: i32,
    cw: usize,
    ch: usize,
);

#[bums::check_mem_safe("ipred.S", ac.as_mut_ptr(), y.as_ptr(), stride, w_pad, h_pad, cw, ch,
    [ac.len() == 1024, y.len() == stride * 1 * ch, cw >= 4, ch >= 4, cw <= 16, ch <= 32, 32 % ch == 0, stride >= 2 * cw, w_pad >= 0, w_pad <= 3, h_pad >= 0, h_pad <= 3])]
fn ipred_cfl_ac_422_8bpc_neon(
    ac: &mut [i16],
    y: &[u8],
    stride: usize,
    w_pad: i32,
    h_pad: i32,
    cw: usize,
    ch: usize,
);

#[bums::check_mem_safe("ipred.S", ac.as_mut_ptr(), y.as_ptr(), stride, w_pad, h_pad, cw, ch,
    [ac.len() == 1024, y.len() == stride * 1 * ch, cw >= 4, ch >= 4, cw <= 32, ch <= 32, 32 % ch == 0, stride >= 1 * cw, w_pad >= 0, w_pad <= 3, h_pad >= 0, h_pad <= 3])]
fn ipred_cfl_ac_444_8bpc_neon(
    ac: &mut [i16],
    y: &[u8],
    stride: usize,
    w_pad: i32,
    h_pad: i32,
    cw: usize,
    ch: usize,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, pal.as_ptr(), idx.as_ptr(), w, h,
    [dst.len() == stride * h, pal.len() == 8, idx.len() == w * h / 2, w >= 4, h >= 4, w <= 64, h <= 64, 64 % h == 0, 64 % w == 0, stride >= w])]
fn pal_pred_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    pal: &[u8],
    idx: &[u8],
    w: usize,
    h: usize,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr(), width, height, dxy, max_base_xy,
    [dst.len() == stride * height, topleft.len() == 2 * width + 1, max_base_xy + 8 <= topleft.len(), width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_z1_fill1_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    dxy: i32,
    max_base_xy: usize,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr(), width, height, dxy, max_base_xy,
    [dst.len() * 1 == stride * height, topleft.len() == 64 + 64 * (64 + 15) * 2 + 16, max_base_xy == 2 * (width + height) - 2, width + height <= 16, width >= 4, height >= 4, width % 4 == 0, height % 4 == 0, stride >= width * 1, dxy >= 0, dxy <= 102])]
fn ipred_z1_fill2_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    dxy: i32,
    max_base_xy: usize,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr(), width, height, dxy, max_base_xy,
    [dst.len() == stride * height, topleft.len() == 2 * width + 1, max_base_xy + 8 <= topleft.len(), width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_z3_fill1_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    dxy: i32,
    max_base_xy: usize,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, topleft.as_ptr(), width, height, dxy, max_base_xy,
    [dst.len() * 1 == stride * height, topleft.len() == 64 + 64 + (64 + 15) * 2, max_base_xy == 2 * (width + height) - 2, width + height <= 16, width >= 4, height >= 4, width % 4 == 0, height % 4 == 0, stride >= width * 1, dxy >= 0, dxy <= 102])]
fn ipred_z3_fill2_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    topleft: &[u8],
    width: usize,
    height: usize,
    dxy: i32,
    max_base_xy: usize,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, top.as_ptr(), left.as_ptr(), width, height, dx, dy,
    [dst.len() == stride * height, top.len() == 2 * width + 1 + 16, left.len() == 2 * height + 1 + 16, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width, dx >= 0, dx <= 102, dy >= 0, dy <= 102])]
fn ipred_z2_fill1_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    top: &[u8],
    left: &[u8],
    width: usize,
    height: usize,
    dx: i32,
    dy: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, top.as_ptr(), left.as_ptr(), width, height, dx, dy,
    [dst.len() == stride * height, top.len() == 2 * width + 1 + 16, left.len() == 2 * height + 1 + 16, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width, dx >= 0, dx <= 102, dy >= 0, dy <= 102])]
fn ipred_z2_fill2_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    top: &[u8],
    left: &[u8],
    width: usize,
    height: usize,
    dx: i32,
    dy: i32,
);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), stride, top.as_ptr(), left.as_ptr(), width, height, dx, dy,
    [dst.len() == stride * height, top.len() == 2 * width + 1 + 16, left.len() == 2 * height + 1 + 16, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width, dx >= 0, dx <= 102, dy >= 0, dy <= 102])]
fn ipred_z2_fill3_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    top: &[u8],
    left: &[u8],
    width: usize,
    height: usize,
    dx: i32,
    dy: i32,
);

#[bums::check_mem_safe("ipred.S", out.as_mut_ptr(), hsz, in_0.as_ptr(), end, bitdepth_max,
    [out.len() == hsz * 2, in_0.len() == hsz + 1 + 16, hsz >= 4, hsz <= 64, end >= 0, end <= hsz])]
fn ipred_z1_upsample_edge_8bpc_neon(out: &mut [u8], hsz: usize, in_0: &[u8], end: i32, bitdepth_max: i32);

#[bums::check_mem_safe("ipred.S", out.as_mut_ptr(), hsz, in_0.as_ptr(), bitdepth_max,
    [out.len() == hsz * 2, in_0.len() == hsz + 1 + 16, hsz >= 4, hsz <= 64])]
fn ipred_z2_upsample_edge_8bpc_neon(out: &mut [u8], hsz: usize, in_0: &[u8], bitdepth_max: i32);

#[bums::check_mem_safe("ipred.S", out.as_mut_ptr(), sz, in_0.as_ptr().add(1), end, strength,
    [out.len() == sz, in_0.len() == sz + 2 + 16, sz >= 4, sz <= 128, strength >= 1, strength <= 3, end >= 0, end <= sz])]
fn ipred_z1_filter_edge_8bpc_neon(out: &mut [u8], sz: usize, in_0: &[u8], end: i32, strength: i32);

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), src.as_ptr_range().end, n,
    [dst.len() == src.len(), src.len() == n, n >= 16, n % 16 == 0])]
fn ipred_reverse_8bpc_neon(dst: &mut [u8], src: &[u8], n: usize);

#[bums::check_mem_safe("ipred.S", out.as_mut_ptr(), px, n, [out.len() == n, n >= 16, n % 16 == 0])]
fn ipred_pixel_set_8bpc_neon(out: &mut [u8], px: u8, n: usize);
#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_dc_128_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_dc_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_dc_top_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_dc_left_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_v_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_h_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_paeth_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_smooth_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_smooth_v_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_smooth_h_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, angle, max_width, max_height, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, width >= 4, height >= 4, width <= 32, height <= 32, 32 % height == 0, stride >= width, angle >= 0, angle <= 4])]
fn ipred_filter_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    angle: i32,
    max_width: i32,
    max_height: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, ac.as_ptr(), alpha, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, ac.len() == 1024, width >= 4, height >= 4, width <= 32, height <= 32, 32 % height == 0, stride >= width])]
fn ipred_cfl_128_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    ac: &[i16],
    alpha: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, ac.as_ptr(), alpha, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, ac.len() == 1024, width >= 4, height >= 4, width <= 32, height <= 32, 32 % height == 0, stride >= width])]
fn ipred_cfl_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    ac: &[i16],
    alpha: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, ac.as_ptr(), alpha, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, ac.len() == 1024, width >= 4, height >= 4, width <= 32, height <= 32, 32 % height == 0, stride >= width])]
fn ipred_cfl_top_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    ac: &[i16],
    alpha: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr().add(128), width, height, ac.as_ptr(), alpha, bitdepth_max,
    [dst.len() == stride * height, topleft.len() == 257, ac.len() == 1024, width >= 4, height >= 4, width <= 32, height <= 32, 32 % height == 0, stride >= width])]
fn ipred_cfl_left_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    ac: &[i16],
    alpha: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("ipred16.S", ac.as_mut_ptr(), y.as_ptr(), stride, w_pad, h_pad, cw, ch,
    [ac.len() == 1024, y.len() == stride * 2 * ch, cw >= 4, ch >= 4, cw <= 16, ch <= 16, 16 % ch == 0, stride >= 2 * cw, w_pad >= 0, w_pad <= 3, h_pad >= 0, h_pad <= 3])]
fn ipred_cfl_ac_420_16bpc_neon(
    ac: &mut [i16],
    y: &[u16],
    stride: usize,
    w_pad: i32,
    h_pad: i32,
    cw: usize,
    ch: usize,
);

#[bums::check_mem_safe("ipred16.S", ac.as_mut_ptr(), y.as_ptr(), stride, w_pad, h_pad, cw, ch,
    [ac.len() == 1024, y.len() == stride * 1 * ch, cw >= 4, ch >= 4, cw <= 16, ch <= 32, 32 % ch == 0, stride >= 2 * cw, w_pad >= 0, w_pad <= 3, h_pad >= 0, h_pad <= 3])]
fn ipred_cfl_ac_422_16bpc_neon(
    ac: &mut [i16],
    y: &[u16],
    stride: usize,
    w_pad: i32,
    h_pad: i32,
    cw: usize,
    ch: usize,
);

#[bums::check_mem_safe("ipred16.S", ac.as_mut_ptr(), y.as_ptr(), stride, w_pad, h_pad, cw, ch,
    [ac.len() == 1024, y.len() == stride * 1 * ch, cw >= 4, ch >= 4, cw <= 32, ch <= 32, 32 % ch == 0, stride >= 1 * cw, w_pad >= 0, w_pad <= 3, h_pad >= 0, h_pad <= 3])]
fn ipred_cfl_ac_444_16bpc_neon(
    ac: &mut [i16],
    y: &[u16],
    stride: usize,
    w_pad: i32,
    h_pad: i32,
    cw: usize,
    ch: usize,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, pal.as_ptr(), idx.as_ptr(), w, h,
    [dst.len() == stride * h, pal.len() == 8, idx.len() == w * h / 2, w >= 4, h >= 4, w <= 64, h <= 64, 64 % h == 0, 64 % w == 0, stride >= w])]
fn pal_pred_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    pal: &[u16],
    idx: &[u8],
    w: usize,
    h: usize,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr(), width, height, dxy, max_base_xy,
    [dst.len() == stride * height, topleft.len() == 2 * width + 1, max_base_xy + 8 <= topleft.len(), width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_z1_fill1_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    dxy: i32,
    max_base_xy: usize,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr(), width, height, dxy, max_base_xy,
    [dst.len() * 2 == stride * height, topleft.len() == 64 + 64 * (64 + 15) * 2 + 16, max_base_xy == 2 * (width + height) - 2, width + height <= 16, width >= 4, height >= 4, width % 4 == 0, height % 4 == 0, stride >= width * 2, dxy >= 0, dxy <= 102])]
fn ipred_z1_fill2_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    dxy: i32,
    max_base_xy: usize,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr(), width, height, dxy, max_base_xy,
    [dst.len() == stride * height, topleft.len() == 2 * width + 1, max_base_xy + 8 <= topleft.len(), width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width])]
fn ipred_z3_fill1_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    dxy: i32,
    max_base_xy: usize,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, topleft.as_ptr(), width, height, dxy, max_base_xy,
    [dst.len() * 2 == stride * height, topleft.len() == 64 + 64 + (64 + 15) * 2, max_base_xy == 2 * (width + height) - 2, width + height <= 16, width >= 4, height >= 4, width % 4 == 0, height % 4 == 0, stride >= width * 2, dxy >= 0, dxy <= 102])]
fn ipred_z3_fill2_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    topleft: &[u16],
    width: usize,
    height: usize,
    dxy: i32,
    max_base_xy: usize,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, top.as_ptr(), left.as_ptr(), width, height, dx, dy,
    [dst.len() == stride * height, top.len() == 2 * width + 1 + 8, left.len() == 2 * height + 1 + 8, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width, dx >= 0, dx <= 102, dy >= 0, dy <= 102])]
fn ipred_z2_fill1_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    top: &[u16],
    left: &[u16],
    width: usize,
    height: usize,
    dx: i32,
    dy: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, top.as_ptr(), left.as_ptr(), width, height, dx, dy,
    [dst.len() == stride * height, top.len() == 2 * width + 1 + 8, left.len() == 2 * height + 1 + 8, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width, dx >= 0, dx <= 102, dy >= 0, dy <= 102])]
fn ipred_z2_fill2_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    top: &[u16],
    left: &[u16],
    width: usize,
    height: usize,
    dx: i32,
    dy: i32,
);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), stride, top.as_ptr(), left.as_ptr(), width, height, dx, dy,
    [dst.len() == stride * height, top.len() == 2 * width + 1 + 8, left.len() == 2 * height + 1 + 8, width >= 4, height >= 4, width <= 64, height <= 64, 64 % height == 0, stride >= width, dx >= 0, dx <= 102, dy >= 0, dy <= 102])]
fn ipred_z2_fill3_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    top: &[u16],
    left: &[u16],
    width: usize,
    height: usize,
    dx: i32,
    dy: i32,
);

#[bums::check_mem_safe("ipred16.S", out.as_mut_ptr(), hsz, in_0.as_ptr(), end, bitdepth_max,
    [out.len() == hsz * 2, in_0.len() == hsz + 1 + 8, hsz >= 4, hsz <= 64, end >= 0, end <= hsz])]
fn ipred_z1_upsample_edge_16bpc_neon(out: &mut [u16], hsz: usize, in_0: &[u16], end: i32, bitdepth_max: i32);

#[bums::check_mem_safe("ipred16.S", out.as_mut_ptr(), hsz, in_0.as_ptr(), bitdepth_max,
    [out.len() == hsz * 2, in_0.len() == hsz + 1 + 8, hsz >= 4, hsz <= 64])]
fn ipred_z2_upsample_edge_16bpc_neon(out: &mut [u16], hsz: usize, in_0: &[u16], bitdepth_max: i32);

#[bums::check_mem_safe("ipred16.S", out.as_mut_ptr(), sz, in_0.as_ptr().add(1), end, strength,
    [out.len() == sz, in_0.len() == sz + 2 + 8, sz >= 4, sz <= 128, strength >= 1, strength <= 3, end >= 0, end <= sz])]
fn ipred_z1_filter_edge_16bpc_neon(out: &mut [u16], sz: usize, in_0: &[u16], end: i32, strength: i32);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), src.as_ptr_range().end, n,
    [dst.len() == src.len(), src.len() == n, n >= 8, n % 8 == 0])]
fn ipred_reverse_16bpc_neon(dst: &mut [u16], src: &[u16], n: usize);

#[bums::check_mem_safe("ipred16.S", out.as_mut_ptr(), px, n, [out.len() == n, n >= 8, n % 8 == 0])]
fn ipred_pixel_set_16bpc_neon(out: &mut [u16], px: u16, n: usize);
