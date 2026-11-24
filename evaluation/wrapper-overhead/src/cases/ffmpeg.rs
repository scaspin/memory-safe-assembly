#![allow(unused_unsafe)]

use std::hint::black_box;

use crate::harness::{Calls, Case};
use crate::wrappers::*;

macro_rules! calls {
    ($module:ident, $state:expr, $bytes:expr, |$s:ident| ($($arg:expr),* $(,)?)) => {
        Calls::new(
            $state,
            $bytes,
            |$s| {
                black_box(unsafe { $module::annotated($(black_box($arg)),*) });
            },
            |$s| {
                black_box(unsafe { $module::raw($(black_box($arg)),*) });
            },
        )
    };
}

fn bytes(n: usize, seed: u8) -> Vec<u8> {
    (0..n).map(|i| (i as u8).wrapping_mul(31).wrapping_add(seed)).collect()
}

fn shorts(n: usize, seed: i16, modulus: i16) -> Vec<i16> {
    (0..n).map(|i| ((i as i16).wrapping_mul(37).wrapping_add(seed)).rem_euclid(modulus)).collect()
}

pub fn cases() -> Vec<Case> {
    vec![
        Case {
            function: "ff_ps_stereo_interpolate_neon",
            build: |size| {
                #[derive(Clone)]
                struct State {
                    l: Vec<f32>,
                    r: Vec<f32>,
                    h: Vec<f32>,
                    h_step: Vec<f32>,
                    len: usize,
                }
                let len = size.pick(1, 64, 4096);
                let samples = |seed: f32| (0..2 * len).map(|i| seed + (i % 13) as f32 * 0.25).collect::<Vec<f32>>();
                let state = State { l: samples(1.0), r: samples(2.0), h: vec![0.5; 8], h_step: vec![0.0; 8], len };
                calls!(ff_ps_stereo_interpolate_neon, state, 4 * (4 * len + 16), |s| (&mut s.l, &mut s.r, &s.h, &s.h_step, s.len))
            },
        },
        Case {
            function: "ff_put_h264_chroma_mc8_neon",
            build: |size| {
                #[derive(Clone)]
                struct State {
                    dst: Vec<u8>,
                    src: Vec<u8>,
                    stride: usize,
                    h: usize,
                }
                let h = size.pick(4, 8, 16);
                let stride = 16;
                let state = State { dst: vec![0; (h - 1) * stride + 8], src: bytes((h + 2) * stride + 16, 3), stride, h };
                let total = state.dst.len() + state.src.len();
                calls!(ff_put_h264_chroma_mc8_neon, state, total, |s| (&mut s.dst, &s.src, s.stride, s.h, 3, 5))
            },
        },
        Case {
            function: "ff_hevc_sao_edge_filter_8x8_8_neon",
            build: |size| {
                #[derive(Clone)]
                struct State {
                    dst: Vec<u8>,
                    src: Vec<u8>,
                    offset_val: Vec<i16>,
                    width: usize,
                    height: usize,
                }
                let (width, height) = size.pick((4, 4), (8, 8), (8, 64));
                let stride_dst = 8;
                let state = State {
                    dst: vec![0; height * stride_dst],
                    src: bytes((height + 2) * 192 + 16, 5),
                    offset_val: vec![0, 3, 1, -1, -3, 0, 0, 0],
                    width,
                    height,
                };
                let total = state.dst.len() + state.src.len() + 16;
                calls!(ff_hevc_sao_edge_filter_8x8_8_neon, state, total, |s| (&mut s.dst, &s.src, 8, &s.offset_val, 1, s.width, s.height))
            },
        },
        Case {
            function: "ff_hevc_put_hevc_epel_uni_v4_8_neon",
            build: |size| {
                #[derive(Clone)]
                struct State {
                    dst: Vec<u8>,
                    src: Vec<u8>,
                    height: usize,
                }
                let height = size.pick(2, 16, 64);
                let stride = 64;
                let state = State { dst: vec![0; (height - 1) * stride + 4], src: bytes((height + 4) * stride + 16, 7), height };
                let total = state.dst.len() + state.src.len();
                calls!(ff_hevc_put_hevc_epel_uni_v4_8_neon, state, total, |s| (&mut s.dst, 64, &s.src, 64, s.height, 0, 3, 4))
            },
        },
        Case {
            function: "ff_hevc_put_hevc_pel_bi_w_pixels4_8_neon",
            build: |size| {
                #[derive(Clone)]
                struct State {
                    dst: Vec<u8>,
                    src: Vec<u8>,
                    src2: Vec<i16>,
                    height: usize,
                }
                let height = size.pick(2, 16, 64);
                let stride = 64;
                let state = State {
                    dst: vec![0; (height - 1) * stride + 4],
                    src: bytes((height + 1) * stride + 16, 9),
                    src2: shorts(4096, 11, 4096),
                    height,
                };
                let total = state.dst.len() + state.src.len() + 2 * 4 * height;
                calls!(ff_hevc_put_hevc_pel_bi_w_pixels4_8_neon, state, total, |s| (&mut s.dst, 64, &s.src, 64, &s.src2, s.height, 6, 1, 1, 0, 0, 0, 4))
            },
        },
        Case {
            function: "ff_bwdif_filter_line_neon",
            build: |size| {
                #[derive(Clone)]
                struct State {
                    dst: Vec<u8>,
                    prev: Vec<u8>,
                    cur: Vec<u8>,
                    next: Vec<u8>,
                    w: usize,
                }
                let w = size.pick(16, 256, 2048);
                let stride = w;
                let state = State {
                    dst: vec![0; w],
                    prev: bytes(8 * stride + w, 13),
                    cur: bytes(8 * stride + w, 17),
                    next: bytes(8 * stride + w, 19),
                    w,
                };
                let total = w + 3 * 9 * w;
                calls!(ff_bwdif_filter_line_neon, state, total, |s| (
                    &mut s.dst,
                    &s.prev,
                    &s.cur,
                    &s.next,
                    s.w,
                    s.w as i64,
                    -(s.w as i64),
                    2 * s.w as i64,
                    -(2 * s.w as i64),
                    3 * s.w as i64,
                    -(3 * s.w as i64),
                    4 * s.w as i64,
                    -(4 * s.w as i64),
                    0,
                    255,
                    s.w
                ))
            },
        },
    ]
}
