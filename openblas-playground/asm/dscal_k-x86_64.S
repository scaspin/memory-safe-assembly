dscal_k:
movq 0x18(%rsp), %r9
testq %rdi, %rdi
jle dscal_k_550
leaq (,%r8,8), %r8
xorps %xmm1, %xmm1
comisd %xmm0, %xmm1
jne dscal_k_1f0
jp dscal_k_1f0
cmpq $0x1, %r9
je dscal_k_1f0
cmpq $0x8, %r8
jne dscal_k_120
testq $0xf, %rcx
je dscal_k_58
movsd %xmm1, (%rcx)
addq $0x8, %rcx
decq %rdi
jle dscal_k_550
nop
dscal_k_58:
movq %rdi, %rax
sarq $0x4, %rax
jle dscal_k_b0
nopw %cs:(%rax,%rax)
nopl (%rax,%rax)
dscal_k_70:
prefetcht0 0x580(%rcx)
movaps %xmm1, (%rcx)
movaps %xmm1, 0x10(%rcx)
movaps %xmm1, 0x20(%rcx)
movaps %xmm1, 0x30(%rcx)
prefetcht0 0x5c0(%rcx)
movaps %xmm1, 0x40(%rcx)
movaps %xmm1, 0x50(%rcx)
movaps %xmm1, 0x60(%rcx)
movaps %xmm1, 0x70(%rcx)
addq $0x80, %rcx
decq %rax
jg dscal_k_70
nopl (%rax)
dscal_k_b0:
testq $0xf, %rdi
je dscal_k_550
testq $0x8, %rdi
je dscal_k_e0
movaps %xmm1, (%rcx)
movaps %xmm1, 0x10(%rcx)
movaps %xmm1, 0x20(%rcx)
movaps %xmm1, 0x30(%rcx)
addq $0x40, %rcx
nopl (%rax)
dscal_k_e0:
testq $0x4, %rdi
je dscal_k_f8
movaps %xmm1, (%rcx)
movaps %xmm1, 0x10(%rcx)
addq $0x20, %rcx
nopl (%rax)
dscal_k_f8:
testq $0x2, %rdi
je dscal_k_108
movaps %xmm1, (%rcx)
addq $0x10, %rcx
dscal_k_108:
testq $0x1, %rdi
je dscal_k_550
movsd %xmm1, (%rcx)
jmp dscal_k_550
nop
dscal_k_120:
movq %rdi, %rax
sarq $0x3, %rax
jle dscal_k_180
nopl (%rax)
dscal_k_130:
prefetcht0 0x580(%rcx)
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm1, (%rcx)
addq %r8, %rcx
decq %rax
jg dscal_k_130
nopw %cs:(%rax,%rax)
nop
dscal_k_180:
testq $0x7, %rdi
je dscal_k_550
testq $0x4, %rdi
je dscal_k_1b8
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm1, (%rcx)
addq %r8, %rcx
nopw (%rax,%rax)
dscal_k_1b8:
testq $0x2, %rdi
je dscal_k_1d0
movsd %xmm1, (%rcx)
addq %r8, %rcx
movsd %xmm1, (%rcx)
addq %r8, %rcx
nop
dscal_k_1d0:
testq $0x1, %rdi
je dscal_k_550
movsd %xmm1, (%rcx)
jmp dscal_k_550
nopw %cs:(%rax,%rax)
dscal_k_1f0:
unpcklpd %xmm0, %xmm0
cmpq $0x8, %r8
jne dscal_k_3e0
testq $0x8, %rcx
je dscal_k_220
movsd (%rcx), %xmm1
mulsd %xmm0, %xmm1
movsd %xmm1, (%rcx)
addq $0x8, %rcx
decq %rdi
jle dscal_k_550
dscal_k_220:
subq $-0x80, %rcx
movq %rdi, %rax
sarq $0x4, %rax
jle dscal_k_328
movaps -0x80(%rcx), %xmm1
movaps -0x70(%rcx), %xmm2
movaps -0x60(%rcx), %xmm3
movaps -0x50(%rcx), %xmm4
movaps -0x40(%rcx), %xmm5
movaps -0x30(%rcx), %xmm6
movaps -0x20(%rcx), %xmm7
movaps -0x10(%rcx), %xmm8
decq %rax
jle dscal_k_2e0
nopl (%rax,%rax)
dscal_k_260:
prefetcht0 0x580(%rcx)
mulpd %xmm0, %xmm1
movaps %xmm1, -0x80(%rcx)
movaps (%rcx), %xmm1
mulpd %xmm0, %xmm2
movaps %xmm2, -0x70(%rcx)
movaps 0x10(%rcx), %xmm2
mulpd %xmm0, %xmm3
movaps %xmm3, -0x60(%rcx)
movaps 0x20(%rcx), %xmm3
mulpd %xmm0, %xmm4
movaps %xmm4, -0x50(%rcx)
movaps 0x30(%rcx), %xmm4
prefetcht0 0x5c0(%rcx)
mulpd %xmm0, %xmm5
movaps %xmm5, -0x40(%rcx)
movaps 0x40(%rcx), %xmm5
mulpd %xmm0, %xmm6
movaps %xmm6, -0x30(%rcx)
movaps 0x50(%rcx), %xmm6
mulpd %xmm0, %xmm7
movaps %xmm7, -0x20(%rcx)
movaps 0x60(%rcx), %xmm7
mulpd %xmm0, %xmm8
movaps %xmm8, -0x10(%rcx)
movaps 0x70(%rcx), %xmm8
subq $-0x80, %rcx
decq %rax
jg dscal_k_260
nopl (%rax)
dscal_k_2e0:
mulpd %xmm0, %xmm1
movaps %xmm1, -0x80(%rcx)
mulpd %xmm0, %xmm2
movaps %xmm2, -0x70(%rcx)
mulpd %xmm0, %xmm3
movaps %xmm3, -0x60(%rcx)
mulpd %xmm0, %xmm4
movaps %xmm4, -0x50(%rcx)
mulpd %xmm0, %xmm5
movaps %xmm5, -0x40(%rcx)
mulpd %xmm0, %xmm6
movaps %xmm6, -0x30(%rcx)
mulpd %xmm0, %xmm7
movaps %xmm7, -0x20(%rcx)
mulpd %xmm0, %xmm8
movaps %xmm8, -0x10(%rcx)
subq $-0x80, %rcx
nop
dscal_k_328:
testq $0xf, %rdi
je dscal_k_550
testq $0x8, %rdi
je dscal_k_378
movaps -0x80(%rcx), %xmm1
movaps -0x70(%rcx), %xmm2
movaps -0x60(%rcx), %xmm3
movaps -0x50(%rcx), %xmm4
mulpd %xmm0, %xmm1
movaps %xmm1, -0x80(%rcx)
mulpd %xmm0, %xmm2
movaps %xmm2, -0x70(%rcx)
mulpd %xmm0, %xmm3
movaps %xmm3, -0x60(%rcx)
mulpd %xmm0, %xmm4
movaps %xmm4, -0x50(%rcx)
addq $0x40, %rcx
nopw (%rax,%rax)
dscal_k_378:
testq $0x4, %rdi
je dscal_k_3a0
movaps -0x80(%rcx), %xmm1
movaps -0x70(%rcx), %xmm2
mulpd %xmm0, %xmm1
movaps %xmm1, -0x80(%rcx)
mulpd %xmm0, %xmm2
movaps %xmm2, -0x70(%rcx)
addq $0x20, %rcx
nopl (%rax)
dscal_k_3a0:
testq $0x2, %rdi
je dscal_k_3c0
movaps -0x80(%rcx), %xmm1
mulpd %xmm0, %xmm1
movaps %xmm1, -0x80(%rcx)
addq $0x10, %rcx
nopl (%rax)
dscal_k_3c0:
testq $0x1, %rdi
je dscal_k_550
movsd -0x80(%rcx), %xmm1
mulsd %xmm0, %xmm1
movsd %xmm1, -0x80(%rcx)
jmp dscal_k_550
dscal_k_3e0:
movq %rcx, %r10
movq %rdi, %rax
sarq $0x3, %rax
jle dscal_k_4a0
dscal_k_3f0:
prefetcht0 0x5c0(%rcx)
movsd (%rcx), %xmm1
addq %r8, %rcx
movsd (%rcx), %xmm2
addq %r8, %rcx
movsd (%rcx), %xmm3
addq %r8, %rcx
movsd (%rcx), %xmm4
addq %r8, %rcx
movsd (%rcx), %xmm5
addq %r8, %rcx
movsd (%rcx), %xmm6
addq %r8, %rcx
movsd (%rcx), %xmm7
addq %r8, %rcx
movsd (%rcx), %xmm8
addq %r8, %rcx
mulsd %xmm0, %xmm1
mulsd %xmm0, %xmm2
mulsd %xmm0, %xmm3
mulsd %xmm0, %xmm4
mulsd %xmm0, %xmm5
mulsd %xmm0, %xmm6
mulsd %xmm0, %xmm7
mulsd %xmm0, %xmm8
movsd %xmm1, (%r10)
addq %r8, %r10
movsd %xmm2, (%r10)
addq %r8, %r10
movsd %xmm3, (%r10)
addq %r8, %r10
movsd %xmm4, (%r10)
addq %r8, %r10
movsd %xmm5, (%r10)
addq %r8, %r10
movsd %xmm6, (%r10)
addq %r8, %r10
movsd %xmm7, (%r10)
addq %r8, %r10
movsd %xmm8, (%r10)
addq %r8, %r10
decq %rax
jg dscal_k_3f0
nopw (%rax,%rax)
dscal_k_4a0:
testq $0x7, %rdi
je dscal_k_550
testq $0x4, %rdi
je dscal_k_508
movsd (%rcx), %xmm1
addq %r8, %rcx
movsd (%rcx), %xmm2
addq %r8, %rcx
movsd (%rcx), %xmm3
addq %r8, %rcx
movsd (%rcx), %xmm4
addq %r8, %rcx
mulsd %xmm0, %xmm1
mulsd %xmm0, %xmm2
mulsd %xmm0, %xmm3
mulsd %xmm0, %xmm4
movsd %xmm1, (%r10)
addq %r8, %r10
movsd %xmm2, (%r10)
addq %r8, %r10
movsd %xmm3, (%r10)
addq %r8, %r10
movsd %xmm4, (%r10)
addq %r8, %r10
nopw (%rax,%rax)
dscal_k_508:
testq $0x2, %rdi
je dscal_k_538
movsd (%rcx), %xmm1
addq %r8, %rcx
movsd (%rcx), %xmm2
addq %r8, %rcx
mulsd %xmm0, %xmm1
mulsd %xmm0, %xmm2
movsd %xmm1, (%r10)
addq %r8, %r10
movsd %xmm2, (%r10)
addq %r8, %r10
nop
dscal_k_538:
testq $0x1, %rdi
je dscal_k_550
movsd (%rcx), %xmm1
mulsd %xmm0, %xmm1
movsd %xmm1, (%rcx)
nopl (%rax)
dscal_k_550:
xorq %rax, %rax
retq
