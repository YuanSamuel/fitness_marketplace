import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVideoPage extends StatefulWidget {
  ShowVideoPage({Key key, this.videoDownloadUrl}) : super(key: key);

  final String videoDownloadUrl;

  @override
  _ShowVideoPageState createState() => _ShowVideoPageState();
}

class _ShowVideoPageState extends State<ShowVideoPage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoDownloadUrl)
      ..initialize().then((value) {
        _controller.setLooping(false);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _controller.value.initialized
              ? Padding(
                  padding: EdgeInsets.all(10.0),
                  child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: GestureDetector(
                          child: VideoPlayer(_controller),
                          onTap: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          })),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
