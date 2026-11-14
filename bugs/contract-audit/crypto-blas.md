# crypto-blas contract audit

Scope: crypto-playground, bignum-playground, graviola-playground, openblas-playground, candle-playground, corecrypto-playground.
Caller sources: aws-lc checkout (f1468511a, Oct 2024), s2n-bignum, graviola, OpenBLAS, candle (cfcbd71) under $CLAUDE_JOB_DIR/tmp/src. mlkem-native/mldsa-native are not in the aws-lc checkout; their aarch64 `meta.h` glue was read from upstream GitHub (main).

## 1. Candidate bugs (NOT-UPHELD-UNSAFE), most severe first

| # | Function (playground) | Clause | Triggering input | Access | Reachability |
|---|---|---|---|---|---|
| 1 | `<half::f16 as candle_core::cpu::kernels::VecOps>::vec_add` -> `cpu::vec_add_f16` (candle `candle_f16_vecops_vec_add`, `candle_vec_add_f16`) | `lhs.len() == rhs.len() == res.len()` | safe call `f16::vec_add(&[f16; 64], &[], &mut [])` | **writes** `res[0..lhs.len()]` and reads `rhs[0..lhs.len()]`, so a short `res` overflows the heap or stack | Safe public trait method. `candle_core::cpu` is `pub mod` (lib.rs:56), `kernels` is `pub mod` (cpu/mod.rs:5), and `VecOps` is a `pub trait` (kernels.rs:1). The f16 impl (kernels.rs:134-136) passes only `lhs.len()`. The default impl (kernels.rs:7-12) uses `zip` and is safe. I found no internal caller of `VecOps::vec_add`, so this is a soundness hole in the safe API. bf16 `vec_add`/`vec_mul` (kernels.rs:187-193) and `scalar_add` (`xs.len()` drives writes to `ys`) have the same pattern but are not annotated. |
| 2 | `<f16 as GgmlType>::vec_dot` -> `cpu::vec_dot_f16` (candle `candle_f16_vec_dot`, `candle_vec_dot_f16`); the f32 impl is the same | `n <= xs.len(), n <= ys.len()` | safe call `<f16 as GgmlType>::vec_dot(1 << 20, &[], &[])` | **reads** `n` elements past both slices | `GgmlType` is a pub trait in `pub mod k_quants` (quantized/mod.rs:14). The length check is `debug_assert!` only (k_quants.rs:2769-2770 for f16, 2724-2725 for f32), so it is gone in release builds. The internal matmul upholds it: for f16, `BLCK_SIZE` is 1 and the slices are exactly k long (k_quants.rs:2690-2706, 2532). |
| 3 | OpenBLAS x86_64 `damax_k`/`dmax_k` (openblas `damax_k-x86_64.S`, `dmax_k-x86_64.S`; also samax/smax/camax kernels `amax_sse.S`/`zamax_sse.S`, and the min variants) | `inc_x >= 1` | `damax_(&n=10, x, &incx=-1)`, `dmax_`, `damin_`, `dmin_`, `cblas_damax(10, x, -1)` (all exported, exports/gensymbol:56,106) | **reads** `x[-1] .. x[-(n-1)]`, i.e. `(n-1)*|incx|` elements **before** the buffer | interface/max.c:141-153 and 175-187 reject only `n<=0` and `incx==0`. Unlike dot/copy/nrm2, it does not adjust `x` for `incx<0`. kernel/x86_64/amax_sse2.S:61-72 has no `INCX<=0` test and walks with the signed stride. `iamax_sse2.S`, `asum_sse2.S` and `zamax_sse2.S` do test `INCX<=0`. The aarch64 kernels also check (damax_k.S/dmax_k.S: `cmp x2,xzr; b.le` exit), so on ARM the same call returns 0. This is reachable from the public BLAS extension API with a caller-chosen negative stride. Reference-BLAS semantics would return 0. |

No candidate bug found in aws-lc, s2n-bignum, graviola or the mlkem/mldsa callers for any **verified** clause.

## 2. Unique finds / API-CONTRACT assumptions

