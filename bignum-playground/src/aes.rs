#[bums_macros::check_mem_safe("aes-xts-dec.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 >= 10, key1.1 <= 14, key1.1 % 2 == 0, key2.1 >= 10, key2.1 <= 14, key2.1 % 2 == 0, input.len() >= 16, input.len() == output.len()])]
fn aes_hw_xts_decrypt(
    input: &[u8],
    output: &mut [u8],
    key1: &([u32; 60], u32),
    key2: &([u32; 60], u32),
    iv: &[u8; 16],
);

#[bums_macros::check_mem_safe("aes-xts-enc.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 >= 10, key1.1 <= 14, key1.1 % 2 == 0, key2.1 >= 10, key2.1 <= 14, key2.1 % 2 == 0, input.len() >= 16, input.len() == output.len()])]
fn aes_hw_xts_encrypt(
    input: &[u8],
    output: &mut [u8],
    key1: &([u32; 60], u32),
    key2: &([u32; 60], u32),
    iv: &[u8; 16],
);
