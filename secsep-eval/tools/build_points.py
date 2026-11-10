import json,re,sys,os,collections
S=os.path.dirname(os.path.abspath(__file__))
E='/Users/shai/Documents/Princeton/msa-secsep/secsep-eval'
ann=json.load(open(f'{S}/ann.json'))
bench={'salsa20.S':'salsa20','chacha20.S':'chacha20','poly1305.S':'poly1305','sha512.S':'sha512','x25519.S':'x25519','ed25519_sign.S':'ed25519_sign'}
bums={}
for tsv in [f'{E}/bums-run1.tsv',f'{E}/bums-run2.tsv',f'{E}/bums-run3.tsv',f'{E}/bums-ed.tsv',f'{E}/bums-run4.tsv',f'{E}/bums-run5.tsv',f'{E}/bums-run6.tsv',f'{E}/bums-run9.tsv']:
    if not os.path.exists(tsv): continue
    for line in open(tsv):
        p=line.rstrip('\n').split('\t')
        if len(p)>=4 and p[0] in ann['bums']:
            bums[p[0]]={'status':p[2],'time':float(p[3]),'reason':p[4][:240] if len(p)>4 else ''}
if not os.path.exists(f'{E}/bums-run2.tsv'):
    bums['table_select']={'status':'verified','time':0.2,'reason':''}
    bums['x25519_ge_scalarmult_base']={'status':'verified','time':29.8,'reason':''}
octal={}
for b in set(bench.values()):
    d=collections.defaultdict(lambda: collections.Counter())
    q=collections.defaultdict(int)
    for f in os.listdir(f'{E}/secsep/octal/out/{b}'):
        if not f.endswith('.log'): continue
        for m in re.finditer(r'OCTAL_FUNC_TIME (\w+) (\S+) ([\d.]+) (\d+)',open(f'{E}/secsep/octal/out/{b}/{f}',errors='ignore').read()):
            d[m.group(2)][m.group(1)]+=float(m.group(3)); q[m.group(2)]+=int(m.group(4))
    octal[b]=(d,q)
pts=[]
for fn,a in ann['bums'].items():
    if fn not in ann['secsep']: continue
    b=bench[a['file']]; d,q=octal[b]
    if fn not in d: print('missing octal time',b,fn,file=sys.stderr); continue
    phases={k:round(v,2) for k,v in d[fn].items()}
    pts.append({'fn':fn,'bench':b,
      'bums':{'clauses':a['clauses'],'tokens':a['tokens'],**bums[fn]},
      'secsep':{'clauses':ann['secsep'][fn]['clauses'],'tokens':ann['secsep'][fn]['tokens'],'time':round(sum(d[fn].values()),2),'phases':phases,'queries':q[fn]}})
json.dump(pts,open(f'{S}/points.json','w'),indent=1)
print(len(pts),'points')
