use std::collections::{BTreeMap, BTreeSet};
use std::env;
use std::fs;
use std::path::{Path, PathBuf};

use proc_macro2::TokenStream;
use quote::{format_ident, quote};
use syn::punctuated::Punctuated;
use syn::visit_mut::{self, VisitMut};
use syn::{Block, Expr, FnArg, Item, ItemFn, ItemStruct, Pat, Stmt, Token, Type, parse_quote};
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

fn wrappers(function: &str, module: &str, found: &Found) -> (TokenStream, String, usize, usize, BTreeSet<String>, syn::Signature) {
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
    let signature = wrapper.sig.clone();

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
    let module = format_ident!("{module}");
    let tokens = quote! {
        pub mod #module {
            #![allow(unused, unused_unsafe, non_camel_case_types, non_snake_case, clippy::all)]
            #(#public_structs)*
            #(#converters)*
            #annotated
            #raw
            #(#other_items)*
        }
    };
    let structured = struct_arguments.values().cloned().collect();
    (tokens, annotation.asm_file, bindings, preconditions, structured, signature)
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

struct Suite {
    name: &'static str,
    crate_dir: &'static str,
    domain: &'static str,
}

const SUITES: &[Suite] = &[
    Suite { name: "awslc", crate_dir: "crypto-playground", domain: "crypto" },
    Suite { name: "openssl", crate_dir: "openssl-playground", domain: "crypto" },
    Suite { name: "corecrypto", crate_dir: "corecrypto-playground", domain: "crypto" },
    Suite { name: "graviola", crate_dir: "graviola-playground", domain: "crypto" },
    Suite { name: "bignum", crate_dir: "bignum-playground", domain: "crypto" },
    Suite { name: "blake3", crate_dir: "blake3-secp256k1-playground", domain: "crypto" },
    Suite { name: "candle", crate_dir: "candle-playground", domain: "numeric" },
    Suite { name: "openblas", crate_dir: "openblas-playground", domain: "numeric" },
    Suite { name: "compression", crate_dir: "compression-playground", domain: "compression" },
    Suite { name: "ffmpeg", crate_dir: "ffmpeg-playground", domain: "media" },
    Suite { name: "rav1d", crate_dir: "rav1d-playground", domain: "media" },
];

struct Found {
    attribute: String,
    item: String,
    file: PathBuf,
}

fn find_by_file(crate_dir: &Path, function: &str, file: &str) -> Option<Found> {
    let mut sources = Vec::new();
    rust_sources(&crate_dir.join("src"), &mut sources);
    for path in sources {
        if !path.ends_with(file) {
            continue;
        }
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
            return Some(Found {
                attribute: text[open + 1..close].to_string(),
                item: text[item_start..item_end].to_string(),
                file: path.clone(),
            });
        }
    }
    None
}

fn symbol_of(attribute: &str, function: &str) -> String {
    attribute
        .find("symbol = \"")
        .map(|at| {
            let rest = &attribute[at + "symbol = \"".len()..];
            rest[..rest.find('"').unwrap()].to_string()
        })
        .unwrap_or_else(|| function.to_string())
}

const INTEGERS: &[&str] = &["u8", "u16", "u32", "u64", "usize", "i8", "i16", "i32", "i64", "isize"];

fn path_name(ty: &Type) -> Option<String> {
    match ty {
        Type::Path(p) if p.qself.is_none() => p.path.get_ident().map(|i| i.to_string()),
        _ => None,
    }
}

fn fillable(ty: &Type) -> bool {
    match ty {
        Type::Path(_) => path_name(ty).is_some_and(|n| {
            INTEGERS.contains(&n.as_str()) || ["u128", "i128", "f32", "f64", "bool"].contains(&n.as_str())
        }),
        Type::Array(a) => fillable(&a.elem),
        Type::Tuple(t) => !t.elems.is_empty() && t.elems.len() <= 12 && t.elems.iter().all(fillable),
        Type::Paren(p) => fillable(&p.elem),
        _ => false,
    }
}

enum Kind {
    Integer(String),
    Plain(Type),
    Slice(Type, bool),
    Referenced(Type, bool),
    Structured(Type, bool),
}

