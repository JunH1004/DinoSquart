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
import 'back_objects/clouds.dart';
import 'back_objects/sky2.dart';
import 'back_objects/sky3.dart';
class MainGame extends FlameGame with HasCollisionDetection{
  MainGame(this.context);
  late Player player;
  late Sky1 sky1;
  late Sky2 sky2;
  late Sky3 sky3;
  late Ground ground;
  late Cloud cloud;
  double score = 0;
  double timer = 0;
  EnemyManager enemyManager = EnemyManager();
  GameManager gameManager = GameManager();


  int lastSquatCnt = 0;
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
    cloud = Cloud();
    ground = Ground();
    add(player);
    add(enemyManager);
    add(gameManager);
    add(sky1);
    add(sky2);
    add(sky3);
    add(ground);
    add(cloud);
    int squatCnt = context.read<WorkoutInfo>().squatCount;
    lastSquatCnt = squatCnt;
  }

  void update(double dt) {
    if (context.read<WorkoutPageStateStore>().state != WorkoutPageState.Workout){
      return;
    }
    super.update(dt);
    timer += dt;
    if (timer > enemyManager.goalTime && enemyManager.isLimitedGame){
      //gameclear
      print("game clear");
      enemyManager.setGameSpeed(0);
      context.read<WorkoutPageStateStore>().setPageState(WorkoutPageState.Report);
    }

    score = timer * 5;
    context.read<WorkoutInfo>().setScroe(score);
    int squatCnt = context.read<WorkoutInfo>().squatCount;
    if (lastSquatCnt != squatCnt){
      lastSquatCnt = squatCnt;
      
      //점프가 스쿼트에 가동범위에 따라 강해짐
      double booster = 1;
      context.read<WorkoutInfo>().minSquatLevel;
      if (context.read<WorkoutInfo>().minSquatLevel <= 0.25){
        booster = 1.3;
      }
      player.jump(booster);
    }
  }

}