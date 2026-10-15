bignum_demont_p256:
bignum_demont_p256_alt:
    ldp             x2, x3, [x1]
    ldp             x4, x5, [x1, #16]
    stp             x2, x3, [x0]
    stp             x4, x5, [x0, #16]
ret
