import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:dino_squart_flutter/game/manager/enemy_manager.dart';
import 'package:dino_squart_flutter/game/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'manager/game_manager.dart';

class Enemy extends RectangleComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  static const enemySize = 48.0;
  double moveSpeed = 3;
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
    if (position.x > gameRef.size.x * 1) {
      // 화면 밖에 있을 경우
      position.x = position.x - moveSpeed;
    }
    else if (position.x > gameRef.size.x * -0.1 && position.x < gameRef.size.x * 1) {
      // 화면 안에 있을 경우
      // 배속 가능
      position.x = position.x - gameRef.enemyManager.getEnemySpeed();
    }
    else {
      position.x = position.x - moveSpeed;
    }
    if (position.x < gameRef.size.x * -0.5){
      removeFromParent();
    }
  }
}