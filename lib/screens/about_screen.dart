import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = "/about-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
          splashRadius: Material.defaultSplashRadius * 2 / 3,
        ),
      ),
      body: Center(
        child: Container(
          child: Text("About"),
        ),
      ),
    );
  }
}
