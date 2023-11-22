import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameUI extends StatefulWidget {
  const GameUI({Key? key}) : super(key: key);

  @override
  State<GameUI> createState() => _GameUIState();
}

class _GameUIState extends State<GameUI> {

  @override
  Widget build(BuildContext context) {
    int score = (context.watch<WorkoutInfo>().score).toInt();
    //TODO 길이도 상태 조건에 포함시키기
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(score.toString(),style: MyTextStyles.game_ui_o2,),
                  Text('\n',style: MyTextStyles.game_ui_o2,),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
          ),
        ),
      ],
    );
  }
}
