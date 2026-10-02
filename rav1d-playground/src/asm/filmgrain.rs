#![allow(dead_code)]

use bums_macros as bums;

#[bums::check_mem_safe("filmgrain.S", buf.as_mut_ptr(), data.as_ptr(), bitdepth_max,
    [buf.len() == 82 * 73, data.len() == 92, data[23] <= 3])]
fn generate_grain_y_8bpc_neon(buf: &mut [i8], data: &[u32], bitdepth_max: i32);

#[bums::check_mem_safe("filmgrain.S", buf.as_mut_ptr(), buf_y.as_ptr(), data.as_ptr(), uv, bitdepth_max,
    [buf.len() == 82 * 73, buf_y.len() == 82 * 73, data.len() == 92, data[23] <= 3, uv >= 0, uv <= 1])]
fn generate_grain_uv_420_8bpc_neon(buf: &mut [i8], buf_y: &[i8], data: &[u32], uv: i32, bitdepth_max: i32);

#[bums::check_mem_safe("filmgrain.S", buf.as_mut_ptr(), buf_y.as_ptr(), data.as_ptr(), uv, bitdepth_max,
    [buf.len() == 82 * 73, buf_y.len() == 82 * 73, data.len() == 92, data[23] <= 3, uv >= 0, uv <= 1])]
fn generate_grain_uv_422_8bpc_neon(buf: &mut [i8], buf_y: &[i8], data: &[u32], uv: i32, bitdepth_max: i32);

#[bums::check_mem_safe("filmgrain.S", buf.as_mut_ptr(), buf_y.as_ptr(), data.as_ptr(), uv, bitdepth_max,
    [buf.len() == 82 * 73, buf_y.len() == 82 * 73, data.len() == 92, data[23] <= 3, uv >= 0, uv <= 1])]
fn generate_grain_uv_444_8bpc_neon(buf: &mut [i8], buf_y: &[i8], data: &[u32], uv: i32, bitdepth_max: i32);

#[bums::check_mem_safe("filmgrain.S", dst.as_mut_ptr(), src.as_ptr(), stride, scaling.as_ptr(), scaling_shift, grain_lut.as_ptr(), offsets.as_ptr(), h, clip, ty, bitdepth_max,
    [dst.len() * 1 == stride * h, src.len() * 1 == stride * h, stride >= 32, h >= 1, h <= 32, scaling.len() == 256, grain_lut.len() == 82 * 74, offsets.len() == 4, offsets[0] >= 0, offsets[0] <= 255, offsets[1] >= 0, offsets[1] <= 255, offsets[2] >= 0, offsets[2] <= 255, offsets[3] >= 0, offsets[3] <= 255, clip <= 1, ty <= 3])]
fn fgy_32x32_8bpc_neon(
    dst: &mut [u8],
    src: &[u8],
    stride: usize,
    scaling: &[u8],
    scaling_shift: i32,
    grain_lut: &[i8],
    offsets: &[i32],
    h: usize,
    clip: usize,
    ty: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("filmgrain.S", dst.as_mut_ptr(), src.as_ptr(), stride, scaling.as_ptr(), data.as_ptr(), grain_lut.as_ptr(), luma_row.as_ptr(), luma_stride, offsets.as_ptr(), h, uv, is_id, ty, bitdepth_max,
    [dst.len() * 1 == stride * h, src.len() * 1 == stride * h, stride >= 16, h >= 1, h <= 16, luma_row.len() * 1 == luma_stride * (h * 2), luma_stride >= 32, scaling.len() == 256, data.len() == 224, grain_lut.len() == 82 * 74, offsets.len() == 4, offsets[0] >= 0, offsets[0] <= 255, offsets[1] >= 0, offsets[1] <= 255, offsets[2] >= 0, offsets[2] <= 255, offsets[3] >= 0, offsets[3] <= 255, uv <= 1, is_id <= 1, ty <= 7])]
