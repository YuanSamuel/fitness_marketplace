***REMOVED***

class Trainer {
  String firstName;
  String lastName;
  String email;
  double rating;
  List trainingTypes;

  DocumentReference reference;

  Trainer(
      {this.firstName, this.lastName, this.email, this.rating, this.trainingTypes, this.reference***REMOVED***);

  factory Trainer.fromSnapshot(DocumentSnapshot snapshot) {
    Trainer newTrainer = Trainer.fromJson(snapshot.data);
    newTrainer.reference = snapshot.reference;
    return newTrainer;
  ***REMOVED***

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      rating: json['rating'] as double,
      trainingTypes: json['trainingTypes'] as List,
***REMOVED***
  ***REMOVED***

  Map<String, dynamic> toJson() => _TrainerToJson(this);

  Map<String, dynamic> _TrainerToJson(Trainer instance) {
    return <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'rating': instance.rating,
      'trainingTypes': instance.trainingTypes,
    ***REMOVED***;
  ***REMOVED***
***REMOVED***
