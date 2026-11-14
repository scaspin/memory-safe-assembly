import csv
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D

EVAL = Path(__file__).resolve().parent.parent
DATA = EVAL / "paper-data" / "data"
FIGS = EVAL / "paper-data" / "figures"

BUMS, SECSEP = "#2a78d6", "#eb6834"
INK, INK_2, INK_3, GRID = "#141413", "#55544f", "#8a8983", "#e6e5e0"
SECSEP_RAMP = ["#f6c3a6", "#f0976a", "#eb6834", "#b84a1d"]
SINGLE, DOUBLE = 3.4, 7.0

plt.rcParams.update({
    "font.family": "sans-serif",
    "font.sans-serif": ["Helvetica", "Arial", "DejaVu Sans"],
    "font.size": 8, "axes.titlesize": 8, "axes.labelsize": 8,
    "xtick.labelsize": 7, "ytick.labelsize": 7, "legend.fontsize": 7,
    "axes.edgecolor": INK_3, "axes.labelcolor": INK_2, "text.color": INK,
    "xtick.color": INK_2, "ytick.color": INK_2, "axes.linewidth": 0.6,
    "xtick.major.width": 0.6, "ytick.major.width": 0.6,
    "axes.spines.top": False, "axes.spines.right": False,
    "axes.grid": True, "grid.color": GRID, "grid.linewidth": 0.6, "axes.axisbelow": True,
    "legend.frameon": False, "pdf.fonttype": 42, "ps.fonttype": 42,
})


def rows(name):
    return list(csv.DictReader(open(DATA / name)))


def save(fig, name):
    FIGS.mkdir(parents=True, exist_ok=True)
    fig.savefig(FIGS / f"{name}.pdf", bbox_inches="tight")
    fig.savefig(FIGS / f"{name}.png", dpi=300, bbox_inches="tight")
    plt.close(fig)
    print(f"figures/{name}.pdf|png")


def legend_tools(ax, loc="upper left", above=False):
    placement = dict(loc="lower left", bbox_to_anchor=(0, 1.0), ncol=2) if above else dict(loc=loc)
    ax.legend(handles=[
        Line2D([], [], marker="o", ls="", color=BUMS, markersize=5, label="BUMS"),
        Line2D([], [], marker="s", ls="", color=SECSEP, markersize=5, label="SecSep"),
    ], handletextpad=0.3, **placement)


def annotation_vs_time(measure):
    pf = rows("per_function.csv")
    fig, ax = plt.subplots(figsize=(SINGLE, 2.4))
    for r in pf:
        x0, x1 = float(r[f"secsep_{measure}"]), float(r[f"bums_{measure}"])
        y0, y1 = float(r["secsep_cpu_s"]), max(float(r["bums_wall_s"]), 0.1)
        ax.scatter(x0, y0, marker="s", s=18, color=SECSEP, edgecolor="white", linewidth=0.6, zorder=3)
        ax.scatter(x1, y1, marker="o", s=20, color=BUMS, edgecolor="white", linewidth=0.6, zorder=3)
    ax.set_yscale("log")
    ax.set_xlabel("Annotation clauses per function" if measure == "clauses" else "Annotation tokens per function")
    ax.set_ylabel("Time per function (s, log)")
    legend_tools(ax, above=True)
    for r in pf:
        if r["function"] in ("ED25519_sign", "poly1305_donna_mul"):
            ax.annotate(r["function"], (float(r[f"secsep_{measure}"]), float(r["secsep_cpu_s"])),
                        xytext=(4, 3), textcoords="offset points", fontsize=6, color=INK_2)
    save(fig, f"fig_annotation_vs_time_{measure}")


def time_per_function():
    pf = sorted(rows("per_function.csv"), key=lambda r: float(r["secsep_cpu_s"]))
    fig, ax = plt.subplots(figsize=(SINGLE, 3.6))
    for i, r in enumerate(pf):
        s, b = float(r["secsep_cpu_s"]), max(float(r["bums_wall_s"]), 0.1)
        ax.plot([b, s], [i, i], color=INK_3, linewidth=0.8, zorder=1)
        ax.scatter(s, i, marker="s", s=16, color=SECSEP, edgecolor="white", linewidth=0.5, zorder=3)
        ax.scatter(b, i, marker="o", s=18, color=BUMS, edgecolor="white", linewidth=0.5, zorder=3)
    ax.set_yticks(range(len(pf)))
    ax.set_yticklabels([r["function"] for r in pf], fontsize=6, family="monospace")
    ax.set_xscale("log")
    ax.set_xlabel("Time per function (s, log)")
    ax.grid(axis="y", visible=False)
    legend_tools(ax, "lower right")
    save(fig, "fig_time_per_function")


