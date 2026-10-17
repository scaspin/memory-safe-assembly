use std::{
    env, fs,
    path::{Path, PathBuf},
    process::Command,
};

const SKIP: &[&str] = &["asm.S", "neon.S", "inter_sme2.S"];

fn sources(dir: &Path, found: &mut Vec<PathBuf>) -> std::io::Result<()> {
    for entry in fs::read_dir(dir)? {
        let path = entry?.path();
        if path.is_dir() {
            sources(&path, found)?;
        } else if path.extension().is_some_and(|e| e == "S")
            && !SKIP.contains(&path.file_name().unwrap().to_str().unwrap())
        {
            found.push(path);
        }
    }
    Ok(())
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("cargo::rerun-if-changed=disassemble-elf.py");
    println!("cargo::rerun-if-changed=include");
    println!("cargo::rerun-if-changed=analysis-tables");

    let out_dir = PathBuf::from(env::var("OUT_DIR")?);
    let elf_dir = out_dir.join("elf");
    fs::create_dir_all(&elf_dir)?;

    let mut files = Vec::new();
    sources(Path::new("include"), &mut files)?;
    sources(Path::new("analysis-tables"), &mut files)?;
    files.sort();

    let clang = cc::Build::new().get_compiler().path().to_path_buf();
    for file in &files {
        let object = elf_dir.join(file.with_extension("o").file_name().unwrap());
        let status = Command::new(&clang)
            .args(["--target=aarch64-unknown-linux-gnu", "-c", "-Iinclude"])
            .arg(format!("-I{}", file.parent().unwrap().display()))
            .arg("-o")
            .arg(&object)
            .arg(file)
            .status()?;
        if !status.success() {
            panic!("assembling {} failed", file.display());
        }
    }

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
    Ok(())
}
