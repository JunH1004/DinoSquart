import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:dino_squart_flutter/workout_ui/status_view.dart';
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
enum WorkoutPageState {Ready,Stand,Workout,Pause,Report}

class WorkoutPageStateStore extends ChangeNotifier
{
  WorkoutPageState state = WorkoutPageState.Workout;
  setPageState(WorkoutPageState s)
  {
    state = s;
    notifyListeners();
  }
  init()
  {
    state = WorkoutPageState.Workout;
  }
}

//WorkoutPageStateStore클래스 생성 
class WorkoutInfo extends ChangeNotifier
{
    int squatCount = 0;
    double avg_Length=0;
    double avg_Angle=0;
    double body_size=0;
    double atkLength=0;
    double athLength=0;
    double lengthPropotion=0;
    void setATH(double d){
      athLength=d;
      notifyListeners();
    }
    void setATK(double d){
      atkLength = d;
      notifyListeners();
    }
    void setPropotion(double d){
      lengthPropotion=d;
      notifyListeners();
    }
    addSquartCount()
    {
      squatCount += 1;
      notifyListeners();
    }
    //스쿼트 카운트 
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

  @override
  Widget build(BuildContext context) 
  {
    return WillPopScope(
      onWillPop: () 
      {
        return Future(() => false);
      },
      child: Material(
        child: Stack(
          children: [
            PoseDetectorView(squatCounter),

            Positioned(
              top: 0,  // 이 부분을 조절하여 GameWidget의 상단 위치를 조정할 수 있습니다.
              child: SizedBox(
                width: MediaQuery.of(context).size.width,  // 화면 너비에 맞게 설정
                height: MediaQuery.of(context).size.height / 2,  // 화면 높이의 절반으로 설정
                child: GameWidget(game: MainGame(context)),
              ),
            ),
            Positioned(
              bottom: 16, // 화면 하단에서의 여백 조절
              left: 16,   // 화면 왼쪽에서의 여백 조절
              child: Consumer<WorkoutInfo>(builder:( context,workoutInfo, child)
              {
                return YourWidget
                (
                  squatCount: workoutInfo.squatCount,
                  avgLength: workoutInfo.avg_Length,
                  avgAngle: workoutInfo.avg_Angle,
                  bodySize: workoutInfo.body_size,
                );
              }, // YourWidget 추가(스쿼트 개수 출력)
              ),
            ),
            //game view on upper
          ],
        ),
      ),
    );
  }
}
