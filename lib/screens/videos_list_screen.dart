import 'package:flutter/material.dart';

class VideosListScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  _VideosListScreenState createState() => _VideosListScreenState();
}

class _VideosListScreenState extends State<VideosListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Videos"),
      ),
    );
  }
}
