#include <libswscale/swscale.h>
#include <libavutil/pixfmt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

static uint8_t *rows_before_guard(size_t bytes) {
    size_t page = (size_t)getpagesize();
    size_t span = ((bytes + page - 1) / page) * page;
    uint8_t *base = mmap(NULL, span + page, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
    mprotect(base + span, page, PROT_NONE);
    uint8_t *start = base + span - bytes;
    memset(start, 0x80, bytes);
    return start;
}

int main(int argc, char **argv) {
    int w = 16, h = 4;
    int first_slice = argc > 1 ? atoi(argv[1]) : 3;
    struct SwsContext *c = sws_getContext(w, h, AV_PIX_FMT_NV24, w, h, AV_PIX_FMT_YUV420P, SWS_POINT, NULL, NULL, NULL);
    uint8_t *y = calloc(w * h, 1), *uv = calloc(2 * w * h, 1);
    uint8_t *dst[3] = {calloc(w * h, 1), calloc(w * h / 4, 1), calloc(w * h / 4, 1)};
    int dst_stride[3] = {w, w / 2, w / 2};
    int src_stride[4] = {w, 2 * w, 0, 0};

    const uint8_t *src_a[4] = {y, uv, NULL, NULL};
    printf("slice 0: rows 0..%d\n", first_slice - 1);
    fflush(stdout);
    sws_scale(c, src_a, src_stride, 0, first_slice, dst, dst_stride);

    int rest = h - first_slice;
    uint8_t *y_tail = rows_before_guard((size_t)w * rest);
    uint8_t *uv_tail = rows_before_guard((size_t)2 * w * rest);
    const uint8_t *src_b[4] = {y_tail, uv_tail, NULL, NULL};
    printf("slice 1: rows %d..%d, chroma rows end at a guard page\n", first_slice, h - 1);
    fflush(stdout);
    int r = sws_scale(c, src_b, src_stride, first_slice, rest, dst, dst_stride);
    printf("survived, sws_scale returned %d\n", r);
    return 0;
}
