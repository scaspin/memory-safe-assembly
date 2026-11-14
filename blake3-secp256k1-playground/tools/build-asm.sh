#!/usr/bin/env bash
set -euo pipefail

blake3_c=${1:?usage: build-asm.sh <blake3 crate dir> <secp256k1-sys crate dir> <scratch dir>}
secp=${2:?}/depend/secp256k1
scratch=${3:?}
here=$(cd "$(dirname "$0")/.." && pwd)
blake3_c=$blake3_c/c

rm -rf "$scratch/obj"
mkdir -p "$scratch"/obj/{blake3-x86,blake3-a64,secp-x86asm,secp-x86,secp-a64}

for isa in sse2 sse41 avx2 avx512; do
    clang --target=x86_64-linux-gnu -c "$blake3_c/blake3_${isa}_x86-64_unix.S" -o "$scratch/obj/blake3-x86/blake3_${isa}.o"
done

c_flags=(-O3 -fno-pic -fno-stack-protector -fno-asynchronous-unwind-tables
    -nostdinc -isystem "$(clang -print-resource-dir)/include" -isystem "$(xcrun --show-sdk-path)/usr/include")
clang --target=aarch64-linux-gnu -D__arm64__ "${c_flags[@]}" -I"$blake3_c" -c "$here/tools/blake3_neon_entries.c" -o "$scratch/obj/blake3-a64/blake3_neon.o"

secp_flags=("${c_flags[@]}" -I"$secp" -I"$secp/include" -I"$secp/src" -Wno-unused-function
    -DENABLE_MODULE_ECDH=1 -DENABLE_MODULE_SCHNORRSIG=1 -DENABLE_MODULE_EXTRAKEYS=1
    -DENABLE_MODULE_ELLSWIFT=1 -DENABLE_MODULE_MUSIG=1 -DECMULT_WINDOW_SIZE=15
    -DCOMB_BLOCKS=43 -DCOMB_TEETH=6 -DUSE_EXTERNAL_DEFAULT_CALLBACKS=1)
entries=$here/tools/secp256k1_entries.c
clang --target=x86_64-linux-gnu "${secp_flags[@]}" -DUSE_ASM_X86_64=1 -c "$entries" -o "$scratch/obj/secp-x86asm/secp256k1_x86_asm.o"
clang --target=x86_64-linux-gnu "${secp_flags[@]}" -c "$entries" -o "$scratch/obj/secp-x86/secp256k1_x86.o"
clang --target=aarch64-linux-gnu -D__arm64__ "${secp_flags[@]}" -c "$entries" -o "$scratch/obj/secp-a64/secp256k1_a64.o"

for dir in "$scratch"/obj/*; do
    python3 "$here/tools/extract-asm.py" "$dir" "$here/asm"
done
