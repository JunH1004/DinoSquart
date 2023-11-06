import 'package:camera/camera.dart';
import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/ui/homepage_content/achievement_card.dart';
import 'package:dino_squart_flutter/ui/homepage_content/calorie_chart_card.dart';
import 'package:dino_squart_flutter/ui/homepage_content/dino_top_board.dart';
import 'package:dino_squart_flutter/ui/homepage_content/workout_setting_card.dart';
import 'package:dino_squart_flutter/utility/util.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'homepage_content/best_score_card.dart';

class HompageDataStore extends ChangeNotifier{
  int _workoutDifficulty = 0; //0,1,2 //유저가 선택한 운동 난이도
  int _workoutTime = 0; //유저의 목표 운동 시간, 0은 무제한
  int _totalWorkoutTime = 0; //총 운동 시간
  int _totalBurnCalorie = 0; //총 소모한 칼로리
  int _totalAvoidedObstacle = 0; //총 피한 장애물
  List<double> weeklyBrunCalories = [0,0,0,0,0,0,0];
  int _bestScore = 0;//최근 7일 소모 칼로리

  void init(){
    //실제 구현에서는 최근에 설정했던 난이도와 시간을 불러온다.
    _workoutTime = 0;
    _workoutDifficulty = 0;
  }
  void initTestValue(){
    //테스트용 값
    // TODO 실제 데이터 저장 및 불러오기
    _bestScore = 1004;
    _totalWorkoutTime = 218;
    _totalBurnCalorie = 1234;
    _totalAvoidedObstacle = 64;
    weeklyBrunCalories = [1,2,3,5,2,5,7];
  }

  int getSumWeeklyCalorie(){
    int sum = 0;
    for(int i = 0; i < 7; i++){
      sum += weeklyBrunCalories[i].toInt();
    }
    return sum;
  }
  int getBestScore(){
    return _bestScore;
  }
  bool isNewBestScore(int n){
    if (_bestScore < n) return true;

    return false;
  }
  void updateBestScore(int n){
    if (isNewBestScore(n)){
      _bestScore = n;
      notifyListeners();
    }
  }
  int get getTotalWorkoutTime => _totalWorkoutTime;
  set setTotalWorkoutTime(int value) => (){
    _totalWorkoutTime = value;
    notifyListeners();
  };
  String getTotalWorkoutTimeText(){
    return convertToTimeString(_totalWorkoutTime);
  }

  int get getTotalBurnCalorie => _totalBurnCalorie;
  set setTotalBurnCalorie(int value) => (){
    _totalBurnCalorie = value;
    notifyListeners();
  };

  int get getTotalAvoidedObstacle => _totalAvoidedObstacle;
  set setTotalAvoidedObstacle(int value) => (){
    _totalAvoidedObstacle = value;
    notifyListeners();
  };

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState(){
    context.read<HompageDataStore>().init();
    context.read<HompageDataStore>().initTestValue();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor : MyColors.white,title: Text("Dino Squat!",style: TextStyle(fontSize: 42,fontWeight: FontWeight.bold),),),
      body: Column(

        children: [
          Container(
            height: 100.h,
          ),
          Text("Dino Squat!",
        style: TextStyle(fontSize: 42.sp,fontWeight: FontWeight.bold)),
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
    );
  }
}

class MainContentBox extends StatelessWidget {
  const MainContentBox({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(32.w),
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
                      AchievementCard(),
                    ],
                    //Calorie card
                    //업적 카드
                  ),
                )
              ],
            ),
          ),
          //btn
          Container(height: 32.h,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutPage()));
            },
            child: Container(
                decoration: MyCardStyles.outLinedBtnStyle,
                height: 120.h,
                width: double.infinity,
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("게임 시작!",style: MyTextStyles.h1_w,),
                        RichText(text: TextSpan(
                          text: context.watch<HompageDataStore>().getWorkoutTime() == 0?
                          '목표 : ${context.watch<HompageDataStore>().getWorkoutTimeText()}, ${context.watch<HompageDataStore>().getCalPerHour()}'
                              :
                          '목표 : ${context.watch<HompageDataStore>().getWorkoutTimeText()}, ${context.watch<HompageDataStore>().getCalByWorkoutTime()}'
                            ,
                          style: MyTextStyles.h3_w,
                          children: <TextSpan>[
                            context.watch<HompageDataStore>().getWorkoutTime() == 0?
                            TextSpan(text: 'kcal/h',style: MyTextStyles.h4_w)
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
