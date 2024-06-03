#[bums_macros::check_mem_safe("assembly/aws-fips/ghash-neon-armv8.S", htable.as_mut_ptr(), h.as_ptr())]
fn gcm_init_neon(htable: &mut [u128; 16], h: &[u64; 2]);

#[bums_macros::check_mem_safe("assembly/aws-fips/ghash-neon-armv8.S", context.as_mut_ptr(), h.as_ptr())]
fn gcm_gmult_neon(context: &mut [u8; 16], h: &[u64; 2]);

#[bums_macros::check_mem_safe("assembly/aws-fips/ghash-neon-armv8.S", context.as_mut_ptr(), h.as_ptr(), buf.as_ptr(), buf.len() )]
fn gcm_ghash_neon(context: &mut [u8; 16], h: &[u128; 16], buf: &[u8]);

#[cfg(test)]
mod tests {
    use super::*;

    #[allow(improper_ctypes)]
    extern "C" {
        #[link_name = "aws_lc_0_14_1_gcm_init_neon"]
        fn aws_gcm_init_neon(context: *mut u128, input: *const u64);
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
    }
}
