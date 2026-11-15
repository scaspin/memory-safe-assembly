#[bums_macros::check_mem_safe("arm64cpuid.S", buf.as_mut_ptr(), buf.len())]
fn OPENSSL_cleanse(buf: &mut [u8]);

#[bums_macros::check_mem_safe("arm64cpuid.S", a.as_ptr(), b.as_ptr(), a.len(), [a.len() == b.len()])]
fn CRYPTO_memcmp(a: &[u8], b: &[u8]) -> i32;

#[bums_macros::check_mem_safe("arm64cpuid.S", buf.as_mut_ptr(), buf.len())]
fn OPENSSL_rndr_asm(buf: &mut [u8]) -> usize;

#[bums_macros::check_mem_safe("arm64cpuid.S", buf.as_mut_ptr(), buf.len())]
fn OPENSSL_rndrrs_asm(buf: &mut [u8]) -> usize;

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv7_tick() -> u32;

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_cpuid_probe() -> u32;

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_sve_get_vl_bytes() -> u64;

#[bums_macros::check_mem_safe("aesv8-armx.S", user_key.as_ptr(), bits, key as *mut _, [bits == 128 || bits == 192 || bits == 256, user_key.len() * 8 == bits])]
fn aes_v8_set_encrypt_key(user_key: &[u8], bits: i32, key: &mut ([u32; 60], u32)) -> i32;

#[bums_macros::check_mem_safe("aesv8-armx.S", user_key.as_ptr(), bits, key as *mut _, [bits == 128 || bits == 192 || bits == 256, user_key.len() * 8 == bits])]
fn aes_v8_set_decrypt_key(user_key: &[u8], bits: i32, key: &mut ([u32; 60], u32)) -> i32;

