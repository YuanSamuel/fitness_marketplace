import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class UploadVideoHelper {
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
  }
}
