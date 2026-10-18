daxpy_k:
movq 0x8(%rsp), %rsi
movaps %xmm0, %xmm15
unpcklpd %xmm15, %xmm15
leaq (,%r8,8), %r8
leaq (,%rsi,8), %rsi
testq %rdi, %rdi
jle daxpy_k_790
cmpq $0x8, %r8
jne daxpy_k_650
cmpq $0x8, %rsi
jne daxpy_k_650
testq $0x8, %r9
je daxpy_k_70
movsd (%rcx), %xmm0
mulsd %xmm15, %xmm0
addsd (%r9), %xmm0
movsd %xmm0, (%r9)
addq $0x8, %rcx
addq $0x8, %r9
decq %rdi
jle daxpy_k_318
nopl (%rax,%rax)
daxpy_k_70:
subq $-0x80, %rcx
subq $-0x80, %r9
testq $0x8, %rcx
jne daxpy_k_320
movq %rdi, %rax
sarq $0x4, %rax
jle daxpy_k_218
movaps -0x80(%rcx), %xmm0
movaps -0x70(%rcx), %xmm1
movaps -0x60(%rcx), %xmm2
movaps -0x50(%rcx), %xmm3
decq %rax
jle daxpy_k_180
nopl (%rax,%rax)
daxpy_k_b0:
movaps -0x40(%rcx), %xmm4
movaps -0x30(%rcx), %xmm5
prefetcht0 0x580(%r9)
mulpd %xmm15, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
mulpd %xmm15, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x20(%rcx), %xmm6
movaps -0x10(%rcx), %xmm7
prefetcht0 0x580(%rcx)
mulpd %xmm15, %xmm2
addpd -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
mulpd %xmm15, %xmm3
addpd -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movaps (%rcx), %xmm0
movaps 0x10(%rcx), %xmm1
prefetcht0 0x5c0(%r9)
mulpd %xmm15, %xmm4
addpd -0x40(%r9), %xmm4
movaps %xmm4, -0x40(%r9)
mulpd %xmm15, %xmm5
addpd -0x30(%r9), %xmm5
movaps %xmm5, -0x30(%r9)
movaps 0x20(%rcx), %xmm2
movaps 0x30(%rcx), %xmm3
prefetcht0 0x5c0(%rcx)
mulpd %xmm15, %xmm6
addpd -0x20(%r9), %xmm6
movaps %xmm6, -0x20(%r9)
mulpd %xmm15, %xmm7
addpd -0x10(%r9), %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %r9
subq $-0x80, %rcx
decq %rax
jg daxpy_k_b0
nop
daxpy_k_180:
movaps -0x40(%rcx), %xmm4
movaps -0x30(%rcx), %xmm5
mulpd %xmm15, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
mulpd %xmm15, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x20(%rcx), %xmm6
movaps -0x10(%rcx), %xmm7
mulpd %xmm15, %xmm2
addpd -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
mulpd %xmm15, %xmm3
addpd -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
mulpd %xmm15, %xmm4
addpd -0x40(%r9), %xmm4
movaps %xmm4, -0x40(%r9)
mulpd %xmm15, %xmm5
addpd -0x30(%r9), %xmm5
movaps %xmm5, -0x30(%r9)
mulpd %xmm15, %xmm6
addpd -0x20(%r9), %xmm6
movaps %xmm6, -0x20(%r9)
mulpd %xmm15, %xmm7
addpd -0x10(%r9), %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %r9
subq $-0x80, %rcx
daxpy_k_218:
movq %rdi, %rax
andq $0x8, %rax
jle daxpy_k_280
nopl (%rax)
movaps -0x80(%rcx), %xmm0
movaps -0x70(%rcx), %xmm1
movaps -0x60(%rcx), %xmm2
movaps -0x50(%rcx), %xmm3
mulpd %xmm15, %xmm0
addpd -0x80(%r9), %xmm0
mulpd %xmm15, %xmm1
addpd -0x70(%r9), %xmm1
mulpd %xmm15, %xmm2
addpd -0x60(%r9), %xmm2
mulpd %xmm15, %xmm3
addpd -0x50(%r9), %xmm3
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x70(%r9)
movaps %xmm2, -0x60(%r9)
movaps %xmm3, -0x50(%r9)
addq $0x40, %rcx
addq $0x40, %r9
daxpy_k_280:
movq %rdi, %rax
andq $0x4, %rax
jle daxpy_k_2c0
nopl (%rax)
movaps -0x80(%rcx), %xmm0
movaps -0x70(%rcx), %xmm1
mulpd %xmm15, %xmm0
mulpd %xmm15, %xmm1
addpd -0x80(%r9), %xmm0
addpd -0x70(%r9), %xmm1
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x70(%r9)
addq $0x20, %rcx
addq $0x20, %r9
daxpy_k_2c0:
movq %rdi, %rax
andq $0x2, %rax
jle daxpy_k_2f0
nopl (%rax)
movaps -0x80(%rcx), %xmm0
mulpd %xmm15, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
addq $0x10, %rcx
addq $0x10, %r9
nopl (%rax)
daxpy_k_2f0:
movq %rdi, %rax
andq $0x1, %rax
jle daxpy_k_318
nopl (%rax)
movsd -0x80(%rcx), %xmm0
mulsd %xmm15, %xmm0
addsd -0x80(%r9), %xmm0
movsd %xmm0, -0x80(%r9)
nop
daxpy_k_318:
xorq %rax, %rax
retq
nopl (%rax)
daxpy_k_320:
movhps -0x80(%rcx), %xmm0
movq %rdi, %rax
sarq $0x4, %rax
jle daxpy_k_510
movaps -0x78(%rcx), %xmm1
movaps -0x68(%rcx), %xmm2
movaps -0x58(%rcx), %xmm3
decq %rax
jle daxpy_k_448
nopw %cs:(%rax,%rax)
daxpy_k_350:
movaps -0x48(%rcx), %xmm4
movaps -0x38(%rcx), %xmm5
prefetcht0 0x580(%r9)
shufpd $0x1, %xmm1, %xmm0
mulpd %xmm15, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
shufpd $0x1, %xmm2, %xmm1
mulpd %xmm15, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x28(%rcx), %xmm6
movaps -0x18(%rcx), %xmm7
prefetcht0 0x580(%rcx)
shufpd $0x1, %xmm3, %xmm2
mulpd %xmm15, %xmm2
addpd -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
shufpd $0x1, %xmm4, %xmm3
mulpd %xmm15, %xmm3
addpd -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movaps -0x8(%rcx), %xmm0
movaps 0x8(%rcx), %xmm1
prefetcht0 0x5c0(%r9)
shufpd $0x1, %xmm5, %xmm4
mulpd %xmm15, %xmm4
addpd -0x40(%r9), %xmm4
movaps %xmm4, -0x40(%r9)
shufpd $0x1, %xmm6, %xmm5
mulpd %xmm15, %xmm5
addpd -0x30(%r9), %xmm5
movaps %xmm5, -0x30(%r9)
movaps 0x18(%rcx), %xmm2
movaps 0x28(%rcx), %xmm3
prefetcht0 0x5c0(%rcx)
shufpd $0x1, %xmm7, %xmm6
mulpd %xmm15, %xmm6
addpd -0x20(%r9), %xmm6
movaps %xmm6, -0x20(%r9)
shufpd $0x1, %xmm0, %xmm7
mulpd %xmm15, %xmm7
addpd -0x10(%r9), %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
decq %rax
jg daxpy_k_350
nop
daxpy_k_448:
movaps -0x48(%rcx), %xmm4
movaps -0x38(%rcx), %xmm5
shufpd $0x1, %xmm1, %xmm0
mulpd %xmm15, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
movaps -0x8(%rcx), %xmm0
shufpd $0x1, %xmm2, %xmm1
mulpd %xmm15, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x28(%rcx), %xmm6
movaps -0x18(%rcx), %xmm7
shufpd $0x1, %xmm3, %xmm2
mulpd %xmm15, %xmm2
addpd -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
shufpd $0x1, %xmm4, %xmm3
mulpd %xmm15, %xmm3
addpd -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
shufpd $0x1, %xmm5, %xmm4
mulpd %xmm15, %xmm4
addpd -0x40(%r9), %xmm4
movaps %xmm4, -0x40(%r9)
shufpd $0x1, %xmm6, %xmm5
mulpd %xmm15, %xmm5
addpd -0x30(%r9), %xmm5
movaps %xmm5, -0x30(%r9)
shufpd $0x1, %xmm7, %xmm6
mulpd %xmm15, %xmm6
addpd -0x20(%r9), %xmm6
movaps %xmm6, -0x20(%r9)
shufpd $0x1, %xmm0, %xmm7
mulpd %xmm15, %xmm7
addpd -0x10(%r9), %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
nopl (%rax)
daxpy_k_510:
movq %rdi, %rax
andq $0x8, %rax
jle daxpy_k_598
nopl (%rax)
movaps -0x78(%rcx), %xmm1
movaps -0x68(%rcx), %xmm2
movaps -0x58(%rcx), %xmm3
movaps -0x48(%rcx), %xmm8
shufpd $0x1, %xmm1, %xmm0
mulpd %xmm15, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
shufpd $0x1, %xmm2, %xmm1
mulpd %xmm15, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
shufpd $0x1, %xmm3, %xmm2
mulpd %xmm15, %xmm2
addpd -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
shufpd $0x1, %xmm8, %xmm3
mulpd %xmm15, %xmm3
addpd -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movaps %xmm8, %xmm0
addq $0x40, %rcx
addq $0x40, %r9
nopw (%rax,%rax)
daxpy_k_598:
movq %rdi, %rax
andq $0x4, %rax
jle daxpy_k_5e8
nopl (%rax)
movaps -0x78(%rcx), %xmm1
movaps -0x68(%rcx), %xmm2
shufpd $0x1, %xmm1, %xmm0
shufpd $0x1, %xmm2, %xmm1
mulpd %xmm15, %xmm0
mulpd %xmm15, %xmm1
addpd -0x80(%r9), %xmm0
addpd -0x70(%r9), %xmm1
movaps %xmm0, -0x80(%r9)
movaps %xmm1, -0x70(%r9)
movaps %xmm2, %xmm0
addq $0x20, %rcx
addq $0x20, %r9
nopl (%rax)
daxpy_k_5e8:
movq %rdi, %rax
andq $0x2, %rax
jle daxpy_k_620
nopl (%rax)
movaps -0x78(%rcx), %xmm1
shufpd $0x1, %xmm1, %xmm0
mulpd %xmm15, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
addq $0x10, %rcx
addq $0x10, %r9
nopl (%rax)
daxpy_k_620:
movq %rdi, %rax
andq $0x1, %rax
jle daxpy_k_648
nopl (%rax)
movsd -0x80(%rcx), %xmm0
mulsd %xmm15, %xmm0
addsd -0x80(%r9), %xmm0
movsd %xmm0, -0x80(%r9)
nop
daxpy_k_648:
xorq %rax, %rax
retq
nopl (%rax)
daxpy_k_650:
movq %r9, %r11
movq %rdi, %rax
cmpq $0x0, %r8
je daxpy_k_770
cmpq $0x0, %rsi
je daxpy_k_770
sarq $0x3, %rax
jle daxpy_k_760
nopl (%rax)
daxpy_k_678:
movsd (%rcx), %xmm0
addq %r8, %rcx
movhpd (%rcx), %xmm0
addq %r8, %rcx
mulpd %xmm15, %xmm0
movsd (%r11), %xmm6
addq %rsi, %r11
movhpd (%r11), %xmm6
addq %rsi, %r11
addpd %xmm6, %xmm0
movsd (%rcx), %xmm1
addq %r8, %rcx
movhpd (%rcx), %xmm1
addq %r8, %rcx
mulpd %xmm15, %xmm1
movsd (%r11), %xmm6
addq %rsi, %r11
movhpd (%r11), %xmm6
addq %rsi, %r11
addpd %xmm6, %xmm1
movsd (%rcx), %xmm2
addq %r8, %rcx
movhpd (%rcx), %xmm2
addq %r8, %rcx
mulpd %xmm15, %xmm2
movsd (%r11), %xmm6
addq %rsi, %r11
movhpd (%r11), %xmm6
addq %rsi, %r11
addpd %xmm6, %xmm2
movsd (%rcx), %xmm3
addq %r8, %rcx
movhpd (%rcx), %xmm3
addq %r8, %rcx
mulpd %xmm15, %xmm3
movsd (%r11), %xmm6
addq %rsi, %r11
movhpd (%r11), %xmm6
addq %rsi, %r11
addpd %xmm6, %xmm3
movsd %xmm0, (%r9)
addq %rsi, %r9
movhpd %xmm0, (%r9)
addq %rsi, %r9
movsd %xmm1, (%r9)
addq %rsi, %r9
movhpd %xmm1, (%r9)
addq %rsi, %r9
movsd %xmm2, (%r9)
addq %rsi, %r9
movhpd %xmm2, (%r9)
addq %rsi, %r9
movsd %xmm3, (%r9)
addq %rsi, %r9
movhpd %xmm3, (%r9)
addq %rsi, %r9
decq %rax
jg daxpy_k_678
nopl (%rax)
daxpy_k_760:
movq %rdi, %rax
andq $0x7, %rax
jle daxpy_k_790
nopl (%rax)
daxpy_k_770:
movsd (%rcx), %xmm0
addq %r8, %rcx
mulsd %xmm15, %xmm0
addsd (%r9), %xmm0
movsd %xmm0, (%r9)
addq %rsi, %r9
decq %rax
jg daxpy_k_770
nop
daxpy_k_790:
xorq %rax, %rax
retq
