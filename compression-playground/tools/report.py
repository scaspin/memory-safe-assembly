"""Merge bums-check --out TSVs into ../asm-status.tsv and print a summary.

Usage: python3 report.py aarch64=<tsv> x86_64=<tsv> [arch=<tsv> ...]

Later files override earlier rows for the same library, function and architecture, so
a targeted rerun (a larger memory cap, a fixed engine) replaces the sweep's row.

Each input row is `function, file, status, seconds, first error`. The output
adds the architecture and the library (zstd or the ISA-L component), sorted
by library, function and architecture.
"""

import sys
from collections import Counter
from pathlib import Path

OUT = Path(__file__).resolve().parent.parent / "asm-status.tsv"
LIBRARIES = {
    "zstd.rs": "zstd",
    "igzip.rs": "isa-l igzip",
    "igzip_stream.rs": "isa-l igzip",
    "crc.rs": "isa-l crc",
    "erasure_code.rs": "isa-l erasure_code",
    "raid.rs": "isa-l raid",
    "mem.rs": "isa-l mem",
    "zlib_ng.rs": "zlib-ng",
}


def rows(path, arch):
    for line in Path(path).read_text().splitlines():
        function, file, status, seconds, *error = line.split("\t")
        library = LIBRARIES.get(Path(file).name, Path(file).name)
        yield library, function, arch, status, seconds, (error[0] if error else "")


def main():
    latest = {}
    for argument in sys.argv[1:]:
        arch, path = argument.split("=", 1)
        seen = Counter()
        for row in rows(path, arch):
            seen[(row[0], row[1])] += 1
            latest[(row[0], row[1], row[2], seen[(row[0], row[1])])] = row
    table = sorted(latest.values())
    header = "library\tfunction\tarch\tstatus\tseconds\tfirst error"
    OUT.write_text(header + "\n" + "\n".join("\t".join(r) for r in table) + "\n")
    by_library = Counter((r[0], r[3]) for r in table)
    for library in sorted({r[0] for r in table}):
        counts = {s: n for (l, s), n in by_library.items() if l == library}
        total = sum(counts.values())
        shown = ", ".join(f"{n} {s}" for s, n in sorted(counts.items(), key=lambda kv: -kv[1]))
        print(f"{library:22s} {total:4d}: {shown}")
    totals = Counter(r[3] for r in table)
    print(f"{'total':22s} {len(table):4d}: " + ", ".join(f"{n} {s}" for s, n in totals.most_common()))


if __name__ == "__main__":
    main()
