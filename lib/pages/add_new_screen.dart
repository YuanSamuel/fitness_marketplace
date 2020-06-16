import 'package:fitnessmarketplace/apis/firebase_provider.dart';
***REMOVED***
import 'package:fitnessmarketplace/pages/trainer_navigation.dart';
import 'package:fitnessmarketplace/utils/style_constants.dart';
***REMOVED***
***REMOVED***

import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../apis/encoding_provider.dart';
import '../apis/firebase_provider.dart';
import 'package:path/path.dart' as p;
import '../models/video_info.dart';


class AddNewRecording extends StatefulWidget {
***REMOVED***
  _AddNewRecordingState createState() => _AddNewRecordingState();
***REMOVED***

class _AddNewRecordingState extends State<AddNewRecording> {
  String dropdownValue = 'LiveStream';

  int date;


  TextEditingController namecontroller;
  TextEditingController descriptcontroller;
  TextEditingController minscontrolller;


***REMOVED***
***REMOVED***
    // TODO: implement initState
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

    namecontroller = new TextEditingController();
    descriptcontroller = new TextEditingController();
    minscontrolller = new TextEditingController();

***REMOVED***
  ***REMOVED***

  Future addSession(BuildContext context) async{
    if (dropdownValue=="LiveStream"){

    ***REMOVED***
***REMOVED***
      await _takeVideo();

    ***REMOVED***
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrainerNavigation()),
***REMOVED***
  ***REMOVED***


***REMOVED***
***REMOVED***
***REMOVED***
      body: _processing?Center(child: CircularProgressIndicator(),):Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.black87])),
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
  ***REMOVED***
  ***REMOVED***width: 10),
                IconButton(
                  onPressed: () {***REMOVED***,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
    ***REMOVED***
  ***REMOVED***,
  ***REMOVED***width: 20),
                Text(
                    "Add a new session",
***REMOVED***
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 32
    ***REMOVED***,
  ***REMOVED***,

  ***REMOVED***
***REMOVED***
            SizedBox(height: 20),
            Container(
  ***REMOVED***
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.grey[700],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 10.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
    ***REMOVED***
***REMOVED***
***REMOVED***,
              height: 500,
              width: 300,
    ***REMOVED***
    ***REMOVED***
    ***REMOVED***
                    mainAxisAlignment: MainAxisAlignment.center,
        ***REMOVED***
***REMOVED***"Session Type:",
  ***REMOVED***
***REMOVED***
                        fontStyle: FontStyle.italic
        ***REMOVED***,),
***REMOVED***width: 20),
                      DropdownButton<String>(
                        dropdownColor: Colors.grey,
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward,
                        color: Colors.black,),
                        iconSize: 24,
                        elevation: 16,
    ***REMOVED***color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
          ***REMOVED***,
                        onChanged: (String newValue) {
                    ***REMOVED***
                            dropdownValue = newValue;
                          ***REMOVED***);
                        ***REMOVED***,
                        items: <String>['LiveStream', 'Video Recording']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
        ***REMOVED***value),
                      ***REMOVED***
                        ***REMOVED***).toList(),
        ***REMOVED***,
    ***REMOVED***
    ***REMOVED***,



                  Container(
                      height: MediaQuery.of(context).copyWith().size.height / 6,
          ***REMOVED***
                        color: Colors.grey,
        ***REMOVED***,
                      child: CupertinoDatePicker(
                        backgroundColor: Colors.white,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: updateDate,
                        use24hFormat: false,
                        maximumDate: new DateTime(2050, 12, 30),
                        minimumYear: 2010,
                        maximumYear: 2030,
                        minuteInterval: 1,
                        mode: CupertinoDatePickerMode.dateAndTime,
        ***REMOVED***),

                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: StyleConstants.loginBoxDecorationStyle,
                    height: 60.0,
                    child: TextFormField(
                      controller: namecontroller,
                      keyboardType: TextInputType.text,
  ***REMOVED***
                        color: Colors.black,
                        fontFamily: 'OpenSans',
        ***REMOVED***,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),

                        hintText: 'Enter the session title',
                        hintStyle: StyleConstants.loginHintTextStyle,
        ***REMOVED***,
      ***REMOVED***,
    ***REMOVED***,
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: StyleConstants.loginBoxDecorationStyle,
                    height: 60.0,
                    child: TextFormField(
                      controller: descriptcontroller,
                      keyboardType: TextInputType.text,
  ***REMOVED***
                        color: Colors.black,
                        fontFamily: 'OpenSans',
        ***REMOVED***,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),

                        hintText: 'Enter the session description',
                        hintStyle: StyleConstants.loginHintTextStyle,
        ***REMOVED***,
      ***REMOVED***,
    ***REMOVED***,
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: StyleConstants.loginBoxDecorationStyle,
                    height: 60.0,
                    child: TextFormField(
                      controller: minscontrolller,
                      keyboardType: TextInputType.number,
  ***REMOVED***
                        color: Colors.black,
                        fontFamily: 'OpenSans',
        ***REMOVED***,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),

                        hintText: 'Roughly how many minutes will it last?',
                        hintStyle: StyleConstants.loginHintTextStyle,
        ***REMOVED***,
      ***REMOVED***,
    ***REMOVED***,
***REMOVED***
***REMOVED***,



***REMOVED***
            SizedBox(height: 40),
            SizedBox(
              height: 60,
              width: 120,
              child: FloatingActionButton(
                elevation: 20,
                child: Container(
                  child: dropdownValue=="Video Recording"?Text("Continue",
***REMOVED***
                    fontSize: 18
    ***REMOVED***,):Text("Submit",
***REMOVED***
                        fontSize: 18
      ***REMOVED***,),
  ***REMOVED***,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
  ***REMOVED***,
                onPressed: (){
                  addSession(context);
                ***REMOVED***,
***REMOVED***,
            )
          ],
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

  void updateDate(DateTime dt) {
    date = dt.millisecondsSinceEpoch;
  ***REMOVED***


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

    await FirebaseProvider.saveVideo(videoInfo, namecontroller.text.toString(), descriptcontroller.text.toString(), minscontrolller.text.toString(), date);

    setState(() {
      _processPhase = '';
      _progress = 0.0;
      _processing = false;
    ***REMOVED***);
  ***REMOVED***

  Future _takeVideo() async {
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




***REMOVED***
