#include "common.h"
int ED25519_sign(uint8_t out_sig[64], const uint8_t *message, size_t message_len, const uint8_t private_key[64]);
void x25519_sc_reduce(uint8_t s[64]);
int main(void) {
  uint8_t *s = exact(64, 20);
  x25519_sc_reduce(s);
  free(s);
  for (size_t i = 0; i < NLENS; i++) {
    uint8_t *sig = exact(64, 21), *m = exact(LENS[i], 22), *priv = exact(64, 23);
    ED25519_sign(sig, m, LENS[i], priv);
    free(sig); free(m); free(priv);
  }
  return 0;
}
