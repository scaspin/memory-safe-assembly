	.text
crc32_iscsi_01:
endbr64
pushq	%rbx
pushq	%rdi
pushq	%rsi
movq	%rdx, %r8
cmpq	$0x8, %rsi
jb	less_than_8
movq	%rdi, %rcx
negq	%rdi
andq	$0x7, %rdi
je	proc_block
movq	(%rcx), %rbx
addq	%rdi, %rcx
subq	%rdi, %rsi
align_loop:
crc32b	%bl, %r8d
shrq	$0x8, %rbx
decq	%rdi
jne	align_loop
proc_block:
movq	%rsi, %rbx
cmpq	$0xc00, %rsi
jae	full_block
continue_block:
cmpq	$0xc8, %rsi
jb	small
movl	$0xaab, %eax
mull	%esi
shrq	$0x10, %rax
leaq	(%rcx,%rax,8), %rcx
leaq	(%rcx,%rax,8), %rdx
leaq	(%rdx,%rax,8), %r11
xorq	%r9, %r9
xorq	%r10, %r10
leaq	jump_table(%rip), %rdi
movzwq	(%rdi,%rax,2), %rsi
leaq	-0x2428(%rdi,%rsi), %rdi
jmpq	*%rdi
full_block:
movl	$0x80, %eax
leaq	0x800(%rcx), %rdx
leaq	0xc00(%rcx), %r11
addq	$0x400, %rcx
xorq	%r9, %r9
xorq	%r10, %r10
crc_array:
cmpq	$0x1800, %rsi
jbe	non_prefetch
_crc_128:
crc32q	-0x400(%rcx), %r8
crc32q	-0x400(%rdx), %r9
crc32q	-0x400(%r11), %r10
prefetcht1	(%r11)
_crc_127:
crc32q	-0x3f8(%rcx), %r8
crc32q	-0x3f8(%rdx), %r9
crc32q	-0x3f8(%r11), %r10
prefetcht1	0x20(%r11)
_crc_126:
crc32q	-0x3f0(%rcx), %r8
crc32q	-0x3f0(%rdx), %r9
crc32q	-0x3f0(%r11), %r10
prefetcht1	0x40(%r11)
_crc_125:
crc32q	-0x3e8(%rcx), %r8
crc32q	-0x3e8(%rdx), %r9
crc32q	-0x3e8(%r11), %r10
prefetcht1	0x60(%r11)
_crc_124:
crc32q	-0x3e0(%rcx), %r8
crc32q	-0x3e0(%rdx), %r9
crc32q	-0x3e0(%r11), %r10
prefetcht1	0x80(%r11)
_crc_123:
crc32q	-0x3d8(%rcx), %r8
crc32q	-0x3d8(%rdx), %r9
crc32q	-0x3d8(%r11), %r10
prefetcht1	0xa0(%r11)
_crc_122:
crc32q	-0x3d0(%rcx), %r8
crc32q	-0x3d0(%rdx), %r9
crc32q	-0x3d0(%r11), %r10
prefetcht1	0xc0(%r11)
_crc_121:
crc32q	-0x3c8(%rcx), %r8
crc32q	-0x3c8(%rdx), %r9
crc32q	-0x3c8(%r11), %r10
prefetcht1	0xe0(%r11)
_crc_120:
crc32q	-0x3c0(%rcx), %r8
crc32q	-0x3c0(%rdx), %r9
crc32q	-0x3c0(%r11), %r10
prefetcht1	0x100(%r11)
_crc_119:
crc32q	-0x3b8(%rcx), %r8
crc32q	-0x3b8(%rdx), %r9
crc32q	-0x3b8(%r11), %r10
prefetcht1	0x120(%r11)
_crc_118:
crc32q	-0x3b0(%rcx), %r8
crc32q	-0x3b0(%rdx), %r9
crc32q	-0x3b0(%r11), %r10
prefetcht1	0x140(%r11)
_crc_117:
crc32q	-0x3a8(%rcx), %r8
crc32q	-0x3a8(%rdx), %r9
crc32q	-0x3a8(%r11), %r10
prefetcht1	0x160(%r11)
_crc_116:
crc32q	-0x3a0(%rcx), %r8
crc32q	-0x3a0(%rdx), %r9
crc32q	-0x3a0(%r11), %r10
prefetcht1	0x180(%r11)
_crc_115:
crc32q	-0x398(%rcx), %r8
crc32q	-0x398(%rdx), %r9
crc32q	-0x398(%r11), %r10
prefetcht1	0x1a0(%r11)
_crc_114:
crc32q	-0x390(%rcx), %r8
crc32q	-0x390(%rdx), %r9
crc32q	-0x390(%r11), %r10
prefetcht1	0x1c0(%r11)
_crc_113:
crc32q	-0x388(%rcx), %r8
crc32q	-0x388(%rdx), %r9
crc32q	-0x388(%r11), %r10
prefetcht1	0x1e0(%r11)
_crc_112:
crc32q	-0x380(%rcx), %r8
crc32q	-0x380(%rdx), %r9
crc32q	-0x380(%r11), %r10
prefetcht1	0x200(%r11)
_crc_111:
crc32q	-0x378(%rcx), %r8
crc32q	-0x378(%rdx), %r9
crc32q	-0x378(%r11), %r10
prefetcht1	0x220(%r11)
_crc_110:
crc32q	-0x370(%rcx), %r8
crc32q	-0x370(%rdx), %r9
crc32q	-0x370(%r11), %r10
prefetcht1	0x240(%r11)
_crc_109:
crc32q	-0x368(%rcx), %r8
crc32q	-0x368(%rdx), %r9
crc32q	-0x368(%r11), %r10
prefetcht1	0x260(%r11)
_crc_108:
crc32q	-0x360(%rcx), %r8
crc32q	-0x360(%rdx), %r9
crc32q	-0x360(%r11), %r10
prefetcht1	0x280(%r11)
_crc_107:
crc32q	-0x358(%rcx), %r8
crc32q	-0x358(%rdx), %r9
crc32q	-0x358(%r11), %r10
prefetcht1	0x2a0(%r11)
_crc_106:
crc32q	-0x350(%rcx), %r8
crc32q	-0x350(%rdx), %r9
crc32q	-0x350(%r11), %r10
prefetcht1	0x2c0(%r11)
_crc_105:
crc32q	-0x348(%rcx), %r8
crc32q	-0x348(%rdx), %r9
crc32q	-0x348(%r11), %r10
prefetcht1	0x2e0(%r11)
_crc_104:
crc32q	-0x340(%rcx), %r8
crc32q	-0x340(%rdx), %r9
crc32q	-0x340(%r11), %r10
prefetcht1	0x300(%r11)
_crc_103:
crc32q	-0x338(%rcx), %r8
crc32q	-0x338(%rdx), %r9
crc32q	-0x338(%r11), %r10
prefetcht1	0x320(%r11)
_crc_102:
crc32q	-0x330(%rcx), %r8
crc32q	-0x330(%rdx), %r9
crc32q	-0x330(%r11), %r10
prefetcht1	0x340(%r11)
_crc_101:
crc32q	-0x328(%rcx), %r8
crc32q	-0x328(%rdx), %r9
crc32q	-0x328(%r11), %r10
prefetcht1	0x360(%r11)
_crc_100:
crc32q	-0x320(%rcx), %r8
crc32q	-0x320(%rdx), %r9
crc32q	-0x320(%r11), %r10
prefetcht1	0x380(%r11)
_crc_99:
crc32q	-0x318(%rcx), %r8
crc32q	-0x318(%rdx), %r9
crc32q	-0x318(%r11), %r10
prefetcht1	0x3a0(%r11)
_crc_98:
crc32q	-0x310(%rcx), %r8
crc32q	-0x310(%rdx), %r9
crc32q	-0x310(%r11), %r10
prefetcht1	0x3c0(%r11)
_crc_97:
crc32q	-0x308(%rcx), %r8
crc32q	-0x308(%rdx), %r9
crc32q	-0x308(%r11), %r10
prefetcht1	0x3e0(%r11)
_crc_96:
crc32q	-0x300(%rcx), %r8
crc32q	-0x300(%rdx), %r9
crc32q	-0x300(%r11), %r10
prefetcht1	0x400(%r11)
_crc_95:
crc32q	-0x2f8(%rcx), %r8
crc32q	-0x2f8(%rdx), %r9
crc32q	-0x2f8(%r11), %r10
prefetcht1	0x420(%r11)
_crc_94:
crc32q	-0x2f0(%rcx), %r8
crc32q	-0x2f0(%rdx), %r9
crc32q	-0x2f0(%r11), %r10
prefetcht1	0x440(%r11)
_crc_93:
crc32q	-0x2e8(%rcx), %r8
crc32q	-0x2e8(%rdx), %r9
crc32q	-0x2e8(%r11), %r10
prefetcht1	0x460(%r11)
_crc_92:
crc32q	-0x2e0(%rcx), %r8
crc32q	-0x2e0(%rdx), %r9
crc32q	-0x2e0(%r11), %r10
prefetcht1	0x480(%r11)
_crc_91:
crc32q	-0x2d8(%rcx), %r8
crc32q	-0x2d8(%rdx), %r9
crc32q	-0x2d8(%r11), %r10
prefetcht1	0x4a0(%r11)
_crc_90:
crc32q	-0x2d0(%rcx), %r8
crc32q	-0x2d0(%rdx), %r9
crc32q	-0x2d0(%r11), %r10
prefetcht1	0x4c0(%r11)
_crc_89:
crc32q	-0x2c8(%rcx), %r8
crc32q	-0x2c8(%rdx), %r9
crc32q	-0x2c8(%r11), %r10
prefetcht1	0x4e0(%r11)
_crc_88:
crc32q	-0x2c0(%rcx), %r8
crc32q	-0x2c0(%rdx), %r9
crc32q	-0x2c0(%r11), %r10
prefetcht1	0x500(%r11)
_crc_87:
crc32q	-0x2b8(%rcx), %r8
crc32q	-0x2b8(%rdx), %r9
crc32q	-0x2b8(%r11), %r10
prefetcht1	0x520(%r11)
_crc_86:
crc32q	-0x2b0(%rcx), %r8
crc32q	-0x2b0(%rdx), %r9
crc32q	-0x2b0(%r11), %r10
prefetcht1	0x540(%r11)
_crc_85:
crc32q	-0x2a8(%rcx), %r8
crc32q	-0x2a8(%rdx), %r9
crc32q	-0x2a8(%r11), %r10
prefetcht1	0x560(%r11)
_crc_84:
crc32q	-0x2a0(%rcx), %r8
crc32q	-0x2a0(%rdx), %r9
crc32q	-0x2a0(%r11), %r10
prefetcht1	0x580(%r11)
_crc_83:
crc32q	-0x298(%rcx), %r8
crc32q	-0x298(%rdx), %r9
crc32q	-0x298(%r11), %r10
prefetcht1	0x5a0(%r11)
_crc_82:
crc32q	-0x290(%rcx), %r8
crc32q	-0x290(%rdx), %r9
crc32q	-0x290(%r11), %r10
prefetcht1	0x5c0(%r11)
_crc_81:
crc32q	-0x288(%rcx), %r8
crc32q	-0x288(%rdx), %r9
crc32q	-0x288(%r11), %r10
prefetcht1	0x5e0(%r11)
_crc_80:
crc32q	-0x280(%rcx), %r8
crc32q	-0x280(%rdx), %r9
crc32q	-0x280(%r11), %r10
prefetcht1	0x600(%r11)
_crc_79:
crc32q	-0x278(%rcx), %r8
crc32q	-0x278(%rdx), %r9
crc32q	-0x278(%r11), %r10
prefetcht1	0x620(%r11)
_crc_78:
crc32q	-0x270(%rcx), %r8
crc32q	-0x270(%rdx), %r9
crc32q	-0x270(%r11), %r10
prefetcht1	0x640(%r11)
_crc_77:
crc32q	-0x268(%rcx), %r8
crc32q	-0x268(%rdx), %r9
crc32q	-0x268(%r11), %r10
prefetcht1	0x660(%r11)
_crc_76:
crc32q	-0x260(%rcx), %r8
crc32q	-0x260(%rdx), %r9
crc32q	-0x260(%r11), %r10
prefetcht1	0x680(%r11)
_crc_75:
crc32q	-0x258(%rcx), %r8
crc32q	-0x258(%rdx), %r9
crc32q	-0x258(%r11), %r10
prefetcht1	0x6a0(%r11)
_crc_74:
crc32q	-0x250(%rcx), %r8
crc32q	-0x250(%rdx), %r9
crc32q	-0x250(%r11), %r10
prefetcht1	0x6c0(%r11)
_crc_73:
crc32q	-0x248(%rcx), %r8
crc32q	-0x248(%rdx), %r9
crc32q	-0x248(%r11), %r10
prefetcht1	0x6e0(%r11)
_crc_72:
crc32q	-0x240(%rcx), %r8
crc32q	-0x240(%rdx), %r9
crc32q	-0x240(%r11), %r10
prefetcht1	0x700(%r11)
_crc_71:
crc32q	-0x238(%rcx), %r8
crc32q	-0x238(%rdx), %r9
crc32q	-0x238(%r11), %r10
prefetcht1	0x720(%r11)
_crc_70:
crc32q	-0x230(%rcx), %r8
crc32q	-0x230(%rdx), %r9
crc32q	-0x230(%r11), %r10
prefetcht1	0x740(%r11)
_crc_69:
crc32q	-0x228(%rcx), %r8
crc32q	-0x228(%rdx), %r9
crc32q	-0x228(%r11), %r10
prefetcht1	0x760(%r11)
_crc_68:
crc32q	-0x220(%rcx), %r8
crc32q	-0x220(%rdx), %r9
crc32q	-0x220(%r11), %r10
prefetcht1	0x780(%r11)
_crc_67:
crc32q	-0x218(%rcx), %r8
crc32q	-0x218(%rdx), %r9
crc32q	-0x218(%r11), %r10
prefetcht1	0x7a0(%r11)
_crc_66:
crc32q	-0x210(%rcx), %r8
crc32q	-0x210(%rdx), %r9
crc32q	-0x210(%r11), %r10
prefetcht1	0x7c0(%r11)
_crc_65:
crc32q	-0x208(%rcx), %r8
crc32q	-0x208(%rdx), %r9
crc32q	-0x208(%r11), %r10
prefetcht1	0x7e0(%r11)
_crc_64:
crc32q	-0x200(%rcx), %r8
crc32q	-0x200(%rdx), %r9
crc32q	-0x200(%r11), %r10
prefetcht1	0x800(%r11)
_crc_63:
crc32q	-0x1f8(%rcx), %r8
crc32q	-0x1f8(%rdx), %r9
crc32q	-0x1f8(%r11), %r10
prefetcht1	0x820(%r11)
_crc_62:
crc32q	-0x1f0(%rcx), %r8
crc32q	-0x1f0(%rdx), %r9
crc32q	-0x1f0(%r11), %r10
prefetcht1	0x840(%r11)
_crc_61:
crc32q	-0x1e8(%rcx), %r8
crc32q	-0x1e8(%rdx), %r9
crc32q	-0x1e8(%r11), %r10
prefetcht1	0x860(%r11)
_crc_60:
crc32q	-0x1e0(%rcx), %r8
crc32q	-0x1e0(%rdx), %r9
crc32q	-0x1e0(%r11), %r10
prefetcht1	0x880(%r11)
_crc_59:
crc32q	-0x1d8(%rcx), %r8
crc32q	-0x1d8(%rdx), %r9
crc32q	-0x1d8(%r11), %r10
prefetcht1	0x8a0(%r11)
_crc_58:
crc32q	-0x1d0(%rcx), %r8
crc32q	-0x1d0(%rdx), %r9
crc32q	-0x1d0(%r11), %r10
prefetcht1	0x8c0(%r11)
_crc_57:
crc32q	-0x1c8(%rcx), %r8
crc32q	-0x1c8(%rdx), %r9
crc32q	-0x1c8(%r11), %r10
prefetcht1	0x8e0(%r11)
_crc_56:
crc32q	-0x1c0(%rcx), %r8
crc32q	-0x1c0(%rdx), %r9
crc32q	-0x1c0(%r11), %r10
prefetcht1	0x900(%r11)
_crc_55:
crc32q	-0x1b8(%rcx), %r8
crc32q	-0x1b8(%rdx), %r9
crc32q	-0x1b8(%r11), %r10
prefetcht1	0x920(%r11)
_crc_54:
crc32q	-0x1b0(%rcx), %r8
crc32q	-0x1b0(%rdx), %r9
crc32q	-0x1b0(%r11), %r10
prefetcht1	0x940(%r11)
_crc_53:
crc32q	-0x1a8(%rcx), %r8
crc32q	-0x1a8(%rdx), %r9
crc32q	-0x1a8(%r11), %r10
prefetcht1	0x960(%r11)
_crc_52:
crc32q	-0x1a0(%rcx), %r8
crc32q	-0x1a0(%rdx), %r9
crc32q	-0x1a0(%r11), %r10
prefetcht1	0x980(%r11)
_crc_51:
crc32q	-0x198(%rcx), %r8
crc32q	-0x198(%rdx), %r9
crc32q	-0x198(%r11), %r10
prefetcht1	0x9a0(%r11)
_crc_50:
crc32q	-0x190(%rcx), %r8
crc32q	-0x190(%rdx), %r9
crc32q	-0x190(%r11), %r10
prefetcht1	0x9c0(%r11)
_crc_49:
crc32q	-0x188(%rcx), %r8
crc32q	-0x188(%rdx), %r9
crc32q	-0x188(%r11), %r10
prefetcht1	0x9e0(%r11)
_crc_48:
crc32q	-0x180(%rcx), %r8
crc32q	-0x180(%rdx), %r9
crc32q	-0x180(%r11), %r10
prefetcht1	0xa00(%r11)
_crc_47:
crc32q	-0x178(%rcx), %r8
crc32q	-0x178(%rdx), %r9
crc32q	-0x178(%r11), %r10
prefetcht1	0xa20(%r11)
_crc_46:
crc32q	-0x170(%rcx), %r8
crc32q	-0x170(%rdx), %r9
crc32q	-0x170(%r11), %r10
prefetcht1	0xa40(%r11)
_crc_45:
crc32q	-0x168(%rcx), %r8
crc32q	-0x168(%rdx), %r9
crc32q	-0x168(%r11), %r10
prefetcht1	0xa60(%r11)
_crc_44:
crc32q	-0x160(%rcx), %r8
crc32q	-0x160(%rdx), %r9
crc32q	-0x160(%r11), %r10
prefetcht1	0xa80(%r11)
_crc_43:
crc32q	-0x158(%rcx), %r8
crc32q	-0x158(%rdx), %r9
crc32q	-0x158(%r11), %r10
prefetcht1	0xaa0(%r11)
_crc_42:
crc32q	-0x150(%rcx), %r8
crc32q	-0x150(%rdx), %r9
crc32q	-0x150(%r11), %r10
prefetcht1	0xac0(%r11)
_crc_41:
crc32q	-0x148(%rcx), %r8
crc32q	-0x148(%rdx), %r9
crc32q	-0x148(%r11), %r10
prefetcht1	0xae0(%r11)
_crc_40:
crc32q	-0x140(%rcx), %r8
crc32q	-0x140(%rdx), %r9
crc32q	-0x140(%r11), %r10
prefetcht1	0xb00(%r11)
_crc_39:
crc32q	-0x138(%rcx), %r8
crc32q	-0x138(%rdx), %r9
crc32q	-0x138(%r11), %r10
prefetcht1	0xb20(%r11)
_crc_38:
crc32q	-0x130(%rcx), %r8
crc32q	-0x130(%rdx), %r9
crc32q	-0x130(%r11), %r10
prefetcht1	0xb40(%r11)
_crc_37:
crc32q	-0x128(%rcx), %r8
crc32q	-0x128(%rdx), %r9
crc32q	-0x128(%r11), %r10
prefetcht1	0xb60(%r11)
_crc_36:
crc32q	-0x120(%rcx), %r8
crc32q	-0x120(%rdx), %r9
crc32q	-0x120(%r11), %r10
prefetcht1	0xb80(%r11)
_crc_35:
crc32q	-0x118(%rcx), %r8
crc32q	-0x118(%rdx), %r9
crc32q	-0x118(%r11), %r10
prefetcht1	0xba0(%r11)
_crc_34:
crc32q	-0x110(%rcx), %r8
crc32q	-0x110(%rdx), %r9
crc32q	-0x110(%r11), %r10
prefetcht1	0xbc0(%r11)
_crc_33:
crc32q	-0x108(%rcx), %r8
crc32q	-0x108(%rdx), %r9
crc32q	-0x108(%r11), %r10
prefetcht1	0xbe0(%r11)
_crc_32:
crc32q	-0x100(%rcx), %r8
crc32q	-0x100(%rdx), %r9
crc32q	-0x100(%r11), %r10
_crc_31:
crc32q	-0xf8(%rcx), %r8
crc32q	-0xf8(%rdx), %r9
crc32q	-0xf8(%r11), %r10
_crc_30:
crc32q	-0xf0(%rcx), %r8
crc32q	-0xf0(%rdx), %r9
crc32q	-0xf0(%r11), %r10
_crc_29:
crc32q	-0xe8(%rcx), %r8
crc32q	-0xe8(%rdx), %r9
crc32q	-0xe8(%r11), %r10
_crc_28:
crc32q	-0xe0(%rcx), %r8
crc32q	-0xe0(%rdx), %r9
crc32q	-0xe0(%r11), %r10
_crc_27:
crc32q	-0xd8(%rcx), %r8
crc32q	-0xd8(%rdx), %r9
crc32q	-0xd8(%r11), %r10
_crc_26:
crc32q	-0xd0(%rcx), %r8
crc32q	-0xd0(%rdx), %r9
crc32q	-0xd0(%r11), %r10
_crc_25:
crc32q	-0xc8(%rcx), %r8
crc32q	-0xc8(%rdx), %r9
crc32q	-0xc8(%r11), %r10
_crc_24:
crc32q	-0xc0(%rcx), %r8
crc32q	-0xc0(%rdx), %r9
crc32q	-0xc0(%r11), %r10
_crc_23:
crc32q	-0xb8(%rcx), %r8
crc32q	-0xb8(%rdx), %r9
crc32q	-0xb8(%r11), %r10
_crc_22:
crc32q	-0xb0(%rcx), %r8
crc32q	-0xb0(%rdx), %r9
crc32q	-0xb0(%r11), %r10
_crc_21:
crc32q	-0xa8(%rcx), %r8
crc32q	-0xa8(%rdx), %r9
crc32q	-0xa8(%r11), %r10
_crc_20:
crc32q	-0xa0(%rcx), %r8
crc32q	-0xa0(%rdx), %r9
crc32q	-0xa0(%r11), %r10
_crc_19:
crc32q	-0x98(%rcx), %r8
crc32q	-0x98(%rdx), %r9
crc32q	-0x98(%r11), %r10
_crc_18:
crc32q	-0x90(%rcx), %r8
crc32q	-0x90(%rdx), %r9
crc32q	-0x90(%r11), %r10
_crc_17:
crc32q	-0x88(%rcx), %r8
crc32q	-0x88(%rdx), %r9
crc32q	-0x88(%r11), %r10
_crc_16:
crc32q	-0x80(%rcx), %r8
crc32q	-0x80(%rdx), %r9
crc32q	-0x80(%r11), %r10
_crc_15:
crc32q	-0x78(%rcx), %r8
crc32q	-0x78(%rdx), %r9
crc32q	-0x78(%r11), %r10
_crc_14:
crc32q	-0x70(%rcx), %r8
crc32q	-0x70(%rdx), %r9
crc32q	-0x70(%r11), %r10
_crc_13:
crc32q	-0x68(%rcx), %r8
crc32q	-0x68(%rdx), %r9
crc32q	-0x68(%r11), %r10
_crc_12:
crc32q	-0x60(%rcx), %r8
crc32q	-0x60(%rdx), %r9
crc32q	-0x60(%r11), %r10
_crc_11:
crc32q	-0x58(%rcx), %r8
crc32q	-0x58(%rdx), %r9
crc32q	-0x58(%r11), %r10
_crc_10:
crc32q	-0x50(%rcx), %r8
crc32q	-0x50(%rdx), %r9
crc32q	-0x50(%r11), %r10
_crc_9:
crc32q	-0x48(%rcx), %r8
crc32q	-0x48(%rdx), %r9
crc32q	-0x48(%r11), %r10
_crc_8:
crc32q	-0x40(%rcx), %r8
crc32q	-0x40(%rdx), %r9
crc32q	-0x40(%r11), %r10
_crc_7:
crc32q	-0x38(%rcx), %r8
crc32q	-0x38(%rdx), %r9
crc32q	-0x38(%r11), %r10
_crc_6:
crc32q	-0x30(%rcx), %r8
crc32q	-0x30(%rdx), %r9
crc32q	-0x30(%r11), %r10
_crc_5:
crc32q	-0x28(%rcx), %r8
crc32q	-0x28(%rdx), %r9
crc32q	-0x28(%r11), %r10
_crc_4:
crc32q	-0x20(%rcx), %r8
crc32q	-0x20(%rdx), %r9
crc32q	-0x20(%r11), %r10
_crc_3:
crc32q	-0x18(%rcx), %r8
crc32q	-0x18(%rdx), %r9
crc32q	-0x18(%r11), %r10
_crc_2:
crc32q	-0x10(%rcx), %r8
crc32q	-0x10(%rdx), %r9
crc32q	-0x10(%r11), %r10
jmp	next_
non_prefetch:
crc_128:
endbr64
crc32q	-0x400(%rcx), %r8
crc32q	-0x400(%rdx), %r9
crc32q	-0x400(%r11), %r10
crc_127:
endbr64
crc32q	-0x3f8(%rcx), %r8
crc32q	-0x3f8(%rdx), %r9
crc32q	-0x3f8(%r11), %r10
crc_126:
endbr64
crc32q	-0x3f0(%rcx), %r8
crc32q	-0x3f0(%rdx), %r9
crc32q	-0x3f0(%r11), %r10
crc_125:
endbr64
crc32q	-0x3e8(%rcx), %r8
crc32q	-0x3e8(%rdx), %r9
crc32q	-0x3e8(%r11), %r10
crc_124:
endbr64
crc32q	-0x3e0(%rcx), %r8
crc32q	-0x3e0(%rdx), %r9
crc32q	-0x3e0(%r11), %r10
crc_123:
endbr64
crc32q	-0x3d8(%rcx), %r8
crc32q	-0x3d8(%rdx), %r9
crc32q	-0x3d8(%r11), %r10
crc_122:
endbr64
crc32q	-0x3d0(%rcx), %r8
crc32q	-0x3d0(%rdx), %r9
crc32q	-0x3d0(%r11), %r10
crc_121:
endbr64
crc32q	-0x3c8(%rcx), %r8
crc32q	-0x3c8(%rdx), %r9
crc32q	-0x3c8(%r11), %r10
crc_120:
endbr64
crc32q	-0x3c0(%rcx), %r8
crc32q	-0x3c0(%rdx), %r9
crc32q	-0x3c0(%r11), %r10
crc_119:
endbr64
crc32q	-0x3b8(%rcx), %r8
crc32q	-0x3b8(%rdx), %r9
crc32q	-0x3b8(%r11), %r10
crc_118:
endbr64
crc32q	-0x3b0(%rcx), %r8
crc32q	-0x3b0(%rdx), %r9
crc32q	-0x3b0(%r11), %r10
crc_117:
endbr64
crc32q	-0x3a8(%rcx), %r8
crc32q	-0x3a8(%rdx), %r9
crc32q	-0x3a8(%r11), %r10
crc_116:
endbr64
crc32q	-0x3a0(%rcx), %r8
crc32q	-0x3a0(%rdx), %r9
crc32q	-0x3a0(%r11), %r10
crc_115:
endbr64
crc32q	-0x398(%rcx), %r8
crc32q	-0x398(%rdx), %r9
crc32q	-0x398(%r11), %r10
crc_114:
endbr64
crc32q	-0x390(%rcx), %r8
crc32q	-0x390(%rdx), %r9
crc32q	-0x390(%r11), %r10
crc_113:
endbr64
crc32q	-0x388(%rcx), %r8
crc32q	-0x388(%rdx), %r9
crc32q	-0x388(%r11), %r10
crc_112:
endbr64
crc32q	-0x380(%rcx), %r8
crc32q	-0x380(%rdx), %r9
crc32q	-0x380(%r11), %r10
crc_111:
endbr64
crc32q	-0x378(%rcx), %r8
crc32q	-0x378(%rdx), %r9
crc32q	-0x378(%r11), %r10
crc_110:
endbr64
crc32q	-0x370(%rcx), %r8
crc32q	-0x370(%rdx), %r9
crc32q	-0x370(%r11), %r10
crc_109:
endbr64
crc32q	-0x368(%rcx), %r8
crc32q	-0x368(%rdx), %r9
crc32q	-0x368(%r11), %r10
crc_108:
endbr64
crc32q	-0x360(%rcx), %r8
crc32q	-0x360(%rdx), %r9
crc32q	-0x360(%r11), %r10
crc_107:
endbr64
crc32q	-0x358(%rcx), %r8
crc32q	-0x358(%rdx), %r9
crc32q	-0x358(%r11), %r10
crc_106:
endbr64
crc32q	-0x350(%rcx), %r8
crc32q	-0x350(%rdx), %r9
crc32q	-0x350(%r11), %r10
crc_105:
endbr64
crc32q	-0x348(%rcx), %r8
crc32q	-0x348(%rdx), %r9
crc32q	-0x348(%r11), %r10
crc_104:
endbr64
crc32q	-0x340(%rcx), %r8
crc32q	-0x340(%rdx), %r9
crc32q	-0x340(%r11), %r10
crc_103:
endbr64
crc32q	-0x338(%rcx), %r8
crc32q	-0x338(%rdx), %r9
crc32q	-0x338(%r11), %r10
crc_102:
endbr64
crc32q	-0x330(%rcx), %r8
crc32q	-0x330(%rdx), %r9
crc32q	-0x330(%r11), %r10
crc_101:
endbr64
crc32q	-0x328(%rcx), %r8
crc32q	-0x328(%rdx), %r9
crc32q	-0x328(%r11), %r10
crc_100:
endbr64
crc32q	-0x320(%rcx), %r8
crc32q	-0x320(%rdx), %r9
crc32q	-0x320(%r11), %r10
crc_99:
endbr64
crc32q	-0x318(%rcx), %r8
crc32q	-0x318(%rdx), %r9
crc32q	-0x318(%r11), %r10
crc_98:
endbr64
crc32q	-0x310(%rcx), %r8
crc32q	-0x310(%rdx), %r9
crc32q	-0x310(%r11), %r10
crc_97:
endbr64
crc32q	-0x308(%rcx), %r8
crc32q	-0x308(%rdx), %r9
crc32q	-0x308(%r11), %r10
crc_96:
endbr64
crc32q	-0x300(%rcx), %r8
crc32q	-0x300(%rdx), %r9
crc32q	-0x300(%r11), %r10
crc_95:
endbr64
crc32q	-0x2f8(%rcx), %r8
crc32q	-0x2f8(%rdx), %r9
crc32q	-0x2f8(%r11), %r10
crc_94:
endbr64
crc32q	-0x2f0(%rcx), %r8
crc32q	-0x2f0(%rdx), %r9
crc32q	-0x2f0(%r11), %r10
crc_93:
endbr64
crc32q	-0x2e8(%rcx), %r8
crc32q	-0x2e8(%rdx), %r9
crc32q	-0x2e8(%r11), %r10
crc_92:
endbr64
crc32q	-0x2e0(%rcx), %r8
crc32q	-0x2e0(%rdx), %r9
crc32q	-0x2e0(%r11), %r10
crc_91:
endbr64
crc32q	-0x2d8(%rcx), %r8
crc32q	-0x2d8(%rdx), %r9
crc32q	-0x2d8(%r11), %r10
crc_90:
endbr64
crc32q	-0x2d0(%rcx), %r8
crc32q	-0x2d0(%rdx), %r9
crc32q	-0x2d0(%r11), %r10
crc_89:
endbr64
crc32q	-0x2c8(%rcx), %r8
crc32q	-0x2c8(%rdx), %r9
crc32q	-0x2c8(%r11), %r10
crc_88:
endbr64
crc32q	-0x2c0(%rcx), %r8
crc32q	-0x2c0(%rdx), %r9
crc32q	-0x2c0(%r11), %r10
crc_87:
endbr64
crc32q	-0x2b8(%rcx), %r8
crc32q	-0x2b8(%rdx), %r9
crc32q	-0x2b8(%r11), %r10
crc_86:
endbr64
crc32q	-0x2b0(%rcx), %r8
crc32q	-0x2b0(%rdx), %r9
crc32q	-0x2b0(%r11), %r10
crc_85:
endbr64
crc32q	-0x2a8(%rcx), %r8
crc32q	-0x2a8(%rdx), %r9
crc32q	-0x2a8(%r11), %r10
crc_84:
endbr64
crc32q	-0x2a0(%rcx), %r8
crc32q	-0x2a0(%rdx), %r9
crc32q	-0x2a0(%r11), %r10
crc_83:
endbr64
crc32q	-0x298(%rcx), %r8
crc32q	-0x298(%rdx), %r9
crc32q	-0x298(%r11), %r10
crc_82:
endbr64
crc32q	-0x290(%rcx), %r8
crc32q	-0x290(%rdx), %r9
crc32q	-0x290(%r11), %r10
crc_81:
endbr64
crc32q	-0x288(%rcx), %r8
crc32q	-0x288(%rdx), %r9
crc32q	-0x288(%r11), %r10
crc_80:
endbr64
crc32q	-0x280(%rcx), %r8
crc32q	-0x280(%rdx), %r9
crc32q	-0x280(%r11), %r10
crc_79:
endbr64
crc32q	-0x278(%rcx), %r8
crc32q	-0x278(%rdx), %r9
crc32q	-0x278(%r11), %r10
crc_78:
endbr64
crc32q	-0x270(%rcx), %r8
crc32q	-0x270(%rdx), %r9
crc32q	-0x270(%r11), %r10
crc_77:
endbr64
crc32q	-0x268(%rcx), %r8
crc32q	-0x268(%rdx), %r9
crc32q	-0x268(%r11), %r10
crc_76:
endbr64
crc32q	-0x260(%rcx), %r8
crc32q	-0x260(%rdx), %r9
crc32q	-0x260(%r11), %r10
crc_75:
endbr64
crc32q	-0x258(%rcx), %r8
crc32q	-0x258(%rdx), %r9
crc32q	-0x258(%r11), %r10
crc_74:
endbr64
crc32q	-0x250(%rcx), %r8
crc32q	-0x250(%rdx), %r9
crc32q	-0x250(%r11), %r10
crc_73:
endbr64
crc32q	-0x248(%rcx), %r8
crc32q	-0x248(%rdx), %r9
crc32q	-0x248(%r11), %r10
crc_72:
endbr64
crc32q	-0x240(%rcx), %r8
crc32q	-0x240(%rdx), %r9
crc32q	-0x240(%r11), %r10
crc_71:
endbr64
crc32q	-0x238(%rcx), %r8
crc32q	-0x238(%rdx), %r9
crc32q	-0x238(%r11), %r10
crc_70:
endbr64
crc32q	-0x230(%rcx), %r8
crc32q	-0x230(%rdx), %r9
crc32q	-0x230(%r11), %r10
crc_69:
endbr64
crc32q	-0x228(%rcx), %r8
crc32q	-0x228(%rdx), %r9
crc32q	-0x228(%r11), %r10
crc_68:
endbr64
crc32q	-0x220(%rcx), %r8
crc32q	-0x220(%rdx), %r9
crc32q	-0x220(%r11), %r10
crc_67:
endbr64
crc32q	-0x218(%rcx), %r8
crc32q	-0x218(%rdx), %r9
crc32q	-0x218(%r11), %r10
crc_66:
endbr64
crc32q	-0x210(%rcx), %r8
crc32q	-0x210(%rdx), %r9
crc32q	-0x210(%r11), %r10
crc_65:
endbr64
crc32q	-0x208(%rcx), %r8
crc32q	-0x208(%rdx), %r9
crc32q	-0x208(%r11), %r10
crc_64:
endbr64
crc32q	-0x200(%rcx), %r8
crc32q	-0x200(%rdx), %r9
crc32q	-0x200(%r11), %r10
crc_63:
endbr64
crc32q	-0x1f8(%rcx), %r8
crc32q	-0x1f8(%rdx), %r9
crc32q	-0x1f8(%r11), %r10
crc_62:
endbr64
crc32q	-0x1f0(%rcx), %r8
crc32q	-0x1f0(%rdx), %r9
crc32q	-0x1f0(%r11), %r10
crc_61:
endbr64
crc32q	-0x1e8(%rcx), %r8
crc32q	-0x1e8(%rdx), %r9
crc32q	-0x1e8(%r11), %r10
crc_60:
endbr64
crc32q	-0x1e0(%rcx), %r8
crc32q	-0x1e0(%rdx), %r9
crc32q	-0x1e0(%r11), %r10
crc_59:
endbr64
crc32q	-0x1d8(%rcx), %r8
crc32q	-0x1d8(%rdx), %r9
crc32q	-0x1d8(%r11), %r10
crc_58:
endbr64
crc32q	-0x1d0(%rcx), %r8
crc32q	-0x1d0(%rdx), %r9
crc32q	-0x1d0(%r11), %r10
crc_57:
endbr64
crc32q	-0x1c8(%rcx), %r8
crc32q	-0x1c8(%rdx), %r9
crc32q	-0x1c8(%r11), %r10
crc_56:
endbr64
crc32q	-0x1c0(%rcx), %r8
crc32q	-0x1c0(%rdx), %r9
crc32q	-0x1c0(%r11), %r10
crc_55:
endbr64
crc32q	-0x1b8(%rcx), %r8
crc32q	-0x1b8(%rdx), %r9
crc32q	-0x1b8(%r11), %r10
crc_54:
endbr64
crc32q	-0x1b0(%rcx), %r8
crc32q	-0x1b0(%rdx), %r9
crc32q	-0x1b0(%r11), %r10
crc_53:
endbr64
crc32q	-0x1a8(%rcx), %r8
crc32q	-0x1a8(%rdx), %r9
crc32q	-0x1a8(%r11), %r10
crc_52:
endbr64
crc32q	-0x1a0(%rcx), %r8
crc32q	-0x1a0(%rdx), %r9
crc32q	-0x1a0(%r11), %r10
crc_51:
endbr64
crc32q	-0x198(%rcx), %r8
crc32q	-0x198(%rdx), %r9
crc32q	-0x198(%r11), %r10
crc_50:
endbr64
crc32q	-0x190(%rcx), %r8
crc32q	-0x190(%rdx), %r9
crc32q	-0x190(%r11), %r10
crc_49:
endbr64
crc32q	-0x188(%rcx), %r8
crc32q	-0x188(%rdx), %r9
crc32q	-0x188(%r11), %r10
crc_48:
endbr64
crc32q	-0x180(%rcx), %r8
crc32q	-0x180(%rdx), %r9
crc32q	-0x180(%r11), %r10
crc_47:
endbr64
crc32q	-0x178(%rcx), %r8
crc32q	-0x178(%rdx), %r9
crc32q	-0x178(%r11), %r10
crc_46:
endbr64
crc32q	-0x170(%rcx), %r8
crc32q	-0x170(%rdx), %r9
crc32q	-0x170(%r11), %r10
crc_45:
endbr64
crc32q	-0x168(%rcx), %r8
crc32q	-0x168(%rdx), %r9
crc32q	-0x168(%r11), %r10
crc_44:
endbr64
crc32q	-0x160(%rcx), %r8
crc32q	-0x160(%rdx), %r9
crc32q	-0x160(%r11), %r10
crc_43:
endbr64
crc32q	-0x158(%rcx), %r8
crc32q	-0x158(%rdx), %r9
crc32q	-0x158(%r11), %r10
crc_42:
endbr64
crc32q	-0x150(%rcx), %r8
crc32q	-0x150(%rdx), %r9
crc32q	-0x150(%r11), %r10
crc_41:
endbr64
crc32q	-0x148(%rcx), %r8
crc32q	-0x148(%rdx), %r9
crc32q	-0x148(%r11), %r10
crc_40:
endbr64
crc32q	-0x140(%rcx), %r8
crc32q	-0x140(%rdx), %r9
crc32q	-0x140(%r11), %r10
crc_39:
endbr64
crc32q	-0x138(%rcx), %r8
crc32q	-0x138(%rdx), %r9
crc32q	-0x138(%r11), %r10
crc_38:
endbr64
crc32q	-0x130(%rcx), %r8
crc32q	-0x130(%rdx), %r9
crc32q	-0x130(%r11), %r10
crc_37:
endbr64
crc32q	-0x128(%rcx), %r8
crc32q	-0x128(%rdx), %r9
crc32q	-0x128(%r11), %r10
crc_36:
endbr64
crc32q	-0x120(%rcx), %r8
crc32q	-0x120(%rdx), %r9
crc32q	-0x120(%r11), %r10
crc_35:
endbr64
crc32q	-0x118(%rcx), %r8
crc32q	-0x118(%rdx), %r9
crc32q	-0x118(%r11), %r10
crc_34:
endbr64
crc32q	-0x110(%rcx), %r8
crc32q	-0x110(%rdx), %r9
crc32q	-0x110(%r11), %r10
crc_33:
endbr64
crc32q	-0x108(%rcx), %r8
crc32q	-0x108(%rdx), %r9
crc32q	-0x108(%r11), %r10
crc_32:
endbr64
crc32q	-0x100(%rcx), %r8
crc32q	-0x100(%rdx), %r9
crc32q	-0x100(%r11), %r10
crc_31:
endbr64
crc32q	-0xf8(%rcx), %r8
crc32q	-0xf8(%rdx), %r9
crc32q	-0xf8(%r11), %r10
crc_30:
endbr64
crc32q	-0xf0(%rcx), %r8
crc32q	-0xf0(%rdx), %r9
crc32q	-0xf0(%r11), %r10
crc_29:
endbr64
crc32q	-0xe8(%rcx), %r8
crc32q	-0xe8(%rdx), %r9
crc32q	-0xe8(%r11), %r10
crc_28:
endbr64
crc32q	-0xe0(%rcx), %r8
crc32q	-0xe0(%rdx), %r9
crc32q	-0xe0(%r11), %r10
crc_27:
endbr64
crc32q	-0xd8(%rcx), %r8
crc32q	-0xd8(%rdx), %r9
crc32q	-0xd8(%r11), %r10
crc_26:
endbr64
crc32q	-0xd0(%rcx), %r8
crc32q	-0xd0(%rdx), %r9
crc32q	-0xd0(%r11), %r10
crc_25:
endbr64
crc32q	-0xc8(%rcx), %r8
crc32q	-0xc8(%rdx), %r9
crc32q	-0xc8(%r11), %r10
crc_24:
endbr64
crc32q	-0xc0(%rcx), %r8
crc32q	-0xc0(%rdx), %r9
crc32q	-0xc0(%r11), %r10
crc_23:
endbr64
crc32q	-0xb8(%rcx), %r8
crc32q	-0xb8(%rdx), %r9
crc32q	-0xb8(%r11), %r10
crc_22:
endbr64
crc32q	-0xb0(%rcx), %r8
crc32q	-0xb0(%rdx), %r9
crc32q	-0xb0(%r11), %r10
crc_21:
endbr64
crc32q	-0xa8(%rcx), %r8
crc32q	-0xa8(%rdx), %r9
crc32q	-0xa8(%r11), %r10
crc_20:
endbr64
crc32q	-0xa0(%rcx), %r8
crc32q	-0xa0(%rdx), %r9
crc32q	-0xa0(%r11), %r10
crc_19:
endbr64
crc32q	-0x98(%rcx), %r8
crc32q	-0x98(%rdx), %r9
crc32q	-0x98(%r11), %r10
crc_18:
endbr64
crc32q	-0x90(%rcx), %r8
crc32q	-0x90(%rdx), %r9
crc32q	-0x90(%r11), %r10
crc_17:
endbr64
crc32q	-0x88(%rcx), %r8
crc32q	-0x88(%rdx), %r9
crc32q	-0x88(%r11), %r10
crc_16:
endbr64
crc32q	-0x80(%rcx), %r8
crc32q	-0x80(%rdx), %r9
crc32q	-0x80(%r11), %r10
crc_15:
endbr64
crc32q	-0x78(%rcx), %r8
crc32q	-0x78(%rdx), %r9
crc32q	-0x78(%r11), %r10
crc_14:
endbr64
crc32q	-0x70(%rcx), %r8
crc32q	-0x70(%rdx), %r9
crc32q	-0x70(%r11), %r10
crc_13:
endbr64
crc32q	-0x68(%rcx), %r8
crc32q	-0x68(%rdx), %r9
crc32q	-0x68(%r11), %r10
crc_12:
endbr64
crc32q	-0x60(%rcx), %r8
crc32q	-0x60(%rdx), %r9
crc32q	-0x60(%r11), %r10
crc_11:
endbr64
crc32q	-0x58(%rcx), %r8
crc32q	-0x58(%rdx), %r9
crc32q	-0x58(%r11), %r10
crc_10:
endbr64
crc32q	-0x50(%rcx), %r8
crc32q	-0x50(%rdx), %r9
crc32q	-0x50(%r11), %r10
crc_9:
endbr64
crc32q	-0x48(%rcx), %r8
crc32q	-0x48(%rdx), %r9
crc32q	-0x48(%r11), %r10
crc_8:
endbr64
crc32q	-0x40(%rcx), %r8
crc32q	-0x40(%rdx), %r9
crc32q	-0x40(%r11), %r10
crc_7:
endbr64
crc32q	-0x38(%rcx), %r8
crc32q	-0x38(%rdx), %r9
crc32q	-0x38(%r11), %r10
crc_6:
endbr64
crc32q	-0x30(%rcx), %r8
crc32q	-0x30(%rdx), %r9
crc32q	-0x30(%r11), %r10
crc_5:
endbr64
crc32q	-0x28(%rcx), %r8
crc32q	-0x28(%rdx), %r9
crc32q	-0x28(%r11), %r10
crc_4:
endbr64
crc32q	-0x20(%rcx), %r8
crc32q	-0x20(%rdx), %r9
crc32q	-0x20(%r11), %r10
crc_3:
endbr64
crc32q	-0x18(%rcx), %r8
crc32q	-0x18(%rdx), %r9
crc32q	-0x18(%r11), %r10
crc_2:
endbr64
crc32q	-0x10(%rcx), %r8
crc32q	-0x10(%rdx), %r9
crc32q	-0x10(%r11), %r10
next_:
crc_1:
crc32q	-0x8(%rcx), %r8
crc32q	-0x8(%rdx), %r9
movq	%r11, %rcx
leaq	K_table-16(%rip), %rdi
shlq	$0x3, %rax
subq	%rax, %rbx
shlq	%rax
subq	%rax, %rbx
addq	%rax, %rdi
movdqa	(%rdi), %xmm0
movq	%r8, %xmm1
pclmulqdq	$0x0, %xmm0, %xmm1
movq	%r9, %xmm2
pclmulqdq	$0x10, %xmm0, %xmm2
pxor	%xmm2, %xmm1
movq	%xmm1, %rax
xorq	-0x8(%r11), %rax
movq	%r10, %r8
crc32q	%rax, %r8
crc_0:
movq	%rbx, %rsi
cmpq	$0xc00, %rbx
jae	full_block
cmpq	$0x18, %rbx
jae	continue_block
fewer_than_24:
cmpq	$0x10, %rbx
jae	do_16
cmpq	$0x8, %rbx
jae	do_8
shll	$0x1d, %ebx
je	do_return
check_4:
movq	(%rcx), %rdi
shll	%ebx
jae	check_2
crc32l	%edi, %r8d
je	do_return
shrq	$0x20, %rdi
check_2:
shll	%ebx
jae	check_1
crc32w	%di, %r8d
je	do_return
shrq	$0x10, %rdi
check_1:
crc32b	%dil, %r8d
do_return:
movq	%r8, %rax
popq	%rsi
popq	%rdi
popq	%rbx
retq
do_8:
crc32q	(%rcx), %r8
addq	$0x8, %rcx
shll	$0x1d, %ebx
jne	check_4
movq	%r8, %rax
popq	%rsi
popq	%rdi
popq	%rbx
retq
do_16:
crc32q	(%rcx), %r8
crc32q	0x8(%rcx), %r8
addq	$0x10, %rcx
shll	$0x1d, %ebx
jne	check_4
movq	%r8, %rax
popq	%rsi
popq	%rdi
popq	%rbx
retq
less_than_8:
testq	$0x4, %rsi
je	less_than_4
crc32l	(%rdi), %r8d
addq	$0x4, %rdi
less_than_4:
testq	$0x2, %rsi
je	less_than_2
crc32w	(%rdi), %r8d
addq	$0x2, %rdi
less_than_2:
testq	$0x1, %rsi
je	do_return
crc32b	(%rdi), %r8d
movq	%r8, %rax
popq	%rsi
popq	%rdi
popq	%rbx
retq
small:
movq	%r8, %rax
bit8:
shlb	%sil
jae	bit7
crc32q	(%rcx), %rax
crc32q	0x8(%rcx), %rax
crc32q	0x10(%rcx), %rax
crc32q	0x18(%rcx), %rax
crc32q	0x20(%rcx), %rax
crc32q	0x28(%rcx), %rax
crc32q	0x30(%rcx), %rax
crc32q	0x38(%rcx), %rax
crc32q	0x40(%rcx), %rax
crc32q	0x48(%rcx), %rax
crc32q	0x50(%rcx), %rax
crc32q	0x58(%rcx), %rax
crc32q	0x60(%rcx), %rax
crc32q	0x68(%rcx), %rax
crc32q	0x70(%rcx), %rax
crc32q	0x78(%rcx), %rax
je	do_return2
addq	$0x80, %rcx
bit7:
shlb	%sil
jae	bit6
crc32q	(%rcx), %rax
crc32q	0x8(%rcx), %rax
crc32q	0x10(%rcx), %rax
crc32q	0x18(%rcx), %rax
crc32q	0x20(%rcx), %rax
crc32q	0x28(%rcx), %rax
crc32q	0x30(%rcx), %rax
crc32q	0x38(%rcx), %rax
je	do_return2
addq	$0x40, %rcx
bit6:
shlb	%sil
jae	bit5
crc32q	(%rcx), %rax
crc32q	0x8(%rcx), %rax
crc32q	0x10(%rcx), %rax
crc32q	0x18(%rcx), %rax
je	do_return2
addq	$0x20, %rcx
bit5:
shlb	%sil
jae	bit4
crc32q	(%rcx), %rax
crc32q	0x8(%rcx), %rax
je	do_return2
addq	$0x10, %rcx
bit4:
shlb	%sil
jae	bit3
crc32q	(%rcx), %rax
je	do_return2
addq	$0x8, %rcx
bit3:
movq	(%rcx), %rbx
shlb	%sil
jae	bit2
crc32l	%ebx, %eax
je	do_return2
shrq	$0x20, %rbx
bit2:
shlb	%sil
jae	bit1
crc32w	%bx, %eax
je	do_return2
shrq	$0x10, %rbx
bit1:
testb	%sil, %sil
je	do_return2
crc32b	%bl, %eax
do_return2:
popq	%rsi
popq	%rdi
popq	%rbx
retq
nop
nop
	.section .data
	.p2align 6
