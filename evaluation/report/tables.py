import csv
import statistics
from collections import Counter

from .results import EXPECTED, seconds
from .suites import CASE_STUDIES, SUITES

NOT_VERIFIED = ["FAIL", "TIMEOUT", "MEMCAP", "ERROR"]


def summarize(first):
    table = []
    for suite in SUITES:
        records = first.get(suite.name)
        if records is None:
            continue
        statuses = Counter(r["status"] for r in records)
        times = [seconds(r) for r in records if r["status"] in EXPECTED and seconds(r) is not None]
        table.append({
            "case_study": suite.case_study,
            "library": suite.library,
            "isa": suite.isa,
            "suite": suite.name,
            "checks": len(records),
            "verified": statuses["verified"],
            "rejected": statuses["rejected"],
            **{status: statuses[status] for status in NOT_VERIFIED},
            "min_s": min(times) if times else None,
            "mean_s": statistics.mean(times) if times else None,
            "median_s": statistics.median(times) if times else None,
            "max_s": max(times) if times else None,
        })
    return table


def expected(row):
    return row["verified"] + row["rejected"]


def write_csv(table, path):
    with open(path, "w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(table[0]))
        writer.writeheader()
        writer.writerows(table)


def shown(value):
    if value is None:
        return "–"
    if value < 0.01:
        return "<0.01"
    return f"{value:.2f}" if value < 10 else f"{value:.1f}"


def markdown(table):
    lines = []
    for study in CASE_STUDIES:
        rows = [r for r in table if r["case_study"] == study]
        if not rows:
            continue
        lines += [f"### {study}", "",
                  "| Library | ISA | Checks | Verified | Rejected (expected) | Rate | Not verified | Time min / mean / median / max (s) |",
                  "|---|---|---:|---:|---:|---:|---|---|"]
        for r in rows:
            failing = ", ".join(f"{r[s]} {s}" for s in NOT_VERIFIED if r[s]) or "–"
            timing = " / ".join(shown(r[k]) for k in ("min_s", "mean_s", "median_s", "max_s"))
            lines.append(f"| {r['library']} | {r['isa']} | {r['checks']} | {r['verified']} | {r['rejected']} | "
                         f"{100 * expected(r) / r['checks']:.0f}% | {failing} | {timing} |")
        checks = sum(r["checks"] for r in rows)
        good = sum(expected(r) for r in rows)
        lines += [f"| **total** | | **{checks}** | **{sum(r['verified'] for r in rows)}** | "
                  f"**{sum(r['rejected'] for r in rows)}** | **{100 * good / checks:.0f}%** | | |", ""]
    return "\n".join(lines)


def console(table):
    print(f"{'case study':13s}{'library':26s}{'isa':9s}{'checks':>7s}{'ok':>6s}{'rate':>6s}  not verified")
    for r in table:
        failing = ", ".join(f"{r[s]} {s}" for s in NOT_VERIFIED if r[s]) or "-"
        print(f"{r['case_study']:13s}{r['library']:26s}{r['isa']:9s}{r['checks']:7d}{expected(r):6d}"
              f"{100 * expected(r) / r['checks']:5.0f}%  {failing}")
    for study in CASE_STUDIES:
        rows = [r for r in table if r["case_study"] == study]
        if rows:
            checks = sum(r["checks"] for r in rows)
            print(f"{'':13s}{study + ' total':35s}{checks:7d}{sum(expected(r) for r in rows):6d}"
                  f"{100 * sum(expected(r) for r in rows) / checks:5.0f}%")
