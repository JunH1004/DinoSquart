import 'package:camera/camera.dart';
import 'package:dino_squart_flutter/main_style.dart';
import 'package:dino_squart_flutter/ui/homepage.dart';
import 'package:dino_squart_flutter/workout_ui/workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
List<CameraDescription> cameras = [];

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<WorkoutPageStateStore>(create: (_) => WorkoutPageStateStore()),
      ChangeNotifierProvider<WorkoutInfo>(create: (_) => WorkoutInfo()),
      ChangeNotifierProvider<HompageDataStore>(create: (_) => HompageDataStore()),
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage()
    );
  }
}



