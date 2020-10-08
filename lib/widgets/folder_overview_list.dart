import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:TXPlayer/widgets/folder_list_tile.dart';

class FolderOverviewList extends StatelessWidget {
  final String path;

  FolderOverviewList(this.path);

  int getMediaFileCount(String path) {
    int count = 0;
    Directory(path).listSync(recursive: true).forEach((entity) {
      if (lookupMimeType(entity.path) == "video/mp4") {
        count++;
      }
    });
    return count;
  }

  @override
  Widget build(BuildContext context) {
    List<String> directories = List<String>();
    List<String> mediaFiles = List<String>();

    Directory(path).listSync().forEach((entity) {
      if (entity is Directory && getMediaFileCount(entity.path) > 0) {
        directories.add(entity.path);
      } else if (lookupMimeType(entity.path) == "video/mp4") {
        mediaFiles.add(entity.path);
      }
    });

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (directories.isNotEmpty)
            ...directories
                .map((directory) => FolderListTile(
                      Directory(directory),
                    ))
                .toList()
        ],
      ),
    );
  }
}
