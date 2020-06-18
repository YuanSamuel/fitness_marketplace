import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/Student.dart';
import 'package:flutter/material.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
import 'package:table_calendar/table_calendar.dart';

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
  DateTime selectedDate;
  List<dynamic> events;

  CalendarHelper _calendarHelper;

  @override
  void initState() {
    _calendarController = new CalendarController();
    _calendarHelper = new CalendarHelper();
    events = new List<PrivateSession>();
    getAvailablePrivateSessionTimes();
    super.initState();
  }

  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  setUp() async {
    await getCurrentUser();
    await getAvailablePrivateSessionTimes();
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
    setState(() {});
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
              events: _calendarHelper
                  .privateSessionsToEventMap(privateSessionTimes),
              onDaySelected: (DateTime date, List<dynamic> givenEvents) {
                events = givenEvents;
                setState(() {});
              },
            ),
            Container(
              height: 200,
              child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Container(
                          child: Column(
                            children: [
                              Text(events[i].name),
                              Text(events[i].trainerName),
                              Text(DateTime.fromMillisecondsSinceEpoch(
                                      events[i].date)
                                  .toString()),
                            ],
                          ),
                        ),
                        onTap: () {
                          events[i].reference.updateData({
                            'available': false,
                            'studentName': currentStudent.firstName +
                                ' ' +
                                currentStudent.lastName
                          });
                          addToUserPrivateSessions(events[i]);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    }
  }

  addToUserPrivateSessions(PrivateSession session) async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userSnapshot = await Firestore.instance
        .collection('students')
        .document(currentUser.uid)
        .get();
    Student student = Student.fromSnapshot(userSnapshot);
    session.available = false;
    session.studentName = student.firstName + ' ' + student.lastName;
    student.reference.collection('privateSessions').add(session.toJson());
  }
}
