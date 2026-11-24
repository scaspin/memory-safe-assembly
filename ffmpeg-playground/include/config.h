/* Minimal FFmpeg configuration for assembling the aarch64 sources for analysis
 * (aarch64-linux-gnu, PIC). SVE/SME are off: the checker does not model them. */
#ifndef FFMPEG_CONFIG_H
#define FFMPEG_CONFIG_H
#define EXTERN_ASM
#define CONFIG_PIC 1
#define HAVE_AS_FUNC 0
#define HAVE_AS_ARCH_DIRECTIVE 1
#define AS_ARCH_LEVEL armv8.2-a
#define HAVE_AS_ARCHEXT_CRC_DIRECTIVE 1
#define HAVE_AS_ARCHEXT_DOTPROD_DIRECTIVE 1
#define HAVE_AS_ARCHEXT_I8MM_DIRECTIVE 1
#define HAVE_AS_ARCHEXT_AES_DIRECTIVE 1
#define HAVE_AS_ARCHEXT_SHA3_DIRECTIVE 1
#define HAVE_AS_ARCHEXT_SVE_DIRECTIVE 0
#define HAVE_AS_ARCHEXT_SVE2_DIRECTIVE 0
#define HAVE_AS_ARCHEXT_SME_DIRECTIVE 0
#define HAVE_AS_ARCHEXT_SME_I16I64_DIRECTIVE 0
#define HAVE_AS_ARCHEXT_SME2_DIRECTIVE 0
#define HAVE_ARM_CRC 1
#define HAVE_ARM_AES 1
#define HAVE_PMULL 1
#define HAVE_EOR3 1
#define HAVE_DOTPROD 1
#define HAVE_I8MM 1
#define HAVE_SME 0
#define HAVE_SME_I16I64 0
#define HAVE_SECTION_DATA_REL_RO 1
#endif
