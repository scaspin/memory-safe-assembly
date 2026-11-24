#!/bin/sh
set -eu

here=$(cd "$(dirname "$0")" && pwd)
awslc=${AWSLC:-/Users/shai/Documents/Princeton/aws-lc}
work=${WORK:-$here/work}
mkdir -p "$work/build"

if [ ! -f "$work/build/crypto/libcrypto.a" ]; then
    (cd "$work/build" &&
        cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DBUILD_TOOL=OFF -DDISABLE_GO=ON \
            -DCMAKE_C_FLAGS="-Wno-error=unterminated-string-initialization" "$awslc" >cmake.log &&
        ninja crypto >ninja.log)
fi

cc -O1 -I"$awslc/include" "$here/cbc_tail.c" "$work/build/crypto/libcrypto.a" -lpthread -Wl,-w -o "$work/cbc_tail"
"$work/cbc_tail"
