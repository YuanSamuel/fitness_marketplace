import 'dart:io';

***REMOVED***
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
***REMOVED***
import 'register.dart';

class ProfilePic extends StatefulWidget {
***REMOVED***
  _ProfilePicState createState() => _ProfilePicState();
***REMOVED***

class _ProfilePicState extends State<ProfilePic> {

  final _picker = new ImagePicker();
  String url;

  Upload(File image) async {
    FirebaseStorage _storage = FirebaseStorage();
    String filePath = 'images/${DateTime.now()***REMOVED***.png';
    StorageUploadTask _uploadTask = _storage.ref().child(filePath).putFile(image);
    await _uploadTask.onComplete;

    url = await _storage.ref().child(filePath).getDownloadURL();
    Firestore.instance.collection('users').document(userid).setData({
      'url':url,
    ***REMOVED***,merge: true);
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => Scaffold(
                body: SizedBox(
                  width: MediaQuery.of(context).size.width-10,
        ***REMOVED***
        ***REMOVED***
                      FlatButton(
    ***REMOVED***'From Camera'),
                        onPressed: () async {
                          PickedFile image = await _picker.getImage(source: ImageSource.camera);
                          Upload(File(image.path));
                        ***REMOVED***,
        ***REMOVED***,
                      FlatButton(
    ***REMOVED***'From Device'),
                        onPressed: () async {
                          PickedFile image = await _picker.getImage(source: ImageSource.gallery);
                            Upload(File(image.path));
                        ***REMOVED***,
        ***REMOVED***,
    ***REMOVED***
    ***REMOVED***
  ***REMOVED***
***REMOVED***
      ***REMOVED***
        ***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
