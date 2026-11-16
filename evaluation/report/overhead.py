import csv
import random
import statistics
from collections import defaultdict

import matplotlib
import matplotlib.ticker
import numpy

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D

from .suites import DOMAINS, GRID, INK, INK_2

STYLE = {key: (color, marker) for key, _, color, marker in DOMAINS}
SIZES = [("min", "Smallest valid input"), ("mid", "Typical input (~1 KiB)"), ("max", "Large input (16-64 KiB)")]


def load(path):
    rows = list(csv.DictReader(open(path), delimiter="\t"))
    for r in rows:
        for key in ("clauses", "preconditions", "structs", "input_bytes", "iterations"):
            r[key] = int(r[key])
        for key in ("raw_ns", "annotated_ns", "paired_ratio"):
            r[key] = float(r[key])
        r["added_ns"] = r["raw_ns"] * (r["paired_ratio"] - 1.0)
    return rows


def jitters(rows):
    rng = random.Random(7)
    return {f: rng.uniform(-0.3, 0.3) for f in sorted({r["function"] for r in rows})}


def style_axis(axis):
    axis.xaxis.set_major_locator(matplotlib.ticker.MultipleLocator(5))
    axis.xaxis.set_minor_locator(matplotlib.ticker.MultipleLocator(1))
    axis.grid(True, which="major", color=GRID, linewidth=0.6)
    axis.set_axisbelow(True)
    for side in ("top", "right"):
        axis.spines[side].set_visible(False)


def legend_handles():
    handles = [Line2D([], [], linestyle="", marker=m, markersize=5, color=c, markeredgecolor="white", markeredgewidth=0.4, label=n)
               for _, n, c, m in DOMAINS]
    handles += [
        Line2D([], [], linestyle="", marker="o", markersize=5, markerfacecolor="white", markeredgecolor=INK_2, markeredgewidth=0.9, label='raw extern "C"'),
        Line2D([], [], linestyle="", marker="o", markersize=5, color=INK_2, markeredgecolor="white", markeredgewidth=0.4, label="CLAMS wrapper"),
        Line2D([], [], linestyle="", marker="o", markersize=8, markerfacecolor="none", markeredgecolor=INK, markeredgewidth=0.9, label="struct argument"),
    ]
    return handles


def runtime_figure(rows, out):
    jitter = jitters(rows)
    figure, axes = plt.subplots(1, 3, figsize=(7.0, 2.7), sharey=True, sharex=True, constrained_layout=True)
    for axis, (size, title) in zip(axes, SIZES):
        mine = [r for r in rows if r["size"] == size]
        for r in mine:
            color, marker = STYLE[r["domain"]]
            x = r["clauses"] + jitter[r["function"]]
            axis.plot([x, x], [r["raw_ns"], r["annotated_ns"]], color=color, linewidth=0.7, alpha=0.7, zorder=2)
            axis.scatter([x], [r["raw_ns"]], marker=marker, s=14, facecolor="white", edgecolor=color, linewidth=0.8, zorder=3)
            axis.scatter([x], [r["annotated_ns"]], marker=marker, s=14, color=color, edgecolor="white", linewidth=0.4, zorder=4)
            if r["structs"]:
                axis.scatter([x, x], [r["raw_ns"], r["annotated_ns"]], marker="o", s=55, facecolor="none", edgecolor=INK, linewidth=0.7, zorder=5)
        overheads = [r["paired_ratio"] - 1 for r in mine]
        median = statistics.median(overheads) * 100 if overheads else 0
        axis.set_title(f"{title}\n(n={len(mine)}, median overhead {median:+.1f}%)", fontsize=8, color=INK)
        axis.set_yscale("log")
        axis.set_xlabel("Annotation clauses per function")
        style_axis(axis)
    axes[0].set_ylabel("Time per call (ns, log)")
    axes[0].set_xlim(0, max(r["clauses"] for r in rows) + 1)
    figure.legend(handles=legend_handles(), loc="outside upper center", ncol=4, frameon=False, fontsize=7, handletextpad=0.3, columnspacing=1.0)
    for suffix in ("pdf", "png"):
        figure.savefig(out / f"wrapper-overhead.{suffix}", dpi=200)


def smallest_inputs(path):
    rows = list(csv.DictReader(open(path), delimiter="\t"))
    functions = defaultdict(list)
    for r in rows:
        if r["status"] == "ok":
            functions[(r["suite"], r["function"], r["file"])].append(r)
    chosen = []
    for key in sorted(functions):
        r = min(functions[key], key=lambda r: (int(r["input_bytes"]), int(r["sample"])))
        raw = float(r["raw_ns"])
        chosen.append({"domain": r["domain"], "function": r["function"], "clauses": int(r["clauses"]),
                       "structs": int(r.get("structs") or 0),
                       "raw_ns": raw, "added_ns": raw * (float(r["paired_ratio"]) - 1.0),
                       "added_percent": 100.0 * (float(r["paired_ratio"]) - 1.0)})
    return chosen


ADDED_METRICS = {
    "added_ns": ("added time per call (ns)", "Time CLAMS adds per call", "{:.2f} ns", "wrapper-overhead-added"),
    "added_percent": ("added time per call (% of the raw call)", "CLAMS overhead per call", "{:.1f}%", "wrapper-overhead-percent"),
}


