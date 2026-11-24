	.text
xor_gen_neon:
add	x11, x2, x0, lsl #3
ldr	x10, [x11, #-0x8]!
ldr	x3, [x2]
add	x4, x3, x1
sub	w0, w0, #0x2
mov	w6, #0x0
mov	w5, w1
and	w1, w1, #0xff
sub	w5, w5, w1
cbz	w5, L_184
sub	sp, sp, #0x40
stp	d8, d9, [sp]
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
sub	x4, x4, #0x100
L_40:
ldr	q0, [x3]
ldr	q1, [x3, #0x10]
ldr	q2, [x3, #0x20]
ldr	q3, [x3, #0x30]
ldr	q4, [x3, #0x40]
ldr	q5, [x3, #0x50]
ldr	q6, [x3, #0x60]
ldr	q7, [x3, #0x70]
ldr	q8, [x3, #0x80]
ldr	q9, [x3, #0x90]
ldr	q10, [x3, #0xa0]
ldr	q11, [x3, #0xb0]
ldr	q12, [x3, #0xc0]
ldr	q13, [x3, #0xd0]
ldr	q14, [x3, #0xe0]
ldr	q15, [x3, #0xf0]
add	x3, x3, #0x100
cbz	w0, L_11c
add	x7, x2, #0x8
L_8c:
ldr	x9, [x7], #0x8
add	x9, x9, x6
cmp	x7, x11
ldr	q16, [x9]
ldr	q17, [x9, #0x10]
ldr	q18, [x9, #0x20]
ldr	q19, [x9, #0x30]
ldr	q20, [x9, #0x40]
ldr	q21, [x9, #0x50]
ldr	q22, [x9, #0x60]
ldr	q23, [x9, #0x70]
ldr	q24, [x9, #0x80]
ldr	q25, [x9, #0x90]
ldr	q26, [x9, #0xa0]
ldr	q27, [x9, #0xb0]
ldr	q28, [x9, #0xc0]
ldr	q29, [x9, #0xd0]
ldr	q30, [x9, #0xe0]
ldr	q31, [x9, #0xf0]
eor	v0.16b, v0.16b, v16.16b
eor	v1.16b, v1.16b, v17.16b
eor	v2.16b, v2.16b, v18.16b
eor	v3.16b, v3.16b, v19.16b
eor	v4.16b, v4.16b, v20.16b
eor	v5.16b, v5.16b, v21.16b
eor	v6.16b, v6.16b, v22.16b
eor	v7.16b, v7.16b, v23.16b
eor	v8.16b, v8.16b, v24.16b
eor	v9.16b, v9.16b, v25.16b
eor	v10.16b, v10.16b, v26.16b
eor	v11.16b, v11.16b, v27.16b
eor	v12.16b, v12.16b, v28.16b
eor	v13.16b, v13.16b, v29.16b
eor	v14.16b, v14.16b, v30.16b
eor	v15.16b, v15.16b, v31.16b
b.ne	L_8c
L_11c:
str	q0, [x10]
str	q1, [x10, #0x10]
str	q2, [x10, #0x20]
str	q3, [x10, #0x30]
str	q4, [x10, #0x40]
str	q5, [x10, #0x50]
str	q6, [x10, #0x60]
str	q7, [x10, #0x70]
str	q8, [x10, #0x80]
str	q9, [x10, #0x90]
str	q10, [x10, #0xa0]
str	q11, [x10, #0xb0]
str	q12, [x10, #0xc0]
str	q13, [x10, #0xd0]
str	q14, [x10, #0xe0]
str	q15, [x10, #0xf0]
cmp	x3, x4
add	x10, x10, #0x100
add	w6, w6, #0x100
b.ls	L_40
ldp	d8, d9, [sp]
ldp	d10, d11, [sp, #0x10]
ldp	d12, d13, [sp, #0x20]
ldp	d14, d15, [sp, #0x30]
add	sp, sp, #0x40
add	x4, x4, #0x100
L_184:
mov	w5, w1
and	w1, w1, #0xf
sub	w5, w5, w1
cbz	w5, L_1cc
sub	x4, x4, #0x10
L_198:
ldr	q0, [x3], #0x10
cbz	w0, L_1b8
add	x7, x2, #0x8
L_1a4:
ldr	x9, [x7], #0x8
cmp	x7, x11
ldr	q1, [x9, x6]
eor	v0.16b, v0.16b, v1.16b
b.ne	L_1a4
L_1b8:
cmp	x3, x4
str	q0, [x10], #0x10
add	w6, w6, #0x10
b.ls	L_198
add	x4, x4, #0x10
L_1cc:
cbnz	w1, L_1d8
mov	w0, #0x0
ret
L_1d8:
ldrb	w5, [x3], #0x1
cbz	w0, L_1f8
add	x7, x2, #0x8
L_1e4:
ldr	x9, [x7], #0x8
cmp	x7, x11
ldrb	w1, [x9, x6]
eor	w5, w5, w1
b.ne	L_1e4
L_1f8:
cmp	x3, x4
strb	w5, [x10], #0x1
add	w6, w6, #0x1
b.ne	L_1d8
mov	w0, #0x0
ret
