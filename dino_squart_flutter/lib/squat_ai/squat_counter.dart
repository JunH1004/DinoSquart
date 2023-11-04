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
    print(rlength);
    
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
    //각도 계산
    final lAngle = getAngle(pose, PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle);
    final rAngle = getAngle(pose, PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle);
    //길이 계산
    final lLength = calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHip);
    final rLength = calculateDistance(pose, PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHip);

    // 평균 각도 계산
    final averageAngle = (lAngle + rAngle) / 2.0;
    //평균 길이 계산
    final averageLength = (lLength + rLength)/2.0;
    // 각도의 범위를 맞춰주기 위한 보간(interpolation) 계산
    final progress = (70 - averageAngle) / (70 - 150);

    // 계산된 보간값이 0.0에서 1.0 사이에 머무르도록 보장
    final clampedProgress = progress.clamp(0.0, 1.0);


    return clampedProgress;
  }

  double calculateDistance(Pose pose, PoseLandmarkType landmarkType1, PoseLandmarkType landmarkType2) {
  PoseLandmark landmark1 = pose.landmarks[landmarkType1]!;
  PoseLandmark landmark2 = pose.landmarks[landmarkType2]!;

  double x1 = landmark1.x;
  double y1 = landmark1.y;

  double x2 = landmark2.x;
  double y2 = landmark2.y;

  double distance = ((x2 - x1).abs() + (y2 - y1).abs());

  return distance;
}

  bool isDown() {
    if (pose.landmarks.isEmpty){
      return false;
    }
    final lAngle = getAngle(pose, PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle); //왼쪽 각도 계산
    final rAngle = getAngle(pose, PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle); //오른쪽 각도 계산
    final lLength = calculateDistance(pose, PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHip); //왼쪽 길이 계산
    final rLength = calculateDistance(pose, PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHip); //오른쪽 길이 계산
    print(lLength); //확인용 길이 출력 
    print(rLength); //상동
    if (lAngle > 120 && rAngle > 120) {
      return true;}
    return false;
  }
  bool isUp() {
    if (pose.landmarks.isEmpty){
      return false;
    }
    final lAngle = getAngle(pose, PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle);
    final rAngle = getAngle(pose, PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle);
    if (lAngle < 80 && rAngle < 80 ) {
      return true;}
    return false;
  }
  bool isCorrectPose() {
    return true;
  }
  
}


