import csv
import json
import re
import subprocess
import sys
from collections import Counter, defaultdict
from pathlib import Path

TOOLS = Path(__file__).resolve().parent
EVAL = TOOLS.parent
OUT = EVAL / "paper-data"
DATA, TABLES = OUT / "data", OUT / "tables"
OCTAL_OUT = EVAL / "octal-out-clean"
BENCH_SRC = EVAL / "secsep" / "benchmark" / "src"
PLAYGROUND = EVAL.parent / "secsep-playground"

BENCHES = ["salsa20", "sha512", "chacha20", "x25519", "poly1305", "ed25519_sign"]
PAPER_TABLE1 = {
    "salsa20": dict(loc=72, funcs=5, funcs_called=3, prospect_vars="9 (5)", prospect_anno="4 (2)", secsep_args=6, secsep_anno=5),
    "sha512": dict(loc=290, funcs=16, funcs_called=3, prospect_vars="24 (2)", prospect_anno="14 (1)", secsep_args=6, secsep_anno=5),
    "chacha20": dict(loc=100, funcs=7, funcs_called=3, prospect_vars="8 (7)", prospect_anno="4 (3)", secsep_args=8, secsep_anno=7),
    "x25519": dict(loc=1034, funcs=41, funcs_called=5, prospect_vars="361 (11)", prospect_anno="335 (4)", secsep_args=10, secsep_anno=7),
    "poly1305": dict(loc=314, funcs=11, funcs_called=7, prospect_vars="33 (32)", prospect_anno="26 (25)", secsep_args=11, secsep_anno=74),
    "ed25519_sign": dict(loc=2314, funcs=72, funcs_called=11, prospect_vars="512 (77)", prospect_anno="476 (69)", secsep_args=25, secsep_anno=24),
}
ENGINE_FIX = {
    "table_select": "loader models .ascii/.asciz data (k25519Precomp table)",
    "x25519_ge_scalarmult_base": "loader models .ascii/.asciz data (k25519Precomp table)",
    "SHA512": "memset/memcpy contracts with unsigned-length guard",
    "ED25519_sign": "memset/memcpy contracts with unsigned-length guard",
    "X25519": "repeated helper calls counted per call site",
    "CRYPTO_poly1305_update": "unsigned struct fields >= 0; narrow stores keep uncovered constant bytes",
    "poly1305_update": "symbolic 64-bit not (~x = -x-1)",
    "CRYPTO_poly1305_finish": "symbolic 64-bit not (~x = -x-1)",
    "CRYPTO_chacha_20": "forced-exit discharge; down-counter floor bounds; multi-back-edge inside-body rule",
}


def write_csv(name, rows, fields=None):
    DATA.mkdir(parents=True, exist_ok=True)
    fields = fields or list(rows[0])
    with open(DATA / name, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fields)
        w.writeheader()
        w.writerows(rows)
    print(f"data/{name}: {len(rows)} rows")


def read_tsv(path):
    rows = {}
    for line in open(path):
        parts = line.rstrip("\n").split("\t")
        if len(parts) >= 4:
            rows[parts[0]] = dict(status=parts[2], seconds=float(parts[3]), detail=parts[4] if len(parts) > 4 else "")
    return rows


def octal_function_times(bench):
    phases, queries = defaultdict(Counter), Counter()
    for log in (OCTAL_OUT / bench).glob("*.log"):
        for m in re.finditer(r"OCTAL_FUNC_TIME (\w+) (\S+) ([\d.]+) (\d+)", log.read_text(errors="ignore")):
            phases[m.group(2)][m.group(1)] += float(m.group(3))
            queries[m.group(2)] += int(m.group(4))
    return phases, queries


def octal_phase_stats(bench):
    stats = {}
    for phase in ["single_infer", "range_infer", "taint_infer", "change_infer", "check"]:
        s = json.loads((OCTAL_OUT / bench / f"{bench}.{phase}.stat").read_text())
        stats[phase] = s
    log = (EVAL / "secsep-timing" / f"{bench}.log").read_text()
    wall = float(re.search(r"([\d.]+) real", log).group(1))
    rss = int(re.search(r"(\d+)\s+maximum resident set size", log).group(1))
    return stats, wall, rss


