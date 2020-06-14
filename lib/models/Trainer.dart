import 'package:cloud_firestore/cloud_firestore.dart';

class Trainer {
  String firstName;
  String lastName;
  String email;
  String profileUrl;
  double rating;
  List trainingTypes;

  DocumentReference reference;

  Trainer(
      {this.firstName, this.lastName, this.email, this.profileUrl, this.rating, this.trainingTypes, this.reference});

  factory Trainer.fromSnapshot(DocumentSnapshot snapshot) {
    Trainer newTrainer = Trainer.fromJson(snapshot.data);
    newTrainer.reference = snapshot.reference;
    return newTrainer;
  }

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      profileUrl: json['profileUrl'] as String,
      rating: json['rating'] as double,
      trainingTypes: json['trainingTypes'] as List,
    );
  }

  Map<String, dynamic> toJson() => _TrainerToJson(this);

  Map<String, dynamic> _TrainerToJson(Trainer instance) {
    return <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'profileUrl': instance.profileUrl,
      'rating': instance.rating,
      'trainingTypes': instance.trainingTypes,
    };
  }
}
