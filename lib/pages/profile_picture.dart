import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/pages/trainer_navigation.dart';
import 'package:fitnessmarketplace/pages/user_navigation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final _picker = new ImagePicker();
  FirebaseUser currentUser;
  String url;
  bool isTrainer;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userSnapshot = await Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .get();
    setState(() {
      isTrainer = userSnapshot.data['isTrainer'];
    });
  }

  Upload(File image) async {
    FirebaseStorage _storage = FirebaseStorage();
    String filePath = 'images/${DateTime.now()}.png';
    StorageUploadTask _uploadTask =
        _storage.ref().child(filePath).putFile(image);
    await _uploadTask.onComplete;
    url = await _storage.ref().child(filePath).getDownloadURL();

    if (isTrainer) {
      await Firestore.instance
          .collection('trainers')
          .document(currentUser.uid)
          .updateData({
        'profileUrl': url,
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TrainerNavigation()),
      );
    } else {
      await Firestore.instance
          .collection('students')
          .document(currentUser.uid)
          .updateData({
        'profileUrl': url,
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserNavigation()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    PickedFile image = new PickedFile('');

    if (currentUser == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Text('Choose a Profile Picture', style: TextStyle(fontSize: 30),),
            Image.asset(image.path),
            SizedBox(
              height: 100,
            ),
            Center(
              child: IconButton(
                  icon: Icon(Icons.add_a_photo),
                  iconSize: 100,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => Scaffold(
                            body: SizedBox(
                                width: MediaQuery.of(context).size.width - 10,
                                child: Column(
                                  children: [
                                    FlatButton(
                                      child: Text('From Camera'),
                                      onPressed: () async {
                                        image = await _picker.getImage(
                                            source: ImageSource.camera, imageQuality: 50);
                                        Upload(File(image.path));
                                        ProfilePic();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('From Device'),
                                      onPressed: () async {
                                        PickedFile image = await _picker.getImage(
                                            source: ImageSource.gallery, imageQuality: 50);
                                        Upload(File(image.path));
                                        ProfilePic();
                                      },
                                    ),
                                  ],
                                ))));
                  }
              ),
            )
          ],
        ),
      );
    }
  }
}
