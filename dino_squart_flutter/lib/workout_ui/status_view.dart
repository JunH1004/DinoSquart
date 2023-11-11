import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';



class YourWidget extends StatelessWidget {
  final int squatCount;
  final double avgLength;
  final double avgAngle;
  final double bodySize;

  YourWidget({
    required this.squatCount,
    required this.avgLength,
    required this.avgAngle,
    required this.bodySize,
  });

  @override
  Widget build(BuildContext context) {
    // 이 값을 UI에서 사용하세요.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('스쿼트 개수: $squatCount', style: TextStyle(fontSize: 64,color: Color.fromARGB(255, 255, 255, 255)),),
        Text('평균 각도: $avgAngle'),
        Text('체형 크기: $bodySize'),
        Text('발목,허리 길이: ${context.watch<WorkoutInfo>().atkLength}', style: TextStyle(fontSize: 64,color: Color.fromARGB(255, 255, 255, 255)),),
        Text('발목,무릎 길이: ${context.watch<WorkoutInfo>().athLength}', style: TextStyle(fontSize: 64,color: Color.fromARGB(255, 255, 255, 255)),),
        Text('비율:  ${context.watch<WorkoutInfo>().lengthPropotion}', style: TextStyle(fontSize: 64,color: Color.fromARGB(255, 255, 255, 255)),),

        
        // 필요에 따라 더 많은 위젯 추가
      ],
    );
  }
}
