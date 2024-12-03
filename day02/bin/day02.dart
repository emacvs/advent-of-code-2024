import 'dart:io';
import 'package:path/path.dart' as p;

void main(List<String> arguments) {
  List<List<int>> reports = [];
  reports = readData(File(p.join(Directory.current.path, 'input.txt')));
  var safeReport = 0;

  for (var report in reports) {
    if (isSafe(report)) {
      safeReport++;
    } else {
      //try to remove every element to test
      for (var i = 0; i < report.length; i++) {
        List<int> fixed = List.from(report);
        fixed.removeAt(i);
        if (isSafe(fixed)) {
          safeReport++;
          break;
        }
      }
    }
  }
  print(safeReport);
}

bool isSafe(List<int> report) {
  bool? isDecrasing;
  var isSafe = true;

  for (int i = 0; i < report.length - 1; i++) {
    var check = report[i] - report[i + 1];

    //check if no change or change is > 3 than exit
    if (check == 0 || check.abs() > 3) {
      isSafe = false;
    }

    //check decrasing or incrasing
    if (isDecrasing == null) {
      isDecrasing = check < 0;
    } else if (isDecrasing != check < 0) {
      isSafe = false;
    }

    if (!isSafe) {
      break;
    }
  }

  return isSafe;
}

//Function to read file
List<List<int>> readData(File file) {
  List<List<int>> data = [];
  var fileContent = file.readAsLinesSync();

  for (var lineString in fileContent) {
    List<int> line = [];
    for (var i in lineString.split(' ')) {
      var x = int.tryParse(i);
      if (x != null) {
        line.add(x);
      }
    }
    data.add(line);
  }

  return data;
}
