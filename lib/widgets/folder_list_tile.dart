import 'dart:io';

import 'package:flutter/material.dart';

class FolderListTile extends StatelessWidget {
  final Directory dir;

  FolderListTile(this.dir);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.folder,
        size: 70,
      ),
      title: Text(dir.path.split('/').last),
    );
  }
}
