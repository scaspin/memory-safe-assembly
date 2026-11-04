import argparse
import csv
import statistics
from collections import defaultdict
from pathlib import Path

import matplotlib
import numpy

matplotlib.use("Agg")
import matplotlib.pyplot as plt

COLUMNS = [
    "function", "file", "status", "seconds", "message",
    "instructions", "loops", "steps", "queries",
    "execution", "loop_resolution", "forking", "smt_execution", "smt_loops",
    "parsing", "serialization",
]

DOMAIN = {
    "corecrypto": "crypto",
    "graviola": "crypto",
    "crypto": "crypto",
    "crypto-x86": "crypto",
    "bignum": "crypto",
    "rav1d": "image/video",
    "rav1d-x86": "image/video",
    "ffmpeg": "image/video",
    "openblas": "math",
    "openblas-x86": "math",
    "candle": "math",
    "compression": "compression",
    "compression-x86": "compression",
}
AUDIO_FILES = {"src/audio.rs", "src/float_dsp.rs", "src/tx_float.rs"}
DOMAIN_COLOR = {
    "crypto": "#1f77b4",
    "image/video": "#d62728",
    "math": "#2ca02c",
    "compression": "#9467bd",
    "audio": "#ff7f0e",
}
PHASES = [
    ("parsing", "parsing and setup", "#8c564b"),
    ("serialization", "serialization", "#c49c94"),
    ("execution", "symbolic execution", "#8c8c8c"),
    ("forking", "path forking", "#c7c7c7"),
    ("loop_resolution", "loop resolution", "#ff7f0e"),
    ("smt_execution", "SMT (execution)", "#1f77b4"),
    ("smt_loops", "SMT (loop resolution)", "#aec7e8"),
]


def read_runs(results):
    runs = defaultdict(lambda: defaultdict(list))
    for tsv in sorted(Path(results).glob("run*/*.tsv")):
        suite = tsv.stem
        with open(tsv, newline="") as handle:
            for row in csv.reader(handle, delimiter="\t"):
                record = dict(zip(COLUMNS, row))
                runs[suite][(record["function"], record["file"])].append(record)
    return runs


def read_sizes(directory):
    sizes = {}
    for tsv in sorted(Path(directory).glob("*.tsv")):
        with open(tsv, newline="") as handle:
            for function, file, size in csv.reader(handle, delimiter="\t"):
                sizes[(tsv.stem, function, file)] = int(size)
    return sizes


def domain_of(suite, file, split_audio):
    if split_audio and suite == "ffmpeg" and file in AUDIO_FILES:
        return "audio"
    return DOMAIN.get(suite, "other")


def summarize(runs, split_audio, sizes):
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
                "library": suite.removesuffix("-x86"),
                "isa": "x86-64" if suite.endswith("-x86") else "aarch64",
                "domain": domain_of(suite, file, split_audio),
                "audio": suite == "ffmpeg" and file in AUDIO_FILES,
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
                label=f"{domain}{' (loops)' if looped else ''}", **style,
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
    figure, axes = plt.subplots(figsize=(7, 4.5))
    draw(axes, points, "instructions", "instructions executed (distinct)")
    axes.set_ylabel("verification time (s, median of runs)")
    figure.tight_layout()
    figure.savefig(path)


def size_comparison(points, path):
    figure, (executed, static) = plt.subplots(1, 2, figsize=(13, 5), sharey=True)
    draw(executed, points, "instructions", "instructions executed (distinct, under the preconditions)")
    draw(static, points, "static", "instructions in the function (statically reachable from its entry)")
    executed.set_ylabel("verification time (s, median of runs)")
    figure.tight_layout()
    figure.savefig(path)


def breakdown(points, path):
    suites = sorted({(p["domain"], p["suite"]) for p in points})
    totals = {
        suite: {key: sum(p[key] for p in points if p["suite"] == suite) for key, _, _ in PHASES}
        for _, suite in suites
    }
    labels = [suite for _, suite in suites]
    figure, axes = plt.subplots(figsize=(7, 0.35 * len(labels) + 1.6))
    left = [0.0] * len(labels)
    for key, name, color in PHASES:
        shares = []
        for library in labels:
            whole = sum(totals[library].values()) or 1.0
            shares.append(100.0 * totals[library][key] / whole)
        axes.barh(labels, shares, left=left, color=color, label=name)
        left = [a + b for a, b in zip(left, shares)]
    for row, library in enumerate(labels):
        axes.text(101, row, f"{sum(totals[library].values()):.0f}s", va="center", fontsize=7)
    axes.set_xlim(0, 112)
    axes.set_xlabel("share of verification time (%)")
    axes.invert_yaxis()
    axes.legend(fontsize=7, ncol=3, frameon=False, loc="lower center", bbox_to_anchor=(0.5, 1.0))
    figure.tight_layout()
    figure.savefig(path)


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
    labels = [f"{p['suite']}\n{p['function']}" for p in chosen]
    figure, axes = plt.subplots(figsize=(9.5, 0.5 * len(labels) + 1.8))
    left = [0.0] * len(labels)
    for key, name, color in PHASES:
        shares = []
        for p in chosen:
            whole = sum(p[phase] for phase, _, _ in PHASES) or 1.0
            shares.append(100.0 * p[key] / whole)
        axes.barh(labels, shares, left=left, color=color, label=name)
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


def table(points, runs):
    print(f"{'library':14s}{'isa':8s}{'verified':>9s}{'checked':>9s}{'loops':>7s}{'median s':>10s}")
    by = defaultdict(list)
    for p in points:
        by[(p["library"], p["isa"])].append(p)
    for suite, functions in sorted(runs.items()):
        library, isa = suite.removesuffix("-x86"), "x86-64" if suite.endswith("-x86") else "aarch64"
        chosen = by.get((library, isa), [])
        first = [records[0] for records in functions.values()]
        median = statistics.median(p["median"] for p in chosen) if chosen else 0.0
        print(f"{library:14s}{isa:8s}{len(chosen):9d}{len(first):9d}"
              f"{sum(p['loops'] > 0 for p in chosen):7d}{median:10.2f}")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("results", nargs="?", default=Path(__file__).parent / "results")
    parser.add_argument("--out", default=None)
    parser.add_argument("--split-audio", action="store_true")
    parser.add_argument("--sizes", default=None)
    arguments = parser.parse_args()
    out = Path(arguments.out or arguments.results)
    out.mkdir(parents=True, exist_ok=True)
    runs = read_runs(arguments.results)
    sizes = read_sizes(arguments.sizes or Path(arguments.results) / "sizes")
    points = summarize(runs, arguments.split_audio, sizes)
    scatter(points, out / "time-vs-size.pdf")
    if sizes:
        size_comparison(points, out / "size-comparison.pdf")
    breakdown(points, out / "time-breakdown.pdf")
    for rank in RANKS:
        representative_breakdown(points, out / f"time-breakdown-{rank}.pdf", rank)
    with open(out / "points.tsv", "w") as handle:
        keys = list(points[0]) if points else []
        handle.write("\t".join(keys) + "\n")
        for p in points:
            handle.write("\t".join(str(p[k]) for k in keys) + "\n")
    table(points, runs)


if __name__ == "__main__":
    main()
