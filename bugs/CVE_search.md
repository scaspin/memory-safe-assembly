# CVE Search 


## Highlights:

- read out-of-bound in Linux kernel crypto poly1305: https://www.cve.org/CVERecord?id=CVE-2022-50231
- Salsa20 does not handle zero-length inputs: https://www.cve.org/CVERecord?id=CVE-2017-17805
- Out of bounds access in AES CTR Arm when choosing wrong assembly impl: https://www.cve.org/CVERecord?id=CVE-2024-26789
- Input and output of crypto in virtio lengths may differ: https://www.cve.org/CVERecord?id=CVE-2023-3180
- Not encrypting whole input: https://www.cve.org/CVERecord?id=CVE-2022-2097
- Video/pixels bug: https://www.cve.org/CVERecord?id=CVE-2017-8906 and https://www.cve.org/CVERecord?id=CVE-2017-13666

## Other results:
### “openssl” + “assembly”:

- https://www.cve.org/CVERecord?id=CVE-2022-2097
    - AES OCB mode for 32-bit x86 platforms using the AES-NI assembly optimised implementation will not encrypt the entirety of the data under some circumstances.
    - Code: https://github.com/openssl/openssl/commit/6ebf6d51596f51d23ccbc17930778d104a57d99c
    - Fix: changing a “jb” to “jbe”

### “assembly”:

- https://www.cve.org/CVERecord?id=CVE-2017-8906 and https://www.cve.org/CVERecord?id=CVE-2017-13666 → integer underflow in libbpg
- https://www.cve.org/CVERecord?id=CVE-2025-7396 → wolfSSL, blinding of curve25519 and is not relevant for other arches
- https://www.cve.org/CVERecord?id=CVE-2019-6488 → x32 arch, wrong number of bits to represent size during a memcopy
- https://www.cve.org/CVERecord?id=CVE-2019-12904 → flush-and-reload side-channel attack because physical addresses are available to other processes

### “openssl” + “out of bound” / “out-of-bound” / “oob”

- somewhat relevant because Rust but more so for omniglot:https://www.cve.org/CVERecord?id=CVE-2025-24898

### “openssl” + “buffer overflow”

- https://www.cve.org/CVERecord?id=CVE-2021-3711: calling decrypt twice with a smaller buffer second time for SM2
- https://www.cve.org/CVERecord?id=CVE-2007-3108 bn_mont_mul errors
- https://www.cve.org/CVERecord?id=CVE-2002-0657 long master key can lead to buffer overflow

### “rust”+ “assembly”

- https://www.cve.org/CVERecord?id=CVE-2023-53159 → buffer over-read when calling openssl from Rust
- https://www.cve.org/CVERecord?id=CVE-2018-20997 → use after free

### “dav1d”

- https://www.cve.org/CVERecord?id=CVE-2024-1580  integer overflow when decoding videos with large frame size, fix is in C: https://code.videolan.org/videolan/dav1d/-/commit/2b475307dc11be9a1c3cc4358102c76a7f386a51 but this is a C/impl bug


### “bignum”

- Node type-check exception in V8 bug: https://www.cve.org/CVERecord?id=CVE-2022-25324
- Side channel in firefox: https://www.cve.org/CVERecord?id=CVE-2020-12402
- Improper square root impl in openssl: https://www.cve.org/CVERecord?id=CVE-2014-3570
- Overflow in putty for DDoD: https://www.cve.org/CVERecord?id=CVE-2013-4207
- Buffer overflows using a base argument that is larger than the mod argument, which causes the modpow function to write memory before the beginning of its buffer: https://www.cve.org/CVERecord?id=CVE-2004-1440

### “arm64 crypto” 

- read out-of-bound in Linux kernel crypto poly1305 https://www.cve.org/CVERecord?id=CVE-2022-50231
- Register corruption in Linux poly1305: https://www.cve.org/CVERecord?id=CVE-2025-39804
- Out of bounds access in AES CTR Arm when choosing wrong assembly impl: https://www.cve.org/CVERecord?id=CVE-2024-26789

### “x86 crypto”

- Salsa20 does not handle zero-length inputs: https://www.cve.org/CVERecord?id=CVE-2017-17805
- Improper memory locations: https://www.cve.org/CVERecord?id=CVE-2015-3331

### “crypto out-of-bounds” (has a bunch of interesting bugs, not all relevant)

- In linux: the destination dynptr's size is not validated to be at least as large as the source dynptr's size before calling into the crypto backend with 'len = src_len https://www.cve.org/CVERecord?id=CVE-2025-39917
- Incorrect bounds check in Android C code for asn1: https://www.cve.org/CVERecord?id=CVE-2022-20162 and https://www.cve.org/CVERecord?id=CVE-2022-20159
- OOB in C for FreeRDP RSA: https://www.cve.org/CVERecord?id=CVE-2020-13398
- DPDK does not validate user provided info: https://www.cve.org/CVERecord?id=CVE-2020-10724
- No validation of division results: https://www.cve.org/CVERecord?id=CVE-2016-2182

### “crypto buffer overflow”

- https://www.cve.org/CVERecord?id=CVE-2025-3873 failed to check the size of the output buffer of the caller, which could lead to data corruption on the host
- Zephyr crypto driver: https://www.cve.org/CVERecord?id=CVE-2023-5139
- Don’t check src and dst are of same length in QEMU virtual crypto device: https://www.cve.org/CVERecord?id=CVE-2023-3180
- No check of dst length: https://www.cve.org/CVERecord?id=CVE-2022-50407
- Don’t fully understand this one but snapdragon input validation: https://www.cve.org/CVERecord?id=CVE-2018-5917
- Overflow through multiple calls to HMAC, SHA3: https://www.cve.org/CVERecord?id=CVE-2017-17806
- EVP decode update integer underflow: https://www.cve.org/CVERecord?id=CVE-2015-0292 (saw this earlier?)

### Asking chat-gpt, gemini:

- https://www.cve.org/CVERecord?id=CVE-2023-4807 → poly1305 MAC xmm registers not restored
- https://www.cve.org/CVERecord?id=CVE-2022-2274 →
    - issue: https://github.com/openssl/openssl/issues/18625
    - fix: https://github.com/openssl/openssl/pull/18626 adjusting expected length to be number of BN_LONGs rather than bits
