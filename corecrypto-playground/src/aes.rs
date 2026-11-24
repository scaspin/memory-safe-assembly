
#[bums_macros::check_mem_safe("encrypt.S", input.as_ptr(), output.as_mut_ptr(), key as *const _, [key.1 >= 160, key.1 <= 224, key.1 % 32 == 0])]
fn AccelerateCrypto_AES_encrypt(input: &[u8; 16], output: &mut [u8; 16], key: &([u32; 60], u32)) -> i32;

#[bums_macros::check_mem_safe("decrypt.S", input.as_ptr(), output.as_mut_ptr(), key as *const _, [key.1 >= 160, key.1 <= 224, key.1 % 32 == 0])]
fn AccelerateCrypto_AES_decrypt(input: &[u8; 16], output: &mut [u8; 16], key: &([u32; 60], u32)) -> i32;

#[bums_macros::check_mem_safe("encrypt_ecb.S", key as *const _, nblocks, input.as_ptr(), output.as_mut_ptr(), [key.1 >= 160, key.1 <= 224, key.1 % 32 == 0, nblocks <= 4294967295, input.len() == 16 * nblocks, output.len() == input.len()])]
fn AccelerateCrypto_ecb_AES_encrypt(key: &([u32; 60], u32), nblocks: usize, input: &[u8], output: &mut [u8]) -> i32;

#[bums_macros::check_mem_safe("decrypt_ecb.S", key as *const _, nblocks, input.as_ptr(), output.as_mut_ptr(), [key.1 >= 160, key.1 <= 224, key.1 % 32 == 0, nblocks <= 4294967295, input.len() == 16 * nblocks, output.len() == input.len()])]
fn AccelerateCrypto_ecb_AES_decrypt(key: &([u32; 60], u32), nblocks: usize, input: &[u8], output: &mut [u8]) -> i32;

#[bums_macros::check_mem_safe("aes_key_schedule.S", ecb, ctx as *mut _, rawkey.len(), rawkey.as_ptr())]
fn ccaes_arm_encrypt_key(ecb: u64, ctx: &mut ([u32; 60], u32), rawkey: &[u8]) -> i32;

#[bums_macros::check_mem_safe("aes_key_schedule.S", red_zone = 128, ecb, ctx as *mut _, rawkey.len(), rawkey.as_ptr())]
fn ccaes_arm_decrypt_key(ecb: u64, ctx: &mut ([u32; 60], u32), rawkey: &[u8]) -> i32;
