	.text
splat_mv_neon:
ld1	{ v3.16b }, [x1]
clz	w3, w3
adrp	x5, splat_tbl
add	x5, x5, :lo12:splat_tbl
sub	w3, w3, #0x1a
ext	v2.16b, v3.16b, v3.16b, #0xc
ldrsw	x3, [x5, w3, uxtw #2]
add	w2, w2, w2, lsl #1
ext	v0.16b, v2.16b, v3.16b, #0x4
add	x3, x5, x3
ext	v1.16b, v2.16b, v3.16b, #0x8
lsl	w2, w2, #2
ext	v2.16b, v2.16b, v3.16b, #0xc
L_34:
ldr	x1, [x0], #0x8
subs	w4, w4, #0x1
add	x1, x1, x2
br	x3
L_44:
st1	{ v0.8b }, [x1]
str	s2, [x1, #0x8]
b.gt	L_34
ret
L_54:
st1	{ v0.16b }, [x1]
str	d1, [x1, #0x10]
b.gt	L_34
ret
L_64:
st1	{ v0.16b, v1.16b, v2.16b }, [x1], #48
st1	{ v0.16b, v1.16b, v2.16b }, [x1], #48
st1	{ v0.16b, v1.16b, v2.16b }, [x1], #48
st1	{ v0.16b, v1.16b, v2.16b }, [x1], #48
L_74:
st1	{ v0.16b, v1.16b, v2.16b }, [x1], #48
st1	{ v0.16b, v1.16b, v2.16b }, [x1], #48
L_7c:
st1	{ v0.16b, v1.16b, v2.16b }, [x1], #48
L_80:
st1	{ v0.16b, v1.16b, v2.16b }, [x1]
b.gt	L_34
ret
save_tmvs_neon:
stp	x29, x30, [sp, #-0x10]!
mov	x29, sp
movi	v30.8b, #0x0
ld1	{ v31.8b }, [x3]
adrp	x8, save_tmvs_tbl
add	x8, x8, :lo12:save_tmvs_tbl
adrp	x16, mask_mult
add	x16, x16, :lo12:mask_mult
adrp	x13, mv_tbls
add	x13, x13, :lo12:mv_tbls
ld1	{ v29.8b }, [x16]
ext	v31.8b, v30.8b, v31.8b, #0x7
mov	w15, #0x5
mov	w14, #0x18
sxtw	x4, w4
sxtw	x6, w6
mul	w1, w1, w15
sub	w5, w5, w7
lsl	w7, w7, #1
L_d8:
mov	w15, #0x5
and	w9, w7, #0x1e
ldr	x9, [x2, w9, uxtw #3]
add	x9, x9, #0xc
madd	x10, x4, x14, x9
madd	x9, x6, x14, x9
madd	x3, x6, x15, x0
L_f4:
ldrb	w11, [x9, #0xa]
ld1	{ v0.16b }, [x9]
add	x11, x8, w11, uxtw #3
ldr	h1, [x9, #0x8]
ldr	w12, [x11]
mov	x15, x8
add	x9, x9, w12, uxtw #1
cmp	x9, x10
mov	v2.8b, v0.8b
b.ge	L_13c
ldrb	w15, [x9, #0xa]
add	x16, x9, #0x8
ld1	{ v4.16b }, [x9]
add	x15, x8, w15, uxtw #3
ld1	{ v1.h }[1], [x16]
ldr	w12, [x15]
add	x9, x9, w12, uxtw #1
trn1	v2.2d, v0.2d, v4.2d
L_13c:
abs	v2.8h, v2.8h
tbl	v1.8b, { v31.16b }, v1.8b
ushr	v2.8h, v2.8h, #0xc
umull	v1.8h, v1.8b, v29.8b
cmeq	v2.4s, v2.4s, #0
xtn	v2.4h, v2.4s
and	v1.8b, v1.8b, v2.8b
addp	v1.4h, v1.4h, v1.4h
umov	w16, v1.h[0]
umov	w17, v1.h[1]
ldrsw	x11, [x11, #0x4]
ldrsw	x15, [x15, #0x4]
ldr	q1, [x13, w16, uxtw #4]
ldr	q5, [x13, w17, uxtw #4]
add	x11, x8, x11
add	x15, x8, x15
tbl	v0.16b, { v0.16b }, v1.16b
tbl	v4.16b, { v4.16b }, v5.16b
ext	v1.16b, v0.16b, v0.16b, #0x1
ext	v5.16b, v4.16b, v4.16b, #0x1
ext	v2.16b, v0.16b, v1.16b, #0x4
ext	v6.16b, v4.16b, v5.16b, #0x4
blr	x11
b.ge	L_1b4
mov	v0.16b, v4.16b
mov	v1.16b, v5.16b
mov	v2.16b, v6.16b
cmp	x9, x10
blr	x15
b.lt	L_f4
L_1b4:
subs	w5, w5, #0x1
add	w7, w7, #0x2
add	x0, x0, x1
b.gt	L_d8
ldp	x29, x30, [sp], #0x10
ret
L_1cc:
add	x16, x3, #0x4
st1	{ v0.s }[0], [x3]
st1	{ v0.b }[4], [x16]
add	x3, x3, #0x5
ret
L_1e0:
add	x16, x3, #0x8
st1	{ v0.d }[0], [x3]
st1	{ v0.h }[4], [x16]
add	x3, x3, #0xa
ret
L_1f4:
st1	{ v0.16b }, [x3]
str	s1, [x3, #0x10]
add	x3, x3, #0x14
ret
L_204:
st1	{ v0.16b, v1.16b }, [x3]
stur	q2, [x3, #0x18]
add	x3, x3, #0x28
ret
L_214:
add	x16, x3, #0x1e
add	x17, x3, #0x3c
st1	{ v0.16b, v1.16b }, [x3]
st1	{ v0.16b, v1.16b }, [x16]
st1	{ v0.8b }, [x17]
str	q2, [x3, #0x40]
add	x3, x3, #0x50
ret
load_tmvs_neon:
stp	x28, x27, [sp, #-0x60]!
stp	x26, x25, [sp, #0x10]
stp	x24, x23, [sp, #0x20]
stp	x22, x21, [sp, #0x30]
stp	x20, x19, [sp, #0x40]
stp	x29, x30, [sp, #0x50]
ldr	w15, [x0, #0xc8]
ldp	w16, w17, [x0, #0x10]
sub	w6, w2, #0x8
add	w7, w3, #0x8
ldr	w9, [x0, #0xb8]
ldr	x8, [x0, #0xb0]
cmp	w15, #0x1
csel	w1, wzr, w1, eq
bic	w6, w6, w6, asr #31
cmp	w7, w16
csel	w7, w7, w16, lt
lsl	w1, w1, #4
cmp	w5, w17
csel	w5, w5, w17, lt
add	w9, w9, w9, lsl #2
and	w15, w4, #0xf
add	w10, w2, w2, lsl #2
smaddl	x8, w1, w9, x8
smaddl	x10, w15, w9, x10
mov	w15, #-0x7fff8000
sub	w11, w3, w2
add	x10, x10, x8
add	x15, x15, x15, lsl #40
mov	w17, #0x800080
sub	w12, w5, w4
ror	x16, x15, #0x30
ldr	w19, [x0, #0x98]
L_2b8:
and	w13, w11, #0xfffffffc
mov	x14, x10
add	x10, x10, x9
sub	w12, w12, #0x1
cbz	w13, L_2e0
L_2cc:
sub	w13, w13, #0x4
stp	x15, x16, [x14]
str	w17, [x14, #0x10]
add	x14, x14, #0x14
cbnz	w13, L_2cc
L_2e0:
tbz	w11, #0x1, L_2f0
str	x15, [x14]
strh	w16, [x14, #0x8]
add	x14, x14, #0xa
L_2f0:
tbz	w11, #0x0, L_2f8
str	w15, [x14]
L_2f8:
cbnz	w12, L_2b8
cbz	w19, L_4ac
add	x29, x0, #0x38
mov	w10, #0x0
movi	v3.2s, #0xff
adrp	x1, div_mult_tbl
add	x1, x1, :lo12:div_mult_tbl
L_314:
ldr	w16, [x29, x10, lsl #2]
cmn	w16, #0x20
b.lt	L_4a0
sub	x17, x10, #0x3
mov	x20, #0x4
ldrb	w17, [x29, x17]
ldr	x13, [x29, #0x70]
mov	w28, #0x1c
smaddl	x20, w4, w9, x20
mov	w12, w4
add	x21, x29, #0x8
ldr	x13, [x13, x17, lsl #3]
smaddl	x28, w28, w10, x21
sub	w17, w17, #0x4
add	x13, x13, x20
dup	v0.2s, w17
L_354:
and	w14, w12, #0xfffffff8
mov	w11, w6
add	w15, w14, #0x8
cmp	w14, w4
csel	w14, w14, w4, gt
cmp	w15, w5
csel	w15, w15, w5, lt
L_370:
add	x23, x13, x11, lsl #2
ldrb	w22, [x23, x11]
cbz	w22, L_484
ldr	w24, [x28, x22, lsl #2]
cbz	w24, L_484
ldrh	w20, [x1, x24, lsl #1]
add	x23, x23, x11
mul	w20, w20, w16
ldur	s1, [x23, #-0x4]
fmov	s2, w20
sshll	v1.4s, v1.4h, #0x0
mul	v1.2s, v1.2s, v2.s[0]
ssra	v1.2s, v1.2s, #0x1f
ldur	w25, [x23, #-0x4]
srshr	v1.2s, v1.2s, #0xe
abs	v2.2s, v1.2s
eor	v1.8b, v1.8b, v0.8b
sshr	v2.2s, v2.2s, #0x6
cmlt	v1.2s, v1.2s, #0
umin	v2.2s, v2.2s, v3.2s
neg	v4.2s, v2.2s
bsl	v1.8b, v4.8b, v2.8b
fmov	x20, d1
add	w21, w12, w20
cmp	w21, w14
b.lt	L_458
cmp	w21, w15
b.ge	L_458
add	x26, x11, x20, asr #32
and	w27, w21, #0xf
add	x21, x26, x26, lsl #2
umaddl	x27, w27, w9, x8
add	x27, x27, x21
L_3f4:
and	w20, w11, #0xfffffff8
sub	w21, w20, #0x8
cmp	w21, w2
csel	w21, w21, w2, gt
cmp	w26, w21
b.lt	L_428
add	w20, w20, #0x10
cmp	w20, w3
csel	w20, w20, w3, lt
cmp	w26, w20
b.ge	L_428
str	w25, [x27]
strb	w24, [x27, #0x4]
L_428:
add	w11, w11, #0x1
cmp	w11, w7
b.ge	L_490
ldrb	w20, [x23, #0x5]!
cmp	w20, w22
b.ne	L_47c
ldur	w21, [x23, #-0x4]
cmp	w21, w25
b.ne	L_47c
add	w26, w26, #0x1
add	x27, x27, #0x5
b	L_3f4
L_458:
add	w11, w11, #0x1
cmp	w11, w7
b.ge	L_490
ldrb	w20, [x23, #0x5]!
cmp	w20, w22
b.ne	L_47c
ldur	w21, [x23, #-0x4]
cmp	w21, w25
b.eq	L_458
L_47c:
cmp	w11, w7
b.lt	L_370
L_484:
add	w11, w11, #0x1
cmp	w11, w7
b.lt	L_370
L_490:
add	w12, w12, #0x1
add	x13, x13, x9
cmp	w12, w5
b.lt	L_354
L_4a0:
add	w10, w10, #0x1
cmp	w10, w19
b.lt	L_314
L_4ac:
ldp	x29, x30, [sp, #0x50]
ldp	x20, x19, [sp, #0x40]
ldp	x22, x21, [sp, #0x30]
ldp	x24, x23, [sp, #0x20]
ldp	x26, x25, [sp, #0x10]
ldp	x28, x27, [sp], #0x60
ret
	.section .rodata
splat_tbl:
	.size splat_tbl, 24
	.word L_64 - splat_tbl
	.word L_74 - splat_tbl
	.word L_7c - splat_tbl
	.word L_80 - splat_tbl
	.word L_54 - splat_tbl
	.word L_44 - splat_tbl
	.byte 0,0,0,0,0,0,0,0
mv_tbls:
	.size mv_tbls, 64
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 0,1,2,3,8,0,1,2,3,8,0,1,2,3,8,0
	.byte 4,5,6,7,9,4,5,6,7,9,4,5,6,7,9,4
	.byte 4,5,6,7,9,4,5,6,7,9,4,5,6,7,9,4
mask_mult:
	.size mask_mult, 8
	.byte 1,2,1,2,0,0,0,0
save_tmvs_tbl:
	.size save_tmvs_tbl, 176
	.byte 192,0,0,0
	.word L_214 - save_tmvs_tbl
	.byte 192,0,0,0
	.word L_214 - save_tmvs_tbl
	.byte 96,0,0,0
	.word L_204 - save_tmvs_tbl
	.byte 96,0,0,0
	.word L_204 - save_tmvs_tbl
	.byte 96,0,0,0
	.word L_204 - save_tmvs_tbl
	.byte 96,0,0,0
	.word L_204 - save_tmvs_tbl
	.byte 48,0,0,0
	.word L_1f4 - save_tmvs_tbl
	.byte 48,0,0,0
	.word L_1f4 - save_tmvs_tbl
	.byte 48,0,0,0
	.word L_1f4 - save_tmvs_tbl
	.byte 48,0,0,0
	.word L_1f4 - save_tmvs_tbl
	.byte 24,0,0,0
	.word L_1e0 - save_tmvs_tbl
	.byte 24,0,0,0
	.word L_1e0 - save_tmvs_tbl
	.byte 24,0,0,0
	.word L_1e0 - save_tmvs_tbl
	.byte 24,0,0,0
	.word L_1e0 - save_tmvs_tbl
	.byte 24,0,0,0
	.word L_1e0 - save_tmvs_tbl
	.byte 12,0,0,0
	.word L_1cc - save_tmvs_tbl
	.byte 12,0,0,0
	.word L_1cc - save_tmvs_tbl
	.byte 12,0,0,0
	.word L_1cc - save_tmvs_tbl
	.byte 12,0,0,0
	.word L_1cc - save_tmvs_tbl
	.byte 12,0,0,0
	.word L_1cc - save_tmvs_tbl
	.byte 12,0,0,0
	.word L_1cc - save_tmvs_tbl
	.byte 12,0,0,0
	.word L_1cc - save_tmvs_tbl
div_mult_tbl:
	.size div_mult_tbl, 64
	.byte 0,0,0,64,0,32,85,21,0,16,204,12,170,10,36,9
	.byte 0,8,28,7,102,6,209,5,85,5,236,4,146,4,68,4
	.byte 0,4,195,3,142,3,94,3,51,3,12,3,232,2,200,2
	.byte 170,2,143,2,118,2,94,2,73,2,52,2,34,2,16,2
