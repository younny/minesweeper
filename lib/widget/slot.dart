import 'package:flutter/material.dart';
import 'package:minesweeper/bloc/enum.dart';

class Slot extends StatelessWidget {
  const Slot({
    Key key,
    this.item,
    this.slotState,
  }) : super(key: key);

  static const colors = [
    Colors.transparent,
    Colors.blue,
    Colors.orange,
    Colors.red,
    Colors.purple
  ];
  final String item;
  final SlotState slotState;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _pinkBackgroundColor(),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Center(
        child: _renderSlotContent(),
      ),
    );
  }

  bool _isFlagged() => slotState == SlotState.FLAGGED;

  bool _isFlipped() => slotState == SlotState.FLIPPED;

  Widget _renderSlotContent() {
    switch (slotState) {
      case SlotState.FLIPPED:
        return Text(item,
            style: TextStyle(
              color: _pickItemColor(),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ));
      case SlotState.FLAGGED:
        return Icon(
          Icons.flag,
          color: Colors.red,
          size: 24,
        );
      case SlotState.BOMBED:
        return Icon(
          Icons.bug_report,
          color: Colors.black,
          size: 24,
        );
      default:
        return Container();
    }
  }

  Color _pinkBackgroundColor() {
    if (_isFlipped())
      return Color(0xffedcb7b);
    else
      return Color(0xff97bd73);
  }

  Color _pickItemColor() => colors[int.parse(this.item)];
}
