#![allow(dead_code, non_snake_case)]

#[bums_macros::check_mem_safe("rdrand-x86_64.S", buf.as_mut_ptr(), buf.len(), [buf.len() % 8 == 0])]
fn CRYPTO_rdrand_multiple8(buf: &mut [u8]) -> i32;

#[bums_macros::check_mem_safe("aesni-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), keys as *const _, enc, [keys.1 >= 9, keys.1 <= 13, keys.1 % 2 == 1, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aes_hw_ecb_encrypt(input: &[u8], output: &mut [u8], keys: &([u32; 60], u32), enc: i32);

#[bums_macros::check_mem_safe("ghash-ssse3-x86_64.S", context.as_mut_ptr(), h.as_ptr())]
fn gcm_gmult_ssse3(context: &mut [u8; 16], h: &[u128; 16]);

#[bums_macros::check_mem_safe("ghash-ssse3-x86_64.S", context.as_mut_ptr(), h.as_ptr(), buf.as_ptr(), buf.len(), [buf.len() >= 16, buf.len() % 16 == 0])]
fn gcm_ghash_ssse3(context: &mut [u8; 16], h: &[u128; 16], buf: &[u8]);

#[bums_macros::check_mem_safe("ghash-x86_64.S", htable.as_mut_ptr(), h.as_ptr())]
fn gcm_init_avx(htable: &mut [u128; 16], h: &[u64; 2]);

#[bums_macros::check_mem_safe("ghash-x86_64.S", context.as_mut_ptr(), h.as_ptr())]
fn gcm_gmult_avx(context: &mut [u8; 16], h: &[u128; 16]);

#[bums_macros::check_mem_safe("ghash-x86_64.S", context.as_mut_ptr(), h.as_ptr(), buf.as_ptr(), buf.len(), [buf.len() >= 16, buf.len() % 16 == 0])]
fn gcm_ghash_avx(context: &mut [u8; 16], h: &[u128; 16], buf: &[u8]);

#[bums_macros::check_mem_safe("sha1-x86_64.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64])]
fn sha1_block_data_order_ssse3(context: &mut [u32; 5], input: &[u8]);

#[bums_macros::check_mem_safe("sha1-x86_64.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64])]
fn sha1_block_data_order_avx(context: &mut [u32; 5], input: &[u8]);

#[bums_macros::check_mem_safe("sha1-x86_64.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64])]
fn sha1_block_data_order_avx2(context: &mut [u32; 5], input: &[u8]);

#[bums_macros::check_mem_safe("sha256-x86_64.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64])]
fn sha256_block_data_order_ssse3(context: &mut [u32; 8], input: &[u8]);

#[bums_macros::check_mem_safe("sha256-x86_64.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64])]
fn sha256_block_data_order_avx(context: &mut [u32; 8], input: &[u8]);

#[bums_macros::check_mem_safe("sha512-x86_64.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 128, [input.len() >= 128, input.len() % 128 == 0])]
fn sha512_block_data_order_avx(context: &mut [u64; 8], input: &[u8]);
