import csv
import re
from pathlib import Path

EVAL = Path(__file__).resolve().parent.parent
VALE = EVAL / "related" / "hacl-star" / "vale" / "code" / "crypto"
OUT = EVAL / "paper-data" / "data" / "vale_effort.csv"
SPEC = re.compile(r"^\s*(requires|ensures|modifies|reads|lets)\b")


def strip_comments(text):
    text = re.sub(r"\(\*.*?\*\)", lambda m: "\n" * m.group(0).count("\n"), text, flags=re.S)
    return re.sub(r"//[^\n]*", "", text)


def count(path):
    lines = [l for l in strip_comments(path.read_text(errors="ignore")).split("\n") if l.strip()]
    spec, in_spec = 0, False
    for line in lines:
        if SPEC.match(line):
            in_spec = True
        elif re.match(r"^\s*(\{|procedure|function|ghost|#|let\s|\})", line):
            in_spec = False
        spec += in_spec
    procedures = sum(1 for l in lines if re.match(r"^\s*(?:inline\s+)?procedure\b", l))
    return len(lines), spec, procedures


CODE = VALE.parent
GROUPS = {
    "aes / aes-gcm": ["crypto/aes", "thirdPartyPorts/OpenSSL/aes", "thirdPartyPorts/Intel/aes"],
    "sha-256": ["crypto/sha", "thirdPartyPorts/OpenSSL/sha"],
    "poly1305": ["crypto/poly1305", "thirdPartyPorts/OpenSSL/poly1305"],
    "curve25519": ["crypto/ecc", "thirdPartyPorts/rfc7748/curve25519"],
    "bignum": ["crypto/bignum", "thirdPartyPorts/SymCrypt/bignum"],
}
rows = []
for primitive, dirs in GROUPS.items():
    vaf, fstar = [], []
    for d in dirs:
        base = CODE / d
        if not base.exists():
            continue
        vaf += [f for f in base.rglob("*.vaf") if "ppc64le" not in str(f)]
        fstar += [f for f in list(base.rglob("*.fst")) + list(base.rglob("*.fsti")) if "ppc64le" not in str(f)]
    totals = [count(f) for f in vaf]
    rows.append(dict(
        primitive=primitive,
        origins="; ".join(d for d in dirs if (CODE / d).exists()),
        vaf_files=len(vaf),
        procedures=sum(t[2] for t in totals),
        vaf_lines=sum(t[0] for t in totals),
        spec_lines=sum(t[1] for t in totals),
        code_and_proof_lines=sum(t[0] - t[1] for t in totals),
        fstar_lemma_files=len(fstar),
        fstar_lemma_lines=sum(count(f)[0] for f in fstar),
    ))
with open(OUT, "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=list(rows[0]))
    w.writeheader()
    w.writerows(rows)
for r in rows:
    print(r)
