bignum_tomont_p256:
bignum_tomont_p256_alt:
    ldp             x2, x3, [x1]
    ldp             x4, x5, [x1, #16]
    mov             x1, #0xffffffffffffffff
    mov             x7, #0x00000000ffffffff
    mov             x9, #0xffffffff00000001
    subs            x1, x2, x1
    sbcs            x7, x3, x7
    sbcs            x8, x4, xzr
    sbcs            x9, x5, x9
    csel            x2, x2, x1, cc
    csel            x3, x3, x7, cc
    csel            x4, x4, x8, cc
    csel            x5, x5, x9, cc
    stp             x3, x4, [x0]
    stp             x5, x6, [x0, #16]
ret
