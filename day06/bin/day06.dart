// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:path/path.dart' as p;

class Direction {
  final int r;
  final int c;

  Direction(this.r, this.c);
}

class Position {
  int r;
  int c;
  Position(this.r, this.c);
}

class Guard {
  final String visitedChar = "X";
  String guardChar;
  String obstacleChar;
  Position position = Position(0, 0);
  int limitR = 0;
  int limitC = 0;
  int directionIndex = 0;
  List<List<String>> matrix;
  int step = 0;
  int uniquePosition = 1;

  final List<Direction> directions = [
    Direction(-1, 0),
    Direction(0, 1),
    Direction(1, 0),
    Direction(0, -1),
  ];

  rotate() {
    directionIndex++;
    if (directionIndex >= directions.length) {
      directionIndex = 0;
    }
  }

  bool move() {
    if (isOutOfLimits()) {
      return false;
    }

    if (isObstacle()) {
      rotate();
    }

    matrix[position.r][position.c] = visitedChar;
    position.r += directions[directionIndex].r;
    position.c += directions[directionIndex].c;
    if (matrix[position.r][position.c] != visitedChar) {
      uniquePosition++;
    }
    matrix[position.r][position.c] = guardChar;
    step++;

    return true;
  }

  void printMatrix() {
    for (var row in matrix) {
      print(row.reduce((a, b) => a + b));
    }
  }

  bool isOutOfLimits() {
    var nextPosition = getNextPosition();
    return nextPosition.r > limitR ||
        nextPosition.r < 0 ||
        nextPosition.c > limitC ||
        nextPosition.c < 0;
  }

  bool isObstacle() {
    var nextPosition = getNextPosition();
    return matrix[nextPosition.r][nextPosition.c] == obstacleChar;
  }

  Position getNextPosition() {
    return Position(position.r + directions[directionIndex].r,
        position.c + directions[directionIndex].c);
  }

  //function to get the start position
  setStartPosition() {
    for (var r = 0; r < matrix.length; r++) {
      for (var c = 0; c < matrix[r].length; c++) {
        if (matrix[r][c] == guardChar) {
          position = Position(r, c);
          return;
        }
      }
    }
    throw "Position not found";
  }

  Guard(this.matrix, this.guardChar, this.obstacleChar) {
    setStartPosition();
    limitR = matrix.length - 1;
    limitC = matrix[0].length - 1;
  }
}

void main(List<String> arguments) {
  List<List<String>> matrix;
  matrix = readData(File(p.join(Directory.current.path, 'input.txt')));
  var guard = Guard(matrix, "^", "#");
  while (guard.move()) {}
  guard.printMatrix();
  print(guard.step);
  print(guard.uniquePosition);
}

//Function to read file
List<List<String>> readData(File file) {
  List<List<String>> matrix = [];
  var lines = file.readAsLinesSync();
  for (var line in lines) {
    matrix.add(line.split(''));
  }
  return matrix;
}
