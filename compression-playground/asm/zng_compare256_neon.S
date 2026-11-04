	.text
compare256_neon:
mov	w8, #0x8
L_4:
ldr	q0, [x0]
ldr	q1, [x1]
eor	v0.16b, v1.16b, v0.16b
fmov	x9, d0
cbnz	x9, L_40
mov	x9, v0.d[1]
cbnz	x9, L_54
sub	w9, w8, #0x8
add	w8, w8, #0x10
add	x0, x0, #0x10
cmp	w9, #0xf0
add	x1, x1, #0x10
b.lo	L_4
mov	w0, #0x100
ret
L_40:
rbit	x9, x9
clz	x9, x9
add	w8, w8, w9, lsr #3
sub	w0, w8, #0x8
ret
L_54:
rbit	x9, x9
clz	x9, x9
add	w0, w8, w9, lsr #3
ret
longest_match_neon:
str	x25, [sp, #-0x40]!
and	w10, w1, #0xffff
mov	w8, #0x2
mov	w15, #-0x3
ldp	w13, w1, [x0, #0x8c]
mov	w16, #-0x7
ldp	x11, x12, [x0, #0x58]
ldr	w9, [x0, #0x84]
ldr	w18, [x0, #0x40]
stp	x22, x21, [sp, #0x20]
cmp	w13, #0x0
lsr	w3, w1, #2
stp	x20, x19, [sp, #0x30]
csel	w8, w8, w13, eq
sub	w5, w18, #0x106
mov	w6, #-0x5
cmp	w8, #0x7
stp	x24, x23, [sp, #0x10]
csel	w16, w16, w15, hi
cmp	w8, #0x3
add	x15, x11, x9
csinv	w17, w16, wzr, hi
ldr	x16, [x15]
add	w4, w17, w8
ldp	w2, w17, [x0, #0xb8]
ldp	w14, w13, [x0, #0x48]
and	w18, w16, #0xffff
add	x20, x11, x4
cmp	w8, w2
ldr	x2, [x15, x4]
add	x4, x15, #0x2
csel	w1, w1, w3, lo
subs	w3, w9, w5
and	w7, w2, #0xffff
lsr	w21, w2, #16
lsr	x19, x2, #32
csel	w5, wzr, w3, lo
ldr	w2, [x0, #0xb0]
add	x3, x11, #0x2
and	w5, w5, #0xffff
L_104:
cmp	w9, w10
b.ls	L_2c0
cmp	w8, #0x3
b.hi	L_14c
L_114:
mov	w22, w10
ldrh	w23, [x20, x22]
cmp	w23, w7
b.ne	L_130
ldrh	w23, [x11, x22]
cmp	w23, w18
b.eq	L_1d8
L_130:
subs	w1, w1, #0x1
b.eq	L_2c0
and	w10, w14, w10
ldrh	w10, [x12, w10, uxtw #1]
cmp	w10, w5
b.hi	L_114
b	L_2c0
L_14c:
cmp	w8, #0x7
b.ls	L_19c
mov	w22, w21
mov	w23, w7
orr	x22, x23, x22, lsl #16
orr	x23, x22, x19, lsl #32
L_164:
mov	w22, w10
ldr	x24, [x20, x22]
cmp	x24, x23
b.ne	L_180
ldr	x24, [x11, x22]
cmp	x24, x16
b.eq	L_1d8
L_180:
subs	w1, w1, #0x1
b.eq	L_2c0
and	w10, w14, w10
ldrh	w10, [x12, w10, uxtw #1]
cmp	w10, w5
b.hi	L_164
b	L_2c0
L_19c:
orr	w23, w7, w21, lsl #16
L_1a0:
mov	w22, w10
ldr	w24, [x20, x22]
cmp	w24, w23
b.ne	L_1bc
ldr	w24, [x11, x22]
cmp	w24, w16
b.eq	L_1d8
L_1bc:
subs	w1, w1, #0x1
b.eq	L_2c0
and	w10, w14, w10
ldrh	w10, [x12, w10, uxtw #1]
cmp	w10, w5
b.hi	L_1a0
b	L_2c0
L_1d8:
add	x23, x3, x22
mov	w22, #0x8
mov	x24, x4
L_1e4:
ldr	q0, [x24]
ldr	q1, [x23]
eor	v0.16b, v1.16b, v0.16b
fmov	x25, d0
cbnz	x25, L_220
mov	x25, v0.d[1]
cbnz	x25, L_234
sub	w25, w22, #0x8
add	w22, w22, #0x10
add	x24, x24, #0x10
cmp	w25, #0xf0
add	x23, x23, #0x10
b.lo	L_1e4
mov	w23, #0x100
b	L_240
L_220:
rbit	x23, x25
clz	x23, x23
add	w22, w22, w23, lsr #3
sub	w23, w22, #0x8
b	L_240
L_234:
rbit	x23, x25
clz	x23, x23
add	w23, w22, w23, lsr #3
L_240:
add	w22, w23, #0x2
cmp	w22, w8
b.ls	L_290
cmp	w22, w13
str	w10, [x0, #0x88]
b.hs	L_2b4
cmp	w22, w17
b.hs	L_2bc
cmp	w23, #0x5
csinv	w8, w6, wzr, hi
cmp	w23, #0x1
csinc	w8, w8, wzr, hi
add	w8, w8, w23
ldr	x7, [x15, x8]
add	x20, x11, x8
mov	w8, w22
lsr	w21, w7, #16
lsr	x19, x7, #32
and	w7, w7, #0xffff
b	L_298
L_290:
cmp	w2, #0x5
b.lt	L_2c0
L_298:
subs	w1, w1, #0x1
b.eq	L_2c0
and	w10, w14, w10
ldrh	w10, [x12, w10, uxtw #1]
cmp	w10, w5
b.hi	L_104
b	L_2c0
L_2b4:
mov	w8, w13
b	L_2c0
L_2bc:
mov	w8, w22
L_2c0:
ldp	x20, x19, [sp, #0x30]
mov	w0, w8
ldp	x22, x21, [sp, #0x20]
ldp	x24, x23, [sp, #0x10]
ldr	x25, [sp], #0x40
ret
longest_match_slow_neon:
sub	sp, sp, #0xd0
ldp	w9, w10, [x0, #0x8c]
mov	w8, #0x2
stp	x24, x23, [sp, #0xa0]
mov	w11, #-0x3
mov	w12, #-0x7
ldr	w15, [x0, #0x84]
stp	x20, x19, [sp, #0xc0]
cmp	w9, #0x0
lsr	w13, w10, #2
mov	w20, w1
csel	w24, w8, w9, eq
ldr	w8, [x0, #0x40]
stp	x28, x27, [sp, #0x80]
ldp	w9, w16, [x0, #0xb8]
cmp	w24, #0x7
sub	w8, w8, #0x106
stp	x22, x21, [sp, #0xb0]
csel	w11, w12, w11, hi
ldp	x18, x1, [x0, #0x58]
cmp	w24, w9
mov	x19, x0
stp	x29, x30, [sp, #0x70]
csel	w23, w10, w13, lo
subs	w8, w15, w8
stp	x26, x25, [sp, #0x90]
csel	w17, w8, wzr, hi
cmp	w24, #0x3
add	x27, x18, x15
csinv	w8, w11, wzr, hi
ldr	x3, [x27]
add	x29, sp, #0x70
add	w8, w8, w24
ldp	w22, w2, [x0, #0x48]
ldr	x21, [x27, x8]
add	x28, x18, x8
b.lo	L_420
str	x1, [sp, #0x38]
ldr	x8, [x19, #0x98]
ubfx	w1, w3, #8, #8
mov	w0, wzr
stur	w2, [x29, #-0x24]
stur	x18, [x29, #-0x20]
stur	w17, [x29, #-0x4]
stur	w16, [x29, #-0x14]
stur	x15, [x29, #-0x10]
stur	x3, [x29, #-0x30]
blr	x8
ldr	x8, [x19, #0x98]
ldrb	w1, [x27, #0x2]
blr	x8
mov	w25, wzr
mov	w26, #0x3
L_3ac:
ldr	x8, [x19, #0x98]
ldrb	w1, [x27, w26, uxtw]
blr	x8
ldr	x8, [x19, #0x68]
and	w9, w20, #0xffff
sub	w10, w26, #0x2
add	w26, w26, #0x1
ldrh	w8, [x8, w0, uxtw #1]
cmp	w8, w9
csel	w25, w10, w25, lo
csel	w20, w8, w9, lo
cmp	w26, w24
b.ls	L_3ac
ldur	w17, [x29, #-0x4]
add	w8, w25, w17
cmp	w20, w8, uxth
b.ls	L_75c
ldur	x18, [x29, #-0x20]
and	x10, x25, #0xffff
ldur	x15, [x29, #-0x10]
ldur	w16, [x29, #-0x14]
ldr	x1, [sp, #0x38]
sub	x28, x28, x10
ldur	w2, [x29, #-0x24]
ldur	x3, [x29, #-0x30]
sub	x9, x18, x10
cmp	w15, w20, uxth
b.hi	L_434
b	L_748
L_420:
mov	w25, wzr
mov	w8, w17
mov	x9, x18
cmp	w15, w20, uxth
b.ls	L_748
L_434:
lsr	w10, w21, #16
lsr	x7, x21, #32
and	w4, w3, #0xffff
and	w26, w21, #0xffff
and	w5, w17, #0xffff
add	x6, x18, #0x2
mov	w21, w10
L_450:
cmp	w24, #0x3
b.hi	L_494
L_458:
and	x11, x20, #0xffff
ldrh	w10, [x28, x11]
cmp	w10, w26
b.ne	L_474
ldrh	w10, [x9, x11]
cmp	w10, w4
b.eq	L_52c
L_474:
subs	w23, w23, #0x1
b.eq	L_748
and	w10, w20, #0xffff
and	w10, w22, w10
ldrh	w20, [x1, w10, uxtw #1]
cmp	w20, w8, uxth
b.hi	L_458
b	L_748
L_494:
cmp	w24, #0x7
b.ls	L_4e8
mov	w10, w21
mov	w11, w26
orr	x10, x11, x10, lsl #16
orr	x10, x10, x7, lsl #32
L_4ac:
and	x11, x20, #0xffff
ldr	x12, [x28, x11]
cmp	x12, x10
b.ne	L_4c8
ldr	x12, [x9, x11]
cmp	x12, x3
b.eq	L_52c
L_4c8:
subs	w23, w23, #0x1
b.eq	L_748
and	w11, w20, #0xffff
and	w11, w22, w11
ldrh	w20, [x1, w11, uxtw #1]
cmp	w20, w8, uxth
b.hi	L_4ac
b	L_748
L_4e8:
orr	w12, w26, w21, lsl #16
mov	w10, w20
L_4f0:
and	x11, x10, #0xffff
ldr	w13, [x28, x11]
cmp	w13, w12
b.ne	L_50c
ldr	w13, [x9, x11]
cmp	w13, w3
b.eq	L_530
L_50c:
subs	w23, w23, #0x1
b.eq	L_748
and	w10, w10, #0xffff
and	w10, w22, w10
ldrh	w10, [x1, w10, uxtw #1]
cmp	w10, w8, uxth
b.hi	L_4f0
b	L_748
L_52c:
mov	w10, w20
L_530:
add	x11, x11, #0x2
mov	w12, #0x8
mov	x13, x6
L_53c:
ldr	q0, [x13, x15]
ldr	q1, [x9, x11]
eor	v0.16b, v1.16b, v0.16b
fmov	x14, d0
cbnz	x14, L_578
mov	x14, v0.d[1]
cbnz	x14, L_58c
sub	w14, w12, #0x8
add	w12, w12, #0x10
add	x11, x11, #0x10
cmp	w14, #0xf0
add	x13, x13, #0x10
b.lo	L_53c
mov	w12, #0x100
b	L_598
L_578:
rbit	x11, x14
clz	x11, x11
add	w11, w12, w11, lsr #3
sub	w12, w11, #0x8
b	L_598
L_58c:
rbit	x11, x14
clz	x11, x11
add	w12, w12, w11, lsr #3
L_598:
add	w0, w12, #0x2
cmp	w0, w24
b.ls	L_600
and	w11, w10, #0xffff
cmp	w0, w2
sub	w20, w11, w25, uxth
str	w20, [x19, #0x88]
b.hs	L_750
cmp	w0, w16
b.hs	L_74c
subs	w11, w12, #0x1
subs	w13, w12, #0x5
csel	w13, w13, w11, hi
subs	w11, w12, #0x1
csinc	w24, w13, w12, hi
subs	w28, w12, #0x2
ldr	x12, [x27, x24]
lsr	w21, w12, #16
lsr	x7, x12, #32
and	w26, w12, #0xffff
b.lo	L_5f8
add	w12, w0, w20
cmp	w12, w15
b.lo	L_630
L_5f8:
add	x28, x9, x24
mov	w24, w0
L_600:
subs	w23, w23, #0x1
b.eq	L_748
and	w10, w10, w22
mov	w0, w24
and	w10, w10, #0xffff
ldrh	w20, [x1, w10, uxtw #1]
cmp	w20, w8, uxth
b.ls	L_74c
L_620:
cmp	w15, w20, uxth
mov	w24, w0
b.hi	L_450
b	L_74c
L_630:
str	x21, [sp, #0x10]
mov	x21, x0
mov	w8, wzr
str	w26, [sp, #0x1c]
mov	w26, wzr
and	w9, w20, #0xffff
stp	x7, x6, [sp, #0x20]
str	w4, [sp, #0x34]
stur	x3, [x29, #-0x30]
stur	w2, [x29, #-0x24]
stur	x18, [x29, #-0x20]
stur	w17, [x29, #-0x4]
stur	w16, [x29, #-0x14]
stur	x15, [x29, #-0x10]
b	L_680
L_66c:
mov	w26, w8
mov	w20, w10
L_674:
add	w8, w8, #0x1
cmp	w8, w11
b.hi	L_6a4
L_680:
add	w10, w9, w8
and	w10, w10, w22
ldrh	w10, [x1, w10, uxtw #1]
cmp	w10, w20, uxth
b.hs	L_674
add	w12, w5, w8
cmp	w12, w10
b.lo	L_66c
b	L_758
L_6a4:
add	x25, x27, x21
str	x1, [sp, #0x38]
ldr	x8, [x19, #0x98]
ldurb	w1, [x25, #-0x4]
mov	w0, wzr
str	w5, [sp, #0xc]
blr	x8
ldr	x8, [x19, #0x98]
ldurb	w1, [x25, #-0x3]
blr	x8
ldr	x8, [x19, #0x98]
ldurb	w1, [x25, #-0x2]
blr	x8
ldr	x8, [x19, #0x68]
ldrh	w8, [x8, w0, uxtw #1]
cmp	w8, w20, uxth
b.hs	L_700
ldr	w9, [sp, #0xc]
add	w9, w9, w28, uxth
cmp	w9, w8
b.hs	L_758
mov	w26, w28
mov	w20, w8
L_700:
ldur	x18, [x29, #-0x20]
mov	x25, x26
ldur	w17, [x29, #-0x4]
ldp	x7, x6, [sp, #0x20]
mov	x0, x21
sub	x9, x18, w25, uxth
ldur	x15, [x29, #-0x10]
ldur	w16, [x29, #-0x14]
ldr	x1, [sp, #0x38]
ldur	w2, [x29, #-0x24]
add	w8, w25, w17
ldur	x3, [x29, #-0x30]
ldr	w4, [sp, #0x34]
add	x28, x9, x24
ldr	w5, [sp, #0xc]
ldr	w26, [sp, #0x1c]
ldr	x21, [sp, #0x10]
b	L_620
L_748:
mov	w0, w24
L_74c:
b	L_768
L_750:
mov	w0, w2
b	L_74c
L_758:
mov	w24, w21
L_75c:
ldr	w8, [x19, #0x4c]
cmp	w24, w8
csel	w0, w24, w8, lo
L_768:
ldp	x20, x19, [sp, #0xc0]
ldp	x22, x21, [sp, #0xb0]
ldp	x24, x23, [sp, #0xa0]
ldp	x26, x25, [sp, #0x90]
ldp	x28, x27, [sp, #0x80]
ldp	x29, x30, [sp, #0x70]
add	sp, sp, #0xd0
ret
