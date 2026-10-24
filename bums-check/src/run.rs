use crate::Options;
use crate::cargo;
use crate::discover::{self, CfgContext, Found};
use std::collections::{BTreeMap, BTreeSet};
use std::fs::File;
use std::io::{Read, Seek, SeekFrom, Write};
use std::path::{Path, PathBuf};
use std::process::{Child, Command, ExitCode, Stdio};
use std::time::{Duration, Instant};

const RESULT_MARKER: &str = "bums-check-result";
const TARGET_VENDOR_VARIABLE: &str = "BUMS_CHECK_TARGET_VENDOR";

#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum Status {
    Verified,
    Fail,
    Timeout,
    Memcap,
    Error,
}

impl Status {
    fn name(self) -> &'static str {
        match self {
            Status::Verified => "verified",
            Status::Fail => "FAIL",
            Status::Timeout => "TIMEOUT",
            Status::Memcap => "MEMCAP",
            Status::Error => "ERROR",
        }
    }

    fn from_name(name: &str) -> Option<Status> {
        [Status::Verified, Status::Fail, Status::Error]
            .into_iter()
            .find(|status| status.name() == name)
    }
}

fn single_line(text: &str) -> String {
    text.lines()
        .map(str::trim)
        .find(|line| !line.is_empty())
        .unwrap_or_default()
        .replace('\t', " ")
}

pub fn one(arguments: &[String]) -> ExitCode {
    let [_, asm_file, attr, item] = arguments else {
        eprintln!("bums-check --one <id> <asm-file> <attribute> <item>");
        return ExitCode::from(2);
    };
    let (asm_file, attr, item) = (PathBuf::from(asm_file), attr.clone(), item.clone());
    let _ = env_logger::try_init();
    let evaluation = std::thread::Builder::new()
        .stack_size(1 << 30)
        .spawn(move || evaluate(&asm_file, &attr, &item))
        .expect("spawn the checking thread")
        .join();
    let (status, message) = match evaluation {
        Ok(outcome) => outcome,
        Err(panic) => {
            let message = panic
                .downcast_ref::<String>()
                .cloned()
                .or_else(|| panic.downcast_ref::<&str>().map(|text| text.to_string()))
                .unwrap_or_default();
            (Status::Error, format!("panicked: {message}"))
        }
    };
    println!(
        "{RESULT_MARKER}\t{}\t{}",
        status.name(),
        single_line(&message)
    );
    ExitCode::SUCCESS
}

fn evaluate(asm_file: &Path, attr: &str, item: &str) -> (Status, String) {
    let tokens = |text: &str| text.parse::<proc_macro2::TokenStream>();
    let (Ok(attr), Ok(item)) = (tokens(attr), tokens(item)) else {
        return (Status::Error, "cannot tokenize the annotation".to_string());
    };
    let annotation = match bums_annotations::parse_annotation(attr, item) {
        Ok(annotation) => annotation,
        Err(error) => return (Status::Error, error.to_string()),
    };
    if !annotation.diagnostics.is_empty() {
        return (Status::Error, annotation.diagnostics.join("; "));
    }
    let target_vendor = std::env::var(TARGET_VENDOR_VARIABLE).unwrap_or_default();
    if let Some(unsupported) = annotation.unsupported_on(&target_vendor) {
        return (Status::Error, unsupported);
    }
    let program = match bums_annotations::read_program(asm_file) {
        Ok(program) => program,
        Err(error) => return (Status::Error, format!("{}: {error}", asm_file.display())),
    };
    let verdict = match annotation.check(&program) {
        Ok(verdict) => verdict,
        Err(error) => return (Status::Error, error),
    };
    for finding in &verdict.findings {
        eprintln!("bums finding in {}: {finding}", annotation.label);
    }
    if !verdict.diagnostics.is_empty() {
        return (Status::Error, verdict.diagnostics.join("; "));
    }
    if !verdict.failures.is_empty() {
        return (Status::Fail, verdict.failures.join("; "));
    }
    (Status::Verified, String::new())
}