def benchmark_time():
    pb = rows("per_benchmark.csv")
    fig, ax = plt.subplots(figsize=(SINGLE, 2.0))
    for i, r in enumerate(pb):
        s, b = float(r["secsep_cpu_s"]), float(r["bums_wall_s"])
        ax.plot([b, s], [i, i], color=INK_3, linewidth=0.8, zorder=1)
        ax.scatter(s, i, marker="s", s=22, color=SECSEP, edgecolor="white", linewidth=0.5, zorder=3)
        ax.scatter(b, i, marker="o", s=24, color=BUMS, edgecolor="white", linewidth=0.5, zorder=3)
        ax.annotate(f"{s / b:.0f}x" if s / b >= 2 else f"{s / b:.1f}x", (s, i), xytext=(5, -2.5),
                    textcoords="offset points", fontsize=6, color=INK_2)
    ax.set_yticks(range(len(pb)))
    ax.set_yticklabels([f"{r['benchmark']} ({r['functions_compared']})" for r in pb])
    ax.set_xscale("log")
    ax.set_xlabel("Total over the benchmark's functions (s, log)")
    ax.grid(axis="y", visible=False)
    legend_tools(ax, "upper left")
    save(fig, "fig_benchmark_time")


def annotation_burden():
    pb = rows("per_benchmark.csv")
    fig, ax = plt.subplots(figsize=(SINGLE, 2.0))
    width = 0.38
    for i, r in enumerate(pb):
        s, b = int(r["secsep_clauses"]), int(r["bums_clauses"])
        ax.bar(i - width / 2 - 0.01, s, width, color=SECSEP, edgecolor="white", linewidth=0.8)
        ax.bar(i + width / 2 + 0.01, b, width, color=BUMS, edgecolor="white", linewidth=0.8, hatch="////")
        ax.text(i - width / 2, s + 1, str(s), ha="center", va="bottom", fontsize=6, color=INK_2)
        ax.text(i + width / 2, b + 1, str(b), ha="center", va="bottom", fontsize=6, color=INK_2)
    ax.set_xticks(range(len(pb)))
    ax.set_xticklabels([f"{r['benchmark']} ({r['functions_compared']})" for r in pb], rotation=20, ha="right")
    ax.set_ylabel("Annotation clauses")
    ax.grid(axis="x", visible=False)
    ax.legend(handles=[plt.Rectangle((0, 0), 1, 1, color=SECSEP, label="SecSep"),
                       plt.Rectangle((0, 0), 1, 1, facecolor=BUMS, hatch="////", edgecolor="white", label="BUMS")],
              loc="lower left", bbox_to_anchor=(0, 1.0), ncol=2)
    save(fig, "fig_annotation_burden")


