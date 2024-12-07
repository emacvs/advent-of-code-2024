// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

void main(List<String> arguments) {
  List<List<int>> rules = [];
  List<List<int>> manuals = [];
  var data = readData(File(p.join(Directory.current.path, 'input.txt')));
  rules = parseData(data[0].split("\n"), "|");
  manuals = parseData(data[1].split("\n"), ",");

  var parsedManuals = getParsedManuals(rules, manuals);
  var fixedManuals = fixManuals(parsedManuals[1], rules);
  var resultCorrect = sumMiddleElement(parsedManuals[0]);
  var resultFixed = sumMiddleElement(fixedManuals);
  print(resultCorrect);
  print(resultFixed);
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
List<List<List<int>>> getParsedManuals(
    List<List<int>> rules, List<List<int>> manuals) {
  List<List<int>> correctManuals = [];
  List<List<int>> incorrectManuals = [];
  for (var manual in manuals) {
    var isAllCorrect = isManualCorrect(rules, manual);
    if (isAllCorrect) {
      correctManuals.add(manual);
    } else {
      incorrectManuals.add(manual);
    }
  }

  return [correctManuals, incorrectManuals];
}

bool isManualCorrect(List<List<int>> rules, List<int> manual) {
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
  return isAllCorrect;
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

List<int> fixManual(List<int> manual, List<List<int>> rules) {
  var fixed = manual;
  for (var pI = 0; pI < manual.length; pI++) {
    var filteredRules = getFilteredRules(rules, manual[pI]);
    for (var filteredRule in filteredRules) {
      var index = manual.indexOf(filteredRule[1]);
      if (index <= pI && index != -1) {
        fixed.swap(pI, index);
        fixed = fixManual(fixed, rules);
        break;
      }
    }
  }
  return fixed;
}

List<List<int>> fixManuals(List<List<int>> manuals, List<List<int>> rules) {
  List<List<int>> fixedManuals = [];
  for (var manual in manuals) {
    fixedManuals.add(fixManual(manual, rules));
  }
  return fixedManuals;
}
