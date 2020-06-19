***REMOVED***

class Stream {
  int date;
  double minutes;
  double price;
  String title;
  String description;

  DocumentReference reference;

  Stream({this.date, this.minutes, this.price, this.title, this.description***REMOVED***);

  factory Stream.fromSnapshot(DocumentSnapshot snapshot) {
    Stream newStream = Stream.fromJson(snapshot.data);
    newStream.reference = snapshot.reference;
    return newStream;
  ***REMOVED***

  factory Stream.fromJson(Map<String, dynamic> json) {
    return Stream(
      date: json['date'] as int,
      minutes: json['minutes'] as double,
      price: json['price'] as double,
      title: json['title'] as String,
      description: json['description'] as String,
***REMOVED***
  ***REMOVED***

  Map<String, dynamic> toJson() => _StreamToJson(this);

  Map<String, dynamic> _StreamToJson(Stream instance) {
    return <String, dynamic> {
      'date': instance.date,
      'minutes': instance.minutes,
      'price': instance.price,
      'title': instance.title,
      'description': instance.description,
    ***REMOVED***;
  ***REMOVED***
***REMOVED***