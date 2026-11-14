use std::collections::{BTreeMap, BTreeSet};
use std::env;
use std::fs;
use std::path::{Path, PathBuf};

use proc_macro2::TokenStream;
use quote::{format_ident, quote};
use syn::punctuated::Punctuated;
use syn::visit_mut::{self, VisitMut};
use syn::{Block, Expr, FnArg, Item, ItemFn, ItemStruct, Pat, Stmt, Token, Type, parse_quote};

struct Suite {
    name: &'static str,
    crate_dir: &'static str,
    domain: &'static str,
}

const SUITES: &[Suite] = &[
    Suite { name: "crypto", crate_dir: "crypto-playground", domain: "crypto" },
    Suite { name: "bignum", crate_dir: "bignum-playground", domain: "crypto" },
    Suite { name: "graviola", crate_dir: "graviola-playground", domain: "crypto" },
    Suite { name: "corecrypto", crate_dir: "corecrypto-playground", domain: "crypto" },
    Suite { name: "compression", crate_dir: "compression-playground", domain: "compression" },
    Suite { name: "openblas", crate_dir: "openblas-playground", domain: "numeric" },
    Suite { name: "candle", crate_dir: "candle-playground", domain: "numeric" },
    Suite { name: "ffmpeg", crate_dir: "ffmpeg-playground", domain: "media" },
    Suite { name: "rav1d", crate_dir: "rav1d-playground", domain: "media" },
];

struct Found {
    attribute: String,
    item: String,
    file: PathBuf,
}

fn rust_sources(dir: &Path, out: &mut Vec<PathBuf>) {
    let Ok(entries) = fs::read_dir(dir) else { return };
    let mut paths: Vec<PathBuf> = entries.flatten().map(|e| e.path()).collect();
    paths.sort();
    for path in paths {
        if path.is_dir() {
            rust_sources(&path, out);
        } else if path.extension().is_some_and(|e| e == "rs") {
            out.push(path);
        }
    }
}

fn closing_paren(text: &str, open: usize) -> usize {
    let mut depth = 0i32;
    for (offset, c) in text[open..].char_indices() {
        match c {
            '(' | '[' | '{' => depth += 1,
            ')' | ']' | '}' => {
                depth -= 1;
                if depth == 0 {
                    return open + offset;
                }
            }
            _ => {}
        }
    }
    panic!("unbalanced annotation");
}

fn top_level_semicolon(text: &str) -> usize {
    let mut depth = 0i32;
    for (offset, c) in text.char_indices() {
        match c {
            '(' | '[' | '{' => depth += 1,
            ')' | ']' | '}' => depth -= 1,
            ';' if depth == 0 => return offset,
            _ => {}
        }
    }
    panic!("signature without a terminating semicolon");
}

fn excluded_for_aarch64(text: &str, attribute_start: usize, path: &Path) -> bool {
    let line_start = text[..attribute_start].rfind('\n').map_or(0, |i| i + 1);
    let prefix = &text[line_start..attribute_start];
    let names_other_arch = prefix.contains("target_arch") && !prefix.contains("\"aarch64\"");
    let x86_file = path.to_string_lossy().contains("x86");
    names_other_arch || x86_file
}

fn find_annotation(crate_dir: &Path, function: &str) -> Found {
    let mut sources = Vec::new();
    rust_sources(&crate_dir.join("src"), &mut sources);
    let mut matches = Vec::new();
    for path in sources {
        let text = fs::read_to_string(&path).unwrap();
        let mut from = 0;
        while let Some(at) = text[from..].find("check_mem_safe(") {
            let start = from + at;
            let open = start + "check_mem_safe".len();
            let close = closing_paren(&text, open);
            from = close;
            if excluded_for_aarch64(&text, start, &path) {
                continue;
            }
            let rest = &text[close..];
            let Some(fn_at) = rest.find("fn ") else { continue };
            let name: String = rest[fn_at + 3..]
                .trim_start()
                .chars()
                .take_while(|c| c.is_alphanumeric() || *c == '_')
                .collect();
            if name != function {
                continue;
            }
            let item_start = close + fn_at;
            let item_end = item_start + top_level_semicolon(&text[item_start..]) + 1;
            matches.push(Found {
                attribute: text[open + 1..close].to_string(),
                item: text[item_start..item_end].to_string(),
                file: path.clone(),
            });
        }
    }
    match matches.len() {
        1 => matches.pop().unwrap(),
        0 => panic!("no aarch64 annotation for {function} in {}", crate_dir.display()),
        n => panic!("{n} aarch64 annotations for {function} in {}", crate_dir.display()),
    }
}

