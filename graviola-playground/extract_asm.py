#!/usr/bin/env python3
"""Extract the flat GAS instruction text for one graviola aarch64 function
into a plain .S file the checker's line parser can read.

Unlike an earlier version of this script, which hand-parsed the `Q!(...)`/
`Label!(...)`/local-register-alias macro calls inside a graviola
`core::arch::asm!` block with a small Python macro-expander, this version
leans on rustc's own macro expander via `cargo expand`: it patches a cloned
graviola checkout so every `core::arch::asm!` call becomes `verified_asm!`
(a macro added to graviola/src/low/macros.rs that forwards to
`core::arch::asm!` completely unchanged -- it exists only to give this
script a stable, distinctive thing to find), runs `cargo expand` on the
target module, and reads the single fully-resolved string literal `asm!`
is left holding once Q!/Label!/the per-function register aliases/NSPACE!
have all been expanded away by the compiler itself. This is why it no
longer needs its own understanding of any of those macros, and why it
handles every low/aarch64 function uniformly rather than special-casing
constructs (NSPACE!, non-string asm! arguments) a hand-rolled expander
could not follow.

The patch also shadows graviola's own `Label!` (declared again, later in
the same file, which is enough for `#[macro_use]`'s textual scoping to
prefer the new one everywhere after it): graviola's own version resolves a
label reference to a GNU-as numeric local label ("2f"/"2b"), but the
checker's label resolution does not implement GNU-as's redefine-and-
resolve-by-direction scoping for a reused number -- and graviola's ids are
reused often, being allocated per logical label *slot* in a function with
many loops, not globally. The replacement resolves to the name graviola
already carries alongside the id instead (the original s2n-bignum label it
was ported from, unique per function by construction), which the checker's
plain name-indexed label lookup already handles -- the same reason s2n-
bignum's own named labels already worked against it elsewhere.

Setup (once per graviola clone):
    git clone https://github.com/ctz/graviola <path>
    rustup toolchain install nightly   # cargo-expand needs it
    cargo install cargo-expand

Usage:
    extract_asm.py patch <graviola-clone-root>
        Idempotently inserts `verified_asm!` and the `Label!` override into
        low/macros.rs and rewrites every low/aarch64/*.rs to call
        verified_asm! instead of core::arch::asm!. Safe to run more than
        once; a no-op if already patched.

    extract_asm.py extract <graviola-clone-root> <function-name> <output.S>
        Runs `cargo +nightly expand --lib low::aarch64::<function-name>`
        and writes the resolved instruction text to <output.S>, with a
        leading `<function-name>:` label and a trailing synthetic `ret`
        (graviola's asm! blocks are inlined into the caller, so unlike a
        real subroutine they never contain their own `ret`).
"""
import re
import subprocess
import sys
from pathlib import Path


VERIFIED_ASM_MACRO = '''\
/// A drop-in stand-in for `core::arch::asm!` that changes nothing about how
/// the call behaves: every token is forwarded verbatim. Its only purpose is
/// to give the memory-safe-assembly checker's extraction tooling (see
/// extract_asm.py in that project) a distinct, greppable marker to
/// `cargo expand` against, so the extracted instruction text comes from
/// rustc's own macro expansion -- which already resolves Q!, Label!, local
/// register-alias macros, and NSPACE! correctly -- instead of a hand-rolled
/// parser reimplementing that expansion.
macro_rules! verified_asm {
    ($($tokens:tt)*) => {
        core::arch::asm!($($tokens)*)
    };
}

// Shadows graviola's own Label! (declared earlier in this same file): see
// this script's module docstring for why. A later macro_rules! of the same
// name wins for everything after it in #[macro_use]'s textual scope, which
// is every low/aarch64/*.rs file.
macro_rules! Label {
    ($name:literal, $id:literal) => {
        $name
    };
    ($name:literal, $id:literal, $_direction:tt) => {
        $name
    };
}

'''


def patch_graviola(root: Path):
    macros_path = root / "graviola" / "src" / "low" / "macros.rs"
    text = macros_path.read_text()
    if "macro_rules! verified_asm" not in text:
        macros_path.write_text(text + "\n" + VERIFIED_ASM_MACRO)
        print(f"patched {macros_path}")

    aarch64_dir = root / "graviola" / "src" / "low" / "aarch64"
    changed = 0
    for path in sorted(aarch64_dir.glob("*.rs")):
        text = path.read_text()
        patched = text.replace("core::arch::asm!(", "verified_asm!(")
        if patched != text:
            path.write_text(patched)
            changed += 1
    print(f"rewrote {changed} call sites under {aarch64_dir}")


