import csv
import random
import re
import statistics

import matplotlib
import matplotlib.ticker

matplotlib.use("Agg")
import matplotlib.pyplot as plt

from .suites import DOMAINS, GRID, INK, INK_2, REFERENCE, ROOT, SUITES

TOKEN = re.compile(r"[A-Za-z_]\w*|\d+|->|==|<=|>=|!=|&&|\|\||\S")
CHECKER_OPTION = re.compile(r"(?:(?:red_zone|abi|symbol)\s*=(?!=)|rejects$)")
ATTRIBUTE = re.compile(r"#\[(?:cfg_attr\(\s*target_arch\s*=\s*\"(\w+)\"\s*,\s*)?(?:bums|bums_macros)::check_mem_safe\(")


def balanced(text, start):
    depth = 0
    for i in range(start, len(text)):
        c = text[i]
        if c in "([{":
            depth += 1
        elif c in ")]}":
            depth -= 1
            if depth == 0:
                return i
    return len(text) - 1


def split_top(text):
    parts, depth, cur = [], 0, ""
    for c in text:
        if c in "([{":
            depth += 1
        elif c in ")]}":
            depth -= 1
        if c == "," and depth == 0:
            parts.append(cur.strip())
            cur = ""
        else:
            cur += c
    if cur.strip():
        parts.append(cur.strip())
    return parts


def annotations(crate, arch):
    found = {}
    for path in sorted((ROOT / crate / "src").rglob("*.rs")):
        text = path.read_text(errors="ignore")
        for m in ATTRIBUTE.finditer(text):
            if m.group(1) and m.group(1) != arch:
                continue
            open_paren = m.end() - 1
            close = balanced(text, open_paren)
            args = split_top(text[open_paren + 1:close])
            sig = re.search(r"\bfn\s+(\w+)\s*\((.*?)\)\s*(->\s*[^;{]+)?[;{]", text[close:], re.S)
            if not sig:
                continue
            exprs = [e for e in args[1:] if not CHECKER_OPTION.match(e.strip())]
            constraints = sum(len(split_top(e.strip()[1:-1])) for e in exprs if e.strip().startswith("["))
            bindings = sum(1 for e in exprs if not e.strip().startswith("["))
            tokens = len(TOKEN.findall(",".join(exprs))) + len(TOKEN.findall(sig.group(0)))
            found[sig.group(1)] = dict(clauses=bindings + constraints, tokens=tokens, file=str(path.relative_to(ROOT)))
    return found


def verified(results, suite):
    path = results / f"{suite}.tsv"
    if not path.exists():
        path = results / f"{suite}.tsv.partial"
    rows = {}
    if path.exists():
        for line in path.read_text().splitlines():
            parts = line.split("\t")
            if len(parts) >= 16 and parts[2] == "verified":
                rows[parts[0]] = (sum(float(x) for x in parts[9:16]), int(parts[6]))
    return rows


def secsep_reference():
    data = ROOT / "secsep-eval" / "paper-data" / "data"
    if not (data / "per_function.csv").exists():
        return []
    loops = {r["function"]: int(r["backward_branches"]) for r in csv.DictReader(open(data / "secsep_loops.csv"))}
    return [dict(clauses=float(r["secsep_clauses"]), seconds=float(r["secsep_cpu_s"]), loops=loops[r["function"]])
            for r in csv.DictReader(open(data / "per_function.csv"))]


def render(results, out):
    points, unmatched = [], []
    for suite in SUITES:
        ann = annotations(suite.crate, suite.arch)
        for function, (seconds, loops) in verified(results, suite.name).items():
            a = ann.get(function)
            if a is None:
                unmatched.append(f"{suite.name}/{function}")
                continue
            points.append(dict(suite=suite.display, domain=suite.domain, function=function, clauses=a["clauses"], tokens=a["tokens"], seconds=seconds, loops=loops, file=a["file"]))
    if not points:
        return None, points
    with open(out / "annotation-vs-time.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(points[0]))
        w.writeheader()
        w.writerows(points)

    secsep = secsep_reference()
    plt.rcParams.update({"font.size": 8, "axes.edgecolor": INK_2, "axes.labelcolor": INK, "xtick.color": INK_2, "ytick.color": INK_2})
    figure, axes = plt.subplots(1, 2, figsize=(7.0, 2.9), sharey=True, sharex=True, constrained_layout=True)
    floor = 0.001
    for axis, has_loops, title in ((axes[0], False, "Loop-free functions"), (axes[1], True, "Functions with loops")):
        theirs = [r for r in secsep if (r["loops"] > 0) == has_loops]
        ours = [p for p in points if (p["loops"] > 0) == has_loops]
        if theirs:
            axis.scatter([r["clauses"] for r in theirs], [r["seconds"] for r in theirs], marker="x", s=16,
                         linewidth=0.9, color=REFERENCE, zorder=2, label="SecSep / Octal")
        for key, name, color, marker in DOMAINS:
            mine = [p for p in ours if p["domain"] == key]
            jitter = random.Random(7)
            axis.scatter([p["clauses"] + jitter.uniform(-0.3, 0.3) for p in mine], [max(p["seconds"], floor) for p in mine], marker=marker, s=12,
                         color=color, edgecolor="white", linewidth=0.4, alpha=0.85, zorder=3, label=name)
        axis.set_title(f"{title}  (CLAMS n={len(ours)}, SecSep n={len(theirs)})", fontsize=8, color=INK)
        axis.set_yscale("log")
        axis.set_xlim(0, max([p["clauses"] for p in points] + [r["clauses"] for r in secsep]) + 1)
        axis.xaxis.set_major_locator(matplotlib.ticker.MultipleLocator(5))
        axis.xaxis.set_minor_locator(matplotlib.ticker.MultipleLocator(1))
        axis.set_xlabel("Annotation clauses per function")
        axis.grid(True, which="major", color=GRID, linewidth=0.6)
        axis.set_axisbelow(True)
        for side in ("top", "right"):
            axis.spines[side].set_visible(False)
    axes[0].set_ylabel("Checking time (s, log)")
    handles, labels = axes[1].get_legend_handles_labels()
    figure.legend(handles, labels, loc="outside upper center", ncol=5, frameon=False, fontsize=7, handletextpad=0.3, columnspacing=1.0)
    for suffix in ("pdf", "png"):
        figure.savefig(out / f"annotation-vs-time.{suffix}", dpi=200)

    times = [p["seconds"] for p in points]
    print(f"annotation vs time: {len(points)} verified functions; {len(unmatched)} without a parsed annotation")
    print(f"median time {statistics.median(times):.2f} s, median clauses {statistics.median(p['clauses'] for p in points)}, median tokens {statistics.median(p['tokens'] for p in points)}")
    for key, name, _, _ in DOMAINS:
        mine = [p for p in points if p["domain"] == key]
        if mine:
            print(f"  {name:14} n={len(mine):5}  loops {sum(p['loops'] > 0 for p in mine):5}  clauses median {statistics.median(p['clauses'] for p in mine):4}  time median {statistics.median(p['seconds'] for p in mine):7.2f} s")
    if unmatched:
        print("unmatched (first 10):", ", ".join(unmatched[:10]))
    plt.close(figure)
    return out / "annotation-vs-time.pdf", points
