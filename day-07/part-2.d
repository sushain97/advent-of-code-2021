module part2;

import std.algorithm;
import std.array;
import std.conv;
import std.math.algebraic;
import std.range;
import std.stdio;

void main(string[] argv) {
  auto positions = File(argv[1])
    .readln()
    .split(',')
    .map!(to!int)
    .array
    .sort;

  auto moveCost = (int n) => (n * (n + 1)) / 2;
  auto bestCost = iota(positions.minElement, positions.maxElement)
    .map!(i => positions.map!((x) => moveCost(abs(x - i))).sum)
    .minElement;

  writeln(bestCost);
}
