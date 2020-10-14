import 'package:TXPlayer/screens/about_screen.dart';
import 'package:TXPlayer/widgets/drawer_item.dart';
import 'package:TXPlayer/widgets/preferred_languages_dialog.dart';
import 'package:flutter/material.dart';

class HomeScreenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidht = MediaQuery.of(context).size.width;

    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            Container(
              height: deviceHeight * 0.16,
              width: deviceWidht,
              padding: EdgeInsets.only(left: 20, bottom: 20),
              alignment: Alignment.bottomLeft,
              color: Theme.of(context).appBarTheme.color,
              child: Row(
                children: [
                  Icon(
                    Icons.slow_motion_video_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "TX",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    "PLAYER",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                DrawerItem(
                  bodyText: "Subtitle Language",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => PreferredLanguagesDialog(),
                    );
                  },
                ),
                DrawerItem(
                  bodyText: "About",
                  onTap: () {
                    Navigator.of(context).pushNamed(AboutScreen.routeName);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
