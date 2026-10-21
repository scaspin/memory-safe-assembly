use bums::common::*;

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn imm(v: i64) -> AbstractExpression {
    AbstractExpression::Immediate(v)
}

fn fact(op: &str, l: AbstractExpression, r: AbstractExpression) -> AbstractComparison {
    AbstractComparison::new(op, l, r)
}

fn two_vectors(program: &str, multiple: i64) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    let bytes = generate_expression("*", abstract_of("len"), imm(4));
    engine.add_abstract_from(0, "v1");
    engine.add_region(RegionType::RW, "v1", bytes.clone());
    engine.add_abstract_from(1, "v2");
    engine.add_region(RegionType::RW, "v2", bytes);
    engine.add_abstract_from(2, "len");
    engine.add_invariant(fact(">=", abstract_of("len"), imm(multiple)));
    engine.add_invariant(fact("<=", abstract_of("len"), imm(1 << 20)));
    engine.add_invariant(fact(
        "==",
        generate_expression("%", abstract_of("len"), imm(multiple)),
        imm(0),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

const BUTTERFLIES: &str = "start:
    subs w2, w2, #8
    b.lt tail
    loop:
    ldp q0, q1, [x0]
    ldp q2, q3, [x1]
    subs w2, w2, #8
    st1 { v0.4s, v1.4s }, [x0], #32
    st1 { v2.4s, v3.4s }, [x1], #32
    b.ge loop
    tail:
    tbz w2, #2, done
    ld1 { v0.4s }, [x0]
    ld1 { v1.4s }, [x1]
    st1 { v0.4s }, [x1]
    st1 { v1.4s }, [x0]
    done:
    ret";

#[test]
fn a_tail_chosen_by_a_bit_of_the_negative_remainder_is_in_bounds() {
    two_vectors(BUTTERFLIES, 4).expect("verifies");
}

#[test]
fn a_tail_chosen_by_a_bit_of_the_negative_remainder_still_catches_overreads() {
    let res = two_vectors(
        &BUTTERFLIES.replace("ld1 { v1.4s }, [x1]", "ldr q1, [x1, #16]"),
        4,
    );
    assert!(res.is_err(), "{res:?}");
}

#[test]
fn a_countdown_that_lands_on_its_bound_skips_the_tail() {
    two_vectors(BUTTERFLIES, 8).expect("verifies");
}

#[test]
fn a_countdown_that_lands_on_its_bound_still_catches_overreads() {
    let res = two_vectors(
        &BUTTERFLIES.replace("ldp q0, q1, [x0]", "ldp q0, q1, [x0, #16]"),
        8,
    );
    assert!(res.is_err(), "{res:?}");
}

fn branch_taken(body: &str, x2: usize) -> i64 {
    let program = format!("start:\n{body}\nmov x0, #1\nret\ntaken:\nmov x0, #2\nret");
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_immediate("x2", x2);
    engine.start("start").expect("runs");
    engine.get_register_output(0).offset
}

#[test]
fn bics_sets_zero_from_the_cleared_result() {
    let body = "mov w4, #15\nbics w3, w2, w4\nb.eq taken";
    assert_eq!(branch_taken(body, 12), 2);
    assert_eq!(branch_taken(body, 16), 1);
}

#[test]
fn a_32_bit_tst_reads_bit_31_as_negative() {
    let body = "tst w2, w2\nb.mi taken";
    assert_eq!(branch_taken(body, 1 << 31), 2);
    assert_eq!(branch_taken(body, 1 << 30), 1);
}

const COUNTDOWN_NE: &str = "start:
    loop:
    subs w2, w2, #16
    ld1 { v0.4s, v1.4s, v2.4s, v3.4s }, [x0], #64
    ld1 { v4.4s, v5.4s, v6.4s, v7.4s }, [x1], #64
    b.ne loop
    ret";

#[test]
fn a_modular_countdown_tested_by_ne_lands_on_zero() {
    two_vectors(COUNTDOWN_NE, 16).expect("verifies");
}

#[test]
fn a_modular_countdown_tested_by_ne_still_catches_overreads() {
    let res = two_vectors(
        &COUNTDOWN_NE.replace("subs w2, w2, #16", "subs w2, w2, #16\nldr q9, [x1, #64]"),
        16,
    );
    assert!(res.is_err(), "{res:?}");
}

const BLOCKS_BY_BICS: &str = "start:
    mov w4, #15
    bics w3, w2, w4
    b.eq done
    ld1 { v0.4s, v1.4s }, [x0], #32
    loop:
    subs w3, w3, #16
    ld1 { v2.4s, v3.4s }, [x0], #32
    b.eq done
    ld1 { v0.4s, v1.4s }, [x0], #32
    b loop
    done:
    ret";

#[test]
fn whole_blocks_counted_by_bics_are_in_bounds() {
    two_vectors(BLOCKS_BY_BICS, 16).expect("verifies");
}

#[test]
fn whole_blocks_counted_by_bics_still_catch_overreads() {
    let res = two_vectors(
        &BLOCKS_BY_BICS.replace(
            "b.eq done\n    ld1 { v0.4s, v1.4s }, [x0], #32\n    b loop",
            "ld1 { v0.4s, v1.4s }, [x0], #32\n    b.ne loop",
        ),
        16,
    );
    assert!(res.is_err(), "{res:?}");
}

fn x0_after(body: &str, x2: usize) -> RegisterValue {
    let program = format!("start:\n{body}\nret");
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_immediate("x2", x2);
    engine.start("start").expect("runs");
    engine.get_register_output(0)
}

#[test]
fn ubfiz_keeps_the_low_field_and_shifts_it_up() {
    assert_eq!(
        x0_after("ubfiz x0, x2, #4, #32", 0x1_0000_0003).offset,
        0x30
    );
    assert_eq!(x0_after("ubfiz w0, w2, #2, #4", 0xff).offset, 0x3c);
}

#[test]
fn sbfiz_sign_extends_the_field() {
    assert_eq!(x0_after("sbfiz x0, x2, #1, #4", 0xf).offset, -2);
}

#[test]
fn a_crc_result_is_unknown_data() {
    assert_eq!(x0_after("crc32x w0, w0, x2", 5).kind, RegisterKind::Number);
}

fn one_buffer(program: &str) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "buf");
    engine.add_region(RegionType::READ, "buf", abstract_of("len"));
    engine.add_abstract_from(1, "len");
    engine.add_invariant(fact("<=", abstract_of("len"), imm(1 << 40)));
    engine.start("start").map_err(|e| e.to_string())
}

