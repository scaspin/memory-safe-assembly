#!/usr/bin/env python3
"""
scan_rust_ffi_highlighted.py

Scans a Rust repository for:
 - extern "C" function declarations
 - asm!/global_asm! macros

Prints colorized results and also saves to a CSV file.

Columns:
filename, line_number, declaration, reason, call_count, bindgen, public, highlight
"""

import sys
import pathlib
import re
import csv
from collections import defaultdict

# --- ANSI Colors ---
CYAN = "\033[1;36m"
YELLOW = "\033[1;33m"
GREEN = "\033[0;32m"
MAGENTA = "\033[0;35m"
RED = "\033[1;31m"
RESET = "\033[0m"

# --- Config ---
BINDGEN_HEADER_LINES = 20
RUST_EXTS = {".rs"}
DEFAULT_CSV = "ffi_scan_results.csv"

def skip_path(path: pathlib.Path) -> bool:
    return "test" in str(path).lower()

def detect_bindgen(lines) -> bool:
    upto = min(len(lines), BINDGEN_HEADER_LINES)
    for i in range(upto):
        L = lines[i].lower()
        if "bindgen" in L or "automatically generated" in L:
            return True
    return False

def skip_declaration_text(t: str) -> bool:
    tl = t.lower()
    return ("test" in tl) or ("criterion" in tl)

def colorize_line(filename, line_num, decl, reason, count, bindgen, public):
    bindgen_flag = "Yes" if bindgen else "No"
    pub_flag = "Yes" if public else "No"

    # Highlight red if it's public, not bindgen, and used multiple times
    highlight = public and not bindgen and count > 1

    color_decl = f"{RED}{decl}{RESET}" if highlight else f"{GREEN}{decl}{RESET}"

    line = (f"{YELLOW}{line_num:<5}{RESET} "
            f"{color_decl} "
            f"{MAGENTA}[{reason}]{RESET} "
            f"[Count: {count}] [Bindgen: {bindgen_flag}] [Public: {pub_flag}]")
    return line, highlight

# ---------------------------------------------------------------------
# Rust parsing
# ---------------------------------------------------------------------
def collect_extern_functions_rust(lines):
    results = []
    i = 0
    while i < len(lines):
        line = lines[i]
        if 'extern' in line and re.search(r'extern\s*"C"', line):
            if skip_declaration_text(line):
                i += 1
                continue
            start_idx = i
            decl_parts = [line.rstrip("\n")]
            open_count = line.count("{") - line.count("}")
            i += 1
            while i < len(lines) and open_count > 0:
                l = lines[i]
                if skip_declaration_text(l):
                    i += 1
                    continue
                open_count += l.count("{") - l.count("}")
                decl_parts.append(l.rstrip("\n"))
                i += 1

            decl_text = " ".join(p.strip() for p in decl_parts).strip()
            fn_matches = re.findall(r'\bfn\s+([A-Za-z_][A-Za-z0-9_]*)', decl_text)
            is_public = "pub" in decl_text.split("extern")[0]
            bindgen_flag = False
            for back in range(max(0, start_idx - 6), start_idx + 1):
                if "bindgen" in lines[back].lower() or "automatically generated" in lines[back].lower():
                    bindgen_flag = True
                    break
            if fn_matches:
                for name in fn_matches:
                    results.append((start_idx + 1, decl_text, bindgen_flag, name, "extern", is_public))
            else:
                results.append((start_idx + 1, decl_text, bindgen_flag, None, "extern", is_public))
        i += 1
    return results