def mutation_matrix():
    mut = rows("mutation.csv")
    columns = [("bums_class", "BUMS"), ("octal_class", "SecSep")]
    style = {
        "rejected, localized": dict(marker="o", color=INK, fill=True),
        "type checker rejects (function-level)": dict(marker="o", color=INK, fill=False),
        "inference exception (no location)": dict(marker="^", color=INK_3, fill=False),
        "accepted": dict(marker="x", color=INK, fill=True),
    }
    fig, ax = plt.subplots(figsize=(SINGLE, 3.2))
    used = {r[key] for r in mut for key, _ in columns}
    for i, r in enumerate(mut):
        for j, (key, _) in enumerate(columns):
            st = style[r[key]]
            if st["marker"] == "x":
                ax.scatter(j, i, marker="x", s=34, linewidths=1.2, color=st["color"], zorder=3)
            else:
                ax.scatter(j, i, marker=st["marker"], s=34, linewidths=1.0,
                           facecolor=st["color"] if st["fill"] else "none", edgecolor=st["color"], zorder=3)
    ax.set_xticks(range(len(columns)))
    ax.set_xticklabels([c for _, c in columns])
    ax.xaxis.tick_top()
    ax.set_yticks(range(len(mut)))
    ax.set_yticklabels([f"{r['mutant']}: {r['fault']}" for r in mut], fontsize=6)
    ax.invert_yaxis()
    ax.set_xlim(-0.5, len(columns) - 0.5)
    ax.grid(False)
    for spine in ax.spines.values():
        spine.set_visible(False)
    ax.tick_params(length=0)
    entries = [
        ("rejected, localized", Line2D([], [], marker="o", ls="", color=INK, markersize=5, label="rejected at the faulting instruction")),
        ("type checker rejects (function-level)", Line2D([], [], marker="o", ls="", markerfacecolor="none", markeredgecolor=INK, markersize=5, label="type checker rejects the function")),
        ("inference exception (no location)", Line2D([], [], marker="^", ls="", markerfacecolor="none", markeredgecolor=INK_3, markersize=5, label="inference exception, no location")),
        ("accepted", Line2D([], [], marker="x", ls="", color=INK, markersize=5, label="accepted")),
    ]
    ax.legend(handles=[h for k, h in entries if k in used], loc="upper center", bbox_to_anchor=(0.2, -0.02), ncol=1, fontsize=6)
    save(fig, "fig_mutation")


def mutation_matrix_tools():
    dyn = rows("dynamic_tools.csv")
    columns = [("bums", "BUMS"), ("secsep", "SecSep"), ("valgrind_harness", "Valgrind\n(exact-size\ntests)"),
               ("valgrind_shipped", "Valgrind\n(SecSep\ndriver)"), ("asan_harness", "ASan\n(exact-size\ntests)"),
               ("asan_shipped", "ASan\n(SecSep\ndriver)")]
    def kind(value):
        if value in ("rejected, localized", "detected"):
            return "detected"
        if value == "type checker rejects (function-level)":
            return "function"
        if value == "inference exception (no location)":
            return "exception"
        if value in ("side effect or crash", "crashed", "timeout"):
            return "symptom"
        return "missed"
    style = {
        "detected": dict(marker="o", face=INK, edge=INK),
        "function": dict(marker="o", face="none", edge=INK),
        "exception": dict(marker="^", face="none", edge=INK_3),
        "symptom": dict(marker="D", face="none", edge=INK_3),
        "missed": dict(marker="x", face=INK, edge=INK),
    }
    fig, ax = plt.subplots(figsize=(DOUBLE * 0.72, 3.4))
    used = set()
    for i, r in enumerate(dyn):
        for j, (key, _) in enumerate(columns):
            k = kind(r[key])
            used.add(k)
            st = style[k]
            if st["marker"] == "x":
                ax.scatter(j, i, marker="x", s=30, linewidths=1.2, color=INK, zorder=3)
            else:
                ax.scatter(j, i, marker=st["marker"], s=30, linewidths=1.0, facecolor=st["face"], edgecolor=st["edge"], zorder=3)
    ax.set_xticks(range(len(columns)))
    ax.set_xticklabels([c for _, c in columns], fontsize=6.5)
    ax.xaxis.tick_top()
    ax.set_yticks(range(len(dyn)))
    ax.set_yticklabels([f"{r['mutant']}: {r['fault']}" for r in dyn], fontsize=6)
    ax.invert_yaxis()
    ax.set_xlim(-0.5, len(columns) - 0.5)
    ax.grid(False)
    for spine in ax.spines.values():
        spine.set_visible(False)
    ax.tick_params(length=0)
    for x in (1.5, 3.5):
        ax.axvline(x, color=GRID, linewidth=0.8)
    labels = [("detected", "reported at the faulting access"), ("function", "type checker rejects the function"),
              ("exception", "inference exception, no location"), ("symptom", "crash, timeout or later heap corruption"),
              ("missed", "missed")]
    handles = []
    for k, label in labels:
        if k not in used:
            continue
        st = style[k]
        if st["marker"] == "x":
            handles.append(Line2D([], [], marker="x", ls="", color=INK, markersize=5, label=label))
        else:
            handles.append(Line2D([], [], marker=st["marker"], ls="", markerfacecolor=st["face"], markeredgecolor=st["edge"], markersize=5, label=label))
    ax.legend(handles=handles, loc="upper center", bbox_to_anchor=(0.3, -0.02), ncol=2, fontsize=6)
    save(fig, "fig_mutation_tools")


