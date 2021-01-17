import 'package:flutter/material.dart';

class SettingBar extends StatelessWidget {
  const SettingBar({Key key, this.height = 50, @required this.totalMines}): super(key: key);

  final double height;
  final int totalMines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Icon(
            Icons.flag,
            color: Colors.red,
            size: height / 2,
          ),
          Text('$totalMines',
              style: TextStyle(
                fontSize: height / 3,
                color: Colors.black,
              ),
          ),
        ],
      ),
    );
  }
}
