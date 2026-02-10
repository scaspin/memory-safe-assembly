use bums_macros as bums;

#[allow(dead_code)]
#[allow(unexpected_cfgs)]
mod rav1dsrc;
use rav1dsrc::bitdepth::{BitDepth, BitDepth16, BitDepth8};

use crate::rav1dsrc::bitdepth;

fn main() {
    println!("Hello world!");
}

// **********************
//
// CDEF
//
// **********************

//cdef_paddingX_8bpc_neon
#[bums_macros::check_mem_safe("cdef.S", out.as_mut_ptr(), out.len(), in_0.as_ptr(), in_0.len(), width, height, pad)]
fn cdef_padding4_8bpc_neon(out: &mut [u8], in_0: &[u8], width: usize, height: usize, pad: usize);

// cdef_paddingX_edged_8bpc_neon
#[bums_macros::check_mem_safe("cdef.S", out.as_mut_ptr(), out.len(), in_0.as_ptr(), in_0.len(), width, height, pad)]
fn cdef_padding8_edged_8bpc_neon(
    out: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pad: usize,
);

#[bums_macros::check_mem_safe("cdef.S", out.as_mut_ptr(), out.len(), in_0.as_ptr(), in_0.len(), width, height, pad)]
fn cdef_padding4_edged_8bpc_neon(
    out: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pad: usize,
);

// cdef_filterX_edged_8bpc_neon
#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter8_pri_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter8_sec_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter8_pri_sec_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter8_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter4_pri_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter4_sec_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter4_pri_sec_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter4_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

// cdef_find_dir_\bpc()bpc_neon
#[bums_macros::check_mem_safe("cdef.S", img.as_ptr(), stride, bitdepth_max)]
fn cdef_find_dir_8bpc_neon(img: &[u8], stride: usize, bitdepth_max: i32) -> i32;

// cdef_filter\w()_\bpc()bpc_neon
#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter8_pri_edged_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter8_sec_edged_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter8_pri_sec_edged_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter4_pri_edged_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter4_sec_edged_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

#[bums_macros::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst.len(), in_0.as_ptr(), in_0.len(), width, height, pri_strength, sec_strength, dir, damping)]
fn cdef_filter4_pri_sec_edged_8bpc_neon(
    dst: &mut [u8],
    in_0: &[u8],
    width: usize,
    height: usize,
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
);

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

//     fn z1_filter_edge(
//         out: *mut DynPixel,
//         sz: c_int,
//         in_0: *const DynPixel,
//         end: c_int,
//         strength: c_int,
//     ) -> ();
// }

// **********************
//
// fill
// these also have some dynamic dispatching internally
//
// **********************

// fn avg(
//     dst_ptr: *mut DynPixel,
//     dst_stride: isize,
//     tmp1: &[i16; COMPINTER_LEN],
//     tmp2: &[i16; COMPINTER_LEN],
//     w: i32,
//     h: i32,
//     bitdepth_max: i32,
//     _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
// ) -> ();

// #[bums::check_mem_safe("mc.S", dst_ptr.as_mut_ptr(), dst_ptr.len(), tmp1.as_ptr(), tmp2.as_ptr(), w, h, bitdepth_max)]
// fn w_avg_8bpc_neon(
//     dst_ptr: &mut [u8],
//     // dst_stride: isize, //calculated in macro
//     tmp1: &[i16; 16384],
//     tmp2: &[i16; 16384],
//     w: i32,
//     h: i32,
//     bitdepth_max: i32,
// );

// #[bums::check_mem_safe("mc16.S", dst_ptr.as_mut_ptr(), dst_ptr.len(), tmp1.as_ptr(), tmp2.as_ptr(), w, h, bitdepth_max)]
// fn w_avg_16bpc_neon(
//     dst_ptr: &mut [u8],
//     // dst_stride: isize,//calculated in macro
//     tmp1: &[i16; 16384],
//     tmp2: &[i16; 16384],
//     w: i32,
//     h: i32,
//     bitdepth_max: i32,
// );

// **********************
//
// fill
//
// **********************
// from rav1d:
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

// Note: these do dynamic dispatching based on the width internally (see fill1,fill2, fill3) and would require extending CLAMS

// #[bums_macros::check_mem_safe("ipred.S", dst.as_mut_ptr(), dst.len(), topleft.as_ptr(), width, height, 8, [width >= 4, width <= 64, width % 4 == 0, height >= 4, height <= 64, height % 4 == 0])]
// fn ipred_z1_fill1_8bpc_neon(
//     dst: &mut [usize],
//     // stride: usize,
//     topleft: &[usize],
//     width: usize,
//     height: usize,
//     dxy: usize,
//     max_base_xy: usize,
// ) -> ();

