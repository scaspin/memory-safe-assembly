import csv
from collections import defaultdict
from pathlib import Path

EVAL = Path(__file__).resolve().parent.parent
SUMMARY = EVAL / "dynamic" / "results" / "summary.tsv"
DATA = EVAL / "paper-data" / "data"
TOOLS = {"valgrind": "Valgrind", "asan": "ASan"}
MODES = {"harness": "exact-size unit and API tests", "shipped": "SecSep's own driver"}


BOUNDS = ("buffer-overflow", "negative-size-param", "use-after", "invalid-pointer-pair")
SIDE_EFFECT = ("SEGV", "stack-overflow", "attempting free", "double-free", "bad-free")


def classify(r):
    report = r["first_report"]
    if r["verdict"] == "timeout":
        return "timeout"
    if r["tool"] == "valgrind":
        if "Invalid read" in report or "Invalid write" in report:
            return "detected"
        return "crashed" if r["verdict"] in ("crashed", "detected") else r["verdict"]
    if any(k in report for k in BOUNDS):
        return "detected"
    if any(k in report for k in SIDE_EFFECT) or r["verdict"] in ("crashed", "detected"):
        return "side effect or crash"
    return r["verdict"]


def main():
    runs = list(csv.DictReader(open(SUMMARY), delimiter="\t"))
    for r in runs:
        r["verdict"] = classify(r)
    mutation = {r["mutant"]: r for r in csv.DictReader(open(DATA / "mutation.csv"))}
    by_variant = defaultdict(dict)
    for r in runs:
        by_variant[r["variant"]][(r["tool"], r["mode"])] = r

    rows = []
    for mid, m in mutation.items():
        row = dict(mutant=mid, function=m["function"], fault=m["fault"],
                   bums=m["bums_class"], secsep=m["octal_class"])
        for tool in TOOLS:
            for mode in MODES:
                r = by_variant[mid].get((tool, mode))
                row[f"{tool}_{mode}"] = r["verdict"] if r else "not run"
                row[f"{tool}_{mode}_report"] = r["first_report"] if r else ""
        rows.append(row)
    with open(DATA / "dynamic_tools.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]))
        w.writeheader()
        w.writerows(rows)

    false_positives = defaultdict(list)
    for variant, results in by_variant.items():
        if variant.endswith("-original"):
            for (tool, mode), r in results.items():
                if r["verdict"] != "clean":
                    false_positives[tool].append(f"{variant}/{mode}: {r['verdict']}")

    summary = []
    for tool, label in TOOLS.items():
        counts = {mode: sum(r[f"{tool}_{mode}"] == "detected" for r in rows) for mode in MODES}
        crashes = {mode: sum(r[f"{tool}_{mode}"] in ("crashed", "side effect or crash", "timeout") for r in rows) for mode in MODES}
        best = sum(any(r[f"{tool}_{mode}"] == "detected" for mode in MODES) for r in rows)
        note = (f"exact-size tests {counts['harness']}/12, SecSep driver {counts['shipped']}/12"
                f"{'' if not any(crashes.values()) else '; side effect, crash or timeout without a bounds report: exact-size ' + str(crashes['harness']) + ', driver ' + str(crashes['shipped'])}"
                f"; false positives on originals: {len(false_positives[tool])}")
        summary.append(dict(tool=label, detected=best, mutants=len(rows), note=note,
                            false_positives="; ".join(false_positives[tool])))
    with open(DATA / "dynamic_tools_summary.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(summary[0]))
        w.writeheader()
        w.writerows(summary)
    for s in summary:
        print(s)
    for r in rows:
        print(f"{r['mutant']:15} bums={r['bums'][:8]:8} secsep={r['secsep'][:10]:10} "
              + " ".join(f"{t}/{m}={r[f'{t}_{m}']}" for t in TOOLS for m in MODES))


if __name__ == "__main__":
    main()
