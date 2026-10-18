ddot_k:
leaq (,%rdx,8), %rdx
leaq (,%r8,8), %r8
xorps %xmm0, %xmm0
xorps %xmm1, %xmm1
xorps %xmm2, %xmm2
xorps %xmm3, %xmm3
cmpq $0x0, %rdi
jle ddot_k_580
cmpq $0x8, %rdx
jne ddot_k_4f8
cmpq $0x8, %r8
jne ddot_k_4f8
subq $-0x80, %rsi
subq $-0x80, %rcx
testq $0x8, %rcx
je ddot_k_60
movsd -0x80(%rsi), %xmm0
mulsd -0x80(%rcx), %xmm0
addq $0x8, %rsi
addq $0x8, %rcx
decq %rdi
ddot_k_60:
testq $0x8, %rsi
jne ddot_k_268
movq %rdi, %rax
sarq $0x4, %rax
jle ddot_k_1a0
movaps -0x80(%rsi), %xmm4
movaps -0x70(%rsi), %xmm5
movaps -0x60(%rsi), %xmm6
movaps -0x50(%rsi), %xmm7
movaps -0x40(%rsi), %xmm8
movaps -0x30(%rsi), %xmm9
movaps -0x20(%rsi), %xmm10
movaps -0x10(%rsi), %xmm11
decq %rax
jle ddot_k_148
nop
ddot_k_a8:
prefetcht0 0x580(%rsi)
mulpd -0x80(%rcx), %xmm4
addpd %xmm4, %xmm0
movaps (%rsi), %xmm4
mulpd -0x70(%rcx), %xmm5
addpd %xmm5, %xmm1
movaps 0x10(%rsi), %xmm5
prefetcht0 0x580(%rcx)
mulpd -0x60(%rcx), %xmm6
addpd %xmm6, %xmm2
movaps 0x20(%rsi), %xmm6
mulpd -0x50(%rcx), %xmm7
addpd %xmm7, %xmm3
movaps 0x30(%rsi), %xmm7
prefetcht0 0x5c0(%rsi)
mulpd -0x40(%rcx), %xmm8
addpd %xmm8, %xmm0
movaps 0x40(%rsi), %xmm8
mulpd -0x30(%rcx), %xmm9
addpd %xmm9, %xmm1
movaps 0x50(%rsi), %xmm9
prefetcht0 0x5c0(%rcx)
mulpd -0x20(%rcx), %xmm10
addpd %xmm10, %xmm2
movaps 0x60(%rsi), %xmm10
mulpd -0x10(%rcx), %xmm11
addpd %xmm11, %xmm3
movaps 0x70(%rsi), %xmm11
subq $-0x80, %rsi
subq $-0x80, %rcx
decq %rax
jg ddot_k_a8
ddot_k_148:
mulpd -0x80(%rcx), %xmm4
addpd %xmm4, %xmm0
mulpd -0x70(%rcx), %xmm5
addpd %xmm5, %xmm1
mulpd -0x60(%rcx), %xmm6
addpd %xmm6, %xmm2
mulpd -0x50(%rcx), %xmm7
addpd %xmm7, %xmm3
mulpd -0x40(%rcx), %xmm8
addpd %xmm8, %xmm0
mulpd -0x30(%rcx), %xmm9
addpd %xmm9, %xmm1
mulpd -0x20(%rcx), %xmm10
addpd %xmm10, %xmm2
mulpd -0x10(%rcx), %xmm11
addpd %xmm11, %xmm3
subq $-0x80, %rsi
subq $-0x80, %rcx
ddot_k_1a0:
testq $0xf, %rdi
jle ddot_k_580
testq $0x8, %rdi
jle ddot_k_1f8
movaps -0x80(%rsi), %xmm4
movaps -0x70(%rsi), %xmm5
movaps -0x60(%rsi), %xmm6
movaps -0x50(%rsi), %xmm7
mulpd -0x80(%rcx), %xmm4
addpd %xmm4, %xmm0
mulpd -0x70(%rcx), %xmm5
addpd %xmm5, %xmm1
mulpd -0x60(%rcx), %xmm6
addpd %xmm6, %xmm2
mulpd -0x50(%rcx), %xmm7
addpd %xmm7, %xmm3
addq $0x40, %rsi
addq $0x40, %rcx
nopw (%rax,%rax)
ddot_k_1f8:
testq $0x4, %rdi
jle ddot_k_228
movaps -0x80(%rsi), %xmm4
movaps -0x70(%rsi), %xmm5
mulpd -0x80(%rcx), %xmm4
addpd %xmm4, %xmm0
mulpd -0x70(%rcx), %xmm5
addpd %xmm5, %xmm1
addq $0x20, %rsi
addq $0x20, %rcx
nopl (%rax,%rax)
ddot_k_228:
testq $0x2, %rdi
jle ddot_k_248
movaps -0x80(%rsi), %xmm4
mulpd -0x80(%rcx), %xmm4
addpd %xmm4, %xmm0
addq $0x10, %rsi
addq $0x10, %rcx
nop
ddot_k_248:
testq $0x1, %rdi
jle ddot_k_580
movsd -0x80(%rsi), %xmm4
mulsd -0x80(%rcx), %xmm4
addsd %xmm4, %xmm0
jmp ddot_k_580
ddot_k_268:
movhps -0x80(%rsi), %xmm4
addq $0x8, %rsi
movq %rdi, %rax
sarq $0x4, %rax
jle ddot_k_408
movaps -0x80(%rsi), %xmm5
movaps -0x70(%rsi), %xmm6
movaps -0x60(%rsi), %xmm7
movaps -0x50(%rsi), %xmm8
movaps -0x40(%rsi), %xmm9
movaps -0x30(%rsi), %xmm10
movaps -0x20(%rsi), %xmm11
decq %rax
jle ddot_k_378
nop
ddot_k_2a8:
prefetcht0 0x580(%rsi)
shufpd $0x1, %xmm5, %xmm4
mulpd -0x80(%rcx), %xmm4
addpd %xmm4, %xmm0
movaps -0x10(%rsi), %xmm4
shufpd $0x1, %xmm6, %xmm5
mulpd -0x70(%rcx), %xmm5
addpd %xmm5, %xmm1
movaps (%rsi), %xmm5
prefetcht0 0x580(%rcx)
shufpd $0x1, %xmm7, %xmm6
mulpd -0x60(%rcx), %xmm6
addpd %xmm6, %xmm2
movaps 0x10(%rsi), %xmm6
shufpd $0x1, %xmm8, %xmm7
mulpd -0x50(%rcx), %xmm7
addpd %xmm7, %xmm3
movaps 0x20(%rsi), %xmm7
prefetcht0 0x5c0(%rsi)
shufpd $0x1, %xmm9, %xmm8
mulpd -0x40(%rcx), %xmm8
addpd %xmm8, %xmm0
movaps 0x30(%rsi), %xmm8
shufpd $0x1, %xmm10, %xmm9
mulpd -0x30(%rcx), %xmm9
addpd %xmm9, %xmm1
movaps 0x40(%rsi), %xmm9
prefetcht0 0x5c0(%rcx)
shufpd $0x1, %xmm11, %xmm10
mulpd -0x20(%rcx), %xmm10
addpd %xmm10, %xmm2
movaps 0x50(%rsi), %xmm10
shufpd $0x1, %xmm4, %xmm11
mulpd -0x10(%rcx), %xmm11
addpd %xmm11, %xmm3
movaps 0x60(%rsi), %xmm11
subq $-0x80, %rsi
subq $-0x80, %rcx
decq %rax
jg ddot_k_2a8
nopl (%rax)
ddot_k_378:
shufpd $0x1, %xmm5, %xmm4
mulpd -0x80(%rcx), %xmm4
addpd %xmm4, %xmm0
movaps -0x10(%rsi), %xmm4
shufpd $0x1, %xmm6, %xmm5
mulpd -0x70(%rcx), %xmm5
addpd %xmm5, %xmm1
shufpd $0x1, %xmm7, %xmm6
mulpd -0x60(%rcx), %xmm6
addpd %xmm6, %xmm2
shufpd $0x1, %xmm8, %xmm7
mulpd -0x50(%rcx), %xmm7
addpd %xmm7, %xmm3
shufpd $0x1, %xmm9, %xmm8
mulpd -0x40(%rcx), %xmm8
addpd %xmm8, %xmm0
shufpd $0x1, %xmm10, %xmm9
mulpd -0x30(%rcx), %xmm9
addpd %xmm9, %xmm1
shufpd $0x1, %xmm11, %xmm10
mulpd -0x20(%rcx), %xmm10
addpd %xmm10, %xmm2
shufpd $0x1, %xmm4, %xmm11
mulpd -0x10(%rcx), %xmm11
addpd %xmm11, %xmm3
subq $-0x80, %rsi
subq $-0x80, %rcx
nopl (%rax)
ddot_k_408:
testq $0xf, %rdi
jle ddot_k_580
testq $0x8, %rdi
jle ddot_k_470
movaps -0x80(%rsi), %xmm5
movaps -0x70(%rsi), %xmm6
movaps -0x60(%rsi), %xmm7
shufpd $0x1, %xmm5, %xmm4
mulpd -0x80(%rcx), %xmm4
addpd %xmm4, %xmm0
movaps -0x50(%rsi), %xmm4
shufpd $0x1, %xmm6, %xmm5
mulpd -0x70(%rcx), %xmm5
addpd %xmm5, %xmm1
shufpd $0x1, %xmm7, %xmm6
mulpd -0x60(%rcx), %xmm6
addpd %xmm6, %xmm2
shufpd $0x1, %xmm4, %xmm7
mulpd -0x50(%rcx), %xmm7
addpd %xmm7, %xmm3
addq $0x40, %rsi
addq $0x40, %rcx
nop
ddot_k_470:
testq $0x4, %rdi
jle ddot_k_4b0
movaps -0x80(%rsi), %xmm5
movaps -0x70(%rsi), %xmm6
shufpd $0x1, %xmm5, %xmm4
mulpd -0x80(%rcx), %xmm4
addpd %xmm4, %xmm0
shufpd $0x1, %xmm6, %xmm5
mulpd -0x70(%rcx), %xmm5
addpd %xmm5, %xmm1
movapd %xmm6, %xmm4
addq $0x20, %rsi
addq $0x20, %rcx
nopl (%rax)
ddot_k_4b0:
testq $0x2, %rdi
jle ddot_k_4d8
movaps -0x80(%rsi), %xmm5
shufpd $0x1, %xmm5, %xmm4
mulpd -0x80(%rcx), %xmm4
addpd %xmm4, %xmm0
movapd %xmm5, %xmm4
addq $0x10, %rsi
addq $0x10, %rcx
nop
ddot_k_4d8:
testq $0x1, %rdi
jle ddot_k_580
shufpd $0x1, %xmm4, %xmm4
mulsd -0x80(%rcx), %xmm4
addsd %xmm4, %xmm0
jmp ddot_k_580
ddot_k_4f8:
movq %rdi, %rax
sarq $0x2, %rax
jle ddot_k_558
nopl (%rax)
ddot_k_508:
movsd (%rsi), %xmm4
addq %rdx, %rsi
mulsd (%rcx), %xmm4
addq %r8, %rcx
movsd (%rsi), %xmm5
addq %rdx, %rsi
mulsd (%rcx), %xmm5
addq %r8, %rcx
movsd (%rsi), %xmm6
addq %rdx, %rsi
mulsd (%rcx), %xmm6
addq %r8, %rcx
movsd (%rsi), %xmm7
addq %rdx, %rsi
mulsd (%rcx), %xmm7
addq %r8, %rcx
addsd %xmm4, %xmm0
addsd %xmm5, %xmm1
addsd %xmm6, %xmm2
addsd %xmm7, %xmm3
decq %rax
jg ddot_k_508
nopl (%rax)
ddot_k_558:
movq %rdi, %rax
andq $0x3, %rax
jle ddot_k_580
nopl (%rax)
ddot_k_568:
movsd (%rsi), %xmm4
addq %rdx, %rsi
mulsd (%rcx), %xmm4
addq %r8, %rcx
addsd %xmm4, %xmm0
decq %rax
jg ddot_k_568
nop
ddot_k_580:
addpd %xmm1, %xmm0
addpd %xmm3, %xmm2
addpd %xmm2, %xmm0
haddpd %xmm0, %xmm0
retq
