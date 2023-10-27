import 'package:dino_squart_flutter/game/enemy.dart';
import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class Player extends RectangleComponent
    with HasGameRef<MainGame>, CollisionCallbacks,TapCallbacks
{
  static const playerSize = 96.0;

  //물리엔진
  Vector2 _velocity = Vector2.zero();
  final double _gravity = 1;
  final double jumpForce = 20;

  final double groundYPos = 20;

  bool isGround = false;
  Player({
    super.position
  }) : super(
    size: Vector2.all(playerSize),
    anchor: Anchor.bottomCenter,
    priority: 1,
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(size.x / 2 + 20, gameRef.size.y - groundYPos); //시작 위치
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

  void whenDamaged(){
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