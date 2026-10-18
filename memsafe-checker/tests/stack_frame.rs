// The stack is the one region that extends below its base: a function's frame
// runs from the current stack pointer up to the value it was passed, and only
// the caller's incoming arguments sit above that. These pin both ends.

fn init() {
    let _ = env_logger::builder().is_test(true).try_init();
}

fn accepts(body: &[&str]) -> bool {
    accepts_with_arguments(body, 0)
}

// `arguments` is how many values the caller passed; the ninth onward are on the
// stack, which is the only thing that makes an access above the entry stack
// pointer safe.
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
    // At displacement 0 the access is in the caller's frame, not this one.
    assert!(!accepts(&[
        "sub sp,sp,#16",
        "str x0,[sp,#16]",
        "add sp,sp,#16",
    ]));
    // And an access that merely reaches it is just as wrong.
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
    // aarch64 has no red zone, so nothing below the pointer belongs to us.
    assert!(!accepts(&[
        "sub sp,sp,#16",
        "stur x0,[sp,#-8]",
        "add sp,sp,#16",
    ]));
}

// Apple's arm64 ABI keeps the 128 bytes below the stack pointer intact; plain
// AAPCS64 promises nothing there. Code written for Apple asks for the red zone,
// and an access in it is then listed as a finding rather than failed.
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
    // Nine arguments put one eight-byte value at the entry pointer.
    assert!(accepts_with_arguments(&["ldr x0,[sp,#0]"], 9));
    // Nothing above it was passed, so nothing above it is ours to read.
    assert!(!accepts_with_arguments(&["ldr x0,[sp,#8]"], 9));
}

// The index a reduced comparison mask produces is symbolic and negative, which
// is the shape the frame bound has to handle: `msac_decode_symbol_adapt16`
// indexes its frame by `sp + 2 * w15` with `w15` in [-16, 0].
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
    // At -16 the read is at the very bottom of the frame: 32 - 48 - 32 = -48.
    let mut body = MASK_INDEX.to_vec();
    body.push("ldrh w3,[x8,#32]");
    body.push("add sp,sp,#48");
    assert!(accepts(&body));

    // Two bytes lower leaves it.
    let mut body = MASK_INDEX.to_vec();
    body.push("ldrh w3,[x8,#30]");
    body.push("add sp,sp,#48");
    assert!(!accepts(&body));
}

#[test]
fn a_symbolic_frame_index_is_bounded_above() {
    // At 0 the read is at the entry pointer, one element past the frame. This
    // is the access `msac_decode_symbol_adapt16` cannot justify without knowing
    // its cdf ends in a zero.
    let mut body = MASK_INDEX.to_vec();
    body.push("ldrh w3,[x8,#48]");
    body.push("add sp,sp,#48");
    assert!(!accepts(&body));

    // Two bytes lower is the last halfword of the frame, which is in range.
    let mut body = MASK_INDEX.to_vec();
    body.push("ldrh w3,[x8,#46]");
    body.push("add sp,sp,#48");
    assert!(accepts(&body));
}

// A value loaded out of the frame is named `sp[...]`, so an address built from
// one mentions the stack without being on it. filmgrain indexes its jump tables
// that way, and the access has to be checked against the table.
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
