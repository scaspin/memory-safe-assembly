#![allow(clashing_extern_declarations, improper_ctypes)]

mod cases;
mod harness;
mod wrappers {
    include!(concat!(env!("OUT_DIR"), "/wrappers.rs"));
}

use std::collections::BTreeSet;
use std::io::Write;
use std::time::Duration;

use harness::{Size, measure, prefer_performance_cores, satisfies_preconditions};

fn main() {
    prefer_performance_cores();
    let arguments: Vec<String> = std::env::args().skip(1).collect();
    let output = arguments
        .iter()
        .position(|a| a == "--out")
        .map(|i| arguments[i + 1].clone())
        .unwrap_or_else(|| "results/overhead.tsv".to_string());
    let rounds: usize = arguments
        .iter()
        .position(|a| a == "--rounds")
        .map(|i| arguments[i + 1].parse().unwrap())
        .unwrap_or(61);
    let filter = arguments.iter().position(|a| a == "--filter").map(|i| arguments[i + 1].clone());

    let cases = cases::all();
    let with_cases: BTreeSet<&str> = cases.iter().map(|c| c.function).collect();
    for meta in wrappers::META {
        if !with_cases.contains(meta.function) {
            eprintln!("no inputs for {}", meta.function);
        }
    }

    if let Some(parent) = std::path::Path::new(&output).parent() {
        std::fs::create_dir_all(parent).unwrap();
    }
    let mut out = std::fs::File::create(&output).unwrap();
    writeln!(
        out,
        "suite\tdomain\tfunction\tclauses\tpreconditions\tstructs\tsize\tinput_bytes\traw_ns\tannotated_ns\traw_p25\traw_p75\tannotated_p25\tannotated_p75\tpaired_ratio\titerations"
    )
    .unwrap();

    for case in &cases {
        if filter.as_ref().is_some_and(|f| !case.function.contains(f.as_str())) {
            continue;
        }
        let meta = wrappers::META
            .iter()
            .find(|m| m.function == case.function)
            .unwrap_or_else(|| panic!("{} is not in functions.txt", case.function));
        for size in Size::ALL {
            let mut calls = (case.build)(size);
            if let Err(message) = satisfies_preconditions(&mut calls) {
                eprintln!("{} {}: inputs violate the annotation: {message}", case.function, size.label());
                continue;
            }
            let m = measure(&mut calls, rounds, Duration::from_micros(500));
            eprintln!(
                "{:<44} {:>3} {:>9} B  raw {:>10.1} ns  bums {:>10.1} ns  {:+6.1}%",
                case.function,
                size.label(),
                calls.input_bytes,
                m.raw_ns,
                m.annotated_ns,
                (m.paired_ratio - 1.0) * 100.0
            );
            writeln!(
                out,
                "{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{:.3}\t{:.3}\t{:.3}\t{:.3}\t{:.3}\t{:.3}\t{:.5}\t{}",
                meta.suite,
                meta.domain,
                meta.function,
                meta.clauses,
                meta.preconditions,
                meta.structs,
                size.label(),
                calls.input_bytes,
                m.raw_ns,
                m.annotated_ns,
                m.raw_spread.0,
                m.raw_spread.1,
                m.annotated_spread.0,
                m.annotated_spread.1,
                m.paired_ratio,
                m.iterations
            )
            .unwrap();
        }
    }
    eprintln!("wrote {output}");
}
