import 'dart:io';
import 'package:path/path.dart' as p;

void main(List<String> arguments) {
  var memory = readData(File(p.join(Directory.current.path, 'input.txt')));
  var result = 0;
  RegExp exp = RegExp(r"mul\((\d{0,3}),(\d{0,3})\)+|do\(\)+|don\'t\(\)");
  var matches = exp.allMatches(memory);
  var enabled = true;
  for (var match in matches) {
    if (match[0]!.contains("mul")) {
      if (enabled) {
        result += int.parse(match[1]!) * int.parse(match[2]!);
      }
    } else {
      enabled = match[0]!.contains("do()");
    }
  }

  print(result);
}

//Function to read file
String readData(File file) {
  return file.readAsStringSync();
}
