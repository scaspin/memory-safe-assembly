# A core calculus for the bums symbolic executor

This note writes the checker's transformations as a small calculus in λ-calculus style:
a term language, a few judgments, and inference rules. It describes the engine at commit
`b0007ce3` (branch `worktree-awslc-verify`). Rules name the function that implements
them, so they can be checked against the code. Where the code goes beyond a rule, or
falls short of it, the text says so.

The calculus has four layers, each built on the one before:

1. **Terms.** A first-order term language with a normalising constructor (§1–§2).
2. **Transfer.** One instruction maps an abstract state to a new state and a
   *continuation* (§3).
3. **Exploration.** A big-step judgment runs continuations against a path condition,
   forking, merging or pruning at branches (§4–§5).
4. **Acceleration.** A loop is closed by abstracting the state over a counter, giving a
   λκ-term, and checking that one more iteration is the same term at κ+1 (§6).

§7 states the soundness theorem the rules are meant to support and lists the
obligations the implementation does not yet discharge.

---

## 0. Notation

| Symbol | Meaning |
|---|---|
| $\alpha, \beta$ | symbols (z3 integer constants): `x0`, region names, `loop3_?`, `select_12`, `unknown_value_7`, … |
| $n, m, k, \delta$ | 64-bit integer literals |
| $\nu\alpha.\,t$ | $t$ with $\alpha$ a fresh symbol (`fresh_unknown`, `next_carry`, `{loop}_widened_i`, …) |
| $t[e/\alpha]$ | capture-free substitution |
| $\Pi$ | path condition, a stack of scopes of formulas |
| $\Pi \vDash \psi$ | $\Pi \wedge \neg\psi$ is unsat (`check_assumptions` returns `Unsat`) |
| $\mathsf{sat}(\Pi)$ | $\Pi$ has a model |

Every query is made under assumptions: the solver never sees $\neg\psi$ asserted
permanently. "unsat" always means z3 returned `Unsat`. `Unknown` is never treated as
`Unsat` except in the one place noted in §4.1.

---

## 1. Syntax

### 1.1 Terms and comparisons (`AbstractExpression`, `AbstractComparison`)

$$
\begin{array}{rcll}
e & ::= & n & \text{literal (Immediate)}\\
  & \mid & \alpha & \text{symbol (Abstract)}\\
  & \mid & \varepsilon & \text{Empty, read as } 0\\
  & \mid & e \oplus e & \oplus \in \{+,-,*,/,\%,\&,|,\hat{\ },\mathsf{lsl},\mathsf{lsr},\mathsf{asr},\mathsf{umulh},\ldots\}\\
  & \mid & \lceil v \rceil & \text{a boxed register value (only inside comparisons)}\\[4pt]
c & ::= & e \bowtie e & \bowtie\ \in \{<,\le,>,\ge,=,\neq\}
\end{array}
$$

Negation is syntactic: $\neg(e_1 < e_2) = (e_1 \ge e_2)$, and so on (`AbstractComparison::not`).

### 1.2 Abstract values (`RegisterValue`)

A register holds one of three forms, matching the three `RegisterKind`s:

$$
v ::= \underline{n} \;\;(\textsf{Immediate}) \quad\mid\quad \langle e\rangle{+}n \;\;(\textsf{RegisterBase}) \quad\mid\quad \top \;\;(\textsf{Number})
$$

The split into base and offset is the central representation choice. Pointer
arithmetic by constants changes only the offset, so the base stays a recognisable region
symbol.

The term a value denotes (`RegisterValue::expression`) is

$$
\lfloor \underline{n} \rfloor = n \qquad
\lfloor \langle e\rangle{+}n \rfloor = e \boxplus n \qquad
\lfloor \top \rfloor = \nu\alpha.\,\alpha
$$

Each read of $\top$ yields a *fresh* symbol. Two reads of the same unknown register
are therefore unrelated: this is sound but loses equalities.

### 1.3 Flags (`FlagValue`)

$$
f ::= \mathsf{tt} \mid \mathsf{ff} \mid c \mid \bot
$$

$\bot$ (`None`) means "never set". A branch that reads $\bot$ is an error, not
nondeterminism. That is why widening (§6) leaves $\bot$ alone.

### 1.4 Memory (`MemorySafeRegion`)

A region is $R = \langle \kappa_R, \ell_R, a_R, \mathit{cells}_R\rangle$:

- $\kappa_R \in \{\mathsf{R}, \mathsf{W}, \mathsf{RW}\}$ is its kind.
- $\ell_R$ is its length in bytes, a term such as `len * 8`.
- $a_R$ is its alignment.
- $\mathit{cells}_R : \mathbb{Z} \rightharpoonup v$ is sparse; an absent cell reads as $\top$.

The memory $\mu$ maps region names to regions. A region name is also a symbol: the
symbol `R` denotes the region's base address. Labelled data lives in the region `memory`,
with label offsets in $\lambda_\mu$ (`memory_labels`).

### 1.5 States and contexts

$$
\sigma = (\rho,\ \varphi,\ \mu) \qquad \rho : \mathsf{Reg}_{33} \to v \qquad \varphi : \{Z,N,C,V\} \to f
$$

The *path context* $\Gamma$ carries everything that is not machine state:

$$
\Gamma = (\Pi,\ \Delta,\ H,\ J,\ \mathcal{A})
$$

| Component | Code | Contents |
|---|---|---|
| $\Pi$ | `solver` + `scopes` | a stack of named scopes of asserted formulas |
| $\Delta$ | `select_definitions` | $\alpha \mapsto (c, e_t, e_f)$: $\alpha$ is $e_t$ if $c$, else $e_f$ |
| $H$ | `jump_history` | branch records $h = (pc, c, \sigma, \mathit{taken}, \mathit{resolved})$ |
| $J$ | `write_journal` | cell writes $(R, n, v_{\text{old}})$, for undo and loop analysis |
| $\mathcal{A}$ | `active_loops` | open loop summaries awaiting their inductive check (§6.5) |

A configuration is $\Gamma \vdash \langle pc, \sigma\rangle$.

---

## 2. The term algebra

### 2.1 Normalising constructor (`generate_expression`)

