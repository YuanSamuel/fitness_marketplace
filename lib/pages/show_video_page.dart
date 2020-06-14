***REMOVED***
import 'package:video_player/video_player.dart';

class ShowVideoPage extends StatefulWidget {
  ShowVideoPage({Key key, this.videoDownloadUrl***REMOVED***) : super(key: key);

  final String videoDownloadUrl;

***REMOVED***
  _ShowVideoPageState createState() => _ShowVideoPageState();
***REMOVED***

class _ShowVideoPageState extends State<ShowVideoPage> {
  VideoPlayerController _controller;

***REMOVED***
***REMOVED***
***REMOVED***
    _controller = VideoPlayerController.network(widget.videoDownloadUrl)
      ..initialize().then((value) {
        _controller.setLooping(false);
  ***REMOVED******REMOVED***);
      ***REMOVED***);
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
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
                      ***REMOVED***
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            ***REMOVED***);
                          ***REMOVED***)),
  ***REMOVED***
              : SizedBox.shrink(),
        ],
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
