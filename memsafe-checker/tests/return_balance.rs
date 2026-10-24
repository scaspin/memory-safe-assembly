use std::sync::{Mutex, MutexGuard};

static MESSAGES: Mutex<Vec<String>> = Mutex::new(Vec::new());
static INSTALLED: Mutex<bool> = Mutex::new(false);
static SERIAL: Mutex<()> = Mutex::new(());

struct Capture;

impl log::Log for Capture {
    fn enabled(&self, metadata: &log::Metadata) -> bool {
        metadata.level() <= log::Level::Error
    }

    fn log(&self, record: &log::Record) {
        if self.enabled(record.metadata()) {
            MESSAGES
                .lock()
                .expect("messages")
                .push(record.args().to_string());
        }
    }

    fn flush(&self) {}
}

fn install() {
    let mut installed = INSTALLED.lock().unwrap_or_else(|e| e.into_inner());
    if !*installed {
        log::set_boxed_logger(Box::new(Capture)).expect("logger");
        log::set_max_level(log::LevelFilter::Error);
        *installed = true;
    }
}

fn errors_from(body: &[&str]) -> Vec<String> {
    install();
    let mut held: MutexGuard<Vec<String>> = MESSAGES.lock().unwrap_or_else(|e| e.into_inner());
    held.clear();
    drop(held);

    let mut program = vec!["start:".to_string()];
    program.extend(body.iter().map(|line| line.to_string()));
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(1, "buf".to_string());
    engine.add_region(
        bums::common::RegionType::READ,
        "buf".to_string(),
        bums::common::AbstractExpression::Immediate(8),
    );
    let outcome = engine.start("start".to_string());
    assert!(outcome.is_ok(), "{outcome:?}");

    MESSAGES.lock().unwrap_or_else(|e| e.into_inner()).clone()
}

fn complaints(body: &[&str]) -> Vec<String> {
    errors_from(body)
        .into_iter()
        .filter(|m| m.contains("stack pointer not restored"))
        .collect()
}

#[test]
fn the_stack_pointer_is_checked_at_a_return_but_not_at_a_trap() {
    let _serial = SERIAL.lock().unwrap_or_else(|e| e.into_inner());

    assert_eq!(
        complaints(&["stp x29,x30,[sp,#-0x10]!", "ldp x29,x30,[sp],#0x10", "ret"]),
        Vec::<String>::new()
    );

    let unbalanced = complaints(&["stp x29,x30,[sp,#-0x10]!", "ret"]);
    assert_eq!(unbalanced.len(), 1, "{unbalanced:?}");
    assert!(
        unbalanced[0].contains("line 2") && unbalanced[0].contains("-16"),
        "{unbalanced:?}"
    );

    assert_eq!(
        complaints(&["stp x29,x30,[sp,#-0x10]!", "brk #0x1"]),
        Vec::<String>::new()
    );

    assert_eq!(
        complaints(&["stp x29,x30,[sp,#-0x10]!", "udf #0x0"]),
        Vec::<String>::new()
    );
}

#[test]
fn a_trap_ends_the_path() {
    let _serial = SERIAL.lock().unwrap_or_else(|e| e.into_inner());

    let outcome = {
        install();
        let program = ["start:", "brk #0x1", "ldr x0,[x1,#64]"]
            .iter()
            .map(|s| s.to_string())
            .collect::<Vec<_>>();
        let mut engine = bums::engine::ExecutionEngine::new(program);
        engine.add_abstract_from(1, "buf".to_string());
        engine.add_region(
            bums::common::RegionType::READ,
            "buf".to_string(),
            bums::common::AbstractExpression::Immediate(8),
        );
        engine.start("start".to_string())
    };
    assert!(outcome.is_ok(), "{outcome:?}");

    let program = ["start:", "ldr x0,[x1,#64]", "ret"]
        .iter()
        .map(|s| s.to_string())
        .collect::<Vec<_>>();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(1, "buf".to_string());
    engine.add_region(
        bums::common::RegionType::READ,
        "buf".to_string(),
        bums::common::AbstractExpression::Immediate(8),
    );
    assert!(engine.start("start".to_string()).is_err());
}

fn outcome_of(lines: &[&str]) -> Result<(), String> {
    let program = lines.iter().map(|s| s.to_string()).collect::<Vec<_>>();
    let mut engine = bums::engine::ExecutionEngine::new(program);
    engine.add_abstract_from(1, "buf".to_string());
    engine.add_region(
        bums::common::RegionType::READ,
        "buf".to_string(),
        bums::common::AbstractExpression::Immediate(8),
    );
    engine.start("start".to_string()).map_err(|e| e.to_string())
}

#[test]
fn a_path_that_runs_past_the_end_of_the_code_is_rejected() {
    for lines in [
        &["start:", "ldr x0,[x1]"][..],
        &["start:", "cbz x0,end", "ret", "end:"][..],
    ] {
        let outcome = outcome_of(lines);
        assert!(
            outcome
                .as_ref()
                .is_err_and(|e| e.contains("runs past the end of the code")),
            "{lines:?}: {outcome:?}"
        );
    }
    assert_eq!(outcome_of(&["start:", "ldr x0,[x1]", "ret"]), Ok(()));
}
