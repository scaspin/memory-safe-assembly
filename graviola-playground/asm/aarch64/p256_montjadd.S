p256_montjadd:
sub             sp, sp, #(32*7+0)
mov             x15, x0
mov             x16, x1
mov             x17, x2
ldp x2, x3, [x16, #(2*32)]
mul x9, x2, x3
umulh x10, x2, x3
ldp x4, x5, [x16, #((2*32)+16)]
mul x11, x2, x5
umulh x12, x2, x5
mul x6, x2, x4
umulh x7, x2, x4
adds x10, x10, x6
adcs x11, x11, x7
mul x6, x3, x4
umulh x7, x3, x4
adc x7, x7, xzr
adds x11, x11, x6
mul x13, x4, x5
umulh x14, x4, x5
adcs x12, x12, x7
mul x6, x3, x5
umulh x7, x3, x5
adc x7, x7, xzr
adds x12, x12, x6
adcs x13, x13, x7
adc x14, x14, xzr
adds x9, x9, x9
adcs x10, x10, x10
adcs x11, x11, x11
adcs x12, x12, x12
adcs x13, x13, x13
adcs x14, x14, x14
cset x7, cs
umulh x6, x2, x2
mul x8, x2, x2
adds x9, x9, x6
mul x6, x3, x3
adcs x10, x10, x6
umulh x6, x3, x3
adcs x11, x11, x6
mul x6, x4, x4
adcs x12, x12, x6
umulh x6, x4, x4
adcs x13, x13, x6
mul x6, x5, x5
adcs x14, x14, x6
umulh x6, x5, x5
adc x7, x7, x6
adds x9, x9, x8, lsl #32
lsr x3, x8, #32
adcs x10, x10, x3
mov x3, #0xffffffff00000001
mul x2, x8, x3
umulh x8, x8, x3
adcs x11, x11, x2
adc x8, x8, xzr
adds x10, x10, x9, lsl #32
lsr x3, x9, #32
adcs x11, x11, x3
mov x3, #0xffffffff00000001
mul x2, x9, x3
umulh x9, x9, x3
adcs x8, x8, x2
adc x9, x9, xzr
adds x11, x11, x10, lsl #32
lsr x3, x10, #32
adcs x8, x8, x3
mov x3, #0xffffffff00000001
mul x2, x10, x3
umulh x10, x10, x3
adcs x9, x9, x2
adc x10, x10, xzr
adds x8, x8, x11, lsl #32
lsr x3, x11, #32
adcs x9, x9, x3
mov x3, #0xffffffff00000001
mul x2, x11, x3
umulh x11, x11, x3
adcs x10, x10, x2
adc x11, x11, xzr
adds x8, x8, x12
adcs x9, x9, x13
adcs x10, x10, x14
adcs x11, x11, x7
mov x2, #0xffffffffffffffff
csel x2, xzr, x2, cc
mov x3, #0xffffffff
csel x3, xzr, x3, cc
mov x5, #0xffffffff00000001
csel x5, xzr, x5, cc
subs x8, x8, x2
sbcs x9, x9, x3
sbcs x10, x10, xzr
sbc x11, x11, x5
stp x8, x9, [sp, #(32*0)]
stp x10, x11, [sp, #((32*0)+16)]
ldp x2, x3, [x17, #(2*32)]
mul x9, x2, x3
umulh x10, x2, x3
ldp x4, x5, [x17, #((2*32)+16)]
mul x11, x2, x5
umulh x12, x2, x5
mul x6, x2, x4
umulh x7, x2, x4
adds x10, x10, x6
adcs x11, x11, x7
mul x6, x3, x4
umulh x7, x3, x4
adc x7, x7, xzr
adds x11, x11, x6
mul x13, x4, x5
umulh x14, x4, x5
adcs x12, x12, x7
mul x6, x3, x5
umulh x7, x3, x5
adc x7, x7, xzr
adds x12, x12, x6
adcs x13, x13, x7
adc x14, x14, xzr
adds x9, x9, x9
adcs x10, x10, x10
adcs x11, x11, x11
adcs x12, x12, x12
adcs x13, x13, x13
adcs x14, x14, x14
cset x7, cs
umulh x6, x2, x2
mul x8, x2, x2
adds x9, x9, x6
mul x6, x3, x3
adcs x10, x10, x6
umulh x6, x3, x3
adcs x11, x11, x6
mul x6, x4, x4
adcs x12, x12, x6
umulh x6, x4, x4
adcs x13, x13, x6
mul x6, x5, x5
adcs x14, x14, x6
umulh x6, x5, x5
adc x7, x7, x6
adds x9, x9, x8, lsl #32
lsr x3, x8, #32
adcs x10, x10, x3
mov x3, #0xffffffff00000001
mul x2, x8, x3
umulh x8, x8, x3
adcs x11, x11, x2
adc x8, x8, xzr
adds x10, x10, x9, lsl #32
lsr x3, x9, #32
adcs x11, x11, x3
mov x3, #0xffffffff00000001
mul x2, x9, x3
umulh x9, x9, x3
adcs x8, x8, x2
adc x9, x9, xzr
adds x11, x11, x10, lsl #32
lsr x3, x10, #32
adcs x8, x8, x3
mov x3, #0xffffffff00000001
mul x2, x10, x3
umulh x10, x10, x3
adcs x9, x9, x2
adc x10, x10, xzr
adds x8, x8, x11, lsl #32
lsr x3, x11, #32
adcs x9, x9, x3
mov x3, #0xffffffff00000001
mul x2, x11, x3
umulh x11, x11, x3
adcs x10, x10, x2
adc x11, x11, xzr
adds x8, x8, x12
adcs x9, x9, x13
adcs x10, x10, x14
adcs x11, x11, x7
mov x2, #0xffffffffffffffff
csel x2, xzr, x2, cc
mov x3, #0xffffffff
csel x3, xzr, x3, cc
mov x5, #0xffffffff00000001
csel x5, xzr, x5, cc
subs x8, x8, x2
sbcs x9, x9, x3
sbcs x10, x10, xzr
sbc x11, x11, x5
stp x8, x9, [sp, #(32*5)]
stp x10, x11, [sp, #((32*5)+16)]
ldp x3, x4, [x17, #(2*32)]
ldp x7, x8, [x16, #32]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [x16, #(32+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [x17, #((2*32)+16)]
mul x11, x4, x7
adds x13, x13, x11
mul x11, x4, x8
adcs x14, x14, x11
mul x11, x4, x9
adcs x0, x0, x11
mul x11, x4, x10
adcs x1, x1, x11
umulh x3, x4, x10
adc x3, x3, xzr
umulh x11, x4, x7
adds x14, x14, x11
umulh x11, x4, x8
adcs x0, x0, x11
umulh x11, x4, x9
adcs x1, x1, x11
adc x3, x3, xzr
mul x11, x5, x7
adds x14, x14, x11
mul x11, x5, x8
adcs x0, x0, x11
mul x11, x5, x9
adcs x1, x1, x11
mul x11, x5, x10
adcs x3, x3, x11
umulh x4, x5, x10
adc x4, x4, xzr
umulh x11, x5, x7
adds x0, x0, x11
umulh x11, x5, x8
adcs x1, x1, x11
umulh x11, x5, x9
adcs x3, x3, x11
adc x4, x4, xzr
mul x11, x6, x7
adds x0, x0, x11
mul x11, x6, x8
adcs x1, x1, x11
mul x11, x6, x9
adcs x3, x3, x11
mul x11, x6, x10
adcs x4, x4, x11
umulh x5, x6, x10
adc x5, x5, xzr
mov x10, #0xffffffff00000001
adds x13, x13, x12, lsl #32
lsr x11, x12, #32
adcs x14, x14, x11
mul x11, x12, x10
umulh x12, x12, x10
adcs x0, x0, x11
adc x12, x12, xzr
umulh x11, x6, x7
adds x1, x1, x11
umulh x11, x6, x8
adcs x3, x3, x11
umulh x11, x6, x9
adcs x4, x4, x11
adc x5, x5, xzr
adds x14, x14, x13, lsl #32
lsr x11, x13, #32
adcs x0, x0, x11
mul x11, x13, x10
umulh x13, x13, x10
adcs x12, x12, x11
adc x13, x13, xzr
adds x0, x0, x14, lsl #32
lsr x11, x14, #32
adcs x12, x12, x11
mul x11, x14, x10
umulh x14, x14, x10
adcs x13, x13, x11
adc x14, x14, xzr
adds x12, x12, x0, lsl #32
lsr x11, x0, #32
adcs x13, x13, x11
mul x11, x0, x10
umulh x0, x0, x10
adcs x14, x14, x11
adc x0, x0, xzr
adds x12, x12, x1
adcs x13, x13, x3
adcs x14, x14, x4
adcs x0, x0, x5
cset x8, cs
mov x11, #0xffffffff
adds x1, x12, #0x1
sbcs x3, x13, x11
sbcs x4, x14, xzr
sbcs x5, x0, x10
sbcs xzr, x8, xzr
csel x12, x12, x1, cc
csel x13, x13, x3, cc
csel x14, x14, x4, cc
csel x0, x0, x5, cc
stp x12, x13, [sp, #(32*6)]
stp x14, x0, [sp, #((32*6)+16)]
ldp x3, x4, [x16, #(2*32)]
ldp x7, x8, [x17, #32]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [x17, #(32+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [x16, #((2*32)+16)]
mul x11, x4, x7
adds x13, x13, x11
mul x11, x4, x8
adcs x14, x14, x11
mul x11, x4, x9
adcs x0, x0, x11
mul x11, x4, x10
adcs x1, x1, x11
umulh x3, x4, x10
adc x3, x3, xzr
umulh x11, x4, x7
adds x14, x14, x11
umulh x11, x4, x8
adcs x0, x0, x11
umulh x11, x4, x9
adcs x1, x1, x11
adc x3, x3, xzr
mul x11, x5, x7
adds x14, x14, x11
mul x11, x5, x8
adcs x0, x0, x11
mul x11, x5, x9
adcs x1, x1, x11
mul x11, x5, x10
adcs x3, x3, x11
umulh x4, x5, x10
adc x4, x4, xzr
umulh x11, x5, x7
adds x0, x0, x11
umulh x11, x5, x8
adcs x1, x1, x11
umulh x11, x5, x9
adcs x3, x3, x11
adc x4, x4, xzr
mul x11, x6, x7
adds x0, x0, x11
mul x11, x6, x8
adcs x1, x1, x11
mul x11, x6, x9
adcs x3, x3, x11
mul x11, x6, x10
adcs x4, x4, x11
umulh x5, x6, x10
adc x5, x5, xzr
mov x10, #0xffffffff00000001
adds x13, x13, x12, lsl #32
lsr x11, x12, #32
adcs x14, x14, x11
mul x11, x12, x10
umulh x12, x12, x10
adcs x0, x0, x11
adc x12, x12, xzr
umulh x11, x6, x7
adds x1, x1, x11
umulh x11, x6, x8
adcs x3, x3, x11
umulh x11, x6, x9
adcs x4, x4, x11
adc x5, x5, xzr
adds x14, x14, x13, lsl #32
lsr x11, x13, #32
adcs x0, x0, x11
mul x11, x13, x10
umulh x13, x13, x10
adcs x12, x12, x11
adc x13, x13, xzr
adds x0, x0, x14, lsl #32
lsr x11, x14, #32
adcs x12, x12, x11
mul x11, x14, x10
umulh x14, x14, x10
adcs x13, x13, x11
adc x14, x14, xzr
adds x12, x12, x0, lsl #32
lsr x11, x0, #32
adcs x13, x13, x11
mul x11, x0, x10
umulh x0, x0, x10
adcs x14, x14, x11
adc x0, x0, xzr
adds x12, x12, x1
adcs x13, x13, x3
adcs x14, x14, x4
adcs x0, x0, x5
cset x8, cs
mov x11, #0xffffffff
adds x1, x12, #0x1
sbcs x3, x13, x11
sbcs x4, x14, xzr
sbcs x5, x0, x10
sbcs xzr, x8, xzr
csel x12, x12, x1, cc
csel x13, x13, x3, cc
csel x14, x14, x4, cc
csel x0, x0, x5, cc
stp x12, x13, [sp, #(32*1)]
stp x14, x0, [sp, #((32*1)+16)]
ldp x3, x4, [sp, #(32*0)]
ldp x7, x8, [x17, #0]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [x17, #(0+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [sp, #((32*0)+16)]
mul x11, x4, x7
adds x13, x13, x11
mul x11, x4, x8
adcs x14, x14, x11
mul x11, x4, x9
adcs x0, x0, x11
mul x11, x4, x10
adcs x1, x1, x11
umulh x3, x4, x10
adc x3, x3, xzr
umulh x11, x4, x7
adds x14, x14, x11
umulh x11, x4, x8
adcs x0, x0, x11
umulh x11, x4, x9
adcs x1, x1, x11
adc x3, x3, xzr
mul x11, x5, x7
adds x14, x14, x11
mul x11, x5, x8
adcs x0, x0, x11
mul x11, x5, x9
adcs x1, x1, x11
mul x11, x5, x10
adcs x3, x3, x11
umulh x4, x5, x10
adc x4, x4, xzr
umulh x11, x5, x7
adds x0, x0, x11
umulh x11, x5, x8
adcs x1, x1, x11
umulh x11, x5, x9
adcs x3, x3, x11
adc x4, x4, xzr
mul x11, x6, x7
adds x0, x0, x11
mul x11, x6, x8
adcs x1, x1, x11
mul x11, x6, x9
adcs x3, x3, x11
mul x11, x6, x10
adcs x4, x4, x11
umulh x5, x6, x10
adc x5, x5, xzr
mov x10, #0xffffffff00000001
adds x13, x13, x12, lsl #32
lsr x11, x12, #32
adcs x14, x14, x11
mul x11, x12, x10
umulh x12, x12, x10
adcs x0, x0, x11
adc x12, x12, xzr
umulh x11, x6, x7
adds x1, x1, x11
umulh x11, x6, x8
adcs x3, x3, x11
umulh x11, x6, x9
adcs x4, x4, x11
adc x5, x5, xzr
adds x14, x14, x13, lsl #32
lsr x11, x13, #32
adcs x0, x0, x11
mul x11, x13, x10
umulh x13, x13, x10
adcs x12, x12, x11
adc x13, x13, xzr
adds x0, x0, x14, lsl #32
lsr x11, x14, #32
adcs x12, x12, x11
mul x11, x14, x10
umulh x14, x14, x10
adcs x13, x13, x11
adc x14, x14, xzr
adds x12, x12, x0, lsl #32
lsr x11, x0, #32
adcs x13, x13, x11
mul x11, x0, x10
umulh x0, x0, x10
adcs x14, x14, x11
adc x0, x0, xzr
adds x12, x12, x1
adcs x13, x13, x3
adcs x14, x14, x4
adcs x0, x0, x5
cset x8, cs
mov x11, #0xffffffff
adds x1, x12, #0x1
sbcs x3, x13, x11
sbcs x4, x14, xzr
sbcs x5, x0, x10
sbcs xzr, x8, xzr
csel x12, x12, x1, cc
csel x13, x13, x3, cc
csel x14, x14, x4, cc
csel x0, x0, x5, cc
stp x12, x13, [sp, #(32*2)]
stp x14, x0, [sp, #((32*2)+16)]
ldp x3, x4, [sp, #(32*5)]
ldp x7, x8, [x16, #0]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [x16, #(0+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [sp, #((32*5)+16)]
mul x11, x4, x7
adds x13, x13, x11
mul x11, x4, x8
adcs x14, x14, x11
mul x11, x4, x9
adcs x0, x0, x11
mul x11, x4, x10
adcs x1, x1, x11
umulh x3, x4, x10
adc x3, x3, xzr
umulh x11, x4, x7
adds x14, x14, x11
umulh x11, x4, x8
adcs x0, x0, x11
umulh x11, x4, x9
adcs x1, x1, x11
adc x3, x3, xzr
mul x11, x5, x7
adds x14, x14, x11
mul x11, x5, x8
adcs x0, x0, x11
mul x11, x5, x9
adcs x1, x1, x11
mul x11, x5, x10
adcs x3, x3, x11
umulh x4, x5, x10
adc x4, x4, xzr
umulh x11, x5, x7
adds x0, x0, x11
umulh x11, x5, x8
adcs x1, x1, x11
umulh x11, x5, x9
adcs x3, x3, x11
adc x4, x4, xzr
mul x11, x6, x7
adds x0, x0, x11
mul x11, x6, x8
adcs x1, x1, x11
mul x11, x6, x9
adcs x3, x3, x11
mul x11, x6, x10
adcs x4, x4, x11
umulh x5, x6, x10
adc x5, x5, xzr
mov x10, #0xffffffff00000001
adds x13, x13, x12, lsl #32
lsr x11, x12, #32
adcs x14, x14, x11
mul x11, x12, x10
umulh x12, x12, x10
adcs x0, x0, x11
adc x12, x12, xzr
umulh x11, x6, x7
adds x1, x1, x11
umulh x11, x6, x8
adcs x3, x3, x11
umulh x11, x6, x9
adcs x4, x4, x11
adc x5, x5, xzr
adds x14, x14, x13, lsl #32
lsr x11, x13, #32
adcs x0, x0, x11
mul x11, x13, x10
umulh x13, x13, x10
adcs x12, x12, x11
adc x13, x13, xzr
adds x0, x0, x14, lsl #32
lsr x11, x14, #32
adcs x12, x12, x11
mul x11, x14, x10
umulh x14, x14, x10
adcs x13, x13, x11
adc x14, x14, xzr
adds x12, x12, x0, lsl #32
lsr x11, x0, #32
adcs x13, x13, x11
mul x11, x0, x10
umulh x0, x0, x10
adcs x14, x14, x11
adc x0, x0, xzr
adds x12, x12, x1
adcs x13, x13, x3
adcs x14, x14, x4
adcs x0, x0, x5
cset x8, cs
mov x11, #0xffffffff
adds x1, x12, #0x1
sbcs x3, x13, x11
sbcs x4, x14, xzr
sbcs x5, x0, x10
sbcs xzr, x8, xzr
csel x12, x12, x1, cc
csel x13, x13, x3, cc
csel x14, x14, x4, cc
csel x0, x0, x5, cc
stp x12, x13, [sp, #(32*4)]
stp x14, x0, [sp, #((32*4)+16)]
ldp x3, x4, [sp, #(32*0)]
ldp x7, x8, [sp, #(32*1)]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [sp, #((32*1)+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [sp, #((32*0)+16)]
mul x11, x4, x7
adds x13, x13, x11
mul x11, x4, x8
adcs x14, x14, x11
mul x11, x4, x9
adcs x0, x0, x11
mul x11, x4, x10
adcs x1, x1, x11
umulh x3, x4, x10
adc x3, x3, xzr
umulh x11, x4, x7
adds x14, x14, x11
umulh x11, x4, x8
adcs x0, x0, x11
umulh x11, x4, x9
adcs x1, x1, x11
adc x3, x3, xzr
mul x11, x5, x7
adds x14, x14, x11
mul x11, x5, x8
adcs x0, x0, x11
mul x11, x5, x9
adcs x1, x1, x11
mul x11, x5, x10
adcs x3, x3, x11
umulh x4, x5, x10
adc x4, x4, xzr
umulh x11, x5, x7
adds x0, x0, x11
umulh x11, x5, x8
adcs x1, x1, x11
umulh x11, x5, x9
adcs x3, x3, x11
adc x4, x4, xzr
mul x11, x6, x7
adds x0, x0, x11
mul x11, x6, x8
adcs x1, x1, x11
mul x11, x6, x9
adcs x3, x3, x11
mul x11, x6, x10
adcs x4, x4, x11
umulh x5, x6, x10
adc x5, x5, xzr
mov x10, #0xffffffff00000001
adds x13, x13, x12, lsl #32
lsr x11, x12, #32
adcs x14, x14, x11
mul x11, x12, x10
umulh x12, x12, x10
adcs x0, x0, x11
adc x12, x12, xzr
umulh x11, x6, x7
adds x1, x1, x11
umulh x11, x6, x8
adcs x3, x3, x11
umulh x11, x6, x9
adcs x4, x4, x11
adc x5, x5, xzr
adds x14, x14, x13, lsl #32
lsr x11, x13, #32
adcs x0, x0, x11
mul x11, x13, x10
umulh x13, x13, x10
adcs x12, x12, x11
adc x13, x13, xzr
adds x0, x0, x14, lsl #32
lsr x11, x14, #32
adcs x12, x12, x11
mul x11, x14, x10
umulh x14, x14, x10
adcs x13, x13, x11
adc x14, x14, xzr
adds x12, x12, x0, lsl #32
lsr x11, x0, #32
adcs x13, x13, x11
mul x11, x0, x10
umulh x0, x0, x10
adcs x14, x14, x11
adc x0, x0, xzr
adds x12, x12, x1
adcs x13, x13, x3
adcs x14, x14, x4
adcs x0, x0, x5
cset x8, cs
mov x11, #0xffffffff
adds x1, x12, #0x1
sbcs x3, x13, x11
sbcs x4, x14, xzr
sbcs x5, x0, x10
sbcs xzr, x8, xzr
csel x12, x12, x1, cc
csel x13, x13, x3, cc
csel x14, x14, x4, cc
csel x0, x0, x5, cc
stp x12, x13, [sp, #(32*1)]
stp x14, x0, [sp, #((32*1)+16)]
ldp x3, x4, [sp, #(32*5)]
ldp x7, x8, [sp, #(32*6)]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [sp, #((32*6)+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [sp, #((32*5)+16)]
mul x11, x4, x7
adds x13, x13, x11
mul x11, x4, x8
adcs x14, x14, x11
mul x11, x4, x9
adcs x0, x0, x11
mul x11, x4, x10
adcs x1, x1, x11
umulh x3, x4, x10
adc x3, x3, xzr
umulh x11, x4, x7
adds x14, x14, x11
umulh x11, x4, x8
adcs x0, x0, x11
umulh x11, x4, x9
adcs x1, x1, x11
adc x3, x3, xzr
mul x11, x5, x7
adds x14, x14, x11
mul x11, x5, x8
adcs x0, x0, x11
mul x11, x5, x9
adcs x1, x1, x11
mul x11, x5, x10
adcs x3, x3, x11
umulh x4, x5, x10
adc x4, x4, xzr
umulh x11, x5, x7
adds x0, x0, x11
umulh x11, x5, x8
adcs x1, x1, x11
umulh x11, x5, x9
adcs x3, x3, x11
adc x4, x4, xzr
mul x11, x6, x7
adds x0, x0, x11
mul x11, x6, x8
adcs x1, x1, x11
mul x11, x6, x9
adcs x3, x3, x11
mul x11, x6, x10
adcs x4, x4, x11
umulh x5, x6, x10
adc x5, x5, xzr
mov x10, #0xffffffff00000001
adds x13, x13, x12, lsl #32
lsr x11, x12, #32
adcs x14, x14, x11
mul x11, x12, x10
umulh x12, x12, x10
adcs x0, x0, x11
adc x12, x12, xzr
umulh x11, x6, x7
adds x1, x1, x11
umulh x11, x6, x8
adcs x3, x3, x11
umulh x11, x6, x9
adcs x4, x4, x11
adc x5, x5, xzr
adds x14, x14, x13, lsl #32
lsr x11, x13, #32
adcs x0, x0, x11
mul x11, x13, x10
umulh x13, x13, x10
adcs x12, x12, x11
adc x13, x13, xzr
adds x0, x0, x14, lsl #32
lsr x11, x14, #32
adcs x12, x12, x11
mul x11, x14, x10
umulh x14, x14, x10
adcs x13, x13, x11
adc x14, x14, xzr
adds x12, x12, x0, lsl #32
lsr x11, x0, #32
adcs x13, x13, x11
mul x11, x0, x10
umulh x0, x0, x10
adcs x14, x14, x11
adc x0, x0, xzr
adds x12, x12, x1
adcs x13, x13, x3
adcs x14, x14, x4
adcs x0, x0, x5
cset x8, cs
mov x11, #0xffffffff
adds x1, x12, #0x1
sbcs x3, x13, x11
sbcs x4, x14, xzr
sbcs x5, x0, x10
sbcs xzr, x8, xzr
csel x12, x12, x1, cc
csel x13, x13, x3, cc
csel x14, x14, x4, cc
csel x0, x0, x5, cc
stp x12, x13, [sp, #(32*6)]
stp x14, x0, [sp, #((32*6)+16)]
ldp x5, x6, [sp, #(32*2)]
ldp x4, x3, [sp, #(32*4)]
subs x5, x5, x4
sbcs x6, x6, x3
ldp x7, x8, [sp, #((32*2)+16)]
ldp x4, x3, [sp, #((32*4)+16)]
sbcs x7, x7, x4
sbcs x8, x8, x3
csetm x3, cc
adds x5, x5, x3
mov x4, #0xffffffff
and x4, x4, x3
adcs x6, x6, x4
adcs x7, x7, xzr
mov x4, #0xffffffff00000001
and x4, x4, x3
adc x8, x8, x4
stp x5, x6, [sp, #(32*5)]
stp x7, x8, [sp, #((32*5)+16)]
ldp x5, x6, [sp, #(32*1)]
ldp x4, x3, [sp, #(32*6)]
subs x5, x5, x4
sbcs x6, x6, x3
ldp x7, x8, [sp, #((32*1)+16)]
ldp x4, x3, [sp, #((32*6)+16)]
sbcs x7, x7, x4
sbcs x8, x8, x3
csetm x3, cc
adds x5, x5, x3
mov x4, #0xffffffff
and x4, x4, x3
adcs x6, x6, x4
adcs x7, x7, xzr
mov x4, #0xffffffff00000001
and x4, x4, x3
adc x8, x8, x4
stp x5, x6, [sp, #(32*1)]
stp x7, x8, [sp, #((32*1)+16)]
ldp x2, x3, [sp, #(32*5)]
mul x9, x2, x3
umulh x10, x2, x3
ldp x4, x5, [sp, #((32*5)+16)]
mul x11, x2, x5
umulh x12, x2, x5
mul x6, x2, x4
umulh x7, x2, x4
adds x10, x10, x6
adcs x11, x11, x7
mul x6, x3, x4
umulh x7, x3, x4
adc x7, x7, xzr
adds x11, x11, x6
mul x13, x4, x5
umulh x14, x4, x5
adcs x12, x12, x7
mul x6, x3, x5
umulh x7, x3, x5
adc x7, x7, xzr
adds x12, x12, x6
adcs x13, x13, x7
adc x14, x14, xzr
adds x9, x9, x9
adcs x10, x10, x10
adcs x11, x11, x11
adcs x12, x12, x12
adcs x13, x13, x13
adcs x14, x14, x14
cset x7, cs
umulh x6, x2, x2
mul x8, x2, x2
adds x9, x9, x6
mul x6, x3, x3
adcs x10, x10, x6
umulh x6, x3, x3
adcs x11, x11, x6
mul x6, x4, x4
adcs x12, x12, x6
umulh x6, x4, x4
adcs x13, x13, x6
mul x6, x5, x5
adcs x14, x14, x6
umulh x6, x5, x5
adc x7, x7, x6
adds x9, x9, x8, lsl #32
lsr x3, x8, #32
adcs x10, x10, x3
mov x3, #0xffffffff00000001
mul x2, x8, x3
umulh x8, x8, x3
adcs x11, x11, x2
adc x8, x8, xzr
adds x10, x10, x9, lsl #32
lsr x3, x9, #32
adcs x11, x11, x3
mov x3, #0xffffffff00000001
mul x2, x9, x3
umulh x9, x9, x3
adcs x8, x8, x2
adc x9, x9, xzr
adds x11, x11, x10, lsl #32
lsr x3, x10, #32
adcs x8, x8, x3
mov x3, #0xffffffff00000001
mul x2, x10, x3
umulh x10, x10, x3
adcs x9, x9, x2
adc x10, x10, xzr
adds x8, x8, x11, lsl #32
lsr x3, x11, #32
adcs x9, x9, x3
mov x3, #0xffffffff00000001
mul x2, x11, x3
umulh x11, x11, x3
adcs x10, x10, x2
adc x11, x11, xzr
adds x8, x8, x12
adcs x9, x9, x13
adcs x10, x10, x14
adcs x11, x11, x7
mov x2, #0xffffffffffffffff
csel x2, xzr, x2, cc
mov x3, #0xffffffff
csel x3, xzr, x3, cc
mov x5, #0xffffffff00000001
csel x5, xzr, x5, cc
subs x8, x8, x2
sbcs x9, x9, x3
sbcs x10, x10, xzr
sbc x11, x11, x5
stp x8, x9, [sp, #(32*3)]
stp x10, x11, [sp, #((32*3)+16)]
ldp x2, x3, [sp, #(32*1)]
mul x9, x2, x3
umulh x10, x2, x3
ldp x4, x5, [sp, #((32*1)+16)]
mul x11, x2, x5
umulh x12, x2, x5
mul x6, x2, x4
umulh x7, x2, x4
adds x10, x10, x6
adcs x11, x11, x7
mul x6, x3, x4
umulh x7, x3, x4
adc x7, x7, xzr
adds x11, x11, x6
mul x13, x4, x5
umulh x14, x4, x5
adcs x12, x12, x7
mul x6, x3, x5
umulh x7, x3, x5
adc x7, x7, xzr
adds x12, x12, x6
adcs x13, x13, x7
adc x14, x14, xzr
adds x9, x9, x9
adcs x10, x10, x10
adcs x11, x11, x11
adcs x12, x12, x12
adcs x13, x13, x13
adcs x14, x14, x14
cset x7, cs
umulh x6, x2, x2
mul x8, x2, x2
adds x9, x9, x6
mul x6, x3, x3
adcs x10, x10, x6
umulh x6, x3, x3
adcs x11, x11, x6
mul x6, x4, x4
adcs x12, x12, x6
umulh x6, x4, x4
adcs x13, x13, x6
mul x6, x5, x5
adcs x14, x14, x6
umulh x6, x5, x5
adc x7, x7, x6
adds x9, x9, x8, lsl #32
lsr x3, x8, #32
adcs x10, x10, x3
mov x3, #0xffffffff00000001
mul x2, x8, x3
umulh x8, x8, x3
adcs x11, x11, x2
adc x8, x8, xzr
adds x10, x10, x9, lsl #32
lsr x3, x9, #32
adcs x11, x11, x3
mov x3, #0xffffffff00000001
mul x2, x9, x3
umulh x9, x9, x3
adcs x8, x8, x2
adc x9, x9, xzr
adds x11, x11, x10, lsl #32
lsr x3, x10, #32
adcs x8, x8, x3
mov x3, #0xffffffff00000001
mul x2, x10, x3
umulh x10, x10, x3
adcs x9, x9, x2
adc x10, x10, xzr
adds x8, x8, x11, lsl #32
lsr x3, x11, #32
adcs x9, x9, x3
mov x3, #0xffffffff00000001
mul x2, x11, x3
umulh x11, x11, x3
adcs x10, x10, x2
adc x11, x11, xzr
adds x8, x8, x12
adcs x9, x9, x13
adcs x10, x10, x14
adcs x11, x11, x7
cset x2, cs
mov x3, #0xffffffff
mov x5, #0xffffffff00000001
adds x12, x8, #0x1
sbcs x13, x9, x3
sbcs x14, x10, xzr
sbcs x7, x11, x5
sbcs xzr, x2, xzr
csel x8, x8, x12, cc
csel x9, x9, x13, cc
csel x10, x10, x14, cc
csel x11, x11, x7, cc
stp x8, x9, [sp, #(32*0)]
stp x10, x11, [sp, #((32*0)+16)]
ldp x3, x4, [sp, #(32*3)]
ldp x7, x8, [sp, #(32*4)]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [sp, #((32*4)+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [sp, #((32*3)+16)]
mul x11, x4, x7
adds x13, x13, x11
mul x11, x4, x8
adcs x14, x14, x11
mul x11, x4, x9
adcs x0, x0, x11
mul x11, x4, x10
adcs x1, x1, x11
umulh x3, x4, x10
adc x3, x3, xzr
umulh x11, x4, x7
adds x14, x14, x11
umulh x11, x4, x8
adcs x0, x0, x11
umulh x11, x4, x9
adcs x1, x1, x11
adc x3, x3, xzr
mul x11, x5, x7
adds x14, x14, x11
mul x11, x5, x8
adcs x0, x0, x11
mul x11, x5, x9
adcs x1, x1, x11
mul x11, x5, x10
adcs x3, x3, x11
umulh x4, x5, x10
adc x4, x4, xzr
umulh x11, x5, x7
adds x0, x0, x11
umulh x11, x5, x8
adcs x1, x1, x11
umulh x11, x5, x9
adcs x3, x3, x11
adc x4, x4, xzr
mul x11, x6, x7
adds x0, x0, x11
mul x11, x6, x8
adcs x1, x1, x11
mul x11, x6, x9
adcs x3, x3, x11
mul x11, x6, x10
adcs x4, x4, x11
umulh x5, x6, x10
adc x5, x5, xzr
mov x10, #0xffffffff00000001
adds x13, x13, x12, lsl #32
lsr x11, x12, #32
adcs x14, x14, x11
mul x11, x12, x10
umulh x12, x12, x10
adcs x0, x0, x11
adc x12, x12, xzr
umulh x11, x6, x7
adds x1, x1, x11
umulh x11, x6, x8
adcs x3, x3, x11
umulh x11, x6, x9
adcs x4, x4, x11
adc x5, x5, xzr
adds x14, x14, x13, lsl #32
lsr x11, x13, #32
adcs x0, x0, x11
mul x11, x13, x10
umulh x13, x13, x10
adcs x12, x12, x11
adc x13, x13, xzr
adds x0, x0, x14, lsl #32
lsr x11, x14, #32
adcs x12, x12, x11
mul x11, x14, x10
umulh x14, x14, x10
adcs x13, x13, x11
adc x14, x14, xzr
adds x12, x12, x0, lsl #32
lsr x11, x0, #32
adcs x13, x13, x11
mul x11, x0, x10
umulh x0, x0, x10
adcs x14, x14, x11
adc x0, x0, xzr
adds x12, x12, x1
adcs x13, x13, x3
adcs x14, x14, x4
adcs x0, x0, x5
cset x8, cs
mov x11, #0xffffffff
adds x1, x12, #0x1
sbcs x3, x13, x11
sbcs x4, x14, xzr
sbcs x5, x0, x10
sbcs xzr, x8, xzr
csel x12, x12, x1, cc
csel x13, x13, x3, cc
csel x14, x14, x4, cc
csel x0, x0, x5, cc
stp x12, x13, [sp, #(32*4)]
stp x14, x0, [sp, #((32*4)+16)]
ldp x3, x4, [sp, #(32*3)]
ldp x7, x8, [sp, #(32*2)]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [sp, #((32*2)+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [sp, #((32*3)+16)]
mul x11, x4, x7
adds x13, x13, x11
mul x11, x4, x8
adcs x14, x14, x11
mul x11, x4, x9
adcs x0, x0, x11
mul x11, x4, x10
adcs x1, x1, x11
umulh x3, x4, x10
adc x3, x3, xzr
umulh x11, x4, x7
adds x14, x14, x11
umulh x11, x4, x8
adcs x0, x0, x11
umulh x11, x4, x9
adcs x1, x1, x11
adc x3, x3, xzr
mul x11, x5, x7
adds x14, x14, x11
mul x11, x5, x8
adcs x0, x0, x11
mul x11, x5, x9
adcs x1, x1, x11
mul x11, x5, x10
adcs x3, x3, x11
umulh x4, x5, x10
adc x4, x4, xzr
umulh x11, x5, x7
adds x0, x0, x11
umulh x11, x5, x8
adcs x1, x1, x11
umulh x11, x5, x9
adcs x3, x3, x11
adc x4, x4, xzr
mul x11, x6, x7
adds x0, x0, x11
mul x11, x6, x8
adcs x1, x1, x11
mul x11, x6, x9
adcs x3, x3, x11
mul x11, x6, x10
adcs x4, x4, x11
umulh x5, x6, x10
adc x5, x5, xzr
mov x10, #0xffffffff00000001
adds x13, x13, x12, lsl #32
lsr x11, x12, #32
adcs x14, x14, x11
mul x11, x12, x10
umulh x12, x12, x10
adcs x0, x0, x11
adc x12, x12, xzr
umulh x11, x6, x7
adds x1, x1, x11
umulh x11, x6, x8
adcs x3, x3, x11
umulh x11, x6, x9
adcs x4, x4, x11
adc x5, x5, xzr
adds x14, x14, x13, lsl #32
lsr x11, x13, #32
adcs x0, x0, x11
mul x11, x13, x10
umulh x13, x13, x10
adcs x12, x12, x11
adc x13, x13, xzr
adds x0, x0, x14, lsl #32
lsr x11, x14, #32
adcs x12, x12, x11
mul x11, x14, x10
umulh x14, x14, x10
adcs x13, x13, x11
adc x14, x14, xzr
adds x12, x12, x0, lsl #32
lsr x11, x0, #32
adcs x13, x13, x11
mul x11, x0, x10
umulh x0, x0, x10
adcs x14, x14, x11
adc x0, x0, xzr
adds x12, x12, x1
adcs x13, x13, x3
adcs x14, x14, x4
adcs x0, x0, x5
cset x8, cs
mov x11, #0xffffffff
adds x1, x12, #0x1
sbcs x3, x13, x11
sbcs x4, x14, xzr
sbcs x5, x0, x10
sbcs xzr, x8, xzr
csel x12, x12, x1, cc
csel x13, x13, x3, cc
csel x14, x14, x4, cc
csel x0, x0, x5, cc
stp x12, x13, [sp, #(32*2)]
stp x14, x0, [sp, #((32*2)+16)]
ldp x5, x6, [sp, #(32*0)]
ldp x4, x3, [sp, #(32*4)]
subs x5, x5, x4
sbcs x6, x6, x3
ldp x7, x8, [sp, #((32*0)+16)]
ldp x4, x3, [sp, #((32*4)+16)]
sbcs x7, x7, x4
sbcs x8, x8, x3
csetm x3, cc
adds x5, x5, x3
mov x4, #0xffffffff
and x4, x4, x3
adcs x6, x6, x4
adcs x7, x7, xzr
mov x4, #0xffffffff00000001
and x4, x4, x3
adc x8, x8, x4
stp x5, x6, [sp, #(32*0)]
stp x7, x8, [sp, #((32*0)+16)]
ldp x5, x6, [sp, #(32*2)]
ldp x4, x3, [sp, #(32*4)]
subs x5, x5, x4
sbcs x6, x6, x3
ldp x7, x8, [sp, #((32*2)+16)]
ldp x4, x3, [sp, #((32*4)+16)]
sbcs x7, x7, x4
sbcs x8, x8, x3
csetm x3, cc
adds x5, x5, x3
mov x4, #0xffffffff
and x4, x4, x3
adcs x6, x6, x4
adcs x7, x7, xzr
mov x4, #0xffffffff00000001
and x4, x4, x3
adc x8, x8, x4
stp x5, x6, [sp, #(32*3)]
stp x7, x8, [sp, #((32*3)+16)]
ldp x3, x4, [sp, #(32*5)]
ldp x7, x8, [x16, #(2*32)]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [x16, #((2*32)+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [sp, #((32*5)+16)]
mul x11, x4, x7
adds x13, x13, x11
mul x11, x4, x8
adcs x14, x14, x11
mul x11, x4, x9
adcs x0, x0, x11
mul x11, x4, x10
adcs x1, x1, x11
umulh x3, x4, x10
adc x3, x3, xzr
umulh x11, x4, x7
adds x14, x14, x11
umulh x11, x4, x8
adcs x0, x0, x11
umulh x11, x4, x9
adcs x1, x1, x11
adc x3, x3, xzr
mul x11, x5, x7
adds x14, x14, x11
mul x11, x5, x8
adcs x0, x0, x11
mul x11, x5, x9
adcs x1, x1, x11
mul x11, x5, x10
adcs x3, x3, x11
umulh x4, x5, x10
adc x4, x4, xzr
umulh x11, x5, x7
adds x0, x0, x11
umulh x11, x5, x8
adcs x1, x1, x11
umulh x11, x5, x9
adcs x3, x3, x11
adc x4, x4, xzr
mul x11, x6, x7
adds x0, x0, x11
mul x11, x6, x8
adcs x1, x1, x11
mul x11, x6, x9
adcs x3, x3, x11
mul x11, x6, x10
adcs x4, x4, x11
umulh x5, x6, x10
adc x5, x5, xzr
mov x10, #0xffffffff00000001
adds x13, x13, x12, lsl #32
lsr x11, x12, #32
adcs x14, x14, x11
mul x11, x12, x10
umulh x12, x12, x10
adcs x0, x0, x11
adc x12, x12, xzr
umulh x11, x6, x7
adds x1, x1, x11
umulh x11, x6, x8
adcs x3, x3, x11
umulh x11, x6, x9
adcs x4, x4, x11
adc x5, x5, xzr
adds x14, x14, x13, lsl #32
lsr x11, x13, #32
adcs x0, x0, x11
mul x11, x13, x10
umulh x13, x13, x10
adcs x12, x12, x11
adc x13, x13, xzr
adds x0, x0, x14, lsl #32
lsr x11, x14, #32
adcs x12, x12, x11
mul x11, x14, x10
umulh x14, x14, x10
adcs x13, x13, x11
adc x14, x14, xzr
adds x12, x12, x0, lsl #32
lsr x11, x0, #32
adcs x13, x13, x11
mul x11, x0, x10
umulh x0, x0, x10
adcs x14, x14, x11
adc x0, x0, xzr
adds x12, x12, x1
adcs x13, x13, x3
adcs x14, x14, x4
adcs x0, x0, x5
cset x8, cs
mov x11, #0xffffffff
adds x1, x12, #0x1
sbcs x3, x13, x11
sbcs x4, x14, xzr
sbcs x5, x0, x10
sbcs xzr, x8, xzr
csel x12, x12, x1, cc
csel x13, x13, x3, cc
csel x14, x14, x4, cc
csel x0, x0, x5, cc
stp x12, x13, [sp, #(32*5)]
stp x14, x0, [sp, #((32*5)+16)]
ldp x5, x6, [sp, #(32*0)]
ldp x4, x3, [sp, #(32*2)]
subs x5, x5, x4
sbcs x6, x6, x3
ldp x7, x8, [sp, #((32*0)+16)]
ldp x4, x3, [sp, #((32*2)+16)]
sbcs x7, x7, x4
sbcs x8, x8, x3
csetm x3, cc
adds x5, x5, x3
mov x4, #0xffffffff
and x4, x4, x3
adcs x6, x6, x4
adcs x7, x7, xzr
mov x4, #0xffffffff00000001
and x4, x4, x3
adc x8, x8, x4
stp x5, x6, [sp, #(32*0)]
stp x7, x8, [sp, #((32*0)+16)]
ldp x5, x6, [sp, #(32*4)]
ldp x4, x3, [sp, #(32*0)]
subs x5, x5, x4
sbcs x6, x6, x3
ldp x7, x8, [sp, #((32*4)+16)]
ldp x4, x3, [sp, #((32*0)+16)]
sbcs x7, x7, x4
sbcs x8, x8, x3
csetm x3, cc
adds x5, x5, x3
mov x4, #0xffffffff
and x4, x4, x3
adcs x6, x6, x4
adcs x7, x7, xzr
mov x4, #0xffffffff00000001
and x4, x4, x3
adc x8, x8, x4
stp x5, x6, [sp, #(32*4)]
stp x7, x8, [sp, #((32*4)+16)]
ldp x3, x4, [sp, #(32*3)]
ldp x7, x8, [sp, #(32*6)]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [sp, #((32*6)+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [sp, #((32*3)+16)]
mul x11, x4, x7
adds x13, x13, x11
mul x11, x4, x8
adcs x14, x14, x11
mul x11, x4, x9
adcs x0, x0, x11
mul x11, x4, x10
adcs x1, x1, x11
umulh x3, x4, x10
adc x3, x3, xzr
umulh x11, x4, x7
adds x14, x14, x11
umulh x11, x4, x8
adcs x0, x0, x11
umulh x11, x4, x9
adcs x1, x1, x11
adc x3, x3, xzr
mul x11, x5, x7
adds x14, x14, x11
mul x11, x5, x8
adcs x0, x0, x11
mul x11, x5, x9
adcs x1, x1, x11
mul x11, x5, x10
adcs x3, x3, x11
umulh x4, x5, x10
adc x4, x4, xzr
umulh x11, x5, x7
adds x0, x0, x11
umulh x11, x5, x8
adcs x1, x1, x11
umulh x11, x5, x9
adcs x3, x3, x11
adc x4, x4, xzr
mul x11, x6, x7
adds x0, x0, x11
mul x11, x6, x8
adcs x1, x1, x11
mul x11, x6, x9
adcs x3, x3, x11
mul x11, x6, x10
adcs x4, x4, x11
umulh x5, x6, x10
adc x5, x5, xzr
mov x10, #0xffffffff00000001
adds x13, x13, x12, lsl #32
lsr x11, x12, #32
adcs x14, x14, x11
mul x11, x12, x10
umulh x12, x12, x10
adcs x0, x0, x11
adc x12, x12, xzr
umulh x11, x6, x7
adds x1, x1, x11
umulh x11, x6, x8
adcs x3, x3, x11
umulh x11, x6, x9
adcs x4, x4, x11
adc x5, x5, xzr
adds x14, x14, x13, lsl #32
lsr x11, x13, #32
adcs x0, x0, x11
mul x11, x13, x10
umulh x13, x13, x10
adcs x12, x12, x11
adc x13, x13, xzr
adds x0, x0, x14, lsl #32
lsr x11, x14, #32
adcs x12, x12, x11
mul x11, x14, x10
umulh x14, x14, x10
adcs x13, x13, x11
adc x14, x14, xzr
adds x12, x12, x0, lsl #32
lsr x11, x0, #32
adcs x13, x13, x11
mul x11, x0, x10
umulh x0, x0, x10
adcs x14, x14, x11
adc x0, x0, xzr
adds x12, x12, x1
adcs x13, x13, x3
adcs x14, x14, x4
adcs x0, x0, x5
cset x8, cs
mov x11, #0xffffffff
adds x1, x12, #0x1
sbcs x3, x13, x11
sbcs x4, x14, xzr
sbcs x5, x0, x10
sbcs xzr, x8, xzr
csel x12, x12, x1, cc
csel x13, x13, x3, cc
csel x14, x14, x4, cc
csel x0, x0, x5, cc
stp x12, x13, [sp, #(32*3)]
stp x14, x0, [sp, #((32*3)+16)]
ldp x3, x4, [sp, #(32*5)]
ldp x7, x8, [x17, #(2*32)]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [x17, #((2*32)+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [sp, #((32*5)+16)]
mul x11, x4, x7
adds x13, x13, x11
mul x11, x4, x8
adcs x14, x14, x11
mul x11, x4, x9
adcs x0, x0, x11
mul x11, x4, x10
adcs x1, x1, x11
umulh x3, x4, x10
adc x3, x3, xzr
umulh x11, x4, x7
adds x14, x14, x11
umulh x11, x4, x8
adcs x0, x0, x11
umulh x11, x4, x9
adcs x1, x1, x11
adc x3, x3, xzr
mul x11, x5, x7
adds x14, x14, x11
mul x11, x5, x8
adcs x0, x0, x11
mul x11, x5, x9
adcs x1, x1, x11
mul x11, x5, x10
adcs x3, x3, x11
umulh x4, x5, x10
adc x4, x4, xzr
umulh x11, x5, x7
adds x0, x0, x11
umulh x11, x5, x8
adcs x1, x1, x11
umulh x11, x5, x9
adcs x3, x3, x11
adc x4, x4, xzr
mul x11, x6, x7
adds x0, x0, x11
mul x11, x6, x8
adcs x1, x1, x11
mul x11, x6, x9
adcs x3, x3, x11
mul x11, x6, x10
adcs x4, x4, x11
umulh x5, x6, x10
adc x5, x5, xzr
mov x10, #0xffffffff00000001
adds x13, x13, x12, lsl #32
lsr x11, x12, #32
adcs x14, x14, x11
mul x11, x12, x10
umulh x12, x12, x10
adcs x0, x0, x11
adc x12, x12, xzr
umulh x11, x6, x7
adds x1, x1, x11
umulh x11, x6, x8
adcs x3, x3, x11
umulh x11, x6, x9
adcs x4, x4, x11
adc x5, x5, xzr
adds x14, x14, x13, lsl #32
lsr x11, x13, #32
adcs x0, x0, x11
mul x11, x13, x10
umulh x13, x13, x10
adcs x12, x12, x11
adc x13, x13, xzr
adds x0, x0, x14, lsl #32
lsr x11, x14, #32
adcs x12, x12, x11
mul x11, x14, x10
umulh x14, x14, x10
adcs x13, x13, x11
adc x14, x14, xzr
adds x12, x12, x0, lsl #32
lsr x11, x0, #32
adcs x13, x13, x11
mul x11, x0, x10
umulh x0, x0, x10
adcs x14, x14, x11
adc x0, x0, xzr
adds x12, x12, x1
adcs x13, x13, x3
adcs x14, x14, x4
adcs x0, x0, x5
cset x8, cs
mov x11, #0xffffffff
adds x1, x12, #0x1
sbcs x3, x13, x11
sbcs x4, x14, xzr
sbcs x5, x0, x10
sbcs xzr, x8, xzr
csel x12, x12, x1, cc
csel x13, x13, x3, cc
csel x14, x14, x4, cc
csel x0, x0, x5, cc
stp x12, x13, [sp, #(32*5)]
stp x14, x0, [sp, #((32*5)+16)]
ldp x3, x4, [sp, #(32*1)]
ldp x7, x8, [sp, #(32*4)]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [sp, #((32*4)+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [sp, #((32*1)+16)]
mul x11, x4, x7
adds x13, x13, x11
mul x11, x4, x8
adcs x14, x14, x11
mul x11, x4, x9
adcs x0, x0, x11
mul x11, x4, x10
adcs x1, x1, x11
umulh x3, x4, x10
adc x3, x3, xzr
umulh x11, x4, x7
adds x14, x14, x11
umulh x11, x4, x8
adcs x0, x0, x11
umulh x11, x4, x9
adcs x1, x1, x11
adc x3, x3, xzr
mul x11, x5, x7
adds x14, x14, x11
mul x11, x5, x8
adcs x0, x0, x11
mul x11, x5, x9
adcs x1, x1, x11
mul x11, x5, x10
adcs x3, x3, x11
umulh x4, x5, x10
adc x4, x4, xzr
umulh x11, x5, x7
adds x0, x0, x11
umulh x11, x5, x8
adcs x1, x1, x11
umulh x11, x5, x9
adcs x3, x3, x11
adc x4, x4, xzr
mul x11, x6, x7
adds x0, x0, x11
mul x11, x6, x8
adcs x1, x1, x11
mul x11, x6, x9
adcs x3, x3, x11
mul x11, x6, x10
adcs x4, x4, x11
umulh x5, x6, x10
adc x5, x5, xzr
mov x10, #0xffffffff00000001
adds x13, x13, x12, lsl #32
lsr x11, x12, #32
adcs x14, x14, x11
mul x11, x12, x10
umulh x12, x12, x10
adcs x0, x0, x11
adc x12, x12, xzr
umulh x11, x6, x7
adds x1, x1, x11
umulh x11, x6, x8
adcs x3, x3, x11
umulh x11, x6, x9
adcs x4, x4, x11
adc x5, x5, xzr
adds x14, x14, x13, lsl #32
lsr x11, x13, #32
adcs x0, x0, x11
mul x11, x13, x10
umulh x13, x13, x10
adcs x12, x12, x11
adc x13, x13, xzr
adds x0, x0, x14, lsl #32
lsr x11, x14, #32
adcs x12, x12, x11
mul x11, x14, x10
umulh x14, x14, x10
adcs x13, x13, x11
adc x14, x14, xzr
adds x12, x12, x0, lsl #32
lsr x11, x0, #32
adcs x13, x13, x11
mul x11, x0, x10
umulh x0, x0, x10
adcs x14, x14, x11
adc x0, x0, xzr
adds x12, x12, x1
adcs x13, x13, x3
adcs x14, x14, x4
adcs x0, x0, x5
cset x8, cs
mov x11, #0xffffffff
adds x1, x12, #0x1
sbcs x3, x13, x11
sbcs x4, x14, xzr
sbcs x5, x0, x10
sbcs xzr, x8, xzr
csel x12, x12, x1, cc
csel x13, x13, x3, cc
csel x14, x14, x4, cc
csel x0, x0, x5, cc
stp x12, x13, [sp, #(32*4)]
stp x14, x0, [sp, #((32*4)+16)]
ldp x5, x6, [sp, #(32*4)]
ldp x4, x3, [sp, #(32*3)]
subs x5, x5, x4
sbcs x6, x6, x3
ldp x7, x8, [sp, #((32*4)+16)]
ldp x4, x3, [sp, #((32*3)+16)]
sbcs x7, x7, x4
sbcs x8, x8, x3
csetm x3, cc
adds x5, x5, x3
mov x4, #0xffffffff
and x4, x4, x3
adcs x6, x6, x4
adcs x7, x7, xzr
mov x4, #0xffffffff00000001
and x4, x4, x3
adc x8, x8, x4
stp x5, x6, [sp, #(32*4)]
stp x7, x8, [sp, #((32*4)+16)]
ldp             x0, x1, [x16, #(2*32)]
ldp             x2, x3, [x16, #((2*32)+16)]
orr             x12, x0, x1
orr             x13, x2, x3
orr             x12, x12, x13
cmp             x12, xzr
cset            x12, ne
ldp             x4, x5, [x17, #(2*32)]
ldp             x6, x7, [x17, #((2*32)+16)]
orr             x13, x4, x5
orr             x14, x6, x7
orr             x13, x13, x14
cmp             x13, xzr
cset            x13, ne
cmp             x13, x12
ldp             x8, x9, [sp, #(32*5)]
csel            x8, x0, x8, lo
csel            x9, x1, x9, lo
csel            x8, x4, x8, hi
csel            x9, x5, x9, hi
ldp             x10, x11, [sp, #((32*5)+16)]
csel            x10, x2, x10, lo
csel            x11, x3, x11, lo
csel            x10, x6, x10, hi
csel            x11, x7, x11, hi
ldp             x12, x13, [x16, #0]
ldp             x0, x1, [sp, #(32*0)]
csel            x0, x12, x0, lo
csel            x1, x13, x1, lo
ldp             x12, x13, [x17, #0]
csel            x0, x12, x0, hi
csel            x1, x13, x1, hi
ldp             x12, x13, [x16, #(0+16)]
ldp             x2, x3, [sp, #((32*0)+16)]
csel            x2, x12, x2, lo
csel            x3, x13, x3, lo
ldp             x12, x13, [x17, #(0+16)]
csel            x2, x12, x2, hi
csel            x3, x13, x3, hi
ldp             x12, x13, [x16, #32]
ldp             x4, x5, [sp, #(32*4)]
csel            x4, x12, x4, lo
csel            x5, x13, x5, lo
ldp             x12, x13, [x17, #32]
csel            x4, x12, x4, hi
csel            x5, x13, x5, hi
ldp             x12, x13, [x16, #(32+16)]
ldp             x6, x7, [sp, #((32*4)+16)]
csel            x6, x12, x6, lo
csel            x7, x13, x7, lo
ldp             x12, x13, [x17, #(32+16)]
csel            x6, x12, x6, hi
csel            x7, x13, x7, hi
stp             x0, x1, [x15, #0]
stp             x2, x3, [x15, #(0+16)]
stp             x4, x5, [x15, #32]
stp             x6, x7, [x15, #(32+16)]
stp             x8, x9, [x15, #(2*32)]
stp             x10, x11, [x15, #((2*32)+16)]
add             sp, sp, #(32*7+0)
ret
