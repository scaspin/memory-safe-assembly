#![allow(non_snake_case)]

#[bums_macros::check_mem_safe("chacha-armv8.S", out.as_mut_ptr(), input.as_ptr(), input.len(), key.as_ptr(), counter.as_ptr(), [input.len() > 0, input.len() == out.len()])]
fn ChaCha20_ctr32(out: &mut [u8], input: &[u8], key: &[u32; 8], counter: &[u32; 4]);

#[bums_macros::check_mem_safe("chacha20_poly1305_armv8.S", out_ciphertext.as_mut_ptr(), plaintext.as_ptr(), plaintext.len(), ad.as_ptr(), ad.len(), data.as_mut_ptr(), [plaintext.len() == out_ciphertext.len()])]
fn chacha20_poly1305_seal(
    out_ciphertext: &mut [u8],
    plaintext: &[u8],
    ad: &[u8],
    data: &mut [u8; 64],
);

#[bums_macros::check_mem_safe("chacha20_poly1305_armv8.S", out_plaintext.as_mut_ptr(), ciphertext.as_ptr(), out_plaintext.len(), ad.as_ptr(), ad.len(), data.as_mut_ptr(), [out_plaintext.len() == ciphertext.len()])]
fn chacha20_poly1305_open(
    out_plaintext: &mut [u8],
    ciphertext: &[u8],
    ad: &[u8],
    data: &mut [u8; 48],
);
