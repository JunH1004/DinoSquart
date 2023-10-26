import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main_style.dart';
import '../squart_ai/squart_counter.dart';
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
}



class WorkoutPage extends StatefulWidget {
  WorkoutPage({Key?key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late SquartCounter squartCounter = SquartCounter(context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Material(
        child: Stack(
          children: [
            PoseDetectorView(squartCounter),
            //game view on upper
          ],
        ),
      ),
    );
  }
}
