import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:minesweeper/model/board.dart';

class GameClient {
  GameClient(
      {@required this.totalMines, @required this.row, @required this.col});

  final int totalMines;
  final int row;
  final int col;

  Board board;

  Board setBoard() {
    return Board(grid: List.generate(row, (_) => List(col)));
  }

  Future<Board> initGame() async {
    board = setBoard();

    await setBombs();

    await setCount();

    return board;
  }

  Future<Board> setBombs() async {
    int count = 0;
    while (count < totalMines) {
      int i = Random().nextInt(row);
      int j = Random().nextInt(row);
      if (board.grid[i][j] == null) {
        board.grid[i][j] = '*';
        count++;
      }
    }
    return board;
  }

  setCount() async {
    for (int r = 0; r < row; r++) {
      for (int c = 0; c < col; c++) {
        if (board.grid[r][c] == '*') {
          addCountAdjacent(r, c);
        }
      }
    }
  }

  addCountAdjacent(int r, int c) {
    for (int i = max(0, r - 1); i <= min(row - 1, r + 1); i++) {
      for (int j = max(0, c - 1); j <= min(col - 1, c + 1); j++) {
        if (board.grid[i][j] != '*') {
          addCount(i, j);
        }
      }
    }
  }

  addCount(int r, int c) {
    if (board.grid[r][c] == null)
      board.grid[r][c] = 1;
    else
      board.grid[r][c]++;
  }
}
