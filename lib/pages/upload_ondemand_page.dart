import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessmarketplace/pages/show_video_page.dart';

class OnDemandUploadPage extends StatefulWidget {
  OnDemandUploadPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OnDemandUploadPageState createState() => _OnDemandUploadPageState();
}

class _OnDemandUploadPageState extends State<OnDemandUploadPage> {
  final _picker = ImagePicker();
  File video;

  recordAndUploadVideo() async {
    await pickVideo();
    print('picked');
    uploadToFirebase();
  }

  pickVideo() async {
    PickedFile pickedVideo = await _picker.getVideo(source: ImageSource.camera);
    video = File(pickedVideo.path);
  }

  uploadToFirebase() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('videos/${Path.basename(video.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(video);
    await uploadTask.onComplete;
    String downloadUrl = await storageReference.getDownloadURL();
    print(downloadUrl);
    await Firestore.instance.collection('videos').add({'url': downloadUrl});
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: getVideos(),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            List<String> downloadUrls = snapshot.data;
            return Scaffold(
                body: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 10,),
                    RaisedButton(
                      child: Text('Record Video'),
                      onPressed: () {
                        recordAndUploadVideo();
                      },
                    ),
                    downloadUrls != null
                        ? Expanded(
                      child: ListView.builder(
                          itemCount: downloadUrls.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: EdgeInsets.all(12.0),
                              child: RaisedButton(
                                child: Text(i.toString()),
                                onPressed: () {
                                  print('URL' + downloadUrls[i]);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ShowVideoPage(videoDownloadUrl: downloadUrls[i],)),
                                  );
                                },
                              ),
                            );
                          }),
                    )
                        : SizedBox.shrink(),
                  ],
                ));
          }
        });
  }

  Future<List<String>> getVideos() async {
    List<String> downloadUrls = new List<String>();
    QuerySnapshot allVideos =
    await Firestore.instance.collection('videos').getDocuments();
    for (int i = 0; i < allVideos.documents.length; i++) {
      downloadUrls.add(allVideos.documents[i].data['url']);
    }
    return downloadUrls;
  }
}