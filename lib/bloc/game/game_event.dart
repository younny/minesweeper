part of 'game_bloc.dart';

abstract class GameEvent {
  const GameEvent();
}

class GameStarted extends GameEvent {}

class GameFinished extends GameEvent {}