def run_cargo_expand(root: Path, name: str) -> str:
    result = subprocess.run(
        ["cargo", "+nightly", "expand", "--lib", f"low::aarch64::{name}"],
        cwd=root / "graviola",
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        sys.exit(f"cargo expand failed for {name}:\n{result.stderr}")
    return result.stdout


def unescape_rust_string(body: str) -> str:
    out = []
    i = 0
    while i < len(body):
        c = body[i]
        if c == "\\" and i + 1 < len(body):
            nxt = body[i + 1]
            out.append({"n": "\n", "t": "\t", '"': '"', "\\": "\\", "0": "\0"}.get(nxt, nxt))
            i += 2
        else:
            out.append(c)
            i += 1
    return "".join(out)


def extract_first_string_literal(text: str, start: int) -> str:
    """The Rust string literal beginning at the first `"` at or after
    `start`, as its unescaped contents."""
    i = text.index('"', start)
    j = i + 1
    while True:
        if text[j] == "\\":
            j += 2
            continue
        if text[j] == '"':
            break
        j += 1
    return unescape_rust_string(text[i + 1 : j])


def parse_expanded(expanded: str, name: str) -> list[str]:
    fn_marker = re.search(rf"\bfn\s+{re.escape(name)}\s*\(", expanded)
    if not fn_marker:
        sys.exit(f"could not find `fn {name}(` in the expanded output")
    asm_at = expanded.find("asm!(", fn_marker.start())
    if asm_at == -1:
        sys.exit(f"no asm! call found after fn {name}(")
    raw = extract_first_string_literal(expanded, asm_at)
    # A handful of functions write each instruction with a trailing `;`
    # (harmless, surplus punctuation -- the newline it precedes already
    # separates one instruction from the next).
    lines = [normalize(line.strip().rstrip(";").strip()) for line in raw.split("\n")]
    return [line for line in lines if line]


BARE_IMMEDIATE_RE = re.compile(r"-?(0x[0-9a-fA-F]+|[0-9]+)")


def _fix_immediate(m: re.Match) -> str:
    expr = re.sub(r"\s+", "", m.group(1))
    if not expr:
        return "#"
    # Already a single parenthesized expression, or a bare (possibly
    # negative, possibly hex) number: leave it exactly as the checker
    # already parses it. Otherwise graviola has spelled one immediate as
    # several adjacent pieces -- e.g. `# 48+ 16` or `#(2 * 48)+ 16` -- which
    # only survives as one token if wrapped in the parens the checker does
    # keep together.
    if re.fullmatch(r"\(.*\)", expr) or BARE_IMMEDIATE_RE.fullmatch(expr):
        return f"#{expr}"
    return f"#({expr})"


def normalize(line: str) -> str:
    # graviola's Label! macro resolves a forward/backward reference via
    # `stringify!($id f)`, which -- since stringify! joins separate tokens
    # with a space -- produces "2 f" rather than GNU-as's actual local-label
    # syntax "2f". Most branch opcodes happen to still work (whatever reads
    # the operand only looks at the leading digits), but `bl` parses its
    # target more strictly and panics on the space.
    line = re.sub(r"(\d+)\s+([fb])\b", r"\1\2", line)
    # graviola sometimes spaces a pre-index writeback ("[sp, #-16] !"); the
    # checker's parser only recognizes `!` directly after the closing
    # bracket.
    line = line.replace("] !", "]!")
    # An immediate operand runs from `#` up to the next operand separator
    # (`,` or `]`); fold it back into one token regardless of how graviola
    # chose to space or split its arithmetic.
    return re.sub(r"#\s*([^,\]]*)", _fix_immediate, line)


def main():
    if len(sys.argv) >= 2 and sys.argv[1] == "patch":
        patch_graviola(Path(sys.argv[2]))
        return

    if len(sys.argv) >= 2 and sys.argv[1] == "extract":
        root, module, dst = Path(sys.argv[2]), sys.argv[3], sys.argv[4]
        # A handful of files (module name) hold a function under a different
        # name -- e.g. sha3_keccak_f1600_alt.rs's fn is still called
        # sha3_keccak_f1600, an alternative implementation selected at a
        # higher level by cfg rather than by name. Pass that real name as a
        # 5th argument when it differs from the module/output name.
        fn_name = sys.argv[5] if len(sys.argv) > 5 else module
        expanded = run_cargo_expand(root, module)
        instructions = parse_expanded(expanded, fn_name)
        with open(dst, "w") as f:
            f.write(f"{module}:\n")
            for line in instructions:
                f.write(line + "\n")
            f.write("ret\n")
        print(f"{module}: {len(instructions)} instructions -> {dst}")
        return

    sys.exit(__doc__)


if __name__ == "__main__":
    main()
