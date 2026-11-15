import argparse
import statistics
import subprocess
import sys
from pathlib import Path

from . import annotations, distribution, failures, overhead, preconditions, tables, timing
from .results import first_run, run_directories
from .suites import EVALUATION


def arguments():
    parser = argparse.ArgumentParser(prog="python3 -m report", description="Tables and figures from a bums-check sweep.")
    parser.add_argument("results", type=Path, help="sweep directory holding run1/ (and run2/, ...) and sizes/")
    parser.add_argument("--out", type=Path, help="where to write the report (default: RESULTS/report)")
    parser.add_argument("--overhead", type=Path, default=EVALUATION / "wrapper-overhead" / "results",
                        help="directory holding overhead.tsv and isolated.tsv from the wrapper benchmark")
    parser.add_argument("--open", action="store_true", help="open every figure when done (macOS)")
    return parser.parse_args()


def section(title):
    print(f"\n== {title}")


def main():
    args = arguments()
    out = args.out or args.results / "report"
    figures = out / "figures"
    figures.mkdir(parents=True, exist_ok=True)
    first = first_run(args.results)
    if not first:
        sys.exit(f"no sweep TSVs under {args.results}")
    drawn = []

    section("verification results")
    by_library, by_isa, findings = tables.summarize(first)
    tables.write_csv(by_library, out / "libraries.csv")
    tables.write_csv(by_isa, out / "libraries-by-isa.csv")
    tables.console(by_library)

    section("why checks were not verified")
    failed = failures.failures(first)
    failures.write_failures(failed, out / "failures.csv")
    drawn.append(failures.reasons_figure(failed, figures))
    counts = {}
    for row in failed:
        counts[row["reason"]] = counts.get(row["reason"], 0) + 1
    for key, label, _, _ in failures.REASONS:
        if counts.get(key):
            print(f"  {counts[key]:5d}  {label}")

    section("verification time")
    timing_figures, points = timing.render(args.results, figures)
    drawn += timing_figures
    annotation_figure, annotated = annotations.render(run_directories(args.results)[0], figures)
    drawn.append(annotation_figure)
    drawn += distribution.render(figures)

    section("preconditions")
    rows = preconditions.collect(first)
    kinds = preconditions.kind_table(rows)
    preconditions.write_kinds(kinds, out / "precondition-kinds.csv")
    drawn.append(preconditions.kinds_figure(kinds, figures))
    drawn.append(preconditions.counts_figure(rows, figures))
    counted = [r["count"] for r in rows]
    print(f"  {len(rows)} annotations, {sum(counted)} precondition clauses, "
          f"median {statistics.median(counted):g} per function, {sum(c == 0 for c in counted)} with none")

    section("runtime overhead of the checked wrappers")
    drawn += overhead.render(args.overhead, figures)

    drawn = [path for path in drawn if path]
    write_summary(out, (by_library, by_isa, findings), failed, kinds, rows, drawn)
    section("written")
    print(f"  {out / 'summary.md'}")
    print(f"  {len(drawn)} figures in {figures}")
    if args.open:
        subprocess.run(["open", *[str(p.with_suffix('.png')) for p in drawn]], check=False)


def write_summary(out, summary, failed, kinds, rows, drawn):
    counted = [r["count"] for r in rows]
    lines = ["# BUMS evaluation report", "",
             "Checks are annotations (one function on one architecture). `rejected` counts `rejects` contracts that",
             "failed as they must. Times are wall-clock seconds of verified and rejected checks, slow pass included.", "",
             "## Verification by case study and library", "",
             "Functions count each annotated function once per ISA; a function whose exact contract is `rejected` and whose",
             "`_padded`/`_zero_extended`/`_from_64` twin verifies counts as verified, and the reliance appears under",
             "Contract reliance. Findings come from `evaluation/findings.tsv`.", "",
             tables.markdown(*summary),
             "## Why checks were not verified", "",
             "Each failing check is classified by its first failure; `failures.csv` lists every one with its message.", "",
             failures.markdown(failed), "",
             "## Preconditions", "",
             f"{len(rows)} annotations carry {sum(counted)} precondition clauses "
             f"(median {statistics.median(counted):g} per function, {sum(c == 0 for c in counted)} with none). "
             "Per-suite kinds are in `precondition-kinds.csv`.", "",
             "## Figures", ""]
    lines += [f"- `figures/{path.name}`" for path in drawn]
    (out / "summary.md").write_text("\n".join(lines) + "\n")


main()
