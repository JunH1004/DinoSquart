import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:provider/provider.dart';
import '../squat_ai/squat_counter.dart';
import '../workout_ui/workout_page.dart';
import 'camera_view.dart';
import 'painters/pose_painter.dart';
class PoseDetectorView extends StatefulWidget {
  PoseDetectorView(this.squatCounter);
  SquatCounter squatCounter;
  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView> {
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;


  @override
  void dispose() async {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //final state = context.read<WorkoutPageStateStore>().state;
    return Material(
      child: Stack(
        children: [
          CameraView(
            title: '',
            customPaint: _customPaint,
            text: _text,
            onImage: (inputImage) {
              processImage(inputImage);
            },
          ),
        ],
      ),
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    final poses = await _poseDetector.processImage(inputImage);
    //if (poses.isNotEmpty ) {
      //print("${poses[0].landmarks[PoseLandmarkType.nose]?.x}, ${poses[0].landmarks[PoseLandmarkType.nose]?.y}");
    //}
    if (poses.isNotEmpty) {
      widget.squatCounter.setPose(poses[0]);
      widget.squatCounter.doReps();
    }
    else{
      _isBusy = false;
      return;
    }
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      if (poses.isNotEmpty) {
        widget.squatCounter.setPose(poses[0]);
      }
      final painter = PosePainter(
          poses, inputImage.metadata!.size, inputImage.metadata!.rotation,widget.squatCounter.getProgress());
      _customPaint = CustomPaint(painter: painter);

    } else {
      _text = 'Poses found: ${poses.length}\n\n';
      // TODO: set _customPaint to draw landmarks on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
