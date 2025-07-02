use std::env;
use std::fs;
use std::path::Path;
use std::process::Command;
use std::{fs::File, io::Write};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // println!("cargo::rerun-if-changed=disassemble-dir.sh");
    // println!("cargo::rerun-if-changed=clean-objdump.py");

    let mut build = cc::Build::new();

    for entry in std::fs::read_dir("include/src/arm/64")? {
        match entry {
            Ok(entry) => {
                // println!("cargo::rerun-if-changed={}", entry.path().display());
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

    // convert the built object files back to asm
    let mut command = Command::new("bash");
    command.arg("disassemble-dir.sh");
    command.arg(
        std::env::var_os("OUT_DIR")
            .map(std::path::PathBuf::from)
            .ok_or(std::io::Error::last_os_error())?,
    );
    command.arg(
        std::env::var_os("OUT_DIR")
            .map(std::path::PathBuf::from)
            .ok_or(std::io::Error::last_os_error())?,
    );

    command.output().expect("Failed to execute command");

    let out_dir = env::var("OUT_DIR").unwrap();

    // copy edited files
    let src_file = "src/edited-ipred.S";
    let dest_file = Path::new(&out_dir).join("edited-ipred.S");
    println!("des {:?}", dest_file);
    fs::copy(src_file, &dest_file).expect("Failed to copy file");
    println!("cargo:rerun-if-changed={}", src_file);

    Ok(())
}
