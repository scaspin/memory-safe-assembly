extern crate proc_macro;
use proc_macro::TokenStream;
use proc_macro2::Span;
use proc_macro_error::{abort_call_site, proc_macro_error};
use quote::quote;
use std::fs::File;
use std::io::{BufRead, BufReader};
use syn::parse::{Parse, ParseStream};
use syn::{parse_macro_input, Expr, Ident, Lit, Result, Token};

use bums;

// ATTRIBUTE ON EXTERN BLOCK
#[proc_macro_attribute]
pub fn check_mem_safe(attr: TokenStream, item: TokenStream) -> TokenStream {
    println!("attribute: {:?}", item);
    return item
}

// FUNCTION LIKE PROC MACRO
// todo: attribute on asm call

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
            let funcall = Ident::new(&label, Span::call_site());
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
