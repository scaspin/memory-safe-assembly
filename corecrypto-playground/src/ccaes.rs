
#[bums_macros::check_mem_safe("aesencbc.S", key as *const _, iv.as_mut_ptr(), nblocks, input.as_ptr(), output.as_mut_ptr(), [input.len() == 16 * nblocks, output.len() == input.len()])]
fn ccaes_arm_encrypt_cbc(key: &([u32; 60], u32), iv: &mut [u8; 16], nblocks: usize, input: &[u8], output: &mut [u8]) -> i32;

#[bums_macros::check_mem_safe("aesdecbc.S", key as *const _, iv.as_mut_ptr(), nblocks, input.as_ptr(), output.as_mut_ptr(), [input.len() == 16 * nblocks, output.len() == input.len()])]
fn ccaes_arm_decrypt_cbc(key: &([u32; 60], u32), iv: &mut [u8; 16], nblocks: usize, input: &[u8], output: &mut [u8]) -> i32;

#[bums_macros::check_mem_safe("cfb-encrypt-arm64.S", key as *const _, iv.as_mut_ptr(), nblocks, input.as_ptr(), output.as_mut_ptr(), [input.len() == 16 * nblocks, output.len() == input.len()])]
fn ccaes_cfb_encrypt_vng_vector(key: &([u32; 60], u32), iv: &mut [u8; 16], nblocks: usize, input: &[u8], output: &mut [u8]);

#[bums_macros::check_mem_safe("cfb-decrypt-arm64.S", key as *const _, iv.as_mut_ptr(), nblocks, input.as_ptr(), output.as_mut_ptr(), [input.len() == 16 * nblocks, output.len() == input.len()])]
fn ccaes_cfb_decrypt_vng_vector(key: &([u32; 60], u32), iv: &mut [u8; 16], nblocks: usize, input: &[u8], output: &mut [u8]);

#[bums_macros::check_mem_safe("ofb-crypt-arm64.S", key as *const _, iv.as_mut_ptr(), nblocks, input.as_ptr(), output.as_mut_ptr(), [input.len() == 16 * nblocks, output.len() == input.len()])]
fn ccaes_ofb_crypt_vng_vector(key: &([u32; 60], u32), iv: &mut [u8; 16], nblocks: usize, input: &[u8], output: &mut [u8]);

#[bums_macros::check_mem_safe("ctr-arm64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), ctr.as_mut_ptr(), key as *const _, [output.len() == input.len(), key.1 >= 160, key.1 <= 224, key.1 % 32 == 0])]
fn aes_ctr_crypt(input: &[u8], output: &mut [u8], ctr: &mut [u8; 16], key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("ccaes_arm_xts_encrypt.S", output.as_mut_ptr(), input.as_ptr(), tweak.as_mut_ptr(), nblocks, key as *const _, [input.len() == 16 * nblocks, output.len() == input.len(), key.1 >= 160, key.1 <= 224, key.1 % 32 == 0])]
fn ccaes_xts_encrypt_vng_vector(output: &mut [u8], input: &[u8], tweak: &mut [u64; 2], nblocks: usize, key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("ccaes_arm_xts_decrypt.S", output.as_mut_ptr(), input.as_ptr(), tweak.as_mut_ptr(), nblocks, key as *const _, [input.len() == 16 * nblocks, output.len() == input.len(), key.1 >= 160, key.1 <= 224, key.1 % 32 == 0])]
fn ccaes_xts_decrypt_vng_vector(output: &mut [u8], input: &[u8], tweak: &mut [u64; 2], nblocks: usize, key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("ccm-encrypt.S", input.as_ptr(), output.as_mut_ptr(), tag.as_mut_ptr(), nblocks, key as *const _, ctr.as_mut_ptr(), ctr_len, [input.len() == 16 * nblocks, output.len() == input.len(), nblocks >= 1, ctr_len >= 2, ctr_len <= 8])]
fn ccm128_encrypt(input: &[u8], output: &mut [u8], tag: &mut [u8; 16], nblocks: usize, key: &([u32; 60], u32), ctr: &mut [u8; 16], ctr_len: usize);

