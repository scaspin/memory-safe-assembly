#[bums_macros::check_mem_safe("ghash-neon-armv8.S", htable.as_mut_ptr(), h.as_ptr())]
fn gcm_init_neon(htable: &mut [u128; 16], h: &[u64; 2]);

#[bums_macros::check_mem_safe("ghash-neon-armv8.S", context.as_mut_ptr(), h.as_ptr())]
fn gcm_gmult_neon(context: &mut [u8; 16], h: &[u128; 16]);

// length in bits, not bytes
#[bums_macros::check_mem_safe("ghash-neon-armv8.S", context.as_mut_ptr(), h.as_ptr(), buf.as_ptr(), buf.len()*8, [buf.len() > 32])]
fn gcm_ghash_neon(context: &mut [u8; 16], h: &[u128; 16], buf: &[u8]);

#[cfg(test)]
mod tests {
    use super::*;

    #[allow(improper_ctypes)]
    extern "C" {
        #[link_name = "aws_lc_0_14_1_gcm_init_neon"]
        fn aws_gcm_init_neon(context: *mut u128, input: *const u64);

        #[link_name = "aws_lc_0_14_1_gcm_gmult_neon"]
        fn aws_gcm_gmult_neon(context: *mut u8, input: *const u128);

        #[link_name = "aws_lc_0_14_1_gcm_ghash_neon"]
        fn aws_gcm_ghash_neon(context: *mut u8, h: *const u128, buf: *const u8, len: usize);
    }

    #[test]
    fn test_gcm_neon_init_call_to_asm() {
        let mut htable: [u128; 16] = [1; 16];
        let h: [u64; 2] = [3; 2];
        let them = {
            unsafe {
                aws_gcm_init_neon(htable.as_mut_ptr(), h.as_ptr());
            }
            htable
        };

        let us = {
            gcm_init_neon(&mut htable, &h);
            htable
        };

        assert_eq!(them, us);
        assert!(us != [1; 16]);
    }

    #[test]
    fn test_gcm_neon_gmult_call_to_asm() {
        let mut xi: [u8; 16] = [1; 16];
        let htable: [u128; 16] = [0xfc; 16];
        let them = {
            unsafe {
                aws_gcm_gmult_neon(xi.as_mut_ptr(), htable.as_ptr());
            }
            htable
        };

        let us = {
            gcm_gmult_neon(&mut xi, &htable);

            htable
        };
        assert_eq!(them, us);
        assert!(us != [1; 16]);
    }

    #[test]
    fn test_gcm_neon_ghash_call_to_asm() {
        let mut xi: [u8; 16] = [1; 16];
        let htable: [u128; 16] = [3; 16];
        let buf: &[u8] = &[0xff; 64];

        let them = {
            unsafe {
                aws_gcm_ghash_neon(xi.as_mut_ptr(), htable.as_ptr(), buf.as_ptr(), buf.len());
            }
            htable
        };

        let us = {
            gcm_ghash_neon(&mut xi, &htable, buf);
            htable
        };
        assert_eq!(them, us);
        assert!(us != [1; 16]);
    }
}

// (aws-lc-rs) aes_128_gcm_siv -> (aes-lc) EVP_aead_aes_128_gcm_siv -> aead_aes_gcm_siv_seal_scatter -> gcm_siv_polyval ->
// CRYPTO_POLYVAL_init :
// CRYPTO_ghash_init -> gcm_init_neon
// CRYPTO_POLYVAL_update_blocks -> gcm_ghash_neon
