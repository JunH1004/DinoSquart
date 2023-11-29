import 'package:dino_squart_flutter/game/enemy.dart';
import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:dino_squart_flutter/game/manager/game_manager.dart';
import 'package:dino_squart_flutter/ui/homepage.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';
import 'package:flame/components.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';


class EnemyManager extends Component with HasGameRef<MainGame>{
  double _initGameSpeed = 1.2;
  double _gameSpeed = 1.2;
  List<int> _enemies_pattern = [1,0,0];
  double timer = 0;
  bool isLimitedGame = false;
  int goalTime = 0;
  int goalCal = 0;
  double enemySpawnTime = 2;
  @override
  Future<void> onLoad() async {
    goalTime = gameRef.context.read<HompageDataStore>().getWorkoutTime();
    goalCal = gameRef.context.read<HompageDataStore>().getWorkoutDifficulty(); // 1 2 3
    if (goalTime == 0){
      isLimitedGame = false;
    }
    else {
      isLimitedGame = true;
    }
    print('isLimitedGame $isLimitedGame');

    if(goalCal == 0){
      enemySpawnTime = 4;
    }
    else if(goalCal == 1){
      enemySpawnTime = 3.5;
    }
    else{ //goalCal == 2
      enemySpawnTime = 3;
    }

  }
  @override
  void update(double dt) {
    if(gameRef.player.isGround == false){
      return;
    }
    if (gameRef.context.read<WorkoutPageStateStore>().state == WorkoutPageState.Workout)
      timer += dt;
    //print("Timer: $timer"); // Add some text to the print statement for clarity
    super.update(dt);
    if (timer > enemySpawnTime) { // 3 2 1
      spawnEnemy();
    }
  }
  void spawnEnemy(){
    if(_enemies_pattern[0] == 0) {
      print("nothing");
    }
    else if(_enemies_pattern[0] == 1) {
      final Enemy enemy1 = Enemy(0);
      add(enemy1);
    }
    else if(_enemies_pattern[0] == 2) {
      final Enemy enemy1 = Enemy(0);
      final Enemy enemy2 = Enemy(48.w);
      add(enemy1);
      add(enemy2);
    }
    else if(_enemies_pattern[0] == 3) {
      final Enemy enemy1 = Enemy(0);
      final Enemy enemy2 = Enemy(48.w);
      final Enemy enemy3 = Enemy(96.w);
      add(enemy1);
      add(enemy2);
      add(enemy3);

    }
    print(_enemies_pattern[0]);
    _enemies_pattern.removeAt(0);
    timer = 0;
    _enemies_pattern.add(addPattern());
  }
  int addPattern() {
    int rest = Random().nextInt(100);
    print('rest $rest');
    if (rest < 1000) {
      //80퍼 확률로 장애물
      return Random().nextInt(2) + 1;
    }
    //20퍼 확률로 휴식
    return 0;

  }

  void setGameSpeed(double d){
    _gameSpeed = d;
  }
  void setInitGameSpeed(){
    _gameSpeed = _initGameSpeed;
  }
  double getGameSpeed(){
    return _gameSpeed;
  }
}
