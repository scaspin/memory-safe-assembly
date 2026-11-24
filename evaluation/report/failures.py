import csv
import re
from collections import Counter

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt

from .results import EXPECTED
from .suites import CASE_STUDIES, GRID, INK, INK_2, LIBRARY_ORDER, ROOT, SUITES, library_of

REASONS = [
    ("timeout", "time limit", "#8a8984", lambda status, message: status == "TIMEOUT"),
    ("memory", "memory limit", "#b9b6b0", lambda status, message: status == "MEMCAP"),
    ("unproven access", "access not provably in bounds", "#d1495b",
     lambda status, message: "not provably within" in message),
    ("unknown region", "pointer with no known region", "#edae49",
     lambda status, message: "no known region" in message or "no region declared" in message),
    ("path explosion", "path explosion (branch depth or step budget)", "#00798c",
     lambda status, message: "branch depth exceeded" in message or "exploration limit reached" in message),
    ("calling convention", "return / callee-saved contract", "#30638e",
     lambda status, message: "not restored on return" in message or "return value" in message
     or "callee-saved" in message),
    ("vector gather", "gather with unbounded lanes", "#66a182",
     lambda status, message: "lanes have no known bound" in message),
    ("unsupported", "unsupported instruction or feature", "#5a33b0",
     lambda status, message: "not yet implemented" in message or "unsupported" in message
     or "no translation" in message or "panicked" in message),
    ("infeasible", "path with no model", "#e46aa6", lambda status, message: "path has no model" in message),
    ("other", "other", "#3d3b38", lambda status, message: True),
]
REASON_LABEL = {key: label for key, label, _, _ in REASONS}
REASON_COLOR = {key: color for key, _, color, _ in REASONS}


def first_failure(message):
    return re.split(r";\s+(?=line \d+)", message, maxsplit=1)[0].strip()


def classify(status, message):
    first = first_failure(message)
    return next(key for key, _, _, matches in REASONS if matches(status, first))


def curated_diagnoses():
    diagnoses = {}
    path = ROOT / "compression-playground" / "unverified.tsv"
    if path.exists():
        with open(path, newline="") as handle:
            for row in csv.DictReader(handle, delimiter="\t"):
                diagnoses[(row["function"], row["arch"])] = (row["class"], row["reason"])
    return diagnoses


def failures(first):
    diagnoses = curated_diagnoses()
    rows = []
    for suite in SUITES:
        for record in first.get(suite.name, []):
            if record["status"] in EXPECTED:
                continue
            message = record.get("message", "")
            curated = diagnoses.get((record["function"], suite.arch), ("", ""))
            rows.append({
                "case_study": suite.case_study,
                "suite": suite.name,
                "library": library_of(suite, record["function"], record["file"]),
                "isa": suite.isa,
                "function": record["function"],
                "file": record["file"],
                "status": record["status"],
                "seconds": record["seconds"],
                "reason": classify(record["status"], message),
                "first_failure": first_failure(message)[:400],
                "diagnosis_class": curated[0],
                "diagnosis": curated[1],
            })
    return rows


def write_failures(rows, path):
    with open(path, "w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]) if rows else ["suite"])
        writer.writeheader()
        writer.writerows(rows)


def label(row):
    return f"{row['library']} ({row['isa']})"


def reason_counts(rows):
    counts = {}
    for row in rows:
        counts.setdefault(label(row), Counter())[row["reason"]] += 1
    return counts


def ordered_labels(rows):
    rank = {name: i for i, name in enumerate(LIBRARY_ORDER)}
    seen = {(r["library"], r["isa"]): label(r) for r in rows}
    return [seen[key] for key in sorted(seen, key=lambda k: (rank.get(k[0], 99), k[1]))]


def reasons_figure(rows, out):
    counts = reason_counts(rows)
    suites = ordered_labels(rows)
    if not suites:
        return None
    plt.rcParams.update({"font.size": 8, "axes.edgecolor": INK_2, "axes.labelcolor": INK, "xtick.color": INK_2, "ytick.color": INK_2})
    figure, axis = plt.subplots(figsize=(7.5, 0.32 * len(suites) + 1.6), constrained_layout=True)
    left = [0] * len(suites)
    for key, label, color, _ in REASONS:
        widths = [counts[s][key] for s in suites]
        if not any(widths):
            continue
        axis.barh(range(len(suites)), widths, left=left, color=color, label=label, edgecolor="white", linewidth=0.6)
        left = [a + b for a, b in zip(left, widths)]
    axis.set_yticks(range(len(suites)))
    axis.set_yticklabels(suites)
    for row, total in enumerate(left):
        axis.text(total + 0.5, row, str(total), va="center", fontsize=7, color=INK_2)
    axis.invert_yaxis()
    axis.set_xlabel("checks not verified, by first failure")
    axis.grid(True, axis="x", color=GRID, linewidth=0.6)
    axis.set_axisbelow(True)
    for side in ("top", "right"):
        axis.spines[side].set_visible(False)
    axis.legend(fontsize=7, ncol=2, frameon=False, loc="lower right")
    path = out / "failure-reasons.pdf"
    figure.savefig(path)
    figure.savefig(path.with_suffix(".png"), dpi=200)
    plt.close(figure)
    return path


def markdown(rows):
    counts = reason_counts(rows)
    used = [key for key, _, _, _ in REASONS if any(c[key] for c in counts.values())]
    lines = ["| Case study | Library (ISA) | " + " | ".join(REASON_LABEL[k] for k in used) + " | total |",
             "|---|---|" + "---:|" * (len(used) + 1)]
    study_of = {label(r): r["case_study"] for r in rows}
    for name in ordered_labels(rows):
        c = counts[name]
        lines.append(f"| {study_of[name]} | {name} | " + " | ".join(str(c[k] or "") for k in used)
                     + f" | {sum(c.values())} |")
    findings = [r for r in rows if r["diagnosis_class"] == "real-finding"]
    if findings:
        lines += ["", "Diagnosed as real findings (hand-written diagnosis):", ""]
        lines += [f"- `{r['function']}` ({label(r)}): {r['diagnosis']}" for r in findings]
    return "\n".join(lines)