#[bums_macros::check_mem_safe("ccm-encrypt.S", input.as_ptr(), output.as_mut_ptr(), tag.as_mut_ptr(), nblocks, key as *const _, ctr.as_mut_ptr(), ctr_len, [input.len() == 16 * nblocks, output.len() == input.len(), nblocks >= 1, ctr_len >= 2, ctr_len <= 8])]
fn ccm192_encrypt(input: &[u8], output: &mut [u8], tag: &mut [u8; 16], nblocks: usize, key: &([u32; 60], u32), ctr: &mut [u8; 16], ctr_len: usize);

#[bums_macros::check_mem_safe("ccm-encrypt.S", input.as_ptr(), output.as_mut_ptr(), tag.as_mut_ptr(), nblocks, key as *const _, ctr.as_mut_ptr(), ctr_len, [input.len() == 16 * nblocks, output.len() == input.len(), nblocks >= 1, ctr_len >= 2, ctr_len <= 8])]
fn ccm256_encrypt(input: &[u8], output: &mut [u8], tag: &mut [u8; 16], nblocks: usize, key: &([u32; 60], u32), ctr: &mut [u8; 16], ctr_len: usize);

#[bums_macros::check_mem_safe("ccm-decrypt.S", input.as_ptr(), output.as_mut_ptr(), tag.as_mut_ptr(), nblocks, key as *const _, ctr.as_mut_ptr(), ctr_len, [input.len() == 16 * nblocks, output.len() == input.len(), nblocks >= 1, ctr_len >= 2, ctr_len <= 8])]
fn ccm128_decrypt(input: &[u8], output: &mut [u8], tag: &mut [u8; 16], nblocks: usize, key: &([u32; 60], u32), ctr: &mut [u8; 16], ctr_len: usize);

#[bums_macros::check_mem_safe("ccm-decrypt.S", input.as_ptr(), output.as_mut_ptr(), tag.as_mut_ptr(), nblocks, key as *const _, ctr.as_mut_ptr(), ctr_len, [input.len() == 16 * nblocks, output.len() == input.len(), nblocks >= 1, ctr_len >= 2, ctr_len <= 8])]
fn ccm192_decrypt(input: &[u8], output: &mut [u8], tag: &mut [u8; 16], nblocks: usize, key: &([u32; 60], u32), ctr: &mut [u8; 16], ctr_len: usize);

#[bums_macros::check_mem_safe("ccm-decrypt.S", input.as_ptr(), output.as_mut_ptr(), tag.as_mut_ptr(), nblocks, key as *const _, ctr.as_mut_ptr(), ctr_len, [input.len() == 16 * nblocks, output.len() == input.len(), nblocks >= 1, ctr_len >= 2, ctr_len <= 8])]
fn ccm256_decrypt(input: &[u8], output: &mut [u8], tag: &mut [u8; 16], nblocks: usize, key: &([u32; 60], u32), ctr: &mut [u8; 16], ctr_len: usize);

#[bums_macros::check_mem_safe("ghash-arm64.S", htable.as_mut_ptr(), h.as_ptr())]
fn gcm_init(htable: &mut [u8; 256], h: &[u8; 16]);

#[bums_macros::check_mem_safe("ghash-arm64.S", x.as_ptr(), htable.as_ptr(), output.as_mut_ptr())]
fn gcm_gmult(x: &[u8; 16], htable: &[u8; 256], output: &mut [u8; 16]);

#[bums_macros::check_mem_safe("ghash-arm64.S", x.as_mut_ptr(), htable.as_ptr(), input.as_ptr(), input.len())]
fn gcm_ghash(x: &mut [u8; 16], htable: &[u8; 256], input: &[u8]);

#[bums_macros::check_mem_safe("gcm-arm64.S", input.as_ptr(), output.as_mut_ptr(), gcm.as_mut_ptr(), input.len(), htable.as_ptr(), key as *const _, [output.len() == input.len(), key.1 >= 160, key.1 <= 224, key.1 % 32 == 0])]
fn gcmEncrypt(input: &[u8], output: &mut [u8], gcm: &mut [u8; 48], htable: &[u8; 256], key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("gcm-arm64.S", input.as_ptr(), output.as_mut_ptr(), gcm.as_mut_ptr(), input.len(), htable.as_ptr(), key as *const _, [output.len() == input.len(), key.1 >= 160, key.1 <= 224, key.1 % 32 == 0])]
fn gcmDecrypt(input: &[u8], output: &mut [u8], gcm: &mut [u8; 48], htable: &[u8; 256], key: &([u32; 60], u32));
