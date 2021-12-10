import 'dart:convert';
import 'dart:io';

const DIGITS = {
  'abcefg': 0,
  'cf': 1,
  'acdeg': 2,
  'acdfg': 3,
  'bcdf': 4,
  'abdfg': 5,
  'abdefg': 6,
  'acf': 7,
  'abcdefg': 8,
  'abcdfg': 9,
};

void main(List<String> args) async {
  print(await File(args[0])
      .openRead()
      .transform(utf8.decoder)
      .transform(new LineSplitter())
      .map((line) {
    var mapping = {};

    var inputAndOutput = line.trim().split(' | ');
    var input = inputAndOutput[0];
    var output = inputAndOutput[1];

    var inputsByLen = Map.fromEntries(
        input.split(' ').map((n) => MapEntry(n.length, Set.from(n.split('')))));

    var letterFreqs = {}, lettersByFreq = {};
    input.split('').where((l) => l != ' ').forEach((letter) {
      letterFreqs[letter] = (letterFreqs[letter] ?? 0) + 1;
    });
    letterFreqs.forEach((letter, freq) {
      lettersByFreq[freq] = (lettersByFreq[freq] ?? Set())..add(letter);
    });

    mapping['a'] = inputsByLen[3].difference(inputsByLen[2]).first;
    mapping['b'] = lettersByFreq[6].first;
    mapping['c'] =
        (lettersByFreq[8].difference(Set.from([mapping['a']]))).first;
    mapping['f'] = lettersByFreq[9].first;
    mapping['d'] = (inputsByLen[4]
        .difference(Set.from('bcf'.split('').map((c) => mapping[c])))).first;
    mapping['e'] = lettersByFreq[4].first;
    mapping['g'] =
        (Set.from('abcdefg'.split('')).difference(Set.from(mapping.values)))
            .first;

    var reverseMapping = mapping.map((k, v) => MapEntry(v, k));

    return int.parse(output
        .split(' ')
        .map((n) => DIGITS[(n.split('').map((c) => reverseMapping[c]).toList()
                  ..sort())
                .join()]
            .toString())
        .join(''));
  }).reduce((a, b) => a + b));
}
