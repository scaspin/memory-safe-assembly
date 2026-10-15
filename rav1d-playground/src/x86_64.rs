#![allow(dead_code)]

use bums_macros as bums;

#[bums::check_mem_safe("pal-x86_64.S", dst.as_mut_ptr(), src.as_ptr(), bw, bh, w, h, [64 % bw == 0, bw >= 4, 64 % bh == 0, bh >= 4, w >= 4, w <= bw, w % 4 == 0, h >= 4, h <= bh, h % 4 == 0, src.len() == bw * bh, dst.len() * 2 == src.len()])]
fn dav1d_pal_idx_finish_ssse3(dst: &mut [u8], src: &[u8], bw: usize, bh: usize, w: usize, h: usize);

#[bums::check_mem_safe("pal-x86_64.S", dst.as_mut_ptr(), src.as_ptr(), bw, bh, w, h, [64 % bw == 0, bw >= 4, 64 % bh == 0, bh >= 4, w >= 4, w <= bw, w % 4 == 0, h >= 4, h <= bh, h % 4 == 0, src.len() == bw * bh, dst.len() * 2 == src.len()])]
fn dav1d_pal_idx_finish_avx2(dst: &mut [u8], src: &[u8], bw: usize, bh: usize, w: usize, h: usize);

#[cfg(test)]
mod tests {
    use super::*;

    fn reference(dst: &mut [u8], src: &[u8], bw: usize, bh: usize, w: usize, h: usize) {
        let (dst_w, dst_bw) = (w / 2, bw / 2);
        for y in 0..h {
            let (src, dst) = (&src[y * bw..], &mut dst[y * dst_bw..]);
            for x in 0..dst_w {
                dst[x] = src[2 * x] | (src[2 * x + 1] << 4);
            }
            if dst_w < dst_bw {
                dst[dst_w..dst_bw].fill(0x11 * src[w]);
            }
        }
        if h < bh {
            let (last_row, rest) = dst[(h - 1) * dst_bw..].split_at_mut(dst_bw);
            for row in rest.chunks_exact_mut(dst_bw) {
                row.copy_from_slice(last_row);
            }
        }
    }

    #[test]
    fn ssse3_matches_rav1d_for_every_shape() {
        for bw in [4, 8, 16, 32, 64] {
            for bh in [4, 8, 16, 32, 64] {
                for (w, h) in [(bw, bh), (4, 4), (bw.min(8), bh.min(12)), (bw, 4)] {
                    let src: Vec<u8> = (0..bw * bh)
                        .map(|i| ((i / bw) * bw + (i % bw).min(w - 1)) * 7 % 8)
                        .map(|v| v as u8)
                        .collect();
                    let mut ours = vec![0; bw * bh / 2];
                    let mut theirs = vec![0; bw * bh / 2];
                    dav1d_pal_idx_finish_ssse3(&mut ours, &src, bw, bh, w, h);
                    reference(&mut theirs, &src, bw, bh, w, h);
                    assert_eq!(ours, theirs, "bw {bw} bh {bh} w {w} h {h}");
                }
            }
        }
    }
}
