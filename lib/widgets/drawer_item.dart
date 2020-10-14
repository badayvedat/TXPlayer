import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String bodyText;
  final Function onTap;

  DrawerItem({
    @required this.bodyText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.width;
    var deviceWidth = MediaQuery.of(context).size.height;

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(deviceWidth * 0.025),
        alignment: Alignment.centerLeft,
        height: deviceHeight * 0.05,
        width: double.infinity,
        child: Text(
          bodyText,
          style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 17),
          textAlign: TextAlign.left,
        ),
      ),
      onTap: onTap,
    );
  }
}
