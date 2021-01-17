import 'dart:math';

import 'package:flutter/material.dart';

class GameClient {
  GameClient();

  final flag = ['*', 0, 0, 0, 0, 0, 0, 0, 0, 0];
  final totalMines = 10;

  List board;
  int row = 10;
  int col = 10;

  List setBoard(int row, int col) {
    this.row = row;
    this.col = col;
    return List.generate(row, (_) => List(col));
  }

  Future<List> initGame({@required int row, @required int col}) async {
    board = setBoard(row, col);

    var count = 0;
    for (int r = 0; r < row; r++) {
      for (int c = 0; c < col; c++) {
        final picked = flag[Random().nextInt(flag.length)];
        if (picked == '*') {
          count++;
        }
        if (count > 10) {
          board[r][c] = 0;
        } else {
          board[r][c] = picked;
        }
      }
    }
    return board;
  }

  Future<List> setCount() async {
    for (int r = 0; r < row; r++) {
      for (int c = 0; c < col; c++) {
        if (board[r][c] == '*') {
          addCountAdjacent(r, c);
        }
      }
    }

    return board;
  }

  addCountAdjacent(int r, int c) {
    for (int i = r - 1; i <= r + 1; i++) {
      for (int j = c - 1; j <= c + 1; j++) {
        if (i < 0 || i >= row) break;
        if (j < 0 || j >= col) break;
        if (board[i][j] == '*') break;

        board[i][j]++;
      }
    }
  }
}