Terms are only ever built through $\boxplus_\oplus$, never with the raw node. For
$\oplus \in \{+,-\}$ it flattens both sides into a signed list of atoms and a constant,
cancels opposite equal atoms, and folds literals:

$$
\begin{aligned}
e \boxplus_{\pm} 0 &= e \qquad 0 \boxplus_+ e = e\\
e_1 \boxplus_{\pm} e_2 &= \mathsf{rebuild}\big(\mathsf{cancel}(\mathsf{terms}(e_1) \uplus \pm\,\mathsf{terms}(e_2))\big)
  && \text{if anything cancelled, flipped sign, or }{>}1\text{ literal}\\
e_1 \boxplus_{\oplus} e_2 &= e_1 \oplus e_2 && \text{otherwise}
\end{aligned}
$$

$\mathsf{terms}$ distributes through $+$ and $-$ and pulls negative literal factors out
of products ($a * -k \leadsto -(a * k)$). Constants fold with *saturating* arithmetic.
Normalisation is skipped above 256 nodes. This is syntactic, not semantic: it exists to
make $\delta = \lfloor v' \rfloor - \lfloor v\rfloor$ come out as a literal when it
is one, which §6.3 depends on.

### 2.2 Operations on values (`arithmetic_value`)

Only $+$ and $-$ distribute over the base/offset split. Write $\hat\oplus$ for the
64-bit literal operation:

$$
\begin{array}{lcl}
\underline{n} \oplus \underline{m} &=& \underline{n \mathbin{\hat\oplus} m}\\
\langle e\rangle{+}n \pm \underline{m} &=& \langle e\rangle{+}(n \mathbin{\hat\pm} m)\\
\underline{n} \pm \langle e\rangle{+}m &=& \langle e\rangle{+}(n \mathbin{\hat\pm} m) \quad(\dagger)\\
\langle e_1\rangle{+}n \pm \langle e_2\rangle{+}m &=& \langle e_1 \boxplus_\pm e_2\rangle{+}(n \mathbin{\hat\pm} m)\\
\top \oplus v \;=\; v \oplus \top &=& \top \qquad (v \text{ not based})\\
v_1 \oplus v_2 &=& \langle \lfloor v_1\rfloor \boxplus_\oplus \lfloor v_2\rfloor\rangle{+}0 \qquad (\oplus \notin\{+,-\},\ \text{either based})
\end{array}
$$

$(\dagger)$ is the rule as written in `arithmetic_value`. For $-$ it keeps $+e$ where the
value is $n - e$. Whether `sub` with an immediate first operand ever reaches this case
depends on the parser's operand order. I have not checked that here; see the "immediate
minus base sign" note in memory.

Writing a `w` register narrows (`narrow_to_32`):
$\underline{n} \mapsto \underline{n \bmod 2^{32}}$ and
$\langle e\rangle{+}n \mapsto \langle (e \boxplus n) \,\%\, 2^{32}\rangle{+}0$.

### 2.3 Interpretation into the solver (`expression_to_ast`, `comparison_to_ast`)

$[\![\cdot]\!] : e \to \mathsf{Int}$ maps terms to z3 **mathematical integers**:

$$
\begin{array}{lcl}
[\![n]\!] = n \quad [\![\alpha]\!] = \alpha \quad [\![\varepsilon]\!] = 0 &&
[\![\lceil \langle e\rangle{+}n\rceil]\!] = [\![e]\!] + n \quad [\![\lceil \top \rceil]\!] = \nu\alpha.\,\alpha\\[2pt]
[\![e_1 \circ e_2]\!] = [\![e_1]\!] \circ [\![e_2]\!] && \circ \in \{+,-,*,\mathsf{div},\bmod\}\\
[\![e \;\mathsf{lsl}\; k]\!] = [\![e]\!]\cdot 2^{k} && [\![e \;\mathsf{lsr}\; k]\!] = [\![e]\!] \mathbin{\mathsf{div}} 2^{k}\\
[\![e \,\&\, (2^k{-}1)]\!] = [\![e]\!] \bmod 2^k && [\![e \,\&\, {-2^k}]\!] = [\![e]\!] - ([\![e]\!] \bmod 2^k)\\
[\![e \,\&\, 2^k]\!] = \mathsf{bit}_k([\![e]\!]) && [\![e \,\&\, {\sim}2^k]\!] = [\![e]\!] - \mathsf{bit}_k([\![e]\!])\\
[\![e \;\hat{}\; e]\!] = 0 && [\![e_1 \mid e_2]\!] = [\![e_1]\!] + [\![e_2]\!] \quad (\text{bits provably disjoint})\\
[\![e]\!] = \mathsf{opaque}_{e} && \text{otherwise}
\end{array}
$$

$\mathsf{opaque}_e$ is an uninterpreted constant *named by $e$*. Two syntactically equal
opaque terms are therefore equal, and nothing else is known about them. This is the
calculus's only abstraction step: every rule above is exact over $\mathbb{Z}$, and
$\mathsf{opaque}$ over-approximates.

Under $\Delta$, a symbol defined by a select carries its definition. For a term $t$,
$\Delta^\ast(t)$ is the closure of `select_assumptions` / `select_definitions_in`:

$$
\Delta^\ast(t) = \bigwedge_{\alpha \in \mathrm{fv}^\ast(t),\ \Delta(\alpha) = (c, e_t, e_f)}
\big([\![c]\!] \Rightarrow \alpha = [\![e_t]\!]\big) \wedge \big(\neg[\![c]\!] \Rightarrow \alpha = [\![e_f]\!]\big)
$$

$\mathrm{fv}^\ast$ closes $\mathrm{fv}$ under the free variables of definitions and under
the symbols that bound a loop counter (`symbols_bounding_counter`). These are
*assumptions* passed per query, never asserted, so an unused definition costs nothing.

---

## 3. Transfer: $\sigma \vdash \iota \Rightarrow \sigma' ;\ k$

`ARMCORTEXA::execute` is a function from a state and an instruction to a new state and a
continuation (`ExecuteReturnType`):

