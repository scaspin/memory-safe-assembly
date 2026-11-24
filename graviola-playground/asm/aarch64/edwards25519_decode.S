edwards25519_decode:
stp             x19, x20, [sp, #-16]!
stp             x21, x30, [sp, #-16]!
sub             sp, sp, #(24*8+0)
mov             x19, x0
ldrb            w0, [x1]
lsl             x4, x0, #56
ldrb            w0, [x1, #1]
extr            x4, x0, x4, #8
ldrb            w0, [x1, #2]
extr            x4, x0, x4, #8
ldrb            w0, [x1, #3]
extr            x4, x0, x4, #8
ldrb            w0, [x1, #4]
extr            x4, x0, x4, #8
ldrb            w0, [x1, #5]
extr            x4, x0, x4, #8
ldrb            w0, [x1, #6]
extr            x4, x0, x4, #8
ldrb            w0, [x1, #7]
extr            x4, x0, x4, #8
ldrb            w0, [x1, #8]
lsl             x5, x0, #56
ldrb            w0, [x1, #9]
extr            x5, x0, x5, #8
ldrb            w0, [x1, #10]
extr            x5, x0, x5, #8
ldrb            w0, [x1, #11]
extr            x5, x0, x5, #8
ldrb            w0, [x1, #12]
extr            x5, x0, x5, #8
ldrb            w0, [x1, #13]
extr            x5, x0, x5, #8
ldrb            w0, [x1, #14]
extr            x5, x0, x5, #8
ldrb            w0, [x1, #15]
extr            x5, x0, x5, #8
ldrb            w0, [x1, #16]
lsl             x6, x0, #56
ldrb            w0, [x1, #17]
extr            x6, x0, x6, #8
ldrb            w0, [x1, #18]
extr            x6, x0, x6, #8
ldrb            w0, [x1, #19]
extr            x6, x0, x6, #8
ldrb            w0, [x1, #20]
extr            x6, x0, x6, #8
ldrb            w0, [x1, #21]
extr            x6, x0, x6, #8
ldrb            w0, [x1, #22]
extr            x6, x0, x6, #8
ldrb            w0, [x1, #23]
extr            x6, x0, x6, #8
ldrb            w0, [x1, #24]
lsl             x7, x0, #56
ldrb            w0, [x1, #25]
extr            x7, x0, x7, #8
ldrb            w0, [x1, #26]
extr            x7, x0, x7, #8
ldrb            w0, [x1, #27]
extr            x7, x0, x7, #8
ldrb            w0, [x1, #28]
extr            x7, x0, x7, #8
ldrb            w0, [x1, #29]
extr            x7, x0, x7, #8
ldrb            w0, [x1, #30]
extr            x7, x0, x7, #8
ldrb            w0, [x1, #31]
extr            x7, x0, x7, #8
stp             x4, x5, [sp, #0]
lsr             x20, x7, #63
and             x7, x7, #0x7FFFFFFFFFFFFFFF
stp             x6, x7, [sp, #(0+16)]
adds            xzr, x4, #19
adcs            xzr, x5, xzr
adcs            xzr, x6, xzr
adcs            xzr, x7, xzr
cset            x21, mi
add x0, sp, #(16*8)
mov x1, 1
add x2, sp, #0
bl Ledwards25519_decode_alt_nsqr_p25519
ldp             x0, x1, [sp, #(16*8)]
ldp             x2, x3, [sp, #((16*8)+16)]
mov             x4, #0x8000000000000000
subs            x0, x0, #20
sbcs            x1, x1, xzr
sbcs            x2, x2, xzr
sbc             x3, x3, x4
stp             x0, x1, [sp, #(12*8)]
stp             x2, x3, [sp, #((12*8)+16)]
movz x0, #0x78a3
movk x0, #0x1359, lsl #16
movk x0, #0x4dca, lsl #32
movk x0, #0x75eb, lsl #48
movz x1, #0xd8ab
movk x1, #0x4141, lsl #16
movk x1, #0x0a4d, lsl #32
movk x1, #0x0070, lsl #48
movz x2, #0xe898
movk x2, #0x7779, lsl #16
movk x2, #0x4079, lsl #32
movk x2, #0x8cc7, lsl #48
movz x3, #0xfe73
movk x3, #0x2b6f, lsl #16
movk x3, #0x6cee, lsl #32
movk x3, #0x5203, lsl #48
stp             x0, x1, [sp, #(20*8)]
stp             x2, x3, [sp, #((20*8)+16)]
add x0, sp, #(16*8)
add x1, sp, #(20*8)
add x2, sp, #(16*8)
bl Ledwards25519_decode_alt_mul_p25519
ldp             x0, x1, [sp, #(16*8)]
ldp             x2, x3, [sp, #((16*8)+16)]
adds            x0, x0, #1
adcs            x1, x1, xzr
adcs            x2, x2, xzr
adcs            x3, x3, xzr
stp             x0, x1, [sp, #(16*8)]
stp             x2, x3, [sp, #((16*8)+16)]
add x0, sp, #(20*8)
add x1, sp, #(12*8)
add x2, sp, #(16*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(8*8)
mov x1, 1
add x2, sp, #(20*8)
bl Ledwards25519_decode_alt_nsqr_p25519
add x0, sp, #(8*8)
add x1, sp, #(8*8)
add x2, sp, #(20*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(4*8)
mov x1, 2
add x2, sp, #(8*8)
bl Ledwards25519_decode_alt_nsqr_p25519
add x0, sp, #(8*8)
add x1, sp, #(4*8)
add x2, sp, #(8*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(4*8)
mov x1, 1
add x2, sp, #(8*8)
bl Ledwards25519_decode_alt_nsqr_p25519
add x0, sp, #(16*8)
add x1, sp, #(4*8)
add x2, sp, #(20*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(4*8)
mov x1, 5
add x2, sp, #(16*8)
bl Ledwards25519_decode_alt_nsqr_p25519
add x0, sp, #(8*8)
add x1, sp, #(4*8)
add x2, sp, #(16*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(4*8)
mov x1, 10
add x2, sp, #(8*8)
bl Ledwards25519_decode_alt_nsqr_p25519
add x0, sp, #(8*8)
add x1, sp, #(4*8)
add x2, sp, #(8*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(4*8)
mov x1, 5
add x2, sp, #(8*8)
bl Ledwards25519_decode_alt_nsqr_p25519
add x0, sp, #(16*8)
add x1, sp, #(4*8)
add x2, sp, #(16*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(4*8)
mov x1, 25
add x2, sp, #(16*8)
bl Ledwards25519_decode_alt_nsqr_p25519
add x0, sp, #(8*8)
add x1, sp, #(4*8)
add x2, sp, #(16*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(4*8)
mov x1, 50
add x2, sp, #(8*8)
bl Ledwards25519_decode_alt_nsqr_p25519
add x0, sp, #(8*8)
add x1, sp, #(4*8)
add x2, sp, #(8*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(4*8)
mov x1, 25
add x2, sp, #(8*8)
bl Ledwards25519_decode_alt_nsqr_p25519
add x0, sp, #(16*8)
add x1, sp, #(4*8)
add x2, sp, #(16*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(4*8)
mov x1, 125
add x2, sp, #(16*8)
bl Ledwards25519_decode_alt_nsqr_p25519
add x0, sp, #(16*8)
add x1, sp, #(4*8)
add x2, sp, #(16*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(4*8)
mov x1, 2
add x2, sp, #(16*8)
bl Ledwards25519_decode_alt_nsqr_p25519
add x0, sp, #(4*8)
add x1, sp, #(4*8)
add x2, sp, #(20*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(16*8)
mov x1, 1
add x2, sp, #(4*8)
bl Ledwards25519_decode_alt_nsqr_p25519
add x0, sp, #(16*8)
add x1, sp, #(16*8)
add x2, sp, #(20*8)
bl Ledwards25519_decode_alt_mul_p25519
add x0, sp, #(4*8)
add x1, sp, #(12*8)
add x2, sp, #(4*8)
bl Ledwards25519_decode_alt_mul_p25519
movz x0, #0xa0b0
movk x0, #0x4a0e, lsl #16
movk x0, #0x1b27, lsl #32
movk x0, #0xc4ee, lsl #48
movz x1, #0xe478
movk x1, #0xad2f, lsl #16
movk x1, #0x1806, lsl #32
movk x1, #0x2f43, lsl #48
movz x2, #0xd7a7
movk x2, #0x3dfb, lsl #16
movk x2, #0x0099, lsl #32
movk x2, #0x2b4d, lsl #48
movz x3, #0xdf0b
movk x3, #0x4fc1, lsl #16
movk x3, #0x2480, lsl #32
movk x3, #0x2b83, lsl #48
stp             x0, x1, [sp, #(8*8)]
stp             x2, x3, [sp, #((8*8)+16)]
add x0, sp, #(8*8)
add x1, sp, #(4*8)
add x2, sp, #(8*8)
bl Ledwards25519_decode_alt_mul_p25519
ldp             x0, x1, [sp, #(16*8)]
ldp             x2, x3, [sp, #((16*8)+16)]
bic             x4, x0, #1
orr             x4, x4, x1
orr             x5, x2, x3
orr             x4, x4, x5
add             x0, x0, #20
add             x1, x1, #1
orr             x0, x0, x1
add             x2, x2, #1
eor             x3, x3, #0x7FFFFFFFFFFFFFFF
orr             x2, x2, x3
orr             x0, x0, x2
cmp             x4, xzr
ldp             x10, x11, [sp, #(4*8)]
ldp             x14, x15, [sp, #(8*8)]
csel            x10, x10, x14, eq
csel            x11, x11, x15, eq
ldp             x12, x13, [sp, #((4*8)+16)]
ldp             x16, x17, [sp, #((8*8)+16)]
csel            x12, x12, x16, eq
csel            x13, x13, x17, eq
stp             x10, x11, [sp, #(4*8)]
stp             x12, x13, [sp, #((4*8)+16)]
ccmp            x0, xzr, 4, ne
cset            x0, ne
orr             x21, x21, x0
ldp             x0, x1, [sp, #(4*8)]
ldp             x2, x3, [sp, #((4*8)+16)]
mov             x4, #-19
subs            x4, x4, x0
mov             x6, #-1
sbcs            x5, x6, x1
sbcs            x6, x6, x2
mov             x7, #0x7FFFFFFFFFFFFFFF
sbc             x7, x7, x3
and             x9, x0, #1
eor             x20, x9, x20
orr             x8, x0, x1
orr             x9, x2, x3
orr             x8, x8, x9
orr             x10, x21, x20
cmp             x8, xzr
csel            x21, x10, x21, eq
ccmp            x20, xzr, #4, ne
csel            x0, x0, x4, eq
csel            x1, x1, x5, eq
csel            x2, x2, x6, eq
csel            x3, x3, x7, eq
ldp             x8, x9, [sp, #0]
ldp             x10, x11, [sp, #(0+16)]
stp             x0, x1, [x19]
stp             x2, x3, [x19, #16]
stp             x8, x9, [x19, #32]
stp             x10, x11, [x19, #48]
mov             x0, x21
add             sp, sp, #(24*8+0)
ldp             x21, x30, [sp], #16
ldp             x19, x20, [sp], #16
b               hoist_finish
Ledwards25519_decode_alt_mul_p25519:
ldp             x3, x4, [x1]
ldp             x7, x8, [x2]
mul             x12, x3, x7
umulh           x13, x3, x7
mul             x11, x3, x8
umulh           x14, x3, x8
adds            x13, x13, x11
ldp             x9, x10, [x2, #16]
mul             x11, x3, x9
umulh           x15, x3, x9
adcs            x14, x14, x11
mul             x11, x3, x10
umulh           x16, x3, x10
adcs            x15, x15, x11
adc             x16, x16, xzr
ldp             x5, x6, [x1, #16]
mul             x11, x4, x7
adds            x13, x13, x11
mul             x11, x4, x8
adcs            x14, x14, x11
mul             x11, x4, x9
adcs            x15, x15, x11
mul             x11, x4, x10
adcs            x16, x16, x11
umulh           x3, x4, x10
adc             x3, x3, xzr
umulh           x11, x4, x7
adds            x14, x14, x11
umulh           x11, x4, x8
adcs            x15, x15, x11
umulh           x11, x4, x9
adcs            x16, x16, x11
adc             x3, x3, xzr
mul             x11, x5, x7
adds            x14, x14, x11
mul             x11, x5, x8
adcs            x15, x15, x11
mul             x11, x5, x9
adcs            x16, x16, x11
mul             x11, x5, x10
adcs            x3, x3, x11
umulh           x4, x5, x10
adc             x4, x4, xzr
umulh           x11, x5, x7
adds            x15, x15, x11
umulh           x11, x5, x8
adcs            x16, x16, x11
umulh           x11, x5, x9
adcs            x3, x3, x11
adc             x4, x4, xzr
mul             x11, x6, x7
adds            x15, x15, x11
mul             x11, x6, x8
adcs            x16, x16, x11
mul             x11, x6, x9
adcs            x3, x3, x11
mul             x11, x6, x10
adcs            x4, x4, x11
umulh           x5, x6, x10
adc             x5, x5, xzr
umulh           x11, x6, x7
adds            x16, x16, x11
umulh           x11, x6, x8
adcs            x3, x3, x11
umulh           x11, x6, x9
adcs            x4, x4, x11
adc             x5, x5, xzr
mov             x7, #38
mul             x11, x7, x16
umulh           x9, x7, x16
adds            x12, x12, x11
mul             x11, x7, x3
umulh           x3, x7, x3
adcs            x13, x13, x11
mul             x11, x7, x4
umulh           x4, x7, x4
adcs            x14, x14, x11
mul             x11, x7, x5
umulh           x5, x7, x5
adcs            x15, x15, x11
cset            x16, hs
adds            x15, x15, x4
adc             x16, x16, x5
cmn             x15, x15
orr             x15, x15, #0x8000000000000000
adc             x8, x16, x16
mov             x7, #19
madd            x11, x7, x8, x7
adds            x12, x12, x11
adcs            x13, x13, x9
adcs            x14, x14, x3
adcs            x15, x15, xzr
csel            x7, x7, xzr, lo
subs            x12, x12, x7
sbcs            x13, x13, xzr
sbcs            x14, x14, xzr
sbc             x15, x15, xzr
and             x15, x15, #0x7fffffffffffffff
stp             x12, x13, [x0]
stp             x14, x15, [x0, #16]
ret
Ledwards25519_decode_alt_nsqr_p25519:
ldp             x6, x3, [x2]
ldp             x4, x5, [x2, #16]
mov             x2, x6
Ledwards25519_decode_alt_loop:
mul             x9, x2, x3
umulh           x10, x2, x3
mul             x11, x2, x5
umulh           x12, x2, x5
mul             x7, x2, x4
umulh           x6, x2, x4
adds            x10, x10, x7
adcs            x11, x11, x6
mul             x7, x3, x4
umulh           x6, x3, x4
adc             x6, x6, xzr
adds            x11, x11, x7
mul             x13, x4, x5
umulh           x14, x4, x5
adcs            x12, x12, x6
mul             x7, x3, x5
umulh           x6, x3, x5
adc             x6, x6, xzr
adds            x12, x12, x7
adcs            x13, x13, x6
adc             x14, x14, xzr
adds            x9, x9, x9
adcs            x10, x10, x10
adcs            x11, x11, x11
adcs            x12, x12, x12
adcs            x13, x13, x13
adcs            x14, x14, x14
cset            x6, hs
umulh           x7, x2, x2
mul             x8, x2, x2
adds            x9, x9, x7
mul             x7, x3, x3
adcs            x10, x10, x7
umulh           x7, x3, x3
adcs            x11, x11, x7
mul             x7, x4, x4
adcs            x12, x12, x7
umulh           x7, x4, x4
adcs            x13, x13, x7
mul             x7, x5, x5
adcs            x14, x14, x7
umulh           x7, x5, x5
adc             x6, x6, x7
mov             x3, #38
mul             x7, x3, x12
umulh           x4, x3, x12
adds            x8, x8, x7
mul             x7, x3, x13
umulh           x13, x3, x13
adcs            x9, x9, x7
mul             x7, x3, x14
umulh           x14, x3, x14
adcs            x10, x10, x7
mul             x7, x3, x6
umulh           x6, x3, x6
adcs            x11, x11, x7
cset            x12, hs
adds            x11, x11, x14
adc             x12, x12, x6
cmn             x11, x11
bic             x11, x11, #0x8000000000000000
adc             x2, x12, x12
mov             x3, #0x13
mul             x7, x3, x2
adds            x2, x8, x7
adcs            x3, x9, x4
adcs            x4, x10, x13
adc             x5, x11, xzr
subs            x1, x1, #1
bne             Ledwards25519_decode_alt_loop
adds            x6, x2, #19
adcs            x7, x3, xzr
adcs            x8, x4, xzr
adcs            x9, x5, xzr
csel            x2, x2, x6, pl
csel            x3, x3, x7, pl
csel            x4, x4, x8, pl
csel            x5, x5, x9, pl
bic             x5, x5, #0x8000000000000000
stp             x2, x3, [x0]
stp             x4, x5, [x0, #16]
ret
hoist_finish:
ret
