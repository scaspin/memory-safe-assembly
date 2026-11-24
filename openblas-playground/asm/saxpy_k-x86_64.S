saxpy_k:
movq 0x8(%rsp), %rsi
movaps %xmm0, %xmm15
shufps $0x0, %xmm15, %xmm15
leaq (,%r8,4), %r8
leaq (,%rsi,4), %rsi
testq %rdi, %rdi
jle saxpy_k_360
cmpq $0x4, %r8
jne saxpy_k_d90
cmpq $0x4, %rsi
jne saxpy_k_d90
subq $-0x80, %rcx
subq $-0x80, %r9
cmpq $0x3, %rdi
jle saxpy_k_308
testq $0x4, %r9
je saxpy_k_80
movss -0x80(%rcx), %xmm0
mulss %xmm15, %xmm0
addss -0x80(%r9), %xmm0
movss %xmm0, -0x80(%r9)
addq $0x4, %rcx
addq $0x4, %r9
decq %rdi
jle saxpy_k_360
nopl (%rax)
saxpy_k_80:
testq $0x8, %r9
je saxpy_k_b8
movsd -0x80(%rcx), %xmm0
movsd -0x80(%r9), %xmm4
mulps %xmm15, %xmm0
addps %xmm4, %xmm0
movsd %xmm0, -0x80(%r9)
addq $0x8, %rcx
addq $0x8, %r9
subq $0x2, %rdi
jle saxpy_k_360
nopl (%rax,%rax)
saxpy_k_b8:
testq $0xc, %rcx
jne saxpy_k_368
movq %rdi, %rax
sarq $0x5, %rax
jle saxpy_k_238
movaps -0x80(%rcx), %xmm0
movaps -0x70(%rcx), %xmm1
movaps -0x60(%rcx), %xmm2
movaps -0x50(%rcx), %xmm3
decq %rax
jle saxpy_k_1b0
nopl (%rax,%rax)
saxpy_k_f0:
movaps -0x40(%rcx), %xmm4
movaps -0x30(%rcx), %xmm5
prefetcht0 0x580(%r9)
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x20(%rcx), %xmm6
movaps -0x10(%rcx), %xmm7
prefetcht0 0x580(%rcx)
mulps %xmm15, %xmm2
addps -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
mulps %xmm15, %xmm3
addps -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movaps (%rcx), %xmm0
movaps 0x10(%rcx), %xmm1
prefetcht0 0x5c0(%r9)
mulps %xmm15, %xmm4
addps -0x40(%r9), %xmm4
movaps %xmm4, -0x40(%r9)
mulps %xmm15, %xmm5
addps -0x30(%r9), %xmm5
movaps %xmm5, -0x30(%r9)
movaps 0x20(%rcx), %xmm2
movaps 0x30(%rcx), %xmm3
prefetcht0 0x5c0(%rcx)
mulps %xmm15, %xmm6
addps -0x20(%r9), %xmm6
movaps %xmm6, -0x20(%r9)
mulps %xmm15, %xmm7
addps -0x10(%r9), %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
decq %rax
jg saxpy_k_f0
nop
saxpy_k_1b0:
movaps -0x40(%rcx), %xmm4
movaps -0x30(%rcx), %xmm5
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x20(%rcx), %xmm6
movaps -0x10(%rcx), %xmm7
mulps %xmm15, %xmm2
addps -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
mulps %xmm15, %xmm3
addps -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
mulps %xmm15, %xmm4
addps -0x40(%r9), %xmm4
movaps %xmm4, -0x40(%r9)
mulps %xmm15, %xmm5
addps -0x30(%r9), %xmm5
movaps %xmm5, -0x30(%r9)
mulps %xmm15, %xmm6
addps -0x20(%r9), %xmm6
movaps %xmm6, -0x20(%r9)
mulps %xmm15, %xmm7
addps -0x10(%r9), %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
saxpy_k_238:
movq %rdi, %rax
andq $0x10, %rax
jle saxpy_k_298
nopl (%rax)
movaps -0x80(%rcx), %xmm0
movaps -0x70(%rcx), %xmm1
movaps -0x60(%rcx), %xmm2
movaps -0x50(%rcx), %xmm3
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
mulps %xmm15, %xmm2
addps -0x60(%r9), %xmm2
mulps %xmm15, %xmm3
addps -0x50(%r9), %xmm3
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x70(%r9)
movaps %xmm2, -0x60(%r9)
movaps %xmm3, -0x50(%r9)
addq $0x40, %rcx
addq $0x40, %r9
saxpy_k_298:
movq %rdi, %rax
andq $0x8, %rax
jle saxpy_k_2d8
nopl (%rax)
movaps -0x80(%rcx), %xmm0
movaps -0x70(%rcx), %xmm1
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x70(%r9)
addq $0x20, %rcx
addq $0x20, %r9
nopl (%rax)
saxpy_k_2d8:
movq %rdi, %rax
andq $0x4, %rax
jle saxpy_k_308
nopl (%rax)
movaps -0x80(%rcx), %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
addq $0x10, %rcx
addq $0x10, %r9
nopw (%rax,%rax)
saxpy_k_308:
movq %rdi, %rax
andq $0x2, %rax
jle saxpy_k_338
nopl (%rax)
movsd -0x80(%rcx), %xmm0
movsd -0x80(%r9), %xmm4
mulps %xmm15, %xmm0
addps %xmm4, %xmm0
movsd %xmm0, -0x80(%r9)
addq $0x8, %rcx
addq $0x8, %r9
saxpy_k_338:
movq %rdi, %rax
andq $0x1, %rax
jle saxpy_k_360
nopl (%rax)
movss -0x80(%rcx), %xmm0
mulss %xmm15, %xmm0
addss -0x80(%r9), %xmm0
movss %xmm0, -0x80(%r9)
nop
saxpy_k_360:
xorq %rax, %rax
retq
nopl (%rax)
saxpy_k_368:
testq $0x4, %rcx
jne saxpy_k_698
movhps -0x80(%rcx), %xmm0
movq %rdi, %rax
sarq $0x5, %rax
jle saxpy_k_538
movaps -0x78(%rcx), %xmm1
movaps -0x68(%rcx), %xmm2
movaps -0x58(%rcx), %xmm3
movaps -0x48(%rcx), %xmm4
decq %rax
jle saxpy_k_488
nop
saxpy_k_3a0:
movaps -0x38(%rcx), %xmm5
movaps -0x28(%rcx), %xmm6
prefetcht0 0x580(%r9)
shufpd $0x1, %xmm1, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
shufpd $0x1, %xmm2, %xmm1
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x18(%rcx), %xmm7
movaps -0x8(%rcx), %xmm0
prefetcht0 0x580(%rcx)
shufpd $0x1, %xmm3, %xmm2
mulps %xmm15, %xmm2
addps -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
shufpd $0x1, %xmm4, %xmm3
mulps %xmm15, %xmm3
addps -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movaps 0x8(%rcx), %xmm1
movaps 0x18(%rcx), %xmm2
prefetcht0 0x5c0(%r9)
shufpd $0x1, %xmm5, %xmm4
mulps %xmm15, %xmm4
addps -0x40(%r9), %xmm4
movaps %xmm4, -0x40(%r9)
shufpd $0x1, %xmm6, %xmm5
mulps %xmm15, %xmm5
addps -0x30(%r9), %xmm5
movaps %xmm5, -0x30(%r9)
movaps 0x28(%rcx), %xmm3
movaps 0x38(%rcx), %xmm4
prefetcht0 0x5c0(%rcx)
shufpd $0x1, %xmm7, %xmm6
mulps %xmm15, %xmm6
addps -0x20(%r9), %xmm6
movaps %xmm6, -0x20(%r9)
shufpd $0x1, %xmm0, %xmm7
mulps %xmm15, %xmm7
addps -0x10(%r9), %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
decq %rax
jg saxpy_k_3a0
nop
saxpy_k_488:
movaps -0x38(%rcx), %xmm5
movaps -0x28(%rcx), %xmm6
shufpd $0x1, %xmm1, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
shufpd $0x1, %xmm2, %xmm1
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x18(%rcx), %xmm7
movaps -0x8(%rcx), %xmm0
shufpd $0x1, %xmm3, %xmm2
mulps %xmm15, %xmm2
addps -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
shufpd $0x1, %xmm4, %xmm3
mulps %xmm15, %xmm3
addps -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
shufpd $0x1, %xmm5, %xmm4
mulps %xmm15, %xmm4
addps -0x40(%r9), %xmm4
movaps %xmm4, -0x40(%r9)
shufpd $0x1, %xmm6, %xmm5
mulps %xmm15, %xmm5
addps -0x30(%r9), %xmm5
movaps %xmm5, -0x30(%r9)
shufpd $0x1, %xmm7, %xmm6
mulps %xmm15, %xmm6
addps -0x20(%r9), %xmm6
movaps %xmm6, -0x20(%r9)
shufpd $0x1, %xmm0, %xmm7
mulps %xmm15, %xmm7
addps -0x10(%r9), %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
saxpy_k_538:
movq %rdi, %rax
andq $0x10, %rax
jle saxpy_k_5b0
nopl (%rax)
movaps -0x78(%rcx), %xmm1
movaps -0x68(%rcx), %xmm2
movaps -0x58(%rcx), %xmm3
movaps -0x48(%rcx), %xmm4
shufpd $0x1, %xmm1, %xmm0
shufpd $0x1, %xmm2, %xmm1
shufpd $0x1, %xmm3, %xmm2
shufpd $0x1, %xmm4, %xmm3
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
mulps %xmm15, %xmm2
addps -0x60(%r9), %xmm2
mulps %xmm15, %xmm3
addps -0x50(%r9), %xmm3
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x70(%r9)
movaps %xmm2, -0x60(%r9)
movaps %xmm3, -0x50(%r9)
movaps %xmm4, %xmm0
addq $0x40, %rcx
addq $0x40, %r9
nop
saxpy_k_5b0:
movq %rdi, %rax
andq $0x8, %rax
jle saxpy_k_600
nopl (%rax)
movaps -0x78(%rcx), %xmm1
movaps -0x68(%rcx), %xmm2
shufpd $0x1, %xmm1, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
shufpd $0x1, %xmm2, %xmm1
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x70(%r9)
movaps %xmm2, %xmm0
addq $0x20, %rcx
addq $0x20, %r9
nopl (%rax)
saxpy_k_600:
movq %rdi, %rax
andq $0x4, %rax
jle saxpy_k_630
nopl (%rax)
movaps -0x78(%rcx), %xmm1
shufpd $0x1, %xmm1, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
addq $0x10, %rcx
addq $0x10, %r9
nop
saxpy_k_630:
movq %rdi, %rax
andq $0x2, %rax
jle saxpy_k_660
nopl (%rax)
movsd -0x80(%rcx), %xmm0
movsd -0x80(%r9), %xmm4
mulps %xmm15, %xmm0
addps %xmm4, %xmm0
movsd %xmm0, -0x80(%r9)
addq $0x8, %rcx
addq $0x8, %r9
saxpy_k_660:
movq %rdi, %rax
andq $0x1, %rax
jle saxpy_k_690
nopl (%rax)
movss -0x80(%rcx), %xmm0
mulss %xmm15, %xmm0
addss -0x80(%r9), %xmm0
movss %xmm0, -0x80(%r9)
addq $0x4, %r9
nopw (%rax,%rax)
saxpy_k_690:
xorq %rax, %rax
retq
nopl (%rax)
saxpy_k_698:
testq $0x8, %rcx
jne saxpy_k_a20
movaps -0x84(%rcx), %xmm0
movq %rdi, %rax
sarq $0x5, %rax
jle saxpy_k_8a8
movaps -0x74(%rcx), %xmm1
movaps -0x64(%rcx), %xmm2
movaps -0x54(%rcx), %xmm3
movaps -0x44(%rcx), %xmm4
decq %rax
jle saxpy_k_7e0
nopw %cs:(%rax,%rax)
nopl (%rax)
saxpy_k_6e0:
movaps -0x34(%rcx), %xmm5
movaps -0x24(%rcx), %xmm6
prefetcht0 0x580(%r9)
movss %xmm1, %xmm0
shufps $0x39, %xmm0, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
movss %xmm2, %xmm1
shufps $0x39, %xmm1, %xmm1
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x14(%rcx), %xmm7
movaps -0x4(%rcx), %xmm0
prefetcht0 0x580(%rcx)
movss %xmm3, %xmm2
shufps $0x39, %xmm2, %xmm2
mulps %xmm15, %xmm2
addps -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
movss %xmm4, %xmm3
shufps $0x39, %xmm3, %xmm3
mulps %xmm15, %xmm3
addps -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movaps 0xc(%rcx), %xmm1
movaps 0x1c(%rcx), %xmm2
prefetcht0 0x5c0(%r9)
movss %xmm5, %xmm4
shufps $0x39, %xmm4, %xmm4
mulps %xmm15, %xmm4
addps -0x40(%r9), %xmm4
movaps %xmm4, -0x40(%r9)
movss %xmm6, %xmm5
shufps $0x39, %xmm5, %xmm5
mulps %xmm15, %xmm5
addps -0x30(%r9), %xmm5
movaps %xmm5, -0x30(%r9)
movaps 0x2c(%rcx), %xmm3
movaps 0x3c(%rcx), %xmm4
prefetcht0 0x5c0(%rcx)
movss %xmm7, %xmm6
shufps $0x39, %xmm6, %xmm6
mulps %xmm15, %xmm6
addps -0x20(%r9), %xmm6
movaps %xmm6, -0x20(%r9)
movss %xmm0, %xmm7
shufps $0x39, %xmm7, %xmm7
mulps %xmm15, %xmm7
addps -0x10(%r9), %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
decq %rax
jg saxpy_k_6e0
nop
saxpy_k_7e0:
movaps -0x34(%rcx), %xmm5
movaps -0x24(%rcx), %xmm6
movss %xmm1, %xmm0
shufps $0x39, %xmm0, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
movss %xmm2, %xmm1
shufps $0x39, %xmm1, %xmm1
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x14(%rcx), %xmm7
movaps -0x4(%rcx), %xmm0
movss %xmm3, %xmm2
shufps $0x39, %xmm2, %xmm2
mulps %xmm15, %xmm2
addps -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
movss %xmm4, %xmm3
shufps $0x39, %xmm3, %xmm3
mulps %xmm15, %xmm3
addps -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movss %xmm5, %xmm4
shufps $0x39, %xmm4, %xmm4
mulps %xmm15, %xmm4
addps -0x40(%r9), %xmm4
movaps %xmm4, -0x40(%r9)
movss %xmm6, %xmm5
shufps $0x39, %xmm5, %xmm5
mulps %xmm15, %xmm5
addps -0x30(%r9), %xmm5
movaps %xmm5, -0x30(%r9)
movss %xmm7, %xmm6
shufps $0x39, %xmm6, %xmm6
mulps %xmm15, %xmm6
addps -0x20(%r9), %xmm6
movaps %xmm6, -0x20(%r9)
movss %xmm0, %xmm7
shufps $0x39, %xmm7, %xmm7
mulps %xmm15, %xmm7
addps -0x10(%r9), %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
saxpy_k_8a8:
movq %rdi, %rax
andq $0x10, %rax
jle saxpy_k_930
nopl (%rax)
movaps -0x74(%rcx), %xmm1
movaps -0x64(%rcx), %xmm2
movaps -0x54(%rcx), %xmm3
movaps -0x44(%rcx), %xmm4
movss %xmm1, %xmm0
shufps $0x39, %xmm0, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movss %xmm2, %xmm1
shufps $0x39, %xmm1, %xmm1
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movss %xmm3, %xmm2
shufps $0x39, %xmm2, %xmm2
mulps %xmm15, %xmm2
addps -0x60(%r9), %xmm2
movss %xmm4, %xmm3
shufps $0x39, %xmm3, %xmm3
mulps %xmm15, %xmm3
addps -0x50(%r9), %xmm3
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x70(%r9)
movaps %xmm2, -0x60(%r9)
movaps %xmm3, -0x50(%r9)
movaps %xmm4, %xmm0
addq $0x40, %rcx
addq $0x40, %r9
nopl (%rax,%rax)
saxpy_k_930:
movq %rdi, %rax
andq $0x8, %rax
jle saxpy_k_980
nopl (%rax)
movaps -0x74(%rcx), %xmm1
movaps -0x64(%rcx), %xmm2
movss %xmm1, %xmm0
shufps $0x39, %xmm0, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movss %xmm2, %xmm1
shufps $0x39, %xmm1, %xmm1
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x70(%r9)
movaps %xmm2, %xmm0
addq $0x20, %rcx
addq $0x20, %r9
nop
saxpy_k_980:
movq %rdi, %rax
andq $0x4, %rax
jle saxpy_k_9b8
nopl (%rax)
movaps -0x74(%rcx), %xmm1
movss %xmm1, %xmm0
shufps $0x39, %xmm0, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
addq $0x10, %rcx
addq $0x10, %r9
nopw (%rax,%rax)
saxpy_k_9b8:
movq %rdi, %rax
andq $0x2, %rax
jle saxpy_k_9e8
nopl (%rax)
movsd -0x80(%rcx), %xmm0
movsd -0x80(%r9), %xmm4
mulps %xmm15, %xmm0
addps %xmm4, %xmm0
movsd %xmm0, -0x80(%r9)
addq $0x8, %rcx
addq $0x8, %r9
saxpy_k_9e8:
movq %rdi, %rax
andq $0x1, %rax
jle saxpy_k_a18
nopl (%rax)
movss -0x80(%rcx), %xmm0
mulss %xmm15, %xmm0
addss -0x80(%r9), %xmm0
movss %xmm0, -0x80(%r9)
addq $0x4, %r9
nopw (%rax,%rax)
saxpy_k_a18:
xorq %rax, %rax
retq
nopl (%rax)
saxpy_k_a20:
movaps -0x8c(%rcx), %xmm0
movq %rdi, %rax
sarq $0x5, %rax
jle saxpy_k_c18
movaps -0x7c(%rcx), %xmm1
movaps -0x6c(%rcx), %xmm2
movaps -0x5c(%rcx), %xmm3
movaps -0x4c(%rcx), %xmm4
decq %rax
jle saxpy_k_b50
nopl (%rax)
saxpy_k_a50:
movaps -0x3c(%rcx), %xmm5
movaps -0x2c(%rcx), %xmm6
prefetcht0 0x580(%r9)
movss %xmm1, %xmm0
shufps $0x93, %xmm1, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
movss %xmm2, %xmm1
shufps $0x93, %xmm2, %xmm1
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x1c(%rcx), %xmm7
movaps -0xc(%rcx), %xmm0
prefetcht0 0x580(%rcx)
movss %xmm3, %xmm2
shufps $0x93, %xmm3, %xmm2
mulps %xmm15, %xmm2
addps -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
movss %xmm4, %xmm3
shufps $0x93, %xmm4, %xmm3
mulps %xmm15, %xmm3
addps -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movaps 0x4(%rcx), %xmm1
movaps 0x14(%rcx), %xmm2
prefetcht0 0x5c0(%r9)
movss %xmm5, %xmm4
shufps $0x93, %xmm5, %xmm4
mulps %xmm15, %xmm4
addps -0x40(%r9), %xmm4
movaps %xmm4, -0x40(%r9)
movss %xmm6, %xmm5
shufps $0x93, %xmm6, %xmm5
mulps %xmm15, %xmm5
addps -0x30(%r9), %xmm5
movaps %xmm5, -0x30(%r9)
movaps 0x24(%rcx), %xmm3
movaps 0x34(%rcx), %xmm4
prefetcht0 0x5c0(%rcx)
movss %xmm7, %xmm6
shufps $0x93, %xmm7, %xmm6
mulps %xmm15, %xmm6
addps -0x20(%r9), %xmm6
movaps %xmm6, -0x20(%r9)
movss %xmm0, %xmm7
shufps $0x93, %xmm0, %xmm7
mulps %xmm15, %xmm7
addps -0x10(%r9), %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
decq %rax
jg saxpy_k_a50
nop
saxpy_k_b50:
movaps -0x3c(%rcx), %xmm5
movaps -0x2c(%rcx), %xmm6
movss %xmm1, %xmm0
shufps $0x93, %xmm1, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
movss %xmm2, %xmm1
shufps $0x93, %xmm2, %xmm1
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x1c(%rcx), %xmm7
movaps -0xc(%rcx), %xmm0
movss %xmm3, %xmm2
shufps $0x93, %xmm3, %xmm2
mulps %xmm15, %xmm2
addps -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
movss %xmm4, %xmm3
shufps $0x93, %xmm4, %xmm3
mulps %xmm15, %xmm3
addps -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movss %xmm5, %xmm4
shufps $0x93, %xmm5, %xmm4
mulps %xmm15, %xmm4
addps -0x40(%r9), %xmm4
movaps %xmm4, -0x40(%r9)
movss %xmm6, %xmm5
shufps $0x93, %xmm6, %xmm5
mulps %xmm15, %xmm5
addps -0x30(%r9), %xmm5
movaps %xmm5, -0x30(%r9)
movss %xmm7, %xmm6
shufps $0x93, %xmm7, %xmm6
mulps %xmm15, %xmm6
addps -0x20(%r9), %xmm6
movaps %xmm6, -0x20(%r9)
movss %xmm0, %xmm7
shufps $0x93, %xmm0, %xmm7
mulps %xmm15, %xmm7
addps -0x10(%r9), %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
saxpy_k_c18:
movq %rdi, %rax
andq $0x10, %rax
jle saxpy_k_ca0
nopl (%rax)
movaps -0x7c(%rcx), %xmm1
movaps -0x6c(%rcx), %xmm2
movaps -0x5c(%rcx), %xmm3
movaps -0x4c(%rcx), %xmm4
movss %xmm1, %xmm0
shufps $0x93, %xmm1, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movss %xmm2, %xmm1
shufps $0x93, %xmm2, %xmm1
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movss %xmm3, %xmm2
shufps $0x93, %xmm3, %xmm2
mulps %xmm15, %xmm2
addps -0x60(%r9), %xmm2
movss %xmm4, %xmm3
shufps $0x93, %xmm4, %xmm3
mulps %xmm15, %xmm3
addps -0x50(%r9), %xmm3
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x70(%r9)
movaps %xmm2, -0x60(%r9)
movaps %xmm3, -0x50(%r9)
movaps %xmm4, %xmm0
addq $0x40, %rcx
addq $0x40, %r9
nopl (%rax,%rax)
saxpy_k_ca0:
movq %rdi, %rax
andq $0x8, %rax
jle saxpy_k_cf0
nopl (%rax)
movaps -0x7c(%rcx), %xmm1
movaps -0x6c(%rcx), %xmm2
movss %xmm1, %xmm0
shufps $0x93, %xmm1, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movss %xmm2, %xmm1
shufps $0x93, %xmm2, %xmm1
mulps %xmm15, %xmm1
addps -0x70(%r9), %xmm1
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x70(%r9)
movaps %xmm2, %xmm0
addq $0x20, %rcx
addq $0x20, %r9
nop
saxpy_k_cf0:
movq %rdi, %rax
andq $0x4, %rax
jle saxpy_k_d28
nopl (%rax)
movaps -0x7c(%rcx), %xmm1
movss %xmm1, %xmm0
shufps $0x93, %xmm1, %xmm0
mulps %xmm15, %xmm0
addps -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
addq $0x10, %rcx
addq $0x10, %r9
nopw (%rax,%rax)
saxpy_k_d28:
movq %rdi, %rax
andq $0x2, %rax
jle saxpy_k_d58
nopl (%rax)
movsd -0x80(%rcx), %xmm0
movsd -0x80(%r9), %xmm4
mulps %xmm15, %xmm0
addps %xmm4, %xmm0
movsd %xmm0, -0x80(%r9)
addq $0x8, %rcx
addq $0x8, %r9
saxpy_k_d58:
movq %rdi, %rax
andq $0x1, %rax
jle saxpy_k_d88
nopl (%rax)
movss -0x80(%rcx), %xmm0
mulss %xmm15, %xmm0
addss -0x80(%r9), %xmm0
movss %xmm0, -0x80(%r9)
addq $0x4, %r9
nopw (%rax,%rax)
saxpy_k_d88:
xorq %rax, %rax
retq
nopl (%rax)
saxpy_k_d90:
movq %rdi, %rax
movq %r9, %r11
cmpq $0x0, %r8
je saxpy_k_ed8
cmpq $0x0, %rsi
je saxpy_k_ed8
sarq $0x3, %rax
jle saxpy_k_ec8
nopl (%rax)
saxpy_k_db8:
movss (%rcx), %xmm0
addq %r8, %rcx
mulss %xmm15, %xmm0
movss (%r11), %xmm6
addq %rsi, %r11
addss %xmm6, %xmm0
movss (%rcx), %xmm1
addq %r8, %rcx
mulss %xmm15, %xmm1
movss (%r11), %xmm6
addq %rsi, %r11
addss %xmm6, %xmm1
movss (%rcx), %xmm2
addq %r8, %rcx
mulss %xmm15, %xmm2
movss (%r11), %xmm6
addq %rsi, %r11
addss %xmm6, %xmm2
movss (%rcx), %xmm3
addq %r8, %rcx
mulss %xmm15, %xmm3
movss (%r11), %xmm6
addq %rsi, %r11
addss %xmm6, %xmm3
movss %xmm0, (%r9)
addq %rsi, %r9
movss %xmm1, (%r9)
addq %rsi, %r9
movss %xmm2, (%r9)
addq %rsi, %r9
movss %xmm3, (%r9)
addq %rsi, %r9
movss (%rcx), %xmm0
addq %r8, %rcx
mulss %xmm15, %xmm0
movss (%r11), %xmm6
addq %rsi, %r11
addss %xmm6, %xmm0
movss (%rcx), %xmm1
addq %r8, %rcx
mulss %xmm15, %xmm1
movss (%r11), %xmm6
addq %rsi, %r11
addss %xmm6, %xmm1
movss (%rcx), %xmm2
addq %r8, %rcx
mulss %xmm15, %xmm2
movss (%r11), %xmm6
addq %rsi, %r11
addss %xmm6, %xmm2
movss (%rcx), %xmm3
addq %r8, %rcx
mulss %xmm15, %xmm3
movss (%r11), %xmm6
addq %rsi, %r11
addss %xmm6, %xmm3
movss %xmm0, (%r9)
addq %rsi, %r9
movss %xmm1, (%r9)
addq %rsi, %r9
movss %xmm2, (%r9)
addq %rsi, %r9
movss %xmm3, (%r9)
addq %rsi, %r9
decq %rax
jg saxpy_k_db8
nopl (%rax)
saxpy_k_ec8:
movq %rdi, %rax
andq $0x7, %rax
jle saxpy_k_f00
nopl (%rax)
saxpy_k_ed8:
movss (%rcx), %xmm0
addq %r8, %rcx
mulss %xmm15, %xmm0
movss (%r9), %xmm6
addss %xmm6, %xmm0
movss %xmm0, (%r9)
addq %rsi, %r9
decq %rax
jg saxpy_k_ed8
nopw (%rax,%rax)
saxpy_k_f00:
xorq %rax, %rax
retq
nopl (%rax)
