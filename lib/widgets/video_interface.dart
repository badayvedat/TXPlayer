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
  AnimationController _controller;
  Animation<double> _animation;
  Timer _timer;

  void _buildAnimations() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    // Fade out animation after some time
    _timer = Timer(
      Duration(milliseconds: 4000),
      () {
        _controller = AnimationController(
          duration: Duration(milliseconds: 250),
          vsync: this,
        );
        _animation = Tween(begin: 1.0, end: 0.0).animate(_controller);
        setState(() {
          _controller.forward();
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _buildAnimations();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          VideoNavigationBar(widget.videoName),
          VideoControlBar(widget.videoPlayerController),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }
}