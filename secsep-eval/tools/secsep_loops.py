import csv, re, subprocess, sys
from pathlib import Path
build = Path(sys.argv[1]); out = sys.argv[2]
functions = [r["function"] for r in csv.DictReader(open(sys.argv[3]))]
loops = {}
for so in sorted(build.glob("*-original/*.so")):
    dump = subprocess.run(["llvm-objdump", "-d", "--no-show-raw-insn", str(so)], capture_output=True, text=True).stdout
    current = None
    for line in dump.splitlines():
        head = re.match(r"^([0-9a-f]+) <([^>@]+)>:", line)
        if head:
            current = head.group(2); start = int(head.group(1), 16); loops.setdefault(current, 0); continue
        m = re.match(r"\s*([0-9a-f]+):\s+(j\w+)\s+(?:0x)?([0-9a-f]+)\s+<([^>+]+)", line)
        if current and m and m.group(4) == current and int(m.group(3), 16) <= int(m.group(1), 16):
            loops[current] += 1
with open(out, "w", newline="") as f:
    w = csv.writer(f); w.writerow(["function", "backward_branches"])
    for fn in functions:
        w.writerow([fn, loops.get(fn, "")]); print(fn, loops.get(fn))
