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

use bums::common::*;

#[derive(Debug)]
struct CallColon {
    item_fn: Signature,
    _end_token: Token![;],
}

impl Parse for CallColon {
    fn parse(input: ParseStream) -> Result<Self> {
        Ok(Self {
            item_fn: input.parse()?,
            _end_token: input.parse()?,
        })
    }
}

#[derive(Debug)]
struct AttributeList {
    filename: LitStr,
    _separator: Option<Token![,]>,
    red_zone: Option<LitInt>,
    argument_list: Punctuated<Expr, Token![,]>,
}

fn parse_red_zone(input: ParseStream) -> Result<Option<LitInt>> {
    let names_red_zone = input
        .fork()
        .parse::<Ident>()
        .is_ok_and(|name| name == "red_zone");
    if !(names_red_zone && input.peek2(Token![=])) {
        return Ok(None);
    }
    input.parse::<Ident>()?;
    input.parse::<Token![=]>()?;
    let bytes = input.parse()?;
    input.parse::<Option<Token![,]>>()?;
    Ok(Some(bytes))
}

impl Parse for AttributeList {
    fn parse(input: ParseStream) -> Result<Self> {
        Ok(Self {
            filename: input.parse()?,
            _separator: input.parse()?,
            red_zone: parse_red_zone(input)?,
            argument_list: punctuated::Punctuated::<Expr, Token![,]>::parse_terminated(input)?,
        })
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
        "usize" => std::mem::size_of::<usize>(),
        "isize" => std::mem::size_of::<isize>(),
        p => {
            if let Ok(v) = p.parse::<usize>() {
                v
            } else {
                todo!("size of undefined type")
            }
        }
    }
}

fn byte_length(bound: &str, element_type: Option<&String>) -> AbstractExpression {
    let elements = AbstractExpression::Abstract(bound.to_string());
    match element_type {
        Some(ty) => generate_expression(
            "*",
            elements,
            AbstractExpression::Immediate(calculate_size_of(ty.clone()) as i64),
        ),
        None => elements,
    }
}

fn calculate_size_of_array(a: &TypeArray) -> usize {
    let elem = match &*a.elem {
        Type::Path(b) => b.path.segments[0].ident.to_string(),
        _ => todo!("calculate size of array that is not given using path"),
    };
    let len = match &a.len {
        Expr::Lit(b) => match &b.lit {
            Lit::Int(i) => i
                .token()
                .to_string()
                .parse::<usize>()
                .expect("calculate_size_array"),
            _ => todo!("size of array1"),
        },
        _ => todo!("size of array2"),
    };
    calculate_size_of(elem) * len
}

fn calculate_type_of_array_ptr(a: &TypeArray) -> String {
    match &*a.elem {
        Type::Path(b) => b.path.segments[0].ident.to_string(),
        Type::Array(r) => {
            let inner = match &*r.elem {
                Type::Path(p) => p.path.segments[0].ident.to_string(),
                _ => todo!("calculate type of array not with path {:?}", r),
            };
            let size = match &r.len {
                Expr::Lit(l) => match &l.lit {
                    Lit::Int(i) => i.to_string(),
                    _ => todo!(),
                },
                _ => todo!(),
            };
            "[".to_owned() + &inner + ";" + &size + "]"
        }
        _ => todo!("calculate type of array not with path {:?}", a),
    }
}

fn calculate_type_of_slice_ptr(a: &TypeSlice) -> String {
    match &*a.elem {
        Type::Path(b) => b.path.segments[0].ident.to_string(),
        _ => todo!("calculate type of slice"),
    }
}

fn field_layout(ty: &Type) -> (usize, usize) {
    match ty {
        Type::Path(p) => {
            let size = calculate_size_of(p.path.segments[0].ident.to_string());
            (size, size)
        }
        Type::Ptr(_) => (std::mem::size_of::<usize>(), std::mem::align_of::<usize>()),
        Type::Array(a) => (calculate_size_of_array(a), field_layout(&a.elem).1),
        _ => todo!("layout of tuple field {:?}", ty),
    }
}

