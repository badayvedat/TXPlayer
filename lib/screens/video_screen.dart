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
  bool _controllerWasPlaying = false;
  bool _isDragging = false;

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

  String _formatDuration(Duration d) =>
      d.toString().split('.').first.padLeft(8, "0");

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
    void seekToRelativePosition(Offset globalPosition, double xDiff) {
      final RenderBox box = context.findRenderObject();
      final Offset tapPos = box.globalToLocal(globalPosition);
      final double relative = tapPos.dx / box.size.width;
      final Duration posDiff = _controller.value.duration * relative;
      if (xDiff > 0) {
        _controller.seekTo(_controller.value.position + posDiff * 0.01);
      } else {
        _controller.seekTo(_controller.value.position - posDiff * 0.01);
      }
      //_controller.seekTo(posDiff);
    }

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
                  },
                  onHorizontalDragStart: (DragStartDetails details) {
                    if (!_controller.value.initialized) {
                      return;
                    }
                    _controllerWasPlaying = _controller.value.isPlaying;
                    if (_controllerWasPlaying) {
                      _controller.pause();
                    }
                    setState(() {
                      _isDragging = true;
                    });
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    if (!_controller.value.initialized) {
                      return;
                    }
                    seekToRelativePosition(
                        details.globalPosition, details.primaryDelta);
                    setState(() {});
                  },
                  onHorizontalDragEnd: (DragEndDetails details) {
                    if (_controllerWasPlaying) {
                      _controller.play();
                    }
                    setState(() {
                      _isDragging = false;
                    });
                  },
                ),
                if (_isDragging)
                  Center(
                    child: Text(
                      _formatDuration(_controller.value.position),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(fontSize: 50),
                    ),
                  ),
                if (isTapped)
                  VideoInterface(
                    videoName: widget.mediaFilePath.split('/').last,
                    videoPlayerController: _controller,
                  ),
              ],
            ),
    );
  }
}
