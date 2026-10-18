zdotu_k:
shlq $0x4, %rdx
shlq $0x4, %r8
xorps %xmm0, %xmm0
xorps %xmm1, %xmm1
xorps %xmm2, %xmm2
xorps %xmm3, %xmm3
cmpq $0x0, %rdi
jle zdotu_k_161a
cmpq $0x10, %rdx
jne zdotu_k_1140
cmpq $0x10, %r8
jne zdotu_k_1140
subq $-0x80, %rsi
subq $-0x80, %rcx
testq $0x8, %rcx
jne zdotu_k_840
testq $0x8, %rsi
jne zdotu_k_410
movq %rdi, %rax
sarq $0x3, %rax
jle zdotu_k_2d8
movaps -0x80(%rsi), %xmm4
movaps -0x70(%rsi), %xmm5
movaps -0x80(%rcx), %xmm8
movaps -0x70(%rcx), %xmm9
movaps -0x60(%rsi), %xmm6
movaps -0x50(%rsi), %xmm7
movaps -0x60(%rcx), %xmm10
movaps -0x50(%rcx), %xmm11
decq %rax
jle zdotu_k_1d8
nop
zdotu_k_90:
prefetcht0 0x580(%rsi)
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps -0x40(%rcx), %xmm8
mulpd %xmm4, %xmm12
movaps -0x40(%rsi), %xmm4
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
movaps -0x30(%rcx), %xmm9
mulpd %xmm5, %xmm12
movaps -0x30(%rsi), %xmm5
addpd %xmm12, %xmm3
prefetcht0 0x580(%rcx)
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movaps -0x20(%rcx), %xmm10
mulpd %xmm6, %xmm12
movaps -0x20(%rsi), %xmm6
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
movaps -0x10(%rcx), %xmm11
mulpd %xmm7, %xmm12
movaps -0x10(%rsi), %xmm7
addpd %xmm12, %xmm3
prefetcht0 0x5c0(%rsi)
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps (%rcx), %xmm8
mulpd %xmm4, %xmm12
movaps (%rsi), %xmm4
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
movaps 0x10(%rcx), %xmm9
mulpd %xmm5, %xmm12
movaps 0x10(%rsi), %xmm5
addpd %xmm12, %xmm3
prefetcht0 0x5c0(%rcx)
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movaps 0x20(%rcx), %xmm10
mulpd %xmm6, %xmm12
movaps 0x20(%rsi), %xmm6
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
movaps 0x30(%rcx), %xmm11
mulpd %xmm7, %xmm12
movaps 0x30(%rsi), %xmm7
addpd %xmm12, %xmm3
subq $-0x80, %rsi
subq $-0x80, %rcx
decq %rax
jg zdotu_k_90
nopl (%rax,%rax)
zdotu_k_1d8:
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps -0x40(%rcx), %xmm8
mulpd %xmm4, %xmm12
movaps -0x40(%rsi), %xmm4
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
movaps -0x30(%rcx), %xmm9
mulpd %xmm5, %xmm12
movaps -0x30(%rsi), %xmm5
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movaps -0x20(%rcx), %xmm10
mulpd %xmm6, %xmm12
movaps -0x20(%rsi), %xmm6
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
movaps -0x10(%rcx), %xmm11
mulpd %xmm7, %xmm12
movaps -0x10(%rsi), %xmm7
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
mulpd %xmm6, %xmm12
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
mulpd %xmm7, %xmm12
addpd %xmm12, %xmm3
subq $-0x80, %rsi
subq $-0x80, %rcx
nopl (%rax)
zdotu_k_2d8:
testq $0x4, %rdi
jle zdotu_k_380
movaps -0x80(%rsi), %xmm4
movaps -0x80(%rcx), %xmm8
movaps -0x70(%rsi), %xmm5
movaps -0x70(%rcx), %xmm9
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm3
movaps -0x60(%rsi), %xmm6
movaps -0x60(%rcx), %xmm10
movaps -0x50(%rsi), %xmm7
movaps -0x50(%rcx), %xmm11
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
mulpd %xmm6, %xmm12
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
mulpd %xmm7, %xmm12
addpd %xmm12, %xmm3
addq $0x40, %rsi
addq $0x40, %rcx
nopl (%rax)
zdotu_k_380:
testq $0x2, %rdi
jle zdotu_k_3d8
movaps -0x80(%rsi), %xmm4
movaps -0x80(%rcx), %xmm8
movaps -0x70(%rsi), %xmm5
movaps -0x70(%rcx), %xmm9
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm3
addq $0x20, %rsi
addq $0x20, %rcx
nop
zdotu_k_3d8:
testq $0x1, %rdi
jle zdotu_k_1608
movaps -0x80(%rsi), %xmm4
movaps -0x80(%rcx), %xmm8
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
jmp zdotu_k_1608
nopl (%rax)
zdotu_k_410:
movq %rdi, %rax
sarq $0x3, %rax
jle zdotu_k_6e0
movsd -0x80(%rsi), %xmm4
movhps -0x78(%rsi), %xmm4
movsd -0x70(%rsi), %xmm5
movhps -0x68(%rsi), %xmm5
movaps -0x80(%rcx), %xmm8
movaps -0x70(%rcx), %xmm9
movsd -0x60(%rsi), %xmm6
movhps -0x58(%rsi), %xmm6
movsd -0x50(%rsi), %xmm7
movhps -0x48(%rsi), %xmm7
movaps -0x60(%rcx), %xmm10
movaps -0x50(%rcx), %xmm11
decq %rax
jle zdotu_k_5d0
nop
zdotu_k_460:
prefetcht0 0x580(%rsi)
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps -0x40(%rcx), %xmm8
mulpd %xmm4, %xmm12
movsd -0x40(%rsi), %xmm4
movhps -0x38(%rsi), %xmm4
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
movaps -0x30(%rcx), %xmm9
mulpd %xmm5, %xmm12
movsd -0x30(%rsi), %xmm5
movhps -0x28(%rsi), %xmm5
addpd %xmm12, %xmm3
prefetcht0 0x580(%rcx)
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movaps -0x20(%rcx), %xmm10
mulpd %xmm6, %xmm12
movsd -0x20(%rsi), %xmm6
movhps -0x18(%rsi), %xmm6
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
movaps -0x10(%rcx), %xmm11
mulpd %xmm7, %xmm12
movsd -0x10(%rsi), %xmm7
movhps -0x8(%rsi), %xmm7
addpd %xmm12, %xmm3
prefetcht0 0x5c0(%rsi)
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps (%rcx), %xmm8
mulpd %xmm4, %xmm12
movsd (%rsi), %xmm4
movhps 0x8(%rsi), %xmm4
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
movaps 0x10(%rcx), %xmm9
mulpd %xmm5, %xmm12
movsd 0x10(%rsi), %xmm5
movhps 0x18(%rsi), %xmm5
addpd %xmm12, %xmm3
prefetcht0 0x5c0(%rcx)
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movaps 0x20(%rcx), %xmm10
mulpd %xmm6, %xmm12
movsd 0x20(%rsi), %xmm6
movhps 0x28(%rsi), %xmm6
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
movaps 0x30(%rcx), %xmm11
mulpd %xmm7, %xmm12
movsd 0x30(%rsi), %xmm7
movhps 0x38(%rsi), %xmm7
addpd %xmm12, %xmm3
subq $-0x80, %rsi
subq $-0x80, %rcx
decq %rax
jg zdotu_k_460
nopl (%rax,%rax)
zdotu_k_5d0:
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps -0x40(%rcx), %xmm8
mulpd %xmm4, %xmm12
movsd -0x40(%rsi), %xmm4
movhps -0x38(%rsi), %xmm4
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
movaps -0x30(%rcx), %xmm9
mulpd %xmm5, %xmm12
movsd -0x30(%rsi), %xmm5
movhps -0x28(%rsi), %xmm5
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movaps -0x20(%rcx), %xmm10
mulpd %xmm6, %xmm12
movsd -0x20(%rsi), %xmm6
movhps -0x18(%rsi), %xmm6
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
movaps -0x10(%rcx), %xmm11
mulpd %xmm7, %xmm12
movsd -0x10(%rsi), %xmm7
movhps -0x8(%rsi), %xmm7
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
mulpd %xmm6, %xmm12
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
mulpd %xmm7, %xmm12
addpd %xmm12, %xmm3
subq $-0x80, %rsi
subq $-0x80, %rcx
zdotu_k_6e0:
testq $0x4, %rdi
jle zdotu_k_798
movsd -0x80(%rsi), %xmm4
movhps -0x78(%rsi), %xmm4
movaps -0x80(%rcx), %xmm8
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
movsd -0x70(%rsi), %xmm5
movhps -0x68(%rsi), %xmm5
movaps -0x70(%rcx), %xmm9
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm3
movsd -0x60(%rsi), %xmm6
movhps -0x58(%rsi), %xmm6
movaps -0x60(%rcx), %xmm10
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
mulpd %xmm6, %xmm12
addpd %xmm12, %xmm1
movsd -0x50(%rsi), %xmm7
movhps -0x48(%rsi), %xmm7
movaps -0x50(%rcx), %xmm11
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
mulpd %xmm7, %xmm12
addpd %xmm12, %xmm3
addq $0x40, %rsi
addq $0x40, %rcx
nopl (%rax)
zdotu_k_798:
testq $0x2, %rdi
jle zdotu_k_800
movsd -0x80(%rsi), %xmm4
movhps -0x78(%rsi), %xmm4
movaps -0x80(%rcx), %xmm8
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
movsd -0x70(%rsi), %xmm5
movhps -0x68(%rsi), %xmm5
movaps -0x70(%rcx), %xmm9
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm3
addq $0x20, %rsi
addq $0x20, %rcx
nopl (%rax)
zdotu_k_800:
testq $0x1, %rdi
jle zdotu_k_1608
movsd -0x80(%rsi), %xmm4
movhps -0x78(%rsi), %xmm4
movaps -0x80(%rcx), %xmm8
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
jmp zdotu_k_1608
nopw (%rax,%rax)
zdotu_k_840:
testq $0x8, %rsi
jne zdotu_k_c90
movq %rdi, %rax
sarq $0x3, %rax
jle zdotu_k_b20
movsd -0x80(%rcx), %xmm4
movhps -0x78(%rcx), %xmm4
movsd -0x70(%rcx), %xmm5
movhps -0x68(%rcx), %xmm5
movaps -0x80(%rsi), %xmm8
movaps -0x70(%rsi), %xmm9
movsd -0x60(%rcx), %xmm6
movhps -0x58(%rcx), %xmm6
movsd -0x50(%rcx), %xmm7
movhps -0x48(%rcx), %xmm7
movaps -0x60(%rsi), %xmm10
movaps -0x50(%rsi), %xmm11
decq %rax
jle zdotu_k_a10
nopl (%rax,%rax)
zdotu_k_8a0:
prefetcht0 0x580(%rcx)
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps -0x40(%rsi), %xmm8
mulpd %xmm4, %xmm12
movsd -0x40(%rcx), %xmm4
movhps -0x38(%rcx), %xmm4
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
movaps -0x30(%rsi), %xmm9
mulpd %xmm5, %xmm12
movsd -0x30(%rcx), %xmm5
movhps -0x28(%rcx), %xmm5
addpd %xmm12, %xmm3
prefetcht0 0x580(%rsi)
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movaps -0x20(%rsi), %xmm10
mulpd %xmm6, %xmm12
movsd -0x20(%rcx), %xmm6
movhps -0x18(%rcx), %xmm6
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
movaps -0x10(%rsi), %xmm11
mulpd %xmm7, %xmm12
movsd -0x10(%rcx), %xmm7
movhps -0x8(%rcx), %xmm7
addpd %xmm12, %xmm3
prefetcht0 0x5c0(%rcx)
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps (%rsi), %xmm8
mulpd %xmm4, %xmm12
movsd (%rcx), %xmm4
movhps 0x8(%rcx), %xmm4
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
movaps 0x10(%rsi), %xmm9
mulpd %xmm5, %xmm12
movsd 0x10(%rcx), %xmm5
movhps 0x18(%rcx), %xmm5
addpd %xmm12, %xmm3
prefetcht0 0x5c0(%rsi)
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movaps 0x20(%rsi), %xmm10
mulpd %xmm6, %xmm12
movsd 0x20(%rcx), %xmm6
movhps 0x28(%rcx), %xmm6
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
movaps 0x30(%rsi), %xmm11
mulpd %xmm7, %xmm12
movsd 0x30(%rcx), %xmm7
movhps 0x38(%rcx), %xmm7
addpd %xmm12, %xmm3
subq $-0x80, %rsi
subq $-0x80, %rcx
decq %rax
jg zdotu_k_8a0
nopl (%rax,%rax)
zdotu_k_a10:
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps -0x40(%rsi), %xmm8
mulpd %xmm4, %xmm12
movsd -0x40(%rcx), %xmm4
movhps -0x38(%rcx), %xmm4
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
movaps -0x30(%rsi), %xmm9
mulpd %xmm5, %xmm12
movsd -0x30(%rcx), %xmm5
movhps -0x28(%rcx), %xmm5
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movaps -0x20(%rsi), %xmm10
mulpd %xmm6, %xmm12
movsd -0x20(%rcx), %xmm6
movhps -0x18(%rcx), %xmm6
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
movaps -0x10(%rsi), %xmm11
mulpd %xmm7, %xmm12
movsd -0x10(%rcx), %xmm7
movhps -0x8(%rcx), %xmm7
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
mulpd %xmm6, %xmm12
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
mulpd %xmm7, %xmm12
addpd %xmm12, %xmm3
subq $-0x80, %rsi
subq $-0x80, %rcx
zdotu_k_b20:
testq $0x4, %rdi
jle zdotu_k_bd8
movsd -0x80(%rcx), %xmm4
movhps -0x78(%rcx), %xmm4
movaps -0x80(%rsi), %xmm8
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
movsd -0x70(%rcx), %xmm5
movhps -0x68(%rcx), %xmm5
movaps -0x70(%rsi), %xmm9
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm3
movsd -0x60(%rcx), %xmm6
movhps -0x58(%rcx), %xmm6
movaps -0x60(%rsi), %xmm10
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
mulpd %xmm6, %xmm12
addpd %xmm12, %xmm1
movsd -0x50(%rcx), %xmm7
movhps -0x48(%rcx), %xmm7
movaps -0x50(%rsi), %xmm11
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
mulpd %xmm7, %xmm12
addpd %xmm12, %xmm3
addq $0x40, %rsi
addq $0x40, %rcx
nopl (%rax)
zdotu_k_bd8:
testq $0x2, %rdi
jle zdotu_k_c40
movsd -0x80(%rcx), %xmm4
movhps -0x78(%rcx), %xmm4
movaps -0x80(%rsi), %xmm8
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
movsd -0x70(%rcx), %xmm5
movhps -0x68(%rcx), %xmm5
movaps -0x70(%rsi), %xmm9
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm3
addq $0x20, %rsi
addq $0x20, %rcx
nopl (%rax)
zdotu_k_c40:
shufpd $0x1, %xmm1, %xmm1
shufpd $0x1, %xmm3, %xmm3
testq $0x1, %rdi
jle zdotu_k_1608
movsd -0x80(%rcx), %xmm4
movhps -0x78(%rcx), %xmm4
movaps -0x80(%rsi), %xmm8
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
shufpd $0x1, %xmm12, %xmm12
addpd %xmm12, %xmm1
jmp zdotu_k_1608
nopw (%rax,%rax)
zdotu_k_c90:
movhps -0x80(%rsi), %xmm4
addq $0x8, %rsi
movhps -0x80(%rcx), %xmm8
addq $0x8, %rcx
movq %rdi, %rax
sarq $0x3, %rax
jle zdotu_k_fb8
movaps -0x80(%rsi), %xmm5
movaps -0x80(%rcx), %xmm9
movaps -0x70(%rsi), %xmm6
movaps -0x70(%rcx), %xmm10
movaps -0x60(%rsi), %xmm7
movaps -0x60(%rcx), %xmm11
decq %rax
jle zdotu_k_e68
nopw (%rax,%rax)
zdotu_k_cd8:
prefetcht0 0x580(%rcx)
movsd %xmm9, %xmm8
pshufd $0x4e, %xmm8, %xmm12
movsd %xmm5, %xmm4
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps -0x50(%rcx), %xmm8
mulpd %xmm4, %xmm12
movaps -0x50(%rsi), %xmm4
addpd %xmm12, %xmm1
movsd %xmm10, %xmm9
pshufd $0x4e, %xmm9, %xmm12
movsd %xmm6, %xmm5
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm0
movaps -0x40(%rcx), %xmm9
mulpd %xmm5, %xmm12
movaps -0x40(%rsi), %xmm5
addpd %xmm12, %xmm1
prefetcht0 0x580(%rsi)
movsd %xmm11, %xmm10
pshufd $0x4e, %xmm10, %xmm12
movsd %xmm7, %xmm6
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movaps -0x30(%rcx), %xmm10
mulpd %xmm6, %xmm12
movaps -0x30(%rsi), %xmm6
addpd %xmm12, %xmm1
movsd %xmm8, %xmm11
pshufd $0x4e, %xmm11, %xmm12
movsd %xmm4, %xmm7
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm0
movaps -0x20(%rcx), %xmm11
mulpd %xmm7, %xmm12
movaps -0x20(%rsi), %xmm7
addpd %xmm12, %xmm1
prefetcht0 0x5c0(%rcx)
movsd %xmm9, %xmm8
pshufd $0x4e, %xmm8, %xmm12
movsd %xmm5, %xmm4
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps -0x10(%rcx), %xmm8
mulpd %xmm4, %xmm12
movaps -0x10(%rsi), %xmm4
addpd %xmm12, %xmm1
movsd %xmm10, %xmm9
pshufd $0x4e, %xmm9, %xmm12
movsd %xmm6, %xmm5
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm0
movaps (%rcx), %xmm9
mulpd %xmm5, %xmm12
movaps (%rsi), %xmm5
addpd %xmm12, %xmm1
prefetcht0 0x5c0(%rsi)
movsd %xmm11, %xmm10
pshufd $0x4e, %xmm10, %xmm12
movsd %xmm7, %xmm6
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movaps 0x10(%rcx), %xmm10
mulpd %xmm6, %xmm12
movaps 0x10(%rsi), %xmm6
addpd %xmm12, %xmm1
movsd %xmm8, %xmm11
pshufd $0x4e, %xmm11, %xmm12
movsd %xmm4, %xmm7
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm0
movaps 0x20(%rcx), %xmm11
mulpd %xmm7, %xmm12
movaps 0x20(%rsi), %xmm7
addpd %xmm12, %xmm1
subq $-0x80, %rsi
subq $-0x80, %rcx
decq %rax
jg zdotu_k_cd8
nopl (%rax,%rax)
zdotu_k_e68:
movsd %xmm9, %xmm8
pshufd $0x4e, %xmm8, %xmm12
movsd %xmm5, %xmm4
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps -0x50(%rcx), %xmm8
mulpd %xmm4, %xmm12
movaps -0x50(%rsi), %xmm4
addpd %xmm12, %xmm1
movsd %xmm10, %xmm9
pshufd $0x4e, %xmm9, %xmm12
movsd %xmm6, %xmm5
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm0
movaps -0x40(%rcx), %xmm9
mulpd %xmm5, %xmm12
movaps -0x40(%rsi), %xmm5
addpd %xmm12, %xmm1
movsd %xmm11, %xmm10
pshufd $0x4e, %xmm10, %xmm12
movsd %xmm7, %xmm6
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movaps -0x30(%rcx), %xmm10
mulpd %xmm6, %xmm12
movaps -0x30(%rsi), %xmm6
addpd %xmm12, %xmm1
movsd %xmm8, %xmm11
pshufd $0x4e, %xmm11, %xmm12
movsd %xmm4, %xmm7
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm0
movaps -0x20(%rcx), %xmm11
mulpd %xmm7, %xmm12
movaps -0x20(%rsi), %xmm7
addpd %xmm12, %xmm1
movsd %xmm9, %xmm8
pshufd $0x4e, %xmm8, %xmm12
movsd %xmm5, %xmm4
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movaps -0x10(%rcx), %xmm8
mulpd %xmm4, %xmm12
movaps -0x10(%rsi), %xmm4
addpd %xmm12, %xmm1
movsd %xmm10, %xmm9
pshufd $0x4e, %xmm9, %xmm12
movsd %xmm6, %xmm5
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm0
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm1
movsd %xmm11, %xmm10
pshufd $0x4e, %xmm10, %xmm12
movsd %xmm7, %xmm6
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
mulpd %xmm6, %xmm12
addpd %xmm12, %xmm1
movsd %xmm8, %xmm11
pshufd $0x4e, %xmm11, %xmm12
movsd %xmm4, %xmm7
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm0
mulpd %xmm7, %xmm12
addpd %xmm12, %xmm1
subq $-0x80, %rsi
subq $-0x80, %rcx
nopl (%rax)
zdotu_k_fb8:
testq $0x4, %rdi
jle zdotu_k_1080
movaps -0x80(%rsi), %xmm5
movaps -0x80(%rcx), %xmm9
movaps -0x70(%rsi), %xmm6
movaps -0x70(%rcx), %xmm10
movsd %xmm9, %xmm8
pshufd $0x4e, %xmm8, %xmm12
movsd %xmm5, %xmm4
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
movaps -0x60(%rsi), %xmm7
movaps -0x60(%rcx), %xmm11
movsd %xmm10, %xmm9
pshufd $0x4e, %xmm9, %xmm12
movsd %xmm6, %xmm5
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm0
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm1
movaps -0x50(%rsi), %xmm4
movaps -0x50(%rcx), %xmm8
movsd %xmm11, %xmm10
pshufd $0x4e, %xmm10, %xmm12
movsd %xmm7, %xmm6
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
mulpd %xmm6, %xmm12
addpd %xmm12, %xmm1
movsd %xmm8, %xmm11
pshufd $0x4e, %xmm11, %xmm12
movsd %xmm4, %xmm7
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm0
mulpd %xmm7, %xmm12
addpd %xmm12, %xmm1
addq $0x40, %rsi
addq $0x40, %rcx
nopl (%rax)
zdotu_k_1080:
testq $0x2, %rdi
jle zdotu_k_10f0
movaps -0x80(%rsi), %xmm5
movaps -0x80(%rcx), %xmm9
movsd %xmm9, %xmm8
pshufd $0x4e, %xmm8, %xmm12
movsd %xmm5, %xmm4
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
movaps -0x70(%rsi), %xmm6
movaps -0x70(%rcx), %xmm10
movsd %xmm10, %xmm9
pshufd $0x4e, %xmm9, %xmm12
movsd %xmm6, %xmm5
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm0
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm1
movaps %xmm6, %xmm4
movaps %xmm10, %xmm8
addq $0x20, %rsi
addq $0x20, %rcx
zdotu_k_10f0:
testq $0x1, %rdi
jle zdotu_k_1120
movlps -0x80(%rsi), %xmm4
movlps -0x80(%rcx), %xmm8
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
nopl (%rax)
zdotu_k_1120:
shufpd $0x1, %xmm0, %xmm0
shufpd $0x1, %xmm1, %xmm1
shufpd $0x1, %xmm2, %xmm2
shufpd $0x1, %xmm3, %xmm3
jmp zdotu_k_1608
nopl (%rax)
zdotu_k_1140:
movq %rdi, %rax
sarq $0x3, %rax
jle zdotu_k_1488
movsd (%rsi), %xmm4
movhps 0x8(%rsi), %xmm4
addq %rdx, %rsi
movsd (%rcx), %xmm8
movhps 0x8(%rcx), %xmm8
addq %r8, %rcx
movsd (%rsi), %xmm5
movhps 0x8(%rsi), %xmm5
addq %rdx, %rsi
movsd (%rcx), %xmm9
movhps 0x8(%rcx), %xmm9
addq %r8, %rcx
movsd (%rsi), %xmm6
movhps 0x8(%rsi), %xmm6
addq %rdx, %rsi
movsd (%rcx), %xmm10
movhps 0x8(%rcx), %xmm10
addq %r8, %rcx
movsd (%rsi), %xmm7
movhps 0x8(%rsi), %xmm7
addq %rdx, %rsi
movsd (%rcx), %xmm11
movhps 0x8(%rcx), %xmm11
addq %r8, %rcx
decq %rax
jle zdotu_k_1358
nop
zdotu_k_11b8:
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movsd (%rcx), %xmm8
movhps 0x8(%rcx), %xmm8
addq %r8, %rcx
mulpd %xmm4, %xmm12
movsd (%rsi), %xmm4
movhps 0x8(%rsi), %xmm4
addq %rdx, %rsi
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
movsd (%rcx), %xmm9
movhps 0x8(%rcx), %xmm9
addq %r8, %rcx
mulpd %xmm5, %xmm12
movsd (%rsi), %xmm5
movhps 0x8(%rsi), %xmm5
addq %rdx, %rsi
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movsd (%rcx), %xmm10
movhps 0x8(%rcx), %xmm10
addq %r8, %rcx
mulpd %xmm6, %xmm12
movsd (%rsi), %xmm6
movhps 0x8(%rsi), %xmm6
addq %rdx, %rsi
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
movsd (%rcx), %xmm11
movhps 0x8(%rcx), %xmm11
addq %r8, %rcx
mulpd %xmm7, %xmm12
movsd (%rsi), %xmm7
movhps 0x8(%rsi), %xmm7
addq %rdx, %rsi
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movsd (%rcx), %xmm8
movhps 0x8(%rcx), %xmm8
addq %r8, %rcx
mulpd %xmm4, %xmm12
movsd (%rsi), %xmm4
movhps 0x8(%rsi), %xmm4
addq %rdx, %rsi
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
movsd (%rcx), %xmm9
movhps 0x8(%rcx), %xmm9
addq %r8, %rcx
mulpd %xmm5, %xmm12
movsd (%rsi), %xmm5
movhps 0x8(%rsi), %xmm5
addq %rdx, %rsi
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movsd (%rcx), %xmm10
movhps 0x8(%rcx), %xmm10
addq %r8, %rcx
mulpd %xmm6, %xmm12
movsd (%rsi), %xmm6
movhps 0x8(%rsi), %xmm6
addq %rdx, %rsi
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
movsd (%rcx), %xmm11
movhps 0x8(%rcx), %xmm11
addq %r8, %rcx
mulpd %xmm7, %xmm12
movsd (%rsi), %xmm7
movhps 0x8(%rsi), %xmm7
addq %rdx, %rsi
addpd %xmm12, %xmm3
decq %rax
jg zdotu_k_11b8
nopl (%rax)
zdotu_k_1358:
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
movsd (%rcx), %xmm8
movhps 0x8(%rcx), %xmm8
addq %r8, %rcx
mulpd %xmm4, %xmm12
movsd (%rsi), %xmm4
movhps 0x8(%rsi), %xmm4
addq %rdx, %rsi
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
movsd (%rcx), %xmm9
movhps 0x8(%rcx), %xmm9
addq %r8, %rcx
mulpd %xmm5, %xmm12
movsd (%rsi), %xmm5
movhps 0x8(%rsi), %xmm5
addq %rdx, %rsi
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
movsd (%rcx), %xmm10
movhps 0x8(%rcx), %xmm10
addq %r8, %rcx
mulpd %xmm6, %xmm12
movsd (%rsi), %xmm6
movhps 0x8(%rsi), %xmm6
addq %rdx, %rsi
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
movsd (%rcx), %xmm11
movhps 0x8(%rcx), %xmm11
addq %r8, %rcx
mulpd %xmm7, %xmm12
movsd (%rsi), %xmm7
movhps 0x8(%rsi), %xmm7
addq %rdx, %rsi
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm3
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
mulpd %xmm6, %xmm12
addpd %xmm12, %xmm1
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
mulpd %xmm7, %xmm12
addpd %xmm12, %xmm3
zdotu_k_1488:
testq $0x4, %rdi
jle zdotu_k_1560
movsd (%rsi), %xmm4
movhps 0x8(%rsi), %xmm4
addq %rdx, %rsi
movsd (%rcx), %xmm8
movhps 0x8(%rcx), %xmm8
addq %r8, %rcx
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
movsd (%rsi), %xmm5
movhps 0x8(%rsi), %xmm5
addq %rdx, %rsi
movsd (%rcx), %xmm9
movhps 0x8(%rcx), %xmm9
addq %r8, %rcx
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm3
movsd (%rsi), %xmm6
movhps 0x8(%rsi), %xmm6
addq %rdx, %rsi
movsd (%rcx), %xmm10
movhps 0x8(%rcx), %xmm10
addq %r8, %rcx
pshufd $0x4e, %xmm10, %xmm12
mulpd %xmm6, %xmm10
addpd %xmm10, %xmm0
mulpd %xmm6, %xmm12
addpd %xmm12, %xmm1
movsd (%rsi), %xmm7
movhps 0x8(%rsi), %xmm7
addq %rdx, %rsi
movsd (%rcx), %xmm11
movhps 0x8(%rcx), %xmm11
addq %r8, %rcx
pshufd $0x4e, %xmm11, %xmm12
mulpd %xmm7, %xmm11
addpd %xmm11, %xmm2
mulpd %xmm7, %xmm12
addpd %xmm12, %xmm3
nopl (%rax)
zdotu_k_1560:
testq $0x2, %rdi
jle zdotu_k_15d0
movsd (%rsi), %xmm4
movhps 0x8(%rsi), %xmm4
addq %rdx, %rsi
movsd (%rcx), %xmm8
movhps 0x8(%rcx), %xmm8
addq %r8, %rcx
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
movsd (%rsi), %xmm5
movhps 0x8(%rsi), %xmm5
addq %rdx, %rsi
movsd (%rcx), %xmm9
movhps 0x8(%rcx), %xmm9
addq %r8, %rcx
pshufd $0x4e, %xmm9, %xmm12
mulpd %xmm5, %xmm9
addpd %xmm9, %xmm2
mulpd %xmm5, %xmm12
addpd %xmm12, %xmm3
nopl (%rax)
zdotu_k_15d0:
testq $0x1, %rdi
jle zdotu_k_1608
movsd (%rsi), %xmm4
movhps 0x8(%rsi), %xmm4
movsd (%rcx), %xmm8
movhps 0x8(%rcx), %xmm8
pshufd $0x4e, %xmm8, %xmm12
mulpd %xmm4, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm4, %xmm12
addpd %xmm12, %xmm1
nopl (%rax)
zdotu_k_1608:
addpd %xmm2, %xmm0
addpd %xmm3, %xmm1
pshufd $0x4e, %xmm0, %xmm2
pshufd $0x4e, %xmm1, %xmm3
zdotu_k_161a:
subsd %xmm2, %xmm0
addsd %xmm3, %xmm1
retq
