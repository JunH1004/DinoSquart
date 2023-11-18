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
    if (context.watch<WorkoutInfo>().bodySize < 200000){
      displayText = "전신이 보이게 서주세요";
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
                  Text(displayText,style: MyTextStyles.h1_w,),
                  Text((context.watch<WorkoutInfo>().bodySize * 0.001).toInt().toString(),style: MyTextStyles.h1_w,),

                  readyTime <= 3?
                  Text(readyTime.toString(),style: MyTextStyles.h1_w,)
                  :
                  Text('',style: MyTextStyles.h1_w,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
