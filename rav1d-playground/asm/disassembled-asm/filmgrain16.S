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
ret
_get_grain_4_neon:
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
add	x15, x3, x15, lsl #1
ld1.h	{ v0 }[2], [x14]
ld1.h	{ v0 }[3], [x15]
srshl.4h	v0, v0, v31
ret
_output_lag1_neon:
ubfx	x13, x2, #6, #11
lsr	w2, w2, #1
mov.s	w11, v1[0]
ldrsh	w12, [x3, x13, lsl #1]
ext.16b	v0, v0, v0, #2
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
mov.h	v0[7], w14
b.gt	output_lag1_neon
ret
_output_lag2_neon:
ubfx	x13, x2, #6, #11
lsr	w2, w2, #1
mov.s	w11, v1[0]
ldrsh	w12, [x3, x13, lsl #1]
ext.16b	v0, v0, v0, #2
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
mov.h	v0[7], w14
b.gt	output_lag2_neon
ret
_output_lag3_neon:
ubfx	x13, x2, #6, #11
lsr	w2, w2, #1
mov.s	w11, v1[0]
ldrsh	w12, [x3, x13, lsl #1]
ext.16b	v0, v0, v0, #2
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
mov.h	v0[7], w14
b.gt	output_lag3_neon
ret
_sum_lag1_above_neon:
sub	x12, x0, #148
ld1.8h	{ v18 }, [x12]
ext.16b	v0, v16, v17, #14
ext.16b	v1, v17, v18, #2
smull.4s	v4, v17, v28
smlal.4s	v4, v0, v27
smlal.4s	v4, v1, v29
smull2.4s	v5, v17, v28
smlal2.4s	v5, v0, v27
smlal2.4s	v5, v1, v29
mov.16b	v16, v17
mov.16b	v17, v18
ret
_sum_y_lag1_left_neon:
str	x30, [sp, #-16]!
sub	x12, x0, #164
ld1.8h	{ v17 }, [x12]
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
ext.16b	v4, v4, v4, #12
smov.h	w14, v0[7]
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
st1.8h	{ v0 }, [x0], #16
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
st1.8h	{ v0 }, [x0], #16
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
mov	w15, #3
bl	output_lag1_neon
ubfx	x15, x2, #6, #11
lsr	w2, w2, #1
add	x15, x3, x15, lsl #1
ld1.h	{ v1 }[0], [x15]
srshl.4h	v1, v1, v31
ext.16b	v0, v0, v1, #2
st1.8h	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_sum_uv_444_lag1_left_neon:
str	x30, [sp, #-16]!
sub	x12, x0, #164
ld1.8h	{ v17 }, [x12]
bl	sum_lag1_above_neon
ld1.8h	{ v0 }, [x19], #16
smlal.4s	v4, v0, v30
smlal2.4s	v5, v0, v30
b	sum_lag1_y_left_start
_sum_uv_444_lag1_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
ld1.8h	{ v0 }, [x19], #16
smlal.4s	v4, v0, v30
smlal2.4s	v5, v0, v30
b	sum_lag1_y_mid_start
_sum_uv_444_lag1_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
ld1.8h	{ v0 }, [x19], #16
smlal.4s	v4, v0, v30
smlal2.4s	v5, v0, v30
b	sum_lag1_y_right_start
_sum_uv_422_lag1_left_neon:
str	x30, [sp, #-16]!
sub	x12, x0, #164
ld1.8h	{ v17 }, [x12]
bl	sum_lag1_above_neon
ld1.8h	{ v22, v23 }, [x19], #32
addp.8h	v22, v22, v23
srshr.8h	v0, v22, #1
smlal.4s	v4, v0, v30
smlal2.4s	v5, v0, v30
b	sum_lag1_y_left_start
_sum_uv_422_lag1_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
ld1.8h	{ v22, v23 }, [x19], #32
addp.8h	v22, v22, v23
srshr.8h	v0, v22, #1
smlal.4s	v4, v0, v30
smlal2.4s	v5, v0, v30
b	sum_lag1_y_mid_start
_sum_uv_422_lag1_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
ld1.8h	{ v22, v23 }, [x19], #32
addp.8h	v22, v22, v23
srshr.8h	v0, v22, #1
smlal.4s	v4, v0, v30
smlal2.4s	v5, v0, v30
b	sum_lag1_uv_420_right_start
_sum_uv_420_lag1_left_neon:
str	x30, [sp, #-16]!
sub	x12, x0, #164
ld1.8h	{ v17 }, [x12]
bl	sum_lag1_above_neon
add	x12, x19, #164
ld1.8h	{ v22, v23 }, [x19], #32
ld1.8h	{ v24, v25 }, [x12]
addp.8h	v22, v22, v23
addp.8h	v23, v24, v25
add.8h	v22, v22, v23
srshr.8h	v0, v22, #2
smlal.4s	v4, v0, v30
smlal2.4s	v5, v0, v30
b	sum_lag1_y_left_start
_sum_uv_420_lag1_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
add	x12, x19, #164
ld1.8h	{ v22, v23 }, [x19], #32
ld1.8h	{ v24, v25 }, [x12]
addp.8h	v22, v22, v23
addp.8h	v23, v24, v25
add.8h	v22, v22, v23
srshr.8h	v0, v22, #2
smlal.4s	v4, v0, v30
smlal2.4s	v5, v0, v30
b	sum_lag1_y_mid_start
_sum_uv_420_lag1_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag1_above_neon
add	x12, x19, #164
ld1.8h	{ v22, v23 }, [x19], #32
ld1.8h	{ v24, v25 }, [x12]
addp.8h	v22, v22, v23
addp.8h	v23, v24, v25
add.8h	v22, v22, v23
srshr.8h	v0, v22, #2
smlal.4s	v4, v0, v30
smlal2.4s	v5, v0, v30
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
ext.16b	v0, v0, v1, #14
st1.8h	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_sum_lag2_above_neon:
sub	x12, x0, #312
sub	x13, x0, #148
ld1.8h	{ v18 }, [x12]
ld1.8h	{ v21 }, [x13]
dup.8b	v26, v30[0]
ext.16b	v22, v16, v17, #12
dup.8b	v27, v30[1]
ext.16b	v23, v16, v17, #14
sshll.8h	v26, v26, #0
dup.8b	v28, v30[3]
ext.16b	v0, v17, v18, #2
sshll.8h	v27, v27, #0
dup.8b	v29, v30[4]
ext.16b	v1, v17, v18, #4
sshll.8h	v28, v28, #0
sshll.8h	v29, v29, #0
smull.4s	v4, v22, v26
smlal.4s	v4, v23, v27
smlal.4s	v4, v0, v28
smlal.4s	v4, v1, v29
smull2.4s	v5, v22, v26
smlal2.4s	v5, v23, v27
smlal2.4s	v5, v0, v28
smlal2.4s	v5, v1, v29
dup.16b	v26, v30[5]
ext.16b	v22, v19, v20, #12
dup.16b	v27, v30[6]
ext.16b	v23, v19, v20, #14
sshll.8h	v26, v26, #0
dup.16b	v28, v30[8]
ext.16b	v0, v20, v21, #2
sshll.8h	v27, v27, #0
dup.16b	v29, v30[9]
ext.16b	v1, v20, v21, #4
sshll.8h	v28, v28, #0
sshll.8h	v29, v29, #0
smlal.4s	v4, v22, v26
smlal.4s	v4, v23, v27
smlal.4s	v4, v0, v28
smlal.4s	v4, v1, v29
smlal2.4s	v5, v22, v26
smlal2.4s	v5, v23, v27
smlal2.4s	v5, v0, v28
smlal2.4s	v5, v1, v29
dup.16b	v26, v30[2]
dup.16b	v27, v30[7]
sshll.8h	v26, v26, #0
sshll.8h	v27, v27, #0
smlal.4s	v4, v17, v26
smlal.4s	v4, v20, v27
smlal2.4s	v5, v17, v26
smlal2.4s	v5, v20, v27
mov.16b	v16, v17
mov.16b	v17, v18
mov.16b	v19, v20
mov.16b	v20, v21
ret
_sum_y_lag2_left_neon:
str	x30, [sp, #-16]!
sub	x12, x0, #328
sub	x13, x0, #164
ld1.8h	{ v17 }, [x12]
ld1.8h	{ v20 }, [x13]
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
ext.16b	v4, v4, v4, #12
smov.h	w16, v0[6]
smov.h	w14, v0[7]
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
st1.8h	{ v0 }, [x0], #16
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
st1.8h	{ v0 }, [x0], #16
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
mov	w15, #3
bl	output_lag2_neon
ubfx	x15, x2, #6, #11
lsr	w2, w2, #1
add	x15, x3, x15, lsl #1
ld1.h	{ v1 }[0], [x15]
srshl.4h	v1, v1, v31
ext.16b	v0, v0, v1, #2
st1.8h	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_sum_uv_444_lag2_left_neon:
str	x30, [sp, #-16]!
sub	x12, x0, #328
sub	x13, x0, #164
ld1.8h	{ v17 }, [x12]
ld1.8h	{ v20 }, [x13]
bl	sum_lag2_above_neon
ld1.8h	{ v0 }, [x19], #16
dup.8b	v1, v30[12]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag2_y_left_start
_sum_uv_444_lag2_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
ld1.8h	{ v0 }, [x19], #16
dup.8b	v1, v30[12]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag2_y_mid_start
_sum_uv_444_lag2_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
ld1.8h	{ v0 }, [x19], #16
dup.8b	v1, v30[12]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag2_y_right_start
_sum_uv_422_lag2_left_neon:
str	x30, [sp, #-16]!
sub	x12, x0, #328
sub	x13, x0, #164
ld1.8h	{ v17 }, [x12]
ld1.8h	{ v20 }, [x13]
bl	sum_lag2_above_neon
ld1.8h	{ v22, v23 }, [x19], #32
addp.8h	v22, v22, v23
srshr.8h	v0, v22, #1
dup.8b	v1, v30[12]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag2_y_left_start
_sum_uv_422_lag2_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
ld1.8h	{ v22, v23 }, [x19], #32
addp.8h	v22, v22, v23
srshr.8h	v0, v22, #1
dup.8b	v1, v30[12]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag2_y_mid_start
_sum_uv_422_lag2_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
ld1.8h	{ v22, v23 }, [x19], #32
addp.8h	v22, v22, v23
srshr.8h	v0, v22, #1
dup.8b	v1, v30[12]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag2_uv_420_right_start
_sum_uv_420_lag2_left_neon:
str	x30, [sp, #-16]!
sub	x12, x0, #328
sub	x13, x0, #164
ld1.8h	{ v17 }, [x12]
ld1.8h	{ v20 }, [x13]
bl	sum_lag2_above_neon
add	x12, x19, #164
ld1.8h	{ v22, v23 }, [x19], #32
ld1.8h	{ v24, v25 }, [x12]
addp.8h	v22, v22, v23
addp.8h	v23, v24, v25
add.8h	v22, v22, v23
srshr.8h	v0, v22, #2
dup.8b	v1, v30[12]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag2_y_left_start
_sum_uv_420_lag2_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
add	x12, x19, #164
ld1.8h	{ v22, v23 }, [x19], #32
ld1.8h	{ v24, v25 }, [x12]
addp.8h	v22, v22, v23
addp.8h	v23, v24, v25
add.8h	v22, v22, v23
srshr.8h	v0, v22, #2
dup.8b	v1, v30[12]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag2_y_mid_start
_sum_uv_420_lag2_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag2_above_neon
add	x12, x19, #164
ld1.8h	{ v22, v23 }, [x19], #32
ld1.8h	{ v24, v25 }, [x12]
addp.8h	v22, v22, v23
addp.8h	v23, v24, v25
add.8h	v22, v22, v23
srshr.8h	v0, v22, #2
dup.8b	v1, v30[12]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
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
ext.16b	v0, v0, v1, #14
st1.8h	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_sum_lag3_above_neon:
sub	x11, x0, #476
sub	x12, x0, #312
sub	x13, x0, #148
ld1.8h	{ v15 }, [x11]
ld1.8h	{ v18 }, [x12]
ld1.8h	{ v21 }, [x13]
dup.8b	v22, v29[0]
ext.16b	v8, v13, v14, #10
dup.8b	v23, v29[1]
ext.16b	v9, v13, v14, #12
sshll.8h	v22, v22, #0
dup.8b	v24, v29[2]
sshll.8h	v23, v23, #0
dup.8b	v25, v29[3]
ext.16b	v10, v13, v14, #14
sshll.8h	v24, v24, #0
dup.8b	v26, v29[4]
ext.16b	v11, v14, v15, #2
sshll.8h	v25, v25, #0
dup.8b	v27, v29[5]
ext.16b	v12, v14, v15, #4
sshll.8h	v26, v26, #0
dup.8b	v28, v29[6]
ext.16b	v13, v14, v15, #6
sshll.8h	v27, v27, #0
sshll.8h	v28, v28, #0
smull.4s	v4, v8, v22
smlal.4s	v4, v9, v23
smlal.4s	v4, v10, v24
smlal.4s	v4, v11, v26
smlal.4s	v4, v12, v27
smlal.4s	v4, v13, v28
smlal.4s	v4, v14, v25
smull2.4s	v5, v8, v22
smlal2.4s	v5, v9, v23
smlal2.4s	v5, v10, v24
smlal2.4s	v5, v11, v26
smlal2.4s	v5, v12, v27
smlal2.4s	v5, v13, v28
smlal2.4s	v5, v14, v25
dup.8b	v22, v29[7]
ext.16b	v8, v16, v17, #10
dup.8b	v23, v29[8]
ext.16b	v9, v16, v17, #12
sshll.8h	v22, v22, #0
dup.8b	v24, v29[9]
sshll.8h	v23, v23, #0
dup.8b	v25, v29[10]
ext.16b	v10, v16, v17, #14
sshll.8h	v24, v24, #0
dup.8b	v26, v29[11]
ext.16b	v11, v17, v18, #2
sshll.8h	v25, v25, #0
dup.8b	v27, v29[12]
ext.16b	v12, v17, v18, #4
sshll.8h	v26, v26, #0
dup.8b	v28, v29[13]
ext.16b	v13, v17, v18, #6
sshll.8h	v27, v27, #0
sshll.8h	v28, v28, #0
smlal.4s	v4, v8, v22
smlal.4s	v4, v9, v23
smlal.4s	v4, v10, v24
smlal.4s	v4, v11, v26
smlal.4s	v4, v12, v27
smlal.4s	v4, v13, v28
smlal.4s	v4, v17, v25
smlal2.4s	v5, v8, v22
smlal2.4s	v5, v9, v23
smlal2.4s	v5, v10, v24
smlal2.4s	v5, v11, v26
smlal2.4s	v5, v12, v27
smlal2.4s	v5, v13, v28
smlal2.4s	v5, v17, v25
dup.8b	v22, v29[14]
ext.16b	v8, v19, v20, #10
dup.8b	v23, v29[15]
ext.16b	v9, v19, v20, #12
sshll.8h	v22, v22, #0
dup.8b	v24, v30[0]
sshll.8h	v23, v23, #0
dup.8b	v25, v30[1]
ext.16b	v10, v19, v20, #14
sshll.8h	v24, v24, #0
dup.8b	v26, v30[2]
ext.16b	v11, v20, v21, #2
sshll.8h	v25, v25, #0
dup.8b	v27, v30[3]
ext.16b	v12, v20, v21, #4
sshll.8h	v26, v26, #0
dup.8b	v28, v30[4]
ext.16b	v13, v20, v21, #6
sshll.8h	v27, v27, #0
sshll.8h	v28, v28, #0
smlal.4s	v4, v8, v22
smlal.4s	v4, v9, v23
smlal.4s	v4, v10, v24
smlal.4s	v4, v11, v26
smlal.4s	v4, v12, v27
smlal.4s	v4, v13, v28
smlal.4s	v4, v20, v25
mov.16b	v16, v17
mov.16b	v17, v18
smlal2.4s	v5, v8, v22
smlal2.4s	v5, v9, v23
smlal2.4s	v5, v10, v24
smlal2.4s	v5, v11, v26
smlal2.4s	v5, v12, v27
smlal2.4s	v5, v13, v28
smlal2.4s	v5, v20, v25
mov.16b	v13, v14
mov.16b	v14, v15
mov.16b	v19, v20
mov.16b	v20, v21
ret
_sum_y_lag3_left_neon:
str	x30, [sp, #-16]!
sub	x11, x0, #492
sub	x12, x0, #328
sub	x13, x0, #164
ld1.8h	{ v14 }, [x11]
ld1.8h	{ v17 }, [x12]
ld1.8h	{ v20 }, [x13]
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
ext.16b	v4, v4, v4, #12
smov.h	w17, v0[5]
smov.h	w16, v0[6]
smov.h	w14, v0[7]
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
st1.8h	{ v0 }, [x0], #16
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
st1.8h	{ v0 }, [x0], #16
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
mov	w15, #3
bl	output_lag3_neon
ubfx	x15, x2, #6, #11
lsr	w2, w2, #1
add	x15, x3, x15, lsl #1
ld1.h	{ v1 }[0], [x15]
srshl.4h	v1, v1, v31
ext.16b	v0, v0, v1, #2
st1.8h	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_sum_uv_444_lag3_left_neon:
str	x30, [sp, #-16]!
sub	x11, x0, #492
sub	x12, x0, #328
sub	x13, x0, #164
ld1.8h	{ v14 }, [x11]
ld1.8h	{ v17 }, [x12]
ld1.8h	{ v20 }, [x13]
bl	sum_lag3_above_neon
ld1.8h	{ v0 }, [x19], #16
dup.8b	v1, v30[8]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag3_y_left_start
_sum_uv_444_lag3_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
ld1.8h	{ v0 }, [x19], #16
dup.8b	v1, v30[8]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag3_y_mid_start
_sum_uv_444_lag3_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
ld1.8h	{ v0 }, [x19], #16
dup.8b	v1, v30[8]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag3_y_right_start
_sum_uv_422_lag3_left_neon:
str	x30, [sp, #-16]!
sub	x11, x0, #492
sub	x12, x0, #328
sub	x13, x0, #164
ld1.8h	{ v14 }, [x11]
ld1.8h	{ v17 }, [x12]
ld1.8h	{ v20 }, [x13]
bl	sum_lag3_above_neon
ld1.8h	{ v22, v23 }, [x19], #32
addp.8h	v22, v22, v23
srshr.8h	v0, v22, #1
dup.8b	v1, v30[8]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag3_y_left_start
_sum_uv_422_lag3_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
ld1.8h	{ v22, v23 }, [x19], #32
addp.8h	v22, v22, v23
srshr.8h	v0, v22, #1
dup.8b	v1, v30[8]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag3_y_mid_start
_sum_uv_422_lag3_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
ld1.8h	{ v22, v23 }, [x19], #32
addp.8h	v22, v22, v23
srshr.8h	v0, v22, #1
dup.8b	v1, v30[8]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag3_uv_420_right_start
_sum_uv_420_lag3_left_neon:
str	x30, [sp, #-16]!
sub	x11, x0, #492
sub	x12, x0, #328
sub	x13, x0, #164
ld1.8h	{ v14 }, [x11]
ld1.8h	{ v17 }, [x12]
ld1.8h	{ v20 }, [x13]
bl	sum_lag3_above_neon
add	x12, x19, #164
ld1.8h	{ v22, v23 }, [x19], #32
ld1.8h	{ v24, v25 }, [x12]
addp.8h	v22, v22, v23
addp.8h	v23, v24, v25
add.8h	v22, v22, v23
srshr.8h	v0, v22, #2
dup.8b	v1, v30[8]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag3_y_left_start
_sum_uv_420_lag3_mid_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
add	x12, x19, #164
ld1.8h	{ v22, v23 }, [x19], #32
ld1.8h	{ v24, v25 }, [x12]
addp.8h	v22, v22, v23
addp.8h	v23, v24, v25
add.8h	v22, v22, v23
srshr.8h	v0, v22, #2
dup.8b	v1, v30[8]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
b	sum_lag3_y_mid_start
_sum_uv_420_lag3_right_neon:
str	x30, [sp, #-16]!
bl	sum_lag3_above_neon
add	x12, x19, #164
ld1.8h	{ v22, v23 }, [x19], #32
ld1.8h	{ v24, v25 }, [x12]
addp.8h	v22, v22, v23
addp.8h	v23, v24, v25
add.8h	v22, v22, v23
srshr.8h	v0, v22, #2
dup.8b	v1, v30[8]
sshll.8h	v1, v1, #0
smlal.4s	v4, v0, v1
smlal2.4s	v5, v0, v1
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
ext.16b	v0, v0, v1, #14
st1.8h	{ v0 }, [x0], #16
ldr	x30, [sp], #16
ret
_generate_grain_rows_neon:
str	x30, [sp, #-16]!
mov	w16, #80
bl	ltmp0
srshl.8h	v0, v0, v31
subs	w16, w16, #8
st1.8h	{ v0 }, [x0], #16
b.gt	generate_grain_rows_neon
bl	get_grain_2_neon
subs	w1, w1, #1
st1.s	{ v0 }[0], [x0], #4
b.gt	generate_grain_rows_neon
ldr	x30, [sp], #16
ret
_generate_grain_rows_44_neon:
str	x30, [sp, #-16]!
mov	w16, #40
bl	ltmp0
srshl.8h	v0, v0, v31
subs	w16, w16, #8
st1.8h	{ v0 }, [x0], #16
b.gt	generate_grain_rows_44_neon
bl	get_grain_4_neon
subs	w1, w1, #1
st1.4h	{ v0 }, [x0]
add	x0, x0, #84
b.gt	generate_grain_rows_44_neon
ldr	x30, [sp], #16
ret
_gen_grain_uv_444_lag0_neon:
str	x30, [sp, #-16]!
ld1.8h	{ v4 }, [x19], #16
_gen_grain_uv_lag0_8_start:
bl	ltmp0
srshl.8h	v0, v0, v31
_gen_grain_uv_lag0_8_add:
and.16b	v4, v4, v1
smull.4s	v2, v4, v27
smull2.4s	v3, v4, v27
srshl.4s	v2, v2, v28
srshl.4s	v3, v3, v28
sqxtn.4h	v2, v2
sqxtn2.8h	v2, v3
sqadd.8h	v2, v2, v0
smin.8h	v2, v2, v25
smax.8h	v2, v2, v26
st1.8h	{ v2 }, [x0], #16
ldr	x30, [sp], #16
ret
_gen_grain_uv_420_lag0_8_neon:
add	x12, x19, #164
str	x30, [sp, #-16]!
ld1.8h	{ v16, v17 }, [x19], #32
ld1.8h	{ v18, v19 }, [x12]
addp.8h	v16, v16, v17
addp.8h	v17, v18, v19
add.8h	v16, v16, v17
srshr.8h	v4, v16, #2
b	gen_grain_uv_lag0_8_start
_gen_grain_uv_422_lag0_8_neon:
str	x30, [sp, #-16]!
ld1.8h	{ v16, v17 }, [x19], #32
addp.8h	v16, v16, v17
srshr.8h	v4, v16, #1
b	gen_grain_uv_lag0_8_start
_gen_grain_uv_420_lag0_4_neon:
add	x12, x19, #164
str	x30, [sp, #-16]!
ld1.4h	{ v16, v17 }, [x19]
ld1.4h	{ v18, v19 }, [x12]
add	x19, x19, #32
addp.4h	v16, v16, v17
addp.4h	v17, v18, v19
add.4h	v16, v16, v17
srshr.4h	v4, v16, #2
bl	get_grain_4_neon
b	gen_grain_uv_lag0_8_add
_gen_grain_uv_422_lag0_4_neon:
str	x30, [sp, #-16]!
ld1.4h	{ v16, v17 }, [x19]
add	x19, x19, #32
addp.4h	v16, v16, v17
srshr.4h	v4, v16, #1
bl	get_grain_4_neon
b	gen_grain_uv_lag0_8_add
_generate_grain_y_16bpc_neon:
stp	x30, x19, [sp, #-96]!
clz	w15, w2
adrp	x3, generate_grain_y_16bpc_neon
add	x3, x3, #0
sub	w15, w15, #24
ldr	w2, [x1]
ldr	w9, [x1, #184]
add	x4, x1, #96
add	w9, w9, w15
adr	x16, #432
ldr	w17, [x1, #92]
add	w9, w9, #4
ldrh	w17, [x16, w17, uxtw #1]
dup.8h	v31, w9
sub	x16, x16, w17, uxtw
neg.8h	v31, v31
ldr	w7, [x1, #176]
neg	w15, w15
mov	w8, #1
mov	w10, #1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #128
lsl	w5, w5, w15
neg	w6, w5
sub	w5, w5, #1
br	x16
mov	w1, #73
bl	generate_grain_rows_neon
ldp	x30, x19, [sp], #96
ret
ld1r.8b	{ v27 }, [x4], #1
ld1r.8b	{ v28 }, [x4], #1
ld1r.8b	{ v29 }, [x4]
ldrsb	w4, [x4, #1]
mov	w1, #3
bl	generate_grain_rows_neon
sshll.8h	v27, v27, #0
sshll.8h	v28, v28, #0
sshll.8h	v29, v29, #0
mov	w1, #70
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
mov.8b	v16, v0
subs	w1, w1, #1
st1.s	{ v16 }[0], [x0], #4
b.gt	generate_grain_y_16bpc_neon
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
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_mid_neon
bl	sum_y_lag2_right_neon
bl	get_grain_2_neon
mov.8b	v16, v0
subs	w1, w1, #1
st1.s	{ v16 }[0], [x0], #4
b.gt	generate_grain_y_16bpc_neon
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
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_mid_neon
bl	sum_y_lag3_right_neon
bl	get_grain_2_neon
mov.8b	v16, v0
subs	w1, w1, #1
st1.s	{ v16 }[0], [x0], #4
b.gt	generate_grain_y_16bpc_neon
ldp	x20, x21, [sp, #80]
ldp	d14, d15, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldp	x30, x19, [sp], #96
ret
<unknown>
<unknown>
_generate_grain_uv_444_16bpc_neon:
stp	x30, x19, [sp, #-96]!
mov	w13, w3
mov	w14, #28
add	x19, x1, #492
mov	x1, x2
mul	w13, w13, w14
clz	w15, w4
adrp	x3, generate_grain_uv_444_16bpc_neon
add	x3, x3, #0
sub	w15, w15, #24
ldr	w2, [x1]
ldr	w9, [x1, #184]
add	x4, x1, #120
add	w9, w9, w15
adr	x16, #600
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
neg	w15, w15
mov	w8, #1
mov	w10, #1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #128
lsl	w5, w5, w15
neg	w6, w5
sub	w5, w5, #1
eor	w2, w2, w11
br	x16
dup.4s	v28, w7
ld1r.8b	{ v27 }, [x4]
movi.16b	v0, #0
movi.16b	v1, #255
dup.8h	v25, w5
dup.8h	v26, w6
ext.16b	v29, v0, v1, #10
ext.16b	v30, v1, v0, #2
neg.4s	v28, v28
sshll.8h	v27, v27, #0
mov	w1, #3
bl	generate_grain_rows_neon
mov	w1, #70
mov.16b	v1, v29
bl	gen_grain_uv_444_lag0_neon
movi.16b	v1, #255
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
bl	gen_grain_uv_444_lag0_neon
mov.16b	v1, v30
bl	gen_grain_uv_444_lag0_neon
bl	get_grain_2_neon
mov.8b	v16, v0
subs	w1, w1, #1
add	x19, x19, #4
st1.s	{ v16 }[0], [x0], #4
b.gt	generate_grain_uv_444_16bpc_neon
ldp	x30, x19, [sp], #96
ret
ld1r.8b	{ v27 }, [x4], #1
ld1r.8b	{ v28 }, [x4], #1
ld1r.8b	{ v29 }, [x4]
add	x4, x4, #2
mov	w1, #3
ld1r.8b	{ v30 }, [x4]
ldursb	w4, [x4, #-1]
bl	generate_grain_rows_neon
sshll.8h	v27, v27, #0
sshll.8h	v28, v28, #0
sshll.8h	v29, v29, #0
sshll.8h	v30, v30, #0
mov	w1, #70
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
mov.8b	v16, v0
subs	w1, w1, #1
add	x19, x19, #4
st1.s	{ v16 }[0], [x0], #4
b.gt	generate_grain_uv_444_16bpc_neon
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
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_mid_neon
bl	sum_uv_444_lag2_right_neon
bl	get_grain_2_neon
mov.8b	v16, v0
subs	w1, w1, #1
add	x19, x19, #4
st1.s	{ v16 }[0], [x0], #4
b.gt	generate_grain_uv_444_16bpc_neon
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
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_mid_neon
bl	sum_uv_444_lag3_right_neon
bl	get_grain_2_neon
mov.8b	v16, v0
subs	w1, w1, #1
add	x19, x19, #4
st1.s	{ v16 }[0], [x0], #4
b.gt	generate_grain_uv_444_16bpc_neon
ldp	x20, x21, [sp, #80]
ldp	d14, d15, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldp	x30, x19, [sp], #96
ret
<unknown>
<unknown>
_generate_grain_uv_420_16bpc_neon:
stp	x30, x19, [sp, #-96]!
mov	w13, w3
mov	w14, #28
add	x19, x1, #486
mov	x1, x2
mul	w13, w13, w14
clz	w15, w4
adrp	x3, generate_grain_uv_420_16bpc_neon
add	x3, x3, #0
sub	w15, w15, #24
ldr	w2, [x1]
ldr	w9, [x1, #184]
add	x4, x1, #120
add	w9, w9, w15
adr	x16, #508
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
neg	w15, w15
mov	w8, #1
mov	w10, #1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #128
lsl	w5, w5, w15
neg	w6, w5
sub	w5, w5, #1
eor	w2, w2, w11
br	x16
dup.4s	v28, w7
ld1r.8b	{ v27 }, [x4]
movi.16b	v0, #0
movi.16b	v1, #255
dup.8h	v25, w5
dup.8h	v26, w6
ext.16b	v29, v0, v1, #10
ext.16b	v30, v1, v0, #14
neg.4s	v28, v28
sshll.8h	v27, v27, #0
mov	w1, #3
bl	generate_grain_rows_44_neon
mov	w1, #35
mov.16b	v1, v29
bl	gen_grain_uv_420_lag0_8_neon
movi.16b	v1, #255
bl	gen_grain_uv_420_lag0_8_neon
bl	gen_grain_uv_420_lag0_8_neon
bl	gen_grain_uv_420_lag0_8_neon
bl	gen_grain_uv_420_lag0_8_neon
mov.16b	v1, v30
bl	gen_grain_uv_420_lag0_4_neon
subs	w1, w1, #1
add	x19, x19, #136
add	x0, x0, #68
b.gt	generate_grain_uv_420_16bpc_neon
ldp	x30, x19, [sp], #96
ret
ld1r.8b	{ v27 }, [x4], #1
ld1r.8b	{ v28 }, [x4], #1
ld1r.8b	{ v29 }, [x4]
add	x4, x4, #2
mov	w1, #3
ld1r.8b	{ v30 }, [x4]
ldursb	w4, [x4, #-1]
bl	generate_grain_rows_44_neon
sshll.8h	v27, v27, #0
sshll.8h	v28, v28, #0
sshll.8h	v29, v29, #0
sshll.8h	v30, v30, #0
mov	w1, #35
bl	sum_uv_420_lag1_left_neon
bl	sum_uv_420_lag1_mid_neon
bl	sum_uv_420_lag1_mid_neon
bl	sum_uv_420_lag1_mid_neon
bl	sum_uv_420_lag1_mid_neon
bl	sum_uv_420_lag1_right_neon
subs	w1, w1, #1
add	x19, x19, #136
add	x0, x0, #68
b.gt	generate_grain_uv_420_16bpc_neon
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
bl	sum_uv_420_lag2_mid_neon
bl	sum_uv_420_lag2_mid_neon
bl	sum_uv_420_lag2_mid_neon
bl	sum_uv_420_lag2_right_neon
subs	w1, w1, #1
add	x19, x19, #136
add	x0, x0, #68
b.gt	generate_grain_uv_420_16bpc_neon
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
bl	sum_uv_420_lag3_mid_neon
bl	sum_uv_420_lag3_mid_neon
bl	sum_uv_420_lag3_mid_neon
bl	sum_uv_420_lag3_right_neon
subs	w1, w1, #1
add	x19, x19, #136
add	x0, x0, #68
b.gt	generate_grain_uv_420_16bpc_neon
ldp	x20, x21, [sp, #80]
ldp	d14, d15, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldp	x30, x19, [sp], #96
ret
<unknown>
<unknown>
_generate_grain_uv_422_16bpc_neon:
stp	x30, x19, [sp, #-96]!
mov	w13, w3
mov	w14, #28
add	x19, x1, #486
mov	x1, x2
mul	w13, w13, w14
clz	w15, w4
adrp	x3, generate_grain_uv_422_16bpc_neon
add	x3, x3, #0
sub	w15, w15, #24
ldr	w2, [x1]
ldr	w9, [x1, #184]
add	x4, x1, #120
add	w9, w9, w15
adr	x16, #508
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
neg	w15, w15
mov	w8, #1
mov	w10, #1
lsl	w8, w8, w7
lsl	w10, w10, w9
lsr	w8, w8, #1
lsr	w10, w10, #1
mov	w5, #128
lsl	w5, w5, w15
neg	w6, w5
sub	w5, w5, #1
eor	w2, w2, w11
br	x16
dup.4s	v28, w7
ld1r.8b	{ v27 }, [x4]
movi.16b	v0, #0
movi.16b	v1, #255
dup.8h	v25, w5
dup.8h	v26, w6
ext.16b	v29, v0, v1, #10
ext.16b	v30, v1, v0, #14
neg.4s	v28, v28
sshll.8h	v27, v27, #0
mov	w1, #3
bl	generate_grain_rows_44_neon
mov	w1, #70
mov.16b	v1, v29
bl	gen_grain_uv_422_lag0_8_neon
movi.16b	v1, #255
bl	gen_grain_uv_422_lag0_8_neon
bl	gen_grain_uv_422_lag0_8_neon
bl	gen_grain_uv_422_lag0_8_neon
bl	gen_grain_uv_422_lag0_8_neon
mov.16b	v1, v30
bl	gen_grain_uv_422_lag0_4_neon
subs	w1, w1, #1
sub	x19, x19, #28
add	x0, x0, #68
b.gt	generate_grain_uv_422_16bpc_neon
ldp	x30, x19, [sp], #96
ret
ld1r.8b	{ v27 }, [x4], #1
ld1r.8b	{ v28 }, [x4], #1
ld1r.8b	{ v29 }, [x4]
add	x4, x4, #2
mov	w1, #3
ld1r.8b	{ v30 }, [x4]
ldursb	w4, [x4, #-1]
bl	generate_grain_rows_44_neon
sshll.8h	v27, v27, #0
sshll.8h	v28, v28, #0
sshll.8h	v29, v29, #0
sshll.8h	v30, v30, #0
mov	w1, #70
bl	sum_uv_422_lag1_left_neon
bl	sum_uv_422_lag1_mid_neon
bl	sum_uv_422_lag1_mid_neon
bl	sum_uv_422_lag1_mid_neon
bl	sum_uv_422_lag1_mid_neon
bl	sum_uv_422_lag1_right_neon
subs	w1, w1, #1
sub	x19, x19, #28
add	x0, x0, #68
b.gt	generate_grain_uv_422_16bpc_neon
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
bl	sum_uv_422_lag2_mid_neon
bl	sum_uv_422_lag2_mid_neon
bl	sum_uv_422_lag2_mid_neon
bl	sum_uv_422_lag2_right_neon
subs	w1, w1, #1
sub	x19, x19, #28
add	x0, x0, #68
b.gt	generate_grain_uv_422_16bpc_neon
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
bl	sum_uv_422_lag3_mid_neon
bl	sum_uv_422_lag3_mid_neon
bl	sum_uv_422_lag3_mid_neon
bl	sum_uv_422_lag3_right_neon
subs	w1, w1, #1
sub	x19, x19, #28
add	x0, x0, #68
b.gt	generate_grain_uv_422_16bpc_neon
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
umov.h	w14, v0[0]
umov.h	w15, v2[1]
umov.h	w16, v0[2]
add	x14, x14, x3
umov.h	w17, v2[3]
add	x15, x15, x3
ld1.b	{ v6 }[0], [x14]
umov.h	w14, v0[4]
add	x16, x16, x3
ld1.b	{ v7 }[1], [x15]
umov.h	w15, v2[5]
add	x17, x17, x3
ld1.b	{ v6 }[2], [x16]
umov.h	w16, v0[6]
add	x14, x14, x3
ld1.b	{ v7 }[3], [x17]
umov.h	w17, v2[7]
add	x15, x15, x3
ld1.b	{ v6 }[4], [x14]
add	x16, x16, x3
ld1.b	{ v7 }[5], [x15]
add	x17, x17, x3
ld1.b	{ v6 }[6], [x16]
ld1.b	{ v7 }[7], [x17]
umov.h	w14, v2[0]
umov.h	w15, v0[1]
umov.h	w16, v2[2]
add	x14, x14, x3
umov.h	w17, v0[3]
add	x15, x15, x3
ld1.b	{ v7 }[0], [x14]
umov.h	w14, v2[4]
add	x16, x16, x3
ld1.b	{ v6 }[1], [x15]
umov.h	w15, v0[5]
add	x17, x17, x3
ld1.b	{ v7 }[2], [x16]
umov.h	w16, v2[6]
add	x14, x14, x3
ld1.b	{ v6 }[3], [x17]
umov.h	w17, v0[7]
add	x15, x15, x3
ld1.b	{ v7 }[4], [x14]
add	x16, x16, x3
ld1.b	{ v6 }[5], [x15]
add	x17, x17, x3
ld1.b	{ v7 }[6], [x16]
ld1.b	{ v6 }[7], [x17]
umov.h	w14, v1[0]
umov.h	w15, v3[1]
umov.h	w16, v1[2]
add	x14, x14, x3
umov.h	w17, v3[3]
add	x15, x15, x3
ld1.b	{ v6 }[8], [x14]
umov.h	w14, v1[4]
add	x16, x16, x3
ld1.b	{ v7 }[9], [x15]
umov.h	w15, v3[5]
add	x17, x17, x3
ld1.b	{ v6 }[10], [x16]
umov.h	w16, v1[6]
add	x14, x14, x3
ld1.b	{ v7 }[11], [x17]
umov.h	w17, v3[7]
add	x15, x15, x3
ld1.b	{ v6 }[12], [x14]
add	x16, x16, x3
ld1.b	{ v7 }[13], [x15]
add	x17, x17, x3
ld1.b	{ v6 }[14], [x16]
ld1.b	{ v7 }[15], [x17]
umov.h	w14, v3[0]
umov.h	w15, v1[1]
umov.h	w16, v3[2]
add	x14, x14, x3
umov.h	w17, v1[3]
add	x15, x15, x3
ld1.b	{ v7 }[8], [x14]
umov.h	w14, v3[4]
add	x16, x16, x3
ld1.b	{ v6 }[9], [x15]
umov.h	w15, v1[5]
add	x17, x17, x3
ld1.b	{ v7 }[10], [x16]
umov.h	w16, v3[6]
add	x14, x14, x3
ld1.b	{ v6 }[11], [x17]
umov.h	w17, v1[7]
add	x15, x15, x3
ld1.b	{ v7 }[12], [x14]
add	x16, x16, x3
ld1.b	{ v6 }[13], [x15]
add	x17, x17, x3
ld1.b	{ v7 }[14], [x16]
ld1.b	{ v6 }[15], [x17]
ret
_gather16_neon:
umov.h	w14, v0[0]
umov.h	w15, v1[1]
umov.h	w16, v0[2]
add	x14, x14, x3
umov.h	w17, v1[3]
add	x15, x15, x3
ld1.b	{ v6 }[0], [x14]
umov.h	w14, v0[4]
add	x16, x16, x3
ld1.b	{ v7 }[1], [x15]
umov.h	w15, v1[5]
add	x17, x17, x3
ld1.b	{ v6 }[2], [x16]
umov.h	w16, v0[6]
add	x14, x14, x3
ld1.b	{ v7 }[3], [x17]
umov.h	w17, v1[7]
add	x15, x15, x3
ld1.b	{ v6 }[4], [x14]
add	x16, x16, x3
ld1.b	{ v7 }[5], [x15]
add	x17, x17, x3
ld1.b	{ v6 }[6], [x16]
ld1.b	{ v7 }[7], [x17]
umov.h	w14, v1[0]
umov.h	w15, v0[1]
umov.h	w16, v1[2]
add	x14, x14, x3
umov.h	w17, v0[3]
add	x15, x15, x3
ld1.b	{ v7 }[0], [x14]
umov.h	w14, v1[4]
add	x16, x16, x3
ld1.b	{ v6 }[1], [x15]
umov.h	w15, v0[5]
add	x17, x17, x3
ld1.b	{ v7 }[2], [x16]
umov.h	w16, v1[6]
add	x14, x14, x3
ld1.b	{ v6 }[3], [x17]
umov.h	w17, v0[7]
add	x15, x15, x3
ld1.b	{ v7 }[4], [x14]
add	x16, x16, x3
ld1.b	{ v6 }[5], [x15]
add	x17, x17, x3
ld1.b	{ v7 }[6], [x16]
ld1.b	{ v6 }[7], [x17]
mov.d	v6[1], v7[0]
ret
_fgy_32x32_16bpc_neon:
str	x30, [sp, #-80]!
stp	d8, d9, [sp, #16]
stp	d10, d11, [sp, #32]
stp	d12, d13, [sp, #48]
str	d14, [sp, #64]
eor	w4, w4, #0xf
ldr	w11, [x6, #8]
ldr	w13, [x6, #4]
ldr	w15, [x6, #12]
ldr	w10, [sp, #96]
ldr	w6, [x6]
dup.8h	v26, w10
clz	w10, w10
ldr	w8, [sp, #80]
sub	w10, w10, #24
mov	x9, #164
neg	w10, w10
dup.8h	v29, w4
dup.8h	v27, w10
adrp	x16, fgy_32x32_16bpc_neon
add	x16, x16, #0
cbz	w8, fgy_32x32_16bpc_neon
movi.8h	v30, #16
movi.8h	v31, #235
sshl.8h	v30, v30, v27
sshl.8h	v31, v31, v27
b	fgy_32x32_16bpc_neon
movi.8h	v30, #0
mov.16b	v31, v26
ushr.8h	v26, v26, #1
mvn.16b	v25, v26
ld1.4h	{ v27, v28 }, [x16]
add	x5, x5, #18
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
ldr	w11, [sp, #88]
adr	x13, #1092
add	x4, x12, #64
add	x6, x14, x9, lsl #5
tst	w11, #0x1
ldrh	w11, [x13, w11, uxtw #1]
add	x8, x16, x9, lsl #5
add	x8, x8, #64
sub	x11, x13, w11, uxtw
b.eq	fgy_32x32_16bpc_neon
dup.8h	v8, v27[0]
dup.8h	v9, v27[1]
mov	w10, w7
mov	w7, #2
br	x11
_fgy_loop_neon:
ld1.8h	{ v0, v1, v2, v3 }, [x1], x2
mvni.8h	v4, #240, lsl #8
ld1.8h	{ v16, v17, v18, v19 }, [x5], x9
and.16b	v0, v0, v4
and.16b	v1, v1, v4
and.16b	v2, v2, v4
and.16b	v3, v3, v4
bl	gather32_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
ushl.8h	v6, v6, v29
ushl.8h	v7, v7, v29
sqrdmulh.8h	v20, v16, v4
sqrdmulh.8h	v21, v17, v5
sqrdmulh.8h	v22, v18, v6
sqrdmulh.8h	v23, v19, v7
usqadd.8h	v0, v20
usqadd.8h	v1, v21
usqadd.8h	v2, v22
usqadd.8h	v3, v23
umax.8h	v0, v0, v30
umax.8h	v1, v1, v30
umax.8h	v2, v2, v30
umax.8h	v3, v3, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w7, w7, #1
st1.8h	{ v0, v1, v2, v3 }, [x0], x2
b.gt	fgy_loop_neon
ldr	d14, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldr	x30, [sp], #80
ret
ld1.8h	{ v0, v1, v2, v3 }, [x1], x2
ld1.8h	{ v21, v22, v23, v24 }, [x6], x9
mvni.8h	v4, #240, lsl #8
ld1.8h	{ v16, v17, v18, v19 }, [x5], x9
and.16b	v0, v0, v4
and.16b	v1, v1, v4
and.16b	v2, v2, v4
and.16b	v3, v3, v4
bl	gather32_neon
smull.4s	v10, v16, v9
smull2.4s	v11, v16, v9
smull.4s	v12, v17, v9
smull2.4s	v13, v17, v9
smull.4s	v16, v18, v9
smull2.4s	v17, v18, v9
smull.4s	v18, v19, v9
smull2.4s	v19, v19, v9
smlal.4s	v10, v21, v8
smlal2.4s	v11, v21, v8
smlal.4s	v12, v22, v8
smlal2.4s	v13, v22, v8
smlal.4s	v16, v23, v8
smlal2.4s	v17, v23, v8
smlal.4s	v18, v24, v8
smlal2.4s	v19, v24, v8
sqrshrn.4h	v10, v10, #5
sqrshrn2.8h	v10, v11, #5
sqrshrn.4h	v11, v12, #5
sqrshrn2.8h	v11, v13, #5
sqrshrn.4h	v12, v16, #5
sqrshrn2.8h	v12, v17, #5
sqrshrn.4h	v13, v18, #5
sqrshrn2.8h	v13, v19, #5
smin.8h	v16, v10, v26
smin.8h	v17, v11, v26
smin.8h	v18, v12, v26
smin.8h	v19, v13, v26
smax.8h	v16, v16, v25
smax.8h	v17, v17, v25
smax.8h	v18, v18, v25
smax.8h	v19, v19, v25
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
ushl.8h	v6, v6, v29
ushl.8h	v7, v7, v29
sqrdmulh.8h	v20, v16, v4
sqrdmulh.8h	v21, v17, v5
sqrdmulh.8h	v22, v18, v6
sqrdmulh.8h	v23, v19, v7
usqadd.8h	v0, v20
usqadd.8h	v1, v21
usqadd.8h	v2, v22
usqadd.8h	v3, v23
umax.8h	v0, v0, v30
umax.8h	v1, v1, v30
umax.8h	v2, v2, v30
umax.8h	v3, v3, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w7, w7, #1
dup.8h	v8, v28[0]
dup.8h	v9, v28[1]
st1.8h	{ v0, v1, v2, v3 }, [x0], x2
b.gt	fgy_loop_neon
cmp	w10, #2
sub	w7, w10, #2
b.gt	fgy_loop_neon
ldr	d14, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldr	x30, [sp], #80
ret
ld1.8h	{ v0, v1, v2, v3 }, [x1], x2
ld1.4h	{ v20 }, [x4], x9
mvni.8h	v4, #240, lsl #8
ld1.8h	{ v16, v17, v18, v19 }, [x5], x9
and.16b	v0, v0, v4
and.16b	v1, v1, v4
and.16b	v2, v2, v4
and.16b	v3, v3, v4
bl	gather32_neon
smull.4s	v20, v20, v27
smlal.4s	v20, v16, v28
ushll.8h	v4, v6, #0
sqrshrn.4h	v20, v20, #5
ushll2.8h	v5, v6, #0
smin.4h	v20, v20, v26
ushll.8h	v6, v7, #0
smax.4h	v20, v20, v25
ushll2.8h	v7, v7, #0
mov.d	v16[0], v20[0]
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
ushl.8h	v6, v6, v29
ushl.8h	v7, v7, v29
sqrdmulh.8h	v20, v16, v4
sqrdmulh.8h	v21, v17, v5
sqrdmulh.8h	v22, v18, v6
sqrdmulh.8h	v23, v19, v7
usqadd.8h	v0, v20
usqadd.8h	v1, v21
usqadd.8h	v2, v22
usqadd.8h	v3, v23
umax.8h	v0, v0, v30
umax.8h	v1, v1, v30
umax.8h	v2, v2, v30
umax.8h	v3, v3, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w7, w7, #1
st1.8h	{ v0, v1, v2, v3 }, [x0], x2
b.gt	fgy_loop_neon
ldr	d14, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldr	x30, [sp], #80
ret
ld1.8h	{ v0, v1, v2, v3 }, [x1], x2
ld1.4h	{ v20 }, [x4], x9
ld1.8h	{ v21, v22, v23, v24 }, [x6], x9
ld1.4h	{ v14 }, [x8], x9
mvni.8h	v4, #240, lsl #8
ld1.8h	{ v16, v17, v18, v19 }, [x5], x9
and.16b	v0, v0, v4
and.16b	v1, v1, v4
and.16b	v2, v2, v4
and.16b	v3, v3, v4
bl	gather32_neon
smull.4s	v20, v20, v27
smlal.4s	v20, v16, v28
smull.4s	v14, v14, v27
smlal.4s	v14, v21, v28
sqrshrn.4h	v20, v20, #5
sqrshrn.4h	v14, v14, #5
smin.4h	v20, v20, v26
smin.4h	v14, v14, v26
smax.4h	v20, v20, v25
smax.4h	v14, v14, v25
smull.4s	v10, v20, v9
smull2.4s	v11, v16, v9
smull.4s	v12, v17, v9
smull2.4s	v13, v17, v9
smull.4s	v16, v18, v9
smull2.4s	v17, v18, v9
smull.4s	v18, v19, v9
smull2.4s	v19, v19, v9
smlal.4s	v10, v14, v8
smlal2.4s	v11, v21, v8
smlal.4s	v12, v22, v8
smlal2.4s	v13, v22, v8
smlal.4s	v16, v23, v8
smlal2.4s	v17, v23, v8
smlal.4s	v18, v24, v8
smlal2.4s	v19, v24, v8
sqrshrn.4h	v10, v10, #5
sqrshrn2.8h	v10, v11, #5
sqrshrn.4h	v11, v12, #5
sqrshrn2.8h	v11, v13, #5
sqrshrn.4h	v12, v16, #5
sqrshrn2.8h	v12, v17, #5
sqrshrn.4h	v13, v18, #5
sqrshrn2.8h	v13, v19, #5
smin.8h	v16, v10, v26
smin.8h	v17, v11, v26
smin.8h	v18, v12, v26
smin.8h	v19, v13, v26
smax.8h	v16, v16, v25
smax.8h	v17, v17, v25
smax.8h	v18, v18, v25
smax.8h	v19, v19, v25
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
ushl.8h	v6, v6, v29
ushl.8h	v7, v7, v29
sqrdmulh.8h	v20, v16, v4
sqrdmulh.8h	v21, v17, v5
sqrdmulh.8h	v22, v18, v6
sqrdmulh.8h	v23, v19, v7
usqadd.8h	v0, v20
usqadd.8h	v1, v21
usqadd.8h	v2, v22
usqadd.8h	v3, v23
umax.8h	v0, v0, v30
umax.8h	v1, v1, v30
umax.8h	v2, v2, v30
umax.8h	v3, v3, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w7, w7, #1
dup.8h	v8, v28[0]
dup.8h	v9, v28[1]
st1.8h	{ v0, v1, v2, v3 }, [x0], x2
b.gt	fgy_loop_neon
cmp	w10, #2
sub	w7, w10, #2
b.gt	fgy_loop_neon
ldr	d14, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldr	x30, [sp], #80
ret
<unknown>
<unknown>
_fguv_32x32_420_16bpc_neon:
str	x30, [sp, #-80]!
stp	d8, d9, [sp, #16]
stp	d10, d11, [sp, #32]
stp	d12, d13, [sp, #48]
stp	d14, d15, [sp, #64]
ldp	x8, x9, [sp, #80]
ldp	x10, x11, [sp, #96]
ldr	w16, [sp, #120]
ldr	w13, [x4, #88]
ldr	w12, [x4, #216]
dup.8h	v23, w16
clz	w16, w16
eor	w13, w13, #0xf
sub	w16, w16, #24
add	x10, x4, x10, lsl #2
add	x14, x10, #196
add	x15, x10, #188
add	x10, x10, #204
neg	w16, w16
ld1r.8h	{ v8 }, [x14]
ld1r.8h	{ v24 }, [x10]
ld1r.8h	{ v9 }, [x15]
dup.8h	v29, w13
dup.8h	v27, w16
cbz	w12, fguv_32x32_420_16bpc_neon
movi.8h	v30, #16
movi.8h	v31, #240
sshl.8h	v30, v30, v27
sshl.8h	v31, v31, v27
cbz	w11, fguv_32x32_420_16bpc_neon
movi.8h	v31, #235
sshl.8h	v31, v31, v27
b	fguv_32x32_420_16bpc_neon
movi.8h	v30, #0
mov.16b	v31, v23
ushr.8h	v15, v23, #1
sshl.8h	v24, v24, v27
mvn.16b	v14, v15
ldr	w12, [x8, #8]
ldr	w14, [x8, #4]
ldr	w16, [x8, #12]
ldr	w8, [x8]
mov	x10, #164
add	x5, x5, #12
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
add	x4, x13, #32
add	x8, x15, x10, lsl #4
add	x11, x17, x10, lsl #4
add	x11, x11, #32
ldr	w13, [sp, #112]
adrp	x16, fguv_32x32_420_16bpc_neon
add	x16, x16, #0
adr	x14, #4896
ld1.4h	{ v27, v28 }, [x16]
tst	w13, #0x1
ldrh	w13, [x14, w13, uxtw #1]
b.eq	fguv_32x32_420_16bpc_neon
sub	w12, w9, #1
mov	w9, #1
sub	x13, x14, w13, uxtw
movi.8h	v25, #23
movi.8h	v26, #22
add	x7, x7, x7
br	x13
_fguv_32x32_422_16bpc_neon:
str	x30, [sp, #-80]!
stp	d8, d9, [sp, #16]
stp	d10, d11, [sp, #32]
stp	d12, d13, [sp, #48]
stp	d14, d15, [sp, #64]
ldp	x8, x9, [sp, #80]
ldp	x10, x11, [sp, #96]
ldr	w16, [sp, #120]
ldr	w13, [x4, #88]
ldr	w12, [x4, #216]
dup.8h	v23, w16
clz	w16, w16
eor	w13, w13, #0xf
sub	w16, w16, #24
add	x10, x4, x10, lsl #2
add	x14, x10, #196
add	x15, x10, #188
add	x10, x10, #204
neg	w16, w16
ld1r.8h	{ v8 }, [x14]
ld1r.8h	{ v24 }, [x10]
ld1r.8h	{ v9 }, [x15]
dup.8h	v29, w13
dup.8h	v27, w16
cbz	w12, fguv_32x32_422_16bpc_neon
movi.8h	v30, #16
movi.8h	v31, #240
sshl.8h	v30, v30, v27
sshl.8h	v31, v31, v27
cbz	w11, fguv_32x32_422_16bpc_neon
movi.8h	v31, #235
sshl.8h	v31, v31, v27
b	fguv_32x32_422_16bpc_neon
movi.8h	v30, #0
mov.16b	v31, v23
ushr.8h	v15, v23, #1
sshl.8h	v24, v24, v27
mvn.16b	v14, v15
ldr	w12, [x8, #8]
ldr	w14, [x8, #4]
ldr	w16, [x8, #12]
ldr	w8, [x8]
mov	x10, #164
add	x5, x5, #12
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
add	x4, x13, #32
add	x8, x15, x10, lsl #5
add	x11, x17, x10, lsl #5
add	x11, x11, #32
ldr	w13, [sp, #112]
adrp	x16, fguv_32x32_422_16bpc_neon
add	x16, x16, #0
adr	x14, #4556
ld1.4h	{ v27, v28 }, [x16]
tst	w13, #0x1
ldrh	w13, [x14, w13, uxtw #1]
b.eq	fguv_32x32_422_16bpc_neon
sub	w12, w9, #2
mov	w9, #2
sub	x13, x14, w13, uxtw
movi.8h	v25, #27
movi.8h	v26, #17
br	x13
_fguv_32x32_444_16bpc_neon:
str	x30, [sp, #-80]!
stp	d8, d9, [sp, #16]
stp	d10, d11, [sp, #32]
stp	d12, d13, [sp, #48]
stp	d14, d15, [sp, #64]
ldp	x8, x9, [sp, #80]
ldp	x10, x11, [sp, #96]
ldr	w16, [sp, #120]
ldr	w13, [x4, #88]
ldr	w12, [x4, #216]
dup.8h	v23, w16
clz	w16, w16
eor	w13, w13, #0xf
sub	w16, w16, #24
add	x10, x4, x10, lsl #2
add	x14, x10, #196
add	x15, x10, #188
add	x10, x10, #204
neg	w16, w16
ld1r.8h	{ v8 }, [x14]
ld1r.8h	{ v24 }, [x10]
ld1r.8h	{ v9 }, [x15]
dup.8h	v29, w13
dup.8h	v27, w16
cbz	w12, fguv_32x32_444_16bpc_neon
movi.8h	v30, #16
movi.8h	v31, #240
sshl.8h	v30, v30, v27
sshl.8h	v31, v31, v27
cbz	w11, fguv_32x32_444_16bpc_neon
movi.8h	v31, #235
sshl.8h	v31, v31, v27
b	fguv_32x32_444_16bpc_neon
movi.8h	v30, #0
mov.16b	v31, v23
ushr.8h	v15, v23, #1
sshl.8h	v24, v24, v27
mvn.16b	v14, v15
ldr	w12, [x8, #8]
ldr	w14, [x8, #4]
ldr	w16, [x8, #12]
ldr	w8, [x8]
mov	x10, #164
add	x5, x5, #18
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
add	x4, x13, #64
add	x8, x15, x10, lsl #5
add	x11, x17, x10, lsl #5
add	x11, x11, #64
ldr	w13, [sp, #112]
adrp	x16, fguv_32x32_444_16bpc_neon
add	x16, x16, #0
adr	x14, #2524
ld1.4h	{ v27, v28 }, [x16]
tst	w13, #0x1
ldrh	w13, [x14, w13, uxtw #1]
b.eq	fguv_32x32_444_16bpc_neon
sub	w12, w9, #2
mov	w9, #2
sub	x13, x14, w13, uxtw
movi.8h	v25, #27
movi.8h	v26, #17
br	x13
_fguv_loop_sx0_neon:
ld1.8h	{ v16, v17, v18, v19 }, [x5], x10
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
ld1.8h	{ v10, v11, v12, v13 }, [x1], x2
smull.4s	v4, v0, v8
smull2.4s	v5, v0, v8
smull.4s	v6, v1, v8
smull2.4s	v7, v1, v8
smull.4s	v0, v2, v8
smull2.4s	v1, v2, v8
smull.4s	v2, v3, v8
smull2.4s	v3, v3, v8
smlal.4s	v4, v10, v9
smlal2.4s	v5, v10, v9
smlal.4s	v6, v11, v9
smlal2.4s	v7, v11, v9
smlal.4s	v0, v12, v9
smlal2.4s	v1, v12, v9
smlal.4s	v2, v13, v9
smlal2.4s	v3, v13, v9
shrn.4h	v4, v4, #6
shrn2.8h	v4, v5, #6
shrn.4h	v5, v6, #6
shrn2.8h	v5, v7, #6
shrn.4h	v6, v0, #6
shrn2.8h	v6, v1, #6
shrn.4h	v7, v2, #6
shrn2.8h	v7, v3, #6
add.8h	v0, v4, v24
add.8h	v1, v5, v24
add.8h	v2, v6, v24
add.8h	v3, v7, v24
movi.8h	v20, #0
smin.8h	v0, v0, v23
smin.8h	v1, v1, v23
smin.8h	v2, v2, v23
smin.8h	v3, v3, v23
smax.8h	v0, v0, v20
smax.8h	v1, v1, v20
smax.8h	v2, v2, v20
smax.8h	v3, v3, v20
bl	gather32_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
ushl.8h	v6, v6, v29
ushl.8h	v7, v7, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
sqrdmulh.8h	v18, v18, v6
sqrdmulh.8h	v19, v19, v7
usqadd.8h	v10, v16
usqadd.8h	v11, v17
usqadd.8h	v12, v18
usqadd.8h	v13, v19
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umax.8h	v2, v12, v30
umax.8h	v3, v13, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w9, w9, #1
st1.8h	{ v0, v1, v2, v3 }, [x0], x2
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.8h	{ v0, v1, v2, v3 }, [x8], x10
ld1.8h	{ v16, v17, v18, v19 }, [x5], x10
smull.4s	v6, v16, v26
smull2.4s	v7, v16, v26
smull.4s	v10, v17, v26
smull2.4s	v11, v17, v26
smull.4s	v16, v18, v26
smull2.4s	v17, v18, v26
smull.4s	v18, v19, v26
smull2.4s	v19, v19, v26
smlal.4s	v6, v0, v25
smlal2.4s	v7, v0, v25
smlal.4s	v10, v1, v25
smlal2.4s	v11, v1, v25
smlal.4s	v16, v2, v25
smlal2.4s	v17, v2, v25
smlal.4s	v18, v3, v25
smlal2.4s	v19, v3, v25
sqrshrn.4h	v6, v6, #5
sqrshrn2.8h	v6, v7, #5
sqrshrn.4h	v7, v10, #5
sqrshrn2.8h	v7, v11, #5
sqrshrn.4h	v10, v16, #5
sqrshrn2.8h	v10, v17, #5
sqrshrn.4h	v11, v18, #5
sqrshrn2.8h	v11, v19, #5
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
smin.8h	v16, v6, v15
smin.8h	v17, v7, v15
smin.8h	v18, v10, v15
smin.8h	v19, v11, v15
smax.8h	v16, v16, v14
smax.8h	v17, v17, v14
smax.8h	v18, v18, v14
smax.8h	v19, v19, v14
ld1.8h	{ v10, v11, v12, v13 }, [x1], x2
smull.4s	v4, v0, v8
smull2.4s	v5, v0, v8
smull.4s	v6, v1, v8
smull2.4s	v7, v1, v8
smull.4s	v0, v2, v8
smull2.4s	v1, v2, v8
smull.4s	v2, v3, v8
smull2.4s	v3, v3, v8
smlal.4s	v4, v10, v9
smlal2.4s	v5, v10, v9
smlal.4s	v6, v11, v9
smlal2.4s	v7, v11, v9
smlal.4s	v0, v12, v9
smlal2.4s	v1, v12, v9
smlal.4s	v2, v13, v9
smlal2.4s	v3, v13, v9
shrn.4h	v4, v4, #6
shrn2.8h	v4, v5, #6
shrn.4h	v5, v6, #6
shrn2.8h	v5, v7, #6
shrn.4h	v6, v0, #6
shrn2.8h	v6, v1, #6
shrn.4h	v7, v2, #6
shrn2.8h	v7, v3, #6
add.8h	v0, v4, v24
add.8h	v1, v5, v24
add.8h	v2, v6, v24
add.8h	v3, v7, v24
movi.8h	v20, #0
smin.8h	v0, v0, v23
smin.8h	v1, v1, v23
smin.8h	v2, v2, v23
smin.8h	v3, v3, v23
smax.8h	v0, v0, v20
smax.8h	v1, v1, v20
smax.8h	v2, v2, v20
smax.8h	v3, v3, v20
bl	gather32_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
ushl.8h	v6, v6, v29
ushl.8h	v7, v7, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
sqrdmulh.8h	v18, v18, v6
sqrdmulh.8h	v19, v19, v7
usqadd.8h	v10, v16
usqadd.8h	v11, v17
usqadd.8h	v12, v18
usqadd.8h	v13, v19
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umax.8h	v2, v12, v30
umax.8h	v3, v13, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w9, w9, #1
dup.8h	v25, v28[0]
dup.8h	v26, v28[1]
st1.8h	{ v0, v1, v2, v3 }, [x0], x2
b.gt	fguv_loop_sx0_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.4h	{ v4 }, [x4], x10
ld1.8h	{ v16, v17, v18, v19 }, [x5], x10
smull.4s	v4, v4, v27
smlal.4s	v4, v16, v28
sqrshrn.4h	v4, v4, #5
smin.4h	v4, v4, v15
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
smax.4h	v4, v4, v14
ld1.8h	{ v10, v11, v12, v13 }, [x1], x2
mov.d	v16[0], v4[0]
smull.4s	v4, v0, v8
smull2.4s	v5, v0, v8
smull.4s	v6, v1, v8
smull2.4s	v7, v1, v8
smull.4s	v0, v2, v8
smull2.4s	v1, v2, v8
smull.4s	v2, v3, v8
smull2.4s	v3, v3, v8
smlal.4s	v4, v10, v9
smlal2.4s	v5, v10, v9
smlal.4s	v6, v11, v9
smlal2.4s	v7, v11, v9
smlal.4s	v0, v12, v9
smlal2.4s	v1, v12, v9
smlal.4s	v2, v13, v9
smlal2.4s	v3, v13, v9
shrn.4h	v4, v4, #6
shrn2.8h	v4, v5, #6
shrn.4h	v5, v6, #6
shrn2.8h	v5, v7, #6
shrn.4h	v6, v0, #6
shrn2.8h	v6, v1, #6
shrn.4h	v7, v2, #6
shrn2.8h	v7, v3, #6
add.8h	v0, v4, v24
add.8h	v1, v5, v24
add.8h	v2, v6, v24
add.8h	v3, v7, v24
movi.8h	v20, #0
smin.8h	v0, v0, v23
smin.8h	v1, v1, v23
smin.8h	v2, v2, v23
smin.8h	v3, v3, v23
smax.8h	v0, v0, v20
smax.8h	v1, v1, v20
smax.8h	v2, v2, v20
smax.8h	v3, v3, v20
bl	gather32_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
ushl.8h	v6, v6, v29
ushl.8h	v7, v7, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
sqrdmulh.8h	v18, v18, v6
sqrdmulh.8h	v19, v19, v7
usqadd.8h	v10, v16
usqadd.8h	v11, v17
usqadd.8h	v12, v18
usqadd.8h	v13, v19
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umax.8h	v2, v12, v30
umax.8h	v3, v13, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w9, w9, #1
st1.8h	{ v0, v1, v2, v3 }, [x0], x2
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.4h	{ v4 }, [x4], x10
ld1.8h	{ v0, v1, v2, v3 }, [x8], x10
ld1.4h	{ v5 }, [x11], x10
ld1.8h	{ v16, v17, v18, v19 }, [x5], x10
smull.4s	v4, v4, v27
smlal.4s	v4, v16, v28
smull.4s	v5, v5, v27
smlal.4s	v5, v0, v28
sqrshrn.4h	v4, v4, #5
sqrshrn.4h	v5, v5, #5
smin.4h	v4, v4, v15
smin.4h	v5, v5, v15
smax.4h	v4, v4, v14
smax.4h	v5, v5, v14
mov.d	v16[0], v4[0]
mov.d	v0[0], v5[0]
smull.4s	v6, v16, v26
smull2.4s	v7, v16, v26
smull.4s	v10, v17, v26
smull2.4s	v11, v17, v26
smull.4s	v16, v18, v26
smull2.4s	v17, v18, v26
smull.4s	v18, v19, v26
smull2.4s	v19, v19, v26
smlal.4s	v6, v0, v25
smlal2.4s	v7, v0, v25
smlal.4s	v10, v1, v25
smlal2.4s	v11, v1, v25
smlal.4s	v16, v2, v25
smlal2.4s	v17, v2, v25
smlal.4s	v18, v3, v25
smlal2.4s	v19, v3, v25
sqrshrn.4h	v6, v6, #5
sqrshrn2.8h	v6, v7, #5
sqrshrn.4h	v7, v10, #5
sqrshrn2.8h	v7, v11, #5
sqrshrn.4h	v10, v16, #5
sqrshrn2.8h	v10, v17, #5
sqrshrn.4h	v11, v18, #5
sqrshrn2.8h	v11, v19, #5
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
smin.8h	v16, v6, v15
smin.8h	v17, v7, v15
smin.8h	v18, v10, v15
smin.8h	v19, v11, v15
smax.8h	v16, v16, v14
smax.8h	v17, v17, v14
smax.8h	v18, v18, v14
smax.8h	v19, v19, v14
ld1.8h	{ v10, v11, v12, v13 }, [x1], x2
smull.4s	v4, v0, v8
smull2.4s	v5, v0, v8
smull.4s	v6, v1, v8
smull2.4s	v7, v1, v8
smull.4s	v0, v2, v8
smull2.4s	v1, v2, v8
smull.4s	v2, v3, v8
smull2.4s	v3, v3, v8
smlal.4s	v4, v10, v9
smlal2.4s	v5, v10, v9
smlal.4s	v6, v11, v9
smlal2.4s	v7, v11, v9
smlal.4s	v0, v12, v9
smlal2.4s	v1, v12, v9
smlal.4s	v2, v13, v9
smlal2.4s	v3, v13, v9
shrn.4h	v4, v4, #6
shrn2.8h	v4, v5, #6
shrn.4h	v5, v6, #6
shrn2.8h	v5, v7, #6
shrn.4h	v6, v0, #6
shrn2.8h	v6, v1, #6
shrn.4h	v7, v2, #6
shrn2.8h	v7, v3, #6
add.8h	v0, v4, v24
add.8h	v1, v5, v24
add.8h	v2, v6, v24
add.8h	v3, v7, v24
movi.8h	v20, #0
smin.8h	v0, v0, v23
smin.8h	v1, v1, v23
smin.8h	v2, v2, v23
smin.8h	v3, v3, v23
smax.8h	v0, v0, v20
smax.8h	v1, v1, v20
smax.8h	v2, v2, v20
smax.8h	v3, v3, v20
bl	gather32_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
ushl.8h	v6, v6, v29
ushl.8h	v7, v7, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
sqrdmulh.8h	v18, v18, v6
sqrdmulh.8h	v19, v19, v7
usqadd.8h	v10, v16
usqadd.8h	v11, v17
usqadd.8h	v12, v18
usqadd.8h	v13, v19
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umax.8h	v2, v12, v30
umax.8h	v3, v13, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w9, w9, #1
dup.8h	v25, v28[0]
dup.8h	v26, v28[1]
st1.8h	{ v0, v1, v2, v3 }, [x0], x2
b.gt	fguv_loop_sx0_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.8h	{ v16, v17, v18, v19 }, [x5], x10
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
ld1.8h	{ v10, v11, v12, v13 }, [x1], x2
and.16b	v0, v0, v23
and.16b	v1, v1, v23
and.16b	v2, v2, v23
and.16b	v3, v3, v23
bl	gather32_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
ushl.8h	v6, v6, v29
ushl.8h	v7, v7, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
sqrdmulh.8h	v18, v18, v6
sqrdmulh.8h	v19, v19, v7
usqadd.8h	v10, v16
usqadd.8h	v11, v17
usqadd.8h	v12, v18
usqadd.8h	v13, v19
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umax.8h	v2, v12, v30
umax.8h	v3, v13, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w9, w9, #1
st1.8h	{ v0, v1, v2, v3 }, [x0], x2
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.8h	{ v0, v1, v2, v3 }, [x8], x10
ld1.8h	{ v16, v17, v18, v19 }, [x5], x10
smull.4s	v6, v16, v26
smull2.4s	v7, v16, v26
smull.4s	v10, v17, v26
smull2.4s	v11, v17, v26
smull.4s	v16, v18, v26
smull2.4s	v17, v18, v26
smull.4s	v18, v19, v26
smull2.4s	v19, v19, v26
smlal.4s	v6, v0, v25
smlal2.4s	v7, v0, v25
smlal.4s	v10, v1, v25
smlal2.4s	v11, v1, v25
smlal.4s	v16, v2, v25
smlal2.4s	v17, v2, v25
smlal.4s	v18, v3, v25
smlal2.4s	v19, v3, v25
sqrshrn.4h	v6, v6, #5
sqrshrn2.8h	v6, v7, #5
sqrshrn.4h	v7, v10, #5
sqrshrn2.8h	v7, v11, #5
sqrshrn.4h	v10, v16, #5
sqrshrn2.8h	v10, v17, #5
sqrshrn.4h	v11, v18, #5
sqrshrn2.8h	v11, v19, #5
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
smin.8h	v16, v6, v15
smin.8h	v17, v7, v15
smin.8h	v18, v10, v15
smin.8h	v19, v11, v15
smax.8h	v16, v16, v14
smax.8h	v17, v17, v14
smax.8h	v18, v18, v14
smax.8h	v19, v19, v14
ld1.8h	{ v10, v11, v12, v13 }, [x1], x2
and.16b	v0, v0, v23
and.16b	v1, v1, v23
and.16b	v2, v2, v23
and.16b	v3, v3, v23
bl	gather32_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
ushl.8h	v6, v6, v29
ushl.8h	v7, v7, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
sqrdmulh.8h	v18, v18, v6
sqrdmulh.8h	v19, v19, v7
usqadd.8h	v10, v16
usqadd.8h	v11, v17
usqadd.8h	v12, v18
usqadd.8h	v13, v19
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umax.8h	v2, v12, v30
umax.8h	v3, v13, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w9, w9, #1
dup.8h	v25, v28[0]
dup.8h	v26, v28[1]
st1.8h	{ v0, v1, v2, v3 }, [x0], x2
b.gt	fguv_loop_sx0_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.4h	{ v4 }, [x4], x10
ld1.8h	{ v16, v17, v18, v19 }, [x5], x10
smull.4s	v4, v4, v27
smlal.4s	v4, v16, v28
sqrshrn.4h	v4, v4, #5
smin.4h	v4, v4, v15
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
smax.4h	v4, v4, v14
ld1.8h	{ v10, v11, v12, v13 }, [x1], x2
mov.d	v16[0], v4[0]
and.16b	v0, v0, v23
and.16b	v1, v1, v23
and.16b	v2, v2, v23
and.16b	v3, v3, v23
bl	gather32_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
ushl.8h	v6, v6, v29
ushl.8h	v7, v7, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
sqrdmulh.8h	v18, v18, v6
sqrdmulh.8h	v19, v19, v7
usqadd.8h	v10, v16
usqadd.8h	v11, v17
usqadd.8h	v12, v18
usqadd.8h	v13, v19
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umax.8h	v2, v12, v30
umax.8h	v3, v13, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w9, w9, #1
st1.8h	{ v0, v1, v2, v3 }, [x0], x2
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ld1.4h	{ v4 }, [x4], x10
ld1.8h	{ v0, v1, v2, v3 }, [x8], x10
ld1.4h	{ v5 }, [x11], x10
ld1.8h	{ v16, v17, v18, v19 }, [x5], x10
smull.4s	v4, v4, v27
smlal.4s	v4, v16, v28
smull.4s	v5, v5, v27
smlal.4s	v5, v0, v28
sqrshrn.4h	v4, v4, #5
sqrshrn.4h	v5, v5, #5
smin.4h	v4, v4, v15
smin.4h	v5, v5, v15
smax.4h	v4, v4, v14
smax.4h	v5, v5, v14
mov.d	v16[0], v4[0]
mov.d	v0[0], v5[0]
smull.4s	v6, v16, v26
smull2.4s	v7, v16, v26
smull.4s	v10, v17, v26
smull2.4s	v11, v17, v26
smull.4s	v16, v18, v26
smull2.4s	v17, v18, v26
smull.4s	v18, v19, v26
smull2.4s	v19, v19, v26
smlal.4s	v6, v0, v25
smlal2.4s	v7, v0, v25
smlal.4s	v10, v1, v25
smlal2.4s	v11, v1, v25
smlal.4s	v16, v2, v25
smlal2.4s	v17, v2, v25
smlal.4s	v18, v3, v25
smlal2.4s	v19, v3, v25
sqrshrn.4h	v6, v6, #5
sqrshrn2.8h	v6, v7, #5
sqrshrn.4h	v7, v10, #5
sqrshrn2.8h	v7, v11, #5
sqrshrn.4h	v10, v16, #5
sqrshrn2.8h	v10, v17, #5
sqrshrn.4h	v11, v18, #5
sqrshrn2.8h	v11, v19, #5
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
smin.8h	v16, v6, v15
smin.8h	v17, v7, v15
smin.8h	v18, v10, v15
smin.8h	v19, v11, v15
smax.8h	v16, v16, v14
smax.8h	v17, v17, v14
smax.8h	v18, v18, v14
smax.8h	v19, v19, v14
ld1.8h	{ v10, v11, v12, v13 }, [x1], x2
and.16b	v0, v0, v23
and.16b	v1, v1, v23
and.16b	v2, v2, v23
and.16b	v3, v3, v23
bl	gather32_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
ushl.8h	v6, v6, v29
ushl.8h	v7, v7, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
sqrdmulh.8h	v18, v18, v6
sqrdmulh.8h	v19, v19, v7
usqadd.8h	v10, v16
usqadd.8h	v11, v17
usqadd.8h	v12, v18
usqadd.8h	v13, v19
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umax.8h	v2, v12, v30
umax.8h	v3, v13, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w9, w9, #1
dup.8h	v25, v28[0]
dup.8h	v26, v28[1]
st1.8h	{ v0, v1, v2, v3 }, [x0], x2
b.gt	fguv_loop_sx0_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx0_neon
b	fguv_loop_sx0_neon
ldp	d14, d15, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldr	x30, [sp], #80
ret
stllrb	w16, [x13]
<unknown>
<unknown>
<unknown>
_fguv_loop_sx1_neon:
ld1.8h	{ v16, v17 }, [x5], x10
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
ld1.8h	{ v10, v11 }, [x1], x2
addp.8h	v0, v0, v1
addp.8h	v1, v2, v3
urshr.8h	v0, v0, #1
urshr.8h	v1, v1, #1
smull.4s	v2, v0, v8
smull2.4s	v3, v0, v8
smull.4s	v0, v1, v8
smull2.4s	v1, v1, v8
smlal.4s	v2, v10, v9
smlal2.4s	v3, v10, v9
smlal.4s	v0, v11, v9
smlal2.4s	v1, v11, v9
shrn.4h	v2, v2, #6
shrn2.8h	v2, v3, #6
shrn.4h	v3, v0, #6
shrn2.8h	v3, v1, #6
add.8h	v0, v2, v24
add.8h	v1, v3, v24
movi.8h	v2, #0
smin.8h	v0, v0, v23
smin.8h	v1, v1, v23
smax.8h	v0, v0, v2
smax.8h	v1, v1, v2
bl	gather16_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
usqadd.8h	v10, v16
usqadd.8h	v11, v17
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
subs	w9, w9, #1
st1.8h	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.8h	{ v20, v21 }, [x8], x10
ld1.8h	{ v16, v17 }, [x5], x10
smull.4s	v0, v16, v26
smull2.4s	v1, v16, v26
smull.4s	v2, v17, v26
smull2.4s	v3, v17, v26
smlal.4s	v0, v20, v25
smlal2.4s	v1, v20, v25
smlal.4s	v2, v21, v25
smlal2.4s	v3, v21, v25
sqrshrn.4h	v16, v0, #5
sqrshrn2.8h	v16, v1, #5
sqrshrn.4h	v17, v2, #5
sqrshrn2.8h	v17, v3, #5
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
smin.8h	v16, v16, v15
smin.8h	v17, v17, v15
smax.8h	v16, v16, v14
smax.8h	v17, v17, v14
ld1.8h	{ v10, v11 }, [x1], x2
addp.8h	v0, v0, v1
addp.8h	v1, v2, v3
urshr.8h	v0, v0, #1
urshr.8h	v1, v1, #1
smull.4s	v2, v0, v8
smull2.4s	v3, v0, v8
smull.4s	v0, v1, v8
smull2.4s	v1, v1, v8
smlal.4s	v2, v10, v9
smlal2.4s	v3, v10, v9
smlal.4s	v0, v11, v9
smlal2.4s	v1, v11, v9
shrn.4h	v2, v2, #6
shrn2.8h	v2, v3, #6
shrn.4h	v3, v0, #6
shrn2.8h	v3, v1, #6
add.8h	v0, v2, v24
add.8h	v1, v3, v24
movi.8h	v2, #0
smin.8h	v0, v0, v23
smin.8h	v1, v1, v23
smax.8h	v0, v0, v2
smax.8h	v1, v1, v2
bl	gather16_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
usqadd.8h	v10, v16
usqadd.8h	v11, v17
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
mov.16b	v16, v25
subs	w9, w9, #1
mov.16b	v25, v26
mov.16b	v26, v16
st1.8h	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx1_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.4h	{ v18 }, [x4], x10
ld1.8h	{ v16, v17 }, [x5], x10
smull.4s	v18, v18, v27
smlal.4s	v18, v16, v28
sqrshrn.4h	v18, v18, #5
smin.4h	v18, v18, v15
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
smax.4h	v18, v18, v14
ld1.8h	{ v10, v11 }, [x1], x2
mov.d	v16[0], v18[0]
addp.8h	v0, v0, v1
addp.8h	v1, v2, v3
urshr.8h	v0, v0, #1
urshr.8h	v1, v1, #1
smull.4s	v2, v0, v8
smull2.4s	v3, v0, v8
smull.4s	v0, v1, v8
smull2.4s	v1, v1, v8
smlal.4s	v2, v10, v9
smlal2.4s	v3, v10, v9
smlal.4s	v0, v11, v9
smlal2.4s	v1, v11, v9
shrn.4h	v2, v2, #6
shrn2.8h	v2, v3, #6
shrn.4h	v3, v0, #6
shrn2.8h	v3, v1, #6
add.8h	v0, v2, v24
add.8h	v1, v3, v24
movi.8h	v2, #0
smin.8h	v0, v0, v23
smin.8h	v1, v1, v23
smax.8h	v0, v0, v2
smax.8h	v1, v1, v2
bl	gather16_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
usqadd.8h	v10, v16
usqadd.8h	v11, v17
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
subs	w9, w9, #1
st1.8h	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.4h	{ v18 }, [x4], x10
ld1.8h	{ v20, v21 }, [x8], x10
ld1.4h	{ v19 }, [x11], x10
ld1.8h	{ v16, v17 }, [x5], x10
smull.4s	v18, v18, v27
smlal.4s	v18, v16, v28
smull.4s	v19, v19, v27
smlal.4s	v19, v20, v28
sqrshrn.4h	v18, v18, #5
sqrshrn.4h	v19, v19, #5
smin.4h	v18, v18, v15
smin.4h	v19, v19, v15
smax.4h	v18, v18, v14
smax.4h	v19, v19, v14
mov.d	v16[0], v18[0]
mov.d	v20[0], v19[0]
smull.4s	v0, v16, v26
smull2.4s	v1, v16, v26
smull.4s	v2, v17, v26
smull2.4s	v3, v17, v26
smlal.4s	v0, v20, v25
smlal2.4s	v1, v20, v25
smlal.4s	v2, v21, v25
smlal2.4s	v3, v21, v25
sqrshrn.4h	v16, v0, #5
sqrshrn2.8h	v16, v1, #5
sqrshrn.4h	v17, v2, #5
sqrshrn2.8h	v17, v3, #5
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
smin.8h	v16, v16, v15
smin.8h	v17, v17, v15
smax.8h	v16, v16, v14
smax.8h	v17, v17, v14
ld1.8h	{ v10, v11 }, [x1], x2
addp.8h	v0, v0, v1
addp.8h	v1, v2, v3
urshr.8h	v0, v0, #1
urshr.8h	v1, v1, #1
smull.4s	v2, v0, v8
smull2.4s	v3, v0, v8
smull.4s	v0, v1, v8
smull2.4s	v1, v1, v8
smlal.4s	v2, v10, v9
smlal2.4s	v3, v10, v9
smlal.4s	v0, v11, v9
smlal2.4s	v1, v11, v9
shrn.4h	v2, v2, #6
shrn2.8h	v2, v3, #6
shrn.4h	v3, v0, #6
shrn2.8h	v3, v1, #6
add.8h	v0, v2, v24
add.8h	v1, v3, v24
movi.8h	v2, #0
smin.8h	v0, v0, v23
smin.8h	v1, v1, v23
smax.8h	v0, v0, v2
smax.8h	v1, v1, v2
bl	gather16_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
usqadd.8h	v10, v16
usqadd.8h	v11, v17
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
mov.16b	v16, v25
subs	w9, w9, #1
mov.16b	v25, v26
mov.16b	v26, v16
st1.8h	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx1_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.8h	{ v16, v17 }, [x5], x10
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
ld1.8h	{ v10, v11 }, [x1], x2
addp.8h	v0, v0, v1
addp.8h	v1, v2, v3
urshr.8h	v0, v0, #1
urshr.8h	v1, v1, #1
and.16b	v0, v0, v23
and.16b	v1, v1, v23
bl	gather16_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
usqadd.8h	v10, v16
usqadd.8h	v11, v17
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
subs	w9, w9, #1
st1.8h	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.8h	{ v20, v21 }, [x8], x10
ld1.8h	{ v16, v17 }, [x5], x10
smull.4s	v0, v16, v26
smull2.4s	v1, v16, v26
smull.4s	v2, v17, v26
smull2.4s	v3, v17, v26
smlal.4s	v0, v20, v25
smlal2.4s	v1, v20, v25
smlal.4s	v2, v21, v25
smlal2.4s	v3, v21, v25
sqrshrn.4h	v16, v0, #5
sqrshrn2.8h	v16, v1, #5
sqrshrn.4h	v17, v2, #5
sqrshrn2.8h	v17, v3, #5
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
smin.8h	v16, v16, v15
smin.8h	v17, v17, v15
smax.8h	v16, v16, v14
smax.8h	v17, v17, v14
ld1.8h	{ v10, v11 }, [x1], x2
addp.8h	v0, v0, v1
addp.8h	v1, v2, v3
urshr.8h	v0, v0, #1
urshr.8h	v1, v1, #1
and.16b	v0, v0, v23
and.16b	v1, v1, v23
bl	gather16_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
usqadd.8h	v10, v16
usqadd.8h	v11, v17
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
mov.16b	v16, v25
subs	w9, w9, #1
mov.16b	v25, v26
mov.16b	v26, v16
st1.8h	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx1_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.4h	{ v18 }, [x4], x10
ld1.8h	{ v16, v17 }, [x5], x10
smull.4s	v18, v18, v27
smlal.4s	v18, v16, v28
sqrshrn.4h	v18, v18, #5
smin.4h	v18, v18, v15
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
smax.4h	v18, v18, v14
ld1.8h	{ v10, v11 }, [x1], x2
mov.d	v16[0], v18[0]
addp.8h	v0, v0, v1
addp.8h	v1, v2, v3
urshr.8h	v0, v0, #1
urshr.8h	v1, v1, #1
and.16b	v0, v0, v23
and.16b	v1, v1, v23
bl	gather16_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
usqadd.8h	v10, v16
usqadd.8h	v11, v17
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
subs	w9, w9, #1
st1.8h	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ld1.4h	{ v18 }, [x4], x10
ld1.8h	{ v20, v21 }, [x8], x10
ld1.4h	{ v19 }, [x11], x10
ld1.8h	{ v16, v17 }, [x5], x10
smull.4s	v18, v18, v27
smlal.4s	v18, v16, v28
smull.4s	v19, v19, v27
smlal.4s	v19, v20, v28
sqrshrn.4h	v18, v18, #5
sqrshrn.4h	v19, v19, #5
smin.4h	v18, v18, v15
smin.4h	v19, v19, v15
smax.4h	v18, v18, v14
smax.4h	v19, v19, v14
mov.d	v16[0], v18[0]
mov.d	v20[0], v19[0]
smull.4s	v0, v16, v26
smull2.4s	v1, v16, v26
smull.4s	v2, v17, v26
smull2.4s	v3, v17, v26
smlal.4s	v0, v20, v25
smlal2.4s	v1, v20, v25
smlal.4s	v2, v21, v25
smlal2.4s	v3, v21, v25
sqrshrn.4h	v16, v0, #5
sqrshrn2.8h	v16, v1, #5
sqrshrn.4h	v17, v2, #5
sqrshrn2.8h	v17, v3, #5
ld1.8h	{ v0, v1, v2, v3 }, [x6], x7
smin.8h	v16, v16, v15
smin.8h	v17, v17, v15
smax.8h	v16, v16, v14
smax.8h	v17, v17, v14
ld1.8h	{ v10, v11 }, [x1], x2
addp.8h	v0, v0, v1
addp.8h	v1, v2, v3
urshr.8h	v0, v0, #1
urshr.8h	v1, v1, #1
and.16b	v0, v0, v23
and.16b	v1, v1, v23
bl	gather16_neon
ushll.8h	v4, v6, #0
ushll2.8h	v5, v6, #0
ushl.8h	v4, v4, v29
ushl.8h	v5, v5, v29
sqrdmulh.8h	v16, v16, v4
sqrdmulh.8h	v17, v17, v5
usqadd.8h	v10, v16
usqadd.8h	v11, v17
umax.8h	v0, v10, v30
umax.8h	v1, v11, v30
umin.8h	v0, v0, v31
umin.8h	v1, v1, v31
mov.16b	v16, v25
subs	w9, w9, #1
mov.16b	v25, v26
mov.16b	v26, v16
st1.8h	{ v0, v1 }, [x0], x2
b.gt	fguv_loop_sx1_neon
cmp	w12, #0
mov	w9, w12
b.gt	fguv_loop_sx1_neon
b	fguv_loop_sx1_neon
ldp	d14, d15, [sp, #64]
ldp	d12, d13, [sp, #48]
ldp	d10, d11, [sp, #32]
ldp	d8, d9, [sp, #16]
ldr	x30, [sp], #80
ret
mov	z0.d, p4/z, #52         ; =0x34
<unknown>
<unknown>
<unknown>