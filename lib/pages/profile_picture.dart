import 'dart:io';

***REMOVED***
import 'package:fitnessmarketplace/pages/trainer_navigation.dart';
import 'package:fitnessmarketplace/pages/user_navigation.dart';
***REMOVED***
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
***REMOVED***

class ProfilePic extends StatefulWidget {
***REMOVED***
  _ProfilePicState createState() => _ProfilePicState();
***REMOVED***

class _ProfilePicState extends State<ProfilePic> {
  final _picker = new ImagePicker();
  FirebaseUser currentUser;
  String url;
  bool isTrainer;

***REMOVED***
***REMOVED***
    getUserData();
***REMOVED***
  ***REMOVED***

  getUserData() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userSnapshot = await Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .get();
    setState(() {
      isTrainer = userSnapshot.data['isTrainer'];
    ***REMOVED***);
  ***REMOVED***

  Upload(File image) async {
    FirebaseStorage _storage = FirebaseStorage();
    String filePath = 'images/${DateTime.now()***REMOVED***.png';
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
      ***REMOVED***);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TrainerNavigation()),
  ***REMOVED***
    ***REMOVED*** else {
      await Firestore.instance
          .collection('students')
          .document(currentUser.uid)
          .updateData({
        'profileUrl': url,
      ***REMOVED***);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserNavigation()),
  ***REMOVED***
    ***REMOVED***
  ***REMOVED***

***REMOVED***
***REMOVED***

    PickedFile image = new PickedFile('');

    if (currentUser == null) {
  ***REMOVED***
        body: Center(
          child: CircularProgressIndicator(),
***REMOVED***
  ***REMOVED***
    ***REMOVED*** else {
  ***REMOVED***
        body: Column(
          children: [
            SizedBox(
              height: 70,
***REMOVED***
            Text('Choose a Profile Picture', style: TextStyle(fontSize: 30),),
            Image.asset(image.path),
            SizedBox(
              height: 100,
***REMOVED***
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
                      ***REMOVED***
                      ***REMOVED***
                                    FlatButton(
                  ***REMOVED***'From Camera'),
                                      onPressed: () async {
                                        image = await _picker.getImage(
                                            source: ImageSource.camera, imageQuality: 50);
                                        Upload(File(image.path));
                                        ProfilePic();
                                      ***REMOVED***,
                      ***REMOVED***,
                                    FlatButton(
                  ***REMOVED***'From Device'),
                                      onPressed: () async {
                                        PickedFile image = await _picker.getImage(
                                            source: ImageSource.gallery, imageQuality: 50);
                                        Upload(File(image.path));
                                        ProfilePic();
                                      ***REMOVED***,
                      ***REMOVED***,
                  ***REMOVED***
                  ***REMOVED***)));
                  ***REMOVED***
***REMOVED***,
            )
          ],
***REMOVED***
  ***REMOVED***
    ***REMOVED***
  ***REMOVED***
***REMOVED***
