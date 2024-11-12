#![allow(improper_ctypes)]
extern "C" {
    // //mont
    // fn bn_mul_mont();

    // //ghash
    pub fn gcm_init_v8(htable: *mut u128, h: *const u64);
    // fn gcm_gmult_v8();
    // fn gcm_ghash_v8();

    // // keccak
    // fn SHA3_Absorb_hw();
    // fn SHA3_Squeeze_hw();
    // fn SHA3_Absorb_cext();
    // fn SHA3_Squeeze_cext();

    // // md5
    pub fn md5_block_asm_data_order(state: *mut u32, data: *const u8, num: usize);

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

    // pub fn sha1_block_data_order(context: *mut u32, input: *const u8, input_len: usize);
    // pub fn sha512_block_data_order(context: *mut u32, input: *const u8, input_len: usize);
}

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
