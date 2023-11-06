import 'package:dino_squart_flutter/main_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SquatTab extends StatelessWidget {
  const SquatTab({Key? key}) : super(key: key);

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
          child: Container(
            decoration: MyCardStyles.outLinedColorBoxNoRadius(MyColors.lightGrey),
            child: Center(
              child: Text("Squat TAB"),
            ),
          ),
        ),
      ],
    );
  }
}
