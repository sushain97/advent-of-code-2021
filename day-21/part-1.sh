#!/usr/bin/env bash
set -euo pipefail

positions=()
regex='Player ([[:digit:]]) starting position: ([[:digit:]])'
while IFS= read -r line; do
  [[ $line =~ $regex ]]
  positions[((${BASH_REMATCH[1]} - 1))]=${BASH_REMATCH[2]}
done < "$1"

dice_value=1
dice_rolls=0
scores=(0 0)
player_turn=0

while (( scores[0] < 1000 && scores[1] < 1000 )); do
  dice_sum=0
  for _ in {1..3}; do
    dice_sum=$(( dice_sum + dice_value ))
    dice_value=$(( dice_value + 1 ))
    dice_rolls=$(( dice_rolls + 1 ))
  done

  positions[$player_turn]=$(( (positions[player_turn] + dice_sum - 1) % 10 + 1 ))
  scores[$player_turn]=$(( scores[player_turn] + positions[player_turn] ))
  player_turn=$(( (player_turn + 1) % 2 ))
done

echo "$(( (scores[0] < scores[1] ? scores[0] : scores[1]) * dice_rolls ))"
