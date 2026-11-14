#include <openssl/aes.h>
#include <openssl/evp.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <unistd.h>

static uint8_t *ending_at_guard(size_t bytes) {
    size_t page = (size_t)getpagesize();
    size_t span = ((bytes + page - 1) / page + 1) * page;
    uint8_t *base = mmap(NULL, span + page, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
    mprotect(base + span, page, PROT_NONE);
    uint8_t *start = base + span - bytes;
    memset(start, 0x5a, bytes);
    return start;
}

static const uint8_t key_bytes[16] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};

static void aes_cbc(uint8_t *in, uint8_t *out, size_t len, int enc) {
    AES_KEY key;
    uint8_t iv[16] = {0};
    if (enc)
        AES_set_encrypt_key(key_bytes, 128, &key);
    else
        AES_set_decrypt_key(key_bytes, 128, &key);
    AES_cbc_encrypt(in, out, len, &key, iv, enc);
}

static void evp_cipher(uint8_t *in, uint8_t *out, size_t len, int enc) {
    uint8_t iv[16] = {0};
    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
    EVP_CipherInit_ex(ctx, EVP_aes_128_cbc(), NULL, key_bytes, iv, enc);
    EVP_Cipher(ctx, out, in, len);
}

static void evp_update(uint8_t *in, uint8_t *out, size_t len, int enc) {
    uint8_t iv[16] = {0};
    int written = 0;
    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
    EVP_CipherInit_ex(ctx, EVP_aes_128_cbc(), NULL, key_bytes, iv, enc);
    EVP_CIPHER_CTX_set_padding(ctx, 0);
    EVP_CipherUpdate(ctx, out, &written, in, (int)len);
}

typedef void (*entry)(uint8_t *, uint8_t *, size_t, int);

static void run(const char *name, entry f, size_t len, int enc, int guard_out) {
    pid_t pid = fork();
    if (pid == 0) {
        uint8_t *in = guard_out ? ending_at_guard(len + 64) : ending_at_guard(len);
        uint8_t *out = guard_out ? ending_at_guard(len) : ending_at_guard(len + 64);
        f(in, out, len, enc);
        _exit(0);
    }
    int status;
    waitpid(pid, &status, 0);
    const char *verdict = WIFSIGNALED(status) ? (WTERMSIG(status) == SIGBUS || WTERMSIG(status) == SIGSEGV ? "FAULT" : "signal") : "ok";
    printf("%-18s %-7s len=%-3zu guard after %-3s : %s\n", name, enc ? "encrypt" : "decrypt", len, guard_out ? "out" : "in", verdict);
}

int main(void) {
    struct { const char *name; entry f; } entries[] = {
        {"AES_cbc_encrypt", aes_cbc},
        {"EVP_Cipher", evp_cipher},
        {"EVP_CipherUpdate", evp_update},
    };
    size_t lens[] = {32, 20, 17, 31};
    for (size_t e = 0; e < 3; e++)
        for (int enc = 1; enc >= 0; enc--)
            for (size_t l = 0; l < 4; l++)
                for (int g = 0; g < 2; g++)
                    run(entries[e].name, entries[e].f, lens[l], enc, g);
    return 0;
}
