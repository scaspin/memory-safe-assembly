use crate::utils::*;
use byteorder::ByteOrder;
use zeroize::Zeroize;

#[derive(Debug)]
#[repr(C)]
pub struct AesKey {
    rd_key: [u32; 4 * (14 + 1)], //14 is the MAX number of AES rounds
    rounds: u32,
}

impl AesKey {
    pub fn new() -> Self {
        return Self {
            rd_key: [0x10; 60],
            rounds: 10,
        };
    }

    pub fn new_from_bytes(bytes: &[u8]) -> Self {
        let mut i = 0;
        let mut rd_key: [u32; 60] = [0; 60];
        let mut rounds = u32::from_le_bytes(bytes[240..244].try_into().unwrap());
        for j in 0..60 {
            rd_key[j] = u32::from_le_bytes(bytes[i..(i + 4)].try_into().unwrap());
            i = i + 4;
        }

        Self { rd_key, rounds }
    }
}

enum AesFunc {
    AesHwCtr32EncryptBlocks,
    VpaesCtr32EncryptBlocks,
}

// available AES assembly functions
// fn aes_hw_set_encrypt_key();
// fn aes_hw_set_decrypt_key();
// fn aes_hw_encrypt();
// fn aes_hw_decrypt();
// fn aes_hw_cbc_encrypt();

//fn aes_hw_ctr32_encrypt_blocks();
// fn aes_hw_xts_encrypt();
// fn aes_hw_xts_decrypt();

// fn aesv8_gcm_8x_enc_128();
// fn aesv8_gcm_8x_dec_128();
// fn aesv8_gcm_8x_enc_192();
// fn aesv8_gcm_8x_dec_192();
// fn aesv8_gcm_8x_enc_256();
// fn aesv8_gcm_8x_dec_256();

// //vpaes
// fn vpaes_encrypt();
// fn vpaes_decrypt();
// fn vpaes_set_encrypt_key();
// fn vpaes_set_decrypt_key();
// fn vpaes_cbc_encrypt();
//fn vpaes_ctr32_encrypt_blocks();

// #[bums_macros::check_mem_safe("aesv8-gcm-armv8.S", input.as_ptr(), input.len()*8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), keys as *const _, htable.as_ptr(), [keys.1 >= 10, keys.1 <= 16, input.len()>64, input.len() == output.len()])]
// fn aes_gcm_enc_kernel(
//     input: &[u8],
//     output: &mut [u8],
//     xi: &mut [u8],
//     ivec: &mut [u8; 16],
//     keys: &([u32; 60], usize),
//     htable: &[u128; 16],
// );

// #[bums_macros::check_mem_safe("aesv8-gcm-armv8.S", input.as_ptr(), input.len()*8, output.as_mut_ptr(), xi.as_mut_ptr(), ivec.as_mut_ptr(), keys as *const _, htable.as_ptr(), [keys.1 >= 10, keys.1 <= 16, input.len()>64, input.len() == output.len()])]
// fn aes_gcm_dec_kernel(
//     input: &[u8],
//     output: &mut [u8],
//     xi: &mut [u8; 16],
//     ivec: &mut [u8; 16],
//     keys: &([u32; 60], usize),
//     htable: &[u128; 16],
// );

// SHOULD REALLY HAVE (rounds == 10 or rounds == 12 or rounds == 14)
#[bums_macros::check_mem_safe("aesv8-armx.S", input.as_ptr(), output.as_mut_ptr(), input.len()/16, keys as *const _, ivec.as_mut_ptr(), [keys.1 >= 10, keys.1 <= 16, input.len()>=16, input.len() == output.len()])]
fn aes_hw_ctr32_encrypt_blocks(
    input: &[u8],
    output: &mut [u8],
    keys: &([u32; 60], u32),
    ivec: &mut [u8; 16],
);

