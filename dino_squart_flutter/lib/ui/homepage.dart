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
import 'package:shared_preferences/shared_preferences.dart';
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
  Future<void> initTestValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Fetch values from SharedPreferences, or use default values if not found
    _bestScore = prefs.getInt('bestScore') ?? 0;
    _totalWorkoutTime = prefs.getInt('totalWorkoutTime') ?? 0;
    _totalBurnCalorie = prefs.getInt('totalBurnCalorie') ?? 0;
    _totalAvoidedObstacle = prefs.getInt('totalAvoidedObstacle') ?? 0;
    weeklyBrunCalories = prefs.getStringList('weeklyBurnCalories')?.map((e) => double.parse(e))?.toList() ?? [0,0,0,0,0,0,0];

    notifyListeners();
  }

  int get getBestScore => _bestScore;

  int get getTotalWorkoutTime => _totalWorkoutTime;

  int get getTotalBurnCalorie => _totalBurnCalorie;

  int get getTotalAvoidedObstacle => _totalAvoidedObstacle;

  List<double> get getWeeklyBrunCalories => weeklyBrunCalories;

  void setTotalWorkoutTime(int value)  {
    _totalWorkoutTime = value;
    notifyListeners();
     _saveToSharedPreferences('totalWorkoutTime', value);
  }

  void setTotalBurnCalorie(int value)  {
    _totalBurnCalorie = value;
    notifyListeners();
     _saveToSharedPreferences('totalBurnCalorie', value);
  }

  void setTotalAvoidedObstacle(int value)  {
    _totalAvoidedObstacle = value;
    notifyListeners();
     _saveToSharedPreferences('totalAvoidedObstacle', value);
  }
  void addTotalWorkoutTime(int value)  {
    _totalWorkoutTime += value;
    notifyListeners();
    _saveToSharedPreferences('totalWorkoutTime', value);
  }

  void addTotalBurnCalorie(int value)  {
    _totalBurnCalorie += value;
    notifyListeners();
    _saveToSharedPreferences('totalBurnCalorie', value);
  }

  void addTotalAvoidedObstacle(int value)  {
    _totalAvoidedObstacle += value;
    notifyListeners();
    _saveToSharedPreferences('totalAvoidedObstacle', value);
  }

  void setWeeklyBrunCalories(List<double> values) {
    weeklyBrunCalories = values;
    notifyListeners();
    _saveToSharedPreferences('weeklyBurnCalories', values.map((e) => e.toString()).toList());
  }
  void addWeeklyBurnCalories(double d){
    weeklyBrunCalories.removeAt(0);
    weeklyBrunCalories.add(d);
    _saveToSharedPreferences('weeklyBurnCalories', weeklyBrunCalories.map((e) => e.toString()).toList());
  }


  // ... (existing code)

  // Helper method to save values to SharedPreferences
  Future<void> _saveToSharedPreferences(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  int getSumWeeklyCalorie(){
    int sum = 0;
    for(int i = 0; i < 7; i++){
      sum += weeklyBrunCalories[i].toInt();
    }
    return sum;
  }

  bool isNewBestScore(int n){
    if (_bestScore < n) return true;

    return false;
  }
  void updateBestScore(int n){
    if (isNewBestScore(n)){
      _bestScore = n;
      _saveToSharedPreferences('bestScore', _bestScore);
      notifyListeners();
    }
  }
  String getTotalWorkoutTimeText(){
    return convertToTimeString(_totalWorkoutTime);
  }

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
