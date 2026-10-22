mod cargo;
mod discover;
mod run;

use std::path::PathBuf;
use std::process::ExitCode;

const USAGE: &str = "usage: bums-check <crate-dir> [options]

  --target TRIPLE          check the annotations active for TRIPLE (default: host)
  --features A,B           enable crate features (repeatable)
  --all-features           enable every crate feature
  --no-default-features    do not enable the default features
  --asm-dir DIR            read assembly from DIR instead of the build script's OUT_DIR
  --jobs N                 functions checked in parallel (default: cores / 2)
  --timeout SECS           wall clock per function (default 300)
  --mem-gb G               resident memory cap per function (default 4)
  --filter REGEX           only functions whose name matches REGEX
  --skip-file FILE         skip the function names listed in FILE (one per line, # comments)
  --out FILE               write a TSV: function, file, status, seconds, first error
  --log-dir DIR            keep one log per function (RUST_LOG applies)
  --list                   print the annotations that would be checked and exit";

fn main() -> ExitCode {
    let arguments: Vec<String> = std::env::args().skip(1).collect();
    if arguments.first().map(String::as_str) == Some("--one") {
        return run::one(&arguments[1..]);
    }
    match parse_options(arguments) {
        Ok(options) => match run::all(options) {
            Ok(code) => code,
            Err(error) => {
                eprintln!("bums-check: {error}");
                ExitCode::from(2)
            }
        },
        Err(error) => {
            eprintln!("bums-check: {error}\n\n{USAGE}");
            ExitCode::from(2)
        }
    }
}

pub struct Options {
    pub crate_dir: PathBuf,
    pub target: Option<String>,
    pub features: cargo::FeatureRequest,
    pub asm_dir: Option<PathBuf>,
    pub jobs: usize,
    pub timeout_seconds: u64,
    pub mem_gb: f64,
    pub filter: Option<regex::Regex>,
    pub skip_file: Option<PathBuf>,
    pub out: Option<PathBuf>,
    pub log_dir: Option<PathBuf>,
    pub list: bool,
}

fn parse_options(arguments: Vec<String>) -> Result<Options, String> {
    let cores = std::thread::available_parallelism().map_or(2, |n| n.get());
    let mut crate_dir = None;
    let mut options = Options {
        crate_dir: PathBuf::new(),
        target: None,
        features: cargo::FeatureRequest {
            features: Vec::new(),
            all_features: false,
            no_default_features: false,
        },
        asm_dir: None,
        jobs: (cores / 2).max(1),
        timeout_seconds: 300,
        mem_gb: 4.0,
        filter: None,
        skip_file: None,
        out: None,
        log_dir: None,
        list: false,
    };
    let mut arguments = arguments.into_iter();
    while let Some(argument) = arguments.next() {
        let mut value = || {
            arguments
                .next()
                .ok_or_else(|| format!("{argument} needs a value"))
        };
        match argument.as_str() {
            "-h" | "--help" => return Err("help".to_string()),
            "--target" => options.target = Some(value()?),
            "--features" => options.features.features.extend(
                value()?
                    .split([',', ' '])
                    .filter(|feature| !feature.is_empty())
                    .map(str::to_string),
            ),
            "--all-features" => options.features.all_features = true,
            "--no-default-features" => options.features.no_default_features = true,
            "--asm-dir" => options.asm_dir = Some(PathBuf::from(value()?)),
            "--jobs" | "-j" => {
                options.jobs = value()?
                    .parse()
                    .map_err(|_| "--jobs needs a number".to_string())?
            }
            "--timeout" => {
                options.timeout_seconds = value()?
                    .parse()
                    .map_err(|_| "--timeout needs seconds".to_string())?
            }
            "--mem-gb" => {
                options.mem_gb = value()?
                    .parse()
                    .map_err(|_| "--mem-gb needs a number".to_string())?
            }
            "--filter" => {
                options.filter = Some(
                    regex::Regex::new(&value()?).map_err(|error| format!("--filter: {error}"))?,
                )
            }
            "--skip-file" => options.skip_file = Some(PathBuf::from(value()?)),
            "--out" => options.out = Some(PathBuf::from(value()?)),
            "--log-dir" => options.log_dir = Some(PathBuf::from(value()?)),
            "--list" => options.list = true,
            flag if flag.starts_with('-') => return Err(format!("unknown option {flag}")),
            directory => {
                if crate_dir.replace(PathBuf::from(directory)).is_some() {
                    return Err("only one crate directory".to_string());
                }
            }
        }
    }
    options.crate_dir = crate_dir.ok_or("missing crate directory")?;
    options.jobs = options.jobs.max(1);
    Ok(options)
}
