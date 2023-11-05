import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import '../../main_style.dart';
import 'coordinates_translator.dart';

class PosePainter extends CustomPainter {
  PosePainter(this.poses, this.absoluteImageSize, this.rotation, this.progress);

  double progress;
  final List<Pose> poses;
  Size absoluteImageSize;
  final InputImageRotation rotation;
  final pointColor = Colors.white70;
  Color get lineColor {
    // progress 값에 따라 색상 계산
    final interpolatedColor = Color.lerp(Colors.white, MyColors.RED, progress);
    // lerp 함수는 progress 값에 따라 두 색상을 보간(interpolate)하여 새로운 색상을 생성
    // 이 예시에서는 0.0에 가까울수록 red, 1.0에 가까울수록 blue에 가까운 색상이 생성됨
    return interpolatedColor ?? Colors.white; // null 체크 후 기본값 설정
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9.0
      ..color = pointColor;
    final headPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.0
      ..color = pointColor;

    final leftPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = lineColor;

    final rightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = lineColor;

    for (final pose in poses) {
      final head = pose.landmarks[PoseLandmarkType.nose];
      canvas.drawCircle(
          Offset(
            translateX(head!.x, rotation, size, absoluteImageSize),
            translateY(head!.y, rotation, size, absoluteImageSize),
          ),
          1,
          headPaint);

      pose.landmarks.forEach((_, landmark) {
        if (landmark.type == PoseLandmarkType.leftThumb || landmark.type == PoseLandmarkType.rightThumb) return;
        if (landmark.type == PoseLandmarkType.leftPinky || landmark.type == PoseLandmarkType.rightPinky) return;
        if (landmark.type == PoseLandmarkType.leftIndex || landmark.type == PoseLandmarkType.rightIndex) return;
        if (landmark.type == PoseLandmarkType.leftAnkle || landmark.type == PoseLandmarkType.rightAnkle) return;
        if (landmark.type == PoseLandmarkType.leftKnee || landmark.type == PoseLandmarkType.rightKnee) return;
        if (landmark.type == PoseLandmarkType.leftHeel || landmark.type == PoseLandmarkType.rightHeel) return;
        if (landmark.type == PoseLandmarkType.leftFootIndex || landmark.type == PoseLandmarkType.rightFootIndex) return;

        if (landmark.type == PoseLandmarkType.leftWrist || landmark.type == PoseLandmarkType.rightWrist) return;
        if (landmark.type == PoseLandmarkType.leftElbow || landmark.type == PoseLandmarkType.rightElbow) return;

        if (landmark.type.index > PoseLandmarkType.rightMouth.index) {
          canvas.drawCircle(
              Offset(
                translateX(landmark.x, rotation, size, absoluteImageSize),
                translateY(landmark.y, rotation, size, absoluteImageSize),
              ),
              1,
              paint);
        }
      }
      );

      void paintLine(
          PoseLandmarkType type1, PoseLandmarkType type2, Paint paintType) {
        final PoseLandmark joint1 = pose.landmarks[type1]!;
        final PoseLandmark joint2 = pose.landmarks[type2]!;
        canvas.drawLine(
            Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
                translateY(joint1.y, rotation, size, absoluteImageSize)),
            Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
                translateY(joint2.y, rotation, size, absoluteImageSize)),
            paintType);
      }

      //Draw arms
      /*
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, leftPaint);
      paintLine(
          PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, leftPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
          rightPaint);
      paintLine(
          PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist, rightPaint);

       */

      //Draw Body
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, leftPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
          rightPaint);
      paintLine(
          PoseLandmarkType.leftHip, PoseLandmarkType.rightHip, leftPaint);
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder, leftPaint);

      //Draw legs
      paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, leftPaint);
      paintLine(
          PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, leftPaint);
      paintLine(
          PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, rightPaint);
      paintLine(
          PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle, rightPaint);
    }
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.poses != poses;
  }
}
