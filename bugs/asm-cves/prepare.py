#!/usr/bin/env python3
"""Fetch the vulnerable and fixed assembly behind each CVE and flatten it for the checker.

Each source is taken from the upstream repository at the commit before the fix and at the
fix, run through the C preprocessor with a minimal stub of the project's headers, and has
its GNU numeric local labels (`1:` reached as `1f` or `1b`) renamed to unique names, which
is what the assembler itself does. Run from this directory: `python3 prepare.py`.
"""
import os
import re
import subprocess
import sys
import tempfile
import urllib.request

HERE = os.path.dirname(os.path.abspath(__file__))
GLIBC = "https://raw.githubusercontent.com/bminor/glibc/{commit}/sysdeps/x86_64/multiarch/{file}"

CASES = [
    {
        "cve": "cve-2019-6488",
        "fix": "231c56760c1e",
        "before": "b304fc201d2f6baf52ea790df8643e99772243cd",
        "files": ["memmove-vec-unaligned-erms.S", "memmove-avx-unaligned-erms.S"],
        "entry": "memmove-avx-unaligned-erms.S",
        "builds": [
            ("before", "", "memmove-avx-unaligned-erms.lp64.vulnerable.S"),
            ("before", "-D__ILP32__", "memmove-avx-unaligned-erms.x32.vulnerable.S"),
            ("fix", "-D__ILP32__", "memmove-avx-unaligned-erms.x32.fixed.S"),
        ],
    },
    {
        "cve": "cve-2019-6488",
        "fix": "82d0b4a4d76d",
        "before": "ecd8b842cf37ea112e59cd9085ff1f1b6e208ae0",
        "files": ["memset-vec-unaligned-erms.S", "memset-avx2-unaligned-erms.S"],
        "entry": "memset-avx2-unaligned-erms.S",
        "builds": [
            ("before", "", "memset-avx2-unaligned-erms.lp64.vulnerable.S"),
            ("before", "-D__ILP32__", "memset-avx2-unaligned-erms.x32.vulnerable.S"),
            ("fix", "-D__ILP32__", "memset-avx2-unaligned-erms.x32.fixed.S"),
        ],
    },
    {
        "cve": "cve-2018-11237",
        "fix": "9aaaab7c6e41",
        "before": "8f145c77123a565b816f918969e0e35ee5b89153",
        "files": ["memmove-avx512-no-vzeroupper.S"],
        "entry": "memmove-avx512-no-vzeroupper.S",
        "builds": [
            ("before", "", "memmove-avx512-no-vzeroupper.vulnerable.S"),
            ("fix", "", "memmove-avx512-no-vzeroupper.fixed.S"),
        ],
    },
]

OPENSSL = "https://raw.githubusercontent.com/openssl/openssl/{commit}/{file}"

PERLASM_CASES = [
    {
        "cve": "cve-2026-28386",
        "fix": "7464ccdd43f6",
        "before": "02986569b897f7ed8370f7fe751f0fdfe1ae8946",
        "script": "crypto/aes/asm/aes-cfb-avx512.pl",
        "builds": [
            ("before", "aes-cfb-avx512.vulnerable.s"),
            ("fix", "aes-cfb-avx512.fixed.s"),
        ],
    },
]

NUMERIC_DEFINITION = re.compile(r"^(\s*)(\d+):")
NUMERIC_REFERENCE = re.compile(r"\b(\d+)([fb])\b")


def relabel(lines):
    definitions = []
    for i, line in enumerate(lines):
        m = NUMERIC_DEFINITION.match(line)
        if m:
            definitions.append((i, m.group(2)))
    name = {i: f".Lnumeric_{label}_{k}" for k, (i, label) in enumerate(definitions)}

    def target(at, label, direction):
        candidates = [i for i, l in definitions if l == label]
        if direction == "f":
            ahead = [i for i in candidates if i > at]
            return name[min(ahead)] if ahead else None
        behind = [i for i in candidates if i <= at]
        return name[max(behind)] if behind else None

    out = []
    for i, line in enumerate(lines):
        m = NUMERIC_DEFINITION.match(line)
        if m:
            line = f"{m.group(1)}{name[i]}:{line[m.end():]}"
        else:
            def replace(r):
                resolved = target(i, r.group(1), r.group(2))
                return resolved if resolved else r.group(0)
            if not line.lstrip().startswith("."):
                line = NUMERIC_REFERENCE.sub(replace, line)
        out.append(line)
    return out


def fetch(commit, file, into):
    with urllib.request.urlopen(GLIBC.format(commit=commit, file=file), timeout=60) as r:
        open(os.path.join(into, file), "wb").write(r.read())


def perlasm(case, which):
    tree = tempfile.mkdtemp()
    for file in (case["script"], "crypto/perlasm/x86_64-xlate.pl"):
        os.makedirs(os.path.join(tree, os.path.dirname(file)), exist_ok=True)
        with urllib.request.urlopen(OPENSSL.format(commit=case[which], file=file), timeout=60) as r:
            open(os.path.join(tree, file), "wb").write(r.read())
    script_dir = os.path.join(tree, os.path.dirname(case["script"]))
    out = os.path.join(tree, "out.s")
    env = dict(os.environ, CC="clang")
    subprocess.run(["perl", os.path.basename(case["script"]), "elf", out],
                   cwd=script_dir, env=env, check=True)
    return open(out).read().splitlines()


def main():
    for case in PERLASM_CASES:
        out_dir = os.path.join(HERE, case["cve"])
        os.makedirs(out_dir, exist_ok=True)
        for which, name in case["builds"]:
            header = [f"# {case['cve']}: openssl {case[which]} {case['script']} (elf flavour),"
                      f" generated by prepare.py"]
            lines = perlasm(case, which)
            open(os.path.join(out_dir, name), "w").write("\n".join(header + lines) + "\n")
            print(f"{case['cve']}/{name}")
    stub = os.path.join(HERE, "glibc-stub")
    for case in CASES:
        out_dir = os.path.join(HERE, case["cve"])
        os.makedirs(out_dir, exist_ok=True)
        trees = {}
        for which in ("before", "fix"):
            tree = tempfile.mkdtemp()
            for file in case["files"]:
                fetch(case[which], file, tree)
            trees[which] = tree
        for which, flags, name in case["builds"]:
            tree = trees[which]
            cmd = ["clang", "-E", "-P", "-x", "assembler-with-cpp",
                   "-include", os.path.join(stub, "sysdep.h"), "-I", stub, "-I", tree,
                   "-DUSE_MULTIARCH", "-DSHARED"] + flags.split() + [os.path.join(tree, case["entry"])]
            text = subprocess.run(cmd, check=True, capture_output=True, text=True).stdout
            lines = text.replace(" @@ ", "\n").splitlines()
            header = [f"# {case['cve']}: glibc {case[which]} sysdeps/x86_64/multiarch/{case['entry']}"
                      f" {flags or '(LP64)'}, preprocessed by prepare.py"]
            open(os.path.join(out_dir, name), "w").write("\n".join(header + relabel(lines)) + "\n")
            print(f"{case['cve']}/{name}")


if __name__ == "__main__":
    sys.exit(main())
