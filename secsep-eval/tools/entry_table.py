import json,re,os,collections
D=os.path.dirname(os.path.abspath(__file__)); E=os.path.dirname(D)
ann=json.load(open(f'{D}/ann.json'))
lib=open(f'{E}/../secsep-playground/src/lib.rs').read()
paper={'salsa20':(3,6,5),'sha512':(3,6,5),'chacha20':(3,8,7),'x25519':(5,10,7),'poly1305':(7,11,74),'ed25519_sign':(11,25,24)}
entries={'salsa20':['salsa20'],'chacha20':['CRYPTO_chacha_20'],'poly1305':['CRYPTO_poly1305_init','CRYPTO_poly1305_update','CRYPTO_poly1305_finish'],'sha512':['SHA512'],'x25519':['X25519'],'ed25519_sign':['ED25519_sign']}
secsep_wall={'salsa20':30.1,'chacha20':177.9,'poly1305':1378.7,'sha512':188.8,'x25519':853.5,'ed25519_sign':2265.5}
times={l.split('\t')[0]:(l.split('\t')[2],float(l.split('\t')[3])) for l in open(f'{E}/bums-run9.tsv') if l.count('\t')>=3}
def lines_of(fn):
    m=re.search(r'#\[bums_macros::check_mem_safe\([^\n]*\)\]\n(fn '+re.escape(fn)+r'\b.*?;)',lib,re.S)
    return 1+m.group(1).count('\n')+1
src_lines=collections.Counter()
for p in __import__('pathlib').Path(f'{E}/secsep/benchmark/src').rglob('*.c'):
    pass
order=['salsa20','sha512','chacha20','x25519','poly1305','ed25519_sign']
print('bench\tSecSep F\'\tSecSep #Arg\tSecSep #Anno(paper)\tSecSep clauses(ours)\tSecSep infer+check wall s\tBUMS entries\tBUMS #Anno lines\tBUMS clauses\tBUMS tokens\tBUMS verify s\tall verified')
rows=[]
for b in order:
    fs=entries[b]
    sec_cl=sum(v['clauses'] for k,v in ann['secsep'].items() if v['file'] and k in [x for x in ann['bums'] if (ann['bums'][x]['file'].split('.')[0]==b)] )
    bl=sum(lines_of(f) for f in fs); bc=sum(ann['bums'][f]['clauses'] for f in fs); bt=sum(ann['bums'][f]['tokens'] for f in fs)
    bs=sum(times[f][1] for f in fs); ok=all(times[f][0]=='verified' for f in fs)
    Fp,arg,anno=paper[b]
    rows.append((b,Fp,arg,anno,secsep_wall[b],len(fs),bl,bc,bt,bs,ok))
    print(f"{b}\t{Fp}\t{arg}\t{anno}\t-\t{secsep_wall[b]}\t{len(fs)}\t{bl}\t{bc}\t{bt}\t{bs:.1f}\t{ok}")
t=[sum(r[i] for r in rows) for i in (1,2,3,4,5,6,7,8,9)]
print(f"total\t{t[0]}\t{t[1]}\t{t[2]}\t-\t{t[3]:.0f}\t{t[4]}\t{t[5]}\t{t[6]}\t{t[7]}\t{t[8]:.1f}")
json.dump(rows,open(f'{D}/entry_table.json','w'))
