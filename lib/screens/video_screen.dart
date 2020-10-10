import 'dart:async';
import 'dart:io';

import 'package:TXPlayer/widgets/video_interface.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  static const routeName = "/video-screen";
  final String mediaFilePath;

  VideoScreen({
    Key key,
    @required this.mediaFilePath,
  }) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController _controller;
  bool isInitialized = false;
  bool isTapped = false;
  Timer timer;

  @override
  void initState() {
    // Set orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // Disable status bar and bottom bar
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller = VideoPlayerController.file(File(widget.mediaFilePath))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          isInitialized = true;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: !isInitialized
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                GestureDetector(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        // Timer will be used to sync dispose of VideoInterface and it's fade out animation
                        if (isTapped) {
                          isTapped = false;
                          timer?.cancel();
                        } else {
                          isTapped = true;
                          timer = Timer(Duration(milliseconds: 4500), () {
                            if (isTapped) {
                              setState(() {
                                isTapped = false;
                              });
                            }
                          });
                        }
                      });
                    }),
                if (isTapped)
                  VideoInterface(
                    videoName: widget.mediaFilePath.split('/').last,
                    videoPlayerController: _controller,
                  ),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  padding: EdgeInsets.only(top: 10.0),
                ),
              ],
            ),
    );
  }
}
