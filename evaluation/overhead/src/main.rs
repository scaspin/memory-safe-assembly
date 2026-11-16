#![allow(clashing_extern_declarations, improper_ctypes)]

mod inputs;
mod harness;
mod wrappers {
    include!(concat!(env!("OUT_DIR"), "/wrappers.rs"));
}

use std::io::Write;
use std::time::Duration;

use harness::{measure, prefer_performance_cores, satisfies_preconditions};

pub struct Sample {
    pub calls: harness::Calls,
    pub description: String,
}

fn option(arguments: &[String], name: &str) -> Option<String> {
    arguments.iter().position(|a| a == name).map(|i| arguments[i + 1].clone())
}

fn number<T: std::str::FromStr>(arguments: &[String], name: &str, default: T) -> T {
    option(arguments, name).map_or(default, |v| v.parse().ok().expect(name))
}

fn spread(mut accepted: Vec<Sample>, keep: usize) -> Vec<Sample> {
    accepted.sort_by_key(|s| s.calls.input_bytes);
    let sizes = accepted.windows(2).filter(|w| w[0].calls.input_bytes != w[1].calls.input_bytes).count() + 1;
    if sizes == 1 {
        accepted.truncate(keep.min(3));
        return accepted;
    }
    accepted.dedup_by_key(|s| s.calls.input_bytes);
    if accepted.len() <= keep {
        return accepted;
    }
    let last = accepted.len() - 1;
    let picks: Vec<usize> = (0..keep).map(|k| k * last / (keep - 1).max(1)).collect();
    accepted
        .into_iter()
        .enumerate()
        .filter(|(i, _)| picks.contains(i))
        .map(|(_, s)| s)
        .collect()
}

fn main() {
    prefer_performance_cores();
    let arguments: Vec<String> = std::env::args().skip(1).collect();
    if arguments.iter().any(|a| a == "--list") {
        for (index, meta) in wrappers::META.iter().enumerate() {
            let status = if meta.sample.is_some() { "ready" } else { "skipped" };
            println!("{index}\t{}\t{}\t{status}\t{}", meta.function, meta.file, meta.skipped);
        }
        return;
    }
    let index: usize = number(&arguments, "--run", usize::MAX);
    let meta = &wrappers::META[index];
    let sample = meta.sample.expect("this function has no input generator");
    let output = option(&arguments, "--out").expect("--out FILE");
    let seed: u64 = number(&arguments, "--seed", 1);
    let tries: usize = number(&arguments, "--tries", 3000);
    let keep: usize = number(&arguments, "--samples", 8);
    let rounds: usize = number(&arguments, "--rounds", 21);
    let batch_us: u64 = number(&arguments, "--batch-us", 200);

    let mut rng = inputs::Rng::new(seed ^ (index as u64).wrapping_mul(0x2545_f491_4f6c_dd1d));
    let mut accepted = Vec::new();
    let mut attempts = 0;
    let mut generated = 0;
    while attempts < tries && accepted.len() < 4 * keep {
        attempts += 1;
        let Some(mut candidate) = sample(&mut rng) else { continue };
        generated += 1;
        if satisfies_preconditions(&mut candidate.calls).is_ok() {
            accepted.push(candidate);
        }
    }
    let chosen = spread(accepted, keep);
    eprintln!(
        "{} {}: {attempts} attempts, {generated} candidates built, {} distinct inputs measured",
        meta.function,
        meta.file,
        chosen.len()
    );
    let mut out = std::fs::OpenOptions::new().create(true).append(true).open(&output).unwrap();
    if chosen.is_empty() {
        writeln!(
            out,
            "{}\t{}\t{}\t{}\t{}\t{}\t-1\t0\t\tno input satisfied the preconditions ({attempts} attempts, {generated} built)\t\t\t\t\t\t\t\t0\t0",
            meta.suite, meta.domain, meta.function, meta.file, meta.clauses, meta.preconditions
        )
        .unwrap();
        return;
    }
    for (number, mut chosen) in chosen.into_iter().enumerate() {
        let m = measure(&mut chosen.calls, rounds, Duration::from_micros(batch_us));
        let drifted = satisfies_preconditions(&mut chosen.calls).is_err();
        writeln!(
            out,
            "{}\t{}\t{}\t{}\t{}\t{}\t{number}\t{}\t{}\tok\t{:.3}\t{:.3}\t{:.3}\t{:.3}\t{:.3}\t{:.3}\t{:.5}\t{}\t{}",
            meta.suite,
            meta.domain,
            meta.function,
            meta.file,
            meta.clauses,
            meta.preconditions,
            chosen.calls.input_bytes,
            chosen.description,
            m.raw_ns,
            m.annotated_ns,
            m.raw_spread.0,
            m.raw_spread.1,
            m.annotated_spread.0,
            m.annotated_spread.1,
            m.paired_ratio,
            m.iterations,
            drifted as u8,
        )
        .unwrap();
    }
}
