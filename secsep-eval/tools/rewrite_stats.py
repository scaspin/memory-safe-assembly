import sys, re, difflib, collections, pathlib
def instrs(path, funcs):
    out=[]; cur=None
    for raw in open(path, errors='ignore'):
        line=raw.split('#')[0].rstrip()
        s=line.strip()
        if not s: continue
        m=re.match(r'^([A-Za-z_.$][\w.$@]*):', s)
        if m and not s.startswith('.L') :
            cur=m.group(1) if m.group(1) in funcs else None
            continue
        if cur is None or s.startswith('.') and not s.startswith('.L') : continue
        if s.endswith(':'): continue
        out.append((cur, re.sub(r'\s+',' ',s)))
    return out
analysis, shipped, names = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2]), sys.argv[3:]
print("bench\tfuncs\torig_insns\ttf_insns\tunchanged\treplaced\tinserted\tdeleted\tdelta_mem_ops\tpush_pop_rewritten\ttop_inserted")
for b in names:
    funcs=set(open(analysis/b/f"{b}.funcs.txt").read().split())
    a=instrs(analysis/b/f"{b}.s", funcs); t=instrs(shipped/f"{b}.tf.s", funcs)
    A=[x[1] for x in a]; T=[x[1] for x in t]
    sm=difflib.SequenceMatcher(None,A,T,autojunk=False)
    c=collections.Counter(); ins=collections.Counter()
    for op,i1,i2,j1,j2 in sm.get_opcodes():
        if op=='equal': c['eq']+=i2-i1
        elif op=='replace': c['rep']+=max(i2-i1,j2-j1); [ins.update([x.split()[0]]) for x in T[j1:j2]]
        elif op=='insert': c['ins']+=j2-j1; [ins.update([x.split()[0]]) for x in T[j1:j2]]
        elif op=='delete': c['del']+=i2-i1
    delta=sum(1 for x in T if re.search(r'8388608|0x800000', x))
    pp=sum(1 for x in A if x.split()[0] in ('pushq','popq'))-sum(1 for x in T if x.split()[0] in ('pushq','popq'))
    print(f"{b}\t{len(funcs)}\t{len(A)}\t{len(T)}\t{c['eq']}\t{c['rep']}\t{c['ins']}\t{c['del']}\t{delta}\t{pp}\t{' '.join(f'{k}:{v}' for k,v in ins.most_common(6))}")
