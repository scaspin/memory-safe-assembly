#include "common.h"
void CRYPTO_chacha_20(uint8_t *out, const uint8_t *in, size_t in_len, const uint8_t key[32], const uint8_t nonce[12], uint32_t counter);
int main(void) {
  for (size_t i = 0; i < NLENS; i++) {
    uint8_t *in = exact(LENS[i], 7), *out = exact(LENS[i], 8), *key = exact(32, 9), *nonce = exact(12, 10);
    CRYPTO_chacha_20(out, in, LENS[i], key, nonce, 1);
    free(in); free(out); free(key); free(nonce);
  }
  return 0;
}
