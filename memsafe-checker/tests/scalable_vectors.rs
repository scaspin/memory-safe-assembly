use bums::common::*;

fn copy_between_buffers(program: &str) -> Result<(), String> {
    let _ = env_logger::builder().is_test(true).try_init();
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "len");
    engine.add_abstract_from(1, "src");
    engine.add_region(RegionType::READ, "src", abstract_of("len"));
    engine.add_abstract_from(2, "dst");
    engine.add_region(RegionType::RW, "dst", abstract_of("len"));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        abstract_of("len"),
        AbstractExpression::Immediate(1 << 31),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_whilelo_loop_stays_inside_both_buffers() {
    let program = "start:
        mov x5, #0
        loop:
        whilelo p0.b, x5, x0
        b.eq done
        ld1b { z1.b }, p0/z, [x1, x5]
        eor z1.d, z1.d, z1.d
        st1b { z1.b }, p0, [x2, x5]
        incb x5
        b loop
        done:
        ret";
    assert_eq!(copy_between_buffers(program), Ok(()));
}

#[test]
fn a_predicate_bounded_past_the_buffer_is_caught() {
    let program = "start:
        mov x5, #0
        add x6, x0, #16
        loop:
        whilelo p0.b, x5, x6
        b.eq done
        ld1b { z1.b }, p0/z, [x1, x5]
        incb x5
        b loop
        done:
        ret";
    assert!(copy_between_buffers(program).is_err());
}

#[test]
fn an_access_away_from_the_predicate_start_is_caught() {
    let program = "start:
        mov x5, #0
        loop:
        whilelo p0.b, x5, x0
        b.eq done
        add x7, x5, #1
        ld1b { z1.b }, p0/z, [x1, x7]
        incb x5
        b loop
        done:
        ret";
    assert!(copy_between_buffers(program).is_err());
}

#[test]
fn an_unmodelled_scalable_store_is_an_error() {
    for store in ["st1w { z1.s }, p0, [x2]", "str z1, [x2]"] {
        let program = format!(
            "start:
            mov x5, #0
            whilelo p0.s, x5, x0
            {store}
            ret"
        );
        assert!(copy_between_buffers(&program).is_err(), "{store}");
    }
}

#[test]
fn a_predicate_the_loop_never_recomputes_is_caught() {
    let program = "start:
        mov x5, #0
        whilelo p0.b, x5, x0
        b.eq done
        loop:
        ld1b { z1.b }, p0/z, [x1, x5]
        incb x5
        cmp x5, x0
        b.lo loop
        done:
        ret";
    assert!(copy_between_buffers(program).is_err());
}
