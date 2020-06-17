import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
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
  CalendarController _calendarController;
  List<PrivateSession> privateSessionTimes;
  DateTime selectedDate;
  List<dynamic> events;

  @override
  void initState() {
    events = new List<PrivateSession>();
    _calendarController = new CalendarController();
    getAvailablePrivateSessionTimes();
    super.initState();
  }

  void dispose() {
    _calendarController.dispose();
    super.dispose();
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
              events: getAvailableTimes(),
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
                    return GestureDetector(
                      child: Container(
                        child: Column(
                          children: [
                            Text(events[i].name),
                            Text(events[i].trainerName),
                            Text(events[i].date.toDate().toString()),
                          ],
                        ),
                      ),
                      onTap: () {
                        events[i].reference.updateData({'available': false});
                        addToUserPrivateSessions(events[i]);
                        Navigator.pop(context);
                      },
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
    session.available = false;
    Firestore.instance
        .collection('students')
        .document(currentUser.uid)
        .collection('privateSessions')
        .add(session.toJson());
  }

  Map<DateTime, List<PrivateSession>> getAvailableTimes() {
    Map<DateTime, List<PrivateSession>> allTimes =
        new Map<DateTime, List<PrivateSession>>();

    for (int i = 0; i < privateSessionTimes.length; i++) {
      PrivateSession privateSession = privateSessionTimes[i];
      DateTime privateSessionDate = privateSession.date.toDate().toLocal();
      if (allTimes.containsKey(privateSessionDate)) {
        allTimes[privateSessionDate].add(privateSession);
      } else {
        List<PrivateSession> privateSessionsList = new List<PrivateSession>();
        privateSessionsList.add(privateSession);
        allTimes[privateSessionDate] = privateSessionsList;
      }
    }

    return allTimes;
  }
}