- **aws-lc CBC with a length that is not a multiple of 16** (crypto `aes_hw_cbc_encrypt` aarch64+x86, `vpaes_cbc_encrypt`). The `input.len() % 16 == 0` clause is only API-CONTRACT. It is documented but not enforced for `AES_cbc_encrypt` (include/openssl/aes.h:127, "must be a multiple of the block size") and for `EVP_Cipher` (include/openssl/cipher.h:459-464, "undefined ... it'll often round the length up and likely read past the buffer"). Effects outside the contract:
  - vpaes-armv8 `vpaes_cbc_encrypt` loops `subs x17,#16; b.hi`, so it processes ceil(len/16) blocks and **reads and writes** up to 15 bytes past `in`/`out`. It is reached through `EVP_Cipher` when !hwaes (e_aes.c:190, aes_cbc_cipher).
  - The x86 aesni `aes_hw_cbc_encrypt` encrypt tail (`.Lcbc_enc_tail`: `rep movsb` then `rep stosb` of `16-len%16` zero bytes into `out`) **writes** up to 15 bytes past `out`.
  - The aesv8 `aes_hw_cbc_encrypt` rounds the length down, but its preload `ld1 {v16},[x0],x8` with x8=16 **reads** up to 15 bytes past `in`.
  - `EVP_EncryptUpdate`/`DecryptUpdate` always pass block multiples. Only raw `EVP_Cipher` and `AES_cbc_encrypt` callers can trip this.
- **`CRYPTO_rndr_multiple8`** (crypto, aarch64). The asm is `cbz` on len==0, then a store loop `sub x1,#8; cbz x1,done`. For len%8 != 0 it never terminates and keeps writing. Both the `>=8` and `%8==0` requirements are real asm requirements (the asm comment says "len = 0 is not supported"). The rndr caller is not in this aws-lc checkout, so I could not check it. The rdrand analogue rounds down to `len & ~7` (rand.c:304-306), and the x86 asm accepts 0.
- **GCM kernels: the clause is tighter than callers, so lengths 16..64 are unverified** (crypto `aes_gcm_enc_kernel`/`aes_gcm_dec_kernel`, clause `input.len() > 64`). aws-lc calls them with `len_blocks >= 16` (gcm.c:153-156, 182, 219). By reading the asm, a length of at most 64 goes straight to `.Lenc_tail` (`cmp x0,x5; b.ge .Lenc_tail` with x5 = in + ((len-1) & ~63)), and the tail dispatches on `end - in`. So this is safe, but BUMS did not prove it. A len of 0 would be unsafe: x5 wraps to in+huge and the main loop runs. The caller excludes 0 (gcm.c:154).
- **Coverage gap: aws-lc does not call the s2n-bignum functions BUMS verified on NEON hardware.** On aarch64, aws-lc calls the `_neon` variants of `bignum_copy_row_from_table_{16,32,8n}` (exponentiation.c:146-153), `bignum_k{mul,sqr}_{16_32,32_64}` (montgomery.c:478-497) and `bignum_emontredc_8n` (montgomery.c:521-523). NEON is always present there. The playground verifies only the non-NEON symbols.
- **aws-lc does not call `sha1_block_data_order_avx2`.** It calls `_avx` under the avx2 capability (sha1.c:399-402), so that annotation covers unreachable code in aws-lc. It is reachable in BoringSSL.
- **graviola `bignum_optsub`, `PosInt::sub`** (graviola `bignum_optsub`, clause `y.len() == z.len()`). Callers such as `p.sub(&one)` (rsa_priv/generate.rs:96-97, 231) pass `y = one.as_words()` of length 1 with z of length `p.used`. The asm reads `y[0..z.len()]` past the slice, but stays inside `b.words: [u64; N]`, so it is memory-safe in practice. Under Rust aliasing rules it still reads outside the slice's provenance. Graviola's wrappers check lengths only with `debug_assert!` (bignum_emontredc_8n.rs:33-34, which also checks `z.len()%8` rather than `m.len()%8`; bignum_mul.rs:109; copy_row_from_table*.rs) or not at all (bignum_optsub.rs:73). The only guarantee is the exact-size dispatch in posint.rs:385-407.
- **OpenBLAS `n * inc_x <= x.len()` is looser than the real buffer.** BLAS only guarantees `(n-1)*|inc|+1` elements (or `2*((n-1)*inc+1)` for complex), so BUMS's proof does not rule out reads in the last `inc-1` slack elements. Manual reading of the strided paths (e.g. ddot_k.S `ddot_k_78`, dnrm2_k.S `dnrm2_k_248`) shows only element-wise `ld1 {v.d}[0],[x],inc` walks, so nothing currently reads the slack. If you want the proof to cover it, tighten the clause to `(n-1)*inc_x + 1 <= x.len()`.
- **mlkem `rej_uniform_asm` table size.** The yaml header says `table[2048]` and the annotation uses 4096. This is already in memory, so I am not re-reporting it, only confirming the header still says 2048.
- **corecrypto ccm\*_encrypt/decrypt.** The asm loads `[x0]` before any count check, so `nblocks >= 1` is a hard requirement. It also indexes `L_ONE` by `ctr_len` (`ldr q5,[x7,w6,uxtw #4]`), so `ctr_len` must stay inside the L_ONE table. I cannot check either against callers (no source).

