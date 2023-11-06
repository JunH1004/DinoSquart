import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/ui/homepage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CalorieCard extends StatelessWidget {
  List<double> data = [0,0,0,0,0,0,0];

  @override
  Widget build(BuildContext context) {
    data = context.watch<HompageDataStore>().weeklyBrunCalories;
    return Flexible(
      flex: 3,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.all(8.h),
        decoration: MyCardStyles.outLinedBoxStyle,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16.w, 16.h, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('주간 칼로리',style: MyTextStyles.h3,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(context.read<HompageDataStore>().getSumWeeklyCalorie().toString(),style: MyTextStyles.h2),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 4.h),
                          child: Text('cal',style: MyTextStyles.h3))
                    ],
                  )
                ],
              ),
            ),

            Expanded(
                child: LineChart(
                  _createRepsData(data),
                )),
          ],
        ),
      ),
    );
  }
}

LineChartData _createRepsData(List<double> data) {
  final double maxValue = data.reduce((currentMax, element) =>
  currentMax > element
      ? currentMax
      : element);
  return LineChartData(
    minX: 0,
    maxX: 6,
    minY: 0,
    maxY: maxValue + 1,
    lineBarsData: [
      LineChartBarData(
        spots: [
          for (int i = 0; i < 7; i++) i < data.length ? FlSpot(
              i.toDouble(), data[i]) : FlSpot(i.toDouble(), 0),
        ],
        isCurved: true,
        preventCurveOverShooting: false,
        color: MyColors.black,
        barWidth: 4.w,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
            show: true, color: mainTheme.primaryColor.withOpacity(0.7)),
      ),
    ],
    lineTouchData: LineTouchData(enabled: false),
    borderData: FlBorderData(show: false),
    gridData: FlGridData(
      show: true,
      drawVerticalLine: false,
      drawHorizontalLine: false,
      verticalInterval: maxValue/3,
      horizontalInterval: maxValue/5,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: MyColors.lightGrey,
          strokeWidth: 2.h,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: MyColors.lightGrey,
          strokeWidth: 2.w,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
    ),
  );
}