K_table:
	.byte 214,11,208,76,1,0,0,0,240,118,236,5,1,0,0,0
	.byte 142,194,79,186,0,0,0,0,214,11,208,76,1,0,0,0
	.byte 218,99,44,216,1,0,0,0,254,13,12,242,0,0,0,0
	.byte 248,221,74,158,0,0,0,0,142,194,79,186,0,0,0,0
	.byte 150,178,211,57,0,0,0,0,58,166,74,56,1,0,0,0
	.byte 162,184,249,2,1,0,0,0,218,99,44,216,1,0,0,0
	.byte 230,245,55,66,1,0,0,0,4,29,41,28,0,0,0,0
	.byte 146,96,59,13,0,0,0,0,248,221,74,158,0,0,0,0
	.byte 192,253,108,201,0,0,0,0,2,239,14,116,0,0,0,0
	.byte 86,228,102,130,1,0,0,0,150,178,211,57,0,0,0,0
	.byte 62,231,236,218,0,0,0,0,236,110,58,8,0,0,0,0
	.byte 42,255,122,171,0,0,0,0,162,184,249,2,1,0,0,0
	.byte 116,165,142,36,1,0,0,0,150,57,115,193,1,0,0,0
	.byte 50,136,52,131,0,0,0,0,230,245,55,66,1,0,0,0
	.byte 36,49,116,44,1,0,0,0,48,28,217,42,0,0,0,0
	.byte 134,43,224,185,0,0,0,0,146,96,59,13,0,0,0,0
	.byte 78,58,179,24,0,0,0,0,162,206,146,105,0,0,0,0
	.byte 106,226,49,179,1,0,0,0,192,253,108,201,0,0,0,0
	.byte 70,186,53,125,1,0,0,0,72,128,144,126,0,0,0,0
	.byte 138,139,46,191,1,0,0,0,86,228,102,130,1,0,0,0
	.byte 138,150,224,163,1,0,0,0,216,249,209,30,1,0,0,0
	.byte 244,57,127,206,0,0,0,0,62,231,236,218,0,0,0,0
	.byte 86,46,216,97,0,0,0,0,94,245,208,241,0,0,0,0
	.byte 162,241,112,210,0,0,0,0,42,255,122,171,0,0,0,0
	.byte 108,246,245,195,1,0,0,0,168,184,122,168,0,0,0,0
	.byte 172,218,208,46,1,0,0,0,116,165,142,36,1,0,0,0
	.byte 100,59,134,101,0,0,0,0,0,216,98,132,0,0,0,0
	.byte 142,79,239,30,1,0,0,0,50,136,52,131,0,0,0,0
	.byte 76,245,84,238,1,0,0,0,168,17,209,113,0,0,0,0
	.byte 40,44,227,179,0,0,0,0,36,49,116,44,1,0,0,0
	.byte 38,127,79,6,0,0,0,0,198,82,216,255,0,0,0,0
	.byte 12,59,126,221,0,0,0,0,134,43,224,185,0,0,0,0
	.byte 28,101,133,242,0,0,0,0,164,122,177,220,0,0,0,0
	.byte 60,111,116,16,0,0,0,0,78,58,179,24,0,0,0,0
	.byte 164,254,74,194,1,0,0,0,238,90,124,243,0,0,0,0
	.byte 68,152,29,39,0,0,0,0,106,226,49,179,1,0,0,0
	.byte 12,106,118,142,0,0,0,0,162,213,81,96,0,0,0,0
	.byte 48,247,165,147,0,0,0,0,70,186,53,125,1,0,0,0
	.byte 92,142,176,108,0,0,0,0,14,162,92,29,1,0,0,0
	.byte 178,159,116,107,0,0,0,0,138,139,46,191,1,0,0,0
	.byte 242,148,127,22,1,0,0,0,156,217,243,33,0,0,0,0
	.byte 46,102,195,206,0,0,0,0,138,150,224,163,1,0,0,0
	.byte 74,99,41,147,1,0,0,0,20,128,21,143,0,0,0,0
	.byte 106,78,252,230,0,0,0,0,244,57,127,206,0,0,0,0
	.byte 138,187,39,130,0,0,0,0,6,33,232,165,1,0,0,0
	.byte 104,71,205,176,0,0,0,0,86,46,216,97,0,0,0,0
	.byte 196,137,43,60,1,0,0,0,178,90,129,136,1,0,0,0
	.byte 92,130,164,215,0,0,0,0,162,241,112,210,0,0,0,0
	.byte 186,242,95,15,1,0,0,0,62,95,64,5,1,0,0,0
	.byte 18,211,103,1,0,0,0,0,108,246,245,195,1,0,0,0
	.byte 68,101,7,246,0,0,0,0,150,247,173,233,0,0,0,0
	.byte 10,166,246,38,0,0,0,0,172,218,208,46,1,0,0,0
	.byte 78,183,173,162,1,0,0,0,52,139,99,150,0,0,0,0
	.byte 58,175,52,157,1,0,0,0,100,59,134,101,0,0,0,0
	.byte 156,204,195,73,0,0,0,0,160,133,5,229,1,0,0,0
	.byte 122,232,188,104,0,0,0,0,142,79,239,30,1,0,0,0
	.byte 198,166,79,82,1,0,0,0,220,105,28,159,1,0,0,0
	.byte 202,138,186,108,1,0,0,0,76,245,84,238,1,0,0,0
	.byte 136,136,217,66,0,0,0,0,62,52,19,41,1,0,0,0
	.byte 126,159,157,50,1,0,0,0,40,44,227,179,0,0,0,0
	.byte 40,149,198,177,1,0,0,0,58,90,242,136,0,0,0,0
	.byte 58,81,120,33,0,0,0,0,38,127,79,6,0,0,0,0
	.byte 158,19,172,224,0,0,0,0,176,240,54,78,0,0,0,0
	.byte 250,118,0,23,0,0,0,0,12,59,126,221,0,0,0,0
	.byte 226,162,161,65,1,0,0,0,248,129,111,189,0,0,0,0
	.byte 180,40,216,106,1,0,0,0,28,101,133,242,0,0,0,0
	.byte 100,123,209,65,0,0,0,0,186,203,37,148,1,0,0,0
	.byte 102,204,225,250,1,0,0,0,60,111,116,16,0,0,0,0
	.byte 0,75,91,167,1,0,0,0,138,126,179,141,1,0,0,0
	.byte 76,229,114,248,0,0,0,0,164,254,74,194,1,0,0,0
	.byte 252,233,65,30,0,0,0,0,50,73,20,76,0,0,0,0
	.byte 210,228,216,134,0,0,0,0,68,152,29,39,0,0,0,0
	.byte 122,175,247,96,1,0,0,0,2,143,20,82,0,0,0,0
	.byte 188,241,184,91,0,0,0,0,12,106,118,142,0,0,0,0
	.byte 122,210,15,169,0,0,0,0,122,243,198,163,0,0,0,0
	.byte 122,7,175,179,0,0,0,0,48,247,165,147,0,0,0,0
	.byte 130,215,132,73,0,0,0,0,142,35,44,210,1,0,0,0
	.byte 172,243,110,202,0,0,0,0,92,142,176,108,0,0,0,0
	.byte 38,11,78,35,0,0,0,0,106,208,222,99,0,0,0,0
	.byte 74,189,138,216,1,0,0,0,178,159,116,107,0,0,0,0
	.byte 106,69,151,69,0,0,0,0,60,151,86,77,0,0,0,0
	.byte 180,142,226,233,0,0,0,0,242,148,127,22,1,0,0,0
	.byte 122,245,63,123,0,0,0,0,46,191,133,147,1,0,0,0
	.byte 130,183,200,201,0,0,0,0,46,102,195,206,0,0,0,0
	.byte 158,186,156,58,1,0,0,0,138,243,23,228,0,0,0,0
	.byte 164,6,225,147,0,0,0,0,74,99,41,147,1,0,0,0
	.byte 156,26,0,103,1,0,0,0,128,121,114,78,1,0,0,0
	.byte 212,197,255,221,1,0,0,0,106,78,252,230,0,0,0,0
	.byte 128,70,240,13,0,0,0,0,252,184,4,209,0,0,0,0
	.byte 30,0,66,35,0,0,0,0,138,187,39,130,0,0,0,0
	.byte 126,141,42,10,0,0,0,0,48,119,57,91,0,0,0,0
	.byte 166,63,118,104,1,0,0,0,104,71,205,176,0,0,0,0
	.byte 122,64,90,237,1,0,0,0,22,180,142,231,0,0,0,0
	.byte 26,237,195,210,0,0,0,0,196,137,43,60,1,0,0,0
	.byte 36,87,90,153,0,0,0,0,240,120,19,100,1,0,0,0
	.byte 196,251,26,155,1,0,0,0,92,130,164,215,0,0,0,0
	.byte 192,237,255,9,1,0,0,0,28,85,150,141,0,0,0,0
	.byte 96,30,39,242,0,0,0,0,186,242,95,15,1,0,0,0
	.byte 202,248,11,11,0,0,0,0,210,13,248,11,0,0,0,0
	.byte 122,139,136,35,1,0,0,0,18,211,103,1,0,0,0,0
	.byte 220,247,136,232,1,0,0,0,28,221,205,141,1,0,0,0
	.byte 178,3,238,2,0,0,0,0,68,101,7,246,0,0,0,0
	.byte 254,216,232,131,1,0,0,0,178,210,69,106,0,0,0,0
	.byte 66,160,215,51,1,0,0,0,10,166,246,38,0,0,0,0
	.byte 12,245,176,22,1,0,0,0,232,16,62,221,1,0,0,0
	.byte 112,230,171,95,0,0,0,0,78,183,173,162,1,0,0,0
	.byte 136,68,0,48,1,0,0,0,108,128,135,222,0,0,0,0
	.byte 246,245,188,0,0,0,0,0,58,175,52,157,1,0,0,0
	.byte 120,112,12,143,1,0,0,0,84,135,51,20,0,0,0,0
	.byte 152,118,242,23,0,0,0,0,156,204,195,73,0,0,0,0
	.byte 0,95,202,88,0,0,0,0,238,119,62,94,1,0,0,0
	.byte 36,12,144,175,1,0,0,0,122,232,188,104,0,0,0,0
	.byte 40,202,207,181,0,0,0,0,142,68,7,221,0,0,0,0
	.byte 248,136,210,222,0,0,0,0,198,166,79,82,1,0,0,0
	.byte 188,41,242,89,0,0,0,0,72,131,4,216,1,0,0,0
	.byte 236,13,57,109,0,0,0,0,202,138,186,108,1,0,0,0
	.byte 144,3,23,55,0,0,0,0,44,224,227,163,0,0,0,0
	.byte 204,193,83,99,0,0,0,0,136,136,217,66,0,0,0,0
	.byte 92,79,88,196,0,0,0,0,234,123,60,215,0,0,0,0
	.byte 24,52,106,241,1,0,0,0,126,159,157,50,1,0,0,0
	.byte 226,119,19,83,0,0,0,0,98,118,19,133,1,0,0,0
	.byte 124,202,217,216,1,0,0,0,40,149,198,177,1,0,0,0
	.byte 242,41,91,178,0,0,0,0,188,181,8,138,1,0,0,0
	.byte 176,168,178,159,1,0,0,0,58,81,120,33,0,0,0,0
	.byte 172,230,143,160,1,0,0,0,224,138,117,218,1,0,0,0
	.byte 78,223,205,69,0,0,0,0,158,19,172,224,0,0,0,0
	.byte 242,71,22,169,1,0,0,0,176,158,207,105,1,0,0,0
	.byte 196,23,247,160,1,0,0,0,250,118,0,23,0,0,0,0
	.section .rodata_in_text
