dmax_k:
xorps %xmm0, %xmm0
leaq (,%rdx,8), %rdx
testq %rdi, %rdi
jle dmax_k_350
movsd (%rsi), %xmm0
addq %rdx, %rsi
unpcklpd %xmm0, %xmm0
movaps %xmm0, %xmm1
movaps %xmm0, %xmm2
movaps %xmm0, %xmm3
decq %rdi
jle dmax_k_350
cmpq $0x8, %rdx
jne dmax_k_1b8
subq $-0x80, %rsi
testq $0x8, %rsi
je dmax_k_68
movsd -0x80(%rsi), %xmm4
unpcklpd %xmm4, %xmm4
maxpd %xmm4, %xmm3
addq $0x8, %rsi
decq %rdi
jle dmax_k_330
nopw (%rax,%rax)
dmax_k_68:
movq %rdi, %rax
sarq $0x4, %rax
jle dmax_k_130
movaps -0x80(%rsi), %xmm4
movaps -0x70(%rsi), %xmm5
movaps -0x60(%rsi), %xmm6
movaps -0x50(%rsi), %xmm7
decq %rax
jle dmax_k_f0
nopw (%rax,%rax)
dmax_k_90:
prefetcht0 0x580(%rsi)
maxpd %xmm4, %xmm0
movaps -0x40(%rsi), %xmm4
maxpd %xmm5, %xmm1
movaps -0x30(%rsi), %xmm5
maxpd %xmm6, %xmm2
movaps -0x20(%rsi), %xmm6
maxpd %xmm7, %xmm3
movaps -0x10(%rsi), %xmm7
prefetcht0 0x5c0(%rsi)
maxpd %xmm4, %xmm0
movaps (%rsi), %xmm4
maxpd %xmm5, %xmm1
movaps 0x10(%rsi), %xmm5
maxpd %xmm6, %xmm2
movaps 0x20(%rsi), %xmm6
maxpd %xmm7, %xmm3
movaps 0x30(%rsi), %xmm7
subq $-0x80, %rsi
decq %rax
jg dmax_k_90
nopw %cs:(%rax,%rax)
dmax_k_f0:
maxpd %xmm4, %xmm0
movaps -0x40(%rsi), %xmm4
maxpd %xmm5, %xmm1
movaps -0x30(%rsi), %xmm5
maxpd %xmm6, %xmm2
movaps -0x20(%rsi), %xmm6
maxpd %xmm7, %xmm3
movaps -0x10(%rsi), %xmm7
maxpd %xmm4, %xmm0
maxpd %xmm5, %xmm1
maxpd %xmm6, %xmm2
maxpd %xmm7, %xmm3
subq $-0x80, %rsi
nopw %cs:(%rax,%rax)
nop
dmax_k_130:
testq $0x8, %rdi
jle dmax_k_160
movaps -0x80(%rsi), %xmm4
maxpd %xmm4, %xmm0
movaps -0x70(%rsi), %xmm5
maxpd %xmm5, %xmm1
movaps -0x60(%rsi), %xmm6
maxpd %xmm6, %xmm2
movaps -0x50(%rsi), %xmm7
maxpd %xmm7, %xmm3
addq $0x40, %rsi
nopl (%rax)
dmax_k_160:
testq $0x4, %rdi
jle dmax_k_180
movaps -0x80(%rsi), %xmm4
maxpd %xmm4, %xmm0
movaps -0x70(%rsi), %xmm5
maxpd %xmm5, %xmm1
addq $0x20, %rsi
nopl (%rax)
dmax_k_180:
testq $0x2, %rdi
jle dmax_k_198
movaps -0x80(%rsi), %xmm4
maxpd %xmm4, %xmm2
addq $0x10, %rsi
nopl (%rax)
dmax_k_198:
testq $0x1, %rdi
jle dmax_k_330
movsd -0x80(%rsi), %xmm4
unpcklpd %xmm4, %xmm4
maxpd %xmm4, %xmm3
jmp dmax_k_330
nop
dmax_k_1b8:
movq %rdi, %rax
sarq $0x4, %rax
jle dmax_k_270
nopw %cs:(%rax,%rax)
nop
dmax_k_1d0:
prefetcht0 0x580(%rsi)
movsd (%rsi), %xmm4
addq %rdx, %rsi
movhps (%rsi), %xmm4
addq %rdx, %rsi
maxpd %xmm4, %xmm0
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhps (%rsi), %xmm5
addq %rdx, %rsi
maxpd %xmm5, %xmm1
movsd (%rsi), %xmm6
addq %rdx, %rsi
movhps (%rsi), %xmm6
addq %rdx, %rsi
maxpd %xmm6, %xmm2
movsd (%rsi), %xmm7
addq %rdx, %rsi
movhps (%rsi), %xmm7
addq %rdx, %rsi
maxpd %xmm7, %xmm3
prefetcht0 0x5c0(%rsi)
movsd (%rsi), %xmm4
addq %rdx, %rsi
movhps (%rsi), %xmm4
addq %rdx, %rsi
maxpd %xmm4, %xmm0
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhps (%rsi), %xmm5
addq %rdx, %rsi
maxpd %xmm5, %xmm1
movsd (%rsi), %xmm6
addq %rdx, %rsi
movhps (%rsi), %xmm6
addq %rdx, %rsi
maxpd %xmm6, %xmm2
movsd (%rsi), %xmm7
addq %rdx, %rsi
movhps (%rsi), %xmm7
addq %rdx, %rsi
maxpd %xmm7, %xmm3
decq %rax
jg dmax_k_1d0
nop
dmax_k_270:
andq $0xf, %rdi
jle dmax_k_330
testq $0x8, %rdi
je dmax_k_2c8
movsd (%rsi), %xmm4
addq %rdx, %rsi
movhps (%rsi), %xmm4
addq %rdx, %rsi
maxpd %xmm4, %xmm0
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhps (%rsi), %xmm5
addq %rdx, %rsi
maxpd %xmm5, %xmm1
movsd (%rsi), %xmm6
addq %rdx, %rsi
movhps (%rsi), %xmm6
addq %rdx, %rsi
maxpd %xmm6, %xmm2
movsd (%rsi), %xmm7
addq %rdx, %rsi
movhps (%rsi), %xmm7
addq %rdx, %rsi
maxpd %xmm7, %xmm3
nop
dmax_k_2c8:
testq $0x4, %rdi
je dmax_k_2f8
movsd (%rsi), %xmm4
addq %rdx, %rsi
movhps (%rsi), %xmm4
addq %rdx, %rsi
maxpd %xmm4, %xmm0
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhps (%rsi), %xmm5
addq %rdx, %rsi
maxpd %xmm5, %xmm1
nopl (%rax,%rax)
dmax_k_2f8:
testq $0x2, %rdi
je dmax_k_318
movsd (%rsi), %xmm6
addq %rdx, %rsi
movhps (%rsi), %xmm6
addq %rdx, %rsi
maxpd %xmm6, %xmm2
nopw (%rax,%rax)
dmax_k_318:
testq $0x1, %rdi
je dmax_k_330
movsd (%rsi), %xmm7
unpcklpd %xmm7, %xmm7
maxpd %xmm7, %xmm3
nopl (%rax)
dmax_k_330:
maxpd %xmm1, %xmm0
maxpd %xmm3, %xmm2
maxpd %xmm2, %xmm0
movaps %xmm0, %xmm1
unpckhpd %xmm0, %xmm0
maxsd %xmm1, %xmm0
nopw (%rax,%rax)
dmax_k_350:
retq
