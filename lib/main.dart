import 'package:flutter/material.dart';
import 'package:today_news/routes/routes.dart';
import 'package:today_news/screen/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Today News',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
      onGenerateRoute: (settings) => Routes.generateRoutes(settings),
    );
  }
}
