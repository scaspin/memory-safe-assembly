import csv
import statistics
import sys
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker
import numpy

from annotation_vs_time import DOMAINS, GRID, INK, INK_2, REFERENCE, secsep_reference

HERE = Path(__file__).resolve().parent


def seconds_label(value, _=None):
    if value >= 100:
        return f"{value:.0f} s"
    if value >= 1:
        return f"{value:.3g} s"
    return f"{value * 1000:.3g} ms"


def stacked(axis, points, stack_order, edges, placed, legend=True):
    layers = [[placed(float(p["seconds"])) for p in points if p["domain"] == key] for key, _, _, _ in stack_order]
    labels = []
    for key, name, _, _ in stack_order:
        times = [float(p["seconds"]) for p in points if p["domain"] == key]
        labels.append(f"{name} (n={len(times)}, median {seconds_label(statistics.median(times))})")
    axis.hist(layers, bins=edges, stacked=True, color=[c for _, _, c, _ in stack_order], edgecolor="white", linewidth=0.8, label=labels)
    axis.grid(True, axis="y", color=GRID, linewidth=0.6)
    axis.set_axisbelow(True)
    for side in ("top", "right"):
        axis.spines[side].set_visible(False)
    if legend:
        axis.legend(loc="upper right", frameon=False, fontsize=7)
    return layers


def median_line(axis, middle, offset):
    axis.axvline(middle, color=INK, linewidth=0.8, linestyle=(0, (3, 2)), zorder=4)
    axis.annotate(f"CLAMS median {seconds_label(middle)}", (middle, axis.get_ylim()[1] * 0.97), xytext=(offset, 0),
                  textcoords="offset points", va="top", fontsize=7, color=INK)


def secsep_strip(strip, theirs, placed):
    strip.scatter([placed(t) for t in theirs], [0] * len(theirs), marker="x", s=18, linewidth=0.9, color=REFERENCE)
    strip.set_yticks([])
    strip.set_ylim(-1, 1)
    strip.set_title(f"SecSep / Octal (n={len(theirs)}, median {seconds_label(statistics.median(theirs))})", fontsize=7, color=INK_2, loc="left", pad=2)
    for side in ("top", "right", "left"):
        strip.spines[side].set_visible(False)


def figure_with_strip(height=3.3):
    return plt.subplots(2, 1, figsize=(7.0, height), sharex=True, constrained_layout=True, gridspec_kw=dict(height_ratios=[1, 6]))


def log_version(points, theirs, stack_order, everything):
    floor = 0.001
    placed = lambda value: max(value, floor)
    edges = numpy.logspace(-3, 4, 7 * 4 + 1)
    figure, (strip, axis) = figure_with_strip()
    stacked(axis, points, stack_order, edges, placed)
    median_line(axis, statistics.median(everything), 4)
    axis.set_xscale("log")
    axis.xaxis.set_major_formatter(matplotlib.ticker.FuncFormatter(seconds_label))
    axis.set_xlim(edges[0], edges[-1])
    axis.set_xlabel("Checking time per function (log)")
    axis.set_ylabel(f"CLAMS functions (n={len(points)})")
    secsep_strip(strip, theirs, placed)
    return figure


def overflow_version(points, theirs, stack_order, everything, cutoff=20.0, width=0.5):
    overflow = cutoff + 3
    placed = lambda value: overflow if value > cutoff else value
    edges = numpy.append(numpy.arange(0, cutoff + width / 2, width), [overflow - width / 2, overflow + width / 2])
    figure, (strip, axis) = figure_with_strip()
    layers = stacked(axis, points, stack_order, edges, placed)
    median_line(axis, statistics.median(everything), 14)
    ticks = list(numpy.arange(0, cutoff + 1, 5)) + [overflow]
    axis.set_xticks(ticks)
    axis.set_xticklabels([f"{t:g} s" for t in ticks[:-1]] + [f"> {cutoff:g} s"])
    axis.xaxis.set_minor_locator(matplotlib.ticker.MultipleLocator(width))
    beyond = sum(t > cutoff for t in everything)
    height = sum(sum(t == overflow for t in layer) for layer in layers)
    axis.axvspan(cutoff + width, overflow - width, color=GRID, alpha=0.5, linewidth=0, zorder=0)
    axis.annotate(f"{beyond} ({100 * beyond / len(everything):.0f}%)", (overflow, height), xytext=(0, 3), textcoords="offset points",
                  ha="center", va="bottom", fontsize=7, color=INK_2, annotation_clip=False)
    axis.set_xlim(0, edges[-1])
    axis.set_xlabel("Checking time per function")
    axis.set_ylabel(f"CLAMS functions (n={len(points)})")
    secsep_strip(strip, theirs, placed)
    strip.annotate(f"{sum(t > cutoff for t in theirs)} of {len(theirs)}", (overflow, 0), xytext=(0, 6), textcoords="offset points",
                   ha="center", va="bottom", fontsize=7, color=INK_2)
    return figure


