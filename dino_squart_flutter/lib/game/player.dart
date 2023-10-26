import 'package:flame/components.dart';

class Player extends RectangleComponent {
  static const playerSize = 96.0;
  Player({required position})
      : super(
    position: position,
    size: Vector2.all(playerSize),
    anchor: Anchor.bottomCenter,
  );
}