use std::{env, fs::File, io::Write};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("cargo:rerun-if-changed=assembly/aws-fips");
    let mut build = cc::Build::new();

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

    let mut seen = std::collections::HashSet::new();
    for subdir in ["fipsmodule", "chacha", "cipher_extra"] {
        let dir = format!("generated-asm/{}-{}/crypto/{}", os, arch, subdir);
        let Ok(entries) = std::fs::read_dir(&dir) else {
            continue;
        };
        for entry in entries {
            match entry {
                Ok(entry) => {
                    println!("cargo::rerun-if-changed={}", entry.path().display());
                    if !seen.insert(entry.file_name()) {
                        continue;
                    }
                    let mut processed_path = std::env::var_os("OUT_DIR")
                        .map(std::path::PathBuf::from)
                        .ok_or(std::io::Error::last_os_error())?;
                    processed_path.push(entry.file_name());
                    File::create(processed_path.clone())?.write_all(
                        &cc::Build::new()
                            .include("include")
                            .file(entry.path())
                            .expand(),
                    )?;
                    build.file(processed_path);
                }
                Err(e) => println!("cargo::warning:{}", e),
            }
        }
    }

    if let Ok(entries) = std::fs::read_dir(format!("native-asm/{}", arch)) {
        for entry in entries.flatten() {
            println!("cargo::rerun-if-changed={}", entry.path().display());
            if !seen.insert(entry.file_name()) {
                continue;
            }
            let mut processed_path = std::env::var_os("OUT_DIR")
                .map(std::path::PathBuf::from)
                .ok_or(std::io::Error::last_os_error())?;
            processed_path.push(entry.file_name());
            File::create(processed_path.clone())?.write_all(
                &cc::Build::new()
                    .include("include")
                    .include("native-asm/include")
                    .define("S2N_BN_HIDE_SYMBOLS", "1")
                    .file(entry.path())
                    .expand(),
            )?;
            build.file(processed_path);
        }
    }

    build.include("include").compile("linkedasms");
    println!("cargo:rustc-link-lib=linkedasms");
    Ok(())
}
