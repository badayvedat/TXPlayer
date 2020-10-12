import 'package:TXPlayer/screens/video_screen.dart';
import 'package:TXPlayer/widgets/custom_tile.dart';
import 'package:flutter/material.dart';

class VideoListTile extends StatelessWidget {
  final String path;

  VideoListTile(this.path);

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

    return CustomTile(
      icon: Icon(
        Icons.video_label,
        size: deviceWidth * 0.18,
      ),
      trailingWidget: Expanded(
        child: Text(
          path.split('/').last,
          style: Theme.of(context).textTheme.bodyText1,
          softWrap: true,
        ),
      ),
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          VideoScreen.routeName,
          arguments: path,
        );
      },
    );

    /* return ListTile(
      contentPadding: EdgeInsetsDirectional.only(start: 9),
      leading: Icon(
        Icons.video_collection_rounded,
        size: 50,
      ),
      title: Text(
        path.split('/').last,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          VideoScreen.routeName,
          arguments: path,
        );
      },
    ); */
  }
}
