	.text
msac_decode_symbol_adapt4_neon:
add	x8, x0, #0x18
ld1	{ v0.4h }, [x1]
ld1r	{ v29.4h }, [x8]
adrp	x9, coeffs+30
add	x9, x9, :lo12:coeffs+30
movi	v31.4h, #0x7f, lsl #8
sub	x10, x9, x2, lsl #1
mvni	v30.4h, #0x3f
and	v7.8b, v29.8b, v31.8b
and	v2.8b, v0.8b, v30.8b
ld1	{ v4.4h }, [x10]
sqdmulh	v6.4h, v2.4h, v7.4h
ldr	d28, [x0, #0x10]
add	v4.4h, v2.4h, v4.4h
add	v4.4h, v6.4h, v4.4h
dup	v30.4h, v28.h[3]
cmhs	v2.4h, v30.4h, v4.4h
ext	v29.8b, v29.8b, v4.8b, #0x6
mov	x15, v2.d[0]
ldr	w4, [x0, #0x20]
rev	x15, x15
sub	v29.4h, v29.4h, v4.4h
clz	x15, x15
cbz	w4, L_a0
ldrh	w3, [x1, x2, lsl #1]
mvn	w14, w2
mov	w4, #-0x4
cmn	w14, #0x3
sub	v16.4h, v0.4h, v2.4h
orr	v2.4h, #0x80, lsl #8
lsr	w14, w3, #4
sbc	w4, w4, w14
sub	v2.4h, v2.4h, v0.4h
dup	v6.4h, w4
sub	w3, w3, w3, lsr #5
sshl	v2.4h, v2.4h, v6.4h
add	w3, w3, #0x1
add	v0.4h, v16.4h, v2.4h
st1	{ v0.4h }, [x1]
strh	w3, [x1, x2, lsl #1]
L_a0:
ldr	w6, [x0, #0x1c]
ldr	x7, [x0, #0x10]
mov	x4, v29.d[0]
mov	x3, v4.d[0]
lsr	x4, x4, x15
lsr	x3, x3, x15
lsl	w5, w4, #16
sub	x7, x7, x3, lsl #48
clz	w5, w5
lsl	w4, w4, w5
subs	w6, w6, w5
lsl	x7, x7, x5
strh	w4, [x0, #0x18]
b.lo	L_e8
str	w6, [x0, #0x1c]
str	x7, [x0, #0x10]
lsr	w0, w15, #4
ret
L_e8:
lsr	w15, w15, #4
b	L_f0
L_f0:
ldp	x3, x4, [x0]
add	x5, x3, #0x8
subs	x5, x5, x4
b.hi	L_148
ldr	x8, [x3]
sub	w4, w6, #0x30
mvn	x8, x8
neg	w5, w4
rev	x8, x8
lsr	w5, w5, #3
lsr	x8, x8, x4
L_11c:
add	x3, x3, x5
add	w6, w6, w5, lsl #3
str	x3, [x0]
L_128:
orr	x7, x7, x8
str	w6, [x0, #0x1c]
str	x7, [x0, #0x10]
mov	w0, w15
ret
L_13c:
sub	w8, w6, #0x10
ror	x8, x8, x8
b	L_128
L_148:
cmp	x3, x4
b.hs	L_13c
ldur	x8, [x4, #-0x8]
lsl	w5, w5, #3
lsr	x8, x8, x5
sub	w5, w6, #0x30
mvn	x8, x8
sub	w4, w4, w3
rev	x8, x8
lsr	x8, x8, x5
neg	w5, w5
lsr	w5, w5, #3
cmp	w5, w4
csel	w5, w5, w4, lo
b	L_11c
msac_decode_symbol_adapt8_neon:
add	x8, x0, #0x18
ld1	{ v0.8h }, [x1]
ld1r	{ v29.8h }, [x8]
adrp	x9, coeffs+30
add	x9, x9, :lo12:coeffs+30
movi	v31.8h, #0x7f, lsl #8
sub	x10, x9, x2, lsl #1
mvni	v30.8h, #0x3f
and	v7.16b, v29.16b, v31.16b
and	v2.16b, v0.16b, v30.16b
ld1	{ v4.8h }, [x10]
sqdmulh	v6.8h, v2.8h, v7.8h
ldr	d28, [x0, #0x10]
add	v4.8h, v2.8h, v4.8h
add	v4.8h, v6.8h, v4.8h
dup	v30.8h, v28.h[3]
ldur	q31, [x9, #0x22]
cmhs	v2.8h, v30.8h, v4.8h
and	v31.16b, v31.16b, v2.16b
ext	v29.16b, v29.16b, v4.16b, #0xe
addv	h31, v31.8h
ldr	w4, [x0, #0x20]
sub	v30.8h, v30.8h, v4.8h
smov	w15, v31.b[0]
sub	v29.8h, v29.8h, v4.8h
cbz	w4, L_22c
ldrh	w3, [x1, x2, lsl #1]
mvn	w14, w2
mov	w4, #-0x4
cmn	w14, #0x3
sub	v16.8h, v0.8h, v2.8h
orr	v2.8h, #0x80, lsl #8
lsr	w14, w3, #4
sbc	w4, w4, w14
sub	v2.8h, v2.8h, v0.8h
dup	v6.8h, w4
sub	w3, w3, w3, lsr #5
sshl	v2.8h, v2.8h, v6.8h
add	w3, w3, #0x1
add	v0.8h, v16.8h, v2.8h
st1	{ v0.8h }, [x1]
strh	w3, [x1, x2, lsl #1]
L_22c:
ldr	w6, [x0, #0x1c]
tbl	v30.8b, { v30.16b }, v31.8b
tbl	v29.8b, { v29.16b }, v31.8b
mov	v28.h[3], v30.h[0]
clz	v0.4h, v29.4h
umov	w5, v0.h[0]
ushl	v29.4h, v29.4h, v0.4h
ushl	d28, d28, d0
subs	w6, w6, w5
str	h29, [x0, #0x18]
b.lo	L_268
str	w6, [x0, #0x1c]
str	d28, [x0, #0x10]
lsr	w0, w15, #1
ret
L_268:
lsr	w15, w15, #1
mov	x7, v28.d[0]
b	L_f0
msac_decode_symbol_adapt16_neon:
sub	sp, sp, #0x30
add	x8, x0, #0x18
ld1	{ v0.8h, v1.8h }, [x1]
ld1r	{ v29.8h }, [x8]
adrp	x9, coeffs+30
add	x9, x9, :lo12:coeffs+30
movi	v31.8h, #0x7f, lsl #8
sub	x10, x9, x2, lsl #1
mvni	v30.8h, #0x3f
and	v7.16b, v29.16b, v31.16b
str	h29, [sp, #0xe]
and	v2.16b, v0.16b, v30.16b
and	v3.16b, v1.16b, v30.16b
ld1	{ v4.8h, v5.8h }, [x10]
sqdmulh	v6.8h, v2.8h, v7.8h
sqdmulh	v7.8h, v3.8h, v7.8h
ldr	d28, [x0, #0x10]
add	v4.8h, v2.8h, v4.8h
add	v5.8h, v3.8h, v5.8h
add	v4.8h, v6.8h, v4.8h
add	v5.8h, v7.8h, v5.8h
dup	v30.8h, v28.h[3]
str	q4, [sp, #0x10]
str	q5, [sp, #0x20]
cmhs	v2.8h, v30.8h, v4.8h
cmhs	v3.8h, v30.8h, v5.8h
add	v6.8h, v2.8h, v3.8h
addv	h31, v6.8h
ldr	w4, [x0, #0x20]
smov	w15, v31.h[0]
cbz	w4, L_338
ldrh	w3, [x1, x2, lsl #1]
mov	w4, #-0x5
sub	v16.8h, v0.8h, v2.8h
sub	v17.8h, v1.8h, v3.8h
orr	v2.8h, #0x80, lsl #8
orr	v3.8h, #0x80, lsl #8
sub	w4, w4, w3, lsr #4
sub	v2.8h, v2.8h, v0.8h
sub	v3.8h, v3.8h, v1.8h
dup	v6.8h, w4
sub	w3, w3, w3, lsr #5
sshl	v2.8h, v2.8h, v6.8h
sshl	v3.8h, v3.8h, v6.8h
add	w3, w3, #0x1
add	v0.8h, v16.8h, v2.8h
add	v1.8h, v17.8h, v3.8h
st1	{ v0.8h, v1.8h }, [x1]
strh	w3, [x1, x2, lsl #1]
L_338:
add	x8, sp, w15, sxtw #1
ldrh	w3, [x8, #0x30]
ldurh	w4, [x8, #0x2e]
ldr	w6, [x0, #0x1c]
ldr	x7, [x0, #0x10]
sub	w4, w4, w3
clz	w5, w4
eor	w5, w5, #0x10
sub	x7, x7, x3, lsl #48
lsl	w4, w4, w5
subs	w6, w6, w5
lsl	x7, x7, x5
str	w4, [x0, #0x18]
add	sp, sp, #0x30
b.lo	L_384
str	w6, [x0, #0x1c]
str	x7, [x0, #0x10]
add	w0, w15, #0x10
ret
L_384:
add	w15, w15, #0x10
b	L_f0
msac_decode_hi_tok_neon:
ld1	{ v0.4h }, [x1]
add	x16, x0, #0x18
movi	v31.4h, #0x7f, lsl #8
adrp	x17, coeffs+24
add	x17, x17, :lo12:coeffs+24
mvni	v30.4h, #0x3f
ldrh	w9, [x1, #0x6]
ld1r	{ v3.4h }, [x16]
ld1	{ v29.4h }, [x17]
add	x17, x0, #0x16
mov	w13, #-0xc0
and	v17.8b, v0.8b, v30.8b
ldr	w10, [x0, #0x20]
ld1r	{ v1.8h }, [x17]
ldr	w6, [x0, #0x1c]
ldr	x7, [x0, #0x10]
L_3cc:
and	v7.8b, v3.8b, v31.8b
sqdmulh	v6.4h, v17.4h, v7.4h
add	v4.4h, v17.4h, v29.4h
add	v4.4h, v6.4h, v4.4h
cmhs	v2.4h, v1.4h, v4.4h
add	w13, w13, #0x28
ext	v18.8b, v3.8b, v4.8b, #0x6
mov	x15, v2.d[0]
rev	x15, x15
sub	v18.4h, v18.4h, v4.4h
clz	x15, x15
cbz	w10, L_430
sub	v5.4h, v0.4h, v2.4h
mov	w4, #-0x5
orr	v2.4h, #0x80, lsl #8
sub	w4, w4, w9, lsr #4
sub	v2.4h, v2.4h, v0.4h
dup	v6.4h, w4
sub	w9, w9, w9, lsr #5
sshl	v2.4h, v2.4h, v6.4h
add	w9, w9, #0x1
add	v0.4h, v5.4h, v2.4h
st1	{ v0.4h }, [x1]
and	v17.8b, v0.8b, v30.8b
strh	w9, [x1, #0x6]
L_430:
mov	x4, v18.d[0]
mov	x3, v4.d[0]
lsr	x4, x4, x15
lsr	x3, x3, x15
lsl	w5, w4, #16
sub	x7, x7, x3, lsl #48
clz	w5, w5
lsl	w4, w4, w5
subs	w6, w6, w5
lsl	x7, x7, x5
strh	w4, [x0, #0x18]
dup	v3.4h, w4
b.hs	L_4a0
ldp	x3, x4, [x0]
add	x5, x3, #0x8
subs	x5, x5, x4
b.hi	L_4d4
ldr	x8, [x3]
sub	w4, w6, #0x30
mvn	x8, x8
neg	w5, w4
rev	x8, x8
lsr	w5, w5, #3
lsr	x8, x8, x4
L_490:
add	x3, x3, x5
add	w6, w6, w5, lsl #3
str	x3, [x0]
L_49c:
orr	x7, x7, x8
L_4a0:
sub	w15, w15, #0x28
lsr	x12, x7, #48
adds	w13, w13, w15
dup	v1.8h, w12
b.lo	L_3cc
add	w13, w13, #0xf0
str	w6, [x0, #0x1c]
str	x7, [x0, #0x10]
lsr	w0, w13, #4
ret
L_4c8:
sub	w8, w6, #0x10
ror	x8, x8, x8
b	L_49c
L_4d4:
cmp	x3, x4
b.hs	L_4c8
ldur	x8, [x4, #-0x8]
lsl	w5, w5, #3
lsr	x8, x8, x5
sub	w5, w6, #0x30
mvn	x8, x8
sub	w4, w4, w3
rev	x8, x8
lsr	x8, x8, x5
neg	w5, w5
lsr	w5, w5, #3
cmp	w5, w4
csel	w5, w5, w4, lo
b	L_490
msac_decode_bool_equi_neon:
ldp	w5, w6, [x0, #0x18]
ldr	x7, [x0, #0x10]
and	w4, w5, #0xffffff00
add	w4, w4, #0x8
subs	x8, x7, x4, lsl #47
lsr	w4, w4, #1
sub	w5, w5, w4
cset	w15, lo
csel	w4, w5, w4, hs
csel	x7, x8, x7, hs
clz	w5, w4
eor	w5, w5, #0x10
lsl	w4, w4, w5
subs	w6, w6, w5
lsl	x7, x7, x5
str	w4, [x0, #0x18]
b.lo	L_f0
str	w6, [x0, #0x1c]
str	x7, [x0, #0x10]
mov	w0, w15
ret
msac_decode_bool_neon:
ldp	w5, w6, [x0, #0x18]
ldr	x7, [x0, #0x10]
lsr	w4, w5, #8
and	w1, w1, #0xffffffc0
mul	w4, w4, w1
lsr	w4, w4, #7
add	w4, w4, #0x4
subs	x8, x7, x4, lsl #48
sub	w5, w5, w4
cset	w15, lo
csel	w4, w5, w4, hs
csel	x7, x8, x7, hs
clz	w5, w4
eor	w5, w5, #0x10
lsl	w4, w4, w5
subs	w6, w6, w5
lsl	x7, x7, x5
str	w4, [x0, #0x18]
b.lo	L_f0
str	w6, [x0, #0x1c]
str	x7, [x0, #0x10]
mov	w0, w15
ret
msac_decode_bool_adapt_neon:
ldr	w9, [x1]
ldp	w5, w6, [x0, #0x18]
ldr	x7, [x0, #0x10]
lsr	w4, w5, #8
and	w2, w9, #0xffc0
mul	w4, w4, w2
lsr	w4, w4, #7
add	w4, w4, #0x4
subs	x8, x7, x4, lsl #48
sub	w5, w5, w4
cset	w15, lo
csel	w4, w5, w4, hs
csel	x7, x8, x7, hs
ldr	w10, [x0, #0x20]
clz	w5, w4
eor	w5, w5, #0x10
cbz	w10, L_634
lsr	w2, w9, #16
and	w9, w9, #0xffff
sub	w3, w2, w2, lsr #5
lsr	w2, w2, #4
add	w10, w3, #0x1
add	w2, w2, #0x4
sub	w9, w9, w15
sub	w11, w9, w15, lsl #15
asr	w11, w11, w2
sub	w9, w9, w11
strh	w9, [x1]
strh	w10, [x1, #0x2]
L_634:
lsl	w4, w4, w5
subs	w6, w6, w5
lsl	x7, x7, x5
str	w4, [x0, #0x18]
b.lo	L_f0
str	w6, [x0, #0x1c]
str	x7, [x0, #0x10]
mov	w0, w15
ret
	.section .rodata
coeffs:
	.size coeffs, 80
	.byte 60,0,56,0,52,0,48,0,44,0,40,0,36,0,32,0
	.byte 28,0,24,0,20,0,16,0,12,0,8,0,4,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 254,253,254,253,254,253,254,253,254,253,254,253,254,253,14,15
