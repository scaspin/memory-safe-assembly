use bums_macros as bums;

#[allow(dead_code)]
#[allow(unexpected_cfgs)]
mod rav1dsrc;
use rav1dsrc::bitdepth::{BitDepth, BitDepth16, BitDepth8};

// https://github.com/memorysafety/rav1d/blob/7d7240943d519288fdc9f2b9532b750bd494bf2f/src/ipred.rs#L1595
// wrap_fn_ptr!(unsafe extern "C" fn reverse(
//     dst: *mut DynPixel,
//     src: *const DynPixel,
//     n: c_int,
// ) -> ());
// impl reverse::Fn {
//     pub fn call<BD: BitDepth>(&self, dst: &mut [BD::Pixel], src: &[BD::Pixel], n: c_int) {
//         let dst = dst.as_mut_ptr().cast();
//         let src = src.as_ptr().cast();
//         // SAFETY: We're assuming the asm is actually correct and safe.
//         unsafe { self.get()(dst, src, n) }
//     }
// }
// fn reverse(dst: *mut DynPixel, src: *const DynPixel, n: c_int) -> ();

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), src.as_ptr_range().end, src.len(), [src.len() == dst.len(), src.len() >= 16, src.len()%16==0])]
fn ipred_reverse_8bpc_neon(dst: &mut [u8], src: &[u8]);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), src.as_ptr_range().end ,src.len()/2, [src.len() == dst.len(), src.len() >= 16, src.len()%16==0])]
fn ipred_reverse_16bpc_neon(dst: &mut [u16], src: &[u16]);

pub trait CallReverse {
    fn call_reverse(dst: &mut [Self::Pixel], src: &[Self::Pixel]) -> ()
    where
        Self: BitDepth;
}

impl CallReverse for BitDepth8 {
    fn call_reverse(dst: &mut [u8], src: &[u8]) {
        ipred_reverse_8bpc_neon(dst, src)
    }
}

impl CallReverse for BitDepth16 {
    fn call_reverse(dst: &mut [u16], src: &[u16]) {
        ipred_reverse_16bpc_neon(dst, src)
    }
}

// peel back the rav1d generics over BD::Pixel
pub fn call_reverse<BD: BitDepth + CallReverse>(dst: &mut [BD::Pixel], src: &[BD::Pixel]) {
    BD::call_reverse(dst, src);
}

fn main() {
    println!("Hello world!");
}

#[cfg(test)]
mod tests {
    use super::*;

    extern "C" {
        #[link_name = "rav1d_1_0_0_ipred_reverse_8bpc_neon"]
        fn rav1d_ipred_reverse_8bpc_neon(dest: *mut u8, src: *const u8, num: usize);
    }

    #[test]
    fn test_reverse_asm_impls() {
        let pixel_src: &[u8] = &[0, 1, 2, 3, 4, 5, 6, 7];
        let pixel_dest_us: &mut [u8] = &mut [0; 8];
        let pixel_dest_them: &mut [u8] = &mut [0; 8];

        let us = {
            ipred_reverse_8bpc_neon(pixel_dest_us, pixel_src);
            pixel_dest_us
        };
        let them = {
            unsafe {
                rav1d_ipred_reverse_8bpc_neon(pixel_dest_them.as_mut_ptr(), pixel_src.as_ptr(), 6);
                pixel_dest_them
            }
        };

        assert_eq!(us, them);
    }
}
