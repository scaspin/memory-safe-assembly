import re,sys,pathlib,json
TOK=re.compile(r'[A-Za-z_]\w*|\d+|->|==|<=|>=|\S')
sec={}
for p in pathlib.Path(sys.argv[1]).rglob('*.c'):
    t=p.read_text(errors='ignore')
    for m in re.finditer(r'/\*\*(.*?)\*/\s*(?:NOINLINE\s*)?(?://[^\n]*\n\s*)?(?:static\s+)?(?:inline\s+)?[\w\s\*]+?\b(\w+)\s*\(',t,re.S):
        body,fn=m.group(1),m.group(2)
        if '@secsep' not in body: continue
        lines=[re.sub(r'^\s*\*\s?','',l) for l in body.splitlines() if '@secsep' in l]
        text=' '.join(lines)
        clauses=len(re.findall(r'@(?:valid|size|unit|taint|const|sym|overlap)\b',text))+len(re.findall(r'@secsep_(?:in|out)\b',text))
        sec[fn]={'clauses':clauses,'tokens':len(TOK.findall(text)),'default':'@secsep_default' in text,'file':p.name}
bums={}
src=open(sys.argv[2]).read()
for m in re.finditer(r'#\[bums_macros::check_mem_safe\((.*?)\)\]\s*\n(fn\s+(\w+)\s*\(.*?\)\s*(?:->\s*\w+)?;)',src,re.S):
    args,sig,fn=m.group(1),m.group(2),m.group(3)
    depth=0;parts=[];cur=''
    for ch in args:
        if ch in '([': depth+=1
        if ch in ')]': depth-=1
        if ch==',' and depth==0: parts.append(cur.strip()); cur=''
        else: cur+=ch
    parts.append(cur.strip())
    exprs=parts[1:]
    constraints=sum(len([c for c in e.strip('[]').split(',') if c.strip()]) for e in exprs if e.startswith('['))
    bindings=sum(1 for e in exprs if not e.startswith('['))
    bums[fn]={'clauses':bindings+constraints,'constraints':constraints,'tokens':len(TOK.findall(','.join(exprs)))+len(TOK.findall(sig)),'file':parts[0].strip('"')}
json.dump({'secsep':sec,'bums':bums},sys.stdout,indent=1)