// #[bums_macros::check_mem_safe("ipred16.S", dst.as_mut_ptr(), dst.len(), topleft.as_ptr(), width, height, 8, [width >= 4, width <= 64, width % 4 == 0, height >= 4, height <= 64, height % 4 == 0])]
// fn ipred_z1_fill1_16bpc_neon(
//     dst: &mut [usize],
//     // stride: usize,
//     topleft: &[usize],
//     width: usize,
//     height: usize,
//     dxy: usize,
//     max_base_xy: usize,
// ) -> ();

// #[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), dst.len(), top.as_ptr(), left.as_ptr(), width, height, 8, [width >=4, width <=64, width%4==0, height>=4, height<=64, height%4==0])]
// fn ipred_z2_fill1_8bpc_neon(
//     dst: &mut [usize],
//     // stride: ptrdiff_t,
//     top: &[usize],
//     left: &[usize],
//     width: c_int,
//     height: c_int,
//     dx: c_int,
//     dy: c_int,
// ) -> ();

// #[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), dst.len(), top.as_ptr(), left.as_ptr(), width, height, 8, [width >=4, width <=64, width%4==0, height>=4, height<=64, height%4==0])]
// fn ipred_z2_fill1_16bpc_neon(
//     dst: &mut [usize],
//     // stride: ptrdiff_t,
//     top: &[usize],
//     left: &[usize],
//     width: c_int,
//     height: c_int,
//     dx: c_int,
//     dy: c_int,
// ) -> ();

// **********************
//
// upsample
//
// **********************
//     fn z1_upsample_edge(
//         out: *mut DynPixel,
//         hsz: c_int,
//         in_0: *const DynPixel,
//         end: c_int,
//         _bitdepth_max: c_int,
//     ) -> ();
//
//     fn z2_upsample_edge(
//         out: *mut DynPixel,
//         hsz: c_int,
//         in_0: *const DynPixel,
//         _bitdepth_max: c_int,
//     ) -> ();

#[bums::check_mem_safe("edited-ipred.S", out.as_mut_ptr(), out.len(), in_0.as_ptr(), in_0.len(), 8, [out.len() == in_0.len() * 2 + 1, out.len()>=4, out.len()<=16, out.len()%4==0])]
fn ipred_z1_upsample_edge_8bpc_neon(out: &mut [usize], in_0: &[usize]) -> ();

// Here, sz is 4 or 8, and we produce 2*sz+1 output elements.
#[bums::check_mem_safe("edited-ipred.S", out.as_mut_ptr(), out.len() , in_0.as_ptr(),  in_0.len(), [out.len() == in_0.len() * 2 + 1, out.len()>=4, out.len()<=8, out.len()%4==0])]
fn ipred_z2_upsample_edge_8bpc_neon(out: &mut [usize], in_0: &mut [usize]);

// #[bums::check_mem_safe("ipred.S", ac.as_ptr(), y, w_pad, h_pad, cw, ch)]
// fn ipred_cfl_ac_420_8bpc_neon(ac: &mut [i16; 1024], y: isize, w_pad: i32, h_pad: i32, cw: i32, ch: i32);

// #[bums::check_mem_safe("edited-ipred.S", out.as_mut_ptr(), 4, in_0.as_ptr(), in_0.len(), [ in_0.len() >= 18, in_0.len()%18==0])]
// fn ipred_z1_filter_edge_8bpc_neon(out: &mut [u8], in_0: &mut [u8], strength: i32);

// #[bums::check_mem_safe("edited-ipred.S", dst.as_mut_ptr(), stride, pal.as_ptr(), idx, w, h)]
// fn pal_pred_8bpc_neon(dst: &mut [u8], stride: usize, pal: &[u8; 8], idx: u8, w: u32, h: u32);

// **********************
//
// ipred reverse
//
// **********************
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

#[bums::check_mem_safe("ipred.S", dst.as_mut_ptr(), src.as_ptr_range().end, 1, [src.len() == dst.len(), src.len() >= 32, src.len()%32==0])]
fn ipred_reverse_8bpc_neon(dst: &mut [u8], src: &[u8]);

#[bums::check_mem_safe("ipred16.S", dst.as_mut_ptr(), src.as_ptr_range().end , src.len()/4, [src.len() == dst.len(), src.len() >= 32, src.len()%32==0])]
fn ipred_reverse_16bpc_neon(dst: &mut [u16], src: &[u16]);

#[cfg(test)]
mod tests {
    use super::*;

    extern "C" {
        #[link_name = "rav1d_1_0_0_ipred_reverse_8bpc_neon"]
        fn rav1d_ipred_reverse_8bpc_neon(dest: *mut u8, src: *const u8, num: usize);
    }

    #[allow(unreachable_code)]
    #[test]
    fn test_reverse_asm_impls() {
        todo!("figure out linking issues with rav1d");
        // TODO: figure out why this fails, what the actual length computation is

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
