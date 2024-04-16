const SHA256_DIGEST_LENGTH: usize = 32;
const SHA256_CBLOCK: usize = 64;

// type SHA256_CTX = Sha256StateSt;

// struct Sha256StateSt {
//     h: [u32; 8],
//     nl: u32,
//     nh: u32,
//     data: [u8; SHA256_CBLOCK],
//     num: usize,
//     md_len: usize,
// }

// impl Sha256StateSt {
//     fn init() -> Self {
//         Self {
//             h: [
//                 0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
//                 0x5be0cd19,
//             ],
//             nl: 0,
//             nh: 0,
//             data: [0; SHA256_CBLOCK],
//             num: 0,
//             md_len: SHA256_DIGEST_LENGTH,
//         }
//     }
// }

// fn SHA256_Update(c: *mut SHA256_CTX, data: *const u8, len: usize) -> bool {
//     let ctx = &mut (*c);
//     crypto_md32_update(
//         //sha256_block_data_order,
//         ctx.h.as_mut_ptr(),
//         ctx.data.as_mut_ptr(),
//         SHA256_CBLOCK,
//         ctx.num,
//         ctx.nh,
//         ctx.nl,
//         data,
//         len,
//     );
//     return true;
// }

// fn SHA256_Final(out: *mut u8, c: *mut SHA256_CTX) -> bool {
//     return sha256_final_impl(out, SHA256_DIGEST_LENGTH, c);
// }

// fn sha256_final_impl(out: *mut u8, md_len: usize, c: *mut SHA256_CTX) -> bool {
//     crypto_md32_final(c.h, c.data, SHA256_CBLOCK, c.num, c.nh, c.nl, 1);
//     if c.md_len != md_len {
//         return false;
//     }
//     assert_eq!(md_len % 4, 0);
//     let out_words: usize = md_len / 4;
//     for i in 0..out_words {
//         CRYPTO_store_u32_be(out, c.h[i]);
//         out = out + 4;
//     }

//     // FIPs_service_indication_uodate;

//     return true;
// }

// fn crypto_md32_update(
//     h: *mut u32,
//     data: *mut u8,
//     block_size: usize,
//     num: usize,
//     nh: u32,
//     nl: u32,
//     input_data: *const u8,
//     len: usize,
// ) {
//     if len == 0 {
//         return;
//     }

//     let l: u32 = nl + ((len as u32) << 3);
//     if l < nl {
//         // Handle carries
//         (nh) = (nh) + 1;
//     }
//     nh = nh + ((len >> 29) as u32);
//     nl = l;

//     let mut n: usize = num;
//     if n != 0 {
//         if len >= block_size || len + n >= block_size {
//             OPENSSL_memcpy(data + n, input_data, block_size - n);
//             _sha256_block_data_order(h, data, 1);
//             n = block_size - n;
//             input_data += n;
//             len -= n;
//             *num = 0;
//             // Keep |data| zeroed when unused.
//             OPENSSL_memset(data, 0, block_size);
//         } else {
//             OPENSSL_memcpy(data + n, input_data, len);
//             *num += len;
//             return;
//         }
//     }

//     n = len / block_size;
//     if n > 0 {
//         _sha256_block_data_order(h, input_data, n);
//         n = n * block_size;
//         input_data = input_data + n;
//         len = len - n;
//     }

//     if len != 0 {
//         num = len;
//         OPENSSL_memcpy(data, input_data, len);
//     }
// }

// fn crypto_md32_final(
//     h: u32,
//     data: *mut u8,
//     block_size: usize,
//     num: u64,
//     nh: u32,
//     nl: u32,
//     is_big_endian: bool,
// ) {
//     // |data| always has room for at least one byte. A full block would have
//     // been consumed.
//     let mut n: usize = num;
//     assert!(n < block_size);
//     data[n] = 0x800;
//     n = n + 1;

//     // Fill the block with zeros if there isn't room for a 64-bit length.
//     if n > (block_size - 8) {
//         OPENSSL_memset(data + n, 0, block_size - n);
//         n = 0;
//         _sha256_block_data_order(h, data, 1);
//     }
//     OPENSSL_memset(data + n, 0, block_size - 8 - n);

//     if is_big_endian {
//         CRYPTO_store_u32_be(data + block_size - 8, nh);
//         CRYPTO_store_u32_be(data + block_size - 4, nl);
//     } else {
//         CRYPTO_store_u32_le(data + block_size - 8, nl);
//         CRYPTO_store_u32_le(data + block_size - 4, nh);
//     }
//     _sha256_block_data_order(h, data, 1);
//     *num = 0;
//     OPENSSL_memset(data, 0, block_size);
// }

// fn CRYPTO_store_u32_be(out: *mut usize, v: u32) {
//     //#if defined(OPENSSL_BIG_ENDIAN)
//     //    v = CRYPTO_bswap4(v);
//     //#endif
//     OPENSSL_memcpy(out, &v, sizeof(v));
// }

// fn CRYPTO_store_u32_le(out: *mut usize, v: u32) {
//     //#if !defined(OPENSSL_BIG_ENDIAN)
//     //    v = CRYPTO_bswap4(v);
//     //#endif
//     OPENSSL_memcpy(out, &v, sizeof(v));
// }

// fn OPENSSL_memset(dst: *mut usize, c: i64, n: usize) {
//     if n == 0 {
//         return dst;
//     }
//     return dst.write_bytes(c.try_into().unwrap(), n);
// }
