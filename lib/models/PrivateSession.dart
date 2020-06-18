***REMOVED***

class PrivateSession {
  String name;
  String studentName;
  String trainerName;
  String photoUrl;
  bool available;
  int length;
  int date;

  DocumentReference reference;

  PrivateSession({this.name, this.studentName, this.trainerName, this.photoUrl, this.available, this.length, this.date, this.reference***REMOVED***);

  factory PrivateSession.fromSnapshot(DocumentSnapshot snapshot) {
    PrivateSession newPrivateSession = PrivateSession.fromJson(snapshot.data);
    newPrivateSession.reference = snapshot.reference;
    return newPrivateSession;
  ***REMOVED***

  factory PrivateSession.fromJson(Map<String, dynamic> json) {
    return PrivateSession(
      name: json['name'] as String,
      studentName: json['studentName'] as String,
      trainerName: json['trainerName'] as String,
      photoUrl: json['photoUrl'] as String,
      available: json['available'] as bool,
      length: json['length'] as int,
      date: json['date'] as int,
***REMOVED***
  ***REMOVED***

  Map<String, dynamic> toJson() => _PrivateSessionToJson(this);

  _PrivateSessionToJson(PrivateSession instance) {
    return <String, dynamic>{
      'name': instance.name,
      'studentName': instance.studentName,
      'trainerName': instance.trainerName,
      'photoUrl': instance.photoUrl,
      'available': instance.available,
      'length': instance.length,
      'date': instance.date
    ***REMOVED***;
  ***REMOVED***

***REMOVED***