def theil_sen(xs, ys):
    xs, ys = numpy.asarray(xs, dtype=float), numpy.asarray(ys, dtype=float)
    first, second = numpy.triu_indices(len(xs), k=1)
    run = xs[second] - xs[first]
    distinct = run != 0
    slope = float(numpy.median((ys[second] - ys[first])[distinct] / run[distinct]))
    return slope, float(numpy.median(ys - slope * xs))


def added_figure(rows, out, metric="added_ns"):
    label, heading, shown, stem = ADDED_METRICS[metric]
    rng = random.Random(7)
    plt.rcParams.update({"font.size": 7})
    figure, axis = plt.subplots(figsize=(3.4, 2.7), constrained_layout=True)
    for key, name, color, marker in DOMAINS:
        mine = [r for r in rows if r["domain"] == key]
        if not mine:
            continue
        xs = [r["clauses"] + rng.uniform(-0.3, 0.3) for r in mine]
        axis.scatter(xs, [r[metric] for r in mine], marker=marker, s=7, color=color, alpha=0.45,
                     linewidth=0, zorder=3, label=f"{name} ({len(mine)})")
        ringed = [(x, r[metric]) for x, r in zip(xs, mine) if r["structs"]]
        if ringed:
            axis.scatter(*zip(*ringed), marker="o", s=22, facecolor="none", edgecolor=INK, linewidth=0.5, zorder=5)
    axis.scatter([], [], marker="o", s=22, facecolor="none", edgecolor=INK, linewidth=0.5,
                 label=f"struct argument ({sum(r['structs'] > 0 for r in rows)})")
    slope, intercept = theil_sen([r["clauses"] for r in rows], [r[metric] for r in rows])
    unit = shown.format(slope).split()[-1] if " " in shown.format(slope) else "%"
    span = numpy.linspace(0, max(r["clauses"] for r in rows), 200)
    axis.plot(span, numpy.maximum(0.0, intercept + slope * span), color=INK, linewidth=1.2, zorder=4,
              label=f"fit: {slope:.2f} {unit} per clause")
    middle = statistics.median(r[metric] for r in rows)
    axis.axhline(0, color=INK_2, linewidth=0.6, zorder=1)
    axis.set_yscale("symlog", linthresh=1, linscale=0.8)
    axis.set_ylim(min(r[metric] for r in rows) * 1.5, max(r[metric] for r in rows) * 1.5)
    axis.set_xlabel("annotation clauses per function")
    axis.set_ylabel(label)
    axis.set_xlim(-1, max(r["clauses"] for r in rows) + 1)
    style_axis(axis)
    axis.xaxis.set_major_locator(matplotlib.ticker.MultipleLocator(10))
    axis.xaxis.set_minor_locator(matplotlib.ticker.MultipleLocator(5))
    axis.set_title(f"{heading} (n={len(rows)}, median {shown.format(middle)})", fontsize=7, color=INK)
    axis.legend(loc="lower right", fontsize=5.5, frameon=True, framealpha=0.85, edgecolor=GRID, markerscale=1.6,
                handletextpad=0.3, labelspacing=0.25, borderpad=0.4)
    for suffix in ("pdf", "png"):
        figure.savefig(out / f"{stem}.{suffix}", dpi=300)
    plt.close(figure)
    plt.rcParams.update({"font.size": 8})
    print(f"  Theil-Sen fit, floored at zero: max(0, {intercept:+.3f} + {slope:.3f} per clause), zero below {-intercept / slope:.1f} clauses")
    within = sorted(r[metric] for r in rows)
    print(f"overhead, all verified functions (smallest input): n={len(rows)} {metric} median {middle:.2f}, "
          f"p10 {within[len(within) // 10]:.2f}, p90 {within[9 * len(within) // 10]:.2f}")
    return out / f"{stem}.pdf"


def render(directory, out, everything=None):
    path = directory / "overhead.tsv"
    isolated_path = directory / "isolated.tsv"
    if not path.exists():
        return []
    rows = load(path)
    plt.rcParams.update({"font.size": 8, "axes.edgecolor": INK_2, "axes.labelcolor": INK, "xtick.color": INK_2, "ytick.color": INK_2})
    runtime_figure(rows, out)
    paths = [out / "wrapper-overhead.pdf"]
    if everything and (everything / "overhead.tsv").exists():
        smallest = smallest_inputs(everything / "overhead.tsv")
        paths += [added_figure(smallest, out, metric) for metric in ADDED_METRICS]
    if isolated_path.exists():
        isolated = load(isolated_path)
        once = [r for r in isolated if r["size"] == "min"]
        for label, group in (("no struct", [r for r in once if not r["structs"]]), ("struct", [r for r in once if r["structs"]])):
            added = sorted(r["added_ns"] for r in group)
            print(f"overhead, isolated {label}: n={len(group)} added ns median {statistics.median(added):.2f}, range {added[0]:.2f}..{added[-1]:.2f}")
    for size, _ in SIZES:
        mine = [r for r in rows if r["size"] == size]
        plain = [r["added_ns"] for r in mine if not r["structs"]]
        structs = [r["added_ns"] for r in mine if r["structs"]]
        line = f"overhead, {size} input: n={len(mine)}  median overhead {statistics.median(r['paired_ratio'] - 1 for r in mine) * 100:+.2f}%"
        if plain:
            line += f"  added ns median {statistics.median(plain):.1f} (no struct)"
        if structs:
            line += f", {statistics.median(structs):.1f} (struct)"
        print(line)
    plt.close("all")
    return paths
