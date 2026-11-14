import collections
import re

CRATES = {
    "compression": "compression-playground", "compression-x86": "compression-playground",
    "corecrypto": "corecrypto-playground", "graviola": "graviola-playground",
    "crypto": "crypto-playground", "crypto-x86": "crypto-playground",
    "bignum": "bignum-playground", "openblas": "openblas-playground",
    "openblas-x86": "openblas-playground", "candle": "candle-playground",
    "rav1d": "rav1d-playground", "rav1d-x86": "rav1d-playground", "ffmpeg": "ffmpeg-playground",
    "blake3": "blake3-secp256k1-playground", "blake3-x86": "blake3-secp256k1-playground",
    "secsep-x86": "secsep-playground",
}


def balanced(text, start, open_char, close_char):
    depth = 0
    in_string = False
    i = start
    while i < len(text):
        c = text[i]
        if in_string:
            if c == "\\":
                i += 2
                continue
            if c == '"':
                in_string = False
        elif c == '"':
            in_string = True
        elif c == open_char:
            depth += 1
        elif c == close_char:
            depth -= 1
            if depth == 0:
                return i
        i += 1
    return -1


def split_top(text, sep=","):
    parts, depth, current, in_string = [], 0, [], False
    for c in text:
        if in_string:
            current.append(c)
            if c == '"':
                in_string = False
            continue
        if c == '"':
            in_string = True
        elif c in "([{":
            depth += 1
        elif c in ")]}":
            depth -= 1
        if c == sep and depth == 0:
            parts.append("".join(current).strip())
            current = []
        else:
            current.append(c)
    if "".join(current).strip():
        parts.append("".join(current).strip())
    return parts


def annotations(source):
    text = source.read_text()
    found = collections.defaultdict(list)
    for match in re.finditer(r"check_mem_safe\s*\(", text):
        open_at = match.end() - 1
        close_at = balanced(text, open_at, "(", ")")
        if close_at < 0:
            continue
        body = text[open_at + 1:close_at]
        name = re.search(r"\bfn\s+([A-Za-z_][A-Za-z0-9_]*|\$[a-z_]+)", text[close_at:close_at + 2000])
        args = split_top(body)
        asm = args[0].strip().strip('"') if args else ""
        array = next((a for a in reversed(args) if a.startswith("[")), None)
        conditions = split_top(array[1:-1]) if array else []
        if name:
            found[name.group(1)].append((asm, conditions))
    return found


def classify(condition):
    if "||" in condition:
        return "disjunction"
    if re.search(r"\.iter\(\)|\.\.\]|\[\s*\.\.", condition):
        return "element range (all elements)"
    if condition.lstrip().startswith("*") or re.match(r"^\s*\(\s*\*", condition):
        return "pointed-to content"
    if re.search(r"\w\s*\[[^\]]+\]", condition.split("==")[0].split("<")[0].split(">")[0]):
        if re.search(r"as_(mut_)?ptr\(\)", condition):
            return "pointer-table entry"
        return "element value"
    if "%" in condition:
        return "divisibility / alignment"
    if ".len()" in condition:
        return "length equality" if re.search(r"(?<![<>!=])==(?!=)", condition) else "length bound"
    if re.search(r"\b[a-z_]\w*\.(\d+|[a-z_]\w*)\b(?!\()", condition):
        return "struct field"
    equality = re.search(r"(?<![<>!=])==(?!=)", condition)
    if equality:
        return "scalar equality"
    upper = re.match(r"^(.*?)(<=|<)(.*)$", condition)
    lower = re.match(r"^(.*?)(>=|>)(.*)$", condition)
    side = upper.group(3) if upper else (lower.group(1) if lower else "")
    constant = re.fullmatch(r"\s*(\d+)\s*", side)
    if (upper or (lower and not upper)) and constant and int(constant.group(1)) >= 1 << 20:
        return "overflow cap (>= 2^20)"
    if upper:
        return "scalar upper bound"
    if lower:
        return "scalar lower bound"
    return "other"


KINDS = ["length equality", "length bound", "scalar lower bound", "scalar upper bound",
         "overflow cap (>= 2^20)", "scalar equality", "divisibility / alignment", "struct field",
         "pointer-table entry", "element value", "element range (all elements)", "pointed-to content",
         "disjunction", "other"]
