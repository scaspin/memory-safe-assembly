#!/bin/bash
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
root=$(dirname "$here")
out=${OUT:-$here/results}
from=${FROM:-}
stages=${STAGES:-tests sweep figures tables secsep}
min_free_gb=${MIN_FREE_GB:-1.5}
python=${PYTHON:-python3}

export RUSTUP_TOOLCHAIN=${RUSTUP_TOOLCHAIN:-1.93-aarch64-apple-darwin}
export JOBS=${JOBS:-2} MEM_GB=${MEM_GB:-3} RUNS=${RUNS:-1}

usage() {
  cat <<EOF
usage: evaluation/reproduce.sh

Runs the stages in STAGES (default: "$stages") and writes everything under OUT (default: $out).

  prepare   render Apple corecrypto's licensed asm from its submodule (runs before sweep and overhead too)
  tests     cargo test of bums and bums_annotations (the soundness guard), log in OUT/tests.log
  sweep     evaluation/run.sh over every case study, per-function TSVs in OUT/run*/ and OUT/sizes/
  figures   time breakdowns, time vs size, annotation vs time, time distributions in OUT/figures/
  tables    per-case-study verification and precondition kinds in OUT/tables/
  secsep    SecSep/Octal comparison figures in secsep-eval/paper-data/figures from the committed CSVs;
            with SECSEP_RAW=<secsep-eval checkout holding octal-out-clean/, symex/ and the Vale and
            related/hacl-star trees> it first rebuilds paper-data/data and paper-data/tables, reading
            s2n-bignum proofs from ./s2n-bignum or S2N_BIGNUM=<s2n-bignum clone>
  overhead  wrapper runtime overhead benchmark in evaluation/wrapper-overhead/results/

FROM=DIR draws figures and tables from an existing sweep instead of OUT, e.g.
  FROM=evaluation/published/rework-5f5018a4 STAGES="figures tables" evaluation/reproduce.sh
Sweep knobs pass through to run.sh: RUNS ($RUNS), JOBS ($JOBS), MEM_GB ($MEM_GB), TIMEOUT, SLOW_TIMEOUT, ONLY.
MIN_FREE_GB ($min_free_gb) is the free-memory floor below which the sweep's bums-check children are killed.
EOF
}

case "${1:-}" in -h | --help) usage; exit 0 ;; esac

wants() { [[ " $stages " == *" $1 "* ]]; }
stamp() { echo "=== $1 $(date '+%F %T')"; }
mkdir -p "$out"
check=$root/target/release/bums-check

prepare_corecrypto() {
  local playground=$root/corecrypto-playground
  [[ -n $(ls -A "$playground/asm/aarch64" 2>/dev/null) ]] && return
  stamp "corecrypto import (licensed asm, rendered locally and never committed)"
  (cd "$root" && git submodule update --init corecrypto-playground/corecrypto)
  (cd "$playground" && "$python" import-corecrypto.py)
}

if wants sweep || wants overhead || wants prepare; then
  prepare_corecrypto
fi

if wants tests; then
  stamp tests
  (cd "$root" && RUST_MIN_STACK=1073741824 cargo test -p bums -p bums_annotations --release --no-fail-fast) \
    >"$out/tests.log" 2>&1 && echo "tests passed" || { echo "tests FAILED, see $out/tests.log"; exit 1; }
  grep -E '^test result' "$out/tests.log" | awk '{p+=$4; f+=$6} END {print p " passed, " f " failed"}'
fi

if wants sweep; then
  stamp sweep
  (cd "$root" && cargo build --release -p bums-check)
  (
    while sleep 5; do
      free=$(vm_stat | awk '/Pages free|Pages inactive|Pages speculative/ {gsub("\\.", "", $NF); s += $NF} END {printf "%.1f", s * 16384 / 1073741824}')
      if awk -v f="$free" -v m="$min_free_gb" 'BEGIN {exit !(f < m)}'; then
        echo "watchdog: ${free} GB free, killing this sweep's bums-check $(date '+%T')"
        pkill -f "^$check" || true
      fi
    done
  ) &
  watchdog=$!
  trap 'kill $watchdog 2>/dev/null || true' EXIT
  OUT=$out "$here/run.sh"
  kill $watchdog 2>/dev/null || true
fi

source_dir=${from:-$out}
[[ $source_dir = /* ]] || source_dir=$root/$source_dir

if wants figures; then
  stamp figures
  figures=$out/figures
  mkdir -p "$figures"
  "$python" "$here/plot.py" "$source_dir" --out "$figures" | tee "$figures/summary.txt"
  "$python" "$here/annotation_vs_time.py" "$source_dir/run1" "$figures"
  "$python" "$here/time_distribution.py" "$figures"
fi

if wants tables; then
  stamp tables
  tables=$out/tables
  mkdir -p "$tables"
  "$python" "$here/tables/case_studies.py" "$source_dir/run1" "$tables"
  "$python" "$here/tables/kinds_by_suite.py" "$source_dir/run1" "$tables/precondition-kinds.csv"
fi

if wants secsep; then
  stamp secsep
  paper=$root/secsep-eval/paper-data
  if [[ -n ${SECSEP_RAW:-} ]]; then
    secsep=$root/secsep-eval
    for raw in octal-out-clean secsep symex related; do
      [[ -e $secsep/$raw ]] || ln -s "$SECSEP_RAW/$raw" "$secsep/$raw"
    done
    if [[ ! -e $root/s2n-bignum && -n ${S2N_BIGNUM:-} ]]; then
      ln -s "$S2N_BIGNUM" "$root/s2n-bignum"
    fi
    for raw in "$SECSEP_RAW"/mutation/* "$SECSEP_RAW"/dynamic/results/*; do
      local_copy=$secsep/${raw#"$SECSEP_RAW"/}
      [[ -e $local_copy ]] || ln -s "$raw" "$local_copy"
    done
    for builder in build_paper_data build_length_table build_mutation_matrix build_dynamic s2n_bignum_effort s2n_safety_effort vale_effort build_related_work; do
      "$python" "$secsep/tools/$builder.py"
    done
  fi
  "$python" "$root/secsep-eval/tools/make_figures.py" 2>/dev/null
  echo "figures in $paper/figures, tables in $paper/tables"
fi

if wants overhead; then
  stamp overhead
  bench=$here/wrapper-overhead
  (cd "$bench" && cargo build --release && ./target/release/wrapper-overhead --out results/overhead.tsv)
  (cd "$bench" && cargo build --release --features isolated --target-dir target-isolated \
    && ./target-isolated/release/wrapper-overhead --out results/isolated.tsv)
  "$python" "$bench/plot.py"
fi

stamp done
