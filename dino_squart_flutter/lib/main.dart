import 'package:camera/camera.dart';
import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
List<CameraDescription> cameras = [];
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
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
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<WorkoutPageStateStore>(create: (_) => WorkoutPageStateStore()),
          ChangeNotifierProvider<WorkoutInfo>(create: (_) => WorkoutInfo()),
        ],
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      height: 250,
    );
  }
}
class RecordBoard extends StatelessWidget {
  const RecordBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(42, 0, 42, 0),
      color: Colors.green,
      height: 450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("통계",style: MyTextStyles.h1,),
          Flexible(
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
                Flexible(
                  child: Container(
                    color: Colors.greenAccent,
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
class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(42, 0, 42, 0),
      height: 450,
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
                            Text("10:00",style: MyTextStyles.h1,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: (){print("onTap()");},
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