## 3. NOT-UPHELD-SAFE

- aws-lc `aes_hw_cbc_encrypt` / `aes_hw_ecb_encrypt` `input.len() >= 16`: `EVP_Cipher`/`AES_cbc_encrypt` can pass 0..15. aesv8 does `subs x2,#16; b.lo abort`, aesni ECB does `andq $-16,%rdx; jz ret`, and aesni CBC does `testq %rdx; jz` (then the tail path, see section 2). vpaes CBC does `cbz x2`.
- aws-lc `aes_gcm_{enc,dec}_kernel` `input.len() > 64`: covered in section 2. It is safe for every multiple of 16 that is at least 16.
- OpenBLAS aarch64 `ddot_k`, `sdot_k`, `zdotu_k`, `dcopy_k`, `drot_k`, `daxpy_k`, `saxpy_k`, `zaxpy_k`, `dswap_k`, `dnrm2_k`, plus x86 `zaxpy_k`/`dnrm2_k`, clause `inc >= 1`. For `inc < 0` the interfaces move `x` to the top end (dot.c:63-64, copy.c:76-77, rot.c:73-74, axpy.c:89-90, zaxpy.c:98-99, swap.c:86-87, nrm2.c:99-103, zdot.c:100-101) and pass the negative stride. The strided paths are plain signed post-index walks, which stay inside `[x_orig, x_orig+(n-1)|inc|]`. `inc == 0` (axpy/swap/copy/dot allow it) touches only element 0.
- OpenBLAS aarch64 `dasum_k`, `damax_k`, `dmax_k`, `idamax_k`, `dsum_k`, `zasum_k` and x86 `dasum_k`, `zasum_k`, `idamax_k`, clause `inc >= 1`. asum.c, sum.c and imax.c do not reject `inc <= 0`, but these kernels exit on it (`cmp x2,xzr; b.le` / `testq %rdx; jle`).
- graviola `bignum_optsub` `y.len()==z.len()` in `PosInt::sub`: see section 2.

## 4. Families: one line each