const UNSIGNED_REMAINING: &str = "start:
    add x10, x0, x1
    sub x11, x10, x0
    cmp x11, #16
    b.lo done
    loop:
    ldr q17, [x0], #16
    sub x11, x10, x0
    cmp x11, #16
    b.hs loop
    done:
    ret";

#[test]
fn an_unsigned_remaining_count_never_wraps_while_the_loop_runs() {
    one_buffer(UNSIGNED_REMAINING).expect("verifies");
}

#[test]
fn an_unsigned_remaining_count_still_catches_overreads() {
    let res = one_buffer(
        &UNSIGNED_REMAINING.replace("ldr q17, [x0], #16", "ldr q17, [x0], #16\nldr q18, [x0]"),
    );
    assert!(res.is_err(), "{res:?}");
}

#[test]
fn a_step_larger_than_the_bound_keeps_the_wrapping() {
    let res =
        one_buffer(&UNSIGNED_REMAINING.replace("cmp x11, #16\n    b.hs", "cmp x11, #8\n    b.hs"));
    assert!(res.is_err(), "{res:?}");
}

fn byte_indexed_table(lookup: &str) -> Result<(), String> {
    byte_indexed_table_of(lookup, 64)
}

fn byte_indexed_table_of(lookup: &str, entries: i64) -> Result<(), String> {
    init();
    let program = format!("start:\nldrb w7, [x0, x1]\n{lookup}\nret");
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "buf");
    engine.add_region(RegionType::READ, "buf", abstract_of("len"));
    engine.add_abstract_from(1, "i");
    engine.add_invariant(fact("<", abstract_of("i"), abstract_of("len")));
    engine.add_invariant(fact(">=", abstract_of("i"), imm(0)));
    engine.add_abstract_from(2, "tbl");
    engine.add_region(RegionType::READ, "tbl", imm(entries));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_loaded_byte_shifted_down_indexes_a_64_entry_table() {
    byte_indexed_table("lsr x8, x7, #2\nldrb w8, [x2, x8]").expect("verifies");
    byte_indexed_table("ubfiz x9, x7, #4, #2\nldrb w9, [x2, x9]").expect("verifies");
}

