import 'package:flutter/material.dart';

class VideoNavigationBar extends StatelessWidget {
  final String videoName;

  VideoNavigationBar(this.videoName);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      color: Colors.black12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            splashRadius: 1,
            iconSize: MediaQuery.of(context).size.height * 0.075,
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.height * 0.05,
          ),
          Expanded(
            flex: 1,
            child: Text(
              videoName,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.050,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
