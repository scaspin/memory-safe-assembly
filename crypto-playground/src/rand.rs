#![allow(non_snake_case)]

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("rndr-armv8.S", out.as_mut_ptr(), out.len(), [out.len() >= 8, out.len() % 8 == 0])]
fn CRYPTO_rndr_multiple8(out: &mut [u8]) -> i32;
