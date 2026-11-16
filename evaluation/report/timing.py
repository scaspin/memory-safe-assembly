import statistics
from pathlib import Path

import matplotlib
import numpy

matplotlib.use("Agg")
import matplotlib.pyplot as plt

from .results import read_runs, read_sizes
from .suites import BY_NAME, DOMAIN_COLOR, DOMAINS, display

DOMAIN_NAME = {key: name for key, name, _, _ in DOMAINS}
PHASES = [
    ("parsing", "parsing and setup", "#3d3b38"),
    ("execution", "symbolic execution", "#a3a09a"),
    ("forking", "path forking", "#d3d0ca"),
    ("loop_resolution", "loop resolution", "#6e6b66"),
    ("serialization", "serialization", "#e46aa6"),
    ("smt_execution", "SMT (execution)", "#5a33b0"),
    ("smt_loops", "SMT (loop resolution)", "#b7a2e8"),
]


def domain_of(suite):
    return BY_NAME[suite].domain if suite in BY_NAME else "other"


def summarize(runs, sizes):
    points = []
    for suite, functions in runs.items():
        for (function, file), records in functions.items():
            verified = [r for r in records if r["status"] == "verified" and r.get("instructions")]
            if not verified or len(verified) != len(records):
                continue
            seconds = [sum(float(r.get(key) or 0) for key, _, _ in PHASES) for r in verified]
            phases = {
                key: statistics.median(float(r.get(key) or 0) for r in verified)
                for key, _, _ in PHASES
            }
            points.append({
                "suite": suite,
                "library": BY_NAME[suite].library if suite in BY_NAME else suite,
                "isa": BY_NAME[suite].isa if suite in BY_NAME else "",
                "domain": domain_of(suite),
                "function": function,
                "instructions": int(verified[0]["instructions"]),
                "static": sizes.get((suite, function, file), 0),
                "loops": int(verified[0]["loops"]),
                "queries": round(statistics.median(int(r.get("queries") or 0) for r in verified)),
                "median": statistics.median(seconds),
                "low": min(seconds),
                "high": max(seconds),
                "runs": len(seconds),
                **phases,
            })
    return points


def draw(axes, points, size, label):
    points = [p for p in points if p[size] > 0]
    for domain, color in DOMAIN_COLOR.items():
        for looped, marker in ((False, "o"), (True, "x")):
            chosen = [p for p in points if p["domain"] == domain and (p["loops"] > 0) == looped]
            if not chosen:
                continue
            xs = [p[size] for p in chosen]
            ys = [p["median"] for p in chosen]
            errors = [
                [p["median"] - p["low"] for p in chosen],
                [p["high"] - p["median"] for p in chosen],
            ]
            axes.errorbar(xs, ys, yerr=errors, fmt="none", ecolor=color, alpha=0.25, lw=0.6)
            style = {"color": color} if looped else {"facecolors": "none", "edgecolors": color}
            axes.scatter(
                xs, ys, marker=marker, s=14, linewidths=0.8, alpha=0.8,
                label=f"{DOMAIN_NAME.get(domain, domain)}{' (loops)' if looped else ''}", **style,
            )
    for looped, style in ((False, "-"), (True, "--")):
        chosen = [p for p in points if (p["loops"] > 0) == looped and p["median"] > 0]
        if len(chosen) < 2:
            continue
        xs = numpy.log10([p[size] for p in chosen])
        ys = numpy.log10([p["median"] for p in chosen])
        slope, intercept = numpy.polyfit(xs, ys, 1)
        fitted = slope * xs + intercept
        r_squared = 1 - ((ys - fitted) ** 2).sum() / ((ys - ys.mean()) ** 2).sum()
        span = numpy.linspace(xs.min(), xs.max(), 50)
        axes.plot(
            10 ** span, 10 ** (slope * span + intercept), style, color="black", lw=1.2,
            label=f"{'loops' if looped else 'no loops'}: t ∝ n^{slope:.2f} (R²={r_squared:.2f}, n={len(chosen)})",
        )
    axes.set_xscale("log")
    axes.set_yscale("log")
    axes.set_xlabel(label)
    axes.grid(True, which="major", alpha=0.3)
    axes.legend(fontsize=6, ncol=2, frameon=False, loc="upper left")


def scatter(points, path):
    figure, (straight, looping) = plt.subplots(1, 2, figsize=(12, 4.5), sharey=True)
    without = [p for p in points if p["loops"] == 0]
    with_loops = [p for p in points if p["loops"] > 0]
    draw(straight, without, "instructions", "instructions executed (distinct)")
    draw(looping, with_loops, "instructions", "instructions executed (distinct)")
    straight.set_title(f"Functions without loops (n={len(without)})", fontsize=9)
    looping.set_title(f"Functions with loops (n={len(with_loops)})", fontsize=9)
    straight.set_ylabel("verification time (s, median of runs)")
    figure.tight_layout()
    figure.savefig(path)
    figure.savefig(Path(path).with_suffix(".png"), dpi=300)