### crypto-playground (aws-lc)
- AES key setup (`aes_hw_set_{en,de}crypt_key`, `vpaes_set_{en,de}crypt_key`; bits 128..256 with %64): UPHELD by aes.c:86 (`bits != 128 && != 192 && != 256 -> -2`). EVP key_len values are fixed. Key length `>= bits/8` is API-CONTRACT on `AES_set_encrypt_key`.
- AES rounds clauses (`keys.1` 10/12/14 aesv8, 9/11/13 aesni and vpaes): UPHELD. Each AES_KEY comes from the matching set_key (aes.c:89-95; e_aes.c:171-198), and the hw GCM kernel only runs when the block function is hwaes (gcm.c:320). The struct is public, so a hand-forged `rounds` value is API-CONTRACT.
- `aes_hw_ctr32_encrypt_blocks` / `vpaes_ctr32_encrypt_blocks` (blocks >= 1): UPHELD. ctr.c:105-121 (`while (len >= 16)`, blocks stays >= 1 after the wrap split) and gcm.c ctr32 paths guarded by `len_blocks != 0`. The BSAES path that passes 0 blocks (e_aes.c:110) is 32-bit ARM only.
- `aesv8_gcm_8x_*` (`len > 128`, rounds ==): UPHELD by gcm.c:163-178 (`len >= 256`, switch on `key->rounds`).
- `aes_gcm_{enc,dec}_kernel`: see section 3. Htable/Xi/ivec fixed sizes match `u128 Htable[16]` and `uint8_t[16]`.
- `aes_hw_cbc_encrypt` / `vpaes_cbc_encrypt` / `aes_hw_ecb_encrypt` `%16`: API-CONTRACT (section 2). The `>=16` clause is NOT-UPHELD-SAFE.
- `vpaes_encrypt` / `vpaes_decrypt` / `aes_hw_{en,de}crypt` (16-byte blocks): UPHELD (block128_f signature).
- GHASH (`gcm_ghash_{neon,v8,clmul,ssse3,avx}` `len >= 16, %16`): UPHELD. gcm.c:417-419, 487, 499-501, 576, 680 all pass `len_blocks != 0` or `GHASH_CHUNK`. The init/gmult functions use fixed sizes.
- SHA-1/SHA-256/SHA-512/MD5 block functions (`num >= 1`, len = 64·num or 128·num): UPHELD by md32_common.h `crypto_md32_update` (`if (n > 0)`), sha512.c:341-346 (`len >= sizeof(c->p)`), and the 1-block final calls.
- `ChaCha20_ctr32_{neon,nohw}` (`len > 0`): UPHELD by chacha.c:113 (`if (in_len > 0)`), chacha.c:150, and internal.h:52 (neon only when `len >= 192`).
- `chacha20_poly1305_{seal,open}` (data layout, extra_ciphertext region): UPHELD. The seal tuple matches `union chacha20_poly1305_seal_data` (cipher_extra/internal.h:174-193, static size 64; open size 48). `extra_ciphertext = out_tag` with `extra_in_len` bytes (e_chacha20poly1305.c:205-206).
- `bn_add_words` / `bn_sub_words` (equal lengths): UPHELD by type, and there is no n>=1 clause.
- `bn_mul_mont` aarch64 (`2 <= num <= 1024`, all equal): UPHELD. montgomery.c:551 and 607 require `num >= 128/BN_BITS2` = 2, montgomery.c:212 caps at BN_MONTGOMERY_MAX_WORDS = 1024, and exponentiation.c:1086 requires `top > 1`.
- p256 fixed-size functions (mul/sqr/neg/point_*, beeu): UPHELD by types. `select_w5` (index 0..16, table 192 u64) and `select_w7` (0..64, 512 u64) are UPHELD by booth_recode_w5/w7 (p256-nistz.c:52-72; 240-274; 333-348). `ord_sqr_mont` rep 1..64 is UPHELD by p256-nistz.c:523-566 (kChain p <= 32, direct calls <= 64).
- `KeccakF1600_hw`: fixed size, UPHELD. `CRYPTO_rdrand_multiple8` (`%8`): UPHELD by rand.c:304 (`len & ~7`). `CRYPTO_rndr_multiple8`: UNCLEAR, caller not in the checkout (section 2).
- mlkem native (ntt/intt/mulcache/reduce/tobytes/tomont/basemul k2-4): fixed sizes match the yaml ABI headers, UPHELD (mlkem-native meta.h only checks NEON). `mlkem_rej_uniform_asm` (`buflen %24`): UPHELD by mlk_rej_uniform_native (`len != MLKEM_N || buflen % 24 != 0` -> fallback).
- mldsa native: `rej_uniform` (`%24`) UPHELD by mld_rej_uniform_native (same guard). `rej_uniform_eta2/eta4` (`%8, >=8`) UPHELD by `buflen == 136 / 272` (MLD_AARCH64_REJ_UNIFORM_ETA{2,4}_BUFLEN). `polyz_unpack_17/19` (576/640 bytes, 64-byte indices) UPHELD by the table sizes. The rest are fixed-size and UPHELD (meta.h only checks NEON).