fn fguv_32x32_420_8bpc_neon(
    dst: &mut [u8],
    src: &[u8],
    stride: usize,
    scaling: &[u8],
    data: &[u8],
    grain_lut: &[i8],
    luma_row: &[u8],
    luma_stride: usize,
    offsets: &[i32],
    h: usize,
    uv: usize,
    is_id: usize,
    ty: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("filmgrain.S", dst.as_mut_ptr(), src.as_ptr(), stride, scaling.as_ptr(), data.as_ptr(), grain_lut.as_ptr(), luma_row.as_ptr(), luma_stride, offsets.as_ptr(), h, uv, is_id, ty, bitdepth_max,
    [dst.len() * 1 == stride * h, src.len() * 1 == stride * h, stride >= 16, h >= 1, h <= 32, luma_row.len() * 1 == luma_stride * (h * 1), luma_stride >= 32, scaling.len() == 256, data.len() == 224, grain_lut.len() == 82 * 74, offsets.len() == 4, offsets[0] >= 0, offsets[0] <= 255, offsets[1] >= 0, offsets[1] <= 255, offsets[2] >= 0, offsets[2] <= 255, offsets[3] >= 0, offsets[3] <= 255, uv <= 1, is_id <= 1, ty <= 7])]
fn fguv_32x32_422_8bpc_neon(
    dst: &mut [u8],
    src: &[u8],
    stride: usize,
    scaling: &[u8],
    data: &[u8],
    grain_lut: &[i8],
    luma_row: &[u8],
    luma_stride: usize,
    offsets: &[i32],
    h: usize,
    uv: usize,
    is_id: usize,
    ty: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("filmgrain.S", dst.as_mut_ptr(), src.as_ptr(), stride, scaling.as_ptr(), data.as_ptr(), grain_lut.as_ptr(), luma_row.as_ptr(), luma_stride, offsets.as_ptr(), h, uv, is_id, ty, bitdepth_max,
    [dst.len() * 1 == stride * h, src.len() * 1 == stride * h, stride >= 32, h >= 1, h <= 32, luma_row.len() * 1 == luma_stride * (h * 1), luma_stride >= 32, scaling.len() == 256, data.len() == 224, grain_lut.len() == 82 * 74, offsets.len() == 4, offsets[0] >= 0, offsets[0] <= 255, offsets[1] >= 0, offsets[1] <= 255, offsets[2] >= 0, offsets[2] <= 255, offsets[3] >= 0, offsets[3] <= 255, uv <= 1, is_id <= 1, ty <= 7])]
fn fguv_32x32_444_8bpc_neon(
    dst: &mut [u8],
    src: &[u8],
    stride: usize,
    scaling: &[u8],
    data: &[u8],
    grain_lut: &[i8],
    luma_row: &[u8],
    luma_stride: usize,
    offsets: &[i32],
    h: usize,
    uv: usize,
    is_id: usize,
    ty: usize,
    bitdepth_max: i32,
);
#[bums::check_mem_safe("filmgrain16.S", buf.as_mut_ptr(), data.as_ptr(), bitdepth_max,
    [buf.len() == 82 * 73, data.len() == 92, data[23] <= 3])]
fn generate_grain_y_16bpc_neon(buf: &mut [i16], data: &[u32], bitdepth_max: i32);

#[bums::check_mem_safe("filmgrain16.S", buf.as_mut_ptr(), buf_y.as_ptr(), data.as_ptr(), uv, bitdepth_max,
    [buf.len() == 82 * 73, buf_y.len() == 82 * 73, data.len() == 92, data[23] <= 3, uv >= 0, uv <= 1])]
fn generate_grain_uv_420_16bpc_neon(buf: &mut [i16], buf_y: &[i16], data: &[u32], uv: i32, bitdepth_max: i32);

#[bums::check_mem_safe("filmgrain16.S", buf.as_mut_ptr(), buf_y.as_ptr(), data.as_ptr(), uv, bitdepth_max,
    [buf.len() == 82 * 73, buf_y.len() == 82 * 73, data.len() == 92, data[23] <= 3, uv >= 0, uv <= 1])]
fn generate_grain_uv_422_16bpc_neon(buf: &mut [i16], buf_y: &[i16], data: &[u32], uv: i32, bitdepth_max: i32);

#[bums::check_mem_safe("filmgrain16.S", buf.as_mut_ptr(), buf_y.as_ptr(), data.as_ptr(), uv, bitdepth_max,
    [buf.len() == 82 * 73, buf_y.len() == 82 * 73, data.len() == 92, data[23] <= 3, uv >= 0, uv <= 1])]
fn generate_grain_uv_444_16bpc_neon(buf: &mut [i16], buf_y: &[i16], data: &[u32], uv: i32, bitdepth_max: i32);

#[bums::check_mem_safe("filmgrain16.S", dst.as_mut_ptr(), src.as_ptr(), stride, scaling.as_ptr(), scaling_shift, grain_lut.as_ptr(), offsets.as_ptr(), h, clip, ty, bitdepth_max,
    [dst.len() * 2 == stride * h, src.len() * 2 == stride * h, stride >= 64, h >= 1, h <= 32, scaling.len() == 4096, grain_lut.len() == 82 * 74, offsets.len() == 4, offsets[0] >= 0, offsets[0] <= 255, offsets[1] >= 0, offsets[1] <= 255, offsets[2] >= 0, offsets[2] <= 255, offsets[3] >= 0, offsets[3] <= 255, clip <= 1, ty <= 3])]
