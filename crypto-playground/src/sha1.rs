use bums_macros;

/// The length of a block for SHA-1, in bytes.
const SHA1_BLOCK_LEN: usize = 512 / 8;

/// The length of the output of SHA-1, in bytes.
pub const SHA1_OUTPUT_LEN: usize = 160 / 8;

// // straight out of aws-cl-rs
// // https://github.com/aws/aws-lc-rs/blob/0d8ef6cf53429cfabadbde73a986bd3528054178/aws-lc-rs/src/digest/sha.rs#L212
// pub fn sha256_digest(msg: &[u8], output: &mut [u8]) {
//     sha256(msg, msg.len(), output);
// }

#[bums_macros::check_mem_safe("sha1-armv8.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64])]
fn sha1_block_data_order(context: &mut [u8; 20], input: &[u8]);

#[cfg(test)]
mod tests {
    use super::*;
    use aws_lc_rs::digest::{digest, SHA1};

    extern "C" {
        #[link_name = "aws_lc_0_14_1_sha1_block_data_order"]
        fn aws_sha1_block_data_order(context: *mut u32, input: *const u8, input_len: usize);
    }

    #[test]
    fn test_sha1_asm_impls() {
        let ours = {
            let mut context = [
                0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
                0x5be0cd19,
            ];
            let input = [0xee; 128];
            sha1_block_data_order(&mut context, &input);
            context
        };

        let theirs = {
            let mut context = [
                0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
                0x5be0cd19,
            ];
            let input = [0xee; 128];
            unsafe {
                aws_sha1_block_data_order(context.as_mut_ptr(), input.as_ptr(), input.len() / 64);
            }
            context
        };
        assert_eq!(ours, theirs);
    }
}
