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

// extern "C" {
//     // src/ipred.rs
//     fn angular_ipred(
//         dst_ptr: *mut DynPixel,
//         stride: ptrdiff_t,
//         topleft: *const DynPixel,
//         width: c_int,
//         height: c_int,
//         angle: c_int,
//         max_width: c_int,
//         max_height: c_int,
//         bitdepth_max: c_int,
//         _topleft_off: usize,
//         _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
//     ) -> ();

//     fn cfl_ac(
//         ac: &mut [i16; SCRATCH_AC_TXTP_LEN],
//         y_ptr: *const DynPixel,
//         stride: ptrdiff_t,
//         w_pad: c_int,
//         h_pad: c_int,
//         cw: c_int,
//         ch: c_int,
//         _y: *const FFISafe<Rav1dPictureDataComponentOffset>,
//     ) -> ();

//     fn cfl_pred(
//         dst_ptr: *mut DynPixel,
//         stride: ptrdiff_t,
//         topleft: *const DynPixel,
//         width: c_int,
//         height: c_int,
//         ac: &[i16; SCRATCH_AC_TXTP_LEN],
//         alpha: c_int,
//         bitdepth_max: c_int,
//         _topleft_off: usize,
//         _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
//     ) -> ();

//     fn pal_pred(
//         dst_ptr: *mut DynPixel,
//         stride: ptrdiff_t,
//         pal: *const [DynPixel; 8],
//         idx: *const u8,
//         w: c_int,
//         h: c_int,
//         _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
//     ) -> ();

//     fn z13_fill(
//         dst: *mut DynPixel,
//         stride: ptrdiff_t,
//         topleft: *const DynPixel,
//         width: c_int,
//         height: c_int,
//         dxy: c_int,
//         max_base_xy: c_int,
//     ) -> ();

//     fn z2_fill(
//         dst: *mut DynPixel,
//         stride: ptrdiff_t,
//         top: *const DynPixel,
//         left: *const DynPixel,
//         width: c_int,
//         height: c_int,
//         dx: c_int,
//         dy: c_int,
//     ) -> ();

//     fn z1_upsample_edge(
//         out: *mut DynPixel,
//         hsz: c_int,
//         in_0: *const DynPixel,
//         end: c_int,
//         _bitdepth_max: c_int,
//     ) -> ();

//     fn z1_filter_edge(
//         out: *mut DynPixel,
//         sz: c_int,
//         in_0: *const DynPixel,
//         end: c_int,
//         strength: c_int,
//     ) -> ();

//     fn z2_upsample_edge(
//         out: *mut DynPixel,
//         hsz: c_int,
//         in_0: *const DynPixel,
//         _bitdepth_max: c_int,
//     ) -> ();
// }

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

// ptrdiff_t -> isize, c_int -> i32
// #[bums::check_mem_safe("ipred.S", ac.as_ptr(), y, w_pad, h_pad, cw, ch)]
// fn ipred_cfl_ac_420_8bpc_neon(ac: &mut [i16; 1024], y: isize, w_pad: i32, h_pad: i32, cw: i32, ch: i32);

#[bums::check_mem_safe("edited-ipred.S", out.as_mut_ptr(), out.len(), in_0.as_ptr(), -1, [out.len() >= 16, out.len()%16==0, out.len() == in_0.len()])]
fn ipred_z1_upsample_edge_8bpc_neon(out: &mut [u8], in_0: &[u8]) -> ();

#[bums::check_mem_safe("edited-ipred.S", out.as_mut_ptr(), out.len(), in_0.as_ptr(), in_0.len(), strength, [in_0.len() >= 16, in_0.len()%16==0, out.len() == in_0.len()])]
fn ipred_z1_filter_edge_8bpc_neon(out: &mut [u8], in_0: &mut [u8], strength: i32);

#[bums::check_mem_safe("edited-ipred.S", dst.as_mut_ptr(), stride, pal.as_ptr(), idx, w, h)]
fn pal_pred_8bpc_neon(dst: &mut [u8], stride: usize, pal: &[u8; 8], idx: u8, w: u32, h: u32);

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
