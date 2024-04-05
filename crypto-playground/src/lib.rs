use bums_macros;

const SHA256_DIGEST_LENGTH: usize = 32;
const SHA256_CBLOCK: usize = 64;

type SHA256_CTX = Sha256_State_St;

struct Sha256_State_St {
    h: [u32; 8],
    nl: u32,
    nh: u32,
    data: [u8; SHA256_CBLOCK],
    num: usize,
    md_len: usize,
}

fn SHA256(data: *const u8, len: usize, out: *mut u8) -> *mut u8 {
    out
}

fn sha256_digest(msg: &[u8], output: &mut [u8]) {
    SHA256(msg.as_ptr(), msg.len(), output.as_mut_ptr());

    //let result: &mut [u8] = &mut [
    //    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    //    0, 0,
    //];
    //output.copy_from_slice(&result);

    //output
}

#[bums_macros::check_mem_safe("sha256_asm", state.as_ptr(), input.as_mut_ptr(), input.len())]
fn _sha256_block_data_order(state: SHA256_CTX, input: &mut [u8]);

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sha256() {
        let message: &[u8] = &[1, 2, 3, 4, 5, 6, 7, 8, 9];
        let mut output: &mut [u8] = &mut [
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0,
        ];
        //let output: &mut [u8] = todo!();
        sha256_digest(&message, &mut output);
        println!("output:{:?}", output);
    }
}
