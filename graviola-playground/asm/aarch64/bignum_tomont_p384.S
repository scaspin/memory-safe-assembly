bignum_tomont_p384:
bignum_tomont_p384_alt:
    ldp             x2, x3, [x1]
    ldp             x4, x5, [x1, #16]
    ldp             x6, x7, [x1, #32]
    mov             x8, #0x00000000ffffffff
    mov             x9, #0xffffffff00000000
    mov             x10, #0xfffffffffffffffe
    subs            x8, x2, x8
    sbcs            x9, x3, x9
    sbcs            x10, x4, x10
    adcs            x11, x5, xzr
    adcs            x12, x6, xzr
    adcs            x1, x7, xzr
    csel            x2, x2, x8, cc
    csel            x3, x3, x9, cc
    csel            x4, x4, x10, cc
    csel            x5, x5, x11, cc
    csel            x6, x6, x12, cc
    csel            x7, x7, x1, cc
    stp             x3, x4, [x0]
    stp             x5, x6, [x0, #16]
    stp             x7, x8, [x0, #32]
ret
