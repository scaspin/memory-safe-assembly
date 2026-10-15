bignum_madd_n25519:
stp             x19, x20, [sp, #-16]!
mov             x19, x0
ldp             x13, x14, [x1]
ldp             x7, x0, [x2]
mul             x8, x13, x7
umulh           x9, x13, x7
mul             x16, x13, x0
umulh           x10, x13, x0
adds            x9, x9, x16
ldp             x4, x5, [x2, #16]
mul             x16, x13, x4
umulh           x11, x13, x4
adcs            x10, x10, x16
mul             x16, x13, x5
umulh           x12, x13, x5
adcs            x11, x11, x16
adc             x12, x12, xzr
ldp             x15, x6, [x3]
adds            x8, x8, x15
adcs            x9, x9, x6
ldp             x15, x6, [x3, #16]
adcs            x10, x10, x15
adcs            x11, x11, x6
adc             x12, x12, xzr
ldp             x15, x6, [x1, #16]
mul             x16, x14, x7
adds            x9, x9, x16
mul             x16, x14, x0
adcs            x10, x10, x16
mul             x16, x14, x4
adcs            x11, x11, x16
mul             x16, x14, x5
adcs            x12, x12, x16
umulh           x13, x14, x5
adc             x13, x13, xzr
umulh           x16, x14, x7
adds            x10, x10, x16
umulh           x16, x14, x0
adcs            x11, x11, x16
umulh           x16, x14, x4
adcs            x12, x12, x16
adc             x13, x13, xzr
mul             x16, x15, x7
adds            x10, x10, x16
mul             x16, x15, x0
adcs            x11, x11, x16
mul             x16, x15, x4
adcs            x12, x12, x16
mul             x16, x15, x5
adcs            x13, x13, x16
umulh           x14, x15, x5
adc             x14, x14, xzr
umulh           x16, x15, x7
adds            x11, x11, x16
umulh           x16, x15, x0
adcs            x12, x12, x16
umulh           x16, x15, x4
adcs            x13, x13, x16
adc             x14, x14, xzr
mul             x16, x6, x7
adds            x11, x11, x16
mul             x16, x6, x0
adcs            x12, x12, x16
mul             x16, x6, x4
adcs            x13, x13, x16
mul             x16, x6, x5
adcs            x14, x14, x16
umulh           x15, x6, x5
adc             x15, x15, xzr
umulh           x16, x6, x7
adds            x12, x12, x16
umulh           x16, x6, x0
adcs            x13, x13, x16
umulh           x16, x6, x4
adcs            x14, x14, x16
adc             x15, x15, xzr
movz x3, #0xd3ed
movk x3, #0x5cf5, lsl #16
movk x3, #0x631a, lsl #32
movk x3, #0x5812, lsl #48
movz x4, #0x9cd6
movk x4, #0xa2f7, lsl #16
movk x4, #0xf9de, lsl #32
movk x4, #0x14de, lsl #48
lsr x2, x15, #60
and x15, x15, #0x0FFFFFFFFFFFFFFF
mul x5, x3, x2
mul x6, x4, x2
umulh x7, x3, x2
adds x6, x6, x7
umulh x7, x4, x2
adc x7, x7, xzr
subs x12, x12, x5
sbcs x13, x13, x6
sbcs x14, x14, x7
sbcs x15, x15, xzr
csel x5, x3, xzr, cc
csel x6, x4, xzr, cc
adds x12, x12, x5
and x7, x5, #0x1000000000000000
adcs x13, x13, x6
adcs x14, x14, xzr
adc x15, x15, x7
extr x2, x15, x14, #60
and x14, x14, #0x0FFFFFFFFFFFFFFF
sub x2, x2, x15, lsr #60
and x5, x15, #0xF000000000000000
add x14, x14, x5
mul x5, x3, x2
mul x6, x4, x2
umulh x7, x3, x2
adds x6, x6, x7
umulh x7, x4, x2
adc x7, x7, xzr
subs x11, x11, x5
sbcs x12, x12, x6
sbcs x13, x13, x7
sbcs x14, x14, xzr
csel x5, x3, xzr, cc
csel x6, x4, xzr, cc
adds x11, x11, x5
and x7, x5, #0x1000000000000000
adcs x12, x12, x6
adcs x13, x13, xzr
adc x14, x14, x7
extr x2, x14, x13, #60
and x13, x13, #0x0FFFFFFFFFFFFFFF
sub x2, x2, x14, lsr #60
and x5, x14, #0xF000000000000000
add x13, x13, x5
mul x5, x3, x2
mul x6, x4, x2
umulh x7, x3, x2
adds x6, x6, x7
umulh x7, x4, x2
adc x7, x7, xzr
subs x10, x10, x5
sbcs x11, x11, x6
sbcs x12, x12, x7
sbcs x13, x13, xzr
csel x5, x3, xzr, cc
csel x6, x4, xzr, cc
adds x10, x10, x5
and x7, x5, #0x1000000000000000
adcs x11, x11, x6
adcs x12, x12, xzr
adc x13, x13, x7
extr x2, x13, x12, #60
and x12, x12, #0x0FFFFFFFFFFFFFFF
sub x2, x2, x13, lsr #60
and x5, x13, #0xF000000000000000
add x12, x12, x5
mul x5, x3, x2
mul x6, x4, x2
umulh x7, x3, x2
adds x6, x6, x7
umulh x7, x4, x2
adc x7, x7, xzr
subs x9, x9, x5
sbcs x10, x10, x6
sbcs x11, x11, x7
sbcs x12, x12, xzr
csel x5, x3, xzr, cc
csel x6, x4, xzr, cc
adds x9, x9, x5
and x7, x5, #0x1000000000000000
adcs x10, x10, x6
adcs x11, x11, xzr
adc x12, x12, x7
extr x2, x12, x11, #60
and x11, x11, #0x0FFFFFFFFFFFFFFF
sub x2, x2, x12, lsr #60
and x5, x12, #0xF000000000000000
add x11, x11, x5
mul x5, x3, x2
mul x6, x4, x2
umulh x7, x3, x2
adds x6, x6, x7
umulh x7, x4, x2
adc x7, x7, xzr
subs x8, x8, x5
sbcs x9, x9, x6
sbcs x10, x10, x7
sbcs x11, x11, xzr
csel x5, x3, xzr, cc
csel x6, x4, xzr, cc
adds x8, x8, x5
and x7, x5, #0x1000000000000000
adcs x9, x9, x6
adcs x10, x10, xzr
adc x11, x11, x7
stp             x8, x9, [x19]
stp             x10, x11, [x19, #16]
ldp             x19, x20, [sp], #16
ret
