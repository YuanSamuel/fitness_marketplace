import 'package:cloud_firestore/cloud_firestore.dart';

class PrivateSession {
  String name;
  String studentUid;
  String trainerName;
  String photoUrl;
  bool available;
  int length;
  Timestamp date;

  DocumentReference reference;

  PrivateSession({this.name, this.studentUid, this.trainerName, this.photoUrl, this.available, this.length, this.date, this.reference});

  factory PrivateSession.fromSnapshot(DocumentSnapshot snapshot) {
    PrivateSession newPrivateSession = PrivateSession.fromJson(snapshot.data);
    newPrivateSession.reference = snapshot.reference;
    return newPrivateSession;
  }

  factory PrivateSession.fromJson(Map<String, dynamic> json) {
    return PrivateSession(
      name: json['name'] as String,
      studentUid: json['studentUid'] as String,
      trainerName: json['trainerName'] as String,
      photoUrl: json['photoUrl'] as String,
      available: json['available'] as bool,
      length: json['length'] as int,
      date: json['date'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => _PrivateSessionToJson(this);

  _PrivateSessionToJson(PrivateSession instance) {
    return <String, dynamic>{
      'name': instance.name,
      'studentUid': instance.studentUid,
      'trainerName': instance.trainerName,
      'photoUrl': instance.photoUrl,
      'available': instance.available,
      'length': instance.length,
      'date': instance.date
    };
  }

}