#include <libavutil/frame.h>
#include <libavutil/opt.h>
#include <libavutil/pixfmt.h>
#include <libswscale/swscale.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

static uint8_t *ending_at_guard(size_t bytes) {
    size_t page = (size_t)getpagesize();
    size_t span = ((bytes + page - 1) / page) * page;
    uint8_t *base = mmap(NULL, span + page, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
    mprotect(base + span, page, PROT_NONE);
    uint8_t *start = base + span - bytes;
    memset(start, 0x40, bytes);
    return start;
}

static int rgb24_to_yuv420p(int w, int h) {
    struct SwsContext *c = sws_getContext(w, h, AV_PIX_FMT_BGR24, w, h, AV_PIX_FMT_YUV420P, SWS_BILINEAR, NULL, NULL, NULL);
    uint8_t *src = ending_at_guard((size_t)3 * w * h);
    int cw = (w + 1) / 2, ch = (h + 1) / 2;
    uint8_t *dst[3] = {ending_at_guard((size_t)w * h), ending_at_guard((size_t)cw * ch), ending_at_guard((size_t)cw * ch)};
    int dst_stride[3] = {w, cw, cw};
    const uint8_t *srcp[1] = {src};
    int src_stride[1] = {3 * w};
    return sws_scale(c, srcp, src_stride, 0, h, dst, dst_stride);
}

static int yuv420p_to_rgba_threaded(int w, int h, int threads) {
    struct SwsContext *c = sws_alloc_context();
    av_opt_set_int(c, "srcw", w, 0);
    av_opt_set_int(c, "srch", h, 0);
    av_opt_set_int(c, "dstw", w, 0);
    av_opt_set_int(c, "dsth", h, 0);
    av_opt_set_int(c, "src_format", getenv("NV12") ? AV_PIX_FMT_NV12 : AV_PIX_FMT_YUV420P, 0);
    av_opt_set_int(c, "dst_format", AV_PIX_FMT_RGBA, 0);
    av_opt_set_int(c, "sws_flags", SWS_BILINEAR, 0);
    av_opt_set_int(c, "threads", threads, 0);
    if (!getenv("GRAPH_API") && sws_init_context(c, NULL, NULL) < 0) return -1000;
    AVFrame *in = av_frame_alloc(), *out = av_frame_alloc();
    in->width = out->width = w;
    in->height = out->height = h;
    in->format = getenv("NV12") ? AV_PIX_FMT_NV12 : AV_PIX_FMT_YUV420P;
    out->format = AV_PIX_FMT_RGBA;
    av_frame_get_buffer(in, 0);
    for (int p = 0; p < 3 && in->data[p]; p++) memset(in->data[p], 0x50, (size_t)in->linesize[p] * (p ? (h + 1) / 2 : h));
    out->linesize[0] = 4 * w;
    out->data[0] = ending_at_guard((size_t)4 * w * h);
    return sws_scale_frame(c, out, in);
}

int main(int argc, char **argv) {
    const char *which = argv[1];
    int w = atoi(argv[2]), h = atoi(argv[3]);
    int r = !strcmp(which, "rgb24") ? rgb24_to_yuv420p(w, h) : yuv420p_to_rgba_threaded(w, h, atoi(argv[4]));
    printf("%s %dx%d survived, returned %d\n", which, w, h, r);
    return 0;
}
