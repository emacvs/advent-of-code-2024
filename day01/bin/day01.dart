import 'dart:io';
import 'package:path/path.dart' as p;

void main(List<String> arguments) {
  List<int> list0 = [];
  List<int> list1 = [];
  var result = 0;
  var similarity = 0;

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
    result += ((list0[i] - list1[i]).abs());
    similarity += list0[i] * list1.where((item) => item == list0[i]).length;
  }
  print(result);
  print(similarity);
}
