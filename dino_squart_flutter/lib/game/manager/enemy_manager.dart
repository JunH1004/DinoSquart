import 'package:dino_squart_flutter/game/enemy.dart';
import 'package:dino_squart_flutter/game/enemy_fly.dart';
import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:dino_squart_flutter/game/manager/game_manager.dart';
import 'package:flame/components.dart';
import 'dart:math';

class EnemyManager extends Component with HasGameRef<MainGame>{
  final double _initEnemySpeed = 3;
  double _enemySpeed = 3;
  final List<Enemy> _enemies = [];
  List<int> _enemies_pattern = [1, 1, 1, 1, 1, 1, 1];
  //패턴 설정. 0 : 아무것도 아님. 1 : 지상. 2 : 공중 적
  double timer = 0;

  @override
  void update(double dt) {
    timer += dt;
    //print("Timer: $timer"); // Add some text to the print statement for clarity

    super.update(dt);
    if (timer > 2){
      if(_enemies_pattern[0] == 0) {
        print("nothing");
      }
      else if(_enemies_pattern[0] == 1) {
        final Enemy enemy1 = Enemy();
        add(enemy1);
      }
      else if(_enemies_pattern[0] == 2) {
        final Enemy_fly enemy1 = Enemy_fly();
        add(enemy1);
      }
      print(_enemies_pattern[0]);
      _enemies_pattern.removeAt(0);
      _enemies_pattern.add(addPattern());
      timer = 0;
    }

  }

  int addPattern() {
    return Random().nextInt(3);
  }

  void setEnemySpeed(double d){
    _enemySpeed = d;
  }
  void setInitEnemySpeed(){
    _enemySpeed = _initEnemySpeed;
  }
  double getEnemySpeed(){
    return _enemySpeed;
  }
}
