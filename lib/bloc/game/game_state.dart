part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameInitial extends GameState {}

class GameLoadingSuccess extends GameState {
  final Board board;

  const GameLoadingSuccess({@required this.board});

  @override
  List<Object> get props => [this.board];

  @override
  String toString() => 'GameLoadingSuccess{board: $board}';
}