fn host_triple() -> Result<String, String> {
    let output = Command::new("rustc")
        .arg("-vV")
        .output()
        .map_err(|error| format!("rustc -vV: {error}"))?;
    String::from_utf8_lossy(&output.stdout)
        .lines()
        .find_map(|line| line.strip_prefix("host: ").map(str::to_string))
        .ok_or_else(|| "rustc -vV reports no host".to_string())
}

fn skipped_names(path: &Path) -> Result<BTreeSet<String>, String> {
    let text =
        std::fs::read_to_string(path).map_err(|error| format!("{}: {error}", path.display()))?;
    Ok(text
        .lines()
        .map(|line| line.split('#').next().unwrap_or_default().trim())
        .filter(|line| !line.is_empty())
        .map(|line| line.split_whitespace().next().unwrap_or(line).to_string())
        .collect())
}

struct Job {
    found: Found,
    file: String,
    log: PathBuf,
}

struct Running {
    job: usize,
    child: Child,
    started: Instant,
    peak_kb: u64,
}

struct Outcome {
    status: Status,
    seconds: f64,
    message: String,
}

fn resident_kb(pids: &[u32]) -> BTreeMap<u32, u64> {
    if pids.is_empty() {
        return BTreeMap::new();
    }
    let list: Vec<String> = pids.iter().map(u32::to_string).collect();
    let Ok(output) = Command::new("ps")
        .args(["-o", "pid=,rss=", "-p", &list.join(",")])
        .output()
    else {
        return BTreeMap::new();
    };
    String::from_utf8_lossy(&output.stdout)
        .lines()
        .filter_map(|line| {
            let mut fields = line.split_whitespace();
            Some((fields.next()?.parse().ok()?, fields.next()?.parse().ok()?))
        })
        .collect()
}

fn log_tail(log: &Path) -> String {
    let Ok(mut file) = File::open(log) else {
        return String::new();
    };
    let length = file.metadata().map_or(0, |metadata| metadata.len());
    let _ = file.seek(SeekFrom::Start(length.saturating_sub(64 * 1024)));
    let mut tail = Vec::new();
    let _ = file.read_to_end(&mut tail);
    String::from_utf8_lossy(&tail).into_owned()
}

fn reported_outcome(log: &Path) -> Option<(Status, String)> {
    let tail = log_tail(log);
    let line = tail
        .lines()
        .rev()
        .find(|line| line.starts_with(RESULT_MARKER))?;
    let mut fields = line.splitn(3, '\t').skip(1);
    let status = Status::from_name(fields.next()?)?;
    Some((status, fields.next().unwrap_or_default().to_string()))
}

fn last_log_line(log: &Path) -> String {
    let tail = log_tail(log);
    let panic_message = tail
        .lines()
        .skip_while(|line| !line.contains("panicked at"))
        .nth(1);
    panic_message
        .or_else(|| tail.lines().rev().find(|line| !line.trim().is_empty()))
        .map(single_line)
        .unwrap_or_default()
}

fn spawn(job: &Job, asm_dir: &Path, target_vendor: &str) -> Result<Child, String> {
    let log = File::create(&job.log).map_err(|error| format!("{}: {error}", job.log.display()))?;
    let log_for_stderr = log
        .try_clone()
        .map_err(|error| format!("{}: {error}", job.log.display()))?;
    let executable =
        std::env::current_exe().map_err(|error| format!("cannot find bums-check: {error}"))?;
    Command::new(executable)
        .arg("--one")
        .arg(&job.found.function)
        .arg(asm_dir.join(&job.found.asm_file))
        .arg(job.found.attr.to_string())
        .arg(job.found.item.to_string())
        .env(TARGET_VENDOR_VARIABLE, target_vendor)
        .stdin(Stdio::null())
        .stdout(log)
        .stderr(log_for_stderr)
        .spawn()
        .map_err(|error| format!("spawn {}: {error}", job.found.function))
}

