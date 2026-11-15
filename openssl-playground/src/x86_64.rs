#[bums_macros::check_mem_safe("x86_64cpuid.S", buf.as_mut_ptr(), buf.len())]
fn OPENSSL_cleanse(buf: &mut [u8]);

#[bums_macros::check_mem_safe("x86_64cpuid.S", a.as_ptr(), b.as_ptr(), a.len(), [a.len() == b.len()])]
fn CRYPTO_memcmp(a: &[u8], b: &[u8]) -> i32;

#[bums_macros::check_mem_safe("x86_64cpuid.S", val.as_mut_ptr(), amount)]
fn OPENSSL_atomic_add(val: &mut [i32; 1], amount: i32) -> i32;

#[bums_macros::check_mem_safe("x86_64cpuid.S")]
fn OPENSSL_rdtsc() -> u32;

#[bums_macros::check_mem_safe("x86_64cpuid.S", cap.as_mut_ptr())]
fn OPENSSL_ia32_cpuid(cap: &mut [u32; 10]) -> u64;

#[bums_macros::check_mem_safe("x86_64cpuid.S", out.as_mut_ptr(), out.len())]
fn OPENSSL_instrument_bus(out: &mut [u32]) -> usize;

#[bums_macros::check_mem_safe("x86_64cpuid.S", out.as_mut_ptr(), out.len(), max)]
fn OPENSSL_instrument_bus2(out: &mut [u32], max: usize) -> usize;

#[bums_macros::check_mem_safe("x86_64cpuid.S", buf.as_mut_ptr(), buf.len())]
fn OPENSSL_ia32_rdrand_bytes(buf: &mut [u8]) -> usize;

#[bums_macros::check_mem_safe("x86_64cpuid.S", buf.as_mut_ptr(), buf.len())]
fn OPENSSL_ia32_rdseed_bytes(buf: &mut [u8]) -> usize;

#[bums_macros::check_mem_safe("aesni-x86_64.S", user_key.as_ptr(), bits, key as *mut _, [bits == 128 || bits == 192 || bits == 256, user_key.len() * 8 == bits])]
fn aesni_set_encrypt_key(user_key: &[u8], bits: i32, key: &mut ([u32; 60], u32)) -> i32;

#[bums_macros::check_mem_safe("aesni-x86_64.S", user_key.as_ptr(), bits, key as *mut _, [bits == 128 || bits == 192 || bits == 256, user_key.len() * 8 == bits])]
fn aesni_set_decrypt_key(user_key: &[u8], bits: i32, key: &mut ([u32; 60], u32)) -> i32;

#[bums_macros::check_mem_safe("aesni-x86_64.S", input.as_ptr(), output.as_mut_ptr(), key as *const _, [key.1 == 9 || key.1 == 11 || key.1 == 13])]
fn aesni_encrypt(input: &[u8; 16], output: &mut [u8; 16], key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("aesni-x86_64.S", input.as_ptr(), output.as_mut_ptr(), key as *const _, [key.1 == 9 || key.1 == 11 || key.1 == 13])]
fn aesni_decrypt(input: &[u8; 16], output: &mut [u8; 16], key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("aesni-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, enc, [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aesni_ecb_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), enc: i32);

#[bums_macros::check_mem_safe("aesni-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, ivec.as_mut_ptr(), enc, [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aesni_cbc_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("aesni-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 16, key as *const _, ivec.as_ptr(), [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aesni_ctr32_encrypt_blocks(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &[u8; 16]);

#[bums_macros::check_mem_safe("aesni-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 16, key as *const _, ivec.as_ptr(), cmac.as_mut_ptr(), [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aesni_ccm64_encrypt_blocks(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &[u8; 16], cmac: &mut [u8; 16]);

#[bums_macros::check_mem_safe("aesni-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 16, key as *const _, ivec.as_ptr(), cmac.as_mut_ptr(), [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn aesni_ccm64_decrypt_blocks(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &[u8; 16], cmac: &mut [u8; 16]);

#[bums_macros::check_mem_safe("aesni-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 == 9 || key1.1 == 13, key2.1 == key1.1, input.len() >= 16, input.len() == output.len()])]
fn aesni_xts_encrypt(input: &[u8], output: &mut [u8], key1: &([u32; 60], u32), key2: &([u32; 60], u32), iv: &[u8; 16]);

#[bums_macros::check_mem_safe("aesni-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 == 9 || key1.1 == 13, key2.1 == key1.1, input.len() >= 16, input.len() == output.len()])]
fn aesni_xts_decrypt(input: &[u8], output: &mut [u8], key1: &([u32; 60], u32), key2: &([u32; 60], u32), iv: &[u8; 16]);

#[bums_macros::check_mem_safe("aesni-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 16, key as *const _, start, offset.as_mut_ptr(), l.as_ptr(), checksum.as_mut_ptr(), [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len(), start >= 1])]
fn aesni_ocb_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), start: u64, offset: &mut [u8; 16], l: &[u8; 1024], checksum: &mut [u8; 16]);

#[bums_macros::check_mem_safe("aesni-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 16, key as *const _, start, offset.as_mut_ptr(), l.as_ptr(), checksum.as_mut_ptr(), [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len(), start >= 1])]
fn aesni_ocb_decrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), start: u64, offset: &mut [u8; 16], l: &[u8; 1024], checksum: &mut [u8; 16]);

#[bums_macros::check_mem_safe("aesni-gcm-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, ivec.as_mut_ptr(), xi.as_mut_ptr(), [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() == output.len()])]
fn aesni_gcm_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], xi: &mut [u64; 36]) -> usize;

#[bums_macros::check_mem_safe("aesni-gcm-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, ivec.as_mut_ptr(), xi.as_mut_ptr(), [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() == output.len()])]
fn aesni_gcm_decrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], xi: &mut [u64; 36]) -> usize;

#[bums_macros::check_mem_safe("aesni-sha1-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 64, key as *const _, ivec.as_mut_ptr(), ctx.as_mut_ptr(), md.as_ptr(), [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() >= 64, input.len() % 64 == 0, input.len() == output.len(), md.len() == input.len()])]
fn aesni_cbc_sha1_enc(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], ctx: &mut [u32; 5], md: &[u8]);

