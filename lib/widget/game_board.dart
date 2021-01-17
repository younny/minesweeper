import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper/bloc/enum.dart';
import 'package:minesweeper/widget/setting_bar.dart';
import 'package:minesweeper/widget/slot.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({
    Key key,
    @required this.row,
    @required this.totalMines,
    @required this.board,
  }) : super(key: key);

  final int row;
  final int totalMines;
  final List board;

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  int row;
  List slotState;
  int totalMines;

  @override
  void initState() {
    super.initState();
    row = widget.row;
    totalMines = widget.totalMines;
    slotState = List.generate(row, (index) => List(row));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingBar(totalMines: totalMines),
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
                  item: (widget.board[x][y] ?? 0).toString(),
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

  _onTap(int row, int col) {
    setState(() {
      if (widget.board[row][col] == '*') {
        slotState[row][col] = SlotState.BOMBED;
        print("Bombed!!!!!!");
      } else {
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
    int randomTop = row == 0 ? 0 : Random().nextInt(row);
    int randomBottom = Random().nextInt(widget.row);
    int randomLeft = col == 0 ? 0 : Random().nextInt(col);
    int randomRight = Random().nextInt(widget.row);

    for (int i = row; i >= randomTop && i > 0; i--) {
      if (_isBomb(i, col)) return;
      if (col > 0) _flipColumnRandomly(i, col);
      _flip(i, col);
    }

    for (int i = row + 1; i <= randomBottom; i++) {
      if (_isBomb(i, col)) break;
      if (col > 0) _flipColumnRandomly(i, col);
      _flip(i, col);
    }

    for (int i = col; i >= randomLeft && i > 0; i--) {
      if (_isBomb(row, i)) break;
      if (col > 0) _flipColumnRandomly(i, col);
      _flip(row, i);
    }

    for (int i = col + 1; i <= randomRight; i++) {
      if (_isBomb(row, i)) break;
      if (col > 0) _flipColumnRandomly(i, col);
      _flip(row, i);
    }
  }

  _isBomb(int row, int col) => widget.board[row][col] == '*';

  _flip(int row, int col) {
    setState(() {
      slotState[row][col] = SlotState.FLIPPED;
    });
  }

  _flipColumnRandomly(int row, int col) {
    for (int j = col; j >= Random().nextInt(col); j--) {
      if (_isBomb(row, j)) break;
      _flip(row, j);
    }
    for (int j = col; j <= Random().nextInt(widget.row); j++) {
      if (_isBomb(row, j)) break;
      _flip(row, j);
    }
  }
}
