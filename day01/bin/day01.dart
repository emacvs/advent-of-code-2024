import 'dart:io';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

void main(List<String> arguments) {
  List<int> list0 = [];
  List<int> list1 = [];
  List<int> result = [];

  var filePath = p.join(Directory.current.path, 'input.txt');
  File file = File(filePath);
  var fileContent = file.readAsLinesSync();

  for (var lineString in fileContent) {
    List<int> line = [];
    for (var i in lineString.split(' ')) {
      var x = int.tryParse(i);
      if (x != null) {
        line.add(x);
      }
    }
    list0.add(line[0]);
    list1.add(line[1]);
  }

  list0.sort();
  list1.sort();

  for (var i = 0; i < list0.length; i++) {
    result.add((list0[i] - list1[i]).abs());
  }
  print(result.sum);
}