fn tuple_layout<'a>(fields: impl Iterator<Item = &'a Type>) -> (Vec<usize>, usize) {
    let mut offsets = Vec::new();
    let mut end: usize = 0;
    let mut widest: usize = 1;
    for ty in fields {
        let (size, align) = field_layout(ty);
        let start = end.next_multiple_of(align);
        offsets.push(start);
        end = start + size;
        widest = widest.max(align);
    }
    (offsets, end.next_multiple_of(widest))
}

fn calculate_hash<T: Hash>(t: &T) -> u64 {
    let mut s = DefaultHasher::new();
    t.hash(&mut s);
    s.finish()
}

fn passed_pointer(
    parameter: &str,
    arguments: &Punctuated<Expr, Token![,]>,
) -> Option<(&'static str, bool)> {
    for argument in arguments {
        let Expr::MethodCall(call) = argument else {
            continue;
        };
        let (call, receiver) = match &*call.receiver {
            Expr::MethodCall(inner) => (inner, &inner.receiver),
            _ => (call, &call.receiver),
        };
        let Expr::Path(path) = &**receiver else {
            continue;
        };
        if path.path.segments[0].ident != parameter {
            continue;
        }
        match call.method.to_string().as_str() {
            "as_mut_ptr" => return Some(("_as_mut_ptr", true)),
            "as_ptr" => return Some(("_as_ptr", false)),
            _ => (),
        }
    }
    None
}

fn indexed_element(input: &ExprBinary) -> Option<(String, i64)> {
    if !matches!(input.op, BinOp::Eq(_)) {
        return None;
    }
    let Expr::Index(indexed) = &*input.left else {
        return None;
    };
    let Expr::Path(path) = &*indexed.expr else {
        return None;
    };
    let Expr::Lit(literal) = &*indexed.index else {
        return None;
    };
    let Lit::Int(element) = &literal.lit else {
        return None;
    };
    Some((
        path.path.segments[0].ident.to_string(),
        element.base10_parse::<i64>().ok()?,
    ))
}

fn constant_index(e: &Expr) -> Option<i64> {
    match e {
        Expr::Lit(l) => match &l.lit {
            Lit::Int(i) => i.base10_parse::<i64>().ok(),
            _ => None,
        },
        Expr::Paren(p) => constant_index(&p.expr),
        Expr::Unary(u) if matches!(u.op, syn::UnOp::Neg(_)) => constant_index(&u.expr).map(|v| -v),
        Expr::Binary(b) => {
            let (l, r) = (constant_index(&b.left)?, constant_index(&b.right)?);
            match b.op {
                BinOp::Add(_) => l.checked_add(r),
                BinOp::Sub(_) => l.checked_sub(r),
                BinOp::Mul(_) => l.checked_mul(r),
                _ => None,
            }
        }
        _ => None,
    }
}

fn element_bound(input: &ExprBinary) -> Option<(String, i64)> {
    if !matches!(
        input.op,
        BinOp::Eq(_) | BinOp::Ne(_) | BinOp::Lt(_) | BinOp::Le(_) | BinOp::Gt(_) | BinOp::Ge(_)
    ) {
        return None;
    }
    let Expr::Index(indexed) = &*input.left else {
        return None;
    };
    let Expr::Path(path) = &*indexed.expr else {
        return None;
    };
    let index = match constant_index(&indexed.index) {
        Some(index) => index,
        None => {
            emit_call_site_error!(
                "an element precondition needs a literal index: a proc macro runs \
                 before const evaluation, so a named constant cannot be resolved here"
            );
            return None;
        }
    };
    Some((path.path.segments[0].ident.to_string(), index))
}

fn pointer_contents(
    input: &ExprBinary,
    arguments: &Punctuated<Expr, Token![,]>,
) -> Option<(String, i64, String, &'static str, Option<(bool, Expr)>)> {
    let (array, element) = indexed_element(input)?;
    let (array_suffix, _) = passed_pointer(&array, arguments)?;

    let (call, step) = match &*input.right {
        Expr::MethodCall(call)
            if matches!(call.method.to_string().as_str(), "add" | "byte_add") =>
        {
            let Expr::MethodCall(inner) = &*call.receiver else {
                return None;
            };
            (
                inner,
                Some((call.method == "add", call.args.first()?.clone())),
            )
        }
        Expr::MethodCall(call) => (call, None),
        _ => return None,
    };
    let Expr::Path(slice) = &*call.receiver else {
        return None;
    };
    let suffix = match call.method.to_string().as_str() {
        "as_mut_ptr" => "_as_mut_ptr",
        "as_ptr" => "_as_ptr",
        _ => return None,
    };

    Some((
        format!("{}{}", array, array_suffix),
        element * 8,
        slice.path.segments[0].ident.to_string(),
        suffix,
        step,
    ))
}

