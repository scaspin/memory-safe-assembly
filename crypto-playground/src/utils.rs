use byteorder::ByteOrder;
use num_traits::PrimInt;

pub fn ms_memcpy<T: std::marker::Copy>(dst: &mut [T], src: &[T], n: usize) {
    if n == 0 {
        return;
    }
    dst[0..n].copy_from_slice(&src[0..n]);
}

pub fn ms_memset<T: std::clone::Clone>(dst: &mut [T], c: T, n: usize) {
    if n == 0 {
        return;
    }
    dst[0..n].fill(c);
}

pub fn convert(data: &[u32; 8]) -> [u8; 32] {
    let mut res = [0; 32];
    for i in 0..8 {
        res[4 * i..][..4].copy_from_slice(&data[i].to_be_bytes());
    }
    res
}

#[inline]
pub fn ms_addc_u64(x: u64, y: u64, carry_in: bool) -> (u64, bool) {
    // nightly option: x.carrying_add(y, carry_in)
    if carry_in {
        match x.overflowing_add(1) {
            (r, true) => return (r.overflowing_add(y).0, true),
            (r, false) => r.overflowing_add(y),
        }
    } else {
        x.overflowing_add(y)
    }
}

#[inline]
pub fn ms_subc_u64(x: u64, y: u64, carry_in: bool) -> (u64, bool) {
    let ret = x - y - (carry_in as u64);
    (ret, (x < y) | ((x == y) & carry_in))
}

#[inline]
pub fn ms_xor16(output: &mut [u8; 16], a: &[u8; 16], b: &[u8; 16]) {
    // (scaspin) todo from aws-lc: need to check this here too! but don't have crypto_word_t yet
    // TODO(davidben): Ideally we'd leave this to the compiler, which could use
    // vector registers, etc. But the compiler doesn't know that |in| and |out|
    // cannot partially alias. |restrict| is slightly two strict (we allow exact
    // aliasing), but perhaps in-place could be a separate function?
    // OPENSSL_STATIC_ASSERT(16 % sizeof(crypto_word_t) == 0,
    // block_cannot_be_evenly_divided_into_crypto_word_t)

    // TODO: (scaspin) I don't really get what's going on here tbh
    let i = 0;
    while i < 16 {
        byteorder::LE::write_u32(
            &mut output[i..],
            byteorder::LE::read_u32(&a[i..]) ^ byteorder::LE::read_u32(&b[i..]),
        );
    }
}

#[inline]
pub fn constant_time_select<T>(mask: T, a: T, b: T) -> T
where
    T: PrimInt,
{
    mask & a | (!mask & b)
}

#[inline]
pub fn constant_time_msb(a: i64) -> i64 {
    0 - (a >> ((core::mem::size_of::<i64>() as i64) * 8 - 1))
}

#[inline]
pub fn constant_time_is_zero(a: i64) -> i64 {
    constant_time_msb(!a & (a - 1))
}

#[inline]
pub fn constant_time_eq(a: i64, b: i64) -> i64 {
    constant_time_is_zero(a ^ b)
}

#[inline]
pub fn constant_time_lt(a: i64, b: i64) -> i64 {
    constant_time_msb(a ^ ((a ^ b) | ((a - b) ^ a)))
}
