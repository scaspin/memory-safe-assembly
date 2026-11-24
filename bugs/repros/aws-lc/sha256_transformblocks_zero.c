#include <openssl/sha.h>
#include <sys/mman.h>
#include <unistd.h>
// SHA256_TransformBlocks with num_blocks = 0. Valid input is 0 bytes, so `data`
// points exactly at a guard page: a correct no-op touches nothing; a do-while
// asm loop reads data[0..64) and runs off the end.
int main(void) {
    long pg = sysconf(_SC_PAGESIZE);
    unsigned char *p = mmap(0, 2*pg, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
    mprotect(p + pg, pg, PROT_NONE);
    unsigned char *data = p + pg;          // 0 readable bytes; guard starts here
    uint32_t state[8] = {0};
    SHA256_TransformBlocks(state, data, 0); // documented low-level public API
    return 0;
}
