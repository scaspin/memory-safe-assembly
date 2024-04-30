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
pub fn constant_time_select<T>(mask: T, a: T, b: T) -> T
where
    T: PrimInt,
{
    mask & a | (!mask & b)
}

#[inline]
pub fn constant_time_msb(a: u64) -> u64 {
    0 - (a >> ((core::mem::size_of::<u64>() as u64) * 8 - 1))
}

#[inline]
pub fn constant_time_is_zero(a: u64) -> u64 {
    constant_time_msb(!a & (a - 1))
}

#[inline]
pub fn constant_time_eq(a: u64, b: u64) -> u64 {
    constant_time_is_zero(a ^ b)
}

#[inline]
pub fn constant_time_lt(a: u64, b: u64) -> u64 {
    constant_time_msb(a ^ ((a ^ b) | ((a - b) ^ a)))
}
