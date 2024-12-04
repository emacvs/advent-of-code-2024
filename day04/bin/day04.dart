// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:path/path.dart' as p;

const WORD_KEY = "XMAS";
const DIRECTIONS = [
  [0, 1], // >
  [0, -1], // <
  [1, 0], // V
  [-1, 0], // ^
  [-1, 1], // ^>
  [1, 1], // V>
  [1, -1], // V<
  [-1, -1] // ^<
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
      for (var direction in DIRECTIONS) {
        if (isValidWord(matrix, word, r, c, direction[0], direction[1])) {
          wordFind++;
        }
      }
    }
  }
  return wordFind;
}

bool isValidWord(
    List<List<String>> matrix, String word, int r, int c, int dr, int dc) {
  for (var i = 0; i < word.length; i++) {
    if (isOutOfLimit(matrix, r, c) || matrix[r][c] != word[i]) {
      return false;
    }
    c += dc;
    r += dr;
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
