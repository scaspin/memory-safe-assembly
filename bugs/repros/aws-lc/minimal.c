// Minimal crash for the CBC tail over-read (A4).
// The input buffer is EXACTLY `len` bytes and ends at a guard page, so any read
// past in[len) faults. len = 20 is >= 16 and not a multiple of 16: the ARMv8 AES
// assembly (aes_hw_cbc_encrypt in aws-lc, aes_v8_cbc_encrypt in OpenSSL -- the
// same aesv8-armx code) processes in[0..16), then loads a whole block from
// in[16..32), 12 bytes past the buffer.
//
// aws-lc:  cc -I<aws-lc>/include minimal.c <aws-lc>/libcrypto.a -Wl,-w -o minimal
// OpenSSL: reached through EVP_Cipher, not this AES_cbc_encrypt entry -- see minimal_openssl.c
#include <openssl/aes.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

int main(void) {
    size_t len = 20;                       // >= 16, not a multiple of 16
    long pg = sysconf(_SC_PAGESIZE);
    unsigned char *p = mmap(0, 2 * pg, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
    mprotect(p + pg, pg, PROT_NONE);       // guard page right after the first page
    unsigned char *in = p + pg - len;      // exactly `len` readable bytes, then the guard
    memset(in, 0x5a, len);
    unsigned char out[64], iv[16] = {0};
    unsigned char key[16] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
    AES_KEY k;
    AES_set_encrypt_key(key, 128, &k);
    AES_cbc_encrypt(in, out, len, &k, iv, AES_ENCRYPT);  // reads in[16..32), past in[20)
    return 0;
}