def per_function():
    ann = json.loads((TOOLS / "ann.json").read_text())
    final = read_tsv(EVAL / "bums-run10.tsv")
    baseline = read_tsv(EVAL / "bums-run1.tsv")
    rows = []
    for bench in BENCHES:
        phases, queries = octal_function_times(bench)
        for fn, b in ann["bums"].items():
            if b["file"] != f"{bench}.S":
                continue
            s = ann["secsep"][fn]
            p = phases[fn]
            rows.append(dict(
                benchmark=bench, function=fn,
                bums_clauses=b["clauses"], bums_tokens=b["tokens"],
                secsep_clauses=s["clauses"], secsep_tokens=s["tokens"],
                bums_status_baseline=baseline[fn]["status"], bums_status_final=final[fn]["status"],
                bums_wall_s=final[fn]["seconds"],
                secsep_cpu_s=round(sum(p.values()), 2),
                secsep_infer_cpu_s=round(p["single"] + p["range"] + p["taint"], 2),
                secsep_check_cpu_s=round(p["check"], 2),
                secsep_smt_queries=queries[fn],
                engine_change_needed=ENGINE_FIX.get(fn, ""),
            ))
    write_csv("per_function.csv", rows)
    return rows


def benchmark_phases():
    rows = []
    for bench in BENCHES:
        stats, wall, rss = octal_phase_stats(bench)
        for phase, s in stats.items():
            rows.append(dict(benchmark=bench, phase=phase, cpu_s=round(s["time"], 2),
                             smt_queries=s["smt_queries"], smt_s=round(s["smt_queries_time"], 2)))
        rows.append(dict(benchmark=bench, phase="TOTAL_wall_incl_transform", cpu_s=wall,
                         smt_queries=sum(s["smt_queries"] for s in stats.values()),
                         smt_s=round(sum(s["smt_queries_time"] for s in stats.values()), 2)))
        rows.append(dict(benchmark=bench, phase="peak_rss_bytes", cpu_s=rss, smt_queries="", smt_s=""))
    write_csv("secsep_phases.csv", rows)


def per_benchmark(per_fn):
    rows = []
    for bench in BENCHES:
        fs = [r for r in per_fn if r["benchmark"] == bench]
        t = PAPER_TABLE1[bench]
        _, wall, _ = octal_phase_stats(bench)
        rows.append(dict(
            benchmark=bench, functions_compared=len(fs),
            secsep_clauses=sum(r["secsep_clauses"] for r in fs), bums_clauses=sum(r["bums_clauses"] for r in fs),
            secsep_tokens=sum(r["secsep_tokens"] for r in fs), bums_tokens=sum(r["bums_tokens"] for r in fs),
            secsep_cpu_s=round(sum(r["secsep_cpu_s"] for r in fs), 1), bums_wall_s=round(sum(r["bums_wall_s"] for r in fs), 1),
            bums_all_verified=all(r["bums_status_final"] == "verified" for r in fs),
            secsep_whole_program_wall_s=wall, secsep_paper_anno_lines_all_functions=t["secsep_anno"],
        ))
    write_csv("per_benchmark.csv", rows)
    return rows


def annotation_tags():
    rows = []
    for path in sorted(BENCH_SRC.rglob("*.c")):
        text = path.read_text(errors="ignore")
        for m in re.finditer(r"/\*\*(.*?)\*/\s*(?:NOINLINE\s*)?(?://[^\n]*\n\s*)?(?:static\s+)?(?:inline\s+)?[\w\s\*]+?\b(\w+)\s*\(", text, re.S):
            body, fn = m.group(1), m.group(2)
            if "@secsep" not in body:
                continue
            row = dict(file=path.name, function=fn, default="@secsep_default" in body,
                       variable_lines=len(re.findall(r"@secsep\s+[\w\->\.]+\s*:", body)),
                       explicit_constraints=len(re.findall(r"@secsep_(?:in|out)\b", body)))
            for tag in ["valid", "size", "taint", "const", "overlap", "sym", "unit"]:
                row[tag] = len(re.findall(r"@" + tag + r"\b", body))
            rows.append(row)
    write_csv("secsep_annotations_by_function.csv", rows)
    globals_ = Counter()
    for path in BENCH_SRC.rglob("*.[ch]"):
        text = path.read_text(errors="ignore")
        for k in ["SECRET_SYM", "PUBLIC_SYM", "SECRET_CONSTSYM", "PUBLIC_CONSTSYM", "SECRET_VAR", "PUBLIC_VAR"]:
            globals_[k] += len(re.findall(r"\b" + k + r"\b", text)) - (1 if path.name == "secsep.h" else 0)
    write_csv("secsep_global_markers.csv", [dict(marker=k, count=v) for k, v in sorted(globals_.items())])


