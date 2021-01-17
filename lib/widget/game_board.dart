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
        SettingBar(
            totalMines: totalMines
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
                  item: '${widget.board[x][y]}',
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
}
