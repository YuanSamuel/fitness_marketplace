***REMOVED***

class OneOnOneSession {
  String name;
  String studentUid;
  int length;
  Timestamp date;

  DocumentReference reference;

  OneOnOneSession({this.name, this.studentUid, this.length, this.date, this.reference***REMOVED***);

  factory OneOnOneSession.fromSnapshot(DocumentSnapshot snapshot) {
    OneOnOneSession newOneOnOneSession = OneOnOneSession.fromJson(snapshot.data);
    newOneOnOneSession.reference = snapshot.reference;
    return newOneOnOneSession;
  ***REMOVED***

  factory OneOnOneSession.fromJson(Map<String, dynamic> json) {
    return OneOnOneSession(
      name: json['name'] as String,
      studentUid: json['studentUid'] as String,
      length: json['length'] as int,
      date: json['date'] as Timestamp,
***REMOVED***
  ***REMOVED***

  Map<String, dynamic> toJson() => _OneOnOneSessionToJson(this);

  _OneOnOneSessionToJson(OneOnOneSession instance) {
    return <String, dynamic>{
      'name': instance.name,
      'studentUid': instance.studentUid,
      'length': instance.length,
      'date': instance.date
    ***REMOVED***;
  ***REMOVED***

***REMOVED***