import 'dart:io';

***REMOVED***
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
***REMOVED***
import 'package:fitnessmarketplace/pages/show_video_page.dart';

class OnDemandUploadPage extends StatefulWidget {
  OnDemandUploadPage({Key key, this.title***REMOVED***) : super(key: key);

  final String title;

***REMOVED***
  _OnDemandUploadPageState createState() => _OnDemandUploadPageState();
***REMOVED***

class _OnDemandUploadPageState extends State<OnDemandUploadPage> {
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
    setState(() {

    ***REMOVED***);
  ***REMOVED***

***REMOVED***
***REMOVED***
    return FutureBuilder<List<String>>(
        future: getVideos(),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
        ***REMOVED***
              body: Center(
                child: CircularProgressIndicator(),
***REMOVED***,
        ***REMOVED***
          ***REMOVED*** else {
            List<String> downloadUrls = snapshot.data;
        ***REMOVED***
                body: Column(
      ***REMOVED***
      ***REMOVED***height: MediaQuery.of(context).size.height / 10,),
                    RaisedButton(
  ***REMOVED***'Record Video'),
  ***REMOVED***
                        recordAndUploadVideo();
                      ***REMOVED***,
      ***REMOVED***,
                    downloadUrls != null
                        ? Expanded(
                      child: ListView.builder(
                          itemCount: downloadUrls.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: EdgeInsets.all(12.0),
                              child: RaisedButton(
            ***REMOVED***i.toString()),
            ***REMOVED***
                                  print('URL' + downloadUrls[i]);
            ***REMOVED***
          ***REMOVED***
          ***REMOVED***builder: (context) => ShowVideoPage(videoDownloadUrl: downloadUrls[i],)),
                              ***REMOVED***
                                ***REMOVED***,
                ***REMOVED***,
                        ***REMOVED***
                          ***REMOVED***),
      ***REMOVED***
                        : SizedBox.shrink(),
  ***REMOVED***
  ***REMOVED***);
          ***REMOVED***
        ***REMOVED***);
  ***REMOVED***

  Future<List<String>> getVideos() async {
    List<String> downloadUrls = new List<String>();
    QuerySnapshot allVideos =
    await Firestore.instance.collection('videos').getDocuments();
    for (int i = 0; i < allVideos.documents.length; i++) {
      downloadUrls.add(allVideos.documents[i].data['url']);
    ***REMOVED***
    return downloadUrls;
  ***REMOVED***
***REMOVED***