dgemm_beta:
movq 0x10(%rsp), %rdx
movq 0x18(%rsp), %rcx
pxor %xmm1, %xmm1
testq %rdi, %rdi
jle dgemm_beta_1b0
testq %rsi, %rsi
jle dgemm_beta_1b0
ucomisd %xmm1, %xmm0
jne dgemm_beta_b0
nopw (%rax,%rax)
dgemm_beta_30:
movq %rdx, %r8
leaq (%rdx,%rcx,8), %rdx
movq %rdi, %rax
sarq $0x3, %rax
jle dgemm_beta_80
dgemm_beta_40:
movsd %xmm0, (%r8)
movsd %xmm0, 0x8(%r8)
movsd %xmm0, 0x10(%r8)
movsd %xmm0, 0x18(%r8)
movsd %xmm0, 0x20(%r8)
movsd %xmm0, 0x28(%r8)
movsd %xmm0, 0x30(%r8)
movsd %xmm0, 0x38(%r8)
addq $0x40, %r8
decq %rax
jg dgemm_beta_40
nopl (%rax,%rax)
dgemm_beta_80:
movq %rdi, %rax
andq $0x7, %rax
jle dgemm_beta_a0
nopl (%rax)
dgemm_beta_90:
movsd %xmm0, (%r8)
addq $0x8, %r8
decq %rax
jg dgemm_beta_90
nop
dgemm_beta_a0:
decq %rsi
jg dgemm_beta_30
jmp dgemm_beta_1b0
nopw (%rax,%rax)
dgemm_beta_b0:
movq %rdx, %r8
leaq (%rdx,%rcx,8), %rdx
movq %rdi, %rax
sarq $0x3, %rax
jle dgemm_beta_170
nopw %cs:(%rax,%rax)
nop
dgemm_beta_d0:
movsd (%r8), %xmm8
movsd 0x8(%r8), %xmm9
movsd 0x10(%r8), %xmm10
movsd 0x18(%r8), %xmm11
movsd 0x20(%r8), %xmm12
movsd 0x28(%r8), %xmm13
movsd 0x30(%r8), %xmm14
movsd 0x38(%r8), %xmm15
mulsd %xmm0, %xmm8
mulsd %xmm0, %xmm9
mulsd %xmm0, %xmm10
mulsd %xmm0, %xmm11
mulsd %xmm0, %xmm12
mulsd %xmm0, %xmm13
mulsd %xmm0, %xmm14
mulsd %xmm0, %xmm15
movsd %xmm8, (%r8)
movsd %xmm9, 0x8(%r8)
movsd %xmm10, 0x10(%r8)
movsd %xmm11, 0x18(%r8)
movsd %xmm12, 0x20(%r8)
movsd %xmm13, 0x28(%r8)
movsd %xmm14, 0x30(%r8)
movsd %xmm15, 0x38(%r8)
addq $0x40, %r8
decq %rax
jg dgemm_beta_d0
nopw %cs:(%rax,%rax)
nopl (%rax)
dgemm_beta_170:
movq %rdi, %rax
andq $0x7, %rax
jle dgemm_beta_1a0
nopl (%rax)
dgemm_beta_180:
movsd (%r8), %xmm8
mulsd %xmm0, %xmm8
movsd %xmm8, (%r8)
addq $0x8, %r8
decq %rax
jg dgemm_beta_180
nopl (%rax,%rax)
dgemm_beta_1a0:
decq %rsi
jg dgemm_beta_b0
nopl (%rax)
dgemm_beta_1b0:
xorq %rax, %rax
retq