def size_comparison(points, path):
    figure, (executed, static) = plt.subplots(1, 2, figsize=(13, 5), sharey=True)
    draw(executed, points, "instructions", "instructions executed (distinct, under the preconditions)")
    draw(static, points, "static", "instructions in the function (statically reachable from its entry)")
    executed.set_ylabel("verification time (s, median of runs)")
    figure.tight_layout()
    figure.savefig(path)
    figure.savefig(Path(path).with_suffix(".png"), dpi=300)


def breakdown(points, path):
    suites = sorted({(p["domain"], p["suite"]) for p in points})
    totals = {
        suite: {key: sum(p[key] for p in points if p["suite"] == suite) for key, _, _ in PHASES}
        for _, suite in suites
    }
    labels = [suite for _, suite in suites]
    figure, axes = plt.subplots(figsize=(7, 0.35 * len(labels) + 1.6))
    axes.set_yticks(range(len(labels)))
    left = [0.0] * len(labels)
    for key, name, color in PHASES:
        shares = []
        for library in labels:
            whole = sum(totals[library].values()) or 1.0
            shares.append(100.0 * totals[library][key] / whole)
        axes.barh(range(len(labels)), shares, left=left, color=color, label=name, edgecolor="white", linewidth=0.6)
        left = [a + b for a, b in zip(left, shares)]
    axes.set_yticklabels([display(l) for l in labels])
    for row, library in enumerate(labels):
        axes.text(101, row, f"{sum(totals[library].values()):.0f}s", va="center", fontsize=7)
    axes.set_xlim(0, 112)
    axes.set_xlabel("share of verification time (%)")
    axes.invert_yaxis()
    axes.legend(fontsize=7, ncol=3, frameon=False, loc="lower center", bbox_to_anchor=(0.5, 1.0))
    figure.tight_layout()
    figure.savefig(path)
    figure.savefig(Path(path).with_suffix(".png"), dpi=300)


RANKS = {
    "fastest": lambda ordered: ordered[0],
    "median": lambda ordered: ordered[(len(ordered) - 1) // 2],
    "slowest": lambda ordered: ordered[-1],
}


def representative_breakdown(points, path, rank):
    suites = sorted({(p["domain"], p["suite"]) for p in points})
    chosen = []
    for _, suite in suites:
        ordered = sorted((p for p in points if p["suite"] == suite), key=lambda p: p["median"])
        chosen.append(RANKS[rank](ordered))
    labels = [f"{display(p['suite'])}\n{p['function']}" for p in chosen]
    figure, axes = plt.subplots(figsize=(9.5, 0.5 * len(labels) + 1.8))
    left = [0.0] * len(labels)
    for key, name, color in PHASES:
        shares = []
        for p in chosen:
            whole = sum(p[phase] for phase, _, _ in PHASES) or 1.0
            shares.append(100.0 * p[key] / whole)
        axes.barh(labels, shares, left=left, color=color, label=name, edgecolor="white", linewidth=0.6)
        left = [a + b for a, b in zip(left, shares)]
    for row, p in enumerate(chosen):
        seconds = p["median"]
        shown = f"{seconds * 1000:.0f}ms" if seconds < 1 else f"{seconds:.1f}s"
        details = f"{shown}\n{p['instructions']:,} instrs executed, {p['queries']:,} SMT queries"
        axes.text(101, row, details, va="center", fontsize=6.5, linespacing=1.3)
    axes.set_xlim(0, 135)
    axes.set_xticks(range(0, 101, 20))
    axes.spines["right"].set_visible(False)
    axes.spines["top"].set_visible(False)
    axes.set_xlabel(f"share of verification time (%), {rank} verified function per suite")
    axes.tick_params(axis="y", labelsize=6)
    axes.invert_yaxis()
    axes.legend(fontsize=7, ncol=3, frameon=False, loc="lower center", bbox_to_anchor=(0.5, 1.0))
    figure.tight_layout()
    figure.savefig(path)
    figure.savefig(Path(path).with_suffix(".png"), dpi=300)


def render(results, out):
    runs = read_runs(results)
    sizes = read_sizes(Path(results) / "sizes")
    points = summarize(runs, sizes)
    if not points:
        return [], points
    paths = [out / "time-vs-size.pdf", out / "time-breakdown.pdf"]
    scatter(points, paths[0])
    breakdown(points, paths[1])
    if sizes:
        paths.append(out / "size-comparison.pdf")
        size_comparison(points, paths[-1])
    for rank in RANKS:
        paths.append(out / f"time-breakdown-{rank}.pdf")
        representative_breakdown(points, paths[-1], rank)
    with open(out / "points.tsv", "w") as handle:
        keys = list(points[0])
        handle.write("\t".join(keys) + "\n")
        for p in points:
            handle.write("\t".join(str(p[k]) for k in keys) + "\n")
    plt.close("all")
    return paths, points
