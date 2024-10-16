use aws_lc_rs::digest::{digest, SHA256};
use criterion::{criterion_group, criterion_main, BenchmarkId, Criterion};
use crypto_playground::sha256::{sha256_assembly, sha256_digest};
use rand::Rng;

fn bums_assembly(message: &[u8]) -> [u32; 8] {
    let mut context = [
        0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
        0x5be0cd19,
    ];
    sha256_assembly(&mut context, &message);
    return context;
}

#[inline]
fn aws_assembly(message: &[u8]) -> [u32; 8] {
    let mut context = [
        0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
        0x5be0cd19,
    ];

    //sha256_aws_assembly(context.as_mut_ptr(), message.as_ptr(), message.len() / 64);
    unsafe {
        aws_lc_sys::SHA256_TransformBlocks(
            context.as_mut_ptr(),
            message.as_ptr(),
            message.len() / 64,
        );
    }

    return context;
}

fn rust_version(message: &[u8]) {
    let mut v = vec![0; 32];
    let mut output: &mut [u8] = v.as_mut_slice();
    sha256_digest(&message, &mut output);
}

fn aws_lc_version(message: &[u8]) {
    let mut v = vec![0; 32];
    let mut output: &mut [u8] = v.as_mut_slice();
    let output = digest(&SHA256, message);
}

fn assembly_sha256(bench: &mut Criterion) {
    let mut group = bench.benchmark_group("sha256-assembly");
    let mut rng = rand::thread_rng();

    for i in [64, 128, 256, 512, 1024] {
        let message = vec![rng.gen::<u8>(); i];
        group.bench_with_input(
            BenchmarkId::new("aws--assembly", i),
            &message,
            |b, message| b.iter(|| aws_assembly(message)),
        );
        group.bench_with_input(
            BenchmarkId::new("clams--assembly", i),
            &message,
            |b, message| b.iter(|| bums_assembly(message)),
        );
    }
    group.finish();
}
fn public_sha256(bench: &mut Criterion) {
    let mut group = bench.benchmark_group("public-sha256");
    let mut rng = rand::thread_rng();

    for i in [64, 128, 256, 512, 1024] {
        let message = vec![rng.gen::<u8>(); i];
        group.bench_with_input(
            BenchmarkId::new("rust--rewritten", i),
            &message,
            |b, message| b.iter(|| rust_version(message)),
        );
        group.bench_with_input(BenchmarkId::new("C--aws", i), &message, |b, message| {
            b.iter(|| aws_lc_version(message))
        });
    }
    group.finish();
}

criterion_group!(benches, public_sha256, assembly_sha256);
criterion_main!(benches);
