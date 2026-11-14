#![allow(unused_unsafe)]

use std::hint::black_box;

use crate::harness::{Calls, Case};
use crate::wrappers::*;

macro_rules! calls {
    ($module:ident, $state:expr, $bytes:expr, |$s:ident| ($($arg:expr),* $(,)?)) => {
        Calls::new(
            $state,
            $bytes,
            move |$s| {
                black_box(unsafe { $module::annotated($(black_box($arg)),*) });
            },
            move |$s| {
                black_box(unsafe { $module::raw($(black_box($arg)),*) });
            },
        )
    };
}

fn bytes(n: usize, seed: u8) -> Vec<u8> {
    (0..n).map(|i| (i as u8).wrapping_mul(31).wrapping_add(seed)).collect()
}

fn grain(n: usize) -> Vec<i8> {
    (0..n).map(|i| ((i * 7) % 31) as i8 - 15).collect()
}

pub fn cases() -> Vec<Case> {
    vec![
        Case {
            function: "blend_v_8bpc_neon",
            build: |size| {
                #[derive(Clone)]
                struct State {
                    dst: Vec<u8>,
                    tmp: Vec<u8>,
                    w: usize,
                    h: usize,
                }
                let (w, h) = size.pick((2, 4), (16, 16), (32, 32));
                let state = State { dst: bytes(w * h, 1), tmp: bytes(w * h, 2), w, h };
                calls!(blend_v_8bpc_neon, state, 2 * w * h, |s| (&mut s.dst, s.w, &s.tmp, s.w, s.h))
            },
        },
        Case {
            function: "cdef_filter8_8bpc_neon",
            build: |size| {
                #[derive(Clone)]
                struct State {
                    dst: Vec<u8>,
                    tmp: Vec<u16>,
                    h: usize,
                }
                let h = size.pick(4, 8, 8);
                let tmp = (0..200).map(|i| ((i * 37) % 256) as u16).collect();
                let state = State { dst: bytes(8 * h, 3), tmp, h };
                calls!(cdef_filter8_8bpc_neon, state, 8 * h + 400, |s| (&mut s.dst, 8, &s.tmp, 4, 2, 3, 5, s.h, 15, 255))
            },
        },
        Case {
            function: "put_8tap_regular_8bpc_neon_dotprod",
            build: |size| {
                #[derive(Clone)]
                struct State {
                    dst: Vec<u8>,
                    src: Vec<u8>,
                    w: usize,
                    h: usize,
                }
                let (w, h) = size.pick((2, 2), (16, 16), (128, 128));
                let state = State { dst: vec![0; w * h], src: bytes(w * (h + 6) + w + 7, 5), w, h };
                let total = state.dst.len() + state.src.len();
                calls!(put_8tap_regular_8bpc_neon_dotprod, state, total, |s| (&mut s.dst, s.w, &s.src, s.w, s.w, s.h, 5, 7, 255))
            },
        },
        Case {
            function: "warp_affine_8x8_8bpc_neon",
            build: |_| {
                #[derive(Clone)]
                struct State {
                    dst: Vec<u8>,
                    src: Vec<u8>,
                    abcd: Vec<i16>,
                }
                let (alpha, beta, gamma, delta) = (100i32, -50i32, 30i32, 20i32);
                let state = State {
                    dst: vec![0; 8 * 8],
                    src: bytes(32 * 15, 7),
                    abcd: vec![alpha as i16, beta as i16, gamma as i16, delta as i16],
                };
                calls!(warp_affine_8x8_8bpc_neon, state, 64 + 32 * 15 + 8, |s| (&mut s.dst, 8, &s.src, 32, &s.abcd, 512, 512, 255, alpha, beta, gamma, delta))
            },
        },
        Case {
            function: "fgy_32x32_8bpc_neon",
            build: |size| {
                #[derive(Clone)]
                struct State {
                    dst: Vec<u8>,
                    src: Vec<u8>,
                    scaling: Vec<u8>,
                    grain_lut: Vec<i8>,
                    offsets: Vec<i32>,
                    h: usize,
                }
                let h = size.pick(1, 16, 32);
                let stride = 32;
                let state = State {
                    dst: vec![0; stride * h],
                    src: bytes(stride * h, 9),
                    scaling: bytes(256, 11),
                    grain_lut: grain(82 * 74),
                    offsets: vec![10, 20, 30, 40],
                    h,
                };
                let total = 2 * stride * h + 256 + 82 * 74 + 16;
                calls!(fgy_32x32_8bpc_neon, state, total, |s| (&mut s.dst, &s.src, 32, &s.scaling, 8, &s.grain_lut, &s.offsets, s.h, 0, 0, 255))
            },
        },
        Case {
            function: "fguv_32x32_422_8bpc_neon",
            build: |size| {
                #[derive(Clone)]
                struct State {
                    dst: Vec<u8>,
                    src: Vec<u8>,
                    scaling: Vec<u8>,
                    data: Vec<u8>,
                    grain_lut: Vec<i8>,
                    luma_row: Vec<u8>,
                    offsets: Vec<i32>,
                    h: usize,
                }
                let h = size.pick(1, 16, 32);
                let (stride, luma_stride) = (16, 32);
                let state = State {
                    dst: vec![0; stride * h],
                    src: bytes(stride * h, 13),
                    scaling: bytes(256, 15),
                    data: bytes(224, 17),
                    grain_lut: grain(82 * 74),
                    luma_row: bytes(luma_stride * h, 19),
                    offsets: vec![10, 20, 30, 40],
                    h,
                };
                let total = 2 * stride * h + luma_stride * h + 256 + 224 + 82 * 74 + 16;
                calls!(fguv_32x32_422_8bpc_neon, state, total, |s| (
                    &mut s.dst,
                    &s.src,
                    16,
                    &s.scaling,
                    &s.data,
                    &s.grain_lut,
                    &s.luma_row,
                    32,
                    &s.offsets,
                    s.h,
                    0,
                    0,
                    0,
                    255
                ))
            },
        },
    ]
}