jump_table:
	.size jump_table, 258
	.byte 15,34,183,33,158,33,133,33,108,33,83,33,58,33,33,33
	.byte 8,33,239,32,214,32,189,32,164,32,139,32,114,32,89,32
	.byte 64,32,30,32,252,31,218,31,184,31,150,31,116,31,82,31
	.byte 48,31,14,31,236,30,202,30,168,30,134,30,100,30,66,30
	.byte 32,30,254,29,220,29,186,29,152,29,118,29,84,29,50,29
	.byte 16,29,238,28,204,28,170,28,136,28,102,28,68,28,34,28
	.byte 0,28,222,27,188,27,154,27,120,27,86,27,52,27,18,27
	.byte 240,26,206,26,172,26,138,26,104,26,70,26,36,26,2,26
	.byte 224,25,190,25,156,25,122,25,88,25,54,25,20,25,242,24
	.byte 208,24,174,24,140,24,106,24,72,24,38,24,4,24,226,23
	.byte 192,23,158,23,124,23,90,23,56,23,22,23,244,22,210,22
	.byte 176,22,142,22,108,22,74,22,40,22,6,22,228,21,194,21
	.byte 160,21,126,21,92,21,58,21,24,21,246,20,212,20,178,20
	.byte 144,20,110,20,76,20,42,20,8,20,230,19,196,19,162,19
	.byte 128,19,94,19,60,19,26,19,248,18,214,18,180,18,146,18
	.byte 112,18,78,18,44,18,10,18,232,17,198,17,164,17,130,17
	.byte 96,17
