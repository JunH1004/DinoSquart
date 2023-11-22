import 'package:dino_squart_flutter/game/enemy.dart';
import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
enum PlayerState { run, jump}
double playerSize = 200.0.w ;
class Player extends PositionComponent
    with HasGameRef<MainGame>, CollisionCallbacks,TapCallbacks
{
  late final PlayerComponent _playerComponent;


  //물리엔진
  Vector2 _velocity = Vector2.zero();
  final double _gravity = 1;
  final double jumpForce = 20;
  double groundYPos = 80.h;
  bool isGround = true;


  Player({
    super.position
  }) : super(
    size: Vector2.all(playerSize),
    anchor: Anchor.bottomCenter,
    priority: 10,
  ){
    var dinoImage = Flame.images.fromCache("DinoFull.png");

    List<Sprite> spritesRun = [
      Sprite(dinoImage,srcPosition: Vector2(0,144.5),srcSize: Vector2(143,144)),
      Sprite(dinoImage,srcPosition: Vector2(144,144.5),srcSize: Vector2(143,144)),
      Sprite(dinoImage,srcPosition: Vector2(288,144.5),srcSize: Vector2(143,144)),
      Sprite(dinoImage,srcPosition: Vector2(432,144.5),srcSize: Vector2(143,144)),
    ];

    List<Sprite> spritesJump= [
      Sprite(dinoImage,srcPosition: Vector2(144*5,144.5),srcSize: Vector2(143,144)),
    ];

    var animationRun = SpriteAnimation.spriteList(spritesRun, stepTime: 0.1);
    var animationJump = SpriteAnimation.spriteList(spritesJump, stepTime: 1);
    _playerComponent = PlayerComponent<PlayerState>({
      PlayerState.run : animationRun,
      PlayerState.jump : animationJump,
    }
    );
    _playerComponent.current = PlayerState.run;
    add(_playerComponent);
  }

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
    jump(1.3);
  }

  void jump(double booster){
    gameRef.enemyManager.timer = 0;
    if (_playerComponent.current == PlayerState.jump){
      return;
    }
    print("jump");
    _velocity.y = -jumpForce * booster;
    position += _velocity;
    gameRef.enemyManager.setGameSpeed(4);
    _playerComponent.current = PlayerState.jump;
    isGround = false;
  }

  void whenDamaged() {
    print("damaged!");
    if(gameRef.enemyManager.isLimitedGame){
      gameRef.enemyManager.setGameSpeed(0);
      gameRef.context.read<WorkoutInfo>().isGameOver = true;
      gameRef.context.read<WorkoutPageStateStore>().setPageState(WorkoutPageState.Report);
    }
  }

  void gravitySystem(){
    if (position.y < gameRef.size.y - groundYPos){
      _velocity.y += _gravity;
      position += _velocity;
    }
    else{
      gameRef.enemyManager.setInitGameSpeed();
      position.y = gameRef.size.y - groundYPos;
      _playerComponent.current = PlayerState.run;
      isGround = true;
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
  void playerUpdate(PlayerState playerState) {
    _playerComponent.playerUpdate(playerState);
  }
}

class PlayerComponent<T> extends SpriteAnimationGroupComponent<T> {
  PlayerComponent(Map<T, SpriteAnimation> playerAnimationMap)
      : super(size: Vector2(playerSize, playerSize), animations: playerAnimationMap);

  @override
  void update(double dt) {
    super.update(dt);
  }

  void playerUpdate(PlayerState playerState) {
    this.current = playerState as T?;
  }
}