import csv
import random
import statistics
import sys
from pathlib import Path

import matplotlib
import matplotlib.ticker

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D

HERE = Path(__file__).resolve().parent
DOMAINS = [
    ("crypto", "Cryptography", "#2a78d6", "o"),
    ("media", "Media codecs", "#eb6834", "s"),
    ("compression", "Compression", "#1baf7a", "^"),
    ("numeric", "Numeric / ML", "#eda100", "D"),
]
STYLE = {key: (color, marker) for key, _, color, marker in DOMAINS}
INK = "#0b0b0b"
INK_2 = "#52514e"
GRID = "#e4e3df"
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
        Line2D([], [], linestyle="", marker="o", markersize=5, color=INK_2, markeredgecolor="white", markeredgewidth=0.4, label="bums wrapper"),
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


def added_figure(rows, out):
    rows = [r for r in rows if r["size"] == "min"]
    jitter = jitters(rows)
    figure, axis = plt.subplots(figsize=(3.5, 2.9), constrained_layout=True)
    for r in rows:
        color, marker = STYLE[r["domain"]]
        x = r["clauses"] + jitter[r["function"]]
        axis.scatter([x], [r["added_ns"]], marker=marker, s=14, color=color, edgecolor="white", linewidth=0.4, zorder=3)
        if r["structs"]:
            axis.scatter([x], [r["added_ns"]], marker="o", s=55, facecolor="none", edgecolor=INK, linewidth=0.7, zorder=4)
    axis.axhline(0, color=INK_2, linewidth=0.6, zorder=1)
    axis.set_title(f"Cost bums adds per call, assembly stubbed (n={len(rows)})", fontsize=8, color=INK)
    axis.set_xlabel("Annotation clauses per function")
    axis.set_ylabel("Added time per call (ns)")
    axis.set_xlim(0, max(r["clauses"] for r in rows) + 1)
    style_axis(axis)
    figure.legend(handles=legend_handles()[:4] + legend_handles()[6:], loc="outside upper center", ncol=3, frameon=False, fontsize=6, handletextpad=0.3, columnspacing=0.8)
    for suffix in ("pdf", "png"):
        figure.savefig(out / f"wrapper-overhead-added.{suffix}", dpi=200)


def main():
    path = Path(sys.argv[1]) if len(sys.argv) > 1 else HERE / "results" / "overhead.tsv"
    isolated_path = Path(sys.argv[2]) if len(sys.argv) > 2 else path.parent / "isolated.tsv"
    rows = load(path)
    plt.rcParams.update({"font.size": 8, "axes.edgecolor": INK_2, "axes.labelcolor": INK, "xtick.color": INK_2, "ytick.color": INK_2})
    runtime_figure(rows, path.parent)
    if isolated_path.exists():
        isolated = load(isolated_path)
        added_figure(isolated, path.parent)
        once = [r for r in isolated if r["size"] == "min"]
        for label, group in (("no struct", [r for r in once if not r["structs"]]), ("struct", [r for r in once if r["structs"]])):
            added = sorted(r["added_ns"] for r in group)
            print(f"isolated {label}: n={len(group)} added ns median {statistics.median(added):.2f}, range {added[0]:.2f}..{added[-1]:.2f}")
    for size, _ in SIZES:
        mine = [r for r in rows if r["size"] == size]
        plain = [r["added_ns"] for r in mine if not r["structs"]]
        structs = [r["added_ns"] for r in mine if r["structs"]]
        line = f"{size}: n={len(mine)}  median overhead {statistics.median(r['paired_ratio'] - 1 for r in mine) * 100:+.2f}%"
        if plain:
            line += f"  added ns median {statistics.median(plain):.1f} (no struct)"
        if structs:
            line += f", {statistics.median(structs):.1f} (struct)"
        print(line)
    print(path.parent / "wrapper-overhead.pdf")


if __name__ == "__main__":
    main()
