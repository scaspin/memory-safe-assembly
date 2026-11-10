import re,sys,pathlib,collections
root=pathlib.Path(sys.argv[1])
files=[p for p in root.rglob('*') if p.suffix in ('.c','.h')]
tot=collections.Counter(); per=collections.defaultdict(collections.Counter)
for p in files:
    t=p.read_text(errors='ignore')
    for m in re.finditer(r'/\*\*(.*?)\*/\s*(?:NOINLINE\s*)?(?://[^\n]*\n\s*)?(?:static\s+)?[\w\s\*]+?\b(\w+)\s*\(',t,re.S):
        body,fn=m.group(1),m.group(2)
        if '@secsep' not in body: continue
        c=per[(p.name,fn)]
        c['default']+=body.count('@secsep_default')
        c['var_lines']+=len(re.findall(r'@secsep\s+[\w\->\.]+\s*:',body))
        c['constr']+=len(re.findall(r'@secsep_(?:in|out)\b',body))
        for tag in ['size','unit','valid','taint','const','sym','overlap']:
            c[tag]+=len(re.findall(r'@'+tag+r'\b',body))
    for k in ['SECRET_SYM','PUBLIC_SYM','SECRET_CONSTSYM','PUBLIC_CONSTSYM','SECRET_VAR','PUBLIC_VAR']:
        tot[k]+=len(re.findall(r'\b'+k+r'\b',t))-(1 if p.name=='secsep.h' else 0)
for (f,fn),c in sorted(per.items()):
    print(f"{f:28} {fn:28} "+" ".join(f"{k}={v}" for k,v in c.items() if v))
s=collections.Counter()
for c in per.values(): s.update(c)
print("annotated functions:",len(per),"non-default:",sum(1 for c in per.values() if not c['default']))
print("totals:",dict(s)); print("global/local section annotations:",dict(tot))
