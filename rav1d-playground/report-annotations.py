#!/usr/bin/env python3
"""Categorise the outcome of every `#[check_mem_safe]` declaration in this crate.

Usage:
    cargo build --release -p rav1d-playground --message-format=json > build.json
    python3 report-annotations.py build.json

Each declaration either verifies (no diagnostic) or produces exactly one error.
Errors fall into two shapes: the analysis ran and rejected the program
("Accessing address outside allowable memory regions", "could not resolve
loop", ...), or the engine hit something it does not model yet and the proc
macro panicked. The categories below separate the two so the second group can
be read as an engine feature backlog rather than as findings.
"""

import collections
import glob
import json
import os
import re
import sys

CRATE = os.path.dirname(os.path.abspath(__file__))

# (category, regex against the error text or panic message)
CATEGORIES = [
    ("unsupported: jump table / PC-relative const data",
     r"adrp not invoked correctly|No label found|No label 1|No label 2|undefined label"),
    ("unsupported: SIMD instruction",
     r"simd instruction .* not supported|simd arithmetic instruction not supported|"
     r"unsupported operand in simd|unsupported shl vector type"),
    ("unsupported: scalar instruction",
     r"other instruction not implemented yet|Unsupported arithmetic instruction|"
     r"memory instruction not supported yet|unsupported condition code"),
    ("unsupported: call into another asm function (blr)",
     r'opcode: "blr"'),
    ("unsupported: control-flow instruction",
     r"control flow instruction not yet implemented"),
    ("unsupported: condition code",
     r"csel with condition code|unsupported condition code"),
    ("unsupported: engine internals",
     r"memory regions in access check"),
    ("unsupported: register operand",
     r"Not a valid register operand"),
    ("unsupported: instruction parse",
     r"integer parsing failed|instruction parse"),
    ("unsupported: macro cannot model this argument",
     r"not yet implemented: Input type|ptr array size|Arg list type|"
     r"size of undefined type|Standard Input type"),
    ("unresolved loop",
     r"could not resolve loop|not summarized after"),
    ("branch depth exceeded",
     r"branch depth exceeded"),
    ("exploration limit reached",
     r"exploration limit reached"),
    ("flag read before it was set",
     r"Flag cannot be branched on|reads a flag the program never set|"
     r"reads a carry flag the program never set"),
    ("symbol missing from disassembly",
     r"Start label not found in program"),
    ("memory safety violation reported",
     r"Accessing address outside allowable memory regions|Need memory region to load from|"
     r"not provably within region|has no declared region|Cannot prove access safe"),
]


def declarations():
    """Map (relative path, attribute line) -> (module, function name).

    The same asm symbol may be declared in more than one module (the hand
    written examples in `main.rs` alongside the generated ones), so outcomes
    are tracked per declaration, not per symbol.
    """
    index = {}
    for path in sorted(glob.glob(os.path.join(CRATE, "src", "**", "*.rs"), recursive=True)):
        rel = os.path.relpath(path, os.path.dirname(CRATE))
        lines = open(path).read().splitlines()
        pending = None
        for n, line in enumerate(lines, 1):
            if "check_mem_safe" in line and line.lstrip().startswith("#["):
                pending = n
            elif pending is not None:
                m = re.match(r"\s*fn (\w+)", line)
                if m:
                    module = os.path.splitext(os.path.basename(rel))[0]
                    index[(rel, pending)] = (module, m.group(1))
                    pending = None
    return index


def categorise(text):
    for name, pattern in CATEGORIES:
        if re.search(pattern, text):
            return name
    return "other"


