import collections
import csv
import re
import statistics

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt

from .suites import DOMAINS, GRID, INK, INK_2, ROOT, SUITES



def balanced(text, start, open_char, close_char):
    depth = 0
    in_string = False
    i = start
    while i < len(text):
        c = text[i]
        if in_string:
            if c == "\\":
                i += 2
                continue
            if c == '"':
                in_string = False
        elif c == '"':
            in_string = True
        elif c == open_char:
            depth += 1
        elif c == close_char:
            depth -= 1
            if depth == 0:
                return i
        i += 1
    return -1


def split_top(text, sep=","):
    parts, depth, current, in_string = [], 0, [], False
    for c in text:
        if in_string:
            current.append(c)
            if c == '"':
                in_string = False
            continue
        if c == '"':
            in_string = True
        elif c in "([{":
            depth += 1
        elif c in ")]}":
            depth -= 1
        if c == sep and depth == 0:
            parts.append("".join(current).strip())
            current = []
        else:
            current.append(c)
    if "".join(current).strip():
        parts.append("".join(current).strip())
    return parts


def annotations(source):
    text = source.read_text()
    found = collections.defaultdict(list)
    for match in re.finditer(r"check_mem_safe\s*\(", text):
        open_at = match.end() - 1
        close_at = balanced(text, open_at, "(", ")")
        if close_at < 0:
            continue
        body = text[open_at + 1:close_at]
        name = re.search(r"\bfn\s+([A-Za-z_][A-Za-z0-9_]*|\$[a-z_]+)", text[close_at:close_at + 2000])
        args = split_top(body)
        asm = args[0].strip().strip('"') if args else ""
        array = next((a for a in reversed(args) if a.startswith("[")), None)
        conditions = split_top(array[1:-1]) if array else []
        if name:
            found[name.group(1)].append((asm, conditions))
    return found


def classify(condition):
    if "||" in condition:
        return "disjunction"
    if re.search(r"\.iter\(\)|\.\.\]|\[\s*\.\.", condition):
        return "element range (all elements)"
    if condition.lstrip().startswith("*") or re.match(r"^\s*\(\s*\*", condition):
        return "pointed-to content"
    if re.search(r"\w\s*\[[^\]]+\]", condition.split("==")[0].split("<")[0].split(">")[0]):
        if re.search(r"as_(mut_)?ptr\(\)", condition):
            return "pointer-table entry"
        return "element value"
    if "%" in condition:
        return "divisibility / alignment"
    if ".len()" in condition:
        return "length equality" if re.search(r"(?<![<>!=])==(?!=)", condition) else "length bound"
    if re.search(r"\b[a-z_]\w*\.(\d+|[a-z_]\w*)\b(?!\()", condition):
        return "struct field"
    equality = re.search(r"(?<![<>!=])==(?!=)", condition)
    if equality:
        return "scalar equality"
    upper = re.match(r"^(.*?)(<=|<)(.*)$", condition)
    lower = re.match(r"^(.*?)(>=|>)(.*)$", condition)
    side = upper.group(3) if upper else (lower.group(1) if lower else "")
    constant = re.fullmatch(r"\s*(\d+)\s*", side)
    if (upper or (lower and not upper)) and constant and int(constant.group(1)) >= 1 << 20:
        return "overflow cap (>= 2^20)"
    if upper:
        return "scalar upper bound"
    if lower:
        return "scalar lower bound"
    return "other"


KINDS = ["length equality", "length bound", "scalar lower bound", "scalar upper bound",
         "overflow cap (>= 2^20)", "scalar equality", "divisibility / alignment", "struct field",
         "pointer-table entry", "element value", "element range (all elements)", "pointed-to content",
         "disjunction", "other"]

KIND_COLORS = {
    "length equality": "#2a78d6", "length bound": "#8fb8ea", "scalar lower bound": "#1baf7a",
    "scalar upper bound": "#8ed8bd", "overflow cap (>= 2^20)": "#b9b6b0", "scalar equality": "#eda100",
    "divisibility / alignment": "#f5cf73", "struct field": "#eb6834", "pointer-table entry": "#f3a37f",
    "element value": "#5a33b0", "element range (all elements)": "#b7a2e8", "pointed-to content": "#e46aa6",
    "disjunction": "#3d3b38", "other": "#8a8984",
}


def pick(candidates, suite):
    if len(candidates) == 1:
        return candidates[0]
    preferred = [c for c in candidates if ("x86" in c[0].lower()) == (suite.isa == "x86-64")]
    return (preferred or candidates)[0]


def conditions_of(candidate):
    conditions = []
    for condition in candidate[1]:
        if "&&" in condition and "||" not in condition:
            conditions.extend(part.strip() for part in condition.strip("() ").split("&&"))
        else:
            conditions.append(condition)
    return conditions


