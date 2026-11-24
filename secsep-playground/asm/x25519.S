	.text
	.file	"bench_x25519.c"
	.globl	CRYPTO_MUTEX_init               # -- Begin function CRYPTO_MUTEX_init
	.p2align	4, 0x90
	.type	CRYPTO_MUTEX_init,@function
CRYPTO_MUTEX_init:                      # @CRYPTO_MUTEX_init
# %bb.0:
	pushq	%rax
	xorl	%esi, %esi
	callq	pthread_rwlock_init@PLT
	testl	%eax, %eax
	jne	.LBB0_2
# %bb.1:
	popq	%rax
	retq
.LBB0_2:
	callq	abort@PLT
.Lfunc_end0:
	.size	CRYPTO_MUTEX_init, .Lfunc_end0-CRYPTO_MUTEX_init
                                        # -- End function
	.globl	CRYPTO_MUTEX_lock_read          # -- Begin function CRYPTO_MUTEX_lock_read
	.p2align	4, 0x90
	.type	CRYPTO_MUTEX_lock_read,@function
CRYPTO_MUTEX_lock_read:                 # @CRYPTO_MUTEX_lock_read
# %bb.0:
	pushq	%rax
	callq	pthread_rwlock_rdlock@PLT
	testl	%eax, %eax
	jne	.LBB1_2
# %bb.1:
	popq	%rax
	retq
.LBB1_2:
	callq	abort@PLT
.Lfunc_end1:
	.size	CRYPTO_MUTEX_lock_read, .Lfunc_end1-CRYPTO_MUTEX_lock_read
                                        # -- End function
	.globl	CRYPTO_MUTEX_lock_write         # -- Begin function CRYPTO_MUTEX_lock_write
	.p2align	4, 0x90
	.type	CRYPTO_MUTEX_lock_write,@function
CRYPTO_MUTEX_lock_write:                # @CRYPTO_MUTEX_lock_write
# %bb.0:
	pushq	%rax
	callq	pthread_rwlock_wrlock@PLT
	testl	%eax, %eax
	jne	.LBB2_2
# %bb.1:
	popq	%rax
	retq
.LBB2_2:
	callq	abort@PLT
.Lfunc_end2:
	.size	CRYPTO_MUTEX_lock_write, .Lfunc_end2-CRYPTO_MUTEX_lock_write
                                        # -- End function
	.globl	CRYPTO_MUTEX_unlock_read        # -- Begin function CRYPTO_MUTEX_unlock_read
	.p2align	4, 0x90
	.type	CRYPTO_MUTEX_unlock_read,@function
CRYPTO_MUTEX_unlock_read:               # @CRYPTO_MUTEX_unlock_read
# %bb.0:
	pushq	%rax
	callq	pthread_rwlock_unlock@PLT
	testl	%eax, %eax
	jne	.LBB3_2
# %bb.1:
	popq	%rax
	retq
.LBB3_2:
	callq	abort@PLT
.Lfunc_end3:
	.size	CRYPTO_MUTEX_unlock_read, .Lfunc_end3-CRYPTO_MUTEX_unlock_read
                                        # -- End function
	.globl	CRYPTO_MUTEX_unlock_write       # -- Begin function CRYPTO_MUTEX_unlock_write
	.p2align	4, 0x90
	.type	CRYPTO_MUTEX_unlock_write,@function
CRYPTO_MUTEX_unlock_write:              # @CRYPTO_MUTEX_unlock_write
# %bb.0:
	pushq	%rax
	callq	pthread_rwlock_unlock@PLT
	testl	%eax, %eax
	jne	.LBB4_2
# %bb.1:
	popq	%rax
	retq
.LBB4_2:
	callq	abort@PLT
.Lfunc_end4:
	.size	CRYPTO_MUTEX_unlock_write, .Lfunc_end4-CRYPTO_MUTEX_unlock_write
                                        # -- End function
	.globl	CRYPTO_MUTEX_cleanup            # -- Begin function CRYPTO_MUTEX_cleanup
	.p2align	4, 0x90
	.type	CRYPTO_MUTEX_cleanup,@function
CRYPTO_MUTEX_cleanup:                   # @CRYPTO_MUTEX_cleanup
# %bb.0:
	pushq	%rax
	callq	pthread_rwlock_destroy@PLT
	popq	%rax
	retq
.Lfunc_end5:
	.size	CRYPTO_MUTEX_cleanup, .Lfunc_end5-CRYPTO_MUTEX_cleanup
                                        # -- End function
	.globl	CRYPTO_once                     # -- Begin function CRYPTO_once
	.p2align	4, 0x90
	.type	CRYPTO_once,@function
CRYPTO_once:                            # @CRYPTO_once
# %bb.0:
	pushq	%rax
	callq	pthread_once@PLT
	testl	%eax, %eax
	jne	.LBB6_2
# %bb.1:
	popq	%rax
	retq
.LBB6_2:
	callq	abort@PLT
.Lfunc_end6:
	.size	CRYPTO_once, .Lfunc_end6-CRYPTO_once
                                        # -- End function
	.globl	CRYPTO_get_thread_local         # -- Begin function CRYPTO_get_thread_local
	.p2align	4, 0x90
	.type	CRYPTO_get_thread_local,@function
CRYPTO_get_thread_local:                # @CRYPTO_get_thread_local
# %bb.0:
	pushq	%rbx
	movl	%edi, %ebx
	leaq	g_thread_local_init_once(%rip), %rdi
	leaq	thread_local_init(%rip), %rsi
	callq	pthread_once@PLT
	testl	%eax, %eax
	jne	.LBB7_6
# %bb.1:
	cmpl	$0, g_thread_local_key_created(%rip)
	je	.LBB7_5
# %bb.2:
	movl	g_thread_local_key(%rip), %edi
	callq	pthread_getspecific@PLT
	testq	%rax, %rax
	je	.LBB7_5
# %bb.3:
	movl	%ebx, %ecx
	movq	(%rax,%rcx,8), %rax
	popq	%rbx
	retq
.LBB7_5:
	xorl	%eax, %eax
	popq	%rbx
	retq
.LBB7_6:
	callq	abort@PLT
.Lfunc_end7:
	.size	CRYPTO_get_thread_local, .Lfunc_end7-CRYPTO_get_thread_local
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function thread_local_init
	.type	thread_local_init,@function
thread_local_init:                      # @thread_local_init
# %bb.0:
	pushq	%rax
	leaq	g_thread_local_key(%rip), %rdi
	leaq	thread_local_destructor(%rip), %rsi
	callq	pthread_key_create@PLT
	xorl	%ecx, %ecx
	testl	%eax, %eax
	sete	%cl
	movl	%ecx, g_thread_local_key_created(%rip)
	popq	%rax
	retq
.Lfunc_end8:
	.size	thread_local_init, .Lfunc_end8-thread_local_init
                                        # -- End function
	.globl	CRYPTO_set_thread_local         # -- Begin function CRYPTO_set_thread_local
	.p2align	4, 0x90
	.type	CRYPTO_set_thread_local,@function
CRYPTO_set_thread_local:                # @CRYPTO_set_thread_local
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r14
	movq	%rsi, %rbx
	movl	%edi, %ebp
	leaq	g_thread_local_init_once(%rip), %rdi
	leaq	thread_local_init(%rip), %rsi
	callq	pthread_once@PLT
	testl	%eax, %eax
	jne	.LBB9_10
# %bb.1:
	cmpl	$0, g_thread_local_key_created(%rip)
	je	.LBB9_2
# %bb.3:
	movl	g_thread_local_key(%rip), %edi
	callq	pthread_getspecific@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	je	.LBB9_4
.LBB9_7:
	leaq	g_destructors_lock(%rip), %rdi
	callq	pthread_mutex_lock@PLT
	testl	%eax, %eax
	jne	.LBB9_2
# %bb.8:
	movl	%ebp, %r12d
	leaq	g_destructors(%rip), %rax
	movq	%r14, (%rax,%r12,8)
	leaq	g_destructors_lock(%rip), %rdi
	callq	pthread_mutex_unlock@PLT
	movq	%rbx, (%r15,%r12,8)
	movl	$1, %eax
	jmp	.LBB9_9
.LBB9_4:
	movl	$1, %edi
	movl	$40, %esi
	callq	calloc@PLT
	testq	%rax, %rax
	je	.LBB9_2
# %bb.5:
	movq	%rax, %r15
	movl	g_thread_local_key(%rip), %edi
	movq	%rax, %rsi
	callq	pthread_setspecific@PLT
	testl	%eax, %eax
	je	.LBB9_7
# %bb.6:
	movq	%r15, %rdi
	callq	free@PLT
.LBB9_2:
	movq	%rbx, %rdi
	callq	*%r14
	xorl	%eax, %eax
.LBB9_9:
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB9_10:
	callq	abort@PLT
.Lfunc_end9:
	.size	CRYPTO_set_thread_local, .Lfunc_end9-CRYPTO_set_thread_local
                                        # -- End function
	.globl	ERR_get_error                   # -- Begin function ERR_get_error
	.p2align	4, 0x90
	.type	ERR_get_error,@function
ERR_get_error:                          # @ERR_get_error
# %bb.0:
	pushq	%rax
	movl	$1, %edi
	xorl	%esi, %esi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	get_error_values
	popq	%rcx
	retq
.Lfunc_end10:
	.size	ERR_get_error, .Lfunc_end10-ERR_get_error
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function get_error_values
	.type	get_error_values,@function
get_error_values:                       # @get_error_values
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%r9, 16(%rsp)                   # 8-byte Spill
	movq	%r8, 8(%rsp)                    # 8-byte Spill
	movq	%rcx, %r13
	movq	%rdx, %rbx
	movl	%esi, %r14d
	movl	%edi, 4(%rsp)                   # 4-byte Spill
	leaq	g_thread_local_init_once(%rip), %rdi
	leaq	thread_local_init(%rip), %rsi
	callq	pthread_once@PLT
	testl	%eax, %eax
	jne	.LBB11_28
# %bb.1:
	cmpl	$0, g_thread_local_key_created(%rip)
	je	.LBB11_4
# %bb.2:
	movl	g_thread_local_key(%rip), %edi
	callq	pthread_getspecific@PLT
	testq	%rax, %rax
	je	.LBB11_4
# %bb.3:
	movq	(%rax), %r15
	testq	%r15, %r15
	jne	.LBB11_7
.LBB11_4:
	movl	$1, %edi
	movl	$400, %esi                      # imm = 0x190
	callq	calloc@PLT
	testq	%rax, %rax
	je	.LBB11_5
# %bb.6:
	movq	%rax, %r15
	leaq	err_state_free(%rip), %rdx
	xorl	%ebp, %ebp
	xorl	%edi, %edi
	movq	%rax, %rsi
	callq	CRYPTO_set_thread_local
	testl	%eax, %eax
	je	.LBB11_27
.LBB11_7:
	movl	384(%r15), %r12d
	movl	388(%r15), %eax
	xorl	%ebp, %ebp
	cmpl	%r12d, %eax
	je	.LBB11_27
# %bb.8:
	incl	%eax
	andl	$15, %eax
	testl	%r14d, %r14d
	cmovel	%eax, %r12d
	leaq	(%r12,%r12,2), %rax
	leaq	(%r15,%rax,8), %r14
	movl	16(%r15,%rax,8), %ebp
	movq	%rbx, %rsi
	testq	%rbx, %rbx
	movq	16(%rsp), %rdx                  # 8-byte Reload
	movq	8(%rsp), %rbx                   # 8-byte Reload
	je	.LBB11_14
# %bb.9:
	testq	%r13, %r13
	je	.LBB11_14
# %bb.10:
	movq	(%r14), %rcx
	testq	%rcx, %rcx
	je	.LBB11_11
# %bb.12:
	movq	%rcx, (%rsi)
	movzwl	20(%r15,%rax,8), %ecx
	jmp	.LBB11_13
.LBB11_5:
	xorl	%ebp, %ebp
	jmp	.LBB11_27
.LBB11_11:
	leaq	.L.str.9(%rip), %rcx
	movq	%rcx, (%rsi)
	xorl	%ecx, %ecx
.LBB11_13:
	movl	%ecx, (%r13)
.LBB11_14:
	testq	%rbx, %rbx
	je	.LBB11_18
# %bb.15:
	movq	8(%r15,%rax,8), %rcx
	testq	%rcx, %rcx
	je	.LBB11_16
# %bb.20:
	movq	%rcx, (%rbx)
	testq	%rdx, %rdx
	je	.LBB11_22
# %bb.21:
	movl	$3, (%rdx)
.LBB11_22:
	cmpl	$0, 4(%rsp)                     # 4-byte Folded Reload
	je	.LBB11_27
# %bb.23:
	leaq	(%r15,%rax,8), %rbx
	addq	$8, %rbx
	cmpq	$0, (%rbx)
	je	.LBB11_25
# %bb.24:
	movq	392(%r15), %rdi
	callq	free@PLT
	movq	(%rbx), %rax
	movq	%rax, 392(%r15)
.LBB11_25:
	movq	$0, (%rbx)
	xorl	%edi, %edi
	jmp	.LBB11_26
.LBB11_16:
	leaq	.L.str.7(%rip), %rcx
	movq	%rcx, (%rbx)
	testq	%rdx, %rdx
	je	.LBB11_18
# %bb.17:
	movl	$0, (%rdx)
.LBB11_18:
	cmpl	$0, 4(%rsp)                     # 4-byte Folded Reload
	je	.LBB11_27
# %bb.19:
	movq	8(%r15,%rax,8), %rdi
.LBB11_26:
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%r14)
	movq	$0, 16(%r14)
	movl	%r12d, 388(%r15)
.LBB11_27:
	movl	%ebp, %eax
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB11_28:
	callq	abort@PLT
.Lfunc_end11:
	.size	get_error_values, .Lfunc_end11-get_error_values
                                        # -- End function
	.globl	ERR_get_error_line              # -- Begin function ERR_get_error_line
	.p2align	4, 0x90
	.type	ERR_get_error_line,@function
ERR_get_error_line:                     # @ERR_get_error_line
# %bb.0:
	pushq	%rax
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movl	$1, %edi
	xorl	%esi, %esi
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	get_error_values
	popq	%rcx
	retq
.Lfunc_end12:
	.size	ERR_get_error_line, .Lfunc_end12-ERR_get_error_line
                                        # -- End function
	.globl	ERR_get_error_line_data         # -- Begin function ERR_get_error_line_data
	.p2align	4, 0x90
	.type	ERR_get_error_line_data,@function
ERR_get_error_line_data:                # @ERR_get_error_line_data
# %bb.0:
	pushq	%rax
	movq	%rcx, %r9
	movq	%rdx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movl	$1, %edi
	xorl	%esi, %esi
	callq	get_error_values
	popq	%rcx
	retq
.Lfunc_end13:
	.size	ERR_get_error_line_data, .Lfunc_end13-ERR_get_error_line_data
                                        # -- End function
	.globl	ERR_peek_error                  # -- Begin function ERR_peek_error
	.p2align	4, 0x90
	.type	ERR_peek_error,@function
ERR_peek_error:                         # @ERR_peek_error
# %bb.0:
	pushq	%rax
	xorl	%edi, %edi
	xorl	%esi, %esi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	get_error_values
	popq	%rcx
	retq
.Lfunc_end14:
	.size	ERR_peek_error, .Lfunc_end14-ERR_peek_error
                                        # -- End function
	.globl	ERR_peek_error_line             # -- Begin function ERR_peek_error_line
	.p2align	4, 0x90
	.type	ERR_peek_error_line,@function
ERR_peek_error_line:                    # @ERR_peek_error_line
# %bb.0:
	pushq	%rax
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	xorl	%edi, %edi
	xorl	%esi, %esi
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	get_error_values
	popq	%rcx
	retq
.Lfunc_end15:
	.size	ERR_peek_error_line, .Lfunc_end15-ERR_peek_error_line
                                        # -- End function
	.globl	ERR_peek_error_line_data        # -- Begin function ERR_peek_error_line_data
	.p2align	4, 0x90
	.type	ERR_peek_error_line_data,@function
ERR_peek_error_line_data:               # @ERR_peek_error_line_data
# %bb.0:
	pushq	%rax
	movq	%rcx, %r9
	movq	%rdx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	xorl	%edi, %edi
	xorl	%esi, %esi
	callq	get_error_values
	popq	%rcx
	retq
.Lfunc_end16:
	.size	ERR_peek_error_line_data, .Lfunc_end16-ERR_peek_error_line_data
                                        # -- End function
	.globl	ERR_peek_last_error             # -- Begin function ERR_peek_last_error
	.p2align	4, 0x90
	.type	ERR_peek_last_error,@function
ERR_peek_last_error:                    # @ERR_peek_last_error
# %bb.0:
	pushq	%rax
	xorl	%edi, %edi
	movl	$1, %esi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	get_error_values
	popq	%rcx
	retq
.Lfunc_end17:
	.size	ERR_peek_last_error, .Lfunc_end17-ERR_peek_last_error
                                        # -- End function
	.globl	ERR_peek_last_error_line        # -- Begin function ERR_peek_last_error_line
	.p2align	4, 0x90
	.type	ERR_peek_last_error_line,@function
ERR_peek_last_error_line:               # @ERR_peek_last_error_line
# %bb.0:
	pushq	%rax
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	xorl	%edi, %edi
	movl	$1, %esi
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	get_error_values
	popq	%rcx
	retq
.Lfunc_end18:
	.size	ERR_peek_last_error_line, .Lfunc_end18-ERR_peek_last_error_line
                                        # -- End function
	.globl	ERR_peek_last_error_line_data   # -- Begin function ERR_peek_last_error_line_data
	.p2align	4, 0x90
	.type	ERR_peek_last_error_line_data,@function
ERR_peek_last_error_line_data:          # @ERR_peek_last_error_line_data
# %bb.0:
	pushq	%rax
	movq	%rcx, %r9
	movq	%rdx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	xorl	%edi, %edi
	movl	$1, %esi
	callq	get_error_values
	popq	%rcx
	retq
.Lfunc_end19:
	.size	ERR_peek_last_error_line_data, .Lfunc_end19-ERR_peek_last_error_line_data
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function ERR_clear_error
.LCPI20_0:
	.zero	16
	.text
	.globl	ERR_clear_error
	.p2align	4, 0x90
	.type	ERR_clear_error,@function
ERR_clear_error:                        # @ERR_clear_error
# %bb.0:
	pushq	%rbx
	leaq	g_thread_local_init_once(%rip), %rdi
	leaq	thread_local_init(%rip), %rsi
	callq	pthread_once@PLT
	testl	%eax, %eax
	jne	.LBB20_8
# %bb.1:
	cmpl	$0, g_thread_local_key_created(%rip)
	je	.LBB20_4
# %bb.2:
	movl	g_thread_local_key(%rip), %edi
	callq	pthread_getspecific@PLT
	testq	%rax, %rax
	je	.LBB20_4
# %bb.3:
	movq	(%rax), %rbx
	testq	%rbx, %rbx
	jne	.LBB20_6
.LBB20_4:
	movl	$1, %edi
	movl	$400, %esi                      # imm = 0x190
	callq	calloc@PLT
	testq	%rax, %rax
	je	.LBB20_7
# %bb.5:
	movq	%rax, %rbx
	leaq	err_state_free(%rip), %rdx
	xorl	%edi, %edi
	movq	%rax, %rsi
	callq	CRYPTO_set_thread_local
	testl	%eax, %eax
	je	.LBB20_7
.LBB20_6:
	movq	8(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%rbx)
	movq	$0, 16(%rbx)
	movq	32(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 24(%rbx)
	movq	$0, 40(%rbx)
	movq	56(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 48(%rbx)
	movq	$0, 64(%rbx)
	movq	80(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 72(%rbx)
	movq	$0, 88(%rbx)
	movq	104(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 96(%rbx)
	movq	$0, 112(%rbx)
	movq	128(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 120(%rbx)
	movq	$0, 136(%rbx)
	movq	152(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 144(%rbx)
	movq	$0, 160(%rbx)
	movq	176(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 168(%rbx)
	movq	$0, 184(%rbx)
	movq	200(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 192(%rbx)
	movq	$0, 208(%rbx)
	movq	224(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 216(%rbx)
	movq	$0, 232(%rbx)
	movq	248(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 240(%rbx)
	movq	$0, 256(%rbx)
	movq	272(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 264(%rbx)
	movq	$0, 280(%rbx)
	movq	296(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 288(%rbx)
	movq	$0, 304(%rbx)
	movq	320(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 312(%rbx)
	movq	$0, 328(%rbx)
	movq	344(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 336(%rbx)
	movq	$0, 352(%rbx)
	movq	368(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 360(%rbx)
	movq	$0, 376(%rbx)
	movq	392(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 384(%rbx)
.LBB20_7:
	popq	%rbx
	retq
.LBB20_8:
	callq	abort@PLT
.Lfunc_end20:
	.size	ERR_clear_error, .Lfunc_end20-ERR_clear_error
                                        # -- End function
	.globl	ERR_remove_thread_state         # -- Begin function ERR_remove_thread_state
	.p2align	4, 0x90
	.type	ERR_remove_thread_state,@function
ERR_remove_thread_state:                # @ERR_remove_thread_state
# %bb.0:
	testq	%rdi, %rdi
	je	.LBB21_1
# %bb.2:
	retq
.LBB21_1:
	pushq	%rax
	callq	ERR_clear_error
	addq	$8, %rsp
	retq
.Lfunc_end21:
	.size	ERR_remove_thread_state, .Lfunc_end21-ERR_remove_thread_state
                                        # -- End function
	.globl	ERR_get_next_error_library      # -- Begin function ERR_get_next_error_library
	.p2align	4, 0x90
	.type	ERR_get_next_error_library,@function
ERR_get_next_error_library:             # @ERR_get_next_error_library
# %bb.0:
	pushq	%rbx
	leaq	global_next_library_mutex(%rip), %rdi
	callq	pthread_rwlock_wrlock@PLT
	testl	%eax, %eax
	jne	.LBB22_3
# %bb.1:
	movl	global_next_library(%rip), %ebx
	leal	1(%rbx), %eax
	movl	%eax, global_next_library(%rip)
	leaq	global_next_library_mutex(%rip), %rdi
	callq	pthread_rwlock_unlock@PLT
	testl	%eax, %eax
	jne	.LBB22_3
# %bb.2:
	movl	%ebx, %eax
	popq	%rbx
	retq
.LBB22_3:
	callq	abort@PLT
.Lfunc_end22:
	.size	ERR_get_next_error_library, .Lfunc_end22-ERR_get_next_error_library
                                        # -- End function
	.globl	ERR_remove_state                # -- Begin function ERR_remove_state
	.p2align	4, 0x90
	.type	ERR_remove_state,@function
ERR_remove_state:                       # @ERR_remove_state
# %bb.0:
	pushq	%rax
	callq	ERR_clear_error
	popq	%rax
	retq
.Lfunc_end23:
	.size	ERR_remove_state, .Lfunc_end23-ERR_remove_state
                                        # -- End function
	.globl	ERR_clear_system_error          # -- Begin function ERR_clear_system_error
	.p2align	4, 0x90
	.type	ERR_clear_system_error,@function
ERR_clear_system_error:                 # @ERR_clear_system_error
# %bb.0:
	pushq	%rax
	callq	__errno_location@PLT
	movl	$0, (%rax)
	popq	%rax
	retq
.Lfunc_end24:
	.size	ERR_clear_system_error, .Lfunc_end24-ERR_clear_system_error
                                        # -- End function
	.globl	ERR_lib_error_string            # -- Begin function ERR_lib_error_string
	.p2align	4, 0x90
	.type	ERR_lib_error_string,@function
ERR_lib_error_string:                   # @ERR_lib_error_string
# %bb.0:
                                        # kill: def $edi killed $edi def $rdi
	cmpl	$570425343, %edi                # imm = 0x21FFFFFF
	jbe	.LBB25_2
# %bb.1:
	xorl	%ecx, %ecx
	jmp	.LBB25_3
.LBB25_2:
	shrl	$24, %edi
	leaq	(%rdi,%rdi,2), %rax
	leaq	kLibraryNames(%rip), %rcx
	movq	(%rcx,%rax,8), %rcx
.LBB25_3:
	testq	%rcx, %rcx
	leaq	.L.str(%rip), %rax
	cmovneq	%rcx, %rax
	retq
.Lfunc_end25:
	.size	ERR_lib_error_string, .Lfunc_end25-ERR_lib_error_string
                                        # -- End function
	.globl	ERR_lib_symbol_name             # -- Begin function ERR_lib_symbol_name
	.p2align	4, 0x90
	.type	ERR_lib_symbol_name,@function
ERR_lib_symbol_name:                    # @ERR_lib_symbol_name
# %bb.0:
                                        # kill: def $edi killed $edi def $rdi
	cmpl	$570425343, %edi                # imm = 0x21FFFFFF
	jbe	.LBB26_2
# %bb.1:
	xorl	%eax, %eax
	retq
.LBB26_2:
	shrl	$24, %edi
	leaq	(%rdi,%rdi,2), %rax
	leaq	kLibraryNames(%rip), %rcx
	movq	8(%rcx,%rax,8), %rax
	retq
.Lfunc_end26:
	.size	ERR_lib_symbol_name, .Lfunc_end26-ERR_lib_symbol_name
                                        # -- End function
	.globl	ERR_func_error_string           # -- Begin function ERR_func_error_string
	.p2align	4, 0x90
	.type	ERR_func_error_string,@function
ERR_func_error_string:                  # @ERR_func_error_string
# %bb.0:
	leaq	.L.str.1(%rip), %rax
	retq
.Lfunc_end27:
	.size	ERR_func_error_string, .Lfunc_end27-ERR_func_error_string
                                        # -- End function
	.globl	ERR_reason_error_string         # -- Begin function ERR_reason_error_string
	.p2align	4, 0x90
	.type	ERR_reason_error_string,@function
ERR_reason_error_string:                # @ERR_reason_error_string
# %bb.0:
	pushq	%rax
	movl	%edi, %ecx
	movl	%edi, %edx
	shrl	$24, %edx
	andl	$4095, %edi                     # imm = 0xFFF
	cmpl	$2, %edx
	jne	.LBB28_3
# %bb.1:
	cmpl	$126, %edi
	ja	.LBB28_6
# %bb.2:
	callq	strerror@PLT
	jmp	.LBB28_7
.LBB28_3:
	cmpl	$33, %edi
	ja	.LBB28_8
# %bb.4:
	movl	%edi, %eax
	leaq	(%rax,%rax,2), %rax
	leaq	kLibraryNames(%rip), %rcx
.LBB28_5:
	movq	(%rcx,%rax,8), %rax
	jmp	.LBB28_7
.LBB28_8:
	cmpl	$99, %edi
	ja	.LBB28_11
# %bb.9:
	addl	$-65, %edi
	cmpl	$5, %edi
	jae	.LBB28_6
# %bb.10:
	movslq	%edi, %rax
	leaq	.Lswitch.table.ERR_error_string_n(%rip), %rcx
	jmp	.LBB28_5
.LBB28_6:
	xorl	%eax, %eax
.LBB28_7:
	testq	%rax, %rax
	leaq	.L.str.2(%rip), %rcx
	cmovneq	%rax, %rcx
	movq	%rcx, %rax
	popq	%rcx
	retq
.LBB28_11:
	xorl	%eax, %eax
	cmpl	$1073741823, %ecx               # imm = 0x3FFFFFFF
	ja	.LBB28_7
# %bb.12:
	cmpl	$2047, %edi                     # imm = 0x7FF
	ja	.LBB28_7
# %bb.13:
	shll	$26, %edx
	shll	$15, %edi
	orl	%edx, %edi
	shrl	$15, %edi
	movl	$757, %ecx                      # imm = 0x2F5
	xorl	%eax, %eax
	leaq	kOpenSSLReasonValues(%rip), %rdx
	xorl	%esi, %esi
	jmp	.LBB28_16
	.p2align	4, 0x90
.LBB28_14:                              #   in Loop: Header=BB28_16 Depth=1
	movq	%r8, %rcx
	cmpq	%rcx, %rsi
	jae	.LBB28_7
.LBB28_16:                              # =>This Inner Loop Header: Depth=1
	leaq	(%rcx,%rsi), %r8
	shrq	%r8
	movl	(%rdx,%r8,4), %r9d
	movl	%r9d, %r10d
	shrl	$15, %r10d
	cmpl	%r10d, %edi
	jb	.LBB28_14
# %bb.17:                               #   in Loop: Header=BB28_16 Depth=1
	jbe	.LBB28_20
# %bb.18:                               #   in Loop: Header=BB28_16 Depth=1
	incq	%r8
	movq	%r8, %rsi
	cmpq	%rcx, %rsi
	jb	.LBB28_16
	jmp	.LBB28_7
.LBB28_20:
	andl	$32767, %r9d                    # imm = 0x7FFF
	leaq	kOpenSSLReasonStringData(%rip), %rax
	addq	%r9, %rax
	jmp	.LBB28_7
.Lfunc_end28:
	.size	ERR_reason_error_string, .Lfunc_end28-ERR_reason_error_string
                                        # -- End function
	.globl	ERR_reason_symbol_name          # -- Begin function ERR_reason_symbol_name
	.p2align	4, 0x90
	.type	ERR_reason_symbol_name,@function
ERR_reason_symbol_name:                 # @ERR_reason_symbol_name
# %bb.0:
	movl	%edi, %edx
	shrl	$24, %edx
	cmpl	$2, %edx
	jne	.LBB29_2
.LBB29_1:
	xorl	%eax, %eax
	retq
.LBB29_2:
	movl	%edi, %ecx
	andl	$4095, %ecx                     # imm = 0xFFF
	cmpl	$33, %ecx
	ja	.LBB29_4
# %bb.3:
	movl	%ecx, %eax
	leaq	(%rax,%rax,2), %rax
	leaq	kLibraryNames(%rip), %rcx
	movq	16(%rcx,%rax,8), %rax
	retq
.LBB29_4:
	cmpl	$99, %ecx
	ja	.LBB29_7
# %bb.5:
	addl	$-65, %ecx
	cmpl	$5, %ecx
	jae	.LBB29_1
# %bb.6:
	movslq	%ecx, %rax
	leaq	.Lreltable.ERR_reason_symbol_name(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmp	.LBB29_15
.LBB29_7:
	xorl	%eax, %eax
	cmpl	$1073741823, %edi               # imm = 0x3FFFFFFF
	ja	.LBB29_15
# %bb.8:
	cmpl	$2047, %ecx                     # imm = 0x7FF
	ja	.LBB29_15
# %bb.9:
	shll	$26, %edx
	shll	$15, %ecx
	orl	%edx, %ecx
	shrl	$15, %ecx
	movl	$757, %edx                      # imm = 0x2F5
	xorl	%eax, %eax
	leaq	kOpenSSLReasonValues(%rip), %rsi
	xorl	%edi, %edi
	jmp	.LBB29_12
	.p2align	4, 0x90
.LBB29_10:                              #   in Loop: Header=BB29_12 Depth=1
	movq	%r8, %rdx
	cmpq	%rdx, %rdi
	jae	.LBB29_15
.LBB29_12:                              # =>This Inner Loop Header: Depth=1
	leaq	(%rdx,%rdi), %r8
	shrq	%r8
	movl	(%rsi,%r8,4), %r9d
	movl	%r9d, %r10d
	shrl	$15, %r10d
	cmpl	%r10d, %ecx
	jb	.LBB29_10
# %bb.13:                               #   in Loop: Header=BB29_12 Depth=1
	jbe	.LBB29_17
# %bb.14:                               #   in Loop: Header=BB29_12 Depth=1
	incq	%r8
	movq	%r8, %rdi
	cmpq	%rdx, %rdi
	jb	.LBB29_12
.LBB29_15:
	retq
.LBB29_17:
	andl	$32767, %r9d                    # imm = 0x7FFF
	leaq	kOpenSSLReasonStringData(%rip), %rax
	addq	%r9, %rax
	retq
.Lfunc_end29:
	.size	ERR_reason_symbol_name, .Lfunc_end29-ERR_reason_symbol_name
                                        # -- End function
	.globl	ERR_error_string                # -- Begin function ERR_error_string
	.p2align	4, 0x90
	.type	ERR_error_string,@function
ERR_error_string:                       # @ERR_error_string
# %bb.0:
	pushq	%rax
	testq	%rsi, %rsi
	leaq	ERR_error_string.buf(%rip), %rax
	cmoveq	%rax, %rsi
	movl	$120, %edx
	callq	ERR_error_string_n
	popq	%rcx
	retq
.Lfunc_end30:
	.size	ERR_error_string, .Lfunc_end30-ERR_error_string
                                        # -- End function
	.globl	ERR_error_string_n              # -- Begin function ERR_error_string_n
	.p2align	4, 0x90
	.type	ERR_error_string_n,@function
ERR_error_string_n:                     # @ERR_error_string_n
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$88, %rsp
	testq	%rdx, %rdx
	je	.LBB31_3
# %bb.1:
	movq	%rdx, %r14
	movl	%edi, %ebp
	movl	%edi, %r13d
	shrl	$24, %r13d
	cmpl	$570425343, %edi                # imm = 0x21FFFFFF
	movq	%rsi, 8(%rsp)                   # 8-byte Spill
	jbe	.LBB31_4
# %bb.2:
	xorl	%r15d, %r15d
	jmp	.LBB31_5
.LBB31_3:
	xorl	%r12d, %r12d
	jmp	.LBB31_29
.LBB31_4:
	movl	%r13d, %eax
	leaq	(%rax,%rax,2), %rax
	leaq	kLibraryNames(%rip), %rcx
	movq	(%rcx,%rax,8), %r15
.LBB31_5:
	movl	%ebp, %r12d
	andl	$4095, %r12d                    # imm = 0xFFF
	cmpl	$2, %r13d
	jne	.LBB31_8
# %bb.6:
	cmpl	$126, %r12d
	ja	.LBB31_11
# %bb.7:
	movl	%r12d, %edi
	callq	strerror@PLT
	movq	%rax, %rbx
	jmp	.LBB31_12
.LBB31_8:
	cmpl	$33, %r12d
	ja	.LBB31_30
# %bb.9:
	movl	%r12d, %eax
	leaq	(%rax,%rax,2), %rax
	leaq	kLibraryNames(%rip), %rcx
.LBB31_10:
	movq	(%rcx,%rax,8), %rbx
	jmp	.LBB31_12
.LBB31_30:
	cmpl	$99, %r12d
	ja	.LBB31_33
# %bb.31:
	leal	-65(%r12), %eax
	cmpl	$5, %eax
	jae	.LBB31_11
# %bb.32:
	cltq
	leaq	.Lswitch.table.ERR_error_string_n(%rip), %rcx
	jmp	.LBB31_10
.LBB31_11:
	xorl	%ebx, %ebx
.LBB31_12:
	testq	%r15, %r15
	je	.LBB31_25
# %bb.13:
	testq	%rbx, %rbx
	je	.LBB31_26
.LBB31_14:
	leaq	.L.str.5(%rip), %rdx
	movq	8(%rsp), %r12                   # 8-byte Reload
	movq	%r12, %rdi
	movq	%r14, %rsi
	movl	%ebp, %ecx
	movq	%r15, %r8
	movq	%rbx, %r9
	xorl	%eax, %eax
	callq	snprintf@PLT
	cmpq	$5, %r14
	jb	.LBB31_29
# %bb.15:
	testl	%eax, %eax
	js	.LBB31_29
# %bb.16:
	movl	%eax, %eax
	cmpq	%r14, %rax
	jb	.LBB31_29
# %bb.17:
	leaq	(%r14,%r12), %rbx
	addq	$-5, %rbx
	movq	%r12, %rdi
	movl	$58, %esi
	callq	strchr@PLT
	movl	$4, %edx
	testq	%rax, %rax
	je	.LBB31_27
# %bb.18:
	cmpq	%rbx, %rax
	ja	.LBB31_27
# %bb.19:
	incq	%rax
	movq	%rax, %rdi
	movl	$58, %esi
	callq	strchr@PLT
	leaq	1(%rbx), %rdi
	movl	$3, %edx
	testq	%rax, %rax
	je	.LBB31_28
# %bb.20:
	cmpq	%rdi, %rax
	ja	.LBB31_28
# %bb.21:
	incq	%rax
	movq	%rax, %rdi
	movl	$58, %esi
	callq	strchr@PLT
	leaq	2(%rbx), %rdi
	movl	$2, %edx
	testq	%rax, %rax
	je	.LBB31_28
# %bb.22:
	cmpq	%rdi, %rax
	ja	.LBB31_28
# %bb.23:
	incq	%rax
	movq	%rax, %rdi
	movl	$58, %esi
	callq	strchr@PLT
	addq	$3, %rbx
	movl	$1, %edx
	testq	%rax, %rax
	je	.LBB31_27
# %bb.24:
	movq	%rbx, %rdi
	cmpq	%rbx, %rax
	jbe	.LBB31_29
	jmp	.LBB31_28
.LBB31_25:
	leaq	.L.str.3(%rip), %rdx
	leaq	48(%rsp), %r15
	movl	$32, %esi
	movq	%r15, %rdi
	movl	%r13d, %ecx
	xorl	%eax, %eax
	callq	snprintf@PLT
	testq	%rbx, %rbx
	jne	.LBB31_14
.LBB31_26:
	leaq	.L.str.4(%rip), %rdx
	leaq	16(%rsp), %rbx
	movl	$32, %esi
	movq	%rbx, %rdi
	movl	%r12d, %ecx
	xorl	%eax, %eax
	callq	snprintf@PLT
	jmp	.LBB31_14
.LBB31_27:
	movq	%rbx, %rdi
.LBB31_28:
	movl	$58, %esi
	callq	memset@PLT
.LBB31_29:
	movq	%r12, %rax
	addq	$88, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB31_33:
	xorl	%ebx, %ebx
	cmpl	$1073741823, %ebp               # imm = 0x3FFFFFFF
	ja	.LBB31_12
# %bb.34:
	cmpl	$2047, %r12d                    # imm = 0x7FF
	ja	.LBB31_12
# %bb.35:
	movl	%r13d, %ecx
	shll	$26, %ecx
	movl	%r12d, %eax
	shll	$15, %eax
	orl	%ecx, %eax
	shrl	$15, %eax
	movl	$757, %ecx                      # imm = 0x2F5
	xorl	%ebx, %ebx
	leaq	kOpenSSLReasonValues(%rip), %rdx
	xorl	%esi, %esi
	jmp	.LBB31_38
	.p2align	4, 0x90
.LBB31_36:                              #   in Loop: Header=BB31_38 Depth=1
	movq	%rdi, %rcx
	cmpq	%rcx, %rsi
	jae	.LBB31_12
.LBB31_38:                              # =>This Inner Loop Header: Depth=1
	leaq	(%rcx,%rsi), %rdi
	shrq	%rdi
	movl	(%rdx,%rdi,4), %r8d
	movl	%r8d, %r9d
	shrl	$15, %r9d
	cmpl	%r9d, %eax
	jb	.LBB31_36
# %bb.39:                               #   in Loop: Header=BB31_38 Depth=1
	jbe	.LBB31_42
# %bb.40:                               #   in Loop: Header=BB31_38 Depth=1
	incq	%rdi
	movq	%rdi, %rsi
	cmpq	%rcx, %rsi
	jb	.LBB31_38
	jmp	.LBB31_12
.LBB31_42:
	andl	$32767, %r8d                    # imm = 0x7FFF
	leaq	kOpenSSLReasonStringData(%rip), %rbx
	addq	%r8, %rbx
	jmp	.LBB31_12
.Lfunc_end31:
	.size	ERR_error_string_n, .Lfunc_end31-ERR_error_string_n
                                        # -- End function
	.globl	ERR_print_errors_cb             # -- Begin function ERR_print_errors_cb
	.p2align	4, 0x90
	.type	ERR_print_errors_cb,@function
ERR_print_errors_cb:                    # @ERR_print_errors_cb
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1192, %rsp                     # imm = 0x4A8
	movq	%rsi, %rbx
	movq	%rdi, %r14
	leaq	g_thread_local_init_once(%rip), %rdi
	leaq	thread_local_init(%rip), %rsi
	callq	pthread_once@PLT
	testl	%eax, %eax
	jne	.LBB32_13
# %bb.1:
	cmpl	$0, g_thread_local_key_created(%rip)
	je	.LBB32_4
# %bb.2:
	movl	g_thread_local_key(%rip), %edi
	callq	pthread_getspecific@PLT
	testq	%rax, %rax
	je	.LBB32_4
# %bb.3:
	movq	(%rax), %r15
	testq	%r15, %r15
	jne	.LBB32_7
.LBB32_4:
	movl	$1, %edi
	movl	$400, %esi                      # imm = 0x190
	callq	calloc@PLT
	testq	%rax, %rax
	je	.LBB32_6
# %bb.5:
	movq	%rax, %r15
	leaq	err_state_free(%rip), %rdx
	xorl	%edi, %edi
	movq	%rax, %rsi
	callq	CRYPTO_set_thread_local
	testl	%eax, %eax
	jne	.LBB32_7
.LBB32_6:
	xorl	%r15d, %r15d
.LBB32_7:
	leaq	32(%rsp), %r13
	leaq	.L.str.6(%rip), %rbp
	leaq	160(%rsp), %r12
	jmp	.LBB32_8
	.p2align	4, 0x90
.LBB32_11:                              #   in Loop: Header=BB32_8 Depth=1
	movq	24(%rsp), %r9
	movl	12(%rsp), %r11d
	movl	$1024, %esi                     # imm = 0x400
	movq	%r12, %rdi
	movq	%rbp, %rdx
	movq	%r15, %rcx
	movq	%r13, %r8
	xorl	%eax, %eax
	pushq	%r10
	pushq	%r11
	callq	snprintf@PLT
	addq	$16, %rsp
	movq	%r12, %rdi
	callq	strlen@PLT
	movq	%r12, %rdi
	movq	%rax, %rsi
	movq	%rbx, %rdx
	callq	*%r14
	testl	%eax, %eax
	jle	.LBB32_12
.LBB32_8:                               # =>This Inner Loop Header: Depth=1
	movl	$1, %edi
	xorl	%esi, %esi
	leaq	24(%rsp), %rdx
	leaq	12(%rsp), %rcx
	leaq	16(%rsp), %r8
	leaq	8(%rsp), %r9
	callq	get_error_values
	testl	%eax, %eax
	je	.LBB32_12
# %bb.9:                                #   in Loop: Header=BB32_8 Depth=1
	movl	$120, %edx
	movl	%eax, %edi
	movq	%r13, %rsi
	callq	ERR_error_string_n
	testb	$1, 8(%rsp)
	leaq	.L.str.7(%rip), %r10
	je	.LBB32_11
# %bb.10:                               #   in Loop: Header=BB32_8 Depth=1
	movq	16(%rsp), %r10
	jmp	.LBB32_11
.LBB32_12:
	addq	$1192, %rsp                     # imm = 0x4A8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB32_13:
	callq	abort@PLT
.Lfunc_end32:
	.size	ERR_print_errors_cb, .Lfunc_end32-ERR_print_errors_cb
                                        # -- End function
	.globl	ERR_print_errors_fp             # -- Begin function ERR_print_errors_fp
	.p2align	4, 0x90
	.type	ERR_print_errors_fp,@function
ERR_print_errors_fp:                    # @ERR_print_errors_fp
# %bb.0:
	pushq	%rax
	movq	%rdi, %rsi
	leaq	print_errors_to_file(%rip), %rdi
	callq	ERR_print_errors_cb
	popq	%rax
	retq
.Lfunc_end33:
	.size	ERR_print_errors_fp, .Lfunc_end33-ERR_print_errors_fp
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function print_errors_to_file
	.type	print_errors_to_file,@function
print_errors_to_file:                   # @print_errors_to_file
# %bb.0:
	pushq	%rax
	movq	%rdx, %rsi
	callq	fputs@PLT
	notl	%eax
	shrl	$31, %eax
	popq	%rcx
	retq
.Lfunc_end34:
	.size	print_errors_to_file, .Lfunc_end34-print_errors_to_file
                                        # -- End function
	.globl	ERR_put_error                   # -- Begin function ERR_put_error
	.p2align	4, 0x90
	.type	ERR_put_error,@function
ERR_put_error:                          # @ERR_put_error
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movl	%r8d, %ebp
	movq	%rcx, %r15
	movl	%edx, %r14d
	movl	%edi, %ebx
	leaq	g_thread_local_init_once(%rip), %rdi
	leaq	thread_local_init(%rip), %rsi
	callq	pthread_once@PLT
	testl	%eax, %eax
	jne	.LBB35_13
# %bb.1:
	cmpl	$0, g_thread_local_key_created(%rip)
	je	.LBB35_4
# %bb.2:
	movl	g_thread_local_key(%rip), %edi
	callq	pthread_getspecific@PLT
	testq	%rax, %rax
	je	.LBB35_4
# %bb.3:
	movq	(%rax), %r12
	testq	%r12, %r12
	jne	.LBB35_6
.LBB35_4:
	movl	$1, %edi
	movl	$400, %esi                      # imm = 0x190
	callq	calloc@PLT
	testq	%rax, %rax
	je	.LBB35_12
# %bb.5:
	movq	%rax, %r12
	leaq	err_state_free(%rip), %rdx
	xorl	%edi, %edi
	movq	%rax, %rsi
	callq	CRYPTO_set_thread_local
	testl	%eax, %eax
	je	.LBB35_12
.LBB35_6:
	cmpl	$2, %ebx
	jne	.LBB35_9
# %bb.7:
	testl	%r14d, %r14d
	jne	.LBB35_9
# %bb.8:
	callq	__errno_location@PLT
	movl	(%rax), %r14d
.LBB35_9:
	movl	384(%r12), %ecx
	leal	1(%rcx), %eax
	andl	$15, %eax
	movl	%eax, 384(%r12)
	cmpl	388(%r12), %eax
	jne	.LBB35_11
# %bb.10:
	addl	$2, %ecx
	andl	$15, %ecx
	movl	%ecx, 388(%r12)
.LBB35_11:
	movl	%eax, %eax
	leaq	(%rax,%rax,2), %r13
	movq	8(%r12,%r13,8), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 8(%r12,%r13,8)
	movq	%r15, (%r12,%r13,8)
	movw	%bp, 20(%r12,%r13,8)
	shll	$24, %ebx
	andl	$4095, %r14d                    # imm = 0xFFF
	orl	%ebx, %r14d
	movl	%r14d, 16(%r12,%r13,8)
.LBB35_12:
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB35_13:
	callq	abort@PLT
.Lfunc_end35:
	.size	ERR_put_error, .Lfunc_end35-ERR_put_error
                                        # -- End function
	.globl	ERR_add_error_data              # -- Begin function ERR_add_error_data
	.p2align	4, 0x90
	.type	ERR_add_error_data,@function
ERR_add_error_data:                     # @ERR_add_error_data
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$264, %rsp                      # imm = 0x108
	movq	%rsi, 88(%rsp)
	movq	%rdx, 96(%rsp)
	movq	%rcx, 104(%rsp)
	movq	%r8, 112(%rsp)
	movq	%r9, 120(%rsp)
	testb	%al, %al
	je	.LBB36_28
# %bb.27:
	movaps	%xmm0, 128(%rsp)
	movaps	%xmm1, 144(%rsp)
	movaps	%xmm2, 160(%rsp)
	movaps	%xmm3, 176(%rsp)
	movaps	%xmm4, 192(%rsp)
	movaps	%xmm5, 208(%rsp)
	movaps	%xmm6, 224(%rsp)
	movaps	%xmm7, 240(%rsp)
.LBB36_28:
	leaq	80(%rsp), %rax
	movq	%rax, 32(%rsp)
	leaq	320(%rsp), %rcx
	movq	%rcx, 24(%rsp)
	movabsq	$206158430216, %rcx             # imm = 0x3000000008
	movq	%rcx, 16(%rsp)
	movq	%rax, 64(%rsp)
	movq	16(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	24(%rsp), %rax
	movq	%rax, 56(%rsp)
	movl	%edi, %r14d
	testl	%edi, %edi
	movl	%edi, 12(%rsp)                  # 4-byte Spill
	je	.LBB36_1
# %bb.2:
	movl	48(%rsp), %ebx
	movq	64(%rsp), %r12
	movq	56(%rsp), %rax
	xorl	%r15d, %r15d
	movq	%r14, %r13
	jmp	.LBB36_3
	.p2align	4, 0x90
.LBB36_8:                               #   in Loop: Header=BB36_3 Depth=1
	movq	%rbp, %rax
	decq	%r13
	je	.LBB36_9
.LBB36_3:                               # =>This Inner Loop Header: Depth=1
	cmpl	$40, %ebx
	ja	.LBB36_5
# %bb.4:                                #   in Loop: Header=BB36_3 Depth=1
	movq	%rax, %rbp
	movl	%ebx, %eax
	addq	%r12, %rax
	addl	$8, %ebx
	movl	%ebx, 48(%rsp)
	jmp	.LBB36_6
	.p2align	4, 0x90
.LBB36_5:                               #   in Loop: Header=BB36_3 Depth=1
	leaq	8(%rax), %rbp
	movq	%rbp, 56(%rsp)
.LBB36_6:                               #   in Loop: Header=BB36_3 Depth=1
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.LBB36_8
# %bb.7:                                #   in Loop: Header=BB36_3 Depth=1
	callq	strlen@PLT
	addq	%rax, %r15
	jae	.LBB36_8
	jmp	.LBB36_26
.LBB36_1:
	xorl	%r15d, %r15d
	jmp	.LBB36_10
.LBB36_9:
	cmpq	$-1, %r15
	je	.LBB36_26
.LBB36_10:
	leaq	1(%r15), %rbx
	movq	%rbx, %rdi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB36_26
# %bb.11:
	movb	$0, (%rax)
	cmpl	$0, 12(%rsp)                    # 4-byte Folded Reload
	je	.LBB36_25
# %bb.12:
	xorl	%ecx, %ecx
	jmp	.LBB36_13
	.p2align	4, 0x90
.LBB36_23:                              #   in Loop: Header=BB36_13 Depth=1
	movb	$0, (%rdx)
.LBB36_24:                              #   in Loop: Header=BB36_13 Depth=1
	incq	%rcx
	cmpq	%r14, %rcx
	je	.LBB36_25
.LBB36_13:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB36_18 Depth 2
                                        #     Child Loop BB36_21 Depth 2
	movl	16(%rsp), %esi
	cmpq	$40, %rsi
	ja	.LBB36_15
# %bb.14:                               #   in Loop: Header=BB36_13 Depth=1
	movq	%rsi, %rdx
	addq	32(%rsp), %rdx
	addl	$8, %esi
	movl	%esi, 16(%rsp)
	jmp	.LBB36_16
	.p2align	4, 0x90
.LBB36_15:                              #   in Loop: Header=BB36_13 Depth=1
	movq	24(%rsp), %rdx
	leaq	8(%rdx), %rsi
	movq	%rsi, 24(%rsp)
.LBB36_16:                              #   in Loop: Header=BB36_13 Depth=1
	movq	(%rdx), %rsi
	testq	%rsi, %rsi
	je	.LBB36_24
# %bb.17:                               # %.preheader
                                        #   in Loop: Header=BB36_13 Depth=1
	movq	%r15, %rdi
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB36_18:                              #   Parent Loop BB36_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, (%rax,%rdx)
	je	.LBB36_20
# %bb.19:                               #   in Loop: Header=BB36_18 Depth=2
	incq	%rdx
	decq	%rdi
	cmpq	%rdx, %rbx
	jne	.LBB36_18
	jmp	.LBB36_24
	.p2align	4, 0x90
.LBB36_20:                              #   in Loop: Header=BB36_13 Depth=1
	movq	%rbx, %r8
	subq	%rdx, %r8
	addq	%rax, %rdx
	cmpq	$2, %r8
	jb	.LBB36_23
	.p2align	4, 0x90
.LBB36_21:                              #   Parent Loop BB36_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rsi), %r8d
	testb	%r8b, %r8b
	je	.LBB36_23
# %bb.22:                               #   in Loop: Header=BB36_21 Depth=2
	incq	%rsi
	movb	%r8b, (%rdx)
	incq	%rdx
	decq	%rdi
	jne	.LBB36_21
	jmp	.LBB36_23
.LBB36_25:
	movq	%rax, %rdi
	callq	err_set_error_data
.LBB36_26:
	addq	$264, %rsp                      # imm = 0x108
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end36:
	.size	ERR_add_error_data, .Lfunc_end36-ERR_add_error_data
                                        # -- End function
	.globl	ERR_add_error_dataf             # -- Begin function ERR_add_error_dataf
	.p2align	4, 0x90
	.type	ERR_add_error_dataf,@function
ERR_add_error_dataf:                    # @ERR_add_error_dataf
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$248, %rsp
	movq	%rdi, %r14
	movq	%rsi, 72(%rsp)
	movq	%rdx, 80(%rsp)
	movq	%rcx, 88(%rsp)
	movq	%r8, 96(%rsp)
	movq	%r9, 104(%rsp)
	testb	%al, %al
	je	.LBB37_12
# %bb.11:
	movaps	%xmm0, 112(%rsp)
	movaps	%xmm1, 128(%rsp)
	movaps	%xmm2, 144(%rsp)
	movaps	%xmm3, 160(%rsp)
	movaps	%xmm4, 176(%rsp)
	movaps	%xmm5, 192(%rsp)
	movaps	%xmm6, 208(%rsp)
	movaps	%xmm7, 224(%rsp)
.LBB37_12:
	leaq	64(%rsp), %rax
	movq	%rax, 16(%rsp)
	leaq	288(%rsp), %rax
	movq	%rax, 8(%rsp)
	movabsq	$206158430216, %rax             # imm = 0x3000000008
	movq	%rax, (%rsp)
	movl	$64, %edi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB37_1
# %bb.2:
	movq	%rax, %rbx
	movq	16(%rsp), %rax
	movq	%rax, 48(%rsp)
	movaps	(%rsp), %xmm0
	movaps	%xmm0, 32(%rsp)
	movl	$64, %r15d
	leaq	32(%rsp), %rcx
	movl	$64, %esi
	movq	%rbx, %rdi
	movq	%r14, %rdx
	callq	vsnprintf@PLT
	testl	%eax, %eax
	js	.LBB37_8
# %bb.3:
	cmpl	$64, %eax
	jb	.LBB37_6
# %bb.4:
	movl	%eax, %r15d
	incq	%r15
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	realloc@PLT
	testq	%rax, %rax
	je	.LBB37_8
# %bb.5:
	movq	%rax, %r12
	movq	%rsp, %rcx
	movq	%rax, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	vsnprintf@PLT
	movq	%r12, %rbx
.LBB37_6:
	testl	%eax, %eax
	js	.LBB37_8
# %bb.7:
	movl	%eax, %eax
	cmpq	%rax, %r15
	jbe	.LBB37_8
# %bb.9:
	movq	%rbx, %rdi
	callq	err_set_error_data
	jmp	.LBB37_10
.LBB37_1:
	xorl	%ebx, %ebx
.LBB37_8:
	movq	%rbx, %rdi
	callq	free@PLT
	callq	__errno_location@PLT
	movl	$12, (%rax)
.LBB37_10:
	addq	$248, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end37:
	.size	ERR_add_error_dataf, .Lfunc_end37-ERR_add_error_dataf
                                        # -- End function
	.globl	OPENSSL_vasprintf_internal      # -- Begin function OPENSSL_vasprintf_internal
	.p2align	4, 0x90
	.type	OPENSSL_vasprintf_internal,@function
OPENSSL_vasprintf_internal:             # @OPENSSL_vasprintf_internal
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, 8(%rsp)                   # 8-byte Spill
	testl	%ecx, %ecx
	leaq	OPENSSL_malloc(%rip), %rax
	cmovneq	malloc@GOTPCREL(%rip), %rax
	leaq	OPENSSL_free(%rip), %rbx
	cmovneq	free@GOTPCREL(%rip), %rbx
	leaq	OPENSSL_realloc(%rip), %rbp
	cmovneq	realloc@GOTPCREL(%rip), %rbp
	movl	$64, %edi
	callq	*%rax
	testq	%rax, %rax
	je	.LBB38_1
# %bb.3:
	movq	%rax, %r14
	movq	16(%r15), %rax
	movq	%rax, 32(%rsp)
	movups	(%r15), %xmm0
	movaps	%xmm0, 16(%rsp)
	movl	$64, %r13d
	leaq	16(%rsp), %rcx
	movl	$64, %esi
	movq	%r14, %rdi
	movq	%r12, %rdx
	callq	vsnprintf@PLT
	testl	%eax, %eax
	js	.LBB38_2
# %bb.4:
	cmpl	$64, %eax
	jb	.LBB38_7
# %bb.5:
	movl	%eax, %r13d
	incq	%r13
	movq	%r14, %rdi
	movq	%r13, %rsi
	callq	*%rbp
	testq	%rax, %rax
	je	.LBB38_2
# %bb.6:
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	movq	%r15, %rcx
	callq	vsnprintf@PLT
	movq	%rbp, %r14
.LBB38_7:
	testl	%eax, %eax
	js	.LBB38_2
# %bb.8:
	movl	%eax, %ecx
	cmpq	%rcx, %r13
	jbe	.LBB38_2
# %bb.9:
	movq	8(%rsp), %rcx                   # 8-byte Reload
	movq	%r14, (%rcx)
	jmp	.LBB38_10
.LBB38_1:
	xorl	%r14d, %r14d
.LBB38_2:
	movq	%r14, %rdi
	callq	*%rbx
	movq	8(%rsp), %rax                   # 8-byte Reload
	movq	$0, (%rax)
	callq	__errno_location@PLT
	movl	$12, (%rax)
	movl	$-1, %eax
.LBB38_10:
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end38:
	.size	OPENSSL_vasprintf_internal, .Lfunc_end38-OPENSSL_vasprintf_internal
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function err_set_error_data
	.type	err_set_error_data,@function
err_set_error_data:                     # @err_set_error_data
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %rbx
	leaq	g_thread_local_init_once(%rip), %rdi
	leaq	thread_local_init(%rip), %rsi
	callq	pthread_once@PLT
	testl	%eax, %eax
	jne	.LBB39_10
# %bb.1:
	cmpl	$0, g_thread_local_key_created(%rip)
	je	.LBB39_4
# %bb.2:
	movl	g_thread_local_key(%rip), %edi
	callq	pthread_getspecific@PLT
	testq	%rax, %rax
	je	.LBB39_4
# %bb.3:
	movq	(%rax), %r14
	testq	%r14, %r14
	jne	.LBB39_6
.LBB39_4:
	movl	$1, %edi
	movl	$400, %esi                      # imm = 0x190
	callq	calloc@PLT
	testq	%rax, %rax
	je	.LBB39_7
# %bb.5:
	movq	%rax, %r14
	leaq	err_state_free(%rip), %rdx
	xorl	%edi, %edi
	movq	%rax, %rsi
	callq	CRYPTO_set_thread_local
	testl	%eax, %eax
	je	.LBB39_7
.LBB39_6:
	movl	384(%r14), %eax
	cmpl	388(%r14), %eax
	jne	.LBB39_8
.LBB39_7:
	movq	%rbx, %rdi
	callq	free@PLT
	jmp	.LBB39_9
.LBB39_8:
	leaq	(%rax,%rax,2), %r15
	movq	8(%r14,%r15,8), %rdi
	callq	free@PLT
	movq	%rbx, 8(%r14,%r15,8)
.LBB39_9:
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.LBB39_10:
	callq	abort@PLT
.Lfunc_end39:
	.size	err_set_error_data, .Lfunc_end39-err_set_error_data
                                        # -- End function
	.globl	ERR_set_error_data              # -- Begin function ERR_set_error_data
	.p2align	4, 0x90
	.type	ERR_set_error_data,@function
ERR_set_error_data:                     # @ERR_set_error_data
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movl	%esi, %ebp
	testb	$1, %bpl
	je	.LBB40_12
# %bb.1:
	movq	%rdi, %rbx
	callq	strlen@PLT
	movq	%rax, %r14
	incq	%r14
	movq	%r14, %rdi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB40_3
# %bb.2:
	movq	%rax, %r15
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%r14, %rdx
	callq	memcpy@PLT
	movq	%r15, %rdi
	callq	err_set_error_data
.LBB40_3:
	testq	%rbx, %rbx
	je	.LBB40_12
# %bb.4:
	andl	$2, %ebp
	je	.LBB40_12
# %bb.5:
	cmpq	$0, OPENSSL_memory_free@GOTPCREL(%rip)
	je	.LBB40_7
# %bb.6:
	movq	%rbx, %rdi
	callq	OPENSSL_memory_free@PLT
	jmp	.LBB40_12
.LBB40_7:
	movq	-8(%rbx), %r14
	addq	$-8, %rbx
	addq	$8, %r14
	je	.LBB40_9
# %bb.8:
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
.LBB40_9:
	movq	%rbx, %rdi
	cmpq	$0, sdallocx@GOTPCREL(%rip)
	je	.LBB40_11
# %bb.10:
	movq	%r14, %rsi
	xorl	%edx, %edx
	callq	sdallocx@PLT
	jmp	.LBB40_12
.LBB40_11:
	callq	free@PLT
.LBB40_12:
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end40:
	.size	ERR_set_error_data, .Lfunc_end40-ERR_set_error_data
                                        # -- End function
	.globl	OPENSSL_free                    # -- Begin function OPENSSL_free
	.p2align	4, 0x90
	.type	OPENSSL_free,@function
OPENSSL_free:                           # @OPENSSL_free
# %bb.0:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	testq	%rdi, %rdi
	je	.LBB41_8
# %bb.1:
	movq	%rdi, %rbx
	cmpq	$0, OPENSSL_memory_free@GOTPCREL(%rip)
	je	.LBB41_3
# %bb.2:
	movq	%rbx, %rdi
	callq	OPENSSL_memory_free@PLT
	jmp	.LBB41_8
.LBB41_3:
	movq	-8(%rbx), %r14
	addq	$-8, %rbx
	addq	$8, %r14
	je	.LBB41_5
# %bb.4:
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
.LBB41_5:
	movq	%rbx, %rdi
	cmpq	$0, sdallocx@GOTPCREL(%rip)
	je	.LBB41_7
# %bb.6:
	movq	%r14, %rsi
	xorl	%edx, %edx
	callq	sdallocx@PLT
	jmp	.LBB41_8
.LBB41_7:
	callq	free@PLT
.LBB41_8:
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end41:
	.size	OPENSSL_free, .Lfunc_end41-OPENSSL_free
                                        # -- End function
	.globl	ERR_set_mark                    # -- Begin function ERR_set_mark
	.p2align	4, 0x90
	.type	ERR_set_mark,@function
ERR_set_mark:                           # @ERR_set_mark
# %bb.0:
	pushq	%rbp
	pushq	%rbx
	pushq	%rax
	leaq	g_thread_local_init_once(%rip), %rdi
	leaq	thread_local_init(%rip), %rsi
	callq	pthread_once@PLT
	testl	%eax, %eax
	jne	.LBB42_10
# %bb.1:
	cmpl	$0, g_thread_local_key_created(%rip)
	je	.LBB42_4
# %bb.2:
	movl	g_thread_local_key(%rip), %edi
	callq	pthread_getspecific@PLT
	testq	%rax, %rax
	je	.LBB42_4
# %bb.3:
	movq	(%rax), %rbx
	testq	%rbx, %rbx
	jne	.LBB42_7
.LBB42_4:
	movl	$1, %edi
	movl	$400, %esi                      # imm = 0x190
	callq	calloc@PLT
	testq	%rax, %rax
	je	.LBB42_5
# %bb.6:
	movq	%rax, %rbx
	leaq	err_state_free(%rip), %rdx
	xorl	%ebp, %ebp
	xorl	%edi, %edi
	movq	%rax, %rsi
	callq	CRYPTO_set_thread_local
	testl	%eax, %eax
	je	.LBB42_9
.LBB42_7:
	movl	384(%rbx), %eax
	xorl	%ebp, %ebp
	cmpl	%eax, 388(%rbx)
	je	.LBB42_9
# %bb.8:
	leaq	(%rax,%rax,2), %rax
	orb	$1, 22(%rbx,%rax,8)
	movl	$1, %ebp
	jmp	.LBB42_9
.LBB42_5:
	xorl	%ebp, %ebp
.LBB42_9:
	movl	%ebp, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.LBB42_10:
	callq	abort@PLT
.Lfunc_end42:
	.size	ERR_set_mark, .Lfunc_end42-ERR_set_mark
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function ERR_pop_to_mark
.LCPI43_0:
	.zero	16
	.text
	.globl	ERR_pop_to_mark
	.p2align	4, 0x90
	.type	ERR_pop_to_mark,@function
ERR_pop_to_mark:                        # @ERR_pop_to_mark
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	leaq	g_thread_local_init_once(%rip), %rdi
	leaq	thread_local_init(%rip), %rsi
	callq	pthread_once@PLT
	testl	%eax, %eax
	jne	.LBB43_13
# %bb.1:
	cmpl	$0, g_thread_local_key_created(%rip)
	je	.LBB43_4
# %bb.2:
	movl	g_thread_local_key(%rip), %edi
	callq	pthread_getspecific@PLT
	testq	%rax, %rax
	je	.LBB43_4
# %bb.3:
	movq	(%rax), %rbx
	testq	%rbx, %rbx
	jne	.LBB43_7
.LBB43_4:
	movl	$1, %edi
	movl	$400, %esi                      # imm = 0x190
	callq	calloc@PLT
	testq	%rax, %rax
	je	.LBB43_5
# %bb.6:
	movq	%rax, %rbx
	leaq	err_state_free(%rip), %rdx
	xorl	%ebp, %ebp
	xorl	%edi, %edi
	movq	%rax, %rsi
	callq	CRYPTO_set_thread_local
	testl	%eax, %eax
	je	.LBB43_12
.LBB43_7:
	movl	384(%rbx), %eax
	xorl	%ebp, %ebp
	cmpl	%eax, 388(%rbx)
	je	.LBB43_12
# %bb.8:                                # %.preheader
	movl	$15, %r14d
	.p2align	4, 0x90
.LBB43_9:                               # =>This Inner Loop Header: Depth=1
	movl	%eax, %eax
	leaq	(%rax,%rax,2), %r15
	movzbl	22(%rbx,%r15,8), %eax
	testb	$1, %al
	jne	.LBB43_10
# %bb.11:                               #   in Loop: Header=BB43_9 Depth=1
	movq	8(%rbx,%r15,8), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%rbx,%r15,8)
	movq	$0, 16(%rbx,%r15,8)
	movl	384(%rbx), %eax
	movl	388(%rbx), %ecx
	subl	$1, %eax
	cmovbl	%r14d, %eax
	movl	%eax, 384(%rbx)
	cmpl	%eax, %ecx
	jne	.LBB43_9
	jmp	.LBB43_12
.LBB43_5:
	xorl	%ebp, %ebp
	jmp	.LBB43_12
.LBB43_10:
	leaq	(%rbx,%r15,8), %rcx
	addq	$22, %rcx
	andb	$-2, %al
	movb	%al, (%rcx)
	movl	$1, %ebp
.LBB43_12:
	movl	%ebp, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB43_13:
	callq	abort@PLT
.Lfunc_end43:
	.size	ERR_pop_to_mark, .Lfunc_end43-ERR_pop_to_mark
                                        # -- End function
	.globl	ERR_load_crypto_strings         # -- Begin function ERR_load_crypto_strings
	.p2align	4, 0x90
	.type	ERR_load_crypto_strings,@function
ERR_load_crypto_strings:                # @ERR_load_crypto_strings
# %bb.0:
	retq
.Lfunc_end44:
	.size	ERR_load_crypto_strings, .Lfunc_end44-ERR_load_crypto_strings
                                        # -- End function
	.globl	ERR_free_strings                # -- Begin function ERR_free_strings
	.p2align	4, 0x90
	.type	ERR_free_strings,@function
ERR_free_strings:                       # @ERR_free_strings
# %bb.0:
	retq
.Lfunc_end45:
	.size	ERR_free_strings, .Lfunc_end45-ERR_free_strings
                                        # -- End function
	.globl	ERR_load_BIO_strings            # -- Begin function ERR_load_BIO_strings
	.p2align	4, 0x90
	.type	ERR_load_BIO_strings,@function
ERR_load_BIO_strings:                   # @ERR_load_BIO_strings
# %bb.0:
	retq
.Lfunc_end46:
	.size	ERR_load_BIO_strings, .Lfunc_end46-ERR_load_BIO_strings
                                        # -- End function
	.globl	ERR_load_ERR_strings            # -- Begin function ERR_load_ERR_strings
	.p2align	4, 0x90
	.type	ERR_load_ERR_strings,@function
ERR_load_ERR_strings:                   # @ERR_load_ERR_strings
# %bb.0:
	retq
.Lfunc_end47:
	.size	ERR_load_ERR_strings, .Lfunc_end47-ERR_load_ERR_strings
                                        # -- End function
	.globl	ERR_load_RAND_strings           # -- Begin function ERR_load_RAND_strings
	.p2align	4, 0x90
	.type	ERR_load_RAND_strings,@function
ERR_load_RAND_strings:                  # @ERR_load_RAND_strings
# %bb.0:
	retq
.Lfunc_end48:
	.size	ERR_load_RAND_strings, .Lfunc_end48-ERR_load_RAND_strings
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function ERR_SAVE_STATE_free
.LCPI49_0:
	.zero	16
	.text
	.globl	ERR_SAVE_STATE_free
	.p2align	4, 0x90
	.type	ERR_SAVE_STATE_free,@function
ERR_SAVE_STATE_free:                    # @ERR_SAVE_STATE_free
# %bb.0:
	testq	%rdi, %rdi
	je	.LBB49_5
# %bb.1:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	cmpq	$0, 8(%rdi)
	je	.LBB49_4
# %bb.2:                                # %.preheader
	movl	$8, %r14d
	xorl	%r15d, %r15d
	.p2align	4, 0x90
.LBB49_3:                               # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %r12
	movq	(%r12,%r14), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, -8(%r12,%r14)
	movq	$0, 8(%r12,%r14)
	incq	%r15
	addq	$24, %r14
	cmpq	8(%rbx), %r15
	jb	.LBB49_3
.LBB49_4:
	movq	(%rbx), %rdi
	callq	free@PLT
	movq	%rbx, %rdi
	callq	free@PLT
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
.LBB49_5:
	retq
.Lfunc_end49:
	.size	ERR_SAVE_STATE_free, .Lfunc_end49-ERR_SAVE_STATE_free
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function ERR_save_state
.LCPI50_0:
	.zero	16
	.text
	.globl	ERR_save_state
	.p2align	4, 0x90
	.type	ERR_save_state,@function
ERR_save_state:                         # @ERR_save_state
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	leaq	g_thread_local_init_once(%rip), %rdi
	leaq	thread_local_init(%rip), %rsi
	callq	pthread_once@PLT
	testl	%eax, %eax
	jne	.LBB50_23
# %bb.1:
	cmpl	$0, g_thread_local_key_created(%rip)
	je	.LBB50_4
# %bb.2:
	movl	g_thread_local_key(%rip), %edi
	callq	pthread_getspecific@PLT
	testq	%rax, %rax
	je	.LBB50_4
# %bb.3:
	movq	(%rax), %r15
	testq	%r15, %r15
	jne	.LBB50_6
.LBB50_4:
	movl	$1, %edi
	movl	$400, %esi                      # imm = 0x190
	callq	calloc@PLT
	testq	%rax, %rax
	je	.LBB50_8
# %bb.5:
	movq	%rax, %r15
	leaq	err_state_free(%rip), %rdx
	xorl	%r13d, %r13d
	xorl	%edi, %edi
	movq	%rax, %rsi
	callq	CRYPTO_set_thread_local
	testl	%eax, %eax
	je	.LBB50_22
.LBB50_6:
	movl	384(%r15), %r14d
	movl	388(%r15), %ebx
	cmpl	%ebx, %r14d
	je	.LBB50_8
# %bb.9:
	movl	$16, %edi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB50_8
# %bb.10:
	movq	%rax, %r13
	movq	%r15, 16(%rsp)                  # 8-byte Spill
	leal	16(%r14), %ebp
	cmpl	%ebx, %r14d
	cmovael	%r14d, %ebp
	movl	%ebp, %eax
	subl	%ebx, %eax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	leaq	(,%rax,8), %rax
	leaq	(%rax,%rax,2), %r12
	movq	%r12, %rdi
	callq	malloc@PLT
	movq	%rax, (%r13)
	testq	%rax, %rax
	je	.LBB50_14
# %bb.11:
	cmpl	%ebx, %ebp
	jne	.LBB50_15
# %bb.12:
	movq	8(%rsp), %rax                   # 8-byte Reload
	movq	%rax, 8(%r13)
	jmp	.LBB50_22
.LBB50_8:
	xorl	%r13d, %r13d
.LBB50_22:
	movq	%r13, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB50_14:
	movq	%r13, %rdi
	callq	free@PLT
	xorl	%r13d, %r13d
	jmp	.LBB50_22
.LBB50_15:
	movq	%rax, %r15
	movq	%rax, %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
	movq	%r13, 24(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	movq	%rax, 8(%r13)
	cmpq	$2, %rax
	movl	$1, %ebx
	cmovbq	%rbx, %rax
	addq	$20, %r15
	negq	%rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %r13                  # 8-byte Reload
	jmp	.LBB50_18
	.p2align	4, 0x90
.LBB50_16:                              #   in Loop: Header=BB50_18 Depth=1
	movq	32(%rsp), %rax                  # 8-byte Reload
	movq	%rbp, (%rax)
	movq	16(%rsp), %r13                  # 8-byte Reload
.LBB50_17:                              #   in Loop: Header=BB50_18 Depth=1
	movl	16(%r13,%r14,8), %eax
	movl	%eax, -4(%r15)
	movzwl	20(%r13,%r14,8), %eax
	movw	%ax, (%r15)
	addq	$24, %r15
	movq	8(%rsp), %rax                   # 8-byte Reload
	addq	%rbx, %rax
	incq	%rax
	incq	%rbx
	cmpq	$1, %rax
	je	.LBB50_21
.LBB50_18:                              # =>This Inner Loop Header: Depth=1
	movl	388(%r13), %eax
	addl	%ebx, %eax
	andl	$15, %eax
	leaq	(%rax,%rax,2), %r14
	movq	-12(%r15), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, -12(%r15)
	movq	(%r13,%r14,8), %rax
	movq	%rax, -20(%r15)
	movq	8(%r13,%r14,8), %r12
	testq	%r12, %r12
	je	.LBB50_17
# %bb.19:                               #   in Loop: Header=BB50_18 Depth=1
	leaq	-12(%r15), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r12, %rdi
	callq	strlen@PLT
	movq	%rax, %r13
	incq	%r13
	movq	%r13, %rdi
	callq	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.LBB50_16
# %bb.20:                               #   in Loop: Header=BB50_18 Depth=1
	movq	%rbp, %rdi
	movq	%r12, %rsi
	movq	%r13, %rdx
	callq	memcpy@PLT
	jmp	.LBB50_16
.LBB50_21:
	movq	24(%rsp), %r13                  # 8-byte Reload
	jmp	.LBB50_22
.LBB50_23:
	callq	abort@PLT
.Lfunc_end50:
	.size	ERR_save_state, .Lfunc_end50-ERR_save_state
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function ERR_restore_state
.LCPI51_0:
	.zero	16
	.text
	.globl	ERR_restore_state
	.p2align	4, 0x90
	.type	ERR_restore_state,@function
ERR_restore_state:                      # @ERR_restore_state
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	testq	%rdi, %rdi
	je	.LBB51_2
# %bb.1:
	movq	%rdi, %r12
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.LBB51_2
# %bb.3:
	cmpq	$16, %rax
	jae	.LBB51_21
# %bb.4:
	leaq	g_thread_local_init_once(%rip), %rdi
	leaq	thread_local_init(%rip), %rsi
	callq	pthread_once@PLT
	testl	%eax, %eax
	jne	.LBB51_21
# %bb.5:
	cmpl	$0, g_thread_local_key_created(%rip)
	je	.LBB51_8
# %bb.6:
	movl	g_thread_local_key(%rip), %edi
	callq	pthread_getspecific@PLT
	testq	%rax, %rax
	je	.LBB51_8
# %bb.7:
	movq	(%rax), %r13
	testq	%r13, %r13
	jne	.LBB51_10
.LBB51_8:
	movl	$1, %edi
	movl	$400, %esi                      # imm = 0x190
	callq	calloc@PLT
	testq	%rax, %rax
	je	.LBB51_14
# %bb.9:
	movq	%rax, %r13
	leaq	err_state_free(%rip), %rdx
	xorl	%edi, %edi
	movq	%rax, %rsi
	callq	CRYPTO_set_thread_local
	testl	%eax, %eax
	je	.LBB51_14
.LBB51_10:
	cmpq	$0, 8(%r12)
	je	.LBB51_11
# %bb.15:                               # %.preheader
	xorl	%ebp, %ebp
	xorl	%ebx, %ebx
	movq	%r12, 16(%rsp)                  # 8-byte Spill
	movq	%r13, 8(%rsp)                   # 8-byte Spill
	jmp	.LBB51_16
	.p2align	4, 0x90
.LBB51_19:                              #   in Loop: Header=BB51_16 Depth=1
	movq	8(%rsp), %rax                   # 8-byte Reload
	movq	%r13, 8(%rax,%rbp)
	movq	%rax, %r13
	movq	16(%rsp), %r12                  # 8-byte Reload
.LBB51_20:                              #   in Loop: Header=BB51_16 Depth=1
	movl	16(%r14,%rbp), %eax
	movl	%eax, 16(%r13,%rbp)
	movzwl	20(%r14,%rbp), %eax
	movw	%ax, 20(%r13,%rbp)
	incq	%rbx
	movq	8(%r12), %rax
	addq	$24, %rbp
	cmpq	%rax, %rbx
	jae	.LBB51_12
.LBB51_16:                              # =>This Inner Loop Header: Depth=1
	movq	(%r12), %r14
	movq	8(%r13,%rbp), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%r13,%rbp)
	movq	$0, 16(%r13,%rbp)
	movq	(%r14,%rbp), %rax
	movq	%rax, (%r13,%rbp)
	movq	8(%r14,%rbp), %r15
	testq	%r15, %r15
	je	.LBB51_20
# %bb.17:                               #   in Loop: Header=BB51_16 Depth=1
	movq	%r15, %rdi
	callq	strlen@PLT
	movq	%rax, %r12
	incq	%r12
	movq	%r12, %rdi
	callq	malloc@PLT
	movq	%rax, %r13
	testq	%rax, %rax
	je	.LBB51_19
# %bb.18:                               #   in Loop: Header=BB51_16 Depth=1
	movq	%r13, %rdi
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	memcpy@PLT
	jmp	.LBB51_19
.LBB51_2:
	callq	ERR_clear_error
	jmp	.LBB51_14
.LBB51_12:
	decl	%eax
	jmp	.LBB51_13
.LBB51_11:
	movl	$-1, %eax
.LBB51_13:
	movl	%eax, 384(%r13)
	movl	$15, 388(%r13)
.LBB51_14:
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB51_21:
	callq	abort@PLT
.Lfunc_end51:
	.size	ERR_restore_state, .Lfunc_end51-ERR_restore_state
                                        # -- End function
	.globl	OPENSSL_malloc                  # -- Begin function OPENSSL_malloc
	.p2align	4, 0x90
	.type	OPENSSL_malloc,@function
OPENSSL_malloc:                         # @OPENSSL_malloc
# %bb.0:
	pushq	%rbx
	movq	%rdi, %rbx
	cmpq	$0, OPENSSL_memory_alloc@GOTPCREL(%rip)
	je	.LBB52_4
# %bb.1:
	movq	%rbx, %rdi
	callq	OPENSSL_memory_alloc@PLT
	testq	%rbx, %rbx
	je	.LBB52_7
# %bb.2:
	testq	%rax, %rax
	je	.LBB52_3
.LBB52_7:
	popq	%rbx
	retq
.LBB52_4:
	cmpq	$-9, %rbx
	ja	.LBB52_3
# %bb.5:
	leaq	8(%rbx), %rdi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB52_3
# %bb.6:
	movq	%rbx, (%rax)
	addq	$8, %rax
	popq	%rbx
	retq
.LBB52_3:
	leaq	.L.str.8(%rip), %rcx
	movl	$14, %edi
	movl	$65, %edx
	movl	$253, %r8d
	callq	ERR_put_error
	xorl	%eax, %eax
	popq	%rbx
	retq
.Lfunc_end52:
	.size	OPENSSL_malloc, .Lfunc_end52-OPENSSL_malloc
                                        # -- End function
	.globl	OPENSSL_zalloc                  # -- Begin function OPENSSL_zalloc
	.p2align	4, 0x90
	.type	OPENSSL_zalloc,@function
OPENSSL_zalloc:                         # @OPENSSL_zalloc
# %bb.0:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	cmpq	$0, OPENSSL_memory_alloc@GOTPCREL(%rip)
	je	.LBB53_4
# %bb.1:
	movq	%rbx, %rdi
	callq	OPENSSL_memory_alloc@PLT
	movq	%rax, %r14
	testq	%rbx, %rbx
	je	.LBB53_9
# %bb.2:
	testq	%r14, %r14
	je	.LBB53_3
.LBB53_9:
	testq	%r14, %r14
	je	.LBB53_10
# %bb.7:
	testq	%rbx, %rbx
	jne	.LBB53_8
	jmp	.LBB53_11
.LBB53_4:
	cmpq	$-9, %rbx
	ja	.LBB53_3
# %bb.5:
	leaq	8(%rbx), %rdi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB53_3
# %bb.6:
	movq	%rax, %r14
	movq	%rbx, (%rax)
	addq	$8, %r14
	testq	%rbx, %rbx
	je	.LBB53_11
.LBB53_8:
	movq	%r14, %rdi
	xorl	%esi, %esi
	movq	%rbx, %rdx
	callq	memset@PLT
	jmp	.LBB53_11
.LBB53_3:
	leaq	.L.str.8(%rip), %rcx
	movl	$14, %edi
	movl	$65, %edx
	movl	$253, %r8d
	callq	ERR_put_error
.LBB53_10:
	xorl	%r14d, %r14d
.LBB53_11:
	movq	%r14, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end53:
	.size	OPENSSL_zalloc, .Lfunc_end53-OPENSSL_zalloc
                                        # -- End function
	.globl	OPENSSL_calloc                  # -- Begin function OPENSSL_calloc
	.p2align	4, 0x90
	.type	OPENSSL_calloc,@function
OPENSSL_calloc:                         # @OPENSSL_calloc
# %bb.0:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	testq	%rsi, %rsi
	je	.LBB54_3
# %bb.1:
	movq	%rbx, %rax
	mulq	%rdi
	jno	.LBB54_3
# %bb.2:
	leaq	.L.str.8(%rip), %rcx
	movl	$14, %edi
	movl	$69, %edx
	movl	$267, %r8d                      # imm = 0x10B
	jmp	.LBB54_13
.LBB54_3:
	imulq	%rdi, %rbx
	cmpq	$0, OPENSSL_memory_alloc@GOTPCREL(%rip)
	je	.LBB54_8
# %bb.4:
	movq	%rbx, %rdi
	callq	OPENSSL_memory_alloc@PLT
	movq	%rax, %r14
	testq	%rbx, %rbx
	je	.LBB54_6
# %bb.5:
	testq	%r14, %r14
	je	.LBB54_12
.LBB54_6:
	testq	%r14, %r14
	je	.LBB54_14
# %bb.7:
	testq	%rbx, %rbx
	jne	.LBB54_11
	jmp	.LBB54_15
.LBB54_8:
	cmpq	$-9, %rbx
	ja	.LBB54_12
# %bb.9:
	leaq	8(%rbx), %rdi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB54_12
# %bb.10:
	movq	%rax, %r14
	movq	%rbx, (%rax)
	addq	$8, %r14
	testq	%rbx, %rbx
	je	.LBB54_15
.LBB54_11:
	movq	%r14, %rdi
	xorl	%esi, %esi
	movq	%rbx, %rdx
	callq	memset@PLT
	jmp	.LBB54_15
.LBB54_12:
	leaq	.L.str.8(%rip), %rcx
	movl	$14, %edi
	movl	$65, %edx
	movl	$253, %r8d
.LBB54_13:
	callq	ERR_put_error
.LBB54_14:
	xorl	%r14d, %r14d
.LBB54_15:
	movq	%r14, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end54:
	.size	OPENSSL_calloc, .Lfunc_end54-OPENSSL_calloc
                                        # -- End function
	.globl	OPENSSL_cleanse                 # -- Begin function OPENSSL_cleanse
	.p2align	4, 0x90
	.type	OPENSSL_cleanse,@function
OPENSSL_cleanse:                        # @OPENSSL_cleanse
# %bb.0:
	testq	%rsi, %rsi
	je	.LBB55_2
# %bb.1:
	pushq	%rax
	movq	%rsi, %rdx
	xorl	%esi, %esi
	callq	memset@PLT
	addq	$8, %rsp
.LBB55_2:
	retq
.Lfunc_end55:
	.size	OPENSSL_cleanse, .Lfunc_end55-OPENSSL_cleanse
                                        # -- End function
	.globl	OPENSSL_realloc                 # -- Begin function OPENSSL_realloc
	.p2align	4, 0x90
	.type	OPENSSL_realloc,@function
OPENSSL_realloc:                        # @OPENSSL_realloc
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %r15
	testq	%rdi, %rdi
	je	.LBB56_6
# %bb.1:
	movq	%rdi, %r14
	cmpq	$0, OPENSSL_memory_get_size@GOTPCREL(%rip)
	je	.LBB56_9
# %bb.2:
	movq	%r14, %rdi
	callq	OPENSSL_memory_get_size@PLT
	movq	%rax, %r12
	cmpq	$0, OPENSSL_memory_alloc@GOTPCREL(%rip)
	jne	.LBB56_10
.LBB56_3:
	cmpq	$-9, %r15
	ja	.LBB56_18
# %bb.4:
	leaq	8(%r15), %rdi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB56_18
# %bb.5:
	movq	%rax, %rbx
	movq	%r15, (%rax)
	addq	$8, %rbx
	jmp	.LBB56_13
.LBB56_6:
	cmpq	$0, OPENSSL_memory_alloc@GOTPCREL(%rip)
	je	.LBB56_15
# %bb.7:
	movq	%r15, %rdi
	callq	OPENSSL_memory_alloc@PLT
	movq	%rax, %rbx
	testq	%r15, %r15
	je	.LBB56_20
# %bb.8:
	testq	%rbx, %rbx
	je	.LBB56_18
	jmp	.LBB56_20
.LBB56_9:
	movq	-8(%r14), %r12
	cmpq	$0, OPENSSL_memory_alloc@GOTPCREL(%rip)
	je	.LBB56_3
.LBB56_10:
	movq	%r15, %rdi
	callq	OPENSSL_memory_alloc@PLT
	movq	%rax, %rbx
	testq	%r15, %r15
	je	.LBB56_12
# %bb.11:
	testq	%rbx, %rbx
	je	.LBB56_18
.LBB56_12:
	testq	%rbx, %rbx
	je	.LBB56_19
.LBB56_13:
	cmpq	%r15, %r12
	cmovbq	%r12, %r15
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
	cmpq	$0, OPENSSL_memory_free@GOTPCREL(%rip)
	je	.LBB56_21
# %bb.14:
	movq	%r14, %rdi
	callq	OPENSSL_memory_free@PLT
	jmp	.LBB56_20
.LBB56_15:
	cmpq	$-9, %r15
	ja	.LBB56_18
# %bb.16:
	leaq	8(%r15), %rdi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB56_18
# %bb.17:
	movq	%rax, %rbx
	movq	%r15, (%rax)
	addq	$8, %rbx
	jmp	.LBB56_20
.LBB56_18:
	leaq	.L.str.8(%rip), %rcx
	movl	$14, %edi
	movl	$65, %edx
	movl	$253, %r8d
	callq	ERR_put_error
.LBB56_19:
	xorl	%ebx, %ebx
.LBB56_20:
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.LBB56_21:
	movq	-8(%r14), %r15
	addq	$-8, %r14
	addq	$8, %r15
	je	.LBB56_23
# %bb.22:
	movq	%r14, %rdi
	xorl	%esi, %esi
	movq	%r15, %rdx
	callq	memset@PLT
.LBB56_23:
	movq	%r14, %rdi
	cmpq	$0, sdallocx@GOTPCREL(%rip)
	je	.LBB56_26
# %bb.24:
	movq	%r15, %rsi
	xorl	%edx, %edx
	callq	sdallocx@PLT
	jmp	.LBB56_20
.LBB56_26:
	callq	free@PLT
	jmp	.LBB56_20
.Lfunc_end56:
	.size	OPENSSL_realloc, .Lfunc_end56-OPENSSL_realloc
                                        # -- End function
	.globl	OPENSSL_clear_free              # -- Begin function OPENSSL_clear_free
	.p2align	4, 0x90
	.type	OPENSSL_clear_free,@function
OPENSSL_clear_free:                     # @OPENSSL_clear_free
# %bb.0:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	testq	%rdi, %rdi
	je	.LBB57_8
# %bb.1:
	movq	%rdi, %rbx
	cmpq	$0, OPENSSL_memory_free@GOTPCREL(%rip)
	je	.LBB57_3
# %bb.2:
	movq	%rbx, %rdi
	callq	OPENSSL_memory_free@PLT
	jmp	.LBB57_8
.LBB57_3:
	movq	-8(%rbx), %r14
	addq	$-8, %rbx
	addq	$8, %r14
	je	.LBB57_5
# %bb.4:
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
.LBB57_5:
	movq	%rbx, %rdi
	cmpq	$0, sdallocx@GOTPCREL(%rip)
	je	.LBB57_7
# %bb.6:
	movq	%r14, %rsi
	xorl	%edx, %edx
	callq	sdallocx@PLT
	jmp	.LBB57_8
.LBB57_7:
	callq	free@PLT
.LBB57_8:
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end57:
	.size	OPENSSL_clear_free, .Lfunc_end57-OPENSSL_clear_free
                                        # -- End function
	.globl	CRYPTO_secure_malloc_init       # -- Begin function CRYPTO_secure_malloc_init
	.p2align	4, 0x90
	.type	CRYPTO_secure_malloc_init,@function
CRYPTO_secure_malloc_init:              # @CRYPTO_secure_malloc_init
# %bb.0:
	xorl	%eax, %eax
	retq
.Lfunc_end58:
	.size	CRYPTO_secure_malloc_init, .Lfunc_end58-CRYPTO_secure_malloc_init
                                        # -- End function
	.globl	CRYPTO_secure_malloc_initialized # -- Begin function CRYPTO_secure_malloc_initialized
	.p2align	4, 0x90
	.type	CRYPTO_secure_malloc_initialized,@function
CRYPTO_secure_malloc_initialized:       # @CRYPTO_secure_malloc_initialized
# %bb.0:
	xorl	%eax, %eax
	retq
.Lfunc_end59:
	.size	CRYPTO_secure_malloc_initialized, .Lfunc_end59-CRYPTO_secure_malloc_initialized
                                        # -- End function
	.globl	CRYPTO_secure_used              # -- Begin function CRYPTO_secure_used
	.p2align	4, 0x90
	.type	CRYPTO_secure_used,@function
CRYPTO_secure_used:                     # @CRYPTO_secure_used
# %bb.0:
	xorl	%eax, %eax
	retq
.Lfunc_end60:
	.size	CRYPTO_secure_used, .Lfunc_end60-CRYPTO_secure_used
                                        # -- End function
	.globl	OPENSSL_secure_malloc           # -- Begin function OPENSSL_secure_malloc
	.p2align	4, 0x90
	.type	OPENSSL_secure_malloc,@function
OPENSSL_secure_malloc:                  # @OPENSSL_secure_malloc
# %bb.0:
	pushq	%rbx
	movq	%rdi, %rbx
	cmpq	$0, OPENSSL_memory_alloc@GOTPCREL(%rip)
	je	.LBB61_4
# %bb.1:
	movq	%rbx, %rdi
	callq	OPENSSL_memory_alloc@PLT
	testq	%rbx, %rbx
	je	.LBB61_7
# %bb.2:
	testq	%rax, %rax
	je	.LBB61_3
.LBB61_7:
	popq	%rbx
	retq
.LBB61_4:
	cmpq	$-9, %rbx
	ja	.LBB61_3
# %bb.5:
	leaq	8(%rbx), %rdi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB61_3
# %bb.6:
	movq	%rbx, (%rax)
	addq	$8, %rax
	popq	%rbx
	retq
.LBB61_3:
	leaq	.L.str.8(%rip), %rcx
	movl	$14, %edi
	movl	$65, %edx
	movl	$253, %r8d
	callq	ERR_put_error
	xorl	%eax, %eax
	popq	%rbx
	retq
.Lfunc_end61:
	.size	OPENSSL_secure_malloc, .Lfunc_end61-OPENSSL_secure_malloc
                                        # -- End function
	.globl	OPENSSL_secure_clear_free       # -- Begin function OPENSSL_secure_clear_free
	.p2align	4, 0x90
	.type	OPENSSL_secure_clear_free,@function
OPENSSL_secure_clear_free:              # @OPENSSL_secure_clear_free
# %bb.0:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	testq	%rdi, %rdi
	je	.LBB62_8
# %bb.1:
	movq	%rdi, %rbx
	cmpq	$0, OPENSSL_memory_free@GOTPCREL(%rip)
	je	.LBB62_3
# %bb.2:
	movq	%rbx, %rdi
	callq	OPENSSL_memory_free@PLT
	jmp	.LBB62_8
.LBB62_3:
	movq	-8(%rbx), %r14
	addq	$-8, %rbx
	addq	$8, %r14
	je	.LBB62_5
# %bb.4:
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
.LBB62_5:
	movq	%rbx, %rdi
	cmpq	$0, sdallocx@GOTPCREL(%rip)
	je	.LBB62_7
# %bb.6:
	movq	%r14, %rsi
	xorl	%edx, %edx
	callq	sdallocx@PLT
	jmp	.LBB62_8
.LBB62_7:
	callq	free@PLT
.LBB62_8:
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end62:
	.size	OPENSSL_secure_clear_free, .Lfunc_end62-OPENSSL_secure_clear_free
                                        # -- End function
	.globl	CRYPTO_memcmp                   # -- Begin function CRYPTO_memcmp
	.p2align	4, 0x90
	.type	CRYPTO_memcmp,@function
CRYPTO_memcmp:                          # @CRYPTO_memcmp
# %bb.0:
	testq	%rdx, %rdx
	je	.LBB63_1
# %bb.2:
	cmpq	$8, %rdx
	jae	.LBB63_4
# %bb.3:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	jmp	.LBB63_13
.LBB63_1:
	xorl	%eax, %eax
	retq
.LBB63_4:
	cmpq	$32, %rdx
	jae	.LBB63_6
# %bb.5:
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	jmp	.LBB63_10
.LBB63_6:
	movq	%rdx, %rax
	andq	$-32, %rax
	pxor	%xmm0, %xmm0
	xorl	%ecx, %ecx
	pxor	%xmm1, %xmm1
	.p2align	4, 0x90
.LBB63_7:                               # =>This Inner Loop Header: Depth=1
	movdqu	(%rdi,%rcx), %xmm2
	movdqu	16(%rdi,%rcx), %xmm3
	movdqu	(%rsi,%rcx), %xmm4
	pxor	%xmm2, %xmm4
	por	%xmm4, %xmm0
	movdqu	16(%rsi,%rcx), %xmm2
	pxor	%xmm3, %xmm2
	por	%xmm2, %xmm1
	addq	$32, %rcx
	cmpq	%rcx, %rax
	jne	.LBB63_7
# %bb.8:
	por	%xmm0, %xmm1
	pshufd	$238, %xmm1, %xmm0              # xmm0 = xmm1[2,3,2,3]
	por	%xmm1, %xmm0
	pshufd	$85, %xmm0, %xmm1               # xmm1 = xmm0[1,1,1,1]
	por	%xmm0, %xmm1
	movdqa	%xmm1, %xmm0
	psrld	$16, %xmm0
	por	%xmm1, %xmm0
	movdqa	%xmm0, %xmm1
	psrlw	$8, %xmm1
	por	%xmm0, %xmm1
	movd	%xmm1, %ecx
	cmpq	%rdx, %rax
	je	.LBB63_14
# %bb.9:
	testb	$24, %dl
	je	.LBB63_13
.LBB63_10:
	movq	%rax, %r8
	movq	%rdx, %rax
	andq	$-8, %rax
	movzbl	%cl, %ecx
	movd	%ecx, %xmm0
	.p2align	4, 0x90
.LBB63_11:                              # =>This Inner Loop Header: Depth=1
	movq	(%rsi,%r8), %rcx
	xorq	(%rdi,%r8), %rcx
	movq	%rcx, %xmm1
	por	%xmm1, %xmm0
	addq	$8, %r8
	cmpq	%r8, %rax
	jne	.LBB63_11
# %bb.12:
	pshufd	$85, %xmm0, %xmm1               # xmm1 = xmm0[1,1,1,1]
	por	%xmm0, %xmm1
	movdqa	%xmm1, %xmm0
	psrld	$16, %xmm0
	por	%xmm1, %xmm0
	movdqa	%xmm0, %xmm1
	psrlw	$8, %xmm1
	por	%xmm0, %xmm1
	movd	%xmm1, %ecx
	cmpq	%rdx, %rax
	je	.LBB63_14
	.p2align	4, 0x90
.LBB63_13:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rsi,%rax), %r8d
	xorb	(%rdi,%rax), %r8b
	orb	%r8b, %cl
	incq	%rax
	cmpq	%rax, %rdx
	jne	.LBB63_13
.LBB63_14:
	movzbl	%cl, %eax
	retq
.Lfunc_end63:
	.size	CRYPTO_memcmp, .Lfunc_end63-CRYPTO_memcmp
                                        # -- End function
	.globl	OPENSSL_hash32                  # -- Begin function OPENSSL_hash32
	.p2align	4, 0x90
	.type	OPENSSL_hash32,@function
OPENSSL_hash32:                         # @OPENSSL_hash32
# %bb.0:
	testq	%rsi, %rsi
	je	.LBB64_1
# %bb.2:
	movl	%esi, %ecx
	andl	$3, %ecx
	cmpq	$4, %rsi
	jae	.LBB64_8
# %bb.3:
	movl	$-2128831035, %eax              # imm = 0x811C9DC5
	xorl	%edx, %edx
	jmp	.LBB64_4
.LBB64_1:
	movl	$-2128831035, %eax              # imm = 0x811C9DC5
	retq
.LBB64_8:
	andq	$-4, %rsi
	movl	$-2128831035, %eax              # imm = 0x811C9DC5
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB64_9:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%rdi,%rdx), %r8d
	xorl	%eax, %r8d
	imull	$16777619, %r8d, %eax           # imm = 0x1000193
	movzbl	1(%rdi,%rdx), %r8d
	xorl	%eax, %r8d
	imull	$16777619, %r8d, %eax           # imm = 0x1000193
	movzbl	2(%rdi,%rdx), %r8d
	xorl	%eax, %r8d
	imull	$16777619, %r8d, %eax           # imm = 0x1000193
	movzbl	3(%rdi,%rdx), %r8d
	xorl	%eax, %r8d
	imull	$16777619, %r8d, %eax           # imm = 0x1000193
	addq	$4, %rdx
	cmpq	%rdx, %rsi
	jne	.LBB64_9
.LBB64_4:
	testq	%rcx, %rcx
	je	.LBB64_7
# %bb.5:                                # %.preheader
	addq	%rdx, %rdi
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB64_6:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%rdi,%rdx), %esi
	xorl	%eax, %esi
	imull	$16777619, %esi, %eax           # imm = 0x1000193
	incq	%rdx
	cmpq	%rdx, %rcx
	jne	.LBB64_6
.LBB64_7:
	retq
.Lfunc_end64:
	.size	OPENSSL_hash32, .Lfunc_end64-OPENSSL_hash32
                                        # -- End function
	.globl	OPENSSL_strhash                 # -- Begin function OPENSSL_strhash
	.p2align	4, 0x90
	.type	OPENSSL_strhash,@function
OPENSSL_strhash:                        # @OPENSSL_strhash
# %bb.0:
	pushq	%rbx
	movq	%rdi, %rbx
	callq	strlen@PLT
	testq	%rax, %rax
	je	.LBB65_1
# %bb.2:
	movq	%rax, %rcx
	movl	%ecx, %edx
	andl	$3, %edx
	cmpq	$4, %rax
	jae	.LBB65_4
# %bb.3:
	movl	$-2128831035, %eax              # imm = 0x811C9DC5
	xorl	%esi, %esi
	jmp	.LBB65_6
.LBB65_1:
	movl	$-2128831035, %eax              # imm = 0x811C9DC5
	popq	%rbx
	retq
.LBB65_4:
	andq	$-4, %rcx
	movl	$-2128831035, %eax              # imm = 0x811C9DC5
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB65_5:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%rbx,%rsi), %edi
	xorl	%eax, %edi
	imull	$16777619, %edi, %eax           # imm = 0x1000193
	movzbl	1(%rbx,%rsi), %edi
	xorl	%eax, %edi
	imull	$16777619, %edi, %eax           # imm = 0x1000193
	movzbl	2(%rbx,%rsi), %edi
	xorl	%eax, %edi
	imull	$16777619, %edi, %eax           # imm = 0x1000193
	movzbl	3(%rbx,%rsi), %edi
	xorl	%eax, %edi
	imull	$16777619, %edi, %eax           # imm = 0x1000193
	addq	$4, %rsi
	cmpq	%rsi, %rcx
	jne	.LBB65_5
.LBB65_6:
	testq	%rdx, %rdx
	je	.LBB65_9
# %bb.7:                                # %.preheader
	addq	%rsi, %rbx
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB65_8:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%rbx,%rcx), %esi
	xorl	%eax, %esi
	imull	$16777619, %esi, %eax           # imm = 0x1000193
	incq	%rcx
	cmpq	%rcx, %rdx
	jne	.LBB65_8
.LBB65_9:
	popq	%rbx
	retq
.Lfunc_end65:
	.size	OPENSSL_strhash, .Lfunc_end65-OPENSSL_strhash
                                        # -- End function
	.globl	OPENSSL_strnlen                 # -- Begin function OPENSSL_strnlen
	.p2align	4, 0x90
	.type	OPENSSL_strnlen,@function
OPENSSL_strnlen:                        # @OPENSSL_strnlen
# %bb.0:
	movq	%rsi, %rax
	xorl	%ecx, %ecx
	testq	%rsi, %rsi
	je	.LBB66_4
	.p2align	4, 0x90
.LBB66_1:                               # =>This Inner Loop Header: Depth=1
	cmpb	$0, (%rdi,%rcx)
	je	.LBB66_4
# %bb.2:                                #   in Loop: Header=BB66_1 Depth=1
	incq	%rcx
	cmpq	%rcx, %rax
	jne	.LBB66_1
# %bb.3:
	movq	%rax, %rcx
.LBB66_4:
	cmpq	%rax, %rcx
	cmovbq	%rcx, %rax
	retq
.Lfunc_end66:
	.size	OPENSSL_strnlen, .Lfunc_end66-OPENSSL_strnlen
                                        # -- End function
	.globl	OPENSSL_strdup                  # -- Begin function OPENSSL_strdup
	.p2align	4, 0x90
	.type	OPENSSL_strdup,@function
OPENSSL_strdup:                         # @OPENSSL_strdup
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	testq	%rdi, %rdi
	je	.LBB67_11
# %bb.1:
	movq	%rdi, %rbx
	callq	strlen@PLT
	movq	%rax, %r14
	incq	%r14
	je	.LBB67_11
# %bb.4:
	cmpq	$0, OPENSSL_memory_alloc@GOTPCREL(%rip)
	je	.LBB67_6
# %bb.5:
	movq	%r14, %rdi
	callq	OPENSSL_memory_alloc@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	jne	.LBB67_9
	jmp	.LBB67_10
.LBB67_6:
	cmpq	$-9, %r14
	ja	.LBB67_10
# %bb.7:
	addq	$9, %rax
	movq	%rax, %rdi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB67_10
# %bb.8:
	movq	%rax, %r15
	movq	%r14, (%rax)
	addq	$8, %r15
.LBB67_9:
	movq	%r15, %rdi
	movq	%rbx, %rsi
	movq	%r14, %rdx
	callq	memcpy@PLT
	jmp	.LBB67_12
.LBB67_10:
	leaq	.L.str.8(%rip), %rcx
	movl	$14, %edi
	movl	$65, %edx
	movl	$253, %r8d
	callq	ERR_put_error
.LBB67_11:
	xorl	%r15d, %r15d
.LBB67_12:
	movq	%r15, %rax
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end67:
	.size	OPENSSL_strdup, .Lfunc_end67-OPENSSL_strdup
                                        # -- End function
	.globl	OPENSSL_memdup                  # -- Begin function OPENSSL_memdup
	.p2align	4, 0x90
	.type	OPENSSL_memdup,@function
OPENSSL_memdup:                         # @OPENSSL_memdup
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	testq	%rsi, %rsi
	je	.LBB68_9
# %bb.1:
	movq	%rsi, %rbx
	movq	%rdi, %r14
	cmpq	$0, OPENSSL_memory_alloc@GOTPCREL(%rip)
	je	.LBB68_4
# %bb.2:
	movq	%rbx, %rdi
	callq	OPENSSL_memory_alloc@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	jne	.LBB68_7
	jmp	.LBB68_8
.LBB68_4:
	cmpq	$-9, %rbx
	ja	.LBB68_8
# %bb.5:
	leaq	8(%rbx), %rdi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB68_8
# %bb.6:
	movq	%rax, %r15
	movq	%rbx, (%rax)
	addq	$8, %r15
.LBB68_7:
	movq	%r15, %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	memcpy@PLT
	jmp	.LBB68_10
.LBB68_8:
	leaq	.L.str.8(%rip), %rcx
	movl	$14, %edi
	movl	$65, %edx
	movl	$253, %r8d
	callq	ERR_put_error
.LBB68_9:
	xorl	%r15d, %r15d
.LBB68_10:
	movq	%r15, %rax
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end68:
	.size	OPENSSL_memdup, .Lfunc_end68-OPENSSL_memdup
                                        # -- End function
	.globl	OPENSSL_isalpha                 # -- Begin function OPENSSL_isalpha
	.p2align	4, 0x90
	.type	OPENSSL_isalpha,@function
OPENSSL_isalpha:                        # @OPENSSL_isalpha
# %bb.0:
	andl	$-33, %edi
	addl	$-65, %edi
	xorl	%eax, %eax
	cmpl	$26, %edi
	setb	%al
	retq
.Lfunc_end69:
	.size	OPENSSL_isalpha, .Lfunc_end69-OPENSSL_isalpha
                                        # -- End function
	.globl	OPENSSL_isdigit                 # -- Begin function OPENSSL_isdigit
	.p2align	4, 0x90
	.type	OPENSSL_isdigit,@function
OPENSSL_isdigit:                        # @OPENSSL_isdigit
# %bb.0:
	addl	$-48, %edi
	xorl	%eax, %eax
	cmpl	$10, %edi
	setb	%al
	retq
.Lfunc_end70:
	.size	OPENSSL_isdigit, .Lfunc_end70-OPENSSL_isdigit
                                        # -- End function
	.globl	OPENSSL_isxdigit                # -- Begin function OPENSSL_isxdigit
	.p2align	4, 0x90
	.type	OPENSSL_isxdigit,@function
OPENSSL_isxdigit:                       # @OPENSSL_isxdigit
# %bb.0:
                                        # kill: def $edi killed $edi def $rdi
	leal	-48(%rdi), %eax
	cmpl	$10, %eax
	setb	%al
	andl	$-33, %edi
	addl	$-65, %edi
	cmpl	$6, %edi
	setb	%cl
	orb	%al, %cl
	movzbl	%cl, %eax
	retq
.Lfunc_end71:
	.size	OPENSSL_isxdigit, .Lfunc_end71-OPENSSL_isxdigit
                                        # -- End function
	.globl	OPENSSL_fromxdigit              # -- Begin function OPENSSL_fromxdigit
	.p2align	4, 0x90
	.type	OPENSSL_fromxdigit,@function
OPENSSL_fromxdigit:                     # @OPENSSL_fromxdigit
# %bb.0:
                                        # kill: def $esi killed $esi def $rsi
	leal	-58(%rsi), %eax
	movb	$-48, %cl
	cmpl	$-11, %eax
	ja	.LBB72_3
# %bb.1:
	leal	-97(%rsi), %eax
	movb	$-87, %cl
	cmpl	$6, %eax
	jb	.LBB72_3
# %bb.2:
	leal	-65(%rsi), %edx
	xorl	%eax, %eax
	movb	$-55, %cl
	cmpl	$5, %edx
	ja	.LBB72_4
.LBB72_3:
	addb	%cl, %sil
	movb	%sil, (%rdi)
	movl	$1, %eax
.LBB72_4:
	retq
.Lfunc_end72:
	.size	OPENSSL_fromxdigit, .Lfunc_end72-OPENSSL_fromxdigit
                                        # -- End function
	.globl	OPENSSL_isalnum                 # -- Begin function OPENSSL_isalnum
	.p2align	4, 0x90
	.type	OPENSSL_isalnum,@function
OPENSSL_isalnum:                        # @OPENSSL_isalnum
# %bb.0:
	movl	%edi, %eax
	andl	$-33, %eax
	addl	$-65, %eax
	cmpl	$26, %eax
	setb	%al
	addl	$-48, %edi
	cmpl	$10, %edi
	setb	%cl
	orb	%al, %cl
	movzbl	%cl, %eax
	retq
.Lfunc_end73:
	.size	OPENSSL_isalnum, .Lfunc_end73-OPENSSL_isalnum
                                        # -- End function
	.globl	OPENSSL_tolower                 # -- Begin function OPENSSL_tolower
	.p2align	4, 0x90
	.type	OPENSSL_tolower,@function
OPENSSL_tolower:                        # @OPENSSL_tolower
# %bb.0:
                                        # kill: def $edi killed $edi def $rdi
	leal	-65(%rdi), %ecx
	leal	32(%rdi), %eax
	cmpl	$26, %ecx
	cmovael	%edi, %eax
	retq
.Lfunc_end74:
	.size	OPENSSL_tolower, .Lfunc_end74-OPENSSL_tolower
                                        # -- End function
	.globl	OPENSSL_isspace                 # -- Begin function OPENSSL_isspace
	.p2align	4, 0x90
	.type	OPENSSL_isspace,@function
OPENSSL_isspace:                        # @OPENSSL_isspace
# %bb.0:
                                        # kill: def $edi killed $edi def $rdi
	leal	-9(%rdi), %eax
	cmpl	$5, %eax
	setb	%al
	cmpl	$32, %edi
	sete	%cl
	orb	%al, %cl
	movzbl	%cl, %eax
	retq
.Lfunc_end75:
	.size	OPENSSL_isspace, .Lfunc_end75-OPENSSL_isspace
                                        # -- End function
	.globl	OPENSSL_strcasecmp              # -- Begin function OPENSSL_strcasecmp
	.p2align	4, 0x90
	.type	OPENSSL_strcasecmp,@function
OPENSSL_strcasecmp:                     # @OPENSSL_strcasecmp
# %bb.0:
	movsbl	(%rdi), %eax
	leal	-65(%rax), %edx
	leal	32(%rax), %ecx
	cmpl	$26, %edx
	cmovael	%eax, %ecx
	movsbl	(%rsi), %eax
	leal	-65(%rax), %edx
	leal	32(%rax), %r8d
	cmpl	$26, %edx
	cmovael	%eax, %r8d
	movl	$-1, %eax
	cmpl	%r8d, %ecx
	jl	.LBB76_7
# %bb.1:                                # %.preheader
	movl	$1, %edx
	.p2align	4, 0x90
.LBB76_3:                               # =>This Inner Loop Header: Depth=1
	cmpl	%r8d, %ecx
	jg	.LBB76_4
# %bb.5:                                #   in Loop: Header=BB76_3 Depth=1
	testl	%ecx, %ecx
	je	.LBB76_6
# %bb.2:                                #   in Loop: Header=BB76_3 Depth=1
	movsbl	(%rdi,%rdx), %r8d
	leal	-65(%r8), %r9d
	leal	32(%r8), %ecx
	cmpl	$26, %r9d
	cmovael	%r8d, %ecx
	movsbl	(%rsi,%rdx), %r9d
	leal	-65(%r9), %r10d
	leal	32(%r9), %r8d
	cmpl	$26, %r10d
	cmovael	%r9d, %r8d
	incq	%rdx
	cmpl	%r8d, %ecx
	jge	.LBB76_3
.LBB76_7:
	retq
.LBB76_4:
	movl	$1, %eax
	retq
.LBB76_6:
	xorl	%eax, %eax
	retq
.Lfunc_end76:
	.size	OPENSSL_strcasecmp, .Lfunc_end76-OPENSSL_strcasecmp
                                        # -- End function
	.globl	OPENSSL_strncasecmp             # -- Begin function OPENSSL_strncasecmp
	.p2align	4, 0x90
	.type	OPENSSL_strncasecmp,@function
OPENSSL_strncasecmp:                    # @OPENSSL_strncasecmp
# %bb.0:
	testq	%rdx, %rdx
	je	.LBB77_1
# %bb.2:                                # %.preheader
	decq	%rdx
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB77_3:                               # =>This Inner Loop Header: Depth=1
	movsbl	(%rdi,%rcx), %eax
	leal	-65(%rax), %r9d
	leal	32(%rax), %r8d
	cmpl	$26, %r9d
	cmovael	%eax, %r8d
	movsbl	(%rsi,%rcx), %eax
	leal	-65(%rax), %r9d
	leal	32(%rax), %r10d
	cmpl	$26, %r9d
	cmovael	%eax, %r10d
	cmpl	%r10d, %r8d
	jl	.LBB77_4
# %bb.5:                                #   in Loop: Header=BB77_3 Depth=1
	jg	.LBB77_6
# %bb.7:                                #   in Loop: Header=BB77_3 Depth=1
	xorl	%eax, %eax
	testl	%r8d, %r8d
	je	.LBB77_9
# %bb.8:                                #   in Loop: Header=BB77_3 Depth=1
	leaq	1(%rcx), %r8
	cmpq	%rcx, %rdx
	movq	%r8, %rcx
	jne	.LBB77_3
.LBB77_9:
	retq
.LBB77_1:
	xorl	%eax, %eax
	retq
.LBB77_4:
	movl	$-1, %eax
	retq
.LBB77_6:
	movl	$1, %eax
	retq
.Lfunc_end77:
	.size	OPENSSL_strncasecmp, .Lfunc_end77-OPENSSL_strncasecmp
                                        # -- End function
	.globl	BIO_snprintf                    # -- Begin function BIO_snprintf
	.p2align	4, 0x90
	.type	BIO_snprintf,@function
BIO_snprintf:                           # @BIO_snprintf
# %bb.0:
	subq	$216, %rsp
	movq	%rcx, 56(%rsp)
	movq	%r8, 64(%rsp)
	movq	%r9, 72(%rsp)
	testb	%al, %al
	je	.LBB78_2
# %bb.1:
	movaps	%xmm0, 80(%rsp)
	movaps	%xmm1, 96(%rsp)
	movaps	%xmm2, 112(%rsp)
	movaps	%xmm3, 128(%rsp)
	movaps	%xmm4, 144(%rsp)
	movaps	%xmm5, 160(%rsp)
	movaps	%xmm6, 176(%rsp)
	movaps	%xmm7, 192(%rsp)
.LBB78_2:
	leaq	32(%rsp), %rax
	movq	%rax, 16(%rsp)
	leaq	224(%rsp), %rax
	movq	%rax, 8(%rsp)
	movabsq	$206158430232, %rax             # imm = 0x3000000018
	movq	%rax, (%rsp)
	movq	%rsp, %rcx
	callq	vsnprintf@PLT
	addq	$216, %rsp
	retq
.Lfunc_end78:
	.size	BIO_snprintf, .Lfunc_end78-BIO_snprintf
                                        # -- End function
	.globl	BIO_vsnprintf                   # -- Begin function BIO_vsnprintf
	.p2align	4, 0x90
	.type	BIO_vsnprintf,@function
BIO_vsnprintf:                          # @BIO_vsnprintf
# %bb.0:
	pushq	%rax
	callq	vsnprintf@PLT
	popq	%rcx
	retq
.Lfunc_end79:
	.size	BIO_vsnprintf, .Lfunc_end79-BIO_vsnprintf
                                        # -- End function
	.globl	OPENSSL_vasprintf               # -- Begin function OPENSSL_vasprintf
	.p2align	4, 0x90
	.type	OPENSSL_vasprintf,@function
OPENSSL_vasprintf:                      # @OPENSSL_vasprintf
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rbx
	cmpq	$0, OPENSSL_memory_alloc@GOTPCREL(%rip)
	je	.LBB80_3
# %bb.1:
	movl	$64, %edi
	callq	OPENSSL_memory_alloc@PLT
	movq	%rax, %r14
	testq	%rax, %rax
	jne	.LBB80_5
	jmp	.LBB80_2
.LBB80_3:
	movl	$72, %edi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB80_2
# %bb.4:
	movq	%rax, %r14
	movq	$64, (%rax)
	addq	$8, %r14
.LBB80_5:
	movq	16(%r15), %rax
	movq	%rax, 16(%rsp)
	movups	(%r15), %xmm0
	movaps	%xmm0, (%rsp)
	movl	$64, %r13d
	movq	%rsp, %rcx
	movl	$64, %esi
	movq	%r14, %rdi
	movq	%r12, %rdx
	callq	vsnprintf@PLT
	testl	%eax, %eax
	js	.LBB80_12
# %bb.6:
	cmpl	$64, %eax
	jb	.LBB80_9
# %bb.7:
	movl	%eax, %r13d
	incq	%r13
	movq	%r14, %rdi
	movq	%r13, %rsi
	callq	OPENSSL_realloc
	testq	%rax, %rax
	je	.LBB80_12
# %bb.8:
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	movq	%r15, %rcx
	callq	vsnprintf@PLT
	movq	%rbp, %r14
.LBB80_9:
	testl	%eax, %eax
	js	.LBB80_12
# %bb.10:
	movl	%eax, %ecx
	cmpq	%rcx, %r13
	jbe	.LBB80_12
# %bb.11:
	movq	%r14, (%rbx)
	jmp	.LBB80_20
.LBB80_12:
	cmpq	$0, OPENSSL_memory_free@GOTPCREL(%rip)
	je	.LBB80_14
# %bb.13:
	movq	%r14, %rdi
	callq	OPENSSL_memory_free@PLT
	jmp	.LBB80_19
.LBB80_2:
	leaq	.L.str.8(%rip), %rcx
	movl	$14, %edi
	movl	$65, %edx
	movl	$253, %r8d
	callq	ERR_put_error
	jmp	.LBB80_19
.LBB80_14:
	movq	-8(%r14), %r15
	addq	$-8, %r14
	addq	$8, %r15
	je	.LBB80_16
# %bb.15:
	movq	%r14, %rdi
	xorl	%esi, %esi
	movq	%r15, %rdx
	callq	memset@PLT
.LBB80_16:
	movq	%r14, %rdi
	cmpq	$0, sdallocx@GOTPCREL(%rip)
	je	.LBB80_18
# %bb.17:
	movq	%r15, %rsi
	xorl	%edx, %edx
	callq	sdallocx@PLT
	jmp	.LBB80_19
.LBB80_18:
	callq	free@PLT
.LBB80_19:
	movq	$0, (%rbx)
	callq	__errno_location@PLT
	movl	$12, (%rax)
	movl	$-1, %eax
.LBB80_20:
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end80:
	.size	OPENSSL_vasprintf, .Lfunc_end80-OPENSSL_vasprintf
                                        # -- End function
	.globl	OPENSSL_asprintf                # -- Begin function OPENSSL_asprintf
	.p2align	4, 0x90
	.type	OPENSSL_asprintf,@function
OPENSSL_asprintf:                       # @OPENSSL_asprintf
# %bb.0:
	subq	$216, %rsp
	movq	%rdx, 48(%rsp)
	movq	%rcx, 56(%rsp)
	movq	%r8, 64(%rsp)
	movq	%r9, 72(%rsp)
	testb	%al, %al
	je	.LBB81_2
# %bb.1:
	movaps	%xmm0, 80(%rsp)
	movaps	%xmm1, 96(%rsp)
	movaps	%xmm2, 112(%rsp)
	movaps	%xmm3, 128(%rsp)
	movaps	%xmm4, 144(%rsp)
	movaps	%xmm5, 160(%rsp)
	movaps	%xmm6, 176(%rsp)
	movaps	%xmm7, 192(%rsp)
.LBB81_2:
	leaq	32(%rsp), %rax
	movq	%rax, 16(%rsp)
	leaq	224(%rsp), %rax
	movq	%rax, 8(%rsp)
	movabsq	$206158430224, %rax             # imm = 0x3000000010
	movq	%rax, (%rsp)
	movq	%rsp, %rdx
	callq	OPENSSL_vasprintf
	addq	$216, %rsp
	retq
.Lfunc_end81:
	.size	OPENSSL_asprintf, .Lfunc_end81-OPENSSL_asprintf
                                        # -- End function
	.globl	OPENSSL_strndup                 # -- Begin function OPENSSL_strndup
	.p2align	4, 0x90
	.type	OPENSSL_strndup,@function
OPENSSL_strndup:                        # @OPENSSL_strndup
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	movq	%rdi, %r14
	xorl	%eax, %eax
	testq	%rsi, %rsi
	je	.LBB82_4
	.p2align	4, 0x90
.LBB82_1:                               # =>This Inner Loop Header: Depth=1
	cmpb	$0, (%r14,%rax)
	je	.LBB82_4
# %bb.2:                                #   in Loop: Header=BB82_1 Depth=1
	incq	%rax
	cmpq	%rax, %rbx
	jne	.LBB82_1
# %bb.3:
	movq	%rbx, %rax
.LBB82_4:
	cmpq	%rbx, %rax
	cmovbq	%rax, %rbx
	cmpq	$-1, %rbx
	je	.LBB82_5
# %bb.7:
	leaq	1(%rbx), %r12
	cmpq	$0, OPENSSL_memory_alloc@GOTPCREL(%rip)
	je	.LBB82_10
# %bb.8:
	movq	%r12, %rdi
	callq	OPENSSL_memory_alloc@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	je	.LBB82_9
# %bb.13:
	testq	%rbx, %rbx
	je	.LBB82_15
.LBB82_14:
	movq	%r15, %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	memcpy@PLT
.LBB82_15:
	movb	$0, (%r15,%rbx)
	jmp	.LBB82_16
.LBB82_5:
	leaq	.L.str.8(%rip), %rcx
	movl	$14, %edi
	movl	$65, %edx
	movl	$560, %r8d                      # imm = 0x230
	jmp	.LBB82_6
.LBB82_10:
	cmpq	$-10, %rbx
	ja	.LBB82_9
# %bb.11:
	leaq	9(%rbx), %rdi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB82_9
# %bb.12:
	movq	%rax, %r15
	movq	%r12, (%rax)
	addq	$8, %r15
	testq	%rbx, %rbx
	jne	.LBB82_14
	jmp	.LBB82_15
.LBB82_9:
	leaq	.L.str.8(%rip), %rcx
	movl	$14, %edi
	movl	$65, %edx
	movl	$253, %r8d
.LBB82_6:
	callq	ERR_put_error
	xorl	%r15d, %r15d
.LBB82_16:
	movq	%r15, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end82:
	.size	OPENSSL_strndup, .Lfunc_end82-OPENSSL_strndup
                                        # -- End function
	.globl	OPENSSL_strlcpy                 # -- Begin function OPENSSL_strlcpy
	.p2align	4, 0x90
	.type	OPENSSL_strlcpy,@function
OPENSSL_strlcpy:                        # @OPENSSL_strlcpy
# %bb.0:
	pushq	%rbx
	movq	%rdx, %rbx
	cmpq	$2, %rdx
	jb	.LBB83_8
# %bb.1:
	decq	%rbx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB83_2:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%rsi,%rax), %ecx
	testb	%cl, %cl
	je	.LBB83_5
# %bb.3:                                #   in Loop: Header=BB83_2 Depth=1
	movb	%cl, (%rdi,%rax)
	incq	%rax
	cmpq	%rax, %rbx
	jne	.LBB83_2
# %bb.4:                                # %.loopexitsplit
	addq	%rax, %rsi
	addq	%rax, %rdi
	jmp	.LBB83_6
.LBB83_8:
	testq	%rbx, %rbx
	movl	$0, %ebx
	jne	.LBB83_6
	jmp	.LBB83_7
.LBB83_5:                               # %..loopexit_crit_edge
	addq	%rax, %rsi
	addq	%rax, %rdi
	movq	%rax, %rbx
.LBB83_6:
	movb	$0, (%rdi)
.LBB83_7:
	movq	%rsi, %rdi
	callq	strlen@PLT
	addq	%rbx, %rax
	popq	%rbx
	retq
.Lfunc_end83:
	.size	OPENSSL_strlcpy, .Lfunc_end83-OPENSSL_strlcpy
                                        # -- End function
	.globl	OPENSSL_strlcat                 # -- Begin function OPENSSL_strlcat
	.p2align	4, 0x90
	.type	OPENSSL_strlcat,@function
OPENSSL_strlcat:                        # @OPENSSL_strlcat
# %bb.0:
	pushq	%rbx
	testq	%rdx, %rdx
	je	.LBB84_1
# %bb.2:                                # %.preheader
	xorl	%eax, %eax
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB84_3:                               # =>This Inner Loop Header: Depth=1
	cmpb	$0, (%rdi,%rbx)
	je	.LBB84_6
# %bb.4:                                #   in Loop: Header=BB84_3 Depth=1
	incq	%rbx
	cmpq	%rbx, %rdx
	jne	.LBB84_3
# %bb.5:
	movq	%rdx, %rbx
	jmp	.LBB84_14
.LBB84_1:
	xorl	%ebx, %ebx
	xorl	%eax, %eax
	jmp	.LBB84_14
.LBB84_6:
	movq	%rdx, %rax
	subq	%rbx, %rax
	cmpq	$2, %rax
	jb	.LBB84_7
# %bb.8:
	movq	%rbx, %rax
	notq	%rax
	addq	%rdx, %rax
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB84_9:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%rsi,%rcx), %edx
	testb	%dl, %dl
	je	.LBB84_12
# %bb.10:                               #   in Loop: Header=BB84_9 Depth=1
	leaq	(%rdi,%rcx), %r8
	movb	%dl, (%r8,%rbx)
	incq	%rcx
	cmpq	%rcx, %rax
	jne	.LBB84_9
# %bb.11:                               # %.loopexitsplit
	addq	%rcx, %rsi
	addq	%rbx, %rdi
	addq	%rcx, %rdi
	jmp	.LBB84_13
.LBB84_7:
	addq	%rbx, %rdi
	xorl	%eax, %eax
	jmp	.LBB84_13
.LBB84_12:                              # %..loopexit_crit_edge
	addq	%rcx, %rsi
	addq	%rbx, %rdi
	addq	%rcx, %rdi
	movq	%rcx, %rax
.LBB84_13:
	movb	$0, (%rdi)
.LBB84_14:
	addq	%rax, %rbx
	movq	%rsi, %rdi
	callq	strlen@PLT
	addq	%rbx, %rax
	popq	%rbx
	retq
.Lfunc_end84:
	.size	OPENSSL_strlcat, .Lfunc_end84-OPENSSL_strlcat
                                        # -- End function
	.globl	CRYPTO_malloc                   # -- Begin function CRYPTO_malloc
	.p2align	4, 0x90
	.type	CRYPTO_malloc,@function
CRYPTO_malloc:                          # @CRYPTO_malloc
# %bb.0:
	pushq	%rbx
	movq	%rdi, %rbx
	cmpq	$0, OPENSSL_memory_alloc@GOTPCREL(%rip)
	je	.LBB85_4
# %bb.1:
	movq	%rbx, %rdi
	callq	OPENSSL_memory_alloc@PLT
	testq	%rbx, %rbx
	je	.LBB85_7
# %bb.2:
	testq	%rax, %rax
	je	.LBB85_3
.LBB85_7:
	popq	%rbx
	retq
.LBB85_4:
	cmpq	$-9, %rbx
	ja	.LBB85_3
# %bb.5:
	leaq	8(%rbx), %rdi
	callq	malloc@PLT
	testq	%rax, %rax
	je	.LBB85_3
# %bb.6:
	movq	%rbx, (%rax)
	addq	$8, %rax
	popq	%rbx
	retq
.LBB85_3:
	leaq	.L.str.8(%rip), %rcx
	movl	$14, %edi
	movl	$65, %edx
	movl	$253, %r8d
	callq	ERR_put_error
	xorl	%eax, %eax
	popq	%rbx
	retq
.Lfunc_end85:
	.size	CRYPTO_malloc, .Lfunc_end85-CRYPTO_malloc
                                        # -- End function
	.globl	CRYPTO_realloc                  # -- Begin function CRYPTO_realloc
	.p2align	4, 0x90
	.type	CRYPTO_realloc,@function
CRYPTO_realloc:                         # @CRYPTO_realloc
# %bb.0:
	pushq	%rax
	callq	OPENSSL_realloc
	popq	%rcx
	retq
.Lfunc_end86:
	.size	CRYPTO_realloc, .Lfunc_end86-CRYPTO_realloc
                                        # -- End function
	.globl	CRYPTO_free                     # -- Begin function CRYPTO_free
	.p2align	4, 0x90
	.type	CRYPTO_free,@function
CRYPTO_free:                            # @CRYPTO_free
# %bb.0:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	testq	%rdi, %rdi
	je	.LBB87_8
# %bb.1:
	movq	%rdi, %rbx
	cmpq	$0, OPENSSL_memory_free@GOTPCREL(%rip)
	je	.LBB87_3
# %bb.2:
	movq	%rbx, %rdi
	callq	OPENSSL_memory_free@PLT
	jmp	.LBB87_8
.LBB87_3:
	movq	-8(%rbx), %r14
	addq	$-8, %rbx
	addq	$8, %r14
	je	.LBB87_5
# %bb.4:
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
.LBB87_5:
	movq	%rbx, %rdi
	cmpq	$0, sdallocx@GOTPCREL(%rip)
	je	.LBB87_7
# %bb.6:
	movq	%r14, %rsi
	xorl	%edx, %edx
	callq	sdallocx@PLT
	jmp	.LBB87_8
.LBB87_7:
	callq	free@PLT
.LBB87_8:
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end87:
	.size	CRYPTO_free, .Lfunc_end87-CRYPTO_free
                                        # -- End function
	.globl	SHA384_Init                     # -- Begin function SHA384_Init
	.p2align	4, 0x90
	.type	SHA384_Init,@function
SHA384_Init:                            # @SHA384_Init
# %bb.0:
	movabsq	$-3766243637369397544, %rax     # imm = 0xCBBB9D5DC1059ED8
	movq	%rax, (%rdi)
	movabsq	$7105036623409894663, %rax      # imm = 0x629A292A367CD507
	movq	%rax, 8(%rdi)
	movabsq	$-7973340178411365097, %rax     # imm = 0x9159015A3070DD17
	movq	%rax, 16(%rdi)
	movabsq	$1526699215303891257, %rax      # imm = 0x152FECD8F70E5939
	movq	%rax, 24(%rdi)
	movabsq	$7436329637833083697, %rax      # imm = 0x67332667FFC00B31
	movq	%rax, 32(%rdi)
	movabsq	$-8163818279084223215, %rax     # imm = 0x8EB44A8768581511
	movq	%rax, 40(%rdi)
	movabsq	$-2662702644619276377, %rax     # imm = 0xDB0C2E0D64F98FA7
	movq	%rax, 48(%rdi)
	movabsq	$5167115440072839076, %rax      # imm = 0x47B5481DBEFA4FA4
	movq	%rax, 56(%rdi)
	movabsq	$206158430208, %rax             # imm = 0x3000000000
	movq	%rax, 208(%rdi)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 64(%rdi)
	movl	$1, %eax
	retq
.Lfunc_end88:
	.size	SHA384_Init, .Lfunc_end88-SHA384_Init
                                        # -- End function
	.globl	SHA512_Init                     # -- Begin function SHA512_Init
	.p2align	4, 0x90
	.type	SHA512_Init,@function
SHA512_Init:                            # @SHA512_Init
# %bb.0:
	movabsq	$7640891576956012808, %rax      # imm = 0x6A09E667F3BCC908
	movq	%rax, (%rdi)
	movabsq	$-4942790177534073029, %rax     # imm = 0xBB67AE8584CAA73B
	movq	%rax, 8(%rdi)
	movabsq	$4354685564936845355, %rax      # imm = 0x3C6EF372FE94F82B
	movq	%rax, 16(%rdi)
	movabsq	$-6534734903238641935, %rax     # imm = 0xA54FF53A5F1D36F1
	movq	%rax, 24(%rdi)
	movabsq	$5840696475078001361, %rax      # imm = 0x510E527FADE682D1
	movq	%rax, 32(%rdi)
	movabsq	$-7276294671716946913, %rax     # imm = 0x9B05688C2B3E6C1F
	movq	%rax, 40(%rdi)
	movabsq	$2270897969802886507, %rax      # imm = 0x1F83D9ABFB41BD6B
	movq	%rax, 48(%rdi)
	movabsq	$6620516959819538809, %rax      # imm = 0x5BE0CD19137E2179
	movq	%rax, 56(%rdi)
	movabsq	$274877906944, %rax             # imm = 0x4000000000
	movq	%rax, 208(%rdi)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 64(%rdi)
	movl	$1, %eax
	retq
.Lfunc_end89:
	.size	SHA512_Init, .Lfunc_end89-SHA512_Init
                                        # -- End function
	.globl	SHA512_256_Init                 # -- Begin function SHA512_256_Init
	.p2align	4, 0x90
	.type	SHA512_256_Init,@function
SHA512_256_Init:                        # @SHA512_256_Init
# %bb.0:
	movabsq	$2463787394917988140, %rax      # imm = 0x22312194FC2BF72C
	movq	%rax, (%rdi)
	movabsq	$-6965556091613846334, %rax     # imm = 0x9F555FA3C84C64C2
	movq	%rax, 8(%rdi)
	movabsq	$2563595384472711505, %rax      # imm = 0x2393B86B6F53B151
	movq	%rax, 16(%rdi)
	movabsq	$-7622211418569250115, %rax     # imm = 0x963877195940EABD
	movq	%rax, 24(%rdi)
	movabsq	$-7626776825740460061, %rax     # imm = 0x96283EE2A88EFFE3
	movq	%rax, 32(%rdi)
	movabsq	$-4729309413028513390, %rax     # imm = 0xBE5E1E2553863992
	movq	%rax, 40(%rdi)
	movabsq	$3098927326965381290, %rax      # imm = 0x2B0199FC2C85B8AA
	movq	%rax, 48(%rdi)
	movabsq	$1060366662362279074, %rax      # imm = 0xEB72DDC81C52CA2
	movq	%rax, 56(%rdi)
	movabsq	$137438953472, %rax             # imm = 0x2000000000
	movq	%rax, 208(%rdi)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 64(%rdi)
	movl	$1, %eax
	retq
.Lfunc_end90:
	.size	SHA512_256_Init, .Lfunc_end90-SHA512_256_Init
                                        # -- End function
	.globl	SHA384                          # -- Begin function SHA384
	.p2align	4, 0x90
	.type	SHA384,@function
SHA384:                                 # @SHA384
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$224, %rsp
	movq	%rdx, %rbx
	movabsq	$-3766243637369397544, %rax     # imm = 0xCBBB9D5DC1059ED8
	movq	%rax, 8(%rsp)
	movabsq	$7105036623409894663, %rax      # imm = 0x629A292A367CD507
	movq	%rax, 16(%rsp)
	movabsq	$-7973340178411365097, %rax     # imm = 0x9159015A3070DD17
	movq	%rax, 24(%rsp)
	movabsq	$1526699215303891257, %rax      # imm = 0x152FECD8F70E5939
	movq	%rax, 32(%rsp)
	movabsq	$7436329637833083697, %rax      # imm = 0x67332667FFC00B31
	movq	%rax, 40(%rsp)
	movabsq	$-8163818279084223215, %rax     # imm = 0x8EB44A8768581511
	movq	%rax, 48(%rsp)
	movabsq	$-2662702644619276377, %rax     # imm = 0xDB0C2E0D64F98FA7
	movq	%rax, 56(%rsp)
	movabsq	$5167115440072839076, %rax      # imm = 0x47B5481DBEFA4FA4
	movq	%rax, 64(%rsp)
	movabsq	$206158430208, %rax             # imm = 0x3000000000
	movq	%rax, 216(%rsp)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 72(%rsp)
	leaq	88(%rsp), %r14
	testq	%rsi, %rsi
	je	.LBB91_1
# %bb.2:
	movq	%rsi, %r12
	movq	%rdi, %r15
	leaq	(,%rsi,8), %rax
	movq	%rsi, %rcx
	shrq	$61, %rcx
	movq	%rcx, 80(%rsp)
	movq	%rax, 72(%rsp)
	cmpq	$128, %rsi
	jb	.LBB91_3
# %bb.4:
	movq	%r12, %rdx
	shrq	$7, %rdx
	leaq	8(%rsp), %rdi
	movq	%r15, %rsi
	callq	sha512_block_data_order
	movl	%r12d, %r13d
	andl	$127, %r13d
	je	.LBB91_16
# %bb.5:
	addq	%r12, %r15
	subq	%r13, %r15
	jmp	.LBB91_6
.LBB91_1:
	movb	$-128, 88(%rsp)
	movl	$1, %edi
	jmp	.LBB91_12
.LBB91_3:
	movq	%r12, %r13
.LBB91_6:
	movq	%r14, %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	memcpy@PLT
	movl	%r13d, 216(%rsp)
	jmp	.LBB91_7
.LBB91_16:
	movl	216(%rsp), %r13d
.LBB91_7:
	movl	%r13d, %eax
	movb	$-128, 88(%rsp,%rax)
	leaq	1(%rax), %rdi
	cmpl	$112, %r13d
	jb	.LBB91_11
# %bb.8:
	cmpl	$127, %eax
	je	.LBB91_10
# %bb.9:
	movl	$127, %edx
	subq	%rax, %rdx
	addq	%r14, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB91_10:
	leaq	8(%rsp), %rdi
	movl	$1, %edx
	movq	%r14, %rsi
	callq	sha512_block_data_order
	xorl	%edi, %edi
	jmp	.LBB91_12
.LBB91_11:
	cmpq	$112, %rdi
	je	.LBB91_13
.LBB91_12:
	movl	$112, %edx
	subq	%rdi, %rdx
	addq	%r14, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB91_13:
	movq	72(%rsp), %rax
	movq	80(%rsp), %rcx
	bswapq	%rcx
	movq	%rcx, 200(%rsp)
	bswapq	%rax
	movq	%rax, 208(%rsp)
	leaq	8(%rsp), %rdi
	movl	$1, %edx
	movq	%r14, %rsi
	callq	sha512_block_data_order
	testq	%rbx, %rbx
	je	.LBB91_15
# %bb.14:
	movq	8(%rsp), %rax
	bswapq	%rax
	movq	%rax, (%rbx)
	movq	16(%rsp), %rax
	bswapq	%rax
	movq	%rax, 8(%rbx)
	movq	24(%rsp), %rax
	bswapq	%rax
	movq	%rax, 16(%rbx)
	movq	32(%rsp), %rax
	bswapq	%rax
	movq	%rax, 24(%rbx)
	movq	40(%rsp), %rax
	bswapq	%rax
	movq	%rax, 32(%rbx)
	movq	48(%rsp), %rax
	bswapq	%rax
	movq	%rax, 40(%rbx)
.LBB91_15:
	movq	%rbx, %rax
	addq	$224, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end91:
	.size	SHA384, .Lfunc_end91-SHA384
                                        # -- End function
	.globl	SHA384_Update                   # -- Begin function SHA384_Update
	.p2align	4, 0x90
	.type	SHA384_Update,@function
SHA384_Update:                          # @SHA384_Update
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	testq	%rdx, %rdx
	je	.LBB92_12
# %bb.1:
	movq	%rdx, %rbx
	movq	%rsi, %r15
	movq	%rdi, %r14
	leaq	(,%rdx,8), %rax
	movq	%rdx, %rcx
	shrq	$61, %rcx
	addq	%rax, 64(%rdi)
	adcq	%rcx, 72(%rdi)
	leaq	80(%rdi), %r12
	movl	208(%rdi), %edi
	testq	%rdi, %rdi
	je	.LBB92_7
# %bb.2:
	movl	$128, %r13d
	subq	%rdi, %r13
	cmpq	%rbx, %r13
	jbe	.LBB92_4
# %bb.3:
	addq	%rdi, %r12
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	memcpy@PLT
	addl	208(%r14), %ebx
	jmp	.LBB92_11
.LBB92_4:
	cmpl	$128, %edi
	je	.LBB92_6
# %bb.5:
	addq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	memcpy@PLT
.LBB92_6:
	movl	$0, 208(%r14)
	subq	%r13, %rbx
	addq	%r13, %r15
	movl	$1, %edx
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	sha512_block_data_order
.LBB92_7:
	cmpq	$128, %rbx
	jb	.LBB92_9
# %bb.8:
	movq	%rbx, %rdx
	shrq	$7, %rdx
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	sha512_block_data_order
	addq	%rbx, %r15
	andl	$127, %ebx
	subq	%rbx, %r15
.LBB92_9:
	testq	%rbx, %rbx
	je	.LBB92_12
# %bb.10:
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	memcpy@PLT
.LBB92_11:
	movl	%ebx, 208(%r14)
.LBB92_12:
	movl	$1, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end92:
	.size	SHA384_Update, .Lfunc_end92-SHA384_Update
                                        # -- End function
	.globl	SHA384_Final                    # -- Begin function SHA384_Final
	.p2align	4, 0x90
	.type	SHA384_Final,@function
SHA384_Final:                           # @SHA384_Final
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	%rsi, %r14
	movq	%rdi, %rbx
	leaq	80(%rsi), %r15
	movl	208(%rsi), %eax
	leaq	1(%rax), %rdi
	movb	$-128, 80(%rsi,%rax)
	cmpq	$112, %rax
	jb	.LBB93_4
# %bb.1:
	cmpl	$127, %eax
	je	.LBB93_3
# %bb.2:
	movl	$127, %edx
	subq	%rax, %rdx
	addq	%r15, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB93_3:
	movl	$1, %edx
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	sha512_block_data_order
	xorl	%edi, %edi
	jmp	.LBB93_5
.LBB93_4:
	cmpq	$112, %rdi
	je	.LBB93_6
.LBB93_5:
	movl	$112, %edx
	subq	%rdi, %rdx
	addq	%r15, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB93_6:
	movq	64(%r14), %rax
	movq	72(%r14), %rcx
	bswapq	%rcx
	movq	%rcx, 192(%r14)
	bswapq	%rax
	movq	%rax, 200(%r14)
	movl	$1, %edx
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	sha512_block_data_order
	testq	%rbx, %rbx
	je	.LBB93_7
# %bb.8:
	movq	(%r14), %rax
	bswapq	%rax
	movq	%rax, (%rbx)
	movq	8(%r14), %rax
	bswapq	%rax
	movq	%rax, 8(%rbx)
	movq	16(%r14), %rax
	bswapq	%rax
	movq	%rax, 16(%rbx)
	movq	24(%r14), %rax
	bswapq	%rax
	movq	%rax, 24(%rbx)
	movq	32(%r14), %rax
	bswapq	%rax
	movq	%rax, 32(%rbx)
	movq	40(%r14), %rax
	bswapq	%rax
	movq	%rax, 40(%rbx)
	movl	$1, %eax
	jmp	.LBB93_9
.LBB93_7:
	xorl	%eax, %eax
.LBB93_9:
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end93:
	.size	SHA384_Final, .Lfunc_end93-SHA384_Final
                                        # -- End function
	.globl	SHA512                          # -- Begin function SHA512
	.p2align	4, 0x90
	.type	SHA512,@function
SHA512:                                 # @SHA512
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$224, %rsp
	movq	%rdx, %rbx
	movabsq	$7640891576956012808, %rax      # imm = 0x6A09E667F3BCC908
	movq	%rax, 8(%rsp)
	movabsq	$-4942790177534073029, %rax     # imm = 0xBB67AE8584CAA73B
	movq	%rax, 16(%rsp)
	movabsq	$4354685564936845355, %rax      # imm = 0x3C6EF372FE94F82B
	movq	%rax, 24(%rsp)
	movabsq	$-6534734903238641935, %rax     # imm = 0xA54FF53A5F1D36F1
	movq	%rax, 32(%rsp)
	movabsq	$5840696475078001361, %rax      # imm = 0x510E527FADE682D1
	movq	%rax, 40(%rsp)
	movabsq	$-7276294671716946913, %rax     # imm = 0x9B05688C2B3E6C1F
	movq	%rax, 48(%rsp)
	movabsq	$2270897969802886507, %rax      # imm = 0x1F83D9ABFB41BD6B
	movq	%rax, 56(%rsp)
	movabsq	$6620516959819538809, %rax      # imm = 0x5BE0CD19137E2179
	movq	%rax, 64(%rsp)
	movabsq	$274877906944, %rax             # imm = 0x4000000000
	movq	%rax, 216(%rsp)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 72(%rsp)
	leaq	88(%rsp), %r14
	testq	%rsi, %rsi
	je	.LBB94_1
# %bb.2:
	movq	%rsi, %r12
	movq	%rdi, %r15
	leaq	(,%rsi,8), %rax
	movq	%rsi, %rcx
	shrq	$61, %rcx
	movq	%rcx, 80(%rsp)
	movq	%rax, 72(%rsp)
	cmpq	$128, %rsi
	jb	.LBB94_3
# %bb.4:
	movq	%r12, %rdx
	shrq	$7, %rdx
	leaq	8(%rsp), %rdi
	movq	%r15, %rsi
	callq	sha512_block_data_order
	movl	%r12d, %r13d
	andl	$127, %r13d
	je	.LBB94_23
# %bb.5:
	addq	%r12, %r15
	subq	%r13, %r15
	jmp	.LBB94_6
.LBB94_1:
	movl	220(%rsp), %r15d
	movb	$-128, 88(%rsp)
	movl	$1, %edi
	jmp	.LBB94_12
.LBB94_3:
	movq	%r12, %r13
.LBB94_6:
	movq	%r14, %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	memcpy@PLT
	movl	%r13d, 216(%rsp)
	jmp	.LBB94_7
.LBB94_23:
	movl	216(%rsp), %r13d
.LBB94_7:
	movl	220(%rsp), %r15d
	movl	%r13d, %eax
	movb	$-128, 88(%rsp,%rax)
	leaq	1(%rax), %rdi
	cmpl	$112, %r13d
	jb	.LBB94_11
# %bb.8:
	cmpl	$127, %eax
	je	.LBB94_10
# %bb.9:
	movl	$127, %edx
	subq	%rax, %rdx
	addq	%r14, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB94_10:
	leaq	8(%rsp), %rdi
	movl	$1, %edx
	movq	%r14, %rsi
	callq	sha512_block_data_order
	xorl	%edi, %edi
	jmp	.LBB94_12
.LBB94_11:
	cmpq	$112, %rdi
	je	.LBB94_13
.LBB94_12:
	movl	$112, %edx
	subq	%rdi, %rdx
	addq	%r14, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB94_13:
	movq	72(%rsp), %rax
	movq	80(%rsp), %rcx
	bswapq	%rcx
	movq	%rcx, 200(%rsp)
	bswapq	%rax
	movq	%rax, 208(%rsp)
	leaq	8(%rsp), %rdi
	movl	$1, %edx
	movq	%r14, %rsi
	callq	sha512_block_data_order
	testq	%rbx, %rbx
	je	.LBB94_22
# %bb.14:
	cmpl	$8, %r15d
	jb	.LBB94_22
# %bb.15:
	shrl	$3, %r15d
	leaq	-1(%r15), %rcx
	movl	%r15d, %eax
	andl	$3, %eax
	cmpq	$3, %rcx
	jae	.LBB94_17
# %bb.16:
	xorl	%edx, %edx
	movq	%rbx, %rcx
	jmp	.LBB94_19
.LBB94_17:
	andl	$-4, %r15d
	xorl	%edx, %edx
	movq	%rbx, %rcx
	.p2align	4, 0x90
.LBB94_18:                              # =>This Inner Loop Header: Depth=1
	movq	8(%rsp,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, (%rcx)
	movq	16(%rsp,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, 8(%rcx)
	movq	24(%rsp,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, 16(%rcx)
	movq	32(%rsp,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, 24(%rcx)
	addq	$32, %rcx
	addq	$4, %rdx
	cmpq	%rdx, %r15
	jne	.LBB94_18
.LBB94_19:
	testq	%rax, %rax
	je	.LBB94_22
# %bb.20:                               # %.preheader
	leaq	(%rsp,%rdx,8), %rdx
	addq	$8, %rdx
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB94_21:                              # =>This Inner Loop Header: Depth=1
	movq	(%rdx,%rsi,8), %rdi
	bswapq	%rdi
	movq	%rdi, (%rcx,%rsi,8)
	incq	%rsi
	cmpq	%rsi, %rax
	jne	.LBB94_21
.LBB94_22:
	movq	%rbx, %rax
	addq	$224, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end94:
	.size	SHA512, .Lfunc_end94-SHA512
                                        # -- End function
	.globl	SHA512_Update                   # -- Begin function SHA512_Update
	.p2align	4, 0x90
	.type	SHA512_Update,@function
SHA512_Update:                          # @SHA512_Update
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	testq	%rdx, %rdx
	je	.LBB95_12
# %bb.1:
	movq	%rdx, %rbx
	movq	%rsi, %r15
	movq	%rdi, %r14
	leaq	(,%rdx,8), %rax
	movq	%rdx, %rcx
	shrq	$61, %rcx
	addq	%rax, 64(%rdi)
	adcq	%rcx, 72(%rdi)
	leaq	80(%rdi), %r12
	movl	208(%rdi), %edi
	testq	%rdi, %rdi
	je	.LBB95_7
# %bb.2:
	movl	$128, %r13d
	subq	%rdi, %r13
	cmpq	%rbx, %r13
	jbe	.LBB95_4
# %bb.3:
	addq	%rdi, %r12
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	memcpy@PLT
	addl	208(%r14), %ebx
	jmp	.LBB95_11
.LBB95_4:
	cmpl	$128, %edi
	je	.LBB95_6
# %bb.5:
	addq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	memcpy@PLT
.LBB95_6:
	movl	$0, 208(%r14)
	subq	%r13, %rbx
	addq	%r13, %r15
	movl	$1, %edx
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	sha512_block_data_order
.LBB95_7:
	cmpq	$128, %rbx
	jb	.LBB95_9
# %bb.8:
	movq	%rbx, %rdx
	shrq	$7, %rdx
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	sha512_block_data_order
	addq	%rbx, %r15
	andl	$127, %ebx
	subq	%rbx, %r15
.LBB95_9:
	testq	%rbx, %rbx
	je	.LBB95_12
# %bb.10:
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	memcpy@PLT
.LBB95_11:
	movl	%ebx, 208(%r14)
.LBB95_12:
	movl	$1, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end95:
	.size	SHA512_Update, .Lfunc_end95-SHA512_Update
                                        # -- End function
	.globl	SHA512_Final                    # -- Begin function SHA512_Final
	.p2align	4, 0x90
	.type	SHA512_Final,@function
SHA512_Final:                           # @SHA512_Final
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %r14
	movq	%rdi, %rbx
	movl	208(%rsi), %eax
	movl	212(%rsi), %r12d
	leaq	80(%rsi), %r15
	leaq	1(%rax), %rdi
	movb	$-128, 80(%rsi,%rax)
	cmpq	$112, %rax
	jb	.LBB96_4
# %bb.1:
	cmpl	$127, %eax
	je	.LBB96_3
# %bb.2:
	movl	$127, %edx
	subq	%rax, %rdx
	addq	%r15, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB96_3:
	movl	$1, %edx
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	sha512_block_data_order
	xorl	%edi, %edi
	jmp	.LBB96_5
.LBB96_4:
	cmpq	$112, %rdi
	je	.LBB96_6
.LBB96_5:
	movl	$112, %edx
	subq	%rdi, %rdx
	addq	%r15, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB96_6:
	movq	64(%r14), %rax
	movq	72(%r14), %rcx
	bswapq	%rcx
	movq	%rcx, 192(%r14)
	bswapq	%rax
	movq	%rax, 200(%r14)
	movl	$1, %edx
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	sha512_block_data_order
	testq	%rbx, %rbx
	je	.LBB96_7
# %bb.8:
	movl	$1, %eax
	cmpl	$8, %r12d
	jb	.LBB96_16
# %bb.9:
	shrq	$3, %r12
	leaq	-1(%r12), %rdx
	movl	%r12d, %ecx
	andl	$3, %ecx
	cmpq	$3, %rdx
	jae	.LBB96_11
# %bb.10:
	xorl	%edx, %edx
	jmp	.LBB96_13
.LBB96_7:
	xorl	%eax, %eax
	jmp	.LBB96_16
.LBB96_11:
	andl	$-4, %r12d
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB96_12:                              # =>This Inner Loop Header: Depth=1
	movq	(%r14,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, (%rbx)
	movq	8(%r14,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, 8(%rbx)
	movq	16(%r14,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, 16(%rbx)
	movq	24(%r14,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, 24(%rbx)
	addq	$32, %rbx
	addq	$4, %rdx
	cmpq	%rdx, %r12
	jne	.LBB96_12
.LBB96_13:
	testq	%rcx, %rcx
	je	.LBB96_16
# %bb.14:                               # %.preheader
	leaq	(%r14,%rdx,8), %rdx
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB96_15:                              # =>This Inner Loop Header: Depth=1
	movq	(%rdx,%rsi,8), %rdi
	bswapq	%rdi
	movq	%rdi, (%rbx,%rsi,8)
	incq	%rsi
	cmpq	%rsi, %rcx
	jne	.LBB96_15
.LBB96_16:
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end96:
	.size	SHA512_Final, .Lfunc_end96-SHA512_Final
                                        # -- End function
	.globl	SHA512_256                      # -- Begin function SHA512_256
	.p2align	4, 0x90
	.type	SHA512_256,@function
SHA512_256:                             # @SHA512_256
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$224, %rsp
	movq	%rdx, %rbx
	movabsq	$2463787394917988140, %rax      # imm = 0x22312194FC2BF72C
	movq	%rax, 8(%rsp)
	movabsq	$-6965556091613846334, %rax     # imm = 0x9F555FA3C84C64C2
	movq	%rax, 16(%rsp)
	movabsq	$2563595384472711505, %rax      # imm = 0x2393B86B6F53B151
	movq	%rax, 24(%rsp)
	movabsq	$-7622211418569250115, %rax     # imm = 0x963877195940EABD
	movq	%rax, 32(%rsp)
	movabsq	$-7626776825740460061, %rax     # imm = 0x96283EE2A88EFFE3
	movq	%rax, 40(%rsp)
	movabsq	$-4729309413028513390, %rax     # imm = 0xBE5E1E2553863992
	movq	%rax, 48(%rsp)
	movabsq	$3098927326965381290, %rax      # imm = 0x2B0199FC2C85B8AA
	movq	%rax, 56(%rsp)
	movabsq	$1060366662362279074, %rax      # imm = 0xEB72DDC81C52CA2
	movq	%rax, 64(%rsp)
	movabsq	$137438953472, %rax             # imm = 0x2000000000
	movq	%rax, 216(%rsp)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 72(%rsp)
	leaq	88(%rsp), %r14
	testq	%rsi, %rsi
	je	.LBB97_1
# %bb.2:
	movq	%rsi, %r12
	movq	%rdi, %r15
	leaq	(,%rsi,8), %rax
	movq	%rsi, %rcx
	shrq	$61, %rcx
	movq	%rcx, 80(%rsp)
	movq	%rax, 72(%rsp)
	cmpq	$128, %rsi
	jb	.LBB97_3
# %bb.4:
	movq	%r12, %rdx
	shrq	$7, %rdx
	leaq	8(%rsp), %rdi
	movq	%r15, %rsi
	callq	sha512_block_data_order
	movl	%r12d, %r13d
	andl	$127, %r13d
	je	.LBB97_16
# %bb.5:
	addq	%r12, %r15
	subq	%r13, %r15
	jmp	.LBB97_6
.LBB97_1:
	movb	$-128, 88(%rsp)
	movl	$1, %edi
	jmp	.LBB97_12
.LBB97_3:
	movq	%r12, %r13
.LBB97_6:
	movq	%r14, %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	memcpy@PLT
	movl	%r13d, 216(%rsp)
	jmp	.LBB97_7
.LBB97_16:
	movl	216(%rsp), %r13d
.LBB97_7:
	movl	%r13d, %eax
	movb	$-128, 88(%rsp,%rax)
	leaq	1(%rax), %rdi
	cmpl	$112, %r13d
	jb	.LBB97_11
# %bb.8:
	cmpl	$127, %eax
	je	.LBB97_10
# %bb.9:
	movl	$127, %edx
	subq	%rax, %rdx
	addq	%r14, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB97_10:
	leaq	8(%rsp), %rdi
	movl	$1, %edx
	movq	%r14, %rsi
	callq	sha512_block_data_order
	xorl	%edi, %edi
	jmp	.LBB97_12
.LBB97_11:
	cmpq	$112, %rdi
	je	.LBB97_13
.LBB97_12:
	movl	$112, %edx
	subq	%rdi, %rdx
	addq	%r14, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB97_13:
	movq	72(%rsp), %rax
	movq	80(%rsp), %rcx
	bswapq	%rcx
	movq	%rcx, 200(%rsp)
	bswapq	%rax
	movq	%rax, 208(%rsp)
	leaq	8(%rsp), %rdi
	movl	$1, %edx
	movq	%r14, %rsi
	callq	sha512_block_data_order
	testq	%rbx, %rbx
	je	.LBB97_15
# %bb.14:
	movq	8(%rsp), %rax
	bswapq	%rax
	movq	%rax, (%rbx)
	movq	16(%rsp), %rax
	bswapq	%rax
	movq	%rax, 8(%rbx)
	movq	24(%rsp), %rax
	bswapq	%rax
	movq	%rax, 16(%rbx)
	movq	32(%rsp), %rax
	bswapq	%rax
	movq	%rax, 24(%rbx)
.LBB97_15:
	movq	%rbx, %rax
	addq	$224, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end97:
	.size	SHA512_256, .Lfunc_end97-SHA512_256
                                        # -- End function
	.globl	SHA512_256_Update               # -- Begin function SHA512_256_Update
	.p2align	4, 0x90
	.type	SHA512_256_Update,@function
SHA512_256_Update:                      # @SHA512_256_Update
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	testq	%rdx, %rdx
	je	.LBB98_12
# %bb.1:
	movq	%rdx, %rbx
	movq	%rsi, %r15
	movq	%rdi, %r14
	leaq	(,%rdx,8), %rax
	movq	%rdx, %rcx
	shrq	$61, %rcx
	addq	%rax, 64(%rdi)
	adcq	%rcx, 72(%rdi)
	leaq	80(%rdi), %r12
	movl	208(%rdi), %edi
	testq	%rdi, %rdi
	je	.LBB98_7
# %bb.2:
	movl	$128, %r13d
	subq	%rdi, %r13
	cmpq	%rbx, %r13
	jbe	.LBB98_4
# %bb.3:
	addq	%rdi, %r12
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	memcpy@PLT
	addl	208(%r14), %ebx
	jmp	.LBB98_11
.LBB98_4:
	cmpl	$128, %edi
	je	.LBB98_6
# %bb.5:
	addq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	memcpy@PLT
.LBB98_6:
	movl	$0, 208(%r14)
	subq	%r13, %rbx
	addq	%r13, %r15
	movl	$1, %edx
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	sha512_block_data_order
.LBB98_7:
	cmpq	$128, %rbx
	jb	.LBB98_9
# %bb.8:
	movq	%rbx, %rdx
	shrq	$7, %rdx
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	sha512_block_data_order
	addq	%rbx, %r15
	andl	$127, %ebx
	subq	%rbx, %r15
.LBB98_9:
	testq	%rbx, %rbx
	je	.LBB98_12
# %bb.10:
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	memcpy@PLT
.LBB98_11:
	movl	%ebx, 208(%r14)
.LBB98_12:
	movl	$1, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end98:
	.size	SHA512_256_Update, .Lfunc_end98-SHA512_256_Update
                                        # -- End function
	.globl	SHA512_256_Final                # -- Begin function SHA512_256_Final
	.p2align	4, 0x90
	.type	SHA512_256_Final,@function
SHA512_256_Final:                       # @SHA512_256_Final
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	%rsi, %r14
	movq	%rdi, %rbx
	leaq	80(%rsi), %r15
	movl	208(%rsi), %eax
	leaq	1(%rax), %rdi
	movb	$-128, 80(%rsi,%rax)
	cmpq	$112, %rax
	jb	.LBB99_4
# %bb.1:
	cmpl	$127, %eax
	je	.LBB99_3
# %bb.2:
	movl	$127, %edx
	subq	%rax, %rdx
	addq	%r15, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB99_3:
	movl	$1, %edx
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	sha512_block_data_order
	xorl	%edi, %edi
	jmp	.LBB99_5
.LBB99_4:
	cmpq	$112, %rdi
	je	.LBB99_6
.LBB99_5:
	movl	$112, %edx
	subq	%rdi, %rdx
	addq	%r15, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB99_6:
	movq	64(%r14), %rax
	movq	72(%r14), %rcx
	bswapq	%rcx
	movq	%rcx, 192(%r14)
	bswapq	%rax
	movq	%rax, 200(%r14)
	movl	$1, %edx
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	sha512_block_data_order
	testq	%rbx, %rbx
	je	.LBB99_7
# %bb.8:
	movq	(%r14), %rax
	bswapq	%rax
	movq	%rax, (%rbx)
	movq	8(%r14), %rax
	bswapq	%rax
	movq	%rax, 8(%rbx)
	movq	16(%r14), %rax
	bswapq	%rax
	movq	%rax, 16(%rbx)
	movq	24(%r14), %rax
	bswapq	%rax
	movq	%rax, 24(%rbx)
	movl	$1, %eax
	jmp	.LBB99_9
.LBB99_7:
	xorl	%eax, %eax
.LBB99_9:
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end99:
	.size	SHA512_256_Final, .Lfunc_end99-SHA512_256_Final
                                        # -- End function
	.globl	SHA512_Transform                # -- Begin function SHA512_Transform
	.p2align	4, 0x90
	.type	SHA512_Transform,@function
SHA512_Transform:                       # @SHA512_Transform
# %bb.0:
	pushq	%rax
	movl	$1, %edx
	callq	sha512_block_data_order
	popq	%rax
	retq
.Lfunc_end100:
	.size	SHA512_Transform, .Lfunc_end100-SHA512_Transform
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function sha512_block_data_order
	.type	sha512_block_data_order,@function
sha512_block_data_order:                # @sha512_block_data_order
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$192, %rsp
	movq	%rdi, 40(%rsp)                  # 8-byte Spill
	testq	%rdx, %rdx
	je	.LBB101_5
# %bb.1:
	movq	40(%rsp), %rax                  # 8-byte Reload
	movq	(%rax), %r13
	movq	8(%rax), %rbx
	movq	16(%rax), %r10
	movq	24(%rax), %rdi
	movq	32(%rax), %rbp
	movq	40(%rax), %r14
	movq	48(%rax), %r11
	movq	56(%rax), %r8
	.p2align	4, 0x90
.LBB101_2:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB101_3 Depth 2
	movq	%rdx, 152(%rsp)                 # 8-byte Spill
	movq	(%rsi), %rdx
	bswapq	%rdx
	movq	%rbp, %rax
	rolq	$50, %rax
	movq	8(%rsi), %r12
	movq	%rbp, %rcx
	rolq	$46, %rcx
	xorq	%rax, %rcx
	movq	%rbp, %rax
	rolq	$23, %rax
	xorq	%rcx, %rax
	movq	%rsi, %r15
	movq	%rbp, %rsi
	andq	%r14, %rsi
	movq	%rbp, %rcx
	notq	%rcx
	andq	%r11, %rcx
	movq	%r8, 80(%rsp)                   # 8-byte Spill
	addq	%r8, %rsi
	addq	%rcx, %rsi
	addq	%rax, %rsi
	movq	%r13, %rax
	rolq	$36, %rax
	movabsq	$4794697086780616226, %rcx      # imm = 0x428A2F98D728AE22
	addq	%rcx, %rsi
	movq	%r13, %rcx
	rolq	$30, %rcx
	movq	%rdx, -8(%rsp)                  # 8-byte Spill
	addq	%rdx, %rsi
	movq	%r13, %rdx
	rolq	$25, %rdx
	xorq	%rax, %rcx
	xorq	%rcx, %rdx
	movq	%rbx, %rax
	xorq	%r10, %rax
	andq	%r13, %rax
	movq	%rbx, %r9
	andq	%r10, %r9
	xorq	%rax, %r9
	addq	%rdx, %r9
	addq	%rsi, %r9
	bswapq	%r12
	movq	%rdi, 112(%rsp)                 # 8-byte Spill
	addq	%rdi, %rsi
	movq	%rsi, %rcx
	rolq	$50, %rcx
	movq	%r13, %rax
	movq	%rsi, %rdx
	rolq	$46, %rdx
	andq	%rbx, %rax
	movq	%rsi, %rdi
	rolq	$23, %rdi
	xorq	%rcx, %rdx
	xorq	%rdx, %rdi
	movq	%rsi, %r8
	andq	%rbp, %r8
	movq	%rsi, %rcx
	notq	%rcx
	andq	%r14, %rcx
	movq	%r11, 88(%rsp)                  # 8-byte Spill
	movq	%r12, -16(%rsp)                 # 8-byte Spill
	addq	%r11, %r8
	addq	%r12, %r8
	addq	%rcx, %r8
	movabsq	$8158064640168781261, %rcx      # imm = 0x7137449123EF65CD
	addq	%rcx, %r8
	addq	%rdi, %r8
	movq	%r9, %rcx
	rolq	$36, %rcx
	movq	%r9, %rdx
	rolq	$30, %rdx
	xorq	%rcx, %rdx
	movq	%r9, %rcx
	rolq	$25, %rcx
	xorq	%rdx, %rcx
	movq	%r13, %rdi
	xorq	%rbx, %rdi
	andq	%r9, %rdi
	xorq	%rax, %rdi
	addq	%rcx, %rdi
	addq	%r8, %rdi
	movq	16(%r15), %r12
	bswapq	%r12
	movq	%r10, 120(%rsp)                 # 8-byte Spill
	addq	%r10, %r8
	movq	%r8, %rcx
	rolq	$50, %rcx
	movq	%r9, %rax
	movq	%r8, %rdx
	rolq	$46, %rdx
	andq	%r13, %rax
	movq	%r8, %r10
	rolq	$23, %r10
	xorq	%rcx, %rdx
	xorq	%rdx, %r10
	movq	%r8, %r11
	andq	%rsi, %r11
	movq	%r8, %rcx
	notq	%rcx
	andq	%rbp, %rcx
	movq	%r14, 96(%rsp)                  # 8-byte Spill
	movq	%r12, 32(%rsp)                  # 8-byte Spill
	addq	%r14, %r11
	addq	%r12, %r11
	addq	%rcx, %r11
	movabsq	$-5349999486874862801, %rcx     # imm = 0xB5C0FBCFEC4D3B2F
	addq	%rcx, %r11
	addq	%r10, %r11
	movq	%rdi, %rcx
	rolq	$36, %rcx
	movq	%rdi, %rdx
	rolq	$30, %rdx
	xorq	%rcx, %rdx
	movq	%rdi, %r10
	rolq	$25, %r10
	xorq	%rdx, %r10
	movq	%r9, %rcx
	xorq	%r13, %rcx
	andq	%rdi, %rcx
	xorq	%rax, %rcx
	addq	%r10, %rcx
	addq	%r11, %rcx
	movq	24(%r15), %r14
	bswapq	%r14
	movq	%rbx, 128(%rsp)                 # 8-byte Spill
	addq	%rbx, %r11
	movq	%r11, %rax
	rolq	$50, %rax
	movq	%rdi, %rdx
	movq	%r11, %r10
	rolq	$46, %r10
	andq	%r9, %rdx
	movq	%r11, %rbx
	rolq	$23, %rbx
	xorq	%rax, %r10
	xorq	%r10, %rbx
	movq	%r11, %r10
	andq	%r8, %r10
	movq	%r11, %rax
	notq	%rax
	andq	%rsi, %rax
	movq	%rbp, 104(%rsp)                 # 8-byte Spill
	movq	%r14, -24(%rsp)                 # 8-byte Spill
	addq	%rbp, %r14
	addq	%r14, %r10
	addq	%rax, %r10
	movabsq	$-1606136188198331460, %rax     # imm = 0xE9B5DBA58189DBBC
	addq	%rax, %r10
	addq	%rbx, %r10
	movq	%rcx, %rax
	rolq	$36, %rax
	movq	%rcx, %rbx
	rolq	$30, %rbx
	xorq	%rax, %rbx
	movq	%rcx, %r14
	rolq	$25, %r14
	xorq	%rbx, %r14
	movq	%rdi, %rax
	xorq	%r9, %rax
	andq	%rcx, %rax
	xorq	%rdx, %rax
	addq	%r14, %rax
	addq	%r10, %rax
	movq	%r15, %r12
	movq	32(%r15), %r14
	bswapq	%r14
	movq	%r13, 136(%rsp)                 # 8-byte Spill
	addq	%r13, %r10
	movq	%r10, %rdx
	rolq	$50, %rdx
	movq	%r10, %rbx
	rolq	$46, %rbx
	xorq	%rdx, %rbx
	movq	%r10, %rdx
	rolq	$23, %rdx
	xorq	%rbx, %rdx
	movq	%r10, %rbx
	andq	%r11, %rbx
	movq	%r14, -48(%rsp)                 # 8-byte Spill
	addq	%r14, %rsi
	addq	%rbx, %rsi
	movq	%r10, %rbx
	notq	%rbx
	andq	%r8, %rbx
	addq	%rbx, %rsi
	movq	%rax, %rbx
	rolq	$36, %rbx
	movabsq	$4131703408338449720, %r14      # imm = 0x3956C25BF348B538
	addq	%r14, %rsi
	movq	%rax, %r14
	rolq	$30, %r14
	addq	%rdx, %rsi
	movq	%rax, %r15
	rolq	$25, %r15
	xorq	%rbx, %r14
	xorq	%r14, %r15
	movq	%rcx, %rbx
	andq	%rdi, %rbx
	movq	%rcx, %rdx
	xorq	%rdi, %rdx
	andq	%rax, %rdx
	xorq	%rbx, %rdx
	addq	%r15, %rdx
	movq	40(%r12), %r14
	bswapq	%r14
	addq	%rsi, %r9
	movq	%r9, %rbx
	rolq	$50, %rbx
	addq	%rsi, %rdx
	movq	%r9, %rsi
	rolq	$46, %rsi
	xorq	%rbx, %rsi
	movq	%r9, %rbx
	rolq	$23, %rbx
	xorq	%rsi, %rbx
	movq	%r9, %rsi
	andq	%r10, %rsi
	movq	%r14, -32(%rsp)                 # 8-byte Spill
	addq	%r14, %r8
	addq	%rsi, %r8
	movq	%r9, %rsi
	notq	%rsi
	andq	%r11, %rsi
	addq	%rsi, %r8
	movq	%rdx, %rsi
	rolq	$36, %rsi
	movabsq	$6480981068601479193, %r14      # imm = 0x59F111F1B605D019
	addq	%r14, %r8
	movq	%rdx, %r14
	rolq	$30, %r14
	addq	%rbx, %r8
	movq	%rdx, %rbx
	rolq	$25, %rbx
	xorq	%rsi, %r14
	xorq	%r14, %rbx
	movq	%rax, %r14
	andq	%rcx, %r14
	movq	%rax, %rsi
	xorq	%rcx, %rsi
	andq	%rdx, %rsi
	xorq	%r14, %rsi
	addq	%rbx, %rsi
	movq	48(%r12), %r14
	bswapq	%r14
	addq	%r8, %rdi
	movq	%rdi, %rbx
	rolq	$50, %rbx
	addq	%r8, %rsi
	movq	%rdi, %r8
	rolq	$46, %r8
	xorq	%rbx, %r8
	movq	%rdi, %rbx
	rolq	$23, %rbx
	xorq	%r8, %rbx
	movq	%rdi, %r8
	andq	%r9, %r8
	movq	%r14, -56(%rsp)                 # 8-byte Spill
	addq	%r14, %r11
	addq	%r8, %r11
	movq	%rdi, %r8
	notq	%r8
	andq	%r10, %r8
	addq	%r8, %r11
	movq	%rsi, %r8
	rolq	$36, %r8
	movabsq	$-7908458776815382629, %r14     # imm = 0x923F82A4AF194F9B
	addq	%r14, %r11
	movq	%rsi, %r14
	rolq	$30, %r14
	addq	%rbx, %r11
	movq	%rsi, %rbx
	rolq	$25, %rbx
	xorq	%r8, %r14
	xorq	%r14, %rbx
	movq	%rdx, %r8
	andq	%rax, %r8
	movq	%rdx, %rbp
	xorq	%rax, %rbp
	andq	%rsi, %rbp
	xorq	%r8, %rbp
	addq	%rbx, %rbp
	movq	56(%r12), %rbx
	bswapq	%rbx
	movq	%rbx, 48(%rsp)                  # 8-byte Spill
	addq	%r11, %rcx
	movq	%rcx, %r8
	rolq	$50, %r8
	addq	%r11, %rbp
	movq	%rcx, %r11
	rolq	$46, %r11
	xorq	%r8, %r11
	movq	%rcx, %r8
	rolq	$23, %r8
	xorq	%r11, %r8
	movq	%rcx, %r11
	andq	%rdi, %r11
	addq	%rbx, %r10
	addq	%r11, %r10
	movq	%rcx, %r11
	notq	%r11
	andq	%r9, %r11
	addq	%r11, %r10
	movq	%rbp, %r11
	rolq	$36, %r11
	movabsq	$-6116909921290321640, %rbx     # imm = 0xAB1C5ED5DA6D8118
	addq	%rbx, %r10
	movq	%rbp, %rbx
	rolq	$30, %rbx
	addq	%r8, %r10
	movq	%rbp, %r8
	rolq	$25, %r8
	xorq	%r11, %rbx
	xorq	%rbx, %r8
	movq	%rsi, %r11
	andq	%rdx, %r11
	movq	%rsi, %rbx
	xorq	%rdx, %rbx
	andq	%rbp, %rbx
	xorq	%r11, %rbx
	addq	%r8, %rbx
	movq	64(%r12), %r11
	bswapq	%r11
	movq	%r11, -40(%rsp)                 # 8-byte Spill
	addq	%r10, %rax
	movq	%rax, %r8
	rolq	$50, %r8
	addq	%r10, %rbx
	movq	%rax, %r10
	rolq	$46, %r10
	xorq	%r8, %r10
	movq	%rax, %r8
	rolq	$23, %r8
	xorq	%r10, %r8
	movq	%rax, %r10
	andq	%rcx, %r10
	addq	%r11, %r9
	addq	%r10, %r9
	movq	%rax, %r10
	notq	%r10
	andq	%rdi, %r10
	addq	%r10, %r9
	movq	%rbx, %r10
	rolq	$36, %r10
	movabsq	$-2880145864133508542, %r11     # imm = 0xD807AA98A3030242
	addq	%r11, %r9
	movq	%rbx, %r11
	rolq	$30, %r11
	addq	%r8, %r9
	movq	%rbx, %r15
	rolq	$25, %r15
	xorq	%r10, %r11
	xorq	%r11, %r15
	movq	%rbp, %r10
	andq	%rsi, %r10
	movq	%rbp, %r13
	xorq	%rsi, %r13
	andq	%rbx, %r13
	xorq	%r10, %r13
	addq	%r15, %r13
	movq	%r12, %r15
	movq	72(%r12), %r8
	bswapq	%r8
	movq	%r8, -64(%rsp)                  # 8-byte Spill
	addq	%r9, %rdx
	movq	%rdx, %r10
	rolq	$50, %r10
	addq	%r9, %r13
	movq	%rdx, %r9
	rolq	$46, %r9
	xorq	%r10, %r9
	movq	%rdx, %r10
	rolq	$23, %r10
	xorq	%r9, %r10
	movq	%rdx, %r9
	andq	%rax, %r9
	addq	%r8, %rdi
	addq	%r9, %rdi
	movq	%rdx, %r9
	notq	%r9
	andq	%rcx, %r9
	addq	%r9, %rdi
	movq	%r13, %r9
	rolq	$36, %r9
	movabsq	$1334009975649890238, %r8       # imm = 0x12835B0145706FBE
	addq	%r8, %rdi
	movq	%r13, %r11
	rolq	$30, %r11
	addq	%r10, %rdi
	movq	%r13, %r10
	rolq	$25, %r10
	xorq	%r9, %r11
	xorq	%r11, %r10
	movq	%rbx, %r9
	andq	%rbp, %r9
	movq	%rbx, %r12
	xorq	%rbp, %r12
	andq	%r13, %r12
	xorq	%r9, %r12
	addq	%r10, %r12
	movq	80(%r15), %r8
	bswapq	%r8
	addq	%rdi, %rsi
	movq	%rsi, %r9
	rolq	$50, %r9
	addq	%rdi, %r12
	movq	%rsi, %rdi
	rolq	$46, %rdi
	xorq	%r9, %rdi
	movq	%rsi, %r9
	rolq	$23, %r9
	xorq	%rdi, %r9
	movq	%rsi, %rdi
	andq	%rdx, %rdi
	movq	%r8, -96(%rsp)                  # 8-byte Spill
	addq	%r8, %rcx
	addq	%rdi, %rcx
	movq	%rsi, %rdi
	notq	%rdi
	andq	%rax, %rdi
	addq	%rdi, %rcx
	movq	%r12, %rdi
	rolq	$36, %rdi
	movabsq	$2608012711638119052, %r8       # imm = 0x243185BE4EE4B28C
	addq	%r8, %rcx
	movq	%r12, %r10
	rolq	$30, %r10
	addq	%r9, %rcx
	movq	%r12, %r9
	rolq	$25, %r9
	xorq	%rdi, %r10
	xorq	%r10, %r9
	movq	%r13, %r10
	andq	%rbx, %r10
	movq	%r13, %r14
	xorq	%rbx, %r14
	andq	%r12, %r14
	xorq	%r10, %r14
	addq	%r9, %r14
	movq	88(%r15), %rdi
	bswapq	%rdi
	addq	%rcx, %rbp
	movq	%rbp, %r9
	rolq	$50, %r9
	addq	%rcx, %r14
	movq	%rbp, %rcx
	rolq	$46, %rcx
	xorq	%r9, %rcx
	movq	%rbp, %r9
	rolq	$23, %r9
	xorq	%rcx, %r9
	movq	%rbp, %rcx
	andq	%rsi, %rcx
	movq	%rdi, -104(%rsp)                # 8-byte Spill
	addq	%rdi, %rax
	addq	%rcx, %rax
	movq	%rbp, %rcx
	notq	%rcx
	andq	%rdx, %rcx
	addq	%rcx, %rax
	movq	%r14, %rcx
	rolq	$36, %rcx
	movabsq	$6128411473006802146, %rdi      # imm = 0x550C7DC3D5FFB4E2
	addq	%rdi, %rax
	movq	%r14, %r10
	rolq	$30, %r10
	addq	%r9, %rax
	movq	%r14, %r11
	rolq	$25, %r11
	xorq	%rcx, %r10
	xorq	%r10, %r11
	movq	%r12, %rcx
	andq	%r13, %rcx
	movq	%r12, %r9
	xorq	%r13, %r9
	andq	%r14, %r9
	xorq	%rcx, %r9
	addq	%r11, %r9
	movq	96(%r15), %rdi
	bswapq	%rdi
	addq	%rax, %rbx
	movq	%rbx, %rcx
	rolq	$50, %rcx
	addq	%rax, %r9
	movq	%rbx, %rax
	rolq	$46, %rax
	xorq	%rcx, %rax
	movq	%rbx, %rcx
	rolq	$23, %rcx
	xorq	%rax, %rcx
	movq	%rbx, %rax
	andq	%rbp, %rax
	movq	%rdi, -120(%rsp)                # 8-byte Spill
	addq	%rdi, %rdx
	addq	%rax, %rdx
	movq	%rbx, %rax
	notq	%rax
	andq	%rsi, %rax
	addq	%rax, %rdx
	movq	%r9, %rax
	rolq	$36, %rax
	movabsq	$8268148722764581231, %rdi      # imm = 0x72BE5D74F27B896F
	addq	%rdi, %rdx
	movq	%r9, %r10
	rolq	$30, %r10
	addq	%rcx, %rdx
	movq	%r9, %r11
	rolq	$25, %r11
	xorq	%rax, %r10
	xorq	%r10, %r11
	movq	%r14, %rax
	andq	%r12, %rax
	movq	%r14, %rcx
	xorq	%r12, %rcx
	andq	%r9, %rcx
	xorq	%rax, %rcx
	addq	%r11, %rcx
	movq	104(%r15), %rdi
	bswapq	%rdi
	addq	%rdx, %r13
	movq	%r13, %rax
	rolq	$50, %rax
	addq	%rdx, %rcx
	movq	%r13, %rdx
	rolq	$46, %rdx
	xorq	%rax, %rdx
	movq	%r13, %rax
	rolq	$23, %rax
	xorq	%rdx, %rax
	movq	%r13, %rdx
	andq	%rbx, %rdx
	movq	%rdi, -88(%rsp)                 # 8-byte Spill
	addq	%rdi, %rsi
	addq	%rdx, %rsi
	movq	%r13, %rdx
	notq	%rdx
	andq	%rbp, %rdx
	addq	%rdx, %rsi
	movq	%rcx, %rdx
	rolq	$36, %rdx
	movabsq	$-9160688886553864527, %rdi     # imm = 0x80DEB1FE3B1696B1
	addq	%rdi, %rsi
	movq	%rcx, %r10
	rolq	$30, %r10
	addq	%rax, %rsi
	movq	%rcx, %rax
	rolq	$25, %rax
	xorq	%rdx, %r10
	xorq	%r10, %rax
	movq	%r9, %rdx
	andq	%r14, %rdx
	movq	%r9, %r11
	xorq	%r14, %r11
	andq	%rcx, %r11
	xorq	%rdx, %r11
	addq	%rax, %r11
	movq	112(%r15), %r10
	bswapq	%r10
	addq	%rsi, %r12
	movq	%r12, %rax
	rolq	$50, %rax
	addq	%rsi, %r11
	movq	%r12, %rdx
	rolq	$46, %rdx
	xorq	%rax, %rdx
	movq	%r12, %rax
	rolq	$23, %rax
	xorq	%rdx, %rax
	movq	%r12, %rdx
	andq	%r13, %rdx
	movq	%r10, -112(%rsp)                # 8-byte Spill
	addq	%r10, %rbp
	addq	%rdx, %rbp
	movq	%r12, %rdx
	notq	%rdx
	andq	%rbx, %rdx
	addq	%rdx, %rbp
	movq	%r11, %rdx
	rolq	$36, %rdx
	movabsq	$-7215885187991268811, %rsi     # imm = 0x9BDC06A725C71235
	addq	%rsi, %rbp
	movq	%r11, %rsi
	rolq	$30, %rsi
	addq	%rax, %rbp
	movq	%r11, %rax
	rolq	$25, %rax
	xorq	%rdx, %rsi
	xorq	%rsi, %rax
	movq	%rcx, %rdx
	andq	%r9, %rdx
	movq	%rcx, %r10
	xorq	%r9, %r10
	andq	%r11, %r10
	xorq	%rdx, %r10
	addq	%rax, %r10
	movq	%r15, %rax
	movq	%r15, 144(%rsp)                 # 8-byte Spill
	movq	120(%r15), %rsi
	bswapq	%rsi
	addq	%rbp, %r14
	movq	%r14, %rax
	rolq	$50, %rax
	addq	%rbp, %r10
	movq	%r14, %rdx
	rolq	$46, %rdx
	xorq	%rax, %rdx
	movq	%r14, %rax
	rolq	$23, %rax
	xorq	%rdx, %rax
	movq	%r14, %rdx
	andq	%r12, %rdx
	movq	%rsi, -80(%rsp)                 # 8-byte Spill
	addq	%rsi, %rbx
	addq	%rdx, %rbx
	movq	%r14, %rdx
	notq	%rdx
	andq	%r13, %rdx
	addq	%rdx, %rbx
	movq	%r10, %rdx
	rolq	$36, %rdx
	movabsq	$-4495734319001033068, %rsi     # imm = 0xC19BF174CF692694
	addq	%rsi, %rbx
	movq	%r10, %rsi
	rolq	$30, %rsi
	addq	%rax, %rbx
	movq	%r10, %rax
	rolq	$25, %rax
	xorq	%rdx, %rsi
	xorq	%rsi, %rax
	movq	%r11, %rdx
	andq	%rcx, %rdx
	movq	%r11, %r8
	xorq	%rcx, %r8
	movq	%r10, %r15
	andq	%r10, %r8
	xorq	%rdx, %r8
	addq	%rax, %r8
	addq	%rbx, %r9
	addq	%rbx, %r8
	xorl	%eax, %eax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	.p2align	4, 0x90
.LBB101_3:                              #   Parent Loop BB101_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r11, -128(%rsp)                # 8-byte Spill
	movq	-16(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rax
	rorq	%rax
	movq	%rbp, %rdx
	rolq	$56, %rdx
	xorq	%rax, %rdx
	movq	%r9, %rax
	rolq	$50, %rax
	movq	%rbp, %rsi
	shrq	$7, %rsi
	movq	%r9, %r10
	rolq	$46, %r10
	xorq	%rdx, %rsi
	movq	%r9, %rdx
	rolq	$23, %rdx
	xorq	%rax, %r10
	xorq	%r10, %rdx
	movq	-8(%rsp), %rdi                  # 8-byte Reload
	addq	-64(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%rsi, %rdi
	movq	%r9, %rsi
	andq	%r14, %rsi
	addq	%r13, %rsi
	movq	%r9, %rax
	notq	%rax
	andq	%r12, %rax
	addq	%rsi, %rax
	addq	%rdx, %rax
	movq	%r8, %rdx
	rolq	$36, %rdx
	movq	%r8, %rsi
	rolq	$30, %rsi
	xorq	%rdx, %rsi
	movq	%r8, %rdx
	rolq	$25, %rdx
	xorq	%rsi, %rdx
	movq	%r15, 8(%rsp)                   # 8-byte Spill
	movq	%r15, %rsi
	xorq	%r11, %rsi
	andq	%r11, %r15
	andq	%r8, %rsi
	xorq	%rsi, %r15
	movq	-112(%rsp), %r11                # 8-byte Reload
	movq	%r11, %rsi
	rolq	$45, %rsi
	movq	%r11, %r10
	rolq	$3, %r10
	xorq	%rsi, %r10
	addq	%rdx, %r15
	movq	%r11, %rdx
	shrq	$6, %rdx
	xorq	%r10, %rdx
	movq	32(%rsp), %r13                  # 8-byte Reload
	movq	%r13, %rsi
	rorq	%rsi
	movq	%r13, %r10
	rolq	$56, %r10
	xorq	%rsi, %r10
	addq	%rdx, %rdi
	movq	%r13, %rdx
	shrq	$7, %rdx
	xorq	%r10, %rdx
	addq	%rdi, %rax
	movq	-72(%rsp), %rbx                 # 8-byte Reload
	leaq	K512(%rip), %rsi
	addq	128(%rsi,%rbx,8), %rax
	addq	%rax, %rcx
	addq	%rax, %r15
	movq	-80(%rsp), %r10                 # 8-byte Reload
	movq	%r10, %rax
	rolq	$45, %rax
	movq	%r10, %rsi
	movq	%r10, -80(%rsp)                 # 8-byte Spill
	rolq	$3, %rsi
	xorq	%rax, %rsi
	addq	-96(%rsp), %rbp                 # 8-byte Folded Reload
	addq	%rdx, %rbp
	movq	%r10, %rax
	shrq	$6, %rax
	xorq	%rsi, %rax
	addq	%rax, %rbp
	movq	%rbp, -16(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	rolq	$50, %rax
	movq	%rcx, %rdx
	rolq	$46, %rdx
	xorq	%rax, %rdx
	movq	%rcx, %rax
	rolq	$23, %rax
	xorq	%rdx, %rax
	movq	%r15, %rdx
	rolq	$36, %rdx
	movq	%r15, %rsi
	rolq	$30, %rsi
	xorq	%rdx, %rsi
	movq	%r15, %rdx
	rolq	$25, %rdx
	xorq	%rsi, %rdx
	movq	%r8, %r11
	movq	%r8, 16(%rsp)                   # 8-byte Spill
	movq	%r8, %rsi
	movq	8(%rsp), %r8                    # 8-byte Reload
	andq	%r8, %rsi
	xorq	%r8, %r11
	andq	%r15, %r11
	xorq	%rsi, %r11
	addq	%rdx, %r11
	movq	%rcx, %rdx
	andq	%r9, %rdx
	addq	%rbp, %r12
	leaq	K512(%rip), %rbp
	addq	136(%rbp,%rbx,8), %r12
	movq	%rbx, -72(%rsp)                 # 8-byte Spill
	addq	%rdx, %r12
	movq	%rcx, %rdx
	notq	%rdx
	andq	%r14, %rdx
	addq	%rdx, %r12
	movq	-24(%rsp), %r8                  # 8-byte Reload
	movq	%r8, %rdx
	rorq	%rdx
	movq	%r8, %rsi
	rolq	$56, %rsi
	xorq	%rdx, %rsi
	addq	%rax, %r12
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	rolq	$45, %rax
	movq	%r8, %rdx
	shrq	$7, %rdx
	movq	%rdi, %r10
	rolq	$3, %r10
	xorq	%rsi, %rdx
	xorq	%rax, %r10
	movq	-128(%rsp), %rsi                # 8-byte Reload
	addq	%r12, %rsi
	addq	%r12, %r11
	shrq	$6, %rdi
	xorq	%r10, %rdi
	addq	-104(%rsp), %r13                # 8-byte Folded Reload
	addq	%rdx, %r13
	movq	%rsi, %rdx
	rolq	$50, %rdx
	addq	%rdi, %r13
	movq	%rsi, %rax
	rolq	$46, %rax
	xorq	%rdx, %rax
	addq	%r13, %r14
	movq	%rsi, %rdx
	andq	%rcx, %rdx
	addq	144(%rbp,%rbx,8), %r14
	addq	%rdx, %r14
	movq	%rsi, %rdx
	movq	%rsi, %r10
	movq	%rsi, -128(%rsp)                # 8-byte Spill
	notq	%rdx
	andq	%r9, %rdx
	addq	%rdx, %r14
	movq	%r15, %rdx
	movq	16(%rsp), %rdi                  # 8-byte Reload
	andq	%rdi, %rdx
	movq	%r15, %r12
	xorq	%rdi, %r12
	andq	%r11, %r12
	xorq	%rdx, %r12
	movq	%r11, %rdx
	rolq	$36, %rdx
	movq	%r11, %rsi
	rolq	$30, %rsi
	xorq	%rdx, %rsi
	movq	%r10, %rdx
	rolq	$23, %rdx
	xorq	%rax, %rdx
	movq	%r11, %rax
	movq	%r11, %rdi
	rolq	$25, %rax
	xorq	%rsi, %rax
	movq	-48(%rsp), %r11                 # 8-byte Reload
	movq	%r11, %rsi
	rorq	%rsi
	movq	%r11, %r10
	rolq	$56, %r10
	xorq	%rsi, %r10
	addq	%rdx, %r14
	movq	%r11, %rdx
	shrq	$7, %rdx
	xorq	%r10, %rdx
	addq	%rax, %r12
	movq	-16(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rax
	rolq	$45, %rax
	movq	%rbp, %rsi
	rolq	$3, %rsi
	xorq	%rax, %rsi
	movq	%rbp, %rax
	shrq	$6, %rax
	xorq	%rsi, %rax
	movq	8(%rsp), %rsi                   # 8-byte Reload
	addq	%r14, %rsi
	addq	%r14, %r12
	addq	-120(%rsp), %r8                 # 8-byte Folded Reload
	addq	%rdx, %r8
	addq	%rax, %r8
	movq	%r8, -24(%rsp)                  # 8-byte Spill
	addq	%r8, %r9
	movq	-72(%rsp), %r10                 # 8-byte Reload
	leaq	K512(%rip), %rax
	addq	152(%rax,%r10,8), %r9
	movq	%rsi, %rbx
	movq	%rsi, %rax
	movq	-128(%rsp), %r11                # 8-byte Reload
	andq	%r11, %rax
	addq	%rax, %r9
	movq	%rsi, %rdx
	rolq	$50, %rdx
	movq	%rsi, %rax
	rolq	$46, %rax
	xorq	%rdx, %rax
	movq	%rsi, %rdx
	notq	%rdx
	andq	%rcx, %rdx
	addq	%rdx, %r9
	movq	%rdi, 72(%rsp)                  # 8-byte Spill
	movq	%rdi, %rdx
	andq	%r15, %rdx
	movq	%rdi, %r14
	xorq	%r15, %r14
	movq	-32(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rsi
	rorq	%rsi
	andq	%r12, %r14
	xorq	%rdx, %r14
	movq	%rbp, %rdx
	rolq	$56, %rdx
	xorq	%rsi, %rdx
	movq	%r12, %rsi
	rolq	$36, %rsi
	movq	%r12, %rdi
	rolq	$30, %rdi
	xorq	%rsi, %rdi
	movq	%rbx, %rsi
	rolq	$23, %rsi
	xorq	%rax, %rsi
	movq	%r12, %rax
	rolq	$25, %rax
	xorq	%rdi, %rax
	movq	%rbp, %rdi
	shrq	$7, %rdi
	xorq	%rdx, %rdi
	addq	%rsi, %r9
	movq	%r13, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rdx
	rolq	$45, %rdx
	movq	%r13, %rsi
	rolq	$3, %rsi
	xorq	%rdx, %rsi
	addq	%rax, %r14
	movq	%r13, %rax
	shrq	$6, %rax
	xorq	%rsi, %rax
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	addq	-88(%rsp), %rdx                 # 8-byte Folded Reload
	addq	%rdi, %rdx
	addq	%rax, %rdx
	movq	%rdx, %rsi
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	movq	16(%rsp), %r8                   # 8-byte Reload
	addq	%r9, %r8
	addq	%r9, %r14
	movq	%r8, %rdx
	rolq	$50, %rdx
	movq	%r8, %rax
	rolq	$46, %rax
	xorq	%rdx, %rax
	addq	%rsi, %rcx
	leaq	K512(%rip), %rdx
	addq	160(%rdx,%r10,8), %rcx
	movq	%r8, %rdx
	movq	%rbx, %r13
	movq	%rbx, 8(%rsp)                   # 8-byte Spill
	andq	%rbx, %rdx
	addq	%rdx, %rcx
	movq	%r8, %rdx
	movq	%r8, %rbx
	notq	%rdx
	andq	%r11, %rdx
	addq	%rdx, %rcx
	movq	%r12, %rdx
	movq	72(%rsp), %r11                  # 8-byte Reload
	andq	%r11, %rdx
	movq	-56(%rsp), %r8                  # 8-byte Reload
	movq	%r8, %rsi
	rorq	%rsi
	movq	%r12, %r9
	xorq	%r11, %r9
	movq	%r8, %rdi
	rolq	$56, %rdi
	andq	%r14, %r9
	xorq	%rdx, %r9
	movq	%r9, %r11
	xorq	%rsi, %rdi
	movq	%r8, %rdx
	shrq	$7, %rdx
	xorq	%rdi, %rdx
	movq	%r14, %rsi
	rolq	$36, %rsi
	movq	%r14, %rdi
	rolq	$30, %rdi
	xorq	%rsi, %rdi
	movq	%rbx, 16(%rsp)                  # 8-byte Spill
	movq	%rbx, %rsi
	rolq	$23, %rsi
	xorq	%rax, %rsi
	movq	%r14, %rax
	rolq	$25, %rax
	xorq	%rdi, %rax
	movq	-24(%rsp), %r8                  # 8-byte Reload
	movq	%r8, %rdi
	rolq	$45, %rdi
	movq	%r8, %r9
	rolq	$3, %r9
	xorq	%rdi, %r9
	addq	%rsi, %rcx
	movq	%r8, %rsi
	shrq	$6, %rsi
	xorq	%r9, %rsi
	addq	%rax, %r11
	addq	-112(%rsp), %rbp                # 8-byte Folded Reload
	addq	%rdx, %rbp
	addq	%rcx, %r15
	addq	%rcx, %r11
	movq	%r11, (%rsp)                    # 8-byte Spill
	addq	%rsi, %rbp
	movq	%rbp, %rdx
	movq	%rbp, -32(%rsp)                 # 8-byte Spill
	movq	%r15, %rcx
	rolq	$50, %rcx
	movq	%r15, %rax
	movq	%r15, 184(%rsp)                 # 8-byte Spill
	rolq	$46, %rax
	xorq	%rcx, %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	leaq	K512(%rip), %rax
	movq	168(%rax,%r10,8), %rbp
	addq	%rdx, %rbp
	addq	-128(%rsp), %rbp                # 8-byte Folded Reload
	movq	%r15, %rcx
	andq	%rbx, %rcx
	addq	%rcx, %rbp
	movq	%r15, %rcx
	notq	%rcx
	movq	48(%rsp), %r15                  # 8-byte Reload
	movq	%r15, %rdx
	rolq	$56, %rdx
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	andq	%r13, %rcx
	addq	%rcx, %rbp
	movq	-40(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rcx
	rolq	$56, %rcx
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	movq	%rbx, -40(%rsp)                 # 8-byte Spill
	movq	-64(%rsp), %r10                 # 8-byte Reload
	movq	%r10, %rax
	rolq	$56, %rax
	movq	-96(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %rcx
	rolq	$56, %rcx
	movq	%rcx, -128(%rsp)                # 8-byte Spill
	movq	%r14, %r11
	movq	%r14, 168(%rsp)                 # 8-byte Spill
	movq	%r14, %rsi
	movq	%r12, 176(%rsp)                 # 8-byte Spill
	andq	%r12, %rsi
	movq	-104(%rsp), %rdi                # 8-byte Reload
	movq	%rdi, %rdx
	rolq	$56, %rdx
	movq	-120(%rsp), %r8                 # 8-byte Reload
	movq	%r8, %r14
	rolq	$56, %r14
	xorq	%r12, %r11
	movq	-88(%rsp), %r12                 # 8-byte Reload
	movq	%r12, %r9
	rolq	$56, %r9
	movq	(%rsp), %rcx                    # 8-byte Reload
	andq	%rcx, %r11
	xorq	%rsi, %r11
	movq	%r15, %rsi
	rorq	%rsi
	xorq	%rsi, 56(%rsp)                  # 8-byte Folded Spill
	rorq	%rbx
	xorq	%rbx, 64(%rsp)                  # 8-byte Folded Spill
	movq	%r10, %rsi
	rorq	%rsi
	xorq	%rsi, %rax
	movq	%rax, 160(%rsp)                 # 8-byte Spill
	movq	%r13, %rsi
	rorq	%rsi
	movq	-128(%rsp), %r13                # 8-byte Reload
	xorq	%rsi, %r13
	movq	%rdi, %rsi
	rorq	%rsi
	movq	%rdx, %rdi
	xorq	%rsi, %rdi
	movq	%r8, %rsi
	rorq	%rsi
	xorq	%rsi, %r14
	movq	%r12, %rsi
	rorq	%rsi
	xorq	%rsi, %r9
	movq	%rcx, %rsi
	rolq	$36, %rsi
	movq	%rcx, %rbx
	rolq	$30, %rbx
	xorq	%rsi, %rbx
	movq	184(%rsp), %r12                 # 8-byte Reload
	movq	%r12, %r10
	rolq	$23, %r10
	xorq	24(%rsp), %r10                  # 8-byte Folded Reload
	movq	%rcx, %rsi
	rolq	$25, %rsi
	xorq	%rbx, %rsi
	movq	-112(%rsp), %rcx                # 8-byte Reload
	movq	%rcx, %rax
	rorq	%rax
	movq	%rcx, %rdx
	rolq	$56, %rdx
	xorq	%rax, %rdx
	addq	%r10, %rbp
	movq	-80(%rsp), %rax                 # 8-byte Reload
	movq	%rax, %rbx
	rorq	%rbx
	movq	%rax, %r10
	rolq	$56, %r10
	xorq	%rbx, %r10
	addq	%rsi, %r11
	movq	-8(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, %r8
	rorq	%r8
	movq	%rsi, %rbx
	rolq	$56, %rbx
	xorq	%r8, %rbx
	shrq	$7, %rsi
	xorq	%rbx, %rsi
	movq	-56(%rsp), %r8                  # 8-byte Reload
	addq	%rax, %r8
	addq	%rax, %rsi
	movq	%rsi, 24(%rsp)                  # 8-byte Spill
	shrq	$7, %rax
	xorq	%r10, %rax
	addq	%rcx, %rax
	movq	%rax, -128(%rsp)                # 8-byte Spill
	shrq	$7, %rcx
	xorq	%rdx, %rcx
	movq	-88(%rsp), %rax                 # 8-byte Reload
	addq	%rax, %rcx
	movq	%rcx, -112(%rsp)                # 8-byte Spill
	movq	%rax, %rcx
	shrq	$7, %rcx
	xorq	%r9, %rcx
	movq	-120(%rsp), %rax                # 8-byte Reload
	addq	%rax, %rcx
	movq	%rcx, -80(%rsp)                 # 8-byte Spill
	movq	%rax, %rcx
	shrq	$7, %rcx
	xorq	%r14, %rcx
	movq	-104(%rsp), %rax                # 8-byte Reload
	addq	%rax, %rcx
	movq	%rcx, -88(%rsp)                 # 8-byte Spill
	shrq	$7, %rax
	xorq	%rdi, %rax
	movq	-96(%rsp), %r10                 # 8-byte Reload
	addq	%r10, %rax
	movq	%rax, -104(%rsp)                # 8-byte Spill
	shrq	$7, %r10
	xorq	%r13, %r10
	movq	-64(%rsp), %rsi                 # 8-byte Reload
	addq	%rsi, %r10
	movq	%r10, -96(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	shrq	$7, %rax
	xorq	160(%rsp), %rax                 # 8-byte Folded Reload
	movq	-40(%rsp), %rsi                 # 8-byte Reload
	addq	%rsi, %rax
	movq	%rax, -120(%rsp)                # 8-byte Spill
	shrq	$7, %rsi
	xorq	64(%rsp), %rsi                  # 8-byte Folded Reload
	addq	%r15, %rsi
	movq	-48(%rsp), %rax                 # 8-byte Reload
	movq	%rax, %rdi
	rolq	$45, %rdi
	shrq	$7, %r15
	movq	%rax, %r9
	rolq	$3, %r9
	xorq	56(%rsp), %r15                  # 8-byte Folded Reload
	xorq	%rdi, %r9
	movq	%rax, %rdi
	shrq	$6, %rdi
	xorq	%r9, %rdi
	addq	%r15, %r8
	movq	72(%rsp), %rbx                  # 8-byte Reload
	addq	%rbp, %rbx
	addq	%rbp, %r11
	addq	%rdi, %r8
	movq	%r8, -56(%rsp)                  # 8-byte Spill
	movq	%rbx, %rcx
	rolq	$50, %rcx
	movq	%rbx, %rdi
	rolq	$46, %rdi
	xorq	%rcx, %rdi
	movq	%rbx, %rcx
	rolq	$23, %rcx
	xorq	%rdi, %rcx
	movq	-72(%rsp), %rdx                 # 8-byte Reload
	leaq	K512(%rip), %rax
	movq	176(%rax,%rdx,8), %rdi
	addq	%r8, %rdi
	addq	8(%rsp), %rdi                   # 8-byte Folded Reload
	movq	%rbx, %r9
	movq	%r12, %rax
	andq	%r12, %r9
	addq	%r9, %rdi
	movq	%rbx, %r9
	notq	%r9
	movq	%r11, %r15
	rolq	$36, %r15
	movq	16(%rsp), %r13                  # 8-byte Reload
	andq	%r13, %r9
	addq	%r9, %rdi
	movq	%r11, %r9
	rolq	$30, %r9
	xorq	%r15, %r9
	movq	%r11, %r15
	rolq	$25, %r15
	xorq	%r9, %r15
	movq	(%rsp), %rbp                    # 8-byte Reload
	movq	%rbp, %r9
	movq	168(%rsp), %r8                  # 8-byte Reload
	andq	%r8, %r9
	xorq	%r8, %rbp
	andq	%r11, %rbp
	xorq	%r9, %rbp
	addq	%rcx, %rdi
	addq	%r15, %rbp
	movq	-32(%rsp), %r14                 # 8-byte Reload
	movq	%r14, %rcx
	rolq	$45, %rcx
	movq	%r14, %r9
	rolq	$3, %r9
	movq	176(%rsp), %r12                 # 8-byte Reload
	addq	%rdi, %r12
	addq	%rdi, %rbp
	xorq	%rcx, %r9
	movq	%r14, %rcx
	shrq	$6, %rcx
	xorq	%r9, %rcx
	movq	%rsi, %rdi
	addq	-8(%rsp), %rdi                  # 8-byte Folded Reload
	addq	%rcx, %rdi
	leaq	K512(%rip), %rcx
	movq	184(%rcx,%rdx,8), %rcx
	movq	%rdx, %rsi
	addq	%rdi, %rcx
	movq	%rdi, %r10
	addq	%r13, %rcx
	movq	%r12, %rdi
	andq	%rbx, %rdi
	addq	%rdi, %rcx
	movq	%r12, %rdi
	rolq	$50, %rdi
	movq	%r12, %r9
	rolq	$46, %r9
	xorq	%rdi, %r9
	movq	%r12, %rdi
	notq	%rdi
	movq	%rax, %r13
	andq	%rax, %rdi
	addq	%rdi, %rcx
	movq	%r12, %rdi
	movq	%r12, %r14
	rolq	$23, %rdi
	xorq	%r9, %rdi
	movq	%rbp, %r9
	rolq	$36, %r9
	movq	%rbp, %r15
	rolq	$30, %r15
	xorq	%r9, %r15
	movq	%rbp, %r9
	rolq	$25, %r9
	xorq	%r15, %r9
	addq	%rdi, %rcx
	movq	%r11, %rdi
	movq	(%rsp), %rax                    # 8-byte Reload
	andq	%rax, %rdi
	movq	%r11, %r15
	xorq	%rax, %r15
	movq	-56(%rsp), %rax                 # 8-byte Reload
	movq	%rax, %r12
	rolq	$45, %r12
	andq	%rbp, %r15
	xorq	%rdi, %r15
	movq	%rax, %rdi
	rolq	$3, %rdi
	addq	%r9, %r15
	xorq	%r12, %rdi
	movq	%r8, %r9
	addq	%rcx, %r9
	addq	%rcx, %r15
	movq	%rax, %rcx
	shrq	$6, %rcx
	xorq	%rdi, %rcx
	movq	-120(%rsp), %rax                # 8-byte Reload
	addq	-16(%rsp), %rax                 # 8-byte Folded Reload
	addq	%rcx, %rax
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	%r9, %rcx
	rolq	$50, %rcx
	movq	%r9, %rdi
	rolq	$46, %rdi
	xorq	%rcx, %rdi
	movq	%r9, %rcx
	rolq	$23, %rcx
	xorq	%rdi, %rcx
	leaq	K512(%rip), %rdx
	movq	192(%rdx,%rsi,8), %rdi
	addq	%rax, %rdi
	addq	%r13, %rdi
	movq	%r9, %r8
	andq	%r14, %r8
	addq	%r8, %rdi
	movq	%r9, %r8
	movq	%r9, %rsi
	notq	%r8
	movq	%r15, %r9
	rolq	$36, %r9
	andq	%rbx, %r8
	addq	%r8, %rdi
	movq	%r15, %r8
	rolq	$30, %r8
	xorq	%r9, %r8
	movq	%r15, %r9
	rolq	$25, %r9
	xorq	%r8, %r9
	movq	%rbp, %r12
	andq	%r11, %r12
	movq	%rbp, %r13
	xorq	%r11, %r13
	andq	%r15, %r13
	xorq	%r12, %r13
	addq	%rcx, %rdi
	addq	%r9, %r13
	movq	%r10, -64(%rsp)                 # 8-byte Spill
	movq	%r10, %rcx
	rolq	$45, %rcx
	movq	%r10, %r9
	rolq	$3, %r9
	movq	(%rsp), %rdx                    # 8-byte Reload
	addq	%rdi, %rdx
	addq	%rdi, %r13
	xorq	%rcx, %r9
	movq	%r10, %rcx
	shrq	$6, %rcx
	xorq	%r9, %rcx
	movq	-96(%rsp), %rax                 # 8-byte Reload
	addq	32(%rsp), %rax                  # 8-byte Folded Reload
	addq	%rcx, %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	leaq	K512(%rip), %rcx
	movq	-72(%rsp), %r8                  # 8-byte Reload
	movq	200(%rcx,%r8,8), %rcx
	addq	%rax, %rcx
	addq	%rbx, %rcx
	movq	%rdx, %rdi
	andq	%rsi, %rdi
	movq	%rsi, %r10
	addq	%rdi, %rcx
	movq	%rdx, %rdi
	rolq	$50, %rdi
	movq	%rdx, %r9
	rolq	$46, %r9
	xorq	%rdi, %r9
	movq	%rdx, %rdi
	notq	%rdi
	andq	%r14, %rdi
	addq	%rdi, %rcx
	movq	%rdx, %rdi
	movq	%rdx, %rax
	rolq	$23, %rdi
	xorq	%r9, %rdi
	movq	%r13, %r9
	rolq	$36, %r9
	movq	%r13, %r12
	rolq	$30, %r12
	xorq	%r9, %r12
	movq	%r13, %r9
	rolq	$25, %r9
	xorq	%r12, %r9
	addq	%rdi, %rcx
	movq	%r15, %rdi
	andq	%rbp, %rdi
	movq	%r15, %r12
	xorq	%rbp, %r12
	movq	-120(%rsp), %rsi                # 8-byte Reload
	movq	%rsi, %rdx
	rolq	$45, %rdx
	andq	%r13, %r12
	xorq	%rdi, %r12
	movq	%rsi, %rdi
	rolq	$3, %rdi
	addq	%r9, %r12
	xorq	%rdx, %rdi
	addq	%rcx, %r11
	addq	%rcx, %r12
	movq	%rsi, %rcx
	shrq	$6, %rcx
	xorq	%rdi, %rcx
	movq	-104(%rsp), %rsi                # 8-byte Reload
	addq	-24(%rsp), %rsi                 # 8-byte Folded Reload
	addq	%rcx, %rsi
	movq	%rsi, -104(%rsp)                # 8-byte Spill
	movq	%r11, %rcx
	rolq	$50, %rcx
	movq	%r11, %rdx
	rolq	$46, %rdx
	xorq	%rcx, %rdx
	movq	%r11, %rcx
	rolq	$23, %rcx
	xorq	%rdx, %rcx
	leaq	K512(%rip), %rdx
	movq	208(%rdx,%r8,8), %rdx
	movq	%r8, %rbx
	addq	%rsi, %rdx
	addq	%r14, %rdx
	movq	%r11, %rdi
	movq	%rax, %rsi
	andq	%rax, %rdi
	addq	%rdi, %rdx
	movq	%r11, %rdi
	notq	%rdi
	movq	%r12, %r9
	rolq	$36, %r9
	andq	%r10, %rdi
	addq	%rdi, %rdx
	movq	%r12, %rdi
	rolq	$30, %rdi
	xorq	%r9, %rdi
	movq	%r12, %r9
	rolq	$25, %r9
	xorq	%rdi, %r9
	movq	%r13, %r8
	andq	%r15, %r8
	movq	%r13, %r14
	xorq	%r15, %r14
	andq	%r12, %r14
	xorq	%r8, %r14
	addq	%rcx, %rdx
	addq	%r9, %r14
	movq	-96(%rsp), %rax                 # 8-byte Reload
	movq	%rax, %rcx
	rolq	$45, %rcx
	movq	%rax, %r8
	rolq	$3, %r8
	addq	%rdx, %rbp
	addq	%rdx, %r14
	xorq	%rcx, %r8
	movq	%rax, %rcx
	shrq	$6, %rcx
	xorq	%r8, %rcx
	movq	-88(%rsp), %rax                 # 8-byte Reload
	addq	-48(%rsp), %rax                 # 8-byte Folded Reload
	addq	%rcx, %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	leaq	K512(%rip), %rcx
	movq	%rbx, %rdi
	movq	216(%rcx,%rbx,8), %rcx
	addq	%rax, %rcx
	addq	%r10, %rcx
	movq	%rbp, %rdx
	andq	%r11, %rdx
	addq	%rdx, %rcx
	movq	%rbp, %rdx
	rolq	$50, %rdx
	movq	%rbp, %r8
	rolq	$46, %r8
	xorq	%rdx, %r8
	movq	%rbp, %rdx
	notq	%rdx
	andq	%rsi, %rdx
	addq	%rdx, %rcx
	movq	%rbp, %rdx
	rolq	$23, %rdx
	xorq	%r8, %rdx
	movq	%r14, %r8
	rolq	$36, %r8
	movq	%r14, %r9
	rolq	$30, %r9
	xorq	%r8, %r9
	movq	%r14, %r8
	rolq	$25, %r8
	xorq	%r9, %r8
	addq	%rdx, %rcx
	movq	%r12, %rdx
	andq	%r13, %rdx
	movq	%r12, %r9
	xorq	%r13, %r9
	movq	-104(%rsp), %rax                # 8-byte Reload
	movq	%rax, %rbx
	rolq	$45, %rbx
	andq	%r14, %r9
	xorq	%rdx, %r9
	movq	%rax, %rdx
	rolq	$3, %rdx
	addq	%r8, %r9
	xorq	%rbx, %rdx
	addq	%rcx, %r15
	addq	%rcx, %r9
	movq	%rax, %rcx
	shrq	$6, %rcx
	xorq	%rdx, %rcx
	movq	-80(%rsp), %rax                 # 8-byte Reload
	addq	-32(%rsp), %rax                 # 8-byte Folded Reload
	addq	%rcx, %rax
	movq	%r15, %rcx
	rolq	$50, %rcx
	movq	%r15, %rdx
	rolq	$46, %rdx
	xorq	%rcx, %rdx
	movq	%r15, %r8
	rolq	$23, %r8
	xorq	%rdx, %r8
	leaq	K512(%rip), %rcx
	movq	224(%rcx,%rdi,8), %rdx
	addq	%rax, %rdx
	movq	%rax, %r10
	addq	%rsi, %rdx
	movq	%r15, %rcx
	andq	%rbp, %rcx
	addq	%rcx, %rdx
	movq	%r15, %rcx
	notq	%rcx
	movq	%r9, %rbx
	rolq	$36, %rbx
	andq	%r11, %rcx
	addq	%rcx, %rdx
	movq	%r9, %rcx
	rolq	$30, %rcx
	xorq	%rbx, %rcx
	movq	%r9, %rbx
	rolq	$25, %rbx
	xorq	%rcx, %rbx
	movq	%r14, %rdi
	andq	%r12, %rdi
	movq	%r14, %rcx
	xorq	%r12, %rcx
	andq	%r9, %rcx
	xorq	%rdi, %rcx
	addq	%r8, %rdx
	addq	%rbx, %rcx
	movq	-88(%rsp), %rax                 # 8-byte Reload
	movq	%rax, %rdi
	rolq	$45, %rdi
	movq	%rax, %r8
	rolq	$3, %r8
	addq	%rdx, %r13
	addq	%rdx, %rcx
	xorq	%rdi, %r8
	movq	%rax, %rdx
	shrq	$6, %rdx
	xorq	%r8, %rdx
	movq	-112(%rsp), %rax                # 8-byte Reload
	addq	-56(%rsp), %rax                 # 8-byte Folded Reload
	addq	%rdx, %rax
	movq	%rax, -112(%rsp)                # 8-byte Spill
	leaq	K512(%rip), %rdx
	movq	-72(%rsp), %rsi                 # 8-byte Reload
	movq	232(%rdx,%rsi,8), %rdx
	addq	%rax, %rdx
	addq	%r11, %rdx
	movq	%r13, %rdi
	andq	%r15, %rdi
	addq	%rdi, %rdx
	movq	%r13, %rdi
	rolq	$50, %rdi
	movq	%r13, %r8
	rolq	$46, %r8
	xorq	%rdi, %r8
	movq	%r13, %rdi
	notq	%rdi
	andq	%rbp, %rdi
	addq	%rdi, %rdx
	movq	%r13, %rdi
	rolq	$23, %rdi
	xorq	%r8, %rdi
	movq	%rcx, %r8
	rolq	$36, %r8
	movq	%rcx, %r11
	rolq	$30, %r11
	xorq	%r8, %r11
	movq	%rcx, %r8
	rolq	$25, %r8
	xorq	%r11, %r8
	addq	%rdi, %rdx
	movq	%r9, %rdi
	andq	%r14, %rdi
	movq	%r9, %r11
	xorq	%r14, %r11
	movq	%r10, %rax
	movq	%r10, -80(%rsp)                 # 8-byte Spill
	movq	%r10, %rbx
	rolq	$45, %rbx
	andq	%rcx, %r11
	xorq	%rdi, %r11
	movq	%r10, %rdi
	rolq	$3, %rdi
	addq	%r8, %r11
	xorq	%rbx, %rdi
	addq	%rdx, %r12
	addq	%rdx, %r11
	movq	%r10, %rdx
	shrq	$6, %rdx
	xorq	%rdi, %rdx
	movq	-128(%rsp), %rax                # 8-byte Reload
	movq	-64(%rsp), %r10                 # 8-byte Reload
	addq	%r10, %rax
	addq	%rdx, %rax
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	%r12, %rdx
	rolq	$50, %rdx
	movq	%r12, %rdi
	rolq	$46, %rdi
	xorq	%rdx, %rdi
	movq	%r12, %rdx
	rolq	$23, %rdx
	xorq	%rdi, %rdx
	leaq	K512(%rip), %rdi
	movq	240(%rdi,%rsi,8), %rdi
	addq	%rax, %rdi
	addq	%rbp, %rdi
	movq	%r12, %r8
	andq	%r13, %r8
	addq	%r8, %rdi
	movq	%r12, %r8
	notq	%r8
	movq	%r11, %rbx
	rolq	$36, %rbx
	andq	%r15, %r8
	addq	%r8, %rdi
	movq	%r11, %r8
	rolq	$30, %r8
	xorq	%rbx, %r8
	movq	%r11, %rbx
	rolq	$25, %rbx
	xorq	%r8, %rbx
	movq	%rcx, %r8
	andq	%r9, %r8
	movq	%rcx, %rbp
	xorq	%r9, %rbp
	andq	%r11, %rbp
	xorq	%r8, %rbp
	addq	%rdx, %rdi
	addq	%rbx, %rbp
	movq	-112(%rsp), %rax                # 8-byte Reload
	movq	%rax, %rdx
	rolq	$45, %rdx
	movq	%rax, %r8
	rolq	$3, %r8
	addq	%rdi, %r14
	addq	%rdi, %rbp
	xorq	%rdx, %r8
	movq	%rax, %rdx
	shrq	$6, %rdx
	xorq	%r8, %rdx
	movq	24(%rsp), %rax                  # 8-byte Reload
	addq	-120(%rsp), %rax                # 8-byte Folded Reload
	addq	%rdx, %rax
	leaq	K512(%rip), %rdx
	movq	248(%rdx,%rsi,8), %rdx
	addq	%rax, %rdx
	movq	%rax, %rsi
	addq	%r15, %rdx
	movq	%r14, %rdi
	andq	%r12, %rdi
	addq	%rdi, %rdx
	movq	%r14, %rdi
	rolq	$50, %rdi
	movq	%r14, %r8
	rolq	$46, %r8
	xorq	%rdi, %r8
	movq	%r14, %rdi
	notq	%rdi
	andq	%r13, %rdi
	addq	%rdi, %rdx
	movq	%r14, %rdi
	rolq	$23, %rdi
	xorq	%r8, %rdi
	movq	%rbp, %r8
	rolq	$36, %r8
	movq	%rbp, %rbx
	rolq	$30, %rbx
	xorq	%r8, %rbx
	movq	%rbp, %r8
	rolq	$25, %r8
	xorq	%rbx, %r8
	addq	%rdi, %rdx
	movq	%r11, %rdi
	andq	%rcx, %rdi
	movq	%r11, %rbx
	xorq	%rcx, %rbx
	movq	%rbp, %r15
	andq	%rbp, %rbx
	xorq	%rdi, %rbx
	addq	%r8, %rbx
	addq	%rdx, %r9
	addq	%rdx, %rbx
	movq	%rbx, %r8
	movq	%r10, 48(%rsp)                  # 8-byte Spill
	movq	-120(%rsp), %rax                # 8-byte Reload
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	-96(%rsp), %rax                 # 8-byte Reload
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	-104(%rsp), %rax                # 8-byte Reload
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-88(%rsp), %rax                 # 8-byte Reload
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-80(%rsp), %rax                 # 8-byte Reload
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	-112(%rsp), %rax                # 8-byte Reload
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	-72(%rsp), %rax                 # 8-byte Reload
	addq	$16, %rax
	movq	-128(%rsp), %rdx                # 8-byte Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rsi, -80(%rsp)                 # 8-byte Spill
	movq	%rax, %rdx
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	cmpq	$64, %rax
	jb	.LBB101_3
# %bb.4:                                #   in Loop: Header=BB101_2 Depth=1
	movq	136(%rsp), %rdx                 # 8-byte Reload
	addq	%r8, %rdx
	movq	128(%rsp), %rbx                 # 8-byte Reload
	addq	%r15, %rbx
	movq	120(%rsp), %r10                 # 8-byte Reload
	addq	%r11, %r10
	movq	112(%rsp), %rdi                 # 8-byte Reload
	addq	%rcx, %rdi
	movq	104(%rsp), %rbp                 # 8-byte Reload
	addq	%r9, %rbp
	movq	96(%rsp), %rax                  # 8-byte Reload
	addq	%r14, %rax
	movq	%rax, %r14
	movq	88(%rsp), %r11                  # 8-byte Reload
	addq	%r12, %r11
	movq	80(%rsp), %r8                   # 8-byte Reload
	addq	%r13, %r8
	movq	%rdx, %r13
	movq	144(%rsp), %rsi                 # 8-byte Reload
	subq	$-128, %rsi
	movq	40(%rsp), %rax                  # 8-byte Reload
	movq	%rdx, (%rax)
	movq	%rbx, 8(%rax)
	movq	%r10, 16(%rax)
	movq	%rdi, 24(%rax)
	movq	%rbp, 32(%rax)
	movq	%r14, 40(%rax)
	movq	%r11, 48(%rax)
	movq	%r8, 56(%rax)
	movq	152(%rsp), %rdx                 # 8-byte Reload
	decq	%rdx
	jne	.LBB101_2
.LBB101_5:
	addq	$192, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end101:
	.size	sha512_block_data_order, .Lfunc_end101-sha512_block_data_order
                                        # -- End function
	.globl	x25519_ge_tobytes               # -- Begin function x25519_ge_tobytes
	.p2align	4, 0x90
	.type	x25519_ge_tobytes,@function
x25519_ge_tobytes:                      # @x25519_ge_tobytes
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$160, %rsp
	movq	%rsi, %r14
	movq	%rdi, %rbx
	movq	112(%rsi), %rax
	movq	%rax, 32(%rsp)
	movups	80(%rsi), %xmm0
	movups	96(%rsi), %xmm1
	movaps	%xmm1, 16(%rsp)
	movaps	%xmm0, (%rsp)
	leaq	120(%rsp), %r15
	movq	%rsp, %rsi
	movq	%r15, %rdi
	callq	fe_loose_invert
	movq	%rsp, %r12
	movq	%r12, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	addq	$40, %r14
	leaq	80(%rsp), %r13
	movq	%r13, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	movq	%rbx, %rdi
	movq	%r13, %rsi
	callq	fe_tobytes
	leaq	48(%rsp), %rdi
	movq	%r12, %rsi
	callq	fe_tobytes
	movzbl	48(%rsp), %eax
	shlb	$7, %al
	xorb	%al, 31(%rbx)
	addq	$160, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end102:
	.size	x25519_ge_tobytes, .Lfunc_end102-x25519_ge_tobytes
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function fe_tobytes
	.type	fe_tobytes,@function
fe_tobytes:                             # @fe_tobytes
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	(%rsi), %rax
	movabsq	$-2251799813685247, %r15        # imm = 0xFFF8000000000001
	leaq	(%rax,%r15), %rcx
	addq	$18, %rcx
	movabsq	$2251799813685247, %r9          # imm = 0x7FFFFFFFFFFFF
	movq	%rcx, %r11
	andq	%r9, %r11
	shrq	$51, %rcx
	negl	%ecx
	movzbl	%cl, %ecx
	movq	8(%rsi), %rdx
	addq	%r15, %rdx
	subq	%rcx, %rdx
	movq	%rdx, %rcx
	andq	%r9, %rcx
	shrq	$51, %rdx
	negl	%edx
	movzbl	%dl, %edx
	movq	16(%rsi), %r10
	addq	%r15, %r10
	subq	%rdx, %r10
	movq	%r10, %r8
	andq	%r9, %r8
	shrq	$51, %r10
	negl	%r10d
	movzbl	%r10b, %edx
	movq	24(%rsi), %rbx
	addq	%r15, %rbx
	subq	%rdx, %rbx
	movq	%rbx, %r10
	andq	%r9, %r10
	shrq	$51, %rbx
	negl	%ebx
	movzbl	%bl, %edx
	addq	32(%rsi), %r15
	subq	%rdx, %r15
	movabsq	$574208952489738240, %rsi       # imm = 0x7F8000000000000
	andq	%r15, %rsi
	xorl	%edx, %edx
	negq	%rsi
	sbbq	%rdx, %rdx
	#APP
	#NO_APP
	leaq	-18(%r9), %r14
	andq	%rdx, %r14
	addq	%r11, %r14
	movq	%r14, %rsi
	movq	%r14, %rbx
	shrq	$51, %rbx
	andq	%rdx, %r9
	addq	%r9, %rcx
	addq	%rbx, %rcx
	movq	%rcx, %r11
	shrq	$51, %r11
	addq	%r9, %r8
	addq	%r11, %r8
	movq	%r8, %r11
	shrq	$51, %r11
	addq	%r10, %r9
	addq	%r11, %r9
	movq	%r9, %r10
	shrq	$51, %r10
	addq	%r15, %rdx
	addq	%r10, %rdx
	movl	%edx, %eax
	shll	$4, %eax
	movl	%r8d, %r10d
	shll	$6, %r10d
	shrq	$48, %rsi
	andl	$7, %esi
	leal	(%rsi,%rcx,8), %esi
	movl	%esi, -68(%rsp)                 # 4-byte Spill
	movq	%rcx, -8(%rsp)                  # 8-byte Spill
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	movq	%rcx, -24(%rsp)                 # 8-byte Spill
	movq	%rcx, -32(%rsp)                 # 8-byte Spill
	movq	%rcx, -40(%rsp)                 # 8-byte Spill
	shrq	$45, %rcx
	andl	$63, %ecx
	orl	%r10d, %ecx
	movq	%r8, -48(%rsp)                  # 8-byte Spill
	movq	%r8, -56(%rsp)                  # 8-byte Spill
	movq	%r8, -64(%rsp)                  # 8-byte Spill
	movq	%r8, %r13
	movq	%r8, %r12
	movq	%r8, %r15
	shrq	$50, %r8
	andl	$1, %r8d
	leal	(%r8,%r9,2), %esi
	movl	%esi, -72(%rsp)                 # 4-byte Spill
	movq	%r9, %r11
	movq	%r9, %r10
	movq	%r9, %rbp
	movq	%r9, %r8
	movq	%r9, %rsi
	shrq	$47, %r9
	andl	$15, %r9d
	orl	%eax, %r9d
	movq	%r14, %rax
	movb	%al, (%rdi)
	movb	%ah, 1(%rdi)
	movq	%r14, %rbx
	shrq	$16, %rbx
	movb	%bl, 2(%rdi)
	movq	%r14, %rbx
	shrq	$24, %rbx
	movb	%bl, 3(%rdi)
	movq	%r14, %rbx
	shrq	$32, %rbx
	movb	%bl, 4(%rdi)
	shrq	$40, %rax
	movb	%al, 5(%rdi)
	movl	-68(%rsp), %eax                 # 4-byte Reload
	movb	%al, 6(%rdi)
	movq	-8(%rsp), %rax                  # 8-byte Reload
	shrq	$5, %rax
	movb	%al, 7(%rdi)
	movq	-16(%rsp), %rax                 # 8-byte Reload
	shrq	$13, %rax
	movb	%al, 8(%rdi)
	movq	-24(%rsp), %rax                 # 8-byte Reload
	shrq	$21, %rax
	movb	%al, 9(%rdi)
	movq	-32(%rsp), %rax                 # 8-byte Reload
	shrq	$29, %rax
	movb	%al, 10(%rdi)
	movq	-40(%rsp), %rax                 # 8-byte Reload
	shrq	$37, %rax
	movb	%al, 11(%rdi)
	movb	%cl, 12(%rdi)
	movq	-48(%rsp), %rax                 # 8-byte Reload
	shrq	$2, %rax
	movb	%al, 13(%rdi)
	movq	-56(%rsp), %rax                 # 8-byte Reload
	shrq	$10, %rax
	movb	%al, 14(%rdi)
	movq	-64(%rsp), %rax                 # 8-byte Reload
	shrq	$18, %rax
	movb	%al, 15(%rdi)
	shrq	$26, %r13
	movb	%r13b, 16(%rdi)
	shrq	$34, %r12
	movb	%r12b, 17(%rdi)
	shrq	$42, %r15
	movb	%r15b, 18(%rdi)
	movl	-72(%rsp), %eax                 # 4-byte Reload
	movb	%al, 19(%rdi)
	shrq	$7, %r11
	movb	%r11b, 20(%rdi)
	shrq	$15, %r10
	movb	%r10b, 21(%rdi)
	shrq	$23, %rbp
	movb	%bpl, 22(%rdi)
	shrq	$31, %r8
	movb	%r8b, 23(%rdi)
	shrq	$39, %rsi
	movb	%sil, 24(%rdi)
	movb	%r9b, 25(%rdi)
	movq	%rdx, %rax
	shrq	$4, %rax
	movb	%al, 26(%rdi)
	movq	%rdx, %rax
	shrq	$12, %rax
	movb	%al, 27(%rdi)
	movq	%rdx, %rax
	shrq	$20, %rax
	movb	%al, 28(%rdi)
	movq	%rdx, %rax
	shrq	$28, %rax
	movb	%al, 29(%rdi)
	movq	%rdx, %rax
	shrq	$36, %rax
	movb	%al, 30(%rdi)
	shrq	$44, %rdx
	andb	$127, %dl
	movb	%dl, 31(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end103:
	.size	fe_tobytes, .Lfunc_end103-fe_tobytes
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function x25519_ge_frombytes_vartime
.LCPI104_0:
	.quad	2251799813685247                # 0x7ffffffffffff
	.quad	2251799813685247                # 0x7ffffffffffff
	.text
	.globl	x25519_ge_frombytes_vartime
	.p2align	4, 0x90
	.type	x25519_ge_frombytes_vartime,@function
x25519_ge_frombytes_vartime:            # @x25519_ge_frombytes_vartime
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$536, %rsp                      # imm = 0x218
	movq	%rdi, 240(%rsp)                 # 8-byte Spill
	movl	(%rsi), %r8d
	movl	16(%rsi), %eax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movzbl	4(%rsi), %r10d
	movzbl	5(%rsi), %r15d
	movzbl	6(%rsi), %edx
	movzbl	7(%rsi), %eax
	movzbl	8(%rsi), %edi
	movzbl	9(%rsi), %r13d
	movzbl	10(%rsi), %ebx
	movzbl	11(%rsi), %r14d
	movzbl	27(%rsi), %ecx
	movl	28(%rsi), %r11d
	andl	$2147483647, %r11d              # imm = 0x7FFFFFFF
	shlq	$20, %r11
	shlq	$12, %rcx
	orq	%r11, %rcx
	movzbl	26(%rsi), %r12d
	shlq	$4, %r12
	orq	%rcx, %r12
	shlq	$40, %r15
	movl	%edx, %ecx
	andl	$7, %ecx
	shlq	$48, %rcx
	orq	%r15, %rcx
	movzbl	12(%rsi), %r15d
	orq	%r8, %rcx
	movzbl	13(%rsi), %r9d
	shlq	$37, %r14
	shlq	$32, %r10
	orq	%r10, %rcx
	movl	%r15d, %r8d
	andl	$63, %r8d
	shlq	$45, %r8
	orq	%r14, %r8
	movzbl	14(%rsi), %r14d
	shlq	$29, %rbx
	orq	%rbx, %r8
	movzbl	15(%rsi), %ebx
	shlq	$21, %r13
	orq	%r13, %r8
	movzbl	20(%rsi), %r13d
	shlq	$13, %rdi
	orq	%rdi, %r8
	movzbl	21(%rsi), %ebp
	shlq	$5, %rax
	orq	%rax, %r8
	movq	8(%rsp), %rax                   # 8-byte Reload
	movq	%rax, %rdi
	shlq	$26, %rdi
	shrq	$3, %rdx
	orq	%rdx, %r8
	movabsq	$2251799813685247, %r11         # imm = 0x7FFFFFFFFFFFF
	leaq	-67108863(%r11), %rdx
	andq	%rdi, %rdx
	movq	%rsi, 424(%rsp)                 # 8-byte Spill
	movl	22(%rsi), %r10d
	shlq	$18, %rbx
	orq	%rbx, %rdx
	movq	%r10, %rsi
	shlq	$23, %rsi
	shlq	$15, %rbp
	shlq	$7, %r13
	shlq	$10, %r14
	shrq	$6, %r15
	orq	%r14, %rdx
	leaq	(%rdx,%r9,4), %r9
	orq	%r15, %r9
	shrq	$25, %rax
	leaq	-8388607(%r11), %rdi
	andq	%rsi, %rdi
	orq	%rbp, %rdi
	orq	%r13, %rdi
	orq	%rax, %rdi
	shrq	$28, %r10
	orq	%r12, %r10
	movq	240(%rsp), %rax                 # 8-byte Reload
	movq	%rcx, 40(%rax)
	movq	%r8, 48(%rax)
	movq	%r9, 56(%rax)
	movq	%rdi, 64(%rax)
	movq	%r10, 72(%rax)
	leaq	(%r10,%r10,8), %rax
	leaq	(%r10,%rax,2), %rax
	imulq	$38, %r10, %rsi
	leaq	(%rdi,%rdi,8), %r11
	mulq	%r10
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	%rdi
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	leaq	(%rdi,%r11,2), %rax
	mulq	%rdi
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rsi, %rax
	mulq	%r9
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	imulq	$38, %rdi, %rax
	leaq	(%rdi,%rdi), %r13
	mulq	%r9
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r9
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rsi, %rax
	mulq	%r8
	movq	%rax, %rdi
	movq	%rdx, %r14
	leaq	(%r9,%r9), %rbp
	movq	%r13, %rax
	mulq	%r8
	movq	%rdx, %r9
	movq	%rax, %r11
	movq	%rbp, %rax
	mulq	%r8
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%r8, %rax
	mulq	%r8
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	addq	%r10, %r10
	movq	%r10, %rax
	mulq	%rcx
	movq	%rdx, %rbx
	movq	%rax, %rsi
	movq	%r13, %rax
	mulq	%rcx
	movq	%rdx, %r15
	movq	%rax, %r12
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rax, %r10
	movq	%rdx, %r13
	leaq	(%r8,%r8), %rax
	mulq	%rcx
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	%rcx
	addq	16(%rsp), %rax                  # 8-byte Folded Reload
	adcq	24(%rsp), %rdx                  # 8-byte Folded Reload
	addq	%rdi, %rax
	adcq	%r14, %rdx
	movq	%rdx, %rcx
	shrq	$51, %rcx
	shldq	$13, %rax, %rdx
	movabsq	$2251799813685247, %rdi         # imm = 0x7FFFFFFFFFFFF
	andq	%rdi, %rax
	addq	32(%rsp), %r11                  # 8-byte Folded Reload
	adcq	40(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rsi, %r11
	adcq	%rbx, %r9
	addq	72(%rsp), %r8                   # 8-byte Folded Reload
	adcq	88(%rsp), %rbp                  # 8-byte Folded Reload
	addq	64(%rsp), %r8                   # 8-byte Folded Reload
	adcq	80(%rsp), %rbp                  # 8-byte Folded Reload
	addq	%rdx, %r8
	adcq	%rcx, %rbp
	movq	%rbp, %rcx
	shrq	$51, %rcx
	shldq	$13, %r8, %rbp
	andq	%rdi, %r8
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r13                  # 8-byte Folded Reload
	addq	112(%rsp), %r10                 # 8-byte Folded Reload
	adcq	120(%rsp), %r13                 # 8-byte Folded Reload
	addq	%rbp, %r10
	adcq	%rcx, %r13
	movq	%r13, %rcx
	shrq	$51, %rcx
	shldq	$13, %r10, %r13
	andq	%rdi, %r10
	addq	96(%rsp), %r12                  # 8-byte Folded Reload
	adcq	104(%rsp), %r15                 # 8-byte Folded Reload
	addq	128(%rsp), %r12                 # 8-byte Folded Reload
	adcq	8(%rsp), %r15                   # 8-byte Folded Reload
	addq	%r13, %r12
	adcq	%rcx, %r15
	movq	%r15, %rcx
	shrq	$51, %rcx
	shldq	$13, %r12, %r15
	andq	%rdi, %r12
	addq	%r11, %r15
	adcq	%r9, %rcx
	shldq	$13, %r15, %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rbx
	movabsq	$4503599627370494, %r13         # imm = 0xFFFFFFFFFFFFE
	addq	%rax, %rbx
	movq	%rbx, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	movq	%r14, %rbp
	shrq	$51, %rbp
	addq	%r10, %rbp
	movq	240(%rsp), %rcx                 # 8-byte Reload
	leaq	40(%rcx), %rax
	movq	%rax, 416(%rsp)                 # 8-byte Spill
	xorps	%xmm0, %xmm0
	movups	%xmm0, 88(%rcx)
	movups	%xmm0, 104(%rcx)
	movq	$1, 80(%rcx)
	andq	%rdi, %r15
	andq	%rdi, %rbx
	andq	%rdi, %r14
	movq	%rbx, 336(%rsp)
	movq	%r14, 344(%rsp)
	movq	%rbp, 352(%rsp)
	movq	%r12, 360(%rsp)
	movq	%r15, 368(%rsp)
	leaq	d(%rip), %rdx
	leaq	296(%rsp), %rdi
	leaq	336(%rsp), %rsi
	callq	fe_mul_impl
	leaq	(%rbx,%r13), %rcx
	addq	$-37, %rcx
	movq	%rcx, %rax
	shrq	$51, %rax
	addq	%r14, %rax
	addq	%r13, %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	%r13, %rbp
	addq	%rdx, %rbp
	movq	%rbp, %rdx
	shrq	$51, %rdx
	addq	%r13, %r12
	addq	%rdx, %r12
	movq	%r12, %rdx
	shrq	$51, %rdx
	addq	%r13, %r15
	addq	%rdx, %r15
	movabsq	$2251799813685247, %rdi         # imm = 0x7FFFFFFFFFFFF
	andq	%rdi, %rcx
	movq	%r15, %rdx
	shrq	$51, %rdx
	leaq	(%rdx,%rdx,8), %rsi
	leaq	(%rdx,%rsi,2), %rdx
	addq	%rcx, %rdx
	movq	%rdx, %rcx
	shrq	$51, %rcx
	andq	%rdi, %rax
	addq	%rcx, %rax
	andq	%rdi, %rdx
	movq	%rax, %rcx
	andq	%rdi, %rcx
	shrq	$51, %rax
	andq	%rdi, %rbp
	addq	%rax, %rbp
	andq	%rdi, %r12
	andq	%rdi, %r15
	movq	%rdx, 280(%rsp)                 # 8-byte Spill
	movq	%rdx, 456(%rsp)
	movq	%rcx, 272(%rsp)                 # 8-byte Spill
	movq	%rcx, 464(%rsp)
	movq	%rbp, 288(%rsp)                 # 8-byte Spill
	movq	%rbp, 472(%rsp)
	movq	%r12, 440(%rsp)                 # 8-byte Spill
	movq	%r12, 480(%rsp)
	movq	%r15, 448(%rsp)                 # 8-byte Spill
	movq	%r15, 488(%rsp)
	movq	296(%rsp), %rax
	incq	%rax
	movq	%rax, 496(%rsp)
	movups	304(%rsp), %xmm0
	movups	%xmm0, 504(%rsp)
	movups	320(%rsp), %xmm0
	movups	%xmm0, 520(%rsp)
	leaq	456(%rsp), %rsi
	leaq	496(%rsp), %rdx
	leaq	336(%rsp), %rdi
	callq	fe_mul_impl
	movq	368(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r8
	movq	360(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r8
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	352(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r8
	movq	%rdx, %r10
	movq	%rax, %rdi
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	addq	%rcx, %rcx
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	movq	344(%rsp), %r13
	movq	%r13, %rax
	mulq	%r8
	movq	%rax, %r8
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%rcx
	movq	%rdx, %r9
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %r15
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rsi
	leaq	(%rbx,%rbx), %rdx
	movq	336(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 232(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	%r13, %rcx
	addq	%r13, %rcx
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, %r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rbp
	addq	40(%rsp), %r8                   # 8-byte Folded Reload
	adcq	48(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r8
	adcq	%rdx, %r14
	shldq	$13, %r8, %r14
	movabsq	$2251799813685247, %rax         # imm = 0x7FFFFFFFFFFFF
	andq	%rax, %r8
	movq	24(%rsp), %rcx                  # 8-byte Reload
	addq	72(%rsp), %rcx                  # 8-byte Folded Reload
	adcq	80(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %rcx
	adcq	232(%rsp), %r9                  # 8-byte Folded Reload
	addq	88(%rsp), %r15                  # 8-byte Folded Reload
	movq	8(%rsp), %r11                   # 8-byte Reload
	adcq	96(%rsp), %r11                  # 8-byte Folded Reload
	addq	136(%rsp), %r15                 # 8-byte Folded Reload
	adcq	16(%rsp), %r11                  # 8-byte Folded Reload
	addq	104(%rsp), %r12                 # 8-byte Folded Reload
	adcq	112(%rsp), %rsi                 # 8-byte Folded Reload
	addq	32(%rsp), %r12                  # 8-byte Folded Reload
	adcq	56(%rsp), %rsi                  # 8-byte Folded Reload
	addq	120(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	128(%rsp), %r10                 # 8-byte Folded Reload
	addq	64(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	%r13, %r10
	addq	%r14, %rdi
	adcq	$0, %r10
	shldq	$13, %rdi, %r10
	andq	%rax, %rdi
	addq	%r12, %r10
	adcq	$0, %rsi
	shldq	$13, %r10, %rsi
	andq	%rax, %r10
	addq	%r15, %rsi
	adcq	$0, %r11
	shldq	$13, %rsi, %r11
	andq	%rax, %rsi
	addq	%rcx, %r11
	adcq	$0, %r9
	shldq	$13, %r11, %r9
	andq	%rax, %r11
	movq	%rax, %r14
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	addq	%r8, %r9
	movq	%r9, %r8
	shrq	$51, %r8
	addq	%rdi, %r8
	movq	%r8, %rbx
	shrq	$51, %rbx
	addq	%r10, %rbx
	leaq	(%r11,%r11,8), %rax
	leaq	(%r11,%rax,2), %rdx
	imulq	$38, %r11, %rcx
	movq	%rsi, %rdi
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rsi
	movq	%r11, %rax
	movq	%r11, 8(%rsp)                   # 8-byte Spill
	mulq	%rdx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rsi
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	imulq	$38, %rdi, %rsi
	movq	%rdi, 128(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	%rcx
	movq	%rdx, %r10
	movq	%rax, %r13
	movq	%rbx, %rax
	mulq	%rsi
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rbx, 120(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	andq	%r14, %r8
	movq	%r8, %rax
	mulq	%rcx
	movq	%rax, 264(%rsp)                 # 8-byte Spill
	movq	%rdx, 232(%rsp)                 # 8-byte Spill
	leaq	(%rdi,%rdi), %rcx
	movq	%r8, %rax
	mulq	%rcx
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rbx,%rbx), %rdi
	movq	%rdi, %rax
	mulq	%r8
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	%r8, %rax
	mulq	%r8
	movq	%rax, %r12
	movq	%rdx, %rbx
	andq	%r14, %r9
	movq	%r14, %rsi
	leaq	(%r11,%r11), %rdx
	movq	%r9, %rax
	mulq	%rdx
	movq	%rdx, %r14
	movq	%rax, %rbp
	movq	%r9, %rax
	mulq	%rcx
	movq	%rdx, %r15
	movq	%rax, %r11
	movq	%rdi, %rax
	mulq	%r9
	movq	%rax, %rdi
	movq	%rdx, 248(%rsp)                 # 8-byte Spill
	leaq	(%r8,%r8), %rax
	mulq	%r9
	movq	%rdx, %rcx
	movq	%rax, 256(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r9
	addq	264(%rsp), %rax                 # 8-byte Folded Reload
	adcq	232(%rsp), %rdx                 # 8-byte Folded Reload
	addq	136(%rsp), %rax                 # 8-byte Folded Reload
	adcq	16(%rsp), %rdx                  # 8-byte Folded Reload
	shldq	$13, %rax, %rdx
	andq	%rsi, %rax
	addq	24(%rsp), %r12                  # 8-byte Folded Reload
	adcq	32(%rsp), %rbx                  # 8-byte Folded Reload
	addq	%rdi, %r12
	adcq	248(%rsp), %rbx                 # 8-byte Folded Reload
	addq	40(%rsp), %r13                  # 8-byte Folded Reload
	adcq	48(%rsp), %r10                  # 8-byte Folded Reload
	addq	256(%rsp), %r13                 # 8-byte Folded Reload
	adcq	%rcx, %r10
	addq	%rdx, %r13
	adcq	$0, %r10
	movq	%r10, %rcx
	shrq	$51, %rcx
	shldq	$13, %r13, %r10
	andq	%rsi, %r13
	addq	%r12, %r10
	adcq	%rbx, %rcx
	movq	%rcx, %rdx
	shrq	$51, %rdx
	shldq	$13, %r10, %rcx
	andq	%rsi, %r10
	addq	88(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %r15                 # 8-byte Folded Reload
	addq	56(%rsp), %r11                  # 8-byte Folded Reload
	adcq	64(%rsp), %r15                  # 8-byte Folded Reload
	addq	%rcx, %r11
	adcq	%rdx, %r15
	movq	%r15, %rcx
	shrq	$51, %rcx
	shldq	$13, %r11, %r15
	andq	%rsi, %r11
	addq	72(%rsp), %rbp                  # 8-byte Folded Reload
	adcq	80(%rsp), %r14                  # 8-byte Folded Reload
	addq	96(%rsp), %rbp                  # 8-byte Folded Reload
	adcq	112(%rsp), %r14                 # 8-byte Folded Reload
	addq	%r15, %rbp
	adcq	%rcx, %r14
	shldq	$13, %rbp, %r14
	andq	%rsi, %rbp
	leaq	(%r14,%r14,8), %rcx
	leaq	(%r14,%rcx,2), %r15
	addq	%rax, %r15
	movq	%r15, %rbx
	shrq	$51, %rbx
	addq	%r13, %rbx
	andq	%rsi, %r15
	movq	%rbx, %rdi
	shrq	$51, %rdi
	addq	%r10, %rdi
	andq	%rsi, %rbx
	leaq	(,%rbp,8), %rax
	addq	%rbp, %rax
	leaq	(,%rax,2), %rdx
	addq	%rbp, %rdx
	imulq	$38, %rbp, %rcx
	leaq	(%r11,%r11,8), %rax
	leaq	(%r11,%rax,2), %rsi
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%rcx
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%rsi
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%rbp, %rsi
	addq	%rbp, %rsi
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rax, %rbp
	movq	%rdx, %r10
	imulq	$38, %r11, %rdx
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	leaq	(%r11,%r11), %r12
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	%rcx
	movq	%rdx, 232(%rsp)                 # 8-byte Spill
	movq	%rax, 264(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r12
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rdi,%rdi), %rcx
	movq	%rcx, %rax
	mulq	%rbx
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rdx, %r11
	movq	%rax, %rdi
	movq	%r15, %rax
	mulq	%rsi
	movq	%rax, %r14
	movq	%rdx, %r13
	leaq	(%rbx,%rbx), %rsi
	movq	%r15, %rax
	mulq	%r12
	movq	%rdx, %rbx
	movq	%rax, %r12
	movq	%rcx, %rax
	mulq	%r15
	movq	%rdx, 432(%rsp)                 # 8-byte Spill
	movq	%rax, %rcx
	movq	%rsi, %rax
	mulq	%r15
	movq	%rdx, 256(%rsp)                 # 8-byte Spill
	movq	%rax, 248(%rsp)                 # 8-byte Spill
	movq	%r15, %rax
	mulq	%r15
	addq	264(%rsp), %rax                 # 8-byte Folded Reload
	adcq	232(%rsp), %rdx                 # 8-byte Folded Reload
	addq	136(%rsp), %rax                 # 8-byte Folded Reload
	adcq	16(%rsp), %rdx                  # 8-byte Folded Reload
	shldq	$13, %rax, %rdx
	movabsq	$2251799813685247, %rsi         # imm = 0x7FFFFFFFFFFFF
	andq	%rsi, %rax
	addq	24(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	32(%rsp), %r11                  # 8-byte Folded Reload
	addq	%rcx, %rdi
	adcq	432(%rsp), %r11                 # 8-byte Folded Reload
	addq	40(%rsp), %rbp                  # 8-byte Folded Reload
	adcq	48(%rsp), %r10                  # 8-byte Folded Reload
	movq	%r9, 192(%rsp)
	addq	248(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	256(%rsp), %r10                 # 8-byte Folded Reload
	movq	%r8, 200(%rsp)
	addq	%rdx, %rbp
	adcq	$0, %r10
	movq	%r10, %rcx
	shrq	$51, %rcx
	shldq	$13, %rbp, %r10
	andq	%rsi, %rbp
	addq	%rdi, %r10
	adcq	%r11, %rcx
	movq	%rcx, %rdx
	shrq	$51, %rdx
	shldq	$13, %r10, %rcx
	andq	%rsi, %r10
	movq	%rsi, %rdi
	addq	104(%rsp), %r12                 # 8-byte Folded Reload
	adcq	112(%rsp), %rbx                 # 8-byte Folded Reload
	movq	120(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, 208(%rsp)
	addq	56(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rbx                  # 8-byte Folded Reload
	movq	128(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, 216(%rsp)
	addq	72(%rsp), %r14                  # 8-byte Folded Reload
	adcq	80(%rsp), %r13                  # 8-byte Folded Reload
	movq	8(%rsp), %rsi                   # 8-byte Reload
	movq	%rsi, 224(%rsp)
	addq	88(%rsp), %r14                  # 8-byte Folded Reload
	adcq	96(%rsp), %r13                  # 8-byte Folded Reload
	addq	%rcx, %r12
	adcq	%rdx, %rbx
	movq	%rbx, %rcx
	shrq	$51, %rcx
	shldq	$13, %r12, %rbx
	addq	%r14, %rbx
	adcq	%r13, %rcx
	shldq	$13, %rbx, %rcx
	movq	%rbx, %xmm0
	movq	%r12, %xmm1
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rcx
	addq	%rax, %rcx
	movq	%rcx, %rax
	shrq	$51, %rax
	addq	%rbp, %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	%r10, %rdx
	andq	%rdi, %rcx
	movq	%rcx, 144(%rsp)
	andq	%rdi, %rax
	movq	%rax, 152(%rsp)
	movq	%rdx, 160(%rsp)
	punpcklqdq	%xmm0, %xmm1            # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI104_0(%rip), %xmm1
	movdqu	%xmm1, 168(%rsp)
	leaq	144(%rsp), %rbx
	movq	%rbx, %rdi
	leaq	336(%rsp), %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	192(%rsp), %rdi
	movq	%rdi, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	224(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r9
	movq	216(%rsp), %rdi
	leaq	(%rdi,%rdi,8), %rcx
	leaq	(%rdi,%rcx,2), %rcx
	imulq	$38, %rdi, %r10
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%r9
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	208(%rsp), %r8
	movq	%rcx, %rax
	mulq	%rdi
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%r9
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	%r8, %rax
	mulq	%r10
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rdi,%rdi), %r15
	movq	%r8, %rax
	mulq	%r8
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	200(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%r9
	movq	%rax, %rdi
	movq	%rdx, %r14
	leaq	(%r8,%r8), %r10
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r8
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r10
	movq	%rdx, %r9
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rbp
	movq	%rax, %r12
	movq	%rdx, %r11
	leaq	(%rbx,%rbx), %rdx
	movq	192(%rsp), %r13
	movq	%r13, %rax
	mulq	%rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%r13, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rbp, %r15
	addq	%rbp, %r15
	movq	%r13, %rax
	mulq	%r10
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %rbp
	movq	%r13, %rax
	mulq	%r13
	addq	48(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %rdi
	adcq	%rdx, %r14
	shldq	$13, %rdi, %r14
	movabsq	$2251799813685247, %r10         # imm = 0x7FFFFFFFFFFFF
	andq	%r10, %rdi
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r8                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	136(%rsp), %r8                  # 8-byte Folded Reload
	movq	72(%rsp), %rdx                  # 8-byte Reload
	addq	96(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	104(%rsp), %r9                  # 8-byte Folded Reload
	addq	16(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	24(%rsp), %r9                   # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	120(%rsp), %r11                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %r11                  # 8-byte Folded Reload
	addq	128(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	8(%rsp), %rcx                   # 8-byte Folded Reload
	addq	%rbp, %rsi
	adcq	%r15, %rcx
	addq	%r14, %rsi
	adcq	$0, %rcx
	shldq	$13, %rsi, %rcx
	andq	%r10, %rsi
	addq	%r12, %rcx
	adcq	$0, %r11
	shldq	$13, %rcx, %r11
	andq	%r10, %rcx
	addq	%rdx, %r11
	adcq	$0, %r9
	shldq	$13, %r11, %r9
	addq	%rax, %r9
	adcq	$0, %r8
	shldq	$13, %r9, %r8
	movq	%r9, %xmm0
	movq	%r11, %xmm1
	leaq	(%r8,%r8,8), %rax
	leaq	(%r8,%rax,2), %rax
	addq	%rdi, %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	%rsi, %rdx
	movq	%rdx, %rsi
	shrq	$51, %rsi
	addq	%rcx, %rsi
	andq	%r10, %rax
	movq	%rax, 192(%rsp)
	andq	%r10, %rdx
	movq	%rdx, 200(%rsp)
	movq	%rsi, 208(%rsp)
	punpcklqdq	%xmm0, %xmm1            # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI104_0(%rip), %xmm1
	movdqu	%xmm1, 216(%rsp)
	leaq	192(%rsp), %rdi
	leaq	144(%rsp), %rsi
	movq	%rdi, %rdx
	callq	fe_mul_impl
	movq	224(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r9
	movq	216(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r10
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r9
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	208(%rsp), %r8
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%r9
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r8, %rax
	mulq	%r10
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r8, %rax
	mulq	%r8
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	200(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%r9
	movq	%rax, %r9
	movq	%rdx, %r14
	leaq	(%r8,%r8), %r11
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r10
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, %r8
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rbp
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	192(%rsp), %r13
	movq	%r13, %rax
	mulq	%rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%r13, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rbp, %r15
	addq	%rbp, %r15
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %rbp
	movq	%r13, %rax
	mulq	%r13
	addq	48(%rsp), %r9                   # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r9
	adcq	%rdx, %r14
	shldq	$13, %r9, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r9
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r10                  # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	136(%rsp), %r10                 # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %r8                  # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %r8                   # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	120(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	128(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	8(%rsp), %rsi                   # 8-byte Folded Reload
	addq	%rbp, %rdi
	adcq	%r15, %rsi
	addq	%r14, %rdi
	adcq	$0, %rsi
	shldq	$13, %rdi, %rsi
	andq	%rdx, %rdi
	addq	%r12, %rsi
	adcq	$0, %rcx
	shldq	$13, %rsi, %rcx
	andq	%rdx, %rsi
	addq	%r11, %rcx
	adcq	$0, %r8
	shldq	$13, %rcx, %r8
	andq	%rdx, %rcx
	addq	%rax, %r8
	adcq	$0, %r10
	shldq	$13, %r8, %r10
	andq	%rdx, %r8
	leaq	(%r10,%r10,8), %rax
	leaq	(%r10,%rax,2), %r13
	addq	%r9, %r13
	movq	%r13, %rbp
	shrq	$51, %rbp
	addq	%rdi, %rbp
	andq	%rdx, %r13
	movq	%rbp, %rdi
	shrq	$51, %rdi
	addq	%rsi, %rdi
	andq	%rdx, %rbp
	leaq	(%r8,%r8,8), %rax
	leaq	(%r8,%rax,2), %rdx
	imulq	$38, %r8, %r9
	leaq	(%r8,%r8), %rbx
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rsi
	movq	%r8, %rax
	mulq	%rdx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r9
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	imulq	$38, %rcx, %r10
	movq	%rcx, %rax
	mulq	%rsi
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, %rsi
	movq	%rax, %r8
	movq	%rdi, %rax
	mulq	%r10
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r9
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	leaq	(%rdi,%rdi), %r11
	movq	%r11, %rax
	mulq	%rbp
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rbp
	movq	%rdx, %r9
	movq	%rax, %r10
	movq	%r13, %rax
	mulq	%rbx
	movq	%rax, %rcx
	movq	%rdx, %r14
	movq	%rbp, %rbx
	addq	%rbp, %rbx
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %rbp
	movq	%rax, %rdi
	movq	%r11, %rax
	mulq	%r13
	movq	%rdx, %r15
	movq	%rax, %r11
	movq	%rbx, %rax
	mulq	%r13
	movq	%rdx, %r12
	movq	%rax, %rbx
	movq	%r13, %rax
	mulq	%r13
	addq	16(%rsp), %rax                  # 8-byte Folded Reload
	adcq	24(%rsp), %rdx                  # 8-byte Folded Reload
	addq	32(%rsp), %rax                  # 8-byte Folded Reload
	adcq	40(%rsp), %rdx                  # 8-byte Folded Reload
	shldq	$13, %rax, %rdx
	movabsq	$2251799813685247, %r13         # imm = 0x7FFFFFFFFFFFF
	andq	%r13, %rax
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r9                   # 8-byte Folded Reload
	addq	%r11, %r10
	adcq	%r15, %r9
	addq	64(%rsp), %r8                   # 8-byte Folded Reload
	adcq	72(%rsp), %rsi                  # 8-byte Folded Reload
	addq	%rbx, %r8
	adcq	%r12, %rsi
	addq	%rdx, %r8
	adcq	$0, %rsi
	movq	%rsi, %rdx
	shrq	$51, %rdx
	shldq	$13, %r8, %rsi
	andq	%r13, %r8
	addq	%r10, %rsi
	adcq	%r9, %rdx
	movq	%rdx, %r9
	shrq	$51, %r9
	shldq	$13, %rsi, %rdx
	andq	%r13, %rsi
	addq	112(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	128(%rsp), %rbp                 # 8-byte Folded Reload
	addq	80(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	88(%rsp), %rbp                  # 8-byte Folded Reload
	addq	%rdx, %rdi
	adcq	%r9, %rbp
	movq	%rbp, %rdx
	shrq	$51, %rdx
	shldq	$13, %rdi, %rbp
	movq	%r13, %r9
	andq	%r13, %rdi
	addq	96(%rsp), %rcx                  # 8-byte Folded Reload
	adcq	104(%rsp), %r14                 # 8-byte Folded Reload
	addq	120(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	8(%rsp), %r14                   # 8-byte Folded Reload
	addq	%rbp, %rcx
	adcq	%rdx, %r14
	shldq	$13, %rcx, %r14
	andq	%r13, %rcx
	leaq	(%r14,%r14,8), %rdx
	leaq	(%r14,%rdx,2), %r13
	addq	%rax, %r13
	movq	%r13, %rbp
	shrq	$51, %rbp
	addq	%r8, %rbp
	movq	%r9, %rax
	andq	%r9, %r13
	movq	%rbp, %r9
	shrq	$51, %r9
	addq	%rsi, %r9
	andq	%rax, %rbp
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdx
	imulq	$38, %rcx, %r10
	leaq	(%rcx,%rcx), %rsi
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rdi,%rax,2), %r8
	movq	%rcx, %rax
	mulq	%rdx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%r10
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	imulq	$38, %rdi, %r11
	movq	%rdi, %rax
	mulq	%r8
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rcx
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	leaq	(%rdi,%rdi), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r10
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	leaq	(%r9,%r9), %r11
	movq	%r11, %rax
	mulq	%rbp
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rbp
	movq	%rdx, %r9
	movq	%rax, %r10
	movq	%r13, %rax
	mulq	%rsi
	movq	%rax, %rdi
	movq	%rdx, %r14
	movq	%rbp, %rbx
	addq	%rbp, %rbx
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %rbp
	movq	%rax, %rsi
	movq	%r11, %rax
	mulq	%r13
	movq	%rdx, %r15
	movq	%rax, %r11
	movq	%rbx, %rax
	mulq	%r13
	movq	%rdx, %r12
	movq	%rax, %rbx
	movq	%r13, %rax
	mulq	%r13
	addq	16(%rsp), %rax                  # 8-byte Folded Reload
	adcq	24(%rsp), %rdx                  # 8-byte Folded Reload
	addq	32(%rsp), %rax                  # 8-byte Folded Reload
	adcq	40(%rsp), %rdx                  # 8-byte Folded Reload
	shldq	$13, %rax, %rdx
	movabsq	$2251799813685247, %r13         # imm = 0x7FFFFFFFFFFFF
	andq	%r13, %rax
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r9                   # 8-byte Folded Reload
	addq	%r11, %r10
	adcq	%r15, %r9
	addq	64(%rsp), %r8                   # 8-byte Folded Reload
	adcq	72(%rsp), %rcx                  # 8-byte Folded Reload
	addq	%rbx, %r8
	adcq	%r12, %rcx
	addq	%rdx, %r8
	adcq	$0, %rcx
	movq	%rcx, %rdx
	shrq	$51, %rdx
	shldq	$13, %r8, %rcx
	andq	%r13, %r8
	addq	%r10, %rcx
	adcq	%r9, %rdx
	movq	%rdx, %r9
	shrq	$51, %r9
	shldq	$13, %rcx, %rdx
	andq	%r13, %rcx
	addq	112(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	128(%rsp), %rbp                 # 8-byte Folded Reload
	addq	80(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	88(%rsp), %rbp                  # 8-byte Folded Reload
	addq	%rdx, %rsi
	adcq	%r9, %rbp
	movq	%rbp, %rdx
	shrq	$51, %rdx
	shldq	$13, %rsi, %rbp
	movq	%r13, %r9
	andq	%r13, %rsi
	addq	96(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	104(%rsp), %r14                 # 8-byte Folded Reload
	addq	120(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	8(%rsp), %r14                   # 8-byte Folded Reload
	addq	%rbp, %rdi
	adcq	%rdx, %r14
	shldq	$13, %rdi, %r14
	andq	%r13, %rdi
	leaq	(%r14,%r14,8), %rdx
	leaq	(%r14,%rdx,2), %r13
	addq	%rax, %r13
	movq	%r13, %rbp
	shrq	$51, %rbp
	addq	%r8, %rbp
	andq	%r9, %r13
	movq	%rbp, %r8
	shrq	$51, %r8
	addq	%rcx, %r8
	andq	%r9, %rbp
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rdi,%rax,2), %rcx
	imulq	$38, %rdi, %r9
	leaq	(%rdi,%rdi), %rbx
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %r10
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	%r9
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	imulq	$38, %rsi, %r11
	movq	%rsi, %rax
	mulq	%r10
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%r8, %rax
	mulq	%r9
	movq	%rdx, %rcx
	movq	%rax, %rdi
	movq	%r8, %rax
	mulq	%r11
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	addq	%rsi, %rsi
	movq	%r8, %rax
	mulq	%r8
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r9
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rsi
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	leaq	(%r8,%r8), %r11
	movq	%r11, %rax
	mulq	%rbp
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rbp
	movq	%rdx, %r9
	movq	%rax, %r10
	movq	%r13, %rax
	mulq	%rbx
	movq	%rax, %r8
	movq	%rdx, %r14
	movq	%rbp, %rbx
	addq	%rbp, %rbx
	movq	%r13, %rax
	mulq	%rsi
	movq	%rdx, %rbp
	movq	%rax, %rsi
	movq	%r11, %rax
	mulq	%r13
	movq	%rdx, %r15
	movq	%rax, %r11
	movq	%rbx, %rax
	mulq	%r13
	movq	%rdx, %r12
	movq	%rax, %rbx
	movq	%r13, %rax
	mulq	%r13
	addq	16(%rsp), %rax                  # 8-byte Folded Reload
	adcq	24(%rsp), %rdx                  # 8-byte Folded Reload
	addq	32(%rsp), %rax                  # 8-byte Folded Reload
	adcq	40(%rsp), %rdx                  # 8-byte Folded Reload
	shldq	$13, %rax, %rdx
	movabsq	$2251799813685247, %r13         # imm = 0x7FFFFFFFFFFFF
	andq	%r13, %rax
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r9                   # 8-byte Folded Reload
	addq	%r11, %r10
	adcq	%r15, %r9
	addq	64(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	72(%rsp), %rcx                  # 8-byte Folded Reload
	addq	%rbx, %rdi
	adcq	%r12, %rcx
	addq	%rdx, %rdi
	adcq	$0, %rcx
	movq	%rcx, %rdx
	shrq	$51, %rdx
	shldq	$13, %rdi, %rcx
	andq	%r13, %rdi
	addq	%r10, %rcx
	adcq	%r9, %rdx
	movq	%rdx, %r9
	shrq	$51, %r9
	shldq	$13, %rcx, %rdx
	andq	%r13, %rcx
	addq	112(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	128(%rsp), %rbp                 # 8-byte Folded Reload
	addq	80(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	88(%rsp), %rbp                  # 8-byte Folded Reload
	addq	%rdx, %rsi
	adcq	%r9, %rbp
	movq	%rbp, %rdx
	shrq	$51, %rdx
	shldq	$13, %rsi, %rbp
	movq	%r13, %r9
	andq	%r13, %rsi
	addq	96(%rsp), %r8                   # 8-byte Folded Reload
	adcq	104(%rsp), %r14                 # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	8(%rsp), %r14                   # 8-byte Folded Reload
	addq	%rbp, %r8
	adcq	%rdx, %r14
	shldq	$13, %r8, %r14
	andq	%r13, %r8
	leaq	(%r14,%r14,8), %rdx
	leaq	(%r14,%rdx,2), %r13
	addq	%rax, %r13
	movq	%r13, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r9, %rax
	andq	%r9, %r13
	movq	%r11, %r9
	shrq	$51, %r9
	addq	%rcx, %r9
	andq	%rax, %r11
	leaq	(%r8,%r8,8), %rax
	leaq	(%r8,%rax,2), %rcx
	imulq	$38, %r8, %rbx
	leaq	(%r8,%r8), %r10
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rdi
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	%rbx
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	imulq	$38, %rsi, %r8
	movq	%rsi, %rax
	mulq	%rdi
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%rbx
	movq	%rdx, %rcx
	movq	%rax, %rdi
	movq	%r9, %rax
	mulq	%r8
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	leaq	(%rsi,%rsi), %r14
	movq	%r9, %rax
	mulq	%r9
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%rbx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r14
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	leaq	(%r9,%r9), %r8
	movq	%r8, %rax
	mulq	%r11
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, %r9
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r15
	movq	%rdx, %rbx
	leaq	(%r11,%r11), %r10
	movq	%r13, %rax
	mulq	%r14
	movq	%rdx, %r14
	movq	%rax, %r11
	movq	%r8, %rax
	mulq	%r13
	movq	%rdx, %r12
	movq	%rax, %r8
	movq	%r10, %rax
	mulq	%r13
	movq	%rdx, %rbp
	movq	%rax, %r10
	movq	%r13, %rax
	mulq	%r13
	addq	16(%rsp), %rax                  # 8-byte Folded Reload
	adcq	24(%rsp), %rdx                  # 8-byte Folded Reload
	addq	32(%rsp), %rax                  # 8-byte Folded Reload
	adcq	40(%rsp), %rdx                  # 8-byte Folded Reload
	shldq	$13, %rax, %rdx
	movabsq	$2251799813685247, %r13         # imm = 0x7FFFFFFFFFFFF
	andq	%r13, %rax
	addq	48(%rsp), %r9                   # 8-byte Folded Reload
	adcq	56(%rsp), %rsi                  # 8-byte Folded Reload
	addq	%r8, %r9
	adcq	%r12, %rsi
	addq	64(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	72(%rsp), %rcx                  # 8-byte Folded Reload
	addq	%r10, %rdi
	adcq	%rbp, %rcx
	addq	%rdx, %rdi
	adcq	$0, %rcx
	movq	%rcx, %rdx
	shrq	$51, %rdx
	shldq	$13, %rdi, %rcx
	andq	%r13, %rdi
	addq	%r9, %rcx
	adcq	%rsi, %rdx
	movq	%rdx, %rsi
	shrq	$51, %rsi
	shldq	$13, %rcx, %rdx
	andq	%r13, %rcx
	addq	128(%rsp), %r11                 # 8-byte Folded Reload
	adcq	8(%rsp), %r14                   # 8-byte Folded Reload
	addq	80(%rsp), %r11                  # 8-byte Folded Reload
	adcq	88(%rsp), %r14                  # 8-byte Folded Reload
	addq	96(%rsp), %r15                  # 8-byte Folded Reload
	adcq	104(%rsp), %rbx                 # 8-byte Folded Reload
	addq	112(%rsp), %r15                 # 8-byte Folded Reload
	adcq	120(%rsp), %rbx                 # 8-byte Folded Reload
	addq	%rdx, %r11
	adcq	%rsi, %r14
	movq	%r14, %rdx
	shrq	$51, %rdx
	shldq	$13, %r11, %r14
	addq	%r15, %r14
	adcq	%rbx, %rdx
	shldq	$13, %r14, %rdx
	movq	%r14, %xmm0
	movq	%r11, %xmm1
	leaq	(%rdx,%rdx,8), %rsi
	leaq	(%rdx,%rsi,2), %rdx
	addq	%rax, %rdx
	movq	%rdx, %rax
	shrq	$51, %rax
	addq	%rdi, %rax
	movq	%rax, %rsi
	shrq	$51, %rsi
	addq	%rcx, %rsi
	punpcklqdq	%xmm0, %xmm1            # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI104_0(%rip), %xmm1
	movdqu	%xmm1, 168(%rsp)
	movq	%rsi, 160(%rsp)
	andq	%r13, %rax
	movq	%rax, 152(%rsp)
	andq	%r13, %rdx
	movq	%rdx, 144(%rsp)
	leaq	192(%rsp), %rdi
	leaq	144(%rsp), %rsi
	movq	%rdi, %rdx
	callq	fe_mul_impl
	movq	224(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r10
	movq	216(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	208(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	200(%rsp), %r13
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	192(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r14
	shldq	$13, %r10, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r10
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	136(%rsp), %r9                  # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %rsi                 # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	120(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	128(%rsp), %r8                  # 8-byte Folded Reload
	adcq	8(%rsp), %rdi                   # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r14, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%r12, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%r11, %rcx
	adcq	$0, %rsi
	shldq	$13, %rcx, %rsi
	andq	%rdx, %rcx
	addq	%rax, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	andq	%rdx, %rsi
	addq	%r10, %r9
	movq	%r9, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	andq	%rdx, %r9
	movq	%rbx, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	andq	%rdx, %rbx
	movl	$9, %eax
	.p2align	4, 0x90
.LBB104_1:                              # =>This Inner Loop Header: Depth=1
	movl	%eax, 8(%rsp)                   # 4-byte Spill
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	imulq	$38, %rsi, %r10
	mulq	%rsi
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rdi
	imulq	$38, %rcx, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	leaq	(%r11,%r11), %r13
	movq	%rbx, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %r12
	movq	%rbx, %rax
	mulq	%r15
	movq	%rdx, %r14
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %rsi
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rax, %rbp
	movq	%rdx, %rcx
	movq	%r9, %rax
	mulq	%rsi
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	leaq	(%rbx,%rbx), %r15
	movq	%r9, %rax
	mulq	%r13
	movq	%rax, %rbx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	%r9
	addq	40(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %r12                  # 8-byte Folded Reload
	addq	%rax, %r11
	adcq	%rdx, %r12
	shldq	$13, %r11, %r12
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r11
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	136(%rsp), %r14                 # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	addq	104(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	112(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rbx, %rbp
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r12, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%rbp, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rsi, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	addq	%rax, %r10
	adcq	$0, %r14
	shldq	$13, %r10, %r14
	leaq	(%r14,%r14,8), %rax
	leaq	(%r14,%rax,2), %r9
	movl	8(%rsp), %eax                   # 4-byte Reload
	addq	%r11, %r9
	movq	%r9, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	movq	%rbx, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r10, %rsi
	andq	%rdx, %rsi
	andq	%rdx, %r9
	andq	%rdx, %rbx
	decl	%eax
	jne	.LBB104_1
# %bb.2:
	movq	%rsi, 176(%rsp)
	movq	%rcx, 168(%rsp)
	movq	%r11, 160(%rsp)
	movq	%rbx, 152(%rsp)
	movq	%r9, 144(%rsp)
	leaq	144(%rsp), %rdi
	leaq	192(%rsp), %rdx
	movq	%rdi, %rsi
	callq	fe_mul_impl
	movq	176(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r10
	movq	168(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	160(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	152(%rsp), %r13
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	144(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r14
	shldq	$13, %r10, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r10
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	136(%rsp), %r9                  # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %rsi                 # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	120(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	128(%rsp), %r8                  # 8-byte Folded Reload
	adcq	8(%rsp), %rdi                   # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r14, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%r12, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%r11, %rcx
	adcq	$0, %rsi
	shldq	$13, %rcx, %rsi
	andq	%rdx, %rcx
	addq	%rax, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	andq	%rdx, %rsi
	addq	%r10, %r9
	movq	%r9, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	andq	%rdx, %r9
	movq	%rbx, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	andq	%rdx, %rbx
	movl	$19, %eax
	.p2align	4, 0x90
.LBB104_3:                              # =>This Inner Loop Header: Depth=1
	movl	%eax, 8(%rsp)                   # 4-byte Spill
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	imulq	$38, %rsi, %r10
	mulq	%rsi
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rdi
	imulq	$38, %rcx, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	leaq	(%r11,%r11), %r13
	movq	%rbx, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %r12
	movq	%rbx, %rax
	mulq	%r15
	movq	%rdx, %r14
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %rsi
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rax, %rbp
	movq	%rdx, %rcx
	movq	%r9, %rax
	mulq	%rsi
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	leaq	(%rbx,%rbx), %r15
	movq	%r9, %rax
	mulq	%r13
	movq	%rax, %rbx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	%r9
	addq	40(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %r12                  # 8-byte Folded Reload
	addq	%rax, %r11
	adcq	%rdx, %r12
	shldq	$13, %r11, %r12
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r11
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	136(%rsp), %r14                 # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	addq	104(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	112(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rbx, %rbp
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r12, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%rbp, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rsi, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	addq	%rax, %r10
	adcq	$0, %r14
	shldq	$13, %r10, %r14
	leaq	(%r14,%r14,8), %rax
	leaq	(%r14,%rax,2), %r9
	movl	8(%rsp), %eax                   # 4-byte Reload
	addq	%r11, %r9
	movq	%r9, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	movq	%rbx, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r10, %rsi
	andq	%rdx, %rsi
	andq	%rdx, %r9
	andq	%rdx, %rbx
	decl	%eax
	jne	.LBB104_3
# %bb.4:
	movq	%rsi, 408(%rsp)
	movq	%rcx, 400(%rsp)
	movq	%r11, 392(%rsp)
	movq	%rbx, 384(%rsp)
	movq	%r9, 376(%rsp)
	leaq	376(%rsp), %rsi
	leaq	144(%rsp), %rdi
	movq	%rdi, %rdx
	callq	fe_mul_impl
	movq	176(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r10
	movq	168(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	160(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	152(%rsp), %r13
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	144(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r14
	shldq	$13, %r10, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r10
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	136(%rsp), %r9                  # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %rsi                 # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	120(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	128(%rsp), %r8                  # 8-byte Folded Reload
	adcq	8(%rsp), %rdi                   # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r14, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%r12, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%r11, %rcx
	adcq	$0, %rsi
	shldq	$13, %rcx, %rsi
	andq	%rdx, %rcx
	addq	%rax, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	andq	%rdx, %rsi
	addq	%r10, %r9
	movq	%r9, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	andq	%rdx, %r9
	movq	%rbx, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	andq	%rdx, %rbx
	movl	$9, %eax
	.p2align	4, 0x90
.LBB104_5:                              # =>This Inner Loop Header: Depth=1
	movl	%eax, 8(%rsp)                   # 4-byte Spill
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	imulq	$38, %rsi, %r10
	mulq	%rsi
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rdi
	imulq	$38, %rcx, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	leaq	(%r11,%r11), %r13
	movq	%rbx, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %r12
	movq	%rbx, %rax
	mulq	%r15
	movq	%rdx, %r14
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %rsi
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rax, %rbp
	movq	%rdx, %rcx
	movq	%r9, %rax
	mulq	%rsi
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	leaq	(%rbx,%rbx), %r15
	movq	%r9, %rax
	mulq	%r13
	movq	%rax, %rbx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	%r9
	addq	40(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %r12                  # 8-byte Folded Reload
	addq	%rax, %r11
	adcq	%rdx, %r12
	shldq	$13, %r11, %r12
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r11
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	136(%rsp), %r14                 # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	addq	104(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	112(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rbx, %rbp
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r12, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%rbp, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rsi, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	addq	%rax, %r10
	adcq	$0, %r14
	shldq	$13, %r10, %r14
	leaq	(%r14,%r14,8), %rax
	leaq	(%r14,%rax,2), %r9
	movl	8(%rsp), %eax                   # 4-byte Reload
	addq	%r11, %r9
	movq	%r9, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	movq	%rbx, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r10, %rsi
	andq	%rdx, %rsi
	andq	%rdx, %r9
	andq	%rdx, %rbx
	decl	%eax
	jne	.LBB104_5
# %bb.6:
	movq	%rsi, 176(%rsp)
	movq	%rcx, 168(%rsp)
	movq	%r11, 160(%rsp)
	movq	%rbx, 152(%rsp)
	movq	%r9, 144(%rsp)
	leaq	144(%rsp), %rsi
	leaq	192(%rsp), %rdi
	movq	%rdi, %rdx
	callq	fe_mul_impl
	movq	224(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r10
	movq	216(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	208(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	200(%rsp), %r13
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	192(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r14
	shldq	$13, %r10, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r10
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	136(%rsp), %r9                  # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %rsi                 # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	120(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	128(%rsp), %r8                  # 8-byte Folded Reload
	adcq	8(%rsp), %rdi                   # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r14, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%r12, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%r11, %rcx
	adcq	$0, %rsi
	shldq	$13, %rcx, %rsi
	andq	%rdx, %rcx
	addq	%rax, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	andq	%rdx, %rsi
	addq	%r10, %r9
	movq	%r9, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	andq	%rdx, %r9
	movq	%rbx, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	andq	%rdx, %rbx
	movl	$49, %eax
	.p2align	4, 0x90
.LBB104_7:                              # =>This Inner Loop Header: Depth=1
	movl	%eax, 8(%rsp)                   # 4-byte Spill
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	imulq	$38, %rsi, %r10
	mulq	%rsi
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rdi
	imulq	$38, %rcx, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	leaq	(%r11,%r11), %r13
	movq	%rbx, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %r12
	movq	%rbx, %rax
	mulq	%r15
	movq	%rdx, %r14
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %rsi
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rax, %rbp
	movq	%rdx, %rcx
	movq	%r9, %rax
	mulq	%rsi
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	leaq	(%rbx,%rbx), %r15
	movq	%r9, %rax
	mulq	%r13
	movq	%rax, %rbx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	%r9
	addq	40(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %r12                  # 8-byte Folded Reload
	addq	%rax, %r11
	adcq	%rdx, %r12
	shldq	$13, %r11, %r12
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r11
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	136(%rsp), %r14                 # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	addq	104(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	112(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rbx, %rbp
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r12, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%rbp, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rsi, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	addq	%rax, %r10
	adcq	$0, %r14
	shldq	$13, %r10, %r14
	leaq	(%r14,%r14,8), %rax
	leaq	(%r14,%rax,2), %r9
	movl	8(%rsp), %eax                   # 4-byte Reload
	addq	%r11, %r9
	movq	%r9, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	movq	%rbx, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r10, %rsi
	andq	%rdx, %rsi
	andq	%rdx, %r9
	andq	%rdx, %rbx
	decl	%eax
	jne	.LBB104_7
# %bb.8:
	movq	%rsi, 176(%rsp)
	movq	%rcx, 168(%rsp)
	movq	%r11, 160(%rsp)
	movq	%rbx, 152(%rsp)
	movq	%r9, 144(%rsp)
	leaq	144(%rsp), %rdi
	leaq	192(%rsp), %rdx
	movq	%rdi, %rsi
	callq	fe_mul_impl
	movq	176(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r10
	movq	168(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	160(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	152(%rsp), %r13
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	144(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r14
	shldq	$13, %r10, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r10
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	136(%rsp), %r9                  # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %rsi                 # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	120(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	128(%rsp), %r8                  # 8-byte Folded Reload
	adcq	8(%rsp), %rdi                   # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r14, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%r12, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%r11, %rcx
	adcq	$0, %rsi
	shldq	$13, %rcx, %rsi
	andq	%rdx, %rcx
	addq	%rax, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	andq	%rdx, %rsi
	addq	%r10, %r9
	movq	%r9, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	andq	%rdx, %r9
	movq	%rbx, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	andq	%rdx, %rbx
	movl	$99, %eax
	.p2align	4, 0x90
.LBB104_9:                              # =>This Inner Loop Header: Depth=1
	movl	%eax, 8(%rsp)                   # 4-byte Spill
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	imulq	$38, %rsi, %r10
	mulq	%rsi
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rdi
	imulq	$38, %rcx, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	leaq	(%r11,%r11), %r13
	movq	%rbx, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %r12
	movq	%rbx, %rax
	mulq	%r15
	movq	%rdx, %r14
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %rsi
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rax, %rbp
	movq	%rdx, %rcx
	movq	%r9, %rax
	mulq	%rsi
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	leaq	(%rbx,%rbx), %r15
	movq	%r9, %rax
	mulq	%r13
	movq	%rax, %rbx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	%r9
	addq	40(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %r12                  # 8-byte Folded Reload
	addq	%rax, %r11
	adcq	%rdx, %r12
	shldq	$13, %r11, %r12
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r11
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	136(%rsp), %r14                 # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	addq	104(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	112(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rbx, %rbp
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r12, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%rbp, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rsi, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	addq	%rax, %r10
	adcq	$0, %r14
	shldq	$13, %r10, %r14
	leaq	(%r14,%r14,8), %rax
	leaq	(%r14,%rax,2), %r9
	movl	8(%rsp), %eax                   # 4-byte Reload
	addq	%r11, %r9
	movq	%r9, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	movq	%rbx, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r10, %rsi
	andq	%rdx, %rsi
	andq	%rdx, %r9
	andq	%rdx, %rbx
	decl	%eax
	jne	.LBB104_9
# %bb.10:
	movq	%rsi, 408(%rsp)
	movq	%rcx, 400(%rsp)
	movq	%r11, 392(%rsp)
	movq	%rbx, 384(%rsp)
	movq	%r9, 376(%rsp)
	leaq	376(%rsp), %rsi
	leaq	144(%rsp), %rdi
	movq	%rdi, %rdx
	callq	fe_mul_impl
	movq	176(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r10
	movq	168(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	160(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	152(%rsp), %r13
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	144(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r14
	shldq	$13, %r10, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r10
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	136(%rsp), %r9                  # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %rsi                 # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	120(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	128(%rsp), %r8                  # 8-byte Folded Reload
	adcq	8(%rsp), %rdi                   # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r14, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%r12, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%r11, %rcx
	adcq	$0, %rsi
	shldq	$13, %rcx, %rsi
	andq	%rdx, %rcx
	addq	%rax, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	andq	%rdx, %rsi
	addq	%r10, %r9
	movq	%r9, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	andq	%rdx, %r9
	movq	%rbx, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	andq	%rdx, %rbx
	movl	$49, %eax
	.p2align	4, 0x90
.LBB104_11:                             # =>This Inner Loop Header: Depth=1
	movl	%eax, 8(%rsp)                   # 4-byte Spill
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	imulq	$38, %rsi, %r10
	mulq	%rsi
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rdi
	imulq	$38, %rcx, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	leaq	(%r11,%r11), %r13
	movq	%rbx, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %r12
	movq	%rbx, %rax
	mulq	%r15
	movq	%rdx, %r14
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %rsi
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rax, %rbp
	movq	%rdx, %rcx
	movq	%r9, %rax
	mulq	%rsi
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	leaq	(%rbx,%rbx), %r15
	movq	%r9, %rax
	mulq	%r13
	movq	%rax, %rbx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	%r9
	addq	40(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %r12                  # 8-byte Folded Reload
	addq	%rax, %r11
	adcq	%rdx, %r12
	shldq	$13, %r11, %r12
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r11
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	136(%rsp), %r14                 # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	addq	104(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	112(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rbx, %rbp
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r12, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%rbp, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rsi, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	addq	%rax, %r10
	adcq	$0, %r14
	shldq	$13, %r10, %r14
	leaq	(%r14,%r14,8), %rax
	leaq	(%r14,%rax,2), %r9
	movl	8(%rsp), %eax                   # 4-byte Reload
	addq	%r11, %r9
	movq	%r9, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	movq	%rbx, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r10, %rsi
	andq	%rdx, %rsi
	andq	%rdx, %r9
	andq	%rdx, %rbx
	decl	%eax
	jne	.LBB104_11
# %bb.12:
	movq	%rsi, 176(%rsp)
	movq	%rcx, 168(%rsp)
	movq	%r11, 160(%rsp)
	movq	%rbx, 152(%rsp)
	movq	%r9, 144(%rsp)
	leaq	144(%rsp), %rsi
	leaq	192(%rsp), %rdi
	movq	%rdi, %rdx
	callq	fe_mul_impl
	movq	224(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r9
	movq	216(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r10
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r9
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	208(%rsp), %r8
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%r9
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r8, %rax
	mulq	%r10
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r8, %rax
	mulq	%r8
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	200(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%r9
	movq	%rax, %r9
	movq	%rdx, %r14
	leaq	(%r8,%r8), %r11
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r10
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, %rcx
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rbp
	movq	%rax, %r12
	movq	%rdx, %r8
	leaq	(%rbx,%rbx), %rdx
	movq	192(%rsp), %r13
	movq	%r13, %rax
	mulq	%rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%r13, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rbp, %r15
	addq	%rbp, %r15
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %rbp
	movq	%r13, %rax
	mulq	%r13
	addq	48(%rsp), %r9                   # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r9
	adcq	%rdx, %r14
	shldq	$13, %r9, %r14
	movabsq	$2251799813685247, %rax         # imm = 0x7FFFFFFFFFFFF
	andq	%rax, %r9
	movq	32(%rsp), %r11                  # 8-byte Reload
	addq	80(%rsp), %r11                  # 8-byte Folded Reload
	adcq	88(%rsp), %r10                  # 8-byte Folded Reload
	addq	%rbx, %r11
	adcq	136(%rsp), %r10                 # 8-byte Folded Reload
	movq	72(%rsp), %rbx                  # 8-byte Reload
	addq	96(%rsp), %rbx                  # 8-byte Folded Reload
	adcq	104(%rsp), %rcx                 # 8-byte Folded Reload
	addq	16(%rsp), %rbx                  # 8-byte Folded Reload
	adcq	24(%rsp), %rcx                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	120(%rsp), %r8                  # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %r8                   # 8-byte Folded Reload
	addq	128(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	8(%rsp), %rsi                   # 8-byte Folded Reload
	addq	%rbp, %rdi
	adcq	%r15, %rsi
	addq	%r14, %rdi
	adcq	$0, %rsi
	shldq	$13, %rdi, %rsi
	movq	%rax, %rdx
	andq	%rax, %rdi
	addq	%r12, %rsi
	adcq	$0, %r8
	shldq	$13, %rsi, %r8
	andq	%rax, %rsi
	addq	%rbx, %r8
	adcq	$0, %rcx
	shldq	$13, %r8, %rcx
	andq	%rax, %r8
	addq	%r11, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rax, %rcx
	leaq	(%r10,%r10,8), %rax
	leaq	(%r10,%rax,2), %rbp
	addq	%r9, %rbp
	movq	%rbp, %r10
	shrq	$51, %r10
	addq	%rdi, %r10
	andq	%rdx, %rbp
	movq	%r10, %r11
	shrq	$51, %r11
	addq	%rsi, %r11
	andq	%rdx, %r10
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdx
	imulq	$38, %rcx, %r9
	leaq	(%r8,%r8,8), %rax
	leaq	(%r8,%rax,2), %rsi
	movq	%rcx, %rax
	mulq	%rdx
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	imulq	$38, %r8, %rbx
	movq	%r8, %rax
	mulq	%r9
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%r8, %rax
	mulq	%rsi
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r9
	movq	%rax, %rdi
	movq	%rdx, %rsi
	leaq	(%r8,%r8), %r14
	movq	%r11, %rax
	mulq	%rbx
	movq	%rdx, %r13
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%r10, %rax
	mulq	%r9
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	leaq	(%r11,%r11), %r9
	movq	%r10, %rax
	mulq	%r14
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%r10, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %r8
	addq	%rcx, %rcx
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, %rcx
	movq	%rax, %r15
	movq	%rbp, %rax
	mulq	%r14
	movq	%rdx, %r14
	movq	%rax, %rbx
	movq	%r9, %rax
	mulq	%rbp
	movq	%rax, %r9
	movq	%rdx, %r12
	leaq	(%r10,%r10), %rax
	mulq	%rbp
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	%rax, %r10
	movq	%rbp, %rax
	mulq	%rbp
	addq	24(%rsp), %rax                  # 8-byte Folded Reload
	adcq	32(%rsp), %rdx                  # 8-byte Folded Reload
	addq	40(%rsp), %rax                  # 8-byte Folded Reload
	adcq	%r13, %rdx
	movq	%rdx, %rbp
	shrq	$51, %rbp
	shldq	$13, %rax, %rdx
	movabsq	$2251799813685247, %r13         # imm = 0x7FFFFFFFFFFFF
	andq	%r13, %rax
	addq	48(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %r8                   # 8-byte Folded Reload
	addq	%r9, %r11
	adcq	%r12, %r8
	addq	64(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	72(%rsp), %rsi                  # 8-byte Folded Reload
	addq	%r10, %rdi
	adcq	16(%rsp), %rsi                  # 8-byte Folded Reload
	addq	%rdx, %rdi
	adcq	%rbp, %rsi
	movq	%rsi, %rdx
	shrq	$51, %rdx
	shldq	$13, %rdi, %rsi
	movabsq	$2251799813685247, %r9          # imm = 0x7FFFFFFFFFFFF
	andq	%r9, %rdi
	addq	%r11, %rsi
	adcq	%r8, %rdx
	movq	%rdx, %r8
	shrq	$51, %r8
	shldq	$13, %rsi, %rdx
	andq	%r9, %rsi
	addq	128(%rsp), %rbx                 # 8-byte Folded Reload
	adcq	8(%rsp), %r14                   # 8-byte Folded Reload
	addq	80(%rsp), %rbx                  # 8-byte Folded Reload
	adcq	88(%rsp), %r14                  # 8-byte Folded Reload
	addq	96(%rsp), %r15                  # 8-byte Folded Reload
	adcq	104(%rsp), %rcx                 # 8-byte Folded Reload
	addq	112(%rsp), %r15                 # 8-byte Folded Reload
	adcq	120(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rdx, %rbx
	adcq	%r8, %r14
	movq	%r14, %rdx
	shrq	$51, %rdx
	shldq	$13, %rbx, %r14
	addq	%r15, %r14
	adcq	%rcx, %rdx
	shldq	$13, %r14, %rdx
	movq	%r14, %xmm0
	movq	%rbx, %xmm1
	leaq	(%rdx,%rdx,8), %rcx
	leaq	(%rdx,%rcx,2), %rcx
	addq	%rax, %rcx
	movq	%rcx, %rax
	shrq	$51, %rax
	addq	%rdi, %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	%rsi, %rdx
	andq	%r9, %rcx
	movq	%rcx, 192(%rsp)
	andq	%r9, %rax
	movq	%rax, 200(%rsp)
	movq	%rdx, 208(%rsp)
	punpcklqdq	%xmm0, %xmm1            # xmm1 = xmm1[0],xmm0[0]
	movdqa	.LCPI104_0(%rip), %xmm0         # xmm0 = [2251799813685247,2251799813685247]
	pand	%xmm0, %xmm1
	movdqu	%xmm1, 216(%rsp)
	leaq	336(%rsp), %rdx
	movq	240(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rdi
	leaq	192(%rsp), %rsi
	callq	fe_mul_impl
	leaq	456(%rsp), %rdx
	movq	%rbp, %rdi
	movq	%rbp, %rsi
	callq	fe_mul_impl
	movq	32(%rbp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r9
	movq	24(%rbp), %rdi
	leaq	(%rdi,%rdi,8), %rcx
	leaq	(%rdi,%rcx,2), %rcx
	imulq	$38, %rdi, %r10
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%r9
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	16(%rbp), %r8
	movq	%rcx, %rax
	mulq	%rdi
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%r9
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	%r8, %rax
	mulq	%r10
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rdi,%rdi), %r15
	movq	%r8, %rax
	mulq	%r8
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	8(%rbp), %r13
	movq	%r13, %rax
	mulq	%r9
	movq	%rax, %rdi
	movq	%rdx, %r14
	leaq	(%r8,%r8), %r10
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r8
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r10
	movq	%rdx, %r9
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %r11
	leaq	(%rbx,%rbx), %rdx
	movq	(%rbp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r10
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %rdi
	adcq	%rdx, %r14
	shldq	$13, %rdi, %r14
	movabsq	$2251799813685247, %r10         # imm = 0x7FFFFFFFFFFFF
	andq	%r10, %rdi
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r8                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	136(%rsp), %r8                  # 8-byte Folded Reload
	movq	72(%rsp), %rdx                  # 8-byte Reload
	addq	96(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	104(%rsp), %r9                  # 8-byte Folded Reload
	addq	16(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	24(%rsp), %r9                   # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	120(%rsp), %r11                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %r11                  # 8-byte Folded Reload
	addq	128(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	8(%rsp), %rcx                   # 8-byte Folded Reload
	addq	%r13, %rsi
	adcq	%r15, %rcx
	addq	%r14, %rsi
	adcq	$0, %rcx
	shldq	$13, %rsi, %rcx
	andq	%r10, %rsi
	addq	%r12, %rcx
	adcq	$0, %r11
	shldq	$13, %rcx, %r11
	andq	%r10, %rcx
	addq	%rdx, %r11
	adcq	$0, %r9
	shldq	$13, %r11, %r9
	addq	%rax, %r9
	adcq	$0, %r8
	shldq	$13, %r9, %r8
	movq	%r9, %xmm0
	movq	%r11, %xmm1
	leaq	(%r8,%r8,8), %rax
	leaq	(%r8,%rax,2), %rax
	addq	%rdi, %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	%rsi, %rdx
	movq	%rdx, %rsi
	shrq	$51, %rsi
	addq	%rcx, %rsi
	andq	%r10, %rax
	movq	%rax, 296(%rsp)
	andq	%r10, %rdx
	movq	%rdx, 304(%rsp)
	movq	%rsi, 312(%rsp)
	punpcklqdq	%xmm0, %xmm1            # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI104_0(%rip), %xmm1
	movdqu	%xmm1, 320(%rsp)
	leaq	296(%rsp), %rdi
	leaq	496(%rsp), %rdx
	movq	%rdi, %rsi
	callq	fe_mul_impl
	movq	296(%rsp), %rcx
	movq	304(%rsp), %r14
	movabsq	$4503599627370494, %rsi         # imm = 0xFFFFFFFFFFFFE
	movq	%rsi, %rax
	subq	280(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	addq	%rcx, %rax
	addq	$-36, %rax
	movq	%rsi, %rcx
	subq	272(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r14, %rcx
	movq	312(%rsp), %r15
	movq	%rsi, %rdx
	subq	288(%rsp), %rdx                 # 8-byte Folded Reload
	addq	%r15, %rdx
	movq	%rax, 192(%rsp)
	movq	320(%rsp), %r12
	movq	%rcx, 200(%rsp)
	movq	%rsi, %rax
	movq	440(%rsp), %rbx                 # 8-byte Reload
	subq	%rbx, %rax
	addq	%r12, %rax
	movq	%rdx, 208(%rsp)
	movq	328(%rsp), %r13
	movq	%rax, 216(%rsp)
	movq	%rsi, %rax
	movq	448(%rsp), %rbp                 # 8-byte Reload
	subq	%rbp, %rax
	addq	%r13, %rax
	movq	%rax, 224(%rsp)
	leaq	192(%rsp), %rdi
	callq	fe_isnonzero
	testl	%eax, %eax
	je	.LBB104_15
# %bb.13:
	movq	8(%rsp), %rax                   # 8-byte Reload
	addq	280(%rsp), %rax                 # 8-byte Folded Reload
	addq	272(%rsp), %r14                 # 8-byte Folded Reload
	addq	288(%rsp), %r15                 # 8-byte Folded Reload
	addq	%rbx, %r12
	addq	%rbp, %r13
	movq	%rax, 192(%rsp)
	movq	%r14, 200(%rsp)
	movq	%r15, 208(%rsp)
	movq	%r12, 216(%rsp)
	movq	%r13, 224(%rsp)
	leaq	192(%rsp), %rdi
	callq	fe_isnonzero
	movl	%eax, %ecx
	xorl	%eax, %eax
	testl	%ecx, %ecx
	jne	.LBB104_18
# %bb.14:
	leaq	sqrtm1(%rip), %rdx
	movq	240(%rsp), %rdi                 # 8-byte Reload
	movq	%rdi, %rsi
	callq	fe_mul_impl
.LBB104_15:
	leaq	144(%rsp), %rdi
	movq	240(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rsi
	callq	fe_tobytes
	movzbl	144(%rsp), %eax
	andb	$1, %al
	movq	424(%rsp), %rcx                 # 8-byte Reload
	movzbl	31(%rcx), %ecx
	shrb	$7, %cl
	cmpb	%cl, %al
	je	.LBB104_17
# %bb.16:
	movabsq	$4503599627370494, %r9          # imm = 0xFFFFFFFFFFFFE
	movq	%r9, %rdi
	subq	(%rbx), %rdi
	movq	%r9, %rax
	subq	8(%rbx), %rax
	movq	%r9, %rdx
	subq	16(%rbx), %rdx
	movq	%r9, %r8
	subq	24(%rbx), %r8
	subq	32(%rbx), %r9
	addq	$-36, %rdi
	movq	%rdi, %rcx
	shrq	$51, %rcx
	addq	%rax, %rcx
	movq	%rcx, %rax
	shrq	$51, %rax
	addq	%rdx, %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	%r8, %rdx
	movq	%rdx, %r10
	shrq	$51, %r10
	addq	%r9, %r10
	movabsq	$2251799813685247, %r11         # imm = 0x7FFFFFFFFFFFF
	andq	%r11, %rdi
	movq	%r10, %r8
	shrq	$51, %r8
	leaq	(%r8,%r8,8), %r9
	leaq	(%r8,%r9,2), %r8
	addq	%rdi, %r8
	movq	%r8, %rdi
	shrq	$51, %rdi
	andq	%r11, %rcx
	addq	%rdi, %rcx
	andq	%r11, %r8
	movq	%rcx, %rdi
	andq	%r11, %rdi
	shrq	$51, %rcx
	andq	%r11, %rax
	addq	%rcx, %rax
	andq	%r11, %rdx
	andq	%r11, %r10
	movq	%r8, (%rbx)
	movq	%rdi, 8(%rbx)
	movq	%rax, 16(%rbx)
	movq	%rdx, 24(%rbx)
	movq	%r10, 32(%rbx)
.LBB104_17:
	leaq	120(%rbx), %rdi
	movq	%rbx, %rsi
	movq	416(%rsp), %rdx                 # 8-byte Reload
	callq	fe_mul_impl
	movl	$1, %eax
.LBB104_18:
	addq	$536, %rsp                      # imm = 0x218
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end104:
	.size	x25519_ge_frombytes_vartime, .Lfunc_end104-x25519_ge_frombytes_vartime
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function fe_isnonzero
	.type	fe_isnonzero,@function
fe_isnonzero:                           # @fe_isnonzero
# %bb.0:
	subq	$88, %rsp
	movq	(%rdi), %r8
	movq	%r8, %rcx
	shrq	$51, %rcx
	addq	8(%rdi), %rcx
	movq	%rcx, %rax
	shrq	$51, %rax
	addq	16(%rdi), %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	24(%rdi), %rdx
	movq	%rdx, %rsi
	shrq	$51, %rsi
	addq	32(%rdi), %rsi
	movabsq	$2251799813685247, %rdi         # imm = 0x7FFFFFFFFFFFF
	andq	%rdi, %r8
	movq	%rsi, %r9
	shrq	$51, %r9
	leaq	(%r9,%r9,8), %r10
	leaq	(%r9,%r10,2), %r9
	addq	%r8, %r9
	movq	%r9, %r8
	shrq	$51, %r8
	andq	%rdi, %rcx
	addq	%r8, %rcx
	andq	%rdi, %r9
	movq	%rcx, %r8
	andq	%rdi, %r8
	shrq	$51, %rcx
	andq	%rdi, %rax
	addq	%rcx, %rax
	andq	%rdi, %rdx
	andq	%rdi, %rsi
	movq	%r9, 8(%rsp)
	movq	%r8, 16(%rsp)
	movq	%rax, 24(%rsp)
	movq	%rdx, 32(%rsp)
	movq	%rsi, 40(%rsp)
	leaq	48(%rsp), %rdi
	leaq	8(%rsp), %rsi
	callq	fe_tobytes
	movdqa	48(%rsp), %xmm0
	por	64(%rsp), %xmm0
	pxor	%xmm1, %xmm1
	pcmpeqb	%xmm0, %xmm1
	pmovmskb	%xmm1, %ecx
	xorl	%eax, %eax
	cmpl	$65535, %ecx                    # imm = 0xFFFF
	setne	%al
	addq	$88, %rsp
	retq
.Lfunc_end105:
	.size	fe_isnonzero, .Lfunc_end105-fe_isnonzero
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function x25519_ge_p3_to_cached
.LCPI106_0:
	.quad	4503599627370458                # 0xfffffffffffda
	.quad	4503599627370494                # 0xffffffffffffe
.LCPI106_1:
	.quad	4503599627370494                # 0xffffffffffffe
	.quad	4503599627370494                # 0xffffffffffffe
	.text
	.globl	x25519_ge_p3_to_cached
	.p2align	4, 0x90
	.type	x25519_ge_p3_to_cached,@function
x25519_ge_p3_to_cached:                 # @x25519_ge_p3_to_cached
# %bb.0:
	pushq	%rax
	movq	32(%rsi), %rax
	addq	72(%rsi), %rax
	movdqu	40(%rsi), %xmm0
	movdqu	(%rsi), %xmm1
	paddq	%xmm0, %xmm1
	movdqu	16(%rsi), %xmm0
	movdqu	56(%rsi), %xmm2
	paddq	%xmm0, %xmm2
	movdqu	%xmm1, (%rdi)
	movdqu	%xmm2, 16(%rdi)
	movq	%rax, 32(%rdi)
	movq	72(%rsi), %rax
	subq	32(%rsi), %rax
	movabsq	$4503599627370494, %rcx         # imm = 0xFFFFFFFFFFFFE
	movdqu	(%rsi), %xmm0
	movdqu	16(%rsi), %xmm1
	movdqu	40(%rsi), %xmm2
	psubq	%xmm0, %xmm2
	movdqu	56(%rsi), %xmm0
	psubq	%xmm1, %xmm0
	paddq	.LCPI106_0(%rip), %xmm2
	paddq	.LCPI106_1(%rip), %xmm0
	addq	%rax, %rcx
	movdqu	%xmm2, 40(%rdi)
	movdqu	%xmm0, 56(%rdi)
	movq	%rcx, 72(%rdi)
	movups	80(%rsi), %xmm0
	movups	96(%rsi), %xmm1
	movq	112(%rsi), %rax
	movq	%rax, 112(%rdi)
	movups	%xmm1, 96(%rdi)
	movups	%xmm0, 80(%rdi)
	addq	$120, %rdi
	addq	$120, %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	popq	%rax
	retq
.Lfunc_end106:
	.size	x25519_ge_p3_to_cached, .Lfunc_end106-x25519_ge_p3_to_cached
                                        # -- End function
	.globl	x25519_ge_p1p1_to_p2            # -- Begin function x25519_ge_p1p1_to_p2
	.p2align	4, 0x90
	.type	x25519_ge_p1p1_to_p2,@function
x25519_ge_p1p1_to_p2:                   # @x25519_ge_p1p1_to_p2
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	%rsi, %rbx
	movq	%rdi, %r14
	leaq	120(%rsi), %r15
	movq	%r15, %rdx
	callq	fe_mul_impl
	leaq	40(%r14), %rdi
	leaq	40(%rbx), %rsi
	addq	$80, %rbx
	movq	%rbx, %rdx
	callq	fe_mul_impl
	addq	$80, %r14
	movq	%r14, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end107:
	.size	x25519_ge_p1p1_to_p2, .Lfunc_end107-x25519_ge_p1p1_to_p2
                                        # -- End function
	.globl	x25519_ge_p1p1_to_p3            # -- Begin function x25519_ge_p1p1_to_p3
	.p2align	4, 0x90
	.type	x25519_ge_p1p1_to_p3,@function
x25519_ge_p1p1_to_p3:                   # @x25519_ge_p1p1_to_p3
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rsi, %rbx
	movq	%rdi, %r14
	leaq	120(%rsi), %r15
	movq	%r15, %rdx
	callq	fe_mul_impl
	leaq	40(%r14), %rdi
	leaq	40(%rbx), %r12
	leaq	80(%rbx), %r13
	movq	%r12, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	80(%r14), %rdi
	movq	%r13, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	addq	$120, %r14
	movq	%r14, %rdi
	movq	%rbx, %rsi
	movq	%r12, %rdx
	callq	fe_mul_impl
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end108:
	.size	x25519_ge_p1p1_to_p3, .Lfunc_end108-x25519_ge_p1p1_to_p3
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function x25519_ge_add
.LCPI109_0:
	.quad	4503599627370458                # 0xfffffffffffda
	.quad	4503599627370494                # 0xffffffffffffe
.LCPI109_1:
	.quad	4503599627370494                # 0xffffffffffffe
	.quad	4503599627370494                # 0xffffffffffffe
	.text
	.globl	x25519_ge_add
	.p2align	4, 0x90
	.type	x25519_ge_add,@function
x25519_ge_add:                          # @x25519_ge_add
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$184, %rsp
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movq	32(%rsi), %rax
	addq	72(%rsi), %rax
	movdqu	40(%rsi), %xmm0
	movdqu	(%rsi), %xmm1
	paddq	%xmm0, %xmm1
	movdqu	16(%rsi), %xmm0
	movdqu	56(%rsi), %xmm2
	paddq	%xmm0, %xmm2
	movdqu	%xmm1, (%rdi)
	movdqu	%xmm2, 16(%rdi)
	movq	%rax, 32(%rdi)
	movabsq	$4503599627370494, %r13         # imm = 0xFFFFFFFFFFFFE
	movq	72(%rsi), %rax
	addq	%r13, %rax
	subq	32(%rsi), %rax
	movdqu	(%rsi), %xmm0
	movdqu	16(%rsi), %xmm1
	movdqu	40(%rsi), %xmm2
	psubq	%xmm0, %xmm2
	movdqu	56(%rsi), %xmm0
	psubq	%xmm1, %xmm0
	paddq	.LCPI109_0(%rip), %xmm2
	paddq	.LCPI109_1(%rip), %xmm0
	leaq	40(%rdi), %r12
	movdqu	%xmm2, 40(%rdi)
	movdqu	%xmm0, 56(%rdi)
	movq	%rax, 72(%rdi)
	leaq	64(%rsp), %rdi
	movq	%rbx, %rsi
	callq	fe_mul_impl
	leaq	40(%r14), %rdx
	leaq	104(%rsp), %rdi
	movq	%r12, %rsi
	callq	fe_mul_impl
	leaq	120(%r14), %rsi
	leaq	120(%r15), %rdx
	leaq	24(%rsp), %rdi
	callq	fe_mul_impl
	addq	$80, %r15
	addq	$80, %r14
	leaq	144(%rsp), %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	144(%rsp), %rsi
	movq	152(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	160(%rsp), %rdi
	movq	168(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	176(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	64(%rsp), %r11
	movq	72(%rsp), %r10
	leaq	(%r11,%r13), %r14
	addq	$-36, %r14
	movq	104(%rsp), %r8
	movq	112(%rsp), %r9
	subq	%r8, %r14
	movq	80(%rsp), %r15
	movq	120(%rsp), %r12
	movq	88(%rsp), %rbp
	movq	128(%rsp), %rcx
	movq	96(%rsp), %rdx
	movq	136(%rsp), %rax
	movq	%r14, (%rbx)
	leaq	(%r10,%r13), %r14
	subq	%r9, %r14
	movq	%r14, 8(%rbx)
	leaq	(%r15,%r13), %r14
	subq	%r12, %r14
	movq	%r14, 16(%rbx)
	movq	%rbp, %r14
	addq	%r13, %r14
	subq	%rcx, %r14
	movq	%r14, 24(%rbx)
	leaq	(%rdx,%r13), %r14
	subq	%rax, %r14
	movq	%r14, 32(%rbx)
	addq	%r11, %r8
	addq	%r10, %r9
	addq	%r15, %r12
	addq	%rbp, %rcx
	addq	%rsi, %rsi
	addq	%rdx, %rax
	movq	%r8, 40(%rbx)
	movq	%r9, 48(%rbx)
	movq	%r12, 56(%rbx)
	movq	%rcx, 64(%rbx)
	movq	%rax, 72(%rbx)
	movabsq	$2251799813685247, %r8          # imm = 0x7FFFFFFFFFFFF
	leaq	-1(%r8), %r9
	andq	%rsi, %r9
	shrq	$51, %rsi
	movq	16(%rsp), %rax                  # 8-byte Reload
	leaq	(%rsi,%rax,2), %r10
	movq	%r10, %rax
	shrq	$51, %rax
	leaq	(%rax,%rdi,2), %rax
	movq	%rax, %rcx
	shrq	$51, %rcx
	movq	(%rsp), %rdx                    # 8-byte Reload
	leaq	(%rcx,%rdx,2), %rcx
	movq	%rcx, %rdx
	shrq	$51, %rdx
	movq	8(%rsp), %rsi                   # 8-byte Reload
	leaq	(%rdx,%rsi,2), %rdx
	movq	%rdx, %rsi
	shrq	$51, %rsi
	leaq	(%rsi,%rsi,8), %rdi
	leaq	(%rsi,%rdi,2), %rdi
	addq	%r9, %rdi
	movq	%rdi, %rsi
	shrq	$51, %rsi
	andq	%r8, %r10
	addq	%rsi, %r10
	andq	%r8, %rdi
	movq	%r10, %rsi
	andq	%r8, %rsi
	shrq	$51, %r10
	andq	%r8, %rax
	addq	%r10, %rax
	andq	%r8, %rcx
	andq	%r8, %rdx
	movq	24(%rsp), %r8
	movq	32(%rsp), %r9
	leaq	(%r8,%rdi), %r10
	movq	40(%rsp), %r11
	movq	48(%rsp), %r14
	movq	56(%rsp), %r15
	movq	%r10, 80(%rbx)
	leaq	(%r9,%rsi), %r10
	movq	%r10, 88(%rbx)
	leaq	(%r11,%rax), %r10
	movq	%r10, 96(%rbx)
	leaq	(%r14,%rcx), %r10
	movq	%r10, 104(%rbx)
	leaq	(%r15,%rdx), %r10
	movq	%r10, 112(%rbx)
	addq	%r13, %rdi
	addq	$-36, %rdi
	subq	%r8, %rdi
	addq	%r13, %rsi
	subq	%r9, %rsi
	addq	%r13, %rax
	subq	%r11, %rax
	addq	%r13, %rcx
	subq	%r14, %rcx
	addq	%r13, %rdx
	subq	%r15, %rdx
	movq	%rdi, 120(%rbx)
	movq	%rsi, 128(%rbx)
	movq	%rax, 136(%rbx)
	movq	%rcx, 144(%rbx)
	movq	%rdx, 152(%rbx)
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end109:
	.size	x25519_ge_add, .Lfunc_end109-x25519_ge_add
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function x25519_ge_sub
.LCPI110_0:
	.quad	4503599627370458                # 0xfffffffffffda
	.quad	4503599627370494                # 0xffffffffffffe
.LCPI110_1:
	.quad	4503599627370494                # 0xffffffffffffe
	.quad	4503599627370494                # 0xffffffffffffe
	.text
	.globl	x25519_ge_sub
	.p2align	4, 0x90
	.type	x25519_ge_sub,@function
x25519_ge_sub:                          # @x25519_ge_sub
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$184, %rsp
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movq	32(%rsi), %rax
	addq	72(%rsi), %rax
	movdqu	40(%rsi), %xmm0
	movdqu	(%rsi), %xmm1
	paddq	%xmm0, %xmm1
	movdqu	16(%rsi), %xmm0
	movdqu	56(%rsi), %xmm2
	paddq	%xmm0, %xmm2
	movdqu	%xmm1, (%rdi)
	movdqu	%xmm2, 16(%rdi)
	movq	%rax, 32(%rdi)
	leaq	40(%rdi), %r12
	movabsq	$4503599627370494, %r13         # imm = 0xFFFFFFFFFFFFE
	movq	72(%rsi), %rax
	addq	%r13, %rax
	subq	32(%rsi), %rax
	movdqu	(%rsi), %xmm0
	movdqu	16(%rsi), %xmm1
	movdqu	40(%rsi), %xmm2
	psubq	%xmm0, %xmm2
	movdqu	56(%rsi), %xmm0
	psubq	%xmm1, %xmm0
	paddq	.LCPI110_0(%rip), %xmm2
	paddq	.LCPI110_1(%rip), %xmm0
	movdqu	%xmm2, 40(%rdi)
	movdqu	%xmm0, 56(%rdi)
	movq	%rax, 72(%rdi)
	addq	$40, %rdx
	leaq	64(%rsp), %rdi
	movq	%rbx, %rsi
	callq	fe_mul_impl
	leaq	104(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	120(%r14), %rsi
	leaq	120(%r15), %rdx
	leaq	24(%rsp), %rdi
	callq	fe_mul_impl
	addq	$80, %r15
	addq	$80, %r14
	leaq	144(%rsp), %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	144(%rsp), %rsi
	movq	152(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	160(%rsp), %rdi
	movq	168(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	176(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	64(%rsp), %r11
	movq	72(%rsp), %r10
	leaq	(%r11,%r13), %r14
	addq	$-36, %r14
	movq	104(%rsp), %r8
	movq	112(%rsp), %r9
	subq	%r8, %r14
	movq	80(%rsp), %r15
	movq	120(%rsp), %r12
	movq	88(%rsp), %rbp
	movq	128(%rsp), %rcx
	movq	96(%rsp), %rdx
	movq	136(%rsp), %rax
	movq	%r14, (%rbx)
	leaq	(%r10,%r13), %r14
	subq	%r9, %r14
	movq	%r14, 8(%rbx)
	leaq	(%r15,%r13), %r14
	subq	%r12, %r14
	movq	%r14, 16(%rbx)
	movq	%rbp, %r14
	addq	%r13, %r14
	subq	%rcx, %r14
	movq	%r14, 24(%rbx)
	leaq	(%rdx,%r13), %r14
	subq	%rax, %r14
	movq	%r14, 32(%rbx)
	addq	%r11, %r8
	addq	%r10, %r9
	addq	%r15, %r12
	addq	%rbp, %rcx
	addq	%rsi, %rsi
	addq	%rdx, %rax
	movq	%r8, 40(%rbx)
	movq	%r9, 48(%rbx)
	movq	%r12, 56(%rbx)
	movq	%rcx, 64(%rbx)
	movq	%rax, 72(%rbx)
	movabsq	$2251799813685247, %r8          # imm = 0x7FFFFFFFFFFFF
	leaq	-1(%r8), %r9
	andq	%rsi, %r9
	shrq	$51, %rsi
	movq	16(%rsp), %rax                  # 8-byte Reload
	leaq	(%rsi,%rax,2), %r10
	movq	%r10, %rax
	shrq	$51, %rax
	leaq	(%rax,%rdi,2), %rax
	movq	%rax, %rcx
	shrq	$51, %rcx
	movq	(%rsp), %rdx                    # 8-byte Reload
	leaq	(%rcx,%rdx,2), %rcx
	movq	%rcx, %rdx
	shrq	$51, %rdx
	movq	8(%rsp), %rsi                   # 8-byte Reload
	leaq	(%rdx,%rsi,2), %rdx
	movq	%rdx, %rsi
	shrq	$51, %rsi
	leaq	(%rsi,%rsi,8), %rdi
	leaq	(%rsi,%rdi,2), %rsi
	addq	%r9, %rsi
	movq	%rsi, %rdi
	shrq	$51, %rdi
	andq	%r8, %r10
	addq	%rdi, %r10
	andq	%r8, %rsi
	movq	%r10, %rdi
	andq	%r8, %rdi
	shrq	$51, %r10
	andq	%r8, %rax
	addq	%r10, %rax
	andq	%r8, %rcx
	andq	%r8, %rdx
	leaq	(%rsi,%r13), %r8
	addq	$-36, %r8
	movq	24(%rsp), %r9
	movq	32(%rsp), %r10
	subq	%r9, %r8
	movq	40(%rsp), %r11
	movq	48(%rsp), %r14
	movq	56(%rsp), %r15
	movq	%r8, 80(%rbx)
	leaq	(%rdi,%r13), %r8
	subq	%r10, %r8
	movq	%r8, 88(%rbx)
	leaq	(%rax,%r13), %r8
	subq	%r11, %r8
	movq	%r8, 96(%rbx)
	leaq	(%rcx,%r13), %r8
	subq	%r14, %r8
	movq	%r8, 104(%rbx)
	addq	%rdx, %r13
	subq	%r15, %r13
	movq	%r13, 112(%rbx)
	addq	%r9, %rsi
	addq	%r10, %rdi
	addq	%r11, %rax
	addq	%r14, %rcx
	addq	%r15, %rdx
	movq	%rsi, 120(%rbx)
	movq	%rdi, 128(%rbx)
	movq	%rax, 136(%rbx)
	movq	%rcx, 144(%rbx)
	movq	%rdx, 152(%rbx)
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end110:
	.size	x25519_ge_sub, .Lfunc_end110-x25519_ge_sub
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function x25519_ge_scalarmult_small_precomp
.LCPI111_0:
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	1                               # 0x1
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
.LCPI111_1:
	.quad	1                               # 0x1
	.quad	0                               # 0x0
	.text
	.globl	x25519_ge_scalarmult_small_precomp
	.p2align	4, 0x90
	.type	x25519_ge_scalarmult_small_precomp,@function
x25519_ge_scalarmult_small_precomp:     # @x25519_ge_scalarmult_small_precomp
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$2296, %rsp                     # imm = 0x8F8
	movq	%rdx, %r15
	movq	%rsi, 40(%rsp)                  # 8-byte Spill
	movq	%rdi, 32(%rsp)                  # 8-byte Spill
	movabsq	$2251799746576384, %rax         # imm = 0x7FFFFFC000000
	movl	$60, %r13d
	leaq	576(%rsp), %r12
	addq	$58720256, %rax                 # imm = 0x3800000
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	.p2align	4, 0x90
.LBB111_1:                              # =>This Inner Loop Header: Depth=1
	movl	-32(%r15,%r13), %eax
	shlq	$20, %rax
	movzbl	-33(%r15,%r13), %ecx
	shlq	$12, %rcx
	orq	%rax, %rcx
	movzbl	-34(%r15,%r13), %r8d
	shlq	$4, %r8
	orq	%rcx, %r8
	movl	-38(%r15,%r13), %ecx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	shlq	$23, %rcx
	movzbl	-39(%r15,%r13), %eax
	shlq	$15, %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movzbl	-40(%r15,%r13), %r10d
	shlq	$7, %r10
	movl	-60(%r15,%r13), %r14d
	movl	-44(%r15,%r13), %r11d
	movq	%r11, %rdi
	shlq	$26, %rdi
	movzbl	-45(%r15,%r13), %ebp
	shlq	$18, %rbp
	movzbl	-48(%r15,%r13), %ebx
	movzbl	-54(%r15,%r13), %eax
	movq	%rax, %rdx
	shlq	$48, %rdx
	movzbl	-55(%r15,%r13), %esi
	shlq	$40, %rsi
	movabsq	$1970324836974592, %r9          # imm = 0x7000000000000
	andq	%r9, %rdx
	orq	%rsi, %rdx
	movq	%rbx, %rsi
	shlq	$45, %rsi
	orq	%r14, %rdx
	movzbl	-56(%r15,%r13), %r14d
	shlq	$32, %r14
	orq	%r14, %rdx
	movzbl	-49(%r15,%r13), %r14d
	shlq	$37, %r14
	movabsq	$2216615441596416, %r9          # imm = 0x7E00000000000
	andq	%r9, %rsi
	orq	%r14, %rsi
	movzbl	-50(%r15,%r13), %r14d
	shlq	$29, %r14
	orq	%r14, %rsi
	movzbl	-51(%r15,%r13), %r14d
	shlq	$21, %r14
	orq	%r14, %rsi
	movzbl	-52(%r15,%r13), %r14d
	shlq	$13, %r14
	orq	%r14, %rsi
	movzbl	-53(%r15,%r13), %r14d
	shlq	$5, %r14
	orq	%r14, %rsi
	movzbl	-46(%r15,%r13), %r14d
	shlq	$10, %r14
	shrq	$3, %rax
	orq	%rax, %rsi
	movzbl	-47(%r15,%r13), %eax
	shrq	$6, %rbx
	movabsq	$2251799746576384, %r9          # imm = 0x7FFFFFC000000
	andq	%r9, %rdi
	orq	%rbp, %rdi
	orq	%r14, %rdi
	leaq	(%rdi,%rax,4), %rax
	orq	%rbx, %rax
	movq	%rax, %rdi
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	shrq	$25, %r11
	andq	8(%rsp), %rcx                   # 8-byte Folded Reload
	addq	16(%rsp), %rcx                  # 8-byte Folded Reload
	orq	%r10, %rcx
	orq	%r11, %rcx
	movq	(%rsp), %rax                    # 8-byte Reload
	shrq	$28, %rax
	orq	%r8, %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	%rdx, 48(%rsp)
	movq	%rsi, 56(%rsp)
	movq	%rdi, 64(%rsp)
	movq	%rcx, 72(%rsp)
	movq	%rax, 80(%rsp)
	movl	(%r15,%r13), %eax
	shlq	$20, %rax
	movzbl	-1(%r15,%r13), %r8d
	shlq	$12, %r8
	orq	%rax, %r8
	movzbl	-2(%r15,%r13), %r9d
	shlq	$4, %r9
	orq	%r8, %r9
	movl	-6(%r15,%r13), %r8d
	movl	-28(%r15,%r13), %r14d
	movl	-12(%r15,%r13), %r10d
	movzbl	-16(%r15,%r13), %ebp
	movzbl	-22(%r15,%r13), %eax
	movq	%rax, %r11
	shlq	$48, %r11
	movzbl	-23(%r15,%r13), %ebx
	shlq	$40, %rbx
	movabsq	$1970324836974592, %rdi         # imm = 0x7000000000000
	andq	%rdi, %r11
	orq	%rbx, %r11
	movq	%rbp, %rbx
	shlq	$45, %rbx
	orq	%r14, %r11
	movzbl	-24(%r15,%r13), %r14d
	shlq	$32, %r14
	orq	%r14, %r11
	movzbl	-17(%r15,%r13), %r14d
	shlq	$37, %r14
	movabsq	$2216615441596416, %rdi         # imm = 0x7E00000000000
	andq	%rdi, %rbx
	orq	%r14, %rbx
	movzbl	-18(%r15,%r13), %r14d
	shlq	$29, %r14
	orq	%r14, %rbx
	movzbl	-19(%r15,%r13), %r14d
	shlq	$21, %r14
	orq	%r14, %rbx
	movzbl	-20(%r15,%r13), %r14d
	shlq	$13, %r14
	orq	%r14, %rbx
	movzbl	-21(%r15,%r13), %r14d
	shlq	$5, %r14
	orq	%r14, %rbx
	movq	%r10, %r14
	shlq	$26, %r14
	shrq	$3, %rax
	orq	%rax, %rbx
	movzbl	-13(%r15,%r13), %eax
	shlq	$18, %rax
	movabsq	$2251799746576384, %rdi         # imm = 0x7FFFFFC000000
	andq	%rdi, %r14
	orq	%rax, %r14
	movzbl	-14(%r15,%r13), %eax
	shlq	$10, %rax
	orq	%rax, %r14
	movzbl	-15(%r15,%r13), %eax
	leaq	(%r14,%rax,4), %rax
	movq	%r8, %r14
	shlq	$23, %r14
	shrq	$6, %rbp
	orq	%rbp, %rax
	movzbl	-7(%r15,%r13), %ebp
	shlq	$15, %rbp
	andq	8(%rsp), %r14                   # 8-byte Folded Reload
	orq	%rbp, %r14
	movzbl	-8(%r15,%r13), %ebp
	shlq	$7, %rbp
	orq	%rbp, %r14
	shrq	$25, %r10
	orq	%r10, %r14
	shrq	$28, %r8
	orq	%r9, %r8
	leaq	(%r11,%rdx), %r9
	movq	%r9, -80(%r12)
	leaq	(%rbx,%rsi), %r9
	movq	%r9, -72(%r12)
	movq	24(%rsp), %rdi                  # 8-byte Reload
	leaq	(%rax,%rdi), %r9
	movq	%r9, -64(%r12)
	leaq	(%r14,%rcx), %r9
	movq	%r9, -56(%r12)
	movq	(%rsp), %rbp                    # 8-byte Reload
	leaq	(%r8,%rbp), %r9
	movq	%r9, -48(%r12)
	movabsq	$4503599627370494, %r9          # imm = 0xFFFFFFFFFFFFE
	subq	%rdx, %r9
	movq	%r11, 208(%rsp)
	leaq	(%r9,%r11), %rdx
	addq	$-36, %rdx
	movabsq	$4503599627370494, %r9          # imm = 0xFFFFFFFFFFFFE
	subq	%rsi, %r9
	movq	%rbx, 216(%rsp)
	addq	%rbx, %r9
	movabsq	$4503599627370494, %r10         # imm = 0xFFFFFFFFFFFFE
	movq	%r10, %rsi
	subq	%rdi, %rsi
	movq	%rax, 224(%rsp)
	addq	%rax, %rsi
	movq	%r10, %rax
	subq	%rcx, %rax
	movq	%r14, 232(%rsp)
	addq	%r14, %rax
	movq	%r10, %rcx
	subq	%rbp, %rcx
	movq	%r8, 240(%rsp)
	addq	%r8, %rcx
	movq	%rdx, -40(%r12)
	movq	%r9, -32(%r12)
	movq	%rsi, -24(%r12)
	movq	%rax, -16(%r12)
	movq	%rcx, -8(%r12)
	movq	%r12, %rdi
	leaq	48(%rsp), %rsi
	leaq	208(%rsp), %rdx
	callq	fe_mul_impl
	movq	%r12, %rdi
	movq	%r12, %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	addq	$64, %r13
	addq	$120, %r12
	cmpq	$1020, %r13                     # imm = 0x3FC
	jne	.LBB111_1
# %bb.2:
	pxor	%xmm0, %xmm0
	movq	32(%rsp), %rax                  # 8-byte Reload
	movdqu	%xmm0, 16(%rax)
	movdqu	%xmm0, (%rax)
	movq	$0, 32(%rax)
	leaq	40(%rax), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movdqu	%xmm0, 48(%rax)
	movdqu	%xmm0, 64(%rax)
	movq	$1, 40(%rax)
	leaq	80(%rax), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movdqu	%xmm0, 88(%rax)
	movdqu	%xmm0, 104(%rax)
	movq	$1, 80(%rax)
	leaq	120(%rax), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movdqu	%xmm0, 120(%rax)
	movdqu	%xmm0, 136(%rax)
	movq	$0, 152(%rax)
	movl	$63, %ecx
	movq	16(%rsp), %r15                  # 8-byte Reload
	.p2align	4, 0x90
.LBB111_3:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB111_4 Depth 2
	movl	%ecx, %eax
	shrq	$3, %rax
	movq	40(%rsp), %r8                   # 8-byte Reload
	movzbl	(%r8,%rax), %edx
	movl	%ecx, (%rsp)                    # 4-byte Spill
                                        # kill: def $cl killed $cl killed $ecx
	andb	$7, %cl
	movzbl	%cl, %ecx
	xorl	%esi, %esi
	btl	%ecx, %edx
	setb	%sil
	movzbl	8(%r8,%rax), %edx
	shrq	%cl, %rdx
	andl	$1, %edx
	movzbl	16(%r8,%rax), %edi
	shrq	%cl, %rdi
	leaq	(%rsi,%rdx,2), %rdx
	andl	$1, %edi
	leaq	(%rdx,%rdi,4), %rdx
	movzbl	24(%r8,%rax), %eax
                                        # kill: def $cl killed $cl killed $ecx
	shrq	%cl, %rax
	andl	$1, %eax
	leaq	(%rdx,%rax,8), %rax
	movl	$1, %ecx
	leaq	608(%rsp), %rdx
	xorl	%r8d, %r8d
	movdqa	.LCPI111_1(%rip), %xmm0         # xmm0 = [1,0]
	pxor	%xmm6, %xmm6
	movdqa	.LCPI111_0(%rip), %xmm5         # xmm5 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
	pxor	%xmm4, %xmm4
	pxor	%xmm2, %xmm2
	pxor	%xmm3, %xmm3
	pxor	%xmm1, %xmm1
	.p2align	4, 0x90
.LBB111_4:                              #   Parent Loop BB111_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r8, %rsi
	movq	%rcx, %rdi
	xorq	%rax, %rdi
	decq	%rdi
	movq	%rdi, %xmm7
	sarq	$63, %rdi
	pshufd	$68, %xmm7, %xmm7               # xmm7 = xmm7[0,1,0,1]
	psrad	$31, %xmm7
	pshufd	$245, %xmm7, %xmm7              # xmm7 = xmm7[1,1,3,3]
	movdqa	%xmm7, %xmm8
	pandn	%xmm0, %xmm8
	movdqu	-112(%rdx), %xmm0
	movdqa	%xmm7, %xmm9
	pandn	%xmm6, %xmm9
	movdqu	-96(%rdx), %xmm6
	movdqa	%xmm7, %xmm10
	pandn	%xmm5, %xmm10
	movdqu	-80(%rdx), %xmm5
	movdqa	%xmm7, %xmm11
	pandn	%xmm4, %xmm11
	movdqu	-64(%rdx), %xmm4
	pand	%xmm7, %xmm0
	por	%xmm8, %xmm0
	pand	%xmm7, %xmm6
	por	%xmm9, %xmm6
	pand	%xmm7, %xmm5
	por	%xmm10, %xmm5
	pand	%xmm7, %xmm4
	por	%xmm11, %xmm4
	movdqa	%xmm7, %xmm8
	pandn	%xmm2, %xmm8
	movdqu	-48(%rdx), %xmm2
	pand	%xmm7, %xmm2
	por	%xmm8, %xmm2
	movdqa	%xmm7, %xmm8
	pandn	%xmm3, %xmm8
	movdqu	-32(%rdx), %xmm3
	pand	%xmm7, %xmm3
	por	%xmm8, %xmm3
	movdqu	-16(%rdx), %xmm8
	pand	%xmm7, %xmm8
	pandn	%xmm1, %xmm7
	movdqa	%xmm7, %xmm1
	por	%xmm8, %xmm1
	movq	(%rdx), %r8
	xorq	%rsi, %r8
	andq	%rdi, %r8
	xorq	%rsi, %r8
	incq	%rcx
	addq	$120, %rdx
	cmpq	$16, %rcx
	jne	.LBB111_4
# %bb.5:                                #   in Loop: Header=BB111_3 Depth=1
	movdqa	%xmm0, 368(%rsp)
	movdqa	%xmm6, 384(%rsp)
	movdqa	%xmm5, 400(%rsp)
	movdqa	%xmm4, 416(%rsp)
	movdqa	%xmm2, 432(%rsp)
	movdqa	%xmm3, 448(%rsp)
	movdqa	%xmm1, 464(%rsp)
	movq	%r8, 480(%rsp)
	movq	32(%rsp), %r13                  # 8-byte Reload
	movq	40(%r13), %rax
	movq	(%r13), %r8
	movq	8(%r13), %r9
	leaq	(%r8,%rax), %r10
	movq	48(%r13), %rcx
	movq	56(%r13), %rdx
	movq	16(%r13), %r11
	movq	64(%r13), %rsi
	movq	24(%r13), %rbx
	movq	72(%r13), %rdi
	movq	32(%r13), %r14
	movq	%r10, 48(%rsp)
	leaq	(%r9,%rcx), %r10
	movq	%r10, 56(%rsp)
	leaq	(%r11,%rdx), %r10
	movq	%r10, 64(%rsp)
	leaq	(%rbx,%rsi), %r10
	movq	%r10, 72(%rsp)
	leaq	(%r14,%rdi), %r10
	movq	%r10, 80(%rsp)
	movabsq	$4503599627370494, %r10         # imm = 0xFFFFFFFFFFFFE
	addq	%r10, %rax
	subq	%r8, %rax
	addq	%r10, %rcx
	subq	%r9, %rcx
	addq	%r10, %rdx
	subq	%r11, %rdx
	addq	%r10, %rsi
	subq	%rbx, %rsi
	addq	%r10, %rdi
	subq	%r14, %rdi
	addq	$-36, %rax
	movq	%rax, 88(%rsp)
	movq	%rcx, 96(%rsp)
	movq	%rdx, 104(%rsp)
	movq	%rsi, 112(%rsp)
	movq	%rdi, 120(%rsp)
	movq	32(%r15), %rax
	leaq	128(%rsp), %rcx
	movq	%rax, 32(%rcx)
	movdqu	(%r15), %xmm0
	movdqu	16(%r15), %xmm1
	movdqu	%xmm1, 16(%rcx)
	movdqu	%xmm0, (%rcx)
	leaq	168(%rsp), %rdi
	movq	24(%rsp), %r14                  # 8-byte Reload
	movq	%r14, %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	leaq	208(%rsp), %rbx
	movq	%rbx, %rdi
	movq	%r13, %rsi
	leaq	48(%rsp), %rdx
	callq	x25519_ge_add
	movq	%r13, %rdi
	movq	%rbx, %rsi
	leaq	328(%rsp), %rbp
	movq	%rbp, %rdx
	callq	fe_mul_impl
	movq	8(%rsp), %rbx                   # 8-byte Reload
	movq	%rbx, %rdi
	leaq	248(%rsp), %rsi
	leaq	288(%rsp), %r12
	movq	%r12, %rdx
	callq	fe_mul_impl
	movq	%r15, %rdi
	movq	%r12, %rsi
	movq	%rbp, %rdx
	callq	fe_mul_impl
	movq	%r14, %rdi
	leaq	208(%rsp), %rbp
	movq	%rbp, %rsi
	leaq	248(%rsp), %rdx
	callq	fe_mul_impl
	movq	%rbp, %rdi
	movq	%r13, %rsi
	leaq	368(%rsp), %rdx
	callq	ge_madd
	movq	%r13, %rdi
	movq	%rbp, %rsi
	leaq	328(%rsp), %r13
	movq	%r13, %rdx
	callq	fe_mul_impl
	movq	%rbx, %rdi
	leaq	248(%rsp), %rbx
	movq	%rbx, %rsi
	movq	%r12, %rdx
	callq	fe_mul_impl
	movq	%r15, %rdi
	movq	%r12, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	movq	%r14, %rdi
	movq	%rbp, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movl	(%rsp), %ecx                    # 4-byte Reload
	decl	%ecx
	cmpl	$64, %ecx
	jb	.LBB111_3
# %bb.6:
	addq	$2296, %rsp                     # imm = 0x8F8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end111:
	.size	x25519_ge_scalarmult_small_precomp, .Lfunc_end111-x25519_ge_scalarmult_small_precomp
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function ge_madd
.LCPI112_0:
	.quad	4503599627370458                # 0xfffffffffffda
	.quad	4503599627370494                # 0xffffffffffffe
.LCPI112_1:
	.quad	4503599627370494                # 0xffffffffffffe
	.quad	4503599627370494                # 0xffffffffffffe
	.text
	.p2align	4, 0x90
	.type	ge_madd,@function
ge_madd:                                # @ge_madd
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$152, %rsp
	movq	%rdx, %r15
	movq	%rsi, %r14
	movq	%rdi, %rbx
	movq	32(%rsi), %rax
	addq	72(%rsi), %rax
	movdqu	40(%rsi), %xmm0
	movdqu	(%rsi), %xmm1
	paddq	%xmm0, %xmm1
	movdqu	16(%rsi), %xmm0
	movdqu	56(%rsi), %xmm2
	paddq	%xmm0, %xmm2
	movdqu	%xmm1, (%rdi)
	movdqu	%xmm2, 16(%rdi)
	movq	%rax, 32(%rdi)
	movabsq	$4503599627370494, %r13         # imm = 0xFFFFFFFFFFFFE
	movq	72(%rsi), %rax
	addq	%r13, %rax
	subq	32(%rsi), %rax
	movdqu	(%rsi), %xmm0
	movdqu	16(%rsi), %xmm1
	movdqu	40(%rsi), %xmm2
	psubq	%xmm0, %xmm2
	movdqu	56(%rsi), %xmm0
	psubq	%xmm1, %xmm0
	paddq	.LCPI112_0(%rip), %xmm2
	paddq	.LCPI112_1(%rip), %xmm0
	leaq	40(%rdi), %r12
	movdqu	%xmm2, 40(%rdi)
	movdqu	%xmm0, 56(%rdi)
	movq	%rax, 72(%rdi)
	leaq	72(%rsp), %rdi
	movq	%rbx, %rsi
	callq	fe_mul_impl
	leaq	40(%r15), %rdx
	leaq	112(%rsp), %rdi
	movq	%r12, %rsi
	callq	fe_mul_impl
	addq	$80, %r15
	leaq	120(%r14), %rdx
	leaq	32(%rsp), %rdi
	movq	%r15, %rsi
	callq	fe_mul_impl
	movq	80(%r14), %rsi
	movq	88(%r14), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	96(%r14), %rdi
	movq	104(%r14), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	112(%r14), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	72(%rsp), %r11
	movq	80(%rsp), %r10
	leaq	(%r11,%r13), %r14
	addq	$-36, %r14
	movq	112(%rsp), %r8
	movq	120(%rsp), %r9
	subq	%r8, %r14
	movq	88(%rsp), %r15
	movq	128(%rsp), %r12
	movq	96(%rsp), %rbp
	movq	136(%rsp), %rcx
	movq	104(%rsp), %rdx
	movq	144(%rsp), %rax
	movq	%r14, (%rbx)
	leaq	(%r10,%r13), %r14
	subq	%r9, %r14
	movq	%r14, 8(%rbx)
	leaq	(%r15,%r13), %r14
	subq	%r12, %r14
	movq	%r14, 16(%rbx)
	movq	%rbp, %r14
	addq	%r13, %r14
	subq	%rcx, %r14
	movq	%r14, 24(%rbx)
	leaq	(%rdx,%r13), %r14
	subq	%rax, %r14
	movq	%r14, 32(%rbx)
	addq	%r11, %r8
	addq	%r10, %r9
	addq	%r15, %r12
	addq	%rbp, %rcx
	addq	%rsi, %rsi
	addq	%rdx, %rax
	movq	%r8, 40(%rbx)
	movq	%r9, 48(%rbx)
	movq	%r12, 56(%rbx)
	movq	%rcx, 64(%rbx)
	movq	%rax, 72(%rbx)
	movabsq	$2251799813685247, %r8          # imm = 0x7FFFFFFFFFFFF
	leaq	-1(%r8), %r9
	andq	%rsi, %r9
	shrq	$51, %rsi
	movq	24(%rsp), %rax                  # 8-byte Reload
	leaq	(%rsi,%rax,2), %r10
	movq	%r10, %rax
	shrq	$51, %rax
	leaq	(%rax,%rdi,2), %rax
	movq	%rax, %rcx
	shrq	$51, %rcx
	movq	8(%rsp), %rdx                   # 8-byte Reload
	leaq	(%rcx,%rdx,2), %rcx
	movq	%rcx, %rdx
	shrq	$51, %rdx
	movq	16(%rsp), %rsi                  # 8-byte Reload
	leaq	(%rdx,%rsi,2), %rdx
	movq	%rdx, %rsi
	shrq	$51, %rsi
	leaq	(%rsi,%rsi,8), %rdi
	leaq	(%rsi,%rdi,2), %rdi
	addq	%r9, %rdi
	movq	%rdi, %rsi
	shrq	$51, %rsi
	andq	%r8, %r10
	addq	%rsi, %r10
	andq	%r8, %rdi
	movq	%r10, %rsi
	andq	%r8, %rsi
	shrq	$51, %r10
	andq	%r8, %rax
	addq	%r10, %rax
	andq	%r8, %rcx
	andq	%r8, %rdx
	movq	32(%rsp), %r8
	movq	40(%rsp), %r9
	leaq	(%r8,%rdi), %r10
	movq	48(%rsp), %r11
	movq	56(%rsp), %r14
	movq	64(%rsp), %r15
	movq	%r10, 80(%rbx)
	leaq	(%r9,%rsi), %r10
	movq	%r10, 88(%rbx)
	leaq	(%r11,%rax), %r10
	movq	%r10, 96(%rbx)
	leaq	(%r14,%rcx), %r10
	movq	%r10, 104(%rbx)
	leaq	(%r15,%rdx), %r10
	movq	%r10, 112(%rbx)
	addq	%r13, %rdi
	addq	$-36, %rdi
	subq	%r8, %rdi
	addq	%r13, %rsi
	subq	%r9, %rsi
	addq	%r13, %rax
	subq	%r11, %rax
	addq	%r13, %rcx
	subq	%r14, %rcx
	addq	%r13, %rdx
	subq	%r15, %rdx
	movq	%rdi, 120(%rbx)
	movq	%rsi, 128(%rbx)
	movq	%rax, 136(%rbx)
	movq	%rcx, 144(%rbx)
	movq	%rdx, 152(%rbx)
	addq	$152, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end112:
	.size	ge_madd, .Lfunc_end112-ge_madd
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function x25519_ge_scalarmult_base
.LCPI113_0:
	.byte	15                              # 0xf
	.byte	15                              # 0xf
	.byte	15                              # 0xf
	.byte	15                              # 0xf
	.byte	15                              # 0xf
	.byte	15                              # 0xf
	.byte	15                              # 0xf
	.byte	15                              # 0xf
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
.LCPI113_1:
	.zero	16,15
	.text
	.globl	x25519_ge_scalarmult_base
	.p2align	4, 0x90
	.type	x25519_ge_scalarmult_base,@function
x25519_ge_scalarmult_base:              # @x25519_ge_scalarmult_base
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$504, %rsp                      # imm = 0x1F8
	movq	%rdi, %rbx
	movq	(%rsi), %xmm1                   # xmm1 = mem[0],zero
	movdqa	.LCPI113_0(%rip), %xmm0         # xmm0 = <15,15,15,15,15,15,15,15,u,u,u,u,u,u,u,u>
	movdqa	%xmm1, %xmm2
	pand	%xmm0, %xmm2
	psrlw	$4, %xmm1
	movdqa	.LCPI113_1(%rip), %xmm3         # xmm3 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	pand	%xmm3, %xmm1
	punpcklbw	%xmm1, %xmm2            # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movdqa	%xmm2, 32(%rsp)
	movq	8(%rsi), %xmm1                  # xmm1 = mem[0],zero
	movdqa	%xmm1, %xmm2
	pand	%xmm0, %xmm2
	psrlw	$4, %xmm1
	pand	%xmm3, %xmm1
	punpcklbw	%xmm1, %xmm2            # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movdqa	%xmm2, 48(%rsp)
	movq	16(%rsi), %xmm1                 # xmm1 = mem[0],zero
	movdqa	%xmm1, %xmm2
	pand	%xmm0, %xmm2
	psrlw	$4, %xmm1
	pand	%xmm3, %xmm1
	punpcklbw	%xmm1, %xmm2            # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movdqa	%xmm2, 64(%rsp)
	movq	24(%rsi), %xmm1                 # xmm1 = mem[0],zero
	pand	%xmm1, %xmm0
	psrlw	$4, %xmm1
	pand	%xmm3, %xmm1
	punpcklbw	%xmm1, %xmm0            # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movdqa	%xmm0, 80(%rsp)
	movl	$1, %eax
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB113_1:                              # =>This Inner Loop Header: Depth=1
	addb	31(%rsp,%rax), %cl
	leal	8(%rcx), %esi
	movl	%esi, %edx
	sarb	$4, %dl
	andb	$-16, %sil
	subb	%sil, %cl
	movb	%cl, 31(%rsp,%rax)
	cmpq	$63, %rax
	je	.LBB113_3
# %bb.2:                                #   in Loop: Header=BB113_1 Depth=1
	addb	32(%rsp,%rax), %dl
	leal	8(%rdx), %esi
	movl	%esi, %ecx
	sarb	$4, %cl
	andb	$-16, %sil
	subb	%sil, %dl
	movb	%dl, 32(%rsp,%rax)
	addq	$2, %rax
	jmp	.LBB113_1
.LBB113_3:
	addb	%dl, 95(%rsp)
	pxor	%xmm0, %xmm0
	movdqu	%xmm0, 16(%rbx)
	movdqu	%xmm0, (%rbx)
	movq	$0, 32(%rbx)
	leaq	40(%rbx), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movdqu	%xmm0, 48(%rbx)
	movdqu	%xmm0, 64(%rbx)
	movq	$1, 40(%rbx)
	leaq	80(%rbx), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movdqu	%xmm0, 88(%rbx)
	movdqu	%xmm0, 104(%rbx)
	movq	$1, 80(%rbx)
	leaq	120(%rbx), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movdqu	%xmm0, 120(%rbx)
	movdqu	%xmm0, 136(%rbx)
	movq	$0, 152(%rbx)
	movq	$-1, %r13
	xorl	%r14d, %r14d
	leaq	224(%rsp), %rbp
	movq	%rbx, 24(%rsp)                  # 8-byte Spill
	.p2align	4, 0x90
.LBB113_4:                              # =>This Inner Loop Header: Depth=1
	movsbl	34(%rsp,%r13), %edx
	leaq	384(%rsp), %r15
	movq	%r15, %rdi
	movl	%r14d, %esi
	callq	table_select
	movq	%rbp, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	ge_madd
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	leaq	344(%rsp), %r12
	movq	%r12, %rdx
	callq	fe_mul_impl
	movq	8(%rsp), %rdi                   # 8-byte Reload
	leaq	264(%rsp), %rbx
	movq	%rbx, %rsi
	leaq	304(%rsp), %r15
	movq	%r15, %rdx
	callq	fe_mul_impl
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	fe_mul_impl
	movq	16(%rsp), %rdi                  # 8-byte Reload
	movq	%rbp, %rsi
	movq	%rbx, %rdx
	movq	24(%rsp), %rbx                  # 8-byte Reload
	callq	fe_mul_impl
	addq	$2, %r13
	incl	%r14d
	cmpq	$62, %r13
	jb	.LBB113_4
# %bb.5:
	movq	32(%rbx), %rax
	movq	%rax, 128(%rsp)
	movups	(%rbx), %xmm0
	movups	16(%rbx), %xmm1
	movaps	%xmm1, 112(%rsp)
	movaps	%xmm0, 96(%rsp)
	movq	8(%rsp), %rax                   # 8-byte Reload
	movups	(%rax), %xmm0
	movups	16(%rax), %xmm1
	movups	%xmm0, 136(%rsp)
	movups	%xmm1, 152(%rsp)
	movq	32(%rax), %rax
	movq	%rax, 168(%rsp)
	movq	(%rsp), %rax                    # 8-byte Reload
	movups	(%rax), %xmm0
	movups	16(%rax), %xmm1
	movaps	%xmm0, 176(%rsp)
	movaps	%xmm1, 192(%rsp)
	movq	32(%rax), %rax
	movq	%rax, 208(%rsp)
	leaq	224(%rsp), %r14
	leaq	96(%rsp), %rsi
	movq	%r14, %rdi
	callq	ge_p2_dbl
	leaq	96(%rsp), %r15
	movq	%r15, %rdi
	movq	%r14, %rsi
	leaq	344(%rsp), %rbp
	movq	%rbp, %rdx
	callq	fe_mul_impl
	leaq	136(%rsp), %rdi
	leaq	264(%rsp), %r13
	movq	%r13, %rsi
	leaq	304(%rsp), %r12
	movq	%r12, %rdx
	callq	fe_mul_impl
	leaq	176(%rsp), %rdi
	movq	%r12, %rsi
	movq	%rbp, %rdx
	callq	fe_mul_impl
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	ge_p2_dbl
	movq	%r15, %rdi
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	fe_mul_impl
	leaq	136(%rsp), %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	fe_mul_impl
	leaq	176(%rsp), %rdi
	movq	%r12, %rsi
	movq	%rbp, %rdx
	callq	fe_mul_impl
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	ge_p2_dbl
	movq	%r15, %rdi
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	fe_mul_impl
	leaq	136(%rsp), %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	fe_mul_impl
	leaq	176(%rsp), %rdi
	movq	%r12, %rsi
	movq	%rbp, %rdx
	callq	fe_mul_impl
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	ge_p2_dbl
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	fe_mul_impl
	movq	8(%rsp), %rdi                   # 8-byte Reload
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	fe_mul_impl
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r12, %rsi
	movq	%rbp, %rdx
	callq	fe_mul_impl
	movq	16(%rsp), %rdi                  # 8-byte Reload
	movq	%r14, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	movq	$-2, %r13
	xorl	%r15d, %r15d
	.p2align	4, 0x90
.LBB113_6:                              # =>This Inner Loop Header: Depth=1
	movsbl	34(%rsp,%r13), %edx
	leaq	384(%rsp), %r14
	movq	%r14, %rdi
	movl	%r15d, %esi
	callq	table_select
	leaq	224(%rsp), %rbp
	movq	%rbp, %rdi
	movq	%rbx, %rsi
	movq	%r14, %rdx
	callq	ge_madd
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	leaq	344(%rsp), %r12
	movq	%r12, %rdx
	callq	fe_mul_impl
	movq	8(%rsp), %rdi                   # 8-byte Reload
	leaq	264(%rsp), %rbx
	movq	%rbx, %rsi
	leaq	304(%rsp), %r14
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r14, %rsi
	movq	%r12, %rdx
	callq	fe_mul_impl
	movq	16(%rsp), %rdi                  # 8-byte Reload
	movq	%rbp, %rsi
	movq	%rbx, %rdx
	movq	24(%rsp), %rbx                  # 8-byte Reload
	callq	fe_mul_impl
	addq	$2, %r13
	incl	%r15d
	cmpq	$62, %r13
	jb	.LBB113_6
# %bb.7:
	addq	$504, %rsp                      # imm = 0x1F8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end113:
	.size	x25519_ge_scalarmult_base, .Lfunc_end113-x25519_ge_scalarmult_base
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function table_select
	.type	table_select,@function
table_select:                           # @table_select
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movslq	%edx, %rax
	movq	%rax, %rcx
	sarq	$63, %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
                                        # kill: def $cl killed $cl killed $rcx
	andb	%dl, %cl
	addb	%cl, %cl
	subb	%cl, %dl
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -128(%rsp)
	movaps	%xmm0, -96(%rsp)
	movaps	%xmm0, -48(%rsp)
	movaps	%xmm0, -64(%rsp)
	movaps	%xmm0, -80(%rsp)
	movaps	%xmm0, -112(%rsp)
	movq	%rax, %rcx
	notq	%rcx
	decq	%rax
	andq	%rcx, %rax
	shrq	$63, %rax
	movb	%al, -128(%rsp)
	movb	%al, -96(%rsp)
	#APP
	#NO_APP
	movslq	%esi, %rax
	movzbl	%dl, %esi
	movl	%esi, %ecx
	xorl	$1, %ecx
	decq	%rcx
	sarq	$63, %rcx
	#APP
	#NO_APP
	movd	%ecx, %xmm0
	punpcklbw	%xmm0, %xmm0            # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0,4,5,6,7]
	pshufd	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0]
	leaq	(%rax,%rax,2), %rcx
	shlq	$8, %rcx
	leaq	k25519Precomp(%rip), %rdx
	movdqa	(%rcx,%rdx), %xmm2
	pand	%xmm0, %xmm2
	pxor	-128(%rsp), %xmm2
	movdqa	%xmm2, -128(%rsp)
	movdqa	16(%rcx,%rdx), %xmm3
	pand	%xmm0, %xmm3
	pxor	-112(%rsp), %xmm3
	movdqa	%xmm3, -112(%rsp)
	movdqa	32(%rcx,%rdx), %xmm4
	pand	%xmm0, %xmm4
	pxor	-96(%rsp), %xmm4
	movdqa	%xmm4, -96(%rsp)
	movdqa	48(%rcx,%rdx), %xmm5
	pand	%xmm0, %xmm5
	pxor	-80(%rsp), %xmm5
	movdqa	%xmm5, -80(%rsp)
	movdqa	64(%rcx,%rdx), %xmm6
	pand	%xmm0, %xmm6
	pxor	-64(%rsp), %xmm6
	movq	%rdi, 24(%rsp)                  # 8-byte Spill
	movdqa	%xmm6, -64(%rsp)
	pand	80(%rcx,%rdx), %xmm0
	pxor	-48(%rsp), %xmm0
	movdqa	%xmm0, -48(%rsp)
	movl	%esi, %eax
	xorl	$2, %eax
	decq	%rax
	sarq	$63, %rax
	#APP
	#NO_APP
	movd	%eax, %xmm1
	punpcklbw	%xmm1, %xmm1            # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm1, %xmm1                # xmm1 = xmm1[0,0,0,0,4,5,6,7]
	pshufd	$0, %xmm1, %xmm1                # xmm1 = xmm1[0,0,0,0]
	movdqa	96(%rcx,%rdx), %xmm7
	pand	%xmm1, %xmm7
	pxor	%xmm2, %xmm7
	movdqa	%xmm7, -128(%rsp)
	movdqa	112(%rcx,%rdx), %xmm2
	pand	%xmm1, %xmm2
	pxor	%xmm3, %xmm2
	movdqa	%xmm2, -112(%rsp)
	movdqa	128(%rcx,%rdx), %xmm3
	pand	%xmm1, %xmm3
	pxor	%xmm4, %xmm3
	movdqa	%xmm3, -96(%rsp)
	movdqa	144(%rcx,%rdx), %xmm4
	pand	%xmm1, %xmm4
	pxor	%xmm5, %xmm4
	movdqa	%xmm4, -80(%rsp)
	movdqa	160(%rcx,%rdx), %xmm5
	pand	%xmm1, %xmm5
	pxor	%xmm6, %xmm5
	movdqa	%xmm5, -64(%rsp)
	pand	176(%rcx,%rdx), %xmm1
	pxor	%xmm0, %xmm1
	movdqa	%xmm1, -48(%rsp)
	movl	%esi, %eax
	xorl	$3, %eax
	decq	%rax
	sarq	$63, %rax
	#APP
	#NO_APP
	movd	%eax, %xmm0
	punpcklbw	%xmm0, %xmm0            # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0,4,5,6,7]
	pshufd	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0]
	movdqa	192(%rcx,%rdx), %xmm6
	pand	%xmm0, %xmm6
	pxor	%xmm7, %xmm6
	movdqa	%xmm6, -128(%rsp)
	movdqa	208(%rcx,%rdx), %xmm7
	pand	%xmm0, %xmm7
	pxor	%xmm2, %xmm7
	movdqa	%xmm7, -112(%rsp)
	movdqa	224(%rcx,%rdx), %xmm2
	pand	%xmm0, %xmm2
	pxor	%xmm3, %xmm2
	movdqa	%xmm2, -96(%rsp)
	movdqa	240(%rcx,%rdx), %xmm3
	pand	%xmm0, %xmm3
	pxor	%xmm4, %xmm3
	movdqa	%xmm3, -80(%rsp)
	movdqa	256(%rcx,%rdx), %xmm4
	pand	%xmm0, %xmm4
	pxor	%xmm5, %xmm4
	movdqa	%xmm4, -64(%rsp)
	pand	272(%rcx,%rdx), %xmm0
	pxor	%xmm1, %xmm0
	movdqa	%xmm0, -48(%rsp)
	movl	%esi, %eax
	xorl	$4, %eax
	decq	%rax
	sarq	$63, %rax
	#APP
	#NO_APP
	movd	%eax, %xmm1
	punpcklbw	%xmm1, %xmm1            # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm1, %xmm1                # xmm1 = xmm1[0,0,0,0,4,5,6,7]
	pshufd	$0, %xmm1, %xmm1                # xmm1 = xmm1[0,0,0,0]
	movdqa	288(%rcx,%rdx), %xmm5
	pand	%xmm1, %xmm5
	pxor	%xmm6, %xmm5
	movdqa	%xmm5, -128(%rsp)
	movdqa	304(%rcx,%rdx), %xmm6
	pand	%xmm1, %xmm6
	pxor	%xmm7, %xmm6
	movdqa	%xmm6, -112(%rsp)
	movdqa	320(%rcx,%rdx), %xmm7
	pand	%xmm1, %xmm7
	pxor	%xmm2, %xmm7
	movdqa	%xmm7, -96(%rsp)
	movdqa	336(%rcx,%rdx), %xmm2
	pand	%xmm1, %xmm2
	pxor	%xmm3, %xmm2
	movdqa	%xmm2, -80(%rsp)
	movdqa	352(%rcx,%rdx), %xmm3
	pand	%xmm1, %xmm3
	pxor	%xmm4, %xmm3
	movdqa	%xmm3, -64(%rsp)
	pand	368(%rcx,%rdx), %xmm1
	pxor	%xmm0, %xmm1
	movdqa	%xmm1, -48(%rsp)
	movl	%esi, %eax
	xorl	$5, %eax
	decq	%rax
	sarq	$63, %rax
	#APP
	#NO_APP
	movd	%eax, %xmm0
	punpcklbw	%xmm0, %xmm0            # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0,4,5,6,7]
	pshufd	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0]
	movdqa	384(%rcx,%rdx), %xmm4
	pand	%xmm0, %xmm4
	pxor	%xmm5, %xmm4
	movdqa	%xmm4, -128(%rsp)
	movdqa	400(%rcx,%rdx), %xmm5
	pand	%xmm0, %xmm5
	pxor	%xmm6, %xmm5
	movdqa	%xmm5, -112(%rsp)
	movdqa	416(%rcx,%rdx), %xmm6
	pand	%xmm0, %xmm6
	pxor	%xmm7, %xmm6
	movdqa	%xmm6, -96(%rsp)
	movdqa	432(%rcx,%rdx), %xmm7
	pand	%xmm0, %xmm7
	pxor	%xmm2, %xmm7
	movdqa	%xmm7, -80(%rsp)
	movdqa	448(%rcx,%rdx), %xmm2
	pand	%xmm0, %xmm2
	pxor	%xmm3, %xmm2
	pand	464(%rcx,%rdx), %xmm0
	movdqa	%xmm2, -64(%rsp)
	pxor	%xmm1, %xmm0
	movdqa	%xmm0, -48(%rsp)
	movl	%esi, %eax
	xorl	$6, %eax
	decq	%rax
	sarq	$63, %rax
	#APP
	#NO_APP
	movd	%eax, %xmm1
	punpcklbw	%xmm1, %xmm1            # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm1, %xmm1                # xmm1 = xmm1[0,0,0,0,4,5,6,7]
	pshufd	$0, %xmm1, %xmm1                # xmm1 = xmm1[0,0,0,0]
	movdqa	480(%rcx,%rdx), %xmm3
	pand	%xmm1, %xmm3
	pxor	%xmm4, %xmm3
	movdqa	%xmm3, -128(%rsp)
	movdqa	496(%rcx,%rdx), %xmm4
	pand	%xmm1, %xmm4
	pxor	%xmm5, %xmm4
	movdqa	%xmm4, -112(%rsp)
	movdqa	512(%rcx,%rdx), %xmm5
	pand	%xmm1, %xmm5
	pxor	%xmm6, %xmm5
	movdqa	%xmm5, -96(%rsp)
	movdqa	528(%rcx,%rdx), %xmm6
	pand	%xmm1, %xmm6
	pxor	%xmm7, %xmm6
	movdqa	%xmm6, -80(%rsp)
	movdqa	544(%rcx,%rdx), %xmm7
	pand	%xmm1, %xmm7
	pxor	%xmm2, %xmm7
	movdqa	%xmm7, -64(%rsp)
	pand	560(%rcx,%rdx), %xmm1
	pxor	%xmm0, %xmm1
	movdqa	%xmm1, -48(%rsp)
	movl	%esi, %eax
	xorl	$7, %eax
	decq	%rax
	sarq	$63, %rax
	#APP
	#NO_APP
	movd	%eax, %xmm0
	punpcklbw	%xmm0, %xmm0            # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0,4,5,6,7]
	pshufd	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0]
	movdqa	576(%rcx,%rdx), %xmm2
	pand	%xmm0, %xmm2
	pxor	%xmm3, %xmm2
	movdqa	%xmm2, -128(%rsp)
	movdqa	592(%rcx,%rdx), %xmm3
	pand	%xmm0, %xmm3
	pxor	%xmm4, %xmm3
	movdqa	%xmm3, -112(%rsp)
	movdqa	608(%rcx,%rdx), %xmm4
	pand	%xmm0, %xmm4
	pxor	%xmm5, %xmm4
	movdqa	%xmm4, -96(%rsp)
	movdqa	624(%rcx,%rdx), %xmm5
	pand	%xmm0, %xmm5
	pxor	%xmm6, %xmm5
	movdqa	%xmm5, -80(%rsp)
	movdqa	640(%rcx,%rdx), %xmm6
	pand	%xmm0, %xmm6
	pxor	%xmm7, %xmm6
	movdqa	%xmm6, -64(%rsp)
	pand	656(%rcx,%rdx), %xmm0
	pxor	%xmm1, %xmm0
	movdqa	%xmm0, -48(%rsp)
	xorl	$8, %esi
	decq	%rsi
	sarq	$63, %rsi
	#APP
	#NO_APP
	movd	%esi, %xmm1
	punpcklbw	%xmm1, %xmm1            # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm1, %xmm1                # xmm1 = xmm1[0,0,0,0,4,5,6,7]
	pshufd	$0, %xmm1, %xmm1                # xmm1 = xmm1[0,0,0,0]
	movdqa	672(%rcx,%rdx), %xmm7
	pand	%xmm1, %xmm7
	pxor	%xmm2, %xmm7
	movdqa	%xmm7, -128(%rsp)
	movdqa	688(%rcx,%rdx), %xmm2
	pand	%xmm1, %xmm2
	pxor	%xmm3, %xmm2
	movdqa	%xmm2, -112(%rsp)
	movdqa	704(%rcx,%rdx), %xmm2
	pand	%xmm1, %xmm2
	pxor	%xmm4, %xmm2
	movdqa	%xmm2, -96(%rsp)
	movdqa	720(%rcx,%rdx), %xmm2
	pand	%xmm1, %xmm2
	pxor	%xmm5, %xmm2
	movdqa	%xmm2, -80(%rsp)
	movdqa	736(%rcx,%rdx), %xmm2
	pand	%xmm1, %xmm2
	pxor	%xmm6, %xmm2
	movdqa	%xmm2, -64(%rsp)
	pand	752(%rcx,%rdx), %xmm1
	pxor	%xmm0, %xmm1
	movdqa	%xmm1, -48(%rsp)
	movl	-100(%rsp), %eax
	shlq	$20, %rax
	movzbl	-101(%rsp), %ecx
	shlq	$12, %rcx
	orq	%rax, %rcx
	movzbl	-102(%rsp), %r11d
	shlq	$4, %r11
	orq	%rcx, %r11
	movl	-112(%rsp), %eax
	movl	-106(%rsp), %edi
	movq	%rdi, %r10
	shlq	$23, %r10
	movzbl	-107(%rsp), %ecx
	shlq	$15, %rcx
	movzbl	-108(%rsp), %ebx
	shlq	$7, %rbx
	movzbl	-113(%rsp), %edx
	shlq	$18, %rdx
	movzbl	-114(%rsp), %esi
	shlq	$10, %rsi
	movzbl	-116(%rsp), %r14d
	movzbl	-117(%rsp), %r15d
	shlq	$37, %r15
	movzbl	-122(%rsp), %r12d
	movzbl	-123(%rsp), %r8d
	shlq	$40, %r8
	movl	%r12d, %r9d
	andl	$7, %r9d
	shlq	$48, %r9
	orq	%r8, %r9
	movl	-128(%rsp), %r8d
	orq	%r8, %r9
	movzbl	-124(%rsp), %r8d
	shlq	$32, %r8
	orq	%r8, %r9
	movl	%r14d, %r8d
	andl	$63, %r8d
	shlq	$45, %r8
	orq	%r15, %r8
	movzbl	-118(%rsp), %r15d
	shlq	$29, %r15
	orq	%r15, %r8
	movzbl	-119(%rsp), %r15d
	shlq	$21, %r15
	orq	%r15, %r8
	movzbl	-120(%rsp), %r15d
	shlq	$13, %r15
	orq	%r15, %r8
	movzbl	-121(%rsp), %r15d
	shlq	$5, %r15
	orq	%r15, %r8
	movzbl	-115(%rsp), %r15d
	shrq	$3, %r12
	orq	%r12, %r8
	shrq	$6, %r14
	movl	%eax, %r12d
	andl	$33554431, %r12d                # imm = 0x1FFFFFF
	shlq	$26, %r12
	orq	%rdx, %r12
	orq	%rsi, %r12
	leaq	(%r12,%r15,4), %rdx
	orq	%r14, %rdx
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	shrq	$25, %rax
	movabsq	$2251799746576384, %rdx         # imm = 0x7FFFFFC000000
	orq	$58720256, %rdx                 # imm = 0x3800000
	andq	%rdx, %r10
	movq	%rdx, %r14
	orq	%rcx, %r10
	orq	%rbx, %r10
	orq	%rax, %r10
	movq	%r10, (%rsp)                    # 8-byte Spill
	shrq	$28, %rdi
	orq	%r11, %rdi
	movq	%rdi, 8(%rsp)                   # 8-byte Spill
	movl	-68(%rsp), %eax
	shlq	$20, %rax
	movzbl	-69(%rsp), %ecx
	shlq	$12, %rcx
	orq	%rax, %rcx
	movzbl	-70(%rsp), %r13d
	shlq	$4, %r13
	orq	%rcx, %r13
	movl	-80(%rsp), %eax
	movzbl	-84(%rsp), %ecx
	movzbl	-85(%rsp), %edx
	shlq	$37, %rdx
	movzbl	-90(%rsp), %esi
	movzbl	-91(%rsp), %ebx
	shlq	$40, %rbx
	movl	%esi, %r11d
	andl	$7, %r11d
	shlq	$48, %r11
	orq	%rbx, %r11
	movl	-96(%rsp), %ebx
	orq	%rbx, %r11
	movzbl	-92(%rsp), %ebx
	shlq	$32, %rbx
	orq	%rbx, %r11
	movq	%r11, -24(%rsp)                 # 8-byte Spill
	movl	%ecx, %ebx
	andl	$63, %ebx
	shlq	$45, %rbx
	orq	%rdx, %rbx
	movzbl	-86(%rsp), %edx
	shlq	$29, %rdx
	orq	%rdx, %rbx
	movzbl	-87(%rsp), %edx
	shlq	$21, %rdx
	orq	%rdx, %rbx
	movzbl	-88(%rsp), %edx
	shlq	$13, %rdx
	orq	%rdx, %rbx
	movzbl	-89(%rsp), %edx
	shlq	$5, %rdx
	orq	%rdx, %rbx
	movzbl	-81(%rsp), %edx
	shlq	$18, %rdx
	shrq	$3, %rsi
	orq	%rsi, %rbx
	movl	%eax, %esi
	andl	$33554431, %esi                 # imm = 0x1FFFFFF
	shlq	$26, %rsi
	orq	%rdx, %rsi
	movzbl	-82(%rsp), %edx
	shlq	$10, %rdx
	orq	%rdx, %rsi
	movzbl	-83(%rsp), %edx
	leaq	(%rsi,%rdx,4), %rsi
	movl	-74(%rsp), %edx
	shrq	$6, %rcx
	orq	%rcx, %rsi
	movq	%rsi, -32(%rsp)                 # 8-byte Spill
	movq	%rdx, %r12
	shlq	$23, %r12
	movzbl	-75(%rsp), %ecx
	shlq	$15, %rcx
	andq	%r14, %r12
	orq	%rcx, %r12
	movzbl	-76(%rsp), %ecx
	shlq	$7, %rcx
	orq	%rcx, %r12
	shrq	$25, %rax
	orq	%rax, %r12
	shrq	$28, %rdx
	orq	%r13, %rdx
	movq	%rdx, -8(%rsp)                  # 8-byte Spill
	movl	-36(%rsp), %eax
	shlq	$20, %rax
	movzbl	-37(%rsp), %ecx
	shlq	$12, %rcx
	orq	%rax, %rcx
	movzbl	-38(%rsp), %ebp
	shlq	$4, %rbp
	orq	%rcx, %rbp
	movzbl	-59(%rsp), %eax
	shlq	$40, %rax
	movzbl	-58(%rsp), %ecx
	movl	%ecx, %r13d
	andl	$7, %r13d
	shlq	$48, %r13
	orq	%rax, %r13
	movl	-64(%rsp), %eax
	orq	%rax, %r13
	movzbl	-60(%rsp), %eax
	shlq	$32, %rax
	orq	%rax, %r13
	movzbl	-53(%rsp), %esi
	shlq	$37, %rsi
	movzbl	-52(%rsp), %edi
	movl	%edi, %r10d
	andl	$63, %r10d
	shlq	$45, %r10
	orq	%rsi, %r10
	movzbl	-54(%rsp), %esi
	shlq	$29, %rsi
	orq	%rsi, %r10
	movzbl	-55(%rsp), %esi
	shlq	$21, %rsi
	orq	%rsi, %r10
	movzbl	-56(%rsp), %esi
	shlq	$13, %rsi
	orq	%rsi, %r10
	movzbl	-57(%rsp), %esi
	shlq	$5, %rsi
	orq	%rsi, %r10
	shrq	$3, %rcx
	orq	%rcx, %r10
	movzbl	-49(%rsp), %ecx
	shlq	$18, %rcx
	movl	-48(%rsp), %edx
	movl	%edx, %esi
	andl	$33554431, %esi                 # imm = 0x1FFFFFF
	shlq	$26, %rsi
	orq	%rcx, %rsi
	movzbl	-50(%rsp), %ecx
	shlq	$10, %rcx
	orq	%rcx, %rsi
	movzbl	-51(%rsp), %ecx
	leaq	(%rsi,%rcx,4), %rax
	shrq	$6, %rdi
	orq	%rdi, %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movl	-42(%rsp), %r15d
	movq	%r15, %rcx
	shlq	$23, %rcx
	andq	%r14, %rcx
	movzbl	-43(%rsp), %edi
	shlq	$15, %rdi
	orq	%rdi, %rcx
	movzbl	-44(%rsp), %edi
	shlq	$7, %rdi
	orq	%rdi, %rcx
	shrq	$25, %rdx
	orq	%rdx, %rcx
	shrq	$28, %r15
	orq	%rbp, %r15
	movq	%r11, %rbp
	xorq	%r9, %rbp
	movq	32(%rsp), %rsi                  # 8-byte Reload
	andq	%rsi, %rbp
	xorq	%rbp, %r9
	movq	24(%rsp), %r11                  # 8-byte Reload
	movq	%r9, (%r11)
	movq	%r8, %rdi
	xorq	%rbx, %rdi
	andq	%rsi, %rdi
	xorq	%rdi, %r8
	movq	%r8, 8(%r11)
	movq	16(%rsp), %r8                   # 8-byte Reload
	movq	%r8, %rdx
	xorq	-32(%rsp), %rdx                 # 8-byte Folded Reload
	andq	%rsi, %rdx
	xorq	%rdx, %r8
	movq	%r8, 16(%r11)
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	%rax, %r8
	xorq	%r12, %r8
	andq	%rsi, %r8
	xorq	%r8, %rax
	movq	%rax, 24(%r11)
	movq	8(%rsp), %rax                   # 8-byte Reload
	movq	%rax, %r9
	movq	-8(%rsp), %r14                  # 8-byte Reload
	xorq	%r14, %r9
	andq	%rsi, %r9
	xorq	%r9, %rax
	movq	%rax, 32(%r11)
	xorq	-24(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%rbp, 40(%r11)
	xorq	%rbx, %rdi
	movq	%rdi, 48(%r11)
	xorq	-32(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 56(%r11)
	xorq	%r12, %r8
	movq	%r8, 64(%r11)
	xorq	%r14, %r9
	movabsq	$4503599627370494, %rdi         # imm = 0xFFFFFFFFFFFFE
	movq	%r9, 72(%r11)
	movq	%rdi, %rdx
	subq	%r13, %rdx
	addq	$-36, %rdx
	xorq	%r13, %rdx
	andq	%rsi, %rdx
	xorq	%r13, %rdx
	movq	%rdx, 80(%r11)
	movq	%rdi, %rdx
	subq	%r10, %rdx
	xorq	%r10, %rdx
	andq	%rsi, %rdx
	xorq	%r10, %rdx
	movq	%rdx, 88(%r11)
	movq	%rdi, %rax
	movq	-16(%rsp), %rdx                 # 8-byte Reload
	subq	%rdx, %rax
	xorq	%rdx, %rax
	andq	%rsi, %rax
	xorq	%rdx, %rax
	movq	%rax, 96(%r11)
	movq	%rdi, %rax
	subq	%rcx, %rax
	xorq	%rcx, %rax
	andq	%rsi, %rax
	xorq	%rcx, %rax
	movq	%rax, 104(%r11)
	subq	%r15, %rdi
	xorq	%r15, %rdi
	andq	%rsi, %rdi
	xorq	%r15, %rdi
	movq	%rdi, 112(%r11)
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end114:
	.size	table_select, .Lfunc_end114-table_select
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function ge_p2_dbl
.LCPI115_0:
	.quad	2251799813685247                # 0x7ffffffffffff
	.quad	2251799813685247                # 0x7ffffffffffff
.LCPI115_1:
	.quad	4503599627370494                # 0xffffffffffffe
	.quad	4503599627370494                # 0xffffffffffffe
	.text
	.p2align	4, 0x90
	.type	ge_p2_dbl,@function
ge_p2_dbl:                              # @ge_p2_dbl
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$168, %rsp
	movq	%rsi, %r15
	movq	32(%rsi), %rcx
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rax
	imulq	$38, %rcx, %r8
	movq	%rcx, %r9
	movq	24(%rsi), %r11
	leaq	(%r11,%r11,8), %rcx
	leaq	(%r11,%rcx,2), %rcx
	imulq	$38, %r11, %r10
	mulq	%r9
	movq	%r9, %rsi
	movq	%r9, 152(%rsp)                  # 8-byte Spill
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r8
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r11
	movq	%r11, 80(%rsp)                  # 8-byte Spill
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	movq	16(%r15), %rbx
	movq	%rbx, %rax
	mulq	%r8
	movq	%rdx, %rcx
	movq	%rax, %r9
	movq	%rbx, %rax
	mulq	%r10
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rbx, 72(%rsp)                  # 8-byte Spill
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	8(%r15), %r12
	movq	%r12, %rax
	mulq	%r8
	movq	%rax, %r8
	movq	%rdx, %r14
	leaq	(%r11,%r11), %r13
	movq	%r12, %rax
	mulq	%r13
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	leaq	(%rbx,%rbx), %rbp
	movq	%r12, %rax
	mulq	%rbp
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%r12, %rax
	mulq	%r12
	movq	%r12, 144(%rsp)                 # 8-byte Spill
	movq	%rax, %r11
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	leaq	(%rsi,%rsi), %rdx
	movq	(%r15), %rsi
	movq	%rsi, 136(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	%rdx
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rsi, %rax
	mulq	%r13
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	movq	%rax, %r13
	movq	%rsi, %rax
	mulq	%rbp
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	leaq	(%r12,%r12), %rdx
	movq	%rsi, %rax
	mulq	%rdx
	movq	%rdx, %rbp
	movq	%rax, 160(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	%rsi
	addq	-96(%rsp), %r8                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r8
	adcq	%rdx, %r14
	shldq	$13, %r8, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r8
	movq	48(%rsp), %rsi                  # 8-byte Reload
	addq	-128(%rsp), %rsi                # 8-byte Folded Reload
	adcq	-72(%rsp), %r10                 # 8-byte Folded Reload
	addq	-104(%rsp), %rsi                # 8-byte Folded Reload
	adcq	32(%rsp), %r10                  # 8-byte Folded Reload
	addq	-64(%rsp), %rbx                 # 8-byte Folded Reload
	movq	104(%rsp), %r12                 # 8-byte Reload
	adcq	-56(%rsp), %r12                 # 8-byte Folded Reload
	addq	%r13, %rbx
	adcq	40(%rsp), %r12                  # 8-byte Folded Reload
	addq	-120(%rsp), %r11                # 8-byte Folded Reload
	movq	112(%rsp), %rax                 # 8-byte Reload
	adcq	-80(%rsp), %rax                 # 8-byte Folded Reload
	addq	-88(%rsp), %r11                 # 8-byte Folded Reload
	adcq	64(%rsp), %rax                  # 8-byte Folded Reload
	addq	88(%rsp), %r9                   # 8-byte Folded Reload
	adcq	96(%rsp), %rcx                  # 8-byte Folded Reload
	addq	160(%rsp), %r9                  # 8-byte Folded Reload
	adcq	%rbp, %rcx
	addq	%r14, %r9
	adcq	$0, %rcx
	shldq	$13, %r9, %rcx
	andq	%rdx, %r9
	addq	%r11, %rcx
	adcq	$0, %rax
	shldq	$13, %rcx, %rax
	andq	%rdx, %rcx
	addq	%rbx, %rax
	movq	%r12, %rbx
	adcq	$0, %rbx
	shldq	$13, %rax, %rbx
	andq	%rdx, %rax
	movq	%rdx, %r11
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	addq	%rsi, %rbx
	adcq	$0, %r10
	shldq	$13, %rbx, %r10
	leaq	(%r10,%r10,8), %rax
	leaq	(%r10,%rax,2), %rax
	addq	%r8, %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	shrq	$51, %rax
	addq	%r9, %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	%rcx, %rdx
	movq	%rdx, 160(%rsp)                 # 8-byte Spill
	movq	72(%r15), %rcx
	movq	%rcx, -120(%rsp)                # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rax
	mulq	%rcx
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	imulq	$38, %rcx, %r8
	movq	64(%r15), %rcx
	movq	%rcx, %rax
	mulq	%r8
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rax
	mulq	%rcx
	movq	%rcx, %r9
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	56(%r15), %rsi
	movq	%rsi, %rax
	mulq	%r8
	movq	%rax, %rbp
	movq	%rdx, %rcx
	andq	%r11, %rbx
	movq	%rbx, 104(%rsp)                 # 8-byte Spill
	imulq	$38, %r9, %rdx
	movq	%r9, 48(%rsp)                   # 8-byte Spill
	movq	%rsi, %rax
	mulq	%rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	%rsi, %rax
	mulq	%rsi
	movq	%rsi, 40(%rsp)                  # 8-byte Spill
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	48(%r15), %r11
	movq	%r15, %rbx
	movq	%r11, %rax
	mulq	%r8
	movq	%rax, %r8
	movq	%rdx, %r13
	addq	%r9, %r9
	movq	%r11, %rax
	mulq	%r9
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	%rdx, %r10
	leaq	(%rsi,%rsi), %r12
	movq	%r11, %rax
	mulq	%r12
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	%rax, %rsi
	movq	%r11, %rax
	mulq	%r11
	movq	%r11, 32(%rsp)                  # 8-byte Spill
	movq	%rax, %r15
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	movq	-120(%rsp), %rax                # 8-byte Reload
	leaq	(%rax,%rax), %rdx
	movq	40(%rbx), %r14
	movq	%r14, -80(%rsp)                 # 8-byte Spill
	movq	%r14, %rax
	mulq	%rdx
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	%r14, %rax
	mulq	%r9
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%r14, %rax
	mulq	%r12
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	movq	%rdx, (%rsp)                    # 8-byte Spill
	movabsq	$2251799813685247, %r9          # imm = 0x7FFFFFFFFFFFF
	andq	%r9, -56(%rsp)                  # 8-byte Folded Spill
	leaq	(%r11,%r11), %rdx
	movq	%r14, %rax
	mulq	%rdx
	movq	%rdx, %r12
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r14
	andq	%r9, -64(%rsp)                  # 8-byte Folded Spill
	addq	-8(%rsp), %r8                   # 8-byte Folded Reload
	adcq	8(%rsp), %r13                   # 8-byte Folded Reload
	addq	%rax, %r8
	adcq	%rdx, %r13
	shldq	$13, %r8, %r13
	andq	%r9, %r8
	movq	-16(%rsp), %rdx                 # 8-byte Reload
	addq	24(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	-104(%rsp), %r10                # 8-byte Folded Reload
	addq	-48(%rsp), %rdx                 # 8-byte Folded Reload
	adcq	-40(%rsp), %r10                 # 8-byte Folded Reload
	addq	-96(%rsp), %rsi                 # 8-byte Folded Reload
	movq	88(%rsp), %r11                  # 8-byte Reload
	adcq	-88(%rsp), %r11                 # 8-byte Folded Reload
	addq	-112(%rsp), %rsi                # 8-byte Folded Reload
	adcq	-32(%rsp), %r11                 # 8-byte Folded Reload
	addq	56(%rsp), %r15                  # 8-byte Folded Reload
	movq	96(%rsp), %rax                  # 8-byte Reload
	adcq	64(%rsp), %rax                  # 8-byte Folded Reload
	addq	-24(%rsp), %r15                 # 8-byte Folded Reload
	adcq	(%rsp), %rax                    # 8-byte Folded Reload
	addq	-128(%rsp), %rbp                # 8-byte Folded Reload
	adcq	-72(%rsp), %rcx                 # 8-byte Folded Reload
	addq	16(%rsp), %rbp                  # 8-byte Folded Reload
	adcq	%r12, %rcx
	addq	%r13, %rbp
	adcq	$0, %rcx
	shldq	$13, %rbp, %rcx
	andq	%r9, %rbp
	addq	%r15, %rcx
	adcq	$0, %rax
	shldq	$13, %rcx, %rax
	andq	%r9, %rcx
	addq	%rsi, %rax
	movq	%r11, %rsi
	adcq	$0, %rsi
	shldq	$13, %rax, %rsi
	andq	%r9, %rax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	addq	%rdx, %rsi
	adcq	$0, %r10
	shldq	$13, %rsi, %r10
	leaq	(%r10,%r10,8), %rax
	leaq	(%r10,%rax,2), %rdx
	addq	%r8, %rdx
	movq	%rdx, %rax
	movq	%rdx, %r8
	shrq	$51, %rax
	addq	%rbp, %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	%rcx, %rdx
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	andq	%r9, %rsi
	movq	%rsi, 88(%rsp)                  # 8-byte Spill
	andq	%r9, %r8
	movq	%r8, 56(%rsp)                   # 8-byte Spill
	movq	%rbx, %rsi
	movq	112(%rbx), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	mulq	%rbx
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	104(%rsi), %r10
	leaq	(%r10,%r10,8), %rax
	leaq	(%r10,%rax,2), %rcx
	imulq	$38, %rbx, %r14
	movq	%r10, %rax
	mulq	%r14
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	96(%rsi), %r11
	movq	%r11, %rax
	mulq	%r14
	movq	%rax, %r8
	movq	%rdx, %rcx
	imulq	$38, %r10, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	addq	%r10, %r10
	movq	%r10, -112(%rsp)                # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	88(%rsi), %r9
	movq	%r9, %rax
	mulq	%r14
	movq	%rax, %r14
	movq	%rdx, %r15
	leaq	(%r11,%r11), %r13
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %r11
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r13
	movq	%rdx, %rbp
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, %r12
	movq	%rdx, %r10
	addq	%rbx, %rbx
	movq	80(%rsi), %rsi
	movq	%rsi, %rax
	mulq	%rbx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	-112(%rsp)                      # 8-byte Folded Reload
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	addq	%r9, %r9
	movq	%rsi, %rax
	mulq	%r13
	movq	%rdx, %r13
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rsi, %rax
	mulq	%r9
	movq	%rdx, %r9
	movq	%rax, %rbx
	movq	%rsi, %rax
	mulq	%rsi
	movabsq	$2251799813685247, %rsi         # imm = 0x7FFFFFFFFFFFF
	andq	%rsi, -72(%rsp)                 # 8-byte Folded Spill
	addq	-24(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-16(%rsp), %r15                 # 8-byte Folded Reload
	addq	%rax, %r14
	adcq	%rdx, %r15
	shldq	$13, %r14, %r15
	andq	%rsi, %r14
	movq	%rsi, %rax
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	addq	(%rsp), %rdx                    # 8-byte Folded Reload
	adcq	8(%rsp), %r11                   # 8-byte Folded Reload
	addq	120(%rsp), %rdx                 # 8-byte Folded Reload
	adcq	128(%rsp), %r11                 # 8-byte Folded Reload
	movq	-8(%rsp), %rsi                  # 8-byte Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %rbp                  # 8-byte Folded Reload
	addq	-48(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	-40(%rsp), %rbp                 # 8-byte Folded Reload
	addq	-104(%rsp), %r12                # 8-byte Folded Reload
	adcq	-96(%rsp), %r10                 # 8-byte Folded Reload
	addq	-112(%rsp), %r12                # 8-byte Folded Reload
	adcq	%r13, %r10
	addq	-88(%rsp), %r8                  # 8-byte Folded Reload
	adcq	-128(%rsp), %rcx                # 8-byte Folded Reload
	addq	%rbx, %r8
	adcq	%r9, %rcx
	addq	%r15, %r8
	adcq	$0, %rcx
	shldq	$13, %r8, %rcx
	movq	%rax, %r15
	andq	%rax, %r8
	addq	%r12, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rax, %rcx
	addq	%rsi, %r10
	adcq	$0, %rbp
	shldq	$13, %r10, %rbp
	addq	%rdx, %rbp
	adcq	$0, %r11
	shldq	$13, %rbp, %r11
	leaq	(%r11,%r11,8), %rax
	leaq	(%r11,%rax,2), %rax
	addq	%r14, %rax
	movq	%rax, %rsi
	shrq	$51, %rsi
	addq	%r8, %rsi
	movq	%rsi, %rdx
	movq	%rsi, -88(%rsp)                 # 8-byte Spill
	shrq	$51, %rdx
	addq	%rcx, %rdx
	andq	%r15, %r10
	leaq	(%rdx,%rdx), %r8
	shrq	$50, %rdx
	leaq	(%rdx,%r10,2), %rdx
	andq	%r15, %rbp
	movq	%rdx, %rcx
	movq	%rdx, %r9
	shrq	$51, %rcx
	leaq	(%rcx,%rbp,2), %rcx
	movq	%rcx, -128(%rsp)                # 8-byte Spill
	shrq	$51, %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %r10
	leaq	(%rax,%rax), %rcx
	leaq	-1(%r15), %rdx
	andq	%rdx, %rcx
	addq	%rcx, %r10
	shrq	$50, %rax
	andl	$1, %eax
	leaq	(%rsi,%rsi), %rcx
	andq	%rdx, %rcx
	orq	%rax, %rcx
	movq	%r10, %rax
	shrq	$51, %rax
	addq	%rax, %rcx
	andq	%rdx, %r8
	movq	%r8, -96(%rsp)                  # 8-byte Spill
	movq	-80(%rsp), %rax                 # 8-byte Reload
	addq	136(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	32(%rsp), %r14                  # 8-byte Reload
	addq	144(%rsp), %r14                 # 8-byte Folded Reload
	movq	40(%rsp), %rbx                  # 8-byte Reload
	addq	72(%rsp), %rbx                  # 8-byte Folded Reload
	movq	48(%rsp), %rsi                  # 8-byte Reload
	addq	80(%rsp), %rsi                  # 8-byte Folded Reload
	movq	-120(%rsp), %r11                # 8-byte Reload
	addq	152(%rsp), %r11                 # 8-byte Folded Reload
	movq	%r15, %rax
	andq	%r15, %r10
	movq	%r10, 48(%rsp)                  # 8-byte Spill
	movq	%rcx, %rdx
	andq	%rax, %rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	shrq	$51, %rcx
	movq	%rcx, 144(%rsp)                 # 8-byte Spill
	andq	%rax, %r9
	movq	%r9, 152(%rsp)                  # 8-byte Spill
	leaq	(%r11,%r11,8), %rax
	leaq	(%r11,%rax,2), %rax
	leaq	(%rsi,%rsi,8), %rcx
	leaq	(%rsi,%rcx,2), %rcx
	mulq	%r11
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	imulq	$38, %r11, %r10
	movq	%rsi, %rax
	mulq	%r10
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%rsi
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	imulq	$38, %rsi, %rcx
	leaq	(%rsi,%rsi), %r8
	movq	%rbx, %rax
	mulq	%r10
	movq	%rdx, %rsi
	movq	%rax, %rbp
	movq	%rbx, %rax
	mulq	%rcx
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	%rdx, (%rsp)                    # 8-byte Spill
	leaq	(%rbx,%rbx), %r9
	movq	%r14, %rcx
	movq	%r14, %rax
	mulq	%r10
	movq	%rdx, %r15
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	%r14, %rax
	mulq	%r8
	movq	%rdx, %r13
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r9
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%r11, %r11
	movq	%r14, %rax
	mulq	%r14
	movq	%rdx, %r14
	movq	%rax, %r12
	movq	-80(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rax
	mulq	%r11
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	%rax, %r11
	movq	%rbx, %rax
	mulq	%r8
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	leaq	(%rcx,%rcx), %r8
	movq	%rbx, %rax
	mulq	%r9
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r8
	movq	%rdx, %r9
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	%rbx
	movabsq	$2251799813685247, %rcx         # imm = 0x7FFFFFFFFFFFF
	andq	%rcx, -128(%rsp)                # 8-byte Folded Spill
	movq	-120(%rsp), %r8                 # 8-byte Reload
	addq	-112(%rsp), %r8                 # 8-byte Folded Reload
	adcq	-24(%rsp), %r15                 # 8-byte Folded Reload
	addq	%rax, %r8
	adcq	%rdx, %r15
	shldq	$13, %r8, %r15
	andq	%rcx, %r8
	movq	%r8, -120(%rsp)                 # 8-byte Spill
	movq	80(%rsp), %rax                  # 8-byte Reload
	addq	-8(%rsp), %rax                  # 8-byte Folded Reload
	adcq	(%rsp), %r13                    # 8-byte Folded Reload
	addq	%r11, %rax
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	adcq	120(%rsp), %r13                 # 8-byte Folded Reload
	movq	72(%rsp), %rax                  # 8-byte Reload
	addq	8(%rsp), %rax                   # 8-byte Folded Reload
	adcq	16(%rsp), %r10                  # 8-byte Folded Reload
	addq	128(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	adcq	-48(%rsp), %r10                 # 8-byte Folded Reload
	addq	24(%rsp), %r12                  # 8-byte Folded Reload
	adcq	-104(%rsp), %r14                # 8-byte Folded Reload
	addq	-40(%rsp), %r12                 # 8-byte Folded Reload
	adcq	-32(%rsp), %r14                 # 8-byte Folded Reload
	addq	32(%rsp), %rbp                  # 8-byte Folded Reload
	adcq	40(%rsp), %rsi                  # 8-byte Folded Reload
	addq	-16(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	%r9, %rsi
	addq	%r15, %rbp
	adcq	$0, %rsi
	shldq	$13, %rbp, %rsi
	andq	%rcx, %rbp
	addq	%r12, %rsi
	adcq	$0, %r14
	movabsq	$4503599627370494, %rax         # imm = 0xFFFFFFFFFFFFE
	leaq	-36(%rax), %r8
	movq	-56(%rsp), %rcx                 # 8-byte Reload
	subq	%rcx, %r8
	movq	56(%rsp), %rdx                  # 8-byte Reload
	leaq	(%rdx,%rcx), %r15
	addq	%rdx, %r8
	movq	%rax, %r9
	movq	-64(%rsp), %rcx                 # 8-byte Reload
	subq	%rcx, %r9
	movq	-72(%rsp), %rdx                 # 8-byte Reload
	addq	%rdx, %rcx
	addq	%rdx, %r9
	movq	%r9, -80(%rsp)                  # 8-byte Spill
	movq	%rax, %r11
	movq	160(%rsp), %rdx                 # 8-byte Reload
	subq	%rdx, %r11
	movq	64(%rsp), %r9                   # 8-byte Reload
	leaq	(%r9,%rdx), %rbx
	addq	%r9, %r11
	movq	%r11, -56(%rsp)                 # 8-byte Spill
	movq	%rax, %r9
	movq	112(%rsp), %rdx                 # 8-byte Reload
	subq	%rdx, %r9
	movq	96(%rsp), %r11                  # 8-byte Reload
	addq	%r11, %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	addq	%r11, %r9
	movq	%r9, 112(%rsp)                  # 8-byte Spill
	movq	%rax, %r12
	movq	104(%rsp), %rdx                 # 8-byte Reload
	subq	%rdx, %r12
	movq	88(%rsp), %r11                  # 8-byte Reload
	addq	%r11, %rdx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	addq	%r11, %r12
	movq	%r15, 40(%rdi)
	movq	%rcx, 48(%rdi)
	movq	%r15, %r11
	shrq	$51, %r11
	addq	%rcx, %r11
	shldq	$13, %rsi, %r14
	movabsq	$2251799813685247, %r9          # imm = 0x7FFFFFFFFFFFF
	andq	%r9, %rsi
	movq	%r11, %rcx
	shrq	$51, %rcx
	addq	%rbx, %rcx
	movq	%rcx, %rdx
	shrq	$51, %rdx
	andq	%r9, %r15
	andq	%r9, %r11
	andq	%r9, %rcx
	addq	72(%rsp), %r14                  # 8-byte Folded Reload
	adcq	$0, %r10
	movq	%rbx, 56(%rdi)
	shldq	$13, %r14, %r10
	addq	80(%rsp), %r10                  # 8-byte Folded Reload
	adcq	$0, %r13
	shldq	$13, %r10, %r13
	leaq	(,%r13,8), %rbx
	addq	%r13, %rbx
	leaq	(%r13,%rbx,2), %r13
	addq	-120(%rsp), %r13                # 8-byte Folded Reload
	movq	%r13, %rbx
	shrq	$51, %rbx
	addq	%rbp, %rbx
	movq	%r10, %xmm1
	movq	%r14, %xmm0
	movq	-64(%rsp), %r9                  # 8-byte Reload
	movq	%r9, 64(%rdi)
	addq	%r9, %rdx
	movq	104(%rsp), %r9                  # 8-byte Reload
	movq	%r9, 72(%rdi)
	movq	%rdx, %xmm2
	shrq	$51, %rdx
	addq	%r9, %rdx
	movq	%rdx, %xmm3
	shrq	$51, %rdx
	leaq	(%rdx,%rdx,8), %r9
	leaq	(%rdx,%r9,2), %rdx
	addq	%r15, %rdx
	movq	%rdx, %r9
	shrq	$51, %r9
	addq	%r11, %r9
	movq	%r9, %r10
	shrq	$51, %r9
	addq	%rcx, %r9
	movabsq	$2251799813685247, %r14         # imm = 0x7FFFFFFFFFFFF
	andq	%r14, %r13
	andq	%r14, %rdx
	leaq	(%rax,%r13), %rcx
	addq	$-36, %rcx
	subq	%rdx, %rcx
	movq	%rbx, %rdx
	andq	%r14, %rbx
	andq	%r14, %r10
	addq	%rax, %rbx
	subq	%r10, %rbx
	shrq	$51, %rdx
	addq	%rax, %rsi
	addq	%rdx, %rsi
	subq	%r9, %rsi
	movq	%r8, 80(%rdi)
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, 88(%rdi)
	movq	-56(%rsp), %r10                 # 8-byte Reload
	movq	%r10, 96(%rdi)
	movq	112(%rsp), %r11                 # 8-byte Reload
	movq	%r11, 104(%rdi)
	movq	%r12, 112(%rdi)
	movq	%rcx, (%rdi)
	movq	%rbx, 8(%rdi)
	movq	%rsi, 16(%rdi)
	movq	%r8, %rcx
	shrq	$51, %rcx
	addq	%rdx, %rcx
	movq	%rcx, %r9
	shrq	$51, %r9
	addq	%r10, %r9
	movq	%r9, %rdx
	shrq	$51, %rdx
	addq	%r11, %rdx
	movq	%rdx, %rsi
	shrq	$51, %rsi
	addq	%r12, %rsi
	movq	%rsi, %r10
	shrq	$51, %r10
	leaq	(%r10,%r10,8), %r11
	leaq	(%r10,%r11,2), %r10
	andq	%r14, %r8
	addq	%r8, %r10
	movq	%r10, %r8
	shrq	$51, %r8
	andq	%r14, %rcx
	addq	%r8, %rcx
	andq	%r14, %r10
	movq	%rcx, %r8
	andq	%r14, %r8
	andq	%r14, %r9
	andq	%r14, %rdx
	andq	%r14, %rsi
	negq	%r10
	addq	%rax, %r10
	addq	$-36, %r10
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	movq	%rax, %r11
	subq	%r8, %r11
	addq	136(%rsp), %r11                 # 8-byte Folded Reload
	movq	%rax, %r8
	subq	%r9, %r8
	shrq	$51, %rcx
	btq	$50, -88(%rsp)                  # 8-byte Folded Reload
	adcq	-96(%rsp), %r8                  # 8-byte Folded Reload
	subq	%rcx, %r8
	addq	144(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rax, %rcx
	subq	%rdx, %rcx
	addq	152(%rsp), %rcx                 # 8-byte Folded Reload
	subq	%rsi, %rax
	addq	-128(%rsp), %rax                # 8-byte Folded Reload
	punpcklqdq	%xmm1, %xmm0            # xmm0 = xmm0[0],xmm1[0]
	movdqa	.LCPI115_0(%rip), %xmm1         # xmm1 = [2251799813685247,2251799813685247]
	pand	%xmm1, %xmm0
	punpcklqdq	%xmm3, %xmm2            # xmm2 = xmm2[0],xmm3[0]
	pand	%xmm1, %xmm2
	psubq	%xmm2, %xmm0
	paddq	.LCPI115_1(%rip), %xmm0
	movdqu	%xmm0, 24(%rdi)
	movq	%r10, 120(%rdi)
	movq	%r11, 128(%rdi)
	movq	%r8, 136(%rdi)
	movq	%rcx, 144(%rdi)
	movq	%rax, 152(%rdi)
	addq	$168, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end115:
	.size	ge_p2_dbl, .Lfunc_end115-ge_p2_dbl
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function x25519_ge_scalarmult
.LCPI116_0:
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	1                               # 0x1
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
.LCPI116_1:
	.quad	1                               # 0x1
	.quad	0                               # 0x0
	.text
	.globl	x25519_ge_scalarmult
	.p2align	4, 0x90
	.type	x25519_ge_scalarmult,@function
x25519_ge_scalarmult:                   # @x25519_ge_scalarmult
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$4056, %rsp                     # imm = 0xFD8
	movq	%rdx, %r14
	movq	%rsi, 40(%rsp)                  # 8-byte Spill
	movq	%rdi, 24(%rsp)                  # 8-byte Spill
	xorps	%xmm0, %xmm0
	movups	%xmm0, 1496(%rsp)
	movups	%xmm0, 1512(%rsp)
	movq	$1, 1488(%rsp)
	movaps	%xmm0, 1536(%rsp)
	movaps	%xmm0, 1552(%rsp)
	movq	$1, 1528(%rsp)
	movups	%xmm0, 1576(%rsp)
	movups	%xmm0, 1592(%rsp)
	movq	$1, 1568(%rsp)
	movups	%xmm0, 1608(%rsp)
	movups	%xmm0, 1624(%rsp)
	movq	$0, 1640(%rsp)
	movq	40(%rdx), %rax
	movq	(%rdx), %r8
	movq	8(%rdx), %r9
	leaq	(%r8,%rax), %r10
	movq	48(%rdx), %rcx
	movq	56(%rdx), %rdx
	movq	16(%r14), %r11
	movq	64(%r14), %rsi
	movq	24(%r14), %rbx
	movq	72(%r14), %rdi
	movq	32(%r14), %r15
	movq	%r10, 1648(%rsp)
	leaq	(%r9,%rcx), %r10
	movq	%r10, 1656(%rsp)
	leaq	(%r11,%rdx), %r10
	movq	%r10, 1664(%rsp)
	leaq	(%rbx,%rsi), %r10
	movq	%r10, 1672(%rsp)
	leaq	(%r15,%rdi), %r10
	movq	%r10, 1680(%rsp)
	movabsq	$4503599627370494, %r10         # imm = 0xFFFFFFFFFFFFE
	addq	%r10, %rax
	subq	%r8, %rax
	addq	%r10, %rcx
	subq	%r9, %rcx
	addq	%r10, %rdx
	subq	%r11, %rdx
	addq	%r10, %rsi
	subq	%rbx, %rsi
	addq	%r10, %rdi
	subq	%r15, %rdi
	addq	$-36, %rax
	movq	%rax, 1688(%rsp)
	movq	%rcx, 1696(%rsp)
	movq	%rdx, 1704(%rsp)
	movq	%rsi, 1712(%rsp)
	movq	%rdi, 1720(%rsp)
	movups	80(%r14), %xmm0
	movups	96(%r14), %xmm1
	movaps	%xmm0, 1728(%rsp)
	movaps	%xmm1, 1744(%rsp)
	movq	112(%r14), %rax
	movq	%rax, 1760(%rsp)
	leaq	1768(%rsp), %rdi
	leaq	120(%r14), %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	movq	32(%r14), %rax
	movq	%rax, 680(%rsp)
	movups	(%r14), %xmm0
	movups	16(%r14), %xmm1
	movups	%xmm1, 664(%rsp)
	movups	%xmm0, 648(%rsp)
	movups	40(%r14), %xmm0
	movups	56(%r14), %xmm1
	movaps	%xmm0, 688(%rsp)
	movaps	%xmm1, 704(%rsp)
	movq	72(%r14), %rax
	movq	%rax, 720(%rsp)
	movdqu	80(%r14), %xmm0
	movdqu	96(%r14), %xmm1
	movdqu	%xmm0, 728(%rsp)
	movdqu	%xmm1, 744(%rsp)
	movq	%r14, 32(%rsp)                  # 8-byte Spill
	movq	112(%r14), %rax
	movq	%rax, 760(%rsp)
	leaq	328(%rsp), %r14
	leaq	248(%rsp), %r12
	movl	$120, %eax
	leaq	1808(%rsp), %rbx
	xorl	%ecx, %ecx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	leaq	208(%rsp), %rbp
	leaq	48(%rsp), %r13
	xorl	%r15d, %r15d
	jmp	.LBB116_1
	.p2align	4, 0x90
.LBB116_5:                              #   in Loop: Header=BB116_1 Depth=1
	addq	$240, (%rsp)                    # 8-byte Folded Spill
	addq	$320, %rbx                      # imm = 0x140
	movq	8(%rsp), %rax                   # 8-byte Reload
	addq	$120, %rax
	cmpq	$14, %r15
	leaq	208(%rsp), %rbp
	leaq	48(%rsp), %r13
	jae	.LBB116_6
.LBB116_1:                              # =>This Inner Loop Header: Depth=1
	addq	$2, %r15
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	leaq	(%rsp,%rax), %rsi
	addq	$528, %rsi                      # imm = 0x210
	movq	%rbp, %rdi
	callq	ge_p2_dbl
	movq	%r13, %rdi
	movq	%rbp, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	88(%rsp), %rdi
	movq	%r12, %rsi
	leaq	288(%rsp), %r13
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	128(%rsp), %rdi
	movq	%r13, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	168(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%r12, %rdx
	callq	fe_mul_impl
	movq	88(%rsp), %rax
	movq	48(%rsp), %rdi
	movq	56(%rsp), %r8
	leaq	(%rdi,%rax), %r9
	movq	96(%rsp), %rcx
	leaq	(%r8,%rcx), %r10
	movq	104(%rsp), %rdx
	movq	64(%rsp), %r11
	leaq	(%r11,%rdx), %r12
	movq	112(%rsp), %rsi
	movq	72(%rsp), %r14
	movq	%r9, (%rbx)
	leaq	(%r14,%rsi), %r9
	movq	%r10, 8(%rbx)
	movq	120(%rsp), %r10
	movq	%r12, 16(%rbx)
	movq	80(%rsp), %r12
	movq	%r9, 24(%rbx)
	leaq	(%r12,%r10), %r9
	movq	%r9, 32(%rbx)
	movabsq	$4503599627370494, %r9          # imm = 0xFFFFFFFFFFFFE
	leaq	128(%rsp), %r13
	addq	%r9, %rax
	subq	%rdi, %rax
	addq	%r9, %rcx
	subq	%r8, %rcx
	addq	%r9, %rdx
	subq	%r11, %rdx
	addq	%r9, %rsi
	subq	%r14, %rsi
	leaq	328(%rsp), %r14
	addq	%r9, %r10
	subq	%r12, %r10
	leaq	248(%rsp), %r12
	addq	$-36, %rax
	movq	%rax, 40(%rbx)
	movq	%rcx, 48(%rbx)
	movq	%rdx, 56(%rbx)
	movq	%rsi, 64(%rbx)
	movq	%r10, 72(%rbx)
	movups	(%r13), %xmm0
	movups	16(%r13), %xmm1
	movups	%xmm0, 80(%rbx)
	movups	%xmm1, 96(%rbx)
	movq	32(%r13), %rax
	movq	%rax, 112(%rbx)
	leaq	120(%rbx), %rdi
	leaq	168(%rsp), %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	movq	%r15, 16(%rsp)                  # 8-byte Spill
	cmpq	$7, %r15
	leaq	288(%rsp), %r15
	ja	.LBB116_3
# %bb.2:                                #   in Loop: Header=BB116_1 Depth=1
	movq	(%rsp), %r13                    # 8-byte Reload
	leaq	(%rsp,%r13), %rdi
	addq	$768, %rdi                      # imm = 0x300
	movq	%rbp, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	(%rsp,%r13), %rdi
	addq	$808, %rdi                      # imm = 0x328
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	leaq	(%rsp,%r13), %rdi
	addq	$848, %rdi                      # imm = 0x350
	leaq	128(%rsp), %r13
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
.LBB116_3:                              #   in Loop: Header=BB116_1 Depth=1
	movq	%rbp, %rdi
	movq	32(%rsp), %rsi                  # 8-byte Reload
	movq	%rbx, %rdx
	callq	x25519_ge_add
	leaq	48(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	88(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	movq	%r13, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	168(%rsp), %r15
	movq	%r15, %rdi
	movq	%rbp, %rsi
	movq	%r12, %rdx
	callq	fe_mul_impl
	movq	88(%rsp), %rax
	movq	48(%rsp), %rdi
	movq	56(%rsp), %r8
	leaq	(%rdi,%rax), %r9
	movq	96(%rsp), %rcx
	leaq	(%r8,%rcx), %r10
	movq	104(%rsp), %rdx
	movq	64(%rsp), %r11
	leaq	(%r11,%rdx), %r14
	movq	112(%rsp), %rsi
	movq	72(%rsp), %r12
	movq	%r9, 160(%rbx)
	leaq	(%r12,%rsi), %r9
	movq	%r10, 168(%rbx)
	movq	120(%rsp), %r10
	movq	%r14, 176(%rbx)
	movq	80(%rsp), %r14
	movq	%r9, 184(%rbx)
	leaq	(%r14,%r10), %r9
	movq	%r9, 192(%rbx)
	movabsq	$4503599627370494, %r9          # imm = 0xFFFFFFFFFFFFE
	addq	%r9, %rax
	subq	%rdi, %rax
	addq	%r9, %rcx
	subq	%r8, %rcx
	addq	%r9, %rdx
	subq	%r11, %rdx
	addq	%r9, %rsi
	subq	%r12, %rsi
	leaq	248(%rsp), %r12
	addq	%r9, %r10
	subq	%r14, %r10
	leaq	328(%rsp), %r14
	addq	$-36, %rax
	movq	%rax, 200(%rbx)
	movq	%rcx, 208(%rbx)
	movq	%rdx, 216(%rbx)
	movq	%rsi, 224(%rbx)
	movq	%r10, 232(%rbx)
	movdqu	(%r13), %xmm0
	movdqu	16(%r13), %xmm1
	movdqu	%xmm0, 240(%rbx)
	movdqu	%xmm1, 256(%rbx)
	movq	32(%r13), %rax
	movq	%rax, 272(%rbx)
	leaq	280(%rbx), %rdi
	movq	%r15, %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	movq	16(%rsp), %r15                  # 8-byte Reload
	cmpq	$6, %r15
	ja	.LBB116_5
# %bb.4:                                #   in Loop: Header=BB116_1 Depth=1
	movq	(%rsp), %rbp                    # 8-byte Reload
	leaq	(%rsp,%rbp), %rdi
	addq	$888, %rdi                      # imm = 0x378
	leaq	208(%rsp), %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	(%rsp,%rbp), %rdi
	addq	$928, %rdi                      # imm = 0x3A0
	movq	%r12, %rsi
	leaq	288(%rsp), %r13
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	(%rsp,%rbp), %rdi
	addq	$968, %rdi                      # imm = 0x3C8
	movq	%r13, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	jmp	.LBB116_5
.LBB116_6:
	pxor	%xmm0, %xmm0
	movq	24(%rsp), %rax                  # 8-byte Reload
	movdqu	%xmm0, 16(%rax)
	movdqu	%xmm0, (%rax)
	movq	$0, 32(%rax)
	leaq	40(%rax), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movdqu	%xmm0, 48(%rax)
	movdqu	%xmm0, 64(%rax)
	movq	$1, 40(%rax)
	leaq	80(%rax), %rbp
	movdqu	%xmm0, 88(%rax)
	movdqu	%xmm0, 104(%rax)
	movq	%rax, %r13
	movq	$1, 80(%rax)
	xorl	%eax, %eax
	leaq	208(%rsp), %r12
	leaq	288(%rsp), %rbx
	movq	%rbp, 16(%rsp)                  # 8-byte Spill
	.p2align	4, 0x90
.LBB116_7:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB116_8 Depth 2
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	%r12, %rdi
	movq	%r13, %rsi
	callq	ge_p2_dbl
	movq	%r13, %rdi
	movq	%r12, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	8(%rsp), %r15                   # 8-byte Reload
	movq	%r15, %rdi
	leaq	248(%rsp), %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	%rbp, %rdi
	movq	%rbx, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	%r12, %rdi
	movq	24(%rsp), %r13                  # 8-byte Reload
	movq	%r13, %rsi
	callq	ge_p2_dbl
	movq	%r13, %rdi
	movq	%r12, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	%r15, %rdi
	leaq	248(%rsp), %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	%rbp, %rdi
	movq	%rbx, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	%r12, %rdi
	movq	%r13, %rsi
	callq	ge_p2_dbl
	movq	%r13, %rdi
	movq	%r12, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	%r15, %rdi
	leaq	248(%rsp), %r15
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	%rbp, %rdi
	movq	%rbx, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	%r12, %rdi
	movq	%r13, %rsi
	callq	ge_p2_dbl
	leaq	48(%rsp), %rbp
	movq	%rbp, %rdi
	movq	%r12, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	88(%rsp), %rdi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	128(%rsp), %rdi
	movq	%rbx, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	168(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	movq	(%rsp), %rdx                    # 8-byte Reload
	movl	%edx, %eax
	shrl	$3, %eax
	movq	40(%rsp), %rcx                  # 8-byte Reload
	subq	%rax, %rcx
	movzbl	31(%rcx), %eax
	movl	%edx, %ecx
	notb	%cl
	andb	$4, %cl
	shrl	%cl, %eax
	andl	$15, %eax
	leaq	1632(%rsp), %rcx
	xorl	%edx, %edx
	movdqa	.LCPI116_1(%rip), %xmm5         # xmm5 = [1,0]
	movdqa	%xmm5, %xmm0
	pxor	%xmm1, %xmm1
	movdqa	.LCPI116_0(%rip), %xmm2         # xmm2 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
	pxor	%xmm3, %xmm3
	pxor	%xmm4, %xmm4
	pxor	%xmm6, %xmm6
	pxor	%xmm7, %xmm7
	pxor	%xmm8, %xmm8
	pxor	%xmm9, %xmm9
	movq	%r12, %rbx
	.p2align	4, 0x90
.LBB116_8:                              #   Parent Loop BB116_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	%eax, %edi
	xorl	%edx, %edi
	decq	%rdi
	movq	%rdi, %xmm10
	pshufd	$68, %xmm10, %xmm10             # xmm10 = xmm10[0,1,0,1]
	psrad	$31, %xmm10
	pshufd	$245, %xmm10, %xmm10            # xmm10 = xmm10[1,1,3,3]
	movdqa	%xmm10, %xmm11
	pandn	%xmm0, %xmm11
	movdqa	-144(%rcx), %xmm0
	pand	%xmm10, %xmm0
	por	%xmm11, %xmm0
	movdqa	%xmm10, %xmm11
	pandn	%xmm1, %xmm11
	movdqa	-128(%rcx), %xmm1
	pand	%xmm10, %xmm1
	por	%xmm11, %xmm1
	movdqa	%xmm10, %xmm11
	pandn	%xmm2, %xmm11
	movdqa	-112(%rcx), %xmm2
	pand	%xmm10, %xmm2
	por	%xmm11, %xmm2
	movdqa	%xmm10, %xmm11
	pandn	%xmm3, %xmm11
	movdqa	-96(%rcx), %xmm3
	pand	%xmm10, %xmm3
	por	%xmm11, %xmm3
	movdqa	%xmm10, %xmm11
	pandn	%xmm4, %xmm11
	movdqa	-80(%rcx), %xmm4
	pand	%xmm10, %xmm4
	por	%xmm11, %xmm4
	movdqa	%xmm10, %xmm11
	pandn	%xmm5, %xmm11
	movdqa	-64(%rcx), %xmm5
	pand	%xmm10, %xmm5
	por	%xmm11, %xmm5
	movdqa	%xmm10, %xmm11
	pandn	%xmm6, %xmm11
	movdqa	-48(%rcx), %xmm6
	pand	%xmm10, %xmm6
	por	%xmm11, %xmm6
	movdqa	%xmm10, %xmm11
	pandn	%xmm7, %xmm11
	movdqa	-32(%rcx), %xmm7
	pand	%xmm10, %xmm7
	por	%xmm11, %xmm7
	movdqa	%xmm10, %xmm11
	pandn	%xmm8, %xmm11
	movdqa	-16(%rcx), %xmm8
	pand	%xmm10, %xmm8
	por	%xmm11, %xmm8
	movdqa	%xmm10, %xmm11
	pandn	%xmm9, %xmm11
	pand	(%rcx), %xmm10
	movdqa	%xmm10, %xmm9
	por	%xmm11, %xmm9
	incq	%rdx
	addq	$160, %rcx
	cmpq	$16, %rdx
	jne	.LBB116_8
# %bb.9:                                #   in Loop: Header=BB116_7 Depth=1
	movdqa	%xmm0, 368(%rsp)
	movdqa	%xmm1, 384(%rsp)
	movdqa	%xmm2, 400(%rsp)
	movdqa	%xmm3, 416(%rsp)
	movdqa	%xmm4, 432(%rsp)
	movdqa	%xmm5, 448(%rsp)
	movdqa	%xmm6, 464(%rsp)
	movdqa	%xmm7, 480(%rsp)
	movdqa	%xmm8, 496(%rsp)
	movdqa	%xmm9, 512(%rsp)
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	leaq	368(%rsp), %rdx
	callq	x25519_ge_add
	movq	%r13, %rdi
	movq	%rbx, %rsi
	leaq	328(%rsp), %r14
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	8(%rsp), %rdi                   # 8-byte Reload
	leaq	248(%rsp), %rsi
	movq	%rbx, %r12
	leaq	288(%rsp), %rbx
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	16(%rsp), %rbp                  # 8-byte Reload
	movq	%rbp, %rdi
	movq	%rbx, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	(%rsp), %rcx                    # 8-byte Reload
	leal	4(%rcx), %eax
	cmpl	$252, %ecx
                                        # kill: def $eax killed $eax def $rax
	jb	.LBB116_7
# %bb.10:
	addq	$4056, %rsp                     # imm = 0xFD8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end116:
	.size	x25519_ge_scalarmult, .Lfunc_end116-x25519_ge_scalarmult
                                        # -- End function
	.globl	x25519_sc_reduce                # -- Begin function x25519_sc_reduce
	.p2align	4, 0x90
	.type	x25519_sc_reduce,@function
x25519_sc_reduce:                       # @x25519_sc_reduce
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, %r13
	movzwl	(%rdi), %eax
	movzbl	2(%rdi), %ecx
	andl	$31, %ecx
	shlq	$16, %rcx
	orq	%rax, %rcx
	movq	%rcx, -88(%rsp)                 # 8-byte Spill
	movzwl	5(%rdi), %eax
	movzbl	7(%rdi), %ecx
	shll	$16, %ecx
	orl	%eax, %ecx
	movq	%rcx, -96(%rsp)                 # 8-byte Spill
	movzwl	13(%rdi), %eax
	movzbl	15(%rdi), %ecx
	shll	$16, %ecx
	orl	%eax, %ecx
	movq	%rcx, -72(%rsp)                 # 8-byte Spill
	movzwl	18(%rdi), %eax
	movzbl	20(%rdi), %r8d
	shlq	$16, %r8
	orq	%rax, %r8
	movzwl	21(%rdi), %eax
	movzbl	23(%rdi), %r9d
	andl	$31, %r9d
	shlq	$16, %r9
	orq	%rax, %r9
	movzwl	26(%rdi), %eax
	movzbl	28(%rdi), %r10d
	shll	$16, %r10d
	orl	%eax, %r10d
	movzwl	34(%rdi), %ecx
	movzbl	36(%rdi), %eax
	shll	$16, %eax
	orl	%ecx, %eax
	shrl	%eax
	andl	$2097151, %eax                  # imm = 0x1FFFFF
	movl	36(%rdi), %ecx
	shrl	$6, %ecx
	andl	$2097151, %ecx                  # imm = 0x1FFFFF
	movzwl	39(%rdi), %edx
	movzbl	41(%rdi), %r11d
	shlq	$16, %r11
	orq	%rdx, %r11
	shrq	$3, %r11
	movzwl	42(%rdi), %edx
	movzbl	44(%rdi), %esi
	andl	$31, %esi
	shlq	$16, %rsi
	orq	%rdx, %rsi
	movq	%rsi, -16(%rsp)                 # 8-byte Spill
	movzwl	47(%rdi), %edx
	movzbl	49(%rdi), %r14d
	shll	$16, %r14d
	orl	%edx, %r14d
	movzwl	55(%rdi), %edx
	movzbl	57(%rdi), %ebx
	shll	$16, %ebx
	orl	%edx, %ebx
	movl	60(%rdi), %r12d
	shrq	$3, %r12
	imulq	$654183, %r12, %rsi             # imm = 0x9FB67
	addq	%rax, %rsi
	imulq	$-997805, %r12, %rdx            # imm = 0xFFF0C653
	addq	%rcx, %rdx
	imulq	$136657, %r12, %rdi             # imm = 0x215D1
	addq	%r11, %rdi
	movl	57(%r13), %ecx
	shrl	$6, %ecx
	andl	$2097151, %ecx                  # imm = 0x1FFFFF
	imulq	$666643, %r12, %rax             # imm = 0xA2C13
	movq	%r12, -24(%rsp)                 # 8-byte Spill
	imulq	$470296, %rcx, %r11             # imm = 0x72D18
	addq	%rax, %r11
	imulq	$136657, %rcx, %rax             # imm = 0x215D1
	addq	%rdx, %rax
	movq	%rax, -104(%rsp)                # 8-byte Spill
	imulq	$-683901, %rcx, %rax            # imm = 0xFFF59083
	addq	%rdi, %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	shrl	%ebx
	andl	$2097151, %ebx                  # imm = 0x1FFFFF
	imulq	$654183, %rbx, %rax             # imm = 0x9FB67
	addq	%r11, %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movl	52(%r13), %edx
	shrl	$4, %edx
	andl	$2097151, %edx                  # imm = 0x1FFFFF
	imulq	$470296, %r12, %r11             # imm = 0x72D18
	imulq	$136657, %rdx, %rdi             # imm = 0x215D1
	addq	%r11, %rdi
	imulq	$-683901, %rdx, %r12            # imm = 0xFFF59083
	addq	%rsi, %r12
	imulq	$-997805, %rcx, %rsi            # imm = 0xFFF0C653
	addq	%rsi, %r12
	shrq	$3, %r8
	movl	49(%r13), %eax
	shrl	$7, %eax
	andl	$2097151, %eax                  # imm = 0x1FFFFF
	imulq	$666643, %rax, %r11             # imm = 0xA2C13
	addq	%r8, %r11
	imulq	$470296, %rax, %rbp             # imm = 0x72D18
	addq	%r9, %rbp
	movl	23(%r13), %r8d
	shrl	$5, %r8d
	andl	$2097151, %r8d                  # imm = 0x1FFFFF
	imulq	$654183, %rax, %rsi             # imm = 0x9FB67
	addq	%r8, %rsi
	imulq	$470296, %rdx, %r8              # imm = 0x72D18
	addq	%r8, %rsi
	shrl	$2, %r10d
	andl	$2097151, %r10d                 # imm = 0x1FFFFF
	imulq	$-997805, %rax, %r8             # imm = 0xFFF0C653
	addq	%r10, %r8
	imulq	$654183, %rdx, %r9              # imm = 0x9FB67
	addq	%r9, %r8
	movl	28(%r13), %r9d
	shrl	$7, %r9d
	andl	$2097151, %r9d                  # imm = 0x1FFFFF
	imulq	$136657, %rax, %r15             # imm = 0x215D1
	addq	%r9, %r15
	imulq	$-997805, %rdx, %r9             # imm = 0xFFF0C653
	addq	%r9, %r15
	movl	31(%r13), %r9d
	shrl	$4, %r9d
	andl	$2097151, %r9d                  # imm = 0x1FFFFF
	imulq	$-683901, %rax, %r10            # imm = 0xFFF59083
	addq	%r9, %r10
	addq	%rdi, %r10
	imulq	$654183, %rcx, %rax             # imm = 0x9FB67
	addq	%rax, %r10
	shrl	$2, %r14d
	andl	$2097151, %r14d                 # imm = 0x1FFFFF
	imulq	$470296, %r14, %rax             # imm = 0x72D18
	addq	%r11, %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	imulq	$666643, %rdx, %rax             # imm = 0xA2C13
	addq	%rax, %rbp
	imulq	$-997805, %r14, %rdi            # imm = 0xFFF0C653
	addq	%rsi, %rdi
	imulq	$136657, %r14, %rax             # imm = 0x215D1
	addq	%r8, %rax
	imulq	$666643, %rcx, %rcx             # imm = 0xA2C13
	addq	%rcx, %rax
	imulq	$-683901, %r14, %r9             # imm = 0xFFF59083
	addq	%r15, %r9
	movl	15(%r13), %ecx
	movq	%r13, -8(%rsp)                  # 8-byte Spill
	shrl	$6, %ecx
	andl	$2097151, %ecx                  # imm = 0x1FFFFF
	imulq	$666643, %r14, %rdx             # imm = 0xA2C13
	leaq	(%rdx,%rcx), %r8
	addq	%rdx, %rcx
	addq	$1048576, %rcx                  # imm = 0x100000
	movq	%rcx, %rsi
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %r8
	movq	%r8, -40(%rsp)                  # 8-byte Spill
	imulq	$654183, %r14, %rcx             # imm = 0x9FB67
	leaq	(%rcx,%rbp), %rdx
	leaq	(%rcx,%rbp), %r14
	addq	$1048576, %r14                  # imm = 0x100000
	imulq	$666643, %rbx, %rcx             # imm = 0xA2C13
	addq	%rcx, %rdi
	movabsq	$17592183947264, %rcx           # imm = 0xFFFFFE00000
	andq	%r14, %rcx
	subq	%rcx, %rdx
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	imulq	$470296, %rbx, %rcx             # imm = 0x72D18
	leaq	(%rax,%rcx), %rdx
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	leaq	(%rcx,%rax), %rbp
	addq	$1048576, %rbp                  # imm = 0x100000
	addq	-48(%rsp), %r9                  # 8-byte Folded Reload
	imulq	$-997805, %rbx, %rax            # imm = 0xFFF0C653
	leaq	(%r10,%rax), %r15
	addq	%r10, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	imulq	$136657, %rbx, %rcx             # imm = 0x215D1
	addq	%rcx, %r12
	movq	%rax, %rcx
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %r15
	imulq	$-683901, %rbx, %rax            # imm = 0xFFF59083
	movq	-104(%rsp), %rdx                # 8-byte Reload
	leaq	(%rdx,%rax), %r8
	addq	%rdx, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, %rdx
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %r8
	imulq	$-683901, -24(%rsp), %rax       # 8-byte Folded Reload
                                        # imm = 0xFFF59083
	movq	-16(%rsp), %r10                 # 8-byte Reload
	leaq	(%rax,%r10), %r11
	addq	%rax, %r10
	addq	$1048576, %r10                  # imm = 0x100000
	movl	44(%r13), %ebx
	shrl	$5, %ebx
	andl	$2097151, %ebx                  # imm = 0x1FFFFF
	movq	%r10, %rax
	sarq	$21, %rax
	addq	%rbx, %rax
	andq	$-2097152, %r10                 # imm = 0xFFE00000
	subq	%r10, %r11
	shrq	$21, %rsi
	movq	-64(%rsp), %r10                 # 8-byte Reload
	leaq	(%r10,%rsi), %rbx
	addq	%r10, %rsi
	addq	$1048576, %rsi                  # imm = 0x100000
	movq	%rsi, %r13
	andq	$-2097152, %rsi                 # imm = 0xFFE00000
	subq	%rsi, %rbx
	shrq	$21, %r14
	leaq	(%rdi,%r14), %rsi
	movq	%rsi, -104(%rsp)                # 8-byte Spill
	addq	%r14, %rdi
	addq	$1048576, %rdi                  # imm = 0x100000
	movq	%rbp, %r10
	sarq	$21, %r10
	leaq	(%r9,%r10), %rsi
	addq	%r10, %r9
	addq	$1048576, %r9                   # imm = 0x100000
	movq	%r9, %r10
	sarq	$21, %r10
	addq	%r15, %r10
	andq	$-2097152, %r9                  # imm = 0xFFE00000
	subq	%r9, %rsi
	movq	%rsi, -16(%rsp)                 # 8-byte Spill
	sarq	$21, %rcx
	leaq	(%r12,%rcx), %r15
	addq	%r12, %rcx
	addq	$1048576, %rcx                  # imm = 0x100000
	movq	%rcx, %r12
	sarq	$21, %r12
	addq	%r8, %r12
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %r15
	sarq	$21, %rdx
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rdx), %r14
	addq	%rdx, %rcx
	addq	$1048576, %rcx                  # imm = 0x100000
	movq	%rcx, %r9
	sarq	$21, %r9
	addq	%r11, %r9
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %r14
	movq	-72(%rsp), %rcx                 # 8-byte Reload
	shrl	%ecx
	andl	$2097151, %ecx                  # imm = 0x1FFFFF
	imulq	$666643, %rax, %rsi             # imm = 0xA2C13
	addq	%rcx, %rsi
	imulq	$470296, %rax, %rdx             # imm = 0x72D18
	addq	-40(%rsp), %rdx                 # 8-byte Folded Reload
	imulq	$654183, %rax, %r8              # imm = 0x9FB67
	addq	%rbx, %r8
	imulq	$-997805, %rax, %rcx            # imm = 0xFFF0C653
	addq	-56(%rsp), %rcx                 # 8-byte Folded Reload
	shrq	$21, %r13
	addq	%r13, %rcx
	imulq	$136657, %rax, %r11             # imm = 0x215D1
	addq	-104(%rsp), %r11                # 8-byte Folded Reload
	movq	%rdi, -72(%rsp)                 # 8-byte Spill
	andq	$-2097152, %rdi                 # imm = 0xFFE00000
	subq	%rdi, %r11
	movq	%r11, -104(%rsp)                # 8-byte Spill
	imulq	$-683901, %rax, %rax            # imm = 0xFFF59083
	addq	-32(%rsp), %rax                 # 8-byte Folded Reload
	andq	$-2097152, %rbp                 # imm = 0xFFE00000
	subq	%rbp, %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	-8(%rsp), %rbx                  # 8-byte Reload
	movl	10(%rbx), %eax
	shrl	$4, %eax
	andl	$2097151, %eax                  # imm = 0x1FFFFF
	imulq	$666643, %r9, %rdi              # imm = 0xA2C13
	addq	%rax, %rdi
	imulq	$470296, %r9, %rax              # imm = 0x72D18
	addq	%rsi, %rax
	imulq	$654183, %r9, %rsi              # imm = 0x9FB67
	addq	%rdx, %rsi
	imulq	$-997805, %r9, %rdx             # imm = 0xFFF0C653
	addq	%r8, %rdx
	imulq	$136657, %r9, %rbp              # imm = 0x215D1
	addq	%rcx, %rbp
	movl	7(%rbx), %ecx
	shrl	$7, %ecx
	andl	$2097151, %ecx                  # imm = 0x1FFFFF
	imulq	$666643, %r14, %r13             # imm = 0xA2C13
	addq	%rcx, %r13
	imulq	$470296, %r14, %r8              # imm = 0x72D18
	addq	%rdi, %r8
	imulq	$654183, %r14, %r11             # imm = 0x9FB67
	addq	%rax, %r11
	imulq	$-997805, %r14, %rax            # imm = 0xFFF0C653
	addq	%rsi, %rax
	imulq	$136657, %r14, %rsi             # imm = 0x215D1
	addq	%rdx, %rsi
	movq	-96(%rsp), %rcx                 # 8-byte Reload
	shrl	$2, %ecx
	andl	$2097151, %ecx                  # imm = 0x1FFFFF
	movq	%rcx, %rdx
	imulq	$666643, %r12, %rcx             # imm = 0xA2C13
	addq	%rdx, %rcx
	imulq	$470296, %r12, %rdx             # imm = 0x72D18
	addq	%r13, %rdx
	imulq	$136657, %r12, %rdi             # imm = 0x215D1
	addq	%rax, %rdi
	imulq	$-683901, %r12, %rax            # imm = 0xFFF59083
	addq	%rsi, %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movl	2(%rbx), %eax
	shrl	$5, %eax
	andl	$2097151, %eax                  # imm = 0x1FFFFF
	imulq	$666643, %r15, %rsi             # imm = 0xA2C13
	addq	%rax, %rsi
	imulq	$470296, %r15, %r13             # imm = 0x72D18
	addq	%rcx, %r13
	imulq	$654183, %r15, %rcx             # imm = 0x9FB67
	addq	%rdx, %rcx
	imulq	$654183, %r12, %rdx             # imm = 0x9FB67
	imulq	$-997805, %r15, %rax            # imm = 0xFFF0C653
	addq	%rdx, %rax
	addq	%r8, %rax
	imulq	$-997805, %r12, %rdx            # imm = 0xFFF0C653
	imulq	$136657, %r15, %r8              # imm = 0x215D1
	addq	%rdx, %r8
	addq	%r11, %r8
	imulq	$470296, %r10, %r11             # imm = 0x72D18
	addq	%rsi, %r11
	imulq	$-997805, %r10, %rdx            # imm = 0xFFF0C653
	addq	%rcx, %rdx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	imulq	$-683901, %r10, %r12            # imm = 0xFFF59083
	addq	%r8, %r12
	movq	%r12, -24(%rsp)                 # 8-byte Spill
	imulq	$666643, %r10, %rcx             # imm = 0xA2C13
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	leaq	(%rcx,%rdx), %rsi
	addq	%rcx, %rdx
	addq	$1048576, %rdx                  # imm = 0x100000
	movq	%rdx, %rcx
	andq	$-2097152, %rdx                 # imm = 0xFFE00000
	subq	%rdx, %rsi
	movq	%rsi, -56(%rsp)                 # 8-byte Spill
	imulq	$654183, %r10, %rdx             # imm = 0x9FB67
	leaq	(%rdx,%r13), %rsi
	movq	%rsi, -48(%rsp)                 # 8-byte Spill
	addq	%rdx, %r13
	addq	$1048576, %r13                  # imm = 0x100000
	imulq	$136657, %r10, %rdx             # imm = 0x215D1
	leaq	(%rax,%rdx), %rsi
	movq	%rsi, -32(%rsp)                 # 8-byte Spill
	leaq	(%rdx,%rax), %r8
	addq	$1048576, %r8                   # imm = 0x100000
	imulq	$-683901, %r15, %rax            # imm = 0xFFF59083
	leaq	(%rdi,%rax), %r10
	addq	%rdi, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, %r15
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %r10
	imulq	$-683901, %r14, %rax            # imm = 0xFFF59083
	leaq	(%rax,%rbp), %rdx
	addq	%rbp, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	imulq	$-683901, %r9, %r9              # imm = 0xFFF59083
	addq	-104(%rsp), %r9                 # 8-byte Folded Reload
	movq	%rax, %r14
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %rdx
	movq	-72(%rsp), %rax                 # 8-byte Reload
	sarq	$21, %rax
	movq	-80(%rsp), %rsi                 # 8-byte Reload
	leaq	(%rsi,%rax), %rbp
	addq	%rsi, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, %rbx
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %rbp
	sarq	$21, %rcx
	leaq	(%r11,%rcx), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	leaq	(%rcx,%r11), %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%r8, %rcx
	sarq	$21, %rcx
	movq	%rcx, -88(%rsp)                 # 8-byte Spill
	leaq	(%rcx,%r12), %rsi
	addq	$1048576, %rsi                  # imm = 0x100000
	movq	%rsi, %rdi
	sarq	$21, %rdi
	addq	%r10, %rdi
	sarq	$21, %r15
	movq	-40(%rsp), %r10                 # 8-byte Reload
	leaq	(%r10,%r15), %rcx
	addq	%r15, %r10
	addq	$1048576, %r10                  # imm = 0x100000
	movq	%r10, %r11
	sarq	$21, %r11
	addq	%rdx, %r11
	andq	$-2097152, %r10                 # imm = 0xFFE00000
	subq	%r10, %rcx
	movq	%rcx, -104(%rsp)                # 8-byte Spill
	sarq	$21, %r14
	leaq	(%r9,%r14), %rcx
	leaq	(%r14,%r9), %rdx
	addq	$1048576, %rdx                  # imm = 0x100000
	movq	%rdx, %r10
	sarq	$21, %r10
	addq	%rbp, %r10
	andq	$-2097152, %rdx                 # imm = 0xFFE00000
	subq	%rdx, %rcx
	movq	%rcx, -80(%rsp)                 # 8-byte Spill
	sarq	$21, %rbx
	movq	-16(%rsp), %rdx                 # 8-byte Reload
	leaq	(%rbx,%rdx), %rcx
	addq	%rbx, %rdx
	addq	$1048576, %rdx                  # imm = 0x100000
	movq	%rdx, %rbx
	andq	$-2097152, %rdx                 # imm = 0xFFE00000
	subq	%rdx, %rcx
	movq	%rcx, -72(%rsp)                 # 8-byte Spill
	sarq	$21, %rbx
	imulq	$666643, %rbx, %r9              # imm = 0xA2C13
	addq	-56(%rsp), %r9                  # 8-byte Folded Reload
	imulq	$470296, %rbx, %r14             # imm = 0x72D18
	addq	-64(%rsp), %r14                 # 8-byte Folded Reload
	movq	%rax, %r15
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %r14
	imulq	$654183, %rbx, %rbp             # imm = 0x9FB67
	addq	-48(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%r13, %rdx
	andq	$-2097152, %r13                 # imm = 0xFFE00000
	subq	%r13, %rbp
	sarq	$21, %r15
	addq	%r15, %rbp
	imulq	$136657, %rbx, %rax             # imm = 0x215D1
	addq	-32(%rsp), %rax                 # 8-byte Folded Reload
	andq	$-2097152, %r8                  # imm = 0xFFE00000
	subq	%r8, %rax
	sarq	$21, %rdx
	movq	-96(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rdx,%rcx), %r15
	addq	$1048576, %r15                  # imm = 0x100000
	movq	%r15, %r8
	sarq	$21, %r8
	addq	%r8, %rax
	movq	%r9, %r8
	sarq	$21, %r8
	addq	%r14, %r8
	movq	%r8, %r12
	sarq	$21, %r12
	addq	%rbp, %r12
	imulq	$-997805, %rbx, %r13            # imm = 0xFFF0C653
	addq	%rcx, %r13
	addq	%rdx, %r13
	andq	$-2097152, %r15                 # imm = 0xFFE00000
	subq	%r15, %r13
	movq	%r12, %rdx
	sarq	$21, %rdx
	addq	%rdx, %r13
	movq	%r13, %r15
	sarq	$21, %r15
	addq	%rax, %r15
	imulq	$-683901, %rbx, %rdx            # imm = 0xFFF59083
	addq	-24(%rsp), %rdx                 # 8-byte Folded Reload
	andq	$-2097152, %rsi                 # imm = 0xFFE00000
	andl	$2097151, %r9d                  # imm = 0x1FFFFF
	andl	$2097151, %r8d                  # imm = 0x1FFFFF
	andl	$2097151, %r12d                 # imm = 0x1FFFFF
	andl	$2097151, %r13d                 # imm = 0x1FFFFF
	addq	-88(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%r15, %rax
	sarq	$21, %rax
	subq	%rsi, %rdx
	addq	%rax, %rdx
	andl	$2097151, %r15d                 # imm = 0x1FFFFF
	movq	%rdx, %rbx
	sarq	$21, %rbx
	addq	%rdi, %rbx
	movq	%rbx, -88(%rsp)                 # 8-byte Spill
	sarq	$21, %rbx
	addq	-104(%rsp), %rbx                # 8-byte Folded Reload
	movq	%rbx, -96(%rsp)                 # 8-byte Spill
	sarq	$21, %rbx
	addq	%r11, %rbx
	movq	%rbx, %rdi
	sarq	$21, %rdi
	addq	-80(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%rdi, %r14
	sarq	$21, %r14
	addq	%r10, %r14
	movq	%r14, %rbp
	sarq	$21, %rbp
	addq	-72(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%rbp, %r10
	sarq	$21, %r10
	imulq	$666643, %r10, %rax             # imm = 0xA2C13
	addq	%r9, %rax
	imulq	$470296, %r10, %r9              # imm = 0x72D18
	addq	%r8, %r9
	imulq	$654183, %r10, %r8              # imm = 0x9FB67
	addq	%r12, %r8
	imulq	$-997805, %r10, %r12            # imm = 0xFFF0C653
	addq	%r13, %r12
	imulq	$136657, %r10, %rsi             # imm = 0x215D1
	addq	%r15, %rsi
	andl	$2097151, %edx                  # imm = 0x1FFFFF
	movq	-88(%rsp), %rcx                 # 8-byte Reload
	andl	$2097151, %ecx                  # imm = 0x1FFFFF
	movq	%rcx, -88(%rsp)                 # 8-byte Spill
	movq	-96(%rsp), %rcx                 # 8-byte Reload
	andl	$2097151, %ecx                  # imm = 0x1FFFFF
	movq	%rcx, -96(%rsp)                 # 8-byte Spill
	andl	$2097151, %ebx                  # imm = 0x1FFFFF
	andl	$2097151, %edi                  # imm = 0x1FFFFF
	andl	$2097151, %r14d                 # imm = 0x1FFFFF
	andl	$2097151, %ebp                  # imm = 0x1FFFFF
	imulq	$-683901, %r10, %rcx            # imm = 0xFFF59083
	addq	%rdx, %rcx
	movq	%rax, %r13
	sarq	$21, %r13
	addq	%r9, %r13
	movq	%r13, %r15
	sarq	$21, %r15
	addq	%r8, %r15
	movq	%r15, %r11
	sarq	$21, %r11
	addq	%r12, %r11
	movq	%r11, %r10
	sarq	$21, %r10
	addq	%rsi, %r10
	movq	%r10, %r9
	sarq	$21, %r9
	addq	%rcx, %r9
	movq	%r9, %r8
	sarq	$21, %r8
	addq	-88(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r8, %r12
	sarq	$21, %r12
	addq	-96(%rsp), %r12                 # 8-byte Folded Reload
	movq	%r12, %rdx
	sarq	$21, %rdx
	addq	%rbx, %rdx
	movq	%rdx, %rbx
	sarq	$21, %rbx
	addq	%rdi, %rbx
	movq	%rbx, %rcx
	sarq	$21, %rcx
	addq	%r14, %rcx
	movq	%rcx, %rsi
	sarq	$21, %rsi
	addq	%rbp, %rsi
	movq	-8(%rsp), %rbp                  # 8-byte Reload
	movb	%al, (%rbp)
	movb	%ah, 1(%rbp)
	shrl	$16, %eax
	andl	$31, %eax
	movl	%r13d, %edi
	shll	$5, %edi
	orl	%eax, %edi
	movb	%dil, 2(%rbp)
	movq	%r13, %rax
	shrq	$3, %rax
	movb	%al, 3(%rbp)
	movq	%r13, %rax
	shrq	$11, %rax
	movb	%al, 4(%rbp)
	shrl	$19, %r13d
	andl	$3, %r13d
	leal	(%r13,%r15,4), %eax
	movb	%al, 5(%rbp)
	movq	%r15, %rax
	shrq	$6, %rax
	movb	%al, 6(%rbp)
	movl	%r11d, %eax
	shll	$7, %eax
	shrl	$14, %r15d
	andl	$127, %r15d
	orl	%eax, %r15d
	movb	%r15b, 7(%rbp)
	movq	%r11, %rax
	shrq	%rax
	movb	%al, 8(%rbp)
	movq	%r11, %rax
	shrq	$9, %rax
	movb	%al, 9(%rbp)
	movl	%r10d, %eax
	shll	$4, %eax
	shrl	$17, %r11d
	andl	$15, %r11d
	orl	%eax, %r11d
	movb	%r11b, 10(%rbp)
	movq	%r10, %rax
	shrq	$4, %rax
	movb	%al, 11(%rbp)
	movq	%r10, %rax
	shrq	$12, %rax
	movb	%al, 12(%rbp)
	shrl	$20, %r10d
	andl	$1, %r10d
	leal	(%r10,%r9,2), %eax
	movb	%al, 13(%rbp)
	movq	%r9, %rax
	shrq	$7, %rax
	movb	%al, 14(%rbp)
	movl	%r8d, %eax
	shll	$6, %eax
	shrl	$15, %r9d
	andl	$63, %r9d
	orl	%eax, %r9d
	movb	%r9b, 15(%rbp)
	movq	%r8, %rax
	shrq	$2, %rax
	movb	%al, 16(%rbp)
	movq	%r8, %rax
	shrq	$10, %rax
	movb	%al, 17(%rbp)
	shrl	$18, %r8d
	andl	$7, %r8d
	leal	(%r8,%r12,8), %eax
	movb	%al, 18(%rbp)
	movq	%r12, %rax
	shrq	$5, %rax
	movb	%al, 19(%rbp)
	shrq	$13, %r12
	movb	%r12b, 20(%rbp)
	movb	%dl, 21(%rbp)
	movb	%dh, 22(%rbp)
	shrl	$16, %edx
	andl	$31, %edx
	movl	%ebx, %eax
	shll	$5, %eax
	orl	%edx, %eax
	movb	%al, 23(%rbp)
	movq	%rbx, %rax
	shrq	$3, %rax
	movb	%al, 24(%rbp)
	movq	%rbx, %rax
	shrq	$11, %rax
	movb	%al, 25(%rbp)
	shrl	$19, %ebx
	andl	$3, %ebx
	leal	(%rbx,%rcx,4), %eax
	movb	%al, 26(%rbp)
	movq	%rcx, %rax
	shrq	$6, %rax
	movb	%al, 27(%rbp)
	movl	%esi, %eax
	shll	$7, %eax
	shrl	$14, %ecx
	andl	$127, %ecx
	orl	%eax, %ecx
	movb	%cl, 28(%rbp)
	movq	%rsi, %rax
	shrq	%rax
	movb	%al, 29(%rbp)
	movq	%rsi, %rax
	shrq	$9, %rax
	movb	%al, 30(%rbp)
	shrq	$17, %rsi
	movb	%sil, 31(%rbp)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end117:
	.size	x25519_sc_reduce, .Lfunc_end117-x25519_sc_reduce
                                        # -- End function
	.globl	ED25519_sign                    # -- Begin function ED25519_sign
	.p2align	4, 0x90
	.type	ED25519_sign,@function
ED25519_sign:                           # @ED25519_sign
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1048, %rsp                     # imm = 0x418
	movq	%rcx, %rbx
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, 568(%rsp)                 # 8-byte Spill
	movabsq	$-4942790177534073029, %rsi     # imm = 0xBB67AE8584CAA73B
	movabsq	$-6534734903238641935, %rdx     # imm = 0xA54FF53A5F1D36F1
	movabsq	$-7276294671716946913, %rax     # imm = 0x9B05688C2B3E6C1F
	movabsq	$7640891576956012808, %r13      # imm = 0x6A09E667F3BCC908
	movabsq	$6620516959819538809, %rcx      # imm = 0x5BE0CD19137E2179
	movabsq	$5840696475078001361, %rdi      # imm = 0x510E527FADE682D1
	movabsq	$4354685564936845355, %r14      # imm = 0x3C6EF372FE94F82B
	movabsq	$2270897969802886507, %rbp      # imm = 0x1F83D9ABFB41BD6B
	movq	%r13, 240(%rsp)
	movq	%rsi, 248(%rsp)
	movq	%r14, 256(%rsp)
	movq	%rdx, 264(%rsp)
	movq	%rdi, 272(%rsp)
	movq	%rax, 280(%rsp)
	movq	%rbp, 288(%rsp)
	movq	%rcx, 296(%rsp)
	movl	$64, 452(%rsp)
	leaq	320(%rsp), %rsi
	movq	$0, 312(%rsp)
	movq	$256, 304(%rsp)                 # imm = 0x100
	movups	(%rbx), %xmm0
	movups	16(%rbx), %xmm1
	movups	%xmm0, 320(%rsp)
	movups	%xmm1, 336(%rsp)
	movl	$32, 448(%rsp)
	movb	$-128, 352(%rsp)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 353(%rsp)
	movups	%xmm0, 369(%rsp)
	movups	%xmm0, 385(%rsp)
	movups	%xmm0, 401(%rsp)
	movups	%xmm0, 417(%rsp)
	movq	$0, 432(%rsp)
	movabsq	$281474976710656, %rax          # imm = 0x1000000000000
	movq	%rax, 440(%rsp)
	leaq	240(%rsp), %rdi
	movl	$1, %edx
	callq	sha512_block_data_order
	movq	240(%rsp), %rsi
	movq	248(%rsp), %rax
	bswapq	%rsi
	movq	%rsi, 192(%rsp)
	bswapq	%rax
	movq	%rax, 200(%rsp)
	movq	256(%rsp), %rax
	bswapq	%rax
	movq	%rax, 208(%rsp)
	movq	264(%rsp), %rdx
	bswapq	%rdx
	movq	%rdx, 216(%rsp)
	movq	272(%rsp), %rax
	bswapq	%rax
	movq	280(%rsp), %rcx
	movq	%rsi, 32(%rsp)                  # 8-byte Spill
                                        # kill: def $sil killed $sil killed $rsi
	andb	$-8, %sil
	movb	%sil, 192(%rsp)
	movq	288(%rsp), %rsi
	shrq	$56, %rdx
	andb	$63, %dl
	orb	$64, %dl
	movb	%dl, 223(%rsp)
	movq	296(%rsp), %rdx
	movq	%r13, 240(%rsp)
	movabsq	$-4942790177534073029, %rdi     # imm = 0xBB67AE8584CAA73B
	movq	%rdi, 248(%rsp)
	movq	%r14, 256(%rsp)
	movabsq	$-6534734903238641935, %rdi     # imm = 0xA54FF53A5F1D36F1
	movq	%rdi, 264(%rsp)
	movabsq	$5840696475078001361, %rdi      # imm = 0x510E527FADE682D1
	movq	%rdi, 272(%rsp)
	movabsq	$-7276294671716946913, %rdi     # imm = 0x9B05688C2B3E6C1F
	movq	%rdi, 280(%rsp)
	movq	%rbp, 288(%rsp)
	movabsq	$6620516959819538809, %rdi      # imm = 0x5BE0CD19137E2179
	movq	%rdi, 296(%rsp)
	movq	$0, 312(%rsp)
	movq	$256, 304(%rsp)                 # imm = 0x100
	movq	%rax, 320(%rsp)
	bswapq	%rcx
	bswapq	%rsi
	movq	%rcx, 328(%rsp)
	movq	%rsi, 336(%rsp)
	bswapq	%rdx
	movq	%rdx, 344(%rsp)
	movabsq	$274877906976, %rax             # imm = 0x4000000020
	movq	%rax, 448(%rsp)
	testq	%r15, %r15
	je	.LBB118_1
# %bb.2:
	leaq	(,%r15,8), %rax
	leaq	256(,%r15,8), %rcx
	movq	%r15, %rdx
	shrq	$61, %rdx
	cmpq	$-256, %rax
	sbbq	$-1, %rdx
	movq	%rdx, 312(%rsp)
	movq	%rcx, 304(%rsp)
	leaq	352(%rsp), %rdi
	cmpq	$95, %r15
	ja	.LBB118_4
# %bb.3:
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
	movl	448(%rsp), %ebp
	addl	%r15d, %ebp
	movl	%ebp, 448(%rsp)
	leaq	320(%rsp), %r13
	jmp	.LBB118_9
.LBB118_1:
	movb	$-128, 352(%rsp)
	movl	$33, %edi
	movl	$64, %r14d
	leaq	320(%rsp), %r13
	jmp	.LBB118_14
.LBB118_4:
	movups	80(%r12), %xmm0
	movups	%xmm0, 80(%rdi)
	movups	64(%r12), %xmm0
	movups	%xmm0, 64(%rdi)
	movups	(%r12), %xmm0
	movups	16(%r12), %xmm1
	movups	32(%r12), %xmm2
	movups	48(%r12), %xmm3
	movups	%xmm3, 48(%rdi)
	movups	%xmm2, 32(%rdi)
	movups	%xmm1, 16(%rdi)
	movups	%xmm0, (%rdi)
	movl	$0, 448(%rsp)
	leaq	-96(%r15), %rbp
	leaq	96(%r12), %r14
	leaq	240(%rsp), %rdi
	movl	$1, %edx
	leaq	320(%rsp), %r13
	movq	%r13, %rsi
	callq	sha512_block_data_order
	cmpq	$128, %rbp
	jb	.LBB118_6
# %bb.5:
	movq	%rbp, %rdx
	shrq	$7, %rdx
	leaq	240(%rsp), %rdi
	movq	%r14, %rsi
	callq	sha512_block_data_order
	leaq	(%r12,%r15), %r14
	andl	$127, %ebp
	subq	%rbp, %r14
.LBB118_6:
	testq	%rbp, %rbp
	je	.LBB118_8
# %bb.7:
	movq	%r13, %rdi
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	memcpy@PLT
	movl	%ebp, 448(%rsp)
	jmp	.LBB118_9
.LBB118_8:
	movl	448(%rsp), %ebp
.LBB118_9:
	movl	452(%rsp), %r14d
	movl	%ebp, %eax
	movb	$-128, 320(%rsp,%rax)
	leaq	1(%rax), %rdi
	cmpl	$112, %ebp
	jb	.LBB118_13
# %bb.10:
	cmpl	$127, %eax
	je	.LBB118_12
# %bb.11:
	movl	$127, %edx
	subq	%rax, %rdx
	addq	%r13, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB118_12:
	leaq	240(%rsp), %rdi
	movl	$1, %edx
	movq	%r13, %rsi
	callq	sha512_block_data_order
	xorl	%edi, %edi
	jmp	.LBB118_14
.LBB118_13:
	cmpq	$112, %rdi
	je	.LBB118_15
.LBB118_14:
	movl	$112, %edx
	subq	%rdi, %rdx
	addq	%r13, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB118_15:
	movq	304(%rsp), %rax
	movq	312(%rsp), %rcx
	bswapq	%rcx
	movq	%rcx, 432(%rsp)
	bswapq	%rax
	movq	%rax, 440(%rsp)
	leaq	240(%rsp), %rdi
	movl	$1, %edx
	movq	%r13, %rsi
	callq	sha512_block_data_order
	cmpl	$8, %r14d
	jb	.LBB118_23
# %bb.16:
	shrl	$3, %r14d
	leaq	-1(%r14), %rcx
	movl	%r14d, %eax
	andl	$3, %eax
	cmpq	$3, %rcx
	jae	.LBB118_18
# %bb.17:
	leaq	576(%rsp), %rcx
	xorl	%edx, %edx
	jmp	.LBB118_20
.LBB118_18:
	andl	$-4, %r14d
	leaq	576(%rsp), %rcx
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB118_19:                             # =>This Inner Loop Header: Depth=1
	movq	240(%rsp,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, (%rcx)
	movq	248(%rsp,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, 8(%rcx)
	movq	256(%rsp,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, 16(%rcx)
	movq	264(%rsp,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, 24(%rcx)
	addq	$32, %rcx
	addq	$4, %rdx
	cmpq	%rdx, %r14
	jne	.LBB118_19
.LBB118_20:
	testq	%rax, %rax
	je	.LBB118_23
# %bb.21:                               # %.preheader2
	leaq	(%rsp,%rdx,8), %rdx
	addq	$240, %rdx
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB118_22:                             # =>This Inner Loop Header: Depth=1
	movq	(%rdx,%rsi,8), %rdi
	bswapq	%rdi
	movq	%rdi, (%rcx,%rsi,8)
	incq	%rsi
	cmpq	%rsi, %rax
	jne	.LBB118_22
.LBB118_23:
	leaq	576(%rsp), %r14
	movq	%r14, %rdi
	callq	x25519_sc_reduce
	leaq	808(%rsp), %r13
	movq	%r13, %rdi
	movq	%r14, %rsi
	callq	x25519_ge_scalarmult_base
	movq	920(%rsp), %rax
	movq	%rax, 528(%rsp)
	movups	888(%rsp), %xmm0
	movups	904(%rsp), %xmm1
	movaps	%xmm1, 512(%rsp)
	movaps	%xmm0, 496(%rsp)
	leaq	1008(%rsp), %r14
	leaq	496(%rsp), %rsi
	movq	%r14, %rdi
	callq	fe_loose_invert
	leaq	496(%rsp), %rbp
	movq	%rbp, %rdi
	movq	%r13, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	848(%rsp), %rsi
	leaq	968(%rsp), %r13
	movq	%r13, %rdi
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	568(%rsp), %r14                 # 8-byte Reload
	movq	%r14, %rdi
	movq	%r13, %rsi
	callq	fe_tobytes
	leaq	768(%rsp), %rdi
	movq	%rbp, %rsi
	callq	fe_tobytes
	movzbl	768(%rsp), %eax
	shlb	$7, %al
	xorb	%al, 31(%r14)
	movabsq	$7640891576956012808, %rax      # imm = 0x6A09E667F3BCC908
	movq	%rax, 240(%rsp)
	movabsq	$-4942790177534073029, %rax     # imm = 0xBB67AE8584CAA73B
	movq	%rax, 248(%rsp)
	movabsq	$4354685564936845355, %rax      # imm = 0x3C6EF372FE94F82B
	movq	%rax, 256(%rsp)
	movabsq	$-6534734903238641935, %rax     # imm = 0xA54FF53A5F1D36F1
	movq	%rax, 264(%rsp)
	movabsq	$5840696475078001361, %rax      # imm = 0x510E527FADE682D1
	movq	%rax, 272(%rsp)
	movabsq	$-7276294671716946913, %rax     # imm = 0x9B05688C2B3E6C1F
	movq	%rax, 280(%rsp)
	movabsq	$2270897969802886507, %rax      # imm = 0x1F83D9ABFB41BD6B
	movq	%rax, 288(%rsp)
	movabsq	$6620516959819538809, %rax      # imm = 0x5BE0CD19137E2179
	movq	%rax, 296(%rsp)
	movq	$0, 312(%rsp)
	movl	$64, 452(%rsp)
	movups	(%r14), %xmm0
	movups	16(%r14), %xmm1
	leaq	320(%rsp), %r14
	movups	%xmm1, 16(%r14)
	movups	%xmm0, (%r14)
	movq	$512, 304(%rsp)                 # imm = 0x200
	movups	32(%rbx), %xmm0
	movups	48(%rbx), %xmm1
	movups	%xmm0, 352(%rsp)
	movups	%xmm1, 368(%rsp)
	movl	$64, 448(%rsp)
	testq	%r15, %r15
	je	.LBB118_24
# %bb.25:
	leaq	(,%r15,8), %rax
	leaq	512(,%r15,8), %rcx
	movq	%r15, %rdx
	shrq	$61, %rdx
	cmpq	$-512, %rax                     # imm = 0xFE00
	sbbq	$-1, %rdx
	movq	%rdx, 312(%rsp)
	movq	%rcx, 304(%rsp)
	leaq	384(%rsp), %rdi
	cmpq	$63, %r15
	ja	.LBB118_27
# %bb.26:
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
	addl	448(%rsp), %r15d
	jmp	.LBB118_32
.LBB118_24:
	movl	452(%rsp), %ebx
	movb	$-128, 384(%rsp)
	movl	$65, %edi
	jmp	.LBB118_38
.LBB118_27:
	movups	(%r12), %xmm0
	movups	16(%r12), %xmm1
	movups	32(%r12), %xmm2
	movups	48(%r12), %xmm3
	movups	%xmm3, 48(%rdi)
	movups	%xmm2, 32(%rdi)
	movups	%xmm1, 16(%rdi)
	movups	%xmm0, (%rdi)
	movl	$0, 448(%rsp)
	movq	%r14, %rsi
	leaq	-64(%r15), %r13
	leaq	64(%r12), %r14
	leaq	240(%rsp), %rdi
	movl	$1, %edx
	callq	sha512_block_data_order
	cmpq	$128, %r13
	jb	.LBB118_29
# %bb.28:
	movq	%r13, %rdx
	shrq	$7, %rdx
	leaq	240(%rsp), %rdi
	movq	%r14, %rsi
	callq	sha512_block_data_order
	addq	%r15, %r12
	andl	$127, %r13d
	subq	%r13, %r12
	movq	%r12, %r14
.LBB118_29:
	testq	%r13, %r13
	je	.LBB118_30
# %bb.31:
	leaq	320(%rsp), %rbx
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%r13, %rdx
	callq	memcpy@PLT
	movl	%r13d, %r15d
	movq	%rbx, %r14
.LBB118_32:
	movl	%r15d, 448(%rsp)
	jmp	.LBB118_33
.LBB118_30:
	movl	448(%rsp), %r15d
	leaq	320(%rsp), %r14
.LBB118_33:
	movl	452(%rsp), %ebx
	movl	%r15d, %eax
	movb	$-128, 320(%rsp,%rax)
	leaq	1(%rax), %rdi
	cmpl	$112, %r15d
	jb	.LBB118_37
# %bb.34:
	cmpl	$127, %eax
	je	.LBB118_36
# %bb.35:
	movl	$127, %edx
	subq	%rax, %rdx
	addq	%r14, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB118_36:
	leaq	240(%rsp), %rdi
	movl	$1, %edx
	movq	%r14, %rsi
	callq	sha512_block_data_order
	xorl	%edi, %edi
	jmp	.LBB118_38
.LBB118_37:
	cmpq	$112, %rdi
	je	.LBB118_39
.LBB118_38:
	movl	$112, %edx
	subq	%rdi, %rdx
	addq	%r14, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB118_39:
	movq	304(%rsp), %rax
	movq	312(%rsp), %rcx
	bswapq	%rcx
	movq	%rcx, 432(%rsp)
	bswapq	%rax
	movq	%rax, 440(%rsp)
	leaq	240(%rsp), %rdi
	movl	$1, %edx
	movq	%r14, %rsi
	callq	sha512_block_data_order
	cmpl	$8, %ebx
	jb	.LBB118_47
# %bb.40:
	shrl	$3, %ebx
	leaq	-1(%rbx), %rcx
	movl	%ebx, %eax
	andl	$3, %eax
	cmpq	$3, %rcx
	jae	.LBB118_42
# %bb.41:
	xorl	%ecx, %ecx
	jmp	.LBB118_44
.LBB118_42:
	andl	$-4, %ebx
	leaq	496(%rsp), %rbp
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB118_43:                             # =>This Inner Loop Header: Depth=1
	movq	240(%rsp,%rcx,8), %rdx
	bswapq	%rdx
	movq	%rdx, (%rbp)
	movq	248(%rsp,%rcx,8), %rdx
	bswapq	%rdx
	movq	%rdx, 8(%rbp)
	movq	256(%rsp,%rcx,8), %rdx
	bswapq	%rdx
	movq	%rdx, 16(%rbp)
	movq	264(%rsp,%rcx,8), %rdx
	bswapq	%rdx
	movq	%rdx, 24(%rbp)
	addq	$32, %rbp
	addq	$4, %rcx
	cmpq	%rcx, %rbx
	jne	.LBB118_43
.LBB118_44:
	testq	%rax, %rax
	je	.LBB118_47
# %bb.45:                               # %.preheader
	leaq	(%rsp,%rcx,8), %rcx
	addq	$240, %rcx
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB118_46:                             # =>This Inner Loop Header: Depth=1
	movq	(%rcx,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, (%rbp,%rdx,8)
	incq	%rdx
	cmpq	%rdx, %rax
	jne	.LBB118_46
.LBB118_47:
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	%r14, %r15
	shrq	$42, %r15
	leaq	496(%rsp), %rdi
	callq	x25519_sc_reduce
	movzwl	496(%rsp), %ecx
	movzbl	498(%rsp), %eax
	andl	$31, %eax
	shlq	$16, %rax
	orq	%rcx, %rax
	movq	%rax, %r9
	movzwl	501(%rsp), %ecx
	movzbl	503(%rsp), %edi
	shll	$16, %edi
	orl	%ecx, %edi
	movzwl	509(%rsp), %ecx
	movzbl	511(%rsp), %eax
	shll	$16, %eax
	orl	%ecx, %eax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movzwl	514(%rsp), %ecx
	movzbl	516(%rsp), %eax
	shlq	$16, %rax
	orq	%rcx, %rax
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movzwl	517(%rsp), %ecx
	movzbl	519(%rsp), %eax
	andl	$31, %eax
	shlq	$16, %rax
	orq	%rcx, %rax
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movzwl	522(%rsp), %ecx
	movzbl	524(%rsp), %eax
	shll	$16, %eax
	orl	%ecx, %eax
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movzwl	192(%rsp), %ecx
	movl	%r14d, %eax
	andl	$2031616, %eax                  # imm = 0x1F0000
	orq	%rcx, %rax
	movq	%rax, %r8
	movzwl	205(%rsp), %ecx
	movzbl	207(%rsp), %r10d
	shll	$16, %r10d
	orl	%ecx, %r10d
	movzwl	210(%rsp), %ecx
	movzbl	212(%rsp), %edx
	shlq	$16, %rdx
	orq	%rcx, %rdx
	movq	%rdx, (%rsp)                    # 8-byte Spill
	movzwl	213(%rsp), %ecx
	movzbl	215(%rsp), %edx
	andl	$31, %edx
	shlq	$16, %rdx
	orq	%rcx, %rdx
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movzwl	218(%rsp), %ecx
	movzbl	220(%rsp), %edx
	shll	$16, %edx
	orl	%ecx, %edx
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	movzbl	578(%rsp), %edx
	andl	$31, %edx
	shlq	$16, %rdx
	movzwl	576(%rsp), %ecx
	orq	%rcx, %rdx
	movq	%rdx, 480(%rsp)                 # 8-byte Spill
	movzbl	583(%rsp), %edx
	shll	$16, %edx
	movzwl	581(%rsp), %ecx
	orl	%ecx, %edx
	movq	%rdx, 472(%rsp)                 # 8-byte Spill
	movzbl	591(%rsp), %edx
	shll	$16, %edx
	movzwl	589(%rsp), %ecx
	orl	%ecx, %edx
	movq	%rdx, 488(%rsp)                 # 8-byte Spill
	movzbl	596(%rsp), %eax
	shlq	$16, %rax
	movzwl	594(%rsp), %edx
	orq	%rdx, %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movzbl	604(%rsp), %esi
	shll	$16, %esi
	movzwl	602(%rsp), %edx
	orl	%edx, %esi
	movq	%rsi, 464(%rsp)                 # 8-byte Spill
	movl	498(%rsp), %ebx
	shrl	$5, %ebx
	andl	$2097151, %ebx                  # imm = 0x1FFFFF
	movl	578(%rsp), %edx
	shrl	$5, %edx
	andl	$2097151, %edx                  # imm = 0x1FFFFF
	movq	%r8, %rcx
	movq	%r8, %rsi
	imulq	%rbx, %rsi
	addq	%rdx, %rsi
	movq	%rsi, 456(%rsp)                 # 8-byte Spill
	shrq	$21, %r14
	andl	$2097151, %r14d                 # imm = 0x1FFFFF
	movq	%r15, %rsi
	andl	$2097151, %esi                  # imm = 0x1FFFFF
	movq	%rsi, %rdx
	movq	%rsi, %r8
	imulq	%r9, %rdx
	movq	%r14, %rsi
	imulq	%rbx, %rsi
	addq	%rdx, %rsi
	movq	%rdi, %rax
	shrl	$2, %eax
	andl	$2097151, %eax                  # imm = 0x1FFFFF
	movq	%rcx, %rdx
	movq	%rcx, %r15
	imulq	%rax, %rdx
	addq	%rsi, %rdx
	movq	%rdx, 760(%rsp)                 # 8-byte Spill
	movl	583(%rsp), %edx
	shrl	$7, %edx
	andl	$2097151, %edx                  # imm = 0x1FFFFF
	movq	%r8, %rsi
	movq	%r8, %r12
	movq	%r8, 40(%rsp)                   # 8-byte Spill
	imulq	%rbx, %rsi
	addq	%rdx, %rsi
	movq	%rsi, 752(%rsp)                 # 8-byte Spill
	movl	503(%rsp), %r11d
	shrl	$7, %r11d
	andl	$2097151, %r11d                 # imm = 0x1FFFFF
	movl	199(%rsp), %edx
	shrl	$7, %edx
	andl	$2097151, %edx                  # imm = 0x1FFFFF
	movq	%r9, %rsi
	imulq	%rdx, %rsi
	movq	%rdx, %rdi
	movq	%rcx, %rdx
	imulq	%r11, %rdx
	addq	%rsi, %rdx
	movq	%rax, %rsi
	imulq	%r14, %rsi
	addq	%rsi, %rdx
	movq	%rdx, 184(%rsp)                 # 8-byte Spill
	movl	506(%rsp), %ecx
	shrl	$4, %ecx
	andl	$2097151, %ecx                  # imm = 0x1FFFFF
	movq	%r14, %rsi
	movq	%r14, %r13
	movq	%r14, 32(%rsp)                  # 8-byte Spill
	imulq	%r11, %rsi
	movq	%r11, %rbp
	movq	%r15, %rdx
	imulq	%rcx, %rdx
	movq	%rcx, %r8
	addq	%rsi, %rdx
	movq	%rdi, %rsi
	movq	%rdi, %rcx
	movq	%rdi, 104(%rsp)                 # 8-byte Spill
	imulq	%rbx, %rsi
	addq	%rsi, %rdx
	movl	202(%rsp), %r14d
	shrl	$4, %r14d
	andl	$2097151, %r14d                 # imm = 0x1FFFFF
	movq	%r9, %rsi
	imulq	%r14, %rsi
	addq	%rsi, %rdx
	movq	%r12, %rsi
	movq	%rax, %r11
	imulq	%rax, %rsi
	addq	%rsi, %rdx
	movq	%rdx, 744(%rsp)                 # 8-byte Spill
	movq	%r14, %rsi
	movq	%r14, 48(%rsp)                  # 8-byte Spill
	imulq	%rbx, %rsi
	movq	%rax, %rdi
	imulq	%rcx, %rdi
	addq	%rsi, %rdi
	shrl	%r10d
	andl	$2097151, %r10d                 # imm = 0x1FFFFF
	movq	%r10, %rsi
	movq	%r10, %rdx
	imulq	%r9, %rsi
	movq	%r9, %rcx
	movq	%r12, %r9
	imulq	%rbp, %r9
	movq	%rbp, 144(%rsp)                 # 8-byte Spill
	addq	%rsi, %r9
	movq	8(%rsp), %r10                   # 8-byte Reload
	shrl	%r10d
	andl	$2097151, %r10d                 # imm = 0x1FFFFF
	movq	%r10, 8(%rsp)                   # 8-byte Spill
	movq	%r13, %rsi
	imulq	%r8, %rsi
	movq	%r8, 16(%rsp)                   # 8-byte Spill
	movq	%r15, %rax
	imulq	%r10, %rax
	addq	%rsi, %rax
	addq	%rdi, %rax
	addq	%r9, %rax
	movq	%rax, 736(%rsp)                 # 8-byte Spill
	movl	207(%rsp), %r13d
	shrl	$6, %r13d
	andl	$2097151, %r13d                 # imm = 0x1FFFFF
	movq	%rcx, %rsi
	movq	%rcx, %r12
	movq	%rcx, 168(%rsp)                 # 8-byte Spill
	imulq	%r13, %rsi
	movq	%r13, 56(%rsp)                  # 8-byte Spill
	movq	%rdx, %r9
	imulq	%rbx, %r9
	addq	%rsi, %r9
	movq	%r11, %rsi
	movq	%r11, %rcx
	movq	%r11, 72(%rsp)                  # 8-byte Spill
	imulq	%r14, %rsi
	movq	40(%rsp), %rdi                  # 8-byte Reload
	movq	%rdi, %r14
	imulq	%r8, %r14
	addq	%rsi, %r14
	movl	511(%rsp), %r10d
	shrl	$6, %r10d
	andl	$2097151, %r10d                 # imm = 0x1FFFFF
	movq	104(%rsp), %r8                  # 8-byte Reload
	movq	%r8, %rsi
	imulq	%rbp, %rsi
	movq	%r15, %r11
	movq	%r15, 152(%rsp)                 # 8-byte Spill
	movq	%r15, %rax
	imulq	%r10, %rax
	addq	%rsi, %rax
	movq	8(%rsp), %rbp                   # 8-byte Reload
	movq	%rbp, %rsi
	movq	32(%rsp), %r15                  # 8-byte Reload
	imulq	%r15, %rsi
	addq	%rsi, %rax
	addq	%r14, %rax
	addq	%r9, %rax
	movq	%rax, 728(%rsp)                 # 8-byte Spill
	movq	(%rsp), %rsi                    # 8-byte Reload
	shrq	$3, %rsi
	movq	%rsi, (%rsp)                    # 8-byte Spill
	imulq	%r12, %rsi
	movq	%rdx, %rax
	movq	%rdx, %r12
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	imulq	%rcx, %rax
	addq	%rsi, %rax
	movq	88(%rsp), %rcx                  # 8-byte Reload
	shrq	$3, %rcx
	addq	%rcx, %rax
	movq	%rax, 720(%rsp)                 # 8-byte Spill
	imulq	%rbx, %r13
	movq	%rdi, %rsi
	imulq	%rbp, %rsi
	addq	%r13, %rsi
	movq	%r8, %r14
	movq	%r8, %rcx
	movq	16(%rsp), %rdx                  # 8-byte Reload
	imulq	%rdx, %rcx
	movq	%r15, %rdi
	movq	%r15, %r9
	imulq	%r10, %r9
	movq	%r10, %r15
	movq	%r10, 160(%rsp)                 # 8-byte Spill
	addq	%rcx, %r9
	movq	136(%rsp), %r13                 # 8-byte Reload
	shrq	$3, %r13
	movq	%r11, %rax
	imulq	%r13, %rax
	movq	%r13, %r11
	addq	%r9, %rax
	movq	48(%rsp), %r9                   # 8-byte Reload
	movq	%r9, %rcx
	movq	144(%rsp), %r8                  # 8-byte Reload
	imulq	%r8, %rcx
	addq	%rcx, %rax
	addq	%rsi, %rax
	movq	%rax, 176(%rsp)                 # 8-byte Spill
	movq	(%rsp), %r10                    # 8-byte Reload
	movq	%r10, %rcx
	imulq	%rbx, %rcx
	movq	%r12, %rsi
	imulq	%r8, %rsi
	addq	%rcx, %rsi
	movq	64(%rsp), %r8                   # 8-byte Reload
	movq	%r8, %rcx
	movq	168(%rsp), %rax                 # 8-byte Reload
	imulq	%rax, %rcx
	addq	%rcx, %rsi
	movq	%r9, %rcx
	imulq	%rdx, %rcx
	movq	40(%rsp), %rbp                  # 8-byte Reload
	movq	%rbp, %r9
	imulq	%r15, %r9
	addq	%rcx, %r9
	movq	72(%rsp), %r12                  # 8-byte Reload
	movq	%r12, %rcx
	movq	56(%rsp), %r13                  # 8-byte Reload
	imulq	%r13, %rcx
	addq	%rcx, %r9
	movq	%r11, %rcx
	movq	%r11, %rdx
	movq	%r11, 136(%rsp)                 # 8-byte Spill
	imulq	%rdi, %rcx
	movq	152(%rsp), %r15                 # 8-byte Reload
	movq	%r15, %rdi
	imulq	80(%rsp), %rdi                  # 8-byte Folded Reload
	addq	%rcx, %rdi
	movq	8(%rsp), %rcx                   # 8-byte Reload
	imulq	%r14, %rcx
	movq	%r14, %r11
	addq	%rcx, %rdi
	addq	%r9, %rdi
	addq	%rsi, %rdi
	movzwl	597(%rsp), %ecx
	addq	%rcx, %rdi
	movq	%rdi, 712(%rsp)                 # 8-byte Spill
	movl	215(%rsp), %esi
	shrl	$5, %esi
	andl	$2097151, %esi                  # imm = 0x1FFFFF
	movq	%rsi, 88(%rsp)                  # 8-byte Spill
	imulq	%rsi, %rax
	movq	%r10, %r14
	imulq	%r12, %r14
	addq	%rax, %r14
	imulq	%rbx, %r8
	addq	%r8, %r14
	movq	%r13, %rcx
	movq	144(%rsp), %r8                  # 8-byte Reload
	imulq	%r8, %rcx
	movq	%rbp, %r13
	imulq	%rdx, %r13
	addq	%rcx, %r13
	movq	24(%rsp), %r12                  # 8-byte Reload
	movq	%r12, %rcx
	imulq	16(%rsp), %rcx                  # 8-byte Folded Reload
	addq	%rcx, %r13
	movl	519(%rsp), %ecx
	shrl	$5, %ecx
	andl	$2097151, %ecx                  # imm = 0x1FFFFF
	movq	160(%rsp), %rdi                 # 8-byte Reload
	imulq	%rdi, %r11
	movq	%r15, %rax
	imulq	%rcx, %rax
	movq	%rcx, %r15
	addq	%r11, %rax
	movq	80(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, %rbp
	movq	32(%rsp), %r10                  # 8-byte Reload
	imulq	%r10, %rbp
	addq	%rbp, %rax
	movq	8(%rsp), %r9                    # 8-byte Reload
	movq	%r9, %rbp
	movq	48(%rsp), %rdx                  # 8-byte Reload
	imulq	%rdx, %rbp
	addq	%rbp, %rax
	addq	%r13, %rax
	addq	%r14, %rax
	movq	%rax, 232(%rsp)                 # 8-byte Spill
	movq	96(%rsp), %r13                  # 8-byte Reload
	shrl	$2, %r13d
	andl	$2097151, %r13d                 # imm = 0x1FFFFF
	movq	%r13, 96(%rsp)                  # 8-byte Spill
	imulq	168(%rsp), %r13                 # 8-byte Folded Reload
	movq	64(%rsp), %r14                  # 8-byte Reload
	imulq	72(%rsp), %r14                  # 8-byte Folded Reload
	addq	%r13, %r14
	movq	(%rsp), %r13                    # 8-byte Reload
	imulq	%r8, %r13
	movq	%r8, %r11
	movq	%r12, %rcx
	imulq	%r9, %rcx
	addq	%r13, %rcx
	movq	88(%rsp), %r13                  # 8-byte Reload
	imulq	%rbx, %r13
	addq	%r13, %rcx
	imulq	%rdi, %rdx
	movq	40(%rsp), %rbp                  # 8-byte Reload
	imulq	%rsi, %rbp
	addq	%rdx, %rbp
	movq	56(%rsp), %r13                  # 8-byte Reload
	movq	16(%rsp), %r8                   # 8-byte Reload
	imulq	%r8, %r13
	addq	%r13, %rbp
	movq	136(%rsp), %r12                 # 8-byte Reload
	movq	%r12, %r13
	imulq	104(%rsp), %r13                 # 8-byte Folded Reload
	imulq	%r15, %r10
	movq	%r15, %rsi
	movq	%r15, 656(%rsp)                 # 8-byte Spill
	addq	%r13, %r10
	movq	112(%rsp), %r9                  # 8-byte Reload
	shrl	$2, %r9d
	andl	$2097151, %r9d                  # imm = 0x1FFFFF
	movq	152(%rsp), %r15                 # 8-byte Reload
	movq	%r15, %rdx
	imulq	%r9, %rdx
	addq	%r10, %rdx
	addq	%rbp, %rdx
	addq	%rcx, %rdx
	addq	%r14, %rdx
	movq	%rdx, 704(%rsp)                 # 8-byte Spill
	movl	220(%rsp), %edx
	shrq	$7, %rdx
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	%r15, %rcx
	movq	168(%rsp), %rax                 # 8-byte Reload
	imulq	%rax, %rcx
	movq	%rcx, 688(%rsp)                 # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	imulq	%rdx, %rax
	movq	64(%rsp), %rcx                  # 8-byte Reload
	imulq	%r11, %rcx
	addq	%rax, %rcx
	movq	96(%rsp), %rax                  # 8-byte Reload
	imulq	%rbx, %rax
	addq	%rax, %rcx
	movl	604(%rsp), %eax
	shrq	$7, %rax
	addq	%rax, %rcx
	movq	%rcx, 696(%rsp)                 # 8-byte Spill
	movq	(%rsp), %r13                    # 8-byte Reload
	movq	%r13, %rax
	imulq	%r8, %rax
	movq	24(%rsp), %r11                  # 8-byte Reload
	movq	%r11, %rcx
	movq	%rdi, %r10
	imulq	%rdi, %rcx
	addq	%rax, %rcx
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	88(%rsp), %rdi                  # 8-byte Reload
	imulq	%rdi, %rax
	addq	%rax, %rcx
	movq	%r12, %rax
	imulq	48(%rsp), %rax                  # 8-byte Folded Reload
	movq	40(%rsp), %rbp                  # 8-byte Reload
	imulq	%rsi, %rbp
	addq	%rax, %rbp
	movq	8(%rsp), %rdx                   # 8-byte Reload
	movq	%rdx, %rax
	movq	56(%rsp), %rsi                  # 8-byte Reload
	imulq	%rsi, %rax
	addq	%rax, %rbp
	movl	524(%rsp), %r14d
	shrq	$7, %r14
	movq	80(%rsp), %rax                  # 8-byte Reload
	movq	104(%rsp), %r12                 # 8-byte Reload
	imulq	%r12, %rax
	imulq	%r14, %r15
	movq	%r14, 648(%rsp)                 # 8-byte Spill
	addq	%rax, %r15
	movq	%r9, %r8
	movq	%r9, 112(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	movq	32(%rsp), %r9                   # 8-byte Reload
	imulq	%r9, %rax
	addq	%rax, %r15
	addq	%rbp, %r15
	addq	%rcx, %r15
	movq	%r15, 152(%rsp)                 # 8-byte Spill
	imulq	144(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%r13, %rcx
	imulq	%rdx, %rcx
	addq	%rdi, %rcx
	movq	64(%rsp), %rdi                  # 8-byte Reload
	movq	%rdi, %rax
	imulq	16(%rsp), %rax                  # 8-byte Folded Reload
	addq	%rax, %rcx
	imulq	%r10, %rsi
	imulq	136(%rsp), %r11                 # 8-byte Folded Reload
	addq	%rsi, %r11
	movq	%r9, %r15
	movq	128(%rsp), %rax                 # 8-byte Reload
	imulq	%r9, %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%r12, %rax
	movq	656(%rsp), %r12                 # 8-byte Reload
	imulq	%r12, %rax
	imulq	%r14, %r15
	addq	%rax, %r15
	movq	80(%rsp), %rdx                  # 8-byte Reload
	movq	%rdx, %rax
	movq	48(%rsp), %r13                  # 8-byte Reload
	imulq	%r13, %rax
	addq	%rax, %r15
	movq	40(%rsp), %r9                   # 8-byte Reload
	movq	%r9, %rax
	imulq	%r8, %rax
	addq	%rax, %r15
	movq	%r15, %rax
	addq	%r11, %rax
	addq	%rcx, %rax
	movq	120(%rsp), %r8                  # 8-byte Reload
	imulq	%r8, %rbx
	addq	%rbx, %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	88(%rsp), %rbx                  # 8-byte Reload
	movq	%rbx, %rax
	imulq	16(%rsp), %rax                  # 8-byte Folded Reload
	movq	%rdi, %rcx
	movq	8(%rsp), %rsi                   # 8-byte Reload
	imulq	%rsi, %rcx
	addq	%rax, %rcx
	movq	96(%rsp), %r10                  # 8-byte Reload
	movq	%r10, %rax
	movq	72(%rsp), %r11                  # 8-byte Reload
	imulq	%r11, %rax
	movq	%rax, 168(%rsp)                 # 8-byte Spill
	imulq	%r8, %r11
	addq	%r11, %rcx
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	160(%rsp), %r8                  # 8-byte Reload
	imulq	%r8, %rax
	movq	24(%rsp), %r11                  # 8-byte Reload
	imulq	%rdx, %r11
	addq	%rax, %r11
	movq	%r13, %rax
	movq	%r12, %r14
	imulq	%r12, %rax
	movq	648(%rsp), %rdx                 # 8-byte Reload
	imulq	%rdx, %r9
	addq	%rax, %r9
	movq	136(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rax
	movq	56(%rsp), %r13                  # 8-byte Reload
	imulq	%r13, %rax
	addq	%rax, %r9
	movq	112(%rsp), %rdi                 # 8-byte Reload
	movq	%rdi, %rax
	movq	104(%rsp), %r12                 # 8-byte Reload
	imulq	%r12, %rax
	addq	%rax, %r9
	addq	%r11, %r9
	addq	%rcx, %r9
	movq	%r9, 40(%rsp)                   # 8-byte Spill
	imulq	%rbx, %rsi
	movq	64(%rsp), %r11                  # 8-byte Reload
	movq	%r11, %rcx
	movq	%r8, %r15
	imulq	%r8, %rcx
	addq	%rsi, %rcx
	movq	%r10, %rbx
	movq	%r10, %rax
	movq	144(%rsp), %rsi                 # 8-byte Reload
	imulq	%rsi, %rax
	movq	%rax, 672(%rsp)                 # 8-byte Spill
	movq	120(%rsp), %r9                  # 8-byte Reload
	imulq	%r9, %rsi
	addq	%rsi, %rcx
	movq	(%rsp), %rax                    # 8-byte Reload
	imulq	%rbp, %rax
	movq	%rbp, %r10
	movq	24(%rsp), %r8                   # 8-byte Reload
	imulq	%r14, %r8
	addq	%rax, %r8
	movq	80(%rsp), %rbp                  # 8-byte Reload
	movq	%rbp, %rax
	imulq	%r13, %rax
	imulq	%rdx, %r12
	movq	%rdx, %r13
	addq	%rax, %r12
	movq	%rdi, %rax
	movq	48(%rsp), %rdi                  # 8-byte Reload
	imulq	%rdi, %rax
	addq	%rax, %r12
	addq	%r8, %r12
	addq	%rcx, %r12
	movq	%r12, 104(%rsp)                 # 8-byte Spill
	movq	88(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, %rax
	imulq	%r15, %rax
	movq	%r11, %rcx
	movq	%r11, %r15
	imulq	%r10, %rcx
	addq	%rax, %rcx
	movq	%rbx, %r12
	movq	%rbx, %rax
	movq	16(%rsp), %rdx                  # 8-byte Reload
	imulq	%rdx, %rax
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	imulq	%r9, %rdx
	addq	%rdx, %rcx
	movq	56(%rsp), %rdx                  # 8-byte Reload
	movq	%rdx, %rax
	imulq	%r14, %rax
	movq	%rdi, %r8
	imulq	%r13, %r8
	addq	%rax, %r8
	movq	(%rsp), %rbx                    # 8-byte Reload
	movq	%rbx, %rax
	movq	%rbp, %r11
	imulq	%rbp, %rax
	addq	%rax, %r8
	movq	24(%rsp), %rbp                  # 8-byte Reload
	movq	%rbp, %rax
	movq	112(%rsp), %rdi                 # 8-byte Reload
	imulq	%rdi, %rax
	addq	%rax, %r8
	addq	%rcx, %r8
	movq	%r8, 48(%rsp)                   # 8-byte Spill
	movq	%r10, %rax
	imulq	%rsi, %rax
	movq	%rbx, %rcx
	imulq	%r14, %rcx
	addq	%rax, %rcx
	movq	%r15, %rax
	imulq	%r11, %rax
	addq	%rax, %rcx
	movq	%rdi, %rax
	imulq	%rdx, %rax
	movq	%rdx, %r9
	movq	%rbp, %rdx
	imulq	%r13, %rdx
	addq	%rax, %rdx
	addq	%rcx, %rdx
	movq	%r12, %rcx
	movq	8(%rsp), %rax                   # 8-byte Reload
	imulq	%rax, %rcx
	movq	%rcx, 664(%rsp)                 # 8-byte Spill
	movq	120(%rsp), %r8                  # 8-byte Reload
	imulq	%r8, %rax
	addq	%rax, %rdx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r12, %rax
	movq	160(%rsp), %rcx                 # 8-byte Reload
	imulq	%rcx, %rax
	movq	%rax, 680(%rsp)                 # 8-byte Spill
	imulq	%r8, %rcx
	movq	%r8, %rbp
	movq	%r15, %r8
	imulq	%r14, %r8
	addq	%rcx, %r8
	movq	%r12, %rax
	imulq	%r10, %rax
	addq	%rax, %r8
	movq	%r11, %rax
	movq	%rsi, %rdx
	imulq	%rsi, %rax
	movq	%r9, %rsi
	imulq	%r13, %rsi
	addq	%rax, %rsi
	movq	%rbx, %rcx
	movq	%rbx, %rax
	imulq	%rdi, %rax
	addq	%rax, %rsi
	movq	%rsi, 56(%rsp)                  # 8-byte Spill
	movq	%rdx, %rax
	imulq	%r14, %rax
	imulq	%r13, %rcx
	addq	%rax, %rcx
	movq	%r15, %rax
	imulq	%rdi, %rax
	addq	%rax, %rcx
	imulq	%rbp, %r10
	addq	%r10, %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	movq	%r12, %r10
	movq	%r11, %rax
	imulq	%r11, %r10
	imulq	%rbp, %rax
	imulq	%r13, %r15
	addq	%rax, %r15
	movq	%rdi, %rax
	movq	%rdx, %rcx
	imulq	%rdx, %rax
	addq	%rax, %r15
	movq	%r15, 64(%rsp)                  # 8-byte Spill
	movq	%r12, %rax
	movq	%r12, %r11
	imulq	%r14, %r11
	imulq	%rbp, %r14
	imulq	%r13, %rcx
	addq	%r14, %rcx
	movq	%rcx, 88(%rsp)                  # 8-byte Spill
	movq	%rax, %rcx
	movq	%rdi, %rdx
	imulq	%rdi, %rcx
	imulq	%rbp, %rdx
	imulq	%r13, %rax
	addq	%rdx, %rax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	imulq	%r13, %rbp
	movq	%rbp, %r14
	movq	480(%rsp), %rax                 # 8-byte Reload
	movq	688(%rsp), %rsi                 # 8-byte Reload
	leaq	(%rax,%rsi), %rdx
	addq	%rsi, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	456(%rsp), %r12                 # 8-byte Reload
	addq	128(%rsp), %r12                 # 8-byte Folded Reload
	movq	%rax, %rsi
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	472(%rsp), %rax                 # 8-byte Reload
	shrl	$2, %eax
	andl	$2097151, %eax                  # imm = 0x1FFFFF
	movq	760(%rsp), %rdx                 # 8-byte Reload
	leaq	(%rdx,%rax), %rdi
	movq	%rdi, 8(%rsp)                   # 8-byte Spill
	addq	%rax, %rdx
	addq	$1048576, %rdx                  # imm = 0x100000
	movq	184(%rsp), %rax                 # 8-byte Reload
	addq	752(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 184(%rsp)                 # 8-byte Spill
	movl	586(%rsp), %eax
	shrl	$4, %eax
	andl	$2097151, %eax                  # imm = 0x1FFFFF
	movq	744(%rsp), %r9                  # 8-byte Reload
	leaq	(%r9,%rax), %rdi
	leaq	(%rax,%r9), %rbx
	addq	$1048576, %rbx                  # imm = 0x100000
	movq	%rbx, %rax
	shrq	$21, %rax
	addq	736(%rsp), %rax                 # 8-byte Folded Reload
	andq	$-2097152, %rbx                 # imm = 0xFFE00000
	subq	%rbx, %rdi
	movq	%rdi, 112(%rsp)                 # 8-byte Spill
	movl	591(%rsp), %ebx
	shrl	$6, %ebx
	andl	$2097151, %ebx                  # imm = 0x1FFFFF
	movq	728(%rsp), %r9                  # 8-byte Reload
	leaq	(%r9,%rbx), %r13
	movq	%r13, 128(%rsp)                 # 8-byte Spill
	addq	%rbx, %r9
	addq	$1048576, %r9                   # imm = 0x100000
	movq	%r9, 80(%rsp)                   # 8-byte Spill
	movq	176(%rsp), %rdi                 # 8-byte Reload
	addq	720(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%rdi, 176(%rsp)                 # 8-byte Spill
	movzbl	599(%rsp), %ebx
	andl	$31, %ebx
	shlq	$16, %rbx
	movq	712(%rsp), %r13                 # 8-byte Reload
	leaq	(%rbx,%r13), %rdi
	movq	%rdi, 120(%rsp)                 # 8-byte Spill
	addq	%r13, %rbx
	addq	$1048576, %rbx                  # imm = 0x100000
	movq	%rbx, 16(%rsp)                  # 8-byte Spill
	movl	599(%rsp), %ebx
	shrl	$5, %ebx
	andl	$2097151, %ebx                  # imm = 0x1FFFFF
	addq	%rbx, 232(%rsp)                 # 8-byte Folded Spill
	movq	464(%rsp), %rbx                 # 8-byte Reload
	shrl	$2, %ebx
	andl	$2097151, %ebx                  # imm = 0x1FFFFF
	movq	704(%rsp), %r13                 # 8-byte Reload
	leaq	(%rbx,%r13), %rbp
	movq	%rbp, 144(%rsp)                 # 8-byte Spill
	leaq	(%rbx,%r13), %rbp
	addq	$1048576, %rbp                  # imm = 0x100000
	movq	%rbp, 160(%rsp)                 # 8-byte Spill
	movq	152(%rsp), %r13                 # 8-byte Reload
	addq	696(%rsp), %r13                 # 8-byte Folded Reload
	movq	672(%rsp), %rbx                 # 8-byte Reload
	addq	%rbx, 40(%rsp)                  # 8-byte Folded Spill
	movq	664(%rsp), %rdi                 # 8-byte Reload
	addq	%rdi, 48(%rsp)                  # 8-byte Folded Spill
	movq	56(%rsp), %r9                   # 8-byte Reload
	addq	%r8, %r9
	movq	(%rsp), %rdi                    # 8-byte Reload
	leaq	(%rdi,%r10), %r15
	addq	%rdi, %r10
	addq	$1048576, %r10                  # imm = 0x100000
	movq	64(%rsp), %r8                   # 8-byte Reload
	addq	%r11, %r8
	movq	%r10, %r11
	andq	$-2097152, %r10                 # imm = 0xFFE00000
	subq	%r10, %r15
	movq	88(%rsp), %rdi                  # 8-byte Reload
	leaq	(%rdi,%rcx), %rbx
	addq	%rdi, %rcx
	addq	$1048576, %rcx                  # imm = 0x100000
	movq	%rcx, %r10
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %rbx
	leaq	1048576(%r14), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %r14
	shrq	$21, %rsi
	leaq	(%r12,%rsi), %rdi
	leaq	(%rsi,%r12), %rcx
	addq	$1048576, %rcx                  # imm = 0x100000
	movq	%rcx, %r12
	shrq	$21, %r12
	addq	8(%rsp), %r12                   # 8-byte Folded Reload
	movq	%rdx, %rsi
	andq	$-2097152, %rdx                 # imm = 0xFFE00000
	subq	%rdx, %r12
	movq	%r12, 56(%rsp)                  # 8-byte Spill
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %rdi
	movq	%rdi, 64(%rsp)                  # 8-byte Spill
	shrq	$21, %rsi
	movq	184(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rsi), %rdx
	addq	%rsi, %rcx
	addq	$1048576, %rcx                  # imm = 0x100000
	movq	%rcx, %rsi
	shrq	$21, %rsi
	addq	112(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rsi, 112(%rsp)                 # 8-byte Spill
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %rdx
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	488(%rsp), %rcx                 # 8-byte Reload
	shrl	%ecx
	andl	$2097151, %ecx                  # imm = 0x1FFFFF
	leaq	(%rax,%rcx), %rdx
	movq	%rdx, 152(%rsp)                 # 8-byte Spill
	addq	%rcx, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	80(%rsp), %rax                  # 8-byte Reload
	shrq	$21, %rax
	movq	176(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rax), %rdx
	movq	%rdx, 464(%rsp)                 # 8-byte Spill
	addq	%rcx, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, 472(%rsp)                 # 8-byte Spill
	shrq	$21, %rax
	addq	120(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 480(%rsp)                 # 8-byte Spill
	movq	16(%rsp), %rax                  # 8-byte Reload
	shrq	$21, %rax
	movq	232(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rax), %rdx
	movq	%rdx, 488(%rsp)                 # 8-byte Spill
	addq	%rcx, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, 232(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	shrq	$21, %rax
	leaq	(%rax,%r13), %rdx
	movq	%rdx, 176(%rsp)                 # 8-byte Spill
	addq	%r13, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	24(%rsp), %rsi                  # 8-byte Reload
	movq	680(%rsp), %rdi                 # 8-byte Reload
	leaq	(%rdi,%rsi), %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, %rcx
	shrq	$21, %rcx
	movq	%r9, %rdx
	addq	%rcx, %r9
	addq	%rdx, %rcx
	addq	$1048576, %rcx                  # imm = 0x100000
	movq	%rcx, %rdx
	shrq	$21, %rdx
	addq	%r15, %rdx
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %r9
	movq	%r9, 184(%rsp)                  # 8-byte Spill
	shrq	$21, %r11
	movq	%r8, %rcx
	addq	%r11, %r8
	addq	%r11, %rcx
	addq	$1048576, %rcx                  # imm = 0x100000
	movq	%rcx, %r11
	shrq	$21, %r11
	addq	%rbx, %r11
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %r8
	shrq	$21, %r10
	movq	96(%rsp), %rcx                  # 8-byte Reload
	leaq	(%rcx,%r10), %r13
	addq	%r10, %rcx
	addq	$1048576, %rcx                  # imm = 0x100000
	movq	%rcx, %r12
	shrq	$21, %r12
	addq	%r14, %r12
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %r13
	movq	(%rsp), %rcx                    # 8-byte Reload
	shrq	$21, %rcx
	imulq	$-683901, %rcx, %r9             # imm = 0xFFF59083
	addq	%rdi, %r9
	addq	%rsi, %r9
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %r9
	movq	%r9, 24(%rsp)                   # 8-byte Spill
	imulq	$666643, %rcx, %rax             # imm = 0xA2C13
	movq	%rcx, %rsi
	movq	%rcx, (%rsp)                    # 8-byte Spill
	imulq	$470296, %r12, %rcx             # imm = 0x72D18
	addq	%rax, %rcx
	imulq	$666643, %r12, %rax             # imm = 0xA2C13
	imulq	$470296, %r13, %r9              # imm = 0x72D18
	addq	%rax, %r9
	imulq	$654183, %r13, %r14             # imm = 0x9FB67
	addq	%rcx, %r14
	imulq	$-997805, %r12, %rcx            # imm = 0xFFF0C653
	imulq	$136657, %r13, %rax             # imm = 0x215D1
	addq	%rcx, %rax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	imulq	$-997805, %rsi, %rsi            # imm = 0xFFF0C653
	movq	72(%rsp), %rcx                  # 8-byte Reload
	addq	%rcx, %rsi
	movq	104(%rsp), %rax                 # 8-byte Reload
	leaq	(%rcx,%rax), %rdi
	addq	$1048576, %rdi                  # imm = 0x100000
	addq	%rax, %rsi
	movq	%rdi, 104(%rsp)                 # 8-byte Spill
	andq	$-2097152, %rdi                 # imm = 0xFFE00000
	subq	%rdi, %rsi
	movq	168(%rsp), %rbp                 # 8-byte Reload
	movq	32(%rsp), %rax                  # 8-byte Reload
	leaq	(%rax,%rbp), %r10
	addq	$1048576, %r10                  # imm = 0x100000
	movq	%r10, %rcx
	shrq	$21, %rcx
	movq	%rcx, 72(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rax                  # 8-byte Reload
	leaq	(%rcx,%rax), %rdi
	addq	$1048576, %rdi                  # imm = 0x100000
	movq	%rdi, 456(%rsp)                 # 8-byte Spill
	shrq	$21, %rdi
	addq	%rdi, %rsi
	imulq	$136657, %r12, %rdi             # imm = 0x215D1
	addq	%rdi, %rsi
	imulq	$666643, %r13, %rdi             # imm = 0xA2C13
	imulq	$470296, %r11, %rbx             # imm = 0x72D18
	addq	%rdi, %rbx
	imulq	$654183, %r11, %rax             # imm = 0x9FB67
	addq	%r9, %rax
	imulq	$-997805, %r11, %rcx            # imm = 0xFFF0C653
	addq	%r14, %rcx
	imulq	$666643, %r8, %rdi              # imm = 0xA2C13
	addq	464(%rsp), %rdi                 # 8-byte Folded Reload
	imulq	$666643, %r11, %r14             # imm = 0xA2C13
	imulq	$470296, %r8, %r9               # imm = 0x72D18
	addq	%r14, %r9
	imulq	$654183, %r8, %r15              # imm = 0x9FB67
	addq	%rbx, %r15
	imulq	$-997805, %r8, %r14             # imm = 0xFFF0C653
	addq	%rax, %r14
	imulq	$136657, %r8, %rbx              # imm = 0x215D1
	addq	%rcx, %rbx
	imulq	$470296, (%rsp), %rax           # 8-byte Folded Reload
                                        # imm = 0x72D18
	addq	%rbp, %rax
	addq	32(%rsp), %rax                  # 8-byte Folded Reload
	andq	$-2097152, %r10                 # imm = 0xFFE00000
	subq	%r10, %rax
	imulq	$654183, %r12, %rcx             # imm = 0x9FB67
	addq	%rcx, %rax
	imulq	$-997805, %r13, %rcx            # imm = 0xFFF0C653
	movq	%r13, %rbp
	addq	%rcx, %rax
	imulq	$136657, %r11, %rcx             # imm = 0x215D1
	addq	%rcx, %rax
	imulq	$-683901, %r8, %rcx             # imm = 0xFFF59083
	addq	%rcx, %rax
	imulq	$666643, %rdx, %r8              # imm = 0xA2C13
	addq	128(%rsp), %r8                  # 8-byte Folded Reload
	movq	80(%rsp), %rcx                  # 8-byte Reload
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %r8
	imulq	$470296, %rdx, %rcx             # imm = 0x72D18
	addq	%rdi, %rcx
	movq	472(%rsp), %rdi                 # 8-byte Reload
	andq	$-2097152, %rdi                 # imm = 0xFFE00000
	subq	%rdi, %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	imulq	$654183, %rdx, %rdi             # imm = 0x9FB67
	addq	%r9, %rdi
	addq	480(%rsp), %rdi                 # 8-byte Folded Reload
	movq	16(%rsp), %rcx                  # 8-byte Reload
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %rdi
	movq	%rdi, %r13
	movq	%rdi, 128(%rsp)                 # 8-byte Spill
	imulq	$-997805, %rdx, %rcx            # imm = 0xFFF0C653
	addq	488(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r15, %rcx
	movq	232(%rsp), %rdi                 # 8-byte Reload
	movq	%rdi, %r9
	andq	$-2097152, %rdi                 # imm = 0xFFE00000
	subq	%rdi, %rcx
	shrq	$21, %r9
	imulq	$136657, %rdx, %rdi             # imm = 0x215D1
	addq	%r9, %rdi
	addq	%r14, %rdi
	addq	144(%rsp), %rdi                 # 8-byte Folded Reload
	movq	160(%rsp), %r9                  # 8-byte Reload
	andq	$-2097152, %r9                  # imm = 0xFFE00000
	subq	%r9, %rdi
	imulq	$-683901, %rdx, %rdx            # imm = 0xFFF59083
	addq	176(%rsp), %rdx                 # 8-byte Folded Reload
	addq	%rbx, %rdx
	movq	120(%rsp), %r10                 # 8-byte Reload
	movq	%r10, %r9
	andq	$-2097152, %r10                 # imm = 0xFFE00000
	subq	%r10, %rdx
	movq	8(%rsp), %r10                   # 8-byte Reload
	shrq	$21, %r10
	leaq	(%r8,%r10), %rbx
	movq	%rbx, 16(%rsp)                  # 8-byte Spill
	addq	%r10, %r8
	addq	$1048576, %r8                   # imm = 0x100000
	movq	%r8, 80(%rsp)                   # 8-byte Spill
	shrq	$21, %r9
	leaq	(%rax,%r9), %r14
	addq	%rax, %r9
	addq	$1048576, %r9                   # imm = 0x100000
	movq	(%rsp), %r10                    # 8-byte Reload
	imulq	$654183, %r10, %rax             # imm = 0x9FB67
	addq	40(%rsp), %rax                  # 8-byte Folded Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	movq	456(%rsp), %r8                  # 8-byte Reload
	andq	$-2097152, %r8                  # imm = 0xFFE00000
	subq	%r8, %rax
	addq	96(%rsp), %rax                  # 8-byte Folded Reload
	imulq	$-683901, %r11, %r8             # imm = 0xFFF59083
	addq	%r8, %rax
	movq	%r9, %r8
	andq	$-2097152, %r9                  # imm = 0xFFE00000
	subq	%r9, %r14
	imulq	$-683901, %rbp, %r9             # imm = 0xFFF59083
	leaq	(%rsi,%r9), %rbx
	addq	%rsi, %r9
	addq	$1048576, %r9                   # imm = 0x100000
	movq	104(%rsp), %r11                 # 8-byte Reload
	shrq	$21, %r11
	imulq	$136657, %r10, %rbp             # imm = 0x215D1
	movq	48(%rsp), %rsi                  # 8-byte Reload
	addq	%rsi, %rbp
	addq	%r11, %rsi
	addq	$1048576, %rsi                  # imm = 0x100000
	addq	%r11, %rbp
	movq	%rsi, %r11
	andq	$-2097152, %rsi                 # imm = 0xFFE00000
	subq	%rsi, %rbp
	imulq	$-683901, %r12, %rsi            # imm = 0xFFF59083
	addq	%rsi, %rbp
	movq	%r9, %rsi
	andq	$-2097152, %r9                  # imm = 0xFFE00000
	subq	%r9, %rbx
	shrq	$21, %r11
	movq	24(%rsp), %r9                   # 8-byte Reload
	leaq	(%r9,%r11), %r10
	addq	%r11, %r9
	addq	$1048576, %r9                   # imm = 0x100000
	movq	%r9, %r12
	sarq	$21, %r12
	addq	184(%rsp), %r12                 # 8-byte Folded Reload
	andq	$-2097152, %r9                  # imm = 0xFFE00000
	subq	%r9, %r10
	leaq	1048576(%r13), %r9
	movq	%r9, 24(%rsp)                   # 8-byte Spill
	sarq	$21, %r9
	leaq	(%rcx,%r9), %r11
	movq	%r11, (%rsp)                    # 8-byte Spill
	leaq	(%rcx,%r9), %r13
	addq	$1048576, %r13                  # imm = 0x100000
	leaq	1048576(%rdi), %rcx
	movq	%rcx, %r9
	sarq	$21, %r9
	leaq	(%rdx,%r9), %r11
	addq	%r9, %rdx
	addq	$1048576, %rdx                  # imm = 0x100000
	movq	%rdx, %r9
	sarq	$21, %r9
	addq	%r14, %r9
	andq	$-2097152, %rdx                 # imm = 0xFFE00000
	subq	%rdx, %r11
	movq	%r11, 40(%rsp)                  # 8-byte Spill
	sarq	$21, %r8
	leaq	(%rax,%r8), %rdx
	addq	%r8, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, %r15
	sarq	$21, %r15
	addq	%rbx, %r15
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %rdx
	movq	%rdx, %r8
	sarq	$21, %rsi
	leaq	(%rsi,%rbp), %r11
	leaq	(%rsi,%rbp), %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, %rbx
	sarq	$21, %rbx
	addq	%r10, %rbx
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %r11
	imulq	$666643, %r12, %rax             # imm = 0xA2C13
	addq	152(%rsp), %rax                 # 8-byte Folded Reload
	movq	8(%rsp), %rdx                   # 8-byte Reload
	andq	$-2097152, %rdx                 # imm = 0xFFE00000
	subq	%rdx, %rax
	imulq	$470296, %r12, %rdx             # imm = 0x72D18
	addq	16(%rsp), %rdx                  # 8-byte Folded Reload
	movq	80(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, %r14
	andq	$-2097152, %rsi                 # imm = 0xFFE00000
	subq	%rsi, %rdx
	imulq	$136657, %r12, %rsi             # imm = 0x215D1
	addq	(%rsp), %rsi                    # 8-byte Folded Reload
	imulq	$-683901, %r12, %r10            # imm = 0xFFF59083
	movq	%r12, 72(%rsp)                  # 8-byte Spill
	addq	%rdi, %r10
	movq	%r13, %rdi
	sarq	$21, %rdi
	addq	%rdi, %r10
	andq	$-2097152, %rcx                 # imm = 0xFFE00000
	subq	%rcx, %r10
	movq	%r10, (%rsp)                    # 8-byte Spill
	imulq	$666643, %rbx, %rcx             # imm = 0xA2C13
	addq	112(%rsp), %rcx                 # 8-byte Folded Reload
	imulq	$470296, %rbx, %rdi             # imm = 0x72D18
	addq	%rax, %rdi
	imulq	$654183, %rbx, %rax             # imm = 0x9FB67
	addq	%rdx, %rax
	imulq	$-683901, %rbx, %rdx            # imm = 0xFFF59083
	addq	%rsi, %rdx
	andq	$-2097152, %r13                 # imm = 0xFFE00000
	subq	%r13, %rdx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	imulq	$666643, %r11, %rsi             # imm = 0xA2C13
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	imulq	$470296, %r11, %r13             # imm = 0x72D18
	addq	%rcx, %r13
	imulq	$654183, %r11, %rbp             # imm = 0x9FB67
	addq	%rdi, %rbp
	imulq	$-997805, %r11, %r10            # imm = 0xFFF0C653
	movq	%r11, 96(%rsp)                  # 8-byte Spill
	addq	%rax, %r10
	sarq	$21, %r14
	movq	%r14, 16(%rsp)                  # 8-byte Spill
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	%r14, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	sarq	$21, %rax
	imulq	$-683901, %r11, %rdx            # imm = 0xFFF59083
	addq	%rax, %rdx
	imulq	$-997805, %r12, %r14            # imm = 0xFFF0C653
	addq	128(%rsp), %r14                 # 8-byte Folded Reload
	imulq	$136657, %rbx, %rax             # imm = 0x215D1
	addq	%rax, %r14
	addq	%rdx, %r14
	movq	24(%rsp), %rax                  # 8-byte Reload
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %r14
	imulq	$666643, %r15, %rdx             # imm = 0xA2C13
	addq	56(%rsp), %rdx                  # 8-byte Folded Reload
	imulq	$470296, %r15, %rcx             # imm = 0x72D18
	addq	%rsi, %rcx
	imulq	$654183, %r15, %rdi             # imm = 0x9FB67
	addq	%r13, %rdi
	imulq	$-997805, %r15, %rax            # imm = 0xFFF0C653
	addq	%rbp, %rax
	imulq	$666643, %r8, %r13              # imm = 0xA2C13
	addq	64(%rsp), %r13                  # 8-byte Folded Reload
	imulq	$654183, %r8, %rbp              # imm = 0x9FB67
	addq	%rcx, %rbp
	imulq	$136657, %r8, %r11              # imm = 0x215D1
	addq	%rax, %r11
	imulq	$136657, %r15, %rsi             # imm = 0x215D1
	addq	%r10, %rsi
	imulq	$654183, %r9, %rcx              # imm = 0x9FB67
	addq	%rdx, %rcx
	imulq	$136657, %r9, %r10              # imm = 0x215D1
	addq	%rdi, %r10
	imulq	$666643, %r9, %rdx              # imm = 0xA2C13
	movq	136(%rsp), %rdi                 # 8-byte Reload
	leaq	(%rdx,%rdi), %rax
	addq	%rdi, %rdx
	addq	$1048576, %rdx                  # imm = 0x100000
	imulq	$470296, %r9, %r12              # imm = 0x72D18
	addq	%r13, %r12
	movq	%rdx, %rdi
	andq	$-2097152, %rdx                 # imm = 0xFFE00000
	subq	%rdx, %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	imulq	$470296, %r8, %rdx              # imm = 0x72D18
	leaq	(%rcx,%rdx), %rax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	leaq	(%rdx,%rcx), %r13
	addq	$1048576, %r13                  # imm = 0x100000
	imulq	$-997805, %r9, %rcx             # imm = 0xFFF0C653
	addq	%rbp, %rcx
	imulq	$-997805, %r8, %rdx             # imm = 0xFFF0C653
	leaq	(%r10,%rdx), %rbp
	movq	%rbp, 8(%rsp)                   # 8-byte Spill
	leaq	(%rdx,%r10), %rbp
	addq	$1048576, %rbp                  # imm = 0x100000
	imulq	$-683901, %r9, %r9              # imm = 0xFFF59083
	addq	%r11, %r9
	imulq	$-683901, %r8, %rdx             # imm = 0xFFF59083
	leaq	(%rsi,%rdx), %r11
	addq	%rsi, %rdx
	addq	$1048576, %rdx                  # imm = 0x100000
	imulq	$654183, 72(%rsp), %rax         # 8-byte Folded Reload
                                        # imm = 0x9FB67
	addq	32(%rsp), %rax                  # 8-byte Folded Reload
	addq	16(%rsp), %rax                  # 8-byte Folded Reload
	imulq	$-997805, %rbx, %rsi            # imm = 0xFFF0C653
	addq	%rsi, %rax
	imulq	$136657, 96(%rsp), %rsi         # 8-byte Folded Reload
                                        # imm = 0x215D1
	addq	%rsi, %rax
	movq	104(%rsp), %rsi                 # 8-byte Reload
	andq	$-2097152, %rsi                 # imm = 0xFFE00000
	subq	%rsi, %rax
	imulq	$-683901, %r15, %rsi            # imm = 0xFFF59083
	addq	%rsi, %rax
	movq	%rdx, %rsi
	andq	$-2097152, %rdx                 # imm = 0xFFE00000
	subq	%rdx, %r11
	leaq	1048576(%r14), %rdx
	movq	%rdx, %r10
	andq	$-2097152, %rdx                 # imm = 0xFFE00000
	subq	%rdx, %r14
	sarq	$21, %rdi
	leaq	(%r12,%rdi), %r8
	leaq	(%rdi,%r12), %r15
	addq	$1048576, %r15                  # imm = 0x100000
	movq	%r13, %rdx
	sarq	$21, %rdx
	leaq	(%rcx,%rdx), %rbx
	leaq	(%rdx,%rcx), %rdi
	addq	$1048576, %rdi                  # imm = 0x100000
	movq	%rbp, %rcx
	sarq	$21, %rcx
	leaq	(%r9,%rcx), %rdx
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%r9), %rdx
	addq	$1048576, %rdx                  # imm = 0x100000
	movq	%rdx, %r12
	sarq	$21, %r12
	addq	%r11, %r12
	sarq	$21, %rsi
	leaq	(%rax,%rsi), %r11
	addq	%rsi, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, %r9
	sarq	$21, %r9
	addq	%r14, %r9
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %r11
	sarq	$21, %r10
	movq	48(%rsp), %rax                  # 8-byte Reload
	leaq	(%rax,%r10), %rcx
	addq	%r10, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movq	(%rsp), %rax                    # 8-byte Reload
	leaq	1048576(%rax), %r14
	movq	%r14, %rax
	sarq	$21, %rax
	movq	40(%rsp), %rcx                  # 8-byte Reload
	leaq	(%rcx,%rax), %r10
	addq	%rcx, %rax
	addq	$1048576, %rax                  # imm = 0x100000
	movq	%rax, %rsi
	andq	$-2097152, %rax                 # imm = 0xFFE00000
	subq	%rax, %r10
	movq	%r10, 40(%rsp)                  # 8-byte Spill
	sarq	$21, %rsi
	imulq	$666643, %rsi, %r10             # imm = 0xA2C13
	addq	24(%rsp), %r10                  # 8-byte Folded Reload
	imulq	$470296, %rsi, %rcx             # imm = 0x72D18
	addq	%r8, %rcx
	movq	%r15, %r8
	andq	$-2097152, %r15                 # imm = 0xFFE00000
	subq	%r15, %rcx
	imulq	$654183, %rsi, %rax             # imm = 0x9FB67
	addq	64(%rsp), %rax                  # 8-byte Folded Reload
	andq	$-2097152, %r13                 # imm = 0xFFE00000
	subq	%r13, %rax
	sarq	$21, %r8
	addq	%r8, %rax
	imulq	$-997805, %rsi, %r8             # imm = 0xFFF0C653
	addq	%rbx, %r8
	movq	%rdi, %rbx
	andq	$-2097152, %rdi                 # imm = 0xFFE00000
	subq	%rdi, %r8
	imulq	$136657, %rsi, %r15             # imm = 0x215D1
	addq	8(%rsp), %r15                   # 8-byte Folded Reload
	andq	$-2097152, %rbp                 # imm = 0xFFE00000
	subq	%rbp, %r15
	sarq	$21, %rbx
	addq	%rbx, %r15
	imulq	$-683901, %rsi, %rdi            # imm = 0xFFF59083
	addq	56(%rsp), %rdi                  # 8-byte Folded Reload
	andq	$-2097152, %rdx                 # imm = 0xFFE00000
	subq	%rdx, %rdi
	movq	%r10, %rsi
	sarq	$21, %rsi
	addq	%rcx, %rsi
	movq	%rsi, %rdx
	sarq	$21, %rdx
	addq	%rax, %rdx
	movq	%rdx, %rbx
	sarq	$21, %rbx
	addq	%r8, %rbx
	movq	%rbx, %r8
	sarq	$21, %r8
	addq	%r15, %r8
	movq	%r8, %r13
	sarq	$21, %r13
	addq	%rdi, %r13
	movq	%r13, %rdi
	sarq	$21, %rdi
	addq	%r12, %rdi
	movq	%rdi, %r15
	sarq	$21, %r15
	addq	%r11, %r15
	movq	%r15, %r12
	sarq	$21, %r12
	addq	%r9, %r12
	movq	%r12, %rbp
	sarq	$21, %rbp
	addq	48(%rsp), %rbp                  # 8-byte Folded Reload
	andq	$-2097152, %r14                 # imm = 0xFFE00000
	movq	32(%rsp), %rcx                  # 8-byte Reload
	sarq	$21, %rcx
	andl	$2097151, %r10d                 # imm = 0x1FFFFF
	andl	$2097151, %esi                  # imm = 0x1FFFFF
	andl	$2097151, %edx                  # imm = 0x1FFFFF
	andl	$2097151, %ebx                  # imm = 0x1FFFFF
	andl	$2097151, %r8d                  # imm = 0x1FFFFF
	movq	(%rsp), %r9                     # 8-byte Reload
	subq	%r14, %r9
	movq	%rbp, %rax
	sarq	$21, %rax
	addq	%rcx, %r9
	addq	%rax, %r9
	movq	%r9, %rcx
	movq	%r9, %r11
	sarq	$21, %rcx
	addq	40(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rcx, %r9
	sarq	$21, %r9
	imulq	$666643, %r9, %rax              # imm = 0xA2C13
	addq	%r10, %rax
	imulq	$470296, %r9, %r10              # imm = 0x72D18
	addq	%rsi, %r10
	imulq	$654183, %r9, %rsi              # imm = 0x9FB67
	addq	%rdx, %rsi
	imulq	$-997805, %r9, %rdx             # imm = 0xFFF0C653
	addq	%rbx, %rdx
	imulq	$136657, %r9, %rbx              # imm = 0x215D1
	addq	%r8, %rbx
	andl	$2097151, %r13d                 # imm = 0x1FFFFF
	andl	$2097151, %edi                  # imm = 0x1FFFFF
	andl	$2097151, %r15d                 # imm = 0x1FFFFF
	andl	$2097151, %r12d                 # imm = 0x1FFFFF
	andl	$2097151, %ebp                  # imm = 0x1FFFFF
	andl	$2097151, %r11d                 # imm = 0x1FFFFF
	movq	%r11, (%rsp)                    # 8-byte Spill
	andl	$2097151, %ecx                  # imm = 0x1FFFFF
	imulq	$-683901, %r9, %r8              # imm = 0xFFF59083
	addq	%r13, %r8
	movq	%rax, %r13
	sarq	$21, %r13
	addq	%r10, %r13
	movq	%r13, %r14
	sarq	$21, %r14
	addq	%rsi, %r14
	movq	%r14, %r11
	sarq	$21, %r11
	addq	%rdx, %r11
	movq	%r11, %r10
	sarq	$21, %r10
	addq	%rbx, %r10
	movq	%r10, %r9
	sarq	$21, %r9
	addq	%r8, %r9
	movq	%r9, %r8
	sarq	$21, %r8
	addq	%rdi, %r8
	movq	%r8, %rdi
	sarq	$21, %rdi
	addq	%r15, %rdi
	movq	%rdi, %rbx
	sarq	$21, %rbx
	addq	%r12, %rbx
	movq	%rbx, %rsi
	sarq	$21, %rsi
	addq	%rbp, %rsi
	movq	%rsi, %rdx
	sarq	$21, %rdx
	addq	(%rsp), %rdx                    # 8-byte Folded Reload
	movq	%rdx, %r15
	sarq	$21, %r15
	addq	%rcx, %r15
	movq	568(%rsp), %rbp                 # 8-byte Reload
	movb	%al, 32(%rbp)
	movb	%ah, 33(%rbp)
	shrl	$16, %eax
	andl	$31, %eax
	movl	%r13d, %ecx
	shll	$5, %ecx
	orl	%eax, %ecx
	movb	%cl, 34(%rbp)
	movq	%r13, %rax
	shrq	$3, %rax
	movb	%al, 35(%rbp)
	movq	%r13, %rax
	shrq	$11, %rax
	movb	%al, 36(%rbp)
	shrl	$19, %r13d
	andl	$3, %r13d
	leal	(%r13,%r14,4), %eax
	movb	%al, 37(%rbp)
	movq	%r14, %rax
	shrq	$6, %rax
	movb	%al, 38(%rbp)
	movl	%r11d, %eax
	shll	$7, %eax
	shrl	$14, %r14d
	andl	$127, %r14d
	orl	%eax, %r14d
	movb	%r14b, 39(%rbp)
	movq	%r11, %rax
	shrq	%rax
	movb	%al, 40(%rbp)
	movq	%r11, %rax
	shrq	$9, %rax
	movb	%al, 41(%rbp)
	movl	%r10d, %eax
	shll	$4, %eax
	shrl	$17, %r11d
	andl	$15, %r11d
	orl	%eax, %r11d
	movb	%r11b, 42(%rbp)
	movq	%r10, %rax
	shrq	$4, %rax
	movb	%al, 43(%rbp)
	movq	%r10, %rax
	shrq	$12, %rax
	movb	%al, 44(%rbp)
	shrl	$20, %r10d
	andl	$1, %r10d
	leal	(%r10,%r9,2), %eax
	movb	%al, 45(%rbp)
	movq	%r9, %rax
	shrq	$7, %rax
	movb	%al, 46(%rbp)
	movl	%r8d, %eax
	shll	$6, %eax
	shrl	$15, %r9d
	andl	$63, %r9d
	orl	%eax, %r9d
	movb	%r9b, 47(%rbp)
	movq	%r8, %rax
	shrq	$2, %rax
	movb	%al, 48(%rbp)
	movq	%r8, %rax
	shrq	$10, %rax
	movb	%al, 49(%rbp)
	shrl	$18, %r8d
	andl	$7, %r8d
	leal	(%r8,%rdi,8), %eax
	movb	%al, 50(%rbp)
	movq	%rdi, %rax
	shrq	$5, %rax
	movb	%al, 51(%rbp)
	shrq	$13, %rdi
	movb	%dil, 52(%rbp)
	movb	%bl, 53(%rbp)
	movb	%bh, 54(%rbp)
	shrl	$16, %ebx
	andl	$31, %ebx
	movl	%esi, %eax
	shll	$5, %eax
	orl	%ebx, %eax
	movb	%al, 55(%rbp)
	movq	%rsi, %rax
	shrq	$3, %rax
	movb	%al, 56(%rbp)
	movq	%rsi, %rax
	shrq	$11, %rax
	movb	%al, 57(%rbp)
	shrl	$19, %esi
	andl	$3, %esi
	leal	(%rsi,%rdx,4), %eax
	movb	%al, 58(%rbp)
	movq	%rdx, %rax
	shrq	$6, %rax
	movb	%al, 59(%rbp)
	movl	%r15d, %eax
	shll	$7, %eax
	shrl	$14, %edx
	andl	$127, %edx
	orl	%eax, %edx
	movb	%dl, 60(%rbp)
	movq	%r15, %rax
	shrq	%rax
	movb	%al, 61(%rbp)
	movq	%r15, %rax
	shrq	$9, %rax
	movb	%al, 62(%rbp)
	shrq	$17, %r15
	movb	%r15b, 63(%rbp)
	movl	$1, %eax
	addq	$1048, %rsp                     # imm = 0x418
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end118:
	.size	ED25519_sign, .Lfunc_end118-ED25519_sign
                                        # -- End function
	.globl	ED25519_verify                  # -- Begin function ED25519_verify
	.p2align	4, 0x90
	.type	ED25519_verify,@function
ED25519_verify:                         # @ED25519_verify
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$3048, %rsp                     # imm = 0xBE8
	xorl	%ebp, %ebp
	cmpb	$31, 63(%rdx)
	ja	.LBB119_170
# %bb.1:
	movq	%rcx, %r12
	movq	%rdx, %r13
	movq	%rsi, %rbx
	movq	%rdi, %r14
	leaq	328(%rsp), %rdi
	movq	%rcx, %rsi
	callq	x25519_ge_frombytes_vartime
	testl	%eax, %eax
	je	.LBB119_170
# %bb.2:
	movabsq	$4503599627370494, %r11         # imm = 0xFFFFFFFFFFFFE
	leaq	-36(%r11), %rax
	movq	%rax, %r8
	subq	328(%rsp), %r8
	movq	%r11, %rcx
	subq	336(%rsp), %rcx
	movq	%r11, %rsi
	subq	344(%rsp), %rsi
	movabsq	$2251799813685247, %r15         # imm = 0x7FFFFFFFFFFFF
	movq	%r11, %rdi
	subq	352(%rsp), %rdi
	movq	%r11, %r9
	subq	360(%rsp), %r9
	movq	%r8, %rdx
	shrq	$51, %rdx
	addq	%rcx, %rdx
	movq	%rdx, %rcx
	shrq	$51, %rcx
	addq	%rsi, %rcx
	movq	%rcx, %rsi
	shrq	$51, %rsi
	addq	%rdi, %rsi
	movq	%rsi, %rdi
	shrq	$51, %rdi
	addq	%r9, %rdi
	andq	%r15, %r8
	movq	%rdi, %r9
	shrq	$51, %r9
	leaq	(%r9,%r9,8), %r10
	leaq	(%r9,%r10,2), %r9
	addq	%r8, %r9
	movq	%r9, %r8
	shrq	$51, %r8
	andq	%r15, %rdx
	addq	%r8, %rdx
	andq	%r15, %r9
	movq	%rdx, %r8
	andq	%r15, %r8
	shrq	$51, %rdx
	andq	%r15, %rcx
	addq	%rdx, %rcx
	andq	%r15, %rsi
	andq	%r15, %rdi
	movq	%r9, 328(%rsp)
	movq	%r8, 336(%rsp)
	movq	%rcx, 344(%rsp)
	movq	%rsi, 352(%rsp)
	movq	%rdi, 360(%rsp)
	subq	448(%rsp), %rax
	movq	%r11, %rdx
	subq	456(%rsp), %rdx
	movq	%r11, %rdi
	subq	464(%rsp), %rdi
	movq	%r11, %r8
	subq	472(%rsp), %r8
	movabsq	$1152921504606846976, %rcx      # imm = 0x1000000000000000
	movq	%r11, %r9
	subq	480(%rsp), %r9
	movq	%rax, %rsi
	shrq	$51, %rsi
	addq	%rdx, %rsi
	movq	%rsi, %rdx
	shrq	$51, %rdx
	addq	%rdi, %rdx
	movq	%rdx, %rdi
	shrq	$51, %rdi
	addq	%r8, %rdi
	movq	%rdi, %r8
	shrq	$51, %r8
	addq	%r9, %r8
	andq	%r15, %rax
	movq	%r8, %r9
	shrq	$51, %r9
	leaq	(%r9,%r9,8), %r10
	leaq	(%r9,%r10,2), %r9
	addq	%rax, %r9
	movq	%r9, %rax
	shrq	$51, %rax
	andq	%r15, %rsi
	addq	%rax, %rsi
	andq	%r15, %r9
	movq	%rsi, %rax
	andq	%r15, %rax
	shrq	$51, %rsi
	andq	%r15, %rdx
	addq	%rsi, %rdx
	andq	%r15, %rdi
	andq	%r15, %r8
	movq	%r9, 448(%rsp)
	movq	%rax, 456(%rsp)
	movq	%rdx, 464(%rsp)
	movq	%rdi, 472(%rsp)
	movq	%r8, 480(%rsp)
	movups	(%r13), %xmm3
	movups	16(%r13), %xmm2
	movdqu	32(%r13), %xmm0
	movdqu	48(%r13), %xmm1
	movdqa	%xmm1, 512(%rsp)
	movdqa	%xmm0, 496(%rsp)
	xorl	%ebp, %ebp
	cmpq	%rcx, 520(%rsp)
	ja	.LBB119_170
# %bb.3:
	jne	.LBB119_8
# %bb.4:
	cmpq	$0, 512(%rsp)
	jne	.LBB119_170
# %bb.5:
	movabsq	$1503914060200516822, %rax      # imm = 0x14DEF9DEA2F79CD6
	cmpq	%rax, 504(%rsp)
	ja	.LBB119_170
# %bb.6:
	jne	.LBB119_8
# %bb.7:
	movabsq	$6346243789798364140, %rax      # imm = 0x5812631A5CF5D3EC
	cmpq	%rax, 496(%rsp)
	ja	.LBB119_170
.LBB119_8:
	movabsq	$7640891576956012808, %rax      # imm = 0x6A09E667F3BCC908
	movq	%rax, 1040(%rsp)
	movabsq	$-4942790177534073029, %rax     # imm = 0xBB67AE8584CAA73B
	movq	%rax, 1048(%rsp)
	movabsq	$4354685564936845355, %rax      # imm = 0x3C6EF372FE94F82B
	movq	%rax, 1056(%rsp)
	movabsq	$-6534734903238641935, %rax     # imm = 0xA54FF53A5F1D36F1
	movq	%rax, 1064(%rsp)
	movabsq	$5840696475078001361, %rax      # imm = 0x510E527FADE682D1
	movq	%rax, 1072(%rsp)
	movabsq	$-7276294671716946913, %rax     # imm = 0x9B05688C2B3E6C1F
	movq	%rax, 1080(%rsp)
	movabsq	$2270897969802886507, %rax      # imm = 0x1F83D9ABFB41BD6B
	movq	%rax, 1088(%rsp)
	movabsq	$6620516959819538809, %rax      # imm = 0x5BE0CD19137E2179
	movq	%rax, 1096(%rsp)
	movq	$0, 1112(%rsp)
	movl	$64, 1252(%rsp)
	leaq	1120(%rsp), %r15
	movups	(%r13), %xmm0
	movups	16(%r13), %xmm1
	movups	%xmm0, 1120(%rsp)
	movups	%xmm1, 1136(%rsp)
	movq	$512, 1104(%rsp)                # imm = 0x200
	movups	(%r12), %xmm0
	movups	16(%r12), %xmm1
	movups	%xmm0, 1152(%rsp)
	movups	%xmm1, 1168(%rsp)
	movl	$64, 1248(%rsp)
	testq	%rbx, %rbx
	movaps	%xmm2, 1520(%rsp)               # 16-byte Spill
	movaps	%xmm3, 1504(%rsp)               # 16-byte Spill
	je	.LBB119_9
# %bb.10:
	leaq	(,%rbx,8), %rax
	leaq	512(,%rbx,8), %rcx
	movq	%rbx, %rdx
	shrq	$61, %rdx
	cmpq	$-512, %rax                     # imm = 0xFE00
	sbbq	$-1, %rdx
	movq	%rdx, 1112(%rsp)
	movq	%rcx, 1104(%rsp)
	leaq	1184(%rsp), %rdi
	cmpq	$63, %rbx
	ja	.LBB119_12
# %bb.11:
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	memcpy@PLT
	addl	1248(%rsp), %ebx
	jmp	.LBB119_17
.LBB119_9:
	movl	1252(%rsp), %r14d
	movb	$-128, 1184(%rsp)
	movl	$65, %edi
	jmp	.LBB119_23
.LBB119_12:
	movups	(%r14), %xmm0
	movups	16(%r14), %xmm1
	movups	32(%r14), %xmm2
	movups	48(%r14), %xmm3
	movups	%xmm3, 48(%rdi)
	movups	%xmm2, 32(%rdi)
	movups	%xmm1, 16(%rdi)
	movups	%xmm0, (%rdi)
	movl	$0, 1248(%rsp)
	leaq	-64(%rbx), %r12
	leaq	64(%r14), %r13
	leaq	1040(%rsp), %rdi
	movl	$1, %edx
	movq	%r15, %rsi
	callq	sha512_block_data_order
	cmpq	$128, %r12
	jb	.LBB119_14
# %bb.13:
	movq	%r12, %rdx
	shrq	$7, %rdx
	leaq	1040(%rsp), %rdi
	movq	%r13, %rsi
	callq	sha512_block_data_order
	addq	%rbx, %r14
	andl	$127, %r12d
	subq	%r12, %r14
	movq	%r14, %r13
.LBB119_14:
	testq	%r12, %r12
	je	.LBB119_15
# %bb.16:
	movq	%r15, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	memcpy@PLT
	movl	%r12d, %ebx
.LBB119_17:
	movl	%ebx, 1248(%rsp)
.LBB119_18:
	movl	1252(%rsp), %r14d
	movl	%ebx, %eax
	movb	$-128, 1120(%rsp,%rax)
	leaq	1(%rax), %rdi
	cmpl	$112, %ebx
	jb	.LBB119_22
# %bb.19:
	cmpl	$127, %eax
	je	.LBB119_21
# %bb.20:
	movl	$127, %edx
	subq	%rax, %rdx
	addq	%r15, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB119_21:
	leaq	1040(%rsp), %rdi
	movl	$1, %edx
	movq	%r15, %rsi
	callq	sha512_block_data_order
	xorl	%edi, %edi
	jmp	.LBB119_23
.LBB119_22:
	cmpq	$112, %rdi
	je	.LBB119_24
.LBB119_23:
	movl	$112, %edx
	subq	%rdi, %rdx
	addq	%r15, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
.LBB119_24:
	movq	1104(%rsp), %rax
	movq	1112(%rsp), %rcx
	bswapq	%rcx
	movq	%rcx, 1232(%rsp)
	bswapq	%rax
	movq	%rax, 1240(%rsp)
	leaq	1040(%rsp), %rdi
	movl	$1, %edx
	movq	%r15, %rsi
	callq	sha512_block_data_order
	cmpl	$8, %r14d
	jb	.LBB119_32
# %bb.25:
	shrl	$3, %r14d
	leaq	-1(%r14), %rcx
	movl	%r14d, %eax
	andl	$3, %eax
	cmpq	$3, %rcx
	jae	.LBB119_27
# %bb.26:
	leaq	2816(%rsp), %rcx
	xorl	%edx, %edx
	jmp	.LBB119_29
.LBB119_27:
	andl	$-4, %r14d
	leaq	2816(%rsp), %rcx
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB119_28:                             # =>This Inner Loop Header: Depth=1
	movq	1040(%rsp,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, (%rcx)
	movq	1048(%rsp,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, 8(%rcx)
	movq	1056(%rsp,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, 16(%rcx)
	movq	1064(%rsp,%rdx,8), %rsi
	bswapq	%rsi
	movq	%rsi, 24(%rcx)
	addq	$32, %rcx
	addq	$4, %rdx
	cmpq	%rdx, %r14
	jne	.LBB119_28
.LBB119_29:
	testq	%rax, %rax
	je	.LBB119_32
# %bb.30:                               # %.preheader16
	leaq	(%rsp,%rdx,8), %rdx
	addq	$1040, %rdx                     # imm = 0x410
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB119_31:                             # =>This Inner Loop Header: Depth=1
	movq	(%rdx,%rsi,8), %rdi
	bswapq	%rdi
	movq	%rdi, (%rcx,%rsi,8)
	incq	%rsi
	cmpq	%rsi, %rax
	jne	.LBB119_31
.LBB119_32:
	leaq	448(%rsp), %rbx
	leaq	2816(%rsp), %rdi
	callq	x25519_sc_reduce
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB119_33:                             # =>This Inner Loop Header: Depth=1
	movl	%eax, %ecx
	shrl	$3, %ecx
	movl	%eax, %edx
	andl	$6, %edx
	movzbl	2816(%rsp,%rcx), %ecx
	btl	%edx, %ecx
	setb	784(%rsp,%rax)
	leal	1(%rax), %edx
	movzbl	%dl, %edx
	andl	$7, %edx
	btl	%edx, %ecx
	setb	785(%rsp,%rax)
	addq	$2, %rax
	cmpq	$256, %rax                      # imm = 0x100
	jne	.LBB119_33
# %bb.34:                               # %.preheader15
	movl	$1, %eax
	movl	$2, %ecx
	movl	$3, %edx
	movl	$4, %esi
	movl	$5, %edi
	xorl	%r8d, %r8d
	jmp	.LBB119_35
.LBB119_15:
	movl	1248(%rsp), %ebx
	jmp	.LBB119_18
.LBB119_89:                             #   in Loop: Header=BB119_35 Depth=1
	movb	%r11b, 784(%rsp,%r8)
	movb	$0, 789(%rsp,%rax)
	.p2align	4, 0x90
.LBB119_90:                             #   in Loop: Header=BB119_35 Depth=1
	incq	%r8
	incq	%rax
	incq	%rcx
	incq	%rdx
	incq	%rsi
	incq	%rdi
	cmpq	$256, %r8                       # imm = 0x100
	je	.LBB119_91
.LBB119_35:                             # =>This Loop Header: Depth=1
                                        #     Child Loop BB119_42 Depth 2
                                        #     Child Loop BB119_50 Depth 2
                                        #     Child Loop BB119_59 Depth 2
                                        #     Child Loop BB119_68 Depth 2
                                        #     Child Loop BB119_77 Depth 2
                                        #     Child Loop BB119_86 Depth 2
	cmpb	$0, 784(%rsp,%r8)
	je	.LBB119_90
# %bb.36:                               #   in Loop: Header=BB119_35 Depth=1
	cmpq	$254, %r8
	ja	.LBB119_90
# %bb.37:                               #   in Loop: Header=BB119_35 Depth=1
	movsbl	784(%rsp,%rax), %r10d
	testl	%r10d, %r10d
	je	.LBB119_45
# %bb.38:                               #   in Loop: Header=BB119_35 Depth=1
	movsbl	784(%rsp,%r8), %r9d
	leal	(%r9,%r10,2), %r11d
	cmpl	$15, %r11d
	jg	.LBB119_40
# %bb.39:                               #   in Loop: Header=BB119_35 Depth=1
	movb	%r11b, 784(%rsp,%r8)
	movb	$0, 784(%rsp,%rax)
	cmpq	$253, %r8
	ja	.LBB119_90
	jmp	.LBB119_46
.LBB119_40:                             #   in Loop: Header=BB119_35 Depth=1
	addl	%r10d, %r10d
	subl	%r10d, %r9d
	cmpl	$-15, %r9d
	jl	.LBB119_90
# %bb.41:                               #   in Loop: Header=BB119_35 Depth=1
	movb	%r9b, 784(%rsp,%r8)
	movq	%r8, %r9
	.p2align	4, 0x90
.LBB119_42:                             #   Parent Loop BB119_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, 785(%rsp,%r9)
	je	.LBB119_43
# %bb.44:                               #   in Loop: Header=BB119_42 Depth=2
	movb	$0, 785(%rsp,%r9)
	incq	%r9
	cmpq	$255, %r9
	jb	.LBB119_42
	.p2align	4, 0x90
.LBB119_45:                             #   in Loop: Header=BB119_35 Depth=1
	cmpq	$253, %r8
	ja	.LBB119_90
.LBB119_46:                             #   in Loop: Header=BB119_35 Depth=1
	movsbl	785(%rsp,%rax), %r10d
	testl	%r10d, %r10d
	je	.LBB119_54
# %bb.47:                               #   in Loop: Header=BB119_35 Depth=1
	movsbl	784(%rsp,%r8), %r9d
	leal	(%r9,%r10,4), %r11d
	cmpl	$16, %r11d
	jge	.LBB119_48
# %bb.53:                               #   in Loop: Header=BB119_35 Depth=1
	movb	%r11b, 784(%rsp,%r8)
	movb	$0, 785(%rsp,%rax)
	cmpq	$252, %r8
	ja	.LBB119_90
	jmp	.LBB119_55
.LBB119_48:                             #   in Loop: Header=BB119_35 Depth=1
	shll	$2, %r10d
	subl	%r10d, %r9d
	cmpl	$-15, %r9d
	jl	.LBB119_90
# %bb.49:                               #   in Loop: Header=BB119_35 Depth=1
	movb	%r9b, 784(%rsp,%r8)
	movq	%rax, %r9
	.p2align	4, 0x90
.LBB119_50:                             #   Parent Loop BB119_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, 785(%rsp,%r9)
	je	.LBB119_52
# %bb.51:                               #   in Loop: Header=BB119_50 Depth=2
	movb	$0, 785(%rsp,%r9)
	incq	%r9
	cmpq	$255, %r9
	jb	.LBB119_50
.LBB119_54:                             #   in Loop: Header=BB119_35 Depth=1
	cmpq	$252, %r8
	ja	.LBB119_90
.LBB119_55:                             #   in Loop: Header=BB119_35 Depth=1
	movsbl	786(%rsp,%rax), %r10d
	testl	%r10d, %r10d
	je	.LBB119_63
# %bb.56:                               #   in Loop: Header=BB119_35 Depth=1
	movsbl	784(%rsp,%r8), %r9d
	leal	(%r9,%r10,8), %r11d
	cmpl	$16, %r11d
	jge	.LBB119_57
# %bb.62:                               #   in Loop: Header=BB119_35 Depth=1
	movb	%r11b, 784(%rsp,%r8)
	movb	$0, 786(%rsp,%rax)
	jmp	.LBB119_63
.LBB119_43:                             #   in Loop: Header=BB119_35 Depth=1
	movb	$1, 785(%rsp,%r9)
	cmpq	$253, %r8
	ja	.LBB119_90
	jmp	.LBB119_46
.LBB119_57:                             #   in Loop: Header=BB119_35 Depth=1
	shll	$3, %r10d
	subl	%r10d, %r9d
	cmpl	$-15, %r9d
	jl	.LBB119_90
# %bb.58:                               #   in Loop: Header=BB119_35 Depth=1
	movb	%r9b, 784(%rsp,%r8)
	movq	%rcx, %r9
	.p2align	4, 0x90
.LBB119_59:                             #   Parent Loop BB119_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, 785(%rsp,%r9)
	je	.LBB119_61
# %bb.60:                               #   in Loop: Header=BB119_59 Depth=2
	movb	$0, 785(%rsp,%r9)
	incq	%r9
	cmpq	$255, %r9
	jb	.LBB119_59
	jmp	.LBB119_63
.LBB119_52:                             #   in Loop: Header=BB119_35 Depth=1
	movb	$1, 785(%rsp,%r9)
	cmpq	$252, %r8
	ja	.LBB119_90
	jmp	.LBB119_55
.LBB119_61:                             #   in Loop: Header=BB119_35 Depth=1
	movb	$1, 785(%rsp,%r9)
.LBB119_63:                             #   in Loop: Header=BB119_35 Depth=1
	cmpq	$251, %r8
	ja	.LBB119_90
# %bb.64:                               #   in Loop: Header=BB119_35 Depth=1
	movsbl	787(%rsp,%rax), %r10d
	testl	%r10d, %r10d
	je	.LBB119_72
# %bb.65:                               #   in Loop: Header=BB119_35 Depth=1
	movsbl	784(%rsp,%r8), %r9d
	shll	$4, %r10d
	leal	(%r10,%r9), %r11d
	cmpl	$16, %r11d
	jge	.LBB119_66
# %bb.71:                               #   in Loop: Header=BB119_35 Depth=1
	movb	%r11b, 784(%rsp,%r8)
	movb	$0, 787(%rsp,%rax)
	jmp	.LBB119_72
.LBB119_66:                             #   in Loop: Header=BB119_35 Depth=1
	subl	%r10d, %r9d
	cmpl	$-15, %r9d
	jl	.LBB119_90
# %bb.67:                               #   in Loop: Header=BB119_35 Depth=1
	movb	%r9b, 784(%rsp,%r8)
	movq	%rdx, %r9
	.p2align	4, 0x90
.LBB119_68:                             #   Parent Loop BB119_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, 785(%rsp,%r9)
	je	.LBB119_70
# %bb.69:                               #   in Loop: Header=BB119_68 Depth=2
	movb	$0, 785(%rsp,%r9)
	incq	%r9
	cmpq	$255, %r9
	jb	.LBB119_68
	jmp	.LBB119_72
.LBB119_70:                             #   in Loop: Header=BB119_35 Depth=1
	movb	$1, 785(%rsp,%r9)
.LBB119_72:                             #   in Loop: Header=BB119_35 Depth=1
	cmpq	$250, %r8
	ja	.LBB119_90
# %bb.73:                               #   in Loop: Header=BB119_35 Depth=1
	movsbl	788(%rsp,%rax), %r10d
	testl	%r10d, %r10d
	je	.LBB119_81
# %bb.74:                               #   in Loop: Header=BB119_35 Depth=1
	movsbl	784(%rsp,%r8), %r9d
	shll	$5, %r10d
	leal	(%r10,%r9), %r11d
	cmpl	$16, %r11d
	jge	.LBB119_75
# %bb.80:                               #   in Loop: Header=BB119_35 Depth=1
	movb	%r11b, 784(%rsp,%r8)
	movb	$0, 788(%rsp,%rax)
	jmp	.LBB119_81
.LBB119_75:                             #   in Loop: Header=BB119_35 Depth=1
	subl	%r10d, %r9d
	cmpl	$-15, %r9d
	jl	.LBB119_90
# %bb.76:                               #   in Loop: Header=BB119_35 Depth=1
	movb	%r9b, 784(%rsp,%r8)
	movq	%rsi, %r9
.LBB119_77:                             #   Parent Loop BB119_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, 785(%rsp,%r9)
	je	.LBB119_79
# %bb.78:                               #   in Loop: Header=BB119_77 Depth=2
	movb	$0, 785(%rsp,%r9)
	incq	%r9
	cmpq	$255, %r9
	jb	.LBB119_77
	jmp	.LBB119_81
.LBB119_79:                             #   in Loop: Header=BB119_35 Depth=1
	movb	$1, 785(%rsp,%r9)
.LBB119_81:                             #   in Loop: Header=BB119_35 Depth=1
	cmpq	$249, %r8
	ja	.LBB119_90
# %bb.82:                               #   in Loop: Header=BB119_35 Depth=1
	movsbl	789(%rsp,%rax), %r10d
	testl	%r10d, %r10d
	je	.LBB119_90
# %bb.83:                               #   in Loop: Header=BB119_35 Depth=1
	movsbl	784(%rsp,%r8), %r9d
	shll	$6, %r10d
	leal	(%r10,%r9), %r11d
	cmpl	$16, %r11d
	jl	.LBB119_89
# %bb.84:                               #   in Loop: Header=BB119_35 Depth=1
	subl	%r10d, %r9d
	cmpl	$-15, %r9d
	jl	.LBB119_90
# %bb.85:                               #   in Loop: Header=BB119_35 Depth=1
	movb	%r9b, 784(%rsp,%r8)
	movq	%rdi, %r9
.LBB119_86:                             #   Parent Loop BB119_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, 785(%rsp,%r9)
	je	.LBB119_88
# %bb.87:                               #   in Loop: Header=BB119_86 Depth=2
	movb	$0, 785(%rsp,%r9)
	incq	%r9
	cmpq	$255, %r9
	jb	.LBB119_86
	jmp	.LBB119_90
.LBB119_88:                             #   in Loop: Header=BB119_35 Depth=1
	movb	$1, 785(%rsp,%r9)
	jmp	.LBB119_90
.LBB119_91:                             # %.preheader8
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB119_92:                             # =>This Inner Loop Header: Depth=1
	movl	%eax, %ecx
	shrl	$3, %ecx
	movl	%eax, %edx
	andl	$6, %edx
	movzbl	496(%rsp,%rcx), %ecx
	btl	%edx, %ecx
	setb	528(%rsp,%rax)
	leal	1(%rax), %edx
	movzbl	%dl, %edx
	andl	$7, %edx
	btl	%edx, %ecx
	setb	529(%rsp,%rax)
	addq	$2, %rax
	cmpq	$256, %rax                      # imm = 0x100
	jne	.LBB119_92
# %bb.93:                               # %.preheader
	movl	$1, %eax
	movl	$2, %ecx
	movl	$3, %edx
	movl	$4, %esi
	movl	$5, %edi
	xorl	%r8d, %r8d
	jmp	.LBB119_94
.LBB119_148:                            #   in Loop: Header=BB119_94 Depth=1
	movb	%r11b, 528(%rsp,%r8)
	movb	$0, 533(%rsp,%rax)
	.p2align	4, 0x90
.LBB119_149:                            #   in Loop: Header=BB119_94 Depth=1
	incq	%r8
	incq	%rax
	incq	%rcx
	incq	%rdx
	incq	%rsi
	incq	%rdi
	cmpq	$256, %r8                       # imm = 0x100
	je	.LBB119_150
.LBB119_94:                             # =>This Loop Header: Depth=1
                                        #     Child Loop BB119_101 Depth 2
                                        #     Child Loop BB119_109 Depth 2
                                        #     Child Loop BB119_118 Depth 2
                                        #     Child Loop BB119_127 Depth 2
                                        #     Child Loop BB119_136 Depth 2
                                        #     Child Loop BB119_145 Depth 2
	cmpb	$0, 528(%rsp,%r8)
	je	.LBB119_149
# %bb.95:                               #   in Loop: Header=BB119_94 Depth=1
	cmpq	$254, %r8
	ja	.LBB119_149
# %bb.96:                               #   in Loop: Header=BB119_94 Depth=1
	movsbl	528(%rsp,%rax), %r10d
	testl	%r10d, %r10d
	je	.LBB119_104
# %bb.97:                               #   in Loop: Header=BB119_94 Depth=1
	movsbl	528(%rsp,%r8), %r9d
	leal	(%r9,%r10,2), %r11d
	cmpl	$15, %r11d
	jg	.LBB119_99
# %bb.98:                               #   in Loop: Header=BB119_94 Depth=1
	movb	%r11b, 528(%rsp,%r8)
	movb	$0, 528(%rsp,%rax)
	cmpq	$253, %r8
	ja	.LBB119_149
	jmp	.LBB119_105
.LBB119_99:                             #   in Loop: Header=BB119_94 Depth=1
	addl	%r10d, %r10d
	subl	%r10d, %r9d
	cmpl	$-15, %r9d
	jl	.LBB119_149
# %bb.100:                              #   in Loop: Header=BB119_94 Depth=1
	movb	%r9b, 528(%rsp,%r8)
	movq	%r8, %r9
	.p2align	4, 0x90
.LBB119_101:                            #   Parent Loop BB119_94 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, 529(%rsp,%r9)
	je	.LBB119_102
# %bb.103:                              #   in Loop: Header=BB119_101 Depth=2
	movb	$0, 529(%rsp,%r9)
	incq	%r9
	cmpq	$255, %r9
	jb	.LBB119_101
	.p2align	4, 0x90
.LBB119_104:                            #   in Loop: Header=BB119_94 Depth=1
	cmpq	$253, %r8
	ja	.LBB119_149
.LBB119_105:                            #   in Loop: Header=BB119_94 Depth=1
	movsbl	529(%rsp,%rax), %r10d
	testl	%r10d, %r10d
	je	.LBB119_113
# %bb.106:                              #   in Loop: Header=BB119_94 Depth=1
	movsbl	528(%rsp,%r8), %r9d
	leal	(%r9,%r10,4), %r11d
	cmpl	$16, %r11d
	jge	.LBB119_107
# %bb.112:                              #   in Loop: Header=BB119_94 Depth=1
	movb	%r11b, 528(%rsp,%r8)
	movb	$0, 529(%rsp,%rax)
	cmpq	$252, %r8
	ja	.LBB119_149
	jmp	.LBB119_114
.LBB119_107:                            #   in Loop: Header=BB119_94 Depth=1
	shll	$2, %r10d
	subl	%r10d, %r9d
	cmpl	$-15, %r9d
	jl	.LBB119_149
# %bb.108:                              #   in Loop: Header=BB119_94 Depth=1
	movb	%r9b, 528(%rsp,%r8)
	movq	%rax, %r9
	.p2align	4, 0x90
.LBB119_109:                            #   Parent Loop BB119_94 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, 529(%rsp,%r9)
	je	.LBB119_111
# %bb.110:                              #   in Loop: Header=BB119_109 Depth=2
	movb	$0, 529(%rsp,%r9)
	incq	%r9
	cmpq	$255, %r9
	jb	.LBB119_109
.LBB119_113:                            #   in Loop: Header=BB119_94 Depth=1
	cmpq	$252, %r8
	ja	.LBB119_149
.LBB119_114:                            #   in Loop: Header=BB119_94 Depth=1
	movsbl	530(%rsp,%rax), %r10d
	testl	%r10d, %r10d
	je	.LBB119_122
# %bb.115:                              #   in Loop: Header=BB119_94 Depth=1
	movsbl	528(%rsp,%r8), %r9d
	leal	(%r9,%r10,8), %r11d
	cmpl	$16, %r11d
	jge	.LBB119_116
# %bb.121:                              #   in Loop: Header=BB119_94 Depth=1
	movb	%r11b, 528(%rsp,%r8)
	movb	$0, 530(%rsp,%rax)
	jmp	.LBB119_122
.LBB119_102:                            #   in Loop: Header=BB119_94 Depth=1
	movb	$1, 529(%rsp,%r9)
	cmpq	$253, %r8
	ja	.LBB119_149
	jmp	.LBB119_105
.LBB119_116:                            #   in Loop: Header=BB119_94 Depth=1
	shll	$3, %r10d
	subl	%r10d, %r9d
	cmpl	$-15, %r9d
	jl	.LBB119_149
# %bb.117:                              #   in Loop: Header=BB119_94 Depth=1
	movb	%r9b, 528(%rsp,%r8)
	movq	%rcx, %r9
	.p2align	4, 0x90
.LBB119_118:                            #   Parent Loop BB119_94 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, 529(%rsp,%r9)
	je	.LBB119_120
# %bb.119:                              #   in Loop: Header=BB119_118 Depth=2
	movb	$0, 529(%rsp,%r9)
	incq	%r9
	cmpq	$255, %r9
	jb	.LBB119_118
	jmp	.LBB119_122
.LBB119_111:                            #   in Loop: Header=BB119_94 Depth=1
	movb	$1, 529(%rsp,%r9)
	cmpq	$252, %r8
	ja	.LBB119_149
	jmp	.LBB119_114
.LBB119_120:                            #   in Loop: Header=BB119_94 Depth=1
	movb	$1, 529(%rsp,%r9)
.LBB119_122:                            #   in Loop: Header=BB119_94 Depth=1
	cmpq	$251, %r8
	ja	.LBB119_149
# %bb.123:                              #   in Loop: Header=BB119_94 Depth=1
	movsbl	531(%rsp,%rax), %r10d
	testl	%r10d, %r10d
	je	.LBB119_131
# %bb.124:                              #   in Loop: Header=BB119_94 Depth=1
	movsbl	528(%rsp,%r8), %r9d
	shll	$4, %r10d
	leal	(%r10,%r9), %r11d
	cmpl	$16, %r11d
	jge	.LBB119_125
# %bb.130:                              #   in Loop: Header=BB119_94 Depth=1
	movb	%r11b, 528(%rsp,%r8)
	movb	$0, 531(%rsp,%rax)
	jmp	.LBB119_131
.LBB119_125:                            #   in Loop: Header=BB119_94 Depth=1
	subl	%r10d, %r9d
	cmpl	$-15, %r9d
	jl	.LBB119_149
# %bb.126:                              #   in Loop: Header=BB119_94 Depth=1
	movb	%r9b, 528(%rsp,%r8)
	movq	%rdx, %r9
	.p2align	4, 0x90
.LBB119_127:                            #   Parent Loop BB119_94 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, 529(%rsp,%r9)
	je	.LBB119_129
# %bb.128:                              #   in Loop: Header=BB119_127 Depth=2
	movb	$0, 529(%rsp,%r9)
	incq	%r9
	cmpq	$255, %r9
	jb	.LBB119_127
	jmp	.LBB119_131
.LBB119_129:                            #   in Loop: Header=BB119_94 Depth=1
	movb	$1, 529(%rsp,%r9)
.LBB119_131:                            #   in Loop: Header=BB119_94 Depth=1
	cmpq	$250, %r8
	ja	.LBB119_149
# %bb.132:                              #   in Loop: Header=BB119_94 Depth=1
	movsbl	532(%rsp,%rax), %r10d
	testl	%r10d, %r10d
	je	.LBB119_140
# %bb.133:                              #   in Loop: Header=BB119_94 Depth=1
	movsbl	528(%rsp,%r8), %r9d
	shll	$5, %r10d
	leal	(%r10,%r9), %r11d
	cmpl	$16, %r11d
	jge	.LBB119_134
# %bb.139:                              #   in Loop: Header=BB119_94 Depth=1
	movb	%r11b, 528(%rsp,%r8)
	movb	$0, 532(%rsp,%rax)
	jmp	.LBB119_140
.LBB119_134:                            #   in Loop: Header=BB119_94 Depth=1
	subl	%r10d, %r9d
	cmpl	$-15, %r9d
	jl	.LBB119_149
# %bb.135:                              #   in Loop: Header=BB119_94 Depth=1
	movb	%r9b, 528(%rsp,%r8)
	movq	%rsi, %r9
.LBB119_136:                            #   Parent Loop BB119_94 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, 529(%rsp,%r9)
	je	.LBB119_138
# %bb.137:                              #   in Loop: Header=BB119_136 Depth=2
	movb	$0, 529(%rsp,%r9)
	incq	%r9
	cmpq	$255, %r9
	jb	.LBB119_136
	jmp	.LBB119_140
.LBB119_138:                            #   in Loop: Header=BB119_94 Depth=1
	movb	$1, 529(%rsp,%r9)
.LBB119_140:                            #   in Loop: Header=BB119_94 Depth=1
	cmpq	$249, %r8
	ja	.LBB119_149
# %bb.141:                              #   in Loop: Header=BB119_94 Depth=1
	movsbl	533(%rsp,%rax), %r10d
	testl	%r10d, %r10d
	je	.LBB119_149
# %bb.142:                              #   in Loop: Header=BB119_94 Depth=1
	movsbl	528(%rsp,%r8), %r9d
	shll	$6, %r10d
	leal	(%r10,%r9), %r11d
	cmpl	$16, %r11d
	jl	.LBB119_148
# %bb.143:                              #   in Loop: Header=BB119_94 Depth=1
	subl	%r10d, %r9d
	cmpl	$-15, %r9d
	jl	.LBB119_149
# %bb.144:                              #   in Loop: Header=BB119_94 Depth=1
	movb	%r9b, 528(%rsp,%r8)
	movq	%rdi, %r9
.LBB119_145:                            #   Parent Loop BB119_94 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, 529(%rsp,%r9)
	je	.LBB119_147
# %bb.146:                              #   in Loop: Header=BB119_145 Depth=2
	movb	$0, 529(%rsp,%r9)
	incq	%r9
	cmpq	$255, %r9
	jb	.LBB119_145
	jmp	.LBB119_149
.LBB119_147:                            #   in Loop: Header=BB119_94 Depth=1
	movb	$1, 529(%rsp,%r9)
	jmp	.LBB119_149
.LBB119_150:
	movq	368(%rsp), %rsi
	movq	328(%rsp), %rdi
	movq	336(%rsp), %r8
	leaq	(%rdi,%rsi), %r9
	movq	376(%rsp), %rax
	leaq	(%r8,%rax), %r10
	movq	384(%rsp), %rcx
	movq	344(%rsp), %r11
	leaq	(%r11,%rcx), %r14
	movq	392(%rsp), %rdx
	movq	352(%rsp), %r15
	movq	%r9, 1536(%rsp)
	leaq	(%r15,%rdx), %r9
	movq	%r10, 1544(%rsp)
	movq	400(%rsp), %r10
	movq	%r14, 1552(%rsp)
	movq	360(%rsp), %r14
	movq	%r9, 1560(%rsp)
	leaq	(%r14,%r10), %r9
	movq	%r9, 1568(%rsp)
	movabsq	$4503599627370494, %rbp         # imm = 0xFFFFFFFFFFFFE
	addq	%rbp, %rsi
	addq	$-36, %rsi
	subq	%rdi, %rsi
	addq	%rbp, %rax
	subq	%r8, %rax
	addq	%rbp, %rcx
	subq	%r11, %rcx
	addq	%rbp, %rdx
	subq	%r15, %rdx
	addq	%rbp, %r10
	subq	%r14, %r10
	movq	%rsi, 1576(%rsp)
	movq	%rax, 1584(%rsp)
	movq	%rcx, 1592(%rsp)
	movq	%rdx, 1600(%rsp)
	movq	%r10, 1608(%rsp)
	movq	440(%rsp), %rax
	movq	%rax, 1648(%rsp)
	movups	408(%rsp), %xmm0
	movups	424(%rsp), %xmm1
	movaps	%xmm1, 1632(%rsp)
	movaps	%xmm0, 1616(%rsp)
	leaq	1656(%rsp), %rdi
	leaq	d2(%rip), %rdx
	movq	%rbx, %rsi
	callq	fe_mul_impl
	movq	360(%rsp), %rax
	movq	%rax, 32(%rsp)
	movups	328(%rsp), %xmm0
	movups	344(%rsp), %xmm1
	movaps	%xmm1, 16(%rsp)
	movaps	%xmm0, (%rsp)
	movups	368(%rsp), %xmm0
	movups	%xmm0, 40(%rsp)
	movups	384(%rsp), %xmm0
	movups	%xmm0, 56(%rsp)
	movq	400(%rsp), %rax
	movq	%rax, 72(%rsp)
	movups	408(%rsp), %xmm0
	movaps	%xmm0, 80(%rsp)
	movups	424(%rsp), %xmm0
	movaps	%xmm0, 96(%rsp)
	movq	440(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	160(%rsp), %rbx
	movq	%rsp, %rsi
	movq	%rbx, %rdi
	callq	ge_p2_dbl
	leaq	280(%rsp), %r13
	leaq	2888(%rsp), %r14
	movq	%r14, %rdi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	2928(%rsp), %rdi
	leaq	200(%rsp), %r15
	leaq	240(%rsp), %r12
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	fe_mul_impl
	leaq	2968(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	3008(%rsp), %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	leaq	1536(%rsp), %rdx
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	x25519_ge_add
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	40(%rsp), %rdi
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	fe_mul_impl
	leaq	80(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	120(%rsp), %r12
	movq	%r12, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	movq	40(%rsp), %rsi
	movq	(%rsp), %rdi
	movq	8(%rsp), %r8
	leaq	(%rdi,%rsi), %r9
	movq	48(%rsp), %rax
	leaq	(%r8,%rax), %r10
	movq	56(%rsp), %rcx
	movq	16(%rsp), %r11
	leaq	(%r11,%rcx), %r14
	movq	64(%rsp), %rdx
	movq	24(%rsp), %r13
	movq	%r9, 1696(%rsp)
	leaq	(%r13,%rdx), %r9
	movq	%r10, 1704(%rsp)
	movq	72(%rsp), %r10
	movq	%r14, 1712(%rsp)
	movq	32(%rsp), %r14
	movq	%r9, 1720(%rsp)
	leaq	(%r14,%r10), %r9
	movq	%r9, 1728(%rsp)
	addq	%rbp, %rsi
	addq	$-36, %rsi
	subq	%rdi, %rsi
	addq	%rbp, %rax
	subq	%r8, %rax
	addq	%rbp, %rcx
	subq	%r11, %rcx
	addq	%rbp, %rdx
	subq	%r13, %rdx
	addq	%rbp, %r10
	subq	%r14, %r10
	movq	%rsi, 1736(%rsp)
	movq	%rax, 1744(%rsp)
	movq	%rcx, 1752(%rsp)
	movq	%rdx, 1760(%rsp)
	leaq	1696(%rsp), %r13
	movq	%r10, 1768(%rsp)
	movq	112(%rsp), %rax
	movq	%rax, 1808(%rsp)
	movups	80(%rsp), %xmm0
	movups	96(%rsp), %xmm1
	movaps	%xmm1, 1792(%rsp)
	movaps	%xmm0, 1776(%rsp)
	leaq	1816(%rsp), %rdi
	movq	%r12, %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	movq	%rbx, %rdi
	leaq	2888(%rsp), %rsi
	movq	%r13, %rdx
	callq	x25519_ge_add
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	movq	%rbx, %r13
	leaq	280(%rsp), %rbx
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	40(%rsp), %rdi
	movq	%r15, %rsi
	leaq	240(%rsp), %r14
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	80(%rsp), %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	%r12, %rdi
	movq	%r12, %rbx
	movq	%r13, %rsi
	movq	%r13, %r12
	movq	%r15, %rdx
	callq	fe_mul_impl
	movq	40(%rsp), %rsi
	movq	(%rsp), %rdi
	movq	8(%rsp), %r8
	leaq	(%rdi,%rsi), %r9
	movq	48(%rsp), %rax
	leaq	(%r8,%rax), %r10
	movq	56(%rsp), %rcx
	movq	16(%rsp), %r11
	leaq	(%r11,%rcx), %r14
	movq	64(%rsp), %rdx
	movq	24(%rsp), %r13
	movq	%r9, 1856(%rsp)
	leaq	(%r13,%rdx), %r9
	movq	%r10, 1864(%rsp)
	movq	72(%rsp), %r10
	movq	%r14, 1872(%rsp)
	movq	32(%rsp), %r14
	movq	%r9, 1880(%rsp)
	leaq	(%r14,%r10), %r9
	movq	%r9, 1888(%rsp)
	addq	%rbp, %rsi
	addq	$-36, %rsi
	subq	%rdi, %rsi
	addq	%rbp, %rax
	subq	%r8, %rax
	addq	%rbp, %rcx
	subq	%r11, %rcx
	addq	%rbp, %rdx
	subq	%r13, %rdx
	addq	%rbp, %r10
	subq	%r14, %r10
	movq	%rsi, 1896(%rsp)
	movq	%rax, 1904(%rsp)
	movq	%rcx, 1912(%rsp)
	movq	%rdx, 1920(%rsp)
	leaq	1856(%rsp), %r13
	movq	%r10, 1928(%rsp)
	movq	112(%rsp), %rax
	movq	%rax, 1968(%rsp)
	movups	80(%rsp), %xmm0
	movups	96(%rsp), %xmm1
	movaps	%xmm1, 1952(%rsp)
	movaps	%xmm0, 1936(%rsp)
	leaq	1976(%rsp), %rdi
	movq	%rbx, %r14
	movq	%rbx, %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	movq	%r12, %rdi
	leaq	2888(%rsp), %rsi
	movq	%r13, %rdx
	callq	x25519_ge_add
	movq	%rsp, %rdi
	movq	%r12, %rsi
	leaq	280(%rsp), %r13
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	40(%rsp), %rdi
	movq	%r15, %rbx
	movq	%r15, %rsi
	leaq	240(%rsp), %r15
	movq	%r15, %rdx
	callq	fe_mul_impl
	leaq	80(%rsp), %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	movq	%r14, %rdi
	movq	%r14, %r15
	movq	%r12, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	40(%rsp), %rsi
	movq	(%rsp), %rdi
	movq	8(%rsp), %r8
	leaq	(%rdi,%rsi), %r9
	movq	48(%rsp), %rax
	leaq	(%r8,%rax), %r10
	movq	56(%rsp), %rcx
	movq	16(%rsp), %r11
	leaq	(%r11,%rcx), %r14
	movq	64(%rsp), %rdx
	movq	24(%rsp), %r13
	movq	%r9, 2016(%rsp)
	leaq	(%r13,%rdx), %r9
	movq	%r10, 2024(%rsp)
	movq	72(%rsp), %r10
	movq	%r14, 2032(%rsp)
	movq	32(%rsp), %r14
	movq	%r9, 2040(%rsp)
	leaq	(%r14,%r10), %r9
	movq	%r9, 2048(%rsp)
	addq	%rbp, %rsi
	addq	$-36, %rsi
	subq	%rdi, %rsi
	addq	%rbp, %rax
	subq	%r8, %rax
	addq	%rbp, %rcx
	subq	%r11, %rcx
	addq	%rbp, %rdx
	subq	%r13, %rdx
	addq	%rbp, %r10
	subq	%r14, %r10
	movq	%rsi, 2056(%rsp)
	movq	%rax, 2064(%rsp)
	movq	%rcx, 2072(%rsp)
	movq	%rdx, 2080(%rsp)
	leaq	2016(%rsp), %r14
	movq	%r10, 2088(%rsp)
	movq	112(%rsp), %rax
	movq	%rax, 2128(%rsp)
	movups	80(%rsp), %xmm0
	movups	96(%rsp), %xmm1
	movaps	%xmm1, 2112(%rsp)
	movaps	%xmm0, 2096(%rsp)
	leaq	2136(%rsp), %rdi
	movq	%r15, %r13
	movq	%r15, %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	movq	%r12, %rdi
	leaq	2888(%rsp), %rsi
	movq	%r14, %rdx
	callq	x25519_ge_add
	movq	%rsp, %rdi
	movq	%r12, %rsi
	leaq	280(%rsp), %r15
	movq	%r15, %rdx
	callq	fe_mul_impl
	leaq	40(%rsp), %rdi
	movq	%rbx, %r14
	movq	%rbx, %rsi
	leaq	240(%rsp), %rbx
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	80(%rsp), %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	movq	%r13, %rdi
	movq	%r13, %rbx
	movq	%r12, %rsi
	movq	%r12, %r15
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	40(%rsp), %rsi
	movq	(%rsp), %rdi
	movq	8(%rsp), %r8
	leaq	(%rdi,%rsi), %r9
	movq	48(%rsp), %rax
	leaq	(%r8,%rax), %r10
	movq	56(%rsp), %rcx
	movq	16(%rsp), %r11
	leaq	(%r11,%rcx), %r14
	movq	64(%rsp), %rdx
	movq	24(%rsp), %r13
	movq	%r9, 2176(%rsp)
	leaq	(%r13,%rdx), %r9
	movq	%r10, 2184(%rsp)
	movq	72(%rsp), %r10
	movq	%r14, 2192(%rsp)
	movq	32(%rsp), %r14
	movq	%r9, 2200(%rsp)
	leaq	(%r14,%r10), %r9
	movq	%r9, 2208(%rsp)
	addq	%rbp, %rsi
	addq	$-36, %rsi
	subq	%rdi, %rsi
	addq	%rbp, %rax
	subq	%r8, %rax
	addq	%rbp, %rcx
	subq	%r11, %rcx
	addq	%rbp, %rdx
	subq	%r13, %rdx
	addq	%rbp, %r10
	subq	%r14, %r10
	movq	%rsi, 2216(%rsp)
	movq	%rax, 2224(%rsp)
	movq	%rcx, 2232(%rsp)
	movq	%rdx, 2240(%rsp)
	leaq	2176(%rsp), %r13
	movq	%r10, 2248(%rsp)
	movq	112(%rsp), %rax
	movq	%rax, 2288(%rsp)
	movups	80(%rsp), %xmm0
	movups	96(%rsp), %xmm1
	movaps	%xmm1, 2272(%rsp)
	movaps	%xmm0, 2256(%rsp)
	leaq	2296(%rsp), %rdi
	movq	%rbx, %r12
	movq	%rbx, %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	movq	%r15, %rdi
	leaq	2888(%rsp), %rsi
	movq	%r13, %rdx
	callq	x25519_ge_add
	movq	%rsp, %rdi
	movq	%r15, %rsi
	movq	%r15, %rbp
	leaq	280(%rsp), %rbx
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	40(%rsp), %r15
	movq	%r15, %rdi
	leaq	200(%rsp), %r14
	movq	%r14, %rsi
	leaq	240(%rsp), %r13
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	80(%rsp), %rdi
	movq	%r13, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	%r12, %rdi
	movq	%rbp, %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	40(%rsp), %rsi
	movq	(%rsp), %rdi
	movq	8(%rsp), %r8
	leaq	(%rdi,%rsi), %r9
	movq	48(%rsp), %rax
	leaq	(%r8,%rax), %r10
	movq	56(%rsp), %rcx
	movq	16(%rsp), %r11
	leaq	(%r11,%rcx), %r14
	movq	64(%rsp), %rdx
	movq	24(%rsp), %r13
	movq	%r9, 2336(%rsp)
	leaq	(%r13,%rdx), %r9
	movq	%r10, 2344(%rsp)
	movq	72(%rsp), %r10
	movq	%r14, 2352(%rsp)
	movq	32(%rsp), %r14
	movq	%r9, 2360(%rsp)
	leaq	(%r14,%r10), %r9
	movq	%r9, 2368(%rsp)
	movabsq	$4503599627370494, %rbp         # imm = 0xFFFFFFFFFFFFE
	addq	%rbp, %rsi
	addq	$-36, %rsi
	subq	%rdi, %rsi
	addq	%rbp, %rax
	subq	%r8, %rax
	addq	%rbp, %rcx
	subq	%r11, %rcx
	addq	%rbp, %rdx
	subq	%r13, %rdx
	addq	%rbp, %r10
	subq	%r14, %r10
	movq	%rsi, 2376(%rsp)
	movq	%rax, 2384(%rsp)
	movq	%rcx, 2392(%rsp)
	movq	%rdx, 2400(%rsp)
	leaq	2336(%rsp), %rbx
	movq	%r10, 2408(%rsp)
	movq	112(%rsp), %rax
	movq	%rax, 2448(%rsp)
	movups	80(%rsp), %xmm0
	movups	96(%rsp), %xmm1
	movaps	%xmm1, 2432(%rsp)
	movaps	%xmm0, 2416(%rsp)
	leaq	2456(%rsp), %rdi
	movq	%r12, %r13
	movq	%r12, %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	leaq	160(%rsp), %r12
	movq	%r12, %rdi
	leaq	2888(%rsp), %rsi
	movq	%rbx, %rdx
	callq	x25519_ge_add
	movq	%rsp, %rdi
	movq	%r12, %rsi
	leaq	280(%rsp), %rbx
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	%r15, %rdi
	leaq	200(%rsp), %r15
	movq	%r15, %rsi
	leaq	240(%rsp), %r14
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	80(%rsp), %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	%r13, %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	movq	40(%rsp), %rsi
	movq	(%rsp), %rdi
	movq	8(%rsp), %r8
	leaq	(%rdi,%rsi), %r9
	movq	48(%rsp), %rax
	leaq	(%r8,%rax), %r10
	movq	56(%rsp), %rcx
	movq	16(%rsp), %r11
	leaq	(%r11,%rcx), %r14
	movq	64(%rsp), %rdx
	movq	24(%rsp), %r13
	movq	%r9, 2496(%rsp)
	leaq	(%r13,%rdx), %r9
	movq	%r10, 2504(%rsp)
	movq	72(%rsp), %r10
	movq	%r14, 2512(%rsp)
	movq	32(%rsp), %r14
	movq	%r9, 2520(%rsp)
	leaq	(%r14,%r10), %r9
	movq	%r9, 2528(%rsp)
	addq	%rbp, %rsi
	addq	$-36, %rsi
	subq	%rdi, %rsi
	addq	%rbp, %rax
	subq	%r8, %rax
	addq	%rbp, %rcx
	subq	%r11, %rcx
	addq	%rbp, %rdx
	subq	%r13, %rdx
	addq	%rbp, %r10
	subq	%r14, %r10
	movq	%rsi, 2536(%rsp)
	movq	%rax, 2544(%rsp)
	movq	%rcx, 2552(%rsp)
	movq	%rdx, 2560(%rsp)
	leaq	2496(%rsp), %r13
	movq	%r10, 2568(%rsp)
	movq	112(%rsp), %rax
	movq	%rax, 2608(%rsp)
	movups	80(%rsp), %xmm0
	movups	96(%rsp), %xmm1
	movaps	%xmm1, 2592(%rsp)
	movaps	%xmm0, 2576(%rsp)
	leaq	2616(%rsp), %rdi
	leaq	120(%rsp), %r14
	movq	%r14, %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	movq	%r12, %rdi
	leaq	2888(%rsp), %rsi
	movq	%r13, %rdx
	leaq	240(%rsp), %r13
	callq	x25519_ge_add
	movq	%rsp, %rdi
	movq	%r12, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	40(%rsp), %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	80(%rsp), %rdi
	movq	%r13, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	%r14, %rdi
	movq	%r14, %rbx
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	movq	40(%rsp), %rsi
	movq	(%rsp), %rdi
	movq	8(%rsp), %r8
	leaq	(%rdi,%rsi), %r9
	movq	48(%rsp), %rax
	leaq	(%r8,%rax), %r10
	movq	56(%rsp), %rcx
	movq	16(%rsp), %r11
	leaq	(%r11,%rcx), %r14
	movq	64(%rsp), %rdx
	movq	24(%rsp), %r12
	movq	%r9, 2656(%rsp)
	leaq	(%r12,%rdx), %r9
	movq	%r10, 2664(%rsp)
	movq	72(%rsp), %r10
	movq	%r14, 2672(%rsp)
	movq	32(%rsp), %r14
	movq	%r9, 2680(%rsp)
	leaq	(%r14,%r10), %r9
	movq	%r9, 2688(%rsp)
	addq	%rbp, %rsi
	addq	$-36, %rsi
	subq	%rdi, %rsi
	addq	%rbp, %rax
	subq	%r8, %rax
	addq	%rbp, %rcx
	subq	%r11, %rcx
	addq	%rbp, %rdx
	subq	%r12, %rdx
	addq	%rbp, %r10
	subq	%r14, %r10
	movq	%rsi, 2696(%rsp)
	movq	%rax, 2704(%rsp)
	movq	%rcx, 2712(%rsp)
	movq	%rdx, 2720(%rsp)
	movq	%r10, 2728(%rsp)
	movq	112(%rsp), %rax
	movq	%rax, 2768(%rsp)
	movups	80(%rsp), %xmm0
	movups	96(%rsp), %xmm1
	movaps	%xmm1, 2752(%rsp)
	movaps	%xmm0, 2736(%rsp)
	leaq	2776(%rsp), %rdi
	movq	%rbx, %rsi
	leaq	d2(%rip), %rdx
	callq	fe_mul_impl
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 1392(%rsp)
	movaps	%xmm0, 1376(%rsp)
	movq	$0, 1408(%rsp)
	movaps	%xmm0, 1424(%rsp)
	movaps	%xmm0, 1440(%rsp)
	movq	$1, 1416(%rsp)
	movups	%xmm0, 1464(%rsp)
	movups	%xmm0, 1480(%rsp)
	movq	$1, 1456(%rsp)
	movl	$255, %eax
	.p2align	4, 0x90
.LBB119_151:                            # =>This Inner Loop Header: Depth=1
	cmpb	$0, 784(%rsp,%rax)
	jne	.LBB119_158
# %bb.152:                              #   in Loop: Header=BB119_151 Depth=1
	cmpb	$0, 528(%rsp,%rax)
	jne	.LBB119_158
# %bb.153:                              #   in Loop: Header=BB119_151 Depth=1
	leal	-1(%rax), %ecx
	cmpb	$0, 784(%rsp,%rcx)
	jne	.LBB119_154
# %bb.155:                              #   in Loop: Header=BB119_151 Depth=1
	cmpb	$0, 528(%rsp,%rcx)
	jne	.LBB119_157
# %bb.156:                              #   in Loop: Header=BB119_151 Depth=1
	addq	$-2, %rax
	cmpl	$-1, %eax
	jne	.LBB119_151
	jmp	.LBB119_169
.LBB119_154:
	decl	%eax
	jmp	.LBB119_158
.LBB119_157:                            # %.split_crit_edge
	decl	%eax
.LBB119_158:
	testl	%eax, %eax
	js	.LBB119_169
# %bb.159:
	movl	%eax, %ebp
	incq	%rbp
	leaq	160(%rsp), %r12
	leaq	1376(%rsp), %r14
	movabsq	$2251799813685247, %rax         # imm = 0x7FFFFFFFFFFFF
	decq	%rax
	movq	%rax, 488(%rsp)                 # 8-byte Spill
	jmp	.LBB119_160
	.p2align	4, 0x90
.LBB119_165:                            #   in Loop: Header=BB119_160 Depth=1
	movq	%rsp, %rbx
	movq	%rbx, %rdi
	movq	%r12, %rsi
	leaq	280(%rsp), %r15
	movq	%r15, %rdx
	callq	fe_mul_impl
	leaq	40(%rsp), %rdi
	leaq	200(%rsp), %r12
	movq	%r12, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	80(%rsp), %rdi
	movq	%r13, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	leaq	120(%rsp), %rdi
	leaq	160(%rsp), %rsi
	movq	%r12, %rdx
	leaq	160(%rsp), %r12
	callq	fe_mul_impl
	shrq	%r14
	imulq	$120, %r14, %rdx
	leaq	Bi(%rip), %rax
	addq	%rax, %rdx
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	ge_madd
.LBB119_168:                            #   in Loop: Header=BB119_160 Depth=1
	leaq	1376(%rsp), %r14
	movq	%r14, %rdi
	movq	%r12, %rsi
	leaq	280(%rsp), %rbx
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	1416(%rsp), %rdi
	leaq	200(%rsp), %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	1456(%rsp), %rdi
	movq	%r13, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	decq	%rbp
	jle	.LBB119_169
.LBB119_160:                            # =>This Inner Loop Header: Depth=1
	movq	%r12, %rdi
	movq	%r14, %rsi
	callq	ge_p2_dbl
	movzbl	783(%rsp,%rbp), %r14d
	testb	%r14b, %r14b
	jle	.LBB119_162
# %bb.161:                              #   in Loop: Header=BB119_160 Depth=1
	movq	%rsp, %r15
	movq	%r15, %rdi
	movq	%r12, %rsi
	leaq	280(%rsp), %r12
	movq	%r12, %rdx
	callq	fe_mul_impl
	leaq	40(%rsp), %rdi
	leaq	200(%rsp), %rbx
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	80(%rsp), %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	leaq	160(%rsp), %r12
	callq	fe_mul_impl
	leaq	120(%rsp), %rdi
	movq	%r12, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	shrq	%r14
	leaq	(%r14,%r14,4), %rax
	shlq	$5, %rax
	leaq	(%rsp,%rax), %rdx
	addq	$1536, %rdx                     # imm = 0x600
	movq	%r12, %rdi
	movq	%r15, %rsi
	callq	x25519_ge_add
	jmp	.LBB119_164
	.p2align	4, 0x90
.LBB119_162:                            #   in Loop: Header=BB119_160 Depth=1
	testb	%r14b, %r14b
	jns	.LBB119_164
# %bb.163:                              #   in Loop: Header=BB119_160 Depth=1
	movq	%rsp, %rdi
	movq	%r12, %rsi
	leaq	280(%rsp), %rbx
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	40(%rsp), %rdi
	leaq	200(%rsp), %r15
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	80(%rsp), %rdi
	movq	%r13, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	120(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	negb	%r14b
	shrb	%r14b
	movzbl	%r14b, %eax
	leaq	(%rax,%rax,4), %rax
	shlq	$5, %rax
	leaq	(%rsp,%rax), %rdx
	addq	$1536, %rdx                     # imm = 0x600
	movq	%r12, %rdi
	movq	%rsp, %rsi
	callq	x25519_ge_sub
	.p2align	4, 0x90
.LBB119_164:                            #   in Loop: Header=BB119_160 Depth=1
	movzbl	527(%rsp,%rbp), %r14d
	testb	%r14b, %r14b
	jg	.LBB119_165
# %bb.166:                              #   in Loop: Header=BB119_160 Depth=1
	testb	%r14b, %r14b
	jns	.LBB119_168
# %bb.167:                              #   in Loop: Header=BB119_160 Depth=1
	movq	%rsp, %rdi
	movq	%r12, %rsi
	leaq	280(%rsp), %rbx
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	40(%rsp), %rdi
	leaq	200(%rsp), %r15
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	80(%rsp), %rdi
	movq	%r13, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	120(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	fe_mul_impl
	movq	40(%rsp), %rsi
	movq	(%rsp), %rdi
	movq	8(%rsp), %r8
	leaq	(%rdi,%rsi), %r9
	movq	48(%rsp), %rax
	leaq	(%r8,%rax), %r10
	movq	56(%rsp), %rcx
	movq	16(%rsp), %r11
	leaq	(%r11,%rcx), %rbx
	movq	64(%rsp), %rdx
	movq	24(%rsp), %r15
	movq	%r9, 160(%rsp)
	leaq	(%r15,%rdx), %r9
	movq	%r10, 168(%rsp)
	movq	72(%rsp), %r10
	movq	%rbx, 176(%rsp)
	movq	32(%rsp), %rbx
	movq	%r9, 184(%rsp)
	leaq	(%rbx,%r10), %r9
	movq	%r9, 192(%rsp)
	movabsq	$4503599627370494, %r13         # imm = 0xFFFFFFFFFFFFE
	addq	%r13, %rsi
	addq	$-36, %rsi
	subq	%rdi, %rsi
	addq	%r13, %rax
	subq	%r8, %rax
	addq	%r13, %rcx
	subq	%r11, %rcx
	addq	%r13, %rdx
	subq	%r15, %rdx
	addq	%r13, %r10
	subq	%rbx, %r10
	movq	%rsi, 200(%rsp)
	movq	%rax, 208(%rsp)
	movq	%rcx, 216(%rsp)
	negb	%r14b
	shrb	%r14b
	movzbl	%r14b, %eax
	imulq	$120, %rax, %rbx
	movq	%rdx, 224(%rsp)
	leaq	Bi(%rip), %r15
	leaq	(%r15,%rbx), %r14
	movq	%r10, 232(%rsp)
	leaq	(%rbx,%r15), %rdx
	addq	$40, %rdx
	leaq	1296(%rsp), %rdi
	movq	%r12, %rsi
	callq	fe_mul_impl
	leaq	1336(%rsp), %rdi
	leaq	200(%rsp), %rsi
	movq	%r14, %rdx
	callq	fe_mul_impl
	leaq	(%rbx,%r15), %rsi
	addq	$80, %rsi
	leaq	1256(%rsp), %rdi
	leaq	120(%rsp), %rdx
	callq	fe_mul_impl
	movq	1296(%rsp), %rsi
	movq	1304(%rsp), %rdx
	leaq	(%rsi,%r13), %rdi
	addq	$-36, %rdi
	movq	1336(%rsp), %rax
	movq	1344(%rsp), %rcx
	subq	%rax, %rdi
	leaq	(%rdx,%r13), %r8
	subq	%rcx, %r8
	movq	1312(%rsp), %r9
	leaq	(%r9,%r13), %r10
	movq	1352(%rsp), %r11
	subq	%r11, %r10
	movq	1320(%rsp), %rbx
	leaq	(%rbx,%r13), %r14
	movq	%rdi, 160(%rsp)
	movq	1360(%rsp), %r15
	subq	%r15, %r14
	movq	%r8, 168(%rsp)
	movq	1328(%rsp), %r8
	movq	%r10, 176(%rsp)
	leaq	(%r8,%r13), %rdi
	movq	%r14, 184(%rsp)
	movq	1368(%rsp), %r10
	subq	%r10, %rdi
	movq	%rdi, 192(%rsp)
	movq	80(%rsp), %rdi
	addq	%rsi, %rax
	movq	88(%rsp), %rsi
	addq	%rdi, %rdi
	addq	%rdx, %rcx
	movq	96(%rsp), %rdx
	addq	%r9, %r11
	movq	104(%rsp), %r9
	addq	%rbx, %r15
	movq	112(%rsp), %rbx
	addq	%r8, %r10
	movq	%rax, 200(%rsp)
	movq	%rcx, 208(%rsp)
	movq	%r11, 216(%rsp)
	movq	%r15, 224(%rsp)
	movq	%r10, 232(%rsp)
	movq	%rdi, %rax
	shrq	$51, %rax
	leaq	(%rax,%rsi,2), %r8
	movq	%r8, %rax
	shrq	$51, %rax
	leaq	(%rax,%rdx,2), %rax
	movq	%rax, %rcx
	shrq	$51, %rcx
	leaq	(%rcx,%r9,2), %rcx
	movq	%rcx, %rdx
	shrq	$51, %rdx
	leaq	(%rdx,%rbx,2), %rdx
	andq	488(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%rdx, %rsi
	shrq	$51, %rsi
	leaq	(%rsi,%rsi,8), %r9
	leaq	(%rsi,%r9,2), %rsi
	addq	%rdi, %rsi
	movq	%rsi, %rdi
	shrq	$51, %rdi
	movabsq	$2251799813685247, %r9          # imm = 0x7FFFFFFFFFFFF
	andq	%r9, %r8
	addq	%rdi, %r8
	andq	%r9, %rsi
	movq	%r8, %rdi
	andq	%r9, %rdi
	shrq	$51, %r8
	andq	%r9, %rax
	addq	%r8, %rax
	andq	%r9, %rcx
	andq	%r9, %rdx
	leaq	(%rsi,%r13), %r8
	addq	$-36, %r8
	movq	1256(%rsp), %r9
	movq	1264(%rsp), %r10
	subq	%r9, %r8
	leaq	(%rdi,%r13), %r11
	subq	%r10, %r11
	leaq	(%rax,%r13), %rbx
	movq	1272(%rsp), %r14
	subq	%r14, %rbx
	movq	%r8, 240(%rsp)
	leaq	(%rcx,%r13), %r8
	movq	%r11, 248(%rsp)
	movq	1280(%rsp), %r11
	subq	%r11, %r8
	movq	%rbx, 256(%rsp)
	leaq	(%rdx,%r13), %rbx
	leaq	240(%rsp), %r13
	movq	%r8, 264(%rsp)
	movq	1288(%rsp), %r8
	subq	%r8, %rbx
	movq	%rbx, 272(%rsp)
	addq	%r9, %rsi
	addq	%r10, %rdi
	addq	%r14, %rax
	addq	%r11, %rcx
	addq	%r8, %rdx
	movq	%rsi, 280(%rsp)
	movq	%rdi, 288(%rsp)
	movq	%rax, 296(%rsp)
	movq	%rcx, 304(%rsp)
	movq	%rdx, 312(%rsp)
	jmp	.LBB119_168
.LBB119_169:
	leaq	1456(%rsp), %rcx
	movq	32(%rcx), %rax
	movq	%rax, 1568(%rsp)
	movups	(%rcx), %xmm0
	movups	16(%rcx), %xmm1
	movaps	%xmm1, 1552(%rsp)
	movaps	%xmm0, 1536(%rsp)
	leaq	784(%rsp), %rbx
	leaq	1536(%rsp), %rsi
	movq	%rbx, %rdi
	callq	fe_loose_invert
	leaq	1536(%rsp), %r14
	leaq	1376(%rsp), %rsi
	movq	%r14, %rdi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	528(%rsp), %r15
	movq	%r15, %rdi
	leaq	1416(%rsp), %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	%rsp, %rdi
	movq	%r15, %rsi
	callq	fe_tobytes
	leaq	160(%rsp), %rdi
	movq	%r14, %rsi
	callq	fe_tobytes
	movzbl	160(%rsp), %eax
	shlb	$7, %al
	xorb	%al, 31(%rsp)
	movdqa	1504(%rsp), %xmm0               # 16-byte Reload
	pxor	(%rsp), %xmm0
	movdqa	1520(%rsp), %xmm1               # 16-byte Reload
	pxor	16(%rsp), %xmm1
	por	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	pcmpeqb	%xmm1, %xmm0
	pmovmskb	%xmm0, %eax
	xorl	%ebp, %ebp
	cmpl	$65535, %eax                    # imm = 0xFFFF
	sete	%bpl
.LBB119_170:
	movl	%ebp, %eax
	addq	$3048, %rsp                     # imm = 0xBE8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end119:
	.size	ED25519_verify, .Lfunc_end119-ED25519_verify
                                        # -- End function
	.globl	ED25519_keypair_from_seed       # -- Begin function ED25519_keypair_from_seed
	.p2align	4, 0x90
	.type	ED25519_keypair_from_seed,@function
ED25519_keypair_from_seed:              # @ED25519_keypair_from_seed
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$456, %rsp                      # imm = 0x1C8
	movq	%rdx, %r15
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movabsq	$7640891576956012808, %rax      # imm = 0x6A09E667F3BCC908
	movq	%rax, 72(%rsp)
	movabsq	$-4942790177534073029, %rax     # imm = 0xBB67AE8584CAA73B
	movq	%rax, 80(%rsp)
	movabsq	$4354685564936845355, %rax      # imm = 0x3C6EF372FE94F82B
	movq	%rax, 88(%rsp)
	movabsq	$-6534734903238641935, %rax     # imm = 0xA54FF53A5F1D36F1
	movq	%rax, 96(%rsp)
	movabsq	$5840696475078001361, %rax      # imm = 0x510E527FADE682D1
	movq	%rax, 104(%rsp)
	movabsq	$-7276294671716946913, %rax     # imm = 0x9B05688C2B3E6C1F
	movq	%rax, 112(%rsp)
	movabsq	$2270897969802886507, %rax      # imm = 0x1F83D9ABFB41BD6B
	movq	%rax, 120(%rsp)
	movabsq	$6620516959819538809, %rax      # imm = 0x5BE0CD19137E2179
	movq	%rax, 128(%rsp)
	movl	$64, 284(%rsp)
	leaq	152(%rsp), %rsi
	movq	$0, 144(%rsp)
	movq	$256, 136(%rsp)                 # imm = 0x100
	movups	(%rdx), %xmm0
	movups	16(%rdx), %xmm1
	movups	%xmm0, 152(%rsp)
	movups	%xmm1, 168(%rsp)
	movl	$32, 280(%rsp)
	movb	$-128, 184(%rsp)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 185(%rsp)
	movups	%xmm0, 201(%rsp)
	movups	%xmm0, 217(%rsp)
	movups	%xmm0, 233(%rsp)
	movups	%xmm0, 249(%rsp)
	movq	$0, 264(%rsp)
	movabsq	$281474976710656, %rax          # imm = 0x1000000000000
	movq	%rax, 272(%rsp)
	leaq	72(%rsp), %rdi
	movl	$1, %edx
	callq	sha512_block_data_order
	movq	72(%rsp), %rax
	movq	80(%rsp), %rcx
	bswapq	%rax
	bswapq	%rcx
	movq	%rax, (%rsp)
	movq	88(%rsp), %rdx
	bswapq	%rdx
	movq	%rcx, 8(%rsp)
	movq	96(%rsp), %rcx
	bswapq	%rcx
	movq	%rdx, 16(%rsp)
	movq	104(%rsp), %rdx
	bswapq	%rdx
	movq	%rcx, 24(%rsp)
	movq	112(%rsp), %rsi
	bswapq	%rsi
	movq	%rdx, 32(%rsp)
	movq	120(%rsp), %rdx
	bswapq	%rdx
	movq	%rsi, 40(%rsp)
	movq	128(%rsp), %rsi
	bswapq	%rsi
	movq	%rdx, 48(%rsp)
	movq	%rsi, 56(%rsp)
	andb	$-8, %al
	movb	%al, (%rsp)
	shrq	$56, %rcx
	andb	$63, %cl
	orb	$64, %cl
	movb	%cl, 31(%rsp)
	leaq	72(%rsp), %r12
	movq	%rsp, %rsi
	movq	%r12, %rdi
	callq	x25519_ge_scalarmult_base
	movq	184(%rsp), %rax
	movq	%rax, 320(%rsp)
	movups	152(%rsp), %xmm0
	movups	168(%rsp), %xmm1
	movaps	%xmm1, 304(%rsp)
	movaps	%xmm0, 288(%rsp)
	leaq	416(%rsp), %r13
	leaq	288(%rsp), %rsi
	movq	%r13, %rdi
	callq	fe_loose_invert
	leaq	288(%rsp), %rbp
	movq	%rbp, %rdi
	movq	%r12, %rsi
	movq	%r13, %rdx
	callq	fe_mul_impl
	leaq	112(%rsp), %rsi
	leaq	376(%rsp), %r12
	movq	%r12, %rdi
	movq	%r13, %rdx
	callq	fe_mul_impl
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	fe_tobytes
	leaq	336(%rsp), %rdi
	movq	%rbp, %rsi
	callq	fe_tobytes
	movzbl	336(%rsp), %eax
	shlb	$7, %al
	xorb	%al, 31(%r14)
	movups	(%r15), %xmm0
	movups	16(%r15), %xmm1
	movups	%xmm1, 16(%rbx)
	movups	%xmm0, (%rbx)
	movups	(%r14), %xmm0
	movups	16(%r14), %xmm1
	movups	%xmm0, 32(%rbx)
	movups	%xmm1, 48(%rbx)
	addq	$456, %rsp                      # imm = 0x1C8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end120:
	.size	ED25519_keypair_from_seed, .Lfunc_end120-ED25519_keypair_from_seed
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function X25519
.LCPI121_0:
	.quad	2251799813685247                # 0x7ffffffffffff
	.quad	2251799813685247                # 0x7ffffffffffff
	.text
	.globl	X25519
	.p2align	4, 0x90
	.type	X25519,@function
X25519:                                 # @X25519
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$776, %rsp                      # imm = 0x308
	movq	%rdi, 512(%rsp)                 # 8-byte Spill
	movabsq	$2251799813685247, %r13         # imm = 0x7FFFFFFFFFFFF
	movdqu	(%rsi), %xmm0
	movdqu	16(%rsi), %xmm1
	movdqa	%xmm0, 544(%rsp)
	movdqa	%xmm1, 560(%rsp)
	andb	$-8, 544(%rsp)
	movzbl	575(%rsp), %eax
	andb	$63, %al
	orb	$64, %al
	movb	%al, 575(%rsp)
	movl	(%rdx), %r9d
	movl	16(%rdx), %eax
	movzbl	4(%rdx), %r10d
	movzbl	5(%rdx), %ebx
	movzbl	6(%rdx), %ecx
	movzbl	7(%rdx), %esi
	movzbl	8(%rdx), %edi
	movzbl	9(%rdx), %r8d
	movzbl	10(%rdx), %r14d
	movzbl	27(%rdx), %r15d
	movl	28(%rdx), %r11d
	andl	$2147483647, %r11d              # imm = 0x7FFFFFFF
	shlq	$20, %r11
	shlq	$12, %r15
	orq	%r11, %r15
	movzbl	26(%rdx), %r11d
	shlq	$4, %r11
	orq	%r15, %r11
	shlq	$40, %rbx
	movl	%ecx, %r15d
	andl	$7, %r15d
	shlq	$48, %r15
	orq	%rbx, %r15
	movzbl	11(%rdx), %r12d
	orq	%r9, %r15
	movzbl	12(%rdx), %r9d
	shlq	$37, %r12
	shlq	$32, %r10
	orq	%r10, %r15
	movl	%r9d, %ebx
	andl	$63, %ebx
	shlq	$45, %rbx
	orq	%r12, %rbx
	movzbl	13(%rdx), %r10d
	shlq	$29, %r14
	orq	%r14, %rbx
	movzbl	14(%rdx), %r14d
	shlq	$21, %r8
	orq	%r8, %rbx
	movzbl	15(%rdx), %r8d
	shlq	$13, %rdi
	orq	%rdi, %rbx
	movzbl	20(%rdx), %edi
	shlq	$5, %rsi
	orq	%rsi, %rbx
	movq	%rax, %rsi
	shlq	$26, %rsi
	shrq	$3, %rcx
	orq	%rcx, %rbx
	leaq	-67108863(%r13), %rcx
	andq	%rsi, %rcx
	movzbl	21(%rdx), %esi
	movl	22(%rdx), %ebp
	shlq	$18, %r8
	orq	%r8, %rcx
	movq	%rbp, %rdx
	shlq	$23, %rdx
	shlq	$15, %rsi
	shlq	$7, %rdi
	shlq	$10, %r14
	shrq	$6, %r9
	orq	%r14, %rcx
	leaq	(%rcx,%r10,4), %r12
	orq	%r9, %r12
	shrq	$25, %rax
	leaq	-8388607(%r13), %r14
	andq	%rdx, %r14
	orq	%rsi, %r14
	orq	%rdi, %r14
	orq	%rax, %r14
	shrq	$28, %rbp
	orq	%r11, %rbp
	movq	%r15, 696(%rsp)
	movq	%rbx, 704(%rsp)
	movq	%r12, 712(%rsp)
	movq	%r14, 720(%rsp)
	movq	%rbp, 728(%rsp)
	pxor	%xmm0, %xmm0
	movdqu	%xmm0, 304(%rsp)
	movdqu	%xmm0, 320(%rsp)
	movq	$1, 296(%rsp)
	movdqa	%xmm0, 192(%rsp)
	movdqa	%xmm0, 208(%rsp)
	movq	$0, 224(%rsp)
	movdqu	%xmm0, 264(%rsp)
	movdqu	%xmm0, 280(%rsp)
	movq	$1, 256(%rsp)
	movl	$254, %eax
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB121_1:                              # =>This Inner Loop Header: Depth=1
	movq	%rbp, 144(%rsp)                 # 8-byte Spill
	movl	%eax, 252(%rsp)                 # 4-byte Spill
                                        # kill: def $edx killed $edx killed $rdx def $rdx
	movl	%eax, %eax
	shrq	$3, %rax
	movzbl	544(%rsp,%rax), %eax
	movl	252(%rsp), %ecx                 # 4-byte Reload
	andl	$7, %ecx
	btl	%ecx, %eax
	movl	$0, %eax
	setb	%al
	movq	%rax, 536(%rsp)                 # 8-byte Spill
	xorl	%eax, %edx
	movq	296(%rsp), %rcx
	movq	304(%rsp), %rsi
	negq	%rdx
	movq	%rcx, %rax
	xorq	%r15, %rax
	andq	%rdx, %rax
	xorq	%rax, %rcx
	movq	%rcx, %r10
	movq	%rcx, 168(%rsp)                 # 8-byte Spill
	movq	%rsi, %rcx
	xorq	%rbx, %rcx
	andq	%rdx, %rcx
	xorq	%r15, %rax
	movq	%rax, %rdi
	movq	%rax, 160(%rsp)                 # 8-byte Spill
	xorq	%rcx, %rsi
	movq	%rsi, %r9
	movq	%rsi, 176(%rsp)                 # 8-byte Spill
	movq	192(%rsp), %rsi
	movq	200(%rsp), %r11
	xorq	%rbx, %rcx
	movq	%rcx, %r15
	movq	%rcx, 184(%rsp)                 # 8-byte Spill
	movq	256(%rsp), %rax
	movq	264(%rsp), %rcx
	movq	%rax, %r8
	movq	%r10, 296(%rsp)
	xorq	%rsi, %r8
	andq	%rdx, %r8
	xorq	%r8, %rsi
	movq	%rsi, 32(%rsp)                  # 8-byte Spill
	movq	%r9, 304(%rsp)
	xorq	%rax, %r8
	movq	%rcx, %r9
	movq	%r11, %rax
	xorq	%r11, %r9
	movq	312(%rsp), %rbx
	andq	%rdx, %r9
	xorq	%r9, %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	xorq	%rcx, %r9
	movq	%rbx, %r11
	xorq	%r12, %r11
	andq	%rdx, %r11
	movq	%rsi, 192(%rsp)
	xorq	%r11, %rbx
	movq	%r8, 256(%rsp)
	movq	%rax, 200(%rsp)
	movq	%r9, 264(%rsp)
	xorq	%r12, %r11
	movq	208(%rsp), %rcx
	movq	272(%rsp), %rax
	movq	%rax, %r10
	xorq	%rcx, %r10
	andq	%rdx, %r10
	xorq	%r10, %rcx
	movq	%rcx, %rsi
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	xorq	%rax, %r10
	movabsq	$4503599627370494, %r13         # imm = 0xFFFFFFFFFFFFE
	leaq	(%rdi,%r13), %rax
	addq	$-36, %rax
	subq	%r8, %rax
	movq	%rax, 432(%rsp)
	leaq	(%r15,%r13), %rax
	subq	%r9, %rax
	movq	%rax, 440(%rsp)
	movq	%rbx, 312(%rsp)
	movq	320(%rsp), %r12
	movq	%r12, %rax
	xorq	%r14, %rax
	andq	%rdx, %rax
	xorq	%rax, %r12
	xorq	%r14, %rax
	leaq	(%r11,%r13), %rcx
	subq	%r10, %rcx
	movq	%rcx, 448(%rsp)
	movq	%rsi, 208(%rsp)
	movq	%r10, 272(%rsp)
	movq	216(%rsp), %rdi
	movq	280(%rsp), %rcx
	movq	%rcx, %rsi
	xorq	%rdi, %rsi
	andq	%rdx, %rsi
	xorq	%rsi, %rdi
	movq	%rdi, 40(%rsp)                  # 8-byte Spill
	xorq	%rcx, %rsi
	movq	%r12, 320(%rsp)
	movq	328(%rsp), %rcx
	movq	%rcx, %r14
	xorq	%rbp, %r14
	andq	%rdx, %r14
	movq	%rdi, 216(%rsp)
	movq	%rsi, 280(%rsp)
	movq	224(%rsp), %rdi
	movq	%rdi, 8(%rsp)                   # 8-byte Spill
	movq	288(%rsp), %r15
	movq	%r15, 152(%rsp)                 # 8-byte Spill
	xorq	%rdi, %r15
	andq	%rdx, %r15
	leaq	(%rax,%r13), %rdx
	subq	%rsi, %rdx
	movq	%rdx, 456(%rsp)
	movq	%r13, %rdx
	movq	168(%rsp), %rdi                 # 8-byte Reload
	leaq	(%rdi,%r13), %rbp
	addq	$-36, %rbp
	movq	32(%rsp), %r13                  # 8-byte Reload
	subq	%r13, %rbp
	movq	%rbp, 56(%rsp)                  # 8-byte Spill
	addq	%rdi, %r13
	movq	%r13, 32(%rsp)                  # 8-byte Spill
	xorq	%r14, %rcx
	xorq	144(%rsp), %r14                 # 8-byte Folded Reload
	movq	176(%rsp), %rdi                 # 8-byte Reload
	leaq	(%rdi,%rdx), %rbp
	movq	16(%rsp), %r13                  # 8-byte Reload
	subq	%r13, %rbp
	movq	%rbp, 48(%rsp)                  # 8-byte Spill
	addq	%rdi, %r13
	movq	%r13, 16(%rsp)                  # 8-byte Spill
	leaq	(%rbx,%rdx), %r13
	movq	24(%rsp), %rdi                  # 8-byte Reload
	subq	%rdi, %r13
	addq	%rbx, %rdi
	movq	%rdi, 24(%rsp)                  # 8-byte Spill
	leaq	(%r12,%rdx), %rbx
	movq	40(%rsp), %rbp                  # 8-byte Reload
	subq	%rbp, %rbx
	addq	%r12, %rbp
	movq	%rbp, 40(%rsp)                  # 8-byte Spill
	addq	160(%rsp), %r8                  # 8-byte Folded Reload
	movq	8(%rsp), %r12                   # 8-byte Reload
	xorq	%r15, %r12
	xorq	152(%rsp), %r15                 # 8-byte Folded Reload
	addq	184(%rsp), %r9                  # 8-byte Folded Reload
	addq	%r11, %r10
	addq	%rax, %rsi
	movq	%rcx, 328(%rsp)
	movq	%r12, 224(%rsp)
	leaq	(%rcx,%rdx), %rbp
	subq	%r12, %rbp
	addq	%rcx, %r12
	movq	%r12, 8(%rsp)                   # 8-byte Spill
	movq	%r15, 288(%rsp)
	leaq	(%r14,%rdx), %rax
	subq	%r15, %rax
	addq	%r14, %r15
	movq	%r8, 472(%rsp)
	movq	%r9, 480(%rsp)
	movq	%r10, 488(%rsp)
	movq	%rax, 464(%rsp)
	movq	%rsi, 496(%rsp)
	movq	%r15, 504(%rsp)
	movq	56(%rsp), %r14                  # 8-byte Reload
	movq	%r14, 392(%rsp)
	movq	48(%rsp), %r15                  # 8-byte Reload
	movq	%r15, 400(%rsp)
	movq	%r13, 408(%rsp)
	movq	%rbx, 416(%rsp)
	movq	32(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 576(%rsp)
	movq	%rbp, 424(%rsp)
	movq	16(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 584(%rsp)
	movq	%rdi, 592(%rsp)
	movq	40(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 600(%rsp)
	movq	%r12, 608(%rsp)
	leaq	256(%rsp), %rdi
	leaq	432(%rsp), %rsi
	leaq	576(%rsp), %rdx
	callq	fe_mul_impl
	leaq	192(%rsp), %rdi
	leaq	472(%rsp), %rsi
	leaq	392(%rsp), %rdx
	callq	fe_mul_impl
	leaq	(,%rbp,8), %rax
	addq	%rbp, %rax
	leaq	(,%rax,2), %rax
	addq	%rbp, %rax
	imulq	$38, %rbp, %rsi
	leaq	(%rbx,%rbx,8), %rcx
	leaq	(%rbx,%rcx,2), %rdi
	mulq	%rbp
	movq	%rdx, 176(%rsp)                 # 8-byte Spill
	movq	%rax, 168(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	%rbx
	movq	%rax, 184(%rsp)                 # 8-byte Spill
	movq	%rdx, 160(%rsp)                 # 8-byte Spill
	imulq	$38, %rbx, %r8
	leaq	(%rbx,%rbx), %rcx
	movq	%rdi, %rax
	mulq	%rbx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	%r13
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %r9
	addq	%r13, %r9
	movq	%r13, %rax
	mulq	%r13
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rsi, %rax
	mulq	%r15
	movq	%rdx, %r13
	movq	%rax, %r10
	movq	%rcx, %rax
	mulq	%r15
	movq	%rax, %r8
	movq	%rdx, %rdi
	addq	%rbp, %rbp
	movq	%r9, %rax
	mulq	%r15
	movq	%rdx, 152(%rsp)                 # 8-byte Spill
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	%r15, %rax
	mulq	%r15
	movq	%r15, %rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	movq	%r14, %rbp
	mulq	%r14
	movq	%rax, %rsi
	movq	%rdx, %r11
	leaq	(%r15,%r15), %rbx
	movq	%rcx, %rax
	mulq	%r14
	movq	%rdx, %r15
	movq	%rax, %r12
	movq	%r9, %rax
	mulq	%r14
	movq	%rdx, %rcx
	movq	%rax, %r9
	movq	%rbx, %rax
	mulq	%r14
	movq	%rdx, %rbx
	movq	%rax, %r14
	movq	%rbp, %rax
	mulq	%rbp
	addq	64(%rsp), %rax                  # 8-byte Folded Reload
	adcq	72(%rsp), %rdx                  # 8-byte Folded Reload
	addq	%r10, %rax
	adcq	%r13, %rdx
	shldq	$13, %rax, %rdx
	movabsq	$2251799813685247, %r10         # imm = 0x7FFFFFFFFFFFF
	andq	%r10, %rax
	addq	80(%rsp), %r8                   # 8-byte Folded Reload
	adcq	88(%rsp), %rdi                  # 8-byte Folded Reload
	addq	%rsi, %r8
	adcq	%r11, %rdi
	addq	120(%rsp), %r14                 # 8-byte Folded Reload
	adcq	136(%rsp), %rbx                 # 8-byte Folded Reload
	addq	112(%rsp), %r14                 # 8-byte Folded Reload
	adcq	128(%rsp), %rbx                 # 8-byte Folded Reload
	addq	%rdx, %r14
	adcq	$0, %rbx
	shldq	$13, %r14, %rbx
	andq	%r10, %r14
	addq	96(%rsp), %r9                   # 8-byte Folded Reload
	adcq	104(%rsp), %rcx                 # 8-byte Folded Reload
	addq	184(%rsp), %r9                  # 8-byte Folded Reload
	adcq	160(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rbx, %r9
	adcq	$0, %rcx
	shldq	$13, %r9, %rcx
	andq	%r10, %r9
	addq	144(%rsp), %r12                 # 8-byte Folded Reload
	adcq	152(%rsp), %r15                 # 8-byte Folded Reload
	addq	168(%rsp), %r12                 # 8-byte Folded Reload
	adcq	176(%rsp), %r15                 # 8-byte Folded Reload
	addq	%rcx, %r12
	adcq	$0, %r15
	shldq	$13, %r12, %r15
	andq	%r10, %r12
	movq	%r12, 160(%rsp)                 # 8-byte Spill
	addq	%r8, %r15
	adcq	$0, %rdi
	shldq	$13, %r15, %rdi
	andq	%r10, %r15
	movq	%r15, 176(%rsp)                 # 8-byte Spill
	leaq	(%rdi,%rdi,8), %rcx
	leaq	(%rdi,%rcx,2), %rcx
	addq	%rax, %rcx
	movq	%rcx, %rax
	shrq	$51, %rax
	addq	%r14, %rax
	andq	%r10, %rcx
	movq	%rcx, 184(%rsp)                 # 8-byte Spill
	movq	%rax, %rcx
	movq	%rax, %r13
	shrq	$51, %rcx
	addq	%r9, %rcx
	movq	%rcx, 168(%rsp)                 # 8-byte Spill
	movq	8(%rsp), %r14                   # 8-byte Reload
	leaq	(%r14,%r14,8), %rax
	leaq	(%r14,%rax,2), %rax
	imulq	$38, %r14, %rcx
	movq	40(%rsp), %r9                   # 8-byte Reload
	leaq	(%r9,%r9,8), %rdx
	leaq	(%r9,%rdx,2), %rdi
	mulq	%r14
	movq	%rdx, 152(%rsp)                 # 8-byte Spill
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r9
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	imulq	$38, %r9, %r8
	leaq	(%r9,%r9), %rsi
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	movq	24(%rsp), %rdi                  # 8-byte Reload
	mulq	%rdi
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%r8, %rax
	mulq	%rdi
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, %r12
	leaq	(%rdi,%rdi), %r9
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	movq	16(%rsp), %rcx                  # 8-byte Reload
	mulq	%rcx
	movq	%rdx, 240(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rax, %r8
	movq	%rdx, %rdi
	addq	%r14, %r14
	movq	%r9, %rax
	mulq	%rcx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	%rcx
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	movq	32(%rsp), %rbp                  # 8-byte Reload
	mulq	%rbp
	movq	%rax, %r14
	movq	%rdx, %r11
	leaq	(%rcx,%rcx), %r10
	movq	%rsi, %rax
	mulq	%rbp
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%rbp
	movq	%rdx, %rsi
	movq	%rax, %r9
	movq	%r10, %rax
	mulq	%rbp
	movq	%rax, %r15
	movq	%rdx, %r10
	movabsq	$2251799813685247, %rcx         # imm = 0x7FFFFFFFFFFFF
	andq	%rcx, %r13
	movq	%r13, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %rax                  # 8-byte Folded Reload
	adcq	%rdx, %r12
	addq	%rbx, %rax
	adcq	240(%rsp), %r12                 # 8-byte Folded Reload
	shldq	$13, %rax, %r12
	andq	%rcx, %rax
	addq	56(%rsp), %r8                   # 8-byte Folded Reload
	adcq	64(%rsp), %rdi                  # 8-byte Folded Reload
	addq	%r14, %r8
	adcq	%r11, %rdi
	addq	96(%rsp), %r15                  # 8-byte Folded Reload
	adcq	112(%rsp), %r10                 # 8-byte Folded Reload
	addq	88(%rsp), %r15                  # 8-byte Folded Reload
	adcq	104(%rsp), %r10                 # 8-byte Folded Reload
	addq	%r12, %r15
	adcq	$0, %r10
	shldq	$13, %r15, %r10
	andq	%rcx, %r15
	addq	72(%rsp), %r9                   # 8-byte Folded Reload
	adcq	80(%rsp), %rsi                  # 8-byte Folded Reload
	addq	128(%rsp), %r9                  # 8-byte Folded Reload
	adcq	136(%rsp), %rsi                 # 8-byte Folded Reload
	addq	%r10, %r9
	adcq	$0, %rsi
	shldq	$13, %r9, %rsi
	andq	%rcx, %r9
	movq	%rcx, %r10
	movq	16(%rsp), %rcx                  # 8-byte Reload
	addq	120(%rsp), %rcx                 # 8-byte Folded Reload
	movq	8(%rsp), %rdx                   # 8-byte Reload
	adcq	24(%rsp), %rdx                  # 8-byte Folded Reload
	addq	144(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	152(%rsp), %rdx                 # 8-byte Folded Reload
	addq	%rsi, %rcx
	adcq	$0, %rdx
	shldq	$13, %rcx, %rdx
	andq	%r10, %rcx
	movq	%rcx, %r11
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	addq	%r8, %rdx
	adcq	$0, %rdi
	shldq	$13, %rdx, %rdi
	movq	%rdx, %r8
	leaq	(%rdi,%rdi,8), %rcx
	leaq	(%rdi,%rcx,2), %rbx
	addq	%rax, %rbx
	movq	%rbx, %r10
	shrq	$51, %r10
	addq	%r15, %r10
	movq	%r10, %rcx
	shrq	$51, %rcx
	addq	%r9, %rcx
	movq	%rcx, %r9
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	256(%rsp), %rax
	movq	264(%rsp), %rbp
	movq	192(%rsp), %rcx
	movq	200(%rsp), %rdx
	leaq	(%rcx,%rax), %rsi
	movq	%rsi, 152(%rsp)                 # 8-byte Spill
	movabsq	$4503599627370494, %rsi         # imm = 0xFFFFFFFFFFFFE
	addq	%rsi, %rax
	addq	$-36, %rax
	subq	%rcx, %rax
	movq	%rax, %rdi
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	leaq	(%rdx,%rbp), %rax
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	addq	%rsi, %rbp
	subq	%rdx, %rbp
	movq	272(%rsp), %r14
	movq	208(%rsp), %rax
	leaq	(%rax,%r14), %rcx
	movq	%rcx, 136(%rsp)                 # 8-byte Spill
	addq	%rsi, %r14
	subq	%rax, %r14
	movq	280(%rsp), %r12
	movq	216(%rsp), %rax
	leaq	(%rax,%r12), %rcx
	movq	%rcx, 128(%rsp)                 # 8-byte Spill
	addq	%rsi, %r12
	subq	%rax, %r12
	movq	288(%rsp), %r15
	movq	224(%rsp), %rax
	leaq	(%rax,%r15), %rcx
	movq	%rcx, 120(%rsp)                 # 8-byte Spill
	addq	%rsi, %r15
	subq	%rax, %r15
	movq	184(%rsp), %r13                 # 8-byte Reload
	movq	%r13, 656(%rsp)
	movq	40(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 664(%rsp)
	movq	168(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 672(%rsp)
	movq	160(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 680(%rsp)
	movq	176(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 688(%rsp)
	movabsq	$2251799813685247, %rax         # imm = 0x7FFFFFFFFFFFF
	andq	%rax, %r8
	movq	%r8, 8(%rsp)                    # 8-byte Spill
	andq	%rax, %rbx
	andq	%rax, %r10
	movq	%r10, 32(%rsp)                  # 8-byte Spill
	movq	%rbx, 616(%rsp)
	movq	%r10, 624(%rsp)
	movq	%r9, 632(%rsp)
	movq	%r11, 640(%rsp)
	movq	%r8, 648(%rsp)
	movq	%rdi, 472(%rsp)
	movq	%rbp, 480(%rsp)
	movq	%r14, 488(%rsp)
	movq	%r12, 496(%rsp)
	movq	%r15, 504(%rsp)
	leaq	296(%rsp), %rdi
	leaq	616(%rsp), %rsi
	leaq	656(%rsp), %rdx
	callq	fe_mul_impl
	movabsq	$4503599627370494, %rdx         # imm = 0xFFFFFFFFFFFFE
	leaq	(%rbx,%rdx), %rax
	addq	$-36, %rax
	subq	%r13, %rax
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	%rdx, %rax
	subq	40(%rsp), %rax                  # 8-byte Folded Reload
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rax                  # 8-byte Reload
	addq	%rdx, %rax
	subq	168(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %rcx                  # 8-byte Reload
	addq	%rdx, %rcx
	subq	160(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %r13                   # 8-byte Reload
	addq	%rdx, %r13
	leaq	(%r15,%r15,8), %rax
	leaq	(%r15,%rax,2), %rax
	mulq	%r15
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	leaq	(%r12,%r12,8), %rax
	leaq	(%r12,%rax,2), %rcx
	imulq	$38, %r15, %rdi
	movq	%rdi, %rax
	mulq	%r12
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	imulq	$38, %r12, %r8
	leaq	(%r12,%r12), %rsi
	movq	%rcx, %rax
	mulq	%r12
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, 240(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%r14
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%rax, 384(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%r14
	movq	%rax, 336(%rsp)                 # 8-byte Spill
	movq	%rdx, 344(%rsp)                 # 8-byte Spill
	leaq	(%r14,%r14), %r8
	movq	%r14, %rax
	mulq	%r14
	movq	%rdx, 360(%rsp)                 # 8-byte Spill
	movq	%rax, 352(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rbp
	movq	%rdx, 528(%rsp)                 # 8-byte Spill
	movq	%rax, 520(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	%rbp
	movq	%rax, %r12
	movq	%rdx, %r9
	addq	%r15, %r15
	movq	%r8, %rax
	mulq	%rbp
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rbp
	movq	%rdx, 376(%rsp)                 # 8-byte Spill
	movq	%rax, 368(%rsp)                 # 8-byte Spill
	movq	%r15, %rax
	movq	64(%rsp), %rcx                  # 8-byte Reload
	mulq	%rcx
	movq	%rax, %rdi
	movq	%rdx, %rbx
	movq	%rbp, %r11
	addq	%rbp, %r11
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, %rsi
	movq	%rax, %r15
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, %r14
	movq	%rax, %r8
	movq	%r11, %rax
	mulq	%rcx
	movq	%rax, %rbp
	movq	%rdx, %r11
	subq	176(%rsp), %r13                 # 8-byte Folded Reload
	movq	%rcx, %rax
	mulq	%rcx
	addq	336(%rsp), %rax                 # 8-byte Folded Reload
	adcq	344(%rsp), %rdx                 # 8-byte Folded Reload
	addq	520(%rsp), %rax                 # 8-byte Folded Reload
	adcq	528(%rsp), %rdx                 # 8-byte Folded Reload
	shldq	$13, %rax, %rdx
	movabsq	$2251799813685247, %r10         # imm = 0x7FFFFFFFFFFFF
	andq	%r10, %rax
	addq	352(%rsp), %r12                 # 8-byte Folded Reload
	adcq	360(%rsp), %r9                  # 8-byte Folded Reload
	addq	%rdi, %r12
	adcq	%rbx, %r9
	addq	240(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	56(%rsp), %r11                  # 8-byte Folded Reload
	addq	384(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	48(%rsp), %r11                  # 8-byte Folded Reload
	addq	%rdx, %rbp
	adcq	$0, %r11
	shldq	$13, %rbp, %r11
	andq	%r10, %rbp
	addq	368(%rsp), %r8                  # 8-byte Folded Reload
	adcq	376(%rsp), %r14                 # 8-byte Folded Reload
	addq	88(%rsp), %r8                   # 8-byte Folded Reload
	adcq	96(%rsp), %r14                  # 8-byte Folded Reload
	addq	%r11, %r8
	adcq	$0, %r14
	shldq	$13, %r8, %r14
	andq	%r10, %r8
	addq	72(%rsp), %r15                  # 8-byte Folded Reload
	adcq	80(%rsp), %rsi                  # 8-byte Folded Reload
	addq	104(%rsp), %r15                 # 8-byte Folded Reload
	adcq	8(%rsp), %rsi                   # 8-byte Folded Reload
	addq	%r14, %r15
	adcq	$0, %rsi
	shldq	$13, %r15, %rsi
	addq	%r12, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	movq	%rsi, %xmm0
	movq	%r15, %xmm1
	leaq	(%r9,%r9,8), %rcx
	leaq	(%r9,%rcx,2), %rcx
	addq	%rax, %rcx
	movq	%rcx, %rdi
	shrq	$51, %rdi
	addq	%rbp, %rdi
	movq	112(%rsp), %r15                 # 8-byte Reload
	movq	%r15, 392(%rsp)
	movq	32(%rsp), %rbp                  # 8-byte Reload
	movq	%rbp, 400(%rsp)
	movq	24(%rsp), %r11                  # 8-byte Reload
	movq	%r11, 408(%rsp)
	movq	16(%rsp), %r10                  # 8-byte Reload
	movq	%r10, 416(%rsp)
	movq	%r13, 424(%rsp)
	movq	%rdi, %rsi
	shrq	$51, %rsi
	movq	%r13, %rax
	movl	$121666, %r14d                  # imm = 0x1DB42
	mulq	%r14
	movq	%rdx, %r9
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%r10, %rax
	mulq	%r14
	movq	%rdx, %r13
	movq	%rax, %r10
	movq	%r11, %rax
	mulq	%r14
	movq	%rax, %r11
	movq	%rdx, %r12
	addq	%r8, %rsi
	movq	%rsi, 104(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r14
	movq	%rdx, %r8
	movq	%rax, %rbx
	movq	%r15, %rax
	mulq	%r14
	shldq	$13, %rax, %rdx
	movabsq	$2251799813685247, %r15         # imm = 0x7FFFFFFFFFFFF
	leaq	-1(%r15), %r14
	andq	%rax, %r14
	andq	%r15, %rcx
	andq	%r15, %rdi
	movq	%rdi, 112(%rsp)                 # 8-byte Spill
	addq	%rbx, %rdx
	adcq	$0, %r8
	shldq	$13, %rdx, %r8
	andq	%r15, %rdx
	addq	%r11, %r8
	adcq	$0, %r12
	shldq	$13, %r8, %r12
	andq	%r15, %r8
	addq	%r10, %r12
	adcq	$0, %r13
	shldq	$13, %r12, %r13
	andq	%r15, %r12
	movq	%r12, 16(%rsp)                  # 8-byte Spill
	addq	8(%rsp), %r13                   # 8-byte Folded Reload
	adcq	$0, %r9
	movq	%rcx, 192(%rsp)
	shldq	$13, %r13, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %rax
	addq	%r14, %rax
	movq	%rax, %rsi
	movq	%rax, %rdi
	shrq	$51, %rsi
	addq	%rdx, %rsi
	movq	%rsi, %rax
	shrq	$51, %rax
	addq	%r8, %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%r15, %rbx
	andq	%r15, %r13
	movq	%r13, 32(%rsp)                  # 8-byte Spill
	andq	%r15, %rdi
	movq	%rdi, 8(%rsp)                   # 8-byte Spill
	movq	120(%rsp), %r15                 # 8-byte Reload
	leaq	(%r15,%r15,8), %rax
	leaq	(%r15,%rax,2), %rax
	mulq	%r15
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	movq	128(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	imulq	$38, %r15, %r9
	movq	%r9, %rax
	mulq	%rcx
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	imulq	$38, %rcx, %r10
	leaq	(%rcx,%rcx), %r8
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	movq	136(%rsp), %rcx                 # 8-byte Reload
	mulq	%rcx
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, 240(%rsp)                 # 8-byte Spill
	movq	%r10, %rax
	mulq	%rcx
	movq	%rax, 352(%rsp)                 # 8-byte Spill
	movq	%rdx, 360(%rsp)                 # 8-byte Spill
	leaq	(%rcx,%rcx), %r11
	movq	%rcx, %rax
	mulq	%rcx
	movq	%rdx, 376(%rsp)                 # 8-byte Spill
	movq	%rax, 368(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	movq	144(%rsp), %rcx                 # 8-byte Reload
	mulq	%rcx
	movq	%rdx, 344(%rsp)                 # 8-byte Spill
	movq	%rax, 336(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%rcx
	movq	%rax, %r10
	movq	%rdx, %r9
	addq	%r15, %r15
	movq	%r11, %rax
	mulq	%rcx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	%rcx
	movq	%rcx, %r14
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	%rax, 384(%rsp)                 # 8-byte Spill
	movq	%r15, %rax
	movq	152(%rsp), %rcx                 # 8-byte Reload
	mulq	%rcx
	movq	%rax, %r15
	movq	%rdx, %rdi
	leaq	(%r14,%r14), %r13
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, %rbp
	movq	%rax, %r14
	movq	%r11, %rax
	mulq	%rcx
	movq	%rdx, %r12
	movq	%rax, %r11
	movq	%r13, %rax
	mulq	%rcx
	movq	%rax, %r13
	movq	%rdx, %r8
	andq	%rbx, %rsi
	movq	%rcx, %rax
	mulq	%rcx
	addq	352(%rsp), %rax                 # 8-byte Folded Reload
	adcq	360(%rsp), %rdx                 # 8-byte Folded Reload
	addq	336(%rsp), %rax                 # 8-byte Folded Reload
	adcq	344(%rsp), %rdx                 # 8-byte Folded Reload
	shldq	$13, %rax, %rdx
	andq	%rbx, %rax
	addq	368(%rsp), %r10                 # 8-byte Folded Reload
	adcq	376(%rsp), %r9                  # 8-byte Folded Reload
	movq	112(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, 200(%rsp)
	addq	%r15, %r10
	adcq	%rdi, %r9
	movq	104(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, 208(%rsp)
	addq	48(%rsp), %r13                  # 8-byte Folded Reload
	adcq	64(%rsp), %r8                   # 8-byte Folded Reload
	addq	240(%rsp), %r13                 # 8-byte Folded Reload
	adcq	56(%rsp), %r8                   # 8-byte Folded Reload
	addq	%rdx, %r13
	adcq	$0, %r8
	shldq	$13, %r13, %r8
	andq	%rbx, %r13
	addq	384(%rsp), %r11                 # 8-byte Folded Reload
	adcq	120(%rsp), %r12                 # 8-byte Folded Reload
	addq	72(%rsp), %r11                  # 8-byte Folded Reload
	adcq	80(%rsp), %r12                  # 8-byte Folded Reload
	addq	%r8, %r11
	adcq	$0, %r12
	shldq	$13, %r11, %r12
	andq	%rbx, %r11
	addq	128(%rsp), %r14                 # 8-byte Folded Reload
	adcq	136(%rsp), %rbp                 # 8-byte Folded Reload
	addq	88(%rsp), %r14                  # 8-byte Folded Reload
	adcq	96(%rsp), %rbp                  # 8-byte Folded Reload
	addq	%r12, %r14
	adcq	$0, %rbp
	shldq	$13, %r14, %rbp
	andq	%rbx, %r14
	movq	%rbx, %rdi
	addq	%r10, %rbp
	adcq	$0, %r9
	shldq	$13, %rbp, %r9
	leaq	(%r9,%r9,8), %rdx
	leaq	(%r9,%rdx,2), %r15
	addq	%rax, %r15
	movq	%r15, %rbx
	shrq	$51, %rbx
	addq	%r13, %rbx
	movq	%rbx, %r12
	shrq	$51, %r12
	addq	%r11, %r12
	movq	8(%rsp), %rax                   # 8-byte Reload
	movq	%rax, 256(%rsp)
	addq	184(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, %rdx
	movq	%rsi, 264(%rsp)
	addq	40(%rsp), %rsi                  # 8-byte Folded Reload
	movq	24(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 272(%rsp)
	addq	168(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, %r8
	movq	16(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 280(%rsp)
	addq	160(%rsp), %rax                 # 8-byte Folded Reload
	movq	32(%rsp), %rcx                  # 8-byte Reload
	movq	%rcx, 288(%rsp)
	addq	176(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rdx, 432(%rsp)
	movq	%rsi, 440(%rsp)
	movq	%r8, 448(%rsp)
	movq	%rax, 456(%rsp)
	movq	%rcx, 464(%rsp)
	punpcklqdq	%xmm0, %xmm1            # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI121_0(%rip), %xmm1
	movdqu	%xmm1, 216(%rsp)
	andq	%rdi, %rbp
	andq	%rdi, %r15
	andq	%rdi, %rbx
	leaq	256(%rsp), %rdi
	leaq	696(%rsp), %rsi
	leaq	192(%rsp), %r13
	movq	%r13, %rdx
	callq	fe_mul_impl
	movq	%r13, %rdi
	leaq	392(%rsp), %rsi
	leaq	432(%rsp), %rdx
	callq	fe_mul_impl
	movl	252(%rsp), %eax                 # 4-byte Reload
	movq	536(%rsp), %rdx                 # 8-byte Reload
	addl	$-1, %eax
	jb	.LBB121_1
# %bb.2:
	negq	%rdx
	movq	296(%rsp), %rax
	movq	304(%rsp), %rcx
	xorq	%rax, %r15
	andq	%rdx, %r15
	xorq	%rax, %r15
	movq	%r15, 296(%rsp)
	xorq	%rcx, %rbx
	andq	%rdx, %rbx
	xorq	%rcx, %rbx
	movq	%rbx, 304(%rsp)
	movq	312(%rsp), %rax
	xorq	%rax, %r12
	andq	%rdx, %r12
	xorq	%rax, %r12
	movq	%r12, 312(%rsp)
	movq	320(%rsp), %rax
	xorq	%rax, %r14
	andq	%rdx, %r14
	xorq	%rax, %r14
	movq	%r14, 320(%rsp)
	movq	328(%rsp), %rax
	xorq	%rax, %rbp
	andq	%rdx, %rbp
	movq	%rdx, %xmm0
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	movdqa	%xmm0, %xmm1
	pandn	192(%rsp), %xmm1
	xorq	%rax, %rbp
	movdqa	256(%rsp), %xmm2
	pand	%xmm0, %xmm2
	por	%xmm1, %xmm2
	movdqa	%xmm2, 192(%rsp)
	movdqa	%xmm0, %xmm1
	pandn	208(%rsp), %xmm1
	movq	%rbp, 328(%rsp)
	pand	272(%rsp), %xmm0
	por	%xmm1, %xmm0
	movdqa	%xmm0, 208(%rsp)
	movq	224(%rsp), %rax
	movq	288(%rsp), %rcx
	xorq	%rax, %rcx
	andq	%rdx, %rcx
	xorq	%rax, %rcx
	movq	%rcx, 224(%rsp)
	movq	%rcx, 768(%rsp)
	movaps	208(%rsp), %xmm0
	movaps	%xmm0, 752(%rsp)
	movaps	192(%rsp), %xmm0
	movaps	%xmm0, 736(%rsp)
	leaq	192(%rsp), %rbx
	leaq	736(%rsp), %rsi
	movq	%rbx, %rdi
	callq	fe_loose_invert
	leaq	296(%rsp), %r14
	movq	%r14, %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	512(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	fe_tobytes
	movdqu	(%rbx), %xmm0
	movdqu	16(%rbx), %xmm1
	por	%xmm0, %xmm1
	pshufd	$238, %xmm1, %xmm0              # xmm0 = xmm1[2,3,2,3]
	por	%xmm1, %xmm0
	pshufd	$85, %xmm0, %xmm1               # xmm1 = xmm0[1,1,1,1]
	por	%xmm0, %xmm1
	movdqa	%xmm1, %xmm0
	psrld	$16, %xmm0
	por	%xmm1, %xmm0
	movdqa	%xmm0, %xmm1
	psrlw	$8, %xmm1
	por	%xmm0, %xmm1
	movd	%xmm1, %eax
	movzbl	%al, %ecx
	#APP
	#NO_APP
	xorl	%eax, %eax
	testl	%ecx, %ecx
	setne	%al
	addq	$776, %rsp                      # imm = 0x308
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end121:
	.size	X25519, .Lfunc_end121-X25519
                                        # -- End function
	.globl	X25519_public_from_private      # -- Begin function X25519_public_from_private
	.p2align	4, 0x90
	.type	X25519_public_from_private,@function
X25519_public_from_private:             # @X25519_public_from_private
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$328, %rsp                      # imm = 0x148
	movq	%rdi, 8(%rsp)                   # 8-byte Spill
	movups	(%rsi), %xmm0
	movups	16(%rsi), %xmm1
	movaps	%xmm0, 16(%rsp)
	movaps	%xmm1, 32(%rsp)
	andb	$-8, 16(%rsp)
	movzbl	47(%rsp), %eax
	andb	$63, %al
	orb	$64, %al
	movb	%al, 47(%rsp)
	leaq	128(%rsp), %rdi
	leaq	16(%rsp), %rsi
	callq	x25519_ge_scalarmult_base
	movq	208(%rsp), %rax
	movq	168(%rsp), %r9
	movq	176(%rsp), %r10
	leaq	(%r9,%rax), %rbx
	movq	216(%rsp), %rcx
	leaq	(%r10,%rcx), %r11
	movq	224(%rsp), %rdx
	movq	184(%rsp), %r14
	leaq	(%r14,%rdx), %r15
	movq	232(%rsp), %rsi
	movq	192(%rsp), %r12
	leaq	(%r12,%rsi), %r13
	movq	240(%rsp), %rdi
	movq	200(%rsp), %rbp
	leaq	(%rbp,%rdi), %r8
	movq	%rbx, 88(%rsp)
	movq	%r11, 96(%rsp)
	movq	%r15, 104(%rsp)
	movq	%r13, 112(%rsp)
	movq	%r8, 120(%rsp)
	movabsq	$4503599627370494, %r8          # imm = 0xFFFFFFFFFFFFE
	addq	%r8, %rax
	subq	%r9, %rax
	addq	$-36, %rax
	addq	%r8, %rcx
	subq	%r10, %rcx
	addq	%r8, %rdx
	subq	%r14, %rdx
	addq	%r8, %rsi
	subq	%r12, %rsi
	addq	%r8, %rdi
	subq	%rbp, %rdi
	movq	%rax, 48(%rsp)
	movq	%rcx, 56(%rsp)
	movq	%rdx, 64(%rsp)
	movq	%rsi, 72(%rsp)
	movq	%rdi, 80(%rsp)
	leaq	288(%rsp), %r14
	leaq	48(%rsp), %rsi
	movq	%r14, %rdi
	callq	fe_loose_invert
	leaq	88(%rsp), %rsi
	movq	%r14, %rdi
	movq	%r14, %rdx
	callq	fe_mul_impl
	movq	8(%rsp), %rdi                   # 8-byte Reload
	movq	%r14, %rsi
	callq	fe_tobytes
	addq	$328, %rsp                      # imm = 0x148
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end122:
	.size	X25519_public_from_private, .Lfunc_end122-X25519_public_from_private
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function fe_loose_invert
.LCPI123_0:
	.quad	2251799813685247                # 0x7ffffffffffff
	.quad	2251799813685247                # 0x7ffffffffffff
	.text
	.p2align	4, 0x90
	.type	fe_loose_invert,@function
fe_loose_invert:                        # @fe_loose_invert
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$360, %rsp                      # imm = 0x168
	movq	%rsi, %r12
	movq	32(%rsi), %r15
	leaq	(%r15,%r15,8), %rax
	leaq	(%r15,%rax,2), %rax
	imulq	$38, %r15, %r10
	movq	24(%rsi), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%r15
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	movq	16(%r12), %r8
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%r10
	movq	%rdx, %rbx
	movq	%rax, %r9
	movq	%r8, %rax
	mulq	%r11
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	addq	%rcx, %rcx
	movq	%r8, %rax
	mulq	%r8
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	8(%r12), %r14
	movq	%r12, 136(%rsp)                 # 8-byte Spill
	movq	%r14, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r13
	addq	%r8, %r8
	movq	%r14, %rax
	mulq	%rcx
	movq	%rdx, %rsi
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r8
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	%rax, %r11
	movq	%r14, %rax
	mulq	%r14
	movq	%rax, %rbp
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	leaq	(%r15,%r15), %rdx
	movq	(%r12), %r15
	movq	%r15, %rax
	mulq	%rdx
	movq	%rdx, 144(%rsp)                 # 8-byte Spill
	movq	%rax, 240(%rsp)                 # 8-byte Spill
	movq	%r15, %rax
	mulq	%rcx
	movq	%rax, 192(%rsp)                 # 8-byte Spill
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	leaq	(%r14,%r14), %rcx
	movq	%r15, %rax
	mulq	%r8
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%r15, %rax
	mulq	%rcx
	movq	%rdx, %r14
	movq	%rax, %r12
	movq	%r15, %rax
	mulq	%r15
	addq	32(%rsp), %r10                  # 8-byte Folded Reload
	adcq	40(%rsp), %r13                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r13
	shldq	$13, %r10, %r13
	movabsq	$2251799813685247, %r8          # imm = 0x7FFFFFFFFFFFF
	andq	%r8, %r10
	movq	16(%rsp), %rdx                  # 8-byte Reload
	addq	56(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	64(%rsp), %rsi                  # 8-byte Folded Reload
	addq	240(%rsp), %rdx                 # 8-byte Folded Reload
	adcq	144(%rsp), %rsi                 # 8-byte Folded Reload
	addq	72(%rsp), %r11                  # 8-byte Folded Reload
	movq	120(%rsp), %rax                 # 8-byte Reload
	adcq	80(%rsp), %rax                  # 8-byte Folded Reload
	addq	192(%rsp), %r11                 # 8-byte Folded Reload
	adcq	8(%rsp), %rax                   # 8-byte Folded Reload
	addq	88(%rsp), %rbp                  # 8-byte Folded Reload
	movq	128(%rsp), %rcx                 # 8-byte Reload
	adcq	96(%rsp), %rcx                  # 8-byte Folded Reload
	addq	24(%rsp), %rbp                  # 8-byte Folded Reload
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	104(%rsp), %r9                  # 8-byte Folded Reload
	adcq	112(%rsp), %rbx                 # 8-byte Folded Reload
	addq	%r12, %r9
	adcq	%r14, %rbx
	addq	%r13, %r9
	adcq	$0, %rbx
	shldq	$13, %r9, %rbx
	andq	%r8, %r9
	addq	%rbp, %rbx
	adcq	$0, %rcx
	shldq	$13, %rbx, %rcx
	andq	%r8, %rbx
	addq	%r11, %rcx
	adcq	$0, %rax
	shldq	$13, %rcx, %rax
	andq	%r8, %rcx
	movq	%rcx, %r11
	addq	%rdx, %rax
	adcq	$0, %rsi
	shldq	$13, %rax, %rsi
	andq	%r8, %rax
	movq	%rax, %rcx
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %r15
	addq	%r10, %r15
	movq	%r15, %r10
	shrq	$51, %r10
	addq	%r9, %r10
	movq	%r10, %r9
	shrq	$51, %r9
	addq	%rbx, %r9
	movq	%rcx, %rsi
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdx
	imulq	$38, %rcx, %rcx
	movq	%rsi, %rax
	leaq	(%r11,%r11,8), %rsi
	movq	%rax, %r14
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	mulq	%rdx
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	leaq	(%r11,%rsi,2), %rsi
	movq	%r11, %rax
	mulq	%rcx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, 192(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%rsi
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%rcx
	movq	%rax, %r12
	movq	%rdx, %rbx
	imulq	$38, %r11, %rdx
	movq	%r11, 128(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%rdx
	movq	%rdx, 144(%rsp)                 # 8-byte Spill
	movq	%rax, 240(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r9
	movq	%r9, 112(%rsp)                  # 8-byte Spill
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	andq	%r8, %r10
	movq	%r10, %rax
	mulq	%rcx
	movq	%rax, 264(%rsp)                 # 8-byte Spill
	movq	%rdx, 272(%rsp)                 # 8-byte Spill
	leaq	(%r11,%r11), %r13
	movq	%r10, %rax
	mulq	%r13
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%r9,%r9), %r11
	movq	%r11, %rax
	mulq	%r10
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r10, %rax
	mulq	%r10
	movq	%r10, %rcx
	movq	%r10, 104(%rsp)                 # 8-byte Spill
	movq	%rax, %rsi
	movq	%rdx, %r9
	andq	%r8, %r15
	movq	%r15, 96(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14), %rdx
	movq	%r15, %rax
	mulq	%rdx
	movq	%rdx, %rbp
	movq	%rax, %r14
	movq	%r15, %rax
	mulq	%r13
	movq	%rdx, %r13
	movq	%rax, %r10
	movq	%r11, %rax
	mulq	%r15
	movq	%rax, %r11
	movq	%rdx, 248(%rsp)                 # 8-byte Spill
	leaq	(%rcx,%rcx), %rax
	mulq	%r15
	movq	%rdx, %rcx
	movq	%rax, 256(%rsp)                 # 8-byte Spill
	movq	%r15, %rax
	mulq	%r15
	addq	264(%rsp), %rax                 # 8-byte Folded Reload
	adcq	272(%rsp), %rdx                 # 8-byte Folded Reload
	addq	240(%rsp), %rax                 # 8-byte Folded Reload
	adcq	144(%rsp), %rdx                 # 8-byte Folded Reload
	shldq	$13, %rax, %rdx
	andq	%r8, %rax
	addq	192(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	8(%rsp), %r9                    # 8-byte Folded Reload
	addq	%r11, %rsi
	adcq	248(%rsp), %r9                  # 8-byte Folded Reload
	addq	16(%rsp), %r12                  # 8-byte Folded Reload
	adcq	24(%rsp), %rbx                  # 8-byte Folded Reload
	addq	256(%rsp), %r12                 # 8-byte Folded Reload
	adcq	%rcx, %rbx
	addq	%rdx, %r12
	adcq	$0, %rbx
	movq	%rbx, %rcx
	shrq	$51, %rcx
	shldq	$13, %r12, %rbx
	andq	%r8, %r12
	addq	%rsi, %rbx
	adcq	%r9, %rcx
	movq	%rcx, %rdx
	shrq	$51, %rdx
	shldq	$13, %rbx, %rcx
	andq	%r8, %rbx
	addq	64(%rsp), %r10                  # 8-byte Folded Reload
	adcq	72(%rsp), %r13                  # 8-byte Folded Reload
	addq	32(%rsp), %r10                  # 8-byte Folded Reload
	adcq	40(%rsp), %r13                  # 8-byte Folded Reload
	addq	%rcx, %r10
	adcq	%rdx, %r13
	movq	%r13, %rcx
	shrq	$51, %rcx
	shldq	$13, %r10, %r13
	andq	%r8, %r10
	addq	48(%rsp), %r14                  # 8-byte Folded Reload
	adcq	56(%rsp), %rbp                  # 8-byte Folded Reload
	addq	80(%rsp), %r14                  # 8-byte Folded Reload
	adcq	88(%rsp), %rbp                  # 8-byte Folded Reload
	addq	%r13, %r14
	adcq	%rcx, %rbp
	shldq	$13, %r14, %rbp
	andq	%r8, %r14
	leaq	(,%rbp,8), %rcx
	addq	%rbp, %rcx
	leaq	(%rbp,%rcx,2), %rbp
	addq	%rax, %rbp
	movq	%rbp, %r13
	shrq	$51, %r13
	addq	%r12, %r13
	andq	%r8, %rbp
	movq	%r13, %rsi
	shrq	$51, %rsi
	addq	%rbx, %rsi
	andq	%r8, %r13
	leaq	(%r14,%r14,8), %rax
	leaq	(%r14,%rax,2), %rcx
	movq	%r14, %rax
	mulq	%rcx
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	leaq	(%r10,%r10,8), %rax
	leaq	(%r10,%rax,2), %rcx
	imulq	$38, %r14, %r8
	movq	%r10, %rax
	mulq	%r8
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%r10, %rax
	mulq	%rcx
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14), %r15
	movq	%rsi, %rax
	mulq	%r8
	movq	%rax, %r12
	movq	%rdx, %r14
	imulq	$38, %r10, %rcx
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	%rdx, 192(%rsp)                 # 8-byte Spill
	leaq	(%r10,%r10), %rbx
	movq	%rsi, %rax
	mulq	%rsi
	movq	%rdx, %r10
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r8
	movq	%rdx, 240(%rsp)                 # 8-byte Spill
	movq	%rax, 272(%rsp)                 # 8-byte Spill
	movq	%r13, %rax
	mulq	%rbx
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	leaq	(%rsi,%rsi), %rcx
	movq	%rcx, %rax
	mulq	%r13
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rdx, %r9
	movq	%rax, %r11
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, %r15
	movq	%rdx, %rsi
	movq	%r13, %r8
	addq	%r13, %r8
	movq	%rbp, %rax
	mulq	%rbx
	movq	%rdx, %r13
	movq	%rax, %rbx
	movq	%rcx, %rax
	mulq	%rbp
	movq	%rdx, 248(%rsp)                 # 8-byte Spill
	movq	%rax, %rcx
	movq	%r8, %rax
	mulq	%rbp
	movq	%rdx, 264(%rsp)                 # 8-byte Spill
	movq	%rax, 256(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rbp
	addq	272(%rsp), %rax                 # 8-byte Folded Reload
	adcq	240(%rsp), %rdx                 # 8-byte Folded Reload
	addq	144(%rsp), %rax                 # 8-byte Folded Reload
	adcq	192(%rsp), %rdx                 # 8-byte Folded Reload
	shldq	$13, %rax, %rdx
	movabsq	$2251799813685247, %r8          # imm = 0x7FFFFFFFFFFFF
	andq	%r8, %rax
	addq	8(%rsp), %r11                   # 8-byte Folded Reload
	adcq	16(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rcx, %r11
	adcq	248(%rsp), %r9                  # 8-byte Folded Reload
	movq	%rdi, 192(%rsp)                 # 8-byte Spill
	addq	24(%rsp), %r12                  # 8-byte Folded Reload
	adcq	32(%rsp), %r14                  # 8-byte Folded Reload
	movq	96(%rsp), %rcx                  # 8-byte Reload
	movq	%rcx, 320(%rsp)
	addq	256(%rsp), %r12                 # 8-byte Folded Reload
	adcq	264(%rsp), %r14                 # 8-byte Folded Reload
	movq	104(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, 328(%rsp)
	addq	%rdx, %r12
	adcq	$0, %r14
	movq	%r14, %rcx
	shrq	$51, %rcx
	shldq	$13, %r12, %r14
	andq	%r8, %r12
	addq	%r11, %r14
	adcq	%r9, %rcx
	movq	%rcx, %rdx
	shrq	$51, %rdx
	shldq	$13, %r14, %rcx
	andq	%r8, %r14
	addq	80(%rsp), %rbx                  # 8-byte Folded Reload
	adcq	88(%rsp), %r13                  # 8-byte Folded Reload
	movq	112(%rsp), %rdi                 # 8-byte Reload
	movq	%rdi, 336(%rsp)
	addq	40(%rsp), %rbx                  # 8-byte Folded Reload
	adcq	48(%rsp), %r13                  # 8-byte Folded Reload
	movq	128(%rsp), %rdi                 # 8-byte Reload
	movq	%rdi, 344(%rsp)
	addq	56(%rsp), %r15                  # 8-byte Folded Reload
	adcq	64(%rsp), %rsi                  # 8-byte Folded Reload
	movq	120(%rsp), %rdi                 # 8-byte Reload
	movq	%rdi, 352(%rsp)
	addq	72(%rsp), %r15                  # 8-byte Folded Reload
	adcq	%r10, %rsi
	addq	%rcx, %rbx
	adcq	%rdx, %r13
	movq	%r13, %rcx
	shrq	$51, %rcx
	shldq	$13, %rbx, %r13
	addq	%r15, %r13
	adcq	%rsi, %rcx
	shldq	$13, %r13, %rcx
	movq	%r13, %xmm0
	movq	%rbx, %xmm1
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rcx
	addq	%rax, %rcx
	movq	%rcx, %rax
	shrq	$51, %rax
	addq	%r12, %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	%r14, %rdx
	andq	%r8, %rcx
	movq	%rcx, 200(%rsp)
	andq	%r8, %rax
	movq	%rax, 208(%rsp)
	movq	%rdx, 216(%rsp)
	punpcklqdq	%xmm0, %xmm1            # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI123_0(%rip), %xmm1
	movdqu	%xmm1, 224(%rsp)
	leaq	200(%rsp), %rbx
	movq	%rbx, %rdi
	movq	136(%rsp), %rsi                 # 8-byte Reload
	movq	%rbx, %rdx
	callq	fe_mul_impl
	leaq	320(%rsp), %rdi
	movq	%rdi, %rsi
	movq	%rbx, %rdx
	callq	fe_mul_impl
	movq	352(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r9
	movq	344(%rsp), %rdi
	leaq	(%rdi,%rdi,8), %rcx
	leaq	(%rdi,%rcx,2), %rcx
	imulq	$38, %rdi, %r10
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%r9
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	336(%rsp), %r8
	movq	%rcx, %rax
	mulq	%rdi
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%r9
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	%r8, %rax
	mulq	%r10
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rdi,%rdi), %r12
	movq	%r8, %rax
	mulq	%r8
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	328(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%r9
	movq	%rax, %rdi
	movq	%rdx, %r15
	leaq	(%r8,%r8), %r10
	movq	%rbp, %rax
	mulq	%r12
	movq	%rdx, %r8
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r10
	movq	%rdx, %r9
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rbp
	movq	%rax, %r13
	movq	%rdx, %r11
	leaq	(%rbx,%rbx), %rdx
	movq	320(%rsp), %r14
	movq	%r14, %rax
	mulq	%rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rbx
	movq	%r14, %rax
	mulq	%r12
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rbp, %r12
	addq	%rbp, %r12
	movq	%r14, %rax
	mulq	%r10
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, %r12
	movq	%rax, %rbp
	movq	%r14, %rax
	mulq	%r14
	addq	48(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	56(%rsp), %r15                  # 8-byte Folded Reload
	addq	%rax, %rdi
	adcq	%rdx, %r15
	shldq	$13, %rdi, %r15
	movabsq	$2251799813685247, %r10         # imm = 0x7FFFFFFFFFFFF
	andq	%r10, %rdi
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r8                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	8(%rsp), %r8                    # 8-byte Folded Reload
	movq	72(%rsp), %rdx                  # 8-byte Reload
	addq	96(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	104(%rsp), %r9                  # 8-byte Folded Reload
	addq	16(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	24(%rsp), %r9                   # 8-byte Folded Reload
	addq	112(%rsp), %r13                 # 8-byte Folded Reload
	adcq	136(%rsp), %r11                 # 8-byte Folded Reload
	addq	40(%rsp), %r13                  # 8-byte Folded Reload
	adcq	64(%rsp), %r11                  # 8-byte Folded Reload
	addq	120(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	128(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rbp, %rsi
	adcq	%r12, %rcx
	addq	%r15, %rsi
	adcq	$0, %rcx
	shldq	$13, %rsi, %rcx
	andq	%r10, %rsi
	addq	%r13, %rcx
	adcq	$0, %r11
	shldq	$13, %rcx, %r11
	andq	%r10, %rcx
	addq	%rdx, %r11
	adcq	$0, %r9
	shldq	$13, %r11, %r9
	addq	%rax, %r9
	adcq	$0, %r8
	shldq	$13, %r9, %r8
	movq	%r9, %xmm0
	movq	%r11, %xmm1
	leaq	(%r8,%r8,8), %rax
	leaq	(%r8,%rax,2), %rax
	addq	%rdi, %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	%rsi, %rdx
	movq	%rdx, %rsi
	shrq	$51, %rsi
	addq	%rcx, %rsi
	andq	%r10, %rax
	movq	%rax, 152(%rsp)
	andq	%r10, %rdx
	movq	%rdx, 160(%rsp)
	movq	%rsi, 168(%rsp)
	punpcklqdq	%xmm0, %xmm1            # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI123_0(%rip), %xmm1
	movdqu	%xmm1, 176(%rsp)
	leaq	152(%rsp), %rdx
	leaq	200(%rsp), %rdi
	movq	%rdi, %rsi
	callq	fe_mul_impl
	movq	232(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r9
	movq	224(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r10
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r9
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	216(%rsp), %rdi
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, %rsi
	movq	%rax, %r8
	movq	%rdi, %rax
	mulq	%r10
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r13
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	208(%rsp), %r15
	movq	%r15, %rax
	mulq	%r9
	movq	%rax, %r9
	movq	%rdx, %r12
	leaq	(%rdi,%rdi), %r11
	movq	%r15, %rax
	mulq	%r13
	movq	%rdx, %r10
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r15, %rax
	mulq	%r11
	movq	%rdx, %rcx
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r15, %rax
	mulq	%r15
	movq	%rax, %rbp
	movq	%rdx, %rdi
	leaq	(%rbx,%rbx), %rdx
	movq	200(%rsp), %r14
	movq	%r14, %rax
	mulq	%rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rbx
	movq	%r14, %rax
	mulq	%r13
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	addq	%r15, %r15
	movq	%r14, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%r14, %rax
	mulq	%r14
	addq	48(%rsp), %r9                   # 8-byte Folded Reload
	adcq	56(%rsp), %r12                  # 8-byte Folded Reload
	addq	%rax, %r9
	adcq	%rdx, %r12
	shldq	$13, %r9, %r12
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r9
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r10                  # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	8(%rsp), %r10                   # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %rcx                 # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %rcx                  # 8-byte Folded Reload
	addq	112(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	136(%rsp), %rdi                 # 8-byte Folded Reload
	addq	40(%rsp), %rbp                  # 8-byte Folded Reload
	adcq	64(%rsp), %rdi                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rsi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rsi
	addq	%r12, %r8
	adcq	$0, %rsi
	shldq	$13, %r8, %rsi
	andq	%rdx, %r8
	addq	%rbp, %rsi
	adcq	$0, %rdi
	shldq	$13, %rsi, %rdi
	andq	%rdx, %rsi
	addq	%r11, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rax, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	leaq	(%r10,%r10,8), %rax
	leaq	(%r10,%rax,2), %r12
	addq	%r9, %r12
	movq	%r12, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	andq	%rdx, %r12
	movq	%r14, %r8
	shrq	$51, %r8
	addq	%rsi, %r8
	andq	%rdx, %r14
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdx
	imulq	$38, %rcx, %r10
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rdi,%rax,2), %rsi
	imulq	$38, %rdi, %r11
	movq	%rcx, %rax
	mulq	%rdx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%r10
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rsi
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	leaq	(%rdi,%rdi), %rbx
	movq	%r8, %rax
	mulq	%r10
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r8, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%r8, %rax
	mulq	%r8
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	leaq	(%r8,%r8), %r9
	movq	%r14, %rax
	mulq	%r10
	movq	%rdx, %r13
	movq	%rax, %r8
	movq	%r14, %rax
	mulq	%rbx
	movq	%rbx, %r10
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	%r14, %rax
	mulq	%r9
	movq	%rax, %rbx
	movq	%rdx, %r11
	leaq	(%rcx,%rcx), %rbp
	movq	%r14, %rax
	mulq	%r14
	movq	%rdx, %rcx
	movq	%rax, %r15
	movq	%r12, %rax
	mulq	%rbp
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%r12, %rax
	mulq	%r10
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14), %rbp
	movq	%r12, %rax
	mulq	%r9
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, %r14
	movq	%r12, %rax
	mulq	%rbp
	movq	%rdx, %rbp
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r12, %rax
	mulq	%r12
	addq	40(%rsp), %r8                   # 8-byte Folded Reload
	adcq	64(%rsp), %r13                  # 8-byte Folded Reload
	addq	%rax, %r8
	adcq	%rdx, %r13
	shldq	$13, %r8, %r13
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r8
	movq	144(%rsp), %r10                 # 8-byte Reload
	addq	80(%rsp), %r10                  # 8-byte Folded Reload
	movq	48(%rsp), %r9                   # 8-byte Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	8(%rsp), %r10                   # 8-byte Folded Reload
	adcq	16(%rsp), %r9                   # 8-byte Folded Reload
	addq	96(%rsp), %rbx                  # 8-byte Folded Reload
	adcq	104(%rsp), %r11                 # 8-byte Folded Reload
	addq	24(%rsp), %rbx                  # 8-byte Folded Reload
	adcq	32(%rsp), %r11                  # 8-byte Folded Reload
	addq	112(%rsp), %r15                 # 8-byte Folded Reload
	adcq	136(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r14, %r15
	adcq	56(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	128(%rsp), %rsi                 # 8-byte Folded Reload
	addq	72(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	%rbp, %rsi
	addq	%r13, %rdi
	adcq	$0, %rsi
	movq	%rsi, %r12
	shrq	$51, %r12
	shldq	$13, %rdi, %rsi
	andq	%rdx, %rdi
	addq	%r15, %rsi
	adcq	%rcx, %r12
	movq	%r12, %rbp
	shrq	$51, %rbp
	shldq	$13, %rsi, %r12
	andq	%rdx, %rsi
	addq	%rbx, %r12
	adcq	%r11, %rbp
	movq	%rbp, %rax
	shrq	$51, %rax
	shldq	$13, %r12, %rbp
	andq	%rdx, %r12
	addq	%r10, %rbp
	adcq	%r9, %rax
	shldq	$13, %rbp, %rax
	andq	%rdx, %rbp
	leaq	(%rax,%rax,8), %rcx
	leaq	(%rax,%rcx,2), %rbx
	addq	%r8, %rbx
	movq	%rbx, %r14
	shrq	$51, %r14
	addq	%rdi, %r14
	andq	%rdx, %rbx
	movq	%r14, %rdi
	shrq	$51, %rdi
	addq	%rsi, %rdi
	andq	%rdx, %r14
	leaq	(,%rbp,8), %rax
	addq	%rbp, %rax
	leaq	(,%rax,2), %rcx
	addq	%rbp, %rcx
	imulq	$38, %rbp, %r9
	leaq	(%r12,%r12,8), %rax
	leaq	(%r12,%rax,2), %rsi
	imulq	$38, %r12, %r10
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%r12, %rax
	mulq	%r9
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%r12, %rax
	mulq	%rsi
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	leaq	(%r12,%r12), %r11
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	%r10
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	leaq	(%rdi,%rdi), %r8
	movq	%r14, %rax
	mulq	%r9
	movq	%rdx, %r12
	movq	%rax, %rdi
	movq	%r14, %rax
	mulq	%r11
	movq	%r11, %r9
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	%r14, %rax
	mulq	%r8
	movq	%rax, %r11
	movq	%rdx, %r10
	movq	%rbp, %r13
	addq	%rbp, %r13
	movq	%r14, %rax
	mulq	%r14
	movq	%rdx, %rbp
	movq	%rax, %r15
	movq	%rbx, %rax
	mulq	%r13
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r9
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14), %r13
	movq	%rbx, %rax
	mulq	%r8
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	%r13
	movq	%rdx, %r13
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	%rbx
	addq	40(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	64(%rsp), %r12                  # 8-byte Folded Reload
	addq	%rax, %rdi
	adcq	%rdx, %r12
	shldq	$13, %rdi, %r12
	movabsq	$2251799813685247, %r8          # imm = 0x7FFFFFFFFFFFF
	andq	%r8, %rdi
	movq	144(%rsp), %r9                  # 8-byte Reload
	addq	80(%rsp), %r9                   # 8-byte Folded Reload
	movq	48(%rsp), %rdx                  # 8-byte Reload
	adcq	88(%rsp), %rdx                  # 8-byte Folded Reload
	addq	8(%rsp), %r9                    # 8-byte Folded Reload
	adcq	16(%rsp), %rdx                  # 8-byte Folded Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %r10                 # 8-byte Folded Reload
	addq	24(%rsp), %r11                  # 8-byte Folded Reload
	adcq	32(%rsp), %r10                  # 8-byte Folded Reload
	addq	112(%rsp), %r15                 # 8-byte Folded Reload
	adcq	136(%rsp), %rbp                 # 8-byte Folded Reload
	addq	%r14, %r15
	adcq	56(%rsp), %rbp                  # 8-byte Folded Reload
	addq	120(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	128(%rsp), %rcx                 # 8-byte Folded Reload
	addq	72(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	%r13, %rcx
	addq	%r12, %rsi
	adcq	$0, %rcx
	movq	%rcx, %r12
	shrq	$51, %r12
	shldq	$13, %rsi, %rcx
	andq	%r8, %rsi
	addq	%r15, %rcx
	adcq	%rbp, %r12
	movq	%r12, %rbp
	shrq	$51, %rbp
	shldq	$13, %rcx, %r12
	andq	%r8, %rcx
	addq	%r11, %r12
	adcq	%r10, %rbp
	movq	%rbp, %rax
	shrq	$51, %rax
	shldq	$13, %r12, %rbp
	andq	%r8, %r12
	addq	%r9, %rbp
	adcq	%rdx, %rax
	shldq	$13, %rbp, %rax
	andq	%r8, %rbp
	leaq	(%rax,%rax,8), %rdx
	leaq	(%rax,%rdx,2), %rbx
	addq	%rdi, %rbx
	movq	%rbx, %r14
	shrq	$51, %r14
	addq	%rsi, %r14
	andq	%r8, %rbx
	movq	%r14, %rdi
	shrq	$51, %rdi
	addq	%rcx, %rdi
	andq	%r8, %r14
	leaq	(,%rbp,8), %rax
	addq	%rbp, %rax
	leaq	(,%rax,2), %rcx
	addq	%rbp, %rcx
	imulq	$38, %rbp, %r9
	leaq	(%r12,%r12,8), %rax
	leaq	(%r12,%rax,2), %rsi
	imulq	$38, %r12, %r10
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%r12, %rax
	mulq	%r9
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%r12, %rax
	mulq	%rsi
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	leaq	(%r12,%r12), %r11
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	%r10
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	leaq	(%rdi,%rdi), %r8
	movq	%r14, %rax
	mulq	%r9
	movq	%rdx, %r12
	movq	%rax, %rdi
	movq	%r14, %rax
	mulq	%r11
	movq	%r11, %r9
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	%r14, %rax
	mulq	%r8
	movq	%rax, %r11
	movq	%rdx, %r10
	movq	%rbp, %r13
	addq	%rbp, %r13
	movq	%r14, %rax
	mulq	%r14
	movq	%rdx, %rbp
	movq	%rax, %r15
	movq	%rbx, %rax
	mulq	%r13
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r9
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14), %r13
	movq	%rbx, %rax
	mulq	%r8
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	%r13
	movq	%rdx, %r13
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	%rbx
	addq	40(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	64(%rsp), %r12                  # 8-byte Folded Reload
	addq	%rax, %rdi
	adcq	%rdx, %r12
	shldq	$13, %rdi, %r12
	movabsq	$2251799813685247, %r8          # imm = 0x7FFFFFFFFFFFF
	andq	%r8, %rdi
	movq	144(%rsp), %r9                  # 8-byte Reload
	addq	80(%rsp), %r9                   # 8-byte Folded Reload
	movq	48(%rsp), %rdx                  # 8-byte Reload
	adcq	88(%rsp), %rdx                  # 8-byte Folded Reload
	addq	8(%rsp), %r9                    # 8-byte Folded Reload
	adcq	16(%rsp), %rdx                  # 8-byte Folded Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %r10                 # 8-byte Folded Reload
	addq	24(%rsp), %r11                  # 8-byte Folded Reload
	adcq	32(%rsp), %r10                  # 8-byte Folded Reload
	addq	112(%rsp), %r15                 # 8-byte Folded Reload
	adcq	136(%rsp), %rbp                 # 8-byte Folded Reload
	addq	%r14, %r15
	adcq	56(%rsp), %rbp                  # 8-byte Folded Reload
	addq	120(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	128(%rsp), %rcx                 # 8-byte Folded Reload
	addq	72(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	%r13, %rcx
	addq	%r12, %rsi
	adcq	$0, %rcx
	movq	%rcx, %r12
	shrq	$51, %r12
	shldq	$13, %rsi, %rcx
	andq	%r8, %rsi
	addq	%r15, %rcx
	adcq	%rbp, %r12
	movq	%r12, %rbp
	shrq	$51, %rbp
	shldq	$13, %rcx, %r12
	andq	%r8, %rcx
	addq	%r11, %r12
	adcq	%r10, %rbp
	movq	%rbp, %rax
	shrq	$51, %rax
	shldq	$13, %r12, %rbp
	andq	%r8, %r12
	addq	%r9, %rbp
	adcq	%rdx, %rax
	shldq	$13, %rbp, %rax
	andq	%r8, %rbp
	leaq	(%rax,%rax,8), %rdx
	leaq	(%rax,%rdx,2), %rbx
	addq	%rdi, %rbx
	movq	%rbx, %r14
	shrq	$51, %r14
	addq	%rsi, %r14
	andq	%r8, %rbx
	movq	%r14, %rdi
	shrq	$51, %rdi
	addq	%rcx, %rdi
	andq	%r8, %r14
	leaq	(,%rbp,8), %rax
	addq	%rbp, %rax
	leaq	(,%rax,2), %rcx
	addq	%rbp, %rcx
	imulq	$38, %rbp, %r9
	leaq	(%r12,%r12,8), %rax
	leaq	(%r12,%rax,2), %rsi
	imulq	$38, %r12, %r10
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%r12, %rax
	mulq	%r9
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%r12, %rax
	mulq	%rsi
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	leaq	(%r12,%r12), %r11
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	%r10
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	leaq	(%rdi,%rdi), %r8
	movq	%r14, %rax
	mulq	%r9
	movq	%rdx, %r12
	movq	%rax, %rdi
	movq	%r14, %rax
	mulq	%r11
	movq	%r11, %r9
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	%r14, %rax
	mulq	%r8
	movq	%rax, %r11
	movq	%rdx, %r10
	movq	%rbp, %r13
	addq	%rbp, %r13
	movq	%r14, %rax
	mulq	%r14
	movq	%rdx, %rbp
	movq	%rax, %r15
	movq	%rbx, %rax
	mulq	%r13
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r9
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14), %r13
	movq	%rbx, %rax
	mulq	%r8
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	%r13
	movq	%rdx, %r8
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	%rbx
	addq	40(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	64(%rsp), %r12                  # 8-byte Folded Reload
	addq	%rax, %rdi
	adcq	%rdx, %r12
	shldq	$13, %rdi, %r12
	movabsq	$2251799813685247, %rbx         # imm = 0x7FFFFFFFFFFFF
	andq	%rbx, %rdi
	movq	144(%rsp), %r9                  # 8-byte Reload
	addq	80(%rsp), %r9                   # 8-byte Folded Reload
	movq	48(%rsp), %r13                  # 8-byte Reload
	adcq	88(%rsp), %r13                  # 8-byte Folded Reload
	addq	8(%rsp), %r9                    # 8-byte Folded Reload
	adcq	16(%rsp), %r13                  # 8-byte Folded Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %r10                 # 8-byte Folded Reload
	addq	24(%rsp), %r11                  # 8-byte Folded Reload
	adcq	32(%rsp), %r10                  # 8-byte Folded Reload
	addq	112(%rsp), %r15                 # 8-byte Folded Reload
	adcq	136(%rsp), %rbp                 # 8-byte Folded Reload
	addq	%r14, %r15
	adcq	56(%rsp), %rbp                  # 8-byte Folded Reload
	addq	120(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	128(%rsp), %rcx                 # 8-byte Folded Reload
	addq	72(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	%r8, %rcx
	addq	%r12, %rsi
	adcq	$0, %rcx
	movq	%rcx, %rax
	shrq	$51, %rax
	shldq	$13, %rsi, %rcx
	andq	%rbx, %rsi
	addq	%r15, %rcx
	adcq	%rbp, %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	shldq	$13, %rcx, %rax
	andq	%rbx, %rcx
	addq	%r11, %rax
	adcq	%r10, %rdx
	movq	%rdx, %r8
	shrq	$51, %r8
	shldq	$13, %rax, %rdx
	addq	%r9, %rdx
	adcq	%r13, %r8
	shldq	$13, %rdx, %r8
	movq	%rdx, %xmm0
	movq	%rax, %xmm1
	leaq	(%r8,%r8,8), %rax
	leaq	(%r8,%rax,2), %rax
	addq	%rdi, %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	%rsi, %rdx
	movq	%rdx, %rsi
	shrq	$51, %rsi
	addq	%rcx, %rsi
	punpcklqdq	%xmm0, %xmm1            # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI123_0(%rip), %xmm1
	movdqu	%xmm1, 176(%rsp)
	movq	%rsi, 168(%rsp)
	andq	%rbx, %rdx
	movq	%rdx, 160(%rsp)
	andq	%rbx, %rax
	movq	%rax, 152(%rsp)
	leaq	200(%rsp), %rdi
	leaq	152(%rsp), %rsi
	movq	%rdi, %rdx
	callq	fe_mul_impl
	movq	232(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r10
	movq	224(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	216(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	208(%rsp), %r13
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	200(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r14
	shldq	$13, %r10, %r14
	movabsq	$2251799813685247, %rax         # imm = 0x7FFFFFFFFFFFF
	andq	%rax, %r10
	movq	32(%rsp), %r11                  # 8-byte Reload
	addq	80(%rsp), %r11                  # 8-byte Folded Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %r11
	adcq	8(%rsp), %r9                    # 8-byte Folded Reload
	movq	72(%rsp), %rdx                  # 8-byte Reload
	addq	96(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	104(%rsp), %rsi                 # 8-byte Folded Reload
	addq	16(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	136(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r14, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rax, %r8
	addq	%r12, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rax, %rdi
	addq	%rdx, %rcx
	adcq	$0, %rsi
	shldq	$13, %rcx, %rsi
	andq	%rax, %rcx
	movq	%rax, %rdx
	addq	%r11, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	andq	%rdx, %rsi
	addq	%r10, %r9
	movq	%r9, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	andq	%rdx, %r9
	movq	%r14, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	andq	%rdx, %r14
	movl	$9, %eax
	.p2align	4, 0x90
.LBB123_1:                              # =>This Inner Loop Header: Depth=1
	movl	%eax, 128(%rsp)                 # 4-byte Spill
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	imulq	$38, %rsi, %r10
	mulq	%rsi
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rdi
	imulq	$38, %rcx, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r12
	leaq	(%r11,%r11), %r13
	movq	%r14, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %rbx
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, %r15
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %rsi
	movq	%r14, %rax
	mulq	%r14
	movq	%rax, %rbp
	movq	%rdx, %rcx
	movq	%r9, %rax
	mulq	%rsi
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%r12
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14), %r12
	movq	%r9, %rax
	mulq	%r13
	movq	%rax, %r14
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r12
	movq	%rdx, %r12
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	%r9
	addq	40(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %rbx                  # 8-byte Folded Reload
	addq	%rax, %r11
	adcq	%rdx, %rbx
	shldq	$13, %r11, %rbx
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r11
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %r15                  # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	8(%rsp), %r15                   # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	addq	104(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	112(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r14, %rbp
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	136(%rsp), %r8                  # 8-byte Folded Reload
	adcq	120(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r12, %rdi
	addq	%rbx, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%rbp, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rsi, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	addq	%rax, %r10
	adcq	$0, %r15
	shldq	$13, %r10, %r15
	leaq	(%r15,%r15,8), %rax
	leaq	(%r15,%rax,2), %r9
	movl	128(%rsp), %eax                 # 4-byte Reload
	addq	%r11, %r9
	movq	%r9, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	movq	%r14, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r10, %rsi
	andq	%rdx, %rsi
	andq	%rdx, %r9
	andq	%rdx, %r14
	decl	%eax
	jne	.LBB123_1
# %bb.2:
	movq	%rsi, 184(%rsp)
	movq	%rcx, 176(%rsp)
	movq	%r11, 168(%rsp)
	movq	%r14, 160(%rsp)
	movq	%r9, 152(%rsp)
	leaq	152(%rsp), %rdi
	leaq	200(%rsp), %rdx
	movq	%rdi, %rsi
	callq	fe_mul_impl
	movq	184(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r10
	movq	176(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	168(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	160(%rsp), %r13
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	152(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r14
	shldq	$13, %r10, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r10
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	8(%rsp), %r9                    # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %rsi                 # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	136(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r14, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%r12, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%r11, %rcx
	adcq	$0, %rsi
	shldq	$13, %rcx, %rsi
	andq	%rdx, %rcx
	addq	%rax, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	andq	%rdx, %rsi
	addq	%r10, %r9
	movq	%r9, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	andq	%rdx, %r9
	movq	%r14, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	andq	%rdx, %r14
	movl	$19, %eax
	.p2align	4, 0x90
.LBB123_3:                              # =>This Inner Loop Header: Depth=1
	movl	%eax, 128(%rsp)                 # 4-byte Spill
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	imulq	$38, %rsi, %r10
	mulq	%rsi
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rdi
	imulq	$38, %rcx, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r12
	leaq	(%r11,%r11), %r13
	movq	%r14, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %rbx
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, %r15
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %rsi
	movq	%r14, %rax
	mulq	%r14
	movq	%rax, %rbp
	movq	%rdx, %rcx
	movq	%r9, %rax
	mulq	%rsi
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%r12
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14), %r12
	movq	%r9, %rax
	mulq	%r13
	movq	%rax, %r14
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r12
	movq	%rdx, %r12
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	%r9
	addq	40(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %rbx                  # 8-byte Folded Reload
	addq	%rax, %r11
	adcq	%rdx, %rbx
	shldq	$13, %r11, %rbx
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r11
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %r15                  # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	8(%rsp), %r15                   # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	addq	104(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	112(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r14, %rbp
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	136(%rsp), %r8                  # 8-byte Folded Reload
	adcq	120(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r12, %rdi
	addq	%rbx, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%rbp, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rsi, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	addq	%rax, %r10
	adcq	$0, %r15
	shldq	$13, %r10, %r15
	leaq	(%r15,%r15,8), %rax
	leaq	(%r15,%rax,2), %r9
	movl	128(%rsp), %eax                 # 4-byte Reload
	addq	%r11, %r9
	movq	%r9, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	movq	%r14, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r10, %rsi
	andq	%rdx, %rsi
	andq	%rdx, %r9
	andq	%rdx, %r14
	decl	%eax
	jne	.LBB123_3
# %bb.4:
	movq	%rsi, 312(%rsp)
	movq	%rcx, 304(%rsp)
	movq	%r11, 296(%rsp)
	movq	%r14, 288(%rsp)
	movq	%r9, 280(%rsp)
	leaq	280(%rsp), %rsi
	leaq	152(%rsp), %rdi
	movq	%rdi, %rdx
	callq	fe_mul_impl
	movq	184(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r10
	movq	176(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	168(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	160(%rsp), %r13
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	152(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r14
	shldq	$13, %r10, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r10
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	8(%rsp), %r9                    # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %rsi                 # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	136(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r14, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%r12, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%r11, %rcx
	adcq	$0, %rsi
	shldq	$13, %rcx, %rsi
	andq	%rdx, %rcx
	addq	%rax, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	andq	%rdx, %rsi
	addq	%r10, %r9
	movq	%r9, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	andq	%rdx, %r9
	movq	%r14, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	andq	%rdx, %r14
	movl	$9, %eax
	.p2align	4, 0x90
.LBB123_5:                              # =>This Inner Loop Header: Depth=1
	movl	%eax, 128(%rsp)                 # 4-byte Spill
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	imulq	$38, %rsi, %r10
	mulq	%rsi
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rdi
	imulq	$38, %rcx, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r12
	leaq	(%r11,%r11), %r13
	movq	%r14, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %rbx
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, %r15
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %rsi
	movq	%r14, %rax
	mulq	%r14
	movq	%rax, %rbp
	movq	%rdx, %rcx
	movq	%r9, %rax
	mulq	%rsi
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%r12
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14), %r12
	movq	%r9, %rax
	mulq	%r13
	movq	%rax, %r14
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r12
	movq	%rdx, %r12
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	%r9
	addq	40(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %rbx                  # 8-byte Folded Reload
	addq	%rax, %r11
	adcq	%rdx, %rbx
	shldq	$13, %r11, %rbx
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r11
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %r15                  # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	8(%rsp), %r15                   # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	addq	104(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	112(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r14, %rbp
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	136(%rsp), %r8                  # 8-byte Folded Reload
	adcq	120(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r12, %rdi
	addq	%rbx, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%rbp, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rsi, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	addq	%rax, %r10
	adcq	$0, %r15
	shldq	$13, %r10, %r15
	leaq	(%r15,%r15,8), %rax
	leaq	(%r15,%rax,2), %r9
	movl	128(%rsp), %eax                 # 4-byte Reload
	addq	%r11, %r9
	movq	%r9, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	movq	%r14, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r10, %rsi
	andq	%rdx, %rsi
	andq	%rdx, %r9
	andq	%rdx, %r14
	decl	%eax
	jne	.LBB123_5
# %bb.6:
	movq	%rsi, 184(%rsp)
	movq	%rcx, 176(%rsp)
	movq	%r11, 168(%rsp)
	movq	%r14, 160(%rsp)
	movq	%r9, 152(%rsp)
	leaq	152(%rsp), %rsi
	leaq	200(%rsp), %rdi
	movq	%rdi, %rdx
	callq	fe_mul_impl
	movq	232(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r10
	movq	224(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	216(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	208(%rsp), %r13
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	200(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r14
	shldq	$13, %r10, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r10
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	8(%rsp), %r9                    # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %rsi                 # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	136(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r14, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%r12, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%r11, %rcx
	adcq	$0, %rsi
	shldq	$13, %rcx, %rsi
	andq	%rdx, %rcx
	addq	%rax, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	andq	%rdx, %rsi
	addq	%r10, %r9
	movq	%r9, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	andq	%rdx, %r9
	movq	%r14, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	andq	%rdx, %r14
	movl	$49, %eax
	.p2align	4, 0x90
.LBB123_7:                              # =>This Inner Loop Header: Depth=1
	movl	%eax, 128(%rsp)                 # 4-byte Spill
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	imulq	$38, %rsi, %r10
	mulq	%rsi
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rdi
	imulq	$38, %rcx, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r12
	leaq	(%r11,%r11), %r13
	movq	%r14, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %rbx
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, %r15
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %rsi
	movq	%r14, %rax
	mulq	%r14
	movq	%rax, %rbp
	movq	%rdx, %rcx
	movq	%r9, %rax
	mulq	%rsi
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%r12
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14), %r12
	movq	%r9, %rax
	mulq	%r13
	movq	%rax, %r14
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r12
	movq	%rdx, %r12
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	%r9
	addq	40(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %rbx                  # 8-byte Folded Reload
	addq	%rax, %r11
	adcq	%rdx, %rbx
	shldq	$13, %r11, %rbx
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r11
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %r15                  # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	8(%rsp), %r15                   # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	addq	104(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	112(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r14, %rbp
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	136(%rsp), %r8                  # 8-byte Folded Reload
	adcq	120(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r12, %rdi
	addq	%rbx, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%rbp, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rsi, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	addq	%rax, %r10
	adcq	$0, %r15
	shldq	$13, %r10, %r15
	leaq	(%r15,%r15,8), %rax
	leaq	(%r15,%rax,2), %r9
	movl	128(%rsp), %eax                 # 4-byte Reload
	addq	%r11, %r9
	movq	%r9, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	movq	%r14, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r10, %rsi
	andq	%rdx, %rsi
	andq	%rdx, %r9
	andq	%rdx, %r14
	decl	%eax
	jne	.LBB123_7
# %bb.8:
	movq	%rsi, 184(%rsp)
	movq	%rcx, 176(%rsp)
	movq	%r11, 168(%rsp)
	movq	%r14, 160(%rsp)
	movq	%r9, 152(%rsp)
	leaq	152(%rsp), %rdi
	leaq	200(%rsp), %rdx
	movq	%rdi, %rsi
	callq	fe_mul_impl
	movq	184(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r10
	movq	176(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	168(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	160(%rsp), %r13
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	152(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r14
	shldq	$13, %r10, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r10
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	8(%rsp), %r9                    # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %rsi                 # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	136(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r14, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%r12, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%r11, %rcx
	adcq	$0, %rsi
	shldq	$13, %rcx, %rsi
	andq	%rdx, %rcx
	addq	%rax, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	andq	%rdx, %rsi
	addq	%r10, %r9
	movq	%r9, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	andq	%rdx, %r9
	movq	%r14, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	andq	%rdx, %r14
	movl	$99, %eax
	.p2align	4, 0x90
.LBB123_9:                              # =>This Inner Loop Header: Depth=1
	movl	%eax, 128(%rsp)                 # 4-byte Spill
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	imulq	$38, %rsi, %r10
	mulq	%rsi
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rdi
	imulq	$38, %rcx, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r12
	leaq	(%r11,%r11), %r13
	movq	%r14, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %rbx
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, %r15
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %rsi
	movq	%r14, %rax
	mulq	%r14
	movq	%rax, %rbp
	movq	%rdx, %rcx
	movq	%r9, %rax
	mulq	%rsi
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%r12
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14), %r12
	movq	%r9, %rax
	mulq	%r13
	movq	%rax, %r14
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r12
	movq	%rdx, %r12
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	%r9
	addq	40(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %rbx                  # 8-byte Folded Reload
	addq	%rax, %r11
	adcq	%rdx, %rbx
	shldq	$13, %r11, %rbx
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r11
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %r15                  # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	8(%rsp), %r15                   # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	addq	104(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	112(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r14, %rbp
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	136(%rsp), %r8                  # 8-byte Folded Reload
	adcq	120(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r12, %rdi
	addq	%rbx, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%rbp, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rsi, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	addq	%rax, %r10
	adcq	$0, %r15
	shldq	$13, %r10, %r15
	leaq	(%r15,%r15,8), %rax
	leaq	(%r15,%rax,2), %r9
	movl	128(%rsp), %eax                 # 4-byte Reload
	addq	%r11, %r9
	movq	%r9, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	movq	%r14, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r10, %rsi
	andq	%rdx, %rsi
	andq	%rdx, %r9
	andq	%rdx, %r14
	decl	%eax
	jne	.LBB123_9
# %bb.10:
	movq	%rsi, 312(%rsp)
	movq	%rcx, 304(%rsp)
	movq	%r11, 296(%rsp)
	movq	%r14, 288(%rsp)
	movq	%r9, 280(%rsp)
	leaq	280(%rsp), %rsi
	leaq	152(%rsp), %rdi
	movq	%rdi, %rdx
	callq	fe_mul_impl
	movq	184(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r10
	movq	176(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r11
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	168(%rsp), %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r15
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	160(%rsp), %r13
	movq	%r13, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r14
	leaq	(%r9,%r9), %r11
	movq	%r13, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r12
	movq	%rdx, %rcx
	leaq	(%rbx,%rbx), %rdx
	movq	152(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%r15
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r13, %r15
	addq	%r13, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	%rbp
	addq	48(%rsp), %r10                  # 8-byte Folded Reload
	adcq	56(%rsp), %r14                  # 8-byte Folded Reload
	addq	%rax, %r10
	adcq	%rdx, %r14
	shldq	$13, %r10, %r14
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r10
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	80(%rsp), %rax                  # 8-byte Folded Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rbx, %rax
	adcq	8(%rsp), %r9                    # 8-byte Folded Reload
	movq	72(%rsp), %r11                  # 8-byte Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %rsi                 # 8-byte Folded Reload
	addq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	addq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	136(%rsp), %rcx                 # 8-byte Folded Reload
	addq	40(%rsp), %r12                  # 8-byte Folded Reload
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r15, %rdi
	addq	%r14, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%r12, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%r11, %rcx
	adcq	$0, %rsi
	shldq	$13, %rcx, %rsi
	andq	%rdx, %rcx
	addq	%rax, %rsi
	adcq	$0, %r9
	shldq	$13, %rsi, %r9
	leaq	(%r9,%r9,8), %rax
	leaq	(%r9,%rax,2), %r9
	andq	%rdx, %rsi
	addq	%r10, %r9
	movq	%r9, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	andq	%rdx, %r9
	movq	%r14, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	andq	%rdx, %r14
	movl	$49, %eax
	.p2align	4, 0x90
.LBB123_11:                             # =>This Inner Loop Header: Depth=1
	movl	%eax, 128(%rsp)                 # 4-byte Spill
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	imulq	$38, %rsi, %r10
	mulq	%rsi
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rdi
	imulq	$38, %rcx, %rdx
	movq	%r11, %rax
	mulq	%rdx
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rax
	mulq	%r11
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r12
	leaq	(%r11,%r11), %r13
	movq	%r14, %rax
	mulq	%r10
	movq	%rax, %r11
	movq	%rdx, %rbx
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, %r15
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r13
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %rsi
	movq	%r14, %rax
	mulq	%r14
	movq	%rax, %rbp
	movq	%rdx, %rcx
	movq	%r9, %rax
	mulq	%rsi
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%r12
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14), %r12
	movq	%r9, %rax
	mulq	%r13
	movq	%rax, %r14
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%r9, %rax
	mulq	%r12
	movq	%rdx, %r12
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	%r9
	addq	40(%rsp), %r11                  # 8-byte Folded Reload
	adcq	56(%rsp), %rbx                  # 8-byte Folded Reload
	addq	%rax, %r11
	adcq	%rdx, %rbx
	shldq	$13, %r11, %rbx
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r11
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	72(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %r15                  # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	8(%rsp), %r15                   # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	addq	88(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	16(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	addq	104(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	112(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r14, %rbp
	adcq	48(%rsp), %rcx                  # 8-byte Folded Reload
	addq	136(%rsp), %r8                  # 8-byte Folded Reload
	adcq	120(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r13, %r8
	adcq	%r12, %rdi
	addq	%rbx, %r8
	adcq	$0, %rdi
	shldq	$13, %r8, %rdi
	andq	%rdx, %r8
	addq	%rbp, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rdx, %rdi
	addq	%rsi, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rdx, %rcx
	addq	%rax, %r10
	adcq	$0, %r15
	shldq	$13, %r10, %r15
	leaq	(%r15,%r15,8), %rax
	leaq	(%r15,%rax,2), %r9
	movl	128(%rsp), %eax                 # 4-byte Reload
	addq	%r11, %r9
	movq	%r9, %r14
	shrq	$51, %r14
	addq	%r8, %r14
	movq	%r14, %r11
	shrq	$51, %r11
	addq	%rdi, %r11
	movq	%r10, %rsi
	andq	%rdx, %rsi
	andq	%rdx, %r9
	andq	%rdx, %r14
	decl	%eax
	jne	.LBB123_11
# %bb.12:
	movq	%rsi, 184(%rsp)
	movq	%rcx, 176(%rsp)
	movq	%r11, 168(%rsp)
	movq	%r14, 160(%rsp)
	movq	%r9, 152(%rsp)
	leaq	152(%rsp), %rsi
	leaq	200(%rsp), %rdi
	movq	%rdi, %rdx
	callq	fe_mul_impl
	movq	232(%rsp), %rbx
	leaq	(%rbx,%rbx,8), %rax
	leaq	(%rbx,%rax,2), %rax
	imulq	$38, %rbx, %r9
	movq	224(%rsp), %rcx
	leaq	(%rcx,%rcx,8), %rdx
	leaq	(%rcx,%rdx,2), %rsi
	imulq	$38, %rcx, %r10
	mulq	%rbx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rax
	mulq	%r9
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	216(%rsp), %rdi
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, %rsi
	movq	%rax, %r8
	movq	%rdi, %rax
	mulq	%r10
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx), %r12
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	208(%rsp), %rbp
	movq	%rbp, %rax
	mulq	%r9
	movq	%rax, %r9
	movq	%rdx, %r15
	leaq	(%rdi,%rdi), %r11
	movq	%rbp, %rax
	mulq	%r12
	movq	%rdx, %r10
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, %rcx
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rbp
	movq	%rax, %r13
	movq	%rdx, %rdi
	leaq	(%rbx,%rbx), %rdx
	movq	200(%rsp), %r14
	movq	%r14, %rax
	mulq	%rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rax, %rbx
	movq	%r14, %rax
	mulq	%r12
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rbp, %r12
	addq	%rbp, %r12
	movq	%r14, %rax
	mulq	%r11
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, %r12
	movq	%rax, %rbp
	movq	%r14, %rax
	mulq	%r14
	addq	48(%rsp), %r9                   # 8-byte Folded Reload
	adcq	56(%rsp), %r15                  # 8-byte Folded Reload
	addq	%rax, %r9
	adcq	%rdx, %r15
	shldq	$13, %r9, %r15
	movabsq	$2251799813685247, %rax         # imm = 0x7FFFFFFFFFFFF
	andq	%rax, %r9
	movq	32(%rsp), %r11                  # 8-byte Reload
	addq	80(%rsp), %r11                  # 8-byte Folded Reload
	adcq	88(%rsp), %r10                  # 8-byte Folded Reload
	addq	%rbx, %r11
	adcq	8(%rsp), %r10                   # 8-byte Folded Reload
	movq	72(%rsp), %rbx                  # 8-byte Reload
	addq	96(%rsp), %rbx                  # 8-byte Folded Reload
	adcq	104(%rsp), %rcx                 # 8-byte Folded Reload
	addq	16(%rsp), %rbx                  # 8-byte Folded Reload
	adcq	24(%rsp), %rcx                  # 8-byte Folded Reload
	addq	112(%rsp), %r13                 # 8-byte Folded Reload
	adcq	136(%rsp), %rdi                 # 8-byte Folded Reload
	addq	40(%rsp), %r13                  # 8-byte Folded Reload
	adcq	64(%rsp), %rdi                  # 8-byte Folded Reload
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	adcq	128(%rsp), %rsi                 # 8-byte Folded Reload
	addq	%rbp, %r8
	adcq	%r12, %rsi
	addq	%r15, %r8
	adcq	$0, %rsi
	shldq	$13, %r8, %rsi
	movq	%rax, %rdx
	andq	%rax, %r8
	addq	%r13, %rsi
	adcq	$0, %rdi
	shldq	$13, %rsi, %rdi
	andq	%rax, %rsi
	addq	%rbx, %rdi
	adcq	$0, %rcx
	shldq	$13, %rdi, %rcx
	andq	%rax, %rdi
	addq	%r11, %rcx
	adcq	$0, %r10
	shldq	$13, %rcx, %r10
	andq	%rax, %rcx
	leaq	(%r10,%r10,8), %rax
	leaq	(%r10,%rax,2), %r14
	addq	%r9, %r14
	movq	%r14, %rbx
	shrq	$51, %rbx
	addq	%r8, %rbx
	andq	%rdx, %r14
	movq	%rbx, %r8
	shrq	$51, %r8
	addq	%rsi, %r8
	andq	%rdx, %rbx
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rdx
	imulq	$38, %rcx, %r10
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rdi,%rax,2), %rsi
	imulq	$38, %rdi, %r11
	movq	%rcx, %rax
	mulq	%rdx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%r10
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rsi
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	leaq	(%rdi,%rdi), %r15
	movq	%r8, %rax
	mulq	%r10
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r8, %rax
	mulq	%r11
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%r8, %rax
	mulq	%r8
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	leaq	(%r8,%r8), %r9
	movq	%rbx, %rax
	mulq	%r10
	movq	%rdx, %r12
	movq	%rax, %r8
	movq	%rbx, %rax
	mulq	%r15
	movq	%r15, %r10
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r9
	movq	%rax, %r15
	movq	%rdx, %r11
	leaq	(%rcx,%rcx), %r13
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rdx, %rcx
	movq	%rax, %rbp
	movq	%r14, %rax
	mulq	%r13
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%r14, %rax
	mulq	%r10
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	leaq	(%rbx,%rbx), %r13
	movq	%r14, %rax
	mulq	%r9
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, %rbx
	movq	%r14, %rax
	mulq	%r13
	movq	%rdx, %r13
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r14
	addq	40(%rsp), %r8                   # 8-byte Folded Reload
	adcq	48(%rsp), %r12                  # 8-byte Folded Reload
	addq	%rax, %r8
	adcq	%rdx, %r12
	movq	%r12, %rax
	shrq	$51, %rax
	shldq	$13, %r8, %r12
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %r8
	movq	144(%rsp), %r10                 # 8-byte Reload
	addq	80(%rsp), %r10                  # 8-byte Folded Reload
	movq	56(%rsp), %r9                   # 8-byte Reload
	adcq	88(%rsp), %r9                   # 8-byte Folded Reload
	addq	8(%rsp), %r10                   # 8-byte Folded Reload
	adcq	16(%rsp), %r9                   # 8-byte Folded Reload
	addq	96(%rsp), %r15                  # 8-byte Folded Reload
	adcq	104(%rsp), %r11                 # 8-byte Folded Reload
	addq	24(%rsp), %r15                  # 8-byte Folded Reload
	adcq	32(%rsp), %r11                  # 8-byte Folded Reload
	addq	112(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	136(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rbx, %rbp
	adcq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	120(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	128(%rsp), %rsi                 # 8-byte Folded Reload
	addq	72(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	%r13, %rsi
	addq	%r12, %rdi
	adcq	%rax, %rsi
	movq	%rsi, %r13
	shrq	$51, %r13
	shldq	$13, %rdi, %rsi
	andq	%rdx, %rdi
	addq	%rbp, %rsi
	adcq	%rcx, %r13
	movq	%r13, %rbp
	shrq	$51, %rbp
	shldq	$13, %rsi, %r13
	andq	%rdx, %rsi
	addq	%r15, %r13
	adcq	%r11, %rbp
	movq	%rbp, %rax
	shrq	$51, %rax
	shldq	$13, %r13, %rbp
	andq	%rdx, %r13
	addq	%r10, %rbp
	adcq	%r9, %rax
	shldq	$13, %rbp, %rax
	andq	%rdx, %rbp
	leaq	(%rax,%rax,8), %rcx
	leaq	(%rax,%rcx,2), %r14
	addq	%r8, %r14
	movq	%r14, %rbx
	shrq	$51, %rbx
	addq	%rdi, %rbx
	andq	%rdx, %r14
	movq	%rbx, %rdi
	shrq	$51, %rdi
	addq	%rsi, %rdi
	andq	%rdx, %rbx
	leaq	(,%rbp,8), %rax
	addq	%rbp, %rax
	leaq	(,%rax,2), %rcx
	addq	%rbp, %rcx
	imulq	$38, %rbp, %r9
	leaq	(,%r13,8), %rax
	addq	%r13, %rax
	leaq	(,%rax,2), %rsi
	addq	%r13, %rsi
	imulq	$38, %r13, %r10
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r9
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%r13, %rax
	mulq	%rsi
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%r13, %r11
	addq	%r13, %r11
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	%r10
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	leaq	(%rdi,%rdi), %r8
	movq	%rbx, %rax
	mulq	%r9
	movq	%rdx, %r15
	movq	%rax, %rdi
	movq	%rbx, %rax
	mulq	%r11
	movq	%r11, %r9
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r8
	movq	%rax, %r11
	movq	%rdx, %r10
	movq	%rbp, %r12
	addq	%rbp, %r12
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rdx, %rbp
	movq	%rax, %r13
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%r14, %rax
	mulq	%r9
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	leaq	(%rbx,%rbx), %r12
	movq	%r14, %rax
	mulq	%r8
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, %rbx
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, %r12
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r14
	addq	40(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	48(%rsp), %r15                  # 8-byte Folded Reload
	addq	%rax, %rdi
	adcq	%rdx, %r15
	movq	%r15, %rax
	shrq	$51, %rax
	shldq	$13, %rdi, %r15
	movabsq	$2251799813685247, %r8          # imm = 0x7FFFFFFFFFFFF
	andq	%r8, %rdi
	movq	144(%rsp), %r9                  # 8-byte Reload
	addq	80(%rsp), %r9                   # 8-byte Folded Reload
	movq	56(%rsp), %rdx                  # 8-byte Reload
	adcq	88(%rsp), %rdx                  # 8-byte Folded Reload
	addq	8(%rsp), %r9                    # 8-byte Folded Reload
	adcq	16(%rsp), %rdx                  # 8-byte Folded Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %r10                 # 8-byte Folded Reload
	addq	24(%rsp), %r11                  # 8-byte Folded Reload
	adcq	32(%rsp), %r10                  # 8-byte Folded Reload
	addq	112(%rsp), %r13                 # 8-byte Folded Reload
	adcq	136(%rsp), %rbp                 # 8-byte Folded Reload
	addq	%rbx, %r13
	adcq	64(%rsp), %rbp                  # 8-byte Folded Reload
	addq	120(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	128(%rsp), %rcx                 # 8-byte Folded Reload
	addq	72(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	%r12, %rcx
	addq	%r15, %rsi
	adcq	%rax, %rcx
	movq	%rcx, %r15
	shrq	$51, %r15
	shldq	$13, %rsi, %rcx
	andq	%r8, %rsi
	addq	%r13, %rcx
	adcq	%rbp, %r15
	movq	%r15, %rbp
	shrq	$51, %rbp
	shldq	$13, %rcx, %r15
	andq	%r8, %rcx
	addq	%r11, %r15
	adcq	%r10, %rbp
	movq	%rbp, %rax
	shrq	$51, %rax
	shldq	$13, %r15, %rbp
	andq	%r8, %r15
	addq	%r9, %rbp
	adcq	%rdx, %rax
	shldq	$13, %rbp, %rax
	andq	%r8, %rbp
	leaq	(%rax,%rax,8), %rdx
	leaq	(%rax,%rdx,2), %r14
	addq	%rdi, %r14
	movq	%r14, %rbx
	shrq	$51, %rbx
	addq	%rsi, %rbx
	andq	%r8, %r14
	movq	%rbx, %rdi
	shrq	$51, %rdi
	addq	%rcx, %rdi
	andq	%r8, %rbx
	leaq	(,%rbp,8), %rax
	addq	%rbp, %rax
	leaq	(,%rax,2), %rcx
	addq	%rbp, %rcx
	imulq	$38, %rbp, %r9
	leaq	(%r15,%r15,8), %rax
	leaq	(%r15,%rax,2), %rsi
	imulq	$38, %r15, %r10
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%r15, %rax
	mulq	%r9
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%r15, %rax
	mulq	%rsi
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	leaq	(%r15,%r15), %r11
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	%r10
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	leaq	(%rdi,%rdi), %r8
	movq	%rbx, %rax
	mulq	%r9
	movq	%rdx, %r15
	movq	%rax, %rdi
	movq	%rbx, %rax
	mulq	%r11
	movq	%r11, %r9
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r8
	movq	%rax, %r11
	movq	%rdx, %r10
	movq	%rbp, %r12
	addq	%rbp, %r12
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rdx, %rbp
	movq	%rax, %r13
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%r14, %rax
	mulq	%r9
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	leaq	(%rbx,%rbx), %r12
	movq	%r14, %rax
	mulq	%r8
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, %rbx
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, %r12
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r14
	addq	40(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	48(%rsp), %r15                  # 8-byte Folded Reload
	addq	%rax, %rdi
	adcq	%rdx, %r15
	movq	%r15, %rax
	shrq	$51, %rax
	shldq	$13, %rdi, %r15
	movabsq	$2251799813685247, %r8          # imm = 0x7FFFFFFFFFFFF
	andq	%r8, %rdi
	movq	144(%rsp), %r9                  # 8-byte Reload
	addq	80(%rsp), %r9                   # 8-byte Folded Reload
	movq	56(%rsp), %rdx                  # 8-byte Reload
	adcq	88(%rsp), %rdx                  # 8-byte Folded Reload
	addq	8(%rsp), %r9                    # 8-byte Folded Reload
	adcq	16(%rsp), %rdx                  # 8-byte Folded Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %r10                 # 8-byte Folded Reload
	addq	24(%rsp), %r11                  # 8-byte Folded Reload
	adcq	32(%rsp), %r10                  # 8-byte Folded Reload
	addq	112(%rsp), %r13                 # 8-byte Folded Reload
	adcq	136(%rsp), %rbp                 # 8-byte Folded Reload
	addq	%rbx, %r13
	adcq	64(%rsp), %rbp                  # 8-byte Folded Reload
	addq	120(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	128(%rsp), %rcx                 # 8-byte Folded Reload
	addq	72(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	%r12, %rcx
	addq	%r15, %rsi
	adcq	%rax, %rcx
	movq	%rcx, %r15
	shrq	$51, %r15
	shldq	$13, %rsi, %rcx
	andq	%r8, %rsi
	addq	%r13, %rcx
	adcq	%rbp, %r15
	movq	%r15, %rbp
	shrq	$51, %rbp
	shldq	$13, %rcx, %r15
	andq	%r8, %rcx
	addq	%r11, %r15
	adcq	%r10, %rbp
	movq	%rbp, %rax
	shrq	$51, %rax
	shldq	$13, %r15, %rbp
	andq	%r8, %r15
	addq	%r9, %rbp
	adcq	%rdx, %rax
	shldq	$13, %rbp, %rax
	andq	%r8, %rbp
	leaq	(%rax,%rax,8), %rdx
	leaq	(%rax,%rdx,2), %r14
	addq	%rdi, %r14
	movq	%r14, %rbx
	shrq	$51, %rbx
	addq	%rsi, %rbx
	andq	%r8, %r14
	movq	%rbx, %rdi
	shrq	$51, %rdi
	addq	%rcx, %rdi
	andq	%r8, %rbx
	leaq	(,%rbp,8), %rax
	addq	%rbp, %rax
	leaq	(,%rax,2), %rcx
	addq	%rbp, %rcx
	imulq	$38, %rbp, %r9
	leaq	(%r15,%r15,8), %rax
	leaq	(%r15,%rax,2), %rsi
	imulq	$38, %r15, %r10
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%r15, %rax
	mulq	%r9
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%r15, %rax
	mulq	%rsi
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	leaq	(%r15,%r15), %r11
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	%r10
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	leaq	(%rdi,%rdi), %r8
	movq	%rbx, %rax
	mulq	%r9
	movq	%rdx, %r15
	movq	%rax, %rdi
	movq	%rbx, %rax
	mulq	%r11
	movq	%r11, %r9
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%rbx, %rax
	mulq	%r8
	movq	%rax, %r11
	movq	%rdx, %r10
	movq	%rbp, %r12
	addq	%rbp, %r12
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rdx, %rbp
	movq	%rax, %r13
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%r14, %rax
	mulq	%r9
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	leaq	(%rbx,%rbx), %r12
	movq	%r14, %rax
	mulq	%r8
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	movq	%rax, %rbx
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, %r8
	movq	%rax, %r12
	movq	%r14, %rax
	mulq	%r14
	addq	48(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	56(%rsp), %r15                  # 8-byte Folded Reload
	addq	%rax, %rdi
	adcq	%rdx, %r15
	movq	%r15, %rax
	shrq	$51, %rax
	shldq	$13, %rdi, %r15
	movabsq	$2251799813685247, %rdx         # imm = 0x7FFFFFFFFFFFF
	andq	%rdx, %rdi
	movq	8(%rsp), %r9                    # 8-byte Reload
	addq	80(%rsp), %r9                   # 8-byte Folded Reload
	movq	64(%rsp), %r14                  # 8-byte Reload
	adcq	88(%rsp), %r14                  # 8-byte Folded Reload
	addq	16(%rsp), %r9                   # 8-byte Folded Reload
	adcq	24(%rsp), %r14                  # 8-byte Folded Reload
	addq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %r10                 # 8-byte Folded Reload
	addq	32(%rsp), %r11                  # 8-byte Folded Reload
	adcq	40(%rsp), %r10                  # 8-byte Folded Reload
	addq	112(%rsp), %r13                 # 8-byte Folded Reload
	adcq	136(%rsp), %rbp                 # 8-byte Folded Reload
	addq	%rbx, %r13
	adcq	72(%rsp), %rbp                  # 8-byte Folded Reload
	addq	120(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	128(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r12, %rsi
	adcq	%r8, %rcx
	addq	%r15, %rsi
	adcq	%rax, %rcx
	movq	%rcx, %rax
	shrq	$51, %rax
	shldq	$13, %rsi, %rcx
	movq	%rdx, %rbx
	andq	%rdx, %rsi
	addq	%r13, %rcx
	adcq	%rbp, %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	shldq	$13, %rcx, %rax
	andq	%rbx, %rcx
	addq	%r11, %rax
	adcq	%r10, %rdx
	movq	%rdx, %r8
	shrq	$51, %r8
	shldq	$13, %rax, %rdx
	addq	%r9, %rdx
	adcq	%r14, %r8
	shldq	$13, %rdx, %r8
	movq	%rdx, %xmm0
	movq	%rax, %xmm1
	leaq	(%r8,%r8,8), %rax
	leaq	(%r8,%rax,2), %rax
	addq	%rdi, %rax
	movq	%rax, %rdx
	shrq	$51, %rdx
	addq	%rsi, %rdx
	movq	%rdx, %rsi
	shrq	$51, %rsi
	addq	%rcx, %rsi
	andq	%rbx, %rax
	andq	%rbx, %rdx
	punpcklqdq	%xmm0, %xmm1            # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI123_0(%rip), %xmm1
	movdqu	%xmm1, 224(%rsp)
	movq	%rsi, 216(%rsp)
	movq	%rdx, 208(%rsp)
	movq	%rax, 200(%rsp)
	leaq	320(%rsp), %rdx
	movq	192(%rsp), %rdi                 # 8-byte Reload
	leaq	200(%rsp), %rsi
	callq	fe_mul_impl
	addq	$360, %rsp                      # imm = 0x168
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end123:
	.size	fe_loose_invert, .Lfunc_end123-fe_loose_invert
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$72, %rsp
	movl	$100, %ebp
	leaq	out_shared_key(%rip), %rbx
	leaq	32(%rsp), %r14
	movq	%rsp, %r15
	.p2align	4, 0x90
.LBB124_1:                              # =>This Inner Loop Header: Depth=1
	movaps	private_key(%rip), %xmm0
	movaps	%xmm0, 32(%rsp)
	movaps	private_key+16(%rip), %xmm0
	movaps	%xmm0, 48(%rsp)
	movaps	peer_public_value(%rip), %xmm0
	movaps	%xmm0, (%rsp)
	movaps	peer_public_value+16(%rip), %xmm0
	movaps	%xmm0, 16(%rsp)
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	X25519
	decl	%ebp
	jne	.LBB124_1
# %bb.2:
	xorl	%eax, %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end124:
	.size	main, .Lfunc_end124-main
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function thread_local_destructor
	.type	thread_local_destructor,@function
thread_local_destructor:                # @thread_local_destructor
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	testq	%rdi, %rdi
	je	.LBB125_13
# %bb.1:
	movq	%rdi, %rbx
	leaq	g_destructors_lock(%rip), %rdi
	callq	pthread_mutex_lock@PLT
	testl	%eax, %eax
	jne	.LBB125_13
# %bb.2:
	movq	g_destructors(%rip), %rbp
	movq	g_destructors+8(%rip), %r13
	movq	g_destructors+16(%rip), %r12
	movq	g_destructors+24(%rip), %r15
	movq	g_destructors+32(%rip), %r14
	leaq	g_destructors_lock(%rip), %rdi
	callq	pthread_mutex_unlock@PLT
	testq	%rbp, %rbp
	je	.LBB125_4
# %bb.3:
	movq	(%rbx), %rdi
	callq	*%rbp
.LBB125_4:
	testq	%r13, %r13
	je	.LBB125_6
# %bb.5:
	movq	8(%rbx), %rdi
	callq	*%r13
.LBB125_6:
	testq	%r12, %r12
	je	.LBB125_8
# %bb.7:
	movq	16(%rbx), %rdi
	callq	*%r12
.LBB125_8:
	testq	%r15, %r15
	je	.LBB125_10
# %bb.9:
	movq	24(%rbx), %rdi
	callq	*%r15
.LBB125_10:
	testq	%r14, %r14
	je	.LBB125_12
# %bb.11:
	movq	32(%rbx), %rdi
	callq	*%r14
.LBB125_12:
	movq	%rbx, %rdi
	callq	free@PLT
.LBB125_13:
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end125:
	.size	thread_local_destructor, .Lfunc_end125-thread_local_destructor
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function err_state_free
.LCPI126_0:
	.zero	16
	.text
	.p2align	4, 0x90
	.type	err_state_free,@function
err_state_free:                         # @err_state_free
# %bb.0:
	testq	%rdi, %rdi
	je	.LBB126_2
# %bb.1:
	pushq	%rbx
	movq	%rdi, %rbx
	movq	8(%rdi), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%rbx)
	movq	$0, 16(%rbx)
	movq	32(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 24(%rbx)
	movq	$0, 40(%rbx)
	movq	56(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 48(%rbx)
	movq	$0, 64(%rbx)
	movq	80(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 72(%rbx)
	movq	$0, 88(%rbx)
	movq	104(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 96(%rbx)
	movq	$0, 112(%rbx)
	movq	128(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 120(%rbx)
	movq	$0, 136(%rbx)
	movq	152(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 144(%rbx)
	movq	$0, 160(%rbx)
	movq	176(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 168(%rbx)
	movq	$0, 184(%rbx)
	movq	200(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 192(%rbx)
	movq	$0, 208(%rbx)
	movq	224(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 216(%rbx)
	movq	$0, 232(%rbx)
	movq	248(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 240(%rbx)
	movq	$0, 256(%rbx)
	movq	272(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 264(%rbx)
	movq	$0, 280(%rbx)
	movq	296(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 288(%rbx)
	movq	$0, 304(%rbx)
	movq	320(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 312(%rbx)
	movq	$0, 328(%rbx)
	movq	344(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 336(%rbx)
	movq	$0, 352(%rbx)
	movq	368(%rbx), %rdi
	callq	free@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 360(%rbx)
	movq	$0, 376(%rbx)
	movq	392(%rbx), %rdi
	callq	free@PLT
	movq	%rbx, %rdi
	callq	free@PLT
	popq	%rbx
.LBB126_2:
	retq
.Lfunc_end126:
	.size	err_state_free, .Lfunc_end126-err_state_free
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function fe_mul_impl
.LCPI127_0:
	.quad	2251799813685247                # 0x7ffffffffffff
	.quad	2251799813685247                # 0x7ffffffffffff
	.text
	.p2align	4, 0x90
	.type	fe_mul_impl,@function
fe_mul_impl:                            # @fe_mul_impl
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$192, %rsp
	movq	%rdx, %r11
	movq	32(%rsi), %r15
	movq	%rsi, %r9
	movq	32(%rdx), %rcx
	movq	%rcx, -104(%rsp)                # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %rbx
	movq	%rbx, %rax
	mulq	%r15
	movq	%rax, 176(%rsp)                 # 8-byte Spill
	movq	%rdx, 184(%rsp)                 # 8-byte Spill
	movq	24(%r11), %rcx
	movq	%rcx, -120(%rsp)                # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %r13
	movq	%r13, %rax
	mulq	%r15
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	16(%r11), %rcx
	movq	%rcx, -128(%rsp)                # 8-byte Spill
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rcx,%rax,2), %r8
	movq	%r8, %rax
	mulq	%r15
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	movq	8(%r11), %rsi
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rsi,%rax,2), %rax
	mulq	%r15
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r9, -112(%rsp)                 # 8-byte Spill
	movq	24(%r9), %r14
	movq	%r14, %rax
	mulq	%rbx
	movq	%rdx, %rbp
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%r14, %rax
	mulq	%r13
	movq	%rdx, %r10
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%r14, %rax
	mulq	%r8
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	movq	%rdx, %r12
	movq	16(%r9), %r8
	movq	%r8, %rax
	mulq	%rbx
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%r8, %rax
	mulq	%r13
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	movq	8(%r9), %r13
	movq	%r13, %rax
	mulq	%rbx
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	movq	(%r11), %r11
	movq	%r11, %rax
	mulq	%r15
	movq	%rdx, 168(%rsp)                 # 8-byte Spill
	movq	%rax, 160(%rsp)                 # 8-byte Spill
	movq	%r14, %rax
	mulq	%rsi
	movq	%rdx, 152(%rsp)                 # 8-byte Spill
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	%r14
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	movq	-128(%rsp), %r9                 # 8-byte Reload
	mulq	%r9
	movq	%rdx, %rbx
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	%r8, %rax
	mulq	%rsi
	movq	%rdx, %r15
	movq	%rax, %r14
	movq	%r11, %rax
	mulq	%r8
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	movq	-120(%rsp), %rcx                # 8-byte Reload
	mulq	%rcx
	movq	%rdx, 104(%rsp)                 # 8-byte Spill
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%r9
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	mulq	%rsi
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	-112(%rsp), %rax                # 8-byte Reload
	movq	(%rax), %r8
	movq	%r11, %rax
	mulq	%r13
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	-104(%rsp)                      # 8-byte Folded Reload
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%r8, %rax
	mulq	%r9
	movq	%rdx, %r9
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	%r8, %rax
	mulq	%rsi
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	%rax, %r13
	movq	%r8, %rax
	mulq	%r11
	movq	-24(%rsp), %r8                  # 8-byte Reload
	addq	(%rsp), %r8                     # 8-byte Folded Reload
	adcq	24(%rsp), %r12                  # 8-byte Folded Reload
	addq	-48(%rsp), %r8                  # 8-byte Folded Reload
	adcq	-40(%rsp), %r12                 # 8-byte Folded Reload
	addq	-64(%rsp), %r8                  # 8-byte Folded Reload
	adcq	-56(%rsp), %r12                 # 8-byte Folded Reload
	addq	%rax, %r8
	adcq	%rdx, %r12
	shldq	$13, %r8, %r12
	movabsq	$2251799813685247, %rax         # imm = 0x7FFFFFFFFFFFF
	andq	%rax, %r8
	movq	8(%rsp), %rcx                   # 8-byte Reload
	addq	112(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	128(%rsp), %rbp                 # 8-byte Folded Reload
	movq	-96(%rsp), %r11                 # 8-byte Reload
	addq	88(%rsp), %r11                  # 8-byte Folded Reload
	adcq	96(%rsp), %r10                  # 8-byte Folded Reload
	addq	48(%rsp), %r11                  # 8-byte Folded Reload
	adcq	64(%rsp), %r10                  # 8-byte Folded Reload
	addq	-80(%rsp), %r11                 # 8-byte Folded Reload
	adcq	-72(%rsp), %r10                 # 8-byte Folded Reload
	addq	%r13, %r11
	adcq	-88(%rsp), %r10                 # 8-byte Folded Reload
	addq	%r12, %r11
	adcq	$0, %r10
	shldq	$13, %r11, %r10
	andq	%rax, %r11
	addq	-32(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	-16(%rsp), %rbp                 # 8-byte Folded Reload
	addq	16(%rsp), %rcx                  # 8-byte Folded Reload
	adcq	32(%rsp), %rbp                  # 8-byte Folded Reload
	addq	-128(%rsp), %rcx                # 8-byte Folded Reload
	adcq	%r9, %rbp
	addq	%r10, %rcx
	adcq	$0, %rbp
	shldq	$13, %rcx, %rbp
	andq	%rax, %rcx
	addq	176(%rsp), %r14                 # 8-byte Folded Reload
	adcq	184(%rsp), %r15                 # 8-byte Folded Reload
	addq	56(%rsp), %r14                  # 8-byte Folded Reload
	adcq	72(%rsp), %r15                  # 8-byte Folded Reload
	addq	120(%rsp), %r14                 # 8-byte Folded Reload
	adcq	136(%rsp), %r15                 # 8-byte Folded Reload
	addq	40(%rsp), %r14                  # 8-byte Folded Reload
	adcq	-120(%rsp), %r15                # 8-byte Folded Reload
	movq	-8(%rsp), %rdx                  # 8-byte Reload
	addq	144(%rsp), %rdx                 # 8-byte Folded Reload
	adcq	152(%rsp), %rbx                 # 8-byte Folded Reload
	addq	80(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	104(%rsp), %rbx                 # 8-byte Folded Reload
	addq	160(%rsp), %rdx                 # 8-byte Folded Reload
	adcq	168(%rsp), %rbx                 # 8-byte Folded Reload
	addq	-112(%rsp), %rdx                # 8-byte Folded Reload
	adcq	-104(%rsp), %rbx                # 8-byte Folded Reload
	addq	%rbp, %r14
	adcq	$0, %r15
	shldq	$13, %r14, %r15
	addq	%rdx, %r15
	adcq	$0, %rbx
	shldq	$13, %r15, %rbx
	movq	%r15, %xmm0
	movq	%r14, %xmm1
	leaq	(%rbx,%rbx,8), %rdx
	leaq	(%rbx,%rdx,2), %rdx
	addq	%r8, %rdx
	movq	%rdx, %rsi
	shrq	$51, %rsi
	addq	%r11, %rsi
	movq	%rsi, %r8
	shrq	$51, %r8
	addq	%rcx, %r8
	andq	%rax, %rdx
	andq	%rax, %rsi
	movq	%rdx, (%rdi)
	movq	%rsi, 8(%rdi)
	movq	%r8, 16(%rdi)
	punpcklqdq	%xmm0, %xmm1            # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI127_0(%rip), %xmm1
	movdqu	%xmm1, 24(%rdi)
	addq	$192, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end127:
	.size	fe_mul_impl, .Lfunc_end127-fe_mul_impl
                                        # -- End function
	.type	g_thread_local_init_once,@object # @g_thread_local_init_once
	.local	g_thread_local_init_once
	.comm	g_thread_local_init_once,4,4
	.type	g_thread_local_key_created,@object # @g_thread_local_key_created
	.local	g_thread_local_key_created
	.comm	g_thread_local_key_created,4,4
	.type	g_thread_local_key,@object      # @g_thread_local_key
	.local	g_thread_local_key
	.comm	g_thread_local_key,4,4
	.type	g_destructors_lock,@object      # @g_destructors_lock
	.local	g_destructors_lock
	.comm	g_destructors_lock,40,8
	.type	g_destructors,@object           # @g_destructors
	.local	g_destructors
	.comm	g_destructors,40,16
	.type	global_next_library_mutex,@object # @global_next_library_mutex
	.local	global_next_library_mutex
	.comm	global_next_library_mutex,56,8
	.type	global_next_library,@object     # @global_next_library
	.data
	.p2align	2, 0x0
global_next_library:
	.long	34                              # 0x22
	.size	global_next_library, 4

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"unknown library"
	.size	.L.str, 16

	.type	kLibraryNames,@object           # @kLibraryNames
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4, 0x0
kLibraryNames:
	.quad	.L.str.10
	.quad	0
	.quad	0
	.quad	.L.str
	.quad	.L.str.11
	.quad	.L.str.12
	.quad	.L.str.13
	.quad	.L.str.14
	.quad	.L.str.15
	.quad	.L.str.16
	.quad	.L.str.17
	.quad	.L.str.18
	.quad	.L.str.19
	.quad	.L.str.20
	.quad	.L.str.21
	.quad	.L.str.22
	.quad	.L.str.23
	.quad	.L.str.24
	.quad	.L.str.25
	.quad	.L.str.26
	.quad	.L.str.27
	.quad	.L.str.28
	.quad	.L.str.29
	.quad	.L.str.30
	.quad	.L.str.31
	.quad	.L.str.32
	.quad	.L.str.33
	.quad	.L.str.34
	.quad	.L.str.35
	.quad	.L.str.36
	.quad	.L.str.37
	.quad	.L.str.38
	.quad	.L.str.39
	.quad	.L.str.40
	.quad	.L.str.41
	.quad	.L.str.42
	.quad	.L.str.43
	.quad	.L.str.44
	.quad	.L.str.45
	.quad	.L.str.46
	.quad	.L.str.47
	.quad	.L.str.48
	.quad	.L.str.49
	.quad	.L.str.50
	.quad	.L.str.51
	.quad	.L.str.52
	.quad	.L.str.53
	.quad	.L.str.54
	.quad	.L.str.55
	.quad	.L.str.56
	.quad	.L.str.57
	.quad	.L.str.58
	.quad	.L.str.59
	.quad	.L.str.60
	.quad	.L.str.61
	.quad	.L.str.62
	.quad	.L.str.63
	.quad	.L.str.64
	.quad	.L.str.65
	.quad	.L.str.66
	.quad	.L.str.67
	.quad	.L.str.68
	.quad	.L.str.69
	.quad	.L.str.70
	.quad	.L.str.71
	.quad	.L.str.72
	.quad	.L.str.73
	.quad	.L.str.74
	.quad	.L.str.75
	.quad	.L.str.76
	.quad	.L.str.77
	.quad	.L.str.78
	.quad	.L.str.79
	.quad	.L.str.80
	.quad	.L.str.81
	.quad	.L.str.82
	.quad	.L.str.83
	.quad	.L.str.84
	.quad	.L.str.85
	.quad	.L.str.86
	.quad	.L.str.87
	.quad	.L.str.88
	.quad	.L.str.89
	.quad	.L.str.90
	.quad	.L.str.91
	.quad	.L.str.92
	.quad	.L.str.93
	.quad	.L.str.94
	.quad	.L.str.95
	.quad	.L.str.96
	.quad	.L.str.97
	.quad	.L.str.98
	.quad	.L.str.99
	.quad	.L.str.100
	.quad	.L.str.101
	.quad	.L.str.102
	.quad	.L.str.103
	.quad	.L.str.104
	.quad	.L.str.105
	.quad	.L.str.106
	.quad	.L.str.107
	.quad	.L.str.108
	.size	kLibraryNames, 816

	.type	.L.str.1,@object                # @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"OPENSSL_internal"
	.size	.L.str.1, 17

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"unknown error"
	.size	.L.str.2, 14

	.type	ERR_error_string.buf,@object    # @ERR_error_string.buf
	.local	ERR_error_string.buf
	.comm	ERR_error_string.buf,120,16
	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"lib(%u)"
	.size	.L.str.3, 8

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"reason(%u)"
	.size	.L.str.4, 11

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"error:%08x:%s:OPENSSL_internal:%s"
	.size	.L.str.5, 34

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"%lu:%s:%s:%d:%s\n"
	.size	.L.str.6, 17

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.zero	1
	.size	.L.str.7, 1

	.type	kOpenSSLReasonValues,@object    # @kOpenSSLReasonValues
	.section	.rodata,"a",@progbits
	.globl	kOpenSSLReasonValues
	.p2align	4, 0x0
kOpenSSLReasonValues:
	.long	204605573                       # 0xc320885
	.long	204638367                       # 0xc32889f
	.long	204671150                       # 0xc3308ae
	.long	204703934                       # 0xc3388be
	.long	204736717                       # 0xc3408cd
	.long	204769510                       # 0xc3488e6
	.long	204802290                       # 0xc3508f2
	.long	204835087                       # 0xc35890f
	.long	204867887                       # 0xc36092f
	.long	204900669                       # 0xc36893d
	.long	204933453                       # 0xc37094d
	.long	204966234                       # 0xc37895a
	.long	204999018                       # 0xc38096a
	.long	205031797                       # 0xc388975
	.long	205064587                       # 0xc39098b
	.long	205097370                       # 0xc39899a
	.long	205130158                       # 0xc3a09ae
	.long	205162642                       # 0xc3a8892
	.long	205193463                       # 0xc3b00f7
	.long	205228321                       # 0xc3b8921
	.long	271714450                       # 0x10320892
	.long	271750740                       # 0x10329654
	.long	271783520                       # 0x10331660
	.long	271816313                       # 0x10339679
	.long	271849100                       # 0x1034168c
	.long	271880083                       # 0x10348f93
	.long	271912159                       # 0x10350cdf
	.long	271947423                       # 0x1035969f
	.long	271980233                       # 0x103616c9
	.long	272013020                       # 0x103696dc
	.long	272045819                       # 0x103716fb
	.long	272078612                       # 0x10379714
	.long	272111401                       # 0x10381729
	.long	272144199                       # 0x10389747
	.long	272176982                       # 0x10391756
	.long	272209778                       # 0x10399772
	.long	272242573                       # 0x103a178d
	.long	272275356                       # 0x103a979c
	.long	272308152                       # 0x103b17b8
	.long	272340947                       # 0x103b97d3
	.long	272373753                       # 0x103c17f9
	.long	272400631                       # 0x103c80f7
	.long	272439306                       # 0x103d180a
	.long	272472094                       # 0x103d981e
	.long	272504893                       # 0x103e183d
	.long	272537676                       # 0x103e984c
	.long	272570467                       # 0x103f1863
	.long	272603254                       # 0x103f9876
	.long	272632995                       # 0x10400ca3
	.long	272668809                       # 0x10409889
	.long	272701607                       # 0x104118a7
	.long	272734394                       # 0x104198ba
	.long	272767188                       # 0x104218d4
	.long	272799972                       # 0x104298e4
	.long	272832760                       # 0x104318f8
	.long	272865550                       # 0x1043990e
	.long	272898342                       # 0x10441926
	.long	272931131                       # 0x1044993b
	.long	272963919                       # 0x1045194f
	.long	272996705                       # 0x10459961
	.long	273024565                       # 0x10460635
	.long	273058202                       # 0x1046899a
	.long	273095030                       # 0x10471976
	.long	273127821                       # 0x1047998d
	.long	273160610                       # 0x104819a2
	.long	273193392                       # 0x104899b0
	.long	273223391                       # 0x10490edf
	.long	273258474                       # 0x104997ea
	.long	273290932                       # 0x104a16b4
	.long	338824307                       # 0x14320c73
	.long	338857108                       # 0x14328c94
	.long	338889891                       # 0x14330ca3
	.long	338922677                       # 0x14338cb5
	.long	338952377                       # 0x143400b9
	.long	338985207                       # 0x143480f7
	.long	339020929                       # 0x14350c81
	.long	405930128                       # 0x18320090
	.long	405966825                       # 0x18328fe9
	.long	405995705                       # 0x183300b9
	.long	406032383                       # 0x18338fff
	.long	406065171                       # 0x18341013
	.long	406094071                       # 0x183480f7
	.long	406130738                       # 0x18351032
	.long	406163530                       # 0x1835904a
	.long	406196338                       # 0x18361072
	.long	406229126                       # 0x18369086
	.long	406261950                       # 0x183710be
	.long	406294740                       # 0x183790d4
	.long	406327528                       # 0x183810e8
	.long	406360312                       # 0x183890f8
	.long	406391488                       # 0x18390ac0
	.long	406425864                       # 0x18399108
	.long	406458670                       # 0x183a112e
	.long	406491476                       # 0x183a9154
	.long	406523115                       # 0x183b0ceb
	.long	406557091                       # 0x183b91a3
	.long	406589877                       # 0x183c11b5
	.long	406622656                       # 0x183c91c0
	.long	406655440                       # 0x183d11d0
	.long	406688225                       # 0x183d91e1
	.long	406721010                       # 0x183e11f2
	.long	406753796                       # 0x183e9204
	.long	406786605                       # 0x183f122d
	.long	406819398                       # 0x183f9246
	.long	406852190                       # 0x1840125e
	.long	406882061                       # 0x1840870d
	.long	406917495                       # 0x18411177
	.long	406950210                       # 0x18419142
	.long	406983009                       # 0x18421161
	.long	407014529                       # 0x18428c81
	.long	407048477                       # 0x1843111d
	.long	407081353                       # 0x18439189
	.long	407113768                       # 0x18441028
	.long	407146666                       # 0x184490aa
	.long	407179359                       # 0x1845105f
	.long	540152472                       # 0x20321298
	.long	540185221                       # 0x20329285
	.long	607261348                       # 0x243212a4
	.long	607291872                       # 0x243289e0
	.long	607326902                       # 0x243312b6
	.long	607359683                       # 0x243392c3
	.long	607392464                       # 0x243412d0
	.long	607425250                       # 0x243492e2
	.long	607458033                       # 0x243512f1
	.long	607490830                       # 0x2435930e
	.long	607523611                       # 0x2436131b
	.long	607556393                       # 0x24369329
	.long	607589175                       # 0x24371337
	.long	607621957                       # 0x24379345
	.long	607654734                       # 0x2438134e
	.long	607687515                       # 0x2438935b
	.long	607720302                       # 0x2439136e
	.long	674368723                       # 0x28320cd3
	.long	674401515                       # 0x28328ceb
	.long	674434211                       # 0x28330ca3
	.long	674467070                       # 0x28338cfe
	.long	674499807                       # 0x28340cdf
	.long	674529465                       # 0x283480b9
	.long	674562295                       # 0x283500f7
	.long	674598017                       # 0x28358c81
	.long	674630042                       # 0x2836099a
	.long	741487354                       # 0x2c3232fa
	.long	741512069                       # 0x2c329385
	.long	741552904                       # 0x2c333308
	.long	741585690                       # 0x2c33b31a
	.long	741618478                       # 0x2c34332e
	.long	741651264                       # 0x2c34b340
	.long	741684059                       # 0x2c35335b
	.long	741716845                       # 0x2c35b36d
	.long	741749661                       # 0x2c36339d
	.long	741770042                       # 0x2c36833a
	.long	741815210                       # 0x2c3733aa
	.long	741848022                       # 0x2c37b3d6
	.long	741880852                       # 0x2c383414
	.long	741913643                       # 0x2c38b42b
	.long	741946441                       # 0x2c393449
	.long	741979225                       # 0x2c39b459
	.long	742012011                       # 0x2c3a346b
	.long	742044799                       # 0x2c3ab47f
	.long	742077584                       # 0x2c3b3490
	.long	742110383                       # 0x2c3bb4af
	.long	742134679                       # 0x2c3c1397
	.long	742167469                       # 0x2c3c93ad
	.long	742208756                       # 0x2c3d34f4
	.long	742233030                       # 0x2c3d93c6
	.long	742274334                       # 0x2c3e351e
	.long	742307116                       # 0x2c3eb52c
	.long	742339908                       # 0x2c3f3544
	.long	742372700                       # 0x2c3fb55c
	.long	742405510                       # 0x2c403586
	.long	742429336                       # 0x2c409298
	.long	742471063                       # 0x2c413597
	.long	742503850                       # 0x2c41b5aa
	.long	742527582                       # 0x2c42125e
	.long	742569403                       # 0x2c42b5bb
	.long	742590317                       # 0x2c43076d
	.long	742634657                       # 0x2c43b4a1
	.long	742667241                       # 0x2c4433e9
	.long	742700393                       # 0x2c44b569
	.long	742732672                       # 0x2c453380
	.long	742765500                       # 0x2c45b3bc
	.long	742798393                       # 0x2c463439
	.long	742831299                       # 0x2c46b4c3
	.long	742864088                       # 0x2c4734d8
	.long	742896913                       # 0x2c47b511
	.long	742929403                       # 0x2c4833fb
	.long	808583168                       # 0x30320000
	.long	808615957                       # 0x30328015
	.long	808648735                       # 0x3033001f
	.long	808681528                       # 0x30338038
	.long	808714327                       # 0x30340057
	.long	808747121                       # 0x30348071
	.long	808779896                       # 0x30350078
	.long	808812688                       # 0x30358090
	.long	808845473                       # 0x303600a1
	.long	808878265                       # 0x303680b9
	.long	808911046                       # 0x303700c6
	.long	808943829                       # 0x303780d5
	.long	808976631                       # 0x303800f7
	.long	809009412                       # 0x30388104
	.long	809042199                       # 0x30390117
	.long	809074994                       # 0x30398132
	.long	809107783                       # 0x303a0147
	.long	809140571                       # 0x303a815b
	.long	809173359                       # 0x303b016f
	.long	809206144                       # 0x303b8180
	.long	809238937                       # 0x303c0199
	.long	809271734                       # 0x303c81b6
	.long	809304516                       # 0x303d01c4
	.long	809337304                       # 0x303d81d8
	.long	809370088                       # 0x303e01e8
	.long	809402881                       # 0x303e8201
	.long	809435665                       # 0x303f0211
	.long	809468452                       # 0x303f8224
	.long	809501235                       # 0x30400233
	.long	809534015                       # 0x3040823f
	.long	809566804                       # 0x30410254
	.long	809599588                       # 0x30418264
	.long	809632379                       # 0x3042027b
	.long	809665160                       # 0x30428288
	.long	809697947                       # 0x3043029b
	.long	809730730                       # 0x304382aa
	.long	809763519                       # 0x304402bf
	.long	809796320                       # 0x304482e0
	.long	809829107                       # 0x304502f3
	.long	809861894                       # 0x30458306
	.long	809894687                       # 0x3046031f
	.long	809927482                       # 0x3046833a
	.long	809960306                       # 0x30470372
	.long	809993092                       # 0x30478384
	.long	810025890                       # 0x304803a2
	.long	810058675                       # 0x304883b3
	.long	810091458                       # 0x304903c2
	.long	810124250                       # 0x304983da
	.long	810157036                       # 0x304a03ec
	.long	810189824                       # 0x304a8400
	.long	810222616                       # 0x304b0418
	.long	810255403                       # 0x304b842b
	.long	810288182                       # 0x304c0436
	.long	810320967                       # 0x304c8447
	.long	810353747                       # 0x304d0453
	.long	810386537                       # 0x304d8469
	.long	810419319                       # 0x304e0477
	.long	810452109                       # 0x304e848d
	.long	810484895                       # 0x304f049f
	.long	810517681                       # 0x304f84b1
	.long	810550484                       # 0x305004d4
	.long	810583271                       # 0x305084e7
	.long	810616056                       # 0x305104f8
	.long	810648840                       # 0x30518508
	.long	810681632                       # 0x30520520
	.long	810714421                       # 0x30528535
	.long	810747213                       # 0x3053054d
	.long	810780001                       # 0x30538561
	.long	810812793                       # 0x30540579
	.long	810845586                       # 0x30548592
	.long	810878379                       # 0x305505ab
	.long	810911176                       # 0x305585c8
	.long	810943955                       # 0x305605d3
	.long	810976747                       # 0x305685eb
	.long	811009531                       # 0x305705fb
	.long	811042316                       # 0x3057860c
	.long	811075103                       # 0x3058061f
	.long	811107893                       # 0x30588635
	.long	811140670                       # 0x3059063e
	.long	811173459                       # 0x30598653
	.long	811206246                       # 0x305a0666
	.long	811239029                       # 0x305a8675
	.long	811271829                       # 0x305b0695
	.long	811304612                       # 0x305b86a4
	.long	811337413                       # 0x305c06c5
	.long	811370209                       # 0x305c86e1
	.long	811402989                       # 0x305d06ed
	.long	811435789                       # 0x305d870d
	.long	811468585                       # 0x305e0729
	.long	811501389                       # 0x305e874d
	.long	811534179                       # 0x305f0763
	.long	811566957                       # 0x305f876d
	.long	811599044                       # 0x306004c4
	.long	811630666                       # 0x3060804a
	.long	811664215                       # 0x30610357
	.long	811697978                       # 0x3061873a
	.long	811729810                       # 0x30620392
	.long	875695024                       # 0x34320bb0
	.long	875727812                       # 0x34328bc4
	.long	875760609                       # 0x34330be1
	.long	875793396                       # 0x34338bf4
	.long	875826179                       # 0x34340c03
	.long	875859037                       # 0x34348c5d
	.long	875891777                       # 0x34350c41
	.long	875924512                       # 0x34358c20
	.long	1009909904                      # 0x3c320090
	.long	1009945896                      # 0x3c328d28
	.long	1009978689                      # 0x3c330d41
	.long	1010011484                      # 0x3c338d5c
	.long	1010044281                      # 0x3c340d79
	.long	1010077091                      # 0x3c348da3
	.long	1010109886                      # 0x3c350dbe
	.long	1010142692                      # 0x3c358de4
	.long	1010175485                      # 0x3c360dfd
	.long	1010208277                      # 0x3c368e15
	.long	1010241062                      # 0x3c370e26
	.long	1010273844                      # 0x3c378e34
	.long	1010306625                      # 0x3c380e41
	.long	1010339413                      # 0x3c388e55
	.long	1010371819                      # 0x3c390ceb
	.long	1010404984                      # 0x3c398e78
	.long	1010437772                      # 0x3c3a0e8c
	.long	1010469210                      # 0x3c3a895a
	.long	1010503324                      # 0x3c3b0e9c
	.long	1010536119                      # 0x3c3b8eb7
	.long	1010568905                      # 0x3c3c0ec9
	.long	1010601724                      # 0x3c3c8efc
	.long	1010634502                      # 0x3c3d0f06
	.long	1010667290                      # 0x3c3d8f1a
	.long	1010700072                      # 0x3c3e0f28
	.long	1010732877                      # 0x3c3e8f4d
	.long	1010765076                      # 0x3c3f0d14
	.long	1010798390                      # 0x3c3f8f36
	.long	1010827449                      # 0x3c4000b9
	.long	1010860279                      # 0x3c4080f7
	.long	1010896276                      # 0x3c410d94
	.long	1010929107                      # 0x3c418dd3
	.long	1010962143                      # 0x3c420edf
	.long	1010994793                      # 0x3c428e69
	.long	1077025346                      # 0x40321a42
	.long	1077058136                      # 0x40329a58
	.long	1077090950                      # 0x40331a86
	.long	1077123728                      # 0x40339a90
	.long	1077156519                      # 0x40341aa7
	.long	1077189317                      # 0x40349ac5
	.long	1077222101                      # 0x40351ad5
	.long	1077254887                      # 0x40359ae7
	.long	1077287668                      # 0x40361af4
	.long	1077320448                      # 0x40369b00
	.long	1077353237                      # 0x40371b15
	.long	1077386023                      # 0x40379b27
	.long	1077418802                      # 0x40381b32
	.long	1077451588                      # 0x40389b44
	.long	1077481363                      # 0x40390f93
	.long	1077517140                      # 0x40399b54
	.long	1077549927                      # 0x403a1b67
	.long	1077582728                      # 0x403a9b88
	.long	1077615513                      # 0x403b1b99
	.long	1077648297                      # 0x403b9ba9
	.long	1077674097                      # 0x403c0071
	.long	1077706896                      # 0x403c8090
	.long	1077746698                      # 0x403d1c0a
	.long	1077779488                      # 0x403d9c20
	.long	1077812271                      # 0x403e1c2f
	.long	1077845095                      # 0x403e9c67
	.long	1077877889                      # 0x403f1c81
	.long	1077910697                      # 0x403f9ca9
	.long	1077943486                      # 0x40401cbe
	.long	1077976274                      # 0x40409cd2
	.long	1078009101                      # 0x40411d0d
	.long	1078041896                      # 0x40419d28
	.long	1078074689                      # 0x40421d41
	.long	1078107476                      # 0x40429d54
	.long	1078140264                      # 0x40431d68
	.long	1078173078                      # 0x40439d96
	.long	1078205869                      # 0x40441dad
	.long	1078231225                      # 0x404480b9
	.long	1078271426                      # 0x40451dc2
	.long	1078304212                      # 0x40459dd4
	.long	1078337016                      # 0x40461df8
	.long	1078369816                      # 0x40469e18
	.long	1078402598                      # 0x40471e26
	.long	1078435405                      # 0x40479e4d
	.long	1078468286                      # 0x40481ebe
	.long	1078501240                      # 0x40489f78
	.long	1078534031                      # 0x40491f8f
	.long	1078566825                      # 0x40499fa9
	.long	1078599616                      # 0x404a1fc0
	.long	1078632414                      # 0x404a9fde
	.long	1078665206                      # 0x404b1ff6
	.long	1078698019                      # 0x404ba023
	.long	1078730809                      # 0x404c2039
	.long	1078763595                      # 0x404ca04b
	.long	1078796396                      # 0x404d206c
	.long	1078829221                      # 0x404da0a5
	.long	1078862009                      # 0x404e20b9
	.long	1078894790                      # 0x404ea0c6
	.long	1078927735                      # 0x404f2177
	.long	1078960621                      # 0x404fa1ed
	.long	1078993500                      # 0x4050225c
	.long	1079026288                      # 0x4050a270
	.long	1079059107                      # 0x405122a3
	.long	1079124659                      # 0x405222b3
	.long	1079157463                      # 0x4052a2d7
	.long	1079190255                      # 0x405322ef
	.long	1079223042                      # 0x4053a302
	.long	1079255831                      # 0x40542317
	.long	1079288634                      # 0x4054a33a
	.long	1079321445                      # 0x40552365
	.long	1079354274                      # 0x4055a3a2
	.long	1079387079                      # 0x405623c7
	.long	1079419872                      # 0x4056a3e0
	.long	1079452664                      # 0x405723f8
	.long	1079485451                      # 0x4057a40b
	.long	1079518240                      # 0x40582420
	.long	1079551047                      # 0x4058a447
	.long	1079583862                      # 0x40592476
	.long	1079616675                      # 0x4059a4a3
	.long	1079682231                      # 0x405aa4b7
	.long	1079715023                      # 0x405b24cf
	.long	1079747808                      # 0x405ba4e0
	.long	1079780595                      # 0x405c24f3
	.long	1079813426                      # 0x405ca532
	.long	1079846207                      # 0x405d253f
	.long	1079879012                      # 0x405da564
	.long	1079911842                      # 0x405e25a2
	.long	1079937790                      # 0x405e8afe
	.long	1079977411                      # 0x405f25c3
	.long	1080010192                      # 0x405fa5d0
	.long	1080042974                      # 0x406025de
	.long	1080075776                      # 0x4060a600
	.long	1080108641                      # 0x40612661
	.long	1080141465                      # 0x4061a699
	.long	1080174256                      # 0x406226b0
	.long	1080207041                      # 0x4062a6c1
	.long	1080239886                      # 0x4063270e
	.long	1080272675                      # 0x4063a723
	.long	1080305466                      # 0x4064273a
	.long	1080338278                      # 0x4064a766
	.long	1080371073                      # 0x40652781
	.long	1080403864                      # 0x4065a798
	.long	1080436656                      # 0x406627b0
	.long	1080469466                      # 0x4066a7da
	.long	1080502277                      # 0x40672805
	.long	1080535114                      # 0x4067a84a
	.long	1080567954                      # 0x40682892
	.long	1080600755                      # 0x4068a8b3
	.long	1080633573                      # 0x406928e5
	.long	1080666387                      # 0x4069a913
	.long	1080699188                      # 0x406a2934
	.long	1080731988                      # 0x406aa954
	.long	1080765148                      # 0x406b2adc
	.long	1080797951                      # 0x406baaff
	.long	1080830741                      # 0x406c2b15
	.long	1080864287                      # 0x406cae1f
	.long	1080897102                      # 0x406d2e4e
	.long	1080929910                      # 0x406dae76
	.long	1080962724                      # 0x406e2ea4
	.long	1080995569                      # 0x406eaef1
	.long	1081028426                      # 0x406f2f4a
	.long	1081061250                      # 0x406faf82
	.long	1081094037                      # 0x40702f95
	.long	1081126834                      # 0x4070afb2
	.long	1081149517                      # 0x4071084d
	.long	1081192388                      # 0x4071afc4
	.long	1081225175                      # 0x40722fd7
	.long	1081257997                      # 0x4072b00d
	.long	1081290789                      # 0x40733025
	.long	1081316783                      # 0x407395af
	.long	1081356345                      # 0x40743039
	.long	1081389139                      # 0x4074b053
	.long	1081421924                      # 0x40753064
	.long	1081454712                      # 0x4075b078
	.long	1081487494                      # 0x40763086
	.long	1081512795                      # 0x4076935b
	.long	1081553067                      # 0x407730ab
	.long	1081585899                      # 0x4077b0eb
	.long	1081618694                      # 0x40783106
	.long	1081651519                      # 0x4078b13f
	.long	1081684310                      # 0x40793156
	.long	1081717100                      # 0x4079b16c
	.long	1081749912                      # 0x407a3198
	.long	1081782699                      # 0x407ab1ab
	.long	1081815488                      # 0x407b31c0
	.long	1081848274                      # 0x407bb1d2
	.long	1081881091                      # 0x407c3203
	.long	1081913868                      # 0x407cb20c
	.long	1081944270                      # 0x407d28ce
	.long	1081975317                      # 0x407da215
	.long	1082011931                      # 0x407e311b
	.long	1082041431                      # 0x407ea457
	.long	1082072634                      # 0x407f1e3a
	.long	1082105869                      # 0x407fa00d
	.long	1082139015                      # 0x40802187
	.long	1082170978                      # 0x40809e62
	.long	1082204869                      # 0x408122c5
	.long	1082237204                      # 0x4081a114
	.long	1082273423                      # 0x40822e8f
	.long	1082301365                      # 0x40829bb5
	.long	1082336306                      # 0x40832432
	.long	1082369867                      # 0x4083a74b
	.long	1082400374                      # 0x40841e76
	.long	1082434703                      # 0x4084a48f
	.long	1082467588                      # 0x40852504
	.long	1082500648                      # 0x4085a628
	.long	1082533252                      # 0x40862584
	.long	1082565167                      # 0x4086a22f
	.long	1082601173                      # 0x40872ed5
	.long	1082631798                      # 0x4087a676
	.long	1082661875                      # 0x40881bf3
	.long	1082697821                      # 0x4088a85d
	.long	1082727490                      # 0x40891c42
	.long	1082760143                      # 0x40899bcf
	.long	1082796877                      # 0x408a2b4d
	.long	1082825159                      # 0x408a99c7
	.long	1082864103                      # 0x408b31e7
	.long	1082896223                      # 0x408baf5f
	.long	1082926356                      # 0x408c2514
	.long	1082956287                      # 0x408c99ff
	.long	1082990430                      # 0x408d1f5e
	.long	1083023016                      # 0x408d9ea8
	.long	1083056270                      # 0x408e208e
	.long	1083089794                      # 0x408ea382
	.long	1083123825                      # 0x408f2871
	.long	1083156036                      # 0x408fa644
	.long	1083189286                      # 0x40902826
	.long	1083221334                      # 0x4090a556
	.long	1083255605                      # 0x40912b35
	.long	1083284005                      # 0x40919a25
	.long	1083317391                      # 0x40921c8f
	.long	1083354896                      # 0x4092af10
	.long	1083387888                      # 0x40932ff0
	.long	1083417152                      # 0x4093a240
	.long	1083448970                      # 0x40941e8a
	.long	1083485030                      # 0x4094ab66
	.long	1083516626                      # 0x409526d2
	.long	1083552120                      # 0x4095b178
	.long	1083584188                      # 0x40962ebc
	.long	1083613600                      # 0x4096a1a0
	.long	1083646603                      # 0x4097228b
	.long	1083678941                      # 0x4097a0dd
	.long	1083710703                      # 0x40981cef
	.long	1083746022                      # 0x4098a6e6
	.long	1083780908                      # 0x40992f2c
	.long	1083810735                      # 0x4099a3af
	.long	1083843400                      # 0x409a2348
	.long	1083873763                      # 0x409a99e3
	.long	1083907812                      # 0x409b1ee4
	.long	1083940623                      # 0x409b9f0f
	.long	1083977933                      # 0x409c30cd
	.long	1084006199                      # 0x409c9f37
	.long	1084039516                      # 0x409d215c
	.long	1084072234                      # 0x409da12a
	.long	1084104064                      # 0x409e1d80
	.long	1084137941                      # 0x409ea1d5
	.long	1084170685                      # 0x409f21bd
	.long	1084202711                      # 0x409f9ed7
	.long	1084236285                      # 0x40a021fd
	.long	1084268791                      # 0x40a0a0f7
	.long	1084301637                      # 0x40a12145
	.long	1106520583                      # 0x41f42a07
	.long	1106848409                      # 0x41f92a99
	.long	1107175820                      # 0x41fe298c
	.long	1107209282                      # 0x41feac42
	.long	1107242352                      # 0x41ff2d70
	.long	1107503648                      # 0x42032a20
	.long	1107831362                      # 0x42082a42
	.long	1107864190                      # 0x4208aa7e
	.long	1107896688                      # 0x42092970
	.long	1107929784                      # 0x4209aab8
	.long	1107962311                      # 0x420a29c7
	.long	1107995047                      # 0x420aa9a7
	.long	1108027879                      # 0x420b29e7
	.long	1108060768                      # 0x420baa60
	.long	1108094348                      # 0x420c2d8c
	.long	1108126582                      # 0x420cab76
	.long	1108159529                      # 0x420d2c29
	.long	1108192352                      # 0x420dac60
	.long	1108487315                      # 0x42122c93
	.long	1108815187                      # 0x42172d53
	.long	1108847829                      # 0x4217acd5
	.long	1109142775                      # 0x421c2cf7
	.long	1109339314                      # 0x421f2cb2
	.long	1109470724                      # 0x42212e04
	.long	1109798198                      # 0x42262d36
	.long	1110126050                      # 0x422b2de2
	.long	1110158340                      # 0x422bac04
	.long	1110191556                      # 0x422c2dc4
	.long	1110223799                      # 0x422cabb7
	.long	1110256528                      # 0x422d2b90
	.long	1110289827                      # 0x422dada3
	.long	1110322147                      # 0x422e2be3
	.long	1110453522                      # 0x42302d12
	.long	1110486138                      # 0x4230ac7a
	.long	1144129400                      # 0x44320778
	.long	1144162183                      # 0x44328787
	.long	1144194963                      # 0x44330793
	.long	1144227745                      # 0x443387a1
	.long	1144260532                      # 0x443407b4
	.long	1144293317                      # 0x443487c5
	.long	1144326092                      # 0x443507cc
	.long	1144358870                      # 0x443587d6
	.long	1144391657                      # 0x443607e9
	.long	1144424447                      # 0x443687ff
	.long	1144457233                      # 0x44370811
	.long	1144490014                      # 0x4437881e
	.long	1144522797                      # 0x4438082d
	.long	1144555573                      # 0x44388835
	.long	1144588365                      # 0x4439084d
	.long	1144621147                      # 0x4439885b
	.long	1144653934                      # 0x443a086e
	.long	1211241349                      # 0x48321385
	.long	1211274135                      # 0x48329397
	.long	1211306925                      # 0x483313ad
	.long	1211339718                      # 0x483393c6
	.long	1278350339                      # 0x4c321403
	.long	1278383123                      # 0x4c329413
	.long	1278415910                      # 0x4c331426
	.long	1278448710                      # 0x4c339446
	.long	1278476473                      # 0x4c3400b9
	.long	1278509303                      # 0x4c3480f7
	.long	1278547026                      # 0x4c351452
	.long	1278579808                      # 0x4c359460
	.long	1278612604                      # 0x4c36147c
	.long	1278645410                      # 0x4c3694a2
	.long	1278678193                      # 0x4c3714b1
	.long	1278710975                      # 0x4c3794bf
	.long	1278743764                      # 0x4c3814d4
	.long	1278776544                      # 0x4c3894e0
	.long	1278809344                      # 0x4c391500
	.long	1278842154                      # 0x4c39952a
	.long	1278874947                      # 0x4c3a1543
	.long	1278907740                      # 0x4c3a955c
	.long	1278936629                      # 0x4c3b0635
	.long	1278973301                      # 0x4c3b9575
	.long	1279006087                      # 0x4c3c1587
	.long	1279038870                      # 0x4c3c9596
	.long	1279071663                      # 0x4c3d15af
	.long	1279102150                      # 0x4c3d8cc6
	.long	1279137308                      # 0x4c3e161c
	.long	1279169982                      # 0x4c3e95be
	.long	1279202878                      # 0x4c3f163e
	.long	1279234907                      # 0x4c3f935b
	.long	1279268308                      # 0x4c4015d4
	.long	1279300591                      # 0x4c4093ef
	.long	1279333900                      # 0x4c41160c
	.long	1279366287                      # 0x4c41948f
	.long	1279399416                      # 0x4c4215f8
	.long	1279431639                      # 0x4c4293d7
	.long	1345467853                      # 0x503235cd
	.long	1345500636                      # 0x5032b5dc
	.long	1345533415                      # 0x503335e7
	.long	1345566199                      # 0x5033b5f7
	.long	1345598992                      # 0x50343610
	.long	1345631786                      # 0x5034b62a
	.long	1345664568                      # 0x50353638
	.long	1345697358                      # 0x5035b64e
	.long	1345730144                      # 0x50363660
	.long	1345762934                      # 0x5036b676
	.long	1345795727                      # 0x5037368f
	.long	1345828514                      # 0x5037b6a2
	.long	1345861306                      # 0x503836ba
	.long	1345894091                      # 0x5038b6cb
	.long	1345926880                      # 0x503936e0
	.long	1345959668                      # 0x5039b6f4
	.long	1345992468                      # 0x503a3714
	.long	1346025258                      # 0x503ab72a
	.long	1346058050                      # 0x503b3742
	.long	1346090836                      # 0x503bb754
	.long	1346123632                      # 0x503c3770
	.long	1346156423                      # 0x503cb787
	.long	1346189216                      # 0x503d37a0
	.long	1346222006                      # 0x503db7b6
	.long	1346254787                      # 0x503e37c3
	.long	1346287577                      # 0x503eb7d9
	.long	1346320363                      # 0x503f37eb
	.long	1346339763                      # 0x503f83b3
	.long	1346385918                      # 0x504037fe
	.long	1346418702                      # 0x5040b80e
	.long	1346451496                      # 0x50413828
	.long	1346484279                      # 0x5041b837
	.long	1346517073                      # 0x50423851
	.long	1346549870                      # 0x5042b86e
	.long	1346582654                      # 0x5043387e
	.long	1346615438                      # 0x5043b88e
	.long	1346648235                      # 0x504438ab
	.long	1346667625                      # 0x50448469
	.long	1346713791                      # 0x504538bf
	.long	1346746589                      # 0x5045b8dd
	.long	1346779376                      # 0x504638f0
	.long	1346812166                      # 0x5046b906
	.long	1346844952                      # 0x50473918
	.long	1346877741                      # 0x5047b92d
	.long	1346910547                      # 0x50483953
	.long	1346943329                      # 0x5048b961
	.long	1346976116                      # 0x50493974
	.long	1347008905                      # 0x5049b989
	.long	1347041695                      # 0x504a399f
	.long	1347074479                      # 0x504ab9af
	.long	1347107279                      # 0x504b39cf
	.long	1347140066                      # 0x504bb9e2
	.long	1347172869                      # 0x504c3a05
	.long	1347205683                      # 0x504cba33
	.long	1347238496                      # 0x504d3a60
	.long	1347271293                      # 0x504dba7d
	.long	1347304088                      # 0x504e3a98
	.long	1347336884                      # 0x504ebab4
	.long	1347369670                      # 0x504f3ac6
	.long	1347402461                      # 0x504fbadd
	.long	1347435244                      # 0x50503aec
	.long	1347454761                      # 0x50508729
	.long	1347500799                      # 0x50513aff
	.long	1347532957                      # 0x5051b89d
	.long	1347566149                      # 0x50523a45
	.long	1479675857                      # 0x58320fd1
	.long	1748111251                      # 0x68320f93
	.long	1748143339                      # 0x68328ceb
	.long	1748176126                      # 0x68330cfe
	.long	1748209569                      # 0x68338fa1
	.long	1748242353                      # 0x68340fb1
	.long	1748271351                      # 0x683480f7
	.long	1748306330                      # 0x6835099a
	.long	1815220057                      # 0x6c320f59
	.long	1815252149                      # 0x6c328cb5
	.long	1815285604                      # 0x6c330f64
	.long	1815318397                      # 0x6c338f7d
	.long	1949436518                      # 0x74320a66
	.long	1949466809                      # 0x743280b9
	.long	1949502662                      # 0x74330cc6
	.long	2016545227                      # 0x783209cb
	.long	2016578016                      # 0x783289e0
	.long	2016610796                      # 0x783309ec
	.long	2016641168                      # 0x78338090
	.long	2016676347                      # 0x783409fb
	.long	2016709136                      # 0x78348a10
	.long	2016741935                      # 0x78350a2f
	.long	2016774737                      # 0x78358a51
	.long	2016807526                      # 0x78360a66
	.long	2016840316                      # 0x78368a7c
	.long	2016873100                      # 0x78370a8c
	.long	2016905901                      # 0x78378aad
	.long	2016938688                      # 0x78380ac0
	.long	2016971474                      # 0x78388ad2
	.long	2017004255                      # 0x78390adf
	.long	2017037054                      # 0x78398afe
	.long	2017069843                      # 0x783a0b13
	.long	2017102625                      # 0x783a8b21
	.long	2017135403                      # 0x783b0b2b
	.long	2017168191                      # 0x783b8b3f
	.long	2017200982                      # 0x783c0b56
	.long	2017233771                      # 0x783c8b6b
	.long	2017266562                      # 0x783d0b82
	.long	2017299351                      # 0x783d8b97
	.long	2017331949                      # 0x783e0aed
	.long	2017364639                      # 0x783e8a9f
	.long	2083656308                      # 0x7c321274
	.long	2150765730                      # 0x803214a2
	.long	2150793360                      # 0x80328090
	.long	2150838985                      # 0x803332c9
	.long	2150858937                      # 0x803380b9
	.long	2150904536                      # 0x803432d8
	.long	2150937152                      # 0x8034b240
	.long	2150969950                      # 0x8035325e
	.long	2151002860                      # 0x8035b2ec
	.long	2151035552                      # 0x803632a0
	.long	2151068239                      # 0x8036b24f
	.long	2151101074                      # 0x80373292
	.long	2151133741                      # 0x8037b22d
	.long	2151166643                      # 0x803832b3
	.long	2151199343                      # 0x8038b26f
	.long	2151232132                      # 0x80393284
	.size	kOpenSSLReasonValues, 3028

	.type	kOpenSSLReasonValuesLen,@object # @kOpenSSLReasonValuesLen
	.globl	kOpenSSLReasonValuesLen
	.p2align	3, 0x0
kOpenSSLReasonValuesLen:
	.quad	757                             # 0x2f5
	.size	kOpenSSLReasonValuesLen, 8

	.type	kOpenSSLReasonStringData,@object # @kOpenSSLReasonStringData
	.globl	kOpenSSLReasonStringData
	.p2align	4, 0x0
kOpenSSLReasonStringData:
	.asciz	"ASN1_LENGTH_MISMATCH\000AUX_ERROR\000BAD_GET_ASN1_OBJECT_CALL\000BAD_OBJECT_HEADER\000BAD_TEMPLATE\000BMPSTRING_IS_WRONG_LENGTH\000BN_LIB\000BOOLEAN_IS_WRONG_LENGTH\000BUFFER_TOO_SMALL\000CONTEXT_NOT_INITIALISED\000DECODE_ERROR\000DEPTH_EXCEEDED\000DIGEST_AND_KEY_TYPE_NOT_SUPPORTED\000ENCODE_ERROR\000ERROR_GETTING_TIME\000EXPECTING_AN_ASN1_SEQUENCE\000EXPECTING_AN_INTEGER\000EXPECTING_AN_OBJECT\000EXPECTING_A_BOOLEAN\000EXPECTING_A_TIME\000EXPLICIT_LENGTH_MISMATCH\000EXPLICIT_TAG_NOT_CONSTRUCTED\000FIELD_MISSING\000FIRST_NUM_TOO_LARGE\000HEADER_TOO_LONG\000ILLEGAL_BITSTRING_FORMAT\000ILLEGAL_BOOLEAN\000ILLEGAL_CHARACTERS\000ILLEGAL_FORMAT\000ILLEGAL_HEX\000ILLEGAL_IMPLICIT_TAG\000ILLEGAL_INTEGER\000ILLEGAL_NESTED_TAGGING\000ILLEGAL_NULL\000ILLEGAL_NULL_VALUE\000ILLEGAL_OBJECT\000ILLEGAL_OPTIONAL_ANY\000ILLEGAL_OPTIONS_ON_ITEM_TEMPLATE\000ILLEGAL_TAGGED_ANY\000ILLEGAL_TIME_VALUE\000INTEGER_NOT_ASCII_FORMAT\000INTEGER_TOO_LARGE_FOR_LONG\000INVALID_BIT_STRING_BITS_LEFT\000INVALID_BIT_STRING_PADDING\000INVALID_BMPSTRING\000INVALID_DIGIT\000INVALID_INTEGER\000INVALID_MODIFIER\000INVALID_NUMBER\000INVALID_OBJECT_ENCODING\000INVALID_SEPARATOR\000INVALID_TIME_FORMAT\000INVALID_UNIVERSALSTRING\000INVALID_UTF8STRING\000LIST_ERROR\000MISSING_ASN1_EOS\000MISSING_EOC\000MISSING_SECOND_NUMBER\000MISSING_VALUE\000MSTRING_NOT_UNIVERSAL\000MSTRING_WRONG_TAG\000NESTED_ASN1_ERROR\000NESTED_ASN1_STRING\000NESTED_TOO_DEEP\000NON_HEX_CHARACTERS\000NOT_ASCII_FORMAT\000NOT_ENOUGH_DATA\000NO_MATCHING_CHOICE_TYPE\000NULL_IS_WRONG_LENGTH\000OBJECT_NOT_ASCII_FORMAT\000ODD_NUMBER_OF_CHARS\000SECOND_NUMBER_TOO_LARGE\000SEQUENCE_LENGTH_MISMATCH\000SEQUENCE_NOT_CONSTRUCTED\000SEQUENCE_OR_SET_NEEDS_CONFIG\000SHORT_LINE\000STREAMING_NOT_SUPPORTED\000STRING_TOO_LONG\000STRING_TOO_SHORT\000TAG_VALUE_TOO_HIGH\000TIME_NOT_ASCII_FORMAT\000TOO_LONG\000TYPE_NOT_CONSTRUCTED\000TYPE_NOT_PRIMITIVE\000UNEXPECTED_EOC\000UNIVERSALSTRING_IS_WRONG_LENGTH\000UNKNOWN_FORMAT\000UNKNOWN_MESSAGE_DIGEST_ALGORITHM\000UNKNOWN_SIGNATURE_ALGORITHM\000UNKNOWN_TAG\000UNSUPPORTED_ANY_DEFINED_BY_TYPE\000UNSUPPORTED_PUBLIC_KEY_TYPE\000UNSUPPORTED_TYPE\000WRONG_INTEGER_TYPE\000WRONG_PUBLIC_KEY_TYPE\000WRONG_TAG\000WRONG_TYPE\000BAD_FOPEN_MODE\000BROKEN_PIPE\000CONNECT_ERROR\000ERROR_SETTING_NBIO\000INVALID_ARGUMENT\000IN_USE\000KEEPALIVE\000NBIO_CONNECT_ERROR\000NO_HOSTNAME_SPECIFIED\000NO_PORT_SPECIFIED\000NO_SUCH_FILE\000NULL_PARAMETER\000SYS_LIB\000UNABLE_TO_CREATE_SOCKET\000UNINITIALIZED\000UNSUPPORTED_METHOD\000WRITE_TO_READ_ONLY_BIO\000ARG2_LT_ARG3\000BAD_ENCODING\000BAD_RECIPROCAL\000BIGNUM_TOO_LONG\000BITS_TOO_SMALL\000CALLED_WITH_EVEN_MODULUS\000DIV_BY_ZERO\000EXPAND_ON_STATIC_BIGNUM_DATA\000INPUT_NOT_REDUCED\000INVALID_INPUT\000INVALID_RANGE\000NEGATIVE_NUMBER\000NOT_A_SQUARE\000NOT_INITIALIZED\000NO_INVERSE\000PRIVATE_KEY_TOO_LARGE\000P_IS_NOT_PRIME\000TOO_MANY_ITERATIONS\000TOO_MANY_TEMPORARY_VARIABLES\000AES_KEY_SETUP_FAILED\000BAD_DECRYPT\000BAD_KEY_LENGTH\000CTRL_NOT_IMPLEMENTED\000CTRL_OPERATION_NOT_IMPLEMENTED\000DATA_NOT_MULTIPLE_OF_BLOCK_LENGTH\000INITIALIZATION_ERROR\000INPUT_NOT_INITIALIZED\000INVALID_AD_SIZE\000INVALID_KEY_LENGTH\000INVALID_NONCE\000INVALID_NONCE_SIZE\000INVALID_OPERATION\000IV_TOO_LARGE\000NO_CIPHER_SET\000NO_DIRECTION_SET\000OUTPUT_ALIASES_INPUT\000TAG_TOO_LARGE\000TOO_LARGE\000UNSUPPORTED_AD_SIZE\000UNSUPPORTED_INPUT_SIZE\000UNSUPPORTED_KEY_SIZE\000UNSUPPORTED_NONCE_SIZE\000UNSUPPORTED_TAG_SIZE\000WRONG_FINAL_BLOCK_LENGTH\000LIST_CANNOT_BE_NULL\000MISSING_CLOSE_SQUARE_BRACKET\000MISSING_EQUAL_SIGN\000NO_CLOSE_BRACE\000UNABLE_TO_CREATE_NEW_SECTION\000VARIABLE_EXPANSION_NOT_SUPPORTED\000VARIABLE_EXPANSION_TOO_LONG\000VARIABLE_HAS_NO_VALUE\000BAD_GENERATOR\000INVALID_PARAMETERS\000INVALID_PUBKEY\000MODULUS_TOO_LARGE\000NO_PRIVATE_VALUE\000UNKNOWN_HASH\000BAD_Q_VALUE\000BAD_VERSION\000MISSING_PARAMETERS\000NEED_NEW_SETUP_VALUES\000BIGNUM_OUT_OF_RANGE\000COORDINATES_OUT_OF_RANGE\000D2I_ECPKPARAMETERS_FAILURE\000EC_GROUP_NEW_BY_NAME_FAILURE\000GROUP2PKPARAMETERS_FAILURE\000GROUP_MISMATCH\000I2D_ECPKPARAMETERS_FAILURE\000INCOMPATIBLE_OBJECTS\000INVALID_COFACTOR\000INVALID_COMPRESSED_POINT\000INVALID_COMPRESSION_BIT\000INVALID_ENCODING\000INVALID_FIELD\000INVALID_FORM\000INVALID_GROUP_ORDER\000INVALID_PRIVATE_KEY\000INVALID_SCALAR\000MISSING_PRIVATE_KEY\000NON_NAMED_CURVE\000PKPARAMETERS2GROUP_FAILURE\000POINT_AT_INFINITY\000POINT_IS_NOT_ON_CURVE\000PUBLIC_KEY_VALIDATION_FAILED\000SLOT_FULL\000UNDEFINED_GENERATOR\000UNKNOWN_GROUP\000UNKNOWN_ORDER\000WRONG_CURVE_PARAMETERS\000WRONG_ORDER\000KDF_FAILED\000POINT_ARITHMETIC_FAILURE\000UNKNOWN_DIGEST_LENGTH\000BAD_SIGNATURE\000NOT_IMPLEMENTED\000RANDOM_NUMBER_GENERATION_FAILED\000OPERATION_NOT_SUPPORTED\000COMMAND_NOT_SUPPORTED\000DIFFERENT_KEY_TYPES\000DIFFERENT_PARAMETERS\000EMPTY_PSK\000EXPECTING_AN_EC_KEY_KEY\000EXPECTING_AN_RSA_KEY\000EXPECTING_A_DH_KEY\000EXPECTING_A_DSA_KEY\000ILLEGAL_OR_UNSUPPORTED_PADDING_MODE\000INVALID_BUFFER_SIZE\000INVALID_DIGEST_LENGTH\000INVALID_DIGEST_TYPE\000INVALID_KEYBITS\000INVALID_MGF1_MD\000INVALID_PADDING_MODE\000INVALID_PEER_KEY\000INVALID_PSS_SALTLEN\000INVALID_SIGNATURE\000KEYS_NOT_SET\000MEMORY_LIMIT_EXCEEDED\000NOT_A_PRIVATE_KEY\000NOT_XOF_OR_INVALID_LENGTH\000NO_DEFAULT_DIGEST\000NO_KEY_SET\000NO_MDC2_SUPPORT\000NO_NID_FOR_CURVE\000NO_OPERATION_SET\000NO_PARAMETERS_SET\000OPERATION_NOT_SUPPORTED_FOR_THIS_KEYTYPE\000OPERATON_NOT_INITIALIZED\000UNKNOWN_PUBLIC_KEY_TYPE\000UNSUPPORTED_ALGORITHM\000OUTPUT_TOO_LARGE\000INVALID_OID_STRING\000UNKNOWN_NID\000BAD_BASE64_DECODE\000BAD_END_LINE\000BAD_IV_CHARS\000BAD_PASSWORD_READ\000CIPHER_IS_NULL\000ERROR_CONVERTING_PRIVATE_KEY\000NOT_DEK_INFO\000NOT_ENCRYPTED\000NOT_PROC_TYPE\000NO_START_LINE\000READ_KEY\000SHORT_HEADER\000UNSUPPORTED_CIPHER\000UNSUPPORTED_ENCRYPTION\000BAD_PKCS7_VERSION\000NOT_PKCS7_SIGNED_DATA\000NO_CERTIFICATES_INCLUDED\000NO_CRLS_INCLUDED\000AMBIGUOUS_FRIENDLY_NAME\000BAD_ITERATION_COUNT\000BAD_PKCS12_DATA\000BAD_PKCS12_VERSION\000CIPHER_HAS_NO_OBJECT_IDENTIFIER\000CRYPT_ERROR\000ENCRYPT_ERROR\000ERROR_SETTING_CIPHER_PARAMS\000INCORRECT_PASSWORD\000INVALID_CHARACTERS\000KEYGEN_FAILURE\000KEY_GEN_ERROR\000METHOD_NOT_SUPPORTED\000MISSING_MAC\000MULTIPLE_PRIVATE_KEYS_IN_PKCS12\000PKCS12_PUBLIC_KEY_INTEGRITY_NOT_SUPPORTED\000PKCS12_TOO_DEEPLY_NESTED\000PRIVATE_KEY_DECODE_ERROR\000PRIVATE_KEY_ENCODE_ERROR\000UNKNOWN_ALGORITHM\000UNKNOWN_CIPHER\000UNKNOWN_CIPHER_ALGORITHM\000UNKNOWN_DIGEST\000UNSUPPORTED_KEYLENGTH\000UNSUPPORTED_KEY_DERIVATION_FUNCTION\000UNSUPPORTED_OPTIONS\000UNSUPPORTED_PRF\000UNSUPPORTED_PRIVATE_KEY_ALGORITHM\000UNSUPPORTED_SALT_TYPE\000BAD_E_VALUE\000BAD_FIXED_HEADER_DECRYPT\000BAD_PAD_BYTE_COUNT\000BAD_RSA_PARAMETERS\000BLOCK_TYPE_IS_NOT_01\000BLOCK_TYPE_IS_NOT_02\000BN_NOT_INITIALIZED\000CANNOT_RECOVER_MULTI_PRIME_KEY\000CRT_PARAMS_ALREADY_GIVEN\000CRT_VALUES_INCORRECT\000DATA_LEN_NOT_EQUAL_TO_MOD_LEN\000DATA_TOO_LARGE\000DATA_TOO_LARGE_FOR_KEY_SIZE\000DATA_TOO_LARGE_FOR_MODULUS\000DATA_TOO_SMALL\000DATA_TOO_SMALL_FOR_KEY_SIZE\000DIGEST_TOO_BIG_FOR_RSA_KEY\000D_E_NOT_CONGRUENT_TO_1\000D_OUT_OF_RANGE\000EMPTY_PUBLIC_KEY\000FIRST_OCTET_INVALID\000INCONSISTENT_SET_OF_CRT_VALUES\000INTERNAL_ERROR\000INVALID_MESSAGE_LENGTH\000KEY_SIZE_TOO_SMALL\000LAST_OCTET_INVALID\000MUST_HAVE_AT_LEAST_TWO_PRIMES\000NO_PUBLIC_EXPONENT\000NULL_BEFORE_BLOCK_MISSING\000N_NOT_EQUAL_P_Q\000OAEP_DECODING_ERROR\000ONLY_ONE_OF_P_Q_GIVEN\000OUTPUT_BUFFER_TOO_SMALL\000PADDING_CHECK_FAILED\000PKCS_DECODING_ERROR\000SLEN_CHECK_FAILED\000SLEN_RECOVERY_FAILED\000UNKNOWN_ALGORITHM_TYPE\000UNKNOWN_PADDING_TYPE\000VALUE_MISSING\000WRONG_SIGNATURE_LENGTH\000ALPN_MISMATCH_ON_EARLY_DATA\000ALPS_MISMATCH_ON_EARLY_DATA\000APPLICATION_DATA_INSTEAD_OF_HANDSHAKE\000APPLICATION_DATA_ON_SHUTDOWN\000APP_DATA_IN_HANDSHAKE\000ATTEMPT_TO_REUSE_SESSION_IN_DIFFERENT_CONTEXT\000BAD_ALERT\000BAD_CHANGE_CIPHER_SPEC\000BAD_DATA_RETURNED_BY_CALLBACK\000BAD_DH_P_LENGTH\000BAD_DIGEST_LENGTH\000BAD_ECC_CERT\000BAD_ECPOINT\000BAD_HANDSHAKE_RECORD\000BAD_HELLO_REQUEST\000BAD_LENGTH\000BAD_PACKET_LENGTH\000BAD_RSA_ENCRYPT\000BAD_SRTP_MKI_VALUE\000BAD_SRTP_PROTECTION_PROFILE_LIST\000BAD_SSL_FILETYPE\000BAD_WRITE_RETRY\000BIO_NOT_SET\000BLOCK_CIPHER_PAD_IS_WRONG\000CANNOT_HAVE_BOTH_PRIVKEY_AND_METHOD\000CANNOT_PARSE_LEAF_CERT\000CA_DN_LENGTH_MISMATCH\000CA_DN_TOO_LONG\000CCS_RECEIVED_EARLY\000CERTIFICATE_AND_PRIVATE_KEY_MISMATCH\000CERTIFICATE_VERIFY_FAILED\000CERT_CB_ERROR\000CERT_DECOMPRESSION_FAILED\000CERT_LENGTH_MISMATCH\000CHANNEL_ID_NOT_P256\000CHANNEL_ID_SIGNATURE_INVALID\000CIPHER_MISMATCH_ON_EARLY_DATA\000CIPHER_OR_HASH_UNAVAILABLE\000CLIENTHELLO_PARSE_FAILED\000CLIENTHELLO_TLSEXT\000CONNECTION_REJECTED\000CONNECTION_TYPE_NOT_SET\000COULD_NOT_PARSE_HINTS\000CUSTOM_EXTENSION_ERROR\000DATA_LENGTH_TOO_LONG\000DECRYPTION_FAILED\000DECRYPTION_FAILED_OR_BAD_RECORD_MAC\000DH_PUBLIC_VALUE_LENGTH_IS_WRONG\000DH_P_TOO_LONG\000DIGEST_CHECK_FAILED\000DOWNGRADE_DETECTED\000DTLS_MESSAGE_TOO_BIG\000DUPLICATE_EXTENSION\000DUPLICATE_KEY_SHARE\000DUPLICATE_SIGNATURE_ALGORITHM\000EARLY_DATA_NOT_IN_USE\000ECC_CERT_NOT_FOR_SIGNING\000ECH_REJECTED\000ECH_SERVER_CONFIG_AND_PRIVATE_KEY_MISMATCH\000ECH_SERVER_CONFIG_UNSUPPORTED_EXTENSION\000ECH_SERVER_WOULD_HAVE_NO_RETRY_CONFIGS\000EMPTY_HELLO_RETRY_REQUEST\000EMS_STATE_INCONSISTENT\000ENCRYPTED_LENGTH_TOO_LONG\000ERROR_ADDING_EXTENSION\000ERROR_IN_RECEIVED_CIPHER_LIST\000ERROR_PARSING_EXTENSION\000EXCESSIVE_MESSAGE_SIZE\000EXCESS_HANDSHAKE_DATA\000EXTRA_DATA_IN_MESSAGE\000FRAGMENT_MISMATCH\000GOT_NEXT_PROTO_WITHOUT_EXTENSION\000HANDSHAKE_FAILURE_ON_CLIENT_HELLO\000HANDSHAKE_NOT_COMPLETE\000HTTPS_PROXY_REQUEST\000HTTP_REQUEST\000INAPPROPRIATE_FALLBACK\000INCONSISTENT_CLIENT_HELLO\000INCONSISTENT_ECH_NEGOTIATION\000INVALID_ALPN_PROTOCOL\000INVALID_ALPN_PROTOCOL_LIST\000INVALID_ALPS_CODEPOINT\000INVALID_CLIENT_HELLO_INNER\000INVALID_COMMAND\000INVALID_COMPRESSION_LIST\000INVALID_DELEGATED_CREDENTIAL\000INVALID_ECH_CONFIG_LIST\000INVALID_ECH_PUBLIC_NAME\000INVALID_MESSAGE\000INVALID_OUTER_EXTENSION\000INVALID_OUTER_RECORD_TYPE\000INVALID_SCT_LIST\000INVALID_SIGNATURE_ALGORITHM\000INVALID_SSL_SESSION\000INVALID_TICKET_KEYS_LENGTH\000KEY_USAGE_BIT_INCORRECT\000LENGTH_MISMATCH\000MISSING_EXTENSION\000MISSING_KEY_SHARE\000MISSING_RSA_CERTIFICATE\000MISSING_TMP_DH_KEY\000MISSING_TMP_ECDH_KEY\000MIXED_SPECIAL_OPERATOR_WITH_GROUPS\000MTU_TOO_SMALL\000NEGOTIATED_ALPS_WITHOUT_ALPN\000NEGOTIATED_BOTH_NPN_AND_ALPN\000NEGOTIATED_TB_WITHOUT_EMS_OR_RI\000NESTED_GROUP\000NO_APPLICATION_PROTOCOL\000NO_CERTIFICATES_RETURNED\000NO_CERTIFICATE_ASSIGNED\000NO_CERTIFICATE_SET\000NO_CIPHERS_AVAILABLE\000NO_CIPHERS_PASSED\000NO_CIPHERS_SPECIFIED\000NO_CIPHER_MATCH\000NO_COMMON_SIGNATURE_ALGORITHMS\000NO_COMPRESSION_SPECIFIED\000NO_GROUPS_SPECIFIED\000NO_METHOD_SPECIFIED\000NO_PRIVATE_KEY_ASSIGNED\000NO_RENEGOTIATION\000NO_REQUIRED_DIGEST\000NO_SHARED_CIPHER\000NO_SHARED_GROUP\000NO_SUPPORTED_VERSIONS_ENABLED\000NULL_SSL_CTX\000NULL_SSL_METHOD_PASSED\000OCSP_CB_ERROR\000OLD_SESSION_CIPHER_NOT_RETURNED\000OLD_SESSION_PRF_HASH_MISMATCH\000OLD_SESSION_VERSION_NOT_RETURNED\000PARSE_TLSEXT\000PATH_TOO_LONG\000PEER_DID_NOT_RETURN_A_CERTIFICATE\000PEER_ERROR_UNSUPPORTED_CERTIFICATE_TYPE\000PRE_SHARED_KEY_MUST_BE_LAST\000PRIVATE_KEY_OPERATION_FAILED\000PROTOCOL_IS_SHUTDOWN\000PSK_IDENTITY_BINDER_COUNT_MISMATCH\000PSK_IDENTITY_NOT_FOUND\000PSK_NO_CLIENT_CB\000PSK_NO_SERVER_CB\000QUIC_INTERNAL_ERROR\000QUIC_TRANSPORT_PARAMETERS_MISCONFIGURED\000READ_TIMEOUT_EXPIRED\000RECORD_LENGTH_MISMATCH\000RECORD_TOO_LARGE\000RENEGOTIATION_EMS_MISMATCH\000RENEGOTIATION_ENCODING_ERR\000RENEGOTIATION_MISMATCH\000REQUIRED_CIPHER_MISSING\000RESUMED_EMS_SESSION_WITHOUT_EMS_EXTENSION\000RESUMED_NON_EMS_SESSION_WITH_EMS_EXTENSION\000SCSV_RECEIVED_WHEN_RENEGOTIATING\000SECOND_SERVERHELLO_VERSION_MISMATCH\000SERVERHELLO_TLSEXT\000SERVER_CERT_CHANGED\000SERVER_ECHOED_INVALID_SESSION_ID\000SESSION_ID_CONTEXT_UNINITIALIZED\000SESSION_MAY_NOT_BE_CREATED\000SHUTDOWN_WHILE_IN_INIT\000SIGNATURE_ALGORITHMS_EXTENSION_SENT_BY_SERVER\000SRTP_COULD_NOT_ALLOCATE_PROFILES\000SRTP_UNKNOWN_PROTECTION_PROFILE\000SSL3_EXT_INVALID_SERVERNAME\000SSLV3_ALERT_BAD_CERTIFICATE\000SSLV3_ALERT_BAD_RECORD_MAC\000SSLV3_ALERT_CERTIFICATE_EXPIRED\000SSLV3_ALERT_CERTIFICATE_REVOKED\000SSLV3_ALERT_CERTIFICATE_UNKNOWN\000SSLV3_ALERT_CLOSE_NOTIFY\000SSLV3_ALERT_DECOMPRESSION_FAILURE\000SSLV3_ALERT_HANDSHAKE_FAILURE\000SSLV3_ALERT_ILLEGAL_PARAMETER\000SSLV3_ALERT_NO_CERTIFICATE\000SSLV3_ALERT_UNEXPECTED_MESSAGE\000SSLV3_ALERT_UNSUPPORTED_CERTIFICATE\000SSL_CTX_HAS_NO_DEFAULT_SSL_VERSION\000SSL_HANDSHAKE_FAILURE\000SSL_SESSION_ID_CONTEXT_TOO_LONG\000SSL_SESSION_ID_TOO_LONG\000TICKET_ENCRYPTION_FAILED\000TLS13_DOWNGRADE\000TLSV1_ALERT_ACCESS_DENIED\000TLSV1_ALERT_BAD_CERTIFICATE_HASH_VALUE\000TLSV1_ALERT_BAD_CERTIFICATE_STATUS_RESPONSE\000TLSV1_ALERT_CERTIFICATE_REQUIRED\000TLSV1_ALERT_CERTIFICATE_UNOBTAINABLE\000TLSV1_ALERT_DECODE_ERROR\000TLSV1_ALERT_DECRYPTION_FAILED\000TLSV1_ALERT_DECRYPT_ERROR\000TLSV1_ALERT_ECH_REQUIRED\000TLSV1_ALERT_EXPORT_RESTRICTION\000TLSV1_ALERT_INAPPROPRIATE_FALLBACK\000TLSV1_ALERT_INSUFFICIENT_SECURITY\000TLSV1_ALERT_INTERNAL_ERROR\000TLSV1_ALERT_NO_APPLICATION_PROTOCOL\000TLSV1_ALERT_NO_RENEGOTIATION\000TLSV1_ALERT_PROTOCOL_VERSION\000TLSV1_ALERT_RECORD_OVERFLOW\000TLSV1_ALERT_UNKNOWN_CA\000TLSV1_ALERT_UNKNOWN_PSK_IDENTITY\000TLSV1_ALERT_UNRECOGNIZED_NAME\000TLSV1_ALERT_UNSUPPORTED_EXTENSION\000TLSV1_ALERT_USER_CANCELLED\000TLS_PEER_DID_NOT_RESPOND_WITH_CERTIFICATE_LIST\000TLS_RSA_ENCRYPTED_VALUE_LENGTH_IS_WRONG\000TOO_MANY_EMPTY_FRAGMENTS\000TOO_MANY_KEY_UPDATES\000TOO_MANY_WARNING_ALERTS\000TOO_MUCH_READ_EARLY_DATA\000TOO_MUCH_SKIPPED_EARLY_DATA\000UNABLE_TO_FIND_ECDH_PARAMETERS\000UNCOMPRESSED_CERT_TOO_LARGE\000UNEXPECTED_COMPATIBILITY_MODE\000UNEXPECTED_EXTENSION\000UNEXPECTED_EXTENSION_ON_EARLY_DATA\000UNEXPECTED_MESSAGE\000UNEXPECTED_OPERATOR_IN_GROUP\000UNEXPECTED_RECORD\000UNKNOWN_ALERT_TYPE\000UNKNOWN_CERTIFICATE_TYPE\000UNKNOWN_CERT_COMPRESSION_ALG\000UNKNOWN_CIPHER_RETURNED\000UNKNOWN_CIPHER_TYPE\000UNKNOWN_KEY_EXCHANGE_TYPE\000UNKNOWN_PROTOCOL\000UNKNOWN_SSL_VERSION\000UNKNOWN_STATE\000UNSAFE_LEGACY_RENEGOTIATION_DISABLED\000UNSUPPORTED_COMPRESSION_ALGORITHM\000UNSUPPORTED_ECH_SERVER_CONFIG\000UNSUPPORTED_ELLIPTIC_CURVE\000UNSUPPORTED_PROTOCOL\000UNSUPPORTED_PROTOCOL_FOR_CUSTOM_KEY\000WRONG_CERTIFICATE_TYPE\000WRONG_CIPHER_RETURNED\000WRONG_CURVE\000WRONG_ENCRYPTION_LEVEL_RECEIVED\000WRONG_MESSAGE_TYPE\000WRONG_SIGNATURE_TYPE\000WRONG_SSL_VERSION\000WRONG_VERSION_NUMBER\000WRONG_VERSION_ON_EARLY_DATA\000X509_LIB\000X509_VERIFICATION_SETUP_PROBLEMS\000BAD_VALIDITY_CHECK\000DECODE_FAILURE\000INVALID_KEY_ID\000INVALID_METADATA\000INVALID_METADATA_KEY\000INVALID_PROOF\000INVALID_TOKEN\000NO_KEYS_CONFIGURED\000NO_SRR_KEY_CONFIGURED\000OVER_BATCHSIZE\000SRR_SIGNATURE_ERROR\000TOO_MANY_KEYS\000AKID_MISMATCH\000BAD_X509_FILETYPE\000BASE64_DECODE_ERROR\000CANT_CHECK_DH_KEY\000CERT_ALREADY_IN_HASH_TABLE\000CRL_ALREADY_DELTA\000CRL_VERIFY_FAILURE\000DELTA_CRL_WITHOUT_CRL_NUMBER\000IDP_MISMATCH\000INVALID_DIRECTORY\000INVALID_FIELD_FOR_VERSION\000INVALID_FIELD_NAME\000INVALID_PARAMETER\000INVALID_POLICY_EXTENSION\000INVALID_PSS_PARAMETERS\000INVALID_TRUST\000INVALID_VERSION\000ISSUER_MISMATCH\000KEY_TYPE_MISMATCH\000KEY_VALUES_MISMATCH\000LOADING_CERT_DIR\000LOADING_DEFAULTS\000NAME_TOO_LONG\000NEWER_CRL_NOT_NEWER\000NO_CERTIFICATE_FOUND\000NO_CERTIFICATE_OR_CRL_FOUND\000NO_CERT_SET_FOR_US_TO_VERIFY\000NO_CRL_FOUND\000NO_CRL_NUMBER\000PUBLIC_KEY_DECODE_ERROR\000PUBLIC_KEY_ENCODE_ERROR\000SHOULD_RETRY\000SIGNATURE_ALGORITHM_MISMATCH\000UNKNOWN_KEY_TYPE\000UNKNOWN_PURPOSE_ID\000UNKNOWN_TRUST_ID\000WRONG_LOOKUP_TYPE\000BAD_IP_ADDRESS\000BAD_OBJECT\000BN_DEC2BN_ERROR\000BN_TO_ASN1_INTEGER_ERROR\000CANNOT_FIND_FREE_FUNCTION\000DIRNAME_ERROR\000DISTPOINT_ALREADY_SET\000DUPLICATE_ZONE_ID\000ERROR_CONVERTING_ZONE\000ERROR_CREATING_EXTENSION\000ERROR_IN_EXTENSION\000EXPECTED_A_SECTION_NAME\000EXTENSION_EXISTS\000EXTENSION_NAME_ERROR\000EXTENSION_NOT_FOUND\000EXTENSION_SETTING_NOT_SUPPORTED\000EXTENSION_VALUE_ERROR\000ILLEGAL_EMPTY_EXTENSION\000ILLEGAL_HEX_DIGIT\000INCORRECT_POLICY_SYNTAX_TAG\000INVALID_BOOLEAN_STRING\000INVALID_EXTENSION_STRING\000INVALID_MULTIPLE_RDNS\000INVALID_NAME\000INVALID_NULL_ARGUMENT\000INVALID_NULL_NAME\000INVALID_NULL_VALUE\000INVALID_NUMBERS\000INVALID_OBJECT_IDENTIFIER\000INVALID_OPTION\000INVALID_POLICY_IDENTIFIER\000INVALID_PROXY_POLICY_SETTING\000INVALID_PURPOSE\000INVALID_SECTION\000INVALID_SYNTAX\000INVALID_VALUE\000ISSUER_DECODE_ERROR\000NEED_ORGANIZATION_AND_NUMBERS\000NO_CONFIG_DATABASE\000NO_ISSUER_CERTIFICATE\000NO_ISSUER_DETAILS\000NO_POLICY_IDENTIFIER\000NO_PROXY_CERT_POLICY_LANGUAGE_DEFINED\000NO_PUBLIC_KEY\000NO_SUBJECT_DETAILS\000ODD_NUMBER_OF_DIGITS\000OPERATION_NOT_DEFINED\000OTHERNAME_ERROR\000POLICY_LANGUAGE_ALREADY_DEFINED\000POLICY_PATH_LENGTH\000POLICY_PATH_LENGTH_ALREADY_DEFINED\000POLICY_WHEN_PROXY_LANGUAGE_REQUIRES_NO_POLICY\000SECTION_NOT_FOUND\000TRAILING_DATA_IN_EXTENSION\000UNABLE_TO_GET_ISSUER_DETAILS\000UNABLE_TO_GET_ISSUER_KEYID\000UNKNOWN_BIT_STRING_ARGUMENT\000UNKNOWN_EXTENSION\000UNKNOWN_EXTENSION_NAME\000UNKNOWN_OPTION\000UNSUPPORTED_OPTION\000USER_TOO_LONG\000"
	.size	kOpenSSLReasonStringData, 15118

	.type	.L.str.8,@object                # @.str.8
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.8:
	.asciz	"src/boringssl/crypto/mem.c"
	.size	.L.str.8, 27

	.type	k25519Precomp,@object           # @k25519Precomp
	.section	.secsep.public.ro,"a",@progbits
	.globl	k25519Precomp
	.p2align	4, 0x0
k25519Precomp:
	.ascii	"\205;\214\365\306\223\274/\031\016\214\373\306-\223\317\302B=d\230H\013'e\272\3243:\235\317\007"
	.ascii	">\221@\327\0059\020\235\263\276@\321\005\2379\375\t\212\217h4\204\301\245g\022\370\230\222/\375D"
	.ascii	"h\252z\207\005\022\311\253\236\304\252\314#\350\331&\214YC\335\313}\033Z\250e\f\237h{\021o"
	.ascii	"\327q<\223\374\347$\222\265\365\017z\226\235F\237\002\007\326\341e\232\246Z..}\250?\006\fY"
	.ascii	"\250\325\264B`\245\231\212\366\254`N\f\201+\217\2527n\261k#\236\340U%\311i\246\225\265k"
	.ascii	"_z\233\245\263\250\372Cx\317\232]\335k\30161j=\013\204\240\017Ps\013\245>\261\365\032p"
	.ascii	"0\227\356L\250\260%\257\212K\206\3500\204Z\0022g\001\237\002P\033\301\364\370\200\232\033N\026z"
	.ascii	"e\322\374\244\350\037aV}\272\301\345\375S\323;\275\326K!\032\3631\201b\332[U\207\025\271*"
	.ascii	"\211\330\320\r?\223\256\024b\3325\034\"#\224XL\333\362\214E\345p\321\306\264\271\022\257&(Z"
	.ascii	"\237\t\374\216\271Qs(8%\375}\364\306ege\222\n\373=\2154\312'\207\345!\003\221\016h"
	.ascii	"\277\030h\005\n\005\376\225\251\372`Vq\211~2sP\240\006\315\343\350\303\232\244EtL?\223'"
	.ascii	"\t\377v\304\351\373\023Zr\301\\{E9\236n\224D+\020\371\334\333]+>Uc\277\f\235\177"
	.ascii	"3\273\245\bD\274\022\242\002\355^\307\303HP\215D\354\277Z\f\353\033\335\353\006\342F\361\314E)"
	.ascii	"\272\326G\244\303\202\221\177\267)'K\321\024\000\325\207\240d\270\034\361<\343\363U\033\353s~J\025"
	.ascii	"\205\202*\201\361\333\273\274\374\321\275\320\007\b\016'-\247\275\033\013g\033\264\232\266;ki\276\252C"
	.ascii	"1q\025w\353\356\f:\210\257\310\000\211\025'\2336\247Y\332h\266e\200\2758\314\242\266{\345Q"
	.ascii	"\244\214}{\266\006\230I9'\322'\204\342[W\271SE \347\\\b\273\204xA\256AL\2668"
	.ascii	"qK\352\002g2\254\205\001\273\241A\003\340p\276D\301;\bK\242\344S\343a\r\237\032\351\270\020"
	.ascii	"\277\243N\224\320\\\032k\322\300\235\263:5ptI.T(\202R\262q~\222<(i\352\033F"
	.ascii	"\261!2\252\232,o\272\247#\272;S!\240l:,\031\222Ov\352\235\340\027S.]\335n\035"
	.ascii	"\242\263\270\001\310m\203\361\232\244>\005G_\003\263\363\255wX\272A\234R\247\220\017j\034\273\237z"
	.ascii	"\217>\335\004fY\267Y,p\210\342w\003\263l#\303\331^f\2343\261/\345\274a`\347\025\t"
	.ascii	"\3314\222\363\355]\247\342\371X\265\341\200v=\226\373#<n\254A',\303\001\0162\241$\220:"
	.ascii	"\032\221\242\311\331\365\301\347\327\247\314\213xq\243\2702*\266\016\031\022dc\225N\314.\\|\220&"
	.ascii	"\035\234/c\016\335\314.\0251\211v\226\266\320QXzc\250k\267\337R9\357\016\240I}\323m"
	.ascii	"^Q\252ITc[\355:\202\306\013\237\304e\250\304\321B[\351\037\f\205\271\025\323\003om\3270"
	.ascii	"\307\344\006!\027DDli\177\215\222\200\326S\373&?Mi\244\236s\264\260K\206.\021\227\306\020"
	.ascii	"\005\310X\203\240*\246\fGB z\343J=j\334\355\021;\246\323dt\357\006\bU\257\233\277\003"
	.ascii	"\336_\276}'\304\223d\242~\255\031\255O]&\220E0F\310\337\000\016\t\376f\355\253\034\346%"
	.ascii	"\004fX\314(\341\023?~tY\264\354sXo\365h\022\314\355=\266\240,\342\206EcxmV"
	.ascii	"\320/Z\306\205B\005\241\303g\026\363*\021dlX\356\032s@\342\nh*\262\223G\363\245\373\024"
	.ascii	"4\b\301\234\237\2447\026Q\304\233\250\325V\216\274\333\322\177\177\017\354\265\034\3315\314^\312[\2273"
	.ascii	"\324\367\205i\026F\327<W\000\310\311\204^>Y\036\023a{\266\362\303/lR\374\203\352\234\202\024"
	.ascii	"\270\354qN/\013\347!\343w\244@\271\335V\346\200O\035\316\316Ve\277~{]S\304;\374\005"
	.ascii	"\302\225\335\227\204{C\377\247\265N\2520Ntl\213\350\205<a]\f\236s\201u_\036\307\331/"
	.ascii	"\335\336\257R\256\263\270$\3170;\355\214c\2254\225\201\276\251\203\274\2443\004\037e\\Gg77"
	.ascii	"\220e$\024\313\225@c5U\301\026@\024\022\357`\274\020\211\f\0248\236\214|\2200W\220\365k"
	.ascii	"\331\255\321@\375\231\272/'\320\364\226o\026\007\263\256;\360\025R\360cC\231\371\030;l\245\276\037"
	.ascii	"\212[A\341\361x\247\017~\247\303\272\367\237@\006P\232\242\232\270\327RoVZcz\366\034R\002"
	.asciz	"\344^/w g\024\261\316\232\007\226\261\224\370\350J\202\254\000M\"\370J\304l\315\367\331S\027"
	.ascii	"\224R\235\n\013\356?QfZ\337\017\\\347\230\217\316\007\341\277\210\206a\324\355,8q~\n\240?"
	.ascii	"4\333=\226-#i<X8\227\264\332\207\336\035\205\362\221\240\371\321\327\252\266\355H\240/\376\265\022"
	.ascii	"\222\036o\255&|+\337\023\211KP#\323fK\303\213\034u\300\235@\214\270\307\226\007\302\223~o"
	.ascii	"M\343\374\226\304\373\360q\355[\363\255k\202\271sa\305(\377ar\004\322o \261o\371v\233t"
	.ascii	"\005\256\246\256\004\366Z\037\231\234\344\276\361Q#\301fk\377\356\265\b\250aQ!\340\001\017\301\316\017"
	.ascii	"EN$\304\235\322\362=\n\336\330\223t\016\002+M!\f\202~\006\310l\n\271\352o\026y7A"
	.ascii	"D\036\376I\246XMd~w\2551\242\256\374!\322\320\177\210Z\034D\002\363\021\305\203q\252\001I"
	.ascii	"\360\370\032\214T\267\261\b\264\231b$|z\017\3169\331\006\036\371\260`\367\023\022mr{\210\273A"
	.ascii	"\256\221f|YL#~\310\264\205\n=\235\210d\347\372J5\f\311\342\332\035\236j\f\007\036\207\n"
	.ascii	"\276FCtD}\350@%+\265\025\324\332H\035>`;\241\030\212:|\367\275\315/\301(\267N"
	.ascii	"\211\211\274K\231\265\0013`B\335[:\256ks<\236\325\031\342\255a\rd\324\205&\0170\347>"
	.ascii	"\030u\036\204Gy\372C\327F\234cY\372\306\345t+\005\343\035^\006\2410\220\270\317\242\306G}"
	.ascii	"\267\326}\236\344U\322\365\254\036\013a\\\021\026\200\312\207\341\222]\227\231<\302%\221\227bW\201\023"
	.ascii	"\340\326\360\216\024\320\332?<oT\221\232t>\235W\201\273&\020b\354q\200\354\3114\215\365\214\024"
	.ascii	"mu\344\232}/W\342\177H\363\210\273E\303V\215\250`im\013\321\237\271\241\256N\255\353\217'"
	.ascii	"'\3604y\366\222\244F\251\n\204\366\276\204\231FT\030a\211*\274\241\\\324\273]\275\036\372\362?"
	.ascii	"f9\223\214\037h\252\261\230\f) \234\224!\214R<\235!\221R\0219{g\234\376\002\335\004A"
	.ascii	"\270j\t\333\006N!\2015O\344\f\311\266\250!\365*\236@*\301$e\201\244\374\216\244\265e\001"
	.ascii	"*B$\021^\277\262r\265:\243\2303\f\372\241f\266R\372\001a\313\224\325S\257\257\000;\206,"
	.ascii	"vj\204\240t\244\220\361\300|/\315\204\371\357\022\217+\252X\006)^i\270\310\376\277\331g\033Y"
	.ascii	"]\265\030\237q\263\271\231\036d\214\241\372\345e\344\355\005\237\3026\021\ba\213\0220p\206O\233H"
	.ascii	"\372\233\264\200\034\r/1\212\354\363\253^QyY\210\034\360\236\3003pr\313{\217\312\307.\340="
	.ascii	"\357\222\353:-\0202\322a\250\026a\264Sb\341$\252\013\031\347\253~=\277\276lI\272\373\365I"
	.ascii	".W\234\036\214b]\025AG\210\305\254\206M\212\353cWQ\366R\243\221[Qg\210\302\246\241\006"
	.ascii	"\324\317[\212\020\232\2240\353sd\274p\335@\334\034\r|0\301\224\302\222tn\372\313m\250\004V"
	.ascii	"\266d\027|\324\321\210rQ\213A\340@\021Tr\321\366\254\030`\032\003\237\306B'\376\211\236\230 "
	.ascii	".\354\352\205\213't\026\337+\313z\007\334!VZ\364\313a\026L\nd\323\225\005\367P\231\013s"
	.ascii	"\177\314-:\375w\227I\222\330O\245,|\2052\240\343\007\322d\330y\242)~\246\f\035\355\003\004"
	.ascii	"R\305N\2075-K\311\215o$\230\317\310\346\305\3165\300\026\372F\313\367\314=0\bCE\327["
	.ascii	"*y\347\025!\223\304\205\311\335\315\275\242\211L\306b\327\243\255\250=\036\235,\370g0\022\333\267["
	.ascii	"\302L\262(\225\321\232\177\201\3015ceTk\1776r\300On\266\270f\203\255\200s\000x:\023"
	.ascii	"\276b\312\306g\364a\t\356R\031!\326!\354\004pG\325\233w`#\030\322\340\360Xm\312\rt"
	.ascii	"<Cx\004W\214\032#\235C\201\302\016'\265\267\237\007\331\343\352\231\252\333\331\003+l%\365\003,"
	.ascii	"N\316\317R\007\356H\337\267\b\354\006\363\372\377\303\304YT\271*\013q\005\215\243>\226\372%\035\026"
	.ascii	"}\244S{u\030\017yyX\f\3170\001{0\371\367~%w=\2201\257\273\226\275\275h\224i"
	.ascii	"H\031\251j\346=\335\330\314\322\300/\302dPH/\352\3754f$H\233:.JlN\034>)"
	.ascii	"\317\376\332\364F/\037\275\367\326\177\244\024\001\357|\177\263GJ\332\375\037\323\205W\220s\244\031RR"
	.ascii	"\341\022Q\222K\023n7\240]\241\334\265x7p\0211\034F\257\211E\260#(\003\177D\\`["
	.ascii	"L\360\347\360\306\376\351;bI\343u\236Wj\206\032\346\035\036\026\357BU\325\275Z\314\364\376\022/"
	.ascii	"\211|\304 Y\200e\271\314\217;\222\f\020\360\347w\357\342\002e%\001\000\356\263\256\250\316m\247$"
	.ascii	"@\307\300\337\262\"E\n\007\244\311@\177n\320\020h\366\317xA\024\317\306\2207\244\030%{`^"
	.ascii	"\024\317\226\245\034C,\240\000\344\323\256@-\304\343\333&\017.\200&E\322hpE\236\0233\037 "
	.ascii	"\030\030\337l\217\035\263X\242Xb\303O\247\3175n\035\346fO\377\263\341\367\325\315l\253\254gP"
	.ascii	"Q\235\003\bk\177R\375\006\000|\001dI\261\030\250\244%.\260\016\"\325u\003Fb\210\272|9"
	.ascii	"\347y\023\310\373\303\025x\361*\341\335 \224a\246\325\375\250\205\370\300\251\377R\302\341\301\"@\033w"
	.ascii	"\262YY\360\2230\3010vy\251\351\215\241:\342&^\035r\221\324/\":lnv \3239#"
	.ascii	"\247/:Q\206\331}\330\b\317\324\371q\233\254\365\263\203\242\036\033\303k\320v\032\227\031\222\030\0323"
	.ascii	"\257ru\235:/Q&\236J\007h\210\342\313[\304\367\200\021\301\301\355\204{\246I\366\237a\311\032"
	.ascii	"\306\200O\373Eo\026\365\317u\307a\336\3076\234\034\331A\220\033\350\324\343!\376\275\203k|\0261"
	.ascii	"h\020KRB8+\362\207\351\234\356;4hP\310PbJ\204q\235\374\021\261\b\03746$a"
	.ascii	"8&-\032\343Ic\2135\375\323\233\000\267\337\235\244k\240\243\270\361\213\177E\004\331x1\252\"\025"
	.ascii	"\215\211N\207\333A\235\331 \334\007l\361\245\376\t\274\233\017\320g,=y@\377^\2360\342\353F"
	.ascii	"8IaiS/8,\020m-\267\232@\376\332'\362F\266\2213\310\350l0$\005\365p\376E"
	.ascii	"\221\024\225\310 I\362b\242\fc?\310\007\360\005\270\324\311\365\322E\273oE\"z\265m\237a\026"
	.ascii	"\214\013\f\226\246uH\332 /\016\357v\320h[\324\217\013=\317Q\373\007\324\222\343\240#\026\215B"
	.ascii	"\375\b\243\001DJO\b\254\312\245v\303\031\"\250}\274\321CF\336\270\336\3068\275`-Y\201\035"
	.ascii	"\350\305\205{\237\266e\207\262\272h\321\213g\360o\233\0173\035|\347p:|\216\257\260Qm_:"
	.ascii	"_\254\r\246V\2076aW\334\253\353j/\340\027}\017\316L-?\031\177\360\334\354\211wJ# "
	.ascii	"R\262xq\266\r\322v`\321\036\325\3714\034\007p\021\344\263 J*\366f\343\377<5\202\326|"
	.ascii	"\363\364\254h`\315e\246\323\343\327<\030-\331B\331%`3\2358YW\377\330,+;%\360>"
	.ascii	"\266\372\207\330[\244\341\013n;@\2722j\204*\000`n\351\022\020\222\331C\t\334;\206\3108("
	.ascii	"0PFJ\317\260k\321\253w\305\025AkI\372\235A\253\364\212\256\317\202\022(\250\006\246\270\334!"
	.ascii	"\2721w\276\372\000\215\232\211\030\236b~`\003\202\177\331\363C7\002\314\262\213gol\277\r\204]"
	.ascii	"\310\237\235\214F\004`\\\313\243*\324n\t@%\234/\356\022LM[\022\253\035\243\224\201\320\303\013"
	.ascii	"\213\341\2370\r8np\307e\341\271\246-\260n\253 \256}\231\272\273W\335\226\301*#vB:"
	.ascii	"\313~D\333r\301\370;\275-(\306\037\304\317_\376\025\252u\300\377\254\200\371\251\341$\350\311p\007"
	.ascii	"\372\204p\212,CBKE\345\271\337\343\031\212\211]\344X\234!\000\237\276\321\353m\241\316w\361\037"
	.ascii	"\375\265\265E\232\331a\317$y:\033\351\204\t\206\211>>0\031\t0\347\036\013PA\375d\3629"
	.ascii	"\341{\t\376\253J\233\321)\031\340\337\341\374m\244\377\361\246,\224\b\311\303N\3615,'!\306e"
	.ascii	"\234\342\347\333\0274\255\247\234\023\234+j7\224\275\251{Y\223\216\033\351\240@\230\210h4\327\022\027"
	.ascii	"\335\2231\316\370\211+\347\273\300%\241V3\020M\203\376\034.=\251\031\004r\342\234\261\n\200\371\""
	.ascii	"\254\375n\232\335\237\002BAI\2454\276\316\022\271{\363\275\207\271d\017d\264\312\230\205\323\244qA"
	.ascii	"\313\370\236>\2126Z`\025GP\245\"\300\351\343\217$$_\260H=U\345&vd\315\026\364\023"
	.ascii	"\214L\311\231\252X'\372\007\270\000\260oo\000#\222S\332\255\335\221\322\373\253\321KW\372\024\202P"
	.ascii	"\326\003\320S\273\025\032Fe\311\363\274\210(\020\262Z:hluv\305'G\264l\310\244Xw:"
	.ascii	"K\376\326>\025i\002\302\304w\035Q9gZ\246\224\257\024,F&\336\313K\247\253o\354`\371\""
	.ascii	"vP\256\223\366\021\201T\246T\375\035\337!\256\035e^\021\363\220\214$\022\224\364\347\215_\321\237]"
	.ascii	"\036R\327\356*M$?\025\226.C(\220:\216\324\026\234.w\272d\341\330\230\353G\372\207\301;"
	.ascii	"\177rcm\323\b\024\0033\265\307\327\357\2327jK\342\256\314\305\217\341\251\323\276\217O\2215/3"
	.ascii	"\f\302\206\352\025\001Gm%\321Fl\313\267\212\231\210\001f:\2652x\327\003\272o\220\316\201\rE"
	.ascii	"?t\256\034\226\330t\320\355c\034\356\365\030m\370)\355\364\347[\305\275\227\b\261:fy\322\272L"
	.ascii	"uR \246\241\266{n\203\216<A\327!O\252\262\\\217\350U\321Vo\341[4\246K]\342-"
	.ascii	"\315\037\327\240$\220\321\200\370\212(\373\n\302%\305\031d:_K\227\243\2613r\000\342\357\274\177}"
	.ascii	"\224\220\302\363\305]|\315\253\005\221*\232\242\201\307X0\034B6\035\306\200\327\324\330\334\226\321\234O"
	.ascii	"\001(k&j\036\357\372\026\237s\325\304hl\206,v\003\033\274/\212\366\215Z\267\207^CuY"
	.ascii	"h7{j\330\227\222\031cz\321\032$X\320\320\027\f\034\\\255\234\002\272\007\003z8\204\320\315|"
	.ascii	"\223\314`g\030\204\f\233\231*\263\032z\000\256\315\030\332\013b\206\354\215\250D\312\220\201\204\312\2235"
	.ascii	"\027\004&m,B\246\334\275@\202\224P=\025\256w\306h\373\264\301\300\251S\317\320a\355\320\213B"
	.ascii	"\247\232\204^\232\030\023\222\315\372\330e5\303\330\324\321\273\375S[TR\214\346c-\332\b\2039'"
	.ascii	"S$p\nL\016\241\271\336\033}\325fX\242\017\367\332'\315\265\331\271\377\3753,IE),W"
	.ascii	"\023\324^C(\215\303B\311\314x2`\363P\275\357\003\332y\032\253\007\273U3\214\276\256\227\225&"
	.ascii	"\2760\315\326E\307\177\307\373\256\272\343\323\350\337\344\f\332]\2520\210,\242\200\312[\300\230T\230\177"
	.ascii	"cc\277\017R\025V\323\246\373M\317EZ\004\b\302\240?\207\274O\302\356\347\022\233\326<e\3620"
	.ascii	"\027\341\013\237\210\316I8\210\242T{\033\255\005\200\034\222\374#\237\303\243=\004\3631\nG\354\302v"
	.ascii	"\205\f\301\2528\311\b\212\313k'\333`\233\027Fp\254o\016\036\300 \251\332sdY\361s\022/"
	.ascii	"\300\013\247U\327\213H0\347B\324\361\244\265\326\006baY\274\236\246\321\352\204\367\305\355\227\031\2548"
	.ascii	"\021\036\340\212|\3749G\237\253jJ\220tR\375.\217r\207\202\212\331A\362i[\330*W\236]"
	.ascii	";\261Q\247\027\265f\006\214\205\233~\206\006}tI\336ME\021\300\254\254\234\346\351\277\234\315\337\""
	.ascii	"\241\340;\020\264Y\354Vi\371Y\322\354\272\343.2\315\365\023\224\262|yr\344\315$x\207\351\017"
	.ascii	"\331\f\r\303\340\322\333\2153C\273\254_f\216\255\037\226*2\214%k\217\307\301HT\300\026)k"
	.ascii	";\221\272\n\3214\333~\016\254m.\202\315\243N\025\370xe\377=\bf\027\n\360\1770?0L"
	.ascii	"\000E\331\rX\003\374)\223\354\273o\244z\322\354\370\247\342\302_\025\n\023\325\241\006\267\032\025kA"
	.ascii	"\205\214\262\027\326;\n\323\352;w9\267w\323\305\277\\j\036\214\347\306\306\304\267*\213\367\270a\r"
	.ascii	"\2606\301\351\357\327\250V K\344X\315\345\007\275\253\340W\033\332/\346\257\322\350wB\367*\032\031"
	.ascii	"\373\016FOC+\346\237\326\0076\246\324\003\323\336$\332\240\267\016!R\360\223[T\000\276}~#"
	.ascii	"1\024<\305K\367\026\316\336\355r \316%\227+\347>\262\265o\303\271\270\b\311\\\013E\016.~"
	.ascii	"0\264\001g\355u5\001\020\375\013\237\346\224\020#\"\177\344\203\025\0172u\343U\021\261\231\246\257q"
	.asciz	"\326P;G\034<B\352\020\3578;\037z\350Q\225\276\311\262_\277\204\233\034\232\370x\274\037s"
	.ascii	"\035\266S9\233o\316e\346A\241\257\3529X\306\376Y\367\251\375_C\017\216\302\261\302\351B\021\002"
	.ascii	"\200\030\370H\030\3070\344\031\301\316^\"\f\226\277\343\025\272k\203\340\332\266\bX\341G3oML"
	.ascii	"p\031\217\230\374\335\f/\033\365\271\260'b\221k\276v\221w\304\266\307n\250\237\217\250\000\225\2778"
	.ascii	"\311\037}\301\317\354\367\030\024<@Q\246\365ul\337\f\356\367+q\336\333\"z\344\247\252\335?\031"
	.ascii	"o\207\3507<\311\322\037,F\321\030Z\036\366\242v\022$9\202\365\200PiI\r\277\236\271oj"
	.ascii	"\306#\344\266\265\"\261\356\216\377\206\362\020p\235\223\214]\317\035\203*\251\220\020\353\305B\237\332o\023"
	.ascii	"\353U\bV\273\301Fj\235\360\223\3708\273\026$\301\254q\2177\021\035\327\352\226\030\243\024i\367u"
	.ascii	"\321\275\005\243\261\337L\371\b,\370\237\235K6\017\212X\273\303\245\330\207*\272\334\350\013Q\203!\002"
	.ascii	"\177z0C\001qZ\235_\244}\304\236\336c\260\323z\222\276R\376\273\"lB@\375A\304\207\023"
	.ascii	"\024-\255^8f\367J0X|\312\200\330\216\240=\036!\020\346\246\023\r\003l\200{\341\034\007j"
	.ascii	"\370\212\227\207\321\303\323\265\023D\016\177=Z+r\240|G\273HH{\r\222\334\036\257j\262q1"
	.ascii	"\321G\212\262\330\267\r\246\361\244p\027\326\024\277\246X\275\335S\223\370\241\324\351CB4cJQl"
	.ascii	"\250LV\227\2201/\251\031\341u\"L\270{\377PQ\207\2447\376UOZ\203\360<\207\324\037\""
	.ascii	"Ac\025:O \"#-\003\n\272\351\340s\373\016\003\017AL\335\340\374\252J\222\373\226\245\332H"
	.ascii	"\223\227L\310]\035\366\024\006\202A\357\343\371A\231\254wb4\217\270\365\315\251y\212\016\3727\310X"
	.ascii	"\307\234\245\\f\216\312n\240\2548.K%G\250\316\027\036\322\b\307\2571\367J\330\312\374\326mg"
	.ascii	"X\220\374\226\205h\371\f\033\240V{\363\273\334\035j\3265I}\347\302\334\n\177\245\306\362sO\034"
	.ascii	"\2044|\374npn\263a\317\301\303\264\311\337s\345\307\034x\311y\035\353\\g\257}\333\232Ep"
	.ascii	"\273\240_0\275Oz\016\255c\306T\340L\235\202H8\343/\203\303!\364BL\366\033\r\310Zy"
	.ascii	"\263+\264\221I\333\221\033\312\334\002K#\226&W\334x\214\037\345\236\337\237\323\037\342\214\204b\341_"
	.ascii	"\b\262|]-\205y(\347\362}hp\335\336\270\221xh!\253\377\013\3345\252}gC\300D+"
	.ascii	"\032\226\224\341O!YNO\315q\r\307}\276I-\362P;\322\317\000\2232r\221\374F\324\211G"
	.ascii	"\216\267N\007\253\207\034\032g\364\332\231\216\321\306\372g\220OH\315\273\254>\344\244\271+\357.\305`"
	.ascii	"\021m\256|\302\305+p\253\214\244T\233i\307D\262.I\272V@\274\357mg\266\331Hr\327p"
	.ascii	"\361\213\375;\274\211]\013\032U\363\3117\222k\260\365(0\325\260\026L\016\253\312\317,1\234\274\020"
	.ascii	"[\240\302>K\350\212\252\340\201\027\355\364\236i\230\321\205\216p\344\023Ey\023\364v\251\323[uc"
	.ascii	"\267\254\361\227\030\020\307=\330\273e\301^}\332]\017\002\241\017\234[\216PV*\3057\027uc'"
	.ascii	"S\b\321*>\240_\265i5\346\236\220uo5\220\270i\276\375\361\371\237\204o\301\213\304\301\214\r"
	.ascii	"\251\031\264n\323\002\224\002\245`\264w~N\264\360VI<\3240b\250\317\347f\321z\212\335\302p"
	.ascii	"\023~\355\270}\226\324\221z\201v\327\n/%td%\205\r\340\202\t\344\345<\245\0268a\2702"
	.ascii	"\016\354o\237P\224ae\215Q\306F\251~.\356\\\233\340g\363\3013\227\225\204\224cc\254\017."
	.ascii	"d\315H\344\276\367\347y\320\206x\bg:\310j.\333\344\240\331\324\237\370AOZs\\!yA"
	.ascii	"4\315k(\2713\256\344\334\326\235U\266~\357\267\037\216\323\263\037\024\213'\206\302A\"f\205\3721"
	.ascii	"*\355\334\327\347\224p\214p\234\323G\303\212\373\227\002\331\006\2513\340;\341v\235\331\f\243D\003p"
	.ascii	"\364\"6.Bl\202\257-P3\230\207) \301#\2218+\341\267\301\233\211$\225\251\022#\273$"
	.ascii	"k\\\370\365*\f\370A\224g\372\004\303\204rh\255\033\272\243\231\337E\211\026]\353\377\371*\035\r"
	.ascii	"\303g\3362\027\355\250\261HI\033F\030\224\264<\322\274\317vCC\275\216\b\200\030\036\207>\356\017"
	.ascii	"\337\036b2\241\212\332\251ye\"Y\241\"\2700\223\301\232\247{\031\004@v\035S\030\227\327\254\026"
	.ascii	"\255\266\207x\305\306Y\311\272\376\220_\255\236\341\224\004\365B\243bN\342\026\000\027\026\030K\323N\026"
	.ascii	"=\035\233-\257r\337rZ$2\2446*Fc7\226\263\026y\240\316>\t#0\271\366\016>\022"
	.ascii	"\232\346/\031L\331~H\023\025\221:\352,\256a'\336\244\271\323\366{\207\353\363s\020\306\017\332x"
	.ascii	"\224:\fh\361\200\237\242\346\347\351\032\025~\367qsy\001HX\361\000\021\335\215\263\026\263\244J\005"
	.ascii	"j\306+\345(]\361[\216\032\360p\030\343G,\335\213\302\006\274\257\031$:\027k%\353\336%-"
	.ascii	"\270|&\031\215F\310\337\257M\345f\234x(\013\027\354nf*\035\353*`\247}\253\246\020F\023"
	.ascii	"\025\365\321w\347e*\315\361`\252\217\207\221\211T\345\006\274\332\274;\267\261\373\311|\251\313xHe"
	.ascii	"\376\260\366\215\307\216\023Q\033\365u\345\211\332\227S\271\361zq\035z \tP\326 +\272\375\002!"
	.ascii	"\241\346\\\005\005\344\236\226)\255Q\022h\247\2746\025\244}\252\027\365\032:\272\262\354)\333%\327\n"
	.ascii	"\205o\005\233\f\274\307\376\327\377\365\347hR}S\372\256\022Cb\306\257w\331\2379\002S_gO"
	.ascii	"W$N\203\261gB\334\305\033\316p\265Du\266\327^\321\367\013z\360\032P6\240q\373\317\357J"
	.ascii	"\036\027\025\00466-\303;H\230\211\021\357+\315\020Q\224\320\255n\n\207ae\250\242r\273\314\013"
	.ascii	"\226\022\376PL^m\030~\237\350\376\202{9\340\2601pP\305\366\307;\3027\217\020i\375xf"
	.ascii	"\310\251\261\352/\226^\030\315}\024e5\346\347\206\362m[\2731\340\222\260>\267\326Y\253\360$@"
	.ascii	"\302chc1\372\206\025\3623-WH\214\366\007\374\256\236x\237\314sO\001G\255\216\020\342B-"
	.ascii	"\223uS\017\r{q!L\006\036\023\013iN\221\237\340*u\256\207\266\033n<B\233\247\363\013B"
	.ascii	"\233\322\337\224\025\023\365\227jL?1]\230Ua\020PE\b\007?\241\353\"\323\322\270\b&kg"
	.ascii	"G+[\034e\2728\201\200\033\0331\354\266q\206\26051\274\261\f\377{\340\361\f\234\372/]t"
	.ascii	"jN\323!W\3376`\320\263{\231'\210\333\261\372ju\310\303\t\302\3239\310\035L\345[\341\006"
	.ascii	"\275\310\311+\036ZR\277\201\235G&\b&[\352\333U\001\337\016\307\021\325\320\365\f\226\353<\342\032"
	.ascii	"J\2312\031\207]r[\260\332\261\316\265\03452\005\312\267\332I\025\304}\367\301\216'a\330\336X"
	.ascii	"\250\311\302\266\250[\373-\214Y,\365\216\357\356Hs\025-\361\007\221\2003\330[\035Ski\272\b"
	.ascii	"\\\305f\362\2237\027\330INE\314\305v\311\310\250\303&\274\370\202\343\\\371\366\205T\350\235\363/"
	.ascii	"z\305\357\303\356>\355w\021H\377\324\027U\340\004\313q\246\361?z=\352T\376|\224\2643\006\022"
	.ascii	"\n\020\022IG1\275\202\006\276o~m{#\336\306y\352\021\031v\036\341\336;9\313\343;C\007"
	.ascii	"B\000a\221x\230\224\013\350\372\353\354<\261\347N\300\244\360\224\225s\276p\205\221\325\264\231\n\3235"
	.ascii	"\364\227\351\\\300Dy\377\243Q\\\260\344=]W|\204vZ\375\2013X\237\332\366z\336>\207-"
	.ascii	"\201\371]N\341\002b\252\365\341\025P\027Y\r\242l\035\342\272\323u\242\030S\002`\001\212aC\005"
	.ascii	"\t47Cd1z\025\331\201\252\364\356\267\270\372\006H\246\365\346\376\223\260\266\247\177pT6w."
	.ascii	"\301#L\227\364\275\352\r\223F\316\235%\no\252,\272\232\242\270, \004\r\226\007-6C\024K"
	.ascii	"\313\234R\034\351T|\226\3735\306d\222&\3660e\031\022x\364\257G'\\o\366\352\030\204\003\027"
	.ascii	"z\037n\266\307\267\304\314~/\f\365%~\025D\034\257>q\374m\360>\367c\332RgD/X"
	.ascii	"\344L2 \323{1\306\304\213H\244\350B\020\250d\023ZN\213\361\036\262\311\215\242\315K\034*\f"
	.ascii	"Ei\275iH\201\304\355\"\215\034\276}\220m\r\253\305\\\325\022\322;\306\203\334\024\2430\233jZ"
	.ascii	"G\004\037o\320\307M\322Y\300\207\333>\236&\262\217\322\262\373r\002[\321wH\366\306\321\213U|"
	.ascii	"=F\226\323$\025\354\320\360$Z\303\212b\273\022\244_\274\034y:\f\245\303\257\373\n\312\245\004\004"
	.ascii	"\321oA*\033\236\274b\213YP\343(\367\306\265gi]=\330?4\004\230\356\370\347\026uR9"
	.ascii	"\326C\247\n\007@\037\214\350^&[\313\320\272\314\336\322\217fk\004KW3\226\335\312\375[9F"
	.ascii	"\234\232]\032-\333\177\021*\\\000\321\274Ew\234\352o\325T\361\276\324\357\026\320\"\350)\232Wv"
	.ascii	"\3624\264R\023\265<3\341\200\336\223I(2\330\3165\ru\207(Q\265\301w'*\273\024\305\002"
	.ascii	"\027*\300I~\216\266E\177\243\251\274\242Q\315#\033L\"\354\021_\326>\261\275\005\236\334\204\243C"
	.ascii	"E\266\361\213\332\325KhSK\265\366~\323\213\373S\322\260\251\327\02691Y\200Ta\t\222`\021"
	.ascii	"\315M\2336\026V8zc5\\e\247,\300u!\200\361\324\371\033\302}B\340\346\221t}c/"
	.ascii	"\252\317\332)i\026M\264\217Y\023\204L\237R\332YU=E\312c\357\351\013\216i\305[\022\0365"
	.ascii	"\276{\366\032F\233\264\324a\211\253\310z\003\003\326\373\231\246\371\237\341\336q\232*\316\347\006-\030\177"
	.ascii	"\"u!\216rKE\t\330\270\204\324\364\350X\252<\220F\177M%X\323\027R\034$C\300\254D"
	.ascii	"\354h\001\253d\216|zC\305\355\025UJZ\313\332\016\315G\323\031U\t\260\223>4\214\254\324g"
	.ascii	"wWzO\273k}\034\341\023\203\221\324\3765\213\204Fk\311\306\241\334J\275q\255\022\203\034mU"
	.ascii	"!\350\033\261Vg\360\201\335\363\243\020#\370\257\017]F\231jU\320\262\370\005\177\214\3148\276z\t"
	.ascii	"\2029\215\f\343@\357\0274\372\243\025>\007\3671nds\007\313\363!O\377N\202\035mllt"
	.ascii	"\244-\245~\207\311I\fC\035\334\233UiCL\322\353\314\367\t8,\002\275\204\356K\243\024~W"
	.ascii	"+\327M\275\276\316\376\224\021\"\017\006\332Oj\364\377\321\310\300wYJ\022\225\222\000\373\270\004Sp"
	.ascii	"\n;\247a\254h\342\360\365\245\2217\020\372\372\362\351\000mk\202>\341\301B\217\327o\351~\372`"
	.ascii	"\306n)M5\035=\266\3301\255_>\005\303\363\354B\275\264\214\225\013g\375Sc\241\f\2169!"
	.ascii	"\001V\267\264\371\252\230'r\255\215\\\023r\254^#\240\267aa\252\316\322N}\217\351\204\262\277\033"
	.ascii	"\3633+8\212\005\365\211\264\300H\255\013\272\342Zn\263=\245\003\265\223\217\3462\242\225\235\355\243Z"
	.ascii	"ae\331\307\351wge6\200\307rT\022+\313\356nP\331\2312\005e\314W\211^N\341\007J"
	.ascii	"\233\244w\304\315X\013$\027\360Gd\336\3328\375\255j\310\2472\215\222\031\201\240\257\204\355z\257P"
	.ascii	"\231\371\r\230\313\022\344Nq\307n<o\327\025\243\375w\\\222\336\355\245\273\00241\0359\254\013?"
	.ascii	"\345[\366\025\001\336On\262\ta!!&\230)\331\326\255\013\201\005\002x\006\320\353\272\026\243!\031"
	.ascii	"\213\301\363\331\232\255Z\327\234\301\261`\357\016jV\331\016\\%\254\013\232>\365\307b\240\354\235\004{"
	.ascii	"\374p\270\337~/B\211\275\263vO\353k),\367M\3026\324\3618\007\260\256s\342A\337Xd"
	.ascii	"\203DD5z\343\313\334\223\276\355\0173y\210u\207\335\305\022\303\004`xd\016\225\302\313\334\223`"
	.ascii	"K\003\204`\276\356\336kT\270\017x\266\302\2311\225\006-\266\253v3\227\220}d\213\311\2001n"
	.ascii	"mp\340\205\205\232\363\03739\347\263\330\245\3206;E\217q\341\362\271C|\251'H\b\352\321W"
	.ascii	"q\260(\241\347\266z\356\252\213\250\223mY\301\2440a!\262\202\336\264\367\030\275\227\335\235\231>6"
	.ascii	"\306\256K\342\334H\030/`\257\274\272Ur\233v1\351\357<n<\313\220U\263\371\306\233\227\037#"
	.ascii	"\304\037\3565\301C\250\226\317\310\344\bU\263n\2270\323\214\265\001h/\264+\005:ix\233\356H"
	.ascii	"\306\363*\314K\3361\\\037\215 \3760\260K\260f\264O\301\tp\215\267\023$y\b\233\372\233\007"
	.ascii	"EB\325\242\200\355\311\363R9\366wx\213\240\nuT\b\321c\254m\327kcp\224\025\373\364\036"
	.ascii	"\364\r0\332Q:\220\343\260Z\251=#d9\204\200d5\013-\361<\355\224q\201\204\366w\214\003"
	.ascii	"\354{\026[\346^N\205\302\315\320\226B\nYY\231!\020\2304\337\262rV\377\013J*\351^W"
	.ascii	"\001\330\244\nE\274F]\330\2713\245'\022\257\303\302\006\211+&;\2368\033X/8~\036\n "
	.ascii	"\317/\030\212\220\200\300\324\275\235H\231\302p\3410\3363\367RW\275\272\005\000\375\323,\021\347\324C"
	.ascii	"\305:\371\352g\271\215Q\300Rf\005\233\230\274q\365\227qV\331\205+\3768N\036eR\312\016\005"
	.ascii	"\352h\346`v9\254\227\227\264:\025\376\273\031\233\237\247\3544\265y\261LW\2561\241\237\300Qa"
	.ascii	"\234\f?E\336\032C\303\233;p\377^\004\365\351={\204\355\311z\331\374\306\364X\034\302\346\016K"
	.ascii	"\226]\360\375\r\\\365:z\356\264*\340.&\335\t\027\027\022\207\273\262\021\013\003\017\200\372$\357\037"
	.ascii	"\206k\2270\365\257\322\"\004F\322\302\006\270\220\215\345\272\345Ml\211\241\334\027\f4\310\346_\000("
	.ascii	"\2261\247\032\373S\3267\030d\327?0\225\224\017\262\027:\373\t\013 \255>a\310/)IMT"
	.ascii	"\210\206R4\237\272\357j\241}\020%\224\377\033\\6K\331f\315\273[\367\372m1\017\223r\344r"
	.ascii	"'v*\3235\366\363\007\360fe_\206M\252zPD\320(\227\347\205<8d\340\017\000\177\356\037"
	.ascii	"O\b\201\227\214 \225&\341\016E#\013*P\261\002\336\357\003\246\256\235\375L\2433'\214.\235Z"
	.asciz	"\345\367\333\003\332\005Sv\275\3154\024I\362\332\244\354\210J\322\315\325J{C\005\004\356Q@\371"
	.ascii	"S\227\257\007\273\223\357\327\247f\267=\317\320>X\305\036\013n\277\230i\316R\004\324]\322\377\267G"
	.ascii	"\2620\323\303#k5\215\006\033G\260\233\213\034\362<\270Bnl1l\263\r\261\352\213~\234\327\007"
	.ascii	"\022\335\b\274\234\373\373\207\233\302\356\341:k\006\212\277\301\037\333+$W\r\266K\246^\243 5\034"
	.ascii	"Y\300k!@o\250\315~\330\274\022\035#\273\037\220\t\307\027\236j\225\264U.\321f;\fu8"
	.ascii	"J\243\313\274\246S\322\200\233!88\241\303a>\226\343\202\230\001\266\303\220o\346\016]w\005=\034"
	.ascii	"\032\345\"\224@\361.iq\366]+<\307\300\313)\340Lt\347O\001!|H0\323\307\342!\006"
	.ascii	"\363\360\333\260\226\027\256\267\226\341|\341\271\257\337T\264\243\252\351q0\222%\235.\000\241\234X\216]"
	.asciz	"\215\203Y\202\314`\230\257\334\232\237\306\301H\352\2200\036Xe7H&e\274\245\323{\t\326\007"
	.ascii	"K\251B\b\225\035\277\300>.\217Xc\303\323\262\357\342Q\2738\024\226\n\206\277\034<x\327\203\025"
	.ascii	"\307(\235\314\004G\003\220\217\305,\367\236g\033\035&\207[\276_+\341\026\nX\305\203N\006XI"
	.ascii	"\341z\242]\357\242\356\354t\001gU\024:|Yz\026\tf\022*\246\311p\217\355\201._*%"
	.ascii	"\r\350fP&\224(\rk\214|0\205\367\303\374\375\022\021\fx\332S\033\210\263C\330\013\027\234\007"
	.ascii	"V\320\325\300P\315\326\315;W\003\273mh\367\232H\357\303\363?r\246<\314\212{1\327\300hg"
	.ascii	"\377o\372d\344\354\006\005#\345\005b\036C\343\276B\352\270Q$By5\000\373\311J\343\005\354m"
	.ascii	"\263\301U\361\345%\266\224\221{{\231\247\363{A\000&km\334\275,\302\364R\315\335\024^DQ"
	.ascii	"U\244\276+\253G1\211)\221\007\222O\242S\214\247\3670\276H\371IK=\324On\b\220\351\022"
	.ascii	"QI\024;K+PW\263\274KDk\377g\216\333\205c\026'i\275\270\310\225\222\3431o\030\023"
	.ascii	".\273\337\177\263\226\f\361\371\352\034\022^\223\232\237?\230[:\3046\021\337\257\231>]\360\343\262w"
	.ascii	"\244\260\335\022\234c\230\325k\206$\3000\237\321\245`\344\374X\003/|\321\212^\t.\025\225\241\007"
	.ascii	"\336\304.\234\305\251o)\313\363\204O\277a\213\274\b\371\250\027\331\006w\034]%\323z\374\225\267c"
	.ascii	"\310_\2368\002\2176\250;\344\215\317\002;C\220C&A\305]\375\241\2577\001/\003=\350\217>"
	.ascii	"<\321\357\350\215Lp\b17\3403\216\032\305\337\343\315`\022\245]\235\245\206\214%\246\231\b\326\""
	.ascii	"\224\242p\005\271\025\213/IE\bgpB\362\224\204\375\273a\341Z\034\336\007@\254\177y;\272u"
	.ascii	"\226\321\315p\300\3339b\232\212}l\213\212\376``\022@\353\274G\210\263^\236w\207{\320\004\t"
	.ascii	"\271@\371Hf-2\3649\f-\275\f/\225\0061\371\201\240\255\227v\026l*\367\272\316\252@b"
	.ascii	"\234\221\272\335\324\037\316\264\252\215L\307>\3331\317Q\314\206\255c\314c,\007\336\035\274?\024\342C"
	.ascii	"\240\225\242[\234t4\370Z\3227\312[|\224\326j1\311\347\247;\361f\254\f\264\215#\257\275V"
	.ascii	"\262;\235\301l\323\020\023\271\206#b\267k*\006\\O\241\327\221\205\233|TW\036~P1\252\003"
	.ascii	"\35335\365\343\271*6@=\271n\325h\2053rUZ\035R\024\016\236\030\023t\203m\250$\035"
	.ascii	"\037\316\324\377Hv\354\364\034\214\254T\360\352E\340|5\t\035\202%\322\210YH\353\232\334a\262C"
	.ascii	"d\023\225l\213=Q\031{\364\013\000&q\376\224g\225O\325\335\020\215\002d\t\224B\342\325\264\002"
	.ascii	"\273y\273\210\031\036[\345\2355z\301}\320\236\2403\352=`\342.,\260\302k'[\317U`2"
	.ascii	"\362\215\321(\313U\241\264\b\345l\030FF\314\352\211C\202l\223\364\234\304\0204]\256\t\310\246'"
	.ascii	"Ti=\304\n',\315\262\312fjW>J\335l\003\327i$Y\372y\231%\214=`\003\025\""
	.ascii	"\210\261\r\037\315\353\246\213\350[Zg:\327\3237ZX\365\025\243\337.\362~\241`\377tq\266,"
	.ascii	"\320\341\0139\371\315\356Y\361\343\214rD B\251\364\360\224zf\034\211\2026\364\2208\267\364\035{"
	.ascii	"\214\365\370\007\030\"._\324\t\224\324\237\\U\3430\246\266\037\215\250\252\262=\340R\323E\202ih"
	.ascii	"$\242\262\263\340\362\222\344`\021U+\006\236l|\016{\177\r\342\217\353\025\222Y\374X&\357\374a"
	.ascii	"z\030\030*\205]\261\333\327\254\335\206\323\252\344\363\202\304\366\017\201\342\272D\317\001\257=GL\317F"
	.ascii	"@\201I\361\247n<!TH+9\370~\036|\272\316)V\214\303\210$\273\305\214\r\345\252e\020"
	.ascii	"\371\345\304\236\355%eB\0033\220\026\001\332^\016\334\312\345\313\362\247\261r@_\353\024\315{8)"
	.ascii	"W\r \337%E,\034Jg\312\277\326-;\\0@\203\341\261\347\007\n\026\347\034O\346\230\241i"
	.ascii	"\355\312\305\3344D\001\3413\373\204<\226]\355G\347\240\206\355v\225\001p\344\371g\322{i\262%"
	.ascii	"\274x\032\331\340\262b\220g\226P\310\234\210\311G\270pP@fJ\365\235\277\241\223$\251\346is"
	.ascii	"dh\230\023\373?g\235\270\307]A\331\373\245<^;'\337;\314N\340\322LN\265=h \024"
	.ascii	"\320Z\314\301o\273\3564\213\254F\226\351\f\033jS\336k\246I\332\260\323\301\201\320aA;\3501"
	.ascii	"\227\321\235$\036\275x\264\002\301X^\0005\fb\\\254\272\314/\323\002\373-\247\b\365\353;\266`"
	.ascii	"O+\006\236\022\307\350\227\330\n2)O\217\344I?h\030oK\341\354[\027\003U-\266\036\317U"
	.ascii	"R\214\365}\343\265v06\314\231\347\335\271:\327 \356\023I\343\034\203\2753\001\272b\252\373V\032"
	.ascii	"X=\302e\020\020yX\234\201\224Pm\b\235\213\247_\305\022\251/@\342\324\221\bWde\232f"
	.ascii	"\354\311\235\\Pk>\224\0327|\247\273W%0Qv4AV\256s\230\\\212\305\231g\203\304\023"
	.ascii	"\200\320\213]j\373\334\304BH\032W\354\304\353\336eS\345\270\203\350\262\324'\270\345\310}\310\275P"
	.ascii	"\271\341\263ZF]:Ba?\361\307\207\301\023\374\266\271\265\354d6\370\031\007\2667\246\223\f\370f"
	.ascii	"\021\341\337n\2037m`\331\253\021\360\025>52\226;\267%\303:\260d\256\325_rDd\325\035"
	.ascii	"\232\310\272\b\000\346\227\302\340\303\341\352\021\352L}|\227\347\237\341\213\343\363\315\005\243c\017E::"
	.ascii	"}\022b3\370\177\244\217\025|\315q\304j\237\274\213\f\"ICEqn.s\237!\022Yd\016"
	.ascii	"'F9\3301/\217\007\020\245\224\336\2031\2358\200o\231\027ml\343\321{\250\251\223\223\215\2141"
	.ascii	"\230\323\035\253)\236f];\236-4X\026\222\374\315sY\363\375\035\205U\366\n\225%\303A\232P"
	.ascii	"\031\376\377*\003]t\362f\333$\177I<\237\f\357\230\205\272\343\323\230\274\024S\035\232g|L\""
	.ascii	"\351%\371\246\334n\300\2753\037\033d\364\363>y\211>\203\235\200\022\354\202\211\023\241(#\360\277\005"
	.ascii	"\344\022\305\r\335\240\201h\376\372\245D\310\r\347O@RJ\217k\216t\037\352\243\001\356\315wbW"
	.ascii	"\013\340\312#p\02326Y\317\254\321\n\317JT\210\034\032\322I\020t\226\247D*\372\303\214\013x"
	.ascii	"_0O#\274\212\363\036\b\336\005\024\275\177W\232\r*\3464\024\245\202^\241\267qbr\030\364_"
	.ascii	"@\225\266\023\350G\333\345\341\020&C;*]\363v\022x8\351&\037\254i\313\240\240\214\333\324)"
	.ascii	"\235\333\211\027\f\b\2169\365x\347\363% `\247]\003\275\006L\211\230\372\276f\251%\334\003j\020"
	.ascii	"\320S33\257\n\255\331\345\t\323\254\245\235f8\360\367\210\310\212eW<\372\276,\005Q\212\263J"
	.ascii	"\234\300\335_\357\321\317\326\316]W\367\375>+\350\3024\026 ]k\325%\233+\355\004\273\306A0"
	.ascii	"\223\325hg%+|\332\023\312\"DW\300\301\230\035\316\n\312\325\013\250\361\220\246\210\300\255\321\315)"
	.ascii	"H\341V\331\371\362\362\017.k5\237u\227\347\255\\\002l_\273\230F\032{\232\004\024h\275K\020"
	.ascii	"c\361\177\326_\232]\251\201V\307L\235\346+\351W\362 \336L\002\370\267\365-\007\373 *O "
	.ascii	"g\355\361h1\375\360Q\302;o\330\315\035\201,\336\362\322\004C\\\334DIq*\tW\314\350["
	.ascii	"y\260\3530=;\024\3100.e\275Z\025\211u1\\m\2171<<e\037\026y\302\027\373p%"
	.ascii	"Z$\270\013U\251.\031\321P\220\217\250\373\346\3105\311\244\210-\352\206yh\206\001\336\221_\034$"
	.ascii	"u\025\266,\1776\372>l\002\326\034vo\371\365b%\265e*\024\307\350\315\n\003S\352e\313="
	.ascii	"\252l\336@)\027\330(:s\331\"\360,\277\217\321\001[#\335\374\327\026\345\360\315_\335\016B\b"
	.ascii	"\316\020\364\004N\303X\003\205\006n'Z[\023\266!\025\271\353\307p\226]\234\210\333!\363T\326\004"
	.ascii	"J\372b\203\253 \377\315n>\032\342\324\030\341W+\3469\374\027\226\027\343\375i\027\274\357S\232\r"
	.ascii	"\325\265\275\335\026\301}^-\335\245\215\266\336T)\222\24243\027\b\266\034\327\032\231\030&OzJ"
	.ascii	"K*7\257\221\262\303$\362G\201qp\202\332\223\362\236\211\206d\205\204\3353\356\340#B1\226J"
	.ascii	"\225_\261_\002\030\247\364\217\033\\k4_\366=\022\021\340\000\205\360\374\315H\030\323\335L\f\265\021"
	.ascii	"\326\377\244\bD'\350\246\331v\025\234~\027\216s\362\263\002=\266H3wQ\314k\316M\316KO"
	.ascii	"o\013\235\304na\3420\027#\354\312\217qV\344\246Ok\362\233@\353H7_Ya\345\316B0"
	.ascii	"\204%$\342Z\316\037\247\236\212\365\222Vr\352&\364<\352\034\327\t\032\322\346\001\034\267\024\335\374s"
	.ascii	"A\254\233Dyp~B\n1\342\274m\343Z\205|\032\204_!v\256L\326\341\234\232\ft\2368"
	.ascii	"(\254\016W\366x\275\311\341\234\221'2\013[\345\355\221\233\241\253>\374e\2206&\326\345%\304%"
	.ascii	"\316\271\3344\256\263\374d\255\320H\343#\003P\227\0338\306b}\360\263E\210gZFySTa"
	.ascii	"n\336\327\361\246\006>?\b#\006\216'v\371>wl\212N&\366\024\214YGH\025\211\2409e"
	.ascii	"\031J\273\024\324\333\304\335\216OB\230<\274\262\031iq\3126\327\237\250H\220\275\031\360\0162e\017"
	.ascii	"s\367\322\303t\037\322\351Eh\304%ATP\3013\236\271\371\350\\Nbl\030\315\305\252\344\305\021"
	.ascii	"\306\340\375\312\261\321\206\324\201Q;\026\343\346?O\232\223\362\372\r\257\250Y*\0073\354\275\307\253L"
	.ascii	"\211\322x?\217x\217\300\237M@\241,\2470\376\235\314e\317\374\213w\362! \313Z\026\230\344~"
	.ascii	".\n\234\b$\226\236#8G\376:\300\304H\307*\241Ov*\355\333\027\202\205\0342\360\223\233c"
	.ascii	"\303\241\021\221\343\b\325{\211t\220\200\324\220++\031\375r\256\302\256\322\347\246\002\266\205<I\337\016"
	.ascii	"\023Av\204\322\304gg5\370\365\367?@\220\240\336\276\346\312\372\317\217\034i\243\337\321T\f\300\004"
	.ascii	"hZ\233YX\201\314\256\016\342\255\353\017OW\352\007\177\266\"t\035\344O\264O\235\001\343\222;@"
	.ascii	"\370\\F\213\201/\302M\370\357\200\024Z\363\240qW\326\307\004\255\277\350\256\364va\262*\261[5"
	.ascii	"\030s\214Z\307\332\001\243\021\252\316\263\235\003\220\355-?\256;\277|\007o\216\255R\340\370\352\030u"
	.ascii	"\364\273\223t\314d\036\247\303\260\243\354\331\204\275\345\205\347\005\372\f\305k\n\022\303.\0302\201\233\017"
	.ascii	"2l\177\033\304Y\210\244\23028\364\274`-\017\331\321\261\311)\251\025\030\304U\027\273\033\207\303G"
	.ascii	"\260fP\310P]\346\373\260\231\242\263\260\304\354b\340\350\032D\352T7\345_\215\324\350,\240\376\b"
	.asciz	"HO\354q\227SDQn]\214\311}\261\005\370k\306\303G\032\301b\367\334\231Fv\205\233\270"
	.ascii	"\320\352\336hv\335M\202#]hK Ed\310e\326\211]\315\317\024\2657\325uO\247)8G"
	.ascii	"\311\0029\255:S\331#\217X\003\357\316\335\302d\264/\341\317\220s%\025\220\323\344DM\213fl"
	.ascii	"\030\304yFu\332\322\202\360\215a\262\330\327;\346\n\353G\254$\357^5\264\3063HLhx "
	.ascii	"\f\202xz!\317H;\227>'\201\262\nj\367{\355\216\214\247el\251?C\212O\005\246\021t"
	.ascii	"\264u\261\030=\345\232W\002\241\222\363Y1qh\3655\357\036\272\354U\204\2179\214Er\250\311\036"
	.ascii	"m\310\235\2712\235eM\025\361:`u\334L\004\210\344\302\334,qL\263\3774\201\373te\023|"
	.ascii	"\233P\242\000\324\244\346\270\264\202\310\013\002\327\201\233au\225\361\233\314\347W`d\315\307\245\210\335:"
	.ascii	"F09Y\324\230\302\205\354Y\366_\2305~\217:n\366\362*\242,\035 \247\006\2441\021\272a"
	.ascii	"\362\3345\266pW\211\253\274\037l\366l\357\337\002\207\321\266\276h\002S\205t\236\207\314\374)\231$"
	.ascii	")\220\225\026\361\240\320\243\211\275~\272lk;\002\0073x&>Z\361{\347\354\330\273\f1 V"
	.ascii	"\326\205\342w\364\265Ff\223a\217lg\377\350@\335\224\265\253\021s\354\246M\354\214e\363F\310~"
	.ascii	"C\3264IC\223\211R\365\"\022\245\006\370\333\271\"\034\364\303\217\207m\2170\227\235M*jg7"
	.ascii	"\307.\242\035?\217^\233\023\315\001lw\035\017\023\270\237\230\242\317\217L!\325\235\2339#\367\252m"
	.ascii	"\242\216\255\254\277\004;X\204\350\213\024\350C\267)\333\305\020\b;X\036+\252\273\263\216\345IT+"
	.ascii	"G\276=\353bu:_\270\240\275\216T8\352\367\231rtE1\345\303\000Q\325'\026\347\351\004\023"
	.ascii	"\376\234\334j\322\024\230x\013\335H\213?\253\033<\n\306y\371\377\341\017\332\223\326-|-\336hD"
	.ascii	"\316\007c\370\306\330\232K(\f]C15\021!,wze\305f\250\324Rs$c~B\246]"
	.ascii	"\236F\031\224^5\273QT\307\335#L\334\3463b\231\177D\326\266\245\223c\275D\373o|\316l"
	.ascii	"\312\"\254\336\210\306\224\032\370\037\256\273\367n\006\271\017XY\2158\214\255\210\250,\237\347\277\232\362X"
	.ascii	"\366\315\016q\277dZK<),F8\345L\261\271:\013\325V\320C6pH[\030$7\371j"
	.ascii	"h>\347\215\253\317\016\351\245v~7\237o\003T\202Y\001\276\013[I\3606\036\364\247\304)vW"
	.ascii	"\210\250\306\tE\002 2s\211UK\0236\340\322\237(3<#6\342\203\217\301\256\f\273%\037p"
	.ascii	"\023\301\276|\331\366\030\235\344\333\277t\346\006J\204\326`N\254\"\265\365 Q^\225P\300[\nr"
	.ascii	"\355la\344\370\260\250\303}\250%\236\016f\000\367\234\245\274\364\037\006\343a\351\013\304\275\277\222\f."
	.ascii	"5Z\200\233C\t?\f\374\253Bb7\213N\350F\223\"\\\363\027\024i\354\360N\024\273\234\233\016"
	.ascii	"\356\276\261]\325\233\356\215\271?r\n7\253\303\311\221\327h\034\277\361\250D\336<\375\034\031Dm6"
	.ascii	"\255 W\373\217\324\272\373\016\r\371\333k\221\201\356\277CUcR1\201\324\330{3?\353\004\021\""
	.ascii	"\024\214\274\362C\027<\236;l\205\265\374&\332.\227\373\247h\016/\270\314D2Y\274\346\244gA"
	.ascii	"\356\217\316\370e&\276\302,\326\200\350\024\377g\351\356N6/~n.\361\366\322~\313p3\2634"
	.ascii	"\000'\366v(\235;d\353hv\016@\235\035]\204\006\374!\003CK\033j$U\"~\2738y"
	.ascii	"\314\326\201\206\356\221\305\315S\247\205\355\234\020\002\316\203\210\200X\301\205t\355\344e\376-n\374v\021"
	.ascii	"\270\016wI\211\342\220\333\243@\364\254*\314\373\230\233\207\327\336\376O5!\266\006i\362T>j\037"
	.ascii	"\233a\234[\320l\257\264\200\204\245\262\364\311\337-\304M\351\353\002\245O=4_}gL:\374\b"
	.ascii	"\3524\007\323\231\301\244`\326\\\0261\266\205\300@\225\202Y\367#>3\342\321\000\271\026\001\255/O"
	.ascii	"8\266;\267\035\331,\226\b\234\022\374\252w\005\346\211\026\266\3639\233ao\201\356D)_\231Q4"
	.ascii	"TN\256\224A\262\276Dl\357W\030Q\034T_\230\004\2156-k\036\246\253\367.\227\244\204TD"
	.ascii	"|}\352\237\320\374R\221\366\\\223\260\224l\201J@\\(G\252\232\216%\267\223(\004\246\234\270\020"
	.ascii	"n\360EZ\276A9ue_\234m\355\256|\320\266Q\377r\234kw\021\251M\r\357\331\321\322\027"
	.ascii	"\234(\030\227IGY=&?S$\305\370\353\022\025\357\303\024\313\277b\002\216Q\267w\325x\270 "
	.ascii	"j>?\007\030\257\362'i\020R\327\031\345?\375\"\000\246<,\267\343\"\247\306e\314cO!r"
	.ascii	"\311);\364\271\267\235\035u\217QOJ\202\005\326\304\235/1\275r\300\362\260E\025Z\205\254$\037"
	.ascii	"\223\246\007S@\177\343\264\225g3/\327\024\247\253\231\020vs\247\320\373\326\311\313q\201\305H\337_"
	.asciz	"\252\005\225\2162\b\326$\356 \024\f\321\301HG\242%\373\006\\\344\377\307\346\225\343*\236s\272"
	.ascii	"&\273\210\352\365&D\256\373;\227\204\331y\0066PNi&\f\003\237\\&\322\030\325\347})r"
	.ascii	"\326\220\207\\\336\230.Y\337\242\302E\323\267\277\345\"\231\264\371`;Z\021\363x\255g>:(\003"
	.ascii	"9\271\f\276\307\035$H\2000c\213M\233\3612\b\223(\002\r\311\337\323E\031'Fh)\341\005"
	.ascii	"PE,$\310\273\277\255\331\2010\320\354\f\310\274\222\337\310\365\246f5\204L\316X\202\323%\317x"
	.ascii	"ZI\234-\263\356\202\272|\271+\361\374\310\357\316\340\321\265\223\256\253-\260\233\215i\023\234\f\3009"
	.asciz	"h\235H1\216k\256\025\207\360+\234\253\034\205\252\005\372N\360\227Z\247\3112\370?k\007Rk"
	.ascii	"-\b\316\271\026~\313\365)\274zAL\361\0074\253\247\364+\316k\263\324\316u\237\032V\351\342}"
	.ascii	"\034x\225\235\341\317\340)\342\020c\226\030\337\201\2669kQp\3239\337W\"a\307;D\343WM"
	.ascii	"\313^\245\266\364\324p\336\231\333\205]\177R\001H\201\232\356\323@\304\311\333\355)`\032\257\220*k"
	.ascii	"\n\330\262[$\363\353w\233\007\271/G\0330\3303s\356L\362\346G\306\t!l'\310\022XF"
	.ascii	"\227\036\346\232\374\364#i\321_?\340\035(5W-\321\355\346C\256d\247J>-\321\351\364\330_"
	.ascii	"\331b\020*\262\276CM\026\33418u\373ep\327h)\336{J\r\030\220g\261\034+,\263\005"
	.ascii	"\225\201\325z,\244\374\367\314\3633Cn(\0242\235\227\0134\r\235\302\266\341\007sVH\032w1"
	.ascii	"\375\250M\322\314^\300\310\203\357\337\005\254\032\317\241a\315\371}\362\357\276\333\231\036G{\243VU;"
	.ascii	"\202\324M\341$\305\2602\266\244+\032TQ\263\355\363Z+(H`\321\243\3536sz\322y\300O"
	.ascii	"\r\305\206\fD\2134\334Q\346\224\314\311\3137\023\271<>dM\367\"d\b\315\343\272\302p\021$"
	.ascii	"\177/\277\211\2608\311Q\247\351\337\002e\275\227$S\344\200x\234\300\377\377\222\216\371\312\316gE\022"
	.ascii	"\264s\304\n\206\253\371?5\344\023\001\356\035\221\360\257\304\306\353`P\347J\r\000\207l\226\022\206?"
	.ascii	"\023\215\0046\372\374\030\234\335\235\211s\263\235\025)\252\320\222\237\0135\237\334\324\031\212\207\356~\365&"
	.ascii	"\336\r*x\311\f\232U\205\203q\352\262\315\035U\214#\3571[\206b\177=asyv\247JP"
	.ascii	"\261\357\207V\325,\253\f{\361z$b\321\200Qg$ZO4Z\301\205i0\272\235=\224A@"
	.ascii	"\335\252l\242Cw!K\316\267\212d$\264\246G\343\311\373\003zO\035\313\031\320\000\230B1\331\022"
	.ascii	"\226\314\353C\272\356\300\303\257\234\352&\234\234t\215\306\314w\034\356\225\372\331\0174\204v\331\241 \024"
	.ascii	"OY7\323\231w\306\000{\244:\262@Q<^\225\363_\343T(\030D\022\240YC1\222O\033"
	.ascii	"\261f\230\24400\3173YH_!\322s\037%\366\364\336Q@\252\202\253\366#\232o\325\221\361_"
	.ascii	"Q\t\025\211\235\020\\>ji\351-\221\372\3169 0_\227?\344\352 \256-\023\177*W\233#"
	.ascii	"h\220-\2543\324\236\201#\205\311_y\253\203(=\353\223U\200rE\357\3136\217ujR\f\002"
	.ascii	"\211\314B\360Y\3571\351\266K\022\216\235\234X,\227Y\307\256\212\341\310\255\f\305\002V\n\376,E"
	.ascii	"\274\333\330\236\3704\230wl\244|\334\371\252\362\310t\260\341\243\334LR\251w81\025F\314\252\002"
	.ascii	"\337wxd\240\367\240\206\237|`\016'd\304\273\311\021\373\361%\352\027\253{\207K0{}\373L"
	.ascii	"\022\357\211\227\302\231\206\342\r\031W\337q\315n+\320p\311\354W\310C\303\305:MC\274L\035["
	.ascii	"\376u\233\270l=\264r\200\334j\234\331\224\306T\237L\343>7\252\303\270dS\0079+b\264\024"
	.ascii	"&\237\n\314\025&\373\266\345\314\215\270+\016O:\005\247i3\213I\001\023\321-YX\022\367\230/"
	.ascii	"\001\247TOD\256\022.\336\327\313\251\360>\376\374\340]\203u\r\211\277\316TEa\347\351b\200\035"
	.ascii	"V\236\017\265L\247\224\f \023\216\216\251\364\037[g\0170\202!\314*\232\371\252\006\330I\342j:"
	.ascii	"Z|\220\251\205\332zeb\017\271\221\265\250\016\032\351\2644\337\373\035\016\215\363_\362\256\350\214\213)"
	.ascii	"\336e!\n\352rz\203\366y\317\013\264\007\253?p\2568w\3076\026R\334\327\247\003\030'\246k"
	.ascii	"\262\f\367\357Sy\222*vp\025y*\311\211Kj\317\2470zE\030\224\205\344\\M@\250\2704"
	.ascii	"53i\203\265\354n\302\375\376\265c\337\023\250\325s%\262\244\232\252\223\242j\034^F\335+\326q"
	.ascii	"\365^\367\261\332\265-\315\365e\260\026\317\225\177\327\205\360I?\352\037W\024=++&!63\034"
	.ascii	"\200\337x\323(\3143e\264\244\017\nyC\333\366Z\332\001\367\371_d\343\244+\027\363\027\363\325t"
	.ascii	"\201\312\331gT\345o\2507\214)+u|\2139;b\254\343\222\bm\332\214\331\351GE\314\353J"
	.ascii	"\020\266Ts\236\215@\013n[\250[S2k\200\007\242XJ\003:\346\333,\337\241\311\335\331;\027"
	.ascii	"\311\001m'\033\007\360\022p\214\304\206\305\272\270\347\251\373\326q\233\022\bS\222\267=Z\371\373\210]"
	.ascii	"\337rX\376\036\017P+\301\0309\324.X\326X\340:g\311\216'\355\346\031\243\236\261\023\315\341\006"
	.ascii	"S\003[\236b\257+GG\004\215'\220\013\252;'\277C\226F_x\f\023{\203\215\032j:\177"
	.ascii	"#o\026oQ\255\320@\276j\253\037\2232\216\021\216\bM\240\024^\343?fb\341&5`\2000"
	.ascii	"\013\200=]9D\346\367\366\355\001\311U\325\250\2259c,Y0x\315h~0Q.\355\375\3200"
	.ascii	"PG\270h\036\227\264\234\317\273df)r\225\240+A\372r&\347\215\\\331\211\305QC\b\025F"
	.ascii	"\2633\022\362\032MY\340\234M\314\360\216\347\333\033w\232I\217\177\030eih\230\t, \024\222\n"
	.ascii	".\240\271\256\300\031\220\274\256L\003\026\r\021\307U\3542\231e\001\365m\016\376]\312\225(\r\312;"
	.ascii	"\277\001\314\236\266\216h\234o\211D\246\255\203\274\360\342\237z__\225-\312A\202\362\215\003\264\250N"
	.ascii	"\244b]<\2741\360@`z\360\317>\213\374\031E\265\017\023\242=\030\230\315\023\217\256\335\3361V"
	.ascii	"\002\322\312\361\nF\355*\203\356\214\244\005S0F_\032\361IEw!\221c\244,T0\t\316$"
	.ascii	"\205\013\363\375U\241\317?\244.76\216\026\367\322D\370\222d\336d\340\262\200BO2\247(\231T"
	.ascii	"\006\301\006\375\365\220\350\037\362\020\210]5h\304\265>\257\214n\376\bx\202K\327\006\212\302\343\324A"
	.ascii	".\032\356c\2472n\362\352\375_\322\267\344\221\256iM\177\321;\323;\274j\377\334\300\336f\033I"
	.ascii	"\241d\332\320\216J\360uK(\342g\257,\"\355\244{{\037y\2434\202g\213\001\267\260\270\366L"
	.ascii	"\2472\352\307=\261\365\230\230\333\026~\314\370\325\343G\331\370\313R\277\n\254\254\344^\310\3208\363\b"
	.ascii	"\275s\032\231!\250\203\303z\f2\337\001\274'\253cpw\204\0333=\301\231\212\007\353\202J\rS"
	.ascii	"\236\277\232lEsim\200\250\000I\374\262\177%P\270\317\310\022\364\254+[\275\277\f\340\347\263\r"
	.ascii	"%H\371\34106L\000ZS\253\214&x-~\213\377\204\314##H\307\271p\027\020?u\352e"
	.ascii	"cc\t\342>\374f=k\313\265a\177,\326\201\032;D\023B\004\276\017\333\241\341!\031\354\244\002"
	.ascii	"_y\317\361ba\310\365\362W\356&\031\206\214\021x5\006\034\205$!\027\317\177\006\354]+\3216"
	.ascii	"\242\270$;\232%\346\\\270\240\257E\314zW\2707p\240\213\350\346\313\314\277\tx\022Q<\024="
	.ascii	"WE\025y\221'm\022\n:x\374\\\217\344\325\254\233\027\337\350\266\2756Y(\250[\210\027\365."
	.ascii	"Q/[0\373\277\356\226\270\226\225\210\2558\371\323%\335\325F\307-\365\360\225\000:\273\220\202\226W"
	.ascii	"\334\256X\214N\2277F\244A\360\253\373\"\357\271\212q\200\351V\331\205\341\246\250C\261\372x\033/"
	.ascii	"\001\341 \nC\270\032\367G\354\360$\215e\223\363\321\356\342n\250\tu\317\341\243*\3345>\304}"
	.ascii	"\030\227>'\\*xZ\224\375N^\231\306v5>}#\037\005\330.\017\231\n\325\202\035\270O\004"
	.ascii	"\303\331}\210ef\226\205US\260K1\233\017\311\261y \357\370\215\340\306/\301\214u\026 \367~"
	.ascii	"\331\343\007\251\305\030\337\301YcL\316\0357\263WI\273\001\2624Ep\312.\3350\234?\202y\177"
	.ascii	"\272\207\365h\360\037\234j\336\310P\000N\211'\b\347[\355}U\231\277<\360\326\006\034C\260\251d"
	.ascii	"\350\023\265\2439\3224\203\330\250\037\271\324p6\3013\275\220\3656A\265\022\264\331\204\327s\003N\n"
	.ascii	"\031)}[\241\326\263.5\202:\325\240\366\264\260G]\244\211C\316Vql4\030\316\n}\032\007"
	.ascii	"1D\341 R5\f\314AQ\261\t\007\225e\r6_\235 \033b\365\232\323Uwa\367\274i|"
	.ascii	"\013\272\207\310\252-\007\323\356b\245\277\005)&\001\213v\357\300\0020T\317\234~\352Fq\314;,"
	.ascii	"_)\350\004\353\327\360\007}\363P/%\030\333\020\327\230\027\027\243\251Q\351\035\245\254\"s\232Zo"
	.ascii	"\276D\331\243\353\324)\347\236\257x\200@\t\236\215\003\234\206GzV%E$;\215\356\200\226\253\002"
	.ascii	"\305\306A/\f\000\241\213\233\373\376\f\301y\237\304\237\034\305<pG\372N\312\257G\341\242!NI"
	.ascii	"\232\r\345\335\205\212\244\357I\242\271\017N\"\232!\331\366\036\331\035\037\t\3724\273F\352\313v]k"
	.ascii	"\"%x\036\027A\371\340\3236i\003t\256\346\361F\307\374\320\242>\213@>1\335\003\234\206\373\026"
	.ascii	"\224\331\f\354lUW\210\272\035\320\\o\334rdw\264B\217\024i\001\257Ts'\205\3663\343\n"
	.ascii	"b\t\2663\227\031\216(3\341\253\330\264r\374$>\320\221\t\355\367\021Hu\320p\217\213\343\201?"
	.ascii	"$\310\027_5\177\333\n\244\231B\327\303#\271t\367\352\370\313\213>|\325=\334\336L\323\342\323\n"
	.ascii	"\376\257\331~\314\017\221\177K\207e$\241\270\\T\004G\fK\322~9\250\223\t\365\004\301\017QP"
	.ascii	"\235$n3\305\017\fo\331\3171\303\031\336^t\034\376\356\t\000\375\326\362\276\036\372\360\213\025|\022"
	.ascii	"t\271Q\256\304\217\242\336\226\376Mt\323s\231\035\250H8\207\013h@b\225\337g\321y$\330N"
	.ascii	"\242y\230.B|\031\366G6\312R\324\335J\244\313\254NK\301?A\233hO\357\007}\370N5"
	.ascii	"u\331\305`\"\265\343\376\270\260A\353\374.5P<e\366\2510\254\b\210m#9\005\322\222-0"
	.ascii	"w\361\340\344\266o\274-\223j\275\244)\277\341\004\350\366zx\324f\031^`\320&\264^_\334\016"
	.ascii	"=(\244\274\242\301\023x\331=\206\241\221\360b\355\206\372h\302\270\274\307\256L\256\034o\267\323\345\020"
	.ascii	"g\216\332S\326\277STA\366\251$\354\036\334\351#\212W\003;&\207\277r\272\0346Ql\264E"
	.ascii	"\344\343\177\212\335M\235\3160\016bvVd\023\253X\231\016\263{OYK\337)\0222\357\n\034\\"
	.ascii	"\241\177O1\277*@\251P\364\214\216\334\361W\342\204\276\250#K\325\273\035;q\313m\243\277w!"
	.ascii	"\217\333y\372\274\033\b7\263Y_\302\036\201H`\207$\203\234evz\b\273\265\212}8\031\346J"
	.ascii	"\203\373[\230D~\021a61\226q*F\340\374K\220%\324H4\254\203d=\244[\276Zhu"
	.ascii	".\243DS\252\366\333\215x@\033\264\264\352\210}`\r\023J\227\353\260^\003>\277\027\033\331\000\032"
	.ascii	"\262\362a\3533\t\226nRI\377\311\250\017=Tie\366z\020ur\337\252\346\260#\266)U\023"
	.ascii	"\376\203.\342\274\026\307\365\301\205\t\350\031\353+\264\256J%\0247\246\235\354\023\246\220\025\005\352rY"
	.ascii	"\030\325\321\255\327\333\360\030\021\037\301\317\210x\237\227\233u\024q\360\3412\207\001:\312e\032\270\265y"
	.ascii	"\021x\217\334 \254\324\017\250OM\254\224\322\232\2324\0046\263d-\033\300\333;_\220\225\234~O"
	.ascii	"\376\231R5=D\310q\327\352\353\333\034;\315\213f\224\244\361\236I\222\200\310\255D\241\304\356B\031"
	.ascii	".0\201W\274Kgb\017\334\255\2119\017R\330\306\331\373S\256\231)\214L\216c.\331:\2311"
	.ascii	"\222I#\256\031S\254}\222>\352\f\221=\033,\"\021<%\224\344<Uu\312\371N1e\n*"
	.ascii	":y\034<\315\0326\317;\2745Z\254\274\236/\253\246\315\250\351`\350`\023\032\352m\233\303]\005"
	.ascii	"\302'\371\367\177\223\267-5\246\320\027\006\037t\333v\257U\021\242\363\202Y\355-|d\030\342\366L"
	.ascii	"\266[\215\302|\"\031\261\253\377Mw\274N\342\007\211,\243\344\316x<\250\266$\252\020w0\032\022"
	.ascii	"\311\203t\307>qY\326\257\226+\270w\340\277\210\323\274\227\020#(\236(\233:\355lJ\271{R"
	.ascii	"\227J\003\237^]\333\344-\27440\t\374S\341\261\323Q\225\221F\005F-\345@zl\307?3"
	.ascii	".H[\231*\231=V\00188n|\320\0054\345\330d/\3365PH\367\251\247 \233\006\211k"
	.ascii	"w\333\307\265\214\372\202@U\3014\307\370\206\206\006~\245\347\366\331\310\346)\317\233c\247\b\323s\004"
	.ascii	"\r\"pbA\240*\201N[$\371\372\211Z\231\005\357rP\316\304\255\377s\353s\252\003!\274#"
	.ascii	"\005\236X\003&y\356\312\222\304\334F\022BK+O\251\001\346t\357\241\002\0324\004\336\277s/\020"
	.ascii	"\232\034Q\265\340\332\264\242\006\377\377+)`\310z4BP\365]7\037\230-\241N\332%\327k?"
	.ascii	"\306EW\177\253\271\030\353\220\306\207W\356\212:\002\251\257\367-\332\022'\267=\001\\\352%}Y6"
	.ascii	"\254X`\020{\215Ms_\220\306o\236W@\331-\223\002\222\371\370fd\320\326`\332\031\314~{"
	.ascii	"\233\372|\247QJ\256mP\206\243\347T6&\202\333\202-\217\315\377\273\t\272\312\365\033f\334\276\003"
	.ascii	"\ri\\i<7\302xn\220B\006f.%\335\322+\341JDD\035\225V9t\001v\2555B"
	.ascii	"\365u\211\007\r\313Xb\230\362\211\221TB)I\344n\343\342#\264\312\240\241f\360\315\260\342|\016"
	.ascii	"\371pK\331\337\376\246\376-\272\374\301Q\3000\361\211\253/\177~\324\202H\265\356\354\212\023VRa"
	.ascii	"\243\205\214\304:d\224\304\2559a<\364\0356\375HM\351:\335\027\333\tJg\264\217]\nnf"
	.ascii	"\r\313pHN\366\273*k\213E\252\360\274e\315]\230\350u\272N\276\232\344\336\024\325\020\310\013\177"
	.ascii	"\240\023rs\255\235\254\203\230.\367.\272\370\366\237Wi\354C\335.\0361u\253\305\336}\220:\035"
	.ascii	"o\023\364&\244k\000\27150\340W\2366g\215(<FO\331\337\310\313\365\333\356\370\274\215\037\r"
	.asciz	"\334\201\320>1\223\026\272\2004\033\205\255\2372)\313!\003\003<\001(\001\343\375\033\243D\033\001"
	.ascii	"\\\247\nji\037V\026j\275RX\\r\277\301\255fy\232\177\335\250\021&\020\205\322\242\210\331c"
	.ascii	"\fl\306?l\240\337?\322\r\326M\216\343@]qM\216&8\213\343z\341W\203n\221\215\304:"
	.ascii	".#\275\257S\007\022\000\203\366\330\375\270\316+\351\221+\347\204\263i\026\370f\240h#+\325\3723"
	.ascii	"\350\317\"\304\320\310,\215\313:\241\005{O+\007o\245\366\354\346\266\376\243\342q\n\271\314U\303<"
	.ascii	"\026\036\344\305\306I\006T5w?30d\370\nF\347\005\363\322\374\254\262\247\334V\242)\364\300\026"
	.ascii	"1\221>\220C\224\266\351\3167Vz\313\224\244\270D\222\272\272\244\321|\310hu\256kB\257\036c"
	.ascii	"\350\rp\243\271u\331GR\005\370\342\373\305\200r\341]\3442'\217eS\265\200_f\177,\037C"
	.ascii	"\237\376f\332\020\004\351\263\246\345\026lRK\335\205\203\277\371\036a\227=\274\265\031\251\036\213d\231U"
	.ascii	"\031{\217\205Dc\002\326JQ\352\241/5\253\024\327\251\220 \032D\000\211&;%\221_q\004{"
	.ascii	"\306\272\346\304\200\302v\263\013\233\035m\335\323\016\227D\371\013EX\225\232\260#\342\315W\372\254\320H"
	.ascii	"C\256\366\254(\275\355\203\264z\\}\213|5\206D,\353\267iG@\300?X\366\302\365{\263Y"
	.ascii	"q\346\253}\344&\017\2667:/b\227\241\321\361\224\003\226\351~\316\bB\333;m3\221A#\026"
	.ascii	"@\206\363\037\326\234I\335\240%6\006\303\233\315)\303=\327=\002\330\342Q1\222; zp%J"
	.ascii	"\366\177&\366\336\231\344\271C\b,t{\312rw\261\362\244\351?\025\240#\006P\320\325\354\337\337,"
	.ascii	"j\355\366S\212f\267*\241p\321\035XBB0a\001\342:L\024\000@\374I\216$m\211!W"
	.ascii	"N\332\320\241\221P](\b>\376\265\247o\252K\263\223\223\341|\027\345c\3750\260\304\2575\311\003"
	.ascii	"\256\033\030\375\027Un\013\264c\271+\237b\"\220%F\0062\351\274\tU\332\023<\366t\335\216W"
	.ascii	"=\f+I\306vr\231\374\005\342\337\304\302\314G<:b\335\204\233\322\334\242\307\210\002Y\253\302>"
	.ascii	"\313\3212\256\t:!\247\325\302\365@\337\207+\017)\253\036\350\306\244\256\013^\254\333jl\366\033\016"
	.ascii	"\271{\330\344{\322\240\241\355\0329a\353M\213\251\203\233\313s\320\335\240\231\316\312\017 Z\302\325-"
	.ascii	"~\210,y\351\325\253\342]m\222\313\030\000\002\032\036_\256\272\315i\272\277_\217\350Z\263H\005s"
	.ascii	"4\343\326\241K\t[\200\031?5\tw\361>\277+p\"\006\313\006?B\335Ex\330w\"ZX"
	.ascii	"\356\270\250\313\243Q5\304\026_\021\262\035o\242eP8\214\253RO\017v\312\270\035A;DC0"
	.ascii	"b\211\3243\202_\212\241\177%x\354\265\304\230f\377A>7\245o\216\247\037\230\357P\211'Vv"
	.ascii	"\235\317\206\352\243sp\341\334_\025\007\267\373\214:\216\212\2031\374\347SH\026\366\023\266\204\364\273("
	.ascii	"\300\310\037\325Y\317\3038\362\266\006\005\375\322\355\233\217\016W\253\237\020\277&\246F\270\301\250`A?"
	.ascii	"|l\023o\\/a\362\276\021\335\366\007\321\352\2573o\336\023\322\232~R]\367\210\2015\313y\036"
	.ascii	"\201\201\340\365\330S\351w\331\336\235)D\f\245\204\345%E\206\f-l\334\364\362\3219-\265\212G"
	.ascii	"\361\343\367\356\30364\001\370\020\236\376\177j\213\202\374\336\371\274\345\b\371\17718;:\033\225\327e"
	.ascii	"Y\321R\222\323\244\246f\007\310\032\207\274\341\335\345o\311\301\246@k,\270\024\"!\032Az\330\026"
	.ascii	"\203\005N\325\342\325\244\373\372\231\275.\327\257\037\342\217w\351ns\302zI\336mZzW\013\231\037"
	.ascii	"\025b\006BZ~\275\263\301$Z\f\315\343\233\207\267\224\371\326\261]\300W\246\214\363e\201|\370("
	.ascii	"\326\367\350\033\255N4\243\217y\352\254\353P\036}R\340\rR\236V\306w>mMS\341/\210E"
	.ascii	"\344o<\224)\231\254\330\242\222\203\243a\361\371\265\363\232\310\276\023\333\231&t\360\005\344<\204\317}"
	.ascii	"\326\203yu]4if\246\021\252\027\021\355\266b\217\022^\230W\030\335}\335\366&\366\270\345\217h"
	.ascii	"\3002GJH\326\220l\2312V\312\375C!\325\341\306]\221\303(\276\263\033\031's~h9g"
	.ascii	"\300\032\f\310\235\314m\2466\2448\033\364\\\240\227\306\327\333\225\276\363\353\247\253}~\215\366\270\240}"
	.ascii	"\246uV8\024 x\357\350\251\375\2520\237d\242\313\250\337\\P\353\321L\263\300M\035\272Z\021F"
	.ascii	"v\332\265\303S\031\017\324\233\236\021!so\254\035`Y\262\376!`\314\003KKg\203~\210_Z"
	.ascii	"\271C\246\240\323(\226\236d \303\346\000\313\303\2652\354-|\211\002S\233\f\307\321\325\342z\343C"
	.ascii	"\021=\241p\317\001c\217\304\320\r5\025\270\316\317~\244\274\244\324\227\002\3674\024M\344V\266i6"
	.ascii	"3\341\246\355\006?~8\300:\241\231Q\0350g\0218&6\370\330Z\275\276\351\325O\315\346!j"
	.ascii	"\343\262\231f\022)A\357\001\023\215pG\b\323q\275\260\202\021\3202T26\213\036\000\007\0337E"
	.ascii	"_\346F0\n\027\306\361$5\322\000**qXU\267\202\214<\275\333iW\377\225\241\361\371kX"
	.ascii	"\013y\370^\215\b\333\246\3457\ta\334\360xR\270n\241a\322I\003\254y!\345\2207\260\257\016"
	.ascii	"\035\256u\017^\200@Q0\314b&\343\373\002\354m9\222\352\036\337\353,\263[C\305D3\256D"
	.ascii	"/\004H7\301U\005\226\021\252\013\202\346A\232!\fmHs8\367\201\034a\306\002Zg\314\2320"
	.ascii	"\356C\245\273\271\211\362\234Bq\311Z\235\016v\363\252`\223O\306\345\202\035\217g\224\177\033\"\325b"
	.ascii	"<z\367:&\324\205uM\024\351\376\021{\256\337=\031\367Y\200p\006\2457 \222\203S\232\362\024"
	.ascii	"m\223\320\030\234)LR\f\032\f\212l\265k\3101\206J\333.\005u\243bEu\274\344\375\016\\"
	.ascii	"\365\327\262%\334~q\337@0\265\231\333p\371!bL\355\303\2674\222\332>\t\356{\\6r^"
	.ascii	">\263\b/\0069\223}\2762\237\337\345Y\226[\375\275\236\037\255=\377\254\267Is\313U\005\262p"
	.ascii	"\177!qE\007\374[W[\331\224\006]gy73\036\031\364\2737\n\232\274\352\264GL\020\361w"
	.ascii	"L,\021U\305\023Q\276\315\037\210\232:B\210fG;P^\205wfDJ@\006J\21794\016"
	.ascii	"(\031K>\t\013\223\030@\366\363s\016\341\343}o]9s\332\0272\364>\2347\312\326\336\212o"
	.ascii	"\350\275\316>\331\"}\266\007/\202'A\350\263\t\215m[\260\037\246?tr#6\2126\005T^"
	.ascii	"\232\262\267\375=\022@\343\221\262\032\242\341\227{H\236\224\346\375\002}\226\371\227\336\323\310.\347\rx"
	.ascii	"r'\364\000\363\352\037g\252A\214**\353r\217\22227\227\327\177\241)\246\207\2652\255\306\357\035"
	.ascii	"\274\347\232\bE\205\342\n\006M\177\034\317\336\2158\270\021H\nQ\025\2548\344\214\222q\366\213\262\016"
	.ascii	"\247\225Q\357\032\276[\257\355\025{\221w\022\214\024.\332\345z\373\367\221)g(\335\370\033 }F"
	.ascii	"\251\347zV\275\364\036\274\275\230D\326\262Lb?\310N\037,\322d\020\344\001@8\272\245\305\371."
	.ascii	"\255O\357t\232\221\376\225\242\b\243\366\354{\202:\001{\244\t\323\001N\226\227\307\243[O<\304q"
	.ascii	"\315t\236\372\366m\375\266z&\257\344\274x\202\361\016\231\357\361\320\263U\202\223\362\305\220\243\214uZ"
	.ascii	"\224\334a\035\213\221\340\214f0\201\232F6\355\215\323\252\350\257)\250\346\324?\3249\366'\200s\n"
	.ascii	"\225$F\331\020'\267\242\003P}\325\322\306\250:\312\207\264\240\277\000\324\343\354r\353\263D\342\272-"
	.ascii	"\314\341\377W/J\017\230C\230\203\341\r\rg\000\375\025\373IJ?\\\020\234\246&Qc\312\230&"
	.ascii	"\016\331=^/p=.\206S\322\344\030\t?\236j\251M\002\366>w^23\372J\fK\000<"
	.ascii	"x\272\2602\2101e\347\213\377\\\222\3671\0308\314\037)\240\221\033\250\b\007\353\312I\314=\264\037"
	.ascii	"+\270\364\006\254F\251\232\363\304\006\250\245\204\242\034\207G\315\306_&\323>\027\322\037\315\001\375Ck"
	.ascii	"\363\016v>XB\307\265\220\271\n\356\271R\334u?\222+\007\302'\024\277\360\331\360o-\013Bs"
	.ascii	"D\305\227FK]\247\307\277\377\017\337H\370\375\025ZxF\252\353\271h(\024\367R[\020\327hZ"
	.ascii	"\006\036\205\236\313\366,\257\3048\"\306\0239Y\217s\363\373\231\226\270\212\332\236\2744\352/c\265="
	.ascii	"\325%\230\202\261\220I.\221\211\232>\207\353\352\355\370JpL9=\360\356\016+\337\225\244~\031Y"
	.ascii	"\330\331]\367+\356n\364\245Yg9\366\261\027\rsr\236I1\321\362\033\023_\327I\337\0322\004"
	.ascii	"\256Z\345\344\031`\341\004\351\222/~zC{\347\244\232\025o\301-\316\307\300\f\327\364\301\375\352E"
	.ascii	"\355\261\314\317$F\016\266\225\003\\\275\222\302\333Y\311\201\004\334\035\235\2401@\331V]\352\316s?"
	.ascii	"+\327E\200\205\001\204iQ\006/\317\242\372\"L\306-\"ke6\032\224\336\332b\003\310\353^Z"
	.ascii	"\306\215N\n\321\277\247\2679\263\311D~\000W\276\372\256W\025\177 \301`\333\030b&\221\210\005&"
	.ascii	"B\345v\306<\216\201L\255\314\316\003\223,B^\b\237\022\264\312\314\007\354\270CD\262\020\372\355\r"
	.ascii	"\004\377`\203\246\004\367Y\364\346av\336?\331\303Q5\207\022s*\033\203W]aN.\f\255T"
	.ascii	"*R+\270\325g;\356\353\301\245\237Fc\3616\323\237\301n\362\322\264\245\b\224z\247\272\262\354b"
	.ascii	"t(\266\2576(\007\222\245\004\341y\205^\315_J\2410\306\255\001\255Z\230?fuP=\221a"
	.ascii	"=+\025aRy\355\345\321\327\335\016}5bIqLk\271\320\310\202t\276\330f\251\031\371Y."
	.ascii	"\33212\0326-\306\rp\002 \2242XG\372\316\224\225?Q\001\330\002\\]\3001\241\302\333="
	.ascii	"\024\273\226'\242W\252\363!\332\007\233\267\272:\210\0349\2401\030\342K\345\371\0052\3308\373\347^"
	.ascii	"K\305^\316\371\017\334\232\r\023/\214k*\234\003\025\225\370\360\307\007\200\002k\263\004\254\024\203\226x"
	.ascii	"\216jDA\313\375\215S\3717IC\251\375\254\245x\214<&\215\220\257F\t\r\312\233<c\320a"
	.ascii	"\337s\374\370\274(\243\255\3747\360\246]i\204\356\t\251\3028\333\264\177c\334{\006\370-\254#["
	.ascii	"f%\333\3775Itc\273h\013x\211k\275\305\003\354>U\2002\033o\365\327\256G\330_\226n"
	.ascii	"{R\200\356S\271\322\232\215m\336\372\252\031\217\350\317\202\016\025\004\027q\016\334\336\225\335\271\273\271y"
	.ascii	"ts\237\216\256}\231\321\026\b\273\317\370\2422\240\n_Dm\022\272l\3154\270\314\nF\021\250\033"
	.ascii	"\302&1j@U\263\353\223\303\310h\250\203c\322\202z\271\345)d\flG!\375\311X\361eP"
	.ascii	"T\231B\f\373i\201pg\317n\327\254\000F\341\272E\346p\212\271\252.\362\372\244X\236\363\2019"
	.ascii	"\336o\346m\245\337E\310:H@,\000\245R\3412\366\264\307c\341\322\351e\033\274\334.E\3640"
	.ascii	"\223\n#Yu\212\373\030]\364\346`i\217\026\035\265<\251\024E\251\205:\375\320\254\0057\b\3348"
	.ascii	"@\227u\305\202'm\205\314\276\234\371iE\023\372qN\352\300s\374D\210i$?Y\032\232-c"
	.ascii	"\247\204\f\355\021\375\t\277:i\237\r\201q\360cy\207\317W-\214\220!\242K\366\212\362}Z:"
	.ascii	"\246\313\007\270\025k\273\366\327\360T\274\337\307#\030\013g)n\003\227\035\273WJ\355G\210\364$\013"
	.ascii	"\307\352\033Q\276\324\332\334\362\314&\355u\200S\244e\232_\000\237\377\234\341c\037HuD\367\3744"
	.ascii	"\230\252\317x\253\035\273\245\362r\013\031g\242\355\\\216`\222\n\021\311\t\223\260t\263/\004\243\031\001"
	.ascii	"\312g\227xL\340\227\301}F\3318\313Mq\270\250_\371\203\202\210\336U\367c\372M\026\334;="
	.ascii	"}\027\302\350\234\330\242g\301\320\225h\366\245\235f\260\242\202\262\345\230e\365s\n\342\355\361\210\300V"
	.ascii	"\002\217\363$\254_\033X\275\f\343\272\376\351\013\251\360\222\317\212\002i!\232\217\003Y\203\244~\213\003"
	.ascii	"\027n\250\020\021=m3\372\262u\0132\210\363\327\210)\007%v3\025\371\207\213\020\231kLg\t"
	.ascii	"\370o1\231!\370N\237O\215\247\352\202\322I/t1\357Z\253\245q\te\353iY\0021^n"
	.ascii	"\"b\006c\016\373\0043?\272\254\207\211\0065\373\243a\020\214w$\031\275 \206\203\321C\255X0"
	.ascii	"\373\223\345\207\365bl\261q>]\312\336\355\231Im>\314\024\340\301\221\264\250\333\250\211G\021\365\b"
	.ascii	"\320cv\345\375\017<2\020\246.\2428\337\303\005\232O\231\254\275\212\307\275\231\334\343\357\244\237T&"
	.ascii	"nf?\257I\205F\333\245\016J\361\004\317\177\327G\f\272\244\367?\362=\205<\3162\341\337\020:"
	.ascii	"\326\371k\036FZ\035t\201\245ww\374\263\005#\331\323td\242tU\324\377\340\001d\334\341&\031"
	.ascii	"\240\316\027\352\212N\177\340\375\301\037:F\025\325/\361\300\3621\375\"S\027\025]\036\206\035\320\241\037"
	.ascii	"\253\224\337\321\000\254\3348\351\r\b\321\335+q.b\342\325\375>\351\023\177\345\001\232\356\030\355\374s"
	.ascii	"2\230Y}\224U\200\314 U\3617\332VF\036 \223\005Nt\367\366\2313\317uj\274c5w"
	.ascii	"\263\234\023c\b\351\261\006\315>\240\305g\332\223\2442\211c\255\310\316w\215DO\206\033pkB\037"
	.ascii	"R%\241\221\3105~\361v\234^WS\201k\267>r\233\ro@\203\3728\344\247?\033\273v\013"
	.ascii	"\001\034\221AL&\311\357%,\242\027\270\267\243\361G\024\017\363k\332uX\220\2601\035'\365\032N"
	.ascii	"\233\223\222\177\371\301\270\bn\253D\324\313qg\276\027\200\273\231cd\345\"U\251r\267\036\326m{"
	.ascii	"\307\322\001\253\371\2530W\030;\024@\334v\373\026\201\262\313\240e\276l\206\376j\377\233e\233\372S"
	.ascii	"\222=\363P\350\301\255\267\317\325\214`O\372\230y\333[\374\215\275-\226\255O/\035\257\316\233>p"
	.ascii	"UT\210\224\351\310\024l\345\324\256ef]:\204\361Z\326\274>\267\033\030P\037\306\304\345\223\2159"
	.ascii	"\362\343\347\322`|\207\303\261\213\2020\240\2524;8\361\236s\347&>(w\005\303\002\220\234\234i"
	.ascii	"\363H\3423g\321K\034_\n\277\025\207\022\236\275v\003\013\241\360\214?\324\023\033\031\337]\233\260S"
	.ascii	"\314\361FY#\247\006\363}\331\345\314\265\030\027\222u\351\264\201G\322\315(\007\331\315o\f\363\312Q"
	.ascii	"\307T\254\030\232\371zs\017\263\034\305\334x3\220\307\f\341L3\274\211+\232\351\370\211\301)\256\022"
	.ascii	"\n\340tvB\247\013\246\363{z\241p\205\016c\314$3\317=VX7\252\375\203#)\252\004U"
	.ascii	"\317\001\r\037\313\300\236\251\256\3674:\314\357\321\r\"N\234\320!u\312U\352\245\353X\351O\321_"
	.ascii	"\216\313\223\277^\376B<_V\3246Q\250\337\276\350 B\210\236\205\360\340(\321%\007\226?\327}"
	.ascii	",\253E(\337-\334\265\223\351\177\n\261\221\224\006F\343\002@\326\363\252M\321tdXn\362?\t"
	.ascii	")\230\005h\376$\r\261\345#\257\333r\006su)\254W\264:%g\023\244p\264\206\274\274Y/"
	.ascii	"\001\303\221\266`\325Ap\036\347\327\255?\033 \205\205U3\021c\341\302\026\261(\b\001=^\245*"
	.ascii	"_\023\027\231B}\204\203\327\003}V\037\221\033\255\321\252w\276\331Hw~J\257Q..\264XT"
	.ascii	"OD\007\f\346\222Q\355\020\035Bt-N\305Bd\310\265\375\202L+5d\206v\212J\000\351\023"
	.ascii	"\177\207;\031\311\000.\273kP\334\340\220\250\343\354\237d\3366\300\267\363\354\032\236\336\230\b\004F_"
	.ascii	"\333\316/\203E\210\235sc\370k\256\311\3268\372\367\376O\267\312\r\2742^\344\274\024\210~\223s"
	.ascii	"\215\364{)\026q\003\2714h\360\324\";\321\251\306\275\226FW\025\227\3415\350\325\221\350\244\370,"
	.ascii	"\242k\320\027~H\265,k\031P9\0348\322$0\212\227\205\201\234e\327\366\244\326\221(\177oz"
	.ascii	"g\017\021\007\207\375\223mI\2658|\323\tL\335\206js\302Lj\261|\t*%Xn\275I "
	.ascii	"I\357\232j\215\375\t}\013\271=[\276`\356\360\324\277\236Q,\265!L\035\224E\305\337\252\021`"
	.ascii	"\220\370\313\002\310\320\336c\252j\377\r\312\230\320\373\231\355\266\271\375\nMb\036\0134y\267\030\316i"
	.ascii	"<\370\225\317m\222g_q\220(qa\205~|[z\217\231\363\347\241\326\340\371b\013\033\314\305o"
	.ascii	"\313y\230\262(U\357\321\222\220~\324<\256\032\335R#\237\030B\004~\022\361\001q\345:kY\025"
	.ascii	"\312$Q~\0261\377\t\337E\307\331\213\025\344\013\345V\365~\"}+)8\321\266\257A\342\244:"
	.ascii	"\242y\221?\3229'F\317\335\326\2271\022\203\377\212\024\362S\265\336\007\023\332M_{h7\"\r"
	.ascii	"\365\0053*\2778\301,\303&\351\242\217?XH\353\322IU\242\261:\bl\243\207Fn\252\3742"
	.ascii	"\337\314\207's\244\0072\370\343\023\362\b\031\343\027N\226\r\366\327\354\262\325\351\013`\3026cot"
	.ascii	"\365\232}\305\215n\305{\362\275\360\235\355\322\013>\243\344\357\"\336\024\300\252\\j\275\376\316\351'F"
	.ascii	"\034\227l\253E\363J?\037sC\231r\353\210\342m\030D\003\212jY3\223b\326~\000\027I{"
	.ascii	"\335\242S\335(\0334T?\374B\337[\220\027\252\364\370\322M\331\222\365\017}\323\214\340\017b\003\035"
	.ascii	"d\260\204\253\\\373\205-\024\274\363\211\322\020xI\f\316\025{D\334jG{\375D\370v\243+\022"
	.ascii	"T\345\264\242\3152\002\302\177\030]\021B\375\320\236\331y\324}\276\264\253.L\354h+\365\013\307\002"
	.ascii	"\341r\215E\2772\345\254\265<\267|\340h\347[\347\275\213\356\224}\317V\003:\264\376\343\227\006k"
	.ascii	"\273/\013]K\354\207\242\312\202H\007\220W\\A\\\201\320\301\036\246D\340\340\365\236@\nO3&"
	.ascii	"\300\243b\337J\360\310\266]\244m\007\357\000\360>\251\322\360IX\271\234\234\256/\033DC\177\303\034"
	.ascii	"\271\256\316\311\361Vf\327je\345\030\370\025[\0344#L\2042(\347&8h\031/wo4:"
	.ascii	"O2\307\\ZV\217P\"\251\006\345\300\304a\320\031\254E\\\333\253\030\373J1\200\003\301\thl"
	.ascii	"\310j\332\342\022Q\325\322\355Q\350\2611\003\275\351br\306\216\335F\007\226\320\305\367n\237\033\221\005"
	.ascii	"\357\352.Q\363\254ISI\313\301\034\323A\301 \215h\232\251\007\f\030$\027-K\306\321\371^U"
	.ascii	"\273\016\337\365\203\2313\301\254L,Q\217u\363\300\341\230\263\013\n\023\361,b\f'\252\371\354<k"
	.ascii	"\b\275s;\272p\2476\f\277\257\243\b\357Jb\362F\t\264\230\3777W\235t\2013\341M_g"
	.ascii	"\035\263\332;\331\366/\241\376-e\235\017\330%\007\207\224\276\232\363O\234\001C<\315\202\270P\364`"
	.ascii	"\374\202\027k\003R,\016\264\203\255l\201l\201d>\007di\331\275\334\320 \305d\001\367\235\331\023"
	.ascii	"\312\300\345!\303^K\001\242\277\031\327\311i\313O\240#\000u\030\034_N\200\254\355U\236\336\006\034"
	.ascii	"\252im\377@+\325\377\273I@\334\030\013S4\227\230M\243/\\J^-\2722}\216o\tx"
	.ascii	"\342\304>\243\326z\017\231\216\340.\2768\371\bf\025E(c\305C\241\234\r\266-\354\037\212\363L"
	.ascii	"\347\\\372\re\252\252\240\214G\265H*\236\304\371[r\003p}\314\tO\276\032\t&:\255<7"
	.ascii	"\255\273\335\211\373\250\276\361\313\256\256a\274,\313;\235\215\233\037\273\247X\217\206\246\022Q\332~T!"
	.asciz	"|\365\311\202Mc\224\2626E\223$\341\375\313\037Z\333\214A\263M\234\236\374\031DE\331\363@"
	.ascii	"\323\206Y\3759\351\375\336\f8\nQ\211,'\364\271\0311\273\007\244+\267\364M%J3\nUc"
	.ascii	"I{TrEX\272\233\340\b\304\342\372\306\005\363\215\3614\307i\372\350`zv}\252\257+\2519"
	.ascii	"7\317i\265\355\326\007e\341.\245\f\260)\204\027]\326k\353\220\000|\352Q\217\367\332\307b\352>"
	.ascii	"N'\223\346\023\307$\235u\323\333hw\205c_\232\263\212\353`URp\315\304\311e\006jCh"
	.ascii	"|\020 \350\027\323V\036e\351\n\204Dh&\305z\374\0172\306\241\340\301r\024a\221\234fsS"
	.ascii	"'?/ \3505\002\274\260u\371d\342\000\\\307\026$\214\243\325\351\244\221\371\211\267\212\366\347\266\027"
	.ascii	"WR\016\232\253\024(]\374\263\312\311\204 \217\220\312\036-[\210\365\312\257\021}\370x\246\265\264\034"
	.ascii	"\347\007\240\242b\252tk\261\307q\360\260\340\021\363#\342\013\0008\344\007W\254n\357\202-\375\300-"
	.ascii	"l\374J9k\300d\266\261_\332\230$\336\210\f4\330\312K\026\003\215O\2424t\336x\312\0133"
	.ascii	"Nt\031\021\204\377.\230$G\007+\226^i\371\373S\311\277O\301\212\305\365\034\2376\033\2761<"
	.ascii	"rB\313\371\223\274h\301\230\333\316\307\037q\270\256z\215\2544\252R\016\177\273U}~\t\301\316A"
	.ascii	"\356\212\224\bM\206\364\260o\034\272\221\356\031\334\007X\241\254\246\256\315uy\273\324bB\023a\0133"
	.ascii	"\212\200m\242\327\031\226\367m\025\236\035\236\324\037\273'\337\241\333l\303\327s}w(\037\331L\264&"
	.ascii	"\203\003sb\223\362\267\341,\212\312\353\377yRK\024\023\324\277\212w\374\332\017ar\234\024\020\353}"
	.ascii	"ut8\217GH\360Q<\313\276\234\364\274]\262U \237\331D\022\253\232\326\245\020\034l\236p,"
	.ascii	"z\356f\207j\257b\313\016\315SU\004\354\313f\265\344\013\0178\001\200X\352\342,\366\237\216\346\b"
	.ascii	"\371\362\270\n\325\t-/\337#Y\305\215!\271\254\271lvs&4\217J\365\031\3678\327;\261L"
	.ascii	"\2550\301K\nP\2554\234\324\013=I\3338\215\276\211\nP\230=\\\242\t;\272\356\207?\037/"
	.ascii	"J\266\025\345u\214\204\3678\220J\333\272\001\225\245P\033u??1\r\302\350.\256\300S\343\241\031"
	.ascii	"\275\275\226\325\315r!\264@\374\356\230CE\340\223\265\tA\264GS\261\2374\256f\002\231\323ks"
	.ascii	"\303\005\372\272`u\034}a^\345\306\240\240\341\263sd\326\300\030\227R\343\2064\f\302\021kTA"
	.ascii	"\264\2634\223P-S\205se\201`K\021\375Fu\203\\B0__\314\\\253\177\270\242\225\"A"
	.ascii	"\306\352\223\342aRe.\333\2543!\003\222Z\204k\231\000y\313u\tF\200\335Z\031\215\273`\007"
	.ascii	"\351\326~\365\210\233\311\031%\310\370m&\313\223Ss\322\n\263\0232\356\\4.-\265\353S\341\024"
	.ascii	"\212\201\346\315\027\032>A\204\240i\355\251m\025W\261\314\312F\217&\277,\362\305:\303\233\2764k"
	.ascii	"\323\362qeei\374\021zs\016SE\350\311\3065P\376\324\242\347:\343\013\323m.\266\307\271\001"
	.ascii	"\262\300x:d/\337\363|\002.\362\036\227>L\243\265\301I^\034}\354-\335\"\t\217\301\022 "
	.ascii	")\235\310Z\345U\013\210c\247\240E\037$\203\024\037l\347\302\337\3576=\350\255KNx[\257\b"
	.ascii	"K,\314\211\322\024s\342\215\027\207\242\021\275\344K\316d3\372\326(\325\030n\202\331\257\325\301#d"
	.ascii	"3%\037\210\334\2314(\266#\223w\332%\005\235\364A4g\373\335z\211\215\026:\026q\235\2672"
	.ascii	"j\263\374\355\331\370\205\314\371\345F7\217\302\274\"\315\323\345\3718\343\235\344\314->\301\373^\nH"
	.ascii	"\037\"\316B\344La\266(9\005L\314\235\031n\003\276\034\334\244\264?f\006\216\034iG\035\263$"
	.ascii	"q b\001\013\347Q\013\305\257\035\213\317\005\265\006\315\253Z\357a\260k,1\277\267\f`'\252G"
	.ascii	"\303\370\025\300\355\036T*|?i|~\376\244\021\326x\242N\023f\257\360\224\240\335\024]X[T"
	.ascii	"\341!\263\343\320\344\004b\225\036\377(zc\252;\236\275\231[\375\317\f\013q\320\310d>\334\"M"
	.ascii	"\017:\324\240^'\277g\276\356\233\b4\216\346\255.\347y\324L\023\211BTT\2722\303\371b\017"
	.ascii	"9_;\326\211e\264\374a\317\313W?j\256\\\005\372:\225\322\302\272\3766\02476\032\240\017\034"
	.ascii	"Pj\223\214\016+\bi\266\305\332\3015\240\311\3714\266\337\304T>\267o@\301+\035\233A\005@"
	.ascii	"\377=\224\"\266\004\306\322\240\263\317D\316\276\214\274x\206\200\227\363O%]\277\246\034;Oa\243\017"
	.ascii	"\360\202\276\271\275\376\003\240\220\254D:\257\301\211 \216\372T\031\221\237I\370B\253@\357\212!\272\037"
	.ascii	"\224\001{>\004W>O\177\257\332\b\356>\035\250\361\336\334\231\253\3069\310\325aw\377\023]Sl"
	.ascii	">\365\310\372H\224T\253A7\246{\232\350\366\201\001^+l}l\375tBn\310\250\312:.9"
	.ascii	"\2575\212>\3514\275L\026\350\207XD\201\007.\253\260\232\362v\2341\031;\301\n\325\344\177\341%"
	.ascii	"\247!\361v\365\177_\221\343\207\315/'2J\303&\345\033M\336/\272\314\233\211i\211\217\202\272k"
	.ascii	"v\366\004\036\327\233(\n\225\017B\326R\034\216 \253\037i4\260\330\206QQ\263\237*DQW%"
	.ascii	"\0019\376\220f\274\321\342\325z\231\240\030J\265L\324`\204\257\024i\035\227\344{k\177OP\235U"
	.ascii	"\375f\322\366\347\221H\234\033x\007\003\233\241D\007;\342a`\035\2178\210\016\325K5\243\246>\022"
	.ascii	"\325T\353\263x\203s\247|<U\245f\323i\035\272\000(\371b\317&\n\0272~\200\325\022\253\001"
	.ascii	"\226-\343A\220\030\215\021HX1\330\302\343\355\271\331E2\330qB\253\036T\241\030\311\342a9J"
	.ascii	"\036?#\363D\326'\003\026\360\3744\016&\232Iy\271\332\362\026\247\265\203\037\021\324\233\255\356\254h"
	.ascii	"\240\273\346\370\340;\334q\n\343\377~4\370\316\326jG:\341_B\222\251c\267\035\373\343\274\326,"
	.ascii	"\020\302\327\363\016\311\2648\f\004\255\267$n\2160#>\347\267\361\331`8\227\365\b\265\325`WY"
	.ascii	"\220'\002\375\353\313*\210`W\021\304\0053\257\211\364s4}\343\222\364e+ZQT\337\305\262,"
	.ascii	"\227c\252\004\341\277)a\313\374\247\244\b\000\226\217X\224\220}\211\300\213?\251\221\262\334>\244\237p"
	.ascii	"\312*\375c\214]\n\353\377Ni.f\301+\322:\260\313\370n\363#'\037\023\310\360\354)\360p"
	.ascii	"\271\260\020^\252\257j*\251\032\004\357p\243\360x\037\326:\252w\373>w\341\331K\247\242\245\354D"
	.ascii	"3>\355.\263\007\023F\347\201U\2443/\004\256f\003_\031\323ID\311XH1l\212]}\013"
	.ascii	"C\325\225{2H\324%\035\0174\243\000\203\323p+\305\341`\034S\034\336\344\351},Q$\"'"
	.ascii	"\374u\251B\212\273{\277X\243\255\226w9\\\214H\252\355\315o\307\177\342\246 \274\366\327_s\031"
	.ascii	".4\305I\257\222\274\032\320\372\346\262\021\330\356\377)N\310\374\215\214\242\357C\305L\244\030\337\265\021"
	.ascii	"fB\310B\320\220\253\343~T\031\177\017\216\204\353\271\227\244e\320\241\003%_\211\337\221\021\221\357\017"
	.size	k25519Precomp, 24576

	.type	d,@object                       # @d
	.section	.rodata,"a",@progbits
	.p2align	3, 0x0
d:
	.quad	929955233495203                 # 0x34dca135978a3
	.quad	466365720129213                 # 0x1a8283b156ebd
	.quad	1662059464998953                # 0x5e7a26001c029
	.quad	2033849074728123                # 0x739c663a03cbb
	.quad	1442794654840575                # 0x52036cee2b6ff
	.size	d, 40

	.type	sqrtm1,@object                  # @sqrtm1
	.p2align	3, 0x0
sqrtm1:
	.quad	1718705420411056                # 0x61b274a0ea0b0
	.quad	234908883556509                 # 0xd5a5fc8f189d
	.quad	2233514472574048                # 0x7ef5e9cbd0c60
	.quad	2117202627021982                # 0x78595a6804c9e
	.quad	765476049583133                 # 0x2b8324804fc1d
	.size	sqrtm1, 40

	.type	d2,@object                      # @d2
	.p2align	3, 0x0
d2:
	.quad	1859910466990425                # 0x69b9426b2f159
	.quad	932731440258426                 # 0x35050762add7a
	.quad	1072319116312658                # 0x3cf44c0038052
	.quad	1815898335770999                # 0x6738cc7407977
	.quad	633789495995903                 # 0x2406d9dc56dff
	.size	d2, 40

	.type	private_key,@object             # @private_key
	.section	.secsep.secret,"aw",@progbits
	.globl	private_key
	.p2align	4, 0x90
private_key:
	.ascii	"\245F\343k\360R|\235;\026\025K\202F^\335b\024L\n\301\374Z\030Pj\"D\272D\232\304"
	.size	private_key, 32

	.type	peer_public_value,@object       # @peer_public_value
	.section	.secsep.public,"aw",@progbits
	.globl	peer_public_value
	.p2align	4, 0x90
peer_public_value:
	.ascii	"\346\333hgX00\3335\224\301\244$\261_|rf$\354&\2635;\020\251\003\246\320\253\034L"
	.size	peer_public_value, 32

	.type	out_shared_key,@object          # @out_shared_key
	.section	.secsep.secret,"aw",@progbits
	.globl	out_shared_key
	.p2align	4, 0x90
out_shared_key:
	.zero	32
	.size	out_shared_key, 32

	.type	.L.str.9,@object                # @.str.9
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.9:
	.asciz	"NA"
	.size	.L.str.9, 3

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"invalid library (0)"
	.size	.L.str.10, 20

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"NONE"
	.size	.L.str.11, 5

	.type	.L.str.12,@object               # @.str.12
.L.str.12:
	.asciz	"NONE_LIB"
	.size	.L.str.12, 9

	.type	.L.str.13,@object               # @.str.13
.L.str.13:
	.asciz	"system library"
	.size	.L.str.13, 15

	.type	.L.str.14,@object               # @.str.14
.L.str.14:
	.asciz	"SYS"
	.size	.L.str.14, 4

	.type	.L.str.15,@object               # @.str.15
.L.str.15:
	.asciz	"SYS_LIB"
	.size	.L.str.15, 8

	.type	.L.str.16,@object               # @.str.16
.L.str.16:
	.asciz	"bignum routines"
	.size	.L.str.16, 16

	.type	.L.str.17,@object               # @.str.17
.L.str.17:
	.asciz	"BN"
	.size	.L.str.17, 3

	.type	.L.str.18,@object               # @.str.18
.L.str.18:
	.asciz	"BN_LIB"
	.size	.L.str.18, 7

	.type	.L.str.19,@object               # @.str.19
.L.str.19:
	.asciz	"RSA routines"
	.size	.L.str.19, 13

	.type	.L.str.20,@object               # @.str.20
.L.str.20:
	.asciz	"RSA"
	.size	.L.str.20, 4

	.type	.L.str.21,@object               # @.str.21
.L.str.21:
	.asciz	"RSA_LIB"
	.size	.L.str.21, 8

	.type	.L.str.22,@object               # @.str.22
.L.str.22:
	.asciz	"Diffie-Hellman routines"
	.size	.L.str.22, 24

	.type	.L.str.23,@object               # @.str.23
.L.str.23:
	.asciz	"DH"
	.size	.L.str.23, 3

	.type	.L.str.24,@object               # @.str.24
.L.str.24:
	.asciz	"DH_LIB"
	.size	.L.str.24, 7

	.type	.L.str.25,@object               # @.str.25
.L.str.25:
	.asciz	"public key routines"
	.size	.L.str.25, 20

	.type	.L.str.26,@object               # @.str.26
.L.str.26:
	.asciz	"EVP"
	.size	.L.str.26, 4

	.type	.L.str.27,@object               # @.str.27
.L.str.27:
	.asciz	"EVP_LIB"
	.size	.L.str.27, 8

	.type	.L.str.28,@object               # @.str.28
.L.str.28:
	.asciz	"memory buffer routines"
	.size	.L.str.28, 23

	.type	.L.str.29,@object               # @.str.29
.L.str.29:
	.asciz	"BUF"
	.size	.L.str.29, 4

	.type	.L.str.30,@object               # @.str.30
.L.str.30:
	.asciz	"BUF_LIB"
	.size	.L.str.30, 8

	.type	.L.str.31,@object               # @.str.31
.L.str.31:
	.asciz	"object identifier routines"
	.size	.L.str.31, 27

	.type	.L.str.32,@object               # @.str.32
.L.str.32:
	.asciz	"OBJ"
	.size	.L.str.32, 4

	.type	.L.str.33,@object               # @.str.33
.L.str.33:
	.asciz	"OBJ_LIB"
	.size	.L.str.33, 8

	.type	.L.str.34,@object               # @.str.34
.L.str.34:
	.asciz	"PEM routines"
	.size	.L.str.34, 13

	.type	.L.str.35,@object               # @.str.35
.L.str.35:
	.asciz	"PEM"
	.size	.L.str.35, 4

	.type	.L.str.36,@object               # @.str.36
.L.str.36:
	.asciz	"PEM_LIB"
	.size	.L.str.36, 8

	.type	.L.str.37,@object               # @.str.37
.L.str.37:
	.asciz	"DSA routines"
	.size	.L.str.37, 13

	.type	.L.str.38,@object               # @.str.38
.L.str.38:
	.asciz	"DSA"
	.size	.L.str.38, 4

	.type	.L.str.39,@object               # @.str.39
.L.str.39:
	.asciz	"DSA_LIB"
	.size	.L.str.39, 8

	.type	.L.str.40,@object               # @.str.40
.L.str.40:
	.asciz	"X.509 certificate routines"
	.size	.L.str.40, 27

	.type	.L.str.41,@object               # @.str.41
.L.str.41:
	.asciz	"X509"
	.size	.L.str.41, 5

	.type	.L.str.42,@object               # @.str.42
.L.str.42:
	.asciz	"X509_LIB"
	.size	.L.str.42, 9

	.type	.L.str.43,@object               # @.str.43
.L.str.43:
	.asciz	"ASN.1 encoding routines"
	.size	.L.str.43, 24

	.type	.L.str.44,@object               # @.str.44
.L.str.44:
	.asciz	"ASN1"
	.size	.L.str.44, 5

	.type	.L.str.45,@object               # @.str.45
.L.str.45:
	.asciz	"ASN1_LIB"
	.size	.L.str.45, 9

	.type	.L.str.46,@object               # @.str.46
.L.str.46:
	.asciz	"configuration file routines"
	.size	.L.str.46, 28

	.type	.L.str.47,@object               # @.str.47
.L.str.47:
	.asciz	"CONF"
	.size	.L.str.47, 5

	.type	.L.str.48,@object               # @.str.48
.L.str.48:
	.asciz	"CONF_LIB"
	.size	.L.str.48, 9

	.type	.L.str.49,@object               # @.str.49
.L.str.49:
	.asciz	"common libcrypto routines"
	.size	.L.str.49, 26

	.type	.L.str.50,@object               # @.str.50
.L.str.50:
	.asciz	"CRYPTO"
	.size	.L.str.50, 7

	.type	.L.str.51,@object               # @.str.51
.L.str.51:
	.asciz	"CRYPTO_LIB"
	.size	.L.str.51, 11

	.type	.L.str.52,@object               # @.str.52
.L.str.52:
	.asciz	"elliptic curve routines"
	.size	.L.str.52, 24

	.type	.L.str.53,@object               # @.str.53
.L.str.53:
	.asciz	"EC"
	.size	.L.str.53, 3

	.type	.L.str.54,@object               # @.str.54
.L.str.54:
	.asciz	"EC_LIB"
	.size	.L.str.54, 7

	.type	.L.str.55,@object               # @.str.55
.L.str.55:
	.asciz	"SSL routines"
	.size	.L.str.55, 13

	.type	.L.str.56,@object               # @.str.56
.L.str.56:
	.asciz	"SSL"
	.size	.L.str.56, 4

	.type	.L.str.57,@object               # @.str.57
.L.str.57:
	.asciz	"SSL_LIB"
	.size	.L.str.57, 8

	.type	.L.str.58,@object               # @.str.58
.L.str.58:
	.asciz	"BIO routines"
	.size	.L.str.58, 13

	.type	.L.str.59,@object               # @.str.59
.L.str.59:
	.asciz	"BIO"
	.size	.L.str.59, 4

	.type	.L.str.60,@object               # @.str.60
.L.str.60:
	.asciz	"BIO_LIB"
	.size	.L.str.60, 8

	.type	.L.str.61,@object               # @.str.61
.L.str.61:
	.asciz	"PKCS7 routines"
	.size	.L.str.61, 15

	.type	.L.str.62,@object               # @.str.62
.L.str.62:
	.asciz	"PKCS7"
	.size	.L.str.62, 6

	.type	.L.str.63,@object               # @.str.63
.L.str.63:
	.asciz	"PKCS7_LIB"
	.size	.L.str.63, 10

	.type	.L.str.64,@object               # @.str.64
.L.str.64:
	.asciz	"PKCS8 routines"
	.size	.L.str.64, 15

	.type	.L.str.65,@object               # @.str.65
.L.str.65:
	.asciz	"PKCS8"
	.size	.L.str.65, 6

	.type	.L.str.66,@object               # @.str.66
.L.str.66:
	.asciz	"PKCS8_LIB"
	.size	.L.str.66, 10

	.type	.L.str.67,@object               # @.str.67
.L.str.67:
	.asciz	"X509 V3 routines"
	.size	.L.str.67, 17

	.type	.L.str.68,@object               # @.str.68
.L.str.68:
	.asciz	"X509V3"
	.size	.L.str.68, 7

	.type	.L.str.69,@object               # @.str.69
.L.str.69:
	.asciz	"X509V3_LIB"
	.size	.L.str.69, 11

	.type	.L.str.70,@object               # @.str.70
.L.str.70:
	.asciz	"random number generator"
	.size	.L.str.70, 24

	.type	.L.str.71,@object               # @.str.71
.L.str.71:
	.asciz	"RAND"
	.size	.L.str.71, 5

	.type	.L.str.72,@object               # @.str.72
.L.str.72:
	.asciz	"RAND_LIB"
	.size	.L.str.72, 9

	.type	.L.str.73,@object               # @.str.73
.L.str.73:
	.asciz	"ENGINE routines"
	.size	.L.str.73, 16

	.type	.L.str.74,@object               # @.str.74
.L.str.74:
	.asciz	"ENGINE"
	.size	.L.str.74, 7

	.type	.L.str.75,@object               # @.str.75
.L.str.75:
	.asciz	"ENGINE_LIB"
	.size	.L.str.75, 11

	.type	.L.str.76,@object               # @.str.76
.L.str.76:
	.asciz	"OCSP routines"
	.size	.L.str.76, 14

	.type	.L.str.77,@object               # @.str.77
.L.str.77:
	.asciz	"OCSP"
	.size	.L.str.77, 5

	.type	.L.str.78,@object               # @.str.78
.L.str.78:
	.asciz	"OCSP_LIB"
	.size	.L.str.78, 9

	.type	.L.str.79,@object               # @.str.79
.L.str.79:
	.asciz	"UI routines"
	.size	.L.str.79, 12

	.type	.L.str.80,@object               # @.str.80
.L.str.80:
	.asciz	"UI"
	.size	.L.str.80, 3

	.type	.L.str.81,@object               # @.str.81
.L.str.81:
	.asciz	"UI_LIB"
	.size	.L.str.81, 7

	.type	.L.str.82,@object               # @.str.82
.L.str.82:
	.asciz	"COMP routines"
	.size	.L.str.82, 14

	.type	.L.str.83,@object               # @.str.83
.L.str.83:
	.asciz	"COMP"
	.size	.L.str.83, 5

	.type	.L.str.84,@object               # @.str.84
.L.str.84:
	.asciz	"COMP_LIB"
	.size	.L.str.84, 9

	.type	.L.str.85,@object               # @.str.85
.L.str.85:
	.asciz	"ECDSA routines"
	.size	.L.str.85, 15

	.type	.L.str.86,@object               # @.str.86
.L.str.86:
	.asciz	"ECDSA"
	.size	.L.str.86, 6

	.type	.L.str.87,@object               # @.str.87
.L.str.87:
	.asciz	"ECDSA_LIB"
	.size	.L.str.87, 10

	.type	.L.str.88,@object               # @.str.88
.L.str.88:
	.asciz	"ECDH routines"
	.size	.L.str.88, 14

	.type	.L.str.89,@object               # @.str.89
.L.str.89:
	.asciz	"ECDH"
	.size	.L.str.89, 5

	.type	.L.str.90,@object               # @.str.90
.L.str.90:
	.asciz	"ECDH_LIB"
	.size	.L.str.90, 9

	.type	.L.str.91,@object               # @.str.91
.L.str.91:
	.asciz	"HMAC routines"
	.size	.L.str.91, 14

	.type	.L.str.92,@object               # @.str.92
.L.str.92:
	.asciz	"HMAC"
	.size	.L.str.92, 5

	.type	.L.str.93,@object               # @.str.93
.L.str.93:
	.asciz	"HMAC_LIB"
	.size	.L.str.93, 9

	.type	.L.str.94,@object               # @.str.94
.L.str.94:
	.asciz	"Digest functions"
	.size	.L.str.94, 17

	.type	.L.str.95,@object               # @.str.95
.L.str.95:
	.asciz	"DIGEST"
	.size	.L.str.95, 7

	.type	.L.str.96,@object               # @.str.96
.L.str.96:
	.asciz	"DIGEST_LIB"
	.size	.L.str.96, 11

	.type	.L.str.97,@object               # @.str.97
.L.str.97:
	.asciz	"Cipher functions"
	.size	.L.str.97, 17

	.type	.L.str.98,@object               # @.str.98
.L.str.98:
	.asciz	"CIPHER"
	.size	.L.str.98, 7

	.type	.L.str.99,@object               # @.str.99
.L.str.99:
	.asciz	"CIPHER_LIB"
	.size	.L.str.99, 11

	.type	.L.str.100,@object              # @.str.100
.L.str.100:
	.asciz	"HKDF functions"
	.size	.L.str.100, 15

	.type	.L.str.101,@object              # @.str.101
.L.str.101:
	.asciz	"HKDF"
	.size	.L.str.101, 5

	.type	.L.str.102,@object              # @.str.102
.L.str.102:
	.asciz	"HKDF_LIB"
	.size	.L.str.102, 9

	.type	.L.str.103,@object              # @.str.103
.L.str.103:
	.asciz	"Trust Token functions"
	.size	.L.str.103, 22

	.type	.L.str.104,@object              # @.str.104
.L.str.104:
	.asciz	"TRUST_TOKEN"
	.size	.L.str.104, 12

	.type	.L.str.105,@object              # @.str.105
.L.str.105:
	.asciz	"TRUST_TOKEN_LIB"
	.size	.L.str.105, 16

	.type	.L.str.106,@object              # @.str.106
.L.str.106:
	.asciz	"User defined functions"
	.size	.L.str.106, 23

	.type	.L.str.107,@object              # @.str.107
.L.str.107:
	.asciz	"USER"
	.size	.L.str.107, 5

	.type	.L.str.108,@object              # @.str.108
.L.str.108:
	.asciz	"USER_LIB"
	.size	.L.str.108, 9

	.type	.L.str.109,@object              # @.str.109
.L.str.109:
	.asciz	"MALLOC_FAILURE"
	.size	.L.str.109, 15

	.type	.L.str.110,@object              # @.str.110
.L.str.110:
	.asciz	"malloc failure"
	.size	.L.str.110, 15

	.type	.L.str.111,@object              # @.str.111
.L.str.111:
	.asciz	"SHOULD_NOT_HAVE_BEEN_CALLED"
	.size	.L.str.111, 28

	.type	.L.str.112,@object              # @.str.112
.L.str.112:
	.asciz	"function should not have been called"
	.size	.L.str.112, 37

	.type	.L.str.113,@object              # @.str.113
.L.str.113:
	.asciz	"PASSED_NULL_PARAMETER"
	.size	.L.str.113, 22

	.type	.L.str.114,@object              # @.str.114
.L.str.114:
	.asciz	"passed a null parameter"
	.size	.L.str.114, 24

	.type	.L.str.115,@object              # @.str.115
.L.str.115:
	.asciz	"INTERNAL_ERROR"
	.size	.L.str.115, 15

	.type	.L.str.116,@object              # @.str.116
.L.str.116:
	.asciz	"internal error"
	.size	.L.str.116, 15

	.type	.L.str.117,@object              # @.str.117
.L.str.117:
	.asciz	"OVERFLOW"
	.size	.L.str.117, 9

	.type	.L.str.118,@object              # @.str.118
.L.str.118:
	.asciz	"overflow"
	.size	.L.str.118, 9

	.type	K512,@object                    # @K512
	.section	.secsep.public.ro,"a",@progbits
	.p2align	4, 0x0
K512:
	.quad	4794697086780616226             # 0x428a2f98d728ae22
	.quad	8158064640168781261             # 0x7137449123ef65cd
	.quad	-5349999486874862801            # 0xb5c0fbcfec4d3b2f
	.quad	-1606136188198331460            # 0xe9b5dba58189dbbc
	.quad	4131703408338449720             # 0x3956c25bf348b538
	.quad	6480981068601479193             # 0x59f111f1b605d019
	.quad	-7908458776815382629            # 0x923f82a4af194f9b
	.quad	-6116909921290321640            # 0xab1c5ed5da6d8118
	.quad	-2880145864133508542            # 0xd807aa98a3030242
	.quad	1334009975649890238             # 0x12835b0145706fbe
	.quad	2608012711638119052             # 0x243185be4ee4b28c
	.quad	6128411473006802146             # 0x550c7dc3d5ffb4e2
	.quad	8268148722764581231             # 0x72be5d74f27b896f
	.quad	-9160688886553864527            # 0x80deb1fe3b1696b1
	.quad	-7215885187991268811            # 0x9bdc06a725c71235
	.quad	-4495734319001033068            # 0xc19bf174cf692694
	.quad	-1973867731355612462            # 0xe49b69c19ef14ad2
	.quad	-1171420211273849373            # 0xefbe4786384f25e3
	.quad	1135362057144423861             # 0xfc19dc68b8cd5b5
	.quad	2597628984639134821             # 0x240ca1cc77ac9c65
	.quad	3308224258029322869             # 0x2de92c6f592b0275
	.quad	5365058923640841347             # 0x4a7484aa6ea6e483
	.quad	6679025012923562964             # 0x5cb0a9dcbd41fbd4
	.quad	8573033837759648693             # 0x76f988da831153b5
	.quad	-7476448914759557205            # 0x983e5152ee66dfab
	.quad	-6327057829258317296            # 0xa831c66d2db43210
	.quad	-5763719355590565569            # 0xb00327c898fb213f
	.quad	-4658551843659510044            # 0xbf597fc7beef0ee4
	.quad	-4116276920077217854            # 0xc6e00bf33da88fc2
	.quad	-3051310485924567259            # 0xd5a79147930aa725
	.quad	489312712824947311              # 0x6ca6351e003826f
	.quad	1452737877330783856             # 0x142929670a0e6e70
	.quad	2861767655752347644             # 0x27b70a8546d22ffc
	.quad	3322285676063803686             # 0x2e1b21385c26c926
	.quad	5560940570517711597             # 0x4d2c6dfc5ac42aed
	.quad	5996557281743188959             # 0x53380d139d95b3df
	.quad	7280758554555802590             # 0x650a73548baf63de
	.quad	8532644243296465576             # 0x766a0abb3c77b2a8
	.quad	-9096487096722542874            # 0x81c2c92e47edaee6
	.quad	-7894198246740708037            # 0x92722c851482353b
	.quad	-6719396339535248540            # 0xa2bfe8a14cf10364
	.quad	-6333637450476146687            # 0xa81a664bbc423001
	.quad	-4446306890439682159            # 0xc24b8b70d0f89791
	.quad	-4076793802049405392            # 0xc76c51a30654be30
	.quad	-3345356375505022440            # 0xd192e819d6ef5218
	.quad	-2983346525034927856            # 0xd69906245565a910
	.quad	-860691631967231958             # 0xf40e35855771202a
	.quad	1182934255886127544             # 0x106aa07032bbd1b8
	.quad	1847814050463011016             # 0x19a4c116b8d2d0c8
	.quad	2177327727835720531             # 0x1e376c085141ab53
	.quad	2830643537854262169             # 0x2748774cdf8eeb99
	.quad	3796741975233480872             # 0x34b0bcb5e19b48a8
	.quad	4115178125766777443             # 0x391c0cb3c5c95a63
	.quad	5681478168544905931             # 0x4ed8aa4ae3418acb
	.quad	6601373596472566643             # 0x5b9cca4f7763e373
	.quad	7507060721942968483             # 0x682e6ff3d6b2b8a3
	.quad	8399075790359081724             # 0x748f82ee5defb2fc
	.quad	8693463985226723168             # 0x78a5636f43172f60
	.quad	-8878714635349349518            # 0x84c87814a1f0ab72
	.quad	-8302665154208450068            # 0x8cc702081a6439ec
	.quad	-8016688836872298968            # 0x90befffa23631e28
	.quad	-6606660893046293015            # 0xa4506cebde82bde9
	.quad	-4685533653050689259            # 0xbef9a3f7b2c67915
	.quad	-4147400797238176981            # 0xc67178f2e372532b
	.quad	-3880063495543823972            # 0xca273eceea26619c
	.quad	-3348786107499101689            # 0xd186b8c721c0c207
	.quad	-1523767162380948706            # 0xeada7dd6cde0eb1e
	.quad	-757361751448694408             # 0xf57d4f7fee6ed178
	.quad	500013540394364858              # 0x6f067aa72176fba
	.quad	748580250866718886              # 0xa637dc5a2c898a6
	.quad	1242879168328830382             # 0x113f9804bef90dae
	.quad	1977374033974150939             # 0x1b710b35131c471b
	.quad	2944078676154940804             # 0x28db77f523047d84
	.quad	3659926193048069267             # 0x32caab7b40c72493
	.quad	4368137639120453308             # 0x3c9ebe0a15c9bebc
	.quad	4836135668995329356             # 0x431d67c49c100d4c
	.quad	5532061633213252278             # 0x4cc5d4becb3e42b6
	.quad	6448918945643986474             # 0x597f299cfc657e2a
	.quad	6902733635092675308             # 0x5fcb6fab3ad6faec
	.quad	7801388544844847127             # 0x6c44198c4a475817
	.size	K512, 640

	.type	Bi,@object                      # @Bi
	.section	.rodata,"a",@progbits
	.p2align	4, 0x0
Bi:
	.quad	1288382639258501                # 0x493c6f58c3b85
	.quad	245678601348599                 # 0xdf7181c325f7
	.quad	269427782077623                 # 0xf50b0b3e4cb7
	.quad	1462984067271730                # 0x5329385a44c32
	.quad	137412439391563                 # 0x7cf9d3a33d4b
	.quad	62697248952638                  # 0x3905d740913e
	.quad	204681361388450                 # 0xba2817d673a2
	.quad	631292143396476                 # 0x23e2827f4e67c
	.quad	338455783676468                 # 0x133d2e0c21a34
	.quad	1213667448819585                # 0x44fd2f9298f81
	.quad	301289933810280                 # 0x11205877aaa68
	.quad	1259582250014073                # 0x479955893d579
	.quad	1422107436869536                # 0x50d66309b67a0
	.quad	796239922652654                 # 0x2d42d0dbee5ee
	.quad	1953934009299142                # 0x6f117b689f0c6
	.quad	1601611775252272                # 0x5b0a84cee9730
	.quad	1720807796594148                # 0x61d10c97155e4
	.quad	1132070835939856                # 0x4059cc8096a10
	.quad	1260455018889551                # 0x47a608da8014f
	.quad	2147779492816911                # 0x7a164e1b9a80f
	.quad	316559037616741                 # 0x11fe8a4fcd265
	.quad	2177824224946892                # 0x7bcb8374faacc
	.quad	1459442586438991                # 0x52f5af4ef4d4f
	.quad	1461528397712656                # 0x5314098f98d10
	.quad	751590696113597                 # 0x2ab91587555bd
	.quad	1850748884277385                # 0x6933f0dd0d889
	.quad	1200145853858453                # 0x44386bb4c4295
	.quad	1068094770532492                # 0x3cb6d3162508c
	.quad	672251375690438                 # 0x26368b872a2c6
	.quad	1586055907191707                # 0x5a2826af12b9b
	.quad	769950342298419                 # 0x2bc4408a5bb33
	.quad	132954430919746                 # 0x78ebdda05442
	.quad	844085933195555                 # 0x2ffb112354123
	.quad	974092374476333                 # 0x375ee8df5862d
	.quad	726076285546016                 # 0x2945ccf146e20
	.quad	425251763115706                 # 0x182c3a447d6ba
	.quad	608463272472562                 # 0x22964e536eff2
	.quad	442562545713235                 # 0x192821f540053
	.quad	837766094556764                 # 0x2f9f19e788e5c
	.quad	374555092627893                 # 0x154a7e73eb1b5
	.quad	1086255230780037                # 0x3dbf1812a8285
	.quad	274979815921559                 # 0xfa17ba3f9797
	.quad	1960002765731872                # 0x6f69cb49c3820
	.quad	929474102396301                 # 0x34d5a0db3858d
	.quad	1190409889297339                # 0x43aabe696b3bb
	.quad	665000864555967                 # 0x25cd0944ea3bf
	.quad	2065379846933859                # 0x75673b81a4d63
	.quad	370231110385876                 # 0x150b925d1c0d4
	.quad	350988370788628                 # 0x13f38d9294114
	.quad	1233371373142985                # 0x461bea69283c9
	.quad	2019367628972465                # 0x72c9aaa3221b1
	.quad	676711900706637                 # 0x267774474f74d
	.quad	110710997811333                 # 0x64b0e9b28085
	.quad	1108646842542025                # 0x3f04ef53b27c9
	.quad	517791959672113                 # 0x1d6edd5d2e531
	.quad	965130719900578                 # 0x36dc801b8b3a2
	.quad	247011430587952                 # 0xe0a7d4935e30
	.quad	526356006571389                 # 0x1deb7cecc0d7d
	.quad	91986625355052                  # 0x53a94e20dd2c
	.quad	2157223321444601                # 0x7a9fbb1c6a0f9
	.quad	1802695059465007                # 0x6678aa6a8632f
	.quad	1664899123557221                # 0x5ea3788d8b365
	.quad	593559490740857                 # 0x21bd6d6994279
	.quad	2160434469266659                # 0x7ace75919e4e3
	.quad	927570450755031                 # 0x34b9ed338add7
	.quad	1725674970513508                # 0x6217e039d8064
	.quad	1933645953859181                # 0x6dea408337e6d
	.quad	1542344539275782                # 0x57ac112628206
	.quad	1767788773573747                # 0x647cb65e30473
	.quad	1297447965928905                # 0x49c05a51fadc9
	.quad	1381809363726107                # 0x4e8bf9045af1b
	.quad	1430341051343062                # 0x514e33a45e0d6
	.quad	2061843536018959                # 0x7533c5b8bfe0f
	.quad	1551778050872521                # 0x583557b7e14c9
	.quad	2036394857967624                # 0x73c172021b008
	.quad	1970894096313054                # 0x700848a802ade
	.quad	528066325833207                 # 0x1e04605c4e5f7
	.quad	1619374932191227                # 0x5c0d01b9767fb
	.quad	2207306624415883                # 0x7d7889f42388b
	.quad	1169170329061080                # 0x4275aae2546d8
	.quad	2070390218572616                # 0x75b0249864348
	.quad	1458919061857835                # 0x52ee11070262b
	.quad	624171843017421                 # 0x237ae54fb5acd
	.quad	1055332792707765                # 0x3bfd1d03aaab5
	.quad	433987520732508                 # 0x18ab598029d5c
	.quad	893653801273833                 # 0x32cc5fd6089e9
	.quad	1168026499324677                # 0x426505c949b05
	.quad	1242553501121234                # 0x46a18880c7ad2
	.quad	1306366254304474                # 0x4a4221888ccda
	.quad	1086752658510815                # 0x3dc65522b53df
	.quad	213454002618221                 # 0xc222a2007f6d
	.quad	939771523987438                 # 0x356b79bdb77ee
	.quad	1159882208056014                # 0x41ee81efe12ce
	.quad	317388369627517                 # 0x120a9bd07097d
	.quad	621213314200687                 # 0x234fd7eec346f
	.quad	1971678598905747                # 0x7013b327fbf93
	.quad	338026507889165                 # 0x1336eeded6a0d
	.quad	762398079972271                 # 0x2b565a2bbf3af
	.quad	655096486107477                 # 0x253ce89591955
	.quad	42299032696322                  # 0x267882d17602
	.quad	177130678690680                 # 0xa119732ea378
	.quad	1754759263300204                # 0x63bf1ba8e2a6c
	.quad	1864311296286618                # 0x69f94cc90df9a
	.quad	1180675631479880                # 0x431d1779bfc48
	.quad	1292726903152791                # 0x497ba6fdaa097
	.quad	1913163449625248                # 0x6cc0313cfeaa0
	.quad	460779200291993                 # 0x1a313848da499
	.quad	2193883288642314                # 0x7cb534219230a
	.quad	1008900146920800                # 0x39596dedefd60
	.quad	1721983679009502                # 0x61e22917f12de
	.quad	1070401523076875                # 0x3cd86468ccf0b
	.quad	1272492007800961                # 0x48553221ac081
	.quad	1910153608563310                # 0x6c9464b4e0a6e
	.quad	2075579521696771                # 0x75fba84180403
	.quad	1191169788841221                # 0x43b5cd4218d05
	.quad	692896803108118                 # 0x2762f9bd0b516
	.quad	500174642072499                 # 0x1c6e7fbddcbb3
	.quad	2068223309439677                # 0x75909c3ace2bd
	.quad	1162190621851337                # 0x42101972d3ec9
	.quad	1426986007309901                # 0x511d61210ae4d
	.size	Bi, 960

	.type	.Lreltable.ERR_reason_symbol_name,@object # @reltable.ERR_reason_symbol_name
	.p2align	2, 0x0
.Lreltable.ERR_reason_symbol_name:
	.long	.L.str.109-.Lreltable.ERR_reason_symbol_name
	.long	.L.str.111-.Lreltable.ERR_reason_symbol_name
	.long	.L.str.113-.Lreltable.ERR_reason_symbol_name
	.long	.L.str.115-.Lreltable.ERR_reason_symbol_name
	.long	.L.str.117-.Lreltable.ERR_reason_symbol_name
	.size	.Lreltable.ERR_reason_symbol_name, 20

	.type	.Lswitch.table.ERR_error_string_n,@object # @switch.table.ERR_error_string_n
	.section	.data.rel.ro,"aw",@progbits
	.p2align	3, 0x0
.Lswitch.table.ERR_error_string_n:
	.quad	.L.str.110
	.quad	.L.str.112
	.quad	.L.str.114
	.quad	.L.str.116
	.quad	.L.str.118
	.size	.Lswitch.table.ERR_error_string_n, 40

	.weak	OPENSSL_memory_alloc
	.weak	OPENSSL_memory_free
	.weak	sdallocx
	.weak	OPENSSL_memory_get_size
	.ident	"clang version 16.0.6 (https://github.com/llvm/llvm-project.git 7cbf1a2591520c2491aa35339f227775f4d3adf6)"
	.section	".note.GNU-stack","",@progbits
