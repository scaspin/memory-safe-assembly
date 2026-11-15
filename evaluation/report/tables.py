import csv
import re
import statistics
from collections import Counter, defaultdict

from .results import EXPECTED, seconds
from .suites import BY_NAME, CASE_STUDIES, EVALUATION, LIBRARY_ORDER, SUITES, case_study_of, library_of

NOT_VERIFIED = ["FAIL", "TIMEOUT", "MEMCAP", "ERROR"]
TWIN = re.compile(r"_(padded|zero_extended|from_64)$")
FINDING_KINDS = ["bug", "contract", "api-misuse", "false-positive"]


def function_key(name):
    return TWIN.sub("", name)


def checks_by_library(first):
    grouped = defaultdict(list)
    for suite in SUITES:
        for record in first.get(suite.name, []):
            library = library_of(suite, record["function"], record["file"])
            grouped[(library, suite.isa)].append({**record, "isa": suite.isa})
    return grouped


def order(keys):
    rank = {name: i for i, name in enumerate(LIBRARY_ORDER)}
    return sorted(keys, key=lambda key: (rank.get(key[0], len(rank)), key[1] if len(key) > 1 else ""))


def stats(records):
    times = [seconds(r) for r in records if r["status"] in EXPECTED and seconds(r) is not None]
    if not times:
        return dict(min_s=None, mean_s=None, median_s=None, max_s=None)
    return dict(min_s=min(times), mean_s=statistics.mean(times), median_s=statistics.median(times), max_s=max(times))


def count(records):
    statuses = Counter(r["status"] for r in records)
    functions = defaultdict(list)
    for r in records:
        functions[(function_key(r["function"]), r["file"], r.get("isa"))].append(r["status"])
    verified_functions = sum(any(s == "verified" for s in group) for group in functions.values())
    return {
        "functions": len(functions),
        "verified_functions": verified_functions,
        "checks": len(records),
        "verified": statuses["verified"],
        "rejected": statuses["rejected"],
        **{status: statuses[status] for status in NOT_VERIFIED},
    }


def read_findings():
    path = EVALUATION / "findings.tsv"
    if not path.exists():
        return []
    with open(path, newline="") as handle:
        return list(csv.DictReader(handle, delimiter="\t"))


def finding_counts(findings, library):
    mine = [f for f in findings if f["library"] == library]
    counts = Counter(f["kind"] for f in mine)
    return {f"findings_{kind.replace('-', '_')}": counts[kind] for kind in FINDING_KINDS} | {
        "findings_real": sum(f["real"] == "yes" for f in mine)}


def summarize(first):
    findings = read_findings()
    grouped = checks_by_library(first)
    by_isa = []
    for library, isa in order(grouped):
        records = grouped[(library, isa)]
        by_isa.append({"case_study": case_study_of(library), "library": library, "isa": isa, **count(records), **stats(records)})
    libraries = defaultdict(list)
    isas = defaultdict(list)
    for (library, isa), records in grouped.items():
        libraries[library] += records
        isas[library].append(isa)
    by_library = []
    for (library,) in order([(name,) for name in libraries]):
        records = libraries[library]
        by_library.append({"case_study": case_study_of(library), "library": library, "isa": " + ".join(sorted(isas[library])),
                           **count(records), **finding_counts(findings, library), **stats(records)})
    return by_library, by_isa, findings


def write_csv(rows, path):
    if not rows:
        return
    with open(path, "w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)


def shown(value):
    if value is None:
        return "–"
    if value < 0.01:
        return "<0.01"
    return f"{value:.2f}" if value < 10 else f"{value:.1f}"


def timing(row):
    return " / ".join(shown(row[k]) for k in ("min_s", "mean_s", "median_s", "max_s"))


def failing(row):
    return ", ".join(f"{row[s]} {s}" for s in NOT_VERIFIED if row[s]) or "–"


def markdown(by_library, by_isa, findings):
    lines = []
    for study in CASE_STUDIES:
        rows = [r for r in by_library if r["case_study"] == study]
        if not rows:
            continue
        lines += [f"### {study}", "",
                  "| Library | ISA | Functions verified | Checks (verified / rejected as expected) | Not verified | Real bugs | Contract reliance | False positives | Time min / mean / median / max (s) |",
                  "|---|---|---:|---:|---|---:|---:|---:|---|"]
        for r in rows:
            lines.append(
                f"| {r['library']} | {r['isa']} | {r['verified_functions']}/{r['functions']} "
                f"({100 * r['verified_functions'] / r['functions']:.0f}%) | {r['checks']} ({r['verified']} / {r['rejected']}) | "
                f"{failing(r)} | {r['findings_bug']} | {r['findings_contract']} | {r['findings_false_positive']} | {timing(r)} |")
        functions = sum(r["functions"] for r in rows)
        verified = sum(r["verified_functions"] for r in rows)
        lines += [f"| **total** | | **{verified}/{functions} ({100 * verified / functions:.0f}%)** | "
                  f"**{sum(r['checks'] for r in rows)}** | | **{sum(r['findings_bug'] for r in rows)}** | "
                  f"**{sum(r['findings_contract'] for r in rows)}** | **{sum(r['findings_false_positive'] for r in rows)}** | |", ""]
    lines += ["### Per library and ISA", "",
              "| Case study | Library | ISA | Functions verified | Checks | Not verified | Time min / mean / median / max (s) |",
              "|---|---|---|---:|---:|---|---|"]
    for r in by_isa:
        lines.append(f"| {r['case_study']} | {r['library']} | {r['isa']} | {r['verified_functions']}/{r['functions']} | "
                     f"{r['checks']} | {failing(r)} | {timing(r)} |")
    lines.append("")
    if findings:
        lines += ["### Findings, and why", ""]
        for library in [r["library"] for r in by_library]:
            mine = [f for f in findings if f["library"] == library]
            if not mine:
                continue
            lines += [f"**{library}**", ""]
            for f in sorted(mine, key=lambda f: FINDING_KINDS.index(f["kind"]) if f["kind"] in FINDING_KINDS else 9):
                lines.append(f"- *{f['kind']}*, real: {f['real']} ({f['evidence']}, {f['reachable']}, {f['impact']}) "
                             f"`{f['functions']}` [{f['isa']}]: {f['reason']}")
            lines.append("")
    return "\n".join(lines)


def console(by_library):
    print(f"{'case study':13s}{'library':24s}{'functions':>14s}{'checks':>8s}{'bugs':>6s}{'contr':>6s}{'f.p.':>6s}  median s")
    for r in by_library:
        print(f"{r['case_study']:13s}{r['library']:24s}{r['verified_functions']:6d}/{r['functions']:<5d}"
              f"{100 * r['verified_functions'] / r['functions']:3.0f}%{r['checks']:7d}{r['findings_bug']:6d}"
              f"{r['findings_contract']:6d}{r['findings_false_positive']:6d}  {shown(r['median_s'])}")
    for study in CASE_STUDIES:
        rows = [r for r in by_library if r["case_study"] == study]
        if rows:
            functions = sum(r["functions"] for r in rows)
            verified = sum(r["verified_functions"] for r in rows)
            print(f"{'':13s}{study + ' total':24s}{verified:6d}/{functions:<5d}{100 * verified / functions:3.0f}%")
