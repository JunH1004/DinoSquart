import 'dart:math';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

double getAngle(Pose pose,PoseLandmarkType p1, PoseLandmarkType p2,PoseLandmarkType p3) 
{
  double radians = atan2(pose.landmarks[p3]!.y - pose.landmarks[p2]!.y, pose.landmarks[p3]!.x - pose.landmarks[p2]!.x) -
      atan2(pose.landmarks[p1]!.y - pose.landmarks[p2]!.y, pose.landmarks[p1]!.x - pose.landmarks[p2]!.x);

  double angle = (radians * 180 / pi).abs();
  if (angle > 180) 
  {
    angle = 360 - angle;
  }

  return angle;
}

double calculateDistance(Pose pose, PoseLandmarkType landmarkType1, PoseLandmarkType landmarkType2) // 두 정점(랜드마크)의 거리를 구하는 함수 추가 수정 없을듯 
{
  PoseLandmark landmark1 = pose.landmarks[landmarkType1]!;
  PoseLandmark landmark2 = pose.landmarks[landmarkType2]!;

  double x1 = landmark1.x;
  double y1 = landmark1.y;

  double x2 = landmark2.x;
  double y2 = landmark2.y;

  double distance = ((x2 - x1).abs() + (y2 - y1).abs());

  return distance;
}

double calculateArea(Pose pose, PoseLandmarkType landmarkType1, PoseLandmarkType landmarkType2, PoseLandmarkType landmarkType3, PoseLandmarkType landmarkType4) // 4개의 정점(랜트마크)를 이용해 면적을 구하는 함수(카마라와 모션사이의 거리를 구하는 함수)추가수정 없을듯
{
  PoseLandmark landmark1 = pose.landmarks[landmarkType1]!;
  PoseLandmark landmark2 = pose.landmarks[landmarkType2]!;
  PoseLandmark landmark3 = pose.landmarks[landmarkType3]!;
  PoseLandmark landmark4 = pose.landmarks[landmarkType4]!;

  double x1= landmark1.x;
  double x2= landmark2.x;
  double x3= landmark3.x;
  double x4= landmark4.x;

  double y1= landmark1.y;
  double y2= landmark2.y;
  double y3= landmark3.y;
  double y4= landmark4.y;

  double area= 1/2*((x1*y2+x2*y3+x3*y4+x4*y1)-(y1*x2+y2*x3+y3*x4+y4*x1));
  return area;
}

String convertToTimeString(int value) 
{
  // 정수값을 분과 초로 분리
  int minutes = value ~/ 60;
  int seconds = value % 60;

  // 시간 문자열 생성
  String minutesString = minutes.toString().padLeft(2, '0');
  String secondsString = seconds.toString().padLeft(2, '0');

  // 분과 초를 조합하여 시간 문자열 생성
  String timeString = '$minutesString:$secondsString';

  return timeString;
}
