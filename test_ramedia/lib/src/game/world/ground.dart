import 'package:flame_forge2d/flame_forge2d.dart';

class Ground extends BodyComponent {
  final Vector2 gameSize;

  Ground(this.gameSize) : super(renderBody: false);

  @override
  Body createBody() {
    final Shape shape = EdgeShape()
      ..set(
        Vector2(0, gameSize.y * .86),
        Vector2(gameSize.x, gameSize.y * .86),
      );
    final BodyDef bodyDef = BodyDef(userData: this, position: Vector2.zero());
    return world.createBody(bodyDef);
  }
}

List<Wall> createBoundaries(Vector2 size, {double? strokeWidth}) {
  final topLeft = Vector2(0 - 0.5, 0 - 0.5);
  final topRight = Vector2(size.x - 0.5, 0 - 0.5);
  final bottomRight = Vector2(size.x - 0.5, size.y - 0.5);
  final bottomLeft = Vector2(0 - 0.5, size.y - 0.5);

  return [
    Wall(topLeft, topRight, strokeWidth: strokeWidth),
    Wall(topRight, bottomRight, strokeWidth: strokeWidth),
    Wall(bottomLeft, bottomRight, strokeWidth: strokeWidth),
    Wall(topLeft, bottomLeft, strokeWidth: strokeWidth),
  ];
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;
  final double strokeWidth;

  Wall(this.start, this.end, {double? strokeWidth}) : strokeWidth = strokeWidth ?? 0.5;

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(shape, friction: 100);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );
    paint.strokeWidth = strokeWidth;

    return world.createBody(bodyDef);
  }
}
