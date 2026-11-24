#![allow(dead_code)]

#[bums_macros::check_mem_safe("salsa20.S", out.as_mut_ptr(), input.as_ptr())]
fn salsa20_words(out: &mut [u32; 16], input: &[u32; 16]);

#[bums_macros::check_mem_safe("salsa20.S", message.as_mut_ptr(), message.len(), key.as_ptr(), nonce)]
fn salsa20(message: &mut [u8], key: &[u8; 32], nonce: u64);

#[bums_macros::check_mem_safe("chacha20.S", output.as_mut_ptr(), input.as_ptr())]
fn chacha_core(output: &mut [u8; 64], input: &[u32; 16]);

#[bums_macros::check_mem_safe("chacha20.S", out.as_mut_ptr(), input.as_ptr(), input.len(), key.as_ptr(), nonce.as_ptr(), counter, [out.len() == input.len()])]
fn CRYPTO_chacha_20(out: &mut [u8], input: &[u8], key: &[u8; 32], nonce: &[u8; 12], counter: u32);

#[bums_macros::check_mem_safe("poly1305.S", state as *mut _, key.as_ptr())]
fn CRYPTO_poly1305_init(state: &mut ([u32; 14], [u8; 16], usize, [u8; 16]), key: &[u8; 32]);

#[bums_macros::check_mem_safe("poly1305.S", state as *mut _, input.as_ptr(), input.len(), [state.2 < 16])]
fn CRYPTO_poly1305_update(state: &mut ([u32; 14], [u8; 16], usize, [u8; 16]), input: &[u8]);

#[bums_macros::check_mem_safe("poly1305.S", state as *mut _, mac.as_mut_ptr(), [state.2 < 16])]
fn CRYPTO_poly1305_finish(state: &mut ([u32; 14], [u8; 16], usize, [u8; 16]), mac: &mut [u8; 16]);

#[bums_macros::check_mem_safe("poly1305.S", state as *mut _)]
fn poly1305_donna_mul(state: &mut ([u32; 14], [u8; 16], usize, [u8; 16]));

#[bums_macros::check_mem_safe("poly1305.S", state as *mut _, input.as_ptr(), input.len())]
fn poly1305_update(state: &mut ([u32; 14], [u8; 16], usize, [u8; 16]), input: &[u8]);

#[bums_macros::check_mem_safe("sha512.S", state.as_mut_ptr(), data.as_ptr(), num, [data.len() == num * 128])]
fn sha512_block_data_order(state: &mut [u64; 8], data: &[u8], num: usize);

#[bums_macros::check_mem_safe("sha512.S", data.as_ptr(), data.len(), out.as_mut_ptr())]
fn SHA512(data: &[u8], out: &mut [u8; 64]) -> usize;

#[bums_macros::check_mem_safe("x25519.S", out.as_mut_ptr(), in1.as_ptr(), in2.as_ptr())]
fn fe_mul_impl(out: &mut [u64; 5], in1: &[u64; 5], in2: &[u64; 5]);

#[bums_macros::check_mem_safe("x25519.S", s.as_mut_ptr(), f.as_ptr())]
fn fe_tobytes(s: &mut [u8; 32], f: &[u64; 5]);

#[bums_macros::check_mem_safe("x25519.S", out.as_mut_ptr(), z.as_ptr())]
fn fe_loose_invert(out: &mut [u64; 5], z: &[u64; 5]);

#[bums_macros::check_mem_safe("x25519.S", out_shared_key.as_mut_ptr(), private_key.as_ptr(), peer_public_value.as_ptr())]
fn X25519(out_shared_key: &mut [u8; 32], private_key: &[u8; 32], peer_public_value: &[u8; 32]) -> i32;

#[bums_macros::check_mem_safe("ed25519_sign.S", r.as_mut_ptr(), p.as_ptr(), q.as_ptr())]
fn ge_madd(r: &mut [u64; 20], p: &[u64; 20], q: &[u64; 15]);

#[bums_macros::check_mem_safe("ed25519_sign.S", r.as_mut_ptr(), p.as_ptr())]
fn ge_p2_dbl(r: &mut [u64; 20], p: &[u64; 15]);

#[bums_macros::check_mem_safe("ed25519_sign.S", t.as_mut_ptr(), pos, b, [pos >= 0, pos < 32])]
fn table_select(t: &mut [u64; 15], pos: i32, b: i8);

#[bums_macros::check_mem_safe("ed25519_sign.S", h.as_mut_ptr(), a.as_ptr())]
fn x25519_ge_scalarmult_base(h: &mut [u64; 20], a: &[u8; 32]);

#[bums_macros::check_mem_safe("ed25519_sign.S", s.as_mut_ptr())]
fn x25519_sc_reduce(s: &mut [u8; 64]);

#[bums_macros::check_mem_safe("ed25519_sign.S", out_sig.as_mut_ptr(), message.as_ptr(), message.len(), private_key.as_ptr())]
fn ED25519_sign(out_sig: &mut [u8; 64], message: &[u8], private_key: &[u8; 64]) -> i32;

#[bums_macros::check_mem_safe("md5.S", state.as_mut_ptr(), data.as_ptr(), num, [data.len() == num * 64])]
fn md5_block_asm_data_order(state: &mut [u32; 4], data: &[u8], num: usize);

#[bums_macros::check_mem_safe("md5m1.S", state.as_mut_ptr(), data.as_ptr(), num, [data.len() == num * 64])]
fn md5_mutant_extra_block(state: &mut [u32; 4], data: &[u8], num: usize);

#[bums_macros::check_mem_safe("md5m2.S", state.as_mut_ptr(), data.as_ptr(), num, [data.len() == num * 64])]
fn md5_mutant_no_zero_check(state: &mut [u32; 4], data: &[u8], num: usize);
