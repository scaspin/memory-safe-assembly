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
| Row | File | Function | 8/16 | CLAMS-style Loop? | dynamic dispatching? | If dd, how many? | Notes |
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
| 33 | ipred.S/ipred16.s | <mark>33/34</mark> | ? | ? | ? | ? | ? |
| 34 | itx.S/itx16.S | <mark>68/58</mark> | ? | ? | ? | ? | ? |
| 35 | loopfilter.S/loopfilter16.S | <mark>11/12</mark> | ? | ? | ? | ? | ? |
| 36 | looprestoration.S/looprestoration16.S | <mark>11</mark> | ? | ? | ? | ? | ? |
| 37 | looprestoration_common.S | sgr_box3_vert_neon | n | y | n | N/A | Calls "clz", input value bitdepth_max, for calculations |
| 38 | looprestoration_common.S | sgr_box5_vert_neon | n | y | n | N/A | Calls "clz", input value bitdepth_max, for calculations |
| 39 | looprestoration_tmpl.S | sgr_finish_filter1_2rows_\bpc\()bpc_neon | n | y | n | N/A | ? |
| 40 | looprestoration_tmpl.S | sgr_finish_weighted1_\bpc\()bpc_neon | n | y | n | N/A | ? |
| 41 | looprestoration_tmpl.S | sgr_finish_filter2_2rows_\bpc\()bpc_neon | n | y | n | N/A | ? |
| 42 | looprestoration_tmpl.S | sgr_finish_weighted2_\bpc\()bpc_neon | n | y | n | N/A | ? |
| 43 | looprestoration_tmpl.S | sgr_weighted2_\bpc\()bpc_neon | n | y | n | N/A | ? |
| 44 | mc.S/mc16.S | 17 | ? | ? | ? | ? | ? |
| 45 | mc16_sve.S | \op\()_8tap_\type\()_16bpc_\isa | n | ? | ? | ? | Calls \op\()_8tap_\isa |
| 46 | mc16_sve.S | \type\()_8tap_\isa | n | ? | y | 6, \type\()_8tap_h_\isa\()_tbl | ? |
| 47 | mc16_sve.S | prep_sve | n | ? | y, prep_tbl | 6 | ? |
| 48 | mc_dotprod.S | \op\()_8tap_\type\()_8bpc_\isa | n | y | y | 6 | Calls \type\()_8tap_\isa, 9 versions, 6 options in page table (need to get disassembled version on different hardware) |
| 49 | mc_dotprod.S |\type\()_8tap_\isa | n | y | y | 6 | ? |
| 50 | msac.S | msac_decode_symbol_adapt4_neon | n | y (nested in L(refill)) | n | N/A | ? |
| 51 | msac.S | msac_decode_symbol_adapt8_neon | n | y | y, above | ? | Calls into "msac_decode_symbol_adapt4_neon"|
| 52 | msac.S | msac_decode_symbol_adapt16_neon | n | y | y, above | ? | ? |
| 53 | msac.S | msac_decode_hi_tok_neon | n | n (but interesting jump behavior) | n | N/A | ? |
| 54 | msac.S | msac_decode_bool_equi_neon | n | n | n | N/A | Jump to L(refill) |
| 55 | msac.S | msac_decode_bool_neon | n | n | n | N/A | Jump to L(refill) |
| 56 | msac.S | msac_decode_bool_adapt_neon | n | n | n | N/A | Jump to L(refill) |
| 57 | refmvs.S | splat_mv_neon | n | y | y | 6, jumptable splat_tbl (.word 320b - splat_tbl ... .word 10b - splat_tbl) endjumptable| ? |
| 58 | refmvs.S | save_tmvs_neon | n | y | y | 44, jumptable save_tmvs_tbl | ? |
| 59 | refmvs.S | load_tmvs_neon | n | y? | n | N/A | xloop and yloop, many jumps, maybe good example |
| 60 | util.S | NONE | ? | ? | ? | ? | ? |