def full_version(points, theirs, stack_order, everything, width=25, zoom=5.0, zoom_width=0.1):
    top = max(everything + theirs)
    edges = numpy.arange(0, top + width, width)
    placed = lambda value: value
    figure, (strip, axis) = figure_with_strip(3.8)
    stacked(axis, points, stack_order, edges, placed, legend=False)
    axis.set_xlim(0, edges[-1])
    axis.xaxis.set_major_locator(matplotlib.ticker.MultipleLocator(200))
    axis.xaxis.set_minor_locator(matplotlib.ticker.MultipleLocator(width * 2))
    axis.xaxis.set_major_formatter(matplotlib.ticker.FuncFormatter(lambda v, _: f"{v:g} s"))
    axis.set_xlabel(f"Checking time per function ({width:g} s bins)")
    axis.set_ylabel(f"CLAMS functions (n={len(points)})")
    first = sum(t < width for t in everything)
    axis.annotate(f"{first} ({100 * first / len(everything):.0f}%) under {width:g} s", (width, first), xytext=(4, -2),
                  textcoords="offset points", va="top", fontsize=7, color=INK)
    inset = axis.inset_axes([0.38, 0.22, 0.6, 0.7])
    within = [p for p in points if float(p["seconds"]) <= zoom]
    stacked(inset, within, stack_order, numpy.arange(0, zoom + zoom_width / 2, zoom_width), placed, legend=False)
    inset.set_xlim(0, zoom)
    inset.xaxis.set_major_formatter(matplotlib.ticker.FuncFormatter(lambda v, _: f"{v:g} s"))
    inset.tick_params(labelsize=7)
    middle = statistics.median(everything)
    inset.axvline(middle, color=INK, linewidth=0.8, linestyle=(0, (3, 2)), zorder=4)
    inset.annotate(f"CLAMS median {seconds_label(middle)}", (middle, inset.get_ylim()[1] * 0.97), xytext=(4, 0),
                   textcoords="offset points", va="top", fontsize=7, color=INK)
    inset.set_title(f"0–{zoom:g} s in {zoom_width * 1000:g} ms bins: {len(within)} functions ({100 * len(within) / len(everything):.0f}%)",
                    fontsize=7, color=INK_2, loc="left", pad=2)
    handles, labels = axis.get_legend_handles_labels()
    figure.legend(handles, labels, loc="outside lower center", ncol=2, frameon=False, fontsize=7)
    secsep_strip(strip, theirs, placed)
    return figure


def main():
    results = Path(sys.argv[1]) if len(sys.argv) > 1 else HERE / "published" / "rework-5f5018a4"
    points = list(csv.DictReader(open(results / "annotation-vs-time.csv")))
    theirs = [r["seconds"] for r in secsep_reference()]
    everything = [float(p["seconds"]) for p in points]
    stack_order = sorted(DOMAINS, key=lambda d: -sum(p["domain"] == d[0] for p in points))
    plt.rcParams.update({"font.size": 8, "axes.edgecolor": INK_2, "axes.labelcolor": INK, "xtick.color": INK_2, "ytick.color": INK_2})
    for name, build in (("log", log_version), ("linear-overflow", overflow_version), ("linear-full", full_version)):
        figure = build(points, theirs, stack_order, everything)
        for suffix in ("pdf", "png"):
            figure.savefig(results / f"time-distribution-{name}.{suffix}", dpi=200)
        plt.close(figure)
        print(results / f"time-distribution-{name}.pdf")


if __name__ == "__main__":
    main()
