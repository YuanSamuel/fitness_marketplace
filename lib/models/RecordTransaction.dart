import 'package:cloud_firestore/cloud_firestore.dart';

class RecordTransaction {
  int purchaseDate;
  int sessionDate;
  double price;
  String sessionID;
  String trainer;
  String type;
  String paymentID;

  DocumentReference reference;

  RecordTransaction(
      {this.purchaseDate,
      this.sessionDate,
      this.price,
      this.sessionID,
      this.trainer,
      this.type,
      this.paymentID,
      this.reference});

  factory RecordTransaction.fromSnapshot(DocumentSnapshot snapshot) {
    RecordTransaction newTransaction =
        RecordTransaction.fromJson(snapshot.data);
    newTransaction.reference = snapshot.reference;
    return newTransaction;
  }

  factory RecordTransaction.fromJson(Map<String, dynamic> json) {
    return RecordTransaction(
      purchaseDate: json['purchaseDate'] as int,
      sessionDate: json['sessionDate'] as int,
      price: json['price'] as double,
      sessionID: json['sessionID'] as String,
      trainer: json['trainer'] as String,
      type: json['type'] as String,
      paymentID: json['paymentID'] as String,
    );
  }

  Map<String, dynamic> toJson() => _RecordTransactionToJson(this);

  Map<String, dynamic> _RecordTransactionToJson(RecordTransaction instance) {
    return <String, dynamic>{
      'purchaseDate': instance.purchaseDate,
      'sessionDate': instance.sessionDate,
      'price': instance.price,
      'sessionID': instance.sessionID,
      'trainer': instance.trainer,
      'type': instance.type,
      'paymentID': instance.paymentID,
    };
  }
}
