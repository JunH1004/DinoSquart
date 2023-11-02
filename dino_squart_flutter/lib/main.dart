import 'package:camera/camera.dart';
import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
List<CameraDescription> cameras = [];

const double _kItemExtent = 32.0;
int _selectedTargetTime = 0;
const List<String> _targetTimes = <String>[
  '무제한',
  '0:30',
  '1:00',
  '1:30',
  '2:00',
  '2:30',
  '3:00',
];
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<WorkoutPageStateStore>(create: (_) => WorkoutPageStateStore()),
      ChangeNotifierProvider<WorkoutInfo>(create: (_) => WorkoutInfo()),
    ],
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DinoBoard(),
          Divider(),
          RecordBoard(),
          Divider(),
          GameBoard(),
        ],
      )
    );
  }
}

class DinoBoard extends StatelessWidget {
  const DinoBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      width: double.infinity,
    );
  }
}
class RecordBoard extends StatelessWidget {
  const RecordBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(42, 0, 42, 0),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("통계",style: MyTextStyles.h1,),
          Flexible(
            child: Column(
              children: [
                Flexible(
                  child: Container(

                    child: Center(
                      child: Text("운동 기록 차트"),
                    ),
                  ),
                ),
                Divider(),
                Flexible(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        reportBox('시간','12:30',''),
                        reportBox('칼로리', '456','Kcal'),
                        reportBox('피한 장애물', '98','개'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(42, 0, 42, 0),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("게임",style: MyTextStyles.h1,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Container( //최고점수
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star),
                            Text("Best Score",style: MyTextStyles.h3,),
                          ],
                        ),
                        Text("1234",style: MyTextStyles.h1,),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Flexible(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("목표 칼로리 >",style: MyTextStyles.h3,),
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("300",style: MyTextStyles.h1,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text("Kcal",style: MyTextStyles.h1_sub,),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("목표 운동 시간 >",style: MyTextStyles.h3,),
                            //Text("10:00",style: MyTextStyles.h1,),
                            CutertinoBtn(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutPage()));
                      },
                    child: Container(
                        color: MyColors.yellow,
                        width: double.infinity,
                        height: double.infinity,
                        child: const Center(child: Text("지금 바로 시작!",style: MyTextStyles.h1,))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
void _showDialog(Widget child, BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6.0),
      // The Bottom margin is provided to align the popup above the system navigation bar.
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      // Provide a background color for the popup.
      color: CupertinoColors.systemBackground.resolveFrom(context),
      // Use a SafeArea widget to avoid system overlaps.
      child: SafeArea(
        top: false,
        child: child,
      ),
    ),
  );
}

class CutertinoBtn extends StatefulWidget {
  const CutertinoBtn({Key? key}) : super(key: key);

  @override
  State<CutertinoBtn> createState() => _CutertinoBtnState();
}

class _CutertinoBtnState extends State<CutertinoBtn> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      // Display a CupertinoPicker with list of fruits.
      onPressed: () => _showDialog(
        CupertinoPicker(
          magnification: 1.22,
          squeeze: 1.2,
          useMagnifier: false,
          itemExtent: _kItemExtent,
          // This sets the initial item.
          scrollController: FixedExtentScrollController(
            initialItem: _selectedTargetTime,
          ),
          // This is called when selected item is changed.
          onSelectedItemChanged: (int selectedItem) {
            setState(() {
              _selectedTargetTime = selectedItem;
            });
          },
          children:
          List<Widget>.generate(_targetTimes.length, (int index) {
            return Center(child: Text(_targetTimes[index]));
          }),
        ),
          context
      ),
      // This displays the selected fruit name.
      child: Text(
        _targetTimes[_selectedTargetTime],
        style: const TextStyle(
          fontSize: 22.0,
        ),
      ),
    );
  }
}


class reportBox extends StatelessWidget {
  reportBox(this.title, this.body,this.sub);

  String title;
  String body;
  String sub = '';
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,style: MyTextStyles.h3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(body,style: MyTextStyles.h1,),
              Text(sub,style: MyTextStyles.h1_sub,),
            ],
          )
        ],
      ),
    );
  }
}
