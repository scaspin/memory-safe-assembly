#define IS_IN(lib) 1
#define ENTRY(name) .globl name @@ name:
#define END(name)
#define ENTRY_CHK(name) ENTRY(name)
#define END_CHK(name)
#define L(name) .L##name
#define HIDDEN_JUMPTARGET(name) name
#define cfi_startproc
#define cfi_endproc
#ifdef __ILP32__
# define RAX_LP eax
# define RCX_LP ecx
# define RDX_LP edx
# define RDI_LP edi
# define RSI_LP esi
#else
# define RAX_LP rax
# define RCX_LP rcx
# define RDX_LP rdx
# define RDI_LP rdi
# define RSI_LP rsi
#endif
#define weak_alias(name, alias)
