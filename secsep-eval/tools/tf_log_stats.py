import sys, re, collections
for path in sys.argv[1:]:
    text=open(path, errors='ignore').read()
    blocks=re.findall(r'\(\* >>>>>>>>>>>>> WAS >>>>>>>>>>>>> \*\)\s*\(\* (.*?) \*\)\s*(.*?)\(\* <<<<<<<<<<<<< NOW <<<<<<<<<<<<< \*\)', text, re.S)
    kinds=collections.Counter(); out_insns=0; shifted=0; added_calls=0
    for was, now in blocks:
        head=was.split(' (')[0].split('(')[0].strip()
        kind=head
        if head in ('UInst','BInst','TInst'):
            kind=head+':'+re.match(r'\w+ \((\w+)', was).group(1)
        if 'StOp' in was and head not in ('Push','Pop'): kind+='/st'
        elif 'LdOp' in was and head not in ('Push','Pop'): kind+='/ld'
        kinds[kind]+=1
        lines=[l for l in now.strip().splitlines() if l.strip() and not l.strip().startswith('(*')]
        out_insns+=len(lines)
        shifted+=sum('8388' in l for l in lines)
    funcs=len(re.findall(r'^Transformed function', text, re.M))
    print(f"{path.split('/')[-1]}: functions={funcs} rewritten_insns={len(blocks)} emitted={out_insns} delta_shifted={shifted} kinds={dict(kinds.most_common(8))}")
