#[bums_macros::check_mem_safe("md5-armv8.S", context.as_mut_ptr(), input.as_ptr(), input.len()/64, [input.len() >= 64])]
fn md5_block_asm_data_order(context: &mut [u32; 16], input: &[u8]);

#[cfg(test)]
mod tests {
    use super::*;
    // use aws_lc_rs::digest::{MD5};

    extern "C" {
        #[link_name = "aws_lc_0_14_1_md5_block_asm_data_order"]
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
}
