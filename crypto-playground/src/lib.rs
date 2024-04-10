use bums_macros;
use round::round_down;

const SHA256_DIGEST_LENGTH: usize = 32;
const SHA256_CBLOCK: usize = 64;

#[allow(non_camel_case_types)]
type SHA256_CTX = Sha256StateSt;

struct Sha256StateSt {
    h: [u32; 8],
    nl: u32,
    nh: u32,
    data: [u8; SHA256_CBLOCK],
    num: usize,
    md_len: usize,
}

impl Sha256StateSt {
    fn init() -> Self {
        Self {
            h: [
                0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
                0x5be0cd19,
            ],
            nl: 0,
            nh: 0,
            data: [0; SHA256_CBLOCK],
            num: 0,
            md_len: SHA256_DIGEST_LENGTH,
        }
    }
}

fn ms_memcpy(dst: &mut [u8], src: &[u8], n: usize) {
    if n == 0 {
        return;
    }
    dst[0..n].copy_from_slice(&src[0..n]);
}

fn ms_memset(dst: &mut [u8], c: u8, n: usize) {
    if n == 0 {
        return;
    }
    dst[0..n].fill(c);
}

fn sha256_update(ctx: &mut SHA256_CTX, msg: &[u8], len: usize) -> Result<(), ()> {
    //call to crypt_md32_update
    let mut len = len;
    let mut msg = msg;

    if len == 0 {
        return Ok(());
    }

    let l = ctx.nl + ((len << 3) as u32);
    if l < ctx.nl {
        ctx.nh = ctx.nh + 1;
    }
    ctx.nh = ctx.nh + ((len >> 29) as u32);
    ctx.nl = l;

    let mut n = ctx.num;
    if n != 0 {
        if len > SHA256_CBLOCK || len + n >= SHA256_CBLOCK {
            ms_memcpy(&mut ctx.data[n..], msg, SHA256_CBLOCK - n);
            sha256_block_data_order(&mut ctx.h, &ctx.data, 1);
            n = SHA256_CBLOCK - n;
            msg = &msg[n..];
            len = len - n;
            ctx.num = 0;
            ms_memset(&mut ctx.data, 0, SHA256_CBLOCK);
        } else {
            ms_memcpy(&mut ctx.data[n..], msg, len);
            ctx.num = ctx.num + (len as usize);
            return Ok(());
        }
    }

    n = len / SHA256_CBLOCK;
    if n > 0 {
        sha256_block_data_order(&mut ctx.h, msg, n);
        n = n * SHA256_CBLOCK;
        msg = &msg[n..];
        len = len - n;
    }

    if len != 0 {
        ctx.num = len as usize;
        ms_memcpy(&mut ctx.data, msg, len);
    }

    Ok(())
}

fn sha256_final(out: &mut [u8], ctx: &mut SHA256_CTX) -> Result<(), ()> {
    // call to crypto_md32_final
    let mut n = ctx.num;
    //assert!(n<SHA256_CBLOCK)
    ctx.data[n] = 0x80;
    n = n + 1;

    if n > (SHA256_CBLOCK - 8) {
        ms_memset(&mut ctx.data[n..], 0, SHA256_CBLOCK - n);
        n = 0;
        sha256_block_data_order(&mut ctx.h, &ctx.data, 1);
    }
    ms_memset(&mut ctx.data[n..], 0, SHA256_CBLOCK - 8 - n);

    // Append a 64-bit length to the block and process it.
    // is big endian = true
    ctx.data[SHA256_CBLOCK - 8] = ctx.nh as u8; // FIX: not sure if right
    ctx.data[SHA256_CBLOCK - 4] = ctx.nl as u8;

    sha256_block_data_order(&mut ctx.h, &ctx.data, 1);
    ctx.num = 0;
    ms_memset(&mut ctx.data, 0, SHA256_CBLOCK);

    if ctx.md_len != SHA256_DIGEST_LENGTH {
        return Err(());
    }

    out.copy_from_slice(&convert(&ctx.h));
    Ok(())
}

fn sha256(data: &[u8], len: usize, out: &mut [u8]) {
    let mut ctx = SHA256_CTX::init();

    // TODO: handle results
    let _ = sha256_update(&mut ctx, data, len);
    let _ = sha256_final(out, &mut ctx);
}

// straight out of aws-cl-rs
// https://github.com/aws/aws-lc-rs/blob/0d8ef6cf53429cfabadbde73a986bd3528054178/aws-lc-rs/src/digest/sha.rs#L212
pub fn sha256_digest(msg: &[u8], output: &mut [u8]) {
    sha256(msg, msg.len(), output);
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
    sha256_block_data_order(context, msg, length);
    output.copy_from_slice(&convert(context));
}

#[bums_macros::check_mem_safe("assembly/sha256-armv8-apple.S", context.as_mut_ptr(), input.as_ptr(), input_len)]
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
        assert_eq!(
            output,
            [
                165, 148, 238, 222, 185, 126, 9, 39, 104, 10, 145, 195, 176, 0, 227, 248, 125, 98,
                238, 3, 49, 147, 246, 175, 241, 168, 84, 157, 37, 223, 105, 41
            ]
        );
    }
}
