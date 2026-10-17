use bums_macros as bums;

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, out.len() == 4, input.len() == 4])]
fn ff_tx_fft2_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize);

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, out.len() == 8, input.len() == 8])]
fn ff_tx_fft4_fwd_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize);

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, out.len() == 8, input.len() == 8])]
fn ff_tx_fft4_inv_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize);

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, s[1] == map.as_ptr(), map.len() == 8, map[..] >= 0, map[..] < 8,
     out.len() == 16, input.len() == 16])]
fn ff_tx_fft8_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize, map: &[i32]);

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, s[1] == map.as_ptr(), map.len() == 8, map[..] >= 0, map[..] < 8,
     out.len() == 16, input.len() == 16])]
fn ff_tx_fft8_ns_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize, map: &[i32]);

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, s[1] == map.as_ptr(), map.len() == 16, map[..] >= 0, map[..] < 16,
     out.len() == 32, input.len() == 32])]
fn ff_tx_fft16_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize, map: &[i32]);

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, s[1] == map.as_ptr(), map.len() == 16, map[..] >= 0, map[..] < 16,
     out.len() == 32, input.len() == 32])]
fn ff_tx_fft16_ns_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize, map: &[i32]);

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, s[1] == map.as_ptr(), map.len() == 32, map[..] >= 0, map[..] < 32,
     out.len() == 64, input.len() == 64])]
fn ff_tx_fft32_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize, map: &[i32]);

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, s[1] == map.as_ptr(), map.len() == 32, map[..] >= 0, map[..] < 32,
     out.len() == 64, input.len() == 64])]
fn ff_tx_fft32_ns_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize, map: &[i32]);

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, s[1] == map.as_ptr(), map.len() == 15, map[..] >= 0, map[..] < 15,
     out.len() == 14 * stride / 4 + 2, stride % 8 == 0, stride >= 8, stride <= 1048576, input.len() == 30])]
fn ff_tx_fft15_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize, map: &[i32]);

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, s[1] == map.as_ptr(), map.len() == 15, map[..] >= 0, map[..] < 15,
     out.len() == 14 * stride / 4 + 2, stride % 8 == 0, stride >= 8, stride <= 1048576, input.len() == 30])]
fn ff_tx_fft15_ns_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize, map: &[i32]);

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, s[0] == len as u32, s[1] == map.as_ptr(), map.len() == len, map[..] >= 0, map[..] < len as i32,
     out.len() == 2 * len, input.len() == 2 * len,
     (len - 32) * (len - 64) * (len - 128) * (len - 256) * (len - 512) * (len - 1024) * (len - 2048) * (len - 4096) == 0])]
fn ff_tx_fft_sr_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize, map: &[i32], len: usize);

#[bums::check_mem_safe("tx_float_neon.S", s.as_ptr(), out.as_mut_ptr(), input.as_ptr(), stride,
    [s.len() == 18, s[0] == len as u32, s[1] == map.as_ptr(), map.len() == len, map[..] >= 0, map[..] < len as i32,
     out.len() == 2 * len, input.len() == 2 * len,
     (len - 32) * (len - 64) * (len - 128) * (len - 256) * (len - 512) * (len - 1024) * (len - 2048) * (len - 4096) == 0])]
fn ff_tx_fft_sr_ns_float_neon(s: &[u32], out: &mut [f32], input: &[f32], stride: usize, map: &[i32], len: usize);

