#![allow(dead_code, non_snake_case, unused_imports)]

#[bums_macros::check_mem_safe("aesv8-armx.S", input.as_ptr(), output.as_mut_ptr(), input.len(), keys as *const _, ivec.as_mut_ptr(), enc, [keys.1 >= 10, keys.1 <= 14, keys.1 % 2 == 0, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aes_hw_cbc_encrypt(
    input: &[u8],
    output: &mut [u8],
    keys: &([u32; 60], u32),
    ivec: &mut [u8; 16],
    enc: i64,
);
