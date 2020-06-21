***REMOVED***

class RecordedVideo {
  String name;
  int uploadedAt;
  String videoUrl;
  String videoID;

  DocumentReference reference;

  RecordedVideo({this.name, this.uploadedAt, this.videoUrl, this.reference,***REMOVED***);

  factory RecordedVideo.fromSnapshot(DocumentSnapshot snapshot) {
    RecordedVideo newRecordedVideo = RecordedVideo.fromJson(snapshot.data);
    newRecordedVideo.reference = snapshot.reference;
    return newRecordedVideo;
  ***REMOVED***

  factory RecordedVideo.fromJson(Map<String, dynamic> json) {
    return RecordedVideo(
      name: json['title'] as String,
      uploadedAt: json['uploadedAt'] as int,
      videoUrl: json['thumbUrl'] as String,
***REMOVED***
  ***REMOVED***

  Map<String, dynamic> toJson() => _RecordedVideoToJson(this);

  Map<String, dynamic> _RecordedVideoToJson(RecordedVideo instance) {
    return <String, dynamic> {
      'name': instance.name,
      'uploadedAt': instance.uploadedAt,
      'thumbUrl': instance.videoUrl,
      'videoID': instance.videoID
    ***REMOVED***;
  ***REMOVED***

***REMOVED***
