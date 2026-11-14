// Minimal crash for the same CBC tail over-read through OpenSSL's public EVP API.
// OpenSSL's legacy AES_cbc_encrypt does NOT use the ARMv8 assembly (it runs the
// byte-safe C CRYPTO_cbc128 path), but EVP_Cipher with EVP_aes_128_cbc() does.
// The input buffer is EXACTLY `len` bytes and ends at a guard page.
// len = 20 faults in aes_v8_cbc_encrypt -- the same aesv8-armx code aws-lc uses.
//
// cc -I<openssl>/include minimal_openssl.c <openssl>/libcrypto.a -Wl,-w -o minimal_openssl
#include <openssl/evp.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

int main(void) {
    size_t len = 20;                       // >= 16, not a multiple of 16
    long pg = sysconf(_SC_PAGESIZE);
    unsigned char *p = mmap(0, 2 * pg, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
    mprotect(p + pg, pg, PROT_NONE);
    unsigned char *in = p + pg - len;      // exactly `len` readable bytes, then the guard
    memset(in, 0x5a, len);
    unsigned char out[64], key[16] = {1}, iv[16] = {0};
    EVP_CIPHER_CTX *c = EVP_CIPHER_CTX_new();
    EVP_CipherInit_ex(c, EVP_aes_128_cbc(), 0, key, iv, 1);
    EVP_Cipher(c, out, in, len);           // reads in[16..32), past in[20)
    return 0;
}
