import 'dart:async';
import 'dart:io';

***REMOVED***
import 'package:flutter_video_compress/flutter_video_compress.dart';

import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:video_player/video_player.dart';
import 'my-theme.dart';

void main() => runApp(VideoCompressTestPage(title: 'Flutter Video Compress Example'));

class VideoCompressTestPage extends StatefulWidget {
  VideoCompressTestPage({this.title***REMOVED***);

  final String title;

***REMOVED***
  _VideoCompressTestPageState createState() => _VideoCompressTestPageState();
***REMOVED***

class _VideoCompressTestPageState extends State<VideoCompressTestPage> {
  final _flutterVideoCompress = FlutterVideoCompress();
  Subscription _subscription;

  Image _thumbnailFileImage;
  Image _gifFileImage;

  MediaInfo _originalVideoInfo = MediaInfo(path: '');
  MediaInfo _compressedVideoInfo = MediaInfo(path: '');
  String _taskName;
  double _progressState = 0;

  final _loadingStreamCtrl = StreamController<bool>.broadcast();

***REMOVED***
***REMOVED***
***REMOVED***
    _subscription =
        _flutterVideoCompress.compressProgress$.subscribe((progress) {
    ***REMOVED***
            _progressState = progress;
          ***REMOVED***);
        ***REMOVED***);
  ***REMOVED***

***REMOVED***
  void dispose() {
    super.dispose();
    _subscription.unsubscribe();
    _loadingStreamCtrl.close();
  ***REMOVED***

  Future<void> runFlutterVideoCompressMethods(File videoFile) async {
    _loadingStreamCtrl.sink.add(true);

    var _startDateTime = DateTime.now();
    print('[Compressing Video] start');
    _taskName = '[Compressing Video]';
    final compressedVideoInfo = await _flutterVideoCompress.compressVideo(
      videoFile.path,
      quality: VideoQuality.DefaultQuality,
      deleteOrigin: false,
***REMOVED***
    _taskName = null;
    print(
        '[Compressing Video] done! ${DateTime.now().difference(_startDateTime).inSeconds***REMOVED***s');

    _startDateTime = DateTime.now();

    print('[Getting Thumbnail File] start');
    final thumbnailFile = await _flutterVideoCompress
        .getThumbnailWithFile(videoFile.path, quality: 50);
    print(
        '[Getting Thumbnail File] done! ${DateTime.now().difference(_startDateTime).inSeconds***REMOVED***s');

    _startDateTime = DateTime.now();
    print('[Getting Gif File] start');
    _taskName = '[Getting Gif File]';
    final gifFile = await _flutterVideoCompress
        .convertVideoToGif(videoFile.path, startTime: 0, duration: 5);
    print(
        '[Getting Gif File] done! ${DateTime.now().difference(_startDateTime).inSeconds***REMOVED***s');
    _taskName = null;

    final videoInfo = await _flutterVideoCompress.getMediaInfo(videoFile.path);

    setState(() {
      _thumbnailFileImage = Image.file(thumbnailFile);
      _gifFileImage = Image.file(gifFile);
      _originalVideoInfo = videoInfo;
      _compressedVideoInfo = compressedVideoInfo;
    ***REMOVED***);
    _loadingStreamCtrl.sink.add(false);
  ***REMOVED***

  Widget _buildMaterialWarp(Widget body) {
    return MaterialApp(
      title: widget.title,
      theme: myTheme,
      home: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: <Widget>[
              IconButton(
                onPressed: () async {
                  await _flutterVideoCompress.deleteAllCache();
                ***REMOVED***,
                icon: Icon(Icons.delete_forever),
***REMOVED***,
***REMOVED***
***REMOVED***
          body: body),
***REMOVED***
  ***REMOVED***

  Widget _buildRoundedRectangleButton(String text, ImageSource source) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Text(text, style: TextStyle(color: Colors.white)),
        color: Colors.grey[800],
        onPressed: () async {
          final videoFile = await ImagePicker.pickVideo(source: source);
          if (videoFile != null) {
            runFlutterVideoCompressMethods(videoFile);
          ***REMOVED***
        ***REMOVED***,
***REMOVED***
***REMOVED***
  ***REMOVED***

  String _infoConvert(MediaInfo info) {
    return 'path: ${info.path***REMOVED***\n'
        'duration: ${info.duration***REMOVED*** microseconds\n'
        'size: ${info.filesize***REMOVED*** bytes\n'
        'size: ${info.width***REMOVED*** x ${info.height***REMOVED***\n'
        'orientation: ${info.orientation***REMOVED***°\n'
        'compression cancelled: ${info.isCancel***REMOVED***\n'
        'author: ${info.author***REMOVED***';
  ***REMOVED***

  List<Widget> _buildInfoPanel(String title,
      {MediaInfo info, Image image, bool isVideoModel = false***REMOVED***) {
    if (info?.file == null && image == null && !isVideoModel) return [];
    return [
      if (!isVideoModel || info?.file != null)
        Card(
          child: ListTile(
            title: Text(title),
            dense: true,
***REMOVED***
***REMOVED***
      if (info?.file != null)
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(_infoConvert(info)),
***REMOVED***
      if (image != null) image,
      if (isVideoModel && info?.file != null) VideoPlayerView(file: info.file)
    ];
  ***REMOVED***

***REMOVED***
  Widget build(context) {
    return _buildMaterialWarp(
      Stack(children: <Widget>[
        ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            _buildRoundedRectangleButton(
              'Take video from camera with Image Picker',
              ImageSource.camera,
***REMOVED***
            _buildRoundedRectangleButton(
              'Take video from gallery with Image Picker',
              ImageSource.gallery,
***REMOVED***
            ..._buildInfoPanel(
              'Original video information',
              info: _originalVideoInfo,
***REMOVED***
            ..._buildInfoPanel(
              'Original video view',
              info: _originalVideoInfo,
              isVideoModel: true,
***REMOVED***
            ..._buildInfoPanel(
              'Compressed video information',
              info: _compressedVideoInfo,
***REMOVED***
            ..._buildInfoPanel(
              'Compressed video view',
              info: _compressedVideoInfo,
              isVideoModel: true,
***REMOVED***
            ..._buildInfoPanel(
              'Thumbnail image from file preview',
              image: _thumbnailFileImage,
***REMOVED***
            ..._buildInfoPanel(
              'Gif image from original video preview',
              image: _gifFileImage,
***REMOVED***
          ].expand((widget) {
            if (widget is SizedBox || widget is Card) {
              return [widget];
            ***REMOVED***
            return [widget, const SizedBox(height: 8)];
          ***REMOVED***).toList(),
***REMOVED***
        StreamBuilder<bool>(
          stream: _loadingStreamCtrl.stream,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return GestureDetector(
                onTap: () {
                  _flutterVideoCompress.cancelCompression();
                ***REMOVED***,
                child: Card(
                  child: Container(
***REMOVED***
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
          ***REMOVED***
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
          ***REMOVED***
                        CircularProgressIndicator(),
                        if (_taskName != null)
                          Padding(
                            padding: const EdgeInsets.all(8),
        ***REMOVED***'[$_taskName] $_progressState％'),
            ***REMOVED***,
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: const Text('click cancel...'),
          ***REMOVED***
      ***REMOVED***
      ***REMOVED***,
    ***REMOVED***,
  ***REMOVED***,
          ***REMOVED***
            ***REMOVED***
            return Container();
          ***REMOVED***,
***REMOVED***
      ]),
***REMOVED***
  ***REMOVED***
***REMOVED***

class VideoPlayerView extends StatefulWidget {
  VideoPlayerView({this.file***REMOVED***);

  final File file;

***REMOVED***
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
***REMOVED***

class _VideoPlayerViewState extends State<VideoPlayerView> {
  VideoPlayerController _controller;

***REMOVED***
***REMOVED***
***REMOVED***
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
  ***REMOVED******REMOVED***);
      ***REMOVED***)
      ..setVolume(1)
      ..play();
  ***REMOVED***

***REMOVED***
  void dispose() {
    super.dispose();
    _controller.dispose();
  ***REMOVED***

***REMOVED***
  Widget build(context) {
    return GestureDetector(
      onTap: () {
  ***REMOVED***
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
        ***REMOVED***);
      ***REMOVED***,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _controller.value.initialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
  ***REMOVED***
                    : Container(),
                Icon(
                  _controller.value.isPlaying ? null : Icons.play_arrow,
                  size: 80,
  ***REMOVED***,
  ***REMOVED***
***REMOVED***
            VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: Color.fromRGBO(255, 255, 255, 0.1),
***REMOVED***,
***REMOVED***
          ],
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***