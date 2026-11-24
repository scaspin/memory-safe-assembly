bignum_mod_n25519:
cmp             x1, #4
bcc             Lbignum_mod_n25519_short
sub             x1, x1, #4
lsl             x7, x1, #3
add             x7, x7, x2
ldp             x5, x6, [x7, #16]
ldp             x3, x4, [x7]
movz x11, #0xd3ed
movk x11, #0x5cf5, lsl #16
movk x11, #0x631a, lsl #32
movk x11, #0x5812, lsl #48
movz x12, #0x9cd6
movk x12, #0xa2f7, lsl #16
movk x12, #0xf9de, lsl #32
movk x12, #0x14de, lsl #48
lsr             x13, x6, #60
and             x6, x6, #0x0FFFFFFFFFFFFFFF
mul             x7, x11, x13
mul             x8, x12, x13
umulh           x9, x11, x13
adds            x8, x8, x9
umulh           x9, x12, x13
adc             x9, x9, xzr
subs            x3, x3, x7
sbcs            x4, x4, x8
sbcs            x5, x5, x9
sbcs            x6, x6, xzr
csel            x7, x11, xzr, cc
csel            x8, x12, xzr, cc
adds            x3, x3, x7
adcs            x4, x4, x8
and             x7, x7, #0x1000000000000000
adcs            x5, x5, xzr
adc             x6, x6, x7
cbz             x1, Lbignum_mod_n25519_writeback
Lbignum_mod_n25519_loop:
extr            x13, x6, x5, #60
and             x5, x5, #0x0FFFFFFFFFFFFFFF
sub             x13, x13, x6, lsr #60
and             x6, x6, #0xF000000000000000
add             x5, x5, x6
mul             x7, x11, x13
mul             x8, x12, x13
umulh           x9, x11, x13
adds            x8, x8, x9
umulh           x9, x12, x13
adc             x9, x9, xzr
sub             x1, x1, #1
ldr             x13, [x2, x1, lsl #3]
subs            x7, x13, x7
sbcs            x8, x3, x8
sbcs            x9, x4, x9
sbcs            x10, x5, xzr
csel            x3, x11, xzr, cc
csel            x4, x12, xzr, cc
adds            x3, x7, x3
and             x6, x4, #0x1000000000000000
adcs            x4, x8, x4
adcs            x5, x9, xzr
adc             x6, x10, x6
cbnz            x1, Lbignum_mod_n25519_loop
Lbignum_mod_n25519_writeback:
stp             x3, x4, [x0]
stp             x5, x6, [x0, #16]
b               hoist_finish
Lbignum_mod_n25519_short:
mov             x3, xzr
mov             x4, xzr
mov             x5, xzr
mov             x6, xzr
cbz             x1, Lbignum_mod_n25519_writeback
ldr             x3, [x2]
subs            x1, x1, #1
beq             Lbignum_mod_n25519_writeback
ldr             x4, [x2, #8]
subs            x1, x1, #1
beq             Lbignum_mod_n25519_writeback
ldr             x5, [x2, #16]
b               Lbignum_mod_n25519_writeback
hoist_finish:
ret
