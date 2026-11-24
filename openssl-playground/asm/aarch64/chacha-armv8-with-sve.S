	.text
ChaCha20_ctr32_dflt:
cmp	x2, #0xc0
b.lo	L_18
adrp	x17, OPENSSL_armcap_P
ldr	w17, [x17]
L_10:
tst	w17, #0x1
b.ne	ChaCha20_neon
L_18:
stp	x29, x30, [sp, #-0x60]!
mov	x29, sp
adrp	x5, _chacha_sve_consts-96
add	x5, x5, :lo12:_chacha_sve_consts-96
stp	x19, x20, [sp, #0x10]
stp	x21, x22, [sp, #0x20]
stp	x23, x24, [sp, #0x30]
stp	x25, x26, [sp, #0x40]
stp	x27, x28, [sp, #0x50]
sub	sp, sp, #0x40
ldp	x22, x23, [x5]
ldp	x24, x25, [x3]
ldp	x26, x27, [x3, #0x10]
ldp	x28, x30, [x4]
L_50:
mov	w5, w22
lsr	x6, x22, #32
mov	w7, w23
lsr	x8, x23, #32
mov	w9, w24
lsr	x10, x24, #32
mov	w11, w25
lsr	x12, x25, #32
mov	w13, w26
lsr	x14, x26, #32
mov	w15, w27
lsr	x16, x27, #32
mov	w17, w28
lsr	x19, x28, #32
mov	w20, w30
lsr	x21, x30, #32
mov	x4, #0xa
subs	x2, x2, #0x40
L_98:
sub	x4, x4, #0x1
add	w5, w5, w9
add	w6, w6, w10
add	w7, w7, w11
add	w8, w8, w12
eor	w17, w17, w5
eor	w19, w19, w6
eor	w20, w20, w7
eor	w21, w21, w8
ror	w17, w17, #0x10
ror	w19, w19, #0x10
ror	w20, w20, #0x10
ror	w21, w21, #0x10
add	w13, w13, w17
add	w14, w14, w19
add	w15, w15, w20
add	w16, w16, w21
eor	w9, w9, w13
eor	w10, w10, w14
eor	w11, w11, w15
eor	w12, w12, w16
ror	w9, w9, #0x14
ror	w10, w10, #0x14
ror	w11, w11, #0x14
ror	w12, w12, #0x14
add	w5, w5, w9
add	w6, w6, w10
add	w7, w7, w11
add	w8, w8, w12
eor	w17, w17, w5
eor	w19, w19, w6
eor	w20, w20, w7
eor	w21, w21, w8
ror	w17, w17, #0x18
ror	w19, w19, #0x18
ror	w20, w20, #0x18
ror	w21, w21, #0x18
add	w13, w13, w17
add	w14, w14, w19
add	w15, w15, w20
add	w16, w16, w21
eor	w9, w9, w13
eor	w10, w10, w14
eor	w11, w11, w15
eor	w12, w12, w16
ror	w9, w9, #0x19
ror	w10, w10, #0x19
ror	w11, w11, #0x19
ror	w12, w12, #0x19
add	w5, w5, w10
add	w6, w6, w11
add	w7, w7, w12
add	w8, w8, w9
eor	w21, w21, w5
eor	w17, w17, w6
eor	w19, w19, w7
eor	w20, w20, w8
ror	w21, w21, #0x10
ror	w17, w17, #0x10
ror	w19, w19, #0x10
ror	w20, w20, #0x10
add	w15, w15, w21
add	w16, w16, w17
add	w13, w13, w19
add	w14, w14, w20
eor	w10, w10, w15
eor	w11, w11, w16
eor	w12, w12, w13
eor	w9, w9, w14
ror	w10, w10, #0x14
ror	w11, w11, #0x14
ror	w12, w12, #0x14
ror	w9, w9, #0x14
add	w5, w5, w10
add	w6, w6, w11
add	w7, w7, w12
add	w8, w8, w9
eor	w21, w21, w5
eor	w17, w17, w6
eor	w19, w19, w7
eor	w20, w20, w8
ror	w21, w21, #0x18
ror	w17, w17, #0x18
ror	w19, w19, #0x18
ror	w20, w20, #0x18
add	w15, w15, w21
add	w16, w16, w17
add	w13, w13, w19
add	w14, w14, w20
eor	w10, w10, w15
eor	w11, w11, w16
eor	w12, w12, w13
eor	w9, w9, w14
ror	w10, w10, #0x19
ror	w11, w11, #0x19
ror	w12, w12, #0x19
ror	w9, w9, #0x19
cbnz	x4, L_98
add	w5, w5, w22
add	x6, x6, x22, lsr #32
add	w7, w7, w23
add	x8, x8, x23, lsr #32
add	w9, w9, w24
add	x10, x10, x24, lsr #32
add	w11, w11, w25
add	x12, x12, x25, lsr #32
add	w13, w13, w26
add	x14, x14, x26, lsr #32
add	w15, w15, w27
add	x16, x16, x27, lsr #32
add	w17, w17, w28
add	x19, x19, x28, lsr #32
add	w20, w20, w30
add	x21, x21, x30, lsr #32
b.lo	L_300
add	x5, x5, x6, lsl #32
add	x7, x7, x8, lsl #32
ldp	x6, x8, [x1]
add	x9, x9, x10, lsl #32
add	x11, x11, x12, lsl #32
ldp	x10, x12, [x1, #0x10]
add	x13, x13, x14, lsl #32
add	x15, x15, x16, lsl #32
ldp	x14, x16, [x1, #0x20]
add	x17, x17, x19, lsl #32
add	x20, x20, x21, lsl #32
ldp	x19, x21, [x1, #0x30]
add	x1, x1, #0x40
eor	x5, x5, x6
eor	x7, x7, x8
eor	x9, x9, x10
eor	x11, x11, x12
eor	x13, x13, x14
eor	x15, x15, x16
eor	x17, x17, x19
eor	x20, x20, x21
stp	x5, x7, [x0]
add	x28, x28, #0x1
stp	x9, x11, [x0, #0x10]
stp	x13, x15, [x0, #0x20]
stp	x17, x20, [x0, #0x30]
add	x0, x0, #0x40
b.hi	L_50
ldp	x19, x20, [x29, #0x10]
add	sp, sp, #0x40
ldp	x21, x22, [x29, #0x20]
ldp	x23, x24, [x29, #0x30]
ldp	x25, x26, [x29, #0x40]
ldp	x27, x28, [x29, #0x50]
ldp	x29, x30, [sp], #0x60
L_2f0:
ret
nop
nop
nop
L_300:
add	x2, x2, #0x40
L_304:
sub	x0, x0, #0x1
add	x1, x1, x2
add	x0, x0, x2
add	x4, sp, x2
neg	x2, x2
add	x5, x5, x6, lsl #32
add	x7, x7, x8, lsl #32
add	x9, x9, x10, lsl #32
add	x11, x11, x12, lsl #32
add	x13, x13, x14, lsl #32
add	x15, x15, x16, lsl #32
add	x17, x17, x19, lsl #32
add	x20, x20, x21, lsl #32
stp	x5, x7, [sp]
stp	x9, x11, [sp, #0x10]
stp	x13, x15, [sp, #0x20]
stp	x17, x20, [sp, #0x30]
L_348:
ldrb	w10, [x1, x2]
ldrb	w11, [x4, x2]
add	x2, x2, #0x1
eor	w10, w10, w11
strb	w10, [x0, x2]
cbnz	x2, L_348
stp	xzr, xzr, [sp]
stp	xzr, xzr, [sp, #0x10]
stp	xzr, xzr, [sp, #0x20]
stp	xzr, xzr, [sp, #0x30]
ldp	x19, x20, [x29, #0x10]
add	sp, sp, #0x40
ldp	x21, x22, [x29, #0x20]
ldp	x23, x24, [x29, #0x30]
ldp	x25, x26, [x29, #0x40]
ldp	x27, x28, [x29, #0x50]
ldp	x29, x30, [sp], #0x60
ret
nop
nop
nop
nop
ChaCha20_ctr32:
cbz	x2, L_2f0
cmp	x2, #0xc0
b.lo	L_18
adrp	x17, OPENSSL_armcap_P
ldr	w17, [x17]
tst	w17, #0x2000
b.eq	L_10
stp	x29, x30, [sp, #-0x10]!
sub	sp, sp, #0x10
ldp	x5, x6, [x4]
stp	x5, x6, [sp]
mov	x4, sp
bl	ChaCha20_ctr32_sve
cbz	x2, L_3dc
bl	ChaCha20_ctr32_dflt
L_3dc:
add	sp, sp, #0x10
ldp	x29, x30, [sp], #0x10
ret
b	L_18
nop
nop
nop
nop
nop
ChaCha20_neon:
stp	x29, x30, [sp, #-0x60]!
mov	x29, sp
adrp	x5, _chacha_sve_consts-96
add	x5, x5, :lo12:_chacha_sve_consts-96
stp	x19, x20, [sp, #0x10]
stp	x21, x22, [sp, #0x20]
stp	x23, x24, [sp, #0x30]
stp	x25, x26, [sp, #0x40]
stp	x27, x28, [sp, #0x50]
cmp	x2, #0x200
b.hs	L_c04
sub	sp, sp, #0x40
ldp	x22, x23, [x5]
ld1	{ v0.4s }, [x5], #16
ldp	x24, x25, [x3]
ldp	x26, x27, [x3, #0x10]
ld1	{ v1.4s, v2.4s }, [x3]
ldp	x28, x30, [x4]
ld1	{ v3.4s }, [x4]
stp	d8, d9, [sp]
ld1	{ v8.4s, v9.4s }, [x5]
L_454:
dup	v16.4s, v0.s[0]
mov	w5, w22
dup	v20.4s, v0.s[1]
lsr	x6, x22, #32
dup	v24.4s, v0.s[2]
mov	w7, w23
dup	v28.4s, v0.s[3]
lsr	x8, x23, #32
dup	v17.4s, v1.s[0]
mov	w9, w24
dup	v21.4s, v1.s[1]
lsr	x10, x24, #32
dup	v25.4s, v1.s[2]
mov	w11, w25
dup	v29.4s, v1.s[3]
lsr	x12, x25, #32
dup	v19.4s, v3.s[0]
mov	w13, w26
dup	v23.4s, v3.s[1]
lsr	x14, x26, #32
dup	v27.4s, v3.s[2]
mov	w15, w27
dup	v31.4s, v3.s[3]
lsr	x16, x27, #32
add	v19.4s, v19.4s, v8.4s
mov	w17, w28
dup	v18.4s, v2.s[0]
lsr	x19, x28, #32
dup	v22.4s, v2.s[1]
mov	w20, w30
dup	v26.4s, v2.s[2]
lsr	x21, x30, #32
dup	v30.4s, v2.s[3]
mov	x4, #0xa
subs	x2, x2, #0x140
L_4e0:
sub	x4, x4, #0x1
add	v16.4s, v16.4s, v17.4s
add	w5, w5, w9
add	v20.4s, v20.4s, v21.4s
add	w6, w6, w10
add	v24.4s, v24.4s, v25.4s
add	w7, w7, w11
add	v28.4s, v28.4s, v29.4s
add	w8, w8, w12
eor	v19.16b, v19.16b, v16.16b
eor	w17, w17, w5
eor	v23.16b, v23.16b, v20.16b
eor	w19, w19, w6
eor	v27.16b, v27.16b, v24.16b
eor	w20, w20, w7
eor	v31.16b, v31.16b, v28.16b
eor	w21, w21, w8
rev32	v19.8h, v19.8h
ror	w17, w17, #0x10
rev32	v23.8h, v23.8h
ror	w19, w19, #0x10
rev32	v27.8h, v27.8h
ror	w20, w20, #0x10
rev32	v31.8h, v31.8h
ror	w21, w21, #0x10
add	v18.4s, v18.4s, v19.4s
add	w13, w13, w17
add	v22.4s, v22.4s, v23.4s
add	w14, w14, w19
add	v26.4s, v26.4s, v27.4s
add	w15, w15, w20
add	v30.4s, v30.4s, v31.4s
add	w16, w16, w21
eor	v4.16b, v17.16b, v18.16b
eor	w9, w9, w13
eor	v5.16b, v21.16b, v22.16b
eor	w10, w10, w14
eor	v6.16b, v25.16b, v26.16b
eor	w11, w11, w15
eor	v7.16b, v29.16b, v30.16b
eor	w12, w12, w16
ushr	v17.4s, v4.4s, #0x14
ror	w9, w9, #0x14
ushr	v21.4s, v5.4s, #0x14
ror	w10, w10, #0x14
ushr	v25.4s, v6.4s, #0x14
ror	w11, w11, #0x14
ushr	v29.4s, v7.4s, #0x14
ror	w12, w12, #0x14
sli	v17.4s, v4.4s, #0xc
add	w5, w5, w9
sli	v21.4s, v5.4s, #0xc
add	w6, w6, w10
sli	v25.4s, v6.4s, #0xc
add	w7, w7, w11
sli	v29.4s, v7.4s, #0xc
add	w8, w8, w12
add	v16.4s, v16.4s, v17.4s
eor	w17, w17, w5
add	v20.4s, v20.4s, v21.4s
eor	w19, w19, w6
add	v24.4s, v24.4s, v25.4s
eor	w20, w20, w7
add	v28.4s, v28.4s, v29.4s
eor	w21, w21, w8
eor	v4.16b, v19.16b, v16.16b
ror	w17, w17, #0x18
eor	v5.16b, v23.16b, v20.16b
ror	w19, w19, #0x18
eor	v6.16b, v27.16b, v24.16b
ror	w20, w20, #0x18
eor	v7.16b, v31.16b, v28.16b
ror	w21, w21, #0x18
tbl	v19.16b, { v4.16b }, v9.16b
add	w13, w13, w17
tbl	v23.16b, { v5.16b }, v9.16b
add	w14, w14, w19
tbl	v27.16b, { v6.16b }, v9.16b
add	w15, w15, w20
tbl	v31.16b, { v7.16b }, v9.16b
add	w16, w16, w21
add	v18.4s, v18.4s, v19.4s
eor	w9, w9, w13
add	v22.4s, v22.4s, v23.4s
eor	w10, w10, w14
add	v26.4s, v26.4s, v27.4s
eor	w11, w11, w15
add	v30.4s, v30.4s, v31.4s
eor	w12, w12, w16
eor	v4.16b, v17.16b, v18.16b
ror	w9, w9, #0x19
eor	v5.16b, v21.16b, v22.16b
ror	w10, w10, #0x19
eor	v6.16b, v25.16b, v26.16b
ror	w11, w11, #0x19
eor	v7.16b, v29.16b, v30.16b
ror	w12, w12, #0x19
ushr	v17.4s, v4.4s, #0x19
ushr	v21.4s, v5.4s, #0x19
ushr	v25.4s, v6.4s, #0x19
ushr	v29.4s, v7.4s, #0x19
sli	v17.4s, v4.4s, #0x7
sli	v21.4s, v5.4s, #0x7
sli	v25.4s, v6.4s, #0x7
sli	v29.4s, v7.4s, #0x7
add	v16.4s, v16.4s, v21.4s
add	w5, w5, w10
add	v20.4s, v20.4s, v25.4s
add	w6, w6, w11
add	v24.4s, v24.4s, v29.4s
add	w7, w7, w12
add	v28.4s, v28.4s, v17.4s
add	w8, w8, w9
eor	v31.16b, v31.16b, v16.16b
eor	w21, w21, w5
eor	v19.16b, v19.16b, v20.16b
eor	w17, w17, w6
eor	v23.16b, v23.16b, v24.16b
eor	w19, w19, w7
eor	v27.16b, v27.16b, v28.16b
eor	w20, w20, w8
rev32	v31.8h, v31.8h
ror	w21, w21, #0x10
rev32	v19.8h, v19.8h
ror	w17, w17, #0x10
rev32	v23.8h, v23.8h
ror	w19, w19, #0x10
rev32	v27.8h, v27.8h
ror	w20, w20, #0x10
add	v26.4s, v26.4s, v31.4s
add	w15, w15, w21
add	v30.4s, v30.4s, v19.4s
add	w16, w16, w17
add	v18.4s, v18.4s, v23.4s
add	w13, w13, w19
add	v22.4s, v22.4s, v27.4s
add	w14, w14, w20
eor	v4.16b, v21.16b, v26.16b
eor	w10, w10, w15
eor	v5.16b, v25.16b, v30.16b
eor	w11, w11, w16
eor	v6.16b, v29.16b, v18.16b
eor	w12, w12, w13
eor	v7.16b, v17.16b, v22.16b
eor	w9, w9, w14
ushr	v21.4s, v4.4s, #0x14
ror	w10, w10, #0x14
ushr	v25.4s, v5.4s, #0x14
ror	w11, w11, #0x14
ushr	v29.4s, v6.4s, #0x14
ror	w12, w12, #0x14
ushr	v17.4s, v7.4s, #0x14
ror	w9, w9, #0x14
sli	v21.4s, v4.4s, #0xc
add	w5, w5, w10
sli	v25.4s, v5.4s, #0xc
add	w6, w6, w11
sli	v29.4s, v6.4s, #0xc
add	w7, w7, w12
sli	v17.4s, v7.4s, #0xc
add	w8, w8, w9
add	v16.4s, v16.4s, v21.4s
eor	w21, w21, w5
add	v20.4s, v20.4s, v25.4s
eor	w17, w17, w6
add	v24.4s, v24.4s, v29.4s
eor	w19, w19, w7
add	v28.4s, v28.4s, v17.4s
eor	w20, w20, w8
eor	v4.16b, v31.16b, v16.16b
ror	w21, w21, #0x18
eor	v5.16b, v19.16b, v20.16b
ror	w17, w17, #0x18
eor	v6.16b, v23.16b, v24.16b
ror	w19, w19, #0x18
eor	v7.16b, v27.16b, v28.16b
ror	w20, w20, #0x18
tbl	v31.16b, { v4.16b }, v9.16b
add	w15, w15, w21
tbl	v19.16b, { v5.16b }, v9.16b
add	w16, w16, w17
tbl	v23.16b, { v6.16b }, v9.16b
add	w13, w13, w19
tbl	v27.16b, { v7.16b }, v9.16b
add	w14, w14, w20
add	v26.4s, v26.4s, v31.4s
eor	w10, w10, w15
add	v30.4s, v30.4s, v19.4s
eor	w11, w11, w16
add	v18.4s, v18.4s, v23.4s
eor	w12, w12, w13
add	v22.4s, v22.4s, v27.4s
eor	w9, w9, w14
eor	v4.16b, v21.16b, v26.16b
ror	w10, w10, #0x19
eor	v5.16b, v25.16b, v30.16b
ror	w11, w11, #0x19
eor	v6.16b, v29.16b, v18.16b
ror	w12, w12, #0x19
eor	v7.16b, v17.16b, v22.16b
ror	w9, w9, #0x19
ushr	v21.4s, v4.4s, #0x19
ushr	v25.4s, v5.4s, #0x19
ushr	v29.4s, v6.4s, #0x19
ushr	v17.4s, v7.4s, #0x19
sli	v21.4s, v4.4s, #0x7
sli	v25.4s, v5.4s, #0x7
sli	v29.4s, v6.4s, #0x7
sli	v17.4s, v7.4s, #0x7
cbnz	x4, L_4e0
add	v19.4s, v19.4s, v8.4s
zip1	v4.4s, v16.4s, v20.4s
zip1	v5.4s, v24.4s, v28.4s
zip2	v6.4s, v16.4s, v20.4s
zip2	v7.4s, v24.4s, v28.4s
zip1	v16.2d, v4.2d, v5.2d
zip2	v20.2d, v4.2d, v5.2d
zip1	v24.2d, v6.2d, v7.2d
zip2	v28.2d, v6.2d, v7.2d
zip1	v4.4s, v17.4s, v21.4s
zip1	v5.4s, v25.4s, v29.4s
zip2	v6.4s, v17.4s, v21.4s
zip2	v7.4s, v25.4s, v29.4s
zip1	v17.2d, v4.2d, v5.2d
zip2	v21.2d, v4.2d, v5.2d
zip1	v25.2d, v6.2d, v7.2d
zip2	v29.2d, v6.2d, v7.2d
zip1	v4.4s, v18.4s, v22.4s
add	w5, w5, w22
zip1	v5.4s, v26.4s, v30.4s
add	x6, x6, x22, lsr #32
zip2	v6.4s, v18.4s, v22.4s
add	w7, w7, w23
zip2	v7.4s, v26.4s, v30.4s
add	x8, x8, x23, lsr #32
zip1	v18.2d, v4.2d, v5.2d
add	w9, w9, w24
zip2	v22.2d, v4.2d, v5.2d
add	x10, x10, x24, lsr #32
zip1	v26.2d, v6.2d, v7.2d
add	w11, w11, w25
zip2	v30.2d, v6.2d, v7.2d
add	x12, x12, x25, lsr #32
zip1	v4.4s, v19.4s, v23.4s
add	w13, w13, w26
zip1	v5.4s, v27.4s, v31.4s
add	x14, x14, x26, lsr #32
zip2	v6.4s, v19.4s, v23.4s
add	w15, w15, w27
zip2	v7.4s, v27.4s, v31.4s
add	x16, x16, x27, lsr #32
zip1	v19.2d, v4.2d, v5.2d
add	w17, w17, w28
zip2	v23.2d, v4.2d, v5.2d
add	x19, x19, x28, lsr #32
zip1	v27.2d, v6.2d, v7.2d
add	w20, w20, w30
zip2	v31.2d, v6.2d, v7.2d
add	x21, x21, x30, lsr #32
b.lo	L_a30
add	x5, x5, x6, lsl #32
add	x7, x7, x8, lsl #32
ldp	x6, x8, [x1]
add	v16.4s, v16.4s, v0.4s
add	x9, x9, x10, lsl #32
add	x11, x11, x12, lsl #32
ldp	x10, x12, [x1, #0x10]
add	v17.4s, v17.4s, v1.4s
add	x13, x13, x14, lsl #32
add	x15, x15, x16, lsl #32
ldp	x14, x16, [x1, #0x20]
add	v18.4s, v18.4s, v2.4s
add	x17, x17, x19, lsl #32
add	x20, x20, x21, lsl #32
ldp	x19, x21, [x1, #0x30]
add	v19.4s, v19.4s, v3.4s
add	x1, x1, #0x40
ld1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
eor	x5, x5, x6
add	v20.4s, v20.4s, v0.4s
eor	x7, x7, x8
add	v21.4s, v21.4s, v1.4s
eor	x9, x9, x10
add	v22.4s, v22.4s, v2.4s
eor	x11, x11, x12
add	v23.4s, v23.4s, v3.4s
eor	x13, x13, x14
eor	v16.16b, v16.16b, v4.16b
movi	v4.4s, #0x5
eor	x15, x15, x16
eor	v17.16b, v17.16b, v5.16b
eor	x17, x17, x19
eor	v18.16b, v18.16b, v6.16b
eor	x20, x20, x21
eor	v19.16b, v19.16b, v7.16b
add	v8.4s, v8.4s, v4.4s
ld1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
stp	x5, x7, [x0]
add	x28, x28, #0x5
stp	x9, x11, [x0, #0x10]
stp	x13, x15, [x0, #0x20]
stp	x17, x20, [x0, #0x30]
add	x0, x0, #0x40
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x0], #64
add	v24.4s, v24.4s, v0.4s
add	v25.4s, v25.4s, v1.4s
add	v26.4s, v26.4s, v2.4s
add	v27.4s, v27.4s, v3.4s
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x1], #64
eor	v20.16b, v20.16b, v4.16b
eor	v21.16b, v21.16b, v5.16b
eor	v22.16b, v22.16b, v6.16b
eor	v23.16b, v23.16b, v7.16b
st1	{ v20.16b, v21.16b, v22.16b, v23.16b }, [x0], #64
add	v28.4s, v28.4s, v0.4s
add	v29.4s, v29.4s, v1.4s
add	v30.4s, v30.4s, v2.4s
add	v31.4s, v31.4s, v3.4s
ld1	{ v20.16b, v21.16b, v22.16b, v23.16b }, [x1], #64
eor	v24.16b, v24.16b, v16.16b
eor	v25.16b, v25.16b, v17.16b
eor	v26.16b, v26.16b, v18.16b
eor	v27.16b, v27.16b, v19.16b
st1	{ v24.16b, v25.16b, v26.16b, v27.16b }, [x0], #64
eor	v28.16b, v28.16b, v20.16b
eor	v29.16b, v29.16b, v21.16b
eor	v30.16b, v30.16b, v22.16b
eor	v31.16b, v31.16b, v23.16b
st1	{ v28.16b, v29.16b, v30.16b, v31.16b }, [x0], #64
b.hi	L_454
ldp	d8, d9, [sp]
ldp	x19, x20, [x29, #0x10]
add	sp, sp, #0x40
ldp	x21, x22, [x29, #0x20]
ldp	x23, x24, [x29, #0x30]
ldp	x25, x26, [x29, #0x40]
ldp	x27, x28, [x29, #0x50]
ldp	x29, x30, [sp], #0x60
ret
nop
L_a30:
add	x2, x2, #0x140
ldp	d8, d9, [sp]
cmp	x2, #0x40
b.lo	L_304
add	x5, x5, x6, lsl #32
add	x7, x7, x8, lsl #32
ldp	x6, x8, [x1]
add	x9, x9, x10, lsl #32
add	x11, x11, x12, lsl #32
ldp	x10, x12, [x1, #0x10]
add	x13, x13, x14, lsl #32
add	x15, x15, x16, lsl #32
ldp	x14, x16, [x1, #0x20]
add	x17, x17, x19, lsl #32
add	x20, x20, x21, lsl #32
ldp	x19, x21, [x1, #0x30]
add	x1, x1, #0x40
eor	x5, x5, x6
eor	x7, x7, x8
eor	x9, x9, x10
eor	x11, x11, x12
eor	x13, x13, x14
eor	x15, x15, x16
eor	x17, x17, x19
eor	x20, x20, x21
stp	x5, x7, [x0]
add	v16.4s, v16.4s, v0.4s
stp	x9, x11, [x0, #0x10]
add	v17.4s, v17.4s, v1.4s
stp	x13, x15, [x0, #0x20]
add	v18.4s, v18.4s, v2.4s
stp	x17, x20, [x0, #0x30]
add	v19.4s, v19.4s, v3.4s
add	x0, x0, #0x40
b.eq	L_ba8
sub	x2, x2, #0x40
cmp	x2, #0x40
b.lo	L_b68
ld1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
eor	v16.16b, v16.16b, v4.16b
eor	v17.16b, v17.16b, v5.16b
eor	v18.16b, v18.16b, v6.16b
eor	v19.16b, v19.16b, v7.16b
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x0], #64
b.eq	L_ba8
add	v16.4s, v20.4s, v0.4s
add	v17.4s, v21.4s, v1.4s
sub	x2, x2, #0x40
add	v18.4s, v22.4s, v2.4s
cmp	x2, #0x40
add	v19.4s, v23.4s, v3.4s
b.lo	L_b68
ld1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
eor	v20.16b, v16.16b, v4.16b
eor	v21.16b, v17.16b, v5.16b
eor	v22.16b, v18.16b, v6.16b
eor	v23.16b, v19.16b, v7.16b
st1	{ v20.16b, v21.16b, v22.16b, v23.16b }, [x0], #64
b.eq	L_ba8
add	v16.4s, v24.4s, v0.4s
add	v17.4s, v25.4s, v1.4s
sub	x2, x2, #0x40
add	v18.4s, v26.4s, v2.4s
cmp	x2, #0x40
add	v19.4s, v27.4s, v3.4s
b.lo	L_b68
ld1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
eor	v24.16b, v16.16b, v4.16b
eor	v25.16b, v17.16b, v5.16b
eor	v26.16b, v18.16b, v6.16b
eor	v27.16b, v19.16b, v7.16b
st1	{ v24.16b, v25.16b, v26.16b, v27.16b }, [x0], #64
b.eq	L_ba8
add	v16.4s, v28.4s, v0.4s
add	v17.4s, v29.4s, v1.4s
add	v18.4s, v30.4s, v2.4s
add	v19.4s, v31.4s, v3.4s
sub	x2, x2, #0x40
L_b68:
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [sp]
sub	x0, x0, #0x1
add	x1, x1, x2
add	x0, x0, x2
add	x4, sp, x2
neg	x2, x2
L_b80:
ldrb	w10, [x1, x2]
ldrb	w11, [x4, x2]
add	x2, x2, #0x1
eor	w10, w10, w11
strb	w10, [x0, x2]
cbnz	x2, L_b80
stp	xzr, xzr, [sp]
stp	xzr, xzr, [sp, #0x10]
stp	xzr, xzr, [sp, #0x20]
stp	xzr, xzr, [sp, #0x30]
L_ba8:
ldp	x19, x20, [x29, #0x10]
add	sp, sp, #0x40
ldp	x21, x22, [x29, #0x20]
ldp	x23, x24, [x29, #0x30]
ldp	x25, x26, [x29, #0x40]
ldp	x27, x28, [x29, #0x50]
ldp	x29, x30, [sp], #0x60
ret
nop
nop
nop
nop
nop
nop
ChaCha20_512_neon:
stp	x29, x30, [sp, #-0x60]!
mov	x29, sp
adrp	x5, _chacha_sve_consts-96
add	x5, x5, :lo12:_chacha_sve_consts-96
stp	x19, x20, [sp, #0x10]
stp	x21, x22, [sp, #0x20]
stp	x23, x24, [sp, #0x30]
stp	x25, x26, [sp, #0x40]
stp	x27, x28, [sp, #0x50]
L_c04:
sub	sp, sp, #0xc0
eor	v7.16b, v7.16b, v7.16b
ldp	x22, x23, [x5]
ld1	{ v0.4s }, [x5], #16
ldp	x24, x25, [x3]
ldp	x26, x27, [x3, #0x10]
ld1	{ v1.4s, v2.4s }, [x3]
ldp	x28, x30, [x4]
ld1	{ v3.4s }, [x4]
ld1	{ v7.s }[0], [x5]
add	x3, x5, #0x10
add	v3.4s, v3.4s, v7.4s
stp	q0, q1, [sp]
add	v3.4s, v3.4s, v7.4s
str	q2, [sp, #0x20]
add	v4.4s, v3.4s, v7.4s
add	v5.4s, v4.4s, v7.4s
add	v6.4s, v5.4s, v7.4s
shl	v7.4s, v7.4s, #0x2
stp	d8, d9, [sp, #0x80]
stp	d10, d11, [sp, #0x90]
stp	d12, d13, [sp, #0xa0]
stp	d14, d15, [sp, #0xb0]
sub	x2, x2, #0x200
L_c64:
mov	v8.16b, v0.16b
mov	v12.16b, v0.16b
mov	v16.16b, v0.16b
mov	v20.16b, v0.16b
mov	v24.16b, v0.16b
mov	v28.16b, v0.16b
mov	v9.16b, v1.16b
mov	w5, w22
mov	v13.16b, v1.16b
lsr	x6, x22, #32
mov	v17.16b, v1.16b
mov	w7, w23
mov	v21.16b, v1.16b
lsr	x8, x23, #32
mov	v25.16b, v1.16b
mov	w9, w24
mov	v29.16b, v1.16b
lsr	x10, x24, #32
mov	v11.16b, v3.16b
mov	w11, w25
mov	v15.16b, v4.16b
lsr	x12, x25, #32
mov	v19.16b, v5.16b
mov	w13, w26
mov	v23.16b, v6.16b
lsr	x14, x26, #32
mov	v10.16b, v2.16b
mov	w15, w27
mov	v14.16b, v2.16b
lsr	x16, x27, #32
add	v27.4s, v11.4s, v7.4s
mov	w17, w28
add	v31.4s, v15.4s, v7.4s
lsr	x19, x28, #32
mov	v18.16b, v2.16b
mov	w20, w30
mov	v22.16b, v2.16b
lsr	x21, x30, #32
mov	v26.16b, v2.16b
stp	q3, q4, [sp, #0x30]
mov	v30.16b, v2.16b
stp	q5, q6, [sp, #0x50]
mov	x4, #0x5
ld1	{ v6.4s }, [x3]
subs	x2, x2, #0x200
L_d18:
sub	x4, x4, #0x1
add	v8.4s, v8.4s, v9.4s
add	w5, w5, w9
add	v12.4s, v12.4s, v13.4s
add	w6, w6, w10
add	v16.4s, v16.4s, v17.4s
add	w7, w7, w11
add	v20.4s, v20.4s, v21.4s
add	w8, w8, w12
add	v24.4s, v24.4s, v25.4s
eor	w17, w17, w5
add	v28.4s, v28.4s, v29.4s
eor	w19, w19, w6
eor	v11.16b, v11.16b, v8.16b
eor	w20, w20, w7
eor	v15.16b, v15.16b, v12.16b
eor	w21, w21, w8
eor	v19.16b, v19.16b, v16.16b
ror	w17, w17, #0x10
eor	v23.16b, v23.16b, v20.16b
ror	w19, w19, #0x10
eor	v27.16b, v27.16b, v24.16b
ror	w20, w20, #0x10
eor	v31.16b, v31.16b, v28.16b
ror	w21, w21, #0x10
rev32	v11.8h, v11.8h
add	w13, w13, w17
rev32	v15.8h, v15.8h
add	w14, w14, w19
rev32	v19.8h, v19.8h
add	w15, w15, w20
rev32	v23.8h, v23.8h
add	w16, w16, w21
rev32	v27.8h, v27.8h
eor	w9, w9, w13
rev32	v31.8h, v31.8h
eor	w10, w10, w14
add	v10.4s, v10.4s, v11.4s
eor	w11, w11, w15
add	v14.4s, v14.4s, v15.4s
eor	w12, w12, w16
add	v18.4s, v18.4s, v19.4s
ror	w9, w9, #0x14
add	v22.4s, v22.4s, v23.4s
ror	w10, w10, #0x14
add	v26.4s, v26.4s, v27.4s
ror	w11, w11, #0x14
add	v30.4s, v30.4s, v31.4s
ror	w12, w12, #0x14
eor	v0.16b, v9.16b, v10.16b
add	w5, w5, w9
eor	v1.16b, v13.16b, v14.16b
add	w6, w6, w10
eor	v2.16b, v17.16b, v18.16b
add	w7, w7, w11
eor	v3.16b, v21.16b, v22.16b
add	w8, w8, w12
eor	v4.16b, v25.16b, v26.16b
eor	w17, w17, w5
eor	v5.16b, v29.16b, v30.16b
eor	w19, w19, w6
ushr	v9.4s, v0.4s, #0x14
eor	w20, w20, w7
ushr	v13.4s, v1.4s, #0x14
eor	w21, w21, w8
ushr	v17.4s, v2.4s, #0x14
ror	w17, w17, #0x18
ushr	v21.4s, v3.4s, #0x14
ror	w19, w19, #0x18
ushr	v25.4s, v4.4s, #0x14
ror	w20, w20, #0x18
ushr	v29.4s, v5.4s, #0x14
ror	w21, w21, #0x18
sli	v9.4s, v0.4s, #0xc
add	w13, w13, w17
sli	v13.4s, v1.4s, #0xc
add	w14, w14, w19
sli	v17.4s, v2.4s, #0xc
add	w15, w15, w20
sli	v21.4s, v3.4s, #0xc
add	w16, w16, w21
sli	v25.4s, v4.4s, #0xc
eor	w9, w9, w13
sli	v29.4s, v5.4s, #0xc
eor	w10, w10, w14
add	v8.4s, v8.4s, v9.4s
eor	w11, w11, w15
add	v12.4s, v12.4s, v13.4s
eor	w12, w12, w16
add	v16.4s, v16.4s, v17.4s
ror	w9, w9, #0x19
add	v20.4s, v20.4s, v21.4s
ror	w10, w10, #0x19
add	v24.4s, v24.4s, v25.4s
ror	w11, w11, #0x19
add	v28.4s, v28.4s, v29.4s
ror	w12, w12, #0x19
eor	v11.16b, v11.16b, v8.16b
add	w5, w5, w10
eor	v15.16b, v15.16b, v12.16b
add	w6, w6, w11
eor	v19.16b, v19.16b, v16.16b
add	w7, w7, w12
eor	v23.16b, v23.16b, v20.16b
add	w8, w8, w9
eor	v27.16b, v27.16b, v24.16b
eor	w21, w21, w5
eor	v31.16b, v31.16b, v28.16b
eor	w17, w17, w6
tbl	v11.16b, { v11.16b }, v6.16b
eor	w19, w19, w7
tbl	v15.16b, { v15.16b }, v6.16b
eor	w20, w20, w8
tbl	v19.16b, { v19.16b }, v6.16b
ror	w21, w21, #0x10
tbl	v23.16b, { v23.16b }, v6.16b
ror	w17, w17, #0x10
tbl	v27.16b, { v27.16b }, v6.16b
ror	w19, w19, #0x10
tbl	v31.16b, { v31.16b }, v6.16b
ror	w20, w20, #0x10
add	v10.4s, v10.4s, v11.4s
add	w15, w15, w21
add	v14.4s, v14.4s, v15.4s
add	w16, w16, w17
add	v18.4s, v18.4s, v19.4s
add	w13, w13, w19
add	v22.4s, v22.4s, v23.4s
add	w14, w14, w20
add	v26.4s, v26.4s, v27.4s
eor	w10, w10, w15
add	v30.4s, v30.4s, v31.4s
eor	w11, w11, w16
eor	v0.16b, v9.16b, v10.16b
eor	w12, w12, w13
eor	v1.16b, v13.16b, v14.16b
eor	w9, w9, w14
eor	v2.16b, v17.16b, v18.16b
ror	w10, w10, #0x14
eor	v3.16b, v21.16b, v22.16b
ror	w11, w11, #0x14
eor	v4.16b, v25.16b, v26.16b
ror	w12, w12, #0x14
eor	v5.16b, v29.16b, v30.16b
ror	w9, w9, #0x14
ushr	v9.4s, v0.4s, #0x19
add	w5, w5, w10
ushr	v13.4s, v1.4s, #0x19
add	w6, w6, w11
ushr	v17.4s, v2.4s, #0x19
add	w7, w7, w12
ushr	v21.4s, v3.4s, #0x19
add	w8, w8, w9
ushr	v25.4s, v4.4s, #0x19
eor	w21, w21, w5
ushr	v29.4s, v5.4s, #0x19
eor	w17, w17, w6
sli	v9.4s, v0.4s, #0x7
eor	w19, w19, w7
sli	v13.4s, v1.4s, #0x7
eor	w20, w20, w8
sli	v17.4s, v2.4s, #0x7
ror	w21, w21, #0x18
sli	v21.4s, v3.4s, #0x7
ror	w17, w17, #0x18
sli	v25.4s, v4.4s, #0x7
ror	w19, w19, #0x18
sli	v29.4s, v5.4s, #0x7
ror	w20, w20, #0x18
ext	v10.16b, v10.16b, v10.16b, #0x8
add	w15, w15, w21
ext	v14.16b, v14.16b, v14.16b, #0x8
add	w16, w16, w17
ext	v18.16b, v18.16b, v18.16b, #0x8
add	w13, w13, w19
ext	v22.16b, v22.16b, v22.16b, #0x8
add	w14, w14, w20
ext	v26.16b, v26.16b, v26.16b, #0x8
eor	w10, w10, w15
ext	v30.16b, v30.16b, v30.16b, #0x8
eor	w11, w11, w16
ext	v11.16b, v11.16b, v11.16b, #0xc
eor	w12, w12, w13
ext	v15.16b, v15.16b, v15.16b, #0xc
eor	w9, w9, w14
ext	v19.16b, v19.16b, v19.16b, #0xc
ror	w10, w10, #0x19
ext	v23.16b, v23.16b, v23.16b, #0xc
ror	w11, w11, #0x19
ext	v27.16b, v27.16b, v27.16b, #0xc
ror	w12, w12, #0x19
ext	v31.16b, v31.16b, v31.16b, #0xc
ror	w9, w9, #0x19
ext	v9.16b, v9.16b, v9.16b, #0x4
ext	v13.16b, v13.16b, v13.16b, #0x4
ext	v17.16b, v17.16b, v17.16b, #0x4
ext	v21.16b, v21.16b, v21.16b, #0x4
ext	v25.16b, v25.16b, v25.16b, #0x4
ext	v29.16b, v29.16b, v29.16b, #0x4
add	v8.4s, v8.4s, v9.4s
add	w5, w5, w9
add	v12.4s, v12.4s, v13.4s
add	w6, w6, w10
add	v16.4s, v16.4s, v17.4s
add	w7, w7, w11
add	v20.4s, v20.4s, v21.4s
add	w8, w8, w12
add	v24.4s, v24.4s, v25.4s
eor	w17, w17, w5
add	v28.4s, v28.4s, v29.4s
eor	w19, w19, w6
eor	v11.16b, v11.16b, v8.16b
eor	w20, w20, w7
eor	v15.16b, v15.16b, v12.16b
eor	w21, w21, w8
eor	v19.16b, v19.16b, v16.16b
ror	w17, w17, #0x10
eor	v23.16b, v23.16b, v20.16b
ror	w19, w19, #0x10
eor	v27.16b, v27.16b, v24.16b
ror	w20, w20, #0x10
eor	v31.16b, v31.16b, v28.16b
ror	w21, w21, #0x10
rev32	v11.8h, v11.8h
add	w13, w13, w17
rev32	v15.8h, v15.8h
add	w14, w14, w19
rev32	v19.8h, v19.8h
add	w15, w15, w20
rev32	v23.8h, v23.8h
add	w16, w16, w21
rev32	v27.8h, v27.8h
eor	w9, w9, w13
rev32	v31.8h, v31.8h
eor	w10, w10, w14
add	v10.4s, v10.4s, v11.4s
eor	w11, w11, w15
add	v14.4s, v14.4s, v15.4s
eor	w12, w12, w16
add	v18.4s, v18.4s, v19.4s
ror	w9, w9, #0x14
add	v22.4s, v22.4s, v23.4s
ror	w10, w10, #0x14
add	v26.4s, v26.4s, v27.4s
ror	w11, w11, #0x14
add	v30.4s, v30.4s, v31.4s
ror	w12, w12, #0x14
eor	v0.16b, v9.16b, v10.16b
add	w5, w5, w9
eor	v1.16b, v13.16b, v14.16b
add	w6, w6, w10
eor	v2.16b, v17.16b, v18.16b
add	w7, w7, w11
eor	v3.16b, v21.16b, v22.16b
add	w8, w8, w12
eor	v4.16b, v25.16b, v26.16b
eor	w17, w17, w5
eor	v5.16b, v29.16b, v30.16b
eor	w19, w19, w6
ushr	v9.4s, v0.4s, #0x14
eor	w20, w20, w7
ushr	v13.4s, v1.4s, #0x14
eor	w21, w21, w8
ushr	v17.4s, v2.4s, #0x14
ror	w17, w17, #0x18
ushr	v21.4s, v3.4s, #0x14
ror	w19, w19, #0x18
ushr	v25.4s, v4.4s, #0x14
ror	w20, w20, #0x18
ushr	v29.4s, v5.4s, #0x14
ror	w21, w21, #0x18
sli	v9.4s, v0.4s, #0xc
add	w13, w13, w17
sli	v13.4s, v1.4s, #0xc
add	w14, w14, w19
sli	v17.4s, v2.4s, #0xc
add	w15, w15, w20
sli	v21.4s, v3.4s, #0xc
add	w16, w16, w21
sli	v25.4s, v4.4s, #0xc
eor	w9, w9, w13
sli	v29.4s, v5.4s, #0xc
eor	w10, w10, w14
add	v8.4s, v8.4s, v9.4s
eor	w11, w11, w15
add	v12.4s, v12.4s, v13.4s
eor	w12, w12, w16
add	v16.4s, v16.4s, v17.4s
ror	w9, w9, #0x19
add	v20.4s, v20.4s, v21.4s
ror	w10, w10, #0x19
add	v24.4s, v24.4s, v25.4s
ror	w11, w11, #0x19
add	v28.4s, v28.4s, v29.4s
ror	w12, w12, #0x19
eor	v11.16b, v11.16b, v8.16b
add	w5, w5, w10
eor	v15.16b, v15.16b, v12.16b
add	w6, w6, w11
eor	v19.16b, v19.16b, v16.16b
add	w7, w7, w12
eor	v23.16b, v23.16b, v20.16b
add	w8, w8, w9
eor	v27.16b, v27.16b, v24.16b
eor	w21, w21, w5
eor	v31.16b, v31.16b, v28.16b
eor	w17, w17, w6
tbl	v11.16b, { v11.16b }, v6.16b
eor	w19, w19, w7
tbl	v15.16b, { v15.16b }, v6.16b
eor	w20, w20, w8
tbl	v19.16b, { v19.16b }, v6.16b
ror	w21, w21, #0x10
tbl	v23.16b, { v23.16b }, v6.16b
ror	w17, w17, #0x10
tbl	v27.16b, { v27.16b }, v6.16b
ror	w19, w19, #0x10
tbl	v31.16b, { v31.16b }, v6.16b
ror	w20, w20, #0x10
add	v10.4s, v10.4s, v11.4s
add	w15, w15, w21
add	v14.4s, v14.4s, v15.4s
add	w16, w16, w17
add	v18.4s, v18.4s, v19.4s
add	w13, w13, w19
add	v22.4s, v22.4s, v23.4s
add	w14, w14, w20
add	v26.4s, v26.4s, v27.4s
eor	w10, w10, w15
add	v30.4s, v30.4s, v31.4s
eor	w11, w11, w16
eor	v0.16b, v9.16b, v10.16b
eor	w12, w12, w13
eor	v1.16b, v13.16b, v14.16b
eor	w9, w9, w14
eor	v2.16b, v17.16b, v18.16b
ror	w10, w10, #0x14
eor	v3.16b, v21.16b, v22.16b
ror	w11, w11, #0x14
eor	v4.16b, v25.16b, v26.16b
ror	w12, w12, #0x14
eor	v5.16b, v29.16b, v30.16b
ror	w9, w9, #0x14
ushr	v9.4s, v0.4s, #0x19
add	w5, w5, w10
ushr	v13.4s, v1.4s, #0x19
add	w6, w6, w11
ushr	v17.4s, v2.4s, #0x19
add	w7, w7, w12
ushr	v21.4s, v3.4s, #0x19
add	w8, w8, w9
ushr	v25.4s, v4.4s, #0x19
eor	w21, w21, w5
ushr	v29.4s, v5.4s, #0x19
eor	w17, w17, w6
sli	v9.4s, v0.4s, #0x7
eor	w19, w19, w7
sli	v13.4s, v1.4s, #0x7
eor	w20, w20, w8
sli	v17.4s, v2.4s, #0x7
ror	w21, w21, #0x18
sli	v21.4s, v3.4s, #0x7
ror	w17, w17, #0x18
sli	v25.4s, v4.4s, #0x7
ror	w19, w19, #0x18
sli	v29.4s, v5.4s, #0x7
ror	w20, w20, #0x18
ext	v10.16b, v10.16b, v10.16b, #0x8
add	w15, w15, w21
ext	v14.16b, v14.16b, v14.16b, #0x8
add	w16, w16, w17
ext	v18.16b, v18.16b, v18.16b, #0x8
add	w13, w13, w19
ext	v22.16b, v22.16b, v22.16b, #0x8
add	w14, w14, w20
ext	v26.16b, v26.16b, v26.16b, #0x8
eor	w10, w10, w15
ext	v30.16b, v30.16b, v30.16b, #0x8
eor	w11, w11, w16
ext	v11.16b, v11.16b, v11.16b, #0x4
eor	w12, w12, w13
ext	v15.16b, v15.16b, v15.16b, #0x4
eor	w9, w9, w14
ext	v19.16b, v19.16b, v19.16b, #0x4
ror	w10, w10, #0x19
ext	v23.16b, v23.16b, v23.16b, #0x4
ror	w11, w11, #0x19
ext	v27.16b, v27.16b, v27.16b, #0x4
ror	w12, w12, #0x19
ext	v31.16b, v31.16b, v31.16b, #0x4
ror	w9, w9, #0x19
ext	v9.16b, v9.16b, v9.16b, #0xc
ext	v13.16b, v13.16b, v13.16b, #0xc
ext	v17.16b, v17.16b, v17.16b, #0xc
ext	v21.16b, v21.16b, v21.16b, #0xc
ext	v25.16b, v25.16b, v25.16b, #0xc
ext	v29.16b, v29.16b, v29.16b, #0xc
cbnz	x4, L_d18
add	w5, w5, w22
add	x6, x6, x22, lsr #32
add	w7, w7, w23
add	x8, x8, x23, lsr #32
add	w9, w9, w24
add	x10, x10, x24, lsr #32
add	w11, w11, w25
add	x12, x12, x25, lsr #32
add	w13, w13, w26
add	x14, x14, x26, lsr #32
add	w15, w15, w27
add	x16, x16, x27, lsr #32
add	w17, w17, w28
add	x19, x19, x28, lsr #32
add	w20, w20, w30
add	x21, x21, x30, lsr #32
add	x5, x5, x6, lsl #32
add	x7, x7, x8, lsl #32
ldp	x6, x8, [x1]
add	x9, x9, x10, lsl #32
add	x11, x11, x12, lsl #32
ldp	x10, x12, [x1, #0x10]
add	x13, x13, x14, lsl #32
add	x15, x15, x16, lsl #32
ldp	x14, x16, [x1, #0x20]
add	x17, x17, x19, lsl #32
add	x20, x20, x21, lsl #32
ldp	x19, x21, [x1, #0x30]
add	x1, x1, #0x40
eor	x5, x5, x6
eor	x7, x7, x8
eor	x9, x9, x10
eor	x11, x11, x12
eor	x13, x13, x14
eor	x15, x15, x16
eor	x17, x17, x19
eor	x20, x20, x21
stp	x5, x7, [x0]
add	x28, x28, #0x1
mov	w5, w22
lsr	x6, x22, #32
stp	x9, x11, [x0, #0x10]
mov	w7, w23
lsr	x8, x23, #32
stp	x13, x15, [x0, #0x20]
mov	w9, w24
lsr	x10, x24, #32
stp	x17, x20, [x0, #0x30]
add	x0, x0, #0x40
mov	w11, w25
lsr	x12, x25, #32
mov	w13, w26
lsr	x14, x26, #32
mov	w15, w27
lsr	x16, x27, #32
mov	w17, w28
lsr	x19, x28, #32
mov	w20, w30
lsr	x21, x30, #32
mov	x4, #0x5
L_1440:
sub	x4, x4, #0x1
add	v8.4s, v8.4s, v9.4s
add	w5, w5, w9
add	v12.4s, v12.4s, v13.4s
add	w6, w6, w10
add	v16.4s, v16.4s, v17.4s
add	w7, w7, w11
add	v20.4s, v20.4s, v21.4s
add	w8, w8, w12
add	v24.4s, v24.4s, v25.4s
eor	w17, w17, w5
add	v28.4s, v28.4s, v29.4s
eor	w19, w19, w6
eor	v11.16b, v11.16b, v8.16b
eor	w20, w20, w7
eor	v15.16b, v15.16b, v12.16b
eor	w21, w21, w8
eor	v19.16b, v19.16b, v16.16b
ror	w17, w17, #0x10
eor	v23.16b, v23.16b, v20.16b
ror	w19, w19, #0x10
eor	v27.16b, v27.16b, v24.16b
ror	w20, w20, #0x10
eor	v31.16b, v31.16b, v28.16b
ror	w21, w21, #0x10
rev32	v11.8h, v11.8h
add	w13, w13, w17
rev32	v15.8h, v15.8h
add	w14, w14, w19
rev32	v19.8h, v19.8h
add	w15, w15, w20
rev32	v23.8h, v23.8h
add	w16, w16, w21
rev32	v27.8h, v27.8h
eor	w9, w9, w13
rev32	v31.8h, v31.8h
eor	w10, w10, w14
add	v10.4s, v10.4s, v11.4s
eor	w11, w11, w15
add	v14.4s, v14.4s, v15.4s
eor	w12, w12, w16
add	v18.4s, v18.4s, v19.4s
ror	w9, w9, #0x14
add	v22.4s, v22.4s, v23.4s
ror	w10, w10, #0x14
add	v26.4s, v26.4s, v27.4s
ror	w11, w11, #0x14
add	v30.4s, v30.4s, v31.4s
ror	w12, w12, #0x14
eor	v0.16b, v9.16b, v10.16b
add	w5, w5, w9
eor	v1.16b, v13.16b, v14.16b
add	w6, w6, w10
eor	v2.16b, v17.16b, v18.16b
add	w7, w7, w11
eor	v3.16b, v21.16b, v22.16b
add	w8, w8, w12
eor	v4.16b, v25.16b, v26.16b
eor	w17, w17, w5
eor	v5.16b, v29.16b, v30.16b
eor	w19, w19, w6
ushr	v9.4s, v0.4s, #0x14
eor	w20, w20, w7
ushr	v13.4s, v1.4s, #0x14
eor	w21, w21, w8
ushr	v17.4s, v2.4s, #0x14
ror	w17, w17, #0x18
ushr	v21.4s, v3.4s, #0x14
ror	w19, w19, #0x18
ushr	v25.4s, v4.4s, #0x14
ror	w20, w20, #0x18
ushr	v29.4s, v5.4s, #0x14
ror	w21, w21, #0x18
sli	v9.4s, v0.4s, #0xc
add	w13, w13, w17
sli	v13.4s, v1.4s, #0xc
add	w14, w14, w19
sli	v17.4s, v2.4s, #0xc
add	w15, w15, w20
sli	v21.4s, v3.4s, #0xc
add	w16, w16, w21
sli	v25.4s, v4.4s, #0xc
eor	w9, w9, w13
sli	v29.4s, v5.4s, #0xc
eor	w10, w10, w14
add	v8.4s, v8.4s, v9.4s
eor	w11, w11, w15
add	v12.4s, v12.4s, v13.4s
eor	w12, w12, w16
add	v16.4s, v16.4s, v17.4s
ror	w9, w9, #0x19
add	v20.4s, v20.4s, v21.4s
ror	w10, w10, #0x19
add	v24.4s, v24.4s, v25.4s
ror	w11, w11, #0x19
add	v28.4s, v28.4s, v29.4s
ror	w12, w12, #0x19
eor	v11.16b, v11.16b, v8.16b
add	w5, w5, w10
eor	v15.16b, v15.16b, v12.16b
add	w6, w6, w11
eor	v19.16b, v19.16b, v16.16b
add	w7, w7, w12
eor	v23.16b, v23.16b, v20.16b
add	w8, w8, w9
eor	v27.16b, v27.16b, v24.16b
eor	w21, w21, w5
eor	v31.16b, v31.16b, v28.16b
eor	w17, w17, w6
tbl	v11.16b, { v11.16b }, v6.16b
eor	w19, w19, w7
tbl	v15.16b, { v15.16b }, v6.16b
eor	w20, w20, w8
tbl	v19.16b, { v19.16b }, v6.16b
ror	w21, w21, #0x10
tbl	v23.16b, { v23.16b }, v6.16b
ror	w17, w17, #0x10
tbl	v27.16b, { v27.16b }, v6.16b
ror	w19, w19, #0x10
tbl	v31.16b, { v31.16b }, v6.16b
ror	w20, w20, #0x10
add	v10.4s, v10.4s, v11.4s
add	w15, w15, w21
add	v14.4s, v14.4s, v15.4s
add	w16, w16, w17
add	v18.4s, v18.4s, v19.4s
add	w13, w13, w19
add	v22.4s, v22.4s, v23.4s
add	w14, w14, w20
add	v26.4s, v26.4s, v27.4s
eor	w10, w10, w15
add	v30.4s, v30.4s, v31.4s
eor	w11, w11, w16
eor	v0.16b, v9.16b, v10.16b
eor	w12, w12, w13
eor	v1.16b, v13.16b, v14.16b
eor	w9, w9, w14
eor	v2.16b, v17.16b, v18.16b
ror	w10, w10, #0x14
eor	v3.16b, v21.16b, v22.16b
ror	w11, w11, #0x14
eor	v4.16b, v25.16b, v26.16b
ror	w12, w12, #0x14
eor	v5.16b, v29.16b, v30.16b
ror	w9, w9, #0x14
ushr	v9.4s, v0.4s, #0x19
add	w5, w5, w10
ushr	v13.4s, v1.4s, #0x19
add	w6, w6, w11
ushr	v17.4s, v2.4s, #0x19
add	w7, w7, w12
ushr	v21.4s, v3.4s, #0x19
add	w8, w8, w9
ushr	v25.4s, v4.4s, #0x19
eor	w21, w21, w5
ushr	v29.4s, v5.4s, #0x19
eor	w17, w17, w6
sli	v9.4s, v0.4s, #0x7
eor	w19, w19, w7
sli	v13.4s, v1.4s, #0x7
eor	w20, w20, w8
sli	v17.4s, v2.4s, #0x7
ror	w21, w21, #0x18
sli	v21.4s, v3.4s, #0x7
ror	w17, w17, #0x18
sli	v25.4s, v4.4s, #0x7
ror	w19, w19, #0x18
sli	v29.4s, v5.4s, #0x7
ror	w20, w20, #0x18
ext	v10.16b, v10.16b, v10.16b, #0x8
add	w15, w15, w21
ext	v14.16b, v14.16b, v14.16b, #0x8
add	w16, w16, w17
ext	v18.16b, v18.16b, v18.16b, #0x8
add	w13, w13, w19
ext	v22.16b, v22.16b, v22.16b, #0x8
add	w14, w14, w20
ext	v26.16b, v26.16b, v26.16b, #0x8
eor	w10, w10, w15
ext	v30.16b, v30.16b, v30.16b, #0x8
eor	w11, w11, w16
ext	v11.16b, v11.16b, v11.16b, #0xc
eor	w12, w12, w13
ext	v15.16b, v15.16b, v15.16b, #0xc
eor	w9, w9, w14
ext	v19.16b, v19.16b, v19.16b, #0xc
ror	w10, w10, #0x19
ext	v23.16b, v23.16b, v23.16b, #0xc
ror	w11, w11, #0x19
ext	v27.16b, v27.16b, v27.16b, #0xc
ror	w12, w12, #0x19
ext	v31.16b, v31.16b, v31.16b, #0xc
ror	w9, w9, #0x19
ext	v9.16b, v9.16b, v9.16b, #0x4
ext	v13.16b, v13.16b, v13.16b, #0x4
ext	v17.16b, v17.16b, v17.16b, #0x4
ext	v21.16b, v21.16b, v21.16b, #0x4
ext	v25.16b, v25.16b, v25.16b, #0x4
ext	v29.16b, v29.16b, v29.16b, #0x4
add	v8.4s, v8.4s, v9.4s
add	w5, w5, w9
add	v12.4s, v12.4s, v13.4s
add	w6, w6, w10
add	v16.4s, v16.4s, v17.4s
add	w7, w7, w11
add	v20.4s, v20.4s, v21.4s
add	w8, w8, w12
add	v24.4s, v24.4s, v25.4s
eor	w17, w17, w5
add	v28.4s, v28.4s, v29.4s
eor	w19, w19, w6
eor	v11.16b, v11.16b, v8.16b
eor	w20, w20, w7
eor	v15.16b, v15.16b, v12.16b
eor	w21, w21, w8
eor	v19.16b, v19.16b, v16.16b
ror	w17, w17, #0x10
eor	v23.16b, v23.16b, v20.16b
ror	w19, w19, #0x10
eor	v27.16b, v27.16b, v24.16b
ror	w20, w20, #0x10
eor	v31.16b, v31.16b, v28.16b
ror	w21, w21, #0x10
rev32	v11.8h, v11.8h
add	w13, w13, w17
rev32	v15.8h, v15.8h
add	w14, w14, w19
rev32	v19.8h, v19.8h
add	w15, w15, w20
rev32	v23.8h, v23.8h
add	w16, w16, w21
rev32	v27.8h, v27.8h
eor	w9, w9, w13
rev32	v31.8h, v31.8h
eor	w10, w10, w14
add	v10.4s, v10.4s, v11.4s
eor	w11, w11, w15
add	v14.4s, v14.4s, v15.4s
eor	w12, w12, w16
add	v18.4s, v18.4s, v19.4s
ror	w9, w9, #0x14
add	v22.4s, v22.4s, v23.4s
ror	w10, w10, #0x14
add	v26.4s, v26.4s, v27.4s
ror	w11, w11, #0x14
add	v30.4s, v30.4s, v31.4s
ror	w12, w12, #0x14
eor	v0.16b, v9.16b, v10.16b
add	w5, w5, w9
eor	v1.16b, v13.16b, v14.16b
add	w6, w6, w10
eor	v2.16b, v17.16b, v18.16b
add	w7, w7, w11
eor	v3.16b, v21.16b, v22.16b
add	w8, w8, w12
eor	v4.16b, v25.16b, v26.16b
eor	w17, w17, w5
eor	v5.16b, v29.16b, v30.16b
eor	w19, w19, w6
ushr	v9.4s, v0.4s, #0x14
eor	w20, w20, w7
ushr	v13.4s, v1.4s, #0x14
eor	w21, w21, w8
ushr	v17.4s, v2.4s, #0x14
ror	w17, w17, #0x18
ushr	v21.4s, v3.4s, #0x14
ror	w19, w19, #0x18
ushr	v25.4s, v4.4s, #0x14
ror	w20, w20, #0x18
ushr	v29.4s, v5.4s, #0x14
ror	w21, w21, #0x18
sli	v9.4s, v0.4s, #0xc
add	w13, w13, w17
sli	v13.4s, v1.4s, #0xc
add	w14, w14, w19
sli	v17.4s, v2.4s, #0xc
add	w15, w15, w20
sli	v21.4s, v3.4s, #0xc
add	w16, w16, w21
sli	v25.4s, v4.4s, #0xc
eor	w9, w9, w13
sli	v29.4s, v5.4s, #0xc
eor	w10, w10, w14
add	v8.4s, v8.4s, v9.4s
eor	w11, w11, w15
add	v12.4s, v12.4s, v13.4s
eor	w12, w12, w16
add	v16.4s, v16.4s, v17.4s
ror	w9, w9, #0x19
add	v20.4s, v20.4s, v21.4s
ror	w10, w10, #0x19
add	v24.4s, v24.4s, v25.4s
ror	w11, w11, #0x19
add	v28.4s, v28.4s, v29.4s
ror	w12, w12, #0x19
eor	v11.16b, v11.16b, v8.16b
add	w5, w5, w10
eor	v15.16b, v15.16b, v12.16b
add	w6, w6, w11
eor	v19.16b, v19.16b, v16.16b
add	w7, w7, w12
eor	v23.16b, v23.16b, v20.16b
add	w8, w8, w9
eor	v27.16b, v27.16b, v24.16b
eor	w21, w21, w5
eor	v31.16b, v31.16b, v28.16b
eor	w17, w17, w6
tbl	v11.16b, { v11.16b }, v6.16b
eor	w19, w19, w7
tbl	v15.16b, { v15.16b }, v6.16b
eor	w20, w20, w8
tbl	v19.16b, { v19.16b }, v6.16b
ror	w21, w21, #0x10
tbl	v23.16b, { v23.16b }, v6.16b
ror	w17, w17, #0x10
tbl	v27.16b, { v27.16b }, v6.16b
ror	w19, w19, #0x10
tbl	v31.16b, { v31.16b }, v6.16b
ror	w20, w20, #0x10
add	v10.4s, v10.4s, v11.4s
add	w15, w15, w21
add	v14.4s, v14.4s, v15.4s
add	w16, w16, w17
add	v18.4s, v18.4s, v19.4s
add	w13, w13, w19
add	v22.4s, v22.4s, v23.4s
add	w14, w14, w20
add	v26.4s, v26.4s, v27.4s
eor	w10, w10, w15
add	v30.4s, v30.4s, v31.4s
eor	w11, w11, w16
eor	v0.16b, v9.16b, v10.16b
eor	w12, w12, w13
eor	v1.16b, v13.16b, v14.16b
eor	w9, w9, w14
eor	v2.16b, v17.16b, v18.16b
ror	w10, w10, #0x14
eor	v3.16b, v21.16b, v22.16b
ror	w11, w11, #0x14
eor	v4.16b, v25.16b, v26.16b
ror	w12, w12, #0x14
eor	v5.16b, v29.16b, v30.16b
ror	w9, w9, #0x14
ushr	v9.4s, v0.4s, #0x19
add	w5, w5, w10
ushr	v13.4s, v1.4s, #0x19
add	w6, w6, w11
ushr	v17.4s, v2.4s, #0x19
add	w7, w7, w12
ushr	v21.4s, v3.4s, #0x19
add	w8, w8, w9
ushr	v25.4s, v4.4s, #0x19
eor	w21, w21, w5
ushr	v29.4s, v5.4s, #0x19
eor	w17, w17, w6
sli	v9.4s, v0.4s, #0x7
eor	w19, w19, w7
sli	v13.4s, v1.4s, #0x7
eor	w20, w20, w8
sli	v17.4s, v2.4s, #0x7
ror	w21, w21, #0x18
sli	v21.4s, v3.4s, #0x7
ror	w17, w17, #0x18
sli	v25.4s, v4.4s, #0x7
ror	w19, w19, #0x18
sli	v29.4s, v5.4s, #0x7
ror	w20, w20, #0x18
ext	v10.16b, v10.16b, v10.16b, #0x8
add	w15, w15, w21
ext	v14.16b, v14.16b, v14.16b, #0x8
add	w16, w16, w17
ext	v18.16b, v18.16b, v18.16b, #0x8
add	w13, w13, w19
ext	v22.16b, v22.16b, v22.16b, #0x8
add	w14, w14, w20
ext	v26.16b, v26.16b, v26.16b, #0x8
eor	w10, w10, w15
ext	v30.16b, v30.16b, v30.16b, #0x8
eor	w11, w11, w16
ext	v11.16b, v11.16b, v11.16b, #0x4
eor	w12, w12, w13
ext	v15.16b, v15.16b, v15.16b, #0x4
eor	w9, w9, w14
ext	v19.16b, v19.16b, v19.16b, #0x4
ror	w10, w10, #0x19
ext	v23.16b, v23.16b, v23.16b, #0x4
ror	w11, w11, #0x19
ext	v27.16b, v27.16b, v27.16b, #0x4
ror	w12, w12, #0x19
ext	v31.16b, v31.16b, v31.16b, #0x4
ror	w9, w9, #0x19
ext	v9.16b, v9.16b, v9.16b, #0xc
ext	v13.16b, v13.16b, v13.16b, #0xc
ext	v17.16b, v17.16b, v17.16b, #0xc
ext	v21.16b, v21.16b, v21.16b, #0xc
ext	v25.16b, v25.16b, v25.16b, #0xc
ext	v29.16b, v29.16b, v29.16b, #0xc
cbnz	x4, L_1440
add	w5, w5, w22
ldp	q0, q1, [sp]
add	x6, x6, x22, lsr #32
ldp	q2, q3, [sp, #0x20]
add	w7, w7, w23
ldp	q4, q5, [sp, #0x40]
add	x8, x8, x23, lsr #32
ldr	q6, [sp, #0x60]
add	v8.4s, v8.4s, v0.4s
add	w9, w9, w24
add	v12.4s, v12.4s, v0.4s
add	x10, x10, x24, lsr #32
add	v16.4s, v16.4s, v0.4s
add	w11, w11, w25
add	v20.4s, v20.4s, v0.4s
add	x12, x12, x25, lsr #32
add	v24.4s, v24.4s, v0.4s
add	w13, w13, w26
add	v28.4s, v28.4s, v0.4s
add	x14, x14, x26, lsr #32
add	v10.4s, v10.4s, v2.4s
add	w15, w15, w27
add	v14.4s, v14.4s, v2.4s
add	x16, x16, x27, lsr #32
add	v18.4s, v18.4s, v2.4s
add	w17, w17, w28
add	v22.4s, v22.4s, v2.4s
add	x19, x19, x28, lsr #32
add	v26.4s, v26.4s, v2.4s
add	w20, w20, w30
add	v30.4s, v30.4s, v2.4s
add	x21, x21, x30, lsr #32
add	v27.4s, v27.4s, v7.4s
add	x5, x5, x6, lsl #32
add	v31.4s, v31.4s, v7.4s
add	x7, x7, x8, lsl #32
add	v11.4s, v11.4s, v3.4s
ldp	x6, x8, [x1]
add	v15.4s, v15.4s, v4.4s
add	x9, x9, x10, lsl #32
add	v19.4s, v19.4s, v5.4s
add	x11, x11, x12, lsl #32
add	v23.4s, v23.4s, v6.4s
ldp	x10, x12, [x1, #0x10]
add	v27.4s, v27.4s, v3.4s
add	x13, x13, x14, lsl #32
add	v31.4s, v31.4s, v4.4s
add	x15, x15, x16, lsl #32
add	v9.4s, v9.4s, v1.4s
ldp	x14, x16, [x1, #0x20]
add	v13.4s, v13.4s, v1.4s
add	x17, x17, x19, lsl #32
add	v17.4s, v17.4s, v1.4s
add	x20, x20, x21, lsl #32
add	v21.4s, v21.4s, v1.4s
ldp	x19, x21, [x1, #0x30]
add	v25.4s, v25.4s, v1.4s
add	x1, x1, #0x40
add	v29.4s, v29.4s, v1.4s
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
eor	x5, x5, x6
eor	x7, x7, x8
eor	x9, x9, x10
eor	x11, x11, x12
eor	x13, x13, x14
eor	v8.16b, v8.16b, v0.16b
eor	x15, x15, x16
eor	v9.16b, v9.16b, v1.16b
eor	x17, x17, x19
eor	v10.16b, v10.16b, v2.16b
eor	x20, x20, x21
eor	v11.16b, v11.16b, v3.16b
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
stp	x5, x7, [x0]
add	x28, x28, #0x7
stp	x9, x11, [x0, #0x10]
stp	x13, x15, [x0, #0x20]
stp	x17, x20, [x0, #0x30]
add	x0, x0, #0x40
st1	{ v8.16b, v9.16b, v10.16b, v11.16b }, [x0], #64
ld1	{ v8.16b, v9.16b, v10.16b, v11.16b }, [x1], #64
eor	v12.16b, v12.16b, v0.16b
eor	v13.16b, v13.16b, v1.16b
eor	v14.16b, v14.16b, v2.16b
eor	v15.16b, v15.16b, v3.16b
st1	{ v12.16b, v13.16b, v14.16b, v15.16b }, [x0], #64
ld1	{ v12.16b, v13.16b, v14.16b, v15.16b }, [x1], #64
eor	v16.16b, v16.16b, v8.16b
ldp	q0, q1, [sp]
eor	v17.16b, v17.16b, v9.16b
ldp	q2, q3, [sp, #0x20]
eor	v18.16b, v18.16b, v10.16b
eor	v19.16b, v19.16b, v11.16b
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x0], #64
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x1], #64
eor	v20.16b, v20.16b, v12.16b
eor	v21.16b, v21.16b, v13.16b
eor	v22.16b, v22.16b, v14.16b
eor	v23.16b, v23.16b, v15.16b
st1	{ v20.16b, v21.16b, v22.16b, v23.16b }, [x0], #64
ld1	{ v20.16b, v21.16b, v22.16b, v23.16b }, [x1], #64
eor	v24.16b, v24.16b, v16.16b
eor	v25.16b, v25.16b, v17.16b
eor	v26.16b, v26.16b, v18.16b
eor	v27.16b, v27.16b, v19.16b
st1	{ v24.16b, v25.16b, v26.16b, v27.16b }, [x0], #64
shl	v8.4s, v7.4s, #0x1
eor	v28.16b, v28.16b, v20.16b
eor	v29.16b, v29.16b, v21.16b
eor	v30.16b, v30.16b, v22.16b
eor	v31.16b, v31.16b, v23.16b
st1	{ v28.16b, v29.16b, v30.16b, v31.16b }, [x0], #64
add	v3.4s, v3.4s, v8.4s
add	v4.4s, v4.4s, v8.4s
add	v5.4s, v5.4s, v8.4s
add	v6.4s, v6.4s, v8.4s
b.hs	L_c64
adds	x2, x2, #0x200
ushr	v7.4s, v7.4s, #0x1
ldp	d10, d11, [sp, #0x90]
ldp	d12, d13, [sp, #0xa0]
ldp	d14, d15, [sp, #0xb0]
stp	q0, q0, [sp]
stp	q0, q0, [sp, #0x20]
stp	q0, q0, [sp, #0x40]
b.eq	L_1ca8
sub	x3, x3, #0x10
cmp	x2, #0xc0
add	sp, sp, #0x80
sub	v3.4s, v3.4s, v7.4s
ld1	{ v8.4s, v9.4s }, [x3]
b.hs	L_454
ldp	d8, d9, [sp]
eor	v1.16b, v1.16b, v1.16b
eor	v2.16b, v2.16b, v2.16b
eor	v3.16b, v3.16b, v3.16b
eor	v4.16b, v4.16b, v4.16b
eor	v5.16b, v5.16b, v5.16b
eor	v6.16b, v6.16b, v6.16b
b	L_50
L_1ca8:
ldp	d8, d9, [sp, #0x80]
ldp	x19, x20, [x29, #0x10]
add	sp, sp, #0xc0
ldp	x21, x22, [x29, #0x20]
ldp	x23, x24, [x29, #0x30]
ldp	x25, x26, [x29, #0x40]
ldp	x27, x28, [x29, #0x50]
ldp	x29, x30, [sp], #0x60
ret
nop
nop
nop
nop
nop
ChaCha20_ctr32_sve:
cntw	x5
cmp	x2, x5, lsl #6
b.lt	L_37fc
mov	x7, #0x0
adrp	x6, OPENSSL_armcap_P
ldr	w6, [x6]
tst	w6, #0x4000
b.eq	L_1d08
mov	x7, #0x1
b	L_1d20
L_1d08:
cmp	x5, #0x4
b.le	L_37fc
adrp	x6, _chacha_sve_consts+16
add	x6, x6, :lo12:_chacha_sve_consts+16
ldp	w9, w10, [x6]
index	z31.s, w9, w10
L_1d20:
stp	d8, d9, [sp, #-0xc0]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
stp	x16, x17, [sp, #0x40]
stp	x18, x19, [sp, #0x50]
stp	x20, x21, [sp, #0x60]
stp	x22, x23, [sp, #0x70]
stp	x24, x25, [sp, #0x80]
stp	x26, x27, [sp, #0x90]
stp	x28, x29, [sp, #0xa0]
str	x30, [sp, #0xb0]
adrp	x6, _chacha_sve_consts
add	x6, x6, :lo12:_chacha_sve_consts
ldp	x23, x24, [x6]
ldp	x25, x26, [x3]
ldp	x27, x28, [x3, #0x10]
ldp	x29, x30, [x4]
ptrues	p0.s
cbz	x7, L_298c
nop
nop
nop
nop
L_1d80:
subs	x7, x2, x5, lsl #6
b.lt	L_2988
mov	x2, x7
b.eq	L_24c8
cmp	x2, #0x40
b.lt	L_24c8
lsr	x8, x23, #32
mov	z0.s, w23
mov	z25.s, w23
mov	w7, w23
mov	z4.s, w8
mov	z26.s, w8
lsr	x10, x24, #32
mov	z8.s, w24
mov	z27.s, w24
mov	w9, w24
mov	z12.s, w10
mov	z28.s, w10
lsr	x12, x25, #32
mov	z1.s, w25
mov	z29.s, w25
mov	w11, w25
mov	z5.s, w12
mov	z30.s, w12
lsr	x14, x26, #32
mov	z9.s, w26
mov	z21.s, w26
mov	w13, w26
mov	z13.s, w14
mov	z22.s, w14
lsr	x16, x27, #32
mov	z2.s, w27
mov	z23.s, w27
mov	w15, w27
mov	z6.s, w16
mov	z24.s, w16
lsr	x18, x28, #32
mov	z10.s, w28
mov	z17.s, w28
mov	w17, w28
mov	z14.s, w18
mov	z18.s, w18
lsr	x22, x30, #32
mov	z11.s, w30
mov	z20.s, w30
mov	w21, w30
mov	z15.s, w22
mov	z31.s, w22
add	w20, w29, #0x1
mov	w19, w29
index	z16.s, w20, #0x1
index	z3.s, w20, #0x1
lsr	x20, x29, #32
mov	z7.s, w20
mov	z19.s, w20
mov	x6, #0xa
L_1e60:
add	z0.s, z0.s, z1.s
add	w7, w7, w11
add	z4.s, z4.s, z5.s
add	w8, w8, w12
add	z8.s, z8.s, z9.s
add	w9, w9, w13
add	z12.s, z12.s, z13.s
add	w10, w10, w14
eor	w19, w19, w7
xar	z3.s, z3.s, z0.s, #0x10
ror	w19, w19, #0x10
eor	w20, w20, w8
xar	z7.s, z7.s, z4.s, #0x10
ror	w20, w20, #0x10
eor	w21, w21, w9
xar	z11.s, z11.s, z8.s, #0x10
ror	w21, w21, #0x10
eor	w22, w22, w10
xar	z15.s, z15.s, z12.s, #0x10
ror	w22, w22, #0x10
add	z2.s, z2.s, z3.s
add	w15, w15, w19
add	z6.s, z6.s, z7.s
add	w16, w16, w20
add	z10.s, z10.s, z11.s
add	w17, w17, w21
add	z14.s, z14.s, z15.s
add	w18, w18, w22
eor	w11, w11, w15
xar	z1.s, z1.s, z2.s, #0x14
ror	w11, w11, #0x14
eor	w12, w12, w16
xar	z5.s, z5.s, z6.s, #0x14
ror	w12, w12, #0x14
eor	w13, w13, w17
xar	z9.s, z9.s, z10.s, #0x14
ror	w13, w13, #0x14
eor	w14, w14, w18
xar	z13.s, z13.s, z14.s, #0x14
ror	w14, w14, #0x14
add	z0.s, z0.s, z1.s
add	w7, w7, w11
add	z4.s, z4.s, z5.s
add	w8, w8, w12
add	z8.s, z8.s, z9.s
add	w9, w9, w13
add	z12.s, z12.s, z13.s
add	w10, w10, w14
eor	w19, w19, w7
xar	z3.s, z3.s, z0.s, #0x18
ror	w19, w19, #0x18
eor	w20, w20, w8
xar	z7.s, z7.s, z4.s, #0x18
ror	w20, w20, #0x18
eor	w21, w21, w9
xar	z11.s, z11.s, z8.s, #0x18
ror	w21, w21, #0x18
eor	w22, w22, w10
xar	z15.s, z15.s, z12.s, #0x18
ror	w22, w22, #0x18
add	z2.s, z2.s, z3.s
add	w15, w15, w19
add	z6.s, z6.s, z7.s
add	w16, w16, w20
add	z10.s, z10.s, z11.s
add	w17, w17, w21
add	z14.s, z14.s, z15.s
add	w18, w18, w22
eor	w11, w11, w15
xar	z1.s, z1.s, z2.s, #0x19
ror	w11, w11, #0x19
eor	w12, w12, w16
xar	z5.s, z5.s, z6.s, #0x19
ror	w12, w12, #0x19
eor	w13, w13, w17
xar	z9.s, z9.s, z10.s, #0x19
ror	w13, w13, #0x19
eor	w14, w14, w18
xar	z13.s, z13.s, z14.s, #0x19
ror	w14, w14, #0x19
add	z0.s, z0.s, z5.s
add	w7, w7, w12
add	z4.s, z4.s, z9.s
add	w8, w8, w13
add	z8.s, z8.s, z13.s
add	w9, w9, w14
add	z12.s, z12.s, z1.s
add	w10, w10, w11
eor	w22, w22, w7
xar	z15.s, z15.s, z0.s, #0x10
ror	w22, w22, #0x10
eor	w19, w19, w8
xar	z3.s, z3.s, z4.s, #0x10
ror	w19, w19, #0x10
eor	w20, w20, w9
xar	z7.s, z7.s, z8.s, #0x10
ror	w20, w20, #0x10
eor	w21, w21, w10
xar	z11.s, z11.s, z12.s, #0x10
ror	w21, w21, #0x10
add	z10.s, z10.s, z15.s
add	w17, w17, w22
add	z14.s, z14.s, z3.s
add	w18, w18, w19
add	z2.s, z2.s, z7.s
add	w15, w15, w20
add	z6.s, z6.s, z11.s
add	w16, w16, w21
eor	w12, w12, w17
xar	z5.s, z5.s, z10.s, #0x14
ror	w12, w12, #0x14
eor	w13, w13, w18
xar	z9.s, z9.s, z14.s, #0x14
ror	w13, w13, #0x14
eor	w14, w14, w15
xar	z13.s, z13.s, z2.s, #0x14
ror	w14, w14, #0x14
eor	w11, w11, w16
xar	z1.s, z1.s, z6.s, #0x14
ror	w11, w11, #0x14
add	z0.s, z0.s, z5.s
add	w7, w7, w12
add	z4.s, z4.s, z9.s
add	w8, w8, w13
add	z8.s, z8.s, z13.s
add	w9, w9, w14
add	z12.s, z12.s, z1.s
add	w10, w10, w11
eor	w22, w22, w7
xar	z15.s, z15.s, z0.s, #0x18
ror	w22, w22, #0x18
eor	w19, w19, w8
xar	z3.s, z3.s, z4.s, #0x18
ror	w19, w19, #0x18
eor	w20, w20, w9
xar	z7.s, z7.s, z8.s, #0x18
ror	w20, w20, #0x18
eor	w21, w21, w10
xar	z11.s, z11.s, z12.s, #0x18
ror	w21, w21, #0x18
add	z10.s, z10.s, z15.s
add	w17, w17, w22
add	z14.s, z14.s, z3.s
add	w18, w18, w19
add	z2.s, z2.s, z7.s
add	w15, w15, w20
add	z6.s, z6.s, z11.s
add	w16, w16, w21
eor	w12, w12, w17
xar	z5.s, z5.s, z10.s, #0x19
ror	w12, w12, #0x19
eor	w13, w13, w18
xar	z9.s, z9.s, z14.s, #0x19
ror	w13, w13, #0x19
eor	w14, w14, w15
xar	z13.s, z13.s, z2.s, #0x19
ror	w14, w14, #0x19
eor	w11, w11, w16
xar	z1.s, z1.s, z6.s, #0x19
ror	w11, w11, #0x19
sub	x6, x6, #0x1
cbnz	x6, L_1e60
add	w7, w7, w23
add	z0.s, z0.s, z25.s
add	x8, x8, x23, lsr #32
add	z4.s, z4.s, z26.s
add	x7, x7, x8, lsl #32
add	w9, w9, w24
add	z8.s, z8.s, z27.s
add	x10, x10, x24, lsr #32
add	z12.s, z12.s, z28.s
add	x9, x9, x10, lsl #32
ldp	x8, x10, [x1], #0x10
add	w11, w11, w25
add	z1.s, z1.s, z29.s
add	x12, x12, x25, lsr #32
add	z5.s, z5.s, z30.s
add	x11, x11, x12, lsl #32
add	w13, w13, w26
add	z9.s, z9.s, z21.s
add	x14, x14, x26, lsr #32
add	z13.s, z13.s, z22.s
add	x13, x13, x14, lsl #32
ldp	x12, x14, [x1], #0x10
add	w15, w15, w27
add	z2.s, z2.s, z23.s
add	x16, x16, x27, lsr #32
add	z6.s, z6.s, z24.s
add	x15, x15, x16, lsl #32
add	w17, w17, w28
add	z10.s, z10.s, z17.s
add	x18, x18, x28, lsr #32
add	z14.s, z14.s, z18.s
add	x17, x17, x18, lsl #32
ldp	x16, x18, [x1], #0x10
add	w19, w19, w29
add	z3.s, z3.s, z16.s
add	x20, x20, x29, lsr #32
add	z7.s, z7.s, z19.s
add	x19, x19, x20, lsl #32
add	w21, w21, w30
add	z11.s, z11.s, z20.s
add	x22, x22, x30, lsr #32
add	z15.s, z15.s, z31.s
add	x21, x21, x22, lsl #32
ldp	x20, x22, [x1], #0x10
add	x29, x29, #0x1
cmp	x5, #0x4
b.ne	L_22b8
eor	x7, x7, x8
eor	x9, x9, x10
eor	x11, x11, x12
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
eor	x13, x13, x14
eor	x15, x15, x16
eor	x17, x17, x18
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
eor	x19, x19, x20
eor	x21, x21, x22
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
eor	z0.d, z0.d, z17.d
eor	z1.d, z1.d, z18.d
eor	z2.d, z2.d, z19.d
eor	z3.d, z3.d, z20.d
eor	z4.d, z4.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z6.d, z6.d, z23.d
eor	z7.d, z7.d, z24.d
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
stp	x7, x9, [x0], #0x10
eor	z8.d, z8.d, z17.d
eor	z9.d, z9.d, z18.d
stp	x11, x13, [x0], #0x10
eor	z10.d, z10.d, z19.d
eor	z11.d, z11.d, z20.d
stp	x15, x17, [x0], #0x10
eor	z12.d, z12.d, z21.d
eor	z13.d, z13.d, z22.d
stp	x19, x21, [x0], #0x10
eor	z14.d, z14.d, z23.d
eor	z15.d, z15.d, z24.d
st1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x0], #64
st1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x0], #64
st1	{ v8.4s, v9.4s, v10.4s, v11.4s }, [x0], #64
st1	{ v12.4s, v13.4s, v14.4s, v15.4s }, [x0], #64
b	L_24b8
L_22b8:
zip1	z17.s, z0.s, z1.s
zip2	z18.s, z0.s, z1.s
zip1	z19.s, z2.s, z3.s
zip2	z20.s, z2.s, z3.s
zip1	z21.s, z4.s, z5.s
zip2	z22.s, z4.s, z5.s
zip1	z23.s, z6.s, z7.s
zip2	z24.s, z6.s, z7.s
zip1	z0.d, z17.d, z19.d
zip2	z1.d, z17.d, z19.d
zip1	z2.d, z18.d, z20.d
zip2	z3.d, z18.d, z20.d
zip1	z4.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z6.d, z22.d, z24.d
zip2	z7.d, z22.d, z24.d
eor	x7, x7, x8
eor	x9, x9, x10
zip1	z17.s, z8.s, z9.s
zip2	z18.s, z8.s, z9.s
zip1	z19.s, z10.s, z11.s
zip2	z20.s, z10.s, z11.s
zip1	z21.s, z12.s, z13.s
zip2	z22.s, z12.s, z13.s
zip1	z23.s, z14.s, z15.s
zip2	z24.s, z14.s, z15.s
zip1	z8.d, z17.d, z19.d
zip2	z9.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z11.d, z18.d, z20.d
zip1	z12.d, z21.d, z23.d
zip2	z13.d, z21.d, z23.d
zip1	z14.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
eor	x11, x11, x12
eor	x13, x13, x14
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
eor	x15, x15, x16
eor	x17, x17, x18
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
eor	x19, x19, x20
eor	x21, x21, x22
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
eor	z0.d, z0.d, z17.d
eor	z4.d, z4.d, z18.d
eor	z8.d, z8.d, z19.d
eor	z12.d, z12.d, z20.d
eor	z1.d, z1.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z9.d, z9.d, z23.d
eor	z13.d, z13.d, z24.d
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
stp	x7, x9, [x0], #0x10
eor	z2.d, z2.d, z17.d
eor	z6.d, z6.d, z18.d
stp	x11, x13, [x0], #0x10
eor	z10.d, z10.d, z19.d
eor	z14.d, z14.d, z20.d
stp	x15, x17, [x0], #0x10
eor	z3.d, z3.d, z21.d
eor	z7.d, z7.d, z22.d
stp	x19, x21, [x0], #0x10
eor	z11.d, z11.d, z23.d
eor	z15.d, z15.d, z24.d
st1w	{ z0.s }, p0, [x0]
st1w	{ z4.s }, p0, [x0, #0x1, mul vl]
st1w	{ z8.s }, p0, [x0, #0x2, mul vl]
st1w	{ z12.s }, p0, [x0, #0x3, mul vl]
st1w	{ z1.s }, p0, [x0, #0x4, mul vl]
st1w	{ z5.s }, p0, [x0, #0x5, mul vl]
st1w	{ z9.s }, p0, [x0, #0x6, mul vl]
st1w	{ z13.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
st1w	{ z2.s }, p0, [x0]
st1w	{ z6.s }, p0, [x0, #0x1, mul vl]
st1w	{ z10.s }, p0, [x0, #0x2, mul vl]
st1w	{ z14.s }, p0, [x0, #0x3, mul vl]
st1w	{ z3.s }, p0, [x0, #0x4, mul vl]
st1w	{ z7.s }, p0, [x0, #0x5, mul vl]
st1w	{ z11.s }, p0, [x0, #0x6, mul vl]
st1w	{ z15.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
L_24b8:
incw	x29
subs	x2, x2, #0x40
b.gt	L_1d80
b	L_2988
L_24c8:
lsr	x8, x23, #32
mov	z0.s, w23
mov	z25.s, w23
mov	z4.s, w8
mov	z26.s, w8
lsr	x10, x24, #32
mov	z8.s, w24
mov	z27.s, w24
mov	z12.s, w10
mov	z28.s, w10
lsr	x12, x25, #32
mov	z1.s, w25
mov	z29.s, w25
mov	z5.s, w12
mov	z30.s, w12
lsr	x14, x26, #32
mov	z9.s, w26
mov	z21.s, w26
mov	z13.s, w14
mov	z22.s, w14
lsr	x16, x27, #32
mov	z2.s, w27
mov	z23.s, w27
mov	z6.s, w16
mov	z24.s, w16
lsr	x18, x28, #32
mov	z10.s, w28
mov	z17.s, w28
mov	z14.s, w18
mov	z18.s, w18
lsr	x22, x30, #32
mov	z11.s, w30
mov	z20.s, w30
mov	z15.s, w22
mov	z31.s, w22
index	z16.s, w29, #0x1
index	z3.s, w29, #0x1
lsr	x20, x29, #32
mov	z7.s, w20
mov	z19.s, w20
mov	x6, #0xa
L_256c:
nop
nop
nop
nop
nop
add	z0.s, z0.s, z1.s
add	z4.s, z4.s, z5.s
add	z8.s, z8.s, z9.s
add	z12.s, z12.s, z13.s
xar	z3.s, z3.s, z0.s, #0x10
xar	z7.s, z7.s, z4.s, #0x10
xar	z11.s, z11.s, z8.s, #0x10
xar	z15.s, z15.s, z12.s, #0x10
add	z2.s, z2.s, z3.s
add	z6.s, z6.s, z7.s
add	z10.s, z10.s, z11.s
add	z14.s, z14.s, z15.s
xar	z1.s, z1.s, z2.s, #0x14
xar	z5.s, z5.s, z6.s, #0x14
xar	z9.s, z9.s, z10.s, #0x14
xar	z13.s, z13.s, z14.s, #0x14
add	z0.s, z0.s, z1.s
add	z4.s, z4.s, z5.s
add	z8.s, z8.s, z9.s
add	z12.s, z12.s, z13.s
xar	z3.s, z3.s, z0.s, #0x18
xar	z7.s, z7.s, z4.s, #0x18
xar	z11.s, z11.s, z8.s, #0x18
xar	z15.s, z15.s, z12.s, #0x18
add	z2.s, z2.s, z3.s
add	z6.s, z6.s, z7.s
add	z10.s, z10.s, z11.s
add	z14.s, z14.s, z15.s
xar	z1.s, z1.s, z2.s, #0x19
xar	z5.s, z5.s, z6.s, #0x19
xar	z9.s, z9.s, z10.s, #0x19
xar	z13.s, z13.s, z14.s, #0x19
add	z0.s, z0.s, z5.s
add	z4.s, z4.s, z9.s
add	z8.s, z8.s, z13.s
add	z12.s, z12.s, z1.s
xar	z15.s, z15.s, z0.s, #0x10
xar	z3.s, z3.s, z4.s, #0x10
xar	z7.s, z7.s, z8.s, #0x10
xar	z11.s, z11.s, z12.s, #0x10
add	z10.s, z10.s, z15.s
add	z14.s, z14.s, z3.s
add	z2.s, z2.s, z7.s
add	z6.s, z6.s, z11.s
xar	z5.s, z5.s, z10.s, #0x14
xar	z9.s, z9.s, z14.s, #0x14
xar	z13.s, z13.s, z2.s, #0x14
xar	z1.s, z1.s, z6.s, #0x14
add	z0.s, z0.s, z5.s
add	z4.s, z4.s, z9.s
add	z8.s, z8.s, z13.s
add	z12.s, z12.s, z1.s
xar	z15.s, z15.s, z0.s, #0x18
xar	z3.s, z3.s, z4.s, #0x18
xar	z7.s, z7.s, z8.s, #0x18
xar	z11.s, z11.s, z12.s, #0x18
add	z10.s, z10.s, z15.s
add	z14.s, z14.s, z3.s
add	z2.s, z2.s, z7.s
add	z6.s, z6.s, z11.s
xar	z5.s, z5.s, z10.s, #0x19
xar	z9.s, z9.s, z14.s, #0x19
xar	z13.s, z13.s, z2.s, #0x19
xar	z1.s, z1.s, z6.s, #0x19
sub	x6, x6, #0x1
cbnz	x6, L_256c
add	z0.s, z0.s, z25.s
add	z4.s, z4.s, z26.s
add	z8.s, z8.s, z27.s
add	z12.s, z12.s, z28.s
add	z1.s, z1.s, z29.s
add	z5.s, z5.s, z30.s
add	z9.s, z9.s, z21.s
add	z13.s, z13.s, z22.s
add	z2.s, z2.s, z23.s
add	z6.s, z6.s, z24.s
add	z10.s, z10.s, z17.s
add	z14.s, z14.s, z18.s
add	z3.s, z3.s, z16.s
add	z7.s, z7.s, z19.s
add	z11.s, z11.s, z20.s
add	z15.s, z15.s, z31.s
cmp	x5, #0x4
b.ne	L_27b4
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
eor	z0.d, z0.d, z17.d
eor	z1.d, z1.d, z18.d
eor	z2.d, z2.d, z19.d
eor	z3.d, z3.d, z20.d
eor	z4.d, z4.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z6.d, z6.d, z23.d
eor	z7.d, z7.d, z24.d
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
eor	z8.d, z8.d, z17.d
eor	z9.d, z9.d, z18.d
eor	z10.d, z10.d, z19.d
eor	z11.d, z11.d, z20.d
eor	z12.d, z12.d, z21.d
eor	z13.d, z13.d, z22.d
eor	z14.d, z14.d, z23.d
eor	z15.d, z15.d, z24.d
st1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x0], #64
st1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x0], #64
st1	{ v8.4s, v9.4s, v10.4s, v11.4s }, [x0], #64
st1	{ v12.4s, v13.4s, v14.4s, v15.4s }, [x0], #64
b	L_2984
L_27b4:
zip1	z17.s, z0.s, z1.s
zip2	z18.s, z0.s, z1.s
zip1	z19.s, z2.s, z3.s
zip2	z20.s, z2.s, z3.s
zip1	z21.s, z4.s, z5.s
zip2	z22.s, z4.s, z5.s
zip1	z23.s, z6.s, z7.s
zip2	z24.s, z6.s, z7.s
zip1	z0.d, z17.d, z19.d
zip2	z1.d, z17.d, z19.d
zip1	z2.d, z18.d, z20.d
zip2	z3.d, z18.d, z20.d
zip1	z4.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z6.d, z22.d, z24.d
zip2	z7.d, z22.d, z24.d
zip1	z17.s, z8.s, z9.s
zip2	z18.s, z8.s, z9.s
zip1	z19.s, z10.s, z11.s
zip2	z20.s, z10.s, z11.s
zip1	z21.s, z12.s, z13.s
zip2	z22.s, z12.s, z13.s
zip1	z23.s, z14.s, z15.s
zip2	z24.s, z14.s, z15.s
zip1	z8.d, z17.d, z19.d
zip2	z9.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z11.d, z18.d, z20.d
zip1	z12.d, z21.d, z23.d
zip2	z13.d, z21.d, z23.d
zip1	z14.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
eor	z0.d, z0.d, z17.d
eor	z4.d, z4.d, z18.d
eor	z8.d, z8.d, z19.d
eor	z12.d, z12.d, z20.d
eor	z1.d, z1.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z9.d, z9.d, z23.d
eor	z13.d, z13.d, z24.d
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
eor	z2.d, z2.d, z17.d
eor	z6.d, z6.d, z18.d
eor	z10.d, z10.d, z19.d
eor	z14.d, z14.d, z20.d
eor	z3.d, z3.d, z21.d
eor	z7.d, z7.d, z22.d
eor	z11.d, z11.d, z23.d
eor	z15.d, z15.d, z24.d
st1w	{ z0.s }, p0, [x0]
st1w	{ z4.s }, p0, [x0, #0x1, mul vl]
st1w	{ z8.s }, p0, [x0, #0x2, mul vl]
st1w	{ z12.s }, p0, [x0, #0x3, mul vl]
st1w	{ z1.s }, p0, [x0, #0x4, mul vl]
st1w	{ z5.s }, p0, [x0, #0x5, mul vl]
st1w	{ z9.s }, p0, [x0, #0x6, mul vl]
st1w	{ z13.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
st1w	{ z2.s }, p0, [x0]
st1w	{ z6.s }, p0, [x0, #0x1, mul vl]
st1w	{ z10.s }, p0, [x0, #0x2, mul vl]
st1w	{ z14.s }, p0, [x0, #0x3, mul vl]
st1w	{ z3.s }, p0, [x0, #0x4, mul vl]
st1w	{ z7.s }, p0, [x0, #0x5, mul vl]
st1w	{ z11.s }, p0, [x0, #0x6, mul vl]
st1w	{ z15.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
L_2984:
incw	x29
L_2988:
b	L_37c8
L_298c:
nop
nop
nop
nop
nop
L_29a0:
subs	x7, x2, x5, lsl #6
b.lt	L_37c8
mov	x2, x7
b.eq	L_3208
cmp	x2, #0x40
b.lt	L_3208
lsr	x8, x23, #32
mov	z0.s, w23
mov	z25.s, w23
mov	w7, w23
mov	z4.s, w8
mov	z26.s, w8
lsr	x10, x24, #32
mov	z8.s, w24
mov	z27.s, w24
mov	w9, w24
mov	z12.s, w10
mov	z28.s, w10
lsr	x12, x25, #32
mov	z1.s, w25
mov	z29.s, w25
mov	w11, w25
mov	z5.s, w12
mov	z30.s, w12
lsr	x14, x26, #32
mov	z9.s, w26
mov	z21.s, w26
mov	w13, w26
mov	z13.s, w14
mov	z22.s, w14
lsr	x16, x27, #32
mov	z2.s, w27
mov	z23.s, w27
mov	w15, w27
mov	z6.s, w16
mov	z24.s, w16
lsr	x18, x28, #32
mov	z10.s, w28
mov	w17, w28
mov	z14.s, w18
lsr	x22, x30, #32
mov	z11.s, w30
mov	w21, w30
mov	z15.s, w22
add	w20, w29, #0x1
mov	w19, w29
index	z16.s, w20, #0x1
index	z3.s, w20, #0x1
lsr	x20, x29, #32
mov	z7.s, w20
mov	x6, #0xa
L_2a6c:
nop
nop
nop
nop
nop
add	z0.s, z0.s, z1.s
add	w7, w7, w11
add	z4.s, z4.s, z5.s
add	w8, w8, w12
add	z8.s, z8.s, z9.s
add	w9, w9, w13
add	z12.s, z12.s, z13.s
add	w10, w10, w14
eor	z3.d, z3.d, z0.d
eor	w19, w19, w7
eor	z7.d, z7.d, z4.d
eor	w20, w20, w8
eor	z11.d, z11.d, z8.d
eor	w21, w21, w9
eor	z15.d, z15.d, z12.d
eor	w22, w22, w10
revh	z3.s, p0/m, z3.s
ror	w19, w19, #0x10
revh	z7.s, p0/m, z7.s
ror	w20, w20, #0x10
revh	z11.s, p0/m, z11.s
ror	w21, w21, #0x10
revh	z15.s, p0/m, z15.s
ror	w22, w22, #0x10
add	z2.s, z2.s, z3.s
add	w15, w15, w19
add	z6.s, z6.s, z7.s
add	w16, w16, w20
add	z10.s, z10.s, z11.s
add	w17, w17, w21
add	z14.s, z14.s, z15.s
add	w18, w18, w22
eor	z1.d, z1.d, z2.d
eor	w11, w11, w15
eor	z5.d, z5.d, z6.d
eor	w12, w12, w16
eor	z9.d, z9.d, z10.d
eor	w13, w13, w17
eor	z13.d, z13.d, z14.d
eor	w14, w14, w18
lsl	z17.s, z1.s, #0xc
lsl	z18.s, z5.s, #0xc
lsl	z19.s, z9.s, #0xc
lsl	z20.s, z13.s, #0xc
lsr	z1.s, z1.s, #0x14
ror	w11, w11, #0x14
lsr	z5.s, z5.s, #0x14
ror	w12, w12, #0x14
lsr	z9.s, z9.s, #0x14
ror	w13, w13, #0x14
lsr	z13.s, z13.s, #0x14
ror	w14, w14, #0x14
orr	z1.d, z1.d, z17.d
orr	z5.d, z5.d, z18.d
orr	z9.d, z9.d, z19.d
orr	z13.d, z13.d, z20.d
add	z0.s, z0.s, z1.s
add	w7, w7, w11
add	z4.s, z4.s, z5.s
add	w8, w8, w12
add	z8.s, z8.s, z9.s
add	w9, w9, w13
add	z12.s, z12.s, z13.s
add	w10, w10, w14
eor	z3.d, z3.d, z0.d
eor	w19, w19, w7
eor	z7.d, z7.d, z4.d
eor	w20, w20, w8
eor	z11.d, z11.d, z8.d
eor	w21, w21, w9
eor	z15.d, z15.d, z12.d
eor	w22, w22, w10
tbl	z3.b, { z3.b }, z31.b
ror	w19, w19, #0x18
tbl	z7.b, { z7.b }, z31.b
ror	w20, w20, #0x18
tbl	z11.b, { z11.b }, z31.b
ror	w21, w21, #0x18
tbl	z15.b, { z15.b }, z31.b
ror	w22, w22, #0x18
add	z2.s, z2.s, z3.s
add	w15, w15, w19
add	z6.s, z6.s, z7.s
add	w16, w16, w20
add	z10.s, z10.s, z11.s
add	w17, w17, w21
add	z14.s, z14.s, z15.s
add	w18, w18, w22
eor	z1.d, z1.d, z2.d
eor	w11, w11, w15
eor	z5.d, z5.d, z6.d
eor	w12, w12, w16
eor	z9.d, z9.d, z10.d
eor	w13, w13, w17
eor	z13.d, z13.d, z14.d
eor	w14, w14, w18
lsl	z17.s, z1.s, #0x7
lsl	z18.s, z5.s, #0x7
lsl	z19.s, z9.s, #0x7
lsl	z20.s, z13.s, #0x7
lsr	z1.s, z1.s, #0x19
ror	w11, w11, #0x19
lsr	z5.s, z5.s, #0x19
ror	w12, w12, #0x19
lsr	z9.s, z9.s, #0x19
ror	w13, w13, #0x19
lsr	z13.s, z13.s, #0x19
ror	w14, w14, #0x19
orr	z1.d, z1.d, z17.d
orr	z5.d, z5.d, z18.d
orr	z9.d, z9.d, z19.d
orr	z13.d, z13.d, z20.d
add	z0.s, z0.s, z5.s
add	w7, w7, w12
add	z4.s, z4.s, z9.s
add	w8, w8, w13
add	z8.s, z8.s, z13.s
add	w9, w9, w14
add	z12.s, z12.s, z1.s
add	w10, w10, w11
eor	z15.d, z15.d, z0.d
eor	w22, w22, w7
eor	z3.d, z3.d, z4.d
eor	w19, w19, w8
eor	z7.d, z7.d, z8.d
eor	w20, w20, w9
eor	z11.d, z11.d, z12.d
eor	w21, w21, w10
revh	z15.s, p0/m, z15.s
ror	w22, w22, #0x10
revh	z3.s, p0/m, z3.s
ror	w19, w19, #0x10
revh	z7.s, p0/m, z7.s
ror	w20, w20, #0x10
revh	z11.s, p0/m, z11.s
ror	w21, w21, #0x10
add	z10.s, z10.s, z15.s
add	w17, w17, w22
add	z14.s, z14.s, z3.s
add	w18, w18, w19
add	z2.s, z2.s, z7.s
add	w15, w15, w20
add	z6.s, z6.s, z11.s
add	w16, w16, w21
eor	z5.d, z5.d, z10.d
eor	w12, w12, w17
eor	z9.d, z9.d, z14.d
eor	w13, w13, w18
eor	z13.d, z13.d, z2.d
eor	w14, w14, w15
eor	z1.d, z1.d, z6.d
eor	w11, w11, w16
lsl	z17.s, z5.s, #0xc
lsl	z18.s, z9.s, #0xc
lsl	z19.s, z13.s, #0xc
lsl	z20.s, z1.s, #0xc
lsr	z5.s, z5.s, #0x14
ror	w12, w12, #0x14
lsr	z9.s, z9.s, #0x14
ror	w13, w13, #0x14
lsr	z13.s, z13.s, #0x14
ror	w14, w14, #0x14
lsr	z1.s, z1.s, #0x14
ror	w11, w11, #0x14
orr	z5.d, z5.d, z17.d
orr	z9.d, z9.d, z18.d
orr	z13.d, z13.d, z19.d
orr	z1.d, z1.d, z20.d
add	z0.s, z0.s, z5.s
add	w7, w7, w12
add	z4.s, z4.s, z9.s
add	w8, w8, w13
add	z8.s, z8.s, z13.s
add	w9, w9, w14
add	z12.s, z12.s, z1.s
add	w10, w10, w11
eor	z15.d, z15.d, z0.d
eor	w22, w22, w7
eor	z3.d, z3.d, z4.d
eor	w19, w19, w8
eor	z7.d, z7.d, z8.d
eor	w20, w20, w9
eor	z11.d, z11.d, z12.d
eor	w21, w21, w10
tbl	z15.b, { z15.b }, z31.b
ror	w22, w22, #0x18
tbl	z3.b, { z3.b }, z31.b
ror	w19, w19, #0x18
tbl	z7.b, { z7.b }, z31.b
ror	w20, w20, #0x18
tbl	z11.b, { z11.b }, z31.b
ror	w21, w21, #0x18
add	z10.s, z10.s, z15.s
add	w17, w17, w22
add	z14.s, z14.s, z3.s
add	w18, w18, w19
add	z2.s, z2.s, z7.s
add	w15, w15, w20
add	z6.s, z6.s, z11.s
add	w16, w16, w21
eor	z5.d, z5.d, z10.d
eor	w12, w12, w17
eor	z9.d, z9.d, z14.d
eor	w13, w13, w18
eor	z13.d, z13.d, z2.d
eor	w14, w14, w15
eor	z1.d, z1.d, z6.d
eor	w11, w11, w16
lsl	z17.s, z5.s, #0x7
lsl	z18.s, z9.s, #0x7
lsl	z19.s, z13.s, #0x7
lsl	z20.s, z1.s, #0x7
lsr	z5.s, z5.s, #0x19
ror	w12, w12, #0x19
lsr	z9.s, z9.s, #0x19
ror	w13, w13, #0x19
lsr	z13.s, z13.s, #0x19
ror	w14, w14, #0x19
lsr	z1.s, z1.s, #0x19
ror	w11, w11, #0x19
orr	z5.d, z5.d, z17.d
orr	z9.d, z9.d, z18.d
orr	z13.d, z13.d, z19.d
orr	z1.d, z1.d, z20.d
sub	x6, x6, #0x1
cbnz	x6, L_2a6c
lsr	x6, x28, #32
mov	z17.s, w28
mov	z18.s, w6
lsr	x6, x29, #32
mov	z19.s, w6
lsr	x6, x30, #32
add	w7, w7, w23
add	z0.s, z0.s, z25.s
add	x8, x8, x23, lsr #32
add	z4.s, z4.s, z26.s
add	x7, x7, x8, lsl #32
add	w9, w9, w24
add	z8.s, z8.s, z27.s
add	x10, x10, x24, lsr #32
add	z12.s, z12.s, z28.s
add	x9, x9, x10, lsl #32
ldp	x8, x10, [x1], #0x10
add	w11, w11, w25
add	z1.s, z1.s, z29.s
add	x12, x12, x25, lsr #32
add	z5.s, z5.s, z30.s
add	x11, x11, x12, lsl #32
add	w13, w13, w26
add	z9.s, z9.s, z21.s
add	x14, x14, x26, lsr #32
add	z13.s, z13.s, z22.s
add	x13, x13, x14, lsl #32
ldp	x12, x14, [x1], #0x10
add	w15, w15, w27
add	z2.s, z2.s, z23.s
add	x16, x16, x27, lsr #32
add	z6.s, z6.s, z24.s
add	x15, x15, x16, lsl #32
add	w17, w17, w28
add	z10.s, z10.s, z17.s
add	x18, x18, x28, lsr #32
add	z14.s, z14.s, z18.s
add	x17, x17, x18, lsl #32
ldp	x16, x18, [x1], #0x10
mov	z20.s, w30
mov	z25.s, w6
add	w19, w19, w29
add	z3.s, z3.s, z16.s
add	x20, x20, x29, lsr #32
add	z7.s, z7.s, z19.s
add	x19, x19, x20, lsl #32
add	w21, w21, w30
add	z11.s, z11.s, z20.s
add	x22, x22, x30, lsr #32
add	z15.s, z15.s, z25.s
add	x21, x21, x22, lsl #32
ldp	x20, x22, [x1], #0x10
add	x29, x29, #0x1
cmp	x5, #0x4
b.ne	L_2ff8
eor	x7, x7, x8
eor	x9, x9, x10
eor	x11, x11, x12
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
eor	x13, x13, x14
eor	x15, x15, x16
eor	x17, x17, x18
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
eor	x19, x19, x20
eor	x21, x21, x22
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
eor	z0.d, z0.d, z17.d
eor	z1.d, z1.d, z18.d
eor	z2.d, z2.d, z19.d
eor	z3.d, z3.d, z20.d
eor	z4.d, z4.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z6.d, z6.d, z23.d
eor	z7.d, z7.d, z24.d
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
stp	x7, x9, [x0], #0x10
eor	z8.d, z8.d, z17.d
eor	z9.d, z9.d, z18.d
stp	x11, x13, [x0], #0x10
eor	z10.d, z10.d, z19.d
eor	z11.d, z11.d, z20.d
stp	x15, x17, [x0], #0x10
eor	z12.d, z12.d, z21.d
eor	z13.d, z13.d, z22.d
stp	x19, x21, [x0], #0x10
eor	z14.d, z14.d, z23.d
eor	z15.d, z15.d, z24.d
st1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x0], #64
st1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x0], #64
st1	{ v8.4s, v9.4s, v10.4s, v11.4s }, [x0], #64
st1	{ v12.4s, v13.4s, v14.4s, v15.4s }, [x0], #64
b	L_31f8
L_2ff8:
zip1	z17.s, z0.s, z1.s
zip2	z18.s, z0.s, z1.s
zip1	z19.s, z2.s, z3.s
zip2	z20.s, z2.s, z3.s
zip1	z21.s, z4.s, z5.s
zip2	z22.s, z4.s, z5.s
zip1	z23.s, z6.s, z7.s
zip2	z24.s, z6.s, z7.s
zip1	z0.d, z17.d, z19.d
zip2	z1.d, z17.d, z19.d
zip1	z2.d, z18.d, z20.d
zip2	z3.d, z18.d, z20.d
zip1	z4.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z6.d, z22.d, z24.d
zip2	z7.d, z22.d, z24.d
eor	x7, x7, x8
eor	x9, x9, x10
zip1	z17.s, z8.s, z9.s
zip2	z18.s, z8.s, z9.s
zip1	z19.s, z10.s, z11.s
zip2	z20.s, z10.s, z11.s
zip1	z21.s, z12.s, z13.s
zip2	z22.s, z12.s, z13.s
zip1	z23.s, z14.s, z15.s
zip2	z24.s, z14.s, z15.s
zip1	z8.d, z17.d, z19.d
zip2	z9.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z11.d, z18.d, z20.d
zip1	z12.d, z21.d, z23.d
zip2	z13.d, z21.d, z23.d
zip1	z14.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
eor	x11, x11, x12
eor	x13, x13, x14
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
eor	x15, x15, x16
eor	x17, x17, x18
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
eor	x19, x19, x20
eor	x21, x21, x22
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
eor	z0.d, z0.d, z17.d
eor	z4.d, z4.d, z18.d
eor	z8.d, z8.d, z19.d
eor	z12.d, z12.d, z20.d
eor	z1.d, z1.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z9.d, z9.d, z23.d
eor	z13.d, z13.d, z24.d
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
stp	x7, x9, [x0], #0x10
eor	z2.d, z2.d, z17.d
eor	z6.d, z6.d, z18.d
stp	x11, x13, [x0], #0x10
eor	z10.d, z10.d, z19.d
eor	z14.d, z14.d, z20.d
stp	x15, x17, [x0], #0x10
eor	z3.d, z3.d, z21.d
eor	z7.d, z7.d, z22.d
stp	x19, x21, [x0], #0x10
eor	z11.d, z11.d, z23.d
eor	z15.d, z15.d, z24.d
st1w	{ z0.s }, p0, [x0]
st1w	{ z4.s }, p0, [x0, #0x1, mul vl]
st1w	{ z8.s }, p0, [x0, #0x2, mul vl]
st1w	{ z12.s }, p0, [x0, #0x3, mul vl]
st1w	{ z1.s }, p0, [x0, #0x4, mul vl]
st1w	{ z5.s }, p0, [x0, #0x5, mul vl]
st1w	{ z9.s }, p0, [x0, #0x6, mul vl]
st1w	{ z13.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
st1w	{ z2.s }, p0, [x0]
st1w	{ z6.s }, p0, [x0, #0x1, mul vl]
st1w	{ z10.s }, p0, [x0, #0x2, mul vl]
st1w	{ z14.s }, p0, [x0, #0x3, mul vl]
st1w	{ z3.s }, p0, [x0, #0x4, mul vl]
st1w	{ z7.s }, p0, [x0, #0x5, mul vl]
st1w	{ z11.s }, p0, [x0, #0x6, mul vl]
st1w	{ z15.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
L_31f8:
incw	x29
subs	x2, x2, #0x40
b.gt	L_29a0
b	L_37c8
L_3208:
lsr	x8, x23, #32
mov	z0.s, w23
mov	z25.s, w23
mov	z4.s, w8
mov	z26.s, w8
lsr	x10, x24, #32
mov	z8.s, w24
mov	z27.s, w24
mov	z12.s, w10
mov	z28.s, w10
lsr	x12, x25, #32
mov	z1.s, w25
mov	z29.s, w25
mov	z5.s, w12
mov	z30.s, w12
lsr	x14, x26, #32
mov	z9.s, w26
mov	z21.s, w26
mov	z13.s, w14
mov	z22.s, w14
lsr	x16, x27, #32
mov	z2.s, w27
mov	z23.s, w27
mov	z6.s, w16
mov	z24.s, w16
lsr	x18, x28, #32
mov	z10.s, w28
mov	z14.s, w18
lsr	x22, x30, #32
mov	z11.s, w30
mov	z15.s, w22
index	z16.s, w29, #0x1
index	z3.s, w29, #0x1
lsr	x20, x29, #32
mov	z7.s, w20
mov	x6, #0xa
L_3298:
nop
nop
add	z0.s, z0.s, z1.s
add	z4.s, z4.s, z5.s
add	z8.s, z8.s, z9.s
add	z12.s, z12.s, z13.s
eor	z3.d, z3.d, z0.d
eor	z7.d, z7.d, z4.d
eor	z11.d, z11.d, z8.d
eor	z15.d, z15.d, z12.d
revh	z3.s, p0/m, z3.s
revh	z7.s, p0/m, z7.s
revh	z11.s, p0/m, z11.s
revh	z15.s, p0/m, z15.s
add	z2.s, z2.s, z3.s
add	z6.s, z6.s, z7.s
add	z10.s, z10.s, z11.s
add	z14.s, z14.s, z15.s
eor	z1.d, z1.d, z2.d
eor	z5.d, z5.d, z6.d
eor	z9.d, z9.d, z10.d
eor	z13.d, z13.d, z14.d
lsl	z17.s, z1.s, #0xc
lsl	z18.s, z5.s, #0xc
lsl	z19.s, z9.s, #0xc
lsl	z20.s, z13.s, #0xc
lsr	z1.s, z1.s, #0x14
lsr	z5.s, z5.s, #0x14
lsr	z9.s, z9.s, #0x14
lsr	z13.s, z13.s, #0x14
orr	z1.d, z1.d, z17.d
orr	z5.d, z5.d, z18.d
orr	z9.d, z9.d, z19.d
orr	z13.d, z13.d, z20.d
add	z0.s, z0.s, z1.s
add	z4.s, z4.s, z5.s
add	z8.s, z8.s, z9.s
add	z12.s, z12.s, z13.s
eor	z3.d, z3.d, z0.d
eor	z7.d, z7.d, z4.d
eor	z11.d, z11.d, z8.d
eor	z15.d, z15.d, z12.d
tbl	z3.b, { z3.b }, z31.b
tbl	z7.b, { z7.b }, z31.b
tbl	z11.b, { z11.b }, z31.b
tbl	z15.b, { z15.b }, z31.b
add	z2.s, z2.s, z3.s
add	z6.s, z6.s, z7.s
add	z10.s, z10.s, z11.s
add	z14.s, z14.s, z15.s
eor	z1.d, z1.d, z2.d
eor	z5.d, z5.d, z6.d
eor	z9.d, z9.d, z10.d
eor	z13.d, z13.d, z14.d
lsl	z17.s, z1.s, #0x7
lsl	z18.s, z5.s, #0x7
lsl	z19.s, z9.s, #0x7
lsl	z20.s, z13.s, #0x7
lsr	z1.s, z1.s, #0x19
lsr	z5.s, z5.s, #0x19
lsr	z9.s, z9.s, #0x19
lsr	z13.s, z13.s, #0x19
orr	z1.d, z1.d, z17.d
orr	z5.d, z5.d, z18.d
orr	z9.d, z9.d, z19.d
orr	z13.d, z13.d, z20.d
add	z0.s, z0.s, z5.s
add	z4.s, z4.s, z9.s
add	z8.s, z8.s, z13.s
add	z12.s, z12.s, z1.s
eor	z15.d, z15.d, z0.d
eor	z3.d, z3.d, z4.d
eor	z7.d, z7.d, z8.d
eor	z11.d, z11.d, z12.d
revh	z15.s, p0/m, z15.s
revh	z3.s, p0/m, z3.s
revh	z7.s, p0/m, z7.s
revh	z11.s, p0/m, z11.s
add	z10.s, z10.s, z15.s
add	z14.s, z14.s, z3.s
add	z2.s, z2.s, z7.s
add	z6.s, z6.s, z11.s
eor	z5.d, z5.d, z10.d
eor	z9.d, z9.d, z14.d
eor	z13.d, z13.d, z2.d
eor	z1.d, z1.d, z6.d
lsl	z17.s, z5.s, #0xc
lsl	z18.s, z9.s, #0xc
lsl	z19.s, z13.s, #0xc
lsl	z20.s, z1.s, #0xc
lsr	z5.s, z5.s, #0x14
lsr	z9.s, z9.s, #0x14
lsr	z13.s, z13.s, #0x14
lsr	z1.s, z1.s, #0x14
orr	z5.d, z5.d, z17.d
orr	z9.d, z9.d, z18.d
orr	z13.d, z13.d, z19.d
orr	z1.d, z1.d, z20.d
add	z0.s, z0.s, z5.s
add	z4.s, z4.s, z9.s
add	z8.s, z8.s, z13.s
add	z12.s, z12.s, z1.s
eor	z15.d, z15.d, z0.d
eor	z3.d, z3.d, z4.d
eor	z7.d, z7.d, z8.d
eor	z11.d, z11.d, z12.d
tbl	z15.b, { z15.b }, z31.b
tbl	z3.b, { z3.b }, z31.b
tbl	z7.b, { z7.b }, z31.b
tbl	z11.b, { z11.b }, z31.b
add	z10.s, z10.s, z15.s
add	z14.s, z14.s, z3.s
add	z2.s, z2.s, z7.s
add	z6.s, z6.s, z11.s
eor	z5.d, z5.d, z10.d
eor	z9.d, z9.d, z14.d
eor	z13.d, z13.d, z2.d
eor	z1.d, z1.d, z6.d
lsl	z17.s, z5.s, #0x7
lsl	z18.s, z9.s, #0x7
lsl	z19.s, z13.s, #0x7
lsl	z20.s, z1.s, #0x7
lsr	z5.s, z5.s, #0x19
lsr	z9.s, z9.s, #0x19
lsr	z13.s, z13.s, #0x19
lsr	z1.s, z1.s, #0x19
orr	z5.d, z5.d, z17.d
orr	z9.d, z9.d, z18.d
orr	z13.d, z13.d, z19.d
orr	z1.d, z1.d, z20.d
sub	x6, x6, #0x1
cbnz	x6, L_3298
lsr	x6, x28, #32
mov	z17.s, w28
mov	z18.s, w6
lsr	x6, x29, #32
mov	z19.s, w6
lsr	x6, x30, #32
add	z0.s, z0.s, z25.s
add	z4.s, z4.s, z26.s
add	z8.s, z8.s, z27.s
add	z12.s, z12.s, z28.s
add	z1.s, z1.s, z29.s
add	z5.s, z5.s, z30.s
add	z9.s, z9.s, z21.s
add	z13.s, z13.s, z22.s
add	z2.s, z2.s, z23.s
add	z6.s, z6.s, z24.s
add	z10.s, z10.s, z17.s
add	z14.s, z14.s, z18.s
mov	z20.s, w30
mov	z25.s, w6
add	z3.s, z3.s, z16.s
add	z7.s, z7.s, z19.s
add	z11.s, z11.s, z20.s
add	z15.s, z15.s, z25.s
cmp	x5, #0x4
b.ne	L_35f4
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
eor	z0.d, z0.d, z17.d
eor	z1.d, z1.d, z18.d
eor	z2.d, z2.d, z19.d
eor	z3.d, z3.d, z20.d
eor	z4.d, z4.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z6.d, z6.d, z23.d
eor	z7.d, z7.d, z24.d
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
eor	z8.d, z8.d, z17.d
eor	z9.d, z9.d, z18.d
eor	z10.d, z10.d, z19.d
eor	z11.d, z11.d, z20.d
eor	z12.d, z12.d, z21.d
eor	z13.d, z13.d, z22.d
eor	z14.d, z14.d, z23.d
eor	z15.d, z15.d, z24.d
st1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x0], #64
st1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x0], #64
st1	{ v8.4s, v9.4s, v10.4s, v11.4s }, [x0], #64
st1	{ v12.4s, v13.4s, v14.4s, v15.4s }, [x0], #64
b	L_37c4
L_35f4:
zip1	z17.s, z0.s, z1.s
zip2	z18.s, z0.s, z1.s
zip1	z19.s, z2.s, z3.s
zip2	z20.s, z2.s, z3.s
zip1	z21.s, z4.s, z5.s
zip2	z22.s, z4.s, z5.s
zip1	z23.s, z6.s, z7.s
zip2	z24.s, z6.s, z7.s
zip1	z0.d, z17.d, z19.d
zip2	z1.d, z17.d, z19.d
zip1	z2.d, z18.d, z20.d
zip2	z3.d, z18.d, z20.d
zip1	z4.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z6.d, z22.d, z24.d
zip2	z7.d, z22.d, z24.d
zip1	z17.s, z8.s, z9.s
zip2	z18.s, z8.s, z9.s
zip1	z19.s, z10.s, z11.s
zip2	z20.s, z10.s, z11.s
zip1	z21.s, z12.s, z13.s
zip2	z22.s, z12.s, z13.s
zip1	z23.s, z14.s, z15.s
zip2	z24.s, z14.s, z15.s
zip1	z8.d, z17.d, z19.d
zip2	z9.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z11.d, z18.d, z20.d
zip1	z12.d, z21.d, z23.d
zip2	z13.d, z21.d, z23.d
zip1	z14.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
eor	z0.d, z0.d, z17.d
eor	z4.d, z4.d, z18.d
eor	z8.d, z8.d, z19.d
eor	z12.d, z12.d, z20.d
eor	z1.d, z1.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z9.d, z9.d, z23.d
eor	z13.d, z13.d, z24.d
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
eor	z2.d, z2.d, z17.d
eor	z6.d, z6.d, z18.d
eor	z10.d, z10.d, z19.d
eor	z14.d, z14.d, z20.d
eor	z3.d, z3.d, z21.d
eor	z7.d, z7.d, z22.d
eor	z11.d, z11.d, z23.d
eor	z15.d, z15.d, z24.d
st1w	{ z0.s }, p0, [x0]
st1w	{ z4.s }, p0, [x0, #0x1, mul vl]
st1w	{ z8.s }, p0, [x0, #0x2, mul vl]
st1w	{ z12.s }, p0, [x0, #0x3, mul vl]
st1w	{ z1.s }, p0, [x0, #0x4, mul vl]
st1w	{ z5.s }, p0, [x0, #0x5, mul vl]
st1w	{ z9.s }, p0, [x0, #0x6, mul vl]
st1w	{ z13.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
st1w	{ z2.s }, p0, [x0]
st1w	{ z6.s }, p0, [x0, #0x1, mul vl]
st1w	{ z10.s }, p0, [x0, #0x2, mul vl]
st1w	{ z14.s }, p0, [x0, #0x3, mul vl]
st1w	{ z3.s }, p0, [x0, #0x4, mul vl]
st1w	{ z7.s }, p0, [x0, #0x5, mul vl]
st1w	{ z11.s }, p0, [x0, #0x6, mul vl]
st1w	{ z15.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
L_37c4:
incw	x29
L_37c8:
str	w29, [x4]
ldp	d10, d11, [sp, #0x10]
ldp	d12, d13, [sp, #0x20]
ldp	d14, d15, [sp, #0x30]
ldp	x16, x17, [sp, #0x40]
ldp	x18, x19, [sp, #0x50]
ldp	x20, x21, [sp, #0x60]
ldp	x22, x23, [sp, #0x70]
ldp	x24, x25, [sp, #0x80]
ldp	x26, x27, [sp, #0x90]
ldp	x28, x29, [sp, #0xa0]
ldr	x30, [sp, #0xb0]
ldp	d8, d9, [sp], #0xc0
L_37fc:
ret
	.section .rodata
	.p2align 5
	.byte 101,120,112,97,110,100,32,51,50,45,98,121,116,101,32,107
	.byte 1,0,0,0,2,0,0,0,3,0,0,0,4,0,0,0
	.byte 3,0,1,2,7,4,5,6,11,8,9,10,15,12,13,14
	.byte 67,104,97,67,104,97,50,48,32,102,111,114,32,65,82,77
	.byte 118,56,44,32,67,82,89,80,84,79,71,65,77,83,32,98
	.byte 121,32,64,100,111,116,45,97,115,109,0,0,0,0,0,0
_chacha_sve_consts:
	.size _chacha_sve_consts, 32
	.byte 101,120,112,97,110,100,32,51,50,45,98,121,116,101,32,107
	.byte 3,0,1,2,4,4,4,4,3,0,1,2,4,4,4,4
