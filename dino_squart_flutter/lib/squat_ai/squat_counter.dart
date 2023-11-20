import 'dart:async';
import 'dart:math';
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
      context.read<WorkoutInfo>().setReadyTime(standTime);
    });
  }
  void stopStandTimer() 
  {
    if (!isStandTimerRunning)
    {
      return;
    }
    isStandTimerRunning = false;
    standTime = 0;
    context.read<WorkoutInfo>().setReadyTime(standTime);
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

    if (context.read<WorkoutPageStateStore>().state == WorkoutPageState.Ready){
      //print('stand : $standTime');
      double ps = getPoseSize();
      getPoseHeight();
      //print(ps);
      if (170000 > ps && ps > 100000){
        startStandTimer();
      }
      else{

        stopStandTimer();
      }
      if (standTime > 3000){
        context.read<WorkoutPageStateStore>().setPageState(WorkoutPageState.Workout);
      }
    }


    context.read<WorkoutInfo>().setSquatLevel(getSquatLevel());
    getPoseSize();

    if (context.read<WorkoutPageStateStore>().state == WorkoutPageState.Pause){
      //정지 중 재개
      if (context.read<WorkoutInfo>().bodySize > 150000){
        context.read<WorkoutPageStateStore>().setPageState(WorkoutPageState.Workout);
      }
    }

    if (context.read<WorkoutPageStateStore>().state == WorkoutPageState.Workout){
      //정지 중 재개
      if (context.read<WorkoutInfo>().bodySize > 300000){
        context.read<WorkoutPageStateStore>().setPageState(WorkoutPageState.Pause);
      }
    }

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
    context.read<WorkoutInfo>().resetMinSquatLevel();
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
    
    if ( min_maxLength<0.5)
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

    if ( min_maxLength>0.8)
    {
      return true;
    }
    return false;
  }
  double getPoseHeight(){
    final poseHeight =
        (calculateDistance(pose, PoseLandmarkType.nose, PoseLandmarkType.leftAnkle)
            + calculateDistance(pose, PoseLandmarkType.nose, PoseLandmarkType.rightAnkle)) * 0.5;
    context.read<WorkoutInfo>().setBodyHeight(poseHeight);
    return poseHeight;
  }
  double getPoseSize(){
    if (pose.landmarks.isEmpty) {
      return 0;
    }
    // Extracting the landmarks
    List<Offset> landmarks = pose.landmarks.values.where((landmark) {
      // Exclude wrist, elbow, and shoulder landmarks
      return landmark.type != PoseLandmarkType.leftWrist &&
          landmark.type != PoseLandmarkType.rightWrist &&

          landmark.type != PoseLandmarkType.leftElbow &&
          landmark.type != PoseLandmarkType.rightElbow &&

          landmark.type != PoseLandmarkType.leftThumb &&
          landmark.type != PoseLandmarkType.rightThumb &&

          landmark.type != PoseLandmarkType.leftIndex &&
          landmark.type != PoseLandmarkType.rightIndex &&

          landmark.type != PoseLandmarkType.leftPinky &&
          landmark.type != PoseLandmarkType.rightPinky;
    }).map((point) {
      return Offset(point.x, point.y);
    }).toList();
    // Applying Graham Scan algorithm to find convex hull
    List<Offset> convexHull = grahamScan(landmarks);

    // Calculate the area of the convex hull
    context.read<WorkoutInfo>().setBodySize(calculateConvexHullArea(convexHull));
    return calculateConvexHullArea(convexHull);
  }

  Offset findLowestPoint(List<Offset> points) {
    Offset lowest = points[0];
    for (Offset point in points) {
      if (point.dy < lowest.dy || (point.dy == lowest.dy && point.dx < lowest.dx)) {
        lowest = point;
      }
    }
    return lowest;
  }
  double distanceTo(Offset a, Offset b) {
    double dx = b.dx - a.dx;
    double dy = b.dy - a.dy;
    return sqrt(dx * dx + dy * dy);
  }

  List<Offset> grahamScan(List<Offset> points) {
    if (points.length < 3) {
      // Convex hull not possible with less than 3 points
      return points;
    }
    // Sort points based on polar angle from the lowest point
    points.sort((a, b) {
      double angleA = atan2(a.dy - findLowestPoint(points).dy, a.dx - findLowestPoint(points).dx);
      double angleB = atan2(b.dy - findLowestPoint(points).dy, b.dx - findLowestPoint(points).dx);

      if (angleA < angleB) {
        return -1;
      } else if (angleA > angleB) {
        return 1;
      } else {
        // If two points have the same polar angle, the one closer comes first
        double distanceA = distanceTo(a,findLowestPoint(points));
        double distanceB = distanceTo(b,findLowestPoint(points));
        return distanceA.compareTo(distanceB);
      }
    });


    // Build the convex hull
    List<Offset> convexHull = [points[0], points[1]];
    for (int i = 2; i < points.length; i++) {
      while (convexHull.length >= 2 &&
          orientation(convexHull[convexHull.length - 2], convexHull[convexHull.length - 1], points[i]) != 2) {
        convexHull.removeLast();
      }
      convexHull.add(points[i]);
    }

    return convexHull;
  }
  // Helper function to determine orientation
  // 0 -> Collinear, 1 -> Clockwise, 2 -> Counterclockwise
  int orientation(Offset p, Offset q, Offset r) {
    double val = (q.dy - p.dy) * (r.dx - q.dx) - (q.dx - p.dx) * (r.dy - q.dy);
    if (val == 0) {
      return 0;
    }
    return (val > 0) ? 1 : 2;
  }

  // Calculate the area of the convex hull using shoelace formula
  double calculateConvexHullArea(List<Offset> convexHull) {
    int n = convexHull.length;
    double area = 0;

    for (int i = 0; i < n; i++) {
      int j = (i + 1) % n;
      area += convexHull[i].dx * convexHull[j].dy;
      area -= convexHull[j].dx * convexHull[i].dy;
    }

    area = area.abs() / 2.0;
    return area;
  }
  
}


