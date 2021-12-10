import 'dart:convert';
import 'dart:io';

const LENGTHS = {2, 3, 4, 7};

void main(List<String> args) async {
  print(await File(args[0])
      .openRead()
      .transform(utf8.decoder)
      .transform(new LineSplitter())
      .map((line) => line
          .trim()
          .split(' | ')[1]
          .split(' ')
          .where((s) => LENGTHS.contains(s.length))
          .length)
      .reduce((a, b) => a + b));
}
