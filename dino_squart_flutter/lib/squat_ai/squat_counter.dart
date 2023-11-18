import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:provider/provider.dart';

import '../utility/util.dart';
import '../workout_ui/workout_page.dart';
class SquatCounter extends ChangeNotifier
{

  SquatCounter(this.context);
  BuildContext context;
  Pose pose = Pose(landmarks: {});
  var restart = true;
  late Timer _standTimer = Timer.periodic(Duration(seconds: 5), (timer) {});
  var standTime = 0;
  bool isStandTimerRunning = false;
  double lastHeadYPose = 0;

  late Timer _totalTimer;
  bool isTotalTimerRunning = false;

  late Timer _notStandTimer;
  bool isNotStandTimerRunning = false;

  

  void startTotalTimer()
  {
    if (isTotalTimerRunning)
    {
      return;
    }
    isTotalTimerRunning = true;
    _totalTimer = Timer.periodic(Duration(seconds: 1), (timer) 
    {
      //context.read<WorkoutInfo>().totalWorkoutTime += 1;
    });
  }
  void stopTotalTimer() 
  {
    if (!isTotalTimerRunning)
    {
      return;
    }
    isTotalTimerRunning = false;
    _totalTimer.cancel();
  }

  void startStandTimer() 
  {
    if (isStandTimerRunning)
    {
      return;
    }
    isStandTimerRunning = true;
    _standTimer = Timer.periodic(Duration(milliseconds: 50), (timer) 
    {
      standTime += 50;
      //context.read<WorkoutInfo>().setGripBarTime(gripTime);
    });
  }
  void stopStandTimer() 
  {
    if (!isStandTimerRunning)
    {
      return;
    }
    isStandTimerRunning = false;
    _standTimer.cancel();
  }

  void setPose(Pose p) 
  {
    pose = p;
  }
  void doReps() 
  {
    if(pose == null)
    {
      restart = true;
      return;
    }

    context.read<WorkoutInfo>().setSquatLevel(getSquatLevel());
    // if(context.read<WorkoutPageStateStore>().state == WorkoutPageState.Stand){
    //   if (isGripBar()) {
    //     if (standTime == 0) {
    //       startStandTimer();
    //     }
    //     if (standTime >= 1000){
    //       context.read<WorkoutPageStateStore>().setPageState(WorkoutPageState.Workout);
    //       context.read<WorkoutInfo>().setIsArmDown(false);
    //       restart = true;
    //       context.read<WorkoutInfo>().setGripBarTime(0);
    //       standTime = 0;
    //       stopStandTimer();
    //       //
    //
    //     }
    //   }
    //   else{
    //     stopStandTimer();
    //     context.read<WorkoutInfo>().setGripBarTime(0);
    //     standTime = 0;
    //   }
    //   return;
    // }

    // if (isBarReleased()){
    //
    // }

    // else if (isGripBar()) {
    //   if (context.read<WorkoutInfo>().isArmDown == true){
    //     startStandTimer();
    //     context.read<WorkoutInfo>().armDownTime =0;
    //     context.read<WorkoutInfo>().setIsArmDown(false);
    //     context.read<WorkoutPageStateStore>().setPageState(WorkoutPageState.Stand);
    //   }
    // }
    // else if (context.read<WorkoutInfo>().isArmDown == true){
    //   context.read<WorkoutInfo>().setIsArmDown(true);
    //   startArmDownTimer();
    //   if (context.read<WorkoutInfo>().armDownTime > 3){
    //     skipSet();
    //     stopArmDownTimer();
    //   }
    //   return;
    // }

    //Send date to WorkoutInfo 
    //context.read<WorkoutInfo>().setATH(calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHip));
    //context.read<WorkoutInfo>().setATK(calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftKnee));
    //context.read<WorkoutInfo>().setPropotion((calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHip))/(calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftKnee)));
    
    
    
    
    
    if (restart) 
    {
    
      if (isUp()) 
      {
        restart = false;
        whenUp();
      }
    }
    else 
    {
      if (isDown()) 
      {
        restart = true;
        whenDown();
      }
    }
  }

  whenUp()
  {
    context.read<WorkoutInfo>().addSquartCount();
    print(context.read<WorkoutInfo>().squatCount);  
  }
  whenDown()
  {
  }





