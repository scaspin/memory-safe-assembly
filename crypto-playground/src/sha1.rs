use crate::utils::*;
use bums_macros;
use byteorder::ByteOrder;

const SHA1_CBLOCK: usize = 64;

#[derive(Debug)]
struct Sha1Context {
    h: [u32; 5],
    nl: u32,
    nh: u32,
    data: [u8; SHA1_CBLOCK],
    num: u32,
}

impl Sha1Context {
    fn init() -> Self {
        Self {
            h: [0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476, 0xc3d2e1f0],
            nl: 0,
            nh: 0,
            data: [0; SHA1_CBLOCK],
            num: 0,
        }
    }
}

// from aws-lc-rs: https://github.com/aws/aws-lc-rs/blob/671415fa90145746e4424275806ae0946504d044/aws-lc-rs/src/digest/sha.rs#L200
pub fn sha1_digest(msg: &[u8], output: &mut [u8]) {
    sha1(msg, msg.len(), output);
}

fn sha1(data: &[u8], len: usize, out: &mut [u8]) {
    let mut ctx = Sha1Context::init();

    sha1_update(&mut ctx, data, len).expect("Update");
    sha1_final(out, &mut ctx).expect("Final");
}

fn sha1_update(ctx: &mut Sha1Context, msg: &[u8], len: usize) -> Result<(), ()> {
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
        if len > SHA1_CBLOCK || len + n >= SHA1_CBLOCK {
            ms_memcpy(&mut ctx.data[n..], msg, SHA1_CBLOCK - n);
            sha1_block_data_order(&mut ctx.h, &ctx.data);
            n = SHA1_CBLOCK - n;
            msg = &msg[n..];
            len = len - n;
            ctx.num = 0;
            ms_memset(&mut ctx.data, 0, SHA1_CBLOCK);
        } else {
            ms_memcpy(&mut ctx.data[n..], msg, len);
            ctx.num = ctx.num + len as u32;
            return Ok(());
        }
    }

    n = len / SHA1_CBLOCK;
    if n > 0 {
        sha1_block_data_order(&mut ctx.h, msg);
        n = n * SHA1_CBLOCK;
        msg = &msg[n..];
        len = len - n;
    }

    if len != 0 {
        ctx.num = len as u32;
        ms_memcpy(&mut ctx.data, msg, len);
    }

    Ok(())
}

fn sha1_final(out: &mut [u8], ctx: &mut Sha1Context) -> Result<(), ()> {
    // call to crypto_md32_final
    let mut n = ctx.num as usize;
    assert!(n < SHA1_CBLOCK);
    ctx.data[n] = 0x80;
    n = n + 1;

    if n > (SHA1_CBLOCK - 8) {
        ms_memset(&mut ctx.data[n..], 0, SHA1_CBLOCK - n);
        n = 0;
        sha1_block_data_order(&mut ctx.h, &ctx.data[0..64]);
    }
    ms_memset(&mut ctx.data[n..], 0, SHA1_CBLOCK - 8 - n);
    // Append a 64-bit length to the block and process it.
    // is big endian = true
    byteorder::BE::write_u32(&mut ctx.data[(SHA1_CBLOCK - 8)..], ctx.nh);
    byteorder::BE::write_u32(&mut ctx.data[(SHA1_CBLOCK - 4)..], ctx.nl);

    sha1_block_data_order(&mut ctx.h, &ctx.data[0..64]);
    ms_memset(&mut ctx.data, 0, SHA1_CBLOCK);

    out.copy_from_slice(&convert_5(&ctx.h));
    Ok(())
}

#[bums_macros::check_mem_safe("sha1-armv8.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 64, [input.len() >= 64])]
fn sha1_block_data_order(context: &mut [u32; 5], input: &[u8]);

#[cfg(test)]
mod tests {
    use super::*;
    use aws_lc_rs::digest::digest;
    use aws_lc_rs::digest::SHA1_FOR_LEGACY_USE_ONLY as SHA1;

    extern "C" {
        #[link_name = "aws_lc_0_14_1_sha1_block_data_order"]
        fn aws_sha1_block_data_order(context: *mut u32, input: *const u8, input_len: usize);
    }

    #[test]
    fn test_sha1_asm_impls() {
        let mut context_us: [u32; 5] = [0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476, 0xc3d2e1f0];
        let mut context_them = context_us.clone();

        let ours = {
            let input = [0xee; 128];
            sha1_block_data_order(&mut context_us, &input);
            context_us
        };

        let theirs = {
            let input = [0xee; 128];
            unsafe {
                aws_sha1_block_data_order(
                    context_them.as_mut_ptr(),
                    input.as_ptr(),
                    input.len() / 64,
                );
            }
            context_them
        };
        assert_eq!(ours, theirs);
    }

    #[test]
    fn test_sha1_final_step() {
        let mut ctx = aws_lc_sys::SHA_CTX::default();
        let mut my_ctx = Sha1Context::init();

        unsafe {
            aws_lc_sys::SHA1_Init(&mut ctx);
        }

        let ours = {
            let mut out: [u8; 20] = [0; 20];
            sha1_final(&mut out, &mut my_ctx).unwrap();
            out
        };

        let theirs = {
            let mut out: [u8; 20] = [0; 20];
            unsafe {
                aws_lc_sys::SHA1_Final(out.as_mut_ptr(), &mut ctx);
            }
            out
        };
        assert_eq!(ours, theirs);
    }

    #[test]
    fn test_sha1_steps() {
        let mut ctx = aws_lc_sys::SHA_CTX::default();
        let mut my_ctx = Sha1Context::init();
        unsafe {
            aws_lc_sys::SHA1_Init(&mut ctx);
        }

        assert_eq!(ctx.h, my_ctx.h);
        assert_eq!(ctx.Nl, my_ctx.nl);
        assert_eq!(ctx.Nh, my_ctx.nh);
        assert_eq!(ctx.data, my_ctx.data);
        assert_eq!(ctx.num, my_ctx.num);

        let msg = [123; 100];
        unsafe {
            aws_lc_sys::SHA1_Update(&mut ctx, msg.as_ptr() as *const _, msg.len());
        }
        sha1_update(&mut my_ctx, &msg, msg.len()).unwrap();

        assert_eq!(ctx.h, my_ctx.h);
        assert_eq!(ctx.Nl, my_ctx.nl);
        assert_eq!(ctx.Nh, my_ctx.nh);
        assert_eq!(ctx.data, my_ctx.data);
        assert_eq!(ctx.num, my_ctx.num);

        let mut out: [u8; 20] = [0; 20];
        unsafe {
            aws_lc_sys::SHA1_Final(out.as_mut_ptr(), &mut ctx);
        }
        let mut my_out: [u8; 20] = [0; 20];
        sha1_final(&mut my_out, &mut my_ctx).unwrap();

        assert_eq!(ctx.h, my_ctx.h);
        assert_eq!(convert_5(&ctx.h), out);

        assert_eq!(out, my_out);
    }

    #[test]
    fn test_sha1_full() {
        let message: &[u8] = &[1, 2, 3, 4, 5, 6, 7, 8, 9];
        let mut v = vec![0; 20];
        let mut output: &mut [u8] = v.as_mut_slice();
        sha1_digest(&message, &mut output);
        assert_eq!(output, digest(&SHA1, message).as_ref());
    }
}
