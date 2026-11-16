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
    cost: float = 1.0

    @property
    def display(self):
        return f"{self.library} ({self.isa})"

    @property
    def arch(self):
        return "x86_64" if self.isa == "x86-64" else "aarch64"


def _suite(name, crate, library, isa, case_study, domain, *flags, split=(), cost=1.0):
    target = ("--target", X86) if isa == "x86-64" else ()
    return Suite(name, crate, library, isa, case_study, domain, target + flags, split, cost)


BLAKE3_ASM = ("--asm-dir", "blake3-secp256k1-playground/asm")
SECSEP_ASM = ("--asm-dir", "secsep-playground/asm")

BY_FILE_BLAKE3 = (("BLAKE3", "file", r"blake3"), ("secp256k1", "file", r"secp256k1"))
BY_FILE_COMPRESSION = (("zlib-ng", "file", r"zlib_ng"), ("zstd", "file", r"zstd"))

SUITES = [
    _suite("awslc", "crypto-playground", "AWS-LC", "aarch64", "Cryptography", "crypto", cost=0.4),
    _suite("awslc-x86", "crypto-playground", "AWS-LC", "x86-64", "Cryptography", "crypto", cost=0.01),
    _suite("openssl", "openssl-playground", "OpenSSL", "aarch64", "Cryptography", "crypto", cost=1.0),
    _suite("openssl-x86", "openssl-playground", "OpenSSL", "x86-64", "Cryptography", "crypto", cost=1.5),
    _suite("corecrypto", "corecrypto-playground", "corecrypto", "aarch64", "Cryptography", "crypto", cost=0.01),
    _suite("graviola", "graviola-playground", "graviola", "aarch64", "Cryptography", "crypto", cost=0.005),
    _suite("bignum", "bignum-playground", "s2n-bignum", "aarch64", "Cryptography", "crypto", cost=0.12),
    _suite("blake3", "blake3-secp256k1-playground", "BLAKE3", "aarch64", "Cryptography", "crypto", *BLAKE3_ASM, split=BY_FILE_BLAKE3, cost=0.02),
    _suite("blake3-x86", "blake3-secp256k1-playground", "BLAKE3", "x86-64", "Cryptography", "crypto", *BLAKE3_ASM, split=BY_FILE_BLAKE3, cost=0.01),
    _suite("secsep-x86", "secsep-playground", "BoringSSL (SecSep set)", "x86-64", "Cryptography", "crypto", *SECSEP_ASM, cost=0.6),
    _suite("candle", "candle-playground", "candle", "aarch64", "Math", "numeric", cost=0.01),
    _suite("openblas", "openblas-playground", "OpenBLAS", "aarch64", "Math", "numeric", cost=0.01),
    _suite("openblas-x86", "openblas-playground", "OpenBLAS", "x86-64", "Math", "numeric", cost=0.2),
    _suite("compression", "compression-playground", "ISA-L", "aarch64", "Math", "compression", split=BY_FILE_COMPRESSION, cost=0.65),
    _suite("compression-x86", "compression-playground", "ISA-L", "x86-64", "Math", "compression", split=BY_FILE_COMPRESSION, cost=2.1),
    _suite("ffmpeg", "ffmpeg-playground", "FFmpeg", "aarch64", "Video", "media", "--all-features", cost=12.0),
    _suite("rav1d", "rav1d-playground", "rav1d/dav1d", "aarch64", "Video", "media", cost=8.3),
]
BY_NAME = {suite.name: suite for suite in SUITES}
ALIASES = {"crypto": "awslc", "crypto-x86": "awslc-x86"}
LIBRARY_ORDER = ["AWS-LC", "OpenSSL", "BoringSSL (SecSep set)", "corecrypto", "graviola", "s2n-bignum",
                 "BLAKE3", "secp256k1", "candle", "OpenBLAS", "ISA-L", "zlib-ng", "zstd",
                 "FFmpeg", "rav1d/dav1d"]


def canonical(name):
    return ALIASES.get(name, name)


def library_of(suite, function, file):
    for library, kind, pattern in suite.split:
        if re.search(pattern, file if kind == "file" else function):
            return library
    return suite.library


def case_study_of(library):
    return next(s.case_study for s in SUITES if library in (s.library, *[r[0] for r in s.split]))


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
    for suite in sorted(SUITES, key=lambda suite: suite.cost):
        print("|".join([suite.name, suite.crate, " ".join(suite.flags)]))
    sys.exit(0)
