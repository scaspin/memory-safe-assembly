#include "secp256k1.c"

#define SECP(name) rustsecp256k1_v0_14_##name

void secp_scalar_mul(SECP(scalar) *r, const SECP(scalar) *a, const SECP(scalar) *b) {
    SECP(scalar_mul)(r, a, b);
}

void secp_scalar_add(SECP(scalar) *r, const SECP(scalar) *a, const SECP(scalar) *b) {
    SECP(scalar_add)(r, a, b);
}

void secp_scalar_set_b32(SECP(scalar) *r, const unsigned char *b32, int *overflow) {
    SECP(scalar_set_b32)(r, b32, overflow);
}

void secp_scalar_get_b32(unsigned char *bin, const SECP(scalar) *a) {
    SECP(scalar_get_b32)(bin, a);
}

void secp_fe_mul(SECP(fe) *r, const SECP(fe) *a, const SECP(fe) *b) {
    SECP(fe_mul)(r, a, b);
}

void secp_fe_sqr(SECP(fe) *r, const SECP(fe) *a) {
    SECP(fe_sqr)(r, a);
}

void secp_fe_normalize(SECP(fe) *r) {
    SECP(fe_normalize)(r);
}

void secp_fe_set_b32_mod(SECP(fe) *r, const unsigned char *a) {
    SECP(fe_set_b32_mod)(r, a);
}

void secp_fe_get_b32(unsigned char *r, const SECP(fe) *a) {
    SECP(fe_get_b32)(r, a);
}

void secp_sha256_transform(uint32_t *s, const unsigned char *blocks, size_t n_blocks) {
    SECP(sha256_transform)(s, blocks, n_blocks);
}

void secp_sha256_write(SECP(sha256) *hash, const unsigned char *data, size_t size) {
    SECP(hash_ctx) ctx;
    SECP(hash_ctx_init)(&ctx);
    SECP(sha256_write)(&ctx, hash, data, size);
}

void secp_sha256_finalize(SECP(sha256) *hash, unsigned char *out32) {
    SECP(hash_ctx) ctx;
    SECP(hash_ctx_init)(&ctx);
    SECP(sha256_finalize)(&ctx, hash, out32);
}
