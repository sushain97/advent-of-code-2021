import 'dart:convert';
import 'dart:io';

void main(List<String> args) async {
  var file = File(args[0]);

  var horiz = 0, depth = 0;

  await file
    .openRead()
    .transform(utf8.decoder)
    .transform(new LineSplitter())
    .forEach((line) {
      var dir_and_unit = line.split(' ');
      var dir = dir_and_unit[0];
      var unit = int.parse(dir_and_unit[1]);

      switch(dir) {
        case 'forward': horiz += unit; break;
        case 'down': depth += unit; break;
        case 'up': depth -= unit; break;
      }
    });

  print(horiz * depth);
}

