#[cfg(target_arch = "aarch64")]
use bums_macros as bums;

#[allow(dead_code)]
#[allow(unexpected_cfgs)]
mod rav1dsrc;

#[cfg(target_arch = "aarch64")]
mod asm;
#[cfg(target_arch = "aarch64")]
use rav1dsrc::bitdepth::{BitDepth, BitDepth16, BitDepth8};

#[cfg(target_arch = "x86_64")]
mod x86_64;

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), src.as_ptr_range().end, 1, [src.len() == dst.len(), src.len() >= 32, src.len()%32==0])]
fn ipred_reverse_8bpc_neon(dst: &mut [u8], src: &[u8]);

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), src.as_ptr_range().end , src.len()/4, [src.len() == dst.len(), src.len() >= 32, src.len()%32==0])]
fn ipred_reverse_16bpc_neon(dst: &mut [u16], src: &[u16]);

#[cfg(target_arch = "aarch64")]
pub trait CallReverse {
    fn call_reverse(dst: &mut [Self::Pixel], src: &[Self::Pixel]) -> ()
    where
        Self: BitDepth;
}

#[cfg(target_arch = "aarch64")]
impl CallReverse for BitDepth8 {
    fn call_reverse(dst: &mut [u8], src: &[u8]) {
        ipred_reverse_8bpc_neon(dst, src)
    }
}

#[cfg(target_arch = "aarch64")]
impl CallReverse for BitDepth16 {
    fn call_reverse(dst: &mut [u16], src: &[u16]) {
        ipred_reverse_16bpc_neon(dst, src)
    }
}

#[cfg(target_arch = "aarch64")]
pub fn call_reverse<BD: BitDepth + CallReverse>(dst: &mut [BD::Pixel], src: &[BD::Pixel]) {
    BD::call_reverse(dst, src);
}

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("edited-ipred.S", out.as_mut_ptr(), out.len(), in_0.as_ptr(), in_0.len(), 8, [in_0.len() == out.len() * 2 + 1, out.len()>=4, out.len()<=16, out.len()%4==0])]
fn ipred_z1_upsample_edge_8bpc_neon(out: &mut [usize], in_0: &[usize]) -> ();

#[cfg(target_arch = "aarch64")]
#[bums::check_mem_safe("edited-ipred.S", out.as_mut_ptr(), out.len() , in_0.as_ptr(),  in_0.len(), [in_0.len() == out.len() * 2 + 1, out.len()>=4, out.len()<=8, out.len()%4==0])]
fn ipred_z2_upsample_edge_8bpc_neon(out: &mut [usize], in_0: &mut [usize]);

fn main() {
    println!("Hello world!");
}

#[cfg(all(test, target_arch = "aarch64"))]
mod tests {
    use super::*;

    unsafe extern "C" {
        #[link_name = "rav1d_1_0_0_ipred_reverse_8bpc_neon"]
        fn rav1d_ipred_reverse_8bpc_neon(dest: *mut u8, src: *const u8, num: usize);
    }

    #[allow(unreachable_code)]
    #[test]
    fn test_reverse_asm_impls() {
        todo!("figure out linking issues with rav1d");

        let pixel_src: &[u8] = &[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
        let pixel_dest_us: &mut [u8] = &mut [0; 16];
        let pixel_dest_them: &mut [u8] = &mut [0; 16];

        let us = {
            ipred_reverse_8bpc_neon(pixel_dest_us, pixel_src);
            pixel_dest_us
        };

        let them = {
            unsafe {
                rav1d_ipred_reverse_8bpc_neon(pixel_dest_them.as_mut_ptr(), pixel_src.as_ptr(), 4);
                pixel_dest_them
            }
        };

        assert_eq!(us, them);
    }
}
