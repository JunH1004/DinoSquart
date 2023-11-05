import 'package:dino_squart_flutter/main_style.dart';
import 'package:flutter/cupertino.dart';

class DinoTopBoard extends StatelessWidget {
  const DinoTopBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image(image: AssetImage('assets/images/greenDino.png'),),
      ),
    );
  }
}
