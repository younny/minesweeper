import 'package:flutter/material.dart';

class SettingBar extends StatelessWidget {
  const SettingBar({
    Key key,
    this.height = 50,
    @required this.totalMines,
    @required this.onRefresh,
  }) : super(key: key);

  final double height;
  final int totalMines;
  final Function onRefresh;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                Icons.flag,
                color: Colors.red,
                size: height / 2,
              ),
              Text(
                '$totalMines',
                style: TextStyle(
                  fontSize: height / 3,
                  color: Colors.black,
                ),
              )
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
              size: height / 2,
            ),
            onPressed: onRefresh,
          )
        ],
      ),
    );
  }
}
