import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class VideoControlBar extends StatefulWidget {
  final VideoPlayerController _videoPlayerController;

  VideoControlBar(this._videoPlayerController);

  @override
  _VideoControlBarState createState() => _VideoControlBarState();
}

class _VideoControlBarState extends State<VideoControlBar> {
  VideoPlayerValue get playerValue => widget._videoPlayerController.value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.20,
      color: Colors.black45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.1,
            ),
            child: IconButton(
                icon: Icon(
                  playerValue.isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height * 0.15,
                ),
                onPressed: () {
                  setState(() {
                    playerValue.isPlaying
                        ? widget._videoPlayerController.pause()
                        : widget._videoPlayerController.play();
                  });
                }),
          ),
        ],
      ),
    );
  }
}
