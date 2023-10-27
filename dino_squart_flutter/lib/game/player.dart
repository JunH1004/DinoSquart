import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Player extends RectangleComponent with HasGameRef, CollisionCallbacks{
  static const playerSize = 96.0;
  bool isGround = true;
  Player({
    super.position
  }) : super(
    size: Vector2.all(playerSize),
    anchor: Anchor.bottomCenter,
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(size.x / 2 + 20, gameRef.size.y - 20);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void jump(){
    if (!isGround) return;

  }

  void whenDamaged(){

  }
}