#[bums_macros::check_mem_safe("vpaes-armv8.S", input.as_ptr(), output.as_mut_ptr(), input.len()/16, keys as *const _, ivec.as_mut_ptr(), [keys.1 >= 10, keys.1 <= 16, input.len()>=16, input.len() == output.len()])]
fn vpaes_ctr32_encrypt_blocks(
    input: &[u8],
    output: &mut [u8],
    keys: &([u32; 60], u32),
    ivec: &mut [u8; 16],
);

#[bums_macros::check_mem_safe("vpaes-armv8.S", input.as_ptr(), output.as_mut_ptr(), keys as *const _, [keys.1 >= 10, keys.1 <= 16, input.len()>= 16,input.len() == output.len()])]
fn vpaes_encrypt(input: &[u8], output: &mut [u8], keys: &([u32; 60], u32));

#[allow(non_snake_case)]
pub fn AES_ctr128_encrypt(
    key: &mut AesKey,
    ivec: &mut [u8; 16],
    block_buffer: &mut [u8; 16],
    in_out: &mut [u8],
) {
    // from aws-lc-rs: let mut num = MaybeUninit::<u32>::new(0);
    let mut num: u32 = 0;
    let input_clone: &[u8] = &in_out.to_vec().clone();

    let res = aes_ctr128_encrypt(
        input_clone,
        in_out,
        in_out.len(),
        &mut (key.rd_key, key.rounds),
        ivec,
        block_buffer,
        &mut num,
    );
    match res {
        Ok(_) => Zeroize::zeroize(block_buffer),
        Err(e) => panic!("Error {:?}", e),
    }
}

fn aes_ctr128_encrypt(
    input: &[u8],
    out: &mut [u8],
    len: usize,
    key: &([u32; 60], u32),
    ivec: &mut [u8; 16],
    block_buffer: &mut [u8; 16],
    num: &mut u32,
) -> Result<(), ()> {
    if std::arch::is_aarch64_feature_detected!("aes") {
        crypto_ctr128_encrypt_ctr32(
            input,
            out,
            len,
            key,
            ivec,
            block_buffer,
            num,
            AesFunc::AesHwCtr32EncryptBlocks,
        );
    } else if std::arch::is_aarch64_feature_detected!("sve2-bitperm") {
        if std::arch::is_aarch64_feature_detected!("neon") {
            crypto_ctr128_encrypt_ctr32(
                input,
                out,
                len,
                key,
                ivec,
                block_buffer,
                num,
                AesFunc::VpaesCtr32EncryptBlocks,
            );
        } else {
            crypto_ctr128_encrypt(input, out, len, key, ivec, block_buffer, num);
        }
    } else {
        // crypto_ctr128_encrypt_ctr32(in, out, len, key, ivec, ecount_buf, num, aes_nohw_ctr32_encrypt_blocks);
        // crypto_ctr128_encrypt_ctr32(
        //     input,
        //     out,
        //     len,
        //     key,
        //     ivec,
        //     block_buffer,
        //     num,
        //     AesFunc::aes_nohw_ctr32_encrypt_blocks,
        // );
        unimplemented!();
    }

    Ok(())
}

fn crypto_ctr128_encrypt(
    mut input: &[u8],
    mut output: &mut [u8],
    len: usize,
    key: &([u32; 60], u32),
    ivec: &mut [u8; 16],
    block_buffer: &mut [u8; 16],
    num: &mut u32,
) {
    // assert!(key && ecount_buf && num);
    // assert!(len == 0 || (in && out));
    assert!(*num <= 16);

    let mut n = *num as usize;
    let mut len = len;

    let mut i = 0;
    while (n > 0) && (len > 0) {
        output[i] = input[i] ^ block_buffer[n];
        len = len - 1;
        n = (n + 1) % 16;
        i = i + 1;
    }

    while len >= 16 {
        vpaes_encrypt(ivec, block_buffer, key);
        ctr128_inc(ivec);
        ms_xor16(
            &mut output[0..16]
                .try_into()
                .expect("Must be at least 16 words long"),
            &input[0..16]
                .try_into()
                .expect("Must be at least 16 words long"),
            &block_buffer[0..16]
                .try_into()
                .expect("Must be at least 16 words long"),
        );
        len = len - 16;
        output = &mut output[16..];
        input = &input[16..];
        n = 0
    }

    if len != 0 {
        vpaes_encrypt(ivec, block_buffer, key);
        ctr128_inc(ivec);
        len = len - 1;
        while len > 0 {
            output[n] = input[n] ^ block_buffer[n];
            n = n + 1;
            len = len - 1;
        }
    }

    // can I do this in rust? there must be better way;
    *num = n as u32;
}

