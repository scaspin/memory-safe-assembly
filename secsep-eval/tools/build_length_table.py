import csv
import json
import re
import statistics
from collections import defaultdict
from pathlib import Path

EVAL = Path(__file__).resolve().parent.parent
DATA = EVAL / "paper-data" / "data"
MUT = EVAL / "mutation"
LENGTHS = [16, 64, 256, 1024, 4096]
LENGTH_DEPENDENT = ["salsa20", "CRYPTO_chacha_20", "SHA512", "sha512_block_data_order", "CRYPTO_poly1305_update", "poly1305_update", "ED25519_sign"]
OVER_READS = ["salsa20-B", "salsa20-C", "sha512-B", "chacha20-A", "chacha20-B", "chacha20-C", "poly1305-A", "poly1305-B", "ed25519_sign-B"]


def median(values):
    return statistics.median(values) if values else None


def seconds(value):
    return f"{value:.1f} s" if value is not None else "-"


def octal_seconds(mid):
    log = re.sub(r"\x1b\[[0-9;]*m", "", (MUT / mid / "octal.log").read_text(errors="ignore"))
    return sum(float(x) for x in re.findall(r"time elapsed: ([0-9.]+) seconds", log))


def octal_rejected(mid):
    log = re.sub(r"\x1b\[[0-9;]*m", "", (MUT / mid / "octal.log").read_text(errors="ignore"))
    return "result: error" in log


def bums_mutant(mid, function):
    for line in (MUT / mid / "bums.tsv").read_text().splitlines():
        parts = line.split("\t")
        if parts[0] == function:
            return parts[2] == "FAIL", float(parts[3])
    return False, None


def main():
    per_function = {r["function"]: r for r in csv.DictReader(open(DATA / "per_function.csv"))}
    manifest = {m["id"]: m for m in json.loads((MUT / "manifest.json").read_text())}
    runs = defaultdict(dict)
    for r in csv.DictReader(open(EVAL / "symex" / "results_lengths.tsv"), delimiter="\t"):
        runs[(int(r["max_len"]), r["tool"])][(r["variant"], r["function"])] = r

    bums_orig = [float(per_function[f]["bums_wall_s"]) for f in LENGTH_DEPENDENT]
    secsep_orig = [float(per_function[f]["secsep_cpu_s"]) for f in LENGTH_DEPENDENT]
    bums_mut = [bums_mutant(m, manifest[m]["function"]) for m in OVER_READS]
    secsep_mut = [(octal_rejected(m), octal_seconds(m)) for m in OVER_READS]

    table = []
    fixed = dict(
        bums_orig=f"{len(bums_orig)}/{len(bums_orig)} verified, median {seconds(median(bums_orig))}",
        secsep_orig=f"{len(secsep_orig)}/{len(secsep_orig)} type-check, median {seconds(median(secsep_orig))}",
        bums_mut=f"{sum(c for c, _ in bums_mut)}/{len(bums_mut)} rejected, median {seconds(median([t for c, t in bums_mut if c]))}",
        secsep_mut=f"{sum(c for c, _ in secsep_mut)}/{len(secsep_mut)} rejected, median {seconds(median([t for c, t in secsep_mut if c]))} (whole program)",
    )
    for length in LENGTHS:
        for kind, keys in (("unmutated", [(f"{next(m['bench'] for m in manifest.values() if m['function'] == f) if any(m['function'] == f for m in manifest.values()) else ''}-original", f) for f in LENGTH_DEPENDENT]),
                           ("over-read mutant", [(m, manifest[m]["function"]) for m in OVER_READS])):
            row = dict(max_len=length, kind=kind, n=len(keys))
            for tool in ("angr", "binsec"):
                results = runs.get((length, tool), {})
                found = []
                for vid, function in keys:
                    match = [r for (v, f), r in results.items() if f == function and (v == vid or (kind == "unmutated" and v.endswith("-original")))]
                    found.append(match[0] if match else None)
                if kind == "unmutated":
                    complete = [r for r in found if r and r["verdict"].startswith("no violation (all")]
                    timeouts = sum(1 for r in found if r and "timeout" in r["verdict"])
                    false_alarms = sum(1 for r in found if r and r["verdict"] == "violation")
                    row[tool] = (f"{len(complete)}/{len(keys)} complete, median {seconds(median([float(r['seconds']) for r in complete]))}"
                                 + (f", {timeouts} timeout" if timeouts else "") + (f", {false_alarms} FALSE ALARM" if false_alarms else "")
                                 + (f", {len(keys) - sum(1 for r in found if r)} pending" if any(r is None for r in found) else ""))
                else:
                    caught = [r for r in found if r and r["verdict"] == "violation"]
                    accepted = sum(1 for r in found if r and r["verdict"].startswith("no violation"))
                    timeouts = sum(1 for r in found if r and "timeout" in r["verdict"])
                    row[tool] = (f"{len(caught)}/{len(keys)} caught, median {seconds(median([float(r['seconds']) for r in caught]))}"
                                 + (f", {accepted} missed (accepted)" if accepted else "") + (f", {timeouts} timeout" if timeouts else "")
                                 + (f", {len(keys) - sum(1 for r in found if r)} pending" if any(r is None for r in found) else ""))
            row["bums"] = fixed["bums_orig"] if kind == "unmutated" else fixed["bums_mut"]
            row["secsep"] = fixed["secsep_orig"] if kind == "unmutated" else fixed["secsep_mut"]
            table.append(row)
    with open(DATA / "symex_length_scaling.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(table[0]))
        w.writeheader()
        w.writerows(table)
    print("| Length bound | Functions | BUMS (all lengths) | SecSep (whole program) | angr | Binsec |")
    print("|---|---|---|---|---|---|")
    for r in table:
        print(f"| {r['max_len']} B | {r['kind']} ({r['n']}) | {r['bums']} | {r['secsep']} | {r['angr']} | {r['binsec']} |")


if __name__ == "__main__":
    main()
