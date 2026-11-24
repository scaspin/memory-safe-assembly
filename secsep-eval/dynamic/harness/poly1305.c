#include "common.h"
struct poly1305_state_st;
void CRYPTO_poly1305_init(struct poly1305_state_st *state, const uint8_t key[32]);
void CRYPTO_poly1305_update(struct poly1305_state_st *state, const uint8_t *in, size_t in_len);
void CRYPTO_poly1305_finish(struct poly1305_state_st *state, uint8_t mac[16]);
void poly1305_update(struct poly1305_state_st *state, const uint8_t *in, size_t len);
int main(void) {
  for (size_t i = 0; i < NLENS; i++) {
    struct poly1305_state_st *st = (struct poly1305_state_st *)exact(96, 11);
    uint8_t *key = exact(32, 12), *m = exact(LENS[i], 13), *mac = exact(16, 14);
    CRYPTO_poly1305_init(st, key);
    CRYPTO_poly1305_update(st, m, LENS[i]);
    CRYPTO_poly1305_finish(st, mac);
    if (LENS[i] > 1) {
      CRYPTO_poly1305_init(st, key);
      CRYPTO_poly1305_update(st, m, 1);
      CRYPTO_poly1305_update(st, m + 1, LENS[i] - 1);
      CRYPTO_poly1305_finish(st, mac);
    }
    CRYPTO_poly1305_init(st, key);
    poly1305_update(st, m, LENS[i]);
    free(st); free(key); free(m); free(mac);
  }
  return 0;
}
