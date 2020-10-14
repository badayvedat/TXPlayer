import 'package:TXPlayer/screens/about_screen.dart';
import 'package:TXPlayer/screens/home_screen.dart';
import 'package:TXPlayer/screens/video_screen.dart';
import 'package:TXPlayer/shared/shared_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(28, 41, 57, 1),
      systemNavigationBarColor: Color.fromRGBO(22, 25, 30, 1),
    ),
  );
  runApp(MyApp());
  SharedManager.init();
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
          headline1: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          headline2: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 20,
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        VideoScreen.routeName: (context) => VideoScreen(
              mediaFilePath: ModalRoute.of(context).settings.arguments,
            ),
        AboutScreen.routeName: (context) => AboutScreen(),
      },
    );
  }
}