def parser_coverage():
    pc = [r for r in rows("octal_parser_coverage.csv") if r["group"] in ("SecSep benchmark (clang 16 compiled)", "BoringSSL hand-written (linux)")]
    pc.sort(key=lambda r: (r["group"] != "SecSep benchmark (clang 16 compiled)", float(r["unsupported_share"])))
    fig, ax = plt.subplots(figsize=(SINGLE, 3.0))
    labels, shares, colors = [], [], []
    for r in pc:
        labels.append(r["file"].replace("-x86_64-linux.S", "").replace("-x86_64-asm-linux.S", "").replace("-linux.S", ""))
        shares.append(100 * float(r["unsupported_share"]))
        colors.append(INK_3 if r["group"].startswith("SecSep") else INK_2)
    y = range(len(labels))
    ax.barh(y, shares, color=colors, height=0.7, edgecolor="white", linewidth=0.6)
    for i, s in enumerate(shares):
        ax.text(s + 1, i, f"{s:.1f}%", va="center", fontsize=6, color=INK_2)
    ax.set_yticks(list(y))
    ax.set_yticklabels(labels, fontsize=6, family="monospace")
    ax.invert_yaxis()
    ax.set_xlabel("Instructions Octal cannot parse or does not support (%)")
    ax.grid(axis="y", visible=False)
    split = sum(1 for r in pc if r["group"].startswith("SecSep"))
    ax.axhline(split - 0.5, color=INK_3, linewidth=0.6, linestyle=(0, (2, 2)))
    ax.text(85, split / 2 - 0.5, "SecSep's own\ncompiled benchmarks", fontsize=6, color=INK_3, ha="right", va="center")
    ax.text(85, split + 2, "BoringSSL hand-written x86", fontsize=6, color=INK_3, ha="right", va="center")
    ax.set_xlim(0, 100)
    save(fig, "fig_parser_coverage")


def secsep_phase_share():
    ph = rows("secsep_phases.csv")
    benches = ["salsa20", "sha512", "chacha20", "x25519", "poly1305", "ed25519_sign"]
    phases = [("single_infer", "dependent type"), ("range_infer", "valid region"), ("taint_infer", "taint"), ("check", "type check")]
    fig, ax = plt.subplots(figsize=(SINGLE, 2.0))
    for i, b in enumerate(benches):
        by = {r["phase"]: r for r in ph if r["benchmark"] == b}
        total = sum(float(by[p]["cpu_s"]) for p, _ in phases)
        smt = sum(float(by[p]["smt_s"]) for p, _ in phases)
        left = 0
        for k, (p, _) in enumerate(phases):
            share = 100 * float(by[p]["cpu_s"]) / total
            ax.barh(i, share, left=left, color=SECSEP_RAMP[k], edgecolor="white", linewidth=1.0, height=0.7)
            left += share
        ax.text(101, i, f"{100 * smt / total:.0f}% SMT", va="center", fontsize=6, color=INK_2)
    ax.set_yticks(range(len(benches)))
    ax.set_yticklabels(benches)
    ax.invert_yaxis()
    ax.set_xlim(0, 100)
    ax.set_xlabel("Share of SecSep's inference + check CPU time (%)")
    ax.grid(axis="y", visible=False)
    ax.legend(handles=[plt.Rectangle((0, 0), 1, 1, color=SECSEP_RAMP[k], label=l) for k, (_, l) in enumerate(phases)],
              loc="upper center", bbox_to_anchor=(0.45, -0.28), ncol=4, fontsize=6)
    save(fig, "fig_secsep_phase_share")


if __name__ == "__main__":
    annotation_vs_time("clauses")
    annotation_vs_time("tokens")
    time_per_function()
    benchmark_time()
    annotation_burden()
    mutation_matrix()
    mutation_matrix_tools()
    parser_coverage()
    secsep_phase_share()
