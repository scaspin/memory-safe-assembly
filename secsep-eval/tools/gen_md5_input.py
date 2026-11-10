import sys
def reg_type(sized, public):
    return "\n".join(f"     ((RangeConst {'(0 8)' if i in sized else '(0 0)'}) ((SingleVar {i}) {'(false)' if i in public else '()'}))" for i in range(32))
def slot(a,b): return f"(((SingleConst {a}) (SingleConst {b})) (RangeConst ()) (SingleTop ()))"
def valid(size): return f"((((SingleConst 0) {size}) (RangeConst (((SingleConst 0) {size}))) (SingleTop (true))))"
def stack(spills):
    return "((4 (Unified (() true true))) (" + " ".join(slot(a,b) for a,b in spills+[(0,8)]) + "))"
def entry(name, sized, public, spills, regions):
    mem=[stack(spills)]+[f"(({r} (Unified (() true {'true' if c else 'false'}))) {valid(s)})" for r,s,c in regions]
    return f"""((func_name {name})
   (reg_type (
{reg_type(sized, public)}))
   (mem_type ({' '.join(mem)}))
   (stack_spill_info ({' '.join(f'({a} {b})' for a,b in spills)}))
   (constr_info ((constr_in ()) (constr_out ()))))"""
md5=entry("md5_block_asm_data_order",{2,3,4,5,6,7,12,13,14,15},{2,4,6,7},[(-40+8*k,-32+8*k) for k in range(5)],
          [(7,"(SingleConst 16)",True),(6,"(SingleBExp SingleMul (SingleVar 2) (SingleConst 64))",False)])
main=entry("main",{3,4,5,12,13,14,15},{4},[(-8,0)],[])
g=lambda n,s:f"({n} {valid(f'(SingleConst {s})')})"
out=f"(({md5}\n {main})\n ({g('state',16)}\n  {g('msg',256)}))\n"
assert out.count('(')==out.count(')')
open(sys.argv[1],'w').write(out)
