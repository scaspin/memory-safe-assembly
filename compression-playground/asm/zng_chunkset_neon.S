	.text
chunkmemset_safe_neon:
sub	sp, sp, #0x30
cmp	w2, w3
stp	x20, x19, [sp, #0x20]
csel	w19, w2, w3, lo
cmp	w3, #0xf
stp	x29, x30, [sp, #0x10]
add	x29, sp, #0x10
b.ls	L_1a0
cbz	w2, L_190
subs	x9, x0, x1
cneg	x8, x9, mi
tbz	x9, #0x3f, L_4c
cmp	x8, x19
b.hs	L_4c
mov	x2, x19
mov	x20, x0
bl	memmove
add	x0, x20, x19
b	L_190
L_4c:
cmp	x8, #0x1
b.ne	L_6c
ldrb	w1, [x1]
mov	x2, x19
mov	x20, x0
bl	memset
add	x0, x20, x19
b	L_190
L_6c:
cmp	x8, #0x10
b.lo	L_b4
sub	w8, w19, #0x1
ldr	q0, [x1]
and	w9, w8, #0xf
add	w8, w9, #0x1
str	q0, [x0]
cmp	w19, w8
add	x0, x0, x8
b.eq	L_190
sub	w9, w9, w19
add	x8, x1, x8
add	w9, w9, #0x1
L_a0:
ldr	q0, [x8], #0x10
adds	w9, w9, #0x10
str	q0, [x0], #0x10
b.ne	L_a0
b	L_190
L_b4:
cmp	x8, #0x8
b.eq	L_dc
cmp	x8, #0x4
b.eq	L_d4
cmp	x8, #0x2
b.ne	L_f4
ld1r	{ v0.8h }, [x1]
b	L_e0
L_d4:
ld1r	{ v0.4s }, [x1]
b	L_e0
L_dc:
ld1r	{ v0.2d }, [x1]
L_e0:
str	q0, [sp]
mov	w8, #0x10
cmp	w19, #0x20
b.hs	L_134
b	L_150
L_f4:
sub	w8, w8, #0x3
adrp	x9, perm_idx_lut
add	x9, x9, :lo12:perm_idx_lut
add	x8, x9, w8, uxtw #2
adrp	x10, permute_table
add	x10, x10, :lo12:permute_table
ldr	q0, [x1]
ldrh	w9, [x8]
ldrh	w8, [x8, #0x2]
ldr	q1, [x10, x9]
mov	w9, #0x10
sub	w8, w9, w8
tbl	v0.16b, { v0.16b }, v1.16b
str	q0, [sp]
cmp	w19, #0x20
b.lo	L_150
L_134:
lsl	w9, w8, #1
L_138:
sub	w19, w19, w9
str	q0, [x0]
cmp	w19, #0x1f
str	q0, [x0, w8, uxtw]
add	x0, x0, x9
b.hi	L_138
L_150:
cmp	w19, #0x10
b.lo	L_174
mov	w9, w8
L_15c:
ldr	q0, [sp]
sub	w19, w19, w8
cmp	w19, #0xf
str	q0, [x0]
add	x0, x0, x9
b.hi	L_15c
L_174:
cbz	w19, L_190
mov	w20, w19
mov	x1, sp
mov	x19, x0
mov	x2, x20
bl	memcpy
add	x0, x19, x20
L_190:
ldp	x20, x19, [sp, #0x20]
ldp	x29, x30, [sp, #0x10]
add	sp, sp, #0x30
ret
L_1a0:
cbz	w19, L_190
L_1a4:
ldrb	w8, [x1], #0x1
subs	w19, w19, #0x1
strb	w8, [x0], #0x1
b.ne	L_1a4
b	L_190
inflate_fast_neon:
sub	sp, sp, #0xf0
stp	x22, x21, [sp, #0xd0]
ldr	x21, [x0, #0x38]
ldr	w8, [x0, #0x20]
stp	x24, x23, [sp, #0xc0]
mov	w13, wzr
ldr	w9, [x0, #0x8]
ldp	w23, w11, [x21, #0x60]
stp	x20, x19, [sp, #0xe0]
sub	w10, w1, w8
sub	w9, w9, #0xe
ldr	x20, [x0, #0x18]
ldr	w12, [x21, #0x78]
stp	x28, x27, [sp, #0xa0]
ldr	x22, [x0]
mov	w27, #-0x1
stp	x26, x25, [sp, #0xb0]
sub	x16, x20, x10
lsl	w10, w27, w11
lsl	w11, w27, w12
ldp	x3, x28, [x21, #0x50]
add	x25, x22, x9
sub	w9, w8, #0x103
ldr	w14, [x21, #0x40]
ldr	w18, [x21, #0x4c]
stp	x29, x30, [sp, #0x90]
add	x29, sp, #0x90
add	x17, x20, x9
mvn	w4, w10
mvn	w5, w11
stur	w14, [x29, #-0x24]
cbz	w14, L_254
cmp	x20, x3
b.lo	L_254
ldr	w9, [x21, #0x44]
add	x10, x20, #0x104
add	x9, x3, x9
cmp	x10, x9
cset	w13, ls
L_254:
ldp	x24, x7, [x21, #0x68]
add	x2, x20, x8
ldr	w6, [x21, #0x48]
add	x30, x3, #0x10
mov	w26, #-0x3
adrp	x1, perm_idx_lut
add	x1, x1, :lo12:perm_idx_lut
stur	w13, [x29, #-0x14]
L_274:
ldr	x8, [x22]
ubfx	w11, w23, #3, #3
lsl	x8, x8, x23
sub	x11, x22, x11
add	x22, x11, #0x7
orr	w11, w23, #0x38
orr	x10, x8, x28
and	x8, x10, x4
add	x8, x24, x8, lsl #2
ldrb	w9, [x8]
cbnz	w9, L_2cc
ldrb	w9, [x8, #0x2]
mov	x12, x20
strb	w9, [x12], #0x1
ldrb	w13, [x8, #0x1]
lsr	x10, x10, x13
sub	w11, w11, w13
and	x8, x10, x4
add	x8, x24, x8, lsl #2
ldrb	w9, [x8]
cbz	w9, L_4a0
mov	x20, x12
L_2cc:
ldrb	w12, [x8, #0x1]
mov	x19, x20
lsr	x28, x10, x12
sub	w23, w11, w12
L_2dc:
tbnz	w9, #0x4, L_330
tbnz	w9, #0x6, L_179c
ldrh	w8, [x8, #0x2]
lsl	w9, w27, w9
add	x8, x24, x8, lsl #2
mvn	w9, w9
and	x9, x28, x9
add	x8, x8, x9, lsl #2
ldrb	w10, [x8, #0x1]
ldrb	w9, [x8]
lsr	x28, x28, x10
sub	w23, w23, w10
cbnz	w9, L_2dc
L_310:
ldrb	w8, [x8, #0x2]
strb	w8, [x19], #0x1
L_318:
mov	x20, x19
L_31c:
cmp	x22, x25
b.hs	L_17e0
cmp	x20, x17
b.lo	L_274
b	L_17e0
L_330:
and	w9, w9, #0xf
sub	w12, w23, w9
lsr	x10, x28, x9
cmp	w12, #0x1b
b.hi	L_364
ldr	x11, [x22]
lsr	w13, w12, #3
lsl	x11, x11, x12
sub	x13, x22, x13
orr	w12, w12, #0x38
add	x22, x13, #0x7
orr	x14, x11, x10
b	L_368
L_364:
mov	x14, x10
L_368:
and	x10, x10, x5
add	x11, x7, x10, lsl #2
ldrh	w10, [x8, #0x2]
ldrb	w15, [x11, #0x1]
ldrb	w13, [x11]
lsr	x8, x14, x15
sub	w23, w12, w15
tbnz	w13, #0x4, L_3b8
L_388:
tbnz	w13, #0x6, L_17c4
ldrh	w11, [x11, #0x2]
lsl	w12, w27, w13
add	x11, x7, x11, lsl #2
mvn	w12, w12
and	x12, x8, x12
add	x11, x11, x12, lsl #2
ldrb	w12, [x11, #0x1]
ldrb	w13, [x11]
lsr	x8, x8, x12
sub	w23, w23, w12
tbz	w13, #0x4, L_388
L_3b8:
and	w12, w13, #0xf
lsl	w9, w27, w9
ldrh	w11, [x11, #0x2]
lsl	w13, w27, w12
stur	x25, [x29, #-0x20]
sub	w23, w23, w12
mvn	w9, w9
mvn	w13, w13
and	x9, x28, x9
lsr	x28, x8, x12
and	x13, x8, x13
add	x20, x9, x10
add	x25, x13, x11
sub	w11, w19, w16
subs	w8, w25, w11
b.ls	L_4d8
cmp	w8, w6
b.hi	L_1840
stur	x16, [x29, #-0x30]
cbz	w18, L_654
subs	w9, w18, w8
b.hs	L_65c
ldur	w9, [x29, #-0x24]
sub	w8, w8, w18
subs	w14, w20, w8
sub	w10, w9, w8
add	x1, x3, x10
b.ls	L_660
subs	x9, x19, x1
b.eq	L_cf8
sub	x11, x2, x19
cmp	x8, x11
csel	x20, x8, x11, lo
subs	x8, x2, x1
cneg	x8, x8, mi
cmp	x11, #0x10
b.lo	L_1668
cmp	x8, #0xf
b.ls	L_1668
cmp	x9, #0x0
str	w14, [sp]
cneg	x8, x9, mi
str	x30, [sp, #0x28]
stur	x7, [x29, #-0x40]
str	w6, [sp, #0x24]
stp	x17, x5, [sp, #0x30]
stp	x4, x22, [sp, #0x10]
str	x0, [sp, #0x48]
tbz	x9, #0x3f, L_e90
cmp	x8, x20
b.hs	L_e90
mov	x0, x19
stur	x2, [x29, #-0x38]
mov	x2, x20
mov	w26, w18
mov	x22, x3
bl	memmove
b	L_1508
L_4a0:
ldrb	w9, [x8, #0x2]
add	x19, x20, #0x2
strb	w9, [x20, #0x1]
ldrb	w12, [x8, #0x1]
lsr	x10, x10, x12
and	x8, x10, x4
add	x8, x24, x8, lsl #2
ldrb	w13, [x8, #0x1]
ldrb	w9, [x8]
lsr	x28, x10, x13
sub	w10, w11, w12
sub	w23, w10, w13
cbnz	w9, L_2dc
b	L_310
L_4d8:
ldur	w8, [x29, #-0x14]
cbz	w8, L_60c
sub	x8, x2, x19
stp	x2, x16, [x29, #-0x38]
neg	x9, x25
cmp	x20, x8
sub	x1, x19, x25
csel	x2, x20, x8, lo
cmp	x2, x9
add	x8, x1, x2
add	x20, x19, x2
ccmp	x25, #0x0, #0x0, gt
ccmp	x19, x8, #0x0, ne
b.hs	L_770
cbz	x25, L_7d0
cbnz	x2, L_534
L_518:
mov	x20, x19
b	L_7d0
L_520:
mov	x10, x1
mov	x19, x13
L_528:
sub	x2, x2, x8
mov	x1, x10
cbz	x2, L_518
L_534:
cmp	x25, x2
csel	x8, x25, x2, lo
mov	x9, x8
cmp	x8, #0x10
b.lo	L_55c
L_548:
ldr	q0, [x1], #0x10
sub	x9, x9, #0x10
cmp	x9, #0xf
str	q0, [x19], #0x10
b.hi	L_548
L_55c:
subs	x10, x9, #0x8
b.lo	L_570
ldr	x9, [x1], #0x8
str	x9, [x19], #0x8
mov	x9, x10
L_570:
subs	x10, x9, #0x4
b.lo	L_590
ldr	w9, [x1], #0x4
str	w9, [x19], #0x4
mov	x13, x19
mov	x9, x10
cbnz	x9, L_598
b	L_520
L_590:
mov	x13, x19
cbz	x9, L_520
L_598:
cmp	x9, #0x20
b.lo	L_5ec
sub	x10, x13, x1
cmp	x10, #0x20
b.lo	L_5ec
and	x12, x9, #0xffffffffffffffe0
and	x11, x9, #0x1f
add	x14, x1, #0x10
add	x19, x13, x12
add	x10, x1, x12
add	x13, x13, #0x10
mov	x15, x12
L_5c8:
ldp	q0, q1, [x14, #-0x10]
subs	x15, x15, #0x20
add	x14, x14, #0x20
stp	q0, q1, [x13, #-0x10]
add	x13, x13, #0x20
b.ne	L_5c8
cmp	x9, x12
b.ne	L_5f8
b	L_528
L_5ec:
mov	x11, x9
mov	x19, x13
mov	x10, x1
L_5f8:
ldrb	w9, [x10], #0x1
subs	x11, x11, #0x1
strb	w9, [x19], #0x1
b.ne	L_5f8
b	L_528
L_60c:
cmp	x20, x25
neg	x8, x25
ccmp	x25, #0x10, #0x2, hi
b.lo	L_7e4
sub	w9, w20, #0x1
ldr	q0, [x19, x8]
and	w9, w9, #0xf
add	w10, w9, #0x1
str	q0, [x19]
subs	w9, w20, w10
add	x20, x19, x10
b.eq	L_c98
ldur	x25, [x29, #-0x20]
L_640:
ldr	q0, [x20, x8]
subs	w9, w9, #0x10
str	q0, [x20], #0x10
b.ne	L_640
b	L_31c
L_654:
ldur	w9, [x29, #-0x24]
sub	w9, w9, w8
L_65c:
add	x1, x3, x9
L_660:
mov	w14, w20
L_664:
subs	w26, w14, w8
b.ls	L_6d8
ldur	w9, [x29, #-0x14]
mov	w8, w8
str	x0, [sp, #0x48]
stp	x17, x5, [sp, #0x30]
stur	x2, [x29, #-0x38]
str	w6, [sp, #0x24]
stur	x7, [x29, #-0x40]
str	x30, [sp, #0x28]
tbz	w9, #0x0, L_808
sub	x9, x2, x19
str	w18, [sp, #0xc]
cmp	x8, x9
str	x3, [sp, #0x40]
csel	x2, x8, x9, lo
cmp	x19, x1
str	x4, [sp, #0x10]
add	x8, x1, x2
add	x20, x19, x2
ccmp	x19, x8, #0x2, hs
cset	w8, lo
cmp	x1, x20
ccmp	x1, x19, #0x0, lo
b.hs	L_8fc
tbnz	w8, #0x0, L_8fc
mov	x0, x19
bl	memcpy
b	L_914
L_6d8:
ldur	w9, [x29, #-0x14]
mov	w8, w14
cbz	w9, L_864
sub	x9, x2, x19
stur	x2, [x29, #-0x38]
ldur	x25, [x29, #-0x20]
cmp	x8, x9
csel	x2, x8, x9, lo
cmp	x19, x1
add	x8, x1, x2
add	x20, x19, x2
ccmp	x19, x8, #0x2, hs
cset	w8, lo
cmp	x1, x20
ccmp	x1, x19, #0x0, lo
b.hs	L_b4c
tbnz	w8, #0x0, L_b4c
stp	x3, x0, [sp, #0x40]
mov	x0, x19
mov	x25, x4
stp	x17, x5, [sp, #0x30]
mov	w19, w6
mov	x26, x30
str	w18, [sp, #0xc]
stur	x7, [x29, #-0x40]
bl	memcpy
ldp	x7, x2, [x29, #-0x40]
mov	x4, x25
ldp	x5, x3, [sp, #0x38]
mov	x30, x26
ldur	x25, [x29, #-0x20]
ldr	w18, [sp, #0xc]
mov	w6, w19
ldr	x17, [sp, #0x30]
ldr	x0, [sp, #0x48]
mov	w26, #-0x3
ldur	x16, [x29, #-0x30]
b	L_1440
L_770:
stp	x3, x0, [sp, #0x40]
mov	x0, x19
mov	x19, x17
mov	w26, w18
str	x21, [sp]
mov	x25, x4
str	x22, [sp, #0x18]
mov	x27, x5
mov	w21, w6
stur	x7, [x29, #-0x40]
mov	x22, x30
bl	memcpy
ldp	x3, x0, [sp, #0x40]
mov	x30, x22
ldur	x7, [x29, #-0x40]
mov	w6, w21
ldr	x22, [sp, #0x18]
ldr	x21, [sp]
mov	x5, x27
mov	w27, #-0x1
mov	x4, x25
mov	w18, w26
mov	w26, #-0x3
mov	x17, x19
L_7d0:
ldp	x2, x16, [x29, #-0x38]
adrp	x1, perm_idx_lut
add	x1, x1, :lo12:perm_idx_lut
ldur	x25, [x29, #-0x20]
b	L_31c
L_7e4:
cmp	x25, #0x3
b.gt	L_8e0
cmp	x25, #0x1
b.eq	L_d34
cmp	x25, #0x2
b.ne	L_d00
add	x8, x19, x8
ld1r	{ v0.8h }, [x8]
b	L_db4
L_808:
subs	x9, x19, x1
b.eq	L_ca0
sub	x10, x2, x19
cmp	x8, x10
csel	x20, x8, x10, lo
subs	x8, x2, x1
cneg	x8, x8, mi
cmp	x10, #0x10
b.lo	L_1544
cmp	x8, #0xf
b.ls	L_1544
cmp	x9, #0x0
stp	x4, x22, [sp, #0x10]
cneg	x8, x9, mi
tbz	x9, #0x3f, L_cb0
cmp	x8, x20
b.hs	L_cb0
mov	x0, x19
mov	x2, x20
str	w18, [sp, #0xc]
mov	x22, x3
bl	memmove
b	L_10fc
L_864:
ldur	x25, [x29, #-0x20]
subs	x9, x19, x1
mov	w26, #-0x3
b.eq	L_ca8
sub	x10, x2, x19
cmp	x8, x10
csel	x20, x8, x10, lo
subs	x8, x2, x1
cneg	x8, x8, mi
cmp	x10, #0x10
b.lo	L_15a4
cmp	x8, #0xf
b.ls	L_15a4
cmp	x9, #0x0
str	x30, [sp, #0x28]
cneg	x8, x9, mi
stur	x7, [x29, #-0x40]
str	w6, [sp, #0x24]
stp	x5, x3, [sp, #0x38]
str	x4, [sp, #0x10]
str	x17, [sp, #0x30]
str	x0, [sp, #0x48]
tbz	x9, #0x3f, L_cd4
cmp	x8, x20
b.hs	L_cd4
mov	x0, x19
mov	x26, x2
mov	x2, x20
mov	w25, w18
bl	memmove
b	L_140c
L_8e0:
cmp	x25, #0x4
b.eq	L_dac
cmp	x25, #0x8
b.ne	L_d00
add	x8, x19, x8
ld1r	{ v0.2d }, [x8]
b	L_db4
L_8fc:
cmp	x19, x1
b.eq	L_914
subs	x8, x1, x19
mov	x20, x19
cneg	x8, x8, mi
cbnz	x2, L_a74
L_914:
ldur	x8, [x29, #-0x38]
sub	x1, x20, x25
sub	x8, x8, x20
cmp	x26, x8
csel	x2, x26, x8, lo
add	x8, x1, x2
cmp	x20, x8
b.hs	L_c5c
ldp	x3, x0, [sp, #0x40]
mov	w26, #-0x3
ldp	x17, x5, [sp, #0x30]
ldur	x19, [x29, #-0x20]
ldr	w18, [sp, #0xc]
ldr	x4, [sp, #0x10]
ldr	w6, [sp, #0x24]
ldur	x7, [x29, #-0x40]
ldr	x30, [sp, #0x28]
cbnz	x2, L_984
L_95c:
ldp	x2, x16, [x29, #-0x38]
adrp	x1, perm_idx_lut
add	x1, x1, :lo12:perm_idx_lut
mov	x25, x19
b	L_31c
L_970:
mov	x10, x1
mov	x20, x13
L_978:
sub	x2, x2, x8
mov	x1, x10
cbz	x2, L_95c
L_984:
cmp	x25, x2
csel	x8, x25, x2, lo
mov	x9, x8
cmp	x8, #0x10
b.lo	L_9ac
L_998:
ldr	q0, [x1], #0x10
sub	x9, x9, #0x10
cmp	x9, #0xf
str	q0, [x20], #0x10
b.hi	L_998
L_9ac:
subs	x10, x9, #0x8
b.lo	L_9c0
ldr	x9, [x1], #0x8
str	x9, [x20], #0x8
mov	x9, x10
L_9c0:
subs	x10, x9, #0x4
b.lo	L_9e0
ldr	w9, [x1], #0x4
str	w9, [x20], #0x4
mov	x13, x20
mov	x9, x10
cbnz	x9, L_9e8
b	L_970
L_9e0:
mov	x13, x20
cbz	x9, L_970
L_9e8:
cmp	x9, #0x20
b.lo	L_a3c
sub	x10, x13, x1
cmp	x10, #0x20
b.lo	L_a3c
and	x12, x9, #0xffffffffffffffe0
and	x11, x9, #0x1f
add	x14, x1, #0x10
add	x20, x13, x12
add	x10, x1, x12
add	x13, x13, #0x10
mov	x15, x12
L_a18:
ldp	q0, q1, [x14, #-0x10]
subs	x15, x15, #0x20
add	x14, x14, #0x20
stp	q0, q1, [x13, #-0x10]
add	x13, x13, #0x20
b.ne	L_a18
cmp	x9, x12
b.ne	L_a48
b	L_978
L_a3c:
mov	x11, x9
mov	x20, x13
mov	x10, x1
L_a48:
ldrb	w9, [x10], #0x1
subs	x11, x11, #0x1
strb	w9, [x20], #0x1
b.ne	L_a48
b	L_978
L_a5c:
mov	x11, x1
mov	x20, x19
L_a64:
sub	x2, x2, x9
mov	x19, x20
mov	x1, x11
cbz	x2, L_914
L_a74:
cmp	x8, x2
csel	x9, x8, x2, lo
mov	x10, x9
cmp	x9, #0x10
b.lo	L_a9c
L_a88:
ldr	q0, [x1], #0x10
sub	x10, x10, #0x10
cmp	x10, #0xf
str	q0, [x19], #0x10
b.hi	L_a88
L_a9c:
subs	x11, x10, #0x8
b.lo	L_ac0
ldr	x10, [x1], #0x8
str	x10, [x19], #0x8
mov	x10, x11
subs	x11, x10, #0x4
b.hs	L_ac8
L_ab8:
cbnz	x10, L_ad8
b	L_a5c
L_ac0:
subs	x11, x10, #0x4
b.lo	L_ab8
L_ac8:
ldr	w10, [x1], #0x4
str	w10, [x19], #0x4
mov	x10, x11
cbz	x10, L_a5c
L_ad8:
cmp	x10, #0x20
b.lo	L_b2c
sub	x11, x19, x1
cmp	x11, #0x20
b.lo	L_b2c
and	x13, x10, #0xffffffffffffffe0
and	x12, x10, #0x1f
add	x14, x1, #0x10
add	x20, x19, x13
add	x11, x1, x13
add	x15, x19, #0x10
mov	x16, x13
L_b08:
ldp	q0, q1, [x14, #-0x10]
subs	x16, x16, #0x20
add	x14, x14, #0x20
stp	q0, q1, [x15, #-0x10]
add	x15, x15, #0x20
b.ne	L_b08
cmp	x10, x13
b.ne	L_b38
b	L_a64
L_b2c:
mov	x12, x10
mov	x20, x19
mov	x11, x1
L_b38:
ldrb	w10, [x11], #0x1
subs	x12, x12, #0x1
strb	w10, [x20], #0x1
b.ne	L_b38
b	L_a64
L_b4c:
cmp	x19, x1
mov	w26, #-0x3
b.eq	L_b68
subs	x8, x1, x19
cneg	x8, x8, mi
cbnz	x2, L_b84
L_b64:
mov	x20, x19
L_b68:
ldp	x2, x16, [x29, #-0x38]
b	L_1440
L_b70:
mov	x11, x1
mov	x19, x14
L_b78:
sub	x2, x2, x9
mov	x1, x11
cbz	x2, L_b64
L_b84:
cmp	x8, x2
csel	x9, x8, x2, lo
mov	x10, x9
cmp	x9, #0x10
b.lo	L_bac
L_b98:
ldr	q0, [x1], #0x10
sub	x10, x10, #0x10
cmp	x10, #0xf
str	q0, [x19], #0x10
b.hi	L_b98
L_bac:
subs	x11, x10, #0x8
b.lo	L_bc0
ldr	x10, [x1], #0x8
str	x10, [x19], #0x8
mov	x10, x11
L_bc0:
subs	x11, x10, #0x4
b.lo	L_be0
ldr	w10, [x1], #0x4
str	w10, [x19], #0x4
mov	x14, x19
mov	x10, x11
cbnz	x10, L_be8
b	L_b70
L_be0:
mov	x14, x19
cbz	x10, L_b70
L_be8:
cmp	x10, #0x20
b.lo	L_c3c
sub	x11, x14, x1
cmp	x11, #0x20
b.lo	L_c3c
and	x13, x10, #0xffffffffffffffe0
and	x12, x10, #0x1f
add	x15, x1, #0x10
add	x19, x14, x13
add	x11, x1, x13
add	x14, x14, #0x10
mov	x16, x13
L_c18:
ldp	q0, q1, [x15, #-0x10]
subs	x16, x16, #0x20
add	x15, x15, #0x20
stp	q0, q1, [x14, #-0x10]
add	x14, x14, #0x20
b.ne	L_c18
cmp	x10, x13
b.ne	L_c48
b	L_b78
L_c3c:
mov	x12, x10
mov	x19, x14
mov	x11, x1
L_c48:
ldrb	w10, [x11], #0x1
subs	x12, x12, #0x1
strb	w10, [x19], #0x1
b.ne	L_c48
b	L_b78
L_c5c:
mov	x0, x20
add	x19, x20, x2
bl	memcpy
ldp	x3, x0, [sp, #0x40]
mov	x20, x19
ldp	x17, x5, [sp, #0x30]
mov	w26, #-0x3
ldp	x2, x16, [x29, #-0x38]
ldur	x25, [x29, #-0x20]
ldr	w18, [sp, #0xc]
ldr	x4, [sp, #0x10]
ldr	w6, [sp, #0x24]
ldur	x7, [x29, #-0x40]
ldr	x30, [sp, #0x28]
b	L_1440
L_c98:
ldur	x25, [x29, #-0x20]
b	L_31c
L_ca0:
add	x8, x19, x8
b	L_1128
L_ca8:
add	x20, x19, x8
b	L_1440
L_cb0:
cmp	x8, #0x1
b.ne	L_eb8
ldrb	w1, [x1]
mov	x0, x19
mov	x2, x20
str	w18, [sp, #0xc]
mov	x22, x3
bl	memset
b	L_10fc
L_cd4:
cmp	x8, #0x1
b.ne	L_f04
ldrb	w1, [x1]
mov	x0, x19
mov	x26, x2
mov	x2, x20
mov	w25, w18
bl	memset
b	L_140c
L_cf8:
add	x19, x19, x8
b	L_1538
L_d00:
add	w9, w25, w26
ldr	q0, [x19, x8]
adrp	x8, permute_table
add	x8, x8, :lo12:permute_table
add	x9, x1, w9, uxtw #2
ldrh	w10, [x9]
ldr	q1, [x8, x10]
ldrh	w8, [x9, #0x2]
mov	w9, #0x10
tbl	v0.16b, { v0.16b }, v1.16b
sub	w8, w9, w8
stur	q0, [x29, #-0x10]
b	L_dbc
L_d34:
ldrb	w1, [x19, x8]
str	x0, [sp, #0x48]
mov	x0, x19
stp	x2, x16, [x29, #-0x38]
mov	x2, x20
mov	x25, x17
mov	w26, w18
str	x21, [sp]
mov	x21, x4
str	x22, [sp, #0x18]
mov	w22, w6
mov	x27, x30
stp	x5, x3, [sp, #0x38]
stur	x7, [x29, #-0x40]
bl	memset
ldp	x7, x2, [x29, #-0x40]
mov	w6, w22
ldp	x5, x3, [sp, #0x38]
mov	x4, x21
ldr	x22, [sp, #0x18]
ldr	x21, [sp]
adrp	x1, perm_idx_lut
add	x1, x1, :lo12:perm_idx_lut
ldur	x16, [x29, #-0x30]
mov	x30, x27
mov	w27, #-0x1
mov	w18, w26
mov	w26, #-0x3
mov	x17, x25
b	L_e80
L_dac:
add	x8, x19, x8
ld1r	{ v0.4s }, [x8]
L_db4:
stur	q0, [x29, #-0x10]
mov	w8, #0x10
L_dbc:
cmp	x20, #0x20
mov	w9, w8
b.lo	L_de4
lsl	w10, w8, #1
L_dcc:
sub	w20, w20, w10
str	q0, [x19]
cmp	w20, #0x1f
str	q0, [x19, x9]
add	x19, x19, x10
b.hi	L_dcc
L_de4:
cmp	w20, #0x10
b.lo	L_e04
L_dec:
ldur	q0, [x29, #-0x10]
sub	w20, w20, w8
cmp	w20, #0xf
str	q0, [x19]
add	x19, x19, x9
b.hi	L_dec
L_e04:
cbz	w20, L_e88
mov	w20, w20
sub	x1, x29, #0x10
str	x0, [sp, #0x48]
mov	x0, x19
stp	x2, x16, [x29, #-0x38]
mov	x2, x20
mov	x26, x17
mov	w25, w18
str	x21, [sp]
str	x22, [sp, #0x18]
mov	x21, x4
mov	w22, w6
stp	x5, x3, [sp, #0x38]
mov	x27, x30
stur	x7, [x29, #-0x40]
bl	memcpy
ldp	x7, x2, [x29, #-0x40]
mov	w6, w22
ldp	x5, x3, [sp, #0x38]
mov	x4, x21
ldr	x22, [sp, #0x18]
ldr	x21, [sp]
adrp	x1, perm_idx_lut
add	x1, x1, :lo12:perm_idx_lut
ldur	x16, [x29, #-0x30]
mov	x30, x27
mov	w27, #-0x1
mov	w18, w25
mov	x17, x26
mov	w26, #-0x3
L_e80:
ldr	x0, [sp, #0x48]
add	x19, x19, x20
L_e88:
ldur	x25, [x29, #-0x20]
b	L_318
L_e90:
cmp	x8, #0x1
b.ne	L_f60
ldrb	w1, [x1]
mov	x0, x19
stur	x2, [x29, #-0x38]
mov	x2, x20
mov	w26, w18
mov	x22, x3
bl	memset
b	L_1508
L_eb8:
cmp	x8, #0x10
b.lo	L_fc8
sub	w8, w20, #0x1
ldr	q0, [x1]
ldur	x7, [x29, #-0x40]
and	w8, w8, #0xf
ldp	x30, x17, [sp, #0x28]
ldp	x4, x22, [sp, #0x10]
add	w9, w8, #0x1
subs	w8, w20, w9
str	q0, [x19]
add	x19, x19, x9
b.eq	L_1124
add	x9, x1, x9
L_ef0:
ldr	q0, [x9], #0x10
subs	w8, w8, #0x10
str	q0, [x19], #0x10
b.ne	L_ef0
b	L_1124
L_f04:
cmp	x8, #0x10
b.lo	L_fe8
sub	w8, w20, #0x1
ldr	q0, [x1]
ldur	x16, [x29, #-0x30]
and	w8, w8, #0xf
ldp	x3, x0, [sp, #0x40]
ldp	x17, x5, [sp, #0x30]
add	w9, w8, #0x1
ldr	x4, [sp, #0x10]
ldr	w6, [sp, #0x24]
subs	w8, w20, w9
ldur	x7, [x29, #-0x40]
ldr	x30, [sp, #0x28]
str	q0, [x19]
add	x19, x19, x9
b.eq	L_143c
add	x9, x1, x9
L_f4c:
ldr	q0, [x9], #0x10
subs	w8, w8, #0x10
str	q0, [x19], #0x10
b.ne	L_f4c
b	L_143c
L_f60:
cmp	x8, #0x10
b.lo	L_1008
sub	w8, w20, #0x1
ldr	q0, [x1]
ldr	x0, [sp, #0x48]
and	w9, w8, #0xf
ldp	x17, x5, [sp, #0x30]
ldp	x4, x22, [sp, #0x10]
add	w8, w9, #0x1
ldur	x16, [x29, #-0x30]
ldr	w6, [sp, #0x24]
cmp	w20, w8
ldur	x7, [x29, #-0x40]
ldr	x30, [sp, #0x28]
ldr	w14, [sp]
str	q0, [x19]
add	x19, x19, x8
b.eq	L_1538
sub	w9, w9, w20
add	x8, x1, x8
add	w9, w9, #0x1
L_fb4:
ldr	q0, [x8], #0x10
adds	w9, w9, #0x10
str	q0, [x19], #0x10
b.ne	L_fb4
b	L_1538
L_fc8:
cmp	x8, #0x8
b.eq	L_1038
cmp	x8, #0x4
b.eq	L_1028
cmp	x8, #0x2
b.ne	L_1058
ld1r	{ v0.8h }, [x1]
b	L_103c
L_fe8:
cmp	x8, #0x8
b.eq	L_1048
cmp	x8, #0x4
b.eq	L_1030
cmp	x8, #0x2
b.ne	L_136c
ld1r	{ v0.8h }, [x1]
b	L_104c
L_1008:
cmp	x8, #0x8
b.eq	L_1454
cmp	x8, #0x4
b.eq	L_144c
cmp	x8, #0x2
b.ne	L_1464
ld1r	{ v0.8h }, [x1]
b	L_1458
L_1028:
ld1r	{ v0.4s }, [x1]
b	L_103c
L_1030:
ld1r	{ v0.4s }, [x1]
b	L_104c
L_1038:
ld1r	{ v0.2d }, [x1]
L_103c:
stur	q0, [x29, #-0x10]
mov	w8, #0x10
b	L_1094
L_1048:
ld1r	{ v0.2d }, [x1]
L_104c:
stur	q0, [x29, #-0x10]
mov	w8, #0x10
b	L_13a4
L_1058:
mov	w9, #-0x3
adrp	x10, permute_table
add	x10, x10, :lo12:permute_table
add	w8, w8, w9
adrp	x9, perm_idx_lut
add	x9, x9, :lo12:perm_idx_lut
add	x8, x9, w8, uxtw #2
ldr	q0, [x1]
ldrh	w9, [x8]
ldrh	w8, [x8, #0x2]
ldr	q1, [x10, x9]
mov	w9, #0x10
sub	w8, w9, w8
tbl	v0.16b, { v0.16b }, v1.16b
stur	q0, [x29, #-0x10]
L_1094:
cmp	x20, #0x20
b.lo	L_10b8
lsl	w9, w8, #1
L_10a0:
sub	w20, w20, w9
str	q0, [x19]
cmp	w20, #0x1f
str	q0, [x19, w8, uxtw]
add	x19, x19, x9
b.hi	L_10a0
L_10b8:
cmp	w20, #0x10
b.lo	L_10dc
mov	w9, w8
L_10c4:
ldur	q0, [x29, #-0x10]
sub	w20, w20, w8
cmp	w20, #0xf
str	q0, [x19]
add	x19, x19, x9
b.hi	L_10c4
L_10dc:
cbz	w20, L_1118
mov	w20, w20
sub	x1, x29, #0x10
mov	x0, x19
mov	x2, x20
str	w18, [sp, #0xc]
mov	x22, x3
bl	memcpy
L_10fc:
ldp	x2, x16, [x29, #-0x38]
mov	x3, x22
ldr	w6, [sp, #0x24]
ldr	x5, [sp, #0x38]
add	x19, x19, x20
ldr	w18, [sp, #0xc]
ldr	x0, [sp, #0x48]
L_1118:
ldp	x30, x17, [sp, #0x28]
ldur	x7, [x29, #-0x40]
ldp	x4, x22, [sp, #0x10]
L_1124:
mov	x8, x19
L_1128:
adrp	x1, perm_idx_lut
add	x1, x1, :lo12:perm_idx_lut
L_1130:
cmp	x25, #0xf
b.hi	L_1174
cmp	w26, w25
b.ls	L_1174
neg	x9, x25
mov	x20, x8
L_1148:
ldr	q0, [x8, x9]
mov	w10, w25
cmp	w25, #0x7
sub	w26, w26, w10
str	q0, [x20]
add	x20, x20, w25, uxtw
lsl	w25, w25, #1
b.hi	L_1178
cmp	w25, w26
b.lo	L_1148
b	L_1178
L_1174:
mov	x20, x8
L_1178:
mov	w9, w26
cbz	w25, L_1210
mov	w10, w25
sub	x12, x2, x20
ldur	x25, [x29, #-0x20]
sub	x8, x20, x10
cmp	x9, x12
csel	x19, x9, x12, lo
subs	x9, x2, x8
cneg	x11, x9, mi
cmp	x12, #0x10
neg	x9, x10
b.lo	L_1610
cmp	x11, #0xf
b.ls	L_1610
cmp	w10, #0x1
b.ne	L_1220
ldrb	w1, [x8]
mov	x0, x20
mov	x2, x19
mov	w26, w18
str	x3, [sp, #0x40]
mov	x25, x4
bl	memset
ldp	x30, x17, [sp, #0x28]
mov	x4, x25
ldp	x7, x2, [x29, #-0x40]
adrp	x1, perm_idx_lut
add	x1, x1, :lo12:perm_idx_lut
ldp	x5, x3, [sp, #0x38]
ldr	w6, [sp, #0x24]
ldur	x25, [x29, #-0x20]
mov	w18, w26
ldur	x16, [x29, #-0x30]
ldr	x0, [sp, #0x48]
add	x20, x20, x19
mov	w26, #-0x3
b	L_31c
L_1210:
ldur	x25, [x29, #-0x20]
add	x20, x20, x9
mov	w26, #-0x3
b	L_31c
L_1220:
cmp	w10, #0x10
mov	w26, #-0x3
b.lo	L_1260
sub	w10, w19, #0x1
ldr	q0, [x8]
and	w10, w10, #0xf
add	w10, w10, #0x1
str	q0, [x20]
subs	w8, w19, w10
add	x20, x20, x10
b.eq	L_31c
L_124c:
ldr	q0, [x20, x9]
subs	w8, w8, #0x10
str	q0, [x20], #0x10
b.ne	L_124c
b	L_31c
L_1260:
cmp	w10, #0x8
b.eq	L_1288
cmp	w10, #0x4
b.eq	L_1280
cmp	w10, #0x2
b.ne	L_1298
ld1r	{ v0.8h }, [x8]
b	L_128c
L_1280:
ld1r	{ v0.4s }, [x8]
b	L_128c
L_1288:
ld1r	{ v0.2d }, [x8]
L_128c:
stur	q0, [x29, #-0x10]
mov	w8, #0x10
b	L_12c8
L_1298:
add	w9, w10, w26
ldr	q0, [x8]
adrp	x8, permute_table
add	x8, x8, :lo12:permute_table
add	x9, x1, w9, uxtw #2
ldrh	w10, [x9]
ldr	q1, [x8, x10]
ldrh	w8, [x9, #0x2]
mov	w9, #0x10
tbl	v0.16b, { v0.16b }, v1.16b
sub	w8, w9, w8
stur	q0, [x29, #-0x10]
L_12c8:
cmp	x19, #0x20
b.lo	L_12ec
lsl	w9, w8, #1
L_12d4:
sub	w19, w19, w9
str	q0, [x20]
cmp	w19, #0x1f
str	q0, [x20, w8, uxtw]
add	x20, x20, x9
b.hi	L_12d4
L_12ec:
cmp	w19, #0x10
b.lo	L_1310
mov	w9, w8
L_12f8:
ldur	q0, [x29, #-0x10]
sub	w19, w19, w8
cmp	w19, #0xf
str	q0, [x20]
add	x20, x20, x9
b.hi	L_12f8
L_1310:
cbz	w19, L_31c
mov	w19, w19
sub	x1, x29, #0x10
mov	x0, x20
mov	x2, x19
mov	w26, w18
str	x3, [sp, #0x40]
mov	x25, x4
bl	memcpy
ldp	x30, x17, [sp, #0x28]
mov	x4, x25
ldp	x7, x2, [x29, #-0x40]
adrp	x1, perm_idx_lut
add	x1, x1, :lo12:perm_idx_lut
ldp	x5, x3, [sp, #0x38]
ldr	w6, [sp, #0x24]
ldur	x25, [x29, #-0x20]
mov	w18, w26
ldur	x16, [x29, #-0x30]
ldr	x0, [sp, #0x48]
mov	w26, #-0x3
add	x20, x20, x19
b	L_31c
L_136c:
add	w8, w8, w26
adrp	x9, perm_idx_lut
add	x9, x9, :lo12:perm_idx_lut
add	x8, x9, w8, uxtw #2
adrp	x10, permute_table
add	x10, x10, :lo12:permute_table
ldr	q0, [x1]
ldrh	w9, [x8]
ldrh	w8, [x8, #0x2]
ldr	q1, [x10, x9]
mov	w9, #0x10
sub	w8, w9, w8
tbl	v0.16b, { v0.16b }, v1.16b
stur	q0, [x29, #-0x10]
L_13a4:
cmp	x20, #0x20
b.lo	L_13c8
lsl	w9, w8, #1
L_13b0:
sub	w20, w20, w9
str	q0, [x19]
cmp	w20, #0x1f
str	q0, [x19, w8, uxtw]
add	x19, x19, x9
b.hi	L_13b0
L_13c8:
cmp	w20, #0x10
b.lo	L_13ec
mov	w9, w8
L_13d4:
ldur	q0, [x29, #-0x10]
sub	w20, w20, w8
cmp	w20, #0xf
str	q0, [x19]
add	x19, x19, x9
b.hi	L_13d4
L_13ec:
cbz	w20, L_1420
mov	w20, w20
sub	x1, x29, #0x10
mov	x0, x19
mov	x26, x2
mov	x2, x20
mov	w25, w18
bl	memcpy
L_140c:
mov	w18, w25
ldur	x25, [x29, #-0x20]
mov	x2, x26
mov	w26, #-0x3
add	x19, x19, x20
L_1420:
ldp	x3, x0, [sp, #0x40]
ldur	x16, [x29, #-0x30]
ldp	x17, x5, [sp, #0x30]
ldr	x4, [sp, #0x10]
ldr	w6, [sp, #0x24]
ldur	x7, [x29, #-0x40]
ldr	x30, [sp, #0x28]
L_143c:
mov	x20, x19
L_1440:
adrp	x1, perm_idx_lut
add	x1, x1, :lo12:perm_idx_lut
b	L_31c
L_144c:
ld1r	{ v0.4s }, [x1]
b	L_1458
L_1454:
ld1r	{ v0.2d }, [x1]
L_1458:
stur	q0, [x29, #-0x10]
mov	w8, #0x10
b	L_149c
L_1464:
add	w8, w8, w26
adrp	x9, perm_idx_lut
add	x9, x9, :lo12:perm_idx_lut
add	x8, x9, w8, uxtw #2
adrp	x10, permute_table
add	x10, x10, :lo12:permute_table
ldr	q0, [x1]
ldrh	w9, [x8]
ldrh	w8, [x8, #0x2]
ldr	q1, [x10, x9]
mov	w9, #0x10
sub	w8, w9, w8
tbl	v0.16b, { v0.16b }, v1.16b
stur	q0, [x29, #-0x10]
L_149c:
cmp	x20, #0x20
mov	w9, w8
b.lo	L_14c4
lsl	w10, w8, #1
L_14ac:
sub	w20, w20, w10
str	q0, [x19]
cmp	w20, #0x1f
str	q0, [x19, x9]
add	x19, x19, x10
b.hi	L_14ac
L_14c4:
cmp	w20, #0x10
b.lo	L_14e4
L_14cc:
ldur	q0, [x29, #-0x10]
sub	w20, w20, w8
cmp	w20, #0xf
str	q0, [x19]
add	x19, x19, x9
b.hi	L_14cc
L_14e4:
cbz	w20, L_1518
mov	w20, w20
sub	x1, x29, #0x10
mov	x0, x19
stur	x2, [x29, #-0x38]
mov	x2, x20
mov	w26, w18
mov	x22, x3
bl	memcpy
L_1508:
ldur	x2, [x29, #-0x38]
mov	x3, x22
mov	w18, w26
add	x19, x19, x20
L_1518:
ldp	x17, x5, [sp, #0x30]
ldr	x0, [sp, #0x48]
ldp	x4, x22, [sp, #0x10]
ldur	x16, [x29, #-0x30]
ldr	w6, [sp, #0x24]
ldur	x7, [x29, #-0x40]
ldr	x30, [sp, #0x28]
ldr	w14, [sp]
L_1538:
mov	w8, w18
mov	x1, x3
b	L_664
L_1544:
cbz	x20, L_16b0
cmp	x20, #0x20
b.lo	L_16c4
cmp	x9, #0x20
b.lo	L_16c4
and	x11, x20, #0xffffffe0
and	x10, x20, #0x1f
add	x12, x1, #0x10
add	x8, x19, x11
add	x9, x1, x11
add	x13, x19, #0x10
mov	x14, x11
L_1574:
ldp	q0, q1, [x12, #-0x10]
subs	x14, x14, #0x20
add	x12, x12, #0x20
stp	q0, q1, [x13, #-0x10]
add	x13, x13, #0x20
b.ne	L_1574
cmp	x20, x11
mov	w27, #-0x1
adrp	x1, perm_idx_lut
add	x1, x1, :lo12:perm_idx_lut
b.ne	L_16dc
b	L_1130
L_15a4:
mov	x26, x25
mov	x25, x7
mov	w7, w6
mov	x6, x2
mov	w2, w18
cbz	x20, L_16bc
mov	x10, x20
cmp	x20, #0x20
b.lo	L_16f0
cmp	x9, #0x20
b.lo	L_16f0
and	x11, x10, #0xffffffe0
and	x9, x10, #0x1f
add	x12, x1, #0x10
add	x20, x19, x11
add	x8, x1, x11
add	x13, x19, #0x10
mov	x14, x11
L_15ec:
ldp	q0, q1, [x12, #-0x10]
subs	x14, x14, #0x20
add	x12, x12, #0x20
stp	q0, q1, [x13, #-0x10]
add	x13, x13, #0x20
b.ne	L_15ec
cmp	x10, x11
b.ne	L_16fc
b	L_170c
L_1610:
mov	x26, x25
cbz	x19, L_1748
cmp	x19, #0x20
b.lo	L_1734
cmp	w10, #0x20
b.lo	L_172c
and	x11, x19, #0xffffffe0
add	x12, x20, #0x10
and	x10, x19, #0x1f
add	x20, x20, x11
add	x8, x8, x11
add	x9, x12, x9
mov	x13, x11
L_1644:
ldp	q0, q1, [x9, #-0x10]
subs	x13, x13, #0x20
add	x9, x9, #0x20
stp	q0, q1, [x12, #-0x10]
add	x12, x12, #0x20
b.ne	L_1644
cmp	x19, x11
b.ne	L_1738
b	L_1748
L_1668:
cbz	x20, L_16a0
cmp	x20, #0x20
b.lo	L_1684
sub	x8, x19, x3
sub	x8, x8, x10
cmp	x8, #0x20
b.hs	L_1758
L_1684:
mov	x9, x19
mov	x8, x20
L_168c:
mov	x19, x9
L_1690:
ldrb	w9, [x1], #0x1
subs	x8, x8, #0x1
strb	w9, [x19], #0x1
b.ne	L_1690
L_16a0:
mov	w8, w18
mov	x1, x3
mov	w27, #-0x1
b	L_664
L_16b0:
mov	x8, x19
mov	w27, #-0x1
b	L_1128
L_16bc:
mov	x20, x19
b	L_170c
L_16c4:
mov	x8, x19
mov	x9, x1
mov	x10, x20
mov	w27, #-0x1
adrp	x1, perm_idx_lut
add	x1, x1, :lo12:perm_idx_lut
L_16dc:
ldrb	w11, [x9], #0x1
subs	x10, x10, #0x1
strb	w11, [x8], #0x1
b.ne	L_16dc
b	L_1130
L_16f0:
mov	x20, x19
mov	x8, x1
mov	x9, x10
L_16fc:
ldrb	w10, [x8], #0x1
subs	x9, x9, #0x1
strb	w10, [x20], #0x1
b.ne	L_16fc
L_170c:
mov	w18, w2
mov	w27, #-0x1
mov	x2, x6
mov	w6, w7
mov	x7, x25
mov	x25, x26
mov	w26, #-0x3
b	L_1440
L_172c:
mov	x10, x19
b	L_1738
L_1734:
mov	x10, x19
L_1738:
ldrb	w9, [x8], #0x1
subs	x10, x10, #0x1
strb	w9, [x20], #0x1
b.ne	L_1738
L_1748:
mov	x25, x26
mov	w27, #-0x1
mov	w26, #-0x3
b	L_31c
L_1758:
and	x11, x20, #0xffffffe0
and	x8, x20, #0x1f
add	x10, x30, x10
add	x9, x19, x11
add	x1, x1, x11
add	x12, x19, #0x10
mov	x13, x11
L_1774:
ldp	q0, q1, [x10, #-0x10]
subs	x13, x13, #0x20
add	x10, x10, #0x20
stp	q0, q1, [x12, #-0x10]
add	x12, x12, #0x20
b.ne	L_1774
cmp	x20, x11
b.ne	L_168c
mov	x19, x9
b	L_16a0
L_179c:
tbnz	w9, #0x5, L_17b8
mov	w8, #0x3f51
adrp	x9, bums_rodata_str1_1+52
add	x9, x9, :lo12:bums_rodata_str1_1+52
str	w8, [x21, #0x8]
str	x9, [x0, #0x30]
b	L_17dc
L_17b8:
mov	w8, #0x3f3f
str	w8, [x21, #0x8]
b	L_17dc
L_17c4:
mov	w9, #0x3f51
adrp	x10, bums_rodata_str1_1+30
add	x10, x10, :lo12:bums_rodata_str1_1+30
str	w9, [x21, #0x8]
mov	x28, x8
str	x10, [x0, #0x30]
L_17dc:
mov	x20, x19
L_17e0:
lsr	w8, w23, #3
sub	w9, w17, w20
and	w10, w23, #0x7
mov	x11, #-0x1
add	w9, w9, #0x103
str	x20, [x0, #0x18]
sub	x8, x22, x8
lsl	x11, x11, x10
str	w9, [x0, #0x20]
sub	w9, w25, w8
str	x8, [x0]
add	w8, w9, #0xe
bic	x9, x28, x11
str	w8, [x0, #0x8]
ldp	x20, x19, [sp, #0xe0]
str	x9, [x21, #0x58]
ldp	x24, x23, [sp, #0xc0]
str	w10, [x21, #0x60]
ldp	x22, x21, [sp, #0xd0]
ldp	x26, x25, [sp, #0xb0]
ldp	x28, x27, [sp, #0xa0]
ldp	x29, x30, [sp, #0x90]
add	sp, sp, #0xf0
ret
L_1840:
mov	w8, #0x3f51
adrp	x9, bums_rodata_str1_1
add	x9, x9, :lo12:bums_rodata_str1_1
ldur	x25, [x29, #-0x20]
str	w8, [x21, #0x8]
mov	x20, x19
str	x9, [x0, #0x30]
b	L_17e0
	.section .rodata
perm_idx_lut:
	.size perm_idx_lut, 52
	.byte 0,0,1,0,0,0,0,0,32,0,1,0,64,0,4,0
	.byte 96,0,2,0,0,0,0,0,128,0,7,0,160,0,6,0
	.byte 192,0,5,0,224,0,4,0,0,1,3,0,32,1,2,0
	.byte 64,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0
permute_table:
	.size permute_table, 832
	.byte 0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0
	.byte 1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1
	.byte 0,1,2,3,4,0,1,2,3,4,0,1,2,3,4,0
	.byte 1,2,3,4,0,1,2,3,4,0,1,2,3,4,0,1
	.byte 0,1,2,3,4,5,0,1,2,3,4,5,0,1,2,3
	.byte 4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1
	.byte 0,1,2,3,4,5,6,0,1,2,3,4,5,6,0,1
	.byte 2,3,4,5,6,0,1,2,3,4,5,6,0,1,2,3
	.byte 0,1,2,3,4,5,6,7,8,0,1,2,3,4,5,6
	.byte 7,8,0,1,2,3,4,5,6,7,8,0,1,2,3,4
	.byte 0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5
	.byte 6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1
	.byte 0,1,2,3,4,5,6,7,8,9,10,0,1,2,3,4
	.byte 5,6,7,8,9,10,0,1,2,3,4,5,6,7,8,9
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,0,1,2,3
	.byte 4,5,6,7,8,9,10,11,0,1,2,3,4,5,6,7
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,12,0,1,2
	.byte 3,4,5,6,7,8,9,10,11,12,0,1,2,3,4,5
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,12,13,0,1
	.byte 2,3,4,5,6,7,8,9,10,11,12,13,0,1,2,3
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,0
	.byte 1,2,3,4,5,6,7,8,9,10,11,12,13,14,0,1
	.byte 16,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14
	.byte 16,17,0,1,2,3,4,5,6,7,8,9,10,11,12,13
	.byte 16,17,18,0,1,2,3,4,5,6,7,8,9,10,11,12
	.byte 16,17,18,19,0,1,2,3,4,5,6,7,8,9,10,11
	.byte 16,17,18,19,20,0,1,2,3,4,5,6,7,8,9,10
	.byte 16,17,18,19,20,21,0,1,2,3,4,5,6,7,8,9
	.byte 16,17,18,19,20,21,22,0,1,2,3,4,5,6,7,8
	.byte 16,17,18,19,20,21,22,23,0,1,2,3,4,5,6,7
	.byte 16,17,18,19,20,21,22,23,24,0,1,2,3,4,5,6
	.byte 16,17,18,19,20,21,22,23,24,25,0,1,2,3,4,5
	.byte 16,17,18,19,20,21,22,23,24,25,26,0,1,2,3,4
	.byte 16,17,18,19,20,21,22,23,24,25,26,27,0,1,2,3
	.byte 16,17,18,19,20,21,22,23,24,25,26,27,28,0,1,2
	.byte 16,17,18,19,20,21,22,23,24,25,26,27,28,29,0,1
	.byte 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.section .rodata.str1.1
bums_rodata_str1_1:
	.byte 105,110,118,97,108,105,100,32,100,105,115,116,97,110,99,101
	.byte 32,116,111,111,32,102,97,114,32,98,97,99,107,0,105,110
	.byte 118,97,108,105,100,32,100,105,115,116,97,110,99,101,32,99
	.byte 111,100,101,0,105,110,118,97,108,105,100,32,108,105,116,101
	.byte 114,97,108,47,108,101,110,103,116,104,32,99,111,100,101,0
// ---- reference memcpy: copies x1[0..x2) to x0[0..x2)
	.text
memcpy:
mov	x3, x0
cbz	x2, memcpy_done
memcpy_loop:
ldrb	w4, [x1], #1
strb	w4, [x3], #1
subs	x2, x2, #1
b.ne	memcpy_loop
memcpy_done:
ret
// ---- reference memmove: reads x1[0..x2) and writes x0[0..x2), the bytes memcpy touches
	.text
memmove:
mov	x3, x0
cbz	x2, memmove_done
memmove_loop:
ldrb	w4, [x1], #1
strb	w4, [x3], #1
subs	x2, x2, #1
b.ne	memmove_loop
memmove_done:
ret
// ---- reference memset: stores the low byte of w1 to x0[0..x2)
	.text
memset:
mov	x3, x0
cbz	x2, memset_done
memset_loop:
strb	w1, [x3], #1
subs	x2, x2, #1
b.ne	memset_loop
memset_done:
ret
