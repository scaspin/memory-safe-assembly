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

A few functions address a `static` Rust array (a precomputed table) via a
`sym` operand to the `asm!` call rather than a register. The expanded
template text leaves these as a bare `{N}@PAGE`/`{N}@PAGEOFF` placeholder
-- `N` the operand's position, counting from zero after the template
string -- because unlike a register operand (which the compiler can and
does substitute textually at this same macro-expansion stage), a symbol's
address is only known at link time. This script resolves `{N}` back to
that operand's symbol name by parsing the `asm!` call's own operand list
(looking for a bare or named `sym IDENT` at position N), the same way the
compiler will when it actually lowers the asm block. Having the real name
back, it then looks for a `static IDENT: [uN; LEN] = [...]` (or `iN`) item
of that name anywhere in the same module -- `cargo expand`'s module-level
output already contains it, being the same file -- parses its flat
element list, and appends it to the `.S` file as a GAS `.data` section
(`.size`, a label, and one directive line per element), which is exactly
the shape the checker's loader already knows how to lay out and size a
region from (s2n-bignum's own extracted `.S` files carry their constant
tables the identical way; see loader.rs). A referenced static this can't
find or can't parse as a flat numeric array is reported, not silently
skipped, since nothing here is specific to any one function or table.

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


def find_string_literal_span(text: str, start: int) -> tuple[int, int]:
    """The (opening quote index, closing quote index) of the Rust string
    literal beginning at the first `"` at or after `start`."""
    i = text.index('"', start)
    j = i + 1
    while True:
        if text[j] == "\\":
            j += 2
            continue
        if text[j] == '"':
            break
        j += 1
    return i, j


def extract_first_string_literal(text: str, start: int) -> str:
    """The Rust string literal beginning at the first `"` at or after
    `start`, as its unescaped contents."""
    i, j = find_string_literal_span(text, start)
    return unescape_rust_string(text[i + 1 : j])


def find_matching_delimiter(text: str, open_index: int) -> int:
    """Index of the `)`/`]`/`}` matching the opening delimiter at
    `open_index`, skipping over nested delimiter groups and "..." string
    literals (so a bracket or comma inside one of those doesn't confuse
    the count)."""
    depth = 0
    i = open_index
    n = len(text)
    while i < n:
        c = text[i]
        if c == '"':
            i += 1
            while i < n and text[i] != '"':
                i += 2 if text[i] == "\\" else 1
            i += 1
            continue
        if c in "([{":
            depth += 1
        elif c in ")]}":
            depth -= 1
            if depth == 0:
                return i
        i += 1
    raise ValueError("unbalanced delimiters")


def split_top_level(text: str) -> list[str]:
    """`text` split on commas that sit outside any nested (), [], {} group
    or "..." string literal."""
    pieces = []
    depth = 0
    start = 0
    i = 0
    n = len(text)
    while i < n:
        c = text[i]
        if c == '"':
            i += 1
            while i < n and text[i] != '"':
                i += 2 if text[i] == "\\" else 1
            i += 1
            continue
        if c in "([{":
            depth += 1
        elif c in ")]}":
            depth -= 1
        elif c == "," and depth == 0:
            pieces.append(text[start:i])
            start = i + 1
        i += 1
    pieces.append(text[start:i])
    return [p.strip() for p in pieces if p.strip()]


SYM_OPERAND_RE = re.compile(r"^(?:[\w:]+\s*=\s*)?sym\s+([\w:]+)$")


def parse_sym_operands(expanded: str, asm_at: int) -> dict[int, str]:
    """Maps each `asm!` operand's position (0-based, counting from the
    first operand after the template string) to the symbol name of every
    bare or named `sym IDENT` operand in this call."""
    open_paren = asm_at + len("asm!")
    close_paren = find_matching_delimiter(expanded, open_paren)
    _, str_end = find_string_literal_span(expanded, open_paren)
    operands = split_top_level(expanded[str_end + 1 : close_paren])
    syms = {}
    for i, operand in enumerate(operands):
        m = SYM_OPERAND_RE.match(operand)
        if m:
            syms[i] = m.group(1)
    return syms


def substitute_sym_placeholders(raw: str, syms: dict[int, str]) -> tuple[str, set[str]]:
    """Replaces every `{N}` in `raw` that refers to a `sym` operand with
    that operand's symbol name, leaving any surrounding text (a `@PAGE`/
    `@PAGEOFF` suffix, a `:lo12:` prefix) untouched. Returns the rewritten
    text and the set of symbol names actually referenced, so the caller
    knows which tables to go find."""
    used: set[str] = set()

    def repl(m: re.Match) -> str:
        index = int(m.group(1))
        name = syms.get(index)
        if name is None:
            return m.group(0)
        used.add(name)
        return name

    return re.sub(r"\{(\d+)\}", repl, raw), used


