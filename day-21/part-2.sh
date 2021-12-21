#!/usr/bin/env bash
set -euo pipefail

positions=()
regex='Player ([[:digit:]]) starting position: ([[:digit:]])'
while IFS= read -r line; do
  [[ $line =~ $regex ]]
  positions[((${BASH_REMATCH[1]} - 1))]=${BASH_REMATCH[2]}
done < "$1"

declare -A winners

declare -A dice_weights
dice_weights[3]=1
dice_weights[4]=3
dice_weights[5]=6
dice_weights[6]=7
dice_weights[7]=6
dice_weights[8]=3
dice_weights[9]=1

count_win() {
  local p1_position=$1
  local p2_position=$2
  local p1_score=$3
  local p2_score=$4

  if (( p1_score >= 21 )); then
    return_counts=(1 0)
  elif (( p2_score >= 21 )); then
    return_counts=(0 1)
  elif [[ -v winners["$*"] ]]; then
    [[ "${winners["$*"]}" =~ ([[:digit:]]+)\ ([[:digit:]]+) ]]
    return_counts=("${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}")
  else
    local result=(0 0)
    for dice_sum in "${!dice_weights[@]}"; do
      local dice_weight=${dice_weights[$dice_sum]}
      local p1_new_position=$(( (p1_position + dice_sum - 1) % 10 + 1 ))
      local p1_new_score=$(( p1_score + p1_new_position ))

      count_win "$p2_position" "$p1_new_position" "$p2_score" "$p1_new_score"
      result=($(( result[0] + return_counts[1] * dice_weight )) $(( result[1] + return_counts[0] * dice_weight )))
    done

    winners["$*"]="${result[*]}"
    return_counts=("${result[@]}")
  fi
}

count_win "${positions[0]}" "${positions[1]}" 0 0
echo "$((return_counts[0] > return_counts[1] ? return_counts[0] : return_counts[1]))"
