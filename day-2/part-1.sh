#!/bin/sh
set -eu

horiz=depth=0

while read -r line; do
  IFS=' '; set -- $line; unset IFS
  case $1 in
    'forward') horiz=$((horiz + $2)) ;;
    'down') depth=$((depth + $2)) ;;
    'up') depth=$((depth - $2)) ;;
  esac
done < "$1"

echo "$((horiz * depth))"
