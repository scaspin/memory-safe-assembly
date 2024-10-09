import re
import sys

def clean_objdump(objdump_output):
    address_pattern = re.compile(r'^\s*[0-9a-fA-F]+:\s+[0-9a-fA-F]+\s+')
    label_pattern = re.compile(r'^\s*[0-9a-fA-F]+(?:\s+<([^>]+)>)?:')
    inline_label_pattern = re.compile(r'\s+0x[0-9a-fA-F]+\s+<([^>]+)>')

    cleaned_lines = []

    for line in objdump_output.splitlines():
        line = line.strip()

        # Skip empty lines
        if not line or line.startswith("#") or line.startswith("/") or line.startswith("Disassembly") or line == "":
            continue

        line = re.sub(address_pattern, '', line)
        line = re.sub(label_pattern, r'\1' + ":", line)
        line = re.sub(inline_label_pattern, r' \1', line)

        cleaned_lines.append(line.strip())

    return "\n".join(cleaned_lines)

# def clean_filename(filename):
#     new_filename = re.sub(r'^[^-]*-','' ,filename)
#     return new_filename

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python clean_objdump.py <input_file> <output_file>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    with open(input_file, 'r') as f:
        objdump_output = f.read()
    
    output = clean_objdump(objdump_output)
    
    with open(output_file, 'w') as f:
        f.write(output)
    
    print(f"Cleaned assembly written to {(output_file)}")