$$
k ::= \mathsf{next} \mid \mathsf{jmp}\ \ell \mid \mathsf{jmp}?\ c\ \ell \mid \mathsf{sel}\ c\ r\ v_t\ v_f \mid \mathsf{ret} \mid \mathsf{fail}\ m
$$

Representative rules:

**Arithmetic.** $\sigma \vdash \mathtt{add}\ r, a, b \Rightarrow \sigma[\rho(r) \mapsto \rho(a) + \rho(b)];\ \mathsf{next}$,
using §2.2.

**Compare** (`cmp`) sets all four flags:

$$
\mathsf{cmp}(v_1, v_2) =
\begin{cases}
Z{=}\mathsf{tt},\ N{=}\mathsf{ff},\ C{=}\mathsf{tt},\ V{=}\mathsf{ff} & v_1 = v_2 \neq \top\\
\text{literal flags from } n, m & v_1 = \langle e\rangle{+}n,\ v_2 = \langle e\rangle{+}m \text{ (bases cancel)}, \text{ or both literal}\\
\nu\text{-fresh flags} & v_1 = v_2 = \top\\
Z{=}(d = 0),\ N{=}(d < 0),\ C{=}(\lceil v_1\rceil \ge \lceil v_2\rceil),\ V{=}(d < -2^{63}) & \text{otherwise, } d = \lceil v_1\rceil - \lceil v_2\rceil
\end{cases}
$$

**Conditional branch.** A flag that is $\mathsf{tt}$ or $\mathsf{ff}$ decides the branch
statically. A flag that is a comparison is re-expressed over the comparison's operands:
`b.lo` with $C = (l \ge r)$ gives $\mathsf{jmp}?\,(l < r)\,\ell$. A flag that is $\bot$
gives $\mathsf{fail}$.

`cbz` / `cbnz` / `tbz` test a value directly: a known literal decides, otherwise
$\mathsf{jmp}?\,(0 = \lceil v\rceil)\,\ell$.

**Select.** `csel r, a, b, cond` with literal flags is an assignment. With symbolic flags
it is $\mathsf{sel}\ c\ r\ \rho(a)\ \rho(b)$. Carry-dependent arithmetic (`adc`, `sbc`)
also produces a $\mathsf{sel}$ between its two results (`carry_select`).

**Addressing** (`indexed_address`). For base $\rho(b)$ and immediate $n$:

| Mode | Address accessed | Writeback |
|---|---|---|
| plain `[b, #n]` | $\rho(b) + \underline{n}$ | none |
| pre-index `[b, #n]!` | $\rho(b) + \underline{n}$ | $\rho(b) + \underline{n}$ |
| post-index `[b], #n` | $\rho(b)$ | $\rho(b) + \underline{n}$ |

**Load and store** call the safety judgment (§5) first, then:

$$
\frac{\Gamma \vdash \mathsf{safe}_{\mathsf R}(\langle e\rangle{+}n, w)}
     {\sigma \vdash \mathtt{ldr}\ t, \langle e\rangle{+}n \Rightarrow \sigma[\rho(t) \mapsto \mathit{read}_\mu(e, n)];\ \mathsf{next}}
\qquad
\mathit{read}_\mu(e, n) = \begin{cases} \mathit{cells}_R(n) \text{ or } \top & e = R \text{ (a bare region symbol)}\\ \top & \text{otherwise}\end{cases}
$$

$$
\frac{\Gamma \vdash \mathsf{safe}_{\mathsf W}(\langle R\rangle{+}n, w)}
     {\sigma \vdash \mathtt{str}\ t, \langle R\rangle{+}n \Rightarrow \sigma[\mathit{cells}_R(n) \mapsto \rho(t)];\ \mathsf{next}
      \quad J \mathrel{+}= (R, n, \mathit{cells}_R(n))}
$$

A store through a compound base (such as `R + 8*i`) is checked for safety, but it
updates no cell. That makes it a *blind write*. A blind write whose base mentions `sp`
is recorded in `blind_stack_writes`, so a loop summary can tell when it might have
clobbered a stack cell (§6.5).

---

## 4. Paths

### 4.1 Deciding a guard (`decide_from_solver`)

Let $A = \Pi \wedge \Delta^\ast(c)$. Then

$$
\mathsf{decide}_\Gamma(c) =
\begin{cases}
\mathsf{dead} & A \wedge c \text{ unsat and } A \wedge \neg c \text{ unsat}\\
\mathsf{take}\ \mathsf{tt} & A \wedge \neg c \text{ unsat}\\
\mathsf{take}\ \mathsf{ff} & A \wedge c \text{ unsat}\\
\mathsf{explore} & \text{otherwise}
\end{cases}
$$

The first case that matches wins. $\mathsf{take}\ \mathsf{tt}$ also fires when
$A \wedge c$ is `Unknown`, which is sound because only the negated side has to be unsat.

### 4.2 Forking

$\mathsf{fork}(\Gamma)$ copies $\Gamma$ and rebuilds the solver from $\Pi$, scope by scope
(`fork`). The copy shares no scope with its parent, so a fact asserted in one arm can
never leak into the other. Summaries, failure counts and loop ids are shared between
arms through `Rc`. They are bookkeeping, not facts.

Assertions go into the innermost scope: $\Pi \oplus \psi$ (`assert_in_scope`). Adding a
branch constraint also adds the select definitions it mentions:

$$
\Pi \oplus_b c \;\triangleq\; \Pi \oplus \Delta^\ast(c) \oplus (b\ ?\ c : \neg c)
\qquad (\texttt{add\_constraint})
$$

---

## 5. Exploration and safety

### 5.1 The exploration judgment

$\Gamma \vdash \langle pc, \sigma\rangle \Downarrow r$ with $r \in \{\mathsf{ok}\} \cup \{\mathsf{err}(M)\}$.
Results combine by $\mathsf{ok} \otimes r = r$ and
$\mathsf{err}(M_1) \otimes \mathsf{err}(M_2) = \mathsf{err}(M_1 \cup M_2)$
(`join_branch_errors`). Branch recursion is bounded by depth 32.

