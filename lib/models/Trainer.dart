import 'package:cloud_firestore/cloud_firestore.dart';

class Trainer {
  String firstName;
  String lastName;
  String email;
  double rating;

  DocumentReference reference;

  Trainer(
      {this.firstName, this.lastName, this.email, this.rating, this.reference});

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
      rating: json['rating'] as double,
    );
  }

  Map<String, dynamic> toJson() => _TrainerToJson(this);

  Map<String, dynamic> _TrainerToJson(Trainer instance) {
    return <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'rating': instance.rating,
    };
  }
}
