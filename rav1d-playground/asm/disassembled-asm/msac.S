_msac_decode_symbol_adapt4_neon:
add	x8, x0, #24
ld1.4h	{ v0 }, [x1]
ld1r.4h	{ v29 }, [x8]
adrp	x9, msac_decode_symbol_adapt4_neon
add	x9, x9, #0
movi.4h	v31, #127, lsl #8
sub	x10, x9, x2, lsl #1
mvni.4h	v30, #63
and.8b	v7, v29, v31
and.8b	v2, v0, v30
ld1.4h	{ v4 }, [x10]
sqdmulh.4h	v6, v2, v7
ldr	d28, [x0, #16]
add.4h	v4, v2, v4
add.4h	v4, v6, v4
dup.4h	v30, v28[3]
cmhs.4h	v2, v30, v4
ext.8b	v29, v29, v4, #6
mov.d	x15, v2[0]
ldr	w4, [x0, #32]
rev	x15, x15
sub.4h	v29, v29, v4
clz	x15, x15
cbz	w4, msac_decode_symbol_adapt4_neon
ldrh	w3, [x1, x2, lsl #1]
mvn	w14, w2
mov	w4, #-4
cmn	w14, #3
sub.4h	v16, v0, v2
orr.4h	v2, #128, lsl #8
lsr	w14, w3, #4
sbc	w4, w4, w14
sub.4h	v2, v2, v0
dup.4h	v6, w4
sub	w3, w3, w3, lsr #5
sshl.4h	v2, v2, v6
add	w3, w3, #1
add.4h	v0, v16, v2
st1.4h	{ v0 }, [x1]
strh	w3, [x1, x2, lsl #1]
ldr	w6, [x0, #28]
ldr	x7, [x0, #16]
mov.d	x4, v29[0]
mov.d	x3, v4[0]
lsr	x4, x4, x15
lsr	x3, x3, x15
lsl	w5, w4, #16
sub	x7, x7, x3, lsl #48
clz	w5, w5
lsl	w4, w4, w5
subs	w6, w6, w5
lsl	x7, x7, x5
strh	w4, [x0, #24]
b.lo	msac_decode_symbol_adapt4_neon
str	w6, [x0, #28]
str	x7, [x0, #16]
lsr	w0, w15, #4
ret
lsr	w15, w15, #4
b	msac_decode_symbol_adapt4_neon
ldp	x3, x4, [x0]
add	x5, x3, #8
subs	x5, x5, x4
b.hi	msac_decode_symbol_adapt4_neon
ldr	x8, [x3]
sub	w4, w6, #48
mvn	x8, x8
neg	w5, w4
rev	x8, x8
lsr	w5, w5, #3
lsr	x8, x8, x4
add	x3, x3, x5
add	w6, w6, w5, lsl #3
str	x3, [x0]
orr	x7, x7, x8
str	w6, [x0, #28]
str	x7, [x0, #16]
mov	w0, w15
ret
sub	w8, w6, #16
ror	x8, x8, x8
b	msac_decode_symbol_adapt4_neon
cmp	x3, x4
b.hs	msac_decode_symbol_adapt4_neon
ldur	x8, [x4, #-8]
lsl	w5, w5, #3
lsr	x8, x8, x5
sub	w5, w6, #48
mvn	x8, x8
sub	w4, w4, w3
rev	x8, x8
lsr	x8, x8, x5
neg	w5, w5
lsr	w5, w5, #3
cmp	w5, w4
csel	w5, w5, w4, lo
b	msac_decode_symbol_adapt4_neon
_msac_decode_symbol_adapt8_neon:
add	x8, x0, #24
ld1.8h	{ v0 }, [x1]
ld1r.8h	{ v29 }, [x8]
adrp	x9, msac_decode_symbol_adapt8_neon
add	x9, x9, #0
movi.8h	v31, #127, lsl #8
sub	x10, x9, x2, lsl #1
mvni.8h	v30, #63
and.16b	v7, v29, v31
and.16b	v2, v0, v30
ld1.8h	{ v4 }, [x10]
sqdmulh.8h	v6, v2, v7
ldr	d28, [x0, #16]
add.8h	v4, v2, v4
add.8h	v4, v6, v4
dup.8h	v30, v28[3]
ldur	q31, [x9, #34]
cmhs.8h	v2, v30, v4
and.16b	v31, v31, v2
ext.16b	v29, v29, v4, #14
addv.8h	h31, v31
ldr	w4, [x0, #32]
sub.8h	v30, v30, v4
smov.b	w15, v31[0]
sub.8h	v29, v29, v4
cbz	w4, msac_decode_symbol_adapt8_neon
ldrh	w3, [x1, x2, lsl #1]
mvn	w14, w2
mov	w4, #-4
cmn	w14, #3
sub.8h	v16, v0, v2
orr.8h	v2, #128, lsl #8
lsr	w14, w3, #4
sbc	w4, w4, w14
sub.8h	v2, v2, v0
dup.8h	v6, w4
sub	w3, w3, w3, lsr #5
sshl.8h	v2, v2, v6
add	w3, w3, #1
add.8h	v0, v16, v2
st1.8h	{ v0 }, [x1]
strh	w3, [x1, x2, lsl #1]
ldr	w6, [x0, #28]
tbl.8b	v30, { v30 }, v31
tbl.8b	v29, { v29 }, v31
mov.h	v28[3], v30[0]
clz.4h	v0, v29
umov.h	w5, v0[0]
ushl.4h	v29, v29, v0
ushl	d28, d28, d0
subs	w6, w6, w5
str	h29, [x0, #24]
b.lo	msac_decode_symbol_adapt8_neon
str	w6, [x0, #28]
str	d28, [x0, #16]
lsr	w0, w15, #1
ret
lsr	w15, w15, #1
mov.d	x7, v28[0]
b	msac_decode_symbol_adapt4_neon
_msac_decode_symbol_adapt16_neon:
sub	sp, sp, #48
add	x8, x0, #24
ld1.8h	{ v0, v1 }, [x1]
ld1r.8h	{ v29 }, [x8]
adrp	x9, msac_decode_symbol_adapt16_neon
add	x9, x9, #0
movi.8h	v31, #127, lsl #8
sub	x10, x9, x2, lsl #1
mvni.8h	v30, #63
and.16b	v7, v29, v31
str	h29, [sp, #14]
and.16b	v2, v0, v30
and.16b	v3, v1, v30
ld1.8h	{ v4, v5 }, [x10]
sqdmulh.8h	v6, v2, v7
sqdmulh.8h	v7, v3, v7
ldr	d28, [x0, #16]
add.8h	v4, v2, v4
add.8h	v5, v3, v5
add.8h	v4, v6, v4
add.8h	v5, v7, v5
dup.8h	v30, v28[3]
str	q4, [sp, #16]
str	q5, [sp, #32]
cmhs.8h	v2, v30, v4
cmhs.8h	v3, v30, v5
add.8h	v6, v2, v3
addv.8h	h31, v6
ldr	w4, [x0, #32]
smov.h	w15, v31[0]
cbz	w4, msac_decode_symbol_adapt16_neon
ldrh	w3, [x1, x2, lsl #1]
mov	w4, #-5
sub.8h	v16, v0, v2
sub.8h	v17, v1, v3
orr.8h	v2, #128, lsl #8
orr.8h	v3, #128, lsl #8
sub	w4, w4, w3, lsr #4
sub.8h	v2, v2, v0
sub.8h	v3, v3, v1
dup.8h	v6, w4
sub	w3, w3, w3, lsr #5
sshl.8h	v2, v2, v6
sshl.8h	v3, v3, v6
add	w3, w3, #1
add.8h	v0, v16, v2
add.8h	v1, v17, v3
st1.8h	{ v0, v1 }, [x1]
strh	w3, [x1, x2, lsl #1]
add	x8, sp, w15, sxtw #1
ldrh	w3, [x8, #48]
ldurh	w4, [x8, #46]
ldr	w6, [x0, #28]
ldr	x7, [x0, #16]
sub	w4, w4, w3
clz	w5, w4
eor	w5, w5, #0x10
sub	x7, x7, x3, lsl #48
lsl	w4, w4, w5
subs	w6, w6, w5
lsl	x7, x7, x5
str	w4, [x0, #24]
add	sp, sp, #48
b.lo	msac_decode_symbol_adapt16_neon
str	w6, [x0, #28]
str	x7, [x0, #16]
add	w0, w15, #16
ret
add	w15, w15, #16
b	msac_decode_symbol_adapt4_neon
_msac_decode_hi_tok_neon:
ld1.4h	{ v0 }, [x1]
add	x16, x0, #24
movi.4h	v31, #127, lsl #8
adrp	x17, msac_decode_hi_tok_neon
add	x17, x17, #0
mvni.4h	v30, #63
ldrh	w9, [x1, #6]
ld1r.4h	{ v3 }, [x16]
ld1.4h	{ v29 }, [x17]
add	x17, x0, #22
mov	w13, #-192
and.8b	v17, v0, v30
ldr	w10, [x0, #32]
ld1r.8h	{ v1 }, [x17]
ldr	w6, [x0, #28]
ldr	x7, [x0, #16]
and.8b	v7, v3, v31
sqdmulh.4h	v6, v17, v7
add.4h	v4, v17, v29
add.4h	v4, v6, v4
cmhs.4h	v2, v1, v4
add	w13, w13, #40
ext.8b	v18, v3, v4, #6
mov.d	x15, v2[0]
rev	x15, x15
sub.4h	v18, v18, v4
clz	x15, x15
cbz	w10, msac_decode_hi_tok_neon
sub.4h	v5, v0, v2
mov	w4, #-5
orr.4h	v2, #128, lsl #8
sub	w4, w4, w9, lsr #4
sub.4h	v2, v2, v0
dup.4h	v6, w4
sub	w9, w9, w9, lsr #5
sshl.4h	v2, v2, v6
add	w9, w9, #1
add.4h	v0, v5, v2
st1.4h	{ v0 }, [x1]
and.8b	v17, v0, v30
strh	w9, [x1, #6]
mov.d	x4, v18[0]
mov.d	x3, v4[0]
lsr	x4, x4, x15
lsr	x3, x3, x15
lsl	w5, w4, #16
sub	x7, x7, x3, lsl #48
clz	w5, w5
lsl	w4, w4, w5
subs	w6, w6, w5
lsl	x7, x7, x5
strh	w4, [x0, #24]
dup.4h	v3, w4
b.hs	msac_decode_hi_tok_neon
ldp	x3, x4, [x0]
add	x5, x3, #8
subs	x5, x5, x4
b.hi	msac_decode_hi_tok_neon
ldr	x8, [x3]
sub	w4, w6, #48
mvn	x8, x8
neg	w5, w4
rev	x8, x8
lsr	w5, w5, #3
lsr	x8, x8, x4
add	x3, x3, x5
add	w6, w6, w5, lsl #3
str	x3, [x0]
orr	x7, x7, x8
sub	w15, w15, #40
lsr	x12, x7, #48
adds	w13, w13, w15
dup.8h	v1, w12
b.lo	msac_decode_hi_tok_neon
add	w13, w13, #240
str	w6, [x0, #28]
str	x7, [x0, #16]
lsr	w0, w13, #4
ret
sub	w8, w6, #16
ror	x8, x8, x8
b	msac_decode_hi_tok_neon
cmp	x3, x4
b.hs	msac_decode_hi_tok_neon
ldur	x8, [x4, #-8]
lsl	w5, w5, #3
lsr	x8, x8, x5
sub	w5, w6, #48
mvn	x8, x8
sub	w4, w4, w3
rev	x8, x8
lsr	x8, x8, x5
neg	w5, w5
lsr	w5, w5, #3
cmp	w5, w4
csel	w5, w5, w4, lo
b	msac_decode_hi_tok_neon
_msac_decode_bool_equi_neon:
ldp	w5, w6, [x0, #24]
ldr	x7, [x0, #16]
and	w4, w5, #0xffffff00
add	w4, w4, #8
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
str	w4, [x0, #24]
b.lo	msac_decode_symbol_adapt4_neon
str	w6, [x0, #28]
str	x7, [x0, #16]
mov	w0, w15
ret
_msac_decode_bool_neon:
ldp	w5, w6, [x0, #24]
ldr	x7, [x0, #16]
lsr	w4, w5, #8
and	w1, w1, #0xffffffc0
mul	w4, w4, w1
lsr	w4, w4, #7
add	w4, w4, #4
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
str	w4, [x0, #24]
b.lo	msac_decode_symbol_adapt4_neon
str	w6, [x0, #28]
str	x7, [x0, #16]
mov	w0, w15
ret
_msac_decode_bool_adapt_neon:
ldr	w9, [x1]
ldp	w5, w6, [x0, #24]
ldr	x7, [x0, #16]
lsr	w4, w5, #8
and	w2, w9, #0xffc0
mul	w4, w4, w2
lsr	w4, w4, #7
add	w4, w4, #4
subs	x8, x7, x4, lsl #48
sub	w5, w5, w4
cset	w15, lo
csel	w4, w5, w4, hs
csel	x7, x8, x7, hs
ldr	w10, [x0, #32]
clz	w5, w4
eor	w5, w5, #0x10
cbz	w10, msac_decode_bool_adapt_neon
lsr	w2, w9, #16
and	w9, w9, #0xffff
sub	w3, w2, w2, lsr #5
lsr	w2, w2, #4
add	w10, w3, #1
add	w2, w2, #4
sub	w9, w9, w15
sub	w11, w9, w15, lsl #15
asr	w11, w11, w2
sub	w9, w9, w11
strh	w9, [x1]
strh	w10, [x1, #2]
lsl	w4, w4, w5
subs	w6, w6, w5
lsl	x7, x7, x5
str	w4, [x0, #24]
b.lo	msac_decode_symbol_adapt4_neon
str	w6, [x0, #28]
str	x7, [x0, #16]
mov	w0, w15
ret