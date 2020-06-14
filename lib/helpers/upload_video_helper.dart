import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
***REMOVED***
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class UploadVideoHelper {
  final _picker = ImagePicker();
  File video;

  recordAndUploadVideo() async {
    await pickVideo();
    print('picked');
    uploadToFirebase();
  ***REMOVED***

  pickVideo() async {
    PickedFile pickedVideo = await _picker.getVideo(source: ImageSource.camera);
    video = File(pickedVideo.path);
  ***REMOVED***

  uploadToFirebase() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('videos/${Path.basename(video.path)***REMOVED***');
    StorageUploadTask uploadTask = storageReference.putFile(video);
    await uploadTask.onComplete;
    String downloadUrl = await storageReference.getDownloadURL();
    print(downloadUrl);
    await Firestore.instance.collection('videos').add({'url': downloadUrl***REMOVED***);
  ***REMOVED***
***REMOVED***
