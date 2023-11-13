import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:test_ramedia/src/game/actors/enemy.dart';

import '../game_over.dart';

bool isTapped = false;

class Player extends BodyComponent with TapCallbacks, ContactCallbacks {
  Vector2? lastPosition;

  Player({required this.gameSize});

  late AudioPool launchSfx;
  late AudioPool flyingSfx;
  late Sprite cloudSprite;
  final Vector2 gameSize;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    launchSfx = await AudioPool.create('audio/sfx/destroyed.mp3', maxPlayers: 1);
    cloudSprite = await game.loadSprite('cloud.webp');

    renderBody = false;
    add(
      SpriteComponent()
        ..sprite = await game.loadSprite('player.png')
        ..size = Vector2.all(50)
        ..anchor = Anchor.center,
    );
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('spaceship.mp3', volume: 0.1);
  }

  @override
  Body createBody() {
    final shape = PolygonShape(); // Используем PolygonShape для треугольника
    final vertices = [
      Vector2(-20, 20),
      Vector2(20, 20),
      Vector2(0, -20),
    ];
    shape.set(vertices);
    final BodyDef bodyDef = BodyDef(
      userData: this,
      position: Vector2((gameSize.x / 2) + 5, (gameSize.y * .86) - 5),
      type: BodyType.static,
    );
    final FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 0.01);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) async {
    if (other is Enemy) {
      launchSfx.start();
      FlameAudio.bgm.stop();

      add(
        SpriteComponent()
          ..sprite = cloudSprite
          ..anchor = Anchor.center
          ..size = Vector2.all(41),
      );

      game.overlays.add(GameOverMenu.id);
    }
  }

  void handlePanUpdate(DragUpdateInfo details) {
    final newPosition = position + Vector2(details.delta!.global.x, 0);
    body.setTransform(newPosition, body.angle);
    lastPosition = newPosition;
  }

  void handlePanEnd(DragEndDetails details) {
    isTapped = false;
  }
}
