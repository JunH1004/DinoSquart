import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/ui/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Container(
        margin: EdgeInsets.all(8.h),
        decoration: MyCardStyles.outLinedBoxStyle,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16.w, 16.h, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('업적',style: MyTextStyles.h2,),
                  Image(image: AssetImage('assets/images/king.png'),width: 64.w,height: 64.h,),
                  Text('',style: MyTextStyles.h2,),
                  Text('  ',style: MyTextStyles.h2,),
                ],
              ),
            ),

            Expanded(
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(16.w,0, 16.w, 16.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      ContentBox('총 운동 시간',context.watch<HompageDataStore>().getTotalWorkoutTimeText(),''),
                      ContentBox('총 소모 칼로리',context.watch<HompageDataStore>().getTotalBurnCalorie.toString(),'cal'),
                      ContentBox('피한 장애물',context.watch<HompageDataStore>().getTotalAvoidedObstacle.toString(),'개'),
                    ],
                  )
                )),
          ],
        ),
      ),
    );
  }
}

class ContentBox extends StatelessWidget {
  ContentBox(this.headText, this.bodyText, this.tailText);
  String headText;
  String bodyText;
  String tailText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(headText,style: MyTextStyles.h3,),
        RichText(
          text: TextSpan(
            text: bodyText,
            style: MyTextStyles.h3_B,
            children: <TextSpan>[
              TextSpan(text: tailText, style: MyTextStyles.h4),
            ],
          ),
        )
      ],
    );
  }
}
