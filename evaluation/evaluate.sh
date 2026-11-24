#!/bin/bash
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
root=$(dirname "$here")
check=$root/target/release/bums-check

stages="prepare tests sweep overhead report"
out=""
from=""
only=""
runs=1
jobs=2
parallel=2
mem_gb=3
timeout=300
slow_timeout=2700
slow_steps=20000000
min_free_gb=1.5
open_figures=false
python=${PYTHON:-python3}
tty=0
[[ -t 2 ]] && tty=1
checked=0
resumed=-1
total=0
started=$(date +%s)
suite_index=0
suite_count=0

usage() {
  cat <<EOF
usage: evaluation/evaluate.sh [options]

Runs the BUMS evaluation: verifies every case study, measures the wrapper overhead,
and writes tables and figures. Everything for one evaluation lands in one directory.

stages (run in this order):
  prepare    render Apple corecrypto's licensed asm from its submodule if missing
  tests      cargo test of the checker; stops the evaluation if a test fails
  sweep      bums-check over every case study (main pass, then a long pass for slow functions)
  overhead   runtime overhead of the checked wrappers (benchmark; run on an idle machine)
  report     tables, failure reasons, and figures from the sweep
  secsep     SecSep/Octal comparison figures in secsep-eval/paper-data (not in the default set)

options:
  --stages "A B"    stages to run (default: "$stages")
  --out DIR         evaluation directory (default: evaluation/results/<date>)
  --from DIR        report on an existing sweep instead of running one (implies --stages report)
  --only "S1 S2"    restrict the sweep to these suites (names: python3 -m report.suites)
  --runs N          sweep repetitions for timing medians (default: $runs)
  --jobs N          functions checked in parallel within a suite (default: $jobs)
  --parallel N      suites checked at once, quickest first (default: $parallel)
  --mem-gb G        resident memory cap per function (default: $mem_gb)
  --timeout S       per-function limit in the main pass (default: $timeout)
  --slow-timeout S  per-function limit in the slow pass (default: $slow_timeout)
  --open            open every figure when the report is written
  -h, --help        this text

examples:
  evaluation/evaluate.sh --open
  evaluation/evaluate.sh --from evaluation/published/rework-5f5018a4 --open
  evaluation/evaluate.sh --only "graviola candle" --stages "sweep report" --open
EOF
}

while [[ $# -gt 0 ]]; do
  case $1 in
    --stages) stages=$2; shift 2 ;;
    --out) out=$2; shift 2 ;;
    --from) from=$2; stages=report; shift 2 ;;
    --only) only=$2; shift 2 ;;
    --runs) runs=$2; shift 2 ;;
    --jobs) jobs=$2; shift 2 ;;
    --parallel) parallel=$2; shift 2 ;;
    --mem-gb) mem_gb=$2; shift 2 ;;
    --timeout) timeout=$2; shift 2 ;;
    --slow-timeout) slow_timeout=$2; shift 2 ;;
    --open) open_figures=true; shift ;;
    -h | --help) usage; exit 0 ;;
    *) echo "unknown option $1" >&2; usage >&2; exit 2 ;;
  esac
done

