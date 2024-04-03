use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};

use bums;
use z3::*;

fn simple_branch(bench: &mut Criterion) {
    bench.bench_function("simple branch", |b| {
        b.iter(|| {
            let mut program = Vec::new();
            program.push("start:".to_string());
            program.push("cmp x1,x2".to_string());
            program.push("b.ne branch".to_string());
            program.push("add x0,x0,#4".to_string());
            program.push("b end".to_string());
            program.push("branch:".to_string());
            program.push("add x0,x0,#2".to_string());
            program.push("end:".to_string());
            program.push("ret".to_string());

            let cfg = Config::new();
            let ctx = Context::new(&cfg);
            let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

            engine.add_abstract_from(0, "left".to_string());
            engine.add_abstract_from(1, "right".to_string());

            let _ = engine.start("start".to_string());
        })
    });
}

fn simple_loop_with_no_mem_access(num_loops: usize) {
    let mut program = Vec::new();
    program.push("start:".to_string());
    program.push("add x1,#0,#0".to_string());
    program.push(("add x2,#0,#".to_owned() + &num_loops.to_string()).to_string());
    program.push("loop:".to_string());
    program.push("add x1,x1,#1".to_string());
    program.push("cmp x1,x2".to_string());
    program.push("b.ne loop".to_string());
    program.push("ret".to_string());

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    let _ = engine.start("start".to_string());
}

fn simple_loop_no_mem_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("simple loops with no memory access");
    for loops in [1, 10, 100, 1000, 10000].iter() {
        group.bench_with_input(BenchmarkId::new("num_loops", loops), &loops, |b, &loops| {
            b.iter(|| simple_loop_with_no_mem_access(black_box(*loops)))
        });
    }
}

criterion_group!(benches, simple_branch, simple_loop_no_mem_benchmark);
criterion_main!(benches);