fn counts(attribute: &TokenStream) -> (usize, usize) {
    let arguments: Punctuated<Expr, Token![,]> =
        syn::parse::Parser::parse2(Punctuated::parse_terminated, attribute.clone()).unwrap();
    let mut bindings = 0;
    let mut preconditions = 0;
    for argument in arguments.iter().skip(1) {
        match argument {
            Expr::Array(list) => preconditions += list.elems.len(),
            _ => bindings += 1,
        }
    }
    (bindings, preconditions)
}

fn is_assert(stmt: &Stmt) -> bool {
    let mac = match stmt {
        Stmt::Macro(m) => &m.mac,
        Stmt::Expr(Expr::Macro(m), _) => &m.mac,
        _ => return false,
    };
    mac.path.is_ident("assert")
}

fn mentions_scratch(stmt: &Stmt) -> bool {
    quote!(#stmt).to_string().contains("_scratch")
}

struct WithoutChecks {
    struct_arguments: BTreeMap<String, String>,
}

impl VisitMut for WithoutChecks {
    fn visit_block_mut(&mut self, block: &mut Block) {
        visit_mut::visit_block_mut(self, block);
        block.stmts.retain(|stmt| {
            !is_assert(stmt) && !mentions_scratch(stmt) && !matches!(stmt, Stmt::Item(Item::Struct(_)))
        });
    }

    fn visit_expr_mut(&mut self, expr: &mut Expr) {
        if let Expr::Reference(reference) = expr {
            let replacement = match &*reference.expr {
                Expr::Path(path) => path
                    .path
                    .get_ident()
                    .and_then(|i| i.to_string().strip_suffix("_scratch").map(str::to_string)),
                Expr::Struct(literal) => literal
                    .path
                    .get_ident()
                    .and_then(|i| self.struct_arguments.get(&i.to_string()).cloned()),
                _ => None,
            };
            if let Some(argument) = replacement {
                let argument = format_ident!("{argument}");
                *expr = parse_quote!(#argument);
                return;
            }
        }
        visit_mut::visit_expr_mut(self, expr);
    }
}

struct StubbedAssembly;

impl VisitMut for StubbedAssembly {
    fn visit_block_mut(&mut self, block: &mut Block) {
        visit_mut::visit_block_mut(self, block);
        let mut stubbed = Vec::new();
        for stmt in block.stmts.drain(..) {
            let Stmt::Item(Item::ForeignMod(foreign)) = stmt else {
                stubbed.push(stmt);
                continue;
            };
            for item in foreign.items {
                let syn::ForeignItem::Fn(declared) = item else { panic!("foreign item that is not a function") };
                let signature = declared.sig;
                let name = &signature.ident;
                let output = &signature.output;
                let types: Vec<_> = signature
                    .inputs
                    .iter()
                    .filter_map(|a| match a {
                        FnArg::Typed(t) => Some(t.ty.clone()),
                        _ => None,
                    })
                    .collect();
                let arguments: Vec<_> = (0..types.len()).map(|i| format_ident!("argument{i}")).collect();
                stubbed.push(parse_quote! {
                    #[inline(never)]
                    extern "C" fn #name(#(#arguments: #types),*) #output {
                        ::core::hint::black_box((#(#arguments,)*));
                        unsafe { ::core::mem::zeroed() }
                    }
                });
            }
        }
        block.stmts = stubbed;
    }
}

fn body_structs(function: &ItemFn) -> Vec<ItemStruct> {
    function
        .block
        .stmts
        .iter()
        .filter_map(|stmt| match stmt {
            Stmt::Item(Item::Struct(s)) => Some(s.clone()),
            _ => None,
        })
        .collect()
}

fn argument_name(arg: &FnArg) -> Option<String> {
    match arg {
        FnArg::Typed(typed) => match &*typed.pat {
            Pat::Ident(ident) => Some(ident.ident.to_string()),
            _ => None,
        },
        _ => None,
    }
}

fn wrappers(function: &str, found: &Found) -> (TokenStream, String, usize, usize, usize) {
    let attribute: TokenStream = found.attribute.parse().unwrap();
    let item: TokenStream = found.item.parse().unwrap();
    let annotation = bums_annotations::parse_annotation(attribute.clone(), item)
        .unwrap_or_else(|e| panic!("{function}: {e}"));
    if !annotation.diagnostics.is_empty() {
        panic!("{function}: {:?}", annotation.diagnostics);
    }
    let file: syn::File = syn::parse2(annotation.expansion.clone()).unwrap();
    let mut wrapper = None;
    let mut other_items = Vec::new();
    for item in file.items {
        match item {
            Item::Fn(f) if wrapper.is_none() => wrapper = Some(f),
            other => other_items.push(other),
        }
    }
    let wrapper = wrapper.expect("expansion has a wrapper function");
    let structs = body_structs(&wrapper);

    let mut annotated = wrapper.clone();
    annotated.sig.ident = format_ident!("annotated");
    annotated.vis = parse_quote!(pub);
    annotated.attrs.push(parse_quote!(#[inline(never)]));

    let struct_arguments: BTreeMap<String, String> = structs
        .iter()
        .map(|s| {
            let name = s.ident.to_string();
            (name.clone(), name.strip_suffix("_struct").unwrap().to_string())
        })
        .collect();
    let mut raw = wrapper.clone();
    raw.sig.ident = format_ident!("raw");
    raw.vis = parse_quote!(pub);
    raw.attrs.push(parse_quote!(#[inline(never)]));
    let mut converters = Vec::new();
    for input in raw.sig.inputs.iter_mut() {
        let Some(name) = argument_name(input) else { continue };
        let struct_name = format!("{name}_struct");
        if !struct_arguments.contains_key(&struct_name) {
            continue;
        }
        let FnArg::Typed(typed) = input else { unreachable!() };
        let Type::Reference(reference) = &mut *typed.ty else {
            panic!("{function}: struct argument {name} is not a reference")
        };
        let Type::Tuple(tuple) = (*reference.elem).clone() else {
            panic!("{function}: struct argument {name} is not a tuple")
        };
        let struct_ident = format_ident!("{struct_name}");
        reference.elem = Box::new(parse_quote!(#struct_ident));
        let declared = structs.iter().find(|s| s.ident == struct_ident).unwrap();
        let fields: Vec<_> = declared.fields.iter().map(|f| f.ident.clone().unwrap()).collect();
        let indices: Vec<syn::Index> = (0..fields.len()).map(syn::Index::from).collect();
        let converter = format_ident!("{name}_as_struct");
        converters.push(quote! {
            pub fn #converter(tuple: &#tuple) -> #struct_ident {
                #struct_ident { #(#fields: tuple.#indices),* }
            }
        });
    }
    WithoutChecks { struct_arguments: struct_arguments.clone() }.visit_item_fn_mut(&mut raw);
    if env::var_os("CARGO_FEATURE_ISOLATED").is_some() {
        StubbedAssembly.visit_item_fn_mut(&mut annotated);
        StubbedAssembly.visit_item_fn_mut(&mut raw);
    }

    let public_structs: Vec<ItemStruct> = structs
        .into_iter()
        .map(|mut s| {
            s.attrs.push(parse_quote!(#[derive(Clone, Copy)]));
            s.vis = parse_quote!(pub);
            for field in s.fields.iter_mut() {
                field.vis = parse_quote!(pub);
            }
            s
        })
        .collect();

    let (bindings, preconditions) = counts(&attribute);
    let module = format_ident!("{function}");
    let tokens = quote! {
        pub mod #module {
            #![allow(unused, non_camel_case_types, non_snake_case, clippy::all)]
            #(#public_structs)*
            #(#converters)*
            #annotated
            #raw
            #(#other_items)*
        }
    };
    (tokens, annotation.asm_file, bindings, preconditions, struct_arguments.len())
}

fn find_named(dir: &Path, name: &str, out: &mut Vec<PathBuf>) {
    let Ok(entries) = fs::read_dir(dir) else { return };
    for entry in entries.flatten() {
        let path = entry.path();
        if path.is_dir() {
            find_named(&path, name, out);
        } else if path.file_name().is_some_and(|n| n == name) {
            out.push(path);
        }
    }
}

fn unique_named(dirs: &[PathBuf], name: &str) -> PathBuf {
    let mut found = Vec::new();
    for dir in dirs {
        find_named(dir, name, &mut found);
    }
    found.sort();
    found.dedup();
    match found.len() {
        1 => found.pop().unwrap(),
        0 => panic!("no source named {name} under {dirs:?}"),
        _ => panic!("several sources named {name}: {found:?}"),
    }
}

fn mach_o_text(source: &str, functions: &BTreeSet<String>) -> String {
    let mut out = String::new();
    for line in source.lines() {
        let trimmed = line.trim();
        if trimmed.starts_with(".type") || trimmed.starts_with(".size") || trimmed.starts_with(".ident") {
            continue;
        }
        if trimmed.starts_with(".section") {
            if trimmed.contains(".rodata") || trimmed.contains(".data") {
                out.push_str("\t.section __TEXT,__const\n");
            } else if trimmed.contains(".text") {
                out.push_str("\t.text\n");
            }
            continue;
        }
        if let Some(label) = trimmed.strip_suffix(':')
            && functions.contains(label)
        {
            out.push_str(&format!("\t.globl _{label}\n\t.p2align 2\n_{label}:\n"));
        }
        let mut rewritten = line.to_string();
        while let Some(at) = rewritten.find(":lo12:") {
            let symbol_start = at + ":lo12:".len();
            let symbol_end = rewritten[symbol_start..]
                .find(|c: char| !(c.is_alphanumeric() || c == '_' || c == '.' || c == '$'))
                .map_or(rewritten.len(), |i| symbol_start + i);
            let symbol = rewritten[symbol_start..symbol_end].to_string();
            rewritten.replace_range(at..symbol_end, &format!("{symbol}@PAGEOFF"));
        }
        let opcode = trimmed.split_whitespace().next().unwrap_or("");
        if opcode == "adrp" && !rewritten.contains('@') {
            if let Some(comma) = rewritten.rfind(',') {
                let operand = rewritten[comma + 1..].trim().to_string();
                rewritten = format!("{}, {}@PAGE", &rewritten[..comma], operand);
            }
        }
        out.push_str(&rewritten);
        out.push('\n');
    }
    out
}

fn mach_o_zero_tables(source: &str) -> String {
    let mut out = String::from("\t.section __DATA,__const\n\t.p2align 4\n");
    for line in source.lines().map(str::trim) {
        if let Some(name) = line.strip_prefix(".globl").map(str::trim) {
            out.push_str(&format!("\t.globl _{name}\n\t.p2align 4\n_{name}:\n"));
        } else if line.starts_with(".zero") {
            out.push_str(&format!("\t{line}\n"));
        }
    }
    out
}

fn overridden_config(original: &Path, out_dir: &Path, name: &str, replacements: &[(&str, &str)]) -> PathBuf {
    let mut text = fs::read_to_string(original).unwrap();
    for (from, to) in replacements {
        assert!(text.contains(from), "{} lacks {from}", original.display());
        text = text.replace(from, to);
    }
    let dir = out_dir.join(name);
    fs::create_dir_all(&dir).unwrap();
    fs::write(dir.join("config.h"), text).unwrap();
    dir
}

fn main() {
    let manifest = PathBuf::from(env::var("CARGO_MANIFEST_DIR").unwrap());
    let root = manifest.join("../..").canonicalize().unwrap();
    let out_dir = PathBuf::from(env::var("OUT_DIR").unwrap());
    println!("cargo::rerun-if-changed=functions.txt");
    println!("cargo::rerun-if-changed=build.rs");

    let list = fs::read_to_string(manifest.join("functions.txt")).unwrap();
    let mut selected: Vec<(&Suite, String)> = Vec::new();
    for line in list.lines().map(str::trim).filter(|l| !l.is_empty() && !l.starts_with('#')) {
        let mut parts = line.split_whitespace();
        let suite_name = parts.next().unwrap();
        let function = parts.next().unwrap().to_string();
        let suite = SUITES.iter().find(|s| s.name == suite_name).unwrap_or_else(|| panic!("unknown suite {suite_name}"));
        selected.push((suite, function));
    }

    let mut modules = Vec::new();
    let mut metadata = Vec::new();
    let mut asm_by_suite: BTreeMap<&str, BTreeMap<String, BTreeSet<String>>> = BTreeMap::new();
    let mut seen = BTreeSet::new();
    for (suite, function) in &selected {
        assert!(seen.insert(function.clone()), "{function} selected twice");
        let crate_dir = root.join(suite.crate_dir);
        let found = find_annotation(&crate_dir, function);
        println!("cargo::rerun-if-changed={}", found.file.display());
        let (tokens, asm_file, bindings, preconditions, structs) = wrappers(function, &found);
        modules.push(tokens);
        asm_by_suite.entry(suite.name).or_default().entry(asm_file).or_default().insert(function.clone());
        let (suite_name, domain) = (suite.name, suite.domain);
        let clauses = bindings + preconditions;
        metadata.push(quote! {
            Meta { suite: #suite_name, function: #function, domain: #domain, clauses: #clauses, preconditions: #preconditions, structs: #structs }
        });
    }

    let generated = quote! {
        pub struct Meta {
            pub suite: &'static str,
            pub function: &'static str,
            pub domain: &'static str,
            pub clauses: usize,
            pub preconditions: usize,
            pub structs: usize,
        }
        pub const META: &[Meta] = &[#(#metadata),*];
        #(#modules)*
    };
    fs::write(out_dir.join("wrappers.rs"), generated.to_string()).unwrap();

    for (suite_name, files) in &asm_by_suite {
        let suite = SUITES.iter().find(|s| s.name == *suite_name).unwrap();
        let crate_dir = root.join(suite.crate_dir);
        let mut build = cc::Build::new();
        build.flag("-Wno-unused-command-line-argument");
        match *suite_name {
            "crypto" => {
                let dirs: Vec<PathBuf> = ["fipsmodule", "chacha", "cipher_extra"]
                    .iter()
                    .map(|d| crate_dir.join("generated-asm/ios-aarch64/crypto").join(d))
                    .chain([crate_dir.join("extra-asm/ios-aarch64"), crate_dir.join("native-asm/aarch64")])
                    .collect();
                build
                    .include(crate_dir.join("include"))
                    .include(crate_dir.join("native-asm/include"))
                    .define("S2N_BN_HIDE_SYMBOLS", "1");
                for name in files.keys() {
                    build.file(unique_named(&dirs, name));
                }
            }
            "bignum" => {
                build
                    .include(crate_dir.join("asm/include"))
                    .include(root.join("crypto-playground/include"))
                    .define("S2N_BN_HIDE_SYMBOLS", "1");
                for name in files.keys() {
                    build.file(unique_named(&[crate_dir.join("asm/aarch64")], name));
                }
            }
            "corecrypto" => {
                for name in files.keys() {
                    build.file(unique_named(&[crate_dir.join("asm/aarch64")], name));
                }
            }
            "rav1d" => {
                let config = overridden_config(
                    &crate_dir.join("include/config.h"),
                    &out_dir,
                    "rav1d-config",
                    &[("#define PRIVATE_PREFIX dav1d_", "#define PRIVATE_PREFIX")],
                );
                build.include(config).include(crate_dir.join("include")).define("__KERNEL__", "1");
                for name in files.keys() {
                    build.file(unique_named(&[crate_dir.join("include/src/arm/64")], name));
                }
                let tables = fs::read_to_string(crate_dir.join("analysis-tables/tables.S")).unwrap();
                let target = out_dir.join("rav1d-tables.s");
                fs::write(&target, mach_o_zero_tables(&tables)).unwrap();
                build.file(target);
            }
            "ffmpeg" => {
                let config = overridden_config(
                    &crate_dir.join("include/config.h"),
                    &out_dir,
                    "ffmpeg-config",
                    &[
                        ("#define EXTERN_ASM\n", "#define EXTERN_ASM _\n"),
                        ("#define HAVE_SECTION_DATA_REL_RO 1", "#define HAVE_SECTION_DATA_REL_RO 0"),
                    ],
                );
                build.include(config).include(crate_dir.join("include"));
                let mut parents = BTreeSet::new();
                for name in files.keys() {
                    let source = unique_named(&[crate_dir.join("include")], name);
                    parents.insert(source.parent().unwrap().to_path_buf());
                    build.file(source);
                }
                for parent in parents {
                    build.include(parent);
                }
            }
            "compression" | "graviola" | "openblas" | "candle" => {
                let asm_dir = if *suite_name == "graviola" { crate_dir.join("asm/aarch64") } else { crate_dir.join("asm") };
                for (name, functions) in files {
                    let source = unique_named(&[asm_dir.clone()], name);
                    let text = mach_o_text(&fs::read_to_string(&source).unwrap(), functions);
                    let target = out_dir.join(format!("{suite_name}-{}", Path::new(name).with_extension("s").display()));
                    fs::write(&target, text).unwrap();
                    build.file(target);
                }
            }
            other => panic!("no assembly recipe for {other}"),
        }
        build.compile(&format!("overhead_{suite_name}"));
    }
}