fn binary_to_abstract_expression(input: &ExprBinary) -> AbstractExpression {
    let left_expr = syn_expr_to_abstract_expression(&input.left);
    let right_expr = syn_expr_to_abstract_expression(&input.right);

    match input.op {
        BinOp::Add(_) => generate_expression("+", left_expr, right_expr),
        BinOp::Sub(_) => generate_expression("-", left_expr, right_expr),
        BinOp::Div(_) => generate_expression("/", left_expr, right_expr),
        BinOp::Mul(_) => generate_expression("*", left_expr, right_expr),
        BinOp::Rem(_) => generate_expression("%", left_expr, right_expr),
        _ => todo!("expression binary to abstract {:?}", input.op),
    }
}

fn operator_of(op: &BinOp) -> &'static str {
    match op {
        BinOp::Eq(_) => "==",
        BinOp::Lt(_) => "<",
        BinOp::Le(_) => "<=",
        BinOp::Ne(_) => "!=",
        BinOp::Ge(_) => ">=",
        BinOp::Gt(_) => ">",
        _ => todo!("comparison conversion"),
    }
}

fn binary_to_abstract_comparison(input: &ExprBinary) -> AbstractComparison {
    let left_expr = syn_expr_to_abstract_expression(&input.left);
    let right_expr = syn_expr_to_abstract_expression(&input.right);

    match input.op {
        BinOp::Eq(_) => generate_comparison("==", left_expr, right_expr),
        BinOp::Lt(_) => generate_comparison("<", left_expr, right_expr),
        BinOp::Le(_) => generate_comparison("<=", left_expr, right_expr),
        BinOp::Ne(_) => generate_comparison("!=", left_expr, right_expr),
        BinOp::Ge(_) => generate_comparison(">=", left_expr, right_expr),
        BinOp::Gt(_) => generate_comparison(">", left_expr, right_expr),
        _ => todo!("comparison conversion"),
    }
}
fn unary_to_abstract_expression(input: &ExprUnary) -> AbstractExpression {
    let expr = syn_expr_to_abstract_expression(&input.expr);
    match input.op {
        UnOp::Not(_) => generate_expression("!", expr, AbstractExpression::Empty),
        UnOp::Neg(_) => generate_expression("-", expr, AbstractExpression::Empty),
        _ => todo!("unary conversion"),
    }
}

fn syn_expr_to_abstract_expression(input: &Expr) -> AbstractExpression {
    match &input {
        Expr::Lit(l) => match &l.lit {
            Lit::Str(s) => AbstractExpression::Abstract(s.value()),
            Lit::Int(i) => {
                AbstractExpression::Immediate(i.base10_parse::<i64>().expect("undefined integer"))
            }
            _ => todo!("Input Literal type"),
        },
        Expr::Binary(b) => binary_to_abstract_expression(b),
        Expr::Unary(b) => unary_to_abstract_expression(b),
        Expr::Paren(p) => syn_expr_to_abstract_expression(&p.expr),
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
                    var_name += "_len";
                }
                "as_ptr" => {
                    var_name += "_as_ptr";
                }
                "as_mut_ptr" => {
                    var_name += "_as_mut_ptr";
                }
                _ => todo!("method matching"),
            };
            AbstractExpression::Abstract(var_name)
        }
        Expr::Path(p) => AbstractExpression::Abstract(p.path.segments[0].ident.to_string()),
        Expr::Cast(c) => syn_expr_to_abstract_expression(&c.expr),
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
            AbstractExpression::Abstract(new_name)
        }
        _ => todo!("Input type {:?}", input),
    }
}

