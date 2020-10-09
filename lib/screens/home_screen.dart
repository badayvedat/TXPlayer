import 'dart:io';

import 'package:TXPlayer/screens/videos_list_screen.dart';
import 'package:TXPlayer/widgets/folder_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Directory> _directories = List<Directory>();
  bool _isLoaded = false;

  @override
  void initState() {
    initPlatformState();
    initPermissionStates();
    super.initState();
  }

  //TODO check if needs permission for both internal and external storage
  // In case of only one exists what will happen?
  Future<void> initPermissionStates() async {
    Permission.storage.request().then((status) {
      if (status.isGranted) {
        setState(() {
          _isLoaded = true;
        });
      }
    });
  }

  Future<void> initPlatformState() async {
    List<StorageInfo> storageInfo;

    //TODO implement on error scope
    try {
      storageInfo = await PathProviderEx.getStorageInfo();
    } on PlatformException {}

    if (!mounted) return;

    setState(() {
      storageInfo.forEach((info) {
        _directories.add(Directory(info.rootDir));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Videos"),
      ),
      body: _isLoaded
          ? ListView(
              children: _directories
                  .map((directory) => FolderListTile(directory))
                  .toList(),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
