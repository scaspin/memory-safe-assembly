use parse::{Parse, ParseStream};
use proc_macro2::{Delimiter, Span, TokenStream, TokenTree};
use punctuated::Punctuated;
use quote::quote;
use std::collections::{BTreeMap, BTreeSet};
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
    options: AttributeOptions,
    argument_list: Punctuated<Expr, Token![,]>,
}

#[derive(Debug, Default)]
struct AttributeOptions {
    red_zone: Option<LitInt>,
    symbol: Option<LitStr>,
    abi: Option<LitStr>,
    rejects: bool,
}

const REJECTS_BUT_VERIFIED: &str = "is marked rejects, so the checker must fail it, but it verified: \
     either the assembly no longer reads past what the annotation grants, or the checker lost the over-read";

fn parse_options(input: ParseStream) -> Result<AttributeOptions> {
    let mut options = AttributeOptions::default();
    loop {
        let Ok(name) = input.fork().parse::<Ident>() else {
            return Ok(options);
        };
        let assigned = input.peek2(Token![=]) && !input.peek2(Token![==]);
        let flag_alone = input.peek2(Token![,]);
        let label = name.to_string();
        match label.as_str() {
            "red_zone" | "symbol" | "abi" if assigned => {
                input.parse::<Ident>()?;
                input.parse::<Token![=]>()?;
                let repeated = match label.as_str() {
                    "red_zone" => options.red_zone.replace(input.parse()?).is_some(),
                    "symbol" => options.symbol.replace(input.parse()?).is_some(),
                    _ => options.abi.replace(input.parse()?).is_some(),
                };
                if repeated {
                    return Err(syn::Error::new_spanned(
                        name,
                        format!("{label} is given twice"),
                    ));
                }
            }
            "rejects" if flag_alone => {
                input.parse::<Ident>()?;
                options.rejects = true;
            }
            _ => return Ok(options),
        }
        input.parse::<Option<Token![,]>>()?;
    }
}

const APPLE_ARM64_RED_ZONE: i64 = 128;
const RED_ZONE_NEEDS_APPLE: &str =
    "red_zone relies on the Apple arm64 ABI and is accepted only for an Apple target";
const RUST_ABI_NEEDS_APPLE: &str = "abi = \"Rust\" models the unstable Rust ABI as the pinned rustc 1.93 lowers it, which was confirmed only for Apple targets";