$$
\frac{\sigma \vdash P[pc] \Rightarrow \sigma';\ \mathsf{next} \qquad \Gamma \vdash \langle pc{+}1, \sigma'\rangle \Downarrow r}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow r}\ \textsc{(Next)}
\qquad
\frac{\sigma \vdash P[pc] \Rightarrow \sigma';\ \mathsf{jmp}\ \ell \qquad \Gamma \vdash \langle \ell, \sigma'\rangle \Downarrow r}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow r}\ \textsc{(Jmp)}
$$

$$
\frac{\sigma \vdash P[pc] \Rightarrow \sigma;\ \mathsf{fail}\ m}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow \mathsf{err}(\{pc{:}m\})}\ \textsc{(Fail)}
$$

Without `fail_fast`, **(Fail)** records the error and continues at $pc{+}1$. Unconditional
back edges are capped at 1000 visits, which reports a stuck loop rather than diverging.

**Branches.** Let $\sigma \vdash P[pc] \Rightarrow \sigma;\ \mathsf{jmp}?\ c\ \ell$,
and write $\mathit{tgt}(\mathsf{tt}) = \ell$ and $\mathit{tgt}(\mathsf{ff}) = pc{+}1$.
Each rule pushes a record $h = (pc, c, \sigma, b)$ onto $H$ (`take_conditional_branch`).

$$
\frac{\mathsf{decide}_\Gamma(c) = \mathsf{take}\ b \qquad \neg\mathsf{trigger}_\Gamma(pc, c) \qquad \Gamma[\Pi \oplus_b c] \vdash \langle \mathit{tgt}(b), \sigma\rangle \Downarrow r}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow r}\ \textsc{(Br-Take)}
$$

$$
\frac{\mathsf{decide}_\Gamma(c) = \mathsf{explore} \qquad \text{no acceleration or merge applies} \qquad
      \Gamma[\Pi \oplus_{\mathsf{tt}} c] \vdash \langle \ell, \sigma\rangle \Downarrow r_1 \qquad
      \mathsf{fork}(\Gamma)[\Pi \oplus_{\mathsf{ff}} c] \vdash \langle pc{+}1, \sigma\rangle \Downarrow r_2}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow r_1 \otimes r_2}\ \textsc{(Br-Fork)}
$$

$$
\frac{\mathsf{decide}_\Gamma(c) = \mathsf{dead}}{\Gamma \vdash \langle pc, \sigma\rangle \Downarrow \mathsf{ok}}\ \textsc{(Br-Dead)}
$$

**Concrete split** (`concrete_split`, `split_on`). If no loop is open and some
$\alpha \in \mathrm{fv}(c)$ has between 2 and 4 values under $\Pi$, the whole branch is
re-run once per value. The values are found by enumerating models and blocking each one
(`finite_values`):

$$
\frac{\mathcal{A} = \emptyset \qquad \mathsf{vals}_\Pi(\alpha) = \{n_1,\ldots,n_j\},\ 2 \le j \le 4 \qquad
      \forall i.\ \mathsf{fork}(\Gamma)[\Pi \oplus (\alpha = n_i)] \vdash \langle pc, \sigma\rangle \Downarrow r_i}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow \textstyle\bigotimes_i r_i}\ \textsc{(Split)}
$$

**Merging data-only arms** (`merge_branch_arms`). Suppose both arms are straight-line
`mov` or arithmetic code of at most 16 instructions that rejoin at a point $j$, and no
register that carries a region differs between the arms. Then the branch is not forked.
Every register that differs becomes a select:

$$
\frac{\sigma \vdash \mathit{arm}_{\mathsf{tt}} \Rightarrow^\ast_j \sigma_t \qquad \sigma \vdash \mathit{arm}_{\mathsf{ff}} \Rightarrow^\ast_j \sigma_f \qquad
      \forall r.\ \rho_t(r) \neq \rho_f(r) \Rightarrow \neg\mathsf{region}(\rho_t(r)) \wedge \neg\mathsf{region}(\rho_f(r)) \qquad
      \Gamma[\Delta \cup \Delta_\sqcup] \vdash \langle j, \sigma_t \sqcup_c \sigma_f\rangle \Downarrow r}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow r}\ \textsc{(Merge)}
$$

Here $(\sigma_t \sqcup_c \sigma_f)(r) = \langle \alpha_r\rangle{+}0$ with
$\Delta_\sqcup(\alpha_r) = (c, \lfloor\rho_t(r)\rfloor, \lfloor\rho_f(r)\rfloor)$ for
each register that differs, and the flags become fresh if the arms disagree on them.
$\mathsf{region}(v)$ holds when $\lfloor v \rfloor$ mentions a region symbol
(`carries_region`). The merge is exact: $\Delta$ says which arm each $\alpha_r$ came
from. So **(Merge)** loses nothing that **(Br-Fork)** would have kept, except
flag precision.

**Selects** (`take_select`). For $\mathsf{sel}\ c\ r\ v_t\ v_f$:

$$
\begin{array}{ll}
\mathsf{decide}_\Gamma(c) = \mathsf{take}\ b: & \rho(r) := v_b,\quad \Pi \oplus_b c\\[2pt]
v_t = \langle e\rangle{+}n_t,\ v_f = \langle e\rangle{+}n_f: & \rho(r) := \langle e \boxplus \alpha\rangle{+}0,\quad \Delta(\alpha) := (c, n_t, n_f)\\[2pt]
\neg\mathsf{region}(v_t) \wedge \neg\mathsf{region}(v_f): & \rho(r) := \langle\alpha\rangle{+}0,\quad \Delta(\alpha) := (c, \lfloor v_t\rfloor, \lfloor v_f\rfloor)\\[2pt]
\text{otherwise}: & \text{fork as in } \textsc{(Br-Fork)}
\end{array}
$$

The second line is the *same-base* rule: a pointer that moves by one of two strides
keeps its region, and the choice becomes a data symbol. The memory note "collapse data
selects, not addresses" is the reason only the last line forks.

### 5.2 The safety judgment (`mem_safe_access`)

$\Gamma \vdash \mathsf{safe}_\kappa(\langle e\rangle{+}n, w)$ says that a $w$-byte access
of kind $\kappa$ at $e + n$ stays inside one declared region on every model of $\Pi$.
Checking it takes four steps.

