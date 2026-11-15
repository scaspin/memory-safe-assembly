import re
import sys

LABEL_WITH_INSTRUCTION = re.compile(r"^(\s*)([A-Za-z_.$][\w.$]*):[ \t]*(\S.*)$")


def expand_argumentless_macros(lines):
    macros, body, name, kept = {}, [], None, []
    for line in lines:
        stripped = line.strip()
        if stripped.startswith(".macro"):
            parts = stripped.split()
            if len(parts) != 2:
                raise SystemExit(f"macro with arguments is not supported: {stripped}")
            name, body = parts[1], []
        elif stripped.startswith(".endm"):
            macros[name], name = body, None
        elif name is not None:
            body.append(line)
        else:
            kept.append(line)
    expanded = []
    for line in kept:
        expanded.extend(macros.get(line.strip(), [line]))
    return expanded


def split_labels(lines):
    split = []
    for line in lines:
        match = LABEL_WITH_INSTRUCTION.match(line)
        if match and not match.group(3).startswith(("//", "#", "/*")):
            split += [match.group(2) + ":", " " + match.group(3)]
        else:
            split.append(line)
    return split


DATA_WIDTHS = {".byte": 1, ".short": 2, ".hword": 2, ".long": 4, ".word": 4, ".inst": 4, ".quad": 8, ".dword": 8}
LABEL_DIFFERENCE = re.compile(r"#(\.?[A-Za-z_$][\w.$]*)-(\.?[A-Za-z_$][\w.$]*)\b")


def section_label_offsets(lines):
    offsets, section, offset = {}, None, 0
    for line in lines:
        stripped = line.split("//")[0].strip()
        if stripped.startswith((".section", ".text", ".data", ".rodata")):
            section, offset = stripped, 0
            continue
        if stripped.endswith(":"):
            offsets[stripped[:-1]] = (section, offset)
            continue
        directive, _, rest = stripped.partition(" ")
        if directive == ".align" or directive == ".p2align":
            alignment = 1 << int(rest.split(",")[0])
            offset = (offset + alignment - 1) // alignment * alignment
        elif directive == ".balign":
            alignment = int(rest.split(",")[0])
            offset = (offset + alignment - 1) // alignment * alignment
        elif directive in DATA_WIDTHS:
            offset += DATA_WIDTHS[directive] * len([item for item in rest.split(",") if item.strip()])
        elif stripped and not stripped.startswith("."):
            offset += 4
    return offsets


def banner_text(line):
    directive, _, rest = line.strip().partition("\t")
    if directive != ".byte":
        directive, _, rest = line.strip().partition(" ")
    if directive != ".byte":
        return None
    try:
        values = [int(item.strip(), 0) for item in rest.split(",")]
    except ValueError:
        return None
    if len(values) < 16 or values[-1] != 0 or not all(32 <= v < 127 for v in values[:-1]):
        return None
    return bytes(values[:-1]).decode()


def move_banners_out_of_text(lines):
    moved = []
    for line in lines:
        text = banner_text(line)
        if text is not None and " " in text:
            moved += [".pushsection .rodata", line, ".popsection"]
        else:
            moved.append(line)
    return moved


def drop_constructor_calls(lines):
    kept = []
    skipping = False
    for line in lines:
        stripped = line.strip()
        if stripped.startswith(".section") and stripped.split()[1:2] == [".init"]:
            skipping = True
            continue
        if skipping and stripped.startswith("call"):
            continue
        skipping = False
        kept.append(line)
    return kept


def drop_hash_before_relocation_operators(lines):
    return [re.sub(r"#(:(?:lo12|pg_hi21|pg_hi21_nc):)", r"\1", line) for line in lines]


def fold_label_differences(lines):
    offsets = section_label_offsets(lines)

    def fold(match):
        target, base = offsets.get(match.group(1)), offsets.get(match.group(2))
        if target is None or base is None or target[0] != base[0]:
            return match.group(0)
        return f"#{target[1] - base[1]}"

    return [LABEL_DIFFERENCE.sub(fold, line) for line in lines]


for path in sys.argv[1:]:
    with open(path) as source:
        lines = source.read().split("\n")
    with open(path, "w") as target:
        target.write("\n".join(drop_constructor_calls(move_banners_out_of_text(drop_hash_before_relocation_operators(fold_label_differences(split_labels(expand_argumentless_macros(lines))))))))
