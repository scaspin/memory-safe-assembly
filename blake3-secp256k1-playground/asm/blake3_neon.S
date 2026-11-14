	.text
blake3_compress_in_place_portable:
sub	sp, sp, #0xb0
ldp	w12, w13, [x1]
ldp	w11, w6, [x0]
ldp	w5, w7, [x0, #0x10]
stp	x20, x19, [sp, #0xa0]
lsr	x17, x3, #32
and	w4, w4, #0xff
add	w11, w11, w12
stp	x26, x25, [sp, #0x70]
and	w25, w2, #0xff
ldp	w9, w10, [x1, #0x8]
add	w19, w11, w5
stp	x22, x21, [sp, #0x90]
eor	w3, w19, w3
stp	x24, x23, [sp, #0x80]
ror	w20, w3, #0x10
mov	w3, #0xe667
add	w6, w6, w9
movk	w3, #0x6a09, lsl #16
add	w6, w6, w7
stp	w9, w12, [sp, #0x30]
add	w3, w20, w3
eor	w17, w6, w17
stp	x28, x27, [sp, #0x60]
eor	w5, w3, w5
ror	w17, w17, #0x10
add	w6, w6, w10
ldp	w12, w18, [x1, #0x18]
ldp	w21, w22, [x0, #0x8]
ror	w2, w5, #0xc
add	w5, w19, w13
mov	w19, #0xae85
ldp	w23, w24, [x0, #0x18]
movk	w19, #0xbb67, lsl #16
stp	x29, x30, [sp, #0x50]
add	w5, w5, w2
ldp	w8, w16, [x1, #0x10]
add	w26, w17, w19
add	w19, w22, w12
eor	w20, w5, w20
eor	w7, w26, w7
add	w22, w19, w24
mov	w19, #0xf53a
ror	w27, w7, #0xc
add	w7, w21, w8
eor	w4, w22, w4
add	w28, w7, w23
ror	w4, w4, #0x10
movk	w19, #0xa54f, lsl #16
add	w7, w6, w27
eor	w6, w28, w25
add	w22, w22, w18
eor	w17, w7, w17
ror	w25, w6, #0x10
add	w29, w4, w19
ror	w6, w17, #0x8
mov	w17, #0xf372
eor	w19, w29, w24
movk	w17, #0x3c6e, lsl #16
ror	w19, w19, #0xc
str	w12, [sp, #0x2c]
add	w24, w25, w17
add	w21, w6, w26
mov	w12, w8
ldp	w14, w15, [x1, #0x20]
eor	w17, w24, w23
eor	w23, w21, w27
add	w26, w22, w19
ror	w27, w17, #0xc
ror	w30, w23, #0x7
add	w17, w28, w16
eor	w4, w26, w4
ror	w20, w20, #0x8
str	w14, [sp, #0xc]
add	w23, w17, w27
ror	w28, w4, #0x8
add	w17, w5, w14
eor	w4, w23, w25
add	w8, w17, w30
add	w22, w20, w3
ror	w25, w4, #0x8
eor	w4, w8, w28
eor	w2, w22, w2
ror	w9, w4, #0x10
str	x0, [sp, #0x18]
mov	w0, w10
ldp	w14, w3, [x1, #0x38]
add	w24, w25, w24
ror	w10, w2, #0x7
str	w13, [sp, #0x4c]
eor	w11, w24, w27
add	w27, w9, w24
add	w24, w28, w29
eor	w2, w27, w30
add	w26, w26, w14
add	w8, w8, w15
ror	w28, w2, #0xc
add	w26, w26, w10
str	w16, [sp, #0x38]
ldp	w17, w13, [x1, #0x28]
eor	w25, w26, w25
add	w8, w8, w28
eor	w19, w24, w19
ldp	w16, w4, [x1, #0x30]
ror	w25, w25, #0x10
ror	w11, w11, #0x7
eor	w9, w8, w9
ror	w1, w19, #0x7
ror	w19, w9, #0x8
add	w9, w7, w17
add	w30, w25, w21
add	w9, w9, w11
add	w7, w23, w16
eor	w10, w30, w10
eor	w20, w9, w20
add	w23, w7, w1
ror	w10, w10, #0xc
ror	w7, w20, #0x10
eor	w20, w23, w6
add	w21, w26, w3
ror	w26, w20, #0x10
add	w6, w19, w27
add	w20, w21, w10
add	w24, w7, w24
eor	w21, w6, w28
eor	w25, w20, w25
eor	w27, w24, w11
add	w22, w26, w22
ror	w11, w25, #0x8
ror	w25, w27, #0xc
eor	w27, w22, w1
add	w9, w9, w13
ror	w27, w27, #0xc
stp	w13, w3, [sp, #0x20]
add	w28, w11, w30
mov	w1, w13
add	w9, w9, w25
add	w23, w23, w4
eor	w10, w28, w10
ldr	w13, [sp, #0x30]
eor	w7, w9, w7
add	w23, w23, w27
ror	w10, w10, #0x7
ror	w21, w21, #0x7
ror	w7, w7, #0x8
eor	w26, w23, w26
add	w8, w8, w13
ror	w26, w26, #0x8
add	w9, w9, w0
add	w8, w8, w10
add	w29, w7, w24
add	w9, w9, w21
eor	w7, w8, w7
add	w22, w26, w22
eor	w24, w29, w25
ror	w30, w7, #0x10
eor	w7, w9, w26
eor	w25, w22, w27
ror	w7, w7, #0x10
ror	w26, w24, #0x7
ror	w25, w25, #0x7
add	w24, w30, w22
add	w20, w20, w12
str	w14, [sp, #0x48]
add	w22, w7, w28
add	w27, w20, w25
mov	w14, w15
eor	w21, w22, w21
eor	w10, w24, w10
add	w20, w23, w18
ror	w21, w21, #0xc
eor	w19, w27, w19
add	w9, w9, w17
ldr	w15, [sp, #0x2c]
ror	w10, w10, #0xc
add	w28, w20, w26
ror	w19, w19, #0x10
add	w20, w9, w21
eor	w9, w28, w11
add	w8, w8, w15
eor	w11, w20, w7
ror	w9, w9, #0x10
add	w7, w19, w29
add	w29, w8, w10
ror	w8, w11, #0x8
eor	w11, w7, w25
mov	w5, w12
mov	w12, w18
str	w18, [sp, #0x28]
eor	w25, w29, w30
add	w30, w9, w6
ror	w23, w11, #0xc
add	w6, w8, w22
ldr	w18, [sp, #0x34]
eor	w11, w30, w26
add	w22, w27, w4
eor	w21, w6, w21
ror	w11, w11, #0xc
add	w26, w22, w23
ror	w27, w21, #0x7
add	w21, w28, w18
ldr	w18, [sp, #0x4c]
eor	w19, w26, w19
add	w22, w21, w11
ror	w19, w19, #0x8
ror	w25, w25, #0x8
add	w21, w29, w18
eor	w9, w22, w9
add	w26, w26, w3
add	w28, w21, w27
ror	w9, w9, #0x8
add	w21, w25, w24
eor	w29, w28, w19
eor	w10, w21, w10
add	w19, w19, w7
ror	w29, w29, #0x10
add	w30, w9, w30
ror	w10, w10, #0x7
eor	w11, w30, w11
add	w7, w28, w1
eor	w23, w19, w23
add	w24, w29, w30
add	w26, w26, w10
ror	w11, w11, #0x7
eor	w27, w24, w27
eor	w9, w26, w9
ror	w23, w23, #0x7
ror	w27, w27, #0xc
ror	w9, w9, #0x10
add	w20, w20, w16
add	w30, w20, w11
ldr	w2, [sp, #0xc]
mov	w3, w14
add	w28, w7, w27
eor	w20, w30, w25
ldr	w18, [sp, #0x48]
eor	w7, w28, w29
add	w29, w9, w6
add	w6, w22, w14
eor	w10, w29, w10
add	w22, w6, w23
ror	w7, w7, #0x8
ror	w10, w10, #0xc
ror	w25, w20, #0x10
eor	w8, w22, w8
add	w20, w26, w2
ror	w8, w8, #0x10
add	w6, w7, w24
add	w20, w20, w10
add	w26, w25, w19
eor	w24, w6, w27
eor	w9, w20, w9
eor	w11, w26, w11
add	w27, w8, w21
ror	w19, w9, #0x8
ror	w9, w11, #0xc
eor	w11, w27, w23
ldr	w14, [sp, #0x38]
ror	w11, w11, #0xc
add	w22, w22, w18
add	w29, w19, w29
ror	w21, w24, #0x7
add	w20, w20, w12
add	w23, w30, w14
eor	w10, w29, w10
add	w22, w22, w11
add	w23, w23, w9
ror	w10, w10, #0x7
eor	w8, w22, w8
eor	w24, w23, w25
add	w25, w28, w0
ror	w8, w8, #0x8
ror	w24, w24, #0x8
add	w23, w23, w17
add	w25, w25, w10
add	w23, w23, w21
add	w27, w8, w27
str	w0, [sp, #0x44]
add	w26, w24, w26
eor	w24, w25, w24
eor	w8, w23, w8
ror	w28, w24, #0x10
eor	w11, w27, w11
ror	w8, w8, #0x10
ror	w11, w11, #0x7
eor	w9, w26, w9
mov	w0, w4
add	w24, w28, w27
add	w27, w8, w29
ror	w9, w9, #0x7
eor	w21, w27, w21
add	w29, w20, w11
add	w20, w22, w4
ror	w21, w21, #0xc
eor	w7, w29, w7
add	w22, w23, w16
add	w30, w20, w9
ror	w7, w7, #0x10
eor	w10, w24, w10
add	w20, w22, w21
eor	w19, w30, w19
ror	w10, w10, #0xc
eor	w22, w20, w8
ror	w19, w19, #0x10
add	w8, w7, w26
add	w23, w25, w5
ror	w26, w22, #0x8
eor	w11, w8, w11
add	w25, w23, w10
add	w6, w19, w6
ror	w23, w11, #0xc
add	w11, w26, w27
eor	w9, w6, w9
add	w22, w29, w18
eor	w21, w11, w21
ror	w9, w9, #0xc
add	w27, w22, w23
ror	w29, w21, #0x7
add	w21, w30, w13
eor	w7, w27, w7
eor	w28, w25, w28
add	w22, w21, w9
ror	w7, w7, #0x8
add	w21, w25, w15
ror	w25, w28, #0x8
eor	w19, w22, w19
add	w28, w21, w29
ror	w19, w19, #0x8
add	w27, w27, w2
eor	w30, w28, w7
add	w21, w25, w24
add	w8, w7, w8
ror	w30, w30, #0x10
eor	w10, w21, w10
add	w6, w19, w6
ror	w10, w10, #0x7
eor	w9, w6, w9
add	w7, w28, w14
add	w24, w30, w6
eor	w23, w8, w23
ror	w9, w9, #0x7
eor	w29, w24, w29
add	w6, w27, w10
ldr	w4, [sp, #0x20]
ror	w29, w29, #0xc
eor	w19, w6, w19
ror	w23, w23, #0x7
ror	w19, w19, #0x10
add	w20, w20, w3
ldr	w12, [sp, #0x4c]
add	w27, w7, w29
add	w28, w20, w9
add	w20, w22, w4
eor	w7, w27, w30
add	w11, w19, w11
eor	w22, w28, w25
ror	w7, w7, #0x8
add	w25, w20, w23
eor	w10, w11, w10
eor	w20, w25, w26
ror	w10, w10, #0xc
add	w26, w6, w12
add	w6, w7, w24
ror	w24, w20, #0x10
ror	w22, w22, #0x10
add	w20, w26, w10
eor	w26, w6, w29
ldr	w13, [sp, #0x24]
add	w29, w24, w21
add	w8, w22, w8
eor	w19, w20, w19
eor	w23, w29, w23
mov	w1, w16
eor	w9, w8, w9
ror	w19, w19, #0x8
ldr	w16, [sp, #0x34]
ror	w23, w23, #0xc
ror	w9, w9, #0xc
add	w25, w25, w13
ror	w21, w26, #0x7
add	w26, w28, w16
add	w11, w19, w11
add	w25, w25, w23
add	w26, w26, w9
eor	w10, w11, w10
eor	w24, w25, w24
eor	w22, w26, w22
ror	w10, w10, #0x7
ror	w24, w24, #0x8
add	w26, w26, w1
ror	w22, w22, #0x8
add	w27, w27, w17
add	w26, w26, w21
add	w27, w27, w10
add	w28, w24, w29
eor	w24, w26, w24
add	w8, w22, w8
eor	w22, w27, w22
eor	w23, w28, w23
ror	w29, w24, #0x10
ror	w22, w22, #0x10
ror	w23, w23, #0x7
eor	w9, w8, w9
add	w20, w20, w0
add	w11, w29, w11
ror	w9, w9, #0x7
add	w24, w22, w28
eor	w21, w11, w21
add	w28, w20, w23
mov	w15, w3
ror	w21, w21, #0xc
add	w20, w25, w18
eor	w7, w28, w7
add	w25, w26, w3
add	w26, w20, w9
ror	w30, w7, #0x10
str	w17, [sp, #0x10]
eor	w10, w24, w10
mov	w17, w18
ldr	w18, [sp, #0x28]
add	w20, w25, w21
eor	w7, w26, w19
ror	w10, w10, #0xc
eor	w19, w20, w29
ror	w29, w7, #0x10
add	w7, w30, w8
add	w27, w27, w18
ror	w19, w19, #0x8
eor	w23, w7, w23
add	w8, w27, w10
add	w27, w29, w6
ror	w23, w23, #0xc
stp	w0, w1, [sp, #0x3c]
mov	w3, w0
mov	w0, w15
add	w6, w19, w11
eor	w9, w27, w9
add	w11, w28, w13
ldr	w15, [sp, #0x44]
eor	w21, w6, w21
ror	w9, w9, #0xc
add	w11, w11, w23
eor	w25, w8, w22
ror	w28, w21, #0x7
add	w21, w26, w15
eor	w26, w11, w30
add	w22, w21, w9
ror	w26, w26, #0x8
add	w8, w8, w5
ror	w25, w25, #0x8
eor	w21, w22, w29
add	w8, w8, w28
ror	w29, w21, #0x8
eor	w30, w8, w26
add	w11, w11, w12
add	w21, w25, w24
ror	w30, w30, #0x10
add	w26, w26, w7
eor	w10, w21, w10
add	w27, w29, w27
add	w8, w8, w16
ror	w10, w10, #0x7
add	w24, w30, w27
eor	w9, w27, w9
eor	w28, w24, w28
eor	w23, w26, w23
ror	w9, w9, #0x7
add	w11, w11, w10
ror	w27, w28, #0xc
ror	w23, w23, #0x7
eor	w7, w11, w29
str	w5, [sp, #0x8]
add	w20, w20, w4
ror	w28, w7, #0x10
add	w8, w8, w27
str	w0, [sp, #0x14]
eor	w7, w8, w30
add	w30, w20, w9
add	w8, w8, w1
add	w29, w28, w6
add	w6, w22, w14
ror	w7, w7, #0x8
ldp	w5, w15, [sp, #0x2c]
eor	w10, w29, w10
add	w22, w6, w23
eor	w20, w30, w25
ror	w10, w10, #0xc
eor	w19, w22, w19
ror	w25, w20, #0x10
add	w11, w11, w5
add	w6, w7, w24
ror	w24, w19, #0x10
add	w20, w11, w10
eor	w11, w6, w27
add	w26, w25, w26
eor	w19, w20, w28
add	w27, w24, w21
eor	w9, w26, w9
ror	w19, w19, #0x8
ror	w21, w11, #0x7
eor	w11, w27, w23
ror	w9, w9, #0xc
ror	w11, w11, #0xc
add	w23, w30, w15
add	w28, w19, w29
add	w22, w22, w2
add	w20, w20, w17
add	w23, w23, w9
eor	w10, w28, w10
add	w22, w22, w11
eor	w25, w23, w25
ror	w10, w10, #0x7
eor	w24, w22, w24
ror	w25, w25, #0x8
ror	w24, w24, #0x8
add	w23, w23, w0
add	w8, w8, w10
add	w23, w23, w21
ldr	w1, [sp, #0x8]
add	w26, w25, w26
eor	w25, w8, w25
add	w27, w24, w27
eor	w24, w23, w24
ror	w25, w25, #0x10
eor	w11, w27, w11
ror	w29, w24, #0x10
ror	w11, w11, #0x7
eor	w9, w26, w9
add	w24, w25, w27
ror	w9, w9, #0x7
ldr	w17, [sp, #0x44]
add	w27, w29, w28
add	w28, w20, w11
add	w20, w22, w13
eor	w21, w27, w21
eor	w7, w28, w7
add	w22, w23, w4
ror	w21, w21, #0xc
add	w30, w20, w9
ror	w20, w7, #0x10
eor	w10, w24, w10
eor	w7, w30, w19
add	w23, w8, w3
add	w12, w22, w21
ror	w10, w10, #0xc
ldr	w4, [sp, #0x10]
eor	w19, w12, w29
ror	w29, w7, #0x10
add	w7, w20, w26
ror	w19, w19, #0x8
eor	w11, w7, w11
add	w26, w23, w10
add	w8, w29, w6
ror	w23, w11, #0xc
add	w11, w28, w2
add	w6, w19, w27
eor	w9, w8, w9
eor	w25, w26, w25
eor	w21, w6, w21
ror	w9, w9, #0xc
add	w11, w11, w23
ror	w27, w21, #0x7
add	w21, w30, w4
eor	w20, w11, w20
add	w22, w21, w9
ror	w20, w20, #0x8
add	w21, w26, w18
ror	w25, w25, #0x8
eor	w26, w22, w29
add	w28, w21, w27
ror	w26, w26, #0x8
eor	w29, w28, w20
add	w11, w11, w5
add	w21, w25, w24
ror	w29, w29, #0x10
ldr	w18, [sp, #0x38]
eor	w10, w21, w10
add	w8, w26, w8
ldr	w13, [sp, #0x4c]
ror	w10, w10, #0x7
add	w24, w29, w8
eor	w8, w8, w9
eor	w27, w24, w27
ror	w8, w8, #0x7
add	w12, w12, w18
add	w11, w11, w10
ror	w9, w27, #0xc
add	w27, w20, w7
eor	w20, w11, w26
add	w7, w28, w15
eor	w23, w27, w23
ror	w28, w20, #0x10
add	w26, w7, w9
ror	w23, w23, #0x7
eor	w7, w26, w29
add	w12, w12, w8
add	w11, w11, w1
add	w29, w28, w6
add	w6, w22, w16
ror	w7, w7, #0x8
eor	w10, w29, w10
add	w22, w6, w23
eor	w20, w12, w25
ror	w10, w10, #0xc
eor	w19, w22, w19
ror	w25, w20, #0x10
add	w6, w7, w24
ror	w24, w19, #0x10
mov	w14, w0
add	w20, w11, w10
eor	w9, w6, w9
add	w11, w25, w27
eor	w19, w20, w28
add	w27, w24, w21
eor	w8, w11, w8
ror	w19, w19, #0x8
ror	w21, w9, #0x7
eor	w9, w27, w23
ror	w8, w8, #0xc
ror	w9, w9, #0xc
mov	w0, w16
add	w12, w12, w17
add	w23, w19, w29
add	w22, w22, w13
ldp	w16, w3, [sp, #0x20]
add	w12, w12, w8
eor	w10, w23, w10
add	w22, w22, w9
eor	w25, w12, w25
ror	w10, w10, #0x7
eor	w24, w22, w24
ror	w25, w25, #0x8
add	w26, w26, w14
ror	w24, w24, #0x8
add	w12, w12, w16
add	w26, w26, w10
add	w20, w20, w3
add	w12, w12, w21
add	w11, w25, w11
eor	w25, w26, w25
add	w27, w24, w27
eor	w24, w12, w24
ror	w25, w25, #0x10
ror	w28, w24, #0x10
eor	w9, w27, w9
eor	w8, w11, w8
ror	w9, w9, #0x7
add	w24, w25, w27
ror	w8, w8, #0x7
add	w27, w28, w23
add	w12, w12, w18
eor	w10, w24, w10
eor	w21, w27, w21
add	w29, w20, w9
add	w20, w22, w2
ror	w21, w21, #0xc
eor	w7, w29, w7
add	w22, w20, w8
ror	w30, w7, #0x10
ldr	w14, [sp, #0x48]
ror	w10, w10, #0xc
add	w20, w12, w21
eor	w12, w22, w19
eor	w19, w20, w28
ror	w12, w12, #0x10
add	w7, w30, w11
ror	w19, w19, #0x8
add	w23, w26, w14
eor	w9, w7, w9
add	w11, w23, w10
add	w26, w12, w6
ror	w23, w9, #0xc
add	w6, w19, w27
ldr	w14, [sp, #0x40]
eor	w8, w26, w8
add	w9, w29, w13
eor	w21, w6, w21
eor	w25, w11, w25
ror	w8, w8, #0xc
add	w9, w9, w23
ror	w27, w21, #0x7
add	w21, w22, w14
ldr	w14, [sp, #0x3c]
eor	w28, w9, w30
ror	w25, w25, #0x8
add	w22, w21, w8
ror	w28, w28, #0x8
add	w11, w11, w14
eor	w12, w22, w12
add	w9, w9, w1
add	w11, w11, w27
add	w21, w25, w24
ror	w12, w12, #0x8
eor	w29, w11, w28
eor	w10, w21, w10
add	w11, w11, w17
ror	w29, w29, #0x10
ror	w10, w10, #0x7
add	w26, w12, w26
eor	w8, w26, w8
add	w20, w20, w0
mov	w14, w0
add	w24, w29, w26
add	w9, w9, w10
ror	w8, w8, #0x7
eor	w27, w24, w27
eor	w12, w9, w12
ldr	w0, [sp, #0x28]
ror	w26, w27, #0xc
add	w27, w28, w7
ror	w12, w12, #0x10
eor	w7, w27, w23
add	w9, w9, w0
mov	w30, w15
add	w11, w11, w26
ror	w23, w7, #0x7
add	w28, w12, w6
eor	w7, w11, w29
add	w29, w20, w8
add	w6, w22, w15
eor	w10, w28, w10
ror	w7, w7, #0x8
eor	w20, w29, w25
add	w22, w6, w23
ror	w10, w10, #0xc
ror	w25, w20, #0x10
eor	w19, w22, w19
add	w6, w7, w24
add	w22, w22, w5
ror	w24, w19, #0x10
add	w20, w9, w10
eor	w9, w6, w26
add	w26, w25, w27
eor	w12, w20, w12
add	w11, w11, w16
eor	w8, w26, w8
add	w27, w24, w21
ror	w19, w12, #0x8
ror	w21, w9, #0x7
ror	w8, w8, #0xc
eor	w9, w27, w23
add	w12, w29, w4
ror	w9, w9, #0xc
add	w23, w19, w28
add	w12, w12, w8
eor	w10, w23, w10
mov	w15, w5
eor	w25, w12, w25
add	w22, w22, w9
ror	w10, w10, #0x7
ror	w25, w25, #0x8
eor	w24, w22, w24
add	w12, w12, w18
ror	w5, w24, #0x8
add	w11, w11, w10
add	w12, w12, w21
eor	w18, w11, w25
add	w24, w25, w26
add	w16, w20, w2
add	w25, w5, w27
ror	w26, w18, #0x10
eor	w18, w12, w5
eor	w9, w25, w9
ror	w5, w18, #0x10
eor	w8, w24, w8
ror	w9, w9, #0x7
ror	w8, w8, #0x7
add	w13, w22, w13
add	w23, w5, w23
add	w12, w12, w14
mov	w29, w4
eor	w20, w23, w21
add	w21, w16, w9
add	w18, w26, w25
ror	w20, w20, #0xc
eor	w16, w21, w7
add	w7, w13, w8
ror	w22, w16, #0x10
eor	w10, w18, w10
add	w15, w21, w15
add	w13, w12, w20
eor	w12, w7, w19
ror	w10, w10, #0xc
eor	w16, w13, w5
ror	w4, w12, #0x10
add	w5, w22, w24
ror	w16, w16, #0x8
eor	w9, w5, w9
ldr	w14, [sp, #0x14]
add	w6, w4, w6
ror	w9, w9, #0xc
add	w11, w11, w3
add	w12, w16, w23
eor	w8, w6, w8
ldr	w2, [sp, #0x48]
eor	w20, w12, w20
ror	w8, w8, #0xc
add	w21, w15, w9
add	w11, w11, w10
ror	w15, w20, #0x7
add	w14, w7, w14
eor	w7, w21, w22
eor	w19, w11, w26
add	w20, w14, w8
ror	w14, w7, #0x8
add	w11, w11, w2
ror	w3, w19, #0x8
eor	w4, w20, w4
add	w11, w11, w15
add	w13, w13, w30
ror	w4, w4, #0x8
eor	w7, w11, w14
add	w5, w14, w5
add	w18, w3, w18
ror	w7, w7, #0x10
eor	w9, w5, w9
eor	w10, w18, w10
add	w6, w4, w6
ror	w9, w9, #0x7
ror	w10, w10, #0x7
add	w14, w7, w6
eor	w8, w6, w8
add	w6, w20, w17
ror	w8, w8, #0x7
eor	w15, w14, w15
add	w17, w6, w9
add	w6, w21, w0
ror	w15, w15, #0xc
add	w6, w6, w10
eor	w16, w17, w16
add	w13, w13, w8
eor	w4, w6, w4
ror	w16, w16, #0x10
eor	w3, w13, w3
ror	w4, w4, #0x10
ror	w3, w3, #0x10
add	w17, w17, w1
add	w18, w16, w18
add	w11, w11, w29
add	w12, w4, w12
eor	w9, w18, w9
add	w5, w3, w5
ldp	w2, w0, [sp, #0x3c]
eor	w10, w12, w10
ror	w9, w9, #0xc
eor	w8, w5, w8
ror	w10, w10, #0xc
ror	w8, w8, #0xc
add	w11, w11, w15
add	w1, w6, w2
add	w17, w17, w9
add	w13, w13, w0
add	w1, w1, w10
eor	w16, w17, w16
add	w13, w13, w8
eor	w2, w1, w4
eor	w7, w11, w7
ror	w16, w16, #0x8
eor	w3, w13, w3
ror	w2, w2, #0x8
ror	w7, w7, #0x8
ror	w3, w3, #0x8
add	w18, w16, w18
ldr	x0, [sp, #0x18]
add	w12, w2, w12
add	w14, w7, w14
eor	w11, w18, w11
add	w4, w3, w5
eor	w13, w12, w13
eor	w15, w14, w15
stp	w11, w13, [x0]
eor	w10, w12, w10
eor	w11, w14, w17
eor	w12, w4, w1
eor	w8, w4, w8
eor	w9, w18, w9
eor	w10, w3, w10, ror #7
stp	w11, w12, [x0, #0x8]
eor	w11, w16, w15, ror #7
eor	w8, w2, w8, ror #7
eor	w9, w7, w9, ror #7
ldp	x20, x19, [sp, #0xa0]
stp	w10, w11, [x0, #0x10]
ldp	x22, x21, [sp, #0x90]
stp	w8, w9, [x0, #0x18]
ldp	x24, x23, [sp, #0x80]
ldp	x26, x25, [sp, #0x70]
ldp	x28, x27, [sp, #0x60]
ldp	x29, x30, [sp, #0x50]
add	sp, sp, #0xb0
ret
blake3_compress_xof_portable:
sub	sp, sp, #0xb0
ldp	w12, w16, [x1]
ldp	w11, w18, [x0]
ldp	w6, w7, [x0, #0x10]
stp	x20, x19, [sp, #0xa0]
and	w4, w4, #0xff
add	w15, w11, w12
stp	x24, x23, [sp, #0x80]
mov	w23, #0xe667
ldp	w8, w10, [x1, #0x8]
add	w19, w15, w6
movk	w23, #0x6a09, lsl #16
stp	x26, x25, [sp, #0x70]
eor	w20, w19, w3
lsr	x3, x3, #32
and	w26, w2, #0xff
ror	w20, w20, #0x10
add	w24, w18, w8
stp	x22, x21, [sp, #0x90]
ldp	w13, w11, [x1, #0x18]
add	w18, w20, w23
add	w23, w24, w7
stp	x28, x27, [sp, #0x60]
eor	w6, w18, w6
eor	w3, w23, w3
stp	x29, x30, [sp, #0x50]
ror	w2, w6, #0xc
ror	w3, w3, #0x10
add	w6, w19, w16
mov	w19, #0xae85
stp	w12, w13, [sp, #0x48]
mov	w15, w8
ldp	w21, w22, [x0, #0x8]
movk	w19, #0xbb67, lsl #16
add	w6, w6, w2
str	x0, [sp, #0x18]
ldp	w9, w17, [x1, #0x10]
ldp	w24, w25, [x0, #0x18]
add	w27, w3, w19
add	w19, w22, w13
eor	w20, w6, w20
eor	w7, w27, w7
stp	w16, w9, [sp, #0x38]
mov	w13, w10
ror	w28, w7, #0xc
add	w22, w19, w25
add	w7, w21, w9
add	w19, w23, w10
eor	w4, w22, w4
add	w29, w7, w24
add	w19, w19, w28
ror	w4, w4, #0x10
eor	w7, w29, w26
mov	w21, #0xf53a
eor	w3, w19, w3
ror	w26, w7, #0x10
movk	w21, #0xa54f, lsl #16
ror	w7, w3, #0x8
mov	w3, #0xf372
add	w30, w4, w21
movk	w3, #0x3c6e, lsl #16
ror	w21, w20, #0x8
eor	w23, w30, w25
add	w3, w26, w3
add	w22, w22, w11
ldp	w12, w14, [x1, #0x20]
ror	w20, w23, #0xc
add	w23, w7, w27
eor	w24, w3, w24
eor	w25, w23, w28
ror	w28, w24, #0xc
mov	w16, w11
add	w27, w22, w20
add	w22, w29, w17
stp	w12, w8, [sp, #0x40]
ror	w8, w25, #0x7
eor	w4, w27, w4
add	w24, w22, w28
ror	w4, w4, #0x8
add	w6, w6, w12
add	w22, w21, w18
eor	w18, w24, w26
add	w29, w6, w8
eor	w2, w22, w2
ror	w9, w18, #0x8
eor	w25, w29, w4
ror	w11, w2, #0x7
ror	w10, w25, #0x10
add	w29, w29, w14
add	w25, w4, w30
add	w2, w9, w3
eor	w20, w25, w20
str	w17, [sp, #0x28]
ldp	w3, w0, [x1, #0x38]
add	w26, w10, w2
eor	w28, w2, w28
ror	w30, w20, #0x7
eor	w8, w26, w8
ror	w28, w28, #0x7
mov	w17, w14
add	w2, w27, w3
ror	w12, w8, #0xc
mov	w14, w13
add	w27, w2, w11
str	w13, [sp, #0x34]
ldr	w4, [sp, #0x38]
ldp	w18, w6, [x1, #0x28]
eor	w9, w27, w9
add	w29, w29, w12
add	w27, w27, w0
ldp	w8, w1, [x1, #0x30]
ror	w9, w9, #0x10
eor	w10, w29, w10
mov	w2, w18
ror	w20, w10, #0x8
add	w10, w19, w18
add	w29, w29, w15
add	w23, w9, w23
add	w10, w10, w28
add	w19, w24, w8
eor	w11, w23, w11
eor	w21, w10, w21
add	w24, w19, w30
ror	w11, w11, #0xc
ror	w19, w21, #0x10
eor	w21, w24, w7
add	w7, w20, w26
ror	w26, w21, #0x10
mov	w18, w8
add	w21, w27, w11
add	w25, w19, w25
eor	w27, w7, w12
eor	w8, w21, w9
eor	w9, w25, w28
add	w28, w26, w22
ror	w8, w8, #0x8
ror	w22, w27, #0x7
ror	w9, w9, #0xc
eor	w27, w28, w30
add	w10, w10, w6
add	w24, w24, w1
ror	w27, w27, #0xc
add	w23, w8, w23
add	w10, w10, w9
eor	w11, w23, w11
eor	w19, w10, w19
add	w10, w10, w13
add	w24, w24, w27
ror	w11, w11, #0x7
ror	w19, w19, #0x8
eor	w26, w24, w26
add	w10, w10, w22
ldr	w13, [sp, #0x3c]
ror	w26, w26, #0x8
add	w29, w29, w11
add	w30, w19, w25
eor	w19, w29, w19
eor	w9, w30, w9
add	w21, w21, w13
add	w25, w26, w28
ror	w28, w19, #0x10
eor	w19, w10, w26
eor	w26, w25, w27
ror	w19, w19, #0x10
ror	w9, w9, #0x7
ror	w26, w26, #0x7
add	w25, w28, w25
ldr	w12, [sp, #0x4c]
add	w23, w19, w23
eor	w11, w25, w11
add	w10, w10, w2
eor	w22, w23, w22
add	w27, w21, w26
add	w21, w24, w16
ror	w22, w22, #0xc
eor	w20, w27, w20
add	w21, w21, w9
ror	w20, w20, #0x10
ror	w11, w11, #0xc
add	w24, w29, w12
add	w12, w10, w22
eor	w8, w21, w8
ldr	w10, [sp, #0x48]
eor	w29, w12, w19
ror	w8, w8, #0x10
add	w19, w20, w30
add	w30, w24, w11
ror	w29, w29, #0x8
eor	w24, w19, w26
eor	w26, w30, w28
add	w28, w8, w7
ror	w24, w24, #0xc
add	w7, w29, w23
eor	w9, w28, w9
add	w23, w27, w1
eor	w22, w7, w22
ror	w9, w9, #0xc
add	w27, w23, w24
ror	w22, w22, #0x7
add	w21, w21, w10
eor	w20, w27, w20
add	w23, w21, w9
ror	w20, w20, #0x8
add	w21, w30, w4
ror	w26, w26, #0x8
eor	w8, w23, w8
add	w21, w21, w22
ror	w30, w8, #0x8
eor	w8, w21, w20
add	w27, w27, w0
add	w10, w26, w25
ror	w8, w8, #0x10
add	w20, w20, w19
eor	w11, w10, w11
add	w28, w30, w28
add	w19, w21, w6
ror	w11, w11, #0x7
add	w25, w8, w28
eor	w9, w28, w9
eor	w22, w25, w22
eor	w24, w20, w24
ror	w9, w9, #0x7
ror	w22, w22, #0xc
add	w27, w27, w11
ror	w24, w24, #0x7
eor	w21, w27, w30
str	w0, [sp, #0xc]
mov	w0, w6
add	w28, w19, w22
ror	w30, w21, #0x10
str	w6, [sp, #0x4]
eor	w8, w28, w8
ldr	w6, [sp, #0x40]
mov	w15, w17
ror	w19, w8, #0x8
add	w8, w12, w18
add	w12, w30, w7
add	w8, w8, w9
add	w7, w23, w17
eor	w11, w12, w11
eor	w21, w8, w26
add	w23, w7, w24
ror	w11, w11, #0xc
ror	w26, w21, #0x10
eor	w21, w23, w29
add	w27, w27, w6
add	w7, w19, w25
ror	w25, w21, #0x10
add	w21, w27, w11
add	w27, w26, w20
eor	w20, w21, w30
ldr	w17, [sp, #0x28]
eor	w9, w27, w9
add	w10, w25, w10
ror	w20, w20, #0x8
ror	w9, w9, #0xc
eor	w24, w10, w24
add	w8, w8, w17
ror	w24, w24, #0xc
add	w12, w20, w12
add	w23, w23, w3
add	w8, w8, w9
eor	w11, w12, w11
eor	w22, w7, w22
eor	w26, w8, w26
add	w23, w23, w24
ror	w11, w11, #0x7
ror	w22, w22, #0x7
ror	w26, w26, #0x8
eor	w25, w23, w25
add	w28, w28, w14
ror	w25, w25, #0x8
add	w8, w8, w2
add	w28, w28, w11
add	w27, w26, w27
add	w8, w8, w22
eor	w26, w28, w26
add	w10, w25, w10
eor	w25, w8, w25
ror	w26, w26, #0x10
eor	w24, w10, w24
ror	w29, w25, #0x10
ror	w24, w24, #0x7
eor	w9, w27, w9
add	w8, w8, w18
add	w25, w26, w10
ror	w9, w9, #0x7
add	w28, w28, w13
eor	w10, w25, w11
add	w11, w29, w12
add	w12, w21, w16
eor	w21, w11, w22
add	w12, w12, w24
ror	w10, w10, #0xc
ror	w22, w21, #0xc
add	w21, w23, w1
eor	w19, w12, w19
add	w23, w21, w9
ror	w30, w19, #0x10
str	w16, [sp, #0x24]
add	w21, w8, w22
eor	w8, w23, w20
mov	w16, w13
eor	w20, w21, w29
ror	w8, w8, #0x10
add	w19, w30, w27
ror	w20, w20, #0x8
eor	w24, w19, w24
add	w27, w28, w10
add	w28, w8, w7
ror	w24, w24, #0xc
ldr	w13, [sp, #0x44]
add	w7, w20, w11
eor	w9, w28, w9
add	w11, w12, w3
eor	w12, w7, w22
ror	w9, w9, #0xc
add	w11, w11, w24
add	w22, w23, w13
ldr	w13, [sp, #0x4c]
eor	w26, w27, w26
ror	w12, w12, #0x7
eor	w29, w11, w30
add	w23, w22, w9
ror	w29, w29, #0x8
add	w22, w27, w13
ror	w26, w26, #0x8
eor	w8, w23, w8
add	w27, w22, w12
add	w11, w11, w6
ror	w8, w8, #0x8
eor	w30, w27, w29
add	w22, w26, w25
ror	w30, w30, #0x10
eor	w10, w22, w10
add	w21, w21, w15
add	w28, w8, w28
ror	w10, w10, #0x7
mov	w6, w17
add	w25, w30, w28
eor	w9, w28, w9
add	w28, w29, w19
eor	w12, w25, w12
add	w11, w11, w10
add	w19, w27, w17
ror	w12, w12, #0xc
eor	w8, w11, w8
eor	w24, w28, w24
ror	w8, w8, #0x10
ror	w9, w9, #0x7
ror	w24, w24, #0x7
add	w27, w19, w12
add	w11, w11, w4
mov	w17, w4
eor	w19, w27, w30
add	w29, w8, w7
add	w30, w21, w9
add	w7, w23, w0
ror	w19, w19, #0x8
eor	w10, w29, w10
eor	w21, w30, w26
add	w23, w7, w24
ror	w10, w10, #0xc
ror	w26, w21, #0x10
eor	w20, w23, w20
add	w7, w19, w25
ror	w25, w20, #0x10
add	w21, w11, w10
eor	w11, w7, w12
add	w12, w26, w28
eor	w8, w21, w8
ldr	w13, [sp, #0x48]
eor	w9, w12, w9
add	w28, w25, w22
ror	w20, w8, #0x8
ror	w8, w9, #0xc
eor	w9, w28, w24
ldr	w4, [sp, #0xc]
ror	w9, w9, #0xc
ror	w22, w11, #0x7
add	w11, w30, w13
add	w24, w20, w29
add	w23, w23, w4
add	w11, w11, w8
eor	w10, w24, w10
add	w23, w23, w9
eor	w26, w11, w26
ror	w10, w10, #0x7
eor	w25, w23, w25
ror	w26, w26, #0x8
add	w27, w27, w2
ror	w25, w25, #0x8
add	w11, w11, w18
add	w27, w27, w10
add	w11, w11, w22
add	w12, w26, w12
eor	w26, w27, w26
add	w28, w25, w28
eor	w25, w11, w25
ror	w26, w26, #0x10
eor	w9, w28, w9
ror	w29, w25, #0x10
ror	w9, w9, #0x7
eor	w8, w12, w8
add	w21, w21, w1
add	w25, w26, w28
add	w28, w29, w24
mov	w14, w3
ror	w8, w8, #0x7
eor	w22, w28, w22
add	w30, w21, w9
mov	w3, w15
ror	w22, w22, #0xc
add	w21, w23, w14
eor	w19, w30, w19
mov	w0, w14
add	w11, w11, w15
add	w23, w21, w8
ror	w21, w19, #0x10
ldr	w14, [sp, #0x24]
eor	w10, w25, w10
add	w11, w11, w22
eor	w19, w23, w20
ror	w10, w10, #0xc
add	w24, w27, w14
eor	w20, w11, w29
ror	w27, w19, #0x10
add	w19, w21, w12
ror	w20, w20, #0x8
eor	w9, w19, w9
add	w12, w24, w10
mov	w15, w18
add	w29, w27, w7
ror	w24, w9, #0xc
stp	w1, w18, [sp, #0x2c]
mov	w18, w1
add	w7, w20, w28
eor	w8, w29, w8
add	w9, w30, w4
ldr	w1, [sp, #0x34]
eor	w22, w7, w22
ror	w8, w8, #0xc
add	w9, w9, w24
eor	w26, w12, w26
ror	w28, w22, #0x7
add	w22, w23, w1
eor	w21, w9, w21
add	w23, w22, w8
ror	w21, w21, #0x8
add	w12, w12, w16
ror	w26, w26, #0x8
eor	w22, w23, w27
add	w12, w12, w28
ror	w27, w22, #0x8
eor	w30, w12, w21
add	w9, w9, w17
add	w22, w26, w25
ror	w30, w30, #0x10
add	w12, w12, w13
eor	w10, w22, w10
add	w29, w27, w29
ldr	w13, [sp, #0x4]
ror	w10, w10, #0x7
add	w25, w30, w29
eor	w8, w29, w8
eor	w28, w25, w28
add	w29, w21, w19
ror	w8, w8, #0x7
add	w9, w9, w10
ror	w28, w28, #0xc
eor	w21, w29, w24
eor	w19, w9, w27
ror	w27, w21, #0x7
add	w11, w11, w13
ror	w24, w19, #0x10
add	w12, w12, w28
ldr	w1, [sp, #0x4c]
eor	w19, w12, w30
add	w11, w11, w8
str	w2, [sp, #0x14]
add	w30, w24, w7
add	w7, w23, w6
ror	w19, w19, #0x8
eor	w10, w30, w10
add	w23, w7, w27
eor	w21, w11, w26
ror	w10, w10, #0xc
eor	w20, w23, w20
add	w9, w9, w1
add	w7, w19, w25
ror	w25, w20, #0x10
ror	w26, w21, #0x10
add	w21, w9, w10
eor	w9, w7, w28
add	w12, w12, w15
eor	w20, w21, w24
add	w24, w25, w22
add	w28, w26, w29
ldp	w16, w2, [sp, #0x40]
ror	w22, w9, #0x7
eor	w9, w24, w27
eor	w8, w28, w8
ror	w9, w9, #0xc
ror	w8, w8, #0xc
ror	w20, w20, #0x8
add	w23, w23, w16
add	w11, w11, w2
add	w21, w21, w0
add	w23, w23, w9
add	w11, w11, w8
add	w27, w20, w30
eor	w25, w23, w25
eor	w26, w11, w26
add	w11, w11, w3
ror	w25, w25, #0x8
add	w11, w11, w22
ror	w26, w26, #0x8
eor	w10, w27, w10
ldr	w17, [sp, #0x14]
mov	w6, w0
add	w24, w25, w24
eor	w25, w11, w25
ror	w10, w10, #0x7
eor	w9, w24, w9
ror	w29, w25, #0x10
add	w28, w26, w28
ror	w9, w9, #0x7
eor	w8, w28, w8
add	w12, w12, w10
add	w27, w29, w27
ror	w8, w8, #0x7
eor	w26, w12, w26
eor	w22, w27, w22
add	w30, w21, w9
add	w21, w23, w4
ror	w22, w22, #0xc
eor	w19, w30, w19
ror	w26, w26, #0x10
add	w11, w11, w13
add	w23, w21, w8
ror	w21, w19, #0x10
add	w11, w11, w22
eor	w19, w23, w20
add	w25, w26, w24
eor	w20, w11, w29
ror	w29, w19, #0x10
add	w19, w21, w28
eor	w10, w25, w10
ror	w20, w20, #0x8
eor	w9, w19, w9
ror	w10, w10, #0xc
add	w28, w29, w7
ror	w24, w9, #0xc
add	w12, w12, w18
add	w7, w20, w27
eor	w8, w28, w8
add	w9, w30, w16
add	w12, w12, w10
eor	w22, w7, w22
ror	w8, w8, #0xc
add	w9, w9, w24
eor	w26, w12, w26
ror	w27, w22, #0x7
add	w22, w23, w17
eor	w21, w9, w21
add	w23, w22, w8
ror	w21, w21, #0x8
add	w12, w12, w14
ror	w26, w26, #0x8
eor	w22, w23, w29
add	w12, w12, w27
ror	w29, w22, #0x8
eor	w30, w12, w21
add	w9, w9, w1
add	w22, w26, w25
ror	w30, w30, #0x10
add	w12, w12, w2
eor	w10, w22, w10
add	w28, w29, w28
ldr	w16, [sp, #0x48]
ror	w10, w10, #0x7
add	w25, w30, w28
eor	w8, w28, w8
eor	w27, w25, w27
add	w28, w21, w19
ldr	w14, [sp, #0x28]
add	w9, w9, w10
ror	w27, w27, #0xc
eor	w21, w28, w24
eor	w19, w9, w29
ror	w29, w21, #0x7
str	w0, [sp, #0x8]
ror	w24, w19, #0x10
add	w12, w12, w27
mov	w15, w13
mov	w0, w2
ror	w8, w8, #0x7
eor	w19, w12, w30
add	w30, w24, w7
add	w7, w23, w16
ror	w19, w19, #0x8
ldp	w13, w2, [sp, #0x38]
add	w11, w11, w14
eor	w10, w30, w10
add	w23, w7, w29
add	w11, w11, w8
ror	w10, w10, #0xc
eor	w20, w23, w20
eor	w21, w11, w26
add	w9, w9, w2
add	w7, w19, w25
ror	w25, w20, #0x10
ror	w26, w21, #0x10
add	w21, w9, w10
eor	w9, w7, w27
eor	w20, w21, w24
ldr	w18, [sp, #0x34]
add	w24, w25, w22
add	w27, w26, w28
ror	w22, w9, #0x7
eor	w9, w24, w29
eor	w8, w27, w8
add	w23, w23, w13
ror	w9, w9, #0xc
ror	w8, w8, #0xc
ror	w20, w20, #0x8
add	w11, w11, w18
add	w12, w12, w3
str	w3, [sp, #0x10]
add	w23, w23, w9
add	w11, w11, w8
add	w28, w20, w30
eor	w25, w23, w25
eor	w26, w11, w26
add	w11, w11, w15
ror	w25, w25, #0x8
eor	w10, w28, w10
add	w11, w11, w22
ror	w10, w10, #0x7
ror	w26, w26, #0x8
mov	w3, w15
add	w24, w25, w24
eor	w25, w11, w25
add	w21, w21, w4
eor	w9, w24, w9
ror	w29, w25, #0x10
add	w12, w12, w10
add	w27, w26, w27
ror	w9, w9, #0x7
eor	w26, w12, w26
eor	w8, w27, w8
add	w28, w29, w28
ldr	w15, [sp, #0x40]
ror	w26, w26, #0x10
ror	w8, w8, #0x7
eor	w22, w28, w22
add	w30, w21, w9
ror	w22, w22, #0xc
add	w21, w23, w15
eor	w19, w30, w19
add	w25, w26, w24
add	w11, w11, w14
add	w21, w21, w8
ror	w19, w19, #0x10
eor	w10, w25, w10
add	w11, w11, w22
eor	w20, w21, w20
ror	w10, w10, #0xc
eor	w24, w11, w29
ror	w29, w20, #0x10
add	w23, w19, w27
add	w12, w12, w6
ror	w20, w24, #0x8
eor	w9, w23, w9
add	w12, w12, w10
add	w7, w29, w7
ror	w24, w9, #0xc
add	w27, w30, w13
eor	w26, w12, w26
add	w9, w20, w28
ldp	w13, w1, [sp, #0x2c]
eor	w8, w7, w8
eor	w22, w9, w22
add	w28, w27, w24
ror	w8, w8, #0xc
ror	w26, w26, #0x8
ror	w30, w22, #0x7
add	w21, w21, w1
eor	w19, w28, w19
add	w12, w12, w13
add	w27, w21, w8
ror	w19, w19, #0x8
add	w22, w26, w25
eor	w21, w27, w29
add	w12, w12, w30
eor	w10, w22, w10
ror	w21, w21, #0x8
eor	w29, w12, w19
ror	w10, w10, #0x7
ror	w29, w29, #0x10
add	w28, w28, w2
add	w23, w19, w23
add	w25, w21, w7
add	w19, w28, w10
eor	w24, w23, w24
add	w7, w29, w25
eor	w8, w25, w8
eor	w21, w19, w21
eor	w25, w7, w30
ror	w24, w24, #0x7
ror	w28, w21, #0x10
ror	w8, w8, #0x7
ror	w25, w25, #0xc
add	w27, w27, w0
add	w11, w11, w16
add	w12, w12, w18
add	w27, w27, w24
add	w9, w28, w9
add	w11, w11, w8
add	w12, w12, w25
eor	w20, w27, w20
eor	w10, w9, w10
eor	w26, w11, w26
ldr	w0, [sp, #0x24]
eor	w21, w12, w29
ror	w29, w20, #0x10
ror	w10, w10, #0xc
ror	w26, w26, #0x10
mov	w2, w18
add	w6, w19, w0
ror	w19, w21, #0x8
add	w30, w29, w22
add	w21, w6, w10
add	w6, w26, w23
eor	w20, w30, w24
eor	w23, w6, w8
ldr	w8, [sp, #0x4c]
eor	w22, w21, w28
ror	w28, w20, #0xc
ror	w20, w22, #0x8
add	w18, w19, w7
ror	w24, w23, #0xc
add	w7, w27, w8
add	w11, w11, w17
add	w22, w7, w28
add	w23, w20, w9
add	w12, w12, w3
add	w9, w11, w24
eor	w11, w22, w29
eor	w10, w23, w10
ror	w11, w11, #0x8
eor	w26, w9, w26
ror	w7, w10, #0x7
eor	w10, w18, w25
mov	w1, w17
ror	w17, w26, #0x8
ror	w10, w10, #0x7
add	w25, w11, w30
add	w9, w9, w14
add	w12, w12, w7
eor	w26, w25, w28
add	w6, w17, w6
eor	w17, w12, w17
add	w27, w12, w4
ror	w12, w26, #0x7
add	w9, w9, w10
add	w14, w21, w15
ldr	w13, [sp, #0x38]
eor	w11, w9, w11
add	w14, w14, w12
add	w9, w9, w16
ror	w11, w11, #0x10
eor	w16, w6, w24
ror	w21, w17, #0x10
eor	w17, w14, w19
ror	w16, w16, #0x7
add	w19, w22, w13
add	w22, w11, w23
ror	w23, w17, #0x10
ldr	w13, [sp, #0x10]
eor	w10, w22, w10
add	w17, w19, w16
add	w4, w21, w25
ror	w10, w10, #0xc
add	w6, w23, w6
eor	w19, w17, w20
add	w20, w17, w13
eor	w17, w6, w12
eor	w15, w4, w7
add	w12, w9, w10
ror	w9, w19, #0x10
ror	w7, w17, #0xc
add	w13, w14, w8
eor	w11, w12, w11
ror	w19, w15, #0xc
ror	w11, w11, #0x8
add	w8, w9, w18
add	w17, w13, w7
eor	w15, w8, w16
eor	w16, w17, w23
add	w14, w27, w19
add	w13, w11, w22
ror	w22, w15, #0xc
ror	w23, w16, #0x8
ldr	w15, [sp, #0x8]
eor	w16, w14, w21
eor	w10, w13, w10
ror	w16, w16, #0x8
add	w17, w17, w0
ldr	w0, [sp, #0x44]
add	w3, w14, w15
add	w14, w23, w6
ror	w15, w10, #0x7
eor	w6, w14, w7
add	w10, w20, w22
add	w4, w16, w4
ror	w6, w6, #0x7
eor	w9, w10, w9
add	w10, w10, w2
ror	w9, w9, #0x8
eor	w18, w4, w19
add	w3, w3, w15
add	w10, w10, w6
ror	w18, w18, #0x7
eor	w7, w3, w23
eor	w11, w10, w11
add	w8, w9, w8
add	w12, w12, w0
ror	w11, w11, #0x10
eor	w19, w8, w22
add	w17, w17, w18
ror	w19, w19, #0x7
eor	w9, w17, w9
ror	w7, w7, #0x10
add	w4, w11, w4
ldr	w0, [sp, #0x3c]
ror	w9, w9, #0x10
eor	w6, w4, w6
add	w21, w12, w19
add	w20, w7, w8
ror	w12, w6, #0xc
add	w10, w10, w0
add	w13, w9, w13
eor	w8, w20, w15
eor	w15, w21, w16
add	w3, w3, w1
add	w16, w10, w12
eor	w10, w13, w18
ror	w15, w15, #0x10
ror	w6, w10, #0xc
ldr	w10, [sp, #0x2c]
ror	w18, w8, #0xc
eor	w8, w16, w11
add	w22, w15, w14
ror	w8, w8, #0x8
add	w10, w17, w10
eor	w11, w22, w19
add	w1, w10, w6
ldr	w10, [sp, #0x30]
add	w14, w3, w18
ror	w17, w11, #0xc
add	w11, w8, w4
eor	w9, w1, w9
add	w10, w21, w10
ror	w9, w9, #0x8
eor	w2, w11, w14
add	w3, w10, w17
lsr	w10, w2, #8
eor	w14, w14, w7
add	w13, w9, w13
lsr	w4, w2, #16
strb	w2, [x5]
strb	w10, [x5, #0x1]
lsr	w2, w2, #24
eor	w7, w13, w3
ror	w10, w14, #0x8
strb	w4, [x5, #0x2]
lsr	w4, w7, #8
strb	w2, [x5, #0x3]
lsr	w2, w7, #16
eor	w15, w3, w15
add	w14, w10, w20
strb	w4, [x5, #0x5]
ror	w15, w15, #0x8
eor	w4, w14, w16
strb	w2, [x5, #0x6]
lsr	w3, w7, #24
lsr	w2, w4, #8
add	w16, w15, w22
eor	w18, w14, w18
strb	w3, [x5, #0x7]
lsr	w3, w4, #24
eor	w1, w16, w1
strb	w2, [x5, #0x9]
lsr	w2, w4, #16
eor	w18, w8, w18, ror #7
strb	w3, [x5, #0xb]
eor	w3, w13, w6
eor	w17, w16, w17
strb	w2, [x5, #0xa]
lsr	w2, w1, #8
eor	w3, w15, w3, ror #7
strb	w1, [x5, #0xc]
eor	w17, w9, w17, ror #7
eor	w12, w11, w12
strb	w2, [x5, #0xd]
lsr	w2, w1, #16
lsr	w1, w1, #24
strb	w18, [x5, #0x14]
eor	w12, w10, w12, ror #7
strb	w1, [x5, #0xf]
lsr	w1, w3, #16
strb	w17, [x5, #0x18]
ldp	x20, x19, [sp, #0xa0]
strb	w1, [x5, #0x12]
lsr	w1, w18, #8
strb	w2, [x5, #0xe]
lsr	w2, w3, #8
strb	w1, [x5, #0x15]
lsr	w1, w18, #16
lsr	w18, w18, #24
strb	w2, [x5, #0x11]
lsr	w2, w3, #24
strb	w1, [x5, #0x16]
lsr	w1, w17, #8
strb	w18, [x5, #0x17]
lsr	w18, w17, #16
lsr	w17, w17, #24
strb	w12, [x5, #0x1c]
ldp	x22, x21, [sp, #0x90]
strb	w17, [x5, #0x1b]
lsr	w17, w12, #16
strb	w18, [x5, #0x1a]
lsr	w18, w12, #8
lsr	w12, w12, #24
strb	w17, [x5, #0x1e]
ldr	x17, [sp, #0x18]
strb	w7, [x5, #0x4]
ldp	x24, x23, [sp, #0x80]
strb	w4, [x5, #0x8]
ldp	x26, x25, [sp, #0x70]
strb	w3, [x5, #0x10]
ldp	x28, x27, [sp, #0x60]
strb	w2, [x5, #0x13]
ldp	x29, x30, [sp, #0x50]
strb	w1, [x5, #0x19]
strb	w18, [x5, #0x1d]
strb	w12, [x5, #0x1f]
ldr	w12, [x17]
eor	w11, w11, w12
str	w11, [x5, #0x20]
ldr	w11, [x17, #0x4]
eor	w11, w13, w11
str	w11, [x5, #0x24]
ldr	w11, [x17, #0x8]
eor	w11, w14, w11
str	w11, [x5, #0x28]
ldr	w11, [x17, #0xc]
eor	w11, w16, w11
str	w11, [x5, #0x2c]
ldr	w11, [x17, #0x10]
eor	w11, w15, w11
str	w11, [x5, #0x30]
ldr	w11, [x17, #0x14]
eor	w8, w8, w11
str	w8, [x5, #0x34]
ldr	w8, [x17, #0x18]
eor	w8, w9, w8
str	w8, [x5, #0x38]
ldr	w8, [x17, #0x1c]
eor	w8, w10, w8
str	w8, [x5, #0x3c]
add	sp, sp, #0xb0
ret
blake3_hash_many_portable:
cbz	x1, L_1e48
sub	sp, sp, #0x90
stp	x29, x30, [sp, #0x30]
add	x29, sp, #0x30
orr	w9, w7, w6
ldrb	w8, [x29, #0x60]
stp	x26, x25, [sp, #0x50]
ldr	x26, [x29, #0x68]
stp	x28, x27, [sp, #0x40]
mov	x28, x2
and	x10, x5, #0x1
stp	x24, x23, [sp, #0x60]
mov	x24, x0
orr	w27, w6, w8
stp	x22, x21, [sp, #0x70]
mov	x21, x4
mov	x22, x3
stp	x20, x19, [sp, #0x80]
mov	w19, w6
mov	x20, x1
str	w9, [sp, #0x4]
orr	w9, w9, w8
str	x10, [sp, #0x8]
str	w9, [sp]
b	L_1db8
L_1d88:
ldp	w8, w9, [sp, #0x10]
ldur	q0, [sp, #0x18]
ldr	x10, [sp, #0x8]
subs	x20, x20, #0x1
add	x24, x24, #0x8
stp	w8, w9, [x26]
add	x21, x21, x10
ldp	w8, w9, [sp, #0x28]
stur	q0, [x26, #0x8]
stp	w8, w9, [x26, #0x18]
add	x26, x26, #0x20
b.eq	L_1e2c
L_1db8:
ldp	q0, q1, [x22]
ldr	x25, [x24]
stp	q0, q1, [sp, #0x10]
cbz	x28, L_1d88
ldp	w9, w8, [sp]
cmp	x28, #0x1
add	x0, sp, #0x10
mov	x1, x25
mov	w2, #0x40
mov	x3, x21
csel	w4, w8, w9, ne
bl	blake3_compress_in_place_portable
add	x25, x25, #0x40
mov	x23, x28
b	L_1e14
L_1df4:
mov	w4, w27
L_1df8:
add	x0, sp, #0x10
mov	x1, x25
mov	w2, #0x40
mov	x3, x21
bl	blake3_compress_in_place_portable
add	x25, x25, #0x40
sub	x23, x23, #0x1
L_1e14:
cmp	x23, #0x2
b.eq	L_1df4
cmp	x23, #0x1
mov	w4, w19
b.ne	L_1df8
b	L_1d88
L_1e2c:
ldp	x20, x19, [sp, #0x80]
ldp	x22, x21, [sp, #0x70]
ldp	x24, x23, [sp, #0x60]
ldp	x26, x25, [sp, #0x50]
ldp	x28, x27, [sp, #0x40]
ldp	x29, x30, [sp, #0x30]
add	sp, sp, #0x90
L_1e48:
ret
blake3_hash_many_neon:
stp	d15, d14, [sp, #-0xa0]!
stp	d13, d12, [sp, #0x10]
stp	d11, d10, [sp, #0x20]
stp	d9, d8, [sp, #0x30]
stp	x29, x30, [sp, #0x40]
add	x29, sp, #0x40
stp	x28, x27, [sp, #0x50]
stp	x26, x25, [sp, #0x60]
stp	x24, x23, [sp, #0x70]
stp	x22, x21, [sp, #0x80]
stp	x20, x19, [sp, #0x90]
sub	sp, sp, #0x190
ldr	x26, [x29, #0x68]
ldrb	w8, [x29, #0x60]
mov	w19, w6
mov	x23, x1
mov	x21, x4
cmp	x1, #0x4
mov	x24, x0
str	x3, [sp, #0x18]
b.lo	L_3030
dup	v0.2s, w5
adrp	x9, bums_rodata_cst16
mov	w10, #0xae85
ldr	q2, [x9]
mov	w9, #0xe667
movk	w10, #0xbb67, lsl #16
movk	w9, #0x6a09, lsl #16
mov	w11, #0xf372
mov	w12, #0xf53a
dup	v18.4s, w9
and	x9, x5, #0x1
movk	w11, #0x3c6e, lsl #16
ushll	v0.2d, v0.2s, #0x0
movk	w12, #0xa54f, lsl #16
adrp	x13, bums_rodata_cst16+16
str	q18, [sp, #0x50]
shl	v0.2d, v0.2d, #0x3f
cmlt	v1.2d, v0.2d, #0
and	v0.16b, v1.16b, v2.16b
dup	v1.4s, w10
orr	w10, w7, w19
str	q0, [sp]
str	q1, [sp, #0x20]
b	L_1f78
L_1f00:
trn1	v0.4s, v22.4s, v6.4s
trn1	v1.4s, v23.4s, v7.4s
add	x14, x21, #0x4
trn1	v2.4s, v16.4s, v17.4s
trn1	v3.4s, v20.4s, v21.4s
tst	w5, #0x1
trn2	v4.4s, v22.4s, v6.4s
trn2	v6.4s, v16.4s, v17.4s
sub	x23, x23, #0x4
trn2	v5.4s, v23.4s, v7.4s
trn2	v16.4s, v20.4s, v21.4s
csel	x21, x14, x21, ne
zip2	v7.2d, v0.2d, v1.2d
mov	v0.d[1], v1.d[0]
cmp	x23, #0x3
zip2	v17.2d, v2.2d, v3.2d
mov	v2.d[1], v3.d[0]
add	x24, x24, #0x20
mov	v1.16b, v4.16b
mov	v3.16b, v6.16b
zip2	v4.2d, v4.2d, v5.2d
mov	v1.d[1], v5.d[0]
mov	v3.d[1], v16.d[0]
stp	q0, q2, [x26]
zip2	v0.2d, v6.2d, v16.2d
stp	q7, q17, [x26, #0x40]
stp	q1, q3, [x26, #0x20]
stp	q4, q0, [x26, #0x60]
add	x26, x26, #0x80
b.ls	L_3030
L_1f78:
ldr	x17, [sp, #0x18]
mov	x14, x17
add	x15, x17, #0x8
add	x16, x17, #0xc
ld1r	{ v22.4s }, [x14], #4
ld1r	{ v6.4s }, [x14]
add	x14, x17, #0x10
ld1r	{ v23.4s }, [x15]
ld1r	{ v7.4s }, [x16]
ld1r	{ v16.4s }, [x14]
add	x14, x17, #0x14
add	x15, x17, #0x18
add	x16, x17, #0x1c
ld1r	{ v17.4s }, [x14]
ld1r	{ v20.4s }, [x15]
ld1r	{ v21.4s }, [x16]
cbz	x2, L_1f00
fmov	d5, x21
add	x14, x21, x9
fmov	s2, w21
dup	v18.2d, x21
ldr	q0, [sp]
mov	x18, x2
ldp	x17, x16, [x24, #0x10]
mov	w0, w10
mov	v5.d[1], x14
mov	v2.s[1], w14
add	v19.2d, v18.2d, v0.2d
ldp	x15, x14, [x24]
add	x16, x16, #0x20
add	x17, x17, #0x20
shrn	v3.2s, v5.2d, #0x20
xtn2	v2.4s, v19.2d
add	x14, x14, #0x20
add	x15, x15, #0x20
addhn2	v3.4s, v18.2d, v0.2d
ldr	q18, [sp, #0x50]
stp	q3, q2, [sp, #0x30]
L_2010:
ldp	q24, q27, [x17, #-0x20]
subs	x18, x18, #0x1
ldp	q25, q30, [x16, #-0x20]
add	v11.4s, v6.4s, v17.4s
ldp	q28, q26, [x15, #-0x20]
add	v12.4s, v7.4s, v21.4s
ldp	q31, q29, [x14, #-0x20]
csel	w3, w8, wzr, eq
trn1	v8.4s, v24.4s, v25.4s
trn1	v9.4s, v27.4s, v30.4s
add	v22.4s, v22.4s, v16.4s
add	v23.4s, v23.4s, v20.4s
orr	w0, w3, w0
trn2	v24.4s, v24.4s, v25.4s
trn1	v19.4s, v28.4s, v31.4s
trn1	v0.4s, v26.4s, v29.4s
and	w0, w0, #0xff
trn2	v31.4s, v28.4s, v31.4s
trn2	v26.4s, v26.4s, v29.4s
trn2	v29.4s, v27.4s, v30.4s
zip2	v1.2d, v19.2d, v8.2d
zip2	v2.2d, v0.2d, v9.2d
mov	v19.d[1], v8.d[0]
mov	v0.d[1], v9.d[0]
dup	v9.4s, w0
mov	w0, w19
str	q1, [sp, #0xa0]
add	v8.4s, v11.4s, v1.4s
add	v10.4s, v12.4s, v2.4s
stur	q0, [x29, #-0x80]
add	v11.4s, v22.4s, v19.4s
add	v12.4s, v23.4s, v0.4s
ldp	q1, q0, [sp, #0x30]
str	q2, [sp, #0xe0]
eor	v23.16b, v10.16b, v9.16b
zip2	v2.2d, v26.2d, v29.2d
mov	v26.d[1], v29.d[0]
str	q19, [sp, #0xc0]
eor	v9.16b, v11.16b, v0.16b
movi	v0.4s, #0x40
eor	v22.16b, v8.16b, v1.16b
rev32	v15.8h, v23.8h
dup	v1.4s, w11
stur	q26, [x29, #-0xe0]
rev32	v14.8h, v22.8h
rev32	v9.8h, v9.8h
dup	v22.4s, w12
eor	v13.16b, v12.16b, v0.16b
ldr	q0, [sp, #0x20]
stur	q2, [x29, #-0xb0]
add	v28.4s, v15.4s, v22.4s
rev32	v13.8h, v13.8h
add	v23.4s, v14.4s, v0.4s
add	v22.4s, v9.4s, v18.4s
zip2	v0.2d, v31.2d, v24.2d
mov	v31.d[1], v24.d[0]
add	v24.4s, v12.4s, v26.4s
eor	v21.16b, v28.16b, v21.16b
eor	v16.16b, v22.16b, v16.16b
add	v27.4s, v13.4s, v1.4s
eor	v1.16b, v23.16b, v17.16b
shl	v6.4s, v21.4s, #0x14
stp	q31, q0, [x29, #-0xa0]
shl	v4.4s, v16.4s, #0x14
eor	v30.16b, v27.16b, v20.16b
shl	v7.4s, v1.4s, #0x14
sri	v6.4s, v21.4s, #0xc
add	v21.4s, v10.4s, v2.4s
sri	v4.4s, v16.4s, #0xc
add	v16.4s, v11.4s, v31.4s
shl	v17.4s, v30.4s, #0x14
sri	v7.4s, v1.4s, #0xc
add	v1.4s, v8.4s, v0.4s
ldp	q12, q10, [x14], #0x40
add	v8.4s, v21.4s, v6.4s
sri	v17.4s, v30.4s, #0xc
add	v25.4s, v16.4s, v4.4s
add	v26.4s, v1.4s, v7.4s
eor	v29.16b, v25.16b, v9.16b
add	v11.4s, v24.4s, v17.4s
eor	v21.16b, v26.16b, v14.16b
ldr	q14, [x13]
eor	v24.16b, v8.16b, v15.16b
tbl	v15.16b, { v29.16b }, v14.16b
eor	v30.16b, v11.16b, v13.16b
tbl	v13.16b, { v21.16b }, v14.16b
tbl	v19.16b, { v24.16b }, v14.16b
ldp	q21, q1, [x17], #0x40
tbl	v20.16b, { v30.16b }, v14.16b
ldp	q30, q29, [x15], #0x40
add	v9.4s, v23.4s, v13.4s
ldp	q23, q24, [x16], #0x40
stur	q1, [x29, #-0xd0]
add	v22.4s, v22.4s, v15.4s
add	v28.4s, v28.4s, v19.4s
trn1	v5.4s, v30.4s, v12.4s
trn1	v3.4s, v29.4s, v10.4s
trn1	v0.4s, v21.4s, v23.4s
trn1	v2.4s, v1.4s, v24.4s
add	v27.4s, v27.4s, v20.4s
eor	v7.16b, v9.16b, v7.16b
eor	v16.16b, v22.16b, v4.16b
eor	v6.16b, v28.16b, v6.16b
trn2	v21.4s, v21.4s, v23.4s
trn2	v23.4s, v29.4s, v10.4s
mov	v1.16b, v5.16b
eor	v17.16b, v27.16b, v17.16b
zip2	v18.2d, v5.2d, v0.2d
shl	v4.4s, v7.4s, #0x19
zip2	v31.2d, v3.2d, v2.2d
mov	v1.d[1], v0.d[0]
mov	v0.16b, v3.16b
shl	v3.4s, v6.4s, #0x19
sri	v4.4s, v7.4s, #0x7
add	v7.4s, v8.4s, v31.4s
str	q31, [sp, #0x80]
mov	v0.d[1], v2.d[0]
shl	v2.4s, v16.4s, #0x19
sri	v3.4s, v6.4s, #0x7
mov	v5.16b, v1.16b
str	q1, [sp, #0xd0]
shl	v1.4s, v17.4s, #0x19
add	v6.4s, v26.4s, v18.4s
mov	v26.16b, v18.16b
sri	v2.4s, v16.4s, #0x7
sri	v1.4s, v17.4s, #0x7
add	v16.4s, v25.4s, v5.4s
add	v17.4s, v11.4s, v0.4s
trn2	v11.4s, v30.4s, v12.4s
stur	q0, [x29, #-0xc0]
ldur	q0, [x29, #-0xd0]
str	q26, [sp, #0xb0]
add	v5.4s, v16.4s, v4.4s
add	v17.4s, v17.4s, v3.4s
add	v7.4s, v7.4s, v2.4s
add	v6.4s, v6.4s, v1.4s
zip2	v25.2d, v11.2d, v21.2d
mov	v11.d[1], v21.d[0]
eor	v19.16b, v5.16b, v19.16b
eor	v31.16b, v17.16b, v13.16b
eor	v18.16b, v7.16b, v20.16b
eor	v8.16b, v6.16b, v15.16b
trn2	v20.4s, v0.4s, v24.4s
ldur	q15, [x29, #-0xb0]
rev32	v19.8h, v19.8h
rev32	v31.8h, v31.8h
rev32	v18.8h, v18.8h
rev32	v8.8h, v8.8h
mov	v24.16b, v11.16b
add	v27.4s, v27.4s, v19.4s
add	v22.4s, v22.4s, v31.4s
add	v9.4s, v9.4s, v18.4s
add	v10.4s, v28.4s, v8.4s
zip2	v28.2d, v23.2d, v20.2d
mov	v29.16b, v24.16b
stur	q24, [x29, #-0xd0]
eor	v4.16b, v27.16b, v4.16b
eor	v3.16b, v22.16b, v3.16b
eor	v2.16b, v9.16b, v2.16b
eor	v0.16b, v10.16b, v1.16b
mov	v1.16b, v23.16b
str	q28, [sp, #0x90]
shl	v21.4s, v4.4s, #0x14
shl	v11.4s, v3.4s, #0x14
shl	v13.4s, v2.4s, #0x14
shl	v12.4s, v0.4s, #0x14
mov	v1.d[1], v20.d[0]
sri	v21.4s, v4.4s, #0xc
sri	v11.4s, v3.4s, #0xc
sri	v13.4s, v2.4s, #0xc
sri	v12.4s, v0.4s, #0xc
add	v0.4s, v5.4s, v24.4s
add	v3.4s, v7.4s, v28.4s
mov	v16.16b, v1.16b
add	v1.4s, v17.4s, v1.4s
add	v2.4s, v6.4s, v25.4s
mov	v5.16b, v25.16b
ldp	q25, q30, [x29, #-0x90]
add	v0.4s, v0.4s, v21.4s
add	v3.4s, v3.4s, v13.4s
add	v1.4s, v1.4s, v11.4s
add	v2.4s, v2.4s, v12.4s
mov	v24.16b, v16.16b
stp	q5, q24, [sp, #0x60]
eor	v4.16b, v0.16b, v19.16b
eor	v17.16b, v3.16b, v18.16b
add	v3.4s, v3.4s, v30.4s
eor	v6.16b, v1.16b, v31.16b
eor	v7.16b, v2.16b, v8.16b
add	v2.4s, v2.4s, v25.4s
add	v1.4s, v1.4s, v15.4s
tbl	v4.16b, { v4.16b }, v14.16b
tbl	v17.16b, { v17.16b }, v14.16b
tbl	v6.16b, { v6.16b }, v14.16b
tbl	v7.16b, { v7.16b }, v14.16b
add	v18.4s, v27.4s, v4.4s
add	v19.4s, v22.4s, v6.4s
add	v22.4s, v9.4s, v17.4s
add	v20.4s, v10.4s, v7.4s
eor	v21.16b, v18.16b, v21.16b
eor	v31.16b, v22.16b, v13.16b
eor	v23.16b, v19.16b, v11.16b
eor	v27.16b, v20.16b, v12.16b
ldr	q13, [sp, #0xa0]
ldr	q12, [sp, #0xe0]
shl	v8.4s, v21.4s, #0x19
shl	v11.4s, v31.4s, #0x19
shl	v9.4s, v23.4s, #0x19
shl	v10.4s, v27.4s, #0x19
add	v0.4s, v0.4s, v13.4s
sri	v8.4s, v21.4s, #0x7
sri	v11.4s, v31.4s, #0x7
sri	v9.4s, v23.4s, #0x7
sri	v10.4s, v27.4s, #0x7
add	v2.4s, v2.4s, v8.4s
add	v0.4s, v0.4s, v11.4s
add	v3.4s, v3.4s, v9.4s
add	v1.4s, v1.4s, v10.4s
eor	v6.16b, v2.16b, v6.16b
add	v2.4s, v2.4s, v26.4s
eor	v7.16b, v0.16b, v7.16b
eor	v4.16b, v3.16b, v4.16b
eor	v17.16b, v1.16b, v17.16b
add	v0.4s, v0.4s, v12.4s
add	v3.4s, v3.4s, v16.4s
ldur	q16, [x29, #-0xc0]
rev32	v6.8h, v6.8h
rev32	v7.8h, v7.8h
rev32	v4.8h, v4.8h
rev32	v17.8h, v17.8h
add	v21.4s, v22.4s, v6.4s
add	v19.4s, v19.4s, v7.4s
add	v20.4s, v20.4s, v4.4s
add	v18.4s, v18.4s, v17.4s
eor	v22.16b, v21.16b, v8.16b
eor	v27.16b, v19.16b, v11.16b
eor	v23.16b, v20.16b, v9.16b
eor	v31.16b, v18.16b, v10.16b
shl	v8.4s, v22.4s, #0x14
shl	v10.4s, v27.4s, #0x14
shl	v9.4s, v23.4s, #0x14
shl	v11.4s, v31.4s, #0x14
sri	v8.4s, v22.4s, #0xc
ldr	q22, [sp, #0xc0]
sri	v10.4s, v27.4s, #0xc
sri	v9.4s, v23.4s, #0xc
sri	v11.4s, v31.4s, #0xc
add	v1.4s, v1.4s, v22.4s
add	v2.4s, v2.4s, v8.4s
add	v0.4s, v0.4s, v10.4s
add	v3.4s, v3.4s, v9.4s
add	v1.4s, v1.4s, v11.4s
eor	v6.16b, v2.16b, v6.16b
add	v2.4s, v2.4s, v16.4s
eor	v7.16b, v0.16b, v7.16b
eor	v4.16b, v3.16b, v4.16b
eor	v17.16b, v1.16b, v17.16b
add	v3.4s, v3.4s, v28.4s
add	v1.4s, v1.4s, v29.4s
ldr	q28, [sp, #0xd0]
tbl	v6.16b, { v6.16b }, v14.16b
mov	v29.16b, v5.16b
tbl	v7.16b, { v7.16b }, v14.16b
tbl	v4.16b, { v4.16b }, v14.16b
tbl	v17.16b, { v17.16b }, v14.16b
add	v21.4s, v21.4s, v6.4s
add	v19.4s, v19.4s, v7.4s
add	v20.4s, v20.4s, v4.4s
add	v18.4s, v18.4s, v17.4s
eor	v22.16b, v21.16b, v8.16b
eor	v27.16b, v19.16b, v10.16b
eor	v23.16b, v20.16b, v9.16b
eor	v31.16b, v18.16b, v11.16b
shl	v8.4s, v22.4s, #0x19
shl	v10.4s, v27.4s, #0x19
shl	v9.4s, v23.4s, #0x19
shl	v11.4s, v31.4s, #0x19
sri	v8.4s, v22.4s, #0x7
ldur	q22, [x29, #-0xa0]
sri	v10.4s, v27.4s, #0x7
sri	v9.4s, v23.4s, #0x7
sri	v11.4s, v31.4s, #0x7
add	v0.4s, v0.4s, v22.4s
add	v0.4s, v0.4s, v8.4s
add	v3.4s, v3.4s, v10.4s
add	v1.4s, v1.4s, v9.4s
add	v2.4s, v2.4s, v11.4s
eor	v4.16b, v0.16b, v4.16b
eor	v17.16b, v3.16b, v17.16b
eor	v6.16b, v1.16b, v6.16b
eor	v7.16b, v2.16b, v7.16b
add	v0.4s, v0.4s, v5.4s
ldr	q5, [sp, #0x80]
add	v3.4s, v3.4s, v28.4s
rev32	v4.8h, v4.8h
rev32	v17.8h, v17.8h
rev32	v6.8h, v6.8h
rev32	v7.8h, v7.8h
add	v1.4s, v1.4s, v5.4s
add	v18.4s, v18.4s, v4.4s
add	v21.4s, v21.4s, v17.4s
add	v19.4s, v19.4s, v6.4s
add	v20.4s, v20.4s, v7.4s
eor	v22.16b, v18.16b, v8.16b
eor	v31.16b, v21.16b, v10.16b
eor	v23.16b, v19.16b, v9.16b
eor	v27.16b, v20.16b, v11.16b
shl	v8.4s, v22.4s, #0x14
shl	v11.4s, v31.4s, #0x14
shl	v9.4s, v23.4s, #0x14
shl	v10.4s, v27.4s, #0x14
sri	v8.4s, v22.4s, #0xc
sri	v11.4s, v31.4s, #0xc
ldur	q22, [x29, #-0xe0]
sri	v9.4s, v23.4s, #0xc
sri	v10.4s, v27.4s, #0xc
add	v2.4s, v2.4s, v22.4s
add	v0.4s, v0.4s, v8.4s
add	v3.4s, v3.4s, v11.4s
add	v1.4s, v1.4s, v9.4s
add	v2.4s, v2.4s, v10.4s
eor	v4.16b, v0.16b, v4.16b
eor	v17.16b, v3.16b, v17.16b
add	v0.4s, v0.4s, v25.4s
eor	v6.16b, v1.16b, v6.16b
eor	v7.16b, v2.16b, v7.16b
add	v2.4s, v2.4s, v26.4s
add	v1.4s, v1.4s, v24.4s
add	v3.4s, v3.4s, v15.4s
ldur	q26, [x29, #-0xe0]
tbl	v4.16b, { v4.16b }, v14.16b
tbl	v17.16b, { v17.16b }, v14.16b
mov	v15.16b, v5.16b
tbl	v6.16b, { v6.16b }, v14.16b
tbl	v7.16b, { v7.16b }, v14.16b
mov	v25.16b, v16.16b
add	v18.4s, v18.4s, v4.4s
add	v21.4s, v21.4s, v17.4s
add	v19.4s, v19.4s, v6.4s
add	v20.4s, v20.4s, v7.4s
eor	v22.16b, v18.16b, v8.16b
eor	v31.16b, v21.16b, v11.16b
eor	v23.16b, v19.16b, v9.16b
eor	v27.16b, v20.16b, v10.16b
shl	v8.4s, v22.4s, #0x19
shl	v11.4s, v31.4s, #0x19
shl	v9.4s, v23.4s, #0x19
shl	v10.4s, v27.4s, #0x19
sri	v8.4s, v22.4s, #0x7
sri	v11.4s, v31.4s, #0x7
sri	v9.4s, v23.4s, #0x7
sri	v10.4s, v27.4s, #0x7
add	v2.4s, v2.4s, v8.4s
add	v0.4s, v0.4s, v11.4s
add	v3.4s, v3.4s, v9.4s
add	v1.4s, v1.4s, v10.4s
eor	v6.16b, v2.16b, v6.16b
eor	v7.16b, v0.16b, v7.16b
add	v2.4s, v2.4s, v16.4s
eor	v4.16b, v3.16b, v4.16b
eor	v17.16b, v1.16b, v17.16b
add	v0.4s, v0.4s, v30.4s
add	v3.4s, v3.4s, v5.4s
add	v1.4s, v1.4s, v13.4s
ldur	q30, [x29, #-0xd0]
rev32	v6.8h, v6.8h
rev32	v7.8h, v7.8h
ldur	q5, [x29, #-0xa0]
rev32	v4.8h, v4.8h
rev32	v17.8h, v17.8h
ldr	q16, [sp, #0x90]
ldr	q13, [sp, #0xb0]
add	v21.4s, v21.4s, v6.4s
add	v19.4s, v19.4s, v7.4s
add	v20.4s, v20.4s, v4.4s
add	v18.4s, v18.4s, v17.4s
eor	v22.16b, v21.16b, v8.16b
eor	v27.16b, v19.16b, v11.16b
eor	v23.16b, v20.16b, v9.16b
eor	v31.16b, v18.16b, v10.16b
shl	v8.4s, v22.4s, #0x14
shl	v10.4s, v27.4s, #0x14
shl	v9.4s, v23.4s, #0x14
shl	v11.4s, v31.4s, #0x14
sri	v8.4s, v22.4s, #0xc
sri	v10.4s, v27.4s, #0xc
sri	v9.4s, v23.4s, #0xc
sri	v11.4s, v31.4s, #0xc
add	v2.4s, v2.4s, v8.4s
add	v0.4s, v0.4s, v10.4s
add	v3.4s, v3.4s, v9.4s
add	v1.4s, v1.4s, v11.4s
eor	v6.16b, v2.16b, v6.16b
eor	v7.16b, v0.16b, v7.16b
add	v0.4s, v0.4s, v12.4s
eor	v4.16b, v3.16b, v4.16b
eor	v17.16b, v1.16b, v17.16b
add	v3.4s, v3.4s, v28.4s
add	v1.4s, v1.4s, v29.4s
add	v2.4s, v2.4s, v30.4s
ldr	q28, [sp, #0xc0]
tbl	v6.16b, { v6.16b }, v14.16b
tbl	v7.16b, { v7.16b }, v14.16b
mov	v29.16b, v24.16b
tbl	v4.16b, { v4.16b }, v14.16b
tbl	v17.16b, { v17.16b }, v14.16b
mov	v12.16b, v25.16b
add	v21.4s, v21.4s, v6.4s
add	v19.4s, v19.4s, v7.4s
add	v20.4s, v20.4s, v4.4s
add	v18.4s, v18.4s, v17.4s
eor	v22.16b, v21.16b, v8.16b
eor	v27.16b, v19.16b, v10.16b
eor	v23.16b, v20.16b, v9.16b
eor	v31.16b, v18.16b, v11.16b
shl	v8.4s, v22.4s, #0x19
shl	v10.4s, v27.4s, #0x19
shl	v9.4s, v23.4s, #0x19
shl	v11.4s, v31.4s, #0x19
sri	v8.4s, v22.4s, #0x7
sri	v10.4s, v27.4s, #0x7
sri	v9.4s, v23.4s, #0x7
sri	v11.4s, v31.4s, #0x7
add	v0.4s, v0.4s, v8.4s
add	v3.4s, v3.4s, v10.4s
add	v1.4s, v1.4s, v9.4s
add	v2.4s, v2.4s, v11.4s
eor	v4.16b, v0.16b, v4.16b
eor	v17.16b, v3.16b, v17.16b
add	v0.4s, v0.4s, v26.4s
eor	v6.16b, v1.16b, v6.16b
eor	v7.16b, v2.16b, v7.16b
add	v3.4s, v3.4s, v5.4s
add	v1.4s, v1.4s, v16.4s
add	v2.4s, v2.4s, v28.4s
rev32	v4.8h, v4.8h
rev32	v17.8h, v17.8h
rev32	v6.8h, v6.8h
rev32	v7.8h, v7.8h
add	v18.4s, v18.4s, v4.4s
add	v21.4s, v21.4s, v17.4s
add	v19.4s, v19.4s, v6.4s
add	v20.4s, v20.4s, v7.4s
eor	v22.16b, v18.16b, v8.16b
eor	v31.16b, v21.16b, v10.16b
eor	v23.16b, v19.16b, v9.16b
eor	v27.16b, v20.16b, v11.16b
shl	v8.4s, v22.4s, #0x14
shl	v11.4s, v31.4s, #0x14
shl	v9.4s, v23.4s, #0x14
shl	v10.4s, v27.4s, #0x14
sri	v8.4s, v22.4s, #0xc
sri	v11.4s, v31.4s, #0xc
sri	v9.4s, v23.4s, #0xc
sri	v10.4s, v27.4s, #0xc
add	v0.4s, v0.4s, v8.4s
add	v3.4s, v3.4s, v11.4s
add	v1.4s, v1.4s, v9.4s
add	v2.4s, v2.4s, v10.4s
eor	v4.16b, v0.16b, v4.16b
eor	v17.16b, v3.16b, v17.16b
add	v0.4s, v0.4s, v13.4s
eor	v6.16b, v1.16b, v6.16b
eor	v7.16b, v2.16b, v7.16b
add	v2.4s, v2.4s, v25.4s
add	v3.4s, v3.4s, v24.4s
add	v1.4s, v1.4s, v15.4s
mov	v24.16b, v30.16b
tbl	v4.16b, { v4.16b }, v14.16b
tbl	v17.16b, { v17.16b }, v14.16b
mov	v25.16b, v15.16b
tbl	v6.16b, { v6.16b }, v14.16b
tbl	v7.16b, { v7.16b }, v14.16b
add	v18.4s, v18.4s, v4.4s
add	v21.4s, v21.4s, v17.4s
add	v19.4s, v19.4s, v6.4s
add	v20.4s, v20.4s, v7.4s
eor	v22.16b, v18.16b, v8.16b
eor	v31.16b, v21.16b, v11.16b
eor	v23.16b, v19.16b, v9.16b
eor	v27.16b, v20.16b, v10.16b
shl	v8.4s, v22.4s, #0x19
shl	v11.4s, v31.4s, #0x19
shl	v9.4s, v23.4s, #0x19
shl	v10.4s, v27.4s, #0x19
sri	v8.4s, v22.4s, #0x7
sri	v11.4s, v31.4s, #0x7
sri	v9.4s, v23.4s, #0x7
sri	v10.4s, v27.4s, #0x7
add	v2.4s, v2.4s, v8.4s
add	v0.4s, v0.4s, v11.4s
add	v3.4s, v3.4s, v9.4s
add	v1.4s, v1.4s, v10.4s
eor	v6.16b, v2.16b, v6.16b
eor	v7.16b, v0.16b, v7.16b
add	v2.4s, v2.4s, v30.4s
eor	v4.16b, v3.16b, v4.16b
eor	v17.16b, v1.16b, v17.16b
add	v3.4s, v3.4s, v16.4s
ldr	q30, [sp, #0x60]
rev32	v6.8h, v6.8h
rev32	v7.8h, v7.8h
rev32	v4.8h, v4.8h
rev32	v17.8h, v17.8h
add	v21.4s, v21.4s, v6.4s
add	v19.4s, v19.4s, v7.4s
add	v20.4s, v20.4s, v4.4s
add	v18.4s, v18.4s, v17.4s
eor	v22.16b, v21.16b, v8.16b
eor	v27.16b, v19.16b, v11.16b
eor	v23.16b, v20.16b, v9.16b
eor	v31.16b, v18.16b, v10.16b
shl	v8.4s, v22.4s, #0x14
shl	v10.4s, v27.4s, #0x14
shl	v9.4s, v23.4s, #0x14
shl	v11.4s, v31.4s, #0x14
sri	v8.4s, v22.4s, #0xc
ldur	q22, [x29, #-0xb0]
sri	v10.4s, v27.4s, #0xc
sri	v9.4s, v23.4s, #0xc
sri	v11.4s, v31.4s, #0xc
add	v0.4s, v0.4s, v22.4s
ldur	q22, [x29, #-0x90]
add	v1.4s, v1.4s, v22.4s
add	v2.4s, v2.4s, v8.4s
add	v0.4s, v0.4s, v10.4s
add	v3.4s, v3.4s, v9.4s
add	v1.4s, v1.4s, v11.4s
eor	v6.16b, v2.16b, v6.16b
add	v2.4s, v2.4s, v30.4s
eor	v7.16b, v0.16b, v7.16b
eor	v4.16b, v3.16b, v4.16b
add	v3.4s, v3.4s, v5.4s
ldp	q5, q15, [sp, #0xd0]
eor	v17.16b, v1.16b, v17.16b
tbl	v6.16b, { v6.16b }, v14.16b
add	v1.4s, v1.4s, v26.4s
tbl	v7.16b, { v7.16b }, v14.16b
tbl	v4.16b, { v4.16b }, v14.16b
ldr	q26, [sp, #0xa0]
tbl	v17.16b, { v17.16b }, v14.16b
add	v21.4s, v21.4s, v6.4s
add	v19.4s, v19.4s, v7.4s
add	v20.4s, v20.4s, v4.4s
add	v18.4s, v18.4s, v17.4s
eor	v22.16b, v21.16b, v8.16b
eor	v27.16b, v19.16b, v10.16b
eor	v23.16b, v20.16b, v9.16b
eor	v31.16b, v18.16b, v11.16b
shl	v8.4s, v22.4s, #0x19
shl	v10.4s, v27.4s, #0x19
shl	v9.4s, v23.4s, #0x19
shl	v11.4s, v31.4s, #0x19
sri	v8.4s, v22.4s, #0x7
ldur	q22, [x29, #-0x80]
sri	v10.4s, v27.4s, #0x7
sri	v9.4s, v23.4s, #0x7
add	v0.4s, v0.4s, v22.4s
sri	v11.4s, v31.4s, #0x7
add	v0.4s, v0.4s, v8.4s
add	v3.4s, v3.4s, v10.4s
add	v1.4s, v1.4s, v9.4s
add	v2.4s, v2.4s, v11.4s
eor	v4.16b, v0.16b, v4.16b
eor	v17.16b, v3.16b, v17.16b
eor	v6.16b, v1.16b, v6.16b
add	v0.4s, v0.4s, v28.4s
add	v3.4s, v3.4s, v15.4s
add	v1.4s, v1.4s, v5.4s
eor	v7.16b, v2.16b, v7.16b
add	v2.4s, v2.4s, v26.4s
rev32	v4.8h, v4.8h
rev32	v17.8h, v17.8h
rev32	v6.8h, v6.8h
rev32	v7.8h, v7.8h
add	v18.4s, v18.4s, v4.4s
add	v21.4s, v21.4s, v17.4s
add	v19.4s, v19.4s, v6.4s
add	v20.4s, v20.4s, v7.4s
eor	v22.16b, v18.16b, v8.16b
eor	v31.16b, v21.16b, v10.16b
eor	v23.16b, v19.16b, v9.16b
eor	v27.16b, v20.16b, v11.16b
shl	v8.4s, v22.4s, #0x14
shl	v11.4s, v31.4s, #0x14
shl	v9.4s, v23.4s, #0x14
shl	v10.4s, v27.4s, #0x14
sri	v8.4s, v22.4s, #0xc
sri	v11.4s, v31.4s, #0xc
sri	v9.4s, v23.4s, #0xc
sri	v10.4s, v27.4s, #0xc
add	v0.4s, v0.4s, v8.4s
add	v3.4s, v3.4s, v11.4s
add	v1.4s, v1.4s, v9.4s
add	v2.4s, v2.4s, v10.4s
eor	v4.16b, v0.16b, v4.16b
eor	v17.16b, v3.16b, v17.16b
eor	v6.16b, v1.16b, v6.16b
add	v0.4s, v0.4s, v12.4s
add	v3.4s, v3.4s, v25.4s
add	v1.4s, v1.4s, v16.4s
eor	v7.16b, v2.16b, v7.16b
add	v2.4s, v2.4s, v24.4s
ldur	q25, [x29, #-0xe0]
tbl	v4.16b, { v4.16b }, v14.16b
tbl	v17.16b, { v17.16b }, v14.16b
tbl	v6.16b, { v6.16b }, v14.16b
mov	v12.16b, v16.16b
mov	v24.16b, v26.16b
ldur	q16, [x29, #-0x80]
tbl	v7.16b, { v7.16b }, v14.16b
add	v18.4s, v18.4s, v4.4s
add	v21.4s, v21.4s, v17.4s
add	v19.4s, v19.4s, v6.4s
add	v20.4s, v20.4s, v7.4s
eor	v22.16b, v18.16b, v8.16b
eor	v31.16b, v21.16b, v11.16b
eor	v23.16b, v19.16b, v9.16b
eor	v27.16b, v20.16b, v10.16b
shl	v8.4s, v22.4s, #0x19
shl	v11.4s, v31.4s, #0x19
shl	v9.4s, v23.4s, #0x19
shl	v10.4s, v27.4s, #0x19
sri	v8.4s, v22.4s, #0x7
sri	v11.4s, v31.4s, #0x7
sri	v9.4s, v23.4s, #0x7
sri	v10.4s, v27.4s, #0x7
add	v2.4s, v2.4s, v8.4s
add	v0.4s, v0.4s, v11.4s
add	v3.4s, v3.4s, v9.4s
add	v1.4s, v1.4s, v10.4s
eor	v6.16b, v2.16b, v6.16b
eor	v7.16b, v0.16b, v7.16b
eor	v4.16b, v3.16b, v4.16b
add	v2.4s, v2.4s, v30.4s
add	v0.4s, v0.4s, v29.4s
add	v3.4s, v3.4s, v5.4s
eor	v17.16b, v1.16b, v17.16b
add	v1.4s, v1.4s, v13.4s
ldur	q13, [x29, #-0xb0]
rev32	v6.8h, v6.8h
rev32	v7.8h, v7.8h
rev32	v4.8h, v4.8h
rev32	v17.8h, v17.8h
add	v21.4s, v21.4s, v6.4s
add	v19.4s, v19.4s, v7.4s
add	v20.4s, v20.4s, v4.4s
add	v18.4s, v18.4s, v17.4s
eor	v22.16b, v21.16b, v8.16b
eor	v27.16b, v19.16b, v11.16b
eor	v23.16b, v20.16b, v9.16b
eor	v31.16b, v18.16b, v10.16b
shl	v8.4s, v22.4s, #0x14
shl	v10.4s, v27.4s, #0x14
shl	v9.4s, v23.4s, #0x14
shl	v11.4s, v31.4s, #0x14
sri	v8.4s, v22.4s, #0xc
sri	v10.4s, v27.4s, #0xc
sri	v9.4s, v23.4s, #0xc
sri	v11.4s, v31.4s, #0xc
add	v2.4s, v2.4s, v8.4s
add	v0.4s, v0.4s, v10.4s
add	v3.4s, v3.4s, v9.4s
add	v1.4s, v1.4s, v11.4s
eor	v6.16b, v2.16b, v6.16b
eor	v7.16b, v0.16b, v7.16b
eor	v4.16b, v3.16b, v4.16b
add	v0.4s, v0.4s, v13.4s
add	v3.4s, v3.4s, v15.4s
add	v2.4s, v2.4s, v25.4s
eor	v17.16b, v1.16b, v17.16b
add	v1.4s, v1.4s, v28.4s
ldr	q15, [sp, #0x70]
tbl	v6.16b, { v6.16b }, v14.16b
tbl	v7.16b, { v7.16b }, v14.16b
tbl	v4.16b, { v4.16b }, v14.16b
tbl	v17.16b, { v17.16b }, v14.16b
add	v21.4s, v21.4s, v6.4s
add	v19.4s, v19.4s, v7.4s
add	v20.4s, v20.4s, v4.4s
add	v18.4s, v18.4s, v17.4s
eor	v22.16b, v21.16b, v8.16b
eor	v27.16b, v19.16b, v10.16b
eor	v23.16b, v20.16b, v9.16b
eor	v31.16b, v18.16b, v11.16b
shl	v8.4s, v22.4s, #0x19
shl	v10.4s, v27.4s, #0x19
shl	v9.4s, v23.4s, #0x19
shl	v11.4s, v31.4s, #0x19
sri	v8.4s, v22.4s, #0x7
sri	v10.4s, v27.4s, #0x7
sri	v9.4s, v23.4s, #0x7
sri	v11.4s, v31.4s, #0x7
add	v0.4s, v0.4s, v8.4s
add	v3.4s, v3.4s, v10.4s
add	v1.4s, v1.4s, v9.4s
add	v2.4s, v2.4s, v11.4s
eor	v4.16b, v0.16b, v4.16b
eor	v17.16b, v3.16b, v17.16b
eor	v6.16b, v1.16b, v6.16b
add	v0.4s, v0.4s, v26.4s
ldp	q26, q29, [x29, #-0xa0]
eor	v7.16b, v2.16b, v7.16b
add	v3.4s, v3.4s, v16.4s
rev32	v4.8h, v4.8h
rev32	v17.8h, v17.8h
rev32	v6.8h, v6.8h
add	v1.4s, v1.4s, v26.4s
add	v2.4s, v2.4s, v29.4s
rev32	v7.8h, v7.8h
add	v18.4s, v18.4s, v4.4s
add	v21.4s, v21.4s, v17.4s
add	v19.4s, v19.4s, v6.4s
add	v20.4s, v20.4s, v7.4s
eor	v22.16b, v18.16b, v8.16b
eor	v31.16b, v21.16b, v10.16b
eor	v23.16b, v19.16b, v9.16b
eor	v27.16b, v20.16b, v11.16b
shl	v8.4s, v22.4s, #0x14
shl	v11.4s, v31.4s, #0x14
shl	v9.4s, v23.4s, #0x14
shl	v10.4s, v27.4s, #0x14
sri	v8.4s, v22.4s, #0xc
sri	v11.4s, v31.4s, #0xc
sri	v9.4s, v23.4s, #0xc
sri	v10.4s, v27.4s, #0xc
add	v0.4s, v0.4s, v8.4s
add	v3.4s, v3.4s, v11.4s
add	v1.4s, v1.4s, v9.4s
add	v2.4s, v2.4s, v10.4s
eor	v4.16b, v0.16b, v4.16b
eor	v17.16b, v3.16b, v17.16b
eor	v6.16b, v1.16b, v6.16b
add	v1.4s, v1.4s, v5.4s
add	v3.4s, v3.4s, v12.4s
ldr	q12, [sp, #0x80]
eor	v7.16b, v2.16b, v7.16b
add	v2.4s, v2.4s, v30.4s
tbl	v4.16b, { v4.16b }, v14.16b
tbl	v17.16b, { v17.16b }, v14.16b
tbl	v6.16b, { v6.16b }, v14.16b
tbl	v7.16b, { v7.16b }, v14.16b
add	v18.4s, v18.4s, v4.4s
add	v21.4s, v21.4s, v17.4s
add	v19.4s, v19.4s, v6.4s
add	v20.4s, v20.4s, v7.4s
eor	v22.16b, v18.16b, v8.16b
eor	v31.16b, v21.16b, v11.16b
eor	v23.16b, v19.16b, v9.16b
eor	v27.16b, v20.16b, v10.16b
shl	v8.4s, v22.4s, #0x19
shl	v11.4s, v31.4s, #0x19
shl	v9.4s, v23.4s, #0x19
shl	v10.4s, v27.4s, #0x19
sri	v8.4s, v22.4s, #0x7
ldp	q22, q5, [x29, #-0xd0]
sri	v11.4s, v31.4s, #0x7
sri	v9.4s, v23.4s, #0x7
sri	v10.4s, v27.4s, #0x7
add	v0.4s, v0.4s, v22.4s
add	v2.4s, v2.4s, v8.4s
add	v0.4s, v0.4s, v11.4s
add	v3.4s, v3.4s, v9.4s
add	v1.4s, v1.4s, v10.4s
eor	v6.16b, v2.16b, v6.16b
add	v2.4s, v2.4s, v25.4s
eor	v7.16b, v0.16b, v7.16b
eor	v4.16b, v3.16b, v4.16b
add	v0.4s, v0.4s, v12.4s
eor	v17.16b, v1.16b, v17.16b
add	v3.4s, v3.4s, v26.4s
add	v1.4s, v1.4s, v5.4s
rev32	v6.8h, v6.8h
mov	v5.16b, v13.16b
rev32	v7.8h, v7.8h
rev32	v4.8h, v4.8h
rev32	v17.8h, v17.8h
add	v21.4s, v21.4s, v6.4s
add	v19.4s, v19.4s, v7.4s
add	v20.4s, v20.4s, v4.4s
add	v18.4s, v18.4s, v17.4s
eor	v22.16b, v21.16b, v8.16b
eor	v27.16b, v19.16b, v11.16b
eor	v23.16b, v20.16b, v9.16b
eor	v31.16b, v18.16b, v10.16b
shl	v8.4s, v22.4s, #0x14
shl	v10.4s, v27.4s, #0x14
shl	v9.4s, v23.4s, #0x14
shl	v11.4s, v31.4s, #0x14
sri	v8.4s, v22.4s, #0xc
sri	v10.4s, v27.4s, #0xc
sri	v9.4s, v23.4s, #0xc
sri	v11.4s, v31.4s, #0xc
add	v2.4s, v2.4s, v8.4s
add	v0.4s, v0.4s, v10.4s
add	v3.4s, v3.4s, v9.4s
add	v1.4s, v1.4s, v11.4s
eor	v6.16b, v2.16b, v6.16b
add	v2.4s, v2.4s, v28.4s
eor	v7.16b, v0.16b, v7.16b
eor	v4.16b, v3.16b, v4.16b
add	v3.4s, v3.4s, v16.4s
eor	v17.16b, v1.16b, v17.16b
add	v0.4s, v0.4s, v15.4s
add	v1.4s, v1.4s, v24.4s
tbl	v6.16b, { v6.16b }, v14.16b
mov	v16.16b, v29.16b
tbl	v7.16b, { v7.16b }, v14.16b
tbl	v4.16b, { v4.16b }, v14.16b
tbl	v17.16b, { v17.16b }, v14.16b
add	v21.4s, v21.4s, v6.4s
add	v19.4s, v19.4s, v7.4s
add	v20.4s, v20.4s, v4.4s
add	v18.4s, v18.4s, v17.4s
eor	v22.16b, v21.16b, v8.16b
eor	v27.16b, v19.16b, v10.16b
eor	v23.16b, v20.16b, v9.16b
eor	v31.16b, v18.16b, v11.16b
shl	v8.4s, v22.4s, #0x19
shl	v10.4s, v27.4s, #0x19
shl	v9.4s, v23.4s, #0x19
shl	v11.4s, v31.4s, #0x19
sri	v8.4s, v22.4s, #0x7
sri	v10.4s, v27.4s, #0x7
sri	v9.4s, v23.4s, #0x7
sri	v11.4s, v31.4s, #0x7
add	v0.4s, v0.4s, v8.4s
add	v3.4s, v3.4s, v10.4s
add	v1.4s, v1.4s, v9.4s
add	v2.4s, v2.4s, v11.4s
eor	v4.16b, v0.16b, v4.16b
add	v0.4s, v0.4s, v29.4s
ldr	q29, [sp, #0xe0]
eor	v17.16b, v3.16b, v17.16b
eor	v6.16b, v1.16b, v6.16b
add	v3.4s, v3.4s, v13.4s
eor	v7.16b, v2.16b, v7.16b
ldr	q13, [sp, #0xb0]
add	v1.4s, v1.4s, v29.4s
rev32	v4.8h, v4.8h
rev32	v17.8h, v17.8h
rev32	v6.8h, v6.8h
add	v2.4s, v2.4s, v13.4s
rev32	v7.8h, v7.8h
add	v18.4s, v18.4s, v4.4s
add	v21.4s, v21.4s, v17.4s
add	v19.4s, v19.4s, v6.4s
add	v20.4s, v20.4s, v7.4s
eor	v22.16b, v18.16b, v8.16b
eor	v23.16b, v21.16b, v10.16b
eor	v27.16b, v19.16b, v9.16b
eor	v31.16b, v20.16b, v11.16b
shl	v8.4s, v22.4s, #0x14
shl	v9.4s, v23.4s, #0x14
shl	v10.4s, v27.4s, #0x14
shl	v11.4s, v31.4s, #0x14
sri	v8.4s, v22.4s, #0xc
sri	v9.4s, v23.4s, #0xc
sri	v10.4s, v27.4s, #0xc
sri	v11.4s, v31.4s, #0xc
add	v0.4s, v0.4s, v8.4s
add	v3.4s, v3.4s, v9.4s
add	v1.4s, v1.4s, v10.4s
add	v2.4s, v2.4s, v11.4s
eor	v4.16b, v0.16b, v4.16b
add	v0.4s, v0.4s, v30.4s
eor	v17.16b, v3.16b, v17.16b
eor	v6.16b, v1.16b, v6.16b
add	v1.4s, v1.4s, v26.4s
eor	v7.16b, v2.16b, v7.16b
add	v2.4s, v2.4s, v25.4s
tbl	v4.16b, { v4.16b }, v14.16b
tbl	v17.16b, { v17.16b }, v14.16b
tbl	v6.16b, { v6.16b }, v14.16b
tbl	v7.16b, { v7.16b }, v14.16b
add	v18.4s, v18.4s, v4.4s
add	v21.4s, v21.4s, v17.4s
add	v19.4s, v19.4s, v6.4s
add	v20.4s, v20.4s, v7.4s
eor	v23.16b, v18.16b, v8.16b
eor	v22.16b, v21.16b, v9.16b
eor	v27.16b, v19.16b, v10.16b
eor	v31.16b, v20.16b, v11.16b
shl	v9.4s, v23.4s, #0x19
shl	v8.4s, v22.4s, #0x19
shl	v10.4s, v27.4s, #0x19
shl	v11.4s, v31.4s, #0x19
sri	v9.4s, v23.4s, #0x7
sri	v8.4s, v22.4s, #0x7
ldr	q22, [sp, #0xd0]
sri	v10.4s, v27.4s, #0x7
sri	v11.4s, v31.4s, #0x7
add	v3.4s, v3.4s, v22.4s
add	v2.4s, v2.4s, v9.4s
add	v0.4s, v0.4s, v8.4s
add	v3.4s, v3.4s, v10.4s
add	v1.4s, v1.4s, v11.4s
eor	v6.16b, v2.16b, v6.16b
add	v2.4s, v2.4s, v28.4s
eor	v7.16b, v0.16b, v7.16b
eor	v4.16b, v3.16b, v4.16b
eor	v17.16b, v1.16b, v17.16b
add	v3.4s, v3.4s, v29.4s
rev32	v6.8h, v6.8h
rev32	v7.8h, v7.8h
rev32	v4.8h, v4.8h
rev32	v17.8h, v17.8h
add	v21.4s, v21.4s, v6.4s
add	v19.4s, v19.4s, v7.4s
add	v20.4s, v20.4s, v4.4s
add	v18.4s, v18.4s, v17.4s
eor	v23.16b, v21.16b, v9.16b
ldr	q9, [sp, #0x90]
eor	v22.16b, v19.16b, v8.16b
eor	v25.16b, v20.16b, v10.16b
eor	v26.16b, v18.16b, v11.16b
add	v0.4s, v0.4s, v9.4s
shl	v30.4s, v23.4s, #0x14
shl	v27.4s, v22.4s, #0x14
shl	v31.4s, v25.4s, #0x14
shl	v8.4s, v26.4s, #0x14
sri	v30.4s, v23.4s, #0xc
sri	v27.4s, v22.4s, #0xc
ldur	q22, [x29, #-0xd0]
sri	v31.4s, v25.4s, #0xc
sri	v8.4s, v26.4s, #0xc
add	v1.4s, v1.4s, v22.4s
add	v2.4s, v2.4s, v30.4s
add	v0.4s, v0.4s, v27.4s
add	v3.4s, v3.4s, v31.4s
add	v1.4s, v1.4s, v8.4s
eor	v6.16b, v2.16b, v6.16b
add	v2.4s, v2.4s, v24.4s
eor	v7.16b, v0.16b, v7.16b
add	v0.4s, v0.4s, v12.4s
eor	v4.16b, v3.16b, v4.16b
eor	v17.16b, v1.16b, v17.16b
add	v3.4s, v3.4s, v5.4s
tbl	v6.16b, { v6.16b }, v14.16b
add	v1.4s, v1.4s, v16.4s
ldur	q5, [x29, #-0x80]
tbl	v7.16b, { v7.16b }, v14.16b
tbl	v4.16b, { v4.16b }, v14.16b
tbl	v17.16b, { v17.16b }, v14.16b
add	v21.4s, v21.4s, v6.4s
add	v19.4s, v19.4s, v7.4s
add	v20.4s, v20.4s, v4.4s
add	v18.4s, v18.4s, v17.4s
eor	v23.16b, v21.16b, v30.16b
eor	v22.16b, v19.16b, v27.16b
eor	v25.16b, v20.16b, v31.16b
eor	v26.16b, v18.16b, v8.16b
shl	v28.4s, v23.4s, #0x19
shl	v27.4s, v22.4s, #0x19
shl	v29.4s, v25.4s, #0x19
shl	v30.4s, v26.4s, #0x19
sri	v28.4s, v23.4s, #0x7
sri	v27.4s, v22.4s, #0x7
sri	v29.4s, v25.4s, #0x7
sri	v30.4s, v26.4s, #0x7
add	v0.4s, v0.4s, v28.4s
add	v3.4s, v3.4s, v27.4s
add	v1.4s, v1.4s, v29.4s
add	v2.4s, v2.4s, v30.4s
eor	v4.16b, v0.16b, v4.16b
add	v0.4s, v0.4s, v13.4s
eor	v17.16b, v3.16b, v17.16b
add	v3.4s, v3.4s, v15.4s
eor	v6.16b, v1.16b, v6.16b
eor	v7.16b, v2.16b, v7.16b
add	v1.4s, v1.4s, v5.4s
rev32	v4.8h, v4.8h
ldur	q5, [x29, #-0xc0]
rev32	v17.8h, v17.8h
rev32	v6.8h, v6.8h
rev32	v7.8h, v7.8h
add	v2.4s, v2.4s, v5.4s
add	v18.4s, v18.4s, v4.4s
add	v21.4s, v21.4s, v17.4s
add	v19.4s, v19.4s, v6.4s
add	v20.4s, v20.4s, v7.4s
eor	v23.16b, v18.16b, v28.16b
eor	v22.16b, v21.16b, v27.16b
eor	v25.16b, v19.16b, v29.16b
eor	v26.16b, v20.16b, v30.16b
shl	v28.4s, v23.4s, #0x14
shl	v27.4s, v22.4s, #0x14
shl	v29.4s, v25.4s, #0x14
shl	v30.4s, v26.4s, #0x14
sri	v28.4s, v23.4s, #0xc
sri	v27.4s, v22.4s, #0xc
sri	v29.4s, v25.4s, #0xc
sri	v30.4s, v26.4s, #0xc
add	v0.4s, v0.4s, v28.4s
add	v3.4s, v3.4s, v27.4s
add	v1.4s, v1.4s, v29.4s
add	v2.4s, v2.4s, v30.4s
eor	v4.16b, v0.16b, v4.16b
eor	v5.16b, v3.16b, v17.16b
eor	v6.16b, v1.16b, v6.16b
eor	v7.16b, v2.16b, v7.16b
tbl	v4.16b, { v4.16b }, v14.16b
tbl	v5.16b, { v5.16b }, v14.16b
tbl	v17.16b, { v6.16b }, v14.16b
tbl	v16.16b, { v7.16b }, v14.16b
add	v7.4s, v18.4s, v4.4s
add	v6.4s, v21.4s, v5.4s
add	v18.4s, v19.4s, v17.4s
add	v19.4s, v20.4s, v16.4s
eor	v21.16b, v7.16b, v28.16b
eor	v20.16b, v6.16b, v27.16b
eor	v6.16b, v6.16b, v2.16b
eor	v22.16b, v18.16b, v29.16b
eor	v23.16b, v19.16b, v30.16b
shl	v25.4s, v21.4s, #0x19
shl	v24.4s, v20.4s, #0x19
shl	v26.4s, v22.4s, #0x19
shl	v27.4s, v23.4s, #0x19
sri	v25.4s, v21.4s, #0x7
sri	v24.4s, v20.4s, #0x7
sri	v26.4s, v22.4s, #0x7
sri	v27.4s, v23.4s, #0x7
eor	v22.16b, v18.16b, v0.16b
eor	v23.16b, v7.16b, v1.16b
eor	v7.16b, v19.16b, v3.16b
ldr	q18, [sp, #0x50]
eor	v17.16b, v25.16b, v17.16b
eor	v16.16b, v24.16b, v16.16b
eor	v20.16b, v27.16b, v5.16b
eor	v21.16b, v26.16b, v4.16b
cbnz	x18, L_2010
b	L_1f00
L_3030:
cbz	x23, L_30ec
orr	w9, w7, w19
and	x28, x5, #0x1
orr	w22, w19, w8
stur	w9, [x29, #-0x80]
orr	w9, w9, w8
stur	w9, [x29, #-0x90]
b	L_306c
L_3050:
ldp	q1, q0, [x29, #-0x70]
subs	x23, x23, #0x1
add	x21, x21, x28
add	x24, x24, #0x8
mov	x2, x27
stp	q1, q0, [x26], #0x20
b.eq	L_30ec
L_306c:
ldr	x8, [sp, #0x18]
ldr	x25, [x24]
mov	x27, x2
ldp	q0, q1, [x8]
stp	q0, q1, [x29, #-0x70]
cbz	x2, L_3050
ldur	w8, [x29, #-0x80]
ldur	w9, [x29, #-0x90]
cmp	x27, #0x1
sub	x0, x29, #0x70
mov	x1, x25
mov	w2, #0x40
csel	w4, w8, w9, ne
mov	x3, x21
mov	x20, x27
bl	blake3_compress_in_place_portable
add	x25, x25, #0x40
b	L_30d4
L_30b4:
mov	w4, w22
L_30b8:
sub	x0, x29, #0x70
mov	x1, x25
mov	w2, #0x40
mov	x3, x21
bl	blake3_compress_in_place_portable
add	x25, x25, #0x40
sub	x20, x20, #0x1
L_30d4:
cmp	x20, #0x2
b.eq	L_30b4
cmp	x20, #0x1
mov	w4, w19
b.ne	L_30b8
b	L_3050
L_30ec:
add	sp, sp, #0x190
ldp	x20, x19, [sp, #0x90]
ldp	x22, x21, [sp, #0x80]
ldp	x24, x23, [sp, #0x70]
ldp	x26, x25, [sp, #0x60]
ldp	x28, x27, [sp, #0x50]
ldp	x29, x30, [sp, #0x40]
ldp	d9, d8, [sp, #0x30]
ldp	d11, d10, [sp, #0x20]
ldp	d13, d12, [sp, #0x10]
ldp	d15, d14, [sp], #0xa0
ret
	.section .rodata.cst16
bums_rodata_cst16:
	.byte 2,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0
	.byte 1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12
