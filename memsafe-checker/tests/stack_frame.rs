fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn accepts(body: &[&str]) -> bool {
    accepts_with_arguments(body, 0)
}

fn accepts_with_arguments(body: &[&str], arguments: usize) -> bool {
    init();
    let mut program = vec!["start:".to_string()];
    program.extend(body.iter().map(|line| line.to_string()));
    program.push("ret".to_string());

    let mut engine = bums::engine::ExecutionEngine::new(program);
    for argument in 0..arguments {
        engine.add_abstract_from(argument, format!("arg{argument}"));
    }
    engine.start("start".to_string()).is_ok()
}

#[test]
fn the_frame_a_function_opens_is_writable() {
    assert!(accepts(&[
        "sub sp,sp,#16",
        "str x0,[sp,#0]",
        "str x0,[sp,#8]",
        "add sp,sp,#16",
    ]));
}

#[test]
fn the_top_of_the_frame_is_the_entry_pointer() {
    assert!(!accepts(&[
        "sub sp,sp,#16",
        "str x0,[sp,#16]",
        "add sp,sp,#16",
    ]));
    assert!(!accepts(&[
        "sub sp,sp,#16",
        "str x0,[sp,#9]",
        "add sp,sp,#16",
    ]));
}

fn run_with_findings(body: &[&str], red_zone: Option<i64>) -> (bool, Vec<String>) {
    init();
    let mut program = vec!["start:".to_string()];
    program.extend(body.iter().map(|line| line.to_string()));
    program.push("ret".to_string());
    let mut engine = bums::engine::ExecutionEngine::new(program);
    if let Some(bytes) = red_zone {
        engine.allow_red_zone(bytes);
    }
    let ok = engine.start("start".to_string()).is_ok();
    (ok, engine.findings())
}

#[test]
fn below_the_stack_pointer_is_not_in_the_frame() {
    assert!(!accepts(&[
        "sub sp,sp,#16",
        "stur x0,[sp,#-8]",
        "add sp,sp,#16",
    ]));
}

#[test]
fn below_the_stack_pointer_is_a_finding_within_an_allowed_red_zone() {
    let (ok, findings) = run_with_findings(
        &["sub sp,sp,#16", "stur x0,[sp,#-8]", "add sp,sp,#16"],
        Some(128),
    );
    assert!(ok);
    assert_eq!(findings.len(), 1, "{findings:?}");
    assert!(findings[0].contains("red zone"), "{findings:?}");

    let (ok, _) = run_with_findings(&["ldp x1,x2,[sp,#-128]"], Some(128));
    assert!(ok);
    let (ok, _) = run_with_findings(&["ldr x1,[sp,#-136]"], Some(128));
    assert!(!ok, "past the red zone");
}

#[test]
fn without_a_red_zone_below_the_stack_pointer_is_no_finding_but_a_failure() {
    let (ok, findings) = run_with_findings(&["ldr x1,[sp,#-8]"], None);
    assert!(!ok);
    assert!(findings.is_empty(), "{findings:?}");
}

#[test]
fn an_access_inside_the_frame_is_no_finding() {
    let (ok, findings) =
        run_with_findings(&["sub sp,sp,#16", "str x0,[sp,#8]", "add sp,sp,#16"], None);
    assert!(ok);
    assert!(findings.is_empty(), "{findings:?}");
}

#[test]
fn a_function_that_opens_no_frame_has_none() {
    assert!(!accepts(&["str x0,[sp,#0]"]));
}

#[test]
fn pre_index_opens_the_frame_before_the_store() {
    assert!(accepts(&["str x0,[sp,#-16]!", "ldr x0,[sp],#16"]));
}

#[test]
fn incoming_stack_arguments_are_readable_above_the_pointer() {
    assert!(accepts_with_arguments(&["ldr x0,[sp,#0]"], 9));
    assert!(!accepts_with_arguments(&["ldr x0,[sp,#8]"], 9));
}

