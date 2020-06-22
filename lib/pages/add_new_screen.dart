import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/apis/firebase_provider.dart';
import 'package:fitnessmarketplace/models/video_info.dart';
import 'package:fitnessmarketplace/pages/trainer_navigation.dart';
import 'package:fitnessmarketplace/utils/style_constants.dart';
import 'package:fitnessmarketplace/widgets/customslider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  _AddNewRecordingState createState() => _AddNewRecordingState();
}

class _AddNewRecordingState extends State<AddNewRecording> {
  String dropdownValue = 'LiveStream';

  int date;

  TextEditingController namecontroller;
  TextEditingController descriptcontroller;
  TextEditingController minscontrolller;

  @override
  void initState() {
    // TODO: implement initState
    EncodingProvider.enableStatisticsCallback((int time,
        int size,
        double bitrate,
        double speed,
        int videoFrameNumber,
        double videoQuality,
        double videoFps) {
      if (_canceled) return;

      setState(() {
        //_progress = time / _videoDuration;
      });
    });
    date = DateTime.now().millisecondsSinceEpoch;
    namecontroller = new TextEditingController();
    descriptcontroller = new TextEditingController();
    minscontrolller = new TextEditingController();

    super.initState();
  }

  static saveStream(String title, String description, double minutes, int date,
      double price) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;

    await Firestore.instance.collection('streams').add({
      'minutes': minutes,
      'description': description,
      'date': date,
      'title': title,
      'price': price,
      'trainer': uid,
    });

