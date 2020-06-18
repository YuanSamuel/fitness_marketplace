***REMOVED***

class Student {

  String firstName;
  String lastName;
  String email;
***REMOVED***

  DocumentReference reference;

  Student({this.firstName, this.lastName, this.email, this.uid, this.reference***REMOVED***);

  factory Student.fromSnapshot(DocumentSnapshot snapshot) {
    Student newStudent = Student.fromJson(snapshot.data);
    newStudent.reference = snapshot.reference;
    return newStudent;
  ***REMOVED***

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      uid: json['uid'] as String,
***REMOVED***
  ***REMOVED***

  Map<String, dynamic> toJson() => _StudentToJson(this);

  Map<String, dynamic> _StudentToJson(Student instance) {
    return <String, dynamic> {
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'uid': instance.uid,
    ***REMOVED***;
  ***REMOVED***

***REMOVED***