def inferred_preconditions():
    rows = []
    for bench in BENCHES:
        out = subprocess.run([sys.executable, str(TOOLS / "ctx_stats.py"), str(OCTAL_OUT / bench / f"{bench}.interface")],
                             capture_output=True, text=True, check=True).stdout
        for line in out.splitlines():
            parts = line.split("\t")
            if len(parts) < 7:
                continue
            rows.append(dict(benchmark=parts[0], function=parts[1], clauses=int(parts[2]), layout=int(parts[3]),
                             nonoverlap=int(parts[4]), alignment_8=int(parts[5]), other=int(parts[6]),
                             other_clauses=parts[7] if len(parts) > 7 else ""))
    notes = {
        ("chacha20", "CRYPTO_chacha_20"): "other = the user-written @secsep_in constraint out - in >= 32",
        ("chacha20", "main"): "other = the user constraint propagated to the call site",
        ("poly1305", "CRYPTO_poly1305_finish"): "other = inferred 16-byte state alignment + inferred buf_used <= 16 (not annotated)",
        ("poly1305", "CRYPTO_poly1305_init"): "other = inferred 16-byte state alignment",
    }
    for r in rows:
        r["note"] = notes.get((r["benchmark"], r["function"]), "")
    write_csv("secsep_inferred_preconditions.csv", rows)


def rewrites():
    rows = []
    for bench in BENCHES:
        line = subprocess.run([sys.executable, str(TOOLS / "tf_log_stats.py"), str(OCTAL_OUT / bench / f"{bench}.transform.log")],
                              capture_output=True, text=True, check=True).stdout.strip()
        m = re.search(r"functions=(\d+) rewritten_insns=(\d+) emitted=(\d+) delta_shifted=(\d+) kinds=(\{.*\})", line)
        kinds = eval(m.group(5))
        rows.append(dict(benchmark=bench, functions=int(m.group(1)), rewritten_instructions=int(m.group(2)),
                         emitted_instructions=int(m.group(3)), delta_shifted=int(m.group(4)),
                         stores=sum(v for k, v in kinds.items() if k.endswith("/st")),
                         loads=sum(v for k, v in kinds.items() if k.endswith("/ld")),
                         push_pop=kinds.get("Push", 0) + kinds.get("Pop", 0), calls=kinds.get("Call", 0),
                         top_kinds=json.dumps(kinds)))
    write_csv("secsep_rewrites.csv", rows)


def mutation():
    rows = list(csv.DictReader(open(EVAL / "mutation" / "results.tsv"), delimiter="\t"))
    def octal_class(r):
        if r["octal_phase"] == "none":
            return "accepted"
        if r["octal_phase"] == "Type Checker":
            return "type checker rejects (function-level)"
        return "inference exception (no location)"
    for r in rows:
        r["bums_class"] = "rejected, localized" if r["bums_function"] == "FAIL" else "accepted"
        r["octal_class"] = octal_class(r)
        del r["bums_entry"]
    write_csv("mutation.csv", rows)
    return rows


def md5_case():
    rows = [
        dict(variant="md5 (BoringSSL md5-x86_64, unmodified)", fault="none", octal_main_calls_with="num = 4",
             octal_verdict="accepted (type-checks)", octal_note="", bums_verdict="verified", bums_note="contract data.len() == num * 64"),
        dict(variant="m1: one extra block", fault="reads block num+1", octal_main_calls_with="num = 4",
             octal_verdict="rejected (inference exception)", octal_note="ArchTypeError: slot annotation is None",
             bums_verdict="rejected", bums_note="read of 4 bytes at data + 64 not provably within region"),
        dict(variant="m2: num == 0 guard removed", fault="reads 64 bytes when num = 0", octal_main_calls_with="num = 4",
             octal_verdict="ACCEPTED (type-checks)", octal_note="silently inferred precondition num >= 1, checked only against main",
             bums_verdict="rejected", bums_note="read of 4 bytes at data + 0 not provably within region of length 0"),
        dict(variant="m3: m2 with main passing num = 0", fault="reads 64 bytes when num = 0", octal_main_calls_with="num = 0",
             octal_verdict="rejected at the call site", octal_note="FuncInterfaceError at main's call", bums_verdict="n/a (same function as m2)", bums_note=""),
    ]
    write_csv("md5_case_study.csv", rows)


def transform_check():
    rows = []
    for bench in BENCHES:
        for variant in ["raw", "folded"]:
            for fn, r in read_tsv(EVAL / "tf-check" / f"{variant}-{bench}-v2.tsv").items():
                rows.append(dict(benchmark=bench, function=fn, variant=variant, status=r["status"],
                                 seconds=r["seconds"], first_message=r["detail"].split(";")[0][:200]))
    write_csv("transform_check.csv", rows)