fn kind_of(ty: &Type) -> Result<Kind, String> {
    if let Some(name) = path_name(ty) {
        if INTEGERS.contains(&name.as_str()) {
            return Ok(Kind::Integer(name));
        }
    }
    match ty {
        Type::Reference(r) => {
            let mutable = r.mutability.is_some();
            match &*r.elem {
                Type::Slice(s) if fillable(&s.elem) => Ok(Kind::Slice((*s.elem).clone(), mutable)),
                inner if fillable(inner) => Ok(Kind::Referenced(inner.clone(), mutable)),
                other => Err(format!("parameter type &{} is not generated", quote!(#other))),
            }
        }
        other if fillable(other) => Ok(Kind::Plain(other.clone())),
        other => Err(format!("parameter type {} is not generated", quote!(#other))),
    }
}

struct Expressions<'a> {
    integers: &'a BTreeSet<String>,
    slices: &'a BTreeSet<String>,
}

impl Expressions<'_> {
    fn translate(&self, expr: &Expr) -> Result<TokenStream, String> {
        match expr {
            Expr::Lit(lit) => match &lit.lit {
                syn::Lit::Int(i) => {
                    let value: i128 = i.base10_parse().map_err(|e| e.to_string())?;
                    Ok(quote!((#value)))
                }
                _ => Err("non-integer literal".into()),
            },
            Expr::Path(p) => {
                let name = p.path.get_ident().map(|i| i.to_string()).ok_or("qualified path")?;
                if self.integers.contains(&name) {
                    let ident = format_ident!("p_{name}");
                    Ok(quote!((#ident as i128)))
                } else {
                    Err(format!("{name} is not an integer parameter"))
                }
            }
            Expr::Paren(p) => self.translate(&p.expr),
            Expr::Group(g) => self.translate(&g.expr),
            Expr::Cast(c) => {
                let target = path_name(&c.ty).ok_or("cast to a non-integer")?;
                if !INTEGERS.contains(&target.as_str()) {
                    return Err("cast to a non-integer".into());
                }
                self.translate(&c.expr)
            }
            Expr::Unary(u) if matches!(u.op, syn::UnOp::Neg(_)) => {
                let inner = self.translate(&u.expr)?;
                Ok(quote!((#inner.checked_neg()?)))
            }
            Expr::MethodCall(m) => {
                let method = m.method.to_string();
                if method == "len" && m.args.is_empty() {
                    if let Expr::Path(p) = &*m.receiver {
                        let name = p.path.get_ident().map(|i| i.to_string()).unwrap_or_default();
                        if self.slices.contains(&name) {
                            let ident = format_ident!("l_{name}");
                            return Ok(quote!((#ident?)));
                        }
                    }
                    return Err("len() of something other than a slice parameter".into());
                }
                if (method == "min" || method == "max") && m.args.len() == 1 {
                    let receiver = self.translate(&m.receiver)?;
                    let argument = self.translate(&m.args[0])?;
                    let method = format_ident!("{method}");
                    return Ok(quote!((#receiver.#method(#argument))));
                }
                Err(format!("method {method} is not evaluated"))
            }
            Expr::Binary(b) => {
                let left = self.translate(&b.left)?;
                let right = self.translate(&b.right)?;
                let checked = match b.op {
                    syn::BinOp::Add(_) => quote!(checked_add),
                    syn::BinOp::Sub(_) => quote!(checked_sub),
                    syn::BinOp::Mul(_) => quote!(checked_mul),
                    syn::BinOp::Div(_) => quote!(checked_div),
                    syn::BinOp::Rem(_) => quote!(checked_rem),
                    syn::BinOp::Shl(_) => return Ok(quote!((#left.checked_shl(u32::try_from(#right).ok()?)?))),
                    syn::BinOp::Shr(_) => return Ok(quote!((#left.checked_shr(u32::try_from(#right).ok()?)?))),
                    syn::BinOp::BitAnd(_) => return Ok(quote!((#left & #right))),
                    syn::BinOp::BitOr(_) => return Ok(quote!((#left | #right))),
                    syn::BinOp::BitXor(_) => return Ok(quote!((#left ^ #right))),
                    _ => return Err("operator is not evaluated".into()),
                };
                Ok(quote!((#left.#checked(#right)?)))
            }
            _ => Err("expression is not evaluated".into()),
        }
    }
}

impl Expressions<'_> {
    fn condition(&self, expr: &Expr) -> Result<TokenStream, String> {
        match expr {
            Expr::Paren(p) => self.condition(&p.expr),
            Expr::Group(g) => self.condition(&g.expr),
            Expr::Unary(u) if matches!(u.op, syn::UnOp::Not(_)) => {
                let inner = self.condition(&u.expr)?;
                Ok(quote!((!#inner)))
            }
            Expr::Binary(b) => match b.op {
                syn::BinOp::And(_) | syn::BinOp::Or(_) => {
                    let (left, right) = (self.condition(&b.left)?, self.condition(&b.right)?);
                    Ok(if matches!(b.op, syn::BinOp::And(_)) { quote!((#left && #right)) } else { quote!((#left || #right)) })
                }
                syn::BinOp::Eq(_) | syn::BinOp::Ne(_) | syn::BinOp::Lt(_) | syn::BinOp::Le(_) | syn::BinOp::Gt(_)
                | syn::BinOp::Ge(_) => {
                    let (left, right) = (self.translate(&b.left)?, self.translate(&b.right)?);
                    let op = &b.op;
                    Ok(quote!((#left #op #right)))
                }
                _ => Err("not a condition".into()),
            },
            _ => Err("not a condition".into()),
        }
    }
}

fn integer_parameters(expr: &Expr, integers: &BTreeSet<String>) -> BTreeSet<String> {
    struct Collect<'a>(&'a BTreeSet<String>, BTreeSet<String>);
    impl<'ast> syn::visit::Visit<'ast> for Collect<'_> {
        fn visit_path(&mut self, path: &'ast syn::Path) {
            if let Some(ident) = path.get_ident() {
                let name = ident.to_string();
                if self.0.contains(&name) {
                    self.1.insert(name);
                }
            }
        }
    }
    let mut collect = Collect(integers, BTreeSet::new());
    syn::visit::Visit::visit_expr(&mut collect, expr);
    collect.1
}

fn universe(constants: &[i128]) -> Vec<i128> {
    let mut values: BTreeSet<i128> = [
        0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 20, 24, 31, 32, 33, 40, 48, 63, 64, 65, 80, 96, 100,
        127, 128, 129, 160, 192, 255, 256, 257, 320, 384, 511, 512, 513, 768, 1000, 1023, 1024, 2048, 4096, 8192, 16384,
    ]
    .into_iter()
    .collect();
    for shift in 0..17 {
        values.insert(1 << shift);
    }
    for &c in constants {
        for v in [c - 1, c, c + 1, c / 2, c / 4] {
            values.insert(v);
        }
        for k in 2..=8 {
            values.insert(c * k);
        }
    }
    values.into_iter().filter(|v| v.abs() <= 1 << 20).collect()
}

fn integer_literals(expr: &Expr, out: &mut BTreeSet<i128>) {
    struct Collect<'a>(&'a mut BTreeSet<i128>);
    impl<'ast> syn::visit::Visit<'ast> for Collect<'_> {
        fn visit_lit_int(&mut self, lit: &'ast syn::LitInt) {
            if let Ok(value) = lit.base10_parse::<i128>() {
                self.0.insert(value);
            }
        }
    }
    syn::visit::Visit::visit_expr(&mut Collect(out), expr);
}

fn length_side(expr: &Expr, slices: &BTreeSet<String>) -> Option<(String, i128)> {
    match expr {
        Expr::MethodCall(m) if m.method == "len" && m.args.is_empty() => match &*m.receiver {
            Expr::Path(p) => p.path.get_ident().map(|i| i.to_string()).filter(|n| slices.contains(n)).map(|n| (n, 1)),
            _ => None,
        },
        Expr::Binary(b) if matches!(b.op, syn::BinOp::Mul(_)) => {
            let factor = |e: &Expr| match e {
                Expr::Lit(syn::ExprLit { lit: syn::Lit::Int(i), .. }) => i.base10_parse::<i128>().ok(),
                _ => None,
            };
            length_side(&b.left, slices)
                .and_then(|(n, k)| factor(&b.right).map(|f| (n, k * f)))
                .or_else(|| length_side(&b.right, slices).and_then(|(n, k)| factor(&b.left).map(|f| (n, k * f))))
        }
        Expr::Paren(p) => length_side(&p.expr, slices),
        _ => None,
    }
}

fn sampler(signature: &syn::Signature, attribute: &TokenStream, structured: &BTreeSet<String>) -> Result<TokenStream, String> {
    let mut parameters = Vec::new();
    for input in &signature.inputs {
        let FnArg::Typed(typed) = input else { return Err("receiver parameter".into()) };
        let Pat::Ident(ident) = &*typed.pat else { return Err("pattern parameter".into()) };
        let name = ident.ident.to_string();
        let kind = if structured.contains(&name) {
            match &*typed.ty {
                Type::Reference(r) if fillable(&r.elem) => Kind::Structured((*r.elem).clone(), r.mutability.is_some()),
                other => return Err(format!("{name}: struct argument of type {} is not generated", quote!(#other))),
            }
        } else {
            kind_of(&typed.ty).map_err(|e| format!("{name}: {e}"))?
        };
        parameters.push((name, kind));
    }
    let integers: BTreeSet<String> = parameters
        .iter()
        .filter(|(_, k)| matches!(k, Kind::Integer(_)))
        .map(|(n, _)| n.clone())
        .collect();
    let slices: BTreeSet<String> =
        parameters.iter().filter(|(_, k)| matches!(k, Kind::Slice(..))).map(|(n, _)| n.clone()).collect();
    let arguments: Punctuated<Expr, Token![,]> =
        syn::parse::Parser::parse2(Punctuated::parse_terminated, attribute.clone()).map_err(|e| e.to_string())?;
    let conditions: Vec<Expr> = arguments
        .iter()
        .filter_map(|a| match a {
            Expr::Array(list) => Some(list.elems.iter().cloned().collect::<Vec<_>>()),
            _ => None,
        })
        .last()
        .unwrap_or_default();
    let mut constants = BTreeSet::new();
    for condition in &conditions {
        integer_literals(condition, &mut constants);
    }
    let constants: Vec<i128> = constants.into_iter().filter(|c| c.abs() <= 1 << 20).collect();
    let expressions = Expressions { integers: &integers, slices: &slices };

    let mut lengths: BTreeMap<String, (TokenStream, i128)> = BTreeMap::new();
    let mut assignments = Vec::new();
    for condition in &conditions {
        let Expr::Binary(b) = condition else { continue };
        let (equal, at_least) = (matches!(b.op, syn::BinOp::Eq(_)), matches!(b.op, syn::BinOp::Ge(_)));
        if equal || at_least {
            let sides = length_side(&b.left, &slices)
                .map(|s| (s, &*b.right))
                .or_else(|| if equal { length_side(&b.right, &slices).map(|s| (s, &*b.left)) } else { None });
            if let Some(((name, factor), other)) = sides {
                if let Ok(value) = expressions.translate(other) {
                    lengths.entry(name).or_insert((value, factor));
                }
                continue;
            }
        }
        if equal {
            if let Expr::Index(index) = &*b.left {
                if let Expr::Path(p) = &*index.expr {
                    let name = p.path.get_ident().map(|i| i.to_string()).unwrap_or_default();
                    let target = parameters.iter().find(|(n, _)| *n == name).map(|(_, k)| k);
                    let element_integer = |ty: &Type| path_name(ty).is_some_and(|n| INTEGERS.contains(&n.as_str()));
                    let element = match target {
                        Some(Kind::Slice(t, _)) if element_integer(t) => Some(t.clone()),
                        Some(Kind::Referenced(Type::Array(a), _)) | Some(Kind::Plain(Type::Array(a))) if element_integer(&a.elem) => {
                            Some((*a.elem).clone())
                        }
                        _ => None,
                    };
                    if let (Some(element), Ok(position), Ok(value)) =
                        (element, expressions.translate(&index.index), expressions.translate(&b.right))
                    {
                        let field = format_ident!("p_{name}");
                        assignments.push(quote! {
                            if let (Some(position), Some(value)) = ((|| -> Option<i128> { Some(#position) })(), (|| -> Option<i128> { Some(#value) })()) {
                                if position >= 0 && (position as usize) < #field.len() {
                                    #field[position as usize] = value as #element;
                                }
                            }
                        });
                    }
                }
            }
        }
    }

    let scalar_conditions: Vec<(BTreeSet<String>, TokenStream)> = conditions
        .iter()
        .filter_map(|condition| {
            if quote!(#condition).to_string().contains("len ()") {
                return None;
            }
            let mentioned = integer_parameters(condition, &integers);
            let translated = expressions.condition(condition).ok()?;
            (!mentioned.is_empty()).then_some((mentioned, translated))
        })
        .collect();
    let universe_values = universe(&constants);
    let universe_len = universe_values.len();
    let mut setup = vec![quote!(const UNIVERSE: [i128; #universe_len] = [#(#universe_values),*];)];
    let mut described = Vec::new();
    let mut assigned: BTreeSet<String> = BTreeSet::new();
    for (name, kind) in &parameters {
        if let Kind::Integer(ty) = kind {
            let ident = format_ident!("p_{name}");
            let ty = format_ident!("{ty}");
            assigned.insert(name.clone());
            let checks: Vec<&TokenStream> = scalar_conditions
                .iter()
                .filter(|(mentioned, _)| mentioned.contains(name) && mentioned.is_subset(&assigned))
                .map(|(_, check)| check)
                .collect();
            setup.push(quote! {
                let #ident: #ty = {
                    let pool: Vec<i128> = UNIVERSE
                        .iter()
                        .copied()
                        .filter(|&candidate| {
                            let #ident: i128 = candidate;
                            <#ty>::try_from(candidate).is_ok()
                                #(&& (|| -> Option<bool> { Some(#checks) })().unwrap_or(false))*
                        })
                        .collect();
                    let value = if pool.is_empty() { rng.scalar(&CONSTANTS) } else { pool[rng.below(pool.len())] };
                    <#ty>::try_from(value).ok()?
                };
            });
            described.push(quote!(format!("{}={}", #name, #ident)));
        }
    }
    for name in &slices {
        let ident = format_ident!("l_{name}");
        setup.push(quote!(let mut #ident: Option<i128> = None;));
    }
    let rounds = slices.len().max(1);
    let mut resolve = Vec::new();
    for name in &slices {
        let ident = format_ident!("l_{name}");
        let compute = match lengths.get(name) {
            Some((value, factor)) => quote! {
                (|| -> Option<i128> {
                    let total = #value;
                    if total % #factor != 0 { return None; }
                    Some(total / #factor)
                })()
            },
            None => quote!(Some(rng.scalar(&CONSTANTS))),
        };
        resolve.push(quote!(if #ident.is_none() { #ident = #compute; }));
    }
    setup.push(quote!(for _ in 0..#rounds { #(#resolve)* }));
    let mut fields = Vec::new();
    let mut values = Vec::new();
    let mut call_arguments = Vec::new();
    let mut raw_arguments = Vec::new();
    let mut sizes = Vec::new();
    for (name, kind) in &parameters {
        let field = format_ident!("p_{name}");
        match kind {
            Kind::Integer(ty) => {
                let ty = format_ident!("{ty}");
                fields.push(quote!(#field: #ty));
                values.push(quote!(#field));
                call_arguments.push(quote!(st.#field));
            }
            Kind::Plain(ty) => {
                setup.push(quote!(let mut #field: #ty = crate::inputs::Fill::fill(rng);));
                fields.push(quote!(#field: #ty));
                values.push(quote!(#field));
                call_arguments.push(quote!(st.#field));
                sizes.push(quote!(std::mem::size_of::<#ty>()));
            }
            Kind::Referenced(ty, mutable) => {
                setup.push(quote!(let mut #field: #ty = crate::inputs::Fill::fill(rng);));
                fields.push(quote!(#field: #ty));
                values.push(quote!(#field));
                call_arguments.push(if *mutable { quote!(&mut st.#field) } else { quote!(&st.#field) });
                sizes.push(quote!(std::mem::size_of::<#ty>()));
            }
            Kind::Slice(element, mutable) => {
                let length = format_ident!("l_{name}");
                setup.push(quote! {
                    let #length = #length?;
                    if #length < 0 || #length as usize * std::mem::size_of::<#element>() > (1 << 24) { return None; }
                    let mut #field: Vec<#element> = crate::inputs::buffer(rng, #length as usize);
                });
                described.push(quote!(format!("{}.len={}", #name, #field.len())));
                fields.push(quote!(#field: Vec<#element>));
                values.push(quote!(#field));
                call_arguments.push(if *mutable { quote!(&mut st.#field[..]) } else { quote!(&st.#field[..]) });
                sizes.push(quote!(#field.len() * std::mem::size_of::<#element>()));
            }
            Kind::Structured(ty, mutable) => {
                let converted = format_ident!("p_{name}_struct");
                let struct_type = format_ident!("{name}_struct");
                let converter = format_ident!("{name}_as_struct");
                setup.push(quote!(let mut #field: #ty = crate::inputs::Fill::fill(rng);));
                fields.push(quote!(#field: #ty));
                fields.push(quote!(#converted: #struct_type));
                values.push(quote!(#field));
                values.push(quote!(#converted: #converter(&#field)));
                call_arguments.push(if *mutable { quote!(&mut st.#field) } else { quote!(&st.#field) });
                raw_arguments.push(if *mutable { quote!(&mut st.#converted) } else { quote!(&st.#converted) });
                sizes.push(quote!(std::mem::size_of::<#ty>()));
                continue;
            }
        }
        raw_arguments.push(call_arguments.last().unwrap().clone());
    }
    let constants_len = constants.len();
    Ok(quote! {
        const CONSTANTS: [i128; #constants_len] = [#(#constants),*];
        pub fn sample(rng: &mut crate::inputs::Rng) -> Option<crate::Sample> {
            #(#setup)*
            #(#assignments)*
            let description: Vec<String> = vec![#(#described),*];
            let description = description.join(" ");
            let input_bytes = 0usize #(+ #sizes)*;
            struct State { #(#fields),* }
            let state = State { #(#values),* };
            Some(crate::Sample {
                calls: crate::harness::Calls::new(
                    state,
                    input_bytes,
                    |st| { let _ = unsafe { annotated(#(#call_arguments),*) }; },
                    |st| { let _ = unsafe { raw(#(#raw_arguments),*) }; },
                ),
                description,
            })
        }
    })
}
struct Entry {
    index: usize,
    function: String,
    file: String,
    symbol: String,
    asm_file: String,
    tokens: TokenStream,
    sampler: TokenStream,
    clauses: usize,
    preconditions: usize,
}

fn mach_o_portable(source: &str, functions: &BTreeSet<String>, rodata_in_text: bool) -> String {
    let kept: String = source
        .lines()
        .filter(|line| {
            let trimmed = line.trim();
            !(trimmed.starts_with(".hidden") || trimmed.starts_with(".previous") || trimmed.starts_with(".protected"))
        })
        .map(|line| {
            let trimmed = line.trim();
            let read_only = trimmed.starts_with(".section") && (trimmed.contains(".rodata") || trimmed.contains(".data.rel.ro"));
            let line = if rodata_in_text && read_only {
                "\t.text".to_string()
            } else if trimmed.starts_with(".pushsection") {
                if trimmed.contains(".text") || rodata_in_text { "\t.text".to_string() } else { "\t.section __TEXT,__const".to_string() }
            } else if trimmed.starts_with(".popsection") {
                "\t.text".to_string()
            } else {
                line.replace("{{", "{").replace("}}", "}")
            };
            format!("{line}\n")
        })
        .collect();
    let text = mach_o_text(&kept, functions);
    if rodata_in_text { text } else { text.replace("__TEXT,__const", "__DATA,__const") }
}

fn find_source(dirs: &[PathBuf], name: &str) -> Result<PathBuf, String> {
    let mut found = Vec::new();
    for dir in dirs {
        find_named(dir, name, &mut found);
    }
    found.sort();
    found.dedup();
    match found.len() {
        1 => Ok(found.pop().unwrap()),
        0 => Err(format!("no source named {name}")),
        _ => Err(format!("several sources named {name}")),
    }
}

fn assemble(suite: &str, root: &Path, out_dir: &Path, asm_file: &str, symbols: &BTreeSet<String>, library: &str) -> Result<(), String> {
    let crate_dir = root.join(SUITES.iter().find(|s| s.name == suite).unwrap().crate_dir);
    let mut build = cc::Build::new();
    build
        .flag("-Wno-unused-command-line-argument")
        .flag("-march=armv9.2-a+sve2+sm4+sha3+aes+crypto+i8mm+dotprod+fp16+rcpc+rng")
        .cargo_metadata(false)
        .cargo_warnings(false);
    let source = match suite {
        "awslc" => {
            let dirs: Vec<PathBuf> = ["fipsmodule", "chacha", "cipher_extra"]
                .iter()
                .map(|d| crate_dir.join("generated-asm/ios-aarch64/crypto").join(d))
                .chain([crate_dir.join("extra-asm/ios-aarch64"), crate_dir.join("native-asm/aarch64")])
                .collect();
            build
                .include(crate_dir.join("include"))
                .include(crate_dir.join("native-asm/include"))
                .define("S2N_BN_HIDE_SYMBOLS", "1");
            find_source(&dirs, asm_file)?
        }
        "bignum" => {
            build
                .include(crate_dir.join("asm/include"))
                .include(root.join("crypto-playground/include"))
                .define("S2N_BN_HIDE_SYMBOLS", "1");
            find_source(&[crate_dir.join("asm/aarch64")], asm_file)?
        }
        "corecrypto" => find_source(&[crate_dir.join("asm/aarch64")], asm_file)?,
        "rav1d" => {
            let config = overridden_config(
                &crate_dir.join("include/config.h"),
                out_dir,
                "rav1d-config",
                &[("#define PRIVATE_PREFIX dav1d_", "#define PRIVATE_PREFIX")],
            );
            build.include(config).include(crate_dir.join("include")).define("__KERNEL__", "1");
            find_source(&[crate_dir.join("include/src/arm/64"), crate_dir.join("src")], asm_file)?
        }
        "ffmpeg" => {
            let config = overridden_config(
                &crate_dir.join("include/config.h"),
                out_dir,
                "ffmpeg-config",
                &[
                    ("#define EXTERN_ASM\n", "#define EXTERN_ASM _\n"),
                    ("#define HAVE_SECTION_DATA_REL_RO 1", "#define HAVE_SECTION_DATA_REL_RO 0"),
                ],
            );
            build.include(config).include(crate_dir.join("include"));
            let source = find_source(&[crate_dir.join("include")], asm_file)?;
            build.include(source.parent().unwrap());
            source
        }
        "compression" | "graviola" | "openblas" | "candle" | "openssl" | "blake3" => {
            let asm_dir = match suite {
                "graviola" | "openssl" => crate_dir.join("asm/aarch64"),
                _ => crate_dir.join("asm"),
            };
            let source = find_source(&[asm_dir], asm_file)?;
            let text = match suite {
                "openssl" => mach_o_portable(&fs::read_to_string(&source).map_err(|e| e.to_string())?, symbols, true),
                "blake3" | "graviola" => mach_o_portable(&fs::read_to_string(&source).map_err(|e| e.to_string())?, symbols, false),
                _ => mach_o_text(&fs::read_to_string(&source).map_err(|e| e.to_string())?, symbols),
            };
            let target = out_dir.join(format!("{library}.s"));
            fs::write(&target, text).map_err(|e| e.to_string())?;
            target
        }
        other => return Err(format!("no assembly recipe for {other}")),
    };
    build.file(source);
    build.try_compile(library).map_err(|e| e.to_string().lines().next().unwrap_or("").to_string())?;
    Ok(())
}

const SYSTEM_SYMBOLS: &[&str] = &[
    "_memcpy", "_memset", "_memmove", "_bzero", "_memcmp", "_abort", "_free", "_malloc", "_calloc", "___stack_chk_fail",
    "___stack_chk_guard", "_strlen",
];

fn symbols(archive: &Path, flags: &[&str]) -> BTreeSet<String> {
    let listing = std::process::Command::new("nm").args(flags).arg(archive).output().unwrap();
    String::from_utf8_lossy(&listing.stdout)
        .lines()
        .filter_map(|line| line.split_whitespace().last().map(str::to_string))
        .filter(|name| !name.ends_with(':') && !name.is_empty())
        .collect()
}

fn unresolved_stubs(out_dir: &Path, libraries: &[String]) -> String {
    let mut undefined = BTreeSet::new();
    let mut defined = BTreeSet::new();
    for library in libraries {
        let archive = out_dir.join(format!("lib{library}.a"));
        undefined.extend(symbols(&archive, &["-u"]));
        defined.extend(symbols(&archive, &["-g", "--defined-only"]));
    }
    let mut text = String::new();
    for name in undefined.difference(&defined) {
        if SYSTEM_SYMBOLS.contains(&name.as_str()) {
            continue;
        }
        if name.contains("memcpy_chk") {
            text.push_str(&format!("\t.text\n\t.globl {name}\n\t.p2align 2\n{name}:\n\tb _memcpy\n"));
        } else if name.contains("memset_chk") {
            text.push_str(&format!("\t.text\n\t.globl {name}\n\t.p2align 2\n{name}:\n\tb _memset\n"));
        } else {
            text.push_str(&format!("\t.section __DATA,__data\n\t.globl {name}\n\t.p2align 6\n{name}:\n\t.zero 1048576\n"));
        }
    }
    text
}

fn links_alone(out_dir: &Path, library: &str, support: &[String]) -> Result<(), String> {
    let main = out_dir.join("probe_main.c");
    fs::write(&main, "int main(void) { return 0; }\n").map_err(|e| e.to_string())?;
    let mut command = std::process::Command::new("cc");
    command.arg(&main).arg(format!("-Wl,-force_load,{}", out_dir.join(format!("lib{library}.a")).display()));
    for extra in support {
        command.arg(out_dir.join(format!("lib{extra}.a")));
    }
    command.arg("-Wl,-undefined,dynamic_lookup");
    let linked = command.arg("-o").arg(out_dir.join(format!("{library}-probe"))).output().map_err(|e| e.to_string())?;
    if linked.status.success() {
        return Ok(());
    }
    let message = String::from_utf8_lossy(&linked.stderr);
    let first = message.lines().find(|l| l.contains("ld:") && !l.contains("warning")).unwrap_or("link failed");
    Err(format!("does not link on Mach-O: {}", first.trim().chars().take(160).collect::<String>()))
}

fn stub_library(out_dir: &Path, name: &str, assembly: &str) {
    let target = out_dir.join(format!("{name}.s"));
    fs::write(&target, assembly).unwrap();
    cc::Build::new().file(target).cargo_metadata(false).compile(name);
}

fn main() {
    let manifest = PathBuf::from(env::var("CARGO_MANIFEST_DIR").unwrap());
    let root = manifest.join("../..").canonicalize().unwrap();
    let out_dir = PathBuf::from(env::var("OUT_DIR").unwrap());
    println!("cargo::rerun-if-env-changed=OVERHEAD_SUITE");
    println!("cargo::rerun-if-env-changed=OVERHEAD_VERIFIED");
    println!("cargo::rerun-if-changed=build.rs");
    let suite_name = env::var("OVERHEAD_SUITE").unwrap_or_else(|_| "graviola".to_string());
    let suite = SUITES.iter().find(|s| s.name == suite_name).unwrap_or_else(|| panic!("unknown suite {suite_name}"));
    let verified = PathBuf::from(env::var("OVERHEAD_VERIFIED").expect("OVERHEAD_VERIFIED names the sweep TSV of the suite"));
    println!("cargo::rerun-if-changed={}", verified.display());
    let rows: Vec<(String, String)> = fs::read_to_string(&verified)
        .unwrap()
        .lines()
        .filter_map(|line| {
            let parts: Vec<&str> = line.split('\t').collect();
            (parts.len() >= 3 && parts[2] == "verified").then(|| (parts[0].to_string(), parts[1].to_string()))
        })
        .collect();

    let crate_dir = root.join(suite.crate_dir);
    let mut entries = Vec::new();
    let mut skipped: Vec<(String, String, String)> = Vec::new();
    std::panic::set_hook(Box::new(|_| {}));
    for (index, (function, file)) in rows.iter().enumerate() {
        let Some(found) = find_by_file(&crate_dir, function, file) else {
            skipped.push((function.clone(), file.clone(), "no aarch64 annotation".into()));
            continue;
        };
        println!("cargo::rerun-if-changed={}", found.file.display());
        let module = format!("f{index}");
        let generated = std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| wrappers(function, &module, &found)));
        let Ok((tokens, asm_file, bindings, preconditions, structs, signature)) = generated else {
            skipped.push((function.clone(), file.clone(), "wrapper generation failed".into()));
            continue;
        };
        if signature.unsafety.is_some() {
            skipped.push((function.clone(), file.clone(), "unsafe wrapper: some preconditions are not checked at run time".into()));
            continue;
        }
        let attribute: TokenStream = found.attribute.parse().unwrap();
        match sampler(&signature, &attribute, &structs) {
            Ok(sampler) => entries.push(Entry {
                index,
                function: function.clone(),
                file: file.clone(),
                symbol: symbol_of(&found.attribute, function),
                asm_file,
                tokens,
                sampler,
                clauses: bindings + preconditions,
                preconditions,
            }),
            Err(reason) => skipped.push((function.clone(), file.clone(), format!("input generator: {reason}"))),
        }
    }
    let _ = std::panic::take_hook();

    let mut by_file: BTreeMap<String, BTreeSet<String>> = BTreeMap::new();
    for entry in &entries {
        by_file.entry(entry.asm_file.clone()).or_default().insert(entry.symbol.clone());
    }
    let mut failed_files: BTreeMap<String, String> = BTreeMap::new();
    let mut built = Vec::new();
    let mut file_of = BTreeMap::new();
    for (number, (asm_file, symbols)) in by_file.iter().enumerate() {
        let library = format!("overhead_{suite_name}_{number}");
        match assemble(&suite_name, &root, &out_dir, asm_file, symbols, &library) {
            Ok(()) => {
                file_of.insert(library.clone(), asm_file.clone());
                built.push(library);
            }
            Err(reason) => {
                failed_files.insert(asm_file.clone(), reason);
            }
        }
    }
    let mut support = Vec::new();
    match suite_name.as_str() {
        "rav1d" => {
            let tables = fs::read_to_string(crate_dir.join("analysis-tables/tables.S")).unwrap();
            stub_library(&out_dir, "overhead_rav1d_tables", &mach_o_zero_tables(&tables));
            support.push("overhead_rav1d_tables".to_string());
        }
        "openssl" => {
            stub_library(
                &out_dir,
                "overhead_openssl_armcap",
                "\t.section __DATA,__data\n\t.p2align 3\n\t.globl OPENSSL_armcap_P\nOPENSSL_armcap_P:\n\t.quad 0\n",
            );
            support.push("overhead_openssl_armcap".to_string());
        }
        _ => {}
    }
    let mut stubs_input = built.clone();
    stubs_input.extend(support.iter().cloned());
    let stubs = unresolved_stubs(&out_dir, &stubs_input);
    if !stubs.is_empty() {
        let name = format!("overhead_{suite_name}_stubs");
        stub_library(&out_dir, &name, &stubs);
        support.push(name);
    }
    let mut alone_failures = BTreeMap::new();
    for library in &built {
        if let Err(reason) = links_alone(&out_dir, library, &support) {
            alone_failures.insert(library.clone(), reason);
        }
    }
    let passing: Vec<String> = built.iter().filter(|l| !alone_failures.contains_key(*l)).cloned().collect();
    for (library, reason) in alone_failures {
        let mut with_others: Vec<String> = passing.clone();
        with_others.extend(support.iter().cloned());
        if links_alone(&out_dir, &library, &with_others).is_err() {
            failed_files.insert(file_of[&library].clone(), reason);
        }
    }
    println!("cargo:rustc-link-search=native={}", out_dir.display());
    for library in built.iter().filter(|l| !failed_files.contains_key(&file_of[*l])).chain(support.iter()) {
        println!("cargo:rustc-link-lib=static={library}");
    }

    let mut modules = Vec::new();
    let mut metadata = Vec::new();
    let domain = suite.domain;
    for entry in &entries {
        let (function, file) = (&entry.function, &entry.file);
        let (clauses, preconditions) = (entry.clauses, entry.preconditions);
        if let Some(reason) = failed_files.get(&entry.asm_file) {
            let reason = format!("assembly did not build for Mach-O: {reason}");
            metadata.push(quote! {
                Meta { suite: #suite_name, domain: #domain, function: #function, file: #file, clauses: #clauses, preconditions: #preconditions, sample: None, skipped: #reason }
            });
            continue;
        }
        modules.push(entry.tokens.clone());
        let module = format_ident!("f{}", entry.index);
        let sampler_module = format_ident!("f{}_sample", entry.index);
        let sampler = &entry.sampler;
        modules.push(quote! {
            pub mod #sampler_module {
                #![allow(unused, unused_mut, unused_unsafe, non_snake_case, clippy::all)]
                use super::#module::*;
                #sampler
            }
        });
        metadata.push(quote! {
            Meta { suite: #suite_name, domain: #domain, function: #function, file: #file, clauses: #clauses, preconditions: #preconditions, sample: Some(#sampler_module::sample), skipped: "" }
        });
    }
    for (function, file, reason) in &skipped {
        metadata.push(quote! {
            Meta { suite: #suite_name, domain: #domain, function: #function, file: #file, clauses: 0, preconditions: 0, sample: None, skipped: #reason }
        });
    }
    let generated = quote! {
        pub struct Meta {
            pub suite: &'static str,
            pub domain: &'static str,
            pub function: &'static str,
            pub file: &'static str,
            pub clauses: usize,
            pub preconditions: usize,
            pub sample: Option<fn(&mut crate::inputs::Rng) -> Option<crate::Sample>>,
            pub skipped: &'static str,
        }
        pub const META: &[Meta] = &[#(#metadata),*];
        #(#modules)*
    };
    fs::write(out_dir.join("wrappers.rs"), generated.to_string()).unwrap();
}
