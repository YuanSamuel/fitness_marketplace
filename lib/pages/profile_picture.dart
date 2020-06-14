import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {

  final _picker = new ImagePicker();
  String url;

  Upload(File image) async {
    FirebaseStorage _storage = FirebaseStorage();
    String filePath = 'images/${DateTime.now()}.png';
    StorageUploadTask _uploadTask = _storage.ref().child(filePath).putFile(image);
    await _uploadTask.onComplete;

    url = await _storage.ref().child(filePath).getDownloadURL();
    Firestore.instance.collection('users').document(userid).setData({
      'url':url,
    },merge: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => Scaffold(
                body: SizedBox(
                  width: MediaQuery.of(context).size.width-10,
                  child: Column(
                    children: [
                      FlatButton(
                        child: Text('From Camera'),
                        onPressed: () async {
                          PickedFile image = await _picker.getImage(source: ImageSource.camera);
                          Upload(File(image.path));
                        },
                      ),
                      FlatButton(
                        child: Text('From Device'),
                        onPressed: () async {
                          PickedFile image = await _picker.getImage(source: ImageSource.gallery);
                            Upload(File(image.path));
                        },
                      ),
                    ],
                  )
                )
              )
          );
        }
      ),
    );
  }
}
