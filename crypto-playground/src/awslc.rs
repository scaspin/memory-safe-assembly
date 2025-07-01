#![allow(improper_ctypes)]
extern "C" {
    // fn ecp_nistz256_mul_mont();
    // fn ecp_nistz256_sqr_mont();
    // fn ecp_nistz256_div_by_2();
    // fn ecp_nistz256_mul_by_2();
    // fn ecp_nistz256_mul_by_3();
    // fn ecp_nistz256_sub();
    // fn ecp_nistz256_neg();
    // fn ecp_nistz256_point_double();
    // fn ecp_nistz256_point_add();
    // fn ecp_nistz256_point_add_affine();
    // fn ecp_nistz256_ord_mul_mont();
    // fn ecp_nistz256_ord_sqr_mont();
    // fn ecp_nistz256_select_w5();
    // fn ecp_nistz256_select_w7();
}

#[bums_macros::check_mem_safe("sha512-armv8.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 128, [input.len() >= 128, input.len()%128==0])]
fn sha512_block_data_order(context: &mut [u32; 16], input: &[u8]);

#[bums_macros::check_mem_safe("chacha-armv8.S", out.as_mut_ptr(), in_0.as_ptr(), in_0.len(), keys.as_ptr(), counter.as_ptr(), [in_0.len() == out.len()])]
fn ChaCha20_ctr32(out: &mut [u8], in_0: &[u8], keys: [u32;8], counter: &[u32;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S", output.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_sub(output: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]) -> bool;

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), inp.as_mut_ptr(), inp.len(), r, [inp.len()>=4, inp.len()%4==0, inp.len()>=r])]
fn SHA3_Absorb_hw(a: &mut [u64; 25], inp: &mut [u8], r: usize);

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), inp.as_mut_ptr(), inp.len(), rounds, padd)]
fn SHA3_Squeeze_hw(a: &mut [u64;25], inp: &mut [u8], rounds: usize, padd: i64);

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), inp.as_mut_ptr(), inp.len(), r, [inp.len()>=4, inp.len()%4==0, inp.len()>=r])]
fn SHA3_Absorb_cext(a: &mut [u64; 25], inp: &mut [u8], r: usize);

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), inp.as_mut_ptr(), inp.len(), rounds, padd)]
fn SHA3_Squeeze_cext(a: &mut [u64;25], inp: &mut [u8], rounds: usize, padd: i64);

#[bums_macros::check_mem_safe("chacha20_poly1305_armv8.S", out_ciphertext.as_mut_ptr(), plaintext.as_ptr(), plaintext.len(), ad.as_ptr(), ad.len())]
fn chacha20_poly1305_seal(out_ciphertext: &mut [u8], plaintext: &[u8], ad: &[u8]);

#[bums_macros::check_mem_safe("chacha20_poly1305_armv8.S", out_plaintext.as_mut_ptr(), ciphertext.as_ptr(), out_plaintext.len(), ad.as_ptr(), ad.len())]
fn chacha20_poly1305_open(out_plaintext: &mut [u8], ciphertext: &[u8], ad: &[u8]);

#[bums_macros::check_mem_safe("p256_beeu-armv8-asm.S", out.as_mut_ptr(), a.as_ptr(), n.as_ptr())]
fn beeu_mod_inverse_vartime(out: &mut [u64;4], a: &[u64;4], n: &[u64;4]);

// not used
// #[bums_macros::check_mem_safe("chacha-armv8.S", out.as_mut_ptr(), in_0.as_ptr(), in_0.len(), [in_0.len()==out.len()])]
// fn ChaCha20_ctr32(out: &mut [u8], in_0: &[u8]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_mul_mont(res: &mut [u64;4], a: &[u64;4], b: &[u64;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S",res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_sqr_mont(res: &mut [u64;4], a: &[u64;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S",res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_div_by_2(res: &mut [u64;4], a: &[u64;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S",res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_mul_by_2(res: &mut [u64;4], a: &[u64;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S",res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_mul_by_3(res: &mut [u64;4], a: &[u64;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S",res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_sub(res: &mut [u64;4], a: &[u64;4], b: &[u64;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S",res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_neg(res: &mut [u64;4], a: &[u64;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S",res.as_mut_ptr(), a.as_ptr())]
fn ecp_nistz256_point_double(r: &mut [u64;4], a: &[u64;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_point_add(res: &mut [u64;4], a: &[u64;4], b: &[u64;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_point_add_affine(res: &mut [u64;4], a: &[u64;4], b: &[u64;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_ord_mul_mont(res: &mut [u64;4], a: &[u64;4], b: &[u64;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S", res.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_ord_sqr_mont(res: &mut [u64;4], a: &[u64;4], b: &[u64;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S", val.as_mut_ptr(), in_0.as_ptr(), index, [index >=0, index <=16])]
fn ecp_nistz256_select_w5(val: &mut [u64;16], in_0: &[u64;16], index: usize);

#[bums_macros::check_mem_safe("p256-armv8-asm.S", val.as_mut_ptr(), in_0.as_ptr(), index, [index >=0, index <=64])]
fn ecp_nistz256_select_w5(val: &mut [u64;64], in_0: &[u64;64], index: usize);