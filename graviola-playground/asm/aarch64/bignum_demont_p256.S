bignum_demont_p256:
bignum_demont_p256_alt:
ldp             x2, x3, [x1]
ldp             x4, x5, [x1, #16]
lsl x7, x2, #32
subs x8, x2, x7
lsr x6, x2, #32
sbc x2, x2, x6
adds x3, x3, x7
adcs x4, x4, x6
adcs x5, x5, x8
adc x2, x2, xzr
lsl x7, x3, #32
subs x8, x3, x7
lsr x6, x3, #32
sbc x3, x3, x6
adds x4, x4, x7
adcs x5, x5, x6
adcs x2, x2, x8
adc x3, x3, xzr
lsl x7, x4, #32
subs x8, x4, x7
lsr x6, x4, #32
sbc x4, x4, x6
adds x5, x5, x7
adcs x2, x2, x6
adcs x3, x3, x8
adc x4, x4, xzr
lsl x7, x5, #32
subs x8, x5, x7
lsr x6, x5, #32
sbc x5, x5, x6
adds x2, x2, x7
adcs x3, x3, x6
adcs x4, x4, x8
adc x5, x5, xzr
stp             x2, x3, [x0]
stp             x4, x5, [x0, #16]
ret