fn fgy_32x32_16bpc_neon(
    dst: &mut [u16],
    src: &[u16],
    stride: usize,
    scaling: &[u8],
    scaling_shift: i32,
    grain_lut: &[i16],
    offsets: &[i32],
    h: usize,
    clip: usize,
    ty: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("filmgrain16.S", dst.as_mut_ptr(), src.as_ptr(), stride, scaling.as_ptr(), data.as_ptr(), grain_lut.as_ptr(), luma_row.as_ptr(), luma_stride, offsets.as_ptr(), h, uv, is_id, ty, bitdepth_max,
    [dst.len() * 2 == stride * h, src.len() * 2 == stride * h, stride >= 32, h >= 1, h <= 16, luma_row.len() * 2 == luma_stride * (h * 2), luma_stride >= 64, scaling.len() == 4096, data.len() == 224, grain_lut.len() == 82 * 74, offsets.len() == 4, offsets[0] >= 0, offsets[0] <= 255, offsets[1] >= 0, offsets[1] <= 255, offsets[2] >= 0, offsets[2] <= 255, offsets[3] >= 0, offsets[3] <= 255, uv <= 1, is_id <= 1, ty <= 7])]
fn fguv_32x32_420_16bpc_neon(
    dst: &mut [u16],
    src: &[u16],
    stride: usize,
    scaling: &[u8],
    data: &[u8],
    grain_lut: &[i16],
    luma_row: &[u16],
    luma_stride: usize,
    offsets: &[i32],
    h: usize,
    uv: usize,
    is_id: usize,
    ty: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("filmgrain16.S", dst.as_mut_ptr(), src.as_ptr(), stride, scaling.as_ptr(), data.as_ptr(), grain_lut.as_ptr(), luma_row.as_ptr(), luma_stride, offsets.as_ptr(), h, uv, is_id, ty, bitdepth_max,
    [dst.len() * 2 == stride * h, src.len() * 2 == stride * h, stride >= 32, h >= 1, h <= 32, luma_row.len() * 2 == luma_stride * (h * 1), luma_stride >= 64, scaling.len() == 4096, data.len() == 224, grain_lut.len() == 82 * 74, offsets.len() == 4, offsets[0] >= 0, offsets[0] <= 255, offsets[1] >= 0, offsets[1] <= 255, offsets[2] >= 0, offsets[2] <= 255, offsets[3] >= 0, offsets[3] <= 255, uv <= 1, is_id <= 1, ty <= 7])]
fn fguv_32x32_422_16bpc_neon(
    dst: &mut [u16],
    src: &[u16],
    stride: usize,
    scaling: &[u8],
    data: &[u8],
    grain_lut: &[i16],
    luma_row: &[u16],
    luma_stride: usize,
    offsets: &[i32],
    h: usize,
    uv: usize,
    is_id: usize,
    ty: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("filmgrain16.S", dst.as_mut_ptr(), src.as_ptr(), stride, scaling.as_ptr(), data.as_ptr(), grain_lut.as_ptr(), luma_row.as_ptr(), luma_stride, offsets.as_ptr(), h, uv, is_id, ty, bitdepth_max,
    [dst.len() * 2 == stride * h, src.len() * 2 == stride * h, stride >= 64, h >= 1, h <= 32, luma_row.len() * 2 == luma_stride * (h * 1), luma_stride >= 64, scaling.len() == 4096, data.len() == 224, grain_lut.len() == 82 * 74, offsets.len() == 4, offsets[0] >= 0, offsets[0] <= 255, offsets[1] >= 0, offsets[1] <= 255, offsets[2] >= 0, offsets[2] <= 255, offsets[3] >= 0, offsets[3] <= 255, uv <= 1, is_id <= 1, ty <= 7])]
fn fguv_32x32_444_16bpc_neon(
    dst: &mut [u16],
    src: &[u16],
    stride: usize,
    scaling: &[u8],
    data: &[u8],
    grain_lut: &[i16],
    luma_row: &[u16],
    luma_stride: usize,
    offsets: &[i32],
    h: usize,
    uv: usize,
    is_id: usize,
    ty: usize,
    bitdepth_max: i32,
);
