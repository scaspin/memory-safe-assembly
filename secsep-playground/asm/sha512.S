	.text
	.file	"bench_sha512.c"
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
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushq	%rbp
	pushq	%r14
	pushq	%rbx
	xorl	%ebp, %ebp
	leaq	message(%rip), %rbx
	leaq	out(%rip), %r14
	.p2align	4, 0x90
.LBB102_1:                              # =>This Inner Loop Header: Depth=1
	movl	%ebp, %eax
	andl	$15, %eax
	movl	$256, %esi                      # imm = 0x100
	subl	%eax, %esi
	movq	%rbx, %rdi
	movq	%r14, %rdx
	callq	SHA512
	incl	%ebp
	cmpl	$100, %ebp
	jne	.LBB102_1
# %bb.2:
	xorl	%eax, %eax
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end102:
	.size	main, .Lfunc_end102-main
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
	je	.LBB103_13
# %bb.1:
	movq	%rdi, %rbx
	leaq	g_destructors_lock(%rip), %rdi
	callq	pthread_mutex_lock@PLT
	testl	%eax, %eax
	jne	.LBB103_13
# %bb.2:
	movq	g_destructors(%rip), %rbp
	movq	g_destructors+8(%rip), %r13
	movq	g_destructors+16(%rip), %r12
	movq	g_destructors+24(%rip), %r15
	movq	g_destructors+32(%rip), %r14
	leaq	g_destructors_lock(%rip), %rdi
	callq	pthread_mutex_unlock@PLT
	testq	%rbp, %rbp
	je	.LBB103_4
# %bb.3:
	movq	(%rbx), %rdi
	callq	*%rbp
.LBB103_4:
	testq	%r13, %r13
	je	.LBB103_6
# %bb.5:
	movq	8(%rbx), %rdi
	callq	*%r13
.LBB103_6:
	testq	%r12, %r12
	je	.LBB103_8
# %bb.7:
	movq	16(%rbx), %rdi
	callq	*%r12
.LBB103_8:
	testq	%r15, %r15
	je	.LBB103_10
# %bb.9:
	movq	24(%rbx), %rdi
	callq	*%r15
.LBB103_10:
	testq	%r14, %r14
	je	.LBB103_12
# %bb.11:
	movq	32(%rbx), %rdi
	callq	*%r14
.LBB103_12:
	movq	%rbx, %rdi
	callq	free@PLT
.LBB103_13:
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end103:
	.size	thread_local_destructor, .Lfunc_end103-thread_local_destructor
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function err_state_free
.LCPI104_0:
	.zero	16
	.text
	.p2align	4, 0x90
	.type	err_state_free,@function
err_state_free:                         # @err_state_free
# %bb.0:
	testq	%rdi, %rdi
	je	.LBB104_2
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
.LBB104_2:
	retq
.Lfunc_end104:
	.size	err_state_free, .Lfunc_end104-err_state_free
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

	.type	message,@object                 # @message
	.section	.secsep.secret,"aw",@progbits
	.globl	message
	.p2align	4, 0x90
message:
	.ascii	"\006\343\024\201\017\353`\233\331\021\372X\376m\347H\364\356\330|\005\030\375\351\211\022\240\023\340\353\2703\364\356\330|\005\030\375\351x+`\255D\326`\027\331\021\372X\376m\347H\364\356\330|\005\030\375\351\211\022\240\023\340\353\2703<\b\035\267\370\255\235\253\361\276\342\0253)\360\206^\002c\252\005\264\364\341^\002c\252\005\264\364\341x+`\255D\326`\027\331\021\372X\376m\347H<\b\035\267\370\255\235\253"
	.zero	128
	.size	message, 256

	.type	out,@object                     # @out
	.globl	out
	.p2align	4, 0x90
out:
	.zero	64
	.size	out, 64

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

	.type	.Lreltable.ERR_reason_symbol_name,@object # @reltable.ERR_reason_symbol_name
	.section	.rodata,"a",@progbits
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
