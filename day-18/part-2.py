#!/usr/bin/env python3

import json
import math
import re
import sys


def _split(number, left_split=False):
    new_number = []
    for element in number:
        if isinstance(element, int) and not left_split and element >= 10:
            new_number.append([element // 2, math.ceil(element / 2)])
            left_split = True
        elif isinstance(element, list):
            new_element, left_split = _split(element, left_split)
            new_number.append(new_element)
        else:
            new_number.append(element)
    return (new_number, left_split)


def split(number):
    return _split(number)[0]


def explode(number):
    nesting = 0
    number_str = str(number)
    for i, c in enumerate(number_str):
        if c == "[":
            nesting += 1
        elif c == "]":
            nesting -= 1

        if nesting == 5 and (match := re.match(r"\[(\d+), (\d+)\]", number_str[i:])):
            left_explode = int(match.group(1))
            right_explode = int(match.group(2))

            right_match = re.search(r"(\d+)", number_str[i + match.end() :])
            if right_match:
                number_str = (
                    number_str[: i + match.end() + right_match.start(1)]
                    + str(int(right_match.group(1)) + right_explode)
                    + number_str[i + match.end() + right_match.end(1) :]
                )

            number_str = number_str[:i] + "0" + number_str[i + match.end() :]

            left_match = re.search(r".*\b(\d+)", number_str[:i])
            if left_match:
                number_str = (
                    number_str[: left_match.start(1)]
                    + str(int(left_match.group(1)) + left_explode)
                    + number_str[left_match.end(1) :]
                )

            return True, json.loads(number_str)
    return False, number


def reduce(number):
    while True:
        changed, number = explode(number)
        if changed:
            continue

        if (split_number := split(number)) != number:
            number = split_number
            continue

        return number


def magnitude(entry):
    if isinstance(entry, int):
        return entry
    else:
        return 3 * magnitude(entry[0]) + 2 * magnitude(entry[1])


if __name__ == "__main__":
    numbers = [json.loads(line.strip()) for line in open(sys.argv[1]).readlines()]
    print(max(magnitude(reduce([a, b])) for a in numbers for b in numbers if a != b))
