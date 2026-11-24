import sys, re, collections
def parse(text):
    toks=re.findall(r'\(|\)|"(?:[^"\\]|\\.)*"|[^\s()]+', text)
    stack=[[]]
    for t in toks:
        if t=='(': stack.append([])
        elif t==')': x=stack.pop(); stack[-1].append(x)
        else: stack[-1].append(t)
    return stack[0]
def show(x): return x if isinstance(x,str) else '('+' '.join(show(y) for y in x)+')'
def fields(entry):
    return {e[0]:e[1:] for e in entry if isinstance(e,list) and e and isinstance(e[0],str)}
def is_const(x): return x[0]=='SingleConst' if isinstance(x,list) else False
def base_like(x):
    if not isinstance(x,list): return False
    if x[0]=='SingleVar': return True
    if x[0]=='SingleBExp' and x[1]=='SingleAdd': return base_like(x[2]) or base_like(x[3])
    return False
def classify(c):
    s=show(c)
    if c[0]=='NoOverflow': return 'layout'
    if c[0]=='Or' and all(isinstance(d,list) and d[0]=='Cond' and d[1][0]=='Le' for d in c[1]): return 'nonoverlap'
    if c[0]=='Cond':
        op,a,b=c[1][0],c[1][1],c[1][2]
        if op=='Eq' and 'SingleAnd' in s and '(SingleConst 7)' in s: return 'alignment'
        if is_const(a) and is_const(b): return 'layout'
        if op in('Lt','Le') and is_const(a) and a[1]=='0' and base_like(b): return 'layout'
        if op=='Le' and base_like(a) and show(b).startswith('(SingleBExp SingleAdd '+show(a)): return 'layout'
        if op=='Le' and is_const(a) and a[1]=='0': return 'layout'
        if op=='Lt' and is_const(b) and b[1]=='2147483648': return 'layout'
        def var_plus_const(x):
            if isinstance(x,list) and x[0]=='SingleVar': return x[1]
            if isinstance(x,list) and x[0]=='SingleBExp' and x[1]=='SingleAdd' and isinstance(x[2],list) and x[2][0]=='SingleVar' and is_const(x[3]): return x[2][1]
            return None
        if op=='Le' and var_plus_const(a) is not None and var_plus_const(a)==var_plus_const(b): return 'layout'
    return 'other'
for path in sys.argv[1:]:
    data=parse(open(path).read())[0]
    seen=set()
    for entry in data:
        f=fields(entry)
        name=f.get('func_name',['?'])[0]
        if name in seen or name.startswith(('memcpy','memset')): continue
        seen.add(name)
        ctx=f.get('in_context',[[]])[0]
        cls=collections.Counter(classify(c) for c in ctx)
        others=[show(c) for c in ctx if classify(c)=='other']
        print(f"{path.split('/')[-1].split('.')[0]}\t{name}\t{len(ctx)}\t{cls['layout']}\t{cls['nonoverlap']}\t{cls['alignment']}\t{cls['other']}\t{' ;; '.join(o[:160] for o in others)}")
