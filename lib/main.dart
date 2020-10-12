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
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(28, 41, 57, 1),
        ),
        iconTheme: IconThemeData(color: Color.fromRGBO(68, 76, 86, 1)),
        scaffoldBackgroundColor: Color.fromRGBO(22, 32, 42, 1),
        textTheme: TextTheme(
          bodyText1:
              TextStyle(color: Color.fromRGBO(193, 199, 207, 1), fontSize: 17),
          headline6: TextStyle(color: Color.fromRGBO(218, 221, 228, 1)),
        ),
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