def parser_coverage():
    rows = []
    for r in csv.DictReader(open(EVAL / "octal-parse-coverage.tsv"), delimiter="\t"):
        name = r["file"]
        group = ("SecSep benchmark (clang 16 compiled)" if name.endswith(".s") else
                 "BoringSSL hand-written (linux)" if "-linux.S" in name else
                 "BoringSSL hand-written (apple)" if "-apple.S" in name else "OpenBLAS kernel")
        insns = int(r["insns"])
        failed = int(r["unsupported"]) + int(r.get("parse_error") or 0)
        rows.append(dict(group=group, file=name, instructions=insns, unsupported_or_unparsed=failed,
                         unsupported_share=round(failed / insns, 4) if insns else 0, top_unsupported=r.get("top_bad", "")))
    write_csv("octal_parser_coverage.csv", rows)


def bums_progression(per_fn):
    rows = [dict(benchmark=r["benchmark"], function=r["function"], baseline=r["bums_status_baseline"],
                 final=r["bums_status_final"], change=r["engine_change_needed"]) for r in per_fn]
    write_csv("bums_progression.csv", rows)


def latex_tables(per_fn, benches, mut):
    TABLES.mkdir(parents=True, exist_ok=True)
    t = ["\\begin{tabular}{lrrrrrrr}", "\\toprule",
         "Benchmark & \\#Fn & \\multicolumn{2}{c}{Clauses} & \\multicolumn{2}{c}{Tokens} & \\multicolumn{2}{c}{Time (s)}\\\\",
         " & & SecSep & BUMS & SecSep & BUMS & SecSep & BUMS\\\\", "\\midrule"]
    for r in benches:
        t.append(f"{r['benchmark'].replace('_', chr(92)+'_')} & {r['functions_compared']} & {r['secsep_clauses']} & {r['bums_clauses']} & "
                 f"{r['secsep_tokens']} & {r['bums_tokens']} & {r['secsep_cpu_s']:.0f} & {r['bums_wall_s']:.0f}\\\\")
    tot = lambda k: sum(r[k] for r in benches)
    t += ["\\midrule", f"Total & {tot('functions_compared')} & {tot('secsep_clauses')} & {tot('bums_clauses')} & {tot('secsep_tokens')} & "
          f"{tot('bums_tokens')} & {tot('secsep_cpu_s'):.0f} & {tot('bums_wall_s'):.0f}\\\\", "\\bottomrule", "\\end{tabular}"]
    (TABLES / "per_benchmark.tex").write_text("\n".join(t) + "\n")

    sym = {"rejected, localized": "\\ding{51}", "type checker rejects (function-level)": "$\\circ$",
           "inference exception (no location)": "$\\triangle$", "accepted": "\\ding{55}"}
    t = ["\\begin{tabular}{llcc}", "\\toprule",
         "Mutant & Fault & BUMS & SecSep\\\\", "\\midrule"]
    for r in mut:
        t.append(f"{r['mutant'].replace('_', chr(92)+'_')} & {r['fault']} & {sym[r['bums_class']]} & {sym[r['octal_class']]}\\\\")
    t += ["\\bottomrule", "\\end{tabular}",
          "% \\ding{51} rejected at the faulting instruction; $\\circ$ type checker rejects the function;",
          "% $\\triangle$ inference raised an exception (no location); \\ding{55} accepted. Needs \\usepackage{pifont}."]
    (TABLES / "mutation.tex").write_text("\n".join(t) + "\n")

    t = ["\\begin{tabular}{llrrrrr}", "\\toprule",
         "Benchmark & Function & \\multicolumn{2}{c}{Clauses} & \\multicolumn{2}{c}{Time (s)} & SMT\\\\",
         " & & SecSep & BUMS & SecSep & BUMS & queries\\\\", "\\midrule"]
    for r in per_fn:
        t.append(f"{r['benchmark'].replace('_', chr(92)+'_')} & \\texttt{{{r['function'].replace('_', chr(92)+'_')}}} & "
                 f"{r['secsep_clauses']} & {r['bums_clauses']} & {r['secsep_cpu_s']:.1f} & {r['bums_wall_s']:.1f} & {r['secsep_smt_queries']}\\\\")
    t += ["\\bottomrule", "\\end{tabular}"]
    (TABLES / "per_function.tex").write_text("\n".join(t) + "\n")
    print("tables/: per_benchmark.tex mutation.tex per_function.tex")


if __name__ == "__main__":
    per_fn = per_function()
    benchmark_phases()
    benches = per_benchmark(per_fn)
    annotation_tags()
    inferred_preconditions()
    rewrites()
    mut = mutation()
    md5_case()
    transform_check()
    parser_coverage()
    bums_progression(per_fn)
    write_csv("secsep_paper_table1.csv", [dict(benchmark=b, **v) for b, v in PAPER_TABLE1.items()])
    latex_tables(per_fn, benches, mut)