const MASK_INDEX: &[&str] = &[
    "sub sp,sp,#48",
    "cmhs v2.8h, v30.8h, v4.8h",
    "cmhs v3.8h, v30.8h, v5.8h",
    "add v6.8h, v2.8h, v3.8h",
    "addv h31, v6.8h",
    "smov w15, v31.h[0]",
    "add x8, sp, w15, sxtw #1",
];

#[test]
fn a_symbolic_frame_index_is_bounded_below() {
    let mut body = MASK_INDEX.to_vec();
    body.push("ldrh w3,[x8,#32]");
    body.push("add sp,sp,#48");
    assert!(accepts(&body));

    let mut body = MASK_INDEX.to_vec();
    body.push("ldrh w3,[x8,#30]");
    body.push("add sp,sp,#48");
    assert!(!accepts(&body));
}

#[test]
fn a_symbolic_frame_index_is_bounded_above() {
    let mut body = MASK_INDEX.to_vec();
    body.push("ldrh w3,[x8,#48]");
    body.push("add sp,sp,#48");
    assert!(!accepts(&body));

    let mut body = MASK_INDEX.to_vec();
    body.push("ldrh w3,[x8,#46]");
    body.push("add sp,sp,#48");
    assert!(accepts(&body));
}

#[test]
fn an_index_loaded_from_the_frame_is_not_a_frame_access() {
    init();
    let program = vec![
        "start:".to_string(),
        "sub sp,sp,#16".to_string(),
        "ldr x9,[sp,#0]".to_string(),
        "add x1,x0,x9".to_string(),
        "ldrb w2,[x1]".to_string(),
        "add sp,sp,#16".to_string(),
        "ret".to_string(),
    ];
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(0, "base".to_string());
    engine.add_region(
        bums::common::RegionType::RW,
        "base".to_string(),
        bums::common::AbstractExpression::Immediate(1024),
    );

    let error = engine.start("start".to_string()).unwrap_err().to_string();
    assert!(error.contains("region of length 1024"), "{error}");
    assert!(!error.contains("stack frame"), "{error}");
}

fn walks_a_frame_sized_at_run_time_then_reads_a_saved_count(read_offset: i64) -> bool {
    use bums::common::*;
    init();
    let mut program = vec!["start:".to_string()];
    program.extend(
        [
            "stp x2,x30,[sp,#-16]!",
            "lsl x10,x2,#3",
            "sub sp,sp,x10",
            "loop:",
            "ldr x4,[sp],#8",
            "subs x2,x2,#1",
            "b.ne loop",
            "ldp x2,x30,[sp],#16",
            "lsl x5,x2,#3",
        ]
        .iter()
        .map(|line| line.to_string()),
    );
    program.push(format!("add x5,x5,#{read_offset}"));
    program.push("ldr x4,[x1,x5]".to_string());
    program.push("ret".to_string());
    let count = AbstractExpression::Abstract("count".to_string());
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(1, "base".to_string());
    engine.add_region(
        RegionType::READ,
        "base".to_string(),
        generate_expression("*", count.clone(), AbstractExpression::Immediate(8)),
    );
    engine.add_abstract_from(2, "count".to_string());
    engine.add_invariant(AbstractComparison::new(
        ">=",
        count.clone(),
        AbstractExpression::Immediate(1),
    ));
    engine.add_invariant(AbstractComparison::new(
        "<=",
        count,
        AbstractExpression::Immediate(1 << 20),
    ));
    engine.start("start".to_string()).is_ok()
}

#[test]
fn a_slot_saved_below_a_walked_frame_is_read_back_where_the_walk_ends() {
    assert!(walks_a_frame_sized_at_run_time_then_reads_a_saved_count(-8));
}

#[test]
fn a_slot_read_back_after_a_walked_frame_still_bounds_the_access() {
    assert!(!walks_a_frame_sized_at_run_time_then_reads_a_saved_count(0));
}
