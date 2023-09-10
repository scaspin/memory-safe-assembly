#!/bin/bash
# bashified makefiles from SymCrypt/lib/makefile.inc

SYMCRYPT_DIR="../SymCrypt"

# Preprocess amd64 .symcryptasm into masm
mkdir -p amd64
for FILE in $SYMCRYPT_DIR/lib/amd64/*.symcryptasm
do
    f="$(basename -- $FILE)"
    f="${f%.*}"
    python3 $SYMCRYPT_DIR/scripts/symcryptasm_processor.py masm amd64 msft $FILE amd64/processed-$f.asm
done

# Process arm64 .symcryptasm into masm
mkdir -p arm64
for FILE in $SYMCRYPT_DIR/lib/arm64/*.symcryptasm
do
    f="$(basename -- $FILE)"
    f="${f%.*}"
    python3 $SYMCRYPT_DIR/scripts/symcryptasm_processor.py armasm64 arm64 aapcs64 $FILE arm64/processed-$f.asm
done

# Process arm64iec .symcryptasm into masm
mkdir -p arm64ec
for FILE in $SYMCRYPT_DIR/lib/arm64/*.symcryptasm
do
    f="$(basename -- $FILE)"
    f="${f%.*}"
    python3 $SYMCRYPT_DIR/scripts/symcryptasm_processor.py armasm64 arm64 arm64ec $FILE arm64ec/processed-$f.asm
done
