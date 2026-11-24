use std::{env, fs::File, io::Write, path::PathBuf};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let arch = env::var("CARGO_CFG_TARGET_ARCH")?;
    let out_dir = PathBuf::from(env::var("OUT_DIR")?);
    let mut build = cc::Build::new();
    let mut any = false;
    let Ok(areas) = std::fs::read_dir(format!("asm/{arch}")) else {
        return Ok(());
    };
    for area in areas.flatten() {
        for entry in std::fs::read_dir(area.path())?.flatten() {
            println!("cargo::rerun-if-changed={}", entry.path().display());
            let processed = out_dir.join(entry.file_name());
            File::create(&processed)?.write_all(
                &cc::Build::new()
                    .include("asm/include")
                    .include("../crypto-playground/include")
                    .define("S2N_BN_HIDE_SYMBOLS", "1")
                    .file(entry.path())
                    .expand(),
            )?;
            build.file(processed);
            any = true;
        }
    }
    if any {
        build.compile("bignumasms");
        println!("cargo:rustc-link-lib=bignumasms");
    }
    Ok(())
}
