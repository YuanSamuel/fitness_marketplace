import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
***REMOVED***
***REMOVED***
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../apis/encoding_provider.dart';
import '../apis/firebase_provider.dart';
import 'package:path/path.dart' as p;
import '../models/video_info.dart';
import 'player.dart';
import 'package:timeago/timeago.dart' as timeago;


class FfmpegVideosTestPage extends StatefulWidget {
  FfmpegVideosTestPage({Key key, this.title***REMOVED***) : super(key: key);

  final String title;

***REMOVED***
  _FfmpegVideosTestPageState createState() => _FfmpegVideosTestPageState();
***REMOVED***

class _FfmpegVideosTestPageState extends State<FfmpegVideosTestPage> {
  final thumbWidth = 100;
  final thumbHeight = 150;
  List<VideoInfo> _videos = <VideoInfo>[];
  bool _imagePickerActive = false;
  bool _processing = false;
  bool _canceled = false;
  double _progress = 0.0;
  //int _videoDuration = 0;
  String _processPhase = '';
  final bool _debugMode = false;

***REMOVED***
***REMOVED***
    FirebaseProvider.listenToVideos((newVideos) {
***REMOVED***
        _videos = newVideos;
      ***REMOVED***);
    ***REMOVED***);

    EncodingProvider.enableStatisticsCallback((int time,
        int size,
        double bitrate,
        double speed,
        int videoFrameNumber,
        double videoQuality,
        double videoFps) {
      if (_canceled) return;

***REMOVED***
        //_progress = time / _videoDuration;
      ***REMOVED***);
    ***REMOVED***);

***REMOVED***
  ***REMOVED***

  void _onUploadProgress(event) {
    if (event.type == StorageTaskEventType.progress) {
      final double progress =
          event.snapshot.bytesTransferred / event.snapshot.totalByteCount;
***REMOVED***
        _progress = progress;
      ***REMOVED***);
    ***REMOVED***
  ***REMOVED***

  Future<String> _uploadFile(filePath, folderName) async {
    final file = new File(filePath);
    final basename = p.basename(filePath);

    final StorageReference ref =
    FirebaseStorage.instance.ref().child(folderName).child(basename);
    StorageUploadTask uploadTask = ref.putFile(file);
    uploadTask.events.listen(_onUploadProgress);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String videoUrl = await taskSnapshot.ref.getDownloadURL();
    return videoUrl;
  ***REMOVED***

  String getFileExtension(String fileName) {
    final exploded = fileName.split('.');
    return exploded[exploded.length - 1];
  ***REMOVED***

  void _updatePlaylistUrls(File file, String videoName) {
    final lines = file.readAsLinesSync();
    var updatedLines = List<String>();

    for (final String line in lines) {
      var updatedLine = line;
      if (line.contains('.ts') || line.contains('.m3u8')) {
        updatedLine = '$videoName%2F$line?alt=media';
      ***REMOVED***
      updatedLines.add(updatedLine);
    ***REMOVED***
    final updatedContents =
    updatedLines.reduce((value, element) => value + '\n' + element);

    file.writeAsStringSync(updatedContents);
  ***REMOVED***

  Future<String> _uploadHLSFiles(dirPath, videoName) async {
    final videosDir = Directory(dirPath);

    var playlistUrl = '';

    final files = videosDir.listSync();
    int i = 1;
    for (FileSystemEntity file in files) {
      final fileName = p.basename(file.path);
      final fileExtension = getFileExtension(fileName);
      if (fileExtension == 'm3u8') _updatePlaylistUrls(file, videoName);

***REMOVED***
        _processPhase = 'Uploading video file $i out of ${files.length***REMOVED***';
        _progress = 0.0;
      ***REMOVED***);

      final downloadUrl = await _uploadFile(file.path, videoName);

      if (fileName == 'master.m3u8') {
        playlistUrl = downloadUrl;
      ***REMOVED***
      i++;
    ***REMOVED***

    return playlistUrl;
  ***REMOVED***

  Future<void> _processVideo(File rawVideoFile) async {

    print("PROCESSING VIDEO");
    final String rand = '${new Random().nextInt(10000)***REMOVED***';
    final videoName = 'video$rand';
    print("VIDEONAME "+videoName);
    final Directory extDir = await getApplicationDocumentsDirectory();
    final outDirPath = '${extDir.path***REMOVED***/Videos/$videoName';
    final videosDir = new Directory(outDirPath);

    print("GOT OUTPUT DIRECTORY");
    videosDir.createSync(recursive: true);

    final rawVideoPath = rawVideoFile.path;

    print("GOT PATH");
    //final info = await EncodingProvider.getMediaInformation(rawVideoPath);
    //final aspectRatio = EncodingProvider.getAspectRatio(info);

    setState(() {
      _processPhase = 'Generating thumbnail';
      //_videoDuration = EncodingProvider.getDuration(info);
      _progress = 0.0;
    ***REMOVED***);

    print("GETTING THUMBNAIL");
    final thumbFilePath =
    await EncodingProvider.getThumb(rawVideoPath, thumbWidth, thumbHeight);

    setState(() {
      _processPhase = 'Encoding video';
      _progress = 0.0;
    ***REMOVED***);

    print("ENCODING VIDEO FOR REAL");
    final encodedFilesDir =
    await EncodingProvider.encodeHLS(rawVideoPath, outDirPath);

    setState(() {
      _processPhase = 'Uploading thumbnail to firebase storage';
      _progress = 0.0;
    ***REMOVED***);
    final thumbUrl = await _uploadFile(thumbFilePath, 'thumbnail');
    final videoUrl = await _uploadHLSFiles(encodedFilesDir, videoName);

    final videoInfo = VideoInfo(
      videoUrl: videoUrl,
      thumbUrl: thumbUrl,
      coverUrl: thumbUrl,
      //aspectRatio: aspectRatio,
      uploadedAt: DateTime.now().millisecondsSinceEpoch,
      videoName: videoName,
***REMOVED***

    setState(() {
      _processPhase = 'Saving video metadata to cloud firestore';
      _progress = 0.0;
    ***REMOVED***);

    await FirebaseProvider.saveVideo(videoInfo, null, null, null, null);

    setState(() {
      _processPhase = '';
      _progress = 0.0;
      _processing = false;
    ***REMOVED***);
  ***REMOVED***

  void _takeVideo() async {
    var videoFile;

    print("TAKING VIDEO");
    if (_debugMode) {
      videoFile = File(
          '/storage/emulated/0/Android/data/com.learningsomethingnew.fluttervideo.flutter_video_sharing/files/Pictures/ebbafabc-dcbe-433b-93dd-80e7777ee4704451355941378265171.mp4');
    ***REMOVED*** else {
      if (_imagePickerActive) return;

      _imagePickerActive = true;
      videoFile = await ImagePicker.pickVideo(source: ImageSource.camera);
      _imagePickerActive = false;

      if (videoFile == null) return;
    ***REMOVED***
    setState(() {
      _processing = true;
    ***REMOVED***);

    try {
      await _processVideo(videoFile);
    ***REMOVED*** catch (e) {
      print('${e.toString()***REMOVED***');
    ***REMOVED*** finally {
***REMOVED***
        _processing = false;
      ***REMOVED***);
    ***REMOVED***
  ***REMOVED***

  _getListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _videos.length,
        itemBuilder: (BuildContext context, int index) {
          final video = _videos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Player(
                      video: video,
                ***REMOVED***
                  ***REMOVED***,
  ***REMOVED***,
          ***REMOVED***
            ***REMOVED***,
            child: Card(
              child: new Container(
                padding: new EdgeInsets.all(10.0),
                child: Stack(
  ***REMOVED***
      ***REMOVED***
          ***REMOVED***
      ***REMOVED***
                        Stack(
          ***REMOVED***
                            Container(
                              width: thumbWidth.toDouble(),
                              height: thumbHeight.toDouble(),
                              child: Center(child: CircularProgressIndicator()),
              ***REMOVED***,
                            ClipRRect(
                              borderRadius: new BorderRadius.circular(8.0),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: video.thumbUrl,
                ***REMOVED***,
              ***REMOVED***,
          ***REMOVED***
          ***REMOVED***,
                        Expanded(
                          child: Container(
                            margin: new EdgeInsets.only(left: 20.0),
                  ***REMOVED***
                  ***REMOVED***
                              mainAxisSize: MainAxisSize.max,
              ***REMOVED***
          ***REMOVED***"${video.videoName***REMOVED***"),
                                Container(
                                  margin: new EdgeInsets.only(top: 12.0),
              ***REMOVED***
                                      'Uploaded ${timeago.format(new DateTime.fromMillisecondsSinceEpoch(video.uploadedAt))***REMOVED***'),
                  ***REMOVED***,
              ***REMOVED***
              ***REMOVED***,
            ***REMOVED***,
          ***REMOVED***,
      ***REMOVED***
      ***REMOVED***,
  ***REMOVED***
  ***REMOVED***,
***REMOVED***,
***REMOVED***
      ***REMOVED***
        ***REMOVED***);
  ***REMOVED***

  _getProgressBar() {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 30.0),
            child: Text(_processPhase),
***REMOVED***
          LinearProgressIndicator(
            value: _progress,
***REMOVED***
        ],
***REMOVED***
***REMOVED***
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
      appBar: AppBar(
        title: Text("Hello"),
***REMOVED***
      body: Center(child: _processing ? _getProgressBar() : _getListView()),
      floatingActionButton: FloatingActionButton(
          child: _processing
              ? CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : Icon(Icons.add),
          onPressed: _takeVideo),
***REMOVED***
  ***REMOVED***
***REMOVED***