extern crate proc_macro;
use proc_macro::TokenStream;
use quote::quote;
use std::fs::File;
use std::io::{BufRead, BufReader};
use syn::{parse_macro_input, ItemFn};

mod common;
mod computer;
mod engine;

#[proc_macro]
pub fn runtime_check(input: TokenStream) -> TokenStream {
    // Parse the input as a function
    let input_fn = parse_macro_input!(input as ItemFn);

    let res = File::open("tests/asm-examples/stack_push_pop.S");
    let mut file: File;
    match res {
        Ok(opened) => file = opened,
        Err(error) => return quote!("{}", error).into(), //compile_error!("Could not open assembly file"),
    }

    let reader = BufReader::new(file);
    let start_label = String::from("start");

    let mut program = Vec::new();
    for line in reader.lines() {
        program.push(line.unwrap_or(String::from("")));
    }
    let mut engine = engine::ExecutionEngine::new(program);

    let check_succeeded = engine.start("start".to_string()).is_ok();
    let output = if check_succeeded {
        let fn_name = &input_fn.sig.ident;
        quote! {
            #input_fn
        }
    } else {
        //syn::Error::new("hey".span(), "Assembly not memory safe").to_compile_error();
        //compile_error!("Assembly not memory safe");
        quote! {}
    };

    output.into()
}
