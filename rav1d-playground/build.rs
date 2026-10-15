use std::env;
use std::fs;
use std::path::Path;
use std::process::Command;
use std::{fs::File, io::Write};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    match env::var("CARGO_CFG_TARGET_ARCH")?.as_str() {
        "x86_64" => x86_64(),
        _ => aarch64(),
    }
}

const X86_SOURCES: [(&str, &str, &[&str]); 1] = [(
    "include/src/x86/pal.asm",
    "pal-x86_64.S",
    &["dav1d_pal_idx_finish_ssse3", "dav1d_pal_idx_finish_avx2"],
)];

fn x86_64() -> Result<(), Box<dyn std::error::Error>> {
    let out_dir = Path::new(&env::var("OUT_DIR")?).to_path_buf();
    let apple = env::var("CARGO_CFG_TARGET_VENDOR")? == "apple";
    println!("cargo:rerun-if-changed=x86/extract-asm.py");

    let config = |dir: &Path, prefix: bool| -> std::io::Result<()> {
        fs::create_dir_all(dir)?;
        let mut defines = vec![
            "%define CONFIG_ASM 1",
            "%define CONFIG_LOG 1",
            "%define private_prefix dav1d",
            "%define ARCH_X86_32 0",
            "%define ARCH_X86_64 1",
            "%define STACK_ALIGNMENT 16",
            "%define PIC 1",
            "%define FORCE_VEX_ENCODING 0",
        ];
        if prefix {
            defines.push("%define PREFIX 1");
        }
        fs::write(dir.join("config.asm"), defines.join("\n") + "\n")
    };
    let link_config = out_dir.join("link");
    let extract_config = out_dir.join("extract");
    config(&link_config, apple)?;
    config(&extract_config, false)?;

    let mut objects = Vec::new();
    for (source, extracted, functions) in X86_SOURCES {
        println!("cargo:rerun-if-changed={source}");
        let object = out_dir.join(Path::new(source).with_extension("o").file_name().unwrap());
        let status = Command::new("nasm")
            .args(["-f", if apple { "macho64" } else { "elf64" }])
            .arg(format!("-I{}/", link_config.display()))
            .arg("-Iinclude/src/")
            .arg(source)
            .arg("-o")
            .arg(&object)
            .status()
            .map_err(|e| format!("nasm is needed to build dav1d's x86 assembly: {e}"))?;
        if !status.success() {
            return Err(format!("nasm failed on {source}").into());
        }
        objects.push(object);

        let status = Command::new("python3")
            .arg("x86/extract-asm.py")
            .arg(source)
            .arg(&extract_config)
            .arg("include/src")
            .arg(out_dir.join(extracted))
            .args(functions)
            .status()?;
        if !status.success() {
            return Err(format!("extract-asm.py failed on {source}").into());
        }
    }

    let archive = out_dir.join("librav1dasm.a");
    let _ = fs::remove_file(&archive);
    let status = Command::new("ar")
        .arg("crs")
        .arg(&archive)
        .args(&objects)
        .status()?;
    if !status.success() {
        return Err("ar failed".into());
    }
    println!("cargo:rustc-link-search=native={}", out_dir.display());
    println!("cargo:rustc-link-lib=static=rav1dasm");
    Ok(())
}

fn aarch64() -> Result<(), Box<dyn std::error::Error>> {
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
