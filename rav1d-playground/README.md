# Rav1d AArch64 Assembly Overview

## Recent relevant bugs
- [looprestoration](https://github.com/memorysafety/rav1d/commit/4700887e4a34d4e0e215bcc80d23e200d9e76e36) "After processing one block, this accidentally jumped to the loop for processing two lines at once."
- [looprestoration](https://github.com/memorysafety/rav1d/commit/e2cdf5118c1c93329a52e9b37c140740ef59ba6c) "The missed register was meant to compare h with 2, but accidentally ended up comparing bitdepth_max to 2. In the case of 8 bpc, there's actually no bitdepth_max parameter, so it ended up comparing an uninitialized value."
- [oob in dotprod](https://github.com/memorysafety/rav1d/commit/1dbb78d6f7fe0c83cf7d778f914169996f96098e)

## Notes
- "clz" often used to determine index into jumptables based on input widths
- "pri_taps" is offsets to ensure filtering/padding in the same direction, not data dependent, but can be encoded as a lookup table

## Categorization of asm routines
<!-- add "called by Rust code column -->
| # | File | Function | 8/16 | CLAMS-style Loop? | dynamic dispatching? | If dd, how many? | Notes |
| --- | ---- | ------   | ---- | ---- | ---- | ---- | ---- |
| 1 | cdef.S/cdef16.S | cdef_paddingX_8bpc_neon | y | y | n | N/A | if/def for width == 8 |
| 2 | cdef.S/cdef16.S | cdef_paddingX_edged_8bpc_neon | y | y | n | N/A | if/def for width == 4 |
| 3 | cdef.S/cdef16.S | cdef_filterX_edged_8bpc_neon | y | y, nested | n | N/A | Variants based on pri,min, sec, 8bpc taps (defined in cdef_tmpl)|
| 4 | cdef_tmpl.S | cdef_filter\w\suffix\()_\bpc\()bpc_neon | n | y | n | N/A | width, bpc, sec, min, pri options |
| 5 | cdef_tmpl.S | cdef_filter\w\()_\bpc\()bpc_neon | n | n | n | N/A | 3 versions: pri, sec, pri+sec+min, each jumping to impl generated in cdef.S |
| 6 | cdef_tmpl.S | cdef_find_dir_\bpc\()bpc_neon | n | n | n | N/A | uses div_table, alt_fact (which are consts so ok) |
| 7 | filmgrain.s/filmgrain16.s | get_gaussian_neon | y | n | n | N/A | Calls "read_rand" and "increment_seed", did not appear in disassembled version locally |
| 8 | filmgrain.s/filmgrain16.s | get_grain_2_neon | y | n | n | N/A | Calls "read_rand", called by other functions through "get_grain_2" |
| 9 | filmgrain.s/filmgrain16.s | output_lag\n\()_neon | y | y | n | N/A | w15 holds the number of entries to produce |
| 10 | filmgrain.s/filmgrain16.s | sum_lag1_above_neon | y | n | n | N/A |  |
| 11 | filmgrain.s/filmgrain16.s | sum_\type\()_lag1_\edge\()_neon | y | ? | ? | ? | n=1,2,3 in disassembly, calls "sum_lag_n_body" which does not loop and does not have dynamic branching|
| 12 | filmgrain.s/filmgrain16.s | sum_lag2_above_neon | y | n | n | N/A | ? |
| 13 | filmgrain.s/filmgrain16.s | sum_\type\()_lag2_\edge\()_neon | y | ? | ? | ? | Calls "sum_lag_n_body" with "lag2", "Store=1" |
| 14 | filmgrain.s/filmgrain16.s | sum_lag3_above_neon | y | n | n | N/A | ? |
| 15 | filmgrain.s/filmgrain16.s | sum_\type\()_lag3_\edge\()_neon | y | ? | ? | ? | Calls "sum_lag_n_body" with "lag3" |
| 16 | filmgrain.s/filmgrain16.s | generate_grain_rows_neon | y | y | n | N/A | Calls "get_grain_row", loops over w1 in -1 |
| 17 | filmgrain.s/filmgrain16.s | generate_grain_rows_44_neon | y | y | n | N/A | Calls "get_grain_row_44", loops over w1 in -1 |
| 18 | filmgrain.s/filmgrain16.s | get_grain_row_neon | y | n | n | N/A | ? |
| 19 | filmgrain.s/filmgrain16.s | get_grain_row_44_neon | y | n | n | N/A | ? |
| 20 | filmgrain.s/filmgrain16.s | add_uv_444_coeff_lag0_neon | y | n | n | N/A | ? |
| 21 | filmgrain.s/filmgrain16.s | add_uv_420_coeff_lag0_neon | y | n | n | N/A | Tail call to "add_coeff_lag0_start" which is main label in 444 function |
| 22 | filmgrain.s/filmgrain16.s | add_uv_422_coeff_lag0_neon | y | n | n | ? | Tail call to "add_coeff_lag0_start" which is main label in 444 function |
| 23 | filmgrain.s/filmgrain16.s | generate_grain_\type\()_8bpc_neon (line 868, gen_grain_44) | y | y | y | 4 in jumptable gen_grain_\type\()_tbl | ? |
| 24 | filmgrain.s/filmgrain16.s | generate_grain_\type\()_8bpc_neon (line 1108, gen_grain_82) | y | y | y | 4 in jumptable gen_grain_\type\()_tbl | ? |
| 25 | filmgrain.s/filmgrain16.s | gather32_neon | y | n | n | N/A | Calls "gather", which calls "gather_interleaved" in source, disassembled simpler |
| 26 | filmgrain.s/filmgrain16.s | gather16_neon | y | n | n | N/A | ? |
| 27 | filmgrain.s/filmgrain16.s | fgy_32x32_8bpc_neon | y | ? | y | 4, .word L(loop_00) - fgy_loop_tbl, .word L(loop_01) - fgy_loop_tbl, .word L(loop_10) - fgy_loop_tbl, .word L(loop_11) - fgy_loop_tbl | ? |
| 28 | filmgrain.s/filmgrain16.s | gy_loop_neon | y | y | n | N/A | ? |
| 29 | filmgrain.s/filmgrain16.s | fguv_32x32_\layout\()_8bpc_neon | y | y | n | N/A |  |
| 30 | filmgrain.s/filmgrain16.s | fguv_loop_sx0_neon | y | y | n | N/A | ? |
| 31 | filmgrain.s/filmgrain16.s | fguv_loop_sx1_neon | y | y | n | N/A | ? |
| 32 | filmgrain16.s | get_grain_4_neon | n | n | n | N/A | ? |
| 33 | ipred.S/ipred16.s | ipred_dc_128_8bpc_neon| y | y | y | 5, ipred_dc_128_tbl | ? |
| 34 | ipred.S/ipred16.s | ipred_v_8bpc_neon| y | y | y | 5, ipred_v_tbl | ? |
| 35 | ipred.S/ipred16.s | ipred_h_8bpc_neon | y | y | y | 5, ipred_h_tbl | ? |
| 36 | ipred.S/ipred16.s | ipred_dc_top_8bpc_neon | y | y | y | 5,ipred_dc_top_tbl | ? |
| 37 | ipred.S/ipred16.s | ipred_dc_left_8bpc_neon | y |  y | y | 10, ipred_dc_left_tbl | ? |
| 38 | ipred.S/ipred16.s | ipred_dc_8bpc_neon | y |  y | y | 10, ipred_dc_tbl | ? |
| 39 | ipred.S/ipred16.s | ipred_paeth_8bpc_neon | y | y, nested | y | 5, ipred_paeth_tbl | ? |
| 40 | ipred.S/ipred16.s | ipred_smooth_8bpc_neon | y | y, nested | y | 5,ipred_smooth_tbl | ? |
| 41 | ipred.S/ipred16.s | ipred_smooth_v_8bpc_neon | y | y | y | 5,ipred_smooth_v_tbl | ? |
| 42 | ipred.S/ipred16.s | ipred_smooth_h_8bpc_neon | y | y, nested | y | 5, ipred_smooth_h_tbl | ? |
| 43 | ipred.S/ipred16.s | ipred_z1_upsample_edge_8bpc_neon| y | n | n | N/A | Uses padding_mask const |
| 44 | ipred.S/ipred16.s | ipred_z2_upsample_edge_8bpc_neon| y | n | n | N/A | From comments: Here, sz is 4 or 8, and we produce 2*sz+1 output elements. |
| 45 | ipred.S/ipred16.s | ipred_z1_filter_edge_8bpc_neon | y | y | n | N/A | Special case for  // if (strength == 3) goto fivetap |
| 46 | ipred.S/ipred16.s | ipred_pixel_set_8bpc_neon | y | y | n | N/A | Simple loop over pixel |
| 47 | ipred.S/ipred16.s | ipred_z1_fill1_8bpc_neon | y | y | y | 5,ipred_z1_fill1_tbl | ? |
| 48 | ipred.S/ipred16.s | ipred_z1_fill2_8bpc_neon | y | y | n | N/A | Branching on width=4 or 8 w/o jumptable |
| 49 | ipred.S/ipred16.s | ipred_reverse_8bpc_neon | y | y | n | N/A | ? |
| 50 | ipred.S/ipred16.s | ipred_z2_fill1_8bpc_neon | y | y | y | 5 ,ipred_z2_fill1_tbl | Huge func |
| 51 | ipred.S/ipred16.s | ipred_z2_fill2_8bpc_neon | y | y | n | N/A | ? |
| 52 | ipred.S/ipred16.s | ipred_z2_fill3_8bpc_neon | y | y | n | N/A | ? |
| 53 | ipred.S/ipred16.s | ipred_z3_fill1_8bpc_neon | y | y | y | 5,ipred_z3_fill1_tbl | ? |
| 54 | ipred.S/ipred16.s | ipred_z3_fill_padding_neon | y | y | y | 6,ipred_z3_fill_padding_tbl | ? |
| 55 | ipred.S/ipred16.s | ipred_z3_fill_padding_wide | y | y, nested | n | N/A | ? |
| 56 | ipred.S/ipred16.s | ipred_z3_fill2_8bpc_neon| y | y | n | N/A | ? |
| 57 | ipred.S/ipred16.s | ipred_filter_8bpc_neon | y| y | y | 4, ipred_filter_tbl | ? |
| 58 | ipred.S/ipred16.s | pal_pred_8bpc_neon | y | y | y | 5, pal_pred_tbl | ? |
| 59 | ipred.S/ipred16.s | ipred_cfl_128_8bpc_neon | y | y | y | 4,ipred_cfl_128_tbl | ? |
| 60 | ipred.S/ipred16.s | ipred_cfl_top_8bpc_neon | y | y | y | 4, ipred_cfl_top_tbl | ? |
| 61 | ipred.S/ipred16.s | ipred_cfl_left_8bpc_neon| y | y | y, but weird | 4, ipred_cfl_splat_tbl +  ipred_cfl_left_tbl| Tailcall to jumptable after jumptable call |
| 62 | ipred.S/ipred16.s | ipred_cfl_8bpc_neon | y | y | y | 8 ,ipred_cfl_tbl | Tailcall |
| 63 | ipred.S/ipred16.s | ipred_cfl_ac_420_8bpc_neon | y | y | y | 3, 4, ipred_cfl_ac_420_tbl, ipred_cfl_ac_420_w16_tbl  | ? |
| 64 | ipred.S/ipred16.s | ipred_cfl_ac_422_8bpc_neon | y | y | y | 3, 4,ipred_cfl_ac_422_tbl, ipred_cfl_ac_422_w16_tbl | ? |
| 65 | ipred.S/ipred16.s | ipred_cfl_ac_444_8bpc_neon | y | y | y | 4, 4, ipred_cfl_ac_444_tbl, ipred_cfl_ac_444_w32_tbl | ? |
| 66 | ipred16.s | ipred_filter_\bpc\()bpc_neon | y | y | y | 4, ipred_filter\bpc\()_tbl | ? |
| 67 | itx.S/itx16.S | idct_dc_w4_neon | y | y | n | N/A | ? |
| 68 | itx.S/itx16.S | idct_dc_w8_neon | y | y | n | N/A | ? |
| 69 | itx.S/itx16.S | idct_dc_w16_neon | y | y | n | N/A | ? |
| 70 | itx.S/itx16.S | idct_dc_w32_neon | y | y | n | N/A | ? |
| 71 | itx.S/itx16.S | idct_dc_w64_neon | y | y | n | N/A | ? |
| 72 | itx.S/itx16.S | inv_dct_4h_x4_neon | y | n | n | N/A | Updates .data, idct_coeffs |
| 73 | itx.S | inv_dct_8h_x4_neon | n | n | n | N/A | Updates .data, idct_coeffs |
| 74 | itx.S/itx16.S | inv_adst_4h_x4_neon | y | n | n | N/A | ? |
| 75 | itx.S/itx16.S | inv_flipadst_4h_x4_neon | y | n | n | N/A  | ? |
| 76 | itx.S | inv_adst_8h_x4_neon | n | n | n | N/A | ? |
| 77 | itx.S | inv_flipadst_8h_x4_neon | n | n | n | N/A | ? |
| 78 | itx.S/itx16.S | inv_identity_4h_x4_neon| y | n | n | N/A | ? |
| 79 | itx.S | inv_identity_8h_x4_neon | n | n | n | N/A | ? |
| 80 | itx.S/itx16.S | inv_txfm_add_wht_wht_4x4_8bpc_neon | y | n | n | N/A | Tailcall in safe file |
| 81 | itx.S/itx16.S | inv_txfm_add_4x4_neon | y | n | y* | ? | *blr used, maybe private? |
| 82 | itx.S/itx16.S | inv_txfm_add_\txfm1\()_\txfm2\()_4x4_8bpc_neon | y | n | n | N/A | Tailcall in same file |
| 83 | itx.S | inv_dct_8h_x8_neon | n | n | n | N/A | ? |
| 84 | itx.S/itx16.S | inv_dct_4h_x8_neon | y | n | n | N/A | ? |
| 85 | itx.S | inv_adst_8h_x8_neon | n | n | n | N/A | ? |
| 86 | itx.S | inv_flipadst_8h_x8_neon | n | n | n | N/A | ? |
| 87 | itx.S/itx16.S | inv_adst_4h_x8_neon | y | n | n | N/A | ? |
| 88 | itx.S/itx16.S | inv_flipadst_4h_x8_neon | y | n | n | N/A | ? |
| 89 | itx.S | inv_identity_8h_x8_neon | n | n | n | N/A | ? |
| 90 | itx.S/itx16.S | inv_identity_4h_x8_neon| y | n | n | N/A | ? |
| 91 | itx.S/itx16.S | inv_txfm_\variant\()add_8x8_neon | n | n | n | N/A | blr called on inputs |
| 92 | itx.S/itx16.S | inv_txfm_add_\txfm1\()_\txfm2\()_8x8_8bpc_neon | y | n | n | N/A | ? |
| 93 | itx.S/itx16.S | inv_txfm_add_8x4_neon | y | n | n | N/A | blr called on inputs |
| 94 | itx.S/itx16.S | inv_txfm_add_4x8_neon | y | n | n | N/A | blr called on inputs
| 95 | itx16.S | inv_txfm_add_4x8_neon | n | n | n | N/A | blr called on inputs
| 96 | itx.S/itx16.S | inv_txfm_add_\txfm1\()_\txfm2\()_\w\()x\h\()_8bpc_neon | y | n | n | N/A | ? |
| 97 | itx.S/itx16.S | inv_dct_8h_x16_neon | n | n | n | N/A | ? |
| 98 | itx.S/itx16.S | inv_dct_4h_x16_neon | y | n | n | N/A | ? |
| 99 | itx.S/itx16.S | inv_adst_8h_x16_neon | n | n | n | N/A | ? |
| 100 | itx.S/itx16.S | inv_flipadst_8h_x16_neon| n | n | n | N/A | ? |
| 101 | itx.S/itx16.S | inv_adst_4h_x16_neon | y | n | n | N/A | ? |
| 102 | itx.S/itx16.S | inv_flipadst_4h_x16_neon | y | n | n | N/A | ? |
| 103 | itx.S/itx16.S | inv_identity_8h_x16_neon | n | n | n | N/A | ? |
| 104 | itx.S/itx16.S | inv_identity_4h_x16_neon | y | n | n | N/A | ? |
| 105 | itx.S/itx16.S | inv_txfm_horz\suffix\()_16x8_neon | y | n | n | N/A | blr called on inputs |
| 106 | itx.S/itx16.S | inv_txfm_add_vert_8x16_neon | y | n | n | N/A  | blr called on inputs |
| 107 | itx.S/itx16.S | inv_txfm_add_16x16_neon | y |  n | n | N/A  | blr called on inputs |
| 108 | itx16.S | inv_txfm_add_4x16_neon | n |  n | n | N/A  | blr called on inputs |
| 109 | itx.S/itx16.S | inv_txfm_add_\txfm1\()_\txfm2\()_16x16_8bpc_neon | y | n | n | N/A | ? |
| 110 | itx.S/itx16.S | inv_txfm_\variant\()add_16x4_neon | y | n | n | N/A | blr called on inputs |
| 111 | itx.S/itx16.S | inv_txfm_add_\txfm1\()_\txfm2\()_\w\()x\h\()_8bpc_neon | y | n | n | N/A | The function that sets the registers for blr in other functions |
| 112 | itx.S/itx16.S | inv_txfm_\variant\()add_16x8_neon | y | n | n | N/A | blr |
| 113 | itx.S/itx16.S | inv_txfm_\variant\()add_8x16_neon | y | n | n | N/A | blr |
| 114 | itx.S/itx16.S | inv_txfm_add_\txfm1\()_\txfm2\()_\w\()x\h\()_8bpc_neon | y | n | n | N/A | blr |
| 115 | itx.S/itx16.S | inv_dct32_odd_8h_x16_neon | y | n | n | N/A | ? | 
| 116 | itx.S | inv_txfm_horz\suffix\()_dct_32x8_neon | n | n | n | N/A | ? |
| 117 | itx16.S | inv_txfm_horz\suffix\()_dct_32x4_neon | n | n | n | N/A | ? |
| 118 | itx.S/itx16.S | inv_txfm_add_vert_dct_8x32_neon | y | n | n | N/A | ? |
| 119 | itx.S/itx16.S | inv_txfm_add_identity_identity_32x32_8bpc_neon | y | y | n | N/A  | ? |
| 120 | itx.S/itx16.S | inv_txfm_add_identity_identity_\w\()x\h\()_8bpc_neon | y | y, nested | n | N/A | def_identity_1632 |
| 121 | itx.S/itx16.S | inv_txfm_add_identity_identity_\w\()x\h\()_8bpc_neon | y | y | n | N/A | def_identity_832 |
| 122 | itx.S/itx16.S | inv_txfm_add_dct_dct_32x32_8bpc_neon | y | y | n | N/A | ? |
| 123 | itx.S/itx16.S | inv_txfm_add_dct_dct_16x32_8bpc_neon | y | y | n | N/A | ? |
| 124 | itx.S/itx16.S | inv_txfm_add_dct_dct_8x32_8bpc_neon | y | y | n | N/A | ? |
| 125 | itx.S/itx16.S | inv_txfm_add_dct_dct_32x8_8bpc_neon | y | y | n | N/A | ? |
| 126 | itx16.S | inv_txfm_add_dct_dct_32x16_16bpc_neon | n | y | n | N/A | ? |
| 127 | itx.S/itx16.S | inv_dct64_step1_neon | y | n | n | N/A | ? |
| 128 | itx.S/itx16.S | inv_dct64_step2_neon | y | y | n | N/A | ? |
| 129 | itx.S/itx16.S | inv_txfm_dct\suffix\()_8h_x64_neon | y, 4s | n | n | N/A | ? |
| 130 | itx.S/itx16.S | inv_txfm_horz_dct_64x8_neon | ? | y | n | N/A | ? |
| 131 | itx16.S | inv_txfm_horz_dct_64x4_neon | n | y | n | N/A | ? |
| 132 | itx.S/itx16.S | inv_txfm_add_vert_dct_8x64_neon | y | y | n | N/A | ? |
| 133 | itx.S/itx16.S | inv_txfm_add_dct_dct_64x64_8bpc_neon | y | y | n | N/A | ? |
| 134 | itx.S/itx16.S | inv_txfm_add_dct_dct_32x64_8bpc_neon | y | y | n | N/A | ? |
| 135 | itx16.S | inv_txfm_add_dct_dct_64x32_8bpc_neon | n | y | n | N/A | ? |
| 136 | itx.S/itx16.S | inv_txfm_add_dct_dct_64x16_8bpc_neon | y | y | n | N/A | ? |
| 137 | itx.S/itx16.S | inv_txfm_add_dct_dct_16x64_8bpc_neon | y | y | n | N/A | ? |
| 138 | loopfilter.S/loopfilter16.S | lpf_v_4_16_neon | y | y, recursive setup | n | N/A | Tailcall |
| 139 | loopfilter.S/loopfilter16.S | lpf_h_4_16_neon | y | y | n | N/A | Calls "lpf_16_wd4" |
| 140 | loopfilter.S/loopfilter16.S | lpf_v_6_16_neon | y | y | n | N/A | Calls "lpf_16_wd6" |
| 141 | loopfilter.S/loopfilter16.S | lpf_h_6_16_neon | y | y | n | N/A | Calls "lpf_16_wd6" |
| 142 | loopfilter.S/loopfilter16.S | lpf_v_8_16_neon | y | y | n | N/A | Calls "lpf_16_wd8" |
| 143 | loopfilter.S/loopfilter16.S | lpf_h_8_16_neon | y | y | n | N/A | Calls "lpf_16_wd8" |
| 144 | loopfilter.S/loopfilter16.S | lpf_v_16_16_neon | y | y | n | N/A | Calls "lpf_16_wd16" |
| 145 | loopfilter.S/loopfilter16.S | lpf_h_16_16_neon | y | y | n | N/A | Calls "lpf_16_wd16" |
| 146 | loopfilter.S/loopfilter16.S | lpf_\dir\()_sb_\type\()_8bpc_neon | y | y | n | N/A | ? |
| 147 | loopfilter.S/loopfilter16.S | lpf_16_wd\wd\()_neon | y | n | n | N/A | Only branches forwards |
| 148 | loopfilter.S/loopfilter16.S | lpf_v_4_16_neon | y | y, recursive setup | n | N/A | Tailcall |
| 149 | loopfilter.S/loopfilter16.S | lpf_h_4_16_neon | y | y | n | N/A | Calls "lpf_16_wd4" |
| 150 | loopfilter.S/loopfilter16.S | lpf_v_6_16_neon | y | y | n | N/A | Calls "lpf_16_wd6" |
| 151 | loopfilter.S/loopfilter16.S | lpf_h_6_16_neon | y | y | n | N/A | Calls "lpf_16_wd6" |
| 152 | loopfilter.S/loopfilter16.S | lpf_v_8_16_neon | y | y | n | N/A | Calls "lpf_16_wd8" |
| 153 | loopfilter.S/loopfilter16.S | lpf_h_8_16_neon | y | y | n | N/A | Calls "lpf_16_wd8" |
| 154 | loopfilter.S/loopfilter16.S | lpf_v_16_16_neon | y | y | n | N/A | Calls "lpf_16_wd16" |
| 155 | loopfilter.S/loopfilter16.S | lpf_h_16_16_neon | y | y | n | N/A | Calls "lpf_16_wd16" |
| 156 | loopfilter.S/loopfilter16.S | lpf_\dir\()_sb_\type\()_8bpc_neon | y | y | n | N/A | ? |
| 157 | looprestoration.S/looprestoration16.S | wiener_filter7_8bpc_neon | y | y | n | N/A | Substracting stack pointer behavior? |
| 158 | looprestoration.S/looprestoration16.S | wiener_filter7_h_8bpc_neon | y | y* | n | N/A | *because loop has two looping conditions, need to figure out if works with current impl |
| 159 | looprestoration.S/looprestoration16.S | wiener_filter7_v_8bpc_neon | y | y | n | N/A | ? |
| 160 | looprestoration.S/looprestoration16.S | wiener_filter7_hv_8bpc_neon | y | y* | n | N/A | *because loop has two looping conditions, need to figure out if works with current impl |
| 161 | looprestoration.S/looprestoration16.S | wiener_filter5_8bpc_neon | y | y | n | N/A | Substracting stack pointer behavior? |
| 162 | looprestoration.S/looprestoration16.S | wiener_filter5_h_8bpc_neon | y | y* | n | N/A | ? |
| 163 | looprestoration.S/looprestoration16.S | wiener_filter5_v_8bpc_neon| y | y | n | N/A | Simple, perhaps good example |
| 164 | looprestoration.S/looprestoration16.S | wiener_filter5_hv_8bpc_neon | y | y* | n | N/A | ? |
| 165 | looprestoration.S/looprestoration16.S | sgr_box3_row_h_8bpc_neon | y | y* | n | N/A | ? |
| 166 | looprestoration.S/looprestoration16.S | sgr_box5_row_h_8bpc_neon | y | y* | n | N/A | ? |
| 167 | looprestoration.S/looprestoration16.S | sgr_box35_row_h_8bpc_neon| y | y* | n | N/A | ? |
| 168 | looprestoration_common.S | sgr_box3_vert_neon | n | y | n | N/A | Calls "clz", input value bitdepth_max, for calculations |
| 169 | looprestoration_common.S | sgr_box5_vert_neon | n | y | n | N/A | Calls "clz", input value bitdepth_max, for calculations |
| 170 | looprestoration_tmpl.S | sgr_finish_filter1_2rows_\bpc\()bpc_neon | n | y | n | N/A | ? |
| 171 | looprestoration_tmpl.S | sgr_finish_weighted1_\bpc\()bpc_neon | n | y | n | N/A | ? |
| 172 | looprestoration_tmpl.S | sgr_finish_filter2_2rows_\bpc\()bpc_neon | n | y | n | N/A | ? |
| 173 | looprestoration_tmpl.S | sgr_finish_weighted2_\bpc\()bpc_neon | n | y | n | N/A | ? |
| 174 | looprestoration_tmpl.S | sgr_weighted2_\bpc\()bpc_neon | n | y | n | N/A | ? |
| 175 | mc.S/mc16.S | \type\()_8bpc_neon | y | y | y | 8, in \type\()_tbl | Uses "\type" instruction, three types: w_avg, and mask |
| 176 | mc.S/mc16.S | w_mask_\type\()_8bpc_neon | y | 2, non-nested | y | 6, w_mask_\type\()_tbl | type=420,422,444 options |
| 177 | mc.S/mc16.S | blend_8bpc_neon | y | y, 3 non-nested | y | 4, blend_tbl | ? |
| 178 | mc.S/mc16.S | blend_h_8bpc_neon | y | y, 4 non-nested (for jumptable) and 1 nested (for 321/32 option) | y | 7, blend_h_tbl | ? |
| 179 | mc.S/mc16.S | blend_v_8bpc_neon | y | y | y | 5 , blend_v_tbl | ? |
| 180 | mc.S/mc16.S | put_neon/put_16bpc_neon | y | y | y | 7 ,  put_tbl | From comments: This has got the same signature as the put_8tap functions, and assumes that x8 is set to (clz(w)-24). |
| 181 | mc.S/mc16.S | prep_neon/prep_16bpc_neon | y | y | y | 6, prep_tbl | From comments: assumes that x8 is set to (clz(w)-24), and x7 to w*2 |
| 182 | mc.S/mc16.S | \op\()_8tap_\type\()_8bpc_neon | y | ? | ? | ? | A function of macros |
| 183 | mc.S/mc16.S | \type\()_\taps\()_neon | y | y | \type\()_\taps\()_h_tbl | Not just a jumptable, find b based on name | So many macros, expands fine in diassembled |
| 184 | mc.S/mc16.S | L(\type\()_\taps\()_v) | y | ? | y | 7,  \type\()_\taps\()_h_tbl | ? |
| 185 | mc.S/mc16.S | L(\type\()_\taps\()_hv) | y | ? | y | 7, \type\()_\taps\()_hv_tbl | ? |
| 186 | mc.S/mc16.S | \type\()_bilin_8bpc_neon | y | ? | y | 7, \type\()_bilin_h_tbl | ? |
| 187 | mc.S/mc16.S | L(\type\()_bilin_v) | y | ? | y | 7, \type\()_bilin_v_tbl | ? |
| 188 | mc.S/mc16.S | L(\type\()_bilin_hv) | y | ? | y | 7, \type\()_bilin_hv_tbl| ? |
| 189 | mc.S/mc16.S | warp_filter_horz_neon | y | n | n | N/A | ? |
| 190 | mc.S/mc16.S | warp_affine_8x8\t\()_8bpc_neon | y |  y | n | N/A | ? |
| 191 | mc.S/mc16.S | emu_edge_8bpc_neon | y | y | n | N/A | (lots of small loops and interesting branching) |
| 192 | mc16_sve.S | \op\()_8tap_\type\()_16bpc_\isa | n | ? | ? | ? | Calls \op\()_8tap_\isa |
| 193 | mc16_sve.S | \type\()_8tap_\isa | n | ? | y | 6, \type\()_8tap_h_\isa\()_tbl | ? |
| 194 | mc16_sve.S | prep_sve | n | ? | y, prep_tbl | 6 | ? |
| 195 | mc_dotprod.S | \op\()_8tap_\type\()_8bpc_\isa | n | y | y | 6 | Calls \type\()_8tap_\isa, 9 versions, 6 options in page table (need to get disassembled version on different hardware) |
| 196 | mc_dotprod.S |\type\()_8tap_\isa | n | y | y | 6 | ? |
| 197 | msac.S | msac_decode_symbol_adapt4_neon | n | y (nested in L(refill)) | y | N/A | ? |
| 198 | msac.S | msac_decode_symbol_adapt8_neon | n | y | y, above | ? | Calls into "msac_decode_symbol_adapt4_neon"|
| 199 | msac.S | msac_decode_symbol_adapt16_neon | n | y | y, above | ? | ? |
| 190 | msac.S | msac_decode_hi_tok_neon | n | n (but interesting jump behavior) | n | N/A | ? |
| 191 | msac.S | msac_decode_bool_equi_neon | n | n | n | N/A | Jump to L(refill) |
| 192 | msac.S | msac_decode_bool_neon | n | n | n | N/A | Jump to L(refill) |
| 193 | msac.S | msac_decode_bool_adapt_neon | n | n | n | N/A | Jump to L(refill) |
| 194 | refmvs.S | splat_mv_neon | n | y | y | 6, jumptable splat_tbl (.word 320b - splat_tbl ... .word 10b - splat_tbl) endjumptable| ? |
| 195 | refmvs.S | save_tmvs_neon | n | y | y | 44, jumptable save_tmvs_tbl | ? |
| 196 | refmvs.S | load_tmvs_neon | n | y? | n | N/A | xloop and yloop, many jumps, maybe good example |
| 197 | util.S | NONE | ? | ? | ? | ? | ? |
