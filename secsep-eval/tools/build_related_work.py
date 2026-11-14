import csv
import json
from collections import defaultdict
from pathlib import Path

EVAL = Path(__file__).resolve().parent.parent
DATA = EVAL / "paper-data" / "data"
TABLES = EVAL / "paper-data" / "tables"


def rows(name):
    path = DATA / name
    return list(csv.DictReader(open(path))) if path.exists() else []


def tex(text):
    return (text.replace("\\", "\\textbackslash{}").replace("&", "\\&").replace("%", "\\%")
            .replace("_", "\\_").replace("#", "\\#").replace("~", "$\\sim$").replace("<=", "$\\le$")
            .replace(">=", "$\\ge$"))


def s2n_summary():
    s2n = [r for r in rows("s2n_bignum_vs_bums.csv") if r["proof_file"]]
    by_module = defaultdict(lambda: defaultdict(int))
    for r in s2n:
        m = by_module[r["module"]]
        m["functions"] += 1
        m["verified"] += r["bums_status"] == "verified"
        for k in ["bums_clauses", "bums_tokens", "spec_lines_main", "tactic_lines", "lemma_and_spec_lines"]:
            m[k] += int(r[k])
    total = defaultdict(int)
    for m in by_module.values():
        for k, v in m.items():
            total[k] += v
    return s2n, by_module, total


def vale_vs_bums():
    vale = {r["primitive"]: r for r in rows("vale_effort.csv")}
    bums = json.loads((EVAL / "tools" / "bums_by_primitive.json").read_text())
    out = []
    for primitive in ["aes / aes-gcm", "sha-256", "poly1305", "curve25519", "bignum"]:
        v, b = vale.get(primitive, {}), bums.get(primitive, {})
        out.append(dict(primitive=primitive,
                        vale_procedures=v.get("procedures", ""), vale_spec_lines=v.get("spec_lines", ""),
                        vale_code_and_proof_lines=v.get("code_and_proof_lines", ""), vale_fstar_lemma_lines=v.get("fstar_lemma_lines", ""),
                        bums_functions=b.get("functions", ""), bums_clauses=b.get("clauses", ""), bums_tokens=b.get("tokens", ""),
                        bums_playgrounds="; ".join(b.get("playgrounds", []))))
    return out


def dynamic_summary():
    found = {r["tool"]: r for r in rows("dynamic_tools_summary.csv")}
    def cell(tool):
        r = found.get(tool)
        return f"{r['detected']}/{r['mutants']} mutants detected; {r['note']}" if r else "pending (runs in progress)"
    return cell


