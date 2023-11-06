import 'package:dino_squart_flutter/main_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadyTab extends StatelessWidget {
  const ReadyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            color: MyColors.black.withOpacity(0.5),
            child: Center(
              child: Text("전신이 보이게 서주세요",style: MyTextStyles.h1_w,),
            ),
          ),
        ),
      ],
    );
  }
}
