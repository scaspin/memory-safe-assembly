	.section .rodata.rav1d_tables,"a",@nobits

	.globl mc_subpel_filters
mc_subpel_filters:
	.zero 720
	.size mc_subpel_filters, 720

	.globl mc_warp_filter
mc_warp_filter:
	.zero 1544
	.size mc_warp_filter, 1544

	.globl sm_weights
sm_weights:
	.zero 128
	.size sm_weights, 128

	.globl filter_intra_taps
filter_intra_taps:
	.zero 320
	.size filter_intra_taps, 320

	.globl obmc_masks
obmc_masks:
	.zero 64
	.size obmc_masks, 64

	.globl gaussian_sequence
gaussian_sequence:
	.zero 4096
	.size gaussian_sequence, 4096