#[test]
fn a_whole_loaded_byte_overruns_a_64_entry_table() {
    let res = byte_indexed_table("ldrb w8, [x2, x7]");
    assert!(res.is_err(), "{res:?}");
}

#[test]
fn a_sign_extended_loaded_byte_can_index_before_a_table() {
    byte_indexed_table_of("ldrb w8, [x2, x7]", 256).expect("verifies");
    let res = byte_indexed_table_of("ldrsb x7, [x0, x1]\nldrb w8, [x2, x7]", 256);
    assert!(res.is_err(), "{res:?}");
}

#[test]
fn bfi_replaces_only_its_field() {
    assert_eq!(
        x0_after("mov x0, #0xff\nbfi x0, x2, #4, #2", 0b10).offset,
        0xef
    );
    assert_eq!(x0_after("mov w0, #0\nbfxil w0, w2, #4, #3", 0x50).offset, 5);
}

#[test]
fn a_field_inserted_from_loaded_bytes_indexes_a_64_entry_table() {
    byte_indexed_table(
        "ldrb w8, [x0, x1]\nlsr w10, w8, #4\nbfi w10, w7, #4, #2\nldrb w9, [x2, x10]",
    )
    .expect("verifies");
    let res = byte_indexed_table(
        "ldrb w8, [x0, x1]\nlsr w10, w8, #4\nbfi w10, w7, #4, #3\nldrb w9, [x2, x10]",
    );
    assert!(res.is_err(), "{res:?}");
}

#[test]
fn byte_reversals_work_at_the_register_width() {
    assert_eq!(x0_after("rev w0, w2", 0x1122_3344).offset, 0x4433_2211);
    assert_eq!(x0_after("rev16 w0, w2", 0x1122_3344).offset, 0x2211_4433);
    assert_eq!(
        x0_after("rev x0, x2", 0x1122_3344).offset,
        0x4433_2211_0000_0000
    );
    assert_eq!(x0_after("rbit w0, w2", 1).offset, 0x8000_0000);
}

#[test]
fn a_32_bit_unsigned_division_by_a_known_divisor() {
    assert_eq!(x0_after("mov w3, #45\nudiv w0, w2, w3", 100).offset, 2);
    assert_eq!(
        x0_after("mov w3, #0\nudiv w0, w2, w3", 100).kind,
        RegisterKind::Number
    );
    assert_eq!(
        x0_after("mov x3, #5\nsdiv x0, x2, x3", 100).kind,
        RegisterKind::Number
    );
}

#[test]
fn a_prefetch_touches_nothing() {
    assert_eq!(x0_after("prfm pldl1keep, [x2]\nmov x0, #1", 0).offset, 1);
}

fn reads_past_on_one_side(branch: &str) -> Result<(), String> {
    init();
    let program =
        format!("start:\nsdiv x3, x1, x1\n{branch} x3, skip\nldr x4, [x0, #8]\nskip:\nret");
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "buf");
    engine.add_region(RegionType::READ, "buf", imm(8));
    engine.add_abstract_from(1, "n");
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn cbz_on_an_unknown_register_explores_both_ways() {
    assert!(reads_past_on_one_side("cbz").is_err());
    assert!(reads_past_on_one_side("cbnz").is_err());
}

#[test]
fn conditional_increments_inversions_and_negations() {
    assert_eq!(x0_after("cmp x2, #5\ncneg x0, x2, lt", 3).offset, -3);
    assert_eq!(x0_after("cmp x2, #5\ncneg x0, x2, lt", 7).offset, 7);
    assert_eq!(
        x0_after("mov x1, #9\ncmp x2, #5\ncsinc x0, x1, x2, eq", 5).offset,
        9
    );
    assert_eq!(
        x0_after("mov x1, #9\ncmp x2, #5\ncsinc x0, x1, x2, eq", 6).offset,
        7
    );
    assert_eq!(x0_after("cmp x2, #5\ncinc x0, x2, ne", 6).offset, 7);
}

