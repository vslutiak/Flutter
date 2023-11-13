import 'package:auto_route/auto_route.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game_over.dart';
import 'main.dart';

@RoutePage()
class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Flame.device.setPortrait();
    Flame.device.fullScreen();
    return GameWidget(
      game: MyGame(),
      initialActiveOverlays: const [StartButton.id],
      overlayBuilderMap: {
        GameOverMenu.id: (BuildContext context, game) => GameOverMenu(
              game: game,
            ),
        StartButton.id: (BuildContext context, game) => StartButton(
              game: game,
            ),
      },
    );
  }
}
