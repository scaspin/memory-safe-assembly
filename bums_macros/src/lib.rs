extern crate proc_macro;
use proc_macro::TokenStream;
#[allow(unused_imports)]
use proc_macro_error::*;
use quote::quote;

#[proc_macro_attribute]
#[proc_macro_error]
pub fn check_mem_safe(attr: TokenStream, item: TokenStream) -> TokenStream {
    let annotation = match bums_annotations::parse_annotation(attr.into(), item.into()) {
        Ok(annotation) => annotation,
        Err(error) => return error.to_compile_error().into(),
    };
    for diagnostic in &annotation.diagnostics {
        emit_call_site_error!(diagnostic);
    }
    let expansion = annotation.expansion.clone();
    let skip_tracking = quote! { const _: Option<&str> = option_env!("BUMS_SKIP"); };
    if std::env::var_os("BUMS_SKIP").is_some() {
        return quote! { #expansion #skip_tracking }.into();
    }

    let assembly_file: std::path::PathBuf = [
        std::env::var("OUT_DIR").expect("OUT_DIR"),
        annotation.asm_file.clone(),
    ]
    .iter()
    .collect();
    let program = match bums_annotations::read_program(&assembly_file) {
        Ok(program) => program,
        Err(error) => {
            abort_call_site!(error);
        }
    };

    let _ = env_logger::try_init();
    let verdict = match annotation.check(&program) {
        Ok(verdict) => verdict,
        Err(error) => {
            abort_call_site!(error);
        }
    };
    for diagnostic in &verdict.diagnostics {
        emit_call_site_error!(diagnostic);
    }

    let label = &annotation.label;
    let notes = verdict
        .findings
        .iter()
        .map(|finding| format!("bums finding in {label}: {finding}"));
    let token_stream: TokenStream = quote! {
        #expansion
        #skip_tracking
        #(
            const _: () = {
                #[deprecated(note = #notes)]
                struct BumsFinding;
                let _ = BumsFinding;
            };
        )*
    }
    .into();

    if !verdict.failures.is_empty() {
        let error = verdict.failures.join("; ");

        #[cfg(not(debug_assertions))]
        emit_call_site_error!(error);

        #[cfg(debug_assertions)]
        eprintln!("bums: VERIFICATION FAILED in {label}: {error}");
    }
    token_stream
}
