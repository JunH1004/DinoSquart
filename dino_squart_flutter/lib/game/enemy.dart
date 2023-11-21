import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:dino_squart_flutter/game/manager/enemy_manager.dart';
import 'package:dino_squart_flutter/game/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';

import 'manager/game_manager.dart';

var enemySize = 32.w;
class Enemy extends PositionComponent
    with HasGameRef<MainGame>, CollisionCallbacks, DragCallbacks {

  late final EnemyComponent _enemyComponent;
  double moveSpeed = 5.w;
  var initPos;
  Enemy(this.initPos) : super(
    size: Vector2.all(enemySize),
    priority: 9,
    anchor: Anchor.bottomLeft,
  ){
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
    position = Vector2(gameRef.size.x + initPos, gameRef.size.y - 120.h);
    add(RectangleHitbox());

  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x = position.x - moveSpeed * gameRef.enemyManager.getGameSpeed();
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