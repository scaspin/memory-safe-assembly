#![allow(dead_code)]

use bums_macros as bums;

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("dsum_k.S", n, x.as_ptr(), inc_x, [inc_x >= 1, n * inc_x <= x.len()])]
fn dsum_k(n: usize, x: &[u64], inc_x: usize) -> f64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("dasum_k.S", n, x.as_ptr(), inc_x, [inc_x >= 1, n * inc_x <= x.len()]))]
#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("dasum_k-x86_64.S", n, x.as_ptr(), inc_x, [n >= 1, inc_x >= 1, n * inc_x <= x.len()]))]
fn dasum_k(n: usize, x: &[u64], inc_x: usize) -> f64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("damax_k.S", n, x.as_ptr(), inc_x, [inc_x >= 1, n * inc_x <= x.len()]))]
#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("damax_k-x86_64.S", n, x.as_ptr(), inc_x, [n >= 1, inc_x >= 1, n * inc_x <= x.len()]))]
fn damax_k(n: usize, x: &[u64], inc_x: usize) -> f64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("dmax_k.S", n, x.as_ptr(), inc_x, [inc_x >= 1, n * inc_x <= x.len()]))]
#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("dmax_k-x86_64.S", n, x.as_ptr(), inc_x, [n >= 1, inc_x >= 1, n * inc_x <= x.len()]))]
fn dmax_k(n: usize, x: &[u64], inc_x: usize) -> f64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("idamax_k.S", n, x.as_ptr(), inc_x, [inc_x >= 1, n * inc_x <= x.len()]))]
#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("idamax_k-x86_64.S", n, x.as_ptr(), inc_x, [n >= 1, inc_x >= 1, n * inc_x <= x.len()]))]
fn idamax_k(n: usize, x: &[u64], inc_x: usize) -> usize;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("dnrm2_k.S", n, x.as_ptr(), inc_x, [inc_x >= 1, n * inc_x <= x.len()]))]
#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("dnrm2_k-x86_64.S", n, x.as_ptr(), inc_x, [n >= 1, inc_x >= 1, n * inc_x <= x.len()]))]
fn dnrm2_k(n: usize, x: &[u64], inc_x: usize) -> f64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("zasum_k.S", n, x.as_ptr(), inc_x, [inc_x >= 1, 2 * n * inc_x <= x.len()]))]
#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zasum_k-x86_64.S", n, x.as_ptr(), inc_x, [n >= 1, inc_x >= 1, 2 * n * inc_x <= x.len()]))]
fn zasum_k(n: usize, x: &[u64], inc_x: usize) -> f64;

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("ddot_k.S", n, x.as_ptr(), inc_x, y.as_ptr(), inc_y, [inc_x >= 1, n * inc_x <= x.len(), inc_y >= 1, n * inc_y <= y.len()])]
fn ddot_k(n: usize, x: &[u64], inc_x: usize, y: &[u64], inc_y: usize) -> f64;

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("sdot_k.S", n, x.as_ptr(), inc_x, y.as_ptr(), inc_y, [inc_x >= 1, n * inc_x <= x.len(), inc_y >= 1, n * inc_y <= y.len()])]
fn sdot_k(n: usize, x: &[u32], inc_x: usize, y: &[u32], inc_y: usize) -> f32;

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("zdotu_k.S", n, x.as_ptr(), inc_x, y.as_ptr(), inc_y, [inc_x >= 1, 2 * n * inc_x <= x.len(), inc_y >= 1, 2 * n * inc_y <= y.len()])]
fn zdotu_k(n: usize, x: &[u64], inc_x: usize, y: &[u64], inc_y: usize) -> f64;

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("dcopy_k.S", n, x.as_ptr(), inc_x, y.as_mut_ptr(), inc_y, [inc_x >= 1, n * inc_x <= x.len(), inc_y >= 1, n * inc_y <= y.len()])]
fn dcopy_k(n: usize, x: &[u64], inc_x: usize, y: &mut [u64], inc_y: usize);

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("drot_k.S", n, x.as_mut_ptr(), inc_x, y.as_mut_ptr(), inc_y, [inc_x >= 1, n * inc_x <= x.len(), inc_y >= 1, n * inc_y <= y.len()])]
fn drot_k(n: usize, x: &mut [u64], inc_x: usize, y: &mut [u64], inc_y: usize);

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("daxpy_k.S", n, 0, 0, x.as_ptr(), inc_x, y.as_mut_ptr(), inc_y, 0, 0, [inc_x >= 1, n * inc_x <= x.len(), inc_y >= 1, n * inc_y <= y.len()])]
fn daxpy_k(n: usize, x: &[u64], inc_x: usize, y: &mut [u64], inc_y: usize);

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("saxpy_k.S", n, 0, 0, x.as_ptr(), inc_x, y.as_mut_ptr(), inc_y, 0, 0, [inc_x >= 1, n * inc_x <= x.len(), inc_y >= 1, n * inc_y <= y.len()])]
fn saxpy_k(n: usize, x: &[u32], inc_x: usize, y: &mut [u32], inc_y: usize);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("zaxpy_k.S", n, 0, 0, x.as_ptr(), inc_x, y.as_mut_ptr(), inc_y, 0, 0, [inc_x >= 1, 2 * n * inc_x <= x.len(), inc_y >= 1, 2 * n * inc_y <= y.len()]))]
#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zaxpy_k-x86_64.S", n, 0, 0, x.as_ptr(), inc_x, y.as_mut_ptr(), inc_y, 0, 0, [n >= 1, inc_x >= 1, 2 * n * inc_x <= x.len(), inc_y >= 1, 2 * n * inc_y <= y.len()]))]
fn zaxpy_k(n: usize, x: &[u64], inc_x: usize, y: &mut [u64], inc_y: usize);

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("dswap_k.S", n, 0, 0, x.as_mut_ptr(), inc_x, y.as_mut_ptr(), inc_y, 0, 0, [inc_x >= 1, n * inc_x <= x.len(), inc_y >= 1, n * inc_y <= y.len()])]
fn dswap_k(n: usize, x: &mut [u64], inc_x: usize, y: &mut [u64], inc_y: usize);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("dscal_k.S", n, 0, 0, x.as_mut_ptr(), inc_x, 0, 0, 0, flag, [inc_x >= 1, n * inc_x <= x.len()]))]
#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("dscal_k-x86_64.S", n, 0, 0, x.as_mut_ptr(), inc_x, 0, 0, 0, flag, [n >= 1, inc_x >= 1, n * inc_x <= x.len()]))]
fn dscal_k(n: usize, x: &mut [u64], inc_x: usize, flag: usize);

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("zscal_k.S", n, 0, 0, x.as_mut_ptr(), inc_x, 0, 0, 0, flag, [inc_x >= 1, 2 * n * inc_x <= x.len()])]
fn zscal_k(n: usize, x: &mut [u64], inc_x: usize, flag: usize);
