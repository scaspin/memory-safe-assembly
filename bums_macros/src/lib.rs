extern crate proc_macro;
use proc_macro::TokenStream;
use proc_macro2::Literal;
use proc_macro_error::{abort_call_site, proc_macro_error};
use quote::quote;
use std::fs::File;
use std::io::{BufRead, BufReader};
use syn::parse::{Parse, Parser, ParseStream};
use syn::{parse_macro_input, Expr, Lit, Result, Token};

use bums;

#[derive(Debug)]
struct MacroInput {
    filename: Expr,
    startlabel: Expr,
}

impl Parse for MacroInput {
    fn parse(input: ParseStream) -> Result<Self> {
        // let mut filename = String::new();
        // let expr_filename = input.parse()?;
        // // filename should be a string literal or a reference to a literal
        // match expr_filename {
        //     Expr::Lit(literal) => match literal.lit {
        //         Lit::Str(string) => {
        //             filename = string.value();
        //         }
        //         _ => todo!(),
        //     },
        //     _ => todo!(),
        // }

        // let comma = input.parse()?;

        // let mut startlabel = String::new();
        // let expr_start = input.parse()?;
        // match expr_start {
        //     Expr::Lit(literal) => match literal.lit {
        //         Lit::Str(string) => {
        //             startlabel = string.value();
        //         }
        //         _ => todo!(),
        //     },
        //     _ => todo!(),
        // };
        
        let mut inputs = syn::punctuated::Punctuated::<Expr, Token![,]>::parse_terminated(input)
            .unwrap().into_iter();
        let output = MacroInput {
            filename: inputs.next().unwrap().clone(),
            startlabel: inputs.next().unwrap().clone(),
        };
        return Ok(output);
    }
}

#[proc_macro]
#[proc_macro_error]
pub fn safe_global_asm(input: TokenStream) -> TokenStream {
    //Parse the input as a function
    let vars = parse_macro_input!(input as MacroInput);

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
            return quote! {
                            use std::arch::asm;
                            global_asm!(include_str!(#filename));

                            extern "C" {
                                fn #label();
                            }
            }
            .into();
        }
        Err(error) => abort_call_site!(error),
    };
}
