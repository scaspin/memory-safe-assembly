dgemv_n:
subq $0x80, %rsp
movq %rbx, (%rsp)
movq %rbp, 0x8(%rsp)
movq %r12, 0x10(%rsp)
movq %r13, 0x18(%rsp)
movq %r14, 0x20(%rsp)
movq %r15, 0x28(%rsp)
movq %rdi, %r10
movq %rsi, %r11
movq %rcx, %r12
movq %r8, %r8
movsd %xmm0, 0x30(%rsp)
movq 0x90(%rsp), %r14
movq %r12, 0x48(%rsp)
movq %r11, 0x40(%rsp)
movq %r10, 0x38(%rsp)
movq %r8, 0x50(%rsp)
movq %r9, 0x58(%rsp)
dgemv_n_57:
xorq %rax, %rax
addq $0x1, %rax
shlq $0x15, %rax
subq %rax, 0x38(%rsp)
movq %rax, %r10
jge dgemv_n_7d
movq 0x38(%rsp), %r10
addq %r10, %rax
jle dgemv_n_e90
movq %rax, %r10
dgemv_n_7d:
movq 0x58(%rsp), %r9
movq 0x48(%rsp), %r12
movq 0x40(%rsp), %r11
movq 0x50(%rsp), %r8
movq 0x88(%rsp), %rsi
movq 0x98(%rsp), %rdi
movq 0xa0(%rsp), %r13
leaq -0x1(%rdi), %rax
leaq (,%rsi,8), %rsi
leaq (,%rdi,8), %rdi
leaq (,%r8,8), %r8
leaq (%r8,%r8,2), %rdx
subq $-0x80, %r12
testq %r11, %r11
jle dgemv_n_e60
testq %r10, %r10
jle dgemv_n_e60
movq %r14, %rbp
andq $0xf, %rbp
orq %rbp, %rax
testq %rax, %rax
cmoveq %r14, %r13
je dgemv_n_138
movq %r13, %rbp
pxor %xmm4, %xmm4
movq %r10, %rax
addq $0x10, %rax
sarq $0x4, %rax
nopl (%rax)
dgemv_n_108:
movaps %xmm4, (%rbp)
movaps %xmm4, 0x10(%rbp)
movaps %xmm4, 0x20(%rbp)
movaps %xmm4, 0x30(%rbp)
movaps %xmm4, 0x40(%rbp)
movaps %xmm4, 0x50(%rbp)
movaps %xmm4, 0x60(%rbp)
movaps %xmm4, 0x70(%rbp)
subq $-0x80, %rbp
decq %rax
jg dgemv_n_108
nopl (%rax)
dgemv_n_138:
cmpq $0x4, %r11
jl dgemv_n_5a0
nopw (%rax,%rax)
dgemv_n_148:
subq $0x4, %r11
leaq 0x80(%r13), %rbp
movq %r12, %rbx
leaq (%r12,%r8,2), %rcx
leaq (%r12,%r8,4), %r12
movddup (%r9), %xmm12
addq %rsi, %r9
movddup (%r9), %xmm13
addq %rsi, %r9
movddup (%r9), %xmm14
addq %rsi, %r9
movddup (%r9), %xmm15
addq %rsi, %r9
movddup 0x30(%rsp), %xmm0
mulpd %xmm0, %xmm12
mulpd %xmm0, %xmm13
mulpd %xmm0, %xmm14
mulpd %xmm0, %xmm15
movq %r10, %rax
sarq $0x3, %rax
jle dgemv_n_430
movups -0x80(%rbx), %xmm0
movups -0x70(%rbx), %xmm1
movups -0x60(%rbx), %xmm2
movups -0x50(%rbx), %xmm3
movups -0x80(%rbp), %xmm8
movups -0x70(%rbp), %xmm9
movups -0x60(%rbp), %xmm10
movups -0x50(%rbp), %xmm11
movups -0x80(%rbx,%r8), %xmm4
movups -0x70(%rbx,%r8), %xmm5
movups -0x60(%rbx,%r8), %xmm6
movups -0x50(%rbx,%r8), %xmm7
decq %rax
jle dgemv_n_348
nopw (%rax,%rax)
dgemv_n_1f0:
prefetcht0 0x120(%rbx)
mulpd %xmm12, %xmm0
addpd %xmm0, %xmm8
movups -0x80(%rcx), %xmm0
mulpd %xmm12, %xmm1
addpd %xmm1, %xmm9
movups -0x70(%rcx), %xmm1
mulpd %xmm12, %xmm2
addpd %xmm2, %xmm10
movups -0x60(%rcx), %xmm2
mulpd %xmm12, %xmm3
addpd %xmm3, %xmm11
movups -0x50(%rcx), %xmm3
prefetcht0 0x120(%rbx,%r8)
mulpd %xmm13, %xmm4
addpd %xmm4, %xmm8
movups -0x80(%rcx,%r8), %xmm4
mulpd %xmm13, %xmm5
addpd %xmm5, %xmm9
movups -0x70(%rcx,%r8), %xmm5
mulpd %xmm13, %xmm6
addpd %xmm6, %xmm10
movups -0x60(%rcx,%r8), %xmm6
mulpd %xmm13, %xmm7
addpd %xmm7, %xmm11
movups -0x50(%rcx,%r8), %xmm7
prefetcht0 0x120(%rcx)
mulpd %xmm14, %xmm0
addpd %xmm0, %xmm8
movups -0x40(%rbx), %xmm0
mulpd %xmm14, %xmm1
addpd %xmm1, %xmm9
movups -0x30(%rbx), %xmm1
mulpd %xmm14, %xmm2
addpd %xmm2, %xmm10
movups -0x20(%rbx), %xmm2
mulpd %xmm14, %xmm3
addpd %xmm3, %xmm11
movups -0x10(%rbx), %xmm3
prefetcht0 0x120(%rcx,%r8)
mulpd %xmm15, %xmm4
addpd %xmm4, %xmm8
movups -0x40(%rbx,%r8), %xmm4
mulpd %xmm15, %xmm5
addpd %xmm5, %xmm9
movups -0x30(%rbx,%r8), %xmm5
mulpd %xmm15, %xmm6
addpd %xmm6, %xmm10
movups -0x20(%rbx,%r8), %xmm6
mulpd %xmm15, %xmm7
addpd %xmm7, %xmm11
movups -0x10(%rbx,%r8), %xmm7
prefetcht0 0x120(%rbp)
movups %xmm8, -0x80(%rbp)
movups %xmm9, -0x70(%rbp)
movups %xmm10, -0x60(%rbp)
movups %xmm11, -0x50(%rbp)
movups -0x40(%rbp), %xmm8
movups -0x30(%rbp), %xmm9
movups -0x20(%rbp), %xmm10
movups -0x10(%rbp), %xmm11
subq $-0x40, %rbx
subq $-0x40, %rcx
subq $-0x40, %rbp
subq $0x1, %rax
jg dgemv_n_1f0
nop
dgemv_n_348:
mulpd %xmm12, %xmm0
addpd %xmm0, %xmm8
movups -0x80(%rcx), %xmm0
mulpd %xmm12, %xmm1
addpd %xmm1, %xmm9
movups -0x70(%rcx), %xmm1
mulpd %xmm12, %xmm2
addpd %xmm2, %xmm10
movups -0x60(%rcx), %xmm2
mulpd %xmm12, %xmm3
addpd %xmm3, %xmm11
movups -0x50(%rcx), %xmm3
mulpd %xmm13, %xmm4
addpd %xmm4, %xmm8
movups -0x80(%rcx,%r8), %xmm4
mulpd %xmm13, %xmm5
addpd %xmm5, %xmm9
movups -0x70(%rcx,%r8), %xmm5
mulpd %xmm13, %xmm6
addpd %xmm6, %xmm10
movups -0x60(%rcx,%r8), %xmm6
mulpd %xmm13, %xmm7
addpd %xmm7, %xmm11
movups -0x50(%rcx,%r8), %xmm7
mulpd %xmm14, %xmm0
addpd %xmm0, %xmm8
mulpd %xmm14, %xmm1
addpd %xmm1, %xmm9
mulpd %xmm14, %xmm2
addpd %xmm2, %xmm10
mulpd %xmm14, %xmm3
addpd %xmm3, %xmm11
mulpd %xmm15, %xmm4
addpd %xmm4, %xmm8
movups %xmm8, -0x80(%rbp)
mulpd %xmm15, %xmm5
addpd %xmm5, %xmm9
movups %xmm9, -0x70(%rbp)
mulpd %xmm15, %xmm6
addpd %xmm6, %xmm10
movups %xmm10, -0x60(%rbp)
mulpd %xmm15, %xmm7
addpd %xmm7, %xmm11
movups %xmm11, -0x50(%rbp)
subq $-0x40, %rbx
subq $-0x40, %rcx
subq $-0x40, %rbp
dgemv_n_430:
testq $0x4, %r10
je dgemv_n_4d8
movups -0x80(%rbx), %xmm0
movups -0x70(%rbx), %xmm1
movups -0x80(%rbp), %xmm8
movups -0x70(%rbp), %xmm9
mulpd %xmm12, %xmm0
addpd %xmm0, %xmm8
mulpd %xmm12, %xmm1
addpd %xmm1, %xmm9
movups -0x80(%rbx,%r8), %xmm4
movups -0x70(%rbx,%r8), %xmm5
mulpd %xmm13, %xmm4
addpd %xmm4, %xmm8
mulpd %xmm13, %xmm5
addpd %xmm5, %xmm9
movups -0x80(%rcx), %xmm0
movups -0x70(%rcx), %xmm1
mulpd %xmm14, %xmm0
addpd %xmm0, %xmm8
mulpd %xmm14, %xmm1
addpd %xmm1, %xmm9
movups -0x80(%rcx,%r8), %xmm4
movups -0x70(%rcx,%r8), %xmm5
mulpd %xmm15, %xmm4
addpd %xmm4, %xmm8
mulpd %xmm15, %xmm5
addpd %xmm5, %xmm9
movups %xmm8, -0x80(%rbp)
movups %xmm9, -0x70(%rbp)
addq $0x20, %rbx
addq $0x20, %rcx
addq $0x20, %rbp
nopl (%rax)
dgemv_n_4d8:
testq $0x2, %r10
je dgemv_n_538
movups -0x80(%rbx), %xmm8
movups -0x80(%rbx,%r8), %xmm9
movups -0x80(%rcx), %xmm10
movups -0x80(%rcx,%r8), %xmm11
movups -0x80(%rbp), %xmm0
mulpd %xmm12, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm13, %xmm9
addpd %xmm9, %xmm0
mulpd %xmm14, %xmm10
addpd %xmm10, %xmm0
mulpd %xmm15, %xmm11
addpd %xmm11, %xmm0
movups %xmm0, -0x80(%rbp)
addq $0x10, %rbx
addq $0x10, %rcx
addq $0x10, %rbp
nopl (%rax,%rax)
dgemv_n_538:
testq $0x1, %r10
je dgemv_n_590
movsd -0x80(%rbp), %xmm0
movsd -0x80(%rbx), %xmm8
movsd -0x80(%rbx,%r8), %xmm9
movsd -0x80(%rcx), %xmm10
movsd -0x80(%rcx,%r8), %xmm11
mulsd %xmm12, %xmm8
addsd %xmm8, %xmm0
mulsd %xmm13, %xmm9
addsd %xmm9, %xmm0
mulsd %xmm14, %xmm10
addsd %xmm10, %xmm0
mulsd %xmm15, %xmm11
addsd %xmm11, %xmm0
movsd %xmm0, -0x80(%rbp)
nopl (%rax)
dgemv_n_590:
cmpq $0x4, %r11
jge dgemv_n_148
nopw (%rax,%rax)
dgemv_n_5a0:
cmpq $0x2, %r11
jl dgemv_n_848
subq $0x2, %r11
leaq 0x80(%r13), %rbp
movq %r12, %rbx
leaq (%r12,%r8), %rcx
leaq (%r12,%r8,2), %r12
movddup (%r9), %xmm12
addq %rsi, %r9
movddup (%r9), %xmm13
addq %rsi, %r9
movddup 0x30(%rsp), %xmm0
mulpd %xmm0, %xmm12
mulpd %xmm0, %xmm13
movq %r10, %rax
sarq $0x3, %rax
jle dgemv_n_768
movups -0x80(%rbx), %xmm0
movups -0x70(%rbx), %xmm1
movups -0x60(%rbx), %xmm2
movups -0x50(%rbx), %xmm3
movups -0x80(%rbp), %xmm8
movups -0x70(%rbp), %xmm9
movups -0x60(%rbp), %xmm10
movups -0x50(%rbp), %xmm11
movups -0x80(%rcx), %xmm4
movups -0x70(%rcx), %xmm5
movups -0x60(%rcx), %xmm6
movups -0x50(%rcx), %xmm7
decq %rax
jle dgemv_n_6f8
nopw (%rax,%rax)
dgemv_n_630:
prefetcht0 0x2a0(%rbx)
mulpd %xmm12, %xmm0
addpd %xmm0, %xmm8
movups -0x40(%rbx), %xmm0
mulpd %xmm12, %xmm1
addpd %xmm1, %xmm9
movups -0x30(%rbx), %xmm1
mulpd %xmm12, %xmm2
addpd %xmm2, %xmm10
movups -0x20(%rbx), %xmm2
mulpd %xmm12, %xmm3
addpd %xmm3, %xmm11
movups -0x10(%rbx), %xmm3
prefetcht0 0x2a0(%rcx)
mulpd %xmm13, %xmm4
addpd %xmm4, %xmm8
movups -0x40(%rcx), %xmm4
mulpd %xmm13, %xmm5
addpd %xmm5, %xmm9
movups -0x30(%rcx), %xmm5
mulpd %xmm13, %xmm6
addpd %xmm6, %xmm10
movups -0x20(%rcx), %xmm6
mulpd %xmm13, %xmm7
addpd %xmm7, %xmm11
movups -0x10(%rcx), %xmm7
prefetcht0 0x2a0(%rbp)
movups %xmm8, -0x80(%rbp)
movups %xmm9, -0x70(%rbp)
movups %xmm10, -0x60(%rbp)
movups %xmm11, -0x50(%rbp)
movups -0x40(%rbp), %xmm8
movups -0x30(%rbp), %xmm9
movups -0x20(%rbp), %xmm10
movups -0x10(%rbp), %xmm11
subq $-0x40, %rbx
subq $-0x40, %rcx
subq $-0x40, %rbp
subq $0x1, %rax
jg dgemv_n_630
nopl (%rax)
dgemv_n_6f8:
mulpd %xmm12, %xmm0
addpd %xmm0, %xmm8
mulpd %xmm12, %xmm1
addpd %xmm1, %xmm9
mulpd %xmm12, %xmm2
addpd %xmm2, %xmm10
mulpd %xmm12, %xmm3
addpd %xmm3, %xmm11
mulpd %xmm13, %xmm4
addpd %xmm4, %xmm8
movups %xmm8, -0x80(%rbp)
mulpd %xmm13, %xmm5
addpd %xmm5, %xmm9
movups %xmm9, -0x70(%rbp)
mulpd %xmm13, %xmm6
addpd %xmm6, %xmm10
movups %xmm10, -0x60(%rbp)
mulpd %xmm13, %xmm7
addpd %xmm7, %xmm11
movups %xmm11, -0x50(%rbp)
subq $-0x40, %rbx
subq $-0x40, %rcx
subq $-0x40, %rbp
dgemv_n_768:
testq $0x4, %r10
je dgemv_n_7d0
movups -0x80(%rbx), %xmm0
movups -0x70(%rbx), %xmm1
movups -0x80(%rbp), %xmm8
movups -0x70(%rbp), %xmm9
mulpd %xmm12, %xmm0
addpd %xmm0, %xmm8
mulpd %xmm12, %xmm1
addpd %xmm1, %xmm9
movups -0x80(%rcx), %xmm4
movups -0x70(%rcx), %xmm5
mulpd %xmm13, %xmm4
addpd %xmm4, %xmm8
movups %xmm8, -0x80(%rbp)
mulpd %xmm13, %xmm5
addpd %xmm5, %xmm9
movups %xmm9, -0x70(%rbp)
addq $0x20, %rbx
addq $0x20, %rcx
addq $0x20, %rbp
nopl (%rax)
dgemv_n_7d0:
testq $0x2, %r10
je dgemv_n_810
movups -0x80(%rbx), %xmm8
movups -0x80(%rcx), %xmm9
movups -0x80(%rbp), %xmm0
mulpd %xmm12, %xmm8
addpd %xmm8, %xmm0
mulpd %xmm13, %xmm9
addpd %xmm9, %xmm0
movups %xmm0, -0x80(%rbp)
addq $0x10, %rbx
addq $0x10, %rcx
addq $0x10, %rbp
nopl (%rax,%rax)
dgemv_n_810:
testq $0x1, %r10
je dgemv_n_848
movsd -0x80(%rbp), %xmm0
movsd -0x80(%rbx), %xmm8
movsd -0x80(%rcx), %xmm9
mulsd %xmm12, %xmm8
addsd %xmm8, %xmm0
mulsd %xmm13, %xmm9
addsd %xmm9, %xmm0
movsd %xmm0, -0x80(%rbp)
nopl (%rax,%rax)
dgemv_n_848:
cmpq $0x1, %r11
jl dgemv_n_a10
leaq 0x80(%r13), %rbp
movq %r12, %rbx
movddup (%r9), %xmm12
addq %rsi, %r9
movddup 0x30(%rsp), %xmm0
mulpd %xmm0, %xmm12
movq %r10, %rax
sarq $0x3, %rax
jle dgemv_n_978
movups -0x80(%rbx), %xmm0
movups -0x70(%rbx), %xmm1
movups -0x60(%rbx), %xmm2
movups -0x50(%rbx), %xmm3
movups -0x80(%rbp), %xmm8
movups -0x70(%rbp), %xmm9
movups -0x60(%rbp), %xmm10
movups -0x50(%rbp), %xmm11
decq %rax
jle dgemv_n_930
nopl (%rax)
dgemv_n_8b0:
prefetcht0 0x5a0(%rbx)
mulpd %xmm12, %xmm0
addpd %xmm0, %xmm8
movups -0x40(%rbx), %xmm0
mulpd %xmm12, %xmm1
addpd %xmm1, %xmm9
movups -0x30(%rbx), %xmm1
mulpd %xmm12, %xmm2
addpd %xmm2, %xmm10
movups -0x20(%rbx), %xmm2
mulpd %xmm12, %xmm3
addpd %xmm3, %xmm11
movups -0x10(%rbx), %xmm3
prefetcht0 0x5a0(%rbp)
movups %xmm8, -0x80(%rbp)
movups %xmm9, -0x70(%rbp)
movups %xmm10, -0x60(%rbp)
movups %xmm11, -0x50(%rbp)
movups -0x40(%rbp), %xmm8
movups -0x30(%rbp), %xmm9
movups -0x20(%rbp), %xmm10
movups -0x10(%rbp), %xmm11
subq $-0x40, %rbx
subq $-0x40, %rbp
subq $0x1, %rax
jg dgemv_n_8b0
nopl (%rax)
dgemv_n_930:
mulpd %xmm12, %xmm0
addpd %xmm0, %xmm8
movups %xmm8, -0x80(%rbp)
mulpd %xmm12, %xmm1
addpd %xmm1, %xmm9
movups %xmm9, -0x70(%rbp)
mulpd %xmm12, %xmm2
addpd %xmm2, %xmm10
movups %xmm10, -0x60(%rbp)
mulpd %xmm12, %xmm3
addpd %xmm3, %xmm11
movups %xmm11, -0x50(%rbp)
subq $-0x40, %rbx
subq $-0x40, %rbp
nopl (%rax)
dgemv_n_978:
testq $0x4, %r10
je dgemv_n_9c0
movups -0x80(%rbx), %xmm0
movups -0x70(%rbx), %xmm1
movups -0x80(%rbp), %xmm8
movups -0x70(%rbp), %xmm9
mulpd %xmm12, %xmm0
addpd %xmm0, %xmm8
movups %xmm8, -0x80(%rbp)
mulpd %xmm12, %xmm1
addpd %xmm1, %xmm9
movups %xmm9, -0x70(%rbp)
addq $0x20, %rbx
addq $0x20, %rbp
nopl (%rax)
dgemv_n_9c0:
testq $0x2, %r10
je dgemv_n_9e8
movups -0x80(%rbx), %xmm8
movups -0x80(%rbp), %xmm0
mulpd %xmm12, %xmm8
addpd %xmm8, %xmm0
movups %xmm0, -0x80(%rbp)
addq $0x10, %rbx
addq $0x10, %rbp
dgemv_n_9e8:
testq $0x1, %r10
je dgemv_n_a10
movsd -0x80(%rbp), %xmm0
movsd -0x80(%rbx), %xmm8
mulsd %xmm12, %xmm8
addsd %xmm8, %xmm0
movsd %xmm0, -0x80(%rbp)
nopl (%rax,%rax)
dgemv_n_a10:
cmpq %r14, %r13
je dgemv_n_e60
movq %r10, %r15
movq %r14, %rbp
cmpq $0x8, %rdi
jne dgemv_n_cb0
testq $0x8, %rbp
je dgemv_n_a60
movsd (%rbp), %xmm0
addsd (%r13), %xmm0
movsd %xmm0, (%rbp)
addq $0x8, %rbp
addq $0x8, %r13
decq %r15
jle dgemv_n_e60
nopw %cs:(%rax,%rax)
nopl (%rax)
dgemv_n_a60:
testq $0x8, %r13
jne dgemv_n_b70
movq %r15, %rax
sarq $0x3, %rax
jle dgemv_n_ad8
nop
dgemv_n_a78:
prefetcht0 0x320(%rbp)
movaps (%rbp), %xmm0
movaps 0x10(%rbp), %xmm1
movaps 0x20(%rbp), %xmm2
movaps 0x30(%rbp), %xmm3
movaps (%r13), %xmm4
movaps 0x10(%r13), %xmm5
movaps 0x20(%r13), %xmm6
movaps 0x30(%r13), %xmm7
prefetcht0 0x320(%r13)
addpd %xmm4, %xmm0
addpd %xmm5, %xmm1
addpd %xmm6, %xmm2
addpd %xmm7, %xmm3
movaps %xmm0, (%rbp)
movaps %xmm1, 0x10(%rbp)
movaps %xmm2, 0x20(%rbp)
movaps %xmm3, 0x30(%rbp)
addq $0x40, %rbp
addq $0x40, %r13
decq %rax
jg dgemv_n_a78
dgemv_n_ad8:
testq $0x7, %r15
jle dgemv_n_e60
testq $0x4, %r15
jle dgemv_n_b18
movaps (%rbp), %xmm0
movaps 0x10(%rbp), %xmm1
movaps (%r13), %xmm4
movaps 0x10(%r13), %xmm5
addpd %xmm4, %xmm0
addpd %xmm5, %xmm1
movaps %xmm0, (%rbp)
movaps %xmm1, 0x10(%rbp)
addq $0x20, %rbp
addq $0x20, %r13
dgemv_n_b18:
testq $0x2, %r15
jle dgemv_n_b40
movaps (%rbp), %xmm0
movaps (%r13), %xmm4
addpd %xmm4, %xmm0
movaps %xmm0, (%rbp)
addq $0x10, %rbp
addq $0x10, %r13
nopw (%rax,%rax)
dgemv_n_b40:
testq $0x1, %r15
jle dgemv_n_e60
movsd (%rbp), %xmm0
movsd (%r13), %xmm4
addsd %xmm4, %xmm0
movlpd %xmm0, (%rbp)
nopl (%rax)
jmp dgemv_n_e60
nopl (%rax)
dgemv_n_b70:
movaps -0x8(%r13), %xmm4
movq %r15, %rax
sarq $0x3, %rax
jle dgemv_n_c08
nopw (%rax,%rax)
dgemv_n_b88:
prefetcht0 0x320(%rbp)
movaps (%rbp), %xmm0
movaps 0x10(%rbp), %xmm1
movaps 0x20(%rbp), %xmm2
movaps 0x30(%rbp), %xmm3
movaps 0x8(%r13), %xmm5
movaps 0x18(%r13), %xmm6
movaps 0x28(%r13), %xmm7
movaps 0x38(%r13), %xmm8
shufpd $0x1, %xmm5, %xmm4
shufpd $0x1, %xmm6, %xmm5
shufpd $0x1, %xmm7, %xmm6
shufpd $0x1, %xmm8, %xmm7
prefetcht0 0x320(%r13)
addpd %xmm4, %xmm0
addpd %xmm5, %xmm1
addpd %xmm6, %xmm2
addpd %xmm7, %xmm3
movaps %xmm0, (%rbp)
movaps %xmm1, 0x10(%rbp)
movaps %xmm2, 0x20(%rbp)
movaps %xmm3, 0x30(%rbp)
movaps %xmm8, %xmm4
addq $0x40, %rbp
addq $0x40, %r13
decq %rax
jg dgemv_n_b88
nopl (%rax)
dgemv_n_c08:
testq $0x7, %r15
jle dgemv_n_e60
testq $0x4, %r15
jle dgemv_n_c58
movaps (%rbp), %xmm0
movaps 0x10(%rbp), %xmm1
movaps 0x8(%r13), %xmm5
movaps 0x18(%r13), %xmm6
shufpd $0x1, %xmm5, %xmm4
shufpd $0x1, %xmm6, %xmm5
addpd %xmm4, %xmm0
addpd %xmm5, %xmm1
movaps %xmm0, (%rbp)
movaps %xmm1, 0x10(%rbp)
movaps %xmm6, %xmm4
addq $0x20, %rbp
addq $0x20, %r13
nopl (%rax)
dgemv_n_c58:
testq $0x2, %r15
jle dgemv_n_c88
movaps (%rbp), %xmm0
movaps 0x8(%r13), %xmm5
shufpd $0x1, %xmm5, %xmm4
addpd %xmm4, %xmm0
movaps %xmm0, (%rbp)
movaps %xmm5, %xmm4
addq $0x10, %rbp
addq $0x10, %r13
nopw (%rax,%rax)
dgemv_n_c88:
testq $0x1, %r15
jle dgemv_n_e60
movsd (%rbp), %xmm0
shufpd $0x1, %xmm4, %xmm4
addsd %xmm4, %xmm0
movlpd %xmm0, (%rbp)
jmp dgemv_n_e60
nopl (%rax)
dgemv_n_cb0:
testq $0x8, %r13
je dgemv_n_ce0
movsd (%rbp), %xmm0
addsd (%r13), %xmm0
movsd %xmm0, (%rbp)
addq %rdi, %rbp
addq $0x8, %r13
decq %r15
jle dgemv_n_e60
nopl (%rax)
dgemv_n_ce0:
movq %rbp, %rbx
movq %r15, %rax
sarq $0x3, %rax
jle dgemv_n_da0
dgemv_n_cf0:
movsd (%rbx), %xmm0
addq %rdi, %rbx
movhpd (%rbx), %xmm0
addq %rdi, %rbx
movaps (%r13), %xmm4
movsd (%rbx), %xmm1
addq %rdi, %rbx
movhpd (%rbx), %xmm1
addq %rdi, %rbx
movaps 0x10(%r13), %xmm5
movsd (%rbx), %xmm2
addq %rdi, %rbx
movhpd (%rbx), %xmm2
addq %rdi, %rbx
movaps 0x20(%r13), %xmm6
addpd %xmm4, %xmm0
movsd (%rbx), %xmm3
addq %rdi, %rbx
movhpd (%rbx), %xmm3
addq %rdi, %rbx
movaps 0x30(%r13), %xmm7
addpd %xmm5, %xmm1
movlpd %xmm0, (%rbp)
addq %rdi, %rbp
movhpd %xmm0, (%rbp)
addq %rdi, %rbp
addpd %xmm6, %xmm2
movlpd %xmm1, (%rbp)
addq %rdi, %rbp
movhpd %xmm1, (%rbp)
addq %rdi, %rbp
addpd %xmm7, %xmm3
movlpd %xmm2, (%rbp)
addq %rdi, %rbp
movhpd %xmm2, (%rbp)
addq %rdi, %rbp
movlpd %xmm3, (%rbp)
addq %rdi, %rbp
movhpd %xmm3, (%rbp)
addq %rdi, %rbp
addq $0x40, %r13
decq %rax
jg dgemv_n_cf0
nopl (%rax)
dgemv_n_da0:
testq $0x7, %r15
jle dgemv_n_e60
testq $0x4, %r15
jle dgemv_n_e08
movsd (%rbx), %xmm0
addq %rdi, %rbx
movhpd (%rbx), %xmm0
addq %rdi, %rbx
movaps (%r13), %xmm4
movsd (%rbx), %xmm1
addq %rdi, %rbx
movhpd (%rbx), %xmm1
addq %rdi, %rbx
movaps 0x10(%r13), %xmm5
addpd %xmm4, %xmm0
addpd %xmm5, %xmm1
movlpd %xmm0, (%rbp)
addq %rdi, %rbp
movhpd %xmm0, (%rbp)
addq %rdi, %rbp
movlpd %xmm1, (%rbp)
addq %rdi, %rbp
movhpd %xmm1, (%rbp)
addq %rdi, %rbp
addq $0x20, %r13
dgemv_n_e08:
testq $0x2, %r15
jle dgemv_n_e40
movsd (%rbx), %xmm0
addq %rdi, %rbx
movhpd (%rbx), %xmm0
addq %rdi, %rbx
movaps (%r13), %xmm4
addpd %xmm4, %xmm0
movlpd %xmm0, (%rbp)
addq %rdi, %rbp
movhpd %xmm0, (%rbp)
addq %rdi, %rbp
addq $0x10, %r13
nopl (%rax)
dgemv_n_e40:
testq $0x1, %r15
jle dgemv_n_e60
movsd (%rbx), %xmm0
movsd (%r13), %xmm4
addsd %xmm4, %xmm0
movlpd %xmm0, (%rbp)
nopl (%rax)
dgemv_n_e60:
leaq (,%r10,8), %rax
addq %rax, 0x48(%rsp)
movq 0x98(%rsp), %rdi
imulq %rdi, %rax
addq %rax, %r14
jmp dgemv_n_57
nopw %cs:(%rax,%rax)
nopl (%rax,%rax)
dgemv_n_e90:
movq (%rsp), %rbx
movq 0x8(%rsp), %rbp
movq 0x10(%rsp), %r12
movq 0x18(%rsp), %r13
movq 0x20(%rsp), %r14
movq 0x28(%rsp), %r15
addq $0x80, %rsp
retq
