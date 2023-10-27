import 'package:dino_squart_flutter/game/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Enemy extends RectangleComponent with HasGameRef, CollisionCallbacks {
  static const enemySize = 48.0;

  Enemy({
    super.position,
  }) : super(
    size: Vector2.all(enemySize),
    priority: 2,
    anchor: Anchor.bottomCenter,
  );
  @override
  Future<void> onLoad() async {
    super.onLoad();
    paint.color = Colors.yellow;
    position = Vector2(gameRef.size.x * 2, gameRef.size.y - 20);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x = position.x - 3;
    if (position.x < gameRef.size.x * -0.5){
      removeFromParent();
    }
  }

  // @override
  // bool onComponentTypeCheck(PositionComponent other) {
  //   if (other is Enemy) {
  //     return false;
  //   } else {
  //     return super.onComponentTypeCheck(other);
  //   }
  // }
  //
  // @override
  // void onCollisionStart(Set<Vector2> intersectionPoints,
  //     PositionComponent other,) {
  //   if (other is Player) {
  //     removeFromParent();
  //   } else {
  //     super.onCollisionStart(intersectionPoints, other);
  //   }
  // }
}