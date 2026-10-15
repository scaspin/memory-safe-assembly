#[cfg_attr(target_arch = "aarch64", bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr()))]
#[cfg_attr(target_arch = "x86_64", bums_macros::check_mem_safe("p256-x86_64-asm.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr()))]
fn ecp_nistz256_mul_mont(res: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[cfg_attr(target_arch = "aarch64", bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr()))]
#[cfg_attr(target_arch = "x86_64", bums_macros::check_mem_safe("p256-x86_64-asm.S", res.as_mut_ptr(), a.as_ptr()))]
fn ecp_nistz256_sqr_mont(res: &mut [u64; 4], a: &[u64; 4]);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_div_by_2(res: &mut [u64; 4], a: &[u64; 4]);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_mul_by_2(res: &mut [u64; 4], a: &[u64; 4]);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_mul_by_3(res: &mut [u64; 4], a: &[u64; 4]);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_sub(res: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[cfg_attr(target_arch = "aarch64", bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr()))]
#[cfg_attr(target_arch = "x86_64", bums_macros::check_mem_safe("p256-x86_64-asm.S", res.as_mut_ptr(), a.as_ptr()))]
fn ecp_nistz256_neg(res: &mut [u64; 4], a: &[u64; 4]);

#[cfg_attr(target_arch = "aarch64", bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr()))]
#[cfg_attr(target_arch = "x86_64", bums_macros::check_mem_safe("p256-x86_64-asm.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr()))]
fn ecp_nistz256_ord_mul_mont(res: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr(), rep, [rep >= 1, rep <= 256])]
fn ecp_nistz256_ord_sqr_mont(res: &mut [u64; 4], a: &[u64; 4], rep: usize);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_point_double(res: &mut [u64; 12], a: &[u64; 12]);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_point_add(res: &mut [u64; 12], a: &[u64; 12], b: &[u64; 12]);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_point_add_affine(res: &mut [u64; 12], a: &[u64; 12], b: &[u64; 8]);

#[cfg_attr(target_arch = "aarch64", bums_macros::check_mem_safe("p256-armv8-asm.S", val.as_mut_ptr(), in_t.as_ptr(), index, [index >= 0, index <= 16]))]
#[cfg_attr(target_arch = "x86_64", bums_macros::check_mem_safe("p256-x86_64-asm.S", val.as_mut_ptr(), in_t.as_ptr(), index))]
fn ecp_nistz256_select_w5(val: &mut [u64; 12], in_t: &[u64; 192], index: usize);

#[cfg_attr(target_arch = "aarch64", bums_macros::check_mem_safe("p256-armv8-asm.S", val.as_mut_ptr(), in_t.as_ptr(), index, [index >= 0, index <= 64]))]
#[cfg_attr(target_arch = "x86_64", bums_macros::check_mem_safe("p256-x86_64-asm.S", val.as_mut_ptr(), in_t.as_ptr(), index))]
fn ecp_nistz256_select_w7(val: &mut [u64; 8], in_t: &[u64; 512], index: usize);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("p256_beeu-armv8-asm.S", out.as_mut_ptr(), a.as_ptr(), n.as_ptr())]
fn beeu_mod_inverse_vartime(out: &mut [u64; 4], a: &[u64; 4], n: &[u64; 4]) -> bool;
