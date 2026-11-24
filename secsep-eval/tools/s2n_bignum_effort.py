import csv
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
PROOFS = REPO / "s2n-bignum" / "arm" / "proofs"
PLAYGROUND = REPO / "bignum-playground" / "src"
SWEEP = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parents[1] / "bums-bignum-2026-11-05.tsv"
OUT = Path(__file__).resolve().parent.parent / "paper-data" / "data" / "s2n_bignum_vs_bums.csv"
TOKEN = re.compile(r"[A-Za-z_]\w*|\d+|->|==|<=|>=|\S")


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


def proof_effort(path):
    raw = path.read_text(errors="ignore")
    text = strip_comments(raw)
    lines = text.split("\n")
    kept, in_code = [], False
    for line in lines:
        if not in_code and re.search(r"define_assert_from_elf|define_word_list|define_trimmed", line):
            in_code = True
        if in_code:
            if line.strip().startswith("];;"):
                in_code = False
            continue
        kept.append(line)
    body = "\n".join(kept)
    statement_lines = main_statement_lines = 0
    theorems = main_theorems = 0
    for m in re.finditer(r"let\s+(\w+)\s*=\s*(?:time\s+)?prove\s*\(?\s*`(.*?)`", body, re.S):
        span = m.group(2).count("\n") + 1
        statement_lines += span
        theorems += 1
        if m.group(1).endswith("_CORRECT"):
            main_statement_lines += span
            main_theorems += 1
    nonblank = sum(1 for line in kept if line.strip())
    return dict(
        proof_file_lines=len(raw.split("\n")),
        code_listing_excluded=len(lines) - len(kept),
        spec_lines_main=main_statement_lines,
        main_theorems=main_theorems,
        lemma_and_spec_lines=statement_lines,
        theorems=theorems,
        tactic_lines=max(nonblank - statement_lines, 0),
        needs=len(re.findall(r'^\s*needs\s+"', raw, re.M)),
    )


def bums_annotations():
    found = []
    for path in sorted(PLAYGROUND.rglob("*.rs")):
        src = path.read_text()
        for m in re.finditer(r"#\[bums_macros::check_mem_safe\((.*?)\)\]\s*\n\s*((?:pub\s+)?(?:unsafe\s+)?fn\s+(\w+)\s*\(.*?\)\s*(?:->\s*[\w\[\]; ]+)?;)", src, re.S):
            args, sig, fn = m.group(1), m.group(2), m.group(3)
            depth, parts, cur = 0, [], ""
            for ch in args:
                if ch in "([":
                    depth += 1
                if ch in ")]":
                    depth -= 1
                if ch == "," and depth == 0:
                    parts.append(cur.strip())
                    cur = ""
                else:
                    cur += ch
            parts.append(cur.strip())
            asm = parts[0].strip('"')
            exprs = parts[1:]
            constraints = sum(len([c for c in e.strip("[]").split(",") if c.strip()]) for e in exprs if e.startswith("["))
            bindings = sum(1 for e in exprs if not e.startswith("["))
            found.append(dict(function=fn, asm=asm, module=path.stem, bums_clauses=bindings + constraints,
                              bums_preconditions=constraints, bums_tokens=len(TOKEN.findall(",".join(exprs))) + len(TOKEN.findall(sig))))
    return found


def sweep():
    rows = {}
    for line in SWEEP.read_text().splitlines():
        p = line.split("\t")
        if len(p) >= 4 and p[2] != "status":
            rows[p[0]] = (p[2], float(p[3]))
    return rows


def main():
    verdicts = sweep()
    rows = []
    for a in bums_annotations():
        proof = PROOFS / (Path(a["asm"]).stem + ".ml")
        effort = proof_effort(proof) if proof.exists() else {}
        status, seconds = verdicts.get(a["function"], ("not in sweep", ""))
        rows.append(dict(**a, proof_file=proof.name if proof.exists() else "", **effort,
                         bums_status=status, bums_wall_s=seconds))
    fields = list(rows[0].keys())
    for r in rows:
        for f in fields:
            r.setdefault(f, "")
        for k in r:
            if k not in fields:
                fields.append(k)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    with open(OUT, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fields)
        w.writeheader()
        w.writerows(rows)
    matched = [r for r in rows if r["proof_file"]]
    print(f"{len(rows)} annotations, {len(matched)} with a proof file")
    tot = lambda k: sum(int(r[k]) for r in matched if r[k] != "")
    print(f"BUMS clauses {tot('bums_clauses')}, tokens {tot('bums_tokens')}")
    print(f"s2n main spec lines {tot('spec_lines_main')}, all statement lines {tot('lemma_and_spec_lines')}, tactic lines {tot('tactic_lines')}")
    missing = [r["asm"] for r in rows if not r["proof_file"]]
    if missing:
        print("no proof file:", ", ".join(missing))


if __name__ == "__main__":
    main()
