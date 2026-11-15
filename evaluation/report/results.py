import csv
from collections import defaultdict
from pathlib import Path

from .suites import canonical

COLUMNS = [
    "function", "file", "status", "seconds", "message",
    "instructions", "loops", "steps", "queries",
    "execution", "loop_resolution", "forking", "smt_execution", "smt_loops",
    "parsing", "serialization",
]
EXPECTED = ("verified", "rejected")


def read_tsv(path):
    records = []
    with open(path, newline="") as handle:
        for row in csv.reader(handle, delimiter="\t"):
            if len(row) >= 4 and row[2] != "status":
                records.append(dict(zip(COLUMNS, row)))
    return records


def run_directories(results):
    results = Path(results)
    runs = sorted(p for p in results.glob("run*") if p.is_dir())
    return runs or [results]


def read_runs(results):
    runs = defaultdict(lambda: defaultdict(list))
    for directory in run_directories(results):
        for tsv in sorted(directory.glob("*.tsv")):
            for record in read_tsv(tsv):
                runs[canonical(tsv.stem)][(record["function"], record["file"])].append(record)
    return runs


def first_run(results):
    directory = run_directories(results)[0]
    return {canonical(tsv.stem): read_tsv(tsv) for tsv in sorted(directory.glob("*.tsv"))}


def read_sizes(directory):
    sizes = {}
    for tsv in sorted(Path(directory).glob("*.tsv")):
        with open(tsv, newline="") as handle:
            for row in csv.reader(handle, delimiter="\t"):
                if len(row) == 3:
                    function, file, size = row
                    sizes[(canonical(tsv.stem), function, file)] = int(size)
    return sizes


def seconds(record):
    try:
        return float(record["seconds"])
    except (KeyError, ValueError):
        return None