### bignum-playground (s2n-bignum, aws-lc callers)
- `aes_hw_xts_{en,de}crypt` (`len >= 16`, rounds 10..14 even): UPHELD by mode_wrappers.c:148 (`length < 16 -> 0`) and e_aes.c:659-661, with keys from AES_set_*_key at 128 or 256 bits (e_aes.c:636-645). The asm also checks `cmp x2,#16; b.lt`. It always loads 15 round keys (240 bytes), which stays inside AES_KEY.
- `bignum_copy_row_from_table{,_16,_32,_8n}` (table = height·width, height >= 1, width %8): UPHELD. exponentiation.c:139-158 uses height = 1<<window, the width dispatch is 32/16/%8, and powerbuf_len >= top·(2^window+2) (exponentiation.c:1020-1030). These are the non-NEON variants only (section 2).
- `bignum_emontredc_8n`, `bignum_ge`, `bignum_optsub`, `bignum_mul`, `bignum_sqr`, `bignum_k{mul,sqr}_*`: UPHELD by montgomery.c:134-145 (`num % 8 == 0`), montgomery.c:464-526 (mulres[2·MAX], t[96] >= 72/32/24), and s2n-bignum_aws-lc.h:179-211.
- p256/p384/p521/curve25519/edwards25519/sha3 fixed-size families: UPHELD by types. `bignum_mod_n25519` is called with k=8, in place (curve25519_s2n_bignum_asm.c:66,77,105). Aliasing does not change addresses, so the disjoint-region model is harmless.

### graviola-playground
- Fixed-size p256/p384/25519/keccak functions: UPHELD by Rust array types (graviola low/aarch64/*.rs).
- k{mul,sqr}_16_32/32_64 and emontredc_8n: UPHELD by the exact `(used,used)` match in posint.rs:385-407 (16 or 32 words) and stack arrays [u64; 32/64] (posint.rs:420-475).
- `bignum_copy_row_from_table*`: UPHELD. The mux dispatches on width (aarch64/bignum_copy_row_from_table_mux.rs). The table is 16·n.used words built in posint.rs:588-640, with height=16 (posint.rs:668-674).
- `bignum_optsub`: UPHELD in mont_reduce8 (posint.rs:482-501). NOT-UPHELD-SAFE in `sub` (section 2).

### openblas-playground
- Level-1 families (asum/sum/amax/max/iamax/nrm2/zasum; dot/sdot/zdotu; copy/rot/axpy/saxpy/zaxpy/swap; scal/zscal): `n >= 1` (x86) is UPHELD by every interface's `if (n <= 0) return`. `inc >= 1` is UPHELD for scal/zscal (scal.c:72, zscal.c:86). It is NOT-UPHELD-SAFE for the others, except x86 damax/dmax, which is NOT-UPHELD-UNSAFE (section 1 #3). The `n*inc <= len` clause is looser than BLAS (section 2).

### candle-playground
- K-quant and q4_0/q8_0 `vec_dot`/`vec_dot_4` (`len % block_size`): UPHELD by type, since the slices are `&[BlockQ*]`. The block sizes 84/110/144/176/210/292/18/34 match the structs, and the kernels zip blocks without using n for addresses.
- `candle_f16_vec_reduce`: fixed size, UPHELD.
- `candle_f16_vecops_vec_add` / `candle_vec_add_f16`: NOT-UPHELD-UNSAFE (section 1 #1).
- `candle_f16_vec_dot` / `candle_vec_dot_f16`: UPHELD for internal matmul (k_quants.rs:2690-2706). NOT-UPHELD-UNSAFE through the safe public `GgmlType::vec_dot` (section 1 #2). `VecOps::vec_dot` is an `unsafe fn` with a raw pointer and length, so it is API-CONTRACT; the conv callers pass `c_in` with `c_in`-length buffers (cpu_backend/mod.rs:1066, 1295; conv2d.rs:353).

### corecrypto-playground (source unavailable; UNCLEAR across the board)
- I can only check clauses against the asm. AES rounds as `key.1` in 160..224 step 32 (10/12/14 rounds × 16). ECB/CBC/CFB/OFB/XTS `len == 16·nblocks`. ccm `nblocks >= 1` and `ctr_len 2..8` (hard asm requirements, section 2). `ccn_shift_{left,right}` `k < 64`. `ccn_mul` `r = 2·s`, `t = s`. SHA compress `len == 64/128·nblocks`. gcm `gcm[48]`, `htable[256]`. None of these can be confirmed against callers without corecrypto C sources. The known `ccaes_arm_decrypt_key` red-zone finding is not re-reported.
