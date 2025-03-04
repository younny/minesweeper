import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper/bloc/game/game_bloc.dart';
import 'package:minesweeper/widget/game_board.dart';

class GamePage extends StatefulWidget {
  GamePage({Key key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameBloc _gameBloc;

  @override
  void didChangeDependencies() {
    _gameBloc = context.read<GameBloc>();
    _gameBloc.add(GameStarted());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Minesweeper")),
      body: BlocBuilder<GameBloc, GameState>(
          buildWhen: (previous, state) => previous.runtimeType == GameInitial,
          builder: (context, state) {
            switch (state.runtimeType) {
              case GameLoadingSuccess:
                final board = (state as GameLoadingSuccess).board;
                return GameBoard(
                  row: _gameBloc.gameClient.row,
                  totalMines: _gameBloc.gameClient.totalMines,
                  board: board,
                  restart: _onRestart,
                );
              default:
                return Container();
            }
          }),
    );
  }

  _onRestart() {
    _gameBloc.add(GameFinished());

    _gameBloc.add(GameStarted());
  }
}
