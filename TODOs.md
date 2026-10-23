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
- [ ] an unbalanced stack pointer at `ret` is only logged, not rejected
- [ ] base-case check of a summary proves facts with trip symbols satisfiable, not implied
- [ ] path merging leaves jump history out of the key; argued sound, not proved for history-dependent discharge
- [ ] `&[*const T]` pointer arrays: row lengths cannot be checked at run time (reported as a finding)
- [ ] red zone is trusted per annotation (`red_zone = 128` on `ccaes_arm_decrypt_key`)
- [ ] bounds on fresh symbols asserted outside a scope are lost on scope rebuild (precision only; fixed on loop release)

## Verification (sweep of 2026-10-23, `bums-check`)

| playground | verified |
|---|---|
| corecrypto | 71/71 |
| graviola | 36/36 |
| openblas aarch64 / x86 | 18/18, 6/8 |
| candle | 15/15 |
| crypto aarch64 / x86 | 82/84, 37/38 |
| bignum | 65/73 |
| rav1d aarch64 / x86 | 376/549, 2/2 |
| ffmpeg | 1206/1391 |

- [ ] timeouts since the summary-validation fixes: p256/p384_montjscalarmul (latch counter reloaded from memory, so no summary), edwards25519_scalarmuldouble, chacha20_poly1305_open/seal, ff_simple_idct*, w_mask_420_16bpc, openblas x86 dscal (borderline) and idamax_k
- [ ] bignum_kmul_32_64 / ksqr_32_64: select condition the engine does not model
- [ ] x86 idamax_k: a concretely decided latch leaves no jump record, so the summary has no counter bound
- [ ] rav1d ipred_z1/z3_fill2: the height latch compares the value before `subs`, which is not in the exit state
- [ ] rav1d main.rs ipred_reverse_8bpc annotation passes n = 1 against an `n % 16` precondition
- [ ] chunks_counted_by_a_clamped_length_are_bounded_by_the_clamp: no relational invariant for a pointer stepped by a fresh `min`
- [ ] sha1_block_data_order_avx2: a loop with two back edges
- [ ] yuv2rgb (64) and the remaining ffmpeg FAILs (59) are untriaged

## Findings to report upstream

- [ ] FFmpeg libswresample `conv_fltp_to_s16_nch_neon`: the C wrapper passes an uninitialised `channels`
- [ ] FFmpeg SBR `hf_apply_noise`: one entry past the row when `kx + m_max == 64` and `m_max` is odd (needs a reproducer)
- [ ] dav1d `save_tmvs_neon`: 8-byte load of the 7-byte `mfmv_sign`
