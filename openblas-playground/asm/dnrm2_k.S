dnrm2_k:
eor v1.16b, v1.16b, v1.16b
fmov d0, #1.00000000
fmov d6, d0
fmov d5, d1
cmp x0, #0x0
b.le dnrm2_k_2a4
cmp x2, #0x0
b.eq dnrm2_k_2a4
cmp x2, #0x1
b.ne dnrm2_k_248
asr x3, x0, #3
cmp x3, xzr
b.le dnrm2_k_1fc
dnrm2_k_34:
ldr d4, [x1], #0x8
fcmp d4, d5
b.eq dnrm2_k_6c
fabs d4, d4
fcmp d1, d4
b.ge dnrm2_k_64
fdiv d2, d1, d4
fmul d2, d2, d2
fmul d3, d0, d2
fadd d0, d6, d3
fmov d1, d4
b dnrm2_k_6c
dnrm2_k_64:
fdiv d2, d4, d1
fmla d0, d2, v2.d[0]
dnrm2_k_6c:
ldr d4, [x1], #0x8
fcmp d4, d5
b.eq dnrm2_k_a4
fabs d4, d4
fcmp d1, d4
b.ge dnrm2_k_9c
fdiv d2, d1, d4
fmul d2, d2, d2
fmul d3, d0, d2
fadd d0, d6, d3
fmov d1, d4
b dnrm2_k_a4
dnrm2_k_9c:
fdiv d2, d4, d1
fmla d0, d2, v2.d[0]
dnrm2_k_a4:
ldr d4, [x1], #0x8
fcmp d4, d5
b.eq dnrm2_k_dc
fabs d4, d4
fcmp d1, d4
b.ge dnrm2_k_d4
fdiv d2, d1, d4
fmul d2, d2, d2
fmul d3, d0, d2
fadd d0, d6, d3
fmov d1, d4
b dnrm2_k_dc
dnrm2_k_d4:
fdiv d2, d4, d1
fmla d0, d2, v2.d[0]
dnrm2_k_dc:
ldr d4, [x1], #0x8
fcmp d4, d5
b.eq dnrm2_k_114
fabs d4, d4
fcmp d1, d4
b.ge dnrm2_k_10c
fdiv d2, d1, d4
fmul d2, d2, d2
fmul d3, d0, d2
fadd d0, d6, d3
fmov d1, d4
b dnrm2_k_114
dnrm2_k_10c:
fdiv d2, d4, d1
fmla d0, d2, v2.d[0]
dnrm2_k_114:
ldr d4, [x1], #0x8
fcmp d4, d5
b.eq dnrm2_k_14c
fabs d4, d4
fcmp d1, d4
b.ge dnrm2_k_144
fdiv d2, d1, d4
fmul d2, d2, d2
fmul d3, d0, d2
fadd d0, d6, d3
fmov d1, d4
b dnrm2_k_14c
dnrm2_k_144:
fdiv d2, d4, d1
fmla d0, d2, v2.d[0]
dnrm2_k_14c:
ldr d4, [x1], #0x8
fcmp d4, d5
b.eq dnrm2_k_184
fabs d4, d4
fcmp d1, d4
b.ge dnrm2_k_17c
fdiv d2, d1, d4
fmul d2, d2, d2
fmul d3, d0, d2
fadd d0, d6, d3
fmov d1, d4
b dnrm2_k_184
dnrm2_k_17c:
fdiv d2, d4, d1
fmla d0, d2, v2.d[0]
dnrm2_k_184:
ldr d4, [x1], #0x8
fcmp d4, d5
b.eq dnrm2_k_1bc
fabs d4, d4
fcmp d1, d4
b.ge dnrm2_k_1b4
fdiv d2, d1, d4
fmul d2, d2, d2
fmul d3, d0, d2
fadd d0, d6, d3
fmov d1, d4
b dnrm2_k_1bc
dnrm2_k_1b4:
fdiv d2, d4, d1
fmla d0, d2, v2.d[0]
dnrm2_k_1bc:
ldr d4, [x1], #0x8
fcmp d4, d5
b.eq dnrm2_k_1f4
fabs d4, d4
fcmp d1, d4
b.ge dnrm2_k_1ec
fdiv d2, d1, d4
fmul d2, d2, d2
fmul d3, d0, d2
fadd d0, d6, d3
fmov d1, d4
b dnrm2_k_1f4
dnrm2_k_1ec:
fdiv d2, d4, d1
fmla d0, d2, v2.d[0]
dnrm2_k_1f4:
subs x3, x3, #0x1
b.ne dnrm2_k_34
dnrm2_k_1fc:
ands x3, x0, #0x7
b.le dnrm2_k_2a4
dnrm2_k_204:
ldr d4, [x1], #0x8
fcmp d4, d5
b.eq dnrm2_k_23c
fabs d4, d4
fcmp d1, d4
b.ge dnrm2_k_234
fdiv d2, d1, d4
fmul d2, d2, d2
fmul d3, d0, d2
fadd d0, d6, d3
fmov d1, d4
b dnrm2_k_23c
dnrm2_k_234:
fdiv d2, d4, d1
fmla d0, d2, v2.d[0]
dnrm2_k_23c:
subs x3, x3, #0x1
b.ne dnrm2_k_204
b dnrm2_k_2a4
dnrm2_k_248:
lsl x2, x2, #3
mov x3, x0
nop
nop
nop
nop
dnrm2_k_260:
ldr d4, [x1]
fcmp d4, d5
b.eq dnrm2_k_298
fabs d4, d4
fcmp d1, d4
b.ge dnrm2_k_290
fdiv d2, d1, d4
fmul d2, d2, d2
fmul d3, d0, d2
fadd d0, d6, d3
fmov d1, d4
b dnrm2_k_298
dnrm2_k_290:
fdiv d2, d4, d1
fmla d0, d2, v2.d[0]
dnrm2_k_298:
add x1, x1, x2
subs x3, x3, #0x1
b.ne dnrm2_k_260
dnrm2_k_2a4:
fsqrt d0, d0
fmul d0, d1, d0
ret
