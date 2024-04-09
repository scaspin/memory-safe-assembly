use bums_macros;
use round::round_down;

fn sha256(data: *const u8, len: usize, out: *mut u8) -> *mut u8 {
    // let mut ctx = SHA256_CTX::init();
    // let ctx_pointer = &mut ctx;
    // let update_result = SHA256_Update(ctx_pointer, data, len);
    // let final_result = SHA256_Final(out, ctx_pointer);
    //    if init_result && update_result && final_result {
    //        ();
    //    } else {
    //        ();
    //    }
    //openssl_cleanse
    out
}

pub fn sha256_digest(msg: &[u8], output: &mut [u8]) {
    sha256(msg.as_ptr(), msg.len(), output.as_mut_ptr());
}

fn convert(data: &[u32; 8]) -> [u8; 32] {
    let mut res = [0; 32];
    for i in 0..8 {
        res[4 * i..][..4].copy_from_slice(&data[i].to_le_bytes());
    }
    res
}

pub fn incomplete_sha256_digest(msg: &[u8], output: &mut [u8]) {
    let context: &mut [u32; 8] = &mut [
        0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
        0x5be0cd19,
    ];

    let length = round_down((msg.len() / 64) as f64, 0) as usize;
    println!("length: {:?}", length.clone());
    sha256_block_data_order(context, msg, length);
    output.copy_from_slice(&convert(context));
}

#[bums_macros::check_mem_safe("assembly/processed_sha256_asm.S", context.as_mut_ptr(), input.as_ptr(), input_len)]
fn sha256_block_data_order(context: &mut [u32; 8], input: &[u8], input_len: usize);

//#[bums_macros::check_mem_safe("assembly/processed_sha256_asm.S", context.as_mut_ptr(), input.as_mut_ptr(), input.len())]
//fn sha1_block_data_order(mut context: [u16; 8], input: &mut [u8]);

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sha256_basic_assembly_call_works() {
        let message: &[u8] = &[
            1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 17, 0, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0,
            0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0,
            0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 0, 5, 6, 7, 8, 9, 10, 0, 0, 0,
            0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 17, 0, 5, 6, 7, 8, 9, 10,
        ];
        let mut v = vec![0; 32];
        let mut output: &mut [u8] = v.as_mut_slice();
        incomplete_sha256_digest(&message, &mut output);
        assert_eq!(
            output,
            [
                147, 39, 217, 130, 230, 90, 60, 209, 11, 217, 29, 77, 93, 71, 11, 230, 96, 68, 39,
                221, 173, 237, 178, 19, 39, 236, 157, 179, 128, 6, 146, 135
            ]
        );
    }

    #[test]
    fn test_sha256_basic_assembly_call_deterministic() {
        let message: &[u8] = &[
            1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 5, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 17, 0, 5, 6, 7, 8, 9, 10,
        ];
        let mut v = vec![0; 32];
        let mut output: &mut [u8] = v.as_mut_slice();

        incomplete_sha256_digest(&message, &mut output);
        assert_eq!(
            output,
            [
                62, 195, 214, 54, 26, 118, 175, 180, 23, 23, 13, 202, 169, 238, 76, 119, 176, 221,
                120, 156, 145, 113, 255, 163, 94, 16, 90, 124, 181, 238, 130, 14
            ]
        );
    }

    #[test]
    fn test_sha256_full() {
        let message: &[u8] = &[1, 2, 3, 4, 5, 6, 7, 8, 9];
        let mut v = vec![0; 32];
        let mut output: &mut [u8] = v.as_mut_slice();
        sha256_digest(&message, &mut output);
        assert!(output != message);
    }
}
