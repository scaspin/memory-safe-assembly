_ltmp0:
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
ld1.h	{ v0 }[0], [x14]
ubfx	x14, x2, #4, #11
ld1.h	{ v0 }[1], [x15]
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
ld1.h	{ v0 }[2], [x14]
ubfx	x14, x2, #2, #11
ld1.h	{ v0 }[3], [x15]
add	x14, x3, x14, lsl #1
ubfx	x15, x2, #3, #11
ld1.h	{ v0 }[4], [x14]
add	x15, x3, x15, lsl #1
ubfx	x14, x2, #4, #11
ld1.h	{ v0 }[5], [x15]
ubfx	x15, x2, #5, #11
add	x14, x3, x14, lsl #1
add	x15, x3, x15, lsl #1
ld1.h	{ v0 }[6], [x14]
ld1.h	{ v0 }[7], [x15]
ret
_get_grain_2_neon:
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
ld1.h	{ v0 }[0], [x14]
ld1.h	{ v0 }[1], [x15]
srshl.4h	v0, v0, v31
xtn.8b	v0, v0
ret
_output_lag1_neon:
ubfx	x13, x2, #6, #11
lsr	w2, w2, #1
mov.s	w11, v1[0]
ldrsh	w12, [x3, x13, lsl #1]
ext.16b	v0, v0, v0, #1
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
subs	w15, w15, #1
ext.16b	v1, v1, v1, #4
mov.b	v0[15], w14
b.gt	output_lag1_neon
ret
_output_lag2_neon:
ubfx	x13, x2, #6, #11
lsr	w2, w2, #1
mov.s	w11, v1[0]
ldrsh	w12, [x3, x13, lsl #1]
ext.16b	v0, v0, v0, #1
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
subs	w15, w15, #1
ext.16b	v1, v1, v1, #4
mov.b	v0[15], w14
b.gt	output_lag2_neon
ret
_output_lag3_neon:
ubfx	x13, x2, #6, #11
lsr	w2, w2, #1
mov.s	w11, v1[0]
ldrsh	w12, [x3, x13, lsl #1]
ext.16b	v0, v0, v0, #1
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
subs	w15, w15, #1
ext.16b	v1, v1, v1, #4
mov.b	v0[15], w14
b.gt	output_lag3_neon
ret
_sum_lag1_above_neon:
smull.8h	v2, v3, v28
smull2.8h	v3, v3, v28
smull.8h	v4, v0, v27
smull2.8h	v5, v0, v27
smull.8h	v6, v1, v29
smull2.8h	v7, v1, v29
saddl.4s	v0, v2, v4
saddl2.4s	v1, v2, v4
saddl.4s	v2, v3, v5
saddl2.4s	v3, v3, v5
saddw.4s	v4, v0, v6
saddw2.4s	v5, v1, v6
saddw.4s	v6, v2, v7
saddw2.4s	v7, v3, v7
ret
_sum_y_lag1_left_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
_sum_lag1_y_left_start:
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
ld1.h	{ v0 }[5], [x12]
ld1.h	{ v0 }[6], [x13]
ld1.h	{ v0 }[7], [x14]
lsl	x2, x2, #1
srshl.8h	v0, v0, v31
xtn2.16b	v0, v0
ext.16b	v4, v4, v4, #12
smov.b	w14, v0[15]
mov.16b	v1, v4
mov	w15, #1
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v5
mov	w15, #4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v6
mov	w15, #4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v7
mov	w15, #4
bl	output_lag1_neon
ldr	x30, [sp], #16
ret
_sum_y_lag1_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
_sum_lag1_y_mid_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v4
mov	w15, #4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v5
mov	w15, #4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v6
mov	w15, #4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v7
mov	w15, #4
bl	output_lag1_neon
ldr	x30, [sp], #16
ret
_sum_y_lag1_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
_sum_lag1_y_right_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v4
mov	w15, #4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v5
mov	w15, #4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v6
mov	w15, #4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v7
mov	w15, #3
bl	output_lag1_neon
ubfx	x15, x2, #6, #11
lsr	w2, w2, #1
add	x15, x3, x15, lsl #1
ld1.h	{ v1 }[0], [x15]
srshl.4h	v1, v1, v31
ext.16b	v0, v0, v1, #1
ldr	x30, [sp], #16
ret
_sum_uv_444_lag1_left_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
ld1.16b	{ v0 }, [x19], #16
smull.8h	v2, v0, v30
smull2.8h	v3, v0, v30
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag1_y_left_start
_sum_uv_444_lag1_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
ld1.16b	{ v0 }, [x19], #16
smull.8h	v2, v0, v30
smull2.8h	v3, v0, v30
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag1_y_mid_start
_sum_uv_444_lag1_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
ld1.16b	{ v0 }, [x19], #16
smull.8h	v2, v0, v30
smull2.8h	v3, v0, v30
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag1_y_right_start
_sum_uv_422_lag1_left_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
ld1.16b	{ v22, v23 }, [x19], #32
saddlp.8h	v22, v22
saddlp.8h	v23, v23
rshrn.8b	v0, v22, #1
rshrn2.16b	v0, v23, #1
smull.8h	v2, v0, v30
smull2.8h	v3, v0, v30
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag1_y_left_start
_sum_uv_422_lag1_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
ld1.16b	{ v22, v23 }, [x19], #32
saddlp.8h	v22, v22
saddlp.8h	v23, v23
rshrn.8b	v0, v22, #1
rshrn2.16b	v0, v23, #1
smull.8h	v2, v0, v30
smull2.8h	v3, v0, v30
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag1_y_mid_start
_sum_uv_422_lag1_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
ld1.16b	{ v22, v23 }, [x19], #32
saddlp.8h	v22, v22
saddlp.8h	v23, v23
rshrn.8b	v0, v22, #1
rshrn2.16b	v0, v23, #1
smull.8h	v2, v0, v30
smull2.8h	v3, v0, v30
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag1_uv_420_right_start
_sum_uv_420_lag1_left_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
add	x12, x19, #82
ld1.16b	{ v22, v23 }, [x19], #32
ld1.16b	{ v24, v25 }, [x12]
saddlp.8h	v22, v22
saddlp.8h	v23, v23
saddlp.8h	v24, v24
saddlp.8h	v25, v25
add.8h	v22, v22, v24
add.8h	v23, v23, v25
rshrn.8b	v0, v22, #2
rshrn2.16b	v0, v23, #2
smull.8h	v2, v0, v30
smull2.8h	v3, v0, v30
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag1_y_left_start
_sum_uv_420_lag1_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
add	x12, x19, #82
ld1.16b	{ v22, v23 }, [x19], #32
ld1.16b	{ v24, v25 }, [x12]
saddlp.8h	v22, v22
saddlp.8h	v23, v23
saddlp.8h	v24, v24
saddlp.8h	v25, v25
add.8h	v22, v22, v24
add.8h	v23, v23, v25
rshrn.8b	v0, v22, #2
rshrn2.16b	v0, v23, #2
smull.8h	v2, v0, v30
smull2.8h	v3, v0, v30
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag1_y_mid_start
_sum_uv_420_lag1_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
add	x12, x19, #82
ld1.16b	{ v22, v23 }, [x19], #32
ld1.16b	{ v24, v25 }, [x12]
saddlp.8h	v22, v22
saddlp.8h	v23, v23
saddlp.8h	v24, v24
saddlp.8h	v25, v25
add.8h	v22, v22, v24
add.8h	v23, v23, v25
rshrn.8b	v0, v22, #2
rshrn2.16b	v0, v23, #2
smull.8h	v2, v0, v30
smull2.8h	v3, v0, v30
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
_sum_lag1_uv_420_right_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v4
mov	w15, #4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v5
mov	w15, #4
bl	output_lag1_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v6
mov	w15, #1
bl	output_lag1_neon
lsr	w2, w2, #3
ubfx	x12, x2, #3, #11
ubfx	x13, x2, #4, #11
ubfx	x14, x2, #5, #11
add	x12, x3, x12, lsl #1
add	x13, x3, x13, lsl #1
add	x14, x3, x14, lsl #1
ld1.h	{ v1 }[0], [x12]
ld1.h	{ v1 }[1], [x13]
ld1.h	{ v1 }[2], [x14]
srshl.4h	v1, v1, v31
xtn.8b	v1, v1
ext.16b	v0, v0, v1, #7
ldr	x30, [sp], #16
ret
_sum_lag2_above_neon:
sub	x12, x0, #148
sub	x13, x0, #66
ld1.16b	{ v18 }, [x12]
ld1.16b	{ v21 }, [x13]
ext.16b	v22, v16, v17, #14
dup.16b	v26, v30[0]
ext.16b	v23, v16, v17, #15
dup.16b	v27, v30[1]
ext.16b	v0, v17, v18, #1
dup.16b	v28, v30[3]
ext.16b	v1, v17, v18, #2
dup.16b	v29, v30[4]
smull.8h	v2, v22, v26
smull2.8h	v3, v22, v26
smull.8h	v4, v23, v27
smull2.8h	v5, v23, v27
smull.8h	v6, v0, v28
smull2.8h	v7, v0, v28
smull.8h	v0, v1, v29
smull2.8h	v1, v1, v29
saddl.4s	v22, v2, v4
saddl2.4s	v23, v2, v4
saddl.4s	v26, v3, v5
saddl2.4s	v27, v3, v5
saddl.4s	v2, v0, v6
saddl2.4s	v3, v0, v6
saddl.4s	v6, v1, v7
saddl2.4s	v7, v1, v7
add.4s	v4, v22, v2
add.4s	v5, v23, v3
add.4s	v6, v26, v6
add.4s	v7, v27, v7
ext.16b	v22, v19, v20, #14
dup.16b	v26, v30[5]
ext.16b	v23, v19, v20, #15
dup.16b	v27, v30[6]
ext.16b	v0, v20, v21, #1
dup.16b	v28, v30[8]
ext.16b	v1, v20, v21, #2
dup.16b	v29, v30[9]
smull.8h	v2, v22, v26
smull2.8h	v3, v22, v26
smull.8h	v22, v23, v27
smull2.8h	v23, v23, v27
smull.8h	v26, v0, v28
smull2.8h	v27, v0, v28
smull.8h	v28, v1, v29
smull2.8h	v29, v1, v29
saddl.4s	v0, v2, v22
saddl2.4s	v1, v2, v22
saddl.4s	v2, v3, v23
saddl2.4s	v3, v3, v23
saddl.4s	v22, v26, v28
saddl2.4s	v23, v26, v28
saddl.4s	v26, v27, v29
saddl2.4s	v27, v27, v29
add.4s	v0, v0, v22
add.4s	v1, v1, v23
add.4s	v2, v2, v26
add.4s	v3, v3, v27
dup.16b	v26, v30[2]
dup.16b	v27, v30[7]
smull.8h	v22, v17, v26
smull2.8h	v23, v17, v26
smull.8h	v24, v20, v27
smull2.8h	v25, v20, v27
add.4s	v4, v4, v0
add.4s	v5, v5, v1
add.4s	v6, v6, v2
add.4s	v7, v7, v3
mov.16b	v16, v17
mov.16b	v17, v18
saddl.4s	v0, v22, v24
saddl2.4s	v1, v22, v24
saddl.4s	v2, v23, v25
saddl2.4s	v3, v23, v25
mov.16b	v19, v20
mov.16b	v20, v21
add.4s	v4, v4, v0
add.4s	v5, v5, v1
add.4s	v6, v6, v2
add.4s	v7, v7, v3
ret
_sum_y_lag2_left_neon:
str	x30, [sp, #-16]!
sub	x12, x0, #164
sub	x13, x0, #82
ld1.16b	{ v17 }, [x12]
ld1.16b	{ v20 }, [x13]
bl	sum_lag2_above_neon
_sum_lag2_y_left_start:
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
ld1.h	{ v0 }[5], [x12]
ld1.h	{ v0 }[6], [x13]
ld1.h	{ v0 }[7], [x14]
lsl	x2, x2, #1
srshl.8h	v0, v0, v31
xtn2.16b	v0, v0
ext.16b	v4, v4, v4, #12
smov.b	w16, v0[14]
smov.b	w14, v0[15]
mov.16b	v1, v4
mov	w15, #1
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v5
mov	w15, #4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v6
mov	w15, #4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v7
mov	w15, #4
bl	output_lag2_neon
st1.16b	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_sum_y_lag2_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
_sum_lag2_y_mid_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v4
mov	w15, #4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v5
mov	w15, #4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v6
mov	w15, #4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v7
mov	w15, #4
bl	output_lag2_neon
st1.16b	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_sum_y_lag2_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
_sum_lag2_y_right_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v4
mov	w15, #4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v5
mov	w15, #4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v6
mov	w15, #4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v7
mov	w15, #3
bl	output_lag2_neon
ubfx	x15, x2, #6, #11
lsr	w2, w2, #1
add	x15, x3, x15, lsl #1
ld1.h	{ v1 }[0], [x15]
srshl.4h	v1, v1, v31
ext.16b	v0, v0, v1, #1
st1.16b	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_sum_uv_444_lag2_left_neon:
str	x30, [sp, #-16]!
sub	x12, x0, #164
sub	x13, x0, #82
ld1.16b	{ v17 }, [x12]
ld1.16b	{ v20 }, [x13]
bl	sum_lag2_above_neon
ld1.16b	{ v0 }, [x19], #16
dup.16b	v1, v30[12]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag2_y_left_start
_sum_uv_444_lag2_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
ld1.16b	{ v0 }, [x19], #16
dup.16b	v1, v30[12]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag2_y_mid_start
_sum_uv_444_lag2_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
ld1.16b	{ v0 }, [x19], #16
dup.16b	v1, v30[12]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag2_y_right_start
_sum_uv_422_lag2_left_neon:
str	x30, [sp, #-16]!
sub	x12, x0, #164
sub	x13, x0, #82
ld1.16b	{ v17 }, [x12]
ld1.16b	{ v20 }, [x13]
bl	sum_lag2_above_neon
ld1.16b	{ v22, v23 }, [x19], #32
saddlp.8h	v22, v22
saddlp.8h	v23, v23
rshrn.8b	v0, v22, #1
rshrn2.16b	v0, v23, #1
dup.16b	v1, v30[12]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag2_y_left_start
_sum_uv_422_lag2_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
ld1.16b	{ v22, v23 }, [x19], #32
saddlp.8h	v22, v22
saddlp.8h	v23, v23
rshrn.8b	v0, v22, #1
rshrn2.16b	v0, v23, #1
dup.16b	v1, v30[12]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag2_y_mid_start
_sum_uv_422_lag2_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
ld1.16b	{ v22, v23 }, [x19], #32
saddlp.8h	v22, v22
saddlp.8h	v23, v23
rshrn.8b	v0, v22, #1
rshrn2.16b	v0, v23, #1
dup.16b	v1, v30[12]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag2_uv_420_right_start
_sum_uv_420_lag2_left_neon:
str	x30, [sp, #-16]!
sub	x12, x0, #164
sub	x13, x0, #82
ld1.16b	{ v17 }, [x12]
ld1.16b	{ v20 }, [x13]
bl	sum_lag2_above_neon
add	x12, x19, #82
ld1.16b	{ v22, v23 }, [x19], #32
ld1.16b	{ v24, v25 }, [x12]
saddlp.8h	v22, v22
saddlp.8h	v23, v23
saddlp.8h	v24, v24
saddlp.8h	v25, v25
add.8h	v22, v22, v24
add.8h	v23, v23, v25
rshrn.8b	v0, v22, #2
rshrn2.16b	v0, v23, #2
dup.16b	v1, v30[12]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag2_y_left_start
_sum_uv_420_lag2_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
add	x12, x19, #82
ld1.16b	{ v22, v23 }, [x19], #32
ld1.16b	{ v24, v25 }, [x12]
saddlp.8h	v22, v22
saddlp.8h	v23, v23
saddlp.8h	v24, v24
saddlp.8h	v25, v25
add.8h	v22, v22, v24
add.8h	v23, v23, v25
rshrn.8b	v0, v22, #2
rshrn2.16b	v0, v23, #2
dup.16b	v1, v30[12]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag2_y_mid_start
_sum_uv_420_lag2_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
add	x12, x19, #82
ld1.16b	{ v22, v23 }, [x19], #32
ld1.16b	{ v24, v25 }, [x12]
saddlp.8h	v22, v22
saddlp.8h	v23, v23
saddlp.8h	v24, v24
saddlp.8h	v25, v25
add.8h	v22, v22, v24
add.8h	v23, v23, v25
rshrn.8b	v0, v22, #2
rshrn2.16b	v0, v23, #2
dup.16b	v1, v30[12]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
_sum_lag2_uv_420_right_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v4
mov	w15, #4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v5
mov	w15, #4
bl	output_lag2_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v6
mov	w15, #1
bl	output_lag2_neon
lsr	w2, w2, #3
ubfx	x12, x2, #3, #11
ubfx	x13, x2, #4, #11
ubfx	x14, x2, #5, #11
add	x12, x3, x12, lsl #1
add	x13, x3, x13, lsl #1
add	x14, x3, x14, lsl #1
ld1.h	{ v1 }[0], [x12]
ld1.h	{ v1 }[1], [x13]
ld1.h	{ v1 }[2], [x14]
srshl.4h	v1, v1, v31
xtn.8b	v1, v1
ext.16b	v0, v0, v1, #7
st1.16b	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_sum_lag3_above_neon:
sub	x11, x0, #230
sub	x12, x0, #148
sub	x13, x0, #66
ld1.16b	{ v15 }, [x11]
ld1.16b	{ v18 }, [x12]
ld1.16b	{ v21 }, [x13]
ext.16b	v8, v13, v14, #13
dup.16b	v22, v29[0]
ext.16b	v9, v13, v14, #14
dup.16b	v23, v29[1]
ext.16b	v10, v13, v14, #15
dup.16b	v24, v29[2]
dup.16b	v25, v29[3]
ext.16b	v11, v14, v15, #1
dup.16b	v26, v29[4]
ext.16b	v12, v14, v15, #2
dup.16b	v27, v29[5]
ext.16b	v13, v14, v15, #3
dup.16b	v28, v29[6]
smull.8h	v0, v8, v22
smull2.8h	v1, v8, v22
smull.8h	v2, v9, v23
smull2.8h	v3, v9, v23
smull.8h	v8, v10, v24
smull2.8h	v9, v10, v24
smull.8h	v10, v11, v26
smull2.8h	v11, v11, v26
saddl.4s	v22, v0, v2
saddl2.4s	v23, v0, v2
saddl.4s	v24, v1, v3
saddl2.4s	v26, v1, v3
saddl.4s	v0, v8, v10
saddl2.4s	v1, v8, v10
saddl.4s	v2, v9, v11
saddl2.4s	v3, v9, v11
smull.8h	v8, v12, v27
smull2.8h	v9, v12, v27
smull.8h	v10, v13, v28
smull2.8h	v11, v13, v28
smull.8h	v12, v14, v25
smull2.8h	v13, v14, v25
add.4s	v4, v22, v0
add.4s	v5, v23, v1
add.4s	v6, v24, v2
add.4s	v7, v26, v3
saddl.4s	v0, v8, v10
saddl2.4s	v1, v8, v10
saddl.4s	v2, v9, v11
saddl2.4s	v3, v9, v11
add.4s	v4, v4, v0
add.4s	v5, v5, v1
add.4s	v6, v6, v2
add.4s	v7, v7, v3
saddw.4s	v4, v4, v12
saddw2.4s	v5, v5, v12
saddw.4s	v6, v6, v13
saddw2.4s	v7, v7, v13
ext.16b	v8, v16, v17, #13
dup.16b	v22, v29[7]
ext.16b	v9, v16, v17, #14
dup.16b	v23, v29[8]
ext.16b	v10, v16, v17, #15
dup.16b	v24, v29[9]
dup.16b	v25, v29[10]
ext.16b	v11, v17, v18, #1
dup.16b	v26, v29[11]
ext.16b	v12, v17, v18, #2
dup.16b	v27, v29[12]
ext.16b	v13, v17, v18, #3
dup.16b	v28, v29[13]
smull.8h	v0, v8, v22
smull2.8h	v1, v8, v22
smull.8h	v2, v9, v23
smull2.8h	v3, v9, v23
smull.8h	v8, v10, v24
smull2.8h	v9, v10, v24
smull.8h	v10, v11, v26
smull2.8h	v11, v11, v26
saddl.4s	v22, v0, v2
saddl2.4s	v23, v0, v2
saddl.4s	v24, v1, v3
saddl2.4s	v26, v1, v3
saddl.4s	v0, v8, v10
saddl2.4s	v1, v8, v10
saddl.4s	v2, v9, v11
saddl2.4s	v3, v9, v11
smull.8h	v8, v12, v27
smull2.8h	v9, v12, v27
smull.8h	v10, v13, v28
smull2.8h	v11, v13, v28
smull.8h	v12, v17, v25
smull2.8h	v13, v17, v25
add.4s	v22, v22, v0
add.4s	v23, v23, v1
add.4s	v24, v24, v2
add.4s	v26, v26, v3
saddl.4s	v0, v8, v10
saddl2.4s	v1, v8, v10
saddl.4s	v2, v9, v11
saddl2.4s	v3, v9, v11
add.4s	v4, v4, v22
add.4s	v5, v5, v23
add.4s	v6, v6, v24
add.4s	v7, v7, v26
add.4s	v4, v4, v0
add.4s	v5, v5, v1
add.4s	v6, v6, v2
add.4s	v7, v7, v3
saddw.4s	v4, v4, v12
saddw2.4s	v5, v5, v12
saddw.4s	v6, v6, v13
saddw2.4s	v7, v7, v13
ext.16b	v8, v19, v20, #13
dup.16b	v22, v29[14]
ext.16b	v9, v19, v20, #14
dup.16b	v23, v29[15]
ext.16b	v10, v19, v20, #15
dup.16b	v24, v30[0]
dup.16b	v25, v30[1]
ext.16b	v11, v20, v21, #1
dup.16b	v26, v30[2]
ext.16b	v12, v20, v21, #2
dup.16b	v27, v30[3]
ext.16b	v13, v20, v21, #3
dup.16b	v28, v30[4]
smull.8h	v0, v8, v22
smull2.8h	v1, v8, v22
smull.8h	v2, v9, v23
smull2.8h	v3, v9, v23
smull.8h	v8, v10, v24
smull2.8h	v9, v10, v24
smull.8h	v10, v11, v26
smull2.8h	v11, v11, v26
saddl.4s	v22, v0, v2
saddl2.4s	v23, v0, v2
saddl.4s	v24, v1, v3
saddl2.4s	v26, v1, v3
saddl.4s	v0, v8, v10
saddl2.4s	v1, v8, v10
saddl.4s	v2, v9, v11
saddl2.4s	v3, v9, v11
smull.8h	v8, v12, v27
smull2.8h	v9, v12, v27
smull.8h	v10, v13, v28
smull2.8h	v11, v13, v28
smull.8h	v12, v20, v25
smull2.8h	v19, v20, v25
add.4s	v22, v22, v0
add.4s	v23, v23, v1
add.4s	v24, v24, v2
add.4s	v26, v26, v3
saddl.4s	v0, v8, v10
saddl2.4s	v1, v8, v10
saddl.4s	v2, v9, v11
saddl2.4s	v3, v9, v11
add.4s	v4, v4, v22
add.4s	v5, v5, v23
add.4s	v6, v6, v24
add.4s	v7, v7, v26
mov.16b	v13, v14
mov.16b	v14, v15
add.4s	v4, v4, v0
add.4s	v5, v5, v1
add.4s	v6, v6, v2
add.4s	v7, v7, v3
mov.16b	v16, v17
mov.16b	v17, v18
saddw.4s	v4, v4, v12
saddw2.4s	v5, v5, v12
saddw.4s	v6, v6, v19
saddw2.4s	v7, v7, v19
mov.16b	v19, v20
mov.16b	v20, v21
ret
_sum_y_lag3_left_neon:
str	x30, [sp, #-16]!
sub	x11, x0, #246
sub	x12, x0, #164
sub	x13, x0, #82
ld1.16b	{ v14 }, [x11]
ld1.16b	{ v17 }, [x12]
ld1.16b	{ v20 }, [x13]
bl	sum_lag3_above_neon
_sum_lag3_y_left_start:
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
ld1.h	{ v0 }[5], [x12]
ld1.h	{ v0 }[6], [x13]
ld1.h	{ v0 }[7], [x14]
lsl	x2, x2, #1
srshl.8h	v0, v0, v31
xtn2.16b	v0, v0
ext.16b	v4, v4, v4, #12
smov.b	w17, v0[13]
smov.b	w16, v0[14]
smov.b	w14, v0[15]
mov.16b	v1, v4
mov	w15, #1
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v5
mov	w15, #4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v6
mov	w15, #4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v7
mov	w15, #4
bl	output_lag3_neon
st1.16b	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_sum_y_lag3_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
_sum_lag3_y_mid_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v4
mov	w15, #4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v5
mov	w15, #4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v6
mov	w15, #4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v7
mov	w15, #4
bl	output_lag3_neon
st1.16b	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_sum_y_lag3_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
_sum_lag3_y_right_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v4
mov	w15, #4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v5
mov	w15, #4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v6
mov	w15, #4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v7
mov	w15, #3
bl	output_lag3_neon
ubfx	x15, x2, #6, #11
lsr	w2, w2, #1
add	x15, x3, x15, lsl #1
ld1.h	{ v1 }[0], [x15]
srshl.4h	v1, v1, v31
ext.16b	v0, v0, v1, #1
st1.16b	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_sum_uv_444_lag3_left_neon:
str	x30, [sp, #-16]!
sub	x11, x0, #246
sub	x12, x0, #164
sub	x13, x0, #82
ld1.16b	{ v14 }, [x11]
ld1.16b	{ v17 }, [x12]
ld1.16b	{ v20 }, [x13]
bl	sum_lag3_above_neon
ld1.16b	{ v0 }, [x19], #16
dup.16b	v1, v30[8]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag3_y_left_start
_sum_uv_444_lag3_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
ld1.16b	{ v0 }, [x19], #16
dup.16b	v1, v30[8]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag3_y_mid_start
_sum_uv_444_lag3_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
ld1.16b	{ v0 }, [x19], #16
dup.16b	v1, v30[8]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag3_y_right_start
_sum_uv_422_lag3_left_neon:
str	x30, [sp, #-16]!
sub	x11, x0, #246
sub	x12, x0, #164
sub	x13, x0, #82
ld1.16b	{ v14 }, [x11]
ld1.16b	{ v17 }, [x12]
ld1.16b	{ v20 }, [x13]
bl	sum_lag3_above_neon
ld1.16b	{ v22, v23 }, [x19], #32
saddlp.8h	v22, v22
saddlp.8h	v23, v23
rshrn.8b	v0, v22, #1
rshrn2.16b	v0, v23, #1
dup.16b	v1, v30[8]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag3_y_left_start
_sum_uv_422_lag3_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
ld1.16b	{ v22, v23 }, [x19], #32
saddlp.8h	v22, v22
saddlp.8h	v23, v23
rshrn.8b	v0, v22, #1
rshrn2.16b	v0, v23, #1
dup.16b	v1, v30[8]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag3_y_mid_start
_sum_uv_422_lag3_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
ld1.16b	{ v22, v23 }, [x19], #32
saddlp.8h	v22, v22
saddlp.8h	v23, v23
rshrn.8b	v0, v22, #1
rshrn2.16b	v0, v23, #1
dup.16b	v1, v30[8]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag3_uv_420_right_start
_sum_uv_420_lag3_left_neon:
str	x30, [sp, #-16]!
sub	x11, x0, #246
sub	x12, x0, #164
sub	x13, x0, #82
ld1.16b	{ v14 }, [x11]
ld1.16b	{ v17 }, [x12]
ld1.16b	{ v20 }, [x13]
bl	sum_lag3_above_neon
add	x12, x19, #82
ld1.16b	{ v22, v23 }, [x19], #32
ld1.16b	{ v24, v25 }, [x12]
saddlp.8h	v22, v22
saddlp.8h	v23, v23
saddlp.8h	v24, v24
saddlp.8h	v25, v25
add.8h	v22, v22, v24
add.8h	v23, v23, v25
rshrn.8b	v0, v22, #2
rshrn2.16b	v0, v23, #2
dup.16b	v1, v30[8]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag3_y_left_start
_sum_uv_420_lag3_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
add	x12, x19, #82
ld1.16b	{ v22, v23 }, [x19], #32
ld1.16b	{ v24, v25 }, [x12]
saddlp.8h	v22, v22
saddlp.8h	v23, v23
saddlp.8h	v24, v24
saddlp.8h	v25, v25
add.8h	v22, v22, v24
add.8h	v23, v23, v25
rshrn.8b	v0, v22, #2
rshrn2.16b	v0, v23, #2
dup.16b	v1, v30[8]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
b	sum_lag3_y_mid_start
_sum_uv_420_lag3_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
add	x12, x19, #82
ld1.16b	{ v22, v23 }, [x19], #32
ld1.16b	{ v24, v25 }, [x12]
saddlp.8h	v22, v22
saddlp.8h	v23, v23
saddlp.8h	v24, v24
saddlp.8h	v25, v25
add.8h	v22, v22, v24
add.8h	v23, v23, v25
rshrn.8b	v0, v22, #2
rshrn2.16b	v0, v23, #2
dup.16b	v1, v30[8]
smull.8h	v2, v0, v1
smull2.8h	v3, v0, v1
saddw.4s	v4, v4, v2
saddw2.4s	v5, v5, v2
saddw.4s	v6, v6, v3
saddw2.4s	v7, v7, v3
_sum_lag3_uv_420_right_start:
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v4
mov	w15, #4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v5
mov	w15, #4
bl	output_lag3_neon
lsr	w11, w2, #3
lsr	w12, w2, #12
lsr	w13, w2, #1
eor	w11, w2, w11
eor	w12, w12, w13
eor	w11, w11, w12
and	w11, w11, #0xf
orr	w2, w2, w11, lsl #16
mov.16b	v1, v6
mov	w15, #1
bl	output_lag3_neon
lsr	w2, w2, #3
ubfx	x12, x2, #3, #11
ubfx	x13, x2, #4, #11
ubfx	x14, x2, #5, #11
add	x12, x3, x12, lsl #1
add	x13, x3, x13, lsl #1
add	x14, x3, x14, lsl #1
ld1.h	{ v1 }[0], [x12]
ld1.h	{ v1 }[1], [x13]
ld1.h	{ v1 }[2], [x14]
srshl.4h	v1, v1, v31
xtn.8b	v1, v1
ext.16b	v0, v0, v1, #7
st1.16b	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_generate_grain_rows_neon:
str	x30, [sp, #-16]!
bl	ltmp0
srshl.8h	v21, v0, v31
xtn.8b	v16, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn2.16b	v16, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn.8b	v17, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn2.16b	v17, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn.8b	v18, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn2.16b	v18, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn.8b	v19, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn2.16b	v19, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn.8b	v20, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn2.16b	v20, v21
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
ld1.h	{ v21 }[0], [x14]
ld1.h	{ v21 }[1], [x15]
srshl.4h	v0, v21, v31
xtn.8b	v21, v0
subs	w1, w1, #1
st1.16b	{ v16, v17 }, [x0], #32
st1.16b	{ v18, v19 }, [x0], #32
st1.16b	{ v20 }, [x0], #16
st1.h	{ v21 }[0], [x0], #2
b.gt	generate_grain_rows_neon
ldr	x30, [sp], #16
ret
_generate_grain_rows_44_neon:
str	x30, [sp, #-16]!
bl	ltmp0
srshl.8h	v18, v0, v31
xtn.8b	v16, v18
bl	ltmp0
srshl.8h	v18, v0, v31
xtn2.16b	v16, v18
bl	ltmp0
srshl.8h	v18, v0, v31
xtn.8b	v17, v18
bl	ltmp0
srshl.8h	v18, v0, v31
xtn2.16b	v17, v18
bl	ltmp0
srshl.8h	v18, v0, v31
xtn.8b	v18, v18
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
ld1.h	{ v0 }[0], [x14]
ubfx	x14, x2, #4, #11
ld1.h	{ v0 }[1], [x15]
ubfx	x15, x2, #5, #11
add	x14, x3, x14, lsl #1
add	x15, x3, x15, lsl #1
ld1.h	{ v0 }[2], [x14]
ld1.h	{ v0 }[3], [x15]
srshl.4h	v0, v0, v31
xtn2.16b	v18, v0
subs	w1, w1, #1
st1.16b	{ v16, v17 }, [x0], #32
st1.16b	{ v18 }, [x0]
add	x0, x0, #50
b.gt	generate_grain_rows_44_neon
ldr	x30, [sp], #16
ret
_get_grain_row_neon:
str	x30, [sp, #-16]!
bl	ltmp0
srshl.8h	v21, v0, v31
xtn.8b	v16, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn2.16b	v16, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn.8b	v17, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn2.16b	v17, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn.8b	v18, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn2.16b	v18, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn.8b	v19, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn2.16b	v19, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn.8b	v20, v21
bl	ltmp0
srshl.8h	v21, v0, v31
xtn2.16b	v20, v21
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
ld1.h	{ v21 }[0], [x14]
ld1.h	{ v21 }[1], [x15]
srshl.4h	v0, v21, v31
xtn.8b	v21, v0
ldr	x30, [sp], #16
ret
_get_grain_row_44_neon:
str	x30, [sp, #-16]!
bl	ltmp0
srshl.8h	v18, v0, v31
xtn.8b	v16, v18
bl	ltmp0
srshl.8h	v18, v0, v31
xtn2.16b	v16, v18
bl	ltmp0
srshl.8h	v18, v0, v31
xtn.8b	v17, v18
bl	ltmp0
srshl.8h	v18, v0, v31
xtn2.16b	v17, v18
bl	ltmp0
srshl.8h	v18, v0, v31
xtn.8b	v18, v18
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
ld1.h	{ v0 }[0], [x14]
ubfx	x14, x2, #4, #11
ld1.h	{ v0 }[1], [x15]
ubfx	x15, x2, #5, #11
add	x14, x3, x14, lsl #1
add	x15, x3, x15, lsl #1
ld1.h	{ v0 }[2], [x14]
ld1.h	{ v0 }[3], [x15]
srshl.4h	v0, v0, v31
xtn2.16b	v18, v0
ldr	x30, [sp], #16
ret
_add_uv_444_coeff_lag0_neon:
smull.8h	v2, v0, v27
smull2.8h	v3, v0, v27
srshl.8h	v2, v2, v28
srshl.8h	v3, v3, v28
saddw.8h	v2, v2, v1
saddw2.8h	v3, v3, v1
sqxtn.8b	v2, v2
sqxtn2.16b	v2, v3
ret
_add_uv_420_coeff_lag0_neon:
ld1.16b	{ v4, v5 }, [x19], #32
ld1.16b	{ v6, v7 }, [x12], #32
saddlp.8h	v4, v4
saddlp.8h	v5, v5
saddlp.8h	v6, v6
saddlp.8h	v7, v7
add.8h	v4, v4, v6
add.8h	v5, v5, v7
rshrn.8b	v4, v4, #2
rshrn2.16b	v4, v5, #2
and.16b	v0, v4, v0
b	add_uv_444_coeff_lag0_neon
_add_uv_422_coeff_lag0_neon:
ld1.16b	{ v4, v5 }, [x19], #32
saddlp.8h	v4, v4
saddlp.8h	v5, v5
rshrn.8b	v4, v4, #1
rshrn2.16b	v4, v5, #1
and.16b	v0, v4, v0
b	add_uv_444_coeff_lag0_neon
_generate_grain_y_8bpc_neon:
stp	x30, x19, [sp, #-96]!
adrp	x3, generate_grain_y_8bpc_neon
add	x3, x3, #0
ldr	w2, [x1]
ldr	w9, [x1, #184]
add	x4, x1, #96
adr	x16, #456
ldr	w17, [x1, #92]
add	w9, w9, #4
ldrh	w17, [x16, w17, uxtw #1]
dup.8h	v31, w9
sub	x16, x16, w17, uxtw
neg.8h	v31, v31
ldr	w7, [x1, #176]
mov	w8, #1
mov	w10, #1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #127
mov	w6, #-128
br	x16
mov	w1, #73
bl	generate_grain_rows_neon
ldp	x30, x19, [sp], #96
ret
ld1r.16b	{ v27 }, [x4], #1
ld1r.16b	{ v28 }, [x4], #1
ld1r.16b	{ v29 }, [x4]
ldrsb	w4, [x4, #1]
mov	w1, #3
bl	generate_grain_rows_neon
mov	w1, #70
mov.16b	v3, v16
ext.16b	v0, v16, v16, #15
ext.16b	v1, v16, v17, #1
bl	sum_y_lag1_left_neon
mov.16b	v22, v0
mov.16b	v3, v17
ext.16b	v0, v16, v17, #15
ext.16b	v1, v17, v18, #1
bl	sum_y_lag1_mid_neon
mov.16b	v23, v0
mov.16b	v3, v18
ext.16b	v0, v17, v18, #15
ext.16b	v1, v18, v19, #1
bl	sum_y_lag1_mid_neon
mov.16b	v24, v0
mov.16b	v3, v19
ext.16b	v0, v18, v19, #15
ext.16b	v1, v19, v20, #1
bl	sum_y_lag1_mid_neon
mov.16b	v25, v0
mov.16b	v3, v20
ext.16b	v0, v19, v20, #15
ext.16b	v1, v20, v21, #1
bl	sum_y_lag1_right_neon
mov.16b	v20, v0
bl	get_grain_2_neon
mov.8b	v21, v0
subs	w1, w1, #1
st1.16b	{ v22, v23 }, [x0], #32
st1.16b	{ v24, v25 }, [x0], #32
st1.16b	{ v20 }, [x0], #16
st1.h	{ v21 }[0], [x0], #2
mov.16b	v16, v22
mov.16b	v17, v23
mov.16b	v18, v24
mov.16b	v19, v25
b.gt	generate_grain_y_8bpc_neon
ldp	x30, x19, [sp], #96
ret
ld1.16b	{ v30 }, [x4]
smov.b	w4, v30[10]
smov.b	w17, v30[11]
mov	w1, #3
bl	generate_grain_rows_neon
mov	w1, #70
bl	sum_y_lag2_left_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_right_neon
bl	get_grain_2_neon
mov.8b	v16, v0
subs	w1, w1, #1
st1.h	{ v16 }[0], [x0], #2
b.gt	generate_grain_y_8bpc_neon
ldp	x30, x19, [sp], #96
ret
ld1.16b	{ v29, v30 }, [x4]
stp	d8, d9, [sp, #16]
stp	d10, d11, [sp, #32]
stp	d12, d13, [sp, #48]
stp	d14, d15, [sp, #64]
stp	x20, x21, [sp, #80]
smov.b	w4, v30[5]
smov.b	w20, v30[6]
smov.b	w21, v30[7]
mov	w1, #3
bl	generate_grain_rows_neon
mov	w1, #70
bl	sum_y_lag3_left_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_right_neon
bl	get_grain_2_neon
mov.8b	v16, v0
subs	w1, w1, #1
st1.h	{ v16 }[0], [x0], #2
b.gt	generate_grain_y_8bpc_neon
ldp	x20, x21, [sp, #80]
ldp	d14, d15, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldp	x30, x19, [sp], #96
ret
<unknown>
<unknown>
_generate_grain_uv_444_8bpc_neon:
stp	x30, x19, [sp, #-96]!
mov	w13, w3
mov	w14, #28
add	x19, x1, #246
mov	x1, x2
mul	w13, w13, w14
adrp	x3, generate_grain_uv_444_8bpc_neon
add	x3, x3, #0
ldr	w2, [x1]
ldr	w9, [x1, #184]
add	x4, x1, #120
adr	x16, #652
ldr	w17, [x1, #92]
add	w9, w9, #4
ldrh	w17, [x16, w17, uxtw #1]
dup.8h	v31, w9
sub	x16, x16, w17, uxtw
neg.8h	v31, v31
cmp	w13, #0
mov	w11, #18904
mov	w14, #46372
add	x4, x4, w13, uxtw
csel	w11, w11, w14, ne
ldr	w7, [x1, #176]
mov	w8, #1
mov	w10, #1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #127
mov	w6, #-128
eor	w2, w2, w11
br	x16
dup.8h	v28, w7
ld1r.16b	{ v27 }, [x4]
movi.16b	v0, #0
movi.16b	v1, #255
ext.16b	v29, v0, v1, #13
ext.16b	v30, v1, v0, #1
neg.8h	v28, v28
mov	w1, #3
bl	generate_grain_rows_neon
mov	w1, #70
ld1.16b	{ v22, v23, v24, v25 }, [x19], #64
bl	get_grain_row_neon
and.16b	v0, v22, v29
mov.16b	v1, v16
bl	add_uv_444_coeff_lag0_neon
mov.16b	v0, v23
mov.16b	v1, v17
mov.16b	v16, v2
bl	add_uv_444_coeff_lag0_neon
ld1.16b	{ v26 }, [x19], #16
mov.16b	v0, v24
mov.16b	v1, v18
mov.16b	v17, v2
bl	add_uv_444_coeff_lag0_neon
add	x19, x19, #2
mov.16b	v0, v25
mov.16b	v1, v19
mov.16b	v18, v2
bl	add_uv_444_coeff_lag0_neon
and.16b	v0, v26, v30
mov.16b	v1, v20
mov.16b	v19, v2
bl	add_uv_444_coeff_lag0_neon
mov.16b	v20, v2
subs	w1, w1, #1
st1.16b	{ v16, v17 }, [x0], #32
st1.16b	{ v18, v19 }, [x0], #32
st1.16b	{ v20 }, [x0], #16
st1.h	{ v21 }[0], [x0], #2
b.gt	generate_grain_uv_444_8bpc_neon
ldp	x30, x19, [sp], #96
ret
ld1r.16b	{ v27 }, [x4], #1
ld1r.16b	{ v28 }, [x4], #1
ld1r.16b	{ v29 }, [x4]
add	x4, x4, #2
mov	w1, #3
ld1r.16b	{ v30 }, [x4]
ldursb	w4, [x4, #-1]
bl	generate_grain_rows_neon
mov	w1, #70
mov.16b	v3, v16
ext.16b	v0, v16, v16, #15
ext.16b	v1, v16, v17, #1
bl	sum_uv_444_lag1_left_neon
mov.16b	v22, v0
mov.16b	v3, v17
ext.16b	v0, v16, v17, #15
ext.16b	v1, v17, v18, #1
bl	sum_uv_444_lag1_mid_neon
mov.16b	v23, v0
mov.16b	v3, v18
ext.16b	v0, v17, v18, #15
ext.16b	v1, v18, v19, #1
bl	sum_uv_444_lag1_mid_neon
mov.16b	v24, v0
mov.16b	v3, v19
ext.16b	v0, v18, v19, #15
ext.16b	v1, v19, v20, #1
bl	sum_uv_444_lag1_mid_neon
mov.16b	v25, v0
mov.16b	v3, v20
ext.16b	v0, v19, v20, #15
ext.16b	v1, v20, v21, #1
bl	sum_uv_444_lag1_right_neon
mov.16b	v20, v0
bl	get_grain_2_neon
mov.8b	v21, v0
subs	w1, w1, #1
add	x19, x19, #2
st1.16b	{ v22, v23 }, [x0], #32
st1.16b	{ v24, v25 }, [x0], #32
st1.16b	{ v20 }, [x0], #16
st1.h	{ v21 }[0], [x0], #2
mov.16b	v16, v22
mov.16b	v17, v23
mov.16b	v18, v24
mov.16b	v19, v25
b.gt	generate_grain_uv_444_8bpc_neon
ldp	x30, x19, [sp], #96
ret
ld1.16b	{ v30 }, [x4]
smov.b	w4, v30[10]
smov.b	w17, v30[11]
mov	w1, #3
bl	generate_grain_rows_neon
mov	w1, #70
bl	sum_uv_444_lag2_left_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_right_neon
bl	get_grain_2_neon
mov.8b	v16, v0
subs	w1, w1, #1
add	x19, x19, #2
st1.h	{ v16 }[0], [x0], #2
b.gt	generate_grain_uv_444_8bpc_neon
ldp	x30, x19, [sp], #96
ret
ld1.16b	{ v29, v30 }, [x4]
stp	d8, d9, [sp, #16]
stp	d10, d11, [sp, #32]
stp	d12, d13, [sp, #48]
stp	d14, d15, [sp, #64]
stp	x20, x21, [sp, #80]
smov.b	w4, v30[5]
smov.b	w20, v30[6]
smov.b	w21, v30[7]
mov	w1, #3
bl	generate_grain_rows_neon
mov	w1, #70
bl	sum_uv_444_lag3_left_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_right_neon
bl	get_grain_2_neon
mov.8b	v16, v0
subs	w1, w1, #1
add	x19, x19, #2
st1.h	{ v16 }[0], [x0], #2
b.gt	generate_grain_uv_444_8bpc_neon
ldp	x20, x21, [sp, #80]
ldp	d14, d15, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldp	x30, x19, [sp], #96
ret
<unknown>
<unknown>
_generate_grain_uv_420_8bpc_neon:
stp	x30, x19, [sp, #-96]!
mov	w13, w3
mov	w14, #28
add	x19, x1, #243
mov	x1, x2
mul	w13, w13, w14
adrp	x3, generate_grain_uv_420_8bpc_neon
add	x3, x3, #0
ldr	w2, [x1]
ldr	w9, [x1, #184]
add	x4, x1, #120
adr	x16, #524
ldr	w17, [x1, #92]
add	w9, w9, #4
ldrh	w17, [x16, w17, uxtw #1]
dup.8h	v31, w9
sub	x16, x16, w17, uxtw
neg.8h	v31, v31
cmp	w13, #0
mov	w11, #18904
mov	w14, #46372
add	x4, x4, w13, uxtw
csel	w11, w11, w14, ne
ldr	w7, [x1, #176]
mov	w8, #1
mov	w10, #1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #127
mov	w6, #-128
eor	w2, w2, w11
br	x16
dup.8h	v28, w7
ld1r.16b	{ v27 }, [x4]
movi.16b	v0, #0
movi.16b	v1, #255
ext.16b	v29, v0, v1, #13
ext.16b	v30, v1, v0, #7
neg.8h	v28, v28
mov	w1, #3
bl	generate_grain_rows_44_neon
mov	w1, #35
bl	get_grain_row_44_neon
add	x12, x19, #82
mov.16b	v0, v29
mov.16b	v1, v16
bl	add_uv_420_coeff_lag0_neon
movi.16b	v0, #255
mov.16b	v1, v17
mov.16b	v16, v2
bl	add_uv_420_coeff_lag0_neon
mov.16b	v0, v30
mov.16b	v1, v18
mov.16b	v17, v2
bl	add_uv_420_coeff_lag0_neon
mov.16b	v18, v2
subs	w1, w1, #1
add	x19, x19, #68
st1.16b	{ v16, v17 }, [x0], #32
st1.16b	{ v18 }, [x0]
add	x0, x0, #50
b.gt	generate_grain_uv_420_8bpc_neon
ldp	x30, x19, [sp], #96
ret
ld1r.16b	{ v27 }, [x4], #1
ld1r.16b	{ v28 }, [x4], #1
ld1r.16b	{ v29 }, [x4]
add	x4, x4, #2
mov	w1, #3
ld1r.16b	{ v30 }, [x4]
ldursb	w4, [x4, #-1]
bl	generate_grain_rows_44_neon
mov	w1, #35
mov.16b	v3, v16
ext.16b	v0, v16, v16, #15
ext.16b	v1, v16, v17, #1
bl	sum_uv_420_lag1_left_neon
mov.16b	v20, v0
mov.16b	v3, v17
ext.16b	v0, v16, v17, #15
ext.16b	v1, v17, v18, #1
bl	sum_uv_420_lag1_mid_neon
mov.16b	v21, v0
mov.16b	v3, v18
ext.16b	v0, v17, v18, #15
ext.16b	v1, v18, v18, #1
bl	sum_uv_420_lag1_right_neon
mov.16b	v18, v0
subs	w1, w1, #1
add	x19, x19, #68
st1.16b	{ v20, v21 }, [x0], #32
st1.16b	{ v18 }, [x0]
add	x0, x0, #50
mov.16b	v16, v20
mov.16b	v17, v21
b.gt	generate_grain_uv_420_8bpc_neon
ldp	x30, x19, [sp], #96
ret
ld1.16b	{ v30 }, [x4]
smov.b	w4, v30[10]
smov.b	w17, v30[11]
mov	w1, #3
bl	generate_grain_rows_44_neon
mov	w1, #35
bl	sum_uv_420_lag2_left_neon
bl	sum_uv_420_lag2_mid_neon
bl	sum_uv_420_lag2_right_neon
subs	w1, w1, #1
add	x19, x19, #68
add	x0, x0, #34
b.gt	generate_grain_uv_420_8bpc_neon
ldp	x30, x19, [sp], #96
ret
ldr	q29, [x4]
ldr	q30, [x4, #16]
stp	d8, d9, [sp, #16]
stp	d10, d11, [sp, #32]
stp	d12, d13, [sp, #48]
stp	d14, d15, [sp, #64]
stp	x20, x21, [sp, #80]
smov.b	w4, v30[5]
smov.b	w20, v30[6]
smov.b	w21, v30[7]
mov	w1, #3
bl	generate_grain_rows_44_neon
mov	w1, #35
bl	sum_uv_420_lag3_left_neon
bl	sum_uv_420_lag3_mid_neon
bl	sum_uv_420_lag3_right_neon
subs	w1, w1, #1
add	x19, x19, #68
add	x0, x0, #34
b.gt	generate_grain_uv_420_8bpc_neon
ldp	x20, x21, [sp, #80]
ldp	d14, d15, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldp	x30, x19, [sp], #96
ret
<unknown>
<unknown>
_generate_grain_uv_422_8bpc_neon:
stp	x30, x19, [sp, #-96]!
mov	w13, w3
mov	w14, #28
add	x19, x1, #243
mov	x1, x2
mul	w13, w13, w14
adrp	x3, generate_grain_uv_422_8bpc_neon
add	x3, x3, #0
ldr	w2, [x1]
ldr	w9, [x1, #184]
add	x4, x1, #120
adr	x16, #520
ldr	w17, [x1, #92]
add	w9, w9, #4
ldrh	w17, [x16, w17, uxtw #1]
dup.8h	v31, w9
sub	x16, x16, w17, uxtw
neg.8h	v31, v31
cmp	w13, #0
mov	w11, #18904
mov	w14, #46372
add	x4, x4, w13, uxtw
csel	w11, w11, w14, ne
ldr	w7, [x1, #176]
mov	w8, #1
mov	w10, #1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #127
mov	w6, #-128
eor	w2, w2, w11
br	x16
dup.8h	v28, w7
ld1r.16b	{ v27 }, [x4]
movi.16b	v0, #0
movi.16b	v1, #255
ext.16b	v29, v0, v1, #13
ext.16b	v30, v1, v0, #7
neg.8h	v28, v28
mov	w1, #3
bl	generate_grain_rows_44_neon
mov	w1, #70
bl	get_grain_row_44_neon
mov.16b	v0, v29
mov.16b	v1, v16
bl	add_uv_422_coeff_lag0_neon
movi.16b	v0, #255
mov.16b	v1, v17
mov.16b	v16, v2
bl	add_uv_422_coeff_lag0_neon
mov.16b	v0, v30
mov.16b	v1, v18
mov.16b	v17, v2
bl	add_uv_422_coeff_lag0_neon
mov.16b	v18, v2
subs	w1, w1, #1
sub	x19, x19, #14
st1.16b	{ v16, v17 }, [x0], #32
st1.16b	{ v18 }, [x0]
add	x0, x0, #50
b.gt	generate_grain_uv_422_8bpc_neon
ldp	x30, x19, [sp], #96
ret
ld1r.16b	{ v27 }, [x4], #1
ld1r.16b	{ v28 }, [x4], #1
ld1r.16b	{ v29 }, [x4]
add	x4, x4, #2
mov	w1, #3
ld1r.16b	{ v30 }, [x4]
ldursb	w4, [x4, #-1]
bl	generate_grain_rows_44_neon
mov	w1, #70
mov.16b	v3, v16
ext.16b	v0, v16, v16, #15
ext.16b	v1, v16, v17, #1
bl	sum_uv_422_lag1_left_neon
mov.16b	v20, v0
mov.16b	v3, v17
ext.16b	v0, v16, v17, #15
ext.16b	v1, v17, v18, #1
bl	sum_uv_422_lag1_mid_neon
mov.16b	v21, v0
mov.16b	v3, v18
ext.16b	v0, v17, v18, #15
ext.16b	v1, v18, v18, #1
bl	sum_uv_422_lag1_right_neon
mov.16b	v18, v0
subs	w1, w1, #1
sub	x19, x19, #14
st1.16b	{ v20, v21 }, [x0], #32
st1.16b	{ v18 }, [x0]
add	x0, x0, #50
mov.16b	v16, v20
mov.16b	v17, v21
b.gt	generate_grain_uv_422_8bpc_neon
ldp	x30, x19, [sp], #96
ret
ld1.16b	{ v30 }, [x4]
smov.b	w4, v30[10]
smov.b	w17, v30[11]
mov	w1, #3
bl	generate_grain_rows_44_neon
mov	w1, #70
bl	sum_uv_422_lag2_left_neon
bl	sum_uv_422_lag2_mid_neon
bl	sum_uv_422_lag2_right_neon
subs	w1, w1, #1
sub	x19, x19, #14
add	x0, x0, #34
b.gt	generate_grain_uv_422_8bpc_neon
ldp	x30, x19, [sp], #96
ret
ldr	q29, [x4]
ldr	q30, [x4, #16]
stp	d8, d9, [sp, #16]
stp	d10, d11, [sp, #32]
stp	d12, d13, [sp, #48]
stp	d14, d15, [sp, #64]
stp	x20, x21, [sp, #80]
smov.b	w4, v30[5]
smov.b	w20, v30[6]
smov.b	w21, v30[7]
mov	w1, #3
bl	generate_grain_rows_44_neon
mov	w1, #70
bl	sum_uv_422_lag3_left_neon
bl	sum_uv_422_lag3_mid_neon
bl	sum_uv_422_lag3_right_neon
subs	w1, w1, #1
sub	x19, x19, #14
add	x0, x0, #34
b.gt	generate_grain_uv_422_8bpc_neon
ldp	x20, x21, [sp, #80]
ldp	d14, d15, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldp	x30, x19, [sp], #96
ret
<unknown>
<unknown>
_gather32_neon:
umov.b	w14, v0[0]
umov.b	w15, v1[8]
umov.b	w16, v0[2]
add	x14, x14, x3
umov.b	w17, v1[10]
add	x15, x15, x3
ld1.b	{ v4 }[0], [x14]
umov.b	w14, v0[4]
add	x16, x16, x3
ld1.b	{ v5 }[8], [x15]
umov.b	w15, v1[12]
add	x17, x17, x3
ld1.b	{ v4 }[2], [x16]
umov.b	w16, v0[6]
add	x14, x14, x3
ld1.b	{ v5 }[10], [x17]
umov.b	w17, v1[14]
add	x15, x15, x3
ld1.b	{ v4 }[4], [x14]
add	x16, x16, x3
ld1.b	{ v5 }[12], [x15]
add	x17, x17, x3
ld1.b	{ v4 }[6], [x16]
ld1.b	{ v5 }[14], [x17]
umov.b	w14, v1[0]
umov.b	w15, v0[8]
umov.b	w16, v1[2]
add	x14, x14, x3
umov.b	w17, v0[10]
add	x15, x15, x3
ld1.b	{ v5 }[0], [x14]
umov.b	w14, v1[4]
add	x16, x16, x3
ld1.b	{ v4 }[8], [x15]
umov.b	w15, v0[12]
add	x17, x17, x3
ld1.b	{ v5 }[2], [x16]
umov.b	w16, v1[6]
add	x14, x14, x3
ld1.b	{ v4 }[10], [x17]
umov.b	w17, v0[14]
add	x15, x15, x3
ld1.b	{ v5 }[4], [x14]
add	x16, x16, x3
ld1.b	{ v4 }[12], [x15]
add	x17, x17, x3
ld1.b	{ v5 }[6], [x16]
ld1.b	{ v4 }[14], [x17]
umov.b	w14, v0[1]
umov.b	w15, v1[9]
umov.b	w16, v0[3]
add	x14, x14, x3
umov.b	w17, v1[11]
add	x15, x15, x3
ld1.b	{ v4 }[1], [x14]
umov.b	w14, v0[5]
add	x16, x16, x3
ld1.b	{ v5 }[9], [x15]
umov.b	w15, v1[13]
add	x17, x17, x3
ld1.b	{ v4 }[3], [x16]
umov.b	w16, v0[7]
add	x14, x14, x3
ld1.b	{ v5 }[11], [x17]
umov.b	w17, v1[15]
add	x15, x15, x3
ld1.b	{ v4 }[5], [x14]
add	x16, x16, x3
ld1.b	{ v5 }[13], [x15]
add	x17, x17, x3
ld1.b	{ v4 }[7], [x16]
ld1.b	{ v5 }[15], [x17]
umov.b	w14, v1[1]
umov.b	w15, v0[9]
umov.b	w16, v1[3]
add	x14, x14, x3
umov.b	w17, v0[11]
add	x15, x15, x3
ld1.b	{ v5 }[1], [x14]
umov.b	w14, v1[5]
add	x16, x16, x3
ld1.b	{ v4 }[9], [x15]
umov.b	w15, v0[13]
add	x17, x17, x3
ld1.b	{ v5 }[3], [x16]
umov.b	w16, v1[7]
add	x14, x14, x3
ld1.b	{ v4 }[11], [x17]
umov.b	w17, v0[15]
add	x15, x15, x3
ld1.b	{ v5 }[5], [x14]
add	x16, x16, x3
ld1.b	{ v4 }[13], [x15]
add	x17, x17, x3
ld1.b	{ v5 }[7], [x16]
ld1.b	{ v4 }[15], [x17]
ret
_gather16_neon:
umov.b	w14, v0[0]
umov.b	w15, v0[8]
umov.b	w16, v0[2]
add	x14, x14, x3
umov.b	w17, v0[10]
add	x15, x15, x3
ld1.b	{ v4 }[0], [x14]
umov.b	w14, v0[4]
add	x16, x16, x3
ld1.b	{ v5 }[8], [x15]
umov.b	w15, v0[12]
add	x17, x17, x3
ld1.b	{ v4 }[2], [x16]
umov.b	w16, v0[6]
add	x14, x14, x3
ld1.b	{ v5 }[10], [x17]
umov.b	w17, v0[14]
add	x15, x15, x3
ld1.b	{ v4 }[4], [x14]
add	x16, x16, x3
ld1.b	{ v5 }[12], [x15]
add	x17, x17, x3
ld1.b	{ v4 }[6], [x16]
ld1.b	{ v5 }[14], [x17]
umov.b	w14, v0[1]
umov.b	w15, v0[9]
umov.b	w16, v0[3]
add	x14, x14, x3
umov.b	w17, v0[11]
add	x15, x15, x3
ld1.b	{ v4 }[1], [x14]
umov.b	w14, v0[5]
add	x16, x16, x3
ld1.b	{ v5 }[9], [x15]
umov.b	w15, v0[13]
add	x17, x17, x3
ld1.b	{ v4 }[3], [x16]
umov.b	w16, v0[7]
add	x14, x14, x3
ld1.b	{ v5 }[11], [x17]
umov.b	w17, v0[15]
add	x15, x15, x3
ld1.b	{ v4 }[5], [x14]
add	x16, x16, x3
ld1.b	{ v5 }[13], [x15]
add	x17, x17, x3
ld1.b	{ v4 }[7], [x16]
ld1.b	{ v5 }[15], [x17]
mov.d	v4[1], v5[1]
ret
_fgy_32x32_8bpc_neon:
str	x30, [sp, #-16]!
ldr	w11, [x6, #8]
ldr	w13, [x6, #4]
ldr	w15, [x6, #12]
ldr	w6, [x6]
ldr	w8, [sp, #16]
mov	x9, #82
neg	w4, w4
dup.8h	v29, w4
adrp	x16, fgy_32x32_8bpc_neon
add	x16, x16, #0
cbz	w8, fgy_32x32_8bpc_neon
movi.16b	v30, #16
movi.16b	v31, #235
b	fgy_32x32_8bpc_neon
movi.16b	v30, #0
movi.16b	v31, #255
ld1.8b	{ v27, v28 }, [x16]
add	x5, x5, #9
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
ldr	w11, [sp, #24]
adr	x13, #824
add	x4, x12, #32
add	x6, x14, x9, lsl #5
tst	w11, #0x1
ldrh	w11, [x13, w11, uxtw #1]
add	x8, x16, x9, lsl #5
add	x8, x8, #32
sub	x11, x13, w11, uxtw
b.eq	fgy_32x32_8bpc_neon
dup.16b	v6, v27[0]
dup.16b	v7, v27[1]
mov	w10, w7
mov	w7, #2
br	x11
_fgy_loop_neon:
ld1.16b	{ v0, v1 }, [x1], x2
ld1.16b	{ v18, v19 }, [x5], x9
bl	gather32_neon
sshll.8h	v16, v18, #0
sshll2.8h	v17, v18, #0
sshll.8h	v18, v19, #0
sshll2.8h	v19, v19, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
ushll.8h	v4, v5, #0
ushll2.8h	v5, v5, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
mul.8h	v18, v18, v4
mul.8h	v19, v19, v5
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
uaddw.8h	v16, v16, v0
uaddw2.8h	v17, v17, v0
uaddw.8h	v18, v18, v1
uaddw2.8h	v19, v19, v1
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
sqxtun.8b	v1, v18
sqxtun2.16b	v1, v19
umax.16b	v0, v0, v30
umax.16b	v1, v1, v30
umin.16b	v0, v0, v31
umin.16b	v1, v1, v31
subs	w7, w7, #1
st1.16b	{ v0, v1 }, [x0], x2
b.gt	fgy_loop_neon
ldr	x30, [sp], #16
ret
ld1.16b	{ v0, v1 }, [x1], x2
ld1.16b	{ v22, v23 }, [x6], x9
ld1.16b	{ v18, v19 }, [x5], x9
bl	gather32_neon
smull.8h	v16, v18, v7
smull2.8h	v17, v18, v7
smull.8h	v18, v19, v7
smull2.8h	v19, v19, v7
smlal.8h	v16, v22, v6
smlal2.8h	v17, v22, v6
smlal.8h	v18, v23, v6
smlal2.8h	v19, v23, v6
sqrshrn.8b	v22, v16, #5
sqrshrn2.16b	v22, v17, #5
sqrshrn.8b	v23, v18, #5
sqrshrn2.16b	v23, v19, #5
sshll.8h	v16, v22, #0
sshll2.8h	v17, v22, #0
sshll.8h	v18, v23, #0
sshll2.8h	v19, v23, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
ushll.8h	v4, v5, #0
ushll2.8h	v5, v5, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
mul.8h	v18, v18, v4
mul.8h	v19, v19, v5
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
uaddw.8h	v16, v16, v0
uaddw2.8h	v17, v17, v0
uaddw.8h	v18, v18, v1
uaddw2.8h	v19, v19, v1
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
sqxtun.8b	v1, v18
sqxtun2.16b	v1, v19
umax.16b	v0, v0, v30
umax.16b	v1, v1, v30
umin.16b	v0, v0, v31
umin.16b	v1, v1, v31
subs	w7, w7, #1
dup.16b	v6, v28[0]
dup.16b	v7, v28[1]
st1.16b	{ v0, v1 }, [x0], x2
b.gt	fgy_loop_neon
cmp	w10, #2
sub	w7, w10, #2
b.gt	fgy_loop_neon
ldr	x30, [sp], #16
ret
ld1.16b	{ v0, v1 }, [x1], x2
ld1.8b	{ v20 }, [x4], x9
ld1.16b	{ v18, v19 }, [x5], x9
bl	gather32_neon
smull.8h	v20, v20, v27
smlal.8h	v20, v18, v28
sqrshrn.8b	v20, v20, #5
sshll2.8h	v17, v18, #0
sshll.8h	v18, v19, #0
sshll2.8h	v19, v19, #0
sshll.8h	v16, v20, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
ushll.8h	v4, v5, #0
ushll2.8h	v5, v5, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
mul.8h	v18, v18, v4
mul.8h	v19, v19, v5
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
uaddw.8h	v16, v16, v0
uaddw2.8h	v17, v17, v0
uaddw.8h	v18, v18, v1
uaddw2.8h	v19, v19, v1
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
sqxtun.8b	v1, v18
sqxtun2.16b	v1, v19
umax.16b	v0, v0, v30
umax.16b	v1, v1, v30
umin.16b	v0, v0, v31
umin.16b	v1, v1, v31
subs	w7, w7, #1
st1.16b	{ v0, v1 }, [x0], x2
b.gt	fgy_loop_neon
ldr	x30, [sp], #16
ret
ld1.16b	{ v0, v1 }, [x1], x2
ld1.8b	{ v20 }, [x4], x9
ld1.16b	{ v22, v23 }, [x6], x9
ld1.8b	{ v21 }, [x8], x9
ld1.16b	{ v18, v19 }, [x5], x9
bl	gather32_neon
smull.8h	v20, v20, v27
smlal.8h	v20, v18, v28
smull.8h	v21, v21, v27
smlal.8h	v21, v22, v28
sqrshrn.8b	v20, v20, #5
sqrshrn.8b	v21, v21, #5
smull.8h	v16, v20, v7
smull2.8h	v17, v18, v7
smull.8h	v18, v19, v7
smull2.8h	v19, v19, v7
smlal.8h	v16, v21, v6
smlal2.8h	v17, v22, v6
smlal.8h	v18, v23, v6
smlal2.8h	v19, v23, v6
sqrshrn.8b	v22, v16, #5
sqrshrn2.16b	v22, v17, #5
sqrshrn.8b	v23, v18, #5
sqrshrn2.16b	v23, v19, #5
sshll.8h	v16, v22, #0
sshll2.8h	v17, v22, #0
sshll.8h	v18, v23, #0
sshll2.8h	v19, v23, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
ushll.8h	v4, v5, #0
ushll2.8h	v5, v5, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
mul.8h	v18, v18, v4
mul.8h	v19, v19, v5
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
uaddw.8h	v16, v16, v0
uaddw2.8h	v17, v17, v0
uaddw.8h	v18, v18, v1
uaddw2.8h	v19, v19, v1
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
sqxtun.8b	v1, v18
sqxtun2.16b	v1, v19
umax.16b	v0, v0, v30
umax.16b	v1, v1, v30
umin.16b	v0, v0, v31
umin.16b	v1, v1, v31
subs	w7, w7, #1
dup.16b	v6, v28[0]
dup.16b	v7, v28[1]
st1.16b	{ v0, v1 }, [x0], x2
b.gt	fgy_loop_neon
cmp	w10, #2
sub	w7, w10, #2
b.gt	fgy_loop_neon
ldr	x30, [sp], #16
ret
<unknown>
<unknown>
_fguv_32x32_420_8bpc_neon:
str	x30, [sp, #-32]!
str	d8, [sp, #16]
ldp	x8, x9, [sp, #32]
ldp	x10, x11, [sp, #48]
ldr	w13, [x4, #88]
ldr	w12, [x4, #216]
neg	w13, w13
add	x10, x4, x10, lsl #2
add	x14, x10, #196
add	x15, x10, #188
add	x10, x10, #204
ld1.h	{ v8 }[0], [x14]
ld1r.8h	{ v24 }, [x10]
ld1.h	{ v8 }[1], [x15]
dup.8h	v29, w13
cbz	w12, fguv_32x32_420_8bpc_neon
movi.16b	v30, #16
movi.16b	v31, #240
cbz	w11, fguv_32x32_420_8bpc_neon
movi.16b	v31, #235
b	fguv_32x32_420_8bpc_neon
movi.16b	v30, #0
movi.16b	v31, #255
ldr	w12, [x8, #8]
ldr	w14, [x8, #4]
ldr	w16, [x8, #12]
ldr	w8, [x8]
mov	x10, #82
add	x5, x5, #6
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
add	x4, x13, #16
add	x8, x15, x10, lsl #4
add	x11, x17, x10, lsl #4
add	x11, x11, #16
ldr	w13, [sp, #64]
adrp	x16, fguv_32x32_420_8bpc_neon
add	x16, x16, #0
adr	x14, #4064
ld1.8b	{ v27, v28 }, [x16]
tst	w13, #0x1
ldrh	w13, [x14, w13, uxtw #1]
b.eq	fguv_32x32_420_8bpc_neon
sub	w12, w9, #1
mov	w9, #1
sub	x13, x14, w13, uxtw
movi.16b	v25, #23
movi.16b	v26, #22
add	x7, x7, x7
br	x13
_fguv_32x32_422_8bpc_neon:
str	x30, [sp, #-32]!
str	d8, [sp, #16]
ldp	x8, x9, [sp, #32]
ldp	x10, x11, [sp, #48]
ldr	w13, [x4, #88]
ldr	w12, [x4, #216]
neg	w13, w13
add	x10, x4, x10, lsl #2
add	x14, x10, #196
add	x15, x10, #188
add	x10, x10, #204
ld1.h	{ v8 }[0], [x14]
ld1r.8h	{ v24 }, [x10]
ld1.h	{ v8 }[1], [x15]
dup.8h	v29, w13
cbz	w12, fguv_32x32_422_8bpc_neon
movi.16b	v30, #16
movi.16b	v31, #240
cbz	w11, fguv_32x32_422_8bpc_neon
movi.16b	v31, #235
b	fguv_32x32_422_8bpc_neon
movi.16b	v30, #0
movi.16b	v31, #255
ldr	w12, [x8, #8]
ldr	w14, [x8, #4]
ldr	w16, [x8, #12]
ldr	w8, [x8]
mov	x10, #82
add	x5, x5, #6
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
add	x4, x13, #16
add	x8, x15, x10, lsl #5
add	x11, x17, x10, lsl #5
add	x11, x11, #16
ldr	w13, [sp, #64]
adrp	x16, fguv_32x32_422_8bpc_neon
add	x16, x16, #0
adr	x14, #3784
ld1.8b	{ v27, v28 }, [x16]
tst	w13, #0x1
ldrh	w13, [x14, w13, uxtw #1]
b.eq	fguv_32x32_422_8bpc_neon
sub	w12, w9, #2
mov	w9, #2
sub	x13, x14, w13, uxtw
movi.16b	v25, #27
movi.16b	v26, #17
br	x13
_fguv_32x32_444_8bpc_neon:
str	x30, [sp, #-32]!
str	d8, [sp, #16]
ldp	x8, x9, [sp, #32]
ldp	x10, x11, [sp, #48]
ldr	w13, [x4, #88]
ldr	w12, [x4, #216]
neg	w13, w13
add	x10, x4, x10, lsl #2
add	x14, x10, #196
add	x15, x10, #188
add	x10, x10, #204
ld1.h	{ v8 }[0], [x14]
ld1r.8h	{ v24 }, [x10]
ld1.h	{ v8 }[1], [x15]
dup.8h	v29, w13
cbz	w12, fguv_32x32_444_8bpc_neon
movi.16b	v30, #16
movi.16b	v31, #240
cbz	w11, fguv_32x32_444_8bpc_neon
movi.16b	v31, #235
b	fguv_32x32_444_8bpc_neon
movi.16b	v30, #0
movi.16b	v31, #255
ldr	w12, [x8, #8]
ldr	w14, [x8, #4]
ldr	w16, [x8, #12]
ldr	w8, [x8]
mov	x10, #82
add	x5, x5, #9
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
add	x4, x13, #32
add	x8, x15, x10, lsl #5
add	x11, x17, x10, lsl #5
add	x11, x11, #32
ldr	w13, [sp, #64]
adrp	x16, fguv_32x32_444_8bpc_neon
add	x16, x16, #0
adr	x14, #2104
ld1.8b	{ v27, v28 }, [x16]
tst	w13, #0x1
ldrh	w13, [x14, w13, uxtw #1]
b.eq	fguv_32x32_444_8bpc_neon
sub	w12, w9, #2
mov	w9, #2
sub	x13, x14, w13, uxtw
movi.16b	v25, #27
movi.16b	v26, #17
br	x13
_fguv_loop_sx0_neon:
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6, v7 }, [x1], x2
ld1.16b	{ v18, v19 }, [x5], x10
ushll.8h	v2, v0, #0
ushll2.8h	v3, v0, #0
ushll.8h	v4, v1, #0
ushll2.8h	v5, v1, #0
ushll.8h	v0, v6, #0
ushll2.8h	v1, v6, #0
ushll.8h	v16, v7, #0
ushll2.8h	v17, v7, #0
mul.8h	v2, v2, v8[0]
mul.8h	v3, v3, v8[0]
mul.8h	v4, v4, v8[0]
mul.8h	v5, v5, v8[0]
mul.8h	v0, v0, v8[1]
mul.8h	v1, v1, v8[1]
mul.8h	v16, v16, v8[1]
mul.8h	v17, v17, v8[1]
sqadd.8h	v2, v2, v0
sqadd.8h	v3, v3, v1
sqadd.8h	v4, v4, v16
sqadd.8h	v5, v5, v17
sshr.8h	v2, v2, #6
sshr.8h	v3, v3, #6
sshr.8h	v4, v4, #6
sshr.8h	v5, v5, #6
add.8h	v2, v2, v24
add.8h	v3, v3, v24
add.8h	v4, v4, v24
add.8h	v5, v5, v24
sqxtun.8b	v0, v2
sqxtun2.16b	v0, v3
sqxtun.8b	v1, v4
sqxtun2.16b	v1, v5
bl	gather32_neon
sshll.8h	v16, v18, #0
sshll2.8h	v17, v18, #0
sshll.8h	v18, v19, #0
sshll2.8h	v19, v19, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
ushll.8h	v4, v5, #0
ushll2.8h	v5, v5, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
mul.8h	v18, v18, v4
mul.8h	v19, v19, v5
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
uaddw.8h	v18, v18, v7
uaddw2.8h	v19, v19, v7
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
sqxtun.8b	v1, v18
sqxtun2.16b	v1, v19
umax.16b	v0, v0, v30
umax.16b	v1, v1, v30
umin.16b	v0, v0, v31
umin.16b	v1, v1, v31
subs	w9, w9, #1
st1.16b	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6, v7 }, [x1], x2
ld1.16b	{ v22, v23 }, [x8], x10
ld1.16b	{ v18, v19 }, [x5], x10
ushll.8h	v2, v0, #0
ushll2.8h	v3, v0, #0
ushll.8h	v4, v1, #0
ushll2.8h	v5, v1, #0
ushll.8h	v0, v6, #0
ushll2.8h	v1, v6, #0
ushll.8h	v16, v7, #0
ushll2.8h	v17, v7, #0
mul.8h	v2, v2, v8[0]
mul.8h	v3, v3, v8[0]
mul.8h	v4, v4, v8[0]
mul.8h	v5, v5, v8[0]
mul.8h	v0, v0, v8[1]
mul.8h	v1, v1, v8[1]
mul.8h	v16, v16, v8[1]
mul.8h	v17, v17, v8[1]
sqadd.8h	v2, v2, v0
sqadd.8h	v3, v3, v1
sqadd.8h	v4, v4, v16
sqadd.8h	v5, v5, v17
sshr.8h	v2, v2, #6
sshr.8h	v3, v3, #6
sshr.8h	v4, v4, #6
sshr.8h	v5, v5, #6
add.8h	v2, v2, v24
add.8h	v3, v3, v24
add.8h	v4, v4, v24
add.8h	v5, v5, v24
sqxtun.8b	v0, v2
sqxtun2.16b	v0, v3
sqxtun.8b	v1, v4
sqxtun2.16b	v1, v5
bl	gather32_neon
smull.8h	v16, v18, v26
smull2.8h	v17, v18, v26
smull.8h	v18, v19, v26
smull2.8h	v19, v19, v26
smlal.8h	v16, v22, v25
smlal2.8h	v17, v22, v25
smlal.8h	v18, v23, v25
smlal2.8h	v19, v23, v25
sqrshrn.8b	v22, v16, #5
sqrshrn2.16b	v22, v17, #5
sqrshrn.8b	v23, v18, #5
sqrshrn2.16b	v23, v19, #5
sshll.8h	v16, v22, #0
sshll2.8h	v17, v22, #0
sshll.8h	v18, v23, #0
sshll2.8h	v19, v23, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
ushll.8h	v4, v5, #0
ushll2.8h	v5, v5, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
mul.8h	v18, v18, v4
mul.8h	v19, v19, v5
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
uaddw.8h	v18, v18, v7
uaddw2.8h	v19, v19, v7
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
sqxtun.8b	v1, v18
sqxtun2.16b	v1, v19
umax.16b	v0, v0, v30
umax.16b	v1, v1, v30
umin.16b	v0, v0, v31
umin.16b	v1, v1, v31
subs	w9, w9, #1
dup.16b	v25, v28[0]
dup.16b	v26, v28[1]
st1.16b	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx0_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6, v7 }, [x1], x2
ld1.8b	{ v20 }, [x4], x10
ld1.16b	{ v18, v19 }, [x5], x10
ushll.8h	v2, v0, #0
ushll2.8h	v3, v0, #0
ushll.8h	v4, v1, #0
ushll2.8h	v5, v1, #0
ushll.8h	v0, v6, #0
ushll2.8h	v1, v6, #0
ushll.8h	v16, v7, #0
ushll2.8h	v17, v7, #0
mul.8h	v2, v2, v8[0]
mul.8h	v3, v3, v8[0]
mul.8h	v4, v4, v8[0]
mul.8h	v5, v5, v8[0]
mul.8h	v0, v0, v8[1]
mul.8h	v1, v1, v8[1]
mul.8h	v16, v16, v8[1]
mul.8h	v17, v17, v8[1]
sqadd.8h	v2, v2, v0
sqadd.8h	v3, v3, v1
sqadd.8h	v4, v4, v16
sqadd.8h	v5, v5, v17
sshr.8h	v2, v2, #6
sshr.8h	v3, v3, #6
sshr.8h	v4, v4, #6
sshr.8h	v5, v5, #6
add.8h	v2, v2, v24
add.8h	v3, v3, v24
add.8h	v4, v4, v24
add.8h	v5, v5, v24
sqxtun.8b	v0, v2
sqxtun2.16b	v0, v3
sqxtun.8b	v1, v4
sqxtun2.16b	v1, v5
bl	gather32_neon
smull.8h	v20, v20, v27
smlal.8h	v20, v18, v28
sqrshrn.8b	v20, v20, #5
sshll2.8h	v17, v18, #0
sshll.8h	v18, v19, #0
sshll2.8h	v19, v19, #0
sshll.8h	v16, v20, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
ushll.8h	v4, v5, #0
ushll2.8h	v5, v5, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
mul.8h	v18, v18, v4
mul.8h	v19, v19, v5
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
uaddw.8h	v18, v18, v7
uaddw2.8h	v19, v19, v7
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
sqxtun.8b	v1, v18
sqxtun2.16b	v1, v19
umax.16b	v0, v0, v30
umax.16b	v1, v1, v30
umin.16b	v0, v0, v31
umin.16b	v1, v1, v31
subs	w9, w9, #1
st1.16b	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6, v7 }, [x1], x2
ld1.8b	{ v20 }, [x4], x10
ld1.16b	{ v22, v23 }, [x8], x10
ld1.8b	{ v21 }, [x11], x10
ld1.16b	{ v18, v19 }, [x5], x10
ushll.8h	v2, v0, #0
ushll2.8h	v3, v0, #0
ushll.8h	v4, v1, #0
ushll2.8h	v5, v1, #0
ushll.8h	v0, v6, #0
ushll2.8h	v1, v6, #0
ushll.8h	v16, v7, #0
ushll2.8h	v17, v7, #0
mul.8h	v2, v2, v8[0]
mul.8h	v3, v3, v8[0]
mul.8h	v4, v4, v8[0]
mul.8h	v5, v5, v8[0]
mul.8h	v0, v0, v8[1]
mul.8h	v1, v1, v8[1]
mul.8h	v16, v16, v8[1]
mul.8h	v17, v17, v8[1]
sqadd.8h	v2, v2, v0
sqadd.8h	v3, v3, v1
sqadd.8h	v4, v4, v16
sqadd.8h	v5, v5, v17
sshr.8h	v2, v2, #6
sshr.8h	v3, v3, #6
sshr.8h	v4, v4, #6
sshr.8h	v5, v5, #6
add.8h	v2, v2, v24
add.8h	v3, v3, v24
add.8h	v4, v4, v24
add.8h	v5, v5, v24
sqxtun.8b	v0, v2
sqxtun2.16b	v0, v3
sqxtun.8b	v1, v4
sqxtun2.16b	v1, v5
bl	gather32_neon
smull.8h	v20, v20, v27
smlal.8h	v20, v18, v28
smull.8h	v21, v21, v27
smlal.8h	v21, v22, v28
sqrshrn.8b	v20, v20, #5
sqrshrn.8b	v21, v21, #5
smull.8h	v16, v20, v26
smull2.8h	v17, v18, v26
smull.8h	v18, v19, v26
smull2.8h	v19, v19, v26
smlal.8h	v16, v21, v25
smlal2.8h	v17, v22, v25
smlal.8h	v18, v23, v25
smlal2.8h	v19, v23, v25
sqrshrn.8b	v22, v16, #5
sqrshrn2.16b	v22, v17, #5
sqrshrn.8b	v23, v18, #5
sqrshrn2.16b	v23, v19, #5
sshll.8h	v16, v22, #0
sshll2.8h	v17, v22, #0
sshll.8h	v18, v23, #0
sshll2.8h	v19, v23, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
ushll.8h	v4, v5, #0
ushll2.8h	v5, v5, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
mul.8h	v18, v18, v4
mul.8h	v19, v19, v5
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
uaddw.8h	v18, v18, v7
uaddw2.8h	v19, v19, v7
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
sqxtun.8b	v1, v18
sqxtun2.16b	v1, v19
umax.16b	v0, v0, v30
umax.16b	v1, v1, v30
umin.16b	v0, v0, v31
umin.16b	v1, v1, v31
subs	w9, w9, #1
dup.16b	v25, v28[0]
dup.16b	v26, v28[1]
st1.16b	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx0_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6, v7 }, [x1], x2
ld1.16b	{ v18, v19 }, [x5], x10
bl	gather32_neon
sshll.8h	v16, v18, #0
sshll2.8h	v17, v18, #0
sshll.8h	v18, v19, #0
sshll2.8h	v19, v19, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
ushll.8h	v4, v5, #0
ushll2.8h	v5, v5, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
mul.8h	v18, v18, v4
mul.8h	v19, v19, v5
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
uaddw.8h	v18, v18, v7
uaddw2.8h	v19, v19, v7
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
sqxtun.8b	v1, v18
sqxtun2.16b	v1, v19
umax.16b	v0, v0, v30
umax.16b	v1, v1, v30
umin.16b	v0, v0, v31
umin.16b	v1, v1, v31
subs	w9, w9, #1
st1.16b	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6, v7 }, [x1], x2
ld1.16b	{ v22, v23 }, [x8], x10
ld1.16b	{ v18, v19 }, [x5], x10
bl	gather32_neon
smull.8h	v16, v18, v26
smull2.8h	v17, v18, v26
smull.8h	v18, v19, v26
smull2.8h	v19, v19, v26
smlal.8h	v16, v22, v25
smlal2.8h	v17, v22, v25
smlal.8h	v18, v23, v25
smlal2.8h	v19, v23, v25
sqrshrn.8b	v22, v16, #5
sqrshrn2.16b	v22, v17, #5
sqrshrn.8b	v23, v18, #5
sqrshrn2.16b	v23, v19, #5
sshll.8h	v16, v22, #0
sshll2.8h	v17, v22, #0
sshll.8h	v18, v23, #0
sshll2.8h	v19, v23, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
ushll.8h	v4, v5, #0
ushll2.8h	v5, v5, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
mul.8h	v18, v18, v4
mul.8h	v19, v19, v5
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
uaddw.8h	v18, v18, v7
uaddw2.8h	v19, v19, v7
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
sqxtun.8b	v1, v18
sqxtun2.16b	v1, v19
umax.16b	v0, v0, v30
umax.16b	v1, v1, v30
umin.16b	v0, v0, v31
umin.16b	v1, v1, v31
subs	w9, w9, #1
dup.16b	v25, v28[0]
dup.16b	v26, v28[1]
st1.16b	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx0_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6, v7 }, [x1], x2
ld1.8b	{ v20 }, [x4], x10
ld1.16b	{ v18, v19 }, [x5], x10
bl	gather32_neon
smull.8h	v20, v20, v27
smlal.8h	v20, v18, v28
sqrshrn.8b	v20, v20, #5
sshll2.8h	v17, v18, #0
sshll.8h	v18, v19, #0
sshll2.8h	v19, v19, #0
sshll.8h	v16, v20, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
ushll.8h	v4, v5, #0
ushll2.8h	v5, v5, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
mul.8h	v18, v18, v4
mul.8h	v19, v19, v5
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
uaddw.8h	v18, v18, v7
uaddw2.8h	v19, v19, v7
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
sqxtun.8b	v1, v18
sqxtun2.16b	v1, v19
umax.16b	v0, v0, v30
umax.16b	v1, v1, v30
umin.16b	v0, v0, v31
umin.16b	v1, v1, v31
subs	w9, w9, #1
st1.16b	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6, v7 }, [x1], x2
ld1.8b	{ v20 }, [x4], x10
ld1.16b	{ v22, v23 }, [x8], x10
ld1.8b	{ v21 }, [x11], x10
ld1.16b	{ v18, v19 }, [x5], x10
bl	gather32_neon
smull.8h	v20, v20, v27
smlal.8h	v20, v18, v28
smull.8h	v21, v21, v27
smlal.8h	v21, v22, v28
sqrshrn.8b	v20, v20, #5
sqrshrn.8b	v21, v21, #5
smull.8h	v16, v20, v26
smull2.8h	v17, v18, v26
smull.8h	v18, v19, v26
smull2.8h	v19, v19, v26
smlal.8h	v16, v21, v25
smlal2.8h	v17, v22, v25
smlal.8h	v18, v23, v25
smlal2.8h	v19, v23, v25
sqrshrn.8b	v22, v16, #5
sqrshrn2.16b	v22, v17, #5
sqrshrn.8b	v23, v18, #5
sqrshrn2.16b	v23, v19, #5
sshll.8h	v16, v22, #0
sshll2.8h	v17, v22, #0
sshll.8h	v18, v23, #0
sshll2.8h	v19, v23, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
ushll.8h	v4, v5, #0
ushll2.8h	v5, v5, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
mul.8h	v18, v18, v4
mul.8h	v19, v19, v5
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
uaddw.8h	v18, v18, v7
uaddw2.8h	v19, v19, v7
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
sqxtun.8b	v1, v18
sqxtun2.16b	v1, v19
umax.16b	v0, v0, v30
umax.16b	v1, v1, v30
umin.16b	v0, v0, v31
umin.16b	v1, v1, v31
subs	w9, w9, #1
dup.16b	v25, v28[0]
dup.16b	v26, v28[1]
st1.16b	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx0_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ldr	d8, [sp, #16]
ldr	x30, [sp], #32
ret
<unknown>
<unknown>
<unknown>
<unknown>
_fguv_loop_sx1_neon:
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6 }, [x1], x2
ld1.16b	{ v18 }, [x5], x10
uaddlp.8h	v2, v0
uaddlp.8h	v3, v1
urshr.8h	v2, v2, #1
urshr.8h	v3, v3, #1
ushll.8h	v0, v6, #0
ushll2.8h	v1, v6, #0
mul.8h	v2, v2, v8[0]
mul.8h	v3, v3, v8[0]
mul.8h	v0, v0, v8[1]
mul.8h	v1, v1, v8[1]
sqadd.8h	v2, v2, v0
sqadd.8h	v3, v3, v1
sshr.8h	v2, v2, #6
sshr.8h	v3, v3, #6
add.8h	v2, v2, v24
add.8h	v3, v3, v24
sqxtun.8b	v0, v2
sqxtun2.16b	v0, v3
bl	gather16_neon
sshll.8h	v16, v18, #0
sshll2.8h	v17, v18, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
umax.16b	v0, v0, v30
umin.16b	v0, v0, v31
subs	w9, w9, #1
st1.16b	{ v0 }, [x0], x2
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6 }, [x1], x2
ld1.16b	{ v22 }, [x8], x10
ld1.16b	{ v18 }, [x5], x10
uaddlp.8h	v2, v0
uaddlp.8h	v3, v1
urshr.8h	v2, v2, #1
urshr.8h	v3, v3, #1
ushll.8h	v0, v6, #0
ushll2.8h	v1, v6, #0
mul.8h	v2, v2, v8[0]
mul.8h	v3, v3, v8[0]
mul.8h	v0, v0, v8[1]
mul.8h	v1, v1, v8[1]
sqadd.8h	v2, v2, v0
sqadd.8h	v3, v3, v1
sshr.8h	v2, v2, #6
sshr.8h	v3, v3, #6
add.8h	v2, v2, v24
add.8h	v3, v3, v24
sqxtun.8b	v0, v2
sqxtun2.16b	v0, v3
bl	gather16_neon
smull.8h	v16, v18, v26
smull2.8h	v17, v18, v26
smlal.8h	v16, v22, v25
smlal2.8h	v17, v22, v25
sqrshrn.8b	v22, v16, #5
sqrshrn2.16b	v22, v17, #5
sshll.8h	v16, v22, #0
sshll2.8h	v17, v22, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
umax.16b	v0, v0, v30
umin.16b	v0, v0, v31
mov.16b	v16, v25
subs	w9, w9, #1
mov.16b	v25, v26
mov.16b	v26, v16
st1.16b	{ v0 }, [x0], x2
b.gt	fguv_loop_sx1_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6 }, [x1], x2
ld1.8b	{ v20 }, [x4], x10
ld1.16b	{ v18 }, [x5], x10
uaddlp.8h	v2, v0
uaddlp.8h	v3, v1
urshr.8h	v2, v2, #1
urshr.8h	v3, v3, #1
ushll.8h	v0, v6, #0
ushll2.8h	v1, v6, #0
mul.8h	v2, v2, v8[0]
mul.8h	v3, v3, v8[0]
mul.8h	v0, v0, v8[1]
mul.8h	v1, v1, v8[1]
sqadd.8h	v2, v2, v0
sqadd.8h	v3, v3, v1
sshr.8h	v2, v2, #6
sshr.8h	v3, v3, #6
add.8h	v2, v2, v24
add.8h	v3, v3, v24
sqxtun.8b	v0, v2
sqxtun2.16b	v0, v3
bl	gather16_neon
smull.8h	v20, v20, v27
smlal.8h	v20, v18, v28
sqrshrn.8b	v20, v20, #5
sshll2.8h	v17, v18, #0
sshll.8h	v16, v20, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
umax.16b	v0, v0, v30
umin.16b	v0, v0, v31
subs	w9, w9, #1
st1.16b	{ v0 }, [x0], x2
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6 }, [x1], x2
ld1.8b	{ v20 }, [x4], x10
ld1.16b	{ v22 }, [x8], x10
ld1.8b	{ v21 }, [x11], x10
ld1.16b	{ v18 }, [x5], x10
uaddlp.8h	v2, v0
uaddlp.8h	v3, v1
urshr.8h	v2, v2, #1
urshr.8h	v3, v3, #1
ushll.8h	v0, v6, #0
ushll2.8h	v1, v6, #0
mul.8h	v2, v2, v8[0]
mul.8h	v3, v3, v8[0]
mul.8h	v0, v0, v8[1]
mul.8h	v1, v1, v8[1]
sqadd.8h	v2, v2, v0
sqadd.8h	v3, v3, v1
sshr.8h	v2, v2, #6
sshr.8h	v3, v3, #6
add.8h	v2, v2, v24
add.8h	v3, v3, v24
sqxtun.8b	v0, v2
sqxtun2.16b	v0, v3
bl	gather16_neon
smull.8h	v20, v20, v27
smlal.8h	v20, v18, v28
smull.8h	v21, v21, v27
smlal.8h	v21, v22, v28
sqrshrn.8b	v20, v20, #5
sqrshrn.8b	v21, v21, #5
smull.8h	v16, v20, v26
smull2.8h	v17, v18, v26
smlal.8h	v16, v21, v25
smlal2.8h	v17, v22, v25
sqrshrn.8b	v22, v16, #5
sqrshrn2.16b	v22, v17, #5
sshll.8h	v16, v22, #0
sshll2.8h	v17, v22, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
umax.16b	v0, v0, v30
umin.16b	v0, v0, v31
mov.16b	v16, v25
subs	w9, w9, #1
mov.16b	v25, v26
mov.16b	v26, v16
st1.16b	{ v0 }, [x0], x2
b.gt	fguv_loop_sx1_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6 }, [x1], x2
ld1.16b	{ v18 }, [x5], x10
uaddlp.8h	v2, v0
uaddlp.8h	v3, v1
rshrn.8b	v0, v2, #1
rshrn2.16b	v0, v3, #1
bl	gather16_neon
sshll.8h	v16, v18, #0
sshll2.8h	v17, v18, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
umax.16b	v0, v0, v30
umin.16b	v0, v0, v31
subs	w9, w9, #1
st1.16b	{ v0 }, [x0], x2
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6 }, [x1], x2
ld1.16b	{ v22 }, [x8], x10
ld1.16b	{ v18 }, [x5], x10
uaddlp.8h	v2, v0
uaddlp.8h	v3, v1
rshrn.8b	v0, v2, #1
rshrn2.16b	v0, v3, #1
bl	gather16_neon
smull.8h	v16, v18, v26
smull2.8h	v17, v18, v26
smlal.8h	v16, v22, v25
smlal2.8h	v17, v22, v25
sqrshrn.8b	v22, v16, #5
sqrshrn2.16b	v22, v17, #5
sshll.8h	v16, v22, #0
sshll2.8h	v17, v22, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
umax.16b	v0, v0, v30
umin.16b	v0, v0, v31
mov.16b	v16, v25
subs	w9, w9, #1
mov.16b	v25, v26
mov.16b	v26, v16
st1.16b	{ v0 }, [x0], x2
b.gt	fguv_loop_sx1_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6 }, [x1], x2
ld1.8b	{ v20 }, [x4], x10
ld1.16b	{ v18 }, [x5], x10
uaddlp.8h	v2, v0
uaddlp.8h	v3, v1
rshrn.8b	v0, v2, #1
rshrn2.16b	v0, v3, #1
bl	gather16_neon
smull.8h	v20, v20, v27
smlal.8h	v20, v18, v28
sqrshrn.8b	v20, v20, #5
sshll2.8h	v17, v18, #0
sshll.8h	v16, v20, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
umax.16b	v0, v0, v30
umin.16b	v0, v0, v31
subs	w9, w9, #1
st1.16b	{ v0 }, [x0], x2
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.16b	{ v0, v1 }, [x6], x7
ld1.16b	{ v6 }, [x1], x2
ld1.8b	{ v20 }, [x4], x10
ld1.16b	{ v22 }, [x8], x10
ld1.8b	{ v21 }, [x11], x10
ld1.16b	{ v18 }, [x5], x10
uaddlp.8h	v2, v0
uaddlp.8h	v3, v1
rshrn.8b	v0, v2, #1
rshrn2.16b	v0, v3, #1
bl	gather16_neon
smull.8h	v20, v20, v27
smlal.8h	v20, v18, v28
smull.8h	v21, v21, v27
smlal.8h	v21, v22, v28
sqrshrn.8b	v20, v20, #5
sqrshrn.8b	v21, v21, #5
smull.8h	v16, v20, v26
smull2.8h	v17, v18, v26
smlal.8h	v16, v21, v25
smlal2.8h	v17, v22, v25
sqrshrn.8b	v22, v16, #5
sqrshrn2.16b	v22, v17, #5
sshll.8h	v16, v22, #0
sshll2.8h	v17, v22, #0
ushll.8h	v2, v4, #0
ushll2.8h	v3, v4, #0
mul.8h	v16, v16, v2
mul.8h	v17, v17, v3
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
uaddw.8h	v16, v16, v6
uaddw2.8h	v17, v17, v6
sqxtun.8b	v0, v16
sqxtun2.16b	v0, v17
umax.16b	v0, v0, v30
umin.16b	v0, v0, v31
mov.16b	v16, v25
subs	w9, w9, #1
mov.16b	v25, v26
mov.16b	v26, v16
st1.16b	{ v0 }, [x0], x2
b.gt	fguv_loop_sx1_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ldr	d8, [sp, #16]
ldr	x30, [sp], #32
ret
sub	z28.s, z10.s, z28.s
<unknown>
<unknown>
<unknown>