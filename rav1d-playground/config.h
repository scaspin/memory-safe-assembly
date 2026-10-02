 #define CONFIG_ASM 1
 #define CONFIG_LOG 1
 #define PREFIX 1
 #define PRIVATE_PREFIX dav1d_
 #define ARCH_ARM 0
 #define ARCH_AARCH64 1
 #define HAVE_DOTPROD 1
 #define HAVE_I8MM 1
 /* SVE2 is not available on the aarch64-apple-darwin target this crate builds
  * for, so mc16_sve.S assembles to nothing. */
 #define HAVE_SVE2 0
 /* Emit the .arch_extension directives so the DotProd/I8MM regions assemble
  * without having to enable those features for the whole translation unit. */
 #define HAVE_AS_ARCHEXT_DOTPROD_DIRECTIVE 1
 #define HAVE_AS_ARCHEXT_I8MM_DIRECTIVE 1
