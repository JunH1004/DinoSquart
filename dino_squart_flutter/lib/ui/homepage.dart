import 'package:camera/camera.dart';
import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/ui/homepage_content/dino_top_board.dart';
import 'package:dino_squart_flutter/ui/homepage_content/workout_setting_card.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'homepage_content/best_score_card.dart';

class HompageDataStore extends ChangeNotifier{
  int _workoutDifficulty = 0; //0,1,2
  void setWorkoutDifficulty(int n){
    _workoutDifficulty = n;
    notifyListeners();
  }
  int getWorkoutDifficulty(){
    return _workoutDifficulty;
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
                      BestScoreCard(),
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
                height: 100,
                width: double.infinity,
                child: const Center(child: Text("지금 바로 시작!",style: MyTextStyles.h1,))),
          ),
        ],
      ),
    );
  }
}
