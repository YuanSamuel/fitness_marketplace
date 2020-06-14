import 'package:cloud_firestore/cloud_firestore.dart';

class RecordedVideo {
  String name;
  Timestamp date;
  String videoUrl;

  DocumentReference reference;

  RecordedVideo({this.name, this.date, this.videoUrl});

  factory RecordedVideo.fromSnapshot(DocumentSnapshot snapshot) {
    RecordedVideo newRecordedVideo = RecordedVideo.fromJson(snapshot.data);
    newRecordedVideo.reference = snapshot.reference;
    return newRecordedVideo;
  }

  factory RecordedVideo.fromJson(Map<String, dynamic> json) {
    return RecordedVideo(
      name: json['name'] as String,
      date: json['date'] as Timestamp,
      videoUrl: json['videoUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => _RecordedVideoToJson(this);

  Map<String, dynamic> _RecordedVideoToJson(RecordedVideo instance) {
    return <String, dynamic>{
      'name': instance.name,
      'date': instance.date,
      'videoUrl': instance.videoUrl,
    };
  }
}
