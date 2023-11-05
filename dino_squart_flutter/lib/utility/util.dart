import 'dart:math';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

double getAngle(Pose pose,PoseLandmarkType p1, PoseLandmarkType p2,PoseLandmarkType p3) {
  double radians = atan2(pose.landmarks[p3]!.y - pose.landmarks[p2]!.y, pose.landmarks[p3]!.x - pose.landmarks[p2]!.x) -
      atan2(pose.landmarks[p1]!.y - pose.landmarks[p2]!.y, pose.landmarks[p1]!.x - pose.landmarks[p2]!.x);

  double angle = (radians * 180 / pi).abs();
  if (angle > 180) {
    angle = 360 - angle;
  }

  return angle;
}

String convertToTimeString(int value) {
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
