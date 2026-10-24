# A core calculus for the bums symbolic executor

This note writes the checker's transformations as a small calculus in λ-calculus style:
a term language, a few judgments, and inference rules. It describes the engine at commit
`f2f881a5` (branch `unify`). Rules name the function that implements them, so they can be
checked against the code. Where the code goes beyond a rule, or falls short of it, the text
says so.

The engine is generic over a machine model (`Machine`, `src/machine.rs`). Two models
exist: AArch64 (`ARMCORTEXA`, `src/computer.rs`, `src/computer/*`) and x86-64 (`X86_64`,
`src/x86/**`). Everything above the transfer layer (§3) is shared; where the models differ
the text says which one a rule describes. Unqualified examples are AArch64.

The calculus has four layers, each built on the one before:

1. **Terms.** A first-order term language with a normalising constructor (§1–§2).
2. **Transfer.** One instruction maps an abstract state to a new state and a
   *continuation* (§3).
3. **Exploration.** A big-step judgment runs continuations against a path condition,
   forking, splitting, merging or pruning at branches (§4–§5).
4. **Acceleration.** A loop is closed by abstracting the state over a counter, giving a
   λκ-term, and checking that one more iteration is the same term at κ+1 (§6).

§7 states the soundness theorem the rules are meant to support, the obligations the
implementation does not yet discharge, and the pieces that are trusted rather than proved.

---

## 0. Notation

| Symbol | Meaning |
|---|---|
| $\alpha, \beta$ | symbols (z3 integer constants): `x0`, region names, `loop3_?`, `select_12`, `unknown_value_7`, … |
| $n, m, k, \delta$ | 64-bit integer literals |
| $\nu\alpha.\,t$ | $t$ with $\alpha$ a fresh symbol (`fresh_unknown`, `fresh_symbol`, `{loop}_widened_i`, …) |
| $t[e/\alpha]$ | capture-free substitution |
| $\Pi$ | path condition, a stack of scopes of formulas |
| $\Pi \vDash \psi$ | $\Pi \wedge \neg\psi$ is unsat |
| $\mathsf{sat}(\Pi)$ | $\Pi$ has a model |

Every query is made under assumptions: the solver never sees $\neg\psi$ asserted
permanently. "unsat" always means z3 returned `Unsat`. `Unknown` is never treated as
`Unsat` except in the one place noted in §4.1.