#[test]
fn ccmp_compares_only_when_its_condition_holds() {
    assert_eq!(
        x0_after(
            "cmp x2, #5\nccmp x2, #3, #0, le\nmov x0, #1\ncsinc x0, x0, x0, le",
            2
        )
        .offset,
        1
    );
    assert_eq!(
        x0_after(
            "cmp x2, #5\nccmp x2, #3, #0, le\nmov x0, #1\ncsinc x0, x0, x0, le",
            4
        )
        .offset,
        2
    );
    assert_eq!(
        x0_after(
            "cmp x2, #5\nccmp x2, #3, #4, le\nmov x0, #1\ncsinc x0, x0, x0, le",
            9
        )
        .offset,
        1
    );
}

fn variable_frame(body: &str) -> Result<(), String> {
    init();
    let program = format!("start:\nlsl x9, x1, #7\nsub sp, sp, x9\n{body}\nadd sp, sp, x9\nret");
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(1, "h");
    engine.add_invariant(fact(">=", abstract_of("h"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("h"), imm(64)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_frame_sized_at_run_time_bounds_its_own_accesses() {
    variable_frame("str q0, [sp]\nsub x10, x9, #16\nstr q0, [sp, x10]").expect("verifies");
    assert!(variable_frame("str q0, [sp, x9]").is_err());
    assert!(variable_frame("str q0, [sp, #-16]").is_err());
}

fn rows_in_pairs(program: &str) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "buf");
    engine.add_region(
        RegionType::READ,
        "buf",
        generate_expression("*", abstract_of("h"), abstract_of("stride")),
    );
    engine.add_abstract_from(1, "stride");
    engine.add_abstract_from(2, "h");
    engine.add_invariant(fact(">=", abstract_of("stride"), imm(4)));
    engine.add_invariant(fact("<=", abstract_of("stride"), imm(1 << 20)));
    engine.add_invariant(fact(">=", abstract_of("h"), imm(2)));
    engine.add_invariant(fact("<=", abstract_of("h"), imm(64)));
    engine.add_invariant(fact(
        "==",
        generate_expression("%", abstract_of("h"), imm(2)),
        imm(0),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

const PAIRS_HI: &str = "start:
    loop:
    ldr s0, [x0]
    ldr s1, [x0, x1]
    subs w2, w2, #2
    add x0, x0, x1, lsl #1
    b.hi loop
    ret";

#[test]
fn an_unsigned_word_countdown_by_pairs_is_bounded() {
    rows_in_pairs(PAIRS_HI).expect("verifies");
}

#[test]
fn an_unsigned_word_countdown_by_pairs_still_catches_overreads() {
    let res = rows_in_pairs(&PAIRS_HI.replace(
        "ldr s1, [x0, x1]",
        "ldr s1, [x0, x1]\nldr s2, [x0, x1, lsl #1]",
    ));
    assert!(res.is_err(), "{res:?}");
}

fn saved_pointer(between: &str) -> Result<(), String> {
    init();
    let program = format!(
        "start:\nlsl x9, x1, #7\nsub sp, sp, x9\nstp x0, x30, [sp, #-16]!\n{between}\nldp x0, x30, [sp], #16\nldr x4, [x0]\nadd sp, sp, x9\nret"
    );
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "buf");
    engine.add_region(RegionType::READ, "buf", imm(8));
    engine.add_abstract_from(1, "h");
    engine.add_abstract_from(2, "k");
    engine.add_invariant(fact(">=", abstract_of("h"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("h"), imm(64)));
    engine.add_invariant(fact(">=", abstract_of("k"), imm(0)));
    engine.add_invariant(fact("<=", abstract_of("k"), imm(8)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_register_saved_at_a_symbolic_slot_comes_back() {
    saved_pointer("mov x0, #0\nstr x3, [sp, #16]").expect("verifies");
    assert!(saved_pointer("mov x0, #0\nadd x5, sp, x2\nstr x3, [x5]").is_err());
}

fn saved_across_loop(loop_body: &str) -> Result<(), String> {
    init();
    let program = format!(
        "start:\nlsl x9, x1, #7\nsub sp, sp, x9\nstp x0, x30, [sp, #-16]!\nmov x0, #0\nadd x5, sp, #16\nmov x6, x1\nloop:\n{loop_body}\nsubs x6, x6, #1\nb.ne loop\nldp x0, x30, [sp], #16\nldr x4, [x0]\nadd sp, sp, x9\nret"
    );
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "buf");
    engine.add_region(RegionType::READ, "buf", imm(8));
    engine.add_abstract_from(1, "h");
    engine.add_invariant(fact(">=", abstract_of("h"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("h"), imm(64)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_saved_slot_survives_a_loop_that_writes_elsewhere() {
    saved_across_loop("str q0, [x5], #128").expect("verifies");
}

#[test]
fn a_saved_slot_is_lost_to_a_loop_that_may_write_it() {
    let res = saved_across_loop("str q0, [x5], #128\nsub x7, x5, #144\nstr x3, [x7]");
    assert!(res.is_err(), "{res:?}");
}

fn saved_above_frame(store: &str) -> Result<(), String> {
    init();
    let program = format!(
        "start:\nstr x0, [sp, #-16]!\nlsl x9, x1, #7\nsub sp, sp, x9\n{store}\nadd sp, sp, x9\nldr x0, [sp], #16\nldr x4, [x0]\nret"
    );
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "buf");
    engine.add_region(RegionType::READ, "buf", imm(8));
    engine.add_abstract_from(1, "h");
    engine.add_abstract_from(2, "k");
    engine.add_invariant(fact(">=", abstract_of("h"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("h"), imm(64)));
    engine.add_invariant(fact(">=", abstract_of("k"), imm(0)));
    engine.add_invariant(fact(
        "<=",
        abstract_of("k"),
        generate_expression("*", abstract_of("h"), imm(8)),
    ));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_store_into_a_run_time_frame_keeps_what_lies_above_it() {
    saved_above_frame("add x5, sp, x2\nand x5, x5, #-16\nstr q0, [sp]").expect("verifies");
    let res = saved_above_frame("lsl x6, x2, #4\nstr q0, [sp, x6]");
    assert!(res.is_err(), "{res:?}");
}

#[test]
fn cset_and_csetm_on_every_condition() {
    assert_eq!(x0_after("cmp x2, #5\ncset x0, gt", 7).offset, 1);
    assert_eq!(x0_after("cmp x2, #5\ncset x0, gt", 5).offset, 0);
    assert_eq!(x0_after("cmp x2, #5\ncsetm x0, le", 5).offset, -1);
    assert_eq!(x0_after("cmp x2, #5\ncset w0, cs", 9).offset, 1);
}

fn pointer_rows(program: &str) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "rows");
    engine.add_region(
        RegionType::READ,
        "rows",
        generate_expression("*", abstract_of("n"), imm(8)),
    );
    engine.add_abstract_from(1, "n");
    engine.add_abstract_from(2, "len");
    engine.add_region(
        RegionType::READ,
        "rows_row",
        generate_expression("*", abstract_of("len"), imm(2)),
    );
    engine.add_pointer_elements("rows", "rows_row");
    engine.add_invariant(fact(">=", abstract_of("n"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("n"), imm(64)));
    engine.add_invariant(fact(">=", abstract_of("len"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("len"), imm(1 << 14)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_pointer_loaded_from_a_pointer_array_bounds_its_row() {
    let program = "start:
        sub x5, x2, #1
        loop:
        ldr x3, [x0], #8
        ldrh w4, [x3, x5, lsl #1]
        subs x1, x1, #1
        b.ne loop
        ret";
    assert_eq!(pointer_rows(program), Ok(()));
}

#[test]
fn a_row_read_one_past_its_length_is_caught() {
    let program = "start:
        ldr x3, [x0]
        ldrh w4, [x3, x2, lsl #1]
        ret";
    assert!(pointer_rows(program).is_err());
}

#[test]
fn a_pointer_read_across_two_elements_is_no_pointer() {
    let program = "start:
        ldr x3, [x0, #4]
        ldrh w4, [x3]
        ret";
    assert!(pointer_rows(program).is_err());
}

fn clamped_lane(program: &str) -> Result<(), String> {
    init();
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "lut");
    engine.add_region(
        RegionType::READ,
        "lut",
        generate_expression(
            "*",
            generate_expression("+", abstract_of("max"), imm(1)),
            imm(4),
        ),
    );
    engine.add_abstract_from(1, "max");
    engine.add_invariant(fact(">=", abstract_of("max"), imm(0)));
    engine.add_invariant(fact("<=", abstract_of("max"), imm(1 << 30)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_lane_clamped_by_umin_indexes_its_table() {
    let program = "start:
        dup v7.4s, w1
        umin v3.4s, v0.4s, v7.4s
        mov w8, v3.s[2]
        umov w9, v3.s[0]
        ldr s4, [x0, w8, uxtw #2]
        ldr s5, [x0, w9, uxtw #2]
        ret";
    assert_eq!(clamped_lane(program), Ok(()));
}

#[test]
fn an_unclamped_lane_does_not_index_the_table() {
    let program = "start:
        dup v7.4s, w1
        mov w8, v0.s[2]
        ldr s4, [x0, w8, uxtw #2]
        ret";
    assert!(clamped_lane(program).is_err());
}

#[test]
fn a_lane_written_after_the_clamp_loses_its_bound() {
    let program = "start:
        dup v7.4s, w1
        umin v3.4s, v0.4s, v7.4s
        add v3.4s, v3.4s, v3.4s
        mov w8, v3.s[2]
        ldr s4, [x0, w8, uxtw #2]
        ret";
    assert!(clamped_lane(program).is_err());
}

#[test]
fn csel_ls_clamps_an_index() {
    let clamped = "start:
        ldr w2, [x2]
        cmp w2, w1
        csel w2, w2, w1, ls
        ldr s0, [x0, w2, uxtw #2]
        ret";
    let unclamped = "start:
        ldr w2, [x2]
        cmp w2, w1
        csel w2, w2, w1, hi
        ldr s0, [x0, w2, uxtw #2]
        ret";
    let run = |program: &str| {
        init();
        let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
        engine.add_abstract_from(0, "lut");
        engine.add_region(
            RegionType::READ,
            "lut",
            generate_expression(
                "*",
                generate_expression("+", abstract_of("max"), imm(1)),
                imm(4),
            ),
        );
        engine.add_abstract_from(1, "max");
        engine.add_invariant(fact(">=", abstract_of("max"), imm(0)));
        engine.add_invariant(fact("<=", abstract_of("max"), imm(1 << 30)));
        engine.add_abstract_from(2, "data");
        engine.add_region(RegionType::READ, "data", imm(4));
        engine.start("start").map_err(|e| e.to_string())
    };
    assert_eq!(run(clamped), Ok(()));
    assert!(run(unclamped).is_err());
}

#[test]
fn a_store_into_one_buffer_keeps_a_slot_in_another() {
    init();
    let program = "start:
        str x5, [x0, x3]
        loop:
        str w6, [x1], #4
        subs x2, x2, #1
        b.ne loop
        ldr x7, [x0, x3]
        ret";
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "a");
    engine.add_region(RegionType::RW, "a", imm(64));
    engine.add_abstract_from(1, "b");
    engine.add_region(
        RegionType::RW,
        "b",
        generate_expression("*", abstract_of("n"), imm(4)),
    );
    engine.add_abstract_from(2, "n");
    engine.add_abstract_from(3, "k");
    engine.add_invariant(fact(">=", abstract_of("n"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("n"), imm(1 << 20)));
    engine.add_invariant(fact(">=", abstract_of("k"), imm(0)));
    engine.add_invariant(fact("<=", abstract_of("k"), imm(56)));
    assert_eq!(engine.start("start").map_err(|e| e.to_string()), Ok(()));
}

#[test]
fn a_32_bit_compare_of_a_folded_word_reads_it_signed() {
    for compare in ["cmn w0, #2", "cmp w0, #0"] {
        init();
        let program = format!(
            "start:
            mov w0, #1
            sub w0, w0, #4
            {compare}
            b.lt done
            ldr x2, [x1, #64]
            done:
            ret"
        );
        let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
        engine.add_abstract_from(1, "buf");
        engine.add_region(RegionType::READ, "buf", imm(8));
        assert_eq!(
            engine.start("start").map_err(|e| e.to_string()),
            Ok(()),
            "{compare}"
        );
    }
}

fn forked_body(read: &str) -> Result<(), String> {
    init();
    let program = format!(
        "start:
        loop:
        ldr w4, [x0]
        cmp w4, #7
        csel x5, x7, x0, eq
        {read}
        mov x5, #0
        add x0, x0, #4
        add x7, x7, #4
        subs x1, x1, #1
        b.ne loop
        ret"
    );
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "buf");
    engine.add_region(
        RegionType::READ,
        "buf",
        generate_expression("*", abstract_of("n"), imm(4)),
    );
    engine.add_abstract_from(1, "n");
    engine.add_abstract_from(7, "other");
    engine.add_region(
        RegionType::READ,
        "other",
        generate_expression(
            "*",
            generate_expression("+", abstract_of("n"), imm(1)),
            imm(4),
        ),
    );
    engine.add_invariant(fact(">=", abstract_of("n"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("n"), imm(1 << 20)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn the_second_side_of_a_fork_in_a_loop_keeps_the_loop_facts() {
    assert_eq!(forked_body("ldr w6, [x5]"), Ok(()));
}

fn divided_index(scale: i64) -> Result<(), String> {
    init();
    let program = format!(
        "start:
        mov x8, #-6148914691236517206
        movk x8, #43691
        umulh x8, x1, x8
        lsr x9, x8, #7
        lsl x9, x9, #{scale}
        ldrb w10, [x0, x9]
        ret"
    );
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "buf");
    engine.add_region(RegionType::READ, "buf", abstract_of("n"));
    engine.add_abstract_from(1, "n");
    engine.add_invariant(fact(">=", abstract_of("n"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("n"), imm(1 << 30)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn umulh_is_the_high_half_of_the_product() {
    assert_eq!(divided_index(7), Ok(()));
    assert!(divided_index(8).is_err());
}

fn immediate_minus_register(offset: i64) -> Result<(), String> {
    init();
    let program = format!(
        "start:
        mov x14, #128
        sub x13, x14, w5, uxtw #1
        add x0, x0, x13
        add x0, x0, x5, lsl #1
        ldrb w1, [x0, #{offset}]
        ret"
    );
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "buf");
    engine.add_region(RegionType::READ, "buf", imm(256));
    engine.add_abstract_from(5, "w");
    engine.add_invariant(fact(">=", abstract_of("w"), imm(0)));
    engine.add_invariant(fact("<=", abstract_of("w"), imm(64)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_register_subtracted_from_an_immediate_is_negated() {
    assert_eq!(immediate_minus_register(127), Ok(()));
    assert!(immediate_minus_register(128).is_err());
}

fn rows_with_a_reset_cursor(width: i64) -> Result<(), String> {
    init();
    let program = "start:
        row:
        mov x10, x0
        mov w9, w2
        col:
        ldr q0, [x10], #16
        subs w9, w9, #16
        b.gt col
        add x0, x0, x3
        subs x1, x1, #1
        b.gt row
        ret";
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "src");
    engine.add_region(
        RegionType::READ,
        "src",
        generate_expression("*", abstract_of("h"), abstract_of("stride")),
    );
    engine.add_abstract_from(1, "h");
    engine.add_abstract_from(2, "w");
    engine.add_abstract_from(3, "stride");
    engine.add_invariant(fact("==", abstract_of("w"), imm(width)));
    engine.add_invariant(fact(">=", abstract_of("stride"), imm(width)));
    engine.add_invariant(fact("<=", abstract_of("stride"), imm(1 << 20)));
    engine.add_invariant(fact(">=", abstract_of("h"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("h"), imm(64)));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_cursor_reset_every_row_does_not_block_the_row_summary() {
    assert_eq!(rows_with_a_reset_cursor(32), Ok(()));
    assert_eq!(rows_with_a_reset_cursor(48), Ok(()));
}

#[test]
fn a_literal_in_the_guard_is_not_a_loaded_value() {
    init();
    let program = [
        "start:",
        "adrp x7, tbl",
        "add x7, x7, :lo12:tbl",
        "ldr w8, [x7]",
        "row:",
        "ldrb w9, [x0], #1",
        "subs w6, w6, #1",
        "b.ne row",
        "ret",
        "\t.section .rodata",
        "tbl:",
        "\t.size tbl, 4",
        "\t.word 1",
    ];
    let mut engine = bums::engine::ExecutionEngine::new(program.iter().map(|s| s.to_string()));
    engine.add_abstract_from(0, "buf");
    engine.add_region(RegionType::READ, "buf", abstract_of("h"));
    engine.add_abstract_from(6, "h");
    engine.add_invariant(fact(">=", abstract_of("h"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("h"), imm(1 << 20)));
    assert_eq!(engine.start("start").map_err(|e| e.to_string()), Ok(()));
}

#[test]
fn a_loop_entered_again_after_closing_is_summarized_again() {
    init();
    let program = "start:
        mov w5, #2
        row:
        mov x9, x0
        mov w8, w1
        col:
        ldrb w2, [x9], #1
        subs w8, w8, #1
        b.ne col
        subs w5, w5, #1
        b.ne row
        ret";
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(0, "buf");
    engine.add_region(RegionType::READ, "buf", abstract_of("w"));
    engine.add_abstract_from(1, "w");
    engine.add_invariant(fact(">=", abstract_of("w"), imm(1)));
    engine.add_invariant(fact("<=", abstract_of("w"), imm(1 << 20)));
    assert_eq!(engine.start("start").map_err(|e| e.to_string()), Ok(()));
}

fn read_below_a_table(offset: i64) -> Result<(), String> {
    init();
    let load = format!("ldr w8, [x7, #{offset}]");
    let program = [
        "start:",
        "adrp x7, tbl-16",
        "add x7, x7, :lo12:tbl-16",
        &load,
        "ret",
        "\t.section .rodata",
        "tbl:",
        "\t.size tbl, 4",
        "\t.word 1",
    ];
    let mut engine = bums::engine::ExecutionEngine::new(program.iter().map(|s| s.to_string()));
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn a_label_with_a_negative_addend_points_before_its_symbol() {
    assert_eq!(read_below_a_table(16), Ok(()));
    assert!(read_below_a_table(12).is_err());
}

fn index_through_a_map(load: &str, ranges: &[(&str, i64)]) -> Result<(), String> {
    init();
    let program = format!(
        "start:
        {load}
        ldr d0, [x2, x10, lsl #3]
        ldr d1, [x2, x11, lsl #3]
        ret"
    );
    let mut engine = bums::engine::ExecutionEngine::new(program.lines().map(str::trim));
    engine.add_abstract_from(1, "map");
    engine.add_region(RegionType::READ, "map", imm(12));
    engine.add_abstract_from(2, "input");
    engine.add_region(RegionType::READ, "input", imm(64));
    for (op, bound) in ranges {
        engine.add_element_range("map", 4, true, op, imm(*bound));
    }
    engine.start("start").map_err(|e| e.to_string())
}

#[test]
fn an_unsigned_read_of_a_nonnegative_signed_element_keeps_its_range() {
    let both = [(">=", 0), ("<", 8)];
    assert_eq!(index_through_a_map("ldp w10, w11, [x1]", &both), Ok(()));
    assert_eq!(index_through_a_map("ldp w10, w11, [x1, #4]", &both), Ok(()));
}

#[test]
fn an_unsigned_read_of_a_possibly_negative_element_is_unbounded() {
    let res = index_through_a_map("ldp w10, w11, [x1]", &[("<", 8)]);
    assert!(res.is_err(), "{res:?}");
    let res = index_through_a_map("ldp w10, w11, [x1]", &[(">=", -1), ("<", 8)]);
    assert!(res.is_err(), "{res:?}");
}

#[test]
fn a_read_straddling_two_elements_is_not_an_element() {
    let ranges = [(">=", 0), ("<", 8)];
    let aligned = "ldrsw x10, [x1]\nldrsw x11, [x1, #4]";
    assert_eq!(index_through_a_map(aligned, &ranges), Ok(()));
    let res = index_through_a_map("ldrsw x10, [x1, #2]\nldrsw x11, [x1, #6]", &ranges);
    assert!(res.is_err(), "{res:?}");
}
