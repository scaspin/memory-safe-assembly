import json,re,shutil,sys
from pathlib import Path
E=Path(__file__).resolve().parent.parent
ASM=E.parent/'secsep-playground'/'asm'
ANALYSIS=E/'secsep'/'benchmark'/'analysis'
OUT=E/'mutation'
MUTANTS=[
 ('salsa20-A','salsa20','salsa20_words','\tmovl\t12(%rsi), %eax','\tmovl\t64(%rsi), %eax','read word 16 of a 16-word input'),
 ('salsa20-B','salsa20','salsa20','\tcmpq\t%r15, %rbp\n\tje\t.LBB2_6','\tcmpq\t%r15, %rbp\n\tja\t.LBB2_6','byte loop runs to message[len]'),
 ('sha512-A','sha512','SHA512','\tandl\t$127, %r13d','\tandl\t$255, %r13d','tail length mask 255 instead of 127'),
 ('sha512-B','sha512','SHA512','\tshrq\t$7, %rdx','\tshrq\t$6, %rdx','block count doubled'),
 ('chacha20-A','chacha20','CRYPTO_chacha_20','\tmovups\t16(%r15,%rcx), %xmm1','\tmovups\t17(%r15,%rcx), %xmm1','vector read one byte late'),
 ('chacha20-B','chacha20','CRYPTO_chacha_20','\tcmovbq\t%r14, %r13','\tmovq\t%r13, %r13','every block 64 bytes (min removed)'),
 ('poly1305-A','poly1305','poly1305_update','\tmovzbl\t1(%r15,%rcx), %edx','\tmovzbl\t4(%r15,%rcx), %edx','unrolled tail read at +4'),
 ('poly1305-B','poly1305','poly1305_update','\tandq\t$3, %rsi','\tandq\t$7, %rsi','single-byte loop counts n&7'),
 ('x25519-A','x25519','X25519','\tmovl\t28(%rdx), %r11d','\tmovl\t29(%rdx), %r11d','peer key read at +29 (4 bytes)'),
 ('x25519-B','x25519','fe_tobytes','\tmovb\t%dl, 31(%rdi)','\tmovb\t%dl, 32(%rdi)','store s[32] of a 32-byte output'),
 ('ed25519_sign-A','ed25519_sign','x25519_sc_reduce','\tmovl\t60(%rdi), %r12d','\tmovl\t61(%rdi), %r12d','read s[61..64] of a 64-byte input'),
 ('ed25519_sign-B','ed25519_sign','ED25519_sign','\tja\t.LBB118_4\n# %bb.3:\n\tmovq\t%r12, %rsi\n\tmovq\t%r15, %rdx','\tja\t.LBB118_4\n# %bb.3:\n\tmovq\t%r12, %rsi\n\tleaq\t1(%r15), %rdx','message copy reads one byte past'),
]
manifest=[]
for mid,bench,fn,old,new,what in MUTANTS:
    src=(ASM/f'{bench}.S').read_text()
    start=re.search(rf'^{re.escape(fn)}:',src,re.M).start()
    end=src.index('\n.Lfunc_end',start)
    body=src[start:end]
    hits=body.count(old)
    if hits!=1:
        sys.exit(f'{mid}: expected one match of {old!r} in {fn}, found {hits}')
    mutated=src[:start]+body.replace(old,new)+src[end:]
    bums_dir=OUT/mid/'asm'; bums_dir.mkdir(parents=True,exist_ok=True)
    for f in ASM.glob('*.S'): shutil.copy(f,bums_dir/f.name)
    (bums_dir/f'{bench}.S').write_text(mutated)
    oct_dir=OUT/mid/'analysis'/bench
    if not oct_dir.exists(): shutil.copytree(ANALYSIS/bench,oct_dir)
    (oct_dir/f'{bench}.s').write_text(mutated)
    manifest.append(dict(id=mid,bench=bench,function=fn,old=old,new=new,what=what))
    print(f'{mid:16} {fn:18} {what}')
json.dump(manifest,open(OUT/'manifest.json','w'),indent=1)
