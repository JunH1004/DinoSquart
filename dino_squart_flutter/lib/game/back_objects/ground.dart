import 'package:dino_squart_flutter/game/enemy.dart';
import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Ground extends SpriteComponent
    with HasGameRef<MainGame>
{
  final double moveSpeed = 3;



  Ground({
    super.position
  }) : super(
    size: Vector2(1280,64),
    anchor: Anchor.bottomLeft,
    priority: -8,
  ){
    var dinoImage = Flame.images.fromCache("Ground.png");
    this.sprite = Sprite(dinoImage);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(0, gameRef.size.y); //시작 위치
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x = position.x - moveSpeed;
    if (position.x < -1280 * 0.5) {
      position.x = 0;
    }
  }


}