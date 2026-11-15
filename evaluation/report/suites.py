import re
import sys
from dataclasses import dataclass, field
from pathlib import Path

EVALUATION = Path(__file__).resolve().parents[1]
ROOT = EVALUATION.parent
X86 = "x86_64-apple-darwin"


@dataclass(frozen=True)
class Suite:
    name: str
    crate: str
    library: str
    isa: str
    case_study: str
    domain: str
    flags: tuple = field(default_factory=tuple)
    split: tuple = field(default_factory=tuple)

    @property
    def display(self):
        return f"{self.library} ({self.isa})"

    @property
    def arch(self):
        return "x86_64" if self.isa == "x86-64" else "aarch64"


def _suite(name, crate, library, isa, case_study, domain, *flags, split=()):
    target = ("--target", X86) if isa == "x86-64" else ()
    return Suite(name, crate, library, isa, case_study, domain, target + flags, split)


BLAKE3_ASM = ("--asm-dir", "blake3-secp256k1-playground/asm")
SECSEP_ASM = ("--asm-dir", "secsep-playground/asm")

BY_FILE_BLAKE3 = (("BLAKE3", "file", r"blake3"), ("secp256k1", "file", r"secp256k1"))
BY_FILE_COMPRESSION = (("zlib-ng", "file", r"zlib_ng"), ("zstd", "file", r"zstd"))

SUITES = [
    _suite("awslc", "crypto-playground", "AWS-LC", "aarch64", "Cryptography", "crypto"),
    _suite("awslc-x86", "crypto-playground", "AWS-LC", "x86-64", "Cryptography", "crypto"),
    _suite("openssl", "openssl-playground", "OpenSSL", "aarch64", "Cryptography", "crypto"),
    _suite("openssl-x86", "openssl-playground", "OpenSSL", "x86-64", "Cryptography", "crypto"),
    _suite("corecrypto", "corecrypto-playground", "corecrypto", "aarch64", "Cryptography", "crypto"),
    _suite("graviola", "graviola-playground", "graviola", "aarch64", "Cryptography", "crypto"),
    _suite("bignum", "bignum-playground", "s2n-bignum", "aarch64", "Cryptography", "crypto"),
    _suite("blake3", "blake3-secp256k1-playground", "BLAKE3", "aarch64", "Cryptography", "crypto", *BLAKE3_ASM, split=BY_FILE_BLAKE3),
    _suite("blake3-x86", "blake3-secp256k1-playground", "BLAKE3", "x86-64", "Cryptography", "crypto", *BLAKE3_ASM, split=BY_FILE_BLAKE3),
    _suite("secsep-x86", "secsep-playground", "BoringSSL (SecSep set)", "x86-64", "Cryptography", "crypto", *SECSEP_ASM),
    _suite("candle", "candle-playground", "candle", "aarch64", "Math", "numeric"),
    _suite("openblas", "openblas-playground", "OpenBLAS", "aarch64", "Math", "numeric"),
    _suite("openblas-x86", "openblas-playground", "OpenBLAS", "x86-64", "Math", "numeric"),
    _suite("compression", "compression-playground", "ISA-L", "aarch64", "Math", "compression", split=BY_FILE_COMPRESSION),
    _suite("compression-x86", "compression-playground", "ISA-L", "x86-64", "Math", "compression", split=BY_FILE_COMPRESSION),
    _suite("ffmpeg", "ffmpeg-playground", "FFmpeg", "aarch64", "Video", "media", "--all-features"),
    _suite("rav1d", "rav1d-playground", "rav1d/dav1d", "aarch64", "Video", "media"),
    _suite("rav1d-x86", "rav1d-playground", "rav1d/dav1d", "x86-64", "Video", "media"),
]
BY_NAME = {suite.name: suite for suite in SUITES}
ALIASES = {"crypto": "awslc", "crypto-x86": "awslc-x86"}
SHA3 = re.compile(r"keccak|sha3", re.IGNORECASE)
LIBRARY_ORDER = ["AWS-LC", "OpenSSL", "BoringSSL (SecSep set)", "corecrypto", "graviola", "s2n-bignum",
                 "SHA-3", "BLAKE3", "secp256k1", "candle", "OpenBLAS", "ISA-L", "zlib-ng", "zstd",
                 "FFmpeg", "rav1d/dav1d"]


def canonical(name):
    return ALIASES.get(name, name)


def library_of(suite, function, file):
    if suite.case_study == "Cryptography" and SHA3.search(function):
        return "SHA-3"
    for library, kind, pattern in suite.split:
        if re.search(pattern, file if kind == "file" else function):
            return library
    return suite.library


def case_study_of(library):
    return next(s.case_study for s in SUITES if library in (s.library, *[r[0] for r in s.split]) or library == "SHA-3")


CASE_STUDIES = ["Cryptography", "Math", "Video"]
DOMAINS = [
    ("crypto", "Cryptography", "#2a78d6", "o"),
    ("media", "Media codecs", "#eb6834", "s"),
    ("compression", "Compression", "#1baf7a", "^"),
    ("numeric", "Numeric / ML", "#eda100", "D"),
]
DOMAIN_COLOR = {key: color for key, _, color, _ in DOMAINS}
INK = "#0b0b0b"
INK_2 = "#52514e"
GRID = "#e4e3df"
REFERENCE = "#8a8984"


def display(name):
    suite = BY_NAME.get(name)
    return suite.display if suite else name


if __name__ == "__main__":
    for suite in SUITES:
        print("|".join([suite.name, suite.crate, " ".join(suite.flags)]))
    sys.exit(0)
