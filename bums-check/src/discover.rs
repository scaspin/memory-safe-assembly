use proc_macro2::TokenStream;
use quote::quote;
use std::collections::BTreeSet;
use std::path::{Path, PathBuf};
use syn::parse::{ParseStream, Parser};
use syn::punctuated::Punctuated;
use syn::{Attribute, Expr, Item, Lit, LitStr, Meta, Signature, Token, Visibility};

pub struct CfgContext {
    pub target_arch: String,
    pub target_os: String,
    pub target_family: String,
    pub features: BTreeSet<String>,
}

impl CfgContext {
    pub fn for_target(target: &str, features: BTreeSet<String>) -> CfgContext {
        let target_arch = target.split('-').next().unwrap_or_default().to_string();
        let target_os = if target.contains("darwin") {
            "macos"
        } else if target.contains("linux") {
            "linux"
        } else if target.contains("windows") {
            "windows"
        } else {
            "none"
        };
        let target_family = if target_os == "windows" {
            "windows"
        } else {
            "unix"
        };
        CfgContext {
            target_arch,
            target_os: target_os.to_string(),
            target_family: target_family.to_string(),
            features,
        }
    }

    fn holds(&self, predicate: &Meta) -> bool {
        match predicate {
            Meta::Path(path) => {
                let name = path_name(path);
                name == self.target_family
            }
            Meta::NameValue(pair) => {
                let Expr::Lit(literal) = &pair.value else {
                    return false;
                };
                let Lit::Str(value) = &literal.lit else {
                    return false;
                };
                let value = value.value();
                match path_name(&pair.path).as_str() {
                    "target_arch" => value == self.target_arch,
                    "target_os" => value == self.target_os,
                    "target_family" => value == self.target_family,
                    "target_pointer_width" => value == "64",
                    "target_endian" => value == "little",
                    "feature" => self.features.contains(&value),
                    _ => false,
                }
            }
            Meta::List(list) => {
                let Ok(operands) =
                    Punctuated::<Meta, Token![,]>::parse_terminated.parse2(list.tokens.clone())
                else {
                    return false;
                };
                match path_name(&list.path).as_str() {
                    "all" => operands.iter().all(|operand| self.holds(operand)),
                    "any" => operands.iter().any(|operand| self.holds(operand)),
                    "not" => operands.len() == 1 && !self.holds(&operands[0]),
                    _ => false,
                }
            }
        }
    }

    fn active_metas(&self, attrs: &[Attribute]) -> Option<Vec<Meta>> {
        let mut metas = Vec::new();
        for attr in attrs {
            if !self.expand(attr.meta.clone(), &mut metas) {
                return None;
            }
        }
        Some(metas)
    }

    fn expand(&self, meta: Meta, metas: &mut Vec<Meta>) -> bool {
        let Meta::List(list) = &meta else {
            metas.push(meta);
            return true;
        };
        match path_name(&list.path).as_str() {
            "cfg" => match list.parse_args::<Meta>() {
                Ok(predicate) => self.holds(&predicate),
                Err(_) => false,
            },
            "cfg_attr" => {
                let Ok(parts) =
                    Punctuated::<Meta, Token![,]>::parse_terminated.parse2(list.tokens.clone())
                else {
                    return true;
                };
                let mut parts = parts.into_iter();
                let Some(predicate) = parts.next() else {
                    return true;
                };
                if !self.holds(&predicate) {
                    return true;
                }
                parts.all(|part| self.expand(part, metas))
            }
            _ => {
                metas.push(meta);
                true
            }
        }
    }
}

fn path_name(path: &syn::Path) -> String {
    path.segments
        .last()
        .map(|segment| segment.ident.to_string())
        .unwrap_or_default()
}

pub struct Found {
    pub function: String,
    pub asm_file: String,
    pub file: PathBuf,
    pub attr: TokenStream,
    pub item: TokenStream,
}

struct BodilessFn {
    attrs: Vec<Attribute>,
    vis: Visibility,
    signature: Signature,
}