WIDTH_FOR_TYPE = {"u8": 1, "i8": 1, "u16": 2, "i16": 2, "u32": 4, "i32": 4, "u64": 8, "i64": 8}
DIRECTIVE_FOR_WIDTH = {1: ".byte", 2: ".hword", 4: ".word", 8: ".quad"}


def parse_rust_int(token: str) -> int:
    token = token.strip().replace("_", "")
    negative = token.startswith("-")
    if negative:
        token = token[1:]
    m = re.match(r"0[xX][0-9a-fA-F]+|\d+", token)
    if not m:
        raise ValueError(f"not a numeric literal: {token!r}")
    text = m.group(0)
    value = int(text, 16) if text.lower().startswith("0x") else int(text)
    return -value if negative else value


def find_static_array(expanded: str, name: str) -> tuple[str, list[int]] | None:
    """The element type and flat value list of `static NAME: [uN/iN; LEN]
    = [...]` in `expanded`, or None if no such item is there (it is looked
    for only in the already-expanded module text, which holds every item
    of the module cargo-expand was pointed at -- not, for instance, a
    table defined in some other module and merely `use`d here)."""
    m = re.search(
        rf"\bstatic\s+{re.escape(name)}\s*:\s*\[\s*([iu](?:8|16|32|64))\s*;\s*(\d+)\s*\]\s*=\s*\[",
        expanded,
    )
    if not m:
        return None
    elem_type, declared_len = m.group(1), int(m.group(2))
    body_start = m.end() - 1
    body_end = find_matching_delimiter(expanded, body_start)
    body = re.sub(r"//[^\n]*", "", expanded[body_start + 1 : body_end])
    values = [parse_rust_int(tok) for tok in body.split(",") if tok.strip()]
    if len(values) != declared_len:
        sys.exit(
            f"static {name}: [..; {declared_len}] has {len(values)} elements "
            "after parsing -- the array literal is not a flat list of numeric "
            "literals this script understands"
        )
    return elem_type, values


def emit_data_section(name: str, elem_type: str, values: list[int]) -> str:
    width = WIDTH_FOR_TYPE[elem_type]
    directive = DIRECTIVE_FOR_WIDTH[width]
    lines = [".data", f".size {name}, {width * len(values)}", f"{name}:"]
    lines += [f"\t{directive}\t{hex(v) if v >= 0 else str(v)}" for v in values]
    return "\n".join(lines) + "\n"


def parse_expanded(expanded: str, name: str) -> tuple[list[str], list[str]]:
    """The normalized instruction lines for `fn name`, plus any `.data`
    section text (one block per table it addresses via a `sym` operand) to
    append after them."""
    fn_marker = re.search(rf"\bfn\s+{re.escape(name)}\s*\(", expanded)
    if not fn_marker:
        sys.exit(f"could not find `fn {name}(` in the expanded output")
    asm_at = expanded.find("asm!(", fn_marker.start())
    if asm_at == -1:
        sys.exit(f"no asm! call found after fn {name}(")
    raw = extract_first_string_literal(expanded, asm_at)

    syms = parse_sym_operands(expanded, asm_at)
    raw, used = substitute_sym_placeholders(raw, syms)
    data_blocks = []
    for table_name in sorted(used):
        found = find_static_array(expanded, table_name)
        if found is None:
            sys.exit(
                f"fn {name} addresses `{table_name}` via a sym operand, but no "
                f"`static {table_name}: [uN; LEN] = [...]` was found in the "
                "expanded module text to extract its contents from"
            )
        elem_type, values = found
        data_blocks.append(emit_data_section(table_name, elem_type, values))

    # A handful of functions write each instruction with a trailing `;`
    # (harmless, surplus punctuation -- the newline it precedes already
    # separates one instruction from the next).
    lines = [normalize(line.strip().rstrip(";").strip()) for line in raw.split("\n")]
    return [line for line in lines if line], data_blocks


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
        instructions, data_blocks = parse_expanded(expanded, fn_name)
        with open(dst, "w") as f:
            f.write(f"{module}:\n")
            for line in instructions:
                f.write(line + "\n")
            f.write("ret\n")
            for block in data_blocks:
                f.write("\n" + block)
        tables = f", {len(data_blocks)} table(s)" if data_blocks else ""
        print(f"{module}: {len(instructions)} instructions{tables} -> {dst}")
        return

    sys.exit(__doc__)


if __name__ == "__main__":
    main()