def safety_summary():
    ours = [r for r in rows("s2n_bignum_safety_effort.csv") if r["annotated_in_bums"] == "True"]
    def median(values):
        values = sorted(values)
        return values[len(values) // 2] if values else 0
    auto = [int(r["safety_lines"]) for r in ours if r["safety_proof_style"].startswith("automatic")]
    scaffold = [int(r["safety_lines"]) for r in ours if r["safety_proof_style"].startswith("scaffolded")]
    return dict(lines=sum(int(r["safety_lines"]) for r in ours), auto_files=len(auto), auto_median=median(auto),
                scaffold_files=len(scaffold), scaffold_median=median(scaffold))


def main():
    safety = safety_summary()
    s2n, by_module, s2n_total = s2n_summary()
    primitives = vale_vs_bums()
    secsep = rows("per_benchmark.csv")
    mutation = rows("mutation.csv")
    dyn = dynamic_summary()
    bums_secsep_clauses = sum(int(r["bums_clauses"]) for r in secsep)
    secsep_clauses = sum(int(r["secsep_clauses"]) for r in secsep)
    octal_checker = sum(r["octal_class"] == "type checker rejects (function-level)" for r in mutation)
    vale_aes = next(p for p in primitives if p["primitive"] == "aes / aes-gcm")

    table = [
        dict(tool="BUMS (this work)", input="existing assembly (hand-written or compiled), GNU/AT&T",
             isa="AArch64, x86-64", property="memory safety against a per-function contract (each parameter its own region)",
             automation="automatic once annotated (symbolic execution + Z3)",
             effort=f"{bums_secsep_clauses} clauses for SecSep's 21 functions; {s2n_total['bums_clauses']} clauses for 71 s2n-bignum functions",
             evidence=f"verifies 21/21 SecSep functions and {s2n_total['verified']}/{s2n_total['functions']} s2n-bignum functions; rejects 12/12 mutants at the faulting instruction",
             runs_on_our_code="yes", measured="yes"),
        dict(tool="SecSep / Octal (CCS 2025)", input="compiled C (clang 16) + C source annotations + LLVM layout metadata",
             isa="x86-64", property="memory safety by typing (relative to the analysed program's callers) and secret/public stack separation for speculative execution",
             automation="type inference + checking automatic; whole program from main; annotations manual",
             effort=f"{secsep_clauses} clauses for the same 21 functions (paper: 122 lines over 32 functions)",
             evidence=f"21/21 benchmark functions type-check; 12/12 mutants rejected, {octal_checker}/12 by its type checker; 1.0% software / 1.2% runtime overhead (gem5)",
             runs_on_our_code="only its 6 benchmarks and a hand-built md5 (parser rejects 0.5-80% of hand-written x86; no AArch64)", measured="yes"),
        dict(tool="s2n-bignum (HOL Light)", input="existing assembly written for verification",
             isa="x86-64, AArch64",
             property="functional correctness for every function; a separate _SAFE theorem (constant time and memory safety together) for 88/331 AArch64 and 66/341 x86 proof files",
             automation="interactive theorem proving; safety of straight-line code by one tactic, loops and branches scaffolded by hand",
             effort=(f"same 71 functions (67 proof files): safety alone {safety['lines']} lines "
                     f"({safety['auto_files']} automatic, median {safety['auto_median']} lines; {safety['scaffold_files']} hand-scaffolded, median {safety['scaffold_median']} lines); "
                     f"functional correctness {s2n_total['tactic_lines']} tactic + {s2n_total['spec_lines_main']} specification lines"),
             evidence="machine-checked; safety theorems are logically independent of the correctness theorems but their specifications are generated from them",
             runs_on_our_code="yes (these are BUMS's bignum benchmarks)", measured="yes (counted)"),
        dict(tool="Vale / EverCrypt (USENIX Security 2017)", input="assembly written in the Vale DSL (generates assembly)",
             isa="x86-64, ppc64le", property="functional correctness, memory safety, and side-channel (taint) properties",
             automation="semi-automatic (F*/Z3 plus manual lemmas)",
             effort=f"AES/AES-GCM: {vale_aes['vale_procedures']} procedures, {vale_aes['vale_spec_lines']} spec + {vale_aes['vale_code_and_proof_lines']} code/proof + {vale_aes['vale_fstar_lemma_lines']} F* lemma lines (BUMS: {vale_aes['bums_functions']} AES/GCM functions, {vale_aes['bums_clauses']} clauses)",
             evidence="machine-checked; verifies its own implementations, not existing perlasm", runs_on_our_code="no (different code)", measured="yes (counted, same algorithm)"),
        dict(tool="Islaris (PLDI 2022)", input="machine code via the Isla ISA semantics", isa="Armv8-A, RISC-V",
             property="functional correctness and memory safety (Iris separation logic)", automation="interactive (Coq) with automation",
             effort="not counted (no shared functions)", evidence="foundational proofs", runs_on_our_code="not attempted", measured="no"),
        dict(tool="Binsec / angr (binary symbolic execution)", input="binaries", isa="x86, ARM, others",
             property="bug finding; a proof only with full path coverage (loops are unrolled or bounded)", automation="automatic with a harness and bounds",
             effort="harness per function", evidence="not run", runs_on_our_code="possible", measured="no"),
        dict(tool="AddressSanitizer", input="C/C++ compiled with instrumentation", isa="x86-64, AArch64, others",
             property="runtime detection of out-of-bounds accesses in instrumented code (hand-written assembly is not instrumented)",
             automation="automatic; depends on test inputs", effort="test harness", evidence=dyn("ASan"), runs_on_our_code="yes", measured="yes"),
        dict(tool="Valgrind memcheck", input="unmodified binaries (dynamic binary translation)", isa="x86-64, AArch64 (Linux)",
             property="runtime detection of heap out-of-bounds (redzones) and uninitialised reads; no stack or global bounds",
             automation="automatic; depends on test inputs", effort="test harness", evidence=dyn("Valgrind"), runs_on_our_code="yes (Linux x86-64 container)", measured="yes"),
    ]
    with open(DATA / "related_work.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(table[0]))
        w.writeheader()
        w.writerows(table)
    with open(DATA / "vale_vs_bums_primitive.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(primitives[0]))
        w.writeheader()
        w.writerows(primitives)

    TABLES.mkdir(parents=True, exist_ok=True)
    t = ["% needs \\usepackage{booktabs,tabularx}", "\\begin{tabularx}{\\textwidth}{>{\\raggedright}p{2.2cm}>{\\raggedright}p{2.6cm}>{\\raggedright}p{1.5cm}>{\\raggedright}X>{\\raggedright}p{2.4cm}>{\\raggedright\\arraybackslash}X}",
         "\\toprule", "Tool & Input & ISA & Property & Automation & Effort / evidence\\\\", "\\midrule"]
    for r in table:
        t.append(f"{tex(r['tool'])} & {tex(r['input'])} & {tex(r['isa'])} & {tex(r['property'])} & {tex(r['automation'])} & {tex(r['effort'])}; {tex(r['evidence'])}\\\\")
    t += ["\\bottomrule", "\\end{tabularx}"]
    (TABLES / "related_work.tex").write_text("\n".join(t) + "\n")

    t = ["\\begin{tabular}{lrrrrrr}", "\\toprule",
         "Module & \\#Fn & BUMS ver. & BUMS clauses & BUMS tokens & s2n spec lines & s2n tactic lines\\\\", "\\midrule"]
    for name, m in sorted(by_module.items()):
        t.append(f"{tex(name)} & {m['functions']} & {m['verified']} & {m['bums_clauses']} & {m['bums_tokens']} & {m['spec_lines_main']} & {m['tactic_lines']}\\\\")
    t += ["\\midrule", f"Total & {s2n_total['functions']} & {s2n_total['verified']} & {s2n_total['bums_clauses']} & {s2n_total['bums_tokens']} & {s2n_total['spec_lines_main']} & {s2n_total['tactic_lines']}\\\\",
          "\\bottomrule", "\\end{tabular}"]
    (TABLES / "s2n_bignum_effort.tex").write_text("\n".join(t) + "\n")

    t = ["\\begin{tabular}{lrrrrrr}", "\\toprule",
         "Primitive & \\multicolumn{4}{c}{Vale (x64)} & \\multicolumn{2}{c}{BUMS}\\\\",
         " & Proc. & Spec & Code+proof & F* lemmas & Fns & Clauses\\\\", "\\midrule"]
    for p in primitives:
        t.append(f"{tex(p['primitive'])} & {p['vale_procedures']} & {p['vale_spec_lines']} & {p['vale_code_and_proof_lines']} & {p['vale_fstar_lemma_lines']} & {p['bums_functions']} & {p['bums_clauses']}\\\\")
    t += ["\\bottomrule", "\\end{tabular}", "% Same algorithm, different code: Vale verifies its own implementations; BUMS verifies existing aws-lc/s2n-bignum/graviola/corecrypto assembly."]
    (TABLES / "vale_vs_bums_primitive.tex").write_text("\n".join(t) + "\n")

    md = ["| Tool | Input | ISA | Property | Automation | Effort | Evidence | Runs on our code |", "|---|---|---|---|---|---|---|---|"]
    for r in table:
        md.append(f"| {r['tool']} | {r['input']} | {r['isa']} | {r['property']} | {r['automation']} | {r['effort']} | {r['evidence']} | {r['runs_on_our_code']} |")
    (EVAL / "paper-data" / "related_work.md").write_text("\n".join(md) + "\n")
    print("data/related_work.csv data/vale_vs_bums_primitive.csv tables/related_work.tex tables/s2n_bignum_effort.tex tables/vale_vs_bums_primitive.tex related_work.md")


if __name__ == "__main__":
    main()
