import 'package:flutter/material.dart';

// This class represents the game over menu overlay.
class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  final game;

  const GameOverMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pause menu title.
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Game Over',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),

          // Restart button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                game.overlays.remove(GameOverMenu.id);
                game.restart();
                game.resumeEngine();
              },
              child: const Text('Restart'),
            ),
          ),
        ],
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  static const String id = 'StartButton';
  final game;

  const StartButton({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: ElevatedButton(
          onPressed: () {
            game.overlays.remove(StartButton.id);
            game.startGame();
            game.resumeEngine();
          },
          child: const Text('Start'),
        ),
      ),
    );
  }
}
