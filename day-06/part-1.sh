#!/bin/bash
set -euo pipefail

timers=(0 0 0 0 0 0 0 0 0)

IFS=','
for timer in $(cat "$1"); do
  timers[$timer]=$((timers["$timer"] + 1))
done
unset IFS

for _ in $(seq 80); do
  timers=(
    $((timers[1]))
    $((timers[2]))
    $((timers[3]))
    $((timers[4]))
    $((timers[5]))
    $((timers[6]))
    $((timers[7] + timers[0]))
    $((timers[8]))
    $((timers[0]))
  )
done

fish=0
for timer in "${timers[@]}"; do
  fish=$((fish + timer))
done

echo "$fish"
