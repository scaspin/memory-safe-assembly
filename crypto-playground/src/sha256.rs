use crate::utils::*;
use bums_macros;
use byteorder::ByteOrder;
const SHA256_DIGEST_LENGTH: u32 = 32;
const SHA256_CBLOCK: usize = 64;

#[allow(non_camel_case_types)]
type SHA256_CTX = Sha256StateSt;

#[derive(Debug)]
struct Sha256StateSt {
    h: [u32; 8],
    nl: u32,
    nh: u32,
    data: [u8; SHA256_CBLOCK],
    num: u32,
    md_len: u32,
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

    let mut n = ctx.num as usize;
    if n != 0 {
        if len > SHA256_CBLOCK || len + n >= SHA256_CBLOCK {
            ms_memcpy(&mut ctx.data[n..], msg, SHA256_CBLOCK - n);
            sha256_block_data_order(&mut ctx.h, &ctx.data);
            n = SHA256_CBLOCK - n;
            msg = &msg[n..];
            len = len - n;
            ctx.num = 0;
            ms_memset(&mut ctx.data, 0, SHA256_CBLOCK);
        } else {
            ms_memcpy(&mut ctx.data[n..], msg, len);
            ctx.num = ctx.num + len as u32;
            return Ok(());
        }
    }

    n = len / SHA256_CBLOCK;
    if n > 0 {
        sha256_block_data_order(&mut ctx.h, msg);
        n = n * SHA256_CBLOCK;
        msg = &msg[n..];
        len = len - n;
    }

    if len != 0 {
        ctx.num = len as u32;
        ms_memcpy(&mut ctx.data, msg, len);
    }

    Ok(())
}

fn sha256_final(out: &mut [u8], ctx: &mut SHA256_CTX) -> Result<(), ()> {
    // call to crypto_md32_final
    let mut n = ctx.num as usize;
    assert!(n < SHA256_CBLOCK);
    ctx.data[n] = 0x80;
    n = n + 1;

    if n > (SHA256_CBLOCK - 8) {
        ms_memset(&mut ctx.data[n..], 0, SHA256_CBLOCK - n);
        n = 0;
        sha256_block_data_order(&mut ctx.h, &ctx.data[0..64]);
    }
    ms_memset(&mut ctx.data[n..], 0, SHA256_CBLOCK - 8 - n);
    // Append a 64-bit length to the block and process it.
    // is big endian = true
    byteorder::BE::write_u32(&mut ctx.data[(SHA256_CBLOCK - 8)..], ctx.nh);
    byteorder::BE::write_u32(&mut ctx.data[(SHA256_CBLOCK - 4)..], ctx.nl);

    sha256_block_data_order(&mut ctx.h, &ctx.data[0..64]);
    ms_memset(&mut ctx.data, 0, SHA256_CBLOCK);

    if ctx.md_len != SHA256_DIGEST_LENGTH {
        return Err(());
    }

    out.copy_from_slice(&convert(&ctx.h));
    Ok(())
}

fn sha256(data: &[u8], len: usize, out: &mut [u8]) {
    let mut ctx = SHA256_CTX::init();

    sha256_update(&mut ctx, data, len).expect("Update");
    sha256_final(out, &mut ctx).expect("Final");
}

// straight out of aws-cl-rs
// https://github.com/aws/aws-lc-rs/blob/0d8ef6cf53429cfabadbde73a986bd3528054178/aws-lc-rs/src/digest/sha.rs#L212
pub fn sha256_digest(msg: &[u8], output: &mut [u8]) {
    sha256(msg, msg.len(), output);
}

#[bums_macros::check_mem_safe("sha256-armv8.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64])]
fn sha256_block_data_order(context: &mut [u32; 8], input: &[u8]);

#[cfg(test)]
mod tests {
    use super::*;
    use aws_lc_rs::digest::{digest, SHA256};

    extern "C" {
        #[link_name = "aws_lc_0_14_1_sha256_block_data_order"]
        fn aws_sha256_block_data_order(context: *mut u32, input: *const u8, input_len: usize);
    }

    #[test]
    fn test_sha256_asm_impls() {
        let ours = {
            let mut context = [
                0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
                0x5be0cd19,
            ];
            let input = [0xee; 128];
            sha256_block_data_order(&mut context, &input);
            context
        };

        let theirs = {
            let mut context = [
                0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
                0x5be0cd19,
            ];
            let input = [0xee; 128];
            unsafe {
                aws_sha256_block_data_order(context.as_mut_ptr(), input.as_ptr(), input.len() / 64);
            }
            context
        };
        assert_eq!(ours, theirs);
    }

    #[test]
    fn test_sha256_final_step() {
        let mut ctx = aws_lc_sys::SHA256_CTX::default();
        let mut my_ctx = SHA256_CTX::init();

        unsafe {
            aws_lc_sys::SHA256_Init(&mut ctx);
        }

        let ours = {
            let mut out: [u8; 32] = [0; 32];
            sha256_final(&mut out, &mut my_ctx).unwrap();
            out
        };

        let theirs = {
            let mut out: [u8; 32] = [0; 32];
            unsafe {
                aws_lc_sys::SHA256_Final(out.as_mut_ptr(), &mut ctx);
            }
            out
        };
        assert_eq!(ours, theirs);
    }

    #[test]
    fn test_sha256_steps() {
        let mut ctx = aws_lc_sys::SHA256_CTX::default();
        let mut my_ctx = SHA256_CTX::init();
        unsafe {
            aws_lc_sys::SHA256_Init(&mut ctx);
        }

        assert_eq!(ctx.h, my_ctx.h);
        assert_eq!(ctx.Nl, my_ctx.nl);
        assert_eq!(ctx.Nh, my_ctx.nh);
        assert_eq!(ctx.data, my_ctx.data);
        assert_eq!(ctx.num, my_ctx.num);
        assert_eq!(ctx.md_len, my_ctx.md_len);

        let msg = [123; 100];
        unsafe {
            aws_lc_sys::SHA256_Update(&mut ctx, msg.as_ptr() as *const _, msg.len());
        }
        sha256_update(&mut my_ctx, &msg, msg.len()).unwrap();

        assert_eq!(ctx.h, my_ctx.h);
        assert_eq!(ctx.Nl, my_ctx.nl);
        assert_eq!(ctx.Nh, my_ctx.nh);
        assert_eq!(ctx.data, my_ctx.data);
        assert_eq!(ctx.num, my_ctx.num);
        assert_eq!(ctx.md_len, my_ctx.md_len);

        let mut out: [u8; 32] = [0; 32];
        unsafe {
            aws_lc_sys::SHA256_Final(out.as_mut_ptr(), &mut ctx);
        }
        let mut my_out: [u8; 32] = [0; 32];
        sha256_final(&mut my_out, &mut my_ctx).unwrap();

        assert_eq!(ctx.h, my_ctx.h);
        assert_eq!(convert(&ctx.h), out);

        assert_eq!(out, my_out);
    }

    #[test]
    fn test_sha256_full() {
        let message: &[u8] = &[1, 2, 3, 4, 5, 6, 7, 8, 9];
        let mut v = vec![0; 32];
        let mut output: &mut [u8] = v.as_mut_slice();
        sha256_digest(&message, &mut output);
        assert_eq!(output, digest(&SHA256, message).as_ref());
    }
}