impl Parse for AttributeList {
    fn parse(input: ParseStream) -> Result<Self> {
        let filename = input.parse()?;
        let _separator = input.parse()?;
        let options = parse_options(input)?;
        if let Some(abi) = &options.abi
            && !matches!(abi.value().as_str(), "C" | "Rust")
        {
            return Err(syn::Error::new_spanned(
                abi,
                "abi must be \"C\" (the default) or \"Rust\"",
            ));
        }
        Ok(Self {
            filename,
            _separator,
            options,
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

const PRECONDITION_FUNCTIONS: [&str; 3] = ["reg", "clz32", "field"];

fn called_function(call: &ExprCall) -> Option<String> {
    let Expr::Path(path) = &*call.func else {
        return None;
    };
    match path.path.segments.iter().collect::<Vec<_>>().as_slice() {
        [segment] if path.qself.is_none() => Some(segment.ident.to_string()),
        _ => None,
    }
}

const FIELD_SCALARS: [&str; 10] = [
    "u8", "i8", "u16", "i16", "u32", "i32", "u64", "i64", "usize", "isize",
];

#[derive(Clone, Debug, PartialEq)]
enum FieldType {
    Scalar(String),
    Array(String, i64),
}

impl FieldType {
    fn element(&self) -> &str {
        match self {
            FieldType::Scalar(element) | FieldType::Array(element, _) => element,
        }
    }

    fn element_width(&self) -> i64 {
        calculate_size_of(self.element().to_string()) as i64
    }

    fn width(&self) -> i64 {
        match self {
            FieldType::Scalar(_) => self.element_width(),
            FieldType::Array(_, count) => self.element_width() * count,
        }
    }

    fn shown(&self) -> String {
        let ty = self.rust_type();
        spelled(quote! { #ty })
    }

    fn rust_type(&self) -> Type {
        let element = Ident::new(self.element(), Span::call_site());
        match self {
            FieldType::Scalar(_) => parse_quote! { #element },
            FieldType::Array(_, count) => {
                let count = proc_macro2::Literal::i64_unsuffixed(*count);
                parse_quote! { [#element; #count] }
            }
        }
    }
}

#[derive(Clone, Debug)]
struct FieldAccess {
    base: String,
    offset: i64,
    ty: FieldType,
}

impl FieldAccess {
    fn symbol(&self) -> String {
        format!("{}@{}", self.base, self.offset)
    }

    fn read(&self) -> proc_macro2::TokenStream {
        let base = Ident::new(&self.base, Span::call_site());
        let offset = proc_macro2::Literal::i64_unsuffixed(self.offset);
        let width = proc_macro2::Literal::i64_unsuffixed(self.ty.width());
        let ty = self.ty.rust_type();
        quote! {
            {
                assert!(#offset + #width <= ::core::mem::size_of_val(#base));
                unsafe { (#base.as_ptr() as *const u8).add(#offset).cast::<#ty>().read_unaligned() }
            }
        }
    }
}

fn field_type(ty: &Type) -> std::result::Result<FieldType, String> {
    let scalar = |ty: &Type| match ty {
        Type::Path(path) => path
            .path
            .get_ident()
            .map(|ident| ident.to_string())
            .filter(|name| FIELD_SCALARS.contains(&name.as_str())),
        _ => None,
    };
    if let Some(name) = scalar(ty) {
        return Ok(FieldType::Scalar(name));
    }
    if let Type::Array(array) = ty
        && let Some(element) = scalar(&array.elem)
        && let Some(count) = constant_index(&array.len).filter(|count| *count > 0)
    {
        return Ok(FieldType::Array(element, count));
    }
    Err(format!(
        "a field is one of {} or a fixed array of them, not {}",
        FIELD_SCALARS.join(", "),
        spelled(quote! { #ty })
    ))
}

fn field_access(e: &Expr) -> Option<std::result::Result<FieldAccess, String>> {
    let Expr::Call(call) = e else {
        return None;
    };
    if called_function(call).as_deref() != Some("field") {
        return None;
    }
    let shown = spelled(quote! { #call });
    let malformed = || {
        Err(format!(
            "a field is named as field::<T>(base, byte_offset): {shown}"
        ))
    };
    let Expr::Path(function) = &*call.func else {
        return Some(malformed());
    };
    let PathArguments::AngleBracketed(generics) = &function.path.segments[0].arguments else {
        return Some(malformed());
    };
    let (Some(GenericArgument::Type(ty)), 1) = (generics.args.first(), generics.args.len()) else {
        return Some(malformed());
    };
    let arguments: Vec<&Expr> = call.args.iter().collect();
    let [Expr::Path(base), offset] = arguments.as_slice() else {
        return Some(malformed());
    };
    let (Some(base), Some(offset)) = (base.path.get_ident(), constant_index(offset)) else {
        return Some(malformed());
    };
    if offset < 0 {
        return Some(Err(format!(
            "a field offset is a byte count from the base: {shown}"
        )));
    }
    Some(field_type(ty).map(|ty| FieldAccess {
        base: base.to_string(),
        offset,
        ty,
    }))
}

fn fields_mentioned(e: &Expr, diagnostics: &mut Vec<String>) -> Vec<FieldAccess> {
    let mut named = Vec::new();
    let mut arrays = 0;
    let mut indexed_arrays = 0;
    each_subexpression(e, &mut |sub| {
        if let Expr::Index(indexed) = sub
            && let Some(Ok(field)) = field_access(&indexed.expr)
            && matches!(field.ty, FieldType::Array(..))
        {
            indexed_arrays += 1;
        }
        match field_access(sub) {
            Some(Ok(field)) => {
                if matches!(field.ty, FieldType::Array(..)) {
                    arrays += 1;
                }
                named.push(field)
            }
            Some(Err(problem)) => diagnostics.push(problem),
            None => (),
        }
    });
    if arrays > indexed_arrays {
        diagnostics.push(format!(
            "a field array is compared element by element, as in field::<[u8; 3]>(rf, 53)[..] <= 6: {}",
            spelled(quote! { #e })
        ));
    }
    named
}

fn register_named(e: &Expr) -> Option<std::result::Result<String, String>> {
    let Expr::Call(call) = e else {
        return None;
    };
    if called_function(call).as_deref() != Some("reg") {
        return None;
    }
    Some(match call.args.iter().collect::<Vec<_>>().as_slice() {
        [Expr::Path(name)] if name.path.get_ident().is_some() => Ok(name
            .path
            .get_ident()
            .expect("a single identifier")
            .to_string()),
        _ => Err(format!(
            "reg(..) names one register, as in reg(x8): {}",
            spelled(quote! { #call })
        )),
    })
}

fn each_subexpression<'a>(e: &'a Expr, visit: &mut impl FnMut(&'a Expr)) {
    visit(e);
    let inner: Vec<&Expr> = match e {
        Expr::Binary(b) => vec![&b.left, &b.right],
        Expr::Unary(u) => vec![&u.expr],
        Expr::Paren(p) => vec![&p.expr],
        Expr::Group(g) => vec![&g.expr],
        Expr::Cast(c) => vec![&c.expr],
        Expr::Index(i) => vec![&i.expr, &i.index],
        Expr::Reference(r) => vec![&r.expr],
        Expr::Repeat(r) => vec![&r.expr, &r.len],
        Expr::Array(a) => a.elems.iter().collect(),
        Expr::Call(c) => c.args.iter().collect(),
        Expr::MethodCall(m) => std::iter::once(&*m.receiver).chain(&m.args).collect(),
        Expr::Range(r) => r.start.iter().chain(r.end.iter()).map(|b| &**b).collect(),
        _ => Vec::new(),
    };
    for e in inner {
        each_subexpression(e, visit);
    }
}

fn registers_mentioned(e: &Expr, diagnostics: &mut Vec<String>) -> Vec<String> {
    let mut named = Vec::new();
    each_subexpression(e, &mut |sub| match register_named(sub) {
        Some(Ok(name)) => named.push(name),
        Some(Err(problem)) => diagnostics.push(problem),
        None => (),
    });
    named
}

fn unknown_functions(e: &Expr, diagnostics: &mut Vec<String>) {
    each_subexpression(e, &mut |sub| {
        let Expr::Call(call) = sub else {
            return;
        };
        let known = called_function(call)
            .is_some_and(|name| PRECONDITION_FUNCTIONS.contains(&name.as_str()));
        if !known {
            diagnostics.push(format!(
                "a precondition can call only {}: {}",
                PRECONDITION_FUNCTIONS.join(", "),
                spelled(quote! { #call })
            ));
        } else if called_function(call).as_deref() == Some("clz32") && call.args.len() != 1 {
            diagnostics.push(format!(
                "clz32 takes one value: {}",
                spelled(quote! { #call })
            ));
        }
    });
}

fn register_symbol(name: &str) -> String {
    format!("reg_{name}")
}

const X86_WIDE_REGISTERS: [&str; 15] = [
    "rax", "rbx", "rcx", "rdx", "rsi", "rdi", "rbp", "r8", "r9", "r10", "r11", "r12", "r13", "r14",
    "r15",
];
const X86_WORD_REGISTERS: [&str; 15] = [
    "eax", "ebx", "ecx", "edx", "esi", "edi", "ebp", "r8d", "r9d", "r10d", "r11d", "r12d", "r13d",
    "r14d", "r15d",
];
const X86_ARGUMENT_REGISTERS: [&str; 6] = ["rdi", "rsi", "rdx", "rcx", "r8", "r9"];
const AARCH64_ARGUMENT_REGISTERS: usize = 8;
const AARCH64_LAST_FREE_REGISTER: usize = 28;

struct EntryRegister {
    full: String,
    word_view: bool,
}

fn entry_register(
    isa: bums::machine::Isa,
    name: &str,
) -> std::result::Result<EntryRegister, String> {
    match isa {
        bums::machine::Isa::Aarch64 => {
            let number = name
                .strip_prefix('x')
                .map(|n| (n, false))
                .or_else(|| name.strip_prefix('w').map(|n| (n, true)))
                .and_then(|(n, word)| {
                    let canonical = n == "0" || !n.starts_with('0');
                    n.parse::<usize>()
                        .ok()
                        .filter(|_| canonical)
                        .map(|n| (n, word))
                });
            match number {
                Some((n, word_view)) if n <= AARCH64_LAST_FREE_REGISTER => Ok(EntryRegister {
                    full: format!("x{n}"),
                    word_view,
                }),
                _ => Err(format!(
                    "reg({name}) is not an AArch64 general register x0..x{AARCH64_LAST_FREE_REGISTER} or w0..w{AARCH64_LAST_FREE_REGISTER}"
                )),
            }
        }
        bums::machine::Isa::X86_64 => {
            if X86_WIDE_REGISTERS.contains(&name) {
                return Ok(EntryRegister {
                    full: name.to_string(),
                    word_view: false,
                });
            }
            match X86_WORD_REGISTERS.iter().position(|r| *r == name) {
                Some(k) => Ok(EntryRegister {
                    full: X86_WIDE_REGISTERS[k].to_string(),
                    word_view: true,
                }),
                None => Err(format!(
                    "reg({name}) is not an x86-64 general register other than the stack pointer"
                )),
            }
        }
    }
}

fn argument_register_names(isa: bums::machine::Isa, arguments: usize) -> Vec<String> {
    match isa {
        bums::machine::Isa::Aarch64 => (0..arguments.min(AARCH64_ARGUMENT_REGISTERS))
            .map(|n| format!("x{n}"))
            .collect(),
        bums::machine::Isa::X86_64 => X86_ARGUMENT_REGISTERS
            .iter()
            .take(arguments)
            .map(|r| r.to_string())
            .collect(),
    }
}

const LARGEST_RESULT_IN_REGISTERS: usize = 16;
const AARCH64_HOMOGENEOUS_FLOAT_MEMBERS: usize = 4;

#[derive(Debug, Default, PartialEq)]
struct ReturnContract {
    indirect_bytes: Option<i64>,
    conditions: Vec<bums::engine::ReturnCondition>,
}

fn scalar_return_conditions(
    isa: bums::machine::Isa,
    scalar: &str,
) -> Option<Vec<bums::engine::ReturnCondition>> {
    use bums::engine::{ReturnCondition, ReturnView};
    let aarch64 = isa == bums::machine::Isa::Aarch64;
    let extended_to_a_word = |view: ReturnView, low: i64, high: i64| {
        if aarch64 {
            vec![ReturnCondition::within(
                format!("a {scalar} extended to the 32 bits of w0 that the caller reads"),
                view,
                &[(low, high)],
            )]
        } else {
            Vec::new()
        }
    };
    match scalar {
        "bool" => Some(vec![if aarch64 {
            ReturnCondition::within(
                "a bool, 0 or 1 across the 32 bits of w0 that the caller reads",
                ReturnView::Unsigned(32),
                &[(0, 1)],
            )
        } else {
            ReturnCondition::within("a bool, 0 or 1 in al", ReturnView::Unsigned(8), &[(0, 1)])
        }]),
        "char" => Some(vec![ReturnCondition::within(
            "a char, a Unicode scalar value",
            ReturnView::Unsigned(32),
            &[(0, 0xD7FF), (0xE000, 0x10FFFF)],
        )]),
        "u8" => Some(extended_to_a_word(
            ReturnView::Unsigned(32),
            0,
            u8::MAX as i64,
        )),
        "u16" => Some(extended_to_a_word(
            ReturnView::Unsigned(32),
            0,
            u16::MAX as i64,
        )),
        "i8" => Some(extended_to_a_word(
            ReturnView::Signed(32),
            i8::MIN as i64,
            i8::MAX as i64,
        )),
        "i16" => Some(extended_to_a_word(
            ReturnView::Signed(32),
            i16::MIN as i64,
            i16::MAX as i64,
        )),
        "u32" | "i32" | "u64" | "i64" | "usize" | "isize" | "u128" | "i128" | "f32" | "f64" => {
            Some(Vec::new())
        }
        _ => None,
    }
}

fn plain_scalar(ty: &Type) -> Option<String> {
    match ty {
        Type::Path(p) if p.qself.is_none() => p.path.get_ident().map(|ident| ident.to_string()),
        Type::Paren(inner) => plain_scalar(&inner.elem),
        Type::Group(inner) => plain_scalar(&inner.elem),
        _ => None,
    }
}

#[derive(Debug, Clone, Copy, PartialEq)]
enum CallingConvention {
    C,
    Rust,
}

const LARGEST_RUST_AGGREGATE_IN_A_REGISTER: usize = 8;

fn inhabited_by_every_bit_pattern(ty: &Type) -> std::result::Result<String, &'static str> {
    let element = plain_scalar(ty).ok_or("an aggregate result must hold integers or floats")?;
    let every_bit_pattern_is_a_value = matches!(
        element.as_str(),
        "u8" | "u16"
            | "u32"
            | "u64"
            | "usize"
            | "i8"
            | "i16"
            | "i32"
            | "i64"
            | "isize"
            | "f32"
            | "f64"
    );
    if !every_bit_pattern_is_a_value {
        return Err(
            "an aggregate result must hold integers or floats that every bit pattern inhabits",
        );
    }
    Ok(element)
}

fn rust_aggregate_contract(
    elements: &[&Type],
    is_tuple: bool,
) -> std::result::Result<ReturnContract, &'static str> {
    let mut kinds = BTreeSet::new();
    for element in elements {
        kinds.insert(inhabited_by_every_bit_pattern(element)?);
    }
    let (Some(element), 1) = (kinds.first(), kinds.len()) else {
        return Err("a Rust ABI aggregate result must have one element type");
    };
    let bytes = calculate_size_of(element.clone()) * elements.len();
    let scalar_pair = is_tuple && elements.len() == 2;
    if scalar_pair || bytes <= LARGEST_RUST_AGGREGATE_IN_A_REGISTER {
        Ok(ReturnContract::default())
    } else {
        Ok(ReturnContract {
            indirect_bytes: Some(bytes as i64),
            conditions: Vec::new(),
        })
    }
}

fn return_contract(
    isa: bums::machine::Isa,
    output: &ReturnType,
    convention: CallingConvention,
) -> std::result::Result<ReturnContract, String> {
    let ty = match output {
        ReturnType::Default => return Ok(ReturnContract::default()),
        ReturnType::Type(_, ty) => &**ty,
    };
    let unsupported = |why: &str| {
        Err(format!(
            "returning {} is not supported: {why}",
            spelled(quote! { #ty })
        ))
    };
    match ty {
        Type::Tuple(unit) if unit.elems.is_empty() => Ok(ReturnContract::default()),
        Type::Ptr(_) => Ok(ReturnContract::default()),
        Type::Tuple(tuple) if convention == CallingConvention::Rust && tuple.elems.len() >= 2 => {
            let elements: Vec<&Type> = tuple.elems.iter().collect();
            rust_aggregate_contract(&elements, true).or_else(&unsupported)
        }
        Type::Array(array) => {
            let element = match inhabited_by_every_bit_pattern(&array.elem) {
                Ok(element) => element,
                Err(why) => return unsupported(why),
            };
            let Some(length) = integer_literal(&array.len).filter(|n| *n > 0) else {
                return unsupported("an array result needs a positive literal length");
            };
            let length = length as usize;
            if convention == CallingConvention::Rust {
                let elements = vec![&*array.elem; length];
                return rust_aggregate_contract(&elements, false).or_else(&unsupported);
            }
            let bytes = calculate_size_of(element.clone()) * length;
            let floats_in_vector_registers = isa == bums::machine::Isa::Aarch64
                && matches!(element.as_str(), "f32" | "f64")
                && length <= AARCH64_HOMOGENEOUS_FLOAT_MEMBERS;
            if floats_in_vector_registers || bytes <= LARGEST_RESULT_IN_REGISTERS {
                Ok(ReturnContract::default())
            } else {
                Ok(ReturnContract {
                    indirect_bytes: Some(bytes as i64),
                    conditions: Vec::new(),
                })
            }
        }
        _ => match plain_scalar(ty).and_then(|scalar| scalar_return_conditions(isa, &scalar)) {
            Some(conditions) => Ok(ReturnContract {
                indirect_bytes: None,
                conditions,
            }),
            None => unsupported(
                "where this type's result is returned, and the values Rust trusts it to hold, are not modelled",
            ),
        },
    }
}

fn entry_registers(
    isa: bums::machine::Isa,
    named: &BTreeSet<String>,
    arguments: usize,
    indirect_result: bool,
) -> std::result::Result<Vec<(String, EntryRegister)>, Vec<String>> {
    let result_pointer_takes_an_argument = isa == bums::machine::Isa::X86_64;
    let mut bound = argument_register_names(
        isa,
        arguments + usize::from(indirect_result && result_pointer_takes_an_argument),
    );
    if indirect_result && !result_pointer_takes_an_argument {
        bound.push("x8".to_string());
    }
    let mut problems = Vec::new();
    let mut resolved: Vec<(String, EntryRegister)> = Vec::new();
    for name in named {
        match entry_register(isa, name) {
            Ok(register) => {
                if bound.contains(&register.full) {
                    problems.push(format!(
                        "reg({name}) is bound to an argument of this function, so its value at entry is that argument"
                    ));
                } else if let Some((other, _)) =
                    resolved.iter().find(|(_, r)| r.full == register.full)
                {
                    problems.push(format!(
                        "reg({name}) and reg({other}) are views of one register; state one of them"
                    ));
                } else {
                    resolved.push((name.clone(), register));
                }
            }
            Err(problem) => problems.push(problem),
        }
    }
    if problems.is_empty() {
        Ok(resolved)
    } else {
        Err(problems)
    }
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

enum ElementBound {
    Literal(String, i64),
    Indexed(Box<IndexedBound>),
}

#[derive(Clone)]
enum BoundTarget {
    Slice(String),
    Field(FieldAccess),
    Strided {
        array: String,
        rows: bool,
        skip: i64,
        step: i64,
    },
}

#[derive(Clone)]
struct IndexedBound {
    target: BoundTarget,
    first: Expr,
    end: Option<Expr>,
    to_end: bool,
    comparison: ExprBinary,
}

fn is_comparison(op: &BinOp) -> bool {
    matches!(
        op,
        BinOp::Eq(_) | BinOp::Ne(_) | BinOp::Lt(_) | BinOp::Le(_) | BinOp::Gt(_) | BinOp::Ge(_)
    )
}

fn method_receiver<'a>(e: &'a Expr, method: &str) -> Option<(&'a Expr, Vec<&'a Expr>)> {
    match e {
        Expr::MethodCall(call) if call.method == method => {
            Some((&*call.receiver, call.args.iter().collect()))
        }
        _ => None,
    }
}

fn closure_body(e: &Expr) -> Option<(String, &Expr)> {
    let Expr::Closure(closure) = e else {
        return None;
    };
    let [Pat::Ident(parameter)] = closure.inputs.iter().collect::<Vec<_>>().as_slice() else {
        return None;
    };
    Some((parameter.ident.to_string(), &*closure.body))
}

fn names(e: &Expr, name: &str) -> bool {
    matches!(e, Expr::Path(path) if path.path.is_ident(name))
}

struct StridedAll {
    receiver: Expr,
    skip: i64,
    step: i64,
    comparison: ExprBinary,
}

fn strided_all(e: &Expr) -> Option<std::result::Result<StridedAll, String>> {
    let (walk, arguments) = method_receiver(e, "all")?;
    let shown = || spelled(quote! { #e });
    let [predicate] = arguments.as_slice() else {
        return Some(Err(format!("all takes one closure: {}", shown())));
    };
    let (step, walk) = match method_receiver(walk, "step_by") {
        Some((inner, step)) => (step.first().and_then(|s| constant_index(s)), inner),
        None => (Some(1), walk),
    };
    let (skip, walk) = match method_receiver(walk, "skip") {
        Some((inner, skip)) => (skip.first().and_then(|s| constant_index(s)), inner),
        None => (Some(0), walk),
    };
    let (receiver, _) = method_receiver(walk, "iter")?;
    let (Some(skip), Some(step)) = (skip, step) else {
        return Some(Err(format!(
            "skip and step_by take literal counts: {}",
            shown()
        )));
    };
    if skip < 0 || step < 1 {
        return Some(Err(format!(
            "skip must be >= 0 and step_by >= 1: {}",
            shown()
        )));
    }
    let comparison = closure_body(predicate).and_then(|(element, body)| match body {
        Expr::Binary(b) if is_comparison(&b.op) => match &*b.left {
            Expr::Unary(u) if matches!(u.op, UnOp::Deref(_)) && names(&u.expr, &element) => {
                Some(b.clone())
            }
            _ => None,
        },
        _ => None,
    });
    let Some(comparison) = comparison else {
        return Some(Err(format!(
            "the predicate of all is |e| *e op bound: {}",
            shown()
        )));
    };
    Some(Ok(StridedAll {
        receiver: receiver.clone(),
        skip,
        step,
        comparison,
    }))
}

fn strided_over(array: &Expr, rows: bool, walk: StridedAll) -> Option<IndexedBound> {
    let Expr::Path(array) = array else {
        return None;
    };
    Some(IndexedBound {
        target: BoundTarget::Strided {
            array: array.path.get_ident()?.to_string(),
            rows,
            skip: walk.skip,
            step: walk.step,
        },
        first: parse_quote! { 0 },
        end: None,
        to_end: true,
        comparison: walk.comparison,
    })
}

fn rows_bound(e: &Expr) -> Option<std::result::Result<IndexedBound, String>> {
    let (walk, arguments) = method_receiver(e, "all")?;
    let (rows, _) = method_receiver(walk, "iter")?;
    let [predicate] = arguments.as_slice() else {
        return None;
    };
    let (row, body) = closure_body(predicate)?;
    let inner = match strided_all(body)? {
        Ok(inner) => inner,
        Err(problem) => return Some(Err(problem)),
    };
    if !names(&inner.receiver, &row) {
        return Some(Err(format!(
            "the rows walk starts from the row the closure names: {}",
            spelled(quote! { #e })
        )));
    }
    Some(strided_over(rows, true, inner).ok_or_else(|| {
        format!(
            "all walks the rows of a slice argument: {}",
            spelled(quote! { #e })
        )
    }))
}

fn strided_bound(e: &Expr) -> Option<std::result::Result<IndexedBound, String>> {
    if let Some(rows) = rows_bound(e) {
        return Some(rows);
    }
    let walk = match strided_all(e)? {
        Ok(walk) => walk,
        Err(problem) => return Some(Err(problem)),
    };
    let receiver = walk.receiver.clone();
    Some(
        strided_over(&receiver, false, walk)
            .ok_or_else(|| format!("all walks a slice argument: {}", spelled(quote! { #e }))),
    )
}

fn element_bound(input: &ExprBinary) -> Option<ElementBound> {
    if !is_comparison(&input.op) {
        return None;
    }
    let Expr::Index(indexed) = &*input.left else {
        return None;
    };
    let target = match &*indexed.expr {
        Expr::Path(path) => BoundTarget::Slice(path.path.segments[0].ident.to_string()),
        call @ Expr::Call(_) => match field_access(call)? {
            Ok(field) if matches!(field.ty, FieldType::Array(..)) => BoundTarget::Field(field),
            _ => return None,
        },
        _ => return None,
    };
    if let Expr::Range(range) = &*indexed.index {
        let first = range
            .start
            .as_deref()
            .cloned()
            .unwrap_or_else(|| parse_quote! { 0 });
        let end = range.end.as_deref().cloned();
        let to_end = end.is_none();
        let end = match (&range.limits, end) {
            (RangeLimits::Closed(_), Some(last)) => Some(parse_quote! { #last + 1 }),
            (_, end) => end,
        };
        return Some(ElementBound::Indexed(Box::new(IndexedBound {
            target,
            first,
            end,
            to_end,
            comparison: input.clone(),
        })));
    }
    Some(match (constant_index(&indexed.index), &target) {
        (Some(index), BoundTarget::Slice(array)) => ElementBound::Literal(array.clone(), index),
        _ => ElementBound::Indexed(Box::new(IndexedBound {
            target,
            first: (*indexed.index).clone(),
            end: None,
            to_end: false,
            comparison: input.clone(),
        })),
    })
}

fn exact_index(index: &Expr) -> proc_macro2::TokenStream {
    let exact = exact_value(index);
    quote! { usize::try_from(#exact).expect(#PRECONDITION_OVERFLOW) }
}

fn indexed_bound_check(bound: &IndexedBound, original: &Expr) -> proc_macro2::TokenStream {
    let elements = match &bound.target {
        BoundTarget::Slice(array) => {
            let array = Ident::new(array, Span::call_site());
            quote! { #array }
        }
        BoundTarget::Field(field) => field.read(),
        BoundTarget::Strided { .. } => return quote! { assert!(#original); },
    };
    let op = &bound.comparison.op;
    let exact_bound = exact_value(&bound.comparison.right);
    let first = exact_index(&bound.first);
    match (&bound.end, bound.to_end) {
        (None, false) => {
            let element = exact_leaf(quote! { (#elements)[#first] });
            quote! { assert!(#element #op #exact_bound); }
        }
        (end, _) => {
            let end = match end {
                Some(end) => exact_index(end),
                None => quote! { (#elements).len() },
            };
            quote! {
                assert!((#elements)[#first..#end].iter().all(|e| i128::try_from(*e).expect(#PRECONDITION_OVERFLOW) #op #exact_bound));
            }
        }
    }
}

type PointerContent = (String, i64, String, &'static str, Option<(bool, Expr)>);

fn tuple_field(input: &ExprBinary, inputs: &Punctuated<FnArg, Token![,]>) -> Option<(String, i64)> {
    if !matches!(input.op, BinOp::Eq(_)) {
        return None;
    }
    let Expr::Field(field) = &*input.left else {
        return None;
    };
    let Expr::Path(base) = &*field.base else {
        return None;
    };
    let Member::Unnamed(index) = &field.member else {
        return None;
    };
    let name = base.path.segments[0].ident.to_string();
    let tuple = inputs.iter().find_map(|argument| match argument {
        FnArg::Typed(typed) => match (&*typed.pat, &*typed.ty) {
            (Pat::Ident(ident), Type::Reference(reference)) if ident.ident == name => {
                match &*reference.elem {
                    Type::Tuple(tuple) => Some((tuple.clone(), reference.mutability.is_some())),
                    _ => None,
                }
            }
            _ => None,
        },
        _ => None,
    })?;
    let (tuple, mutable) = tuple;
    let (offsets, _) = tuple_layout(tuple.elems.iter());
    let region = name + if mutable { "_as_mut_ptr" } else { "_as_ptr" };
    Some((region, *offsets.get(index.index as usize)? as i64))
}

fn pointer_contents(
    input: &ExprBinary,
    arguments: &Punctuated<Expr, Token![,]>,
    inputs: &Punctuated<FnArg, Token![,]>,
) -> Option<PointerContent> {
    let (region, offset) = match indexed_element(input) {
        Some((array, element)) => {
            let (array_suffix, _) = passed_pointer(&array, arguments)?;
            (format!("{}{}", array, array_suffix), element * 8)
        }
        None => tuple_field(input, inputs)?,
    };
    let (slice, suffix, step) = pointer_source(&input.right)?;
    Some((region, offset, slice, suffix, step))
}

const POINTER_FIELD_TYPES: [&str; 4] = ["usize", "u64", "isize", "i64"];

fn wrapping_pointer(source: &Expr) -> Expr {
    match source {
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
    }
}

fn field_pointer(
    input: &ExprBinary,
    arguments: &Punctuated<Expr, Token![,]>,
) -> Option<std::result::Result<(PointerContent, FieldAccess), String>> {
    if !matches!(input.op, BinOp::Eq(_)) {
        return None;
    }
    let field = match field_access(&input.left)? {
        Ok(field) => field,
        Err(problem) => return Some(Err(problem)),
    };
    let (slice, suffix, step) = pointer_source(&input.right)?;
    if !matches!(&field.ty, FieldType::Scalar(t) if POINTER_FIELD_TYPES.contains(&t.as_str())) {
        return Some(Err(format!(
            "a pointer field is 8 bytes, one of {}: {}",
            POINTER_FIELD_TYPES.join(", "),
            spelled(quote! { #input })
        )));
    }
    let Some((base_suffix, _)) = passed_pointer(&field.base, arguments) else {
        return Some(Err(format!(
            "{} must be passed as a pointer to hold fields",
            field.base
        )));
    };
    Some(Ok((
        (
            format!("{}{}", field.base, base_suffix),
            field.offset,
            slice,
            suffix,
            step,
        ),
        field,
    )))
}

type PointerSource = (String, &'static str, Option<(bool, Expr)>);

fn pointer_source(right: &Expr) -> Option<PointerSource> {
    let (call, step) = match right {
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
    Some((slice.path.segments[0].ident.to_string(), suffix, step))
}

#[derive(Clone)]
struct PointerArray {
    array: String,
    element: String,
    row_length: Expr,
    rows: Expr,
    writable: bool,
}

fn pointer_array_shape(input: &ExprBinary) -> Option<PointerArray> {
    if !matches!(input.op, BinOp::Eq(_)) {
        return None;
    }
    let Expr::Path(array) = &*input.left else {
        return None;
    };
    let Expr::Repeat(rows) = &*input.right else {
        return None;
    };
    let Expr::Reference(reference) = &*rows.expr else {
        return None;
    };
    let Expr::Repeat(row) = &*reference.expr else {
        return None;
    };
    let Expr::Path(element) = &*row.expr else {
        return None;
    };
    Some(PointerArray {
        array: array.path.segments[0].ident.to_string(),
        element: element.path.segments[0].ident.to_string(),
        row_length: (*row.len).clone(),
        rows: (*rows.len).clone(),
        writable: reference.mutability.is_some(),
    })
}

fn integer_literal(e: &Expr) -> Option<i64> {
    match e {
        Expr::Lit(ExprLit {
            lit: Lit::Int(value),
            ..
        }) => value.base10_parse::<i64>().ok(),
        Expr::Paren(inner) => integer_literal(&inner.expr),
        _ => None,
    }
}

fn element_field(input: &ExprBinary) -> Option<(Expr, (i64, i64))> {
    let Expr::Binary(masked) = &*input.left else {
        return None;
    };
    if !matches!(masked.op, BinOp::BitAnd(_)) {
        return None;
    }
    let mask = integer_literal(&masked.right)?;
    let bits = (mask + 1).trailing_zeros() as i64;
    if mask <= 0 || (mask + 1) & mask != 0 {
        return None;
    }
    let inner = match &*masked.left {
        Expr::Paren(paren) => (*paren.expr).clone(),
        other => other.clone(),
    };
    match &inner {
        Expr::Binary(shifted) if matches!(shifted.op, BinOp::Shr(_)) => Some((
            (*shifted.left).clone(),
            (integer_literal(&shifted.right)?, bits),
        )),
        _ => Some((inner, (0, bits))),
    }
}

fn element_range_array(input: &ExprBinary) -> Option<String> {
    let left = element_field(input).map_or_else(|| (*input.left).clone(), |(element, _)| element);
    let Expr::Index(indexed) = &left else {
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

struct RowPointers {
    row: Type,
    checked: bool,
    writable_rows: bool,
}

fn row_pointer_type(ty: &Type) -> Option<RowPointers> {
    let Type::Reference(reference) = ty else {
        return None;
    };
    let Type::Slice(slice) = &*reference.elem else {
        return None;
    };
    match &*slice.elem {
        Type::Ptr(pointer) => Some(RowPointers {
            row: Type::Ptr(pointer.clone()),
            checked: false,
            writable_rows: pointer.mutability.is_some(),
        }),
        Type::Reference(row) => match &*row.elem {
            Type::Slice(slice) => {
                let element = &slice.elem;
                let writable_rows = row.mutability.is_some() && reference.mutability.is_some();
                Some(RowPointers {
                    row: if writable_rows {
                        parse_quote! { *mut #element }
                    } else {
                        parse_quote! { *const #element }
                    },
                    checked: true,
                    writable_rows,
                })
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

fn without_parens(e: &Expr) -> &Expr {
    match e {
        Expr::Paren(p) => without_parens(&p.expr),
        Expr::Group(g) => without_parens(&g.expr),
        _ => e,
    }
}

fn comparisons_only(e: &Expr) -> bool {
    match e {
        Expr::Paren(p) => comparisons_only(&p.expr),
        Expr::Binary(b) if matches!(b.op, BinOp::Or(_)) => {
            comparisons_only(&b.left) && comparisons_only(&b.right)
        }
        _ => conjunction_of_comparisons(e),
    }
}

fn conjunction_of_comparisons(e: &Expr) -> bool {
    match e {
        Expr::Paren(p) => conjunction_of_comparisons(&p.expr),
        Expr::Binary(b) => match b.op {
            BinOp::And(_) => {
                conjunction_of_comparisons(&b.left) && conjunction_of_comparisons(&b.right)
            }
            BinOp::Eq(_)
            | BinOp::Ne(_)
            | BinOp::Lt(_)
            | BinOp::Le(_)
            | BinOp::Gt(_)
            | BinOp::Ge(_) => true,
            _ => false,
        },
        _ => false,
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
        Expr::Call(call)
            if called_function(call).as_deref() == Some("clz32") && call.args.len() == 1 =>
        {
            let inner = exact_value(&call.args[0]);
            quote! { i128::from(((#inner).rem_euclid(1i128 << 32) as u32).leading_zeros()) }
        }
        Expr::Call(_) if matches!(field_access(e), Some(Ok(_))) => {
            let Some(Ok(field)) = field_access(e) else {
                unreachable!()
            };
            exact_leaf(field.read())
        }
        Expr::Lit(ExprLit {
            lit: Lit::Int(literal),
            ..
        }) if literal.suffix().is_empty() => {
            let wide = LitInt::new(&format!("{}i128", literal.base10_digits()), literal.span());
            quote! { #wide }
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
        UnOp::Neg(_) => match expr {
            AbstractExpression::Immediate(value) => AbstractExpression::Immediate(
                value.checked_neg().expect("negated integer out of range"),
            ),
            other => generate_expression("-", AbstractExpression::Immediate(0), other),
        },
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
        Expr::Call(call) => match (called_function(call).as_deref(), register_named(input)) {
            (_, Some(Ok(name))) => AbstractExpression::Abstract(register_symbol(&name)),
            (Some("clz32"), _) if call.args.len() == 1 => generate_expression(
                "clz",
                syn_expr_to_abstract_expression(&call.args[0]),
                AbstractExpression::Immediate(32),
            ),
            (Some("field"), _) => match field_access(input) {
                Some(Ok(field)) if matches!(field.ty, FieldType::Scalar(_)) => {
                    AbstractExpression::Abstract(field.symbol())
                }
                _ => panic!(
                    "a field array is compared element by element, as in field::<[u8; 3]>(rf, 53)[..] <= 6: {}",
                    spelled(quote! { #call })
                ),
            },
            _ => panic!(
                "unsupported call in a precondition: {}",
                spelled(quote! { #call })
            ),
        },
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
    pub symbol: String,
    pub rejects: bool,
    pub asm_file: String,
    pub diagnostics: Vec<String>,
    pub expansion: TokenStream,
    signature: Signature,
    red_zone: Option<i64>,
    convention: CallingConvention,
    argument_list: Punctuated<Expr, Token![,]>,
    regions: Vec<FnArg>,
    input_sizes: BTreeMap<String, usize>,
    pointer_sizes: BTreeMap<String, String>,
    input_types: BTreeMap<String, Type>,
    input_expressions: BTreeMap<String, Expr>,
    new_structs: BTreeMap<String, ItemStruct>,
    pointer_offsets: BTreeMap<usize, (bool, Expr)>,
    pointer_values: Vec<PointerContent>,
    element_bounds: Vec<(String, i64, ExprBinary)>,
    element_ranges: Vec<(String, ExprBinary)>,
    pointer_arrays: Vec<PointerArray>,
    invariants: Vec<AbstractComparison>,
    combinations: Vec<Vec<AbstractComparison>>,
    unchecked_rows: Vec<String>,
    unchecked_pointer_fields: Vec<(String, usize)>,
    register_preconditions: BTreeSet<String>,
    indexed_bounds: Vec<IndexedBound>,
    fields: Vec<FieldAccess>,
}

pub struct Verdict {
    pub failures: Vec<String>,
    pub rejected: Vec<String>,
    pub findings: Vec<String>,
    pub diagnostics: Vec<String>,
}

fn lower_fields(
    engine: &mut bums::engine::AnyEngine,
    region: &str,
    fields: &[(String, Type)],
) -> std::result::Result<(), String> {
    let (offsets, _) = tuple_layout(fields.iter().map(|(_, ty)| ty));
    for (k, ((field, ty), offset)) in fields.iter().zip(offsets.iter()).enumerate() {
        let value = AbstractExpression::Abstract(field.clone());
        match ty {
            Type::Path(p) => {
                engine.add_abstract_to_memory_sized(
                    region.to_string(),
                    *offset as i64,
                    value.clone(),
                    field_layout(ty).0 as i64,
                );
                let bits = [
                    ("u8", 8),
                    ("u16", 16),
                    ("u32", 32),
                    ("u64", 64),
                    ("usize", 64),
                ]
                .iter()
                .find(|(unsigned, _)| p.path.is_ident(unsigned))
                .map(|(_, bits)| *bits);
                if let Some(bits) = bits {
                    engine.add_invariant(AbstractComparison::new(
                        ">=",
                        value.clone(),
                        AbstractExpression::Immediate(0),
                    ));
                    if bits < 64 {
                        engine.add_invariant(AbstractComparison::new(
                            "<",
                            value,
                            AbstractExpression::Immediate(1 << bits),
                        ));
                    }
                }
            }
            Type::Ptr(pointer) => {
                engine.add_abstract_to_memory_sized(region.to_string(), *offset as i64, value, 8);
                let access = if pointer.mutability.is_some() {
                    RegionType::RW
                } else {
                    RegionType::READ
                };
                match &*pointer.elem {
                    Type::Array(blob) => engine.add_region(
                        access,
                        field.clone(),
                        AbstractExpression::Immediate(calculate_size_of_array(blob) as i64),
                    ),
                    Type::Tuple(inner) => {
                        let (_, size) = tuple_layout(inner.elems.iter());
                        engine.add_region(
                            access,
                            field.clone(),
                            AbstractExpression::Immediate(size as i64),
                        );
                        let inner_fields: Vec<(String, Type)> = inner
                            .elems
                            .iter()
                            .enumerate()
                            .map(|(i, ty)| (format!("{field}_field{i}"), ty.clone()))
                            .collect();
                        lower_fields(engine, field, &inner_fields)?;
                    }
                    Type::Path(p) => {
                        let Some((length_field, _)) = fields.get(k + 1) else {
                            return Err(
                                "a pointer field must be followed by its usize length".to_string()
                            );
                        };
                        let element = p.path.segments[0].ident.to_string();
                        engine.add_region(
                            access,
                            field.clone(),
                            byte_length(length_field, Some(&element)),
                        );
                    }
                    other => todo!("pointer field to {:?}", other),
                }
            }
            Type::Array(_) => {}
            other => todo!("unsupported tuple type {:?}", other),
        }
    }
    Ok(())
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
    let convention = match attributes.options.abi.as_ref().map(LitStr::value).as_deref() {
        Some("Rust") => CallingConvention::Rust,
        _ => CallingConvention::C,
    };
    for isa in [bums::machine::Isa::Aarch64, bums::machine::Isa::X86_64] {
        if let Err(problem) = return_contract(isa, &vars.item_fn.output, convention) {
            return Err(syn::Error::new_spanned(&vars.item_fn.output, problem));
        }
    }
    let symbol = attributes
        .options
        .symbol
        .as_ref()
        .map_or_else(|| vars.item_fn.ident.to_string(), LitStr::value);
    let rejects = attributes.options.rejects;
    let red_zone = attributes
        .options
        .red_zone
        .as_ref()
        .map(|bytes| {
            let parsed = bytes.base10_parse::<i64>()?;
            if !(0..=APPLE_ARM64_RED_ZONE).contains(&parsed) {
                return Err(syn::Error::new_spanned(
                    bytes,
                    format!(
                        "red_zone must be at most {APPLE_ARM64_RED_ZONE} bytes, the red zone the Apple arm64 ABI guarantees"
                    ),
                ));
            }
            Ok(parsed)
        })
        .transpose()?;
    let mut diagnostics = Vec::new();
    let fn_name = &vars.item_fn.ident;
    let output = &vars.item_fn.output;

    let mut invariants: Vec<AbstractComparison> = Vec::new();
    let mut element_bounds: Vec<(String, i64, ExprBinary)> = Vec::new();
    let mut pointer_values: Vec<PointerContent> = Vec::new();
    let mut element_ranges: Vec<(String, ExprBinary)> = Vec::new();
    let mut pointer_arrays: Vec<PointerArray> = Vec::new();
    let mut disjunctions: Vec<Vec<Vec<AbstractComparison>>> = Vec::new();
    let mut register_preconditions: BTreeSet<String> = BTreeSet::new();
    let mut indexed_bounds: Vec<IndexedBound> = Vec::new();
    let mut declared_fields: Vec<FieldAccess> = Vec::new();
    let mut pointer_fields: BTreeSet<(String, i64)> = BTreeSet::new();
    let mut strided_bounds: Vec<(IndexedBound, Expr)> = Vec::new();
    let mut asserts = quote! {};
    let argument_list = attributes.argument_list.clone();
    if let Some(Expr::Array(a)) = argument_list.last() {
        for e in &a.elems {
            let well_formed = diagnostics.len();
            unknown_functions(e, &mut diagnostics);
            let registers = registers_mentioned(e, &mut diagnostics);
            let fields = fields_mentioned(e, &mut diagnostics);
            if diagnostics.len() > well_formed {
                continue;
            }
            declared_fields.extend(fields);
            if let Some(bound) = strided_bound(e) {
                match bound {
                    Ok(bound) => strided_bounds.push((bound, e.clone())),
                    Err(problem) => diagnostics.push(problem),
                }
                continue;
            }
            if !registers.is_empty() {
                register_preconditions.extend(registers);
                let mut reads_memory = false;
                each_subexpression(e, &mut |sub| {
                    reads_memory |= matches!(
                        sub,
                        Expr::Index(_) | Expr::Repeat(_) | Expr::Reference(_) | Expr::Range(_)
                    );
                });
                if reads_memory || !comparisons_only(e) {
                    diagnostics.push(format!(
                        "a register precondition compares values with ==, !=, <, <=, >, >=, && and ||: {}",
                        spelled(quote! { #e })
                    ));
                } else if matches!(without_parens(e), Expr::Binary(b) if matches!(b.op, BinOp::Or(_)))
                {
                    let mut alternatives = Vec::new();
                    disjuncts(e, &mut alternatives, &mut diagnostics);
                    disjunctions.push(alternatives);
                } else {
                    conjuncts(e, &mut invariants, &mut diagnostics);
                }
                continue;
            }
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
                    let field = element_field(b);
                    let element = field
                        .as_ref()
                        .map_or_else(|| (*b.left).clone(), |(e, _)| e.clone());
                    let Expr::Index(indexed) = &element else {
                        unreachable!()
                    };
                    let (collection, op) = (&indexed.expr, &b.op);
                    let exact_bound = exact_value(&b.right);
                    let read = match field {
                        Some((_, (shift, bits))) => {
                            let mask = (1i128 << bits) - 1;
                            quote! { (((*e as i128) >> #shift) & #mask) }
                        }
                        None => quote! { (*e as i128) },
                    };
                    asserts = quote! {
                        #asserts
                        assert!(#collection.iter().all(|e| #read #op #exact_bound));
                    };
                    element_ranges.push((array, b.clone()));
                    continue;
                }
                if let Some(pointer) = field_pointer(b, &attributes.argument_list) {
                    match pointer {
                        Ok((value, field)) => {
                            let stored = field.read();
                            let source = wrapping_pointer(&b.right);
                            asserts = quote! { #asserts assert!((#stored) as usize == #source as usize); };
                            pointer_fields.insert((field.base.clone(), field.offset));
                            pointer_values.push(value);
                        }
                        Err(problem) => diagnostics.push(problem),
                    }
                    continue;
                }
                if let Some(value) =
                    pointer_contents(b, &attributes.argument_list, &vars.item_fn.inputs)
                {
                    let stored = &*b.left;
                    let source = wrapping_pointer(&b.right);
                    asserts = quote! { #asserts assert!((#stored) as usize == #source as usize); };
                    pointer_values.push(value);
                    continue;
                }
                match element_bound(b) {
                    Some(ElementBound::Literal(array, index)) => {
                        element_bounds.push((array, index, b.clone()));
                        let exact = exact_condition(e);
                        asserts = quote! { #asserts assert!(#exact); };
                        continue;
                    }
                    Some(ElementBound::Indexed(bound)) => {
                        let check = indexed_bound_check(&bound, e);
                        asserts = quote! { #asserts #check };
                        indexed_bounds.push(*bound);
                        continue;
                    }
                    None => (),
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
                && let Some(pointers) = row_pointer_type(ty)
                && pointers.checked
            {
                let rows = &call.receiver;
                let row = &pointers.row;
                arguments_to_pass.push(if pointers.writable_rows {
                    parse_quote! {
                        #rows.iter_mut().map(|row| row.as_mut_ptr()).collect::<Vec<#row>>().as_ptr()
                    }
                } else {
                    parse_quote! {
                        #rows.iter().map(|row| row.as_ptr()).collect::<Vec<#row>>().as_ptr()
                    }
                });
            } else {
                arguments_to_pass.push(i.clone());
            }
        }
    }

    let mut unchecked_rows = Vec::new();
    for shape in &pointer_arrays {
        let array = &shape.array;
        let rows = Ident::new(array, proc_macro2::Span::call_site());
        let exact_count = exact_value(&shape.rows);
        let exact_rows = exact_leaf(quote! { #rows.len() });
        asserts = quote! { #asserts assert!(#exact_rows == #exact_count); };
        let pointers = input_types.get(array).and_then(row_pointer_type);
        if let Some(pointers) = &pointers
            && shape.writable
            && !pointers.writable_rows
        {
            diagnostics.push(format!(
                "{array} == [&mut ..] declares writable rows, so {array} must be &mut [&mut [T]] or a slice of *mut T"
            ));
        }
        match pointers {
            Some(pointers) if pointers.checked => {
                let exact_len = exact_value(&shape.row_length);
                let exact_row = exact_leaf(quote! { row.len() });
                asserts = quote! {
                    #asserts
                    assert!(#rows.iter().all(|row| #exact_row == #exact_len));
                };
            }
            Some(_) => unchecked_rows.push(array.clone()),
            None => diagnostics.push(format!(
                "{} must be a slice of row references or raw pointers",
                array
            )),
        }
    }
    for (bound, original) in &strided_bounds {
        let BoundTarget::Strided { array, rows, .. } = &bound.target else {
            unreachable!()
        };
        let checked = match (rows, input_types.get(array)) {
            (true, Some(ty)) => row_pointer_type(ty).map(|pointers| pointers.checked),
            (false, Some(Type::Reference(r))) => matches!(&*r.elem, Type::Slice(_)).then_some(true),
            _ => None,
        };
        match checked {
            Some(true) => asserts = quote! { #asserts assert!(#original); },
            Some(false) if !unchecked_rows.contains(array) => unchecked_rows.push(array.clone()),
            Some(false) => (),
            None => diagnostics.push(format!(
                "{array} must be a slice{} to walk it: {}",
                if *rows { " of rows" } else { "" },
                spelled(quote! { #original })
            )),
        }
    }
    let mut layout: BTreeMap<(String, i64), FieldType> = BTreeMap::new();
    for field in &declared_fields {
        let key = (field.base.clone(), field.offset);
        match layout.get(&key) {
            Some(ty) if *ty != field.ty => diagnostics.push(format!(
                "the field at byte {} of {} is declared as both {} and {}",
                field.offset,
                field.base,
                ty.shown(),
                field.ty.shown()
            )),
            _ => {
                layout.insert(key, field.ty.clone());
            }
        }
    }
    let mut reached: Option<(String, i64)> = None;
    for ((base, offset), ty) in &layout {
        if let Some((previous, end)) = &reached
            && previous == base
            && offset < end
        {
            diagnostics.push(format!(
                "the field at byte {offset} of {base} overlaps the field before it, which ends at byte {end}"
            ));
        }
        let end = offset + ty.width();
        reached = match reached {
            Some((previous, before)) if previous == *base => Some((previous, before.max(end))),
            _ => Some((base.clone(), end)),
        };
        let slice = matches!(input_types.get(base), Some(Type::Reference(r)) if matches!(&*r.elem, Type::Slice(_)));
        if !slice {
            diagnostics.push(format!("{base} must be a slice argument to hold fields"));
        }
    }
    let fields: Vec<FieldAccess> = layout
        .iter()
        .filter(|(key, ty)| matches!(ty, FieldType::Scalar(_)) && !pointer_fields.contains(*key))
        .map(|((base, offset), ty)| FieldAccess {
            base: base.clone(),
            offset: *offset,
            ty: ty.clone(),
        })
        .collect();
    indexed_bounds.extend(strided_bounds.iter().map(|(bound, _)| bound.clone()));

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
    extern_fn.output = ReturnType::Default;
    let mut pointer_offsets: BTreeMap<usize, (bool, Expr)> = BTreeMap::new();
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
                        pointer_offsets.insert(new_args.len(), (scaled, expression));
                    }
                    match a.method.to_string().as_str() {
                        "len" => {
                            let n = Ident::new(&(var_name + "_len"), span);
                            new_args.push(parse_quote! {#n: usize});
                        }
                        "as_ptr" => {
                            let n = Ident::new(&(var_name.clone() + "_as_ptr"), span);
                            if let Some(pointers) =
                                input_types.get(&var_name).and_then(row_pointer_type)
                            {
                                let row = pointers.row;
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

    let red_zone_target_check = red_zone.map(|_| {
        quote! {
            #[cfg(not(target_vendor = "apple"))]
            compile_error!(#RED_ZONE_NEEDS_APPLE);
        }
    });
    let rust_abi_target_check = (convention == CallingConvention::Rust).then(|| {
        quote! {
            #[cfg(not(target_vendor = "apple"))]
            compile_error!(#RUST_ABI_NEEDS_APPLE);
        }
    });

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
    if rejects
        || !unchecked_rows.is_empty()
        || !unchecked_pointer_fields.is_empty()
        || !register_preconditions.is_empty()
    {
        original_fn_call.unsafety = Some(Default::default());
    }
    let extern_abi = match convention {
        CallingConvention::C => quote! { "C" },
        CallingConvention::Rust => quote! { "Rust" },
    };
    let (returned_array_declaration, extern_output, unwrapped_result) = match output {
        ReturnType::Type(arrow, ty)
            if convention == CallingConvention::C && matches!(&**ty, Type::Array(_)) =>
        {
            (
                quote! {
                    #[repr(C)]
                    struct ReturnedArray(#ty);
                },
                quote! { #arrow ReturnedArray },
                quote! { #invocation.0 },
            )
        }
        _ => (quote! {}, quote! { #output }, quote! { #invocation }),
    };
    let link_name = (vars.item_fn.ident != symbol).then(|| quote! { #[link_name = #symbol] });
    let unsafe_block: Stmt = parse_quote! {
        #original_fn_call {

            #asserts;

            #struct_decs;

            #returned_array_declaration

            unsafe extern #extern_abi {
                #link_name
                #extern_fn #extern_output;
            }
            unsafe {
                #before_call
                let result = #unwrapped_result;
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
        symbol,
        rejects,
        asm_file: attributes.filename.value(),
        diagnostics,
        expansion: quote! {
            #unsafe_block
            #red_zone_target_check
            #rust_abi_target_check
        },
        signature: vars.item_fn.clone(),
        red_zone,
        convention,
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
        register_preconditions,
        indexed_bounds,
        fields,
    })
}

fn slice_element(ty: Option<&Type>) -> Option<String> {
    match ty? {
        Type::Reference(r) => match &*r.elem {
            Type::Slice(sl) => Some(calculate_type_of_slice_ptr(sl)),
            _ => None,
        },
        _ => None,
    }
}

impl Annotation {
    fn region_holding(&self, name: &str) -> std::result::Result<String, String> {
        if let Some((suffix, _)) = passed_pointer(name, &self.argument_list) {
            return Ok(format!("{name}{suffix}"));
        }
        self.pointer_values
            .iter()
            .find(|(_, _, slice, ..)| slice == name)
            .map(|(_, _, slice, suffix, _)| format!("{slice}{suffix}"))
            .ok_or_else(|| {
                format!(
                    "{name} is neither passed as a pointer nor stored where the assembly finds it"
                )
            })
    }

    fn bound_placement(
        &self,
        bound: &IndexedBound,
    ) -> std::result::Result<(String, String, i64, i64, AbstractExpression), String> {
        let not_a_slice = |array: &str| {
            format!("{array} is not a slice, so an element precondition on it has no element size")
        };
        let walked = |length: AbstractExpression, skip: i64, step: i64| {
            generate_expression(
                "/",
                generate_expression("+", length, AbstractExpression::Immediate(step - 1 - skip)),
                AbstractExpression::Immediate(step),
            )
        };
        match &bound.target {
            BoundTarget::Slice(array) => {
                let element =
                    slice_element(self.input_types.get(array)).ok_or_else(|| not_a_slice(array))?;
                let width = calculate_size_of(element.clone()) as i64;
                Ok((
                    self.region_holding(array)?,
                    element,
                    0,
                    width,
                    AbstractExpression::Abstract(format!("{array}_len")),
                ))
            }
            BoundTarget::Field(field) => {
                let FieldType::Array(element, count) = &field.ty else {
                    unreachable!()
                };
                Ok((
                    self.region_holding(&field.base)?,
                    element.clone(),
                    field.offset,
                    field.ty.element_width(),
                    AbstractExpression::Immediate(*count),
                ))
            }
            BoundTarget::Strided {
                array,
                rows: false,
                skip,
                step,
            } => {
                let element =
                    slice_element(self.input_types.get(array)).ok_or_else(|| not_a_slice(array))?;
                let width = calculate_size_of(element.clone()) as i64;
                Ok((
                    self.region_holding(array)?,
                    element,
                    skip * width,
                    step * width,
                    walked(
                        AbstractExpression::Abstract(format!("{array}_len")),
                        *skip,
                        *step,
                    ),
                ))
            }
            BoundTarget::Strided {
                array,
                rows: true,
                skip,
                step,
            } => {
                let shape = self
                    .pointer_arrays
                    .iter()
                    .find(|shape| shape.array == *array)
                    .ok_or_else(|| {
                        format!("the rows of {array} are walked, so state their shape as {array} == [&[T; N]; M]")
                    })?;
                let width = calculate_size_of(shape.element.clone()) as i64;
                Ok((
                    format!("{array}_row"),
                    shape.element.clone(),
                    skip * width,
                    step * width,
                    walked(
                        syn_expr_to_abstract_expression(&shape.row_length),
                        *skip,
                        *step,
                    ),
                ))
            }
        }
    }

    pub fn unsupported_on(&self, target_vendor: &str) -> Option<String> {
        if target_vendor == "apple" {
            return None;
        }
        if self.red_zone.is_some() {
            return Some(RED_ZONE_NEEDS_APPLE.to_string());
        }
        (self.convention == CallingConvention::Rust).then(|| RUST_ABI_NEEDS_APPLE.to_string())
    }

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
            let returned = return_contract(engine.isa(), output, self.convention)?;
            if let Some(bytes) = returned.indirect_bytes {
                engine.return_through_pointer(format!("{fn_name}_result"), bytes);
            }
            for condition in returned.conditions.iter().cloned() {
                engine.require_of_return_value(condition);
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
                                let from_a_reference = no_suffix != name
                                    && matches!(
                                        input_types.get(no_suffix),
                                        Some(Type::Reference(_))
                                    );
                                if from_a_reference {
                                    engine.add_invariant(AbstractComparison::new(
                                        "!=",
                                        AbstractExpression::Abstract(name.clone()),
                                        AbstractExpression::Immediate(0),
                                    ));
                                }

                                if let Some((scaled, expression)) = pointer_offsets.get(&i) {
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
                                            let fields: Vec<(String, Type)> = s
                                                .fields
                                                .iter()
                                                .map(|f| {
                                                    (
                                                        f.ident
                                                            .clone()
                                                            .expect("tuple fields are named")
                                                            .to_string(),
                                                        f.ty.clone(),
                                                    )
                                                })
                                                .collect();
                                            lower_fields(&mut engine, &name, &fields)?;
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

            let registers = entry_registers(
                engine.isa(),
                &self.register_preconditions,
                arguments_to_memory_safe_regions.len(),
                returned.indirect_bytes.is_some(),
            )
            .map_err(|problems| problems.join("; "))?;
            for (name, register) in registers {
                let symbol = register_symbol(&name);
                if register.word_view {
                    let value = AbstractExpression::Abstract(symbol.clone());
                    for (op, bound) in [(">=", 0), ("<=", u32::MAX as i64)] {
                        engine.add_invariant(AbstractComparison::new(
                            op,
                            value.clone(),
                            AbstractExpression::Immediate(bound),
                        ));
                    }
                    engine.add_abstract(register.full, with_unspecified_upper_bits(&symbol));
                } else {
                    engine.add_abstract(register.full, AbstractExpression::Abstract(symbol));
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
                let narrow = syn::parse_str::<TypePath>(&element)
                    .ok()
                    .and_then(|ty| narrow_argument_range(&ty));
                let element_range = match narrow {
                    Some((least, most)) => vec![(">=", least), ("<=", most)],
                    None if element.starts_with('u') => vec![(">=", 0)],
                    None => Vec::new(),
                };
                for (op, bound) in element_range {
                    engine.add_invariant(AbstractComparison::new(
                        op,
                        AbstractExpression::Abstract(symbol.clone()),
                        AbstractExpression::Immediate(bound),
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
                match element_field(comparison) {
                    Some((_, field)) => engine.add_element_field_range(
                        array.clone() + suffix,
                        calculate_size_of(element.clone()) as i64,
                        operator_of(&comparison.op),
                        syn_expr_to_abstract_expression(&comparison.right),
                        field,
                    ),
                    None => engine.add_element_range(
                        array.clone() + suffix,
                        calculate_size_of(element.clone()) as i64,
                        element.starts_with('i'),
                        operator_of(&comparison.op),
                        syn_expr_to_abstract_expression(&comparison.right),
                    ),
                }
            }
            for shape in pointer_arrays {
                let array = &shape.array;
                let pointers = match self.region_holding(array) {
                    Ok(pointers) => pointers,
                    Err(problem) => {
                        diagnostics.push(problem);
                        continue;
                    }
                };
                engine.add_invariant(AbstractComparison::new(
                    "==",
                    AbstractExpression::Abstract(array.clone() + "_len"),
                    syn_expr_to_abstract_expression(&shape.rows),
                ));
                let row = array.clone() + "_row";
                engine.add_region(
                    if shape.writable {
                        RegionType::RW
                    } else {
                        RegionType::READ
                    },
                    row.clone(),
                    generate_expression(
                        "*",
                        syn_expr_to_abstract_expression(&shape.row_length),
                        AbstractExpression::Immediate(
                            calculate_size_of(shape.element.clone()) as i64
                        ),
                    ),
                );
                engine.add_pointer_elements(pointers, row);
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
            for field in &self.fields {
                let region = self.region_holding(&field.base)?;
                let symbol = AbstractExpression::Abstract(field.symbol());
                engine.add_field(region, field.offset, field.ty.width(), symbol.clone())?;
                let element = field.ty.element();
                let narrow = syn::parse_str::<TypePath>(element)
                    .ok()
                    .and_then(|ty| narrow_argument_range(&ty));
                let bounds = match narrow {
                    Some((least, most)) => vec![(">=", least), ("<=", most)],
                    None if element.starts_with('u') => vec![(">=", 0)],
                    None => Vec::new(),
                };
                for (op, bound) in bounds {
                    engine.add_invariant(AbstractComparison::new(
                        op,
                        symbol.clone(),
                        AbstractExpression::Immediate(bound),
                    ));
                }
            }
            for bound in &self.indexed_bounds {
                let (region, element, base, stride, end_of_all) = self.bound_placement(bound)?;
                if element.starts_with('f') {
                    return Err(format!(
                        "an element precondition needs integer elements, not {element}"
                    ));
                }
                let width = calculate_size_of(element.clone()) as i64;
                let first = syn_expr_to_abstract_expression(&bound.first);
                let end = match (&bound.end, bound.to_end) {
                    (Some(end), _) => syn_expr_to_abstract_expression(end),
                    (None, true) => end_of_all.clone(),
                    (None, false) => {
                        generate_expression("+", first.clone(), AbstractExpression::Immediate(1))
                    }
                };
                let comparison = &bound.comparison;
                let label = spelled(quote! { #comparison });
                if let BoundTarget::Field(field) = &bound.target {
                    let within = [
                        AbstractComparison::new(
                            ">=",
                            first.clone(),
                            AbstractExpression::Immediate(0),
                        ),
                        AbstractComparison::new("<=", end.clone(), end_of_all.clone()),
                    ];
                    if !within.iter().all(|fact| engine.implies(fact)) {
                        return Err(format!(
                            "{label} may index outside the {} elements of the field at byte {}",
                            field.ty.shown(),
                            field.offset
                        ));
                    }
                }
                engine.add_indexed_fact(
                    region,
                    IndexedFact::elements(label, first, end, width, element.starts_with('i'))
                        .bounded(
                            operator_of(&comparison.op),
                            syn_expr_to_abstract_expression(&comparison.right),
                        )
                        .placed(base, stride),
                )?;
            }
            log::info!(target: "bums_macros", "checking {label}");
            let started = std::time::Instant::now();
            let res = engine.start(self.symbol.clone());
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
        for register in &self.register_preconditions {
            findings.push(format!(
                "the value of {register} at entry is a register precondition no Rust caller can establish: \
                 it is the assembly caller's contract, so the wrapper is an unsafe fn"
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
        let (failures, rejected) = match (self.rejects, failures.is_empty()) {
            (false, _) => (failures, Vec::new()),
            (true, true) => (vec![format!("{label} {REJECTS_BUT_VERIFIED}")], Vec::new()),
            (true, false) => (Vec::new(), failures),
        };
        Ok(Verdict {
            failures,
            rejected,
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
    fn a_literal_beyond_i32_bounds_a_usize() {
        let nblocks: usize = 1 << 32;
        let precondition: Expr = parse_quote! { nblocks <= 4294967295 };
        let (spelled, check) = emitted! {
            i128::try_from(nblocks).expect("precondition arithmetic overflows i128") <= 4294967295i128
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
                <= 4i128
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
    fn a_red_zone_is_accepted_only_within_the_apple_guarantee() {
        let item: TokenStream = quote! { fn f(x: &mut [u8; 16]); };
        let too_deep = quote! { "f.S", red_zone = 256, x.as_mut_ptr() };
        assert!(parse_annotation(too_deep, item.clone()).is_err());

        let attr: TokenStream = quote! { "f.S", red_zone = 128, x.as_mut_ptr() };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        assert_eq!(annotation.unsupported_on("apple"), None);
        assert!(annotation.unsupported_on("unknown").is_some());
        let expansion = without_spaces(&annotation.expansion.to_string());
        assert!(
            expansion.contains("#[cfg(not(target_vendor=\"apple\"))]compile_error!"),
            "{expansion}"
        );
    }

    #[test]
    fn a_rejecting_annotation_must_fail_and_names_its_symbol() {
        let program: Vec<String> = ["over_read:", "ldr q0, [x0]", "ret"]
            .iter()
            .map(|line| line.to_string())
            .collect();
        let verdict_for = |attr: TokenStream, item: TokenStream| {
            let annotation = parse_annotation(attr, item).expect("annotation parses");
            assert_eq!(annotation.symbol, "over_read");
            annotation.check(&program).expect("checks")
        };

        let short = verdict_for(
            quote! { "f.S", symbol = "over_read", rejects, x.as_ptr() },
            quote! { fn over_read_unpadded(x: &[u8; 12]); },
        );
        assert!(short.failures.is_empty(), "{:?}", short.failures);
        assert!(!short.rejected.is_empty());

        let padded = verdict_for(
            quote! { "f.S", symbol = "over_read", rejects, x.as_ptr() },
            quote! { fn over_read_padded(x: &[u8; 16]); },
        );
        assert!(padded.rejected.is_empty());
        assert!(padded.failures[0].contains("is marked rejects"));

        let rejecting = parse_annotation(
            quote! { "f.S", symbol = "over_read", rejects, x.as_ptr() },
            quote! { fn over_read_unpadded(x: &[u8; 12]); },
        )
        .expect("annotation parses");
        let wrapper = without_spaces(&rejecting.expansion.to_string());
        assert!(
            wrapper.starts_with("unsafefnover_read_unpadded"),
            "{wrapper}"
        );

        let annotation = parse_annotation(
            quote! { "f.S", symbol = "over_read", x.as_ptr() },
            quote! { fn over_read_padded(x: &[u8; 16]); },
        )
        .expect("annotation parses");
        let expansion = without_spaces(&annotation.expansion.to_string());
        assert!(
            expansion.contains("#[link_name=\"over_read\"]"),
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

    fn width_dispatch() -> Vec<String> {
        [
            "f:",
            "adrp x9, tbl",
            "add x9, x9, :lo12:tbl",
            "ldrsw x8, [x9, x8, lsl #2]",
            "add x9, x9, x8",
            "br x9",
            "L_w16:",
            "strb w1, [x0, #15]",
            "ret",
            "L_w8:",
            "strb w1, [x0, #7]",
            "ret",
            "L_w4:",
            "strb w1, [x0, #3]",
            "ret",
            "\t.section .rodata",
            "tbl:",
            "\t.size tbl, 12",
            "\t.word L_w16 - tbl",
            "\t.word L_w8 - tbl",
            "\t.word L_w4 - tbl",
        ]
        .iter()
        .map(|line| line.to_string())
        .collect()
    }

    fn dispatch_verdict(preconditions: TokenStream) -> std::result::Result<Vec<String>, String> {
        let attr = quote! { "f.S", dst.as_mut_ptr(), v, w, [dst.len() == w, w >= 4, w <= 16, #preconditions] };
        let item = quote! { fn f(dst: &mut [u8], v: u8, w: usize); };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        assert_eq!(annotation.diagnostics, Vec::<String>::new());
        annotation
            .check(&width_dispatch())
            .map(|verdict| verdict.failures)
    }

    fn signed_offset_verdict(lowest: TokenStream) -> std::result::Result<Vec<String>, String> {
        let attr = quote! { "f.S", dst.as_mut_ptr(), x, [dst.len() == 18, x >= #lowest, x <= 9] };
        let item = quote! { fn f(dst: &mut [u8], x: isize); };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        assert_eq!(annotation.diagnostics, Vec::<String>::new());
        let program: Vec<String> = ["f:", "add x8, x0, x1", "strb wzr, [x8, #8]", "ret"]
            .iter()
            .map(|line| line.to_string())
            .collect();
        annotation.check(&program).map(|verdict| verdict.failures)
    }

    #[test]
    fn a_negative_literal_bound_keeps_its_sign() {
        assert_eq!(signed_offset_verdict(quote! { -8 }), Ok(Vec::new()));
        assert_eq!(signed_offset_verdict(quote! { -(4 + 4) }), Ok(Vec::new()));
    }

    #[test]
    fn a_negative_bound_one_too_low_is_rejected() {
        for lowest in [quote! { -9 }, quote! { -(4 + 5) }] {
            let failures = signed_offset_verdict(lowest.clone()).expect("the check runs");
            assert!(
                !failures.is_empty(),
                "x >= {lowest} let a write before dst pass"
            );
        }
    }

    #[test]
    fn a_register_precondition_selects_the_jump_table_entry() {
        assert_eq!(
            dispatch_verdict(quote! { reg(x8) == clz32(w) - 27 }),
            Ok(Vec::new())
        );
    }

    #[test]
    fn a_register_precondition_that_misses_the_table_is_rejected() {
        for wrong in [
            quote! { reg(x8) == clz32(w) - 26 },
            quote! { reg(w8) == clz32(w) - 27 },
            quote! { reg(x8) <= 2 },
            quote! { w >= 4 },
        ] {
            let failures = dispatch_verdict(wrong.clone()).expect("the check runs");
            assert!(
                !failures.is_empty(),
                "{wrong} let an out-of-table read pass"
            );
        }
    }

    #[test]
    fn a_register_precondition_needs_a_free_general_register() {
        for (named, expected) in [
            (quote! { reg(x0) == 4 }, "bound to an argument"),
            (quote! { reg(w2) == 4 }, "bound to an argument"),
            (quote! { reg(sp) == 4 }, "not an AArch64 general register"),
            (quote! { reg(x30) == 4 }, "not an AArch64 general register"),
            (quote! { reg(x08) == 4 }, "not an AArch64 general register"),
            (quote! { reg(rax) == 4 }, "not an AArch64 general register"),
            (
                quote! { reg(x8) == 0 && reg(w8) == 0 },
                "views of one register",
            ),
        ] {
            let error = dispatch_verdict(named.clone()).expect_err("the check refuses");
            assert!(error.contains(expected), "{named}: {error}");
        }
    }

    #[test]
    fn a_malformed_register_precondition_is_a_diagnostic() {
        for malformed in [
            quote! { reg(x8 + 1) == 4 },
            quote! { reg(x8) + 1 },
            quote! { dst[reg(x8)] == 4 },
            quote! { popcount(w) == 1 },
            quote! { clz32(w, 3) == 1 },
        ] {
            let attr = quote! { "f.S", dst.as_mut_ptr(), v, w, [dst.len() == w, #malformed] };
            let item = quote! { fn f(dst: &mut [u8], v: u8, w: usize); };
            let annotation = parse_annotation(attr, item).expect("annotation parses");
            assert!(
                !annotation.diagnostics.is_empty(),
                "{malformed} was accepted"
            );
        }
    }

    #[test]
    fn a_register_precondition_makes_the_wrapper_unsafe_and_unchecked() {
        let attr =
            quote! { "f.S", dst.as_mut_ptr(), v, w, [dst.len() == w, reg(x8) == clz32(w) - 27] };
        let item = quote! { fn f(dst: &mut [u8], v: u8, w: usize); };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        let expansion = without_spaces(&annotation.expansion.to_string());
        assert!(expansion.starts_with("unsafefnf("), "{expansion}");
        assert!(!expansion.contains("reg("), "{expansion}");
    }

    #[test]
    fn clz32_counts_the_leading_zeros_of_the_low_word() {
        let precondition: Expr = parse_quote! { clz32(w) == 27 };
        let w: u64 = (1u64 << 32) + 16;
        let (spelled, check) = emitted! {
            i128::from(((i128::try_from(w).expect("precondition arithmetic overflows i128"))
                .rem_euclid(1i128 << 32) as u32)
                .leading_zeros())
                == 27i128
        };
        assert_eq!(
            without_spaces(&exact_condition(&precondition).to_string()),
            without_spaces(spelled)
        );
        assert!(check());
    }

    fn entry_verdict(
        preconditions: TokenStream,
        read: &str,
    ) -> std::result::Result<Vec<String>, String> {
        let attr = quote! { "f.S", t.as_ptr(), cdf.as_ptr(), n, [t.len() == 33, cdf.len() == 16, #preconditions] };
        let item = quote! { fn f(t: &[u8], cdf: &[u16], n: usize); };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        assert_eq!(annotation.diagnostics, Vec::<String>::new());
        let program: Vec<String> = ["f:", read, "ldrb w5, [x0, x4]", "ret"]
            .iter()
            .map(|line| line.to_string())
            .collect();
        annotation.check(&program).map(|verdict| verdict.failures)
    }

    #[test]
    fn an_element_precondition_at_a_symbolic_index_is_assumed_where_it_is_read() {
        let at_n = "ldrh w4, [x1, x2, lsl #1]";
        assert_eq!(
            entry_verdict(quote! { n <= 15, cdf[n] <= 32 }, at_n),
            Ok(Vec::new())
        );
        assert_eq!(
            entry_verdict(quote! { n <= 15, cdf[n..] <= 32 }, at_n),
            Ok(Vec::new())
        );
        assert_eq!(
            entry_verdict(quote! { n >= 1, n <= 15, cdf[n - 1..=n] <= 32 }, at_n),
            Ok(Vec::new())
        );
        let elsewhere = entry_verdict(quote! { n <= 15, cdf[n] <= 32 }, "ldrh w4, [x1, #2]")
            .expect("the check runs");
        assert!(!elsewhere.is_empty());
    }

    #[test]
    fn an_element_precondition_whose_index_may_be_outside_is_refused() {
        let at_n = "ldrh w4, [x1, x2, lsl #1]";
        for outside in [
            quote! { n <= 16, cdf[n] <= 32 },
            quote! { cdf[n] <= 32 },
            quote! { n <= 15, cdf[n..n + 2] <= 32 },
            quote! { n <= 15, cdf[n + 1..n] <= 32 },
        ] {
            let error = entry_verdict(outside.clone(), at_n).expect_err("the check refuses");
            assert!(error.contains("may index outside"), "{outside}: {error}");
        }
    }

    #[test]
    fn an_element_precondition_at_a_symbolic_index_is_checked_at_run_time() {
        let attr = quote! { "f.S", cdf.as_ptr(), n, [cdf.len() == 16, n <= 15, cdf[n] <= 32, cdf[n + 1..] <= 7] };
        let item = quote! { fn f(cdf: &[u16], n: usize); };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        let expansion = without_spaces(&annotation.expansion.to_string());
        assert!(
            expansion.contains(
                "assert!(i128::try_from((cdf)[usize::try_from(i128::try_from(n).expect(\"preconditionarithmeticoverflowsi128\")).expect(\"preconditionarithmeticoverflowsi128\")])"
            ),
            "{expansion}"
        );
        assert!(
            expansion.contains("..(cdf).len()].iter().all("),
            "{expansion}"
        );
    }

    fn program(lines: &[&str]) -> Vec<String> {
        lines.iter().map(|line| line.to_string()).collect()
    }

    fn field_verdict(
        preconditions: TokenStream,
        lines: &[&str],
    ) -> std::result::Result<Vec<String>, String> {
        let attr = quote! { "f.S", rf.as_ptr(), [rf.len() == 3, #preconditions] };
        let item = quote! { fn f(rf: &[usize], buf: &[u8], n: i32); };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        if !annotation.diagnostics.is_empty() {
            return Err(annotation.diagnostics.join("; "));
        }
        annotation
            .check(&program(lines))
            .map(|verdict| verdict.failures)
    }

    const FIELD_READS: [&str; 5] = [
        "f:",
        "ldr w2, [x0, #16]",
        "ldr x3, [x0, #8]",
        "ldrb w4, [x3, w2, uxtw]",
        "ret",
    ];

    #[test]
    fn a_pointer_field_points_to_a_region_sized_by_another_field() {
        let sized = |length: TokenStream| {
            field_verdict(
                quote! { field::<usize>(rf, 8) == buf.as_ptr(), field::<i32>(rf, 16) == n, n >= 0, buf.len() == #length },
                &FIELD_READS,
            )
        };
        assert_eq!(sized(quote! { n + 1 }), Ok(Vec::new()));
        assert!(!sized(quote! { n }).expect("the check runs").is_empty());
    }

    #[test]
    fn a_field_read_wider_than_its_declaration_learns_nothing() {
        let wide = field_verdict(
            quote! { field::<usize>(rf, 8) == buf.as_ptr(), field::<i32>(rf, 16) == n, n >= 0, buf.len() == n + 1 },
            &["f:", "ldr x2, [x0, #16]", "ldr x3, [x0, #8]", "ldrb w4, [x3, x2]", "ret"],
        )
        .expect("the check runs");
        assert!(!wide.is_empty());
    }

    #[test]
    fn fields_must_fit_and_not_overlap() {
        for (bad, expected) in [
            (
                quote! { field::<i32>(rf, 16) == n, field::<u8>(rf, 18) == 0 },
                "overlaps",
            ),
            (
                quote! { field::<i32>(rf, 16) == n, field::<u32>(rf, 16) == 0 },
                "declared as both",
            ),
            (quote! { field::<f32>(rf, 16) == 0 }, "a field is one of"),
            (
                quote! { field::<u8>(rf) == 0 },
                "field::<T>(base, byte_offset)",
            ),
            (
                quote! { field::<[u8; 3]>(rf, 0) == 0 },
                "element by element",
            ),
            (quote! { field::<i32>(rf, 22) == n }, "not provably inside"),
            (
                quote! { field::<u32>(rf, 8) == buf.as_ptr() },
                "a pointer field is 8 bytes",
            ),
        ] {
            let error = match std::panic::catch_unwind(|| field_verdict(bad.clone(), &FIELD_READS))
            {
                Ok(verdict) => verdict.expect_err("the annotation is refused"),
                Err(panic) => panic.downcast_ref::<String>().cloned().unwrap_or_default(),
            };
            assert!(error.contains(expected), "{bad}: {error}");
        }
    }

    #[test]
    fn a_field_array_carries_a_range_for_every_element() {
        let indexed = |bound: TokenStream| {
            let attr = quote! { "f.S", rf.as_ptr(), t.as_ptr(), k, [rf.len() == 3, t.len() == 7, k <= 2, field::<[u8; 3]>(rf, 0)[..] <= #bound] };
            let item = quote! { fn f(rf: &[usize], t: &[u8], k: usize); };
            let annotation = parse_annotation(attr, item).expect("annotation parses");
            assert_eq!(annotation.diagnostics, Vec::<String>::new());
            annotation
                .check(&program(&[
                    "f:",
                    "ldrb w3, [x0, x2]",
                    "ldrb w4, [x1, x3]",
                    "ret",
                ]))
                .map(|verdict| verdict.failures)
        };
        assert_eq!(indexed(quote! { 6 }), Ok(Vec::new()));
        assert!(!indexed(quote! { 7 }).expect("the check runs").is_empty());
    }

    #[test]
    fn a_field_array_fact_must_stay_inside_the_array() {
        let attr = quote! { "f.S", rf.as_ptr(), k, [rf.len() == 3, k <= 3, field::<[u8; 3]>(rf, 0)[k] <= 6] };
        let item = quote! { fn f(rf: &[usize], k: usize); };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        let error = annotation
            .check(&program(&["f:", "ldrb w3, [x0, x1]", "ret"]))
            .err()
            .unwrap_or_default();
        assert!(error.contains("may index outside"), "{error}");
    }

    #[test]
    fn a_strided_walk_states_a_fact_about_one_field_of_every_row() {
        let walked = |offset: i64| {
            let attr = quote! { "f.S", rr.as_ptr(), t.as_ptr(), [rr == [&[u8; 10]; 2], t.len() == 8, rr.iter().all(|row| row.iter().skip(4).step_by(5).all(|e| *e <= 7))] };
            let item = quote! { fn f(rr: &[&[u8]], t: &[u8]); };
            let annotation = parse_annotation(attr, item).expect("annotation parses");
            assert_eq!(annotation.diagnostics, Vec::<String>::new());
            let read = format!("ldrb w3, [x2, #{offset}]");
            annotation
                .check(&program(&[
                    "f:",
                    "ldr x2, [x0, #8]",
                    &read,
                    "ldrb w4, [x1, x3]",
                    "ret",
                ]))
                .map(|verdict| verdict.failures)
        };
        assert_eq!(walked(9), Ok(Vec::new()));
        assert_eq!(walked(4), Ok(Vec::new()));
        assert!(!walked(8).expect("the check runs").is_empty());
    }

    #[test]
    fn a_malformed_walk_is_a_diagnostic() {
        for malformed in [
            quote! { rr.iter().all(|row| row.iter().skip(k).all(|e| *e <= 7)) },
            quote! { rr.iter().all(|row| row.iter().step_by(0).all(|e| *e <= 7)) },
            quote! { rr.iter().all(|row| row.iter().all(|e| e.count_ones() <= 7)) },
            quote! { rr.iter().all(|row| t.iter().all(|e| *e <= 7)) },
        ] {
            let attr =
                quote! { "f.S", rr.as_ptr(), t.as_ptr(), k, [rr == [&[u8; 10]; 2], #malformed] };
            let item = quote! { fn f(rr: &[&[u8]], t: &[u8], k: usize); };
            let annotation = parse_annotation(attr, item).expect("annotation parses");
            assert!(
                !annotation.diagnostics.is_empty(),
                "{malformed} was accepted"
            );
        }
    }

    #[test]
    fn writable_rows_need_mutable_row_references() {
        let attr = quote! { "f.S", rr.as_ptr(), n, [rr == [&mut [u8; n]; 2], n >= 1] };
        let shared = parse_annotation(attr.clone(), quote! { fn f(rr: &[&mut [u8]], n: usize); })
            .expect("annotation parses");
        assert!(!shared.diagnostics.is_empty());
        let unique = parse_annotation(attr, quote! { fn f(rr: &mut [&mut [u8]], n: usize); })
            .expect("annotation parses");
        assert_eq!(unique.diagnostics, Vec::<String>::new());
        let expansion = without_spaces(&unique.expansion.to_string());
        assert!(
            expansion.contains("rr.iter_mut().map(|row|row.as_mut_ptr()).collect::<Vec<*mutu8>>()"),
            "{expansion}"
        );
        let failures = |last: &str| {
            let program: Vec<String> = ["f:", "ldr x2,[x0,#8]", last, "ret"]
                .iter()
                .map(|line| line.to_string())
                .collect();
            unique.check(&program).expect("the check runs").failures
        };
        assert_eq!(failures("strb wzr,[x2,#0]"), Vec::<String>::new());
        assert!(!failures("strb wzr,[x2,x1]").is_empty());
    }

    #[test]
    fn two_pointers_into_one_buffer_keep_their_own_offsets() {
        let verdict_for = |body: &[&str]| {
            let attr: TokenStream = quote! {
                "f.S", buf.as_mut_ptr().add(pos), buf.as_mut_ptr().add(pos - dist),
                [buf.len() == pos + 1, dist >= 1, dist <= pos]
            };
            let item: TokenStream = quote! { fn f(buf: &mut [u8], pos: usize, dist: usize); };
            let annotation = parse_annotation(attr, item).expect("annotation parses");
            let mut program = vec!["f:".to_string()];
            program.extend(body.iter().map(|line| line.to_string()));
            annotation.check(&program).expect("the check runs").failures
        };
        assert_eq!(verdict_for(&["strb wzr,[x0]", "ret"]), Vec::<String>::new());
        assert!(!verdict_for(&["strb wzr,[x0,#1]", "ret"]).is_empty());
        assert_eq!(
            verdict_for(&["strb wzr,[x1,#1]", "ret"]),
            Vec::<String>::new()
        );
    }

    fn failures_returning(output: TokenStream, body: &[&str]) -> Vec<String> {
        let attr: TokenStream = quote! { "f.S", table.as_ptr(), i, [i < 16] };
        let item: TokenStream = quote! { fn f(table: &[u8; 16], i: usize) -> #output; };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        let mut program = vec!["f:".to_string()];
        program.extend(body.iter().map(|line| line.to_string()));
        annotation.check(&program).expect("the check runs").failures
    }

    #[test]
    fn a_16_byte_array_comes_back_in_registers_so_x8_is_not_a_result_pointer() {
        let array = quote! { [u32; 4] };
        assert_eq!(
            failures_returning(array.clone(), &["mov x0,#1", "mov x1,#2", "ret"]),
            Vec::<String>::new()
        );
        assert!(!failures_returning(array.clone(), &["str wzr,[x8]", "ret"]).is_empty());
        assert!(!failures_returning(array, &["movl $0,(%rdi)", "ret"]).is_empty());
        for narrow in [quote! { [u8; 16] }, quote! { [i16; 4] }] {
            assert_eq!(
                failures_returning(narrow, &["mov x0,#-1", "mov x1,#-1", "ret"]),
                Vec::<String>::new()
            );
        }
    }

    #[test]
    fn floats_up_to_four_come_back_in_vector_registers_on_aarch64_only() {
        assert!(!failures_returning(quote! { [f64; 4] }, &["str xzr,[x8]", "ret"]).is_empty());
        assert_eq!(
            failures_returning(
                quote! { [f64; 4] },
                &["movq $0,24(%rdi)", "movq %rdi,%rax", "ret"]
            ),
            Vec::<String>::new()
        );
    }

    #[test]
    fn an_array_over_16_bytes_is_written_through_x8_on_aarch64() {
        let array = quote! { [u64; 4] };
        assert_eq!(
            failures_returning(
                array.clone(),
                &[
                    "ldrb w2,[x0,x1]",
                    "stp x2,x2,[x8]",
                    "stp x2,x2,[x8,#16]",
                    "ret"
                ]
            ),
            Vec::<String>::new()
        );
        assert!(!failures_returning(array, &["str xzr,[x8,#32]", "ret"]).is_empty());
    }

    #[test]
    fn an_array_over_16_bytes_takes_rdi_and_moves_the_arguments_up_on_x86() {
        let array = quote! { [u64; 4] };
        let filled = |load: &str| {
            failures_returning(
                array.clone(),
                &[
                    load,
                    "movq %rax,(%rdi)",
                    "movq %rax,24(%rdi)",
                    "movq %rdi,%rax",
                    "ret",
                ],
            )
        };
        assert_eq!(filled("movzbl (%rsi,%rdx),%eax"), Vec::<String>::new());
        assert!(!filled("movzbl (%rdi,%rsi),%eax").is_empty());
        assert!(
            !failures_returning(
                array.clone(),
                &["movq $0,32(%rdi)", "movq %rdi,%rax", "ret"]
            )
            .is_empty()
        );
        let without_rax = failures_returning(array, &["movq $0,(%rdi)", "ret"]);
        assert!(
            without_rax
                .iter()
                .any(|failure| failure.contains("the address of the result")),
            "{without_rax:?}"
        );
    }

    #[test]
    fn a_bool_result_must_be_0_or_1_in_the_bits_the_caller_reads() {
        let bool_result = |body: &[&str]| failures_returning(quote! { bool }, body);
        assert_eq!(
            bool_result(&["cmp x1,#3", "cset w0,eq", "ret"]),
            Vec::<String>::new()
        );
        assert!(!bool_result(&["mov w0,#2", "ret"]).is_empty());
        assert!(!bool_result(&["mov w0,#0x100", "ret"]).is_empty());
        assert!(!bool_result(&["ldrb w0,[x0,x1]", "ret"]).is_empty());
        assert!(!bool_result(&["ret"]).is_empty());
        assert_eq!(
            bool_result(&["movl $0x100,%eax", "ret"]),
            Vec::<String>::new()
        );
        assert!(!bool_result(&["movl $2,%eax", "ret"]).is_empty());
    }

    #[test]
    fn a_callee_saved_register_must_hold_its_entry_value_on_return() {
        let failures = |body: &[&str]| failures_returning(quote! { u64 }, body);
        assert_eq!(
            failures(&[
                "stp x19,x20,[sp,#-16]!",
                "mov x19,#0",
                "ldp x19,x20,[sp],#16",
                "ret"
            ]),
            Vec::<String>::new()
        );
        let clobbered = failures(&["mov x19,#0", "ret"]);
        assert!(
            clobbered
                .iter()
                .any(|failure| failure.contains("callee-saved register x19")),
            "{clobbered:?}"
        );
        assert!(!failures(&["mov x29,sp", "ret"]).is_empty());
        let x86 = |body: &[&str]| {
            let mut program = vec!["movq %rdi,%rax"];
            program.extend_from_slice(body);
            failures(&program)
        };
        assert_eq!(
            x86(&["pushq %rbx", "movq $0,%rbx", "popq %rbx", "ret"]),
            Vec::<String>::new()
        );
        assert!(!x86(&["movq $0,%rbx", "ret"]).is_empty());
        assert!(!x86(&["movl $0,%r12d", "ret"]).is_empty());
        assert_eq!(x86(&["movq $0,%r11", "ret"]), Vec::<String>::new());
    }

    fn failures_returning_through_the_rust_abi(output: TokenStream, body: &[&str]) -> Vec<String> {
        let attr: TokenStream = quote! { "f.S", abi = "Rust", table.as_ptr(), i, [i < 16] };
        let item: TokenStream = quote! { fn f(table: &[u8; 16], i: usize) -> #output; };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        let mut program = vec!["f:".to_string()];
        program.extend(body.iter().map(|line| line.to_string()));
        annotation.check(&program).expect("the check runs").failures
    }

    #[test]
    fn a_rust_abi_aggregate_over_8_bytes_is_written_through_the_result_pointer() {
        let four_floats = quote! { (f32, f32, f32, f32) };
        assert_eq!(
            failures_returning_through_the_rust_abi(
                four_floats.clone(),
                &["stp s0,s1,[x8]", "stp s2,s3,[x8,#8]", "ret"]
            ),
            Vec::<String>::new()
        );
        assert!(
            !failures_returning_through_the_rust_abi(
                four_floats.clone(),
                &["str s0,[x8,#16]", "ret"]
            )
            .is_empty()
        );
        assert_eq!(
            failures_returning_through_the_rust_abi(
                four_floats,
                &[
                    "movzbl (%rsi,%rdx),%eax",
                    "movq %rax,8(%rdi)",
                    "movq %rdi,%rax",
                    "ret"
                ]
            ),
            Vec::<String>::new()
        );
        assert_eq!(
            failures_returning_through_the_rust_abi(
                quote! { [u32; 3] },
                &["str w1,[x8,#8]", "ret"]
            ),
            Vec::<String>::new()
        );
    }

    #[test]
    fn a_rust_abi_pair_or_an_aggregate_of_8_bytes_comes_back_in_registers() {
        for output in [
            quote! { (u64, u64) },
            quote! { (f32, f32) },
            quote! { [u8; 8] },
        ] {
            assert!(
                !failures_returning_through_the_rust_abi(output.clone(), &["str xzr,[x8]", "ret"])
                    .is_empty(),
                "{} wrote through x8",
                spelled(output)
            );
        }
        assert_eq!(
            failures_returning_through_the_rust_abi(
                quote! { [u64; 2] },
                &["stp xzr,xzr,[x8]", "ret"]
            ),
            Vec::<String>::new()
        );
    }

    #[test]
    fn the_rust_abi_is_declared_as_such_and_only_for_apple_targets() {
        let attr: TokenStream = quote! { "f.S", abi = "Rust", n };
        let item: TokenStream = quote! { fn f(n: usize) -> (f32, f32, f32, f32); };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        let expansion = without_spaces(&annotation.expansion.to_string());
        assert!(expansion.contains("unsafeextern\"Rust\"{"));
        assert!(!expansion.contains("ReturnedArray"));
        assert!(expansion.contains("#[cfg(not(target_vendor=\"apple\"))]compile_error!"));
        assert_eq!(annotation.unsupported_on("apple"), None);
        assert!(annotation.unsupported_on("unknown").is_some());

        let c_tuple = parse_annotation(
            quote! { "f.S", n },
            quote! { fn f(n: usize) -> (f32, f32, f32, f32); },
        );
        assert!(c_tuple.is_err());
        for attr in [
            quote! { "f.S", abi = "system", n },
            quote! { "f.S", abi = "Rust", abi = "Rust", n },
        ] {
            assert!(parse_annotation(attr, quote! { fn f(n: usize); }).is_err());
        }
        for mixed in [
            quote! { (u32, f32) },
            quote! { (bool, bool, bool) },
            quote! { (u64,) },
        ] {
            let attr: TokenStream = quote! { "f.S", abi = "Rust", n };
            let item: TokenStream = quote! { fn f(n: usize) -> #mixed; };
            assert!(
                parse_annotation(attr, item).is_err(),
                "{} was accepted",
                spelled(mixed)
            );
        }
    }

    #[test]
    fn a_pointer_taken_from_a_reference_is_never_null() {
        let guarded = |register: &str| {
            failures_returning(
                quote! { bool },
                &[
                    &format!("cbz {register},null"),
                    "mov w0,#1",
                    "ret",
                    "null:",
                    "mov w0,#-1",
                    "ret",
                ],
            )
        };
        assert_eq!(guarded("x0"), Vec::<String>::new());
        assert!(!guarded("x1").is_empty());
    }

    #[test]
    fn a_narrow_integer_result_is_extended_to_32_bits_on_aarch64() {
        let failures = |output: TokenStream, body: &[&str]| failures_returning(output, body);
        assert_eq!(
            failures(quote! { u16 }, &["ldrh w0,[x0]", "ret"]),
            Vec::<String>::new()
        );
        assert!(!failures(quote! { u16 }, &["mov w0,#0x10000", "ret"]).is_empty());
        assert_eq!(
            failures(quote! { u16 }, &["movl $0x10000,%eax", "ret"]),
            Vec::<String>::new()
        );
        assert_eq!(
            failures(quote! { i16 }, &["ldrsh w0,[x0]", "ret"]),
            Vec::<String>::new()
        );
        assert!(!failures(quote! { i16 }, &["mov w0,#0xffff", "ret"]).is_empty());
        assert_eq!(
            failures(quote! { u32 }, &["mov x0,#-1", "ret"]),
            Vec::<String>::new()
        );
    }

    #[test]
    fn a_char_result_must_be_a_unicode_scalar_value() {
        assert_eq!(
            failures_returning(quote! { char }, &["mov w0,#65", "ret"]),
            Vec::<String>::new()
        );
        assert!(!failures_returning(quote! { char }, &["mov w0,#0xd800", "ret"]).is_empty());
        assert!(!failures_returning(quote! { char }, &["mov w0,#0x110000", "ret"]).is_empty());
    }

    #[test]
    fn a_result_whose_valid_values_are_not_modelled_is_refused() {
        for output in [
            quote! { &u8 },
            quote! { Option<u8> },
            quote! { (u64, u64) },
            quote! { [bool; 4] },
            quote! { core::num::NonZeroU32 },
        ] {
            let attr: TokenStream = quote! { "f.S", n };
            let item: TokenStream = quote! { fn f(n: usize) -> #output; };
            assert!(
                parse_annotation(attr, item).is_err(),
                "{} was accepted",
                spelled(output)
            );
        }
    }

    #[test]
    fn an_array_result_is_declared_through_a_repr_c_struct() {
        let attr: TokenStream = quote! { "f.S", n };
        let item: TokenStream = quote! { fn f(n: usize) -> [u32; 4]; };
        let annotation = parse_annotation(attr, item).expect("annotation parses");
        let expansion = without_spaces(&annotation.expansion.to_string());
        assert!(expansion.contains("#[repr(C)]structReturnedArray([u32;4]);"));
        assert!(expansion.contains("->ReturnedArray;"));
        assert!(expansion.contains(".0;"));
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
