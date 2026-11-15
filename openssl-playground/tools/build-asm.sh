#!/bin/sh
set -eu
openssl_source=${1:?usage: build-asm.sh OPENSSL_SOURCE_DIR}
playground=$(cd "$(dirname "$0")/.." && pwd)
work=$(mktemp -d)
for arch in aarch64 x86_64; do
    build="$work/linux-$arch"
    mkdir -p "$build" "$playground/asm/$arch"
    (cd "$build" && perl "$openssl_source/Configure" "linux-$arch" no-shared >/dev/null)
    generated=$(grep -oE '^[^ :]+\.(s|S): ' "$build/Makefile" | sed 's/: //' | sort -u)
    (cd "$build" && make -s $generated)
    for file in $generated; do
        name=$(basename "$file")
        out="$playground/asm/$arch/${name%.*}.S"
        case "$file" in
        *.S) clang -E -P -target "$arch-linux-gnu" -I"$openssl_source/include" \
                 -I"$openssl_source/crypto" -I"$openssl_source" -I"$build/include" \
                 -I"$build/crypto" "$build/$file" -o "$out" ;;
        *) cp "$build/$file" "$out" ;;
        esac
    done
done
python3 "$playground/tools/normalize-asm.py" "$playground"/asm/*/*.S
mkdir -p "$work/x86_64-objects" "$work/x86_64-extracted"
for source in "$playground"/asm/x86_64/*.S; do
    clang --target=x86_64-linux-gnu -c "$source" -o "$work/x86_64-objects/$(basename "$source" .S).o"
done
python3 "$playground/../blake3-secp256k1-playground/tools/extract-asm.py" \
    "$work/x86_64-objects" "$work/x86_64-extracted"
cp "$work"/x86_64-extracted/*.S "$playground/asm/x86_64/"
mkdir -p "$work/sve-objects" "$work/sve-extracted"
cat "$playground/asm/aarch64/chacha-armv8.S" "$playground/asm/aarch64/chacha-armv8-sve.S" \
    > "$work/chacha-armv8-with-sve.S"
clang --target=aarch64-linux-gnu -c "$work/chacha-armv8-with-sve.S" -o "$work/sve-objects/chacha-armv8-with-sve.o"
cat "$playground/asm/aarch64/poly1305-armv8.S" "$playground/asm/aarch64/poly1305-armv9-sve2.S" \
    > "$work/poly1305-armv8-with-sve2.S"
clang --target=aarch64-linux-gnu -c "$work/poly1305-armv8-with-sve2.S" -o "$work/sve-objects/poly1305-armv8-with-sve2.o"
for name in chacha-armv8-sve poly1305-armv9-sve2 arm64cpuid; do
    clang --target=aarch64-linux-gnu -c "$playground/asm/aarch64/$name.S" -o "$work/sve-objects/$name.o"
done
python3 "$playground/../blake3-secp256k1-playground/tools/extract-asm.py" \
    "$work/sve-objects" "$work/sve-extracted"
cp "$work"/sve-extracted/*.S "$playground/asm/aarch64/"
rm -rf "$work"
