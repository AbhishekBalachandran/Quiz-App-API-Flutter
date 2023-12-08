import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_api/controller/quiz_controller/quiz_controller.dart';
import 'package:quiz_app_api/view/splash_screen/splash_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuizController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent)),
        home: SplashScreen(),
      ),
    );
  }
}
