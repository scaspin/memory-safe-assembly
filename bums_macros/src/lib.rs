extern crate proc_macro;
use proc_macro::{Span, TokenStream};
use proc_macro_error::{abort_call_site, proc_macro_error};
use quote::quote;
use std::fs::File;
use std::io::{BufRead, BufReader};
use syn::parse::{Parse, ParseStream};
use syn::punctuated::Punctuated;
use syn::{
    parse_macro_input, parse_quote, Expr, ExprCall, FnArg, Ident, Lit, Pat, Result, Signature,
    Stmt, Token, TypeArray,
};
use z3::{Config, Context};

use bums;
use bums::common::RegionType;

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

#[derive(Debug)]
struct AttributeList {
    filename: syn::LitStr,
    _separator: Option<Token![,]>,
    argument_list: Punctuated<Expr, Token![,]>,
}

impl Parse for AttributeList {
    fn parse(input: ParseStream) -> Result<Self> {
        return Ok(Self {
            filename: input.parse()?,
            _separator: input.parse()?,
            argument_list: syn::punctuated::Punctuated::<Expr, Token![,]>::parse_terminated(input)?,
        });
    }
}

fn calculate_size_of(ty: String) -> usize {
    match ty.as_str() {
        "i8" => std::mem::size_of::<i8>(),
        "i16" => std::mem::size_of::<i16>(),
        "i32" => std::mem::size_of::<i32>(),
        "i64" => std::mem::size_of::<i64>(),
        "u8" => std::mem::size_of::<u8>(),
        "u16" => std::mem::size_of::<u16>(),
        "u32" => std::mem::size_of::<u32>(),
        "u64" => std::mem::size_of::<u64>(),
        _ => 0,
    }
}

fn calculate_size_of_array(a: &TypeArray) -> usize {
    let mut elem: String = String::new();
    let mut len: usize = 0;
    match &*a.elem {
        syn::Type::Path(b) => {
            elem = b.path.segments[0].ident.to_string();
        }
        _ => (),
    }
    match &a.len {
        Expr::Lit(b) => match &b.lit {
            Lit::Int(i) => {
                len = i.token().to_string().parse::<usize>().unwrap();
            }
            _ => (),
        },
        _ => (),
    }

    return calculate_size_of(elem) * len;
}