#[bums_macros::check_mem_safe("aesni-sha256-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 64, key as *const _, ivec.as_mut_ptr(), ctx.as_mut_ptr(), md.as_ptr(), [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() >= 64, input.len() % 64 == 0, input.len() == output.len(), md.len() == input.len()])]
fn aesni_cbc_sha256_enc(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], ctx: &mut [u32; 8], md: &[u8]) -> i32;

#[bums_macros::check_mem_safe("aesni-xts-avx512.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 == 9, key2.1 == 9, input.len() >= 16, input.len() == output.len()])]
fn aesni_xts_128_encrypt_avx512(input: &[u8], output: &mut [u8], key1: &([u32; 60], u32), key2: &([u32; 60], u32), iv: &[u8; 16]);

#[bums_macros::check_mem_safe("aesni-xts-avx512.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 == 9, key2.1 == 9, input.len() >= 16, input.len() == output.len()])]
fn aesni_xts_128_decrypt_avx512(input: &[u8], output: &mut [u8], key1: &([u32; 60], u32), key2: &([u32; 60], u32), iv: &[u8; 16]);

#[bums_macros::check_mem_safe("aesni-xts-avx512.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 == 13, key2.1 == 13, input.len() >= 16, input.len() == output.len()])]
fn aesni_xts_256_encrypt_avx512(input: &[u8], output: &mut [u8], key1: &([u32; 60], u32), key2: &([u32; 60], u32), iv: &[u8; 16]);

#[bums_macros::check_mem_safe("aesni-xts-avx512.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 == 13, key2.1 == 13, input.len() >= 16, input.len() == output.len()])]
fn aesni_xts_256_decrypt_avx512(input: &[u8], output: &mut [u8], key1: &([u32; 60], u32), key2: &([u32; 60], u32), iv: &[u8; 16]);

#[bums_macros::check_mem_safe("aesni-xts-avx512.S")]
fn aesni_xts_avx512_eligible() -> i32;

#[bums_macros::check_mem_safe("aes-x86_64.S", user_key.as_ptr(), bits, key as *mut _, [bits == 128 || bits == 192 || bits == 256, user_key.len() * 8 == bits])]
fn AES_set_encrypt_key(user_key: &[u8], bits: i32, key: &mut ([u32; 60], u32)) -> i32;

#[bums_macros::check_mem_safe("aes-x86_64.S", user_key.as_ptr(), bits, key as *mut _, [bits == 128 || bits == 192 || bits == 256, user_key.len() * 8 == bits])]
fn AES_set_decrypt_key(user_key: &[u8], bits: i32, key: &mut ([u32; 60], u32)) -> i32;

