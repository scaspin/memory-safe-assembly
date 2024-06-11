use std::{env, fs::File, io::Write};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let mut build = cc::Build::new();

    let mut os = match env::var("CARGO_CFG_TARGET_OS")?.as_str() {
        "windows" => "win",
        "linux" => "linux",
        "ios" => "ios",
        "macos" => "mac",
        s => panic!("Unsupported operating system {}", s),
    };

    let arch = env::var("CARGO_CFG_TARGET_ARCH")?;

    // (scaspin) special case to run on m1 mac, unsupported by aws-lc-rs
    if os == "mac" && arch == "aarch64" {
        os = "ios"
    }

    for entry in std::fs::read_dir(format!("generated-asm/{}-{}/crypto/fipsmodule", os, arch))? {
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
