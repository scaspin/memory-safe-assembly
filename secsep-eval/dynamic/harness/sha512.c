#include "common.h"
uint8_t *SHA512(const uint8_t *data, size_t len, uint8_t out[64]);
int main(void) {
  for (size_t i = 0; i < NLENS; i++) {
    uint8_t *d = exact(LENS[i], 5), *out = exact(64, 6);
    SHA512(d, LENS[i], out);
    free(d); free(out);
  }
  return 0;
}
