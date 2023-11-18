import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PauseTab extends StatefulWidget {
  const PauseTab({Key? key}) : super(key: key);

  @override
  State<PauseTab> createState() => _PauseTabState();
}

class _PauseTabState extends State<PauseTab> {
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
