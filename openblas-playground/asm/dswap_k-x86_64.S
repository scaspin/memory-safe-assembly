dswap_k:
movq 0x8(%rsp), %rsi
leaq (,%r8,8), %r8
leaq (,%rsi,8), %rsi
cmpq $0x8, %r8
jne dswap_k_4b0
cmpq $0x8, %rsi
jne dswap_k_4b0
testq $0x8, %r9
je dswap_k_60
movsd (%rcx), %xmm0
movsd (%r9), %xmm8
movsd %xmm8, (%rcx)
movsd %xmm0, (%r9)
addq $0x8, %rcx
addq $0x8, %r9
decq %rdi
jle dswap_k_228
nopw %cs:(%rax,%rax)
dswap_k_60:
subq $-0x80, %rcx
subq $-0x80, %r9
testq $0x8, %rcx
jne dswap_k_230
movq %rdi, %rax
sarq $0x4, %rax
jle dswap_k_148
nopw (%rax,%rax)
dswap_k_88:
prefetcht0 0x580(%rcx)
movaps -0x80(%rcx), %xmm0
movaps -0x80(%r9), %xmm1
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x80(%rcx)
movaps -0x70(%rcx), %xmm0
movaps -0x70(%r9), %xmm1
movaps %xmm0, -0x70(%r9)
movaps %xmm1, -0x70(%rcx)
prefetcht0 0x580(%r9)
movaps -0x60(%rcx), %xmm0
movaps -0x60(%r9), %xmm1
movaps %xmm0, -0x60(%r9)
movaps %xmm1, -0x60(%rcx)
movaps -0x50(%rcx), %xmm0
movaps -0x50(%r9), %xmm1
movaps %xmm0, -0x50(%r9)
movaps %xmm1, -0x50(%rcx)
prefetcht0 0x5c0(%rcx)
movaps -0x40(%rcx), %xmm0
movaps -0x40(%r9), %xmm1
movaps %xmm0, -0x40(%r9)
movaps %xmm1, -0x40(%rcx)
movaps -0x30(%rcx), %xmm0
movaps -0x30(%r9), %xmm1
movaps %xmm0, -0x30(%r9)
movaps %xmm1, -0x30(%rcx)
prefetcht0 0x5c0(%r9)
movaps -0x20(%rcx), %xmm0
movaps -0x20(%r9), %xmm1
movaps %xmm0, -0x20(%r9)
movaps %xmm1, -0x20(%rcx)
movaps -0x10(%rcx), %xmm0
movaps -0x10(%r9), %xmm1
movaps %xmm0, -0x10(%r9)
movaps %xmm1, -0x10(%rcx)
subq $-0x80, %r9
subq $-0x80, %rcx
decq %rax
jg dswap_k_88
nop
dswap_k_148:
testq $0x8, %rdi
jle dswap_k_1a8
movaps -0x80(%rcx), %xmm0
movaps -0x80(%r9), %xmm1
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x80(%rcx)
movaps -0x70(%rcx), %xmm0
movaps -0x70(%r9), %xmm1
movaps %xmm0, -0x70(%r9)
movaps %xmm1, -0x70(%rcx)
movaps -0x60(%rcx), %xmm0
movaps -0x60(%r9), %xmm1
movaps %xmm0, -0x60(%r9)
movaps %xmm1, -0x60(%rcx)
movaps -0x50(%rcx), %xmm0
movaps -0x50(%r9), %xmm1
movaps %xmm0, -0x50(%r9)
movaps %xmm1, -0x50(%rcx)
addq $0x40, %rcx
addq $0x40, %r9
nopl (%rax)
dswap_k_1a8:
testq $0x4, %rdi
jle dswap_k_1e0
movaps -0x80(%rcx), %xmm0
movaps -0x80(%r9), %xmm1
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x80(%rcx)
movaps -0x70(%rcx), %xmm0
movaps -0x70(%r9), %xmm1
movaps %xmm0, -0x70(%r9)
movaps %xmm1, -0x70(%rcx)
addq $0x20, %rcx
addq $0x20, %r9
nopl (%rax)
dswap_k_1e0:
testq $0x2, %rdi
jle dswap_k_208
movaps -0x80(%rcx), %xmm0
movaps -0x80(%r9), %xmm1
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x80(%rcx)
addq $0x10, %rcx
addq $0x10, %r9
nopl (%rax,%rax)
dswap_k_208:
testq $0x1, %rdi
jle dswap_k_228
movsd -0x80(%rcx), %xmm0
movsd -0x80(%r9), %xmm1
movlps %xmm1, -0x80(%rcx)
movlps %xmm0, -0x80(%r9)
nopl (%rax)
dswap_k_228:
xorq %rax, %rax
retq
nopl (%rax)
dswap_k_230:
movhps -0x80(%rcx), %xmm0
movaps -0x80(%r9), %xmm1
movlps %xmm1, -0x80(%rcx)
decq %rdi
jle dswap_k_4a0
movq %rdi, %rax
sarq $0x4, %rax
jle dswap_k_370
nopw %cs:(%rax,%rax)
nopl (%rax)
dswap_k_260:
prefetcht0 0x580(%rcx)
movaps -0x78(%rcx), %xmm2
movaps -0x70(%r9), %xmm3
shufpd $0x1, %xmm2, %xmm0
movaps %xmm0, -0x80(%r9)
shufpd $0x1, %xmm3, %xmm1
movaps %xmm1, -0x78(%rcx)
movaps -0x68(%rcx), %xmm0
movaps -0x60(%r9), %xmm1
shufpd $0x1, %xmm0, %xmm2
movaps %xmm2, -0x70(%r9)
shufpd $0x1, %xmm1, %xmm3
movaps %xmm3, -0x68(%rcx)
prefetcht0 0x580(%r9)
movaps -0x58(%rcx), %xmm2
movaps -0x50(%r9), %xmm3
shufpd $0x1, %xmm2, %xmm0
movaps %xmm0, -0x60(%r9)
shufpd $0x1, %xmm3, %xmm1
movaps %xmm1, -0x58(%rcx)
movaps -0x48(%rcx), %xmm0
movaps -0x40(%r9), %xmm1
shufpd $0x1, %xmm0, %xmm2
movaps %xmm2, -0x50(%r9)
shufpd $0x1, %xmm1, %xmm3
movaps %xmm3, -0x48(%rcx)
prefetcht0 0x5c0(%rcx)
movaps -0x38(%rcx), %xmm2
movaps -0x30(%r9), %xmm3
shufpd $0x1, %xmm2, %xmm0
movaps %xmm0, -0x40(%r9)
shufpd $0x1, %xmm3, %xmm1
movaps %xmm1, -0x38(%rcx)
movaps -0x28(%rcx), %xmm0
movaps -0x20(%r9), %xmm1
shufpd $0x1, %xmm0, %xmm2
movaps %xmm2, -0x30(%r9)
shufpd $0x1, %xmm1, %xmm3
movaps %xmm3, -0x28(%rcx)
prefetcht0 0x5c0(%r9)
movaps -0x18(%rcx), %xmm2
movaps -0x10(%r9), %xmm3
shufpd $0x1, %xmm2, %xmm0
movaps %xmm0, -0x20(%r9)
shufpd $0x1, %xmm3, %xmm1
movaps %xmm1, -0x18(%rcx)
movaps -0x8(%rcx), %xmm0
movaps (%r9), %xmm1
shufpd $0x1, %xmm0, %xmm2
movaps %xmm2, -0x10(%r9)
shufpd $0x1, %xmm1, %xmm3
movaps %xmm3, -0x8(%rcx)
subq $-0x80, %rcx
subq $-0x80, %r9
decq %rax
jg dswap_k_260
nop
dswap_k_370:
testq $0x8, %rdi
jle dswap_k_3f8
movaps -0x78(%rcx), %xmm2
movaps -0x70(%r9), %xmm3
shufpd $0x1, %xmm2, %xmm0
movaps %xmm0, -0x80(%r9)
shufpd $0x1, %xmm3, %xmm1
movaps %xmm1, -0x78(%rcx)
movaps -0x68(%rcx), %xmm0
movaps -0x60(%r9), %xmm1
shufpd $0x1, %xmm0, %xmm2
movaps %xmm2, -0x70(%r9)
shufpd $0x1, %xmm1, %xmm3
movaps %xmm3, -0x68(%rcx)
movaps -0x58(%rcx), %xmm2
movaps -0x50(%r9), %xmm3
shufpd $0x1, %xmm2, %xmm0
movaps %xmm0, -0x60(%r9)
shufpd $0x1, %xmm3, %xmm1
movaps %xmm1, -0x58(%rcx)
movaps -0x48(%rcx), %xmm0
movaps -0x40(%r9), %xmm1
shufpd $0x1, %xmm0, %xmm2
movaps %xmm2, -0x50(%r9)
shufpd $0x1, %xmm1, %xmm3
movaps %xmm3, -0x48(%rcx)
addq $0x40, %rcx
addq $0x40, %r9
nopl (%rax)
dswap_k_3f8:
testq $0x4, %rdi
jle dswap_k_448
movaps -0x78(%rcx), %xmm2
movaps -0x70(%r9), %xmm3
shufpd $0x1, %xmm2, %xmm0
movaps %xmm0, -0x80(%r9)
shufpd $0x1, %xmm3, %xmm1
movaps %xmm1, -0x78(%rcx)
movaps -0x68(%rcx), %xmm0
movaps -0x60(%r9), %xmm1
shufpd $0x1, %xmm0, %xmm2
movaps %xmm2, -0x70(%r9)
shufpd $0x1, %xmm1, %xmm3
movaps %xmm3, -0x68(%rcx)
addq $0x20, %rcx
addq $0x20, %r9
nopl (%rax)
dswap_k_448:
testq $0x2, %rdi
jle dswap_k_480
movaps -0x78(%rcx), %xmm2
movaps -0x70(%r9), %xmm3
shufpd $0x1, %xmm3, %xmm1
movaps %xmm1, -0x78(%rcx)
shufpd $0x1, %xmm2, %xmm0
movaps %xmm0, -0x80(%r9)
movaps %xmm2, %xmm0
movaps %xmm3, %xmm1
addq $0x10, %rcx
addq $0x10, %r9
nopl (%rax,%rax)
dswap_k_480:
testq $0x1, %rdi
jle dswap_k_4a0
movhps %xmm0, -0x80(%r9)
movhps -0x78(%rcx), %xmm0
movhps %xmm1, -0x78(%rcx)
addq $0x8, %rcx
addq $0x8, %r9
nop
dswap_k_4a0:
movhps %xmm0, -0x80(%r9)
xorq %rax, %rax
retq
nopl (%rax)
dswap_k_4b0:
movq %rdi, %rax
sarq $0x3, %rax
jle dswap_k_590
nopl (%rax)
dswap_k_4c0:
movsd (%rcx), %xmm0
movsd (%r9), %xmm1
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm0, (%r9)
addq %rsi, %r9
movsd (%rcx), %xmm0
movsd (%r9), %xmm1
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm0, (%r9)
addq %rsi, %r9
movsd (%rcx), %xmm0
movsd (%r9), %xmm1
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm0, (%r9)
addq %rsi, %r9
movsd (%rcx), %xmm0
movsd (%r9), %xmm1
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm0, (%r9)
addq %rsi, %r9
movsd (%rcx), %xmm0
movsd (%r9), %xmm1
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm0, (%r9)
addq %rsi, %r9
movsd (%rcx), %xmm0
movsd (%r9), %xmm1
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm0, (%r9)
addq %rsi, %r9
movsd (%rcx), %xmm0
movsd (%r9), %xmm1
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm0, (%r9)
addq %rsi, %r9
movsd (%rcx), %xmm0
movsd (%r9), %xmm1
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm0, (%r9)
addq %rsi, %r9
decq %rax
jg dswap_k_4c0
nopl (%rax)
dswap_k_590:
movq %rdi, %rax
andq $0x7, %rax
jle dswap_k_5c0
nopl (%rax)
dswap_k_5a0:
movsd (%rcx), %xmm0
movsd (%r9), %xmm1
movsd %xmm1, (%rcx)
movsd %xmm0, (%r9)
addq %r8, %rcx
addq %rsi, %r9
decq %rax
jg dswap_k_5a0
nopl (%rax)
dswap_k_5c0:
xorq %rax, %rax
retq