**1. Fold alignment** (`aligned_offset`, `aligned_parts`). If $e$ is $R$ masked by
$\&\,{-2^k}$ or $\hat{}\ k$ with $k < a_R$, the mask is absorbed into the offset, or
kept as an in-region term. An aligned base therefore still names $R$.

**2. Resolve the region.**
$\mathsf{reg}_\mu(e) = R$ if $e = R$. If $e$ is a label, it resolves to `memory` and the
label's offset. Otherwise it is the first region symbol that occurs in $e$, and the
access fails if there is none.

**3. Check the kind.** A write into a region of kind $\mathsf{R}$ is an error.

**4. Discharge two bound obligations.** Let $a = [\![e]\!] + n$. For an ordinary region:

$$
\mathit{lo} \triangleq a < R \qquad \mathit{hi} \triangleq a + w - 1 \ge R + [\![\ell_R]\!]
$$

For a base mentioning `sp`, the frame is symmetric about $R$. With displacement
$d = [\![e]\!] - R + n$:

$$
\mathit{lo} \triangleq d < -[\![\ell_R]\!] \qquad \mathit{hi} \triangleq d + w - 1 \ge [\![\ell_R]\!]
$$

Then, with $A = \Pi \wedge \Delta^\ast(e)$:

$$
\frac{\mathsf{reg}_\mu(e) = R \qquad \kappa \sqsubseteq \kappa_R \qquad
      \mathsf{sat}(A) \qquad A \wedge \mathit{lo}\ \text{unsat} \qquad A \wedge \mathit{hi}\ \text{unsat}}
     {\Gamma \vdash \mathsf{safe}_\kappa(\langle e\rangle{+}n, w)}\ \textsc{(Safe)}
$$

The premise $\mathsf{sat}(A)$ is the **non-vacuity** check. Without it, an infeasible
path would prove every access.

If either query is `Unknown`, there is one fallback (`safe_for_every_stride`). Pick a
symbol $\beta$ with at most 8 values under $\Pi$, and prove both obligations under each
$\beta = n_i$ separately:

$$
\frac{\mathsf{vals}_\Pi(\beta) = \{n_i\}_{i \le 8} \qquad \forall i.\ A \wedge \beta{=}n_i \wedge \mathit{lo}\ \text{unsat} \wedge A \wedge \beta{=}n_i \wedge \mathit{hi}\ \text{unsat}}
     {\Gamma \vdash \mathsf{safe}_\kappa(\langle e\rangle{+}n, w)}\ \textsc{(Safe-Split)}
$$

---

## 6. Loop acceleration

### 6.1 Overview

A loop is closed by **abstracting the state over a counter**. Let $N = 3$
(`SUMMARY_ITERATION`). After $N$ iterations have run symbolically, the engine builds a
state-valued function

$$
\sigma^\sharp = \lambda\kappa.\ \sigma^\sharp(\kappa)
$$

where $\kappa$ is a fresh rigid symbol `loopN_?`, along with a set of facts $\Phi(\kappa)$.
It then runs the body **once** from $\sigma^\sharp(\kappa)$, with $\kappa$ free. When
control returns to the guard, it checks one thing:

$$
\mathit{body}(\sigma^\sharp(\kappa)) \;\equiv_{\Pi,\Phi}\; \sigma^\sharp(\kappa)[\kappa{+}1/\kappa] \;=\; \sigma^\sharp(\kappa{+}1)
\tag{IND}
$$

Every access in the body was proved for an arbitrary $\kappa \ge N$. The first $N$
iterations were checked concretely. By induction on $\kappa$, every access in every
iteration is safe. After the loop exits, $\kappa$ is no longer arbitrary: the leaving
condition pins it to the iteration where the loop left.

### 6.2 Trigger (`evaluate_branch_condition`, `repeats_unboundedly`)

Acceleration is attempted at a branch $pc$, given the most recent earlier record
$h = (pc, c_h, \sigma_h, b) \in H$, when one of these holds:

- $\mathsf{decide}_\Gamma(c) = \mathsf{explore}$; or
- $\mathsf{decide}_\Gamma(c) = \mathsf{take}\ b$ for the 3rd consecutive time with a
  *changing* guard ($c \neq c_h$) and no bounded guard (a decided but progressing loop);
  or
- unrolling has exceeded the cost budget (`costly_concrete_latch`,
  `unrolling_costs_too_much`).

It is declined in these cases:

- The branch is internal to a loop body: its other side cannot leave the cycle.
- The branch lies on the cycle of a loop that is already open.
- The loop has failed 3 times (`MAX_SUMMARY_TRIES`).
- The summary would widen a register that carries a region to $\top$.

### 6.3 The invariant lattice (`LoopInvariant`)

Each state component $i$ gets a description $\iota_i$:

$$
\iota ::= \mathsf{Fix} \mid \mathsf{Lin}(\delta) \mid \mathsf{AtMost}(k) \mid \mathsf{Within}(k) \mid \mathsf{Tracks}(j, k) \mid \mathsf{NonDec} \mid \mathsf{NonInc} \mid \top
$$

Here $\delta$ is a term (usually a literal) and $k \ge 0$. The order is `subsumes`:
$\top$ is above everything, and

