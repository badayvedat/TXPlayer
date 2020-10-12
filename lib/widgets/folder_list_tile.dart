import 'dart:io';

import 'package:TXPlayer/screens/videos_list_screen.dart';
import 'package:TXPlayer/widgets/custom_tile.dart';
import 'package:flutter/material.dart';

class FolderListTile extends StatelessWidget {
  final Directory dir;

  FolderListTile(this.dir);

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return CustomTile(
      icon: Icon(
        Icons.folder,
        size: deviceWidth * 0.18,
        color: Theme.of(context).iconTheme.color,
      ),
      trailingWidget: Text(
        dir.path.split('/').last,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (ctx, animation1, animation2) =>
              VideosListScreen(dir.path),
        ),
      ),
    );
  }
}
