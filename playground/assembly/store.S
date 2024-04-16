.globl _store
.globl _store_slice

_store:
    add x0,x0,x1
    str x0,[x2]
    ret

_store_slice:
    add x1,x0,#4
    add x2,x0,#6
    add x1,x1,x2
    str x1,[x0]
    ret

