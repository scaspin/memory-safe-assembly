import json
import re
import shutil
from pathlib import Path

DYN = Path(__file__).resolve().parent
EVAL = DYN.parent
ANALYSIS = EVAL / "secsep" / "benchmark" / "analysis"
BUILD = DYN / "build"
BENCHES = ["salsa20", "sha512", "chacha20", "poly1305", "x25519", "ed25519_sign"]
EXPORT = {"poly1305": ["poly1305_update"], "x25519": ["fe_tobytes"]}


def harness_ready(text, bench):
    text = re.sub(r"^(\s*\.globl\s+)main\b", r"\1secsep_main", text, flags=re.M)
    text = re.sub(r"^(\s*\.type\s+)main\b", r"\1secsep_main", text, flags=re.M)
    text = re.sub(r"^main:", "secsep_main:", text, flags=re.M)
    text = re.sub(r"^(\s*\.size\s+)main,(.*)-main\b", r"\1secsep_main,\2-secsep_main", text, flags=re.M)
    exports = "".join(f"\t.globl\t{name}\n" for name in EXPORT.get(bench, []))
    return exports + text


variants = [(f"{b}-original", b, ANALYSIS / b / f"{b}.s") for b in BENCHES]
for m in json.loads((EVAL / "mutation" / "manifest.json").read_text()):
    variants.append((m["id"], m["bench"], EVAL / "mutation" / m["id"] / "analysis" / m["bench"] / f"{m['bench']}.s"))

if BUILD.exists():
    shutil.rmtree(BUILD)
plan = []
for vid, bench, src in variants:
    out = BUILD / vid
    out.mkdir(parents=True)
    text = src.read_text()
    (out / "shipped.s").write_text(text)
    (out / "harness.s").write_text(harness_ready(text, bench))
    plan.append(dict(variant=vid, bench=bench))
(BUILD / "plan.json").write_text(json.dumps(plan, indent=1))
print(f"{len(plan)} variants prepared")
