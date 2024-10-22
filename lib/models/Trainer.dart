import 'package:cloud_firestore/cloud_firestore.dart';

class Trainer {
  String firstName;
  String lastName;
  String email;
  String profileUrl;
  String description;
  String cardNonce;
  double rating;
  double videoPrice;
  double livePrice;
  double oneOnOnePrice;
  List trainingTypes;
  String uid;

  DocumentReference reference;

  Trainer(
      {this.firstName,
      this.lastName,
      this.email,
      this.profileUrl,
      this.description,
      this.cardNonce,
      this.rating,
      this.videoPrice,
      this.livePrice,
      this.oneOnOnePrice,
      this.trainingTypes,
      this.uid,
      this.reference});

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
      description: json['description'] as String,
      cardNonce: json['cardNonce'] as String,
      rating: (json['rating'] + 0.0) as double,
      videoPrice: (json['videoPrice'] + 0.0) as double,
      livePrice: (json['livePrice'] + 0.0) as double,
      oneOnOnePrice: (json['oneOnOnePrice'] + 0.0) as double,
      trainingTypes: json['trainingTypes'] as List,
      uid: json['uid'] as String,
    );
  }

  Map<String, dynamic> toJson() => _TrainerToJson(this);

  Map<String, dynamic> _TrainerToJson(Trainer instance) {
    return <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'profileUrl': instance.profileUrl,
      'description': instance.description,
      'cardNonce': instance.cardNonce,
      'rating': instance.rating,
      'videoPrice': instance.videoPrice,
      'livePrice': instance.videoPrice,
      'oneOnOnePrice': instance.oneOnOnePrice,
      'trainingTypes': instance.trainingTypes,
      'uid': instance.uid,
    };
  }
}
