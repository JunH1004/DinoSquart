import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:provider/provider.dart';

import '../utility/util.dart';
import '../workout_ui/workout_page.dart';
class SquatCounter {
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



  void startTotalTimer(){
    if (isTotalTimerRunning){
      return;
    }
    isTotalTimerRunning = true;
    _totalTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      //context.read<WorkoutInfo>().totalWorkoutTime += 1;
    });
  }
  void stopTotalTimer() {
    if (!isTotalTimerRunning){
      return;
    }
    isTotalTimerRunning = false;
    _totalTimer.cancel();
  }

  void startStandTimer() {
    if (isStandTimerRunning){
      return;
    }
    isStandTimerRunning = true;
    _standTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      standTime += 50;
      //context.read<WorkoutInfo>().setGripBarTime(gripTime);
    });
  }
  void stopStandTimer() {
    if (!isStandTimerRunning){
      return;
    }
    isStandTimerRunning = false;
    _standTimer.cancel();
  }

  void setPose(Pose p) {
    pose = p;
  }
  void doReps() {
    if(pose == null){
      restart = true;
      return;
    }
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


    //Workout State
    if (restart) {
      if (isUp()) {
        restart = false;
        whenUp();
      }
    }
    else {
      if (isDown()) {
        restart = true;
        whenDown();
      }
    }
  }
  whenUp(){
    context.read<WorkoutInfo>().addSquartCount();
    print(context.read<WorkoutInfo>().squatCount);
  }
  whenDown(){

  }


  double getProgress() {
    if (pose.landmarks.isEmpty){
      return 0;
    }
    if (!isCorrectPose()){
      return 0;
    }
    final lAngle = getAngle(pose, PoseLandmarkType.leftWrist, PoseLandmarkType.leftElbow, PoseLandmarkType.leftShoulder);
    final rAngle = getAngle(pose, PoseLandmarkType.rightWrist, PoseLandmarkType.rightElbow, PoseLandmarkType.rightShoulder);

    // 평균 각도 계산
    final averageAngle = (lAngle + rAngle) / 2.0;

    // 각도의 범위를 맞춰주기 위한 보간(interpolation) 계산
    final progress = (70 - averageAngle) / (70 - 150);

    // 계산된 보간값이 0.0에서 1.0 사이에 머무르도록 보장
    final clampedProgress = progress.clamp(0.0, 1.0);

    return clampedProgress;
  }
  bool isUp() {
    if (pose.landmarks.isEmpty){
      return false;
    }
    final lAngle = getAngle(pose, PoseLandmarkType.leftWrist, PoseLandmarkType.leftElbow, PoseLandmarkType.leftShoulder);
    final rAngle = getAngle(pose, PoseLandmarkType.rightWrist, PoseLandmarkType.rightElbow, PoseLandmarkType.rightShoulder);
    if (lAngle < 70 && rAngle < 70) {
      return true;}
    return false;
  }
  bool isDown() {
    if (pose.landmarks.isEmpty){
      return false;
    }
    final lAngle = getAngle(pose, PoseLandmarkType.leftWrist, PoseLandmarkType.leftElbow, PoseLandmarkType.leftShoulder);
    final rAngle = getAngle(pose, PoseLandmarkType.rightWrist, PoseLandmarkType.rightElbow, PoseLandmarkType.rightShoulder);
    if (lAngle > 110 && rAngle > 110) {
      return true;}
    return false;
  }
  bool isCorrectPose() {
    return true;
  }
}
