import argparse
import csv
import statistics
from collections import defaultdict
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt

COLUMNS = [
    "function", "file", "status", "seconds", "message",
    "instructions", "loops", "steps", "queries",
    "execution", "loop_resolution", "forking", "smt_execution", "smt_loops",
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


def domain_of(suite, file, split_audio):
    if split_audio and suite == "ffmpeg" and file in AUDIO_FILES:
        return "audio"
    return DOMAIN.get(suite, "other")


def summarize(runs, split_audio):
    points = []
    for suite, functions in runs.items():
        for (function, file), records in functions.items():
            verified = [r for r in records if r["status"] == "verified" and r.get("instructions")]
            if not verified or len(verified) != len(records):
                continue
            seconds = [sum(float(r[key]) for key, _, _ in PHASES) for r in verified]
            phases = {
                key: statistics.median(float(r[key]) for r in verified) for key, _, _ in PHASES
            }
            points.append({
                "suite": suite,
                "library": suite.removesuffix("-x86"),
                "isa": "x86-64" if suite.endswith("-x86") else "aarch64",
                "domain": domain_of(suite, file, split_audio),
                "audio": suite == "ffmpeg" and file in AUDIO_FILES,
                "function": function,
                "instructions": int(verified[0]["instructions"]),
                "loops": int(verified[0]["loops"]),
                "median": statistics.median(seconds),
                "low": min(seconds),
                "high": max(seconds),
                "runs": len(seconds),
                **phases,
            })
    return points


def scatter(points, path):
    figure, axes = plt.subplots(figsize=(7, 4.5))
    for domain, color in DOMAIN_COLOR.items():
        for looped, marker in ((False, "o"), (True, "x")):
            chosen = [p for p in points if p["domain"] == domain and (p["loops"] > 0) == looped]
            if not chosen:
                continue
            xs = [p["instructions"] for p in chosen]
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
    axes.set_xscale("log")
    axes.set_yscale("log")
    axes.set_xlabel("instructions reached")
    axes.set_ylabel("verification time (s, median of runs)")
    axes.grid(True, which="major", alpha=0.3)
    axes.legend(fontsize=7, ncol=2, frameon=False)
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
    arguments = parser.parse_args()
    out = Path(arguments.out or arguments.results)
    out.mkdir(parents=True, exist_ok=True)
    runs = read_runs(arguments.results)
    points = summarize(runs, arguments.split_audio)
    scatter(points, out / "time-vs-size.pdf")
    breakdown(points, out / "time-breakdown.pdf")
    with open(out / "points.tsv", "w") as handle:
        keys = list(points[0]) if points else []
        handle.write("\t".join(keys) + "\n")
        for p in points:
            handle.write("\t".join(str(p[k]) for k in keys) + "\n")
    table(points, runs)


if __name__ == "__main__":
    main()
