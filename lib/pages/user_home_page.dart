import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:fitnessmarketplace/models/Student.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  Student currentStudent;
  List<PrivateSession> privateSessions;
  List<RecordedVideo> recordedVideos;

  CalendarController _calendarController;

  @override
  void initState() {
    _calendarController = CalendarController();
    getCurrentStudent();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void getCurrentStudent() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance
        .collection('students')
        .document(getUser.uid)
        .get();
    currentStudent = Student.fromSnapshot(userData);
    await getPrivateSessions();
    await getRecordedVideos();
    setState(() {});
  }

  Future<void> getPrivateSessions() async {
    privateSessions = new List<PrivateSession>();
    QuerySnapshot allPrivateSessions = await currentStudent.reference.collection('privateSessions').getDocuments();
    List<DocumentSnapshot> holdPrivateSessions = allPrivateSessions.documents;
    for (int i = 0; i < holdPrivateSessions.length; i++) {
      PrivateSession currentPrivateSession = PrivateSession.fromSnapshot(holdPrivateSessions[i]);
      privateSessions.add(currentPrivateSession);
    }
    return;
  }

  Future<void> getRecordedVideos() async {
    recordedVideos = new List<RecordedVideo>();
    QuerySnapshot allRecordedVideos = await currentStudent.reference.collection('videos').getDocuments();
    List<DocumentSnapshot> videos = allRecordedVideos.documents;
    for (int i = 0; i < videos.length; i++) {
      RecordedVideo currentVideo = RecordedVideo.fromSnapshot(videos[i]);
      recordedVideos.add(currentVideo);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    if (currentStudent == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text(
                        'Student: ' + currentStudent.firstName,
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        onPressed: () {},
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(
                  height: 10.0,
                  thickness: 0.75,
                ),
              ),
              Container(child: _buildCalendar()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(
                  height: 10.0,
                  thickness: 0.75,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Upcoming Sessions',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),

                
              ),
              Container(
                height: 250.0,
                child: ListView.builder(
                  itemCount: privateSessions.length,
                  itemBuilder: (BuildContext context, int i) {
                    DateTime privateSessionDate = privateSessions[i].date.toDate();
                    DateTime localPrivateSessionDate = privateSessionDate.toLocal();
                    String privateSessionDateString = getDateStringFromDateTime(localPrivateSessionDate);
                    String privateSessionTimeString = getTimeStringFromDateTime(localPrivateSessionDate);
                    String privateSessionLengthString = getLengthFromInt(privateSessions[i].length);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xff3B3B3B),
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
                                Text(
                                  privateSessions[i].name +
                                      " | " +
                                      privateSessions[i].trainerName,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  privateSessionLengthString,
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
                                  privateSessionDateString,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  privateSessionTimeString,
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
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.symmetric(
                      vertical: BorderSide(width: 0.5, color: Colors.black26),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Text(
                              'Your Videos',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              'See All',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black26),
                            ),
                          ],
                        )),
                    Container(
                      color: Colors.white,
                      height: 300.0,
                      child: ListView.builder(
                        itemCount: recordedVideos.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int i) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              child: Container(
                                  height: 300.0,
                                  width: 300.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.blue,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(recordedVideos[i].name + ' ' + Timestamp.fromMillisecondsSinceEpoch(recordedVideos[i].date).toDate().toString()),
                                  )
                              ),
                              //TODO set up this so that it works with actual videos / streams
                              /*onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ShowVideoPage(videoDownloadUrl: recordedVideos[i].videoUrl,)),
                                );
                              },*/
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget _buildCalendar() {
    return Container(
      //color: Color(0xff465466),
      //color: Colors.white,
      child: TableCalendar(
        rowHeight: 40.0,
        //onDaySelected: _onDaySelected,
        locale: 'en_US',
        //events: _selectedDay,
        calendarController: _calendarController,
        initialCalendarFormat: CalendarFormat.month,
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.horizontalSwipe,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        calendarStyle: CalendarStyle(
          weekdayStyle: TextStyle(color: Colors.black),
          weekendStyle: TextStyle(color: Colors.red),
          outsideStyle: TextStyle(color: Colors.grey),
          unavailableStyle: TextStyle(color: Colors.grey),
          outsideWeekendStyle: TextStyle(color: Colors.grey),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextBuilder: (date, locale) {
            return DateFormat.E(locale)
                .format(date)
                .substring(0, 3)
                .toUpperCase();
          },
          weekdayStyle: TextStyle(color: Colors.grey),
          weekendStyle: TextStyle(color: Colors.grey),
        ),
        headerVisible: true,
        headerStyle: HeaderStyle(
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        builders: CalendarBuilders(
          markersBuilder: (context, date, events, holidays) {
            return [
              Container(
                decoration: new BoxDecoration(
                  color: Color(0xFF30A9B2),
                  //color: Color(C),
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.all(4.0),
                width: 4,
                height: 4,
              )
            ];
          },
          selectedDayBuilder: (context, date, _) {
            return Container(
              decoration: new BoxDecoration(
                color: Color(0xFF30A9B2),
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.all(4.0),
              width: 100,
              height: 100,
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  getDateStringFromDateTime(DateTime time) {
    return months[time.month] + ' ' + time.day.toString();
  }

  getTimeStringFromDateTime(DateTime time) {
    if (time.hour > 12) {
      return (time.hour - 12).toString() +  ':' + time.minute.toString() + ' p.m.';
    }
    else {
      if (time.hour == 0) {
        return '12:' + time.minute.toString() + 'a.m.';
      }
      return time.hour.toString() + ':' + time.minute.toString() + ' a.m.';
    }
  }

  getLengthFromInt(int length) {
    String duration = '';
    if (length > 60) {
      duration = duration + (length ~/ 60).toString() + ' hours ';
    }
    duration = duration + (length % 60).toString() + ' minutes';
    return duration;
  }
}
