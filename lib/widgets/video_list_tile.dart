import 'package:TXPlayer/screens/video_screen.dart';
import 'package:flutter/material.dart';

class VideoListTile extends StatelessWidget {
  final String path;

  VideoListTile(this.path);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsetsDirectional.only(start: 9),
      leading: Icon(
        Icons.video_collection_rounded,
        size: 50,
      ),
      title: Text(path.split('/').last),
      // TODO implement onTap
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          VideoScreen.routeName,
          arguments: path,
        );
      },
    );
  }
}
