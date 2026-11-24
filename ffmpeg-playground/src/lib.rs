#![allow(dead_code, non_snake_case, clippy::all)]

#[cfg(feature = "audio")]
mod audio;
#[cfg(feature = "float_dsp")]
mod float_dsp;
#[cfg(feature = "h264")]
mod h264;
#[cfg(feature = "h264dsp")]
mod h264dsp;
#[cfg(feature = "hevc")]
mod hevc;
#[cfg(feature = "hevc_mc")]
mod hevc_mc;
#[cfg(feature = "libavutil")]
mod libavutil;
#[cfg(feature = "misc")]
mod misc;
#[cfg(feature = "misc_video")]
mod misc_video;
#[cfg(feature = "pixel")]
mod pixel;
#[cfg(feature = "swscale")]
mod swscale;
#[cfg(feature = "tx_float")]
mod tx_float;
#[cfg(feature = "vp8")]
mod vp8;
#[cfg(feature = "vp9")]
mod vp9;
#[cfg(feature = "vvc")]
mod vvc;
#[cfg(feature = "vvc_alf")]
mod vvc_alf;
#[cfg(feature = "yuv2rgb")]
mod yuv2rgb;
#[cfg(feature = "probe")]
mod probe;
