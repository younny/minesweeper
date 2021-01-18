import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper/bloc/enum.dart';
import 'package:minesweeper/model/board.dart';
import 'package:minesweeper/widget/setting_bar.dart';
import 'package:minesweeper/widget/slot.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({
    Key key,
    @required this.row,
    @required this.totalMines,
    @required this.board,
    @required this.restart,
  }) : super(key: key);

  final int row;
  final int totalMines;
  final Board board;
  final Function restart;

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  int row;
  List slotState;
  int totalMines;
  Board board;

  @override
  void initState() {
    super.initState();
    row = widget.row;
    totalMines = widget.totalMines;
    board = widget.board;
    slotState = List.generate(row, (index) => List(row));
  }

  @override
  void didUpdateWidget(covariant GameBoard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.board != widget.board) {
      setState(() {
        board = widget.board;
        slotState = List.generate(row, (index) => List(row));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingBar(
          totalMines: totalMines,
          onRefresh: _onRefresh,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: row,
            ),
            itemBuilder: (context, index) {
              int x = (index / row).floor();
              int y = index % row;
              return GestureDetector(
                onTap: () => _onTap(x, y),
                onLongPress: () => _onLongTap(x, y),
                child: Slot(
                  item: (widget.board.grid[x][y] ?? 0).toString(),
                  slotState: slotState[x][y],
                ),
              );
            },
            itemCount: row * row,
          ),
        ),
      ],
    );
  }

  _onRefresh() {
    widget.restart();
  }

  _onReveal() {
    setState(() {
      for (int i = 0; i < row; i++) {
        for (int j = 0; j < row; j++) {
          slotState[i][j] = SlotState.FLIPPED;
        }
      }
    });
  }

  _showDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Lose'),
            content: Container(
              child: Text(
                  'Bomb found'
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();

                  _onReveal();
                },
              ),
              TextButton(
                child: Text('Restart'),
                onPressed: () {
                  Navigator.of(context).pop();

                  widget.restart();
                },
              )
            ],
          );
        });
  }

  _onTap(int row, int col) {
    setState(() {
      if (widget.board.grid[row][col] == '*') {
        slotState[row][col] = SlotState.BOMBED;
        _showDialog();
      } else if (slotState[row][col] != SlotState.FLAGGED) {
        slotState[row][col] = SlotState.FLIPPED;
        _flipNearby(row, col);
      }
    });
  }

  _onLongTap(int row, int col) {
    setState(() {
      if (slotState[row][col] == SlotState.FLAGGED) {
        slotState[row][col] = SlotState.DEFAULT;
        totalMines++;
      } else {
        slotState[row][col] = SlotState.FLAGGED;
        totalMines--;
      }
    });
  }

  _flipNearby(int row, int col) {

    for (int i = row; i > row && i > 0; i--) {
      if (_isBomb(i, col)) break;
      if (_isMoreThanOne(i, col)) break;
      if (col > 0) _flipColumnRandomly(i, col);
      _flip(i, col);
    }

    for (int i = row + 1; i < widget.row; i++) {
      if (_isBomb(i, col)) break;
      if (_isMoreThanOne(i, col)) break;
      if (col > 0) _flipColumnRandomly(i, col);
      _flip(i, col);
    }

    for (int i = col; i > col && i > 0; i--) {
      if (_isBomb(row, i)) break;
      if (_isMoreThanOne(row, i)) break;
      if (col > 0) _flipColumnRandomly(i, col);
      _flip(row, i);
    }

    for (int i = col + 1; i < widget.row; i++) {
      if (_isBomb(row, i)) break;
      if (_isMoreThanOne(row, i)) break;
      if (col > 0) _flipColumnRandomly(i, col);
      _flip(row, i);
    }
  }

  _isBomb(int row, int col) => widget.board.grid[row][col] == '*';

  _isMoreThanOne(int row, int col) =>
      widget.board.grid[row][col] != null && widget.board.grid[row][col] > 1;

  _flip(int row, int col) {
    setState(() {
      slotState[row][col] = SlotState.FLIPPED;
    });
  }

  _flipColumnRandomly(int row, int col) {
    for (int j = col; j > col; j--) {
      if (_isBomb(row, j)) break;
      if (_isMoreThanOne(row, j)) break;
      _flip(row, j);
    }
    for (int j = col; j < widget.row; j++) {
      if (_isBomb(row, j)) break;
      if (_isMoreThanOne(row, j)) break;
      _flip(row, j);
    }
  }
}
