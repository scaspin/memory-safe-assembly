import re
import sys
from pathlib import Path

EVAL = Path(__file__).resolve().parent.parent
ASM = EVAL.parent / "openblas-playground" / "asm"
OUT = EVAL / "handasm"
REG = {"rax": 0, "rcx": 1, "rdx": 2, "rbx": 3, "rsp": 4, "rbp": 5, "rsi": 6, "rdi": 7, "r8": 8, "r9": 9}
CALLEE_SAVED = {3, 4, 5, 12, 13, 14, 15}
DROPPED = re.compile(r"^\s*(nop\w*|prefetch\w*)\b")
HALF_MOVES = ("movhps", "movhpd", "movlps", "movlpd")
REGISTER_ARITH = ("addpd", "addsd", "andps", "andpd", "haddpd", "pcmpeqb", "mulpd", "mulsd", "subpd", "subsd", "maxpd", "maxsd")

KERNELS = {
    "dcopy_k": dict(args=["n", "x", "incx", "y", "incy"],
                    regions={"x": ("incx", False), "y": ("incy", True)},
                    call=dict(n=100, incx=1, incy=1)),
    "dasum_k": dict(args=["n", "x", "incx"],
                    regions={"x": ("incx", False)},
                    call=dict(n=100, incx=1)),
}
ARG_REGS = ["rdi", "rsi", "rdx", "rcx", "r8", "r9"]


def port(line):
    stripped = line.strip()
    if DROPPED.match(stripped):
        return None, f"dropped (no memory access): {stripped}"
    mnemonic = stripped.split()[0] if stripped else ""
    if mnemonic in HALF_MOVES:
        return line.replace(mnemonic, "movsd", 1), f"same-width memory move: {stripped}"
    if mnemonic in REGISTER_ARITH:
        operands = stripped[len(mnemonic):].strip()
        width = 8 if mnemonic.endswith("sd") else 16
        if "(" in operands and width == 8:
            return f"movsd {operands}", f"same-width load: {stripped}"
        return f"xorps {operands}", f"data-only op with the same operands: {stripped}"
    return line, None


FLAG_SETTERS = re.compile(r"^\t(cmp|sub|dec|test|sar|shr|and|add|or|xor|inc|neg)\w*\s")
CONDITIONAL = re.compile(r"^\tj(e|ne|l|le|g|ge|b|be|a|ae|z|nz)\s")


def branch_flags(body):
    out, notes = [], []
    last = None
    for line in body:
        jump = CONDITIONAL.match(line)
        if jump and last is not None:
            setter, operands = last.split(None, 1)
            cc = jump.group(1)
            if setter in ("sarq", "shrq", "sarl", "shrl", "andq", "orq", "xorq", "addq", "incq", "negq") and cc not in ("e", "ne", "z", "nz"):
                dest = operands.split(",")[-1].strip()
                out.append(f"\tcmpq\t$0, {dest}")
                notes.append(f"flags: compare {setter} result with 0 before j{cc}")
            elif setter in ("testq", "testl"):
                left, right = [o.strip() for o in operands.split(",")]
                if left == right and cc not in ("e", "ne", "z", "nz"):
                    out[-1] = f"\tcmpq\t$0, {right}"
                    notes.append(f"flags: test r,r with j{cc} as cmp $0")
                elif left.startswith("$") and int(left[1:], 0) >= 0 and cc in ("le", "g"):
                    line = line.replace(f"j{cc}", "je" if cc == "le" else "jne", 1)
                    notes.append(f"flags: test with a positive mask, j{cc} as {'je' if cc == 'le' else 'jne'}")
        out.append(line)
        if FLAG_SETTERS.match(line):
            last = line.strip()
        elif jump or line.strip().endswith(":"):
            pass
        elif re.match(r"^\t(mov|lea|xorps|movsd|movups|movaps|shufpd|unpck|pxor|psrlq|prefetch)", line):
            pass
        else:
            last = None if not line.startswith("\tj") else last
    return out, notes


def size_expr(count_reg, inc_reg):
    product = f"(SingleBExp SingleMul (SingleVar {REG[count_reg]}) (SingleVar {REG[inc_reg]}))"
    return f"(SingleBExp SingleMul {product} (SingleConst 8))"


def reg_types(sized, public):
    return "\n".join(f"     ((RangeConst {'(0 8)' if i in sized else '(0 0)'}) ((SingleVar {i}) {'(false)' if i in public else '()'}))" for i in range(32))


def valid(size):
    return f"((((SingleConst 0) {size}) (RangeConst (((SingleConst 0) {size}))) (SingleTop (true))))"


def stack(spills):
    slots = " ".join(f"(((SingleConst {a}) (SingleConst {b})) (RangeConst ()) (SingleTop ()))" for a, b in spills + [(0, 8)])
    return f"((4 (Unified (() true true))) ({slots}))"


