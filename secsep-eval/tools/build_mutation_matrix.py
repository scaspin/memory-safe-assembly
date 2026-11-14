import csv
import json
import re
from collections import Counter, defaultdict
from pathlib import Path

EVAL = Path(__file__).resolve().parent.parent
MUT = EVAL / "mutation"
DATA = EVAL / "paper-data" / "data"
PHASE_FILE = {"Single Type Infer": "single_infer", "Valid Region Infer": "range_infer", "Taint Type Infer": "taint_infer", "Type Checker": "check"}
PHASES = r"\((Single Type Infer|Valid Region Infer|Taint Type Infer|Change Infer|Type Checker)\) result: (\w+)"


def bums(m):
    path = MUT / m["id"] / "bums.tsv"
    if not path.exists():
        return "not run", ""
    for line in path.read_text().splitlines():
        parts = line.split("\t")
        if parts[0] == m["function"]:
            if parts[2] == "verified":
                return "accepted", ""
            if parts[2] == "FAIL":
                return "rejected", parts[4][:160] if len(parts) > 4 else ""
            return parts[2], ""
    return "not run", ""


def octal(m):
    log_path = MUT / m["id"] / "octal.log"
    if not log_path.exists():
        return "not run", ""
    log = re.sub(r"\x1b\[[0-9;]*m", "", log_path.read_text(errors="ignore"))
    results = re.findall(PHASES, log)
    failed = [p for p, r in results if r == "error"]
    if not failed:
        return ("accepted", "") if results else ("not run", "")
    phase = failed[0]
    detail = ""
    out = MUT / m["id"] / "octal-out" / f"{m['bench']}.{PHASE_FILE.get(phase, '')}.log"
    if out.exists():
        for line in out.read_text(errors="ignore").splitlines():
            if "Fatal error" in line or "Failed" in line:
                detail = line.strip()
    short = re.search(r"\[[^\]]+\] ([^\"]+)", detail)
    return ("rejected by type checker" if phase == "Type Checker" else f"inference exception ({phase})"), (short.group(1) if short else detail)[:120]


def dynamic():
    path = EVAL / "dynamic" / "results" / "summary.tsv"
    found = defaultdict(dict)
    if not path.exists():
        return found
    sys_path = str(EVAL / "tools")
    import sys
    sys.path.insert(0, sys_path)
    from build_dynamic import classify
    for r in csv.DictReader(open(path), delimiter="\t"):
        found[r["variant"]][(r["tool"], r["mode"])] = classify(r)
    return found


def symex():
    path = EVAL / "symex" / "results.tsv"
    found = defaultdict(dict)
    if path.exists():
        for r in csv.DictReader(open(path), delimiter="\t"):
            found[(r["variant"], r["function"])][r["tool"]] = r
    return found


def symex_class(r):
    if r is None:
        return "not run", ""
    v = r["verdict"]
    if v == "violation":
        detail = r["detail"]
        where = re.search(r'"instruction": "(0x[0-9a-f]+)"', detail)
        return "rejected", (where.group(1) if where else detail.split(";")[0])
    if v.startswith("no violation (all"):
        return "accepted (all paths, bounded)", ""
    if v.startswith("no violation found"):
        return "accepted (incomplete)", r["detail"][:80]
    return v, r["detail"][:80]


def main():
    manifest = json.loads((MUT / "manifest.json").read_text())
    dyn, sym = dynamic(), symex()
    rows = []
    for m in manifest:
        row = dict(mutant=m["id"], function=m["function"], fault=m["what"], fault_class=m.get("fault_class", ""), safe=m.get("safe", False))
        row["bums"], row["bums_detail"] = bums(m)
        row["octal"], row["octal_detail"] = octal(m)
        for tool in ("valgrind", "asan"):
            for mode in ("harness", "shipped"):
                row[f"{tool}_{mode}"] = dyn.get(m["id"], {}).get((tool, mode), "not run")
        for tool in ("angr", "binsec"):
            row[tool], row[f"{tool}_detail"] = symex_class(sym.get((m["id"], m["function"]), {}).get(tool))
        rows.append(row)
    with open(DATA / "mutation_all_tools.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]))
        w.writeheader()
        w.writerows(rows)
    originals = []
    for (variant, function), tools in sorted(sym.items()):
        if variant.endswith("-original"):
            for tool, r in tools.items():
                originals.append(dict(variant=variant, function=function, tool=tool, verdict=r["verdict"], seconds=r["seconds"], detail=r["detail"][:200]))
    if originals:
        with open(DATA / "symex_originals.csv", "w", newline="") as f:
            w = csv.DictWriter(f, fieldnames=list(originals[0]))
            w.writeheader()
            w.writerows(originals)
    tools = ["bums", "octal", "valgrind_harness", "valgrind_shipped", "asan_harness", "asan_shipped", "angr", "binsec"]
    unsafe = [r for r in rows if not r["safe"]]
    controls = [r for r in rows if r["safe"]]
    def caught(value):
        return value.startswith("rejected") or value.startswith("inference exception") or value == "detected"
    print(f"{'mutant':16} " + " ".join(f"{t[:12]:12}" for t in tools))
    for r in rows:
        print(f"{r['mutant']:16} " + " ".join(f"{r[t][:12]:12}" for t in tools))
    print("\ncaught on unsafe mutants:", {t: f"{sum(caught(r[t]) for r in unsafe)}/{len(unsafe)}" for t in tools})
    print("false alarms on controls:", {t: f"{sum(caught(r[t]) for r in controls)}/{len(controls)}" for t in tools})
    print("by fault class (bums):", Counter((r["fault_class"], r["bums"]) for r in unsafe))


if __name__ == "__main__":
    main()
