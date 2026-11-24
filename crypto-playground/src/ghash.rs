#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("ghash-neon-armv8.S", htable.as_mut_ptr(), h.as_ptr())]
fn gcm_init_neon(htable: &mut [u128; 16], h: &[u64; 2]);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("ghash-neon-armv8.S", context.as_mut_ptr(), h.as_ptr())]
fn gcm_gmult_neon(context: &mut [u8; 16], h: &[u128; 16]);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("ghash-neon-armv8.S", context.as_mut_ptr(), h.as_ptr(), buf.as_ptr(), buf.len(), [buf.len() >= 16, buf.len()%16==0])]
fn gcm_ghash_neon(context: &mut [u8; 16], h: &[u128; 16], buf: &[u8]);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("ghashv8-armx.S", htable.as_mut_ptr(), h.as_ptr())]
fn gcm_init_v8(htable: &mut [u128; 16], h: &[u64; 2]);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("ghashv8-armx.S", context.as_mut_ptr(), h.as_ptr())]
fn gcm_gmult_v8(context: &mut [u8; 16], h: &[u128; 16]);

#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("ghashv8-armx.S", context.as_mut_ptr(), h.as_ptr(), buf.as_ptr(), buf.len(), [buf.len() >= 16, buf.len()%16==0])]
fn gcm_ghash_v8(context: &mut [u8; 16], h: &[u128; 16], buf: &[u8]);

#[cfg(target_arch = "x86_64")]
#[bums_macros::check_mem_safe("ghash-x86_64.S", htable.as_mut_ptr(), h.as_ptr())]
fn gcm_init_clmul(htable: &mut [u128; 16], h: &[u64; 2]);

#[cfg(target_arch = "x86_64")]
#[bums_macros::check_mem_safe("ghash-x86_64.S", context.as_mut_ptr(), h.as_ptr())]
fn gcm_gmult_clmul(context: &mut [u8; 16], h: &[u128; 16]);

#[cfg(target_arch = "x86_64")]
#[bums_macros::check_mem_safe("ghash-x86_64.S", context.as_mut_ptr(), h.as_ptr(), buf.as_ptr(), buf.len(), [buf.len() >= 16, buf.len()%16==0])]
fn gcm_ghash_clmul(context: &mut [u8; 16], h: &[u128; 16], buf: &[u8]);

#[cfg(all(test, target_arch = "x86_64"))]
mod x86_64_tests {
    use super::*;

    #[allow(improper_ctypes)]
    unsafe extern "C" {
        #[link_name = "aws_lc_0_44_0_gcm_init_clmul"]
        fn aws_gcm_init_clmul(context: *mut u128, input: *const u64);

        #[link_name = "aws_lc_0_44_0_gcm_gmult_clmul"]
        fn aws_gcm_gmult_clmul(context: *mut u8, input: *const u128);

        #[link_name = "aws_lc_0_44_0_gcm_ghash_clmul"]
        fn aws_gcm_ghash_clmul(context: *mut u8, h: *const u128, buf: *const u8, len: usize);
    }

    #[test]
    fn test_gcm_clmul_init_call_to_asm() {
        let h: [u64; 2] = [3; 2];
        let mut theirs: [u128; 16] = [1; 16];
        unsafe { aws_gcm_init_clmul(theirs.as_mut_ptr(), h.as_ptr()) };
        let mut ours: [u128; 16] = [1; 16];
        gcm_init_clmul(&mut ours, &h);
        assert_eq!(ours, theirs);
        assert!(ours != [1; 16]);
    }

    #[test]
    fn test_gcm_clmul_gmult_call_to_asm() {
        let mut htable: [u128; 16] = [1; 16];
        gcm_init_clmul(&mut htable, &[3; 2]);
        let mut theirs: [u8; 16] = [1; 16];
        unsafe { aws_gcm_gmult_clmul(theirs.as_mut_ptr(), htable.as_ptr()) };
        let mut ours: [u8; 16] = [1; 16];
        gcm_gmult_clmul(&mut ours, &htable);
        assert_eq!(ours, theirs);
        assert!(ours != [1; 16]);
    }

    #[test]
    fn test_gcm_clmul_ghash_call_to_asm() {
        let mut htable: [u128; 16] = [1; 16];
        gcm_init_clmul(&mut htable, &[3; 2]);
        let buf: &[u8] = &[0xff; 16 * 9];
        let mut theirs: [u8; 16] = [1; 16];
        unsafe {
            aws_gcm_ghash_clmul(
                theirs.as_mut_ptr(),
                htable.as_ptr(),
                buf.as_ptr(),
                buf.len(),
            )
        };
        let mut ours: [u8; 16] = [1; 16];
        gcm_ghash_clmul(&mut ours, &htable, buf);
        assert_eq!(ours, theirs);
        assert!(ours != [1; 16]);
    }
}

#[cfg(all(test, target_arch = "aarch64"))]
mod tests {
    use super::*;

    #[allow(improper_ctypes)]
    unsafe extern "C" {
        #[link_name = "aws_lc_0_44_0_gcm_init_neon"]
        fn aws_gcm_init_neon(context: *mut u128, input: *const u64);

        #[link_name = "aws_lc_0_44_0_gcm_gmult_neon"]
        fn aws_gcm_gmult_neon(context: *mut u8, input: *const u128);

        #[link_name = "aws_lc_0_44_0_gcm_ghash_neon"]
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
