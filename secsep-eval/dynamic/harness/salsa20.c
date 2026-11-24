#include "common.h"
void salsa20_words(uint32_t *out, uint32_t in[16]);
void salsa20(uint8_t *message, uint64_t mlen, uint8_t key[32], uint64_t nonce);
int main(void) {
  uint32_t *in = (uint32_t *)exact(64, 1), *out = (uint32_t *)exact(64, 2);
  salsa20_words(out, in);
  free(in); free(out);
  for (size_t i = 0; i < NLENS; i++) {
    uint8_t *m = exact(LENS[i], 3), *key = exact(32, 4);
    salsa20(m, LENS[i], key, 0x0102030405060708ull);
    free(m); free(key);
  }
  return 0;
}
