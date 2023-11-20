import 'dart:math';

import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SquatTab extends StatefulWidget {
  const SquatTab({Key? key}) : super(key: key);

  @override
  State<SquatTab> createState() => _SquatTabState();
}

class _SquatTabState extends State<SquatTab> {
  final double goodTopLine = 0.5;

  final double goodBottomLine = 0.0;

  final double perfectTopLine = 0.25;

  final double perfectBottomLine = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            flex: 10,
            child: Container(
              //게임뷰 위에 있을 투명한 컨테이너
            )),
        Flexible(
          flex: 10,
          child: Stack(
            children: [
              Container(
                decoration: MyCardStyles.outLinedColorBoxNoRadius(MyColors.lightGrey.withOpacity(0)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: MyCardStyles.outLinedColorBox(MyColors.white.withOpacity(0.2)),
                    width: 50.w,
                    margin: EdgeInsets.fromLTRB(0, 32.h, 32.w, 32.h),
                    padding: EdgeInsets.fromLTRB(0, 16.h, 0,16.h),
                    child: Stack(
                      children: [
                        Container(
                        ),
                         Positioned.fill(
                          child:  LayoutBuilder(
                            builder: (context, constraints) {
                              return Padding(
                                padding: EdgeInsets.only(top: constraints.biggest.height * (1.0 - goodTopLine), bottom: constraints.biggest.height * goodBottomLine),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Colors.lightGreenAccent.withOpacity(0.5),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned.fill(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Padding(
                                padding: EdgeInsets.only(top: constraints.biggest.height * (1.0 - perfectTopLine), bottom: constraints.biggest.height * perfectBottomLine),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Colors.lightGreenAccent.withOpacity(0.9),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned.fill(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: constraints.biggest.height * (1 - context.watch<WorkoutInfo>().squatLevel),
                                    bottom: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32),bottomRight: Radius.circular(32)),
                                    color: Colors.red),
                                  ),
                              );
                            },
                          ),
                        ),
                        Point(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Point extends StatefulWidget {
  const Point({Key? key}) : super(key: key);

  @override
  State<Point> createState() => _PointState();
}

class _PointState extends State<Point> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child:  LayoutBuilder(
        builder: (context, constraints) {
          return Transform.translate(
            offset: Offset(
                0,
                constraints.biggest.height * (0.5 - context.watch<WorkoutInfo>().squatLevel)
            ),
            child: CircleAvatar(
              backgroundColor: MyColors.RED,
              radius: 32.w,
            ),
          );
        },
      ),
    );
  }
}
