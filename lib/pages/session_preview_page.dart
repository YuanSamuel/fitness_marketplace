import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/animations/FadeAnimationDown.dart';
import 'package:fitnessmarketplace/models/Stream.dart';
import 'package:fitnessmarketplace/models/Student.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
import 'package:fitnessmarketplace/models/video_info.dart';
import 'package:fitnessmarketplace/pages/player.dart';
import 'package:fitnessmarketplace/widgets/trainer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class SessionPreview extends StatefulWidget {
  final Stream stream;
  final bool isStream;
  final Trainer trainer;
  final DocumentSnapshot video;
  final bool isPrivate;
  const SessionPreview({
    Key key,
    this.stream,
    this.isStream,
    this.video,
    this.trainer,
    this.isPrivate,
  }) : super(key: key);

  @override
  _SessionPreviewState createState() => _SessionPreviewState();
}

class _SessionPreviewState extends State<SessionPreview> {
  String trainer = "";
  int rating = 0;
  int comments = 0;
  Trainer t;
  String uid;
  Student currentStudent;

  var responseData;

  @override
  void initState() {
    super.initState();
    print("HELO");

    if (widget.isStream)
      getTrainerInfo();
    else {
      trainer = widget.trainer.firstName + " " + widget.trainer.lastName;
      rating = widget.trainer.rating.round();
    }
  }

  Future getTrainerInfo() async {
    print(widget.stream.title);
    print(widget.stream.trainer);
    print("TRAINER ID" + widget.stream.trainer);
    await Firestore.instance
        .collection("trainers")
        .document(widget.stream.trainer)
        .get()
        .then((value) {
      setState(() {
        trainer = value.data["firstName"] + " " + value.data["lastName"];
        rating = (value.data["rating"] + 0.0).round();
        print("TRAINER IS" + trainer);
        t = Trainer.fromSnapshot(value);
      });
    });
  }

  Future makeTransaction(BuildContext context) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    uid = user.uid;
    print('hello');