def collect_asm_macros_rust(lines, macro_name):
    results = []
    i = 0
    n = len(lines)
    while i < n:
        line = lines[i]
        if re.search(rf'\b{macro_name}\s*\(', line):
            if skip_declaration_text(line):
                i += 1
                continue
            start_idx = i
            decl_parts = [line.rstrip("\n")]
            open_count = line.count("(") - line.count(")")
            i += 1
            while i < n and open_count > 0:
                open_count += lines[i].count("(") - lines[i].count(")")
                decl_parts.append(lines[i].rstrip("\n"))
                i += 1
            decl_text = " ".join(p.strip() for p in decl_parts)
            bindgen_flag = False
            for back in range(max(0, start_idx - 6), start_idx + 1):
                if "bindgen" in lines[back].lower() or "automatically generated" in lines[back].lower():
                    bindgen_flag = True
                    break
            results.append((start_idx + 1, decl_text, bindgen_flag, macro_name, macro_name, False))
        i += 1
    return results

# ---------------------------------------------------------------------
# Call counting
# ---------------------------------------------------------------------
def build_call_counts(root: pathlib.Path):
    counts = defaultdict(int)
    for path in root.rglob("*.rs"):
        if not path.is_file() or skip_path(path):
            continue
        try:
            text = path.read_text(encoding="utf-8", errors="ignore")
        except Exception:
            continue
        for m in re.finditer(r'\b([A-Za-z_][A-Za-z0-9_]*)\s*\(', text):
            counts[m.group(1)] += 1
        counts['asm'] += text.count("asm(")
        counts['global_asm'] += text.count("global_asm!(")
    return counts

# ---------------------------------------------------------------------
# Repo scanning
# ---------------------------------------------------------------------
def scan_repo(root: pathlib.Path):
    results = []
    for path in root.rglob("*.rs"):
        if not path.is_file() or skip_path(path):
            continue
        try:
            lines = path.read_text(encoding="utf-8", errors="ignore").splitlines()
        except Exception:
            continue
        bindgen_flag = detect_bindgen(lines)
        for tup in collect_extern_functions_rust(lines):
            results.append((str(path), *tup))
        for macro in ("asm", "global_asm"):
            for tup in collect_asm_macros_rust(lines, macro):
                results.append((str(path), *tup))
    return results

# ---------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------
def main():
    if len(sys.argv) < 2:
        print("Usage: python3 scan_rust_ffi_highlighted.py /path/to/repo [output.csv]")
        sys.exit(1)

    root = pathlib.Path(sys.argv[1])
    csv_path = pathlib.Path(sys.argv[2]) if len(sys.argv) > 2 else pathlib.Path(DEFAULT_CSV)

    if not root.exists():
        print(f"Path not found: {root}")
        sys.exit(1)

    counts = build_call_counts(root)
    decls = scan_repo(root)

    # Group by file
    per_file = defaultdict(list)
    for filename, line_no, decl_text, bindgen_flag, name, reason, is_public in decls:
        count = counts.get(name, 0) if name else 0
        per_file[filename].append((line_no, decl_text, reason, count, bindgen_flag, is_public))

    csv_rows = []
    for filename, items in per_file.items():
        print(f"\n{CYAN}{filename}{RESET}:")
        for line_no, decl_text, reason, count, bindgen_flag, is_public in sorted(items, key=lambda x: -x[3]):
            cleaned = re.sub(r'\s+', ' ', decl_text).strip()
            cleaned = re.sub(r'[\s]*[{};]+[\s]*$', '', cleaned)
            colored_line, highlight = colorize_line(filename, line_no, cleaned, reason, count, bindgen_flag, is_public)
            print(colored_line)
            csv_rows.append({
                "filename": filename,
                "line_number": line_no,
                "declaration": cleaned,
                "reason": reason,
                "call_count": count,
                "bindgen": bindgen_flag,
                "public": is_public,
                "highlight": highlight
            })

    # Write to CSV
    with open(csv_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=[
            "filename", "line_number", "declaration", "reason",
            "call_count", "bindgen", "public", "highlight"
        ])
        writer.writeheader()
        writer.writerows(csv_rows)

    print(f"\n✅ Results saved to {csv_path}")

if __name__ == "__main__":
    main()

