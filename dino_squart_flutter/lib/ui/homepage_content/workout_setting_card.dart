import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/ui/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
class WorkoutSettingCard extends StatelessWidget {
  const WorkoutSettingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: MyCardStyles.outLinedBoxStyle,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Workout',style: MyTextStyles.h2,),
                ],
              ),
            ),

            Expanded( //Difficulty region
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                          flex: 2,
                          child: Text('난이도',style: MyTextStyles.h3,)),
                      Flexible(
                        flex: 3,
                        child: DifficultyBtns(),
                      ),
                    ],
                  )
                
                
                )),
            Divider(color: MyColors.black,),
            Expanded( //Difficulty region
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                            flex: 2,
                            child: Text('시간',style: MyTextStyles.h3,)),
                        Flexible(
                          flex: 3,
                          child: TimePicker(),
                        ),
                      ],
                    )


                )),

          ],
        ),
      ),
    );
  }
}
class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return HorizontalPicker(
      minValue: 0,
      maxValue: 50,
      divisions: 50,
      suffix: "분",
      showCursor: false,
      backgroundColor: MyColors.white,
      activeItemTextColor: MyColors.black,
      passiveItemsTextColor: MyColors.grey,
      onChanged: (value) {}, height: 100,
    );
  }
}

class DifficultyBtns extends StatefulWidget {
  const DifficultyBtns({super.key});

  @override
  State<DifficultyBtns> createState() => _DifficultyBtnsState();
}

class _DifficultyBtnsState extends State<DifficultyBtns> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [ //난이도 버튼 3개 / 쉬운, 보통, 어려움
        DifficultyBtn('Easy',MyColors.easy,0),
        DifficultyBtn('Normal',MyColors.normal,1),
        DifficultyBtn('Hard',MyColors.hard,2),
      ],
    );
  }
}
class DifficultyBtn extends StatefulWidget {
  DifficultyBtn(this.text, this.bgColor, this.index);
  String text;
  Color bgColor;
  int index;

  @override
  State<DifficultyBtn> createState() => _DifficultyBtnState();
}

class _DifficultyBtnState extends State<DifficultyBtn> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = context.watch<HompageDataStore>().getWorkoutDifficulty() == widget.index;
    return Expanded(
      child: GestureDetector(
        onTap: (){
          context.read<HompageDataStore>().setWorkoutDifficulty(widget.index);
        },
        child: Container(
          margin: isSelected? EdgeInsets.fromLTRB(8, 0, 8, 0) :EdgeInsets.fromLTRB(8, 32, 8, 0),
          decoration: isSelected? MyCardStyles.outLinedColorBox(widget.bgColor):MyCardStyles.outLinedColorBox(widget.bgColor.withOpacity(0.5)),
          child: Center(child: Text(widget.text,style: TextStyle(color: MyColors.black,fontSize: 16,fontWeight: FontWeight.bold),),),
        ),
      ),
    );
  }
}
