// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:path/path.dart' as p;

const WORD_KEY = "MAS";

class Direction {
  final int directionR;
  final int directionC;
  final int positionR;
  final int positionC;

  Direction(this.directionR, this.directionC, this.positionR, this.positionC);
}

//set direction & offset to start to search word
List<Direction> directions = [
  Direction(1, 1, 0, 0), //V>
  Direction(1, -1, 0, 2), // V<
  Direction(-1, -1, 2, 2), // ^<
  Direction(-1, 1, 2, 0), // ^>
];

void main(List<String> arguments) {
  List<List<String>> matrix = [];
  var wordAppear = 0;
  matrix = readData(File(p.join(Directory.current.path, 'input.txt')));
  wordAppear = searchWordInMatrix(WORD_KEY, matrix);
  print(wordAppear);
}

int searchWordInMatrix(String word, List<List<String>> matrix) {
  var wordFind = 0;
  for (var r = 0; r < matrix.length; r++) {
    for (var c = 0; c < matrix[r].length; c++) {
      if (findX(matrix, word, r, c)) {
        wordFind++;
      }
    }
  }
  return wordFind;
}

bool findX(matrix, word, r, c) {
  var xfind = 0;
  for (var direction in directions) {
    var row = r + direction.positionR;
    var col = c + direction.positionC;
    if (isValidWord(matrix, word, row, col, direction)) {
      xfind++;
    }
  }
  return xfind >= 2;
}

bool isValidWord(
    List<List<String>> matrix, String word, int r, int c, Direction direction) {
  for (var i = 0; i < word.length; i++) {
    if (isOutOfLimit(matrix, r, c) || matrix[r][c] != word[i]) {
      return false;
    }
    c += direction.directionC;
    r += direction.directionR;
  }
  return true;
}

bool isOutOfLimit(List<List<String>> matrix, int r, int c) {
  if (r < 0 || r >= matrix.length) {
    return true;
  } else if (c < 0 || c >= matrix[r].length) {
    return true;
  }
  return false;
}

//Function to read file
List<List<String>> readData(File file) {
  List<List<String>> data = [];
  var fileContent = file.readAsLinesSync();
  for (var lineString in fileContent) {
    data.add(lineString.split(''));
  }

  return data;
}
