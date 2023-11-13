import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import 'player.dart';

int coin = 0;

class Coin extends BodyComponent with ContactCallbacks {
  @override
  final Vector2 position;
  final Sprite sprite;
  late Sprite cloudSprite;
  late final AudioPool destroyedSfx;

  Coin(this.position, this.sprite);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    add(
      SpriteComponent()
        ..sprite = sprite
        ..anchor = Anchor.center
        ..size = Vector2.all(20),
    );
    cloudSprite = await game.loadSprite('cloud.webp');
    destroyedSfx = await AudioPool.create('audio/sfx/coin.mp4', maxPlayers: 1);
  }

  @override
  Body createBody() {
    final shape = CircleShape();
    shape.radius = 20;
    final FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3);
    final BodyDef bodyDef = BodyDef(userData: this, position: position, type: BodyType.dynamic);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) async {
    if (other is Player) {
      coin = coin + Random().nextInt(100);
      destroyedSfx.start();
      removeFromParent();
    }
  }
}

class Enemy extends BodyComponent with ContactCallbacks {
  final Sprite sprite;
  final BodyType bodyType;
  final Vector2 _position;

  Enemy(
    this._position,
    this.sprite, {
    this.bodyType = BodyType.dynamic,
    Color? color,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    add(
      SpriteComponent()
        ..sprite = sprite
        ..anchor = Anchor.center
        ..size = Vector2.all(25),
    );
  }

  @override
  Body createBody() {
    final shape = CircleShape();
    shape.radius = 20;

    final fixtureDef = FixtureDef(
      shape,
      restitution: 0.8,
      friction: 0.4,
    );

    final bodyDef = BodyDef(
      userData: this,
      angularDamping: 0.8,
      position: _position,
      type: bodyType,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
