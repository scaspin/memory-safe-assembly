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
    for store in ["str z1, [x2]", "st1w { z1.s }, p0, [x2, #1, mul vl]"] {
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

fn guarded_by_vector_lengths(guard: &str, access: &str) -> Result<(), String> {
    copy_between_buffers(&format!(
        "start:
        {guard}
        cmp x0, x6
        b.lo done
        {access}
        done:
        ret"
    ))
}

#[test]
fn an_all_true_load_a_whole_vector_in_stays_inside_two_vectors() {
    let access = "ptrue p0.b\nld1b { z1.b }, p0/z, [x1, #1, mul vl]";
    assert_eq!(guarded_by_vector_lengths("rdvl x6, #2", access), Ok(()));
    assert!(guarded_by_vector_lengths("rdvl x6, #1", access).is_err());
}

#[test]
fn an_all_true_store_two_vectors_in_is_caught() {
    let access = "ptrue p0.s\nst1w { z1.s }, p0, [x2, #2, mul vl]";
    assert!(guarded_by_vector_lengths("rdvl x6, #2", access).is_err());
    assert_eq!(guarded_by_vector_lengths("rdvl x6, #3", access), Ok(()));
}

#[test]
fn a_four_register_structure_load_spans_four_vectors() {
    let access = "ptrue p0.s\nld4w { z1.s - z4.s }, p0/z, [x1]";
    assert_eq!(guarded_by_vector_lengths("rdvl x6, #4", access), Ok(()));
    assert!(guarded_by_vector_lengths("rdvl x6, #3", access).is_err());
}

#[test]
fn element_counts_scale_to_bytes() {
    let access = "ptrue p0.s\nld1w { z1.s }, p0/z, [x1]";
    assert_eq!(
        guarded_by_vector_lengths("cntw x6\nlsl x6, x6, #2", access),
        Ok(())
    );
    assert!(guarded_by_vector_lengths("cntw x6\nlsl x6, x6, #1", access).is_err());
    assert_eq!(
        guarded_by_vector_lengths("mov x6, #0\nincd x6\nlsl x6, x6, #3", access),
        Ok(())
    );
}

#[test]
fn addvl_advances_the_pointer_by_whole_vectors() {
    let access = "ptrue p0.b\naddvl x1, x1, #1\nld1b { z1.b }, p0/z, [x1]";
    assert_eq!(guarded_by_vector_lengths("rdvl x6, #2", access), Ok(()));
    assert!(guarded_by_vector_lengths("rdvl x6, #1", access).is_err());
}

#[test]
fn a_whilelo_from_zero_covers_at_most_one_vector() {
    let access = "cbz x6, done\nwhilelo p0.s, xzr, x6\nld1w { z1.s }, p0/z, [x1]";
    assert_eq!(
        guarded_by_vector_lengths("mov x6, #0\nlsr x6, x0, #2", access),
        Ok(())
    );
    assert!(guarded_by_vector_lengths("mov x6, #0\nlsr x6, x0, #1", access).is_err());
}

#[test]
fn a_predicate_rewritten_with_a_pattern_is_forgotten() {
    let access = "ptrue p0.b, vl16\nld1b { z1.b }, p0/z, [x1]";
    assert!(guarded_by_vector_lengths("rdvl x6, #1", access).is_err());
}
