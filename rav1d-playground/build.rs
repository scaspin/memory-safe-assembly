use std::env;
use std::fs;
use std::path::Path;
use std::process::Command;
use std::{fs::File, io::Write};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("cargo::rerun-if-changed=disassemble-elf.py");
    println!("cargo::rerun-if-changed=include");

    let mut build = cc::Build::new();

    for entry in std::fs::read_dir("include/src/arm/64")? {
        match entry {
            Ok(entry) => {
                println!("cargo::rerun-if-changed={}", entry.path().display());
                let mut processed_path = std::env::var_os("OUT_DIR")
                    .map(std::path::PathBuf::from)
                    .ok_or(std::io::Error::last_os_error())?;
                processed_path.push(entry.file_name());
                File::create(processed_path.clone())?.write_all(
                    &cc::Build::new()
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

    let out_dir = env::var("OUT_DIR").unwrap();

    let elf_dir = Path::new(&out_dir).join("elf");
    fs::create_dir_all(&elf_dir)?;
    let clang = cc::Build::new().get_compiler().path().to_path_buf();
    let mut elf = cc::Build::new();
    elf.compiler(clang)
        .target("aarch64-unknown-linux-gnu")
        .define("__KERNEL__", "1")
        .include("include")
        .out_dir(&elf_dir)
        .cargo_metadata(false);
    for entry in fs::read_dir("include/src/arm/64")? {
        elf.file(entry?.path());
    }
    for entry in fs::read_dir("analysis-tables")? {
        let path = entry?.path();
        println!("cargo::rerun-if-changed={}", path.display());
        elf.file(path);
    }
    elf.compile_intermediates();

    let disassembly = Command::new("python3")
        .arg("disassemble-elf.py")
        .arg(&elf_dir)
        .arg(&out_dir)
        .output()?;
    if !disassembly.status.success() {
        panic!(
            "disassemble-elf.py failed:\n{}",
            String::from_utf8_lossy(&disassembly.stderr)
        );
    }

    let src_file = "src/edited-ipred.S";
    let dest_file = Path::new(&out_dir).join("edited-ipred.S");
    println!("des {:?}", dest_file);
    fs::copy(src_file, &dest_file).expect("Failed to copy file");
    println!("cargo:rerun-if-changed={}", src_file);

    Ok(())
}
