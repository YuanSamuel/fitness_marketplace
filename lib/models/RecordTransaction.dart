import 'package:cloud_firestore/cloud_firestore.dart';

class RecordTransaction {
  int date;
  double price;
  String sessionID;
  String trainer;
  String type;

  DocumentReference reference;

  RecordTransaction({this.date, this.price, this.sessionID, this.trainer, this.type, this.reference});

  factory RecordTransaction.fromSnapshot(DocumentSnapshot snapshot) {
    RecordTransaction newTransaction = RecordTransaction.fromJson(snapshot.data);
    newTransaction.reference = snapshot.reference;
    return newTransaction;
  }

  factory RecordTransaction.fromJson(Map<String, dynamic> json) {
    return RecordTransaction(
      date: json['date'] as int,
      price: json['price'] as double,
      sessionID: json['sessionID'] as String,
      trainer: json['trainer'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() => _RecordTransactionToJson(this);

  Map<String, dynamic> _RecordTransactionToJson(RecordTransaction instance) {
    return <String, dynamic> {
      'date': instance.date,
      'price': instance.price,
      'sessionID': instance.sessionID,
      'trainer': instance.trainer,
      'type': instance.type,
    };
  }
}