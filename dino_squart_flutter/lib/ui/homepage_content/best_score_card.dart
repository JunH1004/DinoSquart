import 'package:dino_squart_flutter/main_style.dart';
import 'package:flutter/cupertino.dart';

class BestScoreCard extends StatelessWidget {
  const BestScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: MyCardStyles.outLinedBoxStyle,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Best Score',style: MyTextStyles.h3,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('1342',style: MyTextStyles.h2),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                          child: Text('m',style: MyTextStyles.h3))
                    ],
                  )
                ],
              ),
            ),

            Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 16),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image(image: AssetImage('assets/images/king.png'),width: 100,height: 100,)),
                )),
          ],
        ),
      ),
    );
  }
}
