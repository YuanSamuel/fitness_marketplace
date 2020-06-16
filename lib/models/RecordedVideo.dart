***REMOVED***

class RecordedVideo {
  String name;
  Timestamp date;
  String videoUrl;
  int students;

  DocumentReference reference;

  RecordedVideo({this.name, this.date, this.videoUrl, this.students, this.reference***REMOVED***);

  factory RecordedVideo.fromSnapshot(DocumentSnapshot snapshot) {
    RecordedVideo newRecordedVideo = RecordedVideo.fromJson(snapshot.data);
    newRecordedVideo.reference = snapshot.reference;
    return newRecordedVideo;
  ***REMOVED***

  factory RecordedVideo.fromJson(Map<String, dynamic> json) {
    return RecordedVideo(
      name: json['name'] as String,
      date: json['date'] as Timestamp,
      videoUrl: json['videoUrl'] as String,
      students: json['students'] as int,
***REMOVED***
  ***REMOVED***

  Map<String, dynamic> toJson() => _RecordedVideoToJson(this);

  Map<String, dynamic> _RecordedVideoToJson(RecordedVideo instance) {
    return <String, dynamic>{
      'name': instance.name,
      'date': instance.date,
      'videoUrl': instance.videoUrl,
      'students': instance.students,
    ***REMOVED***;
  ***REMOVED***
***REMOVED***
