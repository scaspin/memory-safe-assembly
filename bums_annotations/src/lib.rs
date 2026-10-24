use parse::{Parse, ParseStream};
use proc_macro2::{Delimiter, Span, TokenStream, TokenTree};
use punctuated::Punctuated;
use quote::quote;
use std::collections::BTreeMap;
use std::hash::{DefaultHasher, Hash, Hasher};
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

fn narrow_argument_range(ty: &TypePath) -> Option<(i64, i64)> {
    let ranges = [
        ("bool", 0, 1),
        ("u8", 0, u8::MAX as i64),
        ("i8", i8::MIN as i64, i8::MAX as i64),
        ("u16", 0, u16::MAX as i64),
        ("i16", i16::MIN as i64, i16::MAX as i64),
        ("u32", 0, u32::MAX as i64),
        ("i32", i32::MIN as i64, i32::MAX as i64),
    ];
    ranges
        .into_iter()
        .find(|(name, ..)| ty.path.is_ident(name))
        .map(|(_, least, most)| (least, most))
}

fn with_unspecified_upper_bits(name: &str) -> AbstractExpression {
    generate_expression(
        "+",
        AbstractExpression::Abstract(name.to_string()),
        generate_expression(
            "*",
            AbstractExpression::Immediate(1i64 << 32),
            AbstractExpression::Abstract(format!("{name}_upper_bits")),
        ),
    )
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
        "f32" => std::mem::size_of::<f32>(),
        "f64" => std::mem::size_of::<f64>(),
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
        Type::Ptr(_) | Type::Reference(_) => "usize".to_string(),
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

fn element_bound(input: &ExprBinary, diagnostics: &mut Vec<String>) -> Option<(String, i64)> {
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
            diagnostics.push(
                "an element precondition needs a literal index: a proc macro runs \
                 before const evaluation, so a named constant cannot be resolved here"
                    .to_string(),
            );
            return None;
        }
    };
    Some((path.path.segments[0].ident.to_string(), index))
}