**Escalation** (`common::check`). Most path queries go through `check`: the path solver
first runs with a resource limit; on `Unknown` the assertions and assumptions are copied
into fresh solvers that alternate z3's two arithmetic engines under growing limits
(`ESCALATION`), and only then is the path solver asked again without a resource limit.
Every step also has a wall clock (z3's `timeout`): each escalation step its own, and the
whole query at most `BUMS_CHECK_TIMEOUT_SECS` (600 s by default), so a step that ignores
its resource limit returns `Unknown` (`check_within`). Escalation changes how often
`Unknown` comes back, never what `Sat`/`Unsat` mean.

---

## 1. Syntax

### 1.1 Terms and comparisons (`AbstractExpression`, `AbstractComparison`)

$$
\begin{array}{rcll}
e & ::= & n & \text{literal (Immediate)}\\
  & \mid & \alpha & \text{symbol (Abstract)}\\
  & \mid & \varepsilon & \text{Empty, read as } 0\\
  & \mid & e \oplus e & \oplus \in \{+,-,*,/,\%,\&,|,\hat{\ },\mathsf{lsl},\mathsf{lsr},\mathsf{asr},\mathsf{umulh},\mathsf{zext},\mathsf{sext},\mathsf{clz},\mathsf{atleast},\mathsf{atmost},\ldots\}\\
  & \mid & \lceil v \rceil & \text{a boxed register value (only inside comparisons)}\\[4pt]
c & ::= & e \bowtie e & \bowtie\ \in \{<,\le,>,\ge,=,\neq\}
\end{array}
$$

Negation is syntactic: $\neg(e_1 < e_2) = (e_1 \ge e_2)$, and so on (`AbstractComparison::not`).
$\mathsf{atleast}$/$\mathsf{atmost}$ are max/min; a load narrower than 8 bytes is
*confined*, $\mathsf{conf}_w(\alpha) = \mathsf{atmost}(\mathsf{atleast}(\alpha, 0), 2^{8w}{-}1)$
(`confined_load`).

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

### 1.4 Memory (`MemorySafeRegion`, `loader.rs`)

A region is $R = \langle \kappa_R, \ell_R, a_R, \mathit{cells}_R, W_R, \epsilon_R\rangle$:

- $\kappa_R \in \{\mathsf{R}, \mathsf{W}, \mathsf{RW}\}$ is its kind.
- $\ell_R$ is its length in bytes, a term such as `len * 8`.
- $a_R$ is its alignment; for $a_R > 1$ the solver holds $R \bmod a_R = 0$.
- $\mathit{cells}_R : \mathbb{Z} \rightharpoonup v \times w$ is sparse: a cell at offset $n$
  holds a value of width $w$ (`content`, `widths`).
- $W_R$ is the list of byte intervals ever written (`written`).
- $\epsilon_R \in \mathbb{N}$ is its *epoch* (`epoch`), bumped whenever a write may have
  touched cells the engine cannot name (`renew_unwritten`, `clobber`).

The memory $\mu$ maps region names to regions. A region name is also a symbol: the
symbol `R` denotes the region's base address. The stack is the region `sp`, of kind
$\mathsf{RW}$ and length `MAX` with $\mathtt{MAX} \ge 2^{63}{-}1$; its bounds are checked
specially (§5.2).

**Sections** (`Listing::parse`, `lay_out`). The loader splits a listing into code and data
sections. Code is laid out from address 0, 4 bytes per instruction; data sections follow
on the next page, each 16-byte aligned. Every data section becomes a region of its own,
$\mathsf{RW}$ for `.data`/`.bss`/`__DATA`, otherwise $\mathsf{R}$ (so `.rodata`,
`.const`, and bytes emitted among code, which go to `.text.data[.n]`). A data label is a
pair (section, offset) in $\lambda_\mu$ (`memory_labels`); items become cells: literals,
label differences, and pointers $\langle S\rangle{+}n$ to another symbol. One **address
map** (`addresses`, `line_at`) relates labels and data symbols to addresses and addresses
to code lines; indirect branches use it (§3). Bytes in a code section that control may
fall into are not data: each 4-byte unit becomes the instruction `bums.encoded_unknown`,
which fails when executed (x86 first decodes the `.byte` sequences it understands).

**Slots** (`SymbolicSlot`). A store through a compound address $\langle e\rangle{+}n$
(not a bare region symbol) has no cell. Its value is remembered as a slot
$(e, n, w, v)$ and read back only by a load of the same $(e, n, w)$ (`remember_slot`,
`recall_slot`).

### 1.5 States and contexts

$$
\sigma = (\rho,\ \varphi,\ \mu,\ \varsigma) \qquad \varphi : \{Z,N,C,V\} \to f
$$

$\rho$ maps the model's registers to values: on AArch64 $x_0..x_{30}$, `sp`, `xzr`, plus
32 vector registers with lane ranges; on x86-64 the 16 general registers, vector and
mask registers. $\varsigma$ is the list of slots. `MachineState` is $(\rho, \varphi)$; the
rest lives in the machine.

The *path context* $\Gamma$ carries everything that is not machine state:

$$
\Gamma = (\Pi,\ \Delta,\ H,\ J,\ \mathcal{A},\ \mathcal{C},\ \mathcal{L})
$$

| Component | Code | Contents |
|---|---|---|
| $\Pi$ | `solver` + `scopes` | a stack of named scopes of asserted formulas |
| $\Delta$ | `select_definitions` | $\alpha \mapsto (c, e_t, e_f)$: $\alpha$ is $e_t$ if $c$, else $e_f$ |
| $H$ | `jump_history` | branch records $h = (pc, c, \sigma, |J|, \varsigma, \mathit{taken}, \mathit{resolved})$ |
| $J$ | `write_journal` | cell writes $(R, n, v_{\text{old}})$, read by loop analysis |
| $\mathcal{A}$ | `loops.active` | open loop summaries awaiting their inductive check (§6.5) |
| $\mathcal{C}$ | `loops.closed_counters` | counters of closed loops with their possible exit values (§6.5) |
| $\mathcal{L}$ | `ledger`, `loops.relied_on` | summary instances this path relies on, and recorded refutations (§6.6) |

A configuration is $\Gamma \vdash \langle pc, \sigma\rangle$.

---

## 2. The term algebra

### 2.1 Normalising constructor (`generate_expression`)

Terms are only ever built through $\boxplus_\oplus$, never with the raw node. It undoes
an immediately inverted step ($(x + t) - t = x$, $(x - t) + t = x$,
$(x \mathbin{\mathsf{lsl}} k) \mathbin{\mathsf{asr}} k = x$ when $x$ is a literal, a
$\mathsf{sext}$ or $\mathsf{zext}$, or a low-bit mask that fits in $64-k$ signed bits). For $\oplus \in \{+,-\}$ it
flattens both sides into a signed list of atoms and a constant, cancels opposite equal
atoms, and folds literals:

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
is one, which §6.3 depends on. Linear reasoning that must not depend on spelling uses
`Affine::of` / `linear_form` (`widening.rs`), which read a term as a sum of atoms with
integer coefficients.

### 2.2 Operations on values (`arithmetic_value`)

Only $+$ and $-$ distribute over the base/offset split. Write $\hat\oplus$ for the
64-bit wrapping literal operation:

$$
\begin{array}{lcl}
\underline{n} \oplus \underline{m} &=& \underline{n \mathbin{\hat\oplus} m}\\
\langle e\rangle{+}n \pm \underline{m} &=& \langle e\rangle{+}(n \mathbin{\hat\pm} m)\\
\underline{n} \pm \langle e\rangle{+}m &=& \langle \pm e\rangle{+}(n \mathbin{\hat\pm} m)\\
\langle e_1\rangle{+}n \pm \langle e_2\rangle{+}m &=& \langle e_1 \boxplus_\pm e_2\rangle{+}(n \mathbin{\hat\pm} m)\\
\top \oplus v \;=\; v \oplus \top &=& \top\\
v_1 \oplus v_2 &=& \langle \mathsf{cap}(\lfloor v_1\rfloor \boxplus_\oplus \lfloor v_2\rfloor)\rangle{+}0 \qquad (\oplus \notin\{+,-\},\ \text{either based})
\end{array}
$$

$\underline{n} - \langle e\rangle{+}m$ negates the base (`carried_base`).
$\mathsf{cap}(t)$ (`capped`) replaces a term of more than 150 nodes that names no region
by a fresh symbol.

Writing a `w` register narrows (`narrow_to_32`):
$\underline{n} \mapsto \underline{n \bmod 2^{32}}$ and
$\langle e\rangle{+}n \mapsto \langle (e \boxplus n) \,\%\, 2^{32}\rangle{+}0$.

### 2.3 Interpretation into the solver (`expression_to_ast`, `comparison_to_ast`)

$[\![\cdot]\!] : e \rightharpoonup \mathsf{Int}$ maps terms to z3 **mathematical integers**.
It is partial: a term it cannot carry yields `None`, and such a term is *inexpressible*.

$$
\begin{array}{lcl}
[\![n]\!] = n \quad [\![\alpha]\!] = \alpha \quad [\![\varepsilon]\!] = 0 &&
[\![\lceil \langle e\rangle{+}n\rceil]\!] = [\![e]\!] + n \quad [\![\lceil \top \rceil]\!] = \nu\alpha.\,\alpha\\[2pt]
[\![e_1 \circ e_2]\!] = [\![e_1]\!] \circ [\![e_2]\!] && \circ \in \{+,-,*,\mathsf{div},\bmod\}\\
[\![e \;\mathsf{lsl}\; k]\!] = [\![e]\!]\cdot 2^{k} && [\![e \;\mathsf{lsr}\; k]\!] = ([\![e]\!] \bmod 2^{64}) \mathbin{\mathsf{div}} 2^{k}\\
[\![e \;\mathsf{asr}\; k]\!] = [\![\mathsf{sext}_{64}\,e]\!] \mathbin{\mathsf{div}} 2^{k} && [\![\mathsf{zext}_w\,e]\!],\ [\![\mathsf{sext}_w\,e]\!],\ [\![\mathsf{clz}_w\,e]\!] \text{ exact for } w \le 64\\
[\![e \,\&\, (2^k{-}1)]\!] = [\![e]\!] \bmod 2^k && [\![e \,\&\, {-2^k}]\!] = [\![e]\!] - ([\![e]\!] \bmod 2^k)\\
[\![e \,\&\, 2^k]\!] = \mathsf{bit}_k([\![e]\!]) && [\![e \,\&\, {\sim}2^k]\!] = [\![e]\!] - \mathsf{bit}_k([\![e]\!]) \quad(\text{also runs of bits})\\
[\![e \;\hat{}\; e]\!] = 0 \quad [\![e \;\hat{}\; {-1}]\!] = -1 - [\![e]\!] && [\![e_1 \mid e_2]\!] = [\![e_1]\!] + [\![e_2]\!] \quad (\text{bits provably disjoint})\\
[\![e \;\hat{}\; m]\!] = \text{bitwise flip of the bits of literal } m && [\![e \;\hat{}\; e']\!] \text{ otherwise: inexpressible}\\
[\![e_1 \,\&\, e_2]\!],\ [\![e_1 \mid e_2]\!],\ [\![e_1 \oplus e_2]\!] = \mathsf{opaque}_{e} && \text{otherwise}
\end{array}
$$

$\mathsf{opaque}_e$ is an uninterpreted constant *named by $e$*. Two syntactically equal
opaque terms are therefore equal, and nothing else is known about them. Opaque terms and
fresh symbols are the calculus's over-approximation; every other rule is exact over
$\mathbb{Z}$, except that $\mathsf{sext}_{64}$ under $\mathsf{asr}$ is exact only on
$[-2^{63}, 2^{64})$: past it, the word is $\mathsf{opaque}_e$ when that lies in
$[-2^{63}, 2^{63})$ and $0$ otherwise, since a reduction modulo $2^{64}$ there left later
queries on the path undecided.

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

`Machine::execute` is a function from a state and an instruction to a new state and a
continuation (`ExecuteReturnType`), or an error:

$$
k ::= \mathsf{next} \mid \mathsf{jmp}\ \ell \mid \mathsf{jmp@}\ a \mid \mathsf{jmp?}\ c\ \ell \mid \mathsf{sel}\ c\ r\ v_t\ v_f \mid \mathsf{split}\ [c_1,\ldots,c_j] \mid \mathsf{jmpind}\ v \mid \mathsf{trap} \mid \mathsf{fail}\ m
$$

$\mathsf{jmp}\ \mathtt{return}$ ends the path, which then checks that `sp` is restored.

Representative rules:

**Arithmetic.** $\sigma \vdash \mathtt{add}\ r, a, b \Rightarrow \sigma[\rho(r) \mapsto \rho(a) + \rho(b)];\ \mathsf{next}$,
using §2.2.

**Compare** (`cmp_values_sized`) sets all four flags. With $b$ the operand width,
$d = \lceil v_1\rceil - \lceil v_2\rceil$:

$$
\mathsf{cmp}(v_1, v_2) =
\begin{cases}
\nu\text{-fresh flags} & v_1 = \top \text{ or } v_2 = \top\\
Z{=}\mathsf{tt},\ N{=}\mathsf{ff},\ C{=}\mathsf{tt},\ V{=}\mathsf{ff} & v_1 = v_2\\
\text{literal flags from } n, m & v_1 = \langle e\rangle{+}n,\ v_2 = \langle e\rangle{+}m, \text{ or both literal}\\
Z{=}(d = 0),\ N{=}(\mathsf{sext}_b v_1 - \mathsf{sext}_b v_2 < 0),\ C{=}(\mathsf{zext}_{64} v_1 \ge \mathsf{zext}_{64} v_2),\ V{=}(d < -2^{63}) & \text{otherwise}
\end{cases}
$$

**Conditions** (`condition`). Every AArch64 condition code is read through one model of
the flags. A single flag is returned as is (negated for the inverse code). A conjunction
(`gt`, `hi`, `ge` with $V$) becomes one comparison when the flags came from one compare
(`gt` from a signed difference, `hi` from the unsigned order), is decided when a literal
flag decides it, and is otherwise a fresh unknown flag. A flag that is $\bot$ gives
$\mathsf{fail}$. A comparison flag gives $\mathsf{jmp?}\,c\,\ell$, and a literal one
$\mathsf{jmp}$ or $\mathsf{next}$. x86-64 has its own flag model with the same three
outcomes (`x86/computer/flags.rs`).

`cbz` / `cbnz` / `tbz` test a value directly: a known literal decides, otherwise
$\mathsf{jmp?}\,(0 = \lceil v\rceil)\,\ell$ (with $\lceil v\rceil \mathbin{\&} 2^k$ for
`tbz`).

**Select.** `csel r, a, b, cond` with literal flags is an assignment. With symbolic flags
it is $\mathsf{sel}\ c\ r\ \rho(a)\ \rho(b)$. Carry-dependent arithmetic (`adc`, `sbc`)
also produces a $\mathsf{sel}$ between its two results (`carry_select`).

**Split.** A load from a data table at a symbolic index (`table_load`) first proves the
index aligned and inside the table. If several entries are feasible (at most 16), the
instruction returns $\mathsf{split}\,[\,\iota = e_1, \ldots, \iota = e_j\,]$ and is re-run
once per entry (§4). One feasible entry is read directly. x86 `tzcnt`/`bsf` split the
same way over the lowest set bit.

**Indirect jump.** `br`/`blr` return $\mathsf{jmpind}\ v$. The engine resolves it through
the address map: $v$ must be $\langle S\rangle{+}n$ with $S$ a label or data symbol whose
address plus $n$ is the address of an instruction (`resolve_indirect`); anything else is
an error. x86 has no indirect jumps except through decoded jump tables.

**Trap.** `brk`, `udf`, `hlt` (x86: `ud2`, `int3`, `hlt`) return $\mathsf{trap}$: the
path does not return, and ends with no error.

**Addressing** (`indexed_address`). For base $\rho(b)$ and immediate $n$:

| Mode | Address accessed | Writeback |
|---|---|---|
| plain `[b, #n]` | $\rho(b) + \underline{n}$ | none |
| pre-index `[b, #n]!` | $\rho(b) + \underline{n}$ | $\rho(b) + \underline{n}$ |
| post-index `[b], #n` | $\rho(b)$ | $\rho(b) + \underline{n}$ |

**Load and store** call the safety judgment (§5) first. For a bare region symbol $R$
(a label resolves to its section and offset):

$$
\frac{\Gamma \vdash \mathsf{safe}_{\mathsf R}(\langle R\rangle{+}n, w)}
     {\sigma \vdash \mathtt{ldr}\ t, \langle R\rangle{+}n \Rightarrow \sigma[\rho(t) \mapsto \mathit{read}_\mu(R, n, w)];\ \mathsf{next}}
$$

$$
\mathit{read}_\mu(R, n, w) = \begin{cases}
v & \mathit{cells}_R(n) = (v, w)\\
\langle \lfloor v \rfloor \,\%\, 2^{8w}\rangle{+}0 & \mathit{cells}_R(n) = (v, w'),\ w < w' \le 8,\ v \text{ based}\\
\underline{b} & \text{every byte covered by literal cells, assembled into } b\\
\nu\alpha.\,\mathsf{conf}_w(\alpha) & [n, n{+}w) \text{ meets } W_R\\
\langle \mathsf{conf}_w(R[n{:}w]\#\epsilon_R)\rangle{+}0 & \text{otherwise (a never-written location)}
\end{cases}
$$

A never-written location is named by region, offset, width and epoch, so two loads of
it agree, and a load after a symbolic write (which bumps $\epsilon_R$) does not reuse the
old name. Pointer-element preconditions can replace that name in a pristine region
(`element_pointer`).

$$
\frac{\Gamma \vdash \mathsf{safe}_{\mathsf W}(\langle R\rangle{+}n, w)}
     {\sigma \vdash \mathtt{str}\ t, \langle R\rangle{+}n \Rightarrow \sigma[\mathit{cells}_R(n) \mapsto (\rho(t), w)]\big[\mathit{cells}_R(n') \mapsto \bot\big]_{n' \text{ overlapping}};\ \mathsf{next}}
$$

(`store_cell`; a value wider than 8 bytes is stored as $\top$; $W_R$ grows; every change
is journaled in $J$).

**Compound addresses.** For $\langle e\rangle{+}n$ with $e$ not a bare region symbol, a
load reads a matching slot or else $\nu\alpha.\,\mathsf{conf}_w(\alpha)$ ($\top$ at 8
bytes). A store
(`forget_where_written`) forgets every cell of each region $e$ names unless the solver
proves the cell disjoint from $[e{+}n, e{+}n{+}w)$, bumps those regions' epochs, drops
the slots it may overlap (`forget_slots_overlapping`), and records a new slot. A store
whose region is `sp` is also recorded in `blind_stack_writes` (§6.5).

**Returns (AArch64).** `x30` starts as $\langle\mathtt{return}\rangle$ and `bl`/`blr` set
it to $\langle\mathtt{return\_to}\rangle{+}(pc{+}1)$. `ret` through $\langle\mathtt{return}\rangle$
ends the path, through $\langle\mathtt{return\_to}\rangle{+}n$ jumps to line $n$, and
through any other value (a literal, $\top$, a data symbol) is an error. A return through
$\langle\mathtt{return}\rangle$ ends the path only if $\Pi \vDash \mathtt{sp} = \mathtt{sp}_0$, the
entry value, however the two are spelled (`check_stack_pointer_restored`); otherwise it
is an error.

**x86-64.** `push`/`pop`/`call`/`ret` move through the modelled stack, whose cell 0 holds
the return address; `ret` through any other value is an error, and a return to the
caller must leave $\Pi \vDash \mathtt{rsp} = \mathtt{rsp}_0 + 8$. `rep` string operations
check the whole range they move (`store_range`, `load_range`).

---

## 4. Paths

### 4.1 Deciding a guard (`decide_from_solver`)

If $[\![c]\!]$ or $[\![\neg c]\!]$ is inexpressible, the guard is $\mathsf{explore}$.
Otherwise let $A = \Pi \wedge \Delta^\ast(c)$, with every query through `check`. Then

$$
\mathsf{decide}_\Gamma(c) =
\begin{cases}
\mathsf{explore} & [\![c]\!] \text{ inexpressible}\\
\mathsf{dead} & A \wedge c \text{ unsat and } A \wedge \neg c \text{ unsat}\\
\mathsf{take}\ \mathsf{tt} & A \wedge \neg c \text{ unsat}\\
\mathsf{take}\ \mathsf{ff} & A \wedge c \text{ unsat}\\
\mathsf{explore} & \text{otherwise}
\end{cases}
$$

The first case that matches wins. $\mathsf{take}\ \mathsf{tt}$ also fires when
$A \wedge c$ is `Unknown`, which is sound because only the negated side has to be unsat.

### 4.2 Forking and constraints

$\mathsf{fork}(\Gamma)$ copies $\Gamma$ and rebuilds the solver from $\Pi$, scope by scope
(`fork`). The copy shares no scope with its parent, so a fact asserted in one arm can
never leak into the other. The step budget, the explored set, summaries, failure counts,
the ledger and loop ids are shared between arms through `Rc`. They are bookkeeping, not
facts.

Assertions go into the innermost scope: $\Pi \oplus \psi$ (`assert_in_scope`). Adding a
branch constraint also adds the select definitions it mentions:

$$
\Pi \oplus_b c \;\triangleq\; \Pi \oplus \Delta^\ast(c) \oplus (b\ ?\ c : \neg c)
\qquad (\texttt{add\_constraint})
$$

An inexpressible $c$ adds nothing (a weaker $\Pi$). When the added side is an equality
that $\Pi$ then pins to $\alpha = n$, $\alpha$ is replaced by $n$ throughout $\sigma$
(`substitute_decided_symbol`).

**Monotone guard order** (`order_a_monotone_guard`). On the $\ne$ side of a guard
$w \ne b$ in an open loop's body, reached straight-line from the loop's branch, where
$w = s \pm \kappa$ walks by one per round, $b$ is the same bound in the previous round,
and $\Pi \vdash s < b$ (resp. $s > b$), $\Pi$ gains $w < b$ (resp. $w > b$). This needs
every earlier round with $w = b$ to have left the loop, so the rule applies only when the
$=$ arm cannot reach the loop's back edge without passing its header (`stays_in_loop`
on the cycle of the last unrolled round).

---

## 5. Exploration and safety

### 5.1 The exploration judgment

$\Gamma \vdash \langle pc, \sigma\rangle \Downarrow r$ with $r \in \{\mathsf{ok}\} \cup \{\mathsf{err}(M)\}$.
Results combine by $\mathsf{ok} \otimes r = r$ and
$\mathsf{err}(M_1) \otimes \mathsf{err}(M_2) = \mathsf{err}(M_1 \cup M_2)$
(`join_arms`). Branch recursion is bounded by depth 32, and all paths share one budget
of 200 000 steps (`BUMS_MAX_BRANCH_DEPTH`, `BUMS_MAX_STEPS`); exceeding either is an
error.

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
\qquad
\frac{\sigma \vdash P[pc] \Rightarrow \sigma';\ \mathsf{trap}}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow \mathsf{ok}}\ \textsc{(Trap)}
$$

**(Jmp)** covers $\mathsf{jmp@}$ and $\mathsf{jmpind}$ after resolution. Without
`fail_fast`, **(Fail)** logs the error and continues at $pc{+}1$. Unconditional jumps to
one target are capped at 1000 per path, and a branch revisited too often without being
summarized is an error (`check_not_stuck`), so a stuck loop is reported rather than
diverging. A path whose next instruction lies past the end of the listing is an error
(`runs_past_the_end`): only a return or a trap ends a path. A call suspends the open loops until the matching return
(`suspend_for_call`, `resume_suspended`).

**Branches.** Let $\sigma \vdash P[pc] \Rightarrow \sigma;\ \mathsf{jmp?}\ c\ \ell$,
and write $\mathit{tgt}(\mathsf{tt}) = \ell$ and $\mathit{tgt}(\mathsf{ff}) = pc{+}1$.
Each rule pushes a record $h = (pc, c, \sigma, b)$ onto $H$ (`follow_branch`,
`explore_arm`). Loop acceleration (§6) runs inside $\mathsf{decide}$
(`evaluate_branch_condition`, `decide`); the rules below apply when it does not.

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
until the solver says `Unsat` (`finite_values`; `Unknown` gives no split):

$$
\frac{\mathcal{A} = \emptyset \qquad \mathsf{vals}_\Pi(\alpha) = \{n_1,\ldots,n_j\},\ 2 \le j \le 4 \qquad
      \forall i.\ \mathsf{fork}(\Gamma)[\Pi \oplus (\alpha = n_i)] \vdash \langle pc, \sigma[n_i/\alpha]\rangle \Downarrow r_i}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow \textstyle\bigotimes_i r_i}\ \textsc{(Split)}
$$

**Case split** (`split_cases`). For $\sigma \vdash P[pc] \Rightarrow \sigma;\ \mathsf{split}\,[c_i]$:

$$
\frac{\forall i.\ \mathsf{fork}(\Gamma)[\Pi \oplus_{\mathsf{tt}} c_i] \vdash \langle pc, \sigma\rangle \Downarrow r_i}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow \textstyle\bigotimes_i r_i}\ \textsc{(Cases)}
$$

Re-running $P[pc]$ under $c_i$ makes the table read concrete.

**Merging data-only arms** (`merge_branch_arms`, `run_data_arm`). Suppose $c$ is
expressible, $pc$ is not an open loop's guard, and both arms are straight-line data-only
code (arithmetic, `mov`, vector floating point) of at most 16 instructions that rejoin at
a point $j$; a forward diamond inside an arm is merged first. If no register that carries
a region differs between the arms, the branch is not forked. Every register that differs
becomes a select:

$$
\frac{\sigma \vdash \mathit{arm}_{\mathsf{tt}} \Rightarrow^\ast_j \sigma_t \qquad \sigma \vdash \mathit{arm}_{\mathsf{ff}} \Rightarrow^\ast_j \sigma_f \qquad
      \forall r.\ \rho_t(r) \neq \rho_f(r) \Rightarrow \neg\mathsf{region}(\rho_t(r)) \wedge \neg\mathsf{region}(\rho_f(r)) \qquad
      \Gamma[\Delta \cup \Delta_\sqcup] \vdash \langle j, \sigma_t \sqcup_c \sigma_f\rangle \Downarrow r}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow r}\ \textsc{(Merge)}
$$

Here $(\sigma_t \sqcup_c \sigma_f)(r) = \langle \alpha_r\rangle{+}0$ with
$\Delta_\sqcup(\alpha_r) = (c, \lfloor\rho_t(r)\rfloor, \lfloor\rho_f(r)\rfloor)$ for
each register that differs, and the flags become fresh if the arms disagree on them.
$\mathsf{region}(v)$ holds when $\lfloor v \rfloor$ mentions a region or data symbol
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

An inexpressible select condition is an error. The second line is the *same-base* rule: a
pointer that moves by one of two strides keeps its region, and the choice becomes a data
symbol. Only selects between different regions fork.

**Path merging** (`merge_key`, `already_explored`). At the first instruction after a
label, the configuration is reduced to a key

$$
\kappa(\Gamma, \sigma, pc) = \big(pc,\ \mathsf{fp}(\sigma),\ \mathcal{A},\ \mathcal{C},\ \mathcal{L},\ \text{loop attempts, rounds, decisions, latches, ranges, suspended calls, scope ids},\ \Pi\!\restriction_{\text{live}}\big)
$$

$\mathsf{fp}$ (`fingerprint`) prints every register, lane, cell, slot, select definition and
counter of the machine; flags are left out when no instruction reads them before they are
written (`flags_dead`). $\Pi\!\restriction_{\text{live}}$ keeps every assertion except
those that only constrain fresh flag symbols unconnected to the rest (`facts_about_live_symbols`).
$H$ is in the key as a digest of its records (`history_digest`), and so are the select
revisit counts. Keys are recorded on first reach and marked finished when the
path that reached them ends:

$$
\frac{\kappa(\Gamma, \sigma, pc) \in \mathit{Finished}}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow \mathsf{ok}}\ \textsc{(Explored)}
$$

*Soundness argument.* Two configurations with one key have the same machine state, the
same open summaries and the same facts about every symbol the state mentions, so they
describe the same concrete states (§7), and the finished one has already been explored
from that key. An error on the finished path was already reported. The relied-on summary
instances are part of $\mathcal{L}$, so a path explored under a summary never stands in for
a path that does not rely on it, and vice versa. Their $H$ is the same too, so every rule
that reads it (loop triggers, round replay, exit detection) chooses the same way.

### 5.2 The safety judgment (`mem_safe_access`)

$\Gamma \vdash \mathsf{safe}_\kappa(\langle e\rangle{+}n, w)$ says that a $w$-byte access
of kind $\kappa$ at $e + n$ stays inside one declared region on every model of $\Pi$.
Checking it takes four steps.

**1. Normalise the base.** A narrowing $(\cdot)\,\%\,2^{32}$ whose operand the path
proves fits in 32 bits is removed (`without_redundant_narrowing`). If $e$ is $R$ masked
by $\&\,{-2^k}$ with $2^k \le a_R$, or by $\hat{}\ k$ with $0 \le k < a_R$, the mask is absorbed into the offset, or
kept as an in-region term (`aligned_offset`, `aligned_parts`). An aligned base therefore
still names $R$.

**2. Resolve the region** (`region_of`). Read $e$ as an affine sum
$\sum_i c_i \alpha_i + \ldots$ (`Affine::of`). $\mathsf{reg}_\mu(e)$ is the first symbol
with **net coefficient** $+1$ that names a region; failing that, the first region symbol
anywhere in $e$; failing that, the first data label in $e$, which resolves to its section
and adds the label's offset. No region is an error. Counting net coefficients means
$\alpha_A - \alpha_B + \alpha_C$ (a pointer into $C$ plus a difference) resolves to $C$, not
$A$.

**3. Check the kind.** A write into a region of kind $\mathsf{R}$ is an error. Data
sections that are not writable (§1.4) are of kind $\mathsf{R}$.

**4. Discharge two bound obligations.** Let $a = [\![e]\!] + n$; an inexpressible
$[\![e]\!]$ is an error. For an ordinary region:

$$
\mathit{lo} \triangleq a < R \qquad \mathit{hi} \triangleq a + w - 1 \ge R + [\![\ell_R]\!]
$$

For the stack (AArch64), the frame is $[\mathit{low}, \mathit{args})$ relative to the entry
`sp`. With displacement $d = [\![e]\!] - \mathtt{sp} + n$, $\mathit{args}$ the end of the
stack-passed arguments (`stack_arguments`), and $s$ the current displacement of `sp`
from its entry value (`stack_bounds`, `stack_displacement`):

$$
\mathit{low} = \min(s, 0) \qquad
\mathit{lo} \triangleq d < \mathit{low} \qquad \mathit{hi} \triangleq d + w - 1 \ge \mathit{args}
$$

If `sp` is not the entry value plus an expressible amount, a stack access is an error.
On x86-64 the stack interval is $[\mathtt{sp} - \mathtt{MAX},\ \mathtt{sp} + \mathit{top})$,
where $\mathit{top}$ covers the return address and stack arguments: the frame has no lower
bound there.

Then, with $A = \Pi \wedge \Delta^\ast(e)$ and every query through `check`:

$$
\frac{\mathsf{reg}_\mu(e) = R \qquad \kappa \sqsubseteq \kappa_R \qquad
      A \wedge \mathit{lo}\ \text{unsat} \qquad A \wedge \mathit{hi}\ \text{unsat} \qquad \mathsf{sat}(A)}
     {\Gamma \vdash \mathsf{safe}_\kappa(\langle e\rangle{+}n, w)}\ \textsc{(Safe)}
$$

The premise $\mathsf{sat}(A)$ is the **non-vacuity** check. Without it, an infeasible
path would prove every access; an `Unknown` there is reported as an undecided path.

If either bound query is `Unknown` (AArch64), there is one fallback
(`safe_for_every_stride`). Pick a symbol $\beta$ of $e$, of $\ell_R$, or of a model, with
at most 8 values under $\Pi$, and prove both obligations under each $\beta = n_i$
separately:

$$
\frac{\mathsf{vals}_\Pi(\beta) = \{n_i\}_{i \le 8} \qquad \forall i.\ A \wedge \beta{=}n_i \wedge \mathit{lo}\ \text{unsat} \wedge A \wedge \beta{=}n_i \wedge \mathit{hi}\ \text{unsat}}
     {\Gamma \vdash \mathsf{safe}_\kappa(\langle e\rangle{+}n, w)}\ \textsc{(Safe-Split)}
$$

**Red zone** (opt-in, `allow_red_zone(z)`). A stack access whose upper bound holds and
whose displacement provably stays at or above $\mathit{low} - z$ is accepted with a
*finding* rather than an error:

$$
\frac{z > 0 \qquad A \wedge \mathit{hi}\ \text{unsat} \qquad A \wedge d < \mathit{low} - z\ \text{unsat} \qquad \mathsf{sat}(A)}
     {\Gamma \vdash \mathsf{safe}_\kappa(\langle e\rangle{+}n, w)}\ \textsc{(Safe-RedZone)}
$$

---

## 6. Loop acceleration

### 6.1 Overview

A loop is closed by **abstracting the state over a counter**. Let $N = 3$
(`SUMMARY_ITERATION`). At a revisit of the loop guard, the engine compares the state with
the state at the guard's previous visit and builds a state-valued function

$$
\sigma^\sharp = \lambda\kappa.\ \sigma^\sharp(\kappa)
$$

where $\kappa$ is a fresh rigid symbol `loopN_?`, along with a set of facts $\Phi(\kappa)$.
The current visit is $\kappa = N$: every stepping component is *anchored* by rewinding it
$N$ steps, so $\sigma^\sharp(N)$ is the current state. The engine then runs the body
**once** from $\sigma^\sharp(\kappa)$, with $\kappa$ free. When control returns to the
guard, it checks one thing:

$$
\mathit{body}(\sigma^\sharp(\kappa)) \;\equiv_{\Pi,\Phi}\; \sigma^\sharp(\kappa)[\kappa{+}1/\kappa] \;=\; \sigma^\sharp(\kappa{+}1)
\tag{IND}
$$

Every access in the body was proved for an arbitrary $\kappa \ge N$ satisfying $\Phi$, by one
solver query over all such $\kappa$, whatever the shape of the address (affine in $\kappa$
or not), even when $\Phi$ pins the trip count. The
iterations before the summarizing visit were explored concretely, and the exit at the
summarizing visit is explored from the state before summarizing (§6.6). By induction on
$\kappa$, every access in every iteration is safe. After the loop exits, $\kappa$ is no
longer arbitrary: the leaving condition pins it to the iteration where the loop left.

### 6.2 Trigger (`decide`, `repeats_unboundedly`, `unrolling_costs_too_much`, `costly_concrete_latch`)

Acceleration (`try_summarize`) is attempted at a branch $pc$ when one of these holds:

- $\mathsf{decide}_\Gamma(c) = \mathsf{explore}$; or
- $\mathsf{decide}_\Gamma(c) = \mathsf{take}\ b$ for the 3rd consecutive unresolved visit
  with a *changing* guard ($c \neq c_h$), symbols in $c$, and no small bound on the guard's
  distance (`bounded_guard`): a decided but progressing loop; or
- $\mathsf{decide}_\Gamma(c) = \mathsf{take}\ b$ for the 3rd time with a concrete distance
  that closes, and unrolling the rest would cost more than 200 000 instructions; or
- the branch is a zero test (`cbz`/`cbnz`, AArch64) of a concrete register that counts
  down too slowly to unroll within that budget; the test is then made symbolic.

Let $h = (pc, c_h, \sigma_h, b)$ be the most recent earlier record of $pc$ **within the
current iteration of the innermost open loop** (records after that loop's
`history_len`), so an inner loop is summarized from its own visits in this outer
iteration. Acceleration is declined, and the branch decided as usual, when:

- there is no such $h$, or $pc$ is already an open loop's guard;
- the guard reads a register loaded from memory that changed since $h$
  (`reads_a_changing_load`): the loop is unrolled;
- the loop has failed 3 times, or been refuted 8 times (`LoopBudget::exhausted`);
- the branch is internal to a loop body: its other side cannot leave the cycle;
- the cycle since $h$ walks the guard of an open loop;
- the summary would widen a register that carries a region to $\top$;
- the joined invariant reached a fixpoint without closing, or exceeded its ascent bound.

### 6.3 The invariant lattice (`LoopInvariant`)

Each register $i$ gets a description $\iota_i$:

$$
\iota ::= \mathsf{Fix} \mid \mathsf{Lin}(\delta) \mid \mathsf{AtMost}(k) \mid \mathsf{Within}(k) \mid \mathsf{Tracks}(j, k) \mid \mathsf{NonDec} \mid \mathsf{NonInc} \mid \mathsf{Geo}(d) \mid \top
$$

Here $\delta$ is a term (usually a literal), $k \ge 0$, and $d \ge 2$. The order is
`subsumes`: $\top$ is above everything, each element is above itself, and with
$\mathsf{reach}(\mathsf{Fix}) = 0$, $\mathsf{reach}(\mathsf{Lin}(m)) = m$ for a literal
$m$, $\mathsf{reach}(\mathsf{AtMost}(k)) = k$:

$$
\mathsf{Fix} \sqsubseteq \mathsf{Within}(k) \qquad
\mathsf{Within}(k) \sqsubseteq \mathsf{Within}(k') \iff k \le k' \qquad
\iota \sqsubseteq \mathsf{AtMost}(k) \iff \mathsf{reach}(\iota) \in [0, k]
$$
$$
\mathsf{AtMost}(k) \sqsubseteq \mathsf{NonDec} \qquad
\iota \sqsubseteq \mathsf{NonDec} \iff \mathsf{reach}(\iota) \ge 0 \qquad
\iota \sqsubseteq \mathsf{NonInc} \iff \mathsf{reach}(\iota) \le 0
$$

The **join** used between retries is flat: $\iota \sqcup \iota = \iota$, and anything
else joins to $\top$. Each component can therefore ascend at most once, so retries
terminate after at most $|\mathsf{Reg}|$ rounds (`max_ascents`).

**Observation** (`invariant_of_register`). Comparing the state at $h$ with the current
state, under the assumption that the loop continues (`assume_staying`) and with selects
resolved (`resolve_selects`):

$$
\mathsf{obs}(v, v') =
\begin{cases}
\mathsf{Fix} & v = v'\\
\mathsf{Lin}(m - n) & v = \langle e\rangle{+}n,\ v' = \langle e\rangle{+}m\\
\mathsf{Lin}(\delta) & v = \langle e\rangle{+}n,\ v' = \langle e'\rangle{+}n,\ e' - e = \delta \text{ affinely, } e \notin \delta\ (\texttt{symbolic\_step})\\
\mathsf{Geo}(2^k) \text{ or } \mathsf{Geo}(d) & v' = \langle v \mathbin{\mathsf{lsr}} k\rangle{+}0 \text{ or } \langle v / d\rangle{+}0\ (\texttt{geometric\_step})\\
\top & \text{otherwise}
\end{cases}
$$

A narrowed register is compared under its narrowing.

**Refinement** ($\mathsf{refine}_\Pi$: `pin_unknown_steps`, `step_past_inner_loops`,
`bound_values`, `pin_steps`, `settle_select_steps`) replaces $\top$ or a symbolic step
with something sharper when the solver can justify it:

- $\mathsf{Lin}(k)$ when $\Pi$ pins the step to $k$ (`pinned_value`: a model's value,
  then a proof that no other value is possible);
- $\mathsf{Lin}(\delta)$ when the step, once the counters of closed inner loops are
  settled to their exit values, or written over symbols no other moving register carries,
  is proved (`proves_step`);
- $\mathsf{AtMost}(k)$ when a symbolic step is a select whose arms are in $[0, k]$;
- $\mathsf{Within}(k)$ when the value at both visits is a literal or select in $[0, k]$;
- $\mathsf{Tracks}(j, k)$ when pointer $i$ moves $k$ times as far as guard register $j$,
  whose own step then becomes $\mathsf{NonDec}$ or $\mathsf{NonInc}$ if its sign is proved.

Each refinement rests on a proof, not a model; each is a point the soundness argument
must cover (§7). Registers that broke an earlier summary at this $pc$
(`PcRecord::unstable_registers`) are forced to $\top$.

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
\nu\alpha_i.\ \alpha_i & \iota_i \in \{\top, \mathsf{Geo}(d)\}
\end{cases}
$$

When $\delta$ is a literal and the register is based, the $\mathsf{Lin}$ case keeps the
split: $\langle e \boxplus \kappa\delta\rangle{+}(n - N\delta)$. That is how a pointer
keeps its region. A narrowed (`w`) register is re-narrowed with $\%\,2^{32}$. A widened
register that was a confined load of the same width at both visits stays confined.

Memory cells written since $h$ (read from $J$ by `cells_written`) are abstracted the same
way, restricted to $\mathsf{Fix}$, $\mathsf{Lin}(k)$ for literal $k$, and $\top$; cells
that broke an earlier summary are $\top$. Slots survive only if they were present at $h$.
A flag becomes its comparison with the abstracted registers substituted in, or a fresh
flag if that is not expressible (`flag_at_summary`, `widen_flag`).

**Anchoring** (`anchored`, `rewind`). The trip facts below speak about the values of the
guard operands at $\kappa = 0$: each stepping operand $o$ with step $s$ is rewound to
$o - Ns$ (one step less for an operand read from the previous visit). Guard operands are
tied to the register that moved with them (`guard_operands`), so a register that happens
to hold an equal value is not mistaken for the operand.

**Facts.** $\Phi(\kappa)$ is a conjunction:

$$
\Phi(\kappa) = (\kappa \ge N)\ \wedge\ \Phi_{\text{prog}}\ \wedge\ \Phi_{\text{trip}}(\kappa)\ \wedge\ \Phi_{\text{geo}}\ \wedge\ \Phi_{\text{bound}}\ \wedge\ \mathit{stay}(c)[\rho^\sharp(\kappa)]
$$

- $\Phi_{\text{prog}}$: $0 \le p_i \le k(\kappa - N)$ for $\mathsf{AtMost}$, $0 \le w_i \le k$
  for $\mathsf{Within}$, and $p_i \ge 0$ for the monotone cases.
- $\mathit{stay}(c)$ is $c$ if $b$ (the loop continues when the branch is taken), else
  $\neg c$. The guard therefore holds at the summary state.
- $\Phi_{\text{trip}}$ (`trip_of`, `trip_facts`, `facts_for_exit`) applies when the guard
  is $e_x \bowtie e_w$ with $e_x$ fixed and $e_w$ stepping by a nonzero $s$. Let
  $D = \overline{e_x} - \overline{e_w}$, where the overline anchors each operand. Write
  $\trianglelefteq$ for $\le$ when $s > 0$ and $\ge$ when $s < 0$, and $\triangleleft$ for
  the strict version. A fresh total $T$ (`loopN_?_trips`) satisfies:

  $$
  \begin{array}{ll}
  \text{ordered } \bowtie, \text{ continues at equality:} & T s \trianglelefteq D \;\wedge\; D \triangleleft (T{+}1)s\\
  \text{ordered } \bowtie, \text{ stops at equality:} & D \trianglelefteq T s \;\wedge\; (T{-}1)s \triangleleft D\\
  \bowtie\ \in \{=, \neq\} \text{ or symbolic } s: & D = T s
  \end{array}
  \qquad\text{and}\qquad (\kappa + \epsilon)\,s \trianglelefteq T s
  $$

  with $\epsilon \in \{0, 1\}$ by the same case split. Every other exit of the cycle
  contributes facts of the same shape over its own total $T_{pc'}$, and a branch decided
  the same way throughout the cycle whose walker is unsigned contributes the fact that it
  held at iteration $\kappa - 1$ (`held_on_the_cycle`). A guard on a sign-extended word
  counter bounds $\kappa$ by the iterations before the word wraps
  (`word_counter_bound`).
- **Landing requirements** (`landing_requirements`, `unwrapped_requirements`). A trip fact
  that assumes the walker lands exactly on its bound, or never wraps, is paired with what
  it requires:

  $$
  \begin{array}{ll}
  \bowtie\ \in \{=,\neq\} \text{ or symbolic } s: & D \bmod |s| = 0 \;\wedge\; D \trianglerighteq_s 0 \quad (D\cdot s \ge 0 \text{ for symbolic } s)\\
  e_w = \mathsf{zext}_{64}(e) \text{ (unsigned walker)}: & e \ge 0 \;\wedge\; \text{the bound leaves room for one more step without wrapping}
  \end{array}
  $$

  Before $\Phi$ is asserted, each requirement must be proved under $\Pi$; a fact whose
  requirement is not proved is dropped from $\Phi$ and from the exit facts. This is why a
  stride that can step over a `!=` bound gets no trip count.
- $\Phi_{\text{geo}}$ (`bound_geometric_walks`): for $\mathsf{Geo}(d)$ with a proved upper
  bound $B$ on the current value, $0 \le \alpha_i \le B$; if the loop continues while that
  register is nonzero, also $\kappa \le N - 1 + \lceil\log_d\rceil(B)$ (`divisions_to_zero`).
- $\Phi_{\text{bound}}$ (`bound_candidates`, `Bound`): for a widened register $i$,
  candidate bounds $\rho^\sharp(i) \ge \rho_c(i)$ or $\le \rho_c(i)$ (its own start), or
  $\rho^\sharp(i) \le \rho^\sharp(j) + o$ for a register $j$ stepping by a literal
  (dually for negative steps), kept only if they held at both visits or moved that way.
  They are assumed at the summary state and must be re-established one iteration on (§6.5).

**Base case** (`facts_not_implied_at_base`). The current state must be the instance
$\kappa = N$ of $\sigma^\sharp$ with $\Phi(N)$ true. The *definitions* are: $\kappa = N$;
$\rho^\sharp(N)(i) = \rho_c(i)$ for every register whose summary introduces its own fresh
symbol ($w_i$, $p_i$ or $\alpha_i$; a confined $\alpha_i$ only when $\rho_c(i)$ is a confined
load of the same width); every trip fact that does not mention $\kappa$; and a lone
inequality on a trip total no other fact mentions. Each definition is solvable for its
fresh symbol whatever the path, so assuming them loses no concrete state. Under the stay
condition, every other fact of $\Phi$ must then be *implied*: $\Pi \wedge \mathit{defs}
\wedge \neg\phi$ unsat. A fact that is not is dropped, and if the definitions contradict
the path the summary is declined. Region lengths are at most $2^{63}{-}1$ bytes
(`add_region`), the largest object Rust or C can hold, so a walk bounded by a length
does not wrap.

Trip facts are linear, and division appears only in the closed-counter window (§6.5).
Counters are recorded in `symbols_bounding_counter`, so $\Delta^\ast$ of any term that
mentions $\kappa$ brings in the facts that bound it.

**Ghosts** (`ghost_operands`, `exit_ghosts`). A guard operand that no register holds at
the guard, for example one recomputed into a scratch register every iteration, gets a
*ghost*: a predicted value at $\kappa$ and at $\kappa{+}1$. The ghost is substituted into
$\mathit{stay}(c)$, and its $\kappa{+}1$ prediction becomes a premise of (IND). Every
other stepping guard operand is checked at the back edge to still be read from the
register it was tied to (`operand_checks`).

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
- $L$ is the open loop (`ActiveLoop`): $pc$, $b$, $\iota$, $\sigma^\sharp(\kappa)$,
  $\sigma_c$, $\Phi$, its exit facts, its exits, $S$, $|H|$, $|J|$, the summarized cells,
  slots, ghost and operand checks, bounds, and a fresh summary *instance* number.
- $\iota_{\text{prev}}$ is absent on the first attempt; after a widening failure it is
  taken as is (`widened`), otherwise joined.
- If $\Pi \oplus \Phi$ is unsat, the summary contradicts the path. This counts as a
  failure, and the loop is unrolled instead.
- $r$ is not yet the result: it counts only once the summary is validated (§6.6).

**Closing a loop** (`discharge_active_loop`). Control reaches $pc$ again with $L$ on top
of $\mathcal{A}$ and current state $\sigma_1$, without having left through another exit.
Write $\rho^\sharp$ for $\rho^\sharp(\kappa)$ and
$\iota^1_i = \mathsf{refine}_\Pi(\mathsf{obs}(\rho^\sharp(i), \rho_1(i)))$, observed under
$\mathit{stay}(c)$. The inductive check is

$$
\mathsf{IND}(L, \sigma_1) \;\triangleq\;
\bigwedge_i \Big(\iota^1_i \sqsubseteq \iota_i \;\vee\; \Pi \vDash \lfloor\rho_1(i)\rfloor = \lfloor\rho^\sharp(i)\rfloor + \delta_i\Big)
\;\wedge\; \mathsf{cells} \wedge \mathsf{slots} \wedge \mathsf{conf} \wedge \mathsf{ghosts} \wedge \mathsf{bounds} \wedge \mathsf{settled}
$$

The conjuncts:

- **Registers.** The second disjunct, for $\iota_i = \mathsf{Lin}(\delta_i)$, is `proves_step`.
- **cells.** Every cell rewritten since the summary, and every summarized cell, repeats
  its recorded step. No blind stack write since the summary may reach a tracked stack cell
  (`stack_cells_a_blind_write_may_reach`).
- **slots.** Every slot present at the summary is still present (`slots_kept`).
- **conf.** Every register summarized as a confined load still fits its width.
- **ghosts.** $\Pi \vDash$ each ghost operand equals its $\kappa{+}1$ prediction, and each
  checked guard operand is still its register.
- **bounds.** Each assumed bound holds at $\sigma_1$.
- **settled.** Settled select steps repeat (`unrepeated_settled_step`).

For $\mathsf{Lin}$ components this is (IND) from §6.1, by the substitution identity

$$
\big((v_0 - N\delta) + \kappa\delta\big)[\kappa{+}1/\kappa] = \big((v_0 - N\delta) + \kappa\delta\big) + \delta .
$$

The closing rule:

$$
\frac{\mathsf{IND}(L, \sigma_1) \qquad
      \Gamma[\Pi \ominus S \oplus \Phi(\kappa) \oplus \Phi_{\text{exit}} \oplus \Phi_{\text{bound}}[\sigma_1] \oplus \neg\mathit{stay}(c),\ \mathcal{A},\ \mathcal{C} \cup \{\kappa \mapsto V\}] \vdash \langle \mathit{tgt}(\neg b), \sigma_1\rangle \Downarrow r}
     {\Gamma[\mathcal{A}\cdot L] \vdash \langle pc, \sigma_1\rangle \Downarrow r}\ \textsc{(Acc-Close)}
$$

**What changes at the exit.** $\ominus S$ pops the loop's scope. Scopes opened inside
the body sit above $S$, so they are rebuilt afterwards (`scopes_above`,
`rebuild_scopes`). The facts are then re-asserted *outside* the loop's scope, together
with the leaving condition (`keep_facts`); if another loop is open, they are also kept in
its `nested_facts`, so they survive when that loop's scope is popped. Bounds on fresh
symbols (`bound_fresh`) are re-asserted whenever the scope they were made in is popped,
so no pop, rebuild or fork loses them. From here on,
$\kappa$ is the exit iteration: inside the body it was arbitrary, and at the exit it is
pinned. If the leaving condition is affine in $\kappa$, its possible exit values $V$ (a
window of at most 8, `exit_window`, `counter_value_at_exit`) are recorded in
$\mathcal{C}$ (`closed_counters`). $H$ is cut back to $|H|$ at the summary, and the
records of $pc$ are marked resolved. If the path is unsat after closing, it ends
(**Br-Dead**).

Loop closure does not require proving that the loop terminates. Safety needs every
iteration's accesses, not an exit.

**Failing the check** (`refute_active_loop`, `widen_for_retry`). If $\mathsf{IND}$ fails,
the path ends with no result of its own (`path_ends`), and the engine:

1. counts a failure at $pc$, unless every broken component is data that carries no region
   and is not read by the guard;
2. records the broken obligations (`broken_obligations`) in the shared `PcRecord` as
   unstable registers, cells and slots, and a retry attempt $\iota \sqcup \iota^1$ (keeping $\iota_i$ for
   registers that carried a region at entry) with the bounds that failed rejected;
3. records the failure in the ledger: (instance, the instances this path relied on, the
   retry).

The summarizing frame then re-explores (§6.6).

**Leaving through another exit** (`Discharge::LeftThrough`, `release_loop`,
`repeat_round`). If the body leaves through a different exit of the cycle before it
returns to $pc$, $L$ is dropped: its scope is released and its facts kept, and $H$ is cut
back. The loop at $pc$ is then treated as a sequence of *rounds* through that exit. The
first round records its state; the second generalizes the drift between the two rounds
to a fresh progress symbol $p \ge 0$, widening registers that do not move in step and
re-asserting the replayed branch decisions (`generalize_round`); a later round whose
state is an instance of the generalized one at some $p \ge 0$, and at which every replayed
decision is proved to hold, ends its path (`round_covers`), since the generalized state
has already been explored.

**Abandoning.** If a path started at the depth that opened $L$ ends without returning to
$pc$, the epilogue of `run` pops $S$. Every push therefore has exactly one pop.

**Nested loops.** An inner loop is summarized from its visits inside the current
iteration of the open outer loop (§6.2) and closes, or fails, before the outer loop's
back edge. Its counter's exit values in $\mathcal{C}$ let the outer loop's observation
settle inner counters to their exit values (`step_past_inner_loops`) and re-anchor a
pointer that the inner loop advanced (`anchor_past_inner_loops`). A branch on the cycle
of an open loop is never summarized again.

**Memory-free loops** (`memory_free_loop`, `havoc_memory_free_loop`). Consider a natural
loop $[pc, \mathit{end}]$ (from the back edges, `loop_ends_of`) made only of
register-to-register instructions (`register_written`, AArch64 only) that has at least 2
conditional branches and writes no register carrying a region. Its written registers and
all four flags are havocked to fresh symbols (`set_unknown_flags`), and each static exit
is explored once:

$$
\frac{W = \mathrm{written}(P[pc..\mathit{end}]) \qquad \forall x \in W.\ \neg\mathsf{region}(\rho(x)) \qquad
      \forall t \in \mathrm{exits}.\ \mathsf{fork}(\Gamma) \vdash \langle t, \sigma[\rho(x) \mapsto \nu\alpha_x]_{x \in W}[\varphi \mapsto \nu]\rangle \Downarrow r_t}
     {\Gamma \vdash \langle pc, \sigma\rangle \Downarrow \textstyle\bigotimes_t r_t}\ \textsc{(Havoc)}
$$

### 6.6 Validating a summary (`validate_summary`, `SummaryLedger`)

**(Acc-Open)** returns the continuing side, and the frame that summarized holds a fork
$\Gamma_0$ of the configuration *before* summarizing (the fallback). Let $\iota$ be the new
instance, appended to the path's relied-on list. The frame runs the summarized path to the
end, then asks the ledger whether $\iota$ is **refuted**: whether some path recorded a
failed inductive check of $\iota$ while relying only on instances that are not
themselves refuted.

$$
\frac{\Gamma[\ldots] \vdash \langle \mathit{tgt}(b), \sigma^\sharp(\kappa)\rangle \Downarrow r \qquad \iota \text{ not refuted} \qquad
      \Gamma_0 \vdash \langle \mathit{tgt}(\neg b), \sigma_c\rangle \Downarrow r_x}
     {\Gamma_0 \vdash \langle pc, \sigma_c\rangle \Downarrow r \otimes r_x}\ \textsc{(Validate)}
$$

$$
\frac{\iota \text{ refuted with retry } \iota' \qquad \Gamma_0[\text{attempt} := \iota'] \vdash \langle pc, \sigma_c\rangle \Downarrow r}
     {\Gamma_0 \vdash \langle pc, \sigma_c\rangle \Downarrow r}\ \textsc{(Refuted)}
$$

- In **(Validate)**, the exit at the summarizing visit is explored from $\Gamma_0$ only if
  $\mathsf{decide}_{\Gamma_0}(c) = \mathsf{explore}$; $\Phi$ excludes it ($\kappa \ge N$ and
  $\mathit{stay}(c)$ at $\kappa$), so the summarized path does not cover it.
- In **(Refuted)**, the result $r$ of the summarized path is discarded, success or error:
  the state reverts to $\Gamma_0$ and the guard is decided again, with the retry attempt
  or none. After 8 refutations at one $pc$ it is unrolled.
- Paths that relied on a refuted instance do not refute others.

---

## 7. Soundness: statement, obligations, trusted pieces

**Concretization.** A valuation $\theta : \mathsf{Sym} \to \mathbb{Z}$ and a concrete
machine state $s$ are *described* by $(\Gamma, \sigma)$, written
$(\theta, s) \models (\Gamma, \sigma)$, when all of the following hold:

- $\theta \models \Pi \wedge \Delta$;
- for every register $r$ with $\rho(r) \neq \top$,
  $s(r) = \theta([\![\lfloor \rho(r) \rfloor]\!]) \bmod 2^{64}$;
- every cell and slot matches the same way at its width, and every never-written location
  $R[n{:}w]\#\epsilon$ names the bytes there;
- each region $R$ lies at $\theta(R)$ with length $\theta([\![\ell_R]\!])$.

**Theorem (intended).** Suppose $\Gamma_0 \vdash \langle \mathit{entry}, \sigma_0\rangle \Downarrow \mathsf{ok}$,
where $\Gamma_0$ holds the declared regions and preconditions. Then for every
$(\theta, s_0) \models (\Gamma_0, \sigma_0)$, every load or store in the concrete
execution from $s_0$ touches only bytes inside a declared region of a compatible kind
(AArch64 or x86-64, by the model).

**Proof shape.** Induction on the derivation, maintaining $(\theta, s) \models (\Gamma, \sigma)$
for some extension of $\theta$:

| Rule | Obligation | Status |
|---|---|---|
| §2.1–§2.3 | Value operations and $[\![\cdot]\!]$ agree with machine arithmetic | **Only modulo wrap.** $[\![\cdot]\!]$ is over $\mathbb{Z}$ and literals fold with saturation. An access reached through 64-bit overflow is not modelled (open TODO). |
| $\mathsf{opaque}$, $\top$, $\mathsf{cap}$ | Over-approximation: any concrete value extends $\theta$ | Holds: all are unconstrained symbols. |
| §3 loads and stores | Cells, slots and names describe memory | Holds by construction: a write the engine cannot place forgets every cell not proved disjoint and bumps the epoch. |
| **(Br-\*)**, **(Split)** | Every concrete successor is covered | Holds: an arm is pruned only on `Unsat`; an inexpressible guard explores both; **(Split)** covers all values because the enumeration ran to `Unsat`. |
| **(Cases)** | The cases cover every feasible index | **Open.** `table_load` proves the index aligned and in range, but keeps an entry only if its query is `Sat`; an entry whose query is `Unknown` is dropped. It should be kept. |
| **(Merge)**, selects | $\Delta$ is exact | Holds by construction. |
| **(Explored)** | The finished path covers the merged one | Holds by construction: the key holds the machine state, the facts about it, and everything that steers later rules, $H$ included. |
| **(Safe)** | Both bound queries unsat, and the path is feasible | Holds. The frame $[\min(s,0), \mathit{args})$ around `sp` is a convention, not a property proved. |
| **(Acc-Open)** | $\Phi(\kappa)$ holds for every real iteration $\kappa \ge N$ | Holds: the definitions of $T$, $p_i$, $w_i$ and $\alpha_i$ are solvable for any path, every other fact is proved implied at $\kappa = N$ (the base case), and (IND) carries it on; landing facts are kept only when their requirements are proved. Each refinement is backed by a proof, not a model. |
| **(Acc-Close)** | Induction: the base case is the explored iterations and the exit at the summarizing visit, the step is $\mathsf{IND}$ | Holds for the components $\mathsf{IND}$ inspects. Cells and stack writes are covered by the journal and the blind-write check. |
| **(Validate)**, **(Refuted)** | A result under a summary counts only if the summary's inductive check never failed | Holds: a refuted summary's result is discarded and the loop re-explored from the fallback. The ledger only lets a failure count when the failing path relied on no refuted instance. |
| **(Havoc)** | Fresh symbols over-approximate any number of iterations | Holds: the body has no memory access to check, and every register it writes is havocked, as are all four flags. |
| Rounds | A covered round is an instance of an explored generalized round | Holds: the covered round is the generalized state at its shift, and the replayed decisions the generalized exploration assumed are proved there. |

**Trusted assumptions.** These are relied on, not checked:

- **Preconditions.** Declared regions, lengths, element facts and ranges, pointer arrays,
  pinned symbols and invariants (`add_region`, `add_element_fact`, `add_element_range`,
  `add_pointer_elements`, `pin`, `add_invariant`) are asserted, not proved.
- **Stack conventions.** The AArch64 frame $[\min(s,0), \mathit{args})$; the red zone,
  accepted only when the caller opts in (`allow_red_zone`) and then reported as a
  finding; on x86-64, no lower bound below `rsp`.
- **The machine models.** Instruction semantics, decoded `.byte` encodings, and the
  choice of which flags an instruction sets.

---

## 8. Code map

| Calculus | Code |
|---|---|
| $e$, $c$, $v$, $f$, $R$ | `common.rs`: `AbstractExpression`, `AbstractComparison`, `RegisterValue`, `FlagValue`, `MemorySafeRegion` |
| $\boxplus$, affine forms | `common::generate_expression`; `widening::{Affine, linear_form}` |
| $[\![\cdot]\!]$, `check` | `common::{expression_to_ast, comparison_to_ast, check}` |
| $\Delta^\ast$ | `machine.rs::Machine::select_assumptions`; `engine::select_definitions_in` |
| sections, address map | `loader.rs::{Listing::parse, lay_out, evaluate}`; `engine::Engine::new` |
| machine interface | `machine.rs::{Machine, MachineInstruction, Flow}` |
| $\sigma \vdash \iota \Rightarrow \sigma';k$ | AArch64: `computer/instructions.rs::execute`, `condition`; `computer/instruction_aux.rs::{arithmetic_value, cmp_values_sized, carry_select}`. x86-64: `x86/computer/{instructions,flags}.rs` |
| loads, stores, cells, slots | `computer/memory.rs::{load, store, table_load}`; `machine.rs::{store_cell, forget_where_written, region_of}`; `computer.rs::{remember_slot, recall_slot, forget_slots_overlapping}`; `x86/computer/memory.rs` |
| $\mathsf{safe}$ | `computer/memory.rs::{mem_safe_access, safe_for_every_stride, aligned_offset, aligned_parts, without_redundant_narrowing}`; `computer.rs::{stack_bounds, stack_displacement}`; `x86/computer/memory.rs::mem_safe_access` |
| $\Downarrow$, **(Explored)** | `engine::{run, run_from, run_path, step, merge_key, already_explored}` |
| $\mathsf{decide}$, **(Br-\*)** | `engine::{decide_from_solver, take_conditional_branch, follow_branch, explore_arm, add_constraint}`; `engine/loops.rs::{evaluate_branch_condition, decide}` |
| **(Split)**, **(Cases)**, **(Merge)**, selects, $\mathsf{jmpind}$ | `engine::{concrete_split, split_on, split_cases, merge_branch_arms, run_data_arm, take_select, resolve_indirect}` |
| $\mathsf{fork}$, $\oplus^S$, $\ominus S$ | `engine::{fork, push_scope, pop_scope, scopes_above, rebuild_scopes}` |
| $\iota$, $\sqcup$, $\mathsf{obs}$ | `widening.rs::{LoopInvariant, join_all, invariant_of_register, symbolic_step, geometric_step}` |
| trigger | `engine/loops.rs::{repeats_unboundedly, unrolling_costs_too_much, costly_concrete_latch, try_summarize}` |
| $\mathsf{refine}$ | `engine/loops.rs::{pin_unknown_steps, step_past_inner_loops, anchor_past_inner_loops, bound_values, pin_steps, settle_select_steps, proves_step}` |
| $\sigma^\sharp$, $\Phi$, landings | `engine/summary.rs::{summarize, stepped_by_the_counter, anchored, trip_facts, facts_for_exit, held_on_the_cycle, landing_requirements, unwrapped_requirements, bound_candidates, ghost_operands}`; `engine/loops.rs::bound_geometric_walks`; `widening::advance` |
| $L$, attempts | `engine/summary.rs::{Summary, ActiveLoop, LoopAttempt, Bound}`; `engine/loops.rs::{PathLoops, LoopHistory, PcRecord, LoopBudget}` |
| per-loop symbols ($\kappa$, $T$, $p_i$, $w_i$) | `widening.rs::{LoopSymbol, LoopRole, LoopCounter}` |
| **(Acc-Open)** | `engine/loops.rs::{try_summarize, locate_cycle, observe, next_attempt, abstract_cells, draft_summary, justify_facts, install, Decline}` |
| **(Acc-Close)**, failure | `engine/loops.rs::{discharge_active_loop, broken_obligations, Obligation, refute_active_loop, widen_for_retry, keep_facts}`; `engine/summary.rs::exit_window` |
| **(Validate)**, **(Refuted)** | `engine/loops.rs::{validate_summary, SummaryLedger, Verdict}` |
| rounds | `engine/loops.rs::{release_loop, repeat_round, generalize_round, round_covers}` |
| **(Havoc)** | `engine/loops.rs::{memory_free_loop, havoc_memory_free_loop}` |