#[bums_macros::check_mem_safe("aes-x86_64.S", input.as_ptr(), output.as_mut_ptr(), key as *const _, [key.1 == 10 || key.1 == 12 || key.1 == 14])]
fn AES_encrypt(input: &[u8; 16], output: &mut [u8; 16], key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("aes-x86_64.S", input.as_ptr(), output.as_mut_ptr(), key as *const _, [key.1 == 10 || key.1 == 12 || key.1 == 14])]
fn AES_decrypt(input: &[u8; 16], output: &mut [u8; 16], key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("aes-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, ivec.as_mut_ptr(), enc, [key.1 == 10 || key.1 == 12 || key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn AES_cbc_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("bsaes-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, ivec.as_mut_ptr(), enc, [key.1 == 10 || key.1 == 12 || key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn ossl_bsaes_cbc_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("bsaes-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len() / 16, key as *const _, ivec.as_ptr(), [key.1 == 10 || key.1 == 12 || key.1 == 14, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn ossl_bsaes_ctr32_encrypt_blocks(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &[u8; 16]);

#[bums_macros::check_mem_safe("bsaes-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 == 10 || key1.1 == 14, key2.1 == key1.1, input.len() >= 16, input.len() == output.len()])]
fn ossl_bsaes_xts_encrypt(input: &[u8], output: &mut [u8], key1: &([u32; 60], u32), key2: &([u32; 60], u32), iv: &[u8; 16]);

#[bums_macros::check_mem_safe("bsaes-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key1 as *const _, key2 as *const _, iv.as_ptr(), [key1.1 == 10 || key1.1 == 14, key2.1 == key1.1, input.len() >= 16, input.len() == output.len()])]
fn ossl_bsaes_xts_decrypt(input: &[u8], output: &mut [u8], key1: &([u32; 60], u32), key2: &([u32; 60], u32), iv: &[u8; 16]);

#[bums_macros::check_mem_safe("vpaes-x86_64.S", user_key.as_ptr(), bits, key as *mut _, [bits == 128 || bits == 192 || bits == 256, user_key.len() * 8 == bits])]
fn vpaes_set_encrypt_key(user_key: &[u8], bits: i32, key: &mut ([u32; 60], u32)) -> i32;

#[bums_macros::check_mem_safe("vpaes-x86_64.S", user_key.as_ptr(), bits, key as *mut _, [bits == 128 || bits == 192 || bits == 256, user_key.len() * 8 == bits])]
fn vpaes_set_decrypt_key(user_key: &[u8], bits: i32, key: &mut ([u32; 60], u32)) -> i32;

#[bums_macros::check_mem_safe("vpaes-x86_64.S", input.as_ptr(), output.as_mut_ptr(), key as *const _, [key.1 == 9 || key.1 == 11 || key.1 == 13])]
fn vpaes_encrypt(input: &[u8; 16], output: &mut [u8; 16], key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("vpaes-x86_64.S", input.as_ptr(), output.as_mut_ptr(), key as *const _, [key.1 == 9 || key.1 == 11 || key.1 == 13])]
fn vpaes_decrypt(input: &[u8; 16], output: &mut [u8; 16], key: &([u32; 60], u32));

#[bums_macros::check_mem_safe("vpaes-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, ivec.as_mut_ptr(), enc, [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn vpaes_cbc_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("aes-cfb-avx512.S")]
fn ossl_aes_cfb128_vaes_eligible() -> i32;

#[bums_macros::check_mem_safe("aes-cfb-avx512.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, ivec.as_mut_ptr(), num as *mut _, [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() == output.len(), num.0 >= 0, num.0 < 16])]
fn ossl_aes_cfb128_vaes_enc(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], num: &mut (i64,));

#[bums_macros::check_mem_safe("aes-cfb-avx512.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, ivec.as_mut_ptr(), num as *mut _, [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() == output.len(), num.0 >= 0, num.0 < 16])]
fn ossl_aes_cfb128_vaes_dec(input: &[u8], output: &mut [u8], key: &([u32; 60], u32), ivec: &mut [u8; 16], num: &mut (i64,));

#[bums_macros::check_mem_safe("aes-cbc-vaes-x86_64.S")]
fn ossl_aes_cbc_vaes_cleanup_eligible() -> i32;

#[bums_macros::check_mem_safe("aes-gcm-avx512.S")]
fn ossl_vaes_vpclmulqdq_capable() -> i32;

#[bums_macros::check_mem_safe("aes-gcm-avx512.S", key as *const _, ctx.as_mut_ptr(), [key.1 == 9 || key.1 == 11 || key.1 == 13])]
fn ossl_aes_gcm_init_avx512(key: &([u32; 60], u32), ctx: &mut [u64; 56]);

#[bums_macros::check_mem_safe("aes-gcm-avx512.S", key as *const _, ctx.as_mut_ptr(), iv.as_ptr(), iv.len(), [key.1 == 9 || key.1 == 11 || key.1 == 13, iv.len() >= 1])]
fn ossl_aes_gcm_setiv_avx512(key: &([u32; 60], u32), ctx: &mut [u64; 56], iv: &[u8]);

#[bums_macros::check_mem_safe("aes-gcm-avx512.S", ctx.as_mut_ptr(), aad.as_ptr(), aad.len())]
fn ossl_aes_gcm_update_aad_avx512(ctx: &mut [u64; 56], aad: &[u8]);

#[bums_macros::check_mem_safe("aes-gcm-avx512.S", key as *const _, ctx.as_mut_ptr(), blocklen as *mut _, input.as_ptr(), input.len(), output.as_mut_ptr(), [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() == output.len(), blocklen.0 < 16])]
fn ossl_aes_gcm_encrypt_avx512(key: &([u32; 60], u32), ctx: &mut [u64; 56], blocklen: &mut (u32,), input: &[u8], output: &mut [u8]);

#[bums_macros::check_mem_safe("aes-gcm-avx512.S", key as *const _, ctx.as_mut_ptr(), blocklen as *mut _, input.as_ptr(), input.len(), output.as_mut_ptr(), [key.1 == 9 || key.1 == 11 || key.1 == 13, input.len() == output.len(), blocklen.0 < 16])]
fn ossl_aes_gcm_decrypt_avx512(key: &([u32; 60], u32), ctx: &mut [u64; 56], blocklen: &mut (u32,), input: &[u8], output: &mut [u8]);

#[bums_macros::check_mem_safe("aes-gcm-avx512.S", ctx.as_mut_ptr(), blocklen, [blocklen < 16])]
fn ossl_aes_gcm_finalize_avx512(ctx: &mut [u64; 56], blocklen: u32);

#[bums_macros::check_mem_safe("aes-gcm-avx512.S", xi.as_mut_ptr(), ctx.as_ptr())]
fn ossl_gcm_gmult_avx512(xi: &mut [u64; 2], ctx: &[u64; 56]);

#[bums_macros::check_mem_safe("ghash-x86_64.S", xi.as_mut_ptr(), htable.as_ptr())]
fn gcm_gmult_4bit(xi: &mut [u64; 2], htable: &[u128; 16]);

#[bums_macros::check_mem_safe("ghash-x86_64.S", xi.as_mut_ptr(), htable.as_ptr(), input.as_ptr(), input.len(), [input.len() >= 16, input.len() % 16 == 0])]
fn gcm_ghash_4bit(xi: &mut [u64; 2], htable: &[u128; 16], input: &[u8]);

#[bums_macros::check_mem_safe("ghash-x86_64.S", htable.as_mut_ptr(), h.as_ptr())]
fn gcm_init_clmul(htable: &mut [u128; 16], h: &[u64; 2]);

#[bums_macros::check_mem_safe("ghash-x86_64.S", xi.as_mut_ptr(), htable.as_ptr())]
fn gcm_gmult_clmul(xi: &mut [u64; 2], htable: &[u128; 16]);

#[bums_macros::check_mem_safe("ghash-x86_64.S", xi.as_mut_ptr(), htable.as_ptr(), input.as_ptr(), input.len(), [input.len() >= 16, input.len() % 16 == 0])]
fn gcm_ghash_clmul(xi: &mut [u64; 2], htable: &[u128; 16], input: &[u8]);

#[bums_macros::check_mem_safe("ghash-x86_64.S", htable.as_mut_ptr(), h.as_ptr())]
fn gcm_init_avx(htable: &mut [u128; 16], h: &[u64; 2]);

#[bums_macros::check_mem_safe("ghash-x86_64.S", xi.as_mut_ptr(), htable.as_ptr())]
fn gcm_gmult_avx(xi: &mut [u64; 2], htable: &[u128; 16]);

#[bums_macros::check_mem_safe("ghash-x86_64.S", xi.as_mut_ptr(), htable.as_ptr(), input.as_ptr(), input.len(), [input.len() >= 16, input.len() % 16 == 0])]
fn gcm_ghash_avx(xi: &mut [u64; 2], htable: &[u128; 16], input: &[u8]);

#[bums_macros::check_mem_safe("cmll-x86_64.S", bits, input.as_ptr(), key.as_ptr(), output.as_mut_ptr(), [bits == 128 || bits == 192 || bits == 256])]
fn Camellia_EncryptBlock(bits: i32, input: &[u8; 16], key: &[u32; 68], output: &mut [u8; 16]);

#[bums_macros::check_mem_safe("cmll-x86_64.S", bits, input.as_ptr(), key.as_ptr(), output.as_mut_ptr(), [bits == 128 || bits == 192 || bits == 256])]
fn Camellia_DecryptBlock(bits: i32, input: &[u8; 16], key: &[u32; 68], output: &mut [u8; 16]);

#[bums_macros::check_mem_safe("cmll-x86_64.S", rounds, input.as_ptr(), key.as_ptr(), output.as_mut_ptr(), [rounds == 3 || rounds == 4])]
fn Camellia_EncryptBlock_Rounds(rounds: i32, input: &[u8; 16], key: &[u32; 68], output: &mut [u8; 16]);

#[bums_macros::check_mem_safe("cmll-x86_64.S", rounds, input.as_ptr(), key.as_ptr(), output.as_mut_ptr(), [rounds == 3 || rounds == 4])]
fn Camellia_DecryptBlock_Rounds(rounds: i32, input: &[u8; 16], key: &[u32; 68], output: &mut [u8; 16]);

#[bums_macros::check_mem_safe("cmll-x86_64.S", bits, raw.as_ptr(), key.as_mut_ptr(), [bits == 128 || bits == 192 || bits == 256, raw.len() * 8 == bits])]
fn Camellia_Ekeygen(bits: i32, raw: &[u8], key: &mut [u32; 68]) -> i32;

#[bums_macros::check_mem_safe("cmll-x86_64.S", input.as_ptr(), output.as_mut_ptr(), input.len(), key as *const _, ivec.as_mut_ptr(), enc, [key.1 == 3 || key.1 == 4, input.len() >= 16, input.len() % 16 == 0, input.len() == output.len()])]
fn Camellia_cbc_encrypt(input: &[u8], output: &mut [u8], key: &([u32; 68], u32), ivec: &mut [u8; 16], enc: i32);

#[bums_macros::check_mem_safe("chacha-x86_64.S", out.as_mut_ptr(), input.as_ptr(), input.len(), key.as_ptr(), counter.as_ptr(), [input.len() == out.len()])]
fn ChaCha20_ctr32(out: &mut [u8], input: &[u8], key: &[u32; 8], counter: &[u32; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_mul_by_2(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_div_by_2(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_mul_by_3(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_add(res: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_sub(res: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_neg(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_ord_mul_mont(res: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr(), rep, [rep >= 1, rep <= 256])]
fn ecp_nistz256_ord_sqr_mont(res: &mut [u64; 4], a: &[u64; 4], rep: u64);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_to_mont(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_mul_mont(res: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_sqr_mont(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_from_mont(res: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", table.as_mut_ptr(), point.as_ptr(), idx, [idx >= 1, idx <= 16])]
fn ecp_nistz256_scatter_w5(table: &mut [u64; 192], point: &[u64; 12], idx: i32);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", point.as_mut_ptr(), table.as_ptr(), idx, [idx >= 0, idx <= 16])]
fn ecp_nistz256_gather_w5(point: &mut [u64; 12], table: &[u64; 192], idx: i32);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", table.as_mut_ptr(), point.as_ptr(), idx, [idx >= 0, idx <= 63])]
fn ecp_nistz256_scatter_w7(table: &mut [u64; 512], point: &[u64; 8], idx: i32);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", point.as_mut_ptr(), table.as_ptr(), idx, [idx >= 0, idx <= 64])]
fn ecp_nistz256_gather_w7(point: &mut [u64; 8], table: &[u64; 512], idx: i32);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", point.as_mut_ptr(), table.as_ptr(), idx, [idx >= 0, idx <= 64])]
fn ecp_nistz256_avx2_gather_w7(point: &mut [u64; 8], table: &[u64; 512], idx: i32);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_point_double(res: &mut [u64; 12], a: &[u64; 12]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_point_add(res: &mut [u64; 12], a: &[u64; 12], b: &[u64; 12]);

#[bums_macros::check_mem_safe("ecp_nistz256-x86_64.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_point_add_affine(res: &mut [u64; 12], a: &[u64; 12], b: &[u64; 8]);

#[bums_macros::check_mem_safe("x25519-x86_64.S", h.as_mut_ptr(), f.as_ptr(), g.as_ptr())]
fn x25519_fe51_mul(h: &mut [u64; 5], f: &[u64; 5], g: &[u64; 5]);

#[bums_macros::check_mem_safe("x25519-x86_64.S", h.as_mut_ptr(), f.as_ptr())]
fn x25519_fe51_sqr(h: &mut [u64; 5], f: &[u64; 5]);

#[bums_macros::check_mem_safe("x25519-x86_64.S", h.as_mut_ptr(), f.as_ptr())]
fn x25519_fe51_mul121666(h: &mut [u64; 5], f: &[u64; 5]);

#[bums_macros::check_mem_safe("x25519-x86_64.S")]
fn x25519_fe64_eligible() -> i32;

#[bums_macros::check_mem_safe("x25519-x86_64.S", h.as_mut_ptr(), f.as_ptr(), g.as_ptr())]
fn x25519_fe64_mul(h: &mut [u64; 4], f: &[u64; 4], g: &[u64; 4]);

#[bums_macros::check_mem_safe("x25519-x86_64.S", h.as_mut_ptr(), f.as_ptr())]
fn x25519_fe64_sqr(h: &mut [u64; 4], f: &[u64; 4]);

#[bums_macros::check_mem_safe("x25519-x86_64.S", h.as_mut_ptr(), f.as_ptr())]
fn x25519_fe64_mul121666(h: &mut [u64; 4], f: &[u64; 4]);

#[bums_macros::check_mem_safe("x25519-x86_64.S", h.as_mut_ptr(), f.as_ptr(), g.as_ptr())]
fn x25519_fe64_add(h: &mut [u64; 4], f: &[u64; 4], g: &[u64; 4]);

#[bums_macros::check_mem_safe("x25519-x86_64.S", h.as_mut_ptr(), f.as_ptr(), g.as_ptr())]
fn x25519_fe64_sub(h: &mut [u64; 4], f: &[u64; 4], g: &[u64; 4]);

#[bums_macros::check_mem_safe("x25519-x86_64.S", s.as_mut_ptr(), f.as_ptr())]
fn x25519_fe64_tobytes(s: &mut [u8; 32], f: &[u64; 4]);

#[bums_macros::check_mem_safe("x86_64-gf2m.S", r.as_mut_ptr(), a1, a0, b1, b0)]
fn bn_GF2m_mul_2x2(r: &mut [u64; 4], a1: u64, a0: u64, b1: u64, b0: u64);

#[bums_macros::check_mem_safe("x86_64-mont.S", rp.as_mut_ptr(), ap.as_ptr(), bp.as_ptr(), np.as_ptr(), n0.as_ptr(), rp.len(), [rp.len() == ap.len(), rp.len() == bp.len(), rp.len() == np.len(), rp.len() >= 4, rp.len() <= 1024])]
fn bn_mul_mont(rp: &mut [u64], ap: &[u64], bp: &[u64], np: &[u64], n0: &[u64; 1]) -> i32;

#[bums_macros::check_mem_safe("x86_64-mont5.S", rp.as_mut_ptr(), ap.as_ptr(), table.as_ptr(), np.as_ptr(), n0.as_ptr(), rp.len(), power, [rp.len() == ap.len(), rp.len() == np.len(), table.len() == rp.len() * 32, rp.len() % 8 == 0, rp.len() >= 8, rp.len() <= 1024, power >= 0, power < 32])]
fn bn_mul_mont_gather5(rp: &mut [u64], ap: &[u64], table: &[u64], np: &[u64], n0: &[u64; 1], power: i32);

#[bums_macros::check_mem_safe("x86_64-mont5.S", rp.as_mut_ptr(), ap.as_ptr(), table.as_ptr(), np.as_ptr(), n0.as_ptr(), rp.len(), power, [rp.len() == ap.len(), rp.len() == np.len(), table.len() == rp.len() * 32, rp.len() % 8 == 0, rp.len() >= 8, rp.len() <= 1024, power >= 0, power < 32])]
fn bn_power5(rp: &mut [u64], ap: &[u64], table: &[u64], np: &[u64], n0: &[u64; 1], power: i32);

#[bums_macros::check_mem_safe("x86_64-mont5.S", ap.as_ptr(), off, [off >= 0, off + 16 <= ap.len() * 64])]
fn bn_get_bits5(ap: &[u64], off: i32) -> i32;

#[bums_macros::check_mem_safe("x86_64-mont5.S", inp.as_ptr(), inp.len(), table.as_mut_ptr(), power, [table.len() == inp.len() * 32, inp.len() >= 1, power < 32])]
fn bn_scatter5(inp: &[u64], table: &mut [u64], power: usize);

#[bums_macros::check_mem_safe("x86_64-mont5.S", out.as_mut_ptr(), out.len(), table.as_ptr(), power, [table.len() == out.len() * 32, out.len() >= 1, power < 32])]
fn bn_gather5(out: &mut [u64], table: &[u64], power: usize);

#[bums_macros::check_mem_safe("rsaz-x86_64.S", ret.as_mut_ptr(), a.as_ptr(), n.as_ptr(), k, cnt, [cnt >= 1])]
fn rsaz_512_sqr(ret: &mut [u64; 8], a: &[u64; 8], n: &[u64; 8], k: u64, cnt: i32);

#[bums_macros::check_mem_safe("rsaz-x86_64.S", ret.as_mut_ptr(), a.as_ptr(), b.as_ptr(), n.as_ptr(), k)]
fn rsaz_512_mul(ret: &mut [u64; 8], a: &[u64; 8], b: &[u64; 8], n: &[u64; 8], k: u64);

#[bums_macros::check_mem_safe("rsaz-x86_64.S", ret.as_mut_ptr(), a.as_ptr(), table.as_ptr(), n.as_ptr(), k, power, [power < 16])]
fn rsaz_512_mul_gather4(ret: &mut [u64; 8], a: &[u64; 8], table: &[u64; 128], n: &[u64; 8], k: u64, power: u32);

#[bums_macros::check_mem_safe("rsaz-x86_64.S", ret.as_mut_ptr(), a.as_ptr(), n.as_ptr(), k, table.as_mut_ptr(), power, [power < 16])]
fn rsaz_512_mul_scatter4(ret: &mut [u64; 8], a: &[u64; 8], n: &[u64; 8], k: u64, table: &mut [u64; 128], power: u32);

#[bums_macros::check_mem_safe("rsaz-x86_64.S", ret.as_mut_ptr(), a.as_ptr(), n.as_ptr(), k)]
fn rsaz_512_mul_by_one(ret: &mut [u64; 8], a: &[u64; 8], n: &[u64; 8], k: u64);

#[bums_macros::check_mem_safe("rsaz-x86_64.S", table.as_mut_ptr(), val.as_ptr(), power, [power >= 0, power < 16])]
fn rsaz_512_scatter4(table: &mut [u64; 128], val: &[u64; 8], power: i32);

#[bums_macros::check_mem_safe("rsaz-x86_64.S", val.as_mut_ptr(), table.as_ptr(), power, [power >= 0, power < 16])]
fn rsaz_512_gather4(val: &mut [u64; 8], table: &[u64; 128], power: i32);

#[bums_macros::check_mem_safe("rsaz-avx2.S", ret.as_mut_ptr(), a.as_ptr(), n.as_ptr(), k, cnt, [cnt >= 1])]
fn rsaz_1024_sqr_avx2(ret: &mut [u64; 40], a: &[u64; 40], n: &[u64; 40], k: u64, cnt: i32);

#[bums_macros::check_mem_safe("rsaz-avx2.S", ret.as_mut_ptr(), a.as_ptr(), b.as_ptr(), n.as_ptr(), k)]
fn rsaz_1024_mul_avx2(ret: &mut [u64; 40], a: &[u64; 40], b: &[u64; 40], n: &[u64; 40], k: u64);

#[bums_macros::check_mem_safe("rsaz-avx2.S", norm.as_mut_ptr(), red.as_ptr())]
fn rsaz_1024_red2norm_avx2(norm: &mut [u64; 16], red: &[u64; 40]);

#[bums_macros::check_mem_safe("rsaz-avx2.S", red.as_mut_ptr(), norm.as_ptr())]
fn rsaz_1024_norm2red_avx2(red: &mut [u64; 40], norm: &[u64; 16]);

#[bums_macros::check_mem_safe("rsaz-avx2.S", table.as_mut_ptr(), val.as_ptr(), power, [power >= 0, power < 32])]
fn rsaz_1024_scatter5_avx2(table: &mut [u32; 1152], val: &[u64; 40], power: i32);

#[bums_macros::check_mem_safe("rsaz-avx2.S", val.as_mut_ptr(), table.as_ptr(), power, [power >= 0, power < 32])]
fn rsaz_1024_gather5_avx2(val: &mut [u64; 40], table: &[u32; 1152], power: i32);

#[bums_macros::check_mem_safe("rsaz-avx2.S")]
fn rsaz_avx2_eligible() -> i32;

#[bums_macros::check_mem_safe("rsaz-2k-avx512.S")]
fn ossl_rsaz_avx512ifma_eligible() -> i32;

#[bums_macros::check_mem_safe("rsaz-2k-avx512.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr(), m.as_ptr(), k0)]
fn ossl_rsaz_amm52x20_x1_ifma256(res: &mut [u64; 20], a: &[u64; 20], b: &[u64; 20], m: &[u64; 20], k0: u64);

#[bums_macros::check_mem_safe("rsaz-2k-avx512.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr(), m.as_ptr(), k0.as_ptr())]
fn ossl_rsaz_amm52x20_x2_ifma256(res: &mut [u64; 40], a: &[u64; 40], b: &[u64; 40], m: &[u64; 40], k0: &[u64; 2]);

#[bums_macros::check_mem_safe("rsaz-2k-avx512.S", y.as_mut_ptr(), table.as_ptr(), idx1, idx2, [idx1 >= 0, idx1 < 32, idx2 >= 0, idx2 < 32])]
fn ossl_extract_multiplier_2x20_win5(y: &mut [u64; 40], table: &[u64; 1280], idx1: i32, idx2: i32);

#[bums_macros::check_mem_safe("rsaz-2k-avxifma.S")]
fn ossl_rsaz_avxifma_eligible() -> i32;

#[bums_macros::check_mem_safe("rsaz-2k-avxifma.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr(), m.as_ptr(), k0)]
fn ossl_rsaz_amm52x20_x1_avxifma256(res: &mut [u64; 20], a: &[u64; 20], b: &[u64; 20], m: &[u64; 20], k0: u64);

#[bums_macros::check_mem_safe("rsaz-2k-avxifma.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr(), m.as_ptr(), k0.as_ptr())]
fn ossl_rsaz_amm52x20_x2_avxifma256(res: &mut [u64; 40], a: &[u64; 40], b: &[u64; 40], m: &[u64; 40], k0: &[u64; 2]);

#[bums_macros::check_mem_safe("rsaz-2k-avxifma.S", y.as_mut_ptr(), table.as_ptr(), idx1, idx2, [idx1 >= 0, idx1 < 32, idx2 >= 0, idx2 < 32])]
fn ossl_extract_multiplier_2x20_win5_avx(y: &mut [u64; 40], table: &[u64; 1280], idx1: i32, idx2: i32);

#[bums_macros::check_mem_safe("rsaz-3k-avx512.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr(), m.as_ptr(), k0)]
fn ossl_rsaz_amm52x30_x1_ifma256(res: &mut [u64; 32], a: &[u64; 32], b: &[u64; 32], m: &[u64; 32], k0: u64);

#[bums_macros::check_mem_safe("rsaz-3k-avx512.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr(), m.as_ptr(), k0.as_ptr())]
fn ossl_rsaz_amm52x30_x2_ifma256(res: &mut [u64; 64], a: &[u64; 64], b: &[u64; 64], m: &[u64; 64], k0: &[u64; 2]);

#[bums_macros::check_mem_safe("rsaz-3k-avx512.S", y.as_mut_ptr(), table.as_ptr(), idx1, idx2, [idx1 >= 0, idx1 < 32, idx2 >= 0, idx2 < 32])]
fn ossl_extract_multiplier_2x30_win5(y: &mut [u64; 64], table: &[u64; 2048], idx1: i32, idx2: i32);

#[bums_macros::check_mem_safe("rsaz-3k-avxifma.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr(), m.as_ptr(), k0)]
fn ossl_rsaz_amm52x30_x1_avxifma256(res: &mut [u64; 32], a: &[u64; 32], b: &[u64; 32], m: &[u64; 32], k0: u64);

#[bums_macros::check_mem_safe("rsaz-3k-avxifma.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr(), m.as_ptr(), k0.as_ptr())]
fn ossl_rsaz_amm52x30_x2_avxifma256(res: &mut [u64; 64], a: &[u64; 64], b: &[u64; 64], m: &[u64; 64], k0: &[u64; 2]);

#[bums_macros::check_mem_safe("rsaz-3k-avxifma.S", y.as_mut_ptr(), table.as_ptr(), idx1, idx2, [idx1 >= 0, idx1 < 32, idx2 >= 0, idx2 < 32])]
fn ossl_extract_multiplier_2x30_win5_avx(y: &mut [u64; 64], table: &[u64; 2048], idx1: i32, idx2: i32);

#[bums_macros::check_mem_safe("rsaz-4k-avx512.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr(), m.as_ptr(), k0)]
fn ossl_rsaz_amm52x40_x1_ifma256(res: &mut [u64; 40], a: &[u64; 40], b: &[u64; 40], m: &[u64; 40], k0: u64);

#[bums_macros::check_mem_safe("rsaz-4k-avx512.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr(), m.as_ptr(), k0.as_ptr())]
fn ossl_rsaz_amm52x40_x2_ifma256(res: &mut [u64; 80], a: &[u64; 80], b: &[u64; 80], m: &[u64; 80], k0: &[u64; 2]);

#[bums_macros::check_mem_safe("rsaz-4k-avx512.S", y.as_mut_ptr(), table.as_ptr(), idx1, idx2, [idx1 >= 0, idx1 < 32, idx2 >= 0, idx2 < 32])]
fn ossl_extract_multiplier_2x40_win5(y: &mut [u64; 80], table: &[u64; 2560], idx1: i32, idx2: i32);

#[bums_macros::check_mem_safe("rsaz-4k-avxifma.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr(), m.as_ptr(), k0)]
fn ossl_rsaz_amm52x40_x1_avxifma256(res: &mut [u64; 40], a: &[u64; 40], b: &[u64; 40], m: &[u64; 40], k0: u64);

#[bums_macros::check_mem_safe("rsaz-4k-avxifma.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr(), m.as_ptr(), k0.as_ptr())]
fn ossl_rsaz_amm52x40_x2_avxifma256(res: &mut [u64; 80], a: &[u64; 80], b: &[u64; 80], m: &[u64; 80], k0: &[u64; 2]);

#[bums_macros::check_mem_safe("rsaz-4k-avxifma.S", y.as_mut_ptr(), table.as_ptr(), idx1, idx2, [idx1 >= 0, idx1 < 32, idx2 >= 0, idx2 < 32])]
fn ossl_extract_multiplier_2x40_win5_avx(y: &mut [u64; 80], table: &[u64; 2560], idx1: i32, idx2: i32);

#[bums_macros::check_mem_safe("keccak1600-x86_64.S", a.as_mut_ptr(), input.as_ptr(), input.len(), r, [r % 8 == 0, r >= 8, r <= 168])]
fn SHA3_absorb(a: &mut [u64; 25], input: &[u8], r: usize) -> usize;

#[bums_macros::check_mem_safe("keccak1600-x86_64.S", a.as_mut_ptr(), out.as_mut_ptr(), out.len(), r, next, [out.len() >= 1, r % 8 == 0, r >= 8, r <= 168])]
fn SHA3_squeeze(a: &mut [u64; 25], out: &mut [u8], r: usize, next: i32);

#[bums_macros::check_mem_safe("keccak1600x4-avx512vl.S")]
fn SHA3_avx512vl_capable() -> i32;

#[bums_macros::check_mem_safe("keccak1600x4-avx512vl.S", out0.as_mut_ptr(), out1.as_mut_ptr(), out2.as_mut_ptr(), out3.as_mut_ptr(), out0.len(), in0.as_ptr(), in1.as_ptr(), in2.as_ptr(), in3.as_ptr(), in0.len(), [out1.len() == out0.len(), out2.len() == out0.len(), out3.len() == out0.len(), in1.len() == in0.len(), in2.len() == in0.len(), in3.len() == in0.len()])]
fn SHA3_shake128_x4_avx512vl(out0: &mut [u8], out1: &mut [u8], out2: &mut [u8], out3: &mut [u8], in0: &[u8], in1: &[u8], in2: &[u8], in3: &[u8]);

#[bums_macros::check_mem_safe("keccak1600x4-avx512vl.S", out0.as_mut_ptr(), out1.as_mut_ptr(), out2.as_mut_ptr(), out3.as_mut_ptr(), out0.len(), in0.as_ptr(), in1.as_ptr(), in2.as_ptr(), in3.as_ptr(), in0.len(), [out1.len() == out0.len(), out2.len() == out0.len(), out3.len() == out0.len(), in1.len() == in0.len(), in2.len() == in0.len(), in3.len() == in0.len()])]
fn SHA3_shake256_x4_avx512vl(out0: &mut [u8], out1: &mut [u8], out2: &mut [u8], out3: &mut [u8], in0: &[u8], in1: &[u8], in2: &[u8], in3: &[u8]);

#[bums_macros::check_mem_safe("keccak1600x4-avx512vl.S", state.as_mut_ptr(), in0.as_ptr(), in1.as_ptr(), in2.as_ptr(), in3.as_ptr(), in0.len(), [in1.len() == in0.len(), in2.len() == in0.len(), in3.len() == in0.len()])]
fn SHA3_shake128_x4_inc_absorb_avx512vl(state: &mut [u64; 101], in0: &[u8], in1: &[u8], in2: &[u8], in3: &[u8]);

#[bums_macros::check_mem_safe("keccak1600x4-avx512vl.S", state.as_mut_ptr(), in0.as_ptr(), in1.as_ptr(), in2.as_ptr(), in3.as_ptr(), in0.len(), [in1.len() == in0.len(), in2.len() == in0.len(), in3.len() == in0.len()])]
fn SHA3_shake256_x4_inc_absorb_avx512vl(state: &mut [u64; 101], in0: &[u8], in1: &[u8], in2: &[u8], in3: &[u8]);

#[bums_macros::check_mem_safe("keccak1600x4-avx512vl.S", state.as_mut_ptr())]
fn SHA3_shake128_x4_inc_finalize_avx512vl(state: &mut [u64; 101]);

#[bums_macros::check_mem_safe("keccak1600x4-avx512vl.S", state.as_mut_ptr())]
fn SHA3_shake256_x4_inc_finalize_avx512vl(state: &mut [u64; 101]);

#[bums_macros::check_mem_safe("keccak1600x4-avx512vl.S", out0.as_mut_ptr(), out1.as_mut_ptr(), out2.as_mut_ptr(), out3.as_mut_ptr(), out0.len(), state.as_mut_ptr(), [out1.len() == out0.len(), out2.len() == out0.len(), out3.len() == out0.len()])]
fn SHA3_shake128_x4_inc_squeeze_avx512vl(out0: &mut [u8], out1: &mut [u8], out2: &mut [u8], out3: &mut [u8], state: &mut [u64; 101]);

#[bums_macros::check_mem_safe("keccak1600x4-avx512vl.S", out0.as_mut_ptr(), out1.as_mut_ptr(), out2.as_mut_ptr(), out3.as_mut_ptr(), out0.len(), state.as_mut_ptr(), [out1.len() == out0.len(), out2.len() == out0.len(), out3.len() == out0.len()])]
fn SHA3_shake256_x4_inc_squeeze_avx512vl(out0: &mut [u8], out1: &mut [u8], out2: &mut [u8], out3: &mut [u8], state: &mut [u64; 101]);

#[bums_macros::check_mem_safe("md5-x86_64.S", ctx.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64, input.len() % 64 == 0])]
fn ossl_md5_block_asm_data_order(ctx: &mut [u32; 4], input: &[u8]);

#[bums_macros::check_mem_safe("ml_dsa_ntt-x86_64.S")]
fn ml_dsa_ntt_avx2_capable() -> i32;

#[bums_macros::check_mem_safe("ml_dsa_ntt-x86_64.S", a.as_ptr(), b.as_ptr(), out.as_mut_ptr())]
fn ml_dsa_poly_ntt_mult_avx2(a: &[u32; 256], b: &[u32; 256], out: &mut [u32; 256]);

#[bums_macros::check_mem_safe("ml_dsa_ntt-x86_64.S", coeff.as_mut_ptr(), zetas.as_ptr())]
fn ml_dsa_poly_ntt_avx2(coeff: &mut [u32; 256], zetas: &[u32; 256]);

#[bums_macros::check_mem_safe("ml_dsa_ntt-x86_64.S", coeff.as_mut_ptr())]
fn ml_dsa_poly_ntt_inverse_avx2(coeff: &mut [u32; 256]);

#[bums_macros::check_mem_safe("poly1305-x86_64.S", ctx.as_mut_ptr(), key.as_ptr(), func.as_mut_ptr())]
fn poly1305_init(ctx: &mut [u64; 24], key: &[u8; 16], func: &mut [usize; 2]) -> i32;

#[bums_macros::check_mem_safe("poly1305-x86_64.S", ctx.as_mut_ptr(), input.as_ptr(), input.len(), padbit, [input.len() % 16 == 0])]
fn poly1305_blocks(ctx: &mut [u64; 24], input: &[u8], padbit: u32);

#[bums_macros::check_mem_safe("poly1305-x86_64.S", ctx.as_mut_ptr(), mac.as_mut_ptr(), nonce.as_ptr())]
fn poly1305_emit(ctx: &mut [u64; 24], mac: &mut [u8; 16], nonce: &[u32; 4]);

#[bums_macros::check_mem_safe("poly1305-x86_64.S", out.as_mut_ptr(), input.as_ptr(), otp.as_mut_ptr(), input.len(), [input.len() >= 1, out.len() == input.len(), otp.len() == (input.len() + 15) / 16 * 16])]
fn xor128_encrypt_n_pad(out: &mut [u8], input: &[u8], otp: &mut [u8]) -> usize;

#[bums_macros::check_mem_safe("poly1305-x86_64.S", out.as_mut_ptr(), input.as_ptr(), otp.as_mut_ptr(), input.len(), [input.len() >= 1, out.len() == input.len(), otp.len() == (input.len() + 15) / 16 * 16])]
fn xor128_decrypt_n_pad(out: &mut [u8], input: &[u8], otp: &mut [u8]) -> usize;

#[bums_macros::check_mem_safe("rc4-x86_64.S", key.as_mut_ptr(), input.len(), input.as_ptr(), output.as_mut_ptr(), [input.len() == output.len()])]
fn RC4(key: &mut [u32; 258], input: &[u8], output: &mut [u8]);

#[bums_macros::check_mem_safe("rc4-x86_64.S", key.as_mut_ptr(), data.len(), data.as_ptr(), [data.len() >= 1, data.len() <= 256])]
fn RC4_set_key(key: &mut [u32; 258], data: &[u8]);

#[bums_macros::check_mem_safe("rc4-x86_64.S")]
fn RC4_options() -> usize;

#[bums_macros::check_mem_safe("rc4-md5-x86_64.S", key.as_mut_ptr(), input.as_ptr(), output.as_mut_ptr(), ctx.as_mut_ptr(), md.as_ptr(), input.len() / 64, [input.len() >= 64, input.len() % 64 == 0, output.len() == input.len(), md.len() == input.len()])]
fn rc4_md5_enc(key: &mut [u32; 258], input: &[u8], output: &mut [u8], ctx: &mut [u32; 4], md: &[u8]);

#[bums_macros::check_mem_safe("sha1-x86_64.S", ctx.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64, input.len() % 64 == 0])]
fn sha1_block_data_order(ctx: &mut [u32; 5], input: &[u8]);

#[bums_macros::check_mem_safe("sha256-x86_64.S", ctx.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64, input.len() % 64 == 0])]
fn sha256_block_data_order(ctx: &mut [u32; 8], input: &[u8]);

#[bums_macros::check_mem_safe("sha512-x86_64.S", ctx.as_mut_ptr(), input.as_ptr(), input.len() / 128, [input.len() >= 128, input.len() % 128 == 0])]
fn sha512_block_data_order(ctx: &mut [u64; 8], input: &[u8]);

#[bums_macros::check_mem_safe("sha1-mb-x86_64.S", ctx.as_mut_ptr(), desc as *const _, num, [num == 1 || num == 2, desc.1 == 1, desc.3 == 1, desc.5 == 1, desc.7 == 1, desc.9 == 1, desc.11 == 1, desc.13 == 1, desc.15 == 1])]
fn sha1_multi_block(ctx: &mut [u32; 40], desc: &(*const [u8; 64], i32, *const [u8; 64], i32, *const [u8; 64], i32, *const [u8; 64], i32, *const [u8; 64], i32, *const [u8; 64], i32, *const [u8; 64], i32, *const [u8; 64], i32), num: i32);

#[bums_macros::check_mem_safe("sha256-mb-x86_64.S", ctx.as_mut_ptr(), desc as *const _, num, [num == 1 || num == 2, desc.1 == 1, desc.3 == 1, desc.5 == 1, desc.7 == 1, desc.9 == 1, desc.11 == 1, desc.13 == 1, desc.15 == 1])]
fn sha256_multi_block(ctx: &mut [u32; 64], desc: &(*const [u8; 64], i32, *const [u8; 64], i32, *const [u8; 64], i32, *const [u8; 64], i32, *const [u8; 64], i32, *const [u8; 64], i32, *const [u8; 64], i32, *const [u8; 64], i32), num: i32);

#[bums_macros::check_mem_safe("aesni-mb-x86_64.S", desc as *const _, key as *const _, num, [key.1 == 9 || key.1 == 11 || key.1 == 13, num == 1 || num == 2, desc.2 == 1, desc.6 == 1, desc.10 == 1, desc.14 == 1, desc.18 == 1, desc.22 == 1, desc.26 == 1, desc.30 == 1])]
fn aesni_multi_cbc_encrypt(desc: &(*const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2]), key: &([u32; 60], u32), num: i32);

#[bums_macros::check_mem_safe("aesni-mb-x86_64.S", desc as *const _, key as *const _, num, [key.1 == 9 || key.1 == 11 || key.1 == 13, num == 1 || num == 2, desc.2 == 1, desc.6 == 1, desc.10 == 1, desc.14 == 1, desc.18 == 1, desc.22 == 1, desc.26 == 1, desc.30 == 1])]
fn aesni_multi_cbc_decrypt(desc: &(*const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2], *const [u8; 16], *mut [u8; 16], i32, [u64; 2]), key: &([u32; 60], u32), num: i32);

#[bums_macros::check_mem_safe("sm3-x86_64.S", ctx.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64, input.len() % 64 == 0])]
fn ossl_hwsm3_block_data_order(ctx: &mut [u32; 8], input: &[u8]);

#[bums_macros::check_mem_safe("sm4-x86_64.S", user_key.as_ptr(), key.as_mut_ptr())]
fn hw_x86_64_sm4_set_key(user_key: &[u8; 16], key: &mut [u32; 32]) -> i32;

#[bums_macros::check_mem_safe("sm4-x86_64.S", input.as_ptr(), output.as_mut_ptr(), key.as_ptr())]
fn hw_x86_64_sm4_encrypt(input: &[u8; 16], output: &mut [u8; 16], key: &[u32; 32]);

#[bums_macros::check_mem_safe("sm4-x86_64.S", input.as_ptr(), output.as_mut_ptr(), key.as_ptr())]
fn hw_x86_64_sm4_decrypt(input: &[u8; 16], output: &mut [u8; 16], key: &[u32; 32]);

#[bums_macros::check_mem_safe("wp-x86_64.S", ctx.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64, input.len() % 64 == 0])]
fn whirlpool_block(ctx: &mut [u64; 8], input: &[u8]);
