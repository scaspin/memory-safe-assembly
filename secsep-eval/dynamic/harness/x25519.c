#include "common.h"
int X25519(uint8_t out_shared_key[32], const uint8_t private_key[32], const uint8_t peer_public_value[32]);
void fe_tobytes(uint8_t s[32], const uint64_t f[5]);
int main(void) {
  uint8_t *out = exact(32, 15), *priv = exact(32, 16), *peer = exact(32, 17);
  X25519(out, priv, peer);
  uint8_t *s = exact(32, 18);
  uint64_t *f = (uint64_t *)exact(40, 19);
  for (int k = 0; k < 5; k++) f[k] &= (1ull << 51) - 1;
  fe_tobytes(s, f);
  free(out); free(priv); free(peer); free(s); free(f);
  return 0;
}
