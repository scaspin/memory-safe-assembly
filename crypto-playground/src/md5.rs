#[bums_macros::check_mem_safe("md5-armv8.S", context.as_mut_ptr(), input.as_ptr(), input.len()/64, [input.len() >= 64])]
fn md5_block_asm_data_order(context: &mut [u32; 16], input: &[u8]);

#[cfg(test)]
mod tests {
    use super::*;
    // use aws_lc_rs::digest::{MD5};

    extern "C" {
        #[link_name = "aws_lc_0_22_0_md5_block_asm_data_order"]
        fn aws_md5_block_asm_data_order(context: *mut u32, input: *const u8, input_len: usize);
    }

    #[test]
    fn test_md5_asm_impls() {
        let ours = {
            let mut context: [u32; 16] = [
                0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
                0x5be0cd19, 0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c,
                0x1f83d9ab, 0x5be0cd19,
            ];
            let input = [0xee; 128];
            md5_block_asm_data_order(&mut context, &input);
            context
        };

        let theirs = {
            let mut context: [u32; 16] = [
                0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
                0x5be0cd19, 0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c,
                0x1f83d9ab, 0x5be0cd19,
            ];
            let input = [0xee; 128];
            unsafe {
                aws_md5_block_asm_data_order(
                    context.as_mut_ptr(),
                    input.as_ptr(),
                    input.len() / 64,
                );
            }
            context
        };
        assert_eq!(ours, theirs);
    }

    #[cfg(feature = "nightly")]
    extern crate test;

    #[cfg(feature = "nightly")]
    use rand::Rng;
    #[cfg(feature = "nightly")]
    use test::Bencher;

    #[cfg(feature = "nightly")]
    #[bench]
    pub fn bench_md5_aws_assembly(b: &mut Bencher) {
        let mut rng = rand::thread_rng();

        b.iter(|| {
            let message = vec![rng.gen::<u8>(); 128];
            let mut context: [u32; 16] = [
                0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
                0x5be0cd19, 0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c,
                0x1f83d9ab, 0x5be0cd19,
            ];
            unsafe {
                //aws_sha256_block_data_order(
                aws_md5_block_asm_data_order(
                    context.as_mut_ptr(),
                    message.as_ptr(),
                    message.len() / 64,
                );
            }
            return context;
        })
    }

    #[cfg(feature = "nightly")]
    #[bench]
    pub fn bench_md5_clams_assembly(b: &mut Bencher) {
        let mut rng = rand::thread_rng();

        b.iter(|| {
            let message = vec![rng.gen::<u8>(); 128];
            let mut context: [u32; 16] = [
                0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
                0x5be0cd19, 0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c,
                0x1f83d9ab, 0x5be0cd19,
            ];

            md5_block_asm_data_order(&mut context, &message);
            return context;
        })
    }
}
