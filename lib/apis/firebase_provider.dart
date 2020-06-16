***REMOVED***
***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/pages/login_page.dart';

class FirebaseProvider {
  static saveVideo(VideoInfo video, String title, String description, String minutes, int date) async {
    await Firestore.instance.collection('videos').document().setData({
        'videoUrl': video.videoUrl,
        'thumbUrl': video.thumbUrl,
        'coverUrl': video.coverUrl,
        'aspectRatio': video.aspectRatio,
        'uploadedAt': video.uploadedAt,
        'videoName': video.videoName,
        'minutes':minutes,
        'description':description,
        'date':date,
        'title':title
      ***REMOVED***);

***REMOVED***
    final uid = user.uid;


    await Firestore.instance.collection('trainers').document(uid).collection("videos").document().setData({
      'videoUrl': video.videoUrl,
      'thumbUrl': video.thumbUrl,
      'coverUrl': video.coverUrl,
      'aspectRatio': video.aspectRatio,
      'uploadedAt': video.uploadedAt,
      'videoName': video.videoName,
      'minutes':minutes,
      'description':description,
      'date':date,
      'title':title
    ***REMOVED***);
  ***REMOVED***

  static listenToVideos(callback) async {
***REMOVED***
    final uid = user.uid;

    Firestore.instance.collection('trainers').document(uid).collection('videos').snapshots().listen((qs) {
      final videos = mapQueryToVideoInfo(qs);
      callback(videos);
    ***REMOVED***);
  ***REMOVED***

  static mapQueryToVideoInfo(QuerySnapshot qs) {
    return qs.documents.map((DocumentSnapshot ds) {
      return VideoInfo(
        videoUrl: ds.data['videoUrl'],
        thumbUrl: ds.data['thumbUrl'],
        coverUrl: ds.data['coverUrl'],
        aspectRatio: ds.data['aspectRatio'],
        videoName: ds.data['videoName'],
        uploadedAt: ds.data['uploadedAt'],
  ***REMOVED***
    ***REMOVED***).toList();
  ***REMOVED***
***REMOVED***