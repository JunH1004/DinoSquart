import 'package:dino_squart_flutter/game/player.dart';
import 'package:flame/game.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../workout_ui/workout_page.dart';
class MainGame extends FlameGame{
  MainGame(this.context);
  late Player player;
  BuildContext context;
  @override
  Future<void> onLoad() async {
    player = Player(
      position: Vector2(size.x * 0.25, size.y - 20),
    );
    add(player);
  }

  void update(double dt) {
    super.update(dt);

    // WorkoutInfo 클래스를 가져옴
    WorkoutInfo workoutInfo = Provider.of<WorkoutInfo>(context, listen: false);

    // 스쿼트 개수에 따라 캐릭터의 y 위치 조절
    double newYPosition = size.y - 20 - workoutInfo.squatCount * 20; // 스쿼트 개수에 따라 조절
    player.position = Vector2(size.x * 0.25, newYPosition);
  }

}