import 'dart:math';

class GameClient {
  final flags = ['*', 0, 0, 0, 0, 0, 0, 0, 0, 0];

  int row = 10;
  int col = 10;
  int totalMines = 10;

  GameClient();

  List setBoard() {
    return List.generate(row, (_) => List(col));
  }

  Future<List> initGame() async {
    final board = await setMines();

    return await setCount(board);
  }

  Future<List> setMines() async {
    final board = setBoard();

    var count = 0;
    for (int r = 0; r < row; r++) {
      for (int c = 0; c < col; c++) {
        final picked = flags[Random().nextInt(flags.length)];
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

  Future<List> setCount(List board) async {
    for (int r = 0; r < row; r++) {
      for (int c = 0; c < col; c++) {
        if (board[r][c] == '*') {
          addCountAdjacent(board, r, c);
        }
      }
    }

    return board;
  }

  addCountAdjacent(List board, int r, int c) {
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
