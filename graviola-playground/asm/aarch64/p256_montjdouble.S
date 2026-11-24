p256_montjdouble:
sub             sp, sp, #(32*6+0)
mov             x15, x0
mov             x16, x1
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
cset x7, hs
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
mov x5, #-4294967295
adds x9, x9, x8, lsl #32
lsr x3, x8, #32
adcs x10, x10, x3
mul x2, x8, x5
umulh x8, x8, x5
adcs x11, x11, x2
adc x8, x8, xzr
adds x10, x10, x9, lsl #32
lsr x3, x9, #32
adcs x11, x11, x3
mul x2, x9, x5
umulh x9, x9, x5
adcs x8, x8, x2
adc x9, x9, xzr
adds x11, x11, x10, lsl #32
lsr x3, x10, #32
adcs x8, x8, x3
mul x2, x10, x5
umulh x10, x10, x5
adcs x9, x9, x2
adc x10, x10, xzr
adds x8, x8, x11, lsl #32
lsr x3, x11, #32
adcs x9, x9, x3
mul x2, x11, x5
umulh x11, x11, x5
adcs x10, x10, x2
adc x11, x11, xzr
adds x8, x8, x12
adcs x9, x9, x13
adcs x10, x10, x14
adcs x11, x11, x7
cset x2, hs
mov x3, #4294967295
adds x12, x8, #1
sbcs x13, x9, x3
sbcs x14, x10, xzr
sbcs x7, x11, x5
sbcs xzr, x2, xzr
csel x8, x8, x12, lo
csel x9, x9, x13, lo
csel x10, x10, x14, lo
csel x11, x11, x7, lo
stp x8, x9, [sp, #(32*0)]
stp x10, x11, [sp, #((32*0)+16)]
ldp x2, x3, [x16, #32]
mul x9, x2, x3
umulh x10, x2, x3
ldp x4, x5, [x16, #(32+16)]
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
cset x7, hs
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
mov x5, #-4294967295
adds x9, x9, x8, lsl #32
lsr x3, x8, #32
adcs x10, x10, x3
mul x2, x8, x5
umulh x8, x8, x5
adcs x11, x11, x2
adc x8, x8, xzr
adds x10, x10, x9, lsl #32
lsr x3, x9, #32
adcs x11, x11, x3
mul x2, x9, x5
umulh x9, x9, x5
adcs x8, x8, x2
adc x9, x9, xzr
adds x11, x11, x10, lsl #32
lsr x3, x10, #32
adcs x8, x8, x3
mul x2, x10, x5
umulh x10, x10, x5
adcs x9, x9, x2
adc x10, x10, xzr
adds x8, x8, x11, lsl #32
lsr x3, x11, #32
adcs x9, x9, x3
mul x2, x11, x5
umulh x11, x11, x5
adcs x10, x10, x2
adc x11, x11, xzr
adds x8, x8, x12
adcs x9, x9, x13
adcs x10, x10, x14
adcs x11, x11, x7
cset x2, hs
mov x3, #4294967295
adds x12, x8, #1
sbcs x13, x9, x3
sbcs x14, x10, xzr
sbcs x7, x11, x5
sbcs xzr, x2, xzr
csel x8, x8, x12, lo
csel x9, x9, x13, lo
csel x10, x10, x14, lo
csel x11, x11, x7, lo
stp x8, x9, [sp, #(32*1)]
stp x10, x11, [sp, #((32*1)+16)]
ldp x5, x6, [x16, #0]
ldp x4, x3, [sp, #(32*0)]
subs x5, x5, x4
sbcs x6, x6, x3
ldp x7, x8, [x16, #(0+16)]
ldp x4, x3, [sp, #((32*0)+16)]
sbcs x7, x7, x4
sbcs x8, x8, x3
csetm x3, lo
adds x5, x5, x3
and x4, x3, #0xffffffff
adcs x6, x6, x4
adcs x7, x7, xzr
and x4, x3, #0xffffffff00000001
adc x8, x8, x4
stp x5, x6, [sp, #(32*3)]
stp x7, x8, [sp, #((32*3)+16)]
ldp x5, x6, [x16, #0]
ldp x4, x3, [sp, #(32*0)]
adds x5, x5, x4
adcs x6, x6, x3
ldp x7, x8, [x16, #(0+16)]
ldp x4, x3, [sp, #((32*0)+16)]
adcs x7, x7, x4
adcs x8, x8, x3
csetm x3, cs
subs x5, x5, x3
and x1, x3, #4294967295
sbcs x6, x6, x1
sbcs x7, x7, xzr
and x2, x3, #-4294967295
sbc x8, x8, x2
stp x5, x6, [sp, #(32*2)]
stp x7, x8, [sp, #((32*2)+16)]
ldp x3, x4, [sp, #(32*2)]
ldp x7, x8, [sp, #(32*3)]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [sp, #((32*3)+16)]
mul x11, x3, x9
umulh x0, x3, x9
adcs x14, x14, x11
mul x11, x3, x10
umulh x1, x3, x10
adcs x0, x0, x11
adc x1, x1, xzr
ldp x5, x6, [sp, #((32*2)+16)]
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
ldp x5, x6, [x16, #32]
ldp x4, x3, [x16, #(2*32)]
adds x5, x5, x4
adcs x6, x6, x3
ldp x7, x8, [x16, #(32+16)]
ldp x4, x3, [x16, #((2*32)+16)]
adcs x7, x7, x4
adcs x8, x8, x3
adc x3, xzr, xzr
cmn x5, #1
mov x4, #4294967295
sbcs xzr, x6, x4
sbcs xzr, x7, xzr
mov x4, #-4294967295
sbcs xzr, x8, x4
adcs x3, x3, xzr
csetm x3, ne
subs x5, x5, x3
and x4, x3, #0xffffffff
sbcs x6, x6, x4
sbcs x7, x7, xzr
and x4, x3, #0xffffffff00000001
sbc x8, x8, x4
stp x5, x6, [sp, #(32*2)]
stp x7, x8, [sp, #((32*2)+16)]
ldp x3, x4, [x16, #0]
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
ldp x5, x6, [x16, #(0+16)]
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
ldp x2, x3, [sp, #(32*3)]
mul x9, x2, x3
umulh x10, x2, x3
ldp x4, x5, [sp, #((32*3)+16)]
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
cset x7, hs
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
mov x5, #-4294967295
adds x9, x9, x8, lsl #32
lsr x3, x8, #32
adcs x10, x10, x3
mul x2, x8, x5
umulh x8, x8, x5
adcs x11, x11, x2
adc x8, x8, xzr
adds x10, x10, x9, lsl #32
lsr x3, x9, #32
adcs x11, x11, x3
mul x2, x9, x5
umulh x9, x9, x5
adcs x8, x8, x2
adc x9, x9, xzr
adds x11, x11, x10, lsl #32
lsr x3, x10, #32
adcs x8, x8, x3
mul x2, x10, x5
umulh x10, x10, x5
adcs x9, x9, x2
adc x10, x10, xzr
adds x8, x8, x11, lsl #32
lsr x3, x11, #32
adcs x9, x9, x3
mul x2, x11, x5
umulh x11, x11, x5
adcs x10, x10, x2
adc x11, x11, xzr
adds x8, x8, x12
adcs x9, x9, x13
adcs x10, x10, x14
adcs x11, x11, x7
cset x2, hs
mov x3, #4294967295
adds x12, x8, #1
sbcs x13, x9, x3
sbcs x14, x10, xzr
sbcs x7, x11, x5
sbcs xzr, x2, xzr
csel x8, x8, x12, lo
csel x9, x9, x13, lo
csel x10, x10, x14, lo
csel x11, x11, x7, lo
stp x8, x9, [sp, #(32*5)]
stp x10, x11, [sp, #((32*5)+16)]
ldp x2, x3, [sp, #(32*2)]
mul x9, x2, x3
umulh x10, x2, x3
ldp x4, x5, [sp, #((32*2)+16)]
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
cset x7, hs
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
mov x5, #-4294967295
adds x9, x9, x8, lsl #32
lsr x3, x8, #32
adcs x10, x10, x3
mul x2, x8, x5
umulh x8, x8, x5
adcs x11, x11, x2
adc x8, x8, xzr
adds x10, x10, x9, lsl #32
lsr x3, x9, #32
adcs x11, x11, x3
mul x2, x9, x5
umulh x9, x9, x5
adcs x8, x8, x2
adc x9, x9, xzr
adds x11, x11, x10, lsl #32
lsr x3, x10, #32
adcs x8, x8, x3
mul x2, x10, x5
umulh x10, x10, x5
adcs x9, x9, x2
adc x10, x10, xzr
adds x8, x8, x11, lsl #32
lsr x3, x11, #32
adcs x9, x9, x3
mul x2, x11, x5
umulh x11, x11, x5
adcs x10, x10, x2
adc x11, x11, xzr
adds x8, x8, x12
adcs x9, x9, x13
adcs x10, x10, x14
adcs x11, x11, x7
cset x2, hs
mov x3, #4294967295
adds x12, x8, #1
sbcs x13, x9, x3
sbcs x14, x10, xzr
sbcs x7, x11, x5
sbcs xzr, x2, xzr
csel x8, x8, x12, lo
csel x9, x9, x13, lo
csel x10, x10, x14, lo
csel x11, x11, x7, lo
stp x8, x9, [sp, #(32*2)]
stp x10, x11, [sp, #((32*2)+16)]
mov x1, 9
mov x2, #-1
ldp x9, x10, [sp, #(32*5)]
subs x9, x2, x9
mov x2, #4294967295
sbcs x10, x2, x10
ldp x11, x12, [sp, #((32*5)+16)]
sbcs x11, xzr, x11
mov x2, #-4294967295
sbc x12, x2, x12
mul x3, x1, x9
mul x4, x1, x10
mul x5, x1, x11
mul x6, x1, x12
umulh x9, x1, x9
umulh x10, x1, x10
umulh x11, x1, x11
umulh x7, x1, x12
adds x4, x4, x9
adcs x5, x5, x10
adcs x6, x6, x11
adc x7, x7, xzr
mov x1, 12
ldp x9, x10, [sp, #(32*4)]
mul x8, x9, x1
umulh x9, x9, x1
adds x3, x3, x8
mul x8, x10, x1
umulh x10, x10, x1
adcs x4, x4, x8
ldp x11, x12, [sp, #((32*4)+16)]
mul x8, x11, x1
umulh x11, x11, x1
adcs x5, x5, x8
mul x8, x12, x1
umulh x12, x12, x1
adcs x6, x6, x8
adc x7, x7, xzr
adds x4, x4, x9
adcs x5, x5, x10
adcs x6, x6, x11
adc x7, x7, x12
add x8, x7, #1
lsl x10, x8, #32
adds x6, x6, x10
adc x7, x7, xzr
neg x9, x8
sub x10, x10, #1
subs x3, x3, x9
sbcs x4, x4, x10
sbcs x5, x5, xzr
sbcs x6, x6, x8
sbc x8, x7, x8
adds x3, x3, x8
and x9, x8, #4294967295
adcs x4, x4, x9
adcs x5, x5, xzr
neg x10, x9
adc x6, x6, x10
stp x3, x4, [sp, #(32*5)]
stp x5, x6, [sp, #((32*5)+16)]
ldp x5, x6, [sp, #(32*2)]
ldp x4, x3, [sp, #(32*0)]
subs x5, x5, x4
sbcs x6, x6, x3
ldp x7, x8, [sp, #((32*2)+16)]
ldp x4, x3, [sp, #((32*0)+16)]
sbcs x7, x7, x4
sbcs x8, x8, x3
csetm x3, lo
adds x5, x5, x3
and x4, x3, #0xffffffff
adcs x6, x6, x4
adcs x7, x7, xzr
and x4, x3, #0xffffffff00000001
adc x8, x8, x4
stp x5, x6, [sp, #(32*2)]
stp x7, x8, [sp, #((32*2)+16)]
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
cset x7, hs
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
mov x5, #-4294967295
adds x9, x9, x8, lsl #32
lsr x3, x8, #32
adcs x10, x10, x3
mul x2, x8, x5
umulh x8, x8, x5
adcs x11, x11, x2
adc x8, x8, xzr
adds x10, x10, x9, lsl #32
lsr x3, x9, #32
adcs x11, x11, x3
mul x2, x9, x5
umulh x9, x9, x5
adcs x8, x8, x2
adc x9, x9, xzr
adds x11, x11, x10, lsl #32
lsr x3, x10, #32
adcs x8, x8, x3
mul x2, x10, x5
umulh x10, x10, x5
adcs x9, x9, x2
adc x10, x10, xzr
adds x8, x8, x11, lsl #32
lsr x3, x11, #32
adcs x9, x9, x3
mul x2, x11, x5
umulh x11, x11, x5
adcs x10, x10, x2
adc x11, x11, xzr
adds x8, x8, x12
adcs x9, x9, x13
adcs x10, x10, x14
adcs x11, x11, x7
cset x2, hs
mov x3, #4294967295
adds x12, x8, #1
sbcs x13, x9, x3
sbcs x14, x10, xzr
sbcs x7, x11, x5
sbcs xzr, x2, xzr
csel x8, x8, x12, lo
csel x9, x9, x13, lo
csel x10, x10, x14, lo
csel x11, x11, x7, lo
stp x8, x9, [sp, #(32*0)]
stp x10, x11, [sp, #((32*0)+16)]
ldp x3, x4, [sp, #(32*5)]
ldp x7, x8, [sp, #(32*3)]
mul x12, x3, x7
umulh x13, x3, x7
mul x11, x3, x8
umulh x14, x3, x8
adds x13, x13, x11
ldp x9, x10, [sp, #((32*3)+16)]
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
stp x12, x13, [sp, #(32*3)]
stp x14, x0, [sp, #((32*3)+16)]
ldp x5, x6, [sp, #(32*2)]
ldp x4, x3, [sp, #(32*1)]
subs x5, x5, x4
sbcs x6, x6, x3
ldp x7, x8, [sp, #((32*2)+16)]
ldp x4, x3, [sp, #((32*1)+16)]
sbcs x7, x7, x4
sbcs x8, x8, x3
csetm x3, lo
adds x5, x5, x3
and x4, x3, #0xffffffff
adcs x6, x6, x4
adcs x7, x7, xzr
and x4, x3, #0xffffffff00000001
adc x8, x8, x4
stp x5, x6, [x15, #(2*32)]
stp x7, x8, [x15, #((2*32)+16)]
ldp x1, x2, [sp, #(32*4)]
lsl x0, x1, #2
ldp x6, x7, [sp, #(32*5)]
subs x0, x0, x6
extr x1, x2, x1, #62
sbcs x1, x1, x7
ldp x3, x4, [sp, #((32*4)+16)]
extr x2, x3, x2, #62
ldp x6, x7, [sp, #((32*5)+16)]
sbcs x2, x2, x6
extr x3, x4, x3, #62
sbcs x3, x3, x7
lsr x4, x4, #62
sbc x4, x4, xzr
add x5, x4, #1
lsl x8, x5, #32
subs x6, xzr, x8
sbcs x7, xzr, xzr
sbc x8, x8, x5
adds x0, x0, x5
adcs x1, x1, x6
adcs x2, x2, x7
adcs x3, x3, x8
csetm x5, cc
adds x0, x0, x5
and x6, x5, #4294967295
adcs x1, x1, x6
adcs x2, x2, xzr
neg x7, x6
adc x3, x3, x7
stp x0, x1, [x15, #0]
stp x2, x3, [x15, #(0+16)]
mov x1, 8
mov x2, #-1
ldp x9, x10, [sp, #(32*0)]
subs x9, x2, x9
mov x2, #4294967295
sbcs x10, x2, x10
ldp x11, x12, [sp, #((32*0)+16)]
sbcs x11, xzr, x11
mov x2, #-4294967295
sbc x12, x2, x12
lsl x3, x9, #3
extr x4, x10, x9, #61
extr x5, x11, x10, #61
extr x6, x12, x11, #61
lsr x7, x12, #61
mov x1, 3
ldp x9, x10, [sp, #(32*3)]
mul x8, x9, x1
umulh x9, x9, x1
adds x3, x3, x8
mul x8, x10, x1
umulh x10, x10, x1
adcs x4, x4, x8
ldp x11, x12, [sp, #((32*3)+16)]
mul x8, x11, x1
umulh x11, x11, x1
adcs x5, x5, x8
mul x8, x12, x1
umulh x12, x12, x1
adcs x6, x6, x8
adc x7, x7, xzr
adds x4, x4, x9
adcs x5, x5, x10
adcs x6, x6, x11
adc x7, x7, x12
add x8, x7, #1
lsl x10, x8, #32
adds x6, x6, x10
adc x7, x7, xzr
neg x9, x8
sub x10, x10, #1
subs x3, x3, x9
sbcs x4, x4, x10
sbcs x5, x5, xzr
sbcs x6, x6, x8
sbc x8, x7, x8
adds x3, x3, x8
and x9, x8, #4294967295
adcs x4, x4, x9
adcs x5, x5, xzr
neg x10, x9
adc x6, x6, x10
stp x3, x4, [x15, #32]
stp x5, x6, [x15, #(32+16)]
add             sp, sp, #(32*6+0)
ret
