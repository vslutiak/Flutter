import 'dart:async' as time;
import 'dart:math';

import 'package:flame/components.dart' as comp;
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:test_ramedia/src/game/actors/enemy.dart';

import 'actors/player.dart';
import 'world/ground.dart';

class MyGame extends Forge2DGame with ContactCallbacks, PanDetector {
  MyGame() : super(gravity: Vector2(0, 100.0));

  late time.Timer timer;
  late time.Timer gameTimer;
  late Player player;

  @override
  onPanUpdate(DragUpdateInfo info) {
    player.handlePanUpdate(info);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    const touchCountTextStyle = TextStyle(color: Colors.white, fontSize: 20);
    final touchCountTextSpan = TextSpan(text: 'Coins: $coin', style: touchCountTextStyle);
    final touchCountTextPainter = TextPainter(
      text: touchCountTextSpan,
      textDirection: TextDirection.ltr,
    );
    touchCountTextPainter.layout();
    touchCountTextPainter.paint(canvas, Offset(size.x / 2 - touchCountTextPainter.width / 2, 50));
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(
      comp.SpriteComponent(sprite: await loadSprite('background.png'), size: size),
    );
    final boundaries = createBoundaries(size);
    add(Ground(size));
    player = Player(gameSize: size);
    add(player);
    addAll(boundaries);
  }

  void startGame() {
    timer = time.Timer.periodic(const Duration(seconds: 1), (timer) {
      addEnemy(Random().nextDouble() * size.x, -Random().nextDouble() * size.y);
    });
    gameTimer = time.Timer.periodic(const Duration(seconds: 2), (timer) {
      addCoin(Random().nextDouble() * size.x, -Random().nextDouble() * size.y);
    });
  }

  void addEnemy(double x, double y) async {
    final enemy = Enemy(Vector2(x, y), await loadSprite('enemy.png'));
    add(enemy);
  }

  void addCoin(double x, double y) async {
    final coins = Coin(Vector2(x, y), await loadSprite('coin.png'));
    add(coins);
  }

  void restart() {
    coin = 0;
    remove(player);

    for (var child in children) {
      if (child is Enemy || child is Coin) {
        remove(child);
      }
    }

    player = Player(gameSize: size);
    add(player);
    timer.cancel();
    gameTimer.cancel();
    startGame();
  }
}
