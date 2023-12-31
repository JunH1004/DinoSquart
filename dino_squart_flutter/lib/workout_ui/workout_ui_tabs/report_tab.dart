import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/workout_ui/workout_ui_tabs/report_contents/report_best_score_card.dart';
import 'package:dino_squart_flutter/workout_ui/workout_ui_tabs/report_contents/report_calorie_chart.dart';
import 'package:dino_squart_flutter/workout_ui/workout_ui_tabs/report_contents/report_total_avoid_card.dart';
import 'package:dino_squart_flutter/workout_ui/workout_ui_tabs/report_contents/report_total_calorie_card.dart';
import 'package:dino_squart_flutter/workout_ui/workout_ui_tabs/report_contents/report_total_time_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stroke_text/stroke_text.dart';

class ReportTab extends StatelessWidget {
  const ReportTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            flex: 10,
            child: Container(
              color: MyColors.black.withOpacity(0.5),
              child: Center(
                child: StrokeText(
                  text: 'Game Over',
                  textStyle: MyTextStyles.g1_outline_color(MyColors.RED),
                  strokeColor: Colors.white,
                  strokeWidth: 100,
                )
              ),
            )),
        Flexible(
          flex: 10,
          child: Container(
            decoration: MyCardStyles.outLinedColorBoxNoRadius(MyColors.lightGrey),
              padding: EdgeInsets.all(32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReportCalorieChartCard(),
                            ReportBestScoreCard(),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReportTotalTimeCard(),
                            ReportTotalCalorieCard(),
                            ReportTotalAvoidCard(),
                          ],
                          //Calorie card
                          //업적 카드
                        ),
                      )
                    ],
                  ),
                ),
                Container(height: 32.h,),
                GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      decoration: MyCardStyles.outLinedBtnStyle,
                      height: 120.h,
                      width: double.infinity,
                      child: Center(
                        child: Text('홈 화면으로', style: MyTextStyles.h1_w,)
                      ),
                    )
                )
              ],
            )
          ),
        ),
      ],
    );
  }
}
