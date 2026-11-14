#!/bin/bash
set -u
here=$(cd "$(dirname "$0")" && pwd)
work=/tmp/secsep-dynamic
results=$here/results
mkdir -p "$work" "$results"
summary=$results/summary.tsv
[ "${APPEND:-0}" = 1 ] || printf "variant\tbench\tmode\ttool\texit\tverdict\tfirst_report\n" > "$summary"

classify() {
  local log=$1 code=$2
  if grep -qE "Invalid (read|write)|ERROR: AddressSanitizer" "$log"; then echo detected
  elif [ "$code" -ge 128 ] || grep -qE "Process terminating|Segmentation fault|SEGV" "$log"; then echo crashed
  elif [ "$code" -eq 124 ]; then echo timeout
  elif [ "$code" -ne 0 ]; then echo "exit-$code"
  else echo clean
  fi
}

first_report() {
  grep -m1 -E "Invalid (read|write) of size [0-9]+|ERROR: AddressSanitizer: [a-z-]+" "$1" | sed 's/^==[0-9]*== //' | tr -d '\n'
  local where
  where=$(grep -m1 -A1 -E "Invalid (read|write)|ERROR: AddressSanitizer" "$1" | tail -1 | grep -oE "(in |: )[A-Za-z_][A-Za-z_0-9]*" | head -1 | sed 's/^in //;s/^: //')
  [ -n "$where" ] && printf " @ %s" "$where"
}

run() {
  local variant=$1 bench=$2 mode=$3 tool=$4 bin=$5
  local log=$results/$variant.$mode.$tool.log code
  if [ "$tool" = valgrind ]; then
    timeout 1800 valgrind --error-exitcode=99 --error-limit=no "$bin" > "$log" 2>&1
  else
    ASAN_OPTIONS=detect_leaks=0 timeout 1800 "$bin" > "$log" 2>&1
  fi
  code=$?
  printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n" "$variant" "$bench" "$mode" "$tool" "$code" "$(classify "$log" "$code")" "$(first_report "$log")" >> "$summary"
  printf "%-16s %-8s %-9s %s\n" "$variant" "$mode" "$tool" "$(classify "$log" "$code")"
}

python3 -c "import json;[print(p['variant'],p['bench']) for p in json.load(open('$here/build/plan.json'))]" | while read -r variant bench; do
  src=$here/build/$variant
  out=$work/$variant
  mkdir -p "$out"
  gcc -g -O1 -o "$out/harness-plain" "$here/harness/$bench.c" "$src/harness.s" -lpthread 2>"$out/build.log"
  clang -g -O1 -fsanitize=address -fno-omit-frame-pointer -o "$out/harness-asan" "$here/harness/$bench.c" "$src/harness.s" -lpthread 2>>"$out/build.log"
  gcc -g -o "$out/shipped-plain" "$src/shipped.s" -lpthread 2>>"$out/build.log"
  clang -g -fsanitize=address -o "$out/shipped-asan" "$src/shipped.s" -lpthread 2>>"$out/build.log"
  for bin in harness-plain harness-asan shipped-plain shipped-asan; do
    [ -x "$out/$bin" ] || printf "%s\t%s\t%s\t%s\t-\tbuild-failed\t%s\n" "$variant" "$bench" "${bin%-*}" "${bin#*-}" "$(head -c 200 "$out/build.log" | tr '\n' ' ')" >> "$summary"
  done
  [ -x "$out/harness-plain" ] && run "$variant" "$bench" harness valgrind "$out/harness-plain"
  [ -x "$out/harness-asan" ] && run "$variant" "$bench" harness asan "$out/harness-asan"
  [ -x "$out/shipped-plain" ] && run "$variant" "$bench" shipped valgrind "$out/shipped-plain"
  [ -x "$out/shipped-asan" ] && run "$variant" "$bench" shipped asan "$out/shipped-asan"
done
echo "done: $summary"
