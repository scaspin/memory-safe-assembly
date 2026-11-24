#!/bin/sh
set -eu

here=$(cd "$(dirname "$0")" && pwd)
work=${WORK:-$here/work}
revision=ee8cbd7dbce9b293905f3088192e4b43ab00c33a
mkdir -p "$work"

if [ ! -d "$work/ffmpeg" ]; then
    mkdir "$work/ffmpeg"
    git -C "$work/ffmpeg" init -q
    git -C "$work/ffmpeg" remote add origin https://github.com/FFmpeg/FFmpeg.git
    git -C "$work/ffmpeg" fetch -q --depth 1 origin "$revision"
    git -C "$work/ffmpeg" checkout -q FETCH_HEAD
fi

if [ ! -f "$work/install/lib/libswscale.a" ]; then
    mkdir -p "$work/build"
    (cd "$work/build" && "$work/ffmpeg/configure" --prefix="$work/install" \
        --disable-everything --disable-programs --disable-doc --disable-avcodec \
        --disable-avformat --disable-avfilter --disable-swresample --disable-avdevice \
        --enable-swscale --enable-static --disable-shared >configure.log &&
        make -j4 >make.log && make install >install.log)
fi

pc="$work/install/lib/pkgconfig"
cflags="-O1 -g -I$work/install/include"
libs=$(PKG_CONFIG_PATH=$pc pkg-config --static --libs libswscale libavutil)
cc $cflags "$here/odd_rows.c" $libs -o "$work/odd_rows"
cc $cflags "$here/nv24_slice.c" $libs -o "$work/nv24_slice"

expect() {
    label=$1
    shift
    if "$@" >/dev/null 2>&1; then status=0; else status=$?; fi
    echo "$label: exit $status"
}

expect "control  nv24 slices 2+2              " "$work/nv24_slice" 2
expect "BUG      nv24 slices 3+1              " "$work/nv24_slice" 3
expect "control  bgr24->yuv420p 640x480       " "$work/odd_rows" rgb24 640 480
expect "BUG      bgr24->yuv420p 640x481       " "$work/odd_rows" rgb24 640 481
expect "control  nv12->rgba 1920x1024, 1 thr  " env NV12=1 GRAPH_API=1 "$work/odd_rows" yuv 1920 1024 1
expect "BUG      nv12->rgba 1920x1024, 6 thr  " env NV12=1 GRAPH_API=1 "$work/odd_rows" yuv 1920 1024 6
expect "safe     yuv420p->rgba 1920x1024, 6   " env GRAPH_API=1 "$work/odd_rows" yuv 1920 1024 6