fn parse_bodiless_fn(input: ParseStream) -> syn::Result<BodilessFn> {
    let attrs = input.call(Attribute::parse_outer)?;
    let vis = input.parse()?;
    let signature = input.parse()?;
    input.parse::<Token![;]>()?;
    Ok(BodilessFn {
        attrs,
        vis,
        signature,
    })
}

pub fn discover(crate_dir: &Path, cfg: &CfgContext) -> Result<Vec<Found>, String> {
    let mut found = Vec::new();
    for root in ["src/lib.rs", "src/main.rs"] {
        let path = crate_dir.join(root);
        if path.exists() {
            walk_file(&path, path.parent().unwrap(), cfg, &mut found)?;
        }
    }
    Ok(found)
}

fn walk_file(
    path: &Path,
    module_dir: &Path,
    cfg: &CfgContext,
    found: &mut Vec<Found>,
) -> Result<(), String> {
    let source =
        std::fs::read_to_string(path).map_err(|error| format!("{}: {error}", path.display()))?;
    let file = syn::parse_file(&source).map_err(|error| format!("{}: {error}", path.display()))?;
    if cfg.active_metas(&file.attrs).is_none() {
        return Ok(());
    }
    walk_items(&file.items, path, module_dir, cfg, found)
}

fn walk_items(
    items: &[Item],
    file: &Path,
    module_dir: &Path,
    cfg: &CfgContext,
    found: &mut Vec<Found>,
) -> Result<(), String> {
    for item in items {
        match item {
            Item::Mod(declaration) => {
                let Some(metas) = cfg.active_metas(&declaration.attrs) else {
                    continue;
                };
                let name = declaration.ident.to_string();
                let explicit_path = metas.iter().find_map(|meta| match meta {
                    Meta::NameValue(pair) if path_name(&pair.path) == "path" => match &pair.value {
                        Expr::Lit(literal) => match &literal.lit {
                            Lit::Str(value) => Some(value.value()),
                            _ => None,
                        },
                        _ => None,
                    },
                    _ => None,
                });
                match &declaration.content {
                    Some((_, items)) => {
                        let child_dir = match &explicit_path {
                            Some(explicit) => module_dir.join(explicit),
                            None => module_dir.join(&name),
                        };
                        walk_items(items, file, &child_dir, cfg, found)?;
                    }
                    None => {
                        let (child_file, child_dir) = match explicit_path {
                            Some(explicit) => {
                                let child_file = module_dir.join(explicit);
                                let child_dir = child_file.parent().unwrap().to_path_buf();
                                (child_file, child_dir)
                            }
                            None => {
                                let flat = module_dir.join(format!("{name}.rs"));
                                if flat.exists() {
                                    (flat, module_dir.join(&name))
                                } else {
                                    let nested = module_dir.join(&name);
                                    (nested.join("mod.rs"), nested)
                                }
                            }
                        };
                        walk_file(&child_file, &child_dir, cfg, found)?;
                    }
                }
            }
            Item::Verbatim(tokens) => {
                let Ok(function) = parse_bodiless_fn.parse2(tokens.clone()) else {
                    continue;
                };
                let Some(metas) = cfg.active_metas(&function.attrs) else {
                    continue;
                };
                let (vis, signature) = (&function.vis, &function.signature);
                for meta in metas {
                    let Meta::List(list) = meta else {
                        continue;
                    };
                    if path_name(&list.path) != "check_mem_safe" {
                        continue;
                    }
                    let asm_file = list
                        .tokens
                        .clone()
                        .into_iter()
                        .next()
                        .and_then(|token| syn::parse2::<LitStr>(token.into()).ok())
                        .map(|name| name.value())
                        .unwrap_or_default();
                    found.push(Found {
                        function: signature.ident.to_string(),
                        asm_file,
                        file: file.to_path_buf(),
                        attr: list.tokens.clone(),
                        item: quote! { #vis #signature ; },
                    });
                }
            }
            _ => {}
        }
    }
    Ok(())
}
