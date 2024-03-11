extern crate proc_macro;
use proc_macro::{Span, TokenStream};
use proc_macro_error::{abort_call_site, proc_macro_error};
use quote::quote;
use std::fs::File;
use std::io::{BufRead, BufReader};
// use std::process::Command;
use syn::parse::{Parse, ParseStream};
use syn::punctuated::Punctuated;
use syn::{
    parse_macro_input, parse_quote, Expr, ExprCall, FnArg, Ident, Lit, Pat, Result,
    Signature, Stmt, Token,
};

use bums;

#[derive(Debug)]
struct CallColon {
    item_fn: Signature,
    _end_token: Token![;],
}

impl Parse for CallColon {
    fn parse(input: ParseStream) -> Result<Self> {
        return Ok(Self {
            item_fn: input.parse()?,
            _end_token: input.parse()?,
        });
    }
}

fn calculate_size_of(ty: String) -> (Option<usize>, Option<String>) {
    match ty.as_str() {
        "i8" => (Some(std::mem::size_of::<i8>()), None),
        "i16" => (Some(std::mem::size_of::<i16>()), None),
        "i32" => (Some(std::mem::size_of::<i32>()), None),
        "i64" => (Some(std::mem::size_of::<i64>()), None),
        "u8" => (Some(std::mem::size_of::<u8>()), None),
        "u16" => (Some(std::mem::size_of::<u16>()), None),
        "u32" => (Some(std::mem::size_of::<u32>()), None),
        "u64" => (Some(std::mem::size_of::<u64>()), None),
        s => {
            (None, None)
        }
    }
}

// ATTRIBUTE ON EXTERN BLOCK
#[proc_macro_attribute]
#[proc_macro_error]
pub fn check_mem_safe(attr: TokenStream, item: TokenStream) -> TokenStream {
    let vars = parse_macro_input!(item as CallColon);

    //get args from function call to pass to invocation
    let mut arguments_to_memory_safe_regions= Vec::new();
    let mut arguments_to_pass: Punctuated<_, _> = Punctuated::new();
    for i in &vars.item_fn.inputs {
        arguments_to_memory_safe_regions.push(i.clone());
        match i {
            FnArg::Typed(pat_type) => {
                match &*pat_type.pat {
                    Pat::Ident(a) => {
                        let s = a.ident.clone();
                        let mut q = Punctuated::new();
                        q.push(syn::PathSegment {
                            ident: s,
                            arguments: syn::PathArguments::None,
                        });
                        let w = Expr::Path(syn::ExprPath {
                            attrs: Vec::new(),
                            qself: None,
                            path: syn::Path {
                                leading_colon: None,
                                segments: q,
                            },
                        });
                        arguments_to_pass.push(w);
                    }
                    _ => (),
                }
                // input_names.push(a.pat)
            }
            _ => (),
        }
    }

    // extract name of function being invoked to pass to invocation
    let mut q = Punctuated::new();
    q.push(syn::PathSegment {
        ident: vars.item_fn.ident.clone(),
        arguments: syn::PathArguments::None,
    });

    let invocation: ExprCall = ExprCall {
        attrs: vec![],
        func: Box::new(Expr::Path(syn::ExprPath {
            attrs: Vec::new(),
            qself: None,
            path: syn::Path {
                leading_colon: None,
                segments: q,
            },
        })),
        paren_token: Default::default(),
        args: arguments_to_pass,
    };

    let extern_fn = vars.item_fn.clone();
    let unsafe_block: Stmt = parse_quote! {
        #extern_fn {
            extern "C" {
                #extern_fn;
            }
            unsafe {
                #invocation;
            }
        }
    };

    let token_stream = quote!(#unsafe_block).into();

    // compile file
    // make this path
    let filename = attr.to_string();
    // Command::new("gcc")
    //     .args(&[
    //         "-s",
    //         &(filename.clone() + ".s"),
    //         "-o",
    //         &(filename.clone() + ".o"),
    //     ])
    //     .output()
    //     .expect("Failed to compile assembly code");
    
    let res = File::open(filename.clone() + ".s");
    let file: File;
    match res {
        Ok(opened) => {
            file = opened;
        }
        Err(error) => {
            // make more specific span
            abort_call_site!(error);
        }
    };

    let reader = BufReader::new(file);
    let mut program = Vec::new();
    for line in reader.lines() {
        program.push(line.unwrap_or(String::from("")));
    }
    let mut engine = bums::engine::ExecutionEngine::new(program);

    // add memory safe regions
    for a in &arguments_to_memory_safe_regions {
        let mut name = String::new();
        let mut size: (Option<usize>, Option<String>) = (None, None);

        match a {
            FnArg::Typed(pat_type) => {
                match &*pat_type.pat {
                    Pat::Ident(b) => {
                        name = b.ident.clone().to_string();
                    }
                    _ => (),
                }
                match &*pat_type.ty {
                    // simple types
                    syn::Type::Path(a) => {
                        for c in &a.path.segments {
                            let res = calculate_size_of(c.ident.to_string());
                            match res {
                                (Some(_), None) | (None, Some(_)) => size = res,
                                _ => abort_call_site!("Cannot calculate size of simple type")
                            }
                        }
                    },
                    _ => println!("yet unsupported type: {:#?}", pat_type.ty),
                }
            }
            _ => (),
        }

        engine.add_region_from(name, size) // size is in bytes if number
    }

    let label = vars.item_fn.ident.to_string();
    let res = engine.start(label.clone());

    match res {
        Ok(_) => return token_stream,
        Err(error) => abort_call_site!(error),
    };
}

