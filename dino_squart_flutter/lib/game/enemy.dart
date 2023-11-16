import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:dino_squart_flutter/game/manager/enemy_manager.dart';
import 'package:dino_squart_flutter/game/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'manager/game_manager.dart';

const enemySize = 16.0;
class Enemy extends PositionComponent
    with HasGameRef<MainGame>, CollisionCallbacks, DragCallbacks {

  late final EnemyComponent _enemyComponent;
  double moveSpeed = 3;

  Enemy({
    super.position,
  }) : super(
    size: Vector2.all(enemySize),
    priority: 2,
    anchor: Anchor.bottomCenter,
  ){
    var TreeImage = Flame.images.fromCache("Tree.png");
    var TreeImage1 = Flame.images.fromCache("Tree_up.png");
    var TreeImage2 = Flame.images.fromCache("Tree_down.png");

    List<Sprite> TreeAnim = [
      Sprite(TreeImage1),
      Sprite(TreeImage2),
    ];

    var animatedTreeImage = SpriteAnimation.spriteList(TreeAnim, stepTime: 0.3);
    _enemyComponent = EnemyComponent(animatedTreeImage);
    add(_enemyComponent);


  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    //paint.color = Colors.yellow;
    position = Vector2(gameRef.size.x * 2, gameRef.size.y - 80);
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

class EnemyComponent extends SpriteAnimationComponent {
  EnemyComponent(SpriteAnimation playerAnimationMap)
      : super(size: Vector2(3,4) * enemySize, animation: playerAnimationMap);
  @override
  void update(double dt){
    super.update(dt);
  }
}