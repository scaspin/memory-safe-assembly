extern crate proc_macro;
use proc_macro::TokenStream;
use quote::quote;
use std::fs::File;
use std::io::{BufRead, BufReader};
use syn::parse::{Parse, ParseStream};
use syn::{parse_macro_input, Ident, Result, Token};

use bums;

#[derive(Debug)]
struct MacroInput {
    filename: Ident,
}

impl Parse for MacroInput {
    fn parse(input: ParseStream) -> Result<Self> {
        Ok(MacroInput {
            filename: input.parse()?,
        })
    }
}

#[proc_macro]
pub fn safe_asm(input: TokenStream) -> TokenStream {
    //Parse the input as a function
    let vars = parse_macro_input!(input as MacroInput);
    println!("input: {:?}", vars);

    let res = File::open("example.S");
    let mut file: File;
    match res {
        Ok(opened) => {
            println!("opened file");
            file = opened
        }
        Err(error) => {
            println!("did not open");
            println!("error: {:?}", error);
            return quote!("Could not open assembly file").into();
        }
    };

    // let reader = BufReader::new(file);
    // let start_label = String::from("start");

    // let mut program = Vec::new();
    // for line in reader.lines() {
    //     program.push(line.unwrap_or(String::from("")));
    // }
    // let mut engine = engine::ExecutionEngine::new(program);

    // let check_succeeded = engine.start("start".to_string()).is_ok();
    // let output = if check_succeeded {
    //     let fn_name = &input_fn.sig.ident;
    //     quote! {
    //         #input_fn
    //     }
    // } else {
    //     //syn::Error::new("hey".span(), "Assembly not memory safe").to_compile_error();
    //     //compile_error!("Assembly not memory safe");
    //     quote! {}
    // };

    println!("hello");
    quote!("hey").into()
}
