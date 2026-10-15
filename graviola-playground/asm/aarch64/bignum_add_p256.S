bignum_add_p256:
    ldp             x4, x5, [x1]
    ldp             x8, x9, [x2]
    adds            x4, x4, x8
    adcs            x5, x5, x9
    ldp             x6, x7, [x1, #16]
    ldp             x10, x11, [x2, #16]
    adcs            x6, x6, x10
    adcs            x7, x7, x11
    adc             x3, xzr, xzr
    subs            x8, x4, #0xffffffffffffffff
    mov             x9, #0x00000000ffffffff
    sbcs            x9, x5, x9
    sbcs            x10, x6, xzr
    mov             x11, #0xffffffff00000001
    sbcs            x11, x7, x11
    sbcs            x3, x3, xzr
    csel            x4, x4, x8, cc
    csel            x5, x5, x9, cc
    csel            x6, x6, x10, cc
    csel            x7, x7, x11, cc
    stp             x4, x5, [x0]
    stp             x6, x7, [x0, #16]
ret
