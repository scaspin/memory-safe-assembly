	.text
get_gaussian_neon:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
lsr	w2, w2, #4
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #12
ubfx	x14, x2, #2, #11
ubfx	x15, x2, #3, #11
add	x14, x3, x14, lsl #1
add	x15, x3, x15, lsl #1
ld1	{ v0.h }[0], [x14]
ubfx	x14, x2, #4, #11
ld1	{ v0.h }[1], [x15]
add	x14, x3, x14, lsl #1
ubfx	x15, x2, #5, #11
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
lsr	w2, w2, #4
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #12
add	x15, x3, x15, lsl #1
ld1	{ v0.h }[2], [x14]
ubfx	x14, x2, #2, #11
ld1	{ v0.h }[3], [x15]
add	x14, x3, x14, lsl #1
ubfx	x15, x2, #3, #11
ld1	{ v0.h }[4], [x14]
add	x15, x3, x15, lsl #1
ubfx	x14, x2, #4, #11
ld1	{ v0.h }[5], [x15]
ubfx	x15, x2, #5, #11
add	x14, x3, x14, lsl #1
add	x15, x3, x15, lsl #1
ld1	{ v0.h }[6], [x14]
ld1	{ v0.h }[7], [x15]
ret
get_grain_2_neon:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
lsr	w2, w2, #2
and	w11, w11, #0x3
orr	w2, w2, w11, lsl #14
ubfx	x14, x2, #4, #11
ubfx	x15, x2, #5, #11
add	x14, x3, x14, lsl #1
add	x15, x3, x15, lsl #1
ld1	{ v0.h }[0], [x14]
ld1	{ v0.h }[1], [x15]
srshl	v0.4h, v0.4h, v31.4h
xtn	v0.8b, v0.8h
ret
output_lag1_neon:
ubfx	x13, x2, #6, #11
lsr	w2, w2, #1
mov	w11, v1.s[0]
ldrsh	w12, [x3, x13, lsl #1]
ext	v0.16b, v0.16b, v0.16b, #0x1
madd	w11, w14, w4, w11
add	w14, w11, w8
add	w12, w12, w10
asr	w14, w14, w7
asr	w12, w12, w9
add	w14, w14, w12
cmp	w14, w5
csel	w14, w14, w5, le
cmp	w14, w6
csel	w14, w14, w6, ge
subs	w15, w15, #0x1
ext	v1.16b, v1.16b, v1.16b, #0x4
mov	v0.b[15], w14
b.gt	output_lag1_neon
ret
output_lag2_neon:
ubfx	x13, x2, #6, #11
lsr	w2, w2, #1
mov	w11, v1.s[0]
ldrsh	w12, [x3, x13, lsl #1]
ext	v0.16b, v0.16b, v0.16b, #0x1
madd	w11, w16, w4, w11
madd	w11, w14, w17, w11
mov	w16, w14
add	w14, w11, w8
add	w12, w12, w10
asr	w14, w14, w7
asr	w12, w12, w9
add	w14, w14, w12
cmp	w14, w5
csel	w14, w14, w5, le
cmp	w14, w6
csel	w14, w14, w6, ge
subs	w15, w15, #0x1
ext	v1.16b, v1.16b, v1.16b, #0x4
mov	v0.b[15], w14
b.gt	output_lag2_neon
ret
output_lag3_neon:
ubfx	x13, x2, #6, #11
lsr	w2, w2, #1
mov	w11, v1.s[0]
ldrsh	w12, [x3, x13, lsl #1]
ext	v0.16b, v0.16b, v0.16b, #0x1
madd	w11, w17, w4, w11
madd	w11, w16, w20, w11
madd	w11, w14, w21, w11
mov	w17, w16
mov	w16, w14
add	w14, w11, w8
add	w12, w12, w10
asr	w14, w14, w7
asr	w12, w12, w9
add	w14, w14, w12
cmp	w14, w5
csel	w14, w14, w5, le
cmp	w14, w6
csel	w14, w14, w6, ge
subs	w15, w15, #0x1
ext	v1.16b, v1.16b, v1.16b, #0x4
mov	v0.b[15], w14
b.gt	output_lag3_neon
ret
sum_lag1_above_neon:
smull	v2.8h, v3.8b, v28.8b
smull2	v3.8h, v3.16b, v28.16b
smull	v4.8h, v0.8b, v27.8b
smull2	v5.8h, v0.16b, v27.16b
smull	v6.8h, v1.8b, v29.8b
smull2	v7.8h, v1.16b, v29.16b
saddl	v0.4s, v2.4h, v4.4h
saddl2	v1.4s, v2.8h, v4.8h
saddl	v2.4s, v3.4h, v5.4h
saddl2	v3.4s, v3.8h, v5.8h
saddw	v4.4s, v0.4s, v6.4h
saddw2	v5.4s, v1.4s, v6.8h
saddw	v6.4s, v2.4s, v7.4h
saddw2	v7.4s, v3.4s, v7.8h
ret
sum_y_lag1_left_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
sum_lag1_y_left_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
lsr	w2, w2, #4
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #12
ubfx	x12, x2, #2, #11
ubfx	x13, x2, #3, #11
ubfx	x14, x2, #4, #11
add	x12, x3, x12, lsl #1
add	x13, x3, x13, lsl #1
add	x14, x3, x14, lsl #1
ld1	{ v0.h }[5], [x12]
ld1	{ v0.h }[6], [x13]
ld1	{ v0.h }[7], [x14]
lsl	x2, x2, #1
srshl	v0.8h, v0.8h, v31.8h
xtn2	v0.16b, v0.8h
ext	v4.16b, v4.16b, v4.16b, #0xc
smov	w14, v0.b[15]
mov	v1.16b, v4.16b
mov	w15, #0x1
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v5.16b
mov	w15, #0x4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v6.16b
mov	w15, #0x4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v7.16b
mov	w15, #0x4
bl	output_lag1_neon
ldr	x30, [sp], #0x10
ret
sum_y_lag1_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
sum_lag1_y_mid_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v4.16b
mov	w15, #0x4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v5.16b
mov	w15, #0x4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v6.16b
mov	w15, #0x4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v7.16b
mov	w15, #0x4
bl	output_lag1_neon
ldr	x30, [sp], #0x10
ret
sum_y_lag1_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
sum_lag1_y_right_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v4.16b
mov	w15, #0x4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v5.16b
mov	w15, #0x4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v6.16b
mov	w15, #0x4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v7.16b
mov	w15, #0x3
bl	output_lag1_neon
ubfx	x15, x2, #6, #11
lsr	w2, w2, #1
add	x15, x3, x15, lsl #1
ld1	{ v1.h }[0], [x15]
srshl	v1.4h, v1.4h, v31.4h
ext	v0.16b, v0.16b, v1.16b, #0x1
ldr	x30, [sp], #0x10
ret
sum_uv_444_lag1_left_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
ld1	{ v0.16b }, [x19], #16
smull	v2.8h, v0.8b, v30.8b
smull2	v3.8h, v0.16b, v30.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag1_y_left_start
sum_uv_444_lag1_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
ld1	{ v0.16b }, [x19], #16
smull	v2.8h, v0.8b, v30.8b
smull2	v3.8h, v0.16b, v30.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag1_y_mid_start
sum_uv_444_lag1_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
ld1	{ v0.16b }, [x19], #16
smull	v2.8h, v0.8b, v30.8b
smull2	v3.8h, v0.16b, v30.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag1_y_right_start
sum_uv_422_lag1_left_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
ld1	{ v22.16b, v23.16b }, [x19], #32
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
rshrn	v0.8b, v22.8h, #0x1
rshrn2	v0.16b, v23.8h, #0x1
smull	v2.8h, v0.8b, v30.8b
smull2	v3.8h, v0.16b, v30.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag1_y_left_start
sum_uv_422_lag1_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
ld1	{ v22.16b, v23.16b }, [x19], #32
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
rshrn	v0.8b, v22.8h, #0x1
rshrn2	v0.16b, v23.8h, #0x1
smull	v2.8h, v0.8b, v30.8b
smull2	v3.8h, v0.16b, v30.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag1_y_mid_start
sum_uv_422_lag1_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
ld1	{ v22.16b, v23.16b }, [x19], #32
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
rshrn	v0.8b, v22.8h, #0x1
rshrn2	v0.16b, v23.8h, #0x1
smull	v2.8h, v0.8b, v30.8b
smull2	v3.8h, v0.16b, v30.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag1_uv_420_right_start
sum_uv_420_lag1_left_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
add	x12, x19, #0x52
ld1	{ v22.16b, v23.16b }, [x19], #32
ld1	{ v24.16b, v25.16b }, [x12]
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
saddlp	v24.8h, v24.16b
saddlp	v25.8h, v25.16b
add	v22.8h, v22.8h, v24.8h
add	v23.8h, v23.8h, v25.8h
rshrn	v0.8b, v22.8h, #0x2
rshrn2	v0.16b, v23.8h, #0x2
smull	v2.8h, v0.8b, v30.8b
smull2	v3.8h, v0.16b, v30.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag1_y_left_start
sum_uv_420_lag1_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
add	x12, x19, #0x52
ld1	{ v22.16b, v23.16b }, [x19], #32
ld1	{ v24.16b, v25.16b }, [x12]
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
saddlp	v24.8h, v24.16b
saddlp	v25.8h, v25.16b
add	v22.8h, v22.8h, v24.8h
add	v23.8h, v23.8h, v25.8h
rshrn	v0.8b, v22.8h, #0x2
rshrn2	v0.16b, v23.8h, #0x2
smull	v2.8h, v0.8b, v30.8b
smull2	v3.8h, v0.16b, v30.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag1_y_mid_start
sum_uv_420_lag1_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
add	x12, x19, #0x52
ld1	{ v22.16b, v23.16b }, [x19], #32
ld1	{ v24.16b, v25.16b }, [x12]
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
saddlp	v24.8h, v24.16b
saddlp	v25.8h, v25.16b
add	v22.8h, v22.8h, v24.8h
add	v23.8h, v23.8h, v25.8h
rshrn	v0.8b, v22.8h, #0x2
rshrn2	v0.16b, v23.8h, #0x2
smull	v2.8h, v0.8b, v30.8b
smull2	v3.8h, v0.16b, v30.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
sum_lag1_uv_420_right_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v4.16b
mov	w15, #0x4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v5.16b
mov	w15, #0x4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v6.16b
mov	w15, #0x1
bl	output_lag1_neon
lsr	w2, w2, #3
ubfx	x12, x2, #3, #11
ubfx	x13, x2, #4, #11
ubfx	x14, x2, #5, #11
add	x12, x3, x12, lsl #1
add	x13, x3, x13, lsl #1
add	x14, x3, x14, lsl #1
ld1	{ v1.h }[0], [x12]
ld1	{ v1.h }[1], [x13]
ld1	{ v1.h }[2], [x14]
srshl	v1.4h, v1.4h, v31.4h
xtn	v1.8b, v1.8h
ext	v0.16b, v0.16b, v1.16b, #0x7
ldr	x30, [sp], #0x10
ret
sum_lag2_above_neon:
sub	x12, x0, #0x94
sub	x13, x0, #0x42
ld1	{ v18.16b }, [x12]
ld1	{ v21.16b }, [x13]
ext	v22.16b, v16.16b, v17.16b, #0xe
dup	v26.16b, v30.b[0]
ext	v23.16b, v16.16b, v17.16b, #0xf
dup	v27.16b, v30.b[1]
ext	v0.16b, v17.16b, v18.16b, #0x1
dup	v28.16b, v30.b[3]
ext	v1.16b, v17.16b, v18.16b, #0x2
dup	v29.16b, v30.b[4]
smull	v2.8h, v22.8b, v26.8b
smull2	v3.8h, v22.16b, v26.16b
smull	v4.8h, v23.8b, v27.8b
smull2	v5.8h, v23.16b, v27.16b
smull	v6.8h, v0.8b, v28.8b
smull2	v7.8h, v0.16b, v28.16b
smull	v0.8h, v1.8b, v29.8b
smull2	v1.8h, v1.16b, v29.16b
saddl	v22.4s, v2.4h, v4.4h
saddl2	v23.4s, v2.8h, v4.8h
saddl	v26.4s, v3.4h, v5.4h
saddl2	v27.4s, v3.8h, v5.8h
saddl	v2.4s, v0.4h, v6.4h
saddl2	v3.4s, v0.8h, v6.8h
saddl	v6.4s, v1.4h, v7.4h
saddl2	v7.4s, v1.8h, v7.8h
add	v4.4s, v22.4s, v2.4s
add	v5.4s, v23.4s, v3.4s
add	v6.4s, v26.4s, v6.4s
add	v7.4s, v27.4s, v7.4s
ext	v22.16b, v19.16b, v20.16b, #0xe
dup	v26.16b, v30.b[5]
ext	v23.16b, v19.16b, v20.16b, #0xf
dup	v27.16b, v30.b[6]
ext	v0.16b, v20.16b, v21.16b, #0x1
dup	v28.16b, v30.b[8]
ext	v1.16b, v20.16b, v21.16b, #0x2
dup	v29.16b, v30.b[9]
smull	v2.8h, v22.8b, v26.8b
smull2	v3.8h, v22.16b, v26.16b
smull	v22.8h, v23.8b, v27.8b
smull2	v23.8h, v23.16b, v27.16b
smull	v26.8h, v0.8b, v28.8b
smull2	v27.8h, v0.16b, v28.16b
smull	v28.8h, v1.8b, v29.8b
smull2	v29.8h, v1.16b, v29.16b
saddl	v0.4s, v2.4h, v22.4h
saddl2	v1.4s, v2.8h, v22.8h
saddl	v2.4s, v3.4h, v23.4h
saddl2	v3.4s, v3.8h, v23.8h
saddl	v22.4s, v26.4h, v28.4h
saddl2	v23.4s, v26.8h, v28.8h
saddl	v26.4s, v27.4h, v29.4h
saddl2	v27.4s, v27.8h, v29.8h
add	v0.4s, v0.4s, v22.4s
add	v1.4s, v1.4s, v23.4s
add	v2.4s, v2.4s, v26.4s
add	v3.4s, v3.4s, v27.4s
dup	v26.16b, v30.b[2]
dup	v27.16b, v30.b[7]
smull	v22.8h, v17.8b, v26.8b
smull2	v23.8h, v17.16b, v26.16b
smull	v24.8h, v20.8b, v27.8b
smull2	v25.8h, v20.16b, v27.16b
add	v4.4s, v4.4s, v0.4s
add	v5.4s, v5.4s, v1.4s
add	v6.4s, v6.4s, v2.4s
add	v7.4s, v7.4s, v3.4s
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
saddl	v0.4s, v22.4h, v24.4h
saddl2	v1.4s, v22.8h, v24.8h
saddl	v2.4s, v23.4h, v25.4h
saddl2	v3.4s, v23.8h, v25.8h
mov	v19.16b, v20.16b
mov	v20.16b, v21.16b
add	v4.4s, v4.4s, v0.4s
add	v5.4s, v5.4s, v1.4s
add	v6.4s, v6.4s, v2.4s
add	v7.4s, v7.4s, v3.4s
ret
sum_y_lag2_left_neon:
str	x30, [sp, #-0x10]!
sub	x12, x0, #0xa4
sub	x13, x0, #0x52
ld1	{ v17.16b }, [x12]
ld1	{ v20.16b }, [x13]
bl	sum_lag2_above_neon
sum_lag2_y_left_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
lsr	w2, w2, #4
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #12
ubfx	x12, x2, #2, #11
ubfx	x13, x2, #3, #11
ubfx	x14, x2, #4, #11
add	x12, x3, x12, lsl #1
add	x13, x3, x13, lsl #1
add	x14, x3, x14, lsl #1
ld1	{ v0.h }[5], [x12]
ld1	{ v0.h }[6], [x13]
ld1	{ v0.h }[7], [x14]
lsl	x2, x2, #1
srshl	v0.8h, v0.8h, v31.8h
xtn2	v0.16b, v0.8h
ext	v4.16b, v4.16b, v4.16b, #0xc
smov	w16, v0.b[14]
smov	w14, v0.b[15]
mov	v1.16b, v4.16b
mov	w15, #0x1
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v5.16b
mov	w15, #0x4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v6.16b
mov	w15, #0x4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v7.16b
mov	w15, #0x4
bl	output_lag2_neon
st1	{ v0.16b }, [x0], #16
ldr	x30, [sp], #0x10
ret
sum_y_lag2_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
sum_lag2_y_mid_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v4.16b
mov	w15, #0x4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v5.16b
mov	w15, #0x4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v6.16b
mov	w15, #0x4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v7.16b
mov	w15, #0x4
bl	output_lag2_neon
st1	{ v0.16b }, [x0], #16
ldr	x30, [sp], #0x10
ret
sum_y_lag2_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
sum_lag2_y_right_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v4.16b
mov	w15, #0x4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v5.16b
mov	w15, #0x4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v6.16b
mov	w15, #0x4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v7.16b
mov	w15, #0x3
bl	output_lag2_neon
ubfx	x15, x2, #6, #11
lsr	w2, w2, #1
add	x15, x3, x15, lsl #1
ld1	{ v1.h }[0], [x15]
srshl	v1.4h, v1.4h, v31.4h
ext	v0.16b, v0.16b, v1.16b, #0x1
st1	{ v0.16b }, [x0], #16
ldr	x30, [sp], #0x10
ret
sum_uv_444_lag2_left_neon:
str	x30, [sp, #-0x10]!
sub	x12, x0, #0xa4
sub	x13, x0, #0x52
ld1	{ v17.16b }, [x12]
ld1	{ v20.16b }, [x13]
bl	sum_lag2_above_neon
ld1	{ v0.16b }, [x19], #16
dup	v1.16b, v30.b[12]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag2_y_left_start
sum_uv_444_lag2_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
ld1	{ v0.16b }, [x19], #16
dup	v1.16b, v30.b[12]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag2_y_mid_start
sum_uv_444_lag2_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
ld1	{ v0.16b }, [x19], #16
dup	v1.16b, v30.b[12]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag2_y_right_start
sum_uv_422_lag2_left_neon:
str	x30, [sp, #-0x10]!
sub	x12, x0, #0xa4
sub	x13, x0, #0x52
ld1	{ v17.16b }, [x12]
ld1	{ v20.16b }, [x13]
bl	sum_lag2_above_neon
ld1	{ v22.16b, v23.16b }, [x19], #32
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
rshrn	v0.8b, v22.8h, #0x1
rshrn2	v0.16b, v23.8h, #0x1
dup	v1.16b, v30.b[12]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag2_y_left_start
sum_uv_422_lag2_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
ld1	{ v22.16b, v23.16b }, [x19], #32
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
rshrn	v0.8b, v22.8h, #0x1
rshrn2	v0.16b, v23.8h, #0x1
dup	v1.16b, v30.b[12]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag2_y_mid_start
sum_uv_422_lag2_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
ld1	{ v22.16b, v23.16b }, [x19], #32
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
rshrn	v0.8b, v22.8h, #0x1
rshrn2	v0.16b, v23.8h, #0x1
dup	v1.16b, v30.b[12]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag2_uv_420_right_start
sum_uv_420_lag2_left_neon:
str	x30, [sp, #-0x10]!
sub	x12, x0, #0xa4
sub	x13, x0, #0x52
ld1	{ v17.16b }, [x12]
ld1	{ v20.16b }, [x13]
bl	sum_lag2_above_neon
add	x12, x19, #0x52
ld1	{ v22.16b, v23.16b }, [x19], #32
ld1	{ v24.16b, v25.16b }, [x12]
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
saddlp	v24.8h, v24.16b
saddlp	v25.8h, v25.16b
add	v22.8h, v22.8h, v24.8h
add	v23.8h, v23.8h, v25.8h
rshrn	v0.8b, v22.8h, #0x2
rshrn2	v0.16b, v23.8h, #0x2
dup	v1.16b, v30.b[12]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag2_y_left_start
sum_uv_420_lag2_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
add	x12, x19, #0x52
ld1	{ v22.16b, v23.16b }, [x19], #32
ld1	{ v24.16b, v25.16b }, [x12]
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
saddlp	v24.8h, v24.16b
saddlp	v25.8h, v25.16b
add	v22.8h, v22.8h, v24.8h
add	v23.8h, v23.8h, v25.8h
rshrn	v0.8b, v22.8h, #0x2
rshrn2	v0.16b, v23.8h, #0x2
dup	v1.16b, v30.b[12]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag2_y_mid_start
sum_uv_420_lag2_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
add	x12, x19, #0x52
ld1	{ v22.16b, v23.16b }, [x19], #32
ld1	{ v24.16b, v25.16b }, [x12]
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
saddlp	v24.8h, v24.16b
saddlp	v25.8h, v25.16b
add	v22.8h, v22.8h, v24.8h
add	v23.8h, v23.8h, v25.8h
rshrn	v0.8b, v22.8h, #0x2
rshrn2	v0.16b, v23.8h, #0x2
dup	v1.16b, v30.b[12]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
sum_lag2_uv_420_right_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v4.16b
mov	w15, #0x4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v5.16b
mov	w15, #0x4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v6.16b
mov	w15, #0x1
bl	output_lag2_neon
lsr	w2, w2, #3
ubfx	x12, x2, #3, #11
ubfx	x13, x2, #4, #11
ubfx	x14, x2, #5, #11
add	x12, x3, x12, lsl #1
add	x13, x3, x13, lsl #1
add	x14, x3, x14, lsl #1
ld1	{ v1.h }[0], [x12]
ld1	{ v1.h }[1], [x13]
ld1	{ v1.h }[2], [x14]
srshl	v1.4h, v1.4h, v31.4h
xtn	v1.8b, v1.8h
ext	v0.16b, v0.16b, v1.16b, #0x7
st1	{ v0.16b }, [x0], #16
ldr	x30, [sp], #0x10
ret
sum_lag3_above_neon:
sub	x11, x0, #0xe6
sub	x12, x0, #0x94
sub	x13, x0, #0x42
ld1	{ v15.16b }, [x11]
ld1	{ v18.16b }, [x12]
ld1	{ v21.16b }, [x13]
ext	v8.16b, v13.16b, v14.16b, #0xd
dup	v22.16b, v29.b[0]
ext	v9.16b, v13.16b, v14.16b, #0xe
dup	v23.16b, v29.b[1]
ext	v10.16b, v13.16b, v14.16b, #0xf
dup	v24.16b, v29.b[2]
dup	v25.16b, v29.b[3]
ext	v11.16b, v14.16b, v15.16b, #0x1
dup	v26.16b, v29.b[4]
ext	v12.16b, v14.16b, v15.16b, #0x2
dup	v27.16b, v29.b[5]
ext	v13.16b, v14.16b, v15.16b, #0x3
dup	v28.16b, v29.b[6]
smull	v0.8h, v8.8b, v22.8b
smull2	v1.8h, v8.16b, v22.16b
smull	v2.8h, v9.8b, v23.8b
smull2	v3.8h, v9.16b, v23.16b
smull	v8.8h, v10.8b, v24.8b
smull2	v9.8h, v10.16b, v24.16b
smull	v10.8h, v11.8b, v26.8b
smull2	v11.8h, v11.16b, v26.16b
saddl	v22.4s, v0.4h, v2.4h
saddl2	v23.4s, v0.8h, v2.8h
saddl	v24.4s, v1.4h, v3.4h
saddl2	v26.4s, v1.8h, v3.8h
saddl	v0.4s, v8.4h, v10.4h
saddl2	v1.4s, v8.8h, v10.8h
saddl	v2.4s, v9.4h, v11.4h
saddl2	v3.4s, v9.8h, v11.8h
smull	v8.8h, v12.8b, v27.8b
smull2	v9.8h, v12.16b, v27.16b
smull	v10.8h, v13.8b, v28.8b
smull2	v11.8h, v13.16b, v28.16b
smull	v12.8h, v14.8b, v25.8b
smull2	v13.8h, v14.16b, v25.16b
add	v4.4s, v22.4s, v0.4s
add	v5.4s, v23.4s, v1.4s
add	v6.4s, v24.4s, v2.4s
add	v7.4s, v26.4s, v3.4s
saddl	v0.4s, v8.4h, v10.4h
saddl2	v1.4s, v8.8h, v10.8h
saddl	v2.4s, v9.4h, v11.4h
saddl2	v3.4s, v9.8h, v11.8h
add	v4.4s, v4.4s, v0.4s
add	v5.4s, v5.4s, v1.4s
add	v6.4s, v6.4s, v2.4s
add	v7.4s, v7.4s, v3.4s
saddw	v4.4s, v4.4s, v12.4h
saddw2	v5.4s, v5.4s, v12.8h
saddw	v6.4s, v6.4s, v13.4h
saddw2	v7.4s, v7.4s, v13.8h
ext	v8.16b, v16.16b, v17.16b, #0xd
dup	v22.16b, v29.b[7]
ext	v9.16b, v16.16b, v17.16b, #0xe
dup	v23.16b, v29.b[8]
ext	v10.16b, v16.16b, v17.16b, #0xf
dup	v24.16b, v29.b[9]
dup	v25.16b, v29.b[10]
ext	v11.16b, v17.16b, v18.16b, #0x1
dup	v26.16b, v29.b[11]
ext	v12.16b, v17.16b, v18.16b, #0x2
dup	v27.16b, v29.b[12]
ext	v13.16b, v17.16b, v18.16b, #0x3
dup	v28.16b, v29.b[13]
smull	v0.8h, v8.8b, v22.8b
smull2	v1.8h, v8.16b, v22.16b
smull	v2.8h, v9.8b, v23.8b
smull2	v3.8h, v9.16b, v23.16b
smull	v8.8h, v10.8b, v24.8b
smull2	v9.8h, v10.16b, v24.16b
smull	v10.8h, v11.8b, v26.8b
smull2	v11.8h, v11.16b, v26.16b
saddl	v22.4s, v0.4h, v2.4h
saddl2	v23.4s, v0.8h, v2.8h
saddl	v24.4s, v1.4h, v3.4h
saddl2	v26.4s, v1.8h, v3.8h
saddl	v0.4s, v8.4h, v10.4h
saddl2	v1.4s, v8.8h, v10.8h
saddl	v2.4s, v9.4h, v11.4h
saddl2	v3.4s, v9.8h, v11.8h
smull	v8.8h, v12.8b, v27.8b
smull2	v9.8h, v12.16b, v27.16b
smull	v10.8h, v13.8b, v28.8b
smull2	v11.8h, v13.16b, v28.16b
smull	v12.8h, v17.8b, v25.8b
smull2	v13.8h, v17.16b, v25.16b
add	v22.4s, v22.4s, v0.4s
add	v23.4s, v23.4s, v1.4s
add	v24.4s, v24.4s, v2.4s
add	v26.4s, v26.4s, v3.4s
saddl	v0.4s, v8.4h, v10.4h
saddl2	v1.4s, v8.8h, v10.8h
saddl	v2.4s, v9.4h, v11.4h
saddl2	v3.4s, v9.8h, v11.8h
add	v4.4s, v4.4s, v22.4s
add	v5.4s, v5.4s, v23.4s
add	v6.4s, v6.4s, v24.4s
add	v7.4s, v7.4s, v26.4s
add	v4.4s, v4.4s, v0.4s
add	v5.4s, v5.4s, v1.4s
add	v6.4s, v6.4s, v2.4s
add	v7.4s, v7.4s, v3.4s
saddw	v4.4s, v4.4s, v12.4h
saddw2	v5.4s, v5.4s, v12.8h
saddw	v6.4s, v6.4s, v13.4h
saddw2	v7.4s, v7.4s, v13.8h
ext	v8.16b, v19.16b, v20.16b, #0xd
dup	v22.16b, v29.b[14]
ext	v9.16b, v19.16b, v20.16b, #0xe
dup	v23.16b, v29.b[15]
ext	v10.16b, v19.16b, v20.16b, #0xf
dup	v24.16b, v30.b[0]
dup	v25.16b, v30.b[1]
ext	v11.16b, v20.16b, v21.16b, #0x1
dup	v26.16b, v30.b[2]
ext	v12.16b, v20.16b, v21.16b, #0x2
dup	v27.16b, v30.b[3]
ext	v13.16b, v20.16b, v21.16b, #0x3
dup	v28.16b, v30.b[4]
smull	v0.8h, v8.8b, v22.8b
smull2	v1.8h, v8.16b, v22.16b
smull	v2.8h, v9.8b, v23.8b
smull2	v3.8h, v9.16b, v23.16b
smull	v8.8h, v10.8b, v24.8b
smull2	v9.8h, v10.16b, v24.16b
smull	v10.8h, v11.8b, v26.8b
smull2	v11.8h, v11.16b, v26.16b
saddl	v22.4s, v0.4h, v2.4h
saddl2	v23.4s, v0.8h, v2.8h
saddl	v24.4s, v1.4h, v3.4h
saddl2	v26.4s, v1.8h, v3.8h
saddl	v0.4s, v8.4h, v10.4h
saddl2	v1.4s, v8.8h, v10.8h
saddl	v2.4s, v9.4h, v11.4h
saddl2	v3.4s, v9.8h, v11.8h
smull	v8.8h, v12.8b, v27.8b
smull2	v9.8h, v12.16b, v27.16b
smull	v10.8h, v13.8b, v28.8b
smull2	v11.8h, v13.16b, v28.16b
smull	v12.8h, v20.8b, v25.8b
smull2	v19.8h, v20.16b, v25.16b
add	v22.4s, v22.4s, v0.4s
add	v23.4s, v23.4s, v1.4s
add	v24.4s, v24.4s, v2.4s
add	v26.4s, v26.4s, v3.4s
saddl	v0.4s, v8.4h, v10.4h
saddl2	v1.4s, v8.8h, v10.8h
saddl	v2.4s, v9.4h, v11.4h
saddl2	v3.4s, v9.8h, v11.8h
add	v4.4s, v4.4s, v22.4s
add	v5.4s, v5.4s, v23.4s
add	v6.4s, v6.4s, v24.4s
add	v7.4s, v7.4s, v26.4s
mov	v13.16b, v14.16b
mov	v14.16b, v15.16b
add	v4.4s, v4.4s, v0.4s
add	v5.4s, v5.4s, v1.4s
add	v6.4s, v6.4s, v2.4s
add	v7.4s, v7.4s, v3.4s
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
saddw	v4.4s, v4.4s, v12.4h
saddw2	v5.4s, v5.4s, v12.8h
saddw	v6.4s, v6.4s, v19.4h
saddw2	v7.4s, v7.4s, v19.8h
mov	v19.16b, v20.16b
mov	v20.16b, v21.16b
ret
sum_y_lag3_left_neon:
str	x30, [sp, #-0x10]!
sub	x11, x0, #0xf6
sub	x12, x0, #0xa4
sub	x13, x0, #0x52
ld1	{ v14.16b }, [x11]
ld1	{ v17.16b }, [x12]
ld1	{ v20.16b }, [x13]
bl	sum_lag3_above_neon
sum_lag3_y_left_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
lsr	w2, w2, #4
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #12
ubfx	x12, x2, #2, #11
ubfx	x13, x2, #3, #11
ubfx	x14, x2, #4, #11
add	x12, x3, x12, lsl #1
add	x13, x3, x13, lsl #1
add	x14, x3, x14, lsl #1
ld1	{ v0.h }[5], [x12]
ld1	{ v0.h }[6], [x13]
ld1	{ v0.h }[7], [x14]
lsl	x2, x2, #1
srshl	v0.8h, v0.8h, v31.8h
xtn2	v0.16b, v0.8h
ext	v4.16b, v4.16b, v4.16b, #0xc
smov	w17, v0.b[13]
smov	w16, v0.b[14]
smov	w14, v0.b[15]
mov	v1.16b, v4.16b
mov	w15, #0x1
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v5.16b
mov	w15, #0x4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v6.16b
mov	w15, #0x4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v7.16b
mov	w15, #0x4
bl	output_lag3_neon
st1	{ v0.16b }, [x0], #16
ldr	x30, [sp], #0x10
ret
sum_y_lag3_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
sum_lag3_y_mid_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v4.16b
mov	w15, #0x4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v5.16b
mov	w15, #0x4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v6.16b
mov	w15, #0x4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v7.16b
mov	w15, #0x4
bl	output_lag3_neon
st1	{ v0.16b }, [x0], #16
ldr	x30, [sp], #0x10
ret
sum_y_lag3_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
sum_lag3_y_right_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v4.16b
mov	w15, #0x4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v5.16b
mov	w15, #0x4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v6.16b
mov	w15, #0x4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v7.16b
mov	w15, #0x3
bl	output_lag3_neon
ubfx	x15, x2, #6, #11
lsr	w2, w2, #1
add	x15, x3, x15, lsl #1
ld1	{ v1.h }[0], [x15]
srshl	v1.4h, v1.4h, v31.4h
ext	v0.16b, v0.16b, v1.16b, #0x1
st1	{ v0.16b }, [x0], #16
ldr	x30, [sp], #0x10
ret
sum_uv_444_lag3_left_neon:
str	x30, [sp, #-0x10]!
sub	x11, x0, #0xf6
sub	x12, x0, #0xa4
sub	x13, x0, #0x52
ld1	{ v14.16b }, [x11]
ld1	{ v17.16b }, [x12]
ld1	{ v20.16b }, [x13]
bl	sum_lag3_above_neon
ld1	{ v0.16b }, [x19], #16
dup	v1.16b, v30.b[8]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag3_y_left_start
sum_uv_444_lag3_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
ld1	{ v0.16b }, [x19], #16
dup	v1.16b, v30.b[8]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag3_y_mid_start
sum_uv_444_lag3_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
ld1	{ v0.16b }, [x19], #16
dup	v1.16b, v30.b[8]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag3_y_right_start
sum_uv_422_lag3_left_neon:
str	x30, [sp, #-0x10]!
sub	x11, x0, #0xf6
sub	x12, x0, #0xa4
sub	x13, x0, #0x52
ld1	{ v14.16b }, [x11]
ld1	{ v17.16b }, [x12]
ld1	{ v20.16b }, [x13]
bl	sum_lag3_above_neon
ld1	{ v22.16b, v23.16b }, [x19], #32
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
rshrn	v0.8b, v22.8h, #0x1
rshrn2	v0.16b, v23.8h, #0x1
dup	v1.16b, v30.b[8]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag3_y_left_start
sum_uv_422_lag3_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
ld1	{ v22.16b, v23.16b }, [x19], #32
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
rshrn	v0.8b, v22.8h, #0x1
rshrn2	v0.16b, v23.8h, #0x1
dup	v1.16b, v30.b[8]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag3_y_mid_start
sum_uv_422_lag3_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
ld1	{ v22.16b, v23.16b }, [x19], #32
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
rshrn	v0.8b, v22.8h, #0x1
rshrn2	v0.16b, v23.8h, #0x1
dup	v1.16b, v30.b[8]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag3_uv_420_right_start
sum_uv_420_lag3_left_neon:
str	x30, [sp, #-0x10]!
sub	x11, x0, #0xf6
sub	x12, x0, #0xa4
sub	x13, x0, #0x52
ld1	{ v14.16b }, [x11]
ld1	{ v17.16b }, [x12]
ld1	{ v20.16b }, [x13]
bl	sum_lag3_above_neon
add	x12, x19, #0x52
ld1	{ v22.16b, v23.16b }, [x19], #32
ld1	{ v24.16b, v25.16b }, [x12]
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
saddlp	v24.8h, v24.16b
saddlp	v25.8h, v25.16b
add	v22.8h, v22.8h, v24.8h
add	v23.8h, v23.8h, v25.8h
rshrn	v0.8b, v22.8h, #0x2
rshrn2	v0.16b, v23.8h, #0x2
dup	v1.16b, v30.b[8]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag3_y_left_start
sum_uv_420_lag3_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
add	x12, x19, #0x52
ld1	{ v22.16b, v23.16b }, [x19], #32
ld1	{ v24.16b, v25.16b }, [x12]
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
saddlp	v24.8h, v24.16b
saddlp	v25.8h, v25.16b
add	v22.8h, v22.8h, v24.8h
add	v23.8h, v23.8h, v25.8h
rshrn	v0.8b, v22.8h, #0x2
rshrn2	v0.16b, v23.8h, #0x2
dup	v1.16b, v30.b[8]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
b	sum_lag3_y_mid_start
sum_uv_420_lag3_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
add	x12, x19, #0x52
ld1	{ v22.16b, v23.16b }, [x19], #32
ld1	{ v24.16b, v25.16b }, [x12]
saddlp	v22.8h, v22.16b
saddlp	v23.8h, v23.16b
saddlp	v24.8h, v24.16b
saddlp	v25.8h, v25.16b
add	v22.8h, v22.8h, v24.8h
add	v23.8h, v23.8h, v25.8h
rshrn	v0.8b, v22.8h, #0x2
rshrn2	v0.16b, v23.8h, #0x2
dup	v1.16b, v30.b[8]
smull	v2.8h, v0.8b, v1.8b
smull2	v3.8h, v0.16b, v1.16b
saddw	v4.4s, v4.4s, v2.4h
saddw2	v5.4s, v5.4s, v2.8h
saddw	v6.4s, v6.4s, v3.4h
saddw2	v7.4s, v7.4s, v3.8h
sum_lag3_uv_420_right_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v4.16b
mov	w15, #0x4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v5.16b
mov	w15, #0x4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov	v1.16b, v6.16b
mov	w15, #0x1
bl	output_lag3_neon
lsr	w2, w2, #3
ubfx	x12, x2, #3, #11
ubfx	x13, x2, #4, #11
ubfx	x14, x2, #5, #11
add	x12, x3, x12, lsl #1
add	x13, x3, x13, lsl #1
add	x14, x3, x14, lsl #1
ld1	{ v1.h }[0], [x12]
ld1	{ v1.h }[1], [x13]
ld1	{ v1.h }[2], [x14]
srshl	v1.4h, v1.4h, v31.4h
xtn	v1.8b, v1.8h
ext	v0.16b, v0.16b, v1.16b, #0x7
st1	{ v0.16b }, [x0], #16
ldr	x30, [sp], #0x10
ret
generate_grain_rows_neon:
str	x30, [sp, #-0x10]!
L_1774:
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn	v16.8b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn2	v16.16b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn	v17.8b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn2	v17.16b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn	v18.8b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn2	v18.16b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn	v19.8b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn2	v19.16b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn	v20.8b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn2	v20.16b, v21.8h
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
lsr	w2, w2, #2
and	w11, w11, #0x3
orr	w2, w2, w11, lsl #14
ubfx	x14, x2, #4, #11
ubfx	x15, x2, #5, #11
add	x14, x3, x14, lsl #1
add	x15, x3, x15, lsl #1
ld1	{ v21.h }[0], [x14]
ld1	{ v21.h }[1], [x15]
srshl	v0.4h, v21.4h, v31.4h
xtn	v21.8b, v0.8h
subs	w1, w1, #0x1
st1	{ v16.16b, v17.16b }, [x0], #32
st1	{ v18.16b, v19.16b }, [x0], #32
st1	{ v20.16b }, [x0], #16
st1	{ v21.h }[0], [x0], #2
b.gt	L_1774
ldr	x30, [sp], #0x10
ret
generate_grain_rows_44_neon:
str	x30, [sp, #-0x10]!
L_1854:
bl	get_gaussian_neon
srshl	v18.8h, v0.8h, v31.8h
xtn	v16.8b, v18.8h
bl	get_gaussian_neon
srshl	v18.8h, v0.8h, v31.8h
xtn2	v16.16b, v18.8h
bl	get_gaussian_neon
srshl	v18.8h, v0.8h, v31.8h
xtn	v17.8b, v18.8h
bl	get_gaussian_neon
srshl	v18.8h, v0.8h, v31.8h
xtn2	v17.16b, v18.8h
bl	get_gaussian_neon
srshl	v18.8h, v0.8h, v31.8h
xtn	v18.8b, v18.8h
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
lsr	w2, w2, #4
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #12
ubfx	x14, x2, #2, #11
ubfx	x15, x2, #3, #11
add	x14, x3, x14, lsl #1
add	x15, x3, x15, lsl #1
ld1	{ v0.h }[0], [x14]
ubfx	x14, x2, #4, #11
ld1	{ v0.h }[1], [x15]
ubfx	x15, x2, #5, #11
add	x14, x3, x14, lsl #1
add	x15, x3, x15, lsl #1
ld1	{ v0.h }[2], [x14]
ld1	{ v0.h }[3], [x15]
srshl	v0.4h, v0.4h, v31.4h
xtn2	v18.16b, v0.8h
subs	w1, w1, #0x1
st1	{ v16.16b, v17.16b }, [x0], #32
st1	{ v18.16b }, [x0]
add	x0, x0, #0x32
b.gt	L_1854
ldr	x30, [sp], #0x10
ret
get_grain_row_neon:
str	x30, [sp, #-0x10]!
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn	v16.8b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn2	v16.16b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn	v17.8b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn2	v17.16b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn	v18.8b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn2	v18.16b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn	v19.8b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn2	v19.16b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn	v20.8b, v21.8h
bl	get_gaussian_neon
srshl	v21.8h, v0.8h, v31.8h
xtn2	v20.16b, v21.8h
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
lsr	w2, w2, #2
and	w11, w11, #0x3
orr	w2, w2, w11, lsl #14
ubfx	x14, x2, #4, #11
ubfx	x15, x2, #5, #11
add	x14, x3, x14, lsl #1
add	x15, x3, x15, lsl #1
ld1	{ v21.h }[0], [x14]
ld1	{ v21.h }[1], [x15]
srshl	v0.4h, v21.4h, v31.4h
xtn	v21.8b, v0.8h
ldr	x30, [sp], #0x10
ret
get_grain_row_44_neon:
str	x30, [sp, #-0x10]!
bl	get_gaussian_neon
srshl	v18.8h, v0.8h, v31.8h
xtn	v16.8b, v18.8h
bl	get_gaussian_neon
srshl	v18.8h, v0.8h, v31.8h
xtn2	v16.16b, v18.8h
bl	get_gaussian_neon
srshl	v18.8h, v0.8h, v31.8h
xtn	v17.8b, v18.8h
bl	get_gaussian_neon
srshl	v18.8h, v0.8h, v31.8h
xtn2	v17.16b, v18.8h
bl	get_gaussian_neon
srshl	v18.8h, v0.8h, v31.8h
xtn	v18.8b, v18.8h
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
lsr	w2, w2, #4
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #12
ubfx	x14, x2, #2, #11
ubfx	x15, x2, #3, #11
add	x14, x3, x14, lsl #1
add	x15, x3, x15, lsl #1
ld1	{ v0.h }[0], [x14]
ubfx	x14, x2, #4, #11
ld1	{ v0.h }[1], [x15]
ubfx	x15, x2, #5, #11
add	x14, x3, x14, lsl #1
add	x15, x3, x15, lsl #1
ld1	{ v0.h }[2], [x14]
ld1	{ v0.h }[3], [x15]
srshl	v0.4h, v0.4h, v31.4h
xtn2	v18.16b, v0.8h
ldr	x30, [sp], #0x10
ret
add_uv_444_coeff_lag0_neon:
add_coeff_lag0_start:
smull	v2.8h, v0.8b, v27.8b
smull2	v3.8h, v0.16b, v27.16b
srshl	v2.8h, v2.8h, v28.8h
srshl	v3.8h, v3.8h, v28.8h
saddw	v2.8h, v2.8h, v1.8b
saddw2	v3.8h, v3.8h, v1.16b
sqxtn	v2.8b, v2.8h
sqxtn2	v2.16b, v3.8h
ret
add_uv_420_coeff_lag0_neon:
ld1	{ v4.16b, v5.16b }, [x19], #32
ld1	{ v6.16b, v7.16b }, [x12], #32
saddlp	v4.8h, v4.16b
saddlp	v5.8h, v5.16b
saddlp	v6.8h, v6.16b
saddlp	v7.8h, v7.16b
add	v4.8h, v4.8h, v6.8h
add	v5.8h, v5.8h, v7.8h
rshrn	v4.8b, v4.8h, #0x2
rshrn2	v4.16b, v5.8h, #0x2
and	v0.16b, v4.16b, v0.16b
b	add_uv_444_coeff_lag0_neon
add_uv_422_coeff_lag0_neon:
ld1	{ v4.16b, v5.16b }, [x19], #32
saddlp	v4.8h, v4.16b
saddlp	v5.8h, v5.16b
rshrn	v4.8b, v4.8h, #0x1
rshrn2	v4.16b, v5.8h, #0x1
and	v0.16b, v4.16b, v0.16b
b	add_uv_444_coeff_lag0_neon
generate_grain_y_8bpc_neon:
stp	x30, x19, [sp, #-0x60]!
adrp	x3, gaussian_sequence
add	x3, x3, :lo12:gaussian_sequence
ldr	w2, [x1]
ldr	w9, [x1, #0xb8]
add	x4, x1, #0x60
adrp	x16, gen_grain_y_tbl
add	x16, x16, :lo12:gen_grain_y_tbl
ldr	w17, [x1, #0x5c]
add	w9, w9, #0x4
ldrsw	x17, [x16, w17, uxtw #2]
dup	v31.8h, w9
add	x16, x16, x17
neg	v31.8h, v31.8h
ldr	w7, [x1, #0xb0]
mov	w8, #0x1
mov	w10, #0x1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #0x7f
mov	w6, #-0x80
br	x16
L_1b44:
mov	w1, #0x49
bl	generate_grain_rows_neon
ldp	x30, x19, [sp], #0x60
ret
L_1b54:
ld1r	{ v27.16b }, [x4], #1
ld1r	{ v28.16b }, [x4], #1
ld1r	{ v29.16b }, [x4]
ldrsb	w4, [x4, #0x1]
mov	w1, #0x3
bl	generate_grain_rows_neon
mov	w1, #0x46
L_1b70:
mov	v3.16b, v16.16b
ext	v0.16b, v16.16b, v16.16b, #0xf
ext	v1.16b, v16.16b, v17.16b, #0x1
bl	sum_y_lag1_left_neon
mov	v22.16b, v0.16b
mov	v3.16b, v17.16b
ext	v0.16b, v16.16b, v17.16b, #0xf
ext	v1.16b, v17.16b, v18.16b, #0x1
bl	sum_y_lag1_mid_neon
mov	v23.16b, v0.16b
mov	v3.16b, v18.16b
ext	v0.16b, v17.16b, v18.16b, #0xf
ext	v1.16b, v18.16b, v19.16b, #0x1
bl	sum_y_lag1_mid_neon
mov	v24.16b, v0.16b
mov	v3.16b, v19.16b
ext	v0.16b, v18.16b, v19.16b, #0xf
ext	v1.16b, v19.16b, v20.16b, #0x1
bl	sum_y_lag1_mid_neon
mov	v25.16b, v0.16b
mov	v3.16b, v20.16b
ext	v0.16b, v19.16b, v20.16b, #0xf
ext	v1.16b, v20.16b, v21.16b, #0x1
bl	sum_y_lag1_right_neon
mov	v20.16b, v0.16b
bl	get_grain_2_neon
mov	v21.8b, v0.8b
subs	w1, w1, #0x1
st1	{ v22.16b, v23.16b }, [x0], #32
st1	{ v24.16b, v25.16b }, [x0], #32
st1	{ v20.16b }, [x0], #16
st1	{ v21.h }[0], [x0], #2
mov	v16.16b, v22.16b
mov	v17.16b, v23.16b
mov	v18.16b, v24.16b
mov	v19.16b, v25.16b
b.gt	L_1b70
ldp	x30, x19, [sp], #0x60
ret
L_1c0c:
ld1	{ v30.16b }, [x4]
smov	w4, v30.b[10]
smov	w17, v30.b[11]
mov	w1, #0x3
bl	generate_grain_rows_neon
mov	w1, #0x46
L_1c24:
bl	sum_y_lag2_left_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_right_neon
bl	get_grain_2_neon
mov	v16.8b, v0.8b
subs	w1, w1, #0x1
st1	{ v16.h }[0], [x0], #2
b.gt	L_1c24
ldp	x30, x19, [sp], #0x60
ret
L_1c54:
ld1	{ v29.16b, v30.16b }, [x4]
stp	d8, d9, [sp, #0x10]
stp	d10, d11, [sp, #0x20]
stp	d12, d13, [sp, #0x30]
stp	d14, d15, [sp, #0x40]
stp	x20, x21, [sp, #0x50]
smov	w4, v30.b[5]
smov	w20, v30.b[6]
smov	w21, v30.b[7]
mov	w1, #0x3
bl	generate_grain_rows_neon
mov	w1, #0x46
L_1c84:
bl	sum_y_lag3_left_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_right_neon
bl	get_grain_2_neon
mov	v16.8b, v0.8b
subs	w1, w1, #0x1
st1	{ v16.h }[0], [x0], #2
b.gt	L_1c84
ldp	x20, x21, [sp, #0x50]
ldp	d14, d15, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldp	x30, x19, [sp], #0x60
ret
generate_grain_uv_444_8bpc_neon:
stp	x30, x19, [sp, #-0x60]!
mov	w13, w3
mov	w14, #0x1c
add	x19, x1, #0xf6
mov	x1, x2
mul	w13, w13, w14
adrp	x3, gaussian_sequence
add	x3, x3, :lo12:gaussian_sequence
ldr	w2, [x1]
ldr	w9, [x1, #0xb8]
add	x4, x1, #0x78
adrp	x16, gen_grain_uv_444_tbl
add	x16, x16, :lo12:gen_grain_uv_444_tbl
ldr	w17, [x1, #0x5c]
add	w9, w9, #0x4
ldrsw	x17, [x16, w17, uxtw #2]
dup	v31.8h, w9
add	x16, x16, x17
neg	v31.8h, v31.8h
cmp	w13, #0x0
mov	w11, #0x49d8
mov	w14, #0xb524
add	x4, x4, w13, uxtw
csel	w11, w11, w14, ne
ldr	w7, [x1, #0xb0]
mov	w8, #0x1
mov	w10, #0x1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #0x7f
mov	w6, #-0x80
eor	w2, w2, w11
br	x16
L_1d54:
dup	v28.8h, w7
ld1r	{ v27.16b }, [x4]
movi	v0.16b, #0x0
movi	v1.16b, #0xff
ext	v29.16b, v0.16b, v1.16b, #0xd
ext	v30.16b, v1.16b, v0.16b, #0x1
neg	v28.8h, v28.8h
mov	w1, #0x3
bl	generate_grain_rows_neon
mov	w1, #0x46
L_1d7c:
ld1	{ v22.16b, v23.16b, v24.16b, v25.16b }, [x19], #64
bl	get_grain_row_neon
and	v0.16b, v22.16b, v29.16b
mov	v1.16b, v16.16b
bl	add_uv_444_coeff_lag0_neon
mov	v0.16b, v23.16b
mov	v1.16b, v17.16b
mov	v16.16b, v2.16b
bl	add_uv_444_coeff_lag0_neon
ld1	{ v26.16b }, [x19], #16
mov	v0.16b, v24.16b
mov	v1.16b, v18.16b
mov	v17.16b, v2.16b
bl	add_uv_444_coeff_lag0_neon
add	x19, x19, #0x2
mov	v0.16b, v25.16b
mov	v1.16b, v19.16b
mov	v18.16b, v2.16b
bl	add_uv_444_coeff_lag0_neon
and	v0.16b, v26.16b, v30.16b
mov	v1.16b, v20.16b
mov	v19.16b, v2.16b
bl	add_uv_444_coeff_lag0_neon
mov	v20.16b, v2.16b
subs	w1, w1, #0x1
st1	{ v16.16b, v17.16b }, [x0], #32
st1	{ v18.16b, v19.16b }, [x0], #32
st1	{ v20.16b }, [x0], #16
st1	{ v21.h }[0], [x0], #2
b.gt	L_1d7c
ldp	x30, x19, [sp], #0x60
ret
L_1dfc:
ld1r	{ v27.16b }, [x4], #1
ld1r	{ v28.16b }, [x4], #1
ld1r	{ v29.16b }, [x4]
add	x4, x4, #0x2
mov	w1, #0x3
ld1r	{ v30.16b }, [x4]
ldursb	w4, [x4, #-0x1]
bl	generate_grain_rows_neon
mov	w1, #0x46
L_1e20:
mov	v3.16b, v16.16b
ext	v0.16b, v16.16b, v16.16b, #0xf
ext	v1.16b, v16.16b, v17.16b, #0x1
bl	sum_uv_444_lag1_left_neon
mov	v22.16b, v0.16b
mov	v3.16b, v17.16b
ext	v0.16b, v16.16b, v17.16b, #0xf
ext	v1.16b, v17.16b, v18.16b, #0x1
bl	sum_uv_444_lag1_mid_neon
mov	v23.16b, v0.16b
mov	v3.16b, v18.16b
ext	v0.16b, v17.16b, v18.16b, #0xf
ext	v1.16b, v18.16b, v19.16b, #0x1
bl	sum_uv_444_lag1_mid_neon
mov	v24.16b, v0.16b
mov	v3.16b, v19.16b
ext	v0.16b, v18.16b, v19.16b, #0xf
ext	v1.16b, v19.16b, v20.16b, #0x1
bl	sum_uv_444_lag1_mid_neon
mov	v25.16b, v0.16b
mov	v3.16b, v20.16b
ext	v0.16b, v19.16b, v20.16b, #0xf
ext	v1.16b, v20.16b, v21.16b, #0x1
bl	sum_uv_444_lag1_right_neon
mov	v20.16b, v0.16b
bl	get_grain_2_neon
mov	v21.8b, v0.8b
subs	w1, w1, #0x1
add	x19, x19, #0x2
st1	{ v22.16b, v23.16b }, [x0], #32
st1	{ v24.16b, v25.16b }, [x0], #32
st1	{ v20.16b }, [x0], #16
st1	{ v21.h }[0], [x0], #2
mov	v16.16b, v22.16b
mov	v17.16b, v23.16b
mov	v18.16b, v24.16b
mov	v19.16b, v25.16b
b.gt	L_1e20
ldp	x30, x19, [sp], #0x60
ret
L_1ec0:
ld1	{ v30.16b }, [x4]
smov	w4, v30.b[10]
smov	w17, v30.b[11]
mov	w1, #0x3
bl	generate_grain_rows_neon
mov	w1, #0x46
L_1ed8:
bl	sum_uv_444_lag2_left_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_right_neon
bl	get_grain_2_neon
mov	v16.8b, v0.8b
subs	w1, w1, #0x1
add	x19, x19, #0x2
st1	{ v16.h }[0], [x0], #2
b.gt	L_1ed8
ldp	x30, x19, [sp], #0x60
ret
L_1f0c:
ld1	{ v29.16b, v30.16b }, [x4]
stp	d8, d9, [sp, #0x10]
stp	d10, d11, [sp, #0x20]
stp	d12, d13, [sp, #0x30]
stp	d14, d15, [sp, #0x40]
stp	x20, x21, [sp, #0x50]
smov	w4, v30.b[5]
smov	w20, v30.b[6]
smov	w21, v30.b[7]
mov	w1, #0x3
bl	generate_grain_rows_neon
mov	w1, #0x46
L_1f3c:
bl	sum_uv_444_lag3_left_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_right_neon
bl	get_grain_2_neon
mov	v16.8b, v0.8b
subs	w1, w1, #0x1
add	x19, x19, #0x2
st1	{ v16.h }[0], [x0], #2
b.gt	L_1f3c
ldp	x20, x21, [sp, #0x50]
ldp	d14, d15, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldp	x30, x19, [sp], #0x60
ret
generate_grain_uv_420_8bpc_neon:
stp	x30, x19, [sp, #-0x60]!
mov	w13, w3
mov	w14, #0x1c
add	x19, x1, #0xf3
mov	x1, x2
mul	w13, w13, w14
adrp	x3, gaussian_sequence
add	x3, x3, :lo12:gaussian_sequence
ldr	w2, [x1]
ldr	w9, [x1, #0xb8]
add	x4, x1, #0x78
adrp	x16, gen_grain_uv_420_tbl
add	x16, x16, :lo12:gen_grain_uv_420_tbl
ldr	w17, [x1, #0x5c]
add	w9, w9, #0x4
ldrsw	x17, [x16, w17, uxtw #2]
dup	v31.8h, w9
add	x16, x16, x17
neg	v31.8h, v31.8h
cmp	w13, #0x0
mov	w11, #0x49d8
mov	w14, #0xb524
add	x4, x4, w13, uxtw
csel	w11, w11, w14, ne
ldr	w7, [x1, #0xb0]
mov	w8, #0x1
mov	w10, #0x1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #0x7f
mov	w6, #-0x80
eor	w2, w2, w11
br	x16
L_2010:
dup	v28.8h, w7
ld1r	{ v27.16b }, [x4]
movi	v0.16b, #0x0
movi	v1.16b, #0xff
ext	v29.16b, v0.16b, v1.16b, #0xd
ext	v30.16b, v1.16b, v0.16b, #0x7
neg	v28.8h, v28.8h
mov	w1, #0x3
bl	generate_grain_rows_44_neon
mov	w1, #0x23
L_2038:
bl	get_grain_row_44_neon
add	x12, x19, #0x52
mov	v0.16b, v29.16b
mov	v1.16b, v16.16b
bl	add_uv_420_coeff_lag0_neon
movi	v0.16b, #0xff
mov	v1.16b, v17.16b
mov	v16.16b, v2.16b
bl	add_uv_420_coeff_lag0_neon
mov	v0.16b, v30.16b
mov	v1.16b, v18.16b
mov	v17.16b, v2.16b
bl	add_uv_420_coeff_lag0_neon
mov	v18.16b, v2.16b
subs	w1, w1, #0x1
add	x19, x19, #0x44
st1	{ v16.16b, v17.16b }, [x0], #32
st1	{ v18.16b }, [x0]
add	x0, x0, #0x32
b.gt	L_2038
ldp	x30, x19, [sp], #0x60
ret
L_2090:
ld1r	{ v27.16b }, [x4], #1
ld1r	{ v28.16b }, [x4], #1
ld1r	{ v29.16b }, [x4]
add	x4, x4, #0x2
mov	w1, #0x3
ld1r	{ v30.16b }, [x4]
ldursb	w4, [x4, #-0x1]
bl	generate_grain_rows_44_neon
mov	w1, #0x23
L_20b4:
mov	v3.16b, v16.16b
ext	v0.16b, v16.16b, v16.16b, #0xf
ext	v1.16b, v16.16b, v17.16b, #0x1
bl	sum_uv_420_lag1_left_neon
mov	v20.16b, v0.16b
mov	v3.16b, v17.16b
ext	v0.16b, v16.16b, v17.16b, #0xf
ext	v1.16b, v17.16b, v18.16b, #0x1
bl	sum_uv_420_lag1_mid_neon
mov	v21.16b, v0.16b
mov	v3.16b, v18.16b
ext	v0.16b, v17.16b, v18.16b, #0xf
ext	v1.16b, v18.16b, v18.16b, #0x1
bl	sum_uv_420_lag1_right_neon
mov	v18.16b, v0.16b
subs	w1, w1, #0x1
add	x19, x19, #0x44
st1	{ v20.16b, v21.16b }, [x0], #32
st1	{ v18.16b }, [x0]
add	x0, x0, #0x32
mov	v16.16b, v20.16b
mov	v17.16b, v21.16b
b.gt	L_20b4
ldp	x30, x19, [sp], #0x60
ret
L_2118:
ld1	{ v30.16b }, [x4]
smov	w4, v30.b[10]
smov	w17, v30.b[11]
mov	w1, #0x3
bl	generate_grain_rows_44_neon
mov	w1, #0x23
L_2130:
bl	sum_uv_420_lag2_left_neon
bl	sum_uv_420_lag2_mid_neon
bl	sum_uv_420_lag2_right_neon
subs	w1, w1, #0x1
add	x19, x19, #0x44
add	x0, x0, #0x22
b.gt	L_2130
ldp	x30, x19, [sp], #0x60
ret
L_2154:
ldr	q29, [x4]
ldr	q30, [x4, #0x10]
stp	d8, d9, [sp, #0x10]
stp	d10, d11, [sp, #0x20]
stp	d12, d13, [sp, #0x30]
stp	d14, d15, [sp, #0x40]
stp	x20, x21, [sp, #0x50]
smov	w4, v30.b[5]
smov	w20, v30.b[6]
smov	w21, v30.b[7]
mov	w1, #0x3
bl	generate_grain_rows_44_neon
mov	w1, #0x23
L_2188:
bl	sum_uv_420_lag3_left_neon
bl	sum_uv_420_lag3_mid_neon
bl	sum_uv_420_lag3_right_neon
subs	w1, w1, #0x1
add	x19, x19, #0x44
add	x0, x0, #0x22
b.gt	L_2188
ldp	x20, x21, [sp, #0x50]
ldp	d14, d15, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldp	x30, x19, [sp], #0x60
ret
generate_grain_uv_422_8bpc_neon:
stp	x30, x19, [sp, #-0x60]!
mov	w13, w3
mov	w14, #0x1c
add	x19, x1, #0xf3
mov	x1, x2
mul	w13, w13, w14
adrp	x3, gaussian_sequence
add	x3, x3, :lo12:gaussian_sequence
ldr	w2, [x1]
ldr	w9, [x1, #0xb8]
add	x4, x1, #0x78
adrp	x16, gen_grain_uv_422_tbl
add	x16, x16, :lo12:gen_grain_uv_422_tbl
ldr	w17, [x1, #0x5c]
add	w9, w9, #0x4
ldrsw	x17, [x16, w17, uxtw #2]
dup	v31.8h, w9
add	x16, x16, x17
neg	v31.8h, v31.8h
cmp	w13, #0x0
mov	w11, #0x49d8
mov	w14, #0xb524
add	x4, x4, w13, uxtw
csel	w11, w11, w14, ne
ldr	w7, [x1, #0xb0]
mov	w8, #0x1
mov	w10, #0x1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #0x7f
mov	w6, #-0x80
eor	w2, w2, w11
br	x16
L_224c:
dup	v28.8h, w7
ld1r	{ v27.16b }, [x4]
movi	v0.16b, #0x0
movi	v1.16b, #0xff
ext	v29.16b, v0.16b, v1.16b, #0xd
ext	v30.16b, v1.16b, v0.16b, #0x7
neg	v28.8h, v28.8h
mov	w1, #0x3
bl	generate_grain_rows_44_neon
mov	w1, #0x46
L_2274:
bl	get_grain_row_44_neon
mov	v0.16b, v29.16b
mov	v1.16b, v16.16b
bl	add_uv_422_coeff_lag0_neon
movi	v0.16b, #0xff
mov	v1.16b, v17.16b
mov	v16.16b, v2.16b
bl	add_uv_422_coeff_lag0_neon
mov	v0.16b, v30.16b
mov	v1.16b, v18.16b
mov	v17.16b, v2.16b
bl	add_uv_422_coeff_lag0_neon
mov	v18.16b, v2.16b
subs	w1, w1, #0x1
sub	x19, x19, #0xe
st1	{ v16.16b, v17.16b }, [x0], #32
st1	{ v18.16b }, [x0]
add	x0, x0, #0x32
b.gt	L_2274
ldp	x30, x19, [sp], #0x60
ret
L_22c8:
ld1r	{ v27.16b }, [x4], #1
ld1r	{ v28.16b }, [x4], #1
ld1r	{ v29.16b }, [x4]
add	x4, x4, #0x2
mov	w1, #0x3
ld1r	{ v30.16b }, [x4]
ldursb	w4, [x4, #-0x1]
bl	generate_grain_rows_44_neon
mov	w1, #0x46
L_22ec:
mov	v3.16b, v16.16b
ext	v0.16b, v16.16b, v16.16b, #0xf
ext	v1.16b, v16.16b, v17.16b, #0x1
bl	sum_uv_422_lag1_left_neon
mov	v20.16b, v0.16b
mov	v3.16b, v17.16b
ext	v0.16b, v16.16b, v17.16b, #0xf
ext	v1.16b, v17.16b, v18.16b, #0x1
bl	sum_uv_422_lag1_mid_neon
mov	v21.16b, v0.16b
mov	v3.16b, v18.16b
ext	v0.16b, v17.16b, v18.16b, #0xf
ext	v1.16b, v18.16b, v18.16b, #0x1
bl	sum_uv_422_lag1_right_neon
mov	v18.16b, v0.16b
subs	w1, w1, #0x1
sub	x19, x19, #0xe
st1	{ v20.16b, v21.16b }, [x0], #32
st1	{ v18.16b }, [x0]
add	x0, x0, #0x32
mov	v16.16b, v20.16b
mov	v17.16b, v21.16b
b.gt	L_22ec
ldp	x30, x19, [sp], #0x60
ret
L_2350:
ld1	{ v30.16b }, [x4]
smov	w4, v30.b[10]
smov	w17, v30.b[11]
mov	w1, #0x3
bl	generate_grain_rows_44_neon
mov	w1, #0x46
L_2368:
bl	sum_uv_422_lag2_left_neon
bl	sum_uv_422_lag2_mid_neon
bl	sum_uv_422_lag2_right_neon
subs	w1, w1, #0x1
sub	x19, x19, #0xe
add	x0, x0, #0x22
b.gt	L_2368
ldp	x30, x19, [sp], #0x60
ret
L_238c:
ldr	q29, [x4]
ldr	q30, [x4, #0x10]
stp	d8, d9, [sp, #0x10]
stp	d10, d11, [sp, #0x20]
stp	d12, d13, [sp, #0x30]
stp	d14, d15, [sp, #0x40]
stp	x20, x21, [sp, #0x50]
smov	w4, v30.b[5]
smov	w20, v30.b[6]
smov	w21, v30.b[7]
mov	w1, #0x3
bl	generate_grain_rows_44_neon
mov	w1, #0x46
L_23c0:
bl	sum_uv_422_lag3_left_neon
bl	sum_uv_422_lag3_mid_neon
bl	sum_uv_422_lag3_right_neon
subs	w1, w1, #0x1
sub	x19, x19, #0xe
add	x0, x0, #0x22
b.gt	L_23c0
ldp	x20, x21, [sp, #0x50]
ldp	d14, d15, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldp	x30, x19, [sp], #0x60
ret
gather32_neon:
umov	w14, v0.b[0]
umov	w15, v1.b[8]
umov	w16, v0.b[2]
add	x14, x14, x3
umov	w17, v1.b[10]
add	x15, x15, x3
ld1	{ v4.b }[0], [x14]
umov	w14, v0.b[4]
add	x16, x16, x3
ld1	{ v5.b }[8], [x15]
umov	w15, v1.b[12]
add	x17, x17, x3
ld1	{ v4.b }[2], [x16]
umov	w16, v0.b[6]
add	x14, x14, x3
ld1	{ v5.b }[10], [x17]
umov	w17, v1.b[14]
add	x15, x15, x3
ld1	{ v4.b }[4], [x14]
add	x16, x16, x3
ld1	{ v5.b }[12], [x15]
add	x17, x17, x3
ld1	{ v4.b }[6], [x16]
ld1	{ v5.b }[14], [x17]
umov	w14, v1.b[0]
umov	w15, v0.b[8]
umov	w16, v1.b[2]
add	x14, x14, x3
umov	w17, v0.b[10]
add	x15, x15, x3
ld1	{ v5.b }[0], [x14]
umov	w14, v1.b[4]
add	x16, x16, x3
ld1	{ v4.b }[8], [x15]
umov	w15, v0.b[12]
add	x17, x17, x3
ld1	{ v5.b }[2], [x16]
umov	w16, v1.b[6]
add	x14, x14, x3
ld1	{ v4.b }[10], [x17]
umov	w17, v0.b[14]
add	x15, x15, x3
ld1	{ v5.b }[4], [x14]
add	x16, x16, x3
ld1	{ v4.b }[12], [x15]
add	x17, x17, x3
ld1	{ v5.b }[6], [x16]
ld1	{ v4.b }[14], [x17]
umov	w14, v0.b[1]
umov	w15, v1.b[9]
umov	w16, v0.b[3]
add	x14, x14, x3
umov	w17, v1.b[11]
add	x15, x15, x3
ld1	{ v4.b }[1], [x14]
umov	w14, v0.b[5]
add	x16, x16, x3
ld1	{ v5.b }[9], [x15]
umov	w15, v1.b[13]
add	x17, x17, x3
ld1	{ v4.b }[3], [x16]
umov	w16, v0.b[7]
add	x14, x14, x3
ld1	{ v5.b }[11], [x17]
umov	w17, v1.b[15]
add	x15, x15, x3
ld1	{ v4.b }[5], [x14]
add	x16, x16, x3
ld1	{ v5.b }[13], [x15]
add	x17, x17, x3
ld1	{ v4.b }[7], [x16]
ld1	{ v5.b }[15], [x17]
umov	w14, v1.b[1]
umov	w15, v0.b[9]
umov	w16, v1.b[3]
add	x14, x14, x3
umov	w17, v0.b[11]
add	x15, x15, x3
ld1	{ v5.b }[1], [x14]
umov	w14, v1.b[5]
add	x16, x16, x3
ld1	{ v4.b }[9], [x15]
umov	w15, v0.b[13]
add	x17, x17, x3
ld1	{ v5.b }[3], [x16]
umov	w16, v1.b[7]
add	x14, x14, x3
ld1	{ v4.b }[11], [x17]
umov	w17, v0.b[15]
add	x15, x15, x3
ld1	{ v5.b }[5], [x14]
add	x16, x16, x3
ld1	{ v4.b }[13], [x15]
add	x17, x17, x3
ld1	{ v5.b }[7], [x16]
ld1	{ v4.b }[15], [x17]
ret
gather16_neon:
umov	w14, v0.b[0]
umov	w15, v0.b[8]
umov	w16, v0.b[2]
add	x14, x14, x3
umov	w17, v0.b[10]
add	x15, x15, x3
ld1	{ v4.b }[0], [x14]
umov	w14, v0.b[4]
add	x16, x16, x3
ld1	{ v5.b }[8], [x15]
umov	w15, v0.b[12]
add	x17, x17, x3
ld1	{ v4.b }[2], [x16]
umov	w16, v0.b[6]
add	x14, x14, x3
ld1	{ v5.b }[10], [x17]
umov	w17, v0.b[14]
add	x15, x15, x3
ld1	{ v4.b }[4], [x14]
add	x16, x16, x3
ld1	{ v5.b }[12], [x15]
add	x17, x17, x3
ld1	{ v4.b }[6], [x16]
ld1	{ v5.b }[14], [x17]
umov	w14, v0.b[1]
umov	w15, v0.b[9]
umov	w16, v0.b[3]
add	x14, x14, x3
umov	w17, v0.b[11]
add	x15, x15, x3
ld1	{ v4.b }[1], [x14]
umov	w14, v0.b[5]
add	x16, x16, x3
ld1	{ v5.b }[9], [x15]
umov	w15, v0.b[13]
add	x17, x17, x3
ld1	{ v4.b }[3], [x16]
umov	w16, v0.b[7]
add	x14, x14, x3
ld1	{ v5.b }[11], [x17]
umov	w17, v0.b[15]
add	x15, x15, x3
ld1	{ v4.b }[5], [x14]
add	x16, x16, x3
ld1	{ v5.b }[13], [x15]
add	x17, x17, x3
ld1	{ v4.b }[7], [x16]
ld1	{ v5.b }[15], [x17]
mov	v4.d[1], v5.d[1]
ret
fgy_32x32_8bpc_neon:
str	x30, [sp, #-0x10]!
ldr	w11, [x6, #0x8]
ldr	w13, [x6, #0x4]
ldr	w15, [x6, #0xc]
ldr	w6, [x6]
ldr	w8, [sp, #0x10]
mov	x9, #0x52
neg	w4, w4
dup	v29.8h, w4
adrp	x16, overlap_coeffs_0
add	x16, x16, :lo12:overlap_coeffs_0
cbz	w8, L_2680
movi	v30.16b, #0x10
movi	v31.16b, #0xeb
b	L_2688
L_2680:
movi	v30.16b, #0x0
movi	v31.16b, #0xff
L_2688:
ld1	{ v27.8b, v28.8b }, [x16]
add	x5, x5, #0x9
add	x5, x5, x9, lsl #3
add	x5, x5, x9
and	w12, w11, #0xf
lsr	w11, w11, #4
add	w12, w12, w12
add	w11, w11, w11
and	w14, w13, #0xf
lsr	w13, w13, #4
add	w14, w14, w14
add	w13, w13, w13
and	w16, w15, #0xf
lsr	w15, w15, #4
add	w16, w16, w16
add	w15, w15, w15
and	w10, w6, #0xf
lsr	w6, w6, #4
add	w10, w10, w10
add	w6, w6, w6
madd	x12, x9, x12, x5
add	x12, x12, w11, uxtw
madd	x14, x9, x14, x5
add	x14, x14, w13, uxtw
madd	x16, x9, x16, x5
add	x16, x16, w15, uxtw
madd	x5, x9, x10, x5
add	x5, x5, w6, uxtw
ldr	w11, [sp, #0x18]
adrp	x13, fgy_loop_tbl
add	x13, x13, :lo12:fgy_loop_tbl
add	x4, x12, #0x20
add	x6, x14, x9, lsl #5
tst	w11, #0x1
ldrsw	x11, [x13, w11, uxtw #2]
add	x8, x16, x9, lsl #5
add	x8, x8, #0x20
add	x11, x13, x11
b.eq	L_2734
dup	v6.16b, v27.b[0]
dup	v7.16b, v27.b[1]
mov	w10, w7
mov	w7, #0x2
L_2734:
br	x11
fgy_loop_neon:
ld1	{ v0.16b, v1.16b }, [x1], x2
ld1	{ v18.16b, v19.16b }, [x5], x9
bl	gather32_neon
sshll	v16.8h, v18.8b, #0x0
sshll2	v17.8h, v18.16b, #0x0
sshll	v18.8h, v19.8b, #0x0
sshll2	v19.8h, v19.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
ushll	v4.8h, v5.8b, #0x0
ushll2	v5.8h, v5.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
mul	v18.8h, v18.8h, v4.8h
mul	v19.8h, v19.8h, v5.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
uaddw	v16.8h, v16.8h, v0.8b
uaddw2	v17.8h, v17.8h, v0.16b
uaddw	v18.8h, v18.8h, v1.8b
uaddw2	v19.8h, v19.8h, v1.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
sqxtun	v1.8b, v18.8h
sqxtun2	v1.16b, v19.8h
umax	v0.16b, v0.16b, v30.16b
umax	v1.16b, v1.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
umin	v1.16b, v1.16b, v31.16b
subs	w7, w7, #0x1
st1	{ v0.16b, v1.16b }, [x0], x2
b.gt	fgy_loop_neon
ldr	x30, [sp], #0x10
ret
L_27c8:
ld1	{ v0.16b, v1.16b }, [x1], x2
ld1	{ v22.16b, v23.16b }, [x6], x9
ld1	{ v18.16b, v19.16b }, [x5], x9
bl	gather32_neon
smull	v16.8h, v18.8b, v7.8b
smull2	v17.8h, v18.16b, v7.16b
smull	v18.8h, v19.8b, v7.8b
smull2	v19.8h, v19.16b, v7.16b
smlal	v16.8h, v22.8b, v6.8b
smlal2	v17.8h, v22.16b, v6.16b
smlal	v18.8h, v23.8b, v6.8b
smlal2	v19.8h, v23.16b, v6.16b
sqrshrn	v22.8b, v16.8h, #0x5
sqrshrn2	v22.16b, v17.8h, #0x5
sqrshrn	v23.8b, v18.8h, #0x5
sqrshrn2	v23.16b, v19.8h, #0x5
sshll	v16.8h, v22.8b, #0x0
sshll2	v17.8h, v22.16b, #0x0
sshll	v18.8h, v23.8b, #0x0
sshll2	v19.8h, v23.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
ushll	v4.8h, v5.8b, #0x0
ushll2	v5.8h, v5.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
mul	v18.8h, v18.8h, v4.8h
mul	v19.8h, v19.8h, v5.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
uaddw	v16.8h, v16.8h, v0.8b
uaddw2	v17.8h, v17.8h, v0.16b
uaddw	v18.8h, v18.8h, v1.8b
uaddw2	v19.8h, v19.8h, v1.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
sqxtun	v1.8b, v18.8h
sqxtun2	v1.16b, v19.8h
umax	v0.16b, v0.16b, v30.16b
umax	v1.16b, v1.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
umin	v1.16b, v1.16b, v31.16b
subs	w7, w7, #0x1
dup	v6.16b, v28.b[0]
dup	v7.16b, v28.b[1]
st1	{ v0.16b, v1.16b }, [x0], x2
b.gt	L_27c8
cmp	w10, #0x2
sub	w7, w10, #0x2
b.gt	fgy_loop_neon
ldr	x30, [sp], #0x10
ret
L_28a0:
ld1	{ v0.16b, v1.16b }, [x1], x2
ld1	{ v20.8b }, [x4], x9
ld1	{ v18.16b, v19.16b }, [x5], x9
bl	gather32_neon
smull	v20.8h, v20.8b, v27.8b
smlal	v20.8h, v18.8b, v28.8b
sqrshrn	v20.8b, v20.8h, #0x5
sshll2	v17.8h, v18.16b, #0x0
sshll	v18.8h, v19.8b, #0x0
sshll2	v19.8h, v19.16b, #0x0
sshll	v16.8h, v20.8b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
ushll	v4.8h, v5.8b, #0x0
ushll2	v5.8h, v5.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
mul	v18.8h, v18.8h, v4.8h
mul	v19.8h, v19.8h, v5.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
uaddw	v16.8h, v16.8h, v0.8b
uaddw2	v17.8h, v17.8h, v0.16b
uaddw	v18.8h, v18.8h, v1.8b
uaddw2	v19.8h, v19.8h, v1.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
sqxtun	v1.8b, v18.8h
sqxtun2	v1.16b, v19.8h
umax	v0.16b, v0.16b, v30.16b
umax	v1.16b, v1.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
umin	v1.16b, v1.16b, v31.16b
subs	w7, w7, #0x1
st1	{ v0.16b, v1.16b }, [x0], x2
b.gt	L_28a0
ldr	x30, [sp], #0x10
ret
L_2940:
ld1	{ v0.16b, v1.16b }, [x1], x2
ld1	{ v20.8b }, [x4], x9
ld1	{ v22.16b, v23.16b }, [x6], x9
ld1	{ v21.8b }, [x8], x9
ld1	{ v18.16b, v19.16b }, [x5], x9
bl	gather32_neon
smull	v20.8h, v20.8b, v27.8b
smlal	v20.8h, v18.8b, v28.8b
smull	v21.8h, v21.8b, v27.8b
smlal	v21.8h, v22.8b, v28.8b
sqrshrn	v20.8b, v20.8h, #0x5
sqrshrn	v21.8b, v21.8h, #0x5
smull	v16.8h, v20.8b, v7.8b
smull2	v17.8h, v18.16b, v7.16b
smull	v18.8h, v19.8b, v7.8b
smull2	v19.8h, v19.16b, v7.16b
smlal	v16.8h, v21.8b, v6.8b
smlal2	v17.8h, v22.16b, v6.16b
smlal	v18.8h, v23.8b, v6.8b
smlal2	v19.8h, v23.16b, v6.16b
sqrshrn	v22.8b, v16.8h, #0x5
sqrshrn2	v22.16b, v17.8h, #0x5
sqrshrn	v23.8b, v18.8h, #0x5
sqrshrn2	v23.16b, v19.8h, #0x5
sshll	v16.8h, v22.8b, #0x0
sshll2	v17.8h, v22.16b, #0x0
sshll	v18.8h, v23.8b, #0x0
sshll2	v19.8h, v23.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
ushll	v4.8h, v5.8b, #0x0
ushll2	v5.8h, v5.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
mul	v18.8h, v18.8h, v4.8h
mul	v19.8h, v19.8h, v5.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
uaddw	v16.8h, v16.8h, v0.8b
uaddw2	v17.8h, v17.8h, v0.16b
uaddw	v18.8h, v18.8h, v1.8b
uaddw2	v19.8h, v19.8h, v1.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
sqxtun	v1.8b, v18.8h
sqxtun2	v1.16b, v19.8h
umax	v0.16b, v0.16b, v30.16b
umax	v1.16b, v1.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
umin	v1.16b, v1.16b, v31.16b
subs	w7, w7, #0x1
dup	v6.16b, v28.b[0]
dup	v7.16b, v28.b[1]
st1	{ v0.16b, v1.16b }, [x0], x2
b.gt	L_2940
cmp	w10, #0x2
sub	w7, w10, #0x2
b.gt	L_28a0
ldr	x30, [sp], #0x10
ret
fguv_32x32_420_8bpc_neon:
str	x30, [sp, #-0x20]!
str	d8, [sp, #0x10]
ldp	x8, x9, [sp, #0x20]
ldp	x10, x11, [sp, #0x30]
ldr	w13, [x4, #0x58]
ldr	w12, [x4, #0xd8]
neg	w13, w13
add	x10, x4, x10, lsl #2
add	x14, x10, #0xc4
add	x15, x10, #0xbc
add	x10, x10, #0xcc
ld1	{ v8.h }[0], [x14]
ld1r	{ v24.8h }, [x10]
ld1	{ v8.h }[1], [x15]
dup	v29.8h, w13
cbz	w12, L_2a8c
movi	v30.16b, #0x10
movi	v31.16b, #0xf0
cbz	w11, L_2a94
movi	v31.16b, #0xeb
b	L_2a94
L_2a8c:
movi	v30.16b, #0x0
movi	v31.16b, #0xff
L_2a94:
ldr	w12, [x8, #0x8]
ldr	w14, [x8, #0x4]
ldr	w16, [x8, #0xc]
ldr	w8, [x8]
mov	x10, #0x52
add	x5, x5, #0x6
add	x5, x5, x10, lsl #2
add	x5, x5, x10, lsl #1
and	w13, w12, #0xf
lsr	w12, w12, #4
and	w15, w14, #0xf
lsr	w14, w14, #4
and	w17, w16, #0xf
lsr	w16, w16, #4
and	w11, w8, #0xf
lsr	w8, w8, #4
madd	x13, x10, x13, x5
add	x13, x13, w12, uxtw
madd	x15, x10, x15, x5
add	x15, x15, w14, uxtw
madd	x17, x10, x17, x5
add	x17, x17, w16, uxtw
madd	x5, x10, x11, x5
add	x5, x5, w8, uxtw
add	x4, x13, #0x10
add	x8, x15, x10, lsl #4
add	x11, x17, x10, lsl #4
add	x11, x11, #0x10
ldr	w13, [sp, #0x40]
adrp	x16, overlap_coeffs_1
add	x16, x16, :lo12:overlap_coeffs_1
adrp	x14, fguv_loop_sx1_tbl
add	x14, x14, :lo12:fguv_loop_sx1_tbl
ld1	{ v27.8b, v28.8b }, [x16]
tst	w13, #0x1
ldrsw	x13, [x14, w13, uxtw #2]
b.eq	L_2b30
sub	w12, w9, #0x1
mov	w9, #0x1
L_2b30:
add	x13, x14, x13
movi	v25.16b, #0x17
movi	v26.16b, #0x16
add	x7, x7, x7
br	x13
fguv_32x32_422_8bpc_neon:
str	x30, [sp, #-0x20]!
str	d8, [sp, #0x10]
ldp	x8, x9, [sp, #0x20]
ldp	x10, x11, [sp, #0x30]
ldr	w13, [x4, #0x58]
ldr	w12, [x4, #0xd8]
neg	w13, w13
add	x10, x4, x10, lsl #2
add	x14, x10, #0xc4
add	x15, x10, #0xbc
add	x10, x10, #0xcc
ld1	{ v8.h }[0], [x14]
ld1r	{ v24.8h }, [x10]
ld1	{ v8.h }[1], [x15]
dup	v29.8h, w13
cbz	w12, L_2b98
movi	v30.16b, #0x10
movi	v31.16b, #0xf0
cbz	w11, L_2ba0
movi	v31.16b, #0xeb
b	L_2ba0
L_2b98:
movi	v30.16b, #0x0
movi	v31.16b, #0xff
L_2ba0:
ldr	w12, [x8, #0x8]
ldr	w14, [x8, #0x4]
ldr	w16, [x8, #0xc]
ldr	w8, [x8]
mov	x10, #0x52
add	x5, x5, #0x6
add	x5, x5, x10, lsl #3
add	x5, x5, x10
and	w13, w12, #0xf
lsr	w12, w12, #4
add	w13, w13, w13
and	w15, w14, #0xf
lsr	w14, w14, #4
add	w15, w15, w15
and	w17, w16, #0xf
lsr	w16, w16, #4
add	w17, w17, w17
and	w11, w8, #0xf
lsr	w8, w8, #4
add	w11, w11, w11
madd	x13, x10, x13, x5
add	x13, x13, w12, uxtw
madd	x15, x10, x15, x5
add	x15, x15, w14, uxtw
madd	x17, x10, x17, x5
add	x17, x17, w16, uxtw
madd	x5, x10, x11, x5
add	x5, x5, w8, uxtw
add	x4, x13, #0x10
add	x8, x15, x10, lsl #5
add	x11, x17, x10, lsl #5
add	x11, x11, #0x10
ldr	w13, [sp, #0x40]
adrp	x16, overlap_coeffs_1
add	x16, x16, :lo12:overlap_coeffs_1
adrp	x14, fguv_loop_sx1_tbl
add	x14, x14, :lo12:fguv_loop_sx1_tbl
ld1	{ v27.8b, v28.8b }, [x16]
tst	w13, #0x1
ldrsw	x13, [x14, w13, uxtw #2]
b.eq	L_2c4c
sub	w12, w9, #0x2
mov	w9, #0x2
L_2c4c:
add	x13, x14, x13
movi	v25.16b, #0x1b
movi	v26.16b, #0x11
br	x13
fguv_32x32_444_8bpc_neon:
str	x30, [sp, #-0x20]!
str	d8, [sp, #0x10]
ldp	x8, x9, [sp, #0x20]
ldp	x10, x11, [sp, #0x30]
ldr	w13, [x4, #0x58]
ldr	w12, [x4, #0xd8]
neg	w13, w13
add	x10, x4, x10, lsl #2
add	x14, x10, #0xc4
add	x15, x10, #0xbc
add	x10, x10, #0xcc
ld1	{ v8.h }[0], [x14]
ld1r	{ v24.8h }, [x10]
ld1	{ v8.h }[1], [x15]
dup	v29.8h, w13
cbz	w12, L_2cb0
movi	v30.16b, #0x10
movi	v31.16b, #0xf0
cbz	w11, L_2cb8
movi	v31.16b, #0xeb
b	L_2cb8
L_2cb0:
movi	v30.16b, #0x0
movi	v31.16b, #0xff
L_2cb8:
ldr	w12, [x8, #0x8]
ldr	w14, [x8, #0x4]
ldr	w16, [x8, #0xc]
ldr	w8, [x8]
mov	x10, #0x52
add	x5, x5, #0x9
add	x5, x5, x10, lsl #3
add	x5, x5, x10
and	w13, w12, #0xf
lsr	w12, w12, #4
add	w13, w13, w13
add	w12, w12, w12
and	w15, w14, #0xf
lsr	w14, w14, #4
add	w15, w15, w15
add	w14, w14, w14
and	w17, w16, #0xf
lsr	w16, w16, #4
add	w17, w17, w17
add	w16, w16, w16
and	w11, w8, #0xf
lsr	w8, w8, #4
add	w11, w11, w11
add	w8, w8, w8
madd	x13, x10, x13, x5
add	x13, x13, w12, uxtw
madd	x15, x10, x15, x5
add	x15, x15, w14, uxtw
madd	x17, x10, x17, x5
add	x17, x17, w16, uxtw
madd	x5, x10, x11, x5
add	x5, x5, w8, uxtw
add	x4, x13, #0x20
add	x8, x15, x10, lsl #5
add	x11, x17, x10, lsl #5
add	x11, x11, #0x20
ldr	w13, [sp, #0x40]
adrp	x16, overlap_coeffs_0
add	x16, x16, :lo12:overlap_coeffs_0
adrp	x14, fguv_loop_sx0_tbl
add	x14, x14, :lo12:fguv_loop_sx0_tbl
ld1	{ v27.8b, v28.8b }, [x16]
tst	w13, #0x1
ldrsw	x13, [x14, w13, uxtw #2]
b.eq	L_2d74
sub	w12, w9, #0x2
mov	w9, #0x2
L_2d74:
add	x13, x14, x13
movi	v25.16b, #0x1b
movi	v26.16b, #0x11
br	x13
fguv_loop_sx0_neon:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b, v7.16b }, [x1], x2
ld1	{ v18.16b, v19.16b }, [x5], x10
ushll	v2.8h, v0.8b, #0x0
ushll2	v3.8h, v0.16b, #0x0
ushll	v4.8h, v1.8b, #0x0
ushll2	v5.8h, v1.16b, #0x0
ushll	v0.8h, v6.8b, #0x0
ushll2	v1.8h, v6.16b, #0x0
ushll	v16.8h, v7.8b, #0x0
ushll2	v17.8h, v7.16b, #0x0
mul	v2.8h, v2.8h, v8.h[0]
mul	v3.8h, v3.8h, v8.h[0]
mul	v4.8h, v4.8h, v8.h[0]
mul	v5.8h, v5.8h, v8.h[0]
mul	v0.8h, v0.8h, v8.h[1]
mul	v1.8h, v1.8h, v8.h[1]
mul	v16.8h, v16.8h, v8.h[1]
mul	v17.8h, v17.8h, v8.h[1]
sqadd	v2.8h, v2.8h, v0.8h
sqadd	v3.8h, v3.8h, v1.8h
sqadd	v4.8h, v4.8h, v16.8h
sqadd	v5.8h, v5.8h, v17.8h
sshr	v2.8h, v2.8h, #0x6
sshr	v3.8h, v3.8h, #0x6
sshr	v4.8h, v4.8h, #0x6
sshr	v5.8h, v5.8h, #0x6
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v24.8h
add	v4.8h, v4.8h, v24.8h
add	v5.8h, v5.8h, v24.8h
sqxtun	v0.8b, v2.8h
sqxtun2	v0.16b, v3.8h
sqxtun	v1.8b, v4.8h
sqxtun2	v1.16b, v5.8h
bl	gather32_neon
sshll	v16.8h, v18.8b, #0x0
sshll2	v17.8h, v18.16b, #0x0
sshll	v18.8h, v19.8b, #0x0
sshll2	v19.8h, v19.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
ushll	v4.8h, v5.8b, #0x0
ushll2	v5.8h, v5.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
mul	v18.8h, v18.8h, v4.8h
mul	v19.8h, v19.8h, v5.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
uaddw	v18.8h, v18.8h, v7.8b
uaddw2	v19.8h, v19.8h, v7.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
sqxtun	v1.8b, v18.8h
sqxtun2	v1.16b, v19.8h
umax	v0.16b, v0.16b, v30.16b
umax	v1.16b, v1.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
umin	v1.16b, v1.16b, v31.16b
subs	w9, w9, #0x1
st1	{ v0.16b, v1.16b }, [x0], x2
b.gt	fguv_loop_sx0_neon
b	L_3584
L_2e94:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b, v7.16b }, [x1], x2
ld1	{ v22.16b, v23.16b }, [x8], x10
ld1	{ v18.16b, v19.16b }, [x5], x10
ushll	v2.8h, v0.8b, #0x0
ushll2	v3.8h, v0.16b, #0x0
ushll	v4.8h, v1.8b, #0x0
ushll2	v5.8h, v1.16b, #0x0
ushll	v0.8h, v6.8b, #0x0
ushll2	v1.8h, v6.16b, #0x0
ushll	v16.8h, v7.8b, #0x0
ushll2	v17.8h, v7.16b, #0x0
mul	v2.8h, v2.8h, v8.h[0]
mul	v3.8h, v3.8h, v8.h[0]
mul	v4.8h, v4.8h, v8.h[0]
mul	v5.8h, v5.8h, v8.h[0]
mul	v0.8h, v0.8h, v8.h[1]
mul	v1.8h, v1.8h, v8.h[1]
mul	v16.8h, v16.8h, v8.h[1]
mul	v17.8h, v17.8h, v8.h[1]
sqadd	v2.8h, v2.8h, v0.8h
sqadd	v3.8h, v3.8h, v1.8h
sqadd	v4.8h, v4.8h, v16.8h
sqadd	v5.8h, v5.8h, v17.8h
sshr	v2.8h, v2.8h, #0x6
sshr	v3.8h, v3.8h, #0x6
sshr	v4.8h, v4.8h, #0x6
sshr	v5.8h, v5.8h, #0x6
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v24.8h
add	v4.8h, v4.8h, v24.8h
add	v5.8h, v5.8h, v24.8h
sqxtun	v0.8b, v2.8h
sqxtun2	v0.16b, v3.8h
sqxtun	v1.8b, v4.8h
sqxtun2	v1.16b, v5.8h
bl	gather32_neon
smull	v16.8h, v18.8b, v26.8b
smull2	v17.8h, v18.16b, v26.16b
smull	v18.8h, v19.8b, v26.8b
smull2	v19.8h, v19.16b, v26.16b
smlal	v16.8h, v22.8b, v25.8b
smlal2	v17.8h, v22.16b, v25.16b
smlal	v18.8h, v23.8b, v25.8b
smlal2	v19.8h, v23.16b, v25.16b
sqrshrn	v22.8b, v16.8h, #0x5
sqrshrn2	v22.16b, v17.8h, #0x5
sqrshrn	v23.8b, v18.8h, #0x5
sqrshrn2	v23.16b, v19.8h, #0x5
sshll	v16.8h, v22.8b, #0x0
sshll2	v17.8h, v22.16b, #0x0
sshll	v18.8h, v23.8b, #0x0
sshll2	v19.8h, v23.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
ushll	v4.8h, v5.8b, #0x0
ushll2	v5.8h, v5.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
mul	v18.8h, v18.8h, v4.8h
mul	v19.8h, v19.8h, v5.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
uaddw	v18.8h, v18.8h, v7.8b
uaddw2	v19.8h, v19.8h, v7.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
sqxtun	v1.8b, v18.8h
sqxtun2	v1.16b, v19.8h
umax	v0.16b, v0.16b, v30.16b
umax	v1.16b, v1.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
umin	v1.16b, v1.16b, v31.16b
subs	w9, w9, #0x1
dup	v25.16b, v28.b[0]
dup	v26.16b, v28.b[1]
st1	{ v0.16b, v1.16b }, [x0], x2
b.gt	L_2e94
cmp	w12, #0x0
mov	w9, w12
b.gt	fguv_loop_sx0_neon
b	L_3584
L_2fec:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b, v7.16b }, [x1], x2
ld1	{ v20.8b }, [x4], x10
ld1	{ v18.16b, v19.16b }, [x5], x10
ushll	v2.8h, v0.8b, #0x0
ushll2	v3.8h, v0.16b, #0x0
ushll	v4.8h, v1.8b, #0x0
ushll2	v5.8h, v1.16b, #0x0
ushll	v0.8h, v6.8b, #0x0
ushll2	v1.8h, v6.16b, #0x0
ushll	v16.8h, v7.8b, #0x0
ushll2	v17.8h, v7.16b, #0x0
mul	v2.8h, v2.8h, v8.h[0]
mul	v3.8h, v3.8h, v8.h[0]
mul	v4.8h, v4.8h, v8.h[0]
mul	v5.8h, v5.8h, v8.h[0]
mul	v0.8h, v0.8h, v8.h[1]
mul	v1.8h, v1.8h, v8.h[1]
mul	v16.8h, v16.8h, v8.h[1]
mul	v17.8h, v17.8h, v8.h[1]
sqadd	v2.8h, v2.8h, v0.8h
sqadd	v3.8h, v3.8h, v1.8h
sqadd	v4.8h, v4.8h, v16.8h
sqadd	v5.8h, v5.8h, v17.8h
sshr	v2.8h, v2.8h, #0x6
sshr	v3.8h, v3.8h, #0x6
sshr	v4.8h, v4.8h, #0x6
sshr	v5.8h, v5.8h, #0x6
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v24.8h
add	v4.8h, v4.8h, v24.8h
add	v5.8h, v5.8h, v24.8h
sqxtun	v0.8b, v2.8h
sqxtun2	v0.16b, v3.8h
sqxtun	v1.8b, v4.8h
sqxtun2	v1.16b, v5.8h
bl	gather32_neon
smull	v20.8h, v20.8b, v27.8b
smlal	v20.8h, v18.8b, v28.8b
sqrshrn	v20.8b, v20.8h, #0x5
sshll2	v17.8h, v18.16b, #0x0
sshll	v18.8h, v19.8b, #0x0
sshll2	v19.8h, v19.16b, #0x0
sshll	v16.8h, v20.8b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
ushll	v4.8h, v5.8b, #0x0
ushll2	v5.8h, v5.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
mul	v18.8h, v18.8h, v4.8h
mul	v19.8h, v19.8h, v5.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
uaddw	v18.8h, v18.8h, v7.8b
uaddw2	v19.8h, v19.8h, v7.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
sqxtun	v1.8b, v18.8h
sqxtun2	v1.16b, v19.8h
umax	v0.16b, v0.16b, v30.16b
umax	v1.16b, v1.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
umin	v1.16b, v1.16b, v31.16b
subs	w9, w9, #0x1
st1	{ v0.16b, v1.16b }, [x0], x2
b.gt	L_2fec
b	L_3584
L_310c:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b, v7.16b }, [x1], x2
ld1	{ v20.8b }, [x4], x10
ld1	{ v22.16b, v23.16b }, [x8], x10
ld1	{ v21.8b }, [x11], x10
ld1	{ v18.16b, v19.16b }, [x5], x10
ushll	v2.8h, v0.8b, #0x0
ushll2	v3.8h, v0.16b, #0x0
ushll	v4.8h, v1.8b, #0x0
ushll2	v5.8h, v1.16b, #0x0
ushll	v0.8h, v6.8b, #0x0
ushll2	v1.8h, v6.16b, #0x0
ushll	v16.8h, v7.8b, #0x0
ushll2	v17.8h, v7.16b, #0x0
mul	v2.8h, v2.8h, v8.h[0]
mul	v3.8h, v3.8h, v8.h[0]
mul	v4.8h, v4.8h, v8.h[0]
mul	v5.8h, v5.8h, v8.h[0]
mul	v0.8h, v0.8h, v8.h[1]
mul	v1.8h, v1.8h, v8.h[1]
mul	v16.8h, v16.8h, v8.h[1]
mul	v17.8h, v17.8h, v8.h[1]
sqadd	v2.8h, v2.8h, v0.8h
sqadd	v3.8h, v3.8h, v1.8h
sqadd	v4.8h, v4.8h, v16.8h
sqadd	v5.8h, v5.8h, v17.8h
sshr	v2.8h, v2.8h, #0x6
sshr	v3.8h, v3.8h, #0x6
sshr	v4.8h, v4.8h, #0x6
sshr	v5.8h, v5.8h, #0x6
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v24.8h
add	v4.8h, v4.8h, v24.8h
add	v5.8h, v5.8h, v24.8h
sqxtun	v0.8b, v2.8h
sqxtun2	v0.16b, v3.8h
sqxtun	v1.8b, v4.8h
sqxtun2	v1.16b, v5.8h
bl	gather32_neon
smull	v20.8h, v20.8b, v27.8b
smlal	v20.8h, v18.8b, v28.8b
smull	v21.8h, v21.8b, v27.8b
smlal	v21.8h, v22.8b, v28.8b
sqrshrn	v20.8b, v20.8h, #0x5
sqrshrn	v21.8b, v21.8h, #0x5
smull	v16.8h, v20.8b, v26.8b
smull2	v17.8h, v18.16b, v26.16b
smull	v18.8h, v19.8b, v26.8b
smull2	v19.8h, v19.16b, v26.16b
smlal	v16.8h, v21.8b, v25.8b
smlal2	v17.8h, v22.16b, v25.16b
smlal	v18.8h, v23.8b, v25.8b
smlal2	v19.8h, v23.16b, v25.16b
sqrshrn	v22.8b, v16.8h, #0x5
sqrshrn2	v22.16b, v17.8h, #0x5
sqrshrn	v23.8b, v18.8h, #0x5
sqrshrn2	v23.16b, v19.8h, #0x5
sshll	v16.8h, v22.8b, #0x0
sshll2	v17.8h, v22.16b, #0x0
sshll	v18.8h, v23.8b, #0x0
sshll2	v19.8h, v23.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
ushll	v4.8h, v5.8b, #0x0
ushll2	v5.8h, v5.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
mul	v18.8h, v18.8h, v4.8h
mul	v19.8h, v19.8h, v5.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
uaddw	v18.8h, v18.8h, v7.8b
uaddw2	v19.8h, v19.8h, v7.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
sqxtun	v1.8b, v18.8h
sqxtun2	v1.16b, v19.8h
umax	v0.16b, v0.16b, v30.16b
umax	v1.16b, v1.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
umin	v1.16b, v1.16b, v31.16b
subs	w9, w9, #0x1
dup	v25.16b, v28.b[0]
dup	v26.16b, v28.b[1]
st1	{ v0.16b, v1.16b }, [x0], x2
b.gt	L_310c
cmp	w12, #0x0
mov	w9, w12
b.gt	L_2fec
b	L_3584
L_3284:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b, v7.16b }, [x1], x2
ld1	{ v18.16b, v19.16b }, [x5], x10
bl	gather32_neon
sshll	v16.8h, v18.8b, #0x0
sshll2	v17.8h, v18.16b, #0x0
sshll	v18.8h, v19.8b, #0x0
sshll2	v19.8h, v19.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
ushll	v4.8h, v5.8b, #0x0
ushll2	v5.8h, v5.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
mul	v18.8h, v18.8h, v4.8h
mul	v19.8h, v19.8h, v5.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
uaddw	v18.8h, v18.8h, v7.8b
uaddw2	v19.8h, v19.8h, v7.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
sqxtun	v1.8b, v18.8h
sqxtun2	v1.16b, v19.8h
umax	v0.16b, v0.16b, v30.16b
umax	v1.16b, v1.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
umin	v1.16b, v1.16b, v31.16b
subs	w9, w9, #0x1
st1	{ v0.16b, v1.16b }, [x0], x2
b.gt	L_3284
b	L_3584
L_3314:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b, v7.16b }, [x1], x2
ld1	{ v22.16b, v23.16b }, [x8], x10
ld1	{ v18.16b, v19.16b }, [x5], x10
bl	gather32_neon
smull	v16.8h, v18.8b, v26.8b
smull2	v17.8h, v18.16b, v26.16b
smull	v18.8h, v19.8b, v26.8b
smull2	v19.8h, v19.16b, v26.16b
smlal	v16.8h, v22.8b, v25.8b
smlal2	v17.8h, v22.16b, v25.16b
smlal	v18.8h, v23.8b, v25.8b
smlal2	v19.8h, v23.16b, v25.16b
sqrshrn	v22.8b, v16.8h, #0x5
sqrshrn2	v22.16b, v17.8h, #0x5
sqrshrn	v23.8b, v18.8h, #0x5
sqrshrn2	v23.16b, v19.8h, #0x5
sshll	v16.8h, v22.8b, #0x0
sshll2	v17.8h, v22.16b, #0x0
sshll	v18.8h, v23.8b, #0x0
sshll2	v19.8h, v23.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
ushll	v4.8h, v5.8b, #0x0
ushll2	v5.8h, v5.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
mul	v18.8h, v18.8h, v4.8h
mul	v19.8h, v19.8h, v5.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
uaddw	v18.8h, v18.8h, v7.8b
uaddw2	v19.8h, v19.8h, v7.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
sqxtun	v1.8b, v18.8h
sqxtun2	v1.16b, v19.8h
umax	v0.16b, v0.16b, v30.16b
umax	v1.16b, v1.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
umin	v1.16b, v1.16b, v31.16b
subs	w9, w9, #0x1
dup	v25.16b, v28.b[0]
dup	v26.16b, v28.b[1]
st1	{ v0.16b, v1.16b }, [x0], x2
b.gt	L_3314
cmp	w12, #0x0
mov	w9, w12
b.gt	L_3284
b	L_3584
L_33ec:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b, v7.16b }, [x1], x2
ld1	{ v20.8b }, [x4], x10
ld1	{ v18.16b, v19.16b }, [x5], x10
bl	gather32_neon
smull	v20.8h, v20.8b, v27.8b
smlal	v20.8h, v18.8b, v28.8b
sqrshrn	v20.8b, v20.8h, #0x5
sshll2	v17.8h, v18.16b, #0x0
sshll	v18.8h, v19.8b, #0x0
sshll2	v19.8h, v19.16b, #0x0
sshll	v16.8h, v20.8b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
ushll	v4.8h, v5.8b, #0x0
ushll2	v5.8h, v5.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
mul	v18.8h, v18.8h, v4.8h
mul	v19.8h, v19.8h, v5.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
uaddw	v18.8h, v18.8h, v7.8b
uaddw2	v19.8h, v19.8h, v7.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
sqxtun	v1.8b, v18.8h
sqxtun2	v1.16b, v19.8h
umax	v0.16b, v0.16b, v30.16b
umax	v1.16b, v1.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
umin	v1.16b, v1.16b, v31.16b
subs	w9, w9, #0x1
st1	{ v0.16b, v1.16b }, [x0], x2
b.gt	L_33ec
b	L_3584
L_348c:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b, v7.16b }, [x1], x2
ld1	{ v20.8b }, [x4], x10
ld1	{ v22.16b, v23.16b }, [x8], x10
ld1	{ v21.8b }, [x11], x10
ld1	{ v18.16b, v19.16b }, [x5], x10
bl	gather32_neon
smull	v20.8h, v20.8b, v27.8b
smlal	v20.8h, v18.8b, v28.8b
smull	v21.8h, v21.8b, v27.8b
smlal	v21.8h, v22.8b, v28.8b
sqrshrn	v20.8b, v20.8h, #0x5
sqrshrn	v21.8b, v21.8h, #0x5
smull	v16.8h, v20.8b, v26.8b
smull2	v17.8h, v18.16b, v26.16b
smull	v18.8h, v19.8b, v26.8b
smull2	v19.8h, v19.16b, v26.16b
smlal	v16.8h, v21.8b, v25.8b
smlal2	v17.8h, v22.16b, v25.16b
smlal	v18.8h, v23.8b, v25.8b
smlal2	v19.8h, v23.16b, v25.16b
sqrshrn	v22.8b, v16.8h, #0x5
sqrshrn2	v22.16b, v17.8h, #0x5
sqrshrn	v23.8b, v18.8h, #0x5
sqrshrn2	v23.16b, v19.8h, #0x5
sshll	v16.8h, v22.8b, #0x0
sshll2	v17.8h, v22.16b, #0x0
sshll	v18.8h, v23.8b, #0x0
sshll2	v19.8h, v23.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
ushll	v4.8h, v5.8b, #0x0
ushll2	v5.8h, v5.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
mul	v18.8h, v18.8h, v4.8h
mul	v19.8h, v19.8h, v5.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
uaddw	v18.8h, v18.8h, v7.8b
uaddw2	v19.8h, v19.8h, v7.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
sqxtun	v1.8b, v18.8h
sqxtun2	v1.16b, v19.8h
umax	v0.16b, v0.16b, v30.16b
umax	v1.16b, v1.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
umin	v1.16b, v1.16b, v31.16b
subs	w9, w9, #0x1
dup	v25.16b, v28.b[0]
dup	v26.16b, v28.b[1]
st1	{ v0.16b, v1.16b }, [x0], x2
b.gt	L_348c
cmp	w12, #0x0
mov	w9, w12
b.gt	L_33ec
b	L_3584
L_3584:
ldr	d8, [sp, #0x10]
ldr	x30, [sp], #0x20
ret
fguv_loop_sx1_neon:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b }, [x1], x2
ld1	{ v18.16b }, [x5], x10
uaddlp	v2.8h, v0.16b
uaddlp	v3.8h, v1.16b
urshr	v2.8h, v2.8h, #0x1
urshr	v3.8h, v3.8h, #0x1
ushll	v0.8h, v6.8b, #0x0
ushll2	v1.8h, v6.16b, #0x0
mul	v2.8h, v2.8h, v8.h[0]
mul	v3.8h, v3.8h, v8.h[0]
mul	v0.8h, v0.8h, v8.h[1]
mul	v1.8h, v1.8h, v8.h[1]
sqadd	v2.8h, v2.8h, v0.8h
sqadd	v3.8h, v3.8h, v1.8h
sshr	v2.8h, v2.8h, #0x6
sshr	v3.8h, v3.8h, #0x6
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v24.8h
sqxtun	v0.8b, v2.8h
sqxtun2	v0.16b, v3.8h
bl	gather16_neon
sshll	v16.8h, v18.8b, #0x0
sshll2	v17.8h, v18.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
umax	v0.16b, v0.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
subs	w9, w9, #0x1
st1	{ v0.16b }, [x0], x2
b.gt	fguv_loop_sx1_neon
b	L_3ae0
L_3630:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b }, [x1], x2
ld1	{ v22.16b }, [x8], x10
ld1	{ v18.16b }, [x5], x10
uaddlp	v2.8h, v0.16b
uaddlp	v3.8h, v1.16b
urshr	v2.8h, v2.8h, #0x1
urshr	v3.8h, v3.8h, #0x1
ushll	v0.8h, v6.8b, #0x0
ushll2	v1.8h, v6.16b, #0x0
mul	v2.8h, v2.8h, v8.h[0]
mul	v3.8h, v3.8h, v8.h[0]
mul	v0.8h, v0.8h, v8.h[1]
mul	v1.8h, v1.8h, v8.h[1]
sqadd	v2.8h, v2.8h, v0.8h
sqadd	v3.8h, v3.8h, v1.8h
sshr	v2.8h, v2.8h, #0x6
sshr	v3.8h, v3.8h, #0x6
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v24.8h
sqxtun	v0.8b, v2.8h
sqxtun2	v0.16b, v3.8h
bl	gather16_neon
smull	v16.8h, v18.8b, v26.8b
smull2	v17.8h, v18.16b, v26.16b
smlal	v16.8h, v22.8b, v25.8b
smlal2	v17.8h, v22.16b, v25.16b
sqrshrn	v22.8b, v16.8h, #0x5
sqrshrn2	v22.16b, v17.8h, #0x5
sshll	v16.8h, v22.8b, #0x0
sshll2	v17.8h, v22.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
umax	v0.16b, v0.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
mov	v16.16b, v25.16b
subs	w9, w9, #0x1
mov	v25.16b, v26.16b
mov	v26.16b, v16.16b
st1	{ v0.16b }, [x0], x2
b.gt	L_3630
cmp	w12, #0x0
mov	w9, w12
b.gt	fguv_loop_sx1_neon
b	L_3ae0
L_3704:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b }, [x1], x2
ld1	{ v20.8b }, [x4], x10
ld1	{ v18.16b }, [x5], x10
uaddlp	v2.8h, v0.16b
uaddlp	v3.8h, v1.16b
urshr	v2.8h, v2.8h, #0x1
urshr	v3.8h, v3.8h, #0x1
ushll	v0.8h, v6.8b, #0x0
ushll2	v1.8h, v6.16b, #0x0
mul	v2.8h, v2.8h, v8.h[0]
mul	v3.8h, v3.8h, v8.h[0]
mul	v0.8h, v0.8h, v8.h[1]
mul	v1.8h, v1.8h, v8.h[1]
sqadd	v2.8h, v2.8h, v0.8h
sqadd	v3.8h, v3.8h, v1.8h
sshr	v2.8h, v2.8h, #0x6
sshr	v3.8h, v3.8h, #0x6
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v24.8h
sqxtun	v0.8b, v2.8h
sqxtun2	v0.16b, v3.8h
bl	gather16_neon
smull	v20.8h, v20.8b, v27.8b
smlal	v20.8h, v18.8b, v28.8b
sqrshrn	v20.8b, v20.8h, #0x5
sshll2	v17.8h, v18.16b, #0x0
sshll	v16.8h, v20.8b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
umax	v0.16b, v0.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
subs	w9, w9, #0x1
st1	{ v0.16b }, [x0], x2
b.gt	L_3704
b	L_3ae0
L_37b4:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b }, [x1], x2
ld1	{ v20.8b }, [x4], x10
ld1	{ v22.16b }, [x8], x10
ld1	{ v21.8b }, [x11], x10
ld1	{ v18.16b }, [x5], x10
uaddlp	v2.8h, v0.16b
uaddlp	v3.8h, v1.16b
urshr	v2.8h, v2.8h, #0x1
urshr	v3.8h, v3.8h, #0x1
ushll	v0.8h, v6.8b, #0x0
ushll2	v1.8h, v6.16b, #0x0
mul	v2.8h, v2.8h, v8.h[0]
mul	v3.8h, v3.8h, v8.h[0]
mul	v0.8h, v0.8h, v8.h[1]
mul	v1.8h, v1.8h, v8.h[1]
sqadd	v2.8h, v2.8h, v0.8h
sqadd	v3.8h, v3.8h, v1.8h
sshr	v2.8h, v2.8h, #0x6
sshr	v3.8h, v3.8h, #0x6
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v24.8h
sqxtun	v0.8b, v2.8h
sqxtun2	v0.16b, v3.8h
bl	gather16_neon
smull	v20.8h, v20.8b, v27.8b
smlal	v20.8h, v18.8b, v28.8b
smull	v21.8h, v21.8b, v27.8b
smlal	v21.8h, v22.8b, v28.8b
sqrshrn	v20.8b, v20.8h, #0x5
sqrshrn	v21.8b, v21.8h, #0x5
smull	v16.8h, v20.8b, v26.8b
smull2	v17.8h, v18.16b, v26.16b
smlal	v16.8h, v21.8b, v25.8b
smlal2	v17.8h, v22.16b, v25.16b
sqrshrn	v22.8b, v16.8h, #0x5
sqrshrn2	v22.16b, v17.8h, #0x5
sshll	v16.8h, v22.8b, #0x0
sshll2	v17.8h, v22.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
umax	v0.16b, v0.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
mov	v16.16b, v25.16b
subs	w9, w9, #0x1
mov	v25.16b, v26.16b
mov	v26.16b, v16.16b
st1	{ v0.16b }, [x0], x2
b.gt	L_37b4
cmp	w12, #0x0
mov	w9, w12
b.gt	L_3704
b	L_3ae0
L_38a8:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b }, [x1], x2
ld1	{ v18.16b }, [x5], x10
uaddlp	v2.8h, v0.16b
uaddlp	v3.8h, v1.16b
rshrn	v0.8b, v2.8h, #0x1
rshrn2	v0.16b, v3.8h, #0x1
bl	gather16_neon
sshll	v16.8h, v18.8b, #0x0
sshll2	v17.8h, v18.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
umax	v0.16b, v0.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
subs	w9, w9, #0x1
st1	{ v0.16b }, [x0], x2
b.gt	L_38a8
b	L_3ae0
L_3910:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b }, [x1], x2
ld1	{ v22.16b }, [x8], x10
ld1	{ v18.16b }, [x5], x10
uaddlp	v2.8h, v0.16b
uaddlp	v3.8h, v1.16b
rshrn	v0.8b, v2.8h, #0x1
rshrn2	v0.16b, v3.8h, #0x1
bl	gather16_neon
smull	v16.8h, v18.8b, v26.8b
smull2	v17.8h, v18.16b, v26.16b
smlal	v16.8h, v22.8b, v25.8b
smlal2	v17.8h, v22.16b, v25.16b
sqrshrn	v22.8b, v16.8h, #0x5
sqrshrn2	v22.16b, v17.8h, #0x5
sshll	v16.8h, v22.8b, #0x0
sshll2	v17.8h, v22.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
umax	v0.16b, v0.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
mov	v16.16b, v25.16b
subs	w9, w9, #0x1
mov	v25.16b, v26.16b
mov	v26.16b, v16.16b
st1	{ v0.16b }, [x0], x2
b.gt	L_3910
cmp	w12, #0x0
mov	w9, w12
b.gt	L_38a8
b	L_3ae0
L_39ac:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b }, [x1], x2
ld1	{ v20.8b }, [x4], x10
ld1	{ v18.16b }, [x5], x10
uaddlp	v2.8h, v0.16b
uaddlp	v3.8h, v1.16b
rshrn	v0.8b, v2.8h, #0x1
rshrn2	v0.16b, v3.8h, #0x1
bl	gather16_neon
smull	v20.8h, v20.8b, v27.8b
smlal	v20.8h, v18.8b, v28.8b
sqrshrn	v20.8b, v20.8h, #0x5
sshll2	v17.8h, v18.16b, #0x0
sshll	v16.8h, v20.8b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
umax	v0.16b, v0.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
subs	w9, w9, #0x1
st1	{ v0.16b }, [x0], x2
b.gt	L_39ac
b	L_3ae0
L_3a24:
ld1	{ v0.16b, v1.16b }, [x6], x7
ld1	{ v6.16b }, [x1], x2
ld1	{ v20.8b }, [x4], x10
ld1	{ v22.16b }, [x8], x10
ld1	{ v21.8b }, [x11], x10
ld1	{ v18.16b }, [x5], x10
uaddlp	v2.8h, v0.16b
uaddlp	v3.8h, v1.16b
rshrn	v0.8b, v2.8h, #0x1
rshrn2	v0.16b, v3.8h, #0x1
bl	gather16_neon
smull	v20.8h, v20.8b, v27.8b
smlal	v20.8h, v18.8b, v28.8b
smull	v21.8h, v21.8b, v27.8b
smlal	v21.8h, v22.8b, v28.8b
sqrshrn	v20.8b, v20.8h, #0x5
sqrshrn	v21.8b, v21.8h, #0x5
smull	v16.8h, v20.8b, v26.8b
smull2	v17.8h, v18.16b, v26.16b
smlal	v16.8h, v21.8b, v25.8b
smlal2	v17.8h, v22.16b, v25.16b
sqrshrn	v22.8b, v16.8h, #0x5
sqrshrn2	v22.16b, v17.8h, #0x5
sshll	v16.8h, v22.8b, #0x0
sshll2	v17.8h, v22.16b, #0x0
ushll	v2.8h, v4.8b, #0x0
ushll2	v3.8h, v4.16b, #0x0
mul	v16.8h, v16.8h, v2.8h
mul	v17.8h, v17.8h, v3.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
uaddw	v16.8h, v16.8h, v6.8b
uaddw2	v17.8h, v17.8h, v6.16b
sqxtun	v0.8b, v16.8h
sqxtun2	v0.16b, v17.8h
umax	v0.16b, v0.16b, v30.16b
umin	v0.16b, v0.16b, v31.16b
mov	v16.16b, v25.16b
subs	w9, w9, #0x1
mov	v25.16b, v26.16b
mov	v26.16b, v16.16b
st1	{ v0.16b }, [x0], x2
b.gt	L_3a24
cmp	w12, #0x0
mov	w9, w12
b.gt	L_39ac
b	L_3ae0
L_3ae0:
ldr	d8, [sp, #0x10]
ldr	x30, [sp], #0x20
ret
	.section *UND*
	.section .rodata
gen_grain_y_tbl:
	.size gen_grain_y_tbl, 16
	.word L_1b44 - gen_grain_y_tbl
	.word L_1b54 - gen_grain_y_tbl
	.word L_1c0c - gen_grain_y_tbl
	.word L_1c54 - gen_grain_y_tbl
gen_grain_uv_444_tbl:
	.size gen_grain_uv_444_tbl, 16
	.word L_1d54 - gen_grain_uv_444_tbl
	.word L_1dfc - gen_grain_uv_444_tbl
	.word L_1ec0 - gen_grain_uv_444_tbl
	.word L_1f0c - gen_grain_uv_444_tbl
gen_grain_uv_420_tbl:
	.size gen_grain_uv_420_tbl, 16
	.word L_2010 - gen_grain_uv_420_tbl
	.word L_2090 - gen_grain_uv_420_tbl
	.word L_2118 - gen_grain_uv_420_tbl
	.word L_2154 - gen_grain_uv_420_tbl
gen_grain_uv_422_tbl:
	.size gen_grain_uv_422_tbl, 16
	.word L_224c - gen_grain_uv_422_tbl
	.word L_22c8 - gen_grain_uv_422_tbl
	.word L_2350 - gen_grain_uv_422_tbl
	.word L_238c - gen_grain_uv_422_tbl
overlap_coeffs_0:
	.size overlap_coeffs_0, 16
	.byte 27,17,0,0,0,0,0,0,17,27,32,32,32,32,32,32
overlap_coeffs_1:
	.size overlap_coeffs_1, 16
	.byte 23,0,0,0,0,0,0,0,22,32,32,32,32,32,32,32
fgy_loop_tbl:
	.size fgy_loop_tbl, 16
	.word fgy_loop_neon - fgy_loop_tbl
	.word L_27c8 - fgy_loop_tbl
	.word L_28a0 - fgy_loop_tbl
	.word L_2940 - fgy_loop_tbl
fguv_loop_sx0_tbl:
	.size fguv_loop_sx0_tbl, 32
	.word fguv_loop_sx0_neon - fguv_loop_sx0_tbl
	.word L_2e94 - fguv_loop_sx0_tbl
	.word L_2fec - fguv_loop_sx0_tbl
	.word L_310c - fguv_loop_sx0_tbl
	.word L_3284 - fguv_loop_sx0_tbl
	.word L_3314 - fguv_loop_sx0_tbl
	.word L_33ec - fguv_loop_sx0_tbl
	.word L_348c - fguv_loop_sx0_tbl
fguv_loop_sx1_tbl:
	.size fguv_loop_sx1_tbl, 32
	.word fguv_loop_sx1_neon - fguv_loop_sx1_tbl
	.word L_3630 - fguv_loop_sx1_tbl
	.word L_3704 - fguv_loop_sx1_tbl
	.word L_37b4 - fguv_loop_sx1_tbl
	.word L_38a8 - fguv_loop_sx1_tbl
	.word L_3910 - fguv_loop_sx1_tbl
	.word L_39ac - fguv_loop_sx1_tbl
	.word L_3a24 - fguv_loop_sx1_tbl
