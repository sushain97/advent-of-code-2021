module part1;

import std.algorithm;
import std.array;
import std.conv;
import std.math.algebraic;
import std.stdio;

void main(string[] argv) {
  auto positions = File(argv[1])
    .readln()
    .split(',')
    .map!(to!int)
    .array
    .sort;

  auto median = positions[positions.length / 2];
  auto cost = positions
    .map!((a) => abs(a - median))
    .sum;

  writeln(cost);
}
