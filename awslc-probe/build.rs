use std::{env, fs::File, io::Write};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let mut os = match env::var("CARGO_CFG_TARGET_OS")?.as_str() {
        "windows" => "win",
        "linux" => "linux",
        "ios" => "ios",
        "macos" => "mac",
        s => panic!("Unsupported operating system {}", s),
    };

    let arch = env::var("CARGO_CFG_TARGET_ARCH")?;

    if os == "mac" && arch == "aarch64" {
        os = "ios"
    }

    let out_dir = std::env::var_os("OUT_DIR")
        .map(std::path::PathBuf::from)
        .ok_or(std::io::Error::last_os_error())?;

    let root = format!("../crypto-playground/generated-asm/{}-{}/crypto", os, arch);
    let mut seen = std::collections::HashSet::new();
    for subdir in ["fipsmodule", "chacha", "cipher_extra"] {
        let dir = format!("{}/{}", root, subdir);
        let Ok(entries) = std::fs::read_dir(&dir) else {
            continue;
        };
        for entry in entries.flatten() {
            println!("cargo::rerun-if-changed={}", entry.path().display());
            if !seen.insert(entry.file_name()) {
                continue;
            }
            let mut processed_path = out_dir.clone();
            processed_path.push(entry.file_name());
            File::create(processed_path)?.write_all(
                &cc::Build::new()
                    .define("__KERNEL__", "1")
                    .include("../crypto-playground/include")
                    .file(entry.path())
                    .expand(),
            )?;
        }
    }
    Ok(())
}
