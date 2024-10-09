use std::collections::HashSet;
use std::fmt::Display;
use std::fs;
use std::path::PathBuf;
use std::str::FromStr;
use std::{env, fs::File, io::Write};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Arch {
    X86(ArchX86),
    Arm(ArchArm),
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ArchX86 {
    X86_32,
    X86_64,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ArchArm {
    Arm32,
    Arm64,
}

impl FromStr for Arch {
    type Err = String;

    fn from_str(arch: &str) -> Result<Self, Self::Err> {
        Ok(match arch {
            "x86" => Self::X86(ArchX86::X86_32),
            "x86_64" => Self::X86(ArchX86::X86_64),
            "arm" => Self::Arm(ArchArm::Arm32),
            "aarch64" => Self::Arm(ArchArm::Arm64),
            _ => return Err(format!("unexpected arch: {arch}")),
        })
    }
}

struct Define {
    name: &'static str,
    value: String,
}

impl Define {
    pub fn new(name: &'static str, value: impl Display) -> Self {
        Self {
            name,
            value: value.to_string(),
        }
    }

    pub fn bool(name: &'static str, value: bool) -> Self {
        Self::new(name, value as u8)
    }
}
// taken from rav1d https://github.com/memorysafety/rav1d/blob/main/build.rs
fn generate_config_file() {
    let out_dir = PathBuf::from(env::var("OUT_DIR").unwrap());
    let arch = env::var("CARGO_CFG_TARGET_ARCH").unwrap();
    let os = env::var("CARGO_CFG_TARGET_OS").unwrap();
    let vendor = env::var("CARGO_CFG_TARGET_VENDOR").unwrap();
    let features = env::var("CARGO_CFG_TARGET_FEATURE").unwrap();

    // Nothing to do on unknown architectures
    let Ok(arch) = arch.parse::<Arch>() else {
        return;
    };
    let os = os.as_str();
    let vendor = vendor.as_str();
    let features = features.split(',').collect::<HashSet<_>>();

    let mut defines = Vec::new();
    let mut define = |define: Define| {
        defines.push(define);
    };

    define(Define::bool("CONFIG_ASM", true));
    define(Define::bool("CONFIG_LOG", true)); // TODO(kkysen) should be configurable

    if vendor == "apple" || (os == "windows" && matches!(arch, Arch::X86(ArchX86::X86_32))) {
        define(Define::bool("PREFIX", true));
    }

    if matches!(arch, Arch::X86(..)) {
        define(Define::new("private_prefix", "dav1d"));
    }
    if matches!(arch, Arch::Arm(..)) {
        define(Define::new("PRIVATE_PREFIX", "dav1d_"));
    }

    if let Arch::X86(arch) = arch {
        define(Define::bool("ARCH_X86_32", arch == ArchX86::X86_32));
        define(Define::bool("ARCH_X86_64", arch == ArchX86::X86_64));
    }
    if let Arch::Arm(arch) = arch {
        define(Define::bool("ARCH_ARM", arch == ArchArm::Arm32));
        define(Define::bool("ARCH_AARCH64", arch == ArchArm::Arm64));

        if arch == ArchArm::Arm64 {
            // define(Define::bool(
            //     "HAVE_DOTPROD",
            //     cfg!(feature = "asm_arm64_dotprod"),
            // ));
            // define(Define::bool("HAVE_I8MM", cfg!(feature = "asm_arm64_i8mm")));
        }
    }

    if let Arch::X86(arch) = arch {
        let stack_alignment = if arch == ArchX86::X86_64 || os == "linux" || vendor == "apple" {
            16
        } else {
            4
        };
        define(Define::new("STACK_ALIGNMENT", stack_alignment));
    }

    if matches!(arch, Arch::X86(..)) {
        define(Define::bool("PIC", true));

        // Convert SSE asm into (128-bit) AVX when compiler flags are set to use AVX instructions.
        // Note that this checks compile-time CPU features, not runtime features,
        // but that does seem to be what `dav1d` does, too.
        define(Define::bool("FORCE_VEX_ENCODING", features.contains("avx")));
    }

    let use_nasm = match arch {
        Arch::X86(..) => true,
        Arch::Arm(..) => false,
    };

    let define_prefix = if use_nasm { "%" } else { " #" };

    let config_lines = defines
        .iter()
        .map(|Define { name, value }| format!("{define_prefix}define {name} {value}"))
        .collect::<Vec<_>>();

    let config_contents = config_lines.join("\n");
    let config_file_name = if use_nasm { "config.asm" } else { "config.h" };
    let path = out_dir.join(config_file_name);
    fs::write(path, &config_contents).unwrap();
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    generate_config_file();

    let mut build = cc::Build::new();

    // let mut os = match env::var("CARGO_CFG_TARGET_OS")?.as_str() {
    //     "windows" => "win",
    //     "linux" => "linux",
    //     "ios" => "ios",
    //     "macos" => "mac",
    //     s => panic!("Unsupported operating system {}", s),
    // };

    // let arch = env::var("CARGO_CFG_TARGET_ARCH")?;

    for entry in std::fs::read_dir("generated-asm/src/arm/64")? {
        match entry {
            Ok(entry) => {
                println!("cargo::rerun-if-changed={}", entry.path().display());
                let mut processed_path = std::env::var_os("OUT_DIR")
                    .map(std::path::PathBuf::from)
                    .ok_or(std::io::Error::last_os_error())?;
                processed_path.push(entry.file_name());
                File::create(processed_path.clone())?.write_all(
                    &cc::Build::new()
                        // TODO(alevy): remove this define once we can
                        // parse the OPENSSL_armcap_P extern variable
                        // in the SHA256 and other assembly
                        .define("__KERNEL__", "1")
                        .include("include")
                        .file(entry.path())
                        .expand(),
                )?;
                build.file(processed_path);
            }
            Err(e) => println!("cargo::warning:{}", e),
        }
    }

    build.include("include").compile("linkedasms");
    println!("cargo:rustc-link-lib=linkedasms");
    Ok(())
}