import argparse
import csv
import datetime
import os
import platform
import statistics
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
EVALUATION = HERE.parent
ROOT = EVALUATION.parent
sys.path.insert(0, str(EVALUATION))
from report.suites import BY_NAME, library_of

SUITES = ["graviola", "corecrypto", "candle", "openblas", "blake3", "bignum", "awslc", "openssl", "compression", "rav1d", "ffmpeg"]
COLUMNS = ["suite", "domain", "function", "file", "clauses", "preconditions", "sample", "input_bytes", "description", "status",
           "raw_ns", "annotated_ns", "raw_p25", "raw_p75", "annotated_p25", "annotated_p75", "paired_ratio", "iterations", "drifted"]


def arguments():
    parser = argparse.ArgumentParser(description="Runtime overhead of every verified aarch64 function's checked wrapper.")
    parser.add_argument("--results", type=Path, default=EVALUATION / "results" / "2026-11-15-final",
                        help="sweep directory whose run1/<suite>.tsv lists the verified functions")
    parser.add_argument("--out", type=Path, default=None, help="output directory (default: RESULTS/overhead-all)")
    parser.add_argument("--suites", nargs="*", default=SUITES)
    parser.add_argument("--samples", type=int, default=8, help="distinct inputs measured per function")
    parser.add_argument("--tries", type=int, default=3000, help="candidate inputs drawn per function")
    parser.add_argument("--rounds", type=int, default=21, help="paired timing rounds per input")
    parser.add_argument("--batch-us", type=int, default=200, help="minimum duration of one timed batch")
    parser.add_argument("--seed", type=int, default=1)
    parser.add_argument("--timeout", type=int, default=180, help="seconds per function")
    return parser.parse_args()


def build(suite, verified):
    environment = dict(os.environ, OVERHEAD_SUITE=suite, OVERHEAD_VERIFIED=str(verified),
                       RUSTUP_TOOLCHAIN=os.environ.get("RUSTUP_TOOLCHAIN", "1.93-aarch64-apple-darwin"),
                       CARGO_TARGET_DIR=str(HERE / "target" / suite))
    started = time.time()
    subprocess.run(["cargo", "build", "--release", "--quiet"], cwd=HERE, env=environment, check=True)
    print(f"  built in {time.time() - started:.0f}s", flush=True)
    return HERE / "target" / suite / "release" / "overhead"


def main():
    args = arguments()
    out = args.out or args.results / "overhead-all"
    out.mkdir(parents=True, exist_ok=True)
    measurements = out / "overhead.tsv"
    statuses = out / "functions.tsv"
    with open(measurements, "w") as handle:
        handle.write("\t".join(["library"] + COLUMNS) + "\n")
    commit = subprocess.run(["git", "rev-parse", "HEAD"], cwd=ROOT, capture_output=True, text=True).stdout.strip()
    (out / "manifest.txt").write_text(
        f"date\t{datetime.datetime.now().isoformat(timespec='seconds')}\ncommit\t{commit}\n"
        f"machine\t{platform.machine()} {platform.mac_ver()[0]} {subprocess.run(['sysctl', '-n', 'machdep.cpu.brand_string'], capture_output=True, text=True).stdout.strip()}\n"
        f"results\t{args.results}\nsuites\t{' '.join(args.suites)}\nsamples\t{args.samples}\ntries\t{args.tries}\n"
        f"rounds\t{args.rounds}\nbatch_us\t{args.batch_us}\nseed\t{args.seed}\ntimeout\t{args.timeout}\n")
    with open(statuses, "w") as status_file:
        status_file.write("suite\tlibrary\tfunction\tfile\tstatus\tdetail\n")
        for suite_name in args.suites:
            suite = BY_NAME[suite_name]
            verified = args.results / "run1" / f"{suite_name}.tsv"
            print(f"== {suite_name}", flush=True)
            binary = build(suite_name, verified)
            listing = [line.split("\t") for line in subprocess.run([binary, "--list"], capture_output=True, text=True, check=True).stdout.splitlines()]
            ready = [row for row in listing if row[3] == "ready"]
            print(f"  {len(listing)} verified functions, {len(ready)} with an input generator", flush=True)
            for index, function, file, status, detail in listing:
                library = library_of(suite, function, file)
                if status != "ready":
                    status_file.write(f"{suite_name}\t{library}\t{function}\t{file}\tskipped\t{detail}\n")
                    continue
                part = out / f"part-{suite_name}-{index}.tsv"
                part.unlink(missing_ok=True)
                command = [binary, "--run", index, "--out", part, "--samples", str(args.samples), "--tries", str(args.tries),
                           "--rounds", str(args.rounds), "--batch-us", str(args.batch_us), "--seed", str(args.seed)]
                try:
                    run = subprocess.run(command, capture_output=True, text=True, timeout=args.timeout)
                    outcome = "measured" if run.returncode == 0 else f"crashed (exit {run.returncode})"
                    detail = (run.stderr.strip().splitlines() or [""])[-1][:300]
                except subprocess.TimeoutExpired:
                    outcome, detail = "timeout", f"killed after {args.timeout}s"
                rows = [line.split("\t") for line in part.read_text().splitlines()] if part.exists() else []
                if rows and rows[0][9] != "ok":
                    outcome, detail = "no input", rows[0][9]
                    rows = []
                with open(measurements, "a") as handle:
                    for row in rows:
                        handle.write("\t".join([library] + row) + "\n")
                status_file.write(f"{suite_name}\t{library}\t{function}\t{file}\t{outcome}\t{detail}\n")
                status_file.flush()
                part.unlink(missing_ok=True)
            print(f"  done", flush=True)
    summarize(measurements, statuses)


def summarize(measurements, statuses):
    with open(statuses) as handle:
        status = list(csv.DictReader(handle, delimiter="\t"))
    with open(measurements) as handle:
        rows = list(csv.DictReader(handle, delimiter="\t"))
    print(f"\n{'library':24}{'verified':>9}{'measured':>9}{'inputs':>8}{'median overhead':>17}{'median added ns':>17}")
    for library in sorted({s["library"] for s in status}):
        mine = [s for s in status if s["library"] == library]
        measured = [s for s in mine if s["status"] == "measured"]
        points = [r for r in rows if r["library"] == library]
        ratios = [float(r["paired_ratio"]) - 1 for r in points]
        added = [float(r["annotated_ns"]) - float(r["raw_ns"]) for r in points]
        overhead = f"{100 * statistics.median(ratios):+.2f}%" if ratios else "-"
        extra = f"{statistics.median(added):+.2f}" if added else "-"
        print(f"{library:24}{len(mine):9d}{len(measured):9d}{len(points):8d}{overhead:>17}{extra:>17}")
    print(f"\nwrote {measurements} and {statuses}")


if __name__ == "__main__":
    main()
