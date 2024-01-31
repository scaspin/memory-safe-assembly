start: 
    add x3,x1,x2
    add x2,x2,x1
loop:
    ldr x4,[x1]
    add x1,x1,#1
    cmp x1,x3
    b.ne loop
add x4,x4,#4
