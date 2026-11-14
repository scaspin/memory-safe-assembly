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
 ('salsa20-C','salsa20','salsa20','\tmovups\t16(%r14), %xmm0','\tmovups\t17(%r14), %xmm0','key read one byte past'),
 ('salsa20-D','salsa20','salsa20','\tcmpq\t$64, %rdx','\tcmpq\t$66, %rdx','keystream loop overruns a stack buffer into the next local'),
 ('salsa20-S','salsa20','salsa20','\tmovl\t$1797285236, 60(%rsp)','\tmovl\t$1797285237, 60(%rsp)','control: wrong constant word'),
 ('sha512-C','sha512','SHA512','\tmovl\t$127, %edx','\tmovl\t$135, %edx','padding memset overruns the block buffer into the context fields on the stack'),
 ('sha512-D','sha512','SHA512','\tmovq\t%rsi, 24(%rcx)','\tmovq\t%rsi, 32(%rcx)','digest store writes out[64..72)'),
 ('sha512-S','sha512','SHA512','\tmovabsq\t$7640891576956012808, %rax','\tmovabsq\t$7640891576956012809, %rax','control: wrong IV word'),
 ('chacha20-C','chacha20','CRYPTO_chacha_20','\tmovl\t8(%r8), %eax','\tmovl\t9(%r8), %eax','nonce read one byte past'),
 ('chacha20-D','chacha20','CRYPTO_chacha_20','\tmovb\t%cl, 3(%r12,%rax)','\tmovb\t%cl, 4(%r12,%rax)','unrolled tail writes out[len]'),
 ('chacha20-S','chacha20','CRYPTO_chacha_20','\tincl\t%ebx','\taddl\t$2, %ebx','control: block counter steps by two'),
 ('poly1305-C','poly1305','CRYPTO_poly1305_finish','\tmovl\t%eax, 12(%rbx)','\tmovl\t%eax, 13(%rbx)','tag store writes mac[16]'),
 ('poly1305-D','poly1305','CRYPTO_poly1305_update','\tmovl\t$16, %eax\n\tsubq\t%rcx, %rax','\tmovl\t$17, %eax\n\tsubq\t%rcx, %rax','partial-block copy overruns buf[16] into the buf_used field'),
 ('poly1305-E','poly1305','CRYPTO_poly1305_init','\tmovups\t16(%rsi), %xmm0','\tmovups\t17(%rsi), %xmm0','key read one byte past'),
 ('poly1305-S','poly1305','CRYPTO_poly1305_init','\tandl\t$67108611, %ecx','\tandl\t$67108615, %ecx','control: wrong clamp mask'),
 ('x25519-C','x25519','fe_mul_impl','\tmovq\t32(%rdx), %rcx','\tmovq\t40(%rdx), %rcx','reads in2[5] of a 5-limb input'),
 ('x25519-S','x25519','fe_mul_impl','\tmovabsq\t$2251799813685247, %rax','\tmovabsq\t$2251799813685246, %rax','control: wrong limb mask'),
 ('ed25519_sign-C','ed25519_sign','table_select','\tshlq\t$8, %rcx','\tshlq\t$9, %rcx','row stride doubled: reads past the k25519Precomp table'),
 ('ed25519_sign-D','ed25519_sign','ge_madd','\tmovq\t%rdx, 152(%rbx)','\tmovq\t%rdx, 160(%rbx)','stores r[20] of a 20-limb output'),
 ('ed25519_sign-S','ed25519_sign','ge_madd','\tmovabsq\t$4503599627370494, %r13','\tmovabsq\t$4503599627370490, %r13','control: wrong subtraction constant'),
]
FAULT_CLASS={'salsa20-D':'stack local overflow (inside the frame)','sha512-C':'stack local overflow (inside the frame)',
 'poly1305-D':'intra-object overflow (inside a struct)','ed25519_sign-C':'global table overflow','sha512-A':'stack buffer overflow (past the frame)'}
def fault_class(mid):
    return 'safe control' if mid.endswith('-S') else FAULT_CLASS.get(mid,'parameter buffer overflow')
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
    manifest.append(dict(id=mid,bench=bench,function=fn,old=old,new=new,what=what,fault_class=fault_class(mid),safe=mid.endswith('-S')))
    print(f'{mid:16} {fn:18} {what}')
json.dump(manifest,open(OUT/'manifest.json','w'),indent=1)
