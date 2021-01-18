import 'package:meta/meta.dart';

class Board {
  final List grid;

  const Board({@required this.grid});

  @override
  String toString() {
    return '$grid';
  }
}