#[bums_macros::check_mem_safe("aesv8-armx.S", input.as_ptr(), output.as_mut_ptr(), key as *const _, [key.1 == 10 || key.1 == 12 || key.1 == 14])]
fn aes_v8_encrypt(input: &[u8; 16], output: &mut [u8; 16], key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("aesv8-armx.S", input.as_ptr(), output.as_mut_ptr(), key as *const _, [key.1 == 10 || key.1 == 12 || key.1 == 14])]
fn aes_v8_decrypt(input: &[u8; 16], output: &mut [u8; 16], key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("aesv8-armx.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, enc, [key.1 == 10 || key.1 == 12 || key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aes_v8_ecb_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), enc: i32);

#[bums_macros::check_mem_safe("aesv8-armx.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, ivec.as_mut_ptr(), enc, [key.1 == 10 || key.1 == 12 || key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aes_v8_cbc_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("aesv8-armx.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 16, key as *const _, ivec.as_ptr(), [key.1 == 10 || key.1 == 12 || key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aes_v8_ctr32_encrypt_blocks(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &[u8; 16]);

#[bums_macros::check_mem_safe("aesv8-armx.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 16, key as *const _, ivec.as_ptr(), [key.1 == 10 || key.1 == 12 || key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aes_v8_ctr32_encrypt_blocks_unroll12_eor3(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &[u8; 16]);

#[bums_macros::check_mem_safe("aesv8-armx.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 == 10 || key1.1 == 14, key2.1 == key1.1, input.len() >= 16, input.len() == output.len()])]
fn aes_v8_xts_encrypt(input: &[u8], output: &mut [u8], key1: &([u32; 60], u32), key2: &([u32; 60], u32), iv: &[u8; 16]);

#[bums_macros::check_mem_safe("aesv8-armx.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 == 10 || key1.1 == 14, key2.1 == key1.1, input.len() >= 16, input.len() == output.len()])]
fn aes_v8_xts_decrypt(input: &[u8], output: &mut [u8], key1: &([u32; 60], u32), key2: &([u32; 60], u32), iv: &[u8; 16]);

#[bums_macros::check_mem_safe("aes-gcm-armv8_64.S", input.as_ptr(), input.len() * 8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), key as *const _, [key.1 == 10, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aes_gcm_enc_128_kernel(input: &[u8], output: &mut [u8], xi: &mut [u64; 36], ivec: &mut [u8; 16], key: &([u32; 60], u32)) -> usize;

#[bums_macros::check_mem_safe("aes-gcm-armv8_64.S", input.as_ptr(), input.len() * 8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), key as *const _, [key.1 == 10, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aes_gcm_dec_128_kernel(input: &[u8], output: &mut [u8], xi: &mut [u64; 36], ivec: &mut [u8; 16], key: &([u32; 60], u32)) -> usize;

#[bums_macros::check_mem_safe("aes-gcm-armv8_64.S", input.as_ptr(), input.len() * 8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), key as *const _, [key.1 == 12, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aes_gcm_enc_192_kernel(input: &[u8], output: &mut [u8], xi: &mut [u64; 36], ivec: &mut [u8; 16], key: &([u32; 60], u32)) -> usize;

#[bums_macros::check_mem_safe("aes-gcm-armv8_64.S", input.as_ptr(), input.len() * 8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), key as *const _, [key.1 == 12, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aes_gcm_dec_192_kernel(input: &[u8], output: &mut [u8], xi: &mut [u64; 36], ivec: &mut [u8; 16], key: &([u32; 60], u32)) -> usize;

#[bums_macros::check_mem_safe("aes-gcm-armv8_64.S", input.as_ptr(), input.len() * 8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), key as *const _, [key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aes_gcm_enc_256_kernel(input: &[u8], output: &mut [u8], xi: &mut [u64; 36], ivec: &mut [u8; 16], key: &([u32; 60], u32)) -> usize;

#[bums_macros::check_mem_safe("aes-gcm-armv8_64.S", input.as_ptr(), input.len() * 8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), key as *const _, [key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aes_gcm_dec_256_kernel(input: &[u8], output: &mut [u8], xi: &mut [u64; 36], ivec: &mut [u8; 16], key: &([u32; 60], u32)) -> usize;

#[bums_macros::check_mem_safe("aes-gcm-armv8-unroll8_64.S", input.as_ptr(), input.len() * 8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), key as *const _, [key.1 == 10, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn unroll8_eor3_aes_gcm_enc_128_kernel(input: &[u8], output: &mut [u8], xi: &mut [u64; 36], ivec: &mut [u8; 16], key: &([u32; 60], u32)) -> usize;

#[bums_macros::check_mem_safe("aes-gcm-armv8-unroll8_64.S", input.as_ptr(), input.len() * 8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), key as *const _, [key.1 == 10, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn unroll8_eor3_aes_gcm_dec_128_kernel(input: &[u8], output: &mut [u8], xi: &mut [u64; 36], ivec: &mut [u8; 16], key: &([u32; 60], u32)) -> usize;

#[bums_macros::check_mem_safe("aes-gcm-armv8-unroll8_64.S", input.as_ptr(), input.len() * 8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), key as *const _, [key.1 == 12, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn unroll8_eor3_aes_gcm_enc_192_kernel(input: &[u8], output: &mut [u8], xi: &mut [u64; 36], ivec: &mut [u8; 16], key: &([u32; 60], u32)) -> usize;

#[bums_macros::check_mem_safe("aes-gcm-armv8-unroll8_64.S", input.as_ptr(), input.len() * 8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), key as *const _, [key.1 == 12, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn unroll8_eor3_aes_gcm_dec_192_kernel(input: &[u8], output: &mut [u8], xi: &mut [u64; 36], ivec: &mut [u8; 16], key: &([u32; 60], u32)) -> usize;

#[bums_macros::check_mem_safe("aes-gcm-armv8-unroll8_64.S", input.as_ptr(), input.len() * 8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), key as *const _, [key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn unroll8_eor3_aes_gcm_enc_256_kernel(input: &[u8], output: &mut [u8], xi: &mut [u64; 36], ivec: &mut [u8; 16], key: &([u32; 60], u32)) -> usize;

#[bums_macros::check_mem_safe("aes-gcm-armv8-unroll8_64.S", input.as_ptr(), input.len() * 8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), key as *const _, [key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn unroll8_eor3_aes_gcm_dec_256_kernel(input: &[u8], output: &mut [u8], xi: &mut [u64; 36], ivec: &mut [u8; 16], key: &([u32; 60], u32)) -> usize;

#[bums_macros::check_mem_safe("aes-sha1-armv8.S", csrc.as_ptr(), cdst.as_mut_ptr(), csrc.len(), dsrc.as_ptr(), ddst.as_mut_ptr(), dsrc.len(), arg as *const _, [arg.1 == 10 || arg.1 == 12 || arg.1 == 14, csrc.len() >= 16, csrc.len() % 16 == 0, csrc.len() == cdst.len(), dsrc.len() == csrc.len(), ddst.len() == 20])]
fn asm_aescbc_sha1_hmac(csrc: &[u8], cdst: &mut [u8], dsrc: &[u8], ddst: &mut [u8], arg: &(*const [u32; 60], u8, *const [u8; 16], *const [u32; 5], *const [u32; 5])) -> i32;

#[bums_macros::check_mem_safe("aes-sha1-armv8.S", csrc.as_ptr(), cdst.as_mut_ptr(), csrc.len(), dsrc.as_ptr(), ddst.as_mut_ptr(), dsrc.len(), arg as *const _, [arg.1 == 10 || arg.1 == 12 || arg.1 == 14, csrc.len() >= 16, csrc.len() % 16 == 0, csrc.len() == cdst.len(), dsrc.len() == csrc.len(), ddst.len() == 20])]
fn asm_sha1_hmac_aescbc_dec(csrc: &[u8], cdst: &mut [u8], dsrc: &[u8], ddst: &mut [u8], arg: &(*const [u32; 60], u8, *const [u8; 16], *const [u32; 5], *const [u32; 5]));

#[bums_macros::check_mem_safe("aes-sha256-armv8.S", csrc.as_ptr(), cdst.as_mut_ptr(), csrc.len(), dsrc.as_ptr(), ddst.as_mut_ptr(), dsrc.len(), arg as *const _, [arg.1 == 10 || arg.1 == 12 || arg.1 == 14, csrc.len() >= 16, csrc.len() % 16 == 0, csrc.len() == cdst.len(), dsrc.len() == csrc.len(), ddst.len() == 32])]
fn asm_aescbc_sha256_hmac(csrc: &[u8], cdst: &mut [u8], dsrc: &[u8], ddst: &mut [u8], arg: &(*const [u32; 60], u8, *const [u8; 16], *const [u32; 8], *const [u32; 8])) -> i32;

#[bums_macros::check_mem_safe("aes-sha256-armv8.S", csrc.as_ptr(), cdst.as_mut_ptr(), csrc.len(), dsrc.as_ptr(), ddst.as_mut_ptr(), dsrc.len(), arg as *const _, [arg.1 == 10 || arg.1 == 12 || arg.1 == 14, csrc.len() >= 16, csrc.len() % 16 == 0, csrc.len() == cdst.len(), dsrc.len() == csrc.len(), ddst.len() == 32])]
fn asm_sha256_hmac_aescbc_dec(csrc: &[u8], cdst: &mut [u8], dsrc: &[u8], ddst: &mut [u8], arg: &(*const [u32; 60], u8, *const [u8; 16], *const [u32; 8], *const [u32; 8]));

#[bums_macros::check_mem_safe("aes-sha512-armv8.S", csrc.as_ptr(), cdst.as_mut_ptr(), csrc.len(), dsrc.as_ptr(), ddst.as_mut_ptr(), dsrc.len(), arg as *const _, [arg.1 == 10 || arg.1 == 12 || arg.1 == 14, csrc.len() >= 16, csrc.len() % 16 == 0, csrc.len() == cdst.len(), dsrc.len() == csrc.len(), ddst.len() == 64])]
fn asm_aescbc_sha512_hmac(csrc: &[u8], cdst: &mut [u8], dsrc: &[u8], ddst: &mut [u8], arg: &(*const [u32; 60], u8, *const [u8; 16], *const [u64; 8], *const [u64; 8]));

#[bums_macros::check_mem_safe("aes-sha512-armv8.S", csrc.as_ptr(), cdst.as_mut_ptr(), csrc.len(), dsrc.as_ptr(), ddst.as_mut_ptr(), dsrc.len(), arg as *const _, [arg.1 == 10 || arg.1 == 12 || arg.1 == 14, csrc.len() >= 16, csrc.len() % 16 == 0, csrc.len() == cdst.len(), dsrc.len() == csrc.len(), ddst.len() == 64])]
fn asm_sha512_hmac_aescbc_dec(csrc: &[u8], cdst: &mut [u8], dsrc: &[u8], ddst: &mut [u8], arg: &(*const [u32; 60], u8, *const [u8; 16], *const [u64; 8], *const [u64; 8]));

#[bums_macros::check_mem_safe("bsaes-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, ivec.as_mut_ptr(), enc, [key.1 == 10 || key.1 == 12 || key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn ossl_bsaes_cbc_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("bsaes-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 16, key as *const _, ivec.as_ptr(), [key.1 == 10 || key.1 == 12 || key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn ossl_bsaes_ctr32_encrypt_blocks(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &[u8; 16]);

#[bums_macros::check_mem_safe("bsaes-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 == 10 || key1.1 == 14, key2.1 == key1.1, input.len() >= 16, input.len() == output.len()])]
fn ossl_bsaes_xts_encrypt(input: &[u8], output: &mut [u8], key1: &([u32; 60], u32), key2: &([u32; 60], u32), iv: &[u8; 16]);

#[bums_macros::check_mem_safe("bsaes-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 == 10 || key1.1 == 14, key2.1 == key1.1, input.len() >= 16, input.len() == output.len()])]
fn ossl_bsaes_xts_decrypt(input: &[u8], output: &mut [u8], key1: &([u32; 60], u32), key2: &([u32; 60], u32), iv: &[u8; 16]);

#[bums_macros::check_mem_safe("vpaes-armv8.S", user_key.as_ptr(), bits, key as *mut _, [bits == 128 || bits == 192 || bits == 256, user_key.len() * 8 == bits])]
fn vpaes_set_encrypt_key(user_key: &[u8], bits: i32, key: &mut ([u32; 60], u32)) -> i32;

#[bums_macros::check_mem_safe("vpaes-armv8.S", user_key.as_ptr(), bits, key as *mut _, [bits == 128 || bits == 192 || bits == 256, user_key.len() * 8 == bits])]
fn vpaes_set_decrypt_key(user_key: &[u8], bits: i32, key: &mut ([u32; 60], u32)) -> i32;

#[bums_macros::check_mem_safe("vpaes-armv8.S", input.as_ptr(), output.as_mut_ptr(), key as *const _, [key.1 == 9 || key.1 == 11 || key.1 == 13])]
fn vpaes_encrypt(input: &[u8; 16], output: &mut [u8; 16], key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("vpaes-armv8.S", input.as_ptr(), output.as_mut_ptr(), key as *const _, [key.1 == 9 || key.1 == 11 || key.1 == 13])]
fn vpaes_decrypt(input: &[u8; 16], output: &mut [u8; 16], key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("vpaes-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, ivec.as_mut_ptr(), enc, [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn vpaes_cbc_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("vpaes-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, enc, [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn vpaes_ecb_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), enc: i32);

#[bums_macros::check_mem_safe("armv8-mont.S", rp.as_mut_ptr(), ap.as_ptr(), bp.as_ptr(), np.as_ptr(), n0.as_ptr(), rp.len(), [rp.len() == ap.len(), rp.len() == bp.len(), rp.len() == np.len(), rp.len() >= 2, rp.len() <= 1024])]
fn bn_mul_mont(rp: &mut [u64], ap: &[u64], bp: &[u64], np: &[u64], n0: &[u64; 1]) -> i32;

#[bums_macros::check_mem_safe("chacha-armv8-with-sve.S", out.as_mut_ptr(), input.as_ptr(), input.len(), key.as_ptr(), counter.as_mut_ptr(), [input.len() == out.len()])]
fn ChaCha20_ctr32(out: &mut [u8], input: &[u8], key: &[u32; 8], counter: &mut [u32; 4]);

#[bums_macros::check_mem_safe("chacha-armv8.S", out.as_mut_ptr(), input.as_ptr(), input.len(), key.as_ptr(), counter.as_ptr(), [input.len() > 0, input.len() == out.len()])]
fn ChaCha20_ctr32_dflt(out: &mut [u8], input: &[u8], key: &[u32; 8], counter: &[u32; 4]);

#[bums_macros::check_mem_safe("chacha-armv8-sve.S", out.as_mut_ptr(), input.as_ptr(), input.len(), key.as_ptr(), counter.as_mut_ptr(), [input.len() == out.len()])]
fn ChaCha20_ctr32_sve(out: &mut [u8], input: &[u8], key: &[u32; 8], counter: &mut [u32; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_to_mont(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_from_mont(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_mul_mont(res: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_sqr_mont(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_add(res: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_div_by_2(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_mul_by_2(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_mul_by_3(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_sub(res: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_neg(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_point_double(res: &mut [u64; 12], a: &[u64; 12]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_point_add(res: &mut [u64; 12], a: &[u64; 12], b: &[u64; 12]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_point_add_affine(res: &mut [u64; 12], a: &[u64; 12], b: &[u64; 8]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_ord_mul_mont(res: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", res.as_mut_ptr(), a.as_ptr(), rep, [rep >= 1, rep <= 256])]
fn ecp_nistz256_ord_sqr_mont(res: &mut [u64; 4], a: &[u64; 4], rep: u64);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", table.as_mut_ptr(), point.as_ptr(), idx, [idx >= 1, idx <= 16])]
fn ecp_nistz256_scatter_w5(table: &mut [u64; 192], point: &[u64; 12], idx: i32);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", point.as_mut_ptr(), table.as_ptr(), idx, [idx >= 0, idx <= 16])]
fn ecp_nistz256_gather_w5(point: &mut [u64; 12], table: &[u64; 192], idx: i32);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", table.as_mut_ptr(), point.as_ptr(), idx, [idx >= 0, idx <= 63])]
fn ecp_nistz256_scatter_w7(table: &mut [u64; 512], point: &[u64; 8], idx: i32);

#[bums_macros::check_mem_safe("ecp_nistz256-armv8.S", point.as_mut_ptr(), table.as_ptr(), idx, [idx >= 0, idx <= 64])]
fn ecp_nistz256_gather_w7(point: &mut [u64; 8], table: &[u64; 512], idx: i32);

#[bums_macros::check_mem_safe("ecp_sm2p256-armv8.S", a.as_mut_ptr())]
fn bn_rshift1(a: &mut [u64; 4]);

#[bums_macros::check_mem_safe("ecp_sm2p256-armv8.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn bn_sub(r: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_sm2p256-armv8.S", r.as_mut_ptr(), a.as_ptr())]
fn ecp_sm2p256_div_by_2(r: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_sm2p256-armv8.S", r.as_mut_ptr(), a.as_ptr())]
fn ecp_sm2p256_div_by_2_mod_ord(r: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_sm2p256-armv8.S", r.as_mut_ptr(), a.as_ptr())]
fn ecp_sm2p256_mul_by_3(r: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_sm2p256-armv8.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_sm2p256_add(r: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_sm2p256-armv8.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_sm2p256_sub(r: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_sm2p256-armv8.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_sm2p256_sub_mod_ord(r: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_sm2p256-armv8.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_sm2p256_mul(r: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_sm2p256-armv8.S", r.as_mut_ptr(), a.as_ptr())]
fn ecp_sm2p256_sqr(r: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ghashv8-armx.S", htable.as_mut_ptr(), h.as_ptr())]
fn gcm_init_v8(htable: &mut [u128; 16], h: &[u64; 2]);

#[bums_macros::check_mem_safe("ghashv8-armx.S", xi.as_mut_ptr(), htable.as_ptr())]
fn gcm_gmult_v8(xi: &mut [u64; 2], htable: &[u128; 16]);

#[bums_macros::check_mem_safe("ghashv8-armx.S", xi.as_mut_ptr(), htable.as_ptr(), input.as_ptr(), input.len(), [input.len() >= 16, input.len() % 16 == 0])]
fn gcm_ghash_v8(xi: &mut [u64; 2], htable: &[u128; 16], input: &[u8]);

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), input.as_ptr(), input.len(), r, [r % 8 == 0, r >= 8, r <= 168])]
fn SHA3_absorb(a: &mut [u64; 25], input: &[u8], r: usize) -> usize;

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), input.as_ptr(), input.len(), r, [r % 8 == 0, r >= 8, r <= 168])]
fn SHA3_absorb_cext(a: &mut [u64; 25], input: &[u8], r: usize) -> usize;

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), out.as_mut_ptr(), out.len(), r, next, [out.len() >= 1, r % 8 == 0, r >= 8, r <= 168])]
fn SHA3_squeeze(a: &mut [u64; 25], out: &mut [u8], r: usize, next: i32);

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), out.as_mut_ptr(), out.len(), r, next, [out.len() >= 1, r % 8 == 0, r >= 8, r <= 168])]
fn SHA3_squeeze_cext(a: &mut [u64; 25], out: &mut [u8], r: usize, next: i32);

#[bums_macros::check_mem_safe("md5-aarch64.S", ctx.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64, input.len() % 64 == 0])]
fn ossl_md5_block_asm_data_order(ctx: &mut [u32; 4], input: &[u8]);

#[bums_macros::check_mem_safe("poly1305-armv8.S", ctx.as_mut_ptr(), key.as_ptr(), func.as_mut_ptr())]
fn poly1305_init(ctx: &mut [u64; 24], key: &[u8; 16], func: &mut [usize; 2]) -> i32;

#[bums_macros::check_mem_safe("poly1305-armv8.S", ctx.as_mut_ptr(), input.as_ptr(), input.len(), padbit, [input.len() % 16 == 0])]
fn poly1305_blocks(ctx: &mut [u64; 24], input: &[u8], padbit: u32);

#[bums_macros::check_mem_safe("poly1305-armv8.S", ctx.as_mut_ptr(), mac.as_mut_ptr(), nonce.as_ptr())]
fn poly1305_emit(ctx: &mut [u64; 24], mac: &mut [u8; 16], nonce: &[u32; 4]);

#[bums_macros::check_mem_safe("poly1305-armv8-with-sve2.S", ctx as *mut _, input.as_ptr(), input.len(), padbit, [input.len() % 16 == 0, ctx.2 == 0 || (ctx.2 % 4 == 0 && ctx.2 >= -28 && ctx.2 <= -12)])]
fn poly1305_blocks_sve2(ctx: &mut ([u64; 3], u32, i32, [u64; 20]), input: &[u8], padbit: u32);

#[bums_macros::check_mem_safe("sha1-armv8.S", ctx.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64, input.len() % 64 == 0])]
fn sha1_block_data_order(ctx: &mut [u32; 5], input: &[u8]);

#[bums_macros::check_mem_safe("sha256-armv8.S", ctx.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64, input.len() % 64 == 0])]
fn sha256_block_data_order(ctx: &mut [u32; 8], input: &[u8]);

#[bums_macros::check_mem_safe("sha512-armv8.S", ctx.as_mut_ptr(), input.as_ptr(), input.len() / 128, [input.len() >= 128, input.len() % 128 == 0])]
fn sha512_block_data_order(ctx: &mut [u64; 8], input: &[u8]);

#[bums_macros::check_mem_safe("sm3-armv8.S", ctx.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64, input.len() % 64 == 0])]
fn ossl_hwsm3_block_data_order(ctx: &mut [u32; 8], input: &[u8]);

#[bums_macros::check_mem_safe("sm4-armv8.S", user_key.as_ptr(), key.as_mut_ptr())]
fn sm4_v8_set_encrypt_key(user_key: &[u8; 16], key: &mut [u32; 32]) -> i32;

#[bums_macros::check_mem_safe("sm4-armv8.S", user_key.as_ptr(), key.as_mut_ptr())]
fn sm4_v8_set_decrypt_key(user_key: &[u8; 16], key: &mut [u32; 32]) -> i32;

#[bums_macros::check_mem_safe("sm4-armv8.S", input.as_ptr(), output.as_mut_ptr(), key.as_ptr())]
fn sm4_v8_encrypt(input: &[u8; 16], output: &mut [u8; 16], key: &[u32; 32]);

#[bums_macros::check_mem_safe("sm4-armv8.S", input.as_ptr(), output.as_mut_ptr(), key.as_ptr())]
fn sm4_v8_decrypt(input: &[u8; 16], output: &mut [u8; 16], key: &[u32; 32]);

#[bums_macros::check_mem_safe("sm4-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key.as_ptr(), enc, [input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn sm4_v8_ecb_encrypt(input: &[u8], output: &mut [u8], key: &[u32; 32], enc: i32);

#[bums_macros::check_mem_safe("sm4-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key.as_ptr(), ivec.as_mut_ptr(), enc, [input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn sm4_v8_cbc_encrypt(input: &[u8], output: &mut [u8], key: &[u32; 32], ivec: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("sm4-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 16, key.as_ptr(), ivec.as_ptr(), [input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn sm4_v8_ctr32_encrypt_blocks(input: &[u8], output: &mut [u8], key: &[u32; 32], ivec: &[u8; 16]);

#[bums_macros::check_mem_safe("vpsm4-armv8.S", user_key.as_ptr(), key.as_mut_ptr())]
fn vpsm4_set_encrypt_key(user_key: &[u8; 16], key: &mut [u32; 32]) -> i32;

#[bums_macros::check_mem_safe("vpsm4-armv8.S", user_key.as_ptr(), key.as_mut_ptr())]
fn vpsm4_set_decrypt_key(user_key: &[u8; 16], key: &mut [u32; 32]) -> i32;

#[bums_macros::check_mem_safe("vpsm4-armv8.S", input.as_ptr(), output.as_mut_ptr(), key.as_ptr())]
fn vpsm4_encrypt(input: &[u8; 16], output: &mut [u8; 16], key: &[u32; 32]);

#[bums_macros::check_mem_safe("vpsm4-armv8.S", input.as_ptr(), output.as_mut_ptr(), key.as_ptr())]
fn vpsm4_decrypt(input: &[u8; 16], output: &mut [u8; 16], key: &[u32; 32]);

#[bums_macros::check_mem_safe("vpsm4-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key.as_ptr(), enc, [input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn vpsm4_ecb_encrypt(input: &[u8], output: &mut [u8], key: &[u32; 32], enc: i32);

#[bums_macros::check_mem_safe("vpsm4-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key.as_ptr(), ivec.as_mut_ptr(), enc, [input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn vpsm4_cbc_encrypt(input: &[u8], output: &mut [u8], key: &[u32; 32], ivec: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("vpsm4-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 16, key.as_ptr(), ivec.as_ptr(), [input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn vpsm4_ctr32_encrypt_blocks(input: &[u8], output: &mut [u8], key: &[u32; 32], ivec: &[u8; 16]);

#[bums_macros::check_mem_safe("vpsm4-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1.as_ptr(), key2.as_ptr(), iv.as_mut_ptr(), enc, [input.len() >= 16, input.len() == output.len()])]
fn vpsm4_xts_encrypt(input: &[u8], output: &mut [u8], key1: &[u32; 32], key2: &[u32; 32], iv: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("vpsm4-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1.as_ptr(), key2.as_ptr(), iv.as_mut_ptr(), enc, [input.len() >= 16, input.len() == output.len()])]
fn vpsm4_xts_encrypt_gb(input: &[u8], output: &mut [u8], key1: &[u32; 32], key2: &[u32; 32], iv: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("vpsm4_ex-armv8.S", user_key.as_ptr(), key.as_mut_ptr())]
fn vpsm4_ex_set_encrypt_key(user_key: &[u8; 16], key: &mut [u32; 32]) -> i32;

#[bums_macros::check_mem_safe("vpsm4_ex-armv8.S", user_key.as_ptr(), key.as_mut_ptr())]
fn vpsm4_ex_set_decrypt_key(user_key: &[u8; 16], key: &mut [u32; 32]) -> i32;

#[bums_macros::check_mem_safe("vpsm4_ex-armv8.S", input.as_ptr(), output.as_mut_ptr(), key.as_ptr())]
fn vpsm4_ex_encrypt(input: &[u8; 16], output: &mut [u8; 16], key: &[u32; 32]);

#[bums_macros::check_mem_safe("vpsm4_ex-armv8.S", input.as_ptr(), output.as_mut_ptr(), key.as_ptr())]
fn vpsm4_ex_decrypt(input: &[u8; 16], output: &mut [u8; 16], key: &[u32; 32]);

#[bums_macros::check_mem_safe("vpsm4_ex-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key.as_ptr(), enc, [input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn vpsm4_ex_ecb_encrypt(input: &[u8], output: &mut [u8], key: &[u32; 32], enc: i32);

#[bums_macros::check_mem_safe("vpsm4_ex-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key.as_ptr(), ivec.as_mut_ptr(), enc, [input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn vpsm4_ex_cbc_encrypt(input: &[u8], output: &mut [u8], key: &[u32; 32], ivec: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("vpsm4_ex-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 16, key.as_ptr(), ivec.as_ptr(), [input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn vpsm4_ex_ctr32_encrypt_blocks(input: &[u8], output: &mut [u8], key: &[u32; 32], ivec: &[u8; 16]);

#[bums_macros::check_mem_safe("vpsm4_ex-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1.as_ptr(), key2.as_ptr(), iv.as_mut_ptr(), enc, [input.len() >= 16, input.len() == output.len()])]
fn vpsm4_ex_xts_encrypt(input: &[u8], output: &mut [u8], key1: &[u32; 32], key2: &[u32; 32], iv: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("vpsm4_ex-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1.as_ptr(), key2.as_ptr(), iv.as_mut_ptr(), enc, [input.len() >= 16, input.len() == output.len()])]
fn vpsm4_ex_xts_encrypt_gb(input: &[u8], output: &mut [u8], key1: &[u32; 32], key2: &[u32; 32], iv: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv7_neon_probe();

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_aes_probe();

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_sha1_probe();

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_sha256_probe();

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_pmull_probe();

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_sm4_probe();

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_sha512_probe();

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_eor3_probe();

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_sve_probe();

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_sve2_probe();

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_sm3_probe();

#[bums_macros::check_mem_safe("arm64cpuid.S")]
fn _armv8_rng_probe();
