import 'dart:io';

import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Function onTap;
  final Icon icon;
  final Widget trailingWidget;

  CustomTile({@required this.icon, @required this.trailingWidget, this.onTap});

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          width: deviceWidth,
          child: Row(
            children: <Widget>[
              icon,
              SizedBox(
                width: deviceWidth * 0.025,
              ),
              trailingWidget,
            ],
          ),
        ),
      ),
    );
  }
}