def entry(name, sized, public, spills, regions, constraints):
    mem = [stack(spills)] + [f"(({r} (Unified (() true {'true' if w else 'false'}))) {valid(s)})" for r, s, w in regions]
    constr = " ".join(f"(Cond (Le {a} {b}))" for a, b in constraints)
    return f"""((func_name {name})
   (reg_type (
{reg_types(sized, public)}))
   (mem_type ({' '.join(mem)}))
   (stack_spill_info ({' '.join(f'({a} {b})' for a, b in spills)}))
   (constr_info ((constr_in ({constr})) (constr_out ()))))"""


def build(name, spec, variant):
    source = (ASM / f"{name}-x86_64.S").read_text().splitlines()
    body, changes = [], []
    for line in source:
        if line.strip().startswith(("#", ".p2align")) or not line.strip():
            continue
        new, note = port(line)
        if note:
            changes.append(note)
        if new is not None:
            new = re.sub(rf"\b({name}_[0-9a-f]+)\b", r".L\1", new)
            body.append(new.strip() if new.strip().endswith(":") else "\t" + new.strip())
    body, flag_changes = branch_flags(body)
    changes += flag_changes
    regs = {arg: ARG_REGS[i] for i, arg in enumerate(spec["args"])}
    call = dict(spec["call"])
    if variant == "unit-stride":
        call = {k: (1 if k.startswith("inc") else v) for k, v in call.items()}
    n = call["n"]
    driver = ["main:", "\tpushq\t%rax"]
    for arg in spec["args"]:
        reg = regs[arg]
        if arg in spec["regions"]:
            driver.append(f"\tleaq\t{arg}_buf(%rip), %{reg}")
        else:
            driver.append(f"\tmovq\t${call[arg]}, %{reg}")
    driver += [f"\tcallq\t{name}", "\txorl\t%eax, %eax", "\tpopq\t%rcx", "\tretq", "\t.size\tmain, .-main"]
    globals_asm = []
    for arg, (inc, _) in spec["regions"].items():
        size = n * call[inc] * 8
        globals_asm += [f"\t.type\t{arg}_buf,@object", "\t.data", f"\t.globl\t{arg}_buf", "\t.p2align\t4", f"{arg}_buf:", f"\t.zero\t{size}", f"\t.size\t{arg}_buf, {size}"]
    text = ["\t.text", f"\t.globl\t{name}", f"\t.type\t{name},@function", *body, f"\t.size\t{name}, .-{name}",
            "\t.globl\tmain", "\t.type\tmain,@function", *driver, *globals_asm]
    sized = {REG[regs[a]] for a in spec["args"]} | CALLEE_SAVED
    public = {REG[regs[a]] for a in spec["args"]} | {4}
    regions = []
    constraints = []
    for arg, (inc, writable) in spec["regions"].items():
        regions.append((REG[regs[arg]], size_expr(regs["n"], regs[inc]), writable))
        if variant == "unit-stride":
            constraints.append((f"(SingleConst 1)", f"(SingleVar {REG[regs[inc]]})"))
            constraints.append((f"(SingleVar {REG[regs[inc]]})", "(SingleConst 1)"))
        else:
            constraints.append(("(SingleConst 1)", f"(SingleVar {REG[regs[inc]]})"))
    kernel = entry(name, sized, public, [], regions, constraints)
    main = entry("main", CALLEE_SAVED, {4}, [(-8, 0)], [], [])
    globals_sexp = " ".join(f"({arg}_buf {valid(f'(SingleConst {n * call[inc] * 8})')})" for arg, (inc, _) in spec["regions"].items())
    sexp = f"(({kernel}\n {main})\n ({globals_sexp}))\n"
    assert sexp.count("(") == sexp.count(")")
    tag = f"{name}" if variant == "contract" else f"{name}_unit"
    out = OUT / tag
    out.mkdir(parents=True, exist_ok=True)
    asm_text = "\n".join(text).replace(f"\t.globl\t{name}", f"\t.globl\t{tag}").replace(f"\t.type\t{name},@function", f"\t.type\t{tag},@function") if False else "\n".join(text)
    (out / f"{tag}.s").write_text(asm_text + "\n")
    (out / f"{tag}.final.sexp").write_text(sexp)
    (out / "port.txt").write_text("\n".join(changes) + "\n")
    print(f"{tag}: {len(body)} lines, {len(changes)} ported ({sum(c.startswith('dropped') for c in changes)} dropped)")


if __name__ == "__main__":
    for name in sys.argv[1:] or KERNELS:
        for variant in ("contract", "unit-stride"):
            build(name, KERNELS[name], variant)
