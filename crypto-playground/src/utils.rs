pub fn ms_memcpy(dst: &mut [u8], src: &[u8], n: usize) {
    if n == 0 {
        return;
    }
    dst[0..n].copy_from_slice(&src[0..n]);
}

pub fn ms_memset(dst: &mut [u8], c: u8, n: usize) {
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
