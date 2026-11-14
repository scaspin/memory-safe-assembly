import collections
import csv
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from preconditions import CRATES, KINDS, annotations, classify

WORKTREE = Path(__file__).resolve().parents[2]
CURRENT = Path(sys.argv[1])
EARLIER = WORKTREE / "evaluation" / "published" / "rework-5f5018a4" / "run1"
ORDER = ["crypto", "crypto-x86", "corecrypto", "graviola", "bignum", "openblas", "openblas-x86", "candle",
         "rav1d", "rav1d-x86", "ffmpeg", "compression", "compression-x86", "blake3", "blake3-x86", "secsep-x86"]


def functions(suite):
    for results in (CURRENT, EARLIER):
        path = results / f"{suite}.tsv"
        if path.exists():
            rows = [line.split("\t")[:2] for line in path.read_text().splitlines() if line.strip()]
            return rows, results.parent.name
    return [], "-"


def pick(candidates, suite):
    if len(candidates) == 1:
        return candidates[0]
    x86 = suite.endswith("-x86")
    preferred = [c for c in candidates if ("x86" in c[0].lower()) == x86]
    return (preferred or candidates)[0]


def main():
    cache, table, ambiguous, unmatched, sources = {}, {}, 0, collections.Counter(), {}
    for suite in ORDER:
        rows, sources[suite] = functions(suite)
        counts = collections.Counter()
        annotated = 0
        for function, source in rows:
            path = WORKTREE / CRATES[suite] / source
            if path not in cache:
                cache[path] = annotations(path) if path.exists() else {}
            candidates = cache[path].get(function, [])
            if not candidates:
                unmatched[suite] += 1
                continue
            ambiguous += len(candidates) > 1
            conditions = []
            for c in pick(candidates, suite)[1]:
                if "&&" in c and "||" not in c:
                    conditions.extend(p.strip() for p in c.strip("() ").split("&&"))
                else:
                    conditions.append(c)
            counts.update(classify(c) for c in conditions)
            counts["(none)"] += not conditions
            annotated += 1
        table[suite] = (annotated, counts)
    out = Path(sys.argv[2])
    kinds = [k for k in KINDS if any(c[k] for _, c in table.values())]
    with open(out, "w", newline="") as handle:
        writer = csv.writer(handle)
        writer.writerow(["suite", "source", "annotations", "with none", *kinds, "total"])
        for suite in ORDER:
            n, c = table[suite]
            writer.writerow([{"crypto": "AWS-LC", "crypto-x86": "AWS-LC-x86", "secsep-x86": "BoringSSL (SecSep)-x86"}.get(suite, suite), sources[suite], n, c["(none)"], *[c[k] for k in kinds], sum(c[k] for k in kinds)])
    print(f"ambiguous {ambiguous}, unmatched {dict(unmatched)}")
    print(out)


if __name__ == "__main__":
    main()
