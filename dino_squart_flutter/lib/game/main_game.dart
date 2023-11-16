import 'package:dino_squart_flutter/game/back_objects/ground.dart';
import 'package:dino_squart_flutter/game/back_objects/sky1.dart';
import 'package:dino_squart_flutter/game/manager/enemy_manager.dart';
import 'package:dino_squart_flutter/game/manager/game_manager.dart';
import 'package:dino_squart_flutter/game/player.dart';
import 'package:dino_squart_flutter/main_style.dart';
import 'package:flame/game.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../workout_ui/workout_page.dart';
import 'back_objects/sky2.dart';
import 'back_objects/sky3.dart';
class MainGame extends FlameGame with HasCollisionDetection{
  MainGame(this.context);
  late Player player;
  late Sky1 sky1;
  late Sky2 sky2;
  late Sky3 sky3;
  late Ground ground;
  EnemyManager enemyManager = EnemyManager();
  GameManager gameManager = GameManager();
  BuildContext context;
  @override
  Color backgroundColor() {

    return MyColors.sky;
  }


  @override
  Future<void> onLoad() async {
    player = Player();
    sky1 = Sky1();
    sky2 = Sky2();
    sky3 = Sky3();
    ground = Ground();
    add(player);
    add(enemyManager);
    add(gameManager);
    add(sky1);
    add(sky2);
    add(sky3);
    add(ground);
  }

  void update(double dt) {
    super.update(dt);

    // WorkoutInfo 클래스를 가져옴
    WorkoutInfo workoutInfo = Provider.of<WorkoutInfo>(context, listen: false);

    // 스쿼트 개수에 따라 캐릭터의 y 위치 조절
    double newYPosition = size.y - 20 - workoutInfo.squatCount * 20; // 스쿼트 개수에 따라 조절
    //player.position = Vector2(size.x * 0.25, newYPosition);
  }

}