def collect(first):
    cache, rows = {}, []
    for suite in SUITES:
        for record in first.get(suite.name, []):
            path = ROOT / suite.crate / record["file"]
            if path not in cache:
                cache[path] = annotations(path) if path.exists() else {}
            candidates = cache[path].get(record["function"], [])
            if not candidates:
                continue
            conditions = conditions_of(pick(candidates, suite))
            rows.append({
                "suite": suite,
                "function": record["function"],
                "count": len(conditions),
                "kinds": collections.Counter(classify(c) for c in conditions),
            })
    return rows


def kind_table(rows):
    table = {}
    for row in rows:
        entry = table.setdefault(row["suite"].name, {"suite": row["suite"], "annotations": 0, "without": 0, "kinds": collections.Counter()})
        entry["annotations"] += 1
        entry["without"] += row["count"] == 0
        entry["kinds"].update(row["kinds"])
    return [table[s.name] for s in SUITES if s.name in table]


def write_kinds(table, path):
    kinds = [k for k in KINDS if any(entry["kinds"][k] for entry in table)]
    with open(path, "w", newline="") as handle:
        writer = csv.writer(handle)
        writer.writerow(["suite", "library", "isa", "annotations", "without preconditions", *kinds, "total"])
        for entry in table:
            suite = entry["suite"]
            writer.writerow([suite.name, suite.library, suite.isa, entry["annotations"], entry["without"],
                             *[entry["kinds"][k] for k in kinds], sum(entry["kinds"].values())])


def style(axis):
    axis.grid(True, axis="x", color=GRID, linewidth=0.6)
    axis.set_axisbelow(True)
    for side in ("top", "right"):
        axis.spines[side].set_visible(False)


def kinds_figure(table, out):
    plt.rcParams.update({"font.size": 8, "axes.edgecolor": INK_2, "axes.labelcolor": INK, "xtick.color": INK_2, "ytick.color": INK_2})
    figure, axis = plt.subplots(figsize=(8, 0.32 * len(table) + 2.0), constrained_layout=True)
    left = [0.0] * len(table)
    for kind in KINDS:
        shares = [100 * entry["kinds"][kind] / (sum(entry["kinds"].values()) or 1) for entry in table]
        if not any(shares):
            continue
        axis.barh(range(len(table)), shares, left=left, color=KIND_COLORS[kind], label=kind, edgecolor="white", linewidth=0.5)
        left = [a + b for a, b in zip(left, shares)]
    axis.set_yticks(range(len(table)))
    axis.set_yticklabels([entry["suite"].display for entry in table])
    for row, entry in enumerate(table):
        total = sum(entry["kinds"].values())
        axis.text(101, row, f"{total} in {entry['annotations']} fns", va="center", fontsize=6.5, color=INK_2)
    axis.set_xlim(0, 122)
    axis.set_xticks(range(0, 101, 20))
    axis.invert_yaxis()
    axis.set_xlabel("share of precondition clauses (%)")
    style(axis)
    axis.legend(fontsize=6.5, ncol=4, frameon=False, loc="lower center", bbox_to_anchor=(0.45, 1.0))
    path = out / "precondition-kinds.pdf"
    figure.savefig(path)
    figure.savefig(path.with_suffix(".png"), dpi=200)
    plt.close(figure)
    return path


def counts_figure(rows, out):
    plt.rcParams.update({"font.size": 8, "axes.edgecolor": INK_2, "axes.labelcolor": INK, "xtick.color": INK_2, "ytick.color": INK_2})
    figure, axis = plt.subplots(figsize=(7, 3), constrained_layout=True)
    most = max((r["count"] for r in rows), default=0)
    edges = [x - 0.5 for x in range(0, most + 2)]
    layers, colors, labels = [], [], []
    for key, name, color, _ in DOMAINS:
        counts = [r["count"] for r in rows if r["suite"].domain == key]
        if counts:
            layers.append(counts)
            colors.append(color)
            labels.append(f"{name} (n={len(counts)}, median {statistics.median(counts):g})")
    axis.hist(layers, bins=edges, stacked=True, color=colors, label=labels, edgecolor="white", linewidth=0.6)
    axis.set_xlabel("precondition clauses per annotated function")
    axis.set_ylabel("functions")
    axis.grid(True, axis="y", color=GRID, linewidth=0.6)
    axis.set_axisbelow(True)
    for side in ("top", "right"):
        axis.spines[side].set_visible(False)
    axis.legend(fontsize=7, frameon=False)
    path = out / "precondition-counts.pdf"
    figure.savefig(path)
    figure.savefig(path.with_suffix(".png"), dpi=200)
    plt.close(figure)
    return path
