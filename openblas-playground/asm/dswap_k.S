dswap_k:
cmp x0, xzr
b.le dswap_k_114
cmp x4, #0x1
b.ne dswap_k_70
cmp x6, #0x1
b.ne dswap_k_70
asr x1, x0, #3
cmp x1, xzr
b.eq dswap_k_4c
dswap_k_24:
ld1 { v0.4s, v1.4s }, [x3]
ld1 { v2.4s, v3.4s }, [x5]
st1 { v0.4s, v1.4s }, [x5], #32
st1 { v2.4s, v3.4s }, [x3], #32
ld1 { v0.4s, v1.4s }, [x3]
ld1 { v2.4s, v3.4s }, [x5]
st1 { v0.4s, v1.4s }, [x5], #32
st1 { v2.4s, v3.4s }, [x3], #32
subs x1, x1, #0x1
b.ne dswap_k_24
dswap_k_4c:
ands x1, x0, #0x7
b.le dswap_k_114
dswap_k_54:
ldr d0, [x3]
ldr d1, [x5]
str d0, [x5], #0x8
str d1, [x3], #0x8
subs x1, x1, #0x1
b.ne dswap_k_54
b dswap_k_114
dswap_k_70:
lsl x4, x4, #3
lsl x6, x6, #3
asr x1, x0, #2
cmp x1, xzr
b.le dswap_k_ec
dswap_k_84:
ldr x10, [x3]
ldr x11, [x5]
str x10, [x5]
str x11, [x3]
add x5, x5, x6
add x3, x3, x4
ldr x10, [x3]
ldr x11, [x5]
str x10, [x5]
str x11, [x3]
add x5, x5, x6
add x3, x3, x4
ldr x10, [x3]
ldr x11, [x5]
str x10, [x5]
str x11, [x3]
add x5, x5, x6
add x3, x3, x4
ldr x10, [x3]
ldr x11, [x5]
str x10, [x5]
str x11, [x3]
add x5, x5, x6
add x3, x3, x4
subs x1, x1, #0x1
b.ne dswap_k_84
dswap_k_ec:
ands x1, x0, #0x3
b.le dswap_k_114
dswap_k_f4:
ldr x10, [x3]
ldr x11, [x5]
str x10, [x5]
str x11, [x3]
add x5, x5, x6
add x3, x3, x4
subs x1, x1, #0x1
b.ne dswap_k_f4
dswap_k_114:
mov w0, wzr
ret
