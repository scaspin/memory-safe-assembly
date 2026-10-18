use bums::common::*;
use bums::x86::engine::ExecutionEngine;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn source(cve: &str, file: &str) -> Vec<String> {
    let path = format!(
        "{}/../bugs/asm-cves/{cve}/{file}",
        env!("CARGO_MANIFEST_DIR")
    );
    std::fs::read_to_string(&path)
        .unwrap_or_else(|e| panic!("{path}: {e}"))
        .lines()
        .map(String::from)
        .collect()
}

fn at_least(name: &str, n: i64) -> AbstractComparison {
    AbstractComparison::new(">=", abstract_of(name), AbstractExpression::Immediate(n))
}

fn at_most(name: &str, n: i64) -> AbstractComparison {
    AbstractComparison::new("<=", abstract_of(name), AbstractExpression::Immediate(n))
}

fn copy(
    program: Vec<String>,
    entry: &str,
    size: AbstractExpression,
    bounds: &[AbstractComparison],
) -> Result<(), String> {
    init();
    let mut engine = ExecutionEngine::new(program);
    engine.add_abstract_from(0, "dst");
    engine.add_region(RegionType::RW, "dst", abstract_of("n"));
    engine.add_abstract_from(1, "src");
    engine.add_region(RegionType::READ, "src", abstract_of("n"));
    engine.add_abstract_expression_from(2, size);
    for tunable in [
        "x86_shared_non_temporal_threshold",
        "x86_shared_cache_size_half",
    ] {
        engine.add_region(RegionType::READ, tunable, AbstractExpression::Immediate(8));
    }
    for bound in bounds {
        engine.add_invariant(bound.clone());
    }
    engine.start(entry).map_err(|e| e.to_string())
}

fn x32_size() -> AbstractExpression {
    generate_expression(
        "+",
        abstract_of("n"),
        generate_expression(
            "*",
            abstract_of("upper"),
            AbstractExpression::Immediate(1 << 32),
        ),
    )
}

fn x32_bounds() -> Vec<AbstractComparison> {
    vec![
        at_least("n", 0),
        at_most("n", u32::MAX as i64),
        at_least("upper", 0),
        at_most("upper", u32::MAX as i64),
    ]
}

#[test]
fn cve_2019_6488_lp64_memmove_is_safe() {
    let program = source(
        "cve-2019-6488",
        "memmove-avx-unaligned-erms.lp64.vulnerable.S",
    );
    assert_eq!(
        copy(
            program,
            "__memmove_avx_unaligned_erms",
            abstract_of("n"),
            &[at_least("n", 0)]
        ),
        Ok(())
    );
}

#[test]
fn cve_2019_6488_x32_memmove_reads_past_its_buffers() {
    let program = source(
        "cve-2019-6488",
        "memmove-avx-unaligned-erms.x32.vulnerable.S",
    );
    let err = copy(
        program,
        "__memmove_avx_unaligned_erms",
        x32_size(),
        &x32_bounds(),
    )
    .expect_err("the upper half of rdx is garbage on x32");
    assert!(err.contains("not provably within region"), "{err}");
}

#[test]
fn cve_2019_6488_x32_memmove_with_the_fix_is_safe() {
    let program = source("cve-2019-6488", "memmove-avx-unaligned-erms.x32.fixed.S");
    assert_eq!(
        copy(
            program,
            "__memmove_avx_unaligned_erms",
            x32_size(),
            &x32_bounds()
        ),
        Ok(())
    );
}

fn fill(file: &str, size: AbstractExpression, bounds: &[AbstractComparison]) -> Result<(), String> {
    init();
    let mut engine = ExecutionEngine::new(source("cve-2019-6488", file));
    engine.add_abstract_from(0, "dst");
    engine.add_region(RegionType::WRITE, "dst", abstract_of("n"));
    engine.add_abstract_from(1, "byte");
    engine.add_abstract_expression_from(2, size);
    engine.add_region(
        RegionType::READ,
        "x86_shared_non_temporal_threshold",
        AbstractExpression::Immediate(8),
    );
    for bound in bounds {
        engine.add_invariant(bound.clone());
    }
    engine
        .start("__memset_avx2_unaligned_erms")
        .map_err(|e| e.to_string())
}

#[test]
fn cve_2019_6488_lp64_memset_is_safe() {
    assert_eq!(
        fill(
            "memset-avx2-unaligned-erms.lp64.vulnerable.S",
            abstract_of("n"),
            &[at_least("n", 0)]
        ),
        Ok(())
    );
}

