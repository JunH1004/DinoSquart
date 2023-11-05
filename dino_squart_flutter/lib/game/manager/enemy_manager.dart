import 'package:dino_squart_flutter/game/enemy.dart';
import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:dino_squart_flutter/game/manager/game_manager.dart';
import 'package:flame/components.dart';

class EnemyManager extends Component with HasGameRef<MainGame>{
  final double _initEnemySpeed = 3;
  double _enemySpeed = 3;
  final List<Enemy> _enemies = [];
  double timer = 0;

  @override
  void update(double dt) {
    timer += dt;
    //print("Timer: $timer"); // Add some text to the print statement for clarity
    super.update(dt);
    if (timer > 5){
      final Enemy enemy1 = Enemy();
      add(enemy1);
      timer = 0;
    }

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
