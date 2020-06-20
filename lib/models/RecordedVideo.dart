import 'package:cloud_firestore/cloud_firestore.dart';

class RecordedVideo {
  String name;
  int date;
  String videoUrl;
  String videoID;

  DocumentReference reference;

  RecordedVideo({this.name, this.date, this.videoUrl, this.reference,});

  factory RecordedVideo.fromSnapshot(DocumentSnapshot snapshot) {
    RecordedVideo newRecordedVideo = RecordedVideo.fromJson(snapshot.data);
    newRecordedVideo.reference = snapshot.reference;
    return newRecordedVideo;
  }

  factory RecordedVideo.fromJson(Map<String, dynamic> json) {
    return RecordedVideo(
      name: json['title'] as String,
      date: json['date'] as int,
      videoUrl: json['thumbUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => _RecordedVideoToJson(this);

  Map<String, dynamic> _RecordedVideoToJson(RecordedVideo instance) {
    return <String, dynamic> {
      'name': instance.name,
      'date': instance.date,
      'thumbUrl': instance.videoUrl,
      'videoID': instance.videoID
    };
  }

}
