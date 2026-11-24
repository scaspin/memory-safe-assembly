bignum_inv_p256:
stp             x19, x20, [sp, #-16]!
stp             x21, x22, [sp, #-16]!
stp             x23, x24, [sp, #-16]!
sub             sp, sp, #(20*8+0)
mov             x20, x0
mov             x10, #0xffffffffffffffff
mov             x11, #0x00000000ffffffff
mov             x13, #0xffffffff00000001
stp             x10, x11, [sp, #0]
stp             xzr, x13, [sp, #(0+2*8)]
str             xzr, [sp, #(0+4*8)]
ldp             x2, x3, [x1]
subs            x10, x2, x10
sbcs            x11, x3, x11
ldp             x4, x5, [x1, #(2*8)]
sbcs            x12, x4, xzr
sbcs            x13, x5, x13
csel            x2, x2, x10, cc
csel            x3, x3, x11, cc
csel            x4, x4, x12, cc
csel            x5, x5, x13, cc
stp             x2, x3, [sp, #(6*8)]
stp             x4, x5, [sp, #((6*8)+2*8)]
str             xzr, [sp, #((6*8)+4*8)]
stp             xzr, xzr, [sp, #(12*8)]
stp             xzr, xzr, [sp, #((12*8)+2*8)]
mov             x10, #0x0004000000000000
stp             x10, xzr, [sp, #(16*8)]
stp             xzr, xzr, [sp, #((16*8)+2*8)]
mov             x21, #10
mov             x22, #1
b               Lbignum_inv_p256_midloop
Lbignum_inv_p256_loop:
cmp             x10, xzr
csetm           x14, mi
cneg            x10, x10, mi
cmp             x11, xzr
csetm           x15, mi
cneg            x11, x11, mi
cmp             x12, xzr
csetm           x16, mi
cneg            x12, x12, mi
cmp             x13, xzr
csetm           x17, mi
cneg            x13, x13, mi
and             x0, x10, x14
and             x1, x11, x15
add             x9, x0, x1
and             x0, x12, x16
and             x1, x13, x17
add             x19, x0, x1
ldr             x7, [sp, #0]
eor             x1, x7, x14
mul             x0, x1, x10
umulh           x1, x1, x10
adds            x4, x9, x0
adc             x2, xzr, x1
ldr             x8, [sp, #(6*8)]
eor             x1, x8, x15
mul             x0, x1, x11
umulh           x1, x1, x11
adds            x4, x4, x0
adc             x2, x2, x1
eor             x1, x7, x16
mul             x0, x1, x12
umulh           x1, x1, x12
adds            x5, x19, x0
adc             x3, xzr, x1
eor             x1, x8, x17
mul             x0, x1, x13
umulh           x1, x1, x13
adds            x5, x5, x0
adc             x3, x3, x1
ldr             x7, [sp, #(0+8)]
eor             x1, x7, x14
mul             x0, x1, x10
umulh           x1, x1, x10
adds            x2, x2, x0
adc             x6, xzr, x1
ldr             x8, [sp, #((6*8)+8)]
eor             x1, x8, x15
mul             x0, x1, x11
umulh           x1, x1, x11
adds            x2, x2, x0
adc             x6, x6, x1
extr            x4, x2, x4, #59
str             x4, [sp, #0]
eor             x1, x7, x16
mul             x0, x1, x12
umulh           x1, x1, x12
adds            x3, x3, x0
adc             x4, xzr, x1
eor             x1, x8, x17
mul             x0, x1, x13
umulh           x1, x1, x13
adds            x3, x3, x0
adc             x4, x4, x1
extr            x5, x3, x5, #59
str             x5, [sp, #(6*8)]
ldr             x7, [sp, #(0+2*8)]
eor             x1, x7, x14
mul             x0, x1, x10
umulh           x1, x1, x10
adds            x6, x6, x0
adc             x5, xzr, x1
ldr             x8, [sp, #((6*8)+2*8)]
eor             x1, x8, x15
mul             x0, x1, x11
umulh           x1, x1, x11
adds            x6, x6, x0
adc             x5, x5, x1
extr            x2, x6, x2, #59
str             x2, [sp, #(0+8)]
eor             x1, x7, x16
mul             x0, x1, x12
umulh           x1, x1, x12
adds            x4, x4, x0
adc             x2, xzr, x1
eor             x1, x8, x17
mul             x0, x1, x13
umulh           x1, x1, x13
adds            x4, x4, x0
adc             x2, x2, x1
extr            x3, x4, x3, #59
str             x3, [sp, #((6*8)+8)]
ldr             x7, [sp, #(0+3*8)]
eor             x1, x7, x14
ldr             x23, [sp, #(0+4*8)]
eor             x3, x23, x14
and             x3, x3, x10
neg             x3, x3
mul             x0, x1, x10
umulh           x1, x1, x10
adds            x5, x5, x0
adc             x3, x3, x1
ldr             x8, [sp, #((6*8)+3*8)]
eor             x1, x8, x15
ldr             x24, [sp, #((6*8)+4*8)]
eor             x0, x24, x15
and             x0, x0, x11
sub             x3, x3, x0
mul             x0, x1, x11
umulh           x1, x1, x11
adds            x5, x5, x0
adc             x3, x3, x1
extr            x6, x5, x6, #59
str             x6, [sp, #(0+2*8)]
extr            x5, x3, x5, #59
str             x5, [sp, #(0+3*8)]
asr             x3, x3, #59
str             x3, [sp, #(0+4*8)]
eor             x1, x7, x16
eor             x5, x23, x16
and             x5, x5, x12
neg             x5, x5
mul             x0, x1, x12
umulh           x1, x1, x12
adds            x2, x2, x0
adc             x5, x5, x1
eor             x1, x8, x17
eor             x0, x24, x17
and             x0, x0, x13
sub             x5, x5, x0
mul             x0, x1, x13
umulh           x1, x1, x13
adds            x2, x2, x0
adc             x5, x5, x1
extr            x4, x2, x4, #59
str             x4, [sp, #((6*8)+2*8)]
extr            x2, x5, x2, #59
str             x2, [sp, #((6*8)+3*8)]
asr             x5, x5, #59
str             x5, [sp, #((6*8)+4*8)]
ldr             x7, [sp, #(12*8)]
eor             x1, x7, x14
mul             x0, x1, x10
umulh           x1, x1, x10
adds            x4, x9, x0
adc             x2, xzr, x1
ldr             x8, [sp, #(16*8)]
eor             x1, x8, x15
mul             x0, x1, x11
umulh           x1, x1, x11
adds            x4, x4, x0
str             x4, [sp, #(12*8)]
adc             x2, x2, x1
eor             x1, x7, x16
mul             x0, x1, x12
umulh           x1, x1, x12
adds            x5, x19, x0
adc             x3, xzr, x1
eor             x1, x8, x17
mul             x0, x1, x13
umulh           x1, x1, x13
adds            x5, x5, x0
str             x5, [sp, #(16*8)]
adc             x3, x3, x1
ldr             x7, [sp, #((12*8)+8)]
eor             x1, x7, x14
mul             x0, x1, x10
umulh           x1, x1, x10
adds            x2, x2, x0
adc             x6, xzr, x1
ldr             x8, [sp, #((16*8)+8)]
eor             x1, x8, x15
mul             x0, x1, x11
umulh           x1, x1, x11
adds            x2, x2, x0
str             x2, [sp, #((12*8)+8)]
adc             x6, x6, x1
eor             x1, x7, x16
mul             x0, x1, x12
umulh           x1, x1, x12
adds            x3, x3, x0
adc             x4, xzr, x1
eor             x1, x8, x17
mul             x0, x1, x13
umulh           x1, x1, x13
adds            x3, x3, x0
str             x3, [sp, #((16*8)+8)]
adc             x4, x4, x1
ldr             x7, [sp, #((12*8)+2*8)]
eor             x1, x7, x14
mul             x0, x1, x10
umulh           x1, x1, x10
adds            x6, x6, x0
adc             x5, xzr, x1
ldr             x8, [sp, #((16*8)+2*8)]
eor             x1, x8, x15
mul             x0, x1, x11
umulh           x1, x1, x11
adds            x6, x6, x0
str             x6, [sp, #((12*8)+2*8)]
adc             x5, x5, x1
eor             x1, x7, x16
mul             x0, x1, x12
umulh           x1, x1, x12
adds            x4, x4, x0
adc             x2, xzr, x1
eor             x1, x8, x17
mul             x0, x1, x13
umulh           x1, x1, x13
adds            x4, x4, x0
str             x4, [sp, #((16*8)+2*8)]
adc             x2, x2, x1
ldr             x7, [sp, #((12*8)+3*8)]
eor             x1, x7, x14
and             x3, x14, x10
neg             x3, x3
mul             x0, x1, x10
umulh           x1, x1, x10
adds            x5, x5, x0
adc             x3, x3, x1
ldr             x8, [sp, #((16*8)+3*8)]
eor             x1, x8, x15
and             x0, x15, x11
sub             x3, x3, x0
mul             x0, x1, x11
umulh           x1, x1, x11
adds            x5, x5, x0
adc             x3, x3, x1
ldp             x0, x1, [sp, #(12*8)]
ldr             x6, [sp, #((12*8)+2*8)]
mov x14, #0xe000000000000000
adds x0, x0, x14
sbcs x1, x1, xzr
mov x11, #0x000000001fffffff
adcs x6, x6, x11
mov x10, #0x2000000000000000
adcs x5, x5, x10
mov x14, #0x1fffffffe0000000
adc x3, x3, x14
lsl x11, x0, #32
subs x14, x0, x11
lsr x10, x0, #32
sbc x0, x0, x10
adds x1, x1, x11
adcs x6, x6, x10
adcs x5, x5, x14
adcs x3, x3, x0
mov x14, #0xffffffffffffffff
mov x11, #0x00000000ffffffff
mov x10, #0xffffffff00000001
csel x14, x14, xzr, cs
csel x11, x11, xzr, cs
csel x10, x10, xzr, cs
subs x1, x1, x14
sbcs x6, x6, x11
sbcs x5, x5, xzr
sbc x3, x3, x10
stp             x1, x6, [sp, #(12*8)]
stp             x5, x3, [sp, #((12*8)+16)]
eor             x1, x7, x16
and             x5, x16, x12
neg             x5, x5
mul             x0, x1, x12
umulh           x1, x1, x12
adds            x2, x2, x0
adc             x5, x5, x1
eor             x1, x8, x17
and             x0, x17, x13
sub             x5, x5, x0
mul             x0, x1, x13
umulh           x1, x1, x13
adds            x2, x2, x0
adc             x5, x5, x1
ldp             x0, x1, [sp, #(16*8)]
ldr             x3, [sp, #((16*8)+2*8)]
mov x14, #0xe000000000000000
adds x0, x0, x14
sbcs x1, x1, xzr
mov x11, #0x000000001fffffff
adcs x3, x3, x11
mov x10, #0x2000000000000000
adcs x2, x2, x10
mov x14, #0x1fffffffe0000000
adc x5, x5, x14
lsl x11, x0, #32
subs x14, x0, x11
lsr x10, x0, #32
sbc x0, x0, x10
adds x1, x1, x11
adcs x3, x3, x10
adcs x2, x2, x14
adcs x5, x5, x0
mov x14, #0xffffffffffffffff
mov x11, #0x00000000ffffffff
mov x10, #0xffffffff00000001
csel x14, x14, xzr, cs
csel x11, x11, xzr, cs
csel x10, x10, xzr, cs
subs x1, x1, x14
sbcs x3, x3, x11
sbcs x2, x2, xzr
sbc x5, x5, x10
stp             x1, x3, [sp, #(16*8)]
stp             x2, x5, [sp, #((16*8)+16)]
Lbignum_inv_p256_midloop:
mov             x1, x22
ldr             x2, [sp, #0]
ldr             x3, [sp, #(6*8)]
and x4, x2, #0xfffff
orr x4, x4, #0xfffffe0000000000
and x5, x3, #0xfffff
orr x5, x5, #0xc000000000000000
tst x5, #0x1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
asr x5, x5, #1
add x8, x4, #0x100, lsl #12
sbfx x8, x8, #21, #21
mov x11, #0x100000
add x11, x11, x11, lsl #21
add x9, x4, x11
asr x9, x9, #42
add x10, x5, #0x100, lsl #12
sbfx x10, x10, #21, #21
add x11, x5, x11
asr x11, x11, #42
mul x6, x8, x2
mul x7, x9, x3
mul x2, x10, x2
mul x3, x11, x3
add x4, x6, x7
add x5, x2, x3
asr x2, x4, #20
asr x3, x5, #20
and x4, x2, #0xfffff
orr x4, x4, #0xfffffe0000000000
and x5, x3, #0xfffff
orr x5, x5, #0xc000000000000000
tst x5, #0x1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
asr x5, x5, #1
add x12, x4, #0x100, lsl #12
sbfx x12, x12, #21, #21
mov x15, #0x100000
add x15, x15, x15, lsl #21
add x13, x4, x15
asr x13, x13, #42
add x14, x5, #0x100, lsl #12
sbfx x14, x14, #21, #21
add x15, x5, x15
asr x15, x15, #42
mul x6, x12, x2
mul x7, x13, x3
mul x2, x14, x2
mul x3, x15, x3
add x4, x6, x7
add x5, x2, x3
asr x2, x4, #20
asr x3, x5, #20
and x4, x2, #0xfffff
orr x4, x4, #0xfffffe0000000000
and x5, x3, #0xfffff
orr x5, x5, #0xc000000000000000
tst x5, #0x1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
mul x2, x12, x8
mul x3, x12, x9
mul x6, x14, x8
mul x7, x14, x9
madd x8, x13, x10, x2
madd x9, x13, x11, x3
madd x16, x15, x10, x6
madd x17, x15, x11, x7
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
tst x5, #0x2
asr x5, x5, #1
csel x6, x4, xzr, ne
ccmp x1, xzr, #0x8, ne
cneg x1, x1, ge
cneg x6, x6, ge
csel x4, x5, x4, ge
add x5, x5, x6
add x1, x1, #0x2
asr x5, x5, #1
add x12, x4, #0x100, lsl #12
sbfx x12, x12, #22, #21
mov x15, #0x100000
add x15, x15, x15, lsl #21
add x13, x4, x15
asr x13, x13, #43
add x14, x5, #0x100, lsl #12
sbfx x14, x14, #22, #21
add x15, x5, x15
asr x15, x15, #43
mneg x2, x12, x8
mneg x3, x12, x9
mneg x4, x14, x8
mneg x5, x14, x9
msub x10, x13, x16, x2
msub x11, x13, x17, x3
msub x12, x15, x16, x4
msub x13, x15, x17, x5
mov             x22, x1
subs            x21, x21, #1
bne             Lbignum_inv_p256_loop
ldr             x0, [sp, #0]
ldr             x1, [sp, #(6*8)]
mul             x0, x0, x10
madd            x1, x1, x11, x0
asr             x0, x1, #63
cmp             x10, xzr
csetm           x14, mi
cneg            x10, x10, mi
eor             x14, x14, x0
cmp             x11, xzr
csetm           x15, mi
cneg            x11, x11, mi
eor             x15, x15, x0
cmp             x12, xzr
csetm           x16, mi
cneg            x12, x12, mi
eor             x16, x16, x0
cmp             x13, xzr
csetm           x17, mi
cneg            x13, x13, mi
eor             x17, x17, x0
and             x0, x10, x14
and             x1, x11, x15
add             x9, x0, x1
ldr             x7, [sp, #(12*8)]
eor             x1, x7, x14
mul             x0, x1, x10
umulh           x1, x1, x10
adds            x4, x9, x0
adc             x2, xzr, x1
ldr             x8, [sp, #(16*8)]
eor             x1, x8, x15
mul             x0, x1, x11
umulh           x1, x1, x11
adds            x4, x4, x0
str             x4, [sp, #(12*8)]
adc             x2, x2, x1
ldr             x7, [sp, #((12*8)+8)]
eor             x1, x7, x14
mul             x0, x1, x10
umulh           x1, x1, x10
adds            x2, x2, x0
adc             x6, xzr, x1
ldr             x8, [sp, #((16*8)+8)]
eor             x1, x8, x15
mul             x0, x1, x11
umulh           x1, x1, x11
adds            x2, x2, x0
str             x2, [sp, #((12*8)+8)]
adc             x6, x6, x1
ldr             x7, [sp, #((12*8)+2*8)]
eor             x1, x7, x14
mul             x0, x1, x10
umulh           x1, x1, x10
adds            x6, x6, x0
adc             x5, xzr, x1
ldr             x8, [sp, #((16*8)+2*8)]
eor             x1, x8, x15
mul             x0, x1, x11
umulh           x1, x1, x11
adds            x6, x6, x0
str             x6, [sp, #((12*8)+2*8)]
adc             x5, x5, x1
ldr             x7, [sp, #((12*8)+3*8)]
eor             x1, x7, x14
and             x3, x14, x10
neg             x3, x3
mul             x0, x1, x10
umulh           x1, x1, x10
adds            x5, x5, x0
adc             x3, x3, x1
ldr             x8, [sp, #((16*8)+3*8)]
eor             x1, x8, x15
and             x0, x15, x11
sub             x3, x3, x0
mul             x0, x1, x11
umulh           x1, x1, x11
adds            x5, x5, x0
adc             x3, x3, x1
ldp             x0, x1, [sp, #(12*8)]
ldr             x2, [sp, #((12*8)+2*8)]
mov x14, #0xe000000000000000
adds x0, x0, x14
sbcs x1, x1, xzr
mov x11, #0x000000001fffffff
adcs x2, x2, x11
mov x10, #0x2000000000000000
adcs x5, x5, x10
mov x14, #0x1fffffffe0000000
adc x3, x3, x14
lsl x11, x0, #32
subs x14, x0, x11
lsr x10, x0, #32
sbc x0, x0, x10
adds x1, x1, x11
adcs x2, x2, x10
adcs x5, x5, x14
adcs x3, x3, x0
mov x14, #0xffffffffffffffff
mov x11, #0x00000000ffffffff
mov x10, #0xffffffff00000001
csel x14, x14, xzr, cs
csel x11, x11, xzr, cs
csel x10, x10, xzr, cs
subs x1, x1, x14
sbcs x2, x2, x11
sbcs x5, x5, xzr
sbc x3, x3, x10
mov             x10, #0xffffffffffffffff
subs            x10, x1, x10
mov             x11, #0x00000000ffffffff
sbcs            x11, x2, x11
mov             x13, #0xffffffff00000001
sbcs            x12, x5, xzr
sbcs            x13, x3, x13
csel            x10, x1, x10, cc
csel            x11, x2, x11, cc
csel            x12, x5, x12, cc
csel            x13, x3, x13, cc
stp             x10, x11, [x20]
stp             x12, x13, [x20, #16]
add             sp, sp, #(20*8+0)
ldp             x23, x24, [sp], #16
ldp             x21, x22, [sp], #16
ldp             x19, x20, [sp], #16
ret
