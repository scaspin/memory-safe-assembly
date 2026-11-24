use std::{env, fs};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let arch = env::var("CARGO_CFG_TARGET_ARCH")?;
    let out_dir = env::var("OUT_DIR")?;
    let dir = format!("asm/{arch}");
    let Ok(entries) = fs::read_dir(&dir) else {
        return Ok(());
    };
    for entry in entries.flatten() {
        println!("cargo::rerun-if-changed={}", entry.path().display());
        fs::copy(entry.path(), format!("{out_dir}/{}", entry.file_name().to_string_lossy()))?;
    }
    Ok(())
}
