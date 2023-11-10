import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';



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
            Text(
              'Leg\'s Length: ${workoutInfo.avg_Length}',
              style: TextStyle(fontSize: 24),
             ),
             Text(
              'knee angle: ${workoutInfo.avg_Angle}',
              style: TextStyle(fontSize: 24),
             ),
             Text
             (
              'Body_size: ${workoutInfo.body_size}',
              style: TextStyle(fontSize: 24),
             )
            // 다른 UI 요소들을 추가
          ],
        );
      },
    );
  }
}
