import 'package:flutter/material.dart';

var mainTheme = ThemeData(
  primaryColor: MyColors.red,
  scaffoldBackgroundColor: MyColors.black,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
  ),
    iconTheme: IconThemeData(
      color: Colors.white,
    )
);
class MyColors{
  static final red = Color(0xffe52e31);
  static final deepRed = Color(0xffbe2022);
  static final grey = Color(0xff2a2a2a);
  static final black = Color(0xff191919);
  static final lightGrey = Color(0xff757575);
  static final yellow = Colors.amberAccent;
  static final BLUE = Color(0xff2e9fe5);
  static final RED = Colors.red;
  static final GREEN = Color(0xff3ae52e);
}
class MyTextStyles{
  static final headTextStyle = TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600);
  static final bodyTextStyle = TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.normal);
  static final iconTextStyle = TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold);
  static final subTextStyle = TextStyle(color: MyColors.lightGrey,fontSize: 11,fontWeight: FontWeight.normal);
  static final cardBodyTextStyle = TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold);
  static final workoutLargeStyle = TextStyle(color: Colors.white,fontSize: 55,fontWeight: FontWeight.bold);
  static final workoutNormalStyle = TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.bold);
  static final workoutSmallStyle = TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold);
  static final reportTextStyle = TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.normal);
  static final bottomBtnTestStyle = TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.normal);
  static final NoteNormalTextStyle = TextStyle(color: MyColors.RED,fontSize: 16,fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,);
}

class CardStyles{
  static final redCardStyle = BoxDecoration(
    color: MyColors.red,borderRadius:BorderRadius.circular(16),);
  static final normalCardStyle = BoxDecoration(
    color: MyColors.grey,borderRadius:BorderRadius.circular(16),);
  static final lockedCardStyle = BoxDecoration(
    color: MyColors.grey.withOpacity(0.7),borderRadius:BorderRadius.circular(16),);
}

class MyPadding{
  static const double side = 24;
}