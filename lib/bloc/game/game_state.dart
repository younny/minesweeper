part of 'game_bloc.dart';

abstract class GameState {
  const GameState();
}

class GameInitial extends GameState {}

class GameLoadingSuccess extends GameState {
  final List board;

  const GameLoadingSuccess({@required this.board});

  @override
  String toString() => 'GameLoadingSuccess{board: $board}';
}