#!/bin/bash
set -u
here=$(cd "$(dirname "$0")" && pwd)
root=$(dirname "$here")
out=${OUT:-$here/results}
known=${KNOWN:-$here/known-timeouts}
runs=${RUNS:-3}
jobs=${JOBS:-4}
timeout=${TIMEOUT:-300}
x86=x86_64-apple-darwin
check=$root/target/release/bums-check

export RUSTUP_TOOLCHAIN=${RUSTUP_TOOLCHAIN:-1.93-aarch64-apple-darwin}
(cd "$root" && cargo build --release -p bums-check) || exit 1

suites=(
  "corecrypto|corecrypto-playground|"
  "graviola|graviola-playground|"
  "crypto|crypto-playground|"
  "crypto-x86|crypto-playground|--target $x86"
  "bignum|bignum-playground|"
  "openblas|openblas-playground|"
  "openblas-x86|openblas-playground|--target $x86"
  "candle|candle-playground|"
  "rav1d|rav1d-playground|"
  "rav1d-x86|rav1d-playground|--target $x86"
  "ffmpeg|ffmpeg-playground|--all-features"
  "compression|compression-playground|"
  "compression-x86|compression-playground|--target $x86"
)
for extra in ${EXTRA_SUITES:-}; do
  suites+=("$extra")
done

only=${ONLY:-}
for run in $(seq 1 "$runs"); do
  mkdir -p "$out/run$run"
  for suite in "${suites[@]}"; do
    IFS='|' read -r name crate flags <<<"$suite"
    [[ -n $only && " $only " != *" $name "* ]] && continue
    [[ $crate = /* ]] || crate=$root/$crate
    tsv=$out/run$run/$name.tsv
    [[ -s $tsv ]] && continue
    skipping=$out/run$run/$name.skip
    : >"$skipping"
    if [[ -s $known/$name.txt ]]; then
      cat "$known/$name.txt" >>"$skipping"
    fi
    if [[ $run -gt 1 && -s $out/run1/$name.tsv ]]; then
      awk -F'\t' '$3 != "verified" {print $1}' "$out/run1/$name.tsv" >>"$skipping"
    fi
    skip=()
    [[ -s $skipping ]] && skip=(--skip-file "$skipping")
    echo "=== run $run $name $(date)"
    (cd "$root" && "$check" "$crate" $flags --jobs "$jobs" --timeout "$timeout" ${skip[@]+"${skip[@]}"} --out "$tsv.partial") | tail -1
    mv "$tsv.partial" "$tsv"
  done
done

mkdir -p "$out/sizes"
for suite in "${suites[@]}"; do
  IFS='|' read -r name crate flags <<<"$suite"
  [[ -n $only && " $only " != *" $name "* ]] && continue
  [[ $crate = /* ]] || crate=$root/$crate
  sizes=$out/sizes/$name.tsv
  [[ -s $sizes ]] && continue
  echo "=== sizes $name $(date)"
  (cd "$root" && "$check" "$crate" $flags --sizes) | awk -F'\t' 'NF == 3' >"$sizes.partial"
  mv "$sizes.partial" "$sizes"
done
