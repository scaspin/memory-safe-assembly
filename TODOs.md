# General Project TODOs

- [ ] clean up and generalize the loop acceleration protocol
- [ ] stronger post-condition checking
- [ ] do not allow access as a result of overflow (probably have to constrain/precondition inputs)
- [ ] x86
- [ ] s2n_bignum, 
- [ ] fiat crypto from paper
- [ ] vtables
- [ ] s2n-bignum assembly verified
- [ ] s2n-bignum bums version
- [ ] rav1d assembly verified
- [ ] rav1d bums version
- [ ] awslc assembly verified (updated)
- [ ] awslc bums version
- [ ] https://github.com/google/mundane?
- [ ] bums as specs that run in CI
- [ ] cryptol/saw
- [ ] bug suite working (after x86)
- [ ] find all the "isolated" asm out there, can we do all of it? what can we not do?
- [ ] overheads
- [ ] inline asm
- [ ] a tensor library? candle?
- [ ] compare with rust crypto
- [ ] optimize our rust rewrites
- [ ] preconditions/postconditions integrated into flux
- [ ] preconditions/postconditions integrated into https://crates.io/crates/cargo-anneal
- [ ] lean backend from sail? 
- [ ] derive preconditions? 
- [ ] before/after comparison to make sure asm optimizations are safe? (rav1d bounty)
## Soundness

- [ ] pinned trip counts check only the first and last iteration; sound only for addresses affine in the loop counter (`%`, `&`, counter·symbol terms break it)
- [ ] path merging leaves jump history out of the key; argued sound, not proved for history-dependent discharge
- [ ] `&[*const T]` pointer arrays: row lengths cannot be checked at run time (reported as a finding)
- [ ] red zone is trusted per annotation (`red_zone = 128` on `ccaes_arm_decrypt_key`)
- [ ] bounds on fresh symbols asserted outside a scope are lost on scope rebuild (precision only; fixed on loop release)
- [ ] round generalization does not check that a covered round took the same prefix decisions as the generalized one
- [ ] AArch64 32-bit arguments assume clean upper bits (the ABI leaves bits 32-63 unspecified)

## Loop acceleration structure

- [ ] a `LoopFact` type that carries its justification (defining, proved, or assumed) instead of plain comparisons
- [ ] one bound representation: unify `Bound`, `LinearForm` and `Affine`
- [ ] state the join of invariants, cells and bounds as one lattice operation with documented semantics
- [ ] an explicit lifecycle state machine for a loop (attempted, open, closed, refuted, abandoned) in place of scattered flags

## Verification (final sweep of 2026-10-23, `bums-check`, after the soundness fixes)

| playground | verified |
|---|---|
| corecrypto | 71/71 |
| graviola | 36/36 |
| openblas aarch64 / x86 | 18/18, 6/8 |
| candle | 15/15 |
| crypto aarch64 / x86 | 82/84, 37/38 |
| bignum | 65/73 |
| rav1d aarch64 / x86 | 374/549, 2/2 |
| ffmpeg | 1208/1391 |

- [ ] timeouts since the summary-validation fixes: p256/p384_montjscalarmul (latch counter reloaded from memory, so no summary), chacha20_poly1305_open/seal, ff_simple_idct*, w_mask_420_16bpc, openblas x86 dscal (borderline) and idamax_k
- [ ] rav1d ipred_pixel_set_8bpc times out (also at 08a11aa1; its `verified` row was stale). Re-sweep after the seven soundness fixes: candle, openblas, crypto, corecrypto and rav1d ipred/mc lost no verdict
- [ ] bignum_kmul_32_64 / ksqr_32_64: select condition the engine does not model
- [ ] x86 idamax_k: a concretely decided latch leaves no jump record, so the summary has no counter bound
- [ ] rav1d ipred_z1/z3_fill2: the height latch compares the value before `subs`, which is not in the exit state
- [ ] rav1d main.rs ipred_reverse_8bpc annotation passes n = 1 against an `n % 16` precondition
- [ ] rav1d ipred.rs ipred_z2_upsample_edge_8bpc annotation allows hsz = 4 (out.len() == 8) while the code writes 17 bytes (also FAIL at 2dfe44dd; its `verified` row was stale)
- [ ] ffmpeg hevc epel/qpel_uni_w_h32_8 pass the 4 GB cap of bums-check (verified with --mem-gb 10); qpel_hv24_8_i8mm, curve25519_x25519_byte_alt and rav1d fguv_32x32_422_8bpc / wiener_filter5 sit at the timeout
- [ ] chunks_counted_by_a_clamped_length_are_bounded_by_the_clamp: no relational invariant for a pointer stepped by a fresh `min`
- [ ] sha1_block_data_order_avx2: a loop with two back edges
- [ ] yuv2rgb (64) and the remaining ffmpeg FAILs (59) are untriaged

## Findings to report upstream

- [ ] FFmpeg libswresample `conv_fltp_to_s16_nch_neon`: the C wrapper passes an uninitialised `channels`
- [ ] FFmpeg SBR `hf_apply_noise`: one entry past the row when `kx + m_max == 64` and `m_max` is odd (needs a reproducer)
- [ ] dav1d `save_tmvs_neon`: 8-byte load of the 7-byte `mfmv_sign`
