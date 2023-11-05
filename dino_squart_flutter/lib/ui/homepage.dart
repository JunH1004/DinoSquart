import 'package:camera/camera.dart';
import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/ui/homepage_content/calorie_chart_card.dart';
import 'package:dino_squart_flutter/ui/homepage_content/dino_top_board.dart';
import 'package:dino_squart_flutter/ui/homepage_content/workout_setting_card.dart';
import 'package:dino_squart_flutter/utility/util.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'homepage_content/best_score_card.dart';

class HompageDataStore extends ChangeNotifier{
  int _workoutDifficulty = 0; //0,1,2
  int _workoutTime = 0;
  void setWorkoutDifficulty(int n){
    _workoutDifficulty = n;
    notifyListeners();
  }
  int getWorkoutDifficulty(){
    return _workoutDifficulty;
  }
  int getCalPerHour(){
    return (_workoutDifficulty + 1) * 100;
  }
  int getCalByWorkoutTime(){
    return (getCalPerHour() * (getWorkoutTime() / 3600)).toInt();
  }

  void setWorkoutTime(int n){
    _workoutTime = n;
    notifyListeners();
  }
  int getWorkoutTime(){
    return _workoutTime;
  }
  String getWorkoutTimeText(){
    if (_workoutTime == 0){
      return '무제한';
    }
    return convertToTimeString(_workoutTime);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(backgroundColor : MyColors.white,title: Text("Dino Squat!",style: TextStyle(fontSize: 42,fontWeight: FontWeight.bold),),),
        body: Column(
          children: [
            Text("Dino Squat!",
          style: TextStyle(fontSize: 42,fontWeight: FontWeight.bold)),
            Flexible(
              flex: 2,
                child: DinoTopBoard()
            ),
            Flexible(
                flex: 8,
                child: MainContentBox()
            )
          ],
        ),
      ),
    );
  }
}

class MainContentBox extends StatelessWidget {
  const MainContentBox({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(64),
      decoration: MyCardStyles.outLinedGreyBoxStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BestScoreCard(),
                      WorkoutSettingCard(),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalorieCard(),
                      BestScoreCard(),
                    ],
                    //Calorie card
                    //업적 카드
                  ),
                )
              ],
            ),
          ),
          //btn
          Container(height: 50,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutPage()));
            },
            child: Container(
                decoration: MyCardStyles.outLinedBtnStyle,
                height: 120,
                width: double.infinity,
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("지금 바로 시작!",style: MyTextStyles.h1,),
                        RichText(text: TextSpan(
                          text: context.watch<HompageDataStore>().getWorkoutTime() == 0?
                          '목표 : ${context.watch<HompageDataStore>().getWorkoutTimeText()}, ${context.watch<HompageDataStore>().getCalPerHour()}'
                              :
                          '목표 : ${context.watch<HompageDataStore>().getWorkoutTimeText()}, ${context.watch<HompageDataStore>().getCalByWorkoutTime()}'
                            ,
                          style: MyTextStyles.h3,
                          children: <TextSpan>[
                            context.watch<HompageDataStore>().getWorkoutTime() == 0?
                            TextSpan(text: 'kcal/h',style: MyTextStyles.h4)
                                :
                            TextSpan(text: 'kcal',style: MyTextStyles.h4)
                          ]
                        ))
                      ]
                    ),
                ),
            )
          )
        ],
      ),
    );
  }
}