// ATTRIBUTE ON EXTERN BLOCK
#[proc_macro_attribute]
#[proc_macro_error]
pub fn check_mem_safe(attr: TokenStream, item: TokenStream) -> TokenStream {
    let vars = parse_macro_input!(item as CallColon);
    let attributes = parse_macro_input!(attr as AttributeList);
    let fn_name = &vars.item_fn.ident;

    //get args from function call to pass to invocation
    let mut arguments_to_memory_safe_regions = Vec::new();
    let mut input_sizes = Vec::new();
    let mut arguments_to_pass: Punctuated<_, _> = Punctuated::new();
    // if caller did not specify arguments in macro, grab names from function call
    if attributes.argument_list.is_empty() {
        for i in &vars.item_fn.inputs {
            arguments_to_memory_safe_regions.push(i.clone());
            match i {
                FnArg::Typed(pat_type) => match &*pat_type.pat {
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
                },
                _ => (),
            }
        }
    } else {
        for i in &vars.item_fn.inputs {
            //input_sizes.push(i.clone());
            match i {
                FnArg::Typed(pat_type) => {
                    // get name
                    let mut name = String::new();
                    match &*pat_type.pat {
                        Pat::Ident(b) => {
                            name = b.ident.clone().to_string();
                        }
                        _ => (),
                    }
                    match &*pat_type.ty {
                        syn::Type::Array(a) => {
                            let size = calculate_size_of_array(a);
                            input_sizes.push((name, size));
                        }
                        _ => (),
                    }
                }
                _ => (),
            }
        }
        for i in &attributes.argument_list {
            arguments_to_pass.push(i.clone());
        }
    }

    // extract name of function being invoked to pass to invocation
    let mut q = Punctuated::new();
    q.push(syn::PathSegment {
        ident: fn_name.clone(),
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

    let mut extern_fn = vars.item_fn.clone();
    extern_fn.ident = fn_name.clone();
    if !attributes.argument_list.is_empty() {
        let mut new_args: Punctuated<FnArg, Token![,]> = Punctuated::new();
        for i in attributes.argument_list {
            match i {
                Expr::MethodCall(a) => {
                    let mut var_name: String = String::new();
                    let mut span = proc_macro2::Span::call_site();
                    match *a.receiver {
                        Expr::Path(a) => {
                            var_name = a.path.segments[0].ident.to_string();
                            span = a.path.segments[0].ident.span();
                        }
                        _ => (),
                    }
                    match a.method.to_string().as_str() {
                        "len" => {
                            let n = Ident::new(&(var_name + "_len"), span.into());
                            new_args.push(parse_quote! {#n: usize});
                        }
                        "as_ptr" => {
                            let n = Ident::new(&(var_name + "_as_ptr"), span.into());
                            new_args.push(parse_quote! {#n: *const u8});
                        }
                        "as_mut_ptr" => {
                            let n = Ident::new(&(var_name + "_as_mut_ptr"), span.into());
                            new_args.push(parse_quote! {#n: *mut u8});
                        }
                        _ => (),
                    };
                }
                Expr::Reference(_) => {
                    // TODO include a name in var name for uniqueness
                    new_args.push(parse_quote! {reference:u32});
                }
                _ => (),
            }
        }
        for a in &new_args {
            arguments_to_memory_safe_regions.push(a.clone());
        }
        extern_fn = parse_quote! {fn #fn_name(#new_args)};
    }

    let original_fn_call = vars.item_fn.clone();
    let unsafe_block: Stmt = parse_quote! {
        #original_fn_call {
            extern "C" {
                #extern_fn;
            }
            unsafe {
                return #invocation;
            }
        }
    };

    let token_stream = quote!(#unsafe_block).into();

    // compile file
    // make this path
    let filename = attributes.filename.value();
    let res = File::open(filename.clone());
    let file: File;
    match res {
        Ok(opened) => {
            file = opened;
        }
        Err(error) => {
            // make more specific using span
            abort_call_site!(error);
        }
    };

    let reader = BufReader::new(file);
    let mut program = Vec::new();
    for line in reader.lines() {
        program.push(line.unwrap_or(String::from("")));
    }

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

    // TODO: make sure to handle overflows into Stack
    // add memory safe regions
    for i in 0..arguments_to_memory_safe_regions.len() {
        let mut name = String::new();

        let a = &arguments_to_memory_safe_regions[i];
        match a {
            FnArg::Typed(pat_type) => {
                // get name
                match &*pat_type.pat {
                    Pat::Ident(b) => {
                        name = b.ident.clone().to_string();
                    }
                    _ => (),
                }
                //get type to get size
                match &*pat_type.ty {
                    syn::Type::Path(_) => {
                        // simple types that fit in a register?
                        // for c in &a.path.segments {
                        //      size = size + calculate_size_of(c.ident.to_string());
                        // }
                        engine.add_abstract_from(i, name.clone());
                    }
                    syn::Type::Array(a) => {
                        let size = calculate_size_of_array(a);
                        engine.add_abstract_from(i, name.clone());
                        engine.add_region_from(
                            RegionType::WRITE,
                            name.clone(),
                            (Some(size), None, None),
                        );
                        engine.add_region_from(
                            RegionType::READ,
                            name.clone(),
                            (Some(size), None, None),
                        );
                    }
                    syn::Type::Ptr(a) => {
                        // load pointer into register
                        engine.add_abstract_from(i, name.clone());

                        //derive memory safe region based on length
                        let no_mut_name = name.strip_suffix("_as_mut_ptr").unwrap_or(&name);
                        let no_suffix = no_mut_name.strip_suffix("_as_ptr").unwrap_or(no_mut_name);

                        // if pointing to an array defined as a function param, no abstract length
                        for i in &input_sizes {
                            if i.0 == no_suffix {
                                let bound = i.1;
                                engine.add_region_from(
                                    RegionType::READ,
                                    name.clone(),
                                    (Some(bound), None, None),
                                );
                                if a.mutability.is_some() {
                                    engine.add_region_from(
                                        RegionType::WRITE,
                                        name.clone(),
                                        (Some(bound), None, None),
                                    );
                                }
                            }
                        }

                        let bound = no_suffix.to_owned() + "_len";
                        engine.add_region_from(
                            RegionType::READ,
                            name.clone(),
                            (None, Some(bound.clone()), None),
                        );
                        if a.mutability.is_some() {
                            engine.add_region_from(
                                RegionType::WRITE,
                                name.clone(),
                                (None, Some(bound), None),
                            );
                        }
                    }
                    _ => println!("yet unsupported type: {:?}", pat_type.ty),
                }
            }
            _ => (),
        }
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

    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

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
    let cfg = Config::new();
    let ctx = Context::new(&cfg);
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

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
