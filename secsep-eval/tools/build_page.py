import json,os
D=os.path.dirname(os.path.abspath(__file__))
pts=json.load(open(f'{D}/points.json'))
notes=[
 "<strong>SecSep time</strong> is CPU time spent on that function in Octal's four solver-backed phases (dependent type, valid region, taint, type check), measured with per-function timers added to Octal. A caller reuses the interfaces already inferred for its callees.",
 "<strong>BUMS time</strong> is wall-clock time of one <code>bums-check</code> child process, one function at a time. BUMS re-executes every callee inside its caller.",
 "<strong>Clauses</strong>: for SecSep, each <code>@valid</code>, <code>@size</code>, <code>@taint</code>, <code>@const</code>, <code>@overlap</code>, <code>@sym</code> or <code>@unit</code> tag plus each <code>@secsep_in</code>/<code>@secsep_out</code> constraint. For BUMS, each argument binding plus each bracketed precondition. <strong>Tokens</strong> count identifiers, numbers and symbols in the annotation; for BUMS this includes the Rust signature, which is written by hand.",
 "All 21 functions verify in both tools. All BUMS times come from one sweep without logging, one function at a time.",
]
t=open(f'{D}/annot-chart/template.html').read()
t=t.replace('/*DATA*/[]',json.dumps(pts)).replace('/*NOTES*/[]',json.dumps(notes))
head='<!DOCTYPE html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1">\n'
i=t.index('<div class="page">')
page=head+t[:i]+'</head>\n<body>\n'+t[i:]+'\n</body>\n</html>\n'
open(f'{D}/annot-chart/index.html','w').write(page)
print(len(page))
