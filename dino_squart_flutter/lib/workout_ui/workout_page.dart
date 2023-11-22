import 'dart:async';
import 'dart:math';

import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:dino_squart_flutter/workout_ui/game_ui.dart';
import 'package:dino_squart_flutter/workout_ui/workout_ui_tabs/pause_tab.dart';
import 'package:dino_squart_flutter/workout_ui/workout_ui_tabs/pose_ready_tab.dart';
import 'package:dino_squart_flutter/workout_ui/workout_ui_tabs/report_tab.dart';
import 'package:dino_squart_flutter/workout_ui/workout_ui_tabs/squat_tab.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main_style.dart';
import '../squat_ai/squat_counter.dart';
import '../utility/ui_utils.dart';
import '../vision_detector_views/detector_views.dart';
import 'package:flutter/src/material/progress_indicator.dart';
enum WorkoutPageState {Ready,Workout,Pause,Report}
SquatTab squatTab = SquatTab();
class WorkoutPageStateStore extends ChangeNotifier{
  WorkoutPageState state = WorkoutPageState.Ready;
  setPageState(WorkoutPageState s) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      state = s;
      print(state.index);
      notifyListeners();
    });
  }
  init(){
    state = WorkoutPageState.Ready;
  }
}
class WorkoutInfo extends ChangeNotifier{
    double squatLevel = 1.0; //0.0 ~ 1.0 1이 일어난거
    double minSquatLevel = 1;
    final double goodTopLine = 0.75;
    final double goodBottomLine = 0.10;
    final double perfectTopLine = 0.60;
    final double perfectBottomLine = 0.25;

    double score = 0;
    void setScroe(double d){
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        score = d;
        notifyListeners();
      });
    }
    void addScroe(double d){
        score += d;
        if(score < 0){
          score = 0;
        notifyListeners();
      }
    }
    bool isJump = false;
    void setIsJump(bool b){
      isJump = b;
      notifyListeners();
    }

    void resetMinSquatLevel(){
      minSquatLevel = 1;
      notifyListeners();
    }
    double bodySize = 0;
    double bodyHeight = 0;
    setBodyHeight(double d ){
      bodyHeight = d;
      notifyListeners();
    }
    setBodySize(double d ){
      bodySize = d;
      notifyListeners();
    }
    int readyTime  = 0;
    setReadyTime(int d){
      readyTime = d;
      notifyListeners();
    }
    int squatCount = 0;
    int _totalTimer = 0;
    int _totalAvoidCnt = 0;
    List<int> calories = [];

    //TODO GETTER SETTER 만들기
    addSquartCount(){
      squatCount += 1; //스쿼트 하면 초기화
      isJump = true;
      notifyListeners();

    }

    setSquatLevel(double d){
      squatLevel = d;
      if(minSquatLevel > squatLevel){
        minSquatLevel = squatLevel;
      }
      notifyListeners();
    }
}
//WorkoutInfo클래스 생성



class WorkoutPage extends StatefulWidget
{
  WorkoutPage({Key?key}) : super(key: key);
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}
//WorkoutPage 클래스 생성 main.dart의 GameboardState클래스에서 넘어오게 되는 함수 존재
class _WorkoutPageState extends State<WorkoutPage> 
{
  late SquatCounter squatCounter = SquatCounter(context);
  late MainGame mainGame;
  @override
  void initState(){
    super.initState();
    context.read<WorkoutPageStateStore>().init();
    context.read<WorkoutInfo>().squatCount = 0;
    mainGame = MainGame(context);
  }

  @override
  Widget build(BuildContext context) 
  {
    WorkoutPageState state = context.watch<WorkoutPageStateStore>().state;
    return WillPopScope(
      onWillPop: () 
      {
        return Future(() => false);
      },
      child: Material(
        child: Stack(
          children: [

            PoseDetectorView(squatCounter),
            Visibility(
              visible: state == WorkoutPageState.Workout,
              child: Positioned(
                top: 0,  // 이 부분을 조절하여 GameWidget의 상단 위치를 조정할 수 있습니다.
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,  // 화면 너비에 맞게 설정
                  height: MediaQuery.of(context).size.height / 2,  // 화면 높이의 절반으로 설정
                  child: GameWidget(game: mainGame),
                ),
              ),
            ),
            [ // 탭 리스트
              ReadyTab(),
              squatTab,
              PauseTab(),
              ReportTab(),
            ][context.watch<WorkoutPageStateStore>().state.index],
              GameUI(),
            
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: FloatingActionButton.small(onPressed:(){
                  confirmDiaglog(context,
                      'Are you sure to finish workout?', () {
                        Navigator.pop(context);
                      });
                },
                  elevation: 0,
                  backgroundColor: MyColors.white.withOpacity(1),child: Icon(Icons.arrow_back,color: MyColors.black,),),
              ),
            ),
            //game view on upper
          ],
        ),
      ),
    );
  }
}
