extern crate proc_macro;
use parse::{Parse, ParseStream};
use proc_macro::{Span, TokenStream};
#[allow(unused_imports)]
use proc_macro_error::*;
use punctuated::Punctuated;
use quote::quote;
use std::collections::HashMap;
use std::fs::File;
use std::hash::{DefaultHasher, Hash, Hasher};
use std::io::{BufRead, BufReader};
use syn::*;
use z3::{Config, Context};

use bums::common::*;

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
    filename: LitStr,
    _separator: Option<Token![,]>,
    argument_list: Punctuated<Expr, Token![,]>,
}

impl Parse for AttributeList {
    fn parse(input: ParseStream) -> Result<Self> {
        return Ok(Self {
            filename: input.parse()?,
            _separator: input.parse()?,
            argument_list: punctuated::Punctuated::<Expr, Token![,]>::parse_terminated(input)?,
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
        "u128" => std::mem::size_of::<u128>(),
        "usize" => std::mem::size_of::<u128>(),
        "isize" => std::mem::size_of::<isize>(),
        p => {
            if let Ok(v) = p.parse::<usize>() {
                return v;
            } else {
                todo!("size of undefined type")
            }
        }
    }
}

fn calculate_size_of_array(a: &TypeArray) -> usize {
    let elem: String;
    let len;
    match &*a.elem {
        Type::Path(b) => {
            elem = b.path.segments[0].ident.to_string();
        }
        _ => todo!("calculate size of array that is not given using path"),
    }
    match &a.len {
        Expr::Lit(b) => match &b.lit {
            Lit::Int(i) => {
                len = i
                    .token()
                    .to_string()
                    .parse::<usize>()
                    .expect("calculate_size_array");
            }
            _ => todo!("size of array1"),
        },
        _ => todo!("size of array2"),
    }
    return calculate_size_of(elem) * len;
}

fn calculate_type_of_array_ptr(a: &TypeArray) -> String {
    let elem: String;
    match &*a.elem {
        Type::Path(b) => {
            elem = b.path.segments[0].ident.to_string();
        }
        Type::Array(r) => {
            let inner;
            let size;
            match &*r.elem {
                Type::Path(p) => {
                    inner = p.path.segments[0].ident.to_string();
                }
                _ => todo!("calculate type of array not with path {:?}", r),
            }
            match &r.len {
                Expr::Lit(l) => match &l.lit {
                    Lit::Int(i) => size = i.to_string(),
                    _ => todo!(),
                },
                _ => todo!(),
            }
            elem = "[".to_owned() + &inner + &";" + &size + "]";
        }
        _ => todo!("calculate type of array not with path {:?}", a),
    }
    return elem;
}

fn calculate_type_of_slice_ptr(a: &TypeSlice) -> String {
    let elem: String;
    match &*a.elem {
        Type::Path(b) => {
            elem = b.path.segments[0].ident.to_string();
        }
        _ => todo!("calculate type of slice"),
    }
    return elem;
}

fn calculate_hash<T: Hash>(t: &T) -> u64 {
    let mut s = DefaultHasher::new();
    t.hash(&mut s);
    s.finish()
}

fn binary_to_abstract_expression(input: &ExprBinary) -> AbstractExpression {
    let left_expr = syn_expr_to_abstract_expression(&input.left);
    let right_expr = syn_expr_to_abstract_expression(&input.right);

    match input.op {
        BinOp::Add(_) => return generate_expression("+", left_expr, right_expr),
        BinOp::Sub(_) => return generate_expression("-", left_expr, right_expr),
        BinOp::Div(_) => return generate_expression("/", left_expr, right_expr),
        BinOp::Mul(_) => return generate_expression("*", left_expr, right_expr),
        BinOp::Rem(_) => return generate_expression("%", left_expr, right_expr),
        _ => todo!("expression binary to abstract {:?}", input.op),
    }
}

fn binary_to_abstract_comparison(input: &ExprBinary) -> AbstractComparison {
    let left_expr = syn_expr_to_abstract_expression(&input.left);
    let right_expr = syn_expr_to_abstract_expression(&input.right);

    match input.op {
        BinOp::Eq(_) => return generate_comparison("==", left_expr, right_expr),
        BinOp::Lt(_) => return generate_comparison("<", left_expr, right_expr),
        BinOp::Le(_) => return generate_comparison("<=", left_expr, right_expr),
        BinOp::Ne(_) => return generate_comparison("!=", left_expr, right_expr),
        BinOp::Ge(_) => return generate_comparison(">=", left_expr, right_expr),
        BinOp::Gt(_) => return generate_comparison(">", left_expr, right_expr),
        _ => todo!("comparison conversion"),
    }
}
fn unary_to_abstract_expression(input: &ExprUnary) -> AbstractExpression {
    let expr = syn_expr_to_abstract_expression(&input.expr);
    match input.op {
        UnOp::Not(_) => return generate_expression("!", expr, AbstractExpression::Empty),
        UnOp::Neg(_) => return generate_expression("-", expr, AbstractExpression::Empty),
        _ => todo!("unary conversion"),
    }
}

fn syn_expr_to_abstract_expression(input: &Expr) -> AbstractExpression {
    match &input {
        Expr::Lit(l) => match &l.lit {
            Lit::Str(s) => return AbstractExpression::Abstract(s.value()),
            Lit::Int(i) => {
                return AbstractExpression::Immediate(
                    i.base10_parse::<i64>().expect("undefined integer"),
                )
            }
            _ => todo!("Input Literal type"),
        },
        Expr::Binary(b) => return binary_to_abstract_expression(b),
        Expr::Unary(b) => return unary_to_abstract_expression(b),
        Expr::MethodCall(c) => {
            let mut var_name: String;
            match *c.receiver.clone() {
                Expr::Path(a) => {
                    var_name = a.path.segments[0].ident.to_string();
                }
                _ => todo!("method matching to get name"),
            }
            match c.method.to_string().as_str() {
                "len" => {
                    var_name = var_name + "_len";
                }
                "as_ptr" => {
                    var_name = var_name + "_as_ptr";
                }
                "as_mut_ptr" => {
                    var_name = var_name + "_as_mut_ptr";
                }
                _ => todo!("method matching"),
            };
            return AbstractExpression::Abstract(var_name);
        }
        Expr::Path(p) => {
            return AbstractExpression::Abstract(p.path.segments[0].ident.to_string());
        }
        Expr::Field(f) => {
            let base = match &*f.base {
                Expr::Path(p) => p.clone().path.segments[0].ident.to_string(),
                _ => todo!("field processing {:?}", f.base),
            };
            let index = match &f.member {
                Member::Named(n) => n.to_string(),
                Member::Unnamed(n) => n.index.to_string(),
            };
            let new_name = base.to_owned() + "_field" + &index;
            return AbstractExpression::Abstract(new_name);
        }
        _ => todo!("Input type {:?}", input),
    }
}

fn tuple_to_struct(name: String, tuple: TypeTuple) -> ItemStruct {
    let span = Span::call_site().into();

    // Creating fields for the struct
    let mut fields: syn::punctuated::Punctuated<Field, token::Comma> = Punctuated::new();
    for (index, expr) in tuple.elems.iter().enumerate() {
        let field_ident = syn::Ident::new(&format!("{}_field{}", name, index), span);
        let field: Field = parse_quote! {#field_ident: #expr};
        fields.push(field.clone());
    }

    let struct_name = syn::Ident::new(&(name + "_struct"), span);
    parse_quote! { #[repr(C)] struct #struct_name { #fields }}
}

// ATTRIBUTE ON EXTERN BLOCK
#[proc_macro_attribute]
#[proc_macro_error]
pub fn check_mem_safe(attr: TokenStream, item: TokenStream) -> TokenStream {
    let vars = parse_macro_input!(item as CallColon);
    let mut attributes = parse_macro_input!(attr as AttributeList);
    let fn_name = &vars.item_fn.ident;
    let output = &vars.item_fn.output;

    let mut invariants: Vec<AbstractComparison> = Vec::new();
    let mut asserts = quote! {};
    if let Some(Expr::Array(a)) = attributes.argument_list.last() {
        for e in &a.elems {
            if let Expr::Binary(b) = e {
                invariants.push(binary_to_abstract_comparison(b));
                asserts = quote! { #asserts assert!(#e);};
            } else {
                emit_call_site_error!("Cannot define an invariant that is not a binary expression");
            }
        }
        attributes.argument_list.pop();
    }

    //get args from function call to pass to invocation
    let mut arguments_to_memory_safe_regions = Vec::new();
    let mut input_sizes = HashMap::new();
    let mut pointer_sizes = HashMap::new();
    let mut input_types = HashMap::new();
    let mut input_expressions = HashMap::new();
    let mut arguments_to_pass: Punctuated<_, _> = Punctuated::new();
    let mut new_structs = HashMap::new();
    // if caller did not specify arguments in macro, grab names from function call
    if attributes.argument_list.is_empty() {
        for i in &vars.item_fn.inputs {
            arguments_to_memory_safe_regions.push(i.clone());
            match i {
                FnArg::Typed(pat_type) => match &*pat_type.pat {
                    Pat::Ident(a) => {
                        let s = a.ident.clone();
                        let mut q = Punctuated::new();
                        q.push(PathSegment {
                            ident: s,
                            arguments: PathArguments::None,
                        });
                        let w = Expr::Path(ExprPath {
                            attrs: Vec::new(),
                            qself: None,
                            path: Path {
                                leading_colon: None,
                                segments: q,
                            },
                        });
                        arguments_to_pass.push(w);
                    }
                    _ => todo!("non-ident name"),
                },
                _ => todo!("non-typed name"),
            }
        }
    } else {
        for i in &vars.item_fn.inputs {
            match i {
                FnArg::Typed(pat_type) => {
                    // get name
                    let name;
                    match &*pat_type.pat {
                        Pat::Ident(b) => {
                            name = b.ident.clone().to_string();
                        }
                        _ => todo!("non-ident typed name in inputs"),
                    }
                    let ty = &*pat_type.ty;
                    input_types.insert(name.clone(), ty);
                    match ty {
                        Type::Array(a) => {
                            let ty = calculate_type_of_array_ptr(a);
                            let size = calculate_size_of_array(a);
                            input_sizes.insert(name.clone(), size * 2);
                            pointer_sizes.insert(name, ty);
                        }
                        Type::Reference(a) => match &*a.elem {
                            Type::Array(b) => {
                                let ty = calculate_type_of_array_ptr(b);
                                let size = calculate_size_of_array(b);
                                pointer_sizes.insert(name.clone(), ty);
                                input_sizes.insert(name, size * 2);
                            }
                            Type::Slice(b) => {
                                let ty = calculate_type_of_slice_ptr(b);
                                pointer_sizes.insert(name, ty);
                            }
                            Type::Tuple(t) => {
                                let mut size = 0;
                                new_structs
                                    .insert(name.clone(), tuple_to_struct(name.clone(), t.clone()));
                                for e in &t.elems {
                                    match e {
                                        Type::Array(a) => {
                                            size = size + calculate_size_of_array(&a);
                                        }
                                        Type::Path(p) => {
                                            for i in &p.path.segments {
                                                match i.ident.to_string().as_str() {
                                                    "usize" => {
                                                        size = size + std::mem::size_of::<usize>();
                                                    }
                                                    "u32" => {
                                                        size = size + std::mem::size_of::<u32>();
                                                    }
                                                    _ => todo!("path size"),
                                                }
                                            }
                                        }
                                        _ => todo!("element list type"),
                                    }
                                }
                                input_sizes.insert(name.clone(), size);
                            }
                            _ => todo!("Input Reference Type"),
                        },
                        Type::Path(p) => {
                            let ty = p.path.segments[0].ident.to_string();
                            let size = calculate_size_of(ty);
                            input_sizes.insert(name, size * 2);
                        }
                        _ => todo!("Standard Input type {:?}", ty),
                    }
                }
                _ => todo!("Untyped args"),
            }
        }
        for i in &attributes.argument_list {
            if let Expr::Cast(c) = i {
                let struct_name;
                if let Expr::Path(p) = &*c.expr {
                    struct_name = p.path.segments[0].ident.to_string();
                } else {
                    struct_name = "struct".to_string();
                }

                let mut fields = quote! {};
                let mut i = 0;
                let struct_ident = Ident::new(&struct_name, proc_macro2::Span::call_site().into());
                for f in &new_structs
                    .get(&struct_name)
                    .expect("Need established struct")
                    .fields
                {
                    let fieldname = f.ident.clone().expect("Need field name");
                    let lit: Lit = Lit::new(proc_macro2::Literal::usize_unsuffixed(i));
                    fields = quote! { #fields #fieldname: #struct_ident.#lit, };
                    i = i + 1;
                }

                let real_struct_name = Ident::new(
                    &(struct_name + "_struct"),
                    proc_macro2::Span::call_site().into(),
                );
                arguments_to_pass
                    .push(parse_quote! {&#real_struct_name { #fields } as *const #real_struct_name})
            } else {
                arguments_to_pass.push(i.clone());
            }
        }
    }

    // extract name of function being invoked to pass to invocation
    let mut q = Punctuated::new();
    q.push(PathSegment {
        ident: fn_name.clone(),
        arguments: PathArguments::None,
    });

    let invocation: ExprCall = ExprCall {
        attrs: vec![],
        func: Box::new(Expr::Path(ExprPath {
            attrs: Vec::new(),
            qself: None,
            path: Path {
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
        let mut span = proc_macro2::Span::call_site();
        for i in attributes.argument_list {
            match i {
                Expr::MethodCall(a) => {
                    let var_name: String;
                    match *a.receiver {
                        Expr::Path(a) => {
                            var_name = a.path.segments[0].ident.to_string();
                            span = a.path.segments[0].ident.span();
                        }
                        Expr::MethodCall(a) => {
                            todo!("handle nested method calls {:?}", a)
                        }
                        _ => todo!("non-path receiver of a method call {:?}", a),
                    };
                    match a.method.to_string().as_str() {
                        "len" => {
                            let n = Ident::new(&(var_name + "_len"), span.into());
                            new_args.push(parse_quote! {#n: usize});
                        }
                        "as_ptr" => {
                            let n = Ident::new(&(var_name.clone() + "_as_ptr"), span.into());
                            if let Some(size) = pointer_sizes.get(&var_name) {
                                match size.as_str() {
                                    "u8" => new_args.push(parse_quote! {#n: *const u8}),
                                    "u16" => new_args.push(parse_quote! {#n: *const u16}),
                                    "i16" => new_args.push(parse_quote! {#n: *const i16}),
                                    "u32" => new_args.push(parse_quote! {#n: *const u32}),
                                    "u64" => new_args.push(parse_quote! {#n: *const u64}),
                                    "u128" => new_args.push(parse_quote! {#n: *const u128}),
                                    "usize" => new_args.push(parse_quote! {#n: *const usize}),
                                    _ => todo!("ptr array size 1"),
                                }
                            } else {
                                new_args.push(parse_quote! {#n: *const usize});
                            }
                        }
                        "as_mut_ptr" => {
                            let n = Ident::new(&(var_name.clone() + "_as_mut_ptr"), span.into());
                            if let Some(size) = pointer_sizes.get(&var_name) {
                                match size.as_str() {
                                    "u8" => new_args.push(parse_quote! {#n: *mut u8}),
                                    "u16" => new_args.push(parse_quote! {#n: *mut u16}),
                                    "u32" => new_args.push(parse_quote! {#n: *mut u32}),
                                    "u64" => new_args.push(parse_quote! {#n: *mut u64}),
                                    "u128" => new_args.push(parse_quote! {#n: *mut u128}),
                                    "[u64;5]" => new_args.push(parse_quote! {#n: *mut [u64;5]}), // TODO: automate
                                    "usize" => new_args.push(parse_quote! {#n: *mut usize}),
                                    _ => todo!("ptr array size 2"),
                                }
                            } else {
                                new_args.push(parse_quote! {#n: *mut usize});
                            }
                        }
                        _ => todo!("method call in new args"),
                    };
                }
                Expr::Reference(_) => {
                    // TODO include a name in var name for uniqueness
                    new_args.push(parse_quote! {_ : u32});
                }
                Expr::Path(ref a) => {
                    let var_name = a.path.segments[0].ident.to_string();
                    if let Some(ty) = input_types.get(&var_name) {
                        new_args.push(parse_quote! {#i: #ty});
                    }
                }
                Expr::Binary(ref b) => {
                    let exp = quote! {#b}.to_string();
                    let name = "expr_".to_owned() + &calculate_hash(&exp).to_string();
                    input_expressions.insert(name.clone(), i);
                    let n = Ident::new(&name, span.into());
                    new_args.push(parse_quote! {#n : usize});
                }
                Expr::Unary(ref b) => {
                    let exp = quote! {#b}.to_string();
                    let name = "expr_".to_owned() + &calculate_hash(&exp).to_string();
                    input_expressions.insert(name.clone(), i);
                    let n = Ident::new(&name, span.into());
                    new_args.push(parse_quote! {#n : isize});
                }
                Expr::Lit(ref b) => {
                    let exp = quote! {#b}.to_string();
                    let name = "expr_".to_owned() + &calculate_hash(&exp).to_string();
                    input_expressions.insert(name.clone(), i);
                    let n = Ident::new(&name, span.into());
                    new_args.push(parse_quote! {#n : usize});
                }
                Expr::Cast(c) => {
                    let var_name: String;
                    match &*c.expr {
                        Expr::Reference(r) => match &*r.expr {
                            Expr::Path(p) => {
                                var_name = p.path.segments[0].ident.to_string();
                            }
                            _ => todo!("name of cast ref expr types {:?}", r),
                        },
                        Expr::Path(p) => {
                            var_name = p.path.segments[0].ident.to_string();
                        }
                        _ => todo!("name of cast expr types {:?}", c.expr),
                    }

                    let n = Ident::new(&(var_name.clone() + "_as_mut_ptr"), span.into());
                    let ty = c.ty.clone();
                    if let Type::Ptr(p) = *ty.clone() {
                        if let Type::Infer(_) = *p.elem {
                            let struct_name =
                                Ident::new(&(var_name.clone() + "_struct"), span.into());
                            new_args.push(parse_quote! {#n : *const #struct_name});
                        } else {
                            new_args.push(parse_quote! {#n : #ty});
                        }
                    } else {
                        new_args.push(parse_quote! {#n : #ty});
                    }
                }
                Expr::Field(f) => {
                    let var_name: String;
                    match &*f.base {
                        Expr::Path(p) => {
                            var_name = p.path.segments[0].ident.to_string();
                        }
                        Expr::MethodCall(m) => {
                            match &*m.receiver {
                                Expr::Path(a) => {
                                    var_name = a.path.segments[0].ident.to_string();
                                    span = a.path.segments[0].ident.span();
                                }
                                Expr::MethodCall(a) => {
                                    todo!("handle nested method calls {:?}", a)
                                }
                                _ => todo!("non-path receiver of a method call {:?}", m),
                            };
                        }
                        _ => todo!("name of field expr types {:?}", f.base),
                    }
                    match *f.base {
                        Expr::MethodCall(ref m) => match m.method.to_string().as_str() {
                            "as_ptr_range" => {
                                let pointer_size = pointer_sizes
                                    .get(&var_name)
                                    .expect("can't find size of  slice");
                                let pointer_type = Ident::new(&pointer_size.clone(), span.into());
                                match f.member {
                                    syn::Member::Named(name) => match name.to_string().as_str() {
                                        "end" => {
                                            let n = Ident::new(
                                                &(var_name.clone() + "_end_ptr_range"),
                                                span.into(),
                                            );
                                            new_args.push(parse_quote! {#n : *const #pointer_type});
                                        }
                                        _ => todo!("more subfields of range"),
                                    },
                                    syn::Member::Unnamed(i) => match i.index {
                                        0 => {
                                            let n = Ident::new(
                                                &(var_name.clone() + "_start_ptr_range"),
                                                span.into(),
                                            );
                                            new_args.push(parse_quote! {#n : _});
                                        }
                                        1 => {
                                            let n = Ident::new(
                                                &(var_name.clone() + "_end_ptr_range"),
                                                span.into(),
                                            );
                                            new_args.push(parse_quote! {#n : _});
                                        }
                                        _ => todo!("irrelevant for this type"),
                                    },
                                }
                            }
                            _ => todo!("match on fields of the results of more methods"),
                        },
                        _ => todo!("match on fields of more methods"),
                    }
                }
                _ => todo!("Arg list type {:?}", i),
            }
        }
        for a in &new_args {
            arguments_to_memory_safe_regions.push(a.clone());
        }
        extern_fn = parse_quote! {fn #fn_name(#new_args)};
    }

    let mut struct_decs = quote! {};
    for i in new_structs.values() {
        struct_decs = quote! {

            #struct_decs

            #i;
        };
    }

    let original_fn_call = vars.item_fn.clone();
    let unsafe_block: Stmt = parse_quote! {
        #original_fn_call {

            #asserts;

            #struct_decs;

            extern "C" {
                #extern_fn #output;
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
    let assembly_file: std::path::PathBuf =
        [std::env::var("OUT_DIR").expect("OUT_DIR"), filename.clone()]
            .iter()
            .collect();
    let res = File::open(assembly_file);
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

    // add memory safe regions
    for i in 0..arguments_to_memory_safe_regions.len() {
        let name;

        let a = &arguments_to_memory_safe_regions[i];
        match a {
            FnArg::Typed(pat_type) => {
                // get name
                match &*pat_type.pat {
                    Pat::Ident(b) => {
                        name = b.ident.clone().to_string();
                    }
                    Pat::Lit(l) => match &l.lit {
                        Lit::Str(s) => name = s.value(),
                        Lit::Int(i) => name = i.base10_digits().to_string(),
                        _ => todo!("Regions literal pattern {:?}", l),
                    },
                    _ => todo!("Regions pattern pattern"),
                }
                //get type to get size
                match &*pat_type.ty {
                    Type::Path(_) => {
                        if let Some(binary) = input_expressions.get(&name).clone() {
                            match binary {
                                Expr::Binary(b) => {
                                    engine.add_abstract_expression_from(
                                        i,
                                        binary_to_abstract_expression(&b),
                                    );
                                }
                                _ => {
                                    engine.add_abstract_expression_from(
                                        i,
                                        syn_expr_to_abstract_expression(binary),
                                    );
                                }
                            }
                        } else {
                            engine.add_abstract_from(i, name.clone());
                        }
                    }
                    Type::Array(a) => {
                        let size = calculate_size_of_array(a);
                        engine.add_abstract_from(i, name.clone());
                        engine.add_region(
                            RegionType::RW,
                            name.clone(),
                            AbstractExpression::Immediate(size as i64),
                        );
                    }
                    Type::Ptr(a) => {
                        // load pointer into register
                        engine.add_abstract_from(i, name.clone());

                        //derive memory safe region based on length
                        let no_mut_name = name.strip_suffix("_as_mut_ptr").unwrap_or(&name);
                        let no_range = name.strip_suffix("_end_ptr_range").unwrap_or(&no_mut_name);
                        let no_suffix = no_range.strip_suffix("_as_ptr").unwrap_or(no_range);

                        match &*a.elem {
                            Type::Path(p) => {
                                // if pointer to a macro-defined struct
                                if p.path.segments[0].ident.to_string().contains("struct") {
                                    // add the whole region covered by the tuple
                                    if let Some(bound) = input_sizes.get(no_suffix) {
                                        if a.mutability.is_some() {
                                            engine.add_region(
                                                RegionType::WRITE,
                                                name.clone(),
                                                AbstractExpression::Immediate(*bound as i64),
                                            );
                                        } else {
                                            engine.add_region(
                                                RegionType::READ,
                                                name.clone(),
                                                AbstractExpression::Immediate(bound.clone() as i64),
                                            );
                                        }
                                    }

                                    let s = new_structs
                                        .get(no_suffix)
                                        .expect("Need well defined struct");
                                    let mut i = 0;
                                    let mut index = 0;
                                    for e in &s.fields {
                                        match e.ty.clone() {
                                            Type::Path(p) => {
                                                if p.path.segments.len() == 1 {
                                                    let abs = p.path.segments[0].ident.to_string();
                                                    match abs.as_str() {
                                                        "usize" => {
                                                            let new_name = e.ident.clone().expect(
                                                                "need name of variable to input",
                                                            );
                                                            engine.add_abstract_to_memory(
                                                                name.clone(),
                                                                index,
                                                                AbstractExpression::Abstract(
                                                                    new_name.to_string(),
                                                                ),
                                                            );
                                                        }
                                                        "u32" => {
                                                            let new_name = e.ident.clone().expect(
                                                                "need name of variable to input",
                                                            );
                                                            engine.add_abstract_to_memory(
                                                                name.clone(),
                                                                index,
                                                                AbstractExpression::Abstract(
                                                                    new_name.to_string(),
                                                                ),
                                                            );
                                                        }
                                                        _ => todo!("tuple abstracts"),
                                                    }
                                                }
                                            }
                                            Type::Array(a) => {
                                                if let Some(_) = input_sizes.get(no_suffix) {
                                                    index = index
                                                        + ((calculate_size_of_array(&a)) as i64);
                                                }
                                            }
                                            _ => todo!("unsupported tuple type {:?}", e),
                                        }
                                        i = i + 1;
                                    }
                                    continue;
                                }

                                // if pointing to end of array
                                if name.contains("_end_ptr_range") {
                                    // add the whole region covered by the tuple
                                    let bound = no_suffix.to_owned() + "_len";
                                    let pointer_name = no_suffix.to_owned() + "_as_ptr";

                                    engine.add_region(
                                        RegionType::READ,
                                        pointer_name.clone(),
                                        AbstractExpression::Abstract(bound.clone()),
                                    );

                                    //overwrite
                                    engine.add_abstract_expression_from(
                                        i,
                                        generate_expression(
                                            "+",
                                            AbstractExpression::Abstract(pointer_name),
                                            AbstractExpression::Abstract(bound),
                                        ),
                                    );

                                    continue;
                                }

                                // if pointing to an array defined as a function param, no abstract length
                                if let Some(bound) = input_sizes.get(no_suffix) {
                                    if a.mutability.is_some() {
                                        engine.add_region(
                                            RegionType::WRITE,
                                            name.clone(),
                                            AbstractExpression::Immediate(*bound as i64),
                                        );
                                    } else {
                                        engine.add_region(
                                            RegionType::READ,
                                            name.clone(),
                                            AbstractExpression::Immediate(bound.clone() as i64),
                                        );
                                    }
                                    continue;
                                }

                                let bound = no_suffix.to_owned() + "_len";
                                if a.mutability.is_some() {
                                    engine.add_region(
                                        RegionType::WRITE,
                                        name.clone(),
                                        AbstractExpression::Abstract(bound),
                                    );
                                } else {
                                    engine.add_region(
                                        RegionType::READ,
                                        name.clone(),
                                        AbstractExpression::Abstract(bound),
                                    );
                                }
                            }
                            _ => todo!("unsupported pointer type to pass to asm {:?}", a.elem),
                        }
                    }
                    _ => todo!("yet unsupported type: {:?}", pat_type.ty),
                }
            }
            _ => todo!("lib"),
        }
    }

    for i in invariants {
        engine.add_invariant(i);
    }
    let label = vars.item_fn.ident.to_string();
    let res = engine.start(label);

    match res {
        Ok(_) => return token_stream,
        Err(error) => {
            #[cfg(not(debug_assertions))]
            emit_call_site_error!(error);

            #[cfg(debug_assertions)]
            emit_call_site_warning!(error);
            return token_stream;
        }
    };
}
