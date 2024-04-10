with import <nixpkgs> {};

pkgsCross.aarch64-multiplatform.callPackage ({ mkShell }: mkShell {
  nativeBuildInputs = [
    rustup

    # Example Build-time Additional Dependencies
    pkg-config
    llvmPackages.libcxxStdenv
    boringssl
    z3
  ];

  buildInputs = [
    rustup

    # Example Build-time Additional Dependencies
    pkg-config
    llvmPackages.libcxxStdenv
    boringssl
    z3
  ];

  # Set Environment Variables
  RUST_BACKTRACE = 1;
  LIBCLANG_PATH="${llvmPackages.libclang.lib}/lib";
  shellHook = ''
    # Set C flags for Rust's bindgen program. Unlike ordinary C
    # compilation, bindgen does not invoke $CC directly. Instead it
    # uses LLVM's libclang. To make sure all necessary flags are
    # included we need to look in a few places.
    export BINDGEN_EXTRA_CLANG_ARGS="$(< ${stdenv.cc}/nix-support/libc-crt1-cflags) \
      $(< ${stdenv.cc}/nix-support/libc-cflags) \
      $(< ${stdenv.cc}/nix-support/cc-cflags) \
      $(< ${stdenv.cc}/nix-support/libcxx-cxxflags) \
      ${lib.optionalString stdenv.cc.isClang "-idirafter ${stdenv.cc.cc}/lib/clang/${lib.getVersion stdenv.cc.cc}/include"} \
      ${lib.optionalString stdenv.cc.isGNU "-isystem ${stdenv.cc.cc}/include/c++/${lib.getVersion stdenv.cc.cc} -isystem ${stdenv.cc.cc}/include/c++/${lib.getVersion stdenv.cc.cc}/${stdenv.hostPlatform.config} -idirafter ${stdenv.cc.cc}/lib/gcc/${stdenv.hostPlatform.config}/${lib.getVersion stdenv.cc.cc}/include"}
    -isystem ${z3.dev}/include \
    -isystem ${boringssl.dev}/include
    "
    export CFLAGS="-I${boringssl.dev}/include"
  '';

}) {}
