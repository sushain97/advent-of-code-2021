#!/bin/sh
set -eu

horiz=depth=aim=0

while read -r line; do
  IFS=' '; set -- $line; unset IFS
  case $1 in
    'forward')
      horiz=$((horiz + $2))
      depth=$((depth + aim * $2))
      ;;
    'down') aim=$((aim + $2)) ;;
    'up') aim=$((aim - $2)) ;;
  esac
done < "$1"

echo "$((horiz * depth))"
