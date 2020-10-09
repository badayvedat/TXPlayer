import 'dart:io';

import 'package:TXPlayer/widgets/video_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:TXPlayer/widgets/folder_list_tile.dart';

class FolderOverviewList extends StatelessWidget {
  final String path;

  FolderOverviewList(this.path);

  int getMediaFileCount(String path) {
    int count = 0;
    // TODO replace this workaround with something more logical
    try {
      Directory(path).listSync(recursive: true).forEach((entity) {
        if (lookupMimeType(entity.path) == "video/mp4") {
          count++;
        }
      });
    } catch (on) {}
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (directories.isNotEmpty)
            Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: Text(
                "Folders",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ...directories.map((directory) => FolderListTile(
                Directory(directory),
              )),
          if (mediaFiles.isNotEmpty)
            Container(
              margin: directories.isEmpty
                  ? EdgeInsets.symmetric(vertical: 4, horizontal: 10)
                  : EdgeInsets.only(
                      top: 25,
                      bottom: 4,
                      left: 10,
                      right: 10,
                    ),
              child: Text(
                "Videos",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ...mediaFiles.map((filePath) => VideoListTile(filePath)),
        ],
      ),
    );
  }
}