#[test]
fn cve_2019_6488_x32_memset_writes_past_its_buffer() {
    let err = fill(
        "memset-avx2-unaligned-erms.x32.vulnerable.S",
        x32_size(),
        &x32_bounds(),
    )
    .expect_err("the upper half of rdx is garbage on x32");
    assert!(err.contains("write of"), "{err}");
    assert!(err.contains("not provably within region"), "{err}");
}

#[test]
fn cve_2019_6488_x32_memset_with_the_fix_is_safe() {
    assert_eq!(
        fill(
            "memset-avx2-unaligned-erms.x32.fixed.S",
            x32_size(),
            &x32_bounds()
        ),
        Ok(())
    );
}

#[test]
fn cve_2018_11237_avx512_mempcpy_writes_past_its_destination() {
    let program = source(
        "cve-2018-11237",
        "memmove-avx512-no-vzeroupper.vulnerable.S",
    );
    let err = copy(
        program,
        "__mempcpy_avx512_no_vzeroupper",
        abstract_of("n"),
        &[at_least("n", 0)],
    )
    .expect_err("the large-copy path stores its first 128 bytes at dst + n");
    assert!(err.contains("write of 64 bytes at dst + n"), "{err}");
}

#[test]
fn cve_2018_11237_avx512_mempcpy_with_the_fix_is_safe() {
    let program = source("cve-2018-11237", "memmove-avx512-no-vzeroupper.fixed.S");
    assert_eq!(
        copy(
            program,
            "__mempcpy_avx512_no_vzeroupper",
            abstract_of("n"),
            &[at_least("n", 0)]
        ),
        Ok(())
    );
}

#[test]
fn cve_2018_11237_avx512_memmove_was_never_affected() {
    let program = source(
        "cve-2018-11237",
        "memmove-avx512-no-vzeroupper.vulnerable.S",
    );
    assert_eq!(
        copy(
            program,
            "__memmove_avx512_no_vzeroupper",
            abstract_of("n"),
            &[at_least("n", 0)]
        ),
        Ok(())
    );
}

fn cfb128(file: &str, entry: &str, ivec_bytes: i64, rounds: i64) -> Result<(), String> {
    init();
    let mut engine = ExecutionEngine::new(source("cve-2026-28386", file));
    engine.add_abstract_from(0, "in");
    engine.add_region(RegionType::READ, "in", abstract_of("len"));
    engine.add_abstract_from(1, "out");
    engine.add_region(RegionType::WRITE, "out", abstract_of("len"));
    engine.add_abstract_from(2, "len");
    engine.add_abstract_from(3, "ks");
    engine.add_region(RegionType::READ, "ks", AbstractExpression::Immediate(244));
    engine.add_abstract_to_memory("ks", 240, AbstractExpression::Immediate(rounds));
    engine.add_abstract_from(4, "ivec");
    engine.add_region(
        RegionType::RW,
        "ivec",
        AbstractExpression::Immediate(ivec_bytes),
    );
    engine.add_abstract_from(5, "num");
    engine.add_region(RegionType::RW, "num", AbstractExpression::Immediate(8));
    engine.add_abstract_to_memory("num", 0, abstract_of("position"));
    for bound in [
        at_least("len", 0),
        at_least("position", 0),
        at_most("position", 15),
    ] {
        engine.add_invariant(bound);
    }
    engine.start(entry).map_err(|e| e.to_string())
}

const ENTRIES: [&str; 2] = ["ossl_aes_cfb128_vaes_enc", "ossl_aes_cfb128_vaes_dec"];
const ROUNDS: [i64; 3] = [10, 12, 14];

#[test]
fn cve_2026_28386_cfb128_reads_past_the_iv_mid_block() {
    for entry in ENTRIES {
        let err = cfb128("aes-cfb-avx512.vulnerable.s", entry, 16, 10)
            .expect_err("a partial block loads 16 bytes of the iv from its middle");
        assert!(
            err.contains("read of 16 bytes at position + ivec"),
            "{entry}: {err}"
        );
    }
}

#[test]
fn cve_2026_28386_cfb128_reads_past_a_short_input() {
    for entry in ENTRIES {
        let err = cfb128("aes-cfb-avx512.vulnerable.s", entry, 32, 10)
            .expect_err("a partial block loads 16 bytes of input");
        assert!(err.contains("read of 16 bytes at in + 0"), "{entry}: {err}");
    }
}

#[test]
fn cve_2026_28386_cfb128_with_the_fix_is_safe() {
    for entry in ENTRIES {
        for rounds in ROUNDS {
            assert_eq!(
                cfb128("aes-cfb-avx512.fixed.s", entry, 16, rounds),
                Ok(()),
                "{entry} with {rounds} rounds"
            );
        }
    }
}
