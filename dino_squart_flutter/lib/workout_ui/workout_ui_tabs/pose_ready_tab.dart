import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadyTab extends StatefulWidget {
  const ReadyTab({Key? key}) : super(key: key);

  @override
  State<ReadyTab> createState() => _ReadyTabState();
}

class _ReadyTabState extends State<ReadyTab> {
  String displayText = "";

  @override
  Widget build(BuildContext context) {
    int readyTime = ((4000-context.watch<WorkoutInfo>().readyTime) *0.001 ).toInt();
    //TODO 길이도 상태 조건에 포함시키기
    if (context.watch<WorkoutInfo>().bodySize < 170000 && context.watch<WorkoutInfo>().bodySize >= 100000){
      displayText = "좋아요 유지!";
    }
    else if (context.watch<WorkoutInfo>().bodySize < 100000){
      displayText = "전신이 보이게\n서주세요!";
    }
    else{
      displayText = "너무 가까워요";
    }
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            color: MyColors.black.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(displayText,style: MyTextStyles.game_ui_h2,),

                  readyTime <= 3?
                  Text(readyTime.toString(),style: MyTextStyles.game_ui_h1,)
                  :
                  Text('',style: MyTextStyles.game_ui_h1,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