// FUNCTION LIKE PROC MACRO
// todo: attribute on asm call instead?

#[derive(Debug)]
struct InlineInput {
    code: Expr,
    startlabel: Expr,
}

impl Parse for InlineInput {
    fn parse(input: ParseStream) -> Result<Self> {
        let mut inputs = syn::punctuated::Punctuated::<Expr, Token![,]>::parse_terminated(input)
            .unwrap()
            .into_iter();
        let output = Self {
            code: inputs.next().unwrap(),
            startlabel: inputs.next().unwrap().clone(),
        };
        return Ok(output);
    }
}

#[derive(Debug)]
struct GlobalInput {
    filename: Expr,
    startlabel: Expr,
}

impl Parse for GlobalInput {
    fn parse(input: ParseStream) -> Result<Self> {
        let mut inputs = syn::punctuated::Punctuated::<Expr, Token![,]>::parse_terminated(input)
            .unwrap()
            .into_iter();
        let output = Self {
            filename: inputs.next().unwrap().clone(),
            startlabel: inputs.next().unwrap().clone(),
        };
        return Ok(output);
    }
}

#[proc_macro]
#[proc_macro_error]
pub fn safe_asm(input: TokenStream) -> TokenStream {
    //Parse the input as a function
    let vars = parse_macro_input!(input as InlineInput);

    let code_str = match vars.code {
        Expr::Lit(literal) => match literal.lit {
            Lit::Str(string) => string.value(),
            _ => todo!(),
        },
        _ => todo!(),
    };

    let mut program = Vec::new();
    for line in code_str.split("\n") {
        program.push(line.trim().to_string());
    }

    let mut engine = bums::engine::ExecutionEngine::new(program);

    // TODO add regions

    let label = match vars.startlabel.clone() {
        Expr::Lit(literal) => match literal.lit {
            Lit::Str(string) => string.value(),
            _ => todo!(),
        },
        _ => todo!(),
    };

    let res = engine.start(label.clone());

    match res {
        Ok(_) => {
            return quote! {
                            use std::arch::asm;
                            unsafe {
                                asm!(#code_str);
                            }
            }
            .into();
        }
        Err(error) => abort_call_site!(error),
    };
}

#[proc_macro]
#[proc_macro_error]
pub fn safe_global_asm(input: TokenStream) -> TokenStream {
    //Parse the input as a function
    let vars = parse_macro_input!(input as GlobalInput);

    let filename = match vars.filename {
        Expr::Lit(literal) => match literal.lit {
            Lit::Str(string) => string.value(),
            _ => todo!(),
        },
        _ => todo!(),
    };

    let res = File::open(filename.clone());
    let file: File;
    match res {
        Ok(opened) => {
            file = opened;
        }
        Err(error) => {
            // make more specific span
            abort_call_site!(error);
        }
    };

    let reader = BufReader::new(file);
    let mut program = Vec::new();
    for line in reader.lines() {
        program.push(line.unwrap_or(String::from("")));
    }
    let mut engine = bums::engine::ExecutionEngine::new(program);

    // TODO add regions

    let label = match vars.startlabel.clone() {
        Expr::Lit(literal) => match literal.lit {
            Lit::Str(string) => string.value(),
            _ => todo!(),
        },
        _ => todo!(),
    };

    let res = engine.start(label.clone());

    match res {
        Ok(_) => {
            let funcall = Ident::new(&label, Span::call_site().into());
            return quote! {
                            use std::arch::global_asm;
                            global_asm!(include_str!(#filename));

                            extern "C" { fn #funcall(); }
            }
            .into();
        }
        Err(error) => abort_call_site!(error),
    };
}
