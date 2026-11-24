idamax_k:
pxor %xmm0, %xmm0
xorq %rax, %rax
testq %rdi, %rdi
jle idamax_k_c18
leaq (,%rdx,8), %rdx
testq %rdx, %rdx
jle idamax_k_c18
movq %rdi, %r11
movq %rsi, %r10
pcmpeqb %xmm15, %xmm15
psrlq $0x1, %xmm15
movsd (%rsi), %xmm0
addq %rdx, %rsi
decq %rdi
andpd %xmm15, %xmm0
unpcklpd %xmm0, %xmm0
movapd %xmm0, %xmm1
movapd %xmm0, %xmm2
movapd %xmm0, %xmm3
cmpq $0x8, %rdx
jne idamax_k_810
cmpq $0x7, %rdi
jle idamax_k_428
testq $0x7, %rsi
jne idamax_k_428
testq $0xf, %rsi
je idamax_k_98
movsd (%rsi), %xmm4
andpd %xmm15, %xmm4
unpcklpd %xmm4, %xmm4
maxpd %xmm4, %xmm3
decq %rdi
addq $0x8, %rsi
nopl (%rax,%rax)
idamax_k_98:
movq %rdi, %rcx
sarq $0x4, %rcx
jle idamax_k_140
nopw %cs:(%rax,%rax)
nop
idamax_k_b0:
prefetcht0 0x580(%rsi)
movapd (%rsi), %xmm4
andpd %xmm15, %xmm4
maxpd %xmm4, %xmm0
movapd 0x10(%rsi), %xmm5
andpd %xmm15, %xmm5
maxpd %xmm5, %xmm1
movapd 0x20(%rsi), %xmm6
andpd %xmm15, %xmm6
maxpd %xmm6, %xmm2
movapd 0x30(%rsi), %xmm7
andpd %xmm15, %xmm7
maxpd %xmm7, %xmm3
prefetcht0 0x5c0(%rsi)
movapd 0x40(%rsi), %xmm4
andpd %xmm15, %xmm4
maxpd %xmm4, %xmm0
movapd 0x50(%rsi), %xmm5
andpd %xmm15, %xmm5
maxpd %xmm5, %xmm1
movapd 0x60(%rsi), %xmm6
andpd %xmm15, %xmm6
maxpd %xmm6, %xmm2
movapd 0x70(%rsi), %xmm7
andpd %xmm15, %xmm7
maxpd %xmm7, %xmm3
addq $0x80, %rsi
decq %rcx
jg idamax_k_b0
nopl (%rax)
idamax_k_140:
andq $0xf, %rdi
jle idamax_k_1f0
testq $0x8, %rdi
je idamax_k_190
movapd (%rsi), %xmm4
andpd %xmm15, %xmm4
maxpd %xmm4, %xmm0
movapd 0x10(%rsi), %xmm5
andpd %xmm15, %xmm5
maxpd %xmm5, %xmm1
movapd 0x20(%rsi), %xmm6
andpd %xmm15, %xmm6
maxpd %xmm6, %xmm2
movapd 0x30(%rsi), %xmm7
andpd %xmm15, %xmm7
maxpd %xmm7, %xmm3
addq $0x40, %rsi
nop
idamax_k_190:
testq $0x4, %rdi
je idamax_k_1b8
movapd (%rsi), %xmm4
andpd %xmm15, %xmm4
maxpd %xmm4, %xmm0
movapd 0x10(%rsi), %xmm5
andpd %xmm15, %xmm5
maxpd %xmm5, %xmm1
addq $0x20, %rsi
idamax_k_1b8:
testq $0x2, %rdi
je idamax_k_1d2
movapd (%rsi), %xmm6
andpd %xmm15, %xmm6
maxpd %xmm6, %xmm2
addq $0x10, %rsi
idamax_k_1d2:
testq $0x1, %rdi
je idamax_k_1f0
movsd (%rsi), %xmm7
andpd %xmm15, %xmm7
unpcklpd %xmm7, %xmm7
maxpd %xmm7, %xmm3
nopl (%rax)
idamax_k_1f0:
movq %r10, %rsi
movq %r11, %rdi
maxpd %xmm1, %xmm0
maxpd %xmm3, %xmm2
maxpd %xmm2, %xmm0
movapd %xmm0, %xmm1
unpckhpd %xmm0, %xmm0
maxsd %xmm1, %xmm0
unpcklpd %xmm0, %xmm0
nopw (%rax,%rax)
testq $0xf, %rsi
je idamax_k_240
movsd (%rsi), %xmm1
andpd %xmm15, %xmm1
incq %rax
comisd %xmm0, %xmm1
je idamax_k_c18
addq $0x8, %rsi
decq %rdi
nop
idamax_k_240:
movq %rdi, %rcx
sarq $0x3, %rcx
jle idamax_k_378
nopl (%rax)
idamax_k_250:
prefetcht0 0x580(%rsi)
movapd (%rsi), %xmm1
andpd %xmm15, %xmm1
cmpeqpd %xmm0, %xmm1
movapd 0x10(%rsi), %xmm3
andpd %xmm15, %xmm3
cmpeqpd %xmm0, %xmm3
movapd 0x20(%rsi), %xmm5
andpd %xmm15, %xmm5
cmpeqpd %xmm0, %xmm5
movapd 0x30(%rsi), %xmm7
andpd %xmm15, %xmm7
cmpeqpd %xmm0, %xmm7
orpd %xmm3, %xmm1
orpd %xmm7, %xmm5
orpd %xmm5, %xmm1
movmskpd %xmm1, %r11d
testq $0x3, %r11
jne idamax_k_2c0
addq $0x40, %rsi
addq $0x8, %rax
decq %rcx
jg idamax_k_250
jmp idamax_k_378
nop
idamax_k_2c0:
movsd (%rsi), %xmm1
movsd 0x8(%rsi), %xmm2
movsd 0x10(%rsi), %xmm3
movsd 0x18(%rsi), %xmm4
movsd 0x20(%rsi), %xmm5
movsd 0x28(%rsi), %xmm6
movsd 0x30(%rsi), %xmm7
movsd 0x38(%rsi), %xmm8
andpd %xmm15, %xmm1
andpd %xmm15, %xmm2
andpd %xmm15, %xmm3
andpd %xmm15, %xmm4
andpd %xmm15, %xmm5
andpd %xmm15, %xmm6
andpd %xmm15, %xmm7
andpd %xmm15, %xmm8
addq $0x40, %rsi
incq %rax
comisd %xmm0, %xmm1
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm2
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm3
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm4
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm5
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm6
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm7
je idamax_k_c18
incq %rax
jmp idamax_k_c18
nop
idamax_k_378:
testq $0x4, %rdi
je idamax_k_3e0
movsd (%rsi), %xmm1
movsd 0x8(%rsi), %xmm2
movsd 0x10(%rsi), %xmm3
movsd 0x18(%rsi), %xmm4
andpd %xmm15, %xmm1
andpd %xmm15, %xmm2
andpd %xmm15, %xmm3
andpd %xmm15, %xmm4
addq $0x20, %rsi
incq %rax
comisd %xmm0, %xmm1
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm2
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm3
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm4
je idamax_k_c18
idamax_k_3e0:
testq $0x2, %rdi
je idamax_k_420
movsd (%rsi), %xmm1
movsd 0x8(%rsi), %xmm2
andpd %xmm15, %xmm1
andpd %xmm15, %xmm2
addq $0x10, %rsi
incq %rax
comisd %xmm0, %xmm1
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm2
je idamax_k_c18
nopw (%rax,%rax)
idamax_k_420:
incq %rax
jmp idamax_k_c18
idamax_k_428:
movq %rdi, %rcx
sarq $0x4, %rcx
jle idamax_k_500
nopw %cs:(%rax,%rax)
nop
idamax_k_440:
prefetcht0 0x580(%rsi)
movsd (%rsi), %xmm4
movhpd 0x8(%rsi), %xmm4
andpd %xmm15, %xmm4
maxpd %xmm4, %xmm0
movsd 0x10(%rsi), %xmm5
movhpd 0x18(%rsi), %xmm5
andpd %xmm15, %xmm5
maxpd %xmm5, %xmm1
movsd 0x20(%rsi), %xmm6
movhpd 0x28(%rsi), %xmm6
andpd %xmm15, %xmm6
maxpd %xmm6, %xmm2
movsd 0x30(%rsi), %xmm7
movhpd 0x38(%rsi), %xmm7
andpd %xmm15, %xmm7
maxpd %xmm7, %xmm3
prefetcht0 0x5c0(%rsi)
movsd 0x40(%rsi), %xmm4
movhpd 0x48(%rsi), %xmm4
andpd %xmm15, %xmm4
maxpd %xmm4, %xmm0
movsd 0x50(%rsi), %xmm5
movhpd 0x58(%rsi), %xmm5
andpd %xmm15, %xmm5
maxpd %xmm5, %xmm1
movsd 0x60(%rsi), %xmm6
movhpd 0x68(%rsi), %xmm6
andpd %xmm15, %xmm6
maxpd %xmm6, %xmm2
movsd 0x70(%rsi), %xmm7
movhpd 0x78(%rsi), %xmm7
andpd %xmm15, %xmm7
maxpd %xmm7, %xmm3
addq $0x80, %rsi
decq %rcx
jg idamax_k_440
nopw %cs:(%rax,%rax)
nop
idamax_k_500:
andq $0xf, %rdi
jle idamax_k_5e0
testq $0x8, %rdi
je idamax_k_568
movsd (%rsi), %xmm4
movhpd 0x8(%rsi), %xmm4
andpd %xmm15, %xmm4
maxpd %xmm4, %xmm0
movsd 0x10(%rsi), %xmm5
movhpd 0x18(%rsi), %xmm5
andpd %xmm15, %xmm5
maxpd %xmm5, %xmm1
movsd 0x20(%rsi), %xmm6
movhpd 0x28(%rsi), %xmm6
andpd %xmm15, %xmm6
maxpd %xmm6, %xmm2
movsd 0x30(%rsi), %xmm7
movhpd 0x38(%rsi), %xmm7
andpd %xmm15, %xmm7
maxpd %xmm7, %xmm3
addq $0x40, %rsi
nopw (%rax,%rax)
idamax_k_568:
testq $0x4, %rdi
je idamax_k_5a0
movsd (%rsi), %xmm4
movhpd 0x8(%rsi), %xmm4
andpd %xmm15, %xmm4
maxpd %xmm4, %xmm0
movsd 0x10(%rsi), %xmm5
movhpd 0x18(%rsi), %xmm5
andpd %xmm15, %xmm5
maxpd %xmm5, %xmm1
addq $0x20, %rsi
nopw (%rax,%rax)
idamax_k_5a0:
testq $0x2, %rdi
je idamax_k_5bf
movsd (%rsi), %xmm6
movhpd 0x8(%rsi), %xmm6
andpd %xmm15, %xmm6
maxpd %xmm6, %xmm2
addq $0x10, %rsi
idamax_k_5bf:
testq $0x1, %rdi
je idamax_k_5e0
movsd (%rsi), %xmm7
unpcklpd %xmm7, %xmm7
andpd %xmm15, %xmm7
maxpd %xmm7, %xmm3
nopl (%rax)
idamax_k_5e0:
movq %r10, %rsi
movq %r11, %rdi
maxpd %xmm1, %xmm0
maxpd %xmm3, %xmm2
maxpd %xmm2, %xmm0
movapd %xmm0, %xmm1
unpckhpd %xmm0, %xmm0
maxsd %xmm1, %xmm0
unpcklpd %xmm0, %xmm0
movq %rdi, %rcx
sarq $0x3, %rcx
jle idamax_k_758
nop
idamax_k_610:
prefetcht0 0x580(%rsi)
movsd (%rsi), %xmm1
movhpd 0x8(%rsi), %xmm1
andpd %xmm15, %xmm1
cmpeqpd %xmm0, %xmm1
movsd 0x10(%rsi), %xmm3
movhpd 0x18(%rsi), %xmm3
andpd %xmm15, %xmm3
cmpeqpd %xmm0, %xmm3
movsd 0x20(%rsi), %xmm5
movhpd 0x28(%rsi), %xmm5
andpd %xmm15, %xmm5
cmpeqpd %xmm0, %xmm5
movsd 0x30(%rsi), %xmm7
movhpd 0x38(%rsi), %xmm7
andpd %xmm15, %xmm7
cmpeqpd %xmm0, %xmm7
orpd %xmm3, %xmm1
orpd %xmm7, %xmm5
orpd %xmm5, %xmm1
movmskpd %xmm1, %r11d
testq $0x3, %r11
jne idamax_k_6a0
addq $0x40, %rsi
addq $0x8, %rax
decq %rcx
jg idamax_k_610
jmp idamax_k_758
nopw %cs:(%rax,%rax)
nopl (%rax)
idamax_k_6a0:
movsd (%rsi), %xmm1
movsd 0x8(%rsi), %xmm2
movsd 0x10(%rsi), %xmm3
movsd 0x18(%rsi), %xmm4
movsd 0x20(%rsi), %xmm5
movsd 0x28(%rsi), %xmm6
movsd 0x30(%rsi), %xmm7
movsd 0x38(%rsi), %xmm8
andpd %xmm15, %xmm1
andpd %xmm15, %xmm2
andpd %xmm15, %xmm3
andpd %xmm15, %xmm4
andpd %xmm15, %xmm5
andpd %xmm15, %xmm6
andpd %xmm15, %xmm7
andpd %xmm15, %xmm8
addq $0x40, %rsi
incq %rax
comisd %xmm0, %xmm1
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm2
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm3
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm4
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm5
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm6
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm7
je idamax_k_c18
incq %rax
jmp idamax_k_c18
nop
idamax_k_758:
testq $0x4, %rdi
je idamax_k_7c0
movsd (%rsi), %xmm1
movsd 0x8(%rsi), %xmm2
movsd 0x10(%rsi), %xmm3
movsd 0x18(%rsi), %xmm4
andpd %xmm15, %xmm1
andpd %xmm15, %xmm2
andpd %xmm15, %xmm3
andpd %xmm15, %xmm4
addq $0x20, %rsi
incq %rax
comisd %xmm0, %xmm1
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm2
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm3
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm4
je idamax_k_c18
idamax_k_7c0:
testq $0x2, %rdi
je idamax_k_800
movsd (%rsi), %xmm1
movsd 0x8(%rsi), %xmm2
andpd %xmm15, %xmm1
andpd %xmm15, %xmm2
addq $0x10, %rsi
incq %rax
comisd %xmm0, %xmm1
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm2
je idamax_k_c18
nopw (%rax,%rax)
idamax_k_800:
incq %rax
jmp idamax_k_c18
nopl (%rax,%rax)
idamax_k_810:
movq %rdi, %rcx
sarq $0x4, %rcx
jle idamax_k_8f0
nopl (%rax)
idamax_k_820:
movsd (%rsi), %xmm4
addq %rdx, %rsi
movhpd (%rsi), %xmm4
addq %rdx, %rsi
andpd %xmm15, %xmm4
maxpd %xmm4, %xmm0
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhpd (%rsi), %xmm5
addq %rdx, %rsi
andpd %xmm15, %xmm5
maxpd %xmm5, %xmm1
movsd (%rsi), %xmm6
addq %rdx, %rsi
movhpd (%rsi), %xmm6
addq %rdx, %rsi
andpd %xmm15, %xmm6
maxpd %xmm6, %xmm2
movsd (%rsi), %xmm7
addq %rdx, %rsi
movhpd (%rsi), %xmm7
addq %rdx, %rsi
andpd %xmm15, %xmm7
maxpd %xmm7, %xmm3
movsd (%rsi), %xmm4
addq %rdx, %rsi
movhpd (%rsi), %xmm4
addq %rdx, %rsi
andpd %xmm15, %xmm4
maxpd %xmm4, %xmm0
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhpd (%rsi), %xmm5
addq %rdx, %rsi
andpd %xmm15, %xmm5
maxpd %xmm5, %xmm1
movsd (%rsi), %xmm6
addq %rdx, %rsi
movhpd (%rsi), %xmm6
addq %rdx, %rsi
andpd %xmm15, %xmm6
maxpd %xmm6, %xmm2
movsd (%rsi), %xmm7
addq %rdx, %rsi
movhpd (%rsi), %xmm7
addq %rdx, %rsi
andpd %xmm15, %xmm7
maxpd %xmm7, %xmm3
decq %rcx
jg idamax_k_820
nopw %cs:(%rax,%rax)
nopl (%rax,%rax)
idamax_k_8f0:
andq $0xf, %rdi
jle idamax_k_9f0
testq $0x8, %rdi
je idamax_k_960
movsd (%rsi), %xmm4
addq %rdx, %rsi
movhpd (%rsi), %xmm4
addq %rdx, %rsi
andpd %xmm15, %xmm4
maxpd %xmm4, %xmm0
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhpd (%rsi), %xmm5
addq %rdx, %rsi
andpd %xmm15, %xmm5
maxpd %xmm5, %xmm1
movsd (%rsi), %xmm6
addq %rdx, %rsi
movhpd (%rsi), %xmm6
addq %rdx, %rsi
andpd %xmm15, %xmm6
maxpd %xmm6, %xmm2
movsd (%rsi), %xmm7
addq %rdx, %rsi
movhpd (%rsi), %xmm7
addq %rdx, %rsi
andpd %xmm15, %xmm7
maxpd %xmm7, %xmm3
nop
idamax_k_960:
testq $0x4, %rdi
je idamax_k_998
movsd (%rsi), %xmm4
addq %rdx, %rsi
movhpd (%rsi), %xmm4
addq %rdx, %rsi
andpd %xmm15, %xmm4
maxpd %xmm4, %xmm0
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhpd (%rsi), %xmm5
addq %rdx, %rsi
andpd %xmm15, %xmm5
maxpd %xmm5, %xmm1
nop
idamax_k_998:
testq $0x2, %rdi
je idamax_k_9b8
movsd (%rsi), %xmm6
addq %rdx, %rsi
movhpd (%rsi), %xmm6
addq %rdx, %rsi
andpd %xmm15, %xmm6
maxpd %xmm6, %xmm2
idamax_k_9b8:
testq $0x1, %rdi
je idamax_k_9f0
movsd (%rsi), %xmm7
unpcklpd %xmm7, %xmm7
andpd %xmm15, %xmm7
maxpd %xmm7, %xmm3
maxpd %xmm1, %xmm0
maxpd %xmm3, %xmm2
maxpd %xmm2, %xmm0
movapd %xmm0, %xmm1
unpckhpd %xmm0, %xmm0
maxsd %xmm1, %xmm0
nopw (%rax,%rax)
idamax_k_9f0:
movq %r10, %rsi
movq %r11, %rdi
maxpd %xmm1, %xmm0
maxpd %xmm3, %xmm2
maxpd %xmm2, %xmm0
movapd %xmm0, %xmm1
unpckhpd %xmm0, %xmm0
maxsd %xmm1, %xmm0
unpcklpd %xmm0, %xmm0
movq %rdi, %rcx
sarq $0x3, %rcx
jle idamax_k_b78
nop
idamax_k_a20:
movsd (%rsi), %xmm1
addq %rdx, %rsi
movhpd (%rsi), %xmm1
addq %rdx, %rsi
andpd %xmm15, %xmm1
cmpeqpd %xmm0, %xmm1
movsd (%rsi), %xmm3
addq %rdx, %rsi
movhpd (%rsi), %xmm3
addq %rdx, %rsi
andpd %xmm15, %xmm3
cmpeqpd %xmm0, %xmm3
movsd (%rsi), %xmm5
addq %rdx, %rsi
movhpd (%rsi), %xmm5
addq %rdx, %rsi
andpd %xmm15, %xmm5
cmpeqpd %xmm0, %xmm5
movsd (%rsi), %xmm7
addq %rdx, %rsi
movhpd (%rsi), %xmm7
addq %rdx, %rsi
andpd %xmm15, %xmm7
cmpeqpd %xmm0, %xmm7
orpd %xmm3, %xmm1
orpd %xmm7, %xmm5
orpd %xmm5, %xmm1
movmskpd %xmm1, %r11d
testq $0x3, %r11
jne idamax_k_ab0
addq $0x8, %rax
decq %rcx
jg idamax_k_a20
jmp idamax_k_b78
nopl (%rax)
idamax_k_ab0:
subq %rdx, %rsi
movsd (%rsi), %xmm8
subq %rdx, %rsi
movsd (%rsi), %xmm7
subq %rdx, %rsi
movsd (%rsi), %xmm6
subq %rdx, %rsi
movsd (%rsi), %xmm5
subq %rdx, %rsi
movsd (%rsi), %xmm4
subq %rdx, %rsi
movsd (%rsi), %xmm3
subq %rdx, %rsi
movsd (%rsi), %xmm2
subq %rdx, %rsi
movsd (%rsi), %xmm1
andpd %xmm15, %xmm1
andpd %xmm15, %xmm2
andpd %xmm15, %xmm3
andpd %xmm15, %xmm4
andpd %xmm15, %xmm5
andpd %xmm15, %xmm6
andpd %xmm15, %xmm7
andpd %xmm15, %xmm8
addq $0x40, %rsi
incq %rax
comisd %xmm0, %xmm1
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm2
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm3
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm4
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm5
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm6
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm7
je idamax_k_c18
incq %rax
jmp idamax_k_c18
idamax_k_b78:
testq $0x4, %rdi
je idamax_k_bd8
movsd (%rsi), %xmm1
addq %rdx, %rsi
movsd (%rsi), %xmm2
addq %rdx, %rsi
movsd (%rsi), %xmm3
addq %rdx, %rsi
movsd (%rsi), %xmm4
addq %rdx, %rsi
andpd %xmm15, %xmm1
andpd %xmm15, %xmm2
andpd %xmm15, %xmm3
andpd %xmm15, %xmm4
incq %rax
comisd %xmm0, %xmm1
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm2
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm3
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm4
je idamax_k_c18
nopl (%rax)
idamax_k_bd8:
testq $0x2, %rdi
je idamax_k_c10
movsd (%rsi), %xmm1
addq %rdx, %rsi
movsd (%rsi), %xmm2
addq %rdx, %rsi
andpd %xmm15, %xmm1
andpd %xmm15, %xmm2
incq %rax
comisd %xmm0, %xmm1
je idamax_k_c18
incq %rax
comisd %xmm0, %xmm2
je idamax_k_c18
nopl (%rax,%rax)
idamax_k_c10:
incq %rax
nopl (%rax,%rax)
idamax_k_c18:
retq
