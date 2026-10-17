use bums_macros as bums;

#[bums::check_mem_safe("crc.S", ctx.as_ptr(), crc, buffer.as_ptr(), length,
    [ctx.len() == 17, buffer.len() == length, length <= 1099511627776])]
fn ff_crc32_aarch64(ctx: &[u32], crc: u32, buffer: &[u8], length: usize);

#[bums::check_mem_safe("crc.S", ctx.as_ptr(), crc, buffer.as_ptr(), length,
    [ctx.len() == 17, buffer.len() == length, length <= 1099511627776])]
fn ff_crc_neon_pmull(ctx: &[u32], crc: u32, buffer: &[u8], length: usize);

#[bums::check_mem_safe("crc.S", ctx.as_ptr(), crc, buffer.as_ptr(), length,
    [ctx.len() == 17, buffer.len() == length, length <= 1099511627776])]
fn ff_crc_le_neon_pmull(ctx: &[u32], crc: u32, buffer: &[u8], length: usize);

#[bums::check_mem_safe("base64.S", out.as_mut_ptr(), input.as_ptr(), in_size, tbl.as_ptr(),
    [out.len() == (in_size + 2) / 3 * 4 + 1, input.len() == in_size, tbl.len() == 64, in_size >= 48, in_size <= 1073741823])]
fn ff_base64_encode_neon(out: &mut [u8], input: &[u8], in_size: usize, tbl: &[u8]);

#[bums::check_mem_safe("pixelutils_neon.S", src1.as_ptr(), stride1, src2.as_ptr(), stride2,
    [src1.len() == 7 * stride1 + 8, src2.len() == 7 * stride2 + 8, stride1 >= 8, stride2 >= 8, stride1 <= 1073741824, stride2 <= 1073741824])]
fn ff_pixelutils_sad8_neon(src1: &[u8], stride1: usize, src2: &[u8], stride2: usize);

#[bums::check_mem_safe("pixelutils_neon.S", src1.as_ptr(), stride1, src2.as_ptr(), stride2,
    [src1.len() == 15 * stride1 + 16, src2.len() == 15 * stride2 + 16, stride1 >= 16, stride2 >= 16, stride1 <= 1073741824, stride2 <= 1073741824])]
fn ff_pixelutils_sad16_neon(src1: &[u8], stride1: usize, src2: &[u8], stride2: usize);

#[bums::check_mem_safe("pixelutils_neon.S", src1.as_ptr(), stride1, src2.as_ptr(), stride2,
    [src1.len() == 31 * stride1 + 32, src2.len() == 31 * stride2 + 32, stride1 >= 32, stride2 >= 32, stride1 <= 1073741824, stride2 <= 1073741824])]
fn ff_pixelutils_sad32_neon(src1: &[u8], stride1: usize, src2: &[u8], stride2: usize);

#[bums::check_mem_safe("aes.S", a.as_ptr(), dst.as_mut_ptr(), src.as_ptr(), count, iv.as_mut_ptr(), rounds,
    [a.len() == 288, dst.len() == 16 * count, src.len() == 16 * count, iv.len() == 16, count <= 67108864, rounds == 10])]
fn ff_aes_encrypt_10_neon(a: &[u8], dst: &mut [u8], src: &[u8], count: usize, iv: &mut [u8], rounds: usize);

#[bums::check_mem_safe("aes.S", a.as_ptr(), dst.as_mut_ptr(), src.as_ptr(), count, iv.as_mut_ptr(), rounds,
    [a.len() == 288, dst.len() == 16 * count, src.len() == 16 * count, iv.len() == 16, count <= 67108864, rounds == 12])]
fn ff_aes_encrypt_12_neon(a: &[u8], dst: &mut [u8], src: &[u8], count: usize, iv: &mut [u8], rounds: usize);

#[bums::check_mem_safe("aes.S", a.as_ptr(), dst.as_mut_ptr(), src.as_ptr(), count, iv.as_mut_ptr(), rounds,
    [a.len() == 288, dst.len() == 16 * count, src.len() == 16 * count, iv.len() == 16, count <= 67108864, rounds == 14])]
fn ff_aes_encrypt_14_neon(a: &[u8], dst: &mut [u8], src: &[u8], count: usize, iv: &mut [u8], rounds: usize);

#[bums::check_mem_safe("aes.S", a.as_ptr(), dst.as_mut_ptr(), src.as_ptr(), count, iv.as_mut_ptr(), rounds,
    [a.len() == 288, dst.len() == 16 * count, src.len() == 16 * count, iv.len() == 16, count <= 67108864, rounds == 10])]
fn ff_aes_decrypt_10_neon(a: &[u8], dst: &mut [u8], src: &[u8], count: usize, iv: &mut [u8], rounds: usize);

#[bums::check_mem_safe("aes.S", a.as_ptr(), dst.as_mut_ptr(), src.as_ptr(), count, iv.as_mut_ptr(), rounds,
    [a.len() == 288, dst.len() == 16 * count, src.len() == 16 * count, iv.len() == 16, count <= 67108864, rounds == 12])]
fn ff_aes_decrypt_12_neon(a: &[u8], dst: &mut [u8], src: &[u8], count: usize, iv: &mut [u8], rounds: usize);

#[bums::check_mem_safe("aes.S", a.as_ptr(), dst.as_mut_ptr(), src.as_ptr(), count, iv.as_mut_ptr(), rounds,
    [a.len() == 288, dst.len() == 16 * count, src.len() == 16 * count, iv.len() == 16, count <= 67108864, rounds == 14])]
fn ff_aes_decrypt_14_neon(a: &[u8], dst: &mut [u8], src: &[u8], count: usize, iv: &mut [u8], rounds: usize);
