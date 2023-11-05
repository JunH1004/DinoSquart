import 'package:flutter/material.dart';

var mainTheme = ThemeData(
  primaryColor: MyColors.deepGreen,
  scaffoldBackgroundColor: MyColors.black,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
  ),
    iconTheme: IconThemeData(
      color: Colors.white,
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
}
class MyTextStyles{
  static const h1 = TextStyle(color: Colors.black,fontSize: 42,fontWeight: FontWeight.bold);
  static const h2 = TextStyle(color: Colors.black,fontSize: 32,fontWeight: FontWeight.bold);
  static const h3 = TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.normal);
  static const h1_sub = TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold);
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
          width: 4,
          color: MyColors.black
      )
  );
  static final outLinedGreyBoxStyle = BoxDecoration(
    color: MyColors.lightGrey,borderRadius:BorderRadius.only(topLeft: Radius.circular(64),topRight: Radius.circular(64)),
    border: Border.all(
      width: 4,
      color: MyColors.black
    )
  );
  static final outLinedBtnStyle = BoxDecoration(
      color: mainTheme.primaryColor,borderRadius:BorderRadius.circular(64),
      border: Border.all(
          width: 4,
          color: MyColors.black
      )
  );
}

class MyPadding{
  static const double side = 24;
}