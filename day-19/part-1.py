#!/usr/bin/env python3

import collections
import dataclasses
import itertools
import sys

ROTATIONS = list(
    itertools.product(
        itertools.product((-1, 1), repeat=3),
        itertools.permutations((0, 1, 2)),
    )
)


@dataclasses.dataclass
class Scanner:
    beacons: set[tuple]
    position: tuple = None


def test_scanner(unknown_scanner, known_scanner):
    for (orientation, permutation) in ROTATIONS:
        counts = collections.Counter()

        for unknown_beacon in unknown_scanner.beacons:
            for known_beacon in known_scanner.beacons:
                position = tuple(
                    unknown_beacon[coordinate]
                    + orientation[coordinate] * known_beacon[permutation[coordinate]]
                    for coordinate in range(3)
                )
                counts[position] += 1

                if counts[position] >= 12:
                    known_scanner.position = position
                    known_scanner.beacons = {
                        tuple(
                            known_scanner.position[coordinate]
                            - orientation[coordinate] * beacon[permutation[coordinate]]
                            for coordinate in range(3)
                        )
                        for beacon in known_scanner.beacons
                    }
                    return True


if __name__ == "__main__":
    scanners = [
        Scanner(
            {tuple(map(int, line.strip().split(","))) for line in scanner_lines.splitlines()[1:]}
        )
        for scanner_lines in open(sys.argv[1]).read().split("\n\n")
    ]

    scanners[0].position = (0, 0, 0)
    known_scanners = {0}

    while len(known_scanners) < len(scanners):
        learned_scanners = set()

        for known_scanner in known_scanners:
            for i, scanner in enumerate(scanners):
                if i not in known_scanners and test_scanner(scanners[known_scanner], scanner):
                    learned_scanners.add(i)

        known_scanners |= learned_scanners

    print(len(set.union(*(scanner.beacons for scanner in scanners))))
