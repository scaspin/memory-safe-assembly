drot_k:
leaq (,%rdx,8), %rdx
leaq (,%r8,8), %r8
pshufd $0x44, %xmm0, %xmm14
pshufd $0x44, %xmm1, %xmm15
cmpq $0x0, %rdi
jle drot_k_be0
cmpq $0x8, %rdx
jne drot_k_ac0
cmpq $0x8, %r8
jne drot_k_ac0
testq $0x8, %rsi
je drot_k_88
movsd (%rcx), %xmm1
movsd (%rsi), %xmm0
movaps %xmm1, %xmm2
movaps %xmm0, %xmm3
mulsd %xmm14, %xmm0
mulsd %xmm15, %xmm1
mulsd %xmm14, %xmm2
mulsd %xmm15, %xmm3
addsd %xmm1, %xmm0
subsd %xmm3, %xmm2
movsd %xmm0, (%rsi)
movsd %xmm2, (%rcx)
addq $0x8, %rsi
addq $0x8, %rcx
decq %rdi
jle drot_k_be0
nop
drot_k_88:
testq $0x8, %rcx
jne drot_k_640
movq %rdi, %rax
sarq $0x4, %rax
jle drot_k_458
movaps (%rcx), %xmm1
movaps 0x10(%rcx), %xmm3
movaps 0x20(%rcx), %xmm9
movaps 0x30(%rcx), %xmm11
movaps (%rsi), %xmm0
movaps 0x10(%rsi), %xmm2
movaps 0x20(%rsi), %xmm8
movaps 0x30(%rsi), %xmm10
decq %rax
jle drot_k_2c8
nopl (%rax)
drot_k_d0:
prefetcht0 0x580(%rsi)
movaps %xmm1, %xmm4
mulpd %xmm15, %xmm1
movaps %xmm3, %xmm6
mulpd %xmm15, %xmm3
movaps %xmm0, %xmm5
mulpd %xmm14, %xmm0
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm2
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm0
movaps 0x40(%rcx), %xmm1
addpd %xmm3, %xmm2
movaps 0x50(%rcx), %xmm3
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
prefetcht0 0x580(%rcx)
movaps %xmm0, (%rsi)
movaps 0x40(%rsi), %xmm0
movaps %xmm2, 0x10(%rsi)
movaps 0x50(%rsi), %xmm2
movaps %xmm4, (%rcx)
movaps %xmm6, 0x10(%rcx)
movaps %xmm9, %xmm4
mulpd %xmm15, %xmm9
movaps %xmm8, %xmm5
mulpd %xmm14, %xmm8
movaps %xmm11, %xmm6
mulpd %xmm15, %xmm11
movaps %xmm10, %xmm7
mulpd %xmm14, %xmm10
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm9, %xmm8
movaps 0x60(%rcx), %xmm9
addpd %xmm11, %xmm10
movaps 0x70(%rcx), %xmm11
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm8, 0x20(%rsi)
movaps 0x60(%rsi), %xmm8
movaps %xmm10, 0x30(%rsi)
movaps 0x70(%rsi), %xmm10
movaps %xmm4, 0x20(%rcx)
movaps %xmm6, 0x30(%rcx)
prefetcht0 0x5c0(%rsi)
movaps %xmm1, %xmm4
mulpd %xmm15, %xmm1
movaps %xmm3, %xmm6
mulpd %xmm15, %xmm3
movaps %xmm0, %xmm5
mulpd %xmm14, %xmm0
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm2
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm0
movaps 0x80(%rcx), %xmm1
addpd %xmm3, %xmm2
movaps 0x90(%rcx), %xmm3
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, 0x40(%rsi)
movaps 0x80(%rsi), %xmm0
movaps %xmm2, 0x50(%rsi)
movaps 0x90(%rsi), %xmm2
movaps %xmm4, 0x40(%rcx)
movaps %xmm6, 0x50(%rcx)
prefetcht0 0x5c0(%rcx)
movaps %xmm9, %xmm4
mulpd %xmm15, %xmm9
movaps %xmm8, %xmm5
mulpd %xmm14, %xmm8
movaps %xmm11, %xmm6
mulpd %xmm15, %xmm11
movaps %xmm10, %xmm7
mulpd %xmm14, %xmm10
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm9, %xmm8
movaps 0xa0(%rcx), %xmm9
addpd %xmm11, %xmm10
movaps 0xb0(%rcx), %xmm11
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm8, 0x60(%rsi)
movaps 0xa0(%rsi), %xmm8
movaps %xmm10, 0x70(%rsi)
movaps 0xb0(%rsi), %xmm10
movaps %xmm4, 0x60(%rcx)
movaps %xmm6, 0x70(%rcx)
addq $0x80, %rsi
addq $0x80, %rcx
decq %rax
jg drot_k_d0
nopl (%rax)
drot_k_2c8:
movaps %xmm1, %xmm4
mulpd %xmm15, %xmm1
movaps %xmm3, %xmm6
mulpd %xmm15, %xmm3
movaps %xmm0, %xmm5
mulpd %xmm14, %xmm0
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm2
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm0
movaps 0x40(%rcx), %xmm1
addpd %xmm3, %xmm2
movaps 0x50(%rcx), %xmm3
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, (%rsi)
movaps 0x40(%rsi), %xmm0
movaps %xmm2, 0x10(%rsi)
movaps 0x50(%rsi), %xmm2
movaps %xmm4, (%rcx)
movaps %xmm6, 0x10(%rcx)
movaps %xmm9, %xmm4
mulpd %xmm15, %xmm9
movaps %xmm8, %xmm5
mulpd %xmm14, %xmm8
movaps %xmm11, %xmm6
mulpd %xmm15, %xmm11
movaps %xmm10, %xmm7
mulpd %xmm14, %xmm10
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm9, %xmm8
movaps 0x60(%rcx), %xmm9
addpd %xmm11, %xmm10
movaps 0x70(%rcx), %xmm11
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm8, 0x20(%rsi)
movaps 0x60(%rsi), %xmm8
movaps %xmm10, 0x30(%rsi)
movaps 0x70(%rsi), %xmm10
movaps %xmm4, 0x20(%rcx)
movaps %xmm6, 0x30(%rcx)
movaps %xmm1, %xmm4
mulpd %xmm15, %xmm1
movaps %xmm3, %xmm6
mulpd %xmm15, %xmm3
movaps %xmm0, %xmm5
mulpd %xmm14, %xmm0
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm2
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm0
addpd %xmm3, %xmm2
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, 0x40(%rsi)
movaps %xmm2, 0x50(%rsi)
movaps %xmm4, 0x40(%rcx)
movaps %xmm6, 0x50(%rcx)
movaps %xmm9, %xmm4
mulpd %xmm15, %xmm9
movaps %xmm8, %xmm5
mulpd %xmm14, %xmm8
movaps %xmm11, %xmm6
mulpd %xmm15, %xmm11
movaps %xmm10, %xmm7
mulpd %xmm14, %xmm10
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm9, %xmm8
addpd %xmm11, %xmm10
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm8, 0x60(%rsi)
movaps %xmm10, 0x70(%rsi)
movaps %xmm4, 0x60(%rcx)
movaps %xmm6, 0x70(%rcx)
addq $0x80, %rsi
addq $0x80, %rcx
drot_k_458:
testq $0xf, %rdi
jle drot_k_be0
testq $0x8, %rdi
jle drot_k_540
movaps (%rcx), %xmm1
movaps (%rsi), %xmm0
movaps 0x10(%rcx), %xmm3
movaps 0x10(%rsi), %xmm2
movaps %xmm1, %xmm4
movaps %xmm0, %xmm5
movaps %xmm3, %xmm6
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm1
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm3
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm0
addpd %xmm3, %xmm2
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, (%rsi)
movaps %xmm2, 0x10(%rsi)
movaps %xmm4, (%rcx)
movaps %xmm6, 0x10(%rcx)
movaps 0x20(%rcx), %xmm1
movaps 0x20(%rsi), %xmm0
movaps 0x30(%rcx), %xmm3
movaps 0x30(%rsi), %xmm2
movaps %xmm1, %xmm4
movaps %xmm0, %xmm5
movaps %xmm3, %xmm6
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm1
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm3
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm0
addpd %xmm3, %xmm2
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, 0x20(%rsi)
movaps %xmm2, 0x30(%rsi)
movaps %xmm4, 0x20(%rcx)
movaps %xmm6, 0x30(%rcx)
addq $0x40, %rsi
addq $0x40, %rcx
nop
drot_k_540:
testq $0x4, %rdi
jle drot_k_5b8
movaps (%rcx), %xmm1
movaps (%rsi), %xmm0
movaps 0x10(%rcx), %xmm3
movaps 0x10(%rsi), %xmm2
movaps %xmm1, %xmm4
movaps %xmm0, %xmm5
movaps %xmm3, %xmm6
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm1
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm3
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm0
addpd %xmm3, %xmm2
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, (%rsi)
movaps %xmm2, 0x10(%rsi)
movaps %xmm4, (%rcx)
movaps %xmm6, 0x10(%rcx)
addq $0x20, %rsi
addq $0x20, %rcx
nopl (%rax)
drot_k_5b8:
testq $0x2, %rdi
jle drot_k_5f8
movaps (%rcx), %xmm1
movaps (%rsi), %xmm0
movaps %xmm1, %xmm2
movaps %xmm0, %xmm3
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm1
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm3
addpd %xmm1, %xmm0
subpd %xmm3, %xmm2
movaps %xmm0, (%rsi)
movaps %xmm2, (%rcx)
addq $0x10, %rsi
addq $0x10, %rcx
nop
drot_k_5f8:
testq $0x1, %rdi
jle drot_k_be0
movsd (%rcx), %xmm1
movsd (%rsi), %xmm0
movaps %xmm1, %xmm2
movaps %xmm0, %xmm3
mulsd %xmm14, %xmm0
mulsd %xmm15, %xmm1
mulsd %xmm14, %xmm2
mulsd %xmm15, %xmm3
addsd %xmm1, %xmm0
subsd %xmm3, %xmm2
movsd %xmm0, (%rsi)
movsd %xmm2, (%rcx)
jmp drot_k_be0
nopl (%rax)
drot_k_640:
movaps -0x8(%rcx), %xmm1
movq %rdi, %rax
sarq $0x4, %rax
jle drot_k_880
nopl (%rax)
drot_k_658:
prefetcht0 0x580(%rsi)
movaps 0x8(%rcx), %xmm3
movaps 0x18(%rcx), %xmm8
movaps (%rsi), %xmm0
movaps 0x10(%rsi), %xmm2
shufpd $0x1, %xmm3, %xmm1
shufpd $0x1, %xmm8, %xmm3
movaps %xmm1, %xmm4
movaps %xmm0, %xmm5
movaps %xmm3, %xmm6
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm1
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm3
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm0
addpd %xmm3, %xmm2
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, (%rsi)
movaps %xmm2, 0x10(%rsi)
movlpd %xmm4, (%rcx)
movhps %xmm4, 0x8(%rcx)
movlpd %xmm6, 0x10(%rcx)
movhps %xmm6, 0x18(%rcx)
prefetcht0 0x580(%rcx)
movaps 0x28(%rcx), %xmm9
movaps 0x38(%rcx), %xmm1
movaps 0x20(%rsi), %xmm0
movaps 0x30(%rsi), %xmm2
shufpd $0x1, %xmm9, %xmm8
shufpd $0x1, %xmm1, %xmm9
movaps %xmm8, %xmm4
movaps %xmm0, %xmm5
movaps %xmm9, %xmm6
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm9
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm8, %xmm0
addpd %xmm9, %xmm2
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, 0x20(%rsi)
movaps %xmm2, 0x30(%rsi)
movlpd %xmm4, 0x20(%rcx)
movhps %xmm4, 0x28(%rcx)
movlpd %xmm6, 0x30(%rcx)
movhps %xmm6, 0x38(%rcx)
prefetcht0 0x5c0(%rsi)
movaps 0x48(%rcx), %xmm3
movaps 0x58(%rcx), %xmm8
movaps 0x40(%rsi), %xmm0
movaps 0x50(%rsi), %xmm2
shufpd $0x1, %xmm3, %xmm1
shufpd $0x1, %xmm8, %xmm3
movaps %xmm1, %xmm4
movaps %xmm0, %xmm5
movaps %xmm3, %xmm6
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm1
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm3
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm0
addpd %xmm3, %xmm2
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, 0x40(%rsi)
movaps %xmm2, 0x50(%rsi)
movlpd %xmm4, 0x40(%rcx)
movhps %xmm4, 0x48(%rcx)
movlpd %xmm6, 0x50(%rcx)
movhps %xmm6, 0x58(%rcx)
prefetcht0 0x5c0(%rcx)
movaps 0x68(%rcx), %xmm9
movaps 0x78(%rcx), %xmm1
movaps 0x60(%rsi), %xmm0
movaps 0x70(%rsi), %xmm2
shufpd $0x1, %xmm9, %xmm8
shufpd $0x1, %xmm1, %xmm9
movaps %xmm8, %xmm4
movaps %xmm0, %xmm5
movaps %xmm9, %xmm6
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm9
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm8, %xmm0
addpd %xmm9, %xmm2
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, 0x60(%rsi)
movaps %xmm2, 0x70(%rsi)
movlpd %xmm4, 0x60(%rcx)
movhps %xmm4, 0x68(%rcx)
movlpd %xmm6, 0x70(%rcx)
movhps %xmm6, 0x78(%rcx)
addq $0x80, %rsi
addq $0x80, %rcx
decq %rax
jg drot_k_658
nopw (%rax,%rax)
drot_k_880:
testq $0xf, %rdi
jle drot_k_be0
testq $0x8, %rdi
jle drot_k_998
movaps 0x8(%rcx), %xmm3
movaps 0x18(%rcx), %xmm8
movaps (%rsi), %xmm0
movaps 0x10(%rsi), %xmm2
shufpd $0x1, %xmm3, %xmm1
shufpd $0x1, %xmm8, %xmm3
movaps %xmm1, %xmm4
movaps %xmm0, %xmm5
movaps %xmm3, %xmm6
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm1
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm3
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm0
addpd %xmm3, %xmm2
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, (%rsi)
movaps %xmm2, 0x10(%rsi)
movlpd %xmm4, (%rcx)
movhps %xmm4, 0x8(%rcx)
movlpd %xmm6, 0x10(%rcx)
movhps %xmm6, 0x18(%rcx)
movaps 0x28(%rcx), %xmm9
movaps 0x38(%rcx), %xmm1
movaps 0x20(%rsi), %xmm0
movaps 0x30(%rsi), %xmm2
shufpd $0x1, %xmm9, %xmm8
shufpd $0x1, %xmm1, %xmm9
movaps %xmm8, %xmm4
movaps %xmm0, %xmm5
movaps %xmm9, %xmm6
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm9
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm8, %xmm0
addpd %xmm9, %xmm2
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, 0x20(%rsi)
movaps %xmm2, 0x30(%rsi)
movlpd %xmm4, 0x20(%rcx)
movhps %xmm4, 0x28(%rcx)
movlpd %xmm6, 0x30(%rcx)
movhps %xmm6, 0x38(%rcx)
addq $0x40, %rsi
addq $0x40, %rcx
drot_k_998:
testq $0x4, %rdi
jle drot_k_a28
movaps 0x8(%rcx), %xmm3
movaps 0x18(%rcx), %xmm8
movaps (%rsi), %xmm0
movaps 0x10(%rsi), %xmm2
shufpd $0x1, %xmm3, %xmm1
shufpd $0x1, %xmm8, %xmm3
movaps %xmm1, %xmm4
movaps %xmm0, %xmm5
movaps %xmm3, %xmm6
movaps %xmm2, %xmm7
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm1
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm3
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm5
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm0
addpd %xmm3, %xmm2
subpd %xmm5, %xmm4
subpd %xmm7, %xmm6
movaps %xmm0, (%rsi)
movaps %xmm2, 0x10(%rsi)
movlpd %xmm4, (%rcx)
movhps %xmm4, 0x8(%rcx)
movlpd %xmm6, 0x10(%rcx)
movhps %xmm6, 0x18(%rcx)
movaps %xmm8, %xmm1
addq $0x20, %rsi
addq $0x20, %rcx
drot_k_a28:
testq $0x2, %rdi
jle drot_k_a78
movaps 0x8(%rcx), %xmm4
movaps (%rsi), %xmm0
shufpd $0x1, %xmm4, %xmm1
movaps %xmm1, %xmm2
movaps %xmm0, %xmm3
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm1
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm3
addpd %xmm1, %xmm0
subpd %xmm3, %xmm2
movaps %xmm0, (%rsi)
movlpd %xmm2, (%rcx)
movhps %xmm2, 0x8(%rcx)
movaps %xmm4, %xmm1
addq $0x10, %rsi
addq $0x10, %rcx
nopl (%rax)
drot_k_a78:
testq $0x1, %rdi
jle drot_k_be0
unpckhpd %xmm1, %xmm1
movsd (%rsi), %xmm0
movaps %xmm1, %xmm2
movaps %xmm0, %xmm3
mulsd %xmm14, %xmm0
mulsd %xmm15, %xmm1
mulsd %xmm14, %xmm2
mulsd %xmm15, %xmm3
addsd %xmm1, %xmm0
subsd %xmm3, %xmm2
movsd %xmm0, (%rsi)
movsd %xmm2, (%rcx)
jmp drot_k_be0
nopl (%rax)
drot_k_ac0:
movq %rdi, %rax
cmpq $0x0, %rdx
je drot_k_ba0
cmpq $0x0, %r8
je drot_k_ba0
sarq $0x2, %rax
jle drot_k_b90
nopl (%rax)
drot_k_ae8:
movsd (%rcx), %xmm1
movhps (%rcx,%r8), %xmm1
movsd (%rsi), %xmm0
movhps (%rsi,%rdx), %xmm0
movaps %xmm1, %xmm2
movaps %xmm0, %xmm3
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm1
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm3
addpd %xmm1, %xmm0
subpd %xmm3, %xmm2
movlpd %xmm0, (%rsi)
movhps %xmm0, (%rsi,%rdx)
movlpd %xmm2, (%rcx)
movhps %xmm2, (%rcx,%r8)
leaq (%rsi,%rdx,2), %rsi
leaq (%rcx,%r8,2), %rcx
movsd (%rcx), %xmm1
movhps (%rcx,%r8), %xmm1
movsd (%rsi), %xmm0
movhps (%rsi,%rdx), %xmm0
movaps %xmm1, %xmm2
movaps %xmm0, %xmm3
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm1
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm3
addpd %xmm1, %xmm0
subpd %xmm3, %xmm2
movlpd %xmm0, (%rsi)
movhps %xmm0, (%rsi,%rdx)
movlpd %xmm2, (%rcx)
movhps %xmm2, (%rcx,%r8)
leaq (%rsi,%rdx,2), %rsi
leaq (%rcx,%r8,2), %rcx
decq %rax
jg drot_k_ae8
nopl (%rax)
drot_k_b90:
movq %rdi, %rax
andq $0x3, %rax
jle drot_k_be0
nopl (%rax)
drot_k_ba0:
movsd (%rcx), %xmm1
movsd (%rsi), %xmm0
movaps %xmm1, %xmm2
movaps %xmm0, %xmm3
mulsd %xmm14, %xmm0
mulsd %xmm15, %xmm1
mulsd %xmm14, %xmm2
mulsd %xmm15, %xmm3
addsd %xmm1, %xmm0
subsd %xmm3, %xmm2
movsd %xmm0, (%rsi)
movsd %xmm2, (%rcx)
addq %rdx, %rsi
addq %r8, %rcx
decq %rax
jg drot_k_ba0
nopl (%rax)
drot_k_be0:
retq
