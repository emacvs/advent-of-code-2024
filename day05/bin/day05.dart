// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:path/path.dart' as p;

void main(List<String> arguments) {
  List<List<int>> rules = [];
  List<List<int>> manuals = [];
  var data = readData(File(p.join(Directory.current.path, 'input.txt')));
  rules = parseData(data[0].split("\n"), "|");
  manuals = parseData(data[1].split("\n"), ",");

  var correctManuals = getCorrectManuals(rules, manuals);
  var result = sumMiddleElement(correctManuals);
  print(result);
}

//Function to read file
List<String> readData(File file) {
  var fileContent = file.readAsStringSync();
  var data = fileContent.split("\r\n\r\n");
  return data;
}

//function to parse the data
List<List<int>> parseData(List<String> data, String separator) {
  List<List<int>> parsedData = [];
  for (var d in data) {
    var x = d.split(separator);
    parsedData.add(x.map((a) => int.parse(a)).toList());
  }
  return parsedData;
}

//function to check rule
List<List<int>> getCorrectManuals(
    List<List<int>> rules, List<List<int>> manuals) {
  List<List<int>> correctManuals = [];
  for (var manual in manuals) {
    var isAllCorrect = true;
    for (var pI = 0; pI < manual.length; pI++) {
      var isCorrect = true;
      var filteredRules = getFilteredRules(rules, manual[pI]);
      for (var filteredRule in filteredRules) {
        var index = manual.indexOf(filteredRule[1]);
        if (index > pI || index == -1) {
          isCorrect = true;
        } else {
          isCorrect = false;
          break;
        }
      }
      if (isCorrect) {
        isAllCorrect = true;
      } else {
        isAllCorrect = false;
        break;
      }
    }
    if (isAllCorrect) {
      correctManuals.add(manual);
    }
  }

  return correctManuals;
}

List<List<int>> getFilteredRules(List<List<int>> rules, int page) {
  return rules.where((rule) => rule[0] == page).toList();
}

int sumMiddleElement(List<List<int>> manuals) {
  var sum = 0;
  for (var manual in manuals) {
    sum += getMiddleElement(manual);
  }
  return sum;
}

int getMiddleElement(List<int> list) {
  return list[(list.length ~/ 2)];
}
