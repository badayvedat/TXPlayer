import 'package:TXPlayer/screens/home_screen.dart';
import 'package:TXPlayer/screens/video_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TX Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        VideoScreen.routeName: (context) => VideoScreen(
              mediaFilePath: ModalRoute.of(context).settings.arguments,
            ),
      },
    );
  }
}
