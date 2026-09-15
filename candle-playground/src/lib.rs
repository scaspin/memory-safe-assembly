#![allow(dead_code)]

use bums_macros as bums;

#[bums::check_mem_safe("candle_vec_add_f16.S", a_row.as_ptr(), b_row.as_ptr(), c.as_mut_ptr(), a_row.len(), [a_row.len() == b_row.len(), a_row.len() == c.len()])]
fn candle_vec_add_f16(a_row: &[u16], b_row: &[u16], c: &mut [u16]);

#[bums::check_mem_safe("candle_vec_dot_f16.S", a_row.as_ptr(), b_row.as_ptr(), c.as_mut_ptr(), a_row.len(), [a_row.len() == b_row.len()])]
fn candle_vec_dot_f16(a_row: &[u16], b_row: &[u16], c: &mut [u32; 1]);

#[bums::check_mem_safe("candle_f16_vec_reduce.S", x.as_ptr(), y.as_mut_ptr())]
fn candle_f16_vec_reduce(x: &[u64; 8], y: &mut [u32; 1]);

#[bums::check_mem_safe("candle_f16_vecops_vec_add.S", lhs.as_ptr(), lhs.len(), rhs.as_ptr(), rhs.len(), res.as_mut_ptr(), res.len(), [lhs.len() == rhs.len(), lhs.len() == res.len()])]
fn candle_f16_vecops_vec_add(lhs: &[u16], rhs: &[u16], res: &mut [u16]);

#[bums::check_mem_safe("candle_f16_vec_dot.S", n, xs.as_ptr(), xs.len(), ys.as_ptr(), ys.len(), [n <= xs.len(), n <= ys.len()])]
fn candle_f16_vec_dot(n: usize, xs: &[u16], ys: &[u16]) -> f32;

#[bums::check_mem_safe("candle_q2k_vec_dot.S", n, xs.as_ptr(), xs.len() / 84, ys.as_ptr(), ys.len() / 292, [xs.len() % 84 == 0, ys.len() % 292 == 0])]
fn candle_q2k_vec_dot(n: usize, xs: &[u8], ys: &[u8]) -> f32;

#[bums::check_mem_safe("candle_q3k_vec_dot.S", n, xs.as_ptr(), xs.len() / 110, ys.as_ptr(), ys.len() / 292, [xs.len() % 110 == 0, ys.len() % 292 == 0])]
fn candle_q3k_vec_dot(n: usize, xs: &[u8], ys: &[u8]) -> f32;

#[bums::check_mem_safe("candle_q4k_vec_dot.S", n, xs.as_ptr(), xs.len() / 144, ys.as_ptr(), ys.len() / 292, [xs.len() % 144 == 0, ys.len() % 292 == 0])]
fn candle_q4k_vec_dot(n: usize, xs: &[u8], ys: &[u8]) -> f32;

#[bums::check_mem_safe("candle_q5k_vec_dot.S", n, xs.as_ptr(), xs.len() / 176, ys.as_ptr(), ys.len() / 292, [xs.len() % 176 == 0, ys.len() % 292 == 0])]
fn candle_q5k_vec_dot(n: usize, xs: &[u8], ys: &[u8]) -> f32;

#[bums::check_mem_safe("candle_q6k_vec_dot.S", n, xs.as_ptr(), xs.len() / 210, ys.as_ptr(), ys.len() / 292, [xs.len() % 210 == 0, ys.len() % 292 == 0])]
fn candle_q6k_vec_dot(n: usize, xs: &[u8], ys: &[u8]) -> f32;

#[bums::check_mem_safe("candle_q8k_vec_dot.S", n, xs.as_ptr(), xs.len() / 292, ys.as_ptr(), ys.len() / 292, [xs.len() % 292 == 0, ys.len() % 292 == 0])]
fn candle_q8k_vec_dot(n: usize, xs: &[u8], ys: &[u8]) -> f32;

#[bums::check_mem_safe("candle_q4k_vec_dot_4.S", n, xs0.as_ptr(), xs0.len() / 144, xs1.as_ptr(), xs1.len() / 144, xs2.as_ptr(), xs2.len() / 144, xs3.as_ptr(), xs3.len() / 144, ys.as_ptr(), ys.len() / 292, [xs0.len() % 144 == 0, xs1.len() % 144 == 0, xs2.len() % 144 == 0, xs3.len() % 144 == 0, ys.len() % 292 == 0])]
fn candle_q4k_vec_dot_4(n: usize, xs0: &[u8], xs1: &[u8], xs2: &[u8], xs3: &[u8], ys: &[u8]) -> [u32; 4];

#[bums::check_mem_safe("candle_q6k_vec_dot_4.S", n, xs0.as_ptr(), xs0.len() / 210, xs1.as_ptr(), xs1.len() / 210, xs2.as_ptr(), xs2.len() / 210, xs3.as_ptr(), xs3.len() / 210, ys.as_ptr(), ys.len() / 292, [xs0.len() % 210 == 0, xs1.len() % 210 == 0, xs2.len() % 210 == 0, xs3.len() % 210 == 0, ys.len() % 292 == 0])]
fn candle_q6k_vec_dot_4(n: usize, xs0: &[u8], xs1: &[u8], xs2: &[u8], xs3: &[u8], ys: &[u8]) -> [u32; 4];

#[bums::check_mem_safe("candle_q4_0_vec_dot.S", n, xs.as_ptr(), xs.len() / 18, ys.as_ptr(), ys.len() / 34, [xs.len() % 18 == 0, ys.len() % 34 == 0])]
fn candle_q4_0_vec_dot(n: usize, xs: &[u8], ys: &[u8]) -> f32;

#[bums::check_mem_safe("candle_q8_0_vec_dot.S", n, xs.as_ptr(), xs.len() / 34, ys.as_ptr(), ys.len() / 34, [xs.len() % 34 == 0, ys.len() % 34 == 0])]
fn candle_q8_0_vec_dot(n: usize, xs: &[u8], ys: &[u8]) -> f32;