type PointerContent = (String, i64, String, &'static str, Option<(bool, Expr)>);

fn pointer_contents(
    input: &ExprBinary,
    arguments: &Punctuated<Expr, Token![,]>,
) -> Option<PointerContent> {
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

fn pointer_array_shape(input: &ExprBinary) -> Option<(String, String, Expr, Expr)> {
    if !matches!(input.op, BinOp::Eq(_)) {
        return None;
    }
    let Expr::Path(array) = &*input.left else {
        return None;
    };
    let Expr::Repeat(rows) = &*input.right else {
        return None;
    };
    let Expr::Reference(row) = &*rows.expr else {
        return None;
    };
    let Expr::Repeat(row) = &*row.expr else {
        return None;
    };
    let Expr::Path(element) = &*row.expr else {
        return None;
    };
    Some((
        array.path.segments[0].ident.to_string(),
        element.path.segments[0].ident.to_string(),
        (*row.len).clone(),
        (*rows.len).clone(),
    ))
}

fn element_range_array(input: &ExprBinary) -> Option<String> {
    let Expr::Index(indexed) = &*input.left else {
        return None;
    };
    let Expr::Range(range) = &*indexed.index else {
        return None;
    };
    let Expr::Path(path) = &*indexed.expr else {
        return None;
    };
    (range.start.is_none() && range.end.is_none()).then(|| path.path.segments[0].ident.to_string())
}

fn row_pointer_type(ty: &Type) -> Option<(Type, bool)> {
    let Type::Reference(reference) = ty else {
        return None;
    };
    let Type::Slice(slice) = &*reference.elem else {
        return None;
    };
    match &*slice.elem {
        Type::Ptr(pointer) => Some((Type::Ptr(pointer.clone()), false)),
        Type::Reference(row) => match &*row.elem {
            Type::Slice(row) => {
                let element = &row.elem;
                Some((parse_quote! { *const #element }, true))
            }
            _ => None,
        },
        _ => None,
    }
}

fn conjuncts(e: &Expr, out: &mut Vec<AbstractComparison>, diagnostics: &mut Vec<String>) {
    match e {
        Expr::Paren(p) => conjuncts(&p.expr, out, diagnostics),
        Expr::Binary(b) if matches!(b.op, BinOp::And(_)) => {
            conjuncts(&b.left, out, diagnostics);
            conjuncts(&b.right, out, diagnostics);
        }
        Expr::Binary(b) => out.push(binary_to_abstract_comparison(b)),
        _ => diagnostics.push("a precondition must be a comparison".to_string()),
    }
}

fn disjuncts(e: &Expr, out: &mut Vec<Vec<AbstractComparison>>, diagnostics: &mut Vec<String>) {
    match e {
        Expr::Paren(p) => disjuncts(&p.expr, out, diagnostics),
        Expr::Binary(b) if matches!(b.op, BinOp::Or(_)) => {
            disjuncts(&b.left, out, diagnostics);
            disjuncts(&b.right, out, diagnostics);
        }
        _ => {
            let mut all = Vec::new();
            conjuncts(e, &mut all, diagnostics);
            out.push(all);
        }
    }
}

fn casts_keep_their_values(e: &Expr) -> proc_macro2::TokenStream {
    let inner: Vec<&Expr> = match e {
        Expr::Cast(cast) => {
            let integer = matches!(&*cast.ty, Type::Path(p) if p.path.get_ident().is_some_and(|t| {
                ["i8", "i16", "i32", "i64", "i128", "isize", "u8", "u16", "u32", "u64", "u128", "usize"]
                    .contains(&t.to_string().as_str())
            }));
            let nested = casts_keep_their_values(&cast.expr);
            if !integer {
                return nested;
            }
            let (ty, value) = (&cast.ty, &cast.expr);
            return quote! { #nested assert!(((#value) as #ty) as i128 == (#value) as i128); };
        }
        Expr::Binary(b) => vec![&b.left, &b.right],
        Expr::Unary(u) => vec![&u.expr],
        Expr::Paren(p) => vec![&p.expr],
        Expr::Group(g) => vec![&g.expr],
        Expr::Index(i) => vec![&i.expr, &i.index],
        Expr::Reference(r) => vec![&r.expr],
        Expr::Repeat(r) => vec![&r.expr, &r.len],
        Expr::Array(a) => a.elems.iter().collect(),
        Expr::Call(c) => c.args.iter().collect(),
        Expr::MethodCall(m) => std::iter::once(&*m.receiver).chain(&m.args).collect(),
        _ => Vec::new(),
    };
    inner.into_iter().map(casts_keep_their_values).collect()
}

const PRECONDITION_OVERFLOW: &str = "precondition arithmetic overflows i128";

fn exact_condition(e: &Expr) -> proc_macro2::TokenStream {
    match e {
        Expr::Paren(p) => {
            let inner = exact_condition(&p.expr);
            quote! { (#inner) }
        }
        Expr::Group(g) => exact_condition(&g.expr),
        Expr::Unary(u) if matches!(u.op, UnOp::Not(_)) => {
            let inner = exact_condition(&u.expr);
            match &*u.expr {
                Expr::Paren(_) | Expr::Path(_) | Expr::Call(_) | Expr::MethodCall(_) => {
                    quote! { !#inner }
                }
                _ => quote! { !(#inner) },
            }
        }
        Expr::Binary(b) => {
            let op = &b.op;
            match b.op {
                BinOp::And(_) | BinOp::Or(_) => {
                    let (left, right) = (exact_condition(&b.left), exact_condition(&b.right));
                    quote! { #left #op #right }
                }
                BinOp::Eq(_)
                | BinOp::Ne(_)
                | BinOp::Lt(_)
                | BinOp::Le(_)
                | BinOp::Gt(_)
                | BinOp::Ge(_) => {
                    let (left, right) = (exact_value(&b.left), exact_value(&b.right));
                    quote! { #left #op #right }
                }
                _ => quote! { #e },
            }
        }
        _ => quote! { #e },
    }
}

fn exact_leaf(value: impl quote::ToTokens) -> proc_macro2::TokenStream {
    quote! { i128::try_from(#value).expect(#PRECONDITION_OVERFLOW) }
}

fn exact_value(e: &Expr) -> proc_macro2::TokenStream {
    match e {
        Expr::Paren(p) => exact_value(&p.expr),
        Expr::Group(g) => exact_value(&g.expr),
        Expr::Unary(u) if matches!(u.op, UnOp::Neg(_)) => {
            let inner = exact_value(&u.expr);
            quote! { #inner.checked_neg().expect(#PRECONDITION_OVERFLOW) }
        }
        Expr::Binary(b) => {
            let checked = match b.op {
                BinOp::Add(_) => quote! { checked_add },
                BinOp::Sub(_) => quote! { checked_sub },
                BinOp::Mul(_) => quote! { checked_mul },
                BinOp::Div(_) => quote! { checked_div_euclid },
                BinOp::Rem(_) => quote! { checked_rem_euclid },
                _ => return exact_leaf(e),
            };
            let (left, right) = (exact_value(&b.left), exact_value(&b.right));
            quote! { #left.#checked(#right).expect(#PRECONDITION_OVERFLOW) }
        }
        _ => exact_leaf(e),
    }
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
    let span = Span::call_site();

    let mut fields: syn::punctuated::Punctuated<Field, token::Comma> = Punctuated::new();
    for (index, expr) in tuple.elems.iter().enumerate() {
        let field_ident = syn::Ident::new(&format!("{}_field{}", name, index), span);
        let field: Field = parse_quote! {#field_ident: #expr};
        fields.push(field.clone());
    }

    let struct_name = syn::Ident::new(&(name + "_struct"), span);
    parse_quote! { #[repr(C)] struct #struct_name { #fields }}
}

fn spelled(tokens: TokenStream) -> String {
    let spellings: Vec<String> = tokens
        .into_iter()
        .map(|token| match token {
            TokenTree::Group(group) => {
                let (open, close) = match group.delimiter() {
                    Delimiter::Parenthesis => ("(", ")"),
                    Delimiter::Brace => ("{", "}"),
                    Delimiter::Bracket => ("[", "]"),
                    Delimiter::None => ("", ""),
                };
                format!("{open}{}{close}", spelled(group.stream()))
            }
            other => other.to_string(),
        })
        .collect();
    spellings.join(" ")
}

pub struct Annotation {
    pub label: String,
    pub asm_file: String,
    pub diagnostics: Vec<String>,
    pub expansion: TokenStream,
    signature: Signature,
    red_zone: Option<i64>,
    argument_list: Punctuated<Expr, Token![,]>,
    regions: Vec<FnArg>,
    input_sizes: BTreeMap<String, usize>,
    pointer_sizes: BTreeMap<String, String>,
    input_types: BTreeMap<String, Type>,
    input_expressions: BTreeMap<String, Expr>,
    new_structs: BTreeMap<String, ItemStruct>,
    pointer_offsets: BTreeMap<String, (bool, Expr)>,
    pointer_values: Vec<PointerContent>,
    element_bounds: Vec<(String, i64, ExprBinary)>,
    element_ranges: Vec<(String, ExprBinary)>,
    pointer_arrays: Vec<(String, String, Expr, Expr)>,
    invariants: Vec<AbstractComparison>,
    combinations: Vec<Vec<AbstractComparison>>,
    unchecked_rows: Vec<String>,
    unchecked_pointer_fields: Vec<(String, usize)>,
}

pub struct Verdict {
    pub failures: Vec<String>,
    pub findings: Vec<String>,
    pub diagnostics: Vec<String>,
}

pub fn read_program(path: &std::path::Path) -> std::io::Result<Vec<String>> {
    let file = std::fs::File::open(path)?;
    Ok(std::io::BufRead::lines(std::io::BufReader::new(file))
        .map(|line| line.unwrap_or_default())
        .collect())
}

pub fn parse_annotation(attr: TokenStream, item: TokenStream) -> Result<Annotation> {
    let vars: CallColon = syn::parse2(item)?;
    let mut attributes: AttributeList = syn::parse2(attr)?;
    let red_zone = attributes
        .red_zone
        .as_ref()
        .map(|bytes| bytes.base10_parse::<i64>())
        .transpose()?;
    let mut diagnostics = Vec::new();
    let fn_name = &vars.item_fn.ident;
    let output = &vars.item_fn.output;

    let mut invariants: Vec<AbstractComparison> = Vec::new();
    let mut element_bounds: Vec<(String, i64, ExprBinary)> = Vec::new();
    let mut pointer_values: Vec<PointerContent> = Vec::new();
    let mut element_ranges: Vec<(String, ExprBinary)> = Vec::new();
    let mut pointer_arrays: Vec<(String, String, Expr, Expr)> = Vec::new();
    let mut disjunctions: Vec<Vec<Vec<AbstractComparison>>> = Vec::new();
    let mut asserts = quote! {};
    let argument_list = attributes.argument_list.clone();
    if let Some(Expr::Array(a)) = argument_list.last() {
        for e in &a.elems {
            let checks = casts_keep_their_values(e);
            asserts = quote! { #asserts #checks };
            if let Expr::Binary(b) = e {
                if let Some(shape) = pointer_array_shape(b) {
                    pointer_arrays.push(shape);
                    continue;
                }
                if matches!(b.op, BinOp::Or(_)) {
                    let mut alternatives = Vec::new();
                    disjuncts(e, &mut alternatives, &mut diagnostics);
                    disjunctions.push(alternatives);
                    let exact = exact_condition(e);
                    asserts = quote! { #asserts assert!(#exact); };
                    continue;
                }
                if matches!(b.op, BinOp::And(_)) {
                    conjuncts(e, &mut invariants, &mut diagnostics);
                    let exact = exact_condition(e);
                    asserts = quote! { #asserts assert!(#exact); };
                    continue;
                }
                if let Some(array) = element_range_array(b) {
                    let Expr::Index(indexed) = &*b.left else {
                        unreachable!()
                    };
                    let (collection, op) = (&indexed.expr, &b.op);
                    let exact_bound = exact_value(&b.right);
                    asserts = quote! {
                        #asserts
                        assert!(#collection.iter().all(|e| (*e as i128) #op #exact_bound));
                    };
                    element_ranges.push((array, b.clone()));
                    continue;
                }
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
                    asserts = quote! { #asserts assert!((#stored) as usize == #source as usize); };
                    pointer_values.push(value);
                    continue;
                }
                if let Some((array, index)) = element_bound(b, &mut diagnostics) {
                    element_bounds.push((array, index, b.clone()));
                    let exact = exact_condition(e);
                    asserts = quote! { #asserts assert!(#exact); };
                    continue;
                }
                invariants.push(binary_to_abstract_comparison(b));
                let exact = exact_condition(e);
                asserts = quote! { #asserts assert!(#exact); };
            } else {
                diagnostics
                    .push("Cannot define an invariant that is not a binary expression".to_string());
            }
        }
        attributes.argument_list.pop();
    }

    let mut arguments_to_memory_safe_regions = Vec::new();
    let mut input_sizes = BTreeMap::new();
    let mut pointer_sizes = BTreeMap::new();
    let mut input_types = BTreeMap::new();
    let mut input_expressions = BTreeMap::new();
    let mut arguments_to_pass: Punctuated<_, _> = Punctuated::new();
    let mut new_structs = BTreeMap::new();
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
                    input_types.insert(name.clone(), ty.clone());
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
            } else if let Expr::MethodCall(call) = i
                && call.method == "as_ptr"
                && let Expr::Path(receiver) = &*call.receiver
                && let Some(ty) = input_types.get(&receiver.path.segments[0].ident.to_string())
                && let Some((row, true)) = row_pointer_type(ty)
            {
                let rows = &call.receiver;
                arguments_to_pass.push(parse_quote! {
                    #rows.iter().map(|row| row.as_ptr()).collect::<Vec<#row>>().as_ptr()
                });
            } else {
                arguments_to_pass.push(i.clone());
            }
        }
    }

    let mut unchecked_rows = Vec::new();
    for (array, _, len, count) in &pointer_arrays {
        let rows = Ident::new(array, proc_macro2::Span::call_site());
        let exact_count = exact_value(count);
        let exact_rows = exact_leaf(quote! { #rows.len() });
        asserts = quote! { #asserts assert!(#exact_rows == #exact_count); };
        match input_types.get(array).and_then(row_pointer_type) {
            Some((_, true)) => {
                let exact_len = exact_value(len);
                let exact_row = exact_leaf(quote! { row.len() });
                asserts = quote! {
                    #asserts
                    assert!(#rows.iter().all(|row| #exact_row == #exact_len));
                };
            }
            Some((_, false)) => unchecked_rows.push(array.clone()),
            None => diagnostics.push(format!(
                "{} must be a slice of row references or raw pointers",
                array
            )),
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
    let mut pointer_offsets: BTreeMap<String, (bool, Expr)> = BTreeMap::new();
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
                            let exact = exact_value(&expression);
                            let exact_buffer = exact_leaf(quote! { #buffer.len() });
                            asserts = quote! {
                                #asserts
                                assert!(#exact <= #exact_buffer);
                            };
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
                            if let Some((row, _)) =
                                input_types.get(&var_name).and_then(row_pointer_type)
                            {
                                new_args.push(parse_quote! {#n: *const #row});
                            } else if let Some(size) = pointer_sizes.get(&var_name) {
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
                    let exp = spelled(quote! {#b});
                    let name = "expr_".to_owned() + &calculate_hash(&exp).to_string();
                    let (passed, exact) = (exact_leaf(&i), exact_value(&i));
                    asserts = quote! { #asserts assert!(#passed == #exact); };
                    input_expressions.insert(name.clone(), i);
                    let n = Ident::new(&name, span);
                    new_args.push(parse_quote! {#n : usize});
                }
                Expr::Unary(ref b) => {
                    let exp = spelled(quote! {#b});
                    let name = "expr_".to_owned() + &calculate_hash(&exp).to_string();
                    let (passed, exact) = (exact_leaf(&i), exact_value(&i));
                    asserts = quote! { #asserts assert!(#passed == #exact); };
                    input_expressions.insert(name.clone(), i);
                    let n = Ident::new(&name, span);
                    new_args.push(parse_quote! {#n : isize});
                }
                Expr::Lit(ref b) => {
                    let exp = spelled(quote! {#b});
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

    let unchecked_pointer_fields: Vec<(String, usize)> = new_structs
        .iter()
        .flat_map(|(name, declared)| {
            declared
                .fields
                .iter()
                .enumerate()
                .filter(|(_, field)| matches!(field.ty, Type::Ptr(_)))
                .map(move |(index, _)| (name.clone(), index))
        })
        .collect();
    let mut original_fn_call = vars.item_fn.clone();
    if !unchecked_rows.is_empty() || !unchecked_pointer_fields.is_empty() {
        original_fn_call.unsafety = Some(Default::default());
    }
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

    let mut combinations: Vec<Vec<AbstractComparison>> = vec![Vec::new()];
    for alternatives in &disjunctions {
        combinations = combinations
            .iter()
            .flat_map(|chosen| {
                alternatives.iter().map(move |alternative| {
                    let mut chosen = chosen.clone();
                    chosen.extend(alternative.iter().cloned());
                    chosen
                })
            })
            .collect();
    }
    Ok(Annotation {
        label: vars.item_fn.ident.to_string(),
        asm_file: attributes.filename.value(),
        diagnostics,
        expansion: quote!(#unsafe_block),
        signature: vars.item_fn.clone(),
        red_zone,
        argument_list,
        regions: arguments_to_memory_safe_regions,
        input_sizes,
        pointer_sizes,
        input_types,
        input_expressions,
        new_structs,
        pointer_offsets,
        pointer_values,
        element_bounds,
        element_ranges,
        pointer_arrays,
        invariants,
        combinations,
        unchecked_rows,
        unchecked_pointer_fields,
    })
}

impl Annotation {
    pub fn check(&self, program: &[String]) -> std::result::Result<Verdict, String> {
        let Annotation {
            label,
            signature,
            red_zone,
            argument_list,
            regions: arguments_to_memory_safe_regions,
            input_sizes,
            pointer_sizes,
            input_types,
            input_expressions,
            new_structs,
            pointer_offsets,
            pointer_values,
            element_bounds,
            element_ranges,
            pointer_arrays,
            invariants,
            combinations,
            ..
        } = self;
        let fn_name = &signature.ident;
        let output = &signature.output;
        let mut diagnostics: Vec<String> = Vec::new();
        let mut failures: Vec<String> = Vec::new();
        let mut findings: Vec<String> = Vec::new();
        for chosen in combinations {
            let mut engine = bums::engine::AnyEngine::new(program.to_vec());
            if let Some(bytes) = red_zone {
                engine.allow_red_zone(*bytes);
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
                                } else if let Some((least, most)) = narrow_argument_range(p) {
                                    let value = AbstractExpression::Abstract(name.clone());
                                    for (op, bound) in [(">=", least), ("<=", most)] {
                                        engine.add_invariant(AbstractComparison::new(
                                            op,
                                            value.clone(),
                                            AbstractExpression::Immediate(bound),
                                        ));
                                    }
                                    engine.add_abstract_expression_from(
                                        i,
                                        with_unspecified_upper_bits(&name),
                                    );
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
                                let no_range =
                                    name.strip_suffix("_end_ptr_range").unwrap_or(no_mut_name);
                                let no_suffix =
                                    no_range.strip_suffix("_as_ptr").unwrap_or(no_range);

                                if let Some((scaled, expression)) = pointer_offsets.get(no_suffix) {
                                    let mut offset = syn_expr_to_abstract_expression(expression);
                                    if *scaled && let Some(ty) = pointer_sizes.get(no_suffix) {
                                        offset = generate_expression(
                                            "*",
                                            offset,
                                            AbstractExpression::Immediate(calculate_size_of(
                                                ty.clone(),
                                            )
                                                as i64),
                                        );
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
                                                        AbstractExpression::Immediate(
                                                            *bound as i64,
                                                        ),
                                                    );
                                                } else {
                                                    engine.add_region(
                                                        RegionType::READ,
                                                        name.clone(),
                                                        AbstractExpression::Immediate(
                                                            *bound as i64,
                                                        ),
                                                    );
                                                }
                                            }

                                            let s = new_structs
                                                .get(no_suffix)
                                                .expect("Need well defined struct");
                                            let fields: Vec<&Field> = s.fields.iter().collect();
                                            let (offsets, _) =
                                                tuple_layout(fields.iter().map(|f| &f.ty));
                                            let field_name = |f: &Field| {
                                                f.ident
                                                    .clone()
                                                    .expect("tuple fields are named")
                                                    .to_string()
                                            };
                                            for (k, (field, offset)) in
                                                fields.iter().zip(offsets.iter()).enumerate()
                                            {
                                                let value =
                                                    AbstractExpression::Abstract(field_name(field));
                                                match &field.ty {
                                                    Type::Path(_) => {
                                                        engine.add_abstract_to_memory(
                                                            name.clone(),
                                                            *offset as i64,
                                                            value,
                                                        );
                                                    }
                                                    Type::Ptr(pointer) => {
                                                        let Some(length_field) = fields.get(k + 1)
                                                        else {
                                                            return Err("a pointer field must be followed by its usize length".to_string());
                                                        };
                                                        let element = match &*pointer.elem {
                                                            Type::Path(p) => {
                                                                p.path.segments[0].ident.to_string()
                                                            }
                                                            _ => {
                                                                todo!(
                                                                    "pointer field to {:?}",
                                                                    pointer.elem
                                                                )
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
                                                    _ => {
                                                        todo!("unsupported tuple type {:?}", field)
                                                    }
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
                                        let length =
                                            byte_length(&bound, pointer_sizes.get(no_suffix));
                                        if a.mutability.is_some() {
                                            engine.add_region(
                                                RegionType::WRITE,
                                                name.clone(),
                                                length,
                                            );
                                        } else {
                                            engine.add_region(
                                                RegionType::READ,
                                                name.clone(),
                                                length,
                                            );
                                        }
                                    }
                                    Type::Ptr(_) => {
                                        let length = byte_length(
                                            &(no_suffix.to_owned() + "_len"),
                                            Some(&"usize".to_string()),
                                        );
                                        let kind = if a.mutability.is_some() {
                                            RegionType::WRITE
                                        } else {
                                            RegionType::READ
                                        };
                                        engine.add_region(kind, name.clone(), length);
                                    }
                                    _ => todo!(
                                        "unsupported pointer type to pass to asm {:?}",
                                        a.elem
                                    ),
                                }
                            }
                            _ => todo!("yet unsupported type: {:?}", pat_type.ty),
                        }
                    }
                    _ => todo!("lib"),
                }
            }

            for (region, offset, slice, suffix, step) in pointer_values.iter().cloned() {
                let base = format!("{}{}", slice, suffix);
                if passed_pointer(&slice, argument_list).is_none() {
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
                    if scaled && let Some(ty) = pointer_sizes.get(&slice) {
                        step = generate_expression(
                            "*",
                            step,
                            AbstractExpression::Immediate(calculate_size_of(ty.clone()) as i64),
                        );
                    }
                    value = generate_expression("+", value, step);
                }
                engine.add_abstract_to_memory(region, offset, value);
            }
            for (name, ty) in input_types {
                if let Type::Path(p) = ty
                    && ["usize", "u64", "u32", "u16", "u8"]
                        .iter()
                        .any(|unsigned| p.path.is_ident(unsigned))
                {
                    engine.add_invariant(AbstractComparison::new(
                        ">=",
                        AbstractExpression::Abstract(name.clone()),
                        AbstractExpression::Immediate(0),
                    ));
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
            for (array, index, comparison) in element_bounds {
                let Some((suffix, _)) = passed_pointer(array, argument_list) else {
                    diagnostics.push(format!("{} is not passed as a pointer", array));
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
                        diagnostics.push(format!(
                            "{} is not a slice, so it has no element size",
                            array
                        ));
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
            for (array, comparison) in element_ranges {
                let suffix =
                    passed_pointer(array, argument_list).map_or("_as_ptr", |(suffix, _)| suffix);
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
                        diagnostics.push(format!(
                            "{} is not a slice, so it has no element size",
                            array
                        ));
                        "u8".to_string()
                    });
                if element.starts_with('f') {
                    diagnostics.push(format!(
                        "an element range needs integer elements, not {}",
                        element
                    ));
                }
                engine.add_element_range(
                    array.clone() + suffix,
                    calculate_size_of(element.clone()) as i64,
                    element.starts_with('i'),
                    operator_of(&comparison.op),
                    syn_expr_to_abstract_expression(&comparison.right),
                );
            }
            for (array, element, len, count) in pointer_arrays {
                let Some((suffix, _)) = passed_pointer(array, argument_list) else {
                    diagnostics.push(format!("{} is not passed as a pointer", array));
                    continue;
                };
                engine.add_invariant(AbstractComparison::new(
                    "==",
                    AbstractExpression::Abstract(array.clone() + "_len"),
                    syn_expr_to_abstract_expression(count),
                ));
                let row = array.clone() + "_row";
                engine.add_region(
                    RegionType::READ,
                    row.clone(),
                    generate_expression(
                        "*",
                        syn_expr_to_abstract_expression(len),
                        AbstractExpression::Immediate(calculate_size_of(element.clone()) as i64),
                    ),
                );
                engine.add_pointer_elements(array.clone() + suffix, row);
            }
            for i in invariants.iter().cloned() {
                engine.add_invariant(i);
            }
            for c in chosen {
                match (c.op.as_str(), &*c.left, &*c.right) {
                    (
                        "==",
                        AbstractExpression::Abstract(name),
                        AbstractExpression::Immediate(value),
                    )
                    | (
                        "==",
                        AbstractExpression::Immediate(value),
                        AbstractExpression::Abstract(name),
                    ) => engine.pin(name, *value),
                    _ => engine.add_invariant(c.clone()),
                }
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
            if let Err(error) = res {
                failures.push(if combinations.len() > 1 {
                    let assumed: Vec<String> = chosen.iter().map(|c| c.to_string()).collect();
                    format!("assuming {}: {error}", assumed.join(" && "))
                } else {
                    error.to_string()
                });
            }
            for finding in engine.findings() {
                if !findings.contains(&finding) {
                    findings.push(finding);
                }
            }
        }
        for array in &self.unchecked_rows {
            findings.push(format!(
                "the rows of {array} are raw pointers whose lengths cannot be checked at run time: \
                 they are the caller's contract, so the wrapper is an unsafe fn"
            ));
        }
        for (tuple, index) in &self.unchecked_pointer_fields {
            findings.push(format!(
                "field {index} of {tuple} is a raw pointer whose length cannot be checked at run time: \
                 it is the caller's contract, so the wrapper is an unsafe fn"
            ));
        }
        let mut distinct_diagnostics: Vec<String> = Vec::new();
        for diagnostic in diagnostics {
            if !distinct_diagnostics.contains(&diagnostic) {
                distinct_diagnostics.push(diagnostic);
            }
        }
        Ok(Verdict {
            failures,
            findings,
            diagnostics: distinct_diagnostics,
        })
    }
}

#[cfg(test)]
#[allow(clippy::unnecessary_fallible_conversions)]
mod tests {
    use super::*;

    macro_rules! emitted {
        ($($code:tt)*) => {
            (stringify!($($code)*), move || -> bool { $($code)* })
        };
    }

    fn without_spaces(text: &str) -> String {
        text.chars().filter(|c| !c.is_whitespace()).collect()
    }

    #[test]
    fn a_precondition_that_overflows_usize_is_rejected_at_run_time() {
        let n: usize = 1 << 62;
        let inc_x: usize = 4;
        let x = [0u64; 4];
        assert!(n.wrapping_mul(inc_x) <= x.len());

        let precondition: Expr = parse_quote! { n * inc_x <= x.len() };
        let (spelled, check) = emitted! {
            i128::try_from(n)
                .expect("precondition arithmetic overflows i128")
                .checked_mul(i128::try_from(inc_x).expect("precondition arithmetic overflows i128"))
                .expect("precondition arithmetic overflows i128")
                <= i128::try_from(x.len()).expect("precondition arithmetic overflows i128")
        };
        assert_eq!(
            without_spaces(&exact_condition(&precondition).to_string()),
            without_spaces(spelled)
        );
        assert!(!check());
    }

    #[test]
    fn precondition_arithmetic_that_overflows_i128_panics() {
        let (n, inc_x) = (u64::MAX, u64::MAX);
        let precondition: Expr = parse_quote! { n * inc_x * inc_x <= 4 };
        let (spelled, check) = emitted! {
            i128::try_from(n)
                .expect("precondition arithmetic overflows i128")
                .checked_mul(i128::try_from(inc_x).expect("precondition arithmetic overflows i128"))
                .expect("precondition arithmetic overflows i128")
                .checked_mul(i128::try_from(inc_x).expect("precondition arithmetic overflows i128"))
                .expect("precondition arithmetic overflows i128")
                <= i128::try_from(4).expect("precondition arithmetic overflows i128")
        };
        assert_eq!(
            without_spaces(&exact_condition(&precondition).to_string()),
            without_spaces(spelled)
        );
        assert!(std::panic::catch_unwind(check).is_err());
    }

    #[test]
    fn an_expression_argument_is_checked_against_its_exact_value() {
        let attr: TokenStream = quote! { "f.S", x.as_ptr(), n * inc_x, [n * inc_x <= x.len()] };
        let item: TokenStream = quote! { fn f(x: &[u64], n: usize, inc_x: usize); };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        let expansion = without_spaces(&annotation.expansion.to_string());
        let fits = |value: &str| {
            format!("i128::try_from({value}).expect(\"preconditionarithmeticoverflowsi128\")")
        };
        let exact = format!(
            "{}.checked_mul({}).expect(\"preconditionarithmeticoverflowsi128\")",
            fits("n"),
            fits("inc_x")
        );
        assert!(
            expansion.contains(&format!("assert!({exact}<={});", fits("x.len()"))),
            "{expansion}"
        );
        assert!(
            expansion.contains(&format!("assert!({}=={exact});", fits("n*inc_x"))),
            "{expansion}"
        );
    }

    #[test]
    fn a_wrapper_relying_on_unchecked_raw_pointers_is_unsafe() {
        let wrapper_of = |attr: TokenStream, item: TokenStream| {
            let annotation = parse_annotation(attr, item).expect("annotation parses");
            without_spaces(&annotation.expansion.to_string())
        };
        let rows = wrapper_of(
            quote! { "f.S", src.as_ptr(), n, k, [src == [&[i16; n]; k], src.len() == k] },
            quote! { fn f(src: &[*const i16], n: usize, k: usize); },
        );
        assert!(rows.starts_with("unsafefnf("), "{rows}");
        let field = wrapper_of(
            quote! { "f.S", data as *mut _ },
            quote! { fn f(data: &mut ([u8; 4], *const u8, usize)); },
        );
        assert!(field.starts_with("unsafefnf("), "{field}");
        let checked = wrapper_of(
            quote! { "f.S", src.as_ptr(), n, k, [src == [&[i16; n]; k], src.len() == k] },
            quote! { fn f(src: &[&[i16]], n: usize, k: usize); },
        );
        assert!(checked.starts_with("fnf("), "{checked}");
    }

    #[test]
    fn a_32_bit_argument_read_through_its_64_bit_register_is_rejected() {
        let verdict_for = |body: &[&str]| {
            let attr: TokenStream = quote! { "f.S", table.as_ptr(), i, [i < 16] };
            let item: TokenStream = quote! { fn f(table: &[u8; 16], i: u32); };
            let annotation = parse_annotation(attr, item).expect("annotation parses");
            let mut program = vec!["f:".to_string()];
            program.extend(body.iter().map(|line| line.to_string()));
            annotation.check(&program).expect("the check runs").failures
        };
        assert!(!verdict_for(&["ldrb w2,[x0,x1]", "ret"]).is_empty());
        assert_eq!(
            verdict_for(&["ldrb w2,[x0,w1,uxtw]", "ret"]),
            Vec::<String>::new()
        );
        assert!(!verdict_for(&["movzbl (%rdi,%rsi),%eax", "ret"]).is_empty());
        assert_eq!(
            verdict_for(&["movl %esi,%esi", "movzbl (%rdi,%rsi),%eax", "ret"]),
            Vec::<String>::new()
        );
    }
}
