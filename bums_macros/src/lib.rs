extern crate proc_macro;
use proc_macro::TokenStream;
use proc_macro_error::{abort_call_site, proc_macro_error};
use quote::quote;
use std::fs::File;
use std::io::{BufRead, BufReader};
use syn::parse::{Parse, ParseStream};
use syn::{parse_macro_input,Expr, Lit, Result};

use bums;

#[derive(Debug)]
struct MacroInput {
    filename: String,
}

impl Parse for MacroInput {
    fn parse(input: ParseStream) -> Result<Self> {
        let expr = input.parse()?;
        // filename should be a string literal or a reference to a literal
        match expr {
            Expr::Lit(literal) => {
                let value = literal.lit;
                match value {
                    Lit::Str(literal_string) => Ok(MacroInput {
                        filename: literal_string.value(),
                    }),
                    _ => todo!(),
                }
            }
            _ => todo!(),
        }
    }
}

#[proc_macro]
#[proc_macro_error]
pub fn safe_asm(input: TokenStream) -> TokenStream {
    //Parse the input as a function
    let vars = parse_macro_input!(input as MacroInput);

    let res = File::open(vars.filename);
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

    let res = engine.start("start".to_string());
    match res {
        Ok(_) => {
            return quote! {
                asm!(input);
            }
            .into()
        }
        Err(error) => abort_call_site!(error),
    };
}
