import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper/bloc/game/game_bloc.dart';
import 'package:minesweeper/bloc/game/game_bloc_observer.dart';
import 'package:minesweeper/screen/game_page.dart';
import 'package:provider/provider.dart';

import 'bloc/game_client.dart';

void main() {
  Bloc.observer = GameBlocObserver();
  runApp(MinesweeperApp());
}

class MinesweeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minesweeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Provider(
        create: (context) => GameClient(
          totalMines: 10,
          row: 10,
          col: 10
        ),
        child: BlocProvider<GameBloc>(
          create: (context) => GameBloc(
            gameClient: context.read<GameClient>()
          ),
          child: GamePage(),
        ),
      )
    );
  }
}