    //await _handleCameraAndMic();
    _pay();
  }

  void _pay() async {
    print('paying');
    InAppPayments.setSquareApplicationId(
        '***REMOVED***');
    DocumentSnapshot studentData =
    await Firestore.instance.collection('students').document(uid).get();
    currentStudent = Student.fromSnapshot(studentData);
    print('nonce' + currentStudent.paymentNonce);
    print('idempotencyKey' + currentStudent.idempotencyKey);
    if (currentStudent.paymentNonce == null ||  currentStudent.idempotencyKey == null || currentStudent.paymentNonce == '' || currentStudent.idempotencyKey == '') {
      InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _onCardNonceRequestSuccess,
        onCardEntryCancel: _onCardEntryCancel,
      );
    } else {
      print('else');
      await chargeCard(currentStudent.paymentNonce, currentStudent.idempotencyKey);
      print('charged');
      _cardEntryComplete();
    }
  }

  void _onCardEntryCancel() {
    print('hello');
  }

  void _onCardNonceRequestSuccess(CardDetails result) async {
    String idempotencyKey = Uuid().v4();
    currentStudent.reference.updateData({'paymentNonce': result.nonce, 'idempotencyKey': idempotencyKey});
    try {
      await chargeCard(result.nonce, idempotencyKey);
      InAppPayments.completeCardEntry(
        onCardEntryComplete: _cardEntryComplete,
      );
    } on Exception catch (ex) {
      InAppPayments.showCardNonceProcessingError(ex.toString());
    }
  }

  chargeCard(String nonce, String idempotency_key) async {
    double chargeAmt = 0;
    if (widget.isStream) {
      chargeAmt = widget.stream.price * 100;
    } else {
      chargeAmt = widget.video.data['price'] * 100;
    }
    var body = jsonEncode({
      'source_id': nonce,
      'idempotency_key': idempotency_key,
      'amount_money': {'amount': chargeAmt.floor(), 'currency': 'USD'}
    });
    http.Response response =
    await http.post('https://connect.squareupsandbox.com/v2/payments',
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
          'Bearer EAAAEA7IONxb8KpegRF2XdoRLsrwl_Y9LgwwXdA3IABBB8FG4--suTtuZ2C8PsrG'
        },
        body: body);
    print(response.body);
    responseData = jsonDecode(response.body);
  }

  void _cardEntryComplete() {
    print(widget.isStream);
    if (widget.isStream) {
      Firestore.instance
          .collection('students')
          .document(uid)
          .collection('streams')
          .add(widget.stream.toJson());
    } else {
      Firestore.instance
          .collection('students')
          .document(uid)
          .collection('videos')
          .add(widget.video.data);
    }

    Firestore.instance
        .collection('students')
        .document(uid)
        .collection('transactions')
        .add({
      'type': widget.isStream ? "stream" : "ondemand",
      'sessionID': widget.isStream
          ? widget.stream.reference.documentID
          : widget.video.documentID,
      'price':
      widget.isStream ? widget.stream.price : widget.video.data["price"],
      'trainer': widget.isStream
          ? widget.stream.trainer
          : widget.trainer.reference.documentID,
      'purchaseDate': DateTime.now().millisecondsSinceEpoch,
      'sessionDate': widget.isStream
          ? widget.stream.date
          : DateTime.now().millisecondsSinceEpoch,
      'paymentID': responseData['payment']['id'],
    });

    Firestore.instance
        .collection('trainers')
        .document(widget.isStream
        ? widget.stream.trainer
        : widget.trainer.reference.documentID)
        .collection("transactions")
        .add({
      'type': widget.isStream ? "stream" : "ondemand",
      'sessionID': widget.isStream
          ? widget.stream.reference.documentID
          : widget.video.documentID,
      'price':
      widget.isStream ? widget.stream.price : widget.video.data["price"],
      'trainer': widget.isStream
          ? widget.stream.trainer
          : widget.trainer.reference.documentID,
      'purchaseDate': DateTime.now().millisecondsSinceEpoch,
      'sessionDate': widget.isStream
          ? widget.stream.date
          : DateTime.now().millisecondsSinceEpoch,
      'paymentID': responseData['payment']['id'],
    });

    Navigator.pushReplacementNamed(context, '/userHome');
  }

  Future<void> _handleCameraAndMic() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: FadeAnimationDown(
          1,
          AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            flexibleSpace: Container(
              height: 600,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  image: DecorationImage(
                    image: widget.isStream
                        ? NetworkImage(
                      "https://cnet1.cbsistatic.com/img/sRejNDr7D67rMcvwI11v6xrJcho=/940x0/2019/11/12/e66cc0f3-c6b8-4f6e-9561-e23e08413ce1/gettyimages-1002863304.jpg",
                    )
                        : NetworkImage(widget.video.data["thumbUrl"]),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeAnimationDown(
                    1.2,
                    Text(
                      widget.isStream
                          ? widget.stream.title
                          : widget.video.data["title"],
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              FadeAnimationDown(
                1.4,
                Text("with " + trainer,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black54,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FadeAnimationDown(
                    1.6,
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: Colors.orange.shade700, size: 20),
                        Icon(Icons.star,
                            color: Colors.orange.shade700, size: 20),
                        Icon(Icons.star,
                            color: Colors.orange.shade700, size: 20),
                        Icon(Icons.star,
                            color: Colors.orange.shade700, size: 20),
                        Icon(Icons.star, color: Colors.grey, size: 20),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          rating.toString(),
                          style: TextStyle(
                              color: Colors.orange.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "25",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  FadeAnimationDown(
                      1.8,
                      OutlineButton(
                        highlightedBorderColor: Colors.redAccent,
                        splashColor: Colors.red.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        borderSide:
                        BorderSide(width: 2, color: Colors.red.shade300),
                        child: Text(
                          "View Trainer",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrainerWidget(
                                    trainer: t,
                                  )));
                          //do something, maybe open up trainer page
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              FadeAnimationDown(
                2,
                Divider(
                  thickness: 1.5,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              FadeAnimationDown(
                2.1,
                Text(
                  "About the session",
                  style: TextStyle(
                      color: Colors.red.withOpacity(0.8),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              FadeAnimationDown(
                2.2,
                Text(
                  widget.isStream
                      ? widget.stream.description
                      : widget.video.data["description"],
                  style:
                  TextStyle(color: Colors.grey, height: 1.5, fontSize: 14),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FadeAnimationDown(
                2.3,
                Divider(
                  thickness: 1.5,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FadeAnimationDown(
                    2.5,
                    Container(
                        child: Text(
                          "Cost: " +
                              (widget.isStream
                                  ? widget.stream.price.round()
                                  : widget.video.data["price"].round())
                                  .toString(),
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  FadeAnimationDown(
                    2.6,
                    ButtonTheme(
                      minWidth: 160,
                      height: 45,
                      child: FlatButton.icon(
                        onPressed: () {
                          makeTransaction(context);
                        },
                        icon: Icon(Icons.shopping_basket),
                        label: Text(
                          "PURCHASE",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