$$
\mathsf{Fix} \sqsubseteq \mathsf{Within}(k) \qquad
\mathsf{Within}(k) \sqsubseteq \mathsf{Within}(k') \iff k \le k' \qquad
\mathsf{Lin}(m) \sqsubseteq \mathsf{AtMost}(k) \iff 0 \le m \le k \qquad
\mathsf{Lin}(m) \sqsubseteq \mathsf{NonDec} \iff m \ge 0
$$

(and dually for $\mathsf{NonInc}$), with $\mathsf{Fix}$ treated as $\mathsf{Lin}(0)$.
The **join** used between retries is flat: $\iota \sqcup \iota = \iota$, and anything
else joins to $\top$. Each component can therefore ascend at most once, so retries
terminate after at most $|\mathsf{Reg}|$ rounds (`max_ascents`).

**Observation** (`invariant_of_register`). Comparing the state at record $h$ with the
current state, under the assumption that the loop continues, and with selects resolved:

$$
\mathsf{obs}(v, v') =
\begin{cases}
\mathsf{Fix} & v = v'\\
\mathsf{Lin}(m - n) & v = \langle e\rangle{+}n,\ v' = \langle e\rangle{+}m\\
\mathsf{Lin}(d) & v = \langle e\rangle{+}n,\ v' = \langle e'\rangle{+}n,\ e' \text{ is } e \boxplus d \text{ up to context}\ (\texttt{symbolic\_step})\\
\top & \text{otherwise}
\end{cases}
$$

**Refinement** ($\mathsf{refine}_\Pi$: `pin_steps`, `pin_unknown_steps`, `bound_values`,
`step_past_inner_loops`, `settle_select_steps`) replaces $\top$ with something sharper
when the solver can justify it:

- $\mathsf{Lin}(k)$ when $\Pi$ pins the step to $k$;
- $\mathsf{AtMost}(k)$ when the step ranges over values in $[0, k]$;
- $\mathsf{Within}(k)$ when the value itself lies in $[0, k]$;
- $\mathsf{Tracks}(j, k)$ when component $i$ moves $k$ times as far as component $j$.

Each refinement depends on solver results, so each is a point the soundness argument
must cover (§7).

### 6.4 The summary as a λ-term (`summarize`, `stepped_by_the_counter`)

Let $\sigma_c$ be the current state at the guard. Each register is abstracted by its
invariant. The symbols $p_i$, $w_i$ and $\alpha_i$ are fresh per summary; they do not
depend on $\kappa$:

$$
\rho^\sharp(\kappa)(i) =
\begin{cases}
\rho_c(i) & \iota_i = \mathsf{Fix}\\
(\lfloor\rho_c(i)\rfloor - N\delta) + \kappa\cdot\delta & \iota_i = \mathsf{Lin}(\delta)\\
\lfloor\rho_c(i)\rfloor + p_i & \iota_i = \mathsf{AtMost}(k)\\
w_i & \iota_i = \mathsf{Within}(k)\\
\lfloor\rho_c(i)\rfloor \pm p_i & \iota_i \in \{\mathsf{NonDec}, \mathsf{NonInc}\}\\
\lfloor\rho_c(i)\rfloor + k\,(\lfloor\rho^\sharp(\kappa)(j)\rfloor - \lfloor\rho_c(j)\rfloor) & \iota_i = \mathsf{Tracks}(j, k)\\
\nu\alpha_i.\ \alpha_i & \iota_i = \top
\end{cases}
$$

When $\delta$ is a literal and the register is based, the $\mathsf{Lin}$ case keeps the
split: $\langle e \boxplus \kappa\delta\rangle{+}(n - N\delta)$. That is how a pointer
keeps its region. A narrowed (`w`) register is re-narrowed with $\%\,2^{32}$.

Memory cells written during the observed iteration (read from $J$ by `cells_written`)
are abstracted the same way, restricted to $\mathsf{Fix}$, $\mathsf{Lin}(k)$ for literal
$k$, and $\top$. A flag becomes its comparison with the abstracted registers substituted
in, or a fresh flag if that is not expressible (`flag_at_summary`, `widen_flag`).

**Facts.** $\Phi(\kappa)$ is a conjunction of four groups:

$$
\Phi(\kappa) = (\kappa \ge N)\ \wedge\ \Phi_{\text{prog}}\ \wedge\ \Phi_{\text{trip}}(\kappa)\ \wedge\ \mathit{stay}(c)[\rho^\sharp(\kappa)]
$$

- $\Phi_{\text{prog}}$: $0 \le p_i \le k(\kappa - N)$ for $\mathsf{AtMost}$, $0 \le w_i \le k$
  for $\mathsf{Within}$, and $p_i \ge 0$ for the monotone cases.
- $\mathit{stay}(c)$ is $c$ if $b$ (the loop continues when the branch is taken), else
  $\neg c$. The guard therefore holds at the summary state.
- $\Phi_{\text{trip}}$ (`trip_of`, `trip_facts`, `facts_for_exit`) applies when the guard
  is $e_x \bowtie e_w$ with $e_x$ fixed and $e_w$ stepping by a nonzero $s$. Let
  $D = \overline{e_x} - \overline{e_w}$, where the overline rewinds each operand $N$
  steps to its value at loop entry (`anchored`). Write $\trianglelefteq$ for $\le$ when
  $s > 0$ and $\ge$ when $s < 0$, and $\triangleleft$ for the strict version. A fresh
  total $T$ (`loopN_?_trips`) satisfies:

  $$
  \begin{array}{ll}
  \text{ordered } \bowtie, \text{ continues at equality:} & T s \trianglelefteq D \;\wedge\; D \triangleleft (T{+}1)s\\
  \text{ordered } \bowtie, \text{ stops at equality:} & D \trianglelefteq T s \;\wedge\; (T{-}1)s \triangleleft D\\
  \bowtie\ \in \{=, \neq\}: & D = T s
  \end{array}
  \qquad\text{and}\qquad (\kappa + \epsilon)\,s \trianglelefteq T s
  $$

  with $\epsilon \in \{0, 1\}$ by the same case split. Every other exit of the cycle
  contributes facts of the same shape, over its own total $T_{pc'}$.

Trip facts are linear, and division appears only in the closed-counter window (§6.5).
This follows from the memory notes "z3 BV conversions stall" and "nonlinear checks flip
under parallel tests".

**Ghosts** (`ghost_operands`). A guard operand that no register holds at the guard, for
example one recomputed into a scratch register every iteration, gets a *ghost*: a
predicted value at $\kappa$ and at $\kappa{+}1$. The ghost is substituted into
$\mathit{stay}(c)$, and its $\kappa{+}1$ prediction becomes an additional premise of
(IND).

### 6.5 The loop rules

**Opening a loop** (`try_summarize`):

$$
\frac{\begin{array}{c}
\mathsf{trigger}_\Gamma(pc, c) \qquad h = (pc, c_h, \sigma_h, b) \in H \qquad
\iota = \mathsf{refine}_\Pi\big(\mathsf{obs}(\sigma_h, \sigma_c)\big) \sqcup \iota_{\text{prev}}\\
\iota \ne \iota_{\text{prev}} \qquad \forall i.\ \iota_i = \top \Rightarrow \neg\mathsf{region}(\rho_c(i)) \qquad
\mathsf{sat}(\Pi \oplus^{S} \Phi(\kappa)) \qquad
\Gamma[\Pi \oplus^S \Phi(\kappa),\ \mathcal{A} \cdot L] \vdash \langle \mathit{tgt}(b), \sigma^\sharp(\kappa)\rangle \Downarrow r
\end{array}}
{\Gamma \vdash \langle pc, \sigma_c\rangle \Downarrow r}\ \textsc{(Acc-Open)}
$$

- $\oplus^S$ pushes a new named scope $S$.
- $L = (pc, b, \iota, \sigma^\sharp(\kappa), \sigma_c, \Phi, S, |H|, |J|)$ is the open
  loop (`ActiveLoop`).
- $\iota_{\text{prev}}$ is absent on the first attempt. If the join reaches a fixpoint
  without closing, the rule does not apply.
- If $\Pi \oplus \Phi$ is unsat, the summary contradicts the path. This counts as a
  failure, and the loop is unrolled instead.

**Closing a loop** (`discharge_active_loop`). Control reaches $pc$ again with $L$ on top
of $\mathcal{A}$ and current state $\sigma_1$. Write $\rho^\sharp$ for $\rho^\sharp(\kappa)$
and $\iota^1_i = \mathsf{refine}_\Pi(\mathsf{obs}(\rho^\sharp(i), \rho_1(i)))$. The
inductive check is

$$
\mathsf{IND}(L, \sigma_1) \;\triangleq\;
\bigwedge_i \Big(\iota^1_i \sqsubseteq \iota_i \;\vee\; \Pi \vDash \lfloor\rho_1(i)\rfloor = \lfloor\rho^\sharp(i)\rfloor + \delta_i\Big)
\;\wedge\; \mathsf{cells}\ \wedge\ \mathsf{ghosts}\ \wedge\ \mathsf{settled}
$$

The four conjuncts:

- **Registers.** The second disjunct is `proves_step`.
- **cells.** Every cell rewritten since the summary, and every summarized cell, repeats
  its recorded step. No blind stack write may reach a summarized stack cell
  (`stack_cells_a_blind_write_may_reach`).
- **ghosts.** $\Pi \vDash$ each ghost operand equals its $\kappa{+}1$ prediction.
- **settled.** Settled select steps repeat (`settled_steps_repeat`).

For $\mathsf{Lin}$ components this is (IND) from §6.1, by the substitution identity

$$
\big((v_0 - N\delta) + \kappa\delta\big)[\kappa{+}1/\kappa] = \big((v_0 - N\delta) + \kappa\delta\big) + \delta .
$$

The closing rule:

$$
\frac{\mathsf{IND}(L, \sigma_1) \qquad
      \Gamma[\Pi \ominus S \oplus \Phi(\kappa) \oplus \Phi_{\text{exit}} \oplus \neg\mathit{stay}(c),\ \mathcal{A}] \vdash \langle \mathit{tgt}(\neg b), \sigma_1\rangle \Downarrow r}
     {\Gamma[\mathcal{A}\cdot L] \vdash \langle pc, \sigma_1\rangle \Downarrow r}\ \textsc{(Acc-Close)}
$$

**What changes at the exit.** $\ominus S$ pops the loop's scope. Scopes opened inside
the body sit above $S$, so they are rebuilt afterwards (`scopes_above`,
`rebuild_scopes`). The facts $\Phi$ are then re-asserted *outside* the loop's scope,
together with the leaving condition. From here on, $\kappa$ is the exit iteration:
inside the body it was arbitrary, and at the exit it is pinned. If the guard is affine
in $\kappa$, the possible exit values of $\kappa$ (a window of at most 8, from
`exit_window`) are stored in `closed_counters` for later bounds. If the path is unsat
after closing, it ends (**Br-Dead**).

Loop closure does not require proving that the loop terminates. Safety needs every
iteration's accesses, not an exit, and requiring termination forced unrolling (see the
TODO in `discharge_active_loop`).

**Force-closing** (`only_data_moved`, `force_close`). If $\mathsf{IND}$ fails only on
components $U$ with no region in their entry, summary or current value, and none read by
the guard, the loop still closes. Each register in $U$ is widened to a fresh symbol:

$$
\frac{\neg\mathsf{IND}(L, \sigma_1) \qquad \mathsf{IND}\text{ holds outside } U \qquad \forall i \in U.\ \neg\mathsf{region}(\cdot) \wedge i \notin \mathrm{fv}(c) \qquad
      \cdots \vdash \langle \mathit{tgt}(\neg b), \sigma_1[\rho(i) \mapsto \nu\alpha_i]_{i \in U}\rangle \Downarrow r}
     {\Gamma[\mathcal{A}\cdot L] \vdash \langle pc, \sigma_1\rangle \Downarrow r}\ \textsc{(Acc-Force)}
$$

**Retrying or giving up.** If neither closing rule applies, the engine:

1. pops $S$;
2. restores $\sigma_c$, the state before summarizing;
3. undoes $J$ back to $|J|$ (`undo_writes_since`) and truncates $H$;
4. records the components that broke, as `unstable_registers` and `unstable_cells`.

It then re-enters **(Acc-Open)** with $\iota_{\text{prev}} := \iota \sqcup \iota^1$.
After 3 failures the loop is unrolled through **(Br-Take)** and **(Br-Fork)**.

**Leaving through another exit** (`left_through`, `repeat_round`). If the body leaves
through a different exit of the cycle before it returns to $pc$, $L$ is dropped. Its
scope is released, and a new round starts from that exit. The prefix of branch decisions
after that exit is replayed.

**Abandoning.** If a path started at the depth that opened $L$ ends without returning to
$pc$, the epilogue of `run` pops $S$. Every push therefore has exactly one pop.

**Memory-free loops** (`memory_free_loop`, `havoc_memory_free_loop`). Consider a natural
loop $[pc, \mathit{end}]$ made only of register-to-register instructions, with no loads
or stores (`register_destination` rejects everything else), that has at least 2
conditional branches and writes no register carrying a region. Its written registers and all four flags are havocked to fresh symbols
(`set_unknown_flags`), and each static exit is explored once:

$$
\frac{W = \mathrm{written}(P[pc..\mathit{end}]) \qquad \forall x \in W.\ \neg\mathsf{region}(\rho(x)) \qquad
      \forall t \in \mathrm{exits}.\ \mathsf{fork}(\Gamma) \vdash \langle t, \sigma[\rho(x) \mapsto \nu\alpha_x]_{x \in W}[\varphi \mapsto \nu]\rangle \Downarrow r_t}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow \textstyle\bigotimes_t r_t}\ \textsc{(Havoc)}
$$

---

## 7. Soundness: statement and obligations

**Concretization.** A valuation $\theta : \mathsf{Sym} \to \mathbb{Z}$ and a concrete
machine state $s$ are *described* by $(\Gamma, \sigma)$, written
$(\theta, s) \models (\Gamma, \sigma)$, when all of the following hold:

- $\theta \models \Pi \wedge \Delta$;
- for every register $r$ with $\rho(r) \neq \top$,
  $s(r) = \theta([\![\lfloor \rho(r) \rfloor]\!]) \bmod 2^{64}$;
- every written cell matches the same way;
- each region $R$ lies at $\theta(R)$ with length $\theta([\![\ell_R]\!])$.

**Theorem (intended).** Suppose $\Gamma_0 \vdash \langle \mathit{entry}, \sigma_0\rangle \Downarrow \mathsf{ok}$,
where $\Gamma_0$ holds the declared regions and preconditions. Then for every
$(\theta, s_0) \models (\Gamma_0, \sigma_0)$, every load or store in the concrete AArch64
execution from $s_0$ touches only bytes inside a declared region of a compatible kind.

**Proof shape.** Induction on the derivation, maintaining $(\theta, s) \models (\Gamma, \sigma)$
for some extension of $\theta$:

| Rule | Obligation | Status |
|---|---|---|
| §2.2, §2.3 | Value operations and $[\![\cdot]\!]$ agree with machine arithmetic | **Only modulo wrap.** $[\![\cdot]\!]$ is over $\mathbb{Z}$, and literals fold with saturation. An access reached through 64-bit overflow is not modelled (open TODO). |
| $\mathsf{opaque}$, $\top$ | Over-approximation: any concrete value extends $\theta$ | Holds: both are unconstrained symbols. |
| **(Br-\*)**, **(Split)** | Every concrete successor is covered | Holds: an arm is pruned only on `Unsat`. **(Split)** covers all values because the enumeration ran to `Unsat`. |
| **(Merge)**, selects | $\Delta$ is exact | Holds by construction. |
| **(Safe)** | Both bound queries unsat, and the path is feasible | Holds. The stack frame $\pm\ell_R$ around `sp` is a convention for the precondition, not a property proved. |
| **(Acc-Open)** | $\Phi(\kappa)$ holds for every real iteration $\kappa \ge N$ | Holds for trip facts and progress facts because $T$, $p_i$ and $w_i$ are fresh, so the facts *define* them. Each $\mathsf{refine}_\Pi$ step must be backed by a proof, not a model: see the memory note "no solver guessing without approval". |
| **(Acc-Close)** | Induction: the base case is $N$ explored iterations, the step is $\mathsf{IND}$ | Holds for the components $\mathsf{IND}$ inspects. Cells and stack writes are covered by the journal and the blind-write check. |
| **(Acc-Force)** | Widening $U$ after the body ran with the *claimed* values of $U$ | **Open.** The body's accesses were proved under $\rho^\sharp(i)$ for $i \in U$, and those values have just been shown not to be inductive. `carries_region` excludes pointers but not *indices*. A data register in $U$ used as an offset (`ldr x, [R, xi]`) would make this rule unsound. A sufficient side condition: no $\alpha \in \mathrm{fv}(\rho^\sharp(i))$, for $i \in U$, occurs in any safety query discharged inside the body. |
| **(Havoc)** | Fresh symbols over-approximate any number of iterations | Holds: the body has no memory access to check, and every register it writes is havocked, as are all four flags. |

---

## 8. Code map

| Calculus | Code |
|---|---|
| $e$, $c$, $v$, $f$, $R$ | `common.rs`: `AbstractExpression`, `AbstractComparison`, `RegisterValue`, `FlagValue`, `MemorySafeRegion` |
| $\boxplus$ | `common::generate_expression` |
| $[\![\cdot]\!]$, $\Delta^\ast$ | `common::expression_to_ast`, `comparison_to_ast`; `computer/memory.rs::select_assumptions`; `engine::select_definitions_in` |
| $\sigma \vdash \iota \Rightarrow \sigma';k$ | `computer/instructions.rs::execute`, `computer/instruction_aux.rs::{arithmetic_value, cmp, carry_select}` |
| $\mathsf{safe}$ | `computer/memory.rs::{mem_safe_access, safe_for_every_stride, aligned_offset, aligned_parts}` |
| $\Downarrow$ | `engine::{run, run_from, step}` |
| $\mathsf{decide}$, **(Br-\*)** | `engine::{decide_from_solver, evaluate_branch_condition, take_conditional_branch}` |
| **(Split)**, **(Merge)**, selects | `engine::{concrete_split, split_on, merge_branch_arms, take_select}` |
| $\mathsf{fork}$, $\oplus^S$, $\ominus S$ | `engine::{fork, push_scope, pop_scope, scopes_above, rebuild_scopes}` |
| $\iota$, $\sqcup$, $\mathsf{obs}$ | `widening.rs::{LoopInvariant, join_all, invariant_of_register, symbolic_step}` |
| $\sigma^\sharp$, $\Phi$ | `engine::{summarize, stepped_by_the_counter, trip_facts, facts_for_exit, anchored}`, `widening::advance` |
| **(Acc-Open)** | `engine::try_summarize` |
| **(Acc-Close)**, **(Acc-Force)** | `engine::discharge_active_loop` |
| **(Havoc)** | `engine::{memory_free_loop, havoc_memory_free_loop}` |
