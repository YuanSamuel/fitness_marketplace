import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
import 'package:fitnessmarketplace/helpers/string_helper.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/Stream.dart' as models;
import 'package:fitnessmarketplace/models/Student.dart';
import 'package:fitnessmarketplace/pages/session_preview_page.dart';
import 'package:flutter/material.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class RequestPrivateSessionPage extends StatefulWidget {
  RequestPrivateSessionPage({Key key, this.trainer}) : super(key: key);

  final Trainer trainer;

  @override
  _RequestPrivateSessionPageState createState() =>
      _RequestPrivateSessionPageState();
}

class _RequestPrivateSessionPageState extends State<RequestPrivateSessionPage> {
  Student currentStudent;
  CalendarController _calendarController;
  List<PrivateSession> privateSessionTimes;
  List<models.Stream> streamTimes;
  DateTime selectedDate;
  List<dynamic> events;
  PrivateSession selectedPrivateSession;
  var receivedData;

  CalendarHelper _calendarHelper;
  StringHelper _stringHelper;

  @override
  void initState() {
    _calendarController = new CalendarController();
    _calendarHelper = new CalendarHelper();
    _stringHelper = new StringHelper();
    events = new List<dynamic>();
    setUp();
    super.initState();
  }

  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  setUp() async {
    await getCurrentUser();
    await getAvailablePrivateSessionTimes();
    await getTrainerStreams();
    setState(() {});
  }

  getCurrentUser() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance
        .collection('students')
        .document(getUser.uid)
        .get();
    currentStudent = Student.fromSnapshot(userData);
  }

  getAvailablePrivateSessionTimes() async {
    privateSessionTimes = new List<PrivateSession>();
    QuerySnapshot allPrivateSessionsSnapshot = await widget.trainer.reference
        .collection('privateSessions')
        .getDocuments();
    List<DocumentSnapshot> allPrivateSessionsList =
        allPrivateSessionsSnapshot.documents;

    for (int i = 0; i < allPrivateSessionsList.length; i++) {
      PrivateSession currentPrivateSession =
      PrivateSession.fromSnapshot(allPrivateSessionsList[i]);
      if (currentPrivateSession.available) {
        privateSessionTimes.add(currentPrivateSession);
      }
    }
  }

  getTrainerStreams() async {
    streamTimes = new List<models.Stream>();
    QuerySnapshot streams =
    await widget.trainer.reference.collection('streams').getDocuments();
    List<DocumentSnapshot> streamSnapshots = streams.documents;
    for (int i = 0; i < streamSnapshots.length; i++) {
      streamTimes.add(models.Stream.fromSnapshot(streamSnapshots[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (privateSessionTimes == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            TableCalendar(
              calendarController: _calendarController,
              events: _calendarHelper.listToEventMap(
                  privateSessionTimes, streamTimes),
              onDaySelected: (DateTime date, List<dynamic> givenEvents) {
                setState(() {
                  events = givenEvents;
                });
              },
            ),
            Container(
              height: 200,
              child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (BuildContext context, int i) {
                    String trainerName = widget.trainer.firstName +
                        ' ' +
                        widget.trainer.lastName;

                    bool isStream = events[i] is models.Stream;

                    String length = isStream
                        ? _stringHelper
                        .intToLengthString(events[i].minutes.floor())
                        : _stringHelper.intToLengthString(events[i].length);

                    DateTime date =
                    DateTime.fromMillisecondsSinceEpoch(events[i].date)
                        .toLocal();

                    return GestureDetector(
                      onTap: () {
                        if (events[i] is models.Stream) {
                          print("STUFF SHOULD BE HAPPENING?");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SessionPreview(
                                  stream: events[i],
                                  isStream: true,
                                )),
                          );
                        } else {
                          selectedPrivateSession = events[i];
                          _pay();
                        }
                        //Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.blue,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          height: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 7 *
                                        MediaQuery.of(context).size.width /
                                        10,
                                    height: 40,
                                    child: isStream
                                        ? Text(
                                      events[i].title + ' - Live Class',
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                        : Text(
                                      'Private Session with: ' +
                                          trainerName,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    length,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    _stringHelper.dateTimeToDateString(date),
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    _stringHelper.dateTimeToTimeString(date),
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    }
  }

  void _pay() async {
    print('paying');
    InAppPayments.setSquareApplicationId(
        '***REMOVED***');
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
    double chargeAmt = widget.trainer.oneOnOnePrice * selectedPrivateSession.length / 60 * 100;
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
    receivedData = jsonDecode(response.body);
  }

  void _cardEntryComplete() {
    selectedPrivateSession.reference.updateData({
      'available': false,
      'studentName': currentStudent.firstName + ' ' + currentStudent.lastName
    });

    selectedPrivateSession.available = false;
    selectedPrivateSession.studentName =
        currentStudent.firstName + ' ' + currentStudent.lastName;
    currentStudent.reference
        .collection('privateSessions')
        .add(selectedPrivateSession.toJson());

    currentStudent.reference.collection('transactions').add({
      'type': "privateSession",
      'sessionID': selectedPrivateSession.reference.documentID,
      'price': widget.trainer.oneOnOnePrice,
      'trainer': widget.trainer.reference.documentID,
      'sessionDate': selectedPrivateSession.date,
      'purchaseDate': DateTime.now().millisecondsSinceEpoch,
      'paymentID': receivedData['payment']['id'],
    });

    widget.trainer.reference.collection("transactions").add({
      'type': "privateSession",
      'sessionID': selectedPrivateSession.reference.documentID,
      'price': widget.trainer.oneOnOnePrice,
      'trainer': widget.trainer.reference.documentID,
      'sessionDate': selectedPrivateSession.date,
      'purchaseDate': DateTime.now().millisecondsSinceEpoch,
      'paymentID': receivedData['payment']['id'],
    });

    Navigator.pop(context);
  }
}