    await Firestore.instance
        .collection('trainers')
        .document(uid)
        .collection("streams")
        .document()
        .setData({
      'minutes': minutes,
      'description': description,
      'date': date,
      'title': title,
      'price': price,
      'trainer': uid,
    });
  }

  double time = 0;
  double price = 0;

  Future addSession(BuildContext context) async {
    print("ATTEMPTED");
    if (dropdownValue == "LiveStream") {
      await saveStream(
          namecontroller.text.toString(),
          descriptcontroller.text.toString(),
          time * 105 + 5,
          date,
          price * 95 + 5);
    } else {
      await _takeVideo();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrainerNavigation()),
    );
  }

  double _duration = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: _processing
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Container(
                          //height: MediaQuery.of(context).size.height,
                          height: 1100,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.black, Colors.black87])),
                          child: Column(children: [
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                                SizedBox(width: 20),
                                Text(
                                  "Add a new session",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 32),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                                height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height /
                                    6,
                                width: 325.0,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
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
                                  ),
                                )),
                            SizedBox(
                              height: 20.0,
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      topRight: Radius.circular(50.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Session Type',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        width: 400.0,
                                        child: Center(
                                          child: DropdownButton<String>(
                                            dropdownColor: Colors.white,
                                            value: dropdownValue,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black,
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            style:
                                                TextStyle(color: Colors.black),
                                            underline: Container(
                                              height: 1,
                                              color: Colors.black,
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                dropdownValue = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'LiveStream',
                                              'Video Recording'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Session Title',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        width: 400.0,
                                        child: Center(
                                          child: TextFormField(
                                            controller: namecontroller,
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'OpenSans',
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(top: 14.0),
                                              hintText:
                                                  'Enter the session title',
                                              hintStyle: StyleConstants
                                                  .loginHintTextStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Description',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        width: 400.0,
                                        height: 200.0,
                                        child: Center(
                                          child: TextFormField(
                                            controller: descriptcontroller,
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'OpenSans',
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(top: 14.0),
                                              hintText:
                                                  'Enter the session description',
                                              hintStyle: StyleConstants
                                                  .loginHintTextStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Duration - ' +
                                                ((time * 115 + 5)).toString(),
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        width: 400.0,
                                        child: Center(
                                          child: Slider(
                                              value: time,
                                              onChanged: (value) {
                                                setState(() {
                                                  time = value;
                                                });
                                              }),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Price - ' +
                                                (price * 95 + 5).toString(),
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        width: 400.0,
                                        child: Center(
                                          child: Slider(
                                              value: price,
                                              onChanged: (value) {
                                                setState(() {
                                                  price = value;
                                                });
                                              }),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50.0,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color: Colors.black),
                                        child: IconButton(
                                          color: Colors.black,
                                          icon: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            addSession(context);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ])),
                    ],
                  )));
  }

  void updateDate(DateTime dt) {
    date = dt.millisecondsSinceEpoch;
  }

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
      setState(() {
        _progress = progress;
      });
    }
  }

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
  }

  String getFileExtension(String fileName) {
    final exploded = fileName.split('.');
    return exploded[exploded.length - 1];
  }

  void _updatePlaylistUrls(File file, String videoName) {
    final lines = file.readAsLinesSync();
    var updatedLines = List<String>();

    for (final String line in lines) {
      var updatedLine = line;
      if (line.contains('.ts') || line.contains('.m3u8')) {
        updatedLine = '$videoName%2F$line?alt=media';
      }
      updatedLines.add(updatedLine);
    }
    final updatedContents =
        updatedLines.reduce((value, element) => value + '\n' + element);

    file.writeAsStringSync(updatedContents);
  }

  Future<String> _uploadHLSFiles(dirPath, videoName) async {
    final videosDir = Directory(dirPath);

    var playlistUrl = '';

    final files = videosDir.listSync();
    int i = 1;
    for (FileSystemEntity file in files) {
      final fileName = p.basename(file.path);
      final fileExtension = getFileExtension(fileName);
      if (fileExtension == 'm3u8') _updatePlaylistUrls(file, videoName);

      setState(() {
        _processPhase = 'Uploading video file $i out of ${files.length}';
        _progress = 0.0;
      });

      final downloadUrl = await _uploadFile(file.path, videoName);

      if (fileName == 'master.m3u8') {
        playlistUrl = downloadUrl;
      }
      i++;
    }

    return playlistUrl;
  }

  Future<void> _processVideo(File rawVideoFile) async {
    print("PROCESSING VIDEO");
    final String rand = '${new Random().nextInt(10000)}';
    final videoName = 'video$rand';
    print("VIDEONAME " + videoName);
    final Directory extDir = await getApplicationDocumentsDirectory();
    final outDirPath = '${extDir.path}/Videos/$videoName';
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
    });

    print("GETTING THUMBNAIL");
    final thumbFilePath =
        await EncodingProvider.getThumb(rawVideoPath, thumbWidth, thumbHeight);

    setState(() {
      _processPhase = 'Encoding video';
      _progress = 0.0;
    });

    print("ENCODING VIDEO FOR REAL");
    final encodedFilesDir =
        await EncodingProvider.encodeHLS(rawVideoPath, outDirPath);

    setState(() {
      _processPhase = 'Uploading thumbnail to firebase storage';
      _progress = 0.0;
    });
    final thumbUrl = await _uploadFile(thumbFilePath, 'thumbnail');
    final videoUrl = await _uploadHLSFiles(encodedFilesDir, videoName);

    final videoInfo = VideoInfo(
      videoUrl: videoUrl,
      thumbUrl: thumbUrl,
      coverUrl: thumbUrl,
      //aspectRatio: aspectRatio,
      uploadedAt: DateTime.now().millisecondsSinceEpoch,
      videoName: videoName,
    );

    setState(() {
      _processPhase = 'Saving video metadata to cloud firestore';
      _progress = 0.0;
    });

    await FirebaseProvider.saveVideo(
        videoInfo,
        namecontroller.text.toString(),
        descriptcontroller.text.toString(),
        time * 105 + 5,
        date,
        price * 95 + 5);

    setState(() {
      _processPhase = '';
      _progress = 0.0;
      _processing = false;
    });
  }

  Future _takeVideo() async {
    var videoFile;

    print("TAKING VIDEO");
    if (_debugMode) {
      videoFile = File(
          '/storage/emulated/0/Android/data/com.learningsomethingnew.fluttervideo.flutter_video_sharing/files/Pictures/ebbafabc-dcbe-433b-93dd-80e7777ee4704451355941378265171.mp4');
    } else {
      if (_imagePickerActive) return;

      _imagePickerActive = true;
      videoFile = await ImagePicker.pickVideo(source: ImageSource.camera);
      _imagePickerActive = false;

      if (videoFile == null) return;
    }
    setState(() {
      _processing = true;
    });

    try {
      await _processVideo(videoFile);
    } catch (e) {
      print('${e.toString()}');
    } finally {
      setState(() {
        _processing = false;
      });
    }
  }
}