fn crypto_ctr128_encrypt_ctr32(
    mut input: &[u8],
    mut output: &mut [u8],
    len: usize,
    key: &([u32; 60], u32),
    ivec: &mut [u8; 16],
    block_buffer: &mut [u8; 16],
    num: &mut u32,
    func: AesFunc,
) {
    // assert!(key && block_buffer && num);
    // assert!(len == 0 || (input && output));
    // assert!(num < 16);

    let mut n = *num as usize;
    let mut len = len;

    let mut i = 0;
    while (n > 0) && (len > 0) {
        output[i] = input[i] ^ block_buffer[n];
        len = len - 1;
        n = (n + 1) % 16;
        i = i + 1;
    }

    input = &input[i..];
    output = &mut output[i..];

    let mut ctr32 = byteorder::BE::read_u32(&mut ivec[12..]);

    while len >= 16 {
        let mut blocks = len / 16;

        // (scaspin) don't think we need to translate this to rust?
        // 1<<28 is just a not-so-small yet not-so-large number...
        // Below condition is practically never met, but it has to
        // be checked for code correctness.
        // if (sizeof(size_t) > sizeof(unsigned int) && blocks > (1U << 28)) {
        //     blocks = (1U << 28);
        //   }

        ctr32 = ctr32 + (blocks as u32);
        if ctr32 < (blocks as u32) {
            blocks = blocks - (ctr32 as usize);
            ctr32 = 0;
        }

        match func {
            AesFunc::AesHwCtr32EncryptBlocks => aes_hw_ctr32_encrypt_blocks(
                &input[0..(blocks * 16)],
                &mut output[0..(blocks * 16)],
                key,
                ivec,
            ),
            AesFunc::VpaesCtr32EncryptBlocks => vpaes_ctr32_encrypt_blocks(
                &input[0..(blocks * 16)],
                &mut output[0..(blocks * 16)],
                key,
                ivec,
            ),
        }

        byteorder::BE::write_u32(&mut ivec[12..], ctr32);
        if ctr32 == 0 {
            ctr96_inc(ivec);
        }
        blocks = blocks * 16;
        len = len - blocks;
        output = &mut output[blocks..];
        input = &input[blocks..];
    }

    if len != 0 {
        ms_memset(block_buffer, 0, 16);
        let block_buffer_input = &block_buffer[0..1].to_vec().clone();
        match func {
            AesFunc::AesHwCtr32EncryptBlocks => {
                aes_hw_ctr32_encrypt_blocks(block_buffer_input, &mut block_buffer[0..1], key, ivec)
            }
            AesFunc::VpaesCtr32EncryptBlocks => {
                vpaes_ctr32_encrypt_blocks(block_buffer_input, &mut block_buffer[0..1], key, ivec)
            }
        }
        ctr32 = ctr32 + 1;
        byteorder::BE::write_u32(&mut ivec[12..], ctr32);
        if ctr32 == 0 {
            ctr96_inc(ivec);
        }
        len = len - 1;
        while len > 0 {
            output[n] = input[n] ^ block_buffer[n];
            n = n + 1;
            len = len - 1;
        }
    }

    // (scaspin) this is a bit icky. FIX? there must be better way;
    *num = n as u32;
}

