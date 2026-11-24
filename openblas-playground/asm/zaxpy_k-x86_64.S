zaxpy_k:
movq 0x8(%rsp), %rsi
shlq $0x4, %r8
shlq $0x4, %rsi
testq %rdi, %rdi
jle zaxpy_k_1848
cmpq $0x10, %r8
jne zaxpy_k_1260
cmpq $0x10, %rsi
jne zaxpy_k_1260
subq $-0x80, %rcx
subq $-0x80, %r9
pcmpeqb %xmm7, %xmm7
psllq $0x3f, %xmm7
movddup %xmm0, %xmm14
movddup %xmm1, %xmm15
shufps $0xc, %xmm7, %xmm7
xorpd %xmm7, %xmm15
testq $0x8, %r9
jne zaxpy_k_888
testq $0x8, %rcx
jne zaxpy_k_438
movq %rdi, %rax
sarq $0x3, %rax
jle zaxpy_k_2f8
movaps -0x80(%rcx), %xmm0
movaps -0x70(%rcx), %xmm1
movaps -0x60(%rcx), %xmm2
movaps -0x50(%rcx), %xmm3
decq %rax
jle zaxpy_k_1e0
nop
zaxpy_k_90:
movaps -0x40(%rcx), %xmm4
movaps -0x30(%rcx), %xmm5
prefetcht0 0x580(%r9)
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd -0x80(%r9), %xmm0
addpd %xmm8, %xmm0
movaps %xmm0, -0x80(%r9)
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd -0x70(%r9), %xmm1
addpd %xmm8, %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x20(%rcx), %xmm6
movaps -0x10(%rcx), %xmm7
prefetcht0 0x580(%rcx)
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd -0x60(%r9), %xmm2
addpd %xmm8, %xmm2
movaps %xmm2, -0x60(%r9)
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd -0x50(%r9), %xmm3
addpd %xmm8, %xmm3
movaps %xmm3, -0x50(%r9)
movaps (%rcx), %xmm0
movaps 0x10(%rcx), %xmm1
prefetcht0 0x5c0(%r9)
pshufd $0x4e, %xmm4, %xmm8
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm8
addpd -0x40(%r9), %xmm4
addpd %xmm8, %xmm4
movaps %xmm4, -0x40(%r9)
pshufd $0x4e, %xmm5, %xmm8
mulpd %xmm14, %xmm5
mulpd %xmm15, %xmm8
addpd -0x30(%r9), %xmm5
addpd %xmm8, %xmm5
movaps %xmm5, -0x30(%r9)
movaps 0x20(%rcx), %xmm2
movaps 0x30(%rcx), %xmm3
prefetcht0 0x5c0(%rcx)
pshufd $0x4e, %xmm6, %xmm8
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm8
addpd -0x20(%r9), %xmm6
addpd %xmm8, %xmm6
movaps %xmm6, -0x20(%r9)
pshufd $0x4e, %xmm7, %xmm8
mulpd %xmm14, %xmm7
mulpd %xmm15, %xmm8
addpd -0x10(%r9), %xmm7
addpd %xmm8, %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
decq %rax
jg zaxpy_k_90
nop
zaxpy_k_1e0:
movaps -0x40(%rcx), %xmm4
movaps -0x30(%rcx), %xmm5
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd -0x80(%r9), %xmm0
addpd %xmm8, %xmm0
movaps %xmm0, -0x80(%r9)
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd -0x70(%r9), %xmm1
addpd %xmm8, %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x20(%rcx), %xmm6
movaps -0x10(%rcx), %xmm7
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd -0x60(%r9), %xmm2
addpd %xmm8, %xmm2
movaps %xmm2, -0x60(%r9)
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd -0x50(%r9), %xmm3
addpd %xmm8, %xmm3
movaps %xmm3, -0x50(%r9)
pshufd $0x4e, %xmm4, %xmm8
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm8
addpd -0x40(%r9), %xmm4
addpd %xmm8, %xmm4
movaps %xmm4, -0x40(%r9)
pshufd $0x4e, %xmm5, %xmm8
mulpd %xmm14, %xmm5
mulpd %xmm15, %xmm8
addpd -0x30(%r9), %xmm5
addpd %xmm8, %xmm5
movaps %xmm5, -0x30(%r9)
pshufd $0x4e, %xmm6, %xmm8
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm8
addpd -0x20(%r9), %xmm6
addpd %xmm8, %xmm6
movaps %xmm6, -0x20(%r9)
pshufd $0x4e, %xmm7, %xmm8
mulpd %xmm14, %xmm7
mulpd %xmm15, %xmm8
addpd -0x10(%r9), %xmm7
addpd %xmm8, %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
zaxpy_k_2f8:
movq %rdi, %rax
andq $0x4, %rax
jle zaxpy_k_3a0
movaps -0x80(%rcx), %xmm0
movaps -0x70(%rcx), %xmm1
movaps -0x60(%rcx), %xmm2
movaps -0x50(%rcx), %xmm3
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd -0x80(%r9), %xmm0
addpd %xmm8, %xmm0
movaps %xmm0, -0x80(%r9)
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd -0x70(%r9), %xmm1
addpd %xmm8, %xmm1
movaps %xmm1, -0x70(%r9)
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd -0x60(%r9), %xmm2
addpd %xmm8, %xmm2
movaps %xmm2, -0x60(%r9)
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd -0x50(%r9), %xmm3
addpd %xmm8, %xmm3
movaps %xmm3, -0x50(%r9)
addq $0x40, %rcx
addq $0x40, %r9
nopl (%rax)
zaxpy_k_3a0:
movq %rdi, %rax
andq $0x2, %rax
jle zaxpy_k_400
movaps -0x80(%rcx), %xmm0
movaps -0x70(%rcx), %xmm1
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd -0x80(%r9), %xmm0
addpd %xmm8, %xmm0
movaps %xmm0, -0x80(%r9)
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd -0x70(%r9), %xmm1
addpd %xmm8, %xmm1
movaps %xmm1, -0x70(%r9)
addq $0x20, %rcx
addq $0x20, %r9
nopl (%rax)
zaxpy_k_400:
movq %rdi, %rax
andq $0x1, %rax
jle zaxpy_k_1848
movaps -0x80(%rcx), %xmm0
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd -0x80(%r9), %xmm0
addpd %xmm8, %xmm0
movaps %xmm0, -0x80(%r9)
jmp zaxpy_k_1848
nop
zaxpy_k_438:
movq %rdi, %rax
sarq $0x3, %rax
jle zaxpy_k_720
movsd -0x80(%rcx), %xmm0
movhps -0x78(%rcx), %xmm0
movsd -0x70(%rcx), %xmm1
movhps -0x68(%rcx), %xmm1
movsd -0x60(%rcx), %xmm2
movhps -0x58(%rcx), %xmm2
movsd -0x50(%rcx), %xmm3
movhps -0x48(%rcx), %xmm3
decq %rax
jle zaxpy_k_5f0
nopw (%rax,%rax)
zaxpy_k_478:
movsd -0x40(%rcx), %xmm4
movhps -0x38(%rcx), %xmm4
prefetcht0 0x580(%r9)
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd -0x80(%r9), %xmm0
addpd %xmm8, %xmm0
movaps %xmm0, -0x80(%r9)
movsd -0x30(%rcx), %xmm5
movhps -0x28(%rcx), %xmm5
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd -0x70(%r9), %xmm1
addpd %xmm8, %xmm1
movaps %xmm1, -0x70(%r9)
movsd -0x20(%rcx), %xmm6
movhps -0x18(%rcx), %xmm6
prefetcht0 0x580(%rcx)
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd -0x60(%r9), %xmm2
addpd %xmm8, %xmm2
movaps %xmm2, -0x60(%r9)
movsd -0x10(%rcx), %xmm7
movhps -0x8(%rcx), %xmm7
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd -0x50(%r9), %xmm3
addpd %xmm8, %xmm3
movaps %xmm3, -0x50(%r9)
movsd (%rcx), %xmm0
movhps 0x8(%rcx), %xmm0
prefetcht0 0x5c0(%r9)
pshufd $0x4e, %xmm4, %xmm8
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm8
addpd -0x40(%r9), %xmm4
addpd %xmm8, %xmm4
movaps %xmm4, -0x40(%r9)
movsd 0x10(%rcx), %xmm1
movhps 0x18(%rcx), %xmm1
pshufd $0x4e, %xmm5, %xmm8
mulpd %xmm14, %xmm5
mulpd %xmm15, %xmm8
addpd -0x30(%r9), %xmm5
addpd %xmm8, %xmm5
movaps %xmm5, -0x30(%r9)
movsd 0x20(%rcx), %xmm2
movhps 0x28(%rcx), %xmm2
prefetcht0 0x5c0(%rcx)
pshufd $0x4e, %xmm6, %xmm8
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm8
addpd -0x20(%r9), %xmm6
addpd %xmm8, %xmm6
movaps %xmm6, -0x20(%r9)
movsd 0x30(%rcx), %xmm3
movhps 0x38(%rcx), %xmm3
pshufd $0x4e, %xmm7, %xmm8
mulpd %xmm14, %xmm7
mulpd %xmm15, %xmm8
addpd -0x10(%r9), %xmm7
addpd %xmm8, %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
decq %rax
jg zaxpy_k_478
nop
zaxpy_k_5f0:
movsd -0x40(%rcx), %xmm4
movhps -0x38(%rcx), %xmm4
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd -0x80(%r9), %xmm0
addpd %xmm8, %xmm0
movaps %xmm0, -0x80(%r9)
movsd -0x30(%rcx), %xmm5
movhps -0x28(%rcx), %xmm5
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd -0x70(%r9), %xmm1
addpd %xmm8, %xmm1
movaps %xmm1, -0x70(%r9)
movsd -0x20(%rcx), %xmm6
movhps -0x18(%rcx), %xmm6
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd -0x60(%r9), %xmm2
addpd %xmm8, %xmm2
movaps %xmm2, -0x60(%r9)
movsd -0x10(%rcx), %xmm7
movhps -0x8(%rcx), %xmm7
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd -0x50(%r9), %xmm3
addpd %xmm8, %xmm3
movaps %xmm3, -0x50(%r9)
pshufd $0x4e, %xmm4, %xmm8
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm8
addpd -0x40(%r9), %xmm4
addpd %xmm8, %xmm4
movaps %xmm4, -0x40(%r9)
pshufd $0x4e, %xmm5, %xmm8
mulpd %xmm14, %xmm5
mulpd %xmm15, %xmm8
addpd -0x30(%r9), %xmm5
addpd %xmm8, %xmm5
movaps %xmm5, -0x30(%r9)
pshufd $0x4e, %xmm6, %xmm8
mulpd %xmm14, %xmm6
mulpd %xmm15, %xmm8
addpd -0x20(%r9), %xmm6
addpd %xmm8, %xmm6
movaps %xmm6, -0x20(%r9)
pshufd $0x4e, %xmm7, %xmm8
mulpd %xmm14, %xmm7
mulpd %xmm15, %xmm8
addpd -0x10(%r9), %xmm7
addpd %xmm8, %xmm7
movaps %xmm7, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
nopl (%rax)
zaxpy_k_720:
movq %rdi, %rax
andq $0x4, %rax
jle zaxpy_k_7e0
movsd -0x80(%rcx), %xmm0
movhps -0x78(%rcx), %xmm0
movsd -0x70(%rcx), %xmm1
movhps -0x68(%rcx), %xmm1
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd -0x80(%r9), %xmm0
addpd %xmm8, %xmm0
movaps %xmm0, -0x80(%r9)
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd -0x70(%r9), %xmm1
addpd %xmm8, %xmm1
movaps %xmm1, -0x70(%r9)
movsd -0x60(%rcx), %xmm2
movhps -0x58(%rcx), %xmm2
movsd -0x50(%rcx), %xmm3
movhps -0x48(%rcx), %xmm3
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd -0x60(%r9), %xmm2
addpd %xmm8, %xmm2
movaps %xmm2, -0x60(%r9)
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd -0x50(%r9), %xmm3
addpd %xmm8, %xmm3
movaps %xmm3, -0x50(%r9)
addq $0x40, %rcx
addq $0x40, %r9
nopl (%rax)
zaxpy_k_7e0:
movq %rdi, %rax
andq $0x2, %rax
jle zaxpy_k_848
movsd -0x80(%rcx), %xmm0
movhps -0x78(%rcx), %xmm0
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd -0x80(%r9), %xmm0
addpd %xmm8, %xmm0
movaps %xmm0, -0x80(%r9)
movsd -0x70(%rcx), %xmm1
movhps -0x68(%rcx), %xmm1
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd -0x70(%r9), %xmm1
addpd %xmm8, %xmm1
movaps %xmm1, -0x70(%r9)
addq $0x20, %rcx
addq $0x20, %r9
nopl (%rax,%rax)
zaxpy_k_848:
movq %rdi, %rax
andq $0x1, %rax
jle zaxpy_k_1848
movsd -0x80(%rcx), %xmm0
movhps -0x78(%rcx), %xmm0
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd -0x80(%r9), %xmm0
addpd %xmm8, %xmm0
movaps %xmm0, -0x80(%r9)
jmp zaxpy_k_1848
nopl (%rax,%rax)
zaxpy_k_888:
testq $0x8, %rcx
jne zaxpy_k_d40
movaps -0x80(%rcx), %xmm1
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
xorps %xmm0, %xmm0
shufpd $0x1, %xmm1, %xmm0
xorps %xmm4, %xmm4
movhps -0x80(%r9), %xmm4
addpd %xmm0, %xmm4
movhps %xmm4, -0x80(%r9)
movaps %xmm1, %xmm0
addq $0x10, %rcx
addq $0x8, %r9
decq %rdi
jle zaxpy_k_d28
movq %rdi, %rax
sarq $0x3, %rax
jle zaxpy_k_bc0
movaps -0x80(%rcx), %xmm1
movaps -0x70(%rcx), %xmm2
movaps -0x60(%rcx), %xmm3
decq %rax
jle zaxpy_k_a78
nopl (%rax)
zaxpy_k_900:
prefetcht0 0x580(%r9)
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
movaps -0x50(%rcx), %xmm0
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm2
shufpd $0x1, %xmm2, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x40(%rcx), %xmm1
prefetcht0 0x580(%rcx)
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm3
shufpd $0x1, %xmm3, %xmm2
addpd -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
movaps -0x30(%rcx), %xmm2
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm0
shufpd $0x1, %xmm0, %xmm3
addpd -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movaps -0x20(%rcx), %xmm3
prefetcht0 0x5c0(%r9)
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x40(%r9), %xmm0
movaps %xmm0, -0x40(%r9)
movaps -0x10(%rcx), %xmm0
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm2
shufpd $0x1, %xmm2, %xmm1
addpd -0x30(%r9), %xmm1
movaps %xmm1, -0x30(%r9)
movaps (%rcx), %xmm1
prefetcht0 0x5c0(%rcx)
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm3
shufpd $0x1, %xmm3, %xmm2
addpd -0x20(%r9), %xmm2
movaps %xmm2, -0x20(%r9)
movaps 0x10(%rcx), %xmm2
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm0
shufpd $0x1, %xmm0, %xmm3
addpd -0x10(%r9), %xmm3
movaps %xmm3, -0x10(%r9)
movaps 0x20(%rcx), %xmm3
subq $-0x80, %rcx
subq $-0x80, %r9
decq %rax
jg zaxpy_k_900
nop
zaxpy_k_a78:
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
movaps -0x50(%rcx), %xmm0
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm2
shufpd $0x1, %xmm2, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps -0x40(%rcx), %xmm1
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm3
shufpd $0x1, %xmm3, %xmm2
addpd -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
movaps -0x30(%rcx), %xmm2
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm0
shufpd $0x1, %xmm0, %xmm3
addpd -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movaps -0x20(%rcx), %xmm3
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x40(%r9), %xmm0
movaps %xmm0, -0x40(%r9)
movaps -0x10(%rcx), %xmm0
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm2
shufpd $0x1, %xmm2, %xmm1
addpd -0x30(%r9), %xmm1
movaps %xmm1, -0x30(%r9)
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm3
shufpd $0x1, %xmm3, %xmm2
addpd -0x20(%r9), %xmm2
movaps %xmm2, -0x20(%r9)
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm0
shufpd $0x1, %xmm0, %xmm3
addpd -0x10(%r9), %xmm3
movaps %xmm3, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
nopl (%rax)
zaxpy_k_bc0:
movq %rdi, %rax
andq $0x4, %rax
jle zaxpy_k_c80
movaps -0x80(%rcx), %xmm1
movaps -0x70(%rcx), %xmm2
movaps -0x60(%rcx), %xmm3
movaps -0x50(%rcx), %xmm4
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm2
shufpd $0x1, %xmm2, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm3
shufpd $0x1, %xmm3, %xmm2
addpd -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
pshufd $0x4e, %xmm4, %xmm8
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm4
shufpd $0x1, %xmm4, %xmm3
addpd -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movaps %xmm4, %xmm0
addq $0x40, %rcx
addq $0x40, %r9
nopl (%rax)
zaxpy_k_c80:
movq %rdi, %rax
andq $0x2, %rax
jle zaxpy_k_ce8
movaps -0x80(%rcx), %xmm1
movaps -0x70(%rcx), %xmm2
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm2
shufpd $0x1, %xmm2, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps %xmm2, %xmm0
addq $0x20, %rcx
addq $0x20, %r9
nop
zaxpy_k_ce8:
movq %rdi, %rax
andq $0x1, %rax
jle zaxpy_k_d28
movaps -0x80(%rcx), %xmm1
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
movaps %xmm1, %xmm0
addq $0x10, %rcx
addq $0x10, %r9
nopl (%rax)
zaxpy_k_d28:
shufpd $0x1, %xmm0, %xmm0
addsd -0x80(%r9), %xmm0
movlps %xmm0, -0x80(%r9)
jmp zaxpy_k_1848
nopl (%rax)
zaxpy_k_d40:
movsd -0x80(%rcx), %xmm1
movhps -0x78(%rcx), %xmm1
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
xorps %xmm0, %xmm0
shufpd $0x1, %xmm1, %xmm0
xorps %xmm4, %xmm4
movhps -0x80(%r9), %xmm4
addpd %xmm0, %xmm4
movhps %xmm4, -0x80(%r9)
movaps %xmm1, %xmm0
addq $0x10, %rcx
addq $0x8, %r9
decq %rdi
jle zaxpy_k_1248
movq %rdi, %rax
sarq $0x3, %rax
jle zaxpy_k_10c0
movsd -0x80(%rcx), %xmm1
movhps -0x78(%rcx), %xmm1
movsd -0x70(%rcx), %xmm2
movhps -0x68(%rcx), %xmm2
movsd -0x60(%rcx), %xmm3
movhps -0x58(%rcx), %xmm3
decq %rax
jle zaxpy_k_f60
nopl (%rax)
zaxpy_k_dc0:
prefetcht0 0x580(%r9)
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
movsd -0x50(%rcx), %xmm0
movhps -0x48(%rcx), %xmm0
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm2
shufpd $0x1, %xmm2, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movsd -0x40(%rcx), %xmm1
movhps -0x38(%rcx), %xmm1
prefetcht0 0x580(%rcx)
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm3
shufpd $0x1, %xmm3, %xmm2
addpd -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
movsd -0x30(%rcx), %xmm2
movhps -0x28(%rcx), %xmm2
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm0
shufpd $0x1, %xmm0, %xmm3
addpd -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movsd -0x20(%rcx), %xmm3
movhps -0x18(%rcx), %xmm3
prefetcht0 0x5c0(%r9)
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x40(%r9), %xmm0
movaps %xmm0, -0x40(%r9)
movsd -0x10(%rcx), %xmm0
movhps -0x8(%rcx), %xmm0
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm2
shufpd $0x1, %xmm2, %xmm1
addpd -0x30(%r9), %xmm1
movaps %xmm1, -0x30(%r9)
movsd (%rcx), %xmm1
movhps 0x8(%rcx), %xmm1
prefetcht0 0x5c0(%rcx)
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm3
shufpd $0x1, %xmm3, %xmm2
addpd -0x20(%r9), %xmm2
movaps %xmm2, -0x20(%r9)
movsd 0x10(%rcx), %xmm2
movhps 0x18(%rcx), %xmm2
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm0
shufpd $0x1, %xmm0, %xmm3
addpd -0x10(%r9), %xmm3
movaps %xmm3, -0x10(%r9)
movsd 0x20(%rcx), %xmm3
movhps 0x28(%rcx), %xmm3
subq $-0x80, %rcx
subq $-0x80, %r9
decq %rax
jg zaxpy_k_dc0
nop
zaxpy_k_f60:
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
movsd -0x50(%rcx), %xmm0
movhps -0x48(%rcx), %xmm0
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm2
shufpd $0x1, %xmm2, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movsd -0x40(%rcx), %xmm1
movhps -0x38(%rcx), %xmm1
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm3
shufpd $0x1, %xmm3, %xmm2
addpd -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
movsd -0x30(%rcx), %xmm2
movhps -0x28(%rcx), %xmm2
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm0
shufpd $0x1, %xmm0, %xmm3
addpd -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movsd -0x20(%rcx), %xmm3
movhps -0x18(%rcx), %xmm3
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x40(%r9), %xmm0
movaps %xmm0, -0x40(%r9)
movsd -0x10(%rcx), %xmm0
movhps -0x8(%rcx), %xmm0
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm2
shufpd $0x1, %xmm2, %xmm1
addpd -0x30(%r9), %xmm1
movaps %xmm1, -0x30(%r9)
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm3
shufpd $0x1, %xmm3, %xmm2
addpd -0x20(%r9), %xmm2
movaps %xmm2, -0x20(%r9)
pshufd $0x4e, %xmm0, %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm0
shufpd $0x1, %xmm0, %xmm3
addpd -0x10(%r9), %xmm3
movaps %xmm3, -0x10(%r9)
subq $-0x80, %rcx
subq $-0x80, %r9
nopl (%rax)
zaxpy_k_10c0:
movq %rdi, %rax
andq $0x4, %rax
jle zaxpy_k_1190
movsd -0x80(%rcx), %xmm1
movhps -0x78(%rcx), %xmm1
movsd -0x70(%rcx), %xmm2
movhps -0x68(%rcx), %xmm2
movsd -0x60(%rcx), %xmm3
movhps -0x58(%rcx), %xmm3
movsd -0x50(%rcx), %xmm4
movhps -0x48(%rcx), %xmm4
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm2
shufpd $0x1, %xmm2, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
pshufd $0x4e, %xmm3, %xmm8
mulpd %xmm14, %xmm3
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm3
shufpd $0x1, %xmm3, %xmm2
addpd -0x60(%r9), %xmm2
movaps %xmm2, -0x60(%r9)
pshufd $0x4e, %xmm4, %xmm8
mulpd %xmm14, %xmm4
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm4
shufpd $0x1, %xmm4, %xmm3
addpd -0x50(%r9), %xmm3
movaps %xmm3, -0x50(%r9)
movaps %xmm4, %xmm0
addq $0x40, %rcx
addq $0x40, %r9
zaxpy_k_1190:
movq %rdi, %rax
andq $0x2, %rax
jle zaxpy_k_1200
movsd -0x80(%rcx), %xmm1
movhps -0x78(%rcx), %xmm1
movsd -0x70(%rcx), %xmm2
movhps -0x68(%rcx), %xmm2
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
pshufd $0x4e, %xmm2, %xmm8
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm2
shufpd $0x1, %xmm2, %xmm1
addpd -0x70(%r9), %xmm1
movaps %xmm1, -0x70(%r9)
movaps %xmm2, %xmm0
addq $0x20, %rcx
addq $0x20, %r9
zaxpy_k_1200:
movq %rdi, %rax
andq $0x1, %rax
jle zaxpy_k_1248
movsd -0x80(%rcx), %xmm1
movhps -0x78(%rcx), %xmm1
pshufd $0x4e, %xmm1, %xmm8
mulpd %xmm14, %xmm1
mulpd %xmm15, %xmm8
addpd %xmm8, %xmm1
shufpd $0x1, %xmm1, %xmm0
addpd -0x80(%r9), %xmm0
movaps %xmm0, -0x80(%r9)
movaps %xmm1, %xmm0
addq $0x10, %rcx
addq $0x10, %r9
nopw (%rax,%rax)
zaxpy_k_1248:
shufpd $0x1, %xmm0, %xmm0
addsd -0x80(%r9), %xmm0
movlps %xmm0, -0x80(%r9)
jmp zaxpy_k_1848
nopl (%rax)
zaxpy_k_1260:
movaps %xmm0, %xmm14
pxor %xmm15, %xmm15
subsd %xmm1, %xmm15
unpcklpd %xmm14, %xmm15
unpcklpd %xmm1, %xmm14
movq %r9, %r11
movq %rdi, %rax
cmpq $0x0, %r8
jne zaxpy_k_128e
cmpq $0x0, %rsi
je zaxpy_k_1809
zaxpy_k_128e:
sarq $0x3, %rax
jle zaxpy_k_1678
movddup (%rcx), %xmm0
movddup 0x8(%rcx), %xmm1
addq %r8, %rcx
movddup (%rcx), %xmm2
movddup 0x8(%rcx), %xmm3
addq %r8, %rcx
movddup (%rcx), %xmm4
movddup 0x8(%rcx), %xmm5
addq %r8, %rcx
movddup (%rcx), %xmm6
movddup 0x8(%rcx), %xmm7
addq %r8, %rcx
movsd (%r9), %xmm8
movhpd 0x8(%r9), %xmm8
addq %rsi, %r9
movsd (%r9), %xmm9
movhpd 0x8(%r9), %xmm9
addq %rsi, %r9
movsd (%r9), %xmm10
movhpd 0x8(%r9), %xmm10
addq %rsi, %r9
movsd (%r9), %xmm11
movhpd 0x8(%r9), %xmm11
addq %rsi, %r9
mulpd %xmm14, %xmm0
mulpd %xmm14, %xmm2
mulpd %xmm14, %xmm4
mulpd %xmm14, %xmm6
decq %rax
jle zaxpy_k_1510
nopl (%rax)
zaxpy_k_1320:
addpd %xmm0, %xmm8
mulpd %xmm15, %xmm1
addpd %xmm2, %xmm9
mulpd %xmm15, %xmm3
addpd %xmm4, %xmm10
mulpd %xmm15, %xmm5
addpd %xmm6, %xmm11
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm8
addpd %xmm3, %xmm9
addpd %xmm5, %xmm10
addpd %xmm7, %xmm11
movddup (%rcx), %xmm0
movddup 0x8(%rcx), %xmm1
addq %r8, %rcx
movddup (%rcx), %xmm2
movddup 0x8(%rcx), %xmm3
addq %r8, %rcx
movddup (%rcx), %xmm4
movddup 0x8(%rcx), %xmm5
addq %r8, %rcx
movddup (%rcx), %xmm6
movddup 0x8(%rcx), %xmm7
addq %r8, %rcx
mulpd %xmm14, %xmm0
mulpd %xmm14, %xmm2
mulpd %xmm14, %xmm4
mulpd %xmm14, %xmm6
movlpd %xmm8, (%r11)
movhpd %xmm8, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm9, (%r11)
movhpd %xmm9, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm10, (%r11)
movhpd %xmm10, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm11, (%r11)
movhpd %xmm11, 0x8(%r11)
addq %rsi, %r11
movsd (%r9), %xmm8
movhpd 0x8(%r9), %xmm8
addq %rsi, %r9
movsd (%r9), %xmm9
movhpd 0x8(%r9), %xmm9
addq %rsi, %r9
movsd (%r9), %xmm10
movhpd 0x8(%r9), %xmm10
addq %rsi, %r9
movsd (%r9), %xmm11
movhpd 0x8(%r9), %xmm11
addq %rsi, %r9
addpd %xmm0, %xmm8
mulpd %xmm15, %xmm1
addpd %xmm2, %xmm9
mulpd %xmm15, %xmm3
addpd %xmm4, %xmm10
mulpd %xmm15, %xmm5
addpd %xmm6, %xmm11
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm8
addpd %xmm3, %xmm9
addpd %xmm5, %xmm10
addpd %xmm7, %xmm11
movddup (%rcx), %xmm0
movddup 0x8(%rcx), %xmm1
addq %r8, %rcx
movddup (%rcx), %xmm2
movddup 0x8(%rcx), %xmm3
addq %r8, %rcx
movddup (%rcx), %xmm4
movddup 0x8(%rcx), %xmm5
addq %r8, %rcx
movddup (%rcx), %xmm6
movddup 0x8(%rcx), %xmm7
addq %r8, %rcx
mulpd %xmm14, %xmm0
mulpd %xmm14, %xmm2
mulpd %xmm14, %xmm4
mulpd %xmm14, %xmm6
movlpd %xmm8, (%r11)
movhpd %xmm8, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm9, (%r11)
movhpd %xmm9, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm10, (%r11)
movhpd %xmm10, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm11, (%r11)
movhpd %xmm11, 0x8(%r11)
addq %rsi, %r11
movsd (%r9), %xmm8
movhpd 0x8(%r9), %xmm8
addq %rsi, %r9
movsd (%r9), %xmm9
movhpd 0x8(%r9), %xmm9
addq %rsi, %r9
movsd (%r9), %xmm10
movhpd 0x8(%r9), %xmm10
addq %rsi, %r9
movsd (%r9), %xmm11
movhpd 0x8(%r9), %xmm11
addq %rsi, %r9
decq %rax
jg zaxpy_k_1320
nopl (%rax)
zaxpy_k_1510:
addpd %xmm0, %xmm8
mulpd %xmm15, %xmm1
addpd %xmm2, %xmm9
mulpd %xmm15, %xmm3
addpd %xmm4, %xmm10
mulpd %xmm15, %xmm5
addpd %xmm6, %xmm11
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm8
addpd %xmm3, %xmm9
addpd %xmm5, %xmm10
addpd %xmm7, %xmm11
movddup (%rcx), %xmm0
movddup 0x8(%rcx), %xmm1
addq %r8, %rcx
movddup (%rcx), %xmm2
movddup 0x8(%rcx), %xmm3
addq %r8, %rcx
movddup (%rcx), %xmm4
movddup 0x8(%rcx), %xmm5
addq %r8, %rcx
movddup (%rcx), %xmm6
movddup 0x8(%rcx), %xmm7
addq %r8, %rcx
mulpd %xmm14, %xmm0
mulpd %xmm14, %xmm2
mulpd %xmm14, %xmm4
mulpd %xmm14, %xmm6
movlpd %xmm8, (%r11)
movhpd %xmm8, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm9, (%r11)
movhpd %xmm9, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm10, (%r11)
movhpd %xmm10, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm11, (%r11)
movhpd %xmm11, 0x8(%r11)
addq %rsi, %r11
movsd (%r9), %xmm8
movhpd 0x8(%r9), %xmm8
addq %rsi, %r9
movsd (%r9), %xmm9
movhpd 0x8(%r9), %xmm9
addq %rsi, %r9
movsd (%r9), %xmm10
movhpd 0x8(%r9), %xmm10
addq %rsi, %r9
movsd (%r9), %xmm11
movhpd 0x8(%r9), %xmm11
addq %rsi, %r9
addpd %xmm0, %xmm8
mulpd %xmm15, %xmm1
addpd %xmm2, %xmm9
mulpd %xmm15, %xmm3
addpd %xmm4, %xmm10
mulpd %xmm15, %xmm5
addpd %xmm6, %xmm11
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm8
addpd %xmm3, %xmm9
addpd %xmm5, %xmm10
addpd %xmm7, %xmm11
movlpd %xmm8, (%r11)
movhpd %xmm8, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm9, (%r11)
movhpd %xmm9, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm10, (%r11)
movhpd %xmm10, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm11, (%r11)
movhpd %xmm11, 0x8(%r11)
addq %rsi, %r11
nopl (%rax)
zaxpy_k_1678:
movq %rdi, %rax
andq $0x4, %rax
jle zaxpy_k_1778
movddup (%rcx), %xmm0
movddup 0x8(%rcx), %xmm1
addq %r8, %rcx
movddup (%rcx), %xmm2
movddup 0x8(%rcx), %xmm3
addq %r8, %rcx
movddup (%rcx), %xmm4
movddup 0x8(%rcx), %xmm5
addq %r8, %rcx
movddup (%rcx), %xmm6
movddup 0x8(%rcx), %xmm7
addq %r8, %rcx
movsd (%r9), %xmm8
movhpd 0x8(%r9), %xmm8
addq %rsi, %r9
movsd (%r9), %xmm9
movhpd 0x8(%r9), %xmm9
addq %rsi, %r9
movsd (%r9), %xmm10
movhpd 0x8(%r9), %xmm10
addq %rsi, %r9
movsd (%r9), %xmm11
movhpd 0x8(%r9), %xmm11
addq %rsi, %r9
mulpd %xmm14, %xmm0
mulpd %xmm14, %xmm2
mulpd %xmm14, %xmm4
mulpd %xmm14, %xmm6
addpd %xmm0, %xmm8
mulpd %xmm15, %xmm1
addpd %xmm2, %xmm9
mulpd %xmm15, %xmm3
addpd %xmm4, %xmm10
mulpd %xmm15, %xmm5
addpd %xmm6, %xmm11
mulpd %xmm15, %xmm7
addpd %xmm1, %xmm8
addpd %xmm3, %xmm9
addpd %xmm5, %xmm10
addpd %xmm7, %xmm11
movlpd %xmm8, (%r11)
movhpd %xmm8, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm9, (%r11)
movhpd %xmm9, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm10, (%r11)
movhpd %xmm10, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm11, (%r11)
movhpd %xmm11, 0x8(%r11)
addq %rsi, %r11
nopl (%rax)
zaxpy_k_1778:
movq %rdi, %rax
andq $0x2, %rax
jle zaxpy_k_1800
movddup (%rcx), %xmm0
movddup 0x8(%rcx), %xmm1
addq %r8, %rcx
movddup (%rcx), %xmm2
movddup 0x8(%rcx), %xmm3
addq %r8, %rcx
movsd (%r9), %xmm8
movhpd 0x8(%r9), %xmm8
addq %rsi, %r9
movsd (%r9), %xmm9
movhpd 0x8(%r9), %xmm9
addq %rsi, %r9
mulpd %xmm14, %xmm0
mulpd %xmm14, %xmm2
mulpd %xmm15, %xmm1
mulpd %xmm15, %xmm3
addpd %xmm0, %xmm8
addpd %xmm2, %xmm9
addpd %xmm1, %xmm8
addpd %xmm3, %xmm9
movlpd %xmm8, (%r11)
movhpd %xmm8, 0x8(%r11)
addq %rsi, %r11
movlpd %xmm9, (%r11)
movhpd %xmm9, 0x8(%r11)
addq %rsi, %r11
nopl (%rax)
zaxpy_k_1800:
movq %rdi, %rax
andq $0x1, %rax
jle zaxpy_k_1848
zaxpy_k_1809:
movddup (%rcx), %xmm0
movddup 0x8(%rcx), %xmm1
movsd (%r9), %xmm8
movhpd 0x8(%r9), %xmm8
mulpd %xmm14, %xmm0
mulpd %xmm15, %xmm1
addpd %xmm0, %xmm8
addpd %xmm1, %xmm8
movlpd %xmm8, (%r11)
movhpd %xmm8, 0x8(%r11)
decq %rax
jg zaxpy_k_1809
nopl (%rax)
zaxpy_k_1848:
xorq %rax, %rax
retq
