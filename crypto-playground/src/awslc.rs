#![allow(improper_ctypes)]
extern "C" {

    fn chacha20_poly1305_seal();

    fn chacha20_poly1305_open();

    // //mont

    // //ghash
    // pub fn gcm_init_v8(htable: *mut u128, h: *const u64);
    // fn gcm_gmult_v8();
    // fn gcm_ghash_v8();

    // // keccak
    // fn SHA3_Absorb_hw();
    // fn SHA3_Squeeze_hw();
    fn SHA3_Absorb_cext();
    fn SHA3_Squeeze_cext();

    // //p256
    // fn beeu_mod_inverse_vartime();
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

// #[bums_macros::check_mem_safe("chacha-armv8.S", out.as_mut_ptr(), in_0.as_ptr(), in_0.len(), keys.as_ptr(), counter.as_ptr())]
// fn ChaCha20_ctr32(out: &mut [u8], in_0: &[u8], keys: [u32;8], counter: &[u32;4]);

#[bums_macros::check_mem_safe("p256-armv8-asm.S", output.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ecp_nistz256_sub(output: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]) -> bool;

#[bums_macros::check_mem_safe("p256-armv8-asm.S", x0.as_mut_ptr(), x1.as_ptr())]
fn ecp_nistz256_div_by_2(x0: &mut [u64; 4], x1: &[u64; 4]) -> bool;

// #[bums_macros::check_mem_safe("p256_beeu-armv8-asm.S", out.as_ptr(), a.as_ptr(), n.as_ptr())]
// fn beeu_mod_inverse_vartime(out: &[u64;4], a:&[u64;4], n:&[u64;4]);

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), inp.as_mut_ptr(), inp.len(), r, [inp.len()>=4, inp.len()%4==0, inp.len()>=r])]
fn SHA3_Absorb_hw(a: &mut [u64; 25], inp: &mut [u8], r: usize);

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), inp.as_mut_ptr(), inp.len(), rounds, padd)]
fn SHA3_Squeeze_hw(a: &mut [u64;25], inp: &mut [u8], rounds: usize, padd: i64);

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn test_gcm_init_v8_call_to_asm() {
        let mut htable: [u128; 16] = [1; 16];
        let h: [u64; 2] = [3; 2];
        unsafe {
            gcm_init_v8(htable.as_mut_ptr(), h.as_ptr());
        }
        assert!(htable != [1; 16]);
    }

    #[test]
    fn test_md5_block_asm_data_order_call_to_asm() {
        let mut context = [
            0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
            0x5be0cd19,
        ];
        let input = [0xee; 64];
        unsafe { md5_block_asm_data_order(context.as_mut_ptr(), input.as_ptr(), input.len()) }
        assert!(
            context
                != [
                    0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c,
                    0x1f83d9ab, 0x5be0cd19,
                ]
        );
    }
}
