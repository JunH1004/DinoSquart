import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../main_style.dart';


class BottomButton extends StatelessWidget {
  BottomButton({required this.mainColor, required this.onPressed,required this.text});
  Color mainColor;
  var onPressed;
  String text;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 60,
            color: mainColor,
          ),
        ),
        SafeArea(
            child: Align(
          alignment: Alignment.bottomCenter,
              child: Container(
                height: 61,
                width: double.infinity,
                  color: mainColor,
                  child: TextButton(
                      onPressed: onPressed,
                      child: Text(text,),
                  )),
        )),
      ],
    );;
  }
}
void confirmDiaglog(BuildContext context, String contentText, Function onPressed) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: Text('Please Confirm'.tr()),
        content: Text(contentText),
        actions: [
          TextButton(
            onPressed: () {
              onPressed();
              Navigator.of(context).pop(); // 다이얼로그 닫기
            },
            child: Text('Yes'.tr(),style: TextStyle(color: MyColors.RED),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
            },
            child: Text('No'),
          ),
        ],
      );
    },
  );
}

class SliverSimpleBoard extends StatelessWidget {
  SliverSimpleBoard(this.left,this.right);
  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child : Padding(
          padding: EdgeInsets.fromLTRB(MyPadding.side, 10, MyPadding.side, 0),
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: CardStyles.normalCardStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(left,),
                Text(right,),
              ],
            ),
          ),
        )
    );
  }
}
class SimpleBoard extends StatelessWidget {
  SimpleBoard(this.left,this.right);
  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: CardStyles.normalCardStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left,),
          Text(right,),
        ],
      ),
    );
  }
}