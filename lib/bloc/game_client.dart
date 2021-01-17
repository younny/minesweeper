import 'dart:math';

import 'package:flutter/cupertino.dart';

class GameClient {

  GameClient(
      {@required this.totalMines, @required this.row, @required this.col}) {
    board = setBoard();
  }

  final int totalMines;
  final int row;
  final int col;

  List board;

  List setBoard() {
    return List.generate(row, (_) => List(col));
  }

  Future<List> initGame() async {
    await setBombs();

    await setCount();

    return board;
  }

  Future<List> setBombs() async {
    var count = 0;
    while (count < totalMines) {
      int i = Random().nextInt(row);
      int j = Random().nextInt(row);
      board[i][j] = '*';
      count++;
    }
    return board;
  }

  setCount() async {
    for (int r = 0; r < row; r++) {
      for (int c = 0; c < col; c++) {
        if (board[r][c] == '*') {
          addCountAdjacent(r, c);
        }
      }
    }
  }

  addCountAdjacent(int r, int c) {
    for (int i = max(0, r - 1); i <= min(row - 1, r + 1); i++) {
      for (int j = max(0, c - 1); j <= min(col - 1, c + 1); j++) {
        if (board[i][j] != '*') {
          addCount(i, j);
        }
      }
    }
  }

  addCount(int r, int c) {
    if (board[r][c] == null)
      board[r][c] = 1;
    else
      board[r][c]++;
  }
}
