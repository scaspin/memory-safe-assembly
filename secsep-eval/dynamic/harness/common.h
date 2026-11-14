#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>

static const size_t LENS[] = {0, 1, 3, 4, 7, 8, 15, 16, 17, 31, 32, 33, 63, 64, 65, 100, 127, 128, 129, 200, 255, 256, 1000};
#define NLENS (sizeof(LENS) / sizeof(LENS[0]))

static uint8_t *exact(size_t n, uint8_t seed) {
  uint8_t *p = malloc(n);
  for (size_t i = 0; i < n; i++) p[i] = (uint8_t)(i * 131u + seed);
  return p;
}
