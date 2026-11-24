damax_k:
xorps %xmm0, %xmm0
leaq (,%rdx,8), %rdx
testq %rdi, %rdi
jle damax_k_400
pcmpeqb %xmm15, %xmm15
psrlq $0x1, %xmm15
movsd (%rsi), %xmm0
addq %rdx, %rsi
andps %xmm15, %xmm0
unpcklpd %xmm0, %xmm0
movaps %xmm0, %xmm1
movaps %xmm0, %xmm2
movaps %xmm0, %xmm3
decq %rdi
jle damax_k_400
cmpq $0x8, %rdx
jne damax_k_230
subq $-0x80, %rsi
testq $0x8, %rsi
je damax_k_78
movsd -0x80(%rsi), %xmm4
andps %xmm15, %xmm4
unpcklpd %xmm4, %xmm4
maxpd %xmm4, %xmm3
addq $0x8, %rsi
decq %rdi
jle damax_k_3e0
nopl (%rax)
damax_k_78:
movq %rdi, %rax
sarq $0x4, %rax
jle damax_k_180
movaps -0x80(%rsi), %xmm4
movaps -0x70(%rsi), %xmm5
movaps -0x60(%rsi), %xmm6
movaps -0x50(%rsi), %xmm7
decq %rax
jle damax_k_120
nop
damax_k_a0:
prefetcht0 0x580(%rsi)
andps %xmm15, %xmm4
maxpd %xmm4, %xmm0
movaps -0x40(%rsi), %xmm4
andps %xmm15, %xmm5
maxpd %xmm5, %xmm1
movaps -0x30(%rsi), %xmm5
andps %xmm15, %xmm6
maxpd %xmm6, %xmm2
movaps -0x20(%rsi), %xmm6
andps %xmm15, %xmm7
maxpd %xmm7, %xmm3
movaps -0x10(%rsi), %xmm7
prefetcht0 0x5c0(%rsi)
andps %xmm15, %xmm4
maxpd %xmm4, %xmm0
movaps (%rsi), %xmm4
andps %xmm15, %xmm5
maxpd %xmm5, %xmm1
movaps 0x10(%rsi), %xmm5
andps %xmm15, %xmm6
maxpd %xmm6, %xmm2
movaps 0x20(%rsi), %xmm6
andps %xmm15, %xmm7
maxpd %xmm7, %xmm3
movaps 0x30(%rsi), %xmm7
subq $-0x80, %rsi
decq %rax
jg damax_k_a0
nopw %cs:(%rax,%rax)
damax_k_120:
andps %xmm15, %xmm4
maxpd %xmm4, %xmm0
movaps -0x40(%rsi), %xmm4
andps %xmm15, %xmm5
maxpd %xmm5, %xmm1
movaps -0x30(%rsi), %xmm5
andps %xmm15, %xmm6
maxpd %xmm6, %xmm2
movaps -0x20(%rsi), %xmm6
andps %xmm15, %xmm7
maxpd %xmm7, %xmm3
movaps -0x10(%rsi), %xmm7
andps %xmm15, %xmm4
maxpd %xmm4, %xmm0
andps %xmm15, %xmm5
maxpd %xmm5, %xmm1
andps %xmm15, %xmm6
maxpd %xmm6, %xmm2
andps %xmm15, %xmm7
maxpd %xmm7, %xmm3
subq $-0x80, %rsi
nopw %cs:(%rax,%rax)
nop
damax_k_180:
testq $0x8, %rdi
jle damax_k_1c0
movaps -0x80(%rsi), %xmm4
andps %xmm15, %xmm4
maxpd %xmm4, %xmm0
movaps -0x70(%rsi), %xmm5
andps %xmm15, %xmm5
maxpd %xmm5, %xmm1
movaps -0x60(%rsi), %xmm6
andps %xmm15, %xmm6
maxpd %xmm6, %xmm2
movaps -0x50(%rsi), %xmm7
andps %xmm15, %xmm7
maxpd %xmm7, %xmm3
addq $0x40, %rsi
nopl (%rax)
damax_k_1c0:
testq $0x4, %rdi
jle damax_k_1e8
movaps -0x80(%rsi), %xmm4
andps %xmm15, %xmm4
maxpd %xmm4, %xmm0
movaps -0x70(%rsi), %xmm5
andps %xmm15, %xmm5
maxpd %xmm5, %xmm1
addq $0x20, %rsi
nopl (%rax)
damax_k_1e8:
testq $0x2, %rdi
jle damax_k_208
movaps -0x80(%rsi), %xmm4
andps %xmm15, %xmm4
maxpd %xmm4, %xmm2
addq $0x10, %rsi
nopl (%rax)
damax_k_208:
testq $0x1, %rdi
jle damax_k_3e0
movsd -0x80(%rsi), %xmm4
unpcklpd %xmm4, %xmm4
andps %xmm15, %xmm4
maxpd %xmm4, %xmm3
jmp damax_k_3e0
nopl (%rax,%rax)
damax_k_230:
movq %rdi, %rax
sarq $0x4, %rax
jle damax_k_300
nopl (%rax)
damax_k_240:
prefetcht0 0x580(%rsi)
movsd (%rsi), %xmm4
addq %rdx, %rsi
movhps (%rsi), %xmm4
addq %rdx, %rsi
andps %xmm15, %xmm4
maxpd %xmm4, %xmm0
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhps (%rsi), %xmm5
addq %rdx, %rsi
andps %xmm15, %xmm5
maxpd %xmm5, %xmm1
movsd (%rsi), %xmm6
addq %rdx, %rsi
movhps (%rsi), %xmm6
addq %rdx, %rsi
andps %xmm15, %xmm6
maxpd %xmm6, %xmm2
movsd (%rsi), %xmm7
addq %rdx, %rsi
movhps (%rsi), %xmm7
addq %rdx, %rsi
andps %xmm15, %xmm7
maxpd %xmm7, %xmm3
prefetcht0 0x5c0(%rsi)
movsd (%rsi), %xmm4
addq %rdx, %rsi
movhps (%rsi), %xmm4
addq %rdx, %rsi
andps %xmm15, %xmm4
maxpd %xmm4, %xmm0
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhps (%rsi), %xmm5
addq %rdx, %rsi
andps %xmm15, %xmm5
maxpd %xmm5, %xmm1
movsd (%rsi), %xmm6
addq %rdx, %rsi
movhps (%rsi), %xmm6
addq %rdx, %rsi
andps %xmm15, %xmm6
maxpd %xmm6, %xmm2
movsd (%rsi), %xmm7
addq %rdx, %rsi
movhps (%rsi), %xmm7
addq %rdx, %rsi
andps %xmm15, %xmm7
maxpd %xmm7, %xmm3
decq %rax
jg damax_k_240
nop
damax_k_300:
andq $0xf, %rdi
jle damax_k_3e0
testq $0x8, %rdi
je damax_k_368
movsd (%rsi), %xmm4
addq %rdx, %rsi
movhps (%rsi), %xmm4
addq %rdx, %rsi
andps %xmm15, %xmm4
maxpd %xmm4, %xmm0
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhps (%rsi), %xmm5
addq %rdx, %rsi
andps %xmm15, %xmm5
maxpd %xmm5, %xmm1
movsd (%rsi), %xmm6
addq %rdx, %rsi
movhps (%rsi), %xmm6
addq %rdx, %rsi
andps %xmm15, %xmm6
maxpd %xmm6, %xmm2
movsd (%rsi), %xmm7
addq %rdx, %rsi
movhps (%rsi), %xmm7
addq %rdx, %rsi
andps %xmm15, %xmm7
maxpd %xmm7, %xmm3
nop
damax_k_368:
testq $0x4, %rdi
je damax_k_3a0
movsd (%rsi), %xmm4
addq %rdx, %rsi
movhps (%rsi), %xmm4
addq %rdx, %rsi
andps %xmm15, %xmm4
maxpd %xmm4, %xmm0
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhps (%rsi), %xmm5
addq %rdx, %rsi
andps %xmm15, %xmm5
maxpd %xmm5, %xmm1
nopl (%rax,%rax)
damax_k_3a0:
testq $0x2, %rdi
je damax_k_3c0
movsd (%rsi), %xmm6
addq %rdx, %rsi
movhps (%rsi), %xmm6
addq %rdx, %rsi
andps %xmm15, %xmm6
maxpd %xmm6, %xmm2
nop
damax_k_3c0:
testq $0x1, %rdi
je damax_k_3e0
movsd (%rsi), %xmm7
unpcklpd %xmm7, %xmm7
andps %xmm15, %xmm7
maxpd %xmm7, %xmm3
nopl (%rax)
damax_k_3e0:
maxpd %xmm1, %xmm0
maxpd %xmm3, %xmm2
maxpd %xmm2, %xmm0
movaps %xmm0, %xmm1
unpckhpd %xmm0, %xmm0
maxsd %xmm1, %xmm0
nopw (%rax,%rax)
damax_k_400:
retq
