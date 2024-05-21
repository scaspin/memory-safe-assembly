struct AesKey {
    _rd_key: [u32; 4 * (14 + 1)], //14 is the MAX number of AES rounds
    _rounds: usize,
}

impl AesKey {
    pub fn new() -> Self {
        return Self {
            _rd_key: [0; 60],
            _rounds: 1,
        };
    }
}

extern "C" {
    pub fn aes_gcm_enc_kernel(
        input: *const u8,
        len: usize, // in bits
        output: *mut u8,
        xi: *mut u8,
        ivec: *mut u8,
        key: *const u32,
        htable: *const u128,
    );

    pub fn aes_gcm_dec_kernel(
        input: *const u8,
        len: usize, // in bits
        output: *mut u8,
        xi: *mut u8,
        ivec: *mut u8,
        key: *const u32,
        htable: *const u128,
    );

    // //vpaes
    // fn vpaes_encrypt();
    // fn vpaes_decrypt();
    // fn vpaes_set_encrypt_key();
    // fn vpaes_set_decrypt_key();
    // fn vpaes_cbc_encrypt();
    // fn vpaes_ctr32_encrypt_blocks();

    // //mont
    // fn bn_mul_mont();

    // //ghash
    // fn gcm_init_neon();
    // fn gcm_gmult_neon();
    // fn gcm_ghash_neon();
    // fn gcm_init_v8();
    // fn gcm_gmult_v8();
    // fn gcm_ghash_v8();

    // // keccak
    // fn SHA3_Absorb_hw();
    // fn SHA3_Squeeze_hw();
    // fn SHA3_Absorb_cext();
    // fn SHA3_Squeeze_cext();

    // // md5
    // fn md5_block_asm_data_order();

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

    // //leftover sha
    // fn sha1_block_data_order();
    // fn sha512_block_data_order();

}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_aes_gcm_encrypt_call_to_asm() {
        let input: [u8; 64] = [0; 64];
        let mut output: [u8; 64] = [0; 64];
        let mut xi: [u8; 16] = [0; 16];
        let mut ivec: [u8; 16] = [0; 16];
        let key = AesKey::new();
        let key_ptr = &key as *const AesKey as *const u32;
        let htable: [u128; 16] = [0; 16];

        unsafe {
            aes_gcm_enc_kernel(
                input.as_ptr(),
                input.len() * 8,
                output.as_mut_ptr(),
                xi.as_mut_ptr(),
                ivec.as_mut_ptr(),
                key_ptr,
                htable.as_ptr(),
            );
        }
        assert!(output != [0; 64]);
    }

    #[test]
    fn test_aes_gcm_decrypt_call_to_asm() {
        let input: [u8; 64] = [10; 64];
        let mut output: [u8; 64] = [0; 64];
        let mut xi: [u8; 16] = [0; 16];
        let mut ivec: [u8; 16] = [0; 16];
        let key = AesKey::new();
        let key_ptr = &key as *const AesKey as *const u32;
        let htable: [u128; 16] = [0; 16];

        unsafe {
            aes_gcm_dec_kernel(
                input.as_ptr(),
                input.len() * 8,
                output.as_mut_ptr(),
                xi.as_mut_ptr(),
                ivec.as_mut_ptr(),
                key_ptr,
                htable.as_ptr(),
            );
        }
        assert!(output != [10; 64]);
    }
}