  double getProgress() 
  {
    if (pose.landmarks.isEmpty)
    {
      return 0;
    }
    if (!isCorrectPose())
    {
      return 0;
    }
    //각도 계산
    final lAngle = getAngle(pose, PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle);
    final rAngle = getAngle(pose, PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle);

    // 평균 각도 계산
    final averageAngle = (lAngle + rAngle) / 2.0;

    // 각도의 범위를 맞춰주기 위한 보간(interpolation) 계산
    final progress = (70 - averageAngle) / (70 - 150);

    // 계산된 보간값이 0.0에서 1.0 사이에 머무르도록 보장
    final clampedProgress = progress.clamp(0.0, 1.0);

    return clampedProgress;
  }


  double getAvgLength() 
  {
    final avg_length = calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHip);
    notifyListeners();
    return avg_length;
  }
  double getAvgAngle()
  {
    final avg_angle = (getAngle(pose, PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle)+getAngle(pose, PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle))/2;
    notifyListeners();
    return avg_angle;
  }
  double getBodySize()
  {
    final body_size = calculateArea(pose, PoseLandmarkType.leftHip, PoseLandmarkType.rightHip, PoseLandmarkType.rightShoulder,PoseLandmarkType.leftShoulder);
    notifyListeners();
    return body_size;
  }



  bool isDown() // 내려갔을때의 각도 값과 Hip과 Ankle 사이의 거리를 이용해 정상적으로 내려왔는지 확인하는 값 추후에 내려온 정도를 리니어하게 출력하는 방안을 모색할것 
  {
    if (pose.landmarks.isEmpty)
    {
      return false;
    }
    final lATHLength = calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHip); //왼쪽 ATH길이 계산
    final rATHLength = calculateDistance(pose, PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHip); //오른쪽 ATH길이 계산
    final lATKLength = calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftKnee); //왼쪽 ATH길이 계산
    final rATKLength = calculateDistance(pose, PoseLandmarkType.rightAnkle, PoseLandmarkType.rightKnee); //오른쪽 ATH길이 계산
    final avg_ATHLength = (rATHLength+lATHLength)/2; // 좌우 ATH평균 길이 
    final avg_ATKLength = (rATKLength+lATKLength)/2; // 좌우 ATK평균 길이
    final min_maxLength = ((avg_ATHLength/avg_ATKLength)-1).clamp(0.0, 1.0);
    
    if ( min_maxLength<0.3) 
    {
      return true;
    }
    return false;
  }
  double getSquatLevel(){
    if (pose.landmarks.isEmpty)
    {
      return 1.0;
    }
    final lATHLength = calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHip); //왼쪽 ATH길이 계산
    final rATHLength = calculateDistance(pose, PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHip); //오른쪽 ATH길이 계산
    final lATKLength = calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftKnee); //왼쪽 ATH길이 계산
    final rATKLength = calculateDistance(pose, PoseLandmarkType.rightAnkle, PoseLandmarkType.rightKnee); //오른쪽 ATH길이 계산
    final avg_ATHLength = (rATHLength+lATHLength)/2; // 좌우 ATH평균 길이
    final avg_ATKLength = (rATKLength+lATKLength)/2; // 좌우 ATK평균 길이
    return ((avg_ATHLength/avg_ATKLength)-1).clamp(0.0, 1.0);
  }
  bool isUp() // 올라왔을때의 각도 값과 Hip과 Ankle 사이의 거리를 이용해 정상적으로 올라왔는지 확인하는 값 추후에 올라온 정도를 를 isDown()의 것과 같이 리니어하게 출려갛는 방안 모색 
  {
    if (pose.landmarks.isEmpty)
    {
      return false;
    }
    final lATHLength = calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHip); //왼쪽 ATH길이 계산
    final rATHLength = calculateDistance(pose, PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHip); //오른쪽 ATH길이 계산
    final lATKLength = calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftKnee); //왼쪽 ATH길이 계산
    final rATKLength = calculateDistance(pose, PoseLandmarkType.rightAnkle, PoseLandmarkType.rightKnee); //오른쪽 ATH길이 계산
    final avg_ATHLength = (rATHLength+lATHLength)/2; // 좌우 ATH평균 길이 
    final avg_ATKLength = (rATKLength+lATKLength)/2; // 좌우 ATK평균 길이
    final min_maxLength = ((avg_ATHLength/avg_ATKLength)-1).clamp(0.0, 1.0);
    print(min_maxLength);

    if ( min_maxLength>0.7) 
    {
      return true;
    }
    return false;
  }
  bool isCorrectPose() 
  {
    return true;
  }
  
}


