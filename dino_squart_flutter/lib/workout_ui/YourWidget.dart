import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart'; // 이곳에 해당 Dart 파일의 경로를 넣어주세요.



class YourWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutInfo>(
      builder: (context, workoutInfo, child) {
        return Column(
          children: [
            Text(
              'Squat Count: ${workoutInfo.squatCount}',
              style: TextStyle(fontSize: 24),
            ),
            // 다른 UI 요소들을 추가할 수 있습니다.
          ],
        );
      },
    );
  }
}
