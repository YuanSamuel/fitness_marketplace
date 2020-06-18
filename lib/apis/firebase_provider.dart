import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/models/video_info.dart';
import 'package:fitnessmarketplace/pages/login_page.dart';

class FirebaseProvider {
  static saveVideo(VideoInfo video, String title, String description, String minutes, int date, double price) async {
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
        'title':title,
        'price':price
      });

    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
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
      'title':title,
      'price':price
    });
  }

  static listenToVideos(callback) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;

    Firestore.instance.collection('trainers').document(uid).collection('videos').snapshots().listen((qs) {
      final videos = mapQueryToVideoInfo(qs);
      callback(videos);
    });
  }

  static mapQueryToVideoInfo(QuerySnapshot qs) {
    return qs.documents.map((DocumentSnapshot ds) {
      return VideoInfo(
        videoUrl: ds.data['videoUrl'],
        thumbUrl: ds.data['thumbUrl'],
        coverUrl: ds.data['coverUrl'],
        aspectRatio: ds.data['aspectRatio'],
        videoName: ds.data['videoName'],
        uploadedAt: ds.data['uploadedAt'],
      );
    }).toList();
  }
}