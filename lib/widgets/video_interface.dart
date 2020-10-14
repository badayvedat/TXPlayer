import 'dart:async';

import 'package:TXPlayer/widgets/video_control_bar.dart';
import 'package:TXPlayer/widgets/video_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoInterface extends StatefulWidget {
  final String videoName;
  final VideoPlayerController videoPlayerController;

  VideoInterface({
    this.videoName,
    this.videoPlayerController,
  });

  @override
  _VideoInterfaceState createState() => _VideoInterfaceState();
}

class _VideoInterfaceState extends State<VideoInterface>
    with TickerProviderStateMixin {
  _VideoInterfaceState() {
    _listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  AnimationController _animationController;
  Animation<double> _animation;
  Timer _timer;
  VoidCallback _listener;

  void _buildAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();

    // Fade out animation after some time
    _timer = Timer(
      Duration(milliseconds: 4000),
      () {
        _animationController = AnimationController(
          duration: Duration(milliseconds: 250),
          vsync: this,
        );
        _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController);
        setState(() {
          _animationController.forward();
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _buildAnimations();
    _animationController.forward();
    widget.videoPlayerController.addListener(_listener);
  }

  String _formatDuration(Duration d) =>
      d.toString().split('.').first.padLeft(8, "0");

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return FadeTransition(
      opacity: _animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          VideoNavigationBar(widget.videoName),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5),
                  height: deviceHeight * 0.055,
                  width: deviceWidth,
                  color: Colors.black45,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: deviceWidth * 0.1,
                        child: Text(
                          _formatDuration(
                              widget.videoPlayerController.value.position),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: deviceWidth * 0.8,
                        child: VideoProgressIndicator(
                          widget.videoPlayerController,
                          allowScrubbing: true,
                          colors: VideoProgressColors(playedColor: Colors.blue),
                        ),
                      ),
                      Container(
                        width: deviceWidth * 0.1,
                        child: Text(
                          _formatDuration(
                              widget.videoPlayerController.value.duration),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                VideoControlBar(widget.videoPlayerController),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.videoPlayerController.removeListener(_listener);
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }
}
