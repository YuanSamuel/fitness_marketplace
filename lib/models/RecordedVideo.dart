***REMOVED***

class RecordedVideo {
  String name;
  int date;
  String videoUrl;
  String videoID;

  DocumentReference reference;

  RecordedVideo({this.name, this.date, this.videoUrl, this.reference,***REMOVED***);

  factory RecordedVideo.fromSnapshot(DocumentSnapshot snapshot) {
    RecordedVideo newRecordedVideo = RecordedVideo.fromJson(snapshot.data);
    newRecordedVideo.reference = snapshot.reference;
    return newRecordedVideo;
  ***REMOVED***

  factory RecordedVideo.fromJson(Map<String, dynamic> json) {
    return RecordedVideo(
      name: json['title'] as String,
      date: json['date'] as int,
      videoUrl: json['thumbUrl'] as String,
***REMOVED***
  ***REMOVED***

  Map<String, dynamic> toJson() => _RecordedVideoToJson(this);

  Map<String, dynamic> _RecordedVideoToJson(RecordedVideo instance) {
    return <String, dynamic> {
      'name': instance.name,
      'date': instance.date,
      'thumbUrl': instance.videoUrl,
      'videoID': instance.videoID
    ***REMOVED***;
  ***REMOVED***

***REMOVED***
