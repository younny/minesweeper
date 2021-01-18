import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/model/board.dart';

import '../game_client.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameClient gameClient;

  GameBloc({@required this.gameClient}) : super(GameInitial());

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is GameStarted) {
      final finalBoard = await gameClient.initGame();

      yield GameLoadingSuccess(board: finalBoard);
    } else if (event is GameFinished) {
      yield GameInitial();
    }
  }
}
