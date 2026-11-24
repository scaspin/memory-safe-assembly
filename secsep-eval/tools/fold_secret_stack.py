import re,sys
from pathlib import Path
DELTA=0x800000
WINDOW=1<<20
def fold(text):
    def displacement(m):
        d=int(m.group(1))
        return (str(d+DELTA) if abs(d+DELTA)<WINDOW else m.group(1))+'('
    text=re.sub(r'(?<![\w$])(-?\d+)\(',displacement,text)
    return re.sub(rf'\$-{DELTA}\b','$0',text)
src,dst=Path(sys.argv[1]),Path(sys.argv[2])
dst.write_text(fold(src.read_text()))
left=re.findall(r'-?\b838\d{4}\b',fold(src.read_text()))
print(f'{src.name}: {len(left)} delta-sized numbers left after folding')
