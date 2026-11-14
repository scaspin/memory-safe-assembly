import csv
import statistics
import sys
from collections import Counter
from pathlib import Path

CASE_STUDIES = [
    ("Cryptography", [
        ("AWS-LC", "aarch64", "crypto"),
        ("AWS-LC", "x86-64", "crypto-x86"),
        ("corecrypto", "aarch64", "corecrypto"),
        ("graviola", "aarch64", "graviola"),
        ("s2n-bignum", "aarch64", "bignum"),
        ("BLAKE3 + secp256k1", "aarch64", "blake3"),
        ("BLAKE3 + secp256k1", "x86-64", "blake3-x86"),
        ("BoringSSL (SecSep set)", "x86-64", "secsep-x86"),
    ]),
    ("Math", [
        ("candle", "aarch64", "candle"),
        ("OpenBLAS", "aarch64", "openblas"),
        ("OpenBLAS", "x86-64", "openblas-x86"),
        ("ISA-L + zlib-ng + zstd", "aarch64", "compression"),
        ("ISA-L + zlib-ng + zstd", "x86-64", "compression-x86"),
    ]),
    ("Video", [
        ("FFmpeg", "aarch64", "ffmpeg"),
        ("rav1d/dav1d", "aarch64", "rav1d"),
        ("rav1d/dav1d", "x86-64", "rav1d-x86"),
    ]),
]
NOT_VERIFIED = ["FAIL", "TIMEOUT", "MEMCAP", "ERROR"]


def rows_of(results, suite):
    path = results / f"{suite}.tsv"
    if not path.exists():
        return None
    rows = []
    for line in path.read_text().splitlines():
        parts = line.split("\t")
        if len(parts) >= 4:
            rows.append((parts[2], float(parts[3]) if parts[3] else None))
    return rows


def seconds(value):
    if value < 0.01:
        return "<0.01"
    return f"{value:.2f}" if value < 10 else f"{value:.1f}"


def summarize(results):
    table = []
    for study, libraries in CASE_STUDIES:
        for library, arch, suite in libraries:
            rows = rows_of(results, suite)
            if rows is None:
                table.append(dict(study=study, library=library, arch=arch, suite=suite, missing=True))
                continue
            statuses = Counter(status for status, _ in rows)
            times = [t for status, t in rows if status in ("verified", "rejected") and t is not None]
            table.append(dict(
                study=study, library=library, arch=arch, suite=suite, missing=False,
                checks=len(rows), verified=statuses["verified"], rejected=statuses["rejected"],
                **{status: statuses[status] for status in NOT_VERIFIED},
                min=min(times) if times else None, mean=statistics.mean(times) if times else None,
                median=statistics.median(times) if times else None, max=max(times) if times else None,
            ))
    return table


def markdown(table, results):
    lines = [f"Per-case-study verification, from `{results}`.",
             "Checks are annotations (one function on one architecture). `rejected` are `rejects` contracts that",
             "failed as they must and count as expected outcomes. Times are wall-clock seconds of verified and",
             "rejected checks, slow-pass times included.", ""]
    for study, _ in CASE_STUDIES:
        lines += [f"## {study}", "",
                  "| Library | Arch | Checks | Verified | Rate | Rejected (expected) | Not verified | Time min / mean / median / max (s) |",
                  "|---|---|---:|---:|---:|---:|---|---|"]
        totals = Counter()
        for row in (r for r in table if r["study"] == study):
            if row["missing"]:
                lines.append(f"| {row['library']} | {row['arch']} | – | – | – | – | no `{row['suite']}.tsv` | – |")
                continue
            expected = row["verified"] + row["rejected"]
            rate = f"{100 * expected / row['checks']:.0f}%" if row["checks"] else "–"
            failing = ", ".join(f"{row[s]} {s}" for s in NOT_VERIFIED if row[s]) or "–"
            timing = " / ".join(seconds(row[k]) for k in ("min", "mean", "median", "max")) if row["min"] is not None else "–"
            lines.append(f"| {row['library']} | {row['arch']} | {row['checks']} | {row['verified']} | {rate} | "
                         f"{row['rejected']} | {failing} | {timing} |")
            totals.update(checks=row["checks"], expected=expected)
        if totals["checks"]:
            lines.append(f"| **total** | | **{totals['checks']}** | | "
                         f"**{100 * totals['expected'] / totals['checks']:.0f}%** | | | |")
        lines.append("")
    return "\n".join(lines)


def main():
    results = Path(sys.argv[1])
    out = Path(sys.argv[2]) if len(sys.argv) > 2 else results.parent
    out.mkdir(parents=True, exist_ok=True)
    table = summarize(results)
    keys = ["study", "library", "arch", "suite", "checks", "verified", "rejected", *NOT_VERIFIED,
            "min", "mean", "median", "max"]
    with open(out / "case-studies.csv", "w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=keys, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(r for r in table if not r["missing"])
    (out / "case-studies.md").write_text(markdown(table, results))
    print(out / "case-studies.md")


if __name__ == "__main__":
    main()
