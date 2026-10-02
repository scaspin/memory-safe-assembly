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
ret
get_grain_4_neon:
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
add	x15, x3, x15, lsl #1
ld1	{ v0.h }[2], [x14]
ld1	{ v0.h }[3], [x15]
srshl	v0.4h, v0.4h, v31.4h
ret
output_lag1_neon:
ubfx	x13, x2, #6, #11
lsr	w2, w2, #1
mov	w11, v1.s[0]
ldrsh	w12, [x3, x13, lsl #1]
ext	v0.16b, v0.16b, v0.16b, #0x2
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
mov	v0.h[7], w14
b.gt	output_lag1_neon
ret
output_lag2_neon:
ubfx	x13, x2, #6, #11
lsr	w2, w2, #1
mov	w11, v1.s[0]
ldrsh	w12, [x3, x13, lsl #1]
ext	v0.16b, v0.16b, v0.16b, #0x2
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
mov	v0.h[7], w14
b.gt	output_lag2_neon
ret
output_lag3_neon:
ubfx	x13, x2, #6, #11
lsr	w2, w2, #1
mov	w11, v1.s[0]
ldrsh	w12, [x3, x13, lsl #1]
ext	v0.16b, v0.16b, v0.16b, #0x2
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
mov	v0.h[7], w14
b.gt	output_lag3_neon
ret
sum_lag1_above_neon:
sub	x12, x0, #0x94
ld1	{ v18.8h }, [x12]
ext	v0.16b, v16.16b, v17.16b, #0xe
ext	v1.16b, v17.16b, v18.16b, #0x2
smull	v4.4s, v17.4h, v28.4h
smlal	v4.4s, v0.4h, v27.4h
smlal	v4.4s, v1.4h, v29.4h
smull2	v5.4s, v17.8h, v28.8h
smlal2	v5.4s, v0.8h, v27.8h
smlal2	v5.4s, v1.8h, v29.8h
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
ret
sum_y_lag1_left_neon:
str	x30, [sp, #-0x10]!
sub	x12, x0, #0xa4
ld1	{ v17.8h }, [x12]
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
ext	v4.16b, v4.16b, v4.16b, #0xc
smov	w14, v0.h[7]
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
st1	{ v0.8h }, [x0], #16
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
st1	{ v0.8h }, [x0], #16
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
mov	w15, #0x3
bl	output_lag1_neon
ubfx	x15, x2, #6, #11
lsr	w2, w2, #1
add	x15, x3, x15, lsl #1
ld1	{ v1.h }[0], [x15]
srshl	v1.4h, v1.4h, v31.4h
ext	v0.16b, v0.16b, v1.16b, #0x2
st1	{ v0.8h }, [x0], #16
ldr	x30, [sp], #0x10
ret
sum_uv_444_lag1_left_neon:
str	x30, [sp, #-0x10]!
sub	x12, x0, #0xa4
ld1	{ v17.8h }, [x12]
bl	sum_lag1_above_neon
ld1	{ v0.8h }, [x19], #16
smlal	v4.4s, v0.4h, v30.4h
smlal2	v5.4s, v0.8h, v30.8h
b	sum_lag1_y_left_start
sum_uv_444_lag1_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
ld1	{ v0.8h }, [x19], #16
smlal	v4.4s, v0.4h, v30.4h
smlal2	v5.4s, v0.8h, v30.8h
b	sum_lag1_y_mid_start
sum_uv_444_lag1_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
ld1	{ v0.8h }, [x19], #16
smlal	v4.4s, v0.4h, v30.4h
smlal2	v5.4s, v0.8h, v30.8h
b	sum_lag1_y_right_start
sum_uv_422_lag1_left_neon:
str	x30, [sp, #-0x10]!
sub	x12, x0, #0xa4
ld1	{ v17.8h }, [x12]
bl	sum_lag1_above_neon
ld1	{ v22.8h, v23.8h }, [x19], #32
addp	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x1
smlal	v4.4s, v0.4h, v30.4h
smlal2	v5.4s, v0.8h, v30.8h
b	sum_lag1_y_left_start
sum_uv_422_lag1_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
ld1	{ v22.8h, v23.8h }, [x19], #32
addp	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x1
smlal	v4.4s, v0.4h, v30.4h
smlal2	v5.4s, v0.8h, v30.8h
b	sum_lag1_y_mid_start
sum_uv_422_lag1_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
ld1	{ v22.8h, v23.8h }, [x19], #32
addp	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x1
smlal	v4.4s, v0.4h, v30.4h
smlal2	v5.4s, v0.8h, v30.8h
b	sum_lag1_uv_420_right_start
sum_uv_420_lag1_left_neon:
str	x30, [sp, #-0x10]!
sub	x12, x0, #0xa4
ld1	{ v17.8h }, [x12]
bl	sum_lag1_above_neon
add	x12, x19, #0xa4
ld1	{ v22.8h, v23.8h }, [x19], #32
ld1	{ v24.8h, v25.8h }, [x12]
addp	v22.8h, v22.8h, v23.8h
addp	v23.8h, v24.8h, v25.8h
add	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x2
smlal	v4.4s, v0.4h, v30.4h
smlal2	v5.4s, v0.8h, v30.8h
b	sum_lag1_y_left_start
sum_uv_420_lag1_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
add	x12, x19, #0xa4
ld1	{ v22.8h, v23.8h }, [x19], #32
ld1	{ v24.8h, v25.8h }, [x12]
addp	v22.8h, v22.8h, v23.8h
addp	v23.8h, v24.8h, v25.8h
add	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x2
smlal	v4.4s, v0.4h, v30.4h
smlal2	v5.4s, v0.8h, v30.8h
b	sum_lag1_y_mid_start
sum_uv_420_lag1_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag1_above_neon
add	x12, x19, #0xa4
ld1	{ v22.8h, v23.8h }, [x19], #32
ld1	{ v24.8h, v25.8h }, [x12]
addp	v22.8h, v22.8h, v23.8h
addp	v23.8h, v24.8h, v25.8h
add	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x2
smlal	v4.4s, v0.4h, v30.4h
smlal2	v5.4s, v0.8h, v30.8h
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
ext	v0.16b, v0.16b, v1.16b, #0xe
st1	{ v0.8h }, [x0], #16
ldr	x30, [sp], #0x10
ret
sum_lag2_above_neon:
sub	x12, x0, #0x138
sub	x13, x0, #0x94
ld1	{ v18.8h }, [x12]
ld1	{ v21.8h }, [x13]
dup	v26.8b, v30.b[0]
ext	v22.16b, v16.16b, v17.16b, #0xc
dup	v27.8b, v30.b[1]
ext	v23.16b, v16.16b, v17.16b, #0xe
sshll	v26.8h, v26.8b, #0x0
dup	v28.8b, v30.b[3]
ext	v0.16b, v17.16b, v18.16b, #0x2
sshll	v27.8h, v27.8b, #0x0
dup	v29.8b, v30.b[4]
ext	v1.16b, v17.16b, v18.16b, #0x4
sshll	v28.8h, v28.8b, #0x0
sshll	v29.8h, v29.8b, #0x0
smull	v4.4s, v22.4h, v26.4h
smlal	v4.4s, v23.4h, v27.4h
smlal	v4.4s, v0.4h, v28.4h
smlal	v4.4s, v1.4h, v29.4h
smull2	v5.4s, v22.8h, v26.8h
smlal2	v5.4s, v23.8h, v27.8h
smlal2	v5.4s, v0.8h, v28.8h
smlal2	v5.4s, v1.8h, v29.8h
dup	v26.16b, v30.b[5]
ext	v22.16b, v19.16b, v20.16b, #0xc
dup	v27.16b, v30.b[6]
ext	v23.16b, v19.16b, v20.16b, #0xe
sshll	v26.8h, v26.8b, #0x0
dup	v28.16b, v30.b[8]
ext	v0.16b, v20.16b, v21.16b, #0x2
sshll	v27.8h, v27.8b, #0x0
dup	v29.16b, v30.b[9]
ext	v1.16b, v20.16b, v21.16b, #0x4
sshll	v28.8h, v28.8b, #0x0
sshll	v29.8h, v29.8b, #0x0
smlal	v4.4s, v22.4h, v26.4h
smlal	v4.4s, v23.4h, v27.4h
smlal	v4.4s, v0.4h, v28.4h
smlal	v4.4s, v1.4h, v29.4h
smlal2	v5.4s, v22.8h, v26.8h
smlal2	v5.4s, v23.8h, v27.8h
smlal2	v5.4s, v0.8h, v28.8h
smlal2	v5.4s, v1.8h, v29.8h
dup	v26.16b, v30.b[2]
dup	v27.16b, v30.b[7]
sshll	v26.8h, v26.8b, #0x0
sshll	v27.8h, v27.8b, #0x0
smlal	v4.4s, v17.4h, v26.4h
smlal	v4.4s, v20.4h, v27.4h
smlal2	v5.4s, v17.8h, v26.8h
smlal2	v5.4s, v20.8h, v27.8h
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
mov	v19.16b, v20.16b
mov	v20.16b, v21.16b
ret
sum_y_lag2_left_neon:
str	x30, [sp, #-0x10]!
sub	x12, x0, #0x148
sub	x13, x0, #0xa4
ld1	{ v17.8h }, [x12]
ld1	{ v20.8h }, [x13]
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
ext	v4.16b, v4.16b, v4.16b, #0xc
smov	w16, v0.h[6]
smov	w14, v0.h[7]
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
st1	{ v0.8h }, [x0], #16
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
st1	{ v0.8h }, [x0], #16
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
mov	w15, #0x3
bl	output_lag2_neon
ubfx	x15, x2, #6, #11
lsr	w2, w2, #1
add	x15, x3, x15, lsl #1
ld1	{ v1.h }[0], [x15]
srshl	v1.4h, v1.4h, v31.4h
ext	v0.16b, v0.16b, v1.16b, #0x2
st1	{ v0.8h }, [x0], #16
ldr	x30, [sp], #0x10
ret
sum_uv_444_lag2_left_neon:
str	x30, [sp, #-0x10]!
sub	x12, x0, #0x148
sub	x13, x0, #0xa4
ld1	{ v17.8h }, [x12]
ld1	{ v20.8h }, [x13]
bl	sum_lag2_above_neon
ld1	{ v0.8h }, [x19], #16
dup	v1.8b, v30.b[12]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag2_y_left_start
sum_uv_444_lag2_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
ld1	{ v0.8h }, [x19], #16
dup	v1.8b, v30.b[12]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag2_y_mid_start
sum_uv_444_lag2_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
ld1	{ v0.8h }, [x19], #16
dup	v1.8b, v30.b[12]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag2_y_right_start
sum_uv_422_lag2_left_neon:
str	x30, [sp, #-0x10]!
sub	x12, x0, #0x148
sub	x13, x0, #0xa4
ld1	{ v17.8h }, [x12]
ld1	{ v20.8h }, [x13]
bl	sum_lag2_above_neon
ld1	{ v22.8h, v23.8h }, [x19], #32
addp	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x1
dup	v1.8b, v30.b[12]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag2_y_left_start
sum_uv_422_lag2_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
ld1	{ v22.8h, v23.8h }, [x19], #32
addp	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x1
dup	v1.8b, v30.b[12]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag2_y_mid_start
sum_uv_422_lag2_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
ld1	{ v22.8h, v23.8h }, [x19], #32
addp	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x1
dup	v1.8b, v30.b[12]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag2_uv_420_right_start
sum_uv_420_lag2_left_neon:
str	x30, [sp, #-0x10]!
sub	x12, x0, #0x148
sub	x13, x0, #0xa4
ld1	{ v17.8h }, [x12]
ld1	{ v20.8h }, [x13]
bl	sum_lag2_above_neon
add	x12, x19, #0xa4
ld1	{ v22.8h, v23.8h }, [x19], #32
ld1	{ v24.8h, v25.8h }, [x12]
addp	v22.8h, v22.8h, v23.8h
addp	v23.8h, v24.8h, v25.8h
add	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x2
dup	v1.8b, v30.b[12]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag2_y_left_start
sum_uv_420_lag2_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
add	x12, x19, #0xa4
ld1	{ v22.8h, v23.8h }, [x19], #32
ld1	{ v24.8h, v25.8h }, [x12]
addp	v22.8h, v22.8h, v23.8h
addp	v23.8h, v24.8h, v25.8h
add	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x2
dup	v1.8b, v30.b[12]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag2_y_mid_start
sum_uv_420_lag2_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag2_above_neon
add	x12, x19, #0xa4
ld1	{ v22.8h, v23.8h }, [x19], #32
ld1	{ v24.8h, v25.8h }, [x12]
addp	v22.8h, v22.8h, v23.8h
addp	v23.8h, v24.8h, v25.8h
add	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x2
dup	v1.8b, v30.b[12]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
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
ext	v0.16b, v0.16b, v1.16b, #0xe
st1	{ v0.8h }, [x0], #16
ldr	x30, [sp], #0x10
ret
sum_lag3_above_neon:
sub	x11, x0, #0x1dc
sub	x12, x0, #0x138
sub	x13, x0, #0x94
ld1	{ v15.8h }, [x11]
ld1	{ v18.8h }, [x12]
ld1	{ v21.8h }, [x13]
dup	v22.8b, v29.b[0]
ext	v8.16b, v13.16b, v14.16b, #0xa
dup	v23.8b, v29.b[1]
ext	v9.16b, v13.16b, v14.16b, #0xc
sshll	v22.8h, v22.8b, #0x0
dup	v24.8b, v29.b[2]
sshll	v23.8h, v23.8b, #0x0
dup	v25.8b, v29.b[3]
ext	v10.16b, v13.16b, v14.16b, #0xe
sshll	v24.8h, v24.8b, #0x0
dup	v26.8b, v29.b[4]
ext	v11.16b, v14.16b, v15.16b, #0x2
sshll	v25.8h, v25.8b, #0x0
dup	v27.8b, v29.b[5]
ext	v12.16b, v14.16b, v15.16b, #0x4
sshll	v26.8h, v26.8b, #0x0
dup	v28.8b, v29.b[6]
ext	v13.16b, v14.16b, v15.16b, #0x6
sshll	v27.8h, v27.8b, #0x0
sshll	v28.8h, v28.8b, #0x0
smull	v4.4s, v8.4h, v22.4h
smlal	v4.4s, v9.4h, v23.4h
smlal	v4.4s, v10.4h, v24.4h
smlal	v4.4s, v11.4h, v26.4h
smlal	v4.4s, v12.4h, v27.4h
smlal	v4.4s, v13.4h, v28.4h
smlal	v4.4s, v14.4h, v25.4h
smull2	v5.4s, v8.8h, v22.8h
smlal2	v5.4s, v9.8h, v23.8h
smlal2	v5.4s, v10.8h, v24.8h
smlal2	v5.4s, v11.8h, v26.8h
smlal2	v5.4s, v12.8h, v27.8h
smlal2	v5.4s, v13.8h, v28.8h
smlal2	v5.4s, v14.8h, v25.8h
dup	v22.8b, v29.b[7]
ext	v8.16b, v16.16b, v17.16b, #0xa
dup	v23.8b, v29.b[8]
ext	v9.16b, v16.16b, v17.16b, #0xc
sshll	v22.8h, v22.8b, #0x0
dup	v24.8b, v29.b[9]
sshll	v23.8h, v23.8b, #0x0
dup	v25.8b, v29.b[10]
ext	v10.16b, v16.16b, v17.16b, #0xe
sshll	v24.8h, v24.8b, #0x0
dup	v26.8b, v29.b[11]
ext	v11.16b, v17.16b, v18.16b, #0x2
sshll	v25.8h, v25.8b, #0x0
dup	v27.8b, v29.b[12]
ext	v12.16b, v17.16b, v18.16b, #0x4
sshll	v26.8h, v26.8b, #0x0
dup	v28.8b, v29.b[13]
ext	v13.16b, v17.16b, v18.16b, #0x6
sshll	v27.8h, v27.8b, #0x0
sshll	v28.8h, v28.8b, #0x0
smlal	v4.4s, v8.4h, v22.4h
smlal	v4.4s, v9.4h, v23.4h
smlal	v4.4s, v10.4h, v24.4h
smlal	v4.4s, v11.4h, v26.4h
smlal	v4.4s, v12.4h, v27.4h
smlal	v4.4s, v13.4h, v28.4h
smlal	v4.4s, v17.4h, v25.4h
smlal2	v5.4s, v8.8h, v22.8h
smlal2	v5.4s, v9.8h, v23.8h
smlal2	v5.4s, v10.8h, v24.8h
smlal2	v5.4s, v11.8h, v26.8h
smlal2	v5.4s, v12.8h, v27.8h
smlal2	v5.4s, v13.8h, v28.8h
smlal2	v5.4s, v17.8h, v25.8h
dup	v22.8b, v29.b[14]
ext	v8.16b, v19.16b, v20.16b, #0xa
dup	v23.8b, v29.b[15]
ext	v9.16b, v19.16b, v20.16b, #0xc
sshll	v22.8h, v22.8b, #0x0
dup	v24.8b, v30.b[0]
sshll	v23.8h, v23.8b, #0x0
dup	v25.8b, v30.b[1]
ext	v10.16b, v19.16b, v20.16b, #0xe
sshll	v24.8h, v24.8b, #0x0
dup	v26.8b, v30.b[2]
ext	v11.16b, v20.16b, v21.16b, #0x2
sshll	v25.8h, v25.8b, #0x0
dup	v27.8b, v30.b[3]
ext	v12.16b, v20.16b, v21.16b, #0x4
sshll	v26.8h, v26.8b, #0x0
dup	v28.8b, v30.b[4]
ext	v13.16b, v20.16b, v21.16b, #0x6
sshll	v27.8h, v27.8b, #0x0
sshll	v28.8h, v28.8b, #0x0
smlal	v4.4s, v8.4h, v22.4h
smlal	v4.4s, v9.4h, v23.4h
smlal	v4.4s, v10.4h, v24.4h
smlal	v4.4s, v11.4h, v26.4h
smlal	v4.4s, v12.4h, v27.4h
smlal	v4.4s, v13.4h, v28.4h
smlal	v4.4s, v20.4h, v25.4h
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
smlal2	v5.4s, v8.8h, v22.8h
smlal2	v5.4s, v9.8h, v23.8h
smlal2	v5.4s, v10.8h, v24.8h
smlal2	v5.4s, v11.8h, v26.8h
smlal2	v5.4s, v12.8h, v27.8h
smlal2	v5.4s, v13.8h, v28.8h
smlal2	v5.4s, v20.8h, v25.8h
mov	v13.16b, v14.16b
mov	v14.16b, v15.16b
mov	v19.16b, v20.16b
mov	v20.16b, v21.16b
ret
sum_y_lag3_left_neon:
str	x30, [sp, #-0x10]!
sub	x11, x0, #0x1ec
sub	x12, x0, #0x148
sub	x13, x0, #0xa4
ld1	{ v14.8h }, [x11]
ld1	{ v17.8h }, [x12]
ld1	{ v20.8h }, [x13]
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
ext	v4.16b, v4.16b, v4.16b, #0xc
smov	w17, v0.h[5]
smov	w16, v0.h[6]
smov	w14, v0.h[7]
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
st1	{ v0.8h }, [x0], #16
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
st1	{ v0.8h }, [x0], #16
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
mov	w15, #0x3
bl	output_lag3_neon
ubfx	x15, x2, #6, #11
lsr	w2, w2, #1
add	x15, x3, x15, lsl #1
ld1	{ v1.h }[0], [x15]
srshl	v1.4h, v1.4h, v31.4h
ext	v0.16b, v0.16b, v1.16b, #0x2
st1	{ v0.8h }, [x0], #16
ldr	x30, [sp], #0x10
ret
sum_uv_444_lag3_left_neon:
str	x30, [sp, #-0x10]!
sub	x11, x0, #0x1ec
sub	x12, x0, #0x148
sub	x13, x0, #0xa4
ld1	{ v14.8h }, [x11]
ld1	{ v17.8h }, [x12]
ld1	{ v20.8h }, [x13]
bl	sum_lag3_above_neon
ld1	{ v0.8h }, [x19], #16
dup	v1.8b, v30.b[8]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag3_y_left_start
sum_uv_444_lag3_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
ld1	{ v0.8h }, [x19], #16
dup	v1.8b, v30.b[8]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag3_y_mid_start
sum_uv_444_lag3_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
ld1	{ v0.8h }, [x19], #16
dup	v1.8b, v30.b[8]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag3_y_right_start
sum_uv_422_lag3_left_neon:
str	x30, [sp, #-0x10]!
sub	x11, x0, #0x1ec
sub	x12, x0, #0x148
sub	x13, x0, #0xa4
ld1	{ v14.8h }, [x11]
ld1	{ v17.8h }, [x12]
ld1	{ v20.8h }, [x13]
bl	sum_lag3_above_neon
ld1	{ v22.8h, v23.8h }, [x19], #32
addp	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x1
dup	v1.8b, v30.b[8]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag3_y_left_start
sum_uv_422_lag3_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
ld1	{ v22.8h, v23.8h }, [x19], #32
addp	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x1
dup	v1.8b, v30.b[8]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag3_y_mid_start
sum_uv_422_lag3_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
ld1	{ v22.8h, v23.8h }, [x19], #32
addp	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x1
dup	v1.8b, v30.b[8]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag3_uv_420_right_start
sum_uv_420_lag3_left_neon:
str	x30, [sp, #-0x10]!
sub	x11, x0, #0x1ec
sub	x12, x0, #0x148
sub	x13, x0, #0xa4
ld1	{ v14.8h }, [x11]
ld1	{ v17.8h }, [x12]
ld1	{ v20.8h }, [x13]
bl	sum_lag3_above_neon
add	x12, x19, #0xa4
ld1	{ v22.8h, v23.8h }, [x19], #32
ld1	{ v24.8h, v25.8h }, [x12]
addp	v22.8h, v22.8h, v23.8h
addp	v23.8h, v24.8h, v25.8h
add	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x2
dup	v1.8b, v30.b[8]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag3_y_left_start
sum_uv_420_lag3_mid_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
add	x12, x19, #0xa4
ld1	{ v22.8h, v23.8h }, [x19], #32
ld1	{ v24.8h, v25.8h }, [x12]
addp	v22.8h, v22.8h, v23.8h
addp	v23.8h, v24.8h, v25.8h
add	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x2
dup	v1.8b, v30.b[8]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
b	sum_lag3_y_mid_start
sum_uv_420_lag3_right_neon:
str	x30, [sp, #-0x10]!
bl	sum_lag3_above_neon
add	x12, x19, #0xa4
ld1	{ v22.8h, v23.8h }, [x19], #32
ld1	{ v24.8h, v25.8h }, [x12]
addp	v22.8h, v22.8h, v23.8h
addp	v23.8h, v24.8h, v25.8h
add	v22.8h, v22.8h, v23.8h
srshr	v0.8h, v22.8h, #0x2
dup	v1.8b, v30.b[8]
sshll	v1.8h, v1.8b, #0x0
smlal	v4.4s, v0.4h, v1.4h
smlal2	v5.4s, v0.8h, v1.8h
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
ext	v0.16b, v0.16b, v1.16b, #0xe
st1	{ v0.8h }, [x0], #16
ldr	x30, [sp], #0x10
ret
generate_grain_rows_neon:
str	x30, [sp, #-0x10]!
L_1028:
mov	w16, #0x50
L_102c:
bl	get_gaussian_neon
srshl	v0.8h, v0.8h, v31.8h
subs	w16, w16, #0x8
st1	{ v0.8h }, [x0], #16
b.gt	L_102c
bl	get_grain_2_neon
subs	w1, w1, #0x1
st1	{ v0.s }[0], [x0], #4
b.gt	L_1028
ldr	x30, [sp], #0x10
ret
generate_grain_rows_44_neon:
str	x30, [sp, #-0x10]!
L_105c:
mov	w16, #0x28
L_1060:
bl	get_gaussian_neon
srshl	v0.8h, v0.8h, v31.8h
subs	w16, w16, #0x8
st1	{ v0.8h }, [x0], #16
b.gt	L_1060
bl	get_grain_4_neon
subs	w1, w1, #0x1
st1	{ v0.4h }, [x0]
add	x0, x0, #0x54
b.gt	L_105c
ldr	x30, [sp], #0x10
ret
gen_grain_uv_444_lag0_neon:
str	x30, [sp, #-0x10]!
ld1	{ v4.8h }, [x19], #16
gen_grain_uv_lag0_8_start:
bl	get_gaussian_neon
srshl	v0.8h, v0.8h, v31.8h
gen_grain_uv_lag0_8_add:
and	v4.16b, v4.16b, v1.16b
smull	v2.4s, v4.4h, v27.4h
smull2	v3.4s, v4.8h, v27.8h
srshl	v2.4s, v2.4s, v28.4s
srshl	v3.4s, v3.4s, v28.4s
sqxtn	v2.4h, v2.4s
sqxtn2	v2.8h, v3.4s
sqadd	v2.8h, v2.8h, v0.8h
smin	v2.8h, v2.8h, v25.8h
smax	v2.8h, v2.8h, v26.8h
st1	{ v2.8h }, [x0], #16
ldr	x30, [sp], #0x10
ret
gen_grain_uv_420_lag0_8_neon:
add	x12, x19, #0xa4
str	x30, [sp, #-0x10]!
ld1	{ v16.8h, v17.8h }, [x19], #32
ld1	{ v18.8h, v19.8h }, [x12]
addp	v16.8h, v16.8h, v17.8h
addp	v17.8h, v18.8h, v19.8h
add	v16.8h, v16.8h, v17.8h
srshr	v4.8h, v16.8h, #0x2
b	gen_grain_uv_lag0_8_start
gen_grain_uv_422_lag0_8_neon:
str	x30, [sp, #-0x10]!
ld1	{ v16.8h, v17.8h }, [x19], #32
addp	v16.8h, v16.8h, v17.8h
srshr	v4.8h, v16.8h, #0x1
b	gen_grain_uv_lag0_8_start
gen_grain_uv_420_lag0_4_neon:
add	x12, x19, #0xa4
str	x30, [sp, #-0x10]!
ld1	{ v16.4h, v17.4h }, [x19]
ld1	{ v18.4h, v19.4h }, [x12]
add	x19, x19, #0x20
addp	v16.4h, v16.4h, v17.4h
addp	v17.4h, v18.4h, v19.4h
add	v16.4h, v16.4h, v17.4h
srshr	v4.4h, v16.4h, #0x2
bl	get_grain_4_neon
b	gen_grain_uv_lag0_8_add
gen_grain_uv_422_lag0_4_neon:
str	x30, [sp, #-0x10]!
ld1	{ v16.4h, v17.4h }, [x19]
add	x19, x19, #0x20
addp	v16.4h, v16.4h, v17.4h
srshr	v4.4h, v16.4h, #0x1
bl	get_grain_4_neon
b	gen_grain_uv_lag0_8_add
generate_grain_y_16bpc_neon:
stp	x30, x19, [sp, #-0x60]!
clz	w15, w2
adrp	x3, gaussian_sequence
add	x3, x3, :lo12:gaussian_sequence
sub	w15, w15, #0x18
ldr	w2, [x1]
ldr	w9, [x1, #0xb8]
add	x4, x1, #0x60
add	w9, w9, w15
adrp	x16, gen_grain_y_tbl
add	x16, x16, :lo12:gen_grain_y_tbl
ldr	w17, [x1, #0x5c]
add	w9, w9, #0x4
ldrsw	x17, [x16, w17, uxtw #2]
dup	v31.8h, w9
add	x16, x16, x17
neg	v31.8h, v31.8h
ldr	w7, [x1, #0xb0]
neg	w15, w15
mov	w8, #0x1
mov	w10, #0x1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #0x80
lsl	w5, w5, w15
neg	w6, w5
sub	w5, w5, #0x1
br	x16
L_11cc:
mov	w1, #0x49
bl	generate_grain_rows_neon
ldp	x30, x19, [sp], #0x60
ret
L_11dc:
ld1r	{ v27.8b }, [x4], #1
ld1r	{ v28.8b }, [x4], #1
ld1r	{ v29.8b }, [x4]
ldrsb	w4, [x4, #0x1]
mov	w1, #0x3
bl	generate_grain_rows_neon
sshll	v27.8h, v27.8b, #0x0
sshll	v28.8h, v28.8b, #0x0
sshll	v29.8h, v29.8b, #0x0
mov	w1, #0x46
L_1204:
bl	sum_y_lag1_left_neon
bl	sum_y_lag1_mid_neon
bl	sum_y_lag1_mid_neon
bl	sum_y_lag1_mid_neon
bl	sum_y_lag1_mid_neon
bl	sum_y_lag1_mid_neon
bl	sum_y_lag1_mid_neon
bl	sum_y_lag1_mid_neon
bl	sum_y_lag1_mid_neon
bl	sum_y_lag1_right_neon
bl	get_grain_2_neon
mov	v16.8b, v0.8b
subs	w1, w1, #0x1
st1	{ v16.s }[0], [x0], #4
b.gt	L_1204
ldp	x30, x19, [sp], #0x60
ret
L_1248:
ld1	{ v30.16b }, [x4]
smov	w4, v30.b[10]
smov	w17, v30.b[11]
mov	w1, #0x3
bl	generate_grain_rows_neon
mov	w1, #0x46
L_1260:
bl	sum_y_lag2_left_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_right_neon
bl	get_grain_2_neon
mov	v16.8b, v0.8b
subs	w1, w1, #0x1
st1	{ v16.s }[0], [x0], #4
b.gt	L_1260
ldp	x30, x19, [sp], #0x60
ret
L_12a4:
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
L_12d4:
bl	sum_y_lag3_left_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_right_neon
bl	get_grain_2_neon
mov	v16.8b, v0.8b
subs	w1, w1, #0x1
st1	{ v16.s }[0], [x0], #4
b.gt	L_12d4
ldp	x20, x21, [sp, #0x50]
ldp	d14, d15, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldp	x30, x19, [sp], #0x60
ret
generate_grain_uv_444_16bpc_neon:
stp	x30, x19, [sp, #-0x60]!
mov	w13, w3
mov	w14, #0x1c
add	x19, x1, #0x1ec
mov	x1, x2
mul	w13, w13, w14
clz	w15, w4
adrp	x3, gaussian_sequence
add	x3, x3, :lo12:gaussian_sequence
sub	w15, w15, #0x18
ldr	w2, [x1]
ldr	w9, [x1, #0xb8]
add	x4, x1, #0x78
add	w9, w9, w15
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
neg	w15, w15
mov	w8, #0x1
mov	w10, #0x1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #0x80
lsl	w5, w5, w15
neg	w6, w5
sub	w5, w5, #0x1
eor	w2, w2, w11
br	x16
L_13d0:
dup	v28.4s, w7
ld1r	{ v27.8b }, [x4]
movi	v0.16b, #0x0
movi	v1.16b, #0xff
dup	v25.8h, w5
dup	v26.8h, w6
ext	v29.16b, v0.16b, v1.16b, #0xa
ext	v30.16b, v1.16b, v0.16b, #0x2
neg	v28.4s, v28.4s
sshll	v27.8h, v27.8b, #0x0
mov	w1, #0x3
bl	generate_grain_rows_neon
mov	w1, #0x46
L_1404:
mov	v1.16b, v29.16b
bl	gen_grain_uv_444_lag0_neon
movi	v1.16b, #0xff
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
mov	v1.16b, v30.16b
bl	gen_grain_uv_444_lag0_neon
bl	get_grain_2_neon
mov	v16.8b, v0.8b
subs	w1, w1, #0x1
add	x19, x19, #0x4
st1	{ v16.s }[0], [x0], #4
b.gt	L_1404
ldp	x30, x19, [sp], #0x60
ret
L_1458:
ld1r	{ v27.8b }, [x4], #1
ld1r	{ v28.8b }, [x4], #1
ld1r	{ v29.8b }, [x4]
add	x4, x4, #0x2
mov	w1, #0x3
ld1r	{ v30.8b }, [x4]
ldursb	w4, [x4, #-0x1]
bl	generate_grain_rows_neon
sshll	v27.8h, v27.8b, #0x0
sshll	v28.8h, v28.8b, #0x0
sshll	v29.8h, v29.8b, #0x0
sshll	v30.8h, v30.8b, #0x0
mov	w1, #0x46
L_148c:
bl	sum_uv_444_lag1_left_neon
bl	sum_uv_444_lag1_mid_neon
bl	sum_uv_444_lag1_mid_neon
bl	sum_uv_444_lag1_mid_neon
bl	sum_uv_444_lag1_mid_neon
bl	sum_uv_444_lag1_mid_neon
bl	sum_uv_444_lag1_mid_neon
bl	sum_uv_444_lag1_mid_neon
bl	sum_uv_444_lag1_mid_neon
bl	sum_uv_444_lag1_right_neon
bl	get_grain_2_neon
mov	v16.8b, v0.8b
subs	w1, w1, #0x1
add	x19, x19, #0x4
st1	{ v16.s }[0], [x0], #4
b.gt	L_148c
ldp	x30, x19, [sp], #0x60
ret
L_14d4:
ld1	{ v30.16b }, [x4]
smov	w4, v30.b[10]
smov	w17, v30.b[11]
mov	w1, #0x3
bl	generate_grain_rows_neon
mov	w1, #0x46
L_14ec:
bl	sum_uv_444_lag2_left_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_right_neon
bl	get_grain_2_neon
mov	v16.8b, v0.8b
subs	w1, w1, #0x1
add	x19, x19, #0x4
st1	{ v16.s }[0], [x0], #4
b.gt	L_14ec
ldp	x30, x19, [sp], #0x60
ret
L_1534:
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
L_1564:
bl	sum_uv_444_lag3_left_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_right_neon
bl	get_grain_2_neon
mov	v16.8b, v0.8b
subs	w1, w1, #0x1
add	x19, x19, #0x4
st1	{ v16.s }[0], [x0], #4
b.gt	L_1564
ldp	x20, x21, [sp, #0x50]
ldp	d14, d15, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldp	x30, x19, [sp], #0x60
ret
generate_grain_uv_420_16bpc_neon:
stp	x30, x19, [sp, #-0x60]!
mov	w13, w3
mov	w14, #0x1c
add	x19, x1, #0x1e6
mov	x1, x2
mul	w13, w13, w14
clz	w15, w4
adrp	x3, gaussian_sequence
add	x3, x3, :lo12:gaussian_sequence
sub	w15, w15, #0x18
ldr	w2, [x1]
ldr	w9, [x1, #0xb8]
add	x4, x1, #0x78
add	w9, w9, w15
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
neg	w15, w15
mov	w8, #0x1
mov	w10, #0x1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #0x80
lsl	w5, w5, w15
neg	w6, w5
sub	w5, w5, #0x1
eor	w2, w2, w11
br	x16
L_1664:
dup	v28.4s, w7
ld1r	{ v27.8b }, [x4]
movi	v0.16b, #0x0
movi	v1.16b, #0xff
dup	v25.8h, w5
dup	v26.8h, w6
ext	v29.16b, v0.16b, v1.16b, #0xa
ext	v30.16b, v1.16b, v0.16b, #0xe
neg	v28.4s, v28.4s
sshll	v27.8h, v27.8b, #0x0
mov	w1, #0x3
bl	generate_grain_rows_44_neon
mov	w1, #0x23
L_1698:
mov	v1.16b, v29.16b
bl	gen_grain_uv_420_lag0_8_neon
movi	v1.16b, #0xff
bl	gen_grain_uv_420_lag0_8_neon
bl	gen_grain_uv_420_lag0_8_neon
bl	gen_grain_uv_420_lag0_8_neon
bl	gen_grain_uv_420_lag0_8_neon
mov	v1.16b, v30.16b
bl	gen_grain_uv_420_lag0_4_neon
subs	w1, w1, #0x1
add	x19, x19, #0x88
add	x0, x0, #0x44
b.gt	L_1698
ldp	x30, x19, [sp], #0x60
ret
L_16d4:
ld1r	{ v27.8b }, [x4], #1
ld1r	{ v28.8b }, [x4], #1
ld1r	{ v29.8b }, [x4]
add	x4, x4, #0x2
mov	w1, #0x3
ld1r	{ v30.8b }, [x4]
ldursb	w4, [x4, #-0x1]
bl	generate_grain_rows_44_neon
sshll	v27.8h, v27.8b, #0x0
sshll	v28.8h, v28.8b, #0x0
sshll	v29.8h, v29.8b, #0x0
sshll	v30.8h, v30.8b, #0x0
mov	w1, #0x23
L_1708:
bl	sum_uv_420_lag1_left_neon
bl	sum_uv_420_lag1_mid_neon
bl	sum_uv_420_lag1_mid_neon
bl	sum_uv_420_lag1_mid_neon
bl	sum_uv_420_lag1_mid_neon
bl	sum_uv_420_lag1_right_neon
subs	w1, w1, #0x1
add	x19, x19, #0x88
add	x0, x0, #0x44
b.gt	L_1708
ldp	x30, x19, [sp], #0x60
ret
L_1738:
ld1	{ v30.16b }, [x4]
smov	w4, v30.b[10]
smov	w17, v30.b[11]
mov	w1, #0x3
bl	generate_grain_rows_44_neon
mov	w1, #0x23
L_1750:
bl	sum_uv_420_lag2_left_neon
bl	sum_uv_420_lag2_mid_neon
bl	sum_uv_420_lag2_mid_neon
bl	sum_uv_420_lag2_mid_neon
bl	sum_uv_420_lag2_mid_neon
bl	sum_uv_420_lag2_right_neon
subs	w1, w1, #0x1
add	x19, x19, #0x88
add	x0, x0, #0x44
b.gt	L_1750
ldp	x30, x19, [sp], #0x60
ret
L_1780:
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
L_17b4:
bl	sum_uv_420_lag3_left_neon
bl	sum_uv_420_lag3_mid_neon
bl	sum_uv_420_lag3_mid_neon
bl	sum_uv_420_lag3_mid_neon
bl	sum_uv_420_lag3_mid_neon
bl	sum_uv_420_lag3_right_neon
subs	w1, w1, #0x1
add	x19, x19, #0x88
add	x0, x0, #0x44
b.gt	L_17b4
ldp	x20, x21, [sp, #0x50]
ldp	d14, d15, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldp	x30, x19, [sp], #0x60
ret
generate_grain_uv_422_16bpc_neon:
stp	x30, x19, [sp, #-0x60]!
mov	w13, w3
mov	w14, #0x1c
add	x19, x1, #0x1e6
mov	x1, x2
mul	w13, w13, w14
clz	w15, w4
adrp	x3, gaussian_sequence
add	x3, x3, :lo12:gaussian_sequence
sub	w15, w15, #0x18
ldr	w2, [x1]
ldr	w9, [x1, #0xb8]
add	x4, x1, #0x78
add	w9, w9, w15
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
neg	w15, w15
mov	w8, #0x1
mov	w10, #0x1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #0x80
lsl	w5, w5, w15
neg	w6, w5
sub	w5, w5, #0x1
eor	w2, w2, w11
br	x16
L_189c:
dup	v28.4s, w7
ld1r	{ v27.8b }, [x4]
movi	v0.16b, #0x0
movi	v1.16b, #0xff
dup	v25.8h, w5
dup	v26.8h, w6
ext	v29.16b, v0.16b, v1.16b, #0xa
ext	v30.16b, v1.16b, v0.16b, #0xe
neg	v28.4s, v28.4s
sshll	v27.8h, v27.8b, #0x0
mov	w1, #0x3
bl	generate_grain_rows_44_neon
mov	w1, #0x46
L_18d0:
mov	v1.16b, v29.16b
bl	gen_grain_uv_422_lag0_8_neon
movi	v1.16b, #0xff
bl	gen_grain_uv_422_lag0_8_neon
bl	gen_grain_uv_422_lag0_8_neon
bl	gen_grain_uv_422_lag0_8_neon
bl	gen_grain_uv_422_lag0_8_neon
mov	v1.16b, v30.16b
bl	gen_grain_uv_422_lag0_4_neon
subs	w1, w1, #0x1
sub	x19, x19, #0x1c
add	x0, x0, #0x44
b.gt	L_18d0
ldp	x30, x19, [sp], #0x60
ret
L_190c:
ld1r	{ v27.8b }, [x4], #1
ld1r	{ v28.8b }, [x4], #1
ld1r	{ v29.8b }, [x4]
add	x4, x4, #0x2
mov	w1, #0x3
ld1r	{ v30.8b }, [x4]
ldursb	w4, [x4, #-0x1]
bl	generate_grain_rows_44_neon
sshll	v27.8h, v27.8b, #0x0
sshll	v28.8h, v28.8b, #0x0
sshll	v29.8h, v29.8b, #0x0
sshll	v30.8h, v30.8b, #0x0
mov	w1, #0x46
L_1940:
bl	sum_uv_422_lag1_left_neon
bl	sum_uv_422_lag1_mid_neon
bl	sum_uv_422_lag1_mid_neon
bl	sum_uv_422_lag1_mid_neon
bl	sum_uv_422_lag1_mid_neon
bl	sum_uv_422_lag1_right_neon
subs	w1, w1, #0x1
sub	x19, x19, #0x1c
add	x0, x0, #0x44
b.gt	L_1940
ldp	x30, x19, [sp], #0x60
ret
L_1970:
ld1	{ v30.16b }, [x4]
smov	w4, v30.b[10]
smov	w17, v30.b[11]
mov	w1, #0x3
bl	generate_grain_rows_44_neon
mov	w1, #0x46
L_1988:
bl	sum_uv_422_lag2_left_neon
bl	sum_uv_422_lag2_mid_neon
bl	sum_uv_422_lag2_mid_neon
bl	sum_uv_422_lag2_mid_neon
bl	sum_uv_422_lag2_mid_neon
bl	sum_uv_422_lag2_right_neon
subs	w1, w1, #0x1
sub	x19, x19, #0x1c
add	x0, x0, #0x44
b.gt	L_1988
ldp	x30, x19, [sp], #0x60
ret
L_19b8:
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
L_19ec:
bl	sum_uv_422_lag3_left_neon
bl	sum_uv_422_lag3_mid_neon
bl	sum_uv_422_lag3_mid_neon
bl	sum_uv_422_lag3_mid_neon
bl	sum_uv_422_lag3_mid_neon
bl	sum_uv_422_lag3_right_neon
subs	w1, w1, #0x1
sub	x19, x19, #0x1c
add	x0, x0, #0x44
b.gt	L_19ec
ldp	x20, x21, [sp, #0x50]
ldp	d14, d15, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldp	x30, x19, [sp], #0x60
ret
gather32_neon:
umov	w14, v0.h[0]
umov	w15, v2.h[1]
umov	w16, v0.h[2]
add	x14, x14, x3
umov	w17, v2.h[3]
add	x15, x15, x3
ld1	{ v6.b }[0], [x14]
umov	w14, v0.h[4]
add	x16, x16, x3
ld1	{ v7.b }[1], [x15]
umov	w15, v2.h[5]
add	x17, x17, x3
ld1	{ v6.b }[2], [x16]
umov	w16, v0.h[6]
add	x14, x14, x3
ld1	{ v7.b }[3], [x17]
umov	w17, v2.h[7]
add	x15, x15, x3
ld1	{ v6.b }[4], [x14]
add	x16, x16, x3
ld1	{ v7.b }[5], [x15]
add	x17, x17, x3
ld1	{ v6.b }[6], [x16]
ld1	{ v7.b }[7], [x17]
umov	w14, v2.h[0]
umov	w15, v0.h[1]
umov	w16, v2.h[2]
add	x14, x14, x3
umov	w17, v0.h[3]
add	x15, x15, x3
ld1	{ v7.b }[0], [x14]
umov	w14, v2.h[4]
add	x16, x16, x3
ld1	{ v6.b }[1], [x15]
umov	w15, v0.h[5]
add	x17, x17, x3
ld1	{ v7.b }[2], [x16]
umov	w16, v2.h[6]
add	x14, x14, x3
ld1	{ v6.b }[3], [x17]
umov	w17, v0.h[7]
add	x15, x15, x3
ld1	{ v7.b }[4], [x14]
add	x16, x16, x3
ld1	{ v6.b }[5], [x15]
add	x17, x17, x3
ld1	{ v7.b }[6], [x16]
ld1	{ v6.b }[7], [x17]
umov	w14, v1.h[0]
umov	w15, v3.h[1]
umov	w16, v1.h[2]
add	x14, x14, x3
umov	w17, v3.h[3]
add	x15, x15, x3
ld1	{ v6.b }[8], [x14]
umov	w14, v1.h[4]
add	x16, x16, x3
ld1	{ v7.b }[9], [x15]
umov	w15, v3.h[5]
add	x17, x17, x3
ld1	{ v6.b }[10], [x16]
umov	w16, v1.h[6]
add	x14, x14, x3
ld1	{ v7.b }[11], [x17]
umov	w17, v3.h[7]
add	x15, x15, x3
ld1	{ v6.b }[12], [x14]
add	x16, x16, x3
ld1	{ v7.b }[13], [x15]
add	x17, x17, x3
ld1	{ v6.b }[14], [x16]
ld1	{ v7.b }[15], [x17]
umov	w14, v3.h[0]
umov	w15, v1.h[1]
umov	w16, v3.h[2]
add	x14, x14, x3
umov	w17, v1.h[3]
add	x15, x15, x3
ld1	{ v7.b }[8], [x14]
umov	w14, v3.h[4]
add	x16, x16, x3
ld1	{ v6.b }[9], [x15]
umov	w15, v1.h[5]
add	x17, x17, x3
ld1	{ v7.b }[10], [x16]
umov	w16, v3.h[6]
add	x14, x14, x3
ld1	{ v6.b }[11], [x17]
umov	w17, v1.h[7]
add	x15, x15, x3
ld1	{ v7.b }[12], [x14]
add	x16, x16, x3
ld1	{ v6.b }[13], [x15]
add	x17, x17, x3
ld1	{ v7.b }[14], [x16]
ld1	{ v6.b }[15], [x17]
ret
gather16_neon:
umov	w14, v0.h[0]
umov	w15, v1.h[1]
umov	w16, v0.h[2]
add	x14, x14, x3
umov	w17, v1.h[3]
add	x15, x15, x3
ld1	{ v6.b }[0], [x14]
umov	w14, v0.h[4]
add	x16, x16, x3
ld1	{ v7.b }[1], [x15]
umov	w15, v1.h[5]
add	x17, x17, x3
ld1	{ v6.b }[2], [x16]
umov	w16, v0.h[6]
add	x14, x14, x3
ld1	{ v7.b }[3], [x17]
umov	w17, v1.h[7]
add	x15, x15, x3
ld1	{ v6.b }[4], [x14]
add	x16, x16, x3
ld1	{ v7.b }[5], [x15]
add	x17, x17, x3
ld1	{ v6.b }[6], [x16]
ld1	{ v7.b }[7], [x17]
umov	w14, v1.h[0]
umov	w15, v0.h[1]
umov	w16, v1.h[2]
add	x14, x14, x3
umov	w17, v0.h[3]
add	x15, x15, x3
ld1	{ v7.b }[0], [x14]
umov	w14, v1.h[4]
add	x16, x16, x3
ld1	{ v6.b }[1], [x15]
umov	w15, v0.h[5]
add	x17, x17, x3
ld1	{ v7.b }[2], [x16]
umov	w16, v1.h[6]
add	x14, x14, x3
ld1	{ v6.b }[3], [x17]
umov	w17, v0.h[7]
add	x15, x15, x3
ld1	{ v7.b }[4], [x14]
add	x16, x16, x3
ld1	{ v6.b }[5], [x15]
add	x17, x17, x3
ld1	{ v7.b }[6], [x16]
ld1	{ v6.b }[7], [x17]
mov	v6.d[1], v7.d[0]
ret
fgy_32x32_16bpc_neon:
str	x30, [sp, #-0x50]!
stp	d8, d9, [sp, #0x10]
stp	d10, d11, [sp, #0x20]
stp	d12, d13, [sp, #0x30]
str	d14, [sp, #0x40]
eor	w4, w4, #0xf
ldr	w11, [x6, #0x8]
ldr	w13, [x6, #0x4]
ldr	w15, [x6, #0xc]
ldr	w10, [sp, #0x60]
ldr	w6, [x6]
dup	v26.8h, w10
clz	w10, w10
ldr	w8, [sp, #0x50]
sub	w10, w10, #0x18
mov	x9, #0xa4
neg	w10, w10
dup	v29.8h, w4
dup	v27.8h, w10
adrp	x16, overlap_coeffs_0
add	x16, x16, :lo12:overlap_coeffs_0
cbz	w8, L_1ce8
movi	v30.8h, #0x10
movi	v31.8h, #0xeb
sshl	v30.8h, v30.8h, v27.8h
sshl	v31.8h, v31.8h, v27.8h
b	L_1cf0
L_1ce8:
movi	v30.8h, #0x0
mov	v31.16b, v26.16b
L_1cf0:
ushr	v26.8h, v26.8h, #0x1
mvn	v25.16b, v26.16b
ld1	{ v27.4h, v28.4h }, [x16]
add	x5, x5, #0x12
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
add	x12, x12, w11, uxtw #1
madd	x14, x9, x14, x5
add	x14, x14, w13, uxtw #1
madd	x16, x9, x16, x5
add	x16, x16, w15, uxtw #1
madd	x5, x9, x10, x5
add	x5, x5, w6, uxtw #1
ldr	w11, [sp, #0x58]
adrp	x13, fgy_loop_tbl
add	x13, x13, :lo12:fgy_loop_tbl
add	x4, x12, #0x40
add	x6, x14, x9, lsl #5
tst	w11, #0x1
ldrsw	x11, [x13, w11, uxtw #2]
add	x8, x16, x9, lsl #5
add	x8, x8, #0x40
add	x11, x13, x11
b.eq	L_1da4
dup	v8.8h, v27.h[0]
dup	v9.8h, v27.h[1]
mov	w10, w7
mov	w7, #0x2
L_1da4:
br	x11
fgy_loop_neon:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x1], x2
mvni	v4.8h, #0xf0, lsl #8
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x5], x9
and	v0.16b, v0.16b, v4.16b
and	v1.16b, v1.16b, v4.16b
and	v2.16b, v2.16b, v4.16b
and	v3.16b, v3.16b, v4.16b
bl	gather32_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
ushl	v6.8h, v6.8h, v29.8h
ushl	v7.8h, v7.8h, v29.8h
sqrdmulh	v20.8h, v16.8h, v4.8h
sqrdmulh	v21.8h, v17.8h, v5.8h
sqrdmulh	v22.8h, v18.8h, v6.8h
sqrdmulh	v23.8h, v19.8h, v7.8h
usqadd	v0.8h, v20.8h
usqadd	v1.8h, v21.8h
usqadd	v2.8h, v22.8h
usqadd	v3.8h, v23.8h
umax	v0.8h, v0.8h, v30.8h
umax	v1.8h, v1.8h, v30.8h
umax	v2.8h, v2.8h, v30.8h
umax	v3.8h, v3.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w7, w7, #0x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x2
b.gt	fgy_loop_neon
ldr	d14, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldr	x30, [sp], #0x50
ret
L_1e4c:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x1], x2
ld1	{ v21.8h, v22.8h, v23.8h, v24.8h }, [x6], x9
mvni	v4.8h, #0xf0, lsl #8
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x5], x9
and	v0.16b, v0.16b, v4.16b
and	v1.16b, v1.16b, v4.16b
and	v2.16b, v2.16b, v4.16b
and	v3.16b, v3.16b, v4.16b
bl	gather32_neon
smull	v10.4s, v16.4h, v9.4h
smull2	v11.4s, v16.8h, v9.8h
smull	v12.4s, v17.4h, v9.4h
smull2	v13.4s, v17.8h, v9.8h
smull	v16.4s, v18.4h, v9.4h
smull2	v17.4s, v18.8h, v9.8h
smull	v18.4s, v19.4h, v9.4h
smull2	v19.4s, v19.8h, v9.8h
smlal	v10.4s, v21.4h, v8.4h
smlal2	v11.4s, v21.8h, v8.8h
smlal	v12.4s, v22.4h, v8.4h
smlal2	v13.4s, v22.8h, v8.8h
smlal	v16.4s, v23.4h, v8.4h
smlal2	v17.4s, v23.8h, v8.8h
smlal	v18.4s, v24.4h, v8.4h
smlal2	v19.4s, v24.8h, v8.8h
sqrshrn	v10.4h, v10.4s, #0x5
sqrshrn2	v10.8h, v11.4s, #0x5
sqrshrn	v11.4h, v12.4s, #0x5
sqrshrn2	v11.8h, v13.4s, #0x5
sqrshrn	v12.4h, v16.4s, #0x5
sqrshrn2	v12.8h, v17.4s, #0x5
sqrshrn	v13.4h, v18.4s, #0x5
sqrshrn2	v13.8h, v19.4s, #0x5
smin	v16.8h, v10.8h, v26.8h
smin	v17.8h, v11.8h, v26.8h
smin	v18.8h, v12.8h, v26.8h
smin	v19.8h, v13.8h, v26.8h
smax	v16.8h, v16.8h, v25.8h
smax	v17.8h, v17.8h, v25.8h
smax	v18.8h, v18.8h, v25.8h
smax	v19.8h, v19.8h, v25.8h
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
ushl	v6.8h, v6.8h, v29.8h
ushl	v7.8h, v7.8h, v29.8h
sqrdmulh	v20.8h, v16.8h, v4.8h
sqrdmulh	v21.8h, v17.8h, v5.8h
sqrdmulh	v22.8h, v18.8h, v6.8h
sqrdmulh	v23.8h, v19.8h, v7.8h
usqadd	v0.8h, v20.8h
usqadd	v1.8h, v21.8h
usqadd	v2.8h, v22.8h
usqadd	v3.8h, v23.8h
umax	v0.8h, v0.8h, v30.8h
umax	v1.8h, v1.8h, v30.8h
umax	v2.8h, v2.8h, v30.8h
umax	v3.8h, v3.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w7, w7, #0x1
dup	v8.8h, v28.h[0]
dup	v9.8h, v28.h[1]
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x2
b.gt	L_1e4c
cmp	w10, #0x2
sub	w7, w10, #0x2
b.gt	fgy_loop_neon
ldr	d14, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldr	x30, [sp], #0x50
ret
L_1f88:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x1], x2
ld1	{ v20.4h }, [x4], x9
mvni	v4.8h, #0xf0, lsl #8
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x5], x9
and	v0.16b, v0.16b, v4.16b
and	v1.16b, v1.16b, v4.16b
and	v2.16b, v2.16b, v4.16b
and	v3.16b, v3.16b, v4.16b
bl	gather32_neon
smull	v20.4s, v20.4h, v27.4h
smlal	v20.4s, v16.4h, v28.4h
ushll	v4.8h, v6.8b, #0x0
sqrshrn	v20.4h, v20.4s, #0x5
ushll2	v5.8h, v6.16b, #0x0
smin	v20.4h, v20.4h, v26.4h
ushll	v6.8h, v7.8b, #0x0
smax	v20.4h, v20.4h, v25.4h
ushll2	v7.8h, v7.16b, #0x0
mov	v16.d[0], v20.d[0]
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
ushl	v6.8h, v6.8h, v29.8h
ushl	v7.8h, v7.8h, v29.8h
sqrdmulh	v20.8h, v16.8h, v4.8h
sqrdmulh	v21.8h, v17.8h, v5.8h
sqrdmulh	v22.8h, v18.8h, v6.8h
sqrdmulh	v23.8h, v19.8h, v7.8h
usqadd	v0.8h, v20.8h
usqadd	v1.8h, v21.8h
usqadd	v2.8h, v22.8h
usqadd	v3.8h, v23.8h
umax	v0.8h, v0.8h, v30.8h
umax	v1.8h, v1.8h, v30.8h
umax	v2.8h, v2.8h, v30.8h
umax	v3.8h, v3.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w7, w7, #0x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x2
b.gt	L_1f88
ldr	d14, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldr	x30, [sp], #0x50
ret
L_2048:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x1], x2
ld1	{ v20.4h }, [x4], x9
ld1	{ v21.8h, v22.8h, v23.8h, v24.8h }, [x6], x9
ld1	{ v14.4h }, [x8], x9
mvni	v4.8h, #0xf0, lsl #8
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x5], x9
and	v0.16b, v0.16b, v4.16b
and	v1.16b, v1.16b, v4.16b
and	v2.16b, v2.16b, v4.16b
and	v3.16b, v3.16b, v4.16b
bl	gather32_neon
smull	v20.4s, v20.4h, v27.4h
smlal	v20.4s, v16.4h, v28.4h
smull	v14.4s, v14.4h, v27.4h
smlal	v14.4s, v21.4h, v28.4h
sqrshrn	v20.4h, v20.4s, #0x5
sqrshrn	v14.4h, v14.4s, #0x5
smin	v20.4h, v20.4h, v26.4h
smin	v14.4h, v14.4h, v26.4h
smax	v20.4h, v20.4h, v25.4h
smax	v14.4h, v14.4h, v25.4h
smull	v10.4s, v20.4h, v9.4h
smull2	v11.4s, v16.8h, v9.8h
smull	v12.4s, v17.4h, v9.4h
smull2	v13.4s, v17.8h, v9.8h
smull	v16.4s, v18.4h, v9.4h
smull2	v17.4s, v18.8h, v9.8h
smull	v18.4s, v19.4h, v9.4h
smull2	v19.4s, v19.8h, v9.8h
smlal	v10.4s, v14.4h, v8.4h
smlal2	v11.4s, v21.8h, v8.8h
smlal	v12.4s, v22.4h, v8.4h
smlal2	v13.4s, v22.8h, v8.8h
smlal	v16.4s, v23.4h, v8.4h
smlal2	v17.4s, v23.8h, v8.8h
smlal	v18.4s, v24.4h, v8.4h
smlal2	v19.4s, v24.8h, v8.8h
sqrshrn	v10.4h, v10.4s, #0x5
sqrshrn2	v10.8h, v11.4s, #0x5
sqrshrn	v11.4h, v12.4s, #0x5
sqrshrn2	v11.8h, v13.4s, #0x5
sqrshrn	v12.4h, v16.4s, #0x5
sqrshrn2	v12.8h, v17.4s, #0x5
sqrshrn	v13.4h, v18.4s, #0x5
sqrshrn2	v13.8h, v19.4s, #0x5
smin	v16.8h, v10.8h, v26.8h
smin	v17.8h, v11.8h, v26.8h
smin	v18.8h, v12.8h, v26.8h
smin	v19.8h, v13.8h, v26.8h
smax	v16.8h, v16.8h, v25.8h
smax	v17.8h, v17.8h, v25.8h
smax	v18.8h, v18.8h, v25.8h
smax	v19.8h, v19.8h, v25.8h
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
ushl	v6.8h, v6.8h, v29.8h
ushl	v7.8h, v7.8h, v29.8h
sqrdmulh	v20.8h, v16.8h, v4.8h
sqrdmulh	v21.8h, v17.8h, v5.8h
sqrdmulh	v22.8h, v18.8h, v6.8h
sqrdmulh	v23.8h, v19.8h, v7.8h
usqadd	v0.8h, v20.8h
usqadd	v1.8h, v21.8h
usqadd	v2.8h, v22.8h
usqadd	v3.8h, v23.8h
umax	v0.8h, v0.8h, v30.8h
umax	v1.8h, v1.8h, v30.8h
umax	v2.8h, v2.8h, v30.8h
umax	v3.8h, v3.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w7, w7, #0x1
dup	v8.8h, v28.h[0]
dup	v9.8h, v28.h[1]
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x2
b.gt	L_2048
cmp	w10, #0x2
sub	w7, w10, #0x2
b.gt	L_1f88
ldr	d14, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldr	x30, [sp], #0x50
ret
fguv_32x32_420_16bpc_neon:
str	x30, [sp, #-0x50]!
stp	d8, d9, [sp, #0x10]
stp	d10, d11, [sp, #0x20]
stp	d12, d13, [sp, #0x30]
stp	d14, d15, [sp, #0x40]
ldp	x8, x9, [sp, #0x50]
ldp	x10, x11, [sp, #0x60]
ldr	w16, [sp, #0x78]
ldr	w13, [x4, #0x58]
ldr	w12, [x4, #0xd8]
dup	v23.8h, w16
clz	w16, w16
eor	w13, w13, #0xf
sub	w16, w16, #0x18
add	x10, x4, x10, lsl #2
add	x14, x10, #0xc4
add	x15, x10, #0xbc
add	x10, x10, #0xcc
neg	w16, w16
ld1r	{ v8.8h }, [x14]
ld1r	{ v24.8h }, [x10]
ld1r	{ v9.8h }, [x15]
dup	v29.8h, w13
dup	v27.8h, w16
cbz	w12, L_2238
movi	v30.8h, #0x10
movi	v31.8h, #0xf0
sshl	v30.8h, v30.8h, v27.8h
sshl	v31.8h, v31.8h, v27.8h
cbz	w11, L_2240
movi	v31.8h, #0xeb
sshl	v31.8h, v31.8h, v27.8h
b	L_2240
L_2238:
movi	v30.8h, #0x0
mov	v31.16b, v23.16b
L_2240:
ushr	v15.8h, v23.8h, #0x1
sshl	v24.8h, v24.8h, v27.8h
mvn	v14.16b, v15.16b
ldr	w12, [x8, #0x8]
ldr	w14, [x8, #0x4]
ldr	w16, [x8, #0xc]
ldr	w8, [x8]
mov	x10, #0xa4
add	x5, x5, #0xc
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
add	x13, x13, w12, uxtw #1
madd	x15, x10, x15, x5
add	x15, x15, w14, uxtw #1
madd	x17, x10, x17, x5
add	x17, x17, w16, uxtw #1
madd	x5, x10, x11, x5
add	x5, x5, w8, uxtw #1
add	x4, x13, #0x20
add	x8, x15, x10, lsl #4
add	x11, x17, x10, lsl #4
add	x11, x11, #0x20
ldr	w13, [sp, #0x70]
adrp	x16, overlap_coeffs_1
add	x16, x16, :lo12:overlap_coeffs_1
adrp	x14, fguv_loop_sx1_tbl
add	x14, x14, :lo12:fguv_loop_sx1_tbl
ld1	{ v27.4h, v28.4h }, [x16]
tst	w13, #0x1
ldrsw	x13, [x14, w13, uxtw #2]
b.eq	L_22e8
sub	w12, w9, #0x1
mov	w9, #0x1
L_22e8:
add	x13, x14, x13
movi	v25.8h, #0x17
movi	v26.8h, #0x16
add	x7, x7, x7
br	x13
fguv_32x32_422_16bpc_neon:
str	x30, [sp, #-0x50]!
stp	d8, d9, [sp, #0x10]
stp	d10, d11, [sp, #0x20]
stp	d12, d13, [sp, #0x30]
stp	d14, d15, [sp, #0x40]
ldp	x8, x9, [sp, #0x50]
ldp	x10, x11, [sp, #0x60]
ldr	w16, [sp, #0x78]
ldr	w13, [x4, #0x58]
ldr	w12, [x4, #0xd8]
dup	v23.8h, w16
clz	w16, w16
eor	w13, w13, #0xf
sub	w16, w16, #0x18
add	x10, x4, x10, lsl #2
add	x14, x10, #0xc4
add	x15, x10, #0xbc
add	x10, x10, #0xcc
neg	w16, w16
ld1r	{ v8.8h }, [x14]
ld1r	{ v24.8h }, [x10]
ld1r	{ v9.8h }, [x15]
dup	v29.8h, w13
dup	v27.8h, w16
cbz	w12, L_2380
movi	v30.8h, #0x10
movi	v31.8h, #0xf0
sshl	v30.8h, v30.8h, v27.8h
sshl	v31.8h, v31.8h, v27.8h
cbz	w11, L_2388
movi	v31.8h, #0xeb
sshl	v31.8h, v31.8h, v27.8h
b	L_2388
L_2380:
movi	v30.8h, #0x0
mov	v31.16b, v23.16b
L_2388:
ushr	v15.8h, v23.8h, #0x1
sshl	v24.8h, v24.8h, v27.8h
mvn	v14.16b, v15.16b
ldr	w12, [x8, #0x8]
ldr	w14, [x8, #0x4]
ldr	w16, [x8, #0xc]
ldr	w8, [x8]
mov	x10, #0xa4
add	x5, x5, #0xc
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
add	x13, x13, w12, uxtw #1
madd	x15, x10, x15, x5
add	x15, x15, w14, uxtw #1
madd	x17, x10, x17, x5
add	x17, x17, w16, uxtw #1
madd	x5, x10, x11, x5
add	x5, x5, w8, uxtw #1
add	x4, x13, #0x20
add	x8, x15, x10, lsl #5
add	x11, x17, x10, lsl #5
add	x11, x11, #0x20
ldr	w13, [sp, #0x70]
adrp	x16, overlap_coeffs_1
add	x16, x16, :lo12:overlap_coeffs_1
adrp	x14, fguv_loop_sx1_tbl
add	x14, x14, :lo12:fguv_loop_sx1_tbl
ld1	{ v27.4h, v28.4h }, [x16]
tst	w13, #0x1
ldrsw	x13, [x14, w13, uxtw #2]
b.eq	L_2440
sub	w12, w9, #0x2
mov	w9, #0x2
L_2440:
add	x13, x14, x13
movi	v25.8h, #0x1b
movi	v26.8h, #0x11
br	x13
fguv_32x32_444_16bpc_neon:
str	x30, [sp, #-0x50]!
stp	d8, d9, [sp, #0x10]
stp	d10, d11, [sp, #0x20]
stp	d12, d13, [sp, #0x30]
stp	d14, d15, [sp, #0x40]
ldp	x8, x9, [sp, #0x50]
ldp	x10, x11, [sp, #0x60]
ldr	w16, [sp, #0x78]
ldr	w13, [x4, #0x58]
ldr	w12, [x4, #0xd8]
dup	v23.8h, w16
clz	w16, w16
eor	w13, w13, #0xf
sub	w16, w16, #0x18
add	x10, x4, x10, lsl #2
add	x14, x10, #0xc4
add	x15, x10, #0xbc
add	x10, x10, #0xcc
neg	w16, w16
ld1r	{ v8.8h }, [x14]
ld1r	{ v24.8h }, [x10]
ld1r	{ v9.8h }, [x15]
dup	v29.8h, w13
dup	v27.8h, w16
cbz	w12, L_24d4
movi	v30.8h, #0x10
movi	v31.8h, #0xf0
sshl	v30.8h, v30.8h, v27.8h
sshl	v31.8h, v31.8h, v27.8h
cbz	w11, L_24dc
movi	v31.8h, #0xeb
sshl	v31.8h, v31.8h, v27.8h
b	L_24dc
L_24d4:
movi	v30.8h, #0x0
mov	v31.16b, v23.16b
L_24dc:
ushr	v15.8h, v23.8h, #0x1
sshl	v24.8h, v24.8h, v27.8h
mvn	v14.16b, v15.16b
ldr	w12, [x8, #0x8]
ldr	w14, [x8, #0x4]
ldr	w16, [x8, #0xc]
ldr	w8, [x8]
mov	x10, #0xa4
add	x5, x5, #0x12
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
add	x13, x13, w12, uxtw #1
madd	x15, x10, x15, x5
add	x15, x15, w14, uxtw #1
madd	x17, x10, x17, x5
add	x17, x17, w16, uxtw #1
madd	x5, x10, x11, x5
add	x5, x5, w8, uxtw #1
add	x4, x13, #0x40
add	x8, x15, x10, lsl #5
add	x11, x17, x10, lsl #5
add	x11, x11, #0x40
ldr	w13, [sp, #0x70]
adrp	x16, overlap_coeffs_0
add	x16, x16, :lo12:overlap_coeffs_0
adrp	x14, fguv_loop_sx0_tbl
add	x14, x14, :lo12:fguv_loop_sx0_tbl
ld1	{ v27.4h, v28.4h }, [x16]
tst	w13, #0x1
ldrsw	x13, [x14, w13, uxtw #2]
b.eq	L_25a4
sub	w12, w9, #0x2
mov	w9, #0x2
L_25a4:
add	x13, x14, x13
movi	v25.8h, #0x1b
movi	v26.8h, #0x11
br	x13
fguv_loop_sx0_neon:
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x5], x10
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
ld1	{ v10.8h, v11.8h, v12.8h, v13.8h }, [x1], x2
smull	v4.4s, v0.4h, v8.4h
smull2	v5.4s, v0.8h, v8.8h
smull	v6.4s, v1.4h, v8.4h
smull2	v7.4s, v1.8h, v8.8h
smull	v0.4s, v2.4h, v8.4h
smull2	v1.4s, v2.8h, v8.8h
smull	v2.4s, v3.4h, v8.4h
smull2	v3.4s, v3.8h, v8.8h
smlal	v4.4s, v10.4h, v9.4h
smlal2	v5.4s, v10.8h, v9.8h
smlal	v6.4s, v11.4h, v9.4h
smlal2	v7.4s, v11.8h, v9.8h
smlal	v0.4s, v12.4h, v9.4h
smlal2	v1.4s, v12.8h, v9.8h
smlal	v2.4s, v13.4h, v9.4h
smlal2	v3.4s, v13.8h, v9.8h
shrn	v4.4h, v4.4s, #0x6
shrn2	v4.8h, v5.4s, #0x6
shrn	v5.4h, v6.4s, #0x6
shrn2	v5.8h, v7.4s, #0x6
shrn	v6.4h, v0.4s, #0x6
shrn2	v6.8h, v1.4s, #0x6
shrn	v7.4h, v2.4s, #0x6
shrn2	v7.8h, v3.4s, #0x6
add	v0.8h, v4.8h, v24.8h
add	v1.8h, v5.8h, v24.8h
add	v2.8h, v6.8h, v24.8h
add	v3.8h, v7.8h, v24.8h
movi	v20.8h, #0x0
smin	v0.8h, v0.8h, v23.8h
smin	v1.8h, v1.8h, v23.8h
smin	v2.8h, v2.8h, v23.8h
smin	v3.8h, v3.8h, v23.8h
smax	v0.8h, v0.8h, v20.8h
smax	v1.8h, v1.8h, v20.8h
smax	v2.8h, v2.8h, v20.8h
smax	v3.8h, v3.8h, v20.8h
bl	gather32_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
ushl	v6.8h, v6.8h, v29.8h
ushl	v7.8h, v7.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
sqrdmulh	v18.8h, v18.8h, v6.8h
sqrdmulh	v19.8h, v19.8h, v7.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
usqadd	v12.8h, v18.8h
usqadd	v13.8h, v19.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umax	v2.8h, v12.8h, v30.8h
umax	v3.8h, v13.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w9, w9, #0x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x2
b.gt	fguv_loop_sx0_neon
b	L_2f4c
L_26c8:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x8], x10
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x5], x10
smull	v6.4s, v16.4h, v26.4h
smull2	v7.4s, v16.8h, v26.8h
smull	v10.4s, v17.4h, v26.4h
smull2	v11.4s, v17.8h, v26.8h
smull	v16.4s, v18.4h, v26.4h
smull2	v17.4s, v18.8h, v26.8h
smull	v18.4s, v19.4h, v26.4h
smull2	v19.4s, v19.8h, v26.8h
smlal	v6.4s, v0.4h, v25.4h
smlal2	v7.4s, v0.8h, v25.8h
smlal	v10.4s, v1.4h, v25.4h
smlal2	v11.4s, v1.8h, v25.8h
smlal	v16.4s, v2.4h, v25.4h
smlal2	v17.4s, v2.8h, v25.8h
smlal	v18.4s, v3.4h, v25.4h
smlal2	v19.4s, v3.8h, v25.8h
sqrshrn	v6.4h, v6.4s, #0x5
sqrshrn2	v6.8h, v7.4s, #0x5
sqrshrn	v7.4h, v10.4s, #0x5
sqrshrn2	v7.8h, v11.4s, #0x5
sqrshrn	v10.4h, v16.4s, #0x5
sqrshrn2	v10.8h, v17.4s, #0x5
sqrshrn	v11.4h, v18.4s, #0x5
sqrshrn2	v11.8h, v19.4s, #0x5
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
smin	v16.8h, v6.8h, v15.8h
smin	v17.8h, v7.8h, v15.8h
smin	v18.8h, v10.8h, v15.8h
smin	v19.8h, v11.8h, v15.8h
smax	v16.8h, v16.8h, v14.8h
smax	v17.8h, v17.8h, v14.8h
smax	v18.8h, v18.8h, v14.8h
smax	v19.8h, v19.8h, v14.8h
ld1	{ v10.8h, v11.8h, v12.8h, v13.8h }, [x1], x2
smull	v4.4s, v0.4h, v8.4h
smull2	v5.4s, v0.8h, v8.8h
smull	v6.4s, v1.4h, v8.4h
smull2	v7.4s, v1.8h, v8.8h
smull	v0.4s, v2.4h, v8.4h
smull2	v1.4s, v2.8h, v8.8h
smull	v2.4s, v3.4h, v8.4h
smull2	v3.4s, v3.8h, v8.8h
smlal	v4.4s, v10.4h, v9.4h
smlal2	v5.4s, v10.8h, v9.8h
smlal	v6.4s, v11.4h, v9.4h
smlal2	v7.4s, v11.8h, v9.8h
smlal	v0.4s, v12.4h, v9.4h
smlal2	v1.4s, v12.8h, v9.8h
smlal	v2.4s, v13.4h, v9.4h
smlal2	v3.4s, v13.8h, v9.8h
shrn	v4.4h, v4.4s, #0x6
shrn2	v4.8h, v5.4s, #0x6
shrn	v5.4h, v6.4s, #0x6
shrn2	v5.8h, v7.4s, #0x6
shrn	v6.4h, v0.4s, #0x6
shrn2	v6.8h, v1.4s, #0x6
shrn	v7.4h, v2.4s, #0x6
shrn2	v7.8h, v3.4s, #0x6
add	v0.8h, v4.8h, v24.8h
add	v1.8h, v5.8h, v24.8h
add	v2.8h, v6.8h, v24.8h
add	v3.8h, v7.8h, v24.8h
movi	v20.8h, #0x0
smin	v0.8h, v0.8h, v23.8h
smin	v1.8h, v1.8h, v23.8h
smin	v2.8h, v2.8h, v23.8h
smin	v3.8h, v3.8h, v23.8h
smax	v0.8h, v0.8h, v20.8h
smax	v1.8h, v1.8h, v20.8h
smax	v2.8h, v2.8h, v20.8h
smax	v3.8h, v3.8h, v20.8h
bl	gather32_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
ushl	v6.8h, v6.8h, v29.8h
ushl	v7.8h, v7.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
sqrdmulh	v18.8h, v18.8h, v6.8h
sqrdmulh	v19.8h, v19.8h, v7.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
usqadd	v12.8h, v18.8h
usqadd	v13.8h, v19.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umax	v2.8h, v12.8h, v30.8h
umax	v3.8h, v13.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w9, w9, #0x1
dup	v25.8h, v28.h[0]
dup	v26.8h, v28.h[1]
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x2
b.gt	L_26c8
cmp	w12, #0x0
mov	w9, w12
b.gt	fguv_loop_sx0_neon
b	L_2f4c
L_2874:
ld1	{ v4.4h }, [x4], x10
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x5], x10
smull	v4.4s, v4.4h, v27.4h
smlal	v4.4s, v16.4h, v28.4h
sqrshrn	v4.4h, v4.4s, #0x5
smin	v4.4h, v4.4h, v15.4h
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
smax	v4.4h, v4.4h, v14.4h
ld1	{ v10.8h, v11.8h, v12.8h, v13.8h }, [x1], x2
mov	v16.d[0], v4.d[0]
smull	v4.4s, v0.4h, v8.4h
smull2	v5.4s, v0.8h, v8.8h
smull	v6.4s, v1.4h, v8.4h
smull2	v7.4s, v1.8h, v8.8h
smull	v0.4s, v2.4h, v8.4h
smull2	v1.4s, v2.8h, v8.8h
smull	v2.4s, v3.4h, v8.4h
smull2	v3.4s, v3.8h, v8.8h
smlal	v4.4s, v10.4h, v9.4h
smlal2	v5.4s, v10.8h, v9.8h
smlal	v6.4s, v11.4h, v9.4h
smlal2	v7.4s, v11.8h, v9.8h
smlal	v0.4s, v12.4h, v9.4h
smlal2	v1.4s, v12.8h, v9.8h
smlal	v2.4s, v13.4h, v9.4h
smlal2	v3.4s, v13.8h, v9.8h
shrn	v4.4h, v4.4s, #0x6
shrn2	v4.8h, v5.4s, #0x6
shrn	v5.4h, v6.4s, #0x6
shrn2	v5.8h, v7.4s, #0x6
shrn	v6.4h, v0.4s, #0x6
shrn2	v6.8h, v1.4s, #0x6
shrn	v7.4h, v2.4s, #0x6
shrn2	v7.8h, v3.4s, #0x6
add	v0.8h, v4.8h, v24.8h
add	v1.8h, v5.8h, v24.8h
add	v2.8h, v6.8h, v24.8h
add	v3.8h, v7.8h, v24.8h
movi	v20.8h, #0x0
smin	v0.8h, v0.8h, v23.8h
smin	v1.8h, v1.8h, v23.8h
smin	v2.8h, v2.8h, v23.8h
smin	v3.8h, v3.8h, v23.8h
smax	v0.8h, v0.8h, v20.8h
smax	v1.8h, v1.8h, v20.8h
smax	v2.8h, v2.8h, v20.8h
smax	v3.8h, v3.8h, v20.8h
bl	gather32_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
ushl	v6.8h, v6.8h, v29.8h
ushl	v7.8h, v7.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
sqrdmulh	v18.8h, v18.8h, v6.8h
sqrdmulh	v19.8h, v19.8h, v7.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
usqadd	v12.8h, v18.8h
usqadd	v13.8h, v19.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umax	v2.8h, v12.8h, v30.8h
umax	v3.8h, v13.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w9, w9, #0x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x2
b.gt	L_2874
b	L_2f4c
L_29a4:
ld1	{ v4.4h }, [x4], x10
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x8], x10
ld1	{ v5.4h }, [x11], x10
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x5], x10
smull	v4.4s, v4.4h, v27.4h
smlal	v4.4s, v16.4h, v28.4h
smull	v5.4s, v5.4h, v27.4h
smlal	v5.4s, v0.4h, v28.4h
sqrshrn	v4.4h, v4.4s, #0x5
sqrshrn	v5.4h, v5.4s, #0x5
smin	v4.4h, v4.4h, v15.4h
smin	v5.4h, v5.4h, v15.4h
smax	v4.4h, v4.4h, v14.4h
smax	v5.4h, v5.4h, v14.4h
mov	v16.d[0], v4.d[0]
mov	v0.d[0], v5.d[0]
smull	v6.4s, v16.4h, v26.4h
smull2	v7.4s, v16.8h, v26.8h
smull	v10.4s, v17.4h, v26.4h
smull2	v11.4s, v17.8h, v26.8h
smull	v16.4s, v18.4h, v26.4h
smull2	v17.4s, v18.8h, v26.8h
smull	v18.4s, v19.4h, v26.4h
smull2	v19.4s, v19.8h, v26.8h
smlal	v6.4s, v0.4h, v25.4h
smlal2	v7.4s, v0.8h, v25.8h
smlal	v10.4s, v1.4h, v25.4h
smlal2	v11.4s, v1.8h, v25.8h
smlal	v16.4s, v2.4h, v25.4h
smlal2	v17.4s, v2.8h, v25.8h
smlal	v18.4s, v3.4h, v25.4h
smlal2	v19.4s, v3.8h, v25.8h
sqrshrn	v6.4h, v6.4s, #0x5
sqrshrn2	v6.8h, v7.4s, #0x5
sqrshrn	v7.4h, v10.4s, #0x5
sqrshrn2	v7.8h, v11.4s, #0x5
sqrshrn	v10.4h, v16.4s, #0x5
sqrshrn2	v10.8h, v17.4s, #0x5
sqrshrn	v11.4h, v18.4s, #0x5
sqrshrn2	v11.8h, v19.4s, #0x5
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
smin	v16.8h, v6.8h, v15.8h
smin	v17.8h, v7.8h, v15.8h
smin	v18.8h, v10.8h, v15.8h
smin	v19.8h, v11.8h, v15.8h
smax	v16.8h, v16.8h, v14.8h
smax	v17.8h, v17.8h, v14.8h
smax	v18.8h, v18.8h, v14.8h
smax	v19.8h, v19.8h, v14.8h
ld1	{ v10.8h, v11.8h, v12.8h, v13.8h }, [x1], x2
smull	v4.4s, v0.4h, v8.4h
smull2	v5.4s, v0.8h, v8.8h
smull	v6.4s, v1.4h, v8.4h
smull2	v7.4s, v1.8h, v8.8h
smull	v0.4s, v2.4h, v8.4h
smull2	v1.4s, v2.8h, v8.8h
smull	v2.4s, v3.4h, v8.4h
smull2	v3.4s, v3.8h, v8.8h
smlal	v4.4s, v10.4h, v9.4h
smlal2	v5.4s, v10.8h, v9.8h
smlal	v6.4s, v11.4h, v9.4h
smlal2	v7.4s, v11.8h, v9.8h
smlal	v0.4s, v12.4h, v9.4h
smlal2	v1.4s, v12.8h, v9.8h
smlal	v2.4s, v13.4h, v9.4h
smlal2	v3.4s, v13.8h, v9.8h
shrn	v4.4h, v4.4s, #0x6
shrn2	v4.8h, v5.4s, #0x6
shrn	v5.4h, v6.4s, #0x6
shrn2	v5.8h, v7.4s, #0x6
shrn	v6.4h, v0.4s, #0x6
shrn2	v6.8h, v1.4s, #0x6
shrn	v7.4h, v2.4s, #0x6
shrn2	v7.8h, v3.4s, #0x6
add	v0.8h, v4.8h, v24.8h
add	v1.8h, v5.8h, v24.8h
add	v2.8h, v6.8h, v24.8h
add	v3.8h, v7.8h, v24.8h
movi	v20.8h, #0x0
smin	v0.8h, v0.8h, v23.8h
smin	v1.8h, v1.8h, v23.8h
smin	v2.8h, v2.8h, v23.8h
smin	v3.8h, v3.8h, v23.8h
smax	v0.8h, v0.8h, v20.8h
smax	v1.8h, v1.8h, v20.8h
smax	v2.8h, v2.8h, v20.8h
smax	v3.8h, v3.8h, v20.8h
bl	gather32_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
ushl	v6.8h, v6.8h, v29.8h
ushl	v7.8h, v7.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
sqrdmulh	v18.8h, v18.8h, v6.8h
sqrdmulh	v19.8h, v19.8h, v7.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
usqadd	v12.8h, v18.8h
usqadd	v13.8h, v19.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umax	v2.8h, v12.8h, v30.8h
umax	v3.8h, v13.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w9, w9, #0x1
dup	v25.8h, v28.h[0]
dup	v26.8h, v28.h[1]
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x2
b.gt	L_29a4
cmp	w12, #0x0
mov	w9, w12
b.gt	L_2874
b	L_2f4c
L_2b88:
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x5], x10
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
ld1	{ v10.8h, v11.8h, v12.8h, v13.8h }, [x1], x2
and	v0.16b, v0.16b, v23.16b
and	v1.16b, v1.16b, v23.16b
and	v2.16b, v2.16b, v23.16b
and	v3.16b, v3.16b, v23.16b
bl	gather32_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
ushl	v6.8h, v6.8h, v29.8h
ushl	v7.8h, v7.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
sqrdmulh	v18.8h, v18.8h, v6.8h
sqrdmulh	v19.8h, v19.8h, v7.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
usqadd	v12.8h, v18.8h
usqadd	v13.8h, v19.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umax	v2.8h, v12.8h, v30.8h
umax	v3.8h, v13.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w9, w9, #0x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x2
b.gt	L_2b88
b	L_2f4c
L_2c18:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x8], x10
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x5], x10
smull	v6.4s, v16.4h, v26.4h
smull2	v7.4s, v16.8h, v26.8h
smull	v10.4s, v17.4h, v26.4h
smull2	v11.4s, v17.8h, v26.8h
smull	v16.4s, v18.4h, v26.4h
smull2	v17.4s, v18.8h, v26.8h
smull	v18.4s, v19.4h, v26.4h
smull2	v19.4s, v19.8h, v26.8h
smlal	v6.4s, v0.4h, v25.4h
smlal2	v7.4s, v0.8h, v25.8h
smlal	v10.4s, v1.4h, v25.4h
smlal2	v11.4s, v1.8h, v25.8h
smlal	v16.4s, v2.4h, v25.4h
smlal2	v17.4s, v2.8h, v25.8h
smlal	v18.4s, v3.4h, v25.4h
smlal2	v19.4s, v3.8h, v25.8h
sqrshrn	v6.4h, v6.4s, #0x5
sqrshrn2	v6.8h, v7.4s, #0x5
sqrshrn	v7.4h, v10.4s, #0x5
sqrshrn2	v7.8h, v11.4s, #0x5
sqrshrn	v10.4h, v16.4s, #0x5
sqrshrn2	v10.8h, v17.4s, #0x5
sqrshrn	v11.4h, v18.4s, #0x5
sqrshrn2	v11.8h, v19.4s, #0x5
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
smin	v16.8h, v6.8h, v15.8h
smin	v17.8h, v7.8h, v15.8h
smin	v18.8h, v10.8h, v15.8h
smin	v19.8h, v11.8h, v15.8h
smax	v16.8h, v16.8h, v14.8h
smax	v17.8h, v17.8h, v14.8h
smax	v18.8h, v18.8h, v14.8h
smax	v19.8h, v19.8h, v14.8h
ld1	{ v10.8h, v11.8h, v12.8h, v13.8h }, [x1], x2
and	v0.16b, v0.16b, v23.16b
and	v1.16b, v1.16b, v23.16b
and	v2.16b, v2.16b, v23.16b
and	v3.16b, v3.16b, v23.16b
bl	gather32_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
ushl	v6.8h, v6.8h, v29.8h
ushl	v7.8h, v7.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
sqrdmulh	v18.8h, v18.8h, v6.8h
sqrdmulh	v19.8h, v19.8h, v7.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
usqadd	v12.8h, v18.8h
usqadd	v13.8h, v19.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umax	v2.8h, v12.8h, v30.8h
umax	v3.8h, v13.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w9, w9, #0x1
dup	v25.8h, v28.h[0]
dup	v26.8h, v28.h[1]
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x2
b.gt	L_2c18
cmp	w12, #0x0
mov	w9, w12
b.gt	L_2b88
b	L_2f4c
L_2d40:
ld1	{ v4.4h }, [x4], x10
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x5], x10
smull	v4.4s, v4.4h, v27.4h
smlal	v4.4s, v16.4h, v28.4h
sqrshrn	v4.4h, v4.4s, #0x5
smin	v4.4h, v4.4h, v15.4h
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
smax	v4.4h, v4.4h, v14.4h
ld1	{ v10.8h, v11.8h, v12.8h, v13.8h }, [x1], x2
mov	v16.d[0], v4.d[0]
and	v0.16b, v0.16b, v23.16b
and	v1.16b, v1.16b, v23.16b
and	v2.16b, v2.16b, v23.16b
and	v3.16b, v3.16b, v23.16b
bl	gather32_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
ushl	v6.8h, v6.8h, v29.8h
ushl	v7.8h, v7.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
sqrdmulh	v18.8h, v18.8h, v6.8h
sqrdmulh	v19.8h, v19.8h, v7.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
usqadd	v12.8h, v18.8h
usqadd	v13.8h, v19.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umax	v2.8h, v12.8h, v30.8h
umax	v3.8h, v13.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w9, w9, #0x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x2
b.gt	L_2d40
b	L_2f4c
L_2dec:
ld1	{ v4.4h }, [x4], x10
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x8], x10
ld1	{ v5.4h }, [x11], x10
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x5], x10
smull	v4.4s, v4.4h, v27.4h
smlal	v4.4s, v16.4h, v28.4h
smull	v5.4s, v5.4h, v27.4h
smlal	v5.4s, v0.4h, v28.4h
sqrshrn	v4.4h, v4.4s, #0x5
sqrshrn	v5.4h, v5.4s, #0x5
smin	v4.4h, v4.4h, v15.4h
smin	v5.4h, v5.4h, v15.4h
smax	v4.4h, v4.4h, v14.4h
smax	v5.4h, v5.4h, v14.4h
mov	v16.d[0], v4.d[0]
mov	v0.d[0], v5.d[0]
smull	v6.4s, v16.4h, v26.4h
smull2	v7.4s, v16.8h, v26.8h
smull	v10.4s, v17.4h, v26.4h
smull2	v11.4s, v17.8h, v26.8h
smull	v16.4s, v18.4h, v26.4h
smull2	v17.4s, v18.8h, v26.8h
smull	v18.4s, v19.4h, v26.4h
smull2	v19.4s, v19.8h, v26.8h
smlal	v6.4s, v0.4h, v25.4h
smlal2	v7.4s, v0.8h, v25.8h
smlal	v10.4s, v1.4h, v25.4h
smlal2	v11.4s, v1.8h, v25.8h
smlal	v16.4s, v2.4h, v25.4h
smlal2	v17.4s, v2.8h, v25.8h
smlal	v18.4s, v3.4h, v25.4h
smlal2	v19.4s, v3.8h, v25.8h
sqrshrn	v6.4h, v6.4s, #0x5
sqrshrn2	v6.8h, v7.4s, #0x5
sqrshrn	v7.4h, v10.4s, #0x5
sqrshrn2	v7.8h, v11.4s, #0x5
sqrshrn	v10.4h, v16.4s, #0x5
sqrshrn2	v10.8h, v17.4s, #0x5
sqrshrn	v11.4h, v18.4s, #0x5
sqrshrn2	v11.8h, v19.4s, #0x5
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
smin	v16.8h, v6.8h, v15.8h
smin	v17.8h, v7.8h, v15.8h
smin	v18.8h, v10.8h, v15.8h
smin	v19.8h, v11.8h, v15.8h
smax	v16.8h, v16.8h, v14.8h
smax	v17.8h, v17.8h, v14.8h
smax	v18.8h, v18.8h, v14.8h
smax	v19.8h, v19.8h, v14.8h
ld1	{ v10.8h, v11.8h, v12.8h, v13.8h }, [x1], x2
and	v0.16b, v0.16b, v23.16b
and	v1.16b, v1.16b, v23.16b
and	v2.16b, v2.16b, v23.16b
and	v3.16b, v3.16b, v23.16b
bl	gather32_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
ushl	v6.8h, v6.8h, v29.8h
ushl	v7.8h, v7.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
sqrdmulh	v18.8h, v18.8h, v6.8h
sqrdmulh	v19.8h, v19.8h, v7.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
usqadd	v12.8h, v18.8h
usqadd	v13.8h, v19.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umax	v2.8h, v12.8h, v30.8h
umax	v3.8h, v13.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w9, w9, #0x1
dup	v25.8h, v28.h[0]
dup	v26.8h, v28.h[1]
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x2
b.gt	L_2dec
cmp	w12, #0x0
mov	w9, w12
b.gt	L_2d40
b	L_2f4c
L_2f4c:
ldp	d14, d15, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldr	x30, [sp], #0x50
ret
fguv_loop_sx1_neon:
ld1	{ v16.8h, v17.8h }, [x5], x10
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
ld1	{ v10.8h, v11.8h }, [x1], x2
addp	v0.8h, v0.8h, v1.8h
addp	v1.8h, v2.8h, v3.8h
urshr	v0.8h, v0.8h, #0x1
urshr	v1.8h, v1.8h, #0x1
smull	v2.4s, v0.4h, v8.4h
smull2	v3.4s, v0.8h, v8.8h
smull	v0.4s, v1.4h, v8.4h
smull2	v1.4s, v1.8h, v8.8h
smlal	v2.4s, v10.4h, v9.4h
smlal2	v3.4s, v10.8h, v9.8h
smlal	v0.4s, v11.4h, v9.4h
smlal2	v1.4s, v11.8h, v9.8h
shrn	v2.4h, v2.4s, #0x6
shrn2	v2.8h, v3.4s, #0x6
shrn	v3.4h, v0.4s, #0x6
shrn2	v3.8h, v1.4s, #0x6
add	v0.8h, v2.8h, v24.8h
add	v1.8h, v3.8h, v24.8h
movi	v2.8h, #0x0
smin	v0.8h, v0.8h, v23.8h
smin	v1.8h, v1.8h, v23.8h
smax	v0.8h, v0.8h, v2.8h
smax	v1.8h, v1.8h, v2.8h
bl	gather16_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
subs	w9, w9, #0x1
st1	{ v0.8h, v1.8h }, [x0], x2
b.gt	fguv_loop_sx1_neon
b	L_35cc
L_3010:
ld1	{ v20.8h, v21.8h }, [x8], x10
ld1	{ v16.8h, v17.8h }, [x5], x10
smull	v0.4s, v16.4h, v26.4h
smull2	v1.4s, v16.8h, v26.8h
smull	v2.4s, v17.4h, v26.4h
smull2	v3.4s, v17.8h, v26.8h
smlal	v0.4s, v20.4h, v25.4h
smlal2	v1.4s, v20.8h, v25.8h
smlal	v2.4s, v21.4h, v25.4h
smlal2	v3.4s, v21.8h, v25.8h
sqrshrn	v16.4h, v0.4s, #0x5
sqrshrn2	v16.8h, v1.4s, #0x5
sqrshrn	v17.4h, v2.4s, #0x5
sqrshrn2	v17.8h, v3.4s, #0x5
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
smin	v16.8h, v16.8h, v15.8h
smin	v17.8h, v17.8h, v15.8h
smax	v16.8h, v16.8h, v14.8h
smax	v17.8h, v17.8h, v14.8h
ld1	{ v10.8h, v11.8h }, [x1], x2
addp	v0.8h, v0.8h, v1.8h
addp	v1.8h, v2.8h, v3.8h
urshr	v0.8h, v0.8h, #0x1
urshr	v1.8h, v1.8h, #0x1
smull	v2.4s, v0.4h, v8.4h
smull2	v3.4s, v0.8h, v8.8h
smull	v0.4s, v1.4h, v8.4h
smull2	v1.4s, v1.8h, v8.8h
smlal	v2.4s, v10.4h, v9.4h
smlal2	v3.4s, v10.8h, v9.8h
smlal	v0.4s, v11.4h, v9.4h
smlal2	v1.4s, v11.8h, v9.8h
shrn	v2.4h, v2.4s, #0x6
shrn2	v2.8h, v3.4s, #0x6
shrn	v3.4h, v0.4s, #0x6
shrn2	v3.8h, v1.4s, #0x6
add	v0.8h, v2.8h, v24.8h
add	v1.8h, v3.8h, v24.8h
movi	v2.8h, #0x0
smin	v0.8h, v0.8h, v23.8h
smin	v1.8h, v1.8h, v23.8h
smax	v0.8h, v0.8h, v2.8h
smax	v1.8h, v1.8h, v2.8h
bl	gather16_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
mov	v16.16b, v25.16b
subs	w9, w9, #0x1
mov	v25.16b, v26.16b
mov	v26.16b, v16.16b
st1	{ v0.8h, v1.8h }, [x0], x2
b.gt	L_3010
cmp	w12, #0x0
mov	w9, w12
b.gt	fguv_loop_sx1_neon
b	L_35cc
L_3118:
ld1	{ v18.4h }, [x4], x10
ld1	{ v16.8h, v17.8h }, [x5], x10
smull	v18.4s, v18.4h, v27.4h
smlal	v18.4s, v16.4h, v28.4h
sqrshrn	v18.4h, v18.4s, #0x5
smin	v18.4h, v18.4h, v15.4h
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
smax	v18.4h, v18.4h, v14.4h
ld1	{ v10.8h, v11.8h }, [x1], x2
mov	v16.d[0], v18.d[0]
addp	v0.8h, v0.8h, v1.8h
addp	v1.8h, v2.8h, v3.8h
urshr	v0.8h, v0.8h, #0x1
urshr	v1.8h, v1.8h, #0x1
smull	v2.4s, v0.4h, v8.4h
smull2	v3.4s, v0.8h, v8.8h
smull	v0.4s, v1.4h, v8.4h
smull2	v1.4s, v1.8h, v8.8h
smlal	v2.4s, v10.4h, v9.4h
smlal2	v3.4s, v10.8h, v9.8h
smlal	v0.4s, v11.4h, v9.4h
smlal2	v1.4s, v11.8h, v9.8h
shrn	v2.4h, v2.4s, #0x6
shrn2	v2.8h, v3.4s, #0x6
shrn	v3.4h, v0.4s, #0x6
shrn2	v3.8h, v1.4s, #0x6
add	v0.8h, v2.8h, v24.8h
add	v1.8h, v3.8h, v24.8h
movi	v2.8h, #0x0
smin	v0.8h, v0.8h, v23.8h
smin	v1.8h, v1.8h, v23.8h
smax	v0.8h, v0.8h, v2.8h
smax	v1.8h, v1.8h, v2.8h
bl	gather16_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
subs	w9, w9, #0x1
st1	{ v0.8h, v1.8h }, [x0], x2
b.gt	L_3118
b	L_35cc
L_31e0:
ld1	{ v18.4h }, [x4], x10
ld1	{ v20.8h, v21.8h }, [x8], x10
ld1	{ v19.4h }, [x11], x10
ld1	{ v16.8h, v17.8h }, [x5], x10
smull	v18.4s, v18.4h, v27.4h
smlal	v18.4s, v16.4h, v28.4h
smull	v19.4s, v19.4h, v27.4h
smlal	v19.4s, v20.4h, v28.4h
sqrshrn	v18.4h, v18.4s, #0x5
sqrshrn	v19.4h, v19.4s, #0x5
smin	v18.4h, v18.4h, v15.4h
smin	v19.4h, v19.4h, v15.4h
smax	v18.4h, v18.4h, v14.4h
smax	v19.4h, v19.4h, v14.4h
mov	v16.d[0], v18.d[0]
mov	v20.d[0], v19.d[0]
smull	v0.4s, v16.4h, v26.4h
smull2	v1.4s, v16.8h, v26.8h
smull	v2.4s, v17.4h, v26.4h
smull2	v3.4s, v17.8h, v26.8h
smlal	v0.4s, v20.4h, v25.4h
smlal2	v1.4s, v20.8h, v25.8h
smlal	v2.4s, v21.4h, v25.4h
smlal2	v3.4s, v21.8h, v25.8h
sqrshrn	v16.4h, v0.4s, #0x5
sqrshrn2	v16.8h, v1.4s, #0x5
sqrshrn	v17.4h, v2.4s, #0x5
sqrshrn2	v17.8h, v3.4s, #0x5
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
smin	v16.8h, v16.8h, v15.8h
smin	v17.8h, v17.8h, v15.8h
smax	v16.8h, v16.8h, v14.8h
smax	v17.8h, v17.8h, v14.8h
ld1	{ v10.8h, v11.8h }, [x1], x2
addp	v0.8h, v0.8h, v1.8h
addp	v1.8h, v2.8h, v3.8h
urshr	v0.8h, v0.8h, #0x1
urshr	v1.8h, v1.8h, #0x1
smull	v2.4s, v0.4h, v8.4h
smull2	v3.4s, v0.8h, v8.8h
smull	v0.4s, v1.4h, v8.4h
smull2	v1.4s, v1.8h, v8.8h
smlal	v2.4s, v10.4h, v9.4h
smlal2	v3.4s, v10.8h, v9.8h
smlal	v0.4s, v11.4h, v9.4h
smlal2	v1.4s, v11.8h, v9.8h
shrn	v2.4h, v2.4s, #0x6
shrn2	v2.8h, v3.4s, #0x6
shrn	v3.4h, v0.4s, #0x6
shrn2	v3.8h, v1.4s, #0x6
add	v0.8h, v2.8h, v24.8h
add	v1.8h, v3.8h, v24.8h
movi	v2.8h, #0x0
smin	v0.8h, v0.8h, v23.8h
smin	v1.8h, v1.8h, v23.8h
smax	v0.8h, v0.8h, v2.8h
smax	v1.8h, v1.8h, v2.8h
bl	gather16_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
mov	v16.16b, v25.16b
subs	w9, w9, #0x1
mov	v25.16b, v26.16b
mov	v26.16b, v16.16b
st1	{ v0.8h, v1.8h }, [x0], x2
b.gt	L_31e0
cmp	w12, #0x0
mov	w9, w12
b.gt	L_3118
b	L_35cc
L_3320:
ld1	{ v16.8h, v17.8h }, [x5], x10
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
ld1	{ v10.8h, v11.8h }, [x1], x2
addp	v0.8h, v0.8h, v1.8h
addp	v1.8h, v2.8h, v3.8h
urshr	v0.8h, v0.8h, #0x1
urshr	v1.8h, v1.8h, #0x1
and	v0.16b, v0.16b, v23.16b
and	v1.16b, v1.16b, v23.16b
bl	gather16_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
subs	w9, w9, #0x1
st1	{ v0.8h, v1.8h }, [x0], x2
b.gt	L_3320
b	L_35cc
L_3388:
ld1	{ v20.8h, v21.8h }, [x8], x10
ld1	{ v16.8h, v17.8h }, [x5], x10
smull	v0.4s, v16.4h, v26.4h
smull2	v1.4s, v16.8h, v26.8h
smull	v2.4s, v17.4h, v26.4h
smull2	v3.4s, v17.8h, v26.8h
smlal	v0.4s, v20.4h, v25.4h
smlal2	v1.4s, v20.8h, v25.8h
smlal	v2.4s, v21.4h, v25.4h
smlal2	v3.4s, v21.8h, v25.8h
sqrshrn	v16.4h, v0.4s, #0x5
sqrshrn2	v16.8h, v1.4s, #0x5
sqrshrn	v17.4h, v2.4s, #0x5
sqrshrn2	v17.8h, v3.4s, #0x5
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
smin	v16.8h, v16.8h, v15.8h
smin	v17.8h, v17.8h, v15.8h
smax	v16.8h, v16.8h, v14.8h
smax	v17.8h, v17.8h, v14.8h
ld1	{ v10.8h, v11.8h }, [x1], x2
addp	v0.8h, v0.8h, v1.8h
addp	v1.8h, v2.8h, v3.8h
urshr	v0.8h, v0.8h, #0x1
urshr	v1.8h, v1.8h, #0x1
and	v0.16b, v0.16b, v23.16b
and	v1.16b, v1.16b, v23.16b
bl	gather16_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
mov	v16.16b, v25.16b
subs	w9, w9, #0x1
mov	v25.16b, v26.16b
mov	v26.16b, v16.16b
st1	{ v0.8h, v1.8h }, [x0], x2
b.gt	L_3388
cmp	w12, #0x0
mov	w9, w12
b.gt	L_3320
b	L_35cc
L_344c:
ld1	{ v18.4h }, [x4], x10
ld1	{ v16.8h, v17.8h }, [x5], x10
smull	v18.4s, v18.4h, v27.4h
smlal	v18.4s, v16.4h, v28.4h
sqrshrn	v18.4h, v18.4s, #0x5
smin	v18.4h, v18.4h, v15.4h
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
smax	v18.4h, v18.4h, v14.4h
ld1	{ v10.8h, v11.8h }, [x1], x2
mov	v16.d[0], v18.d[0]
addp	v0.8h, v0.8h, v1.8h
addp	v1.8h, v2.8h, v3.8h
urshr	v0.8h, v0.8h, #0x1
urshr	v1.8h, v1.8h, #0x1
and	v0.16b, v0.16b, v23.16b
and	v1.16b, v1.16b, v23.16b
bl	gather16_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
subs	w9, w9, #0x1
st1	{ v0.8h, v1.8h }, [x0], x2
b.gt	L_344c
b	L_35cc
L_34d0:
ld1	{ v18.4h }, [x4], x10
ld1	{ v20.8h, v21.8h }, [x8], x10
ld1	{ v19.4h }, [x11], x10
ld1	{ v16.8h, v17.8h }, [x5], x10
smull	v18.4s, v18.4h, v27.4h
smlal	v18.4s, v16.4h, v28.4h
smull	v19.4s, v19.4h, v27.4h
smlal	v19.4s, v20.4h, v28.4h
sqrshrn	v18.4h, v18.4s, #0x5
sqrshrn	v19.4h, v19.4s, #0x5
smin	v18.4h, v18.4h, v15.4h
smin	v19.4h, v19.4h, v15.4h
smax	v18.4h, v18.4h, v14.4h
smax	v19.4h, v19.4h, v14.4h
mov	v16.d[0], v18.d[0]
mov	v20.d[0], v19.d[0]
smull	v0.4s, v16.4h, v26.4h
smull2	v1.4s, v16.8h, v26.8h
smull	v2.4s, v17.4h, v26.4h
smull2	v3.4s, v17.8h, v26.8h
smlal	v0.4s, v20.4h, v25.4h
smlal2	v1.4s, v20.8h, v25.8h
smlal	v2.4s, v21.4h, v25.4h
smlal2	v3.4s, v21.8h, v25.8h
sqrshrn	v16.4h, v0.4s, #0x5
sqrshrn2	v16.8h, v1.4s, #0x5
sqrshrn	v17.4h, v2.4s, #0x5
sqrshrn2	v17.8h, v3.4s, #0x5
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
smin	v16.8h, v16.8h, v15.8h
smin	v17.8h, v17.8h, v15.8h
smax	v16.8h, v16.8h, v14.8h
smax	v17.8h, v17.8h, v14.8h
ld1	{ v10.8h, v11.8h }, [x1], x2
addp	v0.8h, v0.8h, v1.8h
addp	v1.8h, v2.8h, v3.8h
urshr	v0.8h, v0.8h, #0x1
urshr	v1.8h, v1.8h, #0x1
and	v0.16b, v0.16b, v23.16b
and	v1.16b, v1.16b, v23.16b
bl	gather16_neon
ushll	v4.8h, v6.8b, #0x0
ushll2	v5.8h, v6.16b, #0x0
ushl	v4.8h, v4.8h, v29.8h
ushl	v5.8h, v5.8h, v29.8h
sqrdmulh	v16.8h, v16.8h, v4.8h
sqrdmulh	v17.8h, v17.8h, v5.8h
usqadd	v10.8h, v16.8h
usqadd	v11.8h, v17.8h
umax	v0.8h, v10.8h, v30.8h
umax	v1.8h, v11.8h, v30.8h
umin	v0.8h, v0.8h, v31.8h
umin	v1.8h, v1.8h, v31.8h
mov	v16.16b, v25.16b
subs	w9, w9, #0x1
mov	v25.16b, v26.16b
mov	v26.16b, v16.16b
st1	{ v0.8h, v1.8h }, [x0], x2
b.gt	L_34d0
cmp	w12, #0x0
mov	w9, w12
b.gt	L_344c
b	L_35cc
L_35cc:
ldp	d14, d15, [sp, #0x40]
ldp	d12, d13, [sp, #0x30]
ldp	d10, d11, [sp, #0x20]
ldp	d8, d9, [sp, #0x10]
ldr	x30, [sp], #0x50
ret
	.section *UND*
	.section .rodata
gen_grain_y_tbl:
	.size gen_grain_y_tbl, 16
	.word L_11cc - gen_grain_y_tbl
	.word L_11dc - gen_grain_y_tbl
	.word L_1248 - gen_grain_y_tbl
	.word L_12a4 - gen_grain_y_tbl
gen_grain_uv_444_tbl:
	.size gen_grain_uv_444_tbl, 16
	.word L_13d0 - gen_grain_uv_444_tbl
	.word L_1458 - gen_grain_uv_444_tbl
	.word L_14d4 - gen_grain_uv_444_tbl
	.word L_1534 - gen_grain_uv_444_tbl
gen_grain_uv_420_tbl:
	.size gen_grain_uv_420_tbl, 16
	.word L_1664 - gen_grain_uv_420_tbl
	.word L_16d4 - gen_grain_uv_420_tbl
	.word L_1738 - gen_grain_uv_420_tbl
	.word L_1780 - gen_grain_uv_420_tbl
gen_grain_uv_422_tbl:
	.size gen_grain_uv_422_tbl, 16
	.word L_189c - gen_grain_uv_422_tbl
	.word L_190c - gen_grain_uv_422_tbl
	.word L_1970 - gen_grain_uv_422_tbl
	.word L_19b8 - gen_grain_uv_422_tbl
overlap_coeffs_0:
	.size overlap_coeffs_0, 16
	.byte 27,0,17,0,0,0,0,0,17,0,27,0,32,0,32,0
overlap_coeffs_1:
	.size overlap_coeffs_1, 16
	.byte 23,0,0,0,0,0,0,0,22,0,32,0,32,0,32,0
fgy_loop_tbl:
	.size fgy_loop_tbl, 16
	.word fgy_loop_neon - fgy_loop_tbl
	.word L_1e4c - fgy_loop_tbl
	.word L_1f88 - fgy_loop_tbl
	.word L_2048 - fgy_loop_tbl
fguv_loop_sx0_tbl:
	.size fguv_loop_sx0_tbl, 32
	.word fguv_loop_sx0_neon - fguv_loop_sx0_tbl
	.word L_26c8 - fguv_loop_sx0_tbl
	.word L_2874 - fguv_loop_sx0_tbl
	.word L_29a4 - fguv_loop_sx0_tbl
	.word L_2b88 - fguv_loop_sx0_tbl
	.word L_2c18 - fguv_loop_sx0_tbl
	.word L_2d40 - fguv_loop_sx0_tbl
	.word L_2dec - fguv_loop_sx0_tbl
fguv_loop_sx1_tbl:
	.size fguv_loop_sx1_tbl, 32
	.word fguv_loop_sx1_neon - fguv_loop_sx1_tbl
	.word L_3010 - fguv_loop_sx1_tbl
	.word L_3118 - fguv_loop_sx1_tbl
	.word L_31e0 - fguv_loop_sx1_tbl
	.word L_3320 - fguv_loop_sx1_tbl
	.word L_3388 - fguv_loop_sx1_tbl
	.word L_344c - fguv_loop_sx1_tbl
	.word L_34d0 - fguv_loop_sx1_tbl
