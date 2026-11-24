dnrm2_k:
fldz
testq %rdi, %rdi
jle dnrm2_k_150
testq %rdx, %rdx
je dnrm2_k_150
shlq $0x3, %rdx
fldz
fldz
fldz
cmpq $0x8, %rdx
jne dnrm2_k_c0
movq %rdi, %rax
sarq $0x3, %rax
jle dnrm2_k_90
nopw %cs:(%rax,%rax)
nopl (%rax,%rax)
dnrm2_k_40:
prefetcht0 0x580(%rsi)
fldl (%rsi)
fmul %st(0), %st
fldl 0x8(%rsi)
fmul %st(0), %st
fldl 0x10(%rsi)
fmul %st(0), %st
fldl 0x18(%rsi)
fmul %st(0), %st
faddp %st, %st(7)
faddp %st, %st(5)
faddp %st, %st(3)
faddp %st, %st(1)
fldl 0x20(%rsi)
fmul %st(0), %st
fldl 0x28(%rsi)
fmul %st(0), %st
fldl 0x30(%rsi)
fmul %st(0), %st
fldl 0x38(%rsi)
fmul %st(0), %st
addq $0x40, %rsi
faddp %st, %st(7)
faddp %st, %st(5)
faddp %st, %st(3)
faddp %st, %st(1)
decq %rax
jg dnrm2_k_40
nopw (%rax,%rax)
dnrm2_k_90:
andq $0x7, %rdi
jle dnrm2_k_140
nopw (%rax,%rax)
dnrm2_k_a0:
fldl (%rsi)
fmul %st(0), %st
faddp %st, %st(1)
addq $0x8, %rsi
decq %rdi
jg dnrm2_k_a0
jmp dnrm2_k_140
nopw %cs:(%rax,%rax)
nop
dnrm2_k_c0:
movq %rdi, %rax
sarq $0x3, %rax
jle dnrm2_k_120
nopl (%rax)
dnrm2_k_d0:
fldl (%rsi)
addq %rdx, %rsi
fmul %st(0), %st
fldl (%rsi)
addq %rdx, %rsi
fmul %st(0), %st
fldl (%rsi)
addq %rdx, %rsi
fmul %st(0), %st
fldl (%rsi)
addq %rdx, %rsi
fmul %st(0), %st
faddp %st, %st(7)
faddp %st, %st(5)
faddp %st, %st(3)
faddp %st, %st(1)
fldl (%rsi)
addq %rdx, %rsi
fmul %st(0), %st
fldl (%rsi)
addq %rdx, %rsi
fmul %st(0), %st
fldl (%rsi)
addq %rdx, %rsi
fmul %st(0), %st
fldl (%rsi)
addq %rdx, %rsi
fmul %st(0), %st
faddp %st, %st(7)
faddp %st, %st(5)
faddp %st, %st(3)
faddp %st, %st(1)
decq %rax
jg dnrm2_k_d0
nopl (%rax)
dnrm2_k_120:
andq $0x7, %rdi
jle dnrm2_k_140
nopw %cs:(%rax,%rax)
dnrm2_k_130:
fldl (%rsi)
addq %rdx, %rsi
fmul %st(0), %st
faddp %st, %st(1)
decq %rdi
jg dnrm2_k_130
nop
dnrm2_k_140:
faddp %st, %st(2)
faddp %st, %st(1)
faddp %st, %st(1)
nopw %cs:(%rax,%rax)
dnrm2_k_150:
fsqrt
subq $0x10, %rsp
fstpl (%rsp)
movsd (%rsp), %xmm0
addq $0x10, %rsp
retq
