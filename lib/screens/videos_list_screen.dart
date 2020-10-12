import 'package:TXPlayer/widgets/folder_overview_list.dart';
import 'package:flutter/material.dart';

class VideosListScreen extends StatefulWidget {
  final String path;

  VideosListScreen(this.path);

  @override
  _VideosListScreenState createState() => _VideosListScreenState();
}

class _VideosListScreenState extends State<VideosListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.path.split('/').last),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
          splashRadius: Material.defaultSplashRadius * 2 / 3,
        ),
      ),
      body: FolderOverviewList(widget.path),
    );
  }
}
