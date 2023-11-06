import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/ui/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ReportTotalCalorieCard extends StatelessWidget {
  const ReportTotalCalorieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(8.h),
        decoration: MyCardStyles.outLinedBoxStyle,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16.w, 16.h, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('칼로리',style: MyTextStyles.h3,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('123',style: MyTextStyles.h1),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 4.h),
                          child: Text('cal',style: MyTextStyles.h3))
                    ],
                  )
                ],
              ),
            ),

            Expanded(
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      //                       color: Colors.blue,
                        child: Image(alignment : Alignment.bottomRight,image: AssetImage('assets/images/sunin.png'),width: 200.w,height: 200.h,)))),
          ],
        ),
      ),
    );
  }
}