def detail(text):
    """A short, de-duplicated reason: the offending opcode where there is one."""
    m = re.search(r"simd instruction ([\w.]+) not supported", text)
    if m:
        return m.group(1)
    m = re.search(r'simd arithmetic instruction not supported yet "([\w.]+)"', text)
    if m:
        return m.group(1)
    m = re.search(r'opcode: "([\w.]+)"', text)
    if m:
        return m.group(1)
    m = re.search(r"adrp not invoked correctly.*", text)
    if m:
        return "adrp <reg>, <const-data label>"
    m = re.search(r'Not a valid register operand for \w+ operation Label\("(\w+)"\)', text)
    if m:
        return m.group(1)
    m = re.search(r"csel with condition code not yet implemented (\w+)", text)
    if m:
        return f"csel {m.group(1)}"
    return text.strip().splitlines()[0][:80] if text.strip() else ""


def main():
    build_json = sys.argv[1]
    index = declarations()

    errors = {}
    finished = False
    reached = False
    for line in open(build_json):
        line = line.strip()
        if not line.startswith("{"):
            continue
        try:
            rec = json.loads(line)
        except json.JSONDecodeError:
            continue
        if rec.get("reason") == "build-finished":
            finished = True
        if "rav1d-playground" in rec.get("package_id", ""):
            reached = True
        if rec.get("reason") != "compiler-message":
            continue
        msg = rec["message"]
        if msg.get("level") != "error":
            continue
        spans = msg.get("spans") or []
        if not spans:
            continue
        key = (spans[0]["file_name"], spans[0]["line_start"])
        fn = index.get(key)
        if fn is None:
            continue
        text = msg["message"]
        for child in msg.get("children", []):
            text += "\n" + child.get("message", "")
        errors[fn] = text

    decls = sorted(index.values())
    total = len(decls)
    failed = len(errors)
    passed = total - failed
    if len(sys.argv) > 2:
        try:
            stderr = open(sys.argv[2]).read()
        except OSError:
            stderr = ""
        # A failed build script means the crate was never compiled, so no
        # declaration was analysed and an empty error list proves nothing.
        if "failed to run custom build command" in stderr:
            sys.exit("the build script failed; nothing was analysed (see the build's stderr)")
        if "process didn't exit successfully" in stderr and "(signal:" in stderr:
            print("WARNING: the compiler was killed by a signal; later declarations were never analysed")
            finished = False
    finished = finished and reached
    clean = "verified" if finished else "unknown"

    by_category = collections.defaultdict(list)
    for decl, text in errors.items():
        by_category[categorise(text)].append((decl, detail(text)))

    if not finished:
        print("WARNING: build did not finish; declarations without a diagnostic are unknown, not verified")
    print(f"Declarations analysed: {total}")
    print(f"  {clean + ':':<10} {passed}")
    print(f"  failing:   {failed}")
    print()

    print("Failure modes")
    print("-" * 72)
    for cat in sorted(by_category, key=lambda c: -len(by_category[c])):
        entries = by_category[cat]
        print(f"{len(entries):4}  {cat}")
        reasons = collections.Counter(d for _, d in entries)
        for reason, n in reasons.most_common():
            if reason:
                print(f"          {n:4} x {reason}")
    print()

    print("Per module")
    print("-" * 72)
    per_module = collections.Counter(m for m, _ in decls)
    per_module_fail = collections.Counter(m for m, _ in errors)
    for module in sorted(per_module):
        n = per_module[module]
        f = per_module_fail[module]
        print(f"  {module:<18} {n - f:>4} {clean} / {n:>4} declared")
    print()

    verified = [d for d in decls if d not in errors]
    print(f"{clean.capitalize()} ({len(verified)}):")
    for module, fn in verified:
        print(f"   {module}::{fn}")

    out = os.path.join(CRATE, "asm-status.tsv")
    with open(out, "w") as fh:
        fh.write("module\tfunction\tstatus\tcategory\tdetail\n")
        for decl in decls:
            module, fn = decl
            if decl in errors:
                text = errors[decl]
                fh.write(f"{module}\t{fn}\tfail\t{categorise(text)}\t{detail(text)}\n")
            else:
                fh.write(f"{module}\t{fn}\t{clean}\t\t\n")
    print(f"\nWrote {out}")


if __name__ == "__main__":
    main()
