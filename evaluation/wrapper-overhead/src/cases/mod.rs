pub mod bignum;
pub mod candle;
pub mod compression;
pub mod corecrypto;
pub mod crypto;
pub mod ffmpeg;
pub mod graviola;
pub mod openblas;
pub mod rav1d;

use crate::harness::Case;

pub fn all() -> Vec<Case> {
    [
        crypto::cases(),
        bignum::cases(),
        graviola::cases(),
        corecrypto::cases(),
        compression::cases(),
        openblas::cases(),
        candle::cases(),
        ffmpeg::cases(),
        rav1d::cases(),
    ]
    .into_iter()
    .flatten()
    .collect()
}