fn ctr96_inc(counter: &mut [u8]) {
    let mut c: u32 = 1;

    for n in (0..11).rev() {
        c = c + (counter[n] as u32);
        counter[n] = c as u8;
        c = c >> 8;
    }
}

fn ctr128_inc(counter: &mut [u8]) {
    let mut c: u32 = 1;

    for n in (0..11).rev() {
        c = c + (counter[n] as u32);
        counter[n] = c as u8;
        c = c >> 8;
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    mod cipher;

    extern "C" {
        #[link_name = "aws_lc_0_14_1_aes_hw_ctr32_encrypt_blocks"]
        fn aws_aes_hw_ctr32_encrypt_blocks(
            input_as_ptr: *const u8,
            output_as_mut_ptr: *mut u8,
            len: usize,
            keys_as_mut_ptr: *const AesKey,
            ivec_as_mut_ptr: *mut u8,
        );

        #[link_name = "aws_lc_0_14_1_vpaes_ctr32_encrypt_blocks"]
        fn aws_vpaes_ctr32_encrypt_blocks(
            input_as_ptr: *const u8,
            output_as_mut_ptr: *mut u8,
            len: usize,
            keys_as_mut_ptr: *const AesKey,
            ivec_as_mut_ptr: *mut u8,
        );

        #[link_name = "aws_lc_0_14_1_vpaes_encrypt"]
        fn aws_vpaes_encrypt(
            input_as_ptr: *const u8,
            output_as_mut_ptr: *mut u8,
            keys_as_mut_ptr: *const AesKey,
        );

        #[link_name = "aws_lc_0_14_1_AES_encrypt"]
        fn aws_AES_ctr128_encrypt(
            input_as_ptr: *const u8,
            output_as_mut_ptr: *mut u8,
            len: usize,
            keys_as_mut_ptr: *const AesKey,
            ivec_as_mut_ptr: &mut [u8; 16],
            block_buffer: *mut [u8; 16],
            num: *mut u32,
        );

    }

    #[test]
    fn test_aes_hw_ctr32_encrypt_blocks_asm_impl() {
        let input = [0xee; 128];
        let mut output = [0; 128];
        let key = AesKey::new();
        let mut ivec: [u8; 16] = [0xfc; 16];

        let ours = {
            aes_hw_ctr32_encrypt_blocks(&input, &mut output, &(key.rd_key, key.rounds), &mut ivec);
            output
        };

        let theirs = {
            unsafe {
                aws_aes_hw_ctr32_encrypt_blocks(
                    input.as_ptr(),
                    output.as_mut_ptr(),
                    input.len() / 16,
                    &key as *const AesKey,
                    ivec.as_mut_ptr(),
                );
                output
            }
        };
        assert_eq!(ours, theirs);
        assert!(ours != [0; 128]);
    }

    #[test]
    fn test_vpaes_ctr32_encrypt_blocks_asm_impl() {
        let input = [0xee; 128];
        let mut output = [0; 128];
        let key = AesKey::new();
        let mut ivec: [u8; 16] = [0xfc; 16];

        let ours = {
            vpaes_ctr32_encrypt_blocks(&input, &mut output, &(key.rd_key, key.rounds), &mut ivec);
            output
        };

        let theirs = {
            unsafe {
                aws_vpaes_ctr32_encrypt_blocks(
                    input.as_ptr(),
                    output.as_mut_ptr(),
                    input.len() / 16,
                    &key as *const AesKey,
                    ivec.as_mut_ptr(),
                );
                output
            }
        };
        assert_eq!(ours, theirs);
        assert!(ours != [0; 128]);
    }

    #[test]
    fn test_vpaes_encrypt_asm_impl() {
        let input = [0xee; 128];
        let mut output = [0; 128];
        let key = AesKey::new();

        let ours = {
            vpaes_encrypt(&input, &mut output, &(key.rd_key, key.rounds));
            output
        };

        let theirs = {
            unsafe {
                aws_vpaes_encrypt(input.as_ptr(), output.as_mut_ptr(), &key as *const AesKey);
                output
            }
        };
        assert_eq!(ours, theirs);
        assert!(ours != [0; 128]);
    }

    #[test]
    fn test_aes_deterministic() {
        let key1 = &mut AesKey::new();
        let key2 = &mut AesKey::new();
        let ivec1: &mut [u8; 16] = &mut [0; 16];
        let ivec2: &mut [u8; 16] = &mut [0; 16];
        let block_buffer1: &mut [u8; 16] = &mut [0; 16];
        let block_buffer2: &mut [u8; 16] = &mut [0; 16];
        let input_us: &mut [u8] = &mut [0xee; 32];
        let input_them: &mut [u8] = &mut [0xee; 32];

        let ours = {
            AES_ctr128_encrypt(key1, ivec1, block_buffer1, input_us);
            input_us
        };

        let theirs = {
            AES_ctr128_encrypt(key2, ivec2, block_buffer2, input_them);
            input_them
        };
        assert_eq!(ours, theirs);
        assert!(ours != [0xee; 128]);
    }

    #[ignore]
    #[test]
    fn test_aes_against_aws_lc_low_level() {
        let key1 = &mut AesKey::new();
        // let key2 = &mut AesKey::new();
        let key2 = AesKey::new();
        let ivec1: &mut [u8; 16] = &mut [0; 16];
        let ivec2: &mut [u8; 16] = &mut [0; 16];
        let block_buffer1: &mut [u8; 16] = &mut [0; 16];
        let block_buffer2: &mut [u8; 16] = &mut [0; 16];
        let input_us: &mut [u8] = &mut [0xee; 32];
        let input_them: &mut [u8] = &mut [0xee; 32];

        let ours = {
            AES_ctr128_encrypt(key1, ivec1, block_buffer1, input_us);
            input_us
        };

        let theirs = {
            let output: &mut [u8] = &mut [0; 32];
            let num: u32 = 0;
            unsafe {
                let num_ptr = num as *mut u32;
                aws_AES_ctr128_encrypt(
                    input_them.as_ptr(),
                    output.as_mut_ptr(),
                    1,
                    &key2 as *const AesKey,
                    ivec2,
                    block_buffer2,
                    num_ptr,
                );
                input_them
            }
        };
        assert_eq!(ours, theirs);
        assert!(ours != [0xee; 128]);
    }

    #[test]
    fn test_aes_against_aws_lc_rs_public() {
        use crate::aes::tests::cipher::{
            EncryptingKey, EncryptionContext, UnboundCipherKey, AES_128,
        };
        use aws_lc_rs::test::from_hex;

        let key_string = "000102030405060708090a0b0c0d0e0f";
        let key = from_hex(key_string).unwrap();
        let cipher_key = UnboundCipherKey::new(&AES_128, key.as_slice()).unwrap();
        let mut encrypting_key = EncryptingKey::ctr(cipher_key).unwrap();
        let context = encrypting_key
            .algorithm()
            .new_encryption_context(encrypting_key.mode())
            .expect("expect context");

        let key_bytes = encrypting_key.key.key();
        let key = &mut AesKey::new_from_bytes(key_bytes);
        let input_them: &mut [u8; 32] = &mut [0xee; 32];
        let input_us: &mut [u8] = &mut [0xee; 32];

        let ours = {
            let im = match context {
                EncryptionContext::Iv128(ref v) => v.as_ref(),
                _ => &[0; 16],
            };
            let mut ivec = im.clone();
            let block_buffer: &mut [u8; 16] = &mut [0; 16];
            AES_ctr128_encrypt(key, &mut ivec, block_buffer, input_us);
            input_us
        };

        let theirs = {
            let mut in_out = input_them.clone();
            let _ = encrypting_key.less_safe_encrypt(&mut in_out, context);
            in_out
        };
        assert_eq!(ours, theirs);
        assert!(ours != [0xee; 128]);
    }
}
