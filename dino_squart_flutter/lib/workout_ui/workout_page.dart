import 'package:dino_squart_flutter/game/main_game.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main_style.dart';
import '../squat_ai/squat_counter.dart';
import '../utility/ui_utils.dart';
import '../vision_detector_views/detector_views.dart';
import 'package:flutter/src/material/progress_indicator.dart';
enum WorkoutPageState {Ready,Stand,Workout,Pause,Report}

class WorkoutPageStateStore extends ChangeNotifier{
  WorkoutPageState state = WorkoutPageState.Workout;
  setPageState(WorkoutPageState s) {
    state = s;
    notifyListeners();
  }
  init(){
    state = WorkoutPageState.Workout;
  }
}
class WorkoutInfo extends ChangeNotifier{
    int squatCount = 0;

    addSquartCount(){
      squatCount += 1;
      notifyListeners();
    }
}



class WorkoutPage extends StatefulWidget {
  WorkoutPage({Key?key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late SquatCounter squatCounter = SquatCounter(context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Material(
        child: Stack(
          children: [
            //PoseDetectorView(squartCounter),
            Container(
              color: MyColors.deepGreen,
            ),
            Positioned(
              top: 0,  // 이 부분을 조절하여 GameWidget의 상단 위치를 조정할 수 있습니다.
              child: SizedBox(
                width: MediaQuery.of(context).size.width,  // 화면 너비에 맞게 설정
                height: MediaQuery.of(context).size.height / 2,  // 화면 높이의 절반으로 설정
                child: GameWidget(game: MainGame(context)),
              ),
            ),
            //game view on upper
          ],
        ),
      ),
    );
  }
}
