import 'package:dino_squart_flutter/game/enemy.dart';
import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Player extends SpriteComponent
    with HasGameRef<MainGame>, CollisionCallbacks,TapCallbacks
{
  static const playerSize = 128.0;


  //물리엔진
  Vector2 _velocity = Vector2.zero();
  final double _gravity = 1;
  final double jumpForce = 20;
  double groundYPos = 10.h;
  bool isGround = false;


  Player({
    super.position
  }) : super(
    size: Vector2.all(playerSize),
    anchor: Anchor.bottomCenter,
    priority: 10,
  ){
    var dinoImage = Flame.images.fromCache("greenDino.png");
    this.sprite = Sprite(dinoImage);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(size.x / 2 + 20, gameRef.size.y - 20.h); //시작 위치
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    gravitySystem();
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    jump();
  }

  void jump(){
    print("jump");
    _velocity.y = -jumpForce;
    position += _velocity;
    gameRef.enemyManager.setEnemySpeed(10);
  }

  void whenDamaged() {
    print("damaged!");
  }

  void gravitySystem(){
    if (position.y < gameRef.size.y - groundYPos){
      _velocity.y += _gravity;
      position += _velocity;
    }
    else{
      gameRef.enemyManager.setInitEnemySpeed();
      position.y = gameRef.size.y - groundYPos;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    if (other is Enemy) {
      whenDamaged();
    }
  }
}