fn log_name(function: &str, taken: &mut BTreeSet<String>) -> String {
    let mut name = format!("{function}.log");
    let mut copy = 1;
    while !taken.insert(name.clone()) {
        copy += 1;
        name = format!("{function}-{copy}.log");
    }
    name
}

pub fn all(options: Options) -> Result<ExitCode, String> {
    let started = Instant::now();
    let package = cargo::package(&options.crate_dir)?;
    let target = match &options.target {
        Some(target) => target.clone(),
        None => host_triple()?,
    };
    let features = package.enabled_features(&options.features);
    let cfg = CfgContext::for_target(&target, features.clone());
    let crate_dir = package.manifest.parent().unwrap().to_path_buf();
    let mut found = discover::discover(&crate_dir, &cfg)?;
    let discovered = found.len();
    if let Some(filter) = &options.filter {
        found.retain(|annotation| filter.is_match(&annotation.function));
    }
    let skipped = match &options.skip_file {
        Some(path) => skipped_names(path)?,
        None => BTreeSet::new(),
    };
    let before_skip = found.len();
    found.retain(|annotation| !skipped.contains(&annotation.function));
    let skipped_count = before_skip - found.len();

    let relative = |path: &Path| {
        path.strip_prefix(&crate_dir)
            .unwrap_or(path)
            .display()
            .to_string()
    };
    if options.list {
        for annotation in &found {
            println!(
                "{}\t{}\t{}",
                annotation.function,
                relative(&annotation.file),
                annotation.asm_file
            );
        }
        return Ok(ExitCode::SUCCESS);
    }

    let features_shown: Vec<&str> = features.iter().map(String::as_str).collect();
    println!(
        "bums-check: {} for {target} [features: {}]: {discovered} annotations, {} to check, {skipped_count} skipped",
        package.name,
        features_shown.join(","),
        found.len()
    );

    let asm_dir = match &options.asm_dir {
        Some(directory) => directory.clone(),
        None => package.build_script_out_dir(options.target.as_deref(), &options.features)?,
    };
    println!("bums-check: assembly from {}", asm_dir.display());

    let (log_dir, temporary_logs) = match &options.log_dir {
        Some(directory) => (directory.clone(), false),
        None => (
            std::env::temp_dir().join(format!("bums-check-{}", std::process::id())),
            true,
        ),
    };
    std::fs::create_dir_all(&log_dir).map_err(|error| format!("{}: {error}", log_dir.display()))?;
    let mut taken = BTreeSet::new();
    let jobs: Vec<Job> = found
        .into_iter()
        .map(|found| Job {
            file: relative(&found.file),
            log: log_dir.join(log_name(&found.function, &mut taken)),
            found,
        })
        .collect();

    let mut out = match &options.out {
        Some(path) => {
            Some(File::create(path).map_err(|error| format!("{}: {error}", path.display()))?)
        }
        None => None,
    };

    let timeout = Duration::from_secs(options.timeout_seconds);
    let cap_kb = (options.mem_gb * 1024.0 * 1024.0) as u64;
    let mut outcomes: Vec<Option<Outcome>> = jobs.iter().map(|_| None).collect();
    let mut next = 0;
    let mut running: Vec<Running> = Vec::new();
    let mut finished = 0;
    let mut last_poll = Instant::now() - Duration::from_secs(1);
    while finished < jobs.len() {
        while running.len() < options.jobs && next < jobs.len() {
            match spawn(&jobs[next], &asm_dir, &cfg.target_vendor) {
                Ok(child) => running.push(Running {
                    job: next,
                    child,
                    started: Instant::now(),
                    peak_kb: 0,
                }),
                Err(error) => {
                    outcomes[next] = Some(Outcome {
                        status: Status::Error,
                        seconds: 0.0,
                        message: error,
                    });
                    finished += 1;
                    report(
                        &jobs[next],
                        outcomes[next].as_ref().unwrap(),
                        finished,
                        jobs.len(),
                        &mut out,
                    );
                }
            }
            next += 1;
        }

        let resident = if last_poll.elapsed() >= Duration::from_millis(500) {
            last_poll = Instant::now();
            let pids: Vec<u32> = running.iter().map(|run| run.child.id()).collect();
            resident_kb(&pids)
        } else {
            BTreeMap::new()
        };

        let mut still_running = Vec::new();
        for mut run in running.drain(..) {
            let job = &jobs[run.job];
            let elapsed = run.started.elapsed();
            if let Some(kb) = resident.get(&run.child.id()) {
                run.peak_kb = run.peak_kb.max(*kb);
            }
            let outcome = match run.child.try_wait() {
                Ok(Some(exit)) => Some(match reported_outcome(&job.log) {
                    Some((status, message)) => (status, message),
                    None => (
                        Status::Error,
                        format!("{exit}: {}", last_log_line(&job.log)),
                    ),
                }),
                Ok(None) if elapsed > timeout => {
                    let _ = run.child.kill();
                    let _ = run.child.wait();
                    Some((
                        Status::Timeout,
                        format!("killed after {}s", options.timeout_seconds),
                    ))
                }
                Ok(None) if run.peak_kb > cap_kb => {
                    let _ = run.child.kill();
                    let _ = run.child.wait();
                    Some((
                        Status::Memcap,
                        format!(
                            "killed at {:.1} GB resident",
                            run.peak_kb as f64 / 1048576.0
                        ),
                    ))
                }
                Ok(None) => None,
                Err(error) => Some((Status::Error, error.to_string())),
            };
            match outcome {
                Some((status, message)) => {
                    let outcome = Outcome {
                        status,
                        seconds: elapsed.as_secs_f64(),
                        message,
                    };
                    finished += 1;
                    report(job, &outcome, finished, jobs.len(), &mut out);
                    outcomes[run.job] = Some(outcome);
                }
                None => still_running.push(run),
            }
        }
        running = still_running;
        if finished < jobs.len() {
            std::thread::sleep(Duration::from_millis(100));
        }
    }

    if temporary_logs {
        let _ = std::fs::remove_dir_all(&log_dir);
    }

    let mut counts: BTreeMap<Status, usize> = BTreeMap::new();
    let mut checking_seconds = 0.0;
    for outcome in outcomes.iter().flatten() {
        *counts.entry(outcome.status).or_default() += 1;
        checking_seconds += outcome.seconds;
    }
    let tally: Vec<String> = counts
        .iter()
        .map(|(status, count)| format!("{count} {}", status.name()))
        .collect();
    println!(
        "bums-check: {} functions: {} ({skipped_count} skipped); {:.0}s wall, {:.0}s of checking",
        jobs.len(),
        if tally.is_empty() {
            "none".to_string()
        } else {
            tally.join(", ")
        },
        started.elapsed().as_secs_f64(),
        checking_seconds
    );
    let failed = outcomes
        .iter()
        .flatten()
        .any(|outcome| matches!(outcome.status, Status::Fail | Status::Error));
    Ok(if failed {
        ExitCode::FAILURE
    } else {
        ExitCode::SUCCESS
    })
}

fn report(job: &Job, outcome: &Outcome, finished: usize, total: usize, out: &mut Option<File>) {
    let line = format!(
        "{}\t{}\t{}\t{:.1}\t{}",
        job.found.function,
        job.file,
        outcome.status.name(),
        outcome.seconds,
        outcome.message
    );
    println!("[{finished}/{total}] {}", line.replace('\t', "  "));
    if let Some(file) = out {
        let _ = writeln!(file, "{line}");
    }
}
