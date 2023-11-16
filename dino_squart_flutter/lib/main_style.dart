import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var mainTheme = ThemeData(
  primaryColor: MyColors.deepGreen,
  scaffoldBackgroundColor: MyColors.black,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
  ),
    iconTheme: IconThemeData(
      color: Colors.black,
    )
);
class MyColors{
  static final white = Colors.white;
  static final black = Colors.black ;
  static final grey = Color(0xff757575);
  static final lightGrey = Color(0xffd2d2d2);
  static final BLUE = Color(0xff2e9fe5);
  static final RED = Colors.red;
  static final GREEN = Color(0xff3ae52e);
  static final deepGreen = Color(0xff34A76D);
  static final sky = Color(0xffa0e4f5);
  static final easy = Colors.greenAccent;
  static final normal = Colors.lightBlueAccent;
  static final hard = Colors.redAccent;

}
class MyTextStyles{
  static TextStyle h1 = TextStyle(color: Colors.black,fontSize: 42.sp,fontWeight: FontWeight.bold);
  static TextStyle h2 = TextStyle(color: Colors.black,fontSize: 32.sp,fontWeight: FontWeight.bold);
  static TextStyle h3 = TextStyle(color: Colors.black,fontSize: 24.sp,fontWeight: FontWeight.normal);
  static TextStyle h3_B = TextStyle(color: Colors.black,fontSize: 24.sp,fontWeight: FontWeight.bold);
  static TextStyle h4 = TextStyle(color: Colors.black,fontSize: 16.sp,fontWeight: FontWeight.normal);
  static TextStyle h1_sub = TextStyle(color: Colors.black,fontSize: 24.sp,fontWeight: FontWeight.bold);
  static TextStyle h1_w = TextStyle(color: Colors.white,fontSize: 42.sp,fontWeight: FontWeight.bold);
  static TextStyle h2_w = TextStyle(color: Colors.white,fontSize: 32.sp,fontWeight: FontWeight.bold);
  static TextStyle h3_w = TextStyle(color: Colors.white,fontSize: 24.sp,fontWeight: FontWeight.normal);
  static TextStyle h4_w = TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.normal);
  static TextStyle g1_outline_color(Color fontColor){
    return TextStyle(
      fontSize: 64.sp,
      fontWeight: FontWeight.bold,
      color: fontColor

    );

  }
}


class MyCardStyles{
  static final redCardStyle = BoxDecoration(
    color: MyColors.RED,borderRadius:BorderRadius.circular(16),);
  static final normalCardStyle = BoxDecoration(
    color: MyColors.grey,borderRadius:BorderRadius.circular(16),);
  static final lockedCardStyle = BoxDecoration(
    color: MyColors.grey.withOpacity(0.7),borderRadius:BorderRadius.circular(16),);

  static final outLinedBoxStyle = BoxDecoration(
      color: MyColors.white,borderRadius:BorderRadius.circular(16),
      border: Border.all(
          width: 4.w,
          color: MyColors.black
      )
  );
  static final outLinedGreyBoxStyle = BoxDecoration(
    color: MyColors.lightGrey,borderRadius:BorderRadius.only(topLeft: Radius.circular(64),topRight: Radius.circular(64)),
    border: Border.all(
      width: 4.w,
      color: MyColors.black
    )
  );
  static final outLinedBtnStyle = BoxDecoration(
      color: mainTheme.primaryColor,borderRadius:BorderRadius.circular(64),
      border: Border.all(
          width: 4.w,
          color: MyColors.black
      )
  );
  static BoxDecoration outLinedColorBox(Color bgColor){
    return BoxDecoration(
        color: bgColor,borderRadius:BorderRadius.circular(16),
        border: Border.all(
            width: 4.w,
            color: MyColors.black
        )
    );
 }
  static BoxDecoration outLinedColorBoxNoRadius(Color bgColor){
    return BoxDecoration(
        color: bgColor,
        border: Border.all(
            width: 4.w,
            color: MyColors.black
        )
    );
  }
}

class MyPadding{
  static const double side = 24;
}