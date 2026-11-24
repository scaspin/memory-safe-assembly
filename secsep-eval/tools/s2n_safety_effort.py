import csv
import re
from pathlib import Path

REPO = Path(__file__).resolve().parents[2] / "s2n-bignum"
EVAL = Path(__file__).resolve().parent.parent
OURS = EVAL / "paper-data" / "data" / "s2n_bignum_vs_bums.csv"
OUT = EVAL / "paper-data" / "data" / "s2n_bignum_safety_effort.csv"
SAFE_NAME = re.compile(r"\blet\s+(?:rec\s+)?(\w*(?:safe|SAFE|safety|SAFETY)\w*)\b")
AUTO = ("PROVE_SAFETY_SPEC_TAC",)
SCAFFOLD = ("CONCRETIZE_F_EVENTS_TAC", "ENSURES_EVENTS_WHILE", "ENSURES_EVENTS_SEQUENCE_TAC", "ENSURES_EVENTS_")


def strip_comments(text):
    out, depth, i = [], 0, 0
    while i < len(text):
        if text.startswith("(*", i):
            depth += 1
            i += 2
        elif text.startswith("*)", i) and depth:
            depth -= 1
            i += 2
        else:
            if depth == 0 or text[i] == "\n":
                out.append(text[i])
            i += 1
    return "".join(out)


def phrases(text):
    parts, depth, cur, quote = [], 0, [], False
    i = 0
    while i < len(text):
        c = text[i]
        if c == "`":
            quote = not quote
        if not quote and text.startswith(";;", i):
            parts.append("".join(cur) + ";;")
            cur = []
            i += 2
            continue
        cur.append(c)
        i += 1
    if "".join(cur).strip():
        parts.append("".join(cur))
    return parts


def lines(text):
    return sum(1 for l in text.split("\n") if l.strip())


HEADER = re.compile(r"\(\*\s*Constant-time and memory safety proof", re.I)


def analyse(path):
    raw = path.read_text(errors="ignore")
    split = HEADER.search(raw)
    before, after = (raw[: split.start()], raw[split.start():]) if split else (raw, "")
    correctness = code = 0
    defined = set()
    for p in phrases(strip_comments(before)):
        if re.search(r"define_assert_from_elf|define_word_list|define_trimmed", p):
            code += lines(p)
            continue
        if p.strip().startswith("needs") or not p.strip(";\n "):
            continue
        correctness += lines(p)
        top = re.match(r"\s*let\s+(?:rec\s+)?(\w+)", p)
        if top and len(top.group(1)) > 2 and not re.search(r"_mc$|_EXEC$|_CORRECT$|^_", top.group(1)):
            defined.add(top.group(1))
    safety_text = strip_comments(after)
    spec = proof = 0
    safe_theorems = 0
    for p in phrases(safety_text):
        if p.strip().startswith("needs") or not p.strip(";\n "):
            continue
        for m in re.finditer(r"let\s+(\w+)\s*=\s*(?:time\s+)?prove\s*\(?\s*`(.*?)`", p, re.S):
            if m.group(1).endswith("_SAFE"):
                safe_theorems += 1
                spec += m.group(2).count("\n") + 1
        proof += lines(p)
    proof -= spec
    reused = sorted(n for n in defined if re.search(r"\b" + re.escape(n) + r"\b", safety_text))
    generator = re.compile(r"mk_safety_spec[^;]*?\b\w+_CORRECT\b", re.S)
    spec_generated_live = bool(generator.search(safety_text))
    spec_generated_offline = not spec_generated_live and bool(generator.search(after))
    proof_uses_correct = bool(re.search(r"\b\w+_CORRECT\b", generator.sub("", safety_text)))
    style = ("scaffolded (loop/branch structure by hand)" if any(t in safety_text for t in SCAFFOLD)
             else "automatic (PROVE_SAFETY_SPEC_TAC)" if any(t in safety_text for t in AUTO) else "other")
    return dict(correctness_lines=correctness, safety_spec_lines=spec, safety_proof_lines=proof,
                safety_lines=spec + proof, safe_theorems=safe_theorems,
                spec_generated_from_CORRECT_at_check_time=spec_generated_live,
                spec_generated_from_CORRECT_offline=spec_generated_offline,
                proof_uses_CORRECT_as_lemma=proof_uses_correct,
                safety_reuses_correctness_definitions=len(reused), reused=" ".join(reused[:8]),
                safety_proof_style=style, machine_code_lines_excluded=code)


def main():
    ours = {r["proof_file"]: r for r in csv.DictReader(open(OURS)) if r["proof_file"]}
    rows = []
    for isa in ("arm", "x86"):
        for path in sorted((REPO / isa / "proofs").glob("*.ml")):
            src = path.read_text(errors="ignore")
            if "_SUBROUTINE_SAFE" not in src:
                continue
            a = analyse(path)
            mine = ours.get(path.name) if isa == "arm" else None
            rows.append(dict(isa=isa, proof_file=path.name, annotated_in_bums=bool(mine),
                             bums_clauses=mine["bums_clauses"] if mine else "", **a))
    with open(OUT, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]))
        w.writeheader()
        w.writerows(rows)
    for isa in ("arm", "x86"):
        sel = [r for r in rows if r["isa"] == isa]
        mine = [r for r in sel if r["annotated_in_bums"]]
        for label, group in ((f"{isa} all with _SAFE", sel), (f"{isa} ours", mine)):
            if not group:
                continue
            cs, ss = sum(r["correctness_lines"] for r in group), sum(r["safety_lines"] for r in group)
            live = sum(r["spec_generated_from_CORRECT_at_check_time"] for r in group)
            offline = sum(r["spec_generated_from_CORRECT_offline"] for r in group)
            lemma = sum(r["proof_uses_CORRECT_as_lemma"] for r in group)
            reuse = sum(r["safety_reuses_correctness_definitions"] > 0 for r in group)
            spec = sum(r["safety_spec_lines"] for r in group)
            dep = f"spec from _CORRECT live {live}, offline {offline}; _CORRECT used as lemma {lemma}"
            styles = {}
            for r in group:
                styles[r["safety_proof_style"]] = styles.get(r["safety_proof_style"], 0) + 1
            print(f"{label:16} files={len(group):3} correctness={cs:6} safety={ss:6} (spec {spec}) = {100*ss/(cs+ss):4.1f}% of proof | {dep} | reuses correctness defs {reuse}/{len(group)} | {styles}")
    print(f"wrote {OUT}")


if __name__ == "__main__":
    main()
