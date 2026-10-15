#!/usr/bin/env python3
"""Extract the flat GAS-ish instruction text from a graviola low/aarch64/*.rs
file's `core::arch::asm!(...)` block into a plain .S text file the checker's
line parser can read.

Each instruction is one `Q!(piece piece ...)` call, where each piece is a
string literal, a local single-arm register-alias macro (`macro_rules! p {
() => { "x3" } }`, invoked as `p!()`), or `Label!("name", id[, After|Before])`
(a local-numeric-label declaration/reference). Unlike graviola's own `Label!`
macro, which resolves this to a GNU-as numeric local label (`id` + "f"/"b"),
this resolves it to the literal `name` instead: bums's parser does not
implement GNU numeric-label forward/backward scoping, only named labels (the
same reason s2n-bignum's own named labels already work against it elsewhere).

Known unsupported inputs: a few functions (edwards25519_decode/scalarmulbase/
scalarmuldouble, p384_montjdouble, bignum_inv_p256, bignum_point_select_p256,
p256_montjadd/montjdouble/montjmixadd as of this writing) use an `NSPACE!()`
local-subroutine-naming macro or structure this script does not resolve;
they are left unextracted rather than guessed at.

Requires a clone of https://github.com/ctz/graviola; point <input.rs> at a
file under its graviola/src/low/aarch64/ directory.

Usage: extract_asm.py <input.rs> <output.S> <label>
"""
import re
import sys


ALIAS_RE = re.compile(
    r'macro_rules!\s+(\w+)\s*\{\s*\(\)\s*=>\s*\{\s*"((?:[^"\\]|\\.)*)"\s*\}\s*;?\s*\}'
)
STRING_RE = re.compile(r'"((?:[^"\\]|\\.)*)"')
ALIAS_CALL_RE = re.compile(r'\b(\w+)!\(\)')
LABEL_RE = re.compile(r'Label!\(\s*"([^"]*)"\s*,\s*\d+\s*(?:,\s*(?:After|Before)\s*)?\)')


def build_alias_table(text):
    aliases = {}
    for name, value in ALIAS_RE.findall(text):
        aliases[name] = value
    return aliases


def resolve_piece(piece, aliases):
    """One comma-free token inside a Q!(...) call: a string literal, an
    alias!() call, or a Label!(...) reference."""
    piece = piece.strip()
    if not piece:
        return ""
    m = LABEL_RE.fullmatch(piece)
    if m:
        return m.group(1)
    m = STRING_RE.fullmatch(piece)
    if m:
        return m.group(1).replace('\\"', '"')
    m = ALIAS_CALL_RE.fullmatch(piece)
    if m:
        name = m.group(1)
        if name not in aliases:
            raise ValueError(f"no alias definition for {name}!()")
        return aliases[name]
    raise ValueError(f"unrecognized Q!() piece: {piece!r}")


def split_top_level(s):
    """Split a Q!(...) call's argument list on spaces that are not inside a
    string literal or parens -- graviola writes pieces space-separated, not
    comma-separated, inside one Q!() call."""
    pieces = []
    buf = ""
    depth = 0
    in_str = False
    i = 0
    while i < len(s):
        c = s[i]
        if in_str:
            buf += c
            if c == "\\" and i + 1 < len(s):
                buf += s[i + 1]
                i += 2
                continue
            if c == '"':
                in_str = False
            i += 1
            continue
        if c == '"':
            in_str = True
            buf += c
        elif c == "(":
            depth += 1
            buf += c
        elif c == ")":
            depth -= 1
            buf += c
        elif c.isspace() and depth == 0:
            if buf.strip():
                pieces.append(buf.strip())
            buf = ""
        else:
            buf += c
        i += 1
    if buf.strip():
        pieces.append(buf.strip())
    return pieces


def extract_asm_block(text):
    """The text strictly between `core::arch::asm!(` and its matching `)`."""
    start = text.index("core::arch::asm!(")
    i = start + len("core::arch::asm!(")
    depth = 1
    j = i
    while depth > 0:
        if text[j] == "(":
            depth += 1
        elif text[j] == ")":
            depth -= 1
        j += 1
    return text[i : j - 1]


def main():
    src_path, dst_path, label = sys.argv[1], sys.argv[2], sys.argv[3]
    with open(src_path) as f:
        text = f.read()

    aliases = build_alias_table(text)
    block = extract_asm_block(text)

    lines = []
    for raw in block.splitlines():
        stripped = raw.strip().rstrip(",")
        if not stripped.startswith("Q!("):
            continue
        assert stripped.endswith(")"), stripped
        inner = stripped[len("Q!(") : -1]
        pieces = split_top_level(inner)
        instr = "".join(resolve_piece(p, aliases) for p in pieces)
        instr = instr.replace("] !", "]!")
        # graviola sometimes spaces a parenthesized immediate ("# (128 + 0)");
        # the checker only keeps the parenthesized expression as one token
        # when it directly follows the `#` with no space.
        instr = re.sub(r"#\s+\(", "#(", instr)
        lines.append(instr)

    if not lines:
        sys.exit(f"no Q!() instruction lines found in {src_path}")

    with open(dst_path, "w") as f:
        f.write(f"{label}:\n")
        for line in lines:
            f.write(line + "\n")
        f.write("ret\n")

    print(f"{src_path} -> {dst_path}: {len(lines)} instructions")


if __name__ == "__main__":
    main()