export RUSTUP_TOOLCHAIN=${RUSTUP_TOOLCHAIN:-1.93-aarch64-apple-darwin}
out=${out:-$here/results/$(date +%Y-%m-%d)}
[[ $out = /* ]] || out=$PWD/$out
mkdir -p "$out"
results=${from:-$out}
[[ $results = /* ]] || results=$PWD/$results

wants() { [[ " $stages " == *" $1 "* ]]; }
stamp() { echo "=== $1  $(date '+%F %T')"; }
suites() { (cd "$here" && "$python" -m report.suites); }

prepare_corecrypto() {
  local playground=$root/corecrypto-playground
  [[ -n $(ls -A "$playground/asm/aarch64" 2>/dev/null) ]] && return
  stamp "prepare: rendering corecrypto asm (licensed, never committed)"
  (cd "$root" && git submodule update --init corecrypto-playground/corecrypto)
  (cd "$playground" && "$python" import-corecrypto.py)
}

start_watchdog() {
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
}

progress() {
  local suite=$1 pass=$2
  awk -v suite="$suite" -v pass="$pass" -v progress_file="$out/progress/$suite.txt" '
    function bar(done, all, width,   filled, text, i) {
      filled = all > 0 ? int(width * done / all) : 0
      text = ""
      for (i = 0; i < width; i++) text = text (i < filled ? "#" : ".")
      return text
    }
    {
      print
      fflush()
      if (match($0, /^\[[0-9]+\/[0-9]+\]/)) {
        split(substr($0, 2, RLENGTH - 2), part, "/")
        printf "%-16s %-4s [%s] %d/%d  last: %s %s\n", suite, pass, bar(part[1], part[2], 16), part[1], part[2], $2, $4 > progress_file
        close(progress_file)
      }
    }'
}

count_lines() {
  local n=0 f
  for f in "$@"; do
    [[ -f $f ]] && n=$((n + $(wc -l <"$f")))
  done
  echo "$n"
}

finished_suites() {
  local n=0 f
  for f in "$out"/run1/*.tsv; do
    [[ -f $f ]] && n=$((n + 1))
  done
  echo "$n"
}

aggregate_progress() {
  while sleep 5; do
    local finished active done_now elapsed eta line
    finished=$(count_lines "$out"/run1/*.tsv)
    active=$(cat "$out"/progress/*.txt 2>/dev/null || true)
    done_now=$((finished + $(printf '%s\n' "$active" | awk '{split($4, p, "/"); if ($2 == "main") n += p[1]} END {print n + 0}')))
    elapsed=$(($(date +%s) - started))
    fresh=$((done_now - resumed))
    eta=0
    [[ $fresh -gt 0 ]] && eta=$((elapsed * (total - done_now) / fresh))
    line=$(printf 'all %d/%d (%d%%) | %dh%02dm elapsed, ~%dh%02dm left | %d suites finished' "$done_now" "$total" \
      $((total > 0 ? 100 * done_now / total : 0)) $((elapsed / 3600)) $((elapsed % 3600 / 60)) $((eta / 3600)) $((eta % 3600 / 60)) \
      "$(finished_suites)")
    { echo "$line"; printf '%s\n' "$active"; } >"$out/progress.txt"
    [[ $tty = 1 ]] && printf '\r\033[K%s' "${line:0:150}" >&2
  done
}

check_suite() {
  local name=$1 crate=$2 flags=$3 tsv=$4 skip_file=$5 slow_list=$6
  local skip=()
  [[ -s $skip_file ]] && skip=(--skip-file "$skip_file")
  (cd "$root" && "$check" "$crate" $flags --jobs "$jobs" --mem-gb "$mem_gb" --timeout "$timeout" \
    ${skip[@]+"${skip[@]}"} --out "$tsv.partial") 2>&1 | { progress "$name" main; cat >/dev/null; } || true
  if [[ -s $slow_list ]]; then
    local pattern="^($(paste -sd'|' "$slow_list"))\$"
    echo "    slow pass: $(wc -l <"$slow_list" | tr -d ' ') functions skipped above, now checked with up to ${slow_timeout}s each"
    (cd "$root" && BUMS_MAX_STEPS=$slow_steps "$check" "$crate" $flags --filter "$pattern" --jobs "$jobs" \
      --mem-gb "$mem_gb" --timeout "$slow_timeout" --out "$tsv.slow") 2>&1 | { progress "$name" slow; cat >/dev/null; } || true
    [[ -f $tsv.slow ]] && cat "$tsv.slow" >>"$tsv.partial"
    rm -f "$tsv.slow"
  fi
  mv "$tsv.partial" "$tsv"
  rm -f "$out/progress/$name.txt"
  awk -F'\t' '{n++; s[$3]++} END {printf "    %s: %d checks", FILENAME, n; for (k in s) printf ", %d %s", s[k], k; print ""}' "$tsv" \
    | sed "s|$out/||"
}

count_checks() {
  total=0
  while IFS='|' read -r name crate flags; do
    [[ -n $only && " $only " != *" $name "* ]] && continue
    local n
    n=$(cd "$root" && "$check" "$crate" $flags --list 2>/dev/null | awk -F'\t' 'NF >= 2' | wc -l | tr -d ' ')
    total=$((total + n))
  done < <(suites)
}

run_suite() {
  local run=$1 name=$2 crate=$3 flags=$4
  local tsv=$out/run$run/$name.tsv
  local skip_file=$out/run$run/$name.skip slow_list=$here/slow/$name.txt
  : >"$skip_file"
  [[ -s $slow_list ]] && cat "$slow_list" >>"$skip_file"
  if [[ $run -gt 1 && -s $out/run1/$name.tsv ]]; then
    awk -F'\t' '$3 != "verified" && $3 != "rejected" {print $1}' "$out/run1/$name.tsv" >>"$skip_file"
  fi
  local log=$out/logs/$name.log
  echo "--- run $run $name started $(date '+%T')"
  check_suite "$name" "$crate" "$flags" "$tsv" "$skip_file" "$slow_list" >"$log" 2>&1
  rm -f "$skip_file"
  echo "--- run $run $name finished $(date '+%T'): $(tail -1 "$log" | sed 's/^ *//')"
}

sweep() {
  (cd "$root" && cargo build --release -p bums-check)
  echo "counting annotated functions in every suite"
  count_checks
  mkdir -p "$out/progress" "$out/logs"
  rm -f "$out"/progress/*.txt || true
  resumed=$(count_lines "$out"/run1/*.tsv)
  started=$(date +%s)
  echo "$total checks; $parallel suites at a time, $jobs jobs each, quickest first; follow progress with: tail -f $out/progress.txt"
  start_watchdog
  aggregate_progress &
  local aggregator=$!
  trap 'kill $watchdog $aggregator 2>/dev/null || true' EXIT
  for run in $(seq 1 "$runs"); do
    mkdir -p "$out/run$run"
    while IFS='|' read -r name crate flags; do
      [[ -n $only && " $only " != *" $name "* ]] && continue
      if [[ -s $out/run$run/$name.tsv ]]; then
        echo "--- run $run $name: already done ($(wc -l <"$out/run$run/$name.tsv" | tr -d ' ') checks)"
        continue
      fi
      while [[ $(jobs -rp | wc -l) -ge $((parallel + 2)) ]]; do sleep 2; done
      run_suite "$run" "$name" "$crate" "$flags" &
    done < <(suites)
    while [[ $(jobs -rp | wc -l) -gt 2 ]]; do sleep 5; done
  done
  kill $aggregator 2>/dev/null || true
  mkdir -p "$out/sizes"
  while IFS='|' read -r name crate flags; do
    [[ -n $only && " $only " != *" $name "* ]] && continue
    [[ -s $out/sizes/$name.tsv ]] && continue
    (cd "$root" && "$check" "$crate" $flags --sizes) | awk -F'\t' 'NF == 3' >"$out/sizes/$name.tsv" || true
  done < <(suites)
  kill $watchdog 2>/dev/null || true
}

overhead() {
  local bench=$here/wrapper-overhead
  mkdir -p "$out/overhead"
  (cd "$bench" && cargo build --release && ./target/release/wrapper-overhead --out "$out/overhead/overhead.tsv")
  (cd "$bench" && cargo build --release --features isolated --target-dir target-isolated \
    && ./target-isolated/release/wrapper-overhead --out "$out/overhead/isolated.tsv")
}

if wants prepare || wants sweep || wants overhead; then
  stamp prepare
  prepare_corecrypto
fi

if wants tests; then
  stamp tests
  if (cd "$root" && RUST_MIN_STACK=1073741824 cargo test -p bums -p bums_annotations --release --no-fail-fast) >"$out/tests.log" 2>&1; then
    grep -E '^test result' "$out/tests.log" | awk '{p += $4} END {print "    " p " tests passed"}'
  else
    echo "    tests FAILED, see $out/tests.log"
    exit 1
  fi
fi

if wants sweep; then
  stamp sweep
  sweep 2>&1 | tee -a "$out/sweep.log"
fi

if wants overhead; then
  stamp overhead
  overhead 2>&1 | tee -a "$out/overhead.log"
fi

if wants report; then
  stamp report
  overhead_dir=$results/overhead
  [[ -s $overhead_dir/overhead.tsv ]] || overhead_dir=$here/wrapper-overhead/results
  report_args=("$results" --out "$out/report" --overhead "$overhead_dir")
  $open_figures && report_args+=(--open)
  (cd "$here" && "$python" -m report "${report_args[@]}")
fi

if wants secsep; then
  stamp secsep
  "$python" "$root/secsep-eval/tools/make_figures.py" 2>/dev/null
  echo "    SecSep figures in $root/secsep-eval/paper-data/figures"
fi

stamp done
echo "evaluation directory: $out"
