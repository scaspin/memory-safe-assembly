zasum_k:
xorps %xmm0, %xmm0
testq %rdi, %rdi
jle zasum_k_2c0
testq %rdx, %rdx
jle zasum_k_2c0
xorps %xmm1, %xmm1
xorps %xmm2, %xmm2
xorps %xmm3, %xmm3
pcmpeqb %xmm15, %xmm15
psrlq $0x1, %xmm15
shlq $0x4, %rdx
cmpq $0x10, %rdx
jne zasum_k_210
subq $-0x80, %rsi
addq %rdi, %rdi
testq $0x8, %rsi
je zasum_k_60
movsd -0x80(%rsi), %xmm0
addq $0x8, %rsi
andps %xmm15, %xmm0
subq $0x1, %rdi
jle zasum_k_2c0
nop
zasum_k_60:
movq %rdi, %rax
sarq $0x4, %rax
jle zasum_k_168
movaps -0x80(%rsi), %xmm4
movaps -0x70(%rsi), %xmm5
movaps -0x60(%rsi), %xmm6
movaps -0x50(%rsi), %xmm7
movaps -0x40(%rsi), %xmm8
movaps -0x30(%rsi), %xmm9
movaps -0x20(%rsi), %xmm10
movaps -0x10(%rsi), %xmm11
decq %rax
jle zasum_k_120
nopw (%rax,%rax)
zasum_k_a0:
prefetcht0 0x580(%rsi)
andps %xmm15, %xmm4
addpd %xmm4, %xmm0
movaps (%rsi), %xmm4
andps %xmm15, %xmm5
addpd %xmm5, %xmm1
movaps 0x10(%rsi), %xmm5
andps %xmm15, %xmm6
addpd %xmm6, %xmm2
movaps 0x20(%rsi), %xmm6
andps %xmm15, %xmm7
addpd %xmm7, %xmm3
movaps 0x30(%rsi), %xmm7
prefetcht0 0x5c0(%rsi)
andps %xmm15, %xmm8
addpd %xmm8, %xmm0
movaps 0x40(%rsi), %xmm8
andps %xmm15, %xmm9
addpd %xmm9, %xmm1
movaps 0x50(%rsi), %xmm9
andps %xmm15, %xmm10
addpd %xmm10, %xmm2
movaps 0x60(%rsi), %xmm10
andps %xmm15, %xmm11
addpd %xmm11, %xmm3
movaps 0x70(%rsi), %xmm11
subq $-0x80, %rsi
decq %rax
jg zasum_k_a0
nop
zasum_k_120:
andps %xmm15, %xmm4
andps %xmm15, %xmm5
andps %xmm15, %xmm6
andps %xmm15, %xmm7
addpd %xmm4, %xmm0
addpd %xmm5, %xmm1
addpd %xmm6, %xmm2
addpd %xmm7, %xmm3
andps %xmm15, %xmm8
andps %xmm15, %xmm9
andps %xmm15, %xmm10
andps %xmm15, %xmm11
addpd %xmm8, %xmm0
addpd %xmm9, %xmm1
addpd %xmm10, %xmm2
addpd %xmm11, %xmm3
subq $-0x80, %rsi
zasum_k_168:
andq $0xf, %rdi
jle zasum_k_2b0
testq $0x8, %rdi
je zasum_k_1b0
movaps -0x80(%rsi), %xmm4
movaps -0x70(%rsi), %xmm5
movaps -0x60(%rsi), %xmm6
movaps -0x50(%rsi), %xmm7
andps %xmm15, %xmm4
andps %xmm15, %xmm5
andps %xmm15, %xmm6
andps %xmm15, %xmm7
addpd %xmm4, %xmm0
addpd %xmm5, %xmm1
addpd %xmm6, %xmm2
addpd %xmm7, %xmm3
addq $0x40, %rsi
nop
zasum_k_1b0:
testq $0x4, %rdi
je zasum_k_1d8
movaps -0x80(%rsi), %xmm4
movaps -0x70(%rsi), %xmm5
andps %xmm15, %xmm4
andps %xmm15, %xmm5
addpd %xmm4, %xmm0
addpd %xmm5, %xmm1
addq $0x20, %rsi
nopl (%rax)
zasum_k_1d8:
testq $0x2, %rdi
je zasum_k_1f1
movaps -0x80(%rsi), %xmm6
andps %xmm15, %xmm6
addpd %xmm6, %xmm3
addq $0x10, %rsi
zasum_k_1f1:
testq $0x1, %rdi
je zasum_k_2b0
movsd -0x80(%rsi), %xmm4
andps %xmm15, %xmm4
addsd %xmm4, %xmm0
jmp zasum_k_2b0
zasum_k_210:
movq %rdi, %rax
sarq $0x2, %rax
jle zasum_k_280
nopl (%rax)
zasum_k_220:
movsd (%rsi), %xmm4
movhpd 0x8(%rsi), %xmm4
addq %rdx, %rsi
andpd %xmm15, %xmm4
addpd %xmm4, %xmm0
movsd (%rsi), %xmm5
movhpd 0x8(%rsi), %xmm5
addq %rdx, %rsi
andpd %xmm15, %xmm5
addpd %xmm5, %xmm1
movsd (%rsi), %xmm6
movhpd 0x8(%rsi), %xmm6
addq %rdx, %rsi
andpd %xmm15, %xmm6
addpd %xmm6, %xmm2
movsd (%rsi), %xmm7
movhpd 0x8(%rsi), %xmm7
addq %rdx, %rsi
andpd %xmm15, %xmm7
addpd %xmm7, %xmm3
decq %rax
jg zasum_k_220
nopl (%rax)
zasum_k_280:
andq $0x3, %rdi
jle zasum_k_2b0
nopw %cs:(%rax,%rax)
zasum_k_290:
movsd (%rsi), %xmm4
movhpd 0x8(%rsi), %xmm4
andpd %xmm15, %xmm4
addpd %xmm4, %xmm0
addq %rdx, %rsi
decq %rdi
jg zasum_k_290
nopw (%rax,%rax)
zasum_k_2b0:
addpd %xmm1, %xmm0
addpd %xmm3, %xmm2
addpd %xmm2, %xmm0
haddpd %xmm0, %xmm0
zasum_k_2c0:
retq
