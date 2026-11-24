// Tables FFmpeg defines in C that its aarch64 assembly reads, at their C
// sizes so every access is bounded by the real object. The checker needs only
// their extents; the contents are coefficients, zero here.

	.section .rodata
// libavcodec/sbrdsp_template.c: float [544][2]
	.global ff_sbr_noise_table
	.type ff_sbr_noise_table, %object
	.p2align 4
ff_sbr_noise_table:
	.zero 4352
	.size ff_sbr_noise_table, 4352

// libavcodec/vp9dsp.c: int16_t [3][16][8]
	.global ff_vp9_subpel_filters
	.type ff_vp9_subpel_filters, %object
	.p2align 4
ff_vp9_subpel_filters:
	.zero 768
	.size ff_vp9_subpel_filters, 768

// libavcodec/vvc/data.c: int8_t [16][2]
	.global ff_vvc_inter_luma_dmvr_filters
	.type ff_vvc_inter_luma_dmvr_filters, %object
	.p2align 4
ff_vvc_inter_luma_dmvr_filters:
	.zero 32
	.size ff_vvc_inter_luma_dmvr_filters, 32

// libavutil/tx_template.c: TABLE_DEF(53, 12)
	.global ff_tx_tab_53_float
	.type ff_tx_tab_53_float, %object
	.p2align 4
ff_tx_tab_53_float:
	.zero 48
	.size ff_tx_tab_53_float, 48

// libavutil/tx_template.c: SR_TABLE(32), len/4 + 1 floats
	.global ff_tx_tab_32_float
	.type ff_tx_tab_32_float, %object
	.p2align 4
ff_tx_tab_32_float:
	.zero 36
	.size ff_tx_tab_32_float, 36

// libavutil/tx_template.c: SR_TABLE(64), len/4 + 1 floats
	.global ff_tx_tab_64_float
	.type ff_tx_tab_64_float, %object
	.p2align 4
ff_tx_tab_64_float:
	.zero 68
	.size ff_tx_tab_64_float, 68

// libavutil/tx_template.c: SR_TABLE(128), len/4 + 1 floats
	.global ff_tx_tab_128_float
	.type ff_tx_tab_128_float, %object
	.p2align 4
ff_tx_tab_128_float:
	.zero 132
	.size ff_tx_tab_128_float, 132

// libavutil/tx_template.c: SR_TABLE(256), len/4 + 1 floats
	.global ff_tx_tab_256_float
	.type ff_tx_tab_256_float, %object
	.p2align 4
ff_tx_tab_256_float:
	.zero 260
	.size ff_tx_tab_256_float, 260

// libavutil/tx_template.c: SR_TABLE(512), len/4 + 1 floats
	.global ff_tx_tab_512_float
	.type ff_tx_tab_512_float, %object
	.p2align 4
ff_tx_tab_512_float:
	.zero 516
	.size ff_tx_tab_512_float, 516

// libavutil/tx_template.c: SR_TABLE(1024), len/4 + 1 floats
	.global ff_tx_tab_1024_float
	.type ff_tx_tab_1024_float, %object
	.p2align 4
ff_tx_tab_1024_float:
	.zero 1028
	.size ff_tx_tab_1024_float, 1028

// libavutil/tx_template.c: SR_TABLE(2048), len/4 + 1 floats
	.global ff_tx_tab_2048_float
	.type ff_tx_tab_2048_float, %object
	.p2align 4
ff_tx_tab_2048_float:
	.zero 2052
	.size ff_tx_tab_2048_float, 2052

// libavutil/tx_template.c: SR_TABLE(4096), len/4 + 1 floats
	.global ff_tx_tab_4096_float
	.type ff_tx_tab_4096_float, %object
	.p2align 4
ff_tx_tab_4096_float:
	.zero 4100
	.size ff_tx_tab_4096_float, 4100

// libavutil/tx_template.c: SR_TABLE(8192), len/4 + 1 floats
	.global ff_tx_tab_8192_float
	.type ff_tx_tab_8192_float, %object
	.p2align 4
ff_tx_tab_8192_float:
	.zero 8196
	.size ff_tx_tab_8192_float, 8196

// libavutil/tx_template.c: SR_TABLE(16384), len/4 + 1 floats
	.global ff_tx_tab_16384_float
	.type ff_tx_tab_16384_float, %object
	.p2align 4
ff_tx_tab_16384_float:
	.zero 16388
	.size ff_tx_tab_16384_float, 16388

// libavutil/tx_template.c: SR_TABLE(32768), len/4 + 1 floats
	.global ff_tx_tab_32768_float
	.type ff_tx_tab_32768_float, %object
	.p2align 4
ff_tx_tab_32768_float:
	.zero 32772
	.size ff_tx_tab_32768_float, 32772

// libavutil/tx_template.c: SR_TABLE(65536), len/4 + 1 floats
	.global ff_tx_tab_65536_float
	.type ff_tx_tab_65536_float, %object
	.p2align 4
ff_tx_tab_65536_float:
	.zero 65540
	.size ff_tx_tab_65536_float, 65540

// libavutil/tx_template.c: SR_TABLE(131072), len/4 + 1 floats
	.global ff_tx_tab_131072_float
	.type ff_tx_tab_131072_float, %object
	.p2align 4
ff_tx_tab_131072_float:
	.zero 131076
	.size ff_tx_tab_131072_float, 131076

