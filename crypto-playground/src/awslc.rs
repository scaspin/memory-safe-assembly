#![allow(improper_ctypes)]
extern "C" {
    // AES
    // fn aes_hw_set_encrypt_key();
    // fn aes_hw_set_decrypt_key();
    // fn aes_hw_encrypt();
    // fn aes_hw_decrypt();
    // fn aes_hw_cbc_encrypt();

    pub fn aes_hw_ctr32_encrypt_blocks(
        input: *const u8,
        output: *mut u8,
        len: usize,
        key: *const u32,
        ivec: *const u8,
    );
    // fn aes_hw_xts_encrypt();
    // fn aes_hw_xts_decrypt();

    // fn aesv8_gcm_8x_enc_128();
    // fn aesv8_gcm_8x_dec_128();
    // fn aesv8_gcm_8x_enc_192();
    // fn aesv8_gcm_8x_dec_192();
    // fn aesv8_gcm_8x_enc_256();
    // fn aesv8_gcm_8x_dec_256();

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

    // H is passed to |gcm_init_*| as a pair of byte-swapped, 64-bit values.
    // htable: [u128;16], h: [u64;2]
    pub fn gcm_init_neon(htable: *mut u128, h: *const u64);
    // fn gcm_gmult_neon();
    // fn gcm_ghash_neon();
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

    pub fn sha1_block_data_order(context: *mut u32, input: *const u8, input_len: usize);
    pub fn sha512_block_data_order(context: *mut u32, input: *const u8, input_len: usize);
}

#[cfg(test)]
mod tests {
    use super::*;
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

    // TODO: fix, access to undefined memory!
    // #[test]
    // fn test_aes_hw_ctr32_encrypt_blocks_call_to_asm() {
    //     let input: [u8; 64] = [0; 64];
    //     let mut output: [u8; 64] = [0; 64];
    //     let mut ivec: [u8; 16] = [0; 16];
    //     let key = AesKey::new();
    //     let key_ptr = &key as *const AesKey as *const u32;

    //     unsafe {
    //         aes_hw_ctr32_encrypt_blocks(
    //             input.as_ptr(),
    //             output.as_mut_ptr(),
    //             input.len() ,
    //             key_ptr,
    //             ivec.as_mut_ptr(),
    //         )
    //     }
    // }

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

    #[test]
    fn test_gcm_neon_init_call_to_asm() {
        let mut htable: [u128; 16] = [1; 16];
        let h: [u64; 2] = [3; 2];
        unsafe {
            gcm_init_neon(htable.as_mut_ptr(), h.as_ptr());
        }
        assert!(htable != [1; 16]);
    }

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
