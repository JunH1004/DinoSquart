import 'package:dino_squart_flutter/main_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PauseTab extends StatelessWidget {
  const PauseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            color: MyColors.black.withOpacity(0.5),
            child: Center(
              child: Text('정지',style: MyTextStyles.h1_w,),
            ),
          ),
        ),
      ],
    );
  }
}