fn tuple_to_struct(name: String, tuple: TypeTuple) -> ItemStruct {
    let span = Span::call_site().into();

    let mut fields: syn::punctuated::Punctuated<Field, token::Comma> = Punctuated::new();
    for (index, expr) in tuple.elems.iter().enumerate() {
        let field_ident = syn::Ident::new(&format!("{}_field{}", name, index), span);
        let field: Field = parse_quote! {#field_ident: #expr};
        fields.push(field.clone());
    }

    let struct_name = syn::Ident::new(&(name + "_struct"), span);
    parse_quote! { #[repr(C)] struct #struct_name { #fields }}
}

#[proc_macro_attribute]
#[proc_macro_error]
pub fn check_mem_safe(attr: TokenStream, item: TokenStream) -> TokenStream {
    let vars = parse_macro_input!(item as CallColon);
    let mut attributes = parse_macro_input!(attr as AttributeList);
    let fn_name = &vars.item_fn.ident;
    let output = &vars.item_fn.output;

    let mut invariants: Vec<AbstractComparison> = Vec::new();
    let mut element_bounds: Vec<(String, i64, ExprBinary)> = Vec::new();
    let mut pointer_values: Vec<(String, i64, String, &'static str, Option<(bool, Expr)>)> =
        Vec::new();
    let mut asserts = quote! {};
    let argument_list = attributes.argument_list.clone();
    if let Some(Expr::Array(a)) = argument_list.last() {
        for e in &a.elems {
            if let Expr::Binary(b) = e {
                if let Some(value) = pointer_contents(b, &attributes.argument_list) {
                    let stored = &*b.left;
                    let source = match &*b.right {
                        Expr::MethodCall(call) if call.method == "add" => {
                            let mut call = call.clone();
                            call.method = Ident::new("wrapping_add", call.method.span());
                            Expr::MethodCall(call)
                        }
                        Expr::MethodCall(call) if call.method == "byte_add" => {
                            let mut call = call.clone();
                            call.method = Ident::new("wrapping_byte_add", call.method.span());
                            Expr::MethodCall(call)
                        }
                        other => other.clone(),
                    };
                    asserts = quote! { #asserts assert!(#stored == #source as usize); };
                    pointer_values.push(value);
                    continue;
                }
                if let Some((array, index)) = element_bound(b) {
                    element_bounds.push((array, index, b.clone()));
                    asserts = quote! { #asserts assert!(#e);};
                    continue;
                }
                invariants.push(binary_to_abstract_comparison(b));
                asserts = quote! { #asserts assert!(#e);};
            } else {
                emit_call_site_error!("Cannot define an invariant that is not a binary expression");
            }
        }
        attributes.argument_list.pop();
    }

    let mut arguments_to_memory_safe_regions = Vec::new();
    let mut input_sizes = HashMap::new();
    let mut pointer_sizes = HashMap::new();
    let mut input_types = HashMap::new();
    let mut input_expressions = HashMap::new();
    let mut arguments_to_pass: Punctuated<_, _> = Punctuated::new();
    let mut new_structs = HashMap::new();
    let mut before_call = quote! {};
    let mut after_call = quote! {};
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
                    let name = match &*pat_type.pat {
                        Pat::Ident(b) => b.ident.clone().to_string(),
                        _ => todo!("non-ident typed name in inputs"),
                    };
                    let ty = &*pat_type.ty;
                    input_types.insert(name.clone(), ty);
                    match ty {
                        Type::Array(a) => {
                            let ty = calculate_type_of_array_ptr(a);
                            let size = calculate_size_of_array(a);
                            input_sizes.insert(name.clone(), size);
                            pointer_sizes.insert(name, ty);
                        }
                        Type::Reference(a) => match &*a.elem {
                            Type::Array(b) => {
                                let ty = calculate_type_of_array_ptr(b);
                                let size = calculate_size_of_array(b);
                                pointer_sizes.insert(name.clone(), ty);
                                input_sizes.insert(name, size);
                            }
                            Type::Slice(b) => {
                                let ty = calculate_type_of_slice_ptr(b);
                                pointer_sizes.insert(name, ty);
                            }
                            Type::Tuple(t) => {
                                new_structs
                                    .insert(name.clone(), tuple_to_struct(name.clone(), t.clone()));
                                let (_, size) = tuple_layout(t.elems.iter());
                                input_sizes.insert(name.clone(), size);
                            }
                            _ => todo!("Input Reference Type"),
                        },
                        Type::Path(p) => {
                            let ty = p.path.segments[0].ident.to_string();
                            let size = calculate_size_of(ty);
                            input_sizes.insert(name, size);
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
                let mut copied_back = quote! {};
                let struct_ident = Ident::new(&struct_name, proc_macro2::Span::call_site());
                let scratch = Ident::new(
                    &(struct_name.clone() + "_scratch"),
                    proc_macro2::Span::call_site(),
                );
                for (i, f) in new_structs
                    .get(&struct_name)
                    .expect("Need established struct")
                    .fields
                    .iter()
                    .enumerate()
                {
                    let fieldname = f.ident.clone().expect("Need field name");
                    let lit: Lit = Lit::new(proc_macro2::Literal::usize_unsuffixed(i));
                    fields = quote! { #fields #fieldname: #struct_ident.#lit, };
                    copied_back = quote! { #copied_back #struct_ident.#lit = #scratch.#fieldname; };
                }

                let real_struct_name =
                    Ident::new(&(struct_name + "_struct"), proc_macro2::Span::call_site());
                let mutable = matches!(&*c.ty, Type::Ptr(p) if p.mutability.is_some());
                if mutable {
                    before_call = quote! {
                        #before_call
                        let mut #scratch = #real_struct_name { #fields };
                    };
                    after_call = quote! { #after_call #copied_back };
                    arguments_to_pass.push(parse_quote! {&mut #scratch as *mut #real_struct_name})
                } else {
                    arguments_to_pass.push(
                        parse_quote! {&#real_struct_name { #fields } as *const #real_struct_name},
                    )
                }
            } else {
                arguments_to_pass.push(i.clone());
            }
        }
    }

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
    let mut pointer_offsets: HashMap<String, (bool, Expr)> = HashMap::new();
    if !attributes.argument_list.is_empty() {
        let mut new_args: Punctuated<FnArg, Token![,]> = Punctuated::new();
        let mut span = proc_macro2::Span::call_site();
        for original in attributes.argument_list {
            let mut offset = None;
            let i = match original {
                Expr::MethodCall(ref call)
                    if matches!(call.method.to_string().as_str(), "add" | "byte_add")
                        && matches!(&*call.receiver, Expr::MethodCall(_)) =>
                {
                    offset = Some((
                        call.method == "add",
                        call.args
                            .first()
                            .expect("advancing a pointer needs an offset")
                            .clone(),
                    ));
                    (*call.receiver).clone()
                }
                other => other,
            };
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
                    if let Some((scaled, expression)) = offset.take() {
                        if scaled {
                            let buffer = Ident::new(&var_name, span);
                            asserts = quote! { #asserts assert!(#expression <= #buffer.len()); };
                        }
                        pointer_offsets.insert(var_name.clone(), (scaled, expression));
                    }
                    match a.method.to_string().as_str() {
                        "len" => {
                            let n = Ident::new(&(var_name + "_len"), span);
                            new_args.push(parse_quote! {#n: usize});
                        }
                        "as_ptr" => {
                            let n = Ident::new(&(var_name.clone() + "_as_ptr"), span);
                            if let Some(size) = pointer_sizes.get(&var_name) {
                                let element: Type =
                                    syn::parse_str(size).expect("pointer element type");
                                new_args.push(parse_quote! {#n: *const #element});
                            } else {
                                new_args.push(parse_quote! {#n: *const usize});
                            }
                        }
                        "as_mut_ptr" => {
                            let n = Ident::new(&(var_name.clone() + "_as_mut_ptr"), span);
                            if let Some(size) = pointer_sizes.get(&var_name) {
                                let element: Type =
                                    syn::parse_str(size).expect("pointer element type");
                                new_args.push(parse_quote! {#n: *mut #element});
                            } else {
                                new_args.push(parse_quote! {#n: *mut usize});
                            }
                        }
                        _ => todo!("method call in new args"),
                    };
                }
                Expr::Reference(_) => {
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
                    let n = Ident::new(&name, span);
                    new_args.push(parse_quote! {#n : usize});
                }
                Expr::Unary(ref b) => {
                    let exp = quote! {#b}.to_string();
                    let name = "expr_".to_owned() + &calculate_hash(&exp).to_string();
                    input_expressions.insert(name.clone(), i);
                    let n = Ident::new(&name, span);
                    new_args.push(parse_quote! {#n : isize});
                }
                Expr::Lit(ref b) => {
                    let exp = quote! {#b}.to_string();
                    let name = "expr_".to_owned() + &calculate_hash(&exp).to_string();
                    input_expressions.insert(name.clone(), i);
                    let n = Ident::new(&name, span);
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

                    let n = Ident::new(&(var_name.clone() + "_as_mut_ptr"), span);
                    let ty = c.ty.clone();
                    if let Type::Ptr(p) = *ty.clone() {
                        if let Type::Infer(_) = *p.elem {
                            let struct_name = Ident::new(&(var_name.clone() + "_struct"), span);
                            if p.mutability.is_some() {
                                new_args.push(parse_quote! {#n : *mut #struct_name});
                            } else {
                                new_args.push(parse_quote! {#n : *const #struct_name});
                            }
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
                                let pointer_type = Ident::new(&pointer_size.clone(), span);
                                match f.member {
                                    syn::Member::Named(name) => match name.to_string().as_str() {
                                        "end" => {
                                            let n = Ident::new(
                                                &(var_name.clone() + "_end_ptr_range"),
                                                span,
                                            );
                                            new_args.push(parse_quote! {#n : *const #pointer_type});
                                        }
                                        _ => todo!("more subfields of range"),
                                    },
                                    syn::Member::Unnamed(i) => match i.index {
                                        0 => {
                                            let n = Ident::new(
                                                &(var_name.clone() + "_start_ptr_range"),
                                                span,
                                            );
                                            new_args.push(parse_quote! {#n : _});
                                        }
                                        1 => {
                                            let n = Ident::new(
                                                &(var_name.clone() + "_end_ptr_range"),
                                                span,
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

            unsafe extern "C" {
                #extern_fn #output;
            }
            unsafe {
                #before_call
                let result = #invocation;
                #after_call
                return result;
            }
        }
    };

    let token_stream = quote!(#unsafe_block).into();

    let filename = attributes.filename.value();
    let assembly_file: std::path::PathBuf =
        [std::env::var("OUT_DIR").expect("OUT_DIR"), filename.clone()]
            .iter()
            .collect();
    let res = File::open(assembly_file);
    let file = match res {
        Ok(opened) => opened,
        Err(error) => {
            abort_call_site!(error);
        }
    };

    let reader = BufReader::new(file);
    let mut program = Vec::new();
    for line in reader.lines() {
        program.push(line.unwrap_or(String::from("")));
    }

    let mut engine = bums::engine::ExecutionEngine::new(program);
    if let Some(bytes) = &attributes.red_zone {
        engine.allow_red_zone(bytes.base10_parse().unwrap_or_else(|e| abort!(bytes, e)));
    }

    for (i, a) in arguments_to_memory_safe_regions.iter().enumerate() {
        let name;

        match a {
            FnArg::Typed(pat_type) => {
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
                match &*pat_type.ty {
                    Type::Path(p) => {
                        if ["usize", "u64", "u32", "u16", "u8"]
                            .iter()
                            .any(|unsigned| p.path.is_ident(unsigned))
                            && !input_expressions.contains_key(&name)
                        {
                            engine.add_invariant(AbstractComparison::new(
                                ">=",
                                AbstractExpression::Abstract(name.clone()),
                                AbstractExpression::Immediate(0),
                            ));
                        }
                        if let Some(binary) = input_expressions.get(&name) {
                            match binary {
                                Expr::Binary(b) => {
                                    engine.add_abstract_expression_from(
                                        i,
                                        binary_to_abstract_expression(b),
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
                        engine.add_abstract_from(i, name.clone());

                        let no_mut_name = name.strip_suffix("_as_mut_ptr").unwrap_or(&name);
                        let no_range = name.strip_suffix("_end_ptr_range").unwrap_or(no_mut_name);
                        let no_suffix = no_range.strip_suffix("_as_ptr").unwrap_or(no_range);

                        if let Some((scaled, expression)) = pointer_offsets.get(no_suffix) {
                            let mut offset = syn_expr_to_abstract_expression(expression);
                            if *scaled {
                                if let Some(ty) = pointer_sizes.get(no_suffix) {
                                    offset = generate_expression(
                                        "*",
                                        offset,
                                        AbstractExpression::Immediate(
                                            calculate_size_of(ty.clone()) as i64,
                                        ),
                                    );
                                }
                            }
                            engine.add_abstract_expression_from(
                                i,
                                generate_expression(
                                    "+",
                                    AbstractExpression::Abstract(name.clone()),
                                    offset,
                                ),
                            );
                        }

                        match &*a.elem {
                            Type::Path(p) => {
                                if p.path.segments[0].ident.to_string().contains("struct") {
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
                                                AbstractExpression::Immediate(*bound as i64),
                                            );
                                        }
                                    }

                                    let s = new_structs
                                        .get(no_suffix)
                                        .expect("Need well defined struct");
                                    let fields: Vec<&Field> = s.fields.iter().collect();
                                    let (offsets, _) = tuple_layout(fields.iter().map(|f| &f.ty));
                                    let field_name = |f: &Field| {
                                        f.ident.clone().expect("tuple fields are named").to_string()
                                    };
                                    for (k, (field, offset)) in
                                        fields.iter().zip(offsets.iter()).enumerate()
                                    {
                                        let value = AbstractExpression::Abstract(field_name(field));
                                        match &field.ty {
                                            Type::Path(_) => {
                                                engine.add_abstract_to_memory(
                                                    name.clone(),
                                                    *offset as i64,
                                                    value,
                                                );
                                            }
                                            Type::Ptr(pointer) => {
                                                let Some(length_field) = fields.get(k + 1) else {
                                                    abort_call_site!(
                                                        "a pointer field must be followed by its usize length"
                                                    );
                                                };
                                                let element = match &*pointer.elem {
                                                    Type::Path(p) => {
                                                        p.path.segments[0].ident.to_string()
                                                    }
                                                    _ => {
                                                        todo!("pointer field to {:?}", pointer.elem)
                                                    }
                                                };
                                                engine.add_abstract_to_memory(
                                                    name.clone(),
                                                    *offset as i64,
                                                    value,
                                                );
                                                engine.add_region(
                                                    if pointer.mutability.is_some() {
                                                        RegionType::WRITE
                                                    } else {
                                                        RegionType::READ
                                                    },
                                                    field_name(field),
                                                    byte_length(
                                                        &field_name(length_field),
                                                        Some(&element),
                                                    ),
                                                );
                                            }
                                            Type::Array(_) => {}
                                            _ => todo!("unsupported tuple type {:?}", field),
                                        }
                                    }
                                    continue;
                                }

                                if name.contains("_end_ptr_range") {
                                    let length = byte_length(
                                        &(no_suffix.to_owned() + "_len"),
                                        pointer_sizes.get(no_suffix),
                                    );
                                    let pointer_name = no_suffix.to_owned() + "_as_ptr";

                                    engine.add_region(
                                        RegionType::READ,
                                        pointer_name.clone(),
                                        length.clone(),
                                    );

                                    engine.add_abstract_expression_from(
                                        i,
                                        generate_expression(
                                            "+",
                                            AbstractExpression::Abstract(pointer_name),
                                            length,
                                        ),
                                    );

                                    continue;
                                }

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
                                            AbstractExpression::Immediate(*bound as i64),
                                        );
                                    }
                                    continue;
                                }

                                let bound = no_suffix.to_owned() + "_len";
                                let length = byte_length(&bound, pointer_sizes.get(no_suffix));
                                if a.mutability.is_some() {
                                    engine.add_region(RegionType::WRITE, name.clone(), length);
                                } else {
                                    engine.add_region(RegionType::READ, name.clone(), length);
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

    for (region, offset, slice, suffix, step) in pointer_values {
        let base = format!("{}{}", slice, suffix);
        if passed_pointer(&slice, &argument_list).is_none() {
            let kind = if suffix == "_as_mut_ptr" {
                RegionType::RW
            } else {
                RegionType::READ
            };
            engine.add_region(
                kind,
                base.clone(),
                byte_length(&(slice.clone() + "_len"), pointer_sizes.get(&slice)),
            );
        }
        let mut value = AbstractExpression::Abstract(base);
        if let Some((scaled, expression)) = step {
            let mut step = syn_expr_to_abstract_expression(&expression);
            if scaled {
                if let Some(ty) = pointer_sizes.get(&slice) {
                    step = generate_expression(
                        "*",
                        step,
                        AbstractExpression::Immediate(calculate_size_of(ty.clone()) as i64),
                    );
                }
            }
            value = generate_expression("+", value, step);
        }
        engine.add_abstract_to_memory(region, offset, value);
    }
    for (name, ty) in &input_types {
        if let Type::Path(p) = ty {
            if ["usize", "u64", "u32", "u16", "u8"]
                .iter()
                .any(|unsigned| p.path.is_ident(unsigned))
            {
                engine.add_invariant(AbstractComparison::new(
                    ">=",
                    AbstractExpression::Abstract(name.clone()),
                    AbstractExpression::Immediate(0),
                ));
            }
        }
        if let Type::Reference(r) = ty
            && let Type::Slice(sl) = &*r.elem
        {
            engine.add_invariant(AbstractComparison::new(
                "<=",
                byte_length(
                    &(name.clone() + "_len"),
                    Some(&calculate_type_of_slice_ptr(sl)),
                ),
                AbstractExpression::Immediate(isize::MAX as i64),
            ));
        }
    }
    for (array, index, comparison) in &element_bounds {
        let Some((suffix, _)) = passed_pointer(array, &argument_list) else {
            emit_call_site_error!("{} is not passed as a pointer", array);
            continue;
        };
        let region = array.clone() + suffix;
        let element = input_types
            .get(array)
            .and_then(|ty| match ty {
                Type::Reference(r) => match &*r.elem {
                    Type::Slice(sl) => Some(calculate_type_of_slice_ptr(sl)),
                    _ => None,
                },
                _ => None,
            })
            .unwrap_or_else(|| {
                emit_call_site_error!("{} is not a slice, so it has no element size", array);
                "u8".to_string()
            });
        let width = calculate_size_of(element.clone()) as i64;
        let symbol = format!("{region}[{index}]");
        engine.add_element_fact(region, *index, width, symbol.clone());
        if element.starts_with('u') {
            engine.add_invariant(AbstractComparison::new(
                ">=",
                AbstractExpression::Abstract(symbol.clone()),
                AbstractExpression::Immediate(0),
            ));
        }
        engine.add_invariant(AbstractComparison::new(
            operator_of(&comparison.op),
            AbstractExpression::Abstract(symbol),
            syn_expr_to_abstract_expression(&comparison.right),
        ));
    }
    for i in invariants {
        engine.add_invariant(i);
    }
    if let ReturnType::Type(_, ty) = output
        && let Type::Array(a) = &**ty
    {
        let result = format!("{fn_name}_result");
        engine.add_abstract("x8", AbstractExpression::Abstract(result.clone()));
        engine.add_region(
            RegionType::WRITE,
            result,
            AbstractExpression::Immediate(calculate_size_of_array(a) as i64),
        );
    }
    let label = vars.item_fn.ident.to_string();
    let _ = env_logger::try_init();
    log::info!(target: "bums_macros", "checking {label}");
    let started = std::time::Instant::now();
    let res = engine.start(label.clone());
    log::info!(target: "bums_macros", "{label}: {:.1}s, {}", started.elapsed().as_secs_f64(), if res.is_ok() { "verified" } else { "failed" });

    let res = res.and_then(|ok| {
        let unread = engine.unread_element_facts();
        if unread.is_empty() {
            Ok(ok)
        } else {
            Err(std::io::Error::other(format!(
                "{}: element precondition never read by the assembly: {}",
                label,
                unread.join(", ")
            )))
        }
    });

    let findings = engine.findings();
    let token_stream: TokenStream = if findings.is_empty() {
        token_stream
    } else {
        let notes = findings
            .iter()
            .map(|finding| format!("bums finding in {label}: {finding}"));
        let markers = quote! {
            #(
                const _: () = {
                    #[deprecated(note = #notes)]
                    struct BumsFinding;
                    let _ = BumsFinding;
                };
            )*
        };
        let mut combined: proc_macro2::TokenStream = token_stream.into();
        combined.extend(markers);
        combined.into()
    };

    match res {
        Ok(_) => return token_stream,
        Err(error) => {
            #[cfg(not(debug_assertions))]
            emit_call_site_error!(error);

            #[cfg(debug_assertions)]
            eprintln!("bums: VERIFICATION FAILED in {label}: {error}");

            return token_stream;
        